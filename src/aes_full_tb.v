/**
 * File: aes_full_tb.v
 *
 * Contains the testbench for testing full AES encryption
 * for extra credit.
 *
 * input: in.txt
 * output: out.txt
 *
 * input file format:
 * <encryption flag>
 * <plain text>
 * <cipher text> 
 */

`include "constants.v"
`include "hex.v"
`include "sbox.v"

module vtc_encryption_tb();

    integer iterator = 0;

    reg[`BYTE] buffer;
    integer in_file;
    integer out_file;

    reg[`BYTE] plaintext_str[`NIBBLE_BLOCK];
    reg[`BYTE] key_str[`NIBBLE_BLOCK];

    reg is_part_a;
    reg[`BYTE] plaintext[`ROW][`COL];
    reg[`BYTE] key_0[`ROW][`COL];

    // used for column mixing
    reg[`BYTE] z[`ROW];

    // used for key generation
    reg[`BYTE] key[`ROUNDS][`ROW][`COL];
    reg[`BYTE] g[`COL];
    reg[`BYTE] rc[`ROUNDS];

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // determine whether part a or part b is being tested
        is_part_a = (8'h30 != $fgetc(in_file));

        // get the key
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_NIBBLE_SIZE > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            key_str[i] = buffer[`BYTE];
        end

        // get the plaintext
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_NIBBLE_SIZE > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            plaintext_str[i] = buffer[`BYTE];
        end

        // place key into 4x4 byte table
        iterator = 0;
        for (integer i = 0; `COL_SIZE > i; i++) begin
            for (integer j = 0; `ROW_SIZE > j; j++) begin
                buffer[7:4] = ascii_to_hex(key_str[iterator++]);
                buffer[3:0] = ascii_to_hex(key_str[iterator++]);
                key_0[j][i] = buffer;
            end
        end

        // place plaintext into 4x4 byte table
        iterator = 0;
        for (integer i = 0; `COL_SIZE > i; i++) begin
            for (integer j = 0; `ROW_SIZE > j; j++) begin
                buffer[7:4] = ascii_to_hex(plaintext_str[iterator++]);
                buffer[3:0] = ascii_to_hex(plaintext_str[iterator++]);
                plaintext[j][i] = buffer;
            end
        end

//****************************************************************************************** AES BEGIN


//////////////////////////////////////////////////////////////////////////////////////////// KEY GENERATION

        // set RC values
        rc[0] = 8'b00000000;
        rc[1] = 8'b00000001;
        rc[2] = 8'b00000010;
        rc[3] = 8'b00000100;
        rc[4] = 8'b00001000;
        rc[5] = 8'b00010000;
        rc[6] = 8'b00100000;
        rc[7] = 8'b01000000;
        rc[8] = 8'b10000000;
        if (1'h1 == is_part_a) begin
            rc[9] = 8'b00011011;
            rc[10] = 8'b00110110;
        end
        else begin
            rc[9] = 8'b10101010;
            rc[10] = 8'b11111110;
        end

        // place the zeroeth key into w
        for (integer i = 0; `COL_SIZE > i; i++) begin
            for (integer j = 0; `ROW_SIZE > j; j++) begin
                key[0][j][i] = key_0[j][i];
            end
        end

        for (integer rnd = 1; `NUM_ROUNDS > rnd; rnd++) begin

            // calculate g
            g[0] = byte_xor_byte(sbox(key[rnd-1][1][3]), rc[rnd]);
            g[1] = sbox(key[rnd-1][2][3]);
            g[2] = sbox(key[rnd-1][3][3]);
            g[3] = sbox(key[rnd-1][0][3]);

            // calculate w4
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                key[rnd][i][0] = byte_xor_byte(g[i], key[rnd-1][i][0]);
            end

            // calculate w5
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                key[rnd][i][1] = byte_xor_byte(key[rnd][i][0], key[rnd-1][i][1]);
            end

            // calculate w6
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                key[rnd][i][2] = byte_xor_byte(key[rnd][i][1], key[rnd-1][i][2]);
            end

            // calculate w7
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                key[rnd][i][3] = byte_xor_byte(key[rnd][i][2], key[rnd-1][i][3]);
            end
            
        end

//////////////////////////////////////////////////////////////////////////////////////////// ROUND 0

        // perform AES key XOR
        for (integer i = 0; `ROW_SIZE > i; i++) begin
            for (integer j = 0; `COL_SIZE > j; j++) begin
                plaintext[i][j] = byte_xor_byte(plaintext[i][j], key[0][i][j]);
            end
        end  

//////////////////////////////////////////////////////////////////////////////////////////// ROUNDS 1 - 9

        for (integer rnd = 1; `NUM_ROUNDS - 1 > rnd; rnd++) begin

            // perform sbox conversion
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                for (integer j = 0; `COL_SIZE > j; j++) begin
                    plaintext[i][j] = sbox(plaintext[i][j]);
                end
            end

            // perform an AES row shift
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                for (integer j = 0; j < i; j++) begin
                    buffer = plaintext[i][0];
                    plaintext[i][0] = plaintext[i][1];
                    plaintext[i][1] = plaintext[i][2];
                    plaintext[i][2] = plaintext[i][3];
                    plaintext[i][3] = buffer;
                end
            end

            // perform AES column mix
            for (integer i = 0; `COL_SIZE > i; i++) begin

                // save column into z
                for (integer j = 0; `ROW_SIZE > j; j++) begin
                    z[j] = plaintext[j][i];
                end

                // calculate u0
                plaintext[0][i] = byte_mult_byte_a(is_part_a, z[0], 2); 
                plaintext[0][i] = byte_xor_byte(plaintext[0][i], byte_mult_byte_a(is_part_a, z[1], 3)); 
                plaintext[0][i] = byte_xor_byte(plaintext[0][i], z[2]); 
                plaintext[0][i] = byte_xor_byte(plaintext[0][i], z[3]);

                // calculate u1
                plaintext[1][i] = z[0];
                plaintext[1][i] = byte_xor_byte(plaintext[1][i], byte_mult_byte_a(is_part_a, z[1], 2));
                plaintext[1][i] = byte_xor_byte(plaintext[1][i], byte_mult_byte_a(is_part_a, z[2], 3));
                plaintext[1][i] = byte_xor_byte(plaintext[1][i], z[3]);

                // calculate u2
                plaintext[2][i] = z[0]; 
                plaintext[2][i] = byte_xor_byte(plaintext[2][i], z[1]);
                plaintext[2][i] = byte_xor_byte(plaintext[2][i], byte_mult_byte_a(is_part_a, z[2], 2));
                plaintext[2][i] = byte_xor_byte(plaintext[2][i], byte_mult_byte_a(is_part_a, z[3], 3));

                // calculate u3
                plaintext[3][i] = byte_mult_byte_a(is_part_a, z[0], 3);
                plaintext[3][i] = byte_xor_byte(plaintext[3][i], z[1]); 
                plaintext[3][i] = byte_xor_byte(plaintext[3][i], z[2]);
                plaintext[3][i] = byte_xor_byte(plaintext[3][i], byte_mult_byte_a(is_part_a, z[3], 2));

            end

            // perform AES key XOR
            for (integer i = 0; `ROW_SIZE > i; i++) begin
                for (integer j = 0; `COL_SIZE > j; j++) begin
                    plaintext[i][j] = byte_xor_byte(plaintext[i][j], key[rnd][i][j]);
                end
            end
        end   

//////////////////////////////////////////////////////////////////////////////////////////// ROUND 10

    // perform sbox conversion
    for (integer i = 0; `ROW_SIZE > i; i++) begin
        for (integer j = 0; `COL_SIZE > j; j++) begin
            plaintext[i][j] = sbox(plaintext[i][j]);
        end
    end

    // perform an AES row shift
    for (integer i = 0; `ROW_SIZE > i; i++) begin
        for (integer j = 0; j < i; j++) begin
            buffer = plaintext[i][0];
            plaintext[i][0] = plaintext[i][1];
            plaintext[i][1] = plaintext[i][2];
            plaintext[i][2] = plaintext[i][3];
            plaintext[i][3] = buffer;
        end
    end

    // perform AES key XOR
    for (integer i = 0; `ROW_SIZE > i; i++) begin
        for (integer j = 0; `COL_SIZE > j; j++) begin
            plaintext[i][j] = byte_xor_byte(plaintext[i][j], key[10][i][j]);
        end
    end


//****************************************************************************************** AES END

        // write result to output file
        for (integer i = 0; `COL_SIZE > i; i++) begin
            for (integer j = 0; `ROW_SIZE > j; j++) begin
                 $fwrite(out_file, "%x", plaintext[j][i]);
            end
        end

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule
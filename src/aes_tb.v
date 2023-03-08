/**
 * File: aes_a_tb.v
 *
 * Contains the testbench for testing AES encryption and decryption
 * for Part A.
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
    reg[`BYTE] key[`ROW][`ROW];
    reg[`BYTE] rc;

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



//////////////////////////////////////////////////////////////////////////////////////////// ROUND 9

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
            plaintext[0][i] = byte_mult_byte_a(z[0], 2); 
            plaintext[0][i] = byte_xor_byte(plaintext[0][i], byte_mult_byte_a(z[1], 3)); 
            plaintext[0][i] = byte_xor_byte(plaintext[0][i], z[2]); 
            plaintext[0][i] = byte_xor_byte(plaintext[0][i], z[3]);

            // calculate u1
            plaintext[1][i] = z[0];
            plaintext[1][i] = byte_xor_byte(plaintext[1][i], byte_mult_byte_a(z[1], 2));
            plaintext[1][i] = byte_xor_byte(plaintext[1][i], byte_mult_byte_a(z[2], 3));
            plaintext[1][i] = byte_xor_byte(plaintext[1][i], z[3]);

            // calculate u2
            plaintext[2][i] = z[0]; 
            plaintext[2][i] = byte_xor_byte(plaintext[2][i], z[1]);
            plaintext[2][i] = byte_xor_byte(plaintext[2][i], byte_mult_byte_a(z[2], 2));
            plaintext[2][i] = byte_xor_byte(plaintext[2][i], byte_mult_byte_a(z[3], 3));

            // calculate u3
            plaintext[3][i] = byte_mult_byte_a(z[0], 3);
            plaintext[3][i] = byte_xor_byte(plaintext[3][i], z[1]); 
            plaintext[3][i] = byte_xor_byte(plaintext[3][i], z[2]);
            plaintext[3][i] = byte_xor_byte(plaintext[3][i], byte_mult_byte_a(z[3], 2));

        end

        // perform AES key XOR

//////////////////////////////////////////////////////////////////////////////////////////// ROUND 10


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
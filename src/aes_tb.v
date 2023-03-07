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
    reg[`BYTE] key[`ROW][`COL];

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
                key[j][i] = buffer;
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

////////////////////////////////////////////////////////////////////////////////// encryption begins        

        // write out the plaintext before shift
        for (integer i = 0; `ROW_SIZE > i; i++) begin
            for (integer j = 0; `COL_SIZE > j; j++) begin
                $write("%x ", plaintext[i][j]);
            end
            $write("\n");
        end
        $write("\n");
        $write("\n");

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

        // write out the plaintext after shift
        for (integer i = 0; `ROW_SIZE > i; i++) begin
            for (integer j = 0; `COL_SIZE > j; j++) begin
                $write("%x ", plaintext[i][j]);
            end
            $write("\n");
        end
        $write("\n");
        $write("\n");

        // write out the plaintext with sbox values
        for (integer i = 0; `ROW_SIZE > i; i++) begin
            for (integer j = 0; `COL_SIZE > j; j++) begin
                $write("%x ", sbox(plaintext[i][j]));
            end
            $write("\n");
        end
        $write("\n");
        $write("\n");

        $display("%x", byte_mult_byte_a(8'hff, 2));

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule
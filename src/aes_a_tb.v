/**
 * File: vtc_encryption_tb.v
 *
 * Contains the testbench for testing Vigenere Tableux Cipher
 * encryption and decryption. 
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

module vtc_encryption_tb();

    reg[`BYTE] buffer;
    integer in_file;
    integer out_file;

    reg encrypt_flag;
    reg[`BYTE] plaintext_str[`BLOCK];
    reg[`BYTE] key_str[`BLOCK];

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // determine whether to encrypt or decrypt
        encrypt_flag = (8'h30 != $fgetc(in_file));

        // get the key
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_BYTE_LEN > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            key_str[i] = buffer[`BYTE];
        end

        // get the plaintext
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_BYTE_LEN > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            plaintext_str[i] = buffer[`BYTE];
        end

        // printout encryption flag
        $display("%d", encrypt_flag);

        // printout key
        for (integer i = 0; `BLOCK_BYTE_LEN > i; i++) begin
            $write("%c", key_str[i]);
        end
        $write("\n");

        // printout plaintext
        for (integer i = 0; `BLOCK_BYTE_LEN > i; i++) begin
            $write("%c", plaintext_str[i]);
        end
        $write("\n");

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule
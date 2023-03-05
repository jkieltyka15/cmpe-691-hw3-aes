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
`include "aes.v"

module vtc_encryption_tb();

    reg[`BYTE] buffer;
    integer in_file;
    integer out_file;

    reg encrypt_flag;
    reg[`BYTE] plaintext_str[`BIT_BLOCK];
    reg[`BYTE] key_str[`BIT_BLOCK];
    reg[`BYTE] plaintext[`BYTE_BLOCK];
    reg[`BYTE] key[`BYTE_BLOCK];

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // determine whether to encrypt or decrypt
        encrypt_flag = (8'h30 != $fgetc(in_file));

        // get the key
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_BIT_SIZE > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            key_str[i] = buffer[`BYTE];
        end

        // get the plaintext
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `BLOCK_BIT_SIZE > i; i++) begin
            buffer[`BYTE] = $fgetc(in_file);
            plaintext_str[i] = buffer[`BYTE];
        end

        // test xor
        $display("%b", byte_xor_byte(8'hff, 8'h00));
        $display("%b", byte_xor_byte(8'h0f, 8'hf0));
        $display("%b", byte_xor_byte(8'hff, 8'hff));
        $display("%b", byte_xor_byte(8'h1, 8'h6));
        $display("%b", byte_xor_byte(8'h1, 8'h7));

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule
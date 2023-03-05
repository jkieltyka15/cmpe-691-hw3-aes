/**
 * File: aes.v
 *
 * Contains functions used for AES encryption and decryption.
 */

`ifndef _AES_V_
`define _AES_V_

`include "constants.v"

/**
 * Converts an ASCII character to its hex value as a nibble.
 * 
 * @param ascii - The character to convert to a hex value.
 * 
 * @return Hex value in the form of a nibble.
 */
function reg[`NIBBLE] ascii_to_hex(input reg[`BYTE] ascii);
    begin
        reg[`BYTE] hex;
        case(ascii)
            "f" : hex[`NIBBLE] = 4'hf;
            "e" : hex[`NIBBLE] = 4'he;
            "d" : hex[`NIBBLE] = 4'hd;
            "c" : hex[`NIBBLE] = 4'hc;
            "b" : hex[`NIBBLE] = 4'hb;
            "a" : hex[`NIBBLE] = 4'ha;
            "9" : hex[`NIBBLE] = 4'h9;
            "8" : hex[`NIBBLE] = 4'h8;
            "7" : hex[`NIBBLE] = 4'h7;
            "6" : hex[`NIBBLE] = 4'h6;
            "5" : hex[`NIBBLE] = 4'h5;
            "4" : hex[`NIBBLE] = 4'h4;
            "3" : hex[`NIBBLE] = 4'h3;
            "2" : hex[`NIBBLE] = 4'h2;
            "1" : hex[`NIBBLE] = 4'h1;
            default : hex[`NIBBLE] = 4'h0;
        endcase

        return hex;

    end
endfunction


`endif // _AES_V_
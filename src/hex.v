/**
 * File: hex.v
 *
 * Contains functions used for hex number operations.
 */

`ifndef _HEX_V_
`define _HEX_V_

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

/**
 * Perform an XOR when both operatees are one byte.
 * 
 * @param byte_a - The first operatee of the XOR.
 * @param byte_b - The second operatee of the XOR. 
 *
 * @return The result of byte_a XOR byte_b.
 */
function reg[`BYTE] byte_xor_byte(input reg[`BYTE] byte_a, input reg[`BYTE] byte_b);
    begin

        reg[`BYTE] result;

        for (integer i = 0; `BYTE_SIZE > i; i++) begin
            result[i] = byte_a[i] ^ byte_b[i];
        end

        return result;

    end
endfunction


`endif // _HEX_V_
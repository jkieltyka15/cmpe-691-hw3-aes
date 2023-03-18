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
        reg[`NIBBLE] hex;
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

/**
 * Perform multiplication on two bytes.

 * @param byte_a - The first factor.
 * @param byte_b - The second factor that is no greater than 3.
 *
 * @return The result of byte_a multiplied by byte_b.
 */
function reg[`BYTE] byte_mult_byte(input reg[`BYTE] byte_a, input reg[`BYTE] byte_b);
    begin
        reg[`BYTE] result;
        if (byte_b >= 10'h002) begin
            result = byte_a * 10'h002;
        end
        if (byte_b == 10'h003) begin
            result = byte_xor_byte(result, byte_a);
        end
        else begin
            result = byte_a * byte_b;
        end
        
        return result;
    end
endfunction

function reg[`BYTE] ip_op(input reg ip_sel, input reg[`BYTE] byte_a);
    begin
        reg[`BYTE] result;

        if (1'h1 == byte_a[8]) begin
            if (1'h1 == ip_sel) begin
                result = byte_xor_byte(byte_a, 10'b0100011011);
            end
            else begin
                result = byte_xor_byte(byte_a, 10'b0110101001);
            end
        end
        else if (1'h1 == byte_a[9]) begin
            if (1'h1 == ip_sel) begin
                result = byte_xor_byte(byte_a, 10'b1000110110);
            end
            else begin
                result = byte_xor_byte(byte_a, 10'b1001010010);
            end
        end
        else begin
            result = byte_a;    
        end

        return result;
    end
endfunction


`endif // _HEX_V_
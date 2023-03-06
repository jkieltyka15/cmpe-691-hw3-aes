/**
 * File: sbox.v
 *
 * Contains the implementation of AES's S-Box.
 */

// XX 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
// 00 63 7c 77 7b f2 6b 6f c5 30 01 67 2b fe d7 ab 76
// 10 ca 82 c9 7d fa 59 47 f0 ad d4 a2 af 9c a4 72 c0
// 20 b7 fd 93 26 36 3f f7 cc 34 a5 e5 f1 71 d8 31 15
// 30 04 c7 23 c3 18 96 05 9a 07 12 80 e2 eb 27 b2 75
// 40 09 83 2c 1a 1b 6e 5a a0 52 3b d6 b3 29 e3 2f 84
// 50 53 d1 00 ed 20 fc b1 5b 6a cb be 39 4a 4c 58 cf
// 60 d0 ef aa fb 43 4d 33 85 45 f9 02 7f 50 3c 9f a8
// 70 51 a3 40 8f 92 9d 38 f5 bc b6 da 21 10 ff f3 d2
// 80 cd 0c 13 ec 5f 97 44 17 c4 a7 7e 3d 64 5d 19 73
// 90 60 81 4f dc 22 2a 90 88 46 ee b8 14 de 5e 0b db
// a0 e0 32 3a 0a 49 06 24 5c c2 d3 ac 62 91 95 e4 79
// b0 e7 c8 37 6d 8d d5 4e a9 6c 56 f4 ea 65 7a ae 08
// c0 ba 78 25 2e 1c a6 b4 c6 e8 dd 74 1f 4b bd 8b 8a
// d0 70 3e b5 66 48 03 f6 0e 61 35 57 b9 86 c1 1d 9e
// e0 e1 f8 98 11 69 d9 8e 94 9b 1e 87 e9 ce 55 28 df
// f0 8c a1 89 0d bf e6 42 68 41 99 2d 0f b0 54 bb 16

`ifndef _SBOX_V_
`define _SBOX_V_

`include "constants.v"

/**
 * Performs the sbox function for AES.
 * 
 * @param value - The value for the sbox to convert.
 *
 * @return The result of the sbox conversion.
 */
function reg[`BYTE] sbox(input reg[`BYTE] value);
    begin

        reg[`BYTE] sbox_value;

        case(value)

            8'h00 : sbox_value = 8'h63;
            8'h01 : sbox_value = 8'h7c;
            8'h02 : sbox_value = 8'h77;
            8'h03 : sbox_value = 8'h7b;
            8'h04 : sbox_value = 8'hf2;
            8'h05 : sbox_value = 8'h6b;
            8'h06 : sbox_value = 8'hf6;
            8'h07 : sbox_value = 8'hc5;
            8'h08 : sbox_value = 8'h30;
            8'h09 : sbox_value = 8'h01;
            8'h0a : sbox_value = 8'h67;
            8'h0b : sbox_value = 8'h2b;
            8'h0c : sbox_value = 8'hfe;
            8'h0d : sbox_value = 8'hd7;
            8'h0e : sbox_value = 8'hab;
            8'h0f : sbox_value = 8'h76;

            8'h10 : sbox_value = 8'hca;
            8'h11 : sbox_value = 8'h82;
            8'h12 : sbox_value = 8'hc9;
            8'h13 : sbox_value = 8'h7d;
            8'h14 : sbox_value = 8'hfa;
            8'h15 : sbox_value = 8'h59;
            8'h16 : sbox_value = 8'h47;
            8'h17 : sbox_value = 8'hf0;
            8'h18 : sbox_value = 8'had;
            8'h19 : sbox_value = 8'hd4;
            8'h1a : sbox_value = 8'ha2;
            8'h1b : sbox_value = 8'haf;
            8'h1c : sbox_value = 8'h9c;
            8'h1d : sbox_value = 8'ha4;
            8'h1e : sbox_value = 8'h72;
            8'h1f : sbox_value = 8'hc0;

            8'h20 : sbox_value = 8'hb7;
            8'h21 : sbox_value = 8'hfd;
            8'h22 : sbox_value = 8'h93;
            8'h23 : sbox_value = 8'h26;
            8'h24 : sbox_value = 8'h36;
            8'h25 : sbox_value = 8'h3f;
            8'h26 : sbox_value = 8'hf7;
            8'h27 : sbox_value = 8'hcc;
            8'h28 : sbox_value = 8'h34;
            8'h29 : sbox_value = 8'ha5;
            8'h2a : sbox_value = 8'he5;
            8'h2b : sbox_value = 8'hf1;
            8'h2c : sbox_value = 8'h71;
            8'h2d : sbox_value = 8'hd8;
            8'h2e : sbox_value = 8'h31;
            8'h2f : sbox_value = 8'h15;

            8'h30 : sbox_value = 8'h04;
            8'h31 : sbox_value = 8'hc7;
            8'h32 : sbox_value = 8'h23;
            8'h33 : sbox_value = 8'hc3;
            8'h34 : sbox_value = 8'h18;
            8'h35 : sbox_value = 8'h96;
            8'h36 : sbox_value = 8'h05;
            8'h37 : sbox_value = 8'h9a;
            8'h38 : sbox_value = 8'h07;
            8'h39 : sbox_value = 8'h12;
            8'h3a : sbox_value = 8'h80;
            8'h3b : sbox_value = 8'he2;
            8'h3c : sbox_value = 8'heb;
            8'h3d : sbox_value = 8'h27;
            8'h3e : sbox_value = 8'hb2;
            8'h3f : sbox_value = 8'h75;

            8'h40 : sbox_value = 8'h09;
            8'h41 : sbox_value = 8'h83;
            8'h42 : sbox_value = 8'h2c;
            8'h43 : sbox_value = 8'h1a;
            8'h44 : sbox_value = 8'h1b;
            8'h45 : sbox_value = 8'h6e;
            8'h46 : sbox_value = 8'h5a;
            8'h47 : sbox_value = 8'ha0;
            8'h48 : sbox_value = 8'h52;
            8'h49 : sbox_value = 8'h3b;
            8'h4a : sbox_value = 8'hd6;
            8'h4b : sbox_value = 8'hb3;
            8'h4c : sbox_value = 8'h29;
            8'h4d : sbox_value = 8'he3;
            8'h4e : sbox_value = 8'h2f;
            8'h4f : sbox_value = 8'h84;

            8'h50 : sbox_value = 8'h53;
            8'h51 : sbox_value = 8'hd1;
            8'h52 : sbox_value = 8'h00;
            8'h53 : sbox_value = 8'hed;
            8'h54 : sbox_value = 8'h20;
            8'h55 : sbox_value = 8'hfc;
            8'h56 : sbox_value = 8'hb1;
            8'h57 : sbox_value = 8'hb5;
            8'h58 : sbox_value = 8'h6a;
            8'h59 : sbox_value = 8'hcb;
            8'h5a : sbox_value = 8'hbe;
            8'h5b : sbox_value = 8'h39;
            8'h5c : sbox_value = 8'h4a;
            8'h5d : sbox_value = 8'h4c;
            8'h5e : sbox_value = 8'h58;
            8'h5f : sbox_value = 8'hcf;

            8'h60 : sbox_value = 8'hd0;
            8'h61 : sbox_value = 8'hef;
            8'h62 : sbox_value = 8'haa;
            8'h63 : sbox_value = 8'hfb;
            8'h64 : sbox_value = 8'h43;
            8'h65 : sbox_value = 8'h4d;
            8'h66 : sbox_value = 8'h33;
            8'h67 : sbox_value = 8'h85;
            8'h68 : sbox_value = 8'h45;
            8'h69 : sbox_value = 8'hf9;
            8'h6a : sbox_value = 8'h02;
            8'h6b : sbox_value = 8'h7f;
            8'h6c : sbox_value = 8'h50;
            8'h6d : sbox_value = 8'h3c;
            8'h6e : sbox_value = 8'h9f;
            8'h6f : sbox_value = 8'ha8;

            8'h70 : sbox_value = 8'h51;
            8'h71 : sbox_value = 8'ha3;
            8'h72 : sbox_value = 8'h40;
            8'h73 : sbox_value = 8'h8f;
            8'h74 : sbox_value = 8'h92;
            8'h75 : sbox_value = 8'h9d;
            8'h76 : sbox_value = 8'h38;
            8'h77 : sbox_value = 8'hf5;
            8'h78 : sbox_value = 8'hbc;
            8'h79 : sbox_value = 8'hb6;
            8'h7a : sbox_value = 8'hda;
            8'h7b : sbox_value = 8'h21;
            8'h7c : sbox_value = 8'h10;
            8'h7d : sbox_value = 8'hff;
            8'h7e : sbox_value = 8'hf3;
            8'h7f : sbox_value = 8'hd2;

            8'h80 : sbox_value = 8'hcd;
            8'h81 : sbox_value = 8'h0c;
            8'h82 : sbox_value = 8'h13;
            8'h83 : sbox_value = 8'hec;
            8'h84 : sbox_value = 8'h5f;
            8'h85 : sbox_value = 8'h97;
            8'h86 : sbox_value = 8'h44;
            8'h87 : sbox_value = 8'h17;
            8'h88 : sbox_value = 8'hc4;
            8'h89 : sbox_value = 8'ha7;
            8'h8a : sbox_value = 8'h7e;
            8'h8b : sbox_value = 8'h3d;
            8'h8c : sbox_value = 8'h64;
            8'h8d : sbox_value = 8'h5d;
            8'h8e : sbox_value = 8'h19;
            8'h8f : sbox_value = 8'h73;

            8'h90 : sbox_value = 8'h60;
            8'h91 : sbox_value = 8'h81;
            8'h92 : sbox_value = 8'h4f;
            8'h93 : sbox_value = 8'hdc;
            8'h94 : sbox_value = 8'h22;
            8'h95 : sbox_value = 8'h2a;
            8'h96 : sbox_value = 8'h90;
            8'h97 : sbox_value = 8'h88;
            8'h98 : sbox_value = 8'h46;
            8'h99 : sbox_value = 8'hee;
            8'h9a : sbox_value = 8'hb8;
            8'h9b : sbox_value = 8'h14;
            8'h9c : sbox_value = 8'hde;
            8'h9d : sbox_value = 8'h5e;
            8'h9e : sbox_value = 8'h0b;
            8'h9f : sbox_value = 8'hdb;

            8'ha0 : sbox_value = 8'he0;
            8'ha1 : sbox_value = 8'h32;
            8'ha2 : sbox_value = 8'h3a;
            8'ha3 : sbox_value = 8'h0a;
            8'ha4 : sbox_value = 8'h49;
            8'ha5 : sbox_value = 8'h06;
            8'ha6 : sbox_value = 8'h24;
            8'ha7 : sbox_value = 8'h5c;
            8'ha8 : sbox_value = 8'hc2;
            8'ha9 : sbox_value = 8'hd3;
            8'haa : sbox_value = 8'hac;
            8'hab : sbox_value = 8'h62;
            8'hac : sbox_value = 8'h91;
            8'had : sbox_value = 8'h95;
            8'hae : sbox_value = 8'he4;
            8'haf : sbox_value = 8'h79;

            8'hb0 : sbox_value = 8'he7;
            8'hb1 : sbox_value = 8'hc8;
            8'hb2 : sbox_value = 8'h37;
            8'hb3 : sbox_value = 8'h6d;
            8'hb4 : sbox_value = 8'h8d;
            8'hb5 : sbox_value = 8'hd5;
            8'hb6 : sbox_value = 8'h4e;
            8'hb7 : sbox_value = 8'ha9;
            8'hb8 : sbox_value = 8'h6c;
            8'hb9 : sbox_value = 8'h56;
            8'hba : sbox_value = 8'hf4;
            8'hbb : sbox_value = 8'hea;
            8'hbc : sbox_value = 8'h65;
            8'hbd : sbox_value = 8'h7a;
            8'hbe : sbox_value = 8'hae;
            8'hbf : sbox_value = 8'h08;

            8'hc0 : sbox_value = 8'hba;
            8'hc1 : sbox_value = 8'h78;
            8'hc2 : sbox_value = 8'h25;
            8'hc3 : sbox_value = 8'h2e;
            8'hc4 : sbox_value = 8'h1c;
            8'hc5 : sbox_value = 8'ha6;
            8'hc6 : sbox_value = 8'hb4;
            8'hc7 : sbox_value = 8'hc6;
            8'hc8 : sbox_value = 8'he8;
            8'hc9 : sbox_value = 8'hdd;
            8'hca : sbox_value = 8'h74;
            8'hcb : sbox_value = 8'h1f;
            8'hcc : sbox_value = 8'h4b;
            8'hcd : sbox_value = 8'hbd;
            8'hce : sbox_value = 8'h8b;
            8'hcf : sbox_value = 8'h8a;

            8'hd0 : sbox_value = 8'h70;
            8'hd1 : sbox_value = 8'h3e;
            8'hd2 : sbox_value = 8'hb5;
            8'hd3 : sbox_value = 8'h66;
            8'hd4 : sbox_value = 8'h48;
            8'hd5 : sbox_value = 8'h03;
            8'hd6 : sbox_value = 8'hf6;
            8'hd7 : sbox_value = 8'h0e;
            8'hd8 : sbox_value = 8'h61;
            8'hd9 : sbox_value = 8'h35;
            8'hda : sbox_value = 8'h57;
            8'hdb : sbox_value = 8'hb9;
            8'hdc : sbox_value = 8'h86;
            8'hdd : sbox_value = 8'hc1;
            8'hde : sbox_value = 8'h1d;
            8'hdf : sbox_value = 8'h9e;

            8'he0 : sbox_value = 8'he1;
            8'he1 : sbox_value = 8'hf8;
            8'he2 : sbox_value = 8'h98;
            8'he3 : sbox_value = 8'h11;
            8'he4 : sbox_value = 8'h69;
            8'he5 : sbox_value = 8'hd9;
            8'he6 : sbox_value = 8'h8e;
            8'he7 : sbox_value = 8'h94;
            8'he8 : sbox_value = 8'h9b;
            8'he9 : sbox_value = 8'h1e;
            8'hea : sbox_value = 8'h87;
            8'heb : sbox_value = 8'he9;
            8'hec : sbox_value = 8'hce;
            8'hed : sbox_value = 8'h55;
            8'hee : sbox_value = 8'h28;
            8'hef : sbox_value = 8'hdf;

            8'hf0 : sbox_value = 8'h8c;
            8'hf1 : sbox_value = 8'ha1;
            8'hf2 : sbox_value = 8'h89;
            8'hf3 : sbox_value = 8'h0d;
            8'hf4 : sbox_value = 8'hbf;
            8'hf5 : sbox_value = 8'he6;
            8'hf6 : sbox_value = 8'h42;
            8'hf7 : sbox_value = 8'h68;
            8'hf8 : sbox_value = 8'h41;
            8'hf9 : sbox_value = 8'h99;
            8'hfa : sbox_value = 8'h2d;
            8'hfb : sbox_value = 8'h0f;
            8'hfc : sbox_value = 8'hb0;
            8'hfd : sbox_value = 8'h54;
            8'hfe : sbox_value = 8'hbb;
            default : sbox_value = 8'h16;
        endcase

        return sbox_value;

    end
endfunction

`endif // _SBOX_V_
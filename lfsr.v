////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012, Ameer M. Abdelhadi; ameer@ece.ubc.ca. All rights reserved. //
//                                                                                //
// Redistribution  and  use  in  source   and  binary  forms,   with  or  without //
// modification,  are permitted  provided that  the following conditions are met: //
//   * Redistributions   of  source   code  must  retain   the   above  copyright //
//     notice,  this   list   of   conditions   and   the  following  disclaimer. //
//   * Redistributions  in  binary  form  must  reproduce  the  above   copyright //
//     notice, this  list  of  conditions  and the  following  disclaimer in  the //
//     documentation and/or  other  materials  provided  with  the  distribution. //
//   * Neither the name of the University of British Columbia (UBC) nor the names //
//     of   its   contributors  may  be  used  to  endorse  or   promote products //
//     derived from  this  software without  specific  prior  written permission. //
//                                                                                //
// THIS  SOFTWARE IS  PROVIDED  BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" //
// AND  ANY EXPRESS  OR IMPLIED WARRANTIES,  INCLUDING,  BUT NOT LIMITED TO,  THE //
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE //
// DISCLAIMED.  IN NO  EVENT SHALL University of British Columbia (UBC) BE LIABLE //
// FOR ANY DIRECT,  INDIRECT,  INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL //
// DAMAGES  (INCLUDING,  BUT NOT LIMITED TO,  PROCUREMENT OF  SUBSTITUTE GOODS OR //
// SERVICES;  LOSS OF USE,  DATA,  OR PROFITS;  OR BUSINESS INTERRUPTION) HOWEVER //
// CAUSED AND ON ANY THEORY OF LIABILITY,  WHETHER IN CONTRACT, STRICT LIABILITY, //
// OR TORT  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE //
// OF  THIS SOFTWARE,  EVEN  IF  ADVISED  OF  THE  POSSIBILITY  OF  SUCH  DAMAGE. //
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
//    lfsr.v: linear feedback shift register (LFSR); a periodic random counter    //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), June  2012 //
////////////////////////////////////////////////////////////////////////////////////

module lfsr
 #( parameter           WID = 16 ,  // integer: register width, up to 168.
    parameter           INI = 0  )  // int/str: loaded when ald is high. defaults is all 1s. limited to 32 bits.
  ( input               clk      ,  // input  clock
	 input               enb      ,  // clock enable
    input               rst      ,	// async load (loads initial number)
    output wire [WID:1] cnt      ); // output random count number

  // lfst feedback function
  wire fb;
  lfsr_fb      #( .WID(WID) )  // integer: register width, up to 168.
  lfsr_fb_inst  ( .cnt(cnt) ,  // input  clock
                  .fb (fb ) ); // output random count number

  lpm_shiftreg #(
    .LPM_WIDTH    (WID   ), // integer: width of the q ports.
    .LPM_DIRECTION("LEFT"), // string : values are "LEFT", "RIGHT", and or "UNUSED". If omitted, the default is "LEFT".
    .LPM_AVALUE   (INI   )  // int/str: loaded when aset is high. defaults is all 1s. limited to 32 bits.
  ) lfsr_reg (
    .clock  (clk), // positive-edge-triggered clock.
    .enable (enb), // clock enable input.
    .shiftin(fb ), // serial shift data input.
    .aset   (rst), // asynchronous set input (with LPM_AVALUE).
    .q      (cnt)  // data output from the shift register.
  );

endmodule

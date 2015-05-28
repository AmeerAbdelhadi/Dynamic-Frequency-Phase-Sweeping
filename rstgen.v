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
//                rstgen.v: reset generator, based on lfsr counter                //
//                                                                                //
//  Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), May 2012  //
////////////////////////////////////////////////////////////////////////////////////

`include "math.v"

module rstgen
 #( parameter WID = 16 )  // LOG2 reset cycles
  ( input     clk      ,  // input  clock
    input     rsti     ,  // input reset; pass 1'b0 if not required
    output    rsto     ); // output reset

  // lfsr count output
  reg [WID-1:0] cnt;

  // lfst feedback function
  wire fb;
  lfsr_fb      #( .WID(WID) )  // integer: register width, up to 168.
  lfsr_fb_inst  ( .cnt(cnt) ,  // input  clock
                  .fb (fb ) ); // output random count number

  localparam LASTCNT = {1'b1,{(WID-1){1'b0}}}; // last lfsr number before rolling back to all 0's
  wire       is_last = (cnt == LASTCNT)      ; // last lfsr number reached

  always @(posedge clk or posedge rsti)
    if      (rsti   ) cnt <= {WID{1'b0}}      ;
    else if (is_last) cnt <= LASTCNT          ;
	 else              cnt <= {cnt[WID-2:0],fb};

  reg is_last_rh;
  always @(posedge clk or posedge rsti)
    if (rsti) is_last_rh <= 1'b0   ;
    else      is_last_rh <= is_last;

  //reg is_last_rl;
  //always @(negedge clk or posedge rsti)
  //  if (rsti) is_last_rl <= 1'b0      ;
  //  else      is_last_rl <= is_last_rh;

  assign rsto = !is_last_rh;

endmodule

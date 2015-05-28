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
//  phasemeter.v: Clock phase meter using high freq. sampling clock and a counter //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module phasemeter
  ( input         clk_500,  // sampling clock, 500Mhz
    input         clk_ref,  // reference clock
    input         clk_phs,  // phase-shifted clock, same frequency as reference clock
	 output reg    phs_sgn,  // measured pahse shift / sign
    output [11:0] phs_bcd); // measured pahse shift / BCD {ones,tens,hundreds}
	 
  wire clk_ph1 = clk_ref && ~clk_phs;
  
  localparam cntW = 8;
  
  reg  [cntW-1:0] cntR, cntF,cntR_,cntF_;
  always @(posedge clk_500)
    if (!clk_ph1) cntR <=      {cntW{1'b0}};
    else          cntR <= cntR+{cntW{1'b1}};
	 
  always @(negedge clk_500)
    if (!clk_ph1) cntF <=      {cntW{1'b0}};
    else          cntF <= cntR+{cntW{1'b1}};
	 
  always @(negedge clk_ph1)
    {cntR_,cntF_} <= {cntR,cntF};

  always @(negedge clk_ref)
    phs_sgn <= clk_phs;
  
  wire [cntW:0] cnt_sum = cntR_ + cntF_;// + !phs_sign;
  //wire [8:0] phs_bin = cnt_sum*8'd10/8'd8+(|cnt_sum[1:0]);
  
  bin2bcd9 bin2bcd9_00 (cnt_sum,phs_bcd);

endmodule

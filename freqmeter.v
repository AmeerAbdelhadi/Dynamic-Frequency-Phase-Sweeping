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
// freqmeter.v: Clock freq. meter for 50% duty-cycle clocks; measures clock period//
// divides the reference clock to increase accuracy and allow low freq. sampling  //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

// Ameer Abdelhadi, Sept. 2012
// frequency meter for 50% duty-cycle clocks
// measures clock period -T

module freqmeter
  ( input         rst     , // system reset
    input         clk_50  , // sampling clock, 50Mhz
    input         clk_ref , // reference clock / frequency to measure
    output [15:0] frq_bcd); // measured frequency / BCD {thousands,hundreds,tens,ones}

  reg clk_div;
  reg [6:0] ccnt;  
  always @(posedge clk_ref)
    if (ccnt==7'd99) {ccnt,clk_div} <= {7'd0,!clk_div};
    else ccnt <= ccnt+1'b1;

  localparam cntW = 16;
	 
  reg  [cntW-1:0] cntR,cntF,cntR_,cntF_;
  always @(posedge clk_50)
    if (!clk_div) cntR <= 12'd0;
    else          cntR <= cntR+1'b1;
	 
  always @(negedge clk_50)
    if (!clk_div) cntF <= 12'd0;
    else          cntF <= cntF+1'b1;
	 
  always @(negedge clk_div)
    {cntR_,cntF_} <= {cntR,cntF};

  bin2bcd16 bin2bcd16_00 (cntR_+cntF_,frq_bcd);
  
endmodule

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
//        FreqPhaseSweeping.v: Dynamic clock freqyency/phase sweep testing        //
//                             using Altera's DE-115 board with Cyclone IV        //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module FreqPhaseSweeping (
  // PORT declarations
  input         CLOCK_50, // 50MHz clock 1
  output [8:0]  LEDG    , // green LED
  output [17:0] LEDR    , // red   LED
  input  [3:0]	 KEY     , // keys
  input  [17:0] SW      , // switches
  output [6:0]  HEX0    , // 7-segments 0
  output [6:0]  HEX1    , // 7-segments 1
  output [6:0]  HEX2    , // 7-segments 2
  output [6:0]  HEX3    , // 7-segments 3
  output [6:0]  HEX4    , // 7-segments 4
  output [6:0]  HEX5    , // 7-segments 5
  output [6:0]  HEX6    , // 7-segments 6
  output [6:0]  HEX7      // 7-segments 7
);

  // assign high-Z for unused output ports
  assign {LEDG[8],LEDG[5],LEDG[3:0]} = { 4{1'bz}};
  // assign SW to LEDR
  assign LEDR[17:0]  = SW[17:0];
  
  // reset generators
  wire rst   ; rstgen #(20) rstgen_sys (CLOCK_50, 1'b0, rst   ); // system reset generator
  wire rstpll; rstgen #(17) rstgen_pll (CLOCK_50, 1'b0, rstpll); // pll reset (longer than system reset)  

  // instantiate PLL for 500MHz clock generation
  wire clk_500 ;
  wire [3:0] NC;
  pll     #( .MUL0(10          ),  // clk0 parameters : multiply
             .DIV0(1           ),  // clk0 parameters : divide
             .PHS0("-200"      ))  // clk0 parameters : phase shift (ps)
  pll_inst ( .rst (rstpll      ),  // asynchronous reset
             .clki(CLOCK_50    ),  // pll input  clock  // 50MHz
             .clko({NC,clk_500})); // pll output clocks // details above

  // instantiate PLL for dynamic frequency/phase sweeping
  wire clk_ref,clk_phs;
  pll_dyn #(
    .INIT_FRQ("2"), // initial frequency - MHz
    .INIT_PHS("0")  // initial clock phase shift - ps(clk_phs only)
  )pll_dyn_inst (
    .areset    (rstpll  ), // asynchronous reset
    .clk_50    (CLOCK_50), // 50Mhz clock source
    .phasestep (fkey[2] ), // shift phase one step forward
    .freq      (SW[8:0] ), // new frequeny value to be changed
    .write_freq(fkey[3] ), // performe frequeny change 
    .clk_ref   (clk_ref ), // reference output clock
    .clk_phs   (clk_phs ), // output clock with phase shifting
    .busy      (LEDG[7] )  // PLL busy, operation not done yet
  );

  // filtered keys
  wire [3:0] fkey;
  keyfilter keyfilter_02 (CLOCK_50,KEY[2],fkey[2]);
  keyfilter keyfilter_03 (CLOCK_50,KEY[3],fkey[3]);
  assign {LEDG[6],LEDG[4]} = {fkey[3],fkey[2]};

  //phase meter  
  wire        phs_sgn;
  wire [11:0] phs_bcd;
  phasemeter
  phasemeter_inst ( .clk_500(clk_500),  // sampling clock, 500Mhz
                    .clk_ref(clk_ref),  // reference clock
                    .clk_phs(clk_phs),  // phase-shifted clock, same frequency as reference clock
                    .phs_sgn(phs_sgn),  // measured pahse shift / sign
                    .phs_bcd(phs_bcd)); // measured pahse shift / BCD {ones,tens,hundreds}

  hex7seg hex7seg_00 (phs_bcd[3 :0 ],HEX0);
  hex7seg hex7seg_01 (phs_bcd[7 :4 ],HEX1);
  hex7seg hex7seg_02 (phs_bcd[11:8 ],HEX2);
  assign HEX3 = {phs_sgn,6'b111111};

  // frequency meter  
  wire [15:0] frq_bcd;
  freqmeter
  freqmeter_inst
  ( .clk_50 (CLOCK_50),  // sampling clock, 50Mhz
    .clk_ref(clk_phs ),  // reference clock / frequency to measure
    .frq_bcd(frq_bcd )); // measured frequency / BCD {thousands,hundreds,tens,ones}
 
  hex7seg hex7seg_04 (frq_bcd[3 :0 ],HEX4);
  hex7seg hex7seg_05 (frq_bcd[7 :4 ],HEX5);
  hex7seg hex7seg_06 (frq_bcd[11:8 ],HEX6); 
  hex7seg hex7seg_07 (frq_bcd[15:12],HEX7);
  
endmodule

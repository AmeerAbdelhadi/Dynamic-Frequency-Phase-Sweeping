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
// bin2bcd16.v: 16bit Binay to BCD Converter; Double Dabble/ Shift&Add3 Algorithm //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module bin2bcd16 (
  input      [15:0] bin, // binary
  output reg [19:0] bcd  // bcd {10 thousands,thousands,hundreds,tens,ones}
);

  reg [35:0] z;
  integer i;

  always @(bin) begin
    for(i = 0; i <= 35; i = i+1) z[i] = 0;
    z[18:3] = bin;
    for(i = 0; i <= 12; i = i+1) begin
      if(z[19:16] > 4) z[19:16] = z[19:16] + 3;
      if(z[23:20] > 4) z[23:20] = z[23:20] + 3;
      if(z[27:24] > 4) z[27:24] = z[27:24] + 3;
      if(z[31:28] > 4) z[31:28] = z[31:28] + 3;
      z[35:1] = z[34:0];
    end      
    bcd = z[35:16];	
  end             
endmodule

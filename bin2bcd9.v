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
// bin2bcd9.v: 9-bit Binay to BCD Converter; Double Dabble / Shift&Add3 Algorithm //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

module bin2bcd9 (
  input      [8 :0] bin, // binary
  output reg [11:0] bcd  // bcd {hundreds,tens,ones}

);

  reg [19:0] z;
  integer i;

  always @(bin) begin
    for(i = 0; i <= 19; i = i+1) z[i] = 0;
    z[11:3] = bin;
    for(i = 0; i <= 5; i = i+1) begin
      if(z[12:9 ] > 4) z[12:9 ] = z[12:9 ] + 3;
      if(z[16:13] > 4) z[16:13] = z[16:13] + 3;
      z[19:1] = z[18:0];
     end      
	  bcd = {1'b0,z[19:9]};
  end

endmodule

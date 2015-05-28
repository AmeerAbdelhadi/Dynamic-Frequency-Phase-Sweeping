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
//                           math.v: precompile  macros                           //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

// Math functions
// Ameer Abdelhadi, June 2012

`ifndef __MATH_V__
`define __MATH_V__

// pack 2-D array into 1-D
// works with Synopsys, but not with ncverilog
`define PKARRAY(PKWID,PKLEN,PKSRC,PKDST) \
          genvar pki; generate for(pki=0;pki<(PKLEN);pki=pki+1) begin:PKARRi; \
            assign PKDST[((PKWID)*pki+((PKWID)-1)):((PKWID)*pki)] = PKSRC[pki][((PKWID)-1):0]; \
          end; endgenerate

// unpack 1-D array into 2-D
// works with Synopsys, but not with ncverilog
`define UPARRAY(PKWID,PKLEN,PKSRC,PKDST) \
          genvar upi; generate for(upi=0;upi<(PKLEN);upi=upi+1) begin:UPARRi; \
            assign PKDST[upi][((PKWID)-1):0] = PKSRC[((PKWID)*upi+((PKWID)-1)):((PKWID)*upi)]; \
          end; endgenerate

// factorial (n!); result up to 32bit integer
`define fact(n)  ( ( ((n) >= 2      ) ? 2  : 1) * \
                   ( ((n) >= 3      ) ? 3  : 1) * \
                   ( ((n) >= 4      ) ? 4  : 1) * \
                   ( ((n) >= 5      ) ? 5  : 1) * \
                   ( ((n) >= 6      ) ? 6  : 1) * \
                   ( ((n) >= 7      ) ? 7  : 1) * \
                   ( ((n) >= 8      ) ? 8  : 1) * \
                   ( ((n) >= 9      ) ? 9  : 1) * \
                   ( ((n) >= 10     ) ? 10 : 1) * \
                   ( ((n) >= 11     ) ? 11 : 1) * \
                   ( ((n) >= 12     ) ? 12 : 1)   )

// ceiling of log2; up to 31bit unsigned integer (max positive integer in signed 32bit integer)
`define log2(x)  ( ( ((x) >  1         ) ? 1  : 0) + \
                   ( ((x) >  2         ) ? 1  : 0) + \
                   ( ((x) >  4         ) ? 1  : 0) + \
                   ( ((x) >  8         ) ? 1  : 0) + \
                   ( ((x) >  16        ) ? 1  : 0) + \
                   ( ((x) >  32        ) ? 1  : 0) + \
                   ( ((x) >  64        ) ? 1  : 0) + \
                   ( ((x) >  128       ) ? 1  : 0) + \
                   ( ((x) >  256       ) ? 1  : 0) + \
                   ( ((x) >  512       ) ? 1  : 0) + \
                   ( ((x) >  1024      ) ? 1  : 0) + \
                   ( ((x) >  2048      ) ? 1  : 0) + \
                   ( ((x) >  4096      ) ? 1  : 0) + \
                   ( ((x) >  8192      ) ? 1  : 0) + \
                   ( ((x) >  16384     ) ? 1  : 0) + \
                   ( ((x) >  32768     ) ? 1  : 0) + \
                   ( ((x) >  65536     ) ? 1  : 0) + \
                   ( ((x) >  131072    ) ? 1  : 0) + \
                   ( ((x) >  262144    ) ? 1  : 0) + \
                   ( ((x) >  524288    ) ? 1  : 0) + \
                   ( ((x) >  1048576   ) ? 1  : 0) + \
                   ( ((x) >  2097152   ) ? 1  : 0) + \
                   ( ((x) >  4194304   ) ? 1  : 0) + \
                   ( ((x) >  8388608   ) ? 1  : 0) + \
                   ( ((x) >  16777216  ) ? 1  : 0) + \
                   ( ((x) >  33554432  ) ? 1  : 0) + \
                   ( ((x) >  67108864  ) ? 1  : 0) + \
                   ( ((x) >  134217728 ) ? 1  : 0) + \
                   ( ((x) >  268435456 ) ? 1  : 0) + \
                   ( ((x) >  536870912 ) ? 1  : 0) + \
                   ( ((x) >  1073741824) ? 1  : 0)   )

// floor of log2; up to 31bit unsigned integer (max positive integer in signed 32bit integer)
`define log2f(x) ( ( ((x) >= 2         ) ? 1  : 0) + \
                   ( ((x) >= 4         ) ? 1  : 0) + \
                   ( ((x) >= 8         ) ? 1  : 0) + \
                   ( ((x) >= 16        ) ? 1  : 0) + \
                   ( ((x) >= 32        ) ? 1  : 0) + \
                   ( ((x) >= 64        ) ? 1  : 0) + \
                   ( ((x) >= 128       ) ? 1  : 0) + \
                   ( ((x) >= 256       ) ? 1  : 0) + \
                   ( ((x) >= 512       ) ? 1  : 0) + \
                   ( ((x) >= 1024      ) ? 1  : 0) + \
                   ( ((x) >= 2048      ) ? 1  : 0) + \
                   ( ((x) >= 4096      ) ? 1  : 0) + \
                   ( ((x) >= 8192      ) ? 1  : 0) + \
                   ( ((x) >= 16384     ) ? 1  : 0) + \
                   ( ((x) >= 32768     ) ? 1  : 0) + \
                   ( ((x) >= 65536     ) ? 1  : 0) + \
                   ( ((x) >= 131072    ) ? 1  : 0) + \
                   ( ((x) >= 262144    ) ? 1  : 0) + \
                   ( ((x) >= 524288    ) ? 1  : 0) + \
                   ( ((x) >= 1048576   ) ? 1  : 0) + \
                   ( ((x) >= 2097152   ) ? 1  : 0) + \
                   ( ((x) >= 4194304   ) ? 1  : 0) + \
                   ( ((x) >= 8388608   ) ? 1  : 0) + \
                   ( ((x) >= 16777216  ) ? 1  : 0) + \
                   ( ((x) >= 33554432  ) ? 1  : 0) + \
                   ( ((x) >= 67108864  ) ? 1  : 0) + \
                   ( ((x) >= 134217728 ) ? 1  : 0) + \
                   ( ((x) >= 268435456 ) ? 1  : 0) + \
                   ( ((x) >= 536870912 ) ? 1  : 0) + \
                   ( ((x) >= 1073741824) ? 1  : 0)   )						 
						 
						 
`endif //__MATH_V__

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
//    lfsr_fb.v: feedback function for linear feedback shift register (LFSR) ;    //
//    a periodic counter with random count; maximux supported width is 168-bit    //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), June  2012 //
////////////////////////////////////////////////////////////////////////////////////

module lfsr_fb
 #( parameter     WID = 16 )   // integer: register width, up to 168.
  ( input [WID:1] cnt      ,   // input  clock
    output wire   fb       ); // output random count number

  // decoding of feedback signal
  assign fb = (WID==2  ) ? !(cnt[2  ]^cnt[1  ]                                ) :
              (WID==3  ) ? !(cnt[3  ]^cnt[2  ]                                ) :
              (WID==4  ) ? !(cnt[4  ]^cnt[3  ]                                ) :
              (WID==5  ) ? !(cnt[5  ]^cnt[3  ]                                ) :
              (WID==6  ) ? !(cnt[6  ]^cnt[5  ]                                ) :
              (WID==7  ) ? !(cnt[7  ]^cnt[6  ]                                ) :
              (WID==8  ) ? !(cnt[8  ]^cnt[6  ]^cnt[5  ]^cnt[4  ]              ) :
              (WID==9  ) ? !(cnt[9  ]^cnt[5  ]                                ) :
              (WID==10 ) ? !(cnt[10 ]^cnt[7  ]                                ) :
              (WID==11 ) ? !(cnt[11 ]^cnt[9  ]                                ) :
              (WID==12 ) ? !(cnt[12 ]^cnt[6  ]^cnt[4  ]^cnt[1  ]              ) :
              (WID==13 ) ? !(cnt[13 ]^cnt[4  ]^cnt[3  ]^cnt[1  ]              ) :
              (WID==14 ) ? !(cnt[14 ]^cnt[5  ]^cnt[3  ]^cnt[1  ]              ) :
              (WID==15 ) ? !(cnt[15 ]^cnt[14 ]                                ) :
              (WID==16 ) ? !(cnt[16 ]^cnt[15 ]^cnt[13 ]^cnt[4  ]              ) :
              (WID==17 ) ? !(cnt[17 ]^cnt[14 ]                                ) :
              (WID==18 ) ? !(cnt[18 ]^cnt[11 ]                                ) :
              (WID==19 ) ? !(cnt[19 ]^cnt[6  ]^cnt[2  ]^cnt[1  ]              ) :
              (WID==20 ) ? !(cnt[20 ]^cnt[17 ]                                ) :
              (WID==21 ) ? !(cnt[21 ]^cnt[19 ]                                ) :
              (WID==22 ) ? !(cnt[22 ]^cnt[21 ]                                ) :
              (WID==23 ) ? !(cnt[23 ]^cnt[18 ]                                ) :
              (WID==24 ) ? !(cnt[24 ]^cnt[23 ]^cnt[22 ]^cnt[17 ]              ) :
              (WID==25 ) ? !(cnt[25 ]^cnt[22 ]                                ) :
              (WID==26 ) ? !(cnt[26 ]^cnt[6  ]^cnt[2  ]^cnt[1  ]              ) :
              (WID==27 ) ? !(cnt[27 ]^cnt[5  ]^cnt[2  ]^cnt[1  ]              ) :
              (WID==28 ) ? !(cnt[28 ]^cnt[25 ]                                ) :
              (WID==29 ) ? !(cnt[29 ]^cnt[27 ]                                ) :
              (WID==30 ) ? !(cnt[30 ]^cnt[6  ]^cnt[4  ]^cnt[1  ]              ) :
              (WID==31 ) ? !(cnt[31 ]^cnt[28 ]                                ) :
              (WID==32 ) ? !(cnt[32 ]^cnt[22 ]^cnt[2  ]^cnt[1  ]              ) :
              (WID==33 ) ? !(cnt[33 ]^cnt[20 ]                                ) :
              (WID==34 ) ? !(cnt[34 ]^cnt[27 ]^cnt[2  ]^cnt[1  ]              ) :
              (WID==35 ) ? !(cnt[35 ]^cnt[33 ]                                ) :
              (WID==36 ) ? !(cnt[36 ]^cnt[25 ]                                ) :
              (WID==37 ) ? !(cnt[37 ]^cnt[5  ]^cnt[4  ]^cnt[3  ]^cnt[2]^cnt[1]) :
              (WID==38 ) ? !(cnt[38 ]^cnt[6  ]^cnt[5  ]^cnt[1  ]              ) :
              (WID==39 ) ? !(cnt[39 ]^cnt[35 ]                                ) :
              (WID==40 ) ? !(cnt[40 ]^cnt[38 ]^cnt[21 ]^cnt[19 ]              ) :
              (WID==41 ) ? !(cnt[41 ]^cnt[38 ]                                ) :
              (WID==42 ) ? !(cnt[42 ]^cnt[41 ]^cnt[20 ]^cnt[19 ]              ) :
              (WID==43 ) ? !(cnt[43 ]^cnt[42 ]^cnt[38 ]^cnt[37 ]              ) :
              (WID==44 ) ? !(cnt[44 ]^cnt[43 ]^cnt[18 ]^cnt[17 ]              ) :
              (WID==45 ) ? !(cnt[45 ]^cnt[44 ]^cnt[42 ]^cnt[41 ]              ) :
              (WID==46 ) ? !(cnt[46 ]^cnt[45 ]^cnt[26 ]^cnt[25 ]              ) :
              (WID==47 ) ? !(cnt[47 ]^cnt[42 ]                                ) :
              (WID==48 ) ? !(cnt[48 ]^cnt[47 ]^cnt[21 ]^cnt[20 ]              ) :
              (WID==49 ) ? !(cnt[49 ]^cnt[40 ]                                ) :
              (WID==50 ) ? !(cnt[50 ]^cnt[49 ]^cnt[24 ]^cnt[23 ]              ) :
              (WID==51 ) ? !(cnt[51 ]^cnt[50 ]^cnt[36 ]^cnt[35 ]              ) :
              (WID==52 ) ? !(cnt[52 ]^cnt[49 ]                                ) :
              (WID==53 ) ? !(cnt[53 ]^cnt[52 ]^cnt[38 ]^cnt[37 ]              ) :
              (WID==54 ) ? !(cnt[54 ]^cnt[53 ]^cnt[18 ]^cnt[17 ]              ) :
              (WID==55 ) ? !(cnt[55 ]^cnt[31 ]                                ) :
              (WID==56 ) ? !(cnt[56 ]^cnt[55 ]^cnt[35 ]^cnt[34 ]              ) :
              (WID==57 ) ? !(cnt[57 ]^cnt[50 ]                                ) :
              (WID==58 ) ? !(cnt[58 ]^cnt[39 ]                                ) :
              (WID==59 ) ? !(cnt[59 ]^cnt[58 ]^cnt[38 ]^cnt[37 ]              ) :
              (WID==60 ) ? !(cnt[60 ]^cnt[59 ]                                ) :
              (WID==61 ) ? !(cnt[61 ]^cnt[60 ]^cnt[46 ]^cnt[45 ]              ) :
              (WID==62 ) ? !(cnt[62 ]^cnt[61 ]^cnt[6  ]^cnt[5  ]              ) :
              (WID==63 ) ? !(cnt[63 ]^cnt[62 ]                                ) :
              (WID==64 ) ? !(cnt[64 ]^cnt[63 ]^cnt[61 ]^cnt[60 ]              ) :
              (WID==65 ) ? !(cnt[65 ]^cnt[47 ]                                ) :
              (WID==66 ) ? !(cnt[66 ]^cnt[65 ]^cnt[57 ]^cnt[56 ]              ) :
              (WID==67 ) ? !(cnt[67 ]^cnt[66 ]^cnt[58 ]^cnt[57 ]              ) :
              (WID==68 ) ? !(cnt[68 ]^cnt[59 ]                                ) :
              (WID==69 ) ? !(cnt[69 ]^cnt[67 ]^cnt[42 ]^cnt[40 ]              ) :
              (WID==70 ) ? !(cnt[70 ]^cnt[69 ]^cnt[55 ]^cnt[54 ]              ) :
              (WID==71 ) ? !(cnt[71 ]^cnt[65 ]                                ) :
              (WID==72 ) ? !(cnt[72 ]^cnt[66 ]^cnt[25 ]^cnt[19 ]              ) :
              (WID==73 ) ? !(cnt[73 ]^cnt[48 ]                                ) :
              (WID==74 ) ? !(cnt[74 ]^cnt[73 ]^cnt[59 ]^cnt[58 ]              ) :
              (WID==75 ) ? !(cnt[75 ]^cnt[74 ]^cnt[65 ]^cnt[64 ]              ) :
              (WID==76 ) ? !(cnt[76 ]^cnt[75 ]^cnt[41 ]^cnt[40 ]              ) :
              (WID==77 ) ? !(cnt[77 ]^cnt[76 ]^cnt[47 ]^cnt[46 ]              ) :
              (WID==78 ) ? !(cnt[78 ]^cnt[77 ]^cnt[59 ]^cnt[58 ]              ) :
              (WID==79 ) ? !(cnt[79 ]^cnt[70 ]                                ) :
              (WID==80 ) ? !(cnt[80 ]^cnt[79 ]^cnt[43 ]^cnt[42 ]              ) :
              (WID==81 ) ? !(cnt[81 ]^cnt[77 ]                                ) :
              (WID==82 ) ? !(cnt[82 ]^cnt[79 ]^cnt[47 ]^cnt[44 ]              ) :
              (WID==83 ) ? !(cnt[83 ]^cnt[82 ]^cnt[38 ]^cnt[37 ]              ) :
              (WID==84 ) ? !(cnt[84 ]^cnt[71 ]                                ) :
              (WID==85 ) ? !(cnt[85 ]^cnt[84 ]^cnt[58 ]^cnt[57 ]              ) :
              (WID==86 ) ? !(cnt[86 ]^cnt[85 ]^cnt[74 ]^cnt[73 ]              ) :
              (WID==87 ) ? !(cnt[87 ]^cnt[74 ]                                ) :
              (WID==88 ) ? !(cnt[88 ]^cnt[87 ]^cnt[17 ]^cnt[16 ]              ) :
              (WID==89 ) ? !(cnt[89 ]^cnt[51 ]                                ) :
              (WID==90 ) ? !(cnt[90 ]^cnt[89 ]^cnt[72 ]^cnt[71 ]              ) :
              (WID==91 ) ? !(cnt[91 ]^cnt[90 ]^cnt[8  ]^cnt[7  ]              ) :
              (WID==92 ) ? !(cnt[92 ]^cnt[91 ]^cnt[80 ]^cnt[79 ]              ) :
              (WID==93 ) ? !(cnt[93 ]^cnt[91 ]                                ) :
              (WID==94 ) ? !(cnt[94 ]^cnt[73 ]                                ) :
              (WID==95 ) ? !(cnt[95 ]^cnt[84 ]                                ) :
              (WID==96 ) ? !(cnt[96 ]^cnt[94 ]^cnt[49 ]^cnt[47 ]              ) :
              (WID==97 ) ? !(cnt[97 ]^cnt[91 ]                                ) :
              (WID==98 ) ? !(cnt[98 ]^cnt[87 ]                                ) :
              (WID==99 ) ? !(cnt[99 ]^cnt[97 ]^cnt[54 ]^cnt[52 ]              ) :
              (WID==100) ? !(cnt[100]^cnt[63 ]                                ) :
              (WID==101) ? !(cnt[101]^cnt[100]^cnt[95 ]^cnt[94 ]              ) :
              (WID==102) ? !(cnt[102]^cnt[101]^cnt[36 ]^cnt[35 ]              ) :
              (WID==103) ? !(cnt[103]^cnt[94 ]                                ) :
              (WID==104) ? !(cnt[104]^cnt[103]^cnt[94 ]^cnt[93 ]              ) :
              (WID==105) ? !(cnt[105]^cnt[89 ]                                ) :
              (WID==106) ? !(cnt[106]^cnt[91 ]                                ) :
              (WID==107) ? !(cnt[107]^cnt[105]^cnt[44 ]^cnt[42 ]              ) :
              (WID==108) ? !(cnt[108]^cnt[77 ]                                ) :
              (WID==109) ? !(cnt[109]^cnt[108]^cnt[103]^cnt[102]              ) :
              (WID==110) ? !(cnt[110]^cnt[109]^cnt[98 ]^cnt[97 ]              ) :
              (WID==111) ? !(cnt[111]^cnt[101]                                ) :
              (WID==112) ? !(cnt[112]^cnt[110]^cnt[69 ]^cnt[67 ]              ) :
              (WID==113) ? !(cnt[113]^cnt[104]                                ) :
              (WID==114) ? !(cnt[114]^cnt[113]^cnt[33 ]^cnt[32 ]              ) :
              (WID==115) ? !(cnt[115]^cnt[114]^cnt[101]^cnt[100]              ) :
              (WID==116) ? !(cnt[116]^cnt[115]^cnt[46 ]^cnt[45 ]              ) :
              (WID==117) ? !(cnt[117]^cnt[115]^cnt[99 ]^cnt[97 ]              ) :
              (WID==118) ? !(cnt[118]^cnt[85 ]                                ) :
              (WID==119) ? !(cnt[119]^cnt[111]                                ) :
              (WID==120) ? !(cnt[120]^cnt[113]^cnt[9  ]^cnt[2  ]              ) :
              (WID==121) ? !(cnt[121]^cnt[103]                                ) :
              (WID==122) ? !(cnt[122]^cnt[121]^cnt[63 ]^cnt[62 ]              ) :
              (WID==123) ? !(cnt[123]^cnt[121]                                ) :
              (WID==124) ? !(cnt[124]^cnt[87 ]                                ) :
              (WID==125) ? !(cnt[125]^cnt[124]^cnt[18 ]^cnt[17 ]              ) :
              (WID==126) ? !(cnt[126]^cnt[125]^cnt[90 ]^cnt[89 ]              ) :
              (WID==127) ? !(cnt[127]^cnt[126]                                ) :
              (WID==128) ? !(cnt[128]^cnt[126]^cnt[101]^cnt[99 ]              ) :
              (WID==129) ? !(cnt[129]^cnt[124]                                ) :
              (WID==130) ? !(cnt[130]^cnt[127]                                ) :
              (WID==131) ? !(cnt[131]^cnt[130]^cnt[84 ]^cnt[83 ]              ) :
              (WID==132) ? !(cnt[132]^cnt[103]                                ) :
              (WID==133) ? !(cnt[133]^cnt[132]^cnt[82 ]^cnt[81 ]              ) :
              (WID==134) ? !(cnt[134]^cnt[77 ]                                ) :
              (WID==135) ? !(cnt[135]^cnt[124]                                ) :
              (WID==136) ? !(cnt[136]^cnt[135]^cnt[11 ]^cnt[10 ]              ) :
              (WID==137) ? !(cnt[137]^cnt[116]                                ) :
              (WID==138) ? !(cnt[138]^cnt[137]^cnt[131]^cnt[130]              ) :
              (WID==139) ? !(cnt[139]^cnt[136]^cnt[134]^cnt[131]              ) :
              (WID==140) ? !(cnt[140]^cnt[111]                                ) :
              (WID==141) ? !(cnt[141]^cnt[140]^cnt[110]^cnt[109]              ) :
              (WID==142) ? !(cnt[142]^cnt[121]                                ) :
              (WID==143) ? !(cnt[143]^cnt[142]^cnt[123]^cnt[122]              ) :
              (WID==144) ? !(cnt[144]^cnt[143]^cnt[75 ]^cnt[74 ]              ) :
              (WID==145) ? !(cnt[145]^cnt[93 ]                                ) :
              (WID==146) ? !(cnt[146]^cnt[145]^cnt[87 ]^cnt[86 ]              ) :
              (WID==147) ? !(cnt[147]^cnt[146]^cnt[110]^cnt[109]              ) :
              (WID==148) ? !(cnt[148]^cnt[121]                                ) :
              (WID==149) ? !(cnt[149]^cnt[148]^cnt[40 ]^cnt[39 ]              ) :
              (WID==150) ? !(cnt[150]^cnt[97 ]                                ) :
              (WID==151) ? !(cnt[151]^cnt[148]                                ) :
              (WID==152) ? !(cnt[152]^cnt[151]^cnt[87 ]^cnt[86 ]              ) :
              (WID==153) ? !(cnt[153]^cnt[152]                                ) :
              (WID==154) ? !(cnt[154]^cnt[152]^cnt[27 ]^cnt[25 ]              ) :
              (WID==155) ? !(cnt[155]^cnt[154]^cnt[124]^cnt[123]              ) :
              (WID==156) ? !(cnt[156]^cnt[155]^cnt[41 ]^cnt[40 ]              ) :
              (WID==157) ? !(cnt[157]^cnt[156]^cnt[131]^cnt[130]              ) :
              (WID==158) ? !(cnt[158]^cnt[157]^cnt[132]^cnt[131]              ) :
              (WID==159) ? !(cnt[159]^cnt[128]                                ) :
              (WID==160) ? !(cnt[160]^cnt[159]^cnt[142]^cnt[141]              ) :
              (WID==161) ? !(cnt[161]^cnt[143]                                ) :
              (WID==162) ? !(cnt[162]^cnt[161]^cnt[75 ]^cnt[74 ]              ) :
              (WID==163) ? !(cnt[163]^cnt[162]^cnt[104]^cnt[103]              ) :
              (WID==164) ? !(cnt[164]^cnt[163]^cnt[151]^cnt[150]              ) :
              (WID==165) ? !(cnt[165]^cnt[164]^cnt[135]^cnt[134]              ) :
              (WID==166) ? !(cnt[166]^cnt[165]^cnt[128]^cnt[127]              ) :
              (WID==167) ? !(cnt[167]^cnt[161]                                ) :
              (WID==168) ? !(cnt[168]^cnt[166]^cnt[153]^cnt[151]              ) : 1'bx;

endmodule

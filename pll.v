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
//                        pll.v: Altera's PLL instantiation                       //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), June  2012 //
////////////////////////////////////////////////////////////////////////////////////

// Ameer Abdelhadi, June 2012

module pll #(
    parameter    MUL0 = 27  ,  // integer: clock 0 divisor 
    parameter    DIV0 = 5   ,  // integer: clock 0 multiplier
    parameter    PHS0 = "0" ,  // string : clock 0 phase shift / ps
    parameter    MUL1 = 27  ,  // integer: clock 1 divisor 
    parameter    DIV1 = 5   ,  // integer: clock 1 multiplier
    parameter    PHS1 = "0" ,  // string : clock 1 phase shift / ps
    parameter    MUL2 = 27  ,  // integer: clock 2 divisor 
    parameter    DIV2 = 5   ,  // integer: clock 2 multiplier
    parameter    PHS2 = "0" ,  // string : clock 2 phase shift / ps
    parameter    MUL3 = 27  ,  // integer: clock 3 divisor 
    parameter    DIV3 = 5   ,  // integer: clock 3 multiplier
    parameter    PHS3 = "0" ,  // string : clock 3 phase shift / ps
    parameter    MUL4 = 27  ,  // integer: clock 4 divisor 
    parameter    DIV4 = 5   ,  // integer: clock 4 multiplier
    parameter    PHS4 = "0" )( // string : clock 4 phase shift / ps
    input        rst        ,  // asynchronous reset
    input	     clki       ,  // input clock
    output [4:0] clko       ,  // output clocks
    // phase shift	
    input [2:0]  phasecntsel,  // Counter Select. 000:all 001:M 010:C0 011:C1 100:C2 101:C3 110:C4. registered in the rising edge of SCANCLK.
    input        phasestep  ,  // Logic high enables dynamic phase shifting.
    input        phaseupdown,  // Selects dynamic phase shift direction; 1:UP, 0:DOWN. Registered in the rising edge of SCANCLK.
    input        scanclk    ,  // Free running clock used in combination with PHASESTEP to enable or disable dynamic phase shifting.
    output       phasedone  ); // Indicates that the phase adjustment is complete and PLL is ready to act on a possible second adjustment pulse. De-asserts on the rising edge of SCANCLK.

  altpll	#(
    .bandwidth_type          ("AUTO"                 ),
    .clk0_divide_by          (DIV0                   ),
    .clk0_duty_cycle         (50                     ),
    .clk0_multiply_by        (MUL0                   ),
    .clk0_phase_shift        (PHS0                   ),
    .clk1_divide_by          (DIV1                   ),
    .clk1_duty_cycle         (50                     ),
    .clk1_multiply_by        (MUL1                   ),
    .clk1_phase_shift        (PHS1                   ),
    .clk2_divide_by          (DIV2                   ),
    .clk2_duty_cycle         (50                     ),
    .clk2_multiply_by        (MUL2                   ),
    .clk2_phase_shift        (PHS2                   ),
    .clk3_divide_by          (DIV3                   ),
    .clk3_duty_cycle         (50                     ),
    .clk3_multiply_by        (MUL3                   ),
    .clk3_phase_shift        (PHS3                   ),
    .clk4_divide_by          (DIV4                   ),
    .clk4_duty_cycle         (50                     ),
    .clk4_multiply_by        (MUL4                   ),
    .clk4_phase_shift        (PHS4                   ),
    .compensate_clock        ("CLK0"                 ),
    .inclk0_input_frequency  (20000                  ),
    .intended_device_family  ("Cyclone IV E"         ),
    .lpm_hint                ("CBX_MODULE_PREFIX=pll"),
    .lpm_type                ("altpll"               ),
    .operation_mode          ("NORMAL"               ),
    .pll_type                ("AUTO"                 ),
    .port_activeclock        ("PORT_UNUSED"          ),
    .port_areset             ("PORT_USED"            ),
    .port_clkbad0            ("PORT_UNUSED"          ),
    .port_clkbad1            ("PORT_UNUSED"          ),
    .port_clkloss            ("PORT_UNUSED"          ),
    .port_clkswitch          ("PORT_UNUSED"          ),
    .port_configupdate       ("PORT_UNUSED"          ),
    .port_fbin               ("PORT_UNUSED"          ),
    .port_inclk0             ("PORT_USED"            ),
    .port_inclk1             ("PORT_UNUSED"          ),
    .port_locked             ("PORT_UNUSED"          ),
    .port_pfdena             ("PORT_UNUSED"          ),
    .port_phasecounterselect ("PORT_USED"            ),
    .port_phasedone          ("PORT_USED"            ),
    .port_phasestep          ("PORT_USED"            ),
    .port_phaseupdown        ("PORT_USED"            ),
    .port_pllena             ("PORT_UNUSED"          ),
    .port_scanaclr           ("PORT_UNUSED"          ),
    .port_scanclk            ("PORT_USED"            ),
    .port_scanclkena         ("PORT_UNUSED"          ),
    .port_scandata           ("PORT_UNUSED"          ),
    .port_scandataout        ("PORT_UNUSED"          ),
    .port_scandone           ("PORT_UNUSED"          ),
    .port_scanread           ("PORT_UNUSED"          ),
    .port_scanwrite          ("PORT_UNUSED"          ),
    .port_clk0               ("PORT_USED"            ),
    .port_clk1               ("PORT_USED"            ),
    .port_clk2               ("PORT_USED"            ),
    .port_clk3               ("PORT_USED"            ),
    .port_clk4               ("PORT_USED"            ),
    .port_clk5               ("PORT_UNUSED"          ),
    .port_clkena0            ("PORT_UNUSED"          ),
    .port_clkena1            ("PORT_UNUSED"          ),
    .port_clkena2            ("PORT_UNUSED"          ),
    .port_clkena3            ("PORT_UNUSED"          ),
    .port_clkena4            ("PORT_UNUSED"          ),
    .port_clkena5            ("PORT_UNUSED"          ),
    .port_extclk0            ("PORT_UNUSED"          ),
    .port_extclk1            ("PORT_UNUSED"          ),
    .port_extclk2            ("PORT_UNUSED"          ),
    .port_extclk3            ("PORT_UNUSED"          ),
    .vco_frequency_control   ("MANUAL_PHASE"         ),
    .vco_phase_shift_step    (200                    ),	
    .width_clock             (5                      ),
    .width_phasecounterselect(3                      )

  )
  altpll_component (
    .areset            (rst        ),
    .inclk             ({1'h0,clki}),
    .clk               (clko       ),
    .activeclock       (           ),
    .clkbad            (           ),
    .clkena            ({6{1'b1}}  ),
    .clkloss           (           ),
    .clkswitch         (1'b0       ),
    .configupdate      (1'b0       ),
    .enable0           (           ),
    .enable1           (           ),
    .extclk            (           ),
    .extclkena         ({4{1'b1}}  ),
    .fbin              (1'b1       ),
    .fbmimicbidir      (           ),
    .fbout             (           ),
    .fref              (           ),
    .icdrclk           (           ),
    .locked            (           ),
    .pfdena            (1'b1       ),
    .phasecounterselect(phasecntsel),
    .phasedone         (phasedone  ),
    .phasestep         (phasestep  ),
    .phaseupdown       (phaseupdown),
    .pllena            (1'b1       ),
    .scanaclr          (1'b0       ),
    .scanclk           (scanclk    ),
    .scanclkena        (1'b1       ),
    .scandata          (1'b0       ),
    .scandataout       (           ),
    .scandone          (           ),
    .scanread          (1'b0       ),
    .scanwrite         (1'b0       ),
    .sclkout0          (           ),
    .sclkout1          (           ),
    .vcooverrange      (           ),
    .vcounderrange     (           )
  );

endmodule

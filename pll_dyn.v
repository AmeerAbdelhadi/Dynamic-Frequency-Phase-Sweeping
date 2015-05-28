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
//                 pll_dyn.v: dynamic PLL with freq/phase sweeping                //
//                                                                                //
// Ameer M.S. Abdelhadi (ameer@ece.ubc.ca; ameer.abdelhadi@gmail.com), Sept. 2012 //
////////////////////////////////////////////////////////////////////////////////////

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on

module pll_dyn #(
  parameter   INIT_FRQ = 2   , // initial frequency - MHz
  parameter   INIT_PHS = "0" ) // initial clock phase shift - ps (clk_phs only)
( input	      areset         , // asynchronous reset
  input	      clk_50         , // 50Mhz clock source
  input	      phasestep      , // shift phase one step forward
  input [8:0] freq           , // new frequeny value to be changed
  input       write_freq     , // performe frequeny change 
  output      clk_ref        , // reference output clock
  output      clk_phs        , // output clock with phase shifting
  output      busy             // PLL busy, operation not done yet
);

  wire [4:0] clkout;
  assign  {clk_phs,clk_ref}  = clkout[1:0];
  wire cfgbusy, locked, phasedone, scandone;
  
  assign busy = !locked || !phasedone || cfgbusy;
  
  wire scandataout, pll_areset, scandata, scanclkena, scanclk, configupdate;

  altpll #(
    .bandwidth_type          ("HIGH"                     ),
    .clk0_divide_by          (50                         ),
    .clk0_duty_cycle         (50                         ),
    .clk0_multiply_by        (INIT_FRQ                   ),
    .clk0_phase_shift        ("0"                        ),
    .clk1_divide_by          (50                         ),
    .clk1_duty_cycle         (50                         ),
    .clk1_multiply_by        (INIT_FRQ                   ),
    .clk1_phase_shift        (INIT_PHS                   ),
    .compensate_clock        ("CLK0"                     ),
    .inclk0_input_frequency  (20000                      ),
    .intended_device_family  ("Cyclone IV E"             ),
    .lpm_hint                ("CBX_MODULE_PREFIX=pll_dyn"),
    .lpm_type                ("altpll"                   ),
    .operation_mode          ("NORMAL"                   ),
    .pll_type                ("AUTO"                     ),
    .port_activeclock        ("PORT_UNUSED"              ),
    .port_areset             ("PORT_USED"                ),
    .port_clkbad0            ("PORT_UNUSED"              ),
    .port_clkbad1            ("PORT_UNUSED"              ),
    .port_clkloss            ("PORT_UNUSED"              ),
    .port_clkswitch          ("PORT_UNUSED"              ),
    .port_configupdate       ("PORT_USED"                ),
    .port_fbin               ("PORT_UNUSED"              ),
    .port_inclk0             ("PORT_USED"                ),
    .port_inclk1             ("PORT_UNUSED"              ),
    .port_locked             ("PORT_USED"                ),
    .port_pfdena             ("PORT_UNUSED"              ),
    .port_phasecounterselect ("PORT_USED"                ),
    .port_phasedone          ("PORT_USED"                ),
    .port_phasestep          ("PORT_USED"                ),
    .port_phaseupdown        ("PORT_USED"                ),
    .port_pllena             ("PORT_UNUSED"              ),
    .port_scanaclr           ("PORT_UNUSED"              ),
    .port_scanclk            ("PORT_USED"                ),
    .port_scanclkena         ("PORT_USED"                ),
    .port_scandata           ("PORT_USED"                ),
    .port_scandataout        ("PORT_USED"                ),
    .port_scandone           ("PORT_USED"                ),
    .port_scanread           ("PORT_UNUSED"              ),
    .port_scanwrite          ("PORT_UNUSED"              ),
    .port_clk0               ("PORT_USED"                ),
    .port_clk1               ("PORT_USED"                ),
    .port_clk2               ("PORT_UNUSED"              ),
    .port_clk3               ("PORT_UNUSED"              ),
    .port_clk4               ("PORT_UNUSED"              ),
    .port_clk5               ("PORT_UNUSED"              ),
    .port_clkena0            ("PORT_UNUSED"              ),
    .port_clkena1            ("PORT_UNUSED"              ),
    .port_clkena2            ("PORT_UNUSED"              ),
    .port_clkena3            ("PORT_UNUSED"              ),
    .port_clkena4            ("PORT_UNUSED"              ),
    .port_clkena5            ("PORT_UNUSED"              ),
    .port_extclk0            ("PORT_UNUSED"              ),
    .port_extclk1            ("PORT_UNUSED"              ),
    .port_extclk2            ("PORT_UNUSED"              ),
    .port_extclk3            ("PORT_UNUSED"              ),
    .self_reset_on_loss_lock ("OFF"                      ),
    .width_clock             (5                          ),
    .width_phasecounterselect(3                          ),
    .scan_chain_mif_file     ("./pll_dyn.mif"            )
  )
  altpll_component (
    .areset             (pll_areset   ),
    .configupdate       (configupdate ),
    .inclk              ({1'h0,clk_50}),
    .phasecounterselect (3'b011       ), // Dynamic phase shift counter Select. 000:all 001:M 010:C0 011:C1 100:C2 101:C3 110:C4. registered in the rising edge of SCANCLK.
    .phasestep          (phasestep    ),
    .phaseupdown        (1'b1         ), // Dynamic phase shift direction; 1:UP, 0:DOWN. Registered in the PLL on the rising edge of SCANCLK.
    .scanclk            (scanclk      ),
    .scanclkena         (scanclkena   ),
    .scandata           (scandata     ),
    .clk                (clkout       ),
    .locked             (locked       ),
    .phasedone          (phasedone    ),
    .scandataout        (scandataout  ),
    .scandone           (scandone     ),
    .activeclock        (             ),
    .clkbad             (             ),
    .clkena             ({6{1'b1}}    ),
    .clkloss            (             ),
    .clkswitch          (1'b0         ),
    .enable0            (             ),
    .enable1            (             ),
    .extclk             (             ),
    .extclkena          ({4{1'b1}}    ),
    .fbin               (1'b1         ),
    .fbmimicbidir       (             ),
    .fbout              (             ),
    .fref               (             ),
    .icdrclk            (             ),
    .pfdena             (1'b1         ),
    .pllena             (1'b1         ),
    .scanaclr           (1'b0         ),
    .scanread           (1'b0         ),
    .scanwrite          (1'b0         ),
    .sclkout0           (             ),
    .sclkout1           (             ),
    .vcooverrange       (             ),
    .vcounderrange      (             )
);


  pll_cfg pll_cfg_component (
    .clock            (clk_50       ), // input; A clock loads parameters and drives the PLL during reconfiguration.
    .counter_param    (3'b111       ), // input [2:0]; Specifies the parameter for the value specified in the counter_type port
                                       // val counter param                    Width (bits)
                                       // 000  C0-C4   High Count              8
                                       // 001  C0-C4   Low Count               8
                                       // 100  C0-C4   Bypass                  1
                                       // 101  C0-C4   Mode (odd/even)         1
                                       // 101  CP/LF   Charge pump unused      5
                                       // 000  CP/LF   Charge pump current     3
                                       // 100  CP/LF   Loop filter unused      1
                                       // 001  CP/LF   Loop filter resistor    5
                                       // 010  CP/LF   Loop filter capacitance 2
                                       // 000  VCO     VCO post scale          1
                                       // 000  M/N     High Count              8
                                       // 001  M/N     Low Count               8
                                       // 100  M/N     Bypass                  1
                                       // 101  N/N     Mode (odd/even)         1
                                       // 111  N/N     Nominal count           9
    .counter_type     (4'h1         ), // input [3:0]; Specifies the counter type. 0:N 1:M 2:CP/LF 3:VCO 4:C0 5:C1 6:C2 7:C3 8:C4.
    .data_in          (freq         ), // input [8:0]; Data input that provides parameter value when parameters are written.
    .pll_areset_in    (areset       ), // Input signal indicating that the PLL should be reset.
                                       // The pll_areset signal is asserted when pll_areset_in is asserted. Default is 0.
    .pll_scandataout  (scandataout  ), // Contains the scandata for the PLL. Must be connected to the scandataout port of the PLL.
    .pll_scandone     (scandone     ), // input; Determines when the PLL is reconfigured. reasserted upon completion.
    .read_param       (             ), // input; Reads the parameter specified with the counter_type and counter_param to dataout.
                                       // Should only be asserted for one cycle to prevent multiple reads.
                                       // The busy port indicates when the read is complete. Default is 0. 
    .reconfig         (reconfig     ), // input; Specifies that the PLL should be reconfigured with settings specified in the cache.
                                       // Should only be asserted for one cycle to prevent reloading.
                                       // The busy port indicates when the reconfiguration is complete. Default is 0.
    .reset            (areset       ), // input; Asynchronous reset input to the megafunction.
    .write_param      ( write_param ), // input; Writes the parameter specified with the counter_type and counter_param from data_in.
                                       // Should only be asserted for one cycle to prevent multiple writes.
                                       // The busy port indicates when the write is complete. Default is 0.
    .busy             (cfgbusy      ), // output; Indicates PLL is reading or writing a parameter to the cache, or is configuring the PLL.
                                       // While busy is asserted, no parameters can be read or written.
                                       // Signal goes high when read_param, write_param, or reconfig input ports are asserted.
                                       // Signal remains high until the specified operation is complete. 
    .data_out         (             ), // output [8:0]; Data read from the cache when read_param is asserted.
                                       // Acquired through the counter_type and counter_param values, by asserting read_param. 
    .pll_areset       (pll_areset   ), // output (active high); Drives the areset port on the reconfigured PLL.
                                       // The pll_areset port must be connected to the areset port of the altpll.
                                       // The pll_areset port is asserted when pll_areset_in is asserted, or, after reconfiguration,
                                       // at the next rising clock edge after the scandone signal goes high.
    .pll_configupdate (configupdate ), // output; Drives the configupdate port on the reconfigured  PLL.
    .pll_scanclk      (scanclk      ), // output; Drives the scanclk port on the reconfigured  PLL.
    .pll_scanclkena   (scanclkena   ), // output; Clock enable for the scanclk port.
    .pll_scandata     (scandata     )  // output; Drives the scandata port on the reconfigured  PLL.
  );

  // parameter writing controller / FSM
  
  // states
  localparam state_IDLE        = 3'b000;
  localparam state_WRITE_REQ_R = 3'b001;
  localparam state_WRITE_REQ_F = 3'b010;
  localparam state_WRITING     = 3'b011;
  localparam state_WRITE_DONE  = 3'b100;
  localparam state_RECONFIGING = 3'b101;
  
  reg [2:0] state      ;
  reg [2:0] next_state ;
  reg       write_param;
  reg       reconfig   ;

  // sequential proccess
  always @(posedge clk_50 or posedge areset)
    if (areset) state <= state_IDLE;
    else state <= next_state;

  // combinatorial process
  always @(*) begin
    case (state)
      state_IDLE       : {write_param,reconfig,next_state} = {2'b00,  write_freq ?state_WRITE_REQ_R:state};
      state_WRITE_REQ_R: {write_param,reconfig,next_state} = {2'b00,(!write_freq)?state_WRITE_REQ_F:state};
      state_WRITE_REQ_F: {write_param,reconfig,next_state} = {2'b10,  cfgbusy    ?state_WRITING    :state};
      state_WRITING    : {write_param,reconfig,next_state} = {2'b00,(!cfgbusy)   ?state_WRITE_DONE :state};	
      state_WRITE_DONE : {write_param,reconfig,next_state} = {2'b01,  cfgbusy    ?state_RECONFIGING:state};
      state_RECONFIGING: {write_param,reconfig,next_state} = {2'b00,(!cfgbusy)   ?state_IDLE       :state};
      default          : {write_param,reconfig,next_state} = {2'b00,              state_IDLE             };
    endcase
  end

endmodule

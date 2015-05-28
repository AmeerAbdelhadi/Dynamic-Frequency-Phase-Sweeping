##Dynamic Run-time Frequency and Phase sweeping##
##Ameer M. Abdelhadi (ameer.abdelhadi@gmail.com)##


##Dynamic Run-time Frequency and Phase sweeping for Altera's PLLs with freq./phase meters##


**PLATFORM:** DE2-115 Development board with Cyclone IV

**LICENSE:** BSD 3-Clause ("BSD New" or "BSD Simplified") license


---


### Files and directories in this package ###

  * **README:** This file!
  * **LICENSE:** BSD 3-Clause ("BSD New" or "BSD Simplified") license
  * **FreqPhaseSweeping.qpf:** Quartus II project file
  * **FreqPhaseSweeping.qsf:** Quartus II settings file
  * **FreqPhaseSweeping.sdc:** Synopsys design constraints file; Design constraints and timing assignments
  * **FreqPhaseSweeping.pin:** Cyclone IV pin assignment
  * **math.v:** precompile macros
  * **rstgen.v:** Reset generator, based on lfsr counter
  * **keyfilter.v:** Key debouncer / glitch filter
  * **bin2bcd9.v:** 9-bit  binay to BCD converter using double dabble / shift and add3 algorithm
  * **bin2bcd16.v:** 16-bit binay to BCD converter using double dabble / shift and add3 algorithm
  * **lfsr.v:** Linear feedback shift register (LFSR); a periodic random counter
  * **lfsr_fb.v:** Feedback function for linear feedback shift register (LFSR); a periodic counter; maximux supported width is 168-bits
  * **pll.v:** Altera's PLL instantiation
  * **pll_dyn.v:** dynamic PLL with freq/phase sweeping
  * **pll_dyn.mif:** MIF file representing initial state of PLL Scan Chain
  * **pll_cfg.v:** Altera's PLL reconfigurer; created by Altera's megafunction wizard
  * **phasemeter.v:** Clock phase meter using high freq. sampling clock
  * **freqmeter.v:** Clock freq. meter for 50% duty-cycle clocks; measures clock period; divides the reference clock to increase accuracy and allow low freq. sampling
  * **FreqPhaseSweeping.v:** Dynamic clock freqyency/phase sweep testing using Altera's DE-115 board with Cyclone IV
  * **output_files/:** A directory containing Altera's logs and reports

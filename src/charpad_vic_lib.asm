/*
--------------------------------------------------------------------------------------
 vic_lib.asm

 A small library of sub-routines for performing common tasks on the
 Commodore 64 "VIC" (II) Video Interface Chip.
 MOS Technology 6567/8562/8564 (NTSC), 6569/8565/8566 (PAL). 

 Author    : Stewart Wilson, Subchrist Software.
 Created   : Sept 2012.
 Updated   : Sept 2023.
 Platform  : Commodore 64.
 Processor : MOS 6510
 Assembler : 64TASS 1.56


 Contents...

 vic_blank_on
 vic_blank_off
 vic_mode_text
 vic_mode_bitmap
 vic_mode_ecm
 vic_multicolour_on
 vic_multicolour_off
 vic_fatborderLR_on 
 vic_fatborderLR_off
 vic_fatborderTB_on 
 vic_fatborderTB_off 
 vic_reset_sprites
 vic_reset_scroll
 vic_set_scroll (X,Y = offsets).
 vic_wait_offmatrix
 vic_wait_offscreen
 vic_wait_one_sec

 vic_set_bank (A = video bank number, 0-3, 16KB).
 vic_get_bank (result in A).

 vic_set_vmatrix (A = video matrix slot number, 0-15, 1KB).
 vic_get_vmatrix (result in A).
 vic_get_vmatrixaddress (result in A).

 vic_set_charset (A = character set slot number, 0-7, 2KB).
 vic_set_bitmap  (A = bitmap image slot number, 0 or 1, 8KB).

 vic_fill_cmatrix (A = colour value, nybble).
 vic_fill_vmatrix (A = char code).
 vic_test_vmatrix


Notes...

 - The VIC-II can only "see" a 16KB block of memory at any time, the current "video bank" dictates which quarter of the available 64KB is visible.
 - The 1KB Colour Matrix is available from the fixed address $d800 (55296), it is physically external to the RAM and actually consists only of nybbles (4 bits).

 
--------------------------------------------------------------------------------------
*/


// Define some colour constants...

.const BLACK = 0
.const WHITE      = 1
.const RED        = 2
.const CYAN       = 3
.const PURPLE     = 4
.const GREEN      = 5
.const BLUE       = 6
.const YELLOW     = 7
.const ORANGE     = 8
.const BROWN      = 9
.const PINK       = 10
.const DARKGREY   = 11
.const GREY       = 12
.const LIGHTGREEN = 13
.const LIGHTBLUE  = 14
.const LIGHTGREY  = 15


/*-------------------------------------------------------------------
; blanks the Screen Matrix area to the border colour.
;
; parameters: none.
; returns: none.
;-------------------------------------------------------------------
*/

vic_blank_on:

   lda $d011
   and #$ef // clear bit 4 of control register 1.
   sta $d011
   rts

/*-------------------------------------------------
; unblanks the Screen Matrix area.
;
; parameters: none.
; returns: none.
;-------------------------------------------------
*/

vic_blank_off:

   lda $d011
   ora #$10 // set bit 4 of control register 1.
   sta $d011
   rts

/*--------------------------------------------
; enables standard text mode.
;
; parameters: none.
; returns: none.
;--------------------------------------------
*/
vic_mode_text:

   lda $d011
   and #$1f // clear bits 5,6,7 of control register 1.
   sta $d011
   rts

/*---------------------------------------
; enables bitmap mode.
;
; parameters: none.
; returns: none.
;---------------------------------------
*/

vic_mode_bitmap:

   lda $d011
   and #$1f // clear bits 5,6,7 of control register 1.
   ora #$20 // set bit 5.
   sta $d011
   rts

/*----------------------------------------------------
; enables "extended colour" text mode.
;
; parameters: none.
; returns: none.
;----------------------------------------------------
*/ 
vic_mode_ecm:

   lda $d011
   and #$1f // clear bits 5,6,7 of control register 1.
   ora #$40 // set bit 6.
   sta $d011
   rts

/*-----------------------------------------------------------------
; enables text/bitmap multi-colour mode.
;
; parameters: none.
; returns: none.
;-----------------------------------------------------------------
*/

vic_multicolour_on:

   lda $d016
   ora #$10 // set bit 4 of control register 2.
   sta $d016
   rts

/*
;-------------------------------------------------------------------
; disables text/bitmap multi-colour mode.
;
; parameters: none.
; returns: none.
;-------------------------------------------------------------------
*/ 
vic_multicolour_off:

   lda $d016
   and #$ef // clear bit 4 of control register 2.
   sta $d016
   rts

/*
;-----------------------------------------------
; enables "38 column" mode. 
; nb. causes the left and right borders to expand inward by 7 and 9 pixels respectively.
;
; parameters: none.
; returns: none.
;-----------------------------------------------

*/

vic_fatborderLR_on:

   lda $d016
   and #$f7 // clear bit 3 of control register 2.
   sta $d016
   rts

/*

;------------------------------------------------
; enables "40 column" mode. 
;
; parameters: none.
; returns: none.
;------------------------------------------------
*/

vic_fatborderLR_off: 

   lda $d016
   ora #8 // set bit 3 of control register 2.
   sta $d016
   rts

/*;--------------------------------------------
; enables "24 row" mode.
; nb. causes the top and bottom borders to expand inward by 4 pixels each.
;
; parameters: none.
; returns: none.
;--------------------------------------------
*/

vic_fatborderTB_on: 

   lda $d011
   and #$f7 // clear bit 3 of control register 1.
   sta $d011
   rts

/*---------------------------------------------
; enables "25 row" mode.
;
; parameters: none.
; returns: none.
;---------------------------------------------
*/

vic_fatborderTB_off:

   lda $d011
   ora #8 // set bit 3 of control register 1.
   sta $d011
   rts

/* --------------------------------------------------------------------------
; turns all sprites off + resets all sprite attributes.
;
; parameters: none.
; returns: none.
;--------------------------------------------------------------------------
*/

vic_reset_sprites:

     lda #0
     sta $d015   //; turn all sprites off.
     sta $d017   //; disable vertical expansion for all sprites.
     sta $d01d   //; disable horizontal expansion for all sprites.
     sta $d01b   //; give all sprites priority over background graphics.

     ldx #15     //; zero all sprite positions...
     lda #0      //; (clears $d000 - $d010)
vrs0: sta $d000,x
     dex
     bpl vrs0

     ldx #7      //; zero all sprite colours (black)...
     lda #0      //; (clears $d027 - $d02e)
vrs1: sta $d027,x
     dex
     bpl vrs1
     rts

/*;-----------------------------------------------------------------------------------------
; sets both screen scroll registers to their default values (x:0, y:3).
;
; parameters: none.
; returns: none.
;-----------------------------------------------------------------------------------------
*/

vic_reset_scroll:

   lda $d016 // reset horizontal scroll (0)...
   and #$f8
   sta $d016
   lda $d011 // reset vertical scroll (3)...
   and #$f8
   ora #3
   sta $d011
   rts

/*
;---------------------------------------------------------------------------------------
; sets both the horizontal and vertical screen screen scroll registers.
;
; parameters: X,Y = horizontal and vertical scroll offsets (0-7).
; returns: none.
;---------------------------------------------------------------------------------------
*/

vic_set_scroll:

   txa
   and #7    // ensure only a 3-bit (x) parameter value (0-7).
   sta vss_x
   tya
   and #7    // ensure only a 3-bit (y) parameter value (0-7).
   sta vss_y

   lda $d016
   and #$f8
   ora vss_x
   sta $d016

   lda $d011
   and #$f8
   ora vss_y
   sta $d011
   rts

vss_x: .byte 0
vss_y: .byte 0

/*
;---------------------------------------------------------------------------------------
; waits for the raster beam to leave the visible matrix (line 251).
;
; parameters: none.
; returns: none.
;---------------------------------------------------------------------------------------
*/

vic_wait_offmatrix:

vwom0: lda $d012 //; wait for raster line 251...
      cmp #251
      bne vwom0
      rts
/*
;---------------------------------------------------------------------------------------
; waits for the raster beam to leave the visible screen (line 300).
;
; parameters: none.
; returns: none.
;---------------------------------------------------------------------------------------
*/

vic_wait_offscreen:

vwos0: lda $d011 //; wait for raster msb clear..
      and #$80
      bne vwos0
vwos1: lda $d011 //; wait for raster msb set (line 256)..
      and #$80
      beq vwos1
vwos2: lda $d012 //; wait for raster line 300 (256 + 44)...
      cmp #44
      bne vwos2
      rts
/*
;-----------------------------------------------------------------------------------
; uses the raster beam to wait for one second (50 raster cycles, PAL).
;
; nb. all used cpu registers are saved and restored after execution, this makes it
; simple to use this routine in a loop involving the cpu registers.
;
; parameters: none.
; returns: none.
;-----------------------------------------------------------------------------------
*/

vic_wait_one_sec:

     pha //; save cpu registers...
     txa
     pha
     tya
     pha

     ldx #50
vws0: jsr vic_wait_offscreen
     dex
     bne vws0

     pla //; restore cpu registers...
     tay
     pla
     tax
     pla
     rts

/*
;---------------------------------------------
; selects a 16KB video bank.
;
; parameters: A = video bank (0-3).
; returns: none.
;
; video bank 0 is $0000-$3fff (nb. char ROM (4KB) available at $1000-$1fff, slots 2 & 3).
; video bank 1 is $4000-$7fff.
; video bank 2 is $8000-$bfff (nb. char ROM (4KB) available at $9000-$9fff, slots 2 & 3).
; video bank 3 is $c000-$ffff.
;---------------------------------------------
*/

vic_set_bank:

   and #3     //; ensure only a 2-bit parameter value (0-3).
   eor #3     //; binary invert the parameter value.
   sta vsb_b1 //; store the result temporarily.
   lda $dd02  //; read Port-A Data Direction register (CIA #2).
   ora #3     //; set the lowest two bits (outputs).
   sta $dd02  //; write Port-A Data Direction register (CIA #2).
   lda $dd00  //; read Port-A data register (CIA#2).
   and #$fc   //; preserve the upper 6 bits, clear the lower 2.
   ora vsb_b1 //; patch in the adjusted parameter value.
   sta $dd00  //; write Port-A data register (CIA#2).
   rts

vsb_b1: .byte 0

/*
;-----------------------------------------------------------
; returns the current video bank number.
;
; parameters: none.
; returns: A = current video bank number (0-3).
;-----------------------------------------------------------
*/

vic_get_bank:

   lda $dd00 //; read the port-A data register of CIA#2.
   and #3    //; keep the lowest 2 bits.
   eor #3    //; invert them to get the video bank number.
   rts

/*
;-------------------------------------------------
; selects a 1KB video matrix.
;
; parameters: A = video matrix (0-15).
; returns: none.
;-------------------------------------------------
*/

vic_set_vmatrix:

   and #$0f   //; ensure only a 4-bit parameter value (0-15).
   asl        //; shift the value to the high nybble...
   asl
   asl
   asl
   sta vsm_b1 //; store the result temporarily.
   lda $d018  //; read the register.
   and #$0f   //; preserve the low nybble, clear the high nybble.
   ora vsm_b1 //; patch in the adjusted parameter value.
   sta $d018  //; write to the register.
   rts

vsm_b1: .byte 0

/*
;---------------------------------------------------------------------
; returns the current Screen Matrix slot number.
;
; parameters: none.
; returns: A = active Screen Matrix slot number (0-15).
;---------------------------------------------------------------------
*/

vic_get_vmatrix:

   lda $d018  
   lsr   //; move the value to the low nybble...
   lsr
   lsr
   lsr
   rts

/*
;-----------------------------------------------------------------------------
; returns the active Screen Matrix address (high byte).
;
; parameters: none.
; returns: A = high byte of active Screen Matrix.
;-----------------------------------------------------------------------------
*/

vic_get_vmatrixaddress:

   jsr vic_get_bank
   asl   //; multiply by 16384...
   asl   //; we can just shift the bank number (0-3) left 6 places..   
   asl   //; as the result will be treated as a (16-bit) high nybble doing this is 
   asl   //; equivalent to shifting 14 (8+6) places left, ie. x 16384.
   asl
   asl
   sta vgma_b1

   jsr vic_get_vmatrix
 
   asl   //; multiply by 1024, just shift the matrix number (0-f) left 2 places..
   asl   //; this is equivalent to shifting 10 (8+2) places left, ie. x 1024.
   sta vgma_b2

   lda vgma_b1
   clc
   adc vgma_b2
   rts

vgma_b1: .byte 0
vgma_b2: .byte 0

/*
;--------------------------------------------------
; selects a 2KB character set.
;
; parameters: A = character set (0-7).
; returns: none.
;--------------------------------------------------
*/

vic_set_charset:

   and #7     //; ensure only a 3-bit parameter value (0-7).
   asl        //; shift the parameter value left one binary place.
   sta vsc_b1 //; store the result temporarily.
   lda $d018  //; read the register.
   and #$f0   //; preserve the upper nybble, clear the lower nybble.
   ora vsc_b1 //; patch in the adjusted parameter value.
   sta $d018  //; write to the register.
   rts

vsc_b1: .byte 0

/*
;-------------------------------------------------
; selects an 8KB bitmap image.
;
; parameters: A = bitmap image (0 or 1).
; returns: none.
;-------------------------------------------------
*/

vic_set_bitmap:

   and #1     //; ensure only a 1-bit parameter value (0 or 1).
   asl        //; shift the parameter left 3 binary places...
   asl       
   asl
   sta vsi_b1 //; store the result temporarily.
   lda $d018  //; read the register. 
   and #$f0   //; preserve the upper nybble, clear the lower nybble.
   ora vsi_b1 //; patch in the adjusted parameter value.
   sta $d018  //; write to the register.
   rts

vsi_b1: .byte 0

/*
;-----------------------------------------------------------------------------------
; fills the colour matrix with a specified colour (nybble) value.
;
; nb. this fills only the 1000 "visible" nybbles of the (1024 * 4-bit) colour matrix. 
;
; parameters: A = colour (0-15).
; returns: none.
;-----------------------------------------------------------------------------------
*/

vic_fill_cmatrix:

     ldx #250    //; nb. the used counter values are 250 down to 1...   
vfc0: sta $d7ff,x //; instead of 249 down to 0...
     sta $d8f9,x //; this allows for a small code optimization.
     sta $d9f3,x //; in the final comparison (just a bne needed).
     sta $daed,x //; part of which is these addresses being one less than expected.
     dex         //; as this loop runs 250 times it makes a difference.
     bne vfc0    //; nb. can't use bpl as values 128 to 255 will be interpreted as negative (-128 to -1).
     rts
/*
;------------------------------------------------------------------------------
; fills the active video matrix with a specified byte value.
;
; nb. this fills only the 1000 "visible" bytes of the 1KB video matrix. 
;
; parameters: A = value.
; returns: none.
;------------------------------------------------------------------------------
*/
vic_fill_vmatrix:

     sta vfv_b0 //; save the parameter.

     lda #0 //; create a pointer to the active video matrix in zero page ($02,$03)...
     sta $02
     jsr vic_get_vmatrixaddress
     sta $03

     ldx #4  //; fill the matrix (4 x 250 = 1000 bytes)...
vfv0: ldy #0
     lda vfv_b0
vfv1: sta ($02),y
     iny
     cpy #250
     bne vfv1

     lda $02
     clc
     adc #250
     sta $02
     bcc vfv2
     inc $03

vfv2: dex
     bne vfv0
     rts

vfv_b0: .byte 0

/*
;------------------------------------------------------------------------
; fills the active video matrix with ascending values.
;
; nb. this fills only the 1000 "visible" bytes of the 1KB video matrix.
;
; parameters: none.
; returns: none.
;------------------------------------------------------------------------
*/

vic_test_vmatrix:

     lda #0 //; create a pointer to the active video matrix in zero page ($02,$03)...
     sta $02
     jsr vic_get_vmatrixaddress
     sta $03

     ldx #4 // ; fill the matrix (4 x 250 = 1000 bytes)...
vtv0: ldy #0
vtv1: tya
     sta ($02),y
     iny
     cpy #250
     bne vtv1

     lda $02
     clc
     adc #250
     sta $02
     bcc vtv2
     inc $03

vtv2: dex
     bne vtv0
     rts
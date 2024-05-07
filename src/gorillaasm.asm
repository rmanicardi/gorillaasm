//*= $0801 "Basic Upstart" 
BasicUpstart2(main)    // 10 sys$0810

    //*=$0810 "Main" 
main: 
    .const CLEAR_SCREEN = $E544 //  https://skoolkid.github.io/sk6502/c64rom/asm/E544.html
    .const VICII_MEMORY = $D000
    .const SP0X = VICII_MEMORY
    .const SP0Y = VICII_MEMORY+1
    .const SPRITE_POINTER = $07F8 // Default sprite pointer
    .const SPRITE_ENABLER_REGISTER = $D015
    .const SPRITE0_COLOR = $D027
    .const MSBX = $D010
    .const SCNKEY = $FF9F
    .const GETIN  =  $FFE4
    .const SCREEN_RAM = $0400

    jsr CLEAR_SCREEN




    lda #01 // activate sprite 0 (bitmask 00000001)
    sta SPRITE_ENABLER_REGISTER

    lda #08 // setting red to sprite0
    sta SPRITE0_COLOR



    ldx #0
    lda #0


   // start building the screen
    ldx #0 // jump the first two bytes (backgound and foreground color)
    lda #0
    .const SCREEN_01_DATA = duomo_map + 2 // set origin of background data 

    lda duomo_map  // set border color to black
    sta VICII_MEMORY + $20  // boder color ( $D020 )
build_screen:                 // build background (charset based as declared in screen.asm)
    lda SCREEN_01_DATA,X      // copy first chunk of 256 bytes in video ram 
    sta SCREEN_RAM,X
    lda SCREEN_01_DATA+$100,X // copy second chunk of 256 bytes in video ram 
    sta SCREEN_RAM+$100,X
    lda SCREEN_01_DATA+$200,X  // copy third chunk of 256 bytes in video ram
    sta SCREEN_RAM+$200,X
    lda SCREEN_01_DATA+$2e8,X // copy fourth chunk of 256 bytes in video ram
    sta SCREEN_RAM+$2e8,X
    inx 
    bne build_screen
    ldx #0
    lda #0 

    lda #0
    sta MSBX

set_sprite_positions:
    lda #192 
    sta SPRITE_POINTER
    ldx #60
    ldy #151
    stx SP0X
    sty SP0Y

   




scan:
    jsr SCNKEY
    jsr GETIN

start:
    cmp #13 //check ENTER is pressed
    beq end
    cmp #145 //check ARROW UP is pressed
    beq move_sprite_up
    jmp scan

move_sprite_up:
    ldx SP0Y
    dex
    stx SP0Y
    stx SCREEN_RAM
    lda #$00
    sta $C6
    jmp scan


end:
    jsr CLEAR_SCREEN
    lda #0
    sta SPRITE_ENABLER_REGISTER
    rts

#import "charpad_vic_lib.asm"

    * = $3000 "Data"
    /*
        Offest for sprite pointers (value of SPRITE_POINTER): Sprite memory slot in $3000 (64 bytes/sprite * 192 ($C0))
        -192 : gorilla arms down
        -193 : gorilla left arm raised
        -194 : gorilla right arm raised
        -195 : banana
    */
data:
    .import binary "../resources/sprites/gorilla_arms_down.bin"
    .import binary "../resources/sprites/gorilla_left_arm_raised.bin"
    .import binary "../resources/sprites/gorilla_right_arm_raised.bin"
    .import binary "../resources/sprites/banana.bin"
    #import "../build/resources/duomo.asm"

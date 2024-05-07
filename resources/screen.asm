

// PETSCII memory layout (example for a 40x25 screen)'
// byte  0         = border color'
// byte  1         = background color'
// bytes 2-1001    = screencodes'
// bytes 1002-2001 = color

screen_001:
.byte 0,6
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,233,223,233,223,32,32,160,160,32,32,233,223,233,223,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,160,160,160,160,32,32,160,160,32,32,160,160,160,160,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,160,160,160,160,32,32,160,160,32,32,160,160,160,160,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,160,160,160,160,32,233,160,160,223,32,160,160,160,160,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,160,160,160,160,233,160,160,160,160,223,160,160,160,160,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,233,223,32,32,32,32,160,160,160,160,160,160,160,160,160,160,160,160,160,160,32,32,233,223,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,160,160,32,32,32,32,160,160,160,160,160,160,160,160,160,160,160,160,160,160,32,32,160,160,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,160,160,32,32,32,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,32,32,160,160,32,32,32,32,32,32,32,32
.byte 32,233,223,233,223,32,32,32,160,160,32,32,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,223,32,160,160,32,32,32,233,223,233,223,32
.byte 32,160,160,160,160,32,32,32,160,160,32,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,223,160,160,32,32,32,160,160,160,160,32
.byte 32,160,160,160,160,32,32,32,160,160,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,32,32,32,160,160,160,160,32
.byte 32,160,160,160,160,32,32,32,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,32,32,32,160,160,160,160,32
.byte 32,160,160,160,160,32,32,32,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,223,32,32,160,160,160,160,32
.byte 32,160,160,160,160,32,32,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,223,32,160,160,160,160,32
.byte 32,160,160,160,160,32,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,223,160,160,160,160,32
.byte 32,160,160,160,160,233,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,160,160,160,160,160,135,143,146,137,140,140,129,160,192,160,130,153,160,146,143,130,133,146,148,143,182,180,160,168,178,176,177,185,169,160,160,160,160,160
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,14,14,1,1,14,14,1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,14,1,1,1,14,14,1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,14,1,1,1,14,1,1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,1,1,1,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1,1,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,1,1,1,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1,1,14,14,14,14,14,14,14,14
.byte 14,14,14,14,14,14,14,14,1,1,1,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1,1,14,14,14,14,14,14,14,14
.byte 14,1,1,1,1,1,14,14,1,1,1,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,1,1,14,14,14,1,1,1,1,14
.byte 14,1,1,1,1,1,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,14,1,1,1,1,14
.byte 14,1,1,1,1,1,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,14,1,1,1,1,14
.byte 14,1,1,1,1,1,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,14,1,1,1,1,14
.byte 14,1,1,1,1,1,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1,1,1,1,14
.byte 14,1,1,1,1,1,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,1,1,1,1,14
.byte 14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14
.byte 14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte 14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

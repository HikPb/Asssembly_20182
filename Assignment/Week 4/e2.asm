.text

li $s0,0xfa3f001d
andi $t0, $s0,0xff000000
srl $t1, $t0, 24
andi $s0, 0xffffff00
ori $s0, 0x000000ff
and $s0, $s0, $0
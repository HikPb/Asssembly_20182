# Thuc hanh KTMTw2_20160300
.text

# E1 Gan so 16 bit
	addi $s0, $zero, 0x3007
	add $s0, $zero, $0

# E2 Gan so 32 bit
	lui $s0, 0x2110
	ori $s0, 0x003d

# E3 Gia lenh
	li $s0, 0x2110003d
	li $s0, 0x2

# E4 Tinh bieu thuc Z=2X+Y
	addi $t1, $zero, 5
	addi $t2, $zero, -1
	add $s0, $t1, $t1
	add $s0, $s0, $t2

# E5 Phep nhan
	addi $t1, $zero, 4
	addi $t2, $zero, 5
	mul $s0, $t1, $t2
	mul $s0, $s0, 3
	mflo $s1

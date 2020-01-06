.eqv SCREEN 	0x10010000	#Man hinh bitmap	
.eqv RED 	0x00FF0000
.eqv BACKGROUND 	0x00000000
.eqv KEY_A 	0x00000061
.eqv KEY_S	0x00000073
.eqv KEY_D	0x00000064
.eqv KEY_W	0x00000077
.eqv KEY_Q	0x00000071
.eqv KEY_E	0x00000065
.eqv KEY_ENTER	0x0000000a
.eqv DELTA_X	10
.eqv DELTA_Y	10
.eqv DELAY_TIME	100
.eqv KEY_CODE	0xFFFF0004	#Ki tu go vao
.eqv KEY_READY	0xFFFF0000	#Kiem ki tu da san sang de doc chua


#	Ham delay
#	Dung he thong 1 khoang thoi gian DELAY_TIME ( tinh bang mili giay)
.macro delay	
 	li $a0, DELAY_TIME
 	li $v0, 32
 	syscall
.end_macro	
.macro branchIfLessOrEqual(%r1, %r2, %branch)
	sle $v0, %r1, %r2	#	moveToLeft
 	bnez $v0, %branch
.end_macro	 
.macro setColorAndDrawCirle(%color)
	li $s5, %color	#	Dat mau 
 	jal drawCircle		#	de xoa duong tron cu.
.end_macro  

.macro addToStack3(%r1, %r2, %r3)
	add $sp, $sp, -12
	sw %r1, 0($sp)
	sw %r2, 4($sp)
	sw %r3, 8($sp)
.end_macro
.macro addToStack4(%r1, %r2, %r3, %r4)
	add $sp, $sp, -16
	sw %r1, 0($sp)
	sw %r2, 4($sp)
	sw %r3, 8($sp)
	sw %r4, 12($sp)
.end_macro
.macro getFromStack3(%r1, %r2, %r3)
	lw %r1, 0($sp)
 	lw %r2, 4($sp)
 	lw %r3, 8($sp)
 	add $sp, $sp, 12
.end_macro
.macro getFromStack4(%r1, %r2, %r3, %r4)
	lw %r1, 0($sp)
 	lw %r2, 4($sp)
 	lw %r3, 8($sp)
 	lw %r4, 12($sp)
 	add $sp, $sp, 16
.end_macro
.kdata
	CIRCLE_DATA: 	.space 512
.text
 li $s0, 256	# Xo = 256		Toa do X cua tam duong tron
 li $s1, 256	# Yo = 256		Toa do Y cua tam duong tron
 li $s2, 24	# R = 24 		Ban kinh cua tam duong tron
 li $s3, 512	# SCREEN_WITH = 512	Be ngang man hinh
 li $s4, 512	# SCREEN_HEIGHT = 512	Chieu cao man hinh
 li $s5, RED		#	Dat mau hinh tron la mau van
 mul $s6, $s2, $s2		#	R^2
 li $s7, 0		#	dx = 0
 li $t8, DELTA_Y	#	dy = 10
 
 
 
 jal circleInit
 
 gameLoop:
 readKeyboard:
 	lw $k1, KEY_READY #Vong lap cho ban phim san sang
 	beqz $k1, positionCheck
 	nop 
 	lw $k0, KEY_CODE	#Doc ky tu ban phim
 	beq $k0, KEY_A, case_a	#Kiem tra nut A
 	beq $k0, KEY_S, case_s	#Kiem tra nut S
 	beq $k0, KEY_D, case_d	#Kiem tra nut D
 	beq $k0, KEY_W, case_w	#Kiem tra nut W
 	beq $k0, KEY_Q, case_q	#Kiem tra nut Q
 	beq $k0, KEY_E, case_e	#Kiem tra nut Q
 	beq $k0, KEY_ENTER, case_enter #Kiem tra nut ENTER
 	j positionCheck
 case_a:
 	jal moveToLeft
 	j positionCheck
 case_s:
 	jal moveToDown
 	j positionCheck
 case_d:
 	jal moveToRight
 	j positionCheck
 case_w:
 	jal moveToUp
 	j positionCheck
 case_q:
 	addi $s2,$s2,6
 	mul $s6,$s2,$s2
 	setColorAndDrawCirle(BACKGROUND)
 	jal circleInit
 	
 	j draw
 case_e:
 	subi $s2,$s2,6
 	mul $s6,$s2,$s2
 	setColorAndDrawCirle(BACKGROUND)
 	jal circleInit
 	
 	j draw
 case_enter: 
 	j endProgram
 	
 positionCheck:		
 checkRightEdge:
 	add $v0, $s0, $s2	# 
 	add $v0, $v0,$s7	# If Xo + R + DELTA_X > SCREEN_WIDTH Then
 	branchIfLessOrEqual($v0, $s3, checkLeftEdge)	#	moveToLeft
 	jal moveToLeft	#
 	nop
 checkLeftEdge:
 	sub $v0, $s0, $s2	#
 	add $v0, $v0, $s7	# # If Xo - R + DELTA_X < 0 then moveToRight
 	branchIfLessOrEqual($zero, $v0, checkTopEdge)	 	
 	jal moveToRight	#
 	nop
 checkTopEdge:
 	sub $v0, $s1, $s2	#
 	add $v0, $v0, $t8	#
 	branchIfLessOrEqual($zero, $v0, checkBottomEdge)	# If Yo - R + DELTA_Y < 0 then moveToDown
 	jal moveToDown	#
 	nop
 checkBottomEdge:
 	add $v0, $s1, $s2	#
 	add $v0, $v0, $t8	#
 	branchIfLessOrEqual($v0, $s4, draw)	# If Yo + R + DELTA_Y > SCREEN_HEIGHT then
 	jal moveToUp	#
 	nop


 		
 draw: 	
 	setColorAndDrawCirle(BACKGROUND) # Ve duong tron trung mau nen
 	add $s0, $s0, $s7	#	Cap nhat toa do moi
 	add $s1, $s1, $t8	#	cua duong tron
 
 	setColorAndDrawCirle(RED) # Ve duong tron moi
 	delay		#	Dung chuong trinh 1 khoang
 	j gameLoop
 	
endProgram:
	setColorAndDrawCirle(BACKGROUND)
 	li $v0, 10
 	syscall
 
 	


 #
 #	Ham khoi dong duong tron
 # 	Tao mang du lieu luu toa do cac diem cua duong tron
circleInit: 
	addToStack4($ra, $t0, $t3, $t5)

	li $t0, 0		# i = 0
	la $t5, CIRCLE_DATA
loop:	slt $v0, $t0, $s2	# i -> R
	beqz $v0, end_circleInit
	mul $t3, $t0, $t0	# i^2
	sub $t3, $s6, $t3	# $t3 = R^2 - i^2
	move $v0, $t3
	jal sqrt
	sw $a0, 0($t5)		# Luu j = sqrt(R^2 - i^2) vao mang du lieu
	addi $t0, $t0, 1
	add $t5, $t5, 4
	j loop
end_circleInit:
	getFromStack4($ra, $t0, $t3, $t5)
	jr $ra
 
 
#
#	Ham ve diem tren duong tron
# 	Ve dong thoi 2 diem (X0 + i, Y0 +j ) va (Xo + j, Xo + i)
#	@param i = $a0, j = $a1
 drawCirclePoint:
 	addToStack3($t1, $t2, $t4)

 	
 	add $t1, $s0, $a0 	# Xi = Xo + i
	add $t4, $s1, $a1	# Yi = Y0 + j
	mul $t2, $t4, $s3	# Yi * SCREEN_WITH
	add $t1, $t1, $t2	# Yi * SCREEN_WITH + Xi (Toa do 1 chieu cua diem anh)
	sll $t1, $t1, 2		# Dia chi tuong doi cua diem anh
	sw $s5, SCREEN($t1)	# Draw anh
	add $t1, $s0, $a1 	# Xi = Xo + j
	add $t4, $s1, $a0	# Yi = Y0 + i
	mul $t2, $t4, $s3	# Yi * SCREEN_WITH
	add $t1, $t1, $t2	# Yi * SCREEN_WITH + Xi (Toa do 1 chieu cua diem anh)
	sll $t1, $t1, 2		# Dia chi tuong doi cua diem anh
	sw $s5, SCREEN($t1)	# Draw anh
	
	getFromStack3($t1, $t2, $t4)
	jr $ra
 
#	Ham ve duong tron
#	Su dung du lieu o mang CIRCLE_DATA tao boi ham khoidong_Duong tron
#	Ve tung 1/4 cua duong tron	
 drawCircle:

	addToStack4($ra, $t0, $t1, $t3)
 	li $t0, 0	# init i = 0
 loop_drawCircle:
  	slt $v0, $t0, $s2
 	beqz $v0,  end_drawCircle
	
	sll $t1, $t0, 2
	lw $t3, CIRCLE_DATA($t1) # Load j to $t3	 
	
 	move $a0, $t0	# $a0 = i
	move $a1, $t3	# $a1 = j
	jal drawCirclePoint	# Draw (Xo + i, Yo + j), (Xo + j, Yo + i)
	sub $a1, $zero, $t3
	jal drawCirclePoint	# Draw (Xo + i, Yo - j), (Xo + j, Yo - i)
	sub $a0, $zero, $t0
	jal drawCirclePoint	# Draw (Xo - i, Yo - j), (Xo - j, Yo - i)
	add $a1, $zero, $t3
	jal drawCirclePoint	# Draw (Xo - i, Yo + j), (Xo - j, Yo + i)
	
	addi $t0, $t0, 1
	j loop_drawCircle
 end_drawCircle:
 
	getFromStack4($ra, $t0, $t1, $t3)	
 	jr $ra


 				
 				 				
 # Ham tinh can bac hai				 				 				 				
 # $v0 = S, $a0 = sqrt(S)
sqrt: 
	mtc1 $v0, $f0
	cvt.s.w $f0, $f0
	sqrt.s $f0, $f0
	cvt.w.s $f0, $f0
	mfc1 $a0, $f0
	jr $ra
	


#	Cac ham di chuyen
moveToLeft:
	li $s7, -DELTA_X
 	li $t8, 0
	jr $ra 	
moveToRight:
	li $s7, DELTA_X
 	li $t8, 0
	jr $ra 	
moveToUp:
	li $s7, 0
 	li $t8, -DELTA_Y
	jr $ra 	
moveToDown:
	li $s7, 0
 	li $t8, DELTA_Y
	jr $ra 
	
 
 

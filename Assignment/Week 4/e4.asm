.text
li $s1, 0x80000000
li $s2, 0x80000000
start:
li $t0,0 #No Overflow is default status
addu $s3,$s1,$s2 # s3 = s1 + s2
xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
bltz $t1,EXIT #If not, exit
xor $t2, $s3,$s1
beq $t2,$zero,EXIT #s1 and $s2 are positive
li $t0,1 #the result is overflow
EXIT:
.data
dao: .space 20 
string: .space 20 
Message1: .asciiz " Nhap xau: "
.text
getString:
	li $v0, 8
 	la $a0, string
 	la $a1, 20
 	#li $a2, 20
 	syscall 
 get_length: 	
	la $a0, string # a0 = Address(string[0])
 	xor $t0, $zero, $zero # t0 = i = 0
 check_char:
	add $t1, $a0, $t0 # t1 = a0 + t0 #= Address(string[0]+i)
	lb $t2, 0($t1) # t2 = string[i]
 	beq $t2,$zero,end_of_str # Is null char?
	addi $t0, $t0, 1 # t0=t0+1->i = i + 1
 	j check_char
end_of_str:
la $a1, dao
add $s1, $0, $0
addi $s0,$t0,-1 #s0 = i=0
daokytu:
L1:
	add $t1,$s0,$a0 #t1 = s0 + a0 = i + string[0] # = address of y[i]
	lb $t2,0($t1) #t2 = value at t1 = string[i]
	add $t3,$s1,$a1 #t3 = s0 + a1 = i + dao[0] # = address of dao[i]
	sb $t2,0($t3) #dao[i]= t2 = string[i]
	beq $t2,$zero,end_of_daokytu #if y[i]==0, exit
	nop
	addi $s1,$s1,1
	addi $s0,$s0,-1 #s0=s0 + 1 <-> i=i-1
	j L1 #next character
	nop
end_of_daokytu:
li $v0, 4
la $a0, dao
syscall
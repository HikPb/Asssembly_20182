.data

.text
	#ass1
	addi   $s0, $zero, 0x3007 # $s0 = 0 + 0x3007 = 0x3007 ;I-type  add    $s0, $zero, $0     # $s0 = 0 + 0 = 0           ;R-type 
	add    $s0, $zero, $0     # $s0 = 0 + 0 = 0           ;R-type 
	
	#ass2
	
	li $s0, 3
nhan:
	addi $t1, $zero, 5
	addi $t2, $zero, 10
	add $t3, $t1, $t2
	addi $t4, $zero, 20

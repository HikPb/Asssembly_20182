#Laboratory Exercise 3, Assignment 1
.data
i: .word 1
.text
la $t0, i
lw $s1,0($t0) 
li $s2, 0
start:
slt $t0,$s2,$s1 # j<i
bne $t0,$zero,else # branch to else if j<i
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
nop
else: addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif:
#_____________________________________________
#Laboratory 3, Assigment 2
.data
A: .word 10 20 100 30
.text
li $s1, 0 # bien i
li $s4, 1 # step
li $s3, 4 # so ptu mang
li $s5, 0 # sum
li $s2, 4 #so byte cua A
la $t1, A
loop: add $s1,$s1,$s4 #i=i+step
lw $t0,0($t1) #load value of A[i] in $t0
add $s5,$s5,$t0 #sum=sum+A[i]
add $t1,$t1,$s2 #t1 store the address of A[
bne $s1,$s3,loop #if i != n, goto loop
#_____________________________________________
#Laboratory Exercise 3, Home Assignment 3
.data
test: .word 1
.text
la $s0, test #load the address of test variable
lw $s1, 0($s0) #load the value of test to register $t1
li $t0, 0 #load value for test case
li $t1, 1
li $t2, 2
beq $s1, $t0, case_0
beq $s1, $t1, case_1
beq $s1, $t2, case_2
j default
case_0: addi $s2, $s2, 1 #a=a+1
j continue
case_1: sub $s2, $s2, $t1 #a=a-1
j continue
case_2: add $s3, $s3, $s3 #b=2*b
j continue
default:
continue:
#_____________________________________________
#Home Assignment 4a
start:
addi $s1,$zero,10       #  i=10
addi $s2,$zero,5      	#  j=5
slt $t0,$s1,$s2    	# i<j
beq $t0,$zero,else   	# branch to else if j<i
addi $t1,$t1,1          # then part: x=x+1
addi $t3,$zero,1 	# z=1
j endif                 # skip “else” part
else:
addi $t2,$t2,-1 	# begin else part: y=y-1
      	add $t3,$t3,$t3 # z=2*z
 endif:
#Home Assignment 4b
start:
addi $s1,$zero,10      	#  i=10
addi $s2,$zero,5      	#  j=5
slt $t0,$s1,$s2    	# i<j
bne $t0,$zero,else   	# branch to else if j<i
addi $t1,$t1,1         	# then part: x=x+1
addi $t3,$zero,1 	# z=1
j endif                 # skip “else” part
else:
addi $t2,$t2,-1 	# begin else part: y=y-1
      	add $t3,$t3,$t3 # z=2*z
 endif:
#Home Assignment 4c
 
start:
      	addi $s1,$zero,-10	#  i=10
      	addi $s2,$zero,5      	#  j=5

      	add $t4,$s1,$s2        	# t4=i+j

      	slt $t0,$zero,$t4 	# i<j
      	bne $t0,$zero,else   	# branch to else if j<i
      	addi $t1,$t1,1         	# then part: x=x+1
      	addi $t3,$zero,1 	# z=1
      	j endif                 # skip “else” part
else:
      	addi $t2,$t2,-1 	# begin else part: y=y-1
      	add $t3,$t3,$t3    	# z=2*z
 endif:
#Home Assignment 4d
 
start:
addi $s1,$zero,10     	#  i=10
addi $s2,$zero,5      	#  j=5
addi $s3,$zero,1      	#  m=1
addi $s4,$zero,2      	#  n=2
 
add $t4,$s1,$s2        	# t4=i+j
add $t5,$s3,$s4         # t5=m+n
 
slt $t0,$t5,$t4  	# i<j
beq $t0,$zero,else   	# branch to else if j<i
addi $t1,$t1,1          # then part: x=x+1
addi $t3,$zero,1 	# z=1
j endif               	# skip “else” part
else:
addi $t2,$t2,-1 	# begin else part: y=y-1
      	add $t3,$t3,$t3 # z=2*z
 endif:
#_____________________________________________
#Laboratory Exercise 3, Assignment 5

#5a.	i < n:
.data
	A: .word 10 20 30 40
.text
	
	li $s1,0 #bien
	li $s4,1 #step
	li $s3,4 #so pt mang
	li $s5,0 #max
	li $s2,4 #so byte cua A
	la $t1,A
.text
	loop: add $s1,$s1,$s4 #i=i+step
	lw $t0,0($t1) #load value of A[i] in $t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	add $t1,$t1,$s2 #t1 store the address of A[i]
	slt $t2,$s1,$s3
	beq $t2,$zero,loop
#5b.	i <= n:
.data
	A: .word 10 20 30 40
.text
	
	li $s1,0 #bien
	li $s4,1 #step
	li $s3,4 #so pt mang
	li $s5,0 #max
	li $s2,4 #so byte cua A
	la $t1,A
.text
	loop: add $s1,$s1,$s4 #i=i+step
	lw $t0,0($t1) #load value of A[i] in $t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	add $t1,$t1,$s2 #t1 store the address of A[i]
	slt $t2,$s3,$s1
	bne $t2,$zero,loop
#5c.	sum >= 0:
.data
	A: .word 10 20 30 40
.text
	
	li $s1,0 #bien
	li $s4,1 #step
	li $s3,4 #so pt mang
	li $s5,0 #max
	li $s2,4 #so byte cua A
	la $t1,A
.text
	loop: add $s1,$s1,$s4 #i=i+step
	lw $t0,0($t1) #load value of A[i] in $t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	add $t1,$t1,$s2 #t1 store the address of A[i]
	slt $t2,$s5,$zero
	bne $t2,$zero,loop
#5d.	A[i] == 0:
.data
	A: .word 10 20 30 40
.text
	
	li $s1,0 #bien
	li $s4,1 #step
	li $s3,4 #so pt mang
	li $s5,0 #max
	li $s2,4 #so byte cua A
	la $t1,A
.text
	loop: add $s1,$s1,$s4 #i=i+step
	lw $t0,0($t1) #load value of A[i] in $t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	add $t1,$t1,$s2 #t1 store the address of A[i]
	bne $t0,$zero,loop
#___________________________________________________
#Laboratory 3, Assigment 6
.data
A: .word 10 20 100 30
.text
li $s1, 0 # bien i
li $s4, 1 # step
li $s3, 4 # so ptu mang
li $s5, 0 # max
li $s2, 4 #so byte cua A
la $t1, A
loop: add $s1,$s1,$s4 #i=i+step
lw $t0, 0($t1)
start:
	slt $t3,$s5,$t0 # j<i
	bne $t3,1,endif
	add $s5,$zero,$t0 #maxA[i]
endif:
add $t1,$t1,$s2 #t1 store the address of A[
bne $s1,$s3,loop #if i != n, goto loop

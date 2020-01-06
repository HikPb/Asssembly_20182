.data
mess1: .asciiz "Gia tri lon nhat la: "
mess2: .asciiz  "Gia tri nho nhat la: "
.text
 li $s0, 2 #load test input
 li $s1, 6
 li $s2, -1
 li $s3, 9
 li $s4, 1
 li $s5, 5
 li $s6, -3
 li $s7, 0
 push: addi $sp,$sp,-32 #adjust the stack pointer
 sw $s0,28($sp) #push $s0 to stack
 sw $s1,24($sp) #push $s1 to stack
 sw $s2,20($sp)
 sw $s3,16($sp)
 sw $s4,12($sp)
 sw $s5,8($sp)
 sw $s6,4($sp)
 sw $s7,0($sp)
work:
 nop
#pop: lw $s0,0($sp) #pop from stack to $s0
 #lw $s1,4($sp) #pop from stack to $s1
 #addi $sp,$sp,8 #adjust the stack pointer

main:
 la $a0,($sp)
 lw $v0,($a0) #v0 luu gia tri max tam thoi
 lw $t3,($a0) #v2 luu gia tri min tam thoi
 jal loopmax #call max procedure
 nop
 add $a2, $v0, $0 # $a2 luu gia tri max
 add $a3, $t3, $0 # $a3 luu gia tri min
 
 li $v0,56 #terminate
 la $a0 , mess1
 add $a1, $0,$a2
 syscall
 li $v0,56 #terminate
 la $a0 , mess2
 add $a1, $0,$a3
 syscall
 li $v0, 10
 syscall
endmain:
#---------------------------------------------------------------------
#Procedure max: find the largest of three integers
#param[in] $a0 integers
#param[in] $a1 integers
#param[in] $a2 integers
#return $v0 the largest value
#---------------------------------------------------------------------
loopmax: 
 sub $t0, $a0, 32
 beq $t0, $sp, done
 add $a0, $a0, 4
 lw $v1, 0($a0) #copy (a0) in v0; largest so far
 sub $t0,$v1,$v0 #compute (a1)-(v0)
 bltz $t0,L1 #if (a1)-(v0)<0 then no change
 nop
 add $v0,$v1,$zero #else (v1) is largest thus far
L1: sub $t1,$t3,$v1
 bltz $t1, L2 #if (a1)-(v0)<0 then no change
 nop
 add $t3,$v1,$0
L2: j loopmax
done: jr $ra #return to calling program



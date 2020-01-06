.text
li $s1, 1
li $s2, 2
# abs----------------------------------------------------

#or $s0, $zero, $s1      #copy r1 into r2
#slt $t0, $s1, $zero      #is value < 0 ?
#beq $t0, $zero, end  #if r1 is positive, skip next inst
#sub $s0, $zero, $s1      #r2 = 0 - r1
#end:

# move----------------------------------------------------

#or $s0, $0, $s1

# not-----------------------------------------------------

#nor $s0, $s1, $0

# ble-----------------------------------------------------

#slt $t0,$s2,$s1
#beq $t0,$0, L
#addi $s1,$s1,5
#L: addi $s2,$s2,2


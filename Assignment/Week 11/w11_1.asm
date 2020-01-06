.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main: li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t2, OUT_ADRESS_HEXA_KEYBOARD
 li $t3, 0x01 # check row 4 with key C, D, E, F 

polling: sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0, $0, check
 nop 
print: li $v0, 34 # print integer (hexa)
 syscall
 nop
sleep: li $v0, 32
 li $a0, 50 # sleep 100ms
 syscall 
 nop
check:
 slti $t4, $t3, 0x08 
 beq $t4, $0, L
 sll $t3,$t3,1
 j polling
 nop
L:li $t3, 0x01

back_to_polling: j polling # continue polling

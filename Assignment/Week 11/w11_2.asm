.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012 
.data
Message: .asciiz "Oh my god. Someone's presed a button.\n"
.text
main:
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x80 # bit 7 of = 1 to enable interrupt Ha Noi University of Science and Technology
 sb $t3, 0($t1)
Loop: nop
 nop
 nop
 nop
 b Loop # Wait for interrupt
end_main:

.ktext 0x80000180 

IntSR: addi $v0, $zero, 4 # show message 
 la $a0, Message
 syscall
 nop
next_pc:mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 addi $at, $at, 4 # $at = $at + 4 (next instruction)
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at 
return: eret # Return from exception
 
.data
mess1: .asciiz "Tong cua "
mess2: .asciiz " va "
mess3: .asciiz " la: "

.text
 li $s0, 5
 li $s1, 7
 add $t0, $s0, $s1
 li $v0, 4
 la $a0, mess1
 syscall
 li $v0, 1
 la $a0, ($s0)
 syscall
 li $v0, 4
 la $a0, mess2
 syscall
 li $v0, 1
 la $a0, ($s1)
 syscall
 li $v0, 4
 la $a0, mess3
 syscall
 li $v0, 1
 la $a0, ($t0)
 syscall 
 
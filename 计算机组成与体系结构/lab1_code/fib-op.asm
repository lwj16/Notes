## Daniel J. Ellard -- 02/27/94
## fib-o.asm-- A program to compute Fibonacci numbers.
## An optimized version of fib-t.asm.
## main--
## Registers used:
## $v0 - syscall parameter and return value.
## $a0 - syscall parameter-- the string to print.

.text
main:
    subu $sp, $sp, 32        # Set up main’s stack frame:
    sw $ra, 28($sp)
    sw $fp, 24($sp)
    addu $fp, $sp, 32

    ## Get n from the user, put into $a0.
    li $v0, 5                # load syscall read_int into $v0.
    syscall                  # make the syscall.
    move $a0, $v0            # move the number read into $a0.
    jal fib                  # call fib.

    move $a0, $v0
    li $v0, 1                # load syscall print_int into $v0.
    syscall                  # make the syscall.

    la $a0, newline
    li $v0, 4
    syscall                  # make the syscall.

    li $v0, 10               # 10 is the exit syscall.
    syscall                  # do the syscall.

## fib-- (hacked-up caller-save method)
## Registers used:
## $a0 - initially n.
## $t0 - parameter n.
## $t1 - fib (n - 1).
## $t2 - fib (n - 2).

.text
fib:
    bgt $a0, 1, fib_recurse  # if n < 2, then just return a 1,
    li $v0, 1                # don’t build a stack frame.
    jr $ra

# otherwise, set things up to handle
fib_recurse:                 # the recursive case:
    li  $t0, 0
    li  $t3, 0
    li  $t4, 1
    li  $t5, 1
loop:
    slt $t1, $t0, $a0
    beq $t1, 0, done
    add $t5, $t3, $t4
    move $t3, $t4
    move $t4, $t5
    addi $t0, $t0, 1
    j   loop
done:
    move $v0, $t5
    jr $ra
## data for fib-o.asm:
.data
newline: .asciiz "\n"
        .data

msg1:    .asciiz "Please enter 1st number: " 
msg2:   .asciiz  "Please enter 2nd number: "
msg3:   .asciiz  "The result of "
msg4:   .asciiz  " & "
msg5:   .asciiz  " is: "
msg6:   .asciiz  "\nDo you want to try another(0—continue/1—exit): "

        .text
        .globl main

main:
loop:
    li  $v0, 4
    la  $a0, msg1
    syscall

    li  $v0, 5
    syscall
    move    $t1, $v0

    li  $v0, 4
    la  $a0, msg2
    syscall

    li  $v0, 5
    syscall
    move    $t2, $v0

    add $t0, $t1, $t2

    li  $v0, 4
    la  $a0, msg3
    syscall

    li  $v0, 1
    move    $a0, $t1
    syscall

    li  $v0, 4
    la  $a0, msg4
    syscall

    li  $v0, 1
    move    $a0, $t2
    syscall

    li  $v0, 4
    la  $a0, msg5
    syscall

    li  $v0, 1
    move    $a0, $t0
    syscall

    li  $v0, 4
    la  $a0, msg6
    syscall

    li  $v0, 5
    syscall
    move    $t3, $v0

    bne $t3, $0, done
    j   loop
done:
    li  $v0, 10
    syscall
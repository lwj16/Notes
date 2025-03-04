        .data

arrs:   .word 9, 7, 15, 19, 20, 30, 11, 18  # 数组 arrs
N:      .word 8                          # 数组长度 N
msg:    .asciiz "The result is: "         # 输出的字符串

        .text
        .globl main

# sumn 函数: 计算数组元素的和
sumn:
        # 参数: $a0 -> arr, $a1 -> n
        # 返回值: $v0 -> sum

        move    $t0, $0        # sum = 0
        move    $t1, $0        # idx = 0

loop:
        slt     $t2, $t1, $a1
        beq     $t2, 0, done    # 如果 idx >= n, 结束循环
        sll     $t3, $t1, 2       # 计算 arr[idx] 的地址偏移 (idx * 4)
        add     $t3, $t3, $a0     # arr + (idx * 4)
        lw      $t4, 0($t3)       # 加载 arr[idx] 到 $t4
        add     $t0, $t0, $t4     # sum += arr[idx]
        addi    $t1, $t1, 1       # idx++
        j       loop              # 跳回循环开始

done:
        move    $v1, $t0        # 返回 sum
        jr      $ra
# main 函数
main:
        # 加载 arrs 和 N
        la      $a0, arrs         # $a0 = arrs (数组的地址)
        lw      $a1, N            # $a1 = N (数组的大小)

        # 调用 sumn 函数
        jal     sumn              # 调用 sumn，返回值在 $v0

        # 输出结果
        li      $v0, 4            # 系统调用号 4 (打印字符串)
        la      $a0, msg          # 加载 msg 地址
        syscall

        li      $v0, 1            # 系统调用号 1 (打印整数)
        move    $a0, $v1        # 打印 sumn 的返回值（在 $v1 中）
        syscall

        # 退出程序
        li      $v0, 10           # 系统调用号 10 (退出程序)
        syscall
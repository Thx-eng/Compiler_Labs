# my_test.s

.text                           # 代码段开始
.globl cal_sum                  # 声明 cal_sum 是一个全局符号，可以被其他文件调用
.globl main                     # 声明 main 是一个全局符号

cal_sum:
    # 为这个函数分配栈帧。我们需要保存两个8字节的值：
    # 1. 返回地址 (ra)，因为好习惯是总是保存它。
    # 2. s0 寄存器，因为我们将用它来存储变量 n，而 s0 是被调用者保存(callee-saved)寄存器。
    addi    sp, sp, -16         # 栈指针下移16字节 (sp = sp - 16)，分配空间
    sd      ra, 8(sp)           # 将返回地址 ra 保存到栈上 (地址 sp+8)
    sd      s0, 0(sp)           # 将 s0 的原始值保存到栈上 (地址 sp+0)

    # --- 函数体 (Body) ---
    mv      s0, a0              # 将传入的参数 n (在 a0) 移动到 s0 中保存起来
                                # 使用 s0 是因为它在循环中不会被破坏
    
    li      t0, 1               # t0 用作循环变量 i。初始化 i = 1
    li      t1, 0               # t1 用作累加和 sum。初始化 sum = 0

.L_loop_start:                  # 循环开始的标签
    # 循环条件: while (i <= n)
    # 汇编实现: if (i > n) then goto loop_end
    bgt     t0, s0, .L_loop_end # 如果 t0(i) > s0(n)，则跳转到循环结束标签

    # 循环体
    add     t1, t1, t0          # sum = sum + i
    addi    t0, t0, 1           # i = i + 1

    j       .L_loop_start       # 无条件跳转回循环开始

.L_loop_end:                    # 循环结束的标签
    # 准备返回值
    mv      a0, t1              # 将最终的 sum (在 t1) 移动到返回值寄存器 a0

    # --- 函数尾声 (Epilogue) ---
    # 恢复栈帧和寄存器到调用前的状态
    ld      s0, 0(sp)           # 从栈上恢复 s0 的原始值
    ld      ra, 8(sp)           # 从栈上恢复返回地址 ra
    addi    sp, sp, 16          # 释放栈空间 (sp = sp + 16)
    
    ret                         # 返回指令 (跳转到 ra 寄存器中的地址)


main:
    # main 函数调用了其他函数，所以 `call` 指令会修改 `ra` 寄存器。
    # 因此，我们必须在调用任何子函数之前保存 `ra`。
    addi    sp, sp, -16         # 分配16字节栈空间
    sd      ra, 8(sp)           # 保存返回地址 ra

    # --- 函数体 (Body) ---
    call    getint              # 调用 getint()。返回值 n 会被放入 a0

    # 此时 a0 中是 getint() 的返回值 n。
    # 下一个函数 cal_sum(n) 正好需要把参数 n 放在 a0 中。
    # 所以我们无需任何操作，直接调用即可。
    call    cal_sum             # 调用 cal_sum(a0)。返回值 result 会被放入 a0

    # 此时 a0 中是 cal_sum() 的返回值 result。
    # 下一个函数 putint(result) 正好需要把参数 result 放在 a0 中。
    # 再次无需任何操作，直接调用。
    call    putint              # 调用 putint(a0)

    # 准备 main 函数的返回值
    li      a0, 0               # return 0;

    # --- 函数尾声 (Epilogue) ---
    ld      ra, 8(sp)           # 从栈中恢复返回地址 ra
    addi    sp, sp, 16          # 释放栈空间
    
    ret                         # 从 main 函数返回
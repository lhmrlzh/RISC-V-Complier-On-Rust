.equ TEST_X_OFFSET, 0
.equ TEST_Y_OFFSET, 4
.equ TEST_SIZE, 8

.section .rodata
.LC0:
.string "x = %f, y = %f\n"

.text
.align 1
.globl main
.type main, @function
main:
    # 保存栈指针和帧指针
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    addi s0, sp, 16

    # 主体段
    # 按照线性结构存储结构体
    addi sp, sp, -TEST_SIZE
    li t0, 10
    fmv.w.x ft0, t0
    fsw ft0, TEST_X_OFFSET(sp)

    li t1, 20
    fmv.w.x ft1, t1
    fsw ft1, TEST_Y_OFFSET(sp)

    # 调用printf
    lui a5, %hi(.LC0)
    addi a0, a5, %lo(.LC0) # 装载字符串地址
    flw fa1, TEST_X_OFFSET(sp)
    flw fa2, TEST_Y_OFFSET(sp)
    call printf

    addi sp, sp, TEST_SIZE

    # 恢复栈指针和帧指针，return
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16

    jr ra

.size main, .-main # 提供函数大小
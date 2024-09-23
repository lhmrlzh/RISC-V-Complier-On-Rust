.equ TEST_X_OFFSET, 0
.equ TEST_Y_OFFSET, 8
.equ TEST_SIZE, 16

.section .rodata
.LC0:
.string "x = %lf, y = %lf\n"

.text
.align 1
.globl main
.type main, @function
main:
    # 保存栈指针和帧指针
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32

    # 主体段
    # 按照线性结构存储结构体
    addi sp, sp, -TEST_SIZE
    li t0, 0x4034000000000000 # 20.0 的 IEEE 754 双精度浮点数表示
    fmv.d.x ft0, t0
    fsd ft0, TEST_X_OFFSET(sp)

    li t1, 0x4024000000000000 # 10.0 的 IEEE 754 双精度浮点数表示
    fmv.d.x ft1, t1
    fsd ft1, TEST_Y_OFFSET(sp)

    # 调用printf
    lui a5, %hi(.LC0)
    addi a0, a5, %lo(.LC0) # 装载字符串地址
    fld fa0, TEST_X_OFFSET(sp) # 使用 fa0 传递第一个双精度浮点数参数
    fmv.x.d a1, fa0
    fld fa1, TEST_Y_OFFSET(sp) # 使用 fa1 传递第二个双精度浮点数参数
    fmv.x.d a2, fa1
    call printf

    addi sp, sp, TEST_SIZE

    # 恢复栈指针和帧指针，return
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32

    jr ra

.size main, .-main # 提供函数大小

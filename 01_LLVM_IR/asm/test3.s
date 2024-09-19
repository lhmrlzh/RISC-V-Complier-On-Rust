.section .rodata
.LC0: # "Hello World"的位置
    .string "Hello World"

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

    li t0, 0
    sw t0, -20(s0)
    li t1, 10
    sw t1, -24(s0)
    j L1

L0:
    lui a5, %hi(.LC0) # 由于立即数指令的数只能传20位，因此分别加载
    addi a0, a5, %lo(.LC0) # 加载低12位

    call puts
    lw t0, -20(s0)
    addi t0, t0, 1
    sw t0, -20(s0)

L1:
    lw t0, -20(s0)
    lw t1, -24(s0)
    bge t0, t1, L2
    j L0

L2:
    # 恢复栈指针和帧指针，return
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32

    jr ra
.size main, .-main # 提供函数大小

.section .rodata
.LC0: # "Hello World"的位置
    .string "Hello World"

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

    lui a5, %hi(.LC0) # 由于立即数指令的数只能传20位，因此分别加载
    addi a0, a5, %lo(.LC0) # 加载低12位

    call puts

    # 恢复栈指针和帧指针，return
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16

    jr ra

.size main, .-main # 提供函数大小

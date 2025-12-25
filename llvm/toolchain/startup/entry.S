.section .init

.option norvc

.extern _start

.type asm_start, @function
.global asm_start
asm_start:
    .cfi_startproc

.option push
.option norelax
    /* Initialize registers */
    xor x0, x0, x0
    mv x1, x0
    mv x2, x0
    mv x3, x0
    mv x4, x0
    mv x5, x0
    mv x6, x0
    mv x7, x0
    mv x8, x0
    mv x9, x0
    mv x11, x0
    mv x12, x0
    mv x13, x0
    mv x14, x0
    mv x15, x0
    mv x16, x0
    mv x17, x0
    mv x18, x0
    mv x19, x0
    mv x20, x0
    mv x21, x0
    mv x22, x0
    mv x23, x0
    mv x24, x0
    mv x25, x0
    mv x26, x0
    mv x27, x0
    mv x28, x0
    mv x29, x0
    mv x30, x0
    mv x31, x0

    la gp, global_pointer
.option pop

    /* Reset satp */
    # csrw satp, zero

    /* Setup stack */
    la sp, stack_top

    /* Clear the BSS section */
    la t5, bss_start
    la t6, bss_end
bss_clear:
    # sd zero, (t5)
    addi t5, t5, 8
    bgeu t5, t6, bss_clear

    la t0, _start
    # csrw mepc, t0

    /* Jump to _start function! */
    tail _start

    .cfi_endproc

.end

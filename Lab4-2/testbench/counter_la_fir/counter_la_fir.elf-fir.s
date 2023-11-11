	.file	"fir.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/chngh/Desktop/SOC_design/Lab4/lab4-2/lab-caravel_fir/testbench/counter_la_fir" "fir.c"
	.globl	taps
	.data
	.align	2
	.type	taps, @object
	.size	taps, 44
taps:
	.word	0
	.word	-10
	.word	-9
	.word	23
	.word	56
	.word	63
	.word	56
	.word	23
	.word	-9
	.word	-10
	.word	0
	.globl	reg_fir_x
	.section	.sbss,"aw",@nobits
	.align	2
	.type	reg_fir_x, @object
	.size	reg_fir_x, 4
reg_fir_x:
	.zero	4
	.globl	reg_fir_y
	.align	2
	.type	reg_fir_y, @object
	.size	reg_fir_y, 4
reg_fir_y:
	.zero	4
	.globl	output
	.align	2
	.type	output, @object
	.size	output, 4
output:
	.zero	4
	.section	.mprjram,"ax",@progbits
	.align	2
	.globl	initfir
	.type	initfir, @function
initfir:
.LFB0:
	.file 1 "fir.c"
	.loc 1 3 61
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
.LBB2:
	.loc 1 7 10
	sw	zero,-20(s0)
	.loc 1 7 2
	j	.L2
.L3:
	.loc 1 8 34 discriminator 3
	lw	a4,-20(s0)
	li	a5,201326592
	addi	a5,a5,8
	add	a5,a4,a5
	slli	a5,a5,2
	.loc 1 8 7 discriminator 3
	mv	a3,a5
	.loc 1 8 53 discriminator 3
	lui	a5,%hi(taps)
	addi	a4,a5,%lo(taps)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 1 8 47 discriminator 3
	sw	a5,0(a3)
	.loc 1 7 22 discriminator 3
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	.loc 1 7 16 discriminator 1
	lw	a4,-20(s0)
	li	a5,10
	ble	a4,a5,.L3
.LBE2:
	.loc 1 11 3
	li	a5,805306368
	addi	a5,a5,16
	.loc 1 11 31
	li	a4,64
	sw	a4,0(a5)
	.loc 1 13 12
	lui	a5,%hi(reg_fir_x)
	sw	zero,%lo(reg_fir_x)(a5)
	.loc 1 14 12
	lui	a5,%hi(reg_fir_y)
	sw	zero,%lo(reg_fir_y)(a5)
	.loc 1 15 12
	lui	a5,%hi(output)
	sw	zero,%lo(output)(a5)
	.loc 1 16 1
	nop
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	initfir, .-initfir
	.align	2
	.globl	fir
	.type	fir, @function
fir:
.LFB1:
	.loc 1 19 56
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 21 2
	call	initfir
	.loc 1 24 7
	nop
.L5:
	.loc 1 24 10 discriminator 1
	li	a5,805306368
	lw	a5,0(a5)
	.loc 1 24 37 discriminator 1
	andi	a4,a5,4
	.loc 1 24 44 discriminator 1
	li	a5,4
	bne	a4,a5,.L5
	.loc 1 26 34
	li	a5,805306368
	lw	a4,0(a5)
	.loc 1 26 3
	li	a5,805306368
	.loc 1 26 62
	ori	a4,a4,1
	.loc 1 26 31
	sw	a4,0(a5)
.LBB3:
	.loc 1 30 19
	li	s1,0
	.loc 1 30 2
	j	.L6
.L9:
	.loc 1 31 13
	lui	a5,%hi(reg_fir_x)
	sw	s1,%lo(reg_fir_x)(a5)
	.loc 1 34 8
	nop
.L7:
	.loc 1 34 11 discriminator 1
	li	a5,805306368
	lw	a5,0(a5)
	.loc 1 34 38 discriminator 1
	andi	a4,a5,16
	.loc 1 34 45 discriminator 1
	li	a5,16
	bne	a4,a5,.L7
	.loc 1 35 4
	li	a5,805306368
	addi	a5,a5,128
	.loc 1 35 32
	lui	a4,%hi(reg_fir_x)
	lw	a4,%lo(reg_fir_x)(a4)
	sw	a4,0(a5)
	.loc 1 39 8
	nop
.L8:
	.loc 1 39 11 discriminator 1
	li	a5,805306368
	lw	a5,0(a5)
	.loc 1 39 38 discriminator 1
	andi	a4,a5,32
	.loc 1 39 45 discriminator 1
	li	a5,32
	bne	a4,a5,.L8
	.loc 1 40 16 discriminator 2
	li	a5,805306368
	addi	a5,a5,132
	lw	a4,0(a5)
	.loc 1 40 13 discriminator 2
	lui	a5,%hi(reg_fir_y)
	sw	a4,%lo(reg_fir_y)(a5)
	.loc 1 30 29 discriminator 2
	addi	s1,s1,1
.L6:
	.loc 1 30 24 discriminator 1
	li	a5,63
	ble	s1,a5,.L9
.LBE3:
	.loc 1 43 12
	lui	a5,%hi(reg_fir_y)
	lw	a4,%lo(reg_fir_y)(a5)
	lui	a5,%hi(output)
	sw	a4,%lo(output)(a5)
	.loc 1 44 9
	lui	a5,%hi(output)
	addi	a5,a5,%lo(output)
	.loc 1 45 1
	mv	a0,a5
	lw	ra,12(sp)
	.cfi_restore 1
	lw	s0,8(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	lw	s1,4(sp)
	.cfi_restore 9
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1:
	.size	fir, .-fir
	.text
.Letext0:
	.file 2 "fir.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xf0
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x6
	.4byte	.LASF7
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL0
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x2
	.4byte	0x3d
	.4byte	0x36
	.byte	0x3
	.4byte	0x36
	.byte	0xa
	.byte	0
	.byte	0x7
	.byte	0x4
	.byte	0x7
	.4byte	.LASF2
	.byte	0x8
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.4byte	.LASF3
	.byte	0x7
	.4byte	0x26
	.byte	0x5
	.byte	0x3
	.4byte	taps
	.byte	0x1
	.4byte	.LASF4
	.byte	0x8
	.4byte	0x3d
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_x
	.byte	0x1
	.4byte	.LASF5
	.byte	0x9
	.4byte	0x3d
	.byte	0x5
	.byte	0x3
	.4byte	reg_fir_y
	.byte	0x2
	.4byte	0x3d
	.4byte	0x84
	.byte	0x3
	.4byte	0x36
	.byte	0
	.byte	0
	.byte	0x1
	.4byte	.LASF6
	.byte	0xa
	.4byte	0x74
	.byte	0x5
	.byte	0x3
	.4byte	output
	.byte	0x9
	.string	"fir"
	.byte	0x1
	.byte	0x13
	.byte	0x33
	.4byte	0xc4
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x1
	.byte	0x9c
	.4byte	0xc4
	.byte	0x4
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.byte	0x5
	.string	"i"
	.byte	0x1e
	.byte	0x13
	.4byte	0x3d
	.byte	0x1
	.byte	0x59
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x4
	.4byte	0x3d
	.byte	0xb
	.4byte	.LASF8
	.byte	0x1
	.byte	0x3
	.byte	0x33
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x1
	.byte	0x9c
	.byte	0x4
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.byte	0x5
	.string	"i"
	.byte	0x7
	.byte	0xa
	.4byte	0x3d
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x5
	.byte	0x49
	.byte	0x13
	.byte	0x3f
	.byte	0x19
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x1
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x1f
	.byte	0x1b
	.byte	0x1f
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL0:
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x6
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF2:
	.string	"unsigned int"
.LASF3:
	.string	"taps"
.LASF6:
	.string	"output"
.LASF4:
	.string	"reg_fir_x"
.LASF5:
	.string	"reg_fir_y"
.LASF7:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -ffreestanding"
.LASF8:
	.string	"initfir"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"fir.c"
.LASF1:
	.string	"/home/chngh/Desktop/SOC_design/Lab4/lab4-2/lab-caravel_fir/testbench/counter_la_fir"
	.ident	"GCC: (g1ea978e3066) 12.1.0"

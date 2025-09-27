	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
	.file	"test.c"
	.globl	cal_sum                         # -- Begin function cal_sum
	.p2align	1
	.type	cal_sum,@function
cal_sum:                                # @cal_sum
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x11 killed $x10
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	lw	a0, -20(s0)
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	addw	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB0_1
.LBB0_3:
	lw	a0, -28(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	cal_sum, .Lfunc_end0-cal_sum
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 48
	li	a0, 0
	sd	a0, -40(s0)                     # 8-byte Folded Spill
	sw	a0, -20(s0)
	call	getint
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	call	cal_sum
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	call	putint
	ld	a0, -40(s0)                     # 8-byte Folded Reload
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym cal_sum
	.addrsig_sym getint
	.addrsig_sym putint

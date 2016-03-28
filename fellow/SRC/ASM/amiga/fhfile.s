fhfile_init:	movem.l	d0-d7/a0-a6,-(a7)
		move.l	$4.w,a6			; Open expansion.library, ref in a4
		lea	explibname(pc),a1
		jsr	-408(a6)
		move.l	d0,a4
		
		lea	endofcode(pc),a0
		move.l	a0,d7
loop2:		
		move.l	d7,a0		; Loop through packets prepared by fhfile
		tst.l	(a0)
		bmi	loopend

		addq.l	#4,d7

		move.l	#88,d0			; Alloc mem for
		moveq	#1,d1			; mkdosdev packet
		move.l	$4.w,a6
		jsr	-198(a6)				; exec.library
		move.l	d0,a5			; Memory for packet in a5

		move.l	d7,a0
			
		moveq	#84,d0
loop:		move.l	(a0,d0.l),(a5,d0.l)	; Copy packet to a5
		subq.l	#4,d0
		bcc.s	loop

		exg	a4, a6			; KS 1.3 expects libary in a6....
		move.l	a5,a0			; MakeDosNode(a0 - packet) 
		jsr	-144(a6)				
		exg	a4, a6			; Keep expansion.library so we can close it later

		move.l	d0,a3			; New device node in a3
		moveq	#0,d0
		move.l	d0,8(a3)
		move.l	d0,16(a3)
		move.l	d0,32(a3)

		move.l	$4.w,a6
		moveq	#20,d0
		moveq	#0,d1
		jsr	-198(a6)                ; Alloc memory for bootnode, exec.library


		move.l	d7,a1
		move.l	-4(a1),d6		; Our unit number	
		move.l	d0,a1			; Bootnode in a1
		
		moveq	#0,d0
		move.l	d0,(a1)			; Successor = 0
		move.l	d0,4(a1)		; Predecessor = 0
		move.w	d0,14(a1)		: bn_Flags
		move.w	#$10ff,8(a1)	; Node type (0x10 bootnode) and priority
		sub.w	d6,8(a1)		; Subtract unit no from priority
		move.l	$f40ffc,10(a1)	; Configdev pointer (ln_Name ?)
		move.l	a3,16(a1)		; Device node pointer (bn_DeviceNode)

		lea	74(a4),a0
		jsr	-270(a6)				; Enqueue()
	
		add.l	#88,d7
		bra	loop2
loopend:	
	
		move.l	$4.w,a6			; Close expansion.library
		move.l	a4,a1
		jsr	-414(a6)

		movem.l (a7)+,d0-d7/a0-a6
		rts

explibname:	dc.b "expansion.library",0
even
endofcode:

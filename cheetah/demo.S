.global _start

_start:
    nop
    nop

    li t1, 0x13
    li t2, 0x31
    la t3, begin_signature
    
    add t4, t1,t2
    sw t4, 0(t3)
    
    or t4, t1,t2
    sw t4, 4(t3)
    
    and t4, t1,t2
    sw t4, 8(t3)
    
    xor t4, t1,t2
    sw t4, 12(t3)
    
    j exit
    
begin_signature:
    .fill 4, 4, 0xcafebeef
end_signature:
exit:
    li a1,0xf00
    la a2,begin_signature
    la a3,end_signature
    
    loop:
    lw t1,0(a2)
    sw t1,0(a1)
    addi a2,a2,4
    blt a2, a3, loop
    
la a4,0xcafebeef
sw t5,0(a4)


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



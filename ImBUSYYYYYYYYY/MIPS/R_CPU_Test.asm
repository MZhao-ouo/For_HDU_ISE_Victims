nor $1, $0,$0; #$1=FFFF_FFFF
sltu $2, $0, $1; #$2=0000_0001
add $3, $2, $2; #$3=0000_0002
add $4, $3, $2; #$4=0000_0003
add $5, $4, $3; #$5=0000_0005
add $6, $5, $3; #$6=0000_0007
sllv $7, $6, $2; #$7=0000_000E
add $9, $5, $6; #$9=0000_000C
sllv $8, $6, $9; #$8=0000_7000
xor $9, $1, $8; #$9=FFFF_8FFF
add $10, $9, $1; #$10=FFFF_8FFE
sub $11, $8, $7; #$11=0000_6FF2
sub $12, $7, $8; #$12=FFFF_900E
and $13, $9, $12; #$13=FFFF_800E
or $14, $9, $12; #$14=FFFF_9FFF
or $15, $6, $7; #$15=0000_000F
nor $16, $6, $7; #$16=FFFF_FFF0
add $17, $7, $3; #$17=0000_0010
sllv $18, $8, $17; #$18=7000_0000
sllv $19, $3, $17; #$19=0002_0000
sllv $20, $19, $7; #$20=8000_0000
add $21, $20, $1; #$21=7FFF_FFFF
or $22, $18, $21; #$22=7FFF_FFFF
add $23, $20, $22; #$23=FFFF_FFFF
sub $24, $20, $22; #$24=0000_0001
sub $25, $22, $20; #$25=FFFF_FFFF
xor $26, $18, $1; #$26=8FFF_FFFF
sltu $27, $22, $20; #$27=0000_0001
sltu $28, $26, $20; #$28=0000_0000
add $29, $22, $2; #$29=8000_0000
sub $30, $20, $2; #$30=7FFF_FFFF
add $31, $11, $26; #$30=9000_6FF1
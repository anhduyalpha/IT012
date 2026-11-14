# Ho ten: Dang Hoang Anh Duy - MSSV: 25520412 - Muc dich: Duyet mang usage va dem so thang thuoc moi bac gia dien vao mang cnt
# Ke hoach dung thanh ghi:
# $s0: dia chi nen mang reading
# $s1: dia chi nen mang usage
# $s2: chi so vong lap i (0..11) hoac k (0..3)
# $s3: gioi han vong lap (12 thang hoac 4 bac)
# $s7: dia chi nen mang cnt (4 phan tu dem so thang cua 4 bac)
# $t0..$t6: thanh ghi tam tinh dia chi, luu gia tri usage[i], ket qua so sanh va cap nhat cnt

.data
mb:      .asciiz "Bac "
m2:      .asciiz ": "
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
cnt:     .word 0, 0, 0, 0

.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  la   $s7, cnt         # $s7 = dia chi nen cnt
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero, 12   # n = 12 thang

  # Vong lap 1: Tinh usage[i] = reading[i+1] - reading[i]
Loop_Usage:
  beq  $s2, $s3, Start_Count
  sll  $t1, $s2, 2
  add  $t2, $s0, $t1
  lw   $t3, 0($t2)
  lw   $t4, 4($t2)
  sub  $t5, $t4, $t3
  add  $t6, $s1, $t1
  sw   $t5, 0($t6)
  addi $s2, $s2, 1
  j    Loop_Usage

  # Vong lap 2: Duyet mang usage va dem so thang theo bac gia vao cnt
Start_Count:
  addi $s2, $zero, 0    # i = 0

Loop_Count:
  beq  $s2, $s3, Start_Print
  sll  $t1, $s2, 2
  add  $t2, $s1, $t1
  lw   $t0, 0($t2)      # $t0 = usage[i]

  slti $t3, $t0, 101
  bne  $t3, $zero, Tang_Bac1

  slti $t3, $t0, 151
  bne  $t3, $zero, Tang_Bac2

  slti $t3, $t0, 201
  bne  $t3, $zero, Tang_Bac3

  # Bac 4: tang cnt[3]
  lw   $t4, 12($s7)
  addi $t4, $t4, 1
  sw   $t4, 12($s7)
  j    Next_Month

Tang_Bac1:
  lw   $t4, 0($s7)
  addi $t4, $t4, 1
  sw   $t4, 0($s7)
  j    Next_Month

Tang_Bac2:
  lw   $t4, 4($s7)
  addi $t4, $t4, 1
  sw   $t4, 4($s7)
  j    Next_Month

Tang_Bac3:
  lw   $t4, 8($s7)
  addi $t4, $t4, 1
  sw   $t4, 8($s7)

Next_Month:
  addi $s2, $s2, 1
  j    Loop_Count

  # Vong lap 3: In ket qua 4 bac "Bac <k>: <so thang>"
Start_Print:
  addi $s2, $zero, 0    # k = 0
  addi $s3, $zero, 4    # 4 bac

Loop_Print:
  beq  $s2, $s3, Exit
  li   $v0, 4
  la   $a0, mb
  syscall

  li   $v0, 1
  addi $a0, $s2, 1      # in bac k + 1
  syscall

  li   $v0, 4
  la   $a0, m2
  syscall

  sll  $t1, $s2, 2
  add  $t2, $s7, $t1
  lw   $a0, 0($t2)      # in cnt[k]
  li   $v0, 1
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $s2, 1
  j    Loop_Print

Exit:
  li   $v0, 10
  syscall
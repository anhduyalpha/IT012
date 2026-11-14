# Ho ten: Dang Hoang Anh Duy - MSSV: 25520412 - Muc dich: Tinh dien nang tung thang, tong dien nang va tim thang cao nhat
# Ke hoach dung thanh ghi:
# $s0: dia chi nen mang reading
# $s1: dia chi nen mang usage
# $s2: chi so vong lap i (0..11)
# $s3: so thang n = 12
# $s4: tong dien nang ca nam
# $s5: dien nang lon nhat
# $s6: thang co dien nang lon nhat (1..12)
# $t1..$t7: cac thanh ghi tam tinh dia chi, luu gia tri trung gian va so sanh

.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
# Du lieu rieng MSSV 25520412 (D = 2):
# reading: .word 1040, 1182, 1349, 1556, 1798, 2055, 2287
#          .word 2474, 2626, 2748, 2850, 2947, 3059
usage:   .space 48

.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero, 12   # n = 12 thang
  addi $s4, $zero, 0    # $s4 = tong dien nang = 0
  addi $s5, $zero, -1   # $s5 = dien nang cao nhat (khoi tao -1)
  addi $s6, $zero, 0    # $s6 = thang cao nhat

Loop:
  beq  $s2, $s3, Done   # thoat neu i == n

  # Tinh dia chi reading[i] va doc reading[i], reading[i+1]
  sll  $t1, $s2, 2      # $t1 = 4 * i
  add  $t2, $s0, $t1    # $t2 = dia chi reading[i]
  lw   $t3, 0($t2)      # $t3 = reading[i]
  lw   $t4, 4($t2)      # $t4 = reading[i+1]

  # Tinh dien nang thang i+1 va luu vao usage[i]
  sub  $t5, $t4, $t3    # $t5 = $t4 - $t3 (dien nang thang i+1)
  add  $t6, $s1, $t1    # $t6 = dia chi usage[i]
  sw   $t5, 0($t6)      # luu $t5 vao usage[i]

  # Cong don tong dien nang va cap nhat thang cao nhat
  add  $s4, $s4, $t5    # cong don vao tong $s4
  slt  $t7, $s5, $t5    # $t7 = 1 neu $s5 < $t5
  beq  $t7, $zero, PrintMonth
  add  $s5, $t5, $zero  # cap nhat dien nang lon nhat
  addi $s6, $s2, 1      # cap nhat thang lon nhat (i + 1)

PrintMonth:
  # In "Thang ", i+1, ": ", $t5, xuong dong
  li   $v0, 4
  la   $a0, m1
  syscall

  li   $v0, 1
  addi $a0, $s2, 1
  syscall

  li   $v0, 4
  la   $a0, m2
  syscall

  li   $v0, 1
  add  $a0, $t5, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $s2, 1      # i = i + 1
  j    Loop

Done:
  # In "Tong: <tong>"
  li   $v0, 4
  la   $a0, mt
  syscall

  li   $v0, 1
  add  $a0, $s4, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  # In "Thang cao nhat: <thang> (<dien nang>)"
  li   $v0, 4
  la   $a0, mm
  syscall

  li   $v0, 1
  add  $a0, $s6, $zero
  syscall

  li   $v0, 4
  la   $a0, lp
  syscall

  li   $v0, 1
  add  $a0, $s5, $zero
  syscall

  li   $v0, 4
  la   $a0, rp
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  li   $v0, 10
  syscall

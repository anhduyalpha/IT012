# Ho ten: Dang Hoang Anh Duy - MSSV: 25520412 - Muc dich: Doc dien nang tieu thu tu ban phim va phan loai bac gia dien (1..4)
# Ke hoach dung thanh ghi:
# $s0: dien nang tieu thu nhap tu ban phim (kWh)
# $s1: bac gia dien tuong ung (1, 2, 3 hoac 4)
# $t0: ket qua so sanh slti (0 hoac 1)

.data
prompt: .asciiz "Nhap dien nang (kWh): "
msg:    .asciiz "Bac: "
nl:     .asciiz "\n"

.text
.globl main
main:
  li   $v0, 4
  la   $a0, prompt
  syscall

  li   $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add  $s0, $v0, $zero   # $s0 = dien nang (kWh)

  # Xac dinh bac (1..4) theo Bang 6, dat vao $s1
  slti $t0, $s0, 101     # $t0 = 1 neu $s0 <= 100
  bne  $t0, $zero, Bac1

  slti $t0, $s0, 151     # $t0 = 1 neu $s0 <= 150
  bne  $t0, $zero, Bac2

  slti $t0, $s0, 201     # $t0 = 1 neu $s0 <= 200
  bne  $t0, $zero, Bac3

  li   $s1, 4            # $s0 >= 201 -> Bac 4
  j    InKetQua

Bac1:
  li   $s1, 1
  j    InKetQua

Bac2:
  li   $s1, 2
  j    InKetQua

Bac3:
  li   $s1, 3

InKetQua:
  # In "Bac: ", roi $s1, roi xuong dong
  li   $v0, 4
  la   $a0, msg
  syscall

  li   $v0, 1
  add  $a0, $s1, $zero
  syscall

  li   $v0, 4
  la   $a0, nl
  syscall

  li   $v0, 10
  syscall
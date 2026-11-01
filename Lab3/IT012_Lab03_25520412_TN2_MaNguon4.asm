# Ho va ten: Dang Hoang Anh Duy - MSSV: 25520412
# Ma nguon 4 - chuyen cau lenh thanh lenh hop ngu

.text
.globl main
main:
    addi $s0, $zero, 8       # y = 8
    addi $s1, $zero, 5       # z = 5
    addi $s2, $zero, 3       # w = 3

    # x1 = y + z + w vao $t0
    add  $t0, $s0, $s1
    add  $t0, $t0, $s2

    # x2 = (y + z) - (w + 5) vao $t1
    add  $t5, $s0, $s1
    addi $t1, $s2, 5
    sub  $t1, $t5, $t1

    # x3 = y (sao chep) vao $t2
    add  $t2, $s0, $zero

    # x4 = z - y vao $t3
    sub  $t3, $s1, $s0

    li   $v0, 10
    syscall

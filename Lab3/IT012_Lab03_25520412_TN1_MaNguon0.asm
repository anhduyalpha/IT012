# Ho va ten: Dang Hoang Anh Duy - MSSV: 25520412
# Ma nguon 0 - kiem tra nhanh

.data
msg:   .asciiz "Xin chao, MARS!\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, msg
    syscall

    li   $v0, 10
    syscall

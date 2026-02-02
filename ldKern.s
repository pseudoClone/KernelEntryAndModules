.section text
.global _start
_start:
        la sp, stack_top
        call kern_main
1: j 1b ; don't know why people do this since, while(1) should never return, unless stack is exceeded

.section bss
.space 4096 ; stack size
.global stack_top
stack_top:

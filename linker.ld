OUTPUT_ARCH(riscv) /*Don't know what it should be for I32 base + M extension*/
ENTRY(_start)
SECTIONS
{
	. = 0x80000000;
	.text : {
		*(.text._start)
		*(.text*)}
	}

	.data : {*(.data)}
	.bss  : {*(.bss)}
	. = ALLIGN(4) /* Start stack at memory alligned for 2^4 bytes */
	. += 4096;
	stack_top = .;
}

OUTPUT_FORMAT(elf32-i386)
ENTRY(start) /* No fucking userspace main */
SECTIONS
{
        . = 0x100000; /* Stadard entry but jaha rakhda ni hunchha*/
        .text = {*(.text)}
        .data = {*(.data)}
        .bss  = {*(.bss)}
}

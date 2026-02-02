void kernel_main(void){
  	volatile char* uart = (char*) 0x10000000; /* QEMU's physical address for UART MMIO */
  	*uart = "X";
	while(1){};
}

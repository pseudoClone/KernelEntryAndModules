# Basic Idea
- Not like x86 where you have to specify real mode at the start. Just assume that your machine is in Machine Mode.
- Jump to reset vector and call kernel entry
- There are two perpetual loops. One to stop the kernel from just exiting and other is for ensuring that the first one does not exceed stack
- Get the UART MMIO address(yes it's hardcoded, surprising I know) and push the character from kernel to the transmitter FIFO register
- If it gives, an error, most probably it's the linker, fix it and you should be good to go.

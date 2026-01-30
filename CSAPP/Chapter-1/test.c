
#include <stdio.h>

int main() {
  printf("Hello World!");
printf("Have a good day!");
return 0;
}

/*
information = bits & context

c is like abstraction for assembly

the translation process
1. cpp (looks at #)
2. compiler (turns code into assembly)
3. assemlber (turns assembler into machine instructions)
4. linker


PC (Program Counter): bookmark that points to next instruction
Register: the memory in CPU, instant lookup
ALU: specialuzed tool to perform math/logic
Main Memory: RAM, can store lots of instruction. cpu sees this as a huge aray
BUS: the I/O conveyor belt, can carry bits back and forth
its the highway. can have memory bus, cpu bus, i/o bus
I/O: connection to the external world.
OS : the gatekeeper of i/o . when a program runs it asks the os first - system calls
CPU: doesn't have lots of memory, very tiny


CPU Instructions
load: loads instruction from RAM
STORE: stores instruction ffrom cpu to ram
update: copy contents of two registers

DMA:
instead of chef (cpu) -> disk
make the RAM interact with the disk, cpu can keep doing whatever its doint
move from diskto memory without goin to cpu

How a program runs
phase 1: the order
type hello -> keyboard -> memory

phase 2: the delivery
tells disk to send progrma code to main memory

phase 3: the cooking
cpu get instruction from memory, process it in register, send result to display
register is where everything is happening

CPU takes 2 items and performs (binary oeprator) in the cpu register

context switching: like a fast juggling for OS
give an illusion its running simultaneousy when alt tab

when you run a program it's always being copied to RAM/memory first

*/

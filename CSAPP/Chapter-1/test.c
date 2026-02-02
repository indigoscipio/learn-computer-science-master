
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


CACHE
register - can only hold 1/2 . . technicaly register has memory 
l1/l2 - tmeporary memory - exist to   addres the memory/cpu gap
main memory - library
disk - warehouse/storage

THE MEMORY PYRAMID
register 
l1/l2
memory
disk
internet/server

caching - each level acts as a "room" for level below it.

-----

OS ABSTRACTION - OS IS THE ULTIMATE MANAGER
File (abstraction for i/o) - sees all device as simple bytes instead of differentiating
VM  - os tricks program beleive it has entire memory of computer to itself. it hides the fact
other programs are using it
Processes - proc + mem + i/o, creates illustion your program is the only thing running

-----
PROCESSES
it's a way to give all program its own private universe
cpu juggles each program so incredibly fast it doesn't even realize its switching 
gives an illustion that the program is the only one runing on the system  
the program actually uses proc, memory, and I/O

this juggling process is called context switch
alt tab but more low level work

conssits of multiple processes usually

-----

VM
- ram is just a cache for the disk
- each program when runs has its own virtual address space
- with the power of MMU
- when ram is out of space it uses hard drive, gives an illusion

*/

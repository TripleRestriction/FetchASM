# FetchASM
```
nasm -felf64 fetchasm.asm -o fetchasm.o && ld fetchasm.o -o fetchasm && ./fetchasm
```
Written in 64 bit NASM Linux Assembly, may have some issues on your device because buffer offsets are hard coded.
May expand more in future.

Sample:
![alt text](https://raw.githubusercontent.com/TripleRestriction/FetchASM/refs/heads/main/sample.png)

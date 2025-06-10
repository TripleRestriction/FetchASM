# FetchASM
```
nasm -felf64 fetchasm.asm -o fetchasm.o && ld fetchasm.o -o fetchasm && ./fetchasm
```
Written in 64 bit NASM Linux Assembly, may have some issues on your device because buffer offsets are hard coded.
Will expand more in future.

Sample:


![alt text](https://raw.githubusercontent.com/TripleRestriction/FetchASM/refs/heads/main/sample.png)



Todo:
1) Use something like getline() instead of manual offsets.
2) Prettify.
3) ASCII art support.
4) More info.
5) Perhaps show mem in GB instead of KB.

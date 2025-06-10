; A FETCH TOOL WRITTEN IN X64 LINUX NASM ASSEMBLY by Triple Restriction/Draco Silver
section .bss
  uname_buf resb 256
  buffer resb 124
  buffer2 resb 100
  ascii_buf resb 1024
section .data
  sep db "|-> ", 0 ; 10 means new line and db means define byte, 0 means null terminator 
  sep_len equ $ - sep ; subtracts current pos from pos of msg to obtain length of string

  ascii_art db "ascii.txt", 0
  
  dist db 0x1b, "[34mKernel ", 0x1b, "[0m", 0
  dist_len equ $ - dist

  lines db 0x1b, "[34m-----------------------------------------------------------------------------------", 0x1b, "[0m", 0
  lines_len equ $ - lines

  cpu_info db 0x1b, "[34mCPU", 0x1b, "[0m", 0
  cpu_len equ $ - cpu_info
  cpu_proc db "/proc/cpuinfo", 0

  mem_info db 0x1b, "[34mMEM ", 0x1b, "[0m", 0
  mem_len equ $ - mem_info
  mem_proc db "/proc/meminfo", 0

  newline db '', 10; newline
  newline_len equ $ - newline

section .text
global _start

_start:
;;;;;print ascii art;;;;;;;;;;;;;;;;;;;;;;;;;
  mov rax, 2 
  mov rdi, ascii_art
  xor rsi, rsi
  xor rdx, rdx
  syscall
  ;; reading the opened file
  mov rdi, rax ;; return value stored in rax probably idk it just works
  xor rax, rax
  mov rsi, ascii_buf
  mov rdx, 1024
  syscall

  ;; printing the file
  mov rdx, rax
  mov rax, 1 
  mov rdi, 1 
  mov rsi, ascii_buf
  syscall
  
  call print_lines
  call print_newline
;;;;;;;;;;;;;;;kernel;;;;;;;;;;;;;;;;;;;;;;;;;;
  call print_arrow 

  ;; print info name mov rax, 1
  mov rax, 1
  mov rdi, 1
  mov rsi, dist
  mov rdx, dist_len
  syscall
  
  ; obtain the uname
  mov rax, 0x3f ; sys call for uname
  mov rdi, uname_buf
  syscall
  ; print the uname
  mov rax, 1; sys call for write
  mov rdi, 1; choose stdout descriptor 
  mov rsi, uname_buf; put what to print in rsi
  mov rdx, 250; put length in rdx
  syscall

  call print_newline
;;;;;;;;;;;;;;;;;;;CPU;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  call print_arrow
  
  mov rax, 1 
  mov rdi, 1 
  mov rsi, cpu_info
  mov rdx, cpu_len
  syscall
  ;; opening the file
  mov rax, 2 
  mov rdi, cpu_proc
  mov rsi, 0
  mov rdx, 0
  syscall
  ;; reading the opened file
  mov rdi, rax ;; return value stored in rax probably idk it just works
  xor rax, rax
  mov rsi, buffer
  mov rdx, 95
  syscall

  ;; printing the file
  mov rdx, rax
  mov rax, 1 
  mov rdi, 1 
  mov rsi, buffer + 79
  syscall

  call print_newline
;;;;;;;;;;;;;;;;;;;MEM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  call print_arrow
  
  mov rax, 1 
  mov rdi, 1 
  mov rsi, mem_info
  mov rdx, mem_len
  syscall

  ;; opening the file
  mov rax, 2 
  mov rdi, mem_proc
  xor rsi, rsi
  xor rdx, rdx
  syscall

  ;; reading the opened file
  mov rdi, rax ;; return value stored in rax probably idk it just works
  xor rax, rax
  mov rsi, buffer2
  mov rdx, 28
  syscall

  ;; printing the file
  mov rdx, rax
  mov rax, 1 
  mov rdi, 1 
  mov rsi, buffer2 + 17
  syscall

  call print_lines

  call print_newline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; quit the program
  mov rax, 60 ; invoke exit syscall (60 for x64 and 1 for x86)
  xor rdi, rdi ; set return value to 0
  syscall

print_arrow:
  mov rax, 1
  mov rdi, 1
  mov rsi, sep
  mov rdx, sep_len
  syscall
  ret

print_newline:
  ;print a newline character 
  mov rax, 1;
  mov rdi, 1
  mov rsi, newline; newline 
  mov rdx, newline_len ; length
  syscall 
  ret

print_lines:
  mov rax, 1 
  mov rdi, 1 
  mov rsi, lines
  mov rdx, lines_len
  syscall
  ret

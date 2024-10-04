; Assignment 4 - Fill Array
; YOUR NAME HERE

global _start           ; expose program entry point

section .text           ; start of code segment

; Constants for the problem. Program should use these values according to
; the assignment instructions. Changes to these values should cause the
; program to fill the array accordingly.
ARRAY_SIZE equ 10
START_VALUE equ 14
ADD_VALUE equ 3

_start:
    mov rdi, array              ; rdi points to the start of the array (64-bit register)
    mov rax, START_VALUE        ; Load START_VALUE into rax (64-bit register for storing values)
    mov rsi, 1                  ; rsi is the multiplier for ADD_VALUE (starts at 1)
    mov rcx, ARRAY_SIZE         ; Load ARRAY_SIZE into rcx (64-bit register for loop counter)

    ; Store the first value (START_VALUE) in the array
    mov [rdi], rax              ; Store START_VALUE in the first array position (64-bit store)
    add rdi, 8                  ; Move rdi to the next quadword (8 bytes forward for 64-bit)
    dec rcx                     ; Decrement rcx since one element is already filled

fill_loop:
    test rcx, rcx               ; Check if the counter (rcx) is zero
    jz exit                     ; If rcx == 0, exit the loop

    ; Calculate the next value
    mov rbx, ADD_VALUE          ; Load ADD_VALUE into rbx (64-bit register)
    imul rbx, rsi               ; Multiply ADD_VALUE by rsi (generating 3, 6, 9, 12, etc.)
    add rax, rbx                ; Add the result to the previous value in rax
    mov [rdi], rax              ; Store the new value in the array (64-bit store)

    ; Prepare for the next iteration
    add rdi, 8                  ; Move to the next element (64-bit addressing, 8 bytes forward)
    inc rsi                     ; Increment the multiplier
    loop fill_loop              ; Decrement rcx and repeat loop if rcx != 0

exit:
    ; End the program
    mov rax, 0x3c               ; system call for exit (64-bit)
    xor rdi, rdi                ; exit code 0
    syscall                     ; invoke operating system call 

section .data           ; start of initialized data segment


section .bss            ; start of uninitialized data segment 

array resq ARRAY_SIZE   ; Reserve space for ARRAY_SIZE quadwords (64-bit)

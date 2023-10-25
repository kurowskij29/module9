.global main
.global checkGrade 



.text
main:
   # Save return to os on stack
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Prompt For An Input
   LDR r0, =prompt
   BL  printf

   #Scanf
   LDR r0, =input
   LDR r1, =grade
   LDR r2, =name
   BL scanf

   # Call checkGrade
   LDR r1, =grade
   LDR r1, [r1, #0]
   LDR r2, =name
   BL checkGrade

   # Return to the OS
   ldr lr, [sp, #0]
   add sp, sp, #4
   mov pc, lr

.data
   grade: .word 0
   prompt: .asciz "Enter the grade and student name, separated by a space:\n"
   input: .asciz "%d %s"
   name: .asciz ""





.text
checkGrade:
   # Push
   SUB sp, sp, #4
   STR lr, [sp, #0]


   MOV r4, r0
   MOV r5, r1
   #if block
   #check 0 <= r4 <= 100
   MOV r1, #0
   MOV r0, #0
   CMP r4, r0
   MOVGE r1, #1

   MOV r2, #0
   MOV r0, #100
   CMP r4, r0
   MOVLE r2, #1

   AND r1, r1, r2
   MOV r2, #1
   CMP r1, r2
   BEQ grade_A // Grade is valid
      # Code block for Invalid Grade
      LDR r0, =Invalid
      BL printf
      B EndIf
   grade_A:
   MOV r0, #90
   CMP r4, r0
   BLT grade_B
      # Code block for grade of A
      LDR r0, =GradeA
      LDR r1, r5
      BL printf
      B EndIf
   grade_B:
   MOV r0, #80
   CMP r4, r0
   BLT grade_C
      # Code block for grade of B
      LDR r0, =GradeB
      LDR r1, r5
      BL printf
      B EndIf
   grade_C:
   MOV r0, #70
   CMP r4, r0
   BLT Else
      # Code block for grade of C
      LDR r0, =GradeC
      LDR r1, r5
      BL printf
      B EndIf
   Else:
      # Code block for grade of F
      LDR r0, =GradeF
      LDR r1, r5
      BL printf
      B EndIf
   EndIf:

   # Pop
   ldr lr, [sp, #0]
   add sp, sp, #4
   mov pc, lr

.data
   GradeA: .asciz "%s got an A\n"
   GradeB: .asciz "%s got a B\n"
   GradeC: .asciz "%s got a C\n"
   GradeF: .asciz "%s got an F\n"
   Invalid: .asciz "Grade must be 0 <= grade <= 100\n"

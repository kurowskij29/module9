#
# Program name: calcGrades.s
# Author: Jack Kurowski
# Date: 10/29/2023
# Purpose: This program outputs what a user entered for a student
# test and the grade they got
#
.text
.global main
main:

   # Save return to os on stack
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Prompt For An Input
   LDR r0, =prompt1
   BL  printf

   #Scanf
   LDR r0, =input1
   LDR r1, =grade
   LDR r2, =name
   BL scanf

   BL checkGrade

   # Printing The Message
   LDR r0, =format1
   LDR r1, =grade
   LDR r1, [r1, #0]
   LDR r2, =name
   MOV r0, r1
   MOV r1, r2
   BL checkGrade 

   # Return to the OS
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data
   grade: .word 0
   prompt1: .asciz "Enter your grade and name\n"
   input1: .asciz "%d %s"
   format1: .asciz "Your grade is %d and name is %s \n"
   name: .asciz ""
#End main


# Function checkGrade
# checkGrade takes a number and name input and prints out the student
# name and what grade they got
# Inputs:
#    r0 - grade
#    r1 - name
# Outputs:
#    no outputs - print info only


.text
.global checkGrade

checkGrade:
   # Push
   SUB sp, sp, #12
   STR lr, [sp, #0]
   STR r4, [sp, #4]
   STR r5, [sp, #8]

   # Store inputs in other regs
   MOV r4, r0
   MOV r5, r1
 
   #if block
   #check grade is at least zero
   MOV r1, #0
   MOV r0, #0
   CMP r4, r0
   MOVGE r1, #1

   # Check grade is bounded by 100
   MOV r2, #0
   MOV r0, #100
   CMP r4, r0
   MOVLE r2, #1

   # and to see if 0 <= r4 <= 100
   AND r1, r1, r2
   MOV r2, #1
   CMP r1, r2

   BEQ grade_A 
      # bad entry
      LDR r0, =BadInput
      BL printf
      B EndIf
   grade_A:
   MOV r0, #90
   CMP r4, r0
   BLT grade_B
      # blockA    
      LDR r0, =az
      MOV r1, r5
      BL printf
      B EndIf
   grade_B:
   MOV r0, #80
   CMP r4, r0
   BLT grade_C
      #blockB
      LDR r0, =bz
      MOV r1, r5
      BL printf
      B EndIf
   grade_C:
   MOV r0, #70
   CMP r4, r0
   BLT Else
      # blockC
      LDR r0, =cz
      MOV r1, r5
      BL printf
      B EndIf
   Else:
      # blockF
      LDR r0, =fz
      MOV r1, r5
      BL printf
      B EndIf

   EndIf:



   # Pop
   LDR lr, [sp, #0]
   LDR r4, [sp, #4]
   LDR r5, [sp, #8]
   ADD sp, sp, #12
   MOV pc, lr

.data
   format2: .asciz "num2 Your grade is %d and name is %s \n"
   az: .asciz "%s got an A\n"
   bz: .asciz "%s got a B\n"
   cz: .asciz "%s got a C\n"
   fz: .asciz "%s got an F\n"
   BadInput: .asciz "You must enter a valid grade (a number between 0 and 100, inclusive)\n"

# end checkGrade



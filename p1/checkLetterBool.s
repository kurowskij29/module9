
# FileName: libConversions.s
# Author: Jack Kurowski
# Date: 10/23/2023
# Purpose: Check letter using boolean vars
#
# Functions:
# main
# checkLetter
#


.global main
.global checkLetter

.text

main:
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Prompt For An Input
   LDR r0, =prompt1
   BL printf

   #Scanf
   LDR r0, =input1
   LDR r1, =userVal
   BL scanf
   LDR r0, =userVal
   LDR r0, [r0, #0]

   BL checkLetter

   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data
   prompt1: .asciz "Enter a character:\n"
   userVal: .word 0
   input1: .asciz "%1s"


# End main

.text
checkLetter:
   # push
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # check if input is greater than or equal to a
   MOV r4, #0
   MOV r1, #0x61
   CMP r0, r1
   MOVGE r4, #1

   # check if input is less than or equal to z
   MOV r5, #0
   MOV r1, #0x7A
   CMP r0, r1
   MOVLE r5, #1

   # and above checks for lowercase check
   AND r4, r4, r5


   # check if input is greater than or equal to A
   MOV r6, #0
   MOV r1, #0x41
   CMP r0, r1
   MOVGE r6, #1

   # check if input is less than or equal to Z
   MOV r5, #0
   MOV r1, #0x5A
   CMP r0, r1
   MOVLE r5, #1

   # and above checks for uppercase check
   AND r6, r6, r5

   # OR uppercase and lowercase to determine if alphabetic char
   ORR r4, r4, r6
   MOV r1, #0
   CMP r4, r1

   BEQ Else // if block
      # If r4 is not 0 (aka true), then input is a letter
      LDR r0, =outputLetter
      B EndIf

   Else: // else block
      # r4 is 0, thus input is not a letter
      LDR r0, =outputNot

   EndIf: // end of if else

   # print answer
   BL printf
   
   # Pop and return
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data
   outputNot: .asciz "Input is not a letter!\n"
   outputLetter: .asciz "Input is a letter!\n"

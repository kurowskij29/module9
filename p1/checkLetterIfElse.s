
# FileName: libConversions.s
# Author: Jack Kurowski
# Date: 10/23/2023
# Purpose: Check letter without using boolean variables
#
# Functions:
# main
# checkLetter
#


.global main
.global checkLetter

.text

main:
   #push
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Prompt For An Input
   LDR r0, =prompt1
   BL printf

   #Store input letter
   LDR r0, =input1
   LDR r1, =userVal
   BL scanf

   #Put letter in correct reg for BL
   LDR r0, =userVal
   LDR r0, [r0, #0]
   BL checkLetter

   #pop
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

   # check if input is greater than or equal to A
   MOV r4, #0
   MOV r1, #0x41
   CMP r0, r1
   BLT else1

      #start if1 block

      # check if input is less than or equal to z
      MOV r5, #0
      MOV r1, #0x5A
      CMP r0, r1
      BGT else2
         #if2 block
         LDR r0, =outputLetter
         B endIf2
         #end if2 block
      else2:
         # start else2 block

         # check if input is greater than or equal to a
         MOV r4, #0
         MOV r1, #0x61
         CMP r0, r1
         BLT else3
            # block for outter if
   
            # check if input is less than or equal to z
            MOV r5, #0
            MOV r1, #0x7A
            CMP r0, r1
            BGT else4
               # block for if4
               LDR r0, =outputLetter
         
               B endIf4
               # end if4 block
            else4:
               # else4 block
               LDR r0, =outputNot
               #end else4 block
            endIf4:

            B endIf3
            #end block for if3

         else3:
            # else3 block
            LDR r0, =outputNot
            #end else3 block
         endIf3:

      # end else2 block
      endIf2:

   # end if1 block
   B endIf1

   else1:
      # else1 block
      LDR r0, =outputNot

   endIf1:


   # print answer
   BL printf
   
   # Pop and return
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data
   outputNot: .asciz "Input is not a letter!\n"
   outputLetter: .asciz "Input is a letter!\n"

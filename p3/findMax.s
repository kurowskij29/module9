
# Program Name: findMax.s
# Author:       Jack Kurowski
# Date:         10/29/2023 
# Purpose:      Find the max of 3 user entered values and print the max value
# Functions:
#               main
#               getMax

.text
.global main

main:
   # Push
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Prompt For An Input
   LDR r0, =prompt1
   BL printf

   #Load all 3 values
   LDR r0, =input1
   LDR r1, =val1
   LDR r2, =val2
   LDR r3, =val3
   BL scanf
   LDR r0, =val1
   LDR r0, [r0, #0]
   LDR r1, =val2
   LDR r1, [r1, #0]
   LDR r2, =val3
   LDR r2, [r2, #0]

   #call getMax on r0,r1,r2
   BL getMax 
   # Put the value in r1 before loading output into r0
   MOV r1, r0

   #print result
   LDR r0, =output1
   BL printf

   #pop
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data
   prompt1: .asciz "Enter three numbers, separated by spaces\n"
   val1: .word 0
   val2: .word 0
   val3: .word 0
   input1: .asciz "%d %d %d"
   output1: .asciz "The largest of the numbers you entered is: %d\n"


# end main



# getMax
# Purpose: This function finds the max of 3 numbers
# Inputs:
#          r0 - value1
#          r1 - value2
#          r2 - value3
# Outputs:
#          r0 - highest value



.text
.global getMax

getMax:

   #push 
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Save r0 for output
   MOV r3, r2
   MOV r2, r1  
   MOV r1, r0

   # compare val1 and val2
   CMP r1, r2
   BLT else1
      #if1 block
      # compare val1 and val3
      CMP r1, r3
      BLT else2
         #if2 block
         MOV r0, r1
         B endif2
      else2:
         #else2 block
         MOV r0, r3
      endif2:

      B endif1
   else1:
      #else1 block
      # compare val2 and val3
      CMP r2, r3
      BLT else3
         #if3 block
         MOV r0, r2
         B endif3
      else3:
         #else3 block
         MOV r0, r3
      endif3:
   endif1:

   #pop
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

.data 


# end getMax

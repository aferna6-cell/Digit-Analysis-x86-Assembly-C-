# Name: Aidan Fernandes
# Course: ECE 2730
# Section: 001
# Date: 9/22/2025
# File: Fernandes_2730_001_02.s <--- Change this and file name to your last name
# Purpose: Assembly implementation of three functions for digit analysis

# begin assembly stub
.globl dodiff
.type dodiff , @function

# Function: dodiff
# Arguments: None (uses global variables)
# Returns: None (stores result in global diff)
# Purpose: Calculate diff = (digit1 * digit1) + (digit2 * digit2) - (digit3 * digit3)

dodiff :
    # prolog
    pushl %ebp
    pushl %ebx
    movl %esp, %ebp
    
    # Load digit1 and calculate digit1 * digit1
    movl digit1, %eax
    imull %eax, %eax        # eax = digit1 * digit1
    movl %eax, %ebx         # store result in ebx
    
    # Load digit2 and calculate digit2 * digit2
    movl digit2, %eax
    imull %eax, %eax        # eax = digit2 * digit2
    addl %eax, %ebx         # ebx = digit1^2 + digit2^2
    
    # Load digit3 and calculate digit3 * digit3
    movl digit3, %eax
    imull %eax, %eax        # eax = digit3 * digit3
    subl %eax, %ebx         # ebx = digit1^2 + digit2^2 - digit3^2
    
    # Store result in diff
    movl %ebx, diff
    
    # epilog
    movl %ebp, %esp
    popl %ebx
    popl %ebp
    ret

.globl dosumprod
.type dosumprod, @function

# Function: dosumprod
# Arguments: None (uses global variables)
# Returns: None (stores results in global sum and product)
# Purpose: Calculate sum = digit1 + digit2 + digit3, product = digit1 * digit2 * digit3

dosumprod:
    # prolog
    pushl %ebp
    pushl %ebx
    movl %esp, %ebp
    
    # Calculate sum = digit1 + digit2 + digit3
    movl digit1, %eax
    addl digit2, %eax
    addl digit3, %eax
    movl %eax, sum          # store sum
    
    # Calculate product = digit1 * digit2 * digit3
    movl digit1, %eax
    imull digit2, %eax      # eax = digit1 * digit2
    imull digit3, %eax      # eax = digit1 * digit2 * digit3
    movl %eax, product      # store product
    
    # epilog
    movl %ebp, %esp
    popl %ebx
    popl %ebp
    ret

.globl doremainder
.type doremainder, @function

# Function: doremainder
# Arguments: None (uses global variables)
# Returns: None (stores result in global remainder)
# Purpose: Calculate remainder = product % sum

doremainder:
    # prolog
    pushl %ebp
    pushl %ebx
    movl %esp, %ebp
    
    # Calculate product % sum
    movl product, %eax      # dividend in eax
    cdq                     # sign extend eax into edx:eax
    idivl sum               # divide edx:eax by sum, remainder in edx
    movl %edx, remainder    # store remainder
    
    # epilog
    movl %ebp, %esp
    popl %ebx
    popl %ebp
    ret

# declare variables here
.comm digit1, 4, 4
.comm digit2, 4, 4
.comm digit3, 4, 4
.comm diff, 4, 4
.comm sum, 4, 4
.comm product, 4, 4
.comm remainder, 4, 4

# end assembly stub
# Do not forget the required blank line here!
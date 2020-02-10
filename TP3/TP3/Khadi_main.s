			.equ PRINT_INT,		1
			.equ PRINT_STRING,	4
			.equ READ_INT,		5
			.equ EXIT,		10

			.text

			####################################
			# Fonction rechercheDichotomique() 
			# r8:pos
			# r9: fin-debut
			# r10: fin-debut /2
			# r11:4*pos
			#r12:tableau +4*pos
			# r13:tabl[pos]
			####################################
rechercheDichotomique:
			bge r7,r6, if1
			addi r2, zero, -1
			ret

if1:        #pos = debut + (fin-debut) / 2
			sub  r9,r7, r6
			
			movia r14,2
			div r10, r9, r14
			add r8, r6,r10
			
			#if (tab[pos] == val)
			#return pos;
			slli r11,r8, 2
		   	add r12, r5, r11
			ldw r13, 0(r12)
			bne r13, r4,if2
			mov r2,r8
			ret
if2:      
          
			bge r13, r4,if3  #if tab[pos] > val
			addi r6, r8, 1
			
			addi sp,sp,-4
			stw ra, 0(sp)
			call rechercheDichotomique
			ldw ra, 0(sp)
			addi sp, sp,4
			ret			
if3:      		
			addi r7, r8, -1
			addi sp,sp,-4
			stw ra, 0(sp)
			call rechercheDichotomique
			ldw ra, 0(sp)
			addi sp, sp,4
			ret	 
			
						





			##############################
			#       Fonction main()      #
			##############################
			.globl main
main:	
			
				
			
boucle:
			# Imprime "Entrez un nombre: "
			movia	r4, msgNb
			addi	r2, zero, PRINT_STRING
			trap
			
			# Lit un nombre
			addi	r2, zero, READ_INT
			trap
			
			##############################
			#         r4:val
			#		  r5:tableau
			#		  r6:0
			#		  r7:99
		    #         r9:pos
			##############################
			
			mov r4,r2
			movia r5,tableau
			movia r6,0
			movia r7,99
			
			addi sp,sp,-4
			stw ra, 0(sp)

			addi sp,sp,-4
			stw r8,0(sp)
			addi sp,sp,-4
			stw r9,0(sp)

			call rechercheDichotomique

			ldw r9,0(sp)
			addi sp,sp,4
			
			ldw r8,0(sp)
			addi sp,sp,4
			
			ldw ra,0(sp)
			addi sp,sp,4
			
			
			mov r9,r2
			movia r8, 0
			bge r8,r9, if
			
			movia r4, msgPos
			movia r2,4
			trap
	        mov r4, r9
			movia r2,1
			trap
			jmpi fin
if:         
			movia r4, msgErreur
			movia r2,4
			trap
fin:
			addi sp,sp,4
			ldw r9,0(sp)
			addi sp,sp,4
			ldw r8,0(sp)
				
			 
			
	
			br	boucle

			.data
	
msgNb:		.asciz "Entrez un nombre: \n"
msgErreur:	.asciz "Nombre non trouve.\n"
msgPos:		.asciz "La position du nombre est: "

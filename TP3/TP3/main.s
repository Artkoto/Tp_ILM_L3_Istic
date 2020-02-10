#Binome Akoto Yao & Kone Kafongo

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
			addi	r2, zero, -1

conditionRech: 
			bge r6 , r7, nonConditionRech
			ret

nonConditionRech:
				mov r8 ,r5
				sub r8 , r8 , r4
				srli r8, r8, 1
			
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
			# 		  le MAin :
			#         r4:val
			#		  r5:tableau
			#		  r6: debut (0)
			#		  r7:fin (99)
		    #         r9:pos
			##############################
			mov r4,r2
			movia r5,tableau
			movia r6,0
			movia r7,99

			subi sp, sp, 4
			stw ra, 0(sp)
			subi sp, sp, 4
			stw r8,0(sp)


			##############################
			# 	Appelle de la fonction 
			##############################

			call rechercheDichotomique

			ldw	r8, 0(sp)
			addi sp, sp, 4
			ldw	ra, 0(sp)
			addi sp, sp, 4
			
			mov		r8, r2

conditionPos: 
			bge r0, r8 , nonConditionPos
			movia r4 , msgErreur
			movia r2, PRINT_STRING
			trap

nonConditionPos:
			movia r4 , msgPos
			movia r2, PRINT_STRING
			trap
			mov r4 , r8
			movia r2, PRINT_INT
			trap

			br	boucle

			.data
	
msgNb:		.asciz "Entrez un nombre: \n"
msgErreur:	.asciz "Nombre non trouve.\n"
msgPos:		.asciz "La position du nombre est: "
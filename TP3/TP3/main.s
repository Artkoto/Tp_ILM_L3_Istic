#Binome Akoto Yao & Kone Kafongo

			.equ PRINT_INT,		1
			.equ PRINT_STRING,	4
			.equ READ_INT,		5
			.equ EXIT,		10

			.text

			#####################################################
			# Fonction rechercheDichotomique() 
			#---------------------------------------------------
			# r8:pos
			# r9:4*pos : position de l'element  dans le tableau
			#r10:@tabl[pos]
			# r11:tabl[pos]
			####################################################
rechercheDichotomique:
			addi	r2, zero, -1

conditionRech: 
			bge r7 , r6, nonConditionRech 
			#si debut > fin on retourne -1
			ret 

nonConditionRech:
				#calcule de pos dans r8
				mov r8 ,r7
				sub r8 , r8 , r6
				srli r8, r8, 1
				add r8 , r8 ,r6
				
				#recuperation du pos iem element du tableau
				slli	r9, r8, 2 #calcule de l'indice pos dans le tableaux
				add		r10, r5, r9 #indice du tableau
				ldw		r11, 0(r10) #recuperation de t[pos]

conditionInbrRech1:
				
				bne		r11, r4, conditionInbrRech2
				mov		r2, r8 # si tab[pos] = val on retourn pos
				ret

conditionInbrRech2:
				# on sauvegarde l'adresse du processus en cours dans la pile
				#pour s'assurer que la recursivité se passe correctement
				subi	sp, sp, 4 
				stw		ra, 0(sp)

				blt		r4, r11 , conditionInbrRech3
				#si tab[pos] < val 
				addi	r6, r8, 1 # debut := post + 1
				call	rechercheDichotomique 
				ldw		ra, 0(sp) 
				addi	sp, sp, 4
				ret


 conditionInbrRech3:
				subi	r7, r8, 1 # fin := post - 1
				call	rechercheDichotomique
				ldw		ra, 0(sp)
				addi	sp, sp, 4

				
				ret	

			################################
			#       Fonction main()  
			#-------------------------------
			#          r4:val
			#		  r5:tableau
			#		  r6: debut (0)
			#		  r7:fin (99)
		    #         r8:pos
			################################
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
     
			###############Complétion du Main############
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
			mov		r8, r2

conditionPos: 
			bge r8, r0 , nonConditionPos
			movia r4 , msgErreur
			movia r2, PRINT_STRING
			trap
			br	boucle

nonConditionPos:
			movia r4 , msgPos
			movia r2, PRINT_STRING
			trap
			mov r4 , r8
			movia r2, PRINT_INT
			trap

			ldw	r8, 0(sp)
			addi sp, sp, 4
			ldw	ra, 0(sp)
			addi sp, sp, 4

			br	boucle

			.data
	
msgNb:		.asciz "Entrez un nombre: \n"
msgErreur:	.asciz "Nombre non trouve.\n"
msgPos:		.asciz "La position du nombre est: "

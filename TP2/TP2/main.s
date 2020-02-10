			##################################
			#	     L3INFO - TP ARC2        #
			# 	 Manipulation de tableaux    #
			##################################
		
			.equ PRINT_INT, 1
			.equ PRINT_STRING, 4
			.equ READ_INT, 5
			.equ EXIT,	10

			.text
			.global main

lectureTableau:
			ret
			
affichageTableau:
			ret
			
			
main:
			# Affichage du message "Lecture du tableau"
			movia	r4, msgLecture
			addi	r2,	zero, PRINT_STRING
			trap
			
			# Lecture du tableau
			
			# ... (Votre code) ...
			
			# Affichage du message "Affichage du tableau"
			movia	r4, msgAffiche
			addi	r2,	zero, PRINT_STRING
			trap

			# Affichage du tableau
			
			# ... (Votre code) ...

			
			# On rend la main au système.
			addi	r2, zero, EXIT
			trap
	
			.data
msgLecture: .asciz "Lecture du tableau.\n"
msgAffiche: .asciz "Affichage du tableau.\n"

			# Tableau de 10 éléments
tableau:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
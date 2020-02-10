			########################
			#	L3INFO - TP ARC2   #
			# 	 Calcul de PGCD    #
			########################
		
			.equ PRINT_INT, 1
			.equ PRINT_STRING, 4
			.equ READ_INT, 5
			.equ EXIT,	10

			.text
			.global main
		
main:
			# Lecture de l'entier "a"
			movia		r4,	invite_a
			addi		r2, zero, PRINT_STRING
			trap
			
			addi		r2, zero, READ_INT
			trap
			
			movia		r3, a
			stw			r2, 0(r3)
			
			# Lecture de l'entier "b"
			movia		r4,	invite_b
			addi		r2, zero, PRINT_STRING
			trap
			
			addi		r2, zero, READ_INT
			trap
			
			movia		r3, b
			stw			r2, 0(r3)

			# Calcul du PGCD
			
			# ...
			# (Votre code ici)
			# ...
			
			# Affichage du résultat
			movia		r4, msg_res
			addi		r2, zero, PRINT_STRING
			trap
			
			movia		r3, resultat
			ldw			r4, 0(r3)
			addi		r2, zero, PRINT_INT
			trap
			
			addi		r2, zero, EXIT
			trap

.data
			
a:			.skip 4
b:			.skip 4
resultat:	.word 0
invite_a:	.asciz "Entrez un entier (a): "
invite_b:	.asciz "Entrez un entier (b): "
msg_res:	.asciz "Le PGCD de a et b est: "

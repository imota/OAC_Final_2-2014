.text	
###########plota a barra de load####################
#não salva os $s pois é o primeiro programa a rodar#
loadBar:
	li $s2, 200 #y
linhasdeloadhorizontal:
	li $s1, 60 #x inicial
	li $s3, 260 #x final
	add $a0, $s1, $zero
	add $a1, $s2, $zero
	li $a2, 0x44
	li $v0, 45
	syscall
	#linha de cima
	linhaLoadhorizontal:
		beq $s1, $s3, proximaLinhaloadhorizontal
		add $a0, $s1, $zero
		add $a1, $s2, $zero
		li $a2, 0x44
		li $v0, 45
		syscall
		addi $s1, $s1, 1
		j linhaLoadhorizontal

		proximaLinhaloadhorizontal:
			li $t0, 210
			beq $t0, $s2, linhasverticais
			li $s2, 210 #y
			j linhasdeloadhorizontal


linhasverticais:
	li $s2, 60 #agora é o x
linhasdeloadverticais:
	li $s1, 200 #y inicial
	li $s3, 210 #y final
	add $a0, $s2, $zero
	add $a1, $s1, $zero
	li $a2, 0x44
	li $v0, 45
	syscall
	#linha da esquerda
	linhaLoadvertical:
		beq $s1, $s3, proximaLinhaloadvertical
		add $a0, $s2, $zero
		add $a1, $s1, $zero
		li $a2, 0x44
		li $v0, 45
		syscall
		addi $s1, $s1, 1
		j linhaLoadvertical


		proximaLinhaloadvertical:
			li $t0, 260
			beq $t0, $s2, preenchendoBarra
			li $s2, 260
			j linhasdeloadverticais


preenchendoBarra:
	li $s0, 201 #y inicial
	li $s1, 209 #y final
	li $s2, 61  #x inicial
	li $s3, 260 #x final
	loopPreencher:
		beq $s2, $s3, pulaPreencher
		add $a0, $s2, $zero
		add $a1, $s0, $zero
		li $a2, 0xff
		li $v0, 45
		syscall
		addi $s2, $s2, 1
		j loopPreencher

		pulaPreencher:
			beq $s0, $s1, fimLinhaload
			addi $s0, $s0, 1
			li $s2, 61
			j loopPreencher


fimLinhaload:
addi $a0, $zero, 260
addi $a1, $zero, 210
li $a2, 0x44
li $v0, 45
syscall

jr $ra



##################################################
#  Funcao para preencher a barra de load         #
#  Parametros:                                   #
#  $a0 -> numero do arquivo	que ja passou 		 #
#  $a1 -> numero total de arquivos               #
##################################################
preenchePorcentagem:#
	#tem que salvar os $s
	addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
	
	li $s0, 202 #y inicial
	li $s1, 209 #y final
	li $s2, 62  #x inicial
	li $s3, 258 #x final

	sub $t0, $s3, $s2
	mult $t0, $a0
	mflo $t0
	div $t0, $a1
	mflo $t0
	add $t0, $t0, $s2
	move $s3, $t0

	loopPreencherPorcetagem:
		beq $s0, $s1, pulaPreencherPorcetagem
		add $a0, $s2, $zero
		add $a1, $s0, $zero
		li $a2, 0x44
		li $v0, 45
		syscall
		addi $s0, $s0, 1
		j loopPreencherPorcetagem

		pulaPreencherPorcetagem:
			beq $s2, $s3, fimPorcentagem
			addi $s2, $s2, 1
			li $s0, 202
			j loopPreencherPorcetagem


fimPorcentagem:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
	addi $sp, $sp, 16

    jr $ra
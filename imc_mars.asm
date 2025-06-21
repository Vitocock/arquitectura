.data
prompt_n_estudiantes: .asciiz "�Cu�ntos estudiantes hay en el curso? "
prompt_peso:         .asciiz "\nPeso en kg (ej. 70.5): "
prompt_altura:       .asciiz "Altura en metros (ej. 1.75): "
newline:             .asciiz "\n"
resultados:          .asciiz "\n--- Resultados del IMC del Curso ---\n"
imc_promedio_str:    .asciiz "IMC PROMEDIO: "
clasificacion_str:   .asciiz "\n--- Clasificacion del IMC de los estudiantes ---\n"
bajo_peso_str:       .asciiz "Bajo peso: "
normal_str:          .asciiz "\nPeso Normal: "
sobrepeso_str:       .asciiz "\nSobrepeso: "
obeso1_str:          .asciiz "\nObesidad grado I: "
obeso2_str:          .asciiz "\nObesidad grado II: "
obeso3_str:          .asciiz "\nObesidad grado III (M�rbida): "

# Constantes flotantes
f18_5: .float 18.5
f24_9: .float 24.9
f25:   .float 25.0
f29_9: .float 29.9
f30:   .float 30.0
f34_9: .float 34.9
f35:   .float 35.0
f39_9: .float 39.9
zero_float: .float 0.0

.text
.globl main
main:
    # Inicializar contadores
    li $t0, 0       # i = 0
    li $t1, 0       # bajo_peso
    li $t2, 0       # normal
    li $t3, 0       # sobrepeso
    li $t4, 0       # obeso_g1
    li $t5, 0       # obeso_g2
    li $t6, 0       # obeso_g3
    l.s $f12, zero_float  # imc_promedio = 0.0

    # Leer n�mero de estudiantes
    li $v0, 4
    la $a0, prompt_n_estudiantes
    syscall

    li $v0, 5
    syscall
    move $s0, $v0       # num_estudiantes

loop:
    beq $t0, $s0, done

    # Mostrar prompt peso
    li $v0, 4
    la $a0, prompt_peso
    syscall

    li $v0, 6
    syscall
    mov.s $f2, $f0       # peso

    # Mostrar prompt altura
    li $v0, 4
    la $a0, prompt_altura
    syscall

    li $v0, 6
    syscall
    mov.s $f4, $f0       # altura

    # IMC = peso / (altura * altura)
    mul.s $f6, $f4, $f4
    div.s $f8, $f2, $f6   # imc en $f8

    # Acumular imc_promedio
    add.s $f12, $f12, $f8

    # Clasificar IMC
    l.s $f10, f18_5
    c.lt.s $f8, $f10
    bc1t clas1

    l.s $f14, f18_5
    c.lt.s $f14, $f8
    bc1f clas_next2
    l.s $f10, f24_9
    c.lt.s $f8, $f10
    bc1t clas2
clas_next2:

    l.s $f14, f25
    c.lt.s $f14, $f8
    bc1f clas_next3
    l.s $f10, f29_9
    c.lt.s $f8, $f10
    bc1t clas3
clas_next3:

    l.s $f14, f30
    c.lt.s $f14, $f8
    bc1f clas_next4
    l.s $f10, f34_9
    c.lt.s $f8, $f10
    bc1t clas4
clas_next4:

    l.s $f14, f35
    c.lt.s $f14, $f8
    bc1f clas_next5
    l.s $f10, f39_9
    c.lt.s $f8, $f10
    bc1t clas5
clas_next5:

    j clas6

clas1:
    addi $t1, $t1, 1
    j next
clas2:
    addi $t2, $t2, 1
    j next
clas3:
    addi $t3, $t3, 1
    j next
clas4:
    addi $t4, $t4, 1
    j next
clas5:
    addi $t5, $t5, 1
    j next
clas6:
    addi $t6, $t6, 1

next:
    addi $t0, $t0, 1
    j loop

done:
    # Calcular imc_promedio = imc_promedio / num_estudiantes
    mtc1 $s0, $f14
    cvt.s.w $f14, $f14
    div.s $f12, $f12, $f14

    # Mostrar resultados
    li $v0, 4
    la $a0, resultados
    syscall

    li $v0, 4
    la $a0, imc_promedio_str
    syscall

    li $v0, 2
    mov.s $f12, $f12
    syscall

    li $v0, 4
    la $a0, clasificacion_str
    syscall

    li $v0, 4
    la $a0, bajo_peso_str
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, normal_str
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, sobrepeso_str
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, obeso1_str
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, obeso2_str
    syscall
    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, obeso3_str
    syscall
    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 10
    syscall


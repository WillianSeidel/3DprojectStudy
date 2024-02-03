extends MeshInstance3D
var speed = 2  # Ajuste a velocidade conforme necessário
var direction = -1  # 1 para cima, -1 para baixo
var max_distance = 10  # Ajuste conforme necessário
var original_position: Vector3  # Variável para armazenar a posição inicial
var distance_moved = 1  # Variável para rastrear a distância percorrida

func _ready():
	# Armazene a posição inicial
	original_position = position

func _process(delta):
	# Mova o objeto verticalmente
	translate(Vector3(0, 0, speed * direction * delta))

	# Atualize a distância percorrida
	distance_moved += speed * direction * delta

	# Verifique se atingiu a distância máxima ou mínima
	if abs(distance_moved) > max_distance:
		# Inverta a direção e redefina a distância percorrida
		direction *= -1
		distance_moved = 0

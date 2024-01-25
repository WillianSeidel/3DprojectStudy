extends CharacterBody3D

@onready var Cameramount = $Cameramount
@onready var animation_player = $Visual/gdbot/AnimationPlayer

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var sens_horizontal = 0.2
@export var sens_vertical = 0.4

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		Cameramount.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))
		

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if global_transform.origin.y < -10:  # Limite de queda, ajuste conforme necessário
		reset_player_position()  # Chamada para a função de reset

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if animation_player.current_animation != "jump":
			animation_player.play("jump")
		if animation_player.current_animation != "ground_impact":
			animation_player.play("ground_impact")
		
	var input_dir = Input.get_vector("right","left","backward","forward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
			
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func reset_player_position():
	global_transform.origin = Vector3(0, 2, 0)  # Defina a posição inicial do jogador conforme necessário
	velocity = Vector3.ZERO  # Reinicia a velocidade do jogador


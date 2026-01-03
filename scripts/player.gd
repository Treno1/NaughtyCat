extends CharacterBody2D
class_name CatPlayer

enum PlayerState { NORMAL, CUTSCENE }

signal system_ready

const SPEED = 130.0
const JUMP_VELOCITY = -200.0

@onready var animated_sprite: AnimatedSprite2D = $PlayerSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $InteractSprite/InteractArea/CollisionShape2D
@onready var _collision_x_pos = collision_shape.position.x
@onready var interact_sprite: AnimatedSprite2D = $InteractSprite

var player_state := PlayerState.NORMAL

var _is_poking := false


#region landings
var _landings := []

func add_landing(instance_id: int):
	if not _landings.has(instance_id):
		_landings.append(instance_id)
		
func remove_landing(instance_id: int):
	_landings.erase(instance_id)
	
func is_in_landing_zone():
	return !_landings.is_empty()
#endregion 

func _ready() -> void:
	GameManager.set_player(self)
	interact_sprite.visible = false
	emit_signal("system_ready")
	
	
func _physics_process(delta: float) -> void:
	if player_state != PlayerState.NORMAL:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("move_down"):
			position.y += 5
		else:
			velocity.y = JUMP_VELOCITY

	# Gets the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
		collision_shape.position.x = _collision_x_pos
	elif direction < 0:
		animated_sprite.flip_h = true
		collision_shape.position.x = _collision_x_pos * -1
		
	# Play animations
	# Interact
	if Input.is_action_just_pressed("interact"):
		animation_player.play("poke")
		
	if is_on_floor():
		if direction == 0:
			if !_is_poking:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		# Going up
		if velocity.y < 0:
			animated_sprite.play("jump")
		# Going down
		elif velocity.y > 0:
			if is_in_landing_zone():
				animated_sprite.play("land")
			else:
				animated_sprite.play("fly")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	_is_poking = false

func _on_animated_sprite_2d_animation_changed() -> void:
	_is_poking = false
	
func poke_animation() -> void:
	animated_sprite.play("poke")
	_is_poking = true
	
func set_state_cutscene() -> void:
	player_state = PlayerState.CUTSCENE
	
func set_state_normal() -> void:
	player_state = PlayerState.NORMAL
	

extends CharacterBody2D
class_name CatPlayer

const SPEED = 130.0
const JUMP_VELOCITY = -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var landings := []

func add_landing(instance_id: int):
	if not landings.has(instance_id):
		landings.append(instance_id)
		
func remove_landing(instance_id: int):
	landings.erase(instance_id)
	
func is_in_landing_zone():
	return !landings.is_empty()

func _ready() -> void:
	Game.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Gets the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	
	if is_on_floor():
		if direction == 0:
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

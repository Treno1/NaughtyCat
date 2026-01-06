extends RigidBody2D
class_name InteractableBody


signal interaction_complete

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var enabled: bool = true
@export var push_force:= 50
var _is_pushed = false
var _was_pushed = false
var _was_flying = false

func _ready() -> void:
	lock_rotation = true

func interact() -> void:
	_is_pushed = true
	_was_pushed = true
	
func complete_interaction() -> void:
	return
	
func is_flying() -> bool:
	if linear_velocity.y != 0:
		return linear_velocity.y != 0
	return false
	
func _physics_process(_delta: float) -> void:
	if !_was_pushed:
		return
		
	if _is_pushed:
		apply_impulse(Vector2(push_force, 0))
		_is_pushed = false
		return
		
	if is_flying():
		animated_sprite.play("falling")
		_was_flying = true
	elif _was_flying:
		animated_sprite.play("on_ground")
		if enabled:
			emit_signal("interaction_complete")
			print("body interaction complete")
			enabled = false
		
	
		
		

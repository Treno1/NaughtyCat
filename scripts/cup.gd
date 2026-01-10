extends RigidBody2D
class_name Cup

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: Interactable = $Area2D/Interactable

@export var enabled: bool = true
@export var push_force:= 50
var _is_pushed = false
var _was_pushed = false
var _was_flying = false

func _ready() -> void:
	interactable.interacted.connect(_interact)
	lock_rotation = true

func _interact() -> void:
	_is_pushed = true
	_was_pushed = true
	
func is_flying() -> bool:
	if linear_velocity.y != 0:
		return linear_velocity.y != 0
	return false
	
func _physics_process(_delta: float) -> void:
	if !_was_pushed or !interactable.enabled:
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
		if interactable.enabled:
			interactable.complete_interaction()
			print("body interaction complete")
		
	
		
		

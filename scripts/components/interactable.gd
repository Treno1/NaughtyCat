extends Component
class_name Interactable
## Interactable container which should sit under Area2D

signal interaction_complete
signal interacted

@export var enabled: bool = true

var _collition_atjusted := false

const INTERACTABLE_LAYER = 4
	
func _process(_delta: float) -> void:
	if !_collition_atjusted:
		_collition_atjusted = true
		var area = get_parent() as Area2D
		area.collision_layer = INTERACTABLE_LAYER
		area.collision_mask = 0

func interact() -> void:
	emit_signal("interacted")
	
func complete_interaction() -> void:
	enabled = false
	emit_signal("interaction_complete")

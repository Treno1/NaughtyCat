extends Component
class_name OnOffable

@export var target_sprite: Sprite2D = null
@export var target_interactable: Interactable = null

var completed := false

func _ready() -> void:
	target_interactable.interacted.connect(_interact)

func _interact() -> void:
	if target_sprite == null:
		return
	
	target_sprite.visible = !target_sprite.visible
	
	if !completed:
		target_interactable.complete_interaction()
		completed = true
	

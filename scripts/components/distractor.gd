extends Component
class_name Distractor

@export var distraction_area: Area2D = null
@export var control_interactable: Interactable = null
@export var enabled_on_start:= false
## If you want to run it once, turn it on. If you want to on and off it, set it to false
@export var switch_on_completion:= true

func _ready() -> void:
	if control_interactable != null:
		if switch_on_completion:
			control_interactable.interaction_complete.connect(_switch)
		else:
			control_interactable.interacted.connect(_switch)
	
	if enabled_on_start:
		distraction_area.monitorable = true
		distraction_area.monitoring = true
	else:
		distraction_area.monitorable = false
		distraction_area.monitoring = false

func _switch() -> void:
	distraction_area.monitorable = !distraction_area.monitorable
	distraction_area.monitoring = !distraction_area.monitoring

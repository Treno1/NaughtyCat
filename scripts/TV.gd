extends InteractableScratchable
class_name TV

@onready var distraction_area: Area2D = $DistractionArea

func complete_interaction() -> void:
	distraction_area.monitorable = true
	distraction_area.monitoring = true
	super.complete_interaction()

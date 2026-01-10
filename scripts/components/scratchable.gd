extends Component
class_name Scratchable
## Interactable container which should sit under Area2D

## Animations names should be 1,2,3,4 etc
@export var target_sprites: AnimatedSprite2D = null
@export var target_interactable: Interactable = null
@export var animations_count: int = 3

var scratch_cnt := 0

func _ready() -> void:
	target_interactable.interacted.connect(_interact)

func _interact() -> void:
	if target_sprites == null or scratch_cnt >= animations_count:
		return
		
	scratch_cnt+=1
	
	if scratch_cnt == 1:
		target_sprites.visible=true
	
	target_sprites.play(str(scratch_cnt))
	
	if scratch_cnt >= animations_count:
		self.monitorable = false
		self.monitoring = false
		
		target_interactable.complete_interaction()

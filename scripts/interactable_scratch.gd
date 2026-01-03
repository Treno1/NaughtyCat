extends Interactable

# Animations names should be 1,2,3,4 etc
@export var target_sprites: AnimatedSprite2D = null
@export var animations_count: int = 3

var scratch_cnt := 0

func interact() -> void:
	if target_sprites == null or scratch_cnt >= animations_count:
		return
		
	scratch_cnt+=1
	
	if scratch_cnt == 1:
		target_sprites.visible=true
	
	target_sprites.play(str(scratch_cnt))
	
	if scratch_cnt >= animations_count:
		self.monitorable = false
		self.monitoring = false
		
		complete_interaction()

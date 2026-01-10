extends Node2D

@export var is_scratched := false
@onready var couch_scratch_l: Interactable = $CouchScratchL/Interactable
@onready var couch_scratch_r: Interactable = $CouchScratchR/Interactable
@onready var scratch_sprite_l: AnimatedSprite2D = $CouchScratchL/ScratchSpriteL
@onready var scratch_sprite_r: AnimatedSprite2D = $CouchScratchR/ScratchSpriteR


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_scratched:
		couch_scratch_l.enabled = false
		scratch_sprite_l.play("3")
		couch_scratch_r.enabled = false
		scratch_sprite_r.play("4")
	else:
		couch_scratch_l.enabled = true
		scratch_sprite_l.play("idle")
		couch_scratch_r.enabled = true
		scratch_sprite_r.play("idle")

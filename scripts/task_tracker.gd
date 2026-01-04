extends Node
class_name TaskTracker

signal task_completed(task_tracker: TaskTracker)

var _task_data: TaskData = null
var _interactables: Array[Interactable] = []
var _interactions_to_complete: int = 0

func setup(task_data: TaskData) -> void:
	_task_data = task_data
	
	await get_tree().process_frame
	
	for node_path in _task_data.interactables_to_complete:
		var node = get_node_or_null(node_path)
		var interactable = node as Interactable
		if interactable != null:
			_interactables.append(interactable)
			interactable.interaction_complete.connect(_interaction_completed)
			_interactions_to_complete+=1
		else:
			push_error("Node is not a Interactable", node)
	
	# Setup label is task
	print(_task_data.task_ui_text)

func _interaction_completed() -> void:
	_interactions_to_complete -= 1
	print("interactions left: ", _interactions_to_complete)
	
	if _interactions_to_complete <= 0:
		emit_signal("task_completed", self)
		print("emited complete signal")
	
	
	

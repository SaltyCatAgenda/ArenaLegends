extends Node
class_name DummyToon

@onready var stats: ClassStats = $ClassStats

@export var starting_stats: ClassBaseResource

func _ready() -> void:
	stats.reinit(starting_stats)
	add_to_group("targetable")
	



func _on_test_enemy_input_event(camera, event, position, normal, shape_idx):
	pass # Replace with function body.

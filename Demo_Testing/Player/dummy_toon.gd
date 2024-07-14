extends Node
class_name DummyToon

@onready var stats: ClassStats = $ClassStats

@export var starting_stats: ClassBaseResource

#@export var parent: Player

@onready var parent = get_node("../")

func _ready() -> void:
	#print(parent)
	parent.collision_layer=2  # sets the object to be targetable
	stats.reinit(starting_stats)



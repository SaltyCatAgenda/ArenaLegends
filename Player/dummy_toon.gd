extends Node
class_name DummyToon

@onready var stats: ClassStats = $ClassStats

@export var starting_stats: ClassBaseResource

#@export var parent: CharacterBody3D

@onready var parent: CharacterBody3D = self.owner

func _ready() -> void:
	parent.collision_layer=2  # sets the object to be targetable
	stats.reinit(starting_stats)



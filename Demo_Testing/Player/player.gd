class_name Player
extends CharacterBody3D


@onready var pivot : Node3D = $PlayerPivot
@onready var cam_pivot : CamController = $CamPivot
@onready var spring_arm : SpringArm3D = $CamPivot/SpringArm3D
@onready var camera : Camera3D = $CamPivot/SpringArm3D/Camera3D

#@onready var animations = $animations
@onready var states: StateManager = $MovementMachine
@onready var stats: ClassStats = $DummyToon/ClassStats

@onready var targeting: Targeting = $Targeting
@onready var target = null

@onready var SPEED: float
const default_speed : float = 4.0
const ROT_SPEED : float  = 2.0
const JUMP_VELOCITY : int = 5
const gravity : int = 12
const PROJ:=preload("res://Scenes/projectile.tscn")


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	SPEED = default_speed + stats.speed
	states.init()

func _unhandled_input(event: InputEvent) -> void:
	cam_pivot.camsoda(event)
	states.input(event)
	#cast_ray(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	target = targeting.set_target(self,target)
	
func _process(delta: float) -> void: 
	states.process(delta)

func shoot() -> void:
	stats.set_mana(stats.get_mana() - 10)
	var prj := PROJ.instantiate()
	get_parent().add_child(prj)
	prj.global_transform = cam_pivot.global_transform
	

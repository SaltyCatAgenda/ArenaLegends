class_name MoveState
extends BaseState

@export var idle_state: Node
@export var fall_state: Node
@export var jump_state: Node

func enter():
	super.enter()

func input(event: InputEvent) -> BaseState:


	return null

func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input(delta)
	
	player.velocity = lerp(player.velocity,player.SPEED * move , 0.3)
	player.move_and_slide()
	if Input.is_action_pressed("jump"):
		return jump_state
	if move.length() == 0 and !any_buttons_pressed():
		return idle_state

	return null



class_name IdleState
extends BaseState


@export var move_state: Node
@export var fall_state: Node
@export var jump_state: Node
#@export var rotation_state: Node



func enter() -> void:
	super.enter()
	var vel = Vector3(0,0,0)
	player.velocity = vel

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("back"):
		return move_state
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		return move_state
	return null

func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state
	if Input.is_action_pressed("jump"):
		return jump_state
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			return move_state
		else:
			player.pivot.rotate_y(-1 * player.ROT_SPEED * Input.get_axis("left","right") * delta)
			player.cam_pivot.rotate_y(-1 * player.ROT_SPEED * Input.get_axis("left","right") * delta)
		#alternatively, we can return rotation state with this code + animations. see rotato below
	return null

func rotato() -> BaseState:
	#if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
#		return rotation_state
	return null

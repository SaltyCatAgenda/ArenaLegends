class_name BaseState
extends Node

#export (String) var animation_name

# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player

func enter() -> void:
	#player.animations.play(animation_name)
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null

#func get_move_inp(event: InputEvent) -> Vector3:
	#var wasd = Vector3()
	
func get_movement_input(delta: float) -> Vector3:	
	var wasd = Vector3()
	wasd.x = Input.get_axis("left", "right")
	wasd.z = Input.get_axis("forward","back")
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		
		if wasd.z == 1:
			wasd.z = 0
		else:
			wasd.z = -1
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		player.pivot.rotate_y(-1 * player.ROT_SPEED * wasd.x * delta)		
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			player.cam_pivot.rotate_y(-1 * player.ROT_SPEED * wasd.x * delta)
		wasd.x = 0
	return (player.pivot.transform.basis * wasd).normalized()

	
func any_buttons_pressed() -> bool:
	if Input.is_action_pressed("back") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		return true
	return false

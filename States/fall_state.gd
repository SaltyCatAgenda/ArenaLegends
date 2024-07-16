extends BaseState
class_name FallState

@export var move_state: Node
@export var idle_state: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	player.velocity.y -= player.gravity * delta
	var move = get_movement_input(delta)
	player.move_and_slide()

	if player.is_on_floor():
		if any_buttons_pressed():
			return move_state
		else: 
			return idle_state
		
		
#func any_buttons_pressed() -> bool:
#	if Input.is_action_pressed("back") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
#		return true
#	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
#		return true
#	return false
#
#func get_movement_input(delta: float) -> Vector3:	
#	var wasd = Vector3()
#	wasd.x = Input.get_axis("left", "right")
#	wasd.z = Input.get_axis("forward","back")
#
#	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
#		wasd.x = 0
#		if wasd.z == 1:
#			wasd.z = 0
#		else:
#			wasd.z = -1
#	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
#		player.pivot.rotate_y(-1 * player.ROT_SPEED * wasd.x * delta)		
#		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
#			player.cam_pivot.rotate_y(-1 * player.ROT_SPEED * wasd.x * delta)
#		wasd.x = 0
#	return (player.pivot.global_transform.basis * wasd).normalized()

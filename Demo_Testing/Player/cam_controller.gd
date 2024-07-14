extends Node3D
class_name CamController

var cursor_location: Vector2
@onready var cursor_moving: bool = false
const cam_sensitivity : float = 0.004
@onready var player : Player = get_node("../")  # can also use get_parent()
#@export var player : Player    # this would require setting the player manually.  not sure which method is better

func _input(event) -> void:
	if event.is_action_pressed("zoom_in"):
		if player.spring_arm.spring_length > 0:
			player.spring_arm.spring_length -= 0.5
	if event.is_action_pressed("zoom_out"):
		if player.spring_arm.spring_length < 10:
			player.spring_arm.spring_length += 0.5

func camsoda(event: InputEvent) -> void:
	enter_capture(event)
	is_rclick(event)
	cam_mouse_motion(event)
	set_cursor(cursor_location)

func is_rclick(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		player.pivot.global_transform.basis = global_transform.basis
		global_transform.basis = player.pivot.global_transform.basis

func enter_capture(event: InputEvent) -> void:
	if event is InputEventMouseButton and Input.get_mouse_mode()!=Input.MOUSE_MODE_CAPTURED:
		if event.pressed:
			cursor_location = event.position
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func set_cursor(cursor: Vector2) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:

		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_viewport().warp_mouse(cursor)
			#if !cursor_moving:
				#cast_ray(event)
			cursor_moving = false

func cam_mouse_motion(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			cursor_moving = true
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
				player.pivot.rotate_y(-event.relative.x * cam_sensitivity)
				rotate_y(-event.relative.x * cam_sensitivity)
			else:
				rotate_y(-event.relative.x * cam_sensitivity)
			player.spring_arm.rotate_x(-event.relative.y * cam_sensitivity)
			player.spring_arm.rotation.x = clamp(player.spring_arm.rotation.x, -PI/2, PI/4)



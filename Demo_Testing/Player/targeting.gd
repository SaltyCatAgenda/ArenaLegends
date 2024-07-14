extends Node3D
class_name Targeting

var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const RAY_LENGTH = 1000
var is_lclick: bool = false
var is_rclick: bool = false

func cast_ray_to_target(player, old_target):
	target = old_target
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		is_lclick = true
		is_rclick = false
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_lclick and !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and !is_rclick:
			is_lclick = false
			var space_state = get_world_3d().direct_space_state
			var cam = player.camera
			var mousepos = get_viewport().get_mouse_position()

			var origin = cam.project_ray_origin(mousepos)
			var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			query.collide_with_areas = true
			query.collision_mask = 2

			var result = space_state.intersect_ray(query)
			if result:
				if  result.collider.has_node("DummyToon"):
					target = result.collider
					#print("Enemy Spotted")
				else:
						target = old_target
		
	return target


func set_target(player, target):
	var new_target = cast_ray_to_target(player, target)
	if target!=new_target:
		target = new_target
		print(target)
	return target

extends Node3D
class_name Targeting

@onready var player:Player = self.owner

var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const RAY_LENGTH = 1000
var is_lclick: bool = false
var is_rclick: bool = false

var query = null

func cast_ray_to_target(old_target):
	target = old_target
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		is_lclick = true
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			is_rclick = true
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_lclick and !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and !is_rclick:
			is_lclick = false
			var space_state = get_world_3d().direct_space_state
			var cam = player.get_node("CamPivot/SpringArm3D/Camera3D")
			print(cam.name)
			var mousepos = get_viewport().get_mouse_position()

			var origin = cam.project_ray_origin(mousepos)
			var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			#query.exclude = [player]
			query.collide_with_areas = true
			query.collision_mask = 2

			var result = space_state.intersect_ray(query)
			if result:
				if  result.collider.has_node("DummyToon") and !player.get_node("CamPivot").cursor_moving:
					target = result.collider
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		is_lclick = false
		is_rclick = false
	return target


func set_target(target):
	var new_target = cast_ray_to_target(target)
	if target!=new_target:
		# can use collision layers/masks, groups, or string name for distinguishing friendly/enemy
		#if new_target.name=="Player":
			
		if target:
			target.get_node("Pivot/Skin/Model").get_children()[0] \
			.set_instance_shader_parameter("strength", 0.0)
		new_target.get_node("Pivot/Skin/Model").get_children()[0].set_instance_shader_parameter("strength", 1.0)
		target = new_target
		print(target)
	return target

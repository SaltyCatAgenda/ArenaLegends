extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.collision_mask=2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	position += -1 * global_transform.basis.z * 6 * delta


func _on_body_entered(body):
	# options for distinguishing between enemy/friendly : groups, collision layers/masks
	if body.name!="Player":
		#print(body.get_class())
		body.get_node("DummyToon").stats.take_damage(10)
		print(body.get_node("DummyToon").stats.get_health())
		queue_free()


func _on_area_entered(area:Area3D):
	area.get_node("DummyToon").stats.take_damage(10)
	print(area.get_node("DummyToon").stats.get_health())
	queue_free()

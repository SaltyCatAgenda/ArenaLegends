extends Button

@onready var CastBar1 = get_node("../../CastBar")
@onready var player: Player = get_node("../../../")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	CastBar1.visible = true
	player.shoot()
	CastBar1.value = 0
	var tween = get_tree().create_tween()
	tween.tween_property(CastBar1, "value",100,3).set_trans(Tween.TRANS_LINEAR)
	await get_tree().create_timer(3).timeout
	CastBar1.visible = false
	

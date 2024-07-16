extends BaseState
class_name JumpState

@export var fall_state: Node
@export var move_state: Node



# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	player.velocity.y = player.JUMP_VELOCITY
	#player.move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func physics_process(delta) -> BaseState:	
	var air_speed = 0.5 * player.SPEED
	
	
	var move = get_movement_input(delta)
	#if player.velocity.x == 0 and player.velocity.z== 0 :
		
		#player.velocity.x = move.x * air_speed
		#player.velocity.z = move.z * air_speed
	if (move.z != 0 and player.velocity.z==0) or (move.x!=0 and player.velocity.x==0):
		player.velocity.z = move.z * air_speed
		player.velocity.x = move.x * air_speed
	player.move_and_slide()
	player.velocity.y -= player.gravity * delta
	if player.velocity.y < 0:
		return fall_state
	if player.is_on_floor():
		return move_state	
	
	return null



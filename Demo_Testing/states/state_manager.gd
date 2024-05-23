extends Node
class_name StateManager

@export var starting_state: BaseState
@export var character : Player

var current_state: BaseState

func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	#push_warning(str(current_state))

# Initialize the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of
# and set a default state
#player: Player
func init() -> void:
	for child in get_children():
		if child is BaseState:
			child.player = character

			# Initialize with a default state of idle
			change_state(starting_state)
	
# Pass through functions for the Player to call,
# handling state changes as needed
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)

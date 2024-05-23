extends Node
class_name ClassStats


signal health_updated(health)
signal mana_updated(mana)
signal energy_updated(energy)
signal rage_updated(rage)

@onready var health: float : set = set_health, get = get_health
@onready var mana: int : set = set_mana, get = get_mana
@onready var energy: int : set = set_energy, get = get_energy
@onready var rage: int : set = set_rage, get = get_rage


@onready var character_name: String
#@onready var resource_type: ClassBaseResource.ResourceType
@onready var max_health: float
@onready var max_mana: int
@onready var max_energy: int
@onready var max_rage: int
@onready var armor: float
@onready var speed: float


func init_regen_timer(regen_func):
	var regen_timer: Timer = Timer.new()
	regen_timer.set_one_shot(false)
	regen_timer.set_wait_time(2.0)
	regen_timer.timeout.connect(_on_regen_timer_timeout.bind(regen_func))
	add_child(regen_timer)
	regen_timer.start()

func reinit(stats: ClassBaseResource) -> void:
	character_name = stats.character_name
	max_health = stats.max_health
	create_resource(stats)
	armor = stats.armor
	speed = stats.speed
	health = max_health
	mana = max_mana / 1.0
	#resource_type = stats.resource_type
	#print_debug(stats.ResourceType.keys()[resource_type])
	
func create_resource(stats: ClassBaseResource) -> void:
	var regen_resource: Callable
	match stats.resource_type:
		ClassBaseResource.ResourceType.MANA:
			max_mana = stats.max_mana
			regen_resource = regen_mana
		ClassBaseResource.ResourceType.ENERGY:
			max_energy = stats.energy
			regen_resource = regen_energy
		ClassBaseResource.ResourceType.RAGE:
			max_rage = stats.max_rage
			regen_resource = lose_rage
	init_regen_timer(regen_resource)


func take_damage(damage: float) -> void:
	var reduction: float = clamp((1.0 - armor / 100.0 ), 0 , 1.0 )
	var amount: float = get_health() - damage * reduction
	set_health(amount)

func set_health(new_health : float) -> void:
	var prev_health: float = get_health()
	health = clamp(new_health, 0, max_health)
	if get_health() != prev_health:
		emit_signal("health_updated", health)
		if get_health() == 0:
			kill()

func set_mana(new_mana: int) -> void:
	var prev_mana: int = get_mana()
	mana = clamp(new_mana, 0, max_mana)
	if get_mana() != prev_mana:
		emit_signal("mana_updated", mana)
		#print(get_mana())


func set_energy(new_energy: int) -> void:
	var prev_energy: int = get_energy()
	energy = clamp(new_energy, 0, max_energy)
	if get_energy() != prev_energy:
		emit_signal("energy_updated", energy)

func set_rage(new_rage: int) -> void:
	var prev_rage: int = get_rage()
	rage = clamp(new_rage, 0, max_rage)
	if get_rage() != prev_rage:
		emit_signal("rage_updated", rage)
	
func get_health() -> float:
	return health
	
func get_mana() -> float:
	return mana

func get_energy() -> float:
	return energy
	
func get_rage() -> float:
	return rage
	
func kill() -> void:
	pass

func regen_mana() -> void:
	var regen: float = 2.0
	if get_mana() < max_mana:
		set_mana(get_mana() + regen)
		print(get_mana())
		
func regen_energy() -> void:
	var e_regen: float = 5.0
	if get_energy() < max_energy:
		set_energy(get_energy() + e_regen)
		
func lose_rage() -> void:
	var rage_loss: float = 1.5
	# if out of combat for 6 seconds:
	set_rage(get_rage() - rage_loss)



func _on_regen_timer_timeout(regen_func) -> void:
	regen_func.call()

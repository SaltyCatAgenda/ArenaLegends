extends Resource
class_name ClassBaseResource

#@export_enum("MANA", "ENERGY", "RAGE") var ResourceType
enum ResourceType {MANA = 0, ENERGY = 1, RAGE = 2}

@export var character_name: String 
@export var resource_type: ResourceType
@export var max_health: float
@export var max_mana: int
@export var max_rage: int
@export var max_energy: int
@export var armor: float
@export var speed: float



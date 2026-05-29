extends CharacterBody2D


var player_pos
var target_pos
@export var SPEED := 300.0
@export var health := 25
@onready var player = get_parent().get_node("Weapon")
@onready var health_bar := $HealthBar

func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(delta: float) -> void:
	#Sets variables here so that they can update every tick
	player_pos = player.position 
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * SPEED * delta

func take_damage(damage) -> void:
	health -= damage
	
	if health <= 0:
		queue_free()
		
	health_bar.value -= damage

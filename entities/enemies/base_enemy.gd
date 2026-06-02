extends Area2D


var player_pos
var target_pos
@export var SPEED := 300.0
@export var health := 25
@export var enemy_damage := 1
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
		
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			player.player_take_damage(enemy_damage)

func take_damage(damage) -> void:
	print("damage")
	health -= damage
	
	if health <= 0:
		queue_free()
		
	health_bar.value -= damage

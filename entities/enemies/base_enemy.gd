extends Area2D


var player_pos
var target_pos
var enemy_health
var enemy_speed
var enemy_damage
@export var speed_multiple := 1.0
@export var health_multiple := 1.0
@export var damage_multiple := 1.0
@export var experience_given := 1
@onready var player = get_parent().get_node("Weapon")
@onready var health_bar := $HealthBar



func _ready() -> void:
	enemy_health = GameManager.mob_health * health_multiple
	enemy_speed = GameManager.mob_speed * speed_multiple
	enemy_damage = GameManager.mob_damage * damage_multiple
	health_bar.max_value = enemy_health
	health_bar.value = enemy_health

func _physics_process(delta: float) -> void:
	#Sets variables here so that they can update every tick
	player_pos = player.position 
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 60:
		position += target_pos * enemy_speed * delta
		
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			player.player_take_damage(enemy_damage)
		

func take_damage(damage) -> void:
	print("damage")
	enemy_health -= damage
	
	if enemy_health <= 0:
		GameManager.give_experience(experience_given)
		queue_free()
		
	health_bar.value -= damage

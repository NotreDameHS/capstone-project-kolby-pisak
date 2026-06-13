extends Node2D
@export var description := ""
@export var health_increase := 0.0
@export var movement_speed_increase := 0.0
@export var rotation_speed_increase := 0.0
@export var damage_increase := 0.0
@export var health_multiple := 1.0
@export var movement_speed_multiple := 1.0
@export var rotation_speed_multiple := 1.0
@export var fire_rate_multiple := 1.0
@export var damage_multiple := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player_health += health_increase
	GameManager.player_movement_speed += movement_speed_increase
	GameManager.rotation_speed += rotation_speed_increase
	GameManager.player_health *= health_multiple
	GameManager.player_movement_speed *= movement_speed_multiple
	GameManager.rotation_speed *= rotation_speed_multiple
	GameManager.shoot_time *= fire_rate_multiple
	GameManager.player_damage += damage_increase
	GameManager.player_damage *= damage_multiple

extends CharacterBody2D


var player_pos
var target_pos
@export var SPEED := 300.0
@export var health := 25
@onready var player = get_parent().get_node("Weapon")

func _physics_process(delta: float) -> void:
	player_pos = player.position 
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * SPEED * delta

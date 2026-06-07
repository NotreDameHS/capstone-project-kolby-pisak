extends Node2D

@export var point1: Vector2 = Vector2(-3940, -2170)
@export var point2: Vector2 = Vector2(3620, 2010)

@onready var enemy: Resource = preload("res://entities/enemies/enemy1.tscn")

var mobs_per_round = 5
var mobs_spawned = 0

func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	
	var random_point_inside: Vector2 = Vector2(x_value, y_value)
	
	return(random_point_inside)

func spawn_enemy():
	mobs_spawned += 1
	
	var mob: Node = enemy.instantiate()
	
	get_parent().add_child(mob)
	
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	
	mob.set_position(spawn_location)
	

func _on_timer_timeout() -> void:
	#Checks if there is less mobs spawned than the max per round
	if mobs_spawned < mobs_per_round:
		spawn_enemy()
		
	#Checks if the amount of mobs spawned is equal to the max per round and checks if they are all dead
	elif mobs_spawned >= mobs_per_round and get_tree().get_nodes_in_group("Enemy").is_empty() == true:
		print("round over")
		mobs_spawned = 0
		mobs_per_round += 5
		await get_tree().create_timer(5.0).timeout

extends Node2D

@export var point1: Vector2 = Vector2(-3940, -2170)
@export var point2: Vector2 = Vector2(3620, 2010)

@onready var enemy1: Resource = preload("res://entities/enemies/enemy1.tscn")
@onready var enemy2: Resource = preload("res://entities/enemies/enemy2.tscn")
@onready var enemy3: Resource = preload("res://entities/enemies/enemy3.tscn")

var mobs_v1_per_round := 5
var mobs_v1_spawned := 0
var mobs_v2_per_round := 0
var mobs_v2_spawned := 0
var mobs_v3_per_round := 0
var mobs_v3_spawned := 0

func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	
	var random_point_inside: Vector2 = Vector2(x_value, y_value)
	
	return(random_point_inside)

func spawn_enemy_one():
	mobs_v1_spawned += 1
	
	var mob: Node = enemy1.instantiate()
	
	get_parent().add_child(mob)
	
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	
	mob.set_position(spawn_location)
	

func spawn_enemy_two():
	mobs_v2_spawned += 1
	
	var mob2: Node = enemy2.instantiate()
	
	get_parent().add_child(mob2)
	
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	
	mob2.set_position(spawn_location)

func spawn_enemy_three():
	mobs_v3_spawned += 1
	
	var mob3: Node = enemy3.instantiate()
	
	get_parent().add_child(mob3)
	
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	
	mob3.set_position(spawn_location)

func _on_timer_timeout() -> void:
	#Checks if there is less mobs spawned than the max per round
	if mobs_v1_spawned < mobs_v1_per_round:
		spawn_enemy_one()
	
	if GameManager.round_number == 3:
		mobs_v2_per_round = 3
		
	if mobs_v2_spawned < mobs_v2_per_round:
		spawn_enemy_two()
	
	if GameManager.round_number == 5:
		mobs_v3_per_round = 1
	
	if mobs_v3_spawned < mobs_v3_per_round:
		spawn_enemy_three()
		
	#Checks if the amount of mobs spawned is equal to the max per round and checks if they are all dead
	elif mobs_v1_spawned >= mobs_v1_per_round and mobs_v2_spawned >= mobs_v2_per_round and get_tree().get_nodes_in_group("Enemy").is_empty() == true:
		print("round over")
		GameManager.increase_enemey_stats()
		mobs_v1_spawned = 0
		mobs_v1_per_round += 5
		mobs_v2_spawned = 0
		
		if GameManager.round_number > 3:
			mobs_v2_per_round += 3
			
		if GameManager.round_number > 5:
			mobs_v3_per_round += 1
				
		await get_tree().create_timer(5.0).timeout
	

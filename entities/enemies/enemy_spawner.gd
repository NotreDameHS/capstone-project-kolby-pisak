extends Node2D

@export var point1: Vector2 = Vector2(-3940, -2170)
@export var point2: Vector2 = Vector2(3620, 2010)

@onready var enemy: Resource = preload("res://entities/enemies/base_enemy.tscn")

func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	
	var random_point_inside: Vector2 = Vector2(x_value, y_value)
	
	return(random_point_inside)

func spawn_enemy():
	var mob: Node = enemy.instantiate()
	
	get_parent().add_child(mob)
	
	var spawn_location: Vector2 = get_random_point_inside(point1, point2)
	
	mob.set_position(spawn_location)
	

func _on_timer_timeout() -> void:
	spawn_enemy()

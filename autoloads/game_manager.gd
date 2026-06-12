extends Node
var player_xp := 0
var xp_required := 2
var enemies_killed := 0
var player_health := 100.0
var player_damage := 13.0
var player_movement_speed := 600.0
var shoot_time := 0.25
var current_level := 0
var mob_health := 25.0
var mob_speed := 300.0
var mob_damage := 1.0
var rotation_speed := 6.5
var round_number := 1
	
func give_experience(xp_given) -> void:
	enemies_killed += 1
	player_xp += xp_given
	
	if player_xp >= xp_required:
		player_health += 10
		xp_required *= 2
		current_level += 1
		print("XP for next level is ", xp_required)
		print("Current player health is ", player_health)
		
func increase_enemey_stats() -> void:
	mob_health *= 1.1
	mob_speed *= 1.1
	mob_damage *= 1.1
	round_number += 1

extends Node
var player_xp := 0
var xp_required := 5
var enemies_killed := 0
var player_health := 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func give_experience() -> void:
	player_xp += 1
	
	if player_xp == xp_required:
		xp_required *= 2
		player_health += 1500
		print("XP for next level is ", xp_required)
		print("Current player health is", player_health)

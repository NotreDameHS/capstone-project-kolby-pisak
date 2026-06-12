extends Control
var item_scenes := []

func _ready() -> void:
	#item_scenes.append()
	pass

func _physics_process(delta: float) -> void:
	if GameManager.player_xp >= GameManager.xp_required:
		pass
		

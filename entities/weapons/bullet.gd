extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
var damage = GameManager.player_damage
var speed: float = 1000

func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0).rotated(rotation) * speed * delta
	if RayCast.is_colliding():
		print("collide")
		var target = RayCast.get_collider()
		target.take_damage(damage)
		queue_free()
		

extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D

var speed: float = 120

func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0).rotated(rotation) * speed * delta
	if RayCast.is_colliding():
		queue_free()

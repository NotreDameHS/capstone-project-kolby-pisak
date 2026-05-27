extends CharacterBody2D

const SPEED = 600.0
@export var health := 100


func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
	
	if directionX:
		velocity.x = directionX * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if directionY:
		velocity.y = directionY * SPEED
		
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

extends Area2D
var velocity := Vector2(0, 0)
var max_speed := normal_speed
@export var normal_speed := 200.0
@export var boost_speed := 500.0
@export var steering_factor := 1.0

func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
		
	if velocity.length() > 0.0:
		# Instead of rotating the whole ship, we only rotate the Sprite2D
		get_node("Sprite2D").rotation = velocity.angle()
		
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()
	
	var desired_velocity := direction * max_speed
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta
	
	var viewport_size := get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
	
func _on_timer_timeout() -> void:
	max_speed = normal_speed

extends CharacterBody2D

#Weapon Variables
@onready var RotationOffset = $RotationOffset
@onready var ShootPos = $RotationOffset/WeaponSprite/ShootPos
@onready var ShootTimer = $ShootTimer
const bullet_scene = preload("res://entities/weapons/bullet.tscn")
var time_between_shot: float = 0.25
var can_shoot: bool = true


#Player Variables
var health :int = GameManager.player_health
@onready var player_health_bar = $PlayerUI/CanvasLayer/HealthBar
const player_speed = 600.0

func _ready() -> void:
	ShootTimer.wait_time = time_between_shot
	player_health_bar.max_value = health
	player_health_bar.value = health

func _physics_process(delta: float) -> void:
	#Player Code
	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
	
	if directionX:
		velocity.x = directionX * player_speed
	
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	
	if directionY:
		velocity.y = directionY * player_speed
		
	else:
		velocity.y = move_toward(velocity.x, 0, player_speed)

	move_and_slide()
	
	#Weapon Code
	#lerp_angle allows smooth rotation of weapon
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, ( get_global_mouse_position() - global_position).angle(), 6.5*delta) 
	
	if Input.is_action_just_pressed("shoot") and can_shoot: #Checks if weapon can attack
		_shoot()
		can_shoot = false
		ShootTimer.start() #Start weapon attack cooldown
		
	if GameManager.player_xp == GameManager.xp_required:
		health = GameManager.player_health
		player_health_bar.max_value = health
		player_health_bar.value = health
		
func _shoot():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = ShootPos.global_position
	new_bullet.global_rotation = ShootPos.global_rotation
	get_parent().add_child(new_bullet)

func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func player_take_damage(damage) -> void:
	health -= damage
	
	player_health_bar.value -= damage
	
	if health <= 0:
		queue_free()
		

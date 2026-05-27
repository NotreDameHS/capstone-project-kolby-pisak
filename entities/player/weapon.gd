extends CharacterBody2D

const bullet_scene = preload("res://entities/weapons/bullet.tscn")
const SPEED = 600.0
#Weapon Variables
@onready var RotationOffset = $RotationOffset
@onready var ShootPos = $RotationOffset/WeaponSprite/ShootPos
@onready var ShootTimer = $ShootTimer

var time_between_shot: float = 0.25
var can_shoot: bool = true

#Player Variables
@export var health := 100

func _ready() -> void:
	ShootTimer.wait_time = time_between_shot
	
func _physics_process(delta: float) -> void:
	#Player Code
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
	
	#Weapon Code
	#lerp_angle allows smooth rotation of weapon
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, ( get_global_mouse_position() - global_position).angle(), 6.5*delta) 
	
	if Input.is_action_just_pressed("shoot") and can_shoot: #Checks if weapon can attack
		_shoot()
		can_shoot = false
		ShootTimer.start() #Start weapon attack cooldown
		

		
		
func _shoot():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = ShootPos.global_position
	new_bullet.global_rotation = ShootPos.global_rotation
	get_parent().add_child(new_bullet)

func _on_shoot_timer_timeout() -> void:
	can_shoot = true

		

extends CharacterBody2D

#Weapon Variables
@onready var RotationOffset = $RotationOffset
@onready var ShootPos = $RotationOffset/WeaponSprite/ShootPos
@onready var ShootTimer = $ShootTimer
const bullet_scene = preload("res://entities/weapons/bullet.tscn")
var time_between_shot: float = GameManager.shoot_time
var can_shoot: bool = true


#Player Variables
var health :float = GameManager.player_health
var max_health :float = GameManager.player_health
var last_level := 0
var player_level
@onready var player_health_bar = $PlayerUI/CanvasLayer/HealthBar
@onready var player_experience_bar = $PlayerUI/CanvasLayer/ExperienceBar
@onready var player_health_remaining = $PlayerUI/CanvasLayer/HealthRemaining
var player_speed = GameManager.player_movement_speed

func _ready() -> void:
	ShootTimer.wait_time = time_between_shot
	player_health_bar.max_value = health
	player_health_bar.value = health

func _process(_delta: float) -> void:
	#Sets xp value
	player_experience_bar.value = GameManager.player_xp
	#Set current player level
	player_level = GameManager.current_level
	
	#Check is player has leveled up
	if player_level == last_level + 1:
		#Makes last level match current level
		last_level += 1
		
		#Sets all UI to match values
		$PlayerUI/CanvasLayer/LevelLabel.text = "Current Level: "  + str(player_level)
		health = GameManager.player_health
		max_health = GameManager.player_health
		player_health_bar.max_value = health
		player_health_bar.value = health
		player_experience_bar.min_value = GameManager.player_xp
		player_experience_bar.max_value = GameManager.xp_required
		
	player_health_remaining.text = str(int(health)) + "/" + str(int(max_health))
	$PlayerUI/CanvasLayer/RoundLabel.text = "Current Round: "  + str(GameManager.round_number)
	
func _physics_process(delta: float) -> void:
	#Player Code
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = input_direction * player_speed

	move_and_slide()
	
	#Weapon Code
	#lerp_angle allows smooth rotation of weapon
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, ( get_global_mouse_position() - global_position).angle(), GameManager.rotation_speed*delta) 
	
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

func player_take_damage(damage) -> void:
	health -= damage
	
	player_health_bar.value -= damage

	if health <= 0:
		queue_free()
		

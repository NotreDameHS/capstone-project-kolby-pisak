extends Node2D

@onready var camera := $Weapon/PlayerSprite/Camera2D

#Level boundary
@export var left_boundary := -4000
@export var right_boundary := 3680
@export var top_boundary := -2250
@export var bottom_boundary := 2102

func _ready() -> void:
	#Setting player camera limits to player boundary
	camera.limit_left = left_boundary
	camera.limit_right = right_boundary
	camera.limit_bottom = bottom_boundary
	camera.limit_top = top_boundary

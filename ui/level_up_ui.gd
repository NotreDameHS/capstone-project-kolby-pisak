extends Control
var item_scenes := [preload("res://entities/collectibles/creatine.tscn"),
preload("res://entities/collectibles/energy_drink.tscn"),
preload("res://entities/collectibles/mass_gainer.tscn"),
preload("res://entities/collectibles/pills.tscn"),
preload("res://entities/collectibles/speed_potion.tscn"),
preload("res://entities/collectibles/steak.tscn"),
preload("res://entities/collectibles/steroids.tscn"),
preload("res://entities/collectibles/stim.tscn"),
preload("res://entities/collectibles/trigger_finger.tscn")]
	
var item1 :Node2D = item_scenes.pick_random().instantiate()
var item2 :Node2D = item_scenes.pick_random().instantiate()
var item3 :Node2D = item_scenes.pick_random().instantiate()


@onready var button1 := $CanvasLayer/VBoxContainer/Button
@onready var button2 := $CanvasLayer/VBoxContainer2/Button2
@onready var button3 := $CanvasLayer/VBoxContainer3/Button3

func _ready() -> void:
	button1.texture_normal = item1.get_node("normal").texture
	button1.texture_pressed = item1.get_node("pressed").texture
	button2.texture_normal = item2.get_node("normal").texture
	button2.texture_pressed = item2.get_node("pressed").texture
	button3.texture_normal = item3.get_node("normal").texture
	button3.texture_pressed = item3.get_node("pressed").texture
	$CanvasLayer/VBoxContainer/Label.text = item1.description
	$CanvasLayer/VBoxContainer2/Label.text = item2.description
	$CanvasLayer/VBoxContainer3/Label.text = item3.description
	$CanvasLayer/VBoxContainer/NameLabel.text = item1.item_name
	$CanvasLayer/VBoxContainer2/NameLabel.text = item2.item_name
	$CanvasLayer/VBoxContainer3/NameLabel.text = item3.item_name
	
	
	
func _on_button_pressed() -> void:
	GameManager.player_health += item1.health_increase
	GameManager.player_movement_speed += item1.movement_speed_increase
	GameManager.rotation_speed += item1.rotation_speed_increase
	GameManager.player_health *= item1.health_multiple
	GameManager.player_movement_speed *= item1.movement_speed_multiple
	GameManager.rotation_speed *= item1.rotation_speed_multiple
	GameManager.shoot_time *= item1.fire_rate_multiple
	GameManager.player_damage += item1.damage_increase
	GameManager.player_damage *= item1.damage_multiple
	get_parent().change_stats()
	queue_free()

func _on_button_2_pressed() -> void:
	GameManager.player_health += item2.health_increase
	GameManager.player_movement_speed += item2.movement_speed_increase
	GameManager.rotation_speed += item2.rotation_speed_increase
	GameManager.player_health *= item2.health_multiple
	GameManager.player_movement_speed *= item2.movement_speed_multiple
	GameManager.rotation_speed *= item2.rotation_speed_multiple
	GameManager.shoot_time *= item2.fire_rate_multiple
	GameManager.player_damage += item2.damage_increase
	GameManager.player_damage *= item2.damage_multiple
	get_parent().change_stats()
	queue_free()

func _on_button_3_pressed() -> void:
	GameManager.player_health += item3.health_increase
	GameManager.player_movement_speed += item3.movement_speed_increase
	GameManager.rotation_speed += item3.rotation_speed_increase
	GameManager.player_health *= item3.health_multiple
	GameManager.player_movement_speed *= item3.movement_speed_multiple
	GameManager.rotation_speed *= item3.rotation_speed_multiple
	GameManager.shoot_time *= item3.fire_rate_multiple
	GameManager.player_damage += item3.damage_increase
	GameManager.player_damage *= item3.damage_multiple
	get_parent().change_stats()
	queue_free()

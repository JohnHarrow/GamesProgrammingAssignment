extends Control

var stats = PlayerStats

func _ready():
	$VBoxContainer/Level1.grab_focus()


func _on_Level1_pressed():
	stats.health = 4
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Level 1.tscn")


func _on_Level2_pressed():
	stats.health = 4
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")


func _on_Level3_pressed():
	stats.health = 4
	pass 


func _on_Back_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")

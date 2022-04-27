extends Control



func _ready():
	$VBoxContainer/Button.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")

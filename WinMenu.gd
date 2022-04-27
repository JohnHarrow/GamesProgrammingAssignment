extends Control

func _ready():
	$VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")

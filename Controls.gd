extends Control


func _ready():
	$VBoxContainer/BackButton.grab_focus()

func _on_BackButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")


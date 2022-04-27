extends Control


func _ready():
	$VBoxContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://LevelSelect.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ControlsButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Controls.tscn")

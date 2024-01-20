extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$controls/Start.grab_focus()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://controlscreen.tscn")


func _on_quit_pressed():
	get_tree().quit()

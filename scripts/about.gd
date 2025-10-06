extends Control


func _on_help_pressed() -> void:
	GlobalStates.closeAbout.emit()
	visible = false

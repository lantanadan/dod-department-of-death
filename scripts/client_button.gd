extends Button

var client : int = 0

func _on_pressed() -> void:
	GlobalStates.chosenClient = client
	queue_free()

extends Control

signal continueClicked

@onready var user: LineEdit = $MarginContainer/VBoxContainer/User
@onready var button: Button = $MarginContainer/VBoxContainer/Button

func _ready() -> void:
	$MarginContainer.modulate.a = 0
	var fadeIn = create_tween()
	fadeIn.tween_property($MarginContainer,"modulate:a",1,1)
	user.grab_focus()
	user.grab_click_focus()

func _on_button_pressed() -> void:
	toIntro()

func toIntro():
	GlobalStates.player_name = user.text
	continueClicked.emit()

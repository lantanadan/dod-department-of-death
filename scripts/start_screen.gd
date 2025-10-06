extends Control

signal newGame

@onready var intro_text: RichTextLabel = $MarginContainer/RichTextLabel

# This is the wrong way to do this but %s is not cooperating
func _ready() -> void:
	intro_text.text = "Oh hi there, "+GlobalStates.player_name+"! You must be new here. Well, let me be the first to break the bad news to you. You're dead. But, as they say upstairs, death is an opportunity... a JOB opportunity!

Welcome to your first day at the [i]Department of Death[/i]. Your job is to review dossiers on the recently deceased. But you're not here to pass judgment. You're their travel agent! Everyone goes to the same place, but when and how they get there is up to how they lived... and how much cash they were buried with.

Remember, you're working on commission (5%). Get your clients the best package they both deserve and can afford. If you're feeling extra nice, you can cover the difference on more expensive packages, but that's coming out of your pay.

Just try not to cheap out our customers, yeah? We've got a reputation to uphold, and we wouldn't want you pushin' up daisies... again. So get hustlin'!
     [i]- Donovan [/i]				(Press any key to continue)"
	var typed_intro = create_tween()
	typed_intro.tween_property(intro_text,"visible_ratio",1,10)
	await typed_intro.finished
	$TypingSound.stop()
	

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		newGame.emit()

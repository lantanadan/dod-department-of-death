extends Control
@onready var rich_text_label: RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
@onready var continueButton: Button = $VBoxContainer/HBoxContainer/Continue


@export_enum ("Day Success","Bankrupt","Low Rating","Failure","Broke Even","Win-Broke","Win-Awful","Win-BrokeAndAwful","Win-Win","Win-Even") var endState : int = 0
var endMessage : String = ""

func _ready() -> void:
	if GlobalStates.level < 7:
		if GlobalStates.money > 0:
			if GlobalStates.rating >= GlobalStates.ratingGoal:
				endState = 0
			else:
				endState = 2
				
		if GlobalStates.money < 0:
			if GlobalStates.rating >= GlobalStates.ratingGoal:
				endState = 1
			else:
				endState = 3
		if GlobalStates.money == 0:
			endState = 4
	
	if GlobalStates.level == 8:
		if GlobalStates.money < 0:
			if GlobalStates.rating >= GlobalStates.ratingGoal:
				endState = 5
			else:
				endState = 7
		if GlobalStates.money > 0:
			if GlobalStates.rating >= GlobalStates.ratingGoal:
				endState = 6
			else:
				endState = 8
		if GlobalStates.money == 0:
			endState = 9
	
	if endState > 0 or GlobalStates.level == 8:
		continueButton.queue_free()
	rich_text_label.visible_ratio = 0.0
	message()

func message():
	if endState == 0:
		endMessage = "Well look at you, " + GlobalStates.player_name + "! The clients love ya and the cashflow is positive. You've made me one happy corpse.

Let's see if you can keep this going!

[i]- Donovan[/i]"
############################
	if endState == 1:
			endMessage = GlobalStates.player_name + ", I told you not to overdraw your funds! Now look at ya.

The clients love ya but if you're going to bankrupt my company, I can't afford keep you around. Your services are no longer required.

-[i] Donovan[/i]"
############################
	if endState == 2:
		endMessage = GlobalStates.player_name + ", we need to have a serious conveesation about hospitality.

Here at the Department of Death we treat our clients with respect, and I've had too many complaints about the packages you're setting them up with.

I'd say do better next time, but there won't be a next time. Pack your belongings and don't come back tomorrow.

-[i] Donovan [/i]"
############################
	if endState == 3:
		endMessage = GlobalStates.player_name + ", I just reviewed your records for the day.

You're telling me you bankrupted my company AND disrespected our clients?!

I've had it with you. Security is on the way. Don't even bother packing your belongings. You won't need em where you're going.

[i]- Donovan[/i]"
############################
	if endState == 4:
		endMessage = "You must be some kind of miracle worker, " + GlobalStates.name + ". Somehow you ended the day with exactly Net-0 cashflow.
		
I'm not gonna fire ya but I'm not gonna reward ya either. Bring in some PREMIUM sales tomorrow or we're both gonna be in trouble.
		
-[i] Donovan [/i]"
############################
	if endState == 5:
		endMessage = "Okay, kid. You've got some skills to last this long, I'll give you that.

That said, " + GlobalStates.player_name + ", I'm not too happy you've left the company in shambles. And on the Day of the Dead no less!

Consider this a victory, if a hollow one. I'll let you off the hook for now, but I know you could've done better.
-[i] Donovan [/i]"
############################
	if endState == 6:
		endMessage = "Congratulations, " + GlobalStates.player_name + ", you are OFFICIALLY my hero!
 
This office has never had anyone in sales quite like you. We've got cash to burn and reputation to die for... metaphorically speaking, of course.

Take the weekend, kid, and come find me on Monday. I've needed a winner like you on my team for a LONG time. You're the missing domino we've always needed to actually count our pips.

We're gonna do big things, you and I. BIG.

-[i] Donovan [/i]"
############################
	if endState == 7:
		endMessage = "I know you've only been with us a week, but I never thought I'd say this:

" + GlobalStates.player_name + ", you're an embarrassment to this whole office! What, you're just gonna string along me, your coworkers, and your clients for a whole WEEK before you crash out?

You've left us bankrupt. You've left us untrusted. The boys downdown are already calling me, demanding to know who the agent is who's ruined our reputation.

I haven't dimed you out. I'm not that kind of guy and you still did good work these last few days. But for both our sakes, stay home tomorrow. And the next day. And the day after that. Etcetera.

-[i] Donovan [/i]"
############################
	if endState == 8:
		endMessage = "What happened, " + GlobalStates.player_name + "? You made it a whole week making your clients happy and then what, you throw in the towel?

Maybe it's my fault. Maybe I ask too much of my agents. But I've seen how you work and I know you're capable of so much more.

You did good. Not the best, but good. I still think you have what it takes to be the best, just not this time.

-[i] Donovan [/i]"
############################
	rich_text_label.text = endMessage
	var typing = create_tween()
	typing.tween_property(rich_text_label,"visible_ratio",1,5)
	await typing.finished
	$Typesound.stop()

func _on_continue_pressed() -> void:
	GlobalStates.newDay.emit()
	queue_free()


func _on_restart_pressed() -> void:
	GlobalStates.restart.emit()
	queue_free()

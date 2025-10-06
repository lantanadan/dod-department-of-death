extends Control

signal sendText

@export var packageName : String
@export var packageDescription : String
@export var cardNumber : int
var price : int = 0
var startingAngle : float
var rotationDirection : int
var selected : bool

func _ready() -> void:
	rotation_degrees = randf_range(-4.0,4.0)
	rotationDirection = randi_range(0,1)
	$Button.connect("mouse_entered",grabFocus)
	scale = Vector2(0.75,0.75)
	modulate = Color(0.7,0.7,0.7,1)
	
	# Set Card Prices
	if cardNumber == 0:
		price = GlobalStates.package0
	if cardNumber == 1:
		price = GlobalStates.package1
	if cardNumber == 2:
		price = GlobalStates.package2
	if cardNumber == 3:
		price = GlobalStates.package3
	
	packageName = packageName + str(price)
	

func _process(delta: float) -> void:
	if rotationDirection == 0:
		if rotation_degrees >= -2.0:
			rotation_degrees -= delta
		else:
			rotationDirection = 1
	else:
		if rotation_degrees <= 2.0:
			rotation_degrees += delta
		else:
			rotationDirection = 0
	
	if not has_focus():
		#if selected == true:
		var zoomOut = create_tween()
		var zoomColor = create_tween()
		zoomOut.tween_property(self,"scale",Vector2(0.75,0.75),0.25)
		zoomColor.tween_property(self,"modulate",Color(0.7,0.7,0.7,1),0.25)
		selected = false
		#if selected == false:
			#scale = Vector2(0.75,0.75)
			#modulate = Color(0.7,0.7,0.7,1)
	else:
		if selected == false:
			var zoomIn = create_tween()
			var zoomColor = create_tween()
			zoomIn.tween_property(self,"scale",Vector2(1,1),0.25)
			zoomColor.tween_property(self,"modulate",Color(1,1,1,1),0.25)
			sendText.emit(packageName,packageDescription)
			selected = true

func grabFocus():
	grab_focus()
	grab_click_focus()


func _on_button_pressed() -> void:
	if GlobalStates.clientStats[str(GlobalStates.chosenClient)]["BURIEDWORTH"] >= price:
		if cardNumber == 0:
			if GlobalStates.clientStats[str(GlobalStates.chosenClient)]["FREENINE"] == false:
				GlobalStates.soldTravelPackage.emit(price*0.05,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["NINERATING"])
			else:
				GlobalStates.soldTravelPackage.emit(0,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["NINERATING"])
		if cardNumber == 1:
			GlobalStates.soldTravelPackage.emit(price*0.05,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["SHIPRATING"])
		if cardNumber == 2:
			GlobalStates.soldTravelPackage.emit(price*0.05,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["CARRATING"])
		if cardNumber == 3:
			GlobalStates.soldTravelPackage.emit(price*0.05,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["COFFINRATING"])
	else:
		if cardNumber == 0:
			if GlobalStates.clientStats[str(GlobalStates.chosenClient)]["FREENINE"] == false:
				GlobalStates.soldTravelPackage.emit(GlobalStates.clientStats[str(GlobalStates.chosenClient)]["BURIEDWORTH"]-price,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["NINERATING"])
			else:
				GlobalStates.soldTravelPackage.emit(0,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["NINERATING"])
		if cardNumber == 1:
			GlobalStates.soldTravelPackage.emit(GlobalStates.clientStats[str(GlobalStates.chosenClient)]["BURIEDWORTH"]-price,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["SHIPRATING"])
		if cardNumber == 2:
			GlobalStates.soldTravelPackage.emit(GlobalStates.clientStats[str(GlobalStates.chosenClient)]["BURIEDWORTH"]-price,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["CARRATING"])
		if cardNumber == 3:
			GlobalStates.soldTravelPackage.emit(GlobalStates.clientStats[str(GlobalStates.chosenClient)]["BURIEDWORTH"]-price,GlobalStates.clientStats[str(GlobalStates.chosenClient)]["COFFINRATING"])	

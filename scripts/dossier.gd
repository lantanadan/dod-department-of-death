extends Control

@onready var number_nine: Control = $"VBoxContainer/Travel Packages/HBoxContainer/NumberNine"
@onready var luxury_cruise: Control = $"VBoxContainer/Travel Packages/HBoxContainer/LuxuryCruise"
@onready var car: Control = $"VBoxContainer/Travel Packages/HBoxContainer/Car"
@onready var coffin: Control = $"VBoxContainer/Travel Packages/HBoxContainer/Coffin"
@onready var package_name: Label = $"VBoxContainer/Travel Packages/VBoxContainer/PackageName"
@onready var package_description: Label = $"VBoxContainer/Travel Packages/VBoxContainer/PackageDescription"

@onready var clientName: Label = $VBoxContainer/HBoxContainer/VBoxContainer/NameBox/NameData
@onready var occupation: Label = $VBoxContainer/HBoxContainer/VBoxContainer/OccuptationBox/OccupationData
@onready var netWorth: Label = $VBoxContainer/HBoxContainer/VBoxContainer/NetWorthBox/NWData
@onready var buriedWorth: Label = $VBoxContainer/HBoxContainer/VBoxContainer/BuriedBox/BuriedNetWorthData
@onready var timeOfDeath: Label = $VBoxContainer/HBoxContainer/VBoxContainer2/TimeOfDeathBox/TODData
@onready var causeOfDeath: Label = $VBoxContainer/HBoxContainer/VBoxContainer2/CauseOfDeathBox/CODData
@onready var virtues: Label = $VBoxContainer/HBoxContainer/VBoxContainer2/VirtuesBox/VirtuesData
@onready var sins: Label = $VBoxContainer/HBoxContainer/VBoxContainer2/SinsBox/SinsData
@onready var recommended: Label = $"VBoxContainer/Travel Packages/Recommended/PackageData"

func _ready() -> void:
	# Load client data
	loadClient()
	
	number_nine.connect("sendText",loadText)
	number_nine.connect("focus_entered",gotFocus)
	luxury_cruise.connect("sendText",loadText)
	luxury_cruise.connect("focus_entered",gotFocus)
	car.connect("sendText",loadText)
	car.connect("focus_entered",gotFocus)
	coffin.connect("sendText",loadText)
	coffin.connect("focus_entered",gotFocus)
	
	package_name.text = ""
	package_description.text = ""

func loadClient():
	# Okay nowhere in the docs does it say anything about dynamically picking a key based on a declared variable
	# So basically you have to feed in the value as a parameter and then pull it as a STRING to find its dictionary value
	# I loathe this
	clientName.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["FNAME"] + " " + GlobalStates.clientStats[str(GlobalStates.chosenClient)]["LNAME"]
	occupation.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["OCCUPATION"]
	netWorth.text = "$"+str(GlobalStates.clientStats[(str(GlobalStates.chosenClient))]["NETWORTH"])
	buriedWorth.text = "$"+str(GlobalStates.clientStats[str((GlobalStates.chosenClient))]["BURIEDWORTH"])
	timeOfDeath.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["TIMEOFDEATH"]
	causeOfDeath.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["CAUSEOFDEATH"]
	virtues.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["VIRTUES"]
	sins.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["SINS"]
	recommended.text = GlobalStates.clientStats[str(GlobalStates.chosenClient)]["RECOMMENDED"]

func loadText(packageName,description):
	package_name.text = packageName
	package_description.text = description

func gotFocus():
	$SFX/Focus.play()

extends Control
@onready var agent_name: Label = $VBoxContainer/HBoxContainer/AgentName
@onready var total_funds: Label = $VBoxContainer/HBoxContainer/TotalFunds
@onready var content: Control = $VBoxContainer/Content/VBoxContainer
@onready var total_rating: Label = $VBoxContainer/HBoxContainer/TotalRating
@onready var client_box: HBoxContainer = $VBoxContainer/Content/VBoxContainer/Clients/TodaysClients

@export var clientButton : PackedScene

const DOSSIER = preload("uid://cl3t1b2nw6ly6")
const RESULTS_SCREEN = preload("uid://5tfmiowxx72s")

var adjustedBalance : int = 0
var adjustFundCount : bool = false
var adjustedRating : float = 1.0

var todaysClients : Array
var remainingClients: int = 3

func _ready() -> void:
	GlobalStates.connect("soldTravelPackage",saleMade)
	GlobalStates.connect("newDay",startNewDay)
	GlobalStates.connect("restart",newGame)
	GlobalStates.connect("closeAbout",reappear)
	
	agent_name.text = GlobalStates.player_name
	total_funds.text = "$"+str(GlobalStates.money)
	adjustedBalance = GlobalStates.money
	total_rating.text = str(snapped(GlobalStates.rating,0))+"%"
	
	pickClients()
	ratingGoal()

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#balanceSheet = -100
		#countFunds()
	total_funds.text = "$"+str(adjustedBalance)
	total_rating.text = str(snapped(adjustedRating*100,0))+"%"

func ratingGoal():
	GlobalStates.ratingGoal = 0.1*GlobalStates.level

func countFunds(balanceSheet):
	GlobalStates.money += balanceSheet
	var adjustFunds = create_tween()
	adjustFunds.tween_property(self,"adjustedBalance",GlobalStates.money,1)
	await adjustFunds.finished
	total_funds.text = "$"+str(GlobalStates.money)
	
func calculateRating(addValue):
	print("Original Rating: " + str(GlobalStates.rating))
	print("Add Rating: " + str(addValue))
	var currentRating : float
	currentRating = GlobalStates.rating + addValue
	GlobalStates.possibleRatings += 1.0
	GlobalStates.rating = currentRating/GlobalStates.possibleRatings
	print("Current Rating: " + str(GlobalStates.rating))
	countRating()
	
func countRating():
	var adjustRating = create_tween()
	adjustRating.tween_property(self,"adjustedRating",GlobalStates.rating,1)
	await adjustRating.finished
	total_rating.text = str(snapped(adjustedRating*100,0))+"%"
	
	
func openDossier():
	content.get_node("Clients").visible = false
	var newDossier = DOSSIER.instantiate()
	content.add_child(newDossier)
	$SFX/Select.play()



func gotFocus():
	$SFX/Focus.play()

func pickClients():
	# Build a blank clients array
	%Title.text = "Active Clients"
	if GlobalStates.day <= 31:
		%Date.text = "October " + str(GlobalStates.day) + " 1998"
	else:
		%Date.text = "November 1, 1998"
	remainingClients = 3
	var clients : Array
	for i in GlobalStates.totalClients:
		# Populate the array with the total number of clients
		clients.append(i)
		# Shuffle the numbers just for the sake of randomness
		clients.shuffle()
	# Pick today's 3 clients
	var clientList = 3
	for i in clientList:
		# Pick a random client number from the total remaining list
		var chosenClient = clients.pick_random()
		# Add that client to the full client list for the day
		todaysClients.append(chosenClient)
		clientButtons(chosenClient)
		# Erase that client from the list to prevent duplicates
		clients.erase(chosenClient)
		
func clientButtons(chosenClient):
	var newButton = clientButton.instantiate()
	client_box.add_child(newButton)
	newButton.client = chosenClient
	newButton.text = GlobalStates.clientStats[str(chosenClient)]["LNAME"]+" , "+GlobalStates.clientStats[str(chosenClient)]["FNAME"]
	newButton.connect("pressed",openDossier)
	newButton.connect("mouse_entered",gotFocus)

func saleMade(price,opinion):
	countFunds(price)
	calculateRating(opinion)
	$SFX/Counter.play()
	content.get_node("Dossier").queue_free()
	content.get_node("Clients").visible = true
	remainingClients -= 1
	if remainingClients == 0:
		endOfDay()

func endOfDay():
	%Title.text = "EOD Results"
	var newResults = RESULTS_SCREEN.instantiate()
	content.add_child(newResults)
	#content.move_child(newResults,2)

func startNewDay():
	await get_tree().create_timer(0.75).timeout
	GlobalStates.day += 1
	GlobalStates.level += 1
	pickClients()
	ratingGoal()

func newGame():
	GlobalStates.newGame()
	total_funds.text = "$"+str(GlobalStates.money)
	adjustedBalance = GlobalStates.money
	total_rating.text = "100%"
	adjustedRating = GlobalStates.rating
	await get_tree().create_timer(0.75).timeout
	pickClients()
	ratingGoal()

func _on_help_pressed() -> void:
	GlobalStates.openAbout.emit()
	self.visible = false

func reappear():
	self.visible = true

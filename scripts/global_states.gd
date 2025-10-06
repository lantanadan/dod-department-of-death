extends Node

signal soldTravelPackage
signal newDay
signal restart
signal openAbout
signal closeAbout

var json_path = "res://assets/data/clients.json"
var player_name : String = ""
var money : int = 1000
var rating : float = 1.0
var possibleRatings : float = 1.0
var clientStats : Dictionary
var totalClients : int = 6
var day : int = 25
var level : float = 1.0
var ratingGoal : float = 0.0
var chosenClient : int = 0
var package0: int = 39999
var package1: int = 24999
var package2: int = 12999
var package3: int = 1499

func _ready() -> void:
	# Load the client database
	load_json_file()

func load_json_file():
	var file = FileAccess.open(json_path,FileAccess.READ)
	#assert(file.file_exists(json_path),"Missing Client Data")
	
	var json = file.get_as_text()
	var json_object = JSON.new()
	json_object.parse(json)
	clientStats = json_object.data
	totalClients = clientStats.size()
	return clientStats

func newGame():
	money = 1000
	rating = 1.0
	possibleRatings = 1.0
	totalClients = 6
	day = 25
	level = 1
	ratingGoal = 0
	chosenClient = 0

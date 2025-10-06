extends Control

const LOGIN_SCREEN = preload("uid://cw5apk3d2uqn5")
const START_SCREEN = preload("uid://c7kndyvbvrunr")
const GAME = preload("uid://cdw04ctgo4q7p")
const ABOUT = preload("uid://768dttjt7wip")
@onready var logo: TextureRect = $Content/Logo
var startedGame : bool = false

func _ready() -> void:
	GlobalStates.connect("newDay",startNewDay)
	GlobalStates.connect("restart",startNewDay)
	GlobalStates.connect("openAbout",about)
	$Startup.play()
	$Scanlines.material.set("shader_parameter/vignette_intensity",500)
	
	var bootup = create_tween()
	bootup.tween_property($Scanlines,"material:shader_parameter/vignette_intensity",2.5,3).set_trans(Tween.TRANS_CIRC)
	
	await get_tree().create_timer(5).timeout
	login_screen()

func login_screen():
	
	
	var fadeLogo = create_tween()
	fadeLogo.tween_property(logo,"modulate:a",0,1)
	await fadeLogo.finished
	logo.queue_free()
	var new_login = LOGIN_SCREEN.instantiate()
	$Content.add_child(new_login)
	new_login.connect("continueClicked",start_screen)
	

func start_screen():
	get_node("Content/LoginScreen").queue_free()
	var new_start = START_SCREEN.instantiate()
	$Content.add_child(new_start)
	new_start.connect("newGame",start_game)

func start_game():
	get_node("Content/StartScreen").queue_free()
	var new_game = GAME.instantiate()
	$Content.add_child(new_game)

func startNewDay():
	var shutdown = create_tween()
	shutdown.tween_property($Scanlines,"material:shader_parameter/vignette_intensity",500,0.5).set_trans(Tween.TRANS_CIRC)
	$Shutdown.play()
	await shutdown.finished
	await get_tree().create_timer(0.5).timeout
	var bootup = create_tween()
	bootup.tween_property($Scanlines,"material:shader_parameter/vignette_intensity",2.5,3).set_trans(Tween.TRANS_CIRC)
	$Startup.play()

func about():
	$About.visible = true

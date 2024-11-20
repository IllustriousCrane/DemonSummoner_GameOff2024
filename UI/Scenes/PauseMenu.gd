extends Control

var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#open and close menu
	if Input.is_action_just_pressed("Exit"):
		
		if !isOpen and !Globals.menuOpen:
			openMenu()
			
		else:
			closeMenu()
			
			
#----------------------------------------------------------------------

func openMenu():
	get_tree().paused = true
	Globals.emit_signal("MenuOpened", "Pause")#
	Globals.menuOpen = true
	show()

#connect Resume Button to this also:
func closeMenu():
	hide()
	get_tree().paused = false
	Globals.menuOpen = false

#------------------------------------------------------------------------

func _on_main_menu_button_pressed():
	#load mainMenu
	#SceneTransition.change_scene("MainMenu.tscn")
	pass # Replace with function body.
	
func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.

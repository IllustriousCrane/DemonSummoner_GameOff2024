extends Control


var correct_opponent
var chosen_opponent = "none"

var current_secret

var secret_button = load("res://UI/Scenes/secret_button.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#instantiate the secret buttons
	add_secrets()


func add_secrets():
	
	if Globals.active_secrets.size() > 1:
		for i in Globals.active_secrets.size()-1:
			print("Add a secret button!")
			var secret_bttn = secret_button.instantiate()
			$"../Secrets".add_child(secret_bttn)
			secret_bttn.set_up(Globals.active_secrets[i])
	else:
		var secret_bttn = secret_button.instantiate()
		$"../Secrets".add_child(secret_bttn)
		secret_bttn.set_up(Globals.active_secrets[0])
		pass # Replace with function body.
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass


func set_up(secret):
	
	show()
	$Control/tagline.text = Globals.Secrets[secret].secret_name
	$Control/description.text = Globals.Secrets[secret].secret_description
	
	correct_opponent = Globals.Secrets[secret].character_concerned
	current_secret = secret
	pass
	
	
func _on_spread_secret_pressed() -> void:
	
	if chosen_opponent == correct_opponent:
		#do damage to the correct opponent
		print("Damaged correct opponent")
		
		#shift the secret to archived
		Globals.archived_secrets.append(current_secret)
		Globals.active_secrets.erase(current_secret)
		
	else:
		#play a fail state scenario
		print("secret had no effect")
		
		#shift the secret to archived
		Globals.archived_secrets.append(current_secret)
		Globals.active_secrets.erase(current_secret)
		pass
	pass # Replace with function body.
	

func close():

	hide()

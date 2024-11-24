extends Node

var locationName = "The Docks"
var locationDescription = "Sinners huddle in the shadow of the clocktower."

var available_secrets = ["secret1", "secret2", "secret3"]

func choose_secret():
	
	var secret = available_secrets[randi_range(0, available_secrets.size() - 1)]
	
	available_secrets.erase(secret)
	print("Chose secret: " + str(secret))
	
	match secret:
		#edit edge cases here to add level 1 or 2 secrets into a new pool
		
		pass
		
	#ADD SECRET TO OPPONENT:
	
	var op = Globals.Secrets[secret].character_concerned
	if op != "none":
		Globals.Opponents[op].active_secrets.append(secret)
	
	pass

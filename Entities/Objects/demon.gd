extends Sprite2D

var demonTextures = [
	"res://Entities/Objects/demon_1.png",
	"res://Entities/Objects/demon_2.png"
]

var anim_counter = 0
var anim_max_rounds = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.NewDay.connect(pickIntention)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("anim finished")
	
	if anim_name == "idle":
		
		anim_counter += 1
		$AnimationPlayer.play("idle")
		if anim_counter >= anim_max_rounds:
			anim_counter = 0
			print("Switch texture!")
			texture = load(demonTextures[randi_range(0, demonTextures.size() - 1)])
			$AnimationPlayer.play("idle")
		
	pass # Replace with function body.

func pickIntention():
	
	#TODO: expand this list of locations Viol might take an interest in
	
	var locations = ["Church", "Palace", "Library", "Streets", "Theatre"]
	Globals.demon_desired_location = locations[randi_range(0, locations.size())]
	print("Demon's desired location is: " + str(Globals.demon_desired_location))
	
	

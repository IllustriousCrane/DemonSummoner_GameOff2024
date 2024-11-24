extends Control

@export var floatSpeed = 50		#speed at which the bubble floats up

@export var max_width = 350
@export var lifeTime = 2

@onready var label = $BubbleContainer/MarginContainer/Label


var dialogue_mode = false
var text = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	position.y -= floatSpeed * delta
	
	if dialogue_mode:
		if get_parent().wait_to_continue and Input.is_action_just_pressed("LeftMouse"):
			$TextAnim.play("fadeOut")
	pass


func initiate_text(dialogue, is_dialogue_mode := false):
		
	text = dialogue
	label.text = text
	
	dialogue_mode = is_dialogue_mode
	await $BubbleContainer.resized
	
	$BubbleContainer.custom_minimum_size.x = min($BubbleContainer.size.x, max_width)
	
	if $BubbleContainer.size.x > max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		
		$BubbleContainer.custom_minimum_size.y = size.y
		
	#$BubbleContainer.global_position.x -= size.x / 2
	#$BubbleContainer.global_position.y -= size.y + 24
	
	#set the animations and timer up

	$TextAnim.play("fadeIn")


	$TextTimer.wait_time = lifeTime
	$TextTimer.start()

	pass


func _on_text_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeOut":
	
		queue_free()
	pass # Replace with function body.


func _on_text_timer_timeout() -> void:
	if !dialogue_mode:
		print("Playing fade out")
		$TextAnim.play("fadeOut")
		get_parent().get_parent().canConverse = true
	
	else:
		get_parent().wait_to_continue = true
	pass # Replace with function body.

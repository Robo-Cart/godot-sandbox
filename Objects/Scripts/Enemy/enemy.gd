class_name Enemy
extends CharacterBody2D

#########################################################
# I tend to keep the top level node's functionality 
# small. Here, this node is responsible for common state
# variables, passing the damaged signal around, and 
# picking a random texture on spawn.
#
# For the most part, other functionality that controls
# the enemy is handled by specific states.
#
# ex. Movement is handled by states setting velocity
# and calling move_and_slide()
########################################################


signal damaged(attack: Attack)

@export var animation_tree: AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback

@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var follow_radius := 25.0
@export var attack_range := 20.0
@export var attacking_movement_speed:= 30.0

var alive := true
var stunned := false

func on_damaged(attack: Attack) -> void:
	damaged.emit(attack)

func _ready():
	await get_tree().process_frame

	print("Active:", $AnimationTree.active)
	print("Tree Root:", $AnimationTree.tree_root)
	print("Animation Player:", $AnimationTree.anim_player)
	print("Animations:", $AnimationPlayer.get_animation_list())
	print("Parameters:", $AnimationTree.get("parameters"))
	animation_tree.active = true
	
	playback = animation_tree.get("parameters/playback")
	print("Playback:", animation_tree.get("parameters/attack/blend_position"))
	
	if playback == null:
		push_error("AnimationTree playback is NULL. Check state machine setup.")
	
	print("Do we have animations:",$AnimationPlayer.get_animation_list())
	print("extra debug check:", animation_tree.get("parameters"))
	print("Tree active:", $AnimationTree.active)
	print("Tree root:", $AnimationTree.tree_root)
	print("Parameters:", $AnimationTree.get("parameters"))
	print("Playback:", $AnimationTree.get("parameters/playback"))

func play_animation(name: String):
	if playback:
		playback.travel(name)
	else:
		push_error("Tried to play animation but playback is null.")

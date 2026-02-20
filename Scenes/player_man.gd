class_name Player_Man

extends CharacterBody2D

@export_group("Player Parameters")
@onready var player_man : Node3D = $SubViewportContainer/SubViewport/player_man
@onready var animation_tree : AnimationTree = $SubViewportContainer/SubViewport/player_man.get_node("AnimationTree")
@onready var weapon_path : Array[Node] = $SubViewportContainer/SubViewport/player_man/Armature/Skeleton3D/BoneAttachment3D.get_children()


@export var speed : float = 200
@export var physicscontrol : bool = false

const MAX_SPEED = 200.0
const ACCELERATION = 800.0
const FRICTION = 900.0


var input_move : Vector2
var input_aim : Vector2
var playback : AnimationNodeStateMachinePlayback
var anim_pos : Vector2
var look_vector : Vector2
var player_offset_angle = 89.5

func _ready() -> void:
	add_to_group("player")
	playback = animation_tree["parameters/playback"]

func _process(delta: float) -> void:
	input_move = Input.get_vector("Left", "Right", "Up", "Down")
	input_aim = Input.get_vector("Aim Left", "Aim Right", "Aim Up", "Aim Down")
	
	# Check player control to use physics based control
	if physicscontrol:
		if input_move:
			# Acceleration (Weighty start)
			velocity = velocity.move_toward(input_move * MAX_SPEED, ACCELERATION * delta)
		else:
			# Friction (Weighty stop)
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		velocity = input_move * speed
	
	if input_move != Vector2.ZERO:
		player_man.rotation.y = -input_move.angle()+player_offset_angle
	if input_aim != Vector2.ZERO:
		player_man.rotation.y = -input_aim.angle()+player_offset_angle
	
	move_and_slide()
	select_animation()
	update_animation_parameters()
	
func select_animation():
	if velocity.length() < 130:
		playback.travel("Walk")
	else:
		playback.travel("Run")

func update_animation_parameters():
	
	if input_move != Vector2.ZERO:
		anim_pos = input_move.rotated(player_man.rotation.y)
	if input_aim != Vector2.ZERO:
		anim_pos = input_aim.rotated(player_man.rotation.y)
	
	animation_tree["parameters/Run/blend_position"] = input_move
	animation_tree["parameters/Walk/blend_position"] = input_move

extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed : float = 60.0
@export var detect_range : float = 120.0
var player: CharacterBody2D

var move_direction: Vector2
var wander_time: float

func randomise_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		
	randomise_wander()

func Update(delta: float):
		
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomise_wander()

func Physics_Update(_delta: float):
	if player == null:
		return
		
	var direction_of_target = player.global_position - enemy.global_position
	var distance_to_target = direction_of_target.length()
	
	if distance_to_target < detect_range:
		Transitioned.emit(self, "Follow")
	
	if enemy:
		enemy.velocity = move_direction * move_speed

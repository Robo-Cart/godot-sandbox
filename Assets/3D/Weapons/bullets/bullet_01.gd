extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
@onready var Impact : AudioStreamPlayer2D = $Impact
@onready var HitParticle : CPUParticles2D = $HitParticle

var speed: float = 1000
var hit : bool = false


func _ready() -> void:
	$DistanceTimeout.wait_time = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !hit :
		if RayCast.is_colliding() and !RayCast.get_collider().is_in_group("player"):
			Impact.play()
			HitParticle.emitting = true
			hit = true
			texture = null
			$DistanceTimeout.start()
			
		global_position += Vector2(1, 0).rotated(rotation) * speed * delta
		
		if RayCast.is_colliding() and RayCast.get_collider().is_in_group("enemy"):
			#if hit enemy signal play hit animation HitFlashAnim.play()
			var enemy = RayCast.get_collider().get_node("HitFlashAnim")
			enemy.play("hit")
	

func _on_distance_timeout_timeout() -> void:
	queue_free()

extends Area2D

var travelled_distance = 0
var direction = Vector2.RIGHT

func _ready() -> void:
	rotation = direction.angle() - deg_to_rad(90)

func _physics_process(delta: float) -> void:
	const SPEED = 400
	const RANGE = 1200
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()

extends Area2D

@onready var player = get_node("/root/Game/Player")

var cloud_time = 10.0
var cloud_damage = 15.0
var player_inside = false

func _ready() -> void:
	await get_tree().create_timer(10.0).timeout
	queue_free()

func _process(_delta: float) -> void:
	if player_inside:
		player.health -= cloud_damage * _delta
		player.get_node("%ProgressBar").value = player.health
		if player.health <= 0.0:
			player.health_depleted.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

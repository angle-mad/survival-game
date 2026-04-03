extends Area2D

@onready var player = get_node("/root/Game/Player")


func _on_body_entered(_body: Node2D) -> void:
	player.health = min(player.health + 20, 100)
	player.get_node("ProgressBar").value = player.health
	queue_free()

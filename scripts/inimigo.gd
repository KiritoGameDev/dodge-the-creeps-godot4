extends RigidBody2D


@export var min_speed = 150
@export var max_speed = 300

func _ready() -> void:
	var tipo_inimigos = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = tipo_inimigos[randi()% tipo_inimigos.size()]
	
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

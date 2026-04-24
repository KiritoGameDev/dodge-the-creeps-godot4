extends Area2D

@export var speed = 400
var screen_size

signal hit

func _ready() -> void:
	hide() # Começa escondido até o jogo iniciar
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		$rastro.emitting = true
	else:
		$AnimatedSprite2D.stop()	
		$rastro.emitting = false

	# Usamos 'elif' aqui para priorizar uma animação por vez
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "direita"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "cima"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	position += velocity * delta	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(pos):
	position = pos
	show() # Faz o boneco aparecer
	$CollisionShape2D.disabled = false # Reativa a colisão


func _on_body_entered(body: Node2D) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

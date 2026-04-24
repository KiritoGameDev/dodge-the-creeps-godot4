extends Node

# Na Godot 4, usamos esta sintaxe para o export
@export var Inimigo: PackedScene
var score

func _ready() -> void:
	# O randomize() não é mais obrigatório na v4, mas limpa o cache de sementes
	novo_jogo()

func game_over() -> void:
	$pontuacaoTimer.stop()
	$inimigoTimer.stop()
	$HUD.exibir_gameover()
	$Musica.stop()
	$somMorte.play()
	
func novo_jogo():
	score = 0
	# Certifique-se que o nó se chama 'jogador' (minúsculo) na árvore
	$jogador.start($PosicaoInicial.position)	
	$inicioTimer.start()
	$HUD.exibir_mensagem("Preparar")
	$HUD.atualiza_score(score)
	$Musica.play()

func _on_inicio_timer_timeout() -> void:
	$inimigoTimer.start()
	$pontuacaoTimer.start()

func _on_pontuacao_timer_timeout() -> void:
	score += 1
	$HUD.atualiza_score(score)

func _on_inimigo_timer_timeout() -> void:
	# 1. Configura o local de spawn no caminho
	# Usamos progress_ratio (0.0 a 1.0) com randf() para evitar erro de tipo
	var local_spawn = $caminhoInimigo/spawnInimigo
	local_spawn.progress_ratio = randf()

	# 2. Cria uma nova instância do inimigo
	var inimigo = Inimigo.instantiate()
	add_child(inimigo)

	# 3. Define a direção (perpendicular ao caminho)
	var direcao = local_spawn.rotation + PI / 2
	inimigo.position = local_spawn.position
	
	# 4. Adiciona aleatoriedade na direção
	direcao += randf_range(-PI / 4, PI / 4)
	inimigo.rotation = direcao

	# 5. Define a velocidade (Funciona se o inimigo for RigidBody2D)
	# Verifique se o script do inimigo tem as variáveis min_speed e max_speed
	var velocidade = Vector2(randf_range(150.0, 250.0), 0.0)
	inimigo.linear_velocity = velocidade.rotated(direcao)

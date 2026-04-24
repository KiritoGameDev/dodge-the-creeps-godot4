extends CanvasLayer

signal  start_game

func exibir_mensagem(text):
	$mensagemLabel.text = text
	$mensagemLabel.show()
	$menssageTimer.start()
	
func exibir_gameover():
	exibir_mensagem("FIM DE JOGO!")
	await $menssageTimer.timeout
	
	$mensagemLabel.text = "Desvie e Sobreviva!"
	$mensagemLabel.show()
	await (get_tree().create_timer(1).timeout)
	$startButton.show()
func atualiza_score(score):
	$scoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$startButton.hide()
	emit_signal("start_game")

func _on_menssage_timer_timeout() -> void:
	$mensagemLabel.hide()

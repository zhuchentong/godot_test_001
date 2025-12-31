extends Area2D

# 速度
@export var slime_speed: float = -200; 
@export var animator: AnimatedSprite2D

var is_death: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not is_death:
		position += Vector2(slime_speed, 0) * _delta 
	
	if position.x < -2200:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("hit player")
		
		body.game_over()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		animator.play("death")
		is_death = true
		area.queue_free()
		get_tree().current_scene.score += 1
		# 等待死亡动画
		await get_tree().create_timer(0.6).timeout
		queue_free()

extends CharacterBody2D

@export var move_speed: float = 1000;
@export var animator: AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left","right","up",'down') * move_speed;
	
	# 如果速度为0, 播放站立动画
	if velocity == Vector2.ZERO:
		animator.play("idle")
	else:
		animator.play("run")
	
	move_and_slide()

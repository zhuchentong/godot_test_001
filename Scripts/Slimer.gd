extends Area2D

# 速度
var slimer_speed: float = -200; 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position += Vector2(slimer_speed, 0) * _delta 

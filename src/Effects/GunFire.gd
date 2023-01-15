extends Node2D

func _ready():
	
	$TimerDestroy.start()
	$Fire.emitting=true

func _process(delta):
	pass

func _on_TimerDestroy_timeout():
	self.queue_free()

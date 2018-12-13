extends Node

signal dead

var score = 0
var dead = false setget _set_dead

func _set_dead(new_dead):
	dead = new_dead
	if new_dead == true:
		print("dead!")
		emit_signal("dead")
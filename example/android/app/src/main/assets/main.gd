extends Control

var singleton
const pluginName: StringName = "GodotFlutterPlugin"

func _ready():
	if Engine.has_singleton(pluginName):
		singleton = Engine.get_singleton(pluginName)
		singleton.connect("get_string", example)
	else: 
		print("未找到插件.")
	pass

func _on_button_button_down():
	if singleton != null:
		singleton.sendData("这是Godot发送到Flutter的数据.")
	else:
		print("插件实例为空.")
	pass

func example(data: String):
	print("Godot: " + data)
	pass

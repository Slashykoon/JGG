extends StaticBody2D

class_name Soldier

onready var Collision_Stand = $Collision_Stand
onready var Collision_Crouch= $Collision_Crouch
onready var Sprite_Stand= $Sprite_Stand
onready var Sprite_Crouch= $Sprite_Crouch
onready var Sprite_Prone= $Sprite_Prone
var rng_frame = RandomNumberGenerator.new()
var GunEffect = preload("res://src/Effects/GunFire.tscn")
onready var CooldownTimer = $Gun/Cooldown
var AmmoBurst = 0
var AmmoperClip = 0
#Soldier Stats
var Morale = 0
var Experience = 0
#Temporary variable 
var BurstCount = 0
var dict_guns : Dictionary
var Gun_id

func _ready():
	pass # Replace with function body.

func Set_Stand_Texture(TexturePath:String):
	$Sprite_Stand.texture=load(TexturePath)

func Set_Frame(iFrame:int):
	$Sprite_Stand.frame =iFrame

func Initialize_Soldier(data):
	rng_frame.randomize()
	var iFrame = int(data.get("Sprite_Stand")[0].get("FrameNumber"))
	Set_Frame(rng_frame.randi_range(0,iFrame-1))
	var arrGP = data.get("Sprite_Stand")[0].get("GunShotPosition").split(",")
	$Gun.position= Vector2(float(arrGP[0]),float(arrGP[1]))
	Set_Stand_Texture(data.get("Sprite_Stand")[0].get("Path"))
	Gun_id = data.get("Gun")
	Initialize_Gun(Gun_id)

func Initialize_Gun(id_Gun):
	Data_From_JSON()
	AmmoBurst = int(dict_guns.get(Gun_id).get("AmmoBurst"))
	AmmoperClip = int(dict_guns.get(Gun_id).get("AmmoClip"))
	$Gun/Cooldown.wait_time = float(dict_guns.get(Gun_id).get("TimeBtwBurst"))

func GoCrouch():
	$Sprite_Crouch

func OpenFire():
	var inst_GunEffect = GunEffect.instance()
	inst_GunEffect.position=$Gun.position
	#Sprite_Stand.get_node("Gun").add_child(inst_GunEffect)
	$Gun.add_child(inst_GunEffect)
	CooldownTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Cooldown_timeout():
	print("Timeout")
	if BurstCount < AmmoBurst:
		BurstCount += 1
		OpenFire()
	else:
		CooldownTimer.stop()
		BurstCount = 0

func Data_From_JSON():
	var fileGuns = File.new()
	var ErrGunsFile = fileGuns.open("res://src/Data/Guns.json", fileGuns.READ)
	var Gunsjson = fileGuns.get_as_text()
	dict_guns = JSON.parse(Gunsjson).result
	fileGuns.close()

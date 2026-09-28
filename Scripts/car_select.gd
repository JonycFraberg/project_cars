extends CanvasLayer

#Hi
# -------------------------
# CAR SELECT STATE
# -------------------------

var car_class := ""
var car_name := ""
var car_index := 0
var color_index := 0
var upgrade_mode:=false
var top_speed_kmh: float
var zero_to_hundred: float

var unlocked_cars := {}
var car_sell_prices := {
	"Colossus Titan Max": 9000,
	"Colossus Behemoth": 0,
	"Mir Cars Nightwolf": 16800,
	
	"Schroder Colosso": 21000,

	"Kuro Zephyr": 24000,
	"Schroder Atrix Q32": 33000,
	"Zenith Horizon": 39000,
	"Eisenach Bengal": 42000,

	"Brutus Viper": 30000,
	"Mir Cars Hutch": 36000,

	"Eisenach Suppressor": 42000,
	"Strandberg Turbo": 48000,
	"Kuro Vault": 51000,
	"Berkshire Mocha": 54000,

	"Mir Cars Transporter": 63000,
	"Kuro Persian": 66000,
	"Kronstadt Fortress": 72000,

	"Kuro Serenity": 51000,
	"Kestrel Speedster": 57000,
	"Eisenach Prince": 72000,
	"Berkshire Blunt": 8000,
	"Kronstadt Blazer": 100000,

	"Schroder Classique Sport": 96000,
	"Brutus Stingray": 84000,
	"Eisenach Goblin": 114000,
	"Berkshire Tempest":150000,
	"Berkshire V12-S": 132000,
	"Kestrel Touring": 156000,

	"Kronstadt Beast": 168000,
	"Brutus Venom": 192000,
	"Kestrel Battleaxe": 210000,
	"Linetti Shepherd": 228000,

	"Kestrel Guillotine": 270000,
	"Linetti Firestorm": 300000,
	"Mir Cars Raptor": 330000,
	"Linetti Terror": 390000,

	"Bartoli Track Cruiser": 540000,
	"Brutus Thunderbolt": 600000,
	"Mir Cars Athletic C70": 720000
}

var car_prices := {
	"Colossus Titan Max": 15000,
	"Colossus Behemoth": 0,
	"Mir Cars Nightwolf": 25000,
	"Schroder Colosso": 32000,

	"Brutus Viper": 45000,
	"Mir Cars Hutch": 55000,

	"Kuro Zephyr": 38000,
	"Schroder Atrix Q32": 50000,
	"Zenith Horizon": 60000,
	"Eisenach Bengal": 65000,

	"Eisenach Suppressor": 70000,
	"Strandberg Turbo": 78000,
	"Kuro Vault": 85000,
	"Berkshire Mocha": 90000,

	"Mir Cars Transporter": 95000,
	"Kuro Persian": 105000,
	"Kronstadt Fortress": 115000,

	"Kuro Serenity": 80000,
	"Kestrel Seabird": 120000,
	"Eisenach Prince": 100000,
	"Berkshire Blunt": 110000,
	"Kronstadt Blazer": 98000,

	"Schroder Classique Sport": 135000,
	"Brutus Stingray": 150000,
	"Berkshire Tempest":203000,
	"Berkshire V12-S": 190000,
	"Kestrel Touring": 220000,

	"Kronstadt Beast": 250000,
	"Brutus Venom": 290000,
	"Kestrel Battleaxe": 320000,
	"Linetti Shepherd": 350000,

	"Kestrel Guillotine": 420000,
	"Linetti Firestorm": 470000,
	"Mir Cars Raptor": 520000,
	"Linetti Terror": 600000,

	"Bartoli Track Cruiser": 850000,
	"Brutus Thunderbolt": 1000000,
	"Mir Cars Athletic C70": 1200000
}


# 3D Preview
@onready var preview_holder: Node3D = $SubViewportContainer/SubViewport/CarPreview/CarHolder
var preview_car: Node3D = null
var rotation_speed := 1.0

# -------------------------
# COLOR DATA
# -------------------------

var car_colors := {
	"Straeda Pitbull":[Color8(128,128,0), Color8(90,90,90), Color8(180,150,80), Color8(0,70,40)],
	"Mir Cars Crawler":[
		Color8(200,40,40),   # Deep Red (default)
		Color8(255,255,255), # White
		Color8(60,60,60),    # Graphite
		Color8(0,80,160)     # Deep Blue
	],
	"Eisenach Escorter":[
		Color8(180,180,180), # Silver (default BMW SUV vibe)
		Color8(255,255,255), # White
		Color8(60,60,60),    # Dark Grey
		Color8(0,70,120)     # Deep Blue
	],
	"Eisenach Goblin":[
	Color8(237,132,69),    # ⭐ Fire Orange (default — BMW 1M signature)
	Color8(255,255,255),  # White
	Color8(60,60,60),     # Graphite
	Color8(0,90,180)      # Deep Blue
],

	"Kronstadt Fortress":[
	Color8(0,0,0),       # Black (default)
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(0,40,80)      # Navy Blue
],
	"Colossus Behemoth":[Color8(215,255,1), Color8(255,255,255), Color8(200,180,120), Color8(160,0,0)],
	"Mir Cars Nightwolf":[Color8(0,0,192), Color8(255,255,255), Color8(64,64,64), Color8(0,80,160)],
	"Colossus Titan Max":[Color8(255,0,0), Color8(180,180,180), Color8(210,180,90), Color8(120,40,40)],

	"Zenith Horizon":[Color8(255,116,49), Color8(255,255,255), Color8(0,90,180), Color8(180,180,180)],
	"Schroder Atrix Q32":[Color8(192,192,192), Color8(255,255,255), Color8(140,0,255), Color8(0,120,160)],
	"Straeda B32":[Color8(132,132,132), Color8(255,255,255), Color8(255,140,0), Color8(0,120,200)],
	"Strandberg Turbo":[
	Color8(133,82,141),   # ⭐ Purple Metallic (default)
	Color8(255,255,255),  # White
	Color8(60,60,60),     # Dark Grey
	Color8(0,80,160)      # Deep Blue
],
"Eisenach Black Panda":[
	Color8(40,40,40),     # ⭐ Default — Panda Graphite
	Color8(255,255,255),  # White
	Color8(0,70,120),     # Deep Blue
	Color8(180,180,180)   # Silver
],

"Schroder Fastback":[
	Color8(180,180,180),   # Silver (default, executive)
	Color8(0,120,200),     # ⭐ Sepang Blue (bright Audi sport color)
	Color8(200,40,40),     # ⭐ Misano Red (deep sporty red)
	Color8(255,140,0)      # ⭐ Samoa Orange (rare Audi exclusive)
],

"Eisenach Suppressor":[
	Color8(75,78,71),     # ⭐ Default — Graphite (boring executive)
	Color8(180,180,180),  # Silver
	Color8(60,60,60),     # Dark Grey
	Color8(0,70,120)      # Deep Blue
],
"Kuro Serenity":[
	Color8(20,40,60),     # ⭐ Midnight Jade Pearl (default) — deep green-black Lexus luxury
	Color8(255,255,255),  # ⭐ Diamond White Pearl — classic Lexus VIP white
	Color8(180,180,180),  # ⭐ Platinum Silver — calm GT silver
	Color8(60,60,60)      # ⭐ Graphite Shadow — dark executive grey
],

"Schroder D-20":[
	Color8(240,240,240),
	Color8(0,60,120),
	Color8(180,180,180),
	Color8(120,0,0)
],
"Kuro Persian":[
	Color8(0,110,130),   # Teal Torque (same as Mammoth)
	Color8(255,255,255), # White
	Color8(60,60,60),    # Dark Grey
	Color8(180,20,20)    # Deep Muscle Red
],


"Mir Cars Athletic C70":[
	Color8(255,80,20),   # Default — American Hyper Orange
	Color8(255,255,255), # White
	Color8(60,60,60),    # Graphite
	Color8(0,90,160)     # Deep Blue
],

"Bartoli Track Cruiser":[
	Color8(0,157,192),   # Default — MC12 Blue
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(0,90,160)     # Deep Blue
],

"Brutus Thunderbolt":[
	Color8(255,0,0),     # Default — Cobra Red
	Color8(255,255,255), # White
	Color8(60,60,60),    # Graphite
	Color8(0,40,120)     # Deep Blue
],
"Kronstadt Crest":[
	Color8(180,180,180),   # Iridium Silver
	Color8(255,255,255),   # Calcite White
	Color8(60,60,60),      # Tenorite Grey
	Color8(0,70,120)       # Cavansite Blue
],

"Kronstadt Blazer":[
	Color8(180,180,180),   # Silver (default)
	Color8(200,40,40),     # ⭐ Deep Mercedes Red
	Color8(60,60,60),      # Graphite
	Color8(0,70,120)       # Deep Blue
],

"Kestrel Touring":[
	Color8(255,54,35),     # ⭐ Midnight Blackpool (default)
	Color8(160,40,200),   # Toxic Purple
	Color8(120,255,40),   # Radioactive Lime
	Color8(255,90,20)     # Cerbera Flame Orange
],

	"Mir Cars Hutch":[Color8(228,31,36), Color8(255,255,255), Color8(160,160,160), Color8(0,40,120)],
	"Brutus Viper":[Color8(0,0,128), Color8(255,255,255), Color8(200,200,200), Color8(160,0,0)],

	"Brutus Stingray":[Color8(255,255,0), Color8(255,255,255), Color8(255,0,0), Color8(160,160,160)],
	"Kestrel Speedster":[Color8(192,192,192), Color8(255,255,255), Color8(0,120,180), Color8(180,180,180)],
	"Berkshire Blunt":[Color8(0,66,37), Color8(173,69,67), Color8(180,180,180), Color8(172,213,243)],
	"Kestrel Seabird":[Color8(50,205,50), Color8(255,255,255), Color8(255,200,0), Color8(0,120,200)],
	"Kuro Zephyr V6":[Color8(255,255,255), Color8(64,64,64), Color8(0,90,180), Color8(180,180,180)],
	

	"Eisenach Monarch":[
	Color8(0,40,80),     # Deep Executive Blue (default)
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(60,60,60)     # Graphite Grey
],
"Eisenach Prince":[
	Color8(255,99,71),    # ⭐ Tomato Red (default)
	Color8(185,155,185),  # White
	Color8(60,60,60),     # Dark Grey
	Color8(0,0,0)         # Black
],
"Berkshire Mocha":[
	Color8(139,69,19),    # Mocha Brown (default)
	Color8(255,255,255),  # White
	Color8(180,180,180),  # Silver
	Color8(0,70,120)      # British Racing Blue
],
	"Mir Cars Transporter":[Color8(192,192,192), Color8(255,255,255), Color8(0,40,80), Color8(160,160,160)],
	"Kuro Vault":[Color8(123,3,35), Color8(255,255,255), Color8(60,60,60), Color8(0,70,120)],

	"Berkshire Tempest":[Color8(192,192,192), Color8(255,255,255), Color8(0,80,120), Color8(160,160,160)],
	"Berkshire V12-S":[Color8(46,54,64), Color8(255,255,255), Color8(80,120,160), Color8(160,160,160)],
	"Bartoli Cruiser":[Color8(0,157,192), Color8(255,255,255), Color8(180,180,180), Color8(0,90,160)],
	"Eisenach Bengal":[
	Color8(113,115,120),   # Same default as Roadstar
	Color8(255,255,255),
	Color8(0,90,180),
	Color8(180,180,180)
],

   
"Schroder Classique Sport":[
	Color8(0,192,192),   # ⭐ Cyan — new signature color
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(200,40,40)    # Red
],


"Schroder Colosso":[
	Color8(180,180,180),   # Silver (default Audi SUV vibe)
	Color8(255,255,255),   # White
	Color8(60,60,60),      # Executive Graphite
	Color8(0,70,120)       # Deep Blue (Audi signature)
],

	"Schroder Atrocity":[
		Color8(255,0,0),    # ⭐ Default — tomato red
		Color8(255,255,255),  # White
		Color8(60,60,60),     # Dark grey
		Color8(0,0,0)         # Black
	],
	"Kuro Zephyr":[
	Color8(240,240,240),   # ⭐ Pearl Cream (starter luxury vibe)
	Color8(120,20,20),     # Crimson Garnet (deep red, unique to IS250)
	Color8(0,110,130),     # Teal Mist (compact-class signature color)
	Color8(70,70,70)       # Graphite Shadow (dark matte grey)
],
"Kronstadt Beast":[
	Color8(20,20,20),     # Obsidian Black (default AMG vibe)
	Color8(255,255,255),  # Arctic White
	Color8(180,180,180),  # Iridium Silver
	Color8(0,70,120)      # Cavansite Blue
],


	"Linetti Terror":[Color8(65,66,76), Color8(255,255,255), Color8(255,200,0), Color8(160,160,160)],
	"Kestrel Battleaxe":[Color8(180,20,35), Color8(255,255,255), Color8(255,140,0), Color8(200,40,80)],
	"Linetti Firestorm":[Color8(225,220,40), Color8(255,255,255), Color8(255,80,0), Color8(200,160,0)],
	"Linetti Shepherd":[Color8(50,220,40), Color8(255,255,255), Color8(255,200,0), Color8(0,160,80)],
	"Brutus Venom":[Color8(255,0,0), Color8(255,255,255), Color8(180,180,180), Color8(0,0,0)],
	"Kestrel Guillotine":[Color8(120,0,180), Color8(255,255,255), Color8(200,160,255), Color8(60,0,90)],
	"Mir Cars Raptor":[
		Color8(225,20,40),   # Deep red
		Color8(255,255,255), # White
		Color8(160,160,160), # Silver
		Color8(0,40,80)      # Midnight Blue
	]
}

# -------------------------
# CAR LISTS
# -------------------------

var suv_list = [
	"Colossus Titan Max",
	"Colossus Behemoth",
	"Schroder Colosso",
	"Mir Cars Nightwolf",
]

var compact_list = [
	"Kuro Zephyr",
	"Schroder Atrix Q32",
	"Eisenach Bengal",
	"Zenith Horizon",
]

var muscle_list = [
	"Brutus Viper",
	"Mir Cars Hutch"
]

var urban_list = [
	"Kuro Serenity",
		"Kestrel Seabird",
	"Kronstadt Blazer",
	"Brutus Stingray",
]

var sedans_list = [
	"Strandberg Turbo",
	"Kuro Vault",
	"Berkshire Mocha",
	"Eisenach Suppressor",
]


var sport_list = [
	"Schroder Classique Sport",
	"Berkshire Blunt",
	"Berkshire V12-S",
	"Kestrel Touring"
]

var sport_racing_list = [
	"Kestrel Battleaxe",
	"Berkshire Tempest",
	"Brutus Venom",
	"Linetti Shepherd",
]

var supercars_list = [
	"Kestrel Guillotine",
	"Linetti Firestorm",
	"Mir Cars Raptor",
	"Linetti Terror",
]
var track_cars_list = [
	"Bartoli Track Cruiser",
	"Brutus Thunderbolt",
	"Mir Cars Athletic C70",
]


# -------------------------
# CAR STATS (PP omitted)
# -------------------------
var suv = {
	"Colossus Titan Max":[
		"", "Country: USA", "HP: 195", "WEIGHT: 3500 KG",
		"0-100 KM/H: 15.0s", "TOP SPEED: 180 KM/H",
		"ENGINE: V8 6.5L DIESEL", "ASPIRATION: Turbo", "TORQUE: 583 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Colossus Behemoth":[
		"", "Country: USA", "HP: 316", "WEIGHT: 2900 KG",
		"0-100 KM/H: 10.2s", "TOP SPEED: 198 KM/H",
		"ENGINE: V8 6.0L", "ASPIRATION: NA", "TORQUE: 488 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Schroder Colosso":[
		"", "Country: Germany", "HP: 237", "WEIGHT: 2340 KG",
		"0-100 KM/H: 8.5s", "TOP SPEED: 211 KM/H",
		"ENGINE: V6 3.0L DIESEL", "ASPIRATION: Turbo", "TORQUE: 500 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Mir Cars Nightwolf":[
		"", "Country: UAE", "HP: 220", "WEIGHT: 2668 KG",
		"0-100 KM/H: 12.0s", "TOP SPEED: 195 KM/H",
		"ENGINE: V8 6.6L", "ASPIRATION: NA", "TORQUE: 450 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	]
}
var compact = {
	"Kuro Zephyr":[
		"", "Country: Japan", "HP: 204", "WEIGHT: 1600 KG",
		"0-100 KM/H: 7.3s", "TOP SPEED: 234 KM/H",
		"ENGINE: V6 2.5L", "ASPIRATION: NA", "TORQUE: 270 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Schroder Atrix Q32":[
		"", "Country: Germany", "HP: 247", "WEIGHT: 1470 KG",
		"0-100 KM/H: 6.6s", "TOP SPEED: 250 KM/H",
		"ENGINE: V6 3.2L", "ASPIRATION: NA", "TORQUE: 320 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Zenith Horizon":[
		"", "Country: Japan", "HP: 287", "WEIGHT: 1460 KG",
		"0-100 KM/H: 6.4s", "TOP SPEED: 250 KM/H",
		"ENGINE: V6 3.5L", "ASPIRATION: NA", "TORQUE: 340 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Eisenach Bengal":[
	"", "Country: Germany", "HP: 204", "WEIGHT: 1550 KG",
	"0-100 KM/H: 6.5s", "TOP SPEED: 246 KM/H",
		"ENGINE: L4 2.0L Diesel", "ASPIRATION: Twin Turbo",
	"TORQUE: 400 NM",
	"TRANSMISSION: REAR-WHEEL DRIVE"
],
}
var muscle = {
	"Brutus Viper":[
		"", "Country: USA", "HP: 355", "WEIGHT: 1650 KG",
		"0-100 KM/H: 5.8s", "TOP SPEED: 216 KM/H",
		"ENGINE: V8 7.0L", "ASPIRATION: NA", "TORQUE: 540 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Mir Cars Hutch":[
		"", "Country: UAE", "HP: 372", "WEIGHT: 1780 KG",
		"0-100 KM/H: 5.6s", "TOP SPEED: 221 KM/H",
		"ENGINE: V8 7.1L", "ASPIRATION: NA", "TORQUE: 560 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	]
}
var urban_racers = {
	"Kuro Serenity":[
		"", "Country: Japan", "HP: 260", "WEIGHT: 1640 KG",
		"0-100 KM/H: 6.4s", "TOP SPEED: 250 KM/H",
		"ENGINE: V8 4.0L", "ASPIRATION: NA", "TORQUE: 360 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
		"Brutus Stingray":[
		"", "Country: USA", "HP: 340", "WEIGHT: 1460 KG",
		"0-100 KM/H: 5.0s", "TOP SPEED: 256 KM/H",
		"ENGINE: V8 5.7L", "ASPIRATION: NA", "TORQUE: 475 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Kestrel Seabird":[
		"", "Country: UK", "HP: 192", "WEIGHT: 935 KG",
		"0-100 KM/H: 4.7s", "TOP SPEED: 243 KM/H",
		"ENGINE: L4 1.8L", "ASPIRATION: NA", "TORQUE: 181 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Kronstadt Blazer":[
		"", "Country: Germany", "HP: 360", "WEIGHT: 1540 KG",
		"0-100 KM/H: 5.2s", "TOP SPEED: 253 KM/H",
		"ENGINE: V8 5.4L", "ASPIRATION: NA", "TORQUE: 510 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
}
var sedans = {
	"Eisenach Suppressor":[
		"", "Country: Germany", "HP: 360", "WEIGHT: 1660 KG",
		"0-100 KM/H: 5.2s", "TOP SPEED: 250 KM/H",
		"ENGINE: V8 4.8L", "ASPIRATION: NA", "TORQUE: 490 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
			"Strandberg Turbo":[
		"", "Country: Sweden", "HP: 300", "WEIGHT: 1667 KG",
		"0-100 KM/H: 5.8s", "TOP SPEED: 247 KM/H",
		"ENGINE: L5 2.5L", "ASPIRATION: Turbo", "TORQUE: 350 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
			
	"Kuro Vault":[
		"", "Country: Japan", "HP: 290", "WEIGHT: 1760 KG",
		"0-100 KM/H: 6.4s", "TOP SPEED: 257 KM/H",
		"ENGINE: V8 4.3L", "ASPIRATION: NA", "TORQUE: 430 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
"Berkshire Mocha":[
	"", "Country: UK", "HP: 300", "WEIGHT: 1750 KG",
	"0-100 KM/H: 5.7s", "TOP SPEED: 253 KM/H",
	"ENGINE: V8 4.2L", "ASPIRATION: NA", "TORQUE: 420 NM",
	"TRANSMISSION: REAR-WHEEL DRIVE"
],
}
var sport = {
	"Berkshire V12-S":[
		"", "Country: UK", "HP: 450", "WEIGHT: 1740 KG",
		"0-100 KM/H: 5.1s", "TOP SPEED: 296 KM/H",
		"ENGINE: V12 5.9L", "ASPIRATION: NA", "TORQUE: 570 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Berkshire Blunt":[
		"", "Country: UK", "HP: 400", "WEIGHT: 1750 KG",
		"0-100 KM/H: 5.6s", "TOP SPEED: 280 KM/H",
		"ENGINE: V8 4.2L", "ASPIRATION: Supercharged", "TORQUE: 553 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Schroder Classique Sport":[
		"", "Country: Germany", "HP: 340", "WEIGHT: 1460 KG",
		"0-100 KM/H: 5.2s", "TOP SPEED: 263 KM/H",
		"ENGINE: L5 2.5L", "ASPIRATION: Turbo", "TORQUE: 450 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Kestrel Touring":[
		"", "Country: UK", "HP: 360", "WEIGHT: 1150 KG",
		"0-100 KM/H: 4.3s", "TOP SPEED: 292 KM/H",
		"ENGINE: V8 4.2L", "ASPIRATION: NA", "TORQUE: 390 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
}
var sport_racing = {
	"Linetti Shepherd":[
		"", "Country: Italy", "HP: 500", "WEIGHT: 1430 KG",
		"0-100 KM/H: 4.2s", "TOP SPEED: 305 KM/H",
		"ENGINE: V10 5.0L", "ASPIRATION: NA", "TORQUE: 510 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Berkshire Tempest":[
		"", "Country: UK", "HP: 520", "WEIGHT: 1780 KG",
		"0-100 KM/H: 4.9s", "TOP SPEED: 318 KM/H",
		"ENGINE: V12 5.9L", "ASPIRATION: NA", "TORQUE: 580 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Brutus Venom":[
		"", "Country: USA", "HP: 415", "WEIGHT: 1560 KG",
		"0-100 KM/H: 4.1s", "TOP SPEED: 300 KM/H",
		"ENGINE: V10 8.0L", "ASPIRATION: NA", "TORQUE: 630 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	
	"Kestrel Battleaxe":[
		"", "Country: UK", "HP: 406", "WEIGHT: 1078 KG",
		"0-100 KM/H: 3.5s", "TOP SPEED: 287 KM/H",
		"ENGINE: L6 4.0L", "ASPIRATION: NA", "TORQUE: 390 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	]
}
var supercars = {
	"Kestrel Guillotine":[
		"", "Country: UK", "HP: 440", "WEIGHT: 1100 KG",
		"0-100 KM/H: 3.6s", "TOP SPEED: 315 KM/H",
		"ENGINE: L6 4.2L", "ASPIRATION: NA", "TORQUE: 420 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Linetti Terror":[
		"", "Country: Italy", "HP: 572", "WEIGHT: 1630 KG",
		"0-100 KM/H: 3.7s", "TOP SPEED: 330 KM/H",
		"ENGINE: V12 6.2L", "ASPIRATION: NA", "TORQUE: 650 NM",
		"TRANSMISSION: FOUR-WHEEL DRIVE"
	],
	"Mir Cars Raptor":[
		"", "Country: USA", "HP: 532", "WEIGHT: 1378 KG",
		"0-100 KM/H: 3.8s", "TOP SPEED: 327 KM/H",
		"ENGINE: V8 7.0L", "ASPIRATION: NA", "TORQUE: 700 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Linetti Firestorm":[
		"", "Country: Italy", "HP: 493", "WEIGHT: 1625 KG",
		"0-100 KM/H: 4.2s", "TOP SPEED: 328 KM/H",
		"ENGINE: V12 5.7L", "ASPIRATION: NA", "TORQUE: 580 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	]
}
var track_cars = {
	"Mir Cars Athletic C70":[
		"", "Country: UAE", "HP: 655", "WEIGHT: 1378 KG",
		"0-100 KM/H: 3.65s", "TOP SPEED: 342 KM/H",
		"ENGINE: V12 7.5L", "ASPIRATION: NA", "TORQUE: 650 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Bartoli Track Cruiser":[
		"", "Country: Italy", "HP: 621", "WEIGHT: 1335 KG",
		"0-100 KM/H: 3.4s", "TOP SPEED: 335 KM/H",
		"ENGINE: V12 6.0L", "ASPIRATION: NA", "TORQUE: 652 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	],
	"Brutus Thunderbolt":[
		"", "Country: USA", "HP: 605", "WEIGHT: 1390 KG",
		"0-100 KM/H: 3.6s", "TOP SPEED: 338 KM/H",
		"ENGINE: V10 6.4L", "ASPIRATION: NA", "TORQUE: 640 NM",
		"TRANSMISSION: REAR-WHEEL DRIVE"
	]
}

# -------------------------
# SCENE PATHS
# -------------------------

func _ready():
	RoadChallengeSave.load_progress()
	$UpgradeMenu.visible = false
	MusicManager.play_menu_music()

	unlocked_cars = Cars.unlocked_cars
	_update_class_locks()
	if GameMode.game_mode!="Club Cups":
		$Control/UpgradesButton.visible=false

	# Disable class buttons in Club Cups if empty
	if GameMode.game_mode == "Club Cups":
		$Control/ClassList/SUV.disabled = not _class_has_eligible(suv_list)
		$Control/ClassList/CompactCars.disabled = not _class_has_eligible(compact_list)
		$Control/ClassList/MuscleCars.disabled = not _class_has_eligible(muscle_list)
		$Control/ClassList/UrbanRacers.disabled = not _class_has_eligible(urban_list)
		$Control/ClassList/Sedans.disabled = not _class_has_eligible(sedans_list)
		$Control/ClassList/SportCoupe.disabled = not _class_has_eligible(sport_list)
		$Control/ClassList/SportRacing.disabled = not _class_has_eligible(sport_racing_list)
		$Control/ClassList/Supercars.disabled = not _class_has_eligible(supercars_list)
		$Control/ClassList/TrackCars.disabled = not _class_has_eligible(track_cars_list)
	if upgrade_mode:
		$Select.hide()
func _apply_dealership_ui():
	$MoneyLabel.show()
	$Control/CarStats/PriceLabel.show()
	$Select.show()

	$Select.text = "BUY"
	$Select.disabled = false
	$Control/UpgradesButton.hide()

	# Update balance + price
	$MoneyLabel.text = "BALANCE: " + str(Cars.player_money)
	
var car_scene_paths = {
	"Colossus Titan Max":"res://Scenes/hummer_h1.tscn",
	"Colossus Behemoth":"res://Scenes/hummer_h2.tscn",
	"Berkshire Mocha":"res://Scenes/jaguar_s_type.tscn",
	"Mir Cars Nightwolf":"res://Scenes/lexus_lx470.tscn",
	"Straeda Pitbull":"res://Scenes/vw_touareg_v10.tscn",

	"Schroder Atrix Q32":"res://Scenes/audi_tt.tscn",
	"Straeda B32":"res://Scenes/new_beetle.tscn",
	"Kronstadt Beast":"res://Scenes/clk_55.tscn",
	"Zenith Horizon":"res://Scenes/nissan_350z.tscn",
	"Straeda G25":"res://Scenes/golf_v_gti.tscn",
	"Schroder D-20":"res://Scenes/audi_a3.tscn",
	"Mir Cars Crawler":"res://Scenes/volvo_xc90.tscn",
	"Eisenach Escorter":"res://Scenes/bmw_x5.tscn",


	"Kestrel Seabird":"res://Scenes/lotus_exige_s.tscn",
	"Eisenach Roadstar":"res://Scenes/bmw_z4.tscn",
	"Brutus Stingray":"res://Scenes/chevrolet_corvette_c5.tscn",
	"Kuro Zephyr V6":"res://Scenes/lexus_is350.tscn",
	"Kestrel Speedster":"res://Scenes/morgan_aero_8.tscn",
	"Berkshire Blunt":"res://Scenes/jaguar_xkr.tscn",
	"Brutus Viper":"res://Scenes/gt500.tscn",
	"Mir Cars Hutch":"res://Scenes/chevelle_ss.tscn",
	"Schroder Colosso":"res://Scenes/audi_q7.tscn",
	"Eisenach Black Panda":"res://Scenes/bmw_330d.tscn",
	"Eisenach Bengal":"res://Scenes/bmw_135.tscn",
	"Eisenach Prince":"res://Scenes/bmw_m5_e39.tscn",
	"Mir Cars Athletic C70":"res://Scenes/zonda.tscn",
	"Bartoli Track Cruiser":"res://Scenes/mc12.tscn",
	"Brutus Thunderbolt":"res://Scenes/ford_cobra.tscn",



	"Eisenach Monarch":"res://Scenes/bmw_745.tscn",
	"Mir Cars Transporter":"res://Scenes/audi_a8.tscn",
	"Kuro Vault":"res://Scenes/lexus_ls430.tscn",
	"Kronstadt Crest":"res://Scenes/slk.tscn",
	"Schroder Classique Sport":"res://Scenes/audi_rs3.tscn",
	"Bartoli Cruiser":"res://Scenes/granturismo.tscn",
	"Berkshire V12-S":"res://Scenes/aston_db9.tscn",
	"Berkshire Tempest":"res://Scenes/vanquish.tscn",
	"Strandberg Turbo":"res://Scenes/volvo_s60r.tscn",
	"Kuro Serenity":"res://Scenes/lexus_sc.tscn",
	"Eisenach Goblin":"res://Scenes/bmw_1m.tscn",


	"Schroder Atrocity":"res://Scenes/audi_s6.tscn",
	"Kestrel Battleaxe":"res://Scenes/sagaris.tscn",
	"Linetti Shepherd":"res://Scenes/gallardo.tscn",
	"Brutus Venom":"res://Scenes/dodge_viper.tscn",
	"Kuro Persian":"res://Scenes/lexus_gs430.tscn",
	"Kronstadt Fortress":"res://Scenes/s600.tscn",

	"Linetti Terror":"res://Scenes/murcielago.tscn",
	"Linetti Firestorm":"res://Scenes/diablo_road.tscn",
	"Kestrel Guillotine":"res://Scenes/tvr t 440r.tscn",
	"Mir Cars Raptor":"res://Scenes/saleen_s7.tscn",
	"Kuro Zephyr":"res://Scenes/lexus_is250.tscn",
	"Eisenach Suppressor":"res://Scenes/bmw_535d.tscn",
	"Schroder Fastback":"res://Scenes/audi_a5_tdi.tscn",
	"Kronstadt Blazer":"res://Scenes/sl_500.tscn",
	"Kestrel Touring":"res://Scenes/tvr_cerbera.tscn"

}

# -------------------------
# UI UPDATE
# -------------------------
func _get_filtered_list(raw_list: Array) -> Array:
	# Free Race → all cars available
	if GameMode.game_mode == "Free Race":
		return raw_list

	# Club Cups → only unlocked cars + eligible cars
	if GameMode.game_mode == "Club Cups" and ChampionshipState.championship_mode:
		var allowed := ClubCups.get_available_cars(ChampionshipState.active_cup)
		var filtered := []

		for car_name in raw_list:
			if allowed.has(car_name) and unlocked_cars.has(car_name) and unlocked_cars[car_name]["unlocked"]:
				filtered.append(car_name)

		return filtered

	# Road Challenge → respect class unlocks
	if GameMode.game_mode == "Road Challenge":
		var filtered := []
		for car_name in raw_list:
			if RoadChallengeSave.unlocked.get(car_class, false):
				filtered.append(car_name)
		return filtered

	return raw_list
func find_car_controller(node: Node) -> Node:
	if node == null:
		return null

	var script :GDScript= node.get_script()
	if script != null:
		var base := script
		while base != null:
			if base == CarController:
				return node
			base = base.get_base_script()

	for child in node.get_children():
		var found = find_car_controller(child)
		if found != null:
			return found

	return null

func get_base_stats_for(name: String) -> Array:
	if suv.has(name):
		return suv[name]
	if compact.has(name):
		return compact[name]
	if muscle.has(name):
		return muscle[name]
	if urban_racers.has(name):
		return urban_racers[name]
	if sedans.has(name):
		return sedans[name]
	if sport.has(name):
		return sport[name]
	if sport_racing.has(name):
		return sport_racing[name]
	if supercars.has(name):
		return supercars[name]
	if track_cars.has(name):
		return track_cars[name]

	return []

func update_car_ui(stats: Array, name: String):
	var final_stats = stats.duplicate()

	# ============================
	# STOCK STATS IN DEALERSHIP
	# ============================

	if Cars.dealership_mode:
		$Control/CarStats/CountryLabel.set_meta("source_text", final_stats[1])
		$Control/CarStats/HPLabel.set_meta("source_text", final_stats[2])
		$Control/CarStats/WeightLabel.set_meta("source_text", final_stats[3])
		$Control/CarStats/ZeroToHundredLabel.set_meta("source_text", final_stats[4])
		$Control/CarStats/TopSpeedLabel.set_meta("source_text", final_stats[5])
		$Control/CarStats/EngineLabel.set_meta("source_text", final_stats[6])
		$Control/CarStats/AspirationLabel.set_meta("source_text", final_stats[7])
		$Control/CarStats/TorqueLabel.set_meta("source_text", final_stats[8])
		$Control/CarStats/TransmissionLabel.set_meta("source_text", final_stats[9])

	else:
		
		if GameMode.game_mode == "Club Cups" and preview_car != null:

			var cc = find_car_controller(preview_car)

			if cc != null:

				$Control/CarStats/HPLabel.text = "HP: " + str(int(cc.horsepower))
				$Control/CarStats/WeightLabel.text = "WEIGHT: " + str(int(cc.mass)) + " KG"

				if SpeedSettings.SPEED_UNIT == "mph":
					$Control/CarStats/ZeroToHundredLabel.text = \
						"0-62 MPH: %.2fs" % cc.zero_to_hundred

					$Control/CarStats/TopSpeedLabel.text = \
						"TOP SPEED: %d MPH" % int(cc.top_speed_kmh * 0.621371)
				else:
					$Control/CarStats/ZeroToHundredLabel.text = \
						"0-100 KM/H: %.2fs" % cc.zero_to_hundred

					$Control/CarStats/TopSpeedLabel.text = \
						"TOP SPEED: %d KM/H" % int(cc.top_speed_kmh)
					
				
		else:

			var zero_text = final_stats[4]
			var top_text = final_stats[5]

			var zero_val = float(zero_text.split(" ")[2].replace("s", ""))
			var top_val = float(top_text.split(" ")[2])

			if SpeedSettings.SPEED_UNIT == "mph":
				$Control/CarStats/ZeroToHundredLabel.text = "0-62 MPH: " + str(zero_val) + "s"
				$Control/CarStats/TopSpeedLabel.text = "TOP SPEED: " + str(int(top_val * 0.621371)) + " MPH"
			else:
				$Control/CarStats/ZeroToHundredLabel.text = "0-100 KM/H: " + str(zero_val) + "s"
				$Control/CarStats/TopSpeedLabel.text = "TOP SPEED: " + str(int(top_val)) + " KM/H"
	# ============================
	# APPLY STATS TO UI
	# ============================

	$Control/Cars/CarName.text = name
	$Control/CarStats/PPLabel.text = stats[0]
	$Control/CarStats/CountryLabel.text = final_stats[1]
	$Control/CarStats/HPLabel.text = final_stats[2]
	$Control/CarStats/WeightLabel.text = final_stats[3]
	if GameMode.game_mode != "Club Cups":
		$Control/CarStats/ZeroToHundredLabel.text = final_stats[4]
		$Control/CarStats/TopSpeedLabel.text = final_stats[5]
		$Control/CarStats/HPLabel.text = final_stats[2]
		$Control/CarStats/WeightLabel.text = final_stats[3]
	$Control/CarStats/EngineLabel.text = final_stats[6]
	$Control/CarStats/AspirationLabel.text = final_stats[7]
	$Control/CarStats/TorqueLabel.text = final_stats[8]
	$Control/CarStats/TransmissionLabel.text = final_stats[9]

	# ============================
	# DEALERSHIP LOGIC
	# ============================

	if Cars.dealership_mode:

		var price :int= car_prices.get(name, 0)
		var sale_price :int= car_sell_prices.get(name, 0)
		var balance := Cars.player_money

		$MoneyLabel.text = "BALANCE: $" + str(balance)

		$Control/Label.text = ""
		$Control/Label.modulate = Color.WHITE

		# Already owned = SELL
		if Cars.unlocked_cars.has(name) and Cars.unlocked_cars[name]["unlocked"]:

			$Control/CarStats/PriceLabel.text = "%s: $%d" % [
	Localization.translate("sale_price"),
	sale_price
]
			$Select.text = Localization.translate("sell")
			$Select.disabled = false

		

		# Not owned = BUY
		else:

			$Control/CarStats/PriceLabel.text = "PRICE: $" + str(price)

			$Select.text = "BUY"
			$Select.disabled = false

			if balance < price:
				$Control/Label.text = "INSUFFICIENT CASH"
				$Control/Label.modulate = Color.RED
				$Select.disabled = true

	# ============================
	# SPEED UNIT DISPLAY
	# ============================

	# ============================
# SPEED UNIT DISPLAY
# ============================

	if GameMode.game_mode == "Club Cups" and preview_car != null:

		var cc = find_car_controller(preview_car)

		if cc != null:

			if SpeedSettings.SPEED_UNIT == "mph":
				$Control/CarStats/ZeroToHundredLabel.text = \
					"0-62 MPH: %.2fs" % cc.zero_to_hundred

				$Control/CarStats/TopSpeedLabel.text = \
					"TOP SPEED: %d MPH" % int(cc.top_speed_kmh * 0.621371)

			else:
				$Control/CarStats/ZeroToHundredLabel.text = \
					"0-100 KM/H: %.2fs" % cc.zero_to_hundred

				$Control/CarStats/TopSpeedLabel.text = \
					"TOP SPEED: %d KM/H" % int(cc.top_speed_kmh)

		else:

			var zero_text = final_stats[4]
			var top_text = final_stats[5]

			var zero_val = float(zero_text.split(" ")[2].replace("s", ""))
			var top_val = float(top_text.split(" ")[2])

			if SpeedSettings.SPEED_UNIT == "mph":

				$Control/CarStats/ZeroToHundredLabel.text = \
					"0-62 MPH: " + str(zero_val) + "s"

				$Control/CarStats/TopSpeedLabel.text = \
					"TOP SPEED: " + str(int(top_val * 0.621371)) + " MPH"

			else:

				$Control/CarStats/ZeroToHundredLabel.text = \
					"0-100 KM/H: " + str(zero_val) + "s"

				$Control/CarStats/TopSpeedLabel.text = \
					"TOP SPEED: " + str(int(top_val)) + " KM/H"
	# 3D PREVIEW LOADING
# -------------------------
func load_preview_car(path: String):
	if preview_car:
		preview_car.queue_free()

	var car_scene = load(path)
	if car_scene == null:
		return

	await get_tree().process_frame
	await get_tree().process_frame
	# ❌ DO NOT update UI here

	var car = car_scene.instantiate()
	car.car_name = car_name

	preview_holder.add_child(car)
	preview_car = car

	car.apply_stats()

	var model_root: Node3D = null
	if car.has_node("ModelRoot"):
		model_root = car.get_node("ModelRoot")
	else:
		model_root = car

	model_root.scale = Vector3.ONE * 1.5
	model_root.position = Vector3.ZERO

	# ⭐ Correct place to update UI
	if GameMode.game_mode == "Club Cups" and car_name != "":
		update_car_ui(get_base_stats_for(car_name), car_name)

# -------------------------

func _process(delta):
	if Cars.dealership_mode:
		if not $MoneyLabel.visible:
			_apply_dealership_ui()


	if preview_car == null:
		return

	var model_root: Node3D = null
	if preview_car.has_node("ModelRoot"):
		model_root = preview_car.get_node("ModelRoot")
	else:
		model_root = preview_car

	model_root.rotate_y(rotation_speed * delta)

# -------------------------
# CLASS BUTTONS
# -------------------------

func _on_4x4suv_pressed():
	
	car_class = "suv"

	var list = _get_filtered_list(suv_list)
	car_index = 0

	if list.is_empty():
		return

	car_name = list[car_index]
	update_car_ui(suv[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()
func _on_compact_cars_pressed():
	car_class = "compact"

	var list = _get_filtered_list(compact_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(compact[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()

func _on_muscle_cars_pressed():
	car_class = "muscle"

	var list = _get_filtered_list(muscle_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(muscle[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()
func _on_urban_racers_pressed():
	car_class = "urban"

	var list = _get_filtered_list(urban_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(urban_racers[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()

func _on_sedans_pressed():
	car_class = "sedans"

	var list = _get_filtered_list(sedans_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(sedans[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()

func _on_sport_coupe_pressed():
	car_class = "sport"

	var list = _get_filtered_list(sport_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(sport[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()

func _on_supercars_pressed():
	car_class = "supercars"

	var list = _get_filtered_list(supercars_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(supercars[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()
func _on_sport_racing_pressed():
	car_class = "sport_racing"

	var list = _get_filtered_list(sport_racing_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(sport_racing[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()


# -------------------------
# INPUT
# -------------------------

func _input(event):
	# Ignore color inputs when no car class is selected (main menu)
	if upgrade_mode:
		return
	if car_class == "":
		if event.is_action_pressed("car_select_left") or event.is_action_pressed("car_select_right"):
			return
		if event.is_action_pressed("color_select_up") or event.is_action_pressed("color_select_down"):
			return

	# Normal behavior inside car select
	if event.is_action_pressed("car_select_left"):
		switch_car(-1)
	if event.is_action_pressed("car_select_right"):
		switch_car(1)

	if event.is_action_pressed("color_select_up"):
		change_color(1)
	if event.is_action_pressed("color_select_down"):
		change_color(-1)
		
	# CHEAT: Unlock all classes with F9
	if event.is_action_pressed("ui_debug"):   # F9
		RoadChallengeSave.unlocked["suv"] = true
		RoadChallengeSave.unlocked["compact"] = true
		RoadChallengeSave.unlocked["muscle"] = true
		RoadChallengeSave.unlocked["urban"] = true
		RoadChallengeSave.unlocked["sedans"] = true
		RoadChallengeSave.unlocked["sport"] = true
		RoadChallengeSave.unlocked["sport_racing"] = true
		RoadChallengeSave.unlocked["supercars"] = true
		RoadChallengeSave.unlocked["track_cars"] = true
		RoadChallengeSave.save_progress()

		print("CHEAT ACTIVATED: All classes unlocked!")
		_update_class_locks()

		


# -------------------------
func switch_car(direction: int):
	if upgrade_mode:
		return

	var list = _get_filtered_list(get_list_for_class(car_class))
	if list.is_empty():
		return

	car_index = (car_index + direction) % list.size()
	car_name = list[car_index]

	update_car_ui(get_stats_for(car_name), car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()

# -------------------------
# COLOR SYSTEM
# -------------------------


func _reset_color():
	color_index = 0

	if Cars.dealership_mode:
		$Control/ColorSelector.hide()
		return

	$Control/ColorSelector.show()
	apply_color_to_preview(car_colors[car_name][0])
	update_color_ui()

func change_color(direction):
	var colors = car_colors[car_name]
	color_index = (color_index + direction) % colors.size()
	if color_index < 0:
		color_index = colors.size() - 1

	apply_color_to_preview(colors[color_index])
	update_color_ui()

func apply_color_to_preview(color: Color):
	if preview_car == null:
		return

	if preview_car.has_node("ModelRoot/Body"):
		var body: Node3D = preview_car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat = child.get_active_material(0)
				if mat:
					mat.albedo_color = color

func update_color_ui():
	if Cars.dealership_mode:
		return
	var colors = car_colors[car_name]

	$Control/ColorSelector/ColorBox1.color = colors[0]
	$Control/ColorSelector/ColorBox2.color = colors[1]
	$Control/ColorSelector/ColorBox3.color = colors[2]
	$Control/ColorSelector/ColorBox4.color = colors[3]

	for i in range(4):
		var box = $Control/ColorSelector.get_child(i)
		box.modulate = Color(1,1,1,1) if i == color_index else Color(0.6,0.6,0.6,1)

# -------------------------
# SELECT BUTTON
# -------------------------

# -------------------------
# SELECT BUTTON (LAN FIX)
# -------------------------
func _on_select_pressed() -> void:
	if upgrade_mode:
		return

	if Cars.dealership_mode:

		var price: int = car_prices.get(car_name, 0)
		var sale_price: int = car_sell_prices.get(car_name, 0)

		# =========================
		# SELL CAR
		# =========================
		if Cars.unlocked_cars.has(car_name) and Cars.unlocked_cars[car_name]["unlocked"]:

			# Prevent selling starter car
			if car_name == "Colossus Behemoth":
				$Control/Label.text = Localization.translate("starter_car")
				$Control/Label.modulate = Color.RED
				return

			Cars.add_money(sale_price)

			Cars.unlocked_cars.erase(car_name)
			Cars.save_unlocked_cars()

			$Control/Label.text = Localization.translate("sold")
			$Control/Label.modulate = Color.GREEN

			$MoneyLabel.text = "balance: $" + str(Cars.player_money)

			update_car_ui(get_stats_for(car_name), car_name)

			return

		# =========================
		# BUY CAR
		# =========================
		if Cars.player_money < price:
			$Control/Label.text = Localization.translate("insufficient_cash")
			$Control/Label.modulate = Color.RED
			return

		Cars.spend_money(price)
		Cars.unlock_car(car_name, "dealership")

		$Control/Label.text = Localization.translate("purchased")
		$Control/Label.modulate = Color.GREEN

		$MoneyLabel.text = "balance: $" + str(Cars.player_money)

		update_car_ui(get_stats_for(car_name), car_name)

		return

	# =========================
	# NORMAL CAR SELECT
	# =========================
	Cars.on_car_selected(car_name)
	Cars.selected_car_name = car_name
	Cars.selected_car = Cars.car_scene_paths.get(car_name, "")
	Cars.selected_color = car_colors.get(car_name, [])[color_index]
	Cars.save_color()

	get_tree().change_scene_to_file("res://Scenes/track_select.tscn")
func _on_back_btn_pressed() -> void:
	if GameMode.game_mode == "Road Challenge":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	elif GameMode.game_mode=="Club Cups":
		get_tree().change_scene_to_file("res://Scenes/championships.tscn")
	elif upgrade_mode==true:
		$Control.show()
		$UpgradeMenu.hide()
	else:
		get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")

func _on_track_cars_pressed():
	car_class = "track_cars"

	var list = _get_filtered_list(track_cars_list)
	car_index = 0
	if list.is_empty(): return

	car_name = list[car_index]
	update_car_ui(track_cars[car_name], car_name)
	load_preview_car(car_scene_paths[car_name])
	_reset_color()


func _update_class_locks():
	# Free Race and Road Challenge share unlocks
	RoadChallengeSave.load_progress()
	if GameMode.game_mode == "Road Challenge":
		await get_tree().process_frame
		$Control/ClassList/SUV.disabled = false
		$Control/ClassList/MuscleCars.disabled = not RoadChallengeSave.unlocked["muscle"]
		$Control/ClassList/CompactCars.disabled = not RoadChallengeSave.unlocked["compact"]
		$Control/ClassList/Sedans.disabled = not RoadChallengeSave.unlocked["sedans"]
		$Control/ClassList/UrbanRacers.disabled = not RoadChallengeSave.unlocked["urban"]
		$Control/ClassList/SportCoupe.disabled = not RoadChallengeSave.unlocked["sport"]
		$Control/ClassList/SportRacing.disabled = not RoadChallengeSave.unlocked["sport_racing"]
		$Control/ClassList/Supercars.disabled = not RoadChallengeSave.unlocked["supercars"]
		$Control/ClassList/TrackCars.disabled = not RoadChallengeSave.unlocked["track_cars"]
		return

	# Normal modes → unlock everything
	for btn in $Control/ClassList.get_children():
		btn.disabled = false
func attempt_purchase(car_name: String):
	var price = car_prices.get(car_name, 0)

	if Cars.unlocked_cars.has(car_name) and Cars.unlocked_cars[car_name]["unlocked"]:
		print("Already owned:", car_name)
		return

	if Cars.player_money < price:
		print("Not enough money! Balance:", Cars.player_money)
		return

	# Deduct money and unlock car
	Cars.spend_money(price)
	Cars.unlock_car(car_name, "dealership")

	print("Purchased:", car_name, "for $", price)

	# Refresh UI
	$MoneyLabel.text = "Money: $" + str(Cars.player_money)
	$Control/PriceLabel.text = "Price: $" + str(price)


func _on_upgrades_pressed() -> void:
	if GameMode.game_mode != "Club Cups":
		return  # upgrades disabled outside Club Cups
	upgrade_mode=true
	if car_name == "":
		return

	upgrade_mode = true

	$Control.hide()
	$UpgradeMenu.show()
	_update_upgrade_menu()
func _update_upgrade_menu():
	if not Cars.upgrades.has(car_name):
		return

	var u = Cars.upgrades[car_name]

	$UpgradeMenu/VBoxContainer/CarLabel.text = car_name

	# Section Titles
	$UpgradeMenu/VBoxContainer/WeightReduction/Label.text = Localization.translate("weight_reduction")
	$UpgradeMenu/VBoxContainer/EngineTune/Label.text = Localization.translate("engine_tune")
	$UpgradeMenu/VBoxContainer/Steering/Label.text = Localization.translate("steering")
	$UpgradeMenu/VBoxContainer/Brakes/Label.text = Localization.translate("brakes")

	# Weight Reduction
	$UpgradeMenu/VBoxContainer/WeightReduction/Stage.text = \
		Localization.translate("stage") + ": " + str(u["weight"])
	$UpgradeMenu/VBoxContainer/WeightReduction/Price.text = \
		"$" + str(2000 * (u["weight"] + 1))

	# Engine Tune
	$UpgradeMenu/VBoxContainer/EngineTune/Stage.text = \
		Localization.translate("stage") + ": " + str(u["engine"])
	$UpgradeMenu/VBoxContainer/EngineTune/Price.text = \
		"$" + str(2500 * (u["engine"] + 1))

	# Steering
	$UpgradeMenu/VBoxContainer/Steering/Stage.text = \
		Localization.translate("stage") + ": " + str(u["steering"])
	$UpgradeMenu/VBoxContainer/Steering/Price.text = \
		"$" + str(1500 * (u["steering"] + 1))

	# Brakes
	$UpgradeMenu/VBoxContainer/Brakes/Stage.text = \
		Localization.translate("stage") + ": " + str(u["brakes"])
	$UpgradeMenu/VBoxContainer/Brakes/Price.text = \
		"$" + str(1800 * (u["brakes"] + 1))

	# Money
	$MoneyLabel.text = Localization.translate("money") + ": $" + str(Cars.player_money)
func get_list_for_class(class_id: String) -> Array:
	match class_id:
		"suv":
			return suv_list
		"compact":
			return compact_list
		"muscle":
			return muscle_list
		"urban":
			return urban_list
		"sedans":
			return sedans_list
		"sport":
			return sport_list
		"sport_racing":
			return sport_racing_list
		"supercars":
			return supercars_list
		"track_cars":
			return track_cars_list
		_:
			return []
func get_stats_for(name: String) -> Array:
	match car_class:
		"suv":
			return suv[name]
		"compact":
			return compact[name]
		"muscle":
			return muscle[name]
		"urban":
			return urban_racers[name]
		"sedans":
			return sedans[name]
		"sport":
			return sport[name]
		"sport_racing":
			return sport_racing[name]
		"supercars":
			return supercars[name]
		"track_cars":
			return track_cars[name]
		_:
			return []


func _on_buy_btn_pressed() -> void:
	if GameMode.game_mode != "Club Cups":
		return

	var u = Cars.upgrades[car_name]
	if u["steering"] >= 3:
		return

	var cost = 1500 * (u["steering"] + 1)
	if not Cars.spend_money(cost):
		return

	u["steering"] += 1
	Cars.save_upgrades()
	_update_upgrade_menu()



func _on_buy_btn_2_pressed() -> void:
	if GameMode.game_mode != "Club Cups":
		return

	var u = Cars.upgrades[car_name]
	if u["engine"] >= 3:
		return

	var cost = 2500 * (u["engine"] + 1)
	if not Cars.spend_money(cost):
		return

	u["engine"] += 1
	Cars.save_upgrades()
	_update_upgrade_menu()



func _on_buy_btn_3_pressed() -> void:
	if GameMode.game_mode != "Club Cups":
		return

	var u = Cars.upgrades[car_name]
	if u["weight"] >= 3:
		return

	var cost = 2000 * (u["weight"] + 1)
	if not Cars.spend_money(cost):
		return

	u["weight"] += 1
	Cars.save_upgrades()
	_update_upgrade_menu()


func _on_buy_btn_4_pressed() -> void:
	if GameMode.game_mode != "Club Cups":
		return

	var u = Cars.upgrades[car_name]
	if u["brakes"] >= 3:
		return

	var cost = 1800 * (u["brakes"] + 1)
	if not Cars.spend_money(cost):
		return

	u["brakes"] += 1
	Cars.save_upgrades()
	_update_upgrade_menu()
func _class_has_eligible(raw_list: Array) -> bool:
	var filtered := _get_filtered_list(raw_list)
	return not filtered.is_empty()
func _kmh_to_mph(kmh: float) -> float:
	return kmh * 0.621371

func _zero_to_hundred_to_mph(time: float) -> float:
	# 0–100 km/h → 0–62 mph
	return time  # acceleration time stays the SAME

func _apply_speed_unit_to_ui():
	var zero_label = $Control/CarStats/ZeroToHundredLabel
	var top_label = $Control/CarStats/TopSpeedLabel

	var zero_text = zero_label.text
	var top_text = top_label.text

	# Extract numbers
	var zero_val = float(zero_text.split(" ")[1].replace("KM/H:", "").replace("MPH:", "").replace("s", ""))
	var top_val = float(top_text.split(" ")[2])

	if SpeedSettings.SPEED_UNIT == "mph":
		var mph_speed = int(top_val * 0.621371)
		zero_label.text = "0-62 MPH: " + str(zero_val) + "s"
		top_label.text = "TOP SPEED: " + str(mph_speed) + " MPH"
	else:
		zero_label.text = "0-100 KM/H: " + str(zero_val) + "s"
		top_label.text = "TOP SPEED: " + str(int(top_val)) + " KM/H"

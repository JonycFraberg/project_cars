extends Node

var LANG: String = "en"

signal language_changed

var TEXT := {
	"en": {
		"road_challenge": "Road Challenge",
		"free_race": "Free Race",
		"career_mode": "Career Mode",
		"sell": "SELL",
		"weight_reduction": "Weight Reduction",
"engine_tune": "Engine Tune",
"steering": "Steering",
"brakes": "Brakes",
"stage": "Stage",
"sale_price": "SALE PRICE",
"na": "NA",
"supercharged": "Supercharged",
"turbo": "Turbo",
"twin_turbo": "Twin Turbo",
"sold": "SOLD!",
"starter_car": "Starter Car",
		"multi_device_play": "Multi-Device Play",
		"normal_race": "Normal Race",
		"laps": "Laps",

		"radar_race": "Radar Race",
		"duel": "Duel",
		"elimination": "Elimination",
		"cop_chase": "Cop Chase",
		"money": "Money",
		"purchased": "PURCHASED!",


		"language_options": "Language Options",
		"colossus": "Colossus Cup",
		"street_tuners": "Street Tuners",
		"berkshire_cup": "Berkshire Cup",
"diesel_masters": "Diesel Masters",
"american_thunder": "American Thunder",
"british_invasion": "British Invasion",
"grand_touring": "Grand Touring Championship",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Engines",
		"zenith_competition": "Zenith Competition",
		"businessman_racers": "Businessman Racers",
		"speedster_tournament": "Speedster Tournament",
		"kuro_cup": "Kuro Cup",
		"all_wheel_grip": "All-Wheel Grip",
		"eisenach_cup": "Eisenach Cup",
		"under_400_hp": "Under 400 HP",
		"brutus_stingray_competition": "Stingray Competition",
		"schroder_cup": "Schroder Cup",
		"gentleman_racers": "Gentleman Racers",
		"japanese_cup": "Japanese Cup",
		"german_cup": "German Cup",
		"kestrel_max_championship": "Kestrel Max",
		"v12_engines": "V12 Engines",
		"supercars": "Supercars",
		"track_cars": "Track Cars",
		"sport_racing": "Sport Racing",
		"special_class": "Special",
		"suv_class": "4x4 SUV",
		"compact_class": "Compact Cars",
		"muscle_class": "Muscle Cars",
		"executive_class": "Executive Cars",
		"urban_performance_class": "Urban Performance Cars",
		"enter_ip_of_host_to_join_game": "Enter IP of host to join game",
"join_lan": "Join LAN",
"host_lan": "Host LAN",

		"sport_coupe_class": "Sport Coupe",
		"sport_racing_class": "Sports Racing Cars",
		"supercars_class": "Supercars",
		"track_class": "Track Cars",
		"races_left": "Races left",
"challenge_complete": "Challenge Complete!",
"reward": "Reward",
"balance": "Balance",
"target": "Target",
"championship_completed": "Championship Completed!",
"congratulations": "Congratulations!",

		"buy": "BUY",
		"price": "PRICE",
		"already_owned": "ALREADY OWNED!",
		"insufficient_cash": "INSUFFICIENT CASH!",
		"select_car": "Select Car",
		"play": "Play",
		"quit": "Quit",
		"resume": "Resume",
		"retry": "Retry",
		"volume": "Volume",
		"upgrades": "Upgrades",
		"car_dealership": "Car Dealership",
		"you_win": "YOU WIN!",
		"you_lose": "YOU LOSE!",
		"hp": "HP",
		"weight": "Weight",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Top Speed",
		"engine": "Engine",
		"italy": "Italy",
		"uk": "UK",
		"sweden": "Sweden",
		"back": "Back",
		"executive_cars": "Executive Cars",
		"urban_performance_cars": "Urban Performance Cars",
		"sport_coupe": "Sport Coupe",

		"aspiration": "Aspiration",
		"torque": "Torque",
		"transmission": "Transmission",
		"country": "Country",
		"kmh": "km/h",
		
		"usa": "USA",
		"germany": "Germany",
		"japan": "Japan",
		"four_wheel_drive": "Four-Wheel Drive",
		"rear_wheel_drive": "Rear-Wheel Drive",
		"front_wheel_drive": "Front-Wheel Drive",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Compact Cars",
		"muscle_cars": "Muscle Cars"
	},

	"fr": {
		"road_challenge": "Défi Routier",
		"free_race": "Course Libre",
		"laps": "Tours",
		"berkshire_cup": "Coupe Berkshire",
"diesel_masters": "Maîtres du Diesel",
"american_thunder": "Tonnerre Américain",
"weight_reduction": "Réduction de poids",
"engine_tune": "Réglage moteur",
"steering": "Direction",
"brakes": "Freins",
"stage": "Niveau",
"british_invasion": "Invasion Britannique",
"grand_touring": "Championnat Grand Tourisme",

		"career_mode": "Mode Carrière",
		"multi_device_play": "Jeu Multi-Appareils",
		"normal_race": "Course Normale",
		"radar_race": "Course Radar",
		"duel": "Duel",
		"elimination": "Élimination",
		"cop_chase": "Course Police",
		"language_options": "Options de langue",
		"colossus": "Coupe Colossus",
		"street_tuners": "Préparateurs de Rue",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "Moteurs V6",
		"zenith_competition": "Compétition Zenith",
		"businessman_racers": "Pilotes d’Affaires",
		"purchased": "ACHETÉ !",

		"speedster_tournament": "Tournoi Speedster",
		"kuro_cup": "Coupe Kuro",
		"all_wheel_grip": "Adhérence Intégrale",
		"eisenach_cup": "Coupe Eisenach",
		"under_400_hp": "Moins de 400 ch",
		"brutus_stingray_competition": "Compétition Stingray",
		"schroder_cup": "Coupe Schröder",
		"gentleman_racers": "Gentlemen Racers",
		"japanese_cup": "Coupe Japonaise",
		"german_cup": "Coupe Allemande",
		"kestrel_max_championshi[]": "Kestrel Max",
		"enter_ip_of_host_to_join_game": "Entrez l’IP de l’hôte pour rejoindre la partie",
"join_lan": "Rejoindre LAN",
"host_lan": "Héberger LAN",

		"v12_engines": "Moteurs V12",
		"supercars": "Supercars",
		"italy": "Italie",
		"uk": "Royaume-Uni",
		"sweden": "Suède",
		"races_left": "Courses restantes",
"challenge_complete": "Défi terminé !",
"reward": "Récompense",
"balance": "Solde",
"target": "Objectif",
"championship_completed": "Championnat terminé !",
"congratulations": "Félicitations !",


"na": "Atmosphérique",
"supercharged": "Compresseur",
"turbo": "Turbo",
"twin_turbo": "Bi-Turbo",
		"back": "Retour",
		"executive": "Voitures de Direction",
		"urban_performance": "Performance Urbaine",
		"sport_coupe": "Coupé Sport",
"sell": "VENDRE",
"sale_price": "PRIX DE VENTE",
"sold": "VENDU !",
"starter_car": "Voiture de départ",
		"track_cars": "Voitures de Circuit",
		"sport_racing": "Course Sportive",
		"special_class": "Spécial",
		"suv_class": "4x4 SUV",
		"compact_class": "Voitures Compactes",
		"muscle_class": "Muscle",
		"executive_cars": "Voitures de Direction",
		"urban_performance_cars": "Performance Urbaine",
		"sport_coupe_class": "Coupé Sport",
		"sport_racing_class": "Course Sportive",
		"supercars_class": "Supercars",
		"track_class": "Voitures de Circuit",
		"buy": "ACHETER",
		"price": "PRIX",
		"already_owned": "DÉJÀ ACHETÉ !",
		"insufficient_cash": "ARGENT INSUFFISANT !",
		"select_car": "Choisir une voiture",
		"play": "Jouer",
		"quit": "Quitter",
		"resume": "Continuer",
		"retry": "Recommencer",
		"volume": "Volume",
		"upgrades": "Améliorations",
		"car_dealership": "Concessionnaire",
		"you_win": "VOUS GAGNEZ !",
		"you_lose": "VOUS PERDEZ !",
		"hp": "Puissance",
		"weight": "Poids",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Vitesse max",
		"engine": "Moteur",
		"aspiration": "Aspiration",
		"torque": "Couple",
		"transmission": "Transmission",
		"country": "Pays",
		"kmh": "km/h",

		"usa": "États-Unis",
		"germany": "Allemagne",
		"japan": "Japon",
		"four_wheel_drive": "Quatre roues motrices",
		"rear_wheel_drive": "Propulsion",
		"front_wheel_drive": "Traction",
		"4x4_suv": "SUV 4x4",
		"compact_cars": "Voitures compactes",
		"muscle_cars": "Muscle Cars"
	},

	"de": {
		"road_challenge": "Straßen-Herausforderung",
		"free_race": "Freies Rennen",
		"career_mode": "Karrieremodus",
		"multi_device_play": "Mehrgeräte Spiel",
		"normal_race": "Normales Rennen",
		"radar_race": "Radarrennen",
		"duel": "Duell",
		"elimination": "Eliminierung",
		"weight_reduction": "Gewichtsreduzierung",
"engine_tune": "Motortuning",
"steering": "Lenkung",
"brakes": "Bremsen",
"stage": "Stufe",
		"cop_chase": "Polizeijagd",
		"berkshire_cup": "Berkshire-Pokal",
"diesel_masters": "Diesel-Meister",
"american_thunder": "Amerikanischer Donner",
"british_invasion": "Britische Invasion",
"grand_touring": "Grand-Touring-Meisterschaft",
		"language_options": "Spracheinstellungen",
		"colossus": "Colossus-Pokal",
		"laps": "Runden",

		"enter_ip_of_host_to_join_game": "IP des Hosts eingeben, um beizutreten",
"join_lan": "LAN beitreten",
"host_lan": "LAN hosten",

		"street_tuners": "Street Tuners",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6-Motoren",
		"zenith_competition": "Zenith-Wettbewerb",
		"races_left": "Verbleibende Rennen",
"challenge_complete": "Herausforderung abgeschlossen!",
"na": "Saugmotor",

"supercharged": "Kompressor",

"turbo": "Turbo",

"twin_turbo": "Biturbo",
"reward": "Belohnung",

"target": "Ziel",
"championship_completed": "Meisterschaft abgeschlossen!",
"congratulations": "Glückwunsch!",

		"businessman_racers": "Geschäftsleute-Racer",
		"speedster_tournament": "Speedster-Turnier",
		"kuro_cup": "Kuro-Pokal",
		"purchased": "GEKAUFT!",

		"all_wheel_grip": "Allrad-Grip",
		"eisenach_cup": "Eisenach-Pokal",
		"italy": "Italien",
		"uk": "Vereinigtes Königreich",
		"sweden": "Schweden",
		"back": "Zurück",
		"executive": "Obere Mittelklasse",
		"urban_performance": "Urban Performance",
		"sport_coupe": "Sportcoupé",

		"under_400_hp": "Unter 400 PS",
		"brutus_stingray_competition": "Stingray-Wettbewerb",
		"schroder_cup": "Schröder-Pokal",
		"gentleman_racers": "Gentleman-Racer",
		"japanese_cup": "Japan-Pokal",
		"german_cup": "Deutschland-Pokal",
		"kestrel_max_championship": "Kestrel Max",
		"v12_engines": "V12-Motoren",
		"supercars": "Supercars",
		"track_cars": "Track Cars",
		"sport_racing": "Sport Racing",
		"special_class": "Spezial",
		"suv_class": "4x4 SUV",
		"compact_class": "Kompaktwagen",
		"muscle_class": "Muscle",
		"executive_cars": "Obere Mittelklasse",
		"urban_performance_cars": "Urban Performance",
		"sport_coupe_class": "Sportcoupé",
		"sport_racing_class": "Sport Racing",
		"supercars_class": "Supercars",
		"track_class": "Track Cars",
		"buy": "KAUFEN",
		"balance": "GUTHABEN",
		"price": "PREIS",
		"already_owned": "BEREITS GEKAUFT!",
		"insufficient_cash": "ZU WENIG GELD!",
		"select_car": "Auto auswählen",
		"play": "Spielen",
		"quit": "Beenden",
		"resume": "Fortsetzen",
		"retry": "Erneut versuchen",
		"volume": "Lautstärke",
		"upgrades": "Upgrades",
		"car_dealership": "Autohaus",
		"you_win": "DU GEWINNST!",
		"you_lose": "DU VERLIERST!",
		"hp": "PS",
		"weight": "Gewicht",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Höchstgeschwindigkeit",
		"engine": "Motor",
		"aspiration": "Aufladung",
		"torque": "Drehmoment",
		"transmission": "Getriebe",
		"country": "Land",
		"kmh": "km/h",
		
		"usa": "USA",
		"germany": "Deutschland",
		"japan": "Japan",
		"four_wheel_drive": "Allradantrieb",
		"rear_wheel_drive": "Hinterradantrieb",
		"front_wheel_drive": "Vorderradantrieb",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompaktwagen",
		"sell": "VERKAUFEN",
"sale_price": "VERKAUFSPREIS",
"sold": "VERKAUFT!",
"starter_car": "Starterfahrzeug",
		"muscle_cars": "Muscle-Cars"
	},

	"ru": {
		"road_challenge": "Дорожный вызов",
		"free_race": "Свободная гонка",
		"career_mode": "Карьерный режим",
		"enter_ip_of_host_to_join_game": "Введите IP хоста, чтобы присоединиться",
"join_lan": "Присоединиться к LAN",
"berkshire_cup": "Кубок Berkshire",
"diesel_masters": "Мастера Дизеля",
"sell": "ПРОДАТЬ",
"sale_price": "ЦЕНА ПРОДАЖИ",
"sold": "ПРОДАНО!",
"starter_car": "Стартовый автомобиль",
"american_thunder": "Американский Гром",
"british_invasion": "Британское Вторжение",
"grand_touring": "Чемпионат Гран Туризмо",
"laps": "Круги",
"weight_reduction": "Снижение веса",
"engine_tune": "Тюнинг двигателя",
"steering": "Рулевое управление",
"brakes": "Тормоза",
"stage": "Уровень",
"host_lan": "Создать LAN",
"races_left": "Осталось гонок",
"challenge_complete": "Испытание завершено!",
"reward": "Награда",
"target": "Цель",
"championship_completed": "Чемпионат завершён!",
"congratulations": "Поздравляем!",

		"multi_device_play": "Мульти-девайс",
		"normal_race": "Обычная гонка",
		"radar_race": "Радарная гонка",
		"na": "Атмосферный",

"supercharged": "Компрессор",

"turbo": "Турбо",

"twin_turbo": "Твин-Турбо",
		"purchased": "КУПЛЕНО!",

		"duel": "Дуэль",
		"elimination": "Элиминация",
		"cop_chase": "Погоня полиции",
		"language_options": "Языковые настройки",
		"colossus": "Кубок Colossus",
		"street_tuners": "Уличные тюнеры",
		"muscle_hustle": "Muscle Hustle",
		"italy": "Италия",
		"uk": "Великобритания",
		"sweden": "Швеция",
		"back": "Назад",
		"special": "Особый",
		"executive": "Представительские авто",
		"urban_performance": "Городские спорткары",
		"sport_coupe": "Спортивные купе",

		"v6_engines": "Двигатели V6",
		"zenith_competition": "Соревнование Zenith",
		"businessman_racers": "Гонщики-бизнесмены",
		"speedster_tournament": "Турнир Speedster",
		"kuro_cup": "Кубок Kuro",
		"all_wheel_grip": "Полный привод",
		"eisenach_cup": "Кубок Eisenach",
		"under_400_hp": "До 400 л.с.",
		"brutus_stingray_competition": "Соревнование Stingray",
		"schroder_cup": "Кубок Schröder",
		"gentleman_racers": "Гонщики-джентльмены",
		"japanese_cup": "Японский кубок",
		"german_cup": "Немецкий кубок",
		"kestrel_max_championship": "Kestrel Max",
		"v12_engines": "Двигатели V12",
		"supercars": "Суперкары",
		"track_cars": "Трековые машины",
		"sport_racing": "Спортивные гонки",
		"special_class": "Особый",
		"suv_class": "4x4 SUV",
		"compact_class": "Компактные автомобили",
		"muscle_class": "Muscle",
		"executive_cars": "Представительские авто",
		"urban_performance_cars": "Городские спорткары",
		"sport_coupe_class": "Спортивные купе",
		"sport_racing_class": "Спортивные гонки",
		"supercars_class": "Суперкары",
		"track_class": "Трековые машины",
		"buy": "КУПИТЬ",
		"balance": "БАЛАНС",
		"price": "ЦЕНА",
		"already_owned": "УЖЕ КУПЛЕНО!",
		"insufficient_cash": "НЕДОСТАТОЧНО ДЕНЕГ!",
		"select_car": "Выбор машины",
		"play": "Играть",
		"quit": "Выйти",
		"resume": "Продолжить",
		"retry": "Повторить",
		"volume": "Громкость",
		"upgrades": "Улучшения",
		"car_dealership": "Автосалон",
		"you_win": "ВЫ ПОБЕДИЛИ!",
		"you_lose": "ВЫ ПРОИГРАЛИ!",
		"hp": "Л.с.",
		"weight": "Вес",
		"zero_to_hundred": "0–100 км/ч",
		"top_speed": "Макс. скорость",
		"engine": "Двигатель",
		"aspiration": "Наддув",
		"torque": "Крутящий момент",
		"transmission": "Трансмиссия",
		"country": "Страна",
		"kmh": "км/ч",
	
		"usa": "США",
		"germany": "Германия",
		"japan": "Япония",
		"four_wheel_drive": "Полный привод",
		"rear_wheel_drive": "Задний привод",
		"front_wheel_drive": "Передний привод",
		"4x4_suv": "Внедорожник 4x4",
		"compact_cars": "Компактные",
		"muscle_cars": "Масл-кары"
	},

	"sh": {
		"road_challenge": "Drumski Izazov",
		"free_race": "Slobodna Trka",
		"career_mode": "Karijerni Mod",
		"multi_device_plau": "Više Uređaja",
		"normal_race": "Normalna Trka",
		"radar_race": "Radar Trka",
		"duel": "Duel",
		"elimination": "Eliminacija",
		"cop_chase": "Policijska Potjera",
		"language_options": "Jezičke opcije",
		"colossus": "Colossus Kup",
		"weight_reduction": "Smanjenje Težine",
"engine_tune": "Podešavanje Motora",
"na": "Atmosferski",
"supercharged": "Kompresor",
"turbo": "Turbo",
"twin_turbo": "Twin Turbo",
"steering": "Upravljanje",
"brakes": "Kočnice",
"stage": "Nivo",
		"purchased": "KUPOVANO!",


		"street_tuners": "Street Tuners",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Motori",
		"enter_ip_of_host_to_join_game": "Unesi IP hosta da se pridružiš",
"join_lan": "Pridruži se LAN-u",
"host_lan": "Hostuj LAN",

		"zenith_competition": "Zenith Takmičenje",
		"businessman_racers": "Biznismeni Trkači",
		"speedster_tournament": "Speedster Turnir",
		"kuro_cup": "Kuro Kup",
		"all_wheel_grip": "Pogon na sve točkove",
		"eisenach_cup": "Eisenach Kup",
		"italy": "Italija",
		"laps": "Krugovi",

		"uk": "Ujedinjeno Kraljevstvo",
		"sweden": "Švedska",
		"back": "Nazad",

		"special": "Specijal",
		"executive": "Poslovna Vozila",
		"berkshire_cup": "Berkshire Kup",
"diesel_masters": "Majstori Dizela",
"american_thunder": "Američki Grom",
"british_invasion": "Britanska Invazija",
"grand_touring": "Grand Touring Šampionat",
		"urban_performance": "Urbana Performansa",
		
		"sport_coupe": "Sportski Kupe",

		"under_400_hp": "Ispod 400 HP",
		"brutus_stingray_competition": "Stingray Takmičenje",
		"schroder_cup": "Schröder Kup",
		"gentleman_racers": "Gentleman Trkači",
		"japanese_cup": "Japanski Kup",
		"german_cup": "Njemački Kup",
		"kestrel_max_championship": "Kestrel Max",
		"v12_engines": "V12 Motori",
		"supercars": "Superautomobili",
		"track_cars": "Trkaći Automobili",
		"sport_racing": "Sportske Trke",
		"special_class": "Specijal",
		"sell": "PRODAJ",
"sale_price": "PRODAJNA CIJENA",
"sold": "PRODANO!",
"starter_car": "Početno vozilo",

		"suv_class": "4x4 SUV",
		"compact_class": "Kompaktna Vozila",
		"muscle_class": "Muscle",
		"executive_cars": "Poslovna Vozila",
		"urban_performance_cars": "Urbana Performansa",
		"sport_coupe_class": "Sportski Kupe",
		"sport_racing_class": "Sportske Trke",
		"supercars_class": "Superautomobili",
		"track_class": "Trkaći Automobili",
		"buy": "KUPI",
		"balance": "STANJE",
		"price": "CENA",
		"already_owned": "VEĆ KUPOVANO!",
		"insufficient_cash": "NEDOVOLJNO NOVCA!",
		"select_car": "Izbor vozila",
		"play": "Igraj",
		"quit": "Izlaz",
		"resume": "Nastavi",
		"retry": "Pokušaj ponovo",
		"volume": "Zvuk",

"challenge_complete": "Izazov završen!",
"reward": "Nagrada",

"target": "Cilj",
"championship_completed": "Šampionat završen!",
"congratulations": "Čestitamo!",

		"upgrades": "Nadogradnje",
		"car_dealership": "Auto Kuća",
		"you_win": "POBJEDA!",
		"you_lose": "PORAZ!",
		"hp": "HP",
		
		"weight": "Težina",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Maksimalna brzina",
		"engine": "Motor",
		"aspiration": "Aspiracija",
		"torque": "Obrtni moment",
		"transmission": "Transmisija",
		"country": "Država",
		"kmh": "km/h",
		
	
		"usa": "SAD",
		"germany": "Njemačka",
		"japan": "Japan",
		"four_wheel_drive": "Pogon na sve točkove",
		"rear_wheel_drive": "Zadnji pogon",
		"front_wheel_drive": "Prednji pogon",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompaktna vozila",
		"muscle_cars": "Muscle automobili"
	},

	"tr": {
		"road_challenge": "Yol Mücadelesi",
		"free_race": "Serbest Yarış",
		"sell": "SAT",
"sale_price": "SATIŞ FİYATI",
"sold": "SATILDI!",
"starter_car": "Başlangıç Aracı",
		"challenge_complete": "Mücadele tamamlandı!",
"reward": "Ödül",

"target": "Hedef",
"championship_completed": "Şampiyona tamamlandı!",
"congratulations": "Tebrikler!",
		"career_mode": "Kariyer Modu",
		"multi_device_play": "Çoklu Cihaz",
		"enter_ip_of_host_to_join_game": "Oyuna katılmak için hostun IP’sini gir",
"join_lan": "LAN’a Katıl",
"na": "Atmosferik",
"supercharged": "Süperşarj",
"turbo": "Turbo",
"twin_turbo": "Çift Turbo",
"host_lan": "LAN Oluştur",

		"normal_race": "Normal Yarış",
		"radar_race": "Radar Yarışı",
		"purchased": "SATIN ALINDI!",

		"duel": "Düello",
		"elimination": "Eleme",
		"cop_chase": "Polis Takibi",
		"language_options": "Dil Seçenekleri",
		"laps": "Turlar",

		"colossus": "Colossus Kupası",
		"street_tuners": "Sokak Tunerları",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Motorlar",
		"italy": "İtalya",
		"uk": "Birleşik Krallık",
		"sweden": "İsveç",
		"back": "Geri",

		"special": "Özel",
		"executive_class": "Yönetici Arabalar",
		"urban_performance": "Kentsel Performans",
		"sport_coupe": "Spor Coupe",

		"zenith_competition": "Zenith Yarışı",
		"businessman_racers": "İş Adamı Yarışçıları",
		"speedster_tournament": "Speedster Turnuvası",
		"kuro_cup": "Kuro Kupası",
		"all_wheel_grip": "Dört Çeker Tutuş",
		"berkshire_cup": "Berkshire Kupası",
"diesel_masters": "Dizel Ustaları",
"american_thunder": "Amerikan Gücü",
"british_invasion": "Britanya İstilası",
"grand_touring": "Grand Touring Şampiyonası",
		"eisenach_cup": "Eisenach Kupası",
		"under_400_hp": "400 Beygir Altı",
		"brutus_stingray_competition": "Stingray Yarışı",
		"schroder_cup": "Schröder Kupası",
		"gentleman_racers": "Centilmen Yarışçılar",
		"japanese_cup": "Japon Kupası",
		"german_cup": "Alman Kupası",
		"kestrel_max_championship": "Kestrel Max",
		"weight_reduction": "Ağırlık Azaltma",
"engine_tune": "Motor Ayarı",
"steering": "Direksiyon",
"brakes": "Frenler",
"stage": "Seviye",
		"v12_engines": "V12 Motorlar",
		"supercars": "Süper Arabalar",
		"track_cars": "Pist Arabaları",
		"sport_racing": "Spor Yarışları",
		"special_class": "Özel",
		"suv_class": "4x4 SUV",
		"compact_class": "Kompakt Arabalar",
		"muscle_class": "Muscle",
		"executive_cars": "Yönetici Arabalar",
		"urban_performance_cars": "Kentsel Performans",
		"sport_coupe_class": "Spor Coupe",
		"sport_racing_class": "Spor Yarışları",
		"supercars_class": "Süper Arabalar",
		"track_class": "Pist Arabaları",
		"buy": "SATIN AL",
		"balance": "BAKİYE",
		"price": "FİYAT",
		"already_owned": "ZATEN SATIN ALINDI!",
		"insufficient_cash": "YETERSİZ PARA!",
		"select_car": "Araba Seç",
		"play": "Oyna",
		"quit": "Çıkış",
		"resume": "Devam Et",
		"retry": "Tekrar Dene",
		"volume": "Ses",
		"upgrades": "Yükseltmeler",
		"car_dealership": "Araba Bayisi",
		"you_win": "KAZANDIN!",
		"you_lose": "KAYBETTİN!",
		"hp": "Beygir Gücü",
		"weight": "Ağırlık",
		"zero_to_hundred": "0–100 km/sa",
		"top_speed": "Azami Hız",
		"engine": "Motor",
		"aspiration": "Besleme",
		"torque": "Tork",
		"transmission": "Şanzıman",
		"country": "Ülke",
		"kmh": "km/sa",

		"usa": "ABD",
		"germany": "Almanya",
		"japan": "Japonya",
		"four_wheel_drive": "Dört Tekerlekten Çekiş",
		"rear_wheel_drive": "Arkadan İtiş",
		"front_wheel_drive": "Önden Çekiş",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompakt Arabalar",
		"muscle_cars": "Muscle Arabalar"
	}
}


func _ready() -> void:
	normalize_dictionary()
	load_language()
# Normalize ANY input into a predictable format
func normalize_key(key: String) -> String:
	var k := key.strip_edges().to_lower()

	# Remove punctuation that breaks matching
	k = k.replace("!", "")
	k = k.replace("?", "")
	k = k.replace(":", "")
	k = k.replace(",", "")
	k = k.replace(".", "")

	# Normalize spacing
	k = k.replace(" ", "_")
	k = k.replace("-", "_")

	while k.find("__") != -1:
		k = k.replace("__", "_")

	return k

# Find best matching key inside a language dictionary
func find_best_key(lang: String, key: String) -> String:
	var lower := normalize_key(key)

	# 1. Exact match only
	if TEXT[lang].has(lower):
		return lower

	# 2. If the key contains spaces → it's a car name or engine type → DO NOT MATCH
	if key.count(" ") > 0:
		return ""

	# 3. If the key contains numbers → it's an engine type → DO NOT MATCH
	if key.is_valid_float() or key.is_valid_int():
		return ""

	# 4. Prefix match ONLY for UI labels
	for k in TEXT[lang].keys():
		if lower.begins_with(k):
			return k

	# 5. Word match DISABLED (too dangerous)
	return ""

# Main translation function
func translate(key: String) -> String:
	var best := find_best_key(LANG, key)
	if best != "":
		return TEXT[LANG][best]

	# fallback to English best match
	var best_en := find_best_key("en", key)
	if best_en != "":
		return TEXT["en"][best_en]

	# IMPORTANT: return key BUT normalized for future matching
	return key

func set_language(code: String) -> void:
	if TEXT.has(code):
		LANG = code
		save_language()

		# Apply font
		if Engine.has_singleton("UiTheme"):
			UiTheme.apply_language_font(LANG)

		# Refresh all UI text
		refresh_ui()

func save_language() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("language", "current", LANG)
	cfg.save("user://settings.cfg")

func load_language() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://settings.cfg") == OK:
		var saved: String = cfg.get_value("language", "current", "en")
		if TEXT.has(saved):
			LANG = saved

	if Engine.has_singleton("UiTheme"):
		UiTheme.apply_language_font(LANG)
func refresh_ui(node: Node = null) -> void:
	if node == null:
		node = get_tree().root

	for child in node.get_children():

		if child is Label or child is Button or child is RichTextLabel:

			# Store original English text ONCE
			if not child.has_meta("original_text"):
				child.set_meta("original_text", child.text)

			var original := str(child.get_meta("original_text"))

			# Split into lines
			var lines := original.split("\n")

			var translated_lines := []
			for line in lines:
				translated_lines.append(translate(line))

			child.text = "\n".join(translated_lines)


		refresh_ui(child)
func normalize_dictionary() -> void:
	for lang in TEXT.keys():
		var new_dict := {}
		for key in TEXT[lang].keys():
			var norm := normalize_key(key)
			new_dict[norm] = TEXT[lang][key]
		TEXT[lang] = new_dict
func set_text(node: Node, text: String) -> void:
	# Store original English text
	node.set_meta("original_text", text)

	# Translate immediately
	var lines := text.split("\n")
	var translated := []
	for line in lines:
		translated.append(translate(line))
	node.text = "\n".join(translated)

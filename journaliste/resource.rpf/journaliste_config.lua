TEXT = {
	OFFICE = 'Prise de service',
	GARAGE	= 'Garage',
	PARKING = 'Parking',
	HELIPAD = 'Helipad',
	OUTFIT = 'Vestiaire',
	SAFE = 'Coffre d\'entreprise',
	PLATE = 'JOUR',
	JOB_INFO = '~o~Journaliste Info',
	CLOSE = 'Fermer',
	START_SERVICE = 'Appuyez sur ~INPUT_PICKUP~ pour ~r~quitter~s~\nle ~y~service actif',
	STOP_SERVICE = 'Appuyez sur ~INPUT_PICKUP~ pour ~g~entrer~s~\nen ~y~service actif',
	PICKUP_GARAGE = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nun véhicule dans votre ~o~garage',
	PICKUP_PARKING = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nun véhicule dans votre ~b~parking',
	PICKUP_HELI = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nvotre ~g~hélicoptère',
	PICKUP_OUTFIT = 'Appuyez sur ~INPUT_PICKUP~ pour changer\n votre ~p~tenue de travail',
	VEH_SPAWN = '~b~Véhicule de service~s~ mis à disposition',
	VEH_DESPAWN = '~b~Véhicule de service~s~ rangé',
    VEH_SPAWN_IMPOSSIBLE = '~r~Impossible, aucune place disponible',
	NO_INFO = '-- Aucune Info --',
	NO_CALL = '~b~Aucun appel a proximité',
    NO_PENDING_CALL = '  ~g~Aucun appel en attente',
	NEED_IN_SERVICE = '~r~Vous devez être en service pour acceder à ce menu',
    CALL_PENDING = '~s~Appel en attente',
    CALL_INFO_NO_PERSONNEL = '~r~Aucun journaliste en service',
    CALL_INFO_ALL_BUSY = '~o~Tous nos journalistes sont occupés',
    CALL_INFO_WAIT = '~p~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Un journaliste va arriver',
    CALL_RECEIVED = 'Confirmation\nVotre appel à été enregistré',
    CALL_ACCEPT = 'Votre appel a été accepté, un journaliste est en route',
    CALL_CANCEL = 'Le journaliste vient d\'abandonné votre appel',
    CALL_DONE = 'Votre appel a été répondu',
    CALL_IN_PROGRESS = '~r~Vous avez déjà une demande en cours ...',
    MISSION_NEW = 'Un nouvel appel est en cours, il est ajouté dans votre liste de missions',
    MISSION_ACCEPT = '~t~Mission acceptée~s~, mettez vous en route !',
    MISSION_CANCEL = 'L\'appel a été annulé',
    MISSION_CONTEST = 'Vous êtes plusieurs journalistes sur le coup',
    MISSION_UNKNOWN = 'Cette mission n\'est plus d\'actualité',
    MISSION_IN_PROGRESS = 'Cette mission est déjà en cours de traitement',
	MISSION_ABANDON = 'Abandonner la mission',
	HELP_MENU = ' ',
	INFO_MENU = '~INPUT_CELLPHONE_SELECT~ pour choisir\n2x ~INPUT_CELLPHONE_CANCEL~ pour quitter',
	STOW = 'Mettre le véhicule à ranger sur l\'emplacement prévu',
	STOW_VEH = 'Ranger le véhicule',
	STOW_HELI = 'Ranger l\'hélico',
	VEH_POLMAV = 'Équipé d\'une puissante caméra pour filmer les courses-poursuites ridicules du LSPD.',
	VEH_FROGGER = 'Spacieux et stable, convient pour faire de discrets reportages sur les magouilles du Benny\'s.',
	VEH_RUMPO = 'Très prisé des kidnappeurs, idéal pour le transport de matériel ou de personnes vivantes ou non.',
	VEH_NEWSVAN = 'Permet de faire du direct rapidement avant que le gouverneur ait le temps de cacher les corps.',
	OUTFIT_INVESTIGATOR = 'Mi-détéctive, mi-inspecteur, vous serez plus apte à délier les langues avec cette tenue',
	OUTFIT_REPORTER = 'Idéal pour braver la tempête et mettre votre vie en jeu pour un simple point sur la météo',
	OUTFIT_CLASSY = 'Indispensable pour vous infiltrer dans les soirées mondaines et sur les tapis rouges',
	OUTFIT_PAPARAZZI = 'Pour violer l\'intimité du gouverneur pendant sa séance de bronzette naturiste',
	OUTFIT_CAMERAMAN = 'Il faut bien quelqu\'un pour filmer les CRS en train de tabasser ces bobos gauchistes !',
	OUTFIT_PILOT = 'Cette tenue vous octroie une aptitude à faire des doubles loopings dans les hélicos de Weazel News',
	OUTFIT_ORIGIN = 'Votre tenue d\'origine, insignifiante et négligé, comme votre vie IRL ...',
	OUTFIT_MANDATORY = '~r~Vous devez avoir une tenue de travail pour prendre votre service',
	CONFIRM_START_SERVICE = 'Vous êtes en ~g~service',
	CONFIRM_STOP_SERVICE = 'Vous n\'êtes plus en ~r~service',
	CONFIRM_OUTFIT_ORIGIN = 'Votre ~p~tenue ~s~d\'origine vous a été restituée',
	CONFIRM_OUTFIT_CHANGE = 'Vous portez une nouvelle ~p~tenue'
}

KEY = {
	E = 51,			--INPUT_CONTEXT
	UP = 172,		--INPUT_CELLPHONE_UP
	DOWN = 173,		--INPUT_CELLPHONE_DOWN
	ENTER = 176,	--INPUT_CELLPHONE_SELECT
	BACKSPACE = 177 --INPUT_CELLPHONE_CANCEL
}

spawn = {
	garage = {
	x= -532.43,
	y= -889.17,
	z= 24.87,
    h= 180.0
	},
	parking = {
	x= -556.39,
	y= -925.23,
	z= 23.86,
    h= 270.0
	},
	helipad = {
	x= -583.38,
	y= -930.41,
	z= 36.83,
    h= 180.0
	}
}

blips = {
	[TEXT.OFFICE] = {
		id= 408,
		x= -1055.48,
		y= -242.73,
		z= 43.02,
		d= 10, -- rayon d'apparition marker
		a= 2,  -- rayon d'activation marker
		r= 1.0 -- rayon drawmarker
	},
	[TEXT.GARAGE] = {
		id= 357,
		x= -536.98,
		y= -889.01,
		z= 24.0,
		d= 50,
		a= 2,
		r= 1.0
	},
	[TEXT.PARKING] = {
		id= 388,
		x= -555.95,  
		y= -921.18,
		z= 22.87,
		d= 35,
		a= 2,
		r= 1.0
	},
	[TEXT.HELIPAD] = {
		id= 389,
		x= -576.47,
		y= -927.62,
		z= 35.83,
		d= 50,
		a= 2,
		r= 1.0
	},
	[TEXT.OUTFIT] = {
		id= 366,
		x= -1050.01,
		y= -229.40,
		z= 43.02,
		d= 15,
		a= 2,
		r= 1.0
	},
	[TEXT.SAFE] = {
		id= 400,
		x= -1055.13,
		y= -230.76,
		z= 42.02,
		d= 5,
		a= 2,
		r= 1.0
	}
}
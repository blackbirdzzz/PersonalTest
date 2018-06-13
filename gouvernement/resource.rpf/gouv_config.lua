TEXT = {
	OFFICE = 'Prise de service',
	GARAGE	= 'Garage',
	PARKING = 'Parking',
	HELIPAD = 'Helipad',
	HANGAR = 'Hangar',
	OUTFIT = 'Vestiaire',
	SAFE = 'Coffre du gouvernement',
	PLATE = 'GOUV',
	JOB_INFO = '~o~Gouverneur Info',
	CLOSE = 'Fermer',
	START_SERVICE = 'Appuyez sur ~INPUT_PICKUP~ pour ~r~quitter~s~\nle ~y~service actif',
	STOP_SERVICE = 'Appuyez sur ~INPUT_PICKUP~ pour ~g~entrer~s~\nen ~y~service actif',
	PICKUP_GARAGE = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nun véhicule dans votre ~o~garage',
	PICKUP_PARKING = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nun véhicule dans votre ~b~parking',
	PICKUP_HELI = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nvotre ~g~hélicoptère',
	PICKUP_HANGAR = 'Appuyez sur ~INPUT_PICKUP~ pour sortir ou ranger\nvotre ~y~jet',
	PICKUP_OUTFIT = 'Appuyez sur ~INPUT_PICKUP~ pour changer\n votre ~p~tenue de travail',
	VEH_SPAWN = '~b~Véhicule de service~s~ mis à disposition',
	VEH_DESPAWN = '~b~Véhicule de service~s~ rangé',
    VEH_SPAWN_IMPOSSIBLE = '~r~Impossible, aucune place disponible',
	NO_INFO = '-- Aucune Info --',
	NO_CALL = '~b~Aucun appel a proximité',
    NO_PENDING_CALL = '  ~g~Aucun appel en attente',
	NEED_IN_SERVICE = '~r~Vous devez être en service pour acceder à ce menu',
    CALL_PENDING = '~s~Appel en attente',
    CALL_INFO_NO_PERSONNEL = '~r~Aucun membre du gouvernement en service',
    CALL_INFO_ALL_BUSY = '~o~Tous les membres du gouvernement sont occupés',
    CALL_INFO_WAIT = '~p~Votre appel est sur attente',
    CALL_INFO_OK = '~g~Un membres du gouvernement va arriver',
    CALL_RECEIVED = 'Confirmation\nVotre appel à été enregistré',
    CALL_ACCEPT = 'Votre appel a été accepté, un membres du gouvernement est en route',
    CALL_CANCEL = 'Le membres du gouvernement vient d\'abandonné votre appel',
    CALL_DONE = 'Votre appel a été répondu',
    CALL_IN_PROGRESS = '~r~Vous avez déjà une demande en cours ...',
    MISSION_NEW = 'Un nouvel appel est en cours, il est ajouté dans votre liste de missions',
    MISSION_ACCEPT = '~t~Mission acceptée~s~, mettez vous en route !',
    MISSION_CANCEL = 'L\'appel a été annulé',
    MISSION_CONTEST = 'Vous êtes plusieurs  membres du gouvernement sur le coup',
    MISSION_UNKNOWN = 'Cette mission n\'est plus d\'actualité',
    MISSION_IN_PROGRESS = 'Cette mission est déjà en cours de traitement',
	MISSION_ABANDON = 'Abandonner la mission',
	HELP_MENU = ' ',
	INFO_MENU = '~INPUT_CELLPHONE_SELECT~ pour choisir\n~INPUT_CELLPHONE_CANCEL~ pour quitter',
	STOW = 'Mettre le véhicule à ranger sur l\'emplacement prévu',
	STOW_VEH = 'Ranger le véhicule',
	STOW_HELI = 'Ranger l\'hélico',
	STOW_AVION = 'Ranger l\'avion',
	VEH_ONEBEAST = 'Blindé et pare-balles, vos conseillers et vos prostitués seront à l\'abri dans ce véhicule.',
	VEH_WHITEHAWK = 'Évitez le trafic pour aller faire votre golf, les bouchons, c\'est pour les pauvres.',
	VEH_ESCALADE = 'Un journaliste a des infos compromettante ? Le coffre est assez grand pour lui et ses acolytes.',
	VEH_LUXOR = 'Ce jet vous octroie l\'autorisation de survoler Los Santos même avec plusieurs kilos de cocaïne a son bord.',
	OUTFIT_GOVERNOR = 'Montrez votre supériorité sociale face à ce bas peuple et montrez leur qui dirige la ville !',
	OUTFIT_BODYGUARD = 'Vous prendrez une balle pour votre gouverneur ? Ça tombe bien, cette tenue n\'a pas de pare-balles.',
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
		x= -411.60,
		y= 1067.13,
		z= 323.84,
		h= 162.0
	},
	parking = {
		x= -421.96,
		y= 1198.47,
		z= 325.64,
		h= 50.0
	},
	helipad = {
		x= -456.7,
		y= 1142.91,
		z= 327.64,
		h= 73.0
	},
	hangar = {
		x= -966.6,
		y= -2982.65,
		z= 13.94,
		h= 60.0
	}
}

blips = {
	[TEXT.OFFICE] = {
		id= 408,
		x= -1570.91,
		y= -575.28,
		z= 107.52,
		d= 10, -- rayon d'apparition marker
		a= 2,  -- rayon d'activation marker
		r= 1.0 -- rayon drawmarker
	},
	[TEXT.GARAGE] = {
		id= 357,
		x= -407.50,  
		y= 1066.49,
		z= 322.84,
		d= 50,
		a= 2,
		r= 1.0
	},
	[TEXT.PARKING] = {
		id= 388,
		x= -426.84,
		y= 1201.23,
		z= 324.75,
		d= 35,
		a= 2,
		r= 1.0
	},
	[TEXT.HELIPAD] = {
		id= 389,
		x= -457.74,
		y= 1131.16,
		z= 324.87,
		d= 50,
		a= 2,
		r= 1.0
	},
	[TEXT.HANGAR] = {
		id= 359,
		x= -968.18,
		y= -2968.27,
		z= 12.94,
		d= 50,
		a= 2,
		r= 1.0
	},
	[TEXT.OUTFIT] = {
		id= 366,
		x= -1565.74,
		y= -570.76,
		z= 107.52,
		d= 15,
		a= 2,
		r= 1.0
	},
	[TEXT.SAFE] = {
		id= 400,
		x= -1555.79,
		y= -575.12,
		z= 107.53,
		d= 5,
		a= 2,
		r= 1.0
	}
}
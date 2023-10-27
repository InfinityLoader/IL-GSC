/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airdrop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 90
 * Decompile Time: 1294 ms
 * Timestamp: 10/27/2023 2:13:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachevehicle("littlebird_mp");
	precachemodel("com_plasticcase_friendly");
	precachemodel("com_plasticcase_enemy");
	precachemodel("com_plasticcase_trap_friendly");
	precachemodel("com_plasticcase_trap_bombsquad");
	precachemodel("vehicle_little_bird_armed");
	precachemodel("vehicle_ac130_low_mp");
	precachemodel("sentry_minigun_folded");
	precachestring(&"PLATFORM_GET_RANDOM");
	precachestring(&"PLATFORM_GET_KILLSTREAK");
	precachestring(&"PLATFORM_CALL_NUKE");
	precachestring(&"MP_CAPTURING_CRATE");
	precacheshader("compassping_friendly_mp");
	precacheshader("compassping_enemy");
	precacheitem("airdrop_trap_explosive_mp");
	precachemodel(maps\mp\gametypes\_teams::getteamcratemodel("allies"));
	precachemodel(maps\mp\gametypes\_teams::getteamcratemodel("axis"));
	precachemodel("prop_suitcase_bomb");
	precacheshader(maps\mp\gametypes\_teams::getteamhudicon("allies"));
	precacheshader(maps\mp\gametypes\_teams::getteamhudicon("axis"));
	precacheshader("waypoint_ammo_friendly");
	precacheshader("compass_objpoint_ammo_friendly");
	precacheshader("compass_objpoint_trap_friendly");
	precacheshader("compass_objpoint_ammo_enemy");
	precacheminimapicon("compass_objpoint_c130_friendly");
	precacheminimapicon("compass_objpoint_c130_enemy");
	game["strings"]["ammo_hint"] = &"MP_AMMO_PICKUP";
	game["strings"]["explosive_ammo_hint"] = &"MP_EXPLOSIVE_AMMO_PICKUP";
	game["strings"]["uav_hint"] = &"MP_UAV_PICKUP";
	game["strings"]["counter_uav_hint"] = &"MP_COUNTER_UAV_PICKUP";
	game["strings"]["sentry_hint"] = &"MP_SENTRY_PICKUP";
	game["strings"]["juggernaut_hint"] = &"MP_JUGGERNAUT_PICKUP";
	game["strings"]["airdrop_juggernaut_hint"] = &"MP_JUGGERNAUT_PICKUP";
	game["strings"]["airdrop_juggernaut_def_hint"] = &"MP_JUGGERNAUT_PICKUP";
	game["strings"]["airdrop_juggernaut_gl_hint"] = &"MP_JUGGERNAUT_PICKUP";
	game["strings"]["airdrop_juggernaut_recon_hint"] = &"MP_JUGGERNAUT_PICKUP";
	game["strings"]["trophy_hint"] = &"MP_PICKUP_TROPHY";
	game["strings"]["predator_missile_hint"] = &"MP_PREDATOR_MISSILE_PICKUP";
	game["strings"]["airstrike_hint"] = &"MP_AIRSTRIKE_PICKUP";
	game["strings"]["precision_airstrike_hint"] = &"MP_PRECISION_AIRSTRIKE_PICKUP";
	game["strings"]["harrier_airstrike_hint"] = &"MP_HARRIER_AIRSTRIKE_PICKUP";
	game["strings"]["helicopter_hint"] = &"MP_HELICOPTER_PICKUP";
	game["strings"]["helicopter_flares_hint"] = &"MP_HELICOPTER_FLARES_PICKUP";
	game["strings"]["stealth_airstrike_hint"] = &"MP_STEALTH_AIRSTRIKE_PICKUP";
	game["strings"]["helicopter_minigun_hint"] = &"MP_HELICOPTER_MINIGUN_PICKUP";
	game["strings"]["ac130_hint"] = &"MP_AC130_PICKUP";
	game["strings"]["emp_hint"] = &"MP_EMP_PICKUP";
	game["strings"]["littlebird_support_hint"] = &"MP_LITTLEBIRD_SUPPORT_PICKUP";
	game["strings"]["littlebird_flock_hint"] = &"MP_LITTLEBIRD_FLOCK_PICKUP";
	game["strings"]["uav_strike_hint"] = &"MP_UAV_STRIKE_PICKUP";
	game["strings"]["light_armor_hint"] = &"MP_LIGHT_ARMOR_PICKUP";
	game["strings"]["minigun_turret_hint"] = &"MP_MINIGUN_TURRET_PICKUP";
	game["strings"]["team_ammo_refill_hint"] = &"MP_TEAM_AMMO_REFILL_PICKUP";
	game["strings"]["deployable_vest_hint"] = &"MP_DEPLOYABLE_VEST_PICKUP";
	game["strings"]["deployable_exp_ammo_hint"] = &"MP_DEPLOYABLE_EXP_AMMO_PICKUP";
	game["strings"]["gl_turret_hint"] = &"MP_GL_TURRET_PICKUP";
	game["strings"]["directional_uav_hint"] = &"MP_DIRECTIONAL_UAV_PICKUP";
	game["strings"]["ims_hint"] = &"MP_IMS_PICKUP";
	game["strings"]["heli_sniper_hint"] = &"MP_HELI_SNIPER_PICKUP";
	game["strings"]["heli_minigunner_hint"] = &"MP_HELI_MINIGUNNER_PICKUP";
	game["strings"]["remote_mortar_hint"] = &"MP_REMOTE_MORTAR_PICKUP";
	game["strings"]["remote_uav_hint"] = &"MP_REMOTE_UAV_PICKUP";
	game["strings"]["littlebird_support_hint"] = &"MP_LITTLEBIRD_SUPPORT_PICKUP";
	game["strings"]["osprey_gunner_hint"] = &"MP_OSPREY_GUNNER_PICKUP";
	game["strings"]["remote_tank_hint"] = &"MP_REMOTE_TANK_PICKUP";
	game["strings"]["triple_uav_hint"] = &"MP_TRIPLE_UAV_PICKUP";
	game["strings"]["remote_mg_turret_hint"] = &"MP_REMOTE_MG_TURRET_PICKUP";
	game["strings"]["sam_turret_hint"] = &"MP_SAM_TURRET_PICKUP";
	game["strings"]["escort_airdrop_hint"] = &"MP_ESCORT_AIRDROP_PICKUP";
	level.airdropcrates = getentarray("care_package","targetname");
	level.oldairdropcrates = getentarray("airdrop_crate","targetname");
	if(!level.airdropcrates.size)
	{
		level.airdropcrates = level.oldairdropcrates;
		level.airdropcratecollision = getent(level.airdropcrates[0].target,"targetname");
	}
	else
	{
		foreach(var_01 in level.oldairdropcrates)
		{
			var_01 deletecrate();
		}

		level.airdropcratecollision = getent(level.airdropcrates[0].target,"targetname");
		level.oldairdropcrates = getentarray("airdrop_crate","targetname");
	}

	if(level.airdropcrates.size)
	{
		foreach(var_01 in level.airdropcrates)
		{
			var_01 deletecrate();
		}
	}

	level.numdropcrates = 0;
	level.killstreakfuncs["airdrop_assault"] = ::tryuseassaultairdrop;
	level.killstreakfuncs["airdrop_support"] = ::tryusesupportairdrop;
	level.killstreakfuncs["airdrop_mega"] = ::tryusemegaairdrop;
	level.killstreakfuncs["airdrop_predator_missile"] = ::tryuseairdroppredatormissile;
	level.killstreakfuncs["airdrop_sentry_minigun"] = ::tryuseairdropsentryminigun;
	level.killstreakfuncs["airdrop_juggernaut"] = ::tryusejuggernautairdrop;
	level.killstreakfuncs["airdrop_juggernaut_def"] = ::tryusejuggernautdefairdrop;
	level.killstreakfuncs["airdrop_juggernaut_gl"] = ::tryusejuggernautglairdrop;
	level.killstreakfuncs["airdrop_juggernaut_recon"] = ::tryusejuggernautreconairdrop;
	level.killstreakfuncs["airdrop_trophy"] = ::tryusetrophyairdrop;
	level.killstreakfuncs["airdrop_trap"] = ::tryuseairdroptrap;
	level.killstreakfuncs["airdrop_remote_tank"] = ::tryuseairdropremotetank;
	level.killstreakfuncs["ammo"] = ::tryuseammo;
	level.killstreakfuncs["explosive_ammo"] = ::tryuseexplosiveammo;
	level.killstreakfuncs["explosive_ammo_2"] = ::tryuseexplosiveammo;
	level.killstreakfuncs["light_armor"] = ::tryuselightarmor;
	level.littlebirds = [];
	level.cratetypes = [];
	addcratetype("airdrop_assault","uav",10,::killstreakcratethink);
	addcratetype("airdrop_assault","ims",20,::killstreakcratethink);
	addcratetype("airdrop_assault","predator_missile",20,::killstreakcratethink);
	addcratetype("airdrop_assault","sentry",20,::killstreakcratethink);
	addcratetype("airdrop_assault","precision_airstrike",6,::killstreakcratethink);
	addcratetype("airdrop_assault","helicopter",4,::killstreakcratethink);
	addcratetype("airdrop_assault","littlebird_support",4,::killstreakcratethink);
	addcratetype("airdrop_assault","littlebird_flock",4,::killstreakcratethink);
	addcratetype("airdrop_assault","remote_mortar",3,::killstreakcratethink);
	addcratetype("airdrop_assault","remote_tank",3,::killstreakcratethink);
	addcratetype("airdrop_assault","helicopter_flares",2,::killstreakcratethink);
	addcratetype("airdrop_assault","ac130",2,::killstreakcratethink);
	addcratetype("airdrop_assault","airdrop_juggernaut",1,::juggernautcratethink);
	addcratetype("airdrop_assault","osprey_gunner",1,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","uav",10,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","ims",20,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","predator_missile",20,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","sentry",20,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","precision_airstrike",8,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","littlebird_flock",8,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","remote_mortar",5,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","remote_tank",2,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","helicopter_flares",2,::killstreakcratethink);
	addcratetype("airdrop_osprey_gunner","airdrop_juggernaut",1,::juggernautcratethink);
	addcratetype("airdrop_osprey_gunner","ac130",1,::killstreakcratethink);
	addcratetype("airdrop_support","uav",9,::killstreakcratethink);
	addcratetype("airdrop_support","counter_uav",9,::killstreakcratethink);
	addcratetype("airdrop_support","deployable_vest",8,::killstreakcratethink);
	addcratetype("airdrop_support","sam_turret",6,::killstreakcratethink);
	addcratetype("airdrop_support","remote_uav",5,::killstreakcratethink);
	addcratetype("airdrop_support","remote_mg_turret",5,::killstreakcratethink);
	addcratetype("airdrop_support","stealth_airstrike",4,::killstreakcratethink);
	addcratetype("airdrop_support","triple_uav",3,::killstreakcratethink);
	addcratetype("airdrop_support","airdrop_juggernaut_recon",2,::juggernautcratethink);
	addcratetype("airdrop_support","escort_airdrop",1,::killstreakcratethink);
	addcratetype("airdrop_support","emp",1,::killstreakcratethink);
	addcratetype("airdrop_escort","airdrop_trap",10,::trapcratethink);
	addcratetype("airdrop_escort","uav",8,::killstreakcratethink);
	addcratetype("airdrop_escort","counter_uav",8,::killstreakcratethink);
	addcratetype("airdrop_escort","deployable_vest",7,::killstreakcratethink);
	addcratetype("airdrop_escort","sentry",7,::killstreakcratethink);
	addcratetype("airdrop_escort","ims",7,::killstreakcratethink);
	addcratetype("airdrop_escort","sam_turret",6,::killstreakcratethink);
	addcratetype("airdrop_escort","stealth_airstrike",5,::killstreakcratethink);
	addcratetype("airdrop_escort","airdrop_juggernaut_recon",5,::juggernautcratethink);
	addcratetype("airdrop_escort","remote_uav",5,::killstreakcratethink);
	addcratetype("airdrop_escort","triple_uav",3,::killstreakcratethink);
	addcratetype("airdrop_escort","remote_mg_turret",3,::killstreakcratethink);
	addcratetype("airdrop_escort","emp",1,::killstreakcratethink);
	addcratetype("airdrop_trapcontents","ims",6,::trapnullfunc);
	addcratetype("airdrop_trapcontents","predator_missile",7,::trapnullfunc);
	addcratetype("airdrop_trapcontents","sentry",7,::trapnullfunc);
	addcratetype("airdrop_trapcontents","precision_airstrike",7,::trapnullfunc);
	addcratetype("airdrop_trapcontents","helicopter",8,::trapnullfunc);
	addcratetype("airdrop_trapcontents","littlebird_support",8,::trapnullfunc);
	addcratetype("airdrop_trapcontents","littlebird_flock",8,::trapnullfunc);
	addcratetype("airdrop_trapcontents","remote_mortar",9,::trapnullfunc);
	addcratetype("airdrop_trapcontents","remote_tank",9,::trapnullfunc);
	addcratetype("airdrop_trapcontents","helicopter_flares",10,::trapnullfunc);
	addcratetype("airdrop_trapcontents","ac130",10,::trapnullfunc);
	addcratetype("airdrop_trapcontents","airdrop_juggernaut",10,::trapnullfunc);
	addcratetype("airdrop_trapcontents","osprey_gunner",10,::trapnullfunc);
	addcratetype("airdrop_grnd","uav",25,::killstreakcratethink);
	addcratetype("airdrop_grnd","counter_uav",25,::killstreakcratethink);
	addcratetype("airdrop_grnd","deployable_vest",21,::killstreakcratethink);
	addcratetype("airdrop_grnd","sentry",21,::killstreakcratethink);
	addcratetype("airdrop_grnd","remote_mg_turret",17,::killstreakcratethink);
	addcratetype("airdrop_grnd","ims",17,::killstreakcratethink);
	addcratetype("airdrop_grnd","triple_uav",13,::killstreakcratethink);
	addcratetype("airdrop_grnd","predator_missile",13,::killstreakcratethink);
	addcratetype("airdrop_grnd","airdrop_trap",11,::trapcratethink);
	addcratetype("airdrop_grnd","precision_airstrike",9,::killstreakcratethink);
	addcratetype("airdrop_grnd","stealth_airstrike",9,::killstreakcratethink);
	addcratetype("airdrop_grnd","helicopter",9,::killstreakcratethink);
	addcratetype("airdrop_grnd","remote_tank",7,::killstreakcratethink);
	addcratetype("airdrop_grnd","sam_turret",7,::killstreakcratethink);
	addcratetype("airdrop_grnd","remote_uav",7,::killstreakcratethink);
	addcratetype("airdrop_grnd","littlebird_support",4,::killstreakcratethink);
	addcratetype("airdrop_grnd","airdrop_juggernaut_recon",4,::juggernautcratethink);
	addcratetype("airdrop_grnd","littlebird_flock",2,::killstreakcratethink);
	addcratetype("airdrop_grnd","helicopter_flares",2,::killstreakcratethink);
	addcratetype("airdrop_grnd","remote_mortar",2,::killstreakcratethink);
	addcratetype("airdrop_grnd","ac130",2,::killstreakcratethink);
	addcratetype("airdrop_grnd","airdrop_juggernaut",1,::juggernautcratethink);
	addcratetype("airdrop_grnd","osprey_gunner",1,::killstreakcratethink);
	addcratetype("airdrop_grnd","emp",1,::killstreakcratethink);
	addcratetype("airdrop_sentry_minigun","sentry",100,::killstreakcratethink);
	addcratetype("airdrop_juggernaut","airdrop_juggernaut",100,::juggernautcratethink);
	addcratetype("airdrop_juggernaut_recon","airdrop_juggernaut_recon",100,::juggernautcratethink);
	addcratetype("airdrop_trophy","airdrop_trophy",100,::trophycratethink);
	addcratetype("airdrop_trap","airdrop_trap",100,::trapcratethink);
	addcratetype("littlebird_support","littlebird_support",100,::killstreakcratethink);
	addcratetype("airdrop_remote_tank","remote_tank",100,::killstreakcratethink);
	foreach(var_0A, var_06 in level.cratetypes)
	{
		level.cratemaxval[var_0A] = 0;
		foreach(var_09, var_08 in level.cratetypes[var_0A])
		{
			if(!var_08)
			{
				continue;
			}

			level.cratemaxval[var_0A] = level.cratemaxval[var_0A] + var_08;
			level.cratetypes[var_0A][var_09] = level.cratemaxval[var_0A];
		}
	}

	var_0B = getentarray("mp_tdm_spawn","classname");
	var_0C = undefined;
	foreach(var_0E in var_0B)
	{
		if(!isdefined(var_0C) || var_0E.origin[2] < var_0C.origin[2])
		{
			var_0C = var_0E;
		}
	}

	level.lowspawn = var_0C;
}

//Function Number: 2
addcratetype(param_00,param_01,param_02,param_03)
{
	level.cratetypes[param_00][param_01] = param_02;
	level.cratefuncs[param_00][param_01] = param_03;
}

//Function Number: 3
getrandomcratetype(param_00)
{
	var_01 = randomint(level.cratemaxval[param_00]);
	if(isdefined(self.owner) && self.owner maps\mp\_utility::_hasperk("specialty_luckycharm"))
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	var_03 = undefined;
	foreach(var_06, var_05 in level.cratetypes[param_00])
	{
		if(!var_05)
		{
			continue;
		}

		var_03 = var_06;
		if(var_05 > var_01)
		{
			if(var_02)
			{
				var_02 = 0;
				continue;
			}

			break;
		}
	}

	return var_03;
}

//Function Number: 4
getcratetypefordroptype(param_00)
{
	switch(param_00)
	{
		case "airdrop_sentry_minigun":
			return "sentry";

		case "airdrop_predator_missile":
			return "predator_missile";

		case "airdrop_juggernaut":
			return "airdrop_juggernaut";

		case "airdrop_juggernaut_def":
			return "airdrop_juggernaut_def";

		case "airdrop_juggernaut_gl":
			return "airdrop_juggernaut_gl";

		case "airdrop_juggernaut_recon":
			return "airdrop_juggernaut_recon";

		case "airdrop_trap":
			return "airdrop_trap";

		case "airdrop_trophy":
			return "airdrop_trophy";

		case "airdrop_remote_tank":
			return "remote_tank";

		case "airdrop_grnd_mega":
		case "airdrop_grnd":
		case "airdrop_support":
		case "airdrop_escort":
		case "airdrop_mega":
		case "airdrop_assault":
		default:
			return getrandomcratetype(param_00);
	}
}

//Function Number: 5
drawline(param_00,param_01,param_02)
{
	var_03 = int(param_02 * 20);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 6
tryuseassaultairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_assault");
}

//Function Number: 7
tryusesupportairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_support");
}

//Function Number: 8
tryuseairdroppredatormissile(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_predator_missile");
}

//Function Number: 9
tryuseairdropsentryminigun(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_sentry_minigun");
}

//Function Number: 10
tryusejuggernautairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_juggernaut");
}

//Function Number: 11
tryusejuggernautglairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_juggernaut_gl");
}

//Function Number: 12
tryusejuggernautreconairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_juggernaut_recon");
}

//Function Number: 13
tryusejuggernautdefairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_juggernaut_def");
}

//Function Number: 14
tryusetrophyairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_trophy");
}

//Function Number: 15
tryusemegaairdrop(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_mega");
}

//Function Number: 16
tryuseairdroptrap(param_00,param_01)
{
	if(tryuseairdrop(param_00,param_01,"airdrop_trap"))
	{
		if(level.teambased)
		{
			thread maps\mp\_utility::leaderdialog(level.otherteam[self.team] + "_enemy_airdrop_assault_inbound",level.otherteam[self.team]);
		}
		else
		{
			var_02[0] = self;
			thread maps\mp\_utility::leaderdialog(level.otherteam[self.team] + "_enemy_airdrop_assault_inbound",undefined,undefined,var_02);
		}

		return 1;
	}

	return 0;
}

//Function Number: 17
tryuseairdropremotetank(param_00,param_01)
{
	return tryuseairdrop(param_00,param_01,"airdrop_remote_tank");
}

//Function Number: 18
tryuseammo(param_00)
{
	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	refillammo(1);
	return 1;
}

//Function Number: 19
tryuseexplosiveammo(param_00)
{
	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	refillammo(0);
	maps\mp\_utility::giveperk("specialty_explosivebullets",0);
	return 1;
}

//Function Number: 20
tryuselightarmor(param_00)
{
	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	thread maps\mp\perks\_perkfunctions::givelightarmor();
	return 1;
}

//Function Number: 21
tryuseairdrop(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = "airdrop_assault";
	}

	var_04 = 1;
	if((level.littlebirds.size >= 4 || level.fauxvehiclecount >= 4) && param_02 != "airdrop_mega" && !issubstr(tolower(param_02),"juggernaut"))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_04 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}
	else if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}
	else if(!maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	if(param_02 != "airdrop_mega" && !issubstr(tolower(param_02),"juggernaut"))
	{
		thread watchdisconnect();
	}

	if(!issubstr(param_02,"juggernaut"))
	{
		maps\mp\_utility::incrementfauxvehiclecount();
	}

	var_03 = beginairdropviamarker(param_00,param_01,param_02);
	if(!isdefined(var_03) || !var_03)
	{
		self notify("markerDetermined");
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(param_02 == "airdrop_mega")
	{
		thread maps\mp\_utility::teamplayercardsplash("used_airdrop_mega",self);
	}

	self notify("markerDetermined");
	maps\mp\_matchdata::logkillstreakevent(param_02,self.origin);
	return 1;
}

//Function Number: 22
watchdisconnect()
{
	self endon("markerDetermined");
	self waittill("disconnect");
}

//Function Number: 23
beginairdropviamarker(param_00,param_01,param_02)
{
	self notify("beginAirdropViaMarker");
	self endon("beginAirdropViaMarker");
	self endon("disconnect");
	level endon("game_ended");
	self.threwairdropmarker = undefined;
	thread watchairdropweaponchange(param_00,param_01,param_02);
	thread watchairdropmarkerusage(param_00,param_01,param_02);
	thread watchairdropmarker(param_00,param_01,param_02);
	var_03 = common_scripts\utility::waittill_any_return("notAirDropWeapon","markerDetermined");
	if(isdefined(var_03) && var_03 == "markerDetermined")
	{
		return 1;
	}
	else if(!isdefined(var_03) && isdefined(self.threwairdropmarker))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
watchairdropweaponchange(param_00,param_01,param_02)
{
	level endon("game_ended");
	self notify("watchAirDropWeaponChange");
	self endon("watchAirDropWeaponChange");
	self endon("disconnect");
	self endon("markerDetermined");
	while(maps\mp\_utility::ischangingweapon())
	{
		wait 0.05;
	}

	var_03 = self getcurrentweapon();
	if(isairdropmarker(var_03))
	{
		var_04 = var_03;
	}
	else
	{
		var_04 = undefined;
	}

	while(isairdropmarker(var_03))
	{
		self waittill("weapon_change",var_03);
		if(isairdropmarker(var_03))
		{
			var_04 = var_03;
		}
	}

	if(isdefined(self.threwairdropmarker))
	{
		var_05 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname);
		self takeweapon(var_05);
		self notify("markerDetermined");
		return;
	}

	self notify("notAirDropWeapon");
}

//Function Number: 25
watchairdropmarkerusage(param_00,param_01,param_02)
{
	level endon("game_ended");
	self notify("watchAirDropMarkerUsage");
	self endon("watchAirDropMarkerUsage");
	self endon("disconnect");
	self endon("markerDetermined");
	for(;;)
	{
		self waittill("grenade_pullback",var_03);
		if(!isairdropmarker(var_03))
		{
			continue;
		}

		common_scripts\utility::_disableusability();
		beginairdropmarkertracking();
	}
}

//Function Number: 26
watchairdropmarker(param_00,param_01,param_02)
{
	level endon("game_ended");
	self notify("watchAirDropMarker");
	self endon("watchAirDropMarker");
	self endon("disconnect");
	self endon("markerDetermined");
	for(;;)
	{
		self waittill("grenade_fire",var_03,var_04);
		if(!isairdropmarker(var_04))
		{
			continue;
		}

		self.threwairdropmarker = 1;
		var_03 thread airdropdetonateonstuck();
		var_03.owner = self;
		var_03.weaponname = var_04;
		var_03 thread airdropmarkeractivate(param_02);
	}
}

//Function Number: 27
beginairdropmarkertracking()
{
	level endon("game_ended");
	self notify("beginAirDropMarkerTracking");
	self endon("beginAirDropMarkerTracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change");
	common_scripts\utility::_enableusability();
}

//Function Number: 28
airdropmarkeractivate(param_00,param_01)
{
	level endon("game_ended");
	self notify("airDropMarkerActivate");
	self endon("airDropMarkerActivate");
	self waittill("explode",var_02);
	var_03 = self.owner;
	if(!isdefined(var_03))
	{
		return;
	}

	if(var_03 maps\mp\_utility::isemped())
	{
		return;
	}

	if(var_03 maps\mp\_utility::isairdenied())
	{
		return;
	}

	if(issubstr(tolower(param_00),"escort_airdrop") && isdefined(level.chopper))
	{
		return;
	}

	wait 0.05;
	if(issubstr(tolower(param_00),"juggernaut"))
	{
		level doc130flyby(var_03,var_02,randomfloat(360),param_00);
		return;
	}

	if(issubstr(tolower(param_00),"escort_airdrop"))
	{
		var_03 maps\mp\killstreaks\_escortairdrop::finishsupportescortusage(param_01,var_02,randomfloat(360),"escort_airdrop");
		return;
	}

	level doflyby(var_03,var_02,randomfloat(360),param_00);
}

//Function Number: 29
initairdropcrate()
{
	self.inuse = 0;
	self hide();
	if(isdefined(self.target))
	{
		self.collision = getent(self.target,"targetname");
		self.collision notsolid();
		return;
	}

	self.collision = undefined;
}

//Function Number: 30
deleteonownerdeath(param_00)
{
	wait 0.25;
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 31
crateteammodelupdater()
{
	self endon("death");
	self hide();
	foreach(var_01 in level.players)
	{
		if(var_01.team != "spectator")
		{
			self showtoplayer(var_01);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_01 in level.players)
		{
			if(var_01.team != "spectator")
			{
				self showtoplayer(var_01);
			}
		}
	}
}

//Function Number: 32
cratemodelteamupdater(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00)
		{
			self showtoplayer(var_02);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_02 in level.players)
		{
			if(var_02.team == param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 33
cratemodelplayerupdater(param_00,param_01)
{
	self endon("death");
	self hide();
	foreach(var_03 in level.players)
	{
		if(param_01 && isdefined(param_00) && var_03 != param_00)
		{
			continue;
		}

		if(!param_01 && isdefined(param_00) && var_03 == param_00)
		{
			continue;
		}

		self showtoplayer(var_03);
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_03 in level.players)
		{
			if(param_01 && isdefined(param_00) && var_03 != param_00)
			{
				continue;
			}

			if(!param_01 && isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoplayer(var_03);
		}
	}
}

//Function Number: 34
crateuseteamupdater(param_00)
{
	self endon("death");
	for(;;)
	{
		setusablebyteam(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 35
crateusejuggernautupdater()
{
	if(!issubstr(self.cratetype,"juggernaut"))
	{
		return;
	}

	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		self disableplayeruse(var_00);
		thread crateusepostjuggernautupdater(var_00);
	}
}

//Function Number: 36
crateusepostjuggernautupdater(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 37
createairdropcrate(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_03);
	var_04.curprogress = 0;
	var_04.usetime = 0;
	var_04.userate = 0;
	var_04.team = self.team;
	if(isdefined(param_00))
	{
		var_04.owner = param_00;
	}
	else
	{
		var_04.owner = undefined;
	}

	var_04.cratetype = param_02;
	var_04.droptype = param_01;
	var_04.targetname = "care_package";
	var_04 setmodel(maps\mp\gametypes\_teams::getteamcratemodel(var_04.team));
	var_04 thread crateteammodelupdater();
	var_05 = "com_plasticcase_friendly";
	if(param_02 == "airdrop_trap")
	{
		var_05 = "com_plasticcase_trap_friendly";
		var_04 thread trap_createbombsquadmodel();
	}

	var_04.friendlymodel = spawn("script_model",param_03);
	var_04.friendlymodel setmodel(var_05);
	var_04.enemymodel = spawn("script_model",param_03);
	var_04.enemymodel setmodel("com_plasticcase_enemy");
	var_04.friendlymodel thread deleteonownerdeath(var_04);
	if(level.teambased)
	{
		var_04.friendlymodel thread cratemodelteamupdater(var_04.team);
	}
	else
	{
		var_04.friendlymodel thread cratemodelplayerupdater(param_00,1);
	}

	var_04.enemymodel thread deleteonownerdeath(var_04);
	if(level.teambased)
	{
		var_04.enemymodel thread cratemodelteamupdater(level.otherteam[var_04.team]);
	}
	else
	{
		var_04.enemymodel thread cratemodelplayerupdater(param_00,0);
	}

	var_04.inuse = 0;
	var_04 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	var_04.killcament = spawn("script_model",var_04.origin + (0,0,300));
	var_04.killcament setscriptmoverkillcam("explosive");
	var_04.killcament linkto(var_04);
	level.numdropcrates++;
	var_04 thread dropcrateexistence();
	return var_04;
}

//Function Number: 38
dropcrateexistence()
{
	level endon("game_ended");
	self waittill("death");
	level.numdropcrates--;
}

//Function Number: 39
trap_createbombsquadmodel()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 hide();
	var_01 = level.otherteam[self.team];
	var_00 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(var_01,self.owner);
	var_00 setmodel("com_plasticcase_trap_bombsquad");
	var_00 linkto(self);
	var_00 setcontents(0);
	self waittill("death");
	var_00 delete();
}

//Function Number: 40
cratesetupforuse(param_00,param_01,param_02)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(param_00);
	self makeusable();
	self.mode = param_01;
	if(level.teambased || isdefined(self.owner))
	{
		var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_03,"invisible",(0,0,0));
		objective_position(var_03,self.origin);
		objective_state(var_03,"active");
		var_04 = "compass_objpoint_ammo_friendly";
		if(param_01 == "trap")
		{
			var_04 = "compass_objpoint_trap_friendly";
		}

		objective_icon(var_03,var_04);
		if(!level.teambased && isdefined(self.owner))
		{
			objective_playerteam(var_03,self.owner getentitynumber());
		}
		else
		{
			objective_team(var_03,self.team);
		}

		self.objidfriendly = var_03;
	}

	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",(0,0,0));
	objective_position(var_03,self.origin);
	objective_state(var_03,"active");
	objective_icon(var_03,"compass_objpoint_ammo_enemy");
	if(!level.teambased && isdefined(self.owner))
	{
		objective_playerenemyteam(var_03,self.owner getentitynumber());
	}
	else
	{
		objective_team(var_03,level.otherteam[self.team]);
	}

	self.objidenemy = var_03;
	if(param_01 == "trap")
	{
		thread crateuseteamupdater(maps\mp\_utility::getotherteam(self.team));
	}
	else
	{
		thread crateuseteamupdater();
		if(issubstr(self.cratetype,"juggernaut"))
		{
			foreach(var_06 in level.players)
			{
				if(var_06 maps\mp\_utility::isjuggernaut())
				{
					thread crateusepostjuggernautupdater(var_06);
				}
			}
		}

		if(level.teambased)
		{
			maps\mp\_entityheadicons::setheadicon(self.team,param_02,(0,0,24),14,14,undefined,undefined,undefined,undefined,undefined,0);
		}
		else if(isdefined(self.owner))
		{
			maps\mp\_entityheadicons::setheadicon(self.owner,param_02,(0,0,24),14,14,undefined,undefined,undefined,undefined,undefined,0);
		}
	}

	thread crateusejuggernautupdater();
}

//Function Number: 41
setusablebyteam(param_00)
{
	foreach(var_02 in level.players)
	{
		if(issubstr(self.cratetype,"juggernaut") && var_02 maps\mp\_utility::isjuggernaut())
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(!level.teambased && self.mode == "trap")
		{
			if(isdefined(self.owner) && var_02 == self.owner)
			{
				self disableplayeruse(var_02);
			}
			else
			{
				self enableplayeruse(var_02);
			}

			continue;
		}

		if(!isdefined(param_00) || param_00 == var_02.team)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 42
dropthecrate(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = [];
	self.owner endon("disconnect");
	if(!isdefined(param_04))
	{
		if(isdefined(param_07))
		{
			var_0A = undefined;
			var_0B = undefined;
			for(var_0C = 0;var_0C < 100;var_0C++)
			{
				var_0B = getcratetypefordroptype(param_01);
				var_0A = 0;
				for(var_0D = 0;var_0D < param_07.size;var_0D++)
				{
					if(var_0B == param_07[var_0D])
					{
						var_0A = 1;
						break;
					}
				}

				if(var_0A == 0)
				{
					break;
				}
			}

			if(var_0A == 1)
			{
				var_0B = getcratetypefordroptype(param_01);
			}
		}
		else
		{
			var_0B = getcratetypefordroptype(param_02);
		}
	}
	else
	{
		var_0B = param_05;
	}

	if(!isdefined(param_06))
	{
		param_06 = (randomint(5),randomint(5),randomint(5));
	}

	var_09 = createairdropcrate(self.owner,param_01,var_0B,param_05);
	switch(param_01)
	{
		case "nuke_drop":
		case "airdrop_mega":
		case "airdrop_juggernaut_recon":
		case "airdrop_juggernaut":
			var_09 linkto(self,"tag_ground",(64,32,-128),(0,0,0));
			break;

		case "airdrop_osprey_gunner":
		case "airdrop_escort":
			var_09 linkto(self,param_08,(0,0,0),(0,0,0));
			break;

		default:
			var_09 linkto(self,"tag_ground",(32,0,5),(0,0,0));
			break;
	}

	var_09.angles = (0,0,0);
	var_09 show();
	var_0E = self.veh_speed;
	thread waitfordropcratemsg(var_09,param_06,param_01,var_0B);
	return var_0B;
}

//Function Number: 43
waitfordropcratemsg(param_00,param_01,param_02,param_03)
{
	self waittill("drop_crate");
	param_00 unlink();
	param_00 physicslaunchserver((0,0,0),param_01);
	param_00 thread physicswaiter(param_02,param_03);
	if(isdefined(param_00.killcament))
	{
		param_00.killcament unlink();
		var_04 = bullettrace(param_00.origin,param_00.origin + (0,0,-10000),0,param_00);
		var_05 = distance(param_00.origin,var_04["position"]);
		var_06 = var_05 / 800;
		param_00.killcament moveto(var_04["position"] + (0,0,300),var_06);
	}
}

//Function Number: 44
physicswaiter(param_00,param_01)
{
	self waittill("physics_finished");
	self thread [[ level.cratefuncs[param_00][param_01] ]](param_00);
	level thread droptimeout(self,self.owner,param_01);
	if(abs(self.origin[2] - level.lowspawn.origin[2]) > 3000)
	{
		deletecrate();
	}
}

//Function Number: 45
droptimeout(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("death");
	if(param_00.droptype == "nuke_drop")
	{
		return;
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(90);
	while(param_00.curprogress != 0)
	{
		wait 1;
	}

	param_00 deletecrate();
}

//Function Number: 46
getpathstart(param_00,param_01)
{
	var_02 = 100;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 47
getpathend(param_00,param_01)
{
	var_02 = 150;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04 + (0,90,0)) * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 48
getflyheightoffset(param_00)
{
	var_01 = 850;
	var_02 = getent("airstrikeheight","targetname");
	if(!isdefined(var_02))
	{
		if(isdefined(level.airstrikeheightscale))
		{
			if(level.airstrikeheightscale > 2)
			{
				var_01 = 1500;
				return var_01 * level.airstrikeheightscale;
			}

			return var_01 * level.airstrikeheightscale + 256 + param_00[2];
		}

		return var_01 + param_00[2];
	}

	return var_02.origin[2];
}

//Function Number: 49
doflyby(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_06 = getflyheightoffset(param_01);
	if(isdefined(param_04))
	{
		var_06 = var_06 + param_04;
	}

	foreach(var_08 in level.littlebirds)
	{
		if(isdefined(var_08.droptype))
		{
			var_06 = var_06 + 128;
		}
	}

	var_0A = param_01 * (1,1,0) + (0,0,var_06);
	var_0B = getpathstart(var_0A,param_02);
	var_0C = getpathend(var_0A,param_02);
	var_0A = var_0A + anglestoforward((0,param_02,0)) * -50;
	var_0D = helisetup(param_00,var_0B,var_0A);
	var_0D endon("death");
	if(!isdefined(param_05))
	{
		param_05 = undefined;
	}

	var_0D.droptype = param_03;
	var_0D setvehgoalpos(var_0A,1);
	var_0D thread dropthecrate(param_01,param_03,var_06,0,param_05,var_0B);
	wait 2;
	var_0D vehicle_setspeed(75,40);
	var_0D setyawspeed(180,180,180,0.3);
	var_0D waittill("goal");
	wait 0.1;
	var_0D notify("drop_crate");
	var_0D setvehgoalpos(var_0C,1);
	var_0D vehicle_setspeed(300,75);
	var_0D.leaving = 1;
	var_0D waittill("goal");
	var_0D notify("leaving");
	var_0D notify("delete");
	maps\mp\_utility::decrementfauxvehiclecount();
	var_0D delete();
}

//Function Number: 50
domegaflyby(param_00,param_01,param_02,param_03)
{
	level thread doflyby(param_00,param_01,param_02,param_03,0);
	wait randomintrange(1,2);
	level thread doflyby(param_00,param_01 + (128,128,0),param_02,param_03,128);
	wait randomintrange(1,2);
	level thread doflyby(param_00,param_01 + (172,256,0),param_02,param_03,256);
	wait randomintrange(1,2);
	level thread doflyby(param_00,param_01 + (64,0,0),param_02,param_03,0);
}

//Function Number: 51
doc130flyby(param_00,param_01,param_02,param_03)
{
	var_04 = 18000;
	var_05 = 3000;
	var_06 = vectortoyaw(param_01 - param_00.origin);
	var_07 = (0,var_06,0);
	var_08 = getflyheightoffset(param_01);
	var_09 = param_01 + anglestoforward(var_07) * -1 * var_04;
	var_09 = var_09 * (1,1,0) + (0,0,var_08);
	var_0A = param_01 + anglestoforward(var_07) * var_04;
	var_0A = var_0A * (1,1,0) + (0,0,var_08);
	var_0B = length(var_09 - var_0A);
	var_0C = var_0B / var_05;
	var_0D = c130setup(param_00,var_09,var_0A);
	var_0D.veh_speed = var_05;
	var_0D.droptype = param_03;
	var_0D playloopsound("veh_ac130_dist_loop");
	var_0D.angles = var_07;
	var_0E = anglestoforward(var_07);
	var_0D moveto(var_0A,var_0C,0,0);
	var_0F = distance2d(var_0D.origin,param_01);
	var_10 = 0;
	for(;;)
	{
		var_11 = distance2d(var_0D.origin,param_01);
		if(var_11 < var_0F)
		{
			var_0F = var_11;
		}
		else if(var_11 > var_0F)
		{
			break;
		}

		if(var_11 < 320)
		{
			break;
		}
		else if(var_11 < 768)
		{
			earthquake(0.15,1.5,param_01,1500);
			if(!var_10)
			{
				var_0D playsound("veh_ac130_sonic_boom");
				var_10 = 1;
			}
		}

		wait 0.05;
	}

	wait 0.05;
	var_12 = (0.25,0,0);
	var_13[0] = var_0D thread dropthecrate(param_01,param_03,var_08,0,undefined,var_09,var_12);
	wait 0.05;
	var_0D notify("drop_crate");
	var_14 = param_01 + anglestoforward(var_07) * var_04 * 1.5;
	var_0D moveto(var_14,var_0C / 2,0,0);
	wait 6;
	var_0D delete();
}

//Function Number: 52
domegac130flyby(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 24000;
	var_06 = 2000;
	var_07 = vectortoyaw(param_01 - param_00.origin);
	var_08 = (0,var_07,0);
	var_09 = anglestoforward(var_08);
	if(isdefined(param_04))
	{
		param_01 = param_01 + var_09 * param_04;
	}

	var_0A = getflyheightoffset(param_01);
	var_0B = param_01 + anglestoforward(var_08) * -1 * var_05;
	var_0B = var_0B * (1,1,0) + (0,0,var_0A);
	var_0C = param_01 + anglestoforward(var_08) * var_05;
	var_0C = var_0C * (1,1,0) + (0,0,var_0A);
	var_0D = length(var_0B - var_0C);
	var_0E = var_0D / var_06;
	var_0F = c130setup(param_00,var_0B,var_0C);
	var_0F.veh_speed = var_06;
	var_0F.droptype = param_03;
	var_0F playloopsound("veh_ac130_dist_loop");
	var_0F.angles = var_08;
	var_09 = anglestoforward(var_08);
	var_0F moveto(var_0C,var_0E,0,0);
	var_10 = distance2d(var_0F.origin,param_01);
	var_11 = 0;
	for(;;)
	{
		var_12 = distance2d(var_0F.origin,param_01);
		if(var_12 < var_10)
		{
			var_10 = var_12;
		}
		else if(var_12 > var_10)
		{
			break;
		}

		if(var_12 < 256)
		{
			break;
		}
		else if(var_12 < 768)
		{
			earthquake(0.15,1.5,param_01,1500);
			if(!var_11)
			{
				var_0F playsound("veh_ac130_sonic_boom");
				var_11 = 1;
			}
		}

		wait 0.05;
	}

	wait 0.05;
	var_13[0] = var_0F thread dropthecrate(param_01,param_03,var_0A,0,undefined,var_0B);
	wait 0.05;
	var_0F notify("drop_crate");
	wait 0.05;
	wait 0.05;
	var_10 notify("drop_crate",var_7B[1],var_0F thread dropthecrate(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13));
	wait 0.05;
	wait 0.05;
	var_10 notify("drop_crate",var_7B[2],var_10 thread dropthecrate(param_02,param_04,var_0B,0,undefined,var_0C,undefined,var_7B));
	wait 0.05;
	wait 0.05;
	var_10 notify("drop_crate",var_7B[3],var_10 thread dropthecrate(param_02,param_04,var_0B,0,undefined,var_0C,undefined,var_7B));
	wait 4;
	var_10 delete();
}

//Function Number: 53
dropnuke(param_00,param_01,param_02)
{
	var_03 = 24000;
	var_04 = 2000;
	var_05 = randomint(360);
	var_06 = (0,var_05,0);
	var_07 = getflyheightoffset(param_00);
	var_08 = param_00 + anglestoforward(var_06) * -1 * var_03;
	var_08 = var_08 * (1,1,0) + (0,0,var_07);
	var_09 = param_00 + anglestoforward(var_06) * var_03;
	var_09 = var_09 * (1,1,0) + (0,0,var_07);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / var_04;
	var_0C = c130setup(param_01,var_08,var_09);
	var_0C.veh_speed = var_04;
	var_0C.droptype = param_02;
	var_0C playloopsound("veh_ac130_dist_loop");
	var_0C.angles = var_06;
	var_0D = anglestoforward(var_06);
	var_0C moveto(var_09,var_0B,0,0);
	var_0E = 0;
	var_0F = distance2d(var_0C.origin,param_00);
	for(;;)
	{
		var_10 = distance2d(var_0C.origin,param_00);
		if(var_10 < var_0F)
		{
			var_0F = var_10;
		}
		else if(var_10 > var_0F)
		{
			break;
		}

		if(var_10 < 256)
		{
			break;
		}
		else if(var_10 < 768)
		{
			earthquake(0.15,1.5,param_00,1500);
			if(!var_0E)
			{
				var_0C playsound("veh_ac130_sonic_boom");
				var_0E = 1;
			}
		}

		wait 0.05;
	}

	var_0C thread dropthecrate(param_00,param_02,var_07,0,"nuke",var_08);
	wait 0.05;
	var_0C notify("drop_crate");
	wait 4;
	var_0C delete();
}

//Function Number: 54
stoploopafter(param_00)
{
	self endon("death");
	wait param_00;
	self stoploopsound();
}

//Function Number: 55
playlooponent(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01 hide();
	var_01 endon("death");
	thread common_scripts\utility::delete_on_death(var_01);
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	var_01 linkto(self);
	var_01 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_01 stoploopsound(param_00);
	var_01 delete();
}

//Function Number: 56
c130setup(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = spawnplane(param_00,"script_model",param_01,"compass_objpoint_c130_friendly","compass_objpoint_c130_enemy");
	var_04 setmodel("vehicle_ac130_low_mp");
	if(!isdefined(var_04))
	{
		return;
	}

	var_04.owner = param_00;
	var_04.team = param_00.team;
	level.c130 = var_04;
	return var_04;
}

//Function Number: 57
helisetup(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = spawnhelicopter(param_00,param_01,var_03,"littlebird_mp","vehicle_little_bird_armed");
	if(!isdefined(var_04))
	{
		return;
	}

	var_04 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_04 thread maps\mp\killstreaks\_helicopter::removefromlittlebirdlistondeath();
	var_04.health = 999999;
	var_04.maxhealth = 500;
	var_04.damagetaken = 0;
	var_04 setcandamage(1);
	var_04.owner = param_00;
	var_04.team = param_00.team;
	var_04.isairdrop = 1;
	var_04 thread watchtimeout();
	var_04 thread heli_existence();
	var_04 thread helidestroyed();
	var_04 thread heli_handledamage();
	var_04 setmaxpitchroll(45,85);
	var_04 vehicle_setspeed(250,175);
	var_04.helitype = "airdrop";
	var_04.specialdamagecallback = ::callback_vehicledamage;
	return var_04;
}

//Function Number: 58
watchtimeout()
{
	level endon("game_ended");
	self endon("leaving");
	self endon("helicopter_gone");
	self endon("death");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(25);
	self notify("death");
}

//Function Number: 59
heli_existence()
{
	common_scripts\utility::waittill_any("crashing","leaving");
	self notify("helicopter_gone");
}

//Function Number: 60
heli_handledamage()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.specialdamagecallback))
		{
			self [[ self.specialdamagecallback ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 61
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.alreadydead) && self.alreadydead)
	{
		return;
	}

	if(!isdefined(param_01) || param_01 == self)
	{
		return;
	}

	if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,param_01))
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	var_0C = param_02;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("helicopter");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0C = var_0C + param_02 * level.armorpiercingmod;
			}
		}
	}

	if(isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		param_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("helicopter");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "javelin_mp":
			case "stinger_mp":
			case "remote_mortar_missile_mp":
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				self.var_30C8 = 1;
				var_0C = self.maxhealth + 1;
				break;

			case "sam_projectile_mp":
				self.var_30C8 = 1;
				var_0C = self.maxhealth * 0.5;
				break;

			case "emp_grenade_mp":
				self.var_30C8 = 0;
				var_0C = self.maxhealth + 1;
				break;
		}
	}

	self.damagetaken = self.damagetaken + var_0C;
	if(self.damagetaken >= self.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(self.owner) || param_01 != self.owner)
		{
			self.alreadydead = 1;
			param_01 notify("destroyed_helicopter");
			param_01 notify("destroyed_killstreak",param_05);
			thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter",param_01);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("kill",300,param_05,param_04);
			param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DESTROYED_HELICOPTER");
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,param_01,param_02,param_04,param_05);
		}

		self notify("death");
	}
}

//Function Number: 62
helidestroyed()
{
	self endon("leaving");
	self endon("helicopter_gone");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self vehicle_setspeed(25,5);
	thread lbspin(randomintrange(180,220));
	wait randomfloatrange(0.5,1.5);
	self notify("drop_crate");
	lbexplode();
}

//Function Number: 63
lbexplode()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	playfx(level.chopper_fx["explode"]["death"]["cobra"],self.origin,var_00);
	self playsound("cobra_helicopter_crash");
	self notify("explode");
	self delete();
}

//Function Number: 64
lbspin(param_00)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"],self,"tail_rotor_jnt");
	playfxontag(level.chopper_fx["fire"]["trail"]["medium"],self,"tail_rotor_jnt");
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait 1;
	}
}

//Function Number: 65
nukecapturethink()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(!var_00 isonground())
		{
			continue;
		}

		if(!useholdthink(var_00))
		{
			continue;
		}

		self notify("captured",var_00);
	}
}

//Function Number: 66
crateothercapturethink(param_00)
{
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(self.owner) && var_01 == self.owner)
		{
			continue;
		}

		if(!validateopenconditions(var_01))
		{
			continue;
		}

		var_01.iscapturingcrate = 1;
		var_02 = createuseent();
		var_03 = var_02 useholdthink(var_01,undefined,param_00);
		if(isdefined(var_02))
		{
			var_02 delete();
		}

		if(!var_03)
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 67
crateownercapturethink(param_00)
{
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			continue;
		}

		if(!validateopenconditions(var_01))
		{
			continue;
		}

		var_01.iscapturingcrate = 1;
		if(!useholdthink(var_01,500,param_00))
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 68
validateopenconditions(param_00)
{
	if((self.cratetype == "airdrop_juggernaut_def" || self.cratetype == "airdrop_juggernaut") && param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(maps\mp\_utility::iskillstreakweapon(var_01) && !issubstr(var_01,"jugg_mp"))
	{
		return 0;
	}

	if(isdefined(param_00.changingweapon) && maps\mp\_utility::iskillstreakweapon(param_00.changingweapon) && !issubstr(param_00.changingweapon,"jugg_mp"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 69
killstreakcratethink(param_00)
{
	self endon("death");
	if(isdefined(game["strings"][self.cratetype + "_hint"]))
	{
		var_01 = game["strings"][self.cratetype + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	cratesetupforuse(var_01,"all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_02);
		if(isdefined(self.owner) && var_02 != self.owner)
		{
			if(!level.teambased || var_02.team != self.team)
			{
				switch(param_00)
				{
					case "airdrop_support":
					case "airdrop_osprey_gunner":
					case "airdrop_escort":
					case "airdrop_assault":
						var_02 thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
						var_02 thread hijacknotify(self,"airdrop");
						break;
	
					case "airdrop_sentry_minigun":
						var_02 thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
						var_02 thread hijacknotify(self,"sentry");
						break;
	
					case "airdrop_remote_tank":
						var_02 thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
						var_02 thread hijacknotify(self,"remote_tank");
						break;
	
					case "airdrop_mega":
						var_02 thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop_mega");
						var_02 thread hijacknotify(self,"emergency_airdrop");
						break;
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::getstreakcost(self.cratetype) / 10 * 50));
				self.owner thread maps\mp\gametypes\_hud_message::splashnotifydelayed("sharepackage",int(maps\mp\killstreaks\_killstreaks::getstreakcost(self.cratetype) / 10 * 50));
			}
		}

		var_02 playlocalsound("ammo_crate_use");
		var_02 thread maps\mp\killstreaks\_killstreaks::givekillstreak(self.cratetype,0,0,self.owner);
		deletecrate();
	}
}

//Function Number: 70
nukecratethink(param_00)
{
	self endon("death");
	cratesetupforuse(&"PLATFORM_CALL_NUKE","nukeDrop",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread nukecapturethink();
	for(;;)
	{
		self waittill("captured",var_01);
		var_01 thread [[ level.killstreakfuncs[self.cratetype] ]](level.gtnw);
		level notify("nukeCaptured",var_01);
		if(isdefined(level.gtnw) && level.gtnw)
		{
			var_01.capturednuke = 1;
		}

		var_01 playlocalsound("ammo_crate_use");
		deletecrate();
	}
}

//Function Number: 71
trophycratethink(param_00)
{
	self endon("death");
	cratesetupforuse(game["strings"]["trophy_hint"],"all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				var_01 thread hijacknotify(self,"trophy");
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::getstreakcost("airdrop_trophy") / 10) * 50);
				self.owner maps\mp\gametypes\_hud_message::playercardsplashnotify("giveaway_trophy",var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_01 thread givelocaltrophy(param_00);
		deletecrate();
	}
}

//Function Number: 72
juggernautcratethink(param_00)
{
	self endon("death");
	cratesetupforuse(game["strings"]["juggernaut_hint"],"all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				var_01 thread hijacknotify(self,"juggernaut");
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::getstreakcost(self.cratetype) / 10) * 50);
				self.owner maps\mp\gametypes\_hud_message::playercardsplashnotify("giveaway_juggernaut",var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_02 = "juggernaut";
		switch(self.cratetype)
		{
			case "airdrop_juggernaut":
				var_02 = "juggernaut";
				break;
	
			case "airdrop_juggernaut_recon":
				var_02 = "juggernaut_recon";
				break;
		}

		var_01 thread maps\mp\killstreaks\_juggernaut::givejuggernaut(var_02);
		deletecrate();
	}
}

//Function Number: 73
sentrycratethink(param_00)
{
	self endon("death");
	cratesetupforuse(game["strings"]["sentry_hint"],"all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				if(issubstr(param_00,"airdrop_sentry"))
				{
					var_01 thread hijacknotify(self,"sentry");
				}
				else
				{
					var_01 thread hijacknotify(self,"emergency_airdrop");
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::getstreakcost("sentry") / 10) * 50);
				self.owner maps\mp\gametypes\_hud_message::playercardsplashnotify("giveaway_sentry",var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_01 thread sentryusetracker();
		deletecrate();
	}
}

//Function Number: 74
trapnullfunc()
{
}

//Function Number: 75
trapcratethink(param_00)
{
	self endon("death");
	var_01 = getrandomcratetype("airdrop_trapcontents");
	cratesetupforuse(game["strings"][var_01 + "_hint"],"trap","none");
	self.bomb = spawn("script_model",self.origin);
	var_02 = bullettrace(self.bomb.origin,self.bomb.origin + (100,100,128),0,self.bomb);
	self.bomb.killcament = spawn("script_model",var_02["position"]);
	self.bomb.killcament setscriptmoverkillcam("explosive");
	thread crateothercapturethink();
	for(;;)
	{
		self waittill("captured",var_03);
		var_03 thread detonatetrap(self.bomb,self,self.owner);
	}
}

//Function Number: 76
detonatetrap(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_00 rotatevelocity((0,300,0),3);
	param_00 setmodel("prop_suitcase_bomb");
	var_03 = param_01.origin;
	thread common_scripts\utility::play_sound_in_space("javelin_clu_lock",var_03);
	wait 1;
	var_04 = var_03 + (0,0,1) - var_03;
	playfx(level.chopper_fx["explode"]["death"]["cobra"],var_03,var_04);
	thread common_scripts\utility::play_sound_in_space("cobra_helicopter_crash",var_03);
	if(isdefined(param_02))
	{
		param_00 radiusdamage(var_03,400,200,50,param_02,"MOD_EXPLOSIVE","airdrop_trap_explosive_mp");
	}
	else
	{
		param_00 radiusdamage(var_03,400,200,50,undefined,"MOD_EXPLOSIVE","airdrop_trap_explosive_mp");
	}

	param_01 deletecrate();
}

//Function Number: 77
deletecrate()
{
	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		maps\mp\_utility::_objective_delete(self.objidenemy);
	}

	if(isdefined(self.bomb) && isdefined(self.bomb.killcament))
	{
		self.bomb.killcament delete();
	}

	if(isdefined(self.bomb))
	{
		self.bomb delete();
	}

	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self delete();
}

//Function Number: 78
sentryusetracker()
{
	if(!maps\mp\killstreaks\_autosentry::givesentry("sentry_minigun"))
	{
		maps\mp\killstreaks\_killstreaks::givekillstreak("sentry");
	}
}

//Function Number: 79
givelocaltrophy(param_00)
{
	self.activetrophy = 1;
	self.trophyammo = 6;
	thread personaltrophyactive();
}

//Function Number: 80
hijacknotify(param_00,param_01)
{
	self notify("hijacker",param_01,param_00.owner);
}

//Function Number: 81
refillammo(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
		if(maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_tacticalinsertion",0);
		}

		if(maps\mp\_utility::_hasperk("specialty_scrambler") && self getammocount("scrambler_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_scrambler",0);
		}

		if(maps\mp\_utility::_hasperk("specialty_portable_radar") && self getammocount("portable_radar_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_portable_radar",0);
		}
	}

	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"grenade") || getsubstr(var_03,0,2) == "gl")
		{
			if(!param_00 || self getammocount(var_03) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(var_03);
	}
}

//Function Number: 82
useholdthink(param_00,param_01,param_02)
{
	param_00 playerlinkto(self);
	param_00 playerlinkedoffsetenable();
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = 3000;
	}

	param_00 thread personalusebar(self,param_02);
	var_03 = useholdthinkloop(param_00);
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
		param_00 unlink();
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 0;
	self.curprogress = 0;
	return var_03;
}

//Function Number: 83
personalusebar(param_00,param_01)
{
	self endon("disconnect");
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0,25);
	var_03 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,25);
	if(!isdefined(param_01))
	{
		param_01 = &"MP_CAPTURING_CRATE";
	}

	var_03 settext(param_01);
	var_04 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended)
	{
		if(var_04 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			var_02 maps\mp\gametypes\_hud_util::updatebar(param_00.curprogress / param_00.usetime,1000 / param_00.usetime * param_00.userate);
			if(!param_00.userate)
			{
				var_02 maps\mp\gametypes\_hud_util::hideelem();
				var_03 maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				var_02 maps\mp\gametypes\_hud_util::showelem();
				var_03 maps\mp\gametypes\_hud_util::showelem();
			}
		}

		var_04 = param_00.userate;
		wait 0.05;
	}

	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 84
useholdthinkloop(param_00)
{
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 85
isairdropmarker(param_00)
{
	switch(param_00)
	{
		case "airdrop_escort_marker_mp":
		case "airdrop_trap_marker_mp":
		case "airdrop_tank_marker_mp":
		case "airdrop_juggernaut_def_mp":
		case "airdrop_juggernaut_mp":
		case "airdrop_sentry_marker_mp":
		case "airdrop_mega_marker_mp":
		case "airdrop_marker_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 86
createuseent()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.curprogress = 0;
	var_00.usetime = 0;
	var_00.userate = 3000;
	var_00.inuse = 0;
	var_00 thread deleteuseent(self);
	return var_00;
}

//Function Number: 87
deleteuseent(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 88
airdropdetonateonstuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self detonate();
}

//Function Number: 89
projectileexplode(param_00)
{
	self endon("death");
	var_01 = param_00.origin;
	var_02 = param_00.model;
	var_03 = param_00.angles;
	param_00 delete();
	playfx(level.mine_explode,var_01,anglestoforward(var_03),anglestoup(var_03));
	radiusdamage(var_01,65,75,10,self);
}

//Function Number: 90
personaltrophyactive()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(!isdefined(level.grenades) || level.grenades.size < 1)
		{
			wait 0.05;
			continue;
		}

		var_01 = maps\mp\_utility::combinearrays(level.grenades,level.missiles);
		foreach(var_03 in var_01)
		{
			wait 0.05;
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03 == self)
			{
				continue;
			}

			if(isdefined(var_03.weaponname) && var_03.weaponname == "trophy_mp")
			{
				continue;
			}

			if(var_03.model == "weapon_parabolic_knife")
			{
				continue;
			}

			if(!isdefined(var_03.owner))
			{
				var_03.owner = getmissileowner(var_03);
			}

			if(isdefined(var_03.owner) && level.teambased && var_03.owner.team == self.team)
			{
				continue;
			}

			var_04 = distancesquared(var_03.origin,self.origin);
			if(var_04 < 147456)
			{
				if(bullettracepassed(var_03.origin,self.origin,0,self))
				{
					playfx(level.sentry_fire,self.origin + (0,0,32),var_03.origin - self.origin,anglestoup(self.angles));
					thread projectileexplode(var_03);
					self.trophyammo--;
					if(self.trophyammo <= 0)
					{
						return;
					}
				}
			}
		}
	}
}
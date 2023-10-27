/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airdrop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 89
 * Decompile Time: 1566 ms
 * Timestamp: 10/27/2023 1:20:21 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level._effect["airdrop_crate_destroy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup");
	level._effect["airdrop_dust_kickup"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_airdrop_crate_dust_kickup");
	precachempanim("juggernaut_carepackage");
	setairdropcratecollision("airdrop_crate");
	setairdropcratecollision("care_package");
	level.killstreakfuncs["airdrop_assault"] = ::func_8427;
	level.killstreakfuncs["airdrop_support"] = ::func_8427;
	level.killstreakfuncs["airdrop_juggernaut"] = ::func_8427;
	level.killstreakfuncs["airdrop_juggernaut_recon"] = ::func_8427;
	level.killstreakfuncs["airdrop_juggernaut_maniac"] = ::func_8427;
	level.numdropcrates = 0;
	level.littlebirds = [];
	level.cratetypes = [];
	level.cratemaxval = [];
	addcratetype("airdrop_assault","uplink",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_UPLINK_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","ims",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_IMS_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","guard_dog",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","drone_hive",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","sentry",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_SENTRY_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","helicopter",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELICOPTER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","ball_drone_backup",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","vanguard",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_VANGUARD_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","airdrop_juggernaut_maniac",3,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_assault","airdrop_juggernaut",2,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_assault","heli_pilot",1,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_assault","odin_assault",1,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_ODIN_ASSAULT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","uplink_support",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_UPLINK_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","deployable_vest",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","deployable_ammo",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","ball_drone_radar",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","aa_launcher",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","jammer",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_JAMMER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","air_superiority",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","recon_agent",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","heli_sniper",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","uav_3dping",3,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_support","airdrop_juggernaut_recon",1,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_support","odin_support",1,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_ODIN_SUPPORT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_juggernaut","airdrop_juggernaut",100,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_juggernaut_recon","airdrop_juggernaut_recon",100,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_juggernaut_maniac","airdrop_juggernaut_maniac",100,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_grnd","uplink",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_UPLINK_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","ims",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_IMS_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","guard_dog",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_GUARD_DOG_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","drone_hive",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","sentry",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_SENTRY_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","helicopter",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELICOPTER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","ball_drone_backup",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","vanguard",4,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_VANGUARD_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","airdrop_juggernaut_maniac",3,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_MANIAC_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_grnd","airdrop_juggernaut",2,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_PICKUP","mp_juggernaut_carepackage_dummy");
	addcratetype("airdrop_grnd","heli_pilot",1,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELI_PILOT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","deployable_vest",25,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DEPLOYABLE_VEST_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","deployable_ammo",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","ball_drone_radar",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_BALL_DRONE_RADAR_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","aa_launcher",20,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_AA_LAUNCHER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","jammer",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_JAMMER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","air_superiority",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_AIR_SUPERIORITY_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","recon_agent",15,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_RECON_AGENT_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","heli_sniper",10,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","uav_3dping",5,::killstreakcratethink,"carepackage_friendly_iw6","carepackage_enemy_iw6",&"KILLSTREAKS_HINTS_UAV_3DPING_PICKUP","carepackage_dummy_iw6");
	addcratetype("airdrop_grnd","airdrop_juggernaut_recon",5,::func_4A26,"mp_juggernaut_carepackage","mp_juggernaut_carepackage_red",&"KILLSTREAKS_HINTS_JUGGERNAUT_RECON_PICKUP","mp_juggernaut_carepackage_dummy");
	if(isdefined(level.customcratefunc))
	{
		[[ level.customcratefunc ]]("carepackage_friendly_iw6","carepackage_enemy_iw6");
	}

	if(isdefined(level.mapcustomcratefunc))
	{
		[[ level.mapcustomcratefunc ]]();
	}

	generatemaxweightedcratevalue();
	var_00 = spawnstruct();
	var_00.xppopup = "destroyed_airdrop";
	var_00.vodestroyed = undefined;
	var_00.callout = "callout_destroyed_airdrop";
	var_00.samdamagescale = 0.09;
	level.heliconfigs["airdrop"] = var_00;
	maps\mp\gametypes\_rank::registerscoreinfo("little_bird",200);
}

//Function Number: 2
generatemaxweightedcratevalue()
{
	foreach(var_06, var_01 in level.cratetypes)
	{
		level.cratemaxval[var_06] = 0;
		foreach(var_03 in var_01)
		{
			var_04 = var_03.type;
			if(!level.cratetypes[var_06][var_04].raw_weight)
			{
				level.cratetypes[var_06][var_04].weight = level.cratetypes[var_06][var_04].raw_weight;
				continue;
			}

			level.cratemaxval[var_06] = level.cratemaxval[var_06] + level.cratetypes[var_06][var_04].raw_weight;
			level.cratetypes[var_06][var_04].weight = level.cratemaxval[var_06];
		}
	}
}

//Function Number: 3
changecrateweight(param_00,param_01,param_02)
{
	if(!isdefined(level.cratetypes[param_00]) || !isdefined(level.cratetypes[param_00][param_01]))
	{
	}

	level.cratetypes[param_00][param_01].raw_weight = param_02;
	generatemaxweightedcratevalue();
}

//Function Number: 4
setairdropcratecollision(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
	}

	level.airdropcratecollision = getent(var_01[0].target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 deletecrate();
	}
}

//Function Number: 5
addcratetype(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_04))
	{
		param_04 = "carepackage_friendly_iw6";
	}

	if(!isdefined(param_05))
	{
		param_05 = "carepackage_enemy_iw6";
	}

	if(!isdefined(param_08))
	{
		param_08 = "carepackage_dummy_iw6";
	}

	level.cratetypes[param_00][param_01] = spawnstruct();
	level.cratetypes[param_00][param_01].droptype = param_00;
	level.cratetypes[param_00][param_01].type = param_01;
	level.cratetypes[param_00][param_01].raw_weight = param_02;
	level.cratetypes[param_00][param_01].weight = param_02;
	level.cratetypes[param_00][param_01].func = param_03;
	level.cratetypes[param_00][param_01].model_name_friendly = param_04;
	level.cratetypes[param_00][param_01].model_name_enemy = param_05;
	level.cratetypes[param_00][param_01].model_name_dummy = param_08;
	if(isdefined(param_06))
	{
		game["strings"][param_01 + "_hint"] = param_06;
	}

	if(isdefined(param_07))
	{
		game["strings"][param_01 + "_optional_hint"] = param_07;
	}
}

//Function Number: 6
getrandomcratetype(param_00)
{
	var_01 = randomint(level.cratemaxval[param_00]);
	var_02 = undefined;
	foreach(var_04 in level.cratetypes[param_00])
	{
		var_05 = var_04.type;
		if(!level.cratetypes[param_00][var_05].weight)
		{
			continue;
		}

		var_02 = var_05;
		if(level.cratetypes[param_00][var_05].weight > var_01)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 7
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

		case "airdrop_juggernaut_maniac":
			return "airdrop_juggernaut_maniac";

		case "airdrop_remote_tank":
			return "remote_tank";

		case "airdrop_lase":
			return "lasedStrike";

		case "airdrop_sotf":
		case "airdrop_grnd_mega":
		case "airdrop_escort":
		case "airdrop_grnd":
		case "airdrop_support":
		case "airdrop_mega":
		case "airdrop_assault":
		default:
			if(isdefined(level.getrandomcratetypeforgamemode))
			{
				return [[ level.getrandomcratetypeforgamemode ]](param_00);
			}
			return getrandomcratetype(param_00);
	}
}

//Function Number: 8
func_8427(param_00,param_01)
{
	var_02 = param_01;
	var_03 = undefined;
	if(!isdefined(var_02))
	{
		var_02 = "airdrop_assault";
	}

	var_04 = 1;
	if((level.littlebirds.size >= 4 || level.fauxvehiclecount >= 4) && var_02 != "airdrop_mega" && !issubstr(tolower(var_02),"juggernaut"))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_04 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(var_02 == "airdrop_lase" && isdefined(level.lasedstrikecrateactive) && level.lasedstrikecrateactive)
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(var_02 != "airdrop_mega" && !issubstr(tolower(var_02),"juggernaut"))
	{
		thread func_8CDA();
	}

	if(!issubstr(var_02,"juggernaut"))
	{
		maps\mp\_utility::func_4487();
	}

	var_03 = beginairdropviamarker(param_00,var_02);
	if(!isdefined(var_03) || !var_03)
	{
		self notify("markerDetermined");
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(var_02 == "airdrop_mega")
	{
		thread maps\mp\_utility::func_7FA0("used_airdrop_mega",self);
	}

	self notify("markerDetermined");
	maps\mp\_matchdata::func_4F1D(var_02,self.origin);
	return 1;
}

//Function Number: 9
func_8CDA()
{
	self endon("markerDetermined");
	self waittill("disconnect");
}

//Function Number: 10
beginairdropviamarker(param_00,param_01)
{
	self notify("beginAirdropViaMarker");
	self endon("beginAirdropViaMarker");
	self endon("disconnect");
	level endon("game_ended");
	self.threwairdropmarker = undefined;
	self.threwairdropmarkerindex = undefined;
	thread func_8CC4(param_00,param_01);
	thread func_8CC2(param_00,param_01);
	thread func_8CC1(param_00,param_01);
	var_02 = common_scripts\utility::func_8B33("notAirDropWeapon","markerDetermined");
	if(isdefined(var_02) && var_02 == "markerDetermined")
	{
		return 1;
	}
	else if(!isdefined(var_02) && isdefined(self.threwairdropmarker))
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_8CC4(param_00,param_01)
{
	level endon("game_ended");
	self notify("watchAirDropWeaponChange");
	self endon("watchAirDropWeaponChange");
	self endon("disconnect");
	self endon("markerDetermined");
	while(maps\mp\_utility::func_4899())
	{
		wait(0.05);
	}

	var_02 = self getcurrentweapon();
	if(maps\mp\killstreaks\_killstreaks::isairdropmarker(var_02))
	{
		var_03 = var_02;
	}
	else
	{
		var_03 = undefined;
	}

	while(maps\mp\killstreaks\_killstreaks::isairdropmarker(var_02))
	{
		self waittill("weapon_switch_started",var_02);
		if(maps\mp\killstreaks\_killstreaks::isairdropmarker(var_02))
		{
			var_03 = var_02;
		}
	}

	if(isdefined(self.threwairdropmarker))
	{
		var_04 = maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.threwairdropmarkerindex].streakname);
		self takeweapon(var_04);
		self notify("markerDetermined");
	}

	self notify("notAirDropWeapon");
}

//Function Number: 12
func_8CC2(param_00,param_01)
{
	level endon("game_ended");
	self notify("watchAirDropMarkerUsage");
	self endon("watchAirDropMarkerUsage");
	self endon("disconnect");
	self endon("markerDetermined");
	for(;;)
	{
		self waittill("grenade_pullback",var_02);
		if(!maps\mp\killstreaks\_killstreaks::isairdropmarker(var_02))
		{
			continue;
		}

		common_scripts\utility::_disableusability();
		beginairdropmarkertracking();
	}
}

//Function Number: 13
func_8CC1(param_00,param_01)
{
	level endon("game_ended");
	self notify("watchAirDropMarker");
	self endon("watchAirDropMarker");
	self endon("disconnect");
	self endon("markerDetermined");
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		if(!maps\mp\killstreaks\_killstreaks::isairdropmarker(var_03))
		{
			continue;
		}

		self.threwairdropmarker = 1;
		self.threwairdropmarkerindex = self.killstreakindexweapon;
		var_02 thread airdropdetonateonstuck();
		var_02.owner = self;
		var_02.weaponname = var_03;
		var_02 thread airdropmarkeractivate(param_01);
	}
}

//Function Number: 14
beginairdropmarkertracking()
{
	level endon("game_ended");
	self notify("beginAirDropMarkerTracking");
	self endon("beginAirDropMarkerTracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::func_8B2A("grenade_fire","weapon_change");
	common_scripts\utility::_enableusability();
}

//Function Number: 15
airdropmarkeractivate(param_00,param_01)
{
	level endon("game_ended");
	self notify("airDropMarkerActivate");
	self endon("airDropMarkerActivate");
	self waittill("explode",var_02);
	var_03 = self.owner;
	if(!isdefined(var_03))
	{
	}

	if(var_03 maps\mp\_utility::func_48F6())
	{
	}

	if(issubstr(tolower(param_00),"escort_airdrop") && isdefined(level.chopper))
	{
	}

	wait(0.05);
	if(issubstr(tolower(param_00),"juggernaut"))
	{
		level func_2860(var_03,var_02,randomfloat(360),param_00);
	}

	if(issubstr(tolower(param_00),"escort_airdrop"))
	{
		var_03 maps\mp\killstreaks\_escortairdrop::finishsupportescortusage(param_01,var_02,randomfloat(360),"escort_airdrop");
	}

	level func_2896(var_03,var_02,randomfloat(360),param_00);
}

//Function Number: 16
func_45D7()
{
	self.inuse = 0;
	self hide();
	if(isdefined(self.target))
	{
		self.collision = getent(self.target,"targetname");
		self.collision notsolid();
	}

	self.collision = undefined;
}

//Function Number: 17
func_2591(param_00)
{
	wait(0.25);
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 18
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

//Function Number: 19
func_203F(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team == "spectator")
		{
			if(param_00 == "allies")
			{
				self showtoplayer(var_02);
			}

			continue;
		}

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
			if(var_02.team == "spectator")
			{
				if(param_00 == "allies")
				{
					self showtoplayer(var_02);
				}

				continue;
			}

			if(var_02.team == param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 20
cratemodelenemyteamsupdater(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
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
			if(var_02.team != param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 21
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

//Function Number: 22
crateuseteamupdater(param_00)
{
	self endon("death");
	for(;;)
	{
		func_720B(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 23
func_204F(param_00)
{
	self endon("death");
	for(;;)
	{
		func_720A(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 24
func_204C()
{
	if(!issubstr(self.cratetype,"juggernaut"))
	{
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

//Function Number: 25
crateusepostjuggernautupdater(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 26
createairdropcrate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawn("script_model",param_03);
	var_06.curprogress = 0;
	var_06.usetime = 0;
	var_06.userate = 0;
	var_06.team = self.team;
	var_06.destination = param_04;
	var_06.id = "care_package";
	if(isdefined(param_00))
	{
		var_06.owner = param_00;
	}
	else
	{
		var_06.owner = undefined;
	}

	var_06.cratetype = param_02;
	var_06.droptype = param_01;
	var_06.targetname = "care_package";
	var_07 = "carepackage_dummy_iw6";
	if(isdefined(level.custom_dummy_crate_model))
	{
		var_07 = level.custom_dummy_crate_model;
	}

	var_06 setmodel(var_07);
	if(param_02 == "airdrop_jackpot")
	{
		var_06.friendlymodel = spawn("script_model",param_03);
		var_06.friendlymodel setmodel(level.cratetypes[param_01][param_02].model_name_friendly);
		var_06.friendlymodel thread func_2591(var_06);
	}
	else
	{
		var_06.friendlymodel = spawn("script_model",param_03);
		var_06.friendlymodel setmodel(level.cratetypes[param_01][param_02].model_name_friendly);
		if(isdefined(level.highlightairdrop) && level.highlightairdrop)
		{
			if(!isdefined(param_05))
			{
				param_05 = 2;
			}

			var_06.friendlymodel hudoutlineenable(param_05,0);
			var_06.outlinecolor = param_05;
		}

		var_06.enemymodel = spawn("script_model",param_03);
		var_06.enemymodel setmodel(level.cratetypes[param_01][param_02].model_name_enemy);
		var_06.friendlymodel setentityowner(var_06);
		var_06.enemymodel setentityowner(var_06);
		var_06.friendlymodel thread func_2591(var_06);
		if(level.teambased)
		{
			var_06.friendlymodel thread func_203F(var_06.team);
		}
		else
		{
			var_06.friendlymodel thread cratemodelplayerupdater(param_00,1);
		}

		var_06.enemymodel thread func_2591(var_06);
		if(level.multiteambased)
		{
			var_06.enemymodel thread cratemodelenemyteamsupdater(var_06.team);
		}
		else if(level.teambased)
		{
			var_06.enemymodel thread func_203F(level.otherteam[var_06.team]);
		}
		else
		{
			var_06.enemymodel thread cratemodelplayerupdater(param_00,0);
		}
	}

	var_06.inuse = 0;
	var_06 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	var_06 thread common_scripts\utility::entity_path_disconnect_thread(1);
	var_06.killcament = spawn("script_model",var_06.origin + (0,0,300),0,1);
	var_06.killcament setscriptmoverkillcam("explosive");
	var_06.killcament linkto(var_06);
	level.numdropcrates++;
	var_06 thread dropcrateexistence(param_04);
	level notify("createAirDropCrate",var_06);
	return var_06;
}

//Function Number: 27
dropcrateexistence(param_00)
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(level.cratekill))
	{
		[[ level.cratekill ]](param_00);
	}

	level.numdropcrates--;
}

//Function Number: 28
cratesetupforuse(param_00,param_01)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(param_00);
	self makeusable();
	var_02 = "compass_objpoint_ammo_friendly";
	var_03 = "compass_objpoint_ammo_enemy";
	if(isdefined(level.objvisall))
	{
		var_03 = "compass_objpoint_ammo_friendly";
	}

	if(!isdefined(self.objidfriendly))
	{
		self.objidfriendly = createobjective(var_02,self.team,1);
	}

	if(!isdefined(self.objidenemy))
	{
		self.objidenemy = createobjective(var_03,level.otherteam[self.team],0);
	}

	thread crateuseteamupdater();
	thread func_204C();
	if(issubstr(self.cratetype,"juggernaut"))
	{
		foreach(var_05 in level.players)
		{
			if(var_05 maps\mp\_utility::isjuggernaut())
			{
				thread crateusepostjuggernautupdater(var_05);
			}
		}
	}

	var_07 = undefined;
	if(level.teambased)
	{
		var_07 = maps\mp\_entityheadicons::setheadicon(self.team,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}
	else if(isdefined(self.owner))
	{
		var_07 = maps\mp\_entityheadicons::setheadicon(self.owner,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}

	if(isdefined(var_07))
	{
		var_07.showinkillcam = 0;
	}

	if(isdefined(level.iconvisall))
	{
		[[ level.iconvisall ]](self,param_01);
	}

	foreach(var_05 in level.players)
	{
		if(var_05.team == "spectator")
		{
			var_07 = maps\mp\_entityheadicons::setheadicon(var_05,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
		}
	}
}

//Function Number: 29
createobjective(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",(0,0,0));
	if(!isdefined(self getlinkedparent()))
	{
		objective_position(var_03,self.origin);
	}
	else
	{
		objective_onentity(var_03,self);
	}

	objective_state(var_03,"active");
	objective_icon(var_03,param_00);
	if(!level.teambased && isdefined(self.owner))
	{
		if(param_02)
		{
			objective_playerteam(var_03,self.owner getentitynumber());
		}
		else
		{
			objective_playerenemyteam(var_03,self.owner getentitynumber());
		}
	}
	else
	{
		objective_team(var_03,param_01);
	}

	if(isdefined(level.objvisall))
	{
		[[ level.objvisall ]](var_03);
	}

	return var_03;
}

//Function Number: 30
func_720B(param_00)
{
	foreach(var_02 in level.players)
	{
		if(issubstr(self.cratetype,"juggernaut") && var_02 maps\mp\_utility::isjuggernaut())
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(issubstr(self.cratetype,"lased") && isdefined(var_02.hassoflam) && var_02.hassoflam)
		{
			self disableplayeruse(var_02);
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

//Function Number: 31
func_720A(param_00)
{
	foreach(var_02 in level.players)
	{
		if(issubstr(self.cratetype,"juggernaut") && var_02 maps\mp\_utility::isjuggernaut())
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(!isdefined(param_00) || param_00 != var_02.team)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 32
func_2B5F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
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
		param_06 = (randomint(50),randomint(50),randomint(50));
	}

	var_09 = createairdropcrate(self.owner,param_01,var_0B,param_05,param_00);
	switch(param_01)
	{
		case "nuke_drop":
		case "airdrop_mega":
		case "airdrop_juggernaut_maniac":
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
	if(issubstr(var_0B,"juggernaut"))
	{
		param_06 = (0,0,0);
	}

	thread func_8AE2(var_09,param_06,param_01,var_0B);
	var_09.droppingtoground = 1;
	return var_0B;
}

//Function Number: 33
killplayerfromcrate_dodamage(param_00)
{
	if(isdefined(level.noairdropkills) && level.noairdropkills)
	{
	}

	param_00 dodamage(1000,param_00.origin,self,self,"MOD_CRUSH");
}

//Function Number: 34
killplayerfromcrate_fastvelocitypush()
{
	self endon("death");
	for(;;)
	{
		self waittill("player_pushed",var_00,var_01);
		if(isplayer(var_00) || isagent(var_00))
		{
			if(var_01[2] < -20)
			{
				killplayerfromcrate_dodamage(var_00);
			}
		}

		wait(0.05);
	}
}

//Function Number: 35
airdrop_override_death_moving_platform(param_00)
{
	if(isdefined(param_00.lasttouchedplatform.destroyairdroponcollision) && param_00.lasttouchedplatform.destroyairdroponcollision)
	{
		playfx(common_scripts\utility::func_3AB9("airdrop_crate_destroy"),self.origin);
		deletecrate();
	}
}

//Function Number: 36
func_9066()
{
	var_00 = self getlinkedchildren(1);
	if(!isdefined(var_00))
	{
	}

	foreach(var_02 in var_00)
	{
		if(!isplayer(var_02))
		{
			continue;
		}

		if(isdefined(var_02.iscapturingcrate) && var_02.iscapturingcrate)
		{
			var_03 = var_02 getlinkedparent();
			if(isdefined(var_03))
			{
				var_02 maps\mp\gametypes\_gameobjects::func_874E(var_03,0);
				var_02 unlink();
			}

			if(isalive(var_02))
			{
				var_02 common_scripts\utility::_enableweapon();
			}

			var_02.iscapturingcrate = 0;
		}
	}
}

//Function Number: 37
airdrop_override_invalid_moving_platform(param_00)
{
	wait(0.05);
	self notify("restarting_physics");
	func_9066();
	self physicslaunchserver((0,0,0),param_00.dropimpulse,param_00.airdrop_max_linear_velocity);
	thread func_5BE9(param_00.droptype,param_00.cratetype);
	thread func_5BEA(param_00.droptype,param_00.cratetype,param_00.dropimpulse,param_00.airdrop_max_linear_velocity);
}

//Function Number: 38
func_8AE2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	if(!isdefined(param_05) || !param_05)
	{
		self waittill("drop_crate");
	}

	var_06 = 1200;
	if(isdefined(param_04))
	{
		var_06 = param_04;
	}

	param_00 unlink();
	param_00 physicslaunchserver((0,0,0),param_01,var_06);
	param_00 thread func_5BE9(param_02,param_03);
	param_00 thread func_5BEA(param_02,param_03,param_01,var_06);
	param_00 thread killplayerfromcrate_fastvelocitypush();
	param_00.unresolved_collision_func = ::killplayerfromcrate_dodamage;
	if(isdefined(param_00.killcament))
	{
		if(isdefined(param_00.carestrike))
		{
			var_07 = -2100;
		}
		else
		{
			var_07 = 0;
		}

		param_00.killcament unlink();
		var_08 = bullettrace(param_00.origin,param_00.origin + (0,0,-10000),0,param_00);
		var_09 = distance(param_00.origin,var_08["position"]);
		var_0A = var_09 / 800;
		param_00.killcament moveto(var_08["position"] + (0,0,300) + (var_07,0,0),var_0A);
	}
}

//Function Number: 39
func_5BE9(param_00,param_01)
{
	self endon("restarting_physics");
	self endon("physics_finished");
	wait(0.5);
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		var_02 = bullettrace(self.origin,self.origin + (0,0,-60),0,self,0,0,0,1);
		if(var_02["fraction"] < 1)
		{
			var_03 = 600;
			self physicssetmaxlinvel(var_03);
			thread func_8ACC();
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 40
func_8ACC()
{
	self endon("death");
	wait(0.035);
	playfx(level._effect["airdrop_dust_kickup"],self.origin + (0,0,5),(0,0,1));
	self.friendlymodel scriptmodelplayanim("juggernaut_carepackage");
	self.enemymodel scriptmodelplayanim("juggernaut_carepackage");
}

//Function Number: 41
func_5BEA(param_00,param_01,param_02,param_03)
{
	self endon("restarting_physics");
	self waittill("physics_finished");
	self.droppingtoground = 0;
	self thread [[ level.cratetypes[param_00][param_01].func ]](param_00);
	level thread droptimeout(self,self.owner,param_01);
	var_04 = spawnstruct();
	var_04.endonstring = "restarting_physics";
	var_04.deathoverridecallback = ::airdrop_override_death_moving_platform;
	var_04.invalidparentoverridecallback = ::airdrop_override_invalid_moving_platform;
	var_04.droptype = param_00;
	var_04.cratetype = param_01;
	var_04.dropimpulse = param_02;
	var_04.airdrop_max_linear_velocity = param_03;
	thread maps\mp\_movers::func_3F25(var_04);
	if(self.friendlymodel maps\mp\_utility::func_818D())
	{
		deletecrate();
	}

	if(isdefined(self.owner) && abs(self.origin[2] - self.owner.origin[2]) > 3000)
	{
		deletecrate();
	}
}

//Function Number: 42
droptimeout(param_00,param_01,param_02)
{
	if(isdefined(level.nocratetimeout) && level.nocratetimeout)
	{
	}

	level endon("game_ended");
	param_00 endon("death");
	if(param_00.droptype == "nuke_drop")
	{
	}

	var_03 = 90;
	if(param_02 == "supply")
	{
		var_03 = 20;
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(var_03);
	while(param_00.curprogress != 0)
	{
		wait(1);
	}

	param_00 deletecrate();
}

//Function Number: 43
getpathstart(param_00,param_01)
{
	var_02 = 100;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 44
func_3B80(param_00,param_01)
{
	var_02 = 150;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04 + (0,90,0)) * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 45
func_3AB0(param_00)
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

//Function Number: 46
func_2896(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
	}

	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed())
	{
	}

	var_06 = func_3AB0(param_01);
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
	var_0C = func_3B80(var_0A,param_02);
	var_0A = var_0A + anglestoforward((0,param_02,0)) * -50;
	var_0D = func_4175(param_00,var_0B,var_0A);
	if(isdefined(level.highlightairdrop) && level.highlightairdrop)
	{
		var_0D hudoutlineenable(3,0);
	}

	var_0D endon("death");
	var_0D.droptype = param_03;
	var_0D setvehgoalpos(var_0A,1);
	var_0D thread func_2B5F(param_01,param_03,var_06,0,param_05,var_0B);
	wait(2);
	var_0D vehicle_setspeed(75,40);
	var_0D setyawspeed(180,180,180,0.3);
	var_0D waittill("goal");
	wait(0.1);
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

//Function Number: 47
func_296F(param_00,param_01,param_02,param_03)
{
	level thread func_2896(param_00,param_01,param_02,param_03,0);
	wait(randomintrange(1,2));
	level thread func_2896(param_00,param_01 + (128,128,0),param_02,param_03,128);
	wait(randomintrange(1,2));
	level thread func_2896(param_00,param_01 + (172,256,0),param_02,param_03,256);
	wait(randomintrange(1,2));
	level thread func_2896(param_00,param_01 + (64,0,0),param_02,param_03,0);
}

//Function Number: 48
func_2860(param_00,param_01,param_02,param_03)
{
	var_04 = 18000;
	var_05 = 3000;
	var_06 = vectortoyaw(param_01 - param_00.origin);
	var_07 = (0,var_06,0);
	var_08 = func_3AB0(param_01);
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

		wait(0.05);
	}

	wait(0.05);
	var_12 = (0,0,0);
	if(!maps\mp\_utility::func_47BB())
	{
		var_13[0] = var_0D thread func_2B5F(param_01,param_03,var_08,0,undefined,var_09,var_12);
	}

	wait(0.05);
	var_0D notify("drop_crate");
	var_14 = param_01 + anglestoforward(var_07) * var_04 * 1.5;
	var_0D moveto(var_14,var_0C / 2,0,0);
	wait(6);
	var_0D delete();
}

//Function Number: 49
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

	var_0A = func_3AB0(param_01);
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

		wait(0.05);
	}

	wait(0.05);
	var_13[0] = var_0F thread func_2B5F(param_01,param_03,var_0A,0,undefined,var_0B);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[1] = var_0F thread func_2B5F(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[2] = var_0F thread func_2B5F(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[3] = var_0F thread func_2B5F(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(4);
	var_0F delete();
}

//Function Number: 50
dropnuke(param_00,param_01,param_02)
{
	var_03 = 24000;
	var_04 = 2000;
	var_05 = randomint(360);
	var_06 = (0,var_05,0);
	var_07 = func_3AB0(param_00);
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

		wait(0.05);
	}

	var_0C thread func_2B5F(param_00,param_02,var_07,0,"nuke",var_08);
	wait(0.05);
	var_0C notify("drop_crate");
	wait(4);
	var_0C delete();
}

//Function Number: 51
func_7C68(param_00)
{
	self endon("death");
	wait(param_00);
	self stoploopsound();
}

//Function Number: 52
func_602A(param_00)
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

//Function Number: 53
c130setup(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = spawnplane(param_00,"script_model",param_01,"compass_objpoint_c130_friendly","compass_objpoint_c130_enemy");
	var_04 setmodel("vehicle_ac130_low_mp");
	if(!isdefined(var_04))
	{
	}

	var_04.owner = param_00;
	var_04.team = param_00.team;
	level.c130 = var_04;
	return var_04;
}

//Function Number: 54
func_4175(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = "littlebird_mp";
	if(isdefined(level.vehicleoverride))
	{
		var_04 = level.vehicleoverride;
	}

	var_05 = spawnhelicopter(param_00,param_01,var_03,var_04,level.littlebird_model);
	if(!isdefined(var_05))
	{
	}

	var_05 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_05 thread maps\mp\killstreaks\_helicopter::func_6590();
	var_05.maxhealth = 500;
	var_05.owner = param_00;
	var_05.team = param_00.team;
	var_05.isairdrop = 1;
	var_05 thread func_8D2E();
	var_05 thread func_40B4();
	var_05 thread func_4156();
	var_05 thread maps\mp\killstreaks\_helicopter::func_40A5("airdrop");
	var_05 setmaxpitchroll(45,85);
	var_05 vehicle_setspeed(250,175);
	var_05.helitype = "airdrop";
	var_05 hidepart("tag_wings");
	return var_05;
}

//Function Number: 55
func_8D2E()
{
	level endon("game_ended");
	self endon("leaving");
	self endon("helicopter_gone");
	self endon("death");
	maps\mp\gametypes\_hostmigration::func_8B0D(25);
	self notify("death");
}

//Function Number: 56
func_40B4()
{
	common_scripts\utility::func_8B2A("crashing","leaving");
	self notify("helicopter_gone");
}

//Function Number: 57
func_4156()
{
	self endon("leaving");
	self endon("helicopter_gone");
	self waittill("death");
	if(!isdefined(self))
	{
	}

	self vehicle_setspeed(25,5);
	thread func_4D0C(randomintrange(180,220));
	wait(randomfloatrange(0.5,1.5));
	self notify("drop_crate");
	lbexplode();
}

//Function Number: 58
lbexplode()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	playfx(level.chopper_fx["explode"]["death"]["cobra"],self.origin,var_00);
	self playsound("exp_helicopter_fuel");
	self notify("explode");
	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 59
func_4D0C(param_00)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"],self,"tail_rotor_jnt");
	playfxontag(level.chopper_fx["fire"]["trail"]["medium"],self,"tail_rotor_jnt");
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 60
func_5754()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(!var_00 isonground())
		{
			continue;
		}

		if(!func_87BF(var_00))
		{
			continue;
		}

		self notify("captured",var_00);
	}
}

//Function Number: 61
crateothercapturethink(param_00)
{
	self endon("restarting_physics");
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(self.owner) && var_01 == self.owner)
		{
			continue;
		}

		if(!func_8816(var_01))
		{
			continue;
		}

		if(isdefined(level.overridecrateusetime))
		{
			var_02 = level.overridecrateusetime;
		}
		else
		{
			var_02 = undefined;
		}

		var_01.iscapturingcrate = 1;
		var_03 = func_212C();
		var_04 = var_03 func_87BF(var_01,var_02,param_00);
		if(isdefined(var_03))
		{
			var_03 delete();
		}

		if(!isdefined(var_01))
		{
		}

		if(!var_04)
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 62
crateownercapturethink(param_00)
{
	self endon("restarting_physics");
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			continue;
		}

		if(!func_8816(var_01))
		{
			continue;
		}

		var_01.iscapturingcrate = 1;
		if(!func_87BF(var_01,500,param_00))
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 63
crateallcapturethink(param_00)
{
	self endon("restarting_physics");
	self.crateuseents = [];
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(!func_8816(var_01))
		{
			continue;
		}

		if(isdefined(level.overridecrateusetime))
		{
			var_02 = level.overridecrateusetime;
			continue;
		}

		var_02 = undefined;
		childthread func_90A3(var_01,var_02,param_00);
	}
}

//Function Number: 64
func_90A3(param_00,param_01,param_02)
{
	param_00.iscapturingcrate = 1;
	self.crateuseents[param_00.name] = func_212C();
	var_03 = self.crateuseents[param_00.name];
	var_04 = self.crateuseents[param_00.name] func_87BF(param_00,param_01,param_02,self);
	if(isdefined(self.crateuseents) && isdefined(var_03))
	{
		self.crateuseents = maps\mp\_utility::array_remove_keep_index(self.crateuseents,var_03);
		var_03 delete();
	}

	if(!isdefined(param_00))
	{
	}

	param_00.iscapturingcrate = 0;
	if(var_04)
	{
		self notify("captured",param_00);
	}
}

//Function Number: 65
func_9554()
{
	self.inuse = 0;
	foreach(var_01 in self.crateuseents)
	{
		if(var_01.inuse)
		{
			self.inuse = 1;
			break;
		}
	}
}

//Function Number: 66
func_8816(param_00)
{
	if((self.cratetype == "airdrop_juggernaut_recon" || self.cratetype == "airdrop_juggernaut" || self.cratetype == "airdrop_juggernaut_maniac") && param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isdefined(param_00.onhelisniper) && param_00.onhelisniper)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(maps\mp\_utility::func_48F7(var_01) && !maps\mp\_utility::func_48EF(var_01))
	{
		return 0;
	}

	if(isdefined(param_00.changingweapon) && maps\mp\_utility::func_48F7(param_00.changingweapon) && !issubstr(param_00.changingweapon,"jugg_mp"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
killstreakcratethink(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	if(isdefined(game["strings"][self.cratetype + "_hint"]))
	{
		var_01 = game["strings"][self.cratetype + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	cratesetupforuse(var_01,maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_02);
		if(isplayer(var_02))
		{
			var_02 setclientomnvar("ui_securing",0);
			var_02.ui_securing = undefined;
		}

		if(isdefined(self.owner) && var_02 != self.owner)
		{
			if(!level.teambased || var_02.team != self.team)
			{
				switch(param_00)
				{
					case "airdrop_osprey_gunner":
					case "airdrop_escort":
					case "airdrop_support":
					case "airdrop_assault":
						var_02 thread maps\mp\gametypes\_missions::func_37A9("hijacker_airdrop");
						var_02 thread func_421F(self,"airdrop");
						break;
	
					case "airdrop_sentry_minigun":
						var_02 thread maps\mp\gametypes\_missions::func_37A9("hijacker_airdrop");
						var_02 thread func_421F(self,"sentry");
						break;
	
					case "airdrop_remote_tank":
						var_02 thread maps\mp\gametypes\_missions::func_37A9("hijacker_airdrop");
						var_02 thread func_421F(self,"remote_tank");
						break;
	
					case "airdrop_mega":
						var_02 thread maps\mp\gametypes\_missions::func_37A9("hijacker_airdrop_mega");
						var_02 thread func_421F(self,"emergency_airdrop");
						break;
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::func_3C16(self.cratetype) / 10 * 50));
				self.owner thread maps\mp\gametypes\_hud_message::func_794D("sharepackage",int(maps\mp\killstreaks\_killstreaks::func_3C16(self.cratetype) / 10 * 50));
			}
		}

		var_02 playlocalsound("ammo_crate_use");
		var_02 thread maps\mp\killstreaks\_killstreaks::func_3CF2(self.cratetype,0,0,self.owner);
		var_02 maps\mp\gametypes\_hud_message::func_4B46(self.cratetype,undefined);
		deletecrate();
	}
}

//Function Number: 68
lasedstrikecratethink(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	cratesetupforuse(game["strings"]["marker_hint"],maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
	level.lasedstrikecrateactive = 1;
	thread crateownercapturethink();
	thread crateothercapturethink();
	var_01 = 0;
	var_02 = thread maps\mp\killstreaks\_lasedstrike::func_78BD(self.owner);
	level.lasedstrikedrone = var_02;
	level.lasedstrikeactive = 1;
	level.soflamcrate = self;
	for(;;)
	{
		self waittill("captured",var_03);
		if(isdefined(self.owner) && var_03 != self.owner)
		{
			if(!level.teambased || var_03.team != self.team)
			{
				deletecrate();
			}
		}

		func_720B(self.team);
		var_03 thread maps\mp\killstreaks\_lasedstrike::givemarker();
		var_01++;
		if(var_01 >= 5)
		{
			deletecrate();
		}
	}
}

//Function Number: 69
nukecratethink(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	cratesetupforuse(&"PLATFORM_CALL_NUKE",maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
	thread func_5754();
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

//Function Number: 70
func_4A26(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	cratesetupforuse(game["strings"][self.cratetype + "_hint"],maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
	thread crateothercapturethink();
	thread crateownercapturethink();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				if(self.cratetype == "airdrop_juggernaut_maniac")
				{
					var_01 thread func_421F(self,"maniac");
				}
				else if(maps\mp\_utility::func_4971(self.cratetype,"juggernaut_"))
				{
					var_01 thread func_421F(self,self.cratetype);
				}
				else
				{
					var_01 thread func_421F(self,"juggernaut");
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::func_3C16(self.cratetype) / 10) * 50);
				if(self.cratetype == "airdrop_juggernaut_maniac")
				{
					self.owner maps\mp\gametypes\_hud_message::func_5F9A("giveaway_juggernaut_maniac",var_01);
				}
				else if(maps\mp\_utility::func_4971(self.cratetype,"juggernaut_"))
				{
					self.owner maps\mp\gametypes\_hud_message::func_5F9A("giveaway_" + self.cratetype,var_01);
				}
				else
				{
					self.owner maps\mp\gametypes\_hud_message::func_5F9A("giveaway_juggernaut",var_01);
				}
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
	
			case "airdrop_juggernaut_maniac":
				var_02 = "juggernaut_maniac";
				break;
	
			default:
				if(maps\mp\_utility::func_4971(self.cratetype,"juggernaut_"))
				{
					var_02 = self.cratetype;
				}
				break;
		}

		var_01 thread maps\mp\killstreaks\_juggernaut::givejuggernaut(var_02);
		deletecrate();
	}
}

//Function Number: 71
func_6E04(param_00)
{
	self endon("death");
	cratesetupforuse(game["strings"]["sentry_hint"],maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
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
					var_01 thread func_421F(self,"sentry");
				}
				else
				{
					var_01 thread func_421F(self,"emergency_airdrop");
				}
			}
			else
			{
				self.owner thread maps\mp\gametypes\_rank::giverankxp("killstreak_giveaway",int(maps\mp\killstreaks\_killstreaks::func_3C16("sentry") / 10) * 50);
				self.owner maps\mp\gametypes\_hud_message::func_5F9A("giveaway_sentry",var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_01 thread func_6E0F();
		deletecrate();
	}
}

//Function Number: 72
deletecrate()
{
	self notify("crate_deleting");
	if(isdefined(self.usedby))
	{
		foreach(var_01 in self.usedby)
		{
			var_01 setclientomnvar("ui_securing",0);
			var_01.ui_securing = undefined;
		}
	}

	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		if(level.multiteambased)
		{
			foreach(var_04 in self.objidenemy)
			{
				maps\mp\_utility::_objective_delete(var_04);
			}
		}
		else
		{
			maps\mp\_utility::_objective_delete(self.objidenemy);
		}
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

	if(isdefined(self.droptype))
	{
		playfx(common_scripts\utility::func_3AB9("airdrop_crate_destroy"),self.origin);
	}

	self delete();
}

//Function Number: 73
func_6E0F()
{
	if(!maps\mp\killstreaks\_autosentry::func_3D0D("sentry_minigun"))
	{
		maps\mp\killstreaks\_killstreaks::func_3CF2("sentry");
	}
}

//Function Number: 74
func_421F(param_00,param_01)
{
	self notify("hijacker",param_01,param_00.owner);
}

//Function Number: 75
func_6429(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
		if(maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
		{
			maps\mp\_utility::func_3CFD("specialty_tacticalinsertion",0);
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

//Function Number: 76
func_87BF(param_00,param_01,param_02,param_03)
{
	maps\mp\_movers::script_mover_link_to_use_object(param_00);
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_03))
	{
		param_03 func_9554();
	}

	if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = 3000;
	}

	var_04 = useholdthinkloop(param_00);
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
	}

	if(isdefined(param_00))
	{
		maps\mp\_movers::script_mover_unlink_from_use_object(param_00);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 0;
	self.curprogress = 0;
	if(isdefined(param_03))
	{
		param_03 func_9554();
	}

	return var_04;
}

//Function Number: 77
useholdthinkloop(param_00)
{
	while(param_00 maps\mp\killstreaks\_deployablebox::func_92B0(self))
	{
		if(!param_00 maps\mp\_movers::script_mover_use_can_link(self))
		{
			param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
			return 0;
		}

		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		param_00 maps\mp\gametypes\_gameobjects::func_874E(self,1);
		if(self.curprogress >= self.usetime)
		{
			param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
			return maps\mp\_utility::func_4945(param_00);
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
	}

	return 0;
}

//Function Number: 78
func_212C()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.curprogress = 0;
	var_00.usetime = 0;
	var_00.userate = 3000;
	var_00.inuse = 0;
	var_00.id = self.id;
	var_00 linkto(self);
	var_00 thread deleteuseent(self);
	return var_00;
}

//Function Number: 79
deleteuseent(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self.usedby))
	{
		foreach(var_02 in self.usedby)
		{
			var_02 setclientomnvar("ui_securing",0);
			var_02.ui_securing = undefined;
		}
	}

	self delete();
}

//Function Number: 80
airdropdetonateonstuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self detonate();
}

//Function Number: 81
func_80A7(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.carepackages))
	{
		foreach(var_05 in level.carepackages)
		{
			if(isdefined(var_05.inuse) && var_05.inuse)
			{
				continue;
			}

			var_06 = var_05 getlinkedparent();
			if(isdefined(var_06) && var_06 == param_00)
			{
				thread func_77FC(var_05,param_01,param_02);
				if(isdefined(param_03))
				{
					maps\mp\_utility::func_252F(1,::func_6514,param_03);
				}
			}
		}
	}
}

//Function Number: 82
func_77FC(param_00,param_01,param_02)
{
	var_03 = param_00.owner;
	var_04 = param_00.droptype;
	var_05 = param_00.cratetype;
	var_06 = param_00.origin;
	param_00 deletecrate();
	var_07 = var_03 createairdropcrate(var_03,var_04,var_05,var_06 + param_01,var_06 + param_01);
	var_07.droppingtoground = 1;
	var_07 thread [[ level.cratetypes[var_07.droptype][var_07.cratetype].func ]](var_07.droptype);
	common_scripts\utility::func_8AFE();
	var_07 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	var_07 thread common_scripts\utility::entity_path_disconnect_thread(1);
	var_07 physicslaunchserver(var_07.origin,param_02);
	if(isbot(var_07.owner))
	{
		wait(0.1);
		var_07.owner notify("new_crate_to_take");
	}
}

//Function Number: 83
func_6514(param_00)
{
	if(isdefined(level.carepackages))
	{
		foreach(var_02 in level.carepackages)
		{
			if(isdefined(var_02) && isdefined(var_02.friendlymodel) && var_02.friendlymodel istouching(param_00))
			{
				var_02 deletecrate();
			}
		}
	}
}

//Function Number: 84
func_3864()
{
	return "carepackage_dummy_iw6";
}

//Function Number: 85
func_386C()
{
	return "carepackage_enemy_iw6";
}

//Function Number: 86
get_friendly_crate_model()
{
	return "carepackage_friendly_iw6";
}

//Function Number: 87
func_3865()
{
	return "mp_juggernaut_carepackage_dummy";
}

//Function Number: 88
func_386E()
{
	return "mp_juggernaut_carepackage_red";
}

//Function Number: 89
get_friendly_juggernaut_crate_model()
{
	return "mp_juggernaut_carepackage";
}
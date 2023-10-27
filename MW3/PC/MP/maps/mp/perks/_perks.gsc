/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 227 ms
 * Timestamp: 10/27/2023 2:14:49 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.perkfuncs = [];
	precacheshader("combathigh_overlay");
	precacheshader("specialty_juiced");
	precacheshader("compassping_revenge");
	precacheshader("specialty_c4death");
	precacheshader("specialty_finalstand");
	precachemodel("weapon_riot_shield_mp");
	precachemodel("viewmodel_riot_shield_mp");
	precachestring(&"MPUI_CHANGING_KIT");
	level.spawnglowmodel["enemy"] = "mil_emergency_flare_mp";
	level.spawnglowmodel["friendly"] = "mil_emergency_flare_mp";
	level.spawnglow["enemy"] = loadfx("misc/flare_ambient");
	level.spawnglow["friendly"] = loadfx("misc/flare_ambient_green");
	level.c4death = loadfx("explosions/javelin_explosion");
	level.spawnfire = loadfx("props/barrelexp");
	precachemodel(level.spawnglowmodel["friendly"]);
	precachemodel(level.spawnglowmodel["enemy"]);
	precachestring(&"MP_DESTROY_TI");
	precacheshaders();
	level._effect["ricochet"] = loadfx("impacts/large_metalhit_1");
	level.scriptperks = [];
	level.perksetfuncs = [];
	level.perkunsetfuncs = [];
	level.fauxperks = [];
	level.scriptperks["specialty_blastshield"] = 1;
	level.scriptperks["_specialty_blastshield"] = 1;
	level.scriptperks["specialty_akimbo"] = 1;
	level.scriptperks["specialty_siege"] = 1;
	level.scriptperks["specialty_falldamage"] = 1;
	level.scriptperks["specialty_shield"] = 1;
	level.scriptperks["specialty_feigndeath"] = 1;
	level.scriptperks["specialty_shellshock"] = 1;
	level.scriptperks["specialty_delaymine"] = 1;
	level.scriptperks["specialty_localjammer"] = 1;
	level.scriptperks["specialty_thermal"] = 1;
	level.scriptperks["specialty_blackbox"] = 1;
	level.scriptperks["specialty_steelnerves"] = 1;
	level.scriptperks["specialty_flashgrenade"] = 1;
	level.scriptperks["specialty_smokegrenade"] = 1;
	level.scriptperks["specialty_concussiongrenade"] = 1;
	level.scriptperks["specialty_challenger"] = 1;
	level.scriptperks["specialty_saboteur"] = 1;
	level.scriptperks["specialty_endgame"] = 1;
	level.scriptperks["specialty_rearview"] = 1;
	level.scriptperks["specialty_hardline"] = 1;
	level.scriptperks["specialty_ac130"] = 1;
	level.scriptperks["specialty_sentry_minigun"] = 1;
	level.scriptperks["specialty_predator_missile"] = 1;
	level.scriptperks["specialty_helicopter_minigun"] = 1;
	level.scriptperks["specialty_tank"] = 1;
	level.scriptperks["specialty_precision_airstrike"] = 1;
	level.scriptperks["specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_littlebird_support"] = 1;
	level.scriptperks["specialty_primarydeath"] = 1;
	level.scriptperks["specialty_secondarybling"] = 1;
	level.scriptperks["specialty_explosivedamage"] = 1;
	level.scriptperks["specialty_laststandoffhand"] = 1;
	level.scriptperks["specialty_dangerclose"] = 1;
	level.scriptperks["specialty_luckycharm"] = 1;
	level.scriptperks["specialty_hardjack"] = 1;
	level.scriptperks["specialty_extraspecialduration"] = 1;
	level.scriptperks["specialty_rollover"] = 1;
	level.scriptperks["specialty_armorpiercing"] = 1;
	level.scriptperks["specialty_omaquickchange"] = 1;
	level.scriptperks["_specialty_rearview"] = 1;
	level.scriptperks["_specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_steadyaimpro"] = 1;
	level.scriptperks["specialty_stun_resistance"] = 1;
	level.scriptperks["specialty_double_load"] = 1;
	level.scriptperks["specialty_hard_shell"] = 1;
	level.scriptperks["specialty_regenspeed"] = 1;
	level.scriptperks["specialty_twoprimaries"] = 1;
	level.scriptperks["specialty_autospot"] = 1;
	level.scriptperks["specialty_overkillpro"] = 1;
	level.scriptperks["specialty_anytwo"] = 1;
	level.scriptperks["specialty_assists"] = 1;
	level.scriptperks["specialty_fasterlockon"] = 1;
	level.scriptperks["specialty_paint"] = 1;
	level.scriptperks["specialty_paint_pro"] = 1;
	level.fauxperks["specialty_shield"] = 1;
	level.scriptperks["specialty_marksman"] = 1;
	level.scriptperks["specialty_sharp_focus"] = 1;
	level.scriptperks["specialty_bling"] = 1;
	level.scriptperks["specialty_moredamage"] = 1;
	level.scriptperks["specialty_copycat"] = 1;
	level.scriptperks["specialty_combathigh"] = 1;
	level.scriptperks["specialty_finalstand"] = 1;
	level.scriptperks["specialty_c4death"] = 1;
	level.scriptperks["specialty_juiced"] = 1;
	level.scriptperks["specialty_revenge"] = 1;
	level.scriptperks["specialty_light_armor"] = 1;
	level.scriptperks["specialty_carepackage"] = 1;
	level.scriptperks["specialty_stopping_power"] = 1;
	level.scriptperks["specialty_uav"] = 1;
	level.scriptperks["bouncingbetty_mp"] = 1;
	level.scriptperks["c4_mp"] = 1;
	level.scriptperks["claymore_mp"] = 1;
	level.scriptperks["frag_grenade_mp"] = 1;
	level.scriptperks["semtex_mp"] = 1;
	level.scriptperks["throwingknife_mp"] = 1;
	level.scriptperks["concussion_grenade_mp"] = 1;
	level.scriptperks["flash_grenade_mp"] = 1;
	level.scriptperks["smoke_grenade_mp"] = 1;
	level.scriptperks["specialty_portable_radar"] = 1;
	level.scriptperks["specialty_scrambler"] = 1;
	level.scriptperks["specialty_tacticalinsertion"] = 1;
	level.scriptperks["trophy_mp"] = 1;
	level.scriptperks["specialty_null"] = 1;
	level.perksetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::setblastshield;
	level.perkunsetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::unsetblastshield;
	level.perksetfuncs["specialty_siege"] = ::maps\mp\perks\_perkfunctions::setsiege;
	level.perkunsetfuncs["specialty_siege"] = ::maps\mp\perks\_perkfunctions::unsetsiege;
	level.perksetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::setfreefall;
	level.perkunsetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::unsetfreefall;
	level.perksetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::setlocaljammer;
	level.perkunsetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::unsetlocaljammer;
	level.perksetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::setthermal;
	level.perkunsetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::unsetthermal;
	level.perksetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::setblackbox;
	level.perkunsetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::unsetblackbox;
	level.perksetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::setlightweight;
	level.perkunsetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::unsetlightweight;
	level.perksetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::setsteelnerves;
	level.perkunsetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::unsetsteelnerves;
	level.perksetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::setdelaymine;
	level.perkunsetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::unsetdelaymine;
	level.perksetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::setchallenger;
	level.perkunsetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::unsetchallenger;
	level.perksetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::setsaboteur;
	level.perkunsetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::unsetsaboteur;
	level.perksetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::setendgame;
	level.perkunsetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::unsetendgame;
	level.perksetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::setrearview;
	level.perkunsetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::unsetrearview;
	level.perksetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::setac130;
	level.perkunsetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::unsetac130;
	level.perksetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::setsentryminigun;
	level.perkunsetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::unsetsentryminigun;
	level.perksetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::setpredatormissile;
	level.perkunsetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::unsetpredatormissile;
	level.perksetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::settank;
	level.perkunsetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::unsettank;
	level.perksetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::setprecision_airstrike;
	level.perkunsetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::unsetprecision_airstrike;
	level.perksetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::sethelicopterminigun;
	level.perkunsetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::unsethelicopterminigun;
	level.perksetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::setonemanarmy;
	level.perkunsetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::unsetonemanarmy;
	level.perksetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::setlittlebirdsupport;
	level.perkunsetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::unsetlittlebirdsupport;
	level.perksetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::settacticalinsertion;
	level.perkunsetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::unsettacticalinsertion;
	level.perksetfuncs["specialty_scrambler"] = ::maps\mp\gametypes\_scrambler::setscrambler;
	level.perkunsetfuncs["specialty_scrambler"] = ::maps\mp\gametypes\_scrambler::unsetscrambler;
	level.perksetfuncs["specialty_portable_radar"] = ::maps\mp\gametypes\_portable_radar::setportableradar;
	level.perkunsetfuncs["specialty_portable_radar"] = ::maps\mp\gametypes\_portable_radar::unsetportableradar;
	level.perksetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::setsteadyaimpro;
	level.perkunsetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::unsetsteadyaimpro;
	level.perksetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::setstunresistance;
	level.perkunsetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::unsetstunresistance;
	level.perksetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::setmarksman;
	level.perkunsetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::unsetmarksman;
	level.perksetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::setdoubleload;
	level.perkunsetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::unsetdoubleload;
	level.perksetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::setsharpfocus;
	level.perkunsetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::unsetsharpfocus;
	level.perksetfuncs["specialty_hard_shell"] = ::maps\mp\perks\_perkfunctions::sethardshell;
	level.perkunsetfuncs["specialty_hard_shell"] = ::maps\mp\perks\_perkfunctions::unsethardshell;
	level.perksetfuncs["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::setregenspeed;
	level.perkunsetfuncs["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::unsetregenspeed;
	level.perksetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::setautospot;
	level.perkunsetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::unsetautospot;
	level.perksetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::setempimmune;
	level.perkunsetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::unsetempimmune;
	level.perksetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::setoverkillpro;
	level.perkunsetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::unsetoverkillpro;
	level.perksetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::setcombathigh;
	level.perkunsetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::unsetcombathigh;
	level.perksetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::setlightarmor;
	level.perkunsetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::unsetlightarmor;
	level.perksetfuncs["specialty_revenge"] = ::maps\mp\perks\_perkfunctions::setrevenge;
	level.perkunsetfuncs["specialty_revenge"] = ::maps\mp\perks\_perkfunctions::unsetrevenge;
	level.perksetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::setc4death;
	level.perkunsetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::unsetc4death;
	level.perksetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::setfinalstand;
	level.perkunsetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::unsetfinalstand;
	level.perksetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::setjuiced;
	level.perkunsetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::unsetjuiced;
	level.perksetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::setcarepackage;
	level.perkunsetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::unsetcarepackage;
	level.perksetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::setstoppingpower;
	level.perkunsetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::unsetstoppingpower;
	level.perksetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::setuav;
	level.perkunsetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::unsetuav;
	initperkdvars();
	level thread onplayerconnect();
}

//Function Number: 2
precacheshaders()
{
	precacheshader("specialty_blastshield");
}

//Function Number: 3
validateperk(param_00,param_01)
{
	if(getdvarint("scr_game_perks") == 0)
	{
		if(tablelookup("mp/perkTable.csv",1,param_01,5) != "equipment")
		{
			return "specialty_null";
		}
	}

	return param_01;
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	self.perks = [];
	self.weaponlist = [];
	self.omaclasschanged = 0;
	for(;;)
	{
		self waittill("spawned_player");
		self.omaclasschanged = 0;
		thread playerproximitytracker();
		thread maps\mp\gametypes\_scrambler::scramblerproximitytracker();
	}
}

//Function Number: 6
playerproximitytracker()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	level endon("game_ended");
	self.proximityactive = 0;
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			wait 0.05;
			if(!isdefined(var_01))
			{
				continue;
			}

			if(var_01.team != self.team)
			{
				continue;
			}

			if(var_01 == self)
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_01))
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(self))
			{
				continue;
			}

			var_02 = distancesquared(var_01.origin,self.origin);
			if(var_02 < 262144)
			{
				self.proximityactive = 1;
				break;
			}
		}

		wait 0.25;
	}
}

//Function Number: 7
drawline(param_00,param_01,param_02)
{
	var_03 = int(param_02 * 20);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 8
cac_modified_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = 0;
	if(maps\mp\_utility::isbulletdamage(param_03))
	{
		if(isplayer(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_paint_pro") && !maps\mp\_utility::iskillstreakweapon(param_04))
		{
			if(!param_00 maps\mp\perks\_perkfunctions::ispainted())
			{
				param_01 maps\mp\gametypes\_missions::processchallenge("ch_bulletpaint");
			}

			param_00 thread maps\mp\perks\_perkfunctions::setpainted();
		}

		if(isplayer(param_01) && isdefined(param_04) && maps\mp\_utility::getweaponclass(param_04) == "weapon_sniper" && issubstr(param_04,"silencer"))
		{
			param_02 = param_02 * 0.75;
		}

		if(isplayer(param_01) && (param_01 maps\mp\_utility::_hasperk("specialty_stopping_power") && param_01 maps\mp\_utility::_hasperk("specialty_bulletdamage")) || param_01 maps\mp\_utility::_hasperk("specialty_moredamage"))
		{
			param_02 = param_02 + param_02 * level.bulletdamagemod;
		}

		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			param_02 = param_02 * level.armorvestmod;
		}
	}
	else if(isexplosivedamagemod(param_03))
	{
		if(isplayer(param_01) && param_01 != param_00 && param_01 isitemunlocked("specialty_paint") && param_01 maps\mp\_utility::_hasperk("specialty_paint") && !maps\mp\_utility::iskillstreakweapon(param_04))
		{
			if(!param_00 maps\mp\perks\_perkfunctions::ispainted())
			{
				param_01 maps\mp\gametypes\_missions::processchallenge("ch_paint_pro");
			}

			param_00 thread maps\mp\perks\_perkfunctions::setpainted();
		}

		if(isplayer(param_01) && weaponinheritsperks(param_04) && param_01 maps\mp\_utility::_hasperk("specialty_explosivedamage") && param_00 maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
			var_08 = var_08 + 0;
		}
		else if(isplayer(param_01) && weaponinheritsperks(param_04) && param_01 maps\mp\_utility::_hasperk("specialty_explosivedamage"))
		{
			var_08 = var_08 + param_02 * level.explosivedamagemod;
		}
		else if(param_00 maps\mp\_utility::_hasperk("_specialty_blastshield") && param_04 != "semtex_mp" || param_02 != 120)
		{
			var_08 = var_08 - int(param_02 * 1 - level.blastshieldmod);
		}

		if(maps\mp\_utility::iskillstreakweapon(param_04) && isplayer(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_dangerclose"))
		{
			var_08 = var_08 + param_02 * level.dangerclosemod;
		}

		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			switch(param_04)
			{
				case "ac130_25mm_mp":
					param_02 = param_02 * level.armorvestmod;
					break;

				case "remote_mortar_missile_mp":
					param_02 = param_02 * 0.2;
					break;

				default:
					if(param_02 < 1000)
					{
						if(param_02 > 1)
						{
							param_02 = param_02 * level.armorvestmod;
						}
					}
					break;
			}
		}

		if(10 - level.graceperiod - level.ingraceperiod > 0)
		{
			param_02 = param_02 * level.armorvestmod;
		}
	}
	else if(param_03 == "MOD_FALLING")
	{
		if(param_00 isitemunlocked("specialty_falldamage") && param_00 maps\mp\_utility::_hasperk("specialty_falldamage"))
		{
			if(param_02 > 0)
			{
				param_00 maps\mp\gametypes\_missions::processchallenge("ch_falldamage");
			}

			var_08 = 0;
			param_02 = 0;
		}
	}
	else if(param_03 == "MOD_MELEE")
	{
		if(isdefined(param_00.haslightarmor) && param_00.haslightarmor)
		{
			if(issubstr(param_04,"riotshield"))
			{
				param_02 = int(param_00.maxhealth * 0.66);
			}
			else
			{
				param_02 = param_00.maxhealth + 1;
			}
		}

		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			param_02 = 20;
			var_08 = 0;
		}
	}
	else if(param_03 == "MOD_IMPACT")
	{
		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			switch(param_04)
			{
				case "semtex_mp":
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
				case "frag_grenade_mp":
				case "concussion_grenade_mp":
								param_02 = 5;
								break;

				default:
								if(param_02 < 1000)
								{
									param_02 = 25;
								}
								break;
			}

			var_08 = 0;
		}
	}

	if(param_00 maps\mp\_utility::_hasperk("specialty_combathigh"))
	{
		if(isdefined(self.damageblockedtotal) && !level.teambased || isdefined(param_01) && isdefined(param_01.team) && param_00.team != param_01.team)
		{
			var_09 = param_02 + var_08;
			var_0A = var_09 - var_09 / 3;
			self.damageblockedtotal = self.damageblockedtotal + var_0A;
			if(self.damageblockedtotal >= 101)
			{
				self notify("combathigh_survived");
				self.damageblockedtotal = undefined;
			}
		}

		if(param_04 != "throwingknife_mp")
		{
			switch(param_03)
			{
				case "MOD_FALLING":
				case "MOD_MELEE":
					break;

				default:
					param_02 = int(param_02 / 3);
					var_08 = int(var_08 / 3);
					break;
			}
		}
	}

	if(isdefined(param_00.haslightarmor) && param_00.haslightarmor && param_04 == "throwingknife_mp")
	{
		param_02 = param_00.health;
		var_08 = 0;
	}

	if(param_02 <= 1)
	{
		param_02 = 1;
		return param_02;
	}

	return int(param_02 + var_08);
}

//Function Number: 9
initperkdvars()
{
	level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage",40) / 100;
	level.armorvestmod = 0.08;
	level.armorvestdefmod = 0.08;
	level.armorpiercingmod = 1.5;
	level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage",40) / 100;
	level.blastshieldmod = maps\mp\_utility::getintproperty("perk_blastShield",45) / 100;
	level.riotshieldmod = maps\mp\_utility::getintproperty("perk_riotShield",100) / 100;
	level.dangerclosemod = maps\mp\_utility::getintproperty("perk_dangerClose",100) / 100;
}

//Function Number: 10
cac_selector()
{
	var_00 = self.specialty;
}

//Function Number: 11
gambitusetracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(getdvarint("scr_game_perks") != 1)
	{
		return;
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	self notifyonplayercommand("gambit_on","+frag");
}

//Function Number: 12
giveblindeyeafterspawn()
{
	self endon("death");
	self endon("disconnect");
	maps\mp\_utility::giveperk("specialty_blindeye",0);
	self.spawnperk = 1;
	while(self.avoidkillstreakonspawntimer > 0)
	{
		self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
		wait 0.05;
	}

	maps\mp\_utility::_unsetperk("specialty_blindeye");
	self.spawnperk = 0;
}
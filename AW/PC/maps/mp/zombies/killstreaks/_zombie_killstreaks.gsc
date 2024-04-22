/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\killstreaks\_zombie_killstreaks.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 411 ms
 * Timestamp: 4/22/2024 2:13:10 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(isdefined(level.mapcustomkillstreakfunc))
	{
		[[ level.mapcustomkillstreakfunc ]]();
	}

	level thread maps\mp\killstreaks\_airdrop::init();
	level thread maps\mp\killstreaks\_rippedturret::init();
	level thread maps\mp\killstreaks\_orbital_carepackage::init();
	level thread maps\mp\killstreaks\_orbital_util::initstart();
	level thread maps\mp\zombies\killstreaks\_zombie_drone_assault::init();
	level thread maps\mp\zombies\killstreaks\_zombie_sentry::init();
	level thread maps\mp\zombies\killstreaks\_zombie_camouflage::init();
	level thread extrainit();
	level.killstreakfuncs["zm_ripped_turret"] = ::maps\mp\killstreaks\_rippedturret::tryuserippedturret;
	level.killstreakwieldweapons["orbital_carepackage_pod_zm_mp"] = "orbital_carepackage";
	level.ocp_weap_name = "orbital_carepackage_pod_zm_mp";
	level thread roundlogic();
}

//Function Number: 2
extrainit()
{
	level.teamemped["allies"] = 0;
	level.teamemped["axis"] = 0;
	level.orbitalsupportinuse = 0;
	level.missile_strike_gas_clouds = [];
}

//Function Number: 3
bot_killstreak_setup()
{
	var_00 = gettime();
	if(!isdefined(level.killstreak_botfunc))
	{
		thread maps\mp\bots\_bots_ks::bot_setup_map_specific_killstreaks();
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("zm_squadmate",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("remote_mg_sentry_turret",::maps\mp\bots\_bots_sentry::bot_killstreak_sentry,::maps\mp\bots\_bots_sentry::bot_can_use_sentry_only_ai_version,"turret");
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("assault_ugv",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use,::maps\mp\bots\_bots_ks::bot_can_use_assault_ugv_only_ai_version);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("zm_sentry",::maps\mp\bots\_bots_sentry::bot_killstreak_sentry,::maps\mp\bots\_bots_sentry::bot_can_use_sentry_only_ai_version,"turret");
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("zm_ugv",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use,::maps\mp\bots\_bots_ks::bot_can_use_assault_ugv_only_ai_version);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("uav",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("orbital_carepackage",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("heavy_exosuit",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("nuke",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("warbird",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("emp",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("orbitalsupport",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("recon_ugv",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("orbital_strike_laser",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("missile_strike",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
		maps\mp\bots\_bots_ks::bot_register_killstreak_func("strafing_run_airstrike",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
	}
}

//Function Number: 4
airdropcustomfunc()
{
	level.cratemaxval = [];
	level.cratetypes = [];
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","sentry_1",8,::killstreakcratethink,&"ZOMBIES_SENTRY_TURRET","zm_sentry","sentry_guardian","sentry_rippable");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","sentry_2",8,::killstreakcratethink,&"ZOMBIES_ROCKET_TURRET","zm_sentry","sentry_guardian","sentry_rocket_turret","sentry_rippable");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","sentry_3",9,::killstreakcratethink,&"ZOMBIES_LASER_TURRET","zm_sentry","sentry_guardian","sentry_energy_turret","sentry_rippable");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","drone_1",12,::killstreakcratethink,&"ZOMBIES_ROCKET_DRONE","zm_ugv","assault_ugv_ai","assault_ugv_rockets");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","drone_2",13,::killstreakcratethink,&"ZOMBIES_ASSAULT_DRONE","zm_ugv","assault_ugv_ai","assault_ugv_mg");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","money",25,::moneycratethink,&"ZOMBIES_CRATE_MONEY","money");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","camo",25,::killstreakcratethink,&"ZOMBIES_CRATE_SHIELD","zm_camouflage");
	if(isdefined(level.airdropcustomfunclevelspecific))
	{
		[[ level.airdropcustomfunclevelspecific ]]();
	}
}

//Function Number: 5
schedulescorestreaks()
{
	var_00 = undefined;
	if(isdefined(level.zmscorestreaks) && level.zmscorestreaks.size > 0)
	{
		var_00 = level.zmscorestreaks[level.zmscorestreaks.size - 1];
	}

	level.zmscorestreaks = [];
	level.zmscorestreakindex = 0;
	var_01 = [];
	if(isdefined(level.zmgetscorestreaksforschedule))
	{
		var_01 = [[ level.zmgetscorestreaksforschedule ]]();
	}
	else
	{
		var_01[var_01.size] = "sentry_" + randomintrange(1,4);
		var_01[var_01.size] = "drone_" + randomintrange(1,3);
		var_01[var_01.size] = "money";
		var_01[var_01.size] = "camo";
		var_01[var_01.size] = "sentry_" + randomintrange(1,4);
		var_01[var_01.size] = "drone_" + randomintrange(1,3);
		var_01[var_01.size] = "money";
		var_01[var_01.size] = "camo";
	}

	var_01 = common_scripts\utility::array_randomize(var_01);
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = getnextscorestreakindex(var_01,var_02,var_00);
		if(var_04 != -1)
		{
			level.zmscorestreaks[level.zmscorestreaks.size] = var_01[var_04];
			var_00 = var_01[var_04];
			var_01[var_04] = undefined;
			continue;
		}

		level.zmscorestreaks[level.zmscorestreaks.size] = level.zmscorestreaks[0];
		var_04 = getarraykeys(var_01)[0];
		level.zmscorestreaks[0] = var_01[var_04];
	}
}

//Function Number: 6
getnextscorestreakindex(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = strtok(param_02,"_");
		param_02 = var_03[0];
	}

	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_05 = param_00[var_04];
		if(isdefined(var_05))
		{
			if(!isdefined(param_02))
			{
				return var_04;
			}
			else
			{
				var_03 = strtok(var_05,"_");
				var_05 = var_03[0];
				if(var_05 != param_02)
				{
					return var_04;
				}
			}
		}
	}

	return -1;
}

//Function Number: 7
setupdroppositions()
{
	level.zmcarepackagelandingspots = common_scripts\utility::getstructarray("carepackageDropPosition","targetname");
	foreach(var_01 in level.zmcarepackagelandingspots)
	{
		var_01.indoors = isdefined(var_01.script_parameters) && var_01.script_parameters == "indoors";
		var_01.groundorg = var_01.origin;
		if(var_01.indoors)
		{
			var_02 = var_01.origin;
			var_03 = var_01.origin + (0,0,-10000);
			var_04 = bullettrace(var_02,var_03,0);
			var_01.groundorg = var_04["position"];
		}

		wait 0.05;
	}
}

//Function Number: 8
schedulemoneydrops()
{
	var_00 = [];
	var_00[var_00.size] = 100;
	var_00[var_00.size] = 100;
	var_00[var_00.size] = 300;
	var_00[var_00.size] = 400;
	var_00[var_00.size] = 600;
	var_00[var_00.size] = 700;
	var_00[var_00.size] = 800;
	var_00[var_00.size] = 1000;
	level.zmmoneyschedule = common_scripts\utility::array_randomize(var_00);
	level.zmmoneyscheduleindex = 0;
}

//Function Number: 9
getnextmoneyamount()
{
	if(level.zmmoneyschedule.size == level.zmmoneyscheduleindex)
	{
		schedulemoneydrops();
	}

	var_00 = level.zmmoneyschedule[level.zmmoneyscheduleindex];
	level.zmmoneyscheduleindex++;
	return var_00;
}

//Function Number: 10
roundlogic()
{
	level.zmcarepackagelandingspots = common_scripts\utility::getstructarray("carepackageDropPosition","targetname");
	if(level.zmcarepackagelandingspots.size == 0)
	{
		return;
	}

	level.zmusedcarepackagelandingspots = [];
	level.getcratefordroptype = ::getcrate;
	level.zmkillstreakcrateprevo = 0;
	level.zmkillstreakcratereactvo = 0;
	level.zmkillstreakcratefirstvo = 0;
	thread setupdroppositions();
	thread schedulescorestreaks();
	thread schedulemoneydrops();
	var_00 = randomintrange(3,5);
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops))
		{
			continue;
		}

		while(level.wavecounter >= var_00)
		{
			var_01 = randomfloatrange(20,30);
			var_02 = level common_scripts\utility::waittill_notify_or_timeout_return("zombie_wave_ended",var_01);
			if(!isdefined(var_02) || var_02 != "timeout")
			{
				continue;
			}

			if(level.currentgen && isdefined(level.numzombierewarddrops) && level.numzombierewarddrops >= 4)
			{
				continue;
			}

			if(isdefined(level.nodroppodpenalty) && level.nodroppodpenalty == 1)
			{
				continue;
			}

			if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops))
			{
				continue;
			}

			var_02 = dropcarepackage();
			if(isdefined(var_02))
			{
				if(isdefined(level.roundsupplydrops))
				{
					level.roundsupplydrops[level.roundsupplydrops.size] = var_02;
				}

				if(level.players.size == 4)
				{
					var_02 = dropcarepackage();
					if(isdefined(var_02) && isdefined(level.roundsupplydrops))
					{
						level.roundsupplydrops[level.roundsupplydrops.size] = var_02;
					}
				}

				var_00 = var_00 + randomintrange(2,4);
			}
		}

		level waittill("zombie_wave_ended");
	}
}

//Function Number: 11
getcloseplayertodroppoint(param_00)
{
	var_01 = sortbydistance(level.players,param_00);
	return var_01[0];
}

//Function Number: 12
getcrate(param_00)
{
	if(level.zmscorestreaks.size == level.zmscorestreakindex)
	{
		schedulescorestreaks();
	}

	var_04 = level.zmscorestreaks[level.zmscorestreakindex];
	level.zmscorestreakindex++;
	return var_04;
}

//Function Number: 13
dropcarepackage(param_00)
{
	var_01 = getowner();
	if(!isdefined(var_01))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = getcratelandingspot(var_01);
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!param_00.indoors)
	{
		var_02 = maps\mp\killstreaks\_orbital_carepackage::firepod(level.ocp_weap_name,var_01,param_00,"zombies",[],undefined,undefined,undefined,0);
		if(isdefined(var_02) && !level.zmkillstreakcrateprevo)
		{
			var_01 = getcloseplayertodroppoint(param_00.origin);
			var_01 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("orbital_drop_pre");
			level.zmkillstreakcrateprevo = 1;
		}
		else if(isdefined(var_02) && isdefined(level.zmbcustomsupplydropvo))
		{
			[[ level.zmbcustomsupplydropvo ]]();
		}

		return var_02;
	}

	return dropcratephysics(var_02,var_01);
}

//Function Number: 14
dropcratephysics(param_00,param_01)
{
	var_02 = "airdrop_assault";
	var_03 = getcrate(var_02);
	var_04 = param_00 maps\mp\killstreaks\_airdrop::createairdropcrate(param_00,var_02,var_03,param_01.origin,undefined,0,1);
	var_04 physicslaunchserver((0,0,0));
	var_04 thread maps\mp\killstreaks\_orbital_carepackage::cratedetectstopphysics();
	var_04 maps\mp\killstreaks\_airdrop::physicswaiter(var_02,var_03);
	return var_03;
}

//Function Number: 15
getowner()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01))
		{
			return var_01;
		}
	}
}

//Function Number: 16
getcratelandingspot(param_00,param_01)
{
	var_02 = 2;
	var_03 = getvalidnodes();
	if(!isdefined(param_01))
	{
		param_01 = "carepackage";
	}

	if(var_03.size == 0)
	{
		level.zmusedcarepackagelandingspots = [];
		var_03 = getvalidnodes();
	}

	var_03 = common_scripts\utility::array_randomize(var_03);
	var_04 = undefined;
	var_05 = 0;
	foreach(var_07 in var_03)
	{
		if(closetomarker(var_07.origin,param_01))
		{
			continue;
		}

		if(var_05 >= var_02)
		{
			wait 0.05;
			var_05 = 0;
		}

		var_08 = carepackagetrace(var_07.groundorg,param_00,param_01);
		var_05++;
		if(var_08)
		{
			var_04 = var_07;
			break;
		}
	}

	if(isdefined(var_04))
	{
		level.zmusedcarepackagelandingspots[level.zmusedcarepackagelandingspots.size] = var_04;
		return var_04;
	}
}

//Function Number: 17
getvalidnodes()
{
	var_00 = [];
	foreach(var_02 in level.zmcarepackagelandingspots)
	{
		if(common_scripts\utility::array_contains(level.zmusedcarepackagelandingspots,var_02))
		{
			continue;
		}

		if(isdefined(var_02.script_noteworthy) && !common_scripts\utility::flag(var_02.script_noteworthy))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 18
getslotnumber(param_00)
{
	var_01 = undefined;
	var_02 = 2;
	var_03 = 5;
	for(var_04 = var_02;var_04 < var_03;var_04++)
	{
		var_05 = param_00.pers["killstreaks"][var_04];
		if(!isdefined(var_05) || !isdefined(var_05.streakname) || var_05.available == 0)
		{
			var_01 = var_04;
			break;
		}
	}

	return var_01;
}

//Function Number: 19
handlekillstreaklimit(param_00)
{
	if(!isdefined(getslotnumber(param_00)))
	{
		showstreaklimitreached(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 20
showstreaklimitreached(param_00)
{
	param_00 iprintlnbold(&"ZOMBIES_STREAK_LIMIT");
}

//Function Number: 21
closetomarker(param_00,param_01)
{
	var_02 = 26;
	var_03 = 41;
	if(param_01 == "goliath_suit")
	{
		var_04 = var_03;
	}
	else
	{
		var_04 = var_03;
	}

	foreach(var_06 in level.orbitaldropmarkers)
	{
		var_07 = var_04;
		if(var_06.orbitaltype == "goliath_suit")
		{
			var_07 = var_07 + var_03;
		}
		else
		{
			var_07 = var_07 + var_02;
		}

		var_08 = var_07 * var_07;
		var_09 = distance2dsquared(var_06.origin,param_00);
		if(var_09 < var_08)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 22
carepackagetrace(param_00,param_01,param_02)
{
	var_03 = 26;
	var_04 = 41;
	if(param_02 == "goliath_suit")
	{
		var_05 = var_04;
	}
	else
	{
		var_05 = var_04;
	}

	return capsuletracepassed(param_00 + (0,0,6),var_05,var_05 * 2,param_01,0);
}

//Function Number: 23
killstreakcratethink(param_00)
{
	self endon("death");
	if(!level.zmkillstreakcratereactvo)
	{
		var_01 = getcloseplayertodroppoint(self.origin);
		var_01 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("orbital_drop_react");
		level.zmkillstreakcratereactvo = 1;
	}

	self.owner = undefined;
	var_02 = maps\mp\killstreaks\_airdrop::getstreakforcrate(param_00,self.cratetype);
	var_03 = maps\mp\killstreaks\_airdrop::getmodulesforcrate(param_00,self.cratetype);
	var_04 = isdefined(self.owner) && self.owner maps\mp\_utility::_hasperk("specialty_highroller") || isdefined(self.moduleroll) && self.moduleroll;
	var_05 = undefined;
	if(var_04)
	{
		var_05 = &"MP_PACKAGE_REROLL";
	}

	var_06 = undefined;
	if(isdefined(game["strings"][param_00 + self.cratetype + "_hint"]))
	{
		var_06 = game["strings"][param_00 + self.cratetype + "_hint"];
	}
	else
	{
		var_06 = &"PLATFORM_GET_KILLSTREAK";
	}

	maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_06,var_05);
	maps\mp\killstreaks\_airdrop::cratesetupforuse("all",maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(var_02,var_03));
	thread crateothercapturethink();
	if(var_04)
	{
		thread maps\mp\killstreaks\_airdrop::crateownerdoubletapthink();
	}

	if(self.istrap)
	{
		maps\mp\killstreaks\_airdrop::cratetrapsetupkillcam();
	}

	for(;;)
	{
		self waittill("captured",var_01);
		var_07 = getslotnumber(var_01);
		var_02 = maps\mp\killstreaks\_airdrop::getstreakforcrate(param_00,self.cratetype);
		var_03 = maps\mp\killstreaks\_airdrop::getmodulesforcrate(param_00,self.cratetype);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				if(self.istrap)
				{
					var_01 thread maps\mp\killstreaks\_airdrop::detonatetrap(self,self.owner);
					return;
				}
				else
				{
					var_01 thread maps\mp\_events::hijackerevent(self.owner);
				}
			}
			else
			{
				self.owner thread maps\mp\_events::sharedevent();
			}
		}

		var_01 playlocalsound("orbital_pkg_use");
		if(!level.zmkillstreakcratefirstvo)
		{
			var_01 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("orbital_drop_1st_get");
			level.zmkillstreakcratefirstvo = 1;
		}
		else
		{
			var_01 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("ss_crate_capture");
		}

		var_01 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_02,undefined,undefined,var_03,var_07);
		var_01 thread maps\mp\killstreaks\_killstreaks::givekillstreak(var_02,0,0,var_01,var_03,var_07);
		if(isdefined(level.mapkillstreak) && level.mapkillstreak == self.cratetype)
		{
			var_01 thread maps\mp\_events::mapkillstreakevent();
		}

		var_08 = 1;
		var_09 = var_01 maps\mp\_utility::_hasperk("specialty_highroller") && !level.teambased || var_01.team != self.team;
		var_0A = isdefined(self.moduletrap) && self.moduletrap;
		var_0B = var_0A && self.owner == var_01 || level.teambased && var_01.team == self.team;
		if(var_09 || var_0B)
		{
			var_0C = var_01 maps\mp\killstreaks\_airdrop::createairdropcrate(var_01,"booby_trap","booby_trap",self.origin,self.angles);
			if(isdefined(var_0C.enemymodel))
			{
				var_0C.enemymodel thread maps\mp\killstreaks\_orbital_carepackage::orbitalanimate(1);
			}

			var_0C thread maps\mp\killstreaks\_airdrop::boobytrapcratethink(self);
			level thread maps\mp\killstreaks\_airdrop::droptimeout(var_0C,var_0C.owner,var_0C.cratetype);
			var_08 = 0;
			if(isdefined(var_0C.friendlymodel))
			{
				var_0C.friendlymodel solid();
			}

			if(isdefined(var_0C.enemymodel))
			{
				var_0C.enemymodel solid();
			}
		}

		maps\mp\killstreaks\_airdrop::deletecrate(var_08);
	}
}

//Function Number: 24
crateothercapturethink(param_00,param_01,param_02)
{
	self endon("captured");
	var_03 = self;
	if(isdefined(self.otherstringent))
	{
		var_03 = self.otherstringent;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2000;
	}

	if(level.currentgen)
	{
		if(isdefined(self.cratestringent))
		{
			var_03 = self.cratestringent;
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	while(isdefined(self))
	{
		var_03 waittill("trigger",var_04);
		if(isdefined(self.owner) && var_04 == self.owner)
		{
			continue;
		}

		if(!param_01 && handlekillstreaklimit(var_04))
		{
			continue;
		}

		if(var_04 isjumping() || isdefined(var_04.exo_hover_on) && var_04.exo_hover_on)
		{
			continue;
		}

		if(!var_04 isonground() && !maps\mp\killstreaks\_airdrop::waitplayerstuckoncarepackagereturn(var_04))
		{
			continue;
		}

		if(!maps\mp\killstreaks\_airdrop::validateopenconditions(var_04))
		{
			continue;
		}

		var_04.iscapturingcrate = 1;
		var_05 = maps\mp\killstreaks\_airdrop::createuseent();
		var_06 = 0;
		if(self.cratetype == "booby_trap")
		{
			var_06 = var_05 maps\mp\killstreaks\_airdrop::useholdthink(var_04,500,param_00);
		}
		else
		{
			var_06 = var_05 maps\mp\killstreaks\_airdrop::useholdthink(var_04,param_02,param_00);
		}

		if(isdefined(var_05))
		{
			var_05 delete();
		}

		if(!var_06)
		{
			if(isdefined(var_04))
			{
				var_04.iscapturingcrate = 0;
			}

			continue;
		}

		var_04.iscapturingcrate = 0;
		if(isdefined(level.numzombierewarddrops))
		{
			level.numzombierewarddrops--;
		}

		self notify("captured",var_04);
	}
}

//Function Number: 25
moneycratethink(param_00)
{
	self endon("death");
	self.owner = undefined;
	var_01 = undefined;
	if(isdefined(game["strings"][param_00 + self.cratetype + "_hint"]))
	{
		var_01 = game["strings"][param_00 + self.cratetype + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_01);
	maps\mp\killstreaks\_airdrop::cratesetupforuse("all","hud_carepkg_world_credits");
	thread crateothercapturethink(undefined,1);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("zmb_ss_credits_acquire");
		var_02 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("ss_money");
		var_03 = getnextmoneyamount();
		var_02 maps\mp\gametypes\zombies::givepointsforevent("crate",var_03,1);
		maps\mp\killstreaks\_airdrop::deletecrate(1);
	}
}

//Function Number: 26
modifydamagekillstreak(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02;
	if(isplayer(param_01) && isagent(param_00))
	{
		if(maps\mp\zombies\_util::is_true(self.resistanttosquadmatedamage))
		{
			return int(var_05 * 0.5);
		}
		else
		{
			return var_05 * level.wavecounter;
		}
	}

	switch(param_03)
	{
		case "killstreakmahem_mp":
		case "remote_energy_turret_mp":
		case "drone_assault_remote_turret_mp":
		case "ugv_missile_mp":
		case "sentry_minigun_mp":
			if(maps\mp\zombies\_util::istrapresistant())
			{
				var_05 = int(var_05 * 0.1);
			}
			else
			{
				var_05 = var_05 * 3;
			}
			break;

		case "turretheadmg_mp":
			var_05 = 200 + level.wavecounter * 10;
			break;

		case "turretheadrocket_mp":
			var_05 = 800 + level.wavecounter * randomintrange(50,75);
			break;

		case "turretheadenergy_mp":
			var_05 = var_05 * 3 + int(level.wavecounter / 2);
			break;

		case "iw5_exominigunzm_mp":
			if(isdefined(param_04) && param_04 == "MOD_MELEE_ALT" && !maps\mp\zombies\_util::instakillimmune())
			{
				var_05 = self.health + 1;
			}
			else if(isdefined(param_04) && param_04 == "MOD_MELEE_ALT")
			{
				var_05 = level.wavecounter * 50;
			}
			else
			{
				var_05 = 2000;
			}
			break;

		case "playermech_rocket_zm_mp":
			var_05 = 7000;
			break;

		case "iw5_juggernautrocketszm_mp":
			var_05 = 3500;
			break;

		default:
			break;
	}

	return var_05;
}
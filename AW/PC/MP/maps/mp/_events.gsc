/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_events.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 105
 * Decompile Time: 1681 ms
 * Timestamp: 10/27/2023 1:48:43 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getdvar("g_gametype");
	var_01 = 0;
	var_02 = [];
	var_02["dm"] = 4;
	var_02["war"] = 5;
	var_02["sd"] = 6;
	var_02["dom"] = 7;
	var_02["conf"] = 8;
	var_02["sr"] = 9;
	var_02["infect"] = 10;
	var_02["gun"] = 11;
	var_02["ctf"] = 12;
	var_02["horde"] = 13;
	var_02["twar"] = 14;
	var_02["hp"] = 15;
	var_02["ball"] = 16;
	for(;;)
	{
		if(!isdefined(var_02[var_00]))
		{
			var_00 = "war";
		}

		var_03 = tablelookupbyrow("mp/xp_event_table.csv",var_01,0);
		var_04 = tablelookupbyrow("mp/xp_event_table.csv",var_01,1);
		var_05 = tablelookupbyrow("mp/xp_event_table.csv",var_01,2);
		var_06 = tablelookupbyrow("mp/xp_event_table.csv",var_01,var_02[var_00]);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		if(var_03 == "win" || var_03 == "loss" || var_03 == "tie")
		{
			var_06 = float(var_06);
		}
		else
		{
			var_06 = int(var_06);
		}

		if(var_06 != -1)
		{
			var_05 = int(var_05);
			var_04 = int(var_04);
			maps\mp\gametypes\_rank::registerxpeventinfo(var_03,var_06,var_05,var_04);
		}

		var_01++;
	}

	level.numkills = 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.killedplayers = [];
		var_00.killedplayerscurrent = [];
		var_00.damagedplayers = [];
		var_00.killedby = [];
		var_00.lastkilledby = undefined;
		var_00.recentkillcount = 0;
		var_00.lastkilltime = 0;
		var_00.bulletstreak = 0;
		var_00.lastcoopstreaktime = 0;
	}
}

//Function Number: 3
killedplayer(param_00,param_01,param_02,param_03,param_04)
{
	level.numkills++;
	var_05 = param_01.guid;
	var_06 = param_01.pers["cur_kill_streak"];
	var_07 = self.guid;
	var_08 = gettime();
	if(maps\mp\_utility::isbulletdamage(param_03))
	{
		if(self.lastkilltime == var_08)
		{
			self.bulletstreak++;
		}
		else
		{
			self.bulletstreak = 1;
		}
	}
	else
	{
		self.bulletstreak = 0;
	}

	self.lastkilltime = gettime();
	self.lastkilledplayer = param_01;
	self.modifiers = [];
	self.damagedplayers[var_05] = undefined;
	thread updaterecentkills(param_00,param_02);
	if(!maps\mp\_utility::iskillstreakweapon(param_02))
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(isdefined(param_01.throwinggrenade))
		{
			var_09 = maps\mp\_utility::strip_suffix(param_01.throwinggrenade,"_lefthand");
			if(var_09 == "frag_grenade_mp")
			{
				self.modifiers["cooking"] = 1;
			}
		}

		if(weaponinventorytype(param_02) == "primary")
		{
			self.segments["killDistanceTotal"] = self.segments["killDistanceTotal"] + distance2d(self.origin,param_01.origin);
			self.segments["killDistanceCount"]++;
		}

		if(param_03 == "MOD_HEAD_SHOT")
		{
			headshotevent(param_00,param_02,param_03);
		}

		if(level.numkills == 1)
		{
			firstbloodevent(param_00,param_02,param_03);
		}

		if(level.teambased && var_08 - param_01.lastkilltime < 3000 && param_01.lastkilledplayer != self)
		{
			avengedplayerevent(param_00,param_02,param_03);
		}

		if(!isalive(self) && self != param_01 && isdefined(self.deathtime) && self.deathtime + 1200 < gettime())
		{
			postdeathkillevent(param_00);
		}

		if(self.pers["cur_death_streak"] > 3)
		{
			comebackevent(param_00,param_02,param_03);
		}

		if(isdefined(self.assistedsuicide) && self.assistedsuicide)
		{
			assistedsuicideevent(param_00,param_02,param_03);
		}

		if(islongshot(self,param_02,param_03,param_01))
		{
			longshotevent(param_00,param_02,param_03);
		}

		if(isresuce(param_01,var_08))
		{
			defendedplayerevent(param_00,param_02,param_03);
		}

		if(var_06 > 0 && isbuzzkillevent(param_01))
		{
			buzzkillevent(param_00,param_01,param_02,param_03);
		}

		if(isoneshotkill(param_01,param_02,param_03))
		{
			oneshotkillevent(param_00,param_02,param_03);
		}

		if(isdefined(self.lastkilledby) && self.lastkilledby == param_01)
		{
			revengeevent(param_00);
		}

		if(param_01.idflags & level.idflags_penetration)
		{
			bulletpenetrationevent(param_00,param_02);
		}

		if(ispointblank(param_01,param_03))
		{
			pointblankevent(param_00,param_02,param_03);
		}

		if(isdefined(param_02) && param_02 == "boost_slam_mp")
		{
			boostslamkillevent(param_00,param_02,param_03);
		}

		if(self.health < 20 && self.health > 0)
		{
			neardeathkillevent(param_02,param_03);
		}

		if(self.issiliding)
		{
			sprintslidekillevent(param_02,param_03);
		}

		if(isdefined(self.lastslidetime) && var_08 - self.lastslidetime < 2000)
		{
			camosprintslidekillevent(param_02,param_03);
		}

		if(common_scripts\utility::isflashed())
		{
			flashedkillevent(param_02,param_03);
		}

		if(isthinkfast(param_02,param_03))
		{
			thinkfastevent();
		}

		if(self.bulletstreak == 2)
		{
			multikillonebulletevent();
		}

		if(isbackstabevent(param_01,param_02,param_03))
		{
			backstabevent();
		}

		if(isthrowbackevent(param_01,param_02,param_03))
		{
			throwbackkillevent();
		}

		var_0A = undefined;
		if(maps\mp\_utility::isstrstart(param_02,"alt_"))
		{
			var_0A = getsubstr(param_02,4);
		}

		if(isdefined(self.pickedupweaponfrom[param_02]) && self.pickedupweaponfrom[param_02] == param_01 && !maps\mp\_utility::ismeleemod(param_03))
		{
			takeandkillevent();
		}
		else if(isdefined(var_0A) && isdefined(self.pickedupweaponfrom[var_0A]) && self.pickedupweaponfrom[var_0A] == param_01 && !maps\mp\_utility::ismeleemod(param_03))
		{
			takeandkillevent();
		}

		if(isdefined(param_02) && param_02 == "iw5_carrydrone_mp")
		{
			killwithballevent();
		}

		if(isdefined(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_ballcarrier") && !isdefined(param_01.weaponusagename) && param_01.weaponusagename == "iw5_dlcgun12loot9_mp")
		{
			killedballcarrierevent();
		}

		if(isdefined(self.exomostrecenttimedeciseconds["exo_dodge"]) && 20 > maps\mp\_utility::gettimepasseddecisecondsincludingrounds() - self.exomostrecenttimedeciseconds["exo_dodge"])
		{
			killafterdodgeevent(param_02);
		}

		checkhighjumpevents(param_01,param_00,param_02,param_03,param_04);
		checkhigherrankkillevents(param_01);
		checkweaponspecifickill(param_01,param_02,param_03);
	}

	checkstreakingevents(param_01);
	if(!isdefined(self.killedplayers[var_05]))
	{
		self.killedplayers[var_05] = 0;
	}

	if(!isdefined(self.killedplayerscurrent[var_05]))
	{
		self.killedplayerscurrent[var_05] = 0;
	}

	if(!isdefined(param_01.killedby[var_07]))
	{
		param_01.killedby[var_07] = 0;
	}

	self.killedplayers[var_05]++;
	self.killedplayerscurrent[var_05]++;
	param_01.killedby[var_07]++;
	param_01.lastkilledby = self;
}

//Function Number: 4
ispointblank(param_00,param_01)
{
	if(maps\mp\_utility::isbulletdamage(param_01))
	{
		var_02 = self.origin;
		var_03 = 9216;
		if(isdefined(param_00.attackerposition))
		{
			var_02 = param_00.attackerposition;
		}

		if(distancesquared(var_02,param_00.origin) < var_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
pointblankevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("pointblank",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("pointblank",self,param_01,undefined,param_02);
	if(isdefined(param_01))
	{
		var_03 = maps\mp\_utility::getbaseweaponname(param_01,1);
		if(maps\mp\_utility::islootweapon(var_03))
		{
			var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
		}

		var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_03);
		if(var_04 == "weapon_special" || var_04 == "weapon_shotgun" || var_04 == "weapon_pistol")
		{
			switch(var_03)
			{
				case "iw5_dlcgun4":
				case "iw5_dlcgun3":
					break;

				case "iw5_dlcgun8loot1":
					break;

				case "iw5_dlcgun13":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 6
killedplayerevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("kills",1);
	maps\mp\_utility::incpersstat("kills",1);
	self.kills = maps\mp\_utility::getpersstat("kills");
	maps\mp\gametypes\_persistence::statsetchild("round","kills",self.kills);
	maps\mp\_utility::updatepersratio("kdRatio","kills","deaths");
	var_03 = "kill";
	switch(param_01)
	{
		case "killstreak_orbital_laser_mp":
		case "orbital_laser_fov_mp":
			break;

		case "paint_missile_killstreak_mp":
		case "warbird_player_turret_mp":
		case "warbird_remote_turret_mp":
		case "warbird_missile_mp":
			break;

		case "orbitalsupport_small_turret_mp":
		case "orbitalsupport_medium_turret_mp":
		case "orbitalsupport_big_turret_mp":
		case "orbitalsupport_40mmbuddy_mp":
		case "orbitalsupport_40mm_mp":
		case "orbitalsupport_missile_mp":
		case "orbitalsupport_105mm_mp":
			break;

		case "airdrop_trap_explosive_mp":
			break;

		case "orbital_carepackage_pod_mp":
			break;

		case "remotemissile_projectile_secondary_mp":
		case "remotemissile_projectile_cluster_child_hellfire_mp":
		case "killstreak_strike_missile_gas_mp":
		case "remotemissile_projectile_cluster_child_mp":
		case "remotemissile_projectile_gas_mp":
		case "remotemissile_projectile_cluster_parent_mp":
		case "remotemissile_projectile_mp":
			break;

		case "iw5_dlcgun12loot3_mp":
		case "remote_turret_mp":
		case "killstreakmahem_mp":
		case "remote_energy_turret_mp":
		case "sentry_minigun_mp":
		case "turretheadmg_mp":
		case "turretheadrocket_mp":
		case "turretheadenergy_mp":
			break;

		case "airstrike_missile_mp":
		case "orbital_carepackage_pod_plane_mp":
		case "stealth_bomb_mp":
			break;

		case "assaultdrone_c4_mp":
		case "drone_assault_remote_turret_mp":
		case "ugv_missile_mp":
			break;

		case "playermech_rocket_mp":
		case "iw5_mechpunch_mp":
		case "iw5_exominigun_mp":
		case "iw5_exoxmgjugg_mp_akimbo":
		case "iw5_juggernautrockets_mp":
		case "juggernaut_sentry_mg_mp":
		case "killstreak_goliathsd_mp":
		case "orbital_carepackage_droppod_mp":
		case "iw5_juggtitan45_mp":
			break;

		case "iw5_dlcgun12loot2_mp":
		case "iw5_dlcgun12loot5_mp":
		case "mp_laser2_core":
		case "killstreak_comeback_mp":
		case "killstreak_terrace_mp":
		case "detroit_tram_turret_mp":
		case "dam_turret_mp":
		case "refraction_turret_mp":
		case "killstreak_solar_mp":
			break;
	}
}

//Function Number: 7
practicerounddialogvalid()
{
	return !isdefined(self.next_pr_dialog_time) || gettime() > self.next_pr_dialog_time;
}

//Function Number: 8
practicerounddialogplayed()
{
	self.next_pr_dialog_time = gettime() + randomintrange(20000,40000);
}

//Function Number: 9
practiceroundkillevent(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	self playlocalsound("ui_practice_round_kill");
	var_04 = 0.5;
	if(!isdefined(self.best_pr_kills))
	{
		self.best_pr_kills = self getcommonplayerdata("bests","kills");
	}

	if(self.best_pr_kills > 0 && self.kills > self.best_pr_kills)
	{
		practicerounddialogplayed();
		wait(var_04);
		maps\mp\_utility::leaderdialogonplayer("ptr_new_best");
		self.best_pr_kills = 0;
		return;
	}

	if(param_01 == "kill" && !maps\mp\_utility::ismeleemod(param_03))
	{
		if(param_03 == "MOD_HEAD_SHOT")
		{
			practicerounddialogplayed();
			wait(var_04);
			maps\mp\_utility::leaderdialogonplayer("ptr_headshot");
			return;
		}

		if(!practicerounddialogvalid())
		{
			return;
		}

		practicerounddialogplayed();
		wait(var_04);
		maps\mp\_utility::leaderdialogonplayer("ptr_greatshot");
		return;
	}
}

//Function Number: 10
practiceroundassistevent(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	var_01 = 0.5;
	practicerounddialogplayed();
	wait(var_01);
	maps\mp\_utility::leaderdialogonplayer("ptr_assist");
}

//Function Number: 11
isthinkfast(param_00,param_01)
{
	if(param_01 == "MOD_IMPACT" || param_01 == "MOD_HEAD_SHOT")
	{
		if(isthinkfastweapon(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
isthinkfastweapon(param_00)
{
	switch(param_00)
	{
		case "stun_grenade__mp":
		case "smoke_grenade_var_mp":
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
		case "smoke_grenade_mp":
		case "emp_grenade_mp":
		case "paint_grenade_mp":
		case "semtex_mp":
		case "frag_grenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 13
thinkfastevent()
{
	maps\mp\_utility::incplayerstat("think_fast",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("think_fast",self);
}

//Function Number: 14
boostslamkillevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("boostslamkill",1);
	thread maps\mp\gametypes\_missions::processchallenge("ch_limited_lookoutbelow",1);
	thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_hot",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("boostslamkill",self,param_01,undefined,param_02);
}

//Function Number: 15
earnedkillstreakevent(param_00,param_01,param_02,param_03)
{
	maps\mp\_utility::incplayerstat(param_00 + "_earned",1);
	level thread maps\mp\gametypes\_rank::awardgameevent(param_00 + "_earned",self);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(param_00,param_01,undefined,param_02,param_03);
	maps\mp\gametypes\_missions::processchallengedaily(22,param_00,undefined);
	maps\mp\gametypes\_missions::processchallengedaily(23,param_00,undefined);
	maps\mp\gametypes\_missions::processchallengedaily(32,param_00,undefined);
	maps\mp\gametypes\_missions::processchallengedaily(35,param_00,undefined);
}

//Function Number: 16
bulletpenetrationevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("bulletpenkills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("bulletpen",self);
	if(isdefined(param_01))
	{
		var_02 = maps\mp\_utility::getbaseweaponname(param_01,1);
		if(maps\mp\_utility::islootweapon(var_02))
		{
			var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
		}

		var_03 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_02);
		if(var_03 == "weapon_sniper")
		{
			if(isdefined(level.challengeinfo["ch_penetrate_" + var_02]))
			{
				maps\mp\gametypes\_missions::processchallenge("ch_penetrate_" + var_02);
			}
		}
	}

	maps\mp\gametypes\_missions::processchallenge("ch_boot_xray");
}

//Function Number: 17
multikillonebulletevent()
{
	maps\mp\_utility::incplayerstat("multiKillOneBullet",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("multiKillOneBullet",self);
}

//Function Number: 18
checkhighjumpevents(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04) && isdefined(param_04.ch_crossbow_player_jumping))
	{
		var_05 = param_04.ch_crossbow_player_jumping;
	}
	else
	{
		var_05 = self ishighjumping();
	}

	if(isdefined(param_04) && isdefined(param_04.ch_crossbow_victim_jumping))
	{
		var_06 = param_04.ch_crossbow_victim_jumping;
	}
	else
	{
		var_06 = param_01 ishighjumping();
	}

	if(var_05 && var_06)
	{
		airtoairevent(param_01,param_02,param_03);
	}

	if(var_05 && !var_06)
	{
		airtogroundevent(param_01,param_02,param_03);
	}

	if(!var_05 && var_06)
	{
		groundtoairevent(param_01,param_02,param_03);
	}
}

//Function Number: 19
checkweaponspecifickill(param_00,param_01,param_02)
{
	if(maps\mp\gametypes\_weapons::isriotshield(param_01) || param_01 == maps\mp\_exo_shield::get_exo_shield_weapon())
	{
		riotshieldkillevent(param_01,param_02);
	}

	if(issubstr(param_01,"exoknife_mp"))
	{
		exoknifekillevent(param_01,param_02,param_00);
	}
}

//Function Number: 20
exoknifekillevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("exo_knife_kill",1);
	if(isdefined(param_02.wasrecall) && param_02.wasrecall)
	{
		maps\mp\_utility::incplayerstat("exo_knife_recall_kill",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("exo_knife_recall_kill",self,param_00,undefined,param_01);
		maps\mp\gametypes\_missions::processchallenge("ch_humiliation_boomerang");
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent("exo_knife_kill",self,param_00,undefined,param_01);
}

//Function Number: 21
neardeathkillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("near_death_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("near_death_kill",self,param_00,undefined,param_01);
}

//Function Number: 22
sprintslidekillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("slide_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("slide_kill",self,param_00,undefined,param_01);
}

//Function Number: 23
flashedkillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("flash_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("flash_kill",self,param_00,undefined,param_01);
}

//Function Number: 24
riotshieldkillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("riot_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("riot_kill",self,param_00,undefined,param_01);
}

//Function Number: 25
airtoairevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("air_to_air_kill",1);
	thread maps\mp\gametypes\_missions::processchallenge("ch_limited_acepilot",1);
	thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_redbaron",1);
	var_03 = maps\mp\_utility::getbaseweaponname(param_01,1);
	if(maps\mp\_utility::islootweapon(var_03))
	{
		var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_03);
	if(maps\mp\_utility::ismeleemod(param_02))
	{
		maps\mp\_utility::incplayerstat("melee_air_to_air",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("melee_air_to_air",self,param_01,undefined,param_02);
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent("air_to_air_kill",self,param_01,undefined,param_02);
	if(var_04 == "weapon_smg" || var_04 == "weapon_shotgun")
	{
		switch(var_03)
		{
			case "iw5_dlcgun4":
				break;

			case "iw5_dlcgun8loot1":
				break;

			case "iw5_dlcgun18":
				break;

			case "iw5_dlcgun28":
				break;

			case "iw5_dlcgun38":
				break;

			default:
				break;
		}
	}
}

//Function Number: 26
airtogroundevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("air_to_ground_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("air_to_ground_kill",self,param_01,undefined,param_02);
	thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_buzz");
	var_03 = maps\mp\_utility::getbaseweaponname(param_01,1);
	if(maps\mp\_utility::islootweapon(var_03))
	{
		var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_03);
	if(var_04 == "weapon_assault" || var_04 == "weapon_heavy" || issubstr(param_01,"exocrossbow"))
	{
		switch(var_03)
		{
			case "iw5_dlcgun1":
			case "iw5_dlcgun2":
				break;

			case "iw5_dlcgun6":
				break;

			case "iw5_dlcgun7loot0":
				break;

			case "iw5_dlcgun7loot6":
				break;

			case "iw5_dlcgun23":
				break;

			case "iw5_dlcgun33":
				break;

			default:
				break;
		}
	}
}

//Function Number: 27
groundtoairevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("ground_to_air_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("ground_to_air_kill",self,param_01,undefined,param_02);
	thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_pull");
	var_03 = maps\mp\_utility::getbaseweaponname(param_01,1);
	if(maps\mp\_utility::islootweapon(var_03))
	{
		var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_03);
	if(var_04 == "weapon_heavy" || issubstr(param_01,"exocrossbow"))
	{
		switch(var_03)
		{
			case "iw5_dlcgun2":
				break;

			default:
				break;
		}
	}
}

//Function Number: 28
isoneshotkill(param_00,param_01,param_02)
{
	if(param_00.attackers.size != 1)
	{
		return 0;
	}

	if(!isdefined(param_00.attackers[self.guid]))
	{
		return 0;
	}

	if(maps\mp\_utility::ismeleemod(param_02))
	{
		return 0;
	}

	if(gettime() != param_00.attackerdata[self.guid].firsttimedamaged)
	{
		return 0;
	}

	var_03 = maps\mp\_utility::getweaponclass(param_01);
	if(var_03 == "weapon_sniper" || var_03 == "weapon_shotgun")
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
islongshot(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03.agentbody))
	{
		return 0;
	}

	var_04 = self.origin;
	if(isdefined(param_03.attackerposition))
	{
		var_04 = param_03.attackerposition;
	}

	if(isalive(param_00) && !param_00 maps\mp\_utility::isusingremote() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" || issubstr(param_01,"exoknife_mp") || issubstr(param_01,"exocrossbow") || issubstr(param_01,"m990") && !maps\mp\_utility::iskillstreakweapon(param_01) && !isdefined(param_00.assistedsuicide))
	{
		var_05 = maps\mp\_utility::getweaponclass(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				break;

			case "weapon_smg":
				break;

			case "weapon_heavy":
			case "weapon_assault":
				break;

			case "weapon_sniper":
				break;

			case "weapon_shotgun":
				break;

			case "weapon_projectile":
			default:
				break;
		}
	}
}

//Function Number: 30
isresuce(param_00,param_01)
{
	if(!level.teambased)
	{
		return 0;
	}

	foreach(var_04, var_03 in param_00.damagedplayers)
	{
		if(var_04 != self.guid && param_01 - var_03 < 500)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
longshotevent(param_00,param_01,param_02)
{
	self.modifiers["longshot"] = 1;
	maps\mp\_utility::incplayerstat("longshots",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("longshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"longshot");
}

//Function Number: 32
headshotevent(param_00,param_01,param_02)
{
	self.modifiers["headshot"] = 1;
	maps\mp\_utility::incpersstat("headshots",1);
	maps\mp\_utility::incplayerstat("headshots",1);
	maps\mp\gametypes\_persistence::statsetchild("round","headshots",maps\mp\_utility::clamptoshort(self.pers["headshots"]));
	self.headshots = maps\mp\_utility::getpersstat("headshots");
	level thread maps\mp\gametypes\_rank::awardgameevent("headshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"headshot");
	maps\mp\gametypes\_missions::processchallenge("ch_limited_headhunter");
}

//Function Number: 33
isthrowbackevent(param_00,param_01,param_02)
{
	if(!isexplosivedamagemod(param_02))
	{
		return 0;
	}

	if(!maps\mp\_utility::isstrstart(param_01,"frag_"))
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_00.explosiveinfo) && isdefined(param_00.explosiveinfo["throwbackKill"]) && param_00.explosiveinfo["throwbackKill"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
throwbackkillevent()
{
	maps\mp\_utility::incplayerstat("throwback_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("throwback_kill",self);
}

//Function Number: 35
fourplayevent()
{
	maps\mp\_utility::incplayerstat("four_play",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("four_play",self);
}

//Function Number: 36
avengedplayerevent(param_00,param_01,param_02)
{
	self.modifiers["avenger"] = 1;
	maps\mp\_utility::incplayerstat("avengekills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("avenger",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"avenger");
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_avenger");
}

//Function Number: 37
assistedsuicideevent(param_00,param_01,param_02)
{
	self.modifiers["assistedsuicide"] = 1;
	maps\mp\_utility::incplayerstat("assistedsuicide",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("assistedsuicide",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"assistedsuicide");
}

//Function Number: 38
defendedplayerevent(param_00,param_01,param_02)
{
	self.modifiers["defender"] = 1;
	maps\mp\_utility::incplayerstat("rescues",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("defender",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"defender");
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_savior");
}

//Function Number: 39
defendobjectiveevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("defends",1);
	maps\mp\_utility::incpersstat("defends",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defends",self.pers["defends"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("defend",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"assaulting");
}

//Function Number: 40
assaultobjectiveevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("assault",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("assault",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"defending");
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_attacker");
	maps\mp\gametypes\_missions::processchallengedaily(7,undefined,undefined);
}

//Function Number: 41
postdeathkillevent(param_00)
{
	self.modifiers["posthumous"] = 1;
	maps\mp\_utility::incplayerstat("posthumous",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("posthumous",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"posthumous");
	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_afterlife");
}

//Function Number: 42
isbackstabevent(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::ismeleemod(param_02))
	{
		return 0;
	}

	if(maps\mp\gametypes\_weapons::isriotshield(param_01) || param_01 == maps\mp\_exo_shield::get_exo_shield_weapon())
	{
		return 0;
	}

	var_03 = param_00 getplayerangles();
	var_04 = self getplayerangles();
	var_05 = angleclamp180(var_03[1] - var_04[1]);
	if(abs(var_05) < 75)
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
backstabevent(param_00)
{
	maps\mp\_utility::incplayerstat("backstab",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("backstab",self);
	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backstab");
}

//Function Number: 44
revengeevent(param_00)
{
	self.modifiers["revenge"] = 1;
	self.lastkilledby = undefined;
	maps\mp\_utility::incplayerstat("revengekills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("revenge",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"revenge");
	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_revenge");
}

//Function Number: 45
multikillevent(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_02);
	var_05 = maps\mp\_utility::getbaseweaponname(param_02,1);
	if(maps\mp\_utility::islootweapon(var_05))
	{
		var_05 = maps\mp\gametypes\_class::getbasefromlootversion(var_05);
	}

	var_06 = "";
	if(common_scripts\utility::string_starts_with(var_05,"iw5_"))
	{
		var_06 = getsubstr(var_05,4);
	}

	switch(param_01)
	{
		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		default:
			break;
	}
}

//Function Number: 46
takeandkillevent()
{
	maps\mp\_utility::incplayerstat("take_and_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("take_and_kill",self);
	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backfire");
}

//Function Number: 47
killedballcarrierevent()
{
	maps\mp\_utility::incplayerstat("killedBallCarrier",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("killedBallCarrier",self);
}

//Function Number: 48
setuplinkstats()
{
	var_00 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
	maps\mp\gametypes\_persistence::statsetchild("round","captures",var_00);
	maps\mp\_utility::setextrascore0(var_00);
}

//Function Number: 49
touchdownevent(param_00)
{
	thread maps\mp\_utility::teamplayercardsplash("callout_touchdown",self,undefined,param_00);
	maps\mp\_utility::incplayerstat("touchdown",1);
	setuplinkstats();
	level thread maps\mp\gametypes\_rank::awardgameevent("touchdown",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_touchdown");
	maps\mp\gametypes\_missions::processchallengedaily(13,param_00,undefined);
}

//Function Number: 50
fieldgoalevent(param_00)
{
	thread maps\mp\_utility::teamplayercardsplash("callout_fieldgoal",self,undefined,param_00);
	maps\mp\_utility::incplayerstat("fieldgoal",1);
	setuplinkstats();
	level thread maps\mp\gametypes\_rank::awardgameevent("fieldgoal",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_fieldgoal");
	maps\mp\gametypes\_missions::processchallengedaily(13,param_00,undefined);
}

//Function Number: 51
interceptionevent()
{
	maps\mp\_utility::incplayerstat("interception",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("interception",self);
}

//Function Number: 52
killwithballevent()
{
	maps\mp\_utility::incplayerstat("kill_with_ball",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_ball",self);
}

//Function Number: 53
ballscoreassistevent()
{
	maps\mp\_utility::incplayerstat("ball_score_assist",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("ball_score_assist",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_assist");
}

//Function Number: 54
passkillpickupevent()
{
	maps\mp\_utility::incplayerstat("pass_kill_pickup",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("pass_kill_pickup",self);
}

//Function Number: 55
flagpickupevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup",self);
	maps\mp\_utility::incplayerstat("flagscarried",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_pickup",self);
	thread maps\mp\_matchdata::loggameevent("pickup",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_carry");
}

//Function Number: 56
flagcaptureevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture",self);
	maps\mp\_utility::incplayerstat("flagscaptured",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_capture",self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_capture");
	maps\mp\gametypes\_missions::processchallengedaily(16,undefined,undefined);
}

//Function Number: 57
flagreturnevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn",self);
	maps\mp\_utility::incplayerstat("flagsreturned",1);
	maps\mp\_utility::incpersstat("returns",1);
	self.assists = self.pers["returns"];
	maps\mp\gametypes\_persistence::statsetchild("round","returns",self.pers["returns"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_return",self);
	thread maps\mp\_matchdata::loggameevent("return",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_return");
	maps\mp\gametypes\_missions::processchallengedaily(17,undefined,undefined);
}

//Function Number: 58
killwithflagevent()
{
	maps\mp\_utility::incplayerstat("killsasflagcarrier",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_flag",self);
}

//Function Number: 59
killflagcarrierevent(param_00)
{
	thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier",self);
	maps\mp\_utility::incplayerstat("flagcarrierkills",1);
	maps\mp\_utility::incpersstat("defends",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defends",self.pers["defends"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_flag_carrier",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"carrying");
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_defend");
}

//Function Number: 60
killdeniedevent(param_00)
{
	maps\mp\_utility::incplayerstat("killsdenied",1);
	maps\mp\_utility::incpersstat("denied",1);
	maps\mp\_utility::setextrascore1(self.pers["denied"]);
	maps\mp\gametypes\_persistence::statsetchild("round","denied",self.pers["denied"]);
	var_01 = "kill_denied";
	if(param_00)
	{
		var_01 = "kill_denied_retrieved";
		maps\mp\_utility::incplayerstat("kill_denied_retrieved",1);
		maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_save_yourself");
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_01,self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_denial");
	maps\mp\gametypes\_missions::processchallengedaily(21,undefined,undefined);
}

//Function Number: 61
killconfirmedevent()
{
	maps\mp\_utility::incplayerstat("killsconfirmed",1);
	maps\mp\_utility::incpersstat("confirmed",1);
	maps\mp\_utility::setextrascore0(self.pers["confirmed"]);
	maps\mp\gametypes\_persistence::statsetchild("round","confirmed",self.pers["confirmed"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_confirmed",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_collector");
	maps\mp\gametypes\_missions::processchallengedaily(4,undefined,undefined);
}

//Function Number: 62
tagcollectorevent()
{
	maps\mp\_utility::incplayerstat("tag_collector",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("tag_collector",self);
}

//Function Number: 63
monitortagcollector(param_00)
{
	if(!isplayer(param_00))
	{
		return;
	}

	param_00 notify("tagCollector");
	param_00 endon("tagCollector");
	if(!isdefined(param_00.tagcollectortotal))
	{
		param_00.tagcollectortotal = 0;
	}

	param_00.tagcollectortotal++;
	if(param_00.tagcollectortotal > 2)
	{
		param_00 tagcollectorevent();
		param_00.tagcollectortotal = 0;
	}

	wait(2.5);
	param_00.tagcollectortotal = 0;
}

//Function Number: 64
bombplantevent()
{
	maps\mp\_utility::incplayerstat("bombsplanted",1);
	maps\mp\_utility::incpersstat("plants",1);
	maps\mp\gametypes\_persistence::statsetchild("round","plants",self.pers["plants"]);
	maps\mp\_utility::setextrascore0(self.pers["plants"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("plant",self);
	thread maps\mp\_matchdata::loggameevent("plant",self.origin);
}

//Function Number: 65
bombdefuseevent(param_00)
{
	maps\mp\_utility::incplayerstat("bombsdefused",1);
	maps\mp\_utility::incpersstat("defuses",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defuses",self.pers["defuses"]);
	maps\mp\_utility::setextrascore1(self.pers["defuses"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused",self);
	if(param_00 == "ninja_defuse" || param_00 == "last_man_defuse")
	{
		maps\mp\_utility::incplayerstat(param_00,1);
		if(param_00 == "last_man_defuse")
		{
			maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_ninja");
		}
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(param_00,self);
	thread maps\mp\_matchdata::loggameevent("defuse",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_bombdefuse");
}

//Function Number: 66
eliminateplayerevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("elimination",1);
	level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated",param_01);
	if(param_00)
	{
		maps\mp\_utility::incplayerstat("last_man_standing",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("last_man_standing",self);
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent("elimination",self);
}

//Function Number: 67
revivetagevent(param_00)
{
	maps\mp\_utility::incplayerstat("sr_tag_revive",1);
	maps\mp\_utility::incplayerstat("killsdenied",1);
	maps\mp\_utility::incpersstat("denied",1);
	maps\mp\gametypes\_persistence::statsetchild("round","denied",self.pers["denied"]);
	self.assists = self.pers["denied"];
	level thread maps\mp\_utility::teamplayercardsplash("callout_tag_revive",param_00);
	level thread maps\mp\gametypes\_rank::awardgameevent("sr_tag_revive",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_medic");
}

//Function Number: 68
eliminatetagevent()
{
	maps\mp\_utility::incplayerstat("sr_tag_elimination",1);
	maps\mp\_utility::incplayerstat("killsconfirmed",1);
	maps\mp\_utility::incpersstat("confirmed",1);
	maps\mp\gametypes\_persistence::statsetchild("round","confirmed",self.pers["confirmed"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("sr_tag_elimination",self);
}

//Function Number: 69
bombdetonateevent()
{
	maps\mp\_utility::incplayerstat("targetsdestroyed",1);
	maps\mp\_utility::incpersstat("destructions",1);
	maps\mp\gametypes\_persistence::statsetchild("round","destructions",self.pers["destructions"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("destroy",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_destroyer");
}

//Function Number: 70
increasegunlevelevent()
{
	maps\mp\_utility::incplayerstat("levelup",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("gained_gun_score",self);
}

//Function Number: 71
decreasegunlevelevent()
{
	maps\mp\_utility::incplayerstat("dejavu",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_gun_score",self);
}

//Function Number: 72
setbackenemygunlevelevent()
{
	maps\mp\_utility::incplayerstat("humiliation",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_enemy_gun_rank",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_regression");
}

//Function Number: 73
quickgunlevelevent()
{
	maps\mp\_utility::incplayerstat("gunslinger",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("quick_gun_rank",self);
}

//Function Number: 74
setbackfirstplayergunlevelevent()
{
	maps\mp\_utility::incplayerstat("regicide",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_first_player_gun_rank",self);
}

//Function Number: 75
firstinfectedevent()
{
	maps\mp\_utility::incplayerstat("patientzero",1);
	maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
	level thread maps\mp\_utility::teamplayercardsplash("callout_first_infected",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("first_infected",self);
	self.patient_zero = 0;
}

//Function Number: 76
finalsurvivorevent()
{
	maps\mp\_utility::incplayerstat("omegaman",1);
	maps\mp\_utility::playsoundonplayers("mp_obj_captured");
	level thread maps\mp\_utility::teamplayercardsplash("callout_final_survivor",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("final_survivor",self);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_survivor");
}

//Function Number: 77
gotinfectedevent()
{
	maps\mp\_utility::incplayerstat("careless",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("got_infected",self);
}

//Function Number: 78
plagueevent()
{
	maps\mp\_utility::incplayerstat("plague",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("infected_plague",self);
}

//Function Number: 79
infectedsurvivorevent()
{
	maps\mp\_utility::incplayerstat("contagious",1);
	level thread maps\mp\_utility::teamplayercardsplash("callout_infected_survivor",self,"axis");
	level thread maps\mp\gametypes\_rank::awardgameevent("infected_survivor",self);
}

//Function Number: 80
survivorevent()
{
	maps\mp\_utility::incplayerstat("survivor",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("survivor",self);
}

//Function Number: 81
domcaptureevent(param_00)
{
	maps\mp\_utility::incplayerstat("pointscaptured",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	var_01 = "capture";
	if(param_00)
	{
		var_01 = "opening_move";
		maps\mp\_utility::incplayerstat("opening_move",1);
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_01,self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
	maps\mp\gametypes\_missions::processchallengedaily(6,undefined,undefined);
}

//Function Number: 82
domneutralizeevent()
{
	level thread maps\mp\gametypes\_rank::awardgameevent("neutralize",self);
}

//Function Number: 83
killwhilecapture(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("assault",1);
	maps\mp\_utility::incplayerstat("kill_while_capture",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_while_capture",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"defending");
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_defender");
}

//Function Number: 84
securehardpointevent()
{
	maps\mp\_utility::incplayerstat("hp_secure",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("hp_secure",self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
	maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

//Function Number: 85
firstbloodevent(param_00,param_01,param_02)
{
	self.modifiers["firstblood"] = 1;
	maps\mp\_utility::incplayerstat("firstblood",1);
	thread maps\mp\_utility::teamplayercardsplash("callout_firstblood",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("firstblood",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"firstblood");
}

//Function Number: 86
isbuzzkillevent(param_00)
{
	foreach(var_02 in param_00.killstreaks)
	{
		if(maps\mp\killstreaks\_killstreaks::issupportstreak(param_00,var_02))
		{
			continue;
		}

		var_03 = maps\mp\killstreaks\_killstreaks::getstreakcost(var_02);
		var_04 = param_00.adrenaline;
		if(var_03 < var_04)
		{
			continue;
		}

		if(var_03 - var_04 < 101)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 87
buzzkillevent(param_00,param_01,param_02,param_03)
{
	self.modifiers["buzzkill"] = param_01.pers["cur_kill_streak"];
	maps\mp\_utility::incplayerstat("buzzkill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("buzzkill",self,param_02,undefined,param_03);
	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_buzzkill");
}

//Function Number: 88
oneshotkillevent(param_00,param_01,param_02)
{
	self.modifiers["oneshotkill"] = 1;
	maps\mp\_utility::incplayerstat("oneshotkill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("oneshotkill",self,param_01,undefined,param_02);
	maps\mp\gametypes\_missions::processchallenge("ch_limited_deadeye");
	var_03 = maps\mp\_utility::getbaseweaponname(param_01,1);
	if(maps\mp\_utility::islootweapon(var_03))
	{
		var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_01,var_03);
	if(var_04 == "weapon_shotgun")
	{
		switch(var_03)
		{
			case "iw5_dlcgun4":
				break;

			case "iw5_dlcgun8loot1":
				break;

			default:
				break;
		}
	}
}

//Function Number: 89
comebackevent(param_00,param_01,param_02)
{
	self.modifiers["comeback"] = 1;
	maps\mp\_utility::incplayerstat("comebacks",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("comeback",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"comeback");
}

//Function Number: 90
semtexstickevent(param_00)
{
	maps\mp\_utility::incplayerstat("semtex_stick",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("semtex_stick",self);
	param_00 maps\mp\_utility::incplayerstat("stuck_with_explosive",1);
	if(!isdefined(level.iszombiegame) && level.iszombiegame == 1)
	{
		level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive",param_00);
	}

	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
	self notify("increment_stuck_kills");
}

//Function Number: 91
crossbowstickevent(param_00)
{
	maps\mp\_utility::incplayerstat("crossbow_stick",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("crossbow_stick",self);
	param_00 maps\mp\_utility::incplayerstat("stuck_with_explosive",1);
	if(!isdefined(level.iszombiegame) && level.iszombiegame == 1)
	{
		level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive",param_00);
	}

	maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
	self notify("increment_stuck_kills");
}

//Function Number: 92
disconnected()
{
	var_00 = self.guid;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(isdefined(level.players[var_01].killedplayers[var_00]))
		{
			level.players[var_01].killedplayers[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].killedplayerscurrent[var_00]))
		{
			level.players[var_01].killedplayerscurrent[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].killedby[var_00]))
		{
			level.players[var_01].killedby[var_00] = undefined;
		}
	}
}

//Function Number: 93
updaterecentkills(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	var_02 = 0;
	if(self playerads() >= 0.2)
	{
		var_02 = 1;
	}

	wait(2);
	if(self.recentkillcount > 1)
	{
		multikillevent(param_00,self.recentkillcount,param_01,var_02);
	}

	self.recentkillcount = 0;
}

//Function Number: 94
hijackerevent(param_00)
{
	maps\mp\_utility::incplayerstat("hijacker",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("hijacker",self);
	thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
	if(isdefined(param_00))
	{
		param_00 maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_airdrop",self);
	}
}

//Function Number: 95
sharedevent()
{
	maps\mp\_utility::incplayerstat("sharepackage",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("sharepackage",self);
}

//Function Number: 96
mapkillstreakevent()
{
	var_00 = getmatchdata("players",self.clientid,"numberOfMapstreaksReceived");
	var_00++;
	setmatchdata("players",self.clientid,"numberOfMapstreaksReceived",maps\mp\_utility::clamptobyte(var_00));
	maps\mp\_utility::incplayerstat("map_killstreak",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("map_killstreak",self);
}

//Function Number: 97
killstreaktagevent()
{
	maps\mp\_utility::incplayerstat("killstreak_tag",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("killstreak_tag",self);
}

//Function Number: 98
killstreakjoinevent()
{
	var_00 = gettime();
	var_01 = self.lastcoopstreaktime + 10000;
	if(var_01 > var_00)
	{
		return;
	}

	self.lastcoopstreaktime = var_00;
	maps\mp\_utility::incplayerstat("killstreak_join",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("killstreak_join",self);
}

//Function Number: 99
checkvandalismmedal(param_00)
{
	if(isdefined(level.ishorde))
	{
		return;
	}

	if(!isdefined(self.attackerlist))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_01 = self.owner;
	if(!isdefined(var_01))
	{
		var_01 = self;
	}

	foreach(var_03 in self.attackerlist)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == var_01)
		{
			continue;
		}

		if(var_03 == param_00)
		{
			continue;
		}

		if(var_03.team == self.team)
		{
			continue;
		}

		var_03 maps\mp\_utility::incplayerstat("assist_killstreak_destroyed",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("assist_killstreak_destroyed",var_03);
	}
}

//Function Number: 100
checkstreakingevents(param_00)
{
	var_01 = self.killstreakcount + 1;
	if(var_01 % 5 && var_01 < 30)
	{
		return;
	}

	switch(var_01)
	{
		case 5:
			break;

		case 10:
			break;

		case 15:
			break;

		case 20:
			break;

		case 25:
			break;

		case 30:
			break;

		default:
			break;
	}
}

//Function Number: 101
checkhigherrankkillevents(param_00)
{
	if(maps\mp\_utility::gettimepassed() < 90000)
	{
		return;
	}

	var_01 = level.players;
	if(level.teambased)
	{
		var_01 = level.teamlist[maps\mp\_utility::getotherteam(self.team)];
	}

	if(var_01.size < 3)
	{
		return;
	}

	var_02 = common_scripts\utility::array_sort_with_func(var_01,::is_score_a_greater_than_b);
	if(isdefined(var_02[0]) && param_00 == var_02[0])
	{
		maps\mp\_utility::incplayerstat("firstplacekill",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("firstplacekill",self);
		maps\mp\gametypes\_missions::processchallenge("ch_precision_highvalue");
	}
}

//Function Number: 102
is_score_a_greater_than_b(param_00,param_01)
{
	return param_00.score > param_01.score;
}

//Function Number: 103
processassistevent(param_00,param_01)
{
	if(isdefined(level.assists_disabled) && level.assists_disabled)
	{
		return;
	}

	var_02 = "assist";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self endon("disconnect");
	param_00 endon("disconnect");
	wait(0.05);
	if(self.team != "axis" && self.team != "allies")
	{
		return;
	}

	if(self.team == param_00.team)
	{
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_02,self,undefined,param_00);
	param_00 maps\mp\_matchdata::logspecialassists(self,var_02);
	if(var_02 == "assist" || var_02 == "assist_riot_shield")
	{
		maps\mp\_utility::incplayerstat("assists",1);
		maps\mp\_utility::incpersstat("assists",1);
		self.assists = maps\mp\_utility::getpersstat("assists");
		if(var_02 == "assist_riot_shield")
		{
			maps\mp\_utility::incplayerstat("assist_riot_shield",1);
		}

		maps\mp\gametypes\_persistence::statsetchild("round","assists",self.assists);
		thread maps\mp\gametypes\_missions::playerassist();
		if(level.practiceround)
		{
			thread practiceroundassistevent(param_00);
		}
	}
}

//Function Number: 104
killafterdodgeevent(param_00)
{
	maps\mp\gametypes\_missions::processchallenge("ch_exomech_evasive");
	maps\mp\gametypes\_missions::processchallengedaily(34,undefined,undefined);
	if(isdefined(param_00))
	{
		var_01 = maps\mp\_utility::getbaseweaponname(param_00,1);
		if(maps\mp\_utility::islootweapon(var_01))
		{
			var_01 = maps\mp\gametypes\_class::getbasefromlootversion(var_01);
		}

		var_02 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_00,var_01);
		if(var_02 == "weapon_assault" || var_02 == "weapon_pistol" || var_02 == "weapon_special")
		{
			switch(var_01)
			{
				case "iw5_dlcgun3":
				case "iw5_dlcgun1":
					break;

				case "iw5_dlcgun6":
					break;

				case "iw5_dlcgun7loot0":
					break;

				case "iw5_dlcgun7loot6":
					break;

				case "iw5_dlcgun13":
					break;

				case "iw5_dlcgun23":
					break;

				case "iw5_dlcgun33":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 105
camosprintslidekillevent(param_00,param_01)
{
	var_02 = maps\mp\_utility::getbaseweaponname(param_00,1);
	if(maps\mp\_utility::islootweapon(var_02))
	{
		var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
	}

	var_03 = maps\mp\gametypes\_missions::get_challenge_weapon_class(param_00,var_02);
	switch(var_03)
	{
		case "weapon_pistol":
		case "weapon_special":
		case "weapon_shotgun":
		case "weapon_smg":
			break;
	}
}
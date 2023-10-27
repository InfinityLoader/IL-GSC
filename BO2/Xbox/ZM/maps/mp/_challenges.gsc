/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_challenges.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 87
 * Decompile Time: 172 ms
 * Timestamp: 10/27/2023 3:06:25 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	if(!(IsDefined(level.challengescallbacks)))
	{
		level.challengescallbacks = [];
	}

	waittillframeend;
	if(canprocesschallenges())
	{
		registerchallengescallback("playerKilled",::challengekills);
		registerchallengescallback("gameEnd",::challengegameend);
		registerchallengescallback("roundEnd",::challengeroundend);
	}

	level thread onplayerconnect();
	foreach(team in level.teams)
	{
		initteamchallenges(team);
	}
}

//Function Number: 2
addflyswatterstat(weapon,aircraft)
{
	if(!(IsDefined(self.pers["flyswattercount"])))
	{
		self.pers["flyswattercount"] = 0;
	}

	self addweaponstat(weapon,"destroyed_aircraft",1);
	self.pers["flyswattercount"]++;
	if(self.pers["flyswattercount"] == 5)
	{
		self addweaponstat(weapon,"destroyed_5_aircraft",1);
	}

	if(IsDefined(aircraft) && IsDefined(aircraft.birthtime))
	{
		if(GetTime() - aircraft.birthtime < 20000)
		{
			self addweaponstat(weapon,"destroyed_aircraft_under20s",1);
		}
	}

	if(!(IsDefined(self.destroyedaircrafttime)))
	{
		self.destroyedaircrafttime = [];
	}

	if(IsDefined(self.destroyedaircrafttime[weapon]) && GetTime() - self.destroyedaircrafttime[weapon] < 10000)
	{
		self addweaponstat(weapon,"destroyed_2aircraft_quickly",1);
		self.destroyedaircrafttime[weapon] = undefined;
	}
	else
	{
		self.destroyedaircrafttime[weapon] = GetTime();
	}
}

//Function Number: 3
canprocesschallenges()
{
/#
	return 1;
getdvarintdefault("scr_debug_challenges",0)
#/
	if(level.rankedmatch || level.wagermatch)
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
initteamchallenges(team)
{
	if(!(IsDefined(game["challenge"])))
	{
		game["challenge"] = [];
	}

	if(!(IsDefined(game["challenge"][team])))
	{
		game["challenge"][team] = [];
		game["challenge"][team]["plantedBomb"] = 0;
		game["challenge"][team]["destroyedBombSite"] = 0;
		game["challenge"][team]["capturedFlag"] = 0;
	}

	game["challenge"][team]["allAlive"] = 1;
}

//Function Number: 5
registerchallengescallback(callback,func)
{
	if(!(IsDefined(level.challengescallbacks[callback])))
	{
		level.challengescallbacks[callback] = [];
	}

	level.challengescallbacks[callback][level.challengescallbacks[callback].size] = func;
}

//Function Number: 6
dochallengecallback(callback,data)
{
	if(!(IsDefined(level.challengescallbacks)))
	{
		return;
	}

	if(!(IsDefined(level.challengescallbacks[callback])))
	{
		return;
	}

	if(IsDefined(data))
	{
		for(i = 0;i < level.challengescallbacks[callback].size;i++)
		{
			thread [[ level.challengescallbacks[callback][i] ]](data);
		}
	}
	else
	{
		for(i = 0;i < level.challengescallbacks[callback].size;i++)
		{
			thread [[ level.challengescallbacks[callback][i] ]]();
		}
	}
}

//Function Number: 7
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player thread initchallengedata();
		player thread spawnwatcher();
		player thread monitorreloads();
	}
}

//Function Number: 8
monitorreloads()
{
	self endon("disconnect");
	while(1)
	{
		self waittill("reload");
		currentweapon = self getcurrentweapon();
		if(currentweapon == "none")
		{
			continue;
		}

		time = GetTime();
		self.lastreloadtime = time;
		if(currentweapon == "crossbow_mp")
		{
			self.crossbowclipkillcount = 0;
		}

		if(weaponhasattachment(currentweapon,"dualclip"))
		{
			self thread reloadthenkill(currentweapon);
		}
	}
}

//Function Number: 9
reloadthenkill(reloadweapon)
{
	self endon("disconnect");
	self endon("death");
	self endon("reloadThenKillTimedOut");
	self notify("reloadThenKillStart");
	self endon("reloadThenKillStart");
	self thread reloadthenkilltimeout(5);
	for(;;)
	{
		self waittill("killed_enemy_player",time,weapon);
		if(reloadweapon == weapon)
		{
			self addplayerstat("reload_then_kill_dualclip",1);
		}
	}
}

//Function Number: 10
reloadthenkilltimeout(time)
{
	self endon("disconnect");
	self endon("death");
	self endon("reloadThenKillStart");
	wait(time);
	self notify("reloadThenKillTimedOut");
}

//Function Number: 11
initchallengedata()
{
	self.pers["bulletStreak"] = 0;
	self.pers["lastBulletKillTime"] = 0;
	self.pers["stickExplosiveKill"] = 0;
	self.pers["carepackagesCalled"] = 0;
	self.explosiveinfo = [];
}

//Function Number: 12
isdamagefromplayercontrolledaitank(eattacker,einflictor,sweapon)
{
	if(sweapon == "ai_tank_drone_gun_mp")
	{
		if(IsDefined(eattacker) && IsDefined(eattacker.remoteweapon) && IsDefined(einflictor))
		{
			if(IsDefined(einflictor.controlled) && einflictor.controlled == 1)
			{
				if(eattacker.remoteweapon == einflictor)
				{
					return 1;
				}
			}
		}
	}
	else if(sweapon == "ai_tank_drone_rocket_mp")
	{
		if(IsDefined(einflictor) && !IsDefined(einflictor.from_ai))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
isdamagefromplayercontrolledsentry(eattacker,einflictor,sweapon)
{
	if(sweapon == "auto_gun_turret_mp")
	{
		if(IsDefined(eattacker) && IsDefined(eattacker.remoteweapon) && IsDefined(einflictor))
		{
			if(eattacker.remoteweapon == einflictor)
			{
				if(IsDefined(einflictor.controlled) && einflictor.controlled == 1)
				{
					return 1;
				}
			}
		}
	}
}

//Function Number: 14
challengekills(data,time)
{
	victim = data.victim;
	player = data.attacker;
	attacker = data.attacker;
	time = data.time;
	victim = data.victim;
	weapon = data.sweapon;
	time = data.time;
	inflictor = data.einflictor;
	meansofdeath = data.smeansofdeath;
	wasplanting = data.wasplanting;
	wasdefusing = data.wasdefusing;
	lastweaponbeforetoss = data.lastweaponbeforetoss;
	ownerweaponatlaunch = data.ownerweaponatlaunch;
	if(!(IsDefined(data.sweapon)))
	{
		return;
	}

	if(!IsDefined(player) || !isplayer(player))
	{
		return;
	}

	weaponclass = getweaponclass(weapon);
	game["challenge"][victim.team]["allAlive"] = 0;
	if(level.teambased)
	{
		if(player.team == victim.team)
		{
			return;
		}
	}
	else if(player == victim)
	{
		return;
	}

	if(isdamagefromplayercontrolledaitank(player,inflictor,weapon) == 1)
	{
		player addplayerstat("kill_with_remote_control_ai_tank",1);
	}

	if(weapon == "auto_gun_turret_mp")
	{
		if(IsDefined(inflictor))
		{
			if(!(IsDefined(inflictor.killcount)))
			{
				inflictor.killcount = 0;
			}

			inflictor.killcount++;
			if(inflictor.killcount >= 5)
			{
				inflictor.killcount = 0;
				player addplayerstat("killstreak_5_with_sentry_gun",1);
			}
		}

		if(isdamagefromplayercontrolledsentry(player,inflictor,weapon) == 1)
		{
			player addplayerstat("kill_with_remote_control_sentry_gun",1);
		}
	}

	if(weapon == "minigun_mp" || weapon == "inventory_minigun_mp")
	{
		player.deathmachinekills++;
		if(player.deathmachinekills >= 5)
		{
			player.deathmachinekills = 0;
			player addplayerstat("killstreak_5_with_death_machine",1);
		}
	}

	if(data.waslockingon == 1 && weapon == "chopper_minigun_mp")
	{
		player addplayerstat("kill_enemy_locking_on_with_chopper_gunner",1);
	}

	if(IsDefined(level.iskillstreakweapon))
	{
		if([[ level.iskillstreakweapon ]](data.sweapon))
		{
			return;
		}
	}

	attacker notify("killed_enemy_player",time,weapon);
	if((IsDefined(player.primaryloadoutweapon) && weapon == player.primaryloadoutweapon) || IsDefined(player.primaryloadoutaltweapon) && weapon == player.primaryloadoutaltweapon)
	{
		if(player isbonuscardactive(0,player.class_num))
		{
			player addbonuscardstat(0,"kills",1,player.class_num);
			player addplayerstat("kill_with_loadout_weapon_with_3_attachments",1);
		}

		if(IsDefined(player.secondaryweaponkill) && player.secondaryweaponkill == 1)
		{
			player.primaryweaponkill = 0;
			player.secondaryweaponkill = 0;
			if(player isbonuscardactive(2,player.class_num))
			{
				player addbonuscardstat(2,"kills",1,player.class_num);
				player addplayerstat("kill_with_both_primary_weapons",1);
			}
		}
		else
		{
			player.primaryweaponkill = 1;
		}
	}
	else if((IsDefined(player.secondaryloadoutweapon) && weapon == player.secondaryloadoutweapon) || IsDefined(player.secondaryloadoutaltweapon) && weapon == player.secondaryloadoutaltweapon)
	{
		if(player isbonuscardactive(1,player.class_num))
		{
			player addbonuscardstat(1,"kills",1,player.class_num);
		}

		if(IsDefined(player.primaryweaponkill) && player.primaryweaponkill == 1)
		{
			player.primaryweaponkill = 0;
			player.secondaryweaponkill = 0;
			if(player isbonuscardactive(2,player.class_num))
			{
				player addbonuscardstat(2,"kills",1,player.class_num);
				player addplayerstat("kill_with_both_primary_weapons",1);
			}
		}
		else
		{
			player.secondaryweaponkill = 1;
		}
	}

	if(player isbonuscardactive(5,player.class_num) || player isbonuscardactive(4,player.class_num) || player isbonuscardactive(3,player.class_num))
	{
		player addplayerstat("kill_with_2_perks_same_category",1);
	}

	baseweaponname = getreffromitemindex(getbaseweaponitemindex(weapon)) + "_mp";
	if(IsDefined(player.weaponkills[baseweaponname]))
	{
		player.weaponkills[baseweaponname]++;
		if(player.weaponkills[baseweaponname] == 5)
		{
			player addweaponstat(baseweaponname,"killstreak_5",1);
		}

		if(player.weaponkills[baseweaponname] == 10)
		{
			player addweaponstat(baseweaponname,"killstreak_10",1);
		}
	}
	else
	{
		player.weaponkills[baseweaponname] = 1;
	}

	attachmentname = player getweaponoptic(weapon);
	if(IsDefined(attachmentname) && attachmentname != "")
	{
		if(IsDefined(player.attachmentkills[attachmentname]))
		{
			player.attachmentkills[attachmentname]++;
			if(player.attachmentkills[attachmentname] == 5)
			{
				player addweaponstat(weapon,"killstreak_5_attachment",1);
			}
		}
		else
		{
			player.attachmentkills[attachmentname] = 1;
		}
	}

/#
	assert(IsDefined(player.activecounteruavs));
#/
/#
	assert(IsDefined(player.activeuavs));
#/
/#
	assert(IsDefined(player.activesatellites));
#/
	if(player.activeuavs > 0)
	{
		player addplayerstat("kill_while_uav_active",1);
	}

	if(player.activecounteruavs > 0)
	{
		player addplayerstat("kill_while_cuav_active",1);
	}

	if(player.activesatellites > 0)
	{
		player addplayerstat("kill_while_satellite_active",1);
	}

	if(IsDefined(attacker.tacticalinsertiontime) && attacker.tacticalinsertiontime + 5000 > time)
	{
		player addplayerstat("kill_after_tac_insert",1);
		player addweaponstat("tactical_insertion_mp","CombatRecordStat",1);
	}

	if(IsDefined(victim.tacticalinsertiontime) && victim.tacticalinsertiontime + 5000 > time)
	{
		player addweaponstat("tactical_insertion_mp","headshots",1);
	}

	if(IsDefined(level.isplayertrackedfunc))
	{
		if(attacker [[ level.isplayertrackedfunc ]](victim,time))
		{
			attacker addplayerstat("kill_enemy_revealed_by_sensor",1);
			attacker addweaponstat("sensor_grenade_mp","CombatRecordStat",1);
		}
	}

	if(level.teambased)
	{
		activeempowner = level.empowners[player.team];
		if(IsDefined(activeempowner))
		{
			if(activeempowner == player)
			{
				player addplayerstat("kill_while_emp_active",1);
			}
		}
	}
	else if(IsDefined(level.empplayer))
	{
		if(level.empplayer == player)
		{
			player addplayerstat("kill_while_emp_active",1);
		}
	}

	if(IsDefined(player.flakjacketclaymore[victim.clientid]) && player.flakjacketclaymore[victim.clientid] == 1)
	{
		player addplayerstat("survive_claymore_kill_planter_flak_jacket_equipped",1);
	}

	if(IsDefined(player.dogsactive))
	{
		if(weapon != "dog_bite_mp")
		{
			player.dogsactivekillstreak++;
			if(player.dogsactivekillstreak > 5)
			{
				player addplayerstat("killstreak_5_dogs",1);
			}
		}
	}

	isstunned = 0;
	if(victim maps/mp/_utility::isflashbanged())
	{
		if(IsDefined(victim.lastflashedby) && victim.lastflashedby == player)
		{
			player addplayerstat("kill_flashed_enemy",1);
			player addweaponstat("flash_grenade_mp","CombatRecordStat",1);
		}

		isstunned = 1;
	}

	if(IsDefined(victim.concussionendtime) && victim.concussionendtime > GetTime())
	{
		if(IsDefined(victim.lastconcussedby) && victim.lastconcussedby == player)
		{
			player addplayerstat("kill_concussed_enemy",1);
			player addweaponstat("concussion_grenade_mp","CombatRecordStat",1);
		}

		isstunned = 1;
	}

	if(IsDefined(player.laststunnedby))
	{
		if(player.laststunnedby == victim && player.laststunnedtime + 5000 > time)
		{
			player addplayerstat("kill_enemy_who_shocked_you",1);
		}
	}

	if(IsDefined(victim.laststunnedby) && victim.laststunnedtime + 5000 > time)
	{
		isstunned = 1;
		if(victim.laststunnedby == player)
		{
			player addplayerstat("kill_shocked_enemy",1);
			player addweaponstat("proximity_grenade_mp","CombatRecordStat",1);
			if(data.smeansofdeath == "MOD_MELEE")
			{
				player addplayerstat("shock_enemy_then_stab_them",1);
			}
		}
	}

	if(player.mantletime + 5000 > time)
	{
		player addplayerstat("mantle_then_kill",1);
	}

	if(IsDefined(player.tookweaponfrom) && IsDefined(player.tookweaponfrom[weapon]) && IsDefined(player.tookweaponfrom[weapon].previousowner))
	{
		if(level.teambased)
		{
			if(player.tookweaponfrom[weapon].previousowner.team != player.team)
			{
				player.pickedupweaponkills[weapon]++;
				player addplayerstat("kill_enemy_with_picked_up_weapon",1);
			}
		}
		else
		{
			player.pickedupweaponkills[weapon]++;
			player addplayerstat("kill_enemy_with_picked_up_weapon",1);
		}

		if(player.pickedupweaponkills[weapon] >= 5)
		{
			player.pickedupweaponkills[weapon] = 0;
			player addplayerstat("killstreak_5_picked_up_weapon",1);
		}
	}

	if(IsDefined(victim.explosiveinfo["originalOwnerKill"]) && victim.explosiveinfo["originalOwnerKill"] == 1)
	{
		if(victim.explosiveinfo["damageExplosiveKill"] == 1)
		{
			player addplayerstat("kill_enemy_shoot_their_explosive",1);
		}
	}

	if(data.attackerstance == "crouch")
	{
		player addplayerstat("kill_enemy_while_crouched",1);
	}
	else if(data.attackerstance == "prone")
	{
		player addplayerstat("kill_enemy_while_prone",1);
	}

	if(data.victimstance == "prone")
	{
		player addplayerstat("kill_prone_enemy",1);
	}

	if(data.smeansofdeath == "MOD_HEAD_SHOT" || data.smeansofdeath == "MOD_PISTOL_BULLET" || data.smeansofdeath == "MOD_RIFLE_BULLET")
	{
		player genericbulletkill(data,victim,weapon);
	}

	if(level.teambased)
	{
		if(!IsDefined(player.pers["kill_every_enemy"]) && level.playercount[victim.pers["team"]] > 3 && player.pers["killed_players"].size >= level.playercount[victim.pers["team"]])
		{
			player addplayerstat("kill_every_enemy",1);
			player.pers["kill_every_enemy"] = 1;
		}
	}

	switch(weaponclass)
	{
		case "€GSC\r\n":
			player.pers["pistolHeadshot"]++;
			player.pers["pistolHeadshot"] = 0;
			player addplayerstat("pistolHeadshot_10_onegame",1);
			break;
	player.pers["pistolHeadshot"] >= 10
	data.smeansofdeath == "MOD_HEAD_SHOT"
			break;

		case "€GSC\r\n":
			player.pers["assaultRifleHeadshot"]++;
			player.pers["assaultRifleHeadshot"] = 0;
			player addplayerstat("headshot_assault_5_onegame",1);
			break;
	player.pers["assaultRifleHeadshot"] >= 5
	data.smeansofdeath == "MOD_HEAD_SHOT"
			break;

		case "€GSC\r\n":
		case "€GSC\r\n":
			break;

		case "€GSC\r\n":
			player addplayerstat("kill_enemy_one_bullet_sniper",1);
			player addweaponstat(weapon,"kill_enemy_one_bullet_sniper",1);
			player.pers["one_shot_sniper_kills"] = 0;
			player.pers["one_shot_sniper_kills"]++;
			player addplayerstat("kill_10_enemy_one_bullet_sniper_onegame",1);
			break;
	player.pers["one_shot_sniper_kills"] == 10
	IsDefined(player.pers["one_shot_sniper_kills"])
	IsDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time
			break;

		case "€GSC\r\n":
			player addplayerstat("kill_enemy_one_bullet_shotgun",1);
			player addweaponstat(weapon,"kill_enemy_one_bullet_shotgun",1);
			player.pers["one_shot_shotgun_kills"] = 0;
			player.pers["one_shot_shotgun_kills"]++;
			player addplayerstat("kill_10_enemy_one_bullet_shotgun_onegame",1);
			break;
	player.pers["one_shot_shotgun_kills"] == 10
	IsDefined(player.pers["one_shot_shotgun_kills"])
	IsDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time
			break;
	}

	if(data.smeansofdeath == "MOD_MELEE")
	{
		if(weaponhasattachment(weapon,"tacknife"))
		{
			player addplayerstat("kill_enemy_with_tacknife",1);
			player bladekill();
		}
		else if(weapon == "knife_ballistic_mp")
		{
			player bladekill();
			player addweaponstat(weapon,"ballistic_knife_melee",1);
		}
		else if(weapon == "knife_held_mp" || weapon == "knife_mp")
		{
			player bladekill();
		}
		else if(weapon == "riotshield_mp")
		{
			if(victim.lastfiretime + 3000 > time)
			{
				player addweaponstat(weapon,"shield_melee_while_enemy_shooting",1);
			}
		}
	}
	else
	{
		if(data.smeansofdeath == "MOD_IMPACT" && baseweaponname == "crossbow_mp")
		{
			if(weaponhasattachment(weapon,"stackfire"))
			{
				player addplayerstat("KILL_CROSSBOW_STACKFIRE",1);
			}
		}
		else if(IsDefined(ownerweaponatlaunch))
		{
			if(weaponhasattachment(ownerweaponatlaunch,"stackfire"))
			{
				player addplayerstat("KILL_CROSSBOW_STACKFIRE",1);
			}
		}

		if(weapon == "knife_ballistic_mp")
		{
			player bladekill();
			if(IsDefined(player.retreivedblades) && player.retreivedblades > 0)
			{
				player.retreivedblades--;
				player addweaponstat(weapon,"kill_retrieved_blade",1);
			}
		}
	}

	lethalgrenadekill = 0;
	switch(weapon)
	{
		case "€GSC\r\n":
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			break;

		case "€GSC\r\n":
			player bladekill();
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			player addweaponstat(level.riotshield_name,"hatchet_kill_with_shield_equiped",1);
			player addplayerstat("hatchet_kill_with_shield_equiped",1);
			break;
	lastweaponbeforetoss == level.riotshield_name
	IsDefined(lastweaponbeforetoss)
			break;

		case "€GSC\r\n":
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			player addplayerstat("kill_with_claymore",1);
			player addplayerstat("kill_with_hacked_claymore",1);
			break;
	data.washacked
			break;

		case "€GSC\r\n":
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			player addplayerstat("kill_with_c4",1);
			break;

		case "€GSC\r\n":
			player addplayerstat("kill_enemy_withcar",1);
			player addweaponstat(inflictor.destroyingweapon,"kills_from_cars",1);
			break;
	IsDefined(inflictor.destroyingweapon)
			break;

		case "€GSC\r\n":
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			attacker.pers["stickExplosiveKill"]++;
			attacker.pers["stickExplosiveKill"] = 0;
			player addplayerstat("stick_explosive_kill_5_onegame",1);
			break;
	attacker.pers["stickExplosiveKill"] >= 5
	IsDefined(victim.explosiveinfo["stuckToPlayer"]) && victim.explosiveinfo["stuckToPlayer"] == victim
			break;

		case "€GSC\r\n":
			lethalgrenadekill = 1;
			player notify("lethalGrenadeKill");
			player addplayerstat("kill_with_cooked_grenade",1);
			player addplayerstat("kill_with_tossed_back_lethal",1);
			break;
	IsDefined(data.victim.explosiveinfo["throwbackKill"]) && data.victim.explosiveinfo["throwbackKill"] == 1
	IsDefined(data.victim.explosiveinfo["cookedKill"]) && data.victim.explosiveinfo["cookedKill"] == 1
			break;

		case "€GSC\r\n":
		case "€GSC\r\n":
			player.crossbowclipkillcount = 0;
			player.crossbowclipkillcount++;
			player.crossbowclipkillcount = 0;
			player addweaponstat("crossbow_mp","crossbow_kill_clip",1);
			break;
	player.crossbowclipkillcount >= weaponclipsize("crossbow_mp")
	IsDefined(player.crossbowclipkillcount)
			break;
	}

	if(lethalgrenadekill)
	{
		if(player isbonuscardactive(6,player.class_num))
		{
			player addbonuscardstat(6,"kills",1,player.class_num);
			if(!(IsDefined(player.pers["dangerCloseKills"])))
			{
				player.pers["dangerCloseKills"] = 0;
			}

			player.pers["dangerCloseKills"]++;
			if(player.pers["dangerCloseKills"] == 5)
			{
				player addplayerstat("kill_with_dual_lethal_grenades",1);
			}
		}
	}

	player perkkills(victim,isstunned,time);
}

//Function Number: 15
perkkills(victim,isstunned,time)
{
	player = self;
	if(player hasperk("specialty_movefaster"))
	{
		player addplayerstat("perk_movefaster_kills",1);
	}

	if(player hasperk("specialty_noname"))
	{
		player addplayerstat("perk_noname_kills",1);
	}

	if(player hasperk("specialty_quieter"))
	{
		player addplayerstat("perk_quieter_kills",1);
	}

	if(player hasperk("specialty_longersprint"))
	{
		if(IsDefined(player.lastsprinttime) && GetTime() - player.lastsprinttime < 2500)
		{
			player addplayerstat("perk_longersprint",1);
		}
	}

	if(player hasperk("specialty_fastmantle"))
	{
		if(IsDefined(player.lastsprinttime) && GetTime() - player.lastsprinttime < 2500 && player playerads() >= 1)
		{
			player addplayerstat("perk_fastmantle_kills",1);
		}
	}

	if(player hasperk("specialty_loudenemies"))
	{
		player addplayerstat("perk_loudenemies_kills",1);
	}

	if(isstunned == 1 && player hasperk("specialty_stunprotection"))
	{
		player addplayerstat("perk_protection_stun_kills",1);
	}

/#
	assert(IsDefined(victim.activecounteruavs));
#/
	activeemp = 0;
	if(level.teambased)
	{
		foreach(team in level.teams)
		{
			if(team == player.team)
			{
			}
			else if(IsDefined(level.empowners[team]))
			{
				activeemp = 1;
				break;
			}
		}
	}
	else if(IsDefined(level.empplayer))
	{
		if(level.empplayer != player)
		{
			activeemp = 1;
		}
	}

	activecuav = 0;
	if(level.teambased)
	{
		foreach(team in level.teams)
		{
			if(team == player.team)
			{
			}
			else if(level.activecounteruavs[team] > 0)
			{
				activecuav = 1;
				break;
			}
		}
	}
	else
	{
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			if(players[i] != player)
			{
				if(IsDefined(level.activecounteruavs[players[i].entnum]) && level.activecounteruavs[players[i].entnum] > 0)
				{
					activecuav = 1;
					break;
				}
			}
		}
	}

	if(activecuav == 1 || activeemp == 1)
	{
		if(player hasperk("specialty_immunecounteruav"))
		{
			player addplayerstat("perk_immune_cuav_kills",1);
		}
	}

	activeuavvictim = 0;
	if(level.teambased)
	{
		if(level.activeuavs[victim.team] > 0)
		{
			activeuavvictim = 1;
		}
	}
	else
	{
		activeuavvictim = IsDefined(level.activeuavs[victim.entnum]) && level.activeuavs[victim.entnum] > 0;
	}

	if(activeuavvictim == 1)
	{
		if(player hasperk("specialty_gpsjammer"))
		{
			player addplayerstat("perk_gpsjammer_immune_kills",1);
		}
	}

	if(player.lastweaponchange + 5000 > time)
	{
		if(player hasperk("specialty_fastweaponswitch"))
		{
			player addplayerstat("perk_fastweaponswitch_kill_after_swap",1);
		}
	}

	if(player.scavenged == 1)
	{
		if(player hasperk("specialty_scavenger"))
		{
			player addplayerstat("perk_scavenger_kills_after_resupply",1);
		}
	}
}

//Function Number: 16
flakjacketprotected(weapon,attacker)
{
	if(weapon == "claymore_mp")
	{
		self.flakjacketclaymore[attacker.clientid] = 1;
	}

	self addplayerstat("perk_flak_survive",1);
}

//Function Number: 17
earnedkillstreak()
{
	if(self hasperk("specialty_earnmoremomentum"))
	{
		self addplayerstat("perk_earnmoremomentum_earn_streak",1);
	}
}

//Function Number: 18
genericbulletkill(data,victim,weapon)
{
	player = self;
	time = data.time;
	if(player.pers["lastBulletKillTime"] == time)
	{
		player.pers["bulletStreak"]++;
	}
	else
	{
		player.pers["bulletStreak"] = 1;
	}

	player.pers["lastBulletKillTime"] = time;
	if(data.victim.idflagstime == time)
	{
		if(data.victim.idflags & level.idflags_penetration)
		{
			player addplayerstat("kill_enemy_through_wall",1);
			if(IsDefined(weapon) && weaponhasattachment(weapon,"fmj"))
			{
				player addplayerstat("kill_enemy_through_wall_with_fmj",1);
			}
		}
	}
}

//Function Number: 19
ishighestscoringplayer(player)
{
	if(!IsDefined(player.score) || player.score < 1)
	{
		return 0;
	}

	players = level.players;
	if(level.teambased)
	{
		team = player.pers["team"];
	}
	else
	{
		team = "all";
	}

	highscore = player.score;
	for(i = 0;i < players.size;i++)
	{
		if(!(IsDefined(players[i].score)))
		{
		}
		else if(players[i] == player)
		{
		}
		else if(players[i].score < 1)
		{
		}
		else if(team != "all" && players[i].pers["team"] != team)
		{
		}
		else if(players[i].score >= highscore)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 20
spawnwatcher()
{
	self endon("disconnect");
	self.pers["stickExplosiveKill"] = 0;
	self.pers["pistolHeadshot"] = 0;
	self.pers["assaultRifleHeadshot"] = 0;
	self.pers["killNemesis"] = 0;
	while(1)
	{
		self waittill("spawned_player");
		self.pers["longshotsPerLife"] = 0;
		self.flakjacketclaymore = [];
		self.weaponkills = [];
		self.attachmentkills = [];
		self.retreivedblades = 0;
		self.lastreloadtime = 0;
		self.crossbowclipkillcount = 0;
		self thread watchfordtp();
		self thread watchformantle();
		self thread monitor_player_sprint();
	}
}

//Function Number: 21
pickedupballisticknife()
{
	self.retreivedblades++;
}

//Function Number: 22
watchfordtp()
{
	self endon("disconnect");
	self endon("death");
	self.dtptime = 0;
	while(1)
	{
		self waittill("dtp_end");
		self.dtptime = GetTime() + 4000;
	}
}

//Function Number: 23
watchformantle()
{
	self endon("disconnect");
	self endon("death");
	self.mantletime = 0;
	while(1)
	{
		self waittill("mantle_start",mantleendtime);
		self.mantletime = mantleendtime;
	}
}

//Function Number: 24
disarmedhackedcarepackage()
{
	self addplayerstat("disarm_hacked_carepackage",1);
}

//Function Number: 25
destroyed_car()
{
	if(!IsDefined(self) || !isplayer(self))
	{
		return;
	}

	self addplayerstat("destroy_car",1);
}

//Function Number: 26
killednemesis()
{
	self.pers["killNemesis"]++;
	if(self.pers["killNemesis"] >= 5)
	{
		self.pers["killNemesis"] = 0;
		self addplayerstat("kill_nemesis",1);
	}
}

//Function Number: 27
killwhiledamagingwithhpm()
{
	self addplayerstat("kill_while_damaging_with_microwave_turret",1);
}

//Function Number: 28
longdistancehatchetkill()
{
	self addplayerstat("long_distance_hatchet_kill",1);
}

//Function Number: 29
blockedsatellite()
{
	self addplayerstat("activate_cuav_while_enemy_satelite_active",1);
}

//Function Number: 30
longdistancekill()
{
	self.pers["longshotsPerLife"]++;
	if(self.pers["longshotsPerLife"] >= 3)
	{
		self.pers["longshotsPerLife"] = 0;
		self addplayerstat("longshot_3_onelife",1);
	}
}

//Function Number: 31
challengeroundend(data)
{
	player = data.player;
	winner = data.winner;
	if(endedearly(winner))
	{
		return;
	}

	if(level.teambased)
	{
		winnerscore = game["teamScores"][winner];
		loserscore = getlosersteamscores(winner);
	}

	switch(level.gametype)
	{
		case "€GSC\r\n":
			player addgametypestat("round_win_no_deaths",1);
			player addgametypestat("last_man_defeat_3_enemies",1);
			break;
	IsDefined(player.lastmansddefeat3enemies)
	game["challenge"][winner]["allAlive"]
	player.team == winner
			break;

		default:
			break;
	}
}

//Function Number: 32
roundend(winner)
{
	wait(0.05);
	data = spawnstruct();
	data.time = GetTime();
	if(level.teambased)
	{
		if(IsDefined(winner) && IsDefined(level.teams[winner]))
		{
			data.winner = winner;
		}
	}
	else if(IsDefined(winner))
	{
		data.winner = winner;
	}

	for(index = 0;index < level.placement["all"].size;index++)
	{
		data.player = level.placement["all"][index];
		data.place = index;
		dochallengecallback("roundEnd",data);
	}
}

//Function Number: 33
gameend(winner)
{
	wait(0.05);
	data = spawnstruct();
	data.time = GetTime();
	if(level.teambased)
	{
		if(IsDefined(winner) && IsDefined(level.teams[winner]))
		{
			data.winner = winner;
		}
	}
	else if(IsDefined(winner) && isplayer(winner))
	{
		data.winner = winner;
	}

	for(index = 0;index < level.placement["all"].size;index++)
	{
		data.player = level.placement["all"][index];
		data.place = index;
		dochallengecallback("gameEnd",data);
	}
}

//Function Number: 34
getfinalkill(player)
{
	if(isplayer(player))
	{
		player addplayerstat("get_final_kill",1);
	}
}

//Function Number: 35
destroyrcbomb(weaponname)
{
	self destroyscorestreak(weaponname);
	if(weaponname == "hatchet_mp")
	{
		self addplayerstat("destroy_rcbomb_with_hatchet",1);
	}
}

//Function Number: 36
capturedcrate()
{
	if(IsDefined(self.lastrescuedby) && IsDefined(self.lastrescuedtime))
	{
		if(self.lastrescuedtime + 5000 > GetTime())
		{
			self.lastrescuedby addplayerstat("defend_teammate_who_captured_package",1);
		}
	}
}

//Function Number: 37
destroyscorestreak(weaponname)
{
	if(IsDefined(weaponname) && weaponname == "qrdrone_turret_mp")
	{
		self addplayerstat("destroy_score_streak_with_qrdrone",1);
	}
}

//Function Number: 38
capturedobjective(capturetime)
{
	if(IsDefined(self.smokegrenadetime) && IsDefined(self.smokegrenadeposition))
	{
		if(self.smokegrenadetime + 14000 > capturetime)
		{
			distsq = distancesquared(self.smokegrenadeposition,self.origin);
			if(distsq < 57600)
			{
				self addplayerstat("capture_objective_in_smoke",1);
				self addweaponstat("willy_pete_mp","CombatRecordStat",1);
			}
			else
			{
			}
		}
	}
}

//Function Number: 39
hackedordestroyedequipment()
{
	if(self hasperk("specialty_showenemyequipment"))
	{
		self addplayerstat("perk_hacker_destroy",1);
	}
}

//Function Number: 40
destroyedequipment(weaponname)
{
	if(IsDefined(weaponname) && weaponname == "emp_grenade_mp")
	{
		self addplayerstat("destroy_equipment_with_emp_grenade",1);
		self addweaponstat("emp_grenade_mp","combatRecordStat",1);
	}

	self addplayerstat("destroy_equipment",1);
	self hackedordestroyedequipment();
}

//Function Number: 41
destroyedtacticalinsert()
{
	if(!(IsDefined(self.pers["tacticalInsertsDestroyed"])))
	{
		self.pers["tacticalInsertsDestroyed"] = 0;
	}

	self.pers["tacticalInsertsDestroyed"]++;
	if(self.pers["tacticalInsertsDestroyed"] >= 5)
	{
		self.pers["tacticalInsertsDestroyed"] = 0;
		self addplayerstat("destroy_5_tactical_inserts",1);
	}
}

//Function Number: 42
bladekill()
{
	if(!(IsDefined(self.pers["bladeKills"])))
	{
		self.pers["bladeKills"] = 0;
	}

	self.pers["bladeKills"]++;
	if(self.pers["bladeKills"] >= 15)
	{
		self.pers["bladeKills"] = 0;
		self addplayerstat("kill_15_with_blade",1);
	}
}

//Function Number: 43
destroyedexplosive(weaponname)
{
	self destroyedequipment(weaponname);
	self addplayerstat("destroy_explosive",1);
}

//Function Number: 44
assisted()
{
	self addplayerstat("assist",1);
}

//Function Number: 45
earnedmicrowaveassistscore(score)
{
	self addplayerstat("assist_score_microwave_turret",score);
	self addplayerstat("assist_score_killstreak",score);
}

//Function Number: 46
earnedcuavassistscore(score)
{
	self addplayerstat("assist_score_cuav",score);
	self addplayerstat("assist_score_killstreak",score);
	self addweaponstat("counteruav_mp","assists",1);
}

//Function Number: 47
earneduavassistscore(score)
{
	self addplayerstat("assist_score_uav",score);
	self addplayerstat("assist_score_killstreak",score);
	self addweaponstat("radar_mp","assists",1);
}

//Function Number: 48
earnedsatelliteassistscore(score)
{
	self addplayerstat("assist_score_satellite",score);
	self addplayerstat("assist_score_killstreak",score);
	self addweaponstat("radardirection_mp","assists",1);
}

//Function Number: 49
earnedempassistscore(score)
{
	self addplayerstat("assist_score_emp",score);
	self addplayerstat("assist_score_killstreak",score);
	self addweaponstat("emp_mp","assists",1);
}

//Function Number: 50
teamcompletedchallenge(team,challenge)
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(IsDefined(players[i].team) && players[i].team == team)
		{
			players[i] addgametypestat(challenge,1);
		}
	}
}

//Function Number: 51
endedearly(winner)
{
	if(level.hostforcedend)
	{
		return 1;
	}

	if(!(IsDefined(winner)))
	{
		return 1;
	}

	if(level.teambased)
	{
		if(winner == "tie")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 52
getlosersteamscores(winner)
{
	teamscores = 0;
	foreach(team in level.teams)
	{
		if(team == winner)
		{
		}
		else
		{
			teamscores = teamscores + game["teamScores"][team];
		}
	}

	return teamscores;
}

//Function Number: 53
didloserfailchallenge(winner,challenge)
{
	foreach(team in level.teams)
	{
		if(team == winner)
		{
		}
		else if(game["challenge"][team][challenge])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 54
challengegameend(data)
{
	player = data.player;
	winner = data.winner;
	if(IsDefined(level.scoreeventgameendcallback))
	{
		[[ level.scoreeventgameendcallback ]](data);
	}

	if(endedearly(winner))
	{
		return;
	}

	if(level.teambased)
	{
		winnerscore = game["teamScores"][winner];
		loserscore = getlosersteamscores(winner);
	}

	switch(level.gametype)
	{
		case "€GSC\r\n":
			player addgametypestat("CRUSH",1);
			mostkillsleastdeaths = 1;
			index = 0;
			for(;;)
			{
				mostkillsleastdeaths = 0;
				mostkillsleastdeaths = 0;
				index++;
			}
	
			player addgametypestat("most_kills_least_deaths",1);
			break;
	mostkillsleastdeaths && player.kills > 0 && level.placement["all"].size > 3
	level.placement["all"][index].kills > player.kills
	level.placement["all"][index].deaths < player.deaths
	index < level.placement["all"].size
	winnerscore >= loserscore + 20
	player.team == winner
			break;

		case "€GSC\r\n":
			secondplace = level.placement["all"][1];
			player addgametypestat("CRUSH",1);
			break;
	player.kills >= secondplace.kills + 7
	level.placement["all"].size >= 2
	player == winner
			break;

		case "€GSC\r\n":
			player addgametypestat("SHUT_OUT",1);
			break;
	loserscore == 0
	player.team == winner
			break;

		case "€GSC\r\n":
			player addgametypestat("CRUSH",1);
			break;
	winnerscore >= loserscore + 70
	player.team == winner
			break;

		case "€GSC\r\n":
			player addgametypestat("CRUSH",1);
			break;
	winnerscore >= loserscore + 70
	player.team == winner && winnerscore > 0
			break;

		case "€GSC\r\n":
			player addgametypestat("CRUSH",1);
			player addgametypestat("ANNIHILATION",1);
			break;
	winnerscore >= loserscore + 110
	player.team == winner && winnerscore > 0
	winnerscore >= loserscore + 70
	player.team == winner && winnerscore > 0
			break;

		case "€GSC\r\n":
			player addgametypestat("SHUT_OUT",1);
			break;
	loserscore == 0
	player.team == game["defenders"] && player.team == winner
			break;

		case "€GSC\r\n":
			player addgametypestat("CRUSH",1);
	loserscore <= 1
	player.team == winner
			break;

		default:
			break;
	}
}

//Function Number: 55
multikill(killcount,weapon)
{
	if(killcount >= 3 && IsDefined(self.lastkillwheninjured))
	{
		if(self.lastkillwheninjured + 5000 > GetTime())
		{
			self addplayerstat("multikill_3_near_death",1);
		}
	}
}

//Function Number: 56
domattackermultikill(killcount)
{
	self addgametypestat("kill_2_enemies_capturing_your_objective",1);
}

//Function Number: 57
totaldomination(team)
{
	teamcompletedchallenge(team,"control_3_points_3_minutes");
}

//Function Number: 58
holdflagentirematch(team,label)
{
	switch(label)
	{
		case "€GSC\r\n":
			event = "hold_a_entire_match";
			break;

		case "€GSC\r\n":
			event = "hold_b_entire_match";
			break;

		case "€GSC\r\n":
			event = "hold_c_entire_match";
			break;

		default:
			break;
	}

	teamcompletedchallenge(team,event);
}

//Function Number: 59
capturedbfirstminute()
{
	self addgametypestat("capture_b_first_minute",1);
}

//Function Number: 60
controlzoneentirely(team)
{
	teamcompletedchallenge(team,"control_zone_entirely");
}

//Function Number: 61
multi_lmg_smg_kill()
{
	self addplayerstat("multikill_3_lmg_or_smg_hip_fire",1);
}

//Function Number: 62
killedzoneattacker(weapon)
{
	if(weapon == "planemortar_mp" || weapon == "remote_missile_missile_mp" || weapon == "remote_missile_bomblet_mp")
	{
		self thread updatezonemultikills();
	}
}

//Function Number: 63
killeddog()
{
	origin = self.origin;
	if(level.teambased)
	{
		teammates = get_team_alive_players_s(self.team);
		foreach(player in teammates.a)
		{
			if(player == self)
			{
			}
			else
			{
				distsq = distancesquared(origin,player.origin);
				if(distsq < 57600)
				{
					self addplayerstat("killed_dog_close_to_teammate",1);
					break;
				}
			}
		}
	}
}

//Function Number: 64
updatezonemultikills()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentZoneKills");
	self endon("updateRecentZoneKills");
	if(!(IsDefined(self.recentzonekillcount)))
	{
		self.recentzonekillcount = 0;
	}

	self.recentzonekillcount++;
	wait(4);
	if(self.recentzonekillcount > 1)
	{
		self addplayerstat("multikill_2_zone_attackers",1);
	}

	self.recentzonekillcount = 0;
}

//Function Number: 65
multi_rcbomb_kill()
{
	self addplayerstat("muiltikill_2_with_rcbomb",1);
}

//Function Number: 66
multi_remotemissile_kill()
{
	self addplayerstat("multikill_3_remote_missile",1);
}

//Function Number: 67
multi_mgl_kill()
{
	self addplayerstat("multikill_3_with_mgl",1);
}

//Function Number: 68
immediatecapture()
{
	self addgametypestat("immediate_capture",1);
}

//Function Number: 69
killedlastcontester()
{
	self addgametypestat("contest_then_capture",1);
}

//Function Number: 70
bothbombsdetonatewithintime()
{
	self addgametypestat("both_bombs_detonate_10_seconds",1);
}

//Function Number: 71
fullclipnomisses(weaponclass,weapon)
{
}

//Function Number: 72
destroyedturret(weaponname)
{
	self destroyscorestreak(weaponname);
	self addplayerstat("destroy_turret",1);
}

//Function Number: 73
calledincarepackage()
{
	self.pers["carepackagesCalled"]++;
	if(self.pers["carepackagesCalled"] >= 3)
	{
		self addplayerstat("call_in_3_care_packages",1);
		self.pers["carepackagesCalled"] = 0;
	}
}

//Function Number: 74
destroyedhelicopter(attacker,weapon,damagetype,playercontrolled)
{
	attacker destroyscorestreak(weapon);
	if(damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET")
	{
		attacker addplayerstat("destroyed_helicopter_with_bullet",1);
	}
}

//Function Number: 75
destroyedqrdrone(damagetype,weapon)
{
	self destroyscorestreak(weapon);
	self addplayerstat("destroy_qrdrone",1);
	if(damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET")
	{
		self addplayerstat("destroyed_qrdrone_with_bullet",1);
	}

	self destroyedplayercontrolledaircraft();
}

//Function Number: 76
destroyedplayercontrolledaircraft()
{
	if(self hasperk("specialty_noname"))
	{
		self addplayerstat("destroy_helicopter",1);
	}
}

//Function Number: 77
destroyedaircraft(attacker,weapon)
{
	attacker destroyscorestreak(weapon);
	if(IsDefined(weapon))
	{
		if(weapon == "emp_mp" || weapon == "killstreak_emp_mp")
		{
			attacker addplayerstat("destroy_aircraft_with_emp",1);
		}
		else if(weapon == "missile_drone_projectile_mp" || weapon == "missile_drone_mp")
		{
			attacker addplayerstat("destroy_aircraft_with_missile_drone",1);
		}
	}

	if(attacker hasperk("specialty_nottargetedbyairsupport"))
	{
		attacker addplayerstat("perk_nottargetedbyairsupport_destroy_aircraft",1);
	}

	attacker addplayerstat("destroy_aircraft",1);
}

//Function Number: 78
killstreakten()
{
	primary = self getloadoutitem(self.class_num,"primary");
	if(primary != 0)
	{
		return;
	}

	secondary = self getloadoutitem(self.class_num,"secondary");
	if(secondary != 0)
	{
		return;
	}

	primarygrenade = self getloadoutitem(self.class_num,"primarygrenade");
	if(primarygrenade != 0)
	{
		return;
	}

	specialgrenade = self getloadoutitem(self.class_num,"specialgrenade");
	if(specialgrenade != 0)
	{
		return;
	}

	for(numspecialties = 0;numspecialties < level.maxspecialties;numspecialties++)
	{
		perk = self getloadoutitem(self.class_num,"specialty" + numspecialties + 1);
		if(perk != 0)
		{
			return;
		}
	}

	self addplayerstat("killstreak_10_no_weapons_perks",1);
}

//Function Number: 79
scavengedgrenade()
{
	self endon("disconnect");
	self endon("death");
	self notify("scavengedGrenade");
	self endon("scavengedGrenade");
	for(;;)
	{
		self waittill("lethalGrenadeKill");
		self addplayerstat("kill_with_resupplied_lethal_grenade",1);
	}
}

//Function Number: 80
stunnedtankwithempgrenade(attacker)
{
	attacker addplayerstat("stun_aitank_wIth_emp_grenade",1);
}

//Function Number: 81
playerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,shitloc,attackerstance)
{
/#
	print(level.gametype);
#/
	self.anglesondeath = self getplayerangles();
	if(IsDefined(attacker))
	{
		attacker.anglesonkill = attacker getplayerangles();
	}

	if(!(IsDefined(sweapon)))
	{
		sweapon = "none";
	}

	self endon("disconnect");
	data = spawnstruct();
	data.victim = self;
	data.victimstance = self getstance();
	data.einflictor = einflictor;
	data.attacker = attacker;
	data.attackerstance = attackerstance;
	data.idamage = idamage;
	data.smeansofdeath = smeansofdeath;
	data.sweapon = sweapon;
	data.shitloc = shitloc;
	data.time = GetTime();
	if(IsDefined(einflictor) && IsDefined(einflictor.lastweaponbeforetoss))
	{
		data.lastweaponbeforetoss = einflictor.lastweaponbeforetoss;
	}

	if(IsDefined(einflictor) && IsDefined(einflictor.ownerweaponatlaunch))
	{
		data.ownerweaponatlaunch = einflictor.ownerweaponatlaunch;
	}

	waslockingon = 0;
	if(IsDefined(einflictor.locking_on))
	{
		waslockingon = waslockingon | einflictor.locking_on;
	}

	if(IsDefined(einflictor.locked_on))
	{
		waslockingon = waslockingon | einflictor.locked_on;
	}

	waslockingon = waslockingon & 1 << data.victim.entnum;
	if(waslockingon != 0)
	{
		data.waslockingon = 1;
	}
	else
	{
		data.waslockingon = 0;
	}

	data.washacked = einflictor maps/mp/_utility::ishacked();
	data.wasplanting = data.victim.isplanting;
	if(!(IsDefined(data.wasplanting)))
	{
		data.wasplanting = 0;
	}

	data.wasdefusing = data.victim.isdefusing;
	if(!(IsDefined(data.wasdefusing)))
	{
		data.wasdefusing = 0;
	}

	data.victimweapon = data.victim.currentweapon;
	data.victimonground = data.victim isonground();
	if(isplayer(attacker))
	{
		data.attackeronground = data.attacker isonground();
		if(!(IsDefined(data.attackerstance)))
		{
			data.attackerstance = data.attacker getstance();
		}
	}
	else
	{
		data.attackeronground = 0;
		data.attackerstance = "stand";
	}

	waitandprocessplayerkilledcallback(data);
	data.attacker notify("playerKilledChallengesProcessed");
}

//Function Number: 82
waittillslowprocessallowed()
{
	while(level.lastslowprocessframe == GetTime())
	{
		wait(0.05);
	}

	level.lastslowprocessframe = GetTime();
}

//Function Number: 83
doscoreeventcallback(callback,data)
{
	if(!(IsDefined(level.scoreeventcallbacks)))
	{
		return;
	}

	if(!(IsDefined(level.scoreeventcallbacks[callback])))
	{
		return;
	}

	if(IsDefined(data))
	{
		for(i = 0;i < level.scoreeventcallbacks[callback].size;i++)
		{
			thread [[ level.scoreeventcallbacks[callback][i] ]](data);
		}
	}
	else
	{
		for(i = 0;i < level.scoreeventcallbacks[callback].size;i++)
		{
			thread [[ level.scoreeventcallbacks[callback][i] ]]();
		}
	}
}

//Function Number: 84
waitandprocessplayerkilledcallback(data)
{
	if(IsDefined(data.attacker))
	{
		data.attacker endon("disconnect");
	}

	wait(0.05);
	waittillslowprocessallowed();
	level thread dochallengecallback("playerKilled",data);
	level thread doscoreeventcallback("playerKilled",data);
}

//Function Number: 85
weaponisknife(weapon)
{
	if(weapon == "knife_held_mp" || weapon == "knife_mp" || weapon == "knife_ballistic_mp")
	{
		return 1;
	}
}

//Function Number: 86
eventreceived(eventname)
{
	self endon("disconnect");
	waittillslowprocessallowed();
	switch(level.gametype)
	{
		case "€GSC\r\n":
			self addgametypestat("killstreak_10",1);
			continue;
			self addgametypestat("killstreak_15",1);
			continue;
			self addgametypestat("killstreak_20",1);
			continue;
			self addgametypestat("multikill_3",1);
			continue;
			self addgametypestat("kill_enemy_who_killed_teammate",1);
			continue;
			self addgametypestat("kill_enemy_injuring_teammate",1);
			break;
	eventname == "kill_enemy_injuring_teammate"
	eventname == "kill_enemy_who_killed_teammate"
	eventname == "multikill_3"
	eventname == "killstreak_20"
	eventname == "killstreak_15"
	eventname == "killstreak_10"
			break;

		case "€GSC\r\n":
			self addgametypestat("killstreak_10",1);
			continue;
			self addgametypestat("killstreak_15",1);
			continue;
			self addgametypestat("killstreak_20",1);
			continue;
			self addgametypestat("killstreak_30",1);
			break;
	eventname == "killstreak_30"
	eventname == "killstreak_20"
	eventname == "killstreak_15"
	eventname == "killstreak_10"
			break;

		case "€GSC\r\n":
			self addgametypestat("defused_bomb_last_man_alive",1);
			continue;
			self addgametypestat("elimination_and_last_player_alive",1);
			continue;
			self addgametypestat("killed_bomb_planter",1);
			continue;
			self addgametypestat("killed_bomb_defuser",1);
			break;
	eventname == "killed_bomb_defuser"
	eventname == "killed_bomb_planter"
	eventname == "elimination_and_last_player_alive"
	eventname == "defused_bomb_last_man_alive"
			break;

		case "€GSC\r\n":
			self addgametypestat("kill_flag_carrier",1);
			continue;
			self addgametypestat("defend_flag_carrier",1);
			break;
	eventname == "defend_flag_carrier"
	eventname == "kill_flag_carrier"
			break;

		case "€GSC\r\n":
			self addgametypestat("killed_bomb_planter",1);
			continue;
			self addgametypestat("killed_bomb_defuser",1);
			break;
	eventname == "killed_bomb_defuser"
	eventname == "killed_bomb_planter"
			break;

		default:
			break;
	}
}

//Function Number: 87
monitor_player_sprint()
{
	self endon("disconnect");
	self endon("death");
	self.lastsprinttime = undefined;
	while(1)
	{
		self waittill("sprint_begin");
		self waittill("sprint_end");
		self.lastsprinttime = GetTime();
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\shrp.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 85 ms
 * Timestamp: 10/27/2023 3:00:31 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/gametypes/_wager;

//Function Number: 1
main()
{
	maps/mp/gametypes/_globallogic::init();
	maps/mp/gametypes/_callbacksetup::setupcallbacks();
	maps/mp/gametypes/_globallogic::setupcallbacks();
	level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill");
	level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill");
	level.shrpweapontimer = getgametypesetting("weaponTimer");
	level.shrpweaponnumber = getgametypesetting("weaponCount");
	registertimelimit(level.shrpweaponnumber * level.shrpweapontimer / 60,level.shrpweaponnumber * level.shrpweapontimer / 60);
	registerscorelimit(0,50000);
	registerroundlimit(0,10);
	registerroundwinlimit(0,10);
	registernumlives(0,100);
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.onspawnplayerunified = ::onspawnplayerunified;
	level.onplayerkilled = ::onplayerkilled;
	level.onwagerawards = ::onwagerawards;
	game["dialog"]["gametype"] = "ss_start";
	level.givecustomloadout = ::givecustomloadout;
	precachestring(&"MP_SHRP_WEAPONS_CYCLED");
	precachestring(&"MP_SHRP_PENULTIMATE_RND");
	precachestring(&"MP_SHRP_PENULTIMATE_MULTIPLIER");
	precachestring(&"MP_SHRP_RND");
	precachestring(&"MP_SHRP_FINAL_MULTIPLIER");
	precachestring(&"MP_SHRP_COUNTDOWN");
	precacheshader("perk_times_two");
	precacheitem("minigun_wager_mp");
	precacheitem("m32_wager_mp");
	game["dialog"]["wm_weapons_cycled"] = "ssharp_cycle_01";
	game["dialog"]["wm_final_weapon"] = "ssharp_fweapon";
	game["dialog"]["wm_bonus_rnd"] = "ssharp_2multi_00";
	game["dialog"]["wm_shrp_rnd"] = "ssharp_sround";
	game["dialog"]["wm_bonus0"] = "boost_gen_05";
	game["dialog"]["wm_bonus1"] = "boost_gen_05";
	game["dialog"]["wm_bonus2"] = "boost_gen_05";
	game["dialog"]["wm_bonus3"] = "boost_gen_05";
	game["dialog"]["wm_bonus4"] = "boost_gen_05";
	game["dialog"]["wm_bonus5"] = "boost_gen_05";
	setscoreboardcolumns("pointstowin","kills","deaths","stabs","x2score");
}

//Function Number: 2
onstartgametype()
{
	setdvar("scr_disable_weapondrop",1);
	setdvar("scr_xpscale",0);
	setdvar("ui_guncycle",0);
	makedvarserverinfo("ui_guncycle",0);
	setclientnamemode("auto_change");
	setobjectivetext("allies",&"OBJECTIVES_SHRP");
	setobjectivetext("axis",&"OBJECTIVES_SHRP");
	attach_compatibility_init();
	if(level.splitscreen)
	{
		setobjectivescoretext("allies",&"OBJECTIVES_SHRP");
		setobjectivescoretext("axis",&"OBJECTIVES_SHRP");
	}
	else
	{
		setobjectivescoretext("allies",&"OBJECTIVES_SHRP_SCORE");
		setobjectivescoretext("axis",&"OBJECTIVES_SHRP_SCORE");
	}

	setobjectivehinttext("allies",&"OBJECTIVES_SHRP_HINT");
	setobjectivehinttext("axis",&"OBJECTIVES_SHRP_HINT");
	allowed[0] = "shrp";
	maps/mp/gametypes/_gameobjects::main(allowed);
	maps/mp/gametypes/_spawning::create_map_placed_influencers();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	newspawns = getentarray("mp_wager_spawn","classname");
	if(newspawns.size > 0)
	{
		maps/mp/gametypes/_spawnlogic::addspawnpoints("allies","mp_wager_spawn");
		maps/mp/gametypes/_spawnlogic::addspawnpoints("axis","mp_wager_spawn");
	}
	else
	{
		maps/mp/gametypes/_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
		maps/mp/gametypes/_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	}

	maps/mp/gametypes/_spawning::updateallspawnpoints();
	level.mapcenter = maps/mp/gametypes/_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getrandomintermissionpoint();
	setdemointermissionpoint(spawnpoint.origin,spawnpoint.angles);
	level.usestartspawns = 0;
	maps/mp/gametypes/_wager::addpowerup("specialty_bulletflinch","perk",&"PERKS_TOUGHNESS","perk_warrior");
	maps/mp/gametypes/_wager::addpowerup("specialty_movefaster","perk",&"PERKS_LIGHTWEIGHT","perk_lightweight");
	maps/mp/gametypes/_wager::addpowerup("specialty_fallheight","perk",&"PERKS_LIGHTWEIGHT","perk_lightweight");
	maps/mp/gametypes/_wager::addpowerup("specialty_longersprint","perk",&"PERKS_EXTREME_CONDITIONING","perk_marathon");
	maps/mp/gametypes/_wager::addpowerup(2,"score_multiplier",&"PERKS_SCORE_MULTIPLIER","perk_times_two");
	level.guncycletimer = createservertimer("extrasmall",1.2);
	level.guncycletimer.horzalign = "user_left";
	level.guncycletimer.vertalign = "user_top";
	level.guncycletimer.x = 10;
	level.guncycletimer.y = 123;
	level.guncycletimer.alignx = "left";
	level.guncycletimer.aligny = "top";
	level.guncycletimer.label = &"MP_SHRP_COUNTDOWN";
	level.guncycletimer.alpha = 0;
	level.guncycletimer.hidewheninkillcam = 1;
	level.displayroundendtext = 0;
	level.quickmessagetoall = 1;
	level thread chooserandomguns();
	level thread clearpowerupsongameend();
}

//Function Number: 3
attach_compatibility_init()
{
	level.attach_compatible = [];
	set_attachtable_id();
	for(i = 0;i < 33;i++)
	{
		itemrow = tablelookuprownum(level.attachtableid,9,i);
		if(itemrow > -1)
		{
			name = tablelookupcolumnforrow(level.attachtableid,itemrow,4);
			level.attach_compatible[name] = [];
			compatible = tablelookupcolumnforrow(level.attachtableid,itemrow,11);
			level.attach_compatible[name] = strtok(compatible," ");
		}
	}
}

//Function Number: 4
set_attachtable_id()
{
	if(!(IsDefined(level.attachtableid)))
	{
		level.attachtableid = "mp/attachmentTable.csv";
	}
}

//Function Number: 5
addguntoprogression(gunname,altname)
{
	if(!(IsDefined(level.gunprogression)))
	{
		level.gunprogression = [];
	}

	newweapon = spawnstruct();
	newweapon.names = [];
	newweapon.names[newweapon.names.size] = gunname;
	if(IsDefined(altname))
	{
		newweapon.names[newweapon.names.size] = altname;
	}

	level.gunprogression[level.gunprogression.size] = newweapon;
}

//Function Number: 6
getrandomgunfromprogression()
{
	weaponidkeys = getarraykeys(level.tbl_weaponids);
	numweaponidkeys = weaponidkeys.size;
	gunprogressionsize = 0;
	if(IsDefined(level.gunprogression))
	{
		size = level.gunprogression.size;
	}

/#
	debug_weapon = GetDvar(#"1C6DE858");
#/
	allowproneblock = 1;
	players = get_players();
	foreach(player in players)
	{
		if(player getstance() == "prone")
		{
			allowproneblock = 0;
			break;
		}
	}

	while(1)
	{
		randomindex = randomint(numweaponidkeys + gunprogressionsize);
		baseweaponname = "";
		weaponname = "";
		if(randomindex < numweaponidkeys)
		{
			id = random(level.tbl_weaponids);
			if(id["group"] != "weapon_launcher" && id["group"] != "weapon_sniper" && id["group"] != "weapon_lmg" && id["group"] != "weapon_assault" && id["group"] != "weapon_smg" && id["group"] != "weapon_pistol" && id["group"] != "weapon_cqb" && id["group"] != "weapon_special")
			{
				continue;
			}

			if(id["reference"] == "weapon_null")
			{
				continue;
			}

			baseweaponname = id["reference"];
			attachmentlist = id["attachment"];
			if(baseweaponname == "m32")
			{
				baseweaponname = "m32_wager";
			}

			if(baseweaponname == "minigun")
			{
				baseweaponname = "minigun_wager";
			}

			if(baseweaponname == "riotshield")
			{
				continue;
			}

			if(GetDvarInt(#"97A055DA") == 0 && baseweaponname == "peacekeeper")
			{
				continue;
			}

			weaponname = addrandomattachmenttoweaponname(baseweaponname,attachmentlist);
			if(!allowproneblock && weaponblocksprone(weaponname))
			{
				continue;
			}
		}
		else
		{
			baseweaponname = level.gunprogression[randomindex - numweaponidkeys].names[0];
			weaponname = level.gunprogression[randomindex - numweaponidkeys].names[0];
		}

		if(!(IsDefined(level.usedbaseweapons)))
		{
			level.usedbaseweapons = [];
			level.usedbaseweapons[0] = "fhj18";
		}

		skipweapon = 0;
		for(i = 0;i < level.usedbaseweapons.size;i++)
		{
			if(level.usedbaseweapons[i] == baseweaponname)
			{
				skipweapon = 1;
				break;
			}
		}

		if(skipweapon)
		{
			continue;
		}

		level.usedbaseweapons[level.usedbaseweapons.size] = baseweaponname;
/#
		weaponname = debug_weapon;
debug_weapon != ""
#/
		return weaponname;
	}
}

//Function Number: 7
addrandomattachmenttoweaponname(baseweaponname,attachmentlist)
{
	if(!(IsDefined(attachmentlist)))
	{
		return baseweaponname;
	}

	attachments = strtok(attachmentlist," ");
	arrayremovevalue(attachments,"dw");
	if(attachments.size <= 0)
	{
		return baseweaponname + "_mp";
	}

	attachments[attachments.size] = "";
	attachment = random(attachments);
	if(attachment == "")
	{
		return baseweaponname + "_mp";
	}

	if(issubstr(attachment,"_"))
	{
		attachment = strtok(attachment,"_")[0];
	}

	if(IsDefined(level.attach_compatible[attachment]) && level.attach_compatible[attachment].size > 0)
	{
		attachment2 = level.attach_compatible[attachment][randomint(level.attach_compatible[attachment].size)];
		contains = 0;
		for(i = 0;i < attachments.size;i++)
		{
			if(IsDefined(attachment2) && attachments[i] == attachment2)
			{
				contains = 1;
				break;
			}
		}

		if(contains)
		{
			if(attachment < attachment2)
			{
				return baseweaponname + "_mp+" + attachment + "+" + attachment2;
			}

			return baseweaponname + "_mp+" + attachment2 + "+" + attachment;
		}
	}

	return baseweaponname + "_mp+" + attachment;
}

//Function Number: 8
waitlongdurationwithhostmigrationpause(nextguncycletime,duration)
{
	endtime = GetTime() + duration * 1000;
	totaltimepassed = 0;
	while(GetTime() < endtime)
	{
		maps/mp/gametypes/_hostmigration::waittillhostmigrationstarts(endtime - GetTime() / 1000);
		if(IsDefined(level.hostmigrationtimer))
		{
			setdvar("ui_guncycle",0);
			timepassed = maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
			totaltimepassed = totaltimepassed + timepassed;
			endtime = endtime + timepassed;
/#
			println("[SHRP] timePassed = " + timepassed);
			println("[SHRP] totatTimePassed = " + totaltimepassed);
			println("[SHRP] level.discardTime = " + level.discardtime);
#/
			setdvar("ui_guncycle",nextguncycletime + totaltimepassed);
		}
	}

	maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	return totaltimepassed;
}

//Function Number: 9
guncyclewaiter(nextguncycletime,waittime)
{
	continuecycling = 1;
	setdvar("ui_guncycle",nextguncycletime);
	level.guncycletimer settimer(waittime);
	level.guncycletimer.alpha = 1;
	timepassed = waitlongdurationwithhostmigrationpause(nextguncycletime,nextguncycletime - GetTime() / 1000 - 6);
	nextguncycletime = nextguncycletime + timepassed;
	for(i = 6;i > 1;i--)
	{
		for(j = 0;j < level.players.size;j++)
		{
			level.players[j] playlocalsound("uin_timer_wager_beep");
		}

		timepassed = waitlongdurationwithhostmigrationpause(nextguncycletime,nextguncycletime - GetTime() / 1000 / i);
		nextguncycletime = nextguncycletime + timepassed;
	}

	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] playlocalsound("uin_timer_wager_last_beep");
	}

	if(nextguncycletime - GetTime() > 0)
	{
		wait(nextguncycletime - GetTime() / 1000);
	}

	level.shrprandomweapon = getrandomgunfromprogression();
	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] notify("remove_planted_weapons");
		level.players[i] givecustomloadout(0,1);
	}

	return continuecycling;
}

//Function Number: 10
chooserandomguns()
{
	level endon("game_ended");
	level thread awardmostpointsmedalgameend();
	waittime = level.shrpweapontimer;
	lightningwaittime = 15;
	level.shrprandomweapon = getrandomgunfromprogression();
	if(level.inprematchperiod)
	{
		level waittill("prematch_over");
	}

	guncycle = 1;
	numguncycles = int(level.timelimit * 60 / waittime + 0.5);
	while(1)
	{
		nextguncycletime = GetTime() + waittime * 1000;
		ispenultimateround = 0;
		issharpshooterround = guncycle == numguncycles - 1;
		for(i = 0;i < level.players.size;i++)
		{
			level.players[i].currentguncyclepoints = 0;
		}

		level.currentguncyclemaxpoints = 0;
		guncyclewaiter(nextguncycletime,waittime);
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(guncycle + 1 == numguncycles)
			{
				player maps/mp/gametypes/_wager::wagerannouncer("wm_final_weapon");
			}
			else
			{
				player maps/mp/gametypes/_wager::wagerannouncer("wm_weapons_cycled");
			}

			player checkawardmostpointsthiscycle();
		}

		if(ispenultimateround)
		{
			level.sharpshootermultiplier = 2;
			for(i = 0;i < level.players.size;i++)
			{
				level.players[i] thread maps/mp/gametypes/_wager::queuewagerpopup(&"MP_SHRP_PENULTIMATE_RND",0,&"MP_SHRP_PENULTIMATE_MULTIPLIER","wm_bonus_rnd");
			}
		}
		else if(issharpshooterround)
		{
			lastmultiplier = level.sharpshootermultiplier;
			if(!(IsDefined(lastmultiplier)))
			{
				lastmultiplier = 1;
			}

			level.sharpshootermultiplier = 2;
			setdvar("ui_guncycle",0);
			level.guncycletimer.alpha = 0;
			for(i = 0;i < level.players.size;i++)
			{
				level.players[i] thread maps/mp/gametypes/_wager::queuewagerpopup(&"MP_SHRP_RND",0,&"MP_SHRP_FINAL_MULTIPLIER","wm_shrp_rnd");
			}

			break;
		}
		else
		{
			level.sharpshootermultiplier = 1;
		}

		guncycle++;
	}
}

//Function Number: 11
checkawardmostpointsthiscycle()
{
	if(IsDefined(self.currentguncyclepoints) && self.currentguncyclepoints > 0)
	{
		if(self.currentguncyclepoints == level.currentguncyclemaxpoints)
		{
			maps/mp/_scoreevents::processscoreevent("most_points_shrp",self);
		}
	}
}

//Function Number: 12
awardmostpointsmedalgameend()
{
	level waittill("game_end");
	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] checkawardmostpointsthiscycle();
	}
}

//Function Number: 13
givecustomloadout(takeallweapons,alreadyspawned)
{
	chooserandombody = 0;
	if(!IsDefined(alreadyspawned) || !alreadyspawned)
	{
		chooserandombody = 1;
	}

	self maps/mp/gametypes/_wager::setupblankrandomplayer(takeallweapons,chooserandombody,level.shrprandomweapon);
	self disableweaponcycling();
	self giveweapon(level.shrprandomweapon);
	self switchtoweapon(level.shrprandomweapon);
	self giveweapon("knife_mp");
	if(!IsDefined(alreadyspawned) || !alreadyspawned)
	{
		self setspawnweapon(level.shrprandomweapon);
	}

	if(IsDefined(takeallweapons) && !takeallweapons)
	{
		self thread takeoldweapons();
	}
	else
	{
		self enableweaponcycling();
	}

	return level.shrprandomweapon;
}

//Function Number: 14
takeoldweapons()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("weapon_change",newweapon);
		if(newweapon != "none")
		{
			break;
		}
	}

	weaponslist = self getweaponslist();
	for(i = 0;i < weaponslist.size;i++)
	{
		if(weaponslist[i] != level.shrprandomweapon && weaponslist[i] != "knife_mp")
		{
			self takeweapon(weaponslist[i]);
		}
	}

	self enableweaponcycling();
}

//Function Number: 15
onplayerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	if(IsDefined(attacker) && isplayer(attacker) && attacker != self)
	{
		if(IsDefined(level.sharpshootermultiplier) && level.sharpshootermultiplier == 2)
		{
			if(!(IsDefined(attacker.pers["x2kills"])))
			{
				attacker.pers["x2kills"] = 1;
			}
			else
			{
				attacker.pers["x2kills"]++;
			}

			attacker.x2kills = attacker.pers["x2kills"];
		}
		else if(IsDefined(level.sharpshootermultiplier) && level.sharpshootermultiplier == 3)
		{
			if(!(IsDefined(attacker.pers["x3kills"])))
			{
				attacker.pers["x3kills"] = 1;
			}
			else
			{
				attacker.pers["x3kills"]++;
			}

			attacker.x2kills = attacker.pers["x3kills"];
		}

		if(IsDefined(self.scoremultiplier) && self.scoremultiplier >= 2)
		{
			maps/mp/_scoreevents::processscoreevent("kill_x2_score_shrp",attacker,self,sweapon);
		}

		currentbonus = attacker.currentbonus;
		if(!(IsDefined(currentbonus)))
		{
			currentbonus = 0;
		}

		if(currentbonus < level.poweruplist.size)
		{
			attacker maps/mp/gametypes/_wager::givepowerup(level.poweruplist[currentbonus]);
			attacker thread maps/mp/gametypes/_wager::wagerannouncer("wm_bonus" + currentbonus);
			if(level.poweruplist[currentbonus].type == "score_multiplier" && attacker.scoremultiplier == 2)
			{
				maps/mp/_scoreevents::processscoreevent("x2_score_shrp",attacker,self,sweapon);
			}

			currentbonus++;
			attacker.currentbonus = currentbonus;
		}

		if(currentbonus >= level.poweruplist.size)
		{
			if(IsDefined(attacker.powerups) && IsDefined(attacker.powerups.size) && attacker.powerups.size > 0)
			{
				attacker thread maps/mp/gametypes/_wager::pulsepowerupicon(attacker.powerups.size - 1);
			}
		}

		scoremultiplier = 1;
		if(IsDefined(attacker.scoremultiplier))
		{
			scoremultiplier = attacker.scoremultiplier;
		}

		if(IsDefined(level.sharpshootermultiplier))
		{
			scoremultiplier = scoremultiplier * level.sharpshootermultiplier;
		}

		scoreincrease = attacker.pointstowin;
		for(i = 1;i <= scoremultiplier;i++)
		{
			if(smeansofdeath == "MOD_MELEE" && level.shrprandomweapon != "knife_mp" && level.shrprandomweapon != "riotshield_mp")
			{
				attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.pointspermeleekill);
				if(i != 1)
				{
					maps/mp/_scoreevents::processscoreevent("kill",attacker,self,sweapon);
					maps/mp/_scoreevents::processscoreevent("wager_melee_kill",attacker,self,sweapon);
				}
			}
			else
			{
				attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.pointsperweaponkill);
				if(!(IsDefined(attacker.currentguncyclepoints)))
				{
					attacker.currentguncyclepoints = 0;
				}

				attacker.currentguncyclepoints = attacker.currentguncyclepoints + level.pointsperweaponkill;
				if(level.currentguncyclemaxpoints < attacker.currentguncyclepoints)
				{
					level.currentguncyclemaxpoints = attacker.currentguncyclepoints;
				}

				if(i != 1)
				{
					maps/mp/_scoreevents::processscoreevent("kill",attacker,self,sweapon);
				}
			}
		}

		scoreincrease = attacker.pointstowin - scoreincrease;
		if(scoremultiplier > 1 || IsDefined(level.sharpshootermultiplier) && level.sharpshootermultiplier > 1)
		{
			attacker playlocalsound("uin_alert_cash_register");
			attacker.pers["x2score"] = attacker.pers["x2score"] + scoreincrease;
			attacker.x2score = attacker.pers["x2score"];
		}
	}

	self.currentbonus = 0;
	self.scoremultiplier = 1;
	self maps/mp/gametypes/_wager::clearpowerups();
}

//Function Number: 16
onspawnplayerunified()
{
	maps/mp/gametypes/_spawning::onspawnplayer_unified();
	self thread infiniteammo();
}

//Function Number: 17
onspawnplayer(predictedspawn)
{
	spawnpoints = maps/mp/gametypes/_spawnlogic::getteamspawnpoints(self.pers["team"]);
	spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_dm(spawnpoints);
	if(predictedspawn)
	{
		self predictspawnpoint(spawnpoint.origin,spawnpoint.angles);
	}
	else
	{
		self spawn(spawnpoint.origin,spawnpoint.angles,"shrp");
		self thread infiniteammo();
	}
}

//Function Number: 18
infiniteammo()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(0.1);
		weapon = self getcurrentweapon();
		self givemaxammo(weapon);
	}
}

//Function Number: 19
onwagerawards()
{
	x2kills = self maps/mp/gametypes/_globallogic_score::getpersstat("x2kills");
	if(!(IsDefined(x2kills)))
	{
		x2kills = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",x2kills,0);
	headshots = self maps/mp/gametypes/_globallogic_score::getpersstat("headshots");
	if(!(IsDefined(headshots)))
	{
		headshots = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",headshots,1);
	bestkillstreak = self maps/mp/gametypes/_globallogic_score::getpersstat("best_kill_streak");
	if(!(IsDefined(bestkillstreak)))
	{
		bestkillstreak = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",bestkillstreak,2);
}

//Function Number: 20
clearpowerupsongameend()
{
	level waittill("game_ended");
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		player maps/mp/gametypes/_wager::clearpowerups();
	}
}
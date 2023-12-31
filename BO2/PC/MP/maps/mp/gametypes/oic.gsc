/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\oic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 8 ms
 * Timestamp: 10/28/2023 12:10:40 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_score;
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
	level.pointsforsurvivalbonus = getgametypesetting("pointsForSurvivalBonus");
	registertimelimit(0,1440);
	registerscorelimit(0,50000);
	registerroundlimit(0,10);
	registerroundwinlimit(0,10);
	registernumlives(1,100);
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.onspawnplayerunified = ::onspawnplayerunified;
	level.givecustomloadout = ::givecustomloadout;
	level.onplayerkilled = ::onplayerkilled;
	level.onplayerdamage = ::onplayerdamage;
	level.onwagerawards = ::onwagerawards;
	game["dialog"]["gametype"] = "oic_start";
	game["dialog"]["wm_2_lives"] = "oic_2life";
	game["dialog"]["wm_final_life"] = "oic_last";
	precachestring(&"MPUI_PLAYER_KILLED");
	precachestring(&"MP_PLUS_ONE_BULLET");
	precachestring(&"MP_OIC_SURVIVOR_BONUS");
	precacheitem("kard_wager_mp");
	setscoreboardcolumns("pointstowin","kills","deaths","stabs","survived");
}

//Function Number: 2
onplayerdamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime)
{
	if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT")
	{
		idamage = self.maxhealth + 1;
	}

	return idamage;
}

//Function Number: 3
givecustomloadout()
{
	weapon = "kard_wager_mp";
	self maps/mp/gametypes/_wager::setupblankrandomplayer(1,1,weapon);
	self giveweapon(weapon);
	self giveweapon("knife_mp");
	self switchtoweapon(weapon);
	clipammo = 1;
	if(IsDefined(self.pers["clip_ammo"]))
	{
		clipammo = self.pers["clip_ammo"];
		self.pers["clip_ammo"] = undefined;
	}

	self setweaponammoclip(weapon,clipammo);
	stockammo = 0;
	if(IsDefined(self.pers["stock_ammo"]))
	{
		stockammo = self.pers["stock_ammo"];
		self.pers["stock_ammo"] = undefined;
	}

	self setweaponammostock(weapon,stockammo);
	self setspawnweapon(weapon);
	self setperk("specialty_unlimitedsprint");
	self setperk("specialty_movefaster");
	return weapon;
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	setobjectivetext("allies",&"OBJECTIVES_DM");
	setobjectivetext("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DM");
		setobjectivescoretext("axis",&"OBJECTIVES_DM");
	}
	else
	{
		setobjectivescoretext("allies",&"OBJECTIVES_DM_SCORE");
		setobjectivescoretext("axis",&"OBJECTIVES_DM_SCORE");
	}

	allowed[0] = "oic";
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
	level.displayroundendtext = 0;
	if(level.roundlimit != 1 && level.numlives)
	{
		level.overrideplayerscore = 1;
		level.displayroundendtext = 1;
		level.onendgame = ::onendgame;
	}

	level thread watchelimination();
	setobjectivehinttext("allies",&"OBJECTIVES_OIC_HINT");
	setobjectivehinttext("axis",&"OBJECTIVES_OIC_HINT");
}

//Function Number: 5
onspawnplayerunified()
{
	maps/mp/gametypes/_spawning::onspawnplayer_unified();
	livesleft = self.pers["lives"];
	if(livesleft == 2)
	{
		self maps/mp/gametypes/_wager::wagerannouncer("wm_2_lives");
	}
	else if(livesleft == 1)
	{
		self maps/mp/gametypes/_wager::wagerannouncer("wm_final_life");
	}
}

//Function Number: 6
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
		self spawn(spawnpoint.origin,spawnpoint.angles,"oic");
	}
}

//Function Number: 7
onendgame(winningplayer)
{
	if(IsDefined(winningplayer) && isplayer(winningplayer))
	{
		[[ level._setplayerscore ]](winningplayer,[[ level._getplayerscore ]](winningplayer) + 1);
	}
}

//Function Number: 8
onstartwagersidebets()
{
	thread saveoffallplayersammo();
}

//Function Number: 9
saveoffallplayersammo()
{
	wait(1);
	for(playerindex = 0;playerindex < level.players.size;playerindex++)
	{
		player = level.players[playerindex];
		if(!(IsDefined(player)))
		{
		}
		else if(player.pers["lives"] == 0)
		{
		}
		else
		{
			currentweapon = player getcurrentweapon();
			player.pers["clip_ammo"] = player getweaponammoclip(currentweapon);
			player.pers["stock_ammo"] = player getweaponammostock(currentweapon);
		}
	}
}

//Function Number: 10
isplayereliminated(player)
{
	return IsDefined(player.pers["eliminated"]) && player.pers["eliminated"];
}

//Function Number: 11
getplayersleft()
{
	playersremaining = [];
	for(playerindex = 0;playerindex < level.players.size;playerindex++)
	{
		player = level.players[playerindex];
		if(!(IsDefined(player)))
		{
		}
		else if(!(isplayereliminated(player)))
		{
			playersremaining[playersremaining.size] = player;
		}
	}

	return playersremaining;
}

//Function Number: 12
onwagerfinalizeround()
{
	playersleft = getplayersleft();
	lastmanstanding = playersleft[0];
	sidebetpool = 0;
	sidebetwinners = [];
	players = level.players;
	for(playerindex = 0;playerindex < players.size;playerindex++)
	{
		if(IsDefined(players[playerindex].pers["sideBetMade"]))
		{
			sidebetpool = sidebetpool + GetDvarInt(#"D9B598A2");
			if(players[playerindex].pers["sideBetMade"] == lastmanstanding.name)
			{
				sidebetwinners[sidebetwinners.size] = players[playerindex];
			}
		}
	}

	if(sidebetwinners.size == 0)
	{
		return;
	}

	sidebetpayout = int(sidebetpool / sidebetwinners.size);
	for(index = 0;index < sidebetwinners.size;index++)
	{
		player = sidebetwinners[index];
		player.pers["wager_sideBetWinnings"] = player.pers["wager_sideBetWinnings"] + sidebetpayout;
	}
}

//Function Number: 13
onplayerkilled(einflictor,attacker,idamage,smeansofdeath,sweapon,vdir,shitloc,psoffsettime,deathanimduration)
{
	if(IsDefined(attacker) && isplayer(attacker) && self != attacker)
	{
		attackerammo = attacker getammocount("kard_wager_mp");
		victimammo = self getammocount("kard_wager_mp");
		attacker giveammo(1);
		attacker thread maps/mp/gametypes/_wager::queuewagerpopup(&"MPUI_PLAYER_KILLED",0,&"MP_PLUS_ONE_BULLET");
		attacker playlocalsound("mpl_oic_bullet_pickup");
		if(smeansofdeath == "MOD_MELEE")
		{
			attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.pointspermeleekill);
			if(attackerammo > 0)
			{
				maps/mp/_scoreevents::processscoreevent("knife_with_ammo_oic",attacker,self,sweapon);
			}

			if(victimammo > attackerammo)
			{
				maps/mp/_scoreevents::processscoreevent("kill_enemy_with_more_ammo_oic",attacker,self,sweapon);
			}
		}
		else
		{
			attacker maps/mp/gametypes/_globallogic_score::givepointstowin(level.pointsperweaponkill);
			if(victimammo > attackerammo + 1)
			{
				maps/mp/_scoreevents::processscoreevent("kill_enemy_with_more_ammo_oic",attacker,self,sweapon);
			}
		}

		if(self.pers["lives"] == 0)
		{
			maps/mp/_scoreevents::processscoreevent("eliminate_oic",attacker,self,sweapon);
		}
	}
}

//Function Number: 14
giveammo(amount)
{
	currentweapon = self getcurrentweapon();
	clipammo = self getweaponammoclip(currentweapon);
	self setweaponammoclip(currentweapon,clipammo + amount);
}

//Function Number: 15
shouldreceivesurvivorbonus()
{
	if(isalive(self))
	{
		return 1;
	}

	if(self.hasspawned && self.pers["lives"] > 0)
	{
		return 1;
	}
}

//Function Number: 16
watchelimination()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_eliminated");
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			if(IsDefined(players[i]) && players[i] shouldreceivesurvivorbonus())
			{
				players[i].pers["survived"]++;
				players[i].survived = players[i].pers["survived"];
				players[i] thread maps/mp/gametypes/_wager::queuewagerpopup(&"MP_OIC_SURVIVOR_BONUS",10);
				score = maps/mp/gametypes/_globallogic_score::_getplayerscore(players[i]);
				maps/mp/_scoreevents::processscoreevent("survivor",players[i]);
				players[i] maps/mp/gametypes/_globallogic_score::givepointstowin(level.pointsforsurvivalbonus);
			}
		}
	}
}

//Function Number: 17
onwagerawards()
{
	stabs = self maps/mp/gametypes/_globallogic_score::getpersstat("stabs");
	if(!(IsDefined(stabs)))
	{
		stabs = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",stabs,0);
	longshots = self maps/mp/gametypes/_globallogic_score::getpersstat("longshots");
	if(!(IsDefined(longshots)))
	{
		longshots = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",longshots,1);
	bestkillstreak = self maps/mp/gametypes/_globallogic_score::getpersstat("best_kill_streak");
	if(!(IsDefined(bestkillstreak)))
	{
		bestkillstreak = 0;
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",bestkillstreak,2);
}
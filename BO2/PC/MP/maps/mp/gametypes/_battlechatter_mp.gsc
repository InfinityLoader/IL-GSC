/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 15 ms
 * Timestamp: 10/28/2023 12:10:28 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	if(level.createfx_enabled)
	{
		return;
	}

	foreach(team in level.teams)
	{
/#
		assert(IsDefined(level.teamprefix[team]));
#/
/#
		assert(IsDefined(level.teamprefix[team]));
#/
		level.isteamspeaking[team] = 0;
		level.speakers[team] = [];
	}

	level.bcsounds = [];
	level.bcsounds["inform_attack"] = "attack";
	level.bcsounds["c4_out"] = "c4";
	level.bcsounds["claymore_out"] = "claymore";
	level.bcsounds["emp_out"] = "emp";
	level.bcsounds["flash_out"] = "flash";
	level.bcsounds["gas_out"] = "gas";
	level.bcsounds["frag_out"] = "grenade";
	level.bcsounds["revive_out"] = "revive";
	level.bcsounds["smoke_out"] = "smoke";
	level.bcsounds["sticky_out"] = "sticky";
	level.bcsounds["gas_incoming"] = "gas";
	level.bcsounds["grenade_incoming"] = "incoming";
	level.bcsounds["kill"] = "kill";
	level.bcsounds["kill_sniper"] = "kill_sniper";
	level.bcsounds["revive"] = "need_revive";
	level.bcsounds["reload"] = "reloading";
	level.bcsounds["enemy"] = "threat";
	level.bcsounds["sniper"] = "sniper";
	level.bcsounds["conc_out"] = "attack_stun";
	level.bcsounds["satchel_plant"] = "attack_throwsatchel";
	level.bcsounds["casualty"] = "casualty_gen";
	level.bcsounds["flare_out"] = "attack_flare";
	level.bcsounds["betty_plant"] = "plant";
	level.bcsounds["landmark"] = "landmark";
	level.bcsounds["taunt"] = "taunt";
	level.bcsounds["killstreak_enemy"] = "enemy";
	level.bcsounds["killstreak_taunt"] = "kls";
	level.bcsounds["kill_killstreak"] = "killstreak";
	level.bcsounds["destructible"] = "destructible_near";
	level.bcsounds["teammate"] = "teammate_near";
	level.bcsounds["gametype"] = "gametype";
	level.bcsounds["squad"] = "squad";
	level.bcsounds["gametype"] = "gametype";
	level.bcsounds["perk"] = "perk_equip";
	level.bcsounds["pain"] = "pain";
	level.bcsounds["death"] = "death";
	level.bcsounds["breathing"] = "breathing";
	level.bcsounds["inform_need"] = "need";
	level.bcsounds["scream"] = "scream";
	level.bcsounds["fire"] = "fire";
	setdvar("bcmp_weapon_delay","2000");
	setdvar("bcmp_weapon_fire_probability","80");
	setdvar("bcmp_weapon_reload_probability","60");
	setdvar("bcmp_weapon_fire_threat_probability","80");
	setdvar("bcmp_sniper_kill_probability","20");
	setdvar("bcmp_ally_kill_probability","60");
	setdvar("bcmp_killstreak_incoming_probability","100");
	setdvar("bcmp_perk_call_probability","100");
	setdvar("bcmp_incoming_grenade_probability","5");
	setdvar("bcmp_toss_grenade_probability","20");
	setdvar("bcmp_toss_trophy_probability","80");
	setdvar("bcmp_kill_inform_probability","40");
	setdvar("bcmp_pain_small_probability","0");
	setdvar("bcmp_breathing_probability","0");
	setdvar("bcmp_pain_delay",".5");
	setdvar("bcmp_last_stand_delay","3");
	setdvar("bcmp_breathing_delay","");
	setdvar("bcmp_enemy_contact_delay","30");
	setdvar("bcmp_enemy_contact_level_delay","15");
	level.bcweapondelay = GetDvarInt(#"9315A47E");
	level.bcweaponfireprobability = GetDvarInt(#"D8DD31D5");
	level.bcweaponreloadprobability = GetDvarInt(#"3BC46746");
	level.bcweaponfirethreatprobability = GetDvarInt(#"50C7E57C");
	level.bcsniperkillprobability = GetDvarInt(#"1D6F5AA2");
	level.bcallykillprobability = GetDvarInt(#"892CBC63");
	level.bckillstreakincomingprobability = GetDvarInt(#"B7B1EDCF");
	level.bcperkcallprobability = GetDvarInt(#"57E10FF3");
	level.bcincominggrenadeprobability = GetDvarInt(#"5FF173AF");
	level.bctossgrenadeprobability = GetDvarInt(#"1E154CA4");
	level.bctosstrophyprobability = GetDvarInt(#"471D69D4");
	level.bckillinformprobability = GetDvarInt(#"C151033C");
	level.bcpainsmallprobability = GetDvarInt(#"F328DB66");
	level.bcpaindelay = GetDvarInt(#"7EDC44DC");
	level.bclaststanddelay = GetDvarInt(#"6E5D54C1");
	level.bcmp_breathing_delay = GetDvarInt(#"53964768");
	level.bcmp_enemy_contact_delay = GetDvarInt(#"BD9F1B3D");
	level.bcmp_enemy_contact_level_delay = GetDvarInt(#"59E10794");
	level.bcmp_breathing_probability = GetDvarInt(#"4BFE2A7A");
	level.allowbattlechatter = getgametypesetting("allowBattleChatter");
	level.landmarks = getentarray("trigger_landmark","targetname");
	level.enemyspotteddialog = 1;
	level thread enemycontactleveldelay();
	level thread onplayerconnect();
	level thread updatebcdvars();
	level.battlechatter_init = 1;
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onjoinedteam();
		player thread onplayerspawned();
	}
}

//Function Number: 3
updatebcdvars()
{
	level endon("game_ended");
	for(;;)
	{
		level.bcweapondelay = GetDvarInt(#"9315A47E");
		level.bckillinformprobability = GetDvarInt(#"C151033C");
		level.bcweaponfireprobability = GetDvarInt(#"D8DD31D5");
		level.bcsniperkillprobability = GetDvarInt(#"1D6F5AA2");
		level thread maps/mp/gametypes/_globallogic::updateteamstatus();
		wait(2);
	}
}

//Function Number: 4
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self.pers["bcVoiceNumber"] = randomintrange(0,3);
		self.pilotisspeaking = 0;
	}
}

//Function Number: 5
onjoinedspectators()
{
	self endon("disconnect");
	self waittill("joined_spectators");
}

//Function Number: 6
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.lastbcattempttime = 0;
		self.heartbeatsnd = 0;
		self.soundmod = "player";
		self.bcvoicenumber = self.pers["bcVoiceNumber"];
		self.pilotisspeaking = 0;
		if(level.splitscreen)
		{
			continue;
		}

		self thread reloadtracking();
		self thread grenadetracking();
		self thread enemythreat();
		self thread stickygrenadetracking();
		self thread painvox();
		self thread allyrevive();
		self thread onfirescream();
		self thread deathvox();
		self thread watchmissileusage();
	}
}

//Function Number: 7
enemycontactleveldelay()
{
	while(1)
	{
		level waittill("level_enemy_spotted");
		level.enemyspotteddialog = 0;
		wait(level.bcmp_enemy_contact_level_delay);
		level.enemyspotteddialog = 1;
	}
}

//Function Number: 8
breathinghurtvox()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("snd_breathing_hurt");
		if(randomintrange(0,100) >= level.bcmp_breathing_probability)
		{
			wait(0.5);
			if(isalive(self))
			{
				level thread mpsaylocalsound(self,"breathing","hurt",0,1);
			}
		}

		wait(level.bcmp_breathing_delay);
	}
}

//Function Number: 9
onfirescream()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("snd_burn_scream");
		if(randomintrange(0,100) >= level.bcmp_breathing_probability)
		{
			wait(0.5);
			if(isalive(self))
			{
				level thread mpsaylocalsound(self,"fire","scream");
			}
		}

		wait(level.bcmp_breathing_delay);
	}
}

//Function Number: 10
breathingbettervox()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("snd_breathing_better");
		if(isalive(self))
		{
			level thread mpsaylocalsound(self,"breathing","better",0,1);
		}
	}
}

//Function Number: 11
laststandvox()
{
	self endon("death");
	self endon("disconnect");
	self waittill("snd_last_stand");
	for(;;)
	{
		self waittill("weapon_fired");
		if(isalive(self))
		{
			level thread mpsaylocalsound(self,"perk","laststand");
		}

		wait(level.bclaststanddelay);
	}
}

//Function Number: 12
allyrevive()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("snd_ally_revive");
		if(isalive(self))
		{
			level thread mpsaylocalsound(self,"inform_attack","revive");
		}

		wait(level.bclaststanddelay);
	}
}

//Function Number: 13
painvox()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("snd_pain_player");
		if(randomintrange(0,100) >= level.bcpainsmallprobability)
		{
			if(isalive(self))
			{
				soundalias = level.teamprefix[self.team] + self.bcvoicenumber + "_" + level.bcsounds["pain"] + "_" + "small";
				self thread dosound(soundalias);
			}
		}

		wait(level.bcpaindelay);
	}
}

//Function Number: 14
deathvox()
{
	self endon("disconnect");
	self waittill("death");
	if(self.team != "spectator")
	{
		soundalias = level.teamprefix[self.team] + self.bcvoicenumber + "_" + level.bcsounds["pain"] + "_" + "death";
		self thread dosound(soundalias);
	}
}

//Function Number: 15
stickygrenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("sticky_explode");
	for(;;)
	{
		self waittill("grenade_stuck",grenade);
		if(IsDefined(grenade))
		{
			grenade.stucktoplayer = self;
		}

		if(isalive(self))
		{
			level thread mpsaylocalsound(self,"grenade_incoming","sticky");
		}

		self notify("sticky_explode");
	}
}

//Function Number: 16
onplayersuicideorteamkill(player,type)
{
	self endon("disconnect");
	waittillframeend;
	if(!(IsDefined(level.battlechatter_init)))
	{
		return;
	}

	if(!(level.teambased))
	{
		return;
	}

	myteam = player.team;
	if(IsDefined(level.aliveplayers[myteam]))
	{
		if(level.aliveplayers[myteam].size)
		{
			index = checkdistancetoevent(player,1000000);
			if(IsDefined(index))
			{
				wait(1);
				if(isalive(level.aliveplayers[myteam][index]))
				{
					level thread mpsaylocalsound(level.aliveplayers[myteam][index],"teammate",type);
				}
			}
		}
	}
}

//Function Number: 17
onplayerkillstreak(player)
{
	player endon("disconnect");
}

//Function Number: 18
onkillstreakused(killstreak,team)
{
}

//Function Number: 19
onplayernearexplodable(object,type)
{
	self endon("disconnect");
	self endon("explosion_started");
}

//Function Number: 20
shoeboxtracking()
{
	self endon("death");
	self endon("disconnect");
	while(1)
	{
		self waittill("begin_firing");
		weaponname = self getcurrentweapon();
		if(weaponname == "mine_shoebox_mp")
		{
			level thread mpsaylocalsound(self,"satchel_plant","shoebox");
		}
	}
}

//Function Number: 21
checkweaponreload(weapon)
{
	switch(weapon)
	{
		case "crossbow_mp":
		case "fhj18_mp":
		case "judge_mp":
		case "smaw_mp":
		case "usrpg_mp":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 22
reloadtracking()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload_start");
		if(randomintrange(0,100) >= level.bcweaponreloadprobability)
		{
			weaponname = self getcurrentweapon();
			weaponshouldreload = checkweaponreload(weaponname);
			if(weaponshouldreload)
			{
				level thread mpsaylocalsound(self,"reload","gen");
			}
		}
	}
}

//Function Number: 23
perkspecificbattlechatter(type,checkdistance)
{
	self endon("death");
	self endon("disconnect");
	self endon("perk_done");
}

//Function Number: 24
enemythreat()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired");
		if(level.enemyspotteddialog)
		{
			if(GetTime() - self.lastbcattempttime > level.bcmp_enemy_contact_delay)
			{
				shooter = self;
				myteam = self.team;
				closest_enemy = shooter get_closest_player_enemy();
				self.lastbcattempttime = GetTime();
				if(IsDefined(closest_enemy))
				{
					if(randomintrange(0,100) >= level.bcweaponfirethreatprobability)
					{
						area = 360000;
						if(distancesquared(closest_enemy.origin,self.origin) < area)
						{
							level thread mpsaylocalsound(closest_enemy,"enemy","infantry",0);
							level notify("level_enemy_spotted");
						}
					}
				}
			}
		}
	}
}

//Function Number: 25
weaponfired()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired");
		if(GetTime() - self.lastbcattempttime > level.bcweapondelay)
		{
			self.lastbcattempttime = GetTime();
			if(randomintrange(0,100) >= level.bcweaponfireprobability)
			{
				self.landmarkent = self getlandmark();
				if(IsDefined(self.landmarkent))
				{
					myteam = self.team;
					foreach(team in level.teams)
					{
						if(team == myteam)
						{
						}
						else
						{
							keys = getarraykeys(level.squads[team]);
							for(i = 0;i < keys.size;i++)
							{
								if(level.squads[team][keys[i]].size)
								{
									index = randomintrange(0,level.squads[team][keys[i]].size);
									level thread mpsaylocalsound(level.squads[team][keys[i]][index],"enemy","infantry");
								}
							}
						}
					}
				}
			}
		}
	}
}

//Function Number: 26
killedbysniper(sniper)
{
	self endon("disconnect");
	sniper endon("disconnect");
	waittillframeend;
	if(!(IsDefined(level.battlechatter_init)))
	{
		return;
	}

	victim = self;
	if(level.hardcoremode || !level.teambased)
	{
		return;
	}

	sniper.issniperspotted = 1;
	if(randomintrange(0,100) >= level.bcsniperkillprobability)
	{
		sniperteam = sniper.team;
		victimteam = self.team;
		index = checkdistancetoevent(victim,1000000);
		if(IsDefined(index))
		{
			level thread mpsaylocalsound(level.aliveplayers[victimteam][index],"enemy","sniper",0);
		}
	}
}

//Function Number: 27
playerkilled(attacker)
{
	self endon("disconnect");
	if(!(isplayer(attacker)))
	{
		return;
	}

	waittillframeend;
	if(!(IsDefined(level.battlechatter_init)))
	{
		return;
	}

	victim = self;
	if(level.hardcoremode)
	{
		return;
	}

	if(randomintrange(0,100) >= level.bcallykillprobability)
	{
		attackerteam = attacker.team;
		victimteam = self.team;
		closest_ally = victim get_closest_player_ally();
		area = 1000000;
		if(IsDefined(closest_ally))
		{
			if(distancesquared(closest_ally.origin,self.origin) < area)
			{
				level thread mpsaylocalsound(closest_ally,"inform_attack","revive",0);
			}
		}
	}
}

//Function Number: 28
grenadetracking()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",grenade,weaponname);
		if(weaponname == "frag_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","grenade");
			}

			level thread incominggrenadetracking(self,grenade,"grenade");
			continue;
		}

		if(weaponname == "satchel_charge_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","c4");
			}

			continue;
		}

		if(weaponname == "emp_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","emp");
			}

			continue;
		}

		if(weaponname == "claymore_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","claymore");
			}

			continue;
		}

		if(weaponname == "flash_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","flash");
			}

			continue;
		}

		if(weaponname == "sticky_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","sticky");
			}

			continue;
		}

		if(weaponname == "tabun_gas_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","gas");
			}

			continue;
		}

		if(weaponname == "willy_pete_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","smoke");
			}

			continue;
		}

		if(weaponname == "hatchet_mp" || weaponname == "proximity_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","hatchet");
			}

			continue;
		}

		if(weaponname == "concussion_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","concussion");
			}

			continue;
		}

		if(weaponname == "scrambler_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","scrambler");
			}

			continue;
		}

		if(weaponname == "tactical_insertion_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","tactical");
			}

			continue;
		}

		if(weaponname == "bouncingbetty_mp")
		{
			if(randomintrange(0,100) >= level.bctosstrophyprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","c4");
			}

			continue;
		}

		if(weaponname == "sensor_grenade_mp")
		{
			if(randomintrange(0,100) >= level.bctossgrenadeprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","hatchet");
			}

			continue;
		}

		if(weaponname == "trophy_system_mp")
		{
			if(randomintrange(0,100) >= level.bctosstrophyprobability)
			{
				level thread mpsaylocalsound(self,"inform_attack","scrambler");
			}
		}
	}
}

//Function Number: 29
watchmissileusage()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("missile_fire",missile,weapon_name);
		if(weapon_name == "usrpg_mp")
		{
			level thread incominggrenadetracking(self,missile,"rpg",0.2);
			continue;
		}

		return;
	}
}

//Function Number: 30
incominggrenadetracking(thrower,grenade,type,waittime)
{
	if(randomintrange(0,100) >= level.bcincominggrenadeprobability)
	{
		if(!(IsDefined(waittime)))
		{
			waittime = 1;
		}

		wait(waittime);
		if(!(IsDefined(thrower)))
		{
			return;
		}

		if(thrower.team == "spectator")
		{
			return;
		}

		enemyteam = thrower.team;
		if(level.players.size)
		{
			player = checkdistancetoobject(250000,grenade,enemyteam,thrower);
			if(IsDefined(player))
			{
				level thread mpsaylocalsound(player,"grenade_incoming",type);
			}
		}
	}
}

//Function Number: 31
incomingspecialgrenadetracking(type)
{
	self endon("death");
	self endon("disconnect");
	self endon("grenade_ended");
	for(;;)
	{
		if(randomintrange(0,100) >= level.bcincominggrenadeprobability)
		{
			if(level.aliveplayers[self.team].size || !level.teambased && level.players.size)
			{
				level thread mpsaylocalsound(self,"grenade_incoming",type);
				self notify("grenade_ended");
			}
		}

		wait(3);
	}
}

//Function Number: 32
gametypespecificbattlechatter(event,team)
{
	self endon("death");
	self endon("disconnect");
	self endon("event_ended");
	for(;;)
	{
		if(IsDefined(team))
		{
			index = checkdistancetoevent(self,90000);
			if(IsDefined(index))
			{
				level thread mpsaylocalsound(level.aliveplayers[team][index],"gametype",event);
				self notify("event_ended");
			}
		}
		else
		{
			foreach(team in level.teams)
			{
				index = randomintrange(0,level.aliveplayers[team].size);
				level thread mpsaylocalsound(level.aliveplayers[team][index],"gametype",event);
			}
		}

		wait(1);
	}
}

//Function Number: 33
checkweaponkill(weapon)
{
	switch(weapon)
	{
		case "cobra_20mm_comlink_mp":
		case "knife_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 34
saykillbattlechatter(attacker,sweapon,victim)
{
	if(checkweaponkill(sweapon))
	{
		return;
	}

	if(IsDefined(victim.issniperspotted) && victim.issniperspotted && randomintrange(0,100) >= level.bckillinformprobability)
	{
		level thread saylocalsounddelayed(attacker,"kill","sniper",0.75);
		victim.issniperspotted = 0;
	}
	else if(IsDefined(level.bckillinformprobability) && randomintrange(0,100) >= level.bckillinformprobability)
	{
		if(!(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon)))
		{
			level thread saylocalsounddelayed(attacker,"kill","infantry",0.75);
		}
	}
}

//Function Number: 35
saylocalsounddelayed(player,soundtype1,soundtype2,delay)
{
	player endon("death");
	player endon("disconnect");
	if(!(IsDefined(level.battlechatter_init)))
	{
		return;
	}

	wait(delay);
	mpsaylocalsound(player,soundtype1,soundtype2);
}

//Function Number: 36
saylocalsound(player,soundtype)
{
	player endon("death");
	player endon("disconnect");
	if(isspeakerinrange(player))
	{
		return;
	}

	if(player.team != "spectator")
	{
		soundalias = level.teamprefix[player.team] + player.bcvoicenumber + "_" + level.bcsounds[soundtype];
	}
}

//Function Number: 37
mpsaylocalsound(player,partone,parttwo,checkspeakers,is2d)
{
	player endon("death");
	player endon("disconnect");
	if(level.players.size <= 1)
	{
		return;
	}

	if(!(IsDefined(checkspeakers)))
	{
		if(isspeakerinrange(player))
		{
			return;
		}
	}

	if(player hasperk("specialty_quieter"))
	{
		return;
	}

	if(player.team != "spectator")
	{
		soundalias = level.teamprefix[player.team] + player.bcvoicenumber + "_" + level.bcsounds[partone] + "_" + parttwo;
		if(IsDefined(is2d))
		{
			player thread dosound(soundalias,is2d);
		}
		else
		{
			player thread dosound(soundalias);
		}
	}
}

//Function Number: 38
mpsaylocationallocalsound(player,prefix,partone,parttwo)
{
	player endon("death");
	player endon("disconnect");
	if(level.players.size <= 1)
	{
		return;
	}

	if(isspeakerinrange(player))
	{
		return;
	}

	if(player.team != "spectator")
	{
		soundalias1 = level.teamprefix[player.team] + player.bcvoicenumber + "_" + level.bcsounds[prefix];
		soundalias2 = level.teamprefix[player.team] + player.bcvoicenumber + "_" + level.bcsounds[partone] + "_" + parttwo;
		player thread dolocationalsound(soundalias1,soundalias2);
	}
}

//Function Number: 39
dosound(soundalias,is2d)
{
	team = self.team;
	level addspeaker(self,team);
	if(IsDefined(is2d))
	{
		self playlocalsound(soundalias);
	}
	else if(level.allowbattlechatter && level.teambased)
	{
		self playsoundontag(soundalias,"J_Head");
	}

	self thread waitplaybacktime(soundalias);
	self waittill_any(soundalias,"death","disconnect");
	level removespeaker(self,team);
}

//Function Number: 40
dolocationalsound(soundalias1,soundalias2)
{
	team = self.team;
	level addspeaker(self,team);
	if(level.allowbattlechatter && level.teambased)
	{
		self playbattlechattertoteam(soundalias1,soundalias2,team,self);
	}

	self thread waitplaybacktime(soundalias1);
	self waittill_any(soundalias1,"death","disconnect");
	level removespeaker(self,team);
}

//Function Number: 41
waitplaybacktime(soundalias)
{
	self endon("death");
	self endon("disconnect");
	playbacktime = soundgetplaybacktime(soundalias);
	if(playbacktime >= 0)
	{
		waittime = playbacktime * 0.001;
		wait(waittime);
	}
	else
	{
		wait(1);
	}

	self notify(soundalias);
}

//Function Number: 42
isspeakerinrange(player)
{
	player endon("death");
	player endon("disconnect");
	distsq = 1000000;
	if(IsDefined(player) && IsDefined(player.team) && player.team != "spectator")
	{
		for(index = 0;index < level.speakers[player.team].size;index++)
		{
			teammate = level.speakers[player.team][index];
			if(teammate == player)
			{
				return 1;
			}

			if(distancesquared(teammate.origin,player.origin) < distsq)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 43
addspeaker(player,team)
{
	level.speakers[team][level.speakers[team].size] = player;
}

//Function Number: 44
removespeaker(player,team)
{
	newspeakers = [];
	for(index = 0;index < level.speakers[team].size;index++)
	{
		if(level.speakers[team][index] == player)
		{
		}
		else
		{
			newspeakers[newspeakers.size] = level.speakers[team][index];
		}
	}

	level.speakers[team] = newspeakers;
}

//Function Number: 45
getlandmark()
{
	landmarks = level.landmarks;
	for(i = 0;i < landmarks.size;i++)
	{
		if(self istouching(landmarks[i]) && IsDefined(landmarks[i].script_landmark))
		{
			return landmarks[i];
		}
	}

	return undefined;
}

//Function Number: 46
checkdistancetoevent(player,area)
{
	if(!(IsDefined(player)))
	{
		return undefined;
	}

	for(index = 0;index < level.aliveplayers[player.team].size;index++)
	{
		teammate = level.aliveplayers[player.team][index];
		if(!(IsDefined(teammate)))
		{
		}
		else if(teammate == player)
		{
		}
		else if(distancesquared(teammate.origin,player.origin) < area)
		{
			return index;
		}
	}
}

//Function Number: 47
checkdistancetoenemy(enemy,area,team)
{
	if(!(IsDefined(enemy)))
	{
		return undefined;
	}

	for(index = 0;index < level.aliveplayers[team].size;index++)
	{
		player = level.aliveplayers[team][index];
		if(distancesquared(enemy.origin,player.origin) < area)
		{
			return index;
		}
	}
}

//Function Number: 48
checkdistancetoobject(area,object,ignoreteam,ignoreent)
{
	if(IsDefined(ignoreteam))
	{
		foreach(team in level.teams)
		{
			for(i = 0;i < level.aliveplayers[team].size;i++)
			{
				player = level.aliveplayers[team][i];
				if(IsDefined(ignoreent) && player == ignoreent)
				{
				}
				else if(IsDefined(object) && distancesquared(player.origin,object.origin) < area)
				{
					return player;
				}
			}
		}
	}
	else
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(IsDefined(ignoreent) && player == ignoreent)
			{
			}
			else if(isalive(player))
			{
				if(IsDefined(object) && distancesquared(player.origin,object.origin) < area)
				{
					return player;
				}
			}
		}
	}
}

//Function Number: 49
get_closest_player_enemy()
{
	players = getplayers();
	players = arraysort(players,self.origin);
	foreach(player in players)
	{
		if(!IsDefined(player) || !isalive(player))
		{
		}
		else if(player.sessionstate != "playing")
		{
		}
		else if(player == self)
		{
		}
		else if(level.teambased && self.team == player.team)
		{
		}
		else
		{
			return player;
		}
	}

	return undefined;
}

//Function Number: 50
get_closest_player_ally()
{
	if(!(level.teambased))
	{
		return undefined;
	}

	players = getplayers(self.team);
	players = arraysort(players,self.origin);
	foreach(player in players)
	{
		if(!IsDefined(player) || !isalive(player))
		{
		}
		else if(player.sessionstate != "playing")
		{
		}
		else if(player == self)
		{
		}
		else
		{
			return player;
		}
	}

	return undefined;
}
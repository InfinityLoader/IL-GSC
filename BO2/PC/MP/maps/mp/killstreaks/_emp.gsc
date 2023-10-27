/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_emp.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 3:00:36 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_tacticalinsertion;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_emp;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
	foreach(team in level.teams)
	{
		level.teamemping[team] = 0;
	}

	level.empplayer = undefined;
	level.emptimeout = 40;
	level.empowners = [];
	if(level.teambased)
	{
		level thread emp_teamtracker();
	}
	else
	{
		level thread emp_playertracker();
	}

	level thread onplayerconnect();
	registerkillstreak("emp_mp","emp_mp","killstreak_emp","emp_used",::emp_use);
	registerkillstreakstrings("emp_mp",&"KILLSTREAK_EARNED_EMP",&"KILLSTREAK_EMP_NOT_AVAILABLE",&"KILLSTREAK_EMP_INBOUND");
	registerkillstreakdialog("emp_mp","mpl_killstreak_emp_activate","kls_emp_used","","kls_emp_enemy","","kls_emp_ready");
	registerkillstreakdevdvar("emp_mp","scr_giveemp");
	maps/mp/killstreaks/_killstreaks::createkillstreaktimer("emp_mp");
/#
	set_dvar_float_if_unset("scr_emp_timeout",40);
	set_dvar_int_if_unset("scr_emp_damage_debug",0);
#/
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if((level.teambased && emp_isteamemped(self.team)) || !level.teambased && IsDefined(level.empplayer) && level.empplayer != self)
		{
			self setempjammed(1);
		}
	}
}

//Function Number: 4
emp_isteamemped(check_team)
{
	foreach(team in level.teams)
	{
		if(team == check_team)
		{
		}
		else if(level.teamemping[team])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
emp_use(lifeid)
{
/#
	assert(IsDefined(self));
#/
	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart("emp_mp",self.team,0,1);
	if(killstreak_id == -1)
	{
		return 0;
	}

	myteam = self.pers["team"];
	if(level.teambased)
	{
		self thread emp_jamotherteams(myteam,killstreak_id);
	}
	else
	{
		self thread emp_jamplayers(self,killstreak_id);
	}

	self.emptime = GetTime();
	self notify("used_emp");
	self playlocalsound("mpl_killstreak_emp_activate");
	self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("emp_mp",self.pers["team"]);
	level.globalkillstreakscalled++;
	self addweaponstat("emp_mp","used",1);
	return 1;
}

//Function Number: 6
emp_jamotherteams(teamname,killstreak_id)
{
	level endon("game_ended");
	overlays = [];
/#
	assert(IsDefined(level.teams[teamname]));
#/
	level notify("EMP_JamOtherTeams" + teamname);
	level endon("EMP_JamOtherTeams" + teamname);
	level.empowners[teamname] = self;
	foreach(player in level.players)
	{
		if(player.team == teamname)
		{
		}
		else
		{
			player playlocalsound("mpl_killstreak_emp_blast_front");
		}
	}

	visionsetnaked("flash_grenade",1.5);
	thread empeffects();
	wait(0.1);
	visionsetnaked("flash_grenade",0);
	if(IsDefined(level.nukedetonated))
	{
		visionsetnaked(level.nukevisionset,5);
	}
	else
	{
		visionsetnaked(GetDvar(#"B4B895C4"),5);
	}

	level.teamemping[teamname] = 1;
	level notify("emp_update",_k121);
	level destroyotherteamsactivevehicles(self,teamname);
	level destroyotherteamsequipment(self,teamname);
/#
	level.emptimeout = GetDvarFloat(#"35E553D4");
#/
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpauseemp(level.emptimeout);
	level.teamemping[teamname] = 0;
	maps/mp/killstreaks/_killstreakrules::killstreakstop("emp_mp",teamname,killstreak_id);
	level.empowners[teamname] = undefined;
	level notify("emp_update");
	level notify("emp_end" + teamname);
}

//Function Number: 7
emp_jamplayers(owner,killstreak_id)
{
	level notify("EMP_JamPlayers");
	level endon("EMP_JamPlayers");
	overlays = [];
/#
	assert(IsDefined(owner));
#/
	foreach(player in level.players)
	{
		if(player == owner)
		{
		}
		else
		{
			player playlocalsound("mpl_killstreak_emp_blast_front");
		}
	}

	visionsetnaked("flash_grenade",1.5);
	thread empeffects();
	wait(0.1);
	visionsetnaked("flash_grenade",0);
	if(IsDefined(level.nukedetonated))
	{
		visionsetnaked(level.nukevisionset,5);
	}
	else
	{
		visionsetnaked(GetDvar(#"B4B895C4"),5);
	}

	level notify("emp_update",_k180);
	level.empplayer = owner;
	level.empplayer thread empplayerffadisconnect();
	level destroyactivevehicles(owner);
	level destroyequipment(owner);
	level notify("emp_update");
/#
	level.emptimeout = GetDvarFloat(#"35E553D4");
#/
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpause(level.emptimeout);
	maps/mp/killstreaks/_killstreakrules::killstreakstop("emp_mp",level.empplayer.team,killstreak_id);
	level.empplayer = undefined;
	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 8
empplayerffadisconnect()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

//Function Number: 9
empeffects()
{
	foreach(player in level.players)
	{
		playerforward = AnglesToForward(player.angles);
		playerforward = (playerforward[0],playerforward[1],0);
		playerforward = vectornormalize(playerforward);
		empdistance = 20000;
		empent = spawn("script_model",8000 + VectorScale((0,0,1)) + playerforward * empdistance);
		empent setmodel("tag_origin");
		empent.angles = 270 + VectorScale((1,0,0));
		empent thread empeffect(player);
	}
}

//Function Number: 10
empeffect(player)
{
	player endon("disconnect");
	self setinvisibletoall();
	self setvisibletoplayer(player);
	wait(0.5);
	playfxontag(level._effect["emp_flash"],self,"tag_origin");
	self playsound("wpn_emp_bomb");
	self deleteaftertime(11);
}

//Function Number: 11
emp_teamtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill_either("joined_team","emp_update");
		foreach(player in level.players)
		{
			if(player.team == "spectator")
			{
			}
			else
			{
				emped = emp_isteamemped(player.team);
				player setempjammed(emped);
				if(emped)
				{
					player notify("emp_jammed");
				}
			}
		}
	}
}

//Function Number: 12
emp_playertracker()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill_either("joined_team","emp_update");
		foreach(player in level.players)
		{
			if(player.team == "spectator")
			{
			}
			else if(IsDefined(level.empplayer) && level.empplayer != player)
			{
				player setempjammed(1);
				player notify("emp_jammed");
			}
			else
			{
				player setempjammed(0);
			}
		}
	}
}

//Function Number: 13
destroyotherteamsequipment(attacker,teamemping)
{
	foreach(team in level.teams)
	{
		if(team == teamemping)
		{
		}
		else
		{
			destroyequipment(attacker,team);
			destroytacticalinsertions(attacker,team);
		}
	}
}

//Function Number: 14
destroyequipment(attacker,teamemped)
{
	for(i = 0;i < level.missileentities.size;i++)
	{
		item = level.missileentities[i];
		if(!(IsDefined(item.name)))
		{
		}
		else if(!(IsDefined(item.owner)))
		{
		}
		else if(IsDefined(teamemped) && item.owner.team != teamemped)
		{
		}
		else if(item.owner == attacker)
		{
		}
		else if(!isweaponequipment(item.name) && item.name != "proximity_grenade_mp")
		{
		}
		else
		{
			watcher = item.owner getwatcherforweapon(item.name);
			if(!(IsDefined(watcher)))
			{
			}
			else
			{
				watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(item,0,attacker,"emp_mp");
			}
		}
	}
}

//Function Number: 15
destroytacticalinsertions(attacker,victimteam)
{
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(!(IsDefined(player.tacticalinsertion)))
		{
		}
		else if(level.teambased && player.team != victimteam)
		{
		}
		else if(attacker == player)
		{
		}
		else
		{
			player.tacticalinsertion thread maps/mp/_tacticalinsertion::fizzle();
		}
	}
}

//Function Number: 16
getwatcherforweapon(weapname)
{
	if(!(IsDefined(self)))
	{
		return undefined;
	}

	if(!(isplayer(self)))
	{
		return undefined;
	}

	for(i = 0;i < self.weaponobjectwatcherarray.size;i++)
	{
		if(self.weaponobjectwatcherarray[i].weapon != weapname)
		{
		}
		else
		{
			return self.weaponobjectwatcherarray[i];
		}
	}

	return undefined;
}

//Function Number: 17
destroyotherteamsactivevehicles(attacker,teamemping)
{
	foreach(team in level.teams)
	{
		if(team == teamemping)
		{
		}
		else
		{
			destroyactivevehicles(attacker,team);
		}
	}
}

//Function Number: 18
destroyactivevehicles(attacker,teamemped)
{
	turrets = getentarray("auto_turret","classname");
	destroyentities(turrets,attacker,teamemped);
	targets = target_getarray();
	destroyentities(targets,attacker,teamemped);
	rcbombs = getentarray("rcbomb","targetname");
	destroyentities(rcbombs,attacker,teamemped);
	remotemissiles = getentarray("remote_missile","targetname");
	destroyentities(remotemissiles,attacker,teamemped);
	remotedrone = getentarray("remote_drone","targetname");
	destroyentities(remotedrone,attacker,teamemped);
	planemortars = getentarray("plane_mortar","targetname");
	foreach(planemortar in planemortars)
	{
		if(IsDefined(teamemped) && IsDefined(planemortar.team))
		{
			if(planemortar.team != teamemped)
			{
			}
			else if(planemortar.owner == attacker)
			{
			}
			else
			{
				planemortar notify("emp_deployed",attacker,Stack-Empty ? Stack-Empty : Stack-Empty);
			}
		}
	}

	satellites = getentarray("satellite","targetname");
	foreach(satellite in satellites)
	{
		if(IsDefined(teamemped) && IsDefined(satellite.team))
		{
			if(satellite.team != teamemped)
			{
			}
			else if(satellite.owner == attacker)
			{
			}
			else
			{
				satellite notify("emp_deployed",attacker,Stack-Empty ? Stack-Empty : _k458);
			}
		}
	}

	if(IsDefined(level.missile_swarm_owner))
	{
		if(level.missile_swarm_owner isenemyplayer(attacker))
		{
			level.missile_swarm_owner notify("emp_destroyed_missile_swarm",attacker,_k477);
		}
	}
}

//Function Number: 19
destroyentities(entities,attacker,team)
{
	meansofdeath = "MOD_EXPLOSIVE";
	weapon = "killstreak_emp_mp";
	damage = 5000;
	direction_vec = (0,0,0);
	point = (0,0,0);
	modelname = "";
	tagname = "";
	partname = "";
	foreach(entity in entities)
	{
		if(IsDefined(team) && IsDefined(entity.team))
		{
			if(entity.team != team)
			{
			}
			else if(entity.owner == attacker)
			{
			}
			else
			{
				entity notify("damage",damage,attacker,direction_vec,point,meansofdeath,tagname,modelname,partname,weapon,Stack-Empty ? Stack-Empty : Stack-Empty);
			}
		}
	}
}

//Function Number: 20
drawempdamageorigin(pos,ang,radius)
{
/#
	for(;;)
	{
		line(pos,pos + AnglesToForward(ang) * radius,(1,0,0));
		line(pos,pos + AnglesToRight(ang) * radius,(0,1,0));
		line(pos,pos + AnglesToUp(ang) * radius,(0,0,1));
		line(pos,pos - AnglesToForward(ang) * radius,(1,0,0));
		line(pos,pos - AnglesToRight(ang) * radius,(0,1,0));
		line(pos,pos - AnglesToUp(ang) * radius,(0,0,1));
		wait(0.05);
	}
GetDvarInt(#"D04570F2")
#/
}

//Function Number: 21
isenemyempkillstreakactive()
{
	if((level.teambased && maps/mp/killstreaks/_emp::emp_isteamemped(self.team)) || !level.teambased && IsDefined(level.empplayer) && level.empplayer != self)
	{
		return 1;
	}
}

//Function Number: 22
isempweapon(weaponname)
{
	if(IsDefined(weaponname) && weaponname == "emp_mp" || weaponname == "emp_grenade_mp" || weaponname == "emp_grenade_zm")
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
isempkillstreakweapon(weaponname)
{
	if(IsDefined(weaponname) && weaponname == "emp_mp")
	{
		return 1;
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_emp.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level._effect["emp_flash"] = loadfx("explosions/emp_flash_mp");
	level.teamemped["allies"] = 0;
	level.teamemped["axis"] = 0;
	level.empplayer = undefined;
	if(level.teambased)
	{
		level thread emp_teamtracker();
	}
	else
	{
		level thread emp_playertracker();
	}

	level.killstreakfuncs["emp"] = ::emp_use;
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self)
		{
			self setempjammed(1);
		}
	}
}

emp_use(lifeid, delay)
{
	if(!isdefined(delay))
	{
		delay = 5;
	}

	myteam = self.pers["team"];
	otherteam = level.otherteam[myteam];
	if(level.teambased)
	{
		thread emp_jamteam(otherteam, 60, delay);
	}
	else
	{
		thread emp_jamplayers(self, 60, delay);
	}

	maps\mp\_matchdata::logkillstreakevent("emp", self.origin);
	self notify("used_emp");
	return 1;
}

emp_jamteam(teamname, duration, delay)
{
	level endon("game_ended");
	thread maps\mp\_utility::teamplayercardsplash("used_emp", self);
	level notify("EMP_JamTeam" + teamname);
	level endon("EMP_JamTeam" + teamname);
	foreach(player in level.players)
	{
		player playlocalsound("emp_activate");
		if(player.team != teamname)
		{
			continue;
		}

		if(player maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			player radarjamoff();
		}
	}

	visionsetnaked("coup_sunblind", 0.1);
	thread empeffects();
	wait 0.1;
	visionsetnaked("coup_sunblind", 0);
	visionsetnaked(getdvar("mapname"), 3);
	level.teamemped[teamname] = 1;
	level notify("emp_update");
	level destroyactivevehicles(self);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(duration);
	level.teamemped[teamname] = 0;
	foreach(player in level.players)
	{
		if(player.team != teamname)
		{
			continue;
		}

		if(player maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			player radarjamon();
		}
	}

	level notify("emp_update");
}

emp_jamplayers(owner, duration, delay)
{
	level notify("EMP_JamPlayers");
	level endon("EMP_JamPlayers");
	foreach(player in level.players)
	{
		player playlocalsound("emp_activate");
		if(player == owner)
		{
			continue;
		}

		if(player maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			player radarjamoff();
		}
	}

	visionsetnaked("coup_sunblind", 0.1);
	thread empeffects();
	wait 0.1;
	visionsetnaked("coup_sunblind", 0);
	visionsetnaked(getdvar("mapname"), 3);
	level notify("emp_update");
	level.empplayer = owner;
	level.empplayer thread empplayerffadisconnect();
	level destroyactivevehicles(owner);
	level notify("emp_update");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(duration);
	foreach(player in level.players)
	{
		if(player == owner)
		{
			continue;
		}

		if(player maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			player radarjamon();
		}
	}

	level.empplayer = undefined;
	level notify("emp_update");
	level notify("emp_ended");
}

empplayerffadisconnect()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

empeffects()
{
	foreach(player in level.players)
	{
		playerforward = anglestoforward(player.angles);
		playerforward = (playerforward[0],playerforward[1],0);
		playerforward = vectornormalize(playerforward);
		empdistance = 20000;
		empent = spawn("script_model", player.origin + (0,0,8000) + common_scripts\utility::vector_multiply(playerforward, empdistance));
		empent setmodel("tag_origin");
		empent.angles = empent.angles + (270,0,0);
		empent thread empeffect(player);
	}
}

empeffect(player)
{
	player endon("disconnect");
	wait 0.5;
	playfxontagforclients(level._effect["emp_flash"], self, "tag_origin", player);
}

emp_teamtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team", "emp_update");
		foreach(player in level.players)
		{
			if(player.team == "spectator")
			{
				continue;
			}

			player setempjammed(level.teamemped[player.team]);
		}
	}
}

emp_playertracker()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team", "emp_update");
		foreach(player in level.players)
		{
			if(player.team == "spectator")
			{
				continue;
			}

			if(isdefined(level.empplayer) && level.empplayer != player)
			{
				player setempjammed(1);
				continue;
			}

			player setempjammed(0);
		}
	}
}

destroyactivevehicles(attacker)
{
	if(isdefined(attacker))
	{
		foreach(heli in level.helis)
		{
			radiusdamage(heli.origin, 384, 5000, 5000, attacker);
		}

		foreach(littlebird in level.littlebird)
		{
			radiusdamage(littlebird.origin, 384, 5000, 5000, attacker);
		}

		foreach(turret in level.turrets)
		{
			radiusdamage(turret.origin, 16, 5000, 5000, attacker);
		}

		foreach(rocket in level.rockets)
		{
			rocket notify("death");
		}

		if(level.teambased)
		{
			foreach(uav in level.uavmodels["allies"])
			{
				radiusdamage(uav.origin, 384, 5000, 5000, attacker);
			}

			foreach(uav in level.uavmodels["axis"])
			{
				radiusdamage(uav.origin, 384, 5000, 5000, attacker);
			}
		}
		else
		{
			foreach(uav in level.uavmodels)
			{
				radiusdamage(uav.origin, 384, 5000, 5000, attacker);
			}
		}

		if(isdefined(level.ac130player))
		{
			radiusdamage(level.ac130.planemodel.origin + (0,0,10), 1000, 5000, 5000, attacker);
			return;
		}

		return;
	}

	foreach(heli in level.helis)
	{
		radiusdamage(heli.origin, 384, 5000, 5000);
	}

	foreach(littlebird in level.littlebird)
	{
		radiusdamage(littlebird.origin, 384, 5000, 5000);
	}

	foreach(turret in level.turrets)
	{
		radiusdamage(turret.origin, 16, 5000, 5000);
	}

	foreach(rocket in level.rockets)
	{
		rocket notify("death");
	}

	if(level.teambased)
	{
		foreach(uav in level.uavmodels["allies"])
		{
			radiusdamage(uav.origin, 384, 5000, 5000);
		}

		foreach(uav in level.uavmodels["axis"])
		{
			radiusdamage(uav.origin, 384, 5000, 5000);
		}
	}
	else
	{
		foreach(uav in level.uavmodels)
		{
			radiusdamage(uav.origin, 384, 5000, 5000);
		}
	}

	if(isdefined(level.ac130player))
	{
		radiusdamage(level.ac130.planemodel.origin + (0,0,10), 1000, 5000, 5000);
		return;
	}
}
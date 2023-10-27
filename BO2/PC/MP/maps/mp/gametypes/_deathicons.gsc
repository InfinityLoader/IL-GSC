/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_deathicons.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 2:59:55 AM
*******************************************************************/

#include maps/mp/gametypes/_deathicons;
#include maps/mp/gametypes/_globallogic_utils;

//Function Number: 1
init()
{
	if(!(IsDefined(level.ragdoll_override)))
	{
		level.ragdoll_override = ::ragdoll_override;
	}

	if(!(level.teambased))
	{
		return;
	}

	precacheshader("headicon_dead");
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player.selfdeathicons = [];
	}
}

//Function Number: 3
updatedeathiconsenabled()
{
}

//Function Number: 4
adddeathicon(entity,dyingplayer,team,timeout)
{
	if(!(level.teambased))
	{
		return;
	}

	iconorg = entity.origin;
	dyingplayer endon("spawned_player");
	dyingplayer endon("disconnect");
	wait(0.05);
	maps/mp/gametypes/_globallogic_utils::waittillslowprocessallowed();
/#
	assert(IsDefined(level.teams[team]));
#/
	if(GetDvar(#"F83E8105") == "0")
	{
		return;
	}

	if(level.hardcoremode)
	{
		return;
	}

	if(IsDefined(self.lastdeathicon))
	{
		self.lastdeathicon destroy();
	}

	newdeathicon = newteamhudelem(team);
	newdeathicon.x = iconorg[0];
	newdeathicon.y = iconorg[1];
	newdeathicon.z = iconorg[2] + 54;
	newdeathicon.alpha = 0.61;
	newdeathicon.archived = 1;
	if(level.splitscreen)
	{
		newdeathicon setshader("headicon_dead",14,14);
	}
	else
	{
		newdeathicon setshader("headicon_dead",7,7);
	}

	newdeathicon setwaypoint(1);
	self.lastdeathicon = newdeathicon;
	newdeathicon thread destroyslowly(timeout);
}

//Function Number: 5
destroyslowly(timeout)
{
	self endon("death");
	wait(timeout);
	self fadeovertime(1);
	self.alpha = 0;
	wait(1);
	self destroy();
}

//Function Number: 6
ragdoll_override(idamage,smeansofdeath,sweapon,shitloc,vdir,vattackerorigin,deathanimduration,einflictor,ragdoll_jib,body)
{
	if(smeansofdeath == "MOD_FALLING" && self isonground() == 1)
	{
		body startragdoll();
		if(!(IsDefined(self.switching_teams)))
		{
			thread maps/mp/gametypes/_deathicons::adddeathicon(body,self,self.team,5);
		}

		return 1;
	}
}
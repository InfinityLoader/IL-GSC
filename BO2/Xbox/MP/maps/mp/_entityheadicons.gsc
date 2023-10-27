/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_entityheadicons.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 3:04:59 AM
*******************************************************************/

#include common_scripts/utility;

//Function Number: 1
init()
{
	if(IsDefined(level.initedentityheadicons))
	{
		return;
	}

	if(level.createfx_enabled)
	{
		return;
	}

	level.initedentityheadicons = 1;
/#
	assert(IsDefined(game["entity_headicon_allies"]),"Allied head icons are not defined.  Check the team set for the level.");
#/
/#
	assert(IsDefined(game["entity_headicon_axis"]),"Axis head icons are not defined.  Check the team set for the level.");
#/
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
	if(!(level.teambased))
	{
		return;
	}

	level.entitieswithheadicons = [];
}

//Function Number: 2
setentityheadicon(team,owner,offset,icon,constant_size)
{
	if(!level.teambased && !IsDefined(owner))
	{
		return;
	}

	if(!(IsDefined(constant_size)))
	{
		constant_size = 0;
	}

	if(!(IsDefined(self.entityheadiconteam)))
	{
		self.entityheadiconteam = "none";
		self.entityheadicons = [];
	}

	if(level.teambased && !IsDefined(owner))
	{
		if(team == self.entityheadiconteam)
		{
			return;
		}

		self.entityheadiconteam = team;
	}

	if(IsDefined(offset))
	{
		self.entityheadiconoffset = offset;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	if(IsDefined(self.entityheadicons))
	{
		for(i = 0;i < self.entityheadicons.size;i++)
		{
			if(IsDefined(self.entityheadicons[i]))
			{
				self.entityheadicons[i] destroy();
			}
		}
	}

	self.entityheadicons = [];
	self notify("kill_entity_headicon_thread");
	if(!(IsDefined(icon)))
	{
		icon = game["entity_headicon_" + team];
	}

	if(IsDefined(owner) && !level.teambased)
	{
		if(!(isplayer(owner)))
		{
/#
			assert(IsDefined(owner.owner),"entity has to have an owner if it\'s not a player");
#/
			owner = owner.owner;
		}

		owner updateentityheadclienticon(self,icon,constant_size);
	}
	else if(IsDefined(owner) && team != "none")
	{
		owner updateentityheadteamicon(self,team,icon,constant_size);
	}

	self thread destroyheadiconsondeath();
}

//Function Number: 3
updateentityheadteamicon(entity,team,icon,constant_size)
{
	headicon = newteamhudelem(team);
	headicon.archived = 1;
	headicon.x = entity.entityheadiconoffset[0];
	headicon.y = entity.entityheadiconoffset[1];
	headicon.z = entity.entityheadiconoffset[2];
	headicon.alpha = 0.8;
	headicon setshader(icon,6,6);
	headicon setwaypoint(constant_size);
	headicon settargetent(entity);
	entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

//Function Number: 4
updateentityheadclienticon(entity,icon,constant_size)
{
	headicon = newclienthudelem(self);
	headicon.archived = 1;
	headicon.x = entity.entityheadiconoffset[0];
	headicon.y = entity.entityheadiconoffset[1];
	headicon.z = entity.entityheadiconoffset[2];
	headicon.alpha = 0.8;
	headicon setshader(icon,6,6);
	headicon setwaypoint(constant_size);
	headicon settargetent(entity);
	entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

//Function Number: 5
destroyheadiconsondeath()
{
	self waittill_any("death","hacked");
	for(i = 0;i < self.entityheadicons.size;i++)
	{
		if(IsDefined(self.entityheadicons[i]))
		{
			self.entityheadicons[i] destroy();
		}
	}
}

//Function Number: 6
destroyentityheadicons()
{
	if(IsDefined(self.entityheadicons))
	{
		for(i = 0;i < self.entityheadicons.size;i++)
		{
			if(IsDefined(self.entityheadicons[i]))
			{
				self.entityheadicons[i] destroy();
			}
		}
	}
}

//Function Number: 7
updateentityheadiconpos(headicon)
{
	headicon.x = self.origin[0] + self.entityheadiconoffset[0];
	headicon.y = self.origin[1] + self.entityheadiconoffset[1];
	headicon.z = self.origin[2] + self.entityheadiconoffset[2];
}
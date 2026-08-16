/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_entityheadicons.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	if(isdefined(level.initedentityheadicons))
	{
		return;
	}

	level.initedentityheadicons = 1;
	game["entity_headicon_allies"] = maps\mp\gametypes\_teams::getteamheadicon("allies");
	game["entity_headicon_axis"] = maps\mp\gametypes\_teams::getteamheadicon("axis");
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
	if(!level.teambased)
	{
		return;
	}
}

setheadicon(showto, icon, offset, width, height)
{
	if(!isdefined(self.entityheadicons))
	{
		self.entityheadicons = [];
	}

	if(!isplayer(showto) && showto == "none")
	{
		foreach(key, headicon in self.entityheadicons)
		{
			if(isdefined(headicon))
			{
				headicon destroy();
			}

			self.entityheadicons[key] = undefined;
		}

		return;
	}

	if(isplayer(showto))
	{
		if(isdefined(self.entityheadicons[showto.guid]))
		{
			self.entityheadicons[showto.guid] destroy();
			self.entityheadicons[showto.guid] = undefined;
		}

		if(icon == "")
		{
			return;
		}

		if(isdefined(self.entityheadicons[showto.team]))
		{
			self.entityheadicons[showto.team] destroy();
			self.entityheadicons[showto.team] = undefined;
		}

		headicon = newclienthudelem(showto);
		self.entityheadicons[showto.guid] = headicon;
	}
	else
	{
		if(isdefined(self.entityheadicons[showto]))
		{
			self.entityheadicons[showto] destroy();
			self.entityheadicons[showto] = undefined;
		}

		if(icon == "")
		{
			return;
		}

		foreach(key, hudicon in self.entityheadicons)
		{
			if(key == "axis" || key == "allies")
			{
				continue;
			}

			player = maps\mp\_utility::getplayerforguid(key);
			if(player.team == showto)
			{
				self.entityheadicons[key] destroy();
				self.entityheadicons[key] = undefined;
			}
		}

		headicon = newteamhudelem(showto);
		self.entityheadicons[showto] = headicon;
	}

	if(!isdefined(width) || !isdefined(height))
	{
		width = 10;
		height = 10;
	}

	headicon.archived = 1;
	headicon.x = self.origin[0] + offset[0];
	headicon.y = self.origin[1] + offset[1];
	headicon.z = self.origin[2] + offset[2];
	headicon.alpha = 0.85;
	headicon setshader(icon, width, height);
	if(isplayer(showto))
	{
		headicon setwaypoint(1, 1, 0);
	}
	else
	{
		headicon setwaypoint(1, 1, 0);
	}

	headicon thread keeppositioned(self, offset);
	thread destroyiconsondeath();
	if(isplayer(showto))
	{
		headicon thread destroyonownerdisconnect(showto);
		return;
	}
}

destroyonownerdisconnect(owner)
{
	self endon("death");
	owner waittill("disconnect");
	self destroy();
}

destroyiconsondeath()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	foreach(headicon in self.entityheadicons)
	{
		if(!isdefined(headicon))
		{
			continue;
		}

		headicon destroy();
	}
}

keeppositioned(owner, offset)
{
	self endon("death");
	owner endon("death");
	pos = owner.origin;
	for(;;)
	{
		if(pos != owner.origin)
		{
			pos = owner.origin;
			self.x = pos[0] + offset[0];
			self.y = pos[0] + offset[0];
			self.z = pos[0] + offset[0];
		}

		wait 0.05;
	}
}

setteamheadicon(team, offset)
{
	if(!level.teambased)
	{
		return;
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	shader = game["entity_headicon_" + team];
	self.entityheadiconteam = team;
	if(isdefined(offset))
	{
		self.entityheadiconoffset = offset;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(team == "none")
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}

		return;
	}

	headicon = newteamhudelem(team);
	headicon.archived = 1;
	headicon.x = self.origin[0] + self.entityheadiconoffset[0];
	headicon.y = self.origin[1] + self.entityheadiconoffset[1];
	headicon.z = self.origin[2] + self.entityheadiconoffset[2];
	headicon.alpha = 0.8;
	headicon setshader(shader, 10, 10);
	headicon setwaypoint(0, 0);
	self.entityheadicon = headicon;
	thread keepiconpositioned();
	thread destroyheadiconsondeath();
}

setplayerheadicon(player, offset)
{
	if(level.teambased)
	{
		return;
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(player))
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}

		return;
	}

	team = player.team;
	self.entityheadiconteam = team;
	if(isdefined(offset))
	{
		self.entityheadiconoffset = offset;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	shader = game["entity_headicon_" + team];
	headicon = newclienthudelem(player);
	headicon.archived = 1;
	headicon.x = self.origin[0] + self.entityheadiconoffset[0];
	headicon.y = self.origin[1] + self.entityheadiconoffset[1];
	headicon.z = self.origin[2] + self.entityheadiconoffset[2];
	headicon.alpha = 0.8;
	headicon setshader(shader, 10, 10);
	headicon setwaypoint(0, 0);
	self.entityheadicon = headicon;
	thread keepiconpositioned();
	thread destroyheadiconsondeath();
}

keepiconpositioned()
{
	self endon("kill_entity_headicon_thread");
	self endon("death");
	pos = self.origin;
	for(;;)
	{
		if(pos != self.origin)
		{
			updateheadiconorigin();
			pos = self.origin;
		}

		wait 0.05;
	}
}

destroyheadiconsondeath()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

updateheadiconorigin()
{
	self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
	self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
	self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}
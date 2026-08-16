/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_shellshock.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precacheshellshock("frag_grenade_mp");
	precacheshellshock("damage_mp");
	precacherumble("artillery_rumble");
	precacherumble("grenade_rumble");
	precachemenu("dirt_effect_center");
	precachemenu("dirt_effect_left");
	precachemenu("dirt_effect_right");
}

shellshockondamage(param_AD9, damage)
{
	if(maps\mp\_flashgrenades::isflashbanged())
	{
		return;
	}

	if(maps\mp\_utility::_hasperk("specialty_blastshield"))
	{
		return;
	}

	if(param_AD9 == "MOD_EXPLOSIVE" || param_AD9 == "MOD_GRENADE" || param_AD9 == "MOD_GRENADE_SPLASH" || param_AD9 == "MOD_PROJECTILE" || param_AD9 == "MOD_PROJECTILE_SPLASH")
	{
		time = 0;
		if(damage >= 90)
		{
			time = 4;
		}
		else if(damage >= 50)
		{
			time = 3;
		}
		else if(damage >= 25)
		{
			time = 2;
		}
		else if(damage > 10)
		{
			time = 2;
		}

		if(time)
		{
			self shellshock("frag_grenade_mp", 0.5);
			return;
		}

		return;
	}
}

endondeath()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

grenade_earthquake()
{
	thread endondeath();
	self endon("end_explode");
	self waittill("explode", position);
	playrumbleonposition("grenade_rumble", position);
	earthquake(0.5, 0.75, position, 800);
	foreach(player in level.players)
	{
		if(player maps\mp\_utility::isusingremote())
		{
			continue;
		}

		if(distance(position, player.origin) > 600)
		{
			continue;
		}

		if(player damageconetrace(position))
		{
			player thread dirteffect(position);
		}
	}
}

dirteffect(position)
{
	self endon("disconnect");
	forwardvec = vectornormalize(anglestoforward(self.angles));
	rightvec = vectornormalize(anglestoright(self.angles));
	grenadevec = vectornormalize(position - self.origin);
	fdot = vectordot(grenadevec, forwardvec);
	rdot = vectordot(grenadevec, rightvec);
	effectmenus = [];
	if(fdot > 0 && fdot > 0.5 && self getcurrentweapon() != "riotshield_mp")
	{
		effectmenus[effectmenus.size] = "dirt_effect_center";
	}

	if(abs(fdot) < 0.866)
	{
		if(rdot > 0)
		{
			effectmenus[effectmenus.size] = "dirt_effect_right";
		}
		else
		{
			effectmenus[effectmenus.size] = "dirt_effect_left";
		}
	}

	foreach(menu in effectmenus)
	{
		self openmenu(menu);
	}

	if(isalive(self))
	{
		common_scripts\utility::waittill_notify_or_timeout("death", 2);
	}

	foreach(menu in effectmenus)
	{
		self closemenu(menu);
	}
}

c4_earthquake()
{
	thread endondeath();
	self endon("end_explode");
	self waittill("explode", position);
	playrumbleonposition("grenade_rumble", position);
	earthquake(0.4, 0.75, position, 512);
}

barrel_earthquake()
{
	playrumbleonposition("grenade_rumble", self.origin);
	earthquake(0.4, 0.5, self.origin, 512);
}

artillery_earthquake()
{
	playrumbleonposition("artillery_rumble", self.origin);
	earthquake(0.7, 0.5, self.origin, 800);
}
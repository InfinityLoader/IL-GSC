/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_shellshock.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 158 ms
 * Timestamp: 10/27/2023 2:25:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshellshock("frag_grenade_mp");
	precacheshellshock("damage_mp");
	precacherumble("artillery_rumble");
	precacherumble("grenade_rumble");
	precachemenu("dirt_effect_center");
	precachemenu("dirt_effect_left");
	precachemenu("dirt_effect_right");
	precachemenu("blood_effect_center");
	precachemenu("blood_effect_left");
	precachemenu("blood_effect_right");
}

//Function Number: 2
shellshockondamage(param_00,param_01)
{
	if(maps\mp\_flashgrenades::isflashbanged())
	{
		return;
	}

	if(param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH")
	{
		if(param_01 > 10)
		{
			if(isdefined(self.shellshockreduction) && self.shellshockreduction)
			{
				self shellshock("frag_grenade_mp",self.shellshockreduction);
				return;
			}

			self shellshock("frag_grenade_mp",0.5);
			return;
		}
	}
}

//Function Number: 3
func_2374()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 4
grenade_earthquake()
{
	thread func_2374();
	self endon("end_explode");
	self waittill("explode",var_00);
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.5,0.75,var_00,800);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::isusingremote())
		{
			continue;
		}

		if(distance(var_00,var_02.origin) > 600)
		{
			continue;
		}

		if(var_02 damageconetrace(var_00))
		{
			var_02 thread dirteffect(var_00);
		}
	}
}

//Function Number: 5
dirteffect(param_00)
{
	self endon("disconnect");
	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = [];
	if(var_04 > 0 && var_04 > 0.5 && self getcurrentweapon() != "riotshield_mp")
	{
	}

	if(abs(var_05) < 0.866)
	{
		if(var_06 > 0)
		{
		}
		else
		{
		}
	}

	foreach(var_08 in var_41)
	{
		self openmenu(var_08);
	}

	if(isalive(self))
	{
		common_scripts\utility::waittill_notify_or_timeout("death",2);
	}

	foreach(var_08 in var_41)
	{
		self closemenu(var_08);
	}
}

//Function Number: 6
bloodeffect(param_00)
{
	self endon("disconnect");
	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = [];
	if(var_04 > 0 && var_04 > 0.5)
	{
	}

	if(abs(var_05) < 0.866)
	{
		if(var_06 > 0)
		{
		}
		else
		{
		}
	}

	foreach(var_08 in var_41)
	{
		self openmenu(var_08);
	}

	if(isalive(self))
	{
		common_scripts\utility::waittill_notify_or_timeout("death",7);
	}

	foreach(var_08 in var_41)
	{
		self closemenu(var_08);
	}
}

//Function Number: 7
c4_earthquake()
{
	thread func_2374();
	self endon("end_explode");
	self waittill("explode",var_00);
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.4,0.75,var_00,512);
}

//Function Number: 8
barrel_earthquake()
{
	playrumbleonposition("grenade_rumble",self.origin);
	earthquake(0.4,0.5,self.origin,512);
}

//Function Number: 9
artillery_earthquake()
{
	playrumbleonposition("artillery_rumble",self.origin);
	earthquake(0.7,0.5,self.origin,800);
}
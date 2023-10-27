/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_c4.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 223 ms
 * Timestamp: 10/27/2023 2:45:41 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "weapon_c4";
	}

	if(!isdefined(param_02))
	{
		param_02 = "weapon_c4_obj";
	}

	if(!isdefined(param_00))
	{
		level.c4_weaponname = "c4";
	}
	else
	{
		level.c4_weaponname = param_00;
	}

	precachemodel(param_01);
	precachemodel(param_02);
	precacheitem(level.c4_weaponname);
	if(isdefined(level.c4_explosion_fx_override))
	{
		level._effect["c4_explosion"] = level.c4_explosion_fx_override;
		return;
	}

	level._effect["c4_explosion"] = loadfx("fx/explosions/grenadeExp_metal");
}

//Function Number: 2
c4_location(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = "weapon_c4";
	}

	if(!isdefined(param_05))
	{
		param_05 = "weapon_c4_obj";
	}

	if(isdefined(param_00))
	{
		var_06 = self gettagorigin(param_00);
	}
	else if(isdefined(param_03))
	{
		var_06 = param_03;
	}
	else
	{
	}

	var_07 = spawn("script_model",var_06 + param_01);
	var_07 setmodel(param_05);
	if(isdefined(param_00))
	{
		var_07 linkto(self,param_00,param_01,param_02);
	}
	else
	{
		var_07.angles = self.angles;
	}

	var_07.trigger = get_use_trigger();
	if(isdefined(level.c4_hintstring))
	{
		var_07.trigger sethintstring(level.c4_hintstring);
	}
	else
	{
		var_07.trigger sethintstring(&"SCRIPT_PLATFORM_HINT_PLANTEXPLOSIVES");
	}

	if(isdefined(param_00))
	{
		var_07.trigger linkto(self,param_00,param_01,param_02);
		var_07.trigger.islinked = 1;
	}
	else
	{
		var_07.trigger.origin = var_07.origin;
	}

	var_07 thread handle_use(self,param_04);
	if(!isdefined(self.multiple_c4))
	{
		var_07 thread handle_delete(self);
	}

	var_07 thread handle_clear_c4(self);
	return var_07;
}

//Function Number: 3
playc4effects()
{
	self endon("death");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("c4_light_blink"),self,"tag_fx");
}

//Function Number: 4
handle_use(param_00,param_01)
{
	param_00 endon("clear_c4");
	if(!isdefined(param_01))
	{
		param_01 = "weapon_c4";
	}

	if(!isdefined(param_00.multiple_c4))
	{
		param_00 endon("c4_planted");
	}

	if(!isdefined(param_00.c4_count))
	{
		param_00.c4_count = 0;
	}

	param_00.c4_count++;
	self.trigger usetriggerrequirelookat();
	self.trigger waittill("trigger",var_02);
	level notify("c4_in_place",self);
	self.trigger unlink();
	self.trigger release_use_trigger();
	self playsound("c4_bounce_default");
	self setmodel(param_01);
	thread playc4effects();
	param_00.c4_count--;
	if(!isdefined(param_00.multiple_c4) || !param_00.c4_count)
	{
		var_02 switch_to_detonator();
	}

	thread handle_detonation(param_00,var_02);
	param_00 notify("c4_planted",self);
}

//Function Number: 5
handle_delete(param_00)
{
	param_00 endon("clear_c4");
	self.trigger endon("trigger");
	param_00 waittill("c4_planted",var_01);
	self.trigger unlink();
	self.trigger release_use_trigger();
	self delete();
}

//Function Number: 6
handle_detonation(param_00,param_01)
{
	param_00 endon("clear_c4");
	param_01 waittill("detonate");
	playfx(level._effect["c4_explosion"],self.origin);
	var_02 = spawn("script_origin",self.origin);
	if(isdefined(level.c4_sound_override))
	{
		var_02 playsound("detpack_explo_main","sound_done");
	}

	self radiusdamage(self.origin,256,200,50);
	earthquake(0.4,1,self.origin,1000);
	if(isdefined(self))
	{
		self delete();
	}

	param_01 thread remove_detonator();
	param_00 notify("c4_detonation");
	var_02 waittill("sound_done");
	var_02 delete();
}

//Function Number: 7
handle_clear_c4(param_00)
{
	param_00 endon("c4_detonation");
	param_00 waittill("clear_c4");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.trigger.inuse) && self.trigger.inuse)
	{
		self.trigger release_use_trigger();
	}

	if(isdefined(self))
	{
		self delete();
	}

	level.player thread remove_detonator();
}

//Function Number: 8
remove_detonator()
{
	level endon("c4_in_place");
	wait(1);
	var_00 = 0;
	if(level.c4_weaponname == self getcurrentweapon() && isdefined(self.old_weapon))
	{
		if(self.old_weapon == "none")
		{
			var_00 = 1;
			self switchtoweapon(self getweaponslistprimaries()[0]);
		}
		else if(self hasweapon(self.old_weapon) && self.old_weapon != level.c4_weaponname)
		{
			self switchtoweapon(self.old_weapon);
		}
		else
		{
			self switchtoweapon(self getweaponslistprimaries()[0]);
		}
	}

	self.old_weapon = undefined;
	if(0 != self getammocount(level.c4_weaponname))
	{
		return;
	}

	self waittill("weapon_change");
	self takeweapon(level.c4_weaponname);
}

//Function Number: 9
switch_to_detonator()
{
	var_00 = undefined;
	if(!isdefined(self.old_weapon))
	{
		self.old_weapon = self getcurrentweapon();
	}

	var_01 = self getweaponslistall();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] != level.c4_weaponname)
		{
			continue;
		}

		var_00 = var_01[var_02];
	}

	if(!isdefined(var_00))
	{
		self giveweapon(level.c4_weaponname);
		self setweaponammoclip(level.c4_weaponname,0);
		self setactionslot(2,"weapon",level.c4_weaponname);
	}

	self switchtoweapon(level.c4_weaponname);
}

//Function Number: 10
get_use_trigger()
{
	var_00 = getentarray("generic_use_trigger","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].inuse) && var_00[var_01].inuse)
		{
			continue;
		}

		if(!isdefined(var_00[var_01].inuse))
		{
			var_00[var_01] enablelinkto();
		}

		var_00[var_01].inuse = 1;
		var_00[var_01].oldorigin = var_00[var_01].origin;
		return var_00[var_01];
	}
}

//Function Number: 11
release_use_trigger()
{
	if(isdefined(self.islinked))
	{
		self unlink();
	}

	self.islinked = undefined;
	self.origin = self.oldorigin;
	self.inuse = 0;
}
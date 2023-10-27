/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_damagefeedback.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 100 ms
 * Timestamp: 10/27/2023 2:22:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("damage_feedback");
	common_scripts\utility::array_thread(level.players,::init_damage_feedback);
	common_scripts\utility::array_thread(level.players,::monitordamage);
}

//Function Number: 2
init_damage_feedback()
{
	self.hud_damagefeedback = newclienthudelem(self);
	self.hud_damagefeedback.alignx = "center";
	self.hud_damagefeedback.aligny = "middle";
	self.hud_damagefeedback.horzalign = "center";
	self.hud_damagefeedback.vertalign = "middle";
	self.hud_damagefeedback.alpha = 0;
	self.hud_damagefeedback.archived = 1;
	self.hud_damagefeedback setshader("damage_feedback",24,48);
	self.hud_damagefeedback.y = 12;
}

//Function Number: 3
monitordamage()
{
	maps\_utility::add_damage_function(::damagefeedback_took_damage);
}

//Function Number: 4
stopmonitordamage()
{
	maps\_utility::remove_damage_function(::damagefeedback_took_damage);
}

//Function Number: 5
damagefeedback_took_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(param_01))
	{
		return;
	}

	if(!maps\_utility::is_damagefeedback_enabled())
	{
		return;
	}

	if(isdefined(self.bullet_resistance))
	{
		var_07 = [];
		if(isdefined(var_7B[param_05]))
		{
			if(param_01 <= self.bullet_resistance)
			{
				return;
			}
		}
	}

	param_02 updatedamagefeedback(self);
}

//Function Number: 6
updatedamagefeedback(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_00.team))
	{
		return;
	}

	if(param_00.team == self.team || param_00.team == "neutral")
	{
		return;
	}

	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
	{
		return;
	}

	if(isdefined(param_00.godmode) && param_00.godmode)
	{
		return;
	}

	if(isdefined(param_00.script_godmode) && param_00.script_godmode)
	{
		return;
	}

	self playlocalsound("SP_hit_alert");
	var_01 = 1;
	if(isdefined(level.slowmo.speed_slow))
	{
		var_01 = level.slowmo.speed_slow;
	}

	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeovertime(var_01);
	self.hud_damagefeedback.alpha = 0;
	var_02 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
	self.hud_damagefeedback.y = 12 - int(var_02);
}
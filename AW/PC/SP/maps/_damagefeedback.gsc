/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_damagefeedback.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 118 ms
 * Timestamp: 10/27/2023 1:58:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("damage_feedback");
	precacheshader("damage_feedback_headshot");
	maps\_utility::enable_damagefeedback_hud();
	maps\_utility::enable_damagefeedback_snd();
	common_scripts\utility::array_thread(level.players,::init_damage_feedback);
	common_scripts\utility::array_thread(level.players,::maps\_utility::generic_damage_think);
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
	self.hud_damagefeedback setshader("damage_feedback",50,100);
	self.hud_damagefeedback.y = 25;
	self.hud_damagefeedback_headshot = newclienthudelem(self);
	self.hud_damagefeedback_headshot.alignx = "center";
	self.hud_damagefeedback_headshot.aligny = "middle";
	self.hud_damagefeedback_headshot.horzalign = "center";
	self.hud_damagefeedback_headshot.vertalign = "middle";
	self.hud_damagefeedback_headshot.alpha = 0;
	self.hud_damagefeedback_headshot.archived = 1;
	self.hud_damagefeedback_headshot setshader("damage_feedback_headshot",50,100);
	self.hud_damagefeedback_headshot.y = 25;
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
damagefeedback_took_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0;
	if(isdefined(self.bullet_resistance))
	{
		var_0B = [];
		var_0B["MOD_PISTOL_BULLET"] = 1;
		var_0B["MOD_RIFLE_BULLET"] = 1;
		if(isdefined(var_0B[param_04]))
		{
			if(param_00 <= self.bullet_resistance && !isdefined(self.mech) || !self.mech || !isdefined(param_09) || !issubstr(param_09,"iw5_em1"))
			{
				return;
			}
		}
	}

	if(isdefined(self.damagelocation) && self.damagelocation == "head" || self.damagelocation == "helmet")
	{
		var_0A = 1;
	}

	param_01 updatedamagefeedback(self,var_0A);
}

//Function Number: 6
updatedamagefeedback(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_00.team))
	{
		var_02 = param_00.team;
	}
	else if(isdefined(param_00.script_team))
	{
		var_02 = param_00.script_team;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	if(var_02 == "neutral" || isdefined(self.team) && var_02 == self.team)
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

	updatedamagefeedbacksnd(param_00);
	updatedamagefeedbackhud(param_01,param_00);
}

//Function Number: 7
updatedamagefeedbacksnd(param_00)
{
	if(!maps\_utility::is_damagefeedback_snd_enabled())
	{
		return;
	}

	if(isdefined(param_00) && isdefined(param_00.disabledamagefeedbacksnd) && param_00.disabledamagefeedbacksnd)
	{
		return;
	}

	if(isplayer(self))
	{
		var_01 = "SP_hit_alert_npc";
		if(soundexists(var_01))
		{
			level.player playlocalsound(var_01);
			return;
		}

		return;
	}

	if(isplayer(param_00))
	{
	}
}

//Function Number: 8
updatedamagefeedbackhud(param_00,param_01)
{
	if(!maps\_utility::is_damagefeedback_hud_enabled())
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	var_02 = 1;
	if(isdefined(level.slowmo.speed_slow))
	{
		var_02 = level.slowmo.speed_slow;
	}

	if(isdefined(param_00) && param_00 && isdefined(param_01) && !isalive(param_01))
	{
		self.hud_damagefeedback_headshot.alpha = 1;
		self.hud_damagefeedback_headshot fadeovertime(var_02);
		self.hud_damagefeedback_headshot.alpha = 0;
		var_03 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
		self.hud_damagefeedback_headshot.y = 25 - int(var_03);
		return;
	}

	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeovertime(var_03);
	self.hud_damagefeedback.alpha = 0;
	var_03 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
	self.hud_damagefeedback.y = 25 - int(var_03);
}
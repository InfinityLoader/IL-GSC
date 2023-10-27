/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_damagefeedback.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 87 ms
 * Timestamp: 10/27/2023 1:39:32 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachematerial("damage_feedback");
	common_scripts\utility::func_F1B(level.players,::init_damage_feedback);
	common_scripts\utility::func_F1B(level.players,::func_537B);
}

//Function Number: 2
init_damage_feedback()
{
	self.var_4310 = newclienthudelem(self);
	self.var_4310.alignx = "center";
	self.var_4310.aligny = "middle";
	self.var_4310.horzalign = "center";
	self.var_4310.vertalign = "middle";
	self.var_4310.alpha = 0;
	self.var_4310.archived = 1;
	self.var_4310 setmaterial("damage_feedback",24,48);
	self.var_4310.y = 12;
}

//Function Number: 3
func_537B()
{
	maps\_utility::add_damage_function(::damagefeedback_took_damage);
}

//Function Number: 4
func_7C69()
{
	maps\_utility::func_6518(::damagefeedback_took_damage);
}

//Function Number: 5
damagefeedback_took_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(param_01))
	{
	}

	if(!maps\_utility::func_47D7())
	{
	}

	if(isdefined(self.bullet_resistance))
	{
		var_07 = [];
		var_07["MOD_PISTOL_BULLET"] = 1;
		var_07["MOD_RIFLE_BULLET"] = 1;
		if(isdefined(var_07[param_04]))
		{
			if(param_00 <= self.bullet_resistance)
			{
			}
		}
	}

	param_01 func_86E0(self);
}

//Function Number: 6
func_86E0(param_00)
{
	if(!isplayer(self))
	{
	}

	if(!isdefined(param_00.team))
	{
	}

	if(param_00.team == self.team || param_00.team == "neutral")
	{
	}

	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
	{
	}

	if(isdefined(param_00.godmode) && param_00.godmode)
	{
	}

	if(isdefined(param_00.var_6BEE) && param_00.var_6BEE)
	{
	}

	self playlocalsound("SP_hit_alert");
	var_01 = 1;
	if(isdefined(level.var_7609.var_7901))
	{
		var_01 = level.var_7609.var_7901;
	}

	self.var_4310.alpha = 1;
	self.var_4310 fadeovertime(var_01);
	self.var_4310.alpha = 0;
	var_02 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
	self.var_4310.y = 12 - castint(var_02);
}
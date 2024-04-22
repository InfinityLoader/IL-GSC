/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: player_scripted_anim_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 59 ms
 * Timestamp: 4/22/2024 2:34:10 AM
*******************************************************************/

//Function Number: 1
waittill_trigger_activate_looking_at(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("valid_trigger");
	var_06 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 0.8;
	}

	if(isdefined(param_03) && param_03)
	{
		var_06 = undefined;
	}

	var_07 = isdefined(param_04) && param_04;
	param_00 thread _trigger_handle_triggering(var_07);
	for(;;)
	{
		if(isdefined(param_00.force_off) && param_00.force_off)
		{
			param_00 common_scripts\utility::trigger_off();
		}
		else if(level.player getstance() == "prone")
		{
			param_00 common_scripts\utility::trigger_off();
		}
		else if(level.player player_looking_at_relative(param_01.origin,param_02,var_06,level.player,param_05))
		{
			param_00 common_scripts\utility::trigger_on();
		}
		else
		{
			param_00 common_scripts\utility::trigger_off();
		}

		wait(0.1);
	}
}

//Function Number: 2
_trigger_handle_triggering(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		var_01 = !level.player ismeleeing();
		var_02 = !level.player issprintsliding();
		var_03 = level.player isonground() || level.player islinked();
		var_04 = !isdefined(self.force_off) || !self.force_off;
		var_05 = level.player getstance() != "prone";
		var_06 = !level.player isthrowinggrenade();
		if(var_04 && var_01 && var_02 && var_03 && var_05 && var_06)
		{
			break;
		}
	}

	self notify("valid_trigger");
	if(param_00)
	{
		self delete();
		return;
	}

	common_scripts\utility::trigger_off();
}

//Function Number: 3
player_looking_at_relative(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.8;
	}

	var_05 = maps\_utility::get_player_from_self();
	var_06 = var_05 geteye();
	var_07 = vectortoangles(param_00 - var_06);
	var_08 = anglestoforward(var_07);
	var_09 = var_05 getplayerangles();
	if(isdefined(param_04))
	{
		var_09 = combineangles(param_04.angles,var_09);
	}

	var_0A = anglestoforward(var_09);
	var_0B = vectordot(var_08,var_0A);
	if(var_0B < param_01)
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		return 1;
	}

	var_0C = bullettrace(param_00,var_06,0,param_03);
	return var_0C["fraction"] == 1;
}
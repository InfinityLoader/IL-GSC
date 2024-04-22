/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _nightvision.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 184 ms
 * Timestamp: 4/22/2024 2:22:01 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = level.players;
	}

	thread init_and_run(param_00,param_01);
}

//Function Number: 2
init_and_run(param_00,param_01)
{
	param_01 = common_scripts\utility::ter_op(isdefined(param_01),param_01,1);
	precachenightvisioncodeassets();
	precacheshellshock("nightvision");
	level.nightvision_dlight_effect = loadfx("fx/misc/NV_dlight");
	level.nightvision_reflector_effect = loadfx("fx/misc/ir_tapeReflect");
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		var_03 maps\_utility::ent_flag_init("nightvision_enabled");
		var_03 maps\_utility::ent_flag_init("nightvision_on");
		var_03 maps\_utility::ent_flag_set("nightvision_enabled");
		var_03 maps\_utility::ent_flag_init("nightvision_dlight_enabled");
		var_03 maps\_utility::ent_flag_set("nightvision_dlight_enabled");
		var_03 maps\_utility::ent_flag_clear("nightvision_dlight_enabled");
		var_03 setactionslot(param_01,"nightvision");
	}

	visionsetnight("default_night");
	waittillframeend;
	wait(0.05);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		var_03 thread nightvision_toggle();
	}
}

//Function Number: 3
nightvision_toggle()
{
	self endon("death");
	for(;;)
	{
		self waittill("night_vision_on");
		nightvision_on();
		self waittill("night_vision_off");
		nightvision_off();
		wait(0.05);
	}
}

//Function Number: 4
nightvision_check(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.player;
	}

	return isdefined(param_00.nightvision_enabled);
}

//Function Number: 5
nightvision_on()
{
	self.nightvision_started = 1;
	wait(1);
	maps\_utility::ent_flag_set("nightvision_on");
	self.nightvision_enabled = 1;
	var_00 = getaiarray("allies");
	common_scripts\utility::array_thread(var_00,::enable_ir_beacon);
	if(!maps\_utility::exists_global_spawn_function("allies",::enable_ir_beacon))
	{
		maps\_utility::add_global_spawn_function("allies",::enable_ir_beacon);
	}
}

//Function Number: 6
enable_ir_beacon()
{
	if(!isai(self))
	{
		return;
	}

	if(isdefined(self.has_no_ir))
	{
		return;
	}

	animscripts\shared::updatelaserstatus();
	thread loopreflectoreffect();
}

//Function Number: 7
loopreflectoreffect()
{
	level endon("night_vision_off");
	self endon("death");
	for(;;)
	{
		playfxontag(level.nightvision_reflector_effect,self,"tag_reflector_arm_le");
		playfxontag(level.nightvision_reflector_effect,self,"tag_reflector_arm_ri");
		wait(0.1);
	}
}

//Function Number: 8
stop_reflector_effect()
{
	if(isdefined(self.has_no_ir))
	{
		return;
	}

	stopfxontag(level.nightvision_reflector_effect,self,"tag_reflector_arm_le");
	stopfxontag(level.nightvision_reflector_effect,self,"tag_reflector_arm_ri");
}

//Function Number: 9
nightvision_off()
{
	self.nightvision_started = undefined;
	wait(0.4);
	level notify("night_vision_off");
	if(isdefined(level.nightvision_dlight))
	{
		level.nightvision_dlight delete();
	}

	self notify("nightvision_shellshock_off");
	maps\_utility::ent_flag_clear("nightvision_on");
	self.nightvision_enabled = undefined;
	var_00 = 0;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(nightvision_check(level.players[var_01]))
		{
			var_00 = 1;
		}
	}

	if(!var_00)
	{
		maps\_utility::remove_global_spawn_function("allies",::enable_ir_beacon);
	}

	thread nightvision_effectsoff();
}

//Function Number: 10
nightvision_effectsoff()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		var_02.usingnvfx = undefined;
		var_02 animscripts\shared::updatelaserstatus();
		var_02 stop_reflector_effect();
	}
}

//Function Number: 11
shouldbreaknvghintprint()
{
	return isdefined(self.nightvision_started);
}

//Function Number: 12
should_break_disable_nvg_print()
{
	return !isdefined(self.nightvision_started);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\skater\skater_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 412 ms
 * Timestamp: 10/27/2023 12:11:22 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\zombie_dlc2::func_DEE8();
	scripts\asm\zombie_dlc2\mp\states::func_2371();
	func_AEB0();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	level.agent_funcs["skater"]["on_damaged"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiedamaged;
	level.agent_funcs["skater"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["skater"]["gametype_on_killed"] = ::lib_0CBC::func_C5D2;
	level.var_BCCE["skater"] = ::lib_0CBC::func_E7FD;
	level.agent_definition["skater"]["setup_func"] = ::setupagent;
	level.agent_definition["skater"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["skater"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["skater"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2;
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["skater"] = ::func_3725;
}

//Function Number: 3
setupagent()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
	self.entered_playspace = 1;
	self.var_9CDD = 1;
	self.nocorpse = 1;
	self.allowpain = 0;
	if(isdefined(level.suicider_avoidance_radius))
	{
		self method_84E6(level.suicider_avoidance_radius);
	}

	thread func_899C();
}

//Function Number: 4
func_899C()
{
	self endon("death");
	level waittill("game_ended");
	self method_841F();
	foreach(var_04, var_01 in self.var_164D)
	{
		var_02 = var_01.var_4BC0;
		var_03 = level.var_2303[var_04].var_10E2F[var_02];
		lib_0A1A::func_2388(var_04,var_02,var_03,var_03.var_116FB);
		lib_0A1A::func_238A(var_04,"idle",0.2,undefined,undefined,undefined);
	}
}

//Function Number: 5
func_FACE(param_00)
{
	self setmodel("roller_skater_female_white");
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

//Function Number: 6
func_AEB0()
{
	level._effect["suicide_zmb_death"] = loadfx("vfx/iw7/_requests/coop/vfx_zmb_blackhole_death");
	level._effect["suicide_zmb_explode"] = loadfx("vfx/iw7/levels/cp_disco/vfx_disco_rollerskate_exp.vfx");
}

//Function Number: 7
func_3725()
{
	var_00 = 200;
	switch(level.var_1096B)
	{
		case 0:
			var_00 = 145;
			break;

		case 1:
			var_00 = 400;
			break;

		case 2:
			var_00 = 900;
			break;

		case 3:
			var_00 = 900;
			break;

		default:
			var_00 = 900;
			break;
	}

	return var_00;
}
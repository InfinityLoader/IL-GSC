/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 634 ms
 * Timestamp: 10/27/2023 12:11:29 AM
*******************************************************************/

//Function Number: 1
zombiesasquatchagentinit()
{
	registerscriptedagent();
}

//Function Number: 2
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\zombie_sasquatch::func_DEE8();
	scripts\asm\zombie_sasquatch\mp\states::func_2371();
	thread func_FAB0();
	func_AE11();
}

//Function Number: 3
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	if(!isdefined(level.var_10970))
	{
		level.var_10970 = [];
	}

	level.var_10970["zombie_sasquatch"] = [];
	level.agent_definition["zombie_sasquatch"]["setup_func"] = ::setupagent;
	level.agent_definition["zombie_sasquatch"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["zombie_sasquatch"] = [];
	level.agent_funcs["zombie_sasquatch"]["on_killed"] = ::onsasquatchkilled;
	level.agent_funcs["zombie_sasquatch"]["on_damaged_finished"] = ::onsasquatchdamagefinished;
}

//Function Number: 4
func_AE11()
{
	level._effect["sasquatch_rock_hit"] = loadfx("vfx/iw7/levels/cp_rave/sasquatch/vfx_rave_sas_projectile_impact.vfx");
}

//Function Number: 5
setupagent()
{
	self.var_4004 = undefined;
	self.var_BCF6 = undefined;
	self.var_26B9 = undefined;
	self.var_86BD = undefined;
	self.name = undefined;
	self.var_EB6A = undefined;
	self.var_CA5B = undefined;
	self.var_13CA0 = undefined;
	self.var_C2AD = undefined;
	self.sessionteam = undefined;
	self.sessionstate = undefined;
	self.var_55E6 = undefined;
	self.disabledweaponswitch = undefined;
	self.var_55D9 = undefined;
	self.var_55E4 = 1;
	self.nocorpse = undefined;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_116D4 = undefined;
	self.var_441A = undefined;
	self.var_4B82 = undefined;
	self.do_immediate_ragdoll = undefined;
	self.var_37FD = 0;
	self.var_24CA = undefined;
	self.var_B36E = undefined;
	self.var_126A3 = undefined;
	self.var_8C35 = 0;
	self.var_9341 = 1;
	self.var_1B03 = "idle";
	self.var_1F5 = "run";
	self.sharpturnnotifydist = 150;
	self.var_257 = 20;
	self.height = 53;
	self.var_252B = 26 + self.var_257;
	self.var_2539 = 54;
	self.var_253A = -64;
	self.var_4D45 = 2250000;
	self.var_181 = 1;
	self.var_86BD = self getentitynumber();
	self.var_BCE4 = 1;
	self.var_C081 = 1;
	self.var_126E8 = 1;
	self.var_772A = 1;
	self.var_2AB2 = 0;
	self.var_2AB8 = 1;
	self.var_118FC = 0;
	self.var_2F = 1;
	self.var_503C = self.var_257 + 1;
	self.var_565C = 0;
	self.var_54CB = 0;
	self.var_9E0C = undefined;
	self.flung = undefined;
	self.var_565C = 0;
	self.var_B0FC = 1;
	self.full_gib = 0;
	self.croc_chomp = 0;
	self.spawn_round_num = level.wave_num;
	self.footstepdetectdist = 600;
	self.footstepdetectdistwalk = 600;
	self.footstepdetectdistsprint = 600;
	self.var_A8A2 = [];
	self.allowpain = 1;
	self method_84E6(45);
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}

	self.entered_playspace = 1;
	thread func_899C();
}

//Function Number: 6
func_FACE(param_00)
{
	self setmodel("zmb_sasquatch_fullbody");
}

//Function Number: 7
setup_eye_glow()
{
	self endon("death");
	self method_80BB(1,0.1);
	wait(1);
	self setscriptablepartstate("right_eye","active");
	self setscriptablepartstate("left_eye","active");
}

//Function Number: 8
func_899C()
{
	self endon("death");
	level waittill("game_ended");
	self method_841F();
	var_00 = self.var_164D[self.var_238F];
	var_01 = var_00.var_4BC0;
	var_02 = level.var_2303[self.var_238F].var_10E2F[var_01];
	lib_0A1A::func_2388(self.var_238F,var_01,var_02,var_02.var_116FB);
	lib_0A1A::func_238A(self.var_238F,"idle",0.2,undefined,undefined,undefined);
}

//Function Number: 9
onsasquatchkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self method_80BB(1,0);
	self setscriptablepartstate("right_eye","inactive");
	self setscriptablepartstate("left_eye","inactive");
	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 10
onsasquatchdamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	scripts\mp\_mp_agent::func_5004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\alien_goon\alien_goon_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 544 ms
 * Timestamp: 10/27/2023 12:11:04 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	scripts\mp\agents\alien_goon\alien_goon_tunedata::setuptunedata();
	lib_0A02::init();
	behaviortree\alien_goon::func_DEE8();
	scripts\asm\alien_goon\mp\states::func_2371();
	scripts\asm\dlc4\alien_anim_utils::func_97C5();
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

	level.agent_definition["alien_goon"]["setup_func"] = ::setupagent;
	level.agent_definition["alien_goon"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["alien_goon"]["on_damaged"] = ::func_C4E0;
	level.agent_funcs["alien_goon"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["alien_goon"]["gametype_on_killed"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiekilled;
	level.agent_funcs["alien_goon"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["alien_goon"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2;
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["alien_goon"] = ::calculatealiengoonhealth;
	if(!isdefined(level.damage_feedback_overrride))
	{
		level.damage_feedback_overrride = [];
	}
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("alien_goon");
}

//Function Number: 4
setupzombiegametypevars()
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
	self.entered_playspace = 0;
	self.var_B36E = undefined;
	self.var_126A3 = undefined;
	self.var_8C35 = 0;
	self.attackent = undefined;
	self.var_9342 = 1;
	self.var_1B03 = "idle";
	self.var_1F5 = "walk";
	self.sharpturnnotifydist = 100;
	self.var_257 = 15;
	self.height = 40;
	self.var_252B = 26 + self.var_257;
	self.var_B640 = "normal";
	self.var_B641 = 50;
	self.var_2539 = 54;
	self.var_253A = -64;
	self.var_4D45 = 2250000;
	self.var_181 = 1;
	self.var_86BD = self getentitynumber();
	self.var_BCE4 = 0.9;
	self.var_C081 = 1;
	self.var_126E8 = 1;
	self.var_772A = 1;
	self.var_2AB2 = 0;
	self.var_2AB8 = 1;
	self.var_118FC = 0;
	self.var_2F = 1;
	self.var_B5F9 = 40;
	self.var_B62E = 70;
	self.var_B631 = 80;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_565C = 0;
	self.var_9BAC = 0;
	self.var_54CB = 0;
	self.damaged_by_player = 0;
	self.var_9E0C = undefined;
	self.flung = undefined;
	self.var_B0FC = 1;
	self.full_gib = 0;
	self.var_12E = undefined;
	self.var_E821 = undefined;
	self.var_A8A2 = [];
	self.var_8C12 = 0;
	self.hasplayedvignetteanim = undefined;
	self.var_9BA7 = undefined;
	self.var_179 = 200;
	self.deathmethod = undefined;
	self.var_10A57 = undefined;
	self.var_828A = undefined;
	self.var_CE65 = undefined;
	self.var_29D2 = 1;
	self.vignette_nocorpse = undefined;
	self.death_anim_no_ragdoll = undefined;
	self.allowpain = 0;
	self method_84E6(45);
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}
}

//Function Number: 5
setupagent()
{
	setupzombiegametypevars();
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_12EE6();
	self.height = self.var_18F4;
	self.var_257 = self.var_18F9;
	self.var_B62D = 70;
	self.var_B62E = 70;
	self.var_B631 = 80;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_B601 = 45;
	self.var_504E = 55;
	self.var_129AF = 55;
	self.var_368 = -60;
	self.var_100 = 60;
	self.ground_pound_damage = 50;
	self.footstepdetectdist = 2500;
	self.footstepdetectdistwalk = 2500;
	self.footstepdetectdistsprint = 2500;
	self.var_180 = 1;
	self.dontmutilate = 1;
	if(scripts\common\utility::istrue(self.activated_venomx_sphere))
	{
		self.activated_venomx_sphere = undefined;
	}

	if(scripts\common\utility::istrue(self.dot_triggered))
	{
		self.dot_triggered = undefined;
	}

	self.aj_goon = 0;
	self.preventplayerpushdist = 12;
	thread monitorwhizbys();
}

//Function Number: 6
func_AEB0()
{
	level._effect["alien_teleport_fx"] = loadfx("vfx/iw7/_requests/coop/zmb_fullbody_gib.vfx");
}

//Function Number: 7
monitorwhizbys()
{
	self endon("death");
	self.lastwhizbytime = undefined;
	for(;;)
	{
		self waittill("bulletwhizby",var_00,var_01);
		self.lastwhizbytime = gettime();
		self.lastwhizbyshooter = var_00;
		self.lastwhizbydist = var_01;
	}
}

//Function Number: 8
calculatealiengoonhealth()
{
	var_00 = 200;
	switch(level.var_1096B)
	{
		case 0:
			var_00 = 400;
			break;

		case 1:
			var_00 = 900;
			break;

		case 2:
			var_00 = 1300;
			break;

		case 3:
			var_00 = 1600;
			break;

		case 4:
			var_00 = 2000;
			break;

		default:
			var_00 = 2000;
			break;
	}

	return var_00;
}

//Function Number: 9
accumulatedamage(param_00,param_01)
{
	if(!isdefined(self.damageaccumulator))
	{
		self.damageaccumulator = spawnstruct();
		self.damageaccumulator.accumulateddamage = 0;
	}
	else if(!isdefined(self.damageaccumulator.var_A96A) || gettime() > self.damageaccumulator.var_A96A + 1000)
	{
		self.damageaccumulator.accumulateddamage = 0;
		self.damageaccumulator.var_A96A = 0;
	}

	self.damageaccumulator.var_A96A = gettime();
	if(!isdefined(param_01))
	{
		param_01 = (1,1,1);
	}

	self.damageaccumulator.lastdir = param_01;
	if(isdefined(self.fake_damage))
	{
		self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + self.fake_damage;
		self.fake_damage = undefined;
		return;
	}

	self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + param_00;
}

//Function Number: 10
func_C4E0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	accumulatedamage(param_02,param_07);
	scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}
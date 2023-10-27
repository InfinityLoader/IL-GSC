/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\pamgrier\pamgrier_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 569 ms
 * Timestamp: 10/27/2023 12:11:19 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\pamgrier::func_DEE8();
	scripts\asm\pamgrier\mp\states::func_2371();
	scripts\mp\agents\pamgrier\pamgrier_tunedata::setuptunedata();
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

	level.agent_definition["pamgrier"]["setup_func"] = ::setupagent;
	level.agent_definition["pamgrier"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["pamgrier"]["on_damaged_finished"] = ::ondamagefinished;
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("cp_disco_female_boss_pam_grier");
	self attach("weapon_zmb_katana_wm_camo","tag_weapon_right");
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
	self.var_BCE4 = 1;
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
	self.dont_cleanup = 1;
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}
}

//Function Number: 5
setupagent()
{
	setupzombiegametypevars();
	self.height = self.var_18F4;
	self.var_257 = self.var_18F9;
	self.var_9341 = 1;
	self.var_B62D = 70;
	self.var_B62E = 70;
	self.var_B631 = 80;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_B601 = 9999;
	self.var_504E = 55;
	self.var_129AF = 55;
	self.var_368 = -60;
	self.var_100 = 60;
	self.ground_pound_damage = 50;
	self.footstepdetectdist = 2500;
	self.footstepdetectdistwalk = 2500;
	self.footstepdetectdistsprint = 2500;
	self.team = "allies";
	self.var_180 = 1;
	self.ignoreme = 1;
	self.bchillin = 0;
	self.chillinpos = self.origin;
	self.chillinangles = self.angles;
	level.the_hoff_revive = 1;
	thread pamcleanup();
}

//Function Number: 6
pamcleanup()
{
	self waittill("death");
	level.the_hoff_revive = undefined;
}

//Function Number: 7
getenemy()
{
	return self.pamenemy;
}

//Function Number: 8
lookatenemy()
{
	var_00 = getenemy();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin - self.origin;
		var_02 = vectortoangles(var_01);
		self method_8289("face angle abs",(0,var_02[1],0));
		return;
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 9
setpassive()
{
	if(scripts\common\utility::istrue(self.bpassive))
	{
		return;
	}

	self.bneedschilltransition = 1;
	self.bpassive = 1;
}

//Function Number: 10
clearpassive()
{
	self.bneedschilltransition = undefined;
	self.bpassive = undefined;
}

//Function Number: 11
ondamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
}
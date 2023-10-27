/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\karatemaster\karatemaster_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 809 ms
 * Timestamp: 10/27/2023 12:11:16 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\karatemaster::func_DEE8();
	scripts\asm\karatemaster\mp\states::func_2371();
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

	level.agent_definition["karatemaster"]["setup_func"] = ::setupagent;
	level.agent_definition["karatemaster"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["karatemaster"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["karatemaster"]["gametype_on_killed"] = ::lib_0CBC::func_C5D2;
	level.agent_funcs["karatemaster"]["on_damaged"] = ::func_C4E0;
	level.agent_funcs["karatemaster"]["on_damaged_finished"] = ::ondamagefinished;
	level.agent_funcs["karatemaster"]["on_killed"] = level.var_C4BE;
	level.var_1094E["karatemaster"] = ::should_spawn_karatemaster;
}

//Function Number: 3
func_FACE(param_00)
{
	if(isdefined(level.karate_zombie_model_list))
	{
		var_01 = scripts\common\utility::random(level.karate_zombie_model_list);
	}
	else
	{
		var_01 = "karatemaster_male_3_black";
	}

	self setmodel(var_01);
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
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
	self method_84E6(30);
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}

	setmovemode("run");
}

//Function Number: 5
setupagent()
{
	thread scripts\mp\agents\zombie\zmb_zombie_agent::func_12EE6();
	setupzombiegametypevars();
	self.karatemaster = 1;
	self.aj_karatemaster = 0;
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
	self.allowpain = 0;
	self.dontmutilate = 1;
	scripts\mp\agents\karatemaster\karatemaster_tunedata::setuptunedata();
}

//Function Number: 6
getenemy()
{
	return self.myenemy;
}

//Function Number: 7
setmovemode(param_00)
{
	self.desiredmovemode = param_00;
}

//Function Number: 8
findgoodteleportcloserspot()
{
	if(isdefined(self.var_233))
	{
		var_00 = self method_841E();
		var_01 = self method_845D(var_00 - scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cteleportthisclosetoplayer);
		return var_01;
	}

	return self.initialteleportpos;
}

//Function Number: 9
accumulatedamage(param_00,param_01)
{
	var_02 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	if(!isdefined(self.damageaccumulator))
	{
		self.damageaccumulator = spawnstruct();
		self.damageaccumulator.accumulateddamage = 0;
	}
	else if(!isdefined(self.damageaccumulator.var_A96A) || gettime() > self.damageaccumulator.var_A96A + var_02.cdamageaccumulationcleartimems)
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
	self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + param_00;
}

//Function Number: 10
getdamageaccumulator()
{
	if(!isdefined(self.damageaccumulator))
	{
		self.damageaccumulator = spawnstruct();
		self.damageaccumulator.accumulateddamage = 0;
	}

	var_00 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
	if(!isdefined(self.damageaccumulator.var_A96A) || gettime() > self.damageaccumulator.var_A96A + var_00.cdamageaccumulationcleartimems)
	{
		self.damageaccumulator.accumulateddamage = 0;
		self.damageaccumulator.var_A96A = 0;
	}

	if(self.damageaccumulator.accumulateddamage == 0)
	{
		return undefined;
	}

	return self.damageaccumulator;
}

//Function Number: 11
cleardamageaccumulator()
{
	self.damageaccumulator.accumulateddamage = 0;
	self.damageaccumulator.var_A96A = 0;
}

//Function Number: 12
ondamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	accumulatedamage(param_02,param_07);
	scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 13
func_C4E0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(scripts\common\utility::istrue(self.ishidden))
	{
		return;
	}

	[[ level.on_zombie_damaged_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 14
should_spawn_karatemaster()
{
	if(scripts\common\utility::func_6E34("rk_fight_started") && scripts\common\utility::flag("rk_fight_started"))
	{
		return undefined;
	}

	var_00 = 0;
	if(level.wave_num >= 20)
	{
		var_00 = min(level.wave_num - 19,10);
	}
	else if(level.wave_num < 10)
	{
		return undefined;
	}

	var_01 = 5;
	if(getdvarint("scr_force_karatemaster_spawn",0) == 1)
	{
		var_01 = 0;
		var_00 = 100;
	}

	if(getdvarint("scr_force_no_karatemaster_spawn",0) == 1)
	{
		var_01 = 500;
		var_00 = 0;
	}

	if(level.wave_num > var_01)
	{
		if(randomint(100) < var_00)
		{
			return "karatemaster";
		}

		return undefined;
	}

	return undefined;
}
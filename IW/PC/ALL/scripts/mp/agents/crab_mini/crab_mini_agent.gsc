/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\crab_mini\crab_mini_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 793 ms
 * Timestamp: 10/27/2023 12:11:12 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	scripts\mp\agents\crab_mini\crab_mini_tunedata::setuptunedata();
	lib_0A02::init();
	behaviortree\crab_mini::func_DEE8();
	scripts\asm\crab_mini\mp\states::func_2371();
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

	level.agent_definition["crab_mini"]["setup_func"] = ::setupagent;
	level.agent_definition["crab_mini"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["crab_mini"]["on_damaged"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiedamaged;
	level.agent_funcs["crab_mini"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["crab_mini"]["gametype_on_killed"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiekilled;
	level.agent_funcs["crab_mini"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::func_C5CE;
	level.agent_funcs["crab_mini"]["on_killed"] = ::onkilled;
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["crab_mini"] = ::calculatecrabminihealth;
	if(!isdefined(level.damage_feedback_overrride))
	{
		level.damage_feedback_overrride = [];
	}

	level.damage_feedback_overrride["crab_mini"] = ::scripts\cp\maps\cp_town\cp_town_damage::crog_processdamagefeedback;
	if(!isdefined(level.special_zombie_damage_func))
	{
		level.special_zombie_damage_func = [];
	}

	level.special_zombie_damage_func["crab_mini"] = ::crab_mini_special_damage_func;
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("zmb_minicrab");
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
}

//Function Number: 6
getenemy()
{
	if(isdefined(self.myenemy))
	{
		return self.myenemy;
	}

	return undefined;
}

//Function Number: 7
lookatenemy()
{
	var_00 = getenemy();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin - self.origin;
		var_02 = vectortoangles(var_01);
		self method_8289("face angle abs",var_02);
		return;
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 8
calculatecrabminihealth()
{
	var_00 = 200;
	switch(level.var_1096B)
	{
		case 0:
			var_00 = 300;
			break;

		case 1:
			var_00 = 450;
			break;

		case 2:
			var_00 = 450;
			break;

		case 3:
			var_00 = 600;
			break;

		default:
			var_00 = 600;
			break;
	}

	return var_00;
}

//Function Number: 9
create_sludge_pool(param_00)
{
	self.var_CE65 = 1;
	if(!isdefined(level.goo_pool_ent_array))
	{
		level.goo_pool_ent_array = [];
	}

	var_01 = 2500;
	foreach(var_03 in level.goo_pool_ent_array)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(distancesquared(param_00,var_03.origin) < var_01)
		{
			var_03.var_AC75 = gettime() + 10000;
			return;
		}
	}

	var_05 = spawn("script_model",param_00);
	var_05 setmodel("tag_origin_crab_goo");
	level.goo_pool_ent_array[level.goo_pool_ent_array.size] = var_05;
	var_05 setscriptablepartstate("blood_pool","active");
	var_05 thread run_sludge_pool_damage_func();
}

//Function Number: 10
run_sludge_pool_damage_func()
{
	self endon("death");
	var_00 = 2500;
	self.var_AC75 = gettime() + 10000;
	while(self.var_AC75 > gettime())
	{
		foreach(var_02 in level.players)
		{
			if(distancesquared(self.origin,var_02.origin) < var_00)
			{
				var_03 = gettime();
				if(!isdefined(var_02.last_crab_sludge_time) || var_02.last_crab_sludge_time + 1000 < var_03)
				{
					var_02 dodamage(20,self.origin,self,self,"MOD_UNKNOWN");
					var_02.last_crab_sludge_time = gettime();
				}
			}
		}

		wait(0.05);
	}

	self delete();
}

//Function Number: 11
setisstuck(param_00)
{
	self.bisstuck = param_00;
}

//Function Number: 12
iscrabministuck()
{
	return isdefined(self.bisstuck) && self.bisstuck;
}

//Function Number: 13
crab_mini_special_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(level.var_9925) && level.var_9925)
	{
		return self.health;
	}

	if(isdefined(param_05) && param_05 == "iw7_knife_zm_cleaver")
	{
		return self.health;
	}

	if(isdefined(param_07))
	{
		var_0C = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
		var_0D = anglestoforward(self.angles) * -1;
		var_0E = vectordot(var_0D,param_07);
		if(var_0E > var_0C.reduce_damage_dot)
		{
			param_02 = param_02 * var_0C.reduce_damage_pct;
			self.armor_hit = 1;
		}
	}

	return param_02;
}

//Function Number: 14
onkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	thread play_death_sfx(1);
	return scripts\mp\agents\zombie\zmb_zombie_agent::func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 15
play_death_sfx(param_00)
{
	playsoundatpos(self.origin,"minion_crog_pre_explo");
	wait(param_00);
	playsoundatpos(self.origin,"minion_crog_explode");
}
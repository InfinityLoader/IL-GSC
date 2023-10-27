/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\crab_brute\crab_brute_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 916 ms
 * Timestamp: 10/27/2023 12:11:10 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\crab_brute::func_DEE8();
	scripts\asm\crab_brute\mp\states::func_2371();
	scripts\mp\agents\crab_brute\crab_brute_tunedata::setuptunedata();
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

	level.agent_definition["crab_brute"]["setup_func"] = ::setupagent;
	level.agent_definition["crab_brute"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["crab_brute"]["on_damaged"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiedamaged;
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["crab_brute"] = ::calculatecrabbruteihealth;
	level.agent_funcs["crab_brute"]["gametype_on_killed"] = ::func_C4D1;
	level.brute_loot_check = [];
	if(!isdefined(level.damage_feedback_overrride))
	{
		level.damage_feedback_overrride = [];
	}

	level.damage_feedback_overrride["crab_brute"] = ::scripts\cp\maps\cp_town\cp_town_damage::crog_processdamagefeedback;
	if(!isdefined(level.special_zombie_damage_func))
	{
		level.special_zombie_damage_func = [];
	}

	level.special_zombie_damage_func["crab_brute"] = ::crab_brute_special_damage_func;
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("zmb_brutecrab");
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
	self.var_594C = 1;
	self.spawn_round_num = level.wave_num;
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
	self.var_B601 = 45;
	self.var_504E = 55;
	self.var_129AF = 55;
	self.var_368 = -60;
	self.var_100 = 60;
	self method_84E6(45);
	self.ground_pound_damage = 50;
	self.footstepdetectdist = 2500;
	self.footstepdetectdistwalk = 2500;
	self.footstepdetectdistsprint = 2500;
	self.var_180 = 1;
	self method_85C9(16);
	thread dopostspawnupdates();
	thread listen_for_death_sfx();
}

//Function Number: 6
dopostspawnupdates()
{
	wait(0.5);
	self.dont_cleanup = 1;
}

//Function Number: 7
listen_for_death_sfx()
{
	self waittill("death");
	self playsound("brute_crog_death");
	wait(1);
	self playsound("brute_crog_explo");
}

//Function Number: 8
getenemy()
{
	if(isdefined(self.myenemy))
	{
		return self.myenemy;
	}

	return undefined;
}

//Function Number: 9
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

//Function Number: 10
crab_brute_special_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(lib_0A1A::func_2354("burrow_loop"))
	{
		return 0;
	}

	if(param_05 == "gas_grenade_mp")
	{
		return 0;
	}

	self.var_A96A = gettime();
	if(isdefined(param_07))
	{
		var_0C = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
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

//Function Number: 11
func_C4D1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.agent_type) && self.agent_type == "crab_brute")
	{
		param_01 scripts\cp\_merits::func_D9AD("mt_dlc3_crab_brute");
	}

	var_0C = scripts\common\utility::random(["ammo_max","instakill_30","cash_2","instakill_30","cash_2","instakill_30","cash_2"]);
	if(isdefined(var_0C) && !isdefined(self.var_72AC))
	{
		if(!isdefined(level.brute_loot_check[self.spawn_round_num]))
		{
			level.brute_loot_check[self.spawn_round_num] = 1;
			level thread scripts\cp\zombies\_powerups::drop_loot(self.origin,param_01,var_0C);
		}
	}

	var_0D = 400;
	level thread boss_death_vo();
	foreach(var_0F in level.players)
	{
		var_0F scripts\cp\_persistence::func_82F9(var_0D);
	}
}

//Function Number: 12
boss_death_vo()
{
	wait(10);
	if(isdefined(level.elvira_ai))
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_crog_defeat_elvira","rave_announcer_vo","highest",70,0,0,1);
		return;
	}

	level thread scripts\cp\_vo::try_to_play_vo("ww_crog_defeat_generic","rave_announcer_vo","highest",70,0,0,1);
}

//Function Number: 13
calculatecrabbruteihealth()
{
	return 5000 * level.players.size;
}

//Function Number: 14
shouldignoreenemy(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(param_00.ignoreme || isdefined(param_00.var_222) && param_00.var_222.ignoreme)
	{
		return 1;
	}

	if(lib_0F74::func_1002C(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 15
create_brute_death_fx(param_00)
{
	self.var_CE65 = 1;
}
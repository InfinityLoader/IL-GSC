/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\ratking\ratking_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 1147 ms
 * Timestamp: 10/27/2023 12:11:21 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\ratking::func_DEE8();
	scripts\asm\ratking\mp\states::func_2371();
	scripts\mp\agents\ratking\ratking_tunedata::setuptunedata();
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

	level.agent_definition["ratking"]["setup_func"] = ::setupagent;
	level.agent_definition["ratking"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["ratking"]["on_damaged_finished"] = ::onratkingdamagefinished;
	level.agent_funcs["ratking"]["on_killed"] = ::onratkingkilled;
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("zmb_rat_king");
	thread delaygiveequipment();
}

//Function Number: 4
delaygiveequipment()
{
	level endon("game_ended");
	self endon("fake_death");
	wait(0.1);
	self setscriptablepartstate("staff","staff_activate");
	self setscriptablepartstate("shield","shield_activate");
}

//Function Number: 5
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
	self.var_B62E = 75;
	self.var_B631 = 120;
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
	self.hasshield = 1;
	self.hasstaff = 1;
	self.next_block_fx_time = 0;
	self.next_pain_time = 0;
	self.next_forced_teleport_time = 0;
	self.fake_death = undefined;
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}
}

//Function Number: 6
setupagent()
{
	setupzombiegametypevars();
	self.height = self.var_18F4;
	self.var_257 = self.var_18F9;
	self.var_9341 = 1;
	self.var_B62D = 75;
	self.var_B62E = 75;
	self.var_B631 = 120;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_B601 = 67;
	self.fake_death = undefined;
	self.meleeattackchance["melee_attack"] = 70;
	self.meleeattackchance["staff_stomp"] = 30;
	self.var_504E = 55;
	self.var_129AF = 55;
	self.var_368 = -60;
	self.var_100 = 60;
	self.var_166 = "slasher_grenade_zm";
	self.var_162 = 999;
	self.ground_pound_damage = 50;
	self.footstepdetectdist = 2500;
	self.footstepdetectdistwalk = 2500;
	self.footstepdetectdistsprint = 2500;
	self.var_71D0 = ::shouldratkingplaypainanim;
	thread listen_for_fake_death();
}

//Function Number: 7
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

//Function Number: 8
isinravemode()
{
	if(self method_85B8())
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
onratkingdamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	accumulatedamage(param_02,param_07);
	ratking_on_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0B,param_0C);
}

//Function Number: 10
ratking_on_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	var_0D = self.health;
	if(isdefined(param_07))
	{
		var_0E = vectortoyaw(param_07);
		var_0F = self.angles[1];
		self.var_E3 = angleclamp180(var_0E - var_0F);
	}
	else
	{
		self.var_E3 = 0;
	}

	self.var_DD = param_08;
	self.var_DE = param_04;
	self.var_4D3F = param_01;
	self.var_DC = param_07;
	self.var_E1 = param_02;
	self.var_E2 = param_05;
	self.var_4D62 = param_06;
	if(param_02 >= self.health)
	{
		param_02 = 0;
		level.rat_king_death_pos = self.origin;
		if(scripts\common\utility::func_2286(level.spawned_enemies,self))
		{
			level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,self);
		}

		self notify("fake_death");
	}

	self method_80E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0B,param_0C,0,1);
	if(self.health > 0 && self.health < var_0D)
	{
		self notify("pain");
	}

	if(isalive(self) && isdefined(self.agent_type))
	{
		var_10 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];
		if(isdefined(var_10))
		{
			[[ var_10 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
		}
	}
}

//Function Number: 11
onratkingkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.nocorpse = 1;
	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 12
getratkinggrenadehandoffset()
{
	return (12,12,100);
}

//Function Number: 13
getratkinghandposition()
{
	return self method_81E7(self.origin + (12,12,100));
}

//Function Number: 14
shouldratkingplaypainanim()
{
	return 0;
}

//Function Number: 15
getstructpos()
{
	if(isdefined(self.ratkingbouncetarget))
	{
		return self.ratkingbouncetarget;
	}

	return undefined;
}

//Function Number: 16
getenemy()
{
	if(isdefined(self.ratkingenemy) && isalive(self.ratkingenemy))
	{
		return self.ratkingenemy;
	}

	return undefined;
}

//Function Number: 17
lookatspot()
{
	var_00 = getstructpos();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin - self.origin;
		var_02 = vectortoangles(var_01);
		self method_8289("face angle abs",(0,var_02[1],0));
		return;
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 18
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

//Function Number: 19
executefakedeath()
{
	self method_85B7(1);
	wait(0.2);
	self suicide();
	wait(0.2);
}

//Function Number: 20
listen_for_fake_death()
{
	self endon("death");
	for(;;)
	{
		self waittill("fake_death");
		if(!scripts\common\utility::istrue(level.ratking_fight))
		{
			self.fake_death = 1;
			scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
			continue;
		}

		if(scripts\common\utility::istrue(level.ratking_fight))
		{
			self.var_180 = 1;
			self.var_EF64 = 1;
			foreach(var_01 in level.players)
			{
				var_01 thread scripts\cp\maps\cp_disco\rat_king_fight::outroblackscreen();
			}

			wait(2);
			self suicide();
		}
	}
}

//Function Number: 21
rkhasstaff()
{
	return scripts\common\utility::istrue(self.hasstaff);
}

//Function Number: 22
rkhasshield()
{
	return self.var_2303.shieldstate == "equipped";
}
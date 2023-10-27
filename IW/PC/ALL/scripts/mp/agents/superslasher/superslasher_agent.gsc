/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\superslasher\superslasher_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 697 ms
 * Timestamp: 10/27/2023 12:11:25 AM
*******************************************************************/

//Function Number: 1
superslasheragentinit()
{
	registerscriptedagent();
}

//Function Number: 2
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\superslasher::func_DEE8();
	scripts\asm\superslasher\mp\states::func_2371();
	thread func_FAB0();
	level.superslasherspawnspot = (-4803,4703,-130);
	level.superslasherspawnangles = (0,-170,0);
	level.superslasherrooftopspot = (-6119,4829,355);
	level.superslasherrooftopangles = (0,10,0);
	level.superslashergotogroundspot = (-5024,4857,-130);
	level.superslasherjumptoroofangles = (0,-170,0);
	loadsuperslasherscriptmodelanim();
	loadsuperslashervfx();
}

//Function Number: 3
loadsuperslasherscriptmodelanim()
{
	precachempanim("IW7_cp_super_death_01");
}

//Function Number: 4
loadsuperslashervfx()
{
	level._effect["super_slasher_death_base"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_ss_death_base_start.vfx");
	level._effect["super_slasher_death_hand"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_ss_death_hands_glow.vfx");
	level._effect["super_slasher_death_limb"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_ss_death_limbs_glow.vfx");
	level._effect["super_slasher_shield_hit"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_ss_shield_hit.vfx");
	level._effect["super_slasher_saw_shark_hit"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_rave_superslasher_stomp_attack.vfx");
	level._effect["super_slasher_saw_shark_spark"] = loadfx("vfx/iw7/levels/cp_rave/superslasher/vfx_rave_superslasher_saw_spark.vfx");
}

//Function Number: 5
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

	level.var_10970["superslasher"] = [];
	level.agent_definition["superslasher"]["setup_func"] = ::setupagent;
	level.agent_definition["superslasher"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["superslasher"] = [];
	level.agent_funcs["superslasher"]["on_damaged"] = ::onsuperslasherdamaged;
	level.agent_funcs["superslasher"]["on_killed"] = ::onsuperslasherkilled;
	level.agent_funcs["superslasher"]["on_damaged_finished"] = ::onsuperslasherdamagefinished;
}

//Function Number: 6
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
	self.entered_playspace = 0;
	self.var_B36E = undefined;
	self.var_126A3 = undefined;
	self.var_8C35 = 0;
	self.var_9341 = 1;
	self.var_9342 = 1;
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
	self.dont_cleanup = 1;
	self.footstepdetectdist = 600;
	self.footstepdetectdistwalk = 600;
	self.footstepdetectdistsprint = 600;
	self.allowpain = 1;
	self.var_A8A2 = [];
	self.var_A964 = [];
	self.var_A96A = 0;
	if(getdvarint("scr_zombie_left_foot_sharp_turn_only",0) == 1)
	{
		self.var_AB3F = 1;
	}

	thread func_899C();
}

//Function Number: 7
func_FACE(param_00)
{
	self setmodel("fullbody_zmb_superslasher");
}

//Function Number: 8
func_899C()
{
	self endon("death");
	level waittill("game_ended");
	self.var_1198.bgameended = 1;
}

//Function Number: 9
onsuperslasherkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.death_anim_no_ragdoll = 1;
	self.nocorpse = 1;
	if(isdefined(self.attackents))
	{
		foreach(var_0A in self.attackents)
		{
			var_0A delete();
		}
	}

	if(isdefined(self.shields))
	{
		foreach(var_0D in self.shields)
		{
			var_0D delete();
		}
	}

	scripts\asm\superslasher\superslasher_actions::stopwireattack();
	thread superslasherdeathscriptmodelsequence(self);
	var_0F = self.var_238F;
	var_10 = self.var_164D[var_0F].var_4BC0;
	var_11 = level.var_2303[var_0F].var_10E2F[var_10];
	lib_0A1A::func_2388(var_0F,var_10,var_11,undefined);
	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 10
superslasherdeathscriptmodelsequence(param_00)
{
	level.soul_key_drop_pos = scripts\common\utility::func_5D14(param_00.origin,200,-5000) + (0,0,50);
	var_01 = param_00.origin;
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("fullbody_zmb_superslasher");
	var_02 scriptmodelplayanim("IW7_cp_super_death_01");
	playsoundatpos(var_02.origin,"zmb_superslasher_death_lr");
	var_02 thread super_slasher_death_vfx_sequence(var_02);
	wait(3.5);
	var_02 moveto(var_01 + (0,0,-300),11.5);
	var_02 waittill("movedone");
	var_02 delete();
	level notify("super_slasher_death");
}

//Function Number: 11
super_slasher_death_vfx_sequence(param_00)
{
	var_01 = spawnfx(level._effect["super_slasher_death_base"],param_00.origin);
	triggerfx(var_01);
	wait(0.6);
	playfxontag(level._effect["super_slasher_death_hand"],param_00,"j_wrist_ri");
	playfxontag(level._effect["super_slasher_death_limb"],param_00,"j_hip_ri");
	wait(0.5);
	playfxontag(level._effect["super_slasher_death_hand"],param_00,"j_wrist_le");
	wait(0.2);
	playfxontag(level._effect["super_slasher_death_limb"],param_00,"j_hip_le");
	wait(1.3);
	playfxontag(level._effect["super_slasher_death_limb"],param_00,"j_elbow_le");
	wait(1);
	playfxontag(level._effect["super_slasher_death_limb"],param_00,"j_clavicle_ri");
	wait(0.7);
	playfxontag(level._effect["super_slasher_death_limb"],param_00,"j_clavicle_le");
	param_00 waittill("movedone");
	var_01 delete();
}

//Function Number: 12
onsuperslasherdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_01) && param_01 == self)
	{
		return;
	}

	if(scripts\common\utility::istrue(self.var_E0) && isdefined(param_06) && isdefined(param_07))
	{
		playfx(level._effect["super_slasher_shield_hit"],param_06,param_07 * -150);
	}

	if(isdefined(self.btrophysystem))
	{
		if(isdefined(param_01) && isplayer(param_01))
		{
			self.var_A964[self.var_A964.size] = vectornormalize(param_01.origin - self.origin);
			self.var_A96A = gettime();
		}

		return;
	}

	if(scripts\common\utility::istrue(self.var_E0))
	{
		return;
	}

	if(isdefined(self.var_1198.binair))
	{
		param_02 = int(min(param_02,self.health - 1));
		if(param_02 == 0)
		{
			return;
		}
	}

	if(param_05 == "iw7_harpoon_zm")
	{
		param_02 = min(0.1 * self.maxhealth,2000);
		param_02 = int(param_02);
	}
	else if(issubstr(param_05,"harpoon1"))
	{
		param_02 = min(0.01 * self.maxhealth,75);
		param_02 = int(param_02);
	}
	else if(issubstr(param_05,"harpoon2"))
	{
		param_02 = min(0.1 * self.maxhealth,1500);
		param_02 = int(param_02);
	}
	else if(issubstr(param_05,"harpoon3"))
	{
		param_02 = min(0.1 * self.maxhealth,2000);
		param_02 = int(param_02);
	}
	else if(issubstr(param_05,"harpoon4"))
	{
		param_02 = min(0.01 * self.maxhealth,1000);
		param_02 = int(param_02);
	}

	param_03 = param_03 | level.var_92C0;
	if(isdefined(level.players) && level.players.size >= 1)
	{
		param_02 = param_02 / level.players.size;
	}

	scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 13
onsuperslasherdamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	scripts\mp\_mp_agent::func_5004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}
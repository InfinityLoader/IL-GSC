/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3961.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:31:50 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	level.var_13F28 = scripts\common\utility::getstructarray("zombie_ghost_hide_node","script_noteworthy");
	level.var_13F29 = scripts\common\utility::getstructarray("zombie_ghost_hover_node","targetname");
	lib_0A02::init();
	lib_03B4::func_DEE8();
	lib_0F46::func_2371();
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

	level.agent_definition["zombie_ghost"]["setup_func"] = ::setupagent;
	level.agent_definition["zombie_ghost"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["zombie_ghost"]["on_killed"] = ::func_C535;
	level.agent_funcs["zombie_ghost"]["on_damaged"] = ::func_C536;
}

//Function Number: 3
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
	self.var_B62E = 60;
	self.var_B62F = squared(self.var_B62E);
	self.var_503C = self.var_257 + 1;
	self.var_B607 = 0.5;
	self.var_565C = 0;
	self.var_54CB = 0;
	self.var_9E0C = undefined;
	self.flung = undefined;
	self.var_565C = 0;
	self.var_B0FC = 1;
	self.full_gib = 0;
	self.var_C1F7 = 0;
	lib_0F74::func_F794(self.var_B62E);
	self setsolid(0);
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
	var_01 = get_ghost_info();
	self.color = var_01.color;
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && level.fbd.fightstarted)
	{
		self setmodel("dlc4_boss_soul");
		return;
	}

	self setmodel(level.zombie_ghost_model);
}

//Function Number: 6
get_ghost_info()
{
	var_00 = spawnstruct();
	switch(level.zombie_ghost_model)
	{
		case "zombie_ghost_cube_red":
		case "zombie_ghost_red":
			var_00.color = "red";
			break;

		case "zombie_ghost_cube_green":
		case "zombie_ghost_green":
			var_00.color = "green";
			break;

		case "zombie_ghost_cube_yellow":
		case "zombie_ghost_yellow":
			var_00.color = "yellow";
			break;

		case "zombie_ghost_cube_blue":
		case "zombie_ghost_blue":
			var_00.color = "blue";
			break;

		case "zombie_ghost_bomb_red":
			var_00.color = "red_bomb";
			break;

		case "zombie_ghost_bomb_green":
			var_00.color = "green_bomb";
			break;

		case "zombie_ghost_bomb_yellow":
			var_00.color = "yellow_bomb";
			break;

		case "zombie_ghost_bomb_blue":
			var_00.color = "blue_bomb";
			break;

		case "zombie_ghost_cube_white":
			var_00.color = "white";
			break;
	}

	return var_00;
}

//Function Number: 7
func_50EF()
{
	self endon("death");
	wait(0.5);
	if(scripts\common\utility::istrue(self.head_is_exploding))
	{
		return;
	}

	if(isdefined(level.var_C01F))
	{
	}
}

//Function Number: 8
func_AEB0()
{
	level._effect["ghost_explosion_death_green"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_ghost_imp.vfx");
}

//Function Number: 9
func_C536(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = gettime();
	if(isplayer(param_01))
	{
		if(isdefined(param_05) && param_05 == "iw7_entangler_zm")
		{
			if(!isdefined(self.var_65FC))
			{
				func_D974(param_01,self);
			}
			else if(param_01 == self.var_65FC)
			{
				func_D974(param_01,self);
			}
			else if(!isdefined(level.fbd) || !isdefined(level.fbd.fightstarted) || !level.fbd.fightstarted)
			{
				func_8263(param_01,var_0C);
			}
		}
		else if(!isdefined(level.fbd) || !isdefined(level.fbd.fightstarted) || !level.fbd.fightstarted)
		{
			param_01 iprintlnbold("This weapon is not effective againt the ghost");
		}
	}

	if(isdefined(param_02))
	{
		self.health = self.health + param_02;
	}
}

//Function Number: 10
func_8263(param_00,param_01)
{
	if(!isdefined(param_00.var_D8A1) || param_01 - param_00.var_D8A1 / 1000 > 3)
	{
		if(isdefined(level.grab_same_ghost_string))
		{
			param_00 iprintlnbold(level.grab_same_ghost_string);
		}
		else
		{
			param_00 iprintlnbold(&"CP_ZMB_GHOST_TRACK_SAME_GHOST");
		}

		param_00.var_D8A1 = param_01;
	}
}

//Function Number: 11
func_D974(param_00,param_01)
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_12DBA(param_00,param_01);
	param_01 thread func_158F(param_01);
	param_01 thread func_65FD(param_00,param_01);
}

//Function Number: 12
func_158F(param_00)
{
	param_00 endon("death");
	param_00 notify("activate_being_tracked_scriptable");
	param_00 endon("activate_being_tracked_scriptable");
	param_00 setscriptablepartstate("being_tracked","on");
	wait(0.2);
	param_00 setscriptablepartstate("being_tracked","off");
}

//Function Number: 13
func_65FD(param_00,param_01)
{
	param_01 endon("death");
	param_01 notify("entangled_by_player_monitor");
	param_01 endon("entangled_by_player_monitor");
	param_01.var_65FC = param_00;
	scripts\common\utility::func_136F7();
	param_01.var_65FC = undefined;
}

//Function Number: 14
func_C535(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_108D0(self.var_1657,param_03,param_04);
	scripts\mp\_mp_agent::func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(isdefined(level.var_8269))
	{
		[[ level.var_8269 ]](param_01,param_04);
	}
}

//Function Number: 15
func_108D0(param_00,param_01,param_02)
{
}
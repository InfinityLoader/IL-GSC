/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\init.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1782 ms
 * Timestamp: 10/27/2023 12:00:39 AM
*******************************************************************/

//Function Number: 1
func_98E1(param_00)
{
	self.var_39B[param_00] = spawnstruct();
	self.var_39B[param_00].var_245 = "none";
	self.var_39B[param_00].var_8BDE = 1;
	if(function_00E6(param_00) != "")
	{
		self.var_39B[param_00].var_13053 = 1;
		return;
	}

	self.var_39B[param_00].var_13053 = 0;
}

//Function Number: 2
func_A000(param_00)
{
	return isdefined(self.var_39B[param_00]);
}

//Function Number: 3
func_F724()
{
	anim.var_4717 = 55;
	anim.var_1A52 = 10;
	anim.var_1A50 = 4096;
	anim.var_1A51 = 45;
	anim.var_1A44 = 20;
	anim.var_C88B = 25;
	anim.var_C889 = level.var_1A50;
	anim.var_C88A = level.var_1A51;
	anim.var_C87D = 30;
	anim.var_B480 = 65;
	anim.var_B47F = 65;
}

//Function Number: 4
func_68BD()
{
	if(scripts\anim\utility_common::func_9F4F(self.var_F0C4))
	{
		return 1;
	}

	if(weaponclass(self.var_D8E1) == "rocketlauncher")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_FAFB()
{
	self endon("death");
	scripts\common\utility::flag_wait("load_finished");
	if(isdefined(level.var_13CC8) && isdefined(level.var_13CC8[self.var_12BA4]))
	{
		self [[ level.var_13CC8[self.var_12BA4] ]]();
		return;
	}

	func_5031();
}

//Function Number: 6
main()
{
	self.var_1491 = spawnstruct();
	self.var_1491.var_A878 = 0;
	self.var_D8E1 = self.var_394;
	func_6DE9();
	if(!scripts\common\utility::func_6E34("load_finished"))
	{
		scripts\common\utility::flag_init("load_finished");
	}

	if(self.var_D8E1 == "")
	{
		self.var_D8E1 = "none";
	}

	if(self.var_F0C4 == "")
	{
		self.var_F0C4 = "none";
	}

	if(self.var_101B4 == "")
	{
		self.var_101B4 = "none";
	}

	self.var_E6E6 = %root;
	self.var_1491.var_2C13 = %body;
	thread func_2A69();
	self.var_1491.var_D6A5 = "stand";
	self.var_1491.var_85E2 = "stand";
	self.var_1491.var_BCC8 = "stop";
	self.var_1491.var_10E19 = "stop";
	self.var_1491.var_10930 = "none";
	self.var_1491.var_870D = "none";
	self.var_1491.var_D8BD = -1;
	self.var_102 = 1;
	self.var_B781 = 750;
	thread func_FAFB();
	self.var_1491.var_BE98 = 0;
	self.var_1491.var_4401 = gettime();
	self.var_1491.var_A981 = gettime();
	self.var_1491.var_112CB = 0;
	self.var_1491.var_55FC = !self method_8198();
	self.var_1491.var_AFFF = 0;
	self.var_1491.var_C888 = 0;
	self.var_1491.var_A9ED = 0;
	self.var_1491.var_BF84 = 0;
	self.var_1491.var_DD61 = 0.8;
	self.var_1491.var_D707 = undefined;
	self.var_1491.var_10B53 = "stand";
	self.var_3EF3 = ::scripts\anim\utility::func_3EF2;
	self.var_117C = 0;
	self.var_1300 = 0;
	thread func_6568();
	self.var_2894 = 1;
	self.var_1491.var_B8D6 = 0;
	self.var_1491.var_C043 = 0;
	self.var_1491.var_B8D6 = 0;
	self.var_1491.var_B8D8 = 0;
	self.var_1491.var_5605 = 0;
	self.var_154E = 1;
	self.var_3D4B = 0;
	self.var_101E7 = 0;
	self.var_101E6 = 1;
	self.var_BE8B = 1;
	self.var_504E = 55;
	scripts\sp\_utility::func_F6FE("asm");
	self.var_1491.var_BFAF = 0;
	if(!isdefined(self.var_EDB1))
	{
		self.var_EDB1 = 0;
	}

	func_FAF2();
	self.var_A980 = 0;
	self.var_440E = 0;
	self.var_112C8 = 0;
	self.var_112CA = 0;
	if(self.team == "allies")
	{
		self.var_112CE = 0.5;
	}
	else
	{
		self.var_112CE = 0;
	}

	if(self.team == "allies")
	{
		self.var_DCAF = 0;
	}
	else
	{
		self.var_DCAF = 256;
	}

	self.var_1E3E = 8000;
	self.var_1E3F = 0;
	scripts\anim\animset::func_FA33();
	self.var_68C6 = [];
	self.var_68C6["corner"] = 1;
	self.var_68C6["cover_crouch"] = 1;
	self.var_68C6["stop"] = 1;
	self.var_68C6["stop_immediate"] = 1;
	self.var_68C6["move"] = 1;
	self.var_68C6["exposed"] = 1;
	self.var_68C6["corner_normal"] = 1;
	var_00 = getarraykeys(self.var_68C6);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		scripts\common\utility::func_414E(var_00[var_01]);
	}

	self.var_DD23 = 0;
	self.var_FFD3 = 0;
	if(!isdefined(level.var_55FE))
	{
		thread scripts\anim\combat_utility::func_B9D9();
	}

	thread func_C4EA();
	if(getdvarint("ai_iw7",0) == 1 && !getdvarint("r_reflectionProbeGenerate"))
	{
		self method_8250(0);
		lib_0A02::func_77();
		lib_0A1E::func_234D(self.var_1FA9,self.var_1FA8);
		thread func_19F7();
		self.var_1FA9 = undefined;
		self.var_1FA8 = undefined;
	}

	thread func_F7AC();
}

//Function Number: 7
func_1929()
{
	return self.var_1198.var_444A;
}

//Function Number: 8
func_100B4(param_00,param_01)
{
	if(!param_00 || self.var_12BA4 != "soldier" && self.var_12BA4 != "c6")
	{
		return 1;
	}

	var_02 = int(gettime() / 50) % 2;
	return param_01 == var_02;
}

//Function Number: 9
func_1001A()
{
	return isdefined(self.var_3135.var_72EB) && self.var_3135.var_72EB;
}

//Function Number: 10
func_19F7()
{
	self endon("terminate_ai_threads");
	self endon("entitydeleted");
	thread lib_0A1E::func_51B8();
	thread lib_0A1E::func_126E5();
	var_00 = 1;
	var_01 = self getentitynumber() % 2;
	for(;;)
	{
		var_02 = 0;
		if(func_1001A())
		{
			lib_0A02::func_90();
			var_02 = 1;
			self.var_3135.var_72EB = undefined;
		}
		else if(var_00)
		{
			if(!func_1929())
			{
				lib_0A02::func_90();
				var_02 = 1;
			}
		}

		if(var_02)
		{
			lib_0A1A::func_2314();
		}

		if(isdefined(self.var_2303.var_10E23))
		{
			lib_0A1A::func_2317(self.var_2303.var_10E23);
			self.var_2303.var_10E23 = undefined;
		}

		lib_0A1A::func_2389();
		wait(0.05);
		if(!isdefined(self))
		{
			break;
		}

		var_00 = func_100B4(var_02,var_01);
	}
}

//Function Number: 11
func_13CC7(param_00)
{
	var_01[0] = "m4_grenadier";
	var_01[1] = "m4_grunt";
	var_01[2] = "m4_silencer";
	var_01[3] = "m4m203";
	if(!isdefined(param_00))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(issubstr(param_00,var_01[var_02]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_F7AC()
{
	self endon("death");
	if(!isdefined(level.var_AE64))
	{
		level waittill("loadout complete");
	}

	scripts\sp\_names::func_7B05();
	thread scripts\anim\squadmanager::func_185C();
}

//Function Number: 13
func_D650()
{
	for(;;)
	{
		if(self method_81BF("stand"))
		{
			var_00[0] = "stand allowed";
			var_01[0] = (0,1,0);
		}
		else
		{
			var_00[0] = "stand not allowed";
			var_01[0] = (1,0,0);
		}

		if(self method_81BF("crouch"))
		{
			var_00[1] = "crouch allowed";
			var_01[1] = (0,1,0);
		}
		else
		{
			var_00[1] = "crouch not allowed";
			var_01[1] = (1,0,0);
		}

		if(self method_81BF("prone"))
		{
			var_00[2] = "prone allowed";
			var_01[2] = (0,1,0);
		}
		else
		{
			var_00[2] = "prone not allowed";
			var_01[2] = (1,0,0);
		}

		var_02 = self method_815B() + (0,0,30);
		var_03 = (0,0,-10);
		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			var_05 = (var_02[0] + var_03[0] * var_04,var_02[1] + var_03[1] * var_04,var_02[2] + var_03[2] * var_04);
		}

		wait(0.05);
	}
}

//Function Number: 14
func_FAF2()
{
	if(!isdefined(self.var_1FC6) || !isdefined(self.var_BCD6))
	{
		func_F2B0();
	}
}

//Function Number: 15
func_F2B0()
{
	self.var_1FC6 = 0.97 + randomfloat(0.13);
	self.var_BD22 = 0.97 + randomfloat(0.13);
	self.var_BCD6 = self.var_BD22;
	self.var_101BB = 1.35;
}

//Function Number: 16
func_94AC(param_00,param_01,param_02,param_03)
{
	anim waittill("new exceptions");
}

//Function Number: 17
func_0104(param_00,param_01,param_02,param_03)
{
}

//Function Number: 18
func_6568()
{
	self endon("death");
	if(1)
	{
		return;
	}

	for(;;)
	{
		self waittill("enemy");
		if(!isalive(self.var_10C))
		{
			continue;
		}

		while(isplayer(self.var_10C))
		{
			if(scripts\anim\utility::func_8BED())
			{
				level.var_A9D0 = gettime();
			}

			wait(2);
		}
	}
}

//Function Number: 19
func_98E4()
{
	level.var_13D57[0] = -36.8552;
	level.var_13D57[1] = -27.0095;
	level.var_13D57[2] = -15.5981;
	level.var_13D57[3] = -4.37769;
	level.var_13D57[4] = 17.7776;
	level.var_13D57[5] = 59.8499;
	level.var_13D57[6] = 104.808;
	level.var_13D57[7] = 152.325;
	level.var_13D57[8] = 201.052;
	level.var_13D57[9] = 250.244;
	level.var_13D57[10] = 298.971;
	level.var_13D57[11] = 330.681;
}

//Function Number: 20
func_6DE9()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		func_6DEA();
		return;
	}

	if(isdefined(level.var_C122))
	{
		return;
	}

	anim.var_C122 = 1;
	scripts\anim\animset::func_94FD();
	anim.var_13086 = 0;
	lib_0B5F::func_965A();
	level.var_BF83 = randomint(3);
	level.var_A9D0 = 100;
	anim.var_503A = ::func_0104;
	func_97F8();
	setdvarifuninitialized("scr_expDeathMayMoveCheck","on");
	scripts\sp\_names::func_F9E6();
	anim.var_1FB5 = 0;
	scripts\anim\init_move_transitions::func_98A0();
	anim.var_4407 = 10000;
	anim.var_4408 = 6000;
	func_9811();
	func_97C0();
	if(!isdefined(level.var_C6BC))
	{
		anim.var_C6BE = ::scripts\anim\notetracks::func_D480;
		anim.var_C6BC = ::scripts\anim\notetracks::func_D47F;
	}

	if(!isdefined(level.var_C6BD))
	{
		anim.var_C6BD = [];
	}

	if(!isdefined(level.var_C6BF))
	{
		anim.var_C6BF = [];
	}

	if(!isdefined(level.var_FE9B))
	{
		anim.var_FE9B = ::scripts\anim\utility::func_FE9D;
	}

	if(!isdefined(level.var_FED3))
	{
		anim.var_FED3 = ::scripts\anim\utility::func_FED2;
	}

	level.var_6D14["scripted"] = ::scripts\anim\notetracks::func_6D3C;
	level.var_6D14["cover_right"] = ::scripts\anim\notetracks::func_FEC8;
	level.var_6D14["cover_left"] = ::scripts\anim\notetracks::func_FEC8;
	level.var_6D14["cover_crouch"] = ::scripts\anim\notetracks::func_FEC8;
	level.var_6D14["cover_stand"] = ::scripts\anim\notetracks::func_FEC8;
	level.var_6D14["move"] = ::scripts\anim\notetracks::func_FEC8;
	scripts\anim\notetracks::func_DF00();
	if(!isdefined(level.flag))
	{
		scripts\common\flags::func_95E2();
	}

	scripts\sp\_gameskill::func_F848();
	level.var_C870 = undefined;
	scripts\anim\setposemovement::func_98BF();
	scripts\anim\face::func_9891();
	anim.var_32BF = scripts\anim\utility::func_2274(1,2,2,2,3,3,3,3,4,4,5);
	anim.var_6B93 = scripts\anim\utility::func_2274(2,3,3,3,4,4,4,5,5);
	anim.var_F217 = scripts\anim\utility::func_2274(1,2,2,3,3,4,4,4,4,5,5,5);
	anim.var_2759 = [];
	anim.var_2755 = 0;
	anim.player = getentarray("player","classname")[0];
	func_97DA();
	func_98E4();
	scripts\anim\cqb::func_FA9F();
	func_97F5();
	func_F724();
	anim.var_A955 = -100000;
	anim.var_BF91 = 10000;
	func_FAE3();
	level.player thread scripts\anim\combat_utility::func_13B22();
	thread func_1B08();
}

//Function Number: 21
func_97F8()
{
}

//Function Number: 22
func_97DA()
{
	if(!isdefined(level.player.team))
	{
		level.player.team = "allies";
	}

	scripts\anim\squadmanager::func_9763();
	level.player thread scripts\anim\squadmanager::func_1811();
	level.player thread scripts\anim\squadmanager::func_D362();
	scripts\anim\battlechatter::func_9542();
	level.player thread scripts\anim\battlechatter_ai::func_185D();
	lib_0E4E::func_96F1();
	anim thread scripts\anim\battlechatter::func_29C9();
}

//Function Number: 23
func_97F5()
{
	anim.var_C222 = randomintrange(0,15);
	anim.var_C221 = randomintrange(0,10);
	anim.var_BF77 = gettime() + randomintrange(0,20000);
	anim.var_BF78 = gettime() + randomintrange(0,10000);
	anim.var_BF76 = gettime() + randomintrange(0,15000);
}

//Function Number: 24
func_9811()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.var_85E4["fraggrenade"] = randomintrange(1000,20000);
		var_01.var_85E4["frag"] = randomintrange(1000,20000);
		var_01.var_85E4["frag_main"] = randomintrange(1000,20000);
		var_01.var_85E4["frag_vr"] = randomintrange(1000,20000);
		var_01.var_85E4["flash_grenade"] = randomintrange(1000,20000);
		var_01.var_85E4["emp"] = randomintrange(1000,20000);
		var_01.var_85E4["antigrav"] = randomintrange(1000,20000);
		var_01.var_85E4["seeker"] = randomintrange(1000,20000);
		var_01.var_85E4["c8_grenade"] = randomintrange(1000,10000);
		var_01.var_85E4["double_grenade"] = randomintrange(1000,-5536);
		var_01.var_C231 = 0;
		var_01.var_A990 = -1000000;
		var_01.var_A98C = -1000000;
		var_01 thread func_F7B3();
	}

	level.var_85E4["AI_fraggrenade"] = randomintrange(0,20000);
	level.var_85E4["AI_frag"] = randomintrange(0,20000);
	level.var_85E4["AI_seeker"] = randomintrange(0,20000);
	level.var_85E4["AI_frag_main"] = randomintrange(0,20000);
	level.var_85E4["AI_frag_vr"] = randomintrange(0,20000);
	level.var_85E4["AI_flash_grenade"] = randomintrange(0,20000);
	level.var_85E4["AI_smoke_grenade_american"] = randomintrange(0,20000);
	level.var_85E4["AI_emp"] = randomintrange(0,20000);
	level.var_85E4["AI_antigrav"] = randomintrange(0,20000);
	level.var_85E4["AI_c8_grenade"] = randomintrange(0,10000);
	scripts\anim\combat_utility::func_9812();
}

//Function Number: 25
func_97C0()
{
	level.var_A936 = [];
	level.var_A936["axis"] = 0;
	level.var_A936["allies"] = 0;
	level.var_A936["team3"] = 0;
	level.var_A936["neutral"] = 0;
	level.var_A934 = [];
	level.var_A934["axis"] = (0,0,0);
	level.var_A934["allies"] = (0,0,0);
	level.var_A934["team3"] = (0,0,0);
	level.var_A934["neutral"] = (0,0,0);
	level.var_A935 = [];
	level.var_A935["axis"] = (0,0,0);
	level.var_A935["allies"] = (0,0,0);
	level.var_A935["team3"] = (0,0,0);
	level.var_A935["neutral"] = (0,0,0);
	level.var_A933 = [];
	level.var_18D5 = [];
	level.var_18D5["axis"] = 0;
	level.var_18D5["allies"] = 0;
	level.var_18D5["team3"] = 0;
	level.var_18D5["neutral"] = 0;
	level.var_18D7 = 30000;
	level.var_18D6 = 3;
}

//Function Number: 26
func_9897()
{
	level.var_B5F8["c6"] = 0;
	level.var_B5F5["c6"] = 9000;
	level.var_B5F7["c6"] = 0;
	level.var_B5F6["c6"] = 15000;
	level.var_B5F8["seeker"] = 0;
	level.var_B5F5["seeker"] = 9000;
	level.var_B5F7["seeker"] = 0;
	level.var_B5F6["seeker"] = 15000;
}

//Function Number: 27
func_1B08()
{
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		var_02 = function_0072();
		if(var_02.size == 0)
		{
			wait(0.05);
			var_00 = 0;
			continue;
		}

		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(!isdefined(var_02[var_03]))
			{
				continue;
			}

			var_02[var_03] notify("do_slow_things");
			var_00++;
			if(var_00 == var_01)
			{
				wait(0.05);
				var_00 = 0;
			}
		}
	}
}

//Function Number: 28
func_F7B3()
{
	waittillframeend;
	if(isdefined(self.var_86A9.var_D397))
	{
		var_00 = int(self.var_86A9.var_D397 * 0.7);
		if(var_00 < 1)
		{
			var_00 = 1;
		}

		self.var_85E4["frag"] = randomintrange(0,var_00);
		self.var_85E4["flash_grenade"] = randomintrange(0,var_00);
		self.var_85E4["seeker"] = randomintrange(0,var_00);
	}

	if(isdefined(self.var_86A9.var_D382))
	{
		var_00 = int(self.var_86A9.var_D382);
		var_01 = int(var_00 / 2);
		if(var_00 <= var_01)
		{
			var_00 = var_01 + 1;
		}

		self.var_85E4["double_grenade"] = randomintrange(var_01,var_00);
	}
}

//Function Number: 29
func_2A69()
{
	if(isdefined(level.var_55F1))
	{
		return;
	}

	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00) && scripts\common\utility::istrue(var_00.var_8589))
		{
			continue;
		}

		if(isdefined(level.var_74C2["ai_grenade_thrown"]))
		{
			level thread [[ level.var_74C2["ai_grenade_thrown"] ]](var_00);
		}

		switch(var_01)
		{
			case "frag":
				thread scripts\sp\_detonategrenades::func_734F(var_00);
				break;
	
			case "emp":
				thread lib_0E25::func_615B(var_00);
				break;
	
			case "seeker":
				thread lib_0E26::func_F135(var_00);
				break;
	
			case "antigrav":
				thread lib_0E21::func_2013(var_00);
				break;
	
			default:
				var_00 thread scripts\sp\_utility::func_858A();
				break;
		}
	}
}

//Function Number: 30
func_FAE3()
{
	anim.var_DCB3 = 60;
	anim.var_DCB2 = [];
	for(var_00 = 0;var_00 < level.var_DCB3;var_00++)
	{
		level.var_DCB2[var_00] = var_00;
	}

	for(var_00 = 0;var_00 < level.var_DCB3;var_00++)
	{
		var_01 = randomint(level.var_DCB3);
		var_02 = level.var_DCB2[var_00];
		level.var_DCB2[var_00] = level.var_DCB2[var_01];
		level.var_DCB2[var_01] = var_02;
	}
}

//Function Number: 31
func_C4EA()
{
	if(isdefined(level.var_5613))
	{
		return;
	}

	self waittill("death");
	if(!isdefined(self))
	{
		if(isdefined(self.var_1491.var_13121))
		{
			self.var_1491.var_13121 delete();
		}
	}
}

//Function Number: 32
func_6DEA()
{
	if(isdefined(level.var_C122))
	{
		return;
	}

	anim.var_C122 = 1;
	anim.var_13086 = 0;
	lib_0B5F::func_965A();
	level.var_BF83 = randomint(3);
	level.var_A9D0 = 100;
	anim.var_503A = ::func_0104;
	if(!isdefined(level.var_7649))
	{
		level.var_7649 = [];
	}

	func_97F8();
	scripts\sp\_names::func_F9E6();
	anim.var_1FB5 = 0;
	anim.var_4407 = 10000;
	anim.var_4408 = 6000;
	anim.var_13CC8 = [];
	level.var_13CC8["c12"] = ::func_363B;
	anim.var_5667 = [];
	anim.var_13CD3 = ::scripts\anim\shared::func_CB29;
	func_9811();
	func_97C0();
	func_9897();
	if(!isdefined(level.var_C6BC))
	{
		anim.var_C6BE = ::scripts\anim\notetracks::func_D480;
		anim.var_C6BC = ::scripts\anim\notetracks::func_D47F;
	}

	if(!isdefined(level.var_C6BD))
	{
		anim.var_C6BD = [];
	}

	if(!isdefined(level.var_C6BF))
	{
		anim.var_C6BF = [];
	}

	if(!isdefined(level.var_FE9B))
	{
		anim.var_FE9B = ::scripts\anim\utility::func_FE9D;
	}

	if(!isdefined(level.var_FED3))
	{
		anim.var_FED3 = ::scripts\anim\utility::func_FED2;
	}

	anim.var_6D14 = [];
	scripts\anim\notetracks::func_DF00();
	if(!isdefined(level.flag))
	{
		scripts\common\flags::func_95E2();
	}

	scripts\sp\_gameskill::func_F848();
	level.var_C870 = undefined;
	scripts\anim\setposemovement::func_98BF();
	scripts\anim\face::func_9891();
	anim.var_32BF = scripts\anim\utility::func_2274(1,2,2,2,3,3,3,3,4,4,5);
	anim.var_6B93 = scripts\anim\utility::func_2274(2,3,3,3,4,4,4,5,5);
	anim.var_F217 = scripts\anim\utility::func_2274(1,2,2,3,3,4,4,4,4,5,5,5);
	anim.var_2759 = [];
	anim.var_2755 = 0;
	if(!isdefined(level.var_3D4B))
	{
		if(scripts\common\utility::func_D11B())
		{
			anim.player = level.var_D127;
		}
		else
		{
			anim.player = getentarray("player","classname")[0];
		}

		func_97DA();
	}

	func_98E4();
	scripts\anim\cqb::func_FA9F();
	func_97F5();
	anim.var_A955 = -100000;
	func_FAE3();
	level.player thread scripts\anim\combat_utility::func_13B22();
}

//Function Number: 33
func_5031()
{
	func_98E1(self.var_D8E1);
	func_98E1(self.var_F0C4);
	func_98E1(self.var_101B4);
	self method_82D0();
	self.var_1491.var_13CBA["left"] = "none";
	self.var_1491.var_13CBA["right"] = "none";
	self.var_1491.var_13CBA["chest"] = "none";
	self.var_1491.var_13CBA["back"] = "none";
	self.var_1491.var_13CBB["left"] = "none";
	self.var_1491.var_13CBB["right"] = "none";
	self.var_1491.var_13CBB["chest"] = "none";
	self.var_1491.var_13CBB["back"] = "none";
	self.var_AA45 = self.var_394;
	var_00 = scripts\anim\utility_common::func_1311B();
	self.var_1491.var_BEF9 = var_00;
	if(var_00)
	{
		thread scripts\anim\shared::func_E775();
	}

	self.var_1491.var_E5DE = 3;
	self.var_1491.var_E5E3 = 1;
	scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
	if(scripts\anim\utility_common::func_9F4F(self.var_F0C4))
	{
		scripts\anim\shared::func_CC2C(self.var_F0C4,"back");
	}

	if(self.team != "allies")
	{
		self.var_8B95 = 1;
	}

	scripts\anim\weaponlist::func_DE4D();
}

//Function Number: 34
func_3597()
{
	if(scripts\anim\utility_common::func_1311B())
	{
		return "rocket";
	}
	else if(scripts\anim\utility_common::func_1311A())
	{
		return "minigun";
	}

	return undefined;
}

//Function Number: 35
func_363B()
{
	self.var_13CC3 = [];
	if(self.var_D8E1 != "" && self.var_D8E1 != "none")
	{
		self.var_394 = self.var_D8E1;
		self.var_13CC3["right"] = func_3597();
	}

	if(self.var_F0C4 != "" && self.var_F0C4 != "none")
	{
		self.var_394 = self.var_F0C4;
		self.var_13CC3["left"] = func_3597();
	}

	self.var_394 = "";
	self.var_3250 = 1;
}
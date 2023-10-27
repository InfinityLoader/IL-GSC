/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_colors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 3203 ms
 * Timestamp: 10/27/2023 12:23:57 AM
*******************************************************************/

//Function Number: 1
func_957F()
{
	if(!scripts\common\utility::func_16F3("colors",::func_957F))
	{
		return;
	}

	scripts\common\utility::flag_init("respawn_friendlies");
}

//Function Number: 2
func_957E()
{
	var_00 = function_0076();
	scripts\common\utility::flag_init("player_looks_away_from_spawner");
	scripts\common\utility::flag_init("friendly_spawner_locked");
	level.var_22DD = [];
	level.var_22DD["axis"] = [];
	level.var_22DD["allies"] = [];
	level.var_22DF = [];
	level.var_22DF["axis"] = [];
	level.var_22DF["allies"] = [];
	var_01 = [];
	var_01 = scripts\common\utility::array_combine(var_01,getentarray("trigger_multiple","code_classname"));
	var_01 = scripts\common\utility::array_combine(var_01,getentarray("trigger_radius","code_classname"));
	var_01 = scripts\common\utility::array_combine(var_01,getentarray("trigger_once","code_classname"));
	level.var_43A0 = [];
	level.var_43A0["allies"] = "allies";
	level.var_43A0["axis"] = "axis";
	level.var_43A0["team3"] = "axis";
	level.var_43A0["neutral"] = "neutral";
	var_02 = getentarray("info_volume","code_classname");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04.var_ED33))
		{
			var_04 func_171E(var_04.var_ED33,"allies");
		}

		if(isdefined(var_04.var_ED34))
		{
			var_04 func_171E(var_04.var_ED34,"axis");
		}
	}

	foreach(var_07 in var_02)
	{
		if(isdefined(var_07.var_ED33))
		{
			var_07 func_178C(var_07.var_ED33,"allies");
		}

		if(isdefined(var_07.var_ED34))
		{
			var_07 func_178C(var_07.var_ED34,"axis");
		}
	}

	foreach(var_0A in var_01)
	{
		if(isdefined(var_0A.var_ED33))
		{
			var_0A thread func_12757(var_0A.var_ED33,"allies");
		}

		if(isdefined(var_0A.var_ED34))
		{
			var_0A thread func_12757(var_0A.var_ED34,"axis");
		}
	}

	level.var_439B = [];
	func_16B5("BAD NODE");
	func_16B5("Cover Stand");
	func_16B5("Cover Crouch");
	func_16B5("Cover Prone");
	func_16B5("Cover Crouch Window");
	func_16B5("Cover Right");
	func_16B5("Cover Left");
	func_16B5("Cover Wide Left");
	func_16B5("Cover Wide Right");
	func_16B5("Conceal Stand");
	func_16B5("Conceal Crouch");
	func_16B5("Conceal Prone");
	func_16B5("Reacquire");
	func_16B5("Balcony");
	func_16B5("Scripted");
	func_16B5("Begin");
	func_16B5("End");
	func_16B5("Turret");
	func_1729("Ambush");
	func_1729("Guard");
	func_1729("Path");
	func_1729("Path 3D");
	func_1729("Exposed");
	func_1729("Exposed 3D");
	func_1729("Cover 3D");
	func_1729("Cover Stand 3D");
	func_16B5("Begin 3D");
	func_16B5("End 3D");
	level.var_43A8 = [];
	level.var_43A8[level.var_43A8.size] = "r";
	level.var_43A8[level.var_43A8.size] = "b";
	level.var_43A8[level.var_43A8.size] = "y";
	level.var_43A8[level.var_43A8.size] = "c";
	level.var_43A8[level.var_43A8.size] = "g";
	level.var_43A8[level.var_43A8.size] = "p";
	level.var_43A8[level.var_43A8.size] = "o";
	level.var_43A3["red"] = "r";
	level.var_43A3["r"] = "r";
	level.var_43A3["blue"] = "b";
	level.var_43A3["b"] = "b";
	level.var_43A3["yellow"] = "y";
	level.var_43A3["y"] = "y";
	level.var_43A3["cyan"] = "c";
	level.var_43A3["c"] = "c";
	level.var_43A3["green"] = "g";
	level.var_43A3["g"] = "g";
	level.var_43A3["purple"] = "p";
	level.var_43A3["p"] = "p";
	level.var_43A3["orange"] = "o";
	level.var_43A3["o"] = "o";
	level.var_4BE0 = [];
	level.var_4BE0["allies"] = [];
	level.var_4BE0["axis"] = [];
	level.var_A95D = [];
	level.var_A95D["allies"] = [];
	level.var_A95D["axis"] = [];
	foreach(var_0D in level.var_43A8)
	{
		level.var_22E0["allies"][var_0D] = [];
		level.var_22E0["axis"][var_0D] = [];
		level.var_4BE0["allies"][var_0D] = undefined;
		level.var_4BE0["axis"][var_0D] = undefined;
	}

	thread func_CFD2();
	var_0F = function_00C9("allies");
	level.var_11AE = [];
	foreach(var_11 in var_0F)
	{
		level.var_11AE[var_11.classname] = var_11;
	}
}

//Function Number: 3
func_45ED()
{
	self.var_EDAD = level.var_43A3[self.var_EDAD];
}

//Function Number: 4
func_19CE(param_00)
{
	if(isdefined(self.var_EDAD))
	{
		func_45ED();
		self.var_4BDF = param_00;
		var_01 = self.var_EDAD;
		level.var_22E0[func_7CE4()][var_01] = scripts\common\utility::array_add(level.var_22E0[func_7CE4()][var_01],self);
		thread func_8467();
	}
}

//Function Number: 5
func_8467()
{
	if(!isdefined(self.var_4BDF))
	{
		return;
	}

	var_00 = level.var_22DD[func_7CE4()][self.var_4BDF];
	func_AB3A();
	if(!isalive(self))
	{
		return;
	}

	if(!scripts\sp\_utility::func_8B6C())
	{
		return;
	}

	if(!isdefined(var_00))
	{
		var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
		func_F21B(var_01,self.var_4BDF);
		return;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(isalive(var_03.var_43A2) && !isplayer(var_03.var_43A2))
		{
			continue;
		}

		thread func_19E1(var_03);
		thread func_4FBF(var_03);
		return;
	}

	func_C002();
}

//Function Number: 6
func_C002()
{
}

//Function Number: 7
func_78D2()
{
	var_00 = [];
	var_00[var_00.size] = "r";
	var_00[var_00.size] = "b";
	var_00[var_00.size] = "y";
	var_00[var_00.size] = "c";
	var_00[var_00.size] = "g";
	var_00[var_00.size] = "p";
	var_00[var_00.size] = "o";
	return var_00;
}

//Function Number: 8
func_22AE(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03] = 1;
	}

	var_05 = [];
	foreach(var_08, var_07 in var_01)
	{
		var_05[var_05.size] = var_08;
	}

	return var_05;
}

//Function Number: 9
func_78D9(param_00,param_01)
{
	return func_78D7(param_00,param_01);
}

//Function Number: 10
func_78D7(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = func_22AE(var_02);
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = func_78D2();
	foreach(var_08 in var_02)
	{
		var_09 = undefined;
		foreach(var_09 in var_06)
		{
			if(issubstr(var_08,var_09))
			{
				break;
			}
		}

		if(!func_43A4(param_01,var_08))
		{
			continue;
		}

		var_04[var_09] = var_08;
		var_03[var_03.size] = var_09;
		var_05[var_05.size] = var_08;
	}

	var_02 = var_05;
	var_0D = [];
	var_0D["colorCodes"] = var_02;
	var_0D["colorCodesByColorIndex"] = var_04;
	var_0D["colors"] = var_03;
	return var_0D;
}

//Function Number: 11
func_43A4(param_00,param_01)
{
	if(isdefined(level.var_22DD[param_00][param_01]))
	{
		return 1;
	}

	return isdefined(level.var_22DF[param_00][param_01]);
}

//Function Number: 12
func_12757(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		if(isdefined(self.var_1605))
		{
			self.var_1605 = undefined;
			continue;
		}

		func_78D8(param_00,param_01);
		if(isdefined(self.var_EE6C) && self.var_EE6C)
		{
			thread func_12732();
		}
	}
}

//Function Number: 13
func_12732()
{
	var_00 = [];
	var_01[0] = self;
	while(var_01.size)
	{
		var_02 = [];
		foreach(var_04 in var_01)
		{
			var_00[var_00.size] = var_04;
			if(!isdefined(var_04.var_336))
			{
				continue;
			}

			var_05 = getentarray(var_04.var_336,"target");
			foreach(var_07 in var_05)
			{
				var_02[var_02.size] = var_07;
			}

			var_05 = undefined;
		}

		var_01 = [];
		foreach(var_0B in var_02)
		{
			if(!isdefined(var_0B.var_ED33) && !isdefined(var_0B.var_ED34))
			{
				continue;
			}

			var_01[var_01.size] = var_0B;
		}
	}

	scripts\sp\_utility::func_228A(var_00);
}

//Function Number: 14
func_159B(param_00)
{
	if(param_00 == "allies")
	{
		thread func_78D8(self.var_ED33,param_00);
		return;
	}

	thread func_78D8(self.var_ED34,param_00);
}

//Function Number: 15
func_78D8(param_00,param_01)
{
	var_02 = func_78D9(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	func_159A(var_03,var_05,param_01,var_04);
}

//Function Number: 16
func_159A(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!isdefined(level.var_22DE[param_02][param_00[var_04]]))
		{
			continue;
		}

		level.var_22DE[param_02][param_00[var_04]] = scripts\common\utility::func_22BC(level.var_22DE[param_02][param_00[var_04]]);
		for(var_05 = 0;var_05 < level.var_22DE[param_02][param_00[var_04]].size;var_05++)
		{
			level.var_22DE[param_02][param_00[var_04]][var_05].var_4BDF = param_00[var_04];
		}
	}

	foreach(var_07 in param_01)
	{
		level.var_22E0[param_02][var_07] = scripts\sp\_utility::func_22B9(level.var_22E0[param_02][var_07]);
		level.var_A95D[param_02][var_07] = level.var_4BE0[param_02][var_07];
		level.var_4BE0[param_02][var_07] = param_03[var_07];
	}

	var_0B = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(func_EB12(param_02,param_01[var_04]))
		{
			continue;
		}

		var_0C = param_00[var_04];
		if(!isdefined(level.var_22DC[param_02][var_0C]))
		{
			continue;
		}

		var_0B[var_0C] = func_9F85(var_0C,param_01[var_04],param_02);
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_0C = param_00[var_04];
		if(!isdefined(var_0B[var_0C]))
		{
			continue;
		}

		if(func_EB12(param_02,param_01[var_04]))
		{
			continue;
		}

		if(!isdefined(level.var_22DC[param_02][var_0C]))
		{
			continue;
		}

		func_9F83(var_0C,param_01[var_04],param_02,var_0B[var_0C]);
	}
}

//Function Number: 17
func_EB12(param_00,param_01)
{
	if(!isdefined(level.var_A95D[param_00][param_01]))
	{
		return 0;
	}

	return level.var_A95D[param_00][param_01] == level.var_4BE0[param_00][param_01];
}

//Function Number: 18
func_D968(param_00,param_01)
{
	if(issubstr(param_00.var_ED33,param_01))
	{
		self.var_4709[self.var_4709.size] = param_00;
		return;
	}

	self.var_4708[self.var_4708.size] = param_00;
}

//Function Number: 19
func_D969(param_00,param_01)
{
	if(issubstr(param_00.var_ED34,param_01))
	{
		self.var_4709[self.var_4709.size] = param_00;
		return;
	}

	self.var_4708[self.var_4708.size] = param_00;
}

//Function Number: 20
func_D967(param_00,param_01)
{
	self.var_4708[self.var_4708.size] = param_00;
}

//Function Number: 21
func_D982(param_00,param_01)
{
	self.var_C961[self.var_C961.size] = param_00;
}

//Function Number: 22
func_D923(param_00,param_01,param_02)
{
	var_03 = level.var_22DD[param_00][param_01];
	var_04 = spawnstruct();
	var_04.var_C961 = [];
	var_04.var_4708 = [];
	var_04.var_4709 = [];
	var_05 = isdefined(level.var_A95D[param_00][param_02]);
	for(var_06 = 0;var_06 < var_03.size;var_06++)
	{
		var_07 = var_03[var_06];
		var_04 [[ level.var_439B[var_07.type][var_05][param_00] ]](var_07,level.var_A95D[param_00][param_02]);
	}

	var_04.var_4708 = scripts\common\utility::array_randomize(var_04.var_4708);
	var_08 = [];
	var_03 = [];
	foreach(var_0A, var_07 in var_04.var_4708)
	{
		if(isdefined(var_07.var_ED38))
		{
			var_08[var_08.size] = var_07;
			var_03[var_0A] = undefined;
			continue;
		}

		var_03[var_03.size] = var_07;
	}

	for(var_06 = 0;var_06 < var_04.var_4709.size;var_06++)
	{
		var_03[var_03.size] = var_04.var_4709[var_06];
	}

	for(var_06 = 0;var_06 < var_04.var_C961.size;var_06++)
	{
		var_03[var_03.size] = var_04.var_C961[var_06];
	}

	foreach(var_07 in var_08)
	{
		var_03[var_03.size] = var_07;
	}

	level.var_22DD[param_00][param_01] = var_03;
}

//Function Number: 23
func_7BDA(param_00,param_01,param_02)
{
	return level.var_22DD[param_00][param_01];
}

//Function Number: 24
func_78D6(param_00,param_01)
{
	return level.var_22DF[param_00][param_01];
}

//Function Number: 25
func_9F85(param_00,param_01,param_02)
{
	level.var_22DC[param_02][param_00] = scripts\sp\_utility::func_22B9(level.var_22DC[param_02][param_00]);
	var_03 = level.var_22DC[param_02][param_00];
	var_03 = scripts\common\utility::array_combine(var_03,level.var_22E0[param_02][param_01]);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		if(isdefined(var_06.var_4BDF) && var_06.var_4BDF == param_00)
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	var_03 = var_04;
	if(!var_03.size)
	{
		return;
	}

	scripts\common\utility::array_thread(var_03,::func_AB3A);
	return var_03;
}

//Function Number: 26
func_F21B(param_00,param_01)
{
	self notify("stop_color_move");
	self.var_4BDF = param_01;
	if(isdefined(param_00.target))
	{
		var_02 = function_00B3(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			self method_82EE(var_02);
		}
	}

	self.var_132 = 0;
	self method_82F1(param_00);
}

//Function Number: 27
func_9F83(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_05 = [];
	if(isdefined(level.var_22DD[param_02][param_00]))
	{
		func_D923(param_02,param_00,param_01);
		var_05 = func_7BDA(param_02,param_00,param_01);
	}
	else
	{
		var_06 = func_78D6(param_02,param_00);
		scripts\common\utility::array_thread(param_03,::func_F21B,var_06,param_00);
	}

	var_07 = 0;
	var_08 = param_03.size;
	for(var_09 = 0;var_09 < var_05.size;var_09++)
	{
		var_0A = var_05[var_09];
		if(isalive(var_0A.var_43A2))
		{
			continue;
		}

		var_0B = scripts\common\utility::getclosest(var_0A.origin,param_03);
		param_03 = scripts\common\utility::func_22A9(param_03,var_0B);
		var_0B func_1142E(var_0A,param_00,self,var_07);
		var_07++;
		if(!param_03.size)
		{
			return;
		}
	}
}

//Function Number: 28
func_1142E(param_00,param_01,param_02,param_03)
{
	self notify("stop_color_move");
	self.var_4BDF = param_01;
	thread func_D966(param_00,param_02,param_03);
}

//Function Number: 29
func_CFD2()
{
	for(;;)
	{
		var_00 = undefined;
		if(!isdefined(level.player.var_205))
		{
			wait(0.05);
			continue;
		}

		var_01 = level.player.var_205.var_43A2;
		var_00 = level.player.var_205;
		var_00.var_43A2 = level.player;
		for(;;)
		{
			if(!isdefined(level.player.var_205))
			{
				break;
			}

			if(level.player.var_205 != var_00)
			{
				break;
			}

			wait(0.05);
		}

		var_00.var_43A2 = undefined;
		var_00 func_4398();
	}
}

//Function Number: 30
func_4398()
{
	if(isdefined(self.var_ED33))
	{
		func_439A(self.var_ED33,"allies");
	}

	if(isdefined(self.var_ED34))
	{
		func_439A(self.var_ED34,"axis");
	}
}

//Function Number: 31
func_439A(param_00,param_01)
{
	if(isdefined(self.var_43A2))
	{
		return;
	}

	var_02 = strtok(param_00," ");
	var_02 = func_22AE(var_02);
	scripts\common\utility::func_22A1(var_02,::func_4399,param_01);
}

//Function Number: 32
func_4399(param_00,param_01)
{
	var_02 = param_00[0];
	if(!isdefined(level.var_4BE0[param_01][var_02]))
	{
		return;
	}

	if(level.var_4BE0[param_01][var_02] != param_00)
	{
		return;
	}

	var_03 = scripts\sp\_utility::func_79C8(param_01,var_02);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(var_05 func_C2D2(param_00))
		{
			continue;
		}

		var_05 func_1142E(self,param_00);
		return;
	}
}

//Function Number: 33
func_C2D2(param_00)
{
	if(!isdefined(self.var_4BDF))
	{
		return 0;
	}

	return self.var_4BDF == param_00;
}

//Function Number: 34
func_19E1(param_00)
{
	self endon("death");
	self endon("stop_color_move");
	func_BE08();
	thread func_19E0(param_00);
}

//Function Number: 35
func_19E0(param_00)
{
	self notify("stop_going_to_node");
	func_F3D2(param_00);
	var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
	if(isdefined(self.var_ED27))
	{
		thread func_3A57(param_00,var_01);
	}
}

//Function Number: 36
func_F3D2(param_00)
{
	if(isdefined(self.var_43A9))
	{
		self thread [[ self.var_43A9 ]](param_00);
	}

	if(isdefined(self.var_11B0))
	{
		thread lib_0B06::func_1F32(self,self.var_11B0);
		self.var_11B0 = undefined;
	}

	if(isdefined(self.var_43AB))
	{
		self thread [[ self.var_43AB ]](param_00);
	}
	else
	{
		self method_82EE(param_00);
	}

	if(func_9CFA(param_00))
	{
		thread func_72C8(param_00);
	}
	else if(isdefined(param_00.var_257) && param_00.var_257 > 0)
	{
		self.var_15C = param_00.var_257;
	}

	var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
	if(isdefined(var_01))
	{
		self method_82E0(var_01);
	}
	else
	{
		self method_8073();
	}

	if(isdefined(param_00.var_133))
	{
		self.var_133 = param_00.var_133;
		return;
	}

	if(isdefined(level.var_6E02))
	{
		self.var_133 = level.var_6E02;
		return;
	}

	self.var_133 = 64;
}

//Function Number: 37
func_9CFA(param_00)
{
	if(!isdefined(self.var_EDB0))
	{
		return 0;
	}

	if(!self.var_EDB0)
	{
		return 0;
	}

	if(!isdefined(param_00.var_133))
	{
		return 0;
	}

	if(self.var_132)
	{
		return 0;
	}

	return 1;
}

//Function Number: 38
func_72C8(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self.var_15C = param_00.var_133;
	scripts\common\utility::waittill_either("goal","damage");
	if(isdefined(param_00.var_257) && param_00.var_257 > 0)
	{
		self.var_15C = param_00.var_257;
	}
}

//Function Number: 39
func_3A57(param_00,param_01)
{
	self endon("death");
	self endon("stop_being_careful");
	self endon("stop_going_to_node");
	thread func_DDF9(param_00);
	for(;;)
	{
		func_13689(param_00,param_01);
		func_12FAD(param_00,param_01);
		self.var_132 = 1;
		func_F3D2(param_00);
	}
}

//Function Number: 40
func_DDF9(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self waittill("stop_being_careful");
	self.var_132 = 1;
	func_F3D2(param_00);
}

//Function Number: 41
func_12FAD(param_00,param_01)
{
	self method_82EF(self.origin);
	self.var_15C = 1024;
	self.var_132 = 0;
	if(isdefined(param_01))
	{
		for(;;)
		{
			wait(1);
			if(self method_81A8(param_00.origin,self.var_133))
			{
				continue;
			}

			if(self method_81A9(param_01))
			{
				continue;
			}

			return;
		}

		return;
	}

	for(;;)
	{
		if(!func_9E6E(param_00.origin,self.var_133))
		{
			return;
		}

		wait(1);
	}
}

//Function Number: 42
func_9E6E(param_00,param_01)
{
	var_02 = function_0072("axis");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(distance2d(var_02[var_03].origin,param_00) < param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 43
func_13689(param_00,param_01)
{
	if(isdefined(param_01))
	{
		for(;;)
		{
			if(self method_81A8(param_00.origin,self.var_133))
			{
				return;
			}

			if(self method_81A9(param_01))
			{
				return;
			}

			wait(1);
		}

		return;
	}

	for(;;)
	{
		if(func_9E6E(param_00.origin,self.var_133))
		{
			return;
		}

		wait(1);
	}
}

//Function Number: 44
func_BE08()
{
	if(!isdefined(self.var_205))
	{
		return 0;
	}

	if(isdefined(self.var_ED35))
	{
		wait(self.var_ED35);
		return 1;
	}

	return self.var_205 scripts\sp\_utility::script_delay();
}

//Function Number: 45
func_D966(param_00,param_01,param_02)
{
	thread func_4FBF(param_00);
	self endon("stop_color_move");
	self endon("death");
	if(isdefined(param_01))
	{
		param_01 scripts\sp\_utility::script_delay();
	}

	if(!func_BE08())
	{
		if(isdefined(param_02))
		{
			wait(param_02 * randomfloatrange(0.2,0.35));
		}
	}

	func_19E0(param_00);
	self.var_439C = param_00;
	for(;;)
	{
		self waittill("node_taken",var_03);
		if(isplayer(var_03))
		{
			wait(0.05);
		}

		param_00 = func_7860();
		if(isdefined(param_00))
		{
			if(isalive(self.var_4397.var_43A2) && self.var_4397.var_43A2 == self)
			{
				self.var_4397.var_43A2 = undefined;
			}

			self.var_4397 = param_00;
			param_00.var_43A2 = self;
			func_19E0(param_00);
		}
	}
}

//Function Number: 46
func_785F()
{
	var_00 = level.var_4BE0[func_7CE4()][self.var_EDAD];
	var_01 = func_7BDA(func_7CE4(),var_00,self.var_EDAD);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02].var_43A2))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 47
func_7860()
{
	var_00 = level.var_4BE0[func_7CE4()][self.var_EDAD];
	var_01 = func_7BDA(func_7CE4(),var_00,self.var_EDAD);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == self.var_4397)
		{
			continue;
		}

		if(!isalive(var_01[var_02].var_43A2))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 48
func_D987(param_00)
{
	self endon("stopScript");
	self endon("death");
	if(isdefined(self.var_205))
	{
		return;
	}

	if(distance(param_00.origin,self.origin) < 32)
	{
		func_DD19(param_00);
		return;
	}

	var_01 = gettime();
	func_135E3(1);
	var_02 = gettime();
	if(var_02 - var_01 >= 1000)
	{
		func_DD19(param_00);
	}
}

//Function Number: 49
func_135E3(param_00)
{
	self endon("killanimscript");
	wait(param_00);
}

//Function Number: 50
func_DD19(param_00)
{
	var_01 = function_0072();
	var_02 = undefined;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!isdefined(var_01[var_03].var_205))
		{
			continue;
		}

		if(var_01[var_03].var_205 != param_00)
		{
			continue;
		}

		var_01[var_03] notify("eject_from_my_node");
		wait(1);
		self notify("eject_from_my_node");
		return 1;
	}

	return 0;
}

//Function Number: 51
func_4FBF(param_00)
{
	param_00.var_43A2 = self;
	self.var_4397 = param_00;
	self endon("stop_color_move");
	self waittill("death");
	self.var_4397.var_43A2 = undefined;
}

//Function Number: 52
func_43A7(param_00)
{
	for(var_01 = 0;var_01 < level.var_43A8.size;var_01++)
	{
		if(param_00 == level.var_43A8[var_01])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
func_178C(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = func_22AE(var_02);
	foreach(var_04 in var_02)
	{
		level.var_22DF[param_01][var_04] = self;
		level.var_22DC[param_01][var_04] = [];
		level.var_22DE[param_01][var_04] = [];
	}
}

//Function Number: 54
func_171E(param_00,param_01)
{
	self.var_43A2 = undefined;
	var_02 = strtok(param_00," ");
	var_02 = func_22AE(var_02);
	foreach(var_04 in var_02)
	{
		if(isdefined(level.var_22DD[param_01]) && isdefined(level.var_22DD[param_01][var_04]))
		{
			level.var_22DD[param_01][var_04] = scripts\common\utility::array_add(level.var_22DD[param_01][var_04],self);
			continue;
		}

		level.var_22DD[param_01][var_04][0] = self;
		level.var_22DC[param_01][var_04] = [];
		level.var_22DE[param_01][var_04] = [];
	}
}

//Function Number: 55
func_AB3A()
{
	if(!isdefined(self.var_4397))
	{
		return;
	}

	if(isdefined(self.var_4397.var_43A2) && self.var_4397.var_43A2 == self)
	{
		self.var_4397.var_43A2 = undefined;
	}

	self.var_4397 = undefined;
	self notify("stop_color_move");
}

//Function Number: 56
func_7E3A()
{
	var_00 = [];
	if(issubstr(self.classname,"axis") || issubstr(self.classname,"enemy") || issubstr(self.classname,"team3"))
	{
		var_00["team"] = "axis";
		var_00["colorTeam"] = self.var_ED34;
	}

	if(issubstr(self.classname,"ally") || self.type == "civilian")
	{
		var_00["team"] = "allies";
		var_00["colorTeam"] = self.var_ED33;
	}

	if(!isdefined(var_00["colorTeam"]))
	{
		var_00 = undefined;
	}

	return var_00;
}

//Function Number: 57
func_E16F()
{
	var_00 = func_7E3A();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = var_00["team"];
	var_02 = var_00["colorTeam"];
	var_03 = strtok(var_02," ");
	var_03 = func_22AE(var_03);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		level.var_22DE[var_01][var_03[var_04]] = scripts\common\utility::func_22A9(level.var_22DE[var_01][var_03[var_04]],self);
	}
}

//Function Number: 58
func_16B5(param_00)
{
	level.var_439B[param_00][1]["allies"] = ::func_D968;
	level.var_439B[param_00][1]["axis"] = ::func_D969;
	level.var_439B[param_00][0]["allies"] = ::func_D967;
	level.var_439B[param_00][0]["axis"] = ::func_D967;
}

//Function Number: 59
func_1729(param_00)
{
	level.var_439B[param_00][1]["allies"] = ::func_D982;
	level.var_439B[param_00][0]["allies"] = ::func_D982;
	level.var_439B[param_00][1]["axis"] = ::func_D982;
	level.var_439B[param_00][0]["axis"] = ::func_D982;
}

//Function Number: 60
func_43AC(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = func_10735(param_00,param_01);
	if(isdefined(level.var_73F1))
	{
		var_02 thread [[ level.var_73F1 ]]();
	}

	var_02 thread func_43AA();
}

//Function Number: 61
func_43AA()
{
	level endon("kill_color_replacements");
	self endon("_disable_reinforcement");
	if(isdefined(self.var_E198))
	{
		return;
	}

	self.var_E198 = 1;
	var_00 = self.classname;
	var_01 = self.var_EDAD;
	waittillframeend;
	if(isalive(self))
	{
		self waittill("death");
	}

	var_02 = level.var_4B58;
	if(!isdefined(self.var_EDAD))
	{
		return;
	}

	thread func_43AC(var_00,self.var_EDAD);
	if(isdefined(self) && isdefined(self.var_EDAD))
	{
		var_01 = self.var_EDAD;
	}

	if(isdefined(self) && isdefined(self.origin))
	{
		var_03 = self.origin;
	}

	for(;;)
	{
		if(func_78CE(var_01,var_02) == "none")
		{
			return;
		}

		var_04 = scripts\sp\_utility::func_79C8("allies",var_02[var_01]);
		if(!isdefined(level.var_4392))
		{
			var_04 = scripts\sp\_utility::func_E0AF(var_04,var_00);
		}

		if(!var_04.size)
		{
			wait(2);
			continue;
		}

		var_05 = scripts\common\utility::getclosest(level.player.origin,var_04);
		waittillframeend;
		if(!isalive(var_05))
		{
			continue;
		}

		var_05 scripts\sp\_utility::func_F3B5(var_01);
		if(isdefined(level.var_73DF))
		{
			var_05 [[ level.var_73DF ]](var_01);
		}

		var_01 = var_02[var_01];
	}
}

//Function Number: 62
func_78CE(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return "none";
	}

	if(!isdefined(param_01))
	{
		return "none";
	}

	if(!isdefined(param_01[param_00]))
	{
		return "none";
	}

	return param_01[param_00];
}

//Function Number: 63
func_73E7()
{
	level.var_73E1 = 1;
	var_00 = 0;
	for(;;)
	{
		for(;;)
		{
			if(!func_E289())
			{
				break;
			}

			wait(0.05);
		}

		wait(1);
		if(!isdefined(level.var_E290))
		{
			continue;
		}

		var_01 = level.player.origin - level.var_E290;
		if(length(var_01) < 200)
		{
			func_D286();
			continue;
		}

		var_02 = anglestoforward((0,level.player getplayerangles()[1],0));
		var_03 = vectornormalize(var_01);
		var_04 = vectordot(var_02,var_03);
		if(var_04 < 0.2)
		{
			func_D286();
			continue;
		}

		var_00++;
		if(var_00 < 3)
		{
			continue;
		}

		scripts\common\utility::flag_set("player_looks_away_from_spawner");
	}
}

//Function Number: 64
func_78D4(param_00)
{
	if(isdefined(param_00))
	{
		if(!isdefined(level.var_11AE[param_00]))
		{
			var_01 = function_00C9("allies");
			foreach(var_03 in var_01)
			{
				if(var_03.classname != param_00)
				{
					continue;
				}

				level.var_11AE[param_00] = var_03;
				break;
			}
		}
	}

	if(!isdefined(param_00))
	{
		var_03 = scripts\common\utility::random(level.var_11AE);
		if(!isdefined(var_03))
		{
			var_01 = [];
			foreach(var_06, var_03 in level.var_11AE)
			{
				if(isdefined(var_03))
				{
					var_01[var_06] = var_03;
				}
			}

			level.var_11AE = var_01;
			return scripts\common\utility::random(level.var_11AE);
		}

		return var_06;
	}

	return level.var_11AE[var_06];
}

//Function Number: 65
func_E289()
{
	if(isdefined(level.var_E288))
	{
		return 0;
	}

	return scripts\common\utility::flag("respawn_friendlies");
}

//Function Number: 66
func_13692()
{
	if(scripts\common\utility::flag("player_looks_away_from_spawner"))
	{
		return;
	}

	level endon("player_looks_away_from_spawner");
	for(;;)
	{
		if(func_E289())
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 67
func_10735(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = undefined;
	for(;;)
	{
		if(!func_E289())
		{
			if(!isdefined(level.var_73E1))
			{
				thread func_73E7();
			}

			for(;;)
			{
				func_13692();
				scripts\common\utility::func_6E5A("friendly_spawner_locked");
				if(scripts\common\utility::flag("player_looks_away_from_spawner") || func_E289())
				{
					break;
				}
			}

			scripts\common\utility::flag_set("friendly_spawner_locked");
		}

		var_03 = func_78D4(param_00);
		var_03.var_C1 = 1;
		var_04 = var_03.origin;
		var_03.origin = level.var_E290;
		var_02 = var_03 method_8393();
		var_03.origin = var_04;
		if(scripts\sp\_utility::func_106ED(var_02))
		{
			thread func_AEE0();
			wait(1);
			continue;
		}

		level notify("reinforcement_spawned",var_02);
		break;
	}

	for(;;)
	{
		if(!isdefined(param_01))
		{
			break;
		}

		if(func_78CE(param_01,level.var_4B58) == "none")
		{
			break;
		}

		param_01 = level.var_4B58[param_01];
	}

	if(isdefined(param_01))
	{
		var_02 scripts\sp\_utility::func_F3B5(param_01);
	}

	thread func_AEE0();
	return var_02;
}

//Function Number: 68
func_AEE0()
{
	scripts\common\utility::flag_set("friendly_spawner_locked");
	if(isdefined(level.var_73E0))
	{
		[[ level.var_73E0 ]]();
	}
	else
	{
		wait(2);
	}

	scripts\common\utility::func_6E2A("friendly_spawner_locked");
}

//Function Number: 69
func_D286()
{
	var_00 = 0;
	scripts\common\utility::func_6E2A("player_looks_away_from_spawner");
}

//Function Number: 70
func_A5C7()
{
	scripts\common\utility::func_6E2A("friendly_spawner_locked");
	level notify("kill_color_replacements");
	var_00 = function_0072();
	scripts\common\utility::array_thread(var_00,::func_E07E);
}

//Function Number: 71
func_E07E()
{
	self.var_E198 = undefined;
}

//Function Number: 72
func_7CE4(param_00)
{
	if(isdefined(self.team) && !isdefined(param_00))
	{
		param_00 = self.team;
	}

	return level.var_43A0[param_00];
}
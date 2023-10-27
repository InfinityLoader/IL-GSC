/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\battlechatter_ai.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 60
 * Decompile Time: 3405 ms
 * Timestamp: 10/27/2023 12:00:07 AM
*******************************************************************/

//Function Number: 1
func_185D(param_00)
{
	self endon("death");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	if(self.var_3D4B)
	{
		return;
	}

	if(!isdefined(self.var_10AC8.var_3D4B) || !self.var_10AC8.var_3D4B)
	{
		self.var_10AC8 scripts\anim\battlechatter::func_9762();
	}

	self.var_6552 = "infantry";
	self.var_376A = [];
	if(isplayer(self) || scripts\common\utility::func_D11B() && self == level.var_D127)
	{
		self.var_28CF = 0;
		self.var_6EE9 = 0;
		self.type = "human";
		return;
	}

	if(isdefined(self.var_29B8) && self.var_29B8)
	{
		self.var_28CF = 0;
		self.var_6EE9 = 0;
	}
	else
	{
		if(self.var_12BA4 == "c12")
		{
			self.var_28CF = 0;
			self.var_6552 = "c12";
			return;
		}

		if(self.var_12BA4 == "c8" || isdefined(self.var_238F) && self.var_238F == "seeker")
		{
			self.var_28CF = 0;
			self.var_6EE9 = 0;
			return;
		}

		if(self.team == "neutral")
		{
			self.var_6552 = undefined;
			self.var_28CF = 0;
			self.var_6EE9 = 0;
			return;
		}

		if(self.var_12BA4 == "c6")
		{
			self method_8000("grenade danger");
			thread func_29B6();
		}

		self.var_8C7E = lib_0A1E::func_2356("Knobs","head");
		self.var_EF82 = lib_0A1E::func_2356("Knobs","scripted_talking");
		self.var_504D = lib_0A1E::func_2356("Knobs","default_talking");
	}

	if(!isdefined(self.var_13525))
	{
		return;
	}

	self.var_46BC = level.var_46BD[self.var_13525];
	if(!isdefined(self.var_46BC))
	{
		return;
	}

	func_23CF();
	thread func_1A54();
	func_94E5();
	thread func_1B06();
}

//Function Number: 2
func_23CF()
{
	if(isdefined(self.var_EDB8))
	{
		var_00 = tolower(self.var_EDB8);
		if(issubstr(var_00,"eth.3n"))
		{
			self.var_C19D = "eth";
			return;
		}

		if(issubstr(var_00,"ethan"))
		{
			self.var_C19D = "eth";
			return;
		}

		if(issubstr(var_00,"salter"))
		{
			self.var_C19D = "slt";
			return;
		}

		if(issubstr(var_00,"brooks"))
		{
			self.var_C19D = "brk";
			return;
		}

		if(issubstr(var_00,"kashima"))
		{
			self.var_C19D = "ksh";
			return;
		}

		if(issubstr(var_00,"omar"))
		{
			self.var_C19D = "omr";
			return;
		}

		if(issubstr(var_00,"mco"))
		{
			self.var_C19D = "omr";
			return;
		}

		if(issubstr(var_00,"macallum"))
		{
			self.var_C19D = "mac";
			return;
		}

		if(issubstr(var_00,"raines"))
		{
			self.var_C19D = "adm";
			return;
		}

		func_F7BB();
		return;
	}

	if(isdefined(self.var_29B8) && self.var_29B8)
	{
		while(!isdefined(level.var_13075) || !isdefined(level.var_13075[self.var_13525]))
		{
			wait(0.05);
		}
	}

	func_F7BB();
}

//Function Number: 3
func_72C2()
{
	if(!getdvarint("bcs_forceEnglish",0))
	{
		return 0;
	}

	switch(level.script)
	{
		case "pmc_strike":
			return 1;
	}

	return 0;
}

//Function Number: 4
func_1B06()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.team))
	{
		return;
	}

	var_00 = 0.5;
	wait(var_00);
	if(!scripts\common\utility::func_D11B())
	{
		thread func_1A10();
	}

	thread func_1A0F();
	if(self.team == "allies")
	{
		wait(var_00);
		thread func_1A0E();
	}
	else if((self.team == "axis" || self.team == "team3") && !func_9D3A(self.var_46BC))
	{
		thread func_1A19();
		var_00 = 5;
	}

	if(isdefined(level.player) && self.team == level.player.team)
	{
		thread func_D085();
	}

	wait(var_00);
	thread func_1A07();
}

//Function Number: 5
func_9D3A(param_00)
{
	if(param_00 == "UN" || param_00 == "JK")
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_F7BB()
{
	var_00 = level.var_13075[self.var_13525];
	var_01 = var_00.size;
	var_02 = randomintrange(0,var_01);
	var_03 = var_02;
	for(var_04 = 0;var_04 <= var_01;var_04++)
	{
		if(var_00[var_02 + var_04 % var_01].var_C1 < var_00[var_03].var_C1)
		{
			var_03 = var_02 + var_04 % var_01;
		}
	}

	thread func_C19E(var_03);
	self.var_C19D = var_00[var_03].var_C19D;
	if(self.var_13525 == "unitednationsfemale")
	{
		self.var_C19D = "w" + self.var_C19D;
	}
}

//Function Number: 7
func_C19E(param_00)
{
	level.var_13075[self.var_13525][param_00].var_C1++;
	scripts\common\utility::waittill_either("death","removed from battleChatter");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	level.var_13075[self.var_13525][param_00].var_C1--;
}

//Function Number: 8
func_1A19()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(2);
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < 1048576)
		{
			if(isdefined(self.var_10AC8.var_B65C) && self.var_10AC8.var_B65C > 1)
			{
				func_181C("taunt","hostileburst");
			}
		}

		wait(randomfloatrange(2,5));
	}
}

//Function Number: 9
func_1A07()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		scripts\anim\battlechatter::func_CEE8();
		wait(0.3 + randomfloat(0.2));
	}
}

//Function Number: 10
func_1A54()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self.var_29AD = scripts\anim\battlechatter::func_7FD8();
		self.var_29B3 = scripts\anim\battlechatter::func_80C8();
		self waittill("set name and rank");
	}
}

//Function Number: 11
func_E11B(param_00)
{
	if(scripts\anim\battlechatter::func_29CA())
	{
		if(func_1A1B() || !isalive(self))
		{
			if(isdefined(self))
			{
				func_1A0C();
				func_1A0A();
			}
		}
	}

	if(isdefined(self))
	{
		self.var_28CF = 0;
		self.var_3D4B = 0;
	}

	self notify("removed from battleChatter");
	if(isdefined(self))
	{
		self.var_3D4C = undefined;
		self.var_BFA8 = undefined;
		self.var_BFA9 = undefined;
		self.var_9F6B = undefined;
		self.var_6552 = undefined;
		self.var_376A = undefined;
		self.var_46BC = undefined;
		self.var_C19D = undefined;
	}
}

//Function Number: 12
func_94E5()
{
	self.var_3D4C = [];
	self.var_3D4C["threat"] = spawnstruct();
	self.var_3D4C["threat"].var_698B = 0;
	self.var_3D4C["threat"].priority = 0;
	self.var_3D4C["response"] = spawnstruct();
	self.var_3D4C["response"].var_698B = 0;
	self.var_3D4C["response"].priority = 0;
	self.var_3D4C["reaction"] = spawnstruct();
	self.var_3D4C["reaction"].var_698B = 0;
	self.var_3D4C["reaction"].priority = 0;
	self.var_3D4C["inform"] = spawnstruct();
	self.var_3D4C["inform"].var_698B = 0;
	self.var_3D4C["inform"].priority = 0;
	self.var_3D4C["order"] = spawnstruct();
	self.var_3D4C["order"].var_698B = 0;
	self.var_3D4C["order"].priority = 0;
	self.var_3D4C["custom"] = spawnstruct();
	self.var_3D4C["custom"].var_698B = 0;
	self.var_3D4C["custom"].priority = 0;
	self.var_BFA8 = gettime() + 50;
	self.var_BFA9["threat"] = 0;
	self.var_BFA9["reaction"] = 0;
	self.var_BFA9["response"] = 0;
	self.var_BFA9["inform"] = 0;
	self.var_BFA9["order"] = 0;
	self.var_BFA9["custom"] = 0;
	self.var_9F6B = 0;
	self.var_29BF = 0;
	self.var_1C8B = [];
	scripts\anim\battlechatter::func_17A2("exposed");
	scripts\anim\battlechatter::func_17A2("ai_contact_clock");
	scripts\anim\battlechatter::func_17A2("ai_target_clock");
	if(self.team == "allies")
	{
		if(scripts\common\utility::func_2286(level.var_D3DD,self.var_13525))
		{
			scripts\anim\battlechatter::func_17A2("player_contact_clock");
			scripts\anim\battlechatter::func_17A2("player_target_clock");
			scripts\anim\battlechatter::func_17A2("player_cardinal");
			scripts\anim\battlechatter::func_17A2("player_obvious");
			scripts\anim\battlechatter::func_17A2("player_object_clock");
			scripts\anim\battlechatter::func_17A2("player_location");
		}

		scripts\anim\battlechatter::func_17A2("ai_location");
		scripts\anim\battlechatter::func_17A2("generic_location");
		if(self.var_13525 == "unitednations" || self.var_13525 == "unitednationsfemale")
		{
			scripts\anim\battlechatter::func_17A2("ai_obvious");
			scripts\anim\battlechatter::func_17A2("ai_casual_clock");
			scripts\anim\battlechatter::func_17A2("concat_location");
			scripts\anim\battlechatter::func_17A2("concat_location");
			scripts\anim\battlechatter::func_17A2("player_distance");
			scripts\anim\battlechatter::func_17A2("player_target_clock_high");
			scripts\anim\battlechatter::func_17A2("ai_distance");
			scripts\anim\battlechatter::func_17A2("ai_target_clock_high");
		}
	}

	self.var_28CF = 0;
	if((isdefined(self.var_ED15) && self.var_ED15) || level.var_29B7)
	{
		self.var_28CF = level.var_28CF[self.team];
	}

	self.var_6EE9 = 0;
	if(scripts\anim\battlechatter::func_13528() && level.var_6EE9[self.team] == 1 && self != level.player)
	{
		self.var_6EE9 = 1;
	}
	else
	{
		self.var_6EE9 = 0;
	}

	if(level.var_7410)
	{
		scripts\sp\_utility::func_F3C0(1);
	}
	else
	{
		scripts\sp\_utility::func_F3C0(0);
	}

	self.var_3D4B = 1;
}

//Function Number: 13
func_183F(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_3902("threat",param_00,param_02))
	{
		return;
	}

	if(scripts\anim\battlechatter::func_117ED(param_01) && !isplayer(param_01))
	{
		return;
	}

	var_03 = scripts\anim\battlechatter::func_4995("threat",param_00,param_02);
	switch(param_00)
	{
		case "infantry":
			var_03.var_117B9 = param_01;
			break;

		case "acquired":
			var_03.var_117B9 = param_01;
			break;
	}

	if(isdefined(param_01.var_10AC8))
	{
		self.var_10AC8 scripts\anim\battlechatter::func_12E7C(param_01.var_10AC8.var_10AEE,self);
	}

	self.var_3D4C["threat"] = undefined;
	self.var_3D4C["threat"] = var_03;
}

//Function Number: 14
func_1820(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_1821(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 15
func_1821(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("responseEvent_failsafe");
	thread func_E2A1(param_02);
	var_06 = param_02 scripts\common\utility::func_13734("death","done speaking","cancel speaking");
	if(var_06 == "cancel speaking")
	{
		return;
	}

	if(!isalive(param_02))
	{
		return;
	}

	if(!scripts\anim\battlechatter::func_3902("response",param_00,param_03,param_01))
	{
		return;
	}

	if(!isplayer(param_02))
	{
		if(scripts\anim\battlechatter::func_9FC7(param_02))
		{
			return;
		}
	}

	var_07 = scripts\anim\battlechatter::func_4995("response",param_00,param_03);
	if(isdefined(param_04))
	{
		var_07.var_E1A1 = param_04;
	}

	if(isdefined(param_05))
	{
		var_07.var_AEC4 = param_05;
	}

	var_07.var_E29D = param_02;
	var_07.var_B92F = param_01;
	self.var_3D4C["response"] = undefined;
	self.var_3D4C["response"] = var_07;
}

//Function Number: 16
func_E2A1(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	param_00 endon("death");
	param_00 endon("done speaking");
	param_00 endon("cancel speaking");
	wait(25);
	self notify("responseEvent_failsafe");
}

//Function Number: 17
func_17D2(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_3902("inform",param_00,param_03,param_01))
	{
		return;
	}

	var_05 = scripts\anim\battlechatter::func_4995("inform",param_00,param_03);
	switch(param_00)
	{
		case "reloading":
			var_05.var_B92F = param_01;
			var_05.var_94C2 = param_02;
			break;

		case "killfirm":
			if(isdefined(param_04))
			{
				var_05.var_117DE = param_04;
			}
	
			break;

		default:
			var_05.var_B92F = param_01;
			break;
	}

	self.var_3D4C["inform"] = undefined;
	self.var_3D4C["inform"] = var_05;
}

//Function Number: 18
func_181C(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.var_3D4C))
	{
		return;
	}

	if(!isdefined(level.var_68AF) || !isdefined(level.var_68B5))
	{
		return;
	}

	var_04 = scripts\anim\battlechatter::func_4995("reaction",param_00,param_03);
	var_04.var_DD60 = param_02;
	var_04.var_B92F = param_01;
	self.var_3D4C["reaction"] = undefined;
	self.var_3D4C["reaction"] = var_04;
}

//Function Number: 19
func_1809(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_3902("order",param_00,param_03,param_01))
	{
		return;
	}

	var_04 = scripts\anim\battlechatter::func_4995("order",param_00,param_03);
	var_04.var_B92F = param_01;
	var_04.var_C6E5 = param_02;
	self.var_3D4C["order"] = undefined;
	self.var_3D4C["order"] = var_04;
}

//Function Number: 20
func_81C6(param_00,param_01)
{
	var_02 = param_00.size;
	if(var_02 == 0)
	{
		wait(param_01);
		return param_00;
	}

	var_03 = param_01 * 20;
	var_04 = var_02 / var_03;
	var_05 = [];
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_07 = param_00[var_06];
		if(self.var_10AEE != "jackal_allies")
		{
			if(!isdefined(var_07) || isdefined(var_07) && !isdefined(var_07.var_13525))
			{
				continue;
			}
		}
		else if(!isdefined(var_07))
		{
			continue;
		}

		if(!isdefined(var_07.var_6552) || self.var_10AEE == "jackal_allies" && isdefined(var_07.var_13525))
		{
			continue;
		}

		var_05[var_05.size] = param_00[var_06];
	}

	if(var_05.size == 0)
	{
		wait(param_01);
		return var_05;
	}

	var_05 = sortbydistance(var_05,level.player.origin);
	var_08 = [];
	var_09 = [];
	var_0A = 0;
	foreach(var_0C in var_05)
	{
		if(isdefined(var_0C) && func_117E8(var_0C))
		{
			var_0D = var_0C scripts\anim\battlechatter::func_7F7E();
			if(isdefined(var_0D) && !scripts\anim\battlechatter::func_AEC7(var_0D))
			{
				var_08[var_08.size] = var_0C;
			}
			else
			{
				var_09[var_09.size] = var_0C;
			}
		}

		var_0A++;
		if(var_0A >= var_04)
		{
			wait(0.05);
			var_0A = 0;
		}
	}

	var_05 = [];
	foreach(var_10 in var_08)
	{
		var_05[var_05.size] = var_10;
	}

	foreach(var_10 in var_09)
	{
		var_05[var_05.size] = var_10;
	}

	return var_05;
}

//Function Number: 21
func_117E8(param_00)
{
	if(distancesquared(level.player.origin,param_00.origin) > level.var_29BE)
	{
		return 0;
	}

	if(!level.player scripts\anim\battlechatter::func_6632(param_00))
	{
		if(scripts\common\utility::func_D11B() && isdefined(level.player.var_58B7) && level.player.var_58B7 == param_00)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 22
func_10AFB()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_10AEE);
	for(;;)
	{
		while(!isdefined(level.var_29B7) || !level.var_29B7)
		{
			wait(0.05);
		}

		while(level.var_29B7)
		{
			if(self.team == "allies")
			{
				if(self.var_10AEE == "jackal_allies")
				{
					var_00 = level.var_A056.var_1630;
					var_01 = func_81C6(var_00,0.5);
				}
				else
				{
					var_01 = func_81C6(function_0072("axis","team3"),0.5);
				}
			}
			else if(self.team == "team3")
			{
				var_01 = func_81C6(function_0072("allies","axis"),0.5);
			}
			else
			{
				wait(0.5);
				if(self.var_10AEE == "jackal_axis")
				{
					var_00 = level.var_A056.var_1630;
					var_01 = func_81C6(var_00,0.5);
				}
				else
				{
					var_01 = function_0072("allies","team3");
					var_01[var_01.size] = level.player;
				}
			}

			if(!var_01.size)
			{
				wait(0.1);
				continue;
			}

			var_02 = [];
			foreach(var_04 in self.var_B661)
			{
				if(!isalive(var_04))
				{
					continue;
				}

				if(isdefined(var_04.var_12BA4) && var_04.var_12BA4 == "c8")
				{
					continue;
				}

				if(isdefined(var_04.var_12BA4) && var_04.var_12BA4 == "c12")
				{
					continue;
				}

				if(!var_01.size)
				{
					var_01 = var_02;
					var_02 = [];
				}

				foreach(var_0C, var_06 in var_01)
				{
					if(scripts\common\utility::func_D11B())
					{
						if(var_06 == level.player)
						{
							var_06 = level.var_D127;
						}
					}
					else if(isdefined(var_04.var_29B8) && var_04.var_29B8)
					{
						continue;
					}

					if(!isdefined(var_06))
					{
						if(var_0C == 0)
						{
							var_01 = [];
						}

						continue;
					}

					if(!isalive(var_06))
					{
						continue;
					}

					if(!isdefined(var_06.var_6552))
					{
						continue;
					}

					if(!var_04 func_29A2(var_06))
					{
						if((scripts\common\utility::func_D11B() && var_06 == level.var_D127) || !scripts\common\utility::func_D11B() && isplayer(var_06))
						{
							continue;
						}

						if(!isdefined(var_06.team) || isdefined(var_06.team) && var_06.team == level.player.team)
						{
							continue;
						}

						if(!level.player func_29A2(var_06) && !scripts\common\utility::func_D11B())
						{
							continue;
						}
					}

					var_07 = var_04 func_810F();
					if(isdefined(var_07))
					{
						var_04 func_17D2("incoming","seeker",undefined,0.9);
					}
					else if(isdefined(var_04.var_3135) && isdefined(var_04.var_3135.var_DB05))
					{
						var_04 func_181C("danger",undefined,var_04.var_3135.var_DB05);
					}
					else
					{
						var_04 func_183F(var_06.var_6552,var_06);
					}

					var_02[var_02.size] = var_06;
					var_08 = [];
					var_07 = undefined;
					foreach(var_0A in var_01)
					{
						if(var_0A != var_06)
						{
							var_08[var_08.size] = var_0A;
						}
					}

					var_01 = var_08;
					break;
				}

				wait(0.05);
			}

			wait(0.05);
		}
	}
}

//Function Number: 23
func_1A1B()
{
	if(isdefined(self.var_238F) && self.var_238F == "jackal")
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_29A2(param_00)
{
	if(isdefined(level.var_D127))
	{
		if(!scripts\common\utility::func_D11B() && self == level.var_D127)
		{
			return 0;
		}
	}

	if(func_1A1B() || scripts\common\utility::func_D11B() && self == level.var_D127)
	{
		if(param_00 func_1A1B())
		{
			var_01 = vectornormalize(param_00.origin - self.origin);
			var_02 = anglestoforward(self.angles);
			var_03 = vectordot(var_02,var_01);
			if(var_03 > 0.6)
			{
				return 1;
			}
		}
	}
	else if(self == level.player)
	{
		if(scripts\sp\_utility::func_CFAC(param_00))
		{
			return 1;
		}
	}
	else if(self method_805F(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
func_10AE7()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_10AEE);
	if(self.var_10AEE != "jackal_allies")
	{
		return;
	}

	while(!isdefined(level.var_29B7) || !level.var_29B7)
	{
		wait(0.05);
	}

	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		while(level.var_29B7)
		{
			foreach(var_03 in self.var_B661)
			{
				if(var_03 != level.player)
				{
					if(isdefined(var_03.var_3135) && isdefined(var_03.var_3135.var_A533) && var_03.var_3135.var_A533)
					{
						var_00 = "flare";
						var_01 = var_03;
						break;
					}
					else if(isdefined(var_03.var_B8A4) && var_03.var_B8A4.size > 0)
					{
						var_00 = "missile";
						var_01 = var_03;
						break;
					}
					else if(var_03 scripts\sp\_utility::func_65DF("jackal_firing"))
					{
						if(var_03 scripts\sp\_utility::func_65DB("jackal_firing"))
						{
							var_00 = "guns";
							var_01 = var_03;
							break;
						}
					}

					continue;
				}

				if(!level.player scripts\sp\_utility::func_65DB("disable_jackal_flares"))
				{
					if(var_03.var_6E9C.var_C1 < var_03.var_6E9C.var_B417 && var_03.var_6E9C.var_A989 < gettime() - 50)
					{
						var_00 = "flare";
						var_01 = var_03;
						break;
					}
				}

				if(!level.player scripts\sp\_utility::func_65DB("disable_jackal_missiles"))
				{
					if(var_03 scripts\sp\_utility::func_65DB("player_jackal_missile"))
					{
						var_00 = "missile";
						var_01 = var_03;
						break;
					}
				}
			}

			if(isdefined(var_01))
			{
				var_01 thread func_67CF(var_00);
				var_01 = undefined;
				wait(randomintrange(5,10));
				continue;
			}

			wait(0.5);
		}

		wait(0.5);
	}

	wait(1);
}

//Function Number: 26
func_810F()
{
	if(!isdefined(level.var_F10A.var_1633) || isdefined(level.var_F10A.var_1633) && level.var_F10A.var_1633.size < 1)
	{
		return;
	}

	if(scripts\anim\battlechatter::func_9B42(self))
	{
		return;
	}

	var_00 = undefined;
	foreach(var_02 in level.var_F10A.var_1633)
	{
		if(var_02.team == self.team)
		{
			continue;
		}

		var_03 = distancesquared(self.origin,var_02.origin);
		if(var_03 < 360000 && isdefined(var_02.var_3135.var_F15D) && var_02.var_3135.var_F15D != self)
		{
			var_00 = var_02;
			break;
		}
	}

	return var_00;
}

//Function Number: 27
func_1A0C()
{
	var_00 = self.var_4F;
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(self.var_12BA4) && self.var_12BA4 == "seeker")
	{
		return;
	}

	if(isdefined(self.var_10AC8) && isdefined(var_00.var_10AC8) && self.var_10AC8 == var_00.var_10AC8)
	{
		return;
	}

	scripts\common\utility::array_thread(self.var_10AC8.var_B661,::func_1A0B,self);
	if(!isdefined(var_00.var_28CF))
	{
		return;
	}

	if(isalive(var_00) && !isplayer(var_00) && isdefined(var_00.var_10AC8) && var_00.var_28CF)
	{
		if(isdefined(var_00.var_376A) && isdefined(var_00.var_376A[var_00.var_10AC8.var_10AEE]))
		{
			var_00.var_376A[var_00.var_10AC8.var_10AEE] = undefined;
		}

		if(!isdefined(var_00.var_6552))
		{
			return;
		}

		if(!var_00 scripts\anim\battlechatter::func_9C15())
		{
			return;
		}

		foreach(var_02 in self.var_10AC8.var_B661)
		{
			if(var_02 == level.player)
			{
				continue;
			}

			if(gettime() > var_02.var_A980 + 2000)
			{
				continue;
			}

			var_02 func_183F(var_00.var_6552,var_00);
		}
	}
}

//Function Number: 28
func_1A0B(param_00)
{
	if(!isalive(self))
	{
		return;
	}

	if(scripts\sp\_utility::func_D123())
	{
		return;
	}

	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	self endon("death");
	self endon("removed from battleChatter");
	self notify("aiDeathEventThread");
	self endon("aiDeathEventThread");
	if(self == level.player)
	{
		if(isdefined(param_00) && !level.player func_29A2(param_00))
		{
			return;
		}
	}

	wait(1.2);
	func_181C("casualty","generic",self,0.9);
}

//Function Number: 29
func_1A0A()
{
	var_00 = self.var_4F;
	var_01 = undefined;
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(var_00.team) && var_00.team == "allies" && isdefined(var_00.var_12BA4) && var_00.var_12BA4 == "c12")
	{
		var_02 = scripts\sp\_utility::func_78BB(var_00.origin,level.player.var_10AC8.var_B661,5000);
		var_01 = "ally_c12_kill";
		if(isdefined(var_02))
		{
			var_03 = var_02;
		}
	}
	else if(scripts\common\utility::func_D11B())
	{
		foreach(var_05 in level.var_10AF9["jackal_allies"].var_B661)
		{
			if(isdefined(var_05.var_4BC7) && var_05.var_4BC7 == self)
			{
				var_00 = var_05;
				var_01 = "jackal";
			}
		}
	}
	else if(!isalive(var_00) || !issentient(var_00) && var_00 != level.player || !isdefined(var_00.var_10AC8))
	{
		return;
	}

	if(!isdefined(var_00.var_46BC))
	{
		return;
	}

	if(var_00.var_46BC == "UN" || var_00.var_46BC == "JK")
	{
		if(!isdefined(var_01))
		{
			var_01 = self.var_12BA4;
		}

		if(isdefined(var_01))
		{
			var_00 thread func_1A1C(var_01);
		}
	}
}

//Function Number: 30
func_1A1C(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(param_00 == "civilian")
	{
		return;
	}

	wait(1.2);
	func_17D2("killfirm","generic",undefined,undefined,param_00);
}

//Function Number: 31
func_1A10()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = undefined;
	for(;;)
	{
		self waittill("grenade danger",var_01);
		if(getdvarint("bcs_enable") == 0)
		{
			continue;
		}

		if(isdefined(var_01))
		{
			var_00 = func_1A11(var_01);
			if(!isdefined(var_00))
			{
				continue;
			}
		}
		else if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
		{
			var_00 = "frag";
		}
		else
		{
			continue;
		}

		func_17D2("incoming",var_00);
	}
}

//Function Number: 32
func_1A11(param_00)
{
	var_01 = undefined;
	if(param_00.model == "frag_grenade_wm")
	{
		var_01 = "frag";
	}

	if(param_00.model == "emp_grenade_wm")
	{
		var_01 = "shock";
	}

	if(param_00.model == "anti_grav_grenade_wm")
	{
		var_01 = "ant";
	}

	return var_01;
}

//Function Number: 33
func_29B6()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("ai_events",var_00);
		foreach(var_02 in var_00)
		{
			if(var_02.type == "grenade danger")
			{
				self notify("grenade danger");
				break;
			}
		}

		wait(5);
	}
}

//Function Number: 34
func_1A0E()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	for(;;)
	{
		self waittill("trigger");
		if(getdvarint("bcs_enable") == 0)
		{
			continue;
		}

		if(gettime() < self.var_1491.var_C888 + 4000)
		{
			continue;
		}

		func_1820("ack","yes",level.player,1);
	}
}

//Function Number: 35
func_67D2(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	if(!isdefined(self.var_205))
	{
		return;
	}

	if(distancesquared(self.origin,self.var_205.origin) < 23040)
	{
		return;
	}

	if(!scripts\anim\battlechatter::func_9EB6())
	{
		return;
	}

	if(!func_BE58())
	{
		return;
	}

	var_01 = scripts\anim\battlechatter::func_80EA(24,1024,"response");
	if(self.team != "axis" && self.team != "team3")
	{
		if(!isdefined(var_01))
		{
			var_01 = level.player;
		}
		else if(randomint(100) < level.var_68AE["moveEvent"]["ordertoplayer"])
		{
			var_01 = level.player;
		}
	}

	if(self.var_440E > 0)
	{
		if(randomint(100) < level.var_68AE["moveEvent"]["coverme"])
		{
			func_1809("action","coverme",var_01);
			return;
		}

		func_1809("move","combat",var_01);
		return;
	}

	if(func_BE59())
	{
		if(gettime() - self.var_10DFF > 3000)
		{
			func_1809("move","noncombat",var_01);
			return;
		}
	}
}

//Function Number: 36
func_BE58()
{
	if(self.var_46BC == "SS")
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
func_BE59()
{
	if(self.var_46BC == "UN")
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
func_1A0F()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	for(;;)
	{
		level waittill("follow order",var_00);
		if(!scripts\anim\battlechatter::func_29CA())
		{
			return;
		}

		if(!isdefined(self.team))
		{
			return;
		}

		if(!isdefined(var_00))
		{
			continue;
		}

		if(!isalive(var_00) || var_00.team != self.team)
		{
			continue;
		}

		if(distancesquared(self.origin,var_00.origin) < 360000)
		{
			func_1820("ack","yes",var_00,0.9);
		}
	}
}

//Function Number: 39
func_D085()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	thread func_D086();
	for(;;)
	{
		self waittill("bulletwhizby",var_00,var_01);
		if(!scripts\anim\battlechatter::func_29CA())
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			if(level.var_46BD[self.var_13525] == "GM" && scripts\anim\battlechatter::func_3902("reaction","takingfire",1,undefined))
			{
				func_181C("takingfire",undefined,var_00,1);
			}

			continue;
		}
	}
}

//Function Number: 40
func_D084()
{
	func_181C("friendlyfire",undefined,level.player,1);
}

//Function Number: 41
func_D086()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_00,var_00,var_02);
		if(isdefined(var_01) && var_01 == level.player)
		{
			if(func_4D04(var_02))
			{
				func_D084();
			}
		}
	}
}

//Function Number: 42
func_4D04(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "MOD_CRUSH":
		case "MOD_IMPACT":
		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
		case "MOD_MELEE":
			return 0;
	}

	return 1;
}

//Function Number: 43
func_7414(param_00,param_01)
{
	var_02 = 65536;
	var_03 = 42;
	if(distancesquared(param_00.origin,self.origin) < var_02)
	{
		return 0;
	}

	if(param_01 > var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_67D4()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c6")
	{
		return;
	}

	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	func_17D2("reloading","generic");
}

//Function Number: 45
func_67D1()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	return 0;
}

//Function Number: 46
func_67D0()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	if(!isdefined(self.var_10C))
	{
	}
}

//Function Number: 47
func_67D5()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	func_17D2("suppressed","generic");
}

//Function Number: 48
func_67CF(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	var_01 = 0;
	var_02 = "frag";
	switch(param_00)
	{
		case "frag":
			var_02 = "frag";
			break;

		case "emp":
			var_02 = "shock";
			break;

		case "offhandshield":
			var_02 = "shield";
			break;

		case "hackingdevice":
			var_02 = "hack";
			break;

		case "guns":
			var_02 = "weapon_guns";
			var_01 = 1;
			break;

		case "missile":
			var_02 = "weapon_missile";
			var_01 = 1;
			break;

		case "flare":
			var_02 = "weapon_flare";
			break;
	}

	func_17D2("attack",var_02);
	if(var_01)
	{
		if(randomint(100) < 25)
		{
			wait(randomfloatrange(1,2));
			if(isalive(self))
			{
				thread func_181C("movement");
				return;
			}
		}
	}
}

//Function Number: 49
func_4C3A()
{
	var_00 = [];
	var_00[var_00.size] = "order_move_combat";
	var_00[var_00.size] = "order_move_noncombat";
	var_00[var_00.size] = "order_action_coverme";
	var_00[var_00.size] = "inform_reloading";
	level.var_4C81 = var_00;
}

//Function Number: 50
func_4C3C(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_4C81)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 51
func_7B7E(param_00)
{
	return level.var_29B1 + "custom battlechatter phrase \'" + param_00 + "\' isn\'t valid.  look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

//Function Number: 52
func_7854(param_00)
{
	return level.var_29B1 + "AI at origin " + self.origin + "wasn\'t able to play custom battlechatter because his nationality is \'" + self.var_46BC + "\'.";
}

//Function Number: 53
func_4C3B(param_00)
{
	if(!isdefined(level.var_4C81))
	{
		func_4C3A();
	}

	param_00 = tolower(param_00);
	if(!func_4C3C(param_00))
	{
		var_01 = func_7B7E(param_00);
		return 0;
	}

	var_02 = scripts\anim\battlechatter::func_80EA(24,512,"response");
	func_2A62();
	switch(var_01)
	{
		case "order_move_combat":
			if(!func_BE58())
			{
				return 0;
			}
	
			scripts\anim\battlechatter::func_128A8(self.var_4C84,var_02);
			func_17EF();
			break;

		case "order_move_noncombat":
			if(!func_BE59())
			{
				return 0;
			}
	
			func_17F0();
			break;

		case "order_action_coverme":
			scripts\anim\battlechatter::func_128A8(self.var_4C84,var_02);
			func_1797();
			break;

		case "inform_reloading":
			func_17D3();
			break;

		default:
			var_01 = func_7B7E(var_01);
			return 0;
	}

	func_6314(2000);
	return 1;
}

//Function Number: 54
func_2A62()
{
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	self.var_4C84 = scripts\anim\battlechatter::func_4996();
}

//Function Number: 55
func_1797()
{
	self.var_4C84 scripts\anim\battlechatter::func_1808("action","coverme");
}

//Function Number: 56
func_17EF()
{
	self.var_4C84 scripts\anim\battlechatter::func_1808("move","combat");
}

//Function Number: 57
func_17F0()
{
	self.var_4C84 scripts\anim\battlechatter::func_1808("move","noncombat");
}

//Function Number: 58
func_17D3()
{
	self.var_4C84 scripts\anim\battlechatter::func_17D1("reloading","generic");
}

//Function Number: 59
func_17F3(param_00)
{
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	self.var_4C84 scripts\anim\battlechatter::func_17F2(param_00);
}

//Function Number: 60
func_6314(param_00,param_01)
{
	if(!scripts\anim\battlechatter::func_29CA())
	{
		return;
	}

	var_02 = scripts\anim\battlechatter::func_4995("custom","generic",1);
	if(isdefined(param_00))
	{
		var_02.var_698B = gettime() + param_00;
	}

	if(isdefined(param_01))
	{
		var_02.type = param_01;
	}
	else
	{
		var_02.type = "custom";
	}

	self.var_3D4C["custom"] = undefined;
	self.var_3D4C["custom"] = var_02;
}
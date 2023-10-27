/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_patrol.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1194 ms
 * Timestamp: 10/27/2023 12:24:52 AM
*******************************************************************/

//Function Number: 1
func_C97C(param_00)
{
	if(isdefined(self.var_10C))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("damage");
	self endon("end_patrol");
	self endon("dog_attacks_ai");
	waittillframeend;
	if(isdefined(self.var_EED1))
	{
		[[ level.var_83D2["_patrol_endon_spotted_flag"] ]]();
	}

	thread func_13749();
	thread func_13759();
	self.var_15C = 32;
	self method_800B("stand");
	self.var_55B0 = 1;
	self.var_55ED = 1;
	self.var_30 = 1;
	self.var_EE7E = 1;
	self.var_C3E8 = self.var_BC;
	self.var_BC = "no_cover";
	scripts\sp\_utility::func_5514();
	if(isdefined(self.var_EE2C))
	{
		self.var_C3FA = self.var_BCD6;
		self.var_BCD6 = self.var_EE2C;
	}

	func_AD3A();
	func_F4C7();
	var_01["ent"][1] = ::func_7CD9;
	var_01["ent"][0] = ::scripts\sp\_utility::func_7A8F;
	var_01["node"][1] = ::func_7CDB;
	var_01["node"][0] = ::func_7A92;
	var_01["struct"][1] = ::func_7CE0;
	var_01["struct"][0] = ::scripts\sp\_utility::func_7A97;
	var_02["ent"] = ::scripts\sp\_utility::func_F3D3;
	var_02["node"] = ::scripts\sp\_utility::func_F3D9;
	var_02["struct"] = ::scripts\sp\_utility::func_F3D3;
	if(isdefined(param_00))
	{
		self.target = param_00;
	}

	if(isdefined(self.target))
	{
		var_03 = 1;
		var_04 = func_7CD9();
		var_05 = func_7CDB();
		var_06 = func_7CE0();
		if(var_04.size)
		{
			var_07 = scripts\common\utility::random(var_04);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = scripts\common\utility::random(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = scripts\common\utility::random(var_08);
			var_08 = "struct";
		}
	}
	else
	{
		var_03 = 0;
		var_04 = scripts\sp\_utility::func_7A8F();
		var_05 = func_7A92();
		var_06 = scripts\sp\_utility::func_7A97();
		if(var_06.size)
		{
			var_07 = scripts\common\utility::random(var_06);
			var_08 = "ent";
		}
		else if(var_07.size)
		{
			var_07 = scripts\common\utility::random(var_07);
			var_08 = "node";
		}
		else
		{
			var_07 = scripts\common\utility::random(var_08);
			var_08 = "struct";
		}
	}

	var_09 = [];
	var_09["pause"] = "patrol_idle_";
	var_09["turn180"] = scripts\common\utility::func_116D7(isdefined(self.var_C97E),self.var_C97E,"patrol_turn180");
	var_09["smoke"] = "patrol_idle_smoke";
	var_09["stretch"] = "patrol_idle_stretch";
	var_09["checkphone"] = "patrol_idle_checkphone";
	var_09["phone"] = "patrol_idle_phone";
	var_0A = var_07;
	for(;;)
	{
		while(isdefined(var_0A.var_C97F))
		{
			wait(0.05);
		}

		var_07.var_C97F = undefined;
		var_07 = var_0A;
		self notify("release_node");
		var_07.var_C97F = 1;
		self.var_A8F4 = var_07;
		[[ var_02[var_08] ]](var_07);
		if(isdefined(var_07.var_257) && var_07.var_257 > 0)
		{
			self.var_15C = var_07.var_257;
		}
		else
		{
			self.var_15C = 32;
		}

		self waittill("goal");
		var_07 notify("trigger",self);
		if(isdefined(var_07.var_ED9E))
		{
			scripts\common\utility::flag_set(var_07.var_ED9E);
		}

		if(isdefined(var_07.var_ED80))
		{
			scripts\sp\_utility::func_65E1(var_07.var_ED80);
		}

		if(isdefined(var_07.var_ED9B))
		{
			scripts\common\utility::func_6E2A(var_07.var_ED9B);
		}

		var_0B = var_07 [[ var_01[var_08][var_03] ]]();
		if(!var_0B.size)
		{
			if(isdefined(var_07.var_ED88))
			{
				self method_8221("face angle",var_07.angles[1]);
			}

			self notify("reached_path_end");
			self notify("_patrol_reached_path_end");
			if(isalive(self.var_C991))
			{
				self.var_C991 notify("master_reached_patrol_end");
			}
		}

		var_0C = ::scripts\anim\reactions::func_DD51;
		var_0D = var_07.var_ECF5;
		var_0E = 1;
		var_0F = 0;
		if(isdefined(var_07.var_EE79))
		{
			var_10 = strtok(var_07.var_EE79," ");
			for(var_11 = 0;var_11 < var_10.size;var_11++)
			{
				switch(var_10[var_11])
				{
					case "keep_running":
						var_0E = 0;
						break;
	
					case "use_node":
						var_0F = 1;
						break;
	
					case "animset":
						var_11 = var_11 + 1;
						self.var_ECF5 = var_10[var_11];
						if(self.var_ECF5 == "default")
						{
							self.var_ECF5 = undefined;
							self.var_C9AB = undefined;
							self.var_C9AC = undefined;
							self.var_C987 = undefined;
						}
						func_F4C7();
						break;
				}
			}
		}

		if(isdefined(var_07.var_EE2C))
		{
			self.var_BCD6 = var_07.var_EE2C;
		}

		if((var_07 func_8BA5() && var_07 func_ED4E()) || isdefined(var_0D) || isdefined(var_07.var_EDA0) && !scripts\common\utility::flag(var_07.var_EDA0))
		{
			if(!isdefined(self.var_C98F) && var_0E)
			{
				func_C981(var_0D,var_0C,var_07);
			}

			if(isdefined(var_07.var_EDA0) && !scripts\common\utility::flag(var_07.var_EDA0))
			{
				scripts\common\utility::flag_wait(var_07.var_EDA0);
			}

			var_07 scripts\sp\_utility::script_delay();
			if(isdefined(var_0D))
			{
				if(isdefined(var_07.var_ED88))
				{
					self method_8221("face angle",var_07.angles[1]);
				}

				self.var_C99C = 1;
				var_12 = var_09[var_0D];
				if(!isdefined(var_12))
				{
					if(isdefined(level.var_C99E))
					{
						var_12 = level.var_C99E[var_0D];
					}
				}

				if(isdefined(var_12))
				{
					if(var_0D == "pause")
					{
						if(isdefined(self.var_C99D) && isdefined(self.var_C99D[var_0D]))
						{
							var_12 = self.var_C99D[var_0D][randomint(self.var_C99D[var_0D].size)];
						}
						else
						{
							var_12 = var_12 + randomintrange(1,6);
						}
					}

					if(var_0F)
					{
						var_07 lib_0B06::func_1ECE(self,var_12);
						var_07 lib_0B06::func_1EC8(self,"gravity",var_12,undefined,var_0C);
					}
					else
					{
						lib_0B06::func_1EC8(self,"gravity",var_12,undefined,var_0C);
					}
				}

				self.var_C99C = undefined;
			}

			if(var_0B.size && !isdefined(var_0D) || var_0D != "turn180" && var_0E && !isdefined(self.var_1025F) || !self.var_1025F)
			{
				func_C980(var_0D,var_0C);
			}
		}

		if(!var_0B.size)
		{
			if(isdefined(self.var_C982) && !isdefined(var_0D))
			{
				func_C981("path_end_idle",var_0C,var_07);
				for(;;)
				{
					var_13 = self.var_C982[randomint(self.var_C982.size)];
					lib_0B06::func_1EC8(self,"gravity",var_13,undefined,var_0C);
				}
			}

			break;
		}

		var_0A = scripts\common\utility::random(var_0B);
	}
}

//Function Number: 2
func_C981(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = 0;
	if(isdefined(param_02.var_ED88))
	{
		var_03 = param_02;
		self.var_C0C1 = 1;
		var_04 = 1;
	}

	if(isdefined(self.var_C9A7) && isdefined(self.var_C9A7[param_00]))
	{
		var_03 lib_0B06::func_1EC8(self,"gravity",self.var_C9A7[param_00],undefined,param_01,var_04);
		return;
	}

	if(isdefined(self.var_ECF5) && isdefined(level.var_EC85["generic"]["patrol_stop_" + self.var_ECF5]))
	{
		lib_0B06::func_1EC8(self,"gravity","patrol_stop_" + self.var_ECF5,undefined,param_01);
		return;
	}

	var_03 lib_0B06::func_1EC8(self,"gravity","patrol_stop",undefined,param_01,var_04);
}

//Function Number: 3
func_C980(param_00,param_01)
{
	if(isdefined(self.var_C9A3) && isdefined(self.var_C9A3[param_00]))
	{
		lib_0B06::func_1EC8(self,"gravity",self.var_C9A3[param_00],undefined,param_01);
		return;
	}

	if(isdefined(self.var_ECF5) && isdefined(level.var_EC85["generic"]["patrol_start_" + self.var_ECF5]))
	{
		lib_0B06::func_1EC8(self,"gravity","patrol_start_" + self.var_ECF5,undefined,param_01);
		return;
	}

	lib_0B06::func_1EC8(self,"gravity","patrol_start",undefined,param_01);
}

//Function Number: 4
func_10B63()
{
	if(self.var_1491.var_D6A5 == "crouch" && isdefined(self.var_1491.var_2274))
	{
		var_00 = self.var_1491.var_2274["stance_change"];
		if(isdefined(var_00))
		{
			self method_82E4("stand_up",var_00,%root,1);
			scripts\anim\shared::func_592B("stand_up");
		}
	}
}

//Function Number: 5
func_C99B()
{
	self endon("enemy");
	self method_8016("zonly_physics",0);
	self method_8221("face current");
	func_10B63();
	var_00 = level.var_EC85["generic"]["patrol_radio_in_clear"];
	self method_82E4("radio",var_00,%root,1);
	scripts\anim\shared::func_592B("radio");
	func_12942();
}

//Function Number: 6
func_12942()
{
	if(!isdefined(self.var_233))
	{
		return;
	}

	var_00 = self.var_233;
	var_01 = var_00 - self.origin;
	var_01 = (var_01[0],var_01[1],0);
	var_02 = lengthsquared(var_01);
	if(var_02 < 1)
	{
		return;
	}

	var_01 = var_01 / sqrt(var_02);
	var_03 = anglestoforward(self.angles);
	if(vectordot(var_03,var_01) < -0.5)
	{
		self method_8016("zonly_physics",0);
		self method_8221("face current");
		func_10B63();
		var_04 = level.var_EC85["generic"]["patrol_turn180"];
		self method_82E4("move",var_04,%root,1);
		if(animhasnotetrack(var_04,"code_move"))
		{
			scripts\anim\shared::func_592B("move");
			self method_8221("face motion");
			self method_8016("none",0);
		}

		scripts\anim\shared::func_592B("move");
	}
}

//Function Number: 7
func_F4C7()
{
	if(isdefined(self.var_ECF5))
	{
		if(isdefined(level.var_EC85["generic"]["patrol_walk_" + self.var_ECF5]))
		{
			self.var_C9AB = "patrol_walk_" + self.var_ECF5;
		}

		if(isdefined(level.var_EC85["generic"]["patrol_walk_weights_" + self.var_ECF5]))
		{
			self.var_C9AC = "patrol_walk_weights_" + self.var_ECF5;
		}

		if(isdefined(level.var_EC85["generic"]["patrol_idle_" + self.var_ECF5]))
		{
			self.var_C987 = "patrol_idle_" + self.var_ECF5;
		}
	}

	var_00 = "patrol_walk";
	if(isdefined(self.var_C9AB))
	{
		var_00 = self.var_C9AB;
	}

	var_01 = undefined;
	if(isdefined(self.var_C9AC))
	{
		var_01 = self.var_C9AC;
	}

	if(isdefined(self.var_ECF5))
	{
		if(isdefined(level.var_EC85["generic"]["patrol_idle_" + self.var_ECF5]))
		{
			scripts\sp\_utility::func_F3C8("patrol_idle_" + self.var_ECF5);
		}
	}

	scripts\sp\_utility::func_F3CC(var_00,var_01);
}

//Function Number: 8
func_1374A()
{
	self endon("end_patrol");
	if(isdefined(self.var_C98C))
	{
		self.var_C98C endon("death");
	}

	self waittill("enemy");
}

//Function Number: 9
func_13759()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.var_A8F4))
	{
		return;
	}

	self.var_A8F4.var_C97F = undefined;
}

//Function Number: 10
func_13749()
{
	self endon("death");
	func_1374A();
	var_00 = scripts\sp\_utility::func_65DF("_stealth_enabled") && scripts\sp\_utility::func_65DB("_stealth_enabled");
	self.var_EE7E = 0;
	if(isdefined(self.var_C3E8))
	{
		self.var_BC = self.var_C3E8;
	}

	if(!var_00)
	{
		scripts\sp\_utility::func_4154();
		self.var_BC = self.var_C3E8;
		scripts\sp\_utility::func_417A();
		self method_800B("stand","crouch","prone");
		self.var_55B0 = 0;
		self.var_55ED = 0;
		self method_83A1();
		self notify("stop_animmode");
		self.var_EE56 = undefined;
		self.var_15C = level.var_4FF6;
	}

	if(isdefined(self.var_C3C3))
	{
		self.var_190 = self.var_C3C3;
	}

	self.var_BCD6 = 1;
	if(!isdefined(self))
	{
		return;
	}

	self notify("release_node");
	if(!isdefined(self.var_A8F4))
	{
		return;
	}

	self.var_A8F4.var_C97F = undefined;
}

//Function Number: 11
func_7CD9()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 12
func_7CDB()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = function_00B4(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 13
func_7CE0()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	}

	return var_00;
}

//Function Number: 14
func_7A92()
{
	var_00 = [];
	if(isdefined(self.var_EE01))
	{
		var_01 = strtok(self.var_EE01," ");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = function_00B3(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 15
func_10118(param_00)
{
	self endon("release_node");
}

//Function Number: 16
func_AD3A()
{
	if(isdefined(self.var_C991))
	{
		self.var_C991 thread func_CA83();
		return;
	}

	if(!isdefined(self.var_EE81))
	{
		return;
	}

	waittillframeend;
	var_00 = function_0074(self.team,"dog");
	var_01 = undefined;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(var_00[var_02].var_EE81))
		{
			continue;
		}

		if(var_00[var_02].var_EE81 != self.var_EE81)
		{
			continue;
		}

		var_01 = var_00[var_02];
		self.var_C991 = var_01;
		var_01.var_C98C = self;
		break;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 thread func_CA83();
}

//Function Number: 17
func_CA83()
{
	scripts\sp\_utility::func_106ED(self);
	if(isdefined(self.var_10C))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	if(isdefined(self.var_EED1))
	{
		[[ level.var_83D2["_patrol_endon_spotted_flag"] ]]();
	}

	self.var_C98C endon("death");
	thread func_13749();
	self.var_15C = 4;
	self.var_30 = 1;
	var_00 = func_CA84();
	var_01 = vectornormalize(self.origin - self.var_C98C.origin);
	var_02 = anglestoright(self.var_C98C.angles);
	var_03 = "left";
	if(vectordot(var_01,var_02) > 0)
	{
		var_03 = "right";
	}

	wait(1);
	thread func_CA86();
	thread func_CA87();
	self.var_C3C3 = self.var_190;
	self.var_190 = 70;
	for(;;)
	{
		if(isdefined(self.var_C98C) && !isdefined(self.var_C98C.var_C99C))
		{
			var_00 = func_CA88(var_00);
			if(var_03 == "null")
			{
				var_03 = "back";
			}

			var_03 = func_CA85(var_00,var_03);
			self.var_C986 = var_00[var_03].origin;
		}
		else
		{
			self.var_C986 = self.origin;
		}

		self method_82EF(self.var_C986);
		wait(0.05);
	}
}

//Function Number: 18
func_CA84()
{
	var_00 = [];
	var_01 = spawnstruct();
	var_01.var_C6C0 = [];
	var_01.var_C6C0[var_01.var_C6C0.size] = "right";
	var_01.var_C6C0[var_01.var_C6C0.size] = "back_right";
	var_02 = spawnstruct();
	var_02.var_C6C0 = [];
	var_02.var_C6C0[var_02.var_C6C0.size] = "right";
	var_02.var_C6C0[var_02.var_C6C0.size] = "back_right";
	var_02.var_C6C0[var_02.var_C6C0.size] = "back";
	var_03 = spawnstruct();
	var_03.var_C6C0 = [];
	var_03.var_C6C0[var_03.var_C6C0.size] = "back_right";
	var_03.var_C6C0[var_03.var_C6C0.size] = "back_left";
	var_03.var_C6C0[var_03.var_C6C0.size] = "back";
	var_04 = spawnstruct();
	var_04.var_C6C0 = [];
	var_04.var_C6C0[var_04.var_C6C0.size] = "left";
	var_04.var_C6C0[var_04.var_C6C0.size] = "back_left";
	var_04.var_C6C0[var_04.var_C6C0.size] = "back";
	var_05 = spawnstruct();
	var_05.var_C6C0 = [];
	var_05.var_C6C0[var_05.var_C6C0.size] = "left";
	var_05.var_C6C0[var_05.var_C6C0.size] = "back_left";
	var_06 = spawnstruct();
	var_00["right"] = var_01;
	var_00["left"] = var_05;
	var_00["back_right"] = var_02;
	var_00["back_left"] = var_04;
	var_00["back"] = var_03;
	var_00["null"] = var_06;
	return var_00;
}

//Function Number: 19
func_CA88(param_00)
{
	var_01 = vectortoangles(self.var_C98C.var_A8F4.origin - self.var_C98C.origin);
	var_02 = self.var_C98C.origin;
	var_03 = anglestoright(var_01);
	var_04 = anglestoforward(var_01);
	param_00["right"].origin = var_02 + var_03 * 40 + var_04 * 30;
	param_00["left"].origin = var_02 + var_03 * -40 + var_04 * 30;
	param_00["back_right"].origin = var_02 + var_03 * 32 + var_04 * -16;
	param_00["back_left"].origin = var_02 + var_03 * -32 + var_04 * -16;
	param_00["back"].origin = var_02 + var_04 * -48;
	param_00["null"].origin = self.origin;
	var_05 = getarraykeys(param_00);
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = var_05[var_06];
		param_00[var_07].var_3E06 = 0;
		param_00[var_07].var_DE05 = 0;
	}

	return param_00;
}

//Function Number: 20
func_CA82(param_00)
{
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(var_03 == "null")
		{
			continue;
		}
	}
}

//Function Number: 21
func_CA85(param_00,param_01)
{
	param_00[param_01].var_DE05 = 1;
	for(var_02 = 0;var_02 < param_00[param_01].var_C6C0.size;var_02++)
	{
		var_03 = param_00[param_01].var_C6C0[var_02];
		if(param_00[var_03].var_3E06)
		{
			continue;
		}

		if(self method_8200(param_00[var_03].origin))
		{
			return var_03;
		}

		param_00[var_03].var_3E06 = 1;
	}

	for(var_02 = 0;var_02 < param_00[param_01].var_C6C0.size;var_02++)
	{
		var_03 = param_00[param_01].var_C6C0[var_02];
		if(param_00[var_03].var_DE05)
		{
			continue;
		}

		var_03 = func_CA85(param_00,var_03);
		return var_03;
	}

	return "null";
}

//Function Number: 22
func_CA86(param_00)
{
	if(isdefined(self.var_10C))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_C98C endon("death");
	if(isdefined(self.var_C98C.script_noteworthy) && self.var_C98C.script_noteworthy == "cqb_patrol")
	{
		scripts\sp\_utility::func_F35F();
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 200;
	}

	scripts\sp\_utility::func_F35F();
	for(;;)
	{
		wait(0.1);
		var_01 = self.var_C986;
		var_02 = distancesquared(self.origin,self.var_C986);
		if(var_02 > squared(param_00))
		{
			if(self.var_1491.var_BCC8 == "run")
			{
				continue;
			}

			lib_0B06::func_1EC8(self,"gravity","patrol_dog_start");
			scripts\sp\_utility::func_417A();
			self.var_EE56 = 1;
			continue;
		}

		if(self.var_1491.var_BCC8 != "walk")
		{
			self notify("stopped_while_patrolling");
			lib_0B06::func_1EC8(self,"gravity","patrol_dog_stop");
			scripts\sp\_utility::func_F35F();
		}
	}
}

//Function Number: 23
func_CA87(param_00,param_01)
{
	if(isdefined(self.var_10C))
	{
		return;
	}

	self endon("enemy");
	self endon("death");
	self endon("end_patrol");
	self.var_C98C endon("death");
	if(isdefined(self.var_C98C.script_noteworthy) && self.var_C98C.script_noteworthy == "cqb_patrol")
	{
		for(;;)
		{
			wait(0.05);
			var_02 = self.var_C986;
			var_03 = distancesquared(self.origin,self.var_C986);
			if(var_03 < squared(16))
			{
				if(self.var_BCD6 > 0.4)
				{
					self.var_BCD6 = self.var_BCD6 - 0.05;
				}

				continue;
			}

			if(var_03 > squared(48))
			{
				if(self.var_BCD6 < 1.8)
				{
					self.var_BCD6 = self.var_BCD6 + 0.05;
				}

				continue;
			}

			self.var_BCD6 = 1;
		}
	}

	if(!isdefined(param_00))
	{
		param_00 = 16;
	}

	if(!isdefined(param_01))
	{
		param_01 = 48;
	}

	var_04 = param_00 * param_00;
	var_05 = param_01 * param_01;
	for(;;)
	{
		wait(0.05);
		var_02 = self.var_C986;
		var_03 = distancesquared(self.origin,self.var_C986);
		if(self.var_1491.var_BCC8 != "walk")
		{
			self.var_BCD6 = 1;
			continue;
		}

		if(var_03 < var_04)
		{
			if(self.var_BCD6 > 0.4)
			{
				self.var_BCD6 = self.var_BCD6 - 0.05;
			}

			continue;
		}

		if(var_03 > var_05)
		{
			if(self.var_BCD6 < 0.75)
			{
				self.var_BCD6 = self.var_BCD6 + 0.05;
			}

			continue;
		}

		self.var_BCD6 = 0.5;
	}
}

//Function Number: 24
func_8BA5()
{
	if(isdefined(self.script_delay) || isdefined(self.var_ED50))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
func_ED4E()
{
	if(isdefined(self.script_delay))
	{
		return self.script_delay > 0.5;
	}

	if(isdefined(self.var_ED50))
	{
		return self.var_ED50 > 0.5;
	}

	return 0;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_vehicle_code.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 124
 * Decompile Time: 5730 ms
 * Timestamp: 10/27/2023 12:25:59 AM
*******************************************************************/

//Function Number: 1
func_FA79()
{
	var_00 = func_12B8();
	foreach(var_02 in var_00)
	{
		var_02 thread func_1323A();
	}
}

//Function Number: 2
func_1323A()
{
	self endon("entitydeleted");
	if(isdefined(self.var_ED48))
	{
		thread lib_0B77::func_1323D();
	}

	self.var_C1 = 1;
	self.var_10708 = [];
	for(;;)
	{
		var_00 = undefined;
		self waittill("spawned",var_00);
		self.var_C1--;
		if(!isdefined(var_00))
		{
			continue;
		}

		var_00.var_10707 = self.var_10708;
		var_00.spawner = self;
		var_00 thread lib_0B77::func_E81A();
	}
}

//Function Number: 3
func_A629(param_00)
{
	param_00 waittill("trigger");
	foreach(var_02 in vehicle_getspawnerarray())
	{
		if(isdefined(var_02.var_EDF5) && var_02.var_EDF5 == self.var_EDF5)
		{
			var_02 delete();
		}
	}
}

//Function Number: 4
func_1063F(param_00)
{
	var_01 = [];
	var_02 = scripts\sp\_utility::func_65DF("no_riders_until_unload");
	foreach(var_04 in param_00)
	{
		var_04.var_C1 = 1;
		var_05 = 0;
		var_06 = 0;
		if(isdefined(var_04.var_ED6E))
		{
			var_05 = 1;
			var_07 = scripts\sp\_utility::func_5CC9(var_04);
			var_07 scripts\sp\_drone_base::func_5C21();
		}
		else if(isdefined(var_04.var_ED8A) || isdefined(var_04.var_ED1B))
		{
			var_05 = 1;
			var_07 = scripts\sp\_utility::func_2C17(var_04);
			var_07 lib_0B2B::func_6B15();
		}
		else if(isdefined(var_04.var_9F) && var_04.var_9F == "script_vehicle")
		{
			var_06 = 1;
			var_08 = spawn("script_model",(0,0,0));
			var_08 setmodel(var_04.model);
			var_08 method_83D0(#animtree);
			if(isdefined(var_04.var_EEC9))
			{
				var_08.var_EEC9 = var_04.var_EEC9;
			}

			var_08.var_9FEF = 1;
			var_08.var_1356F = var_04;
			var_07 = var_08;
		}
		else
		{
			var_09 = (isdefined(var_04.var_EECE) || isdefined(var_04.var_EED1)) && scripts\common\utility::flag("stealth_enabled") && !scripts\common\utility::flag("stealth_spotted");
			var_0A = var_04;
			if(isdefined(var_04.var_EEB6))
			{
				var_0A = lib_0B77::func_7C86(var_04,1);
			}

			if(isdefined(var_04.var_EDB3) || var_02)
			{
				var_07 = var_0A method_8393(var_09);
			}
			else
			{
				var_07 = var_0A method_80B5(var_09);
			}

			if(isdefined(var_04.var_EEB6))
			{
				if(isdefined(var_04.var_EEC9))
				{
					var_07.var_EEC9 = var_04.var_EEC9;
				}
			}
		}

		if(!var_05 && !var_06 && !isalive(var_07))
		{
			continue;
		}

		var_01[var_01.size] = var_07;
	}

	var_01 = func_E05D(var_01);
	return var_01;
}

//Function Number: 5
func_E05D(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!func_19E4(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 6
func_19E4(param_00)
{
	if(isalive(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.classname))
	{
		return 0;
	}

	return param_00.classname == "script_model";
}

//Function Number: 7
func_10725()
{
	if(scripts\sp\_utility::func_65DF("no_riders_until_unload") && !scripts\sp\_utility::func_65DB("no_riders_until_unload"))
	{
		return [];
	}

	var_00 = func_7D47();
	if(!var_00.size)
	{
		return [];
	}

	var_01 = [];
	var_02 = func_1063F(var_00);
	var_02 = func_1041B(var_02);
	foreach(var_04 in var_02)
	{
		thread scripts\sp\_vehicle_aianim::func_8739(var_04);
	}

	return var_02;
}

//Function Number: 8
func_10805(param_00)
{
	if(!isdefined(param_00))
	{
		return func_10725();
	}

	var_01 = func_7D47();
	if(!var_01.size)
	{
		return [];
	}

	var_02 = [];
	var_03 = self.classname;
	if(isdefined(level.var_131A0.var_116CE.var_12BCF[var_03]) && isdefined(level.var_131A0.var_116CE.var_12BCF[var_03][param_00]))
	{
		var_04 = level.var_131A0.var_116CE.var_12BCF[var_03][param_00];
		foreach(var_06 in var_04)
		{
			foreach(var_08 in var_01)
			{
				if(var_08.var_EEC9 == var_06)
				{
					var_02[var_02.size] = var_08;
				}
			}
		}

		var_0B = func_1063F(var_02);
		for(var_0C = 0;var_0C < var_04.size;var_0C++)
		{
			if(isdefined(var_0B[var_0C]))
			{
				var_0B[var_0C].var_EEC9 = var_04[var_0C];
			}
		}

		var_0B = func_1041B(var_0B);
		foreach(var_0E in var_0B)
		{
			thread scripts\sp\_vehicle_aianim::func_8739(var_0E);
		}

		return var_0B;
	}

	return func_10725();
}

//Function Number: 9
func_1041B(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.var_EEC9))
		{
			var_01[var_01.size] = var_04;
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return scripts\common\utility::array_combine(var_01,var_02);
}

//Function Number: 10
func_E0A7()
{
	wait(0.05);
	self.var_1323B = undefined;
}

//Function Number: 11
func_131F6(param_00)
{
	var_01 = param_00.classname;
	if(isdefined(level.var_131A0.var_116CE.var_1325B) && isdefined(level.var_131A0.var_116CE.var_1325B[var_01]))
	{
		param_00 thread [[ level.var_131A0.var_116CE.var_1325B[var_01] ]]();
		return;
	}

	if(isdefined(level.var_131A0.var_116CE.var_8E9D[var_01]))
	{
		foreach(var_03 in level.var_131A0.var_116CE.var_8E9D[var_01])
		{
			param_00 method_8187(var_03);
		}
	}

	if(param_00.var_380 == "empty" || param_00.var_380 == "empty_heli")
	{
		param_00 thread lib_0B98::func_8023();
		return;
	}

	param_00 scripts\sp\_utility::func_F294();
	if(!isdefined(param_00.var_B91F))
	{
		param_00.var_B91F = 0;
	}

	var_05 = param_00.var_380;
	param_00 func_13203();
	param_00 func_1322F();
	if(!isdefined(level.var_13261[param_00.var_380][param_00.classname]))
	{
	}

	param_00 thread [[ level.var_13261[param_00.var_380][param_00.classname] ]]();
	param_00 thread func_B248();
	param_00 thread func_D546();
	if(!isdefined(param_00.var_ED10))
	{
		param_00.var_ED10 = 0;
	}

	if(isdefined(level.var_131A0.var_5B65))
	{
		if(level.var_131A0.var_5B65)
		{
			param_00 method_83BC();
		}
	}

	param_00 scripts\sp\_utility::func_65E0("unloaded");
	param_00 scripts\sp\_utility::func_65E0("loaded");
	param_00 scripts\sp\_utility::func_65E0("landed");
	param_00.var_E4FB = [];
	param_00.var_12BD0 = [];
	param_00.var_12BBC = "default";
	param_00.var_6B9D = [];
	if(isdefined(level.var_131A0.var_116CE.var_247D) && isdefined(level.var_131A0.var_116CE.var_247D[var_01]))
	{
		var_06 = level.var_131A0.var_116CE.var_247D[var_01];
		var_07 = getarraykeys(var_06);
		foreach(var_09 in var_07)
		{
			param_00.var_6B9D[var_09] = undefined;
			param_00.var_6B9E[var_09] = 0;
		}
	}

	param_00 thread func_131AF();
	if(isdefined(param_00.var_EF04))
	{
		param_00 thread lib_0B97::func_ACCE(param_00.var_EF04);
	}

	if(isdefined(param_00.var_EDD1))
	{
		param_00.var_843F = 1;
	}

	param_00.var_4CF5 = [];
	param_00 thread func_740E();
	param_00 thread scripts\sp\_vehicle_aianim::func_88AE();
	if(isdefined(param_00.var_EDB8))
	{
		param_00 method_8363(param_00.var_EDB8,&"");
	}

	param_00 thread func_131EC();
	if(isdefined(param_00.var_ED6C))
	{
		param_00.var_5971 = 1;
	}

	param_00 thread func_1322A();
	param_00 thread lib_0B99::func_1324B();
	param_00 thread func_92D3();
	param_00 thread func_1F6E();
	if(isdefined(param_00.var_ED48))
	{
		param_00 thread lib_0B77::func_131C1();
	}

	param_00 thread func_B6B7();
	if(isdefined(level.var_131A0.var_1066A))
	{
		level thread [[ level.var_131A0.var_1066A ]](param_00);
	}

	if(isdefined(param_00.var_EEDE))
	{
		param_00 method_8364(param_00.var_EEDE);
	}

	param_00 thread func_5636();
	param_00 thread lib_0B98::func_8023();
	if(isdefined(level.var_9334))
	{
		var_0B = level.var_9334;
	}
	else
	{
		var_0B = 0;
	}

	if(param_00 func_8BFC() && !var_0B)
	{
		param_00 thread func_1A93();
	}

	if(param_00 method_83E2())
	{
		param_00.var_378 = "constrained";
		if(isdefined(param_00.var_EE7C))
		{
			param_00.var_378 = param_00.var_EE7C;
		}
	}

	param_00 func_10725();
	param_00 thread func_131FA();
}

//Function Number: 12
func_A5CB(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_4E1C) || !isdefined(level.var_131A0.var_116CE.var_4E1C[param_00]))
	{
		return;
	}

	if(isdefined(self.var_4E38))
	{
		var_01 = self.var_4E38;
	}
	else
	{
		var_01 = level.var_131A0.var_116CE.var_4E1C[var_01].var_B48B;
	}

	if(isdefined(self.var_4E39))
	{
		var_02 = self.var_4E39;
	}
	else
	{
		var_02 = level.var_131A0.var_116CE.var_4E1C[var_01].var_B758;
	}

	if(isdefined(level.var_131A0.var_116CE.var_4E1C[param_00].var_50AE))
	{
		wait(level.var_131A0.var_116CE.var_4E1C[param_00].var_50AE);
	}

	if(!isdefined(self))
	{
		return;
	}

	if(level.var_131A0.var_116CE.var_4E1C[param_00].var_2B19)
	{
		level.player method_80D0(0);
	}

	self radiusdamage(self.origin + level.var_131A0.var_116CE.var_4E1C[param_00].var_C364,level.var_131A0.var_116CE.var_4E1C[param_00].var_DCCA,var_01,var_02,self);
	if(level.var_131A0.var_116CE.var_4E1C[param_00].var_2B19)
	{
		level.player method_80D0(1);
	}
}

//Function Number: 13
func_131FA()
{
	self endon("nodeath_thread");
	var_00 = 0;
	for(;;)
	{
		self waittill("death",var_01,var_02,var_03);
		if(isdefined(self.var_4C49))
		{
			self thread [[ self.var_4C49 ]]();
		}

		if(!var_00)
		{
			var_00 = 1;
			if(isdefined(var_01) && isdefined(var_02))
			{
				var_01 scripts\sp\_player_stats::func_DEBD(self,var_02,var_03);
				if(isdefined(self.var_4D28))
				{
					self.var_4D28 = undefined;
				}
			}
		}

		self notify("clear_c4");
		if(isdefined(self.var_E7D2))
		{
			self.var_E7D2 delete();
		}

		if(isdefined(self.var_B6BD))
		{
			scripts\common\utility::func_22A1(self.var_B6BD,::func_129E4);
			self.var_B6BD = undefined;
		}

		if(!isdefined(self) || func_9BA8())
		{
			if(isdefined(self.var_E4FB))
			{
				foreach(var_05 in self.var_E4FB)
				{
					if(isdefined(var_05))
					{
						var_05 delete();
					}
				}
			}

			if(func_9BA8())
			{
				self.var_E4FB = [];
				continue;
			}

			self notify("delete_destructible");
			return;
		}

		var_07 = undefined;
		if(isdefined(self.var_1322C))
		{
			var_07 = self.var_1322C;
		}
		else if(isdefined(level.var_131A0.var_116CE.var_E7BA[self.classname]))
		{
			var_07 = level.var_131A0.var_116CE.var_E7BA[self.classname];
		}

		if(isdefined(var_07))
		{
			self stoprumble(var_07.var_E7BA);
		}

		if(isdefined(level.var_131A0.var_116CE.var_4E23[self.var_380]))
		{
			thread [[ level.var_131A0.var_116CE.var_4E23[self.var_380] ]]();
		}

		scripts\common\utility::func_22A1(self.var_E4FB,::scripts\sp\_vehicle_aianim::func_876B,var_01,self.var_380);
		thread func_A5CB(self.classname);
		thread func_A5BF(self.classname);
		thread lib_0B97::func_A5F2(self.classname);
		func_5144();
		if(isdefined(level.var_131A0.var_116CE.var_4E4E[self.classname]))
		{
			thread func_F331(level.var_131A0.var_116CE.var_4E4E[self.classname],level.var_131A0.var_131C3[self.classname]);
		}
		else if(isdefined(level.var_131A0.var_116CE.var_4E4E[self.model]))
		{
			thread func_F331(level.var_131A0.var_116CE.var_4E4E[self.model],level.var_131A0.var_131C3[self.model]);
		}

		var_08 = func_13233(self.model,var_01,var_02);
		var_09 = self.origin;
		var_0A = undefined;
		if(isdefined(var_01))
		{
			var_0A = self.origin - var_01.origin;
			var_0A = vectornormalize(var_0A);
		}

		thread func_A5CC(self.classname);
		thread func_12FB(self.model,var_08,var_0A);
		if(self.var_9F == "script_vehicle")
		{
			thread func_A5EE(self.classname);
		}

		if(isdefined(self.var_5179))
		{
			wait(0.05);
			if(!isdefined(self.var_5958) && !self method_83E2())
			{
				self disconnectpaths();
			}

			func_128C();
			wait(0.05);
			func_131D7(self.model);
			self delete();
			continue;
		}

		if(isdefined(self.var_736A))
		{
			self notify("newpath");
			if(!isdefined(self.var_5958))
			{
				self disconnectpaths();
			}

			func_131FB();
			func_128C();
			return;
		}

		func_131CE(self.model,var_01,var_02,var_08);
		if(!isdefined(self))
		{
			return;
		}

		if(!var_08)
		{
			var_09 = self.origin;
		}

		if(isdefined(level.var_131A0.var_116CE.var_4E02[self.classname]))
		{
			earthquake(level.var_131A0.var_116CE.var_4E02[self.classname].var_EB9C,level.var_131A0.var_116CE.var_4E02[self.classname].var_5F36,var_09,level.var_131A0.var_116CE.var_4E02[self.classname].var_257);
		}

		wait(0.5);
		if(func_9BA8())
		{
			continue;
		}

		if(isdefined(self))
		{
			while(isdefined(self.var_5960) && isdefined(self))
			{
				wait(0.05);
			}

			if(!isdefined(self))
			{
				continue;
			}

			if(self method_83E2())
			{
				while(isdefined(self) && self.var_37A != 0)
				{
					wait(1);
				}

				if(!isdefined(self))
				{
					return;
				}

				self disconnectpaths();
				self notify("kill_badplace_forever");
				self method_81D0();
				self notify("newpath");
				self method_83E8();
				return;
			}
			else
			{
				func_128C();
			}

			if(self.var_B91F)
			{
				self hide();
			}
		}

		if(func_143E())
		{
			self delete();
			continue;
		}
	}
}

//Function Number: 14
func_128C()
{
	self method_80F8();
	scripts\common\utility::func_5127(0.05,::func_6A4A);
}

//Function Number: 15
func_6A4A()
{
	self notify("newpath");
	self.accuracy = undefined;
	self.var_247C = undefined;
	self.var_24D2 = undefined;
	self.var_275B = undefined;
	self.var_275C = undefined;
	self.var_4BF0 = undefined;
	self.var_4BF7 = undefined;
	self.var_4CF5 = undefined;
	self.var_5107 = undefined;
	self.var_6B9D = undefined;
	self.var_7F1A = undefined;
	self.var_8C2D = undefined;
	self.var_8CB6 = undefined;
	self.var_C36E = undefined;
	self.var_C36F = undefined;
	self.var_E7BE = undefined;
	self.var_E7C0 = undefined;
	self.var_E7C6 = undefined;
	self.var_ED10 = undefined;
	self.var_ED22 = undefined;
	self.var_ED5D = undefined;
	self.var_27C = undefined;
	self.var_EE50 = undefined;
	self.var_EEDE = undefined;
	self.var_EEF2 = undefined;
	self.var_EEF8 = undefined;
	self.var_10707 = undefined;
	self.var_10708 = undefined;
	self.var_114CB = undefined;
	self.target = undefined;
	self.var_1152D = undefined;
	self.var_127FF = undefined;
	self.var_12800 = undefined;
	self.var_129DB = undefined;
	self.var_129DC = undefined;
	self.var_129DE = undefined;
	self.var_2756 = undefined;
	self.var_247E = undefined;
	self.var_2756 = undefined;
	self.var_E7CA = undefined;
	self.var_E7CB = undefined;
	self.var_E7D0 = undefined;
	self.var_E7D2 = undefined;
	self.var_E880 = undefined;
	self.var_EE5E = undefined;
	self.var_EEC8 = undefined;
	self.var_11659 = undefined;
	self.var_129DE = undefined;
	self.var_12A51 = undefined;
	self.var_12A52 = undefined;
	self.var_12A65 = undefined;
	self.var_12A7C = undefined;
	self.var_12A7D = undefined;
	self.var_12BA3 = undefined;
	self.var_12BBC = undefined;
	self.var_12BD0 = undefined;
	self.var_1307E = undefined;
	self.var_1323C = undefined;
	self.var_136FC = undefined;
	self.var_13BB6 = undefined;
	self.var_C373 = undefined;
	self.var_ECE5 = undefined;
	self.var_13D02 = undefined;
	self.var_5971 = undefined;
	self.var_5958 = undefined;
	self.var_EDD1 = undefined;
	self.var_65DB = undefined;
	self.var_6A0B = undefined;
	self.var_843F = undefined;
	self.var_380 = undefined;
	self.var_13244 = undefined;
	self.var_6231 = undefined;
	self.var_ED12 = undefined;
}

//Function Number: 16
func_143E()
{
	return isdefined(self.var_4828) && self.var_4828 == 1;
}

//Function Number: 17
func_131D7(param_00)
{
	if(isdefined(self.var_5946) && self.var_5946)
	{
		return;
	}

	self notify("death_finished");
	if(!isdefined(self))
	{
		return;
	}

	self method_83D0(#animtree);
	if(isdefined(level.var_131A0.var_116CE.var_5BC3[param_00]))
	{
		self method_806F(level.var_131A0.var_116CE.var_5BC3[param_00],0);
	}

	if(isdefined(level.var_131A0.var_116CE.var_5BC6[param_00]))
	{
		self method_806F(level.var_131A0.var_116CE.var_5BC6[param_00],0);
	}
}

//Function Number: 18
func_13233(param_00,param_01,param_02)
{
	if(!isdefined(self.var_1D63) || self.var_1D63 == 0)
	{
		if(isdefined(self.var_627C) && self.var_627C == 0)
		{
			return 0;
		}

		if(!isdefined(param_02))
		{
			return 0;
		}

		if(!param_02 == "MOD_PROJECTILE" || param_02 == "MOD_PROJECTILE_SPLASH")
		{
			return 0;
		}
	}

	if(isdefined(self.var_9B65) && self.var_9B65)
	{
		return 1;
	}

	return func_131ED(param_00);
}

//Function Number: 19
func_131ED(param_00)
{
	return isdefined(level.var_131A0.var_116CE.var_131BC["rocket_death" + self.classname]) && isdefined(self.var_627C) && self.var_627C == 1;
}

//Function Number: 20
func_131CE(param_00,param_01,param_02,param_03)
{
	var_04 = "tank";
	if(self method_83E2())
	{
		var_04 = "physics";
	}
	else if(func_12F8())
	{
		var_04 = "helicopter";
	}
	else if(isdefined(self.var_4BF7))
	{
		var_04 = "none";
	}

	switch(var_04)
	{
		case "helicopter":
			thread func_8DA7(param_01,param_02,param_03);
			break;

		case "tank":
			if(!isdefined(self.var_E683))
			{
				self method_83E5(0,25);
			}
			else
			{
				self method_83E5(8,25);
				self waittill("deathrolloff");
				self method_83E5(0,25);
			}
	
			self notify("deadstop");
			if(!isdefined(self.var_5958))
			{
				self disconnectpaths();
			}
	
			if(isdefined(self.var_114E0) && self.var_114E0 > 0)
			{
				self waittill("animsdone");
			}
			break;

		case "physics":
			self method_83EF();
			self notify("deadstop");
			if(!isdefined(self.var_5958))
			{
				self disconnectpaths();
			}
	
			if(isdefined(self.var_114E0) && self.var_114E0 > 0)
			{
				self waittill("animsdone");
			}
			break;
	}

	if(isdefined(level.var_131A0.var_116CE.var_8B8F[param_00]) && level.var_131A0.var_116CE.var_8B8F[param_00])
	{
		self method_8080();
	}

	if(func_12F8())
	{
		if(isdefined(self.var_4828) && self.var_4828 == 1)
		{
			self waittill("crash_done");
		}
	}
	else
	{
		while(!func_9BA8() && isdefined(self) && self method_83DD() > 0)
		{
			wait(0.1);
		}
	}

	self notify("stop_looping_death_fx");
	func_131D7(param_00);
}

//Function Number: 21
func_9BA8()
{
	var_00 = 0;
	if(isdefined(self) && self.classname == "script_vehicle_corpse")
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 22
func_F331(param_00,param_01)
{
	if(isdefined(self.var_10268) && self.var_10268)
	{
		return;
	}

	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_412A))
	{
		self method_806F(%root,0);
	}

	if(isdefined(self))
	{
		self setmodel(param_00);
	}
}

//Function Number: 23
func_8DA7(param_00,param_01,param_02)
{
	if(isdefined(param_00) && isplayer(param_00))
	{
		self.var_C720 = param_00;
	}

	self.var_4828 = 1;
	if(!isdefined(self))
	{
		return;
	}

	func_5389();
	if(!param_02)
	{
		thread func_8DAB(param_00,param_01);
	}
}

//Function Number: 24
func_A60E(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.var_E500) && !isdefined(var_02.var_5BD6))
		{
			continue;
		}

		if(isdefined(var_02.var_B14F))
		{
			var_02 scripts\sp\_utility::func_1101B();
		}

		var_02 method_81D0();
	}
}

//Function Number: 25
func_13225(param_00,param_01)
{
	if(isdefined(self.var_1321D) && self.var_1321D != 0)
	{
		return;
	}

	self.health = 1;
	param_00 endon("death");
	self.var_2894 = 0.15;
	self waittill("death");
	param_00 notify("driver_died");
	func_A60E(param_01);
}

//Function Number: 26
func_131B0()
{
	self endon("death");
	self endon("enable_spline_path");
	waittillframeend;
	self.var_E4FB = scripts\sp\_utility::func_DFEB(self.var_E4FB);
	if(self.var_E4FB.size)
	{
		scripts\common\utility::array_thread(self.var_E4FB,::func_13225,self,self.var_E4FB);
		scripts\common\utility::waittill_either("veh_collision","driver_died");
		func_A60E(self.var_E4FB);
		wait(0.25);
	}

	self notify("script_crash_vehicle");
	self method_83EF();
}

//Function Number: 27
func_143F(param_00,param_01)
{
	self endon("death");
	self notify("newpath");
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	self method_8316(param_00);
	self method_82F6(0,0,0);
	self method_8075();
	self method_8348(scripts\common\utility::func_6EE1(self.angles)[1]);
	if(isdefined(self.var_12BC2))
	{
		func_13E1(scripts\sp\_utility::func_864C(self.origin) + (0,0,self.var_12BC2),1);
	}
	else
	{
		func_13E1(scripts\sp\_utility::func_864C(self.origin),1);
	}

	self waittill("goal");
}

//Function Number: 28
func_13200(param_00,param_01)
{
	self endon("death");
	if(!isdefined(level.var_131A0.var_116CE.var_A7C5[self.classname]))
	{
		return;
	}

	var_02 = level.var_131A0.var_116CE.var_A7C5[self.classname];
	foreach(var_04 in var_02)
	{
		self method_82A2(var_04.var_1B0,1,0.2,1);
	}

	if(!param_01)
	{
		return;
	}

	if(isdefined(param_00))
	{
		self waittill("unloaded");
	}
	else
	{
		self waittill("continuepath");
	}

	foreach(var_04 in var_02)
	{
		self method_806F(var_04.var_1B0,0);
		self method_82A2(var_04.var_11472,1,0.2,1);
	}
}

//Function Number: 29
func_13201(param_00,param_01)
{
	return func_143F(param_00,param_01);
}

//Function Number: 30
func_10809(param_00)
{
	if(level.var_650D.size >= 8)
	{
		return;
	}

	var_01 = scripts\sp\_utility::func_10808();
	if(isdefined(param_00))
	{
		var_01 method_83F4(param_00);
	}

	var_01 thread func_131B0();
	var_01 endon("death");
	var_01.var_5971 = 1;
	var_01 lib_0B98::func_845A(var_01);
	var_01 func_AB23();
}

//Function Number: 31
func_AB23()
{
	self endon("script_crash_vehicle");
	scripts\common\utility::waittill_either("enable_spline_path","reached_end_node");
	var_00 = func_7B03(self.origin);
	if(isdefined(level.var_5BC2))
	{
		var_00 thread [[ level.var_5BC2 ]](self);
	}
}

//Function Number: 32
func_7B03(param_00)
{
	param_00 = (param_00[0],param_00[1],0);
	var_01 = scripts\common\utility::func_782F(param_00,level.var_103D0);
	var_02 = [];
	for(var_03 = 0;var_03 < 3;var_03++)
	{
		var_02[var_03] = var_01[var_03];
	}

	foreach(var_05 in level.var_103D0)
	{
		foreach(var_07 in var_02)
		{
			if(var_07 == var_05)
			{
				return var_07;
			}
		}
	}
}

//Function Number: 33
func_13804(param_00)
{
	var_01 = 12;
	var_02 = 400;
	var_03 = gettime() + var_02;
	while(isdefined(self))
	{
		if(abs(self.angles[0]) > var_01 || abs(self.angles[2]) > var_01)
		{
			var_03 = gettime() + var_02;
		}

		if(gettime() > var_03)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 34
func_143C()
{
	if(!isdefined(self.var_ED12))
	{
		return;
	}

	function_0277(self.var_12BA3 + "vehicle_badplace",-1,self,"allies","axis");
}

//Function Number: 35
func_1446(param_00)
{
	self notify("unloading");
	var_01 = [];
	if(scripts\sp\_utility::func_65DF("no_riders_until_unload"))
	{
		scripts\sp\_utility::func_65E1("no_riders_until_unload");
		var_01 = func_10805(param_00);
		foreach(var_03 in var_01)
		{
			scripts\sp\_utility::func_106ED(var_03);
		}

		waittillframeend;
	}

	if(isdefined(param_00))
	{
		self.var_12BBC = param_00;
	}

	foreach(var_06 in self.var_E4FB)
	{
		if(isalive(var_06))
		{
			var_06 notify("unload");
		}
	}

	var_01 = scripts\sp\_vehicle_aianim::func_1F74("unload");
	var_08 = level.var_131A0.var_116CE.var_12BCF[self.classname];
	if(isdefined(var_08))
	{
		var_01 = [];
		var_09 = scripts\sp\_vehicle_aianim::func_7D2F();
		foreach(var_0B in self.var_E4FB)
		{
			if(isdefined(var_09[var_0B.var_1321D]))
			{
				var_01[var_01.size] = var_0B;
			}
		}
	}

	return var_01;
}

//Function Number: 36
func_13E1(param_00,param_01)
{
	if(self.health <= 0)
	{
		return;
	}

	if(isdefined(self.var_C737))
	{
		param_00 = param_00 + (0,0,self.var_C737);
	}

	self method_8362(param_00,param_01);
}

//Function Number: 37
func_8DAB(param_00,param_01)
{
	self endon("in_air_explosion");
	if(isdefined(self.var_CA16))
	{
		var_02 = self.var_CA16;
	}
	else
	{
		var_03 = func_7D31();
		var_02 = scripts\common\utility::getclosest(self.origin,var_03);
	}

	var_02.var_3FF2 = 1;
	self notify("newpath");
	self notify("deathspin");
	var_04 = 0;
	var_05 = 0;
	if(isdefined(var_02.var_EE79) && var_02.var_EE79 == "direct")
	{
		var_05 = 1;
	}

	if(isdefined(self.var_8D3C))
	{
		var_05 = 0;
		var_04 = self.var_8D3C;
	}

	if(var_05)
	{
		var_06 = 60;
		self method_83E5(var_06,15,10);
		self method_8316(var_02.var_257);
		self method_8362(var_02.origin,0);
		thread func_8DA9(var_02.origin,var_06);
		scripts\common\utility::waittill_any_3("goal","near_goal");
		func_8DAC(var_02);
	}
	else
	{
		var_07 = (var_02.origin[0],var_02.origin[1],self.origin[2] + var_04);
		if(isdefined(self.var_8D3D))
		{
			var_07 = self.origin + self.var_8D3D * self vehicle_getvelocity();
			var_07 = (var_07[0],var_07[1],var_07[2] + var_04);
		}

		self method_83E5(40,10,10);
		self method_8316(300);
		self method_8362(var_07,1);
		thread func_8DA9(var_07,40);
		var_08 = "blank";
		while(var_08 != "death")
		{
			var_08 = scripts\common\utility::waittill_any_3("goal","near_goal","death");
			if(!isdefined(var_08) && !isdefined(self))
			{
				var_02.var_3FF2 = undefined;
				self notify("crash_done");
				return;
			}
			else
			{
				var_08 = "death";
			}
		}

		self method_8362(var_02.origin,0);
		self waittill("goal");
		func_8DAC(var_02);
	}

	var_02.var_3FF2 = undefined;
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
}

//Function Number: 38
func_8DAC(param_00)
{
	self endon("death");
	while(isdefined(param_00.target))
	{
		param_00 = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_01 = 56;
		if(isdefined(param_00.var_257))
		{
			var_01 = param_00.var_257;
		}

		self method_8316(var_01);
		self method_8362(param_00.origin,0);
		scripts\common\utility::waittill_any_3("goal","near_goal");
	}
}

//Function Number: 39
func_8DA9(param_00,param_01)
{
	self endon("crash_done");
	self method_8076();
	var_02 = 0;
	if(isdefined(self.var_D831))
	{
		var_02 = self.var_D831;
		if(self.var_D831 < 0)
		{
			var_03 = [1,2,2];
			var_04 = 5;
			var_05 = randomint(var_04);
			var_06 = 0;
			foreach(var_09, var_08 in var_03)
			{
				var_06 = var_06 + var_08;
				if(var_05 < var_06)
				{
					var_02 = var_09;
					break;
				}
			}
		}
	}

	switch(var_02)
	{
		case 1:
			thread func_8DAE();
			break;

		case 2:
			thread func_8DA8(param_00,param_01);
			break;

		case 3:
			thread func_8DB0();
			break;

		case 0:
		default:
			thread func_8DAD();
			break;
	}
}

//Function Number: 40
func_8DB0()
{
	self notify("crash_done");
	self notify("in_air_explosion");
}

//Function Number: 41
func_8DA8(param_00,param_01)
{
	self endon("crash_done");
	self method_8076();
	self method_830A(randomintrange(20,90),randomintrange(5,90));
	self method_8378(400,100,100);
	var_02 = 90 * randomintrange(-2,3);
	for(;;)
	{
		var_03 = param_00 - self.origin;
		var_04 = vectortoyaw(var_03);
		var_04 = var_04 + var_02;
		self method_8348(var_04);
		wait(0.1);
	}
}

//Function Number: 42
func_8DAE()
{
	self endon("crash_done");
	self method_8076();
	self method_8378(400,100,100);
	var_00 = randomint(2);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_01 = randomintrange(20,120);
		if(var_00)
		{
			self method_8348(self.angles[1] + var_01);
		}
		else
		{
			self method_8348(self.angles[1] - var_01);
		}

		var_00 = 1 - var_00;
		var_02 = randomfloatrange(0.5,1);
		wait(var_02);
	}
}

//Function Number: 43
func_8DAD()
{
	self endon("crash_done");
	self method_8076();
	self method_8378(400,100,100);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_00 = randomintrange(90,120);
		self method_8348(self.angles[1] + var_00);
		wait(0.5);
	}
}

//Function Number: 44
func_7D31()
{
	var_00 = [];
	level.var_131A0.var_8DAA = scripts\common\utility::func_22BC(level.var_131A0.var_8DAA);
	foreach(var_02 in level.var_131A0.var_8DAA)
	{
		if(isdefined(var_02.var_3FF2))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 45
func_5389()
{
	if(!isdefined(self.var_6B9D))
	{
		return;
	}

	if(!self.var_6B9D.size)
	{
		return;
	}

	var_00 = getarraykeys(self.var_6B9D);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		self.var_6B9D[var_00[var_01]] unlink();
	}
}

//Function Number: 46
func_131FB()
{
	self notify("kill_badplace_forever");
}

//Function Number: 47
func_A5EE(param_00)
{
	if(isdefined(level.var_131A0.var_116CE.var_4E12[param_00]))
	{
		self.var_5960 = 1;
		wait(level.var_131A0.var_116CE.var_4E12[param_00].var_50AE);
	}

	if(!isdefined(self))
	{
		return;
	}

	self method_81CD(self.origin + (23,33,64),3);
	wait(2);
	if(!isdefined(self))
	{
		return;
	}

	self.var_5960 = undefined;
}

//Function Number: 48
func_9DC0()
{
	if(!isdefined(self))
	{
		return 0;
	}

	return isdefined(self.var_ED);
}

//Function Number: 49
func_12FC(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = self method_8123();
		var_02 = vectornormalize(var_02);
		param_00 = vectornormalize(param_00);
		var_03 = vectorlerp(var_02,param_00,param_01);
		return var_03;
	}

	return undefined;
}

//Function Number: 50
func_12FB(param_00,param_01,param_02)
{
	if(func_9DC0() || isdefined(self.var_9B65) && self.var_9B65)
	{
		return;
	}

	level notify("vehicle_explosion",self.origin);
	self notify("explode",self.origin);
	if(isdefined(self.var_9310) && self.var_9310)
	{
		return;
	}

	var_03 = self.var_380;
	var_04 = self.classname;
	if(param_01)
	{
		var_04 = "rocket_death" + var_04;
	}

	foreach(var_06 in level.var_131A0.var_116CE.var_131BC[var_04])
	{
		thread func_A5E1(param_00,var_06,var_03,param_02);
	}
}

//Function Number: 51
func_A5E1(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.var_136A1))
	{
		if(param_01.var_136A1 >= 0)
		{
			wait(param_01.var_136A1);
		}
		else
		{
			self waittill("death_finished");
		}
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01.var_C174))
	{
		self notify(param_01.var_C174);
	}

	if(isdefined(param_01.var_F1EA))
	{
		scripts\common\utility::delaycall(param_01.var_F1EA,::delete);
	}

	if(isdefined(param_01.var_5FDF))
	{
		if(param_01.var_2A4E && !isdefined(self.var_5179))
		{
			if(isdefined(param_01.var_2DD))
			{
				if(isdefined(param_01.var_10E6A) && param_01.var_10E6A == 1)
				{
					thread func_B03F(param_01.var_5FDF,param_01.var_50AE,param_01.var_2DD);
				}
				else
				{
					thread func_D4C4(param_01.var_5FDF,param_01.var_50AE,param_01.var_2DD);
				}
			}
			else
			{
				var_04 = self.origin + (0,0,100) - self.origin;
				playfx(param_01.var_5FDF,self.origin,var_04);
			}
		}
		else if(isdefined(param_01.var_2DD))
		{
			var_04 = func_12FC(param_03,param_01.var_24DF);
			if(isdefined(var_04))
			{
				var_05 = func_4E49();
				playfx(param_01.var_5FDF,var_05 gettagorigin(param_01.var_2DD),var_04);
				if(isdefined(param_01.var_DFEC))
				{
					var_05 scripts\common\utility::delaycall(param_01.var_DFEC,::delete);
				}
			}
			else
			{
				playfxontag(param_01.var_5FDF,func_4E49(),param_01.var_2DD);
				if(isdefined(param_01.var_DFEC))
				{
					func_4E49() scripts\common\utility::delaycall(param_01.var_DFEC,::delete);
				}
			}
		}
		else
		{
			var_04 = func_12FC(var_04,param_02.var_24DF);
			if(isdefined(var_04))
			{
				playfx(param_01.var_5FDF,self.origin,var_04);
			}
			else
			{
				var_04 = self.origin + (0,0,100) - self.origin;
				playfx(param_01.var_5FDF,self.origin,var_04);
			}
		}
	}

	if(isdefined(param_01.var_10453) && !isdefined(self.var_5179))
	{
		if(param_01.var_312E)
		{
			thread func_4E05(param_01.var_10453);
			return;
		}

		scripts\common\utility::play_sound_in_space(param_01.var_10453);
	}
}

//Function Number: 52
func_B03F(param_00,param_01,param_02)
{
	self endon("stop_looping_death_fx");
	while(isdefined(self))
	{
		playfxontag(param_00,func_4E49(),param_02);
		wait(param_01);
	}
}

//Function Number: 53
func_4E05(param_00)
{
	thread scripts\sp\_utility::func_CD81(param_00,undefined,0,1);
	scripts\common\utility::waittill_any_3("fire_extinguish","stop_crash_loop_sound");
	if(!isdefined(self))
	{
		return;
	}

	self notify("stop sound" + param_00);
}

//Function Number: 54
func_4E49()
{
	if(isdefined(self.var_4E0A) && self.var_4E0A)
	{
		return self;
	}

	if(!isdefined(self.var_4E49))
	{
		var_00 = spawn("script_model",(0,0,0));
		var_00 setmodel(self.model);
		var_00.origin = self.origin;
		var_00.angles = self.angles;
		var_00 notsolid();
		var_00 hide();
		var_00 linkto(self);
		self.var_4E49 = var_00;
	}
	else
	{
		self.var_4E49 setmodel(self.model);
	}

	return self.var_4E49;
}

//Function Number: 55
func_D4C4(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",self.origin);
	self endon("fire_extinguish");
	thread func_D4C5(param_02,var_03);
	for(;;)
	{
		playfx(param_00,var_03.origin,var_03.var_12F93);
		wait(param_01);
	}
}

//Function Number: 56
func_D4C5(param_00,param_01)
{
	param_01.angles = self gettagangles(param_00);
	param_01.origin = self gettagorigin(param_00);
	param_01.var_7337 = anglestoforward(param_01.angles);
	param_01.var_12F93 = anglestoup(param_01.angles);
	while(isdefined(self) && self.var_9F == "script_vehicle" && self method_83DD() > 0)
	{
		param_01.angles = self gettagangles(param_00);
		param_01.origin = self gettagorigin(param_00);
		param_01.var_7337 = anglestoforward(param_01.angles);
		param_01.var_12F93 = anglestoup(param_01.angles);
		wait(0.05);
	}
}

//Function Number: 57
func_A5BF(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_4DFC[param_00]))
	{
		return;
	}

	var_01 = level.var_131A0.var_116CE.var_4DFC[param_00];
	if(isdefined(var_01.var_50AE))
	{
		wait(var_01.var_50AE);
	}

	if(!isdefined(self))
	{
		return;
	}

	badplace_cylinder("vehicle_kill_badplace",var_01.var_5F36,self.origin,var_01.var_257,var_01.height,var_01.var_115A4,var_01.var_115A5);
}

//Function Number: 58
func_129E4(param_00)
{
	if(isdefined(self))
	{
		if(isdefined(param_00.var_51AD))
		{
			wait(param_00.var_51AD);
		}
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 59
func_12B8(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_03 = 1;
		var_04 = getentarray(param_00,param_01);
	}
	else
	{
		var_03 = 0;
		var_04 = getentarray("script_vehicle","code_classname");
	}

	foreach(var_06 in var_04)
	{
		if(var_03 && var_06.var_9F != "script_vehicle")
		{
			continue;
		}

		if(isspawner(var_06))
		{
			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 60
func_1322D(param_00)
{
	foreach(var_02 in self.var_E4FB)
	{
		if(isai(var_02))
		{
			var_02 scripts\sp\_utility::func_F3B5(param_00);
			continue;
		}

		if(isdefined(var_02.spawner))
		{
			var_02.spawner.var_EDAD = param_00;
			continue;
		}
	}
}

//Function Number: 61
func_12E33(param_00)
{
	if(param_00.var_12E3C == gettime())
	{
		return param_00.var_10F82;
	}

	param_00.var_12E3C = gettime();
	if(param_00.var_10F83)
	{
		var_01 = clamp(0 - param_00.angles[2],0 - param_00.var_10F85,param_00.var_10F85) / param_00.var_10F85;
		if(isdefined(param_00.var_AAF3) && param_00.var_AAF3)
		{
			var_02 = param_00 method_83DE();
			var_02 = var_02 * -1;
			var_01 = var_01 + var_02;
			if(var_01 != 0)
			{
				var_03 = 1 / abs(var_01);
				if(var_03 < 1)
				{
					var_01 = var_01 * var_03;
				}
			}
		}

		var_04 = var_01 - param_00.var_10F82;
		if(var_04 != 0)
		{
			var_05 = param_00.var_10F84 / abs(var_04);
			if(var_05 < 1)
			{
				var_04 = var_04 * var_05;
			}

			param_00.var_10F82 = param_00.var_10F82 + var_04;
		}
	}
	else
	{
		param_00.var_10F82 = 0;
	}

	return param_00.var_10F82;
}

//Function Number: 62
func_79D5(param_00)
{
	return scripts\common\utility::getstruct(param_00,"targetname");
}

//Function Number: 63
func_79D3(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(isdefined(var_01) && var_01.size > 0)
	{
		return var_01[randomint(var_01.size)];
	}

	return undefined;
}

//Function Number: 64
func_79D7(param_00)
{
	return getvehiclenode(param_00,"targetname");
}

//Function Number: 65
func_F471(param_00)
{
	var_01 = getent(param_00.var_EE01,"script_linkname");
	if(!isdefined(var_01))
	{
		return;
	}

	self method_8305(var_01);
	self.var_F472 = 1;
}

//Function Number: 66
func_4CFC()
{
	level.var_2184 = 0;
	self.var_56DE = 0;
	thread func_4CFE();
	while(isdefined(self))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(isdefined(self.var_8BA9))
		{
			continue;
		}

		var_04 = tolower(var_04);
		switch(var_04)
		{
			case "bullet":
			case "mod_rifle_bullet":
			case "mod_pistol_bullet":
				if(!level.var_2184)
				{
					if(isdefined(level.var_11829) && level.var_11829 > 0)
					{
						break;
					}
	
					level.var_2184 = 1;
					self.var_56DE = 1;
					var_01 scripts\sp\_utility::func_56BA("invulerable_bullets");
					wait(4);
					level.var_2184 = 0;
					if(isdefined(self))
					{
						self.var_56DE = 0;
					}
	
					break;
				}
	
				break;
		}
	}
}

//Function Number: 67
func_4CFD()
{
	level.var_2184 = 0;
	self.var_56DE = 0;
	thread func_4CFE();
	while(isdefined(self))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(isdefined(self.var_8BA9))
		{
			continue;
		}

		var_04 = tolower(var_04);
		switch(var_04)
		{
			case "mod_grenade_splash":
			case "mod_grenade":
			case "bullet":
			case "mod_rifle_bullet":
			case "mod_pistol_bullet":
				if(!level.var_2184)
				{
					if(isdefined(level.var_11829) && level.var_11829 > 0)
					{
						break;
					}
	
					level.var_2184 = 1;
					self.var_56DE = 1;
					if(var_04 == "mod_grenade" || var_04 == "mod_grenade_splash")
					{
						var_01 scripts\sp\_utility::func_56BA("invulerable_frags");
					}
					else
					{
						var_01 scripts\sp\_utility::func_56BA("invulerable_bullets");
					}
	
					wait(4);
					level.var_2184 = 0;
					if(isdefined(self))
					{
						self.var_56DE = 0;
					}
	
					break;
				}
	
				break;
		}
	}
}

//Function Number: 68
func_4CFE()
{
	self waittill("death");
	if(self.var_56DE)
	{
		level.var_2184 = 0;
	}
}

//Function Number: 69
func_1A93(param_00)
{
	self endon("death");
	self endon("death_finished");
	self notify("stop_kicking_up_dust");
	self endon("stop_kicking_up_dust");
	var_01 = 2000;
	if(isdefined(level.var_126F3))
	{
		var_01 = level.var_126F3;
	}

	var_02 = 80 / var_01;
	var_03 = 0.5;
	if(func_12F6())
	{
		var_03 = 0.15;
	}

	var_04 = self;
	if(isdefined(param_00))
	{
		var_04 = param_00;
	}

	var_05 = 3;
	for(;;)
	{
		wait(var_03);
		if(1)
		{
			if(isdefined(self.var_55A4) && self.var_55A4)
			{
				continue;
			}

			if(isdefined(self.var_126F3))
			{
				var_01 = self.var_126F3;
			}

			var_06 = anglestoup(var_04.angles) * -1;
			var_07 = undefined;
			var_05++;
			if(var_05 > 3)
			{
				var_05 = 3;
				var_07 = scripts\common\trace::func_DCED(var_04.origin,var_04.origin + var_06 * var_01,var_04,undefined,1);
			}

			if(var_07["fraction"] == 1 || var_07["fraction"] < var_02)
			{
				continue;
			}

			var_08 = distance(var_04.origin,var_07["position"]);
			var_09 = func_7D53(self,var_07,var_06,var_08);
			if(!isdefined(var_09))
			{
				continue;
			}

			var_03 = var_08 - 350 / var_01 - 350 * 0.1 + 0.05;
			var_03 = max(var_03,0.05);
			if(!isdefined(var_07))
			{
				continue;
			}

			if(!isdefined(var_07["position"]))
			{
				continue;
			}

			var_0A = var_07["position"];
			var_0B = var_07["normal"];
			var_08 = vectordot(var_0A - var_04.origin,var_0B);
			var_0C = var_04.origin + (0,0,var_08);
			var_0D = var_0A - var_0C;
			if(isdefined(self.var_126F4))
			{
				var_0D = var_0A - level.player.origin;
			}

			if(vectordot(var_07["normal"],(0,0,1)) == -1)
			{
				continue;
			}

			if(length(var_0D) < 1)
			{
				var_0D = var_04.angles + (0,180,0);
			}

			playfx(var_09,var_0A,var_0B,var_0D);
		}
	}
}

//Function Number: 70
func_7D53(param_00,param_01,param_02,param_03)
{
	var_04 = param_01["surfacetype"];
	var_05 = undefined;
	var_06 = vectordot((0,0,-1),param_02);
	if(var_06 >= 0.97)
	{
		var_05 = undefined;
	}
	else if(var_06 >= 0.92)
	{
		var_05 = "_bank";
	}
	else
	{
		var_05 = "_bank_lg";
	}

	return func_7D52(param_00.classname,var_04,var_05);
}

//Function Number: 71
func_7D52(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = param_01 + param_02;
		if(!isdefined(level.var_131A0.var_116CE.var_112D9[param_00][var_03]) && param_01 != "default")
		{
			return func_7D52(param_00,"default",param_02);
		}
		else
		{
			return level.var_131A0.var_116CE.var_112D9[param_00][var_03];
		}
	}

	return func_7D44(param_00,param_01);
}

//Function Number: 72
func_7D44(param_00,param_01)
{
	if(!isdefined(level.var_131A0.var_116CE.var_112D9[param_00][param_01]) && param_01 != "default")
	{
		return func_7D44(param_00,"default");
	}
	else
	{
		return level.var_131A0.var_116CE.var_112D9[param_00][param_01];
	}

	return undefined;
}

//Function Number: 73
func_C018()
{
	return func_12F8() || func_12F6();
}

//Function Number: 74
func_12F8()
{
	return isdefined(level.var_131A0.var_116CE.var_8DB1[self.var_380]);
}

//Function Number: 75
func_12F6()
{
	return isdefined(level.var_131A0.var_116CE.var_1AE5[self.var_380]);
}

//Function Number: 76
func_8BFC()
{
	if(!func_12F8() && !func_12F6())
	{
		return 0;
	}

	return 1;
}

//Function Number: 77
func_8BFD()
{
	if(!isdefined(self.var_380))
	{
		return 0;
	}

	if(self.var_380 == "cobra")
	{
		return 1;
	}

	if(self.var_380 == "cobra_player")
	{
		return 1;
	}

	if(self.var_380 == "viper")
	{
		return 1;
	}

	return 0;
}

//Function Number: 78
func_5636()
{
	self endon("death");
	var_00 = 0;
	if(isdefined(self.var_ED5D) && !self.var_ED5D)
	{
		var_00 = 1;
	}

	if(var_00)
	{
		self.var_5958 = 1;
		return;
	}

	wait(randomfloat(1));
	while(isdefined(self))
	{
		if(self method_83DD() < 1)
		{
			if(!isdefined(self.var_5958))
			{
				self disconnectpaths();
			}
			else
			{
			}

			self notify("speed_zero_path_disconnect");
			while(self method_83DD() < 1)
			{
				if(isdefined(self.var_5958) && self.var_5958)
				{
					break;
				}

				wait(0.05);
			}
		}

		self connectpaths();
		wait(1);
	}
}

//Function Number: 79
func_B6B7()
{
	var_00 = self.classname;
	if(isdefined(self.var_EE5E) && self.var_EE5E > 0)
	{
		return;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_B6BD[var_00]))
	{
		return;
	}

	var_01 = 0;
	if(isdefined(self.var_EE14))
	{
		var_01 = self.var_EE14;
	}

	var_02 = level.var_131A0.var_116CE.var_B6BD[var_00];
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = isdefined(self.script_noteworthy) && self.script_noteworthy == "onemg";
	var_04 = "";
	if(isdefined(self.var_EEF9))
	{
		var_04 = self.var_EEF9;
	}

	foreach(var_08, var_06 in var_02)
	{
		if(isdefined(var_06.var_DE46) && !issubstr(var_04,var_06.var_DE46))
		{
			continue;
		}

		var_07 = spawnturret("misc_turret",(0,0,0),var_06.var_94B8);
		if(isdefined(var_06.var_C367))
		{
			var_07 linkto(self,var_06.var_2DD,var_06.var_C367,(0,-1 * var_01,0));
		}
		else
		{
			var_07 linkto(self,var_06.var_2DD,(0,0,0),(0,-1 * var_01,0));
		}

		var_07 setmodel(var_06.model);
		var_07.angles = self.angles;
		var_07.var_9FF0 = 1;
		var_07.var_C841 = self;
		var_07.var_EEDE = self.var_EEDE;
		var_07 thread scripts\sp\_mgturret::func_32B7();
		var_07 makeunusable();
		func_F5D8(var_07);
		level thread scripts\sp\_mgturret::func_B6A7(var_07,scripts\sp\_utility::func_7E72());
		if(isdefined(self.var_ED98))
		{
			var_07.var_ED98 = self.var_ED98;
		}

		if(isdefined(var_06.var_51AD))
		{
			var_07.var_51AD = var_06.var_51AD;
		}

		if(isdefined(var_06.var_1D2))
		{
			var_07.var_1D2 = var_06.var_1D2;
		}

		if(isdefined(var_06.var_5035))
		{
			var_07 method_82D1(var_06.var_5035);
		}

		if(isdefined(var_06.var_DE46))
		{
			var_07.var_DE46 = var_06.var_DE46;
		}

		self.var_B6BD[var_08] = var_07;
		if(var_03)
		{
			break;
		}
	}

	foreach(var_0B, var_07 in self.var_B6BD)
	{
		var_0A = level.var_131A0.var_116CE.var_B6BD[var_00][var_0B].var_5041;
		if(isdefined(var_0A))
		{
			var_07 func_12A29(var_0A);
		}
	}

	if(!isdefined(self.var_EEF8))
	{
		self.var_EEF8 = 1;
	}

	if(self.var_EEF8 == 0)
	{
		thread func_134C();
		return;
	}

	self.var_EEF8 = 1;
	thread func_134D();
}

//Function Number: 80
func_12A29(param_00)
{
	self.var_5041 = param_00;
}

//Function Number: 81
func_F5D8(param_00)
{
	switch(self.var_EEDE)
	{
		case "friendly":
		case "allies":
			param_00 method_835E("allies");
			break;

		case "enemy":
		case "axis":
			param_00 method_835E("axis");
			break;

		case "team3":
			param_00 method_835E("team3");
			break;

		default:
			break;
	}
}

//Function Number: 82
func_1F6E()
{
	self endon("suspend_drive_anims");
	if(!isdefined(self.var_13D02))
	{
		self.var_13D02 = 1;
	}

	var_00 = self.model;
	var_01 = -1;
	var_02 = undefined;
	self method_83D0(#animtree);
	if(!isdefined(level.var_131A0.var_116CE.var_5BC3[var_00]))
	{
		return;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_5BC6[var_00]))
	{
		level.var_131A0.var_116CE.var_5BC6[var_00] = level.var_131A0.var_116CE.var_5BC3[var_00];
	}

	self endon("death");
	var_03 = level.var_131A0.var_116CE.var_5BC5[var_00];
	var_04 = 1;
	if(isdefined(level.var_131A0.var_116CE.var_5BC4) && isdefined(level.var_131A0.var_116CE.var_5BC4[var_00]))
	{
		var_04 = level.var_131A0.var_116CE.var_5BC4[var_00];
	}

	var_05 = self.var_13D02;
	var_06 = level.var_131A0.var_116CE.var_5BC3[var_00];
	for(;;)
	{
		if(!var_03)
		{
			if(isdefined(self.var_112FB))
			{
				wait(0.05);
				continue;
			}

			self method_82A2(level.var_131A0.var_116CE.var_5BC3[var_00],1,0.2,var_04);
			return;
		}

		var_07 = self method_83DD();
		if(var_05 != self.var_13D02)
		{
			var_08 = 0;
			if(self.var_13D02)
			{
				var_06 = level.var_131A0.var_116CE.var_5BC3[var_00];
				var_08 = 1 - func_7B21(level.var_131A0.var_116CE.var_5BC6[var_00]);
				self method_806F(level.var_131A0.var_116CE.var_5BC6[var_00],0);
			}
			else
			{
				var_06 = level.var_131A0.var_116CE.var_5BC6[var_00];
				var_08 = 1 - func_7B21(level.var_131A0.var_116CE.var_5BC3[var_00]);
				self method_806F(level.var_131A0.var_116CE.var_5BC3[var_00],0);
			}

			var_02 = 0.01;
			if(var_02 >= 1 || var_02 == 0)
			{
				var_02 = 0.01;
			}

			var_05 = self.var_13D02;
		}

		var_09 = var_07 / var_03;
		if(var_09 != var_01)
		{
			self method_82A2(var_06,1,0.05,var_09);
			var_01 = var_09;
		}

		if(isdefined(var_02))
		{
			self method_82B0(var_06,var_02);
			var_02 = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 83
func_FA7A(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isspawner(var_03))
		{
			continue;
		}
		else
		{
			var_01[var_01.size] = var_03;
		}
	}

	foreach(var_06 in var_01)
	{
		thread func_131F6(var_06);
	}
}

//Function Number: 84
func_13203()
{
	var_00 = self.classname;
	if(!isdefined(level.var_131A0.var_116CE.var_AC4A) || !isdefined(level.var_131A0.var_116CE.var_AC4A[var_00]))
	{
		wait(2);
	}

	if(isdefined(self.var_EEC8))
	{
		self.health = self.var_EEC8;
		return;
	}

	if(level.var_131A0.var_116CE.var_AC4A[var_00] == -1)
	{
		return;
	}

	if(isdefined(level.var_131A0.var_116CE.var_AC4D[var_00]) && isdefined(level.var_131A0.var_116CE.var_AC4C[var_00]))
	{
		self.health = randomint(level.var_131A0.var_116CE.var_AC4C[var_00] - level.var_131A0.var_116CE.var_AC4D[var_00]) + level.var_131A0.var_116CE.var_AC4D[var_00];
		return;
	}

	self.health = level.var_131A0.var_116CE.var_AC4A[var_00];
}

//Function Number: 85
func_7B21(param_00)
{
	var_01 = self method_8102(param_00);
	var_02 = getanimlength(param_00);
	if(var_01 == 0)
	{
		return 0;
	}

	return self method_8102(param_00) / getanimlength(param_00);
}

//Function Number: 86
func_112FA()
{
	self notify("suspend_drive_anims");
	var_00 = self.model;
	self method_806F(level.var_131A0.var_116CE.var_5BC3[var_00],0);
	self method_806F(level.var_131A0.var_116CE.var_5BC6[var_00],0);
}

//Function Number: 87
func_92D3()
{
	self method_83D0(#animtree);
	if(!isdefined(level.var_131A0.var_116CE.var_92D0[self.model]))
	{
		return;
	}

	foreach(var_01 in level.var_131A0.var_116CE.var_92D0[self.model])
	{
		self method_82A2(var_01);
	}
}

//Function Number: 88
func_1322A()
{
	self endon("kill_rumble_forever");
	var_00 = self.classname;
	var_01 = undefined;
	if(isdefined(self.var_1322C))
	{
		var_01 = self.var_1322C;
	}
	else if(isdefined(level.var_131A0.var_116CE.var_E7BA[var_00]))
	{
		var_01 = level.var_131A0.var_116CE.var_E7BA[var_00];
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.var_257 * 2;
	var_03 = -1 * var_01.var_257;
	var_04 = spawn("trigger_radius",self.origin + (0,0,var_03),0,var_01.var_257,var_02);
	var_04 enablelinkto();
	var_04 linkto(self);
	self.var_E7D2 = var_04;
	self endon("death");
	if(!isdefined(self.var_E7D0))
	{
		self.var_E7D0 = 1;
	}

	if(isdefined(var_01.var_EB9C))
	{
		self.var_E7CB = var_01.var_EB9C;
	}
	else
	{
		self.var_E7CB = 0.15;
	}

	if(isdefined(var_01.var_5F36))
	{
		self.var_E7C0 = var_01.var_5F36;
	}
	else
	{
		self.var_E7C0 = 4.5;
	}

	if(isdefined(var_01.var_257))
	{
		self.var_E7C6 = var_01.var_257;
	}
	else
	{
		self.var_E7C6 = 600;
	}

	if(isdefined(var_01.var_28AE))
	{
		self.var_E7BE = var_01.var_28AE;
	}
	else
	{
		self.var_E7BE = 1;
	}

	if(isdefined(var_01.var_DCA5))
	{
		self.var_E7CA = var_01.var_DCA5;
	}
	else
	{
		self.var_E7CA = 1;
	}

	var_04.var_257 = self.var_E7C6;
	for(;;)
	{
		var_04 waittill("trigger");
		if((self method_83DD() == 0 && !isdefined(self.var_72DB)) || !self.var_E7D0)
		{
			wait(0.1);
			continue;
		}

		self method_8244(var_01.var_E7BA);
		if(isdefined(self.var_380))
		{
			var_05 = self.var_380 + "_rumble_sfx";
			if(soundexists(var_05))
			{
				level.player playsound(var_05);
			}
		}

		while(level.player istouching(var_04) && self.var_E7D0 && self method_83DD() > 0 || isdefined(self.var_72DB))
		{
			earthquake(self.var_E7CB,self.var_E7C0,self.origin,self.var_E7C6);
			wait(self.var_E7BE + randomfloat(self.var_E7CA));
		}

		self stoprumble(var_01.var_E7BA);
	}
}

//Function Number: 89
func_1322F()
{
	var_00 = self.classname;
	if(!isdefined(self.var_EEDE) && isdefined(level.var_131A0.var_116CE.team[var_00]))
	{
		self.var_EEDE = level.var_131A0.var_116CE.team[var_00];
	}
}

//Function Number: 90
func_131EC()
{
	self endon("death");
	var_00 = self.var_380;
	if(!scripts\sp\_utility::func_65DF("unloaded"))
	{
		scripts\sp\_utility::func_65E0("unloaded");
	}
}

//Function Number: 91
func_7D48(param_00)
{
	var_01 = getvehiclenode(param_00,"targetname");
	if(!isdefined(var_01))
	{
		var_01 = getent(param_00,"targetname");
	}
	else if(func_12F8())
	{
	}

	if(!isdefined(var_01))
	{
		var_01 = scripts\common\utility::getstruct(param_00,"targetname");
	}

	return var_01;
}

//Function Number: 92
func_8B7F()
{
	return isdefined(level.var_131A0.var_116CE.var_7448[self.var_380]);
}

//Function Number: 93
func_85DA(param_00)
{
	if(!isdefined(self.var_EDD3))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"grenade"))
	{
		return 0;
	}

	if(self.var_EDD3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 94
func_324F(param_00)
{
	if(!isdefined(self.var_ED22))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"bullet") || issubstr(param_00,"explosive"))
	{
		return 0;
	}

	if(self.var_ED22)
	{
		return 1;
	}

	return 0;
}

//Function Number: 95
func_69F8(param_00)
{
	if(!isdefined(self.var_ED87))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"explosive"))
	{
		return 0;
	}

	if(self.var_ED87)
	{
		return 1;
	}

	return 0;
}

//Function Number: 96
func_13234(param_00,param_01)
{
	return (!isdefined(param_00) && self.var_EEDE != "neutral") || func_24DC(param_00) || func_24DE(param_00) || func_9DC0() || func_9C29(param_00) || func_324F(param_01) || func_69F8(param_01) || func_85DA(param_01) || param_01 == "MOD_MELEE";
}

//Function Number: 97
func_740E()
{
	self endon("death");
	if(!isdefined(level.var_12D6B))
	{
		self endon("stop_friendlyfire_shield");
	}

	if(isdefined(level.var_131A0.var_116CE.var_323D[self.classname]) && !isdefined(self.var_ED22))
	{
		self.var_ED22 = level.var_131A0.var_116CE.var_323D[self.classname];
	}

	if(isdefined(level.var_131A0.var_116CE.var_85A0[self.classname]) && !isdefined(self.var_EDD3))
	{
		self.var_EDD3 = level.var_131A0.var_116CE.var_323D[self.classname];
	}

	if(isdefined(self.var_EE50))
	{
		self.var_EE50 = 1;
		self.var_3233 = 5000;
		self.health = 350;
	}
	else
	{
		self.var_EE50 = 0;
	}

	self.var_8CB6 = 20000;
	self.health = self.health + self.var_8CB6;
	self.var_4BF0 = self.health;
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	while(self.health > 0)
	{
		self waittill("damage",var_03,var_00,var_04,var_05,var_01,var_06,var_07,var_08,var_09,var_02);
		foreach(var_0B in self.var_4CF5)
		{
			thread [[ var_0B ]](var_03,var_00,var_04,var_05,var_01,var_06,var_07);
		}

		if(isdefined(var_00))
		{
			var_00 scripts\sp\_player_stats::func_DED8();
		}

		if(func_13234(var_00,var_01) || func_12F0())
		{
			self.health = self.var_4BF0;
			continue;
		}

		if(func_8B7F())
		{
			func_DE7F(var_00,var_03);
			self.var_4BF0 = self.health;
			continue;
		}

		if(func_9029(var_01))
		{
			self.health = self.var_4BF0;
			self.var_3233 = self.var_3233 - var_03;
			continue;
		}

		self.var_4BF0 = self.health;
		if(self.health < self.var_8CB6 && !isdefined(self.var_13243))
		{
			break;
		}
	}

	self notify("death",var_00,var_01,var_02);
}

//Function Number: 98
func_9029(param_00)
{
	if(!self.var_EE50)
	{
		return 0;
	}

	if(self.var_3233 <= 0)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!issubstr(param_00,"BULLET"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 99
func_DE7F(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_00.origin - self.origin);
	if(vectordot(var_02,var_03) > 0.86)
	{
		self.health = self.health + int(param_01 * level.var_131A0.var_116CE.var_7448[self.var_380]);
	}
}

//Function Number: 100
func_12F0()
{
	if(isdefined(self.var_843F) && self.var_843F)
	{
		return 1;
	}

	return 0;
}

//Function Number: 101
func_9C29(param_00)
{
	if(!isdefined(self.var_ECE6))
	{
		return 0;
	}

	if(isdefined(param_00) && isai(param_00) && self.var_ECE6 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 102
func_24DE(param_00)
{
	if(isdefined(self.var_EEDE) && self.var_EEDE == "allies" && isdefined(param_00) && isplayer(param_00))
	{
		return 1;
	}

	if(isai(param_00) && param_00.team == self.var_EEDE)
	{
		return 1;
	}

	return 0;
}

//Function Number: 103
func_24DC(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.var_EEDE) && isdefined(self.var_EEDE) && param_00.var_EEDE == self.var_EEDE)
	{
		return 1;
	}

	return 0;
}

//Function Number: 104
func_131AF()
{
	return func_143C();
}

//Function Number: 105
func_13D03(param_00)
{
	self.var_13D02 = scripts\common\utility::func_116D7(param_00 <= 0,0,1);
}

//Function Number: 106
func_B248()
{
	if(isdefined(level.var_B249))
	{
		thread [[ level.var_B249 ]]();
		return;
	}

	var_00 = self.model;
	if(!isdefined(level.var_131A0.var_116CE.var_4F6B[var_00]))
	{
		return;
	}

	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		playfxontag(level.var_131A0.var_116CE.var_4F6B[var_00],self,"tag_engine_exhaust");
		var_01 = self gettagorigin("tag_flash");
		var_02 = physicstrace(var_01,var_01 + (0,0,-128));
		physicsexplosionsphere(var_02,192,100,1);
	}
}

//Function Number: 107
func_D546()
{
	self endon("death");
	var_00 = self.model;
	if(!isdefined(level.var_131A0.var_116CE.var_693A[var_00]))
	{
		return;
	}

	var_01 = 0.1;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(!isalive(self))
		{
			return;
		}

		playfxontag(level.var_131A0.var_116CE.var_693A[var_00],self,"tag_engine_exhaust");
		wait(var_01);
	}
}

//Function Number: 108
func_13219()
{
	self.var_247E = undefined;
	self notify("newpath");
	self method_82F2(scripts\common\utility::func_6EE1(self.angles)[1]);
	self method_8362(self.origin + (0,0,4),1);
}

//Function Number: 109
func_4E5C()
{
	if(self.health > 0)
	{
		self.var_E683 = 1;
	}
}

//Function Number: 110
func_4E5B()
{
	self.var_E683 = undefined;
	self notify("deathrolloff");
}

//Function Number: 111
func_134C()
{
	self.var_EEF8 = 0;
	if(func_12F8() && func_8BFD())
	{
		if(isdefined(level.var_3F23))
		{
			self thread [[ level.var_3F24 ]]();
			return;
		}
	}

	if(!isdefined(self.var_B6BD))
	{
		return;
	}

	foreach(var_01 in self.var_B6BD)
	{
		if(isdefined(var_01.var_ED98))
		{
			var_01.var_ED98 = 0;
		}

		var_01 method_830F("manual");
	}
}

//Function Number: 112
func_134D()
{
	self.var_EEF8 = 1;
	if(func_12F8() && func_8BFD())
	{
		self thread [[ level.var_3F25 ]]();
		return;
	}

	if(!isdefined(self.var_B6BD))
	{
		return;
	}

	foreach(var_01 in self.var_B6BD)
	{
		var_01 show();
		if(isdefined(var_01.var_ED98))
		{
			var_01.var_ED98 = 1;
		}

		if(isdefined(var_01.var_5041))
		{
			if(var_01.var_5041 != "sentry")
			{
				var_01 method_830F(var_01.var_5041);
			}
		}
		else
		{
			var_01 method_830F("auto_nonai");
		}

		func_F5D8(var_01);
	}
}

//Function Number: 113
func_7D47()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_01 = function_00C8(self.target);
		foreach(var_03 in var_01)
		{
			if(!issubstr(var_03.var_9F,"actor") && !issubstr(var_03.var_9F,"vehicle"))
			{
				continue;
			}

			if(issubstr(var_03.var_9F,"actor"))
			{
				if(!isspawner(var_03))
				{
					continue;
				}
				else if(issubstr(var_03.var_9F,"vehicle"))
				{
					if(!var_03.var_2AF & 2)
					{
						continue;
					}
				}
			}

			if(isdefined(var_03.var_5941))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		if(isdefined(level.var_107A7))
		{
			var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.var_EEB6))
				{
					var_00[var_00.size] = var_03;
				}
			}
		}
	}

	return var_00;
}

//Function Number: 114
func_1444(param_00)
{
	if(isdefined(param_00.var_ED52))
	{
		param_00 endon("death");
		wait(param_00.var_ED52);
	}

	var_01 = param_00 method_83DA();
	if(!isdefined(param_00.var_1084E))
	{
		param_00.var_1084E = 0;
	}

	param_00.var_1084E++;
	param_00.var_1323B = var_01;
	param_00.var_A90E = var_01;
	param_00 thread func_E0A7();
	var_01.var_1323C = param_00;
	if(isdefined(param_00.var_12841))
	{
		var_01.var_12841 = param_00.var_12841;
	}

	thread func_131F6(var_01);
	param_00 notify("spawned",var_01);
	return var_01;
}

//Function Number: 115
func_D808()
{
	var_00 = [];
	var_01 = getentarray("script_vehicle","code_classname");
	level.var_BE91 = [];
	var_02 = [];
	var_00 = [];
	if(!isdefined(level.var_13261))
	{
		level.var_13261 = [];
	}

	foreach(var_04 in var_01)
	{
		var_04.var_380 = tolower(var_04.var_380);
		if(var_04.var_380 == "empty" || var_04.var_380 == "empty_heli")
		{
			continue;
		}

		if(isdefined(var_04.var_2AF) && var_04.var_2AF & 1)
		{
			var_02[var_02.size] = var_04;
		}

		var_00[var_00.size] = var_04;
		if(!isdefined(level.var_13261[var_04.var_380]))
		{
			level.var_13261[var_04.var_380] = [];
		}

		var_05 = "classname: " + var_04.classname;
		func_D812(var_05,var_04);
	}

	if(level.var_BE91.size > 0)
	{
		foreach(var_08 in level.var_BE91)
		{
		}

		level waittill("never");
	}

	return var_00;
}

//Function Number: 116
func_D812(param_00,param_01)
{
	if(isdefined(level.var_13261[param_01.var_380][param_01.classname]))
	{
		return;
	}

	if(isdefined(level.var_131A0.var_116CE.var_1325B) && isdefined(level.var_131A0.var_116CE.var_1325B[param_01.classname]))
	{
		return;
	}

	if(param_01.classname == "script_vehicle")
	{
		return;
	}

	var_02 = 0;
	foreach(var_04 in level.var_BE91)
	{
		if(var_04 == param_00)
		{
			var_02 = 1;
		}
	}

	if(!var_02)
	{
		level.var_BE91[level.var_BE91.size] = param_00;
	}
}

//Function Number: 117
func_F9C7()
{
	if(!scripts\common\utility::func_16F3("vehicle_vars",::func_F9C7))
	{
		return;
	}

	scripts\common\utility::func_1115B();
	level.var_131A0 = spawnstruct();
	level.var_131A0.var_116CE = spawnstruct();
	level.var_131A0.var_8DAA = getentarray("helicopter_crash_location","targetname");
	level.var_131A0.var_8DAA = scripts\common\utility::array_combine(level.var_131A0.var_8DAA,scripts\sp\_utility::func_8181("helicopter_crash_location","targetname"));
	level.var_131A0.var_116CE.team = [];
	level.var_131A0.var_116CE.var_4E4E = [];
	level.var_131A0.var_116CE.var_4E23 = [];
	level.var_131A0.var_116CE.var_5BC3 = [];
	level.var_131A0.var_116CE.var_5BC6 = [];
	level.var_131A0.var_116CE.var_E7BA = [];
	level.var_131A0.var_116CE.var_B6BD = [];
	level.var_131A0.var_116CE.var_4E02 = [];
	level.var_131A0.var_116CE.var_112D9 = [];
	level.var_131A0.var_116CE.var_12BCF = [];
	level.var_131A0.var_116CE.var_1A03 = [];
	level.var_131A0.var_116CE.var_A7C5 = [];
	level.var_131A0.var_116CE.var_693A = [];
	level.var_131A0.var_116CE.var_4F6B = [];
	level.var_131A0.var_116CE.var_FE7C = [];
	level.var_131A0.var_116CE.var_8E9D = [];
	level.var_131A0.var_116CE.var_7448 = [];
	level.var_131A0.var_116CE.var_535B = [];
	level.var_131A0.var_116CE.var_85A0 = [];
	level.var_131A0.var_116CE.var_323D = [];
	level.var_131A0.var_116CE.var_4E12 = [];
	level.var_131A0.var_116CE.var_4DFC = [];
	level.var_131A0.var_116CE.var_92D0 = [];
	level.var_131A0.var_116CE.var_8DB1 = [];
	level.var_131A0.var_116CE.var_1AE5 = [];
	level.var_131A0.var_116CE.var_1020A = [];
	level.var_131A0.var_116CE.var_4DF9 = [];
	level.var_131A0.var_116CE.var_131BC = [];
	if(!isdefined(level.var_131A0.var_116CE.var_4E1C))
	{
		level.var_131A0.var_116CE.var_4E1C = [];
	}

	scripts\sp\_vehicle_aianim::func_F8AE();
}

//Function Number: 118
func_FB0A(param_00,param_01)
{
	return func_13E1(param_00,param_01);
}

//Function Number: 119
func_13207(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 512;
	}

	var_01 = self.origin + (0,0,param_00);
	self method_8316(10);
	func_FB0A(var_01,1);
	self waittill("goal");
}

//Function Number: 120
func_10810(param_00)
{
	var_01 = [];
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(!isdefined(var_05.var_9F) || var_05.var_9F != "script_vehicle")
		{
			continue;
		}

		if(isspawner(var_05))
		{
			var_01[var_01.size] = func_1444(var_05);
		}
	}

	return var_01;
}

//Function Number: 121
func_A5CC(param_00)
{
	if(!isdefined(level.var_131A0.var_116CE.var_4DF9[param_00]))
	{
		return;
	}

	if(isdefined(self.var_10263) && self.var_10263)
	{
		return;
	}

	if(isarray(level.var_131A0.var_116CE.var_4DF9[param_00]))
	{
		if(isdefined(self.var_D832))
		{
			var_01 = self.var_D832;
		}
		else
		{
			var_01 = scripts\common\utility::random(level.var_131A0.var_116CE.var_4DF9[var_01]);
		}

		return func_A5CD(var_01);
	}

	return func_A5CD(level.var_131A0.var_116CE.var_4DF9[var_01]);
}

//Function Number: 122
func_A5CD(param_00)
{
	self.var_A648 = 1;
	var_01 = scripts\common\utility::spawn_tag_origin();
	self method_83E3(var_01.origin,var_01.angles,0,0);
	self method_83E8();
	self notify("kill_death_anim",param_00);
	if(isstring(param_00))
	{
		self setcandamage(0);
		var_01 lib_0B06::func_1F35(self,param_00);
	}
	else
	{
		self method_83D0(#animtree);
		self method_8018("vehicle_death_anim",var_01.origin,var_01.angles,param_00);
		self method_8316(30);
		self method_8362(var_01.origin,1);
		self method_82F2(var_01.angles[1]);
		self waittillmatch("end","vehicle_death_anim");
	}

	var_01 delete();
	thread func_50EA(7);
}

//Function Number: 123
func_50EA(param_00)
{
	wait(7);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 124
func_5144()
{
	var_00 = self method_810C();
	var_01 = self method_8159(1,0,0);
	var_02 = distance(var_01,var_00);
	var_03 = function_0083();
	foreach(var_05 in var_03)
	{
		if(distance(var_05.origin,var_00) < var_02)
		{
			var_05 delete();
		}
	}
}
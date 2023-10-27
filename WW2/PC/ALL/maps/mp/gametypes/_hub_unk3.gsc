/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hub_unk3.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 172 ms
 * Timestamp: 10/27/2023 3:23:43 AM
*******************************************************************/

//Function Number: 1
func_8662()
{
	var_00 = self;
	var_00 visionsetnakedforplayer("mp_hub_allies_vlobby",0);
}

//Function Number: 2
func_A594(param_00,param_01)
{
	if(isdefined(self.var_12C["class"]) && self.var_12C["class"] == param_00 && !isdefined(param_01) || !param_01)
	{
		return;
	}

	self.var_12C["class"] = param_00;
	self.var_2319 = param_00;
	maps\mp\gametypes\_class::func_864F(self.var_12C["class"]);
	self.var_95AE = undefined;
	self.var_95AF = undefined;
	maps\mp\gametypes\_class::func_4790(self.var_12C["team"],self.var_12C["class"]);
	maps\mp\gametypes\_hub_unk1::func_115E();
}

//Function Number: 3
func_636A(param_00)
{
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_01,var_02);
		if(var_01 == "class_select")
		{
			param_00.var_839F = var_02;
			continue;
		}

		if(var_01 != "hub_firing_range_selected")
		{
			continue;
		}

		if(isdefined(param_00.var_5721))
		{
			wait 0.05;
			param_00 setclientdvar("3078","1.0");
			param_00 notify("buttonToFiringRangePressed");
			param_00 notify("weaponPlantFiringRange");
			if(!param_00.var_5721)
			{
				param_00.var_3C3D = 1;
				param_00 maps\mp\gametypes\_hub_range::func_98C7();
				param_00 unlink();
				param_00 method_81E3();
				continue;
			}

			param_00 maps\mp\gametypes\_hub_range::func_21C0();
		}
	}
}

//Function Number: 4
func_8482(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	if(isdefined(var_02))
	{
		var_02 method_81DF(param_01);
	}
}

//Function Number: 5
func_8418(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		func_8482(var_03,param_01);
	}
}

//Function Number: 6
func_8877()
{
}

//Function Number: 7
func_62F5()
{
	self endon("disconnect");
	var_00 = ["soldier_key","soldier_rim","soldier_fill","soldier_rimR"];
	var_01 = ["gun_key","gun_rim","gun_fill"];
	var_02 = ["wide_rim","wide_key","wide_fill"];
	var_03 = [1,52,24,51,51,44,44,51,52,51];
	func_8877();
	for(;;)
	{
		self waittill("luinotifyserver",var_04,var_05);
		var_06 = getdvarint("2454",0);
		if(var_04 == "weapon_select" && isdefined(var_05))
		{
			var_07 = int(var_05);
			var_08 = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_07),undefined,undefined,undefined,undefined,undefined,undefined,maps\mp\_utility::func_472C(var_07));
			var_09 = [];
			var_09[var_09.size] = var_08;
			self method_8512(var_09);
			continue;
		}

		if((var_04 == "classpreview" || var_04 == "classpreview_postcopy") && isdefined(var_05))
		{
			if(!var_06)
			{
				if(var_05 >= 0)
				{
					var_0A = var_05 & 15;
					var_0B = int(var_05 / 16);
					if(var_0B > 0)
					{
						self.var_294D = var_0B - 1;
						func_A594("custom" + self.var_294D + 1,0);
					}
				}
			}

			continue;
		}

		if(var_04 == "costume_apply")
		{
			var_0C = maps\mp\gametypes\_class::func_1F95();
			if(isdefined(var_05) && var_05 >= 0)
			{
				var_0D = var_05 & 7;
				var_0E = int(var_05 & ~7 / 8);
				var_0C[var_0D] = var_0E;
			}

			self setcostumemodels(var_0C);
			self method_8423(self);
		}
	}
}

//Function Number: 8
func_0953(param_00)
{
	for(var_01 = 0;var_01 < level.var_60B7.size;var_01++)
	{
		if(level.var_60B7[var_01].var_1D6 == param_00.var_1D6)
		{
			level.var_60B7[var_01] = param_00;
			param_00 = undefined;
			break;
		}
	}

	if(isdefined(param_00))
	{
		level.var_60B7[level.var_60B7.size] = param_00;
	}
}

//Function Number: 9
func_6EA2(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = var_02.var_1D6;
		if(var_02.fontscale >= 0)
		{
			func_0953(var_02);
		}
	}
}

//Function Number: 10
func_3B94(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.var_744A)
	{
		if(var_03.var_1D6 == param_00)
		{
			var_01 = var_03;
			break;
		}
	}

	return var_01;
}

//Function Number: 11
endgame()
{
	level.var_60B7 = [];
	var_00 = maps\mp\_utility::func_4604();
	for(;;)
	{
		while(!isdefined(level.var_744A) || level.var_744A.size == 0)
		{
			wait 0.05;
		}

		while(isdefined(level.var_744A) && level.var_744A.size > 0)
		{
			var_01 = [];
			var_02 = [];
			var_03 = 0;
			var_04 = 0;
			var_05 = 0;
			foreach(var_11, var_07 in level.var_60B7)
			{
				var_08 = func_3B94(var_07.var_1D6);
				if(isdefined(var_08) && var_07.var_11C != 0)
				{
					var_02[var_04] = var_08;
					var_04++;
				}
				else if(!isdefined(var_08) && getdvarint("2803",0) == 0)
				{
				}

				var_09 = spawnstruct();
				var_09.var_985A = "allies";
				var_09.var_23D9 = 0;
				var_09.var_2669 = 0;
				var_09.var_1E26 = 1;
				var_09.var_7615 = 0;
				var_09.var_56FE = 0;
				var_09.var_79 = var_07.var_79;
				var_09.var_76F7 = var_07.fontscale;
				var_09.var_76F3[0] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.footstepdetectdist,3));
				var_09.var_76F3[1] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.footstepdetectdistsprint,3));
				var_09.var_76F3[2] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.footstepdetectdistwalk,3));
				var_09.var_76F3[3] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.var_13F,3));
				var_09.var_76F3[4] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.var_140,3));
				var_09.var_76F3[5] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.var_141,3));
				var_09.var_144 = var_07.var_144;
				var_09.var_76F5 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv",0,var_07.foreground,1));
				var_09.var_76F4 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv",0,var_07.var_143,1));
				var_09.var_7700 = maps\mp\_utility::func_452A(tablelookup("mp/reticleTable.csv",0,var_07.var_145,1));
				var_09.primarypaintjobid = var_07.var_76EF;
				var_09.primarycharmguid = var_07.var_76F0;
				var_09.var_8357 = var_07.var_16E;
				var_09.var_8353[0] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.var_170,3));
				var_09.var_8353[1] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.var_171,3));
				var_09.var_8353[2] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv",0,var_07.health,3));
				var_09.var_8353[3] = 0;
				var_09.var_8353[4] = 0;
				var_09.var_8353[5] = 0;
				var_09.var_176 = var_07.var_176;
				var_09.var_8355 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv",0,var_07.height,1));
				var_09.var_8354 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv",0,var_07.var_174,1));
				var_09.var_8359 = maps\mp\_utility::func_452A(tablelookup("mp/reticleTable.csv",0,var_07.hidewheninmenu,1));
				var_09.secondarypaintjobid = var_07.var_834E;
				var_09.secondarycharmguid = var_07.var_834F;
				var_09.var_60E9 = var_07.var_101;
				var_09.var_5CA8 = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_ED,1));
				var_09.var_959F = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_1A0,1));
				var_09.var_6F69[0] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_123,1));
				var_09.var_6F69[1] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_124,1));
				var_09.var_6F69[2] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_125,1));
				var_09.var_6F69[3] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_126,1));
				var_09.var_6F69[4] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_127,1));
				var_09.var_6F69[5] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_128,1));
				var_09.var_6F69[6] = 0;
				var_09.var_6F69[7] = 0;
				var_09.var_6F69[8] = 0;
				if(isdefined(var_07.var_129))
				{
					var_09.var_6F69[6] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_129,1));
				}

				if(isdefined(var_07.var_12A))
				{
					var_09.var_6F69[7] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_12A,1));
				}

				if(isdefined(var_07.var_12B))
				{
					var_09.var_6F69[8] = maps\mp\_utility::func_452A(tablelookup(var_00,0,var_07.var_12B,1));
				}

				var_0A = 1;
				var_0B = 1;
				var_0C = 1;
				if(!maps\mp\gametypes\_class::func_5835(var_09.var_76F7,var_0A) && !maps\mp\gametypes\_class::func_5839(var_09.var_8357,var_0B,var_0C))
				{
					var_09.var_76F7 = maps\mp\gametypes\_class::func_9590(level.var_2324,10,0);
					for(var_0D = 0;var_0D < 6;var_0D++)
					{
						var_09.var_76F3[var_0D] = 0;
					}
				}

				if(!maps\mp\gametypes\_class::func_5839(var_09.var_8357,var_0B,var_0C))
				{
					var_09.var_8357 = maps\mp\gametypes\_class::func_9590(level.var_2324,10,1);
					for(var_0D = 0;var_0D < 6;var_0D++)
					{
						var_09.var_8353[var_0D] = 0;
					}
				}

				var_09.var_7709 = maps\mp\_utility::func_473C(var_09.var_76F7,0);
				var_09.var_835D = maps\mp\_utility::func_473C(var_09.var_8357,0);
				var_09.var_60FC = maps\mp\_utility::func_473C(var_09.var_60E9,0);
				var_09.var_76F8 = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_09.var_76F7),var_09.var_76F3[0],var_09.var_76F3[1],var_09.var_76F3[2],var_09.var_76F3[3],var_09.var_76F3[4],var_09.var_76F3[5],maps\mp\_utility::func_472C(var_09.var_76F7),var_09.var_76F5,var_09.var_76F4,var_09.var_7700,var_09.var_144);
				var_09.var_8358 = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_09.var_8357),var_09.var_8353[0],var_09.var_8353[1],var_09.var_8353[2],var_09.var_8353[3],var_09.var_8353[4],var_09.var_8353[5],maps\mp\_utility::func_472C(var_09.var_8357),var_09.var_8355,var_09.var_8354,var_09.var_8359,var_09.var_176);
				var_09.var_5A62 = 0;
				var_09.var_5A63 = 0;
				var_09.var_5A64 = 0;
				var_09.var_5A65 = 0;
				var_09.var_59DA = 0;
				var_09.var_870C = 1;
				var_09.var_37FE = maps\mp\_utility::func_44CE(var_09.var_5CA8,0);
				var_09.var_37FD = 0;
				var_09.var_69AD = maps\mp\_utility::func_44CE(var_09.var_959F,0);
				var_09.var_69AC = 0;
				var_0E = [];
				var_0E[level.var_2682["shirt"]] = var_07.var_17F;
				var_0E[level.var_2682["head"]] = var_07.color;
				var_0E[level.var_2682["pants"]] = var_07.var_11A;
				var_0E[level.var_2682["eyewear"]] = var_07.var_91;
				var_0E[level.var_2682["hat"]] = var_07.var_B8;
				var_0E[level.var_2682["gear"]] = var_07.var_A8;
				var_08 = func_3B94(var_07.var_1D6);
				if(isdefined(var_08) && var_07.var_11C != 0)
				{
					var_02[var_04] = var_08;
					var_04++;
				}

				if(!isdefined(var_08))
				{
					if(getdvarint("2803",0) == 0)
					{
					}

					continue;
				}

				var_0F = 0;
				var_10 = "customClasses";
				if(isdefined(var_08.var_294D))
				{
					var_0F = var_08.var_294D;
				}

				var_09.var_2319 = "custom" + common_scripts\utility::func_9AAD(var_0F + 1);
				var_09.var_231B = var_0F;
				var_08.var_A597 = var_09;
			}

			level.var_60B7 = [];
			wait 0.05;
		}
	}
}
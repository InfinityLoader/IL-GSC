/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\createfxmenu.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1978 ms
 * Timestamp: 10/27/2023 12:03:17 AM
*******************************************************************/

//Function Number: 1
func_967B()
{
	level.var_11B7.var_C6C0 = [];
	func_1807("string","fxid","FX id","nil","fx");
	func_1807("float","delay","Repeat rate/start delay",0.5,"fx");
	func_1807("string","flag","Flag","nil","exploder");
	if(!level.var_BD5D)
	{
		func_1807("string","firefx","2nd FX id","nil","exploder");
		func_1807("float","firefxdelay","2nd FX id repeat rate",0.5,"exploder");
		func_1807("float","firefxtimeout","2nd FX timeout",5,"exploder");
		func_1807("string","firefxsound","2nd FX soundalias","nil","exploder");
		func_1807("float","damage","Radius damage",150,"exploder");
		func_1807("float","damage_radius","Radius of radius damage",250,"exploder");
		func_1807("string","earthquake","Earthquake","nil","exploder");
		func_1807("string","ender","Level notify for ending 2nd FX","nil","exploder");
	}

	func_1807("float","delay_min","Minimimum time between repeats",1,"soundfx_interval");
	func_1807("float","delay_max","Maximum time between repeats",2,"soundfx_interval");
	func_1807("int","repeat","Number of times to repeat",5,"exploder");
	func_1807("string","exploder","Exploder","1","exploder");
	func_1807("string","soundalias","Soundalias","nil","all");
	func_1807("string","loopsound","Loopsound","nil","exploder");
	func_1807("int","reactive_radius","Reactive Radius",100,"reactive_fx",::func_9909);
	if(!level.var_BD5D)
	{
		func_1807("string","rumble","Rumble","nil","exploder");
		func_1807("int","stopable","Can be stopped from script","1","all");
	}

	level.var_5FE0 = 0;
	level.var_5FE1 = 10;
	if(level.var_BD5D)
	{
		level.var_5FE1 = 6;
	}

	level.var_49CC = [];
	level.var_49CC["all"] = [];
	level.var_49CC["all"]["exploder"] = 1;
	level.var_49CC["all"]["oneshotfx"] = 1;
	level.var_49CC["all"]["loopfx"] = 1;
	level.var_49CC["all"]["soundfx"] = 1;
	level.var_49CC["all"]["soundfx_interval"] = 1;
	level.var_49CC["all"]["reactive_fx"] = 1;
	level.var_49CC["fx"] = [];
	level.var_49CC["fx"]["exploder"] = 1;
	level.var_49CC["fx"]["oneshotfx"] = 1;
	level.var_49CC["fx"]["loopfx"] = 1;
	if(!level.var_BD5D)
	{
		level.var_49CC["fx"]["reactive_fx"] = 1;
	}

	level.var_49CC["exploder"] = [];
	level.var_49CC["exploder"]["exploder"] = 1;
	level.var_49CC["loopfx"] = [];
	level.var_49CC["loopfx"]["loopfx"] = 1;
	level.var_49CC["oneshotfx"] = [];
	level.var_49CC["oneshotfx"]["oneshotfx"] = 1;
	level.var_49CC["soundfx"] = [];
	level.var_49CC["soundfx"]["soundalias"] = 1;
	level.var_49CC["soundfx_interval"] = [];
	level.var_49CC["soundfx_interval"]["soundfx_interval"] = 1;
	level.var_49CC["reactive_fx"] = [];
	level.var_49CC["reactive_fx"]["reactive_fx"] = 1;
	var_00 = [];
	var_00["creation"] = ::func_B669;
	var_00["create_oneshot"] = ::func_B668;
	var_00["create_loopfx"] = ::func_B668;
	var_00["change_fxid"] = ::func_B668;
	var_00["none"] = ::func_B66D;
	var_00["add_options"] = ::func_B666;
	var_00["select_by_name"] = ::func_B66E;
	level.var_11B7.var_B677 = var_00;
}

//Function Number: 2
func_B665(param_00)
{
	return level.var_48F1 == param_00;
}

//Function Number: 3
func_F796(param_00)
{
	level.var_48F1 = param_00;
}

//Function Number: 4
func_48F1()
{
	if(scripts\common\createfx::func_32DF("escape","x"))
	{
		func_6958();
		return;
	}

	if(isdefined(level.var_11B7.var_B677[level.var_48F1]))
	{
		[[ level.var_11B7.var_B677[level.var_48F1] ]]();
	}
}

//Function Number: 5
func_B669()
{
	if(!isdefined(level.var_11B7.var_B669))
	{
		level.var_11B7.var_B669 = [];
		var_00 = [];
		var_00["1"] = ::func_32F4;
		if(!level.var_BD5D)
		{
			var_00["2"] = ::func_32F2;
			var_00["3"] = ::func_32F3;
			var_00["4"] = ::func_32F0;
			var_00["5"] = ::func_32F1;
			var_00["6"] = ::func_32F5;
		}
		else
		{
			var_00["2"] = ::func_32F3;
			var_00["3"] = ::func_32F0;
			var_00["4"] = ::func_32F1;
			var_00["5"] = ::func_32F5;
		}

		level.var_11B7.var_B669 = var_00;
	}

	foreach(var_03, var_02 in level.var_11B7.var_B669)
	{
		if(scripts\common\createfx::func_32DF(var_03))
		{
			[[ var_02 ]]();
			return;
		}
	}
}

//Function Number: 6
func_32F4()
{
	func_F796("create_oneshot");
	func_5B3D();
}

//Function Number: 7
func_32F2()
{
	func_F796("create_loopfx");
	func_5B3D();
}

//Function Number: 8
func_32F3()
{
	func_F796("create_loopsound");
	var_00 = scripts\common\createfx::func_49E7();
	func_6CCE(var_00);
}

//Function Number: 9
func_32F0()
{
	func_F796("create_exploder");
	var_00 = scripts\common\createfx::func_49F4();
	func_6CCE(var_00);
}

//Function Number: 10
func_32F1()
{
	func_F796("create_interval_sound");
	var_00 = scripts\common\createfx::func_49DD();
	func_6CCE(var_00);
}

//Function Number: 11
func_32F5()
{
	var_00 = scripts\common\createfx::func_4A06();
	func_6CCE(var_00);
}

//Function Number: 12
func_B668()
{
	if(func_BF33())
	{
		func_93F3();
		func_5B3D();
	}
	else if(func_D89F())
	{
		func_4FBC();
		func_5B3D();
	}

	func_B66A();
}

//Function Number: 13
func_B66D()
{
	if(scripts\common\createfx::func_32DF("m"))
	{
		func_93F3();
	}

	func_B667();
	if(func_6634())
	{
		var_00 = func_7A70();
		if(!isdefined(level.var_A8A9) || var_00 != level.var_A8A9)
		{
			func_56B8(var_00);
			level.var_A8A9 = var_00;
		}

		if(scripts\common\createfx::func_32DF("a"))
		{
			scripts\common\createfx::func_417F();
			func_F796("add_options");
			return;
		}

		return;
	}

	level.var_A8A9 = undefined;
}

//Function Number: 14
func_B666()
{
	if(!func_6634())
	{
		scripts\common\createfx::func_4152();
		func_F796("none");
		return;
	}

	func_56B7(func_7A70());
	if(func_BF33())
	{
		func_93F3();
	}
}

//Function Number: 15
func_B66E()
{
	if(func_BF33())
	{
		func_93F3();
		func_5B3D("Select by name");
	}
	else if(func_D89F())
	{
		func_4FBC();
		func_5B3D("Select by name");
	}

	func_F191();
}

//Function Number: 16
func_BF33()
{
	return scripts\common\createfx::func_32DF("rightarrow");
}

//Function Number: 17
func_D89F()
{
	return scripts\common\createfx::func_32DF("leftarrow");
}

//Function Number: 18
func_6958()
{
	scripts\common\createfx::func_4152();
	scripts\common\createfx::func_414D();
	scripts\common\createfx::func_12E21();
	func_F796("none");
}

//Function Number: 19
func_B66A()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = scripts\common\createfx::func_74C7();
	for(var_03 = level.var_5FE0;var_03 < var_02.size;var_03++)
	{
		var_00 = var_00 + 1;
		var_04 = var_00;
		if(var_04 == 10)
		{
			var_04 = 0;
		}

		if(scripts\common\createfx::func_32DF(var_04 + ""))
		{
			var_01 = var_02[var_03];
			break;
		}

		if(var_00 > level.var_5FE1)
		{
			break;
		}
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(func_B665("change_fxid"))
	{
		func_20AF(func_7B4E("fxid"),var_01);
		level.var_5FE0 = 0;
		scripts\common\createfx::func_4152();
		func_F796("none");
		return;
	}

	var_05 = undefined;
	if(func_B665("create_loopfx"))
	{
		var_05 = scripts\common\utility::func_49E6(var_01);
	}

	if(func_B665("create_oneshot"))
	{
		var_05 = scripts\common\utility::func_49FA(var_01);
	}

	func_6CCE(var_05);
}

//Function Number: 20
func_6CCE(param_00)
{
	param_00.var_13125["angles"] = vectortoangles(param_00.var_13125["origin"] + (0,0,100) - param_00.var_13125["origin"]);
	if(isdefined(level._effect) && isdefined(level._effect[param_00.var_13125["fxid"]]) && function_02A2(level._effect[param_00.var_13125["fxid"]]))
	{
		param_00.var_13125["angles"] = (0,0,0);
	}

	param_00 scripts\common\createfx::func_D6CF();
	scripts\common\createfx::func_414D();
	scripts\common\createfx::func_F19D();
	scripts\common\createfx::func_BC69();
	scripts\common\createfx::func_12E21();
	func_F796("none");
}

//Function Number: 21
func_6634()
{
	return level.var_11B7.var_F1B3.size > 0;
}

//Function Number: 22
func_B667()
{
	if(!level.var_11B7.var_F1B3.size)
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = func_7A70();
	for(var_03 = 0;var_03 < level.var_11B7.var_C6C0.size;var_03++)
	{
		var_04 = level.var_11B7.var_C6C0[var_03];
		if(!isdefined(var_02.var_13125[var_04["name"]]))
		{
			continue;
		}

		var_00++;
		if(var_00 < level.var_5FE0)
		{
			continue;
		}

		var_01++;
		var_05 = var_01;
		if(var_05 == 10)
		{
			var_05 = 0;
		}

		if(scripts\common\createfx::func_32DF(var_05 + ""))
		{
			func_D85B(var_04,var_01);
			break;
		}

		if(var_01 > level.var_5FE1)
		{
			var_06 = 1;
			break;
		}
	}
}

//Function Number: 23
func_D85B(param_00,param_01)
{
	if(param_00["name"] == "fxid")
	{
		func_F796("change_fxid");
		func_5B3D();
		return;
	}

	level.var_49C0 = 1;
	level.var_11B7.var_917E[param_01 + 3][0].color = (1,1,0);
	if(isdefined(param_00["input_func"]))
	{
		thread [[ param_00["input_func"] ]](param_01 + 3);
	}
	else
	{
		scripts\common\createfx::func_49B7("To change " + param_00["description"] + " on selected entities, type /fx newvalue");
	}

	func_F4AC(param_00["name"]);
	setdvar("fx","nil");
}

//Function Number: 24
func_B66B()
{
	if(getdvar("fx") == "nil")
	{
		return;
	}

	var_00 = func_7C4C();
	var_01 = undefined;
	if(var_00["type"] == "string")
	{
		var_01 = getdvar("fx");
	}

	if(var_00["type"] == "int")
	{
		var_01 = getdvarint("fx");
	}

	if(var_00["type"] == "float")
	{
		var_01 = getdvarfloat("fx");
	}

	func_20AF(var_00,var_01);
}

//Function Number: 25
func_20AF(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.var_11B7.var_F1B3.size;var_02++)
	{
		var_03 = level.var_11B7.var_F1B3[var_02];
		if(func_B3C8(param_00["mask"],var_03.var_13125["type"]))
		{
			var_03.var_13125[param_00["name"]] = param_01;
		}
	}

	level.var_A8A9 = undefined;
	scripts\common\createfx::func_12E21();
	scripts\common\createfx::func_417F();
}

//Function Number: 26
func_F4AC(param_00)
{
	for(var_01 = 0;var_01 < level.var_11B7.var_C6C0.size;var_01++)
	{
		if(level.var_11B7.var_C6C0[var_01]["name"] != param_00)
		{
			continue;
		}

		level.var_11B7.var_F1B4 = var_01;
		return;
	}
}

//Function Number: 27
func_7C4C()
{
	return level.var_11B7.var_C6C0[level.var_11B7.var_F1B4];
}

//Function Number: 28
func_B3C8(param_00,param_01)
{
	return isdefined(level.var_49CC[param_00][param_01]);
}

//Function Number: 29
func_1807(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	var_06["type"] = param_00;
	var_06["name"] = param_01;
	var_06["description"] = param_02;
	var_06["default"] = param_03;
	var_06["mask"] = param_04;
	if(isdefined(param_05))
	{
		var_06["input_func"] = param_05;
	}

	level.var_11B7.var_C6C0[level.var_11B7.var_C6C0.size] = var_06;
}

//Function Number: 30
func_7B4E(param_00)
{
	for(var_01 = 0;var_01 < level.var_11B7.var_C6C0.size;var_01++)
	{
		if(level.var_11B7.var_C6C0[var_01]["name"] == param_00)
		{
			return level.var_11B7.var_C6C0[var_01];
		}
	}
}

//Function Number: 31
func_9909(param_00)
{
	for(;;)
	{
		wait(0.05);
		if(level.player buttonpressed("escape") || level.player buttonpressed("x"))
		{
			break;
		}

		var_01 = 0;
		if(level.player buttonpressed("-"))
		{
			var_01 = -10;
		}
		else if(level.player buttonpressed("="))
		{
			var_01 = 10;
		}

		if(var_01 != 0)
		{
			foreach(var_03 in level.var_11B7.var_F1B3)
			{
				if(isdefined(var_03.var_13125["reactive_radius"]))
				{
					var_03.var_13125["reactive_radius"] = var_03.var_13125["reactive_radius"] + var_01;
					var_03.var_13125["reactive_radius"] = clamp(var_03.var_13125["reactive_radius"],10,1000);
				}
			}
		}
	}

	level.var_A8A9 = undefined;
	scripts\common\createfx::func_12E21();
	scripts\common\createfx::func_417F();
}

//Function Number: 32
func_56B7(param_00)
{
	scripts\common\createfx::func_4152();
	scripts\common\createfx::func_F3C4("Name: " + param_00.var_13125["fxid"]);
	scripts\common\createfx::func_F3C4("Type: " + param_00.var_13125["type"]);
	scripts\common\createfx::func_F3C4("Origin: " + param_00.var_13125["origin"]);
	scripts\common\createfx::func_F3C4("Angles: " + param_00.var_13125["angles"]);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(level.var_5FE0 >= level.var_11B7.var_C6C0.size)
	{
		level.var_5FE0 = 0;
	}

	for(var_04 = 0;var_04 < level.var_11B7.var_C6C0.size;var_04++)
	{
		var_05 = level.var_11B7.var_C6C0[var_04];
		if(isdefined(param_00.var_13125[var_05["name"]]))
		{
			continue;
		}

		if(!func_B3C8(var_05["mask"],param_00.var_13125["type"]))
		{
			continue;
		}

		var_01++;
		if(var_01 < level.var_5FE0)
		{
			continue;
		}

		if(var_02 >= level.var_5FE1)
		{
			continue;
		}

		var_02++;
		var_06 = var_02;
		if(var_06 == 10)
		{
			var_06 = 0;
		}

		if(scripts\common\createfx::func_32DF(var_06 + ""))
		{
			func_1725(var_05);
			func_B672();
			level.var_A8A9 = undefined;
			return;
		}

		scripts\common\createfx::func_F3C4(var_06 + ". " + var_05["description"]);
	}

	if(var_01 > level.var_5FE1)
	{
		scripts\common\createfx::func_F3C4("(->) More >");
	}

	scripts\common\createfx::func_F3C4("(x) Exit >");
}

//Function Number: 33
func_1725(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.var_11B7.var_F1B3.size;var_02++)
	{
		var_03 = level.var_11B7.var_F1B3[var_02];
		if(func_B3C8(param_00["mask"],var_03.var_13125["type"]))
		{
			var_03.var_13125[param_00["name"]] = param_00["default"];
		}
	}
}

//Function Number: 34
func_B672()
{
	level.var_5FE0 = 0;
	scripts\common\createfx::func_4152();
	func_F796("none");
}

//Function Number: 35
func_56B8(param_00)
{
	if(!func_B665("none"))
	{
		return;
	}

	scripts\common\createfx::func_4152();
	scripts\common\createfx::func_F3C4("Name: " + param_00.var_13125["fxid"]);
	scripts\common\createfx::func_F3C4("Type: " + param_00.var_13125["type"]);
	scripts\common\createfx::func_F3C4("Origin: " + param_00.var_13125["origin"]);
	scripts\common\createfx::func_F3C4("Angles: " + param_00.var_13125["angles"]);
	if(func_6634())
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = 0;
		for(var_04 = 0;var_04 < level.var_11B7.var_C6C0.size;var_04++)
		{
			var_05 = level.var_11B7.var_C6C0[var_04];
			if(!isdefined(param_00.var_13125[var_05["name"]]))
			{
				continue;
			}

			var_01++;
			if(var_01 < level.var_5FE0)
			{
				continue;
			}

			var_02++;
			scripts\common\createfx::func_F3C4(var_02 + ". " + var_05["description"] + ": " + param_00.var_13125[var_05["name"]]);
			if(var_02 > level.var_5FE1)
			{
				var_03 = 1;
				break;
			}
		}

		if(var_01 > level.var_5FE1)
		{
			scripts\common\createfx::func_F3C4("(->) More >");
		}

		scripts\common\createfx::func_F3C4("(a) Add >");
		scripts\common\createfx::func_F3C4("(x) Exit >");
		return;
	}

	var_01 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < level.var_11B7.var_C6C0.size;var_04++)
	{
		var_05 = level.var_11B7.var_C6C0[var_04];
		if(!isdefined(param_00.var_13125[var_05["name"]]))
		{
			continue;
		}

		var_01++;
		scripts\common\createfx::func_F3C4(var_05["description"] + ": " + param_00.var_13125[var_05["name"]]);
		if(var_01 > level.var_11B7.var_917B)
		{
			break;
		}
	}
}

//Function Number: 36
func_5B3D(param_00)
{
	scripts\common\createfx::func_4152();
	var_01 = 0;
	var_02 = 0;
	var_03 = scripts\common\createfx::func_74C7();
	if(!isdefined(param_00))
	{
		param_00 = "Pick an effect";
	}

	scripts\common\createfx::func_F3C4(param_00 + " [" + level.var_5FE0 + " - " + var_03.size + "]:");
	for(var_04 = level.var_5FE0;var_04 < var_03.size;var_04++)
	{
		var_01 = var_01 + 1;
		scripts\common\createfx::func_F3C4(var_01 + ". " + var_03[var_04]);
		if(var_01 >= level.var_5FE1)
		{
			var_02 = 1;
			break;
		}
	}

	if(var_03.size > level.var_5FE1)
	{
		scripts\common\createfx::func_F3C4("(->) More >");
		scripts\common\createfx::func_F3C4("(<-) Previous >");
	}
}

//Function Number: 37
func_93F3()
{
	var_00 = scripts\common\createfx::func_74C7();
	if(level.var_5FE0 >= var_00.size - level.var_5FE1)
	{
		level.var_5FE0 = 0;
		return;
	}

	level.var_5FE0 = level.var_5FE0 + level.var_5FE1;
}

//Function Number: 38
func_4FBC()
{
	level.var_5FE0 = level.var_5FE0 - level.var_5FE1;
	if(level.var_5FE0 < 0)
	{
		var_00 = scripts\common\createfx::func_74C7();
		level.var_5FE0 = var_00.size - level.var_5FE1;
	}
}

//Function Number: 39
func_F191()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = scripts\common\createfx::func_74C7();
	for(var_03 = level.var_5FE0;var_03 < var_02.size;var_03++)
	{
		var_00 = var_00 + 1;
		var_04 = var_00;
		if(var_04 == 10)
		{
			var_04 = 0;
		}

		if(scripts\common\createfx::func_32DF(var_04 + ""))
		{
			var_01 = var_02[var_03];
			break;
		}

		if(var_00 > level.var_5FE1)
		{
			break;
		}
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_05 = [];
	foreach(var_03, var_07 in level.var_49C9)
	{
		if(issubstr(var_07.var_13125["fxid"],var_01))
		{
			var_05[var_05.size] = var_03;
		}
	}

	scripts\common\createfx::func_5264();
	scripts\common\createfx::func_F19B(var_05);
	level.var_11B7.var_F191 = 1;
}

//Function Number: 40
func_7A70()
{
	return level.var_11B7.var_F1B3[level.var_11B7.var_F1B3.size - 1];
}
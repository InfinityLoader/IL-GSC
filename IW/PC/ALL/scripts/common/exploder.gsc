/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\exploder.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1623 ms
 * Timestamp: 10/27/2023 12:03:23 AM
*******************************************************************/

//Function Number: 1
func_F9A6(param_00)
{
	var_01 = param_00.var_ED84;
	if(!isdefined(level.var_69B8[var_01]))
	{
		level.var_69B8[var_01] = [];
	}

	var_02 = param_00.var_336;
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	level.var_69B8[var_01][level.var_69B8[var_01].size] = param_00;
	if(func_69AD(param_00))
	{
		param_00 hide();
		return;
	}

	if(func_69AC(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.var_2AF) && param_00.var_2AF & 1)
		{
			if(isdefined(param_00.var_ED5D))
			{
				param_00 connectpaths();
			}
		}

		return;
	}

	if(func_69AB(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.var_2AF) && param_00.var_2AF & 1)
		{
			param_00 connectpaths();
		}
	}
}

//Function Number: 2
func_FAAA()
{
	scripts\common\utility::func_F315();
	level.var_69B8 = [];
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	foreach(var_04 in var_00)
	{
		if(isdefined(var_04.var_EE89))
		{
			var_04.var_ED84 = var_04.var_EE89;
		}

		if(isdefined(var_04.var_B3CC))
		{
			continue;
		}

		if(isdefined(var_04.var_ED84))
		{
			func_F9A6(var_04);
		}
	}

	var_06 = [];
	var_07 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].var_EE89))
		{
			var_07[var_02].var_ED84 = var_07[var_02].var_EE89;
		}

		if(isdefined(var_07[var_02].var_ED84))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].var_EE89))
		{
			var_07[var_02].var_ED84 = var_07[var_02].var_EE89;
		}

		if(isdefined(var_07[var_02].var_ED84))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].var_EE89))
		{
			var_07[var_02].var_ED84 = var_07[var_02].var_EE89;
		}

		if(isdefined(var_07[var_02].var_ED84))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = level.struct;
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(!isdefined(var_07[var_02]))
		{
			continue;
		}

		if(isdefined(var_07[var_02].var_EE89))
		{
			var_07[var_02].var_ED84 = var_07[var_02].var_EE89;
		}

		if(isdefined(var_07[var_02].var_ED84))
		{
			if(!isdefined(var_07[var_02].angles))
			{
				var_07[var_02].angles = (0,0,0);
			}

			var_06[var_06.size] = var_07[var_02];
		}
	}

	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	var_08 = [];
	var_08["exploderchunk visible"] = 1;
	var_08["exploderchunk"] = 1;
	var_08["exploder"] = 1;
	thread func_F97F();
	for(var_02 = 0;var_02 < var_06.size;var_02++)
	{
		var_09 = var_06[var_02];
		var_04 = scripts\common\utility::func_49AE(var_09.script_fxid);
		var_04.var_13125 = [];
		var_04.var_13125["origin"] = var_09.origin;
		var_04.var_13125["angles"] = var_09.angles;
		var_04.var_13125["delay"] = var_09.script_delay;
		var_04.var_13125["delay_post"] = var_09.var_ED51;
		var_04.var_13125["firefx"] = var_09.var_ED93;
		var_04.var_13125["firefxdelay"] = var_09.var_ED94;
		var_04.var_13125["firefxsound"] = var_09.var_ED95;
		var_04.var_13125["earthquake"] = var_09.var_ED76;
		var_04.var_13125["rumble"] = var_09.var_EEA0;
		var_04.var_13125["damage"] = var_09.var_ED41;
		var_04.var_13125["damage_radius"] = var_09.var_EE8F;
		var_04.var_13125["soundalias"] = var_09.var_EEB1;
		var_04.var_13125["repeat"] = var_09.var_EE94;
		var_04.var_13125["delay_min"] = var_09.var_ED50;
		var_04.var_13125["delay_max"] = var_09.var_ED4F;
		var_04.var_13125["target"] = var_09.target;
		var_04.var_13125["ender"] = var_09.var_ED78;
		var_04.var_13125["physics"] = var_09.var_EE82;
		var_04.var_13125["type"] = "exploder";
		if(!isdefined(var_09.script_fxid))
		{
			var_04.var_13125["fxid"] = "No FX";
		}
		else
		{
			var_04.var_13125["fxid"] = var_09.script_fxid;
		}

		var_04.var_13125["exploder"] = var_09.var_ED84;
		if(isdefined(level.var_49CA))
		{
			var_0A = level.var_49CA[var_04.var_13125["exploder"]];
			if(!isdefined(var_0A))
			{
				var_0A = [];
			}

			var_0A[var_0A.size] = var_04;
			level.var_49CA[var_04.var_13125["exploder"]] = var_0A;
		}

		if(!isdefined(var_04.var_13125["delay"]))
		{
			var_04.var_13125["delay"] = 0;
		}

		if(isdefined(var_09.target))
		{
			var_0B = getentarray(var_04.var_13125["target"],"targetname")[0];
			if(isdefined(var_0B))
			{
				var_0C = var_0B.origin;
				var_04.var_13125["angles"] = vectortoangles(var_0C - var_04.var_13125["origin"]);
			}
			else
			{
				var_0B = scripts\common\utility::get_target_ent(var_04.var_13125["target"]);
				if(isdefined(var_0B))
				{
					var_0C = var_0B.origin;
					var_04.var_13125["angles"] = vectortoangles(var_0C - var_04.var_13125["origin"]);
				}
			}
		}

		if(!isdefined(var_09.var_9F))
		{
			var_04.model = var_09;
			if(isdefined(var_04.model.var_EE24))
			{
				precachemodel(var_04.model.var_EE24);
			}
		}
		else if(var_09.var_9F == "script_brushmodel" || isdefined(var_09.model))
		{
			var_04.model = var_09;
			var_04.model.var_5635 = var_09.var_ED5D;
		}

		if(isdefined(var_09.var_336) && isdefined(var_08[var_09.var_336]))
		{
			var_04.var_13125["exploder_type"] = var_09.var_336;
		}
		else
		{
			var_04.var_13125["exploder_type"] = "normal";
		}

		if(isdefined(var_09.var_B3CC))
		{
			var_04.var_13125["masked_exploder"] = var_09.model;
			var_04.var_13125["masked_exploder_spawnflags"] = var_09.var_2AF;
			var_04.var_13125["masked_exploder_script_disconnectpaths"] = var_09.var_ED5D;
			var_09 delete();
		}

		var_04 scripts\common\createfx::func_D6CF();
	}
}

//Function Number: 3
func_F97F()
{
	waittillframeend;
	waittillframeend;
	waittillframeend;
	var_00 = [];
	foreach(var_02 in level.var_49C9)
	{
		if(var_02.var_13125["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.var_13125["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == "nil")
		{
			var_02.var_13125["flag"] = undefined;
		}

		var_00[var_03] = 1;
	}

	foreach(var_07, var_06 in var_00)
	{
		thread func_69A9(var_07);
	}
}

//Function Number: 4
func_69A9(param_00)
{
	if(!scripts\common\utility::func_6E34(param_00))
	{
		scripts\common\utility::flag_init(param_00);
	}

	scripts\common\utility::flag_wait(param_00);
	foreach(var_02 in level.var_49C9)
	{
		if(var_02.var_13125["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.var_13125["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 != param_00)
		{
			continue;
		}

		var_02 scripts\common\utility::func_15B8();
	}
}

//Function Number: 5
func_69AC(param_00)
{
	return isdefined(param_00.var_336) && param_00.var_336 == "exploder";
}

//Function Number: 6
func_69AD(param_00)
{
	return param_00.model == "fx" && !isdefined(param_00.var_336) || param_00.var_336 != "exploderchunk";
}

//Function Number: 7
func_69AB(param_00)
{
	return isdefined(param_00.var_336) && param_00.var_336 == "exploderchunk";
}

//Function Number: 8
func_100DB(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.var_49CA))
	{
		var_01 = level.var_49CA[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!func_69AD(var_03.model) && !func_69AC(var_03.model) && !func_69AB(var_03.model))
				{
					var_03.model show();
				}

				if(isdefined(var_03.var_3103))
				{
					var_03.model show();
				}
			}

			return;
		}

		return;
	}

	var_05 = 0;
	while(var_03 < level.var_49C9.size)
	{
		var_05 = level.var_49C9[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_13125["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_13125["exploder"]))
		{
			continue;
		}

		if(var_05.var_13125["exploder"] + "" != var_02)
		{
			continue;
		}

		if(isdefined(var_05.model))
		{
			if(!func_69AD(var_05.model) && !func_69AC(var_05.model) && !func_69AB(var_05.model))
			{
				var_05.model show();
			}

			if(isdefined(var_05.var_3103))
			{
				var_05.model show();
			}
		}

		var_03++;
	}
}

//Function Number: 9
func_10FED(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.var_49CA))
	{
		var_01 = level.var_49CA[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!isdefined(var_03.var_B051))
				{
					continue;
				}

				if(isdefined(var_03.var_B066))
				{
					var_03.var_B066 stoploopsound();
					var_03.var_B066 delete();
				}

				var_03.var_B051 delete();
			}

			return;
		}

		return;
	}

	var_05 = 0;
	while(var_03 < level.var_49C9.size)
	{
		var_05 = level.var_49C9[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_13125["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_13125["exploder"]))
		{
			continue;
		}

		if(var_05.var_13125["exploder"] + "" != var_02)
		{
			continue;
		}

		if(!isdefined(var_05.var_B051))
		{
			continue;
		}

		if(isdefined(var_05.var_B066))
		{
			var_05.var_B066 stoploopsound();
			var_05.var_B066 delete();
		}

		var_05.var_B051 delete();
		var_03++;
	}
}

//Function Number: 10
func_79A7(param_00)
{
	param_00 = param_00 + "";
	var_01 = [];
	if(isdefined(level.var_49CA))
	{
		var_02 = level.var_49CA[param_00];
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
	}
	else
	{
		foreach(var_04 in level.var_49C9)
		{
			if(var_04.var_13125["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_04.var_13125["exploder"]))
			{
				continue;
			}

			if(var_04.var_13125["exploder"] + "" != param_00)
			{
				continue;
			}

			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}

//Function Number: 11
func_8E81(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.var_49CA))
	{
		var_01 = level.var_49CA[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.model))
				{
					var_03.model hide();
				}
			}

			return;
		}

		return;
	}

	var_05 = 0;
	while(var_03 < level.var_49C9.size)
	{
		var_05 = level.var_49C9[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_13125["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_13125["exploder"]))
		{
			continue;
		}

		if(var_05.var_13125["exploder"] + "" != var_02)
		{
			continue;
		}

		if(isdefined(var_05.model))
		{
			var_05.model hide();
		}

		var_03++;
	}
}

//Function Number: 12
func_5152(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.var_49CA))
	{
		var_01 = level.var_49CA[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.model))
				{
					var_03.model delete();
				}
			}
		}
	}
	else
	{
		for(var_05 = 0;var_05 < level.var_49C9.size;var_05++)
		{
			var_03 = level.var_49C9[var_05];
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.var_13125["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_03.var_13125["exploder"]))
			{
				continue;
			}

			if(var_03.var_13125["exploder"] + "" != param_00)
			{
				continue;
			}

			if(isdefined(var_03.model))
			{
				var_03.model delete();
			}
		}
	}

	level notify("killexplodertridgers" + param_00);
}

//Function Number: 13
func_69A6()
{
	if(isdefined(self.var_13125["delay"]))
	{
		var_00 = self.var_13125["delay"];
	}
	else
	{
		var_00 = 0;
	}

	if(isdefined(self.var_13125["damage_radius"]))
	{
		var_01 = self.var_13125["damage_radius"];
	}
	else
	{
		var_01 = 128;
	}

	var_02 = self.var_13125["damage"];
	var_03 = self.var_13125["origin"];
	wait(var_00);
	if(isdefined(level.var_4C6F))
	{
		[[ level.var_4C6F ]](var_03,var_01,var_02);
		return;
	}

	radiusdamage(var_03,var_01,var_02,var_02);
}

//Function Number: 14
func_15B9()
{
	if(isdefined(self.var_13125["firefx"]))
	{
		thread func_6CF5();
	}

	if(isdefined(self.var_13125["fxid"]) && self.var_13125["fxid"] != "No FX")
	{
		thread func_38D4();
	}
	else if(isdefined(self.var_13125["soundalias"]) && self.var_13125["soundalias"] != "nil")
	{
		thread func_1045A();
	}

	if(isdefined(self.var_13125["loopsound"]) && self.var_13125["loopsound"] != "nil")
	{
		thread func_5FE2();
	}

	if(isdefined(self.var_13125["damage"]))
	{
		thread func_69A6();
	}

	if(isdefined(self.var_13125["earthquake"]))
	{
		thread func_69A8();
	}

	if(isdefined(self.var_13125["rumble"]))
	{
		thread func_69B0();
	}

	if(self.var_13125["exploder_type"] == "exploder")
	{
		thread func_3102();
		return;
	}

	if(self.var_13125["exploder_type"] == "exploderchunk" || self.var_13125["exploder_type"] == "exploderchunk visible")
	{
		thread func_3104();
		return;
	}

	thread func_3101();
}

//Function Number: 15
func_3101()
{
	var_00 = self.var_13125["exploder"];
	if(isdefined(self.var_13125["delay"]))
	{
		wait(self.var_13125["delay"]);
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self.model))
	{
		return;
	}

	if(isdefined(self.model.classname))
	{
		if(!function_02A4(self.model) && isdefined(self.model.classname))
		{
			if(scripts\common\utility::issp() && self.model.var_2AF & 1)
			{
				self.model [[ level.var_74C2["connectPaths"] ]]();
			}
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_699E))
		{
			return;
		}

		self.var_699E = 1;
		self.model hide();
		self.model notsolid();
		wait(3);
		self.var_699E = undefined;
		self.model show();
		self.model solid();
		return;
	}

	if(!isdefined(self.var_13125["fxid"]) || self.var_13125["fxid"] == "No FX")
	{
		self.var_13125["exploder"] = undefined;
	}

	waittillframeend;
	if(isdefined(self.model) && !function_02A4(self.model) && isdefined(self.model.classname))
	{
		self.model delete();
	}
}

//Function Number: 16
func_3104()
{
	if(isdefined(self.var_13125["delay"]))
	{
		wait(self.var_13125["delay"]);
	}

	var_00 = undefined;
	if(isdefined(self.var_13125["target"]))
	{
		var_00 = scripts\common\utility::get_target_ent(self.var_13125["target"]);
	}

	if(!isdefined(var_00))
	{
		self.model delete();
		return;
	}

	self.model show();
	if(isdefined(self.var_13125["delay_post"]))
	{
		wait(self.var_13125["delay_post"]);
	}

	var_01 = self.var_13125["origin"];
	var_02 = self.var_13125["angles"];
	var_03 = var_00.origin;
	var_04 = isdefined(self.var_13125["physics"]);
	if(var_04)
	{
		var_05 = undefined;
		if(isdefined(var_00.target))
		{
			var_05 = var_00 scripts\common\utility::get_target_ent();
		}

		if(isdefined(var_05))
		{
			var_06 = var_00.origin;
			var_07 = vectornormalize(var_05.origin - var_00.origin);
		}
		else
		{
			var_06 = self.model.origin;
			var_07 = vectornormalize(var_04 - self.model.origin);
		}

		var_07 = var_07 * self.var_13125["physics"];
		self.model physicslaunchserver(var_06,var_07);
		return;
	}
	else
	{
		var_07 = var_06 - self.model.origin;
		self.model rotatevelocity(var_07,12);
		self.model movegravity(var_07,12);
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_699E))
		{
			return;
		}

		self.var_699E = 1;
		wait(3);
		self.var_699E = undefined;
		self.var_13125["origin"] = var_03;
		self.var_13125["angles"] = var_04;
		self.model hide();
		return;
	}

	self.var_13125["exploder"] = undefined;
	wait(6);
	self.model delete();
}

//Function Number: 17
func_3102()
{
	if(isdefined(self.var_13125["delay"]))
	{
		wait(self.var_13125["delay"]);
	}

	if(!isdefined(self.model.var_EE24))
	{
		self.model show();
		self.model solid();
	}
	else
	{
		var_00 = self.model scripts\common\utility::spawn_tag_origin();
		if(isdefined(self.model.var_27C))
		{
			var_00.var_27C = self.model.var_27C;
		}

		var_00 setmodel(self.model.var_EE24);
		var_00 show();
	}

	self.var_3103 = 1;
	if(scripts\common\utility::issp() && !isdefined(self.model.var_EE24) && self.model.var_2AF & 1)
	{
		if(!isdefined(self.model.var_5635))
		{
			self.model [[ level.var_74C2["connectPaths"] ]]();
		}
		else
		{
			self.model [[ level.var_74C2["disconnectPaths"] ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.var_699E))
		{
			return;
		}

		self.var_699E = 1;
		wait(3);
		self.var_699E = undefined;
		if(!isdefined(self.model.var_EE24))
		{
			self.model hide();
			self.model notsolid();
		}
	}
}

//Function Number: 18
func_69B0()
{
	if(!scripts\common\utility::issp())
	{
		return;
	}

	func_69A7();
	level.player playrumbleonentity(self.var_13125["rumble"]);
}

//Function Number: 19
func_69A7()
{
	if(!isdefined(self.var_13125["delay"]))
	{
		self.var_13125["delay"] = 0;
	}

	var_00 = self.var_13125["delay"];
	var_01 = self.var_13125["delay"] + 0.001;
	if(isdefined(self.var_13125["delay_min"]))
	{
		var_00 = self.var_13125["delay_min"];
	}

	if(isdefined(self.var_13125["delay_max"]))
	{
		var_01 = self.var_13125["delay_max"];
	}

	if(var_00 > 0)
	{
		wait(randomfloatrange(var_00,var_01));
	}
}

//Function Number: 20
func_5FE2()
{
	if(isdefined(self.var_B066))
	{
		self.var_B066 stoploopsound();
		self.var_B066 delete();
	}

	var_00 = self.var_13125["origin"];
	var_01 = self.var_13125["loopsound"];
	func_69A7();
	self.var_B066 = scripts\common\utility::play_loopsound_in_space(var_01,var_00);
}

//Function Number: 21
func_1045A()
{
	func_5FE6();
}

//Function Number: 22
func_5FE6()
{
	var_00 = self.var_13125["origin"];
	var_01 = self.var_13125["soundalias"];
	func_69A7();
	scripts\common\utility::play_sound_in_space(var_01,var_00);
}

//Function Number: 23
func_69A8()
{
	func_69A7();
	scripts\common\utility::func_577E(self.var_13125["earthquake"],self.var_13125["origin"]);
}

//Function Number: 24
func_69AF()
{
	if(!isdefined(self.var_13125["soundalias"]) || self.var_13125["soundalias"] == "nil")
	{
		return;
	}

	scripts\common\utility::play_sound_in_space(self.var_13125["soundalias"],self.var_13125["origin"]);
}

//Function Number: 25
func_6CF5()
{
	var_00 = self.var_13125["forward"];
	var_01 = self.var_13125["up"];
	var_02 = undefined;
	var_03 = self.var_13125["firefxsound"];
	var_04 = self.var_13125["origin"];
	var_05 = self.var_13125["firefx"];
	var_06 = self.var_13125["ender"];
	if(!isdefined(var_06))
	{
		var_06 = "createfx_effectStopper";
	}

	var_07 = 0.5;
	if(isdefined(self.var_13125["firefxdelay"]))
	{
		var_07 = self.var_13125["firefxdelay"];
	}

	func_69A7();
	if(isdefined(var_03))
	{
		scripts\common\utility::func_B040(var_03,var_04,1,var_06);
	}

	playfx(level._effect[var_05],self.var_13125["origin"],var_00,var_01);
}

//Function Number: 26
func_38D4()
{
	if(isdefined(self.var_13125["repeat"]))
	{
		thread func_69AF();
		for(var_00 = 0;var_00 < self.var_13125["repeat"];var_00++)
		{
			playfx(level._effect[self.var_13125["fxid"]],self.var_13125["origin"],self.var_13125["forward"],self.var_13125["up"]);
			func_69A7();
		}

		return;
	}

	func_69A7();
	if(isdefined(self.var_B051))
	{
		self.var_B051 delete();
	}

	self.var_B051 = spawnfx(scripts\common\utility::getfx(self.var_13125["fxid"]),self.var_13125["origin"],self.var_13125["forward"],self.var_13125["up"]);
	triggerfx(self.var_B051);
	func_69AF();
}

//Function Number: 27
func_15AC(param_00,param_01,param_02)
{
	param_00 = param_00 + "";
	level notify("exploding_" + param_00);
	var_03 = 0;
	if(isdefined(level.var_49CA) && !level.createfx_enabled)
	{
		var_04 = level.var_49CA[param_00];
		if(isdefined(var_04))
		{
			foreach(var_06 in var_04)
			{
				var_06 scripts\common\utility::func_15B8();
				var_03 = 1;
			}
		}
	}
	else
	{
		for(var_08 = 0;var_08 < level.var_49C9.size;var_08++)
		{
			var_06 = level.var_49C9[var_08];
			if(!isdefined(var_06))
			{
				continue;
			}

			if(var_06.var_13125["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_06.var_13125["exploder"]))
			{
				continue;
			}

			if(var_06.var_13125["exploder"] + "" != param_00)
			{
				continue;
			}

			var_06 scripts\common\utility::func_15B8();
			var_03 = 1;
		}
	}

	if(!func_10071() && !var_03)
	{
		func_1596(param_00,param_01,param_02);
	}
}

//Function Number: 28
func_1596(param_00,param_01,param_02)
{
	if(!func_9D01(param_00))
	{
		return;
	}

	var_03 = int(param_00);
	activateclientexploder(var_03,param_01,param_02);
}

//Function Number: 29
func_9D01(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00;
	if(isstring(param_00))
	{
		var_01 = int(param_00);
		if(var_01 == 0 && param_00 != "0")
		{
			return 0;
		}
	}

	return var_01 >= 0;
}

//Function Number: 30
func_10071()
{
	if(scripts\common\utility::issp())
	{
		return 1;
	}

	if(!isdefined(level.createfx_enabled))
	{
		scripts\common\utility::func_F315();
	}

	if(level.createfx_enabled)
	{
		return 1;
	}

	return getdvar("clientSideEffects") != "1";
}

//Function Number: 31
func_69A5(param_00,param_01,param_02)
{
	waittillframeend;
	waittillframeend;
	func_15AC(param_00,param_01,param_02);
}

//Function Number: 32
func_69A4(param_00,param_01,param_02)
{
	func_15AC(param_00,param_01,param_02);
}
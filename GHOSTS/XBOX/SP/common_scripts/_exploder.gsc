/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_exploder.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 570 ms
 * Timestamp: 10/27/2023 1:38:53 AM
*******************************************************************/

//Function Number: 1
setup_individual_exploder(param_00)
{
	var_01 = param_00.script_exploder;
	if(!isdefined(level.exploders[var_01]))
	{
		level.exploders[var_01] = [];
	}

	var_02 = param_00.targetname;
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	level.exploders[var_01][level.exploders[var_01].size] = param_00;
	if(func_30BF(param_00))
	{
		param_00 hide();
		return;
	}

	if(func_30BE(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.spawnflags) && param_00.spawnflags & 1)
		{
			if(isdefined(param_00.script_disconnectpaths))
			{
				param_00 connectpaths();
			}
		}

		return;
	}

	if(exploder_model_is_chunk(param_00))
	{
		param_00 hide();
		param_00 notsolid();
		if(isdefined(param_00.spawnflags) && param_00.spawnflags & 1)
		{
			param_00 connectpaths();
		}
	}
}

//Function Number: 2
func_71F8()
{
	level.exploders = [];
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	foreach(var_04 in var_00)
	{
		if(isdefined(var_04.script_prefab_exploder))
		{
			var_04.script_exploder = var_04.script_prefab_exploder;
		}

		if(isdefined(var_04.masked_exploder))
		{
			continue;
		}

		if(isdefined(var_04.script_exploder))
		{
			setup_individual_exploder(var_04);
		}
	}

	var_06 = [];
	var_07 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			var_06[var_06.size] = var_07[var_02];
		}
	}

	var_07 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_07.size;var_02++)
	{
		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
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

		if(isdefined(var_07[var_02].script_prefab_exploder))
		{
			var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
		}

		if(isdefined(var_07[var_02].script_exploder))
		{
			if(!isdefined(var_07[var_02].angles))
			{
				var_07[var_02].angles = (0,0,0);
			}

			var_06[var_06.size] = var_07[var_02];
		}
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	var_08 = [];
	var_08["exploderchunk visible"] = 1;
	var_08["exploderchunk"] = 1;
	var_08["exploder"] = 1;
	thread func_7152();
	for(var_02 = 0;var_02 < var_06.size;var_02++)
	{
		var_09 = var_06[var_02];
		var_04 = common_scripts\utility::createexploder(var_09.script_fxid);
		var_04.var_880E = [];
		var_04.var_880E["origin"] = var_09.origin;
		var_04.var_880E["angles"] = var_09.angles;
		var_04.var_880E["delay"] = var_09.script_delay;
		var_04.var_880E["delay_post"] = var_09.script_delay_post;
		var_04.var_880E["firefx"] = var_09.script_firefx;
		var_04.var_880E["firefxdelay"] = var_09.script_firefxdelay;
		var_04.var_880E["firefxsound"] = var_09.script_firefxsound;
		var_04.var_880E["earthquake"] = var_09.script_earthquake;
		var_04.var_880E["rumble"] = var_09.script_rumble;
		var_04.var_880E["damage"] = var_09.script_damage;
		var_04.var_880E["damage_radius"] = var_09.script_radius;
		var_04.var_880E["soundalias"] = var_09.script_soundalias;
		var_04.var_880E["repeat"] = var_09.script_repeat;
		var_04.var_880E["delay_min"] = var_09.script_delay_min;
		var_04.var_880E["delay_max"] = var_09.script_delay_max;
		var_04.var_880E["target"] = var_09.target;
		var_04.var_880E["ender"] = var_09.script_ender;
		var_04.var_880E["physics"] = var_09.script_physics;
		var_04.var_880E["type"] = "exploder";
		if(!isdefined(var_09.script_fxid))
		{
			var_04.var_880E["fxid"] = "No FX";
		}
		else
		{
			var_04.var_880E["fxid"] = var_09.script_fxid;
		}

		var_04.var_880E["exploder"] = var_09.script_exploder;
		if(isdefined(level.createfxexploders))
		{
			var_0A = level.createfxexploders[var_04.var_880E["exploder"]];
			if(!isdefined(var_0A))
			{
				var_0A = [];
			}

			var_0A[var_0A.size] = var_04;
			level.createfxexploders[var_04.var_880E["exploder"]] = var_0A;
		}

		if(!isdefined(var_04.var_880E["delay"]))
		{
			var_04.var_880E["delay"] = 0;
		}

		if(isdefined(var_09.target))
		{
			var_0B = getentarray(var_04.var_880E["target"],"targetname")[0];
			if(isdefined(var_0B))
			{
				var_0C = var_0B.origin;
				var_04.var_880E["angles"] = vectortoangles(var_0C - var_04.var_880E["origin"]);
			}
			else
			{
				var_0B = common_scripts\utility::func_39BD(var_04.var_880E["target"]);
				if(isdefined(var_0B))
				{
					var_0C = var_0B.origin;
					var_04.var_880E["angles"] = vectortoangles(var_0C - var_04.var_880E["origin"]);
				}
			}
		}

		if(!isdefined(var_09.code_classname))
		{
			var_04.model = var_09;
			if(isdefined(var_04.model.script_modelname))
			{
				precachemodel(var_04.model.script_modelname);
			}
		}
		else if(var_09.code_classname == "script_brushmodel" || isdefined(var_09.model))
		{
			var_04.model = var_09;
			var_04.model.disconnect_paths = var_09.script_disconnectpaths;
		}

		if(isdefined(var_09.targetname) && isdefined(var_08[var_09.targetname]))
		{
			var_04.var_880E["exploder_type"] = var_09.targetname;
		}
		else
		{
			var_04.var_880E["exploder_type"] = "normal";
		}

		if(isdefined(var_09.masked_exploder))
		{
			var_04.var_880E["masked_exploder"] = var_09.model;
			var_04.var_880E["masked_exploder_spawnflags"] = var_09.spawnflags;
			var_04.var_880E["masked_exploder_script_disconnectpaths"] = var_09.script_disconnectpaths;
			var_09 delete();
		}

		var_04 common_scripts\_createfx::func_60C3();
	}
}

//Function Number: 3
func_7152()
{
	waittillframeend;
	waittillframeend;
	waittillframeend;
	var_00 = [];
	foreach(var_02 in level.createfxent)
	{
		if(var_02.var_880E["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.var_880E["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == "nil")
		{
			var_02.var_880E["flag"] = undefined;
		}

		var_00[var_03] = 1;
	}

	foreach(var_07, var_06 in var_00)
	{
		thread exploder_flag_wait(var_07);
	}
}

//Function Number: 4
exploder_flag_wait(param_00)
{
	if(!common_scripts\utility::flag_exist(param_00))
	{
		common_scripts\utility::func_3385(param_00);
	}

	common_scripts\utility::flag_wait(param_00);
	foreach(var_02 in level.createfxent)
	{
		if(var_02.var_880E["type"] != "exploder")
		{
			continue;
		}

		var_03 = var_02.var_880E["flag"];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 != param_00)
		{
			continue;
		}

		var_02 common_scripts\utility::activate_individual_exploder();
	}
}

//Function Number: 5
func_30BE(param_00)
{
	return isdefined(param_00.targetname) && param_00.targetname == "exploder";
}

//Function Number: 6
func_30BF(param_00)
{
	return param_00.model == "fx" && !isdefined(param_00.targetname) || param_00.targetname != "exploderchunk";
}

//Function Number: 7
exploder_model_is_chunk(param_00)
{
	return isdefined(param_00.targetname) && param_00.targetname == "exploderchunk";
}

//Function Number: 8
func_74E1(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!func_30BF(var_03.model) && !func_30BE(var_03.model) && !exploder_model_is_chunk(var_03.model))
				{
					var_03.model show();
				}

				if(isdefined(var_03.brush_shown))
				{
					var_03.model show();
				}
			}
		}
	}

	var_05 = 0;
	while(var_03 < level.createfxent.size)
	{
		var_05 = level.createfxent[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_880E["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_880E["exploder"]))
		{
			continue;
		}

		if(var_05.var_880E["exploder"] + "" != var_02)
		{
			continue;
		}

		if(isdefined(var_05.model))
		{
			if(!func_30BF(var_05.model) && !func_30BE(var_05.model) && !exploder_model_is_chunk(var_05.model))
			{
				var_05.model show();
			}

			if(isdefined(var_05.brush_shown))
			{
				var_05.model show();
			}
		}

		var_03++;
	}
}

//Function Number: 9
func_7C23(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!isdefined(var_03.looper))
				{
					continue;
				}

				var_03.looper delete();
			}
		}
	}

	var_05 = 0;
	while(var_03 < level.createfxent.size)
	{
		var_05 = level.createfxent[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_880E["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_880E["exploder"]))
		{
			continue;
		}

		if(var_05.var_880E["exploder"] + "" != var_02)
		{
			continue;
		}

		if(!isdefined(var_05.looper))
		{
			continue;
		}

		var_05.looper delete();
		var_03++;
	}
}

//Function Number: 10
func_3876(param_00)
{
	param_00 = param_00 + "";
	var_01 = [];
	if(isdefined(level.createfxexploders))
	{
		var_02 = level.createfxexploders[param_00];
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
	}
	else
	{
		foreach(var_04 in level.createfxent)
		{
			if(var_04.var_880E["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_04.var_880E["exploder"]))
			{
				continue;
			}

			if(var_04.var_880E["exploder"] + "" != param_00)
			{
				continue;
			}

			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}

//Function Number: 11
func_41DE(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.model))
				{
					var_03.model hide();
				}
			}
		}
	}

	var_05 = 0;
	while(var_03 < level.createfxent.size)
	{
		var_05 = level.createfxent[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_880E["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_880E["exploder"]))
		{
			continue;
		}

		if(var_05.var_880E["exploder"] + "" != var_02)
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
func_254E(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders[param_00];
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
		for(var_05 = 0;var_05 < level.createfxent.size;var_05++)
		{
			var_03 = level.createfxent[var_05];
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.var_880E["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_03.var_880E["exploder"]))
			{
				continue;
			}

			if(var_03.var_880E["exploder"] + "" != param_00)
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
exploder_damage()
{
	if(isdefined(self.var_880E["delay"]))
	{
		var_00 = self.var_880E["delay"];
	}
	else
	{
		var_00 = 0;
	}

	if(isdefined(self.var_880E["damage_radius"]))
	{
		var_01 = self.var_880E["damage_radius"];
	}
	else
	{
		var_01 = 128;
	}

	var_02 = self.var_880E["damage"];
	var_03 = self.var_880E["origin"];
	wait(var_00);
	if(isdefined(level.custom_radius_damage_for_exploders))
	{
		[[ level.custom_radius_damage_for_exploders ]](var_03,var_01,var_02);
	}

	radiusdamage(var_03,var_01,var_02,var_02);
}

//Function Number: 14
activate_individual_exploder_proc()
{
	if(isdefined(self.var_880E["firefx"]))
	{
		thread func_32B5();
	}

	if(isdefined(self.var_880E["fxid"]) && self.var_880E["fxid"] != "No FX")
	{
		thread func_19D2();
	}
	else if(isdefined(self.var_880E["soundalias"]) && self.var_880E["soundalias"] != "nil")
	{
		thread sound_effect();
	}

	if(isdefined(self.var_880E["loopsound"]) && self.var_880E["loopsound"] != "nil")
	{
		thread func_2BEE();
	}

	if(isdefined(self.var_880E["damage"]))
	{
		thread exploder_damage();
	}

	if(isdefined(self.var_880E["earthquake"]))
	{
		thread exploder_earthquake();
	}

	if(isdefined(self.var_880E["rumble"]))
	{
		thread func_30C2();
	}

	if(self.var_880E["exploder_type"] == "exploder")
	{
		thread func_17F6();
	}

	if(self.var_880E["exploder_type"] == "exploderchunk" || self.var_880E["exploder_type"] == "exploderchunk visible")
	{
		thread func_17F8();
	}

	thread func_17F5();
}

//Function Number: 15
func_17F5()
{
	var_00 = self.var_880E["exploder"];
	if(isdefined(self.var_880E["delay"]))
	{
		wait(self.var_880E["delay"]);
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self.model))
	{
	}

	if(isdefined(self.model.classname))
	{
		if(common_scripts\utility::issp() && self.model.spawnflags & 1)
		{
			self.model [[ level.connectpathsfunction ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
		}

		self.exploded = 1;
		self.model hide();
		self.model notsolid();
		wait(3);
		self.exploded = undefined;
		self.model show();
		self.model solid();
	}

	if(!isdefined(self.var_880E["fxid"]) || self.var_880E["fxid"] == "No FX")
	{
		self.var_880E["exploder"] = undefined;
	}

	waittillframeend;
	if(isdefined(self.model) && isdefined(self.model.classname))
	{
		self.model delete();
	}
}

//Function Number: 16
func_17F8()
{
	if(isdefined(self.var_880E["delay"]))
	{
		wait(self.var_880E["delay"]);
	}

	var_00 = undefined;
	if(isdefined(self.var_880E["target"]))
	{
		var_00 = common_scripts\utility::func_39BD(self.var_880E["target"]);
	}

	if(!isdefined(var_00))
	{
		self.model delete();
	}

	self.model show();
	if(isdefined(self.var_880E["delay_post"]))
	{
		wait(self.var_880E["delay_post"]);
	}

	var_01 = self.var_880E["origin"];
	var_02 = self.var_880E["angles"];
	var_03 = var_00.origin;
	var_04 = var_03 - self.var_880E["origin"];
	var_05 = var_04[0];
	var_06 = var_04[1];
	var_07 = var_04[2];
	var_08 = isdefined(self.var_880E["physics"]);
	if(var_08)
	{
		var_09 = undefined;
		if(isdefined(var_00.target))
		{
			var_09 = var_00 common_scripts\utility::func_39BD();
		}

		if(!isdefined(var_09))
		{
			var_0A = var_01;
			var_0B = var_00.origin;
		}
		else
		{
			var_0A = var_02.origin;
			var_0B = var_0A.origin - var_01.origin * self.var_880E["physics"];
		}

		self.model physicslaunchclient(var_0A,var_0B);
	}
	else
	{
		self.model rotatevelocity((var_08,var_09,var_0A),12);
		self.model gravitymove((var_08,var_09,var_0A),12);
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
		}

		self.exploded = 1;
		wait(3);
		self.exploded = undefined;
		self.var_880E["origin"] = var_04;
		self.var_880E["angles"] = var_05;
		self.model hide();
	}

	self.var_880E["exploder"] = undefined;
	wait(6);
	self.model delete();
}

//Function Number: 17
func_17F6()
{
	if(isdefined(self.var_880E["delay"]))
	{
		wait(self.var_880E["delay"]);
	}

	if(!isdefined(self.model.script_modelname))
	{
		self.model show();
		self.model solid();
	}
	else
	{
		var_00 = self.model common_scripts\utility::func_7836();
		if(isdefined(self.model.script_linkname))
		{
			var_00.script_linkname = self.model.script_linkname;
		}

		var_00 setmodel(self.model.script_modelname);
		var_00 show();
	}

	self.brush_shown = 1;
	if(common_scripts\utility::issp() && !isdefined(self.model.script_modelname) && self.model.spawnflags & 1)
	{
		if(!isdefined(self.model.disconnect_paths))
		{
			self.model [[ level.connectpathsfunction ]]();
		}
		else
		{
			self.model [[ level.disconnectpathsfunction ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
		}

		self.exploded = 1;
		wait(3);
		self.exploded = undefined;
		if(!isdefined(self.model.script_modelname))
		{
			self.model hide();
			self.model notsolid();
		}
	}
}

//Function Number: 18
func_30C2()
{
	if(!common_scripts\utility::issp())
	{
	}

	func_30B8();
	level.player playrumbleonentity(self.var_880E["rumble"]);
}

//Function Number: 19
func_30B8()
{
	if(!isdefined(self.var_880E["delay"]))
	{
		self.var_880E["delay"] = 0;
	}

	var_00 = self.var_880E["delay"];
	var_01 = self.var_880E["delay"] + 0.001;
	if(isdefined(self.var_880E["delay_min"]))
	{
		var_00 = self.var_880E["delay_min"];
	}

	if(isdefined(self.var_880E["delay_max"]))
	{
		var_01 = self.var_880E["delay_max"];
	}

	if(var_00 > 0)
	{
		wait(randomfloatrange(var_00,var_01));
	}
}

//Function Number: 20
func_2BEE()
{
	if(isdefined(self.loopsound_ent))
	{
		self.loopsound_ent delete();
	}

	var_00 = self.var_880E["origin"];
	var_01 = self.var_880E["loopsound"];
	func_30B8();
	self.loopsound_ent = common_scripts\utility::func_5CF6(var_01,var_00);
}

//Function Number: 21
sound_effect()
{
	effect_soundalias();
}

//Function Number: 22
effect_soundalias()
{
	var_00 = self.var_880E["origin"];
	var_01 = self.var_880E["soundalias"];
	func_30B8();
	common_scripts\utility::func_5D1F(var_01,var_00);
}

//Function Number: 23
exploder_earthquake()
{
	func_30B8();
	common_scripts\utility::do_earthquake(self.var_880E["earthquake"],self.var_880E["origin"]);
}

//Function Number: 24
func_30C0()
{
	if(!isdefined(self.var_880E["soundalias"]) || self.var_880E["soundalias"] == "nil")
	{
	}

	common_scripts\utility::func_5D1F(self.var_880E["soundalias"],self.var_880E["origin"]);
}

//Function Number: 25
func_32B5()
{
	var_00 = self.var_880E["forward"];
	var_01 = self.var_880E["up"];
	var_02 = undefined;
	var_03 = self.var_880E["firefxsound"];
	var_04 = self.var_880E["origin"];
	var_05 = self.var_880E["firefx"];
	var_06 = self.var_880E["ender"];
	if(!isdefined(var_06))
	{
		var_06 = "createfx_effectStopper";
	}

	var_07 = 0.5;
	if(isdefined(self.var_880E["firefxdelay"]))
	{
		var_07 = self.var_880E["firefxdelay"];
	}

	func_30B8();
	if(isdefined(var_03))
	{
		common_scripts\utility::func_4F68(var_03,var_04,1,var_06);
	}

	playfx(level._effect[var_05],self.var_880E["origin"],var_00,var_01);
}

//Function Number: 26
func_19D2()
{
	if(isdefined(self.var_880E["repeat"]))
	{
		thread func_30C0();
		for(var_00 = 0;var_00 < self.var_880E["repeat"];var_00++)
		{
			playfx(level._effect[self.var_880E["fxid"]],self.var_880E["origin"],self.var_880E["forward"],self.var_880E["up"]);
			func_30B8();
		}
	}

	func_30B8();
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	self.looper = spawnfx(common_scripts\utility::func_3AB9(self.var_880E["fxid"]),self.var_880E["origin"],self.var_880E["forward"],self.var_880E["up"]);
	triggerfx(self.looper);
	func_30C0();
}

//Function Number: 27
activate_exploder(param_00,param_01,param_02)
{
	param_00 = param_00 + "";
	level notify("exploding_" + param_00);
	var_03 = 0;
	if(isdefined(level.createfxexploders) && !level.createfx_enabled)
	{
		var_04 = level.createfxexploders[param_00];
		if(isdefined(var_04))
		{
			foreach(var_06 in var_04)
			{
				var_06 common_scripts\utility::activate_individual_exploder();
				var_03 = 1;
			}
		}
	}
	else
	{
		for(var_08 = 0;var_08 < level.createfxent.size;var_08++)
		{
			var_06 = level.createfxent[var_08];
			if(!isdefined(var_06))
			{
				continue;
			}

			if(var_06.var_880E["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_06.var_880E["exploder"]))
			{
				continue;
			}

			if(var_06.var_880E["exploder"] + "" != param_00)
			{
				continue;
			}

			var_06 common_scripts\utility::activate_individual_exploder();
			var_03 = 1;
		}
	}

	if(!func_74BF() && !var_03)
	{
		activate_clientside_exploder(param_00,param_01,param_02);
	}
}

//Function Number: 28
activate_clientside_exploder(param_00,param_01,param_02)
{
	if(!func_4851(param_00))
	{
	}

	var_03 = castint(param_00);
	getangledelta3d(var_03,param_01,param_02);
}

//Function Number: 29
func_4851(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00;
	if(isstring(param_00))
	{
		var_01 = castint(param_00);
		if(var_01 == 0 && param_00 != "0")
		{
			return 0;
		}
	}

	return var_01 >= 0;
}

//Function Number: 30
func_74BF()
{
	if(common_scripts\utility::issp())
	{
		return 1;
	}

	if(!isdefined(level.createfx_enabled))
	{
		level.createfx_enabled = getdvar("createfx") != "";
	}

	if(level.createfx_enabled)
	{
		return 1;
	}

	return getdvar("clientSideEffects") != "1";
}

//Function Number: 31
func_30B3(param_00,param_01,param_02)
{
	waittillframeend;
	waittillframeend;
	activate_exploder(param_00,param_01,param_02);
}

//Function Number: 32
exploder_after_load(param_00,param_01,param_02)
{
	activate_exploder(param_00,param_01,param_02);
}
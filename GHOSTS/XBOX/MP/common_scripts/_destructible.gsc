/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 150
 * Decompile Time: 2503 ms
 * Timestamp: 10/27/2023 1:33:59 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.destructiblespawnedentslimit = 50;
	level.destructiblespawnedents = [];
	level.currentcaralarms = 0;
	level.commonstarttime = gettime();
	if(!isdefined(level.fast_destructible_explode))
	{
		level.fast_destructible_explode = 0;
	}

	if(!isdefined(level.func))
	{
		level.func = [];
	}

	var_00 = 1;
	if(var_00)
	{
		find_destructibles();
	}

	var_01 = getentarray("delete_on_load","targetname");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}

	func_4537();
	func_4539();
}

//Function Number: 2
debgugprintdestructiblelist()
{
}

//Function Number: 3
find_destructibles()
{
	if(!isdefined(level.destructible_functions))
	{
		level.destructible_functions = [];
	}

	var_00 = [];
	foreach(var_02 in level.struct)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "destructible_dot")
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = getentarray("destructible_vehicle","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread func_7138(var_00);
	}

	var_08 = getentarray("destructible_toy","targetname");
	foreach(var_0A in var_08)
	{
		var_0A thread func_7138(var_00);
	}

	debgugprintdestructiblelist();
}

//Function Number: 4
func_7138(param_00)
{
	func_7137();
	func_7136(param_00);
}

//Function Number: 5
func_7136(param_00)
{
	var_01 = self.destructibleinfo;
	foreach(var_03 in param_00)
	{
		if(isdefined(level.destructible_type[var_01].destructible_dots))
		{
		}

		if(isdefined(var_03.script_parameters) && issubstr(var_03.script_parameters,"destructible_type") && issubstr(var_03.script_parameters,self.destructible_type))
		{
			if(distancesquared(self.origin,var_03.origin) < 1)
			{
				var_04 = getentarray(var_03.target,"targetname");
				level.destructible_type[var_01].destructible_dots = [];
				foreach(var_06 in var_04)
				{
					var_07 = var_06.script_index;
					if(!isdefined(level.destructible_type[var_01].destructible_dots[var_07]))
					{
						level.destructible_type[var_01].destructible_dots[var_07] = [];
					}

					var_08 = level.destructible_type[var_01].destructible_dots[var_07].size;
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["classname"] = var_06.classname;
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["origin"] = var_06.origin;
					var_09 = common_scripts\utility::func_803F(isdefined(var_06.spawnflags),var_06.spawnflags,0);
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["spawnflags"] = var_09;
					switch(var_06.classname)
					{
						case "trigger_radius":
							level.destructible_type[var_01].destructible_dots[var_07][var_08]["radius"] = var_06.height;
							level.destructible_type[var_01].destructible_dots[var_07][var_08]["height"] = var_06.height;
							break;

						default:
							break;
					}

					var_06 delete();
				}

				break;
			}
		}
	}
}

//Function Number: 6
func_267E(param_00)
{
	if(!isdefined(level.destructible_type))
	{
		return -1;
	}

	if(level.destructible_type.size == 0)
	{
		return -1;
	}

	for(var_01 = 0;var_01 < level.destructible_type.size;var_01++)
	{
		if(param_00 == level.destructible_type[var_01].var_880E["type"])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 7
func_267F(param_00)
{
	var_01 = func_267E(param_00);
	if(var_01 >= 0)
	{
		return var_01;
	}

	if(!isdefined(level.destructible_functions[param_00]))
	{
	}

	[[ level.destructible_functions[param_00] ]]();
	var_01 = func_267E(param_00);
	return var_01;
}

//Function Number: 8
func_7137()
{
	var_00 = undefined;
	self.modeldummyon = 0;
	add_damage_owner_recorder();
	self.destructibleinfo = func_267F(self.destructible_type);
	if(self.destructibleinfo < 0)
	{
	}

	func_6105();
	add_destructible_fx();
	if(isdefined(level.destructible_transient) && isdefined(level.destructible_transient[self.destructible_type]))
	{
		common_scripts\utility::flag_wait(level.destructible_transient[self.destructible_type] + "_loaded");
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].attachedmodels))
	{
		foreach(var_03 in level.destructible_type[self.destructibleinfo].attachedmodels)
		{
			if(isdefined(var_03.tag))
			{
				self attach(var_03.model,var_03.tag);
			}
			else
			{
				self attach(var_03.model);
			}

			if(self.modeldummyon)
			{
				if(isdefined(var_03.tag))
				{
					self.modeldummy attach(var_03.model,var_03.tag);
					continue;
				}

				self.modeldummy attach(var_03.model);
			}
		}
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		self.destructible_parts = [];
		for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].parts.size;var_05++)
		{
			self.destructible_parts[var_05] = addstruct();
			self.destructible_parts[var_05].var_880E["currentState"] = 0;
			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["health"]))
			{
				self.destructible_parts[var_05].var_880E["health"] = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["health"];
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["random_dynamic_attachment_1"]))
			{
				var_06 = randomint(level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["random_dynamic_attachment_1"].size);
				var_07 = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["random_dynamic_attachment_tag"][var_06];
				var_08 = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["random_dynamic_attachment_1"][var_06];
				var_09 = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["random_dynamic_attachment_2"][var_06];
				var_0A = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["clipToRemove"][var_06];
				thread func_2843(var_07,var_08,var_09,var_0A);
			}

			if(var_05 == 0)
			{
				continue;
			}

			var_0B = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["modelName"];
			var_0C = level.destructible_type[self.destructibleinfo].parts[var_05][0].var_880E["tagName"];
			for(var_0D = 1;isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][var_0D]);var_0D++)
			{
				var_0E = level.destructible_type[self.destructibleinfo].parts[var_05][var_0D].var_880E["tagName"];
				var_0F = level.destructible_type[self.destructibleinfo].parts[var_05][var_0D].var_880E["modelName"];
				if(isdefined(var_0E) && var_0E != var_0C)
				{
					func_41FF(var_0E);
					if(self.modeldummyon)
					{
						self.modeldummy func_41FF(var_0E);
					}
				}
			}
		}
	}

	if(isdefined(self.target))
	{
		thread destructible_handles_collision_brushes();
	}

	if(self.code_classname != "script_vehicle")
	{
		self setcandamage(1);
	}

	if(common_scripts\utility::issp())
	{
		thread connecttraverses();
	}

	thread func_269D();
}

//Function Number: 9
destructible_create(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.destructible_type))
	{
		level.destructible_type = [];
	}

	var_06 = level.destructible_type.size;
	var_06 = level.destructible_type.size;
	level.destructible_type[var_06] = addstruct();
	level.destructible_type[var_06].var_880E["type"] = param_00;
	level.destructible_type[var_06].parts = [];
	level.destructible_type[var_06].parts[0][0] = addstruct();
	level.destructible_type[var_06].parts[0][0].var_880E["modelName"] = self.model;
	level.destructible_type[var_06].parts[0][0].var_880E["tagName"] = param_01;
	level.destructible_type[var_06].parts[0][0].var_880E["health"] = param_02;
	level.destructible_type[var_06].parts[0][0].var_880E["validAttackers"] = param_03;
	level.destructible_type[var_06].parts[0][0].var_880E["validDamageZone"] = param_04;
	level.destructible_type[var_06].parts[0][0].var_880E["validDamageCause"] = param_05;
	level.destructible_type[var_06].parts[0][0].var_880E["godModeAllowed"] = 1;
	level.destructible_type[var_06].parts[0][0].var_880E["rotateTo"] = self.angles;
	level.destructible_type[var_06].parts[0][0].var_880E["vehicle_exclude_anim"] = 0;
}

//Function Number: 10
func_268B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.destructible_type.size - 1;
	var_0B = level.destructible_type[var_0A].parts.size;
	var_0C = 0;
	destructible_info(var_0B,var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,undefined,param_09);
}

//Function Number: 11
destructible_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].parts.size - 1;
	var_0A = level.destructible_type[var_08].parts[var_09].size;
	if(!isdefined(param_00) && var_09 == 0)
	{
		param_00 = level.destructible_type[var_08].parts[var_09][0].var_880E["tagName"];
	}

	destructible_info(var_09,var_0A,param_00,param_01,param_02,param_03,param_04,param_05,undefined,undefined,param_06,param_07);
}

//Function Number: 12
func_267B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = level.destructible_type.size - 1;
	var_07 = level.destructible_type[var_06].parts.size - 1;
	var_08 = level.destructible_type[var_06].parts[var_07].size - 1;
	var_09 = 0;
	if(isdefined(level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_filename"]))
	{
		if(isdefined(level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_filename"][param_04]))
		{
			var_09 = level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_filename"][param_04].size;
		}
	}

	if(isdefined(param_03))
	{
		level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_valid_damagetype"][param_04][var_09] = param_03;
	}

	level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_filename"][param_04][var_09] = param_01;
	level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_tag"][param_04][var_09] = param_00;
	level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_useTagAngles"][param_04][var_09] = param_02;
	level.destructible_type[var_06].parts[var_07][var_08].var_880E["fx_cost"][param_04][var_09] = param_05;
}

//Function Number: 13
func_266D(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	if(!isdefined(level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"]))
	{
		level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"] = [];
	}

	var_04 = level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"].size;
	var_05 = createdot();
	var_05.type = "predefined";
	var_05.index = param_00;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"][var_04] = var_05;
}

//Function Number: 14
destructible_createdot_radius(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	if(!isdefined(level.destructible_type[var_04].parts[var_05][var_06].var_880E["dot"]))
	{
		level.destructible_type[var_04].parts[var_05][var_06].var_880E["dot"] = [];
	}

	var_07 = level.destructible_type[var_04].parts[var_05][var_06].var_880E["dot"].size;
	var_08 = createdot_radius((0,0,0),param_01,param_02,param_03);
	var_08.tag = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["dot"][var_07] = var_08;
}

//Function Number: 15
func_2692(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].parts.size - 1;
	var_0A = level.destructible_type[var_08].parts[var_09].size - 1;
	var_0B = level.destructible_type[var_08].parts[var_09][var_0A].var_880E["dot"].size - 1;
	var_0C = level.destructible_type[var_08].parts[var_09][var_0A].var_880E["dot"][var_0B];
	var_0C func_7020(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	initdot(param_06);
}

//Function Number: 16
destructible_setdot_ontickfunc(param_00,param_01,param_02)
{
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	var_06 = level.destructible_type[var_03].parts[var_04][var_05].var_880E["dot"].size - 1;
	var_07 = level.destructible_type[var_03].parts[var_04][var_05].var_880E["dot"][var_06];
	var_08 = var_07.ticks.size;
	var_07.ticks[var_08].onenterfunc = param_00;
	var_07.ticks[var_08].onexitfunc = param_01;
	var_07.ticks[var_08].ondeathfunc = param_02;
}

//Function Number: 17
func_2666(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	var_05 = level.destructible_type[var_02].parts[var_03][var_04].var_880E["dot"].size - 1;
	var_06 = level.destructible_type[var_02].parts[var_03][var_04].var_880E["dot"][var_05];
	var_06 builddot_ontick(param_00,param_01);
}

//Function Number: 18
destructible_builddot_startloop(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	var_04 = level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"].size - 1;
	var_05 = level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"][var_04];
	var_05 func_185B(param_00);
}

//Function Number: 19
func_2665(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.destructible_type.size - 1;
	var_07 = level.destructible_type[var_06].parts.size - 1;
	var_08 = level.destructible_type[var_06].parts[var_07].size - 1;
	var_09 = level.destructible_type[var_06].parts[var_07][var_08].var_880E["dot"].size - 1;
	var_0A = level.destructible_type[var_06].parts[var_07][var_08].var_880E["dot"][var_09];
	var_0A builddot_damage(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 20
destructible_builddot_wait(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	var_04 = level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"].size - 1;
	var_05 = level.destructible_type[var_01].parts[var_02][var_03].var_880E["dot"][var_04];
	var_05 builddot_wait(param_00);
}

//Function Number: 21
destructible_loopfx(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	var_07 = 0;
	if(isdefined(level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_filename"]))
	{
		var_07 = level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_filename"].size;
	}

	level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_filename"][var_07] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_tag"][var_07] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_rate"][var_07] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["loopfx_cost"][var_07] = param_03;
}

//Function Number: 22
func_2682(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["healthdrain_amount"] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["healthdrain_interval"] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["badplace_radius"] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["badplace_team"] = param_03;
}

//Function Number: 23
func_2695(param_00,param_01,param_02)
{
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"]))
	{
		level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"] = [];
		level.destructible_type[var_03].parts[var_04][var_05].var_880E["soundCause"] = [];
	}

	if(!isdefined(level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"][param_02]))
	{
		level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"][param_02] = [];
		level.destructible_type[var_03].parts[var_04][var_05].var_880E["soundCause"][param_02] = [];
	}

	var_06 = level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"][param_02].size;
	level.destructible_type[var_03].parts[var_04][var_05].var_880E["sound"][param_02][var_06] = param_00;
	level.destructible_type[var_03].parts[var_04][var_05].var_880E["soundCause"][param_02][var_06] = param_01;
}

//Function Number: 24
func_2686(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsound"]))
	{
		level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsound"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsoundCause"] = [];
	}

	var_05 = level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsound"].size;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsound"][var_05] = param_00;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E["loopsoundCause"][var_05] = param_01;
}

//Function Number: 25
func_2660(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_09 = [];
	var_09["anim"] = param_00;
	var_09["animTree"] = param_01;
	var_09["animType"] = param_02;
	var_09["vehicle_exclude_anim"] = param_03;
	var_09["groupNum"] = param_04;
	var_09["mpAnim"] = param_05;
	var_09["maxStartDelay"] = param_06;
	var_09["animRateMin"] = param_07;
	var_09["animRateMax"] = param_08;
	add_array_to_destructible("animation",var_09);
}

//Function Number: 26
destructible_spotlight(param_00)
{
	var_01 = [];
	var_01["spotlight_tag"] = param_00;
	var_01["spotlight_fx"] = "spotlight_fx";
	var_01["spotlight_brightness"] = 0.85;
	var_01["randomly_flip"] = 1;
	add_keypairs_to_destructible(var_01);
}

//Function Number: 27
add_key_to_destructible(param_00,param_01)
{
	var_02 = [];
	var_02[param_00] = param_01;
	add_keypairs_to_destructible(var_02);
}

//Function Number: 28
add_keypairs_to_destructible(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	foreach(var_06, var_05 in param_00)
	{
		level.destructible_type[var_01].parts[var_02][var_03].var_880E[var_06] = var_05;
	}
}

//Function Number: 29
add_array_to_destructible(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	var_05 = level.destructible_type[var_02].parts[var_03][var_04].var_880E;
	if(!isdefined(var_05[param_00]))
	{
		var_05[param_00] = [];
	}

	var_05[param_00][var_05[param_00].size] = param_01;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E = var_05;
}

//Function Number: 30
destructible_car_alarm()
{
	var_00 = level.destructible_type.size - 1;
	var_01 = level.destructible_type[var_00].parts.size - 1;
	var_02 = level.destructible_type[var_00].parts[var_01].size - 1;
	level.destructible_type[var_00].parts[var_01][var_02].var_880E["triggerCarAlarm"] = 1;
}

//Function Number: 31
destructible_lights_out(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["break_nearby_lights"] = param_00;
}

//Function Number: 32
func_6310(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = 0;
	if(!isdefined(level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_1"]))
	{
		level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_1"] = [];
		level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_2"] = [];
		level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_tag"] = [];
	}

	var_07 = level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_1"].size;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_1"][var_07] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_2"][var_07] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["random_dynamic_attachment_tag"][var_07] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].var_880E["clipToRemove"][var_07] = param_03;
}

//Function Number: 33
destructible_physics(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics"]))
	{
		level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics_tagName"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics_velocity"] = [];
	}

	var_05 = level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics"].size;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics"][var_05] = 1;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics_tagName"][var_05] = param_00;
	level.destructible_type[var_02].parts[var_03][var_04].var_880E["physics_velocity"][var_05] = param_01;
}

//Function Number: 34
func_2698(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["splash_damage_scaler"] = param_00;
}

//Function Number: 35
func_2674(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = level.destructible_type.size - 1;
	var_0D = level.destructible_type[var_0C].parts.size - 1;
	var_0E = level.destructible_type[var_0C].parts[var_0D].size - 1;
	if(common_scripts\utility::issp())
	{
		level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_range"] = param_02;
	}
	else
	{
		level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_range"] = param_03;
	}

	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode"] = 1;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_force_min"] = param_00;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_force_max"] = param_01;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_mindamage"] = param_04;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["explode_maxdamage"] = param_05;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["continueDamage"] = param_06;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["originOffset"] = param_07;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["earthQuakeScale"] = param_08;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["earthQuakeRadius"] = param_09;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["originOffset3d"] = param_0A;
	level.destructible_type[var_0C].parts[var_0D][var_0E].var_880E["delaytime"] = param_0B;
}

//Function Number: 36
destructible_function(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["function"] = param_00;
}

//Function Number: 37
func_268A(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["functionNotify"] = param_00;
}

//Function Number: 38
destructible_damage_threshold(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].var_880E["damage_threshold"] = param_00;
}

//Function Number: 39
destructible_attachmodel(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = level.destructible_type.size - 1;
	if(!isdefined(level.destructible_type[var_02].attachedmodels))
	{
		level.destructible_type[var_02].attachedmodels = [];
	}

	var_03 = addstruct();
	var_03.model = param_01;
	var_03.tag = param_00;
	level.destructible_type[var_02].attachedmodels[level.destructible_type[var_02].attachedmodels.size] = var_03;
}

//Function Number: 40
destructible_info(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03))
	{
		param_03 = tolower(param_03);
	}

	var_0D = level.destructible_type.size - 1;
	level.destructible_type[var_0D].parts[param_00][param_01] = addstruct();
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["modelName"] = param_03;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["tagName"] = param_02;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["health"] = param_04;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["validAttackers"] = param_05;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["validDamageZone"] = param_06;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["validDamageCause"] = param_07;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["alsoDamageParent"] = param_08;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["physicsOnExplosion"] = param_09;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["grenadeImpactDeath"] = param_0A;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["godModeAllowed"] = 0;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["splashRotation"] = param_0B;
	level.destructible_type[var_0D].parts[param_00][param_01].var_880E["receiveDamageFromParent"] = param_0C;
}

//Function Number: 41
func_6105()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].attachedmodels))
	{
		foreach(var_01 in level.destructible_type[self.destructibleinfo].attachedmodels)
		{
			precachemodel(var_01.model);
		}
	}

	for(var_03 = 0;var_03 < level.destructible_type[self.destructibleinfo].parts.size;var_03++)
	{
		for(var_04 = 0;var_04 < level.destructible_type[self.destructibleinfo].parts[var_03].size;var_04++)
		{
			if(level.destructible_type[self.destructibleinfo].parts[var_03].size <= var_04)
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["modelName"]))
			{
				precachemodel(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["modelName"]);
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["animation"]))
			{
				var_05 = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["animation"];
				foreach(var_07 in var_05)
				{
					if(isdefined(var_07["mpAnim"]))
					{
						common_scripts\utility::func_5685("precacheMpAnim",var_07["mpAnim"]);
					}
				}
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["random_dynamic_attachment_1"]))
			{
				foreach(var_0A in level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["random_dynamic_attachment_1"])
				{
					if(isdefined(var_0A) && var_0A != "")
					{
						precachemodel(var_0A);
						precachemodel(var_0A + "_destroy");
					}
				}

				foreach(var_0A in level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["random_dynamic_attachment_2"])
				{
					if(isdefined(var_0A) && var_0A != "")
					{
						precachemodel(var_0A);
						precachemodel(var_0A + "_destroy");
					}
				}
			}
		}
	}
}

//Function Number: 42
add_destructible_fx()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
	}

	for(var_00 = 0;var_00 < level.destructible_type[self.destructibleinfo].parts.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.destructible_type[self.destructibleinfo].parts[var_00].size;var_01++)
		{
			if(level.destructible_type[self.destructibleinfo].parts[var_00].size <= var_01)
			{
				continue;
			}

			var_02 = level.destructible_type[self.destructibleinfo].parts[var_00][var_01];
			if(isdefined(var_02.var_880E["fx_filename"]))
			{
				for(var_03 = 0;var_03 < var_02.var_880E["fx_filename"].size;var_03++)
				{
					var_04 = var_02.var_880E["fx_filename"][var_03];
					var_05 = var_02.var_880E["fx_tag"][var_03];
					if(isdefined(var_04))
					{
						if(isdefined(var_02.var_880E["fx"]) && isdefined(var_02.var_880E["fx"][var_03]) && var_02.var_880E["fx"][var_03].size == var_04.size)
						{
							continue;
						}

						for(var_06 = 0;var_06 < var_04.size;var_06++)
						{
							var_07 = var_04[var_06];
							var_08 = var_05[var_06];
							level.destructible_type[self.destructibleinfo].parts[var_00][var_01].var_880E["fx"][var_03][var_06] = loadfx(var_07,var_08);
						}
					}
				}
			}

			var_09 = level.destructible_type[self.destructibleinfo].parts[var_00][var_01].var_880E["loopfx_filename"];
			var_0A = level.destructible_type[self.destructibleinfo].parts[var_00][var_01].var_880E["loopfx_tag"];
			if(isdefined(var_09))
			{
				if(isdefined(var_02.var_880E["loopfx"]) && var_02.var_880E["loopfx"].size == var_09.size)
				{
					continue;
				}

				for(var_06 = 0;var_06 < var_09.size;var_06++)
				{
					var_0B = var_09[var_06];
					var_0C = var_0A[var_06];
					level.destructible_type[self.destructibleinfo].parts[var_00][var_01].var_880E["loopfx"][var_06] = loadfx(var_0B,var_0C);
				}
			}
		}
	}
}

//Function Number: 43
func_19B0(param_00)
{
	foreach(var_02 in self.destructibles)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 44
func_269D()
{
	var_00 = 0;
	var_01 = self.model;
	var_02 = undefined;
	var_03 = self.origin;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	destructible_update_part(var_00,var_01,var_02,var_03,var_04,var_05,var_06);
	self endon("stop_taking_damage");
	for(;;)
	{
		var_00 = undefined;
		var_05 = undefined;
		var_04 = undefined;
		var_03 = undefined;
		var_07 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		self waittill("damage",var_00,var_05,var_04,var_03,var_07,var_01,var_02,var_08,var_09);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(isdefined(var_05) && isdefined(var_05.type) && var_05.type == "soft_landing" && !var_05 func_19B0(self))
		{
			continue;
		}

		if(common_scripts\utility::issp())
		{
			var_00 = var_00 * 0.5;
		}
		else
		{
			var_00 = var_00 * 1;
		}

		if(var_00 <= 0)
		{
			continue;
		}

		if(common_scripts\utility::issp())
		{
			if(isdefined(var_05) && isplayer(var_05))
			{
				self.damageowner = var_05;
			}
		}
		else if(isdefined(var_05) && isplayer(var_05))
		{
			self.damageowner = var_05;
		}
		else if(isdefined(var_05) && isdefined(var_05.gunner) && isplayer(var_05.gunner))
		{
			self.damageowner = var_05.gunner;
		}

		var_07 = getdamagetype(var_07);
		if(func_483B(var_05,var_07))
		{
			if(common_scripts\utility::issp())
			{
				var_00 = var_00 * 8;
			}
			else
			{
				var_00 = var_00 * 4;
			}
		}

		if(!isdefined(var_01) || var_01 == "")
		{
			var_01 = self.model;
		}

		if(isdefined(var_02) && var_02 == "")
		{
			if(isdefined(var_08) && var_08 != "" && var_08 != "tag_body" && var_08 != "body_animate_jnt")
			{
				var_02 = var_08;
			}
			else
			{
				var_02 = undefined;
			}

			var_0A = level.destructible_type[self.destructibleinfo].parts[0][0].var_880E["tagName"];
			if(isdefined(var_0A) && isdefined(var_08) && var_0A == var_08)
			{
				var_02 = undefined;
			}
		}

		if(var_07 == "splash")
		{
			if(isdefined(level.destructible_type[self.destructibleinfo].parts[0][0].var_880E["splash_damage_scaler"]))
			{
				var_00 = var_00 * level.destructible_type[self.destructibleinfo].parts[0][0].var_880E["splash_damage_scaler"];
			}
			else if(common_scripts\utility::issp())
			{
				var_00 = var_00 * 9;
			}
			else
			{
				var_00 = var_00 * 13;
			}

			func_2697(castint(var_00),var_03,var_04,var_05,var_07);
			continue;
		}

		thread destructible_update_part(castint(var_00),var_01,var_02,var_03,var_04,var_05,var_07);
	}
}

//Function Number: 45
func_483B(param_00,param_01)
{
	if(param_01 != "bullet")
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = undefined;
	if(isplayer(param_00))
	{
		var_02 = param_00 getcurrentweapon();
	}
	else if(isdefined(level.enable_ai_shotgun_destructible_damage) && level.enable_ai_shotgun_destructible_damage)
	{
		if(isdefined(param_00.weapon))
		{
			var_02 = param_00.weapon;
		}
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = weaponclass(var_02);
	if(isdefined(var_03) && var_03 == "spread")
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
getpartandstateindex(param_00,param_01)
{
	var_02 = addstruct();
	var_02.var_880E = [];
	var_03 = -1;
	var_04 = -1;
	if(tolower(param_00) == tolower(self.model) && !isdefined(param_01))
	{
		param_00 = self.model;
		param_01 = undefined;
		var_03 = 0;
		var_04 = 0;
	}

	for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].parts.size;var_05++)
	{
		var_04 = self.destructible_parts[var_05].var_880E["currentState"];
		if(level.destructible_type[self.destructibleinfo].parts[var_05].size <= var_04)
		{
			continue;
		}

		if(!isdefined(param_01))
		{
			continue;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][var_04].var_880E["tagName"]))
		{
			var_06 = level.destructible_type[self.destructibleinfo].parts[var_05][var_04].var_880E["tagName"];
			if(tolower(var_06) == tolower(param_01))
			{
				var_03 = var_05;
				break;
			}
		}
	}

	var_02.var_880E["stateIndex"] = var_04;
	var_02.var_880E["partIndex"] = var_03;
	return var_02;
}

//Function Number: 47
destructible_update_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(self.destructible_parts))
	{
	}

	if(self.destructible_parts.size == 0)
	{
	}

	if(level.fast_destructible_explode)
	{
		self endon("destroyed");
	}

	var_08 = getpartandstateindex(param_01,param_02);
	var_09 = var_08.var_880E["stateIndex"];
	var_0A = var_08.var_880E["partIndex"];
	if(var_0A < 0)
	{
	}

	var_0B = var_09;
	var_0C = 0;
	var_0D = 0;
	for(;;)
	{
		var_09 = self.destructible_parts[var_0A].var_880E["currentState"];
		if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
		{
			break;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][0].var_880E["alsoDamageParent"]))
		{
			if(getdamagetype(param_06) != "splash")
			{
				var_0E = level.destructible_type[self.destructibleinfo].parts[var_0A][0].var_880E["alsoDamageParent"];
				var_0F = castint(param_00 * var_0E);
				thread notifydamageafterframe(var_0F,param_05,param_04,param_03,param_06,"","");
			}
		}

		if(getdamagetype(param_06) != "splash")
		{
			foreach(var_11 in level.destructible_type[self.destructibleinfo].parts)
			{
				if(!isdefined(var_11[0].var_880E["receiveDamageFromParent"]))
				{
					continue;
				}

				if(!isdefined(var_11[0].var_880E["tagName"]))
				{
					continue;
				}

				var_0E = var_11[0].var_880E["receiveDamageFromParent"];
				var_12 = castint(param_00 * var_0E);
				var_13 = var_11[0].var_880E["tagName"];
				thread notifydamageafterframe(var_12,param_05,param_04,param_03,param_06,"",var_13);
			}
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E["health"]))
		{
			break;
		}

		if(!isdefined(self.destructible_parts[var_0A].var_880E["health"]))
		{
			break;
		}

		if(var_0C)
		{
			self.destructible_parts[var_0A].var_880E["health"] = level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E["health"];
		}

		var_0C = 0;
		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E["grenadeImpactDeath"]) && param_06 == "impact")
		{
			param_00 = 100000000;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E["damage_threshold"]) && level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E["damage_threshold"] > param_00)
		{
			param_00 = 0;
		}

		var_15 = self.destructible_parts[var_0A].var_880E["health"];
		var_16 = func_4881(var_0A,var_09,param_05);
		if(var_16)
		{
			var_17 = func_499D(var_0A,var_09,param_06);
			if(var_17)
			{
				if(isdefined(param_05))
				{
					if(isplayer(param_05))
					{
						self.player_damage = self.player_damage + param_00;
					}
					else if(param_05 != self)
					{
						self.non_player_damage = self.non_player_damage + param_00;
					}
				}

				if(isdefined(param_06))
				{
					if(param_06 == "melee" || param_06 == "impact")
					{
						param_00 = 100000;
					}
				}

				self.destructible_parts[var_0A].var_880E["health"] = self.destructible_parts[var_0A].var_880E["health"] - param_00;
			}
		}

		if(self.destructible_parts[var_0A].var_880E["health"] > 0)
		{
		}

		if(isdefined(param_07))
		{
			param_07.var_880E["fxcost"] = get_part_fx_cost_for_action_state(var_0A,self.destructible_parts[var_0A].var_880E["currentState"]);
			add_destructible_to_frame_queue(self,param_07,param_00);
			if(!isdefined(self.waiting_for_queue))
			{
				self.waiting_for_queue = 1;
			}
			else
			{
				self.waiting_for_queue++;
			}

			self waittill("queue_processed",var_18);
			self.waiting_for_queue--;
			if(self.waiting_for_queue == 0)
			{
				self.waiting_for_queue = undefined;
			}

			if(!var_18)
			{
				self.destructible_parts[var_0A].var_880E["health"] = var_15;
			}
		}

		param_00 = castint(abs(self.destructible_parts[var_0A].var_880E["health"]));
		if(param_00 < 0)
		{
		}

		self.destructible_parts[var_0A].var_880E["currentState"]++;
		var_09 = self.destructible_parts[var_0A].var_880E["currentState"];
		var_19 = var_09 - 1;
		var_1A = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19]))
		{
			var_1A = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E;
		}

		var_1B = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
		{
			var_1B = level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].var_880E;
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19]))
		{
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode"]))
		{
			self.exploding = 1;
		}

		if(isdefined(self.loopingsoundstopnotifies) && isdefined(self.loopingsoundstopnotifies[func_8173(var_0A)]))
		{
			for(var_1C = 0;var_1C < self.loopingsoundstopnotifies[func_8173(var_0A)].size;var_1C++)
			{
				self notify(self.loopingsoundstopnotifies[func_8173(var_0A)][var_1C]);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy notify(self.loopingsoundstopnotifies[func_8173(var_0A)][var_1C]);
				}
			}

			self.loopingsoundstopnotifies[func_8173(var_0A)] = undefined;
		}

		if(isdefined(var_1A["break_nearby_lights"]))
		{
			func_267D(var_1A["break_nearby_lights"]);
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
		{
			if(var_0A == 0)
			{
				var_1D = var_1B["modelName"];
				if(isdefined(var_1D) && var_1D != self.model)
				{
					self setmodel(var_1D);
					if(common_scripts\utility::issp() && self.modeldummyon)
					{
						self.modeldummy setmodel(var_1D);
					}

					func_2699(var_1B);
				}
			}
			else
			{
				func_41FF(param_02);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy func_41FF(param_02);
				}

				param_02 = var_1B["tagName"];
				if(isdefined(param_02))
				{
					func_7504(param_02);
					if(common_scripts\utility::issp() && self.modeldummyon)
					{
						self.modeldummy func_7504(param_02);
					}
				}
			}
		}

		var_1E = func_3863();
		if(isdefined(self.exploding))
		{
			func_1CF6(var_1E);
		}

		var_1F = func_2661(var_1A,var_1E,param_06,var_0A);
		var_1F = destructible_fx_think(var_1A,var_1E,param_06,var_0A,var_1F);
		var_1F = destructible_sound_think(var_1A,var_1E,param_06,var_1F);
		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopfx"]))
		{
			var_20 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopfx_filename"].size;
			if(var_20 > 0)
			{
				self notify("FX_State_Change" + var_0A);
			}

			for(var_21 = 0;var_21 < var_20;var_21++)
			{
				var_22 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopfx"][var_21];
				var_23 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopfx_tag"][var_21];
				var_24 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopfx_rate"][var_21];
				thread func_4F76(var_22,var_23,var_24,var_0A);
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopsound"]))
		{
			for(var_1C = 0;var_1C < level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopsound"].size;var_1C++)
			{
				var_25 = isvalidsoundcause("loopsoundCause",var_1A,var_1C,param_06);
				if(var_25)
				{
					var_26 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["loopsound"][var_1C];
					var_27 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["tagName"];
					thread func_5CF3(var_26,var_27);
					if(!isdefined(self.loopingsoundstopnotifies))
					{
						self.loopingsoundstopnotifies = [];
					}

					if(!isdefined(self.loopingsoundstopnotifies[func_8173(var_0A)]))
					{
						self.loopingsoundstopnotifies[func_8173(var_0A)] = [];
					}

					var_28 = self.loopingsoundstopnotifies[func_8173(var_0A)].size;
					self.loopingsoundstopnotifies[func_8173(var_0A)][var_28] = "stop sound" + var_26;
				}
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["triggerCarAlarm"]))
		{
			thread func_281E();
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["break_nearby_lights"]))
		{
			thread break_nearest_light();
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["healthdrain_amount"]))
		{
			self notify("Health_Drain_State_Change" + var_0A);
			var_29 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["healthdrain_amount"];
			var_2A = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["healthdrain_interval"];
			var_2B = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["modelName"];
			var_2C = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["tagName"];
			var_2D = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["badplace_radius"];
			var_2E = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["badplace_team"];
			if(var_29 > 0)
			{
				thread health_drain(var_29,var_2A,var_0A,var_2B,var_2C,var_2D,var_2E);
			}
		}

		var_2F = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["dot"];
		if(isdefined(var_2F))
		{
			foreach(var_31 in var_2F)
			{
				var_32 = var_31.index;
				if(var_31.type == "predefined" && isdefined(var_32))
				{
					var_33 = [];
					foreach(var_35 in level.destructible_type[self.destructibleinfo].destructible_dots[var_32])
					{
						var_36 = var_35["classname"];
						var_37 = undefined;
						switch(var_36)
						{
							case "trigger_radius":
								var_38 = var_35["origin"];
								var_39 = var_35["spawnflags"];
								var_3A = var_35["radius"];
								var_3B = var_35["height"];
								var_37 = createdot_radius(self.origin + var_38,var_39,var_3A,var_3B);
								var_37.ticks = var_31.ticks;
								var_33[var_33.size] = var_37;
								break;
	
							default:
								break;
						}
					}

					level thread func_7AC8(var_33);
					continue;
				}

				if(isdefined(var_31))
				{
					if(isdefined(var_31.tag))
					{
						var_31 func_7021(self gettagorigin(var_31.tag));
					}

					level thread func_7AC8([var_31]);
				}
			}

			var_2F = undefined;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode"]))
		{
			var_0D = 1;
			var_3E = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode_force_min"];
			var_3F = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode_force_max"];
			var_40 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode_range"];
			var_41 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode_mindamage"];
			var_42 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["explode_maxdamage"];
			var_43 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["continueDamage"];
			var_44 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["originOffset"];
			var_45 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["earthQuakeScale"];
			var_46 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["earthQuakeRadius"];
			var_47 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["originOffset3d"];
			var_48 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["delaytime"];
			if(isdefined(param_05) && param_05 != self)
			{
				self.attacker = param_05;
				if(self.code_classname == "script_vehicle")
				{
					self.damage_type = param_06;
				}
			}

			thread explode(var_0A,var_3E,var_3F,var_40,var_41,var_42,var_43,var_44,var_45,var_46,param_05,var_47,var_48);
		}

		var_49 = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["physics"]))
		{
			for(var_1C = 0;var_1C < level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["physics"].size;var_1C++)
			{
				var_49 = undefined;
				var_4A = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["physics_tagName"][var_1C];
				var_4B = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["physics_velocity"][var_1C];
				var_4C = undefined;
				if(isdefined(var_4B))
				{
					var_4D = undefined;
					if(isdefined(var_4A))
					{
						var_4D = self gettagangles(var_4A);
					}
					else if(isdefined(param_02))
					{
						var_4D = self gettagangles(param_02);
					}

					var_49 = undefined;
					if(isdefined(var_4A))
					{
						var_49 = self gettagorigin(var_4A);
					}
					else if(isdefined(param_02))
					{
						var_49 = self gettagorigin(param_02);
					}

					var_4E = var_4B[0] - 5 + randomfloat(10);
					var_4F = var_4B[1] - 5 + randomfloat(10);
					var_50 = var_4B[2] - 5 + randomfloat(10);
					var_51 = anglestoforward(var_4D) * var_4E * randomfloatrange(80,110);
					var_52 = anglestoright(var_4D) * var_4F * randomfloatrange(80,110);
					var_53 = anglestoup(var_4D) * var_50 * randomfloatrange(80,110);
					var_4C = var_51 + var_52 + var_53;
				}
				else
				{
					var_4C = param_03;
					var_54 = (0,0,0);
					if(isdefined(param_05))
					{
						var_54 = param_05.origin;
						var_4C = vectornormalize(param_03 - var_54);
						var_4C = var_4C * 200;
					}
				}

				if(isdefined(var_4A))
				{
					var_55 = undefined;
					for(var_56 = 0;var_56 < level.destructible_type[self.destructibleinfo].parts.size;var_56++)
					{
						if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_56][0].var_880E["tagName"]))
						{
							continue;
						}

						if(level.destructible_type[self.destructibleinfo].parts[var_56][0].var_880E["tagName"] != var_4A)
						{
							continue;
						}

						var_55 = var_56;
						break;
					}

					if(isdefined(var_49))
					{
						thread func_5BDE(var_55,0,var_49,var_4C);
					}
					else
					{
						thread func_5BDE(var_55,0,param_03,var_4C);
					}

					continue;
				}

				if(isdefined(var_49))
				{
					thread func_5BDE(var_0A,var_19,var_49,var_4C);
				}
				else
				{
					thread func_5BDE(var_0A,var_19,param_03,var_4C);
				}
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E) && isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["functionNotify"]))
		{
			self notify(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["functionNotify"]);
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["function"]))
		{
			self thread [[ level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].var_880E["function"] ]]();
		}

		var_0C = 1;
	}
}

//Function Number: 48
func_2699(param_00)
{
	var_01 = param_00["splashRotation"];
	var_02 = param_00["rotateTo"];
	if(!isdefined(var_02))
	{
	}

	if(!isdefined(var_01))
	{
	}

	if(!var_01)
	{
	}

	self.angles = (self.angles[0],var_02[1],self.angles[2]);
}

//Function Number: 49
damage_not(param_00)
{
	var_01 = strtok(param_00," ");
	var_02 = strtok("splash melee bullet splash impact unknown"," ");
	var_03 = "";
	foreach(var_05 in var_01)
	{
		var_02 = common_scripts\utility::array_remove(var_02,var_05);
	}

	foreach(var_08 in var_02)
	{
		var_03 = var_03 + var_08 + " ";
	}

	return var_03;
}

//Function Number: 50
func_2697(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= 0)
	{
	}

	if(isdefined(self.exploded))
	{
	}

	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
	}

	var_05 = getallactiveparts(param_02);
	if(var_05.size <= 0)
	{
	}

	var_05 = func_701D(var_05,param_01);
	var_06 = func_3B1F(var_05);
	foreach(var_08 in var_05)
	{
		var_09 = var_08.var_880E["distance"] * 1.4;
		var_0A = param_00 - var_09 - var_06;
		if(var_0A <= 0)
		{
			continue;
		}

		if(isdefined(self.exploded))
		{
			continue;
		}

		thread destructible_update_part(var_0A,var_08.var_880E["modelName"],var_08.var_880E["tagName"],param_01,param_02,param_03,param_04,var_08);
	}
}

//Function Number: 51
getallactiveparts(param_00)
{
	var_01 = [];
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		return var_01;
	}

	for(var_02 = 0;var_02 < level.destructible_type[self.destructibleinfo].parts.size;var_02++)
	{
		var_03 = var_02;
		var_04 = self.destructible_parts[var_03].var_880E["currentState"];
		for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].parts[var_03].size;var_05++)
		{
			var_06 = level.destructible_type[self.destructibleinfo].parts[var_03][var_05].var_880E["splashRotation"];
			if(isdefined(var_06) && var_06)
			{
				var_07 = vectortoangles(param_00);
				var_08 = var_07[1] - 90;
				level.destructible_type[self.destructibleinfo].parts[var_03][var_05].var_880E["rotateTo"] = (0,var_08,0);
			}
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04]))
		{
			continue;
		}

		var_09 = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["tagName"];
		if(!isdefined(var_09))
		{
			var_09 = "";
		}

		if(var_09 == "")
		{
			continue;
		}

		var_0A = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].var_880E["modelName"];
		if(!isdefined(var_0A))
		{
			var_0A = "";
		}

		var_0B = var_01.size;
		var_01[var_0B] = addstruct();
		var_01[var_0B].var_880E["modelName"] = var_0A;
		var_01[var_0B].var_880E["tagName"] = var_09;
	}

	return var_01;
}

//Function Number: 52
func_701D(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = distance(param_01,self gettagorigin(param_00[var_02].var_880E["tagName"]));
		param_00[var_02].var_880E["distance"] = var_03;
	}

	return param_00;
}

//Function Number: 53
func_3B1F(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		var_04 = var_03.var_880E["distance"];
		if(!isdefined(var_01))
		{
			var_01 = var_04;
		}

		if(var_04 < var_01)
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 54
isvalidsoundcause(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = param_01[param_00][param_04][param_02];
	}
	else
	{
		var_05 = param_02[param_01][param_03];
	}

	if(!isdefined(var_05))
	{
		return 1;
	}

	if(var_05 == param_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
func_4881(param_00,param_01,param_02)
{
	if(isdefined(self.forceexploding))
	{
		return 1;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["explode"]))
	{
		if(isdefined(self.dontallowexplode))
		{
			return 0;
		}
	}

	if(!isdefined(param_02))
	{
		return 1;
	}

	if(param_02 == self)
	{
		return 1;
	}

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["validAttackers"];
	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 == "no_player")
	{
		if(!isplayer(param_02))
		{
			return 1;
		}

		if(!isdefined(param_02.damageisfromplayer))
		{
			return 1;
		}

		if(param_02.damageisfromplayer == 0)
		{
			return 1;
		}
	}
	else if(var_03 == "player_only")
	{
		if(isplayer(param_02))
		{
			return 1;
		}

		if(isdefined(param_02.damageisfromplayer) && param_02.damageisfromplayer)
		{
			return 1;
		}
	}
	else if(var_03 == "no_ai" && isdefined(level.isaifunc))
	{
		if(![[ level.isaifunc ]](param_02))
		{
			return 1;
		}
	}
	else if(var_03 == "ai_only" && isdefined(level.isaifunc))
	{
		if([[ level.isaifunc ]](param_02))
		{
			return 1;
		}
	}
	else
	{
	}

	return 0;
}

//Function Number: 56
func_499D(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["godModeAllowed"];
	if(var_03 && (isdefined(self.godmode) && self.godmode) || isdefined(self.script_bulletshield) && self.script_bulletshield && param_02 == "bullet")
	{
		return 0;
	}

	var_04 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["validDamageCause"];
	if(!isdefined(var_04))
	{
		return 1;
	}

	if(var_04 == "splash" && param_02 != "splash")
	{
		return 0;
	}

	if(var_04 == "no_splash" && param_02 == "splash")
	{
		return 0;
	}

	if((var_04 == "no_melee" && param_02 == "melee") || param_02 == "impact")
	{
		return 0;
	}

	return 1;
}

//Function Number: 57
getdamagetype(param_00)
{
	if(!isdefined(param_00))
	{
		return "unknown";
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "mod_crush":
		case "mod_melee":
		case "melee":
			return "melee";

		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		case "bullet":
			return "bullet";

		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
		case "splash":
			return "splash";

		case "mod_impact":
			return "impact";

		case "unknown":
			return "unknown";

		default:
			return "unknown";
	}
}

//Function Number: 58
func_22D9(param_00,param_01,param_02)
{
	self notify("stop_damage_mirror");
	self endon("stop_damage_mirror");
	param_00 endon("stop_taking_damage");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07);
		param_00 notify("damage",var_03,var_04,var_05,var_06,var_07,param_01,param_02);
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
	}
}

//Function Number: 59
add_damage_owner_recorder()
{
	self.player_damage = 0;
	self.non_player_damage = 0;
	self.car_damage_owner_recorder = 1;
}

//Function Number: 60
func_4F76(param_00,param_01,param_02,param_03)
{
	self endon("FX_State_Change" + param_03);
	self endon("delete_destructible");
	level endon("putout_fires");
	while(isdefined(self))
	{
		var_04 = func_3863();
		playfxontag(param_00,var_04,param_01);
		wait(param_02);
	}
}

//Function Number: 61
health_drain(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("Health_Drain_State_Change" + param_02);
	level endon("putout_fires");
	self endon("destroyed");
	if(isdefined(param_05) && isdefined(level.destructible_badplace_radius_multiplier))
	{
		param_05 = param_05 * level.destructible_badplace_radius_multiplier;
	}

	if(isdefined(param_00) && isdefined(level.destructible_health_drain_amount_multiplier))
	{
		param_00 = param_00 * level.destructible_health_drain_amount_multiplier;
	}

	wait(param_01);
	self.healthdrain = 1;
	var_07 = undefined;
	if(isdefined(level.disable_destructible_bad_places) && level.disable_destructible_bad_places)
	{
		param_05 = undefined;
	}

	if(isdefined(param_05) && isdefined(level.badplace_cylinder_func))
	{
		var_07 = "" + gettime();
		if(!isdefined(self.disablebadplace))
		{
			if(isdefined(self.script_radius))
			{
				param_05 = self.script_radius;
			}

			if(common_scripts\utility::issp() && isdefined(param_06))
			{
				if(param_06 == "both")
				{
					[[ level.badplace_cylinder_func ]](var_07,0,self.origin,param_05,128,"allies","bad_guys");
				}
				else
				{
					[[ level.badplace_cylinder_func ]](var_07,0,self.origin,param_05,128,param_06);
				}

				thread func_1227(var_07);
			}
			else
			{
				[[ level.badplace_cylinder_func ]](var_07,0,self.origin,param_05,128);
				thread func_1227(var_07);
			}
		}
	}

	while(isdefined(self) && self.destructible_parts[param_02].var_880E["health"] > 0)
	{
		self notify("damage",param_00,self,(0,0,0),(0,0,0),"MOD_UNKNOWN",param_03,param_04);
		wait(param_01);
	}

	self notify("remove_badplace");
}

//Function Number: 62
func_1227(param_00)
{
	common_scripts\utility::func_8B2A("destroyed","remove_badplace");
	[[ level.badplace_delete_func ]](param_00);
}

//Function Number: 63
func_5BDE(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["modelName"];
	var_05 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E["tagName"];
	func_41FF(var_05);
	if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit)
	{
		func_5BDF(level.destructiblespawnedents[0]);
	}

	var_06 = spawn("script_model",self gettagorigin(var_05));
	var_06.angles = self gettagangles(var_05);
	var_06 setmodel(var_04);
	level.destructiblespawnedents[level.destructiblespawnedents.size] = var_06;
	var_06 physicslaunchclient(param_02,param_03);
}

//Function Number: 64
func_5BDF(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.destructiblespawnedents.size;var_02++)
	{
		if(level.destructiblespawnedents[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.destructiblespawnedents[var_02];
	}

	level.destructiblespawnedents = var_01;
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 65
explode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03) && isdefined(level.destructible_explosion_radius_multiplier))
	{
		param_03 = param_03 * level.destructible_explosion_radius_multiplier;
	}

	if(!isdefined(param_07))
	{
		param_07 = 80;
	}

	if(!isdefined(param_0B))
	{
		param_0B = (0,0,0);
	}

	if(!isdefined(param_06) || isdefined(param_06) && !param_06)
	{
		if(isdefined(self.exploded))
		{
		}

		self.exploded = 1;
	}

	if(!isdefined(param_0C))
	{
		param_0C = 0;
	}

	self notify("exploded",param_0A);
	level notify("destructible_exploded",self,param_0A);
	if(self.code_classname == "script_vehicle")
	{
		self notify("death",param_0A,self.damage_type);
	}

	if(common_scripts\utility::issp())
	{
		thread disconnecttraverses();
	}

	if(!level.fast_destructible_explode)
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
	}

	var_0D = self.destructible_parts[param_00].var_880E["currentState"];
	var_0E = undefined;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][var_0D]))
	{
		var_0E = level.destructible_type[self.destructibleinfo].parts[param_00][var_0D].var_880E["tagName"];
	}

	if(isdefined(var_0E))
	{
		var_0F = self gettagorigin(var_0E);
	}
	else
	{
		var_0F = self.origin;
	}

	self notify("damage",param_05,self,(0,0,0),var_0F,"MOD_EXPLOSIVE","","");
	self notify("stop_car_alarm");
	waittillframeend;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		for(var_10 = level.destructible_type[self.destructibleinfo].parts.size - 1;var_10 >= 0;var_10--)
		{
			if(var_10 == param_00)
			{
				continue;
			}

			var_11 = self.destructible_parts[var_10].var_880E["currentState"];
			if(var_11 >= level.destructible_type[self.destructibleinfo].parts[var_10].size)
			{
				var_11 = level.destructible_type[self.destructibleinfo].parts[var_10].size - 1;
			}

			var_12 = level.destructible_type[self.destructibleinfo].parts[var_10][var_11].var_880E["modelName"];
			var_0E = level.destructible_type[self.destructibleinfo].parts[var_10][var_11].var_880E["tagName"];
			if(!isdefined(var_12))
			{
				continue;
			}

			if(!isdefined(var_0E))
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_10][0].var_880E["physicsOnExplosion"]))
			{
				if(level.destructible_type[self.destructibleinfo].parts[var_10][0].var_880E["physicsOnExplosion"] > 0)
				{
					var_13 = level.destructible_type[self.destructibleinfo].parts[var_10][0].var_880E["physicsOnExplosion"];
					var_14 = self gettagorigin(var_0E);
					var_15 = vectornormalize(var_14 - var_0F);
					var_15 = var_15 * randomfloatrange(param_01,param_02) * var_13;
					thread func_5BDE(var_10,var_11,var_14,var_15);
					continue;
				}
			}
		}
	}

	var_16 = !isdefined(param_06) || isdefined(param_06) && !param_06;
	if(var_16)
	{
		self notify("stop_taking_damage");
	}

	if(!level.fast_destructible_explode)
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
	}

	var_17 = var_0F + (0,0,param_07) + param_0B;
	var_18 = getsubstr(level.destructible_type[self.destructibleinfo].var_880E["type"],0,7) == "vehicle";
	if(var_18)
	{
		anim.lastcarexplosiontime = gettime();
		anim.lastcarexplosiondamagelocation = var_17;
		anim.lastcarexplosionlocation = var_0F;
		anim.lastcarexplosionrange = param_03;
	}

	level thread func_6E89(1);
	if(param_0C > 0)
	{
		wait(param_0C);
	}

	if(isdefined(level.destructible_protection_func))
	{
		thread [[ level.destructible_protection_func ]]();
	}

	if(common_scripts\utility::issp())
	{
		if(level.gameskill == 0 && !player_touching_post_clip())
		{
			self entityradiusdamage(var_17,param_03,param_05,param_04,self,"MOD_RIFLE_BULLET");
		}
		else
		{
			self entityradiusdamage(var_17,param_03,param_05,param_04,self);
		}

		if(isdefined(self.damageowner) && var_18)
		{
			self.damageowner notify("destroyed_car");
			level notify("player_destroyed_car",self.damageowner,var_17);
		}
	}
	else
	{
		var_19 = "destructible_toy";
		if(var_18)
		{
			var_19 = "destructible_car";
		}

		if(!isdefined(self.damageowner))
		{
			self entityradiusdamage(var_17,param_03,param_05,param_04,self,"MOD_EXPLOSIVE",var_19);
		}
		else
		{
			self entityradiusdamage(var_17,param_03,param_05,param_04,self.damageowner,"MOD_EXPLOSIVE",var_19);
			if(var_18)
			{
				self.damageowner notify("destroyed_car");
				level notify("player_destroyed_car",self.damageowner,var_17);
			}
		}
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		earthquake(param_08,2,var_17,param_09);
	}

	level thread func_6E89(0,0.05);
	var_1A = 0.01;
	var_1B = param_03 * var_1A;
	param_03 = param_03 * 0.99;
	physicsexplosionsphere(var_17,param_03,0,var_1B);
	if(var_16)
	{
		self setcandamage(0);
		thread func_1CF1();
	}

	self notify("destroyed");
}

//Function Number: 66
func_1CF1()
{
	wait(0.05);
	while(isdefined(self) && isdefined(self.waiting_for_queue))
	{
		self waittill("queue_processed");
		wait(0.05);
	}

	if(!isdefined(self))
	{
	}

	self.animsapplied = undefined;
	self.attacker = undefined;
	self.car_damage_owner_recorder = undefined;
	self.caralarm = undefined;
	self.damageowner = undefined;
	self.destructible_parts = undefined;
	self.destructible_type = undefined;
	self.destructibleinfo = undefined;
	self.healthdrain = undefined;
	self.non_player_damage = undefined;
	self.player_damage = undefined;
	if(!isdefined(level.destructible_cleans_up_more))
	{
	}

	self.script_noflip = undefined;
	self.exploding = undefined;
	self.loopingsoundstopnotifies = undefined;
	self.car_alarm_org = undefined;
}

//Function Number: 67
func_6E89(param_00,param_01)
{
	level notify("set_disable_friendlyfire_value_delayed");
	level endon("set_disable_friendlyfire_value_delayed");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	level.friendlyfiredisabledfordestructible = param_00;
}

//Function Number: 68
connecttraverses()
{
	var_00 = func_39D3();
	if(!isdefined(var_00))
	{
	}

	var_00 [[ level.connectpathsfunction ]]();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 69
disconnecttraverses()
{
	var_00 = func_39D3();
	if(!isdefined(var_00))
	{
	}

	var_00.origin = var_00.origin + (0,0,10000);
	var_00 [[ level.disconnectpathsfunction ]]();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 70
func_39D3()
{
	if(!isdefined(self.target))
	{
		return undefined;
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(isspawner(var_02))
		{
			continue;
		}

		if(isdefined(var_02.script_destruct_collision))
		{
			continue;
		}

		if(var_02.code_classname == "light")
		{
			continue;
		}

		if(!var_02.spawnflags & 1)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 71
func_41FF(param_00)
{
	self hidepart(param_00);
}

//Function Number: 72
func_7504(param_00)
{
	self showpart(param_00);
}

//Function Number: 73
func_2766()
{
	self.dontallowexplode = 1;
}

//Function Number: 74
func_34AF()
{
	self.dontallowexplode = undefined;
	self.forceexploding = 1;
	self notify("damage",100000,self,self.origin,self.origin,"MOD_EXPLOSIVE","","");
}

//Function Number: 75
func_3863()
{
	if(!common_scripts\utility::issp())
	{
		return self;
	}

	if(self.modeldummyon)
	{
		var_00 = self.modeldummy;
	}
	else
	{
		var_00 = self;
	}

	return var_00;
}

//Function Number: 76
func_5CF3(param_00,param_01)
{
	var_02 = func_3863();
	var_03 = spawn("script_origin",(0,0,0));
	if(isdefined(param_01))
	{
		var_03.origin = var_02 gettagorigin(param_01);
	}
	else
	{
		var_03.origin = var_02.origin;
	}

	var_03 playloopsound(param_00);
	var_02 thread force_stop_sound(param_00);
	var_02 waittill("stop sound" + param_00);
	if(!isdefined(var_03))
	{
	}

	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 77
force_stop_sound(param_00)
{
	self endon("stop sound" + param_00);
	level waittill("putout_fires");
	self notify("stop sound" + param_00);
}

//Function Number: 78
notifydamageafterframe(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.notifydamageafterframe))
	{
	}

	level.notifydamageafterframe = 1;
	waittillframeend;
	if(isdefined(self.exploded))
	{
		level.notifydamageafterframe = undefined;
	}

	if(common_scripts\utility::issp())
	{
		param_00 = param_00 / 0.5;
	}
	else
	{
		param_00 = param_00 / 1;
	}

	self notify("damage",param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	level.notifydamageafterframe = undefined;
}

//Function Number: 79
func_5D1D(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = spawn("script_origin",self gettagorigin(param_01));
		var_02 hide();
		var_02 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_02 = spawn("script_origin",(0,0,0));
		var_02 hide();
		var_02.origin = self.origin;
		var_02.angles = self.angles;
		var_02 linkto(self);
	}

	var_02 playsound(param_00);
	wait(5);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 80
func_8173(param_00)
{
	return "" + param_00;
}

//Function Number: 81
func_281E()
{
	if(isdefined(self.caralarm))
	{
	}

	self.caralarm = 1;
	if(!func_7470())
	{
	}

	self.car_alarm_org = spawn("script_model",self.origin);
	self.car_alarm_org hide();
	self.car_alarm_org playloopsound("car_alarm");
	level.currentcaralarms++;
	thread car_alarm_timeout();
	self waittill("stop_car_alarm");
	level.lastcaralarmtime = gettime();
	level.currentcaralarms--;
	self.car_alarm_org stoploopsound("car_alarm");
	self.car_alarm_org delete();
}

//Function Number: 82
car_alarm_timeout()
{
	self endon("stop_car_alarm");
	wait(25);
	if(!isdefined(self))
	{
	}

	thread func_5D1D("car_alarm_off");
	self notify("stop_car_alarm");
}

//Function Number: 83
func_7470()
{
	if(level.currentcaralarms >= 2)
	{
		return 0;
	}

	var_00 = undefined;
	if(!isdefined(level.lastcaralarmtime))
	{
		if(common_scripts\utility::func_1DE9())
		{
			return 1;
		}

		var_00 = gettime() - level.commonstarttime;
	}
	else
	{
		var_00 = gettime() - level.lastcaralarmtime;
	}

	if(level.currentcaralarms == 0 && var_00 >= 120)
	{
		return 1;
	}

	if(randomint(100) <= 33)
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
func_2843(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(common_scripts\utility::issp())
	{
		self attach(param_01,param_00,0);
		if(isdefined(param_02) && param_02 != "")
		{
			self attach(param_02,param_00,0);
		}
	}
	else
	{
		var_04[0] = spawn("script_model",self gettagorigin(param_00));
		var_04[0].angles = self gettagangles(param_00);
		var_04[0] setmodel(param_01);
		var_04[0] linkto(self,param_00);
		if(isdefined(param_02) && param_02 != "")
		{
			var_04[1] = spawn("script_model",self gettagorigin(param_00));
			var_04[1].angles = self gettagangles(param_00);
			var_04[1] setmodel(param_02);
			var_04[1] linkto(self,param_00);
		}
	}

	if(isdefined(param_03))
	{
		var_05 = self gettagorigin(param_00);
		var_06 = get_closest_with_targetname(var_05,param_03);
		if(isdefined(var_06))
		{
			var_06 delete();
		}
	}

	self waittill("exploded");
	if(common_scripts\utility::issp())
	{
		self detach(param_01,param_00);
		self attach(param_01 + "_destroy",param_00,0);
		if(isdefined(param_02) && param_02 != "")
		{
			self detach(param_02,param_00);
			self attach(param_02 + "_destroy",param_00,0);
		}
	}

	var_04[0] setmodel(param_01 + "_destroy");
	if(isdefined(param_02) && param_02 != "")
	{
		var_04[1] setmodel(param_02 + "_destroy");
	}
}

//Function Number: 85
get_closest_with_targetname(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = getentarray(param_01,"targetname");
	foreach(var_06 in var_04)
	{
		var_07 = distancesquared(param_00,var_06.origin);
		if(!isdefined(var_02) || var_07 < var_02)
		{
			var_02 = var_07;
			var_03 = var_06;
		}
	}

	return var_03;
}

//Function Number: 86
player_touching_post_clip()
{
	var_00 = undefined;
	if(!isdefined(self.target))
	{
		return 0;
	}

	var_01 = getentarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_destruct_collision) && var_03.script_destruct_collision == "post")
		{
			var_00 = var_03;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		return 0;
	}

	var_05 = func_3952(var_00);
	if(isdefined(var_05))
	{
		return 1;
	}

	return 0;
}

//Function Number: 87
func_3952(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(param_00 istouching(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 88
func_483D()
{
	return getdvar("specialops") == "1";
}

//Function Number: 89
destructible_handles_collision_brushes()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = [];
	var_01["pre"] = ::collision_brush_pre_explosion;
	var_01["post"] = ::collision_brush_post_explosion;
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.script_destruct_collision))
		{
			continue;
		}

		self thread [[ var_01[var_03.script_destruct_collision] ]](var_03);
	}
}

//Function Number: 90
collision_brush_pre_explosion(param_00)
{
	waittillframeend;
	if(common_scripts\utility::issp() && param_00.spawnflags & 1)
	{
		param_00 [[ level.disconnectpathsfunction ]]();
	}

	self waittill("exploded");
	if(common_scripts\utility::issp() && param_00.spawnflags & 1)
	{
		param_00 [[ level.connectpathsfunction ]]();
	}

	param_00 delete();
}

//Function Number: 91
collision_brush_post_explosion(param_00)
{
	param_00 notsolid();
	if(common_scripts\utility::issp() && param_00.spawnflags & 1)
	{
		param_00 [[ level.connectpathsfunction ]]();
	}

	self waittill("exploded");
	waittillframeend;
	if(common_scripts\utility::issp())
	{
		if(param_00.spawnflags & 1)
		{
			param_00 [[ level.disconnectpathsfunction ]]();
		}

		if(func_483D())
		{
			var_01 = func_3952(param_00);
			if(isdefined(var_01))
			{
				self thread [[ level.func_destructible_crush_player ]](var_01);
			}
		}
		else
		{
		}
	}

	param_00 solid();
}

//Function Number: 92
debug_player_in_post_clip(param_00)
{
}

//Function Number: 93
func_267D(param_00)
{
	var_01 = getentarray("light_destructible","targetname");
	if(common_scripts\utility::issp())
	{
		var_02 = getentarray("light_destructible","script_noteworthy");
		var_01 = common_scripts\utility::array_combine(var_01,var_02);
	}

	if(!var_01.size)
	{
	}

	var_03 = param_00 * param_00;
	var_04 = undefined;
	foreach(var_06 in var_01)
	{
		var_07 = distancesquared(self.origin,var_06.origin);
		if(var_07 < var_03)
		{
			var_04 = var_06;
			var_03 = var_07;
		}
	}

	if(!isdefined(var_04))
	{
	}

	self.breakable_light = var_04;
}

//Function Number: 94
break_nearest_light(param_00)
{
	if(!isdefined(self.breakable_light))
	{
	}

	self.breakable_light setlightintensity(0);
}

//Function Number: 95
debug_radiusdamage_circle(param_00,param_01,param_02,param_03)
{
	var_04 = 16;
	var_05 = 360 / var_04;
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0] + var_09;
		var_0C = param_00[1] + var_0A;
		var_0D = param_00[2];
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_23D3(var_06,5,(1,0,0),param_00);
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0];
		var_0C = param_00[1] + var_09;
		var_0D = param_00[2] + var_0A;
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_23D3(var_06,5,(1,0,0),param_00);
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0] + var_0A;
		var_0C = param_00[1];
		var_0D = param_00[2] + var_09;
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_23D3(var_06,5,(1,0,0),param_00);
}

//Function Number: 96
func_23D3(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_04 + 1 >= param_00.size)
		{
			var_06 = param_00[0];
		}
		else
		{
			var_06 = param_00[var_04 + 1];
		}

		thread debug_line(var_05,var_06,param_01,param_02);
		thread debug_line(param_03,var_05,param_01,param_02);
	}
}

//Function Number: 97
debug_line(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 98
spotlight_tag_origin_cleanup(param_00)
{
	param_00 endon("death");
	level waittill("new_destructible_spotlight");
	param_00 delete();
}

//Function Number: 99
func_796C(param_00,param_01,param_02,param_03,param_04)
{
	level endon("new_destructible_spotlight");
	thread spotlight_tag_origin_cleanup(param_04);
	var_05 = param_00["spotlight_brightness"];
	wait(randomfloatrange(2,5));
	destructible_fx_think(param_00,param_01,param_02,param_03);
	level.destructible_spotlight delete();
	param_04 delete();
}

//Function Number: 100
destructible_spotlight_think(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::issp())
	{
	}

	if(!isdefined(self.breakable_light))
	{
	}

	param_01 common_scripts\utility::self_func("startignoringspotLight");
	if(!isdefined(level.destructible_spotlight))
	{
		level.destructible_spotlight = common_scripts\utility::func_7836();
		var_04 = common_scripts\utility::func_3AB9(param_00["spotlight_fx"]);
		playfxontag(var_04,level.destructible_spotlight,"tag_origin");
	}

	level notify("new_destructible_spotlight");
	level.destructible_spotlight unlink();
	var_05 = common_scripts\utility::func_7836();
	var_05 linkto(self,param_00["spotlight_tag"],(0,0,0),(0,0,0));
	level.destructible_spotlight.origin = self.breakable_light.origin;
	level.destructible_spotlight.angles = self.breakable_light.angles;
	level.destructible_spotlight thread func_796C(param_00,param_01,param_02,param_03,var_05);
	wait(0.05);
	if(isdefined(var_05))
	{
		level.destructible_spotlight linkto(var_05);
	}
}

//Function Number: 101
func_4853(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_01["fx_valid_damagetype"]))
	{
		var_04 = param_01["fx_valid_damagetype"][param_03][param_02];
	}

	if(!isdefined(var_04))
	{
		return 1;
	}

	return issubstr(var_04,param_00);
}

//Function Number: 102
destructible_sound_think(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.exploded))
	{
		return undefined;
	}

	if(!isdefined(param_00["sound"]))
	{
		return undefined;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_00["sound"][param_03]))
	{
		return undefined;
	}

	for(var_04 = 0;var_04 < param_00["sound"][param_03].size;var_04++)
	{
		var_05 = isvalidsoundcause("soundCause",param_00,var_04,param_02,param_03);
		if(!var_05)
		{
			continue;
		}

		var_06 = param_00["sound"][param_03][var_04];
		var_07 = param_00["tagName"];
		param_01 thread func_5D1D(var_06,var_07);
	}

	return param_03;
}

//Function Number: 103
destructible_fx_think(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00["fx"]))
	{
		return undefined;
	}

	if(!isdefined(param_04))
	{
		param_04 = randomint(param_00["fx_filename"].size);
	}

	if(!isdefined(param_00["fx"][param_04]))
	{
		param_04 = randomint(param_00["fx_filename"].size);
	}

	var_05 = param_00["fx_filename"][param_04].size;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		if(!func_4853(param_02,param_00,var_06,param_04))
		{
			continue;
		}

		var_07 = param_00["fx"][param_04][var_06];
		if(isdefined(param_00["fx_tag"][param_04][var_06]))
		{
			var_08 = param_00["fx_tag"][param_04][var_06];
			self notify("FX_State_Change" + param_03);
			if(param_00["fx_useTagAngles"][param_04][var_06])
			{
				playfxontag(var_07,param_01,var_08);
			}
			else
			{
				var_09 = param_01 gettagorigin(var_08);
				var_0A = var_09 + (0,0,100) - var_09;
				playfx(var_07,var_09,var_0A);
			}

			continue;
		}

		var_09 = param_01.origin;
		var_0A = var_09 + (0,0,100) - var_09;
		playfx(var_07,var_09,var_0A);
	}

	return param_04;
}

//Function Number: 104
func_2661(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.exploded))
	{
		return undefined;
	}

	if(!isdefined(param_00["animation"]))
	{
		return undefined;
	}

	if(isdefined(self.no_destructible_animation))
	{
		return undefined;
	}

	if(isdefined(param_00["randomly_flip"]) && !isdefined(self.script_noflip))
	{
		if(common_scripts\utility::func_1DE9())
		{
			self.angles = self.angles + (0,180,0);
		}
	}

	if(isdefined(param_00["spotlight_tag"]))
	{
		thread destructible_spotlight_think(param_00,param_01,param_02,param_03);
		wait(0.05);
	}

	var_04 = common_scripts\utility::func_6306(param_00["animation"]);
	var_05 = var_04["anim"];
	var_06 = var_04["animTree"];
	var_07 = var_04["groupNum"];
	var_08 = var_04["mpAnim"];
	var_09 = var_04["maxStartDelay"];
	var_0A = var_04["animRateMin"];
	var_0B = var_04["animRateMax"];
	if(!isdefined(var_0A))
	{
		var_0A = 1;
	}

	if(!isdefined(var_0B))
	{
		var_0B = 1;
	}

	if(var_0A == var_0B)
	{
		var_0C = var_0A;
	}
	else
	{
		var_0C = randomfloatrange(var_0B,var_0C);
	}

	var_0D = var_04["vehicle_exclude_anim"];
	if(self.code_classname == "script_vehicle" && var_0D)
	{
		return undefined;
	}

	param_01 common_scripts\utility::self_func("useanimtree",var_06);
	var_0E = var_04["animType"];
	if(!isdefined(self.animsapplied))
	{
		self.animsapplied = [];
	}

	self.animsapplied[self.animsapplied.size] = var_05;
	if(isdefined(self.exploding))
	{
		func_1CF6(param_01);
	}

	if(isdefined(var_09) && var_09 > 0)
	{
		wait(randomfloat(var_09));
	}

	if(!common_scripts\utility::issp())
	{
		if(isdefined(var_08))
		{
			common_scripts\utility::self_func("scriptModelPlayAnim",var_08);
		}

		return var_07;
	}

	if(var_0E == "setanim")
	{
		param_01 common_scripts\utility::self_func("setanim",var_05,1,1,var_0C);
		return var_07;
	}

	if(var_0E == "setanimknob")
	{
		param_01 common_scripts\utility::self_func("setanimknob",var_05,1,0,var_0C);
		return var_07;
	}

	return undefined;
}

//Function Number: 105
func_1CF6(param_00)
{
	if(isdefined(self.animsapplied))
	{
		foreach(var_02 in self.animsapplied)
		{
			if(common_scripts\utility::issp())
			{
				param_00 common_scripts\utility::self_func("clearanim",var_02,0);
				continue;
			}

			param_00 common_scripts\utility::self_func("scriptModelClearAnim");
		}
	}
}

//Function Number: 106
func_4537()
{
	level.destroyedcount = 0;
	level.destroyedcounttimeout = 0.5;
	if(common_scripts\utility::issp())
	{
		level.maxdestructions = 20;
	}

	level.maxdestructions = 2;
}

//Function Number: 107
add_to_destroyed_count()
{
	level.destroyedcount++;
	wait(level.destroyedcounttimeout);
	level.destroyedcount--;
}

//Function Number: 108
func_384F()
{
	return level.destroyedcount;
}

//Function Number: 109
func_38F4()
{
	return level.maxdestructions;
}

//Function Number: 110
func_4539()
{
	level.destructibleframequeue = [];
}

//Function Number: 111
add_destructible_to_frame_queue(param_00,param_01,param_02)
{
	var_03 = self getentitynumber();
	if(!isdefined(level.destructibleframequeue[var_03]))
	{
		level.destructibleframequeue[var_03] = addstruct();
		level.destructibleframequeue[var_03].entnum = var_03;
		level.destructibleframequeue[var_03].destructible = param_00;
		level.destructibleframequeue[var_03].totaldamage = 0;
		level.destructibleframequeue[var_03].neardistance = 9999999;
		level.destructibleframequeue[var_03].fxcost = 0;
	}

	level.destructibleframequeue[var_03].fxcost = level.destructibleframequeue[var_03].fxcost + param_01.var_880E["fxcost"];
	level.destructibleframequeue[var_03].totaldamage = level.destructibleframequeue[var_03].totaldamage + param_02;
	if(param_01.var_880E["distance"] < level.destructibleframequeue[var_03].neardistance)
	{
		level.destructibleframequeue[var_03].neardistance = param_01.var_880E["distance"];
	}

	thread func_3EC7();
}

//Function Number: 112
func_3EC7()
{
	level notify("handle_destructible_frame_queue");
	level endon("handle_destructible_frame_queue");
	wait(0.05);
	var_00 = level.destructibleframequeue;
	level.destructibleframequeue = [];
	var_01 = func_76F0(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(func_384F() < func_38F4())
		{
			if(var_01[var_02].fxcost)
			{
				thread add_to_destroyed_count();
			}

			var_01[var_02].destructible notify("queue_processed",1);
			continue;
		}

		var_01[var_02].destructible notify("queue_processed",0);
	}
}

//Function Number: 113
func_76F0(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	for(var_05 = 1;var_05 < var_01.size;var_05++)
	{
		var_06 = var_01[var_05];
		for(var_07 = var_05 - 1;var_07 >= 0 && func_37EC(var_06,var_01[var_07]) == var_06;var_07--)
		{
			var_01[var_07 + 1] = var_01[var_07];
		}

		var_01[var_07 + 1] = var_06;
	}

	return var_01;
}

//Function Number: 114
func_37EC(param_00,param_01)
{
	if(param_00.totaldamage > param_01.totaldamage)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 115
get_part_fx_cost_for_action_state(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][param_01]))
	{
		return var_02;
	}

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].var_880E;
	if(isdefined(var_03["fx"]))
	{
		foreach(var_05 in var_03["fx_cost"])
		{
			foreach(var_07 in var_05)
			{
				var_02 = var_02 + var_07;
			}
		}
	}

	return var_02;
}

//Function Number: 116
initdot(param_00)
{
	if(!common_scripts\utility::flag_exist("FLAG_DOT_init"))
	{
		common_scripts\utility::func_3385("FLAG_DOT_init");
		common_scripts\utility::flag_set("FLAG_DOT_init");
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "poison":
			if(!common_scripts\utility::flag_exist("FLAG_DOT_poison_init"))
			{
				common_scripts\utility::func_3385("FLAG_DOT_poison_init");
				common_scripts\utility::flag_set("FLAG_DOT_poison_init");
			}
			break;

		default:
			break;
	}
}

//Function Number: 117
createdot()
{
	var_00 = addstruct();
	var_00.ticks = [];
	return var_00;
}

//Function Number: 118
createdot_radius(param_00,param_01,param_02,param_03)
{
	var_04 = addstruct();
	var_04.type = "trigger_radius";
	var_04.origin = param_00;
	var_04.spawnflags = param_01;
	var_04.radius = param_02;
	var_04.minradius = param_02;
	var_04.maxradius = param_02;
	var_04.height = param_03;
	var_04.ticks = [];
	return var_04;
}

//Function Number: 119
func_7021(param_00)
{
	self.origin = param_00;
}

//Function Number: 120
func_7022(param_00,param_01)
{
	if(isdefined(self.classname) && self.classname != "trigger_radius")
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.minradius = param_00;
	self.maxradius = param_01;
}

//Function Number: 121
func_701F(param_00,param_01)
{
	if(isdefined(self.classname) && issubstr(self.classname,"trigger"))
	{
	}
}

//Function Number: 122
func_7020(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_00))
	{
	}
	else
	{
		param_00 = 0;
	}

	param_06 = tolower(param_06);
	param_07 = tolower(param_07);
	var_08 = self.ticks.size;
	self.ticks[var_08] = addstruct();
	self.ticks[var_08].enable = 0;
	self.ticks[var_08].delay = param_00;
	self.ticks[var_08].interval = param_01;
	self.ticks[var_08].duration = param_02;
	self.ticks[var_08].mindamage = param_03;
	self.ticks[var_08].maxdamage = param_04;
	switch(param_05)
	{
		case 1:
		case 0:
			break;

		default:
			break;
	}

	self.ticks[var_08].falloff = param_05;
	self.ticks[var_08].starttime = 0;
	switch(param_06)
	{
		case "normal":
			break;

		case "poison":
			switch(param_07)
			{
				case "player":
					self.ticks[var_08].type = param_06;
					self.ticks[var_08].affected = param_07;
					self.ticks[var_08].onenterfunc = ::func_5928;
					self.ticks[var_08].onexitfunc = ::func_5933;
					self.ticks[var_08].ondeathfunc = ::func_5910;
					break;
	
				default:
					break;
			}
			break;

		default:
			break;
	}
}

//Function Number: 123
builddot_ontick(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = self.ticks.size;
	self.ticks[var_02] = addstruct();
	self.ticks[var_02].duration = param_00;
	self.ticks[var_02].delay = 0;
	self.ticks[var_02].onenterfunc = ::func_5924;
	self.ticks[var_02].onexitfunc = ::func_5931;
	self.ticks[var_02].ondeathfunc = ::func_590F;
	switch(param_01)
	{
		case "player":
			self.ticks[var_02].affected = param_01;
			break;

		default:
			break;
	}
}

//Function Number: 124
func_185B(param_00)
{
	var_01 = self.ticks.size - 1;
	if(!isdefined(self.ticks[var_01].statements))
	{
		self.ticks[var_01].statements = [];
	}

	var_02 = self.ticks[var_01].statements.size;
	self.ticks[var_01].statements = [];
	self.ticks[var_01].statements["vars"] = [];
	self.ticks[var_01].statements["vars"]["count"] = param_00;
}

//Function Number: 125
builddot_damage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self.ticks.size - 1;
	if(!isdefined(self.ticks[var_06].statements["actions"]))
	{
		self.ticks[var_06].statements["actions"] = [];
	}

	var_07 = self.ticks[var_06].statements["actions"].size;
	self.ticks[var_06].statements["actions"][var_07] = [];
	self.ticks[var_06].statements["actions"][var_07]["vars"] = [param_00,param_01,param_02,param_03,param_04,param_05];
	self.ticks[var_06].statements["actions"][var_07]["func"] = ::func_285E;
}

//Function Number: 126
builddot_wait(param_00)
{
	var_01 = self.ticks.size - 1;
	if(!isdefined(self.ticks[var_01].statements["actions"]))
	{
		self.ticks[var_01].statements["actions"] = [];
	}

	var_02 = self.ticks[var_01].statements["actions"].size;
	self.ticks[var_01].statements["actions"][var_02] = [];
	self.ticks[var_01].statements["actions"][var_02]["vars"] = [param_00];
	self.ticks[var_01].statements["actions"][var_02]["func"] = ::dobuilddot_wait;
}

//Function Number: 127
func_5924(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	var_02 = undefined;
	var_03 = param_01.ticks[param_00].statements;
	if(!isdefined(var_03) || !isdefined(var_03["vars"]) || !isdefined(var_03["vars"]["count"]) || !isdefined(var_03["actions"]))
	{
	}

	var_04 = var_03["vars"]["count"];
	var_05 = var_03["actions"];
	var_03 = undefined;
	for(var_06 = 1;var_06 <= var_04 || var_04 == 0;var_06--)
	{
		foreach(var_08 in var_05)
		{
			var_09 = var_08["vars"];
			var_0A = var_08["func"];
			self [[ var_0A ]](param_00,param_01,var_09);
		}
	}
}

//Function Number: 128
func_5931(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 129
func_590F(param_00,param_01)
{
}

//Function Number: 130
func_285E(param_00,param_01,param_02)
{
	var_03 = param_02[0];
	var_04 = param_02[1];
	var_05 = param_02[2];
	var_06 = param_02[3];
	var_07 = param_02[4];
	var_08 = param_02[5];
	self thread [[ level.callbackplayerdamage ]](param_01,param_01,var_04,var_06,var_07,var_08,param_01.origin,(0,0,0) - param_01.origin,"none",0);
}

//Function Number: 131
dobuilddot_wait(param_00,param_01,param_02)
{
	var_03 = param_01 getentitynumber();
	var_04 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_03);
	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_03 + "_" + var_04);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_03);
	var_03 = undefined;
	var_04 = undefined;
	wait(param_02[0]);
}

//Function Number: 132
func_7AC8(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = undefined;
		switch(var_03.type)
		{
			case "trigger_radius":
				var_04 = spawn("trigger_radius",var_03.origin,var_03.spawnflags,var_03.radius,var_03.height);
				var_04.minradius = var_03.minradius;
				var_04.maxradius = var_03.maxradius;
				var_04.ticks = var_03.ticks;
				var_01[var_01.size] = var_04;
				break;

			default:
				break;
		}

		if(isdefined(var_03.parent))
		{
			var_04 linkto(var_03.parent);
			var_03.parent.dot = var_04;
		}

		var_05 = var_04.ticks;
		foreach(var_07 in var_05)
		{
			var_07.starttime = gettime();
		}

		foreach(var_07 in var_05)
		{
			if(!var_07.delay)
			{
				var_07.enable = 1;
			}
		}

		foreach(var_07 in var_05)
		{
			if(issubstr(var_07.affected,"player"))
			{
				var_04.onplayer = 1;
				break;
			}
		}
	}

	foreach(var_04 in var_01)
	{
		var_04.dot_group = [];
		foreach(var_10 in var_01)
		{
			if(var_04 == var_10)
			{
				continue;
			}

			var_04.dot_group[var_04.dot_group.size] = var_10;
		}
	}

	foreach(var_04 in var_01)
	{
		if(var_04.onplayer)
		{
			var_04 thread func_7AC9();
		}
	}

	foreach(var_04 in var_01)
	{
		var_04 thread func_5380();
	}
}

//Function Number: 133
func_7AC9()
{
	thread func_83BD(::onenterdot_player,::func_5932);
}

//Function Number: 134
func_5380()
{
	var_00 = gettime();
	while(isdefined(self))
	{
		foreach(var_04, var_02 in self.ticks)
		{
			if(isdefined(var_02) && gettime() - var_00 >= var_02.duration * 1000)
			{
				var_03 = self getentitynumber();
				self notify("LISTEN_kill_tick_" + var_04 + "_" + var_03);
				self.ticks[var_04] = undefined;
			}
		}

		if(!self.ticks.size)
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		foreach(var_02 in self.ticks)
		{
			self [[ var_02.ondeathfunc ]]();
		}

		self notify("death");
		self delete();
	}
}

//Function Number: 135
onenterdot_player(param_00)
{
	var_01 = param_00 getentitynumber();
	self notify("LISTEN_enter_dot_" + var_01);
	foreach(var_04, var_03 in param_00.ticks)
	{
		if(!var_03.enable)
		{
			thread dodot_delayfunc(var_04,param_00,var_03.delay,var_03.onenterfunc);
		}
	}

	foreach(var_04, var_03 in param_00.ticks)
	{
		if(var_03.enable && var_03.affected == "player")
		{
			self thread [[ var_03.onenterfunc ]](var_04,param_00);
		}
	}
}

//Function Number: 136
func_5932(param_00)
{
	var_01 = param_00 getentitynumber();
	self notify("LISTEN_exit_dot_" + var_01);
	foreach(var_04, var_03 in param_00.ticks)
	{
		if(var_03.enable && var_03.affected == "player")
		{
			self thread [[ var_03.onexitfunc ]](var_04,param_00);
		}
	}
}

//Function Number: 137
dodot_delayfunc(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 getentitynumber();
	var_05 = self getentitynumber();
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_04 + "_" + var_05);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self notify("LISTEN_exit_dot_" + var_04);
	var_04 = undefined;
	var_05 = undefined;
	wait(param_02);
	self thread [[ param_03 ]](param_00,param_01);
}

//Function Number: 138
func_5928(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	if(!isdefined(self.onenterdot_poisondamagecount))
	{
		self.onenterdot_poisondamagecount = [];
	}

	if(!isdefined(self.onenterdot_poisondamagecount[param_00]))
	{
		self.onenterdot_poisondamagecount[param_00] = [];
	}

	self.onenterdot_poisondamagecount[param_00][var_02] = 0;
	var_04 = common_scripts\utility::func_803F(common_scripts\utility::issp(),1.5,1);
	while(isdefined(param_01) && isdefined(param_01.ticks[param_00]))
	{
		self.onenterdot_poisondamagecount[param_00][var_02]++;
		switch(self.onenterdot_poisondamagecount[param_00][var_02])
		{
			case 1:
				self viewkick(1,self.origin);
				break;

			case 3:
				self shellshock("mp_radiation_low",4);
				func_2873(param_01,var_04 * 2);
				break;

			case 4:
				self shellshock("mp_radiation_med",5);
				thread func_2872(param_00,param_01);
				func_2873(param_01,var_04 * 2);
				break;

			case 6:
				self shellshock("mp_radiation_high",5);
				func_2873(param_01,var_04 * 2);
				break;

			case 8:
				self shellshock("mp_radiation_high",5);
				func_2873(param_01,var_04 * 500);
				break;
		}

		wait(param_01.ticks[param_00].interval);
	}
}

//Function Number: 139
func_5933(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	var_04 = self.onenterdot_poisondamageoverlay;
	if(isdefined(var_04))
	{
		foreach(var_07, var_06 in var_04)
		{
			if(isdefined(var_04[var_07]) && isdefined(var_04[var_07][var_02]))
			{
				var_04[var_07][var_02] thread func_2870(0.1,0);
			}
		}
	}

	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 140
func_5910()
{
	var_00 = self getentitynumber();
	foreach(var_02 in level.players)
	{
		var_03 = var_02.onenterdot_poisondamageoverlay;
		if(isdefined(var_03))
		{
			foreach(var_06, var_05 in var_03)
			{
				if(isdefined(var_03[var_06]) && isdefined(var_03[var_06][var_00]))
				{
					var_03[var_06][var_00] thread func_2871();
				}
			}
		}
	}
}

//Function Number: 141
func_2873(param_00,param_01)
{
	if(common_scripts\utility::issp())
	{
	}

	self thread [[ level.callbackplayerdamage ]](param_00,param_00,param_01,0,"MOD_SUICIDE","claymore_mp",param_00.origin,(0,0,0) - param_00.origin,"none",0);
}

//Function Number: 142
func_2872(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	if(!isdefined(self.onenterdot_poisondamageoverlay))
	{
		self.onenterdot_poisondamageoverlay = [];
	}

	if(!isdefined(self.onenterdot_poisondamageoverlay[param_00]))
	{
		self.onenterdot_poisondamageoverlay[param_00] = [];
	}

	if(!isdefined(self.onenterdot_poisondamageoverlay[param_00][var_02]))
	{
		var_04 = newclienthudelem(self);
		var_04.x = 0;
		var_04.y = 0;
		var_04.alignx = "left";
		var_04.aligny = "top";
		var_04.horzalign = "fullscreen";
		var_04.vertalign = "fullscreen";
		var_04.alpha = 0;
		var_04 setmaterial("black",640,480);
		self.onenterdot_poisondamageoverlay[param_00][var_02] = var_04;
	}

	var_04 = self.onenterdot_poisondamageoverlay[param_00][var_02];
	var_05 = 1;
	var_06 = 2;
	var_07 = 0.25;
	var_08 = 1;
	var_09 = 5;
	var_0A = 100;
	var_0B = 0;
	for(;;)
	{
		while(self.onenterdot_poisondamagecount[param_00][var_02] > 1)
		{
			var_0C = var_0A - var_09;
			var_0B = self.onenterdot_poisondamagecount[param_00][var_02] - var_09 / var_0C;
			if(var_0B < 0)
			{
				var_0B = 0;
			}
			else if(var_0B > 1)
			{
				var_0B = 1;
			}

			var_0D = var_06 - var_05;
			var_0E = var_05 + var_0D * 1 - var_0B;
			var_0F = var_08 - var_07;
			var_10 = var_07 + var_0F * var_0B;
			var_11 = var_0B * 0.5;
			if(var_0B == 1)
			{
				break;
			}

			var_12 = var_0E / 2;
			var_04 dodot_fadeinblackout(var_12,var_10);
			var_04 func_2870(var_12,var_11);
			wait(var_0B * 0.5);
		}

		if(var_0B == 1)
		{
			break;
		}

		if(var_04.alpha != 0)
		{
			var_04 func_2870(1,0);
		}

		wait(0.05);
	}

	var_04 dodot_fadeinblackout(2,0);
}

//Function Number: 143
dodot_fadeinblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 144
func_2870(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 145
func_2871(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
	self destroy();
}

//Function Number: 146
func_83BD(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self.entnum = self getentitynumber();
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02) && !isdefined(var_02.finished_spawning))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.touchtriggers[self.entnum]))
		{
			var_02 thread func_5FE7(self,param_00,param_01);
		}
	}
}

//Function Number: 147
func_5FE7(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(!isplayer(self))
	{
		self endon("death");
	}

	if(!common_scripts\utility::issp())
	{
		var_03 = self.guid;
	}
	else
	{
		var_03 = "player" + gettime();
	}

	param_00.touchlist[var_03] = self;
	if(isdefined(param_00.movetracker))
	{
		self.movetrackers++;
	}

	param_00 notify("trigger_enter",self);
	self notify("trigger_enter",param_00);
	var_04 = 1;
	foreach(var_06 in param_00.dot_group)
	{
		foreach(var_08 in self.touchtriggers)
		{
			if(var_06 == var_08)
			{
				var_04 = 0;
			}
		}
	}

	if(var_04 && isdefined(param_01))
	{
		self thread [[ param_01 ]](param_00);
	}

	self.touchtriggers[param_00.entnum] = param_00;
	while(isalive(self) && common_scripts\utility::issp() || !level.gameended)
	{
		var_0B = 1;
		if(self istouching(param_00))
		{
			wait(0.05);
			continue;
		}

		if(!param_00.dot_group.size)
		{
			var_0B = 0;
		}

		foreach(var_06 in param_00.dot_group)
		{
			if(self istouching(var_06))
			{
				wait(0.05);
				break;
			}
			else
			{
				var_0B = 0;
			}
		}

		if(!var_0B)
		{
			break;
		}
	}

	if(isdefined(self))
	{
		self.touchtriggers[param_00.entnum] = undefined;
		if(isdefined(param_00.movetracker))
		{
			self.movetrackers--;
		}

		self notify("trigger_leave",param_00);
		if(var_04 && isdefined(param_02))
		{
			self thread [[ param_02 ]](param_00);
		}
	}

	if(!common_scripts\utility::issp() && level.gameended)
	{
	}

	param_00.touchlist[var_03] = undefined;
	param_00 notify("trigger_leave",self);
	if(!anythingtouchingtrigger(param_00))
	{
		param_00 notify("trigger_empty");
	}
}

//Function Number: 148
anythingtouchingtrigger(param_00)
{
	return param_00.touchlist.size;
}

//Function Number: 149
func_3965(param_00)
{
	return level._destructible_preanims[param_00];
}

//Function Number: 150
func_3966(param_00)
{
	return level._destructible_preanimtree[param_00];
}
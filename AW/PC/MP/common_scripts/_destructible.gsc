/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts/_destructible.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2558 ms
 * Timestamp: 10/27/2023 1:47:14 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.destructiblespawnedentslimit = 50;
	level.destructiblespawnedents = [];
	level.currentcaralarms = 0;
	level.commonstarttime = gettime();
	if(isdefined(level.currentgen) && level.currentgen)
	{
		level.destructiblespawnedentslimit = 25;
	}

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

	init_destroyed_count();
	init_destructible_frame_queue();
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
		var_06 thread setup_destructibles_thread(var_00);
	}

	var_08 = getentarray("destructible_toy","targetname");
	foreach(var_0A in var_08)
	{
		var_0A thread setup_destructibles_thread(var_00);
	}

	debgugprintdestructiblelist();
}

//Function Number: 4
setup_destructibles_thread(param_00)
{
	setup_destructibles();
	setup_destructible_dots(param_00);
}

//Function Number: 5
setup_destructible_dots(param_00)
{
	var_01 = self.destructibleinfo;
	var_02 = param_00;
	var_0B = getfirstarraykey(var_02);
	if(isdefined(var_0B))
	{
		var_03 = var_02[var_0B];
		if(isdefined(level.destructible_type[var_01].destructible_dots))
		{
			return;
		}

		if(isdefined(var_03.script_parameters) && issubstr(var_03.script_parameters,"destructible_type") && issubstr(var_03.script_parameters,self.destructible_type))
		{
			if(distancesquared(self.origin,var_03.origin) < 1)
			{
				var_04 = getentarray(var_03.target,"targetname");
				level.destructible_type[var_01].destructible_dots = [];
				var_05 = var_04;
				var_0A = getfirstarraykey(var_05);
				if(isdefined(var_0A))
				{
					var_06 = var_05[var_0A];
					var_07 = var_06.script_index;
					if(!isdefined(level.destructible_type[var_01].destructible_dots[var_07]))
					{
						level.destructible_type[var_01].destructible_dots[var_07] = [];
					}

					var_08 = level.destructible_type[var_01].destructible_dots[var_07].size;
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["classname"] = var_06.classname;
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["origin"] = var_06.origin;
					var_09 = common_scripts\utility::ter_op(isdefined(var_06.spawnflags),var_06.spawnflags,0);
					level.destructible_type[var_01].destructible_dots[var_07][var_08]["spawnflags"] = var_09;
					switch(var_06.classname)
					{
						case "trigger_radius":
							break;

						default:
							break;
					}
				}
			}
		}
	}
}

//Function Number: 6
destructible_getinfoindex(param_00)
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
		if(param_00 == level.destructible_type[var_01].v["type"])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 7
dest_cover(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = "test/concrete_cover_dest_test";
	}

	if(!isdefined(param_03))
	{
		param_03 = 150;
	}

	destructible_create(param_00,"tag_origin",1,undefined,32,"no_melee");
	if(isdefined(param_04))
	{
		destructible_state(undefined,param_04,undefined,undefined,32,"no_melee");
	}

	for(var_06 = 0;var_06 < param_01;var_06++)
	{
		var_07 = "fx_joint_" + var_06;
		destructible_part(var_07,undefined,param_03,undefined,undefined,"no_melee",1);
		destructible_fx(var_07,param_02);
		if(isdefined(param_05))
		{
			destructible_sound(param_05);
		}

		destructible_state(undefined);
	}
}

//Function Number: 8
destructible_gettype(param_00)
{
	var_01 = destructible_getinfoindex(param_00);
	if(var_01 >= 0)
	{
		return var_01;
	}

	if(issubstr(param_00,"dest_cover"))
	{
		dest_cover(self.destructible_type,self.script_dest_cover_numchunks,self.script_dest_cover_chunkfx,self.script_dest_cover_chunkhealth,self.script_dest_cover_dmg_model,self.script_dest_cover_chunksnd);
		var_01 = destructible_getinfoindex(param_00);
		return var_01;
	}

	if(!isdefined(level.destructible_functions[param_00]))
	{
		return -1;
	}

	[[ level.destructible_functions[param_00] ]]();
	var_01 = destructible_getinfoindex(param_00);
	return var_01;
}

//Function Number: 9
setup_destructibles()
{
	var_00 = undefined;
	self.modeldummyon = 0;
	add_damage_owner_recorder();
	self.destructibleinfo = destructible_gettype(self.destructible_type);
	if(self.destructibleinfo < 0)
	{
		return;
	}

	precache_destructibles();
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
			self.destructible_parts[var_05] = spawnstruct();
			self.destructible_parts[var_05].v["currentState"] = 0;
			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][0].v["health"]))
			{
				self.destructible_parts[var_05].v["health"] = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["health"];
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][0].v["random_dynamic_attachment_1"]))
			{
				var_06 = randomint(level.destructible_type[self.destructibleinfo].parts[var_05][0].v["random_dynamic_attachment_1"].size);
				var_07 = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["random_dynamic_attachment_tag"][var_06];
				var_08 = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["random_dynamic_attachment_1"][var_06];
				var_09 = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["random_dynamic_attachment_2"][var_06];
				var_0A = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["clipToRemove"][var_06];
				thread do_random_dynamic_attachment(var_07,var_08,var_09,var_0A);
			}

			if(var_05 == 0)
			{
				continue;
			}

			var_0B = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["modelName"];
			var_0C = level.destructible_type[self.destructibleinfo].parts[var_05][0].v["tagName"];
			for(var_0D = 1;isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][var_0D]);var_0D++)
			{
				var_0E = level.destructible_type[self.destructibleinfo].parts[var_05][var_0D].v["tagName"];
				var_0F = level.destructible_type[self.destructibleinfo].parts[var_05][var_0D].v["modelName"];
				if(isdefined(var_0E) && var_0E != var_0C)
				{
					hideapart(var_0E);
					if(self.modeldummyon)
					{
						self.modeldummy hideapart(var_0E);
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

	thread destructible_think();
	if(issubstr(self.destructible_type,"dest_cover"))
	{
		thread destructiblecoverwatcher();
	}

	thread destructible_fx_spawnimmediate();
}

//Function Number: 10
destructible_create(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.destructible_type))
	{
		level.destructible_type = [];
	}

	var_06 = level.destructible_type.size;
	level.destructible_type[var_06] = spawnstruct();
	level.destructible_type[var_06].v["type"] = param_00;
	level.destructible_type[var_06].parts = [];
	level.destructible_type[var_06].parts[0][0] = spawnstruct();
	level.destructible_type[var_06].parts[0][0].v["modelName"] = self.model;
	level.destructible_type[var_06].parts[0][0].v["tagName"] = param_01;
	level.destructible_type[var_06].parts[0][0].v["health"] = param_02;
	level.destructible_type[var_06].parts[0][0].v["validAttackers"] = param_03;
	level.destructible_type[var_06].parts[0][0].v["validDamageZone"] = param_04;
	level.destructible_type[var_06].parts[0][0].v["validDamageCause"] = param_05;
	level.destructible_type[var_06].parts[0][0].v["godModeAllowed"] = 1;
	level.destructible_type[var_06].parts[0][0].v["rotateTo"] = self.angles;
	level.destructible_type[var_06].parts[0][0].v["vehicle_exclude_anim"] = 0;
}

//Function Number: 11
destructible_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.destructible_type.size - 1;
	var_0B = level.destructible_type[var_0A].parts.size;
	var_0C = 0;
	destructible_info(var_0B,var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,undefined,param_09);
}

//Function Number: 12
destructible_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].parts.size - 1;
	var_0A = level.destructible_type[var_08].parts[var_09].size;
	if(!isdefined(param_00) && var_09 == 0)
	{
		param_00 = level.destructible_type[var_08].parts[var_09][0].v["tagName"];
	}

	destructible_info(var_09,var_0A,param_00,param_01,param_02,param_03,param_04,param_05,undefined,undefined,param_06,param_07);
}

//Function Number: 13
destructible_fx_spawn_immediate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	destructible_fx(param_00,param_01,param_02,param_03,param_04,param_05,1,param_06);
}

//Function Number: 14
destructible_fx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].parts.size - 1;
	var_0A = level.destructible_type[var_08].parts[var_09].size - 1;
	var_0B = 0;
	if(isdefined(level.destructible_type[var_08].parts[var_09][var_0A].v["fx_filename"]))
	{
		if(isdefined(level.destructible_type[var_08].parts[var_09][var_0A].v["fx_filename"][param_04]))
		{
			var_0B = level.destructible_type[var_08].parts[var_09][var_0A].v["fx_filename"][param_04].size;
		}
	}

	if(isdefined(param_03))
	{
		level.destructible_type[var_08].parts[var_09][var_0A].v["fx_valid_damagetype"][param_04][var_0B] = param_03;
	}

	level.destructible_type[var_08].parts[var_09][var_0A].v["fx_filename"][param_04][var_0B] = param_01;
	level.destructible_type[var_08].parts[var_09][var_0A].v["fx_tag"][param_04][var_0B] = param_00;
	level.destructible_type[var_08].parts[var_09][var_0A].v["fx_useTagAngles"][param_04][var_0B] = param_02;
	level.destructible_type[var_08].parts[var_09][var_0A].v["fx_cost"][param_04][var_0B] = param_05;
	level.destructible_type[var_08].parts[var_09][var_0A].v["spawn_immediate"][param_04][var_0B] = param_06;
	level.destructible_type[var_08].parts[var_09][var_0A].v["state_change_kill"][param_04][var_0B] = param_07;
}

//Function Number: 15
destructible_createdot_predefined(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	if(!isdefined(level.destructible_type[var_01].parts[var_02][var_03].v["dot"]))
	{
		level.destructible_type[var_01].parts[var_02][var_03].v["dot"] = [];
	}

	var_04 = level.destructible_type[var_01].parts[var_02][var_03].v["dot"].size;
	var_05 = createdot();
	var_05.type = "predefined";
	var_05.index = param_00;
	level.destructible_type[var_01].parts[var_02][var_03].v["dot"][var_04] = var_05;
}

//Function Number: 16
destructible_createdot_radius(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	if(!isdefined(level.destructible_type[var_04].parts[var_05][var_06].v["dot"]))
	{
		level.destructible_type[var_04].parts[var_05][var_06].v["dot"] = [];
	}

	var_07 = level.destructible_type[var_04].parts[var_05][var_06].v["dot"].size;
	var_08 = createdot_radius((0,0,0),param_01,param_02,param_03);
	var_08.tag = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].v["dot"][var_07] = var_08;
}

//Function Number: 17
destructible_setdot_ontick(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].parts.size - 1;
	var_0A = level.destructible_type[var_08].parts[var_09].size - 1;
	var_0B = level.destructible_type[var_08].parts[var_09][var_0A].v["dot"].size - 1;
	var_0C = level.destructible_type[var_08].parts[var_09][var_0A].v["dot"][var_0B];
	var_0C setdot_ontick(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	initdot(param_06);
}

//Function Number: 18
destructible_setdot_ontickfunc(param_00,param_01,param_02)
{
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	var_06 = level.destructible_type[var_03].parts[var_04][var_05].v["dot"].size - 1;
	var_07 = level.destructible_type[var_03].parts[var_04][var_05].v["dot"][var_06];
	var_08 = var_07.ticks.size;
	var_07.ticks[var_08].onenterfunc = param_00;
	var_07.ticks[var_08].onexitfunc = param_01;
	var_07.ticks[var_08].ondeathfunc = param_02;
}

//Function Number: 19
destructible_builddot_ontick(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	var_05 = level.destructible_type[var_02].parts[var_03][var_04].v["dot"].size - 1;
	var_06 = level.destructible_type[var_02].parts[var_03][var_04].v["dot"][var_05];
	var_06 builddot_ontick(param_00,param_01);
}

//Function Number: 20
destructible_builddot_startloop(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	var_04 = level.destructible_type[var_01].parts[var_02][var_03].v["dot"].size - 1;
	var_05 = level.destructible_type[var_01].parts[var_02][var_03].v["dot"][var_04];
	var_05 builddot_startloop(param_00);
}

//Function Number: 21
destructible_builddot_damage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.destructible_type.size - 1;
	var_07 = level.destructible_type[var_06].parts.size - 1;
	var_08 = level.destructible_type[var_06].parts[var_07].size - 1;
	var_09 = level.destructible_type[var_06].parts[var_07][var_08].v["dot"].size - 1;
	var_0A = level.destructible_type[var_06].parts[var_07][var_08].v["dot"][var_09];
	var_0A builddot_damage(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 22
destructible_builddot_wait(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	var_04 = level.destructible_type[var_01].parts[var_02][var_03].v["dot"].size - 1;
	var_05 = level.destructible_type[var_01].parts[var_02][var_03].v["dot"][var_04];
	var_05 builddot_wait(param_00);
}

//Function Number: 23
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
	if(isdefined(level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_filename"]))
	{
		var_07 = level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_filename"].size;
	}

	level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_filename"][var_07] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_tag"][var_07] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_rate"][var_07] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].v["loopfx_cost"][var_07] = param_03;
}

//Function Number: 24
destructible_healthdrain(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	level.destructible_type[var_04].parts[var_05][var_06].v["healthdrain_amount"] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].v["healthdrain_interval"] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].v["badplace_radius"] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].v["badplace_team"] = param_03;
}

//Function Number: 25
destructible_sound(param_00,param_01,param_02)
{
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(level.destructible_type[var_03].parts[var_04][var_05].v["sound"]))
	{
		level.destructible_type[var_03].parts[var_04][var_05].v["sound"] = [];
		level.destructible_type[var_03].parts[var_04][var_05].v["soundCause"] = [];
	}

	if(!isdefined(level.destructible_type[var_03].parts[var_04][var_05].v["sound"][param_02]))
	{
		level.destructible_type[var_03].parts[var_04][var_05].v["sound"][param_02] = [];
		level.destructible_type[var_03].parts[var_04][var_05].v["soundCause"][param_02] = [];
	}

	var_06 = level.destructible_type[var_03].parts[var_04][var_05].v["sound"][param_02].size;
	level.destructible_type[var_03].parts[var_04][var_05].v["sound"][param_02][var_06] = param_00;
	level.destructible_type[var_03].parts[var_04][var_05].v["soundCause"][param_02][var_06] = param_01;
}

//Function Number: 26
destructible_loopsound(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].parts[var_03][var_04].v["loopsound"]))
	{
		level.destructible_type[var_02].parts[var_03][var_04].v["loopsound"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].v["loopsoundCause"] = [];
	}

	var_05 = level.destructible_type[var_02].parts[var_03][var_04].v["loopsound"].size;
	level.destructible_type[var_02].parts[var_03][var_04].v["loopsound"][var_05] = param_00;
	level.destructible_type[var_02].parts[var_03][var_04].v["loopsoundCause"][var_05] = param_01;
}

//Function Number: 27
destructible_anim(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
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

//Function Number: 28
destructible_spotlight(param_00)
{
	var_01 = [];
	var_01["spotlight_tag"] = param_00;
	var_01["spotlight_fx"] = "spotlight_fx";
	var_01["spotlight_brightness"] = 0.85;
	var_01["randomly_flip"] = 1;
	add_keypairs_to_destructible(var_01);
}

//Function Number: 29
add_key_to_destructible(param_00,param_01)
{
	var_02 = [];
	var_02[param_00] = param_01;
	add_keypairs_to_destructible(var_02);
}

//Function Number: 30
add_keypairs_to_destructible(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	foreach(var_06, var_05 in param_00)
	{
		level.destructible_type[var_01].parts[var_02][var_03].v[var_06] = var_05;
	}
}

//Function Number: 31
add_array_to_destructible(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	var_05 = level.destructible_type[var_02].parts[var_03][var_04].v;
	if(!isdefined(var_05[param_00]))
	{
		var_05[param_00] = [];
	}

	var_05[param_00][var_05[param_00].size] = param_01;
	level.destructible_type[var_02].parts[var_03][var_04].v = var_05;
}

//Function Number: 32
destructible_car_alarm()
{
	var_00 = level.destructible_type.size - 1;
	var_01 = level.destructible_type[var_00].parts.size - 1;
	var_02 = level.destructible_type[var_00].parts[var_01].size - 1;
	level.destructible_type[var_00].parts[var_01][var_02].v["triggerCarAlarm"] = 1;
}

//Function Number: 33
destructible_lights_out(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].v["break_nearby_lights"] = param_00;
}

//Function Number: 34
random_dynamic_attachment(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = 0;
	if(!isdefined(level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_1"]))
	{
		level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_1"] = [];
		level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_2"] = [];
		level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_tag"] = [];
	}

	var_07 = level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_1"].size;
	level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_1"][var_07] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_2"][var_07] = param_02;
	level.destructible_type[var_04].parts[var_05][var_06].v["random_dynamic_attachment_tag"][var_07] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].v["clipToRemove"][var_07] = param_03;
}

//Function Number: 35
destructible_physics(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].parts[var_03][var_04].v["physics"]))
	{
		level.destructible_type[var_02].parts[var_03][var_04].v["physics"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].v["physics_tagName"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].v["physics_velocity"] = [];
	}

	var_05 = level.destructible_type[var_02].parts[var_03][var_04].v["physics"].size;
	level.destructible_type[var_02].parts[var_03][var_04].v["physics"][var_05] = 1;
	level.destructible_type[var_02].parts[var_03][var_04].v["physics_tagName"][var_05] = param_00;
	level.destructible_type[var_02].parts[var_03][var_04].v["physics_velocity"][var_05] = param_01;
}

//Function Number: 36
destructible_splash_damage_scaler(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].v["splash_damage_scaler"] = param_00;
}

//Function Number: 37
destructible_explode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = level.destructible_type.size - 1;
	var_0F = level.destructible_type[var_0E].parts.size - 1;
	var_10 = level.destructible_type[var_0E].parts[var_0F].size - 1;
	if(common_scripts\utility::issp())
	{
		level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_range"] = param_02;
	}
	else
	{
		level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_range"] = param_03;
	}

	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode"] = 1;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_force_min"] = param_00;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_force_max"] = param_01;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_mindamage"] = param_04;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_maxdamage"] = param_05;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["continueDamage"] = param_06;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["originOffset"] = param_07;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["earthQuakeScale"] = param_08;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["earthQuakeRadius"] = param_09;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["originOffset3d"] = param_0A;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["delaytime"] = param_0B;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_angularImpulse_min"] = param_0C;
	level.destructible_type[var_0E].parts[var_0F][var_10].v["explode_angularImpulse_max"] = param_0D;
}

//Function Number: 38
destructible_function(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].v["function"] = param_00;
}

//Function Number: 39
destructible_notify(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].v["functionNotify"] = param_00;
}

//Function Number: 40
destructible_damage_threshold(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].parts.size - 1;
	var_03 = level.destructible_type[var_01].parts[var_02].size - 1;
	level.destructible_type[var_01].parts[var_02][var_03].v["damage_threshold"] = param_00;
}

//Function Number: 41
destructible_attachmodel(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = level.destructible_type.size - 1;
	if(!isdefined(level.destructible_type[var_02].attachedmodels))
	{
		level.destructible_type[var_02].attachedmodels = [];
	}

	var_03 = spawnstruct();
	var_03.model = param_01;
	var_03.tag = param_00;
	level.destructible_type[var_02].attachedmodels[level.destructible_type[var_02].attachedmodels.size] = var_03;
}

//Function Number: 42
destructible_info(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03))
	{
		param_03 = tolower(param_03);
	}

	var_0D = level.destructible_type.size - 1;
	level.destructible_type[var_0D].parts[param_00][param_01] = spawnstruct();
	level.destructible_type[var_0D].parts[param_00][param_01].v["modelName"] = param_03;
	level.destructible_type[var_0D].parts[param_00][param_01].v["tagName"] = param_02;
	level.destructible_type[var_0D].parts[param_00][param_01].v["health"] = param_04;
	level.destructible_type[var_0D].parts[param_00][param_01].v["validAttackers"] = param_05;
	level.destructible_type[var_0D].parts[param_00][param_01].v["validDamageZone"] = param_06;
	level.destructible_type[var_0D].parts[param_00][param_01].v["validDamageCause"] = param_07;
	level.destructible_type[var_0D].parts[param_00][param_01].v["alsoDamageParent"] = param_08;
	level.destructible_type[var_0D].parts[param_00][param_01].v["physicsOnExplosion"] = param_09;
	level.destructible_type[var_0D].parts[param_00][param_01].v["grenadeImpactDeath"] = param_0A;
	level.destructible_type[var_0D].parts[param_00][param_01].v["godModeAllowed"] = 0;
	level.destructible_type[var_0D].parts[param_00][param_01].v["splashRotation"] = param_0B;
	level.destructible_type[var_0D].parts[param_00][param_01].v["receiveDamageFromParent"] = param_0C;
}

//Function Number: 43
precache_destructibles()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		return;
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

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["modelName"]))
			{
				precachemodel(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["modelName"]);
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["animation"]))
			{
				var_05 = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["animation"];
				foreach(var_07 in var_05)
				{
					if(isdefined(var_07["mpAnim"]))
					{
						common_scripts\utility::noself_func("precacheMpAnim",var_07["mpAnim"]);
					}
				}
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["random_dynamic_attachment_1"]))
			{
				foreach(var_0A in level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["random_dynamic_attachment_1"])
				{
					if(isdefined(var_0A) && var_0A != "")
					{
						precachemodel(var_0A);
						precachemodel(var_0A + "_destroy");
					}
				}

				foreach(var_0A in level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["random_dynamic_attachment_2"])
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

//Function Number: 44
add_destructible_fx()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		return;
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
			if(isdefined(var_02.v["fx_filename"]))
			{
				for(var_03 = 0;var_03 < var_02.v["fx_filename"].size;var_03++)
				{
					var_04 = var_02.v["fx_filename"][var_03];
					var_05 = var_02.v["fx_tag"][var_03];
					if(isdefined(var_04))
					{
						if(isdefined(var_02.v["fx"]) && isdefined(var_02.v["fx"][var_03]) && var_02.v["fx"][var_03].size == var_04.size)
						{
							continue;
						}

						for(var_06 = 0;var_06 < var_04.size;var_06++)
						{
							var_07 = var_04[var_06];
							var_08 = var_05[var_06];
							level.destructible_type[self.destructibleinfo].parts[var_00][var_01].v["fx"][var_03][var_06] = loadfx(var_07,var_08);
						}
					}
				}
			}

			var_09 = level.destructible_type[self.destructibleinfo].parts[var_00][var_01].v["loopfx_filename"];
			var_0A = level.destructible_type[self.destructibleinfo].parts[var_00][var_01].v["loopfx_tag"];
			if(isdefined(var_09))
			{
				if(isdefined(var_02.v["loopfx"]) && var_02.v["loopfx"].size == var_09.size)
				{
					continue;
				}

				for(var_06 = 0;var_06 < var_09.size;var_06++)
				{
					var_0B = var_09[var_06];
					var_0C = var_0A[var_06];
					level.destructible_type[self.destructibleinfo].parts[var_00][var_01].v["loopfx"][var_06] = loadfx(var_0B,var_0C);
				}
			}
		}
	}
}

//Function Number: 45
candamagedestructible(param_00)
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

//Function Number: 46
destructible_think()
{
	var_00 = 0;
	var_01 = self.model;
	var_02 = undefined;
	var_03 = self.origin;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = self.model;
	destructible_update_part(var_00,var_01,var_02,var_03,var_04,var_05,var_06);
	self endon("stop_taking_damage");
	for(;;)
	{
		var_00 = undefined;
		var_05 = undefined;
		var_04 = undefined;
		var_03 = undefined;
		var_08 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_09 = undefined;
		var_0A = undefined;
		self waittill("damage",var_00,var_05,var_04,var_03,var_08,var_01,var_02,var_09,var_0A);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(isdefined(var_05) && isdefined(var_05.type) && var_05.type == "soft_landing" && !var_05 candamagedestructible(self))
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

		var_08 = getdamagetype(var_08);
		if(is_shotgun_damage(var_05,var_08))
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
			if(isdefined(var_09) && var_09 != "" && var_09 != "tag_body" && var_09 != "body_animate_jnt")
			{
				var_02 = var_09;
			}
			else
			{
				var_02 = undefined;
			}

			var_0B = level.destructible_type[self.destructibleinfo].parts[0][0].v["tagName"];
			if(isdefined(var_0B) && isdefined(var_09) && var_0B == var_09)
			{
				var_02 = undefined;
			}
		}

		if(var_08 == "splash" || var_08 == "energy")
		{
			if(isdefined(level.destructible_type[self.destructibleinfo].parts[0][0].v["splash_damage_scaler"]))
			{
				var_00 = var_00 * level.destructible_type[self.destructibleinfo].parts[0][0].v["splash_damage_scaler"];
			}
			else if(common_scripts\utility::issp())
			{
				var_00 = var_00 * 9;
			}
			else
			{
				var_00 = var_00 * 13;
			}

			if(var_07 == self.model && isdefined(self.script_dest_cover_dmg_model))
			{
				self setmodel(self.script_dest_cover_dmg_model);
			}

			destructible_splash_damage(int(var_00),var_03,var_04,var_05,var_08);
			continue;
		}

		thread destructible_update_part(int(var_00),var_01,var_02,var_03,var_04,var_05,var_08);
	}
}

//Function Number: 47
is_shotgun_damage(param_00,param_01)
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

//Function Number: 48
getpartandstateindex(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.v = [];
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
		var_04 = self.destructible_parts[var_05].v["currentState"];
		if(level.destructible_type[self.destructibleinfo].parts[var_05].size <= var_04)
		{
			continue;
		}

		if(!isdefined(param_01))
		{
			continue;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_05][var_04].v["tagName"]))
		{
			var_06 = level.destructible_type[self.destructibleinfo].parts[var_05][var_04].v["tagName"];
			if(tolower(var_06) == tolower(param_01))
			{
				var_03 = var_05;
				break;
			}
		}
	}

	var_02.v["stateIndex"] = var_04;
	var_02.v["partIndex"] = var_03;
	return var_02;
}

//Function Number: 49
destructible_update_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(self.destructible_parts))
	{
		return;
	}

	if(self.destructible_parts.size == 0)
	{
		return;
	}

	if(level.fast_destructible_explode)
	{
		self endon("destroyed");
	}

	var_08 = getpartandstateindex(param_01,param_02);
	var_09 = var_08.v["stateIndex"];
	var_0A = var_08.v["partIndex"];
	if(var_0A < 0)
	{
		return;
	}

	var_0B = var_09;
	var_0C = 0;
	var_0D = 0;
	var_09 = self.destructible_parts[var_0A].v["currentState"];
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
	{
		break;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][0].v["alsoDamageParent"]))
	{
		if(getdamagetype(param_06) != "splash")
		{
			var_0E = level.destructible_type[self.destructibleinfo].parts[var_0A][0].v["alsoDamageParent"];
			var_0F = int(param_00 * var_0E);
			thread notifydamageafterframe(var_0F,param_05,param_04,param_03,param_06,"","");
		}
	}

	if(var_0A == 0 && getdamagetype(param_06) != "splash")
	{
		for(var_10 = 0;var_10 < level.destructible_type[self.destructibleinfo].parts.size;var_10++)
		{
			var_11 = level.destructible_type[self.destructibleinfo].parts[var_10];
			if(!isdefined(var_11[0].v["receiveDamageFromParent"]))
			{
				continue;
			}

			var_12 = 0;
			if(isdefined(self.destructible_parts[var_10].v["currentState"]))
			{
				var_12 = self.destructible_parts[var_10].v["currentState"];
			}

			if(!isdefined(var_11[var_12]))
			{
				continue;
			}

			if(!isdefined(var_11[var_12].v["tagName"]))
			{
				continue;
			}

			var_13 = var_11[var_12].v["tagName"];
			var_0E = var_11[0].v["receiveDamageFromParent"];
			var_14 = int(param_00 * var_0E);
			thread notifydamageafterframe(var_14,param_05,param_04,param_03,param_06,"",var_13);
		}
	}

	if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v["health"]))
	{
		break;
	}

	if(!isdefined(self.destructible_parts[var_0A].v["health"]))
	{
		break;
	}

	if(var_0C)
	{
		self.destructible_parts[var_0A].v["health"] = level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v["health"];
	}

	var_0C = 0;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v["grenadeImpactDeath"]) && param_06 == "impact")
	{
		param_00 = 100000000;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v["damage_threshold"]) && level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v["damage_threshold"] > param_00)
	{
		param_00 = 0;
	}

	var_15 = self.destructible_parts[var_0A].v["health"];
	var_16 = isattackervalid(var_0A,var_09,param_05);
	if(var_16)
	{
		var_17 = isvaliddamagecause(var_0A,var_09,param_06);
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

			self.destructible_parts[var_0A].v["health"] = self.destructible_parts[var_0A].v["health"] - param_00;
		}
	}

	if(self.destructible_parts[var_0A].v["health"] > 0)
	{
		return;
	}

	if(isdefined(param_07))
	{
		param_07.v["fxcost"] = get_part_fx_cost_for_action_state(var_0A,self.destructible_parts[var_0A].v["currentState"]);
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
			self.destructible_parts[var_0A].v["health"] = var_15;
			return;
		}
	}

	param_00 = int(abs(self.destructible_parts[var_0A].v["health"]));
	if(param_00 < 0)
	{
		return;
	}

	self.destructible_parts[var_0A].v["currentState"]++;
	var_09 = self.destructible_parts[var_0A].v["currentState"];
	var_19 = var_09 - 1;
	var_1A = undefined;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19]))
	{
		var_1A = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v;
	}

	var_1B = undefined;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
	{
		var_1B = level.destructible_type[self.destructibleinfo].parts[var_0A][var_09].v;
	}

	if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19]))
	{
		return;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["explode"]))
	{
		self.exploding = 1;
	}

	if(isdefined(self.loopingsoundstopnotifies) && isdefined(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)]))
	{
		for(var_10 = 0;var_10 < self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)].size;var_10++)
		{
			self notify(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)][var_10]);
			if(common_scripts\utility::issp() && self.modeldummyon)
			{
				self.modeldummy notify(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)][var_10]);
			}
		}

		self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)] = undefined;
	}

	if(isdefined(var_1A["break_nearby_lights"]))
	{
		destructible_get_my_breakable_light(var_1A["break_nearby_lights"]);
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_09]))
	{
		if(var_0A == 0)
		{
			var_1C = var_1B["modelName"];
			if(isdefined(var_1C) && var_1C != self.model)
			{
				self setmodel(var_1C);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy setmodel(var_1C);
				}

				destructible_splash_rotatation(var_1B);
			}
		}
		else
		{
			hideapart(param_02);
			if(common_scripts\utility::issp() && self.modeldummyon)
			{
				self.modeldummy hideapart(param_02);
			}

			param_02 = var_1B["tagName"];
			if(isdefined(param_02))
			{
				showapart(param_02);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy showapart(param_02);
				}
			}
		}
	}

	var_1D = get_dummy();
	if(isdefined(self.exploding))
	{
		clear_anims(var_1D);
	}

	var_1E = destructible_animation_think(var_1A,var_1D,param_06,var_0A);
	var_1E = destructible_fx_think(var_1A,var_1D,param_06,var_0A,var_1E);
	self notify("FX_State_Change_Kill" + var_0A);
	var_1E = destructible_sound_think(var_1A,var_1D,param_06,var_1E);
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopfx"]))
	{
		var_1F = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopfx_filename"].size;
		if(var_1F > 0)
		{
			self notify("FX_State_Change" + var_0A);
		}

		for(var_20 = 0;var_20 < var_1F;var_20++)
		{
			var_21 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopfx"][var_20];
			var_22 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopfx_tag"][var_20];
			var_23 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopfx_rate"][var_20];
			thread loopfx_ontag(var_21,var_22,var_23,var_0A);
		}
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopsound"]))
	{
		for(var_10 = 0;var_10 < level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopsound"].size;var_10++)
		{
			var_24 = isvalidsoundcause("loopsoundCause",var_1A,var_10,param_06);
			if(var_24)
			{
				var_25 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["loopsound"][var_10];
				var_26 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["tagName"];
				thread play_loop_sound_on_destructible(var_25,var_26);
				if(!isdefined(self.loopingsoundstopnotifies))
				{
					self.loopingsoundstopnotifies = [];
				}

				if(!isdefined(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)]))
				{
					self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)] = [];
				}

				var_27 = self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)].size;
				self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_0A)][var_27] = "stop sound" + var_25;
			}
		}
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["triggerCarAlarm"]))
	{
		thread do_car_alarm();
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["break_nearby_lights"]))
	{
		thread break_nearest_light();
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["healthdrain_amount"]))
	{
		self notify("Health_Drain_State_Change" + var_0A);
		var_28 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["healthdrain_amount"];
		var_29 = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["healthdrain_interval"];
		var_2A = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["modelName"];
		var_2B = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["tagName"];
		var_2C = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["badplace_radius"];
		var_2D = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["badplace_team"];
		if(var_28 > 0)
		{
			thread health_drain(var_28,var_29,var_0A,var_2A,var_2B,var_2C,var_2D);
		}
	}

	var_2E = level.destructible_type[self.destructibleinfo].parts[var_0A][var_19].v["dot"];
	if(isdefined(var_2E))
	{
		var_2F = var_2E;
		var_3C = getfirstarraykey(var_2F);
		if(isdefined(var_3C))
		{
			var_30 = var_2F[var_3C];
			var_31 = var_30.index;
			if(var_30.type == "predefined" && isdefined(var_31))
			{
				var_32 = [];
				var_33 = level.destructible_type[self.destructibleinfo].destructible_dots[var_31];
				var_3B = getfirstarraykey(var_33);
				if(isdefined(var_3B))
				{
					var_34 = var_33[var_3B];
					var_35 = var_34["classname"];
					var_36 = undefined;
					switch(var_35)
					{
						case "trigger_radius":
							break;

						default:
							break;
					}
				}
			}
		}
	}
}

//Function Number: 50
destructible_splash_rotatation(param_00)
{
	var_01 = param_00["splashRotation"];
	var_02 = param_00["rotateTo"];
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(!var_01)
	{
		return;
	}

	self.angles = (self.angles[0],var_02[1],self.angles[2]);
}

//Function Number: 51
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

//Function Number: 52
destructible_splash_damage(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= 0)
	{
		return;
	}

	if(isdefined(self.exploded))
	{
		return;
	}

	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		return;
	}

	var_05 = getallactiveparts(param_02);
	if(var_05.size <= 0)
	{
		return;
	}

	var_05 = setdistanceonparts(var_05,param_01);
	var_06 = getlowestpartdistance(var_05);
	foreach(var_08 in var_05)
	{
		var_09 = var_08.v["distance"] * 1.4;
		var_0A = param_00 - var_09 - var_06;
		if(var_0A <= 0)
		{
			continue;
		}

		if(isdefined(self.exploded))
		{
			continue;
		}

		thread destructible_update_part(var_0A,var_08.v["modelName"],var_08.v["tagName"],param_01,param_02,param_03,param_04,var_08);
	}
}

//Function Number: 53
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
		var_04 = self.destructible_parts[var_03].v["currentState"];
		for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].parts[var_03].size;var_05++)
		{
			var_06 = level.destructible_type[self.destructibleinfo].parts[var_03][var_05].v["splashRotation"];
			if(isdefined(var_06) && var_06)
			{
				var_07 = vectortoangles(param_00);
				var_08 = var_07[1] - 90;
				level.destructible_type[self.destructibleinfo].parts[var_03][var_05].v["rotateTo"] = (0,var_08,0);
			}
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].parts[var_03][var_04]))
		{
			continue;
		}

		var_09 = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["tagName"];
		if(!isdefined(var_09))
		{
			var_09 = "";
		}

		if(var_09 == "")
		{
			continue;
		}

		var_0A = level.destructible_type[self.destructibleinfo].parts[var_03][var_04].v["modelName"];
		if(!isdefined(var_0A))
		{
			var_0A = "";
		}

		var_0B = var_01.size;
		var_01[var_0B] = spawnstruct();
		var_01[var_0B].v["modelName"] = var_0A;
		var_01[var_0B].v["tagName"] = var_09;
	}

	return var_01;
}

//Function Number: 54
setdistanceonparts(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = distance(param_01,self gettagorigin(param_00[var_02].v["tagName"]));
		param_00[var_02].v["distance"] = var_03;
	}

	return param_00;
}

//Function Number: 55
getlowestpartdistance(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		var_04 = var_03.v["distance"];
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

//Function Number: 56
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

//Function Number: 57
isattackervalid(param_00,param_01,param_02)
{
	if(isdefined(self.forceexploding))
	{
		return 1;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["explode"]))
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

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["validAttackers"];
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

//Function Number: 58
isvaliddamagecause(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["godModeAllowed"];
	if(var_03 && (isdefined(self.godmode) && self.godmode) || isdefined(self.script_bulletshield) && self.script_bulletshield && param_02 == "bullet")
	{
		return 0;
	}

	var_04 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["validDamageCause"];
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

	if(var_04 == "bullet" && param_02 != "bullet")
	{
		return 0;
	}

	return 1;
}

//Function Number: 59
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
		case "mod_melee_alt":
		case "mod_melee":
		case "melee":
			break;

		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		case "bullet":
			break;

		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
		case "splash":
			break;

		case "mod_impact":
			break;

		case "mod_energy":
			break;

		case "unknown":
			break;

		default:
			break;
	}
}

//Function Number: 60
damage_mirror(param_00,param_01,param_02)
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

//Function Number: 61
add_damage_owner_recorder()
{
	self.player_damage = 0;
	self.non_player_damage = 0;
	self.car_damage_owner_recorder = 1;
}

//Function Number: 62
loopfx_ontag(param_00,param_01,param_02,param_03)
{
	self endon("FX_State_Change" + param_03);
	self endon("delete_destructible");
	level endon("putout_fires");
	while(isdefined(self))
	{
		var_04 = get_dummy();
		playfxontag(param_00,var_04,param_01);
		wait(param_02);
	}
}

//Function Number: 63
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

				thread badplace_remove(var_07);
			}
			else
			{
				[[ level.badplace_cylinder_func ]](var_07,0,self.origin,param_05,128);
				thread badplace_remove(var_07);
			}
		}
	}

	while(isdefined(self) && self.destructible_parts[param_02].v["health"] > 0)
	{
		self notify("damage",param_00,self,(0,0,0),(0,0,0),"MOD_UNKNOWN",param_03,param_04);
		wait(param_01);
	}

	self notify("remove_badplace");
}

//Function Number: 64
badplace_remove(param_00)
{
	common_scripts\utility::waittill_any("destroyed","remove_badplace");
	[[ level.badplace_delete_func ]](param_00);
}

//Function Number: 65
physics_launch(param_00,param_01,param_02,param_03)
{
	var_04 = physics_object_create(param_00,param_01);
	var_04 physicslaunchclient(param_02,param_03);
}

//Function Number: 66
physics_launch_with_impulse(param_00,param_01,param_02,param_03)
{
	var_04 = physics_object_create(param_00,param_01);
	var_04 physicslaunchclientwithimpulse(param_02,param_03);
}

//Function Number: 67
physics_object_create(param_00,param_01)
{
	var_02 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["modelName"];
	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v["tagName"];
	hideapart(var_03);
	if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit)
	{
		physics_object_remove(level.destructiblespawnedents[0]);
	}

	var_04 = spawn("script_model",self gettagorigin(var_03));
	var_04.angles = self gettagangles(var_03);
	var_04 setmodel(var_02);
	level.destructiblespawnedents[level.destructiblespawnedents.size] = var_04;
	return var_04;
}

//Function Number: 68
physics_object_remove(param_00)
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

//Function Number: 69
explode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
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
			return;
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
		return;
	}

	var_0F = self.destructible_parts[param_00].v["currentState"];
	var_10 = undefined;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][var_0F]))
	{
		var_10 = level.destructible_type[self.destructibleinfo].parts[param_00][var_0F].v["tagName"];
	}

	if(isdefined(var_10))
	{
		var_11 = self gettagorigin(var_10);
	}
	else
	{
		var_11 = self.origin;
	}

	self notify("damage",param_05,self,(0,0,0),var_11,"MOD_EXPLOSIVE","","");
	self notify("stop_car_alarm");
	waittillframeend;
	if(isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		for(var_12 = level.destructible_type[self.destructibleinfo].parts.size - 1;var_12 >= 0;var_12--)
		{
			if(var_12 == param_00)
			{
				continue;
			}

			var_13 = self.destructible_parts[var_12].v["currentState"];
			if(var_13 >= level.destructible_type[self.destructibleinfo].parts[var_12].size)
			{
				var_13 = level.destructible_type[self.destructibleinfo].parts[var_12].size - 1;
			}

			var_14 = level.destructible_type[self.destructibleinfo].parts[var_12][var_13].v["modelName"];
			var_10 = level.destructible_type[self.destructibleinfo].parts[var_12][var_13].v["tagName"];
			if(!isdefined(var_14))
			{
				continue;
			}

			if(!isdefined(var_10))
			{
				continue;
			}

			var_15 = 0;
			if(isdefined(self.destructible_parts[var_12].v["health"]))
			{
				var_15 = self.destructible_parts[var_12].v["health"];
			}

			var_16 = 0;
			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_12][var_13].v["health"]))
			{
				var_16 = level.destructible_type[self.destructibleinfo].parts[var_12][var_13].v["health"];
			}

			if(var_16 > 0 && var_15 <= 0)
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].parts[var_12][0].v["physicsOnExplosion"]))
			{
				if(level.destructible_type[self.destructibleinfo].parts[var_12][0].v["physicsOnExplosion"] > 0)
				{
					var_17 = level.destructible_type[self.destructibleinfo].parts[var_12][0].v["physicsOnExplosion"];
					var_18 = self gettagorigin(var_10);
					var_19 = vectornormalize(var_18 - var_11);
					var_19 = var_19 * randomfloatrange(param_01,param_02) * var_17;
					if(isdefined(param_0D) && isdefined(param_0E))
					{
						var_1A = common_scripts\utility::randomvectorrange(param_0D,param_0E);
						thread physics_launch_with_impulse(var_12,var_13,var_19,var_1A);
					}
					else
					{
						thread physics_launch(var_12,var_13,var_18,var_19);
					}

					continue;
				}
			}
		}
	}

	var_1B = !isdefined(param_06) || isdefined(param_06) && !param_06;
	if(var_1B)
	{
		self notify("stop_taking_damage");
	}

	if(!level.fast_destructible_explode)
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
	}

	var_1C = var_11 + (0,0,param_07) + param_0B;
	var_1D = getsubstr(level.destructible_type[self.destructibleinfo].v["type"],0,7) == "vehicle";
	if(var_1D)
	{
		anim.lastcarexplosiontime = gettime();
		anim.lastcarexplosiondamagelocation = var_1C;
		anim.lastcarexplosionlocation = var_11;
		anim.lastcarexplosionrange = param_03;
	}

	level thread set_disable_friendlyfire_value_delayed(1);
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
			self radiusdamage(var_1C,param_03,param_05,param_04,self,"MOD_RIFLE_BULLET");
		}
		else
		{
			self radiusdamage(var_1C,param_03,param_05,param_04,self);
		}

		if(isdefined(self.damageowner) && var_1D)
		{
			self.damageowner notify("destroyed_car");
			level notify("player_destroyed_car",self.damageowner,var_1C);
		}
	}
	else
	{
		var_1E = "destructible_toy";
		if(var_1D)
		{
			var_1E = "destructible_car";
		}

		if(!isdefined(self.damageowner))
		{
			self radiusdamage(var_1C,param_03,param_05,param_04,self,"MOD_EXPLOSIVE",var_1E);
		}
		else
		{
			self radiusdamage(var_1C,param_03,param_05,param_04,self.damageowner,"MOD_EXPLOSIVE",var_1E);
			if(var_1D)
			{
				self.damageowner notify("destroyed_car");
				level notify("player_destroyed_car",self.damageowner,var_1C);
			}
		}
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		earthquake(param_08,2,var_1C,param_09);
	}

	level thread set_disable_friendlyfire_value_delayed(0,0.05);
	var_1F = 0.01;
	var_20 = param_03 * var_1F;
	param_03 = param_03 * 0.99;
	physicsexplosionsphere(var_11,param_03,0,var_20);
	if(var_1B)
	{
		self setcandamage(0);
		thread cleanupvars();
	}

	self notify("destroyed");
}

//Function Number: 70
cleanupvars()
{
	wait(0.05);
	while(isdefined(self) && isdefined(self.waiting_for_queue))
	{
		self waittill("queue_processed");
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
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
		return;
	}

	self.script_noflip = undefined;
	self.exploding = undefined;
	self.loopingsoundstopnotifies = undefined;
	self.car_alarm_org = undefined;
}

//Function Number: 71
set_disable_friendlyfire_value_delayed(param_00,param_01)
{
	level notify("set_disable_friendlyfire_value_delayed");
	level endon("set_disable_friendlyfire_value_delayed");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	level.friendlyfiredisabledfordestructible = param_00;
}

//Function Number: 72
connecttraverses()
{
	var_00 = get_traverse_disconnect_brush();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 [[ level.connectpathsfunction ]]();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 73
disconnecttraverses()
{
	var_00 = get_traverse_disconnect_brush();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00.origin = var_00.origin + (0,0,10000);
	var_00 [[ level.disconnectpathsfunction ]]();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 74
get_traverse_disconnect_brush()
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

//Function Number: 75
hideapart(param_00)
{
	self hidepart(param_00);
}

//Function Number: 76
showapart(param_00)
{
	self showpart(param_00);
}

//Function Number: 77
disable_explosion()
{
	self.dontallowexplode = 1;
}

//Function Number: 78
force_explosion()
{
	self.dontallowexplode = undefined;
	self.forceexploding = 1;
	self notify("damage",100000,self,self.origin,self.origin,"MOD_EXPLOSIVE","","");
}

//Function Number: 79
get_dummy()
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

//Function Number: 80
play_loop_sound_on_destructible(param_00,param_01)
{
	var_02 = get_dummy();
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
		return;
	}

	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 81
force_stop_sound(param_00)
{
	self endon("stop sound" + param_00);
	level waittill("putout_fires");
	self notify("stop sound" + param_00);
}

//Function Number: 82
notifydamageafterframe(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	if(isdefined(self.exploded))
	{
		return;
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
}

//Function Number: 83
play_sound(param_00,param_01)
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

//Function Number: 84
do_car_alarm()
{
	if(isdefined(self.caralarm))
	{
		return;
	}

	self.caralarm = 1;
	if(!should_do_car_alarm())
	{
		return;
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

//Function Number: 85
car_alarm_timeout()
{
	self endon("stop_car_alarm");
	wait(25);
	if(!isdefined(self))
	{
		return;
	}

	thread play_sound("car_alarm_off");
	self notify("stop_car_alarm");
}

//Function Number: 86
should_do_car_alarm()
{
	if(level.currentcaralarms >= 2)
	{
		return 0;
	}

	var_00 = undefined;
	if(!isdefined(level.lastcaralarmtime))
	{
		if(common_scripts\utility::cointoss())
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

//Function Number: 87
do_random_dynamic_attachment(param_00,param_01,param_02,param_03)
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
			return;
		}

		return;
	}

	var_04[0] setmodel(param_01 + "_destroy");
	if(isdefined(param_02) && param_02 != "")
	{
		var_04[1] setmodel(param_02 + "_destroy");
	}
}

//Function Number: 88
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

//Function Number: 89
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

	var_05 = get_player_touching(var_00);
	if(isdefined(var_05))
	{
		return 1;
	}

	return 0;
}

//Function Number: 90
get_player_touching(param_00)
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

//Function Number: 91
is_so()
{
	return getdvar("specialops") == "1";
}

//Function Number: 92
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

//Function Number: 93
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

//Function Number: 94
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

		if(is_so())
		{
			var_01 = get_player_touching(param_00);
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

//Function Number: 95
debug_player_in_post_clip(param_00)
{
}

//Function Number: 96
destructible_get_my_breakable_light(param_00)
{
	var_01 = getentarray("light_destructible","targetname");
	if(common_scripts\utility::issp())
	{
		var_02 = getentarray("light_destructible","script_noteworthy");
		var_01 = common_scripts\utility::array_combine(var_01,var_02);
	}

	if(!var_01.size)
	{
		return;
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
		return;
	}

	self.breakable_light = var_04;
}

//Function Number: 97
break_nearest_light(param_00)
{
	if(!isdefined(self.breakable_light))
	{
		return;
	}

	self.breakable_light setlightintensity(0);
}

//Function Number: 98
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

	thread debug_circle_drawlines(var_06,5,(1,0,0),param_00);
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

	thread debug_circle_drawlines(var_06,5,(1,0,0),param_00);
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

	thread debug_circle_drawlines(var_06,5,(1,0,0),param_00);
}

//Function Number: 99
debug_circle_drawlines(param_00,param_01,param_02,param_03)
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

//Function Number: 100
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

//Function Number: 101
spotlight_tag_origin_cleanup(param_00)
{
	param_00 endon("death");
	level waittill("new_destructible_spotlight");
	param_00 delete();
}

//Function Number: 102
spotlight_fizzles_out(param_00,param_01,param_02,param_03,param_04)
{
	level endon("new_destructible_spotlight");
	thread spotlight_tag_origin_cleanup(param_04);
	var_05 = param_00["spotlight_brightness"];
	wait(randomfloatrange(2,5));
	destructible_fx_think(param_00,param_01,param_02,param_03);
	level.destructible_spotlight delete();
	param_04 delete();
}

//Function Number: 103
destructible_spotlight_think(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	if(!isdefined(self.breakable_light))
	{
		return;
	}

	param_01 common_scripts\utility::self_func("startignoringspotLight");
	if(!isdefined(level.destructible_spotlight))
	{
		level.destructible_spotlight = common_scripts\utility::spawn_tag_origin();
		var_04 = common_scripts\utility::getfx(param_00["spotlight_fx"]);
		playfxontag(var_04,level.destructible_spotlight,"tag_origin");
	}

	level notify("new_destructible_spotlight");
	level.destructible_spotlight unlink();
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05 linkto(self,param_00["spotlight_tag"],(0,0,0),(0,0,0));
	level.destructible_spotlight.origin = self.breakable_light.origin;
	level.destructible_spotlight.angles = self.breakable_light.angles;
	level.destructible_spotlight thread spotlight_fizzles_out(param_00,param_01,param_02,param_03,var_05);
	wait(0.05);
	if(isdefined(var_05))
	{
		level.destructible_spotlight linkto(var_05);
	}
}

//Function Number: 104
is_valid_damagetype(param_00,param_01,param_02,param_03)
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

//Function Number: 105
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
		param_01 thread play_sound(var_06,var_07);
	}

	return param_03;
}

//Function Number: 106
destructible_fx_kill_state_wait(param_00)
{
	var_01 = level.destructible_type[self.destructibleinfo].parts[0].size - 1;
	self endon("FX_State_Change_Kill" + param_00);
	for(;;)
	{
		var_02 = -1;
		if(isdefined(self.destructible_parts[0].v["currentState"]))
		{
			var_02 = self.destructible_parts[0].v["currentState"];
		}

		if(var_02 == var_01)
		{
			return 0;
		}

		wait 0.05;
	}
}

//Function Number: 107
destructible_fx_spawn_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	waittillframeend;
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(param_02))
	{
		if(param_04)
		{
			playfxontag(param_01,param_00,param_02);
			wait(0.05);
			if(param_05 == 1 || param_05 == 2)
			{
				destructible_fx_kill_state_wait(param_03);
				if(param_05 == 1)
				{
					stopfxontag(param_01,param_00,param_02);
					return;
				}

				killfxontag(param_01,param_00,param_02);
				return;
			}

			return;
		}

		var_08 = param_00 gettagorigin(param_02);
		var_09 = (0,0,100);
		if(param_05 == 1 || param_05 == 2)
		{
			var_07 = spawnfx(param_01,var_08,var_09);
			var_06 = triggerfx(var_07,0.01);
		}
		else
		{
			var_06 = playfx(param_01,var_08,var_09);
		}

		wait(0.05);
		if(param_05 == 1 || param_05 == 2)
		{
			destructible_fx_kill_state_wait(param_03);
			if(param_05 == 1)
			{
				var_07 delete();
				return;
			}

			if(param_05 == 2)
			{
				setfxkillondelete(var_07,1);
				wait(0.05);
				var_07 delete();
				return;
			}

			return;
		}

		return;
	}

	var_08 = param_02.origin;
	var_09 = (0,0,100);
	if(param_05 == 1 || param_05 == 2)
	{
		var_07 = spawnfx(param_01,var_08,var_09);
		var_06 = triggerfx(var_07,0.01);
	}
	else
	{
		var_06 = playfx(param_01,var_08,var_09);
	}

	wait(0.05);
	if(param_05 == 1 || param_05 == 2)
	{
		destructible_fx_kill_state_wait(param_03);
		if(param_05 == 1)
		{
			var_07 delete();
			return;
		}

		if(param_05 == 2)
		{
			setfxkillondelete(var_07,1);
			wait(0.05);
			var_07 delete();
			return;
		}

		return;
	}
}

//Function Number: 108
destructible_fx_spawnimmediate()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts))
	{
		return;
	}

	var_00 = get_dummy();
	for(var_01 = 0;var_01 < level.destructible_type[self.destructibleinfo].parts.size;var_01++)
	{
		for(var_02 = 0;var_02 < level.destructible_type[self.destructibleinfo].parts[var_01].size;var_02++)
		{
			var_03 = level.destructible_type[self.destructibleinfo].parts[var_01][var_02];
			if(isdefined(var_03.v["fx_filename"]))
			{
				for(var_04 = 0;var_04 < var_03.v["fx_filename"].size;var_04++)
				{
					var_05 = var_03.v["fx_filename"][var_04];
					var_06 = var_03.v["fx_tag"][var_04];
					var_07 = var_03.v["spawn_immediate"][var_04];
					if(isdefined(var_05) && isdefined(var_07))
					{
						for(var_08 = 0;var_08 < var_05.size;var_08++)
						{
							if(var_07[var_08] == 1)
							{
								var_09 = var_03.v["state_change_kill"][var_04][var_08];
								var_0A = level.destructible_type[self.destructibleinfo].parts[var_01][var_02].v["fx"][var_04][var_08];
								var_0B = var_06[var_08];
								var_0C = var_05[var_08];
								var_0D = level.destructible_type[self.destructibleinfo].parts[var_01][var_02].v["fx_useTagAngles"][var_04][var_08];
								thread destructible_fx_spawn_think(var_00,var_0A,var_0B,var_01,var_0D,var_09);
							}
						}
					}
				}
			}
		}
	}
}

//Function Number: 109
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
		if(!is_valid_damagetype(param_02,param_00,var_06,param_04))
		{
			continue;
		}

		if(param_00["spawn_immediate"][param_04][var_06] == 1)
		{
			continue;
		}

		var_07 = param_00["fx"][param_04][var_06];
		var_08 = param_00["state_change_kill"][param_04][var_06];
		if(isdefined(param_00["fx_tag"][param_04][var_06]))
		{
			var_09 = param_00["fx_tag"][param_04][var_06];
			self notify("FX_State_Change" + param_03);
			if(param_00["fx_useTagAngles"][param_04][var_06])
			{
				thread destructible_fx_spawn_think(param_01,var_07,var_09,param_03,1,var_08);
			}
			else
			{
				thread destructible_fx_spawn_think(param_01,var_07,var_09,param_03,0,var_08);
			}

			continue;
		}

		thread destructible_fx_spawn_think(param_01,var_07,undefined,param_03,0,var_08);
	}

	return param_04;
}

//Function Number: 110
destructible_animation_think(param_00,param_01,param_02,param_03)
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
		if(common_scripts\utility::cointoss())
		{
			self.angles = self.angles + (0,180,0);
		}
	}

	if(isdefined(param_00["spotlight_tag"]))
	{
		thread destructible_spotlight_think(param_00,param_01,param_02,param_03);
		wait(0.05);
	}

	var_04 = common_scripts\utility::random(param_00["animation"]);
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
		clear_anims(param_01);
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

//Function Number: 111
clear_anims(param_00)
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

//Function Number: 112
init_destroyed_count()
{
	level.destroyedcount = 0;
	level.destroyedcounttimeout = 0.5;
	if(common_scripts\utility::issp())
	{
		level.maxdestructions = 20;
		return;
	}

	level.maxdestructions = 2;
}

//Function Number: 113
add_to_destroyed_count()
{
	level.destroyedcount++;
	wait(level.destroyedcounttimeout);
	level.destroyedcount--;
}

//Function Number: 114
get_destroyed_count()
{
	return level.destroyedcount;
}

//Function Number: 115
get_max_destroyed_count()
{
	return level.maxdestructions;
}

//Function Number: 116
init_destructible_frame_queue()
{
	level.destructibleframequeue = [];
}

//Function Number: 117
add_destructible_to_frame_queue(param_00,param_01,param_02)
{
	var_03 = self getentitynumber();
	if(!isdefined(level.destructibleframequeue[var_03]))
	{
		level.destructibleframequeue[var_03] = spawnstruct();
		level.destructibleframequeue[var_03].entnum = var_03;
		level.destructibleframequeue[var_03].destructible = param_00;
		level.destructibleframequeue[var_03].totaldamage = 0;
		level.destructibleframequeue[var_03].neardistance = 9999999;
		level.destructibleframequeue[var_03].fxcost = 0;
	}

	level.destructibleframequeue[var_03].fxcost = level.destructibleframequeue[var_03].fxcost + param_01.v["fxcost"];
	level.destructibleframequeue[var_03].totaldamage = level.destructibleframequeue[var_03].totaldamage + param_02;
	if(param_01.v["distance"] < level.destructibleframequeue[var_03].neardistance)
	{
		level.destructibleframequeue[var_03].neardistance = param_01.v["distance"];
	}

	thread handle_destructible_frame_queue();
}

//Function Number: 118
handle_destructible_frame_queue()
{
	level notify("handle_destructible_frame_queue");
	level endon("handle_destructible_frame_queue");
	wait(0.05);
	var_00 = level.destructibleframequeue;
	level.destructibleframequeue = [];
	var_01 = sort_destructible_frame_queue(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(get_destroyed_count() < get_max_destroyed_count())
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

//Function Number: 119
sort_destructible_frame_queue(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	for(var_05 = 1;var_05 < var_01.size;var_05++)
	{
		var_06 = var_01[var_05];
		for(var_07 = var_05 - 1;var_07 >= 0 && get_better_destructible(var_06,var_01[var_07]) == var_06;var_07--)
		{
			var_01[var_07 + 1] = var_01[var_07];
		}

		var_01[var_07 + 1] = var_06;
	}

	return var_01;
}

//Function Number: 120
get_better_destructible(param_00,param_01)
{
	if(param_00.totaldamage > param_01.totaldamage)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 121
get_part_fx_cost_for_action_state(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.destructible_type[self.destructibleinfo].parts[param_00][param_01]))
	{
		return var_02;
	}

	var_03 = level.destructible_type[self.destructibleinfo].parts[param_00][param_01].v;
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

//Function Number: 122
initdot(param_00)
{
	if(!common_scripts\utility::flag_exist("FLAG_DOT_init"))
	{
		common_scripts\utility::flag_init("FLAG_DOT_init");
		common_scripts\utility::flag_set("FLAG_DOT_init");
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "poison":
			break;

		default:
			break;
	}
}

//Function Number: 123
createdot()
{
	var_00 = spawnstruct();
	var_00.ticks = [];
	return var_00;
}

//Function Number: 124
createdot_radius(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
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

//Function Number: 125
setdot_origin(param_00)
{
	self.origin = param_00;
}

//Function Number: 126
setdot_radius(param_00,param_01)
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

//Function Number: 127
setdot_height(param_00,param_01)
{
	if(isdefined(self.classname) && issubstr(self.classname,"trigger"))
	{
	}
}

//Function Number: 128
setdot_ontick(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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
	self.ticks[var_08] = spawnstruct();
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
}

//Function Number: 129
builddot_ontick(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = self.ticks.size;
	self.ticks[var_02] = spawnstruct();
	self.ticks[var_02].duration = param_00;
	self.ticks[var_02].delay = 0;
	self.ticks[var_02].onenterfunc = ::onenterdot_buildfunc;
	self.ticks[var_02].onexitfunc = ::onexitdot_buildfunc;
	self.ticks[var_02].ondeathfunc = ::ondeathdot_buildfunc;
	switch(param_01)
	{
		case "player":
			break;

		default:
			break;
	}
}

//Function Number: 130
builddot_startloop(param_00)
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

//Function Number: 131
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
	self.ticks[var_06].statements["actions"][var_07]["func"] = ::dobuilddot_damage;
}

//Function Number: 132
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

//Function Number: 133
onenterdot_buildfunc(param_00,param_01)
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
		return;
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

//Function Number: 134
onexitdot_buildfunc(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 135
ondeathdot_buildfunc(param_00,param_01)
{
}

//Function Number: 136
dobuilddot_damage(param_00,param_01,param_02)
{
	var_03 = param_02[0];
	var_04 = param_02[1];
	var_05 = param_02[2];
	var_06 = param_02[3];
	var_07 = param_02[4];
	var_08 = param_02[5];
	self thread [[ level.callbackplayerdamage ]](param_01,param_01,var_04,var_06,var_07,var_08,param_01.origin,(0,0,0) - param_01.origin,"none",0);
}

//Function Number: 137
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

//Function Number: 138
startdot_group(param_00)
{
	var_01 = [];
	var_02 = param_00;
	var_0D = getfirstarraykey(var_02);
	if(isdefined(var_0D))
	{
		var_03 = var_02[var_0D];
		var_04 = undefined;
		switch(var_03.type)
		{
			case "trigger_radius":
				break;

			default:
				break;
		}
	}
}

//Function Number: 139
startdot_player()
{
	thread triggertouchthink(::onenterdot_player,::onexitdot_player);
}

//Function Number: 140
monitordot()
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

//Function Number: 141
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

//Function Number: 142
onexitdot_player(param_00)
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

//Function Number: 143
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

//Function Number: 144
onenterdot_poisondamageplayer(param_00,param_01)
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
	var_04 = common_scripts\utility::ter_op(common_scripts\utility::issp(),1.5,1);
	if(isdefined(param_01) && isdefined(param_01.ticks[param_00]))
	{
		self.onenterdot_poisondamagecount[param_00][var_02]++;
		switch(self.onenterdot_poisondamagecount[param_00][var_02])
		{
			case 1:
				break;

			case 3:
				break;

			case 4:
				break;

			case 6:
				break;

			case 8:
				break;
		}
	}
}

//Function Number: 145
onexitdot_poisondamageplayer(param_00,param_01)
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
				var_04[var_07][var_02] thread dodot_fadeoutblackout(0.1,0);
			}
		}
	}

	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 146
ondeathdot_poisondamageplayer()
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
					var_03[var_06][var_00] thread dodot_fadeoutblackoutanddestroy();
				}
			}
		}
	}
}

//Function Number: 147
dodot_poisondamage(param_00,param_01)
{
	if(common_scripts\utility::issp())
	{
		return;
	}

	self thread [[ level.callbackplayerdamage ]](param_00,param_00,param_01,0,"MOD_SUICIDE","claymore_mp",param_00.origin,(0,0,0) - param_00.origin,"none",0);
}

//Function Number: 148
dodot_poisonblackout(param_00,param_01)
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
		var_04 setshader("black",640,480);
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
			var_04 dodot_fadeoutblackout(var_12,var_11);
			wait(var_0B * 0.5);
		}

		if(var_0B == 1)
		{
			break;
		}

		if(var_04.alpha != 0)
		{
			var_04 dodot_fadeoutblackout(1,0);
		}

		wait(0.05);
	}

	var_04 dodot_fadeinblackout(2,0);
}

//Function Number: 149
dodot_fadeinblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 150
dodot_fadeoutblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 151
dodot_fadeoutblackoutanddestroy(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	param_01 = undefined;
	wait(param_00);
	self destroy();
}

//Function Number: 152
triggertouchthink(param_00,param_01)
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
			var_02 thread playertouchtriggerthink(self,param_00,param_01);
		}
	}
}

//Function Number: 153
playertouchtriggerthink(param_00,param_01,param_02)
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
		return;
	}

	param_00.touchlist[var_03] = undefined;
	param_00 notify("trigger_leave",self);
	if(!anythingtouchingtrigger(param_00))
	{
		param_00 notify("trigger_empty");
	}
}

//Function Number: 154
anythingtouchingtrigger(param_00)
{
	return param_00.touchlist.size;
}

//Function Number: 155
get_precached_anim(param_00)
{
	return level._destructible_preanims[param_00];
}

//Function Number: 156
get_precached_animtree(param_00)
{
	return level._destructible_preanimtree[param_00];
}

//Function Number: 157
destructiblecoverwatcher()
{
	if(!isdefined(level.player))
	{
		return;
	}

	if(!isdefined(self.script_dest_cover_dmg_dist))
	{
		self.script_dest_cover_dmg_dist = 20000;
	}

	while(isdefined(self))
	{
		if(isdefined(self.destructible_parts))
		{
			var_00 = 0;
			for(var_01 = 1;var_01 < self.destructible_parts.size;var_01++)
			{
				if(self.destructible_parts[var_01].v["currentState"] == 1)
				{
					var_00++;
				}
			}

			if(var_00 == self.destructible_parts.size - 1)
			{
				break;
			}
		}

		var_02 = distancesquared(level.player.origin,self.origin);
		if(var_02 > self.script_dest_cover_dmg_dist * self.script_dest_cover_dmg_dist)
		{
			self setcandamage(0);
			continue;
		}

		self setcandamage(1);
		wait(0.05);
	}
}
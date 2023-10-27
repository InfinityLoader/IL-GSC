/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 99
 * Decompile Time: 1532 ms
 * Timestamp: 10/27/2023 2:24:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_E38 = 50;
	level.var_E39 = [];
	level.var_E3A = 0;
	level.var_E3B = gettime();
	if(!isdefined(level.var_E3C))
	{
		level.var_E3C = 0;
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
warn_about_old_destructible()
{
	wait 1;
	var_00 = getentarray("destructible","targetname");
	if(var_00.size != 0)
	{
		foreach(var_02 in var_00)
		{
		}
	}
}

//Function Number: 3
find_destructibles()
{
	var_00 = [];
	switch(getdvar("mapname"))
	{
		case "mp_interchange":
			break;
	var_7B[var_7B.size]
	(3.4,-912.9,646.9)
	var_7B[var_7B.size]
	(2096,1042.5,580.4)
	var_7B[var_7B.size]
	(2061.6,643.2,597.7)
	var_7B[var_7B.size]
	(1662.3,687.5,599.9)
	var_7B[var_7B.size]
	(1418.6,311.3,602.1)
	var_7B[var_7B.size]
	(-29.3,695.7,349)
	var_7B[var_7B.size]
	(-1030.6,2989.5,445.5)
	var_7B[var_7B.size]
	(-1347.8,2905.9,445.9)
	var_7B[var_7B.size]
	(-2966.6,1288.5,378)
	var_7B[var_7B.size]
	(-2038.3,613,378)
	var_7B[var_7B.size]
	(845.6,-1766.3,400.6)
	var_7B[var_7B.size]
	(1276.2,-1882.9,403)
	var_7B[var_7B.size]
	(1497.2,-2220.9,449.5)
	var_7B[var_7B.size]
	(2694.9,-3433,414.4)
	var_7B[var_7B.size]
	(2920.1,-3423.3,416.6)
	var_7B[var_7B.size]
	(1719.8,-711,328.5)
	var_7B[var_7B.size]
	(2451.2,-1034.6,345.6)
	var_7B[var_7B.size]
	(2852.6,-1220.7,345.6)
	var_7B[var_7B.size]
	(3503.7,-1634.5,345.6)
	var_7B[var_7B.size]
	(3333.3,-1743.4,345.6)
	var_7B[var_7B.size]
	(4070.5,-2049.2,349.2)
	var_7B[var_00.size]
	(4172.8,-1887,345.9)
			break;
	}

	var_01 = getentarray("destructible_vehicle","targetname");
	foreach(var_03 in var_01)
	{
		switch(getdvar("mapname"))
		{
			case "mp_interchange":
				if(var_03.origin[2] > 150)
				{
					var_04 = 0;
					foreach(var_06 in var_7B)
					{
						if(int(var_03.origin[0]) == int(var_06[0]) && int(var_03.origin[1]) == int(var_06[1]) && int(var_03.origin[2]) == int(var_06[2]))
						{
							var_04 = 1;
							break;
						}
					}
	
					if(var_04)
					{
						break;
					}
				}
				break;
		}

		var_03 setup_destructibles();
	}

	var_09 = getentarray("destructible_toy","targetname");
	foreach(var_0B in var_09)
	{
		var_0B setup_destructibles();
	}
}

//Function Number: 4
setup_destructibles(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = undefined;
	self.modeldummyon = 0;
	add_damage_owner_recorder();
	self.destructibleinfo = common_scripts\_destructible_types::maketype(self.destructible_type);
	if(self.destructibleinfo < 0)
	{
		return;
	}

	if(!param_00)
	{
		precache_destructibles();
	}

	add_destructible_fx();
	if(isdefined(level.destructible_type[self.destructibleinfo].var_E42))
	{
		self.var_E43 = [];
		for(var_03 = 0;var_03 < level.destructible_type[self.destructibleinfo].var_E42.size;var_03++)
		{
			self.var_E43[var_03] = spawnstruct();
			self.var_E43[var_03].v["currentState"] = 0;
			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["health"]))
			{
				self.var_E43[var_03].v["health"] = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["health"];
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["random_dynamic_attachment_1"]))
			{
				var_04 = randomint(level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["random_dynamic_attachment_1"].size);
				var_05 = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["random_dynamic_attachment_tag"][var_04];
				var_06 = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["random_dynamic_attachment_1"][var_04];
				var_07 = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["random_dynamic_attachment_2"][var_04];
				var_08 = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["clipToRemove"][var_04];
				thread do_random_dynamic_attachment(var_05,var_06,var_07,var_08);
			}

			if(var_03 == 0)
			{
				continue;
			}

			var_09 = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["modelName"];
			var_0A = level.destructible_type[self.destructibleinfo].var_E42[var_03][0].v["tagName"];
			for(var_0B = 1;isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_03][var_0B]);var_0B++)
			{
				var_0C = level.destructible_type[self.destructibleinfo].var_E42[var_03][var_0B].v["tagName"];
				var_0D = level.destructible_type[self.destructibleinfo].var_E42[var_03][var_0B].v["modelName"];
				if(isdefined(var_0C) && var_0C != var_0A)
				{
					hideapart(var_0C);
					if(self.modeldummyon)
					{
						self.modeldummy hideapart(var_0C);
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
}

//Function Number: 5
destructible_create(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.destructible_type))
	{
		level.destructible_type = [];
	}

	var_06 = level.destructible_type.size;
	var_06 = level.destructible_type.size;
	level.destructible_type[var_06] = spawnstruct();
	level.destructible_type[var_06].v["type"] = param_00;
	level.destructible_type[var_06].var_E42 = [];
	level.destructible_type[var_06].var_E42[0][0] = spawnstruct();
	level.destructible_type[var_06].var_E42[0][0].v["modelName"] = self.model;
	level.destructible_type[var_06].var_E42[0][0].v["tagName"] = param_01;
	level.destructible_type[var_06].var_E42[0][0].v["health"] = param_02;
	level.destructible_type[var_06].var_E42[0][0].v["validAttackers"] = param_03;
	level.destructible_type[var_06].var_E42[0][0].v["validDamageZone"] = param_04;
	level.destructible_type[var_06].var_E42[0][0].v["validDamageCause"] = param_05;
	level.destructible_type[var_06].var_E42[0][0].v["godModeAllowed"] = 1;
	level.destructible_type[var_06].var_E42[0][0].v["rotateTo"] = self.angles;
	level.destructible_type[var_06].var_E42[0][0].v["vehicle_exclude_anim"] = 0;
}

//Function Number: 6
destructible_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.destructible_type.size - 1;
	var_0B = level.destructible_type[var_0A].var_E42.size;
	var_0C = 0;
	destructible_info(var_0B,var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,undefined,param_09);
}

//Function Number: 7
destructible_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.destructible_type.size - 1;
	var_09 = level.destructible_type[var_08].var_E42.size - 1;
	var_0A = level.destructible_type[var_08].var_E42[var_09].size;
	if(!isdefined(param_00) && var_09 == 0)
	{
		param_00 = level.destructible_type[var_08].var_E42[var_09][0].v["tagName"];
	}

	destructible_info(var_09,var_0A,param_00,param_01,param_02,param_03,param_04,param_05,undefined,undefined,param_06,param_07);
}

//Function Number: 8
destructible_fx(param_00,param_01,param_02,param_03,param_04,param_05)
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
	var_07 = level.destructible_type[var_06].var_E42.size - 1;
	var_08 = level.destructible_type[var_06].var_E42[var_07].size - 1;
	var_09 = 0;
	if(isdefined(level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_filename"]))
	{
		if(isdefined(level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_filename"][param_04]))
		{
			var_09 = level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_filename"][param_04].size;
		}
	}

	if(isdefined(param_03))
	{
		level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_valid_damagetype"][param_04][var_09] = param_03;
	}

	level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_filename"][param_04][var_09] = param_01;
	level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_tag"][param_04][var_09] = param_00;
	level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_useTagAngles"][param_04][var_09] = param_02;
	level.destructible_type[var_06].var_E42[var_07][var_08].v["fx_cost"][param_04][var_09] = param_05;
}

//Function Number: 9
destructible_loopfx(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].var_E42.size - 1;
	var_06 = level.destructible_type[var_04].var_E42[var_05].size - 1;
	var_07 = 0;
	if(isdefined(level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_filename"]))
	{
		var_07 = level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_filename"].size;
	}

	level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_filename"][var_07] = param_01;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_tag"][var_07] = param_00;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_rate"][var_07] = param_02;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["loopfx_cost"][var_07] = param_03;
}

//Function Number: 10
destructible_healthdrain(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].var_E42.size - 1;
	var_06 = level.destructible_type[var_04].var_E42[var_05].size - 1;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["healthdrain_amount"] = param_00;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["healthdrain_interval"] = param_01;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["badplace_radius"] = param_02;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["badplace_team"] = param_03;
}

//Function Number: 11
destructible_sound(param_00,param_01,param_02)
{
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].var_E42.size - 1;
	var_05 = level.destructible_type[var_03].var_E42[var_04].size - 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"]))
	{
		level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"] = [];
		level.destructible_type[var_03].var_E42[var_04][var_05].v["soundCause"] = [];
	}

	if(!isdefined(level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"][param_02]))
	{
		level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"][param_02] = [];
		level.destructible_type[var_03].var_E42[var_04][var_05].v["soundCause"][param_02] = [];
	}

	var_06 = level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"][param_02].size;
	level.destructible_type[var_03].var_E42[var_04][var_05].v["sound"][param_02][var_06] = param_00;
	level.destructible_type[var_03].var_E42[var_04][var_05].v["soundCause"][param_02][var_06] = param_01;
}

//Function Number: 12
destructible_loopsound(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].var_E42.size - 1;
	var_04 = level.destructible_type[var_02].var_E42[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsound"]))
	{
		level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsound"] = [];
		level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsoundCause"] = [];
	}

	var_05 = level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsound"].size;
	level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsound"][var_05] = param_00;
	level.destructible_type[var_02].var_E42[var_03][var_04].v["loopsoundCause"][var_05] = param_01;
}

//Function Number: 13
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
	add_array_to_destructible("animation",var_7B);
}

//Function Number: 14
destructible_spotlight(param_00)
{
	var_01 = [];
	var_02 = [];
	var_7B["dvars"] = var_02;
	add_keypairs_to_destructible(var_7B);
}

//Function Number: 15
add_key_to_destructible(param_00,param_01)
{
	var_02 = [];
	add_keypairs_to_destructible(var_7B);
}

//Function Number: 16
add_keypairs_to_destructible(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].var_E42.size - 1;
	var_03 = level.destructible_type[var_01].var_E42[var_02].size - 1;
	foreach(var_06, var_05 in param_00)
	{
		level.destructible_type[var_01].var_E42[var_02][var_03].v[var_06] = var_05;
	}
}

//Function Number: 17
add_array_to_destructible(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].var_E42.size - 1;
	var_04 = level.destructible_type[var_02].var_E42[var_03].size - 1;
	var_05 = level.destructible_type[var_02].var_E42[var_03][var_04].v;
	if(!isdefined(var_05[param_00]))
	{
	}

	var_1C[param_01] = var_7B[param_01].size;
	level.destructible_type[var_04].var_E42[var_05][var_7B].v = var_1C;
}

//Function Number: 18
destructible_car_alarm()
{
	var_00 = level.destructible_type.size - 1;
	var_01 = level.destructible_type[var_00].var_E42.size - 1;
	var_02 = level.destructible_type[var_00].var_E42[var_01].size - 1;
	level.destructible_type[var_00].var_E42[var_01][var_02].v["triggerCarAlarm"] = 1;
}

//Function Number: 19
destructible_lights_out(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].var_E42.size - 1;
	var_03 = level.destructible_type[var_01].var_E42[var_02].size - 1;
	level.destructible_type[var_01].var_E42[var_02][var_03].v["break_nearby_lights"] = param_00;
}

//Function Number: 20
random_dynamic_attachment(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].var_E42.size - 1;
	var_06 = 0;
	if(!isdefined(level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_1"]))
	{
		level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_1"] = [];
		level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_2"] = [];
		level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_tag"] = [];
	}

	var_07 = level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_1"].size;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_1"][var_07] = param_01;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_2"][var_07] = param_02;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["random_dynamic_attachment_tag"][var_07] = param_00;
	level.destructible_type[var_04].var_E42[var_05][var_06].v["clipToRemove"][var_07] = param_03;
}

//Function Number: 21
destructible_physics(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].var_E42.size - 1;
	var_04 = level.destructible_type[var_02].var_E42[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].var_E42[var_03][var_04].v["physics"]))
	{
		level.destructible_type[var_02].var_E42[var_03][var_04].v["physics"] = [];
		level.destructible_type[var_02].var_E42[var_03][var_04].v["physics_tagName"] = [];
		level.destructible_type[var_02].var_E42[var_03][var_04].v["physics_velocity"] = [];
	}

	var_05 = level.destructible_type[var_02].var_E42[var_03][var_04].v["physics"].size;
	level.destructible_type[var_02].var_E42[var_03][var_04].v["physics"][var_05] = 1;
	level.destructible_type[var_02].var_E42[var_03][var_04].v["physics_tagName"][var_05] = param_00;
	level.destructible_type[var_02].var_E42[var_03][var_04].v["physics_velocity"][var_05] = param_01;
}

//Function Number: 22
destructible_splash_damage_scaler(param_00)
{
	var_01 = level.destructible_type.size - 1;
	var_02 = level.destructible_type[var_01].var_E42.size - 1;
	var_03 = level.destructible_type[var_01].var_E42[var_02].size - 1;
	level.destructible_type[var_01].var_E42[var_02][var_03].v["splash_damage_scaler"] = param_00;
}

//Function Number: 23
destructible_explode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = level.destructible_type.size - 1;
	var_0D = level.destructible_type[var_0C].var_E42.size - 1;
	var_0E = level.destructible_type[var_0C].var_E42[var_0D].size - 1;
	if(common_scripts\utility::issp())
	{
		level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_range"] = param_02;
	}
	else
	{
		level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_range"] = param_03;
	}

	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode"] = 1;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_force_min"] = param_00;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_force_max"] = param_01;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_mindamage"] = param_04;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["explode_maxdamage"] = param_05;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["continueDamage"] = param_06;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["originOffset"] = param_07;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["earthQuakeScale"] = param_08;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["earthQuakeRadius"] = param_09;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["originOffset3d"] = param_0A;
	level.destructible_type[var_0C].var_E42[var_0D][var_0E].v["delaytime"] = param_0B;
}

//Function Number: 24
destructible_info(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03))
	{
		param_03 = tolower(param_03);
	}

	var_0D = level.destructible_type.size - 1;
	level.destructible_type[var_0D].var_E42[param_00][param_01] = spawnstruct();
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["modelName"] = param_03;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["tagName"] = param_02;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["health"] = param_04;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["validAttackers"] = param_05;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["validDamageZone"] = param_06;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["validDamageCause"] = param_07;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["alsoDamageParent"] = param_08;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["physicsOnExplosion"] = param_09;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["grenadeImpactDeath"] = param_0A;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["godModeAllowed"] = 0;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["splashRotation"] = param_0B;
	level.destructible_type[var_0D].var_E42[param_00][param_01].v["receiveDamageFromParent"] = param_0C;
}

//Function Number: 25
precache_destructibles()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42))
	{
		return;
	}

	for(var_00 = 0;var_00 < level.destructible_type[self.destructibleinfo].var_E42.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.destructible_type[self.destructibleinfo].var_E42[var_00].size;var_01++)
		{
			if(level.destructible_type[self.destructibleinfo].var_E42[var_00].size <= var_01)
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["modelName"]))
			{
				precachemodel(level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["modelName"]);
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["animation"]))
			{
				var_02 = level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["animation"];
				foreach(var_04 in var_02)
				{
					if(isdefined(var_04["mpAnim"]))
					{
						common_scripts\utility::noself_func("precacheMpAnim",var_04["mpAnim"]);
					}
				}
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["random_dynamic_attachment_1"]))
			{
				foreach(var_07 in level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["random_dynamic_attachment_1"])
				{
					if(isdefined(var_07) && var_07 != "")
					{
						precachemodel(var_07);
						precachemodel(var_07 + "_destroy");
					}
				}

				foreach(var_07 in level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["random_dynamic_attachment_2"])
				{
					if(isdefined(var_07) && var_07 != "")
					{
						precachemodel(var_07);
						precachemodel(var_07 + "_destroy");
					}
				}
			}
		}
	}
}

//Function Number: 26
add_destructible_fx()
{
	if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42))
	{
		return;
	}

	for(var_00 = 0;var_00 < level.destructible_type[self.destructibleinfo].var_E42.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.destructible_type[self.destructibleinfo].var_E42[var_00].size;var_01++)
		{
			if(level.destructible_type[self.destructibleinfo].var_E42[var_00].size <= var_01)
			{
				continue;
			}

			var_02 = level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01];
			if(isdefined(var_02.v["fx_filename"]))
			{
				for(var_03 = 0;var_03 < var_02.v["fx_filename"].size;var_03++)
				{
					var_04 = var_02.v["fx_filename"][var_03];
					if(isdefined(var_04))
					{
						if(isdefined(var_02.v["fx"]) && isdefined(var_02.v["fx"][var_03]) && var_02.v["fx"][var_03].size == var_04.size)
						{
							continue;
						}

						foreach(var_07, var_06 in var_04)
						{
							level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["fx"][var_03][var_07] = common_scripts\utility::_loadfx(var_06);
						}
					}
				}
			}

			var_08 = level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["loopfx_filename"];
			if(isdefined(var_08))
			{
				if(isdefined(var_02.v["loopfx"]) && var_02.v["loopfx"].size == var_08.size)
				{
					continue;
				}

				foreach(var_07, var_0A in var_08)
				{
					level.destructible_type[self.destructibleinfo].var_E42[var_00][var_01].v["loopfx"][var_07] = common_scripts\utility::_loadfx(var_0A);
				}
			}
		}
	}
}

//Function Number: 27
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

//Function Number: 28
destructible_think()
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

		var_07 = getdamagetype(var_07);
		if(is_shotgun_damage(var_05,var_07))
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

			var_0A = level.destructible_type[self.destructibleinfo].var_E42[0][0].v["tagName"];
			if(isdefined(var_0A) && isdefined(var_08) && var_0A == var_08)
			{
				var_02 = undefined;
			}
		}

		if(var_07 == "splash")
		{
			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[0][0].v["splash_damage_scaler"]))
			{
				var_00 = var_00 * level.destructible_type[self.destructibleinfo].var_E42[0][0].v["splash_damage_scaler"];
			}
			else if(common_scripts\utility::issp())
			{
				var_00 = var_00 * 9;
			}
			else
			{
				var_00 = var_00 * 13;
			}

			destructible_splash_damage(int(var_00),var_03,var_04,var_05,var_07);
			continue;
		}

		thread destructible_update_part(int(var_00),var_01,var_02,var_03,var_04,var_05,var_07);
	}
}

//Function Number: 29
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
	else if(isdefined(level.var_E51) && level.var_E51)
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

//Function Number: 30
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

	for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].var_E42.size;var_05++)
	{
		var_04 = self.var_E43[var_05].v["currentState"];
		if(level.destructible_type[self.destructibleinfo].var_E42[var_05].size <= var_04)
		{
			continue;
		}

		if(!isdefined(param_01))
		{
			continue;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_05][var_04].v["tagName"]))
		{
			var_06 = level.destructible_type[self.destructibleinfo].var_E42[var_05][var_04].v["tagName"];
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

//Function Number: 31
destructible_update_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(self.var_E43))
	{
		return;
	}

	if(self.var_E43.size == 0)
	{
		return;
	}

	if(level.var_E3C)
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
	for(;;)
	{
		var_09 = self.var_E43[var_0A].v["currentState"];
		if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09]))
		{
			break;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][0].v["alsoDamageParent"]))
		{
			if(getdamagetype(param_06) != "splash")
			{
				var_0E = level.destructible_type[self.destructibleinfo].var_E42[var_0A][0].v["alsoDamageParent"];
				var_0F = int(param_00 * var_0E);
				thread notifydamageafterframe(var_0F,param_05,param_04,param_03,param_06,"","");
			}
		}

		if(getdamagetype(param_06) != "splash")
		{
			foreach(var_11 in level.destructible_type[self.destructibleinfo].var_E42)
			{
				if(!isdefined(var_11[0].v["receiveDamageFromParent"]))
				{
					continue;
				}

				if(!isdefined(var_11[0].v["tagName"]))
				{
					continue;
				}

				var_0E = var_11[0].v["receiveDamageFromParent"];
				var_12 = int(param_00 * var_0E);
				var_13 = var_11[0].v["tagName"];
				thread notifydamageafterframe(var_12,param_05,param_04,param_03,param_06,"",var_13);
			}
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09].v["health"]))
		{
			break;
		}

		if(!isdefined(self.var_E43[var_0A].v["health"]))
		{
			break;
		}

		if(var_0C)
		{
			self.var_E43[var_0A].v["health"] = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09].v["health"];
		}

		var_0C = 0;
		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09].v["grenadeImpactDeath"]) && param_06 == "impact")
		{
			param_00 = 100000000;
		}

		var_15 = self.var_E43[var_0A].v["health"];
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

				self.var_E43[var_0A].v["health"] = self.var_E43[var_0A].v["health"] - param_00;
			}
		}

		if(self.var_E43[var_0A].v["health"] > 0)
		{
			return;
		}

		if(isdefined(param_07))
		{
			param_07.v["fxcost"] = get_part_fx_cost_for_action_state(var_0A,self.var_E43[var_0A].v["currentState"]);
			add_destructible_to_frame_queue(self,param_07,param_00);
			if(!isdefined(self.var_E55))
			{
				self.var_E55 = 1;
			}
			else
			{
				self.var_E55++;
			}

			self waittill("queue_processed",var_18);
			self.var_E55--;
			if(self.var_E55 == 0)
			{
				self.var_E55 = undefined;
			}

			if(!var_18)
			{
				self.var_E43[var_0A].v["health"] = var_15;
				return;
			}
		}

		param_00 = int(abs(self.var_E43[var_0A].v["health"]));
		if(param_00 < 0)
		{
			return;
		}

		self.var_E43[var_0A].v["currentState"]++;
		var_09 = self.var_E43[var_0A].v["currentState"];
		var_19 = var_09 - 1;
		var_1A = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19]))
		{
			var_1A = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v;
		}

		var_1B = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09]))
		{
			var_1B = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09].v;
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19]))
		{
			return;
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode"]))
		{
			self.var_E56 = 1;
		}

		if(isdefined(self.var_E57) && isdefined(self.var_E57[tostring(var_0A)]))
		{
			for(var_1C = 0;var_1C < self.var_E57[tostring(var_0A)].size;var_1C++)
			{
				self notify(self.var_E57[tostring(var_0A)][var_1C]);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy notify(self.var_E57[tostring(var_0A)][var_1C]);
				}
			}

			self.var_E57[tostring(var_0A)] = undefined;
		}

		if(isdefined(var_1A["break_nearby_lights"]))
		{
			destructible_get_my_breakable_light(var_1A["break_nearby_lights"]);
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_09]))
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

		var_1E = get_dummy();
		if(isdefined(self.var_E56))
		{
			clear_anims(var_1E);
		}

		var_1F = destructible_animation_think(var_1A,var_1E,param_06,var_0A);
		var_1F = destructible_fx_think(var_1A,var_1E,param_06,var_0A,var_1F);
		var_1F = destructible_sound_think(var_1A,var_1E,param_06,var_1F);
		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopfx"]))
		{
			var_20 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopfx_filename"].size;
			if(var_20 > 0)
			{
				self notify("FX_State_Change" + var_0A);
			}

			for(var_21 = 0;var_21 < var_20;var_21++)
			{
				var_22 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopfx"][var_21];
				var_23 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopfx_tag"][var_21];
				var_24 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopfx_rate"][var_21];
				thread loopfx_ontag(var_22,var_23,var_24,var_0A);
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopsound"]))
		{
			for(var_1C = 0;var_1C < level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopsound"].size;var_1C++)
			{
				var_25 = isvalidsoundcause("loopsoundCause",var_1A,var_1C,param_06);
				if(var_25)
				{
					var_26 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["loopsound"][var_1C];
					var_27 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["tagName"];
					thread play_loop_sound_on_destructible(var_26,var_27);
					if(!isdefined(self.var_E57))
					{
						self.var_E57 = [];
					}

					if(!isdefined(self.var_E57[tostring(var_0A)]))
					{
						self.var_E57[tostring(var_0A)] = [];
					}

					var_28 = self.var_E57[tostring(var_0A)].size;
					self.var_E57[tostring(var_0A)][var_28] = "stop sound" + var_26;
				}
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["triggerCarAlarm"]))
		{
			thread do_car_alarm();
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["break_nearby_lights"]))
		{
			thread break_nearest_light();
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["healthdrain_amount"]))
		{
			self notify("Health_Drain_State_Change" + var_0A);
			var_29 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["healthdrain_amount"];
			var_2A = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["healthdrain_interval"];
			var_2B = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["modelName"];
			var_2C = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["tagName"];
			var_2D = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["badplace_radius"];
			var_2E = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["badplace_team"];
			if(var_29 > 0)
			{
				thread health_drain(var_29,var_2A,var_0A,var_2B,var_2C,var_2D,var_2E);
			}
		}

		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode"]))
		{
			var_0D = 1;
			var_2F = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode_force_min"];
			var_30 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode_force_max"];
			var_31 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode_range"];
			var_32 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode_mindamage"];
			var_33 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["explode_maxdamage"];
			var_34 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["continueDamage"];
			var_35 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["originOffset"];
			var_36 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["earthQuakeScale"];
			var_37 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["earthQuakeRadius"];
			var_38 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["originOffset3d"];
			var_39 = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["delaytime"];
			if(isdefined(param_05) && param_05 != self)
			{
				self.attacker = param_05;
				if(self.code_classname == "script_vehicle")
				{
					self.damage_type = param_06;
				}
			}

			thread explode(var_0A,var_2F,var_30,var_31,var_32,var_33,var_34,var_35,var_36,var_37,param_05,var_38,var_39);
		}

		var_3A = undefined;
		if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["physics"]))
		{
			for(var_1C = 0;var_1C < level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["physics"].size;var_1C++)
			{
				var_3A = undefined;
				var_3B = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["physics_tagName"][var_1C];
				var_3C = level.destructible_type[self.destructibleinfo].var_E42[var_0A][var_19].v["physics_velocity"][var_1C];
				var_3D = undefined;
				if(isdefined(var_3C))
				{
					var_3E = undefined;
					if(isdefined(var_3B))
					{
						var_3E = self gettagangles(var_3B);
					}
					else if(isdefined(param_02))
					{
						var_3E = self gettagangles(param_02);
					}

					var_3A = undefined;
					if(isdefined(var_3B))
					{
						var_3A = self gettagorigin(var_3B);
					}
					else if(isdefined(param_02))
					{
						var_3A = self gettagorigin(param_02);
					}

					var_3F = var_3C[0] - 5 + randomfloat(10);
					var_40 = var_3C[1] - 5 + randomfloat(10);
					var_41 = var_3C[2] - 5 + randomfloat(10);
					var_42 = anglestoforward(var_3E) * var_3F * randomfloatrange(80,110);
					var_43 = anglestoright(var_3E) * var_40 * randomfloatrange(80,110);
					var_44 = anglestoup(var_3E) * var_41 * randomfloatrange(80,110);
					var_3D = var_42 + var_43 + var_44;
				}
				else
				{
					var_3D = param_03;
					var_45 = (0,0,0);
					if(isdefined(param_05))
					{
						var_45 = param_05.origin;
						var_3D = vectornormalize(param_03 - var_45);
						var_3D = var_3D * 200;
					}
				}

				if(isdefined(var_3B))
				{
					var_46 = undefined;
					for(var_47 = 0;var_47 < level.destructible_type[self.destructibleinfo].var_E42.size;var_47++)
					{
						if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_47][0].v["tagName"]))
						{
							continue;
						}

						if(level.destructible_type[self.destructibleinfo].var_E42[var_47][0].v["tagName"] != var_3B)
						{
							continue;
						}

						var_46 = var_47;
						break;
					}

					if(isdefined(var_3A))
					{
						thread physics_launch(var_46,0,var_3A,var_3D);
					}
					else
					{
						thread physics_launch(var_46,0,param_03,var_3D);
					}

					continue;
				}

				if(isdefined(var_3A))
				{
					thread physics_launch(var_0A,var_19,var_3A,var_3D);
				}
				else
				{
					thread physics_launch(var_0A,var_19,param_03,var_3D);
				}

				return;
			}
		}

		var_0C = 1;
	}
}

//Function Number: 32
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

//Function Number: 33
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

//Function Number: 34
destructible_splash_damage(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= 0)
	{
		return;
	}

	if(isdefined(self.var_946))
	{
		return;
	}

	if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42))
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

		if(isdefined(self.var_946))
		{
			continue;
		}

		thread destructible_update_part(var_0A,var_08.v["modelName"],var_08.v["tagName"],param_01,param_02,param_03,param_04,var_08);
	}
}

//Function Number: 35
getallactiveparts(param_00)
{
	var_01 = [];
	if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42))
	{
		return var_01;
	}

	for(var_02 = 0;var_02 < level.destructible_type[self.destructibleinfo].var_E42.size;var_02++)
	{
		var_03 = var_02;
		var_04 = self.var_E43[var_03].v["currentState"];
		for(var_05 = 0;var_05 < level.destructible_type[self.destructibleinfo].var_E42[var_03].size;var_05++)
		{
			var_06 = level.destructible_type[self.destructibleinfo].var_E42[var_03][var_05].v["splashRotation"];
			if(isdefined(var_06) && var_06)
			{
				var_07 = vectortoangles(param_00);
				var_08 = var_07[1] - 90;
				level.destructible_type[self.destructibleinfo].var_E42[var_03][var_05].v["rotateTo"] = (0,var_08,0);
			}
		}

		if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_03][var_04]))
		{
			continue;
		}

		var_09 = level.destructible_type[self.destructibleinfo].var_E42[var_03][var_04].v["tagName"];
		if(!isdefined(var_09))
		{
			var_09 = "";
		}

		if(var_09 == "")
		{
			continue;
		}

		var_0A = level.destructible_type[self.destructibleinfo].var_E42[var_03][var_04].v["modelName"];
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

//Function Number: 36
setdistanceonparts(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = distance(param_01,self gettagorigin(param_00[var_02].v["tagName"]));
		param_00[var_02].v["distance"] = var_03;
	}

	return param_00;
}

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
isattackervalid(param_00,param_01,param_02)
{
	if(isdefined(self.var_E60))
	{
		return 1;
	}

	if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["explode"]))
	{
		if(isdefined(self.var_E61))
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

	var_03 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["validAttackers"];
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

		if(!isdefined(param_02.var_E62))
		{
			return 1;
		}

		if(param_02.var_E62 == 0)
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

		if(isdefined(param_02.var_E62) && param_02.var_E62)
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

//Function Number: 40
isvaliddamagecause(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["godModeAllowed"];
	if(var_03 && (isdefined(self.godmode) && self.godmode) || isdefined(self.script_bulletshield) && self.script_bulletshield && param_02 == "bullet")
	{
		return 0;
	}

	var_04 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["validDamageCause"];
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

//Function Number: 41
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

		case "splash":
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
			return "splash";

		case "mod_impact":
			return "impact";

		case "unknown":
			return "unknown";

		default:
			return "unknown";
	}
}

//Function Number: 42
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

//Function Number: 43
add_damage_owner_recorder()
{
	self.player_damage = 0;
	self.non_player_damage = 0;
	self.car_damage_owner_recorder = 1;
}

//Function Number: 44
loopfx_ontag(param_00,param_01,param_02,param_03)
{
	self endon("FX_State_Change" + param_03);
	self endon("delete_destructible");
	level endon("putout_fires");
	while(isdefined(self))
	{
		var_04 = get_dummy();
		playfxontag(param_00,var_04,param_01);
		wait param_02;
	}
}

//Function Number: 45
health_drain(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("Health_Drain_State_Change" + param_02);
	level endon("putout_fires");
	self endon("destroyed");
	if(isdefined(param_05) && isdefined(level.var_E6D))
	{
		param_05 = param_05 * level.var_E6D;
	}

	if(isdefined(param_00) && isdefined(level.var_E6E))
	{
		param_00 = param_00 * level.var_E6E;
	}

	wait param_01;
	self.healthdrain = 1;
	var_07 = undefined;
	if(isdefined(level.var_E70) && level.var_E70)
	{
		param_05 = undefined;
	}

	if(isdefined(param_05) && isdefined(param_06) && common_scripts\utility::issp())
	{
		var_07 = "" + gettime();
		if(!isdefined(self.var_E71))
		{
			if(isdefined(self.script_radius))
			{
				param_05 = self.script_radius;
			}

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
	}

	while(isdefined(self) && self.var_E43[param_02].v["health"] > 0)
	{
		self notify("damage",param_00,self,(0,0,0),(0,0,0),"MOD_UNKNOWN",param_03,param_04);
		wait param_01;
	}

	self notify("remove_badplace");
}

//Function Number: 46
badplace_remove(param_00)
{
	common_scripts\utility::waittill_any("destroyed","remove_badplace");
	[[ level.badplace_delete_func ]](param_00);
}

//Function Number: 47
physics_launch(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["modelName"];
	var_05 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v["tagName"];
	hideapart(var_05);
	if(level.var_E39.size >= level.var_E38)
	{
		physics_object_remove(level.var_E39[0]);
	}

	var_06 = spawn("script_model",self gettagorigin(var_05));
	var_06.angles = self gettagangles(var_05);
	var_06 setmodel(var_04);
	level.var_E39[level.var_E39.size] = var_06;
	var_06 physicslaunchclient(param_02,param_03);
}

//Function Number: 48
physics_object_remove(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_E39.size;var_02++)
	{
		if(level.var_E39[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.var_E39[var_02];
	}

	level.var_E39 = var_01;
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 49
explode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03) && isdefined(level.var_E78))
	{
		param_03 = param_03 * level.var_E78;
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
		if(isdefined(self.var_946))
		{
			return;
		}

		self.var_946 = 1;
	}

	if(!isdefined(param_0C))
	{
		param_0C = 0;
	}

	self notify("exploded",param_0A);
	level notify("destructible_exploded");
	if(self.code_classname == "script_vehicle")
	{
		self notify("death",param_0A,self.damage_type);
	}

	if(common_scripts\utility::issp())
	{
		thread disconnecttraverses();
	}

	if(!level.var_E3C)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_0D = self.var_E43[param_00].v["currentState"];
	var_0E = undefined;
	if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[param_00][var_0D]))
	{
		var_0E = level.destructible_type[self.destructibleinfo].var_E42[param_00][var_0D].v["tagName"];
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
	if(isdefined(level.destructible_type[self.destructibleinfo].var_E42))
	{
		for(var_10 = level.destructible_type[self.destructibleinfo].var_E42.size - 1;var_10 >= 0;var_10--)
		{
			if(var_10 == param_00)
			{
				continue;
			}

			var_11 = self.var_E43[var_10].v["currentState"];
			if(var_11 >= level.destructible_type[self.destructibleinfo].var_E42[var_10].size)
			{
				var_11 = level.destructible_type[self.destructibleinfo].var_E42[var_10].size - 1;
			}

			var_12 = level.destructible_type[self.destructibleinfo].var_E42[var_10][var_11].v["modelName"];
			var_0E = level.destructible_type[self.destructibleinfo].var_E42[var_10][var_11].v["tagName"];
			if(!isdefined(var_12))
			{
				continue;
			}

			if(!isdefined(var_0E))
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destructibleinfo].var_E42[var_10][0].v["physicsOnExplosion"]))
			{
				if(level.destructible_type[self.destructibleinfo].var_E42[var_10][0].v["physicsOnExplosion"] > 0)
				{
					var_13 = level.destructible_type[self.destructibleinfo].var_E42[var_10][0].v["physicsOnExplosion"];
					var_14 = self gettagorigin(var_0E);
					var_15 = vectornormalize(var_14 - var_0F);
					var_15 = var_15 * randomfloatrange(param_01,param_02) * var_13;
					thread physics_launch(var_10,var_11,var_14,var_15);
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

	if(!level.var_E3C)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_17 = var_0F + (0,0,param_07) + param_0B;
	var_18 = getsubstr(level.destructible_type[self.destructibleinfo].v["type"],0,7) == "vehicle";
	if(var_18)
	{
		anim.var_D20 = gettime();
		anim.var_D22 = var_17;
		anim.var_D23 = var_0F;
		anim.var_D21 = param_03;
	}

	level thread set_disable_friendlyfire_value_delayed(1);
	if(param_0C > 0)
	{
		wait param_0C;
	}

	if(isdefined(level.var_E79))
	{
		thread [[ level.var_E79 ]]();
	}

	if(common_scripts\utility::issp())
	{
		if(level.gameskill == 0 && !player_touching_post_clip())
		{
			self radiusdamage(var_17,param_03,param_05,param_04,self,"MOD_RIFLE_BULLET");
		}
		else
		{
			self radiusdamage(var_17,param_03,param_05,param_04,self);
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
			self radiusdamage(var_17,param_03,param_05,param_04,self,"MOD_EXPLOSIVE",var_19);
		}
		else
		{
			self radiusdamage(var_17,param_03,param_05,param_04,self.damageowner,"MOD_EXPLOSIVE",var_19);
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

	level thread set_disable_friendlyfire_value_delayed(0,0.05);
	var_1A = 0.01;
	var_1B = param_03 * var_1A;
	param_03 = param_03 * 0.99;
	physicsexplosionsphere(var_17,param_03,0,var_1B);
	if(var_16)
	{
		self setcandamage(0);
		thread cleanupvars();
	}

	self notify("destroyed");
}

//Function Number: 50
cleanupvars()
{
	wait 0.05;
	while(isdefined(self) && isdefined(self.var_E55))
	{
		self waittill("queue_processed");
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.var_E7B = undefined;
	self.attacker = undefined;
	self.car_damage_owner_recorder = undefined;
	self.var_E7C = undefined;
	self.damageowner = undefined;
	self.var_E43 = undefined;
	self.destructible_type = undefined;
	self.destructibleinfo = undefined;
	self.healthdrain = undefined;
	self.non_player_damage = undefined;
	self.player_damage = undefined;
	if(!isdefined(level.var_E7D))
	{
		return;
	}

	self.script_noflip = undefined;
	self.var_E56 = undefined;
	self.var_E57 = undefined;
	self.var_E7F = undefined;
}

//Function Number: 51
set_disable_friendlyfire_value_delayed(param_00,param_01)
{
	level notify("set_disable_friendlyfire_value_delayed");
	level endon("set_disable_friendlyfire_value_delayed");
	if(isdefined(param_01))
	{
		wait param_01;
	}

	level.friendlyfiredisabledfordestructible = param_00;
}

//Function Number: 52
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

//Function Number: 53
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

//Function Number: 54
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

		if(isdefined(var_02.var_E85))
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

//Function Number: 55
hideapart(param_00)
{
	self hidepart(param_00);
}

//Function Number: 56
showapart(param_00)
{
	self showpart(param_00);
}

//Function Number: 57
disable_explosion()
{
	self.var_E61 = 1;
}

//Function Number: 58
force_explosion()
{
	self.var_E61 = undefined;
	self.var_E60 = 1;
	self notify("damage",100000,self,self.origin,self.origin,"MOD_EXPLOSIVE","","");
}

//Function Number: 59
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

//Function Number: 60
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

//Function Number: 61
force_stop_sound(param_00)
{
	self endon("stop sound" + param_00);
	level waittill("putout_fires");
	self notify("stop sound" + param_00);
}

//Function Number: 62
notifydamageafterframe(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.notifydamageafterframe))
	{
		return;
	}

	level.notifydamageafterframe = 1;
	waittillframeend;
	if(isdefined(self.var_946))
	{
		level.notifydamageafterframe = undefined;
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
	level.notifydamageafterframe = undefined;
}

//Function Number: 63
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
	wait 5;
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 64
tostring(param_00)
{
	return "" + param_00;
}

//Function Number: 65
do_car_alarm()
{
	if(isdefined(self.var_E7C))
	{
		return;
	}

	self.var_E7C = 1;
	if(!should_do_car_alarm())
	{
		return;
	}

	self.var_E7F = spawn("script_model",self.origin);
	self.var_E7F hide();
	self.var_E7F playloopsound("car_alarm");
	level.var_E3A++;
	thread car_alarm_timeout();
	self waittill("stop_car_alarm");
	level.var_E91 = gettime();
	level.var_E3A--;
	self.var_E7F stoploopsound("car_alarm");
	self.var_E7F delete();
}

//Function Number: 66
car_alarm_timeout()
{
	self endon("stop_car_alarm");
	wait 25;
	if(!isdefined(self))
	{
		return;
	}

	thread play_sound("car_alarm_off");
	self notify("stop_car_alarm");
}

//Function Number: 67
should_do_car_alarm()
{
	if(level.var_E3A >= 2)
	{
		return 0;
	}

	var_00 = undefined;
	if(!isdefined(level.var_E91))
	{
		if(common_scripts\utility::cointoss())
		{
			return 1;
		}

		var_00 = gettime() - level.var_E3B;
	}
	else
	{
		var_00 = gettime() - level.var_E91;
	}

	if(level.var_E3A == 0 && var_00 >= 120)
	{
		return 1;
	}

	if(randomint(100) <= 33)
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
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
		var_7B[0].angles = self gettagangles(param_01);
		var_7B[0] setmodel(param_02);
		var_7B[0] linkto(self,param_01);
		if(isdefined(param_03) && param_03 != "")
		{
			var_7B[1].angles = self gettagangles(param_01);
			var_7B[1] setmodel(param_03);
			var_7B[1] linkto(self,param_01);
		}
	}

	if(isdefined(var_04))
	{
		var_05 = self gettagorigin(param_01);
		var_06 = get_closest_with_targetname(var_05,var_04);
		if(isdefined(var_06))
		{
			var_06 delete();
		}
	}

	self waittill(spawn("script_model",self gettagorigin(param_00)),var_7B[0],spawn("script_model",self gettagorigin(param_01)),var_7B[1],"exploded");
	if(common_scripts\utility::issp())
	{
		self detach(param_02,param_01);
		self attach(param_02 + "_destroy",param_01,0);
		if(isdefined(param_03) && param_03 != "")
		{
			self detach(param_03,param_01);
			self attach(param_03 + "_destroy",param_01,0);
			return;
		}

		return;
	}

	var_7B[0] setmodel(param_02 + "_destroy");
	if(isdefined(param_03) && param_03 != "")
	{
		var_7B[1] setmodel(param_03 + "_destroy");
	}
}

//Function Number: 69
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

//Function Number: 70
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
		if(isdefined(var_03.var_E85) && var_03.var_E85 == "post")
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

//Function Number: 71
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

//Function Number: 72
is_so()
{
	return getdvar("specialops") == "1";
}

//Function Number: 73
destructible_handles_collision_brushes()
{
	var_00 = getentarray(self.target,"targetname");
	var_01 = [];
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.var_E85))
		{
			continue;
		}

		self thread [[ var_7B[var_03.var_E85] ]](var_03);
	}
}

//Function Number: 74
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

//Function Number: 75
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

//Function Number: 76
debug_player_in_post_clip(param_00)
{
}

//Function Number: 77
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

	self.var_E9F = var_04;
}

//Function Number: 78
break_nearest_light(param_00)
{
	if(!isdefined(self.var_E9F))
	{
		return;
	}

	self.var_E9F setlightintensity(0);
}

//Function Number: 79
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

//Function Number: 80
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

//Function Number: 81
debug_line(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 82
spotlight_tag_origin_cleanup(param_00)
{
	param_00 endon("death");
	level waittill("new_destructible_spotlight");
	param_00 delete();
}

//Function Number: 83
spotlight_fizzles_out(param_00,param_01,param_02,param_03,param_04)
{
	level endon("new_destructible_spotlight");
	thread spotlight_tag_origin_cleanup(param_04);
	var_05 = param_00["spotlight_brightness"];
	common_scripts\utility::noself_func("setsaveddvar","r_spotlightbrightness",var_05);
	wait randomfloatrange(2,5);
	var_06 = randomintrange(5,11);
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		common_scripts\utility::noself_func("setsaveddvar","r_spotlightbrightness",var_05 * 0.65);
		wait 0.05;
		common_scripts\utility::noself_func("setsaveddvar","r_spotlightbrightness",var_05);
		wait 0.05;
	}

	destructible_fx_think(param_00,param_01,param_02,param_03);
	level.destructible_spotlight delete();
	param_04 delete();
}

//Function Number: 84
destructible_spotlight_think(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	if(!isdefined(self.var_E9F))
	{
		return;
	}

	param_01 common_scripts\utility::self_func("startignoringspotLight");
	foreach(var_06, var_05 in param_00["dvars"])
	{
		common_scripts\utility::noself_func("setsaveddvar",var_06,var_05);
	}

	if(!isdefined(level.destructible_spotlight))
	{
		level.destructible_spotlight = common_scripts\utility::spawn_tag_origin();
		var_07 = common_scripts\utility::getfx(param_00["spotlight_fx"]);
		playfxontag(var_07,level.destructible_spotlight,"tag_origin");
	}

	level notify("new_destructible_spotlight");
	level.destructible_spotlight unlink();
	var_08 = common_scripts\utility::spawn_tag_origin();
	var_08 linkto(self,param_00["spotlight_tag"],(0,0,0),(0,0,0));
	level.destructible_spotlight.origin = self.var_E9F.origin;
	level.destructible_spotlight.angles = self.var_E9F.angles;
	level.destructible_spotlight thread spotlight_fizzles_out(param_00,param_01,param_02,param_03,var_08);
	wait 0.05;
	if(isdefined(var_08))
	{
		level.destructible_spotlight linkto(var_08);
	}
}

//Function Number: 85
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

//Function Number: 86
destructible_sound_think(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_946))
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

//Function Number: 87
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

//Function Number: 88
destructible_animation_think(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_946))
	{
		return undefined;
	}

	if(!isdefined(param_00["animation"]))
	{
		return undefined;
	}

	if(isdefined(self.var_EAB))
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
		wait 0.05;
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
	if(!isdefined(self.var_E7B))
	{
		self.var_E7B = [];
	}

	self.var_E7B[self.var_E7B.size] = var_05;
	if(isdefined(self.var_E56))
	{
		clear_anims(param_01);
	}

	if(isdefined(var_09) && var_09 > 0)
	{
		wait randomfloat(var_09);
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

//Function Number: 89
clear_anims(param_00)
{
	if(isdefined(self.var_E7B))
	{
		foreach(var_02 in self.var_E7B)
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

//Function Number: 90
init_destroyed_count()
{
	level.var_EAE = 0;
	level.var_EAF = 0.5;
	if(common_scripts\utility::issp())
	{
		level.var_EB0 = 20;
		return;
	}

	level.var_EB0 = 2;
}

//Function Number: 91
add_to_destroyed_count()
{
	level.var_EAE++;
	wait level.var_EAF;
	level.var_EAE--;
}

//Function Number: 92
get_destroyed_count()
{
	return level.var_EAE;
}

//Function Number: 93
get_max_destroyed_count()
{
	return level.var_EB0;
}

//Function Number: 94
init_destructible_frame_queue()
{
	level.var_EB5 = [];
}

//Function Number: 95
add_destructible_to_frame_queue(param_00,param_01,param_02)
{
	var_03 = self getentitynumber();
	if(!isdefined(level.var_EB5[var_03]))
	{
		level.var_EB5[var_03] = spawnstruct();
		level.var_EB5[var_03].entnum = var_03;
		level.var_EB5[var_03].destructible = param_00;
		level.var_EB5[var_03].var_EB9 = 0;
		level.var_EB5[var_03].var_EBA = 9999999;
		level.var_EB5[var_03].var_EBB = 0;
	}

	level.var_EB5[var_03].var_EBB = level.var_EB5[var_03].var_EBB + param_01.v["fxcost"];
	level.var_EB5[var_03].var_EB9 = level.var_EB5[var_03].var_EB9 + param_02;
	if(param_01.v["distance"] < level.var_EB5[var_03].var_EBA)
	{
		level.var_EB5[var_03].var_EBA = param_01.v["distance"];
	}

	thread handle_destructible_frame_queue();
}

//Function Number: 96
handle_destructible_frame_queue()
{
	level notify("handle_destructible_frame_queue");
	level endon("handle_destructible_frame_queue");
	wait 0.05;
	var_00 = level.var_EB5;
	level.var_EB5 = [];
	var_01 = sort_destructible_frame_queue(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(get_destroyed_count() < get_max_destroyed_count())
		{
			if(var_01[var_02].var_EBB)
			{
				thread add_to_destroyed_count();
			}

			var_01[var_02].destructible notify("queue_processed",1);
			continue;
		}

		var_01[var_02].destructible notify("queue_processed",0);
	}
}

//Function Number: 97
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

//Function Number: 98
get_better_destructible(param_00,param_01)
{
	if(param_00.var_EB9 > param_01.var_EB9)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 99
get_part_fx_cost_for_action_state(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01]))
	{
		return var_02;
	}

	var_03 = level.destructible_type[self.destructibleinfo].var_E42[param_00][param_01].v;
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
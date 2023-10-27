/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 855 ms
 * Timestamp: 10/27/2023 2:38:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.destructiblespawnedentslimit = 50;
	level.destructiblespawnedents = [];
	find_destructibles();
}

//Function Number: 2
destructible_create(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.destructible_type))
	{
		level.destructible_type = [];
	}

	var_05 = level.destructible_type.size;
	var_05 = level.destructible_type.size;
	level.destructible_type[var_05] = spawnstruct();
	level.destructible_type[var_05].v["type"] = param_00;
	level.destructible_type[var_05].parts = [];
	level.destructible_type[var_05].parts[0][0] = spawnstruct();
	level.destructible_type[var_05].parts[0][0].v["modelName"] = self.model;
	level.destructible_type[var_05].parts[0][0].v["health"] = param_01;
	level.destructible_type[var_05].parts[0][0].v["validAttackers"] = param_02;
	level.destructible_type[var_05].parts[0][0].v["validDamageZone"] = param_03;
	level.destructible_type[var_05].parts[0][0].v["validDamageCause"] = param_04;
	level.destructible_type[var_05].parts[0][0].v["godModeAllowed"] = 1;
}

//Function Number: 3
destructible_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.destructible_type.size - 1;
	var_0B = level.destructible_type[var_0A].parts.size;
	var_0C = 0;
	destructible_info(var_0B,var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 4
destructible_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = level.destructible_type.size - 1;
	var_08 = level.destructible_type[var_07].parts.size - 1;
	var_09 = level.destructible_type[var_07].parts[var_08].size;
	destructible_info(var_08,var_09,param_00,param_01,param_02,param_03,param_04,param_05,undefined,undefined,param_06);
}

//Function Number: 5
destructible_fx(param_00,param_01,param_02)
{
	param_01 = try_override_destructible_fx(param_01);
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	level.destructible_type[var_03].parts[var_04][var_05].v["fx_filename"] = param_01;
	level.destructible_type[var_03].parts[var_04][var_05].v["fx_tag"] = param_00;
	level.destructible_type[var_03].parts[var_04][var_05].v["fx_useTagAngles"] = param_02;
}

//Function Number: 6
destructible_loopfx(param_00,param_01,param_02)
{
	param_01 = try_override_destructible_fx(param_01);
	var_03 = level.destructible_type.size - 1;
	var_04 = level.destructible_type[var_03].parts.size - 1;
	var_05 = level.destructible_type[var_03].parts[var_04].size - 1;
	level.destructible_type[var_03].parts[var_04][var_05].v["loopfx_filename"] = param_01;
	level.destructible_type[var_03].parts[var_04][var_05].v["loopfx_tag"] = param_00;
	level.destructible_type[var_03].parts[var_04][var_05].v["loopfx_rate"] = param_02;
}

//Function Number: 7
try_override_destructible_fx(param_00)
{
	if(!isdefined(level.destructible_effect_override))
	{
		return param_00;
	}

	var_01 = getarraykeys(level.destructible_effect_override);
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return level.destructible_effect_override[var_03];
		}
	}

	return param_00;
}

//Function Number: 8
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

//Function Number: 9
destructible_sound(param_00,param_01)
{
	var_02 = level.destructible_type.size - 1;
	var_03 = level.destructible_type[var_02].parts.size - 1;
	var_04 = level.destructible_type[var_02].parts[var_03].size - 1;
	if(!isdefined(level.destructible_type[var_02].parts[var_03][var_04].v["sound"]))
	{
		level.destructible_type[var_02].parts[var_03][var_04].v["sound"] = [];
		level.destructible_type[var_02].parts[var_03][var_04].v["soundCause"] = [];
	}

	var_05 = level.destructible_type[var_02].parts[var_03][var_04].v["sound"].size;
	level.destructible_type[var_02].parts[var_03][var_04].v["sound"][var_05] = param_00;
	level.destructible_type[var_02].parts[var_03][var_04].v["soundCause"][var_05] = param_01;
}

//Function Number: 10
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

//Function Number: 11
destructible_anim(param_00,param_01,param_02,param_03)
{
	var_04 = level.destructible_type.size - 1;
	var_05 = level.destructible_type[var_04].parts.size - 1;
	var_06 = level.destructible_type[var_04].parts[var_05].size - 1;
	if(!isdefined(param_03))
	{
		level.destructible_type[var_04].parts[var_05][var_06].v["anim"] = param_00;
		level.destructible_type[var_04].parts[var_05][var_06].v["animTree"] = param_01;
		level.destructible_type[var_04].parts[var_05][var_06].v["animType"] = param_02;
		return;
	}

	level.destructible_type[var_04].parts[var_05][var_06].v["partAnim"] = param_00;
	level.destructible_type[var_04].parts[var_05][var_06].v["partAnimTree"] = param_01;
	level.destructible_type[var_04].parts[var_05][var_06].v["partAnimType"] = param_02;
}

//Function Number: 12
destructible_physics()
{
	var_00 = level.destructible_type.size - 1;
	var_01 = level.destructible_type[var_00].parts.size - 1;
	var_02 = level.destructible_type[var_00].parts[var_01].size - 1;
	level.destructible_type[var_00].parts[var_01][var_02].v["physics"] = 1;
}

//Function Number: 13
destructible_explode(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.destructible_type.size - 1;
	var_06 = level.destructible_type[var_05].parts.size - 1;
	var_07 = level.destructible_type[var_05].parts[var_06].size - 1;
	level.destructible_type[var_05].parts[var_06][var_07].v["explode_force_min"] = param_00;
	level.destructible_type[var_05].parts[var_06][var_07].v["explode_force_max"] = param_01;
	level.destructible_type[var_05].parts[var_06][var_07].v["explode_range"] = param_02;
	level.destructible_type[var_05].parts[var_06][var_07].v["explode_mindamage"] = param_03;
	level.destructible_type[var_05].parts[var_06][var_07].v["explode_maxdamage"] = param_04;
}

//Function Number: 14
destructible_info(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = level.destructible_type.size - 1;
	level.destructible_type[var_0C].parts[param_00][param_01] = spawnstruct();
	level.destructible_type[var_0C].parts[param_00][param_01].v["modelName"] = param_03;
	level.destructible_type[var_0C].parts[param_00][param_01].v["tagName"] = param_02;
	level.destructible_type[var_0C].parts[param_00][param_01].v["health"] = param_04;
	level.destructible_type[var_0C].parts[param_00][param_01].v["validAttackers"] = param_05;
	level.destructible_type[var_0C].parts[param_00][param_01].v["validDamageZone"] = param_06;
	level.destructible_type[var_0C].parts[param_00][param_01].v["validDamageCause"] = param_07;
	level.destructible_type[var_0C].parts[param_00][param_01].v["alsoDamageParent"] = param_08;
	level.destructible_type[var_0C].parts[param_00][param_01].v["physicsOnExplosion"] = param_09;
	level.destructible_type[var_0C].parts[param_00][param_01].v["grenadeImpactDeath"] = param_0A;
	level.destructible_type[var_0C].parts[param_00][param_01].v["godModeAllowed"] = 0;
	if(!isdefined(param_0B))
	{
		level.destructible_type[var_0C].parts[param_00][param_01].v["createEntityForAnimation"] = 0;
		return;
	}

	level.destructible_type[var_0C].parts[param_00][param_01].v["createEntityForAnimation"] = param_0B;
}

//Function Number: 15
find_destructibles()
{
	common_scripts\utility::array_thread(getentarray("destructible","targetname"),::setup_destructibles);
}

//Function Number: 16
precache_destructibles()
{
	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		for(var_00 = 0;var_00 < level.destructible_type[self.destuctableinfo].parts.size;var_00++)
		{
			for(var_01 = 0;var_01 < level.destructible_type[self.destuctableinfo].parts[var_00].size;var_01++)
			{
				if(level.destructible_type[self.destuctableinfo].parts[var_00].size <= var_01)
				{
					continue;
				}

				if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["modelName"]))
				{
					precachemodel(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["modelName"]);
				}

				if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["fx_filename"]))
				{
					level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["fx"] = loadfx(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["fx_filename"]);
				}

				if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["loopfx_filename"]))
				{
					level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["loopfx"] = loadfx(level.destructible_type[self.destuctableinfo].parts[var_00][var_01].v["loopfx_filename"]);
				}
			}
		}
	}
}

//Function Number: 17
setup_destructibles(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = undefined;
	self.modeldummyon = 0;
	add_damage_owner_recorder();
	self.destuctableinfo = common_scripts\_destructible_types::maketype(self.destructible_type);
	if(!param_00)
	{
		precache_destructibles();
	}

	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		self.destructible_parts = [];
		for(var_02 = 0;var_02 < level.destructible_type[self.destuctableinfo].parts.size;var_02++)
		{
			self.destructible_parts[var_02] = spawnstruct();
			self.destructible_parts[var_02].v["currentState"] = 0;
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_02][0].v["health"]))
			{
				self.destructible_parts[var_02].v["health"] = level.destructible_type[self.destuctableinfo].parts[var_02][0].v["health"];
			}

			if(var_02 == 0)
			{
				continue;
			}

			var_03 = level.destructible_type[self.destuctableinfo].parts[var_02][0].v["modelName"];
			var_04 = level.destructible_type[self.destuctableinfo].parts[var_02][0].v["tagName"];
			self attach(var_03,var_04);
			if(self.modeldummyon)
			{
				self.modeldummy attach(var_03,var_04);
			}
		}
	}

	if(self.classname != "script_vehicle")
	{
		self setcandamage(1);
	}

	thread setup_destructible_entities();
	thread connecttraverses();
	thread destructible_think();
}

//Function Number: 18
add_damage_owner_recorder()
{
	self.player_damage = 0;
	self.non_player_damage = 0;
	self.car_damage_owner_recorder = 1;
}

//Function Number: 19
destructible_think()
{
	self endon("stop_taking_damage");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 <= 0)
		{
			continue;
		}

		var_04 = getdamagetype(var_04);
		if(var_05 == "")
		{
			var_05 = self.model;
		}

		if(isdefined(var_06) && var_06 == "")
		{
			var_06 = undefined;
		}

		if(var_04 == "splash")
		{
			destructible_splash_damage(int(var_00),var_03,var_02,var_01,var_04);
			continue;
		}

		thread destructible_update_part(int(var_00),var_05,var_06,var_03,var_02,var_01,var_04);
	}
}

//Function Number: 20
destructible_update_part(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self.destructible_parts))
	{
		return;
	}

	if(self.destructible_parts.size == 0)
	{
		return;
	}

	var_07 = -1;
	var_08 = -1;
	if(tolower(param_01) == tolower(self.model) && !isdefined(param_02))
	{
		param_01 = self.model;
		param_02 = undefined;
		var_07 = 0;
		var_08 = 0;
	}

	for(var_09 = 0;var_09 < level.destructible_type[self.destuctableinfo].parts.size;var_09++)
	{
		var_08 = self.destructible_parts[var_09].v["currentState"];
		if(level.destructible_type[self.destuctableinfo].parts[var_09].size <= var_08)
		{
			continue;
		}

		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_09][var_08].v["modelName"]))
		{
			continue;
		}

		if(tolower(level.destructible_type[self.destuctableinfo].parts[var_09][var_08].v["modelName"]) == tolower(param_01))
		{
			if(level.destructible_type[self.destuctableinfo].parts[var_09][var_08].v["tagName"] == param_02)
			{
				var_07 = var_09;
				break;
			}
		}
	}

	if(var_07 < 0)
	{
		return;
	}

	var_0A = var_08;
	var_0B = 0;
	var_0C = 0;
	for(;;)
	{
		var_08 = self.destructible_parts[var_07].v["currentState"];
		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_08]))
		{
			break;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][0].v["alsoDamageParent"]))
		{
			if(getdamagetype(param_06) != "splash")
			{
				var_0D = level.destructible_type[self.destuctableinfo].parts[var_07][0].v["alsoDamageParent"];
				var_0E = int(param_00 * var_0D);
				thread notifydamageafterframe(var_0E,param_05,param_04,param_03,param_06,"","");
			}
		}

		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["health"]))
		{
			break;
		}

		if(!isdefined(self.destructible_parts[var_07].v["health"]))
		{
			break;
		}

		if(var_0B)
		{
			self.destructible_parts[var_07].v["health"] = level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["health"];
		}

		var_0B = 0;
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["grenadeImpactDeath"]) && param_06 == "impact")
		{
			param_00 = 100000000;
		}

		var_0F = isattackervalid(var_07,var_08,param_05);
		if(var_0F)
		{
			var_10 = isvaliddamagecause(var_07,var_08,param_06);
			if(var_10)
			{
				if(param_05 == level.player)
				{
					self.player_damage = self.player_damage + param_00;
				}
				else if(param_05 != self)
				{
					self.non_player_damage = self.non_player_damage + param_00;
				}

				self.destructible_parts[var_07].v["health"] = self.destructible_parts[var_07].v["health"] - param_00;
			}
		}

		if(self.destructible_parts[var_07].v["health"] > 0)
		{
			return;
		}

		param_00 = int(abs(self.destructible_parts[var_07].v["health"]));
		if(param_00 < 0)
		{
			return;
		}

		self.destructible_parts[var_07].v["currentState"]++;
		var_08 = self.destructible_parts[var_07].v["currentState"];
		var_11 = var_08 - 1;
		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11]))
		{
			return;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_force_min"]))
		{
			self.exploding = 1;
		}

		if(isdefined(self.loopingsoundstopnotifies) && isdefined(self.loopingsoundstopnotifies[maps\_utility::string(var_07)]))
		{
			for(var_09 = 0;var_09 < self.loopingsoundstopnotifies[maps\_utility::string(var_07)].size;var_09++)
			{
				self notify(self.loopingsoundstopnotifies[maps\_utility::string(var_07)][var_09]);
				if(self.modeldummyon)
				{
					self.modeldummy notify(self.loopingsoundstopnotifies[maps\_utility::string(var_07)][var_09]);
				}
			}

			self.loopingsoundstopnotifies[maps\_utility::string(var_07)] = undefined;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_08]))
		{
			if(var_07 == 0)
			{
				var_12 = level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["modelName"];
				self setmodel(var_12);
				if(self.modeldummyon)
				{
					self.modeldummy setmodel(var_12);
				}
			}
			else
			{
				self detach(param_01,param_02);
				if(self.modeldummyon)
				{
					self.modeldummy detach(param_01,param_02);
				}

				param_01 = level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["modelName"];
				param_02 = level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["tagName"];
				if(isdefined(param_01) && isdefined(param_02))
				{
					if(self.modeldummyon)
					{
						self.modeldummy attach(param_01,param_02);
					}

					self attach(param_01,param_02);
				}
			}
		}

		var_13 = get_dummy();
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["fx"]))
		{
			var_14 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["fx"];
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["fx_tag"]))
			{
				var_15 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["fx_tag"];
				self notify("FX_State_Change" + var_07);
				if(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["fx_useTagAngles"])
				{
					if(delayvfxonmultipleframes(var_13))
					{
						if(!isdefined(self.playingfxpartscount))
						{
							self.playingfxpartscount = 0;
						}

						if(self.playingfxpartscount < 3)
						{
							destructible_playfxontag_internal(var_14,var_13,var_15);
						}
						else
						{
							while(self.playingfxpartscount >= 3)
							{
								wait(0.05);
							}

							destructible_playfxontag_internal(var_14,var_13,var_15);
						}
					}
					else
					{
						playfxontag(var_14,var_13,var_15);
					}
				}
				else
				{
					var_16 = var_13 gettagorigin(var_15);
					var_17 = var_16 + (0,0,100) - var_16;
					playfx(var_14,var_16,var_17);
				}
			}
			else
			{
				var_16 = var_13.origin;
				var_17 = var_16 + (0,0,100) - var_16;
				playfx(var_14,var_16,var_17);
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopfx"]))
		{
			var_18 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopfx"];
			var_19 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopfx_tag"];
			var_1A = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopfx_rate"];
			self notify("FX_State_Change" + var_07);
			thread loopfx_ontag(var_18,var_19,var_1A,var_07);
		}

		if(!isdefined(self.exploded))
		{
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["anim"]))
			{
				var_1B = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["anim"];
				var_1C = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["animTree"];
				var_13 useanimtree(var_1C);
				var_1D = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["animType"];
				if(!isdefined(self.animsapplied))
				{
					self.animsapplied = [];
				}

				self.animsapplied[self.animsapplied.size] = var_1B;
				if(isdefined(self.exploding))
				{
					if(isdefined(self.animsapplied))
					{
						for(var_09 = 0;var_09 < self.animsapplied.size;var_09++)
						{
							var_13 clearanim(self.animsapplied[var_09],0);
						}
					}
				}

				if(var_1D == "setanim")
				{
					var_13 setanim(var_1B,1,1,1);
				}
				else if(var_1D == "setanimknob")
				{
					var_13 setanimknob(var_1B,1,1,1);
				}
				else
				{
				}
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["createEntityForAnimation"]) && level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["createEntityForAnimation"] && !isdefined(self.exploded))
		{
			var_1E = createentity(var_07,var_11,self.destuctableinfo);
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["partAnim"]))
			{
				var_1B = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["partAnim"];
				var_1C = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["partAnimTree"];
				var_1E useanimtree(var_1C);
				var_1D = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["partAnimType"];
				if(!isdefined(self.animsapplied))
				{
					self.animsapplied = [];
				}

				self.animsapplied[self.animsapplied.size] = var_1B;
				if(isdefined(self.exploding) && isdefined(self.animsapplied))
				{
					for(var_09 = 0;var_09 < self.animsapplied.size;var_09++)
					{
						var_1E clearanim(self.animsapplied[var_09],0);
					}
				}

				if(var_1D == "setanim")
				{
					var_1E setanim(var_1B,1,1,1);
				}
				else if(var_1D == "setanimknob")
				{
					var_1E setanimknob(var_1B,1,1,1);
				}
				else
				{
				}
			}
		}

		if(!isdefined(self.exploded))
		{
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["sound"]))
			{
				for(var_09 = 0;var_09 < level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["sound"].size;var_09++)
				{
					var_1F = isvalidsoundcause("soundCause",var_07,var_11,var_09,param_06);
					if(var_1F)
					{
						var_20 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["sound"][var_09];
						var_21 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["tagName"];
						var_13 thread maps\_utility::play_sound_on_tag(var_20,var_21);
					}
				}
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopsound"]))
		{
			for(var_09 = 0;var_09 < level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopsound"].size;var_09++)
			{
				var_1F = isvalidsoundcause("loopsoundCause",var_07,var_11,var_09,param_06);
				if(var_1F)
				{
					var_22 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["loopsound"][var_09];
					var_23 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["tagName"];
					thread play_loop_sound_on_destructible(var_22,var_23);
					if(!isdefined(self.loopingsoundstopnotifies))
					{
						self.loopingsoundstopnotifies = [];
					}

					if(!isdefined(self.loopingsoundstopnotifies[maps\_utility::string(var_07)]))
					{
						self.loopingsoundstopnotifies[maps\_utility::string(var_07)] = [];
					}

					var_24 = self.loopingsoundstopnotifies[maps\_utility::string(var_07)].size;
					self.loopingsoundstopnotifies[maps\_utility::string(var_07)][var_24] = "stop sound" + var_22;
				}
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["healthdrain_amount"]))
		{
			self notify("Health_Drain_State_Change" + var_07);
			var_25 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["healthdrain_amount"];
			var_26 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["healthdrain_interval"];
			var_27 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["modelName"];
			var_28 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["tagName"];
			var_29 = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["badplace_radius"];
			var_2A = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["badplace_team"];
			if(var_25 > 0)
			{
				thread health_drain(var_25,var_26,var_07,var_27,var_28,var_29,var_2A);
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_force_min"]))
		{
			var_0C = 1;
			var_2B = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_force_min"];
			var_2C = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_force_max"];
			var_2D = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_range"];
			var_2E = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_mindamage"];
			var_2F = level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["explode_maxdamage"];
			if(isdefined(param_05) && param_05 != self)
			{
				self.attacker = param_05;
			}

			thread explode(var_07,var_2B,var_2C,var_2D,var_2E,var_2F);
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_11].v["physics"]))
		{
			var_30 = param_03;
			var_31 = (0,0,0);
			if(isdefined(param_05))
			{
				var_31 = param_05.origin;
				if(param_05 == level.player)
				{
					var_31 = level.player geteye();
				}

				var_30 = vectornormalize(param_03 - var_31);
				var_30 = maps\_utility::vector_multiply(var_30,200);
			}

			thread physics_launch(var_07,var_11,param_03,var_30);
			return;
		}

		var_0F = 1;
	}
}

//Function Number: 21
delayvfxonmultipleframes(param_00)
{
	return param_00.model == "vehicle_uaz_hardtop_dsr" && level.script == "icbm";
}

//Function Number: 22
reduceplayingcount(param_00)
{
	wait(param_00);
	self.playingfxpartscount--;
}

//Function Number: 23
destructible_playfxontag_internal(param_00,param_01,param_02)
{
	self.playingfxpartscount++;
	playfxontag(param_00,param_01,param_02);
	thread reduceplayingcount(0.05);
}

//Function Number: 24
destructible_splash_damage(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= 0)
	{
		return;
	}

	var_05 = [];
	var_06 = undefined;
	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		for(var_07 = 0;var_07 < level.destructible_type[self.destuctableinfo].parts.size;var_07++)
		{
			for(var_08 = 0;var_08 < level.destructible_type[self.destuctableinfo].parts[var_07].size;var_08++)
			{
				if(level.destructible_type[self.destuctableinfo].parts[var_07].size <= var_08)
				{
					continue;
				}

				if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["modelName"]))
				{
					var_09 = level.destructible_type[self.destuctableinfo].parts[var_07][var_08].v["modelName"];
					if(var_07 == 0)
					{
						var_0A = distance(param_01,self.origin);
						var_0B = undefined;
					}
					else
					{
						var_0B = level.destructible_type[self.destuctableinfo].parts[var_09][var_0A].v["tagName"];
						var_0A = distance(param_01,self gettagorigin(var_0B));
					}

					if(!isdefined(var_06) || var_0A < var_06)
					{
						var_06 = var_0A;
					}

					var_0C = var_05.size;
					var_05[var_0C] = spawnstruct();
					var_05[var_0C].v["modelName"] = var_09;
					var_05[var_0C].v["tagName"] = var_0B;
					var_05[var_0C].v["distance"] = var_0A;
				}
			}
		}
	}

	if(!isdefined(var_06))
	{
		return;
	}

	if(var_06 < 0)
	{
		return;
	}

	if(var_05.size <= 0)
	{
		return;
	}

	for(var_07 = 0;var_07 < var_05.size;var_07++)
	{
		var_0D = var_05[var_07].v["distance"] * 1.4;
		var_0E = param_00 - var_0D - var_06;
		if(var_0E <= 0)
		{
			continue;
		}

		thread destructible_update_part(var_0E,var_05[var_07].v["modelName"],var_05[var_07].v["tagName"],param_01,param_02,param_03,param_04);
	}
}

//Function Number: 25
isvalidsoundcause(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.destructible_type[self.destuctableinfo].parts[param_01][param_02].v[param_00][param_03];
	if(!isdefined(var_05))
	{
		return 1;
	}

	if(var_05 == param_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
isattackervalid(param_00,param_01,param_02)
{
	if(isdefined(self.forceexploding))
	{
		return 1;
	}

	if(isdefined(level.destructible_type[self.destuctableinfo].parts[param_00][param_01].v["explode_force_min"]))
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

	var_03 = level.destructible_type[self.destuctableinfo].parts[param_00][param_01].v["validAttackers"];
	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 == "no_player")
	{
		if(param_02 != level.player)
		{
			return 1;
		}
	}
	else if(var_03 == "player_only")
	{
		if(param_02 == level.player)
		{
			return 1;
		}
	}
	else if(var_03 == "no_ai")
	{
		if(!isai(param_02))
		{
			return 1;
		}
	}
	else if(var_03 == "ai_only")
	{
		if(isai(param_02))
		{
			return 1;
		}
	}
	else
	{
	}

	return 0;
}

//Function Number: 27
isvaliddamagecause(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = level.destructible_type[self.destuctableinfo].parts[param_00][param_01].v["godModeAllowed"];
	if(var_03 && (isdefined(self.godmode) && self.godmode) || isdefined(self.script_bulletshield) && self.script_bulletshield && param_02 == "bullet")
	{
		return 0;
	}

	var_04 = level.destructible_type[self.destuctableinfo].parts[param_00][param_01].v["validDamageCause"];
	if(!isdefined(var_04))
	{
		return 1;
	}

	if(var_04 == "no_melee" && param_02 == "melee")
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
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

		case "unknown":
			break;

		default:
			break;
	}
}

//Function Number: 29
loopfx_ontag(param_00,param_01,param_02,param_03)
{
	var_04 = get_dummy();
	self endon("FX_State_Change" + param_03);
	self endon("delete_destructible");
	level endon("putout_fires");
	for(;;)
	{
		var_04 = get_dummy();
		playfxontag(param_00,var_04,param_01);
		wait(param_02);
	}
}

//Function Number: 30
health_drain(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("Health_Drain_State_Change" + param_02);
	level endon("putout_fires");
	wait(param_01);
	self.healthdrain = 1;
	var_07 = undefined;
	if(isdefined(param_05) && isdefined(param_06))
	{
		var_07 = "" + gettime();
		if(!isdefined(self.disablebadplace))
		{
			if(param_06 == "both")
			{
				badplace_cylinder(var_07,0,self.origin,param_05,128,"allies","axis");
			}
			else
			{
				badplace_cylinder(var_07,0,self.origin,param_05,128,param_06);
			}
		}
	}

	while(self.destructible_parts[param_02].v["health"] > 0)
	{
		self notify("damage",param_00,self,(0,0,0),(0,0,0),"MOD_UNKNOWN",param_03,param_04);
		wait(param_01);
	}

	if(isdefined(param_05) && isdefined(param_06))
	{
		badplace_delete(var_07);
	}
}

//Function Number: 31
physics_launch(param_00,param_01,param_02,param_03)
{
	var_04 = get_model_from_part(param_00,param_01);
	var_05 = get_last_model_from_part(param_00);
	var_06 = get_tag_from_part(param_00,param_01);
	if(!ismodelattached(var_04,var_06))
	{
		return;
	}

	self detach(var_04,var_06);
	if(self.modeldummyon)
	{
		self.modeldummy detach(var_04,var_06);
	}

	if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit)
	{
		physics_object_remove(level.destructiblespawnedents[0]);
	}

	var_07 = spawn("script_model",self gettagorigin(var_06));
	var_07.angles = self gettagangles(var_06);
	var_07 setmodel(var_05);
	level.destructiblespawnedents[level.destructiblespawnedents.size] = var_07;
	var_07 physicslaunchclient(param_02,param_03);
}

//Function Number: 32
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
	param_00 delete();
}

//Function Number: 33
createentity(param_00,param_01,param_02)
{
	var_03 = get_model_from_part(param_00,param_01);
	var_04 = get_last_model_from_part(param_00);
	var_05 = get_tag_from_part(param_00,param_01);
	if(!ismodelattached(var_03,var_05))
	{
		return;
	}

	self detach(var_03,var_05);
	if(self.modeldummyon)
	{
		self.modeldummy detach(var_03,var_05);
	}

	var_06 = spawn("script_model",self gettagorigin(var_05));
	var_06.angles = self gettagangles(var_05);
	var_06 setmodel(var_04);
	var_06 linkto(self);
	if(!isdefined(self.partsspawnedents))
	{
		self.partsspawnedents = [];
	}

	self.partsspawnedents[self.partsspawnedents.size] = var_06;
	return var_06;
}

//Function Number: 34
explode(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(self.exploded))
	{
		return;
	}

	self.exploded = 1;
	if(self.classname == "script_vehicle" || self.code_classname == "script_vehicle")
	{
		self notify("death");
	}

	thread disconnecttraverses();
	thread destroy_destructible_entities();
	wait(0.05);
	var_06 = level.destructible_type[self.destuctableinfo].parts[param_00][self.destructible_parts[param_00].v["currentState"]].v["tagName"];
	if(isdefined(var_06))
	{
		var_07 = self gettagorigin(var_06);
	}
	else
	{
		var_07 = self.origin;
	}

	self notify("damage",param_05,self,(0,0,0),var_07,"MOD_EXPLOSIVE","","");
	waittillframeend;
	if(isdefined(self.partsspawnedents))
	{
		foreach(var_09 in self.partsspawnedents)
		{
			var_09 delete();
		}
	}

	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		for(var_0B = level.destructible_type[self.destuctableinfo].parts.size - 1;var_0B >= 0;var_0B--)
		{
			if(var_0B == param_00)
			{
				continue;
			}

			var_0C = self.destructible_parts[var_0B].v["currentState"];
			if(var_0C >= level.destructible_type[self.destuctableinfo].parts[var_0B].size)
			{
				var_0C = level.destructible_type[self.destuctableinfo].parts[var_0B].size - 1;
			}

			var_0D = get_model_from_part(var_0B,var_0C);
			var_06 = get_tag_from_part(var_0B,var_0C);
			if(!isdefined(var_0D))
			{
				continue;
			}

			if(!isdefined(var_06))
			{
				continue;
			}

			if(!ismodelattached(var_0D,var_06))
			{
				continue;
			}

			if(part_has_physics_exposion(var_0B))
			{
				apply_physics_explosion_to_part(var_0B,var_0C,var_06,var_07,param_01,param_02);
				continue;
			}

			self detach(var_0D,var_06);
			if(self.modeldummyon)
			{
				self.modeldummy detach(var_0D,var_06);
			}
		}
	}

	self notify("stop_taking_damage");
	wait(0.05);
	var_0E = var_07 + (0,0,80);
	if(getsubstr(level.destructible_type[self.destuctableinfo].v["type"],0,7) == "vehicle")
	{
		anim.lastcarexplosiontime = gettime();
		anim.lastcarexplosiondamagelocation = var_0E;
		anim.lastcarexplosionlocation = var_07;
		anim.lastcarexplosionrange = param_03;
	}

	self radiusdamage(var_0E,param_03,param_05,param_04,self);
	if(arcademode_car_kill())
	{
		thread maps\_arcademode::arcademode_add_points(self.origin,1,"explosive",200);
	}

	self notify("destroyed");
}

//Function Number: 35
arcademode_car_kill()
{
	if(!maps\_utility::arcademode())
	{
		return 0;
	}

	if(level.script == "ac130")
	{
		return 0;
	}

	if(isdefined(level.allcarsdamagedbyplayer))
	{
		return 1;
	}

	return maps\_gameskill::player_did_most_damage();
}

//Function Number: 36
get_destructible_index(param_00,param_01,param_02)
{
	if(param_01 >= 0)
	{
		return level.destructible_type[self.destuctableinfo].parts[param_00][param_01].v[param_02];
	}

	if(param_01 == -1)
	{
		var_03 = undefined;
		for(var_04 = 0;var_04 < level.destructible_type[self.destuctableinfo].parts[param_00].size;var_04++)
		{
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[param_00][var_04].v[param_02]))
			{
				var_03 = level.destructible_type[self.destuctableinfo].parts[param_00][var_04].v[param_02];
			}
		}

		return var_03;
	}
}

//Function Number: 37
get_tag_from_part(param_00,param_01)
{
	return get_destructible_index(param_00,param_01,"tagName");
}

//Function Number: 38
get_model_from_part(param_00,param_01)
{
	return get_destructible_index(param_00,param_01,"modelName");
}

//Function Number: 39
get_last_model_from_part(param_00)
{
	return get_destructible_index(param_00,-1,"modelName");
}

//Function Number: 40
apply_physics_explosion_to_part(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.destructible_type[self.destuctableinfo].parts[param_00][0].v["physicsOnExplosion"];
	var_07 = self gettagorigin(param_02);
	var_08 = vectornormalize(var_07 - param_03);
	var_08 = maps\_utility::vector_multiply(var_08,randomfloatrange(param_04,param_05) * var_06);
	thread physics_launch(param_00,param_01,var_07,var_08);
}

//Function Number: 41
part_has_physics_exposion(param_00)
{
	if(!isdefined(level.destructible_type[self.destuctableinfo].parts[param_00][0].v["physicsOnExplosion"]))
	{
		return 0;
	}

	return level.destructible_type[self.destuctableinfo].parts[param_00][0].v["physicsOnExplosion"] > 0;
}

//Function Number: 42
ismodelattached(param_00,param_01)
{
	var_02 = 0;
	param_00 = tolower(param_00);
	param_01 = tolower(param_01);
	if(!isdefined(param_01))
	{
		return var_02;
	}

	var_03 = self getattachsize();
	var_04 = [];
	for(var_05 = 0;var_05 < var_03;var_05++)
	{
		var_04[var_05] = tolower(self getattachmodelname(var_05));
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(var_04[var_05] != param_00)
		{
			continue;
		}

		var_06 = tolower(self getattachtagname(var_05));
		if(param_01 != var_06)
		{
			continue;
		}

		var_02 = 1;
		break;
	}

	return var_02;
}

//Function Number: 43
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

	if(soundexists(param_00))
	{
		var_03 playloopsound(param_00);
	}
	else
	{
	}

	var_02 thread force_stop_sound(param_00);
	var_02 waittill("stop sound" + param_00);
	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 44
force_stop_sound(param_00)
{
	self endon("stop sound" + param_00);
	level waittill("putout_fires");
	self notify("stop sound" + param_00);
}

//Function Number: 45
notifydamageafterframe(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.notifydamageafterframe))
	{
		return;
	}

	level.notifydamageafterframe = 1;
	waittillframeend;
	if(isdefined(self.exploded))
	{
		level.notifydamageafterframe = undefined;
		return;
	}

	self notify("damage",param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	level.notifydamageafterframe = undefined;
}

//Function Number: 46
get_dummy()
{
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

//Function Number: 47
disable_explosion()
{
	self.dontallowexplode = 1;
}

//Function Number: 48
force_explosion()
{
	self.dontallowexplode = undefined;
	self.forceexploding = 1;
	self notify("damage",1000000000,self,self.origin,self.origin,"MOD_EXPLOSIVE","","");
}

//Function Number: 49
get_traverse_disconnect_brush()
{
	if(!isdefined(self.target))
	{
		return undefined;
	}

	var_00 = getent(self.target,"targetname");
	if(!isdefined(var_00))
	{
		return undefined;
	}

	if(!var_00.spawnflags & 1)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 50
connecttraverses()
{
	var_00 = get_traverse_disconnect_brush();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 connectpaths();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 51
disconnecttraverses()
{
	var_00 = get_traverse_disconnect_brush();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00.origin = var_00.origin + (0,0,10000);
	var_00 disconnectpaths();
	var_00.origin = var_00.origin - (0,0,10000);
}

//Function Number: 52
setup_destructible_entities()
{
	var_00 = common_scripts\utility::get_linked_ents();
	var_01 = var_00;
	var_03 = getfirstarraykey(var_01);
	if(isdefined(var_03))
	{
		var_02 = var_01[var_03];
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		switch(var_02.script_noteworthy)
		{
			case "destroyed":
				break;
		}
	}
}

//Function Number: 53
destroy_destructible_entities()
{
	var_00 = common_scripts\utility::get_linked_ents();
	var_01 = var_00;
	var_03 = getfirstarraykey(var_01);
	if(isdefined(var_03))
	{
		var_02 = var_01[var_03];
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		switch(var_02.script_noteworthy)
		{
			case "destructible":
				break;

			case "destroyed":
				break;
		}
	}
}

//Function Number: 54
destructible_car_alarm()
{
}

//Function Number: 55
destructible_fx_spawn_immediate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
}

//Function Number: 56
destructible_splash_damage_scaler(param_00)
{
}
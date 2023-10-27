/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3662.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:31:01 AM
*******************************************************************/

//Function Number: 1
func_96F1()
{
	level.player.var_3D4C = [];
	level.player.var_3D4C["threat"] = spawnstruct();
	level.player.var_3D4C["threat"].var_698B = 0;
	level.player.var_3D4C["threat"].priority = 0;
	level.player.var_3D4C["response"] = spawnstruct();
	level.player.var_3D4C["response"].var_698B = 0;
	level.player.var_3D4C["response"].priority = 0;
	level.player.var_3D4C["reaction"] = spawnstruct();
	level.player.var_3D4C["reaction"].var_698B = 0;
	level.player.var_3D4C["reaction"].priority = 0;
	level.player.var_3D4C["inform"] = spawnstruct();
	level.player.var_3D4C["inform"].var_698B = 0;
	level.player.var_3D4C["inform"].priority = 0;
	level.player.var_3D4C["order"] = spawnstruct();
	level.player.var_3D4C["order"].var_698B = 0;
	level.player.var_3D4C["order"].priority = 0;
	level.player.var_3D4C["custom"] = spawnstruct();
	level.player.var_3D4C["custom"].var_698B = 0;
	level.player.var_3D4C["custom"].priority = 0;
	level.player.var_BFA8 = gettime() + 50;
	level.player.var_BFA9["threat"] = 0;
	level.player.var_BFA9["reaction"] = 0;
	level.player.var_BFA9["response"] = 0;
	level.player.var_BFA9["inform"] = 0;
	level.player.var_BFA9["order"] = 0;
	level.player.var_BFA9["custom"] = 0;
	level.player.var_9F6B = 0;
	level.player.var_29BF = 0;
	if(isdefined(level.var_D127) && level.player == level.var_D127)
	{
		level.player.var_46BC = "JK";
		return;
	}

	level.player.var_46BC = "UN";
}

//Function Number: 2
func_CF8E()
{
	while(!isdefined(level.var_3D4B))
	{
		wait(0.5);
	}

	if(!isdefined(level.player.var_28CF) || isdefined(level.player.var_28CF) && !level.player.var_28CF)
	{
		level.player.var_28CF = 1;
		level.player.var_9F6B = 0;
		thread func_CF87();
		level.player thread func_D439();
	}
}

//Function Number: 3
func_D313()
{
	if(!isdefined(level.player.var_1C8B))
	{
		level.player.var_1C8B = [];
		level.player scripts\anim\battlechatter::func_17A2("rpg");
		level.player scripts\anim\battlechatter::func_17A2("exposed");
		level.player scripts\anim\battlechatter::func_17A2("acquired");
		level.player scripts\anim\battlechatter::func_17A2("sighted");
		level.player scripts\anim\battlechatter::func_17A2("ai_contact_clock");
		level.player scripts\anim\battlechatter::func_17A2("ai_target_clock");
		level.player scripts\anim\battlechatter::func_17A2("ai_cardinal");
		level.player scripts\anim\battlechatter::func_17A2("player_contact_clock");
		level.player scripts\anim\battlechatter::func_17A2("player_target_clock");
		level.player scripts\anim\battlechatter::func_17A2("player_cardinal");
		level.player scripts\anim\battlechatter::func_17A2("ai_obvious");
		level.player scripts\anim\battlechatter::func_17A2("player_object_clock");
		level.player scripts\anim\battlechatter::func_17A2("player_location");
		level.player scripts\anim\battlechatter::func_17A2("ai_location");
		level.player scripts\anim\battlechatter::func_17A2("generic_location");
		level.player scripts\anim\battlechatter::func_17A2("ai_casual_clock");
		level.player scripts\anim\battlechatter::func_17A2("concat_location");
		level.player scripts\anim\battlechatter::func_17A2("concat_location");
		level.player scripts\anim\battlechatter::func_17A2("player_distance");
		level.player scripts\anim\battlechatter::func_17A2("player_target_clock_high");
		level.player scripts\anim\battlechatter::func_17A2("ai_distance");
		level.player scripts\anim\battlechatter::func_17A2("ai_target_clock_high");
	}
}

//Function Number: 4
func_CF8C()
{
	anim notify("player_battlechatter_off");
	if(isdefined(level.player) && isdefined(level.player.var_28CF))
	{
		level.player.var_28CF = 0;
	}

	if(isdefined(level.player) && isdefined(level.player.var_9F6B))
	{
		level.player.var_9F6B = 0;
	}
}

//Function Number: 5
func_D439()
{
	self endon("death");
	self endon("player_battlechatter_off");
	var_00 = 0.5;
	wait(var_00);
	if(!scripts\common\utility::func_D11B())
	{
		thread scripts\anim\battlechatter_ai::func_1A10();
	}

	wait(var_00);
	thread func_D381();
	wait(var_00);
	thread func_D37C();
	wait(var_00);
	thread scripts\anim\battlechatter_ai::func_1A07();
}

//Function Number: 6
func_D37C()
{
	while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isdefined(level.player.var_28CF) && level.player.var_28CF)
	{
		level.player waittill("damage",var_00,var_01);
		if(!scripts\common\utility::func_D11B())
		{
			if(var_01 scripts\anim\battlechatter::func_29AB())
			{
				var_02 = level.var_10AF9["allies"].var_B661;
				var_02 = scripts\common\utility::array_randomize(var_02);
				foreach(var_04 in var_02)
				{
					if(isalive(var_04) && isai(var_04) && distancesquared(level.player.origin,var_04.origin) > 10000)
					{
						var_04 scripts\anim\battlechatter_ai::func_183F("infantry",var_01,0.9);
						break;
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_D381()
{
	while(!scripts\common\utility::func_D11B() && isalive(level.player) && scripts\anim\battlechatter::func_29CA())
	{
		wait(1);
	}

	while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isdefined(level.player.var_28CF) && level.player.var_28CF)
	{
		if(scripts\common\utility::func_D11B())
		{
			if(isdefined(level.player.var_58B7))
			{
				if(isdefined(level.player.var_58B7.var_1198) && isdefined(level.player.var_58B7.var_1198.var_9DE4))
				{
					if(level.player.var_58B7.var_1198.var_9DE4)
					{
						wait(randomfloatrange(0.25,0.5));
						if(isdefined(level.player.var_58B7))
						{
							level.player scripts\anim\battlechatter_ai::func_181C("movement","generic",level.player.var_58B7,0.9);
						}
					}
					else
					{
						wait(randomfloatrange(0.5,0.75));
						if(isdefined(level.player.var_58B7))
						{
							level.player scripts\anim\battlechatter_ai::func_183F("acquired",level.player.var_58B7);
						}
					}
				}
			}
		}

		wait(1);
		while(!scripts\common\utility::func_D11B() && isalive(level.player) && scripts\anim\battlechatter::func_29CA())
		{
			wait(1);
		}
	}
}

//Function Number: 8
func_D45C()
{
	var_00 = undefined;
	while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isdefined(level.player.var_28CF) && level.player.var_28CF)
	{
		if(!scripts\common\utility::func_D11B())
		{
			var_01 = scripts\sp\_utility::func_81FF();
			foreach(var_03 in var_01)
			{
				if(!isdefined(var_03))
				{
					continue;
				}

				if(isdefined(var_00) && var_00 == var_03)
				{
					continue;
				}

				if(issubstr(var_03.classname,"dropship"))
				{
					if(isdefined(var_03.var_EEDE) && var_03.var_EEDE != level.player.team)
					{
						if(level.player scripts\anim\battlechatter::func_D643(var_03.origin) && distancesquared(level.player.origin,var_03.origin) < 4000000)
						{
							var_04 = level.var_10AF9["allies"].var_B661;
							var_04 = scripts\common\utility::array_randomize(var_04);
							foreach(var_06 in var_04)
							{
								if(isalive(var_06) && isai(var_06) && distancesquared(level.player.origin,var_06.origin) < 250000)
								{
									var_06 scripts\anim\battlechatter_ai::func_17D2("incoming","dropship",undefined,0.9,"vehicle");
									var_00 = var_03;
								}
							}

							wait(randomintrange(15,25));
						}
					}
				}
			}
		}

		wait(2);
		while(scripts\common\utility::func_D11B())
		{
			wait(5);
		}
	}
}

//Function Number: 9
func_CF87()
{
	level.player.var_29C8 = 1;
	while(isalive(level.player) && scripts\anim\battlechatter::func_29CA() && isdefined(level.player.var_28CF) && level.player.var_28CF)
	{
		if(level.player.var_29C8 == 0)
		{
			var_00 = 10;
		}
		else
		{
			var_00 = level.player.var_29C8;
		}

		level.player.var_9F6B = 1;
		for(var_01 = var_00;var_01 >= 0;var_01--)
		{
			level.player.var_29C8 = var_01;
			wait(1);
		}

		level.player.var_9F6B = 0;
		level waittill("player_battlechatter_refresh");
		while(level.player.var_9F6B != 0)
		{
			wait(0.5);
		}
	}
}

//Function Number: 10
func_CF89()
{
	level.player endon("death");
	level endon("player_battlechatter_off");
	var_00 = "none";
	var_01 = ["pc_ammocrate_pickup","pc_equipcrate_pickup","pc_weapon_scanned","pc_armory_door","pc_clear_last_event"];
	for(;;)
	{
		var_02 = scripts\common\utility::func_13730(var_01);
		if(var_02 != var_00 && var_02 != "pc_clear_last_event")
		{
			level.player scripts\anim\battlechatter::func_CEE8(var_02);
			var_00 = var_02;
			thread func_CF88();
		}
		else if(var_02 == "pc_clear_last_event")
		{
			var_00 = "none";
		}

		wait(1);
	}
}

//Function Number: 11
func_CF88()
{
	wait(10);
	level notify("pc_clear_last_event");
}

//Function Number: 12
func_CF86()
{
	level.player endon("death");
	level endon("player_battlechatter_off");
	for(;;)
	{
		var_00 = distance(level.player.origin,self.origin);
		if(var_00 < 500)
		{
			if(scripts\sp\_utility::func_D1DF(self.origin + (0,0,40)))
			{
				if(self.var_336 == "ammo_pickup")
				{
					level notify("pc_ammocrate_pickup");
				}

				if(self.var_336 == "equipment_pickup")
				{
					level notify("pc_equipcrate_pickup");
				}

				if(self.var_336 == "loot_hint_struct")
				{
					level notify("pc_armory_door");
				}

				break;
			}
		}

		wait(1);
	}
}

//Function Number: 13
func_9FE0(param_00)
{
	if(!isdefined(self.var_10AC8.var_9E9B[param_00]) || !isdefined(level.var_9F9E[self.team][param_00]))
	{
		return 1;
	}

	if(!self.var_10AC8.var_9E9B[param_00] && !level.var_9F9E[self.team][param_00])
	{
		return 1;
	}

	return 0;
}
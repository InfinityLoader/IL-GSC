/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _upgrade_perks.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 154 ms
 * Timestamp: 4/22/2024 2:23:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	upgrade_init_perks_tables();
	upgrade_init_perks_players();
	level thread upgrade_change_monitor();
}

//Function Number: 2
upgrade_init_perks_tables()
{
	level.upgrade_perk_active = [];
	level.upgrade_ref = [];
	level.upgrade_ref_index = [];
	level.upgrade_perk_code = [];
	level.upgrade_perk_dvar = [];
	level.upgrade_perk_dvar_origval = [];
	level.upgrade_perk_dvar_newval = [];
	level.upgrade_perk_code_2 = [];
	level.upgrade_perk_dvar_2 = [];
	level.upgrade_perk_dvar_origval_2 = [];
	level.upgrade_perk_dvar_newval_2 = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("sp/upgrade_table.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = int(var_01);
		var_03 = tablelookupbyrow("sp/upgrade_table.csv",var_00,1);
		var_04 = tablelookupbyrow("sp/upgrade_table.csv",var_00,5);
		if(var_03 == "" || var_04 == "")
		{
		}
		else
		{
			level.upgrade_ref_index[var_03] = var_02;
			level.upgrade_ref[var_02] = var_03;
			level.upgrade_perk_code[var_02] = var_04;
			var_05 = tablelookupbyrow("sp/upgrade_table.csv",var_00,6);
			var_06 = float(tablelookupbyrow("sp/upgrade_table.csv",var_00,7));
			var_07 = float(tablelookupbyrow("sp/upgrade_table.csv",var_00,8));
			if(isdefined(var_05) && var_05 != "" && isdefined(var_06) && isdefined(var_07))
			{
				level.upgrade_perk_dvar[var_02] = var_05;
				level.upgrade_perk_dvar_origval[var_02] = var_06;
				level.upgrade_perk_dvar_newval[var_02] = var_07;
			}

			var_08 = tablelookupbyrow("sp/upgrade_table.csv",var_00,9);
			if(var_08 != "")
			{
				level.upgrade_perk_code_2[var_02] = var_08;
				var_09 = tablelookupbyrow("sp/upgrade_table.csv",var_00,10);
				var_0A = float(tablelookupbyrow("sp/upgrade_table.csv",var_00,11));
				var_0B = float(tablelookupbyrow("sp/upgrade_table.csv",var_00,12));
				if(isdefined(var_09) && var_09 != "" && isdefined(var_0A) && isdefined(var_0B))
				{
					level.upgrade_perk_dvar_2[var_02] = var_09;
					level.upgrade_perk_dvar_origval_2[var_02] = var_0A;
					level.upgrade_perk_dvar_newval_2[var_02] = var_0B;
				}
			}

			if(var_04 != "")
			{
				level.upgrade_perk_active[var_02] = ::upgrade_perk_active_code;
			}
		}

		var_00++;
	}
}

//Function Number: 3
upgrade_change_monitor()
{
	self notify("upgrade_change_monitor");
	self endon("upgrade_change_monitor");
	setdvarifuninitialized("upgrades_changed",0);
	for(;;)
	{
		if(getdvarint("upgrades_changed"))
		{
			setdvar("upgrades_changed",0);
			upgrade_init_perks_players();
		}

		wait(0.25);
	}
}

//Function Number: 4
upgrade_init_perks_players()
{
	foreach(var_01 in level.players)
	{
		var_01 thread upgrade_init_perks_player();
	}
}

//Function Number: 5
upgrade_init_perks_player()
{
	foreach(var_01 in level.upgrade_ref_index)
	{
		upgrade_take_perk(level.upgrade_ref[var_01]);
	}

	foreach(var_01 in level.upgrade_ref_index)
	{
		if(maps\_upgrade_system::upgrade_is_purchased(var_01))
		{
			upgrade_give_perk(level.upgrade_ref[var_01]);
		}
	}
}

//Function Number: 6
upgrade_perk_script_code(param_00,param_01)
{
	switch(param_00)
	{
		case "specialty_detectexplosive":
			level.player.exclusive["show_grenades"] = param_01;
			break;

		case "specialty_detectintel":
			level.player.exclusive["intel_mode"] = param_01;
			break;

		case "specialty_extended_battery":
			if(param_01)
			{
				maps\_player_exo::batteryinit(1);
			}
			else
			{
				maps\_player_exo::batteryinit();
			}
			break;

		case "specialty_extended_battery2":
			if(param_01)
			{
				maps\_player_exo::batteryinit(2);
			}
			else
			{
				maps\_player_exo::batteryinit();
			}
			break;

		case "specialty_extendeddetectgren":
			if(param_01)
			{
				level.player.detection_grenade_duration_bonus = 5;
			}
			else
			{
				level.player.detection_grenade_duration_bonus = 0;
			}
			break;
	}
}

//Function Number: 7
upgrade_perk_active_code(param_00,param_01)
{
	if(param_01)
	{
		upgrade_perk_script_code(level.upgrade_perk_code[param_00],1);
		self setperk(level.upgrade_perk_code[param_00],1,0);
		if(isdefined(level.upgrade_perk_dvar[param_00]))
		{
			setsaveddvar(level.upgrade_perk_dvar[param_00],level.upgrade_perk_dvar_newval[param_00]);
		}

		if(isdefined(level.upgrade_perk_code_2[param_00]))
		{
			self setperk(level.upgrade_perk_code_2[param_00],1,0);
			if(isdefined(level.upgrade_perk_dvar_2[param_00]))
			{
				setsaveddvar(level.upgrade_perk_dvar_2[param_00],level.upgrade_perk_dvar_newval_2[param_00]);
				return;
			}

			return;
		}

		return;
	}

	upgrade_perk_script_code(level.upgrade_perk_code[param_00],0);
	self unsetperk(level.upgrade_perk_code[param_00],1);
	if(isdefined(level.upgrade_perk_dvar[param_00]))
	{
		setsaveddvar(level.upgrade_perk_dvar[param_00],level.upgrade_perk_dvar_origval[param_00]);
	}

	if(isdefined(level.upgrade_perk_code_2[param_00]))
	{
		self unsetperk(level.upgrade_perk_code_2[param_00],1);
		if(isdefined(level.upgrade_perk_dvar_2[param_00]))
		{
			setsaveddvar(level.upgrade_perk_dvar_2[param_00],level.upgrade_perk_dvar_origval_2[param_00]);
			return;
		}
	}
}

//Function Number: 8
upgrade_give_perk(param_00)
{
	var_01 = level.upgrade_ref_index[param_00];
	if(isdefined(level.upgrade_perk_active[var_01]))
	{
		self [[ level.upgrade_perk_active[var_01] ]](var_01,1);
	}

	self notify("give_perk",param_00);
}

//Function Number: 9
upgrade_take_perk(param_00)
{
	var_01 = level.upgrade_ref_index[param_00];
	if(isdefined(level.upgrade_perk_active[var_01]))
	{
		self [[ level.upgrade_perk_active[var_01] ]](var_01,0);
	}

	self notify("take_perk",param_00);
}
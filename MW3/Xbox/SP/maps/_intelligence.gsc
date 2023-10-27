/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_intelligence.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 324 ms
 * Timestamp: 10/27/2023 2:35:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(maps\_utility::is_iw4_map_sp())
	{
		return;
	}

	precachestring(&"SCRIPT_INTELLIGENCE_OF_FOURTYSIX");
	precachestring(&"SCRIPT_INTELLIGENCE_PREV_FOUND");
	level.intel_items = func_19D0();
	setdvar("ui_level_cheatpoints",level.intel_items.size);
	level.intel_counter = 0;
	setdvar("ui_level_player_cheatpoints",level.intel_counter);
	level.table_origins = func_19D2();
	func_19CB();
	if(maps\_utility::is_specialop())
	{
		remove_all_intel();
		return;
	}

	intel_think();
	wait 0.05;
}

//Function Number: 2
remove_all_intel()
{
	foreach(var_01 in level.intel_items)
	{
		if(!isdefined(var_01.removed))
		{
			var_01 remove_intel_item();
		}
	}
}

//Function Number: 3
remove_intel_item()
{
	self.removed = 1;
	self.item hide();
	self.item notsolid();
	common_scripts\utility::trigger_off();
	level.intel_counter++;
	setdvar("ui_level_player_cheatpoints",level.intel_counter);
	self notify("end_trigger_thread");
}

//Function Number: 4
func_19CB()
{
	foreach(var_01 in level.intel_items)
	{
		var_02 = var_01.origin;
		var_01.var_19CC = func_19DA(var_02);
	}
}

//Function Number: 5
intel_think()
{
	foreach(var_01 in level.intel_items)
	{
		if(var_01 func_19CF())
		{
			var_01 remove_intel_item();
			continue;
		}

		var_01 thread wait_for_pickup();
		var_01 thread poll_for_found();
	}
}

//Function Number: 6
poll_for_found()
{
	self endon("end_loop_thread");
	while(!func_19CF())
	{
		wait 0.1;
	}

	remove_intel_item();
}

//Function Number: 7
func_19CF()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 getplayerintelisfound(self.var_19CC))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
func_19D0()
{
	var_00 = getentarray("intelligence_item","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].item = getent(var_00[var_01].target,"targetname");
		var_00[var_01].var_19D1 = 0;
	}

	return var_00;
}

//Function Number: 9
func_19D2()
{
	var_00 = [];
	for(var_01 = 1;var_01 <= 64;var_01++)
	{
		var_02 = tablelookup("maps/_intel_items.csv",0,var_01,4);
		if(isdefined(var_02) && var_02 != "undefined")
		{
			var_03 = strtok(var_02,",");
			for(var_04 = 0;var_04 < var_03.size;var_04++)
			{
				var_03[var_04] = int(var_03[var_04]);
			}

			var_00[var_01] = (var_03[0],var_03[1],var_03[2]);
			continue;
		}

		var_00[var_01] = undefined;
	}

	return var_00;
}

//Function Number: 10
wait_for_pickup()
{
	self endon("end_trigger_thread");
	if(self.classname == "trigger_use")
	{
		self sethintstring(&"SCRIPT_INTELLIGENCE_PICKUP");
		self usetriggerrequirelookat();
	}

	self waittill("trigger",var_00);
	self notify("end_loop_thread");
	intel_feedback(var_00);
	save_intel_for_all_players();
	updategamerprofileall();
	waittillframeend;
	remove_intel_item();
}

//Function Number: 11
save_intel_for_all_players()
{
	foreach(var_01 in level.players)
	{
		if(var_01 getplayerintelisfound(self.var_19CC))
		{
			continue;
		}

		var_01 setplayerintelfound(self.var_19CC);
	}

	logstring("found intel item " + self.var_19CC);
	maps\_endmission::updatesppercent();
}

//Function Number: 12
func_19D5()
{
	var_00 = self getlocalplayerprofiledata("cheatPoints");
	self setlocalplayerprofiledata("cheatPoints",var_00 + 1);
}

//Function Number: 13
intel_feedback(param_00)
{
	self.item hide();
	self.item notsolid();
	level thread common_scripts\utility::play_sound_in_space("intelligence_pickup",self.item.origin);
	var_01 = 3000;
	var_02 = 700;
	var_03 = var_01 + var_02 / 1000;
	foreach(var_05 in level.players)
	{
		if(param_00 != var_05 && var_05 getplayerintelisfound(self.var_19CC))
		{
			continue;
		}

		var_06 = var_05 maps\_hud_util::createclientfontstring("objective",1.5);
		var_06.glowcolor = (0.7,0.7,0.3);
		var_06.glowalpha = 1;
		var_06 setup_hud_elem();
		var_06.y = -60;
		var_06 setpulsefx(60,var_01,var_02);
		var_07 = 0;
		if(param_00 == var_05 && var_05 getplayerintelisfound(self.var_19CC))
		{
			var_06.label = &"SCRIPT_INTELLIGENCE_PREV_FOUND";
		}
		else
		{
			var_06.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYSIX";
			var_05 func_19D5();
			var_07 = var_05 getlocalplayerprofiledata("cheatPoints");
			var_06 setvalue(var_07);
		}

		if(var_07 >= 22)
		{
			var_05 maps\_utility::player_giveachievement_wrapper("INFORMANT");
		}

		if(var_07 == 46)
		{
			var_05 maps\_utility::player_giveachievement_wrapper("SCOUT_LEADER");
		}

		var_06 common_scripts\utility::delaycall(var_03,::destroy);
	}
}

//Function Number: 14
setup_hud_elem()
{
	self.color = (1,1,1);
	self.alpha = 1;
	self.x = 0;
	self.alignx = "center";
	self.aligny = "middle";
	self.horzalign = "center";
	self.vertalign = "middle";
	self.foreground = 1;
}

//Function Number: 15
assert_if_identical_origins()
{
	var_00 = [];
	var_01 = 1;
	while(var_01 < 65)
	{
		var_02 = tablelookup("maps/_intel_items.csv",0,var_01,4);
		var_03 = strtok(var_02,",");
		var_01 = 0;
		while(var_01 < var_03.size)
		{
			var_02++ = var_41[var_01];
		}

		var_01[var_02] = (var_41[0],var_41[1],var_41[2]);
		var_02++ = int(var_03[var_01]);
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02]))
		{
			continue;
		}

		if(var_01[var_02] == "undefined")
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			if(!isdefined(var_01[var_04]))
			{
			}
			else if(var_01[var_04] == "undefined")
			{
			}
			else if(var_02 == var_04)
			{
			}
			else if(var_01[var_02] == var_01[var_04])
			{
			}
		}
	}
}

//Function Number: 16
func_19DA(param_00)
{
	for(var_01 = 1;var_01 < level.table_origins.size + 1;var_01++)
	{
		if(!isdefined(level.table_origins[var_01]))
		{
			continue;
		}

		if(distancesquared(param_00,level.table_origins[var_01]) < squared(75))
		{
			return var_01;
		}
	}
}
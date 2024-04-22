/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _intelligence.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 369 ms
 * Timestamp: 4/22/2024 2:21:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachestring(&"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE");
	precachestring(&"SCRIPT_RORKEFILE_PREV_FOUND");
	precachestring(&"SCRIPT_INTELLIGENCE_PICKUP");
	precachestring(&"SCRIPT_INTELLIGENCE_PERCENT");
	precachestring(&"SCRIPT_INTELLIGENCE_UPLOADING");
	precacheshader("torpedo_connection_bar");
	precacheshader("torpedo_connection_frame");
	level.intel_items = create_array_of_intel_items();
	setdvar("ui_level_cheatpoints",level.intel_items.size);
	level.intel_counter = 0;
	setdvar("ui_level_player_cheatpoints",level.intel_counter);
	level.table_origins = create_array_of_origins_from_table();
	initialize_intel();
	if(maps\_utility::is_specialop())
	{
		remove_all_intel();
		return;
	}

	intel_think();
	wait(0.05);
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
initialize_intel()
{
	foreach(var_01 in level.intel_items)
	{
		var_02 = var_01.origin;
		var_01.num = get_nums_from_origins(var_02);
	}
}

//Function Number: 5
intel_think()
{
	foreach(var_01 in level.intel_items)
	{
		if(var_01 check_item_found())
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
	while(!check_item_found())
	{
		wait(0.1);
	}

	remove_intel_item();
}

//Function Number: 7
check_item_found()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 getplayerintelisfound(self.num))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
create_array_of_intel_items()
{
	var_00 = getentarray("intelligence_item","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].item = getent(var_00[var_01].target,"targetname");
		var_00[var_01].found = 0;
	}

	return var_00;
}

//Function Number: 9
create_array_of_origins_from_table()
{
	var_00 = [];
	for(var_01 = 1;var_01 <= 64;var_01++)
	{
		var_02 = tablelookup("sp/_intel_items.csv",0,var_01,4);
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
award_intel()
{
	save_intel_for_all_players();
	updategamerprofileall();
	waittillframeend;
	remove_intel_item();
}

//Function Number: 11
wait_for_pickup()
{
	self endon("end_trigger_thread");
	if(self.classname == "trigger_use")
	{
		self sethintstring(&"SCRIPT_INTELLIGENCE_PICKUP");
		self usetriggerrequirelookat();
	}

	thread upload_hold();
	self waittill("hold_complete");
	self notify("end_loop_thread");
	intel_feedback(level.player);
	award_intel();
}

//Function Number: 12
upload_hold()
{
	level.player.hold_count = 0;
	while(level.player.hold_count < 30)
	{
		level.player.hold_count = 0;
		self waittill("trigger",var_00);
		setdvar("ui_securing","intel");
		setdvar("ui_securing_progress",0);
		thread progress_bar();
		hold_count_check();
	}

	self notify("hold_complete");
	self stoploopsound("intelligence_pickup_loop");
	setdvar("ui_securing_progress",1);
	setdvar("ui_securing","");
	level.player.hold_count = 0;
}

//Function Number: 13
hold_count_check()
{
	self endon("stopped_pressing");
	for(;;)
	{
		if(level.player usebuttonpressed() && distance(level.player.origin,self.origin) < 128 && isalive(level.player))
		{
			level.player.hold_count++;
		}
		else
		{
			setdvar("ui_securing","");
			self stoploopsound("intelligence_pickup_loop");
			self notify("stopped_pressing");
		}

		if(level.player.hold_count >= 30)
		{
			setdvar("ui_securing","");
			self notify("stopped_pressing");
			self stoploopsound("intelligence_pickup_loop");
		}

		wait 0.05;
	}
}

//Function Number: 14
progress_bar()
{
	self endon("stopped_pressing");
	var_00 = 30;
	var_01 = 8;
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		setdvar("ui_securing_progress",getdvarfloat("ui_securing_progress") + 1 / var_00);
		wait 0.05;
	}
}

//Function Number: 15
intel_upload_text(param_00,param_01)
{
	self endon("stopped_pressing");
	var_02 = 30;
	var_03 = 10;
	var_04 = 0;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		if(var_04 > var_03)
		{
			var_04 = 0;
		}

		if(var_04 < var_03 / 2)
		{
			param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
		}
		else
		{
			param_00 settext("");
		}

		param_01.label = int(var_05 / var_02 * 100);
		param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
		var_04++;
		wait 0.05;
	}

	param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
	param_01.label = "100";
	param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
}

//Function Number: 16
save_intel_for_all_players()
{
	foreach(var_01 in level.players)
	{
		if(var_01 getplayerintelisfound(self.num))
		{
			continue;
		}

		var_01 setplayerintelfound(self.num);
		var_01 maps\_player_stats::stat_notify("intel",1);
	}

	logstring("found intel item " + self.num);
	maps\_endmission::updatesppercent();
}

//Function Number: 17
give_point()
{
	var_00 = self getlocalplayerprofiledata("cheatPoints");
	self setlocalplayerprofiledata("cheatPoints",var_00 + 1);
	check_intel_achievements(self);
}

//Function Number: 18
check_intel_achievements(param_00)
{
	var_01 = param_00 getlocalplayerprofiledata("cheatPoints");
	if(var_01 >= 45)
	{
		maps\_utility::giveachievement_wrapper("INTEL_ALL");
	}

	if(var_01 >= 23)
	{
		maps\_utility::giveachievement_wrapper("INTEL_HALF");
	}
}

//Function Number: 19
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
		if(param_00 != var_05 && var_05 getplayerintelisfound(self.num))
		{
			continue;
		}

		var_06 = var_05 maps\_hud_util::createclientfontstring("objective",1.5);
		var_06.glowcolor = (0.7,0.7,0.3);
		var_06.glowalpha = 1;
		var_06 setup_hud_elem();
		var_06.y = -50;
		var_07 = getdvarint("loc_language",0);
		if(var_07 == 16)
		{
			var_06 maps\_utility::delaythread(var_01 / 1000,::maps\_hud_util::fade_over_time,0,var_02 / 1000);
		}
		else
		{
			var_06 setpulsefx(60,var_01,var_02);
		}

		var_08 = 0;
		if(param_00 == var_05 && var_05 getplayerintelisfound(self.num))
		{
			var_06.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
		}
		else
		{
			var_06.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE";
			var_05 give_point();
			var_08 = var_05 getlocalplayerprofiledata("cheatPoints");
			var_06 setvalue(var_08);
		}

		if(var_08 == 18)
		{
			var_05 maps\_utility::player_giveachievement_wrapper("EXT_1");
		}

		var_06 common_scripts\utility::delaycall(var_03,::destroy);
	}
}

//Function Number: 20
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

//Function Number: 21
assert_if_identical_origins()
{
	var_00 = [];
	for(var_01 = 1;var_01 < 65;var_01++)
	{
		var_02 = tablelookup("sp/_intel_items.csv",0,var_01,4);
		var_03 = strtok(var_02,",");
		for(var_01 = 0;var_01 < var_03.size;var_01++)
		{
			var_03[var_01] = int(var_03[var_01]);
		}

		var_00[var_01] = (var_03[0],var_03[1],var_03[2]);
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!isdefined(var_00[var_01]))
		{
			continue;
		}

		if(var_00[var_01] == "undefined")
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			if(!isdefined(var_00[var_04]))
			{
			}
			else if(var_00[var_04] == "undefined")
			{
			}
			else if(var_01 == var_04)
			{
			}
			else if(var_00[var_01] == var_00[var_04])
			{
			}
		}
	}
}

//Function Number: 22
get_nums_from_origins(param_00)
{
	foreach(var_03, var_02 in level.table_origins)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(distancesquared(param_00,var_02) < squared(75))
		{
			return var_03;
		}
	}
}
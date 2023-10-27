/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_intelligence.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 208 ms
 * Timestamp: 10/27/2023 2:48:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!maps\_utility::is_h1_level())
	{
		return;
	}

	precachestring(&"SCRIPT_INTELLIGENCE_OF_THIRTY");
	precacheshader("h1_hud_ammo_status_glow");
	precacheshader("h1_hud_ammo_status_scanlines");
	level.intel_items_total = 30;
	level.intel_items = create_array_of_intel_items();
	level.table_origins = create_array_of_origins_from_table();
	initialize_intel();
}

//Function Number: 2
initialize_intel()
{
	for(var_00 = 0;var_00 < level.intel_items.size;var_00++)
	{
		var_01 = level.intel_items[var_00];
		var_02 = var_01.origin;
		level.intel_items[var_00].num = get_nums_from_origins(var_02);
		if(level.intel_items[var_00] check_item_found())
		{
			var_01.item hide();
			var_01.item notsolid();
			var_01 common_scripts\utility::trigger_off();
			level.intel_items[var_00].found = 1;
			continue;
		}

		level.intel_items[var_00] thread wait_for_pickup();
	}

	remove_found_intel();
}

//Function Number: 3
remove_found_intel()
{
	for(;;)
	{
		for(var_00 = 0;var_00 < level.intel_items.size;var_00++)
		{
			if(!isdefined(level.intel_items[var_00].removed) && level.intel_items[var_00] check_item_found())
			{
				level.intel_items[var_00].removed = 1;
				level.intel_items[var_00].item hide();
				level.intel_items[var_00].item notsolid();
				level.intel_items[var_00] common_scripts\utility::trigger_off();
				level.intel_items[var_00] notify("end_trigger_thread");
			}
		}

		wait(0.1);
	}
}

//Function Number: 4
check_item_found()
{
	return level.player getplayerintelisfound(self.num);
}

//Function Number: 5
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

//Function Number: 6
create_array_of_origins_from_table()
{
	var_00 = [];
	for(var_01 = 1;var_01 <= level.intel_items_total;var_01++)
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

//Function Number: 7
wait_for_pickup()
{
	self sethintstring(&"SCRIPT_INTELLIGENCE_PICKUP");
	self usetriggerrequirelookat();
	self endon("end_trigger_thread");
	self waittill("trigger");
	self.found = 1;
	common_scripts\utility::trigger_off();
	save_that_item_is_found();
	updategamerprofile();
	thread intel_feedback();
}

//Function Number: 8
save_that_item_is_found()
{
	level.player setplayerintelfound(self.num);
}

//Function Number: 9
get_nums_from_origins(param_00)
{
	for(var_01 = 1;var_01 < level.table_origins.size + 1;var_01++)
	{
		if(!isdefined(level.table_origins[var_01]))
		{
			continue;
		}

		if(distancesquared(param_00,level.table_origins[var_01]) < 25)
		{
			return var_01;
		}
	}
}

//Function Number: 10
intel_feedback()
{
	self.item hide();
	self.item notsolid();
	level thread common_scripts\utility::play_sound_in_space("intelligence_pickup",self.item.origin);
	var_00 = 3000;
	var_01 = 700;
	var_02 = maps\_hud_util::createicon("h1_hud_ammo_status_glow",400,75);
	var_02.color = (1,0.95,0.4);
	var_02.x = 0;
	var_02.y = -65;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	var_02.foreground = 1;
	var_02.alpha = 0;
	var_03 = maps\_hud_util::createicon("h1_hud_ammo_status_scanlines",800,75);
	var_03.color = (1,0.85,0);
	var_03.x = 0;
	var_03.y = -65;
	var_03.alignx = "center";
	var_03.aligny = "middle";
	var_03.horzalign = "center";
	var_03.vertalign = "middle";
	var_03.foreground = 1;
	var_03.alpha = 0;
	var_04 = maps\_hud_util::createfontstring("objective",1.5);
	var_04 setup_hud_elem();
	var_04 setpulsefx(19,var_00,var_01);
	var_04 setvalue(intel_found_total());
	var_05 = intel_found_total();
	if(var_05 == 15 || maps\_achievements::platform_tracks_progression())
	{
		maps\_utility::giveachievement_wrapper("LOOK_SHARP");
	}

	if(var_05 == 30 || maps\_achievements::platform_tracks_progression())
	{
		maps\_utility::giveachievement_wrapper("EYES_AND_EARS");
	}

	wait(0.7);
	var_02.alpha = 0.5;
	wait(0.05);
	var_03.alpha = 0.6;
	var_02 fadeovertime(0.035);
	var_02.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(1);
	var_03.alpha = 0;
	wait(var_00 + var_01 / 1000);
	var_04 destroy();
	var_02 destroy();
	var_03 destroy();
}

//Function Number: 11
setup_hud_elem()
{
	self.fontscale = 1.2;
	self.glowcolor = (0.96,0.81,0);
	self.glowalpha = 0.2;
	self.color = (0.99,0.97,0.85);
	self.alpha = 1;
	self.x = 0;
	self.y = -65;
	self.alignx = "center";
	self.aligny = "middle";
	self.horzalign = "center";
	self.vertalign = "middle";
	self.foreground = 1;
	self.label = &"SCRIPT_INTELLIGENCE_OF_THIRTY";
}

//Function Number: 12
intel_found_total()
{
	var_00 = 0;
	for(var_01 = 1;var_01 <= level.intel_items_total;var_01++)
	{
		if(level.player getplayerintelisfound(var_01))
		{
			var_00++;
		}
	}

	return var_00;
}
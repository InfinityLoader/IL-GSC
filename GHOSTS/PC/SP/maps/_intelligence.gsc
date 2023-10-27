/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_intelligence.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 340 ms
 * Timestamp: 10/27/2023 1:27:48 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	precachestring(&"SCRIPT_INTELLIGENCE_OF_EIGHTEEN");
	precachestring(&"SCRIPT_RORKEFILE_PREV_FOUND");
	precachestring(&"SCRIPT_RORKEFILE_PICKUP");
	precachestring(&"SCRIPT_INTELLIGENCE_PERCENT");
	precachestring(&"SCRIPT_INTELLIGENCE_UPLOADING");
	precacheshader("torpedo_connection_bar");
	precacheshader("torpedo_connection_frame");
	level.intel_items = create_array_of_intel_items();
	setdvar("ui_level_cheatpoints",level.intel_items.size);
	level.var_4675 = 0;
	setdvar("ui_level_player_cheatpoints",level.var_4675);
	level.var_7E54 = func_2066();
	func_4625();
	if(maps\_utility::func_4840())
	{
		func_650D();
		return;
	}

	intel_think();
	wait(0.05);
}

//Function Number: 2
func_650D()
{
	foreach(var_01 in level.intel_items)
	{
		if(!isdefined(var_01.var_6583))
		{
			var_01 func_6539();
		}
	}
}

//Function Number: 3
func_6539()
{
	self.var_6583 = 1;
	self.item hide();
	self.item notsolid();
	common_scripts\utility::trigger_off();
	level.var_4675++;
	setdvar("ui_level_player_cheatpoints",level.var_4675);
	self notify("end_trigger_thread");
}

//Function Number: 4
func_4625()
{
	foreach(var_01 in level.intel_items)
	{
		var_02 = var_01.origin;
		var_01.var_576D = func_3915(var_02);
	}
}

//Function Number: 5
intel_think()
{
	foreach(var_01 in level.intel_items)
	{
		if(var_01 func_1B74())
		{
			var_01 func_6539();
			continue;
		}

		var_01 thread func_8A8A();
		var_01 thread func_6092();
	}
}

//Function Number: 6
func_6092()
{
	self endon("end_loop_thread");
	if(isdefined(self))
	{
		if(func_1B74())
		{
			func_6539();
		}
	}
	else
	{
	}

	while(!func_1B74())
	{
		wait(0.05);
	}

	func_6539();
}

//Function Number: 7
func_1B74()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 getplayerintelisfound(self.var_576D))
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
		var_00[var_01].var_34F4 = 0;
	}

	return var_00;
}

//Function Number: 9
func_2066()
{
	var_00 = 20;
	var_01 = [];
	for(var_02 = 1;var_02 <= var_00;var_02++)
	{
		var_03 = tablelookup("maps/_intel_items.csv",0,var_02,4);
		if(isdefined(var_03) && var_03 != "undefined")
		{
			var_04 = strtok(var_03,",");
			for(var_05 = 0;var_05 < var_04.size;var_05++)
			{
				var_04[var_05] = int(var_04[var_05]);
			}

			var_01[var_02] = (var_04[0],var_04[1],var_04[2]);
			continue;
		}

		var_01[var_02] = undefined;
	}

	return var_01;
}

//Function Number: 10
award_intel()
{
	func_6A9F();
	updategamerprofileall();
	waittillframeend;
	func_6539();
}

//Function Number: 11
func_8A8A()
{
	self endon("end_trigger_thread");
	if(self.classname == "trigger_use")
	{
		self sethintstring(&"SCRIPT_RORKEFILE_PICKUP");
		self usetriggerrequirelookat();
	}

	thread func_8765();
	self waittill("hold_complete");
	self notify("end_loop_thread");
	func_4676(level.player);
	award_intel();
}

//Function Number: 12
func_8765()
{
	level.player.var_4297 = 0;
	while(level.player.var_4297 < 30 && isdefined(self))
	{
		level.player.var_4297 = 0;
		self stoploopsound("intelligence_pickup_loop");
		self waittill("trigger",var_00);
		self playloopsound("intelligence_pickup_loop");
		setdvar("ui_securing","intel");
		setdvar("ui_securing_progress",0);
		thread func_61D9();
		hold_count_check();
	}

	self notify("hold_complete");
	self stoploopsound("intelligence_pickup_loop");
	setdvar("ui_securing_progress",1);
	setdvar("ui_securing","");
}

//Function Number: 13
hold_count_check()
{
	self endon("stopped_pressing");
	while(isdefined(self) && isdefined(level.player))
	{
		if(level.player usebuttonpressed() && distance(level.player.origin,self.origin) < 128 && isalive(level.player))
		{
			level.player.var_4297++;
		}
		else
		{
			setdvar("ui_securing","");
			self stoploopsound("intelligence_pickup_loop");
			self notify("stopped_pressing");
		}

		if(level.player.var_4297 >= 30)
		{
			setdvar("ui_securing","");
			self notify("stopped_pressing");
			self stoploopsound("intelligence_pickup_loop");
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 14
func_61D9()
{
	self endon("stopped_pressing");
	var_00 = 30;
	var_01 = 8;
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		setdvar("ui_securing_progress",getdvarfloat("ui_securing_progress") + 1 / var_00);
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 15
func_4679(param_00,param_01)
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
		common_scripts\utility::func_8AFE();
	}

	param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
	param_01.label = "100";
	param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
}

//Function Number: 16
func_6A9F()
{
	foreach(var_01 in level.players)
	{
		if(var_01 getplayerintelisfound(self.var_576D))
		{
			continue;
		}

		var_01 setplayerintelfound(self.var_576D);
	}

	logstring("found intel item " + self.var_576D);
	maps\_endmission::updatesppercent();
}

//Function Number: 17
give_point()
{
	var_00 = self getlocalplayerprofiledata("cheatPoints");
	self setlocalplayerprofiledata("cheatPoints",var_00 + 1);
}

//Function Number: 18
func_4676(param_00)
{
	self.item hide();
	self.item notsolid();
	level thread common_scripts\utility::func_5D1F("intelligence_pickup",self.item.origin);
	var_01 = 3000;
	var_02 = 700;
	var_03 = var_01 + var_02 / 1000;
	foreach(var_05 in level.players)
	{
		if(param_00 != var_05 && var_05 getplayerintelisfound(self.var_576D))
		{
			continue;
		}

		var_06 = var_05 maps\_hud_util::func_20D1("objective",1.5);
		var_06.glowcolor = (0.7,0.7,0.3);
		var_06.glowalpha = 1;
		var_06 func_7168();
		var_06.y = -50;
		var_06 setpulsefx(60,var_01,var_02);
		var_07 = 0;
		if(param_00 == var_05 && var_05 getplayerintelisfound(self.var_576D))
		{
			var_06.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
		}
		else
		{
			var_06.label = &"SCRIPT_INTELLIGENCE_OF_EIGHTEEN";
			var_05 give_point();
			var_07 = var_05 getlocalplayerprofiledata("cheatPoints");
			var_06 setvalue(var_07);
		}

		if(var_07 == 18)
		{
			var_05 maps\_utility::func_5E13("EXT_1");
		}

		var_06 common_scripts\utility::delaycall(var_03,::destroy);
	}
}

//Function Number: 19
func_7168()
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

//Function Number: 20
assert_if_identical_origins()
{
	var_00 = [];
	for(var_01 = 1;var_01 < 65;var_01++)
	{
		var_02 = tablelookup("maps/_intel_items.csv",0,var_01,4);
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

//Function Number: 21
func_3915(param_00)
{
	for(var_01 = 1;var_01 < level.var_7E54.size + 1;var_01++)
	{
		if(!isdefined(level.var_7E54[var_01]))
		{
			continue;
		}

		if(distancesquared(param_00,level.var_7E54[var_01]) < squared(75))
		{
			return var_01;
		}
	}
}
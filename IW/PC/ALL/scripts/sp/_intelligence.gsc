/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_intelligence.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1053 ms
 * Timestamp: 10/27/2023 12:24:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachestring(&"SCRIPT_INTELLIGENCE_OF_EIGHTEEN");
	precachestring(&"SCRIPT_RORKEFILE_PREV_FOUND");
	precachestring(&"SCRIPT_RORKEFILE_PICKUP");
	precachestring(&"SCRIPT_INTELLIGENCE_PERCENT");
	precachestring(&"SCRIPT_INTELLIGENCE_UPLOADING");
	level.var_9953 = func_48A0();
	setdvar("ui_level_cheatpoints",level.var_9953.size);
	level.var_9950 = 0;
	setdvar("ui_level_player_cheatpoints",level.var_9950);
	level.var_113C7 = func_48A1();
	func_9858();
	func_995C();
}

//Function Number: 2
func_DFC0()
{
	foreach(var_01 in level.var_9953)
	{
		if(!isdefined(var_01.var_E0E2))
		{
			var_01 func_E041();
		}
	}
}

//Function Number: 3
func_E041()
{
	self.var_E0E2 = 1;
	self.var_195 hide();
	self.var_195 notsolid();
	scripts\common\utility::trigger_off();
	level.var_9950++;
	setdvar("ui_level_player_cheatpoints",level.var_9950);
	self notify("end_trigger_thread");
}

//Function Number: 4
func_9858()
{
	foreach(var_01 in level.var_9953)
	{
		var_02 = var_01.origin;
		var_01.var_C1D5 = func_7B42(var_02);
	}
}

//Function Number: 5
func_995C()
{
	foreach(var_01 in level.var_9953)
	{
		if(var_01 func_3DAD())
		{
			var_01 func_E041();
			continue;
		}

		var_01 thread func_135F5();
		var_01 thread func_D64F();
	}
}

//Function Number: 6
func_D64F()
{
	self endon("end_loop_thread");
	if(isdefined(self))
	{
		if(func_3DAD())
		{
			func_E041();
		}
	}
	else
	{
		return;
	}

	while(!func_3DAD())
	{
		wait(0.05);
	}

	func_E041();
}

//Function Number: 7
func_3DAD()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 method_8153(self.var_C1D5))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
func_48A0()
{
	var_00 = getentarray("intelligence_item","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].var_195 = getent(var_00[var_01].target,"targetname");
		var_00[var_01].var_7339 = 0;
	}

	return var_00;
}

//Function Number: 9
func_48A1()
{
	var_00 = 20;
	var_01 = [];
	for(var_02 = 1;var_02 <= var_00;var_02++)
	{
		var_03 = tablelookup("sp/intel_items.csv",0,var_02,4);
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
func_26CA()
{
	func_EB60();
	function_022A();
	waittillframeend;
	func_E041();
}

//Function Number: 11
func_135F5()
{
	self endon("end_trigger_thread");
	if(self.classname == "trigger_use")
	{
		self sethintstring(&"SCRIPT_RORKEFILE_PICKUP");
		self method_83D6(1);
	}

	thread func_12F84();
	self waittill("hold_complete");
	self notify("end_loop_thread");
	func_9952(level.player);
	func_26CA();
}

//Function Number: 12
func_12F84()
{
	level.player.var_906B = 0;
	while(level.player.var_906B < 30 && isdefined(self))
	{
		level.player.var_906B = 0;
		self stoploopsound("intelligence_pickup_loop");
		self waittill("trigger",var_00);
		self playloopsound("intelligence_pickup_loop");
		setdvar("ui_securing","intel");
		setdvar("ui_securing_progress",0);
		thread func_D9DA();
		func_906C();
	}

	self notify("hold_complete");
	self stoploopsound("intelligence_pickup_loop");
	setdvar("ui_securing_progress",1);
	setdvar("ui_securing","");
}

//Function Number: 13
func_906C()
{
	self endon("stopped_pressing");
	while(isdefined(self) && isdefined(level.player))
	{
		if(level.player usebuttonpressed() && distance(level.player.origin,self.origin) < 128 && isalive(level.player))
		{
			level.player.var_906B++;
		}
		else
		{
			setdvar("ui_securing","");
			self stoploopsound("intelligence_pickup_loop");
			self notify("stopped_pressing");
		}

		if(level.player.var_906B >= 30)
		{
			setdvar("ui_securing","");
			self notify("stopped_pressing");
			self stoploopsound("intelligence_pickup_loop");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
func_D9DA()
{
	self endon("stopped_pressing");
	var_00 = 30;
	var_01 = 8;
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		setdvar("ui_securing_progress",getdvarfloat("ui_securing_progress") + 1 / var_00);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 15
func_9961(param_00,param_01)
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
		scripts\common\utility::func_136F7();
	}

	param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
	param_01.label = "100";
	param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
}

//Function Number: 16
func_EB60()
{
	foreach(var_01 in level.players)
	{
		if(var_01 method_8153(self.var_C1D5))
		{
			continue;
		}

		var_01 method_8324(self.var_C1D5);
	}

	function_0132("found intel item " + self.var_C1D5);
	scripts\sp\_endmission::func_12F24();
}

//Function Number: 17
func_8322()
{
	var_00 = self method_8139("cheatPoints");
	self method_8302("cheatPoints",var_00 + 1);
}

//Function Number: 18
func_9952(param_00)
{
	self.var_195 hide();
	self.var_195 notsolid();
	function_0178("intelligence_pickup",self.var_195.origin);
	var_01 = 3000;
	var_02 = 700;
	var_03 = var_01 + var_02 / 1000;
	foreach(var_05 in level.players)
	{
		if(param_00 != var_05 && var_05 method_8153(self.var_C1D5))
		{
			continue;
		}

		var_06 = var_05 scripts\sp\_hud_util::func_4999("objective",1.5);
		var_06.var_154 = (0.7,0.7,0.3);
		var_06.var_153 = 1;
		var_06 func_F99F();
		var_06.y = -50;
		var_06 setpulsefx(60,var_01,var_02);
		var_07 = 0;
		if(param_00 == var_05 && var_05 method_8153(self.var_C1D5))
		{
			var_06.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
		}
		else
		{
			var_06.label = &"SCRIPT_INTELLIGENCE_OF_EIGHTEEN";
			var_05 func_8322();
			var_07 = var_05 method_8139("cheatPoints");
			var_06 setvalue(var_07);
		}

		if(var_07 == 18)
		{
			var_05 scripts\sp\_utility::func_D0A1("EXT_1");
		}

		var_06 scripts\common\utility::delaycall(var_03,::destroy);
	}
}

//Function Number: 19
func_F99F()
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
func_23AF()
{
	var_00 = [];
	for(var_01 = 1;var_01 < 65;var_01++)
	{
		var_02 = tablelookup("sp/intel_items.csv",0,var_01,4);
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
func_7B42(param_00)
{
	for(var_01 = 1;var_01 < level.var_113C7.size + 1;var_01++)
	{
		if(!isdefined(level.var_113C7[var_01]))
		{
			continue;
		}

		if(distancesquared(param_00,level.var_113C7[var_01]) < squared(75))
		{
			return var_01;
		}
	}
}
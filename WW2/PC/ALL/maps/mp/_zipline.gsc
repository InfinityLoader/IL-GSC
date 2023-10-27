/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_zipline.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 219 ms
 * Timestamp: 10/27/2023 3:22:17 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	var_00 = [];
	var_01 = getentarray("zipline","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = maps\mp\gametypes\_gameobjects::func_2837("neutral",var_01[var_02],var_00,(0,0,0));
		var_03 maps\mp\gametypes\_gameobjects::func_C30("any");
		var_03 maps\mp\gametypes\_gameobjects::func_8A5A(0.25);
		var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_8A57(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_8A60("any");
		var_03.var_6ABC = ::func_6ABC;
		var_03.var_6BBF = ::func_6BBF;
		var_04 = [];
		var_05 = getent(var_01[var_02].var_1A2,"targetname");
		if(!isdefined(var_05))
		{
		}

		while(isdefined(var_05))
		{
			var_04[var_04.size] = var_05;
			if(isdefined(var_05.var_1A2))
			{
				var_05 = getent(var_05.var_1A2,"targetname");
				continue;
			}

			break;
		}

		var_03.var_9835 = var_04;
	}

	precachemodel("tag_player");
	func_51C7();
}

//Function Number: 2
func_6ABC(param_00)
{
	param_00 method_8617("scrambler_pullout_lift_plr");
}

//Function Number: 3
func_6BBF(param_00)
{
	param_00 thread func_AAF8(self);
}

//Function Number: 4
func_AAF8(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("zipline_drop");
	level endon("game_ended");
	var_01 = spawn("script_origin",param_00.var_9D65.var_116);
	var_01.var_116 = param_00.var_9D65.var_116;
	var_01.var_1D = self.var_1D;
	var_01 setmodel("tag_player");
	self playerlinktodelta(var_01,"tag_player",1,180,180,180,180);
	thread func_A8F9(var_01);
	thread func_A8FF(var_01);
	var_02 = param_00.var_9835;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = distance(var_01.var_116,var_02[var_03].var_116) / 600;
		var_05 = 0;
		if(var_03 == 0)
		{
			var_05 = var_04 * 0.2;
		}

		var_01 moveto(var_02[var_03].var_116,var_04,var_05);
		if(var_01.var_1D != var_02[var_03].var_1D)
		{
			var_01 rotateto(var_02[var_03].var_1D,var_04 * 0.8);
		}

		wait(var_04);
	}

	self notify("destination");
	self unlink();
	var_01 delete();
}

//Function Number: 5
func_A8FF(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("destination");
	level endon("game_ended");
	self notifyonplayercommand("zipline_drop","+gostand");
	self waittill("zipline_drop");
	self unlink();
	param_00 delete();
}

//Function Number: 6
func_A8F9(param_00)
{
	self endon("disconnect");
	self endon("destination");
	self endon("zipline_drop");
	level endon("game_ended");
	self waittill("death");
	self unlink();
	param_00 delete();
}

//Function Number: 7
func_51C7()
{
	var_00 = [];
	var_01 = getentarray("elevator_button","targetname");
	level.var_35B3 = spawnstruct();
	level.var_35B3.var_5E55 = "floor1";
	level.var_35B3.var_932D = [];
	level.var_35B3.var_932D["elevator"] = "closed";
	level.var_35B3.var_2DAC = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = maps\mp\gametypes\_gameobjects::func_2837("neutral",var_01[var_02],var_00,(0,0,0));
		var_03 maps\mp\gametypes\_gameobjects::func_C30("any");
		var_03 maps\mp\gametypes\_gameobjects::func_8A5A(0.25);
		var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_8A57(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_8A60("any");
		var_03.var_6ABC = ::func_6ABD;
		var_03.var_6BBF = ::func_6BC0;
		var_03.var_5E55 = var_01[var_02].var_81E8;
		level.var_35B3.var_932D[var_01[var_02].var_81E8] = "closed";
		if(isdefined(var_01[var_02].var_1A2))
		{
			var_04 = common_scripts\utility::func_46B5(var_01[var_02].var_1A2,"targetname");
			if(isdefined(var_04))
			{
				level.var_35B3.var_2DAC[var_01[var_02].var_81E8] = var_04;
			}
		}
	}
}

//Function Number: 8
func_6ABD(param_00)
{
}

//Function Number: 9
func_6BC0(param_00)
{
	switch(self.var_5E55)
	{
		case "floor1":
			if(level.var_35B3.var_932D["floor1"] == "closed")
			{
				if(level.var_35B3.var_5E55 == "floor1")
				{
					if(level.var_35B3.var_932D["elevator"] == "closed")
					{
						level thread func_6BE1("floor1");
						level thread func_6BE1("elevator");
					}
				}
				else if(level.var_35B3.var_5E55 == "floor2")
				{
					if(level.var_35B3.var_932D["elevator"] == "opened")
					{
						level notify("stop_autoClose");
						level thread func_242F("floor2");
						level func_242F("elevator");
					}
	
					if(level.var_35B3.var_932D["elevator"] == "closed")
					{
						level func_646F();
						level thread func_6BE1("floor1");
						level thread func_6BE1("elevator");
					}
				}
			}
			break;

		case "floor2":
			if(level.var_35B3.var_932D["floor2"] == "closed")
			{
				if(level.var_35B3.var_5E55 == "floor2")
				{
					if(level.var_35B3.var_932D["elevator"] == "closed")
					{
						level thread func_6BE1("floor2");
						level thread func_6BE1("elevator");
					}
				}
				else if(level.var_35B3.var_5E55 == "floor1")
				{
					if(level.var_35B3.var_932D["elevator"] == "opened")
					{
						level notify("stop_autoClose");
						level thread func_242F("floor1");
						level func_242F("elevator");
					}
	
					if(level.var_35B3.var_932D["elevator"] == "closed")
					{
						level func_646F();
						level thread func_6BE1("floor2");
						level thread func_6BE1("elevator");
					}
				}
			}
			break;

		case "elevator":
			if(level.var_35B3.var_932D["elevator"] == "opened")
			{
				level notify("stop_autoClose");
				level thread func_242F(level.var_35B3.var_5E55);
				level func_242F("elevator");
			}
	
			if(level.var_35B3.var_932D["elevator"] == "closed")
			{
				level func_646F();
				level thread func_6BE1(level.var_35B3.var_5E55);
				level thread func_6BE1("elevator");
			}
			break;
	}
}

//Function Number: 10
func_6BE1(param_00)
{
	level.var_35B3.var_932D[param_00] = "opening";
	var_01 = getent("e_door_" + param_00 + "_left","targetname");
	var_02 = getent("e_door_" + param_00 + "_right","targetname");
	if(isdefined(var_01.var_165) && var_01.var_165 == "fahrenheit")
	{
		var_01 moveto(var_01.var_116 - anglestoforward(var_01.var_1D) * 35,2);
		var_02 moveto(var_02.var_116 + anglestoforward(var_02.var_1D) * 35,2);
		var_01 method_8617("elev_door_open");
	}
	else
	{
		var_01 moveto(var_01.var_116 - anglestoright(var_01.var_1D) * 35,2);
		var_02 moveto(var_02.var_116 + anglestoright(var_02.var_1D) * 35,2);
	}

	wait(2);
	level.var_35B3.var_932D[param_00] = "opened";
	if(param_00 == "elevator")
	{
		level thread func_1386();
	}
}

//Function Number: 11
func_242F(param_00)
{
	level.var_35B3.var_932D[param_00] = "closing";
	var_01 = getent("e_door_" + param_00 + "_left","targetname");
	var_02 = getent("e_door_" + param_00 + "_right","targetname");
	if(isdefined(var_01.var_165) && var_01.var_165 == "fahrenheit")
	{
		var_01 moveto(var_01.var_116 + anglestoforward(var_01.var_1D) * 35,2);
		var_02 moveto(var_02.var_116 - anglestoforward(var_02.var_1D) * 35,2);
		var_01 method_8617("elev_door_close");
	}
	else
	{
		var_01 moveto(var_01.var_116 + anglestoright(var_01.var_1D) * 35,2);
		var_02 moveto(var_02.var_116 - anglestoright(var_02.var_1D) * 35,2);
	}

	wait(2);
	level.var_35B3.var_932D[param_00] = "closed";
}

//Function Number: 12
func_1386()
{
	level endon("stop_autoClose");
	wait(10);
	level thread func_242F(level.var_35B3.var_5E55);
	level thread func_242F("elevator");
}

//Function Number: 13
func_646F()
{
	level.var_35B3.var_932D["elevator"] = "moving";
	var_00 = getent("e_door_elevator_left","targetname");
	var_01 = getent("e_door_elevator_right","targetname");
	var_02 = getent("elevator","targetname");
	if(level.var_35B3.var_5E55 == "floor1")
	{
		level.var_35B3.var_5E55 = "floor2";
		var_03 = var_00.var_116[2] - level.var_35B3.var_2DAC["floor1"].var_116[2];
		var_00 moveto((var_00.var_116[0],var_00.var_116[1],level.var_35B3.var_2DAC["floor2"].var_116[2] + var_03),5);
		var_03 = var_01.var_116[2] - level.var_35B3.var_2DAC["floor1"].var_116[2];
		var_01 moveto((var_01.var_116[0],var_01.var_116[1],level.var_35B3.var_2DAC["floor2"].var_116[2] + var_03),5);
		var_02 moveto(level.var_35B3.var_2DAC["floor2"].var_116,5);
	}
	else
	{
		level.var_35B3.var_5E55 = "floor1";
		var_03 = var_01.var_116[2] - level.var_35B3.var_2DAC["floor2"].var_116[2];
		var_00 moveto((var_00.var_116[0],var_00.var_116[1],level.var_35B3.var_2DAC["floor1"].var_116[2] + var_03),5);
		var_03 = var_01.var_116[2] - level.var_35B3.var_2DAC["floor2"].var_116[2];
		var_01 moveto((var_01.var_116[0],var_01.var_116[1],level.var_35B3.var_2DAC["floor1"].var_116[2] + var_03),5);
		var_02 moveto(level.var_35B3.var_2DAC["floor1"].var_116,5);
	}

	wait(5);
	var_02 method_8617("elev_bell_ding");
	level.var_35B3.var_932D["elevator"] = "closed";
}
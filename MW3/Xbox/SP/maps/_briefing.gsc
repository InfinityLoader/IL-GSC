/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_briefing.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 261 ms
 * Timestamp: 10/27/2023 2:34:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	setsaveddvar("hud_drawhud",0);
	level.script = tolower(getdvar("mapname"));
	if(!isdefined(level.var_3B51))
	{
		level.var_3B51 = [];
	}

	var_00 = getentarray("player","classname")[0];
	setsaveddvar("g_speed",0);
	var_00 setviewmodel("viewmodel_hands_cloth");
	precacheshader("black");
	var_01 = 0;
	for(var_02 = 0;var_02 < level.slide.size;var_02++)
	{
		if(isdefined(level.slide[var_02]["movie"]))
		{
			var_01 = 1;
			break;
		}
	}

	if(var_01)
	{
		wait 0.05;
		var_00 func_3B68(0);
		return;
	}

	precachestring(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");
	for(var_03 = 0;var_03 < level.slide.size;var_03++)
	{
		if(isdefined(level.slide[var_03]["image"]))
		{
			precacheshader(level.slide[var_03]["image"]);
		}
	}

	var_00 thread skipthebriefing();
	var_00 dothebriefing();
	var_00 func_3B68(0);
}

//Function Number: 2
start(param_00)
{
	level.var_3B53 = 1;
	level.var_3B54 = 0;
	level.var_3B55 = "A";
	if(isdefined(level.imagea))
	{
		level.imagea destroy();
	}

	if(isdefined(level.var_3B57))
	{
		level.var_3B57 destroy();
	}

	if(isdefined(level.var_3B58))
	{
		level.var_3B58 destroy();
	}

	if(isdefined(level.var_3B59))
	{
		level.var_3B59 destroy();
	}

	if(!isdefined(param_00) || !param_00)
	{
		level.var_3B5A = 0.5;
		level.briefing_fadeouttime = 0.5;
	}
	else
	{
		level.var_3B5A = param_00;
		level.briefing_fadeouttime = param_00;
	}

	self endon("briefingskip");
	thread func_3B60();
	level.var_3B58 = newhudelem();
	level.var_3B58.sort = -1;
	level.var_3B58.alignx = "left";
	level.var_3B58.aligny = "top";
	level.var_3B58.x = 0;
	level.var_3B58.y = 0;
	level.var_3B58.horzalign = "fullscreen";
	level.var_3B58.vertalign = "fullscreen";
	level.var_3B58.foreground = 1;
	level.var_3B58.alpha = 1;
	level.var_3B58 setshader("black",640,480);
	level.var_3B59 = newhudelem();
	level.var_3B59.sort = 1;
	level.var_3B59.alignx = "center";
	level.var_3B59.aligny = "top";
	level.var_3B59.fontscale = 2;
	level.var_3B59.x = 0;
	level.var_3B59.y = 60;
	level.var_3B59.horzalign = "center";
	level.var_3B59.vertalign = "fullscreen";
	level.var_3B59.foreground = 1;
	level.var_3B59 settext(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");
	level.var_3B59.alpha = 0;
	thread fadeinfiretoskip();
	level.imagea = newhudelem();
	level.imagea.alignx = "center";
	level.imagea.aligny = "middle";
	level.imagea.x = 320;
	level.imagea.y = 240;
	level.imagea.alpha = 0;
	level.imagea.horzalign = "fullscreen";
	level.imagea.vertalign = "fullscreen";
	level.imagea setshader("black",640,360);
	level.imagea.foreground = 1;
	level.var_3B57 = newhudelem();
	level.var_3B57.alignx = "center";
	level.var_3B57.aligny = "middle";
	level.var_3B57.x = 320;
	level.var_3B57.y = 240;
	level.var_3B57.horzalign = "fullscreen";
	level.var_3B57.vertalign = "fullscreen";
	level.var_3B57.alpha = 0;
	level.var_3B57 setshader("black",640,360);
	level.var_3B57.foreground = 1;
	self freezecontrols(1);
	wait 0.5;
	for(var_01 = 0;var_01 < level.slide.size;var_01++)
	{
		var_02 = 0;
		if(isdefined(level.slide[var_01]["image"]))
		{
			if(level.script[0] != "m")
			{
				soundplay("slide_advance");
			}

			wait 0.5;
			thread func_3B61(level.slide[var_01]["image"]);
		}

		if(isdefined(level.slide[var_01]["dialog_wait"]) && self.var_3B5C[level.slide[var_01]["dialog_wait"]])
		{
			self waittill(level.slide[var_01]["dialog_wait"] + "sounddone");
		}

		if(isdefined(level.slide[var_01]["dialog"]))
		{
			soundplay(level.slide[var_01]["dialog"],level.slide[var_01]["dialog"] + "sounddone");
			var_02 = 1;
		}

		if(isdefined(level.slide[var_01]["delay"]))
		{
			wait level.slide[var_01]["delay"];
			continue;
		}

		if(var_02)
		{
			self waittill(level.slide[var_01]["dialog"] + "sounddone");
		}
	}
}

//Function Number: 3
fadeinfiretoskip()
{
	wait 1;
	thread fadefiretoskip();
	level.var_3B59 fadeovertime(level.briefing_fadeouttime);
	level.var_3B59.alpha = 1;
}

//Function Number: 4
fadefiretoskip()
{
	wait 7;
	level.var_3B59 fadeovertime(level.briefing_fadeouttime);
	level.var_3B59.alpha = 0;
}

//Function Number: 5
waittillbriefingdone()
{
	self waittill("briefingend");
}

//Function Number: 6
func_3B60()
{
	self endon("briefingend");
	var_00 = getentarray("player","classname")[0];
	wait 0.05;
	maps\_utility::set_console_status();
	for(;;)
	{
		if(level.console)
		{
			if(var_00 buttonpressed("BUTTON_A"))
			{
				self notify("briefingskip");
				func_1001();
				return;
			}

			wait 0.05;
			continue;
		}

		if(var_00 attackbuttonpressed())
		{
			self notify("briefingskip");
			func_1001();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 7
func_3B61(param_00)
{
	self endon("briefingskip");
	if(level.var_3B55 == "A")
	{
		level.var_3B55 = "B";
		level.imagea setshader(param_00,640,360);
		thread imagefadeout("B");
		level.imagea fadeovertime(level.var_3B5A);
		level.imagea.alpha = 1;
		return;
	}

	if(level.var_3B55 == "B")
	{
		level.var_3B55 = "A";
		level.var_3B57 setshader(param_00,640,360);
		thread imagefadeout("A");
		level.var_3B57 fadeovertime(level.var_3B5A);
		level.var_3B57.alpha = 1;
	}
}

//Function Number: 8
imagefadeout(param_00)
{
	if(param_00 == "A")
	{
		level.imagea fadeovertime(level.briefing_fadeouttime);
		level.imagea.alpha = 0;
		return;
	}

	if(param_00 == "B")
	{
		level.var_3B57 fadeovertime(level.briefing_fadeouttime);
		level.var_3B57.alpha = 0;
	}
}

//Function Number: 9
endthread()
{
	if(!level.var_3B53)
	{
		return;
	}

	if(level.var_3B54)
	{
		return;
	}

	self notify("briefingend");
	level.var_3B54 = 1;
	if(level.script[0] != "m")
	{
		self playsound("stop_voice");
	}

	thread imagefadeout("A");
	thread imagefadeout("B");
	wait 1.5;
	level.var_3B54 = 0;
}

//Function Number: 10
func_1001()
{
	thread endthread();
}

//Function Number: 11
soundplay(param_00,param_01)
{
	if(isdefined(level.var_3B51[param_00]))
	{
		iprintlnbold(level.var_3B51[param_00]);
	}

	if(isdefined(param_01))
	{
		thread soundplay_flag(param_00,param_01);
		self playsound(param_00,param_01);
		return;
	}

	self playsound(param_00);
}

//Function Number: 12
soundplay_flag(param_00,param_01)
{
	self.var_3B5C[param_00] = 1;
	self waittill(param_01);
	self.var_3B5C[param_00] = 0;
}

//Function Number: 13
dothebriefing()
{
	start(0.5);
	if(level.script[0] != "m")
	{
		soundplay("slide_advance");
	}

	wait 0.5;
	func_1001();
}

//Function Number: 14
skipthebriefing()
{
	self waittill("briefingskip");
	func_3B68(1);
}

//Function Number: 15
func_3B68(param_00)
{
	if(!param_00)
	{
		for(var_01 = 0;var_01 < level.slide.size;var_01++)
		{
			if(isdefined(level.slide[var_01]["movie"]))
			{
				cinematic(level.slide[var_01]["movie"]);
			}
		}
	}

	changelevel(level.var_3B69,0);
}
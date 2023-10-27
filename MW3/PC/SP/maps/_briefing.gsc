/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_briefing.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 179 ms
 * Timestamp: 10/27/2023 2:20:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	setsaveddvar("hud_drawhud",0);
	level.script = tolower(getdvar("mapname"));
	if(!isdefined(level.tmpmsg))
	{
		level.tmpmsg = [];
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
		var_00 gotothelevel(0);
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
	var_00 gotothelevel(0);
}

//Function Number: 2
start(param_00)
{
	level.briefing_running = 1;
	level.briefing_ending = 0;
	level.placenextimage = "A";
	if(isdefined(level.imagea))
	{
		level.imagea destroy();
	}

	if(isdefined(level.imageb))
	{
		level.imageb destroy();
	}

	if(isdefined(level.blackscreen))
	{
		level.blackscreen destroy();
	}

	if(isdefined(level.firetoskip))
	{
		level.firetoskip destroy();
	}

	if(!isdefined(param_00) || !param_00)
	{
		level.briefing_fadeintime = 0.5;
		level.briefing_fadeouttime = 0.5;
	}
	else
	{
		level.briefing_fadeintime = param_00;
		level.briefing_fadeouttime = param_00;
	}

	self endon("briefingskip");
	thread skipcheck();
	level.blackscreen = newhudelem();
	level.blackscreen.sort = -1;
	level.blackscreen.alignx = "left";
	level.blackscreen.aligny = "top";
	level.blackscreen.x = 0;
	level.blackscreen.y = 0;
	level.blackscreen.horzalign = "fullscreen";
	level.blackscreen.vertalign = "fullscreen";
	level.blackscreen.foreground = 1;
	level.blackscreen.alpha = 1;
	level.blackscreen setshader("black",640,480);
	level.firetoskip = newhudelem();
	level.firetoskip.sort = 1;
	level.firetoskip.alignx = "center";
	level.firetoskip.aligny = "top";
	level.firetoskip.fontscale = 2;
	level.firetoskip.x = 0;
	level.firetoskip.y = 60;
	level.firetoskip.horzalign = "center";
	level.firetoskip.vertalign = "fullscreen";
	level.firetoskip.foreground = 1;
	level.firetoskip settext(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");
	level.firetoskip.alpha = 0;
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
	level.imageb = newhudelem();
	level.imageb.alignx = "center";
	level.imageb.aligny = "middle";
	level.imageb.x = 320;
	level.imageb.y = 240;
	level.imageb.horzalign = "fullscreen";
	level.imageb.vertalign = "fullscreen";
	level.imageb.alpha = 0;
	level.imageb setshader("black",640,360);
	level.imageb.foreground = 1;
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
			thread image(level.slide[var_01]["image"]);
		}

		if(isdefined(level.slide[var_01]["dialog_wait"]) && self.dialogplaying[level.slide[var_01]["dialog_wait"]])
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
	level.firetoskip fadeovertime(level.briefing_fadeouttime);
	level.firetoskip.alpha = 1;
}

//Function Number: 4
fadefiretoskip()
{
	wait 7;
	level.firetoskip fadeovertime(level.briefing_fadeouttime);
	level.firetoskip.alpha = 0;
}

//Function Number: 5
waittillbriefingdone()
{
	self waittill("briefingend");
}

//Function Number: 6
skipcheck()
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
				end();
				return;
			}

			wait 0.05;
			continue;
		}

		if(var_00 attackbuttonpressed())
		{
			self notify("briefingskip");
			end();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 7
image(param_00)
{
	self endon("briefingskip");
	if(level.placenextimage == "A")
	{
		level.placenextimage = "B";
		level.imagea setshader(param_00,640,360);
		thread imagefadeout("B");
		level.imagea fadeovertime(level.briefing_fadeintime);
		level.imagea.alpha = 1;
		return;
	}

	if(level.placenextimage == "B")
	{
		level.placenextimage = "A";
		level.imageb setshader(param_00,640,360);
		thread imagefadeout("A");
		level.imageb fadeovertime(level.briefing_fadeintime);
		level.imageb.alpha = 1;
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
		level.imageb fadeovertime(level.briefing_fadeouttime);
		level.imageb.alpha = 0;
	}
}

//Function Number: 9
endthread()
{
	if(!level.briefing_running)
	{
		return;
	}

	if(level.briefing_ending)
	{
		return;
	}

	self notify("briefingend");
	level.briefing_ending = 1;
	if(level.script[0] != "m")
	{
		self playsound("stop_voice");
	}

	thread imagefadeout("A");
	thread imagefadeout("B");
	wait 1.5;
	level.briefing_ending = 0;
}

//Function Number: 10
end()
{
	thread endthread();
}

//Function Number: 11
soundplay(param_00,param_01)
{
	if(isdefined(level.tmpmsg[param_00]))
	{
		iprintlnbold(level.tmpmsg[param_00]);
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
	self.dialogplaying[param_00] = 1;
	self waittill(param_01);
	self.dialogplaying[param_00] = 0;
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
	end();
}

//Function Number: 14
skipthebriefing()
{
	self waittill("briefingskip");
	gotothelevel(1);
}

//Function Number: 15
gotothelevel(param_00)
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

	changelevel(level.leveltoload,0);
}
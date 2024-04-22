/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _credits.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 492 ms
 * Timestamp: 4/22/2024 2:20:31 AM
*******************************************************************/

//Function Number: 1
initcredits(param_00)
{
	common_scripts\utility::flag_init("atvi_credits_go");
	level.linesize = 1.35;
	level.headingsize = 1.75;
	level.linelist = [];
	level.credits_speed = 20.25;
	level.credits_spacing = -120;
	maps\_utility::set_console_status();
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	switch(param_00)
	{
		case "iw":
			maps\_credits_autogen::initiw6credits();
			break;

		case "atvi":
			break;

		case "all":
			maps\_credits_autogen::initiw6credits();
			break;
	}

	end_logos();
}

//Function Number: 2
addlefttitle(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "lefttitle";
	var_02.title = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 3
addleftname(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "leftname";
	var_02.name = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 4
addsublefttitle(param_00,param_01)
{
	addleftname(param_00,param_01);
}

//Function Number: 5
addsubleftname(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "subleftname";
	var_02.name = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 6
addrighttitle(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "righttitle";
	var_02.title = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 7
addrightname(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "rightname";
	var_02.name = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 8
addcenterheading(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "centerheading";
	var_02.heading = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 9
addcentersubtitle(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "centersubtitle";
	var_02.heading = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 10
addcastname(param_00,param_01,param_02)
{
	precachestring(param_01);
	precachestring(param_00);
	if(!isdefined(param_02))
	{
		param_02 = level.linesize;
	}

	var_03 = spawnstruct();
	var_03.type = "castname";
	var_03.title = param_01;
	var_03.name = param_00;
	var_03.textscale = param_02;
	level.linelist[level.linelist.size] = var_03;
}

//Function Number: 11
addcentername(param_00,param_01)
{
	precachestring(param_00);
	if(!isdefined(param_01))
	{
		param_01 = level.linesize;
	}

	var_02 = spawnstruct();
	var_02.type = "centername";
	var_02.name = param_00;
	var_02.textscale = param_01;
	level.linelist[level.linelist.size] = var_02;
}

//Function Number: 12
addcenternamedouble(param_00,param_01,param_02)
{
	precachestring(param_00);
	precachestring(param_01);
	if(!isdefined(param_02))
	{
		param_02 = level.linesize;
	}

	var_03 = spawnstruct();
	var_03.type = "centernamedouble";
	var_03.name1 = param_00;
	var_03.name2 = param_01;
	var_03.textscale = param_02;
	level.linelist[level.linelist.size] = var_03;
}

//Function Number: 13
addcenterdual(param_00,param_01,param_02)
{
	precachestring(param_00);
	precachestring(param_01);
	if(!isdefined(param_02))
	{
		param_02 = level.linesize;
	}

	var_03 = spawnstruct();
	var_03.type = "centerdual";
	var_03.title = param_00;
	var_03.name = param_01;
	var_03.textscale = param_02;
	level.linelist[level.linelist.size] = var_03;
}

//Function Number: 14
addcentertriple(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = "centertriple";
	if(isdefined(param_00))
	{
		precachestring(param_00);
		var_04.name1 = param_00;
	}
	else
	{
		var_04.name1 = "";
	}

	if(isdefined(param_01))
	{
		precachestring(param_01);
		var_04.name2 = param_01;
	}
	else
	{
		var_04.name2 = "";
	}

	if(isdefined(param_02))
	{
		precachestring(param_02);
		var_04.name3 = param_02;
	}
	else
	{
		var_04.name3 = "";
	}

	if(!isdefined(param_03))
	{
		param_03 = level.linesize;
	}

	var_04.textscale = param_03;
	level.linelist[level.linelist.size] = var_04;
}

//Function Number: 15
addspace()
{
	var_00 = spawnstruct();
	var_00.type = "space";
	level.linelist[level.linelist.size] = var_00;
}

//Function Number: 16
addspacesmall()
{
	var_00 = spawnstruct();
	var_00.type = "spacesmall";
	level.linelist[level.linelist.size] = var_00;
}

//Function Number: 17
addcenterimage(param_00,param_01,param_02,param_03)
{
	precacheshader(param_00);
	var_04 = spawnstruct();
	var_04.type = "centerimage";
	var_04.image = param_00;
	var_04.width = param_01;
	var_04.height = param_02;
	var_04.sort = 2;
	if(isdefined(param_03))
	{
		var_04.delay = param_03;
	}

	level.linelist[level.linelist.size] = var_04;
}

//Function Number: 18
playcredits()
{
	level.player endon("stop_credits");
	visionsetnaked("",0);
	setsaveddvar("cl_disable_pause","1");
	var_00 = "credits_black";
	soundscripts\_snd::snd_message("play_credits");
	var_01 = getdvarint("loc_language",0);
	var_02 = 1;
	if(var_01 == 10 || var_01 == 5)
	{
		var_02 = 0.75;
	}

	for(var_03 = 0;var_03 < level.linelist.size;var_03++)
	{
		var_04 = 0.5;
		var_05 = level.linelist[var_03].type;
		if(var_05 == "centerimage")
		{
			if(isdefined(var_00) && var_00 != "credits_black")
			{
				common_scripts\utility::flag_wait("atvi_credits_go");
			}

			var_06 = level.linelist[var_03].image;
			var_07 = level.linelist[var_03].width;
			var_08 = level.linelist[var_03].height;
			var_09 = newhudelem();
			var_09 setshader(var_06,var_07,var_08);
			var_09.alignx = "center";
			var_09.horzalign = "center";
			var_09.x = 0;
			var_09.y = 480;
			var_09.sort = 2;
			var_09.foreground = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
			if(isdefined(level.linelist[var_03].delay))
			{
				var_04 = level.linelist[var_03].delay;
			}
			else
			{
				var_04 = 0.037 * var_08;
			}
		}
		else if(var_05 == "leftimage")
		{
			var_06 = level.linelist[var_03].image;
			var_07 = level.linelist[var_03].width;
			var_08 = level.linelist[var_03].height;
			var_09 = newhudelem();
			var_09 setshader(var_06,var_07,var_08);
			var_09.alignx = "center";
			var_09.horzalign = "left";
			var_09.x = 128;
			var_09.y = 480;
			var_09.sort = 2;
			var_09.foreground = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_04 = 0.037 * var_08;
		}
		else if(var_05 == "lefttitle")
		{
			var_0A = level.linelist[var_03].title;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0A);
			var_09.alignx = "left";
			var_09.horzalign = "left";
			var_09.x = 28;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_09 thread pulse_fx();
		}
		else if(var_05 == "leftname")
		{
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			if(var_01 == 10 || var_01 == 5)
			{
				var_0B = var_0B * 0.5;
			}

			var_09 = newhudelem();
			var_09 settext(var_0C);
			var_09.alignx = "left";
			var_09.horzalign = "left";
			var_09.x = 60;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_09 thread pulse_fx();
		}
		else if(var_05 == "castname")
		{
			var_0A = level.linelist[var_03].title;
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_0D = newhudelem();
			var_0D settext(var_0A);
			var_0D.alignx = "left";
			var_0D.horzalign = "left";
			var_0D.x = 60;
			var_0D.y = 480;
			if(!level.console)
			{
				var_0D.font = "default";
			}
			else
			{
				var_0D.font = "small";
			}

			var_0D.fontscale = var_0B;
			var_0D.sort = 2;
			var_0D.glowcolor = (0.8,0.8,0.8);
			var_0D.glowalpha = 1;
			var_0E = newhudelem();
			var_0E settext(var_0C);
			var_0E.alignx = "right";
			var_0E.horzalign = "left";
			var_0E.x = 275;
			var_0E.y = 480;
			if(!level.console)
			{
				var_0E.font = "default";
			}
			else
			{
				var_0E.font = "small";
			}

			var_0E.fontscale = var_0B;
			var_0E.sort = 2;
			var_0E.glowcolor = (0.8,0.8,0.8);
			var_0E.glowalpha = 1;
			var_0D thread delaydestroy(level.credits_speed);
			var_0D moveovertime(level.credits_speed);
			var_0D.y = level.credits_spacing;
			var_0E thread delaydestroy(level.credits_speed);
			var_0E moveovertime(level.credits_speed);
			var_0E.y = level.credits_spacing;
			var_0D thread pulse_fx();
			var_0E thread pulse_fx();
		}
		else if(var_05 == "subleftname")
		{
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			if(var_01 == 10 || var_01 == 5)
			{
				var_0B = var_0B * 0.5;
			}

			var_09 = newhudelem();
			var_09 settext(var_0C);
			var_09.alignx = "left";
			var_09.horzalign = "left";
			var_09.x = 92;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_09 thread pulse_fx();
		}
		else if(var_05 == "righttitle")
		{
			var_0A = level.linelist[var_03].title;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0A);
			var_09.alignx = "left";
			var_09.horzalign = "right";
			var_09.x = -132;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
		}
		else if(var_05 == "rightname")
		{
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0C);
			var_09.alignx = "left";
			var_09.horzalign = "right";
			var_09.x = -100;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
		}
		else if(var_05 == "centerheading")
		{
			var_0F = level.linelist[var_03].heading;
			var_0B = level.linelist[var_03].textscale * 1.2 * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0F);
			var_09.alignx = "center";
			var_09.horzalign = "center";
			var_09.x = 0;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "objective";
			}
			else
			{
				var_09.font = "objective";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.color = (1,0.93,0.44);
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 0.5;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09 thread delayfade(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_04 = var_04 * 1.2;
		}
		else if(var_05 == "centersubtitle")
		{
			var_0F = level.linelist[var_03].heading;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0F);
			var_09.alignx = "center";
			var_09.horzalign = "center";
			var_09.x = 0;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "big";
			}
			else
			{
				var_09.font = "big";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.color = (1,0.93,0.44);
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 0.5;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09 thread delayfade(level.credits_speed);
			var_09.y = level.credits_spacing;
			var_04 = var_04 * 1.1;
		}
		else if(var_05 == "centerdual")
		{
			var_0A = level.linelist[var_03].title;
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_0D = newhudelem();
			var_0D settext(var_0A);
			var_0D.alignx = "right";
			var_0D.horzalign = "center";
			var_0D.x = -4;
			var_0D.y = 480;
			if(!level.console)
			{
				var_0D.font = "small";
			}
			else
			{
				var_0D.font = "small";
			}

			var_0D.fontscale = var_0B;
			var_0D.sort = 2;
			var_0D.glowcolor = (0.6,0.6,0.6);
			var_0D.glowalpha = 0;
			var_0E = newhudelem();
			var_0E settext(var_0C);
			var_0E.alignx = "left";
			var_0E.horzalign = "center";
			var_0E.x = 4;
			var_0E.y = 480;
			if(!level.console)
			{
				var_0E.font = "small";
			}
			else
			{
				var_0E.font = "small";
			}

			var_0E.fontscale = var_0B;
			var_0E.sort = 2;
			var_0E.glowcolor = (0.6,0.6,0.6);
			var_0E.glowalpha = 0;
			var_0D thread delaydestroy(level.credits_speed);
			var_0D moveovertime(level.credits_speed);
			var_0D thread delayfade(level.credits_speed - 0.3);
			var_0D.y = level.credits_spacing;
			var_0E thread delaydestroy(level.credits_speed);
			var_0E moveovertime(level.credits_speed);
			var_0E thread delayfade(level.credits_speed);
			var_0E.y = level.credits_spacing;
		}
		else if(var_05 == "centertriple")
		{
			var_10 = level.linelist[var_03].name1;
			var_11 = level.linelist[var_03].name2;
			var_12 = level.linelist[var_03].name3;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_0D = newhudelem();
			var_0D settext(var_10);
			var_0D.alignx = "left";
			var_0D.horzalign = "center";
			var_0D.x = -220;
			var_0D.y = 480;
			if(!level.console)
			{
				var_0D.font = "small";
			}
			else
			{
				var_0D.font = "small";
			}

			var_0D.fontscale = var_0B;
			var_0D.sort = 2;
			var_0D.glowcolor = (0.6,0.6,0.6);
			var_0D.glowalpha = 0;
			var_0E = newhudelem();
			var_0E settext(var_11);
			var_0E.alignx = "center";
			var_0E.horzalign = "center";
			var_0E.x = 0;
			var_0E.y = 480;
			if(!level.console)
			{
				var_0E.font = "small";
			}
			else
			{
				var_0E.font = "small";
			}

			var_0E.fontscale = var_0B;
			var_0E.sort = 2;
			var_0E.glowcolor = (0.6,0.6,0.6);
			var_0E.glowalpha = 0;
			var_13 = newhudelem();
			var_13 settext(var_12);
			var_13.alignx = "right";
			var_13.horzalign = "center";
			var_13.x = 220;
			var_13.y = 480;
			if(!level.console)
			{
				var_13.font = "small";
			}
			else
			{
				var_13.font = "small";
			}

			var_13.fontscale = var_0B;
			var_13.sort = 2;
			var_13.glowcolor = (0.6,0.6,0.6);
			var_13.glowalpha = 0;
			var_0D thread delaydestroy(level.credits_speed);
			var_0D moveovertime(level.credits_speed);
			var_0D thread delayfade(level.credits_speed - 0.4);
			var_0D.y = level.credits_spacing;
			var_0E thread delaydestroy(level.credits_speed);
			var_0E moveovertime(level.credits_speed);
			var_0E thread delayfade(level.credits_speed - 0.2);
			var_0E.y = level.credits_spacing;
			var_13 thread delaydestroy(level.credits_speed);
			var_13 moveovertime(level.credits_speed);
			var_13 thread delayfade(level.credits_speed);
			var_13.y = level.credits_spacing;
		}
		else if(var_05 == "centername")
		{
			var_0C = level.linelist[var_03].name;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_09 = newhudelem();
			var_09 settext(var_0C);
			var_09.alignx = "left";
			var_09.horzalign = "center";
			var_09.x = 8;
			var_09.y = 480;
			if(!level.console)
			{
				var_09.font = "default";
			}
			else
			{
				var_09.font = "small";
			}

			var_09.fontscale = var_0B;
			var_09.sort = 2;
			var_09.glowcolor = (0.8,0.8,0.8);
			var_09.glowalpha = 1;
			var_09 thread delaydestroy(level.credits_speed);
			var_09 moveovertime(level.credits_speed);
			var_09.y = level.credits_spacing;
		}
		else if(var_05 == "centernamedouble")
		{
			var_10 = level.linelist[var_03].name1;
			var_11 = level.linelist[var_03].name2;
			var_0B = level.linelist[var_03].textscale * var_02;
			var_0D = newhudelem();
			var_0D settext(var_10);
			var_0D.alignx = "center";
			var_0D.horzalign = "center";
			var_0D.x = -80;
			var_0D.y = 480;
			if(!level.console)
			{
				var_0D.font = "default";
			}
			else
			{
				var_0D.font = "small";
			}

			var_0D.fontscale = var_0B;
			var_0D.sort = 2;
			var_0D.glowcolor = (0.8,0.8,0.8);
			var_0D.glowalpha = 1;
			var_0E = newhudelem();
			var_0E settext(var_11);
			var_0E.alignx = "center";
			var_0E.horzalign = "center";
			var_0E.x = 80;
			var_0E.y = 480;
			if(!level.console)
			{
				var_0E.font = "default";
			}
			else
			{
				var_0E.font = "small";
			}

			var_0E.fontscale = var_0B;
			var_0E.sort = 2;
			var_0E.glowcolor = (0.8,0.8,0.8);
			var_0E.glowalpha = 1;
			var_0D thread delaydestroy(level.credits_speed);
			var_0D moveovertime(level.credits_speed);
			var_0D.y = level.credits_spacing;
			var_0E thread delaydestroy(level.credits_speed);
			var_0E moveovertime(level.credits_speed);
			var_0E.y = level.credits_spacing;
		}
		else if(var_05 == "spacesmall")
		{
			var_04 = 0.25;
		}
		else
		{
		}

		wait(var_04 * level.credits_speed / 22.5);
	}

	wait(15);
	fade_out_level();
}

//Function Number: 19
delayfade(param_00)
{
	wait(param_00 - 7);
	self fadeovertime(1.5);
	self.alpha = 0;
}

//Function Number: 20
delaydestroy(param_00)
{
	wait(param_00 - 2);
	self destroy();
}

//Function Number: 21
pulse_fx()
{
	self.alpha = 0;
	wait(level.credits_speed * 0.08);
	self fadeovertime(0.2);
	self.alpha = 1;
	self setpulsefx(50,int(level.credits_speed * 0.6 * 1000),500);
}

//Function Number: 22
addgap()
{
	addspace();
	addspace();
}

//Function Number: 23
readncolumns(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		var_04[var_05] = tablelookupbyrow(param_00,param_01,param_02 + var_05);
	}

	return var_04;
}

//Function Number: 24
readtriple(param_00,param_01,param_02)
{
	var_03[0] = tablelookupbyrow(param_00,param_01,param_02);
	var_03[1] = tablelookupbyrow(param_00,param_01,param_02 + 1);
	var_03[2] = tablelookupbyrow(param_00,param_01,param_02 + 2);
	return var_03;
}

//Function Number: 25
allow_early_back_out()
{
	level.player notifyonplayercommand("stop_credits_pressed","+stance");
	if(!level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		level.player notifyonplayercommand("stop_credits_pressed","+gostand");
	}

	level.player notifyonplayercommand("show_skip_prompt","+activate");
	level.player notifyonplayercommand("show_skip_prompt","+gostand");
	level.player notifyonplayercommand("show_skip_prompt","weapnext");
	level.player notifyonplayercommand("show_skip_prompt","+stance");
	level.player notifyonplayercommand("show_skip_prompt","+melee");
	level.player notifyonplayercommand("show_skip_prompt","+sprint");
	level.player notifyonplayercommand("show_skip_prompt","+attack");
	level.player notifyonplayercommand("show_skip_prompt","+frag");
	level.player notifyonplayercommand("show_skip_prompt","+speed_throw");
	level.player notifyonplayercommand("show_skip_prompt","+toggleads_throw");
	level.player notifyonplayercommand("show_skip_prompt","+smoke");
	level.player notifyonplayercommand("show_skip_prompt","pause");
	level.player notifyonplayercommand("show_skip_prompt","+actionslot 1");
	level.player notifyonplayercommand("show_skip_prompt","+actionslot 2");
	level.player notifyonplayercommand("show_skip_prompt","+actionslot 3");
	level.player notifyonplayercommand("show_skip_prompt","+actionslot 4");
	for(;;)
	{
		level.player waittill("show_skip_prompt");
		var_00 = get_stop_credits_button();
		var_00 thread pulse_button_timeout();
		thread end_credits_with_next_press();
		level waittill("pulse_button_timed_out");
		var_00 destroy();
	}
}

//Function Number: 26
get_stop_credits_button()
{
	var_00 = newclienthudelem(level.player);
	var_00.x = -20;
	var_00.y = -20;
	var_00.alignx = "right";
	var_00.aligny = "bottom";
	var_00.horzalign = "right";
	var_00.vertalign = "bottom";
	var_00.fontscale = 2;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 settext(&"CREDITS_UI_SKIP");
	}
	else
	{
		var_00 settext(&"CREDITS_UI_SKIP_PC");
	}

	var_00.alpha = 0;
	var_00.foreground = 1;
	var_00.sort = 10;
	var_00.font = "objective";
	return var_00;
}

//Function Number: 27
pulse_button_timeout()
{
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		self fadeovertime(0.8);
		self.alpha = 1;
		wait(1);
		if(var_00 == 4)
		{
			break;
		}

		self fadeovertime(0.8);
		self.alpha = 0.5;
		wait(1);
	}

	self fadeovertime(0.8);
	self.alpha = 0;
	wait(1);
	level notify("pulse_button_timed_out");
}

//Function Number: 28
end_credits_with_next_press()
{
	level endon("pulse_button_timed_out");
	wait(0.25);
	level.player waittill("stop_credits_pressed");
	level.player notify("stop_credits");
}

//Function Number: 29
fade_out_level()
{
	var_00 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_00.sort = 100;
	var_00 fadeovertime(1);
	var_00.alpha = 1;
}

//Function Number: 30
end_logos()
{
	addcenterimage("dolby_havok_logos_01",384,48,3.875);
}
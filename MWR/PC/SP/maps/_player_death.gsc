/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_death.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 225 ms
 * Timestamp: 10/27/2023 2:48:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.player thread player_throwgrenade_timer();
	thread death_behavior();
	thread death_quote_think();
}

//Function Number: 2
death_behavior()
{
	level.player waittill("death",var_00,var_01,var_02,var_03);
	soundscripts\_snd::snd_message("player_death");
	if(isdefined(var_03))
	{
		var_04 = level.player.origin - level.player geteye() + (0,0,35);
		var_05 = spawn("script_model",level.player.origin + (0,0,var_04[2]));
		var_05.angles = (-10,level.player.angles[2],30);
		var_05 linkto(var_03);
		if(var_01 != "MOD_CRUSH")
		{
			level.player playerlinkto(var_05);
		}
	}

	level.player allowprone(1);
	maps\_sp_matchdata::register_death(var_02,var_01);
}

//Function Number: 3
player_throwgrenade_timer()
{
	self endon("death");
	self.lastgrenadetime = 0;
	for(;;)
	{
		while(!self isthrowinggrenade())
		{
			wait(0.05);
		}

		self.lastgrenadetime = gettime();
		while(self isthrowinggrenade())
		{
			wait(0.05);
		}
	}
}

//Function Number: 4
death_quote_think()
{
	level endon("new_quote_string");
	level.player waittill("death",var_00,var_01,var_02);
	if(getdvar("limited_mode") == "1")
	{
		return;
	}

	setdeadquote();
	special_death_hint(var_00,var_01,var_02);
}

//Function Number: 5
special_death_hint(param_00,param_01,param_02)
{
	if(maps\_utility::is_specialop())
	{
		return;
	}

	if(level.missionfailed)
	{
		return;
	}

	if(param_01 != "MOD_GRENADE" && param_01 != "MOD_GRENADE_SPLASH" && param_01 != "MOD_SUICIDE" && param_01 != "MOD_EXPLOSIVE")
	{
		return;
	}

	if(level.gameskill >= 2)
	{
		if(!maps\_load::map_is_early_in_the_game())
		{
			return;
		}
	}

	switch(param_01)
	{
		case "MOD_SUICIDE":
			break;

		case "MOD_EXPLOSIVE":
			break;

		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
			break;

		default:
			break;
	}
}

//Function Number: 6
vehicle_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.code_classname != "script_vehicle")
	{
		return 0;
	}

	set_deadquote("@SCRIPT_EXPLODING_VEHICLE_DEATH");
	thread set_death_icon("hud_burningcaricon",50,50);
	return 1;
}

//Function Number: 7
destructible_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.destructible_type))
	{
		return 0;
	}

	if(issubstr(param_00.destructible_type,"vehicle"))
	{
		set_deadquote("@SCRIPT_EXPLODING_VEHICLE_DEATH");
		thread set_death_icon("hud_burningcaricon",50,50);
	}
	else
	{
		set_deadquote("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
		thread set_death_icon("hud_destructibledeathicon",96,96);
	}

	return 1;
}

//Function Number: 8
exploding_barrel_death(param_00)
{
	if(isdefined(level.lastexplodingbarrel))
	{
		if(gettime() != level.lastexplodingbarrel["time"])
		{
			return 0;
		}

		var_01 = distance(self.origin,level.lastexplodingbarrel["origin"]);
		if(var_01 > level.lastexplodingbarrel["radius"])
		{
			return 0;
		}

		set_deadquote("@SCRIPT_EXPLODING_BARREL_DEATH");
		thread set_death_icon("hud_burningbarrelicon",50,50);
		return 1;
	}

	return 0;
}

//Function Number: 9
set_deadquote(param_00)
{
	if(getdvar("limited_mode") == "1")
	{
		return;
	}

	setdvar("ui_deadquote",param_00);
}

//Function Number: 10
setdeadquote()
{
	if(!level.missionfailed)
	{
		var_00 = int(tablelookup("sp/deathQuoteTable.csv",1,"size",0));
		var_01 = randomint(var_00);
		if(getdvar("cycle_deathquotes") != "")
		{
			if(getdvar("ui_deadquote_index") == "")
			{
				setdvar("ui_deadquote_index","0");
			}

			var_01 = getdvarint("ui_deadquote_index");
			setdvar("ui_deadquote",lookupdeathquote(var_01));
			var_01++;
			if(var_01 > var_00 - 1)
			{
				var_01 = 0;
			}

			setdvar("ui_deadquote_index",var_01);
			return;
		}

		setdvar("ui_deadquote",lookupdeathquote(var_01));
	}
}

//Function Number: 11
deadquote_recently_used(param_00)
{
	if(param_00 == getdvar("ui_deadquote_v1"))
	{
		return 1;
	}

	if(param_00 == getdvar("ui_deadquote_v2"))
	{
		return 1;
	}

	if(param_00 == getdvar("ui_deadquote_v3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
lookupdeathquote(param_00)
{
	var_01 = tablelookup("sp/deathQuoteTable.csv",0,param_00,1);
	if(tolower(var_01[0]) != tolower("@"))
	{
		var_01 = "@" + var_01;
	}

	return var_01;
}

//Function Number: 13
grenade_death_hint(param_00,param_01)
{
	level.player.failingmission = 1;
	if(getdvar("limited_mode") == "1")
	{
		return;
	}

	set_deadquote("");
	wait(2.5);
	var_02 = newhudelem();
	var_02.elemtype = "font";
	var_02.font = "default";
	var_02.fontscale = 1;
	var_02.x = 0;
	var_02.y = -30;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	var_02 settext(param_00);
	var_02.foreground = 1;
	var_02.alpha = 0;
	var_02 fadeovertime(2);
	var_02.alpha = 1;
	var_02.hidewheninmenu = 1;
	if(isdefined(param_01))
	{
		var_02 = newhudelem();
		var_02.elemtype = "font";
		var_02.font = "default";
		var_02.fontscale = 1;
		var_02.x = 0;
		var_02.y = -25 + level.fontheight * var_02.fontscale;
		var_02.alignx = "center";
		var_02.aligny = "middle";
		var_02.horzalign = "center";
		var_02.vertalign = "middle";
		var_02 settext(param_01);
		var_02.foreground = 1;
		var_02.alpha = 0;
		var_02 fadeovertime(2);
		var_02.alpha = 1;
		var_02.hidewheninmenu = 1;
	}
}

//Function Number: 14
grenade_death_indicator_hud()
{
	if(getdvar("limited_mode") == "1")
	{
		return;
	}

	wait(2.5);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 20;
	var_00 setshader("hud_grenadeicon",25,25);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(2);
	var_00.alpha = 1;
	var_00.hidewheninmenu = 1;
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("hud_grenadepointer",25,13);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(2);
	var_00.alpha = 1;
	var_00.hidewheninmenu = 1;
}

//Function Number: 15
set_death_icon(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 2.5;
	}

	wait(param_03);
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 25;
	var_04 setshader(param_00,param_01,param_02);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.foreground = 1;
	var_04.alpha = 0;
	var_04 fadeovertime(2);
	var_04.alpha = 1;
	var_04.hidewheninmenu = 1;
}
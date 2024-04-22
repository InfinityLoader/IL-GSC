/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _player_death.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 177 ms
 * Timestamp: 4/22/2024 2:22:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.player thread player_throwgrenade_timer();
	level endon("new_quote_string");
	level.player waittill("death",var_00,var_01,var_02,var_03);
	set_deadquote("");
	setsaveddvar("ammoCounterHide",1);
	setsaveddvar("hud_showstance",0);
	setsaveddvar("actionSlotsHide",1);
	soundscripts\_snd::snd_message("player_death");
	if(isdefined(var_03))
	{
		var_04 = level.player.origin - level.player geteye() + (0,0,35);
		var_05 = spawn("script_model",level.player.origin + (0,0,var_04[2]));
		var_05.angles = (-10,level.player.angles[2],30);
		var_05 linkto(var_03);
		level.player playerlinkto(var_05);
	}

	maps\_sp_matchdata::register_death(var_02,var_01);
	special_death_hint(var_00,var_01,var_02);
}

//Function Number: 2
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

//Function Number: 3
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

	set_deadquote("");
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
			if(level.player.lastgrenadetime - gettime() > 3500)
			{
				return;
			}
	
			thread grenade_death_hint(&"SCRIPT_GRENADE_SUICIDE_LINE1",&"SCRIPT_GRENADE_SUICIDE_LINE2");
			break;

		case "MOD_EXPLOSIVE":
			if(level.player destructible_death(param_00))
			{
				return;
			}
	
			if(level.player vehicle_death(param_00))
			{
				return;
			}
	
			if(level.player exploding_barrel_death(param_00))
			{
				return;
			}
			break;

		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
			if(isdefined(param_02) && !issubstr(param_02,"grenade"))
			{
				return;
			}
	
			set_deadquote("@SCRIPT_GRENADE_DEATH");
			thread grenade_death_indicator_hud();
			break;

		default:
			break;
	}
}

//Function Number: 4
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

	level notify("new_quote_string");
	set_deadquote("@SCRIPT_EXPLODING_VEHICLE_DEATH");
	thread set_death_icon("hud_burningcaricon",96,96);
	return 1;
}

//Function Number: 5
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

	level notify("new_quote_string");
	if(issubstr(param_00.destructible_type,"vehicle"))
	{
		set_deadquote("@SCRIPT_EXPLODING_VEHICLE_DEATH");
		thread set_death_icon("hud_burningcaricon",96,96);
	}
	else
	{
		set_deadquote("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
		thread set_death_icon("hud_destructibledeathicon",96,96);
	}

	return 1;
}

//Function Number: 6
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

		level notify("new_quote_string");
		set_deadquote("@SCRIPT_EXPLODING_BARREL_DEATH");
		thread set_death_icon("hud_burningbarrelicon",64,64);
		return 1;
	}

	return 0;
}

//Function Number: 7
set_deadquote(param_00)
{
	setdvar("ui_deadquote",param_00);
}

//Function Number: 8
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

//Function Number: 9
lookupdeathquote(param_00)
{
	var_01 = tablelookup("sp/deathQuoteTable.csv",0,param_00,1);
	if(tolower(var_01[0]) != tolower("@"))
	{
		var_01 = "@" + var_01;
	}

	return var_01;
}

//Function Number: 10
grenade_death_hint(param_00,param_01)
{
	level.player.failingmission = 1;
	set_deadquote("");
	wait(1.5);
	var_02 = newhudelem();
	var_02.elemtype = "font";
	var_02.font = "default";
	var_02.fontscale = 1.5;
	var_02.x = 0;
	var_02.y = -30;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	var_02 settext(param_00);
	var_02.foreground = 1;
	var_02.alpha = 0;
	var_02 fadeovertime(1);
	var_02.alpha = 1;
	if(isdefined(param_01))
	{
		var_02 = newhudelem();
		var_02.elemtype = "font";
		var_02.font = "default";
		var_02.fontscale = 1.5;
		var_02.x = 0;
		var_02.y = -25 + level.fontheight * var_02.fontscale;
		var_02.alignx = "center";
		var_02.aligny = "middle";
		var_02.horzalign = "center";
		var_02.vertalign = "middle";
		var_02 settext(param_01);
		var_02.foreground = 1;
		var_02.alpha = 0;
		var_02 fadeovertime(1);
		var_02.alpha = 1;
	}
}

//Function Number: 11
grenade_death_indicator_hud()
{
	wait(1.5);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 68;
	var_00 setshader("hud_grenadeicon",50,50);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(1);
	var_00.alpha = 1;
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 25;
	var_00 setshader("hud_grenadepointer",50,25);
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 1;
	var_00.alpha = 0;
	var_00 fadeovertime(1);
	var_00.alpha = 1;
}

//Function Number: 12
set_death_icon(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1.5;
	}

	wait(param_03);
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 40;
	var_04 setshader(param_00,param_01,param_02);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.foreground = 1;
	var_04.alpha = 0;
	var_04 fadeovertime(1);
	var_04.alpha = 1;
}
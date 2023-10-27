/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_death.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 149 ms
 * Timestamp: 10/27/2023 1:37:22 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.player thread func_5F46();
	level endon("new_quote_string");
	level.player waittill("death",var_00,var_01,var_02,var_03);
	func_6E75("");
	function_0168("ammoCounterHide",1);
	function_0168("hud_showstance",0);
	function_0168("actionSlotsHide",1);
	if(isdefined(var_03))
	{
		var_04 = level.player.origin - level.player geteye() + (0,0,35);
		var_05 = spawn("script_model",level.player.origin + (0,0,var_04[2]));
		var_05.angles = (-10,level.player.angles[2],30);
		var_05 linkto(var_03);
		level.player playerlinkto(var_05);
	}

	func_78DE(var_00,var_01,var_02);
}

//Function Number: 2
func_5F46()
{
	self endon("death");
	self.var_4C68 = 0;
	for(;;)
	{
		while(!self method_8287())
		{
			wait(0.05);
		}

		self.var_4C68 = gettime();
		while(self method_8287())
		{
			wait(0.05);
		}
	}
}

//Function Number: 3
func_78DE(param_00,param_01,param_02)
{
	if(maps\_utility::func_4840())
	{
	}

	if(level.var_52F1)
	{
	}

	func_6E75("");
	if(param_01 != "MOD_GRENADE" && param_01 != "MOD_GRENADE_SPLASH" && param_01 != "MOD_SUICIDE" && param_01 != "MOD_EXPLOSIVE")
	{
	}

	if(level.gameskill >= 2)
	{
		if(!maps\_load::map_is_early_in_the_game())
		{
		}
	}

	switch(param_01)
	{
		case "MOD_SUICIDE":
			if(level.player.var_4C68 - gettime() > 3500)
			{
			}
	
			thread func_3DA4(&"SCRIPT_GRENADE_SUICIDE_LINE1",&"SCRIPT_GRENADE_SUICIDE_LINE2");
			break;

		case "MOD_EXPLOSIVE":
			if(level.player destructible_death(param_00))
			{
			}
	
			if(level.player func_889F(param_00))
			{
			}
	
			if(level.player func_30D0(param_00))
			{
			}
			break;

		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
			if(isdefined(param_02) && !isweapondetonationtimed(param_02))
			{
			}
	
			func_6E75("@SCRIPT_GRENADE_DEATH");
			thread func_3DA5();
			break;

		default:
			break;
	}
}

//Function Number: 4
func_889F(param_00)
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
	func_6E75("@SCRIPT_EXPLODING_VEHICLE_DEATH");
	thread func_6E77("hud_burningcaricon",96,96);
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
		func_6E75("@SCRIPT_EXPLODING_VEHICLE_DEATH");
		thread func_6E77("hud_burningcaricon",96,96);
	}
	else
	{
		func_6E75("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
		thread func_6E77("hud_destructibledeathicon",96,96);
	}

	return 1;
}

//Function Number: 6
func_30D0(param_00)
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
		func_6E75("@SCRIPT_EXPLODING_BARREL_DEATH");
		thread func_6E77("hud_burningbarrelicon",64,64);
		return 1;
	}

	return 0;
}

//Function Number: 7
func_6E75(param_00)
{
	setdvar("ui_deadquote",param_00);
}

//Function Number: 8
func_234F(param_00)
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
func_4F5E(param_00)
{
	var_01 = tablelookup("sp/deathQuoteTable.csv",0,param_00,1);
	if(tolower(var_01[0]) != tolower("@"))
	{
		var_01 = "@" + var_01;
	}

	return var_01;
}

//Function Number: 10
func_3DA4(param_00,param_01)
{
	level.player.var_3164 = 1;
	func_6E75("");
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
func_3DA5()
{
	wait(1.5);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 68;
	var_00 setmaterial("hud_grenadeicon",50,50);
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
	var_00 setmaterial("hud_grenadepointer",50,25);
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
func_6E77(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1.5;
	}

	wait(param_03);
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 40;
	var_04 setmaterial(param_00,param_01,param_02);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.foreground = 1;
	var_04.alpha = 0;
	var_04 fadeovertime(1);
	var_04.alpha = 1;
}
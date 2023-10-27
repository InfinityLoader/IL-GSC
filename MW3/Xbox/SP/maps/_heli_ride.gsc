/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_heli_ride.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 2:34:21 AM
*******************************************************************/

//Function Number: 1
func_3BA8(param_00,param_01)
{
	maps\_vehicle::func_2594();
	maps\_vehicle_aianim::getout_rigspawn(maps\_vehicle_aianim::getanimatemodel(),3);
	if(!isdefined(param_01))
	{
		param_01 = level.players;
	}

	foreach(var_03 in param_01)
	{
		thread func_3BA9(var_03,3);
	}

	var_05 = 95;
	if(isdefined(param_00.speed))
	{
		var_05 = param_00.speed;
	}

	self setairresistance(30);
	self vehicle_setspeed(var_05,40,level.var_2475);
	maps\_vehicle::vehicle_paths(param_00);
}

//Function Number: 2
func_3BA9(param_00,param_01,param_02)
{
	param_00 thread func_3BAB(self);
	if(getdvar("fastrope_arms") == "")
	{
		setdvar("fastrope_arms","0");
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = undefined;
	for(var_04 = 0;var_04 < self.riders.size;var_04++)
	{
		if(self.riders[var_04].var_1DD4 == param_01)
		{
			var_03 = self.riders[var_04];
			var_03.drone_delete_on_unload = 1;
			var_03.playerpiggyback = 1;
			break;
		}
	}

	var_05 = maps\_vehicle_aianim::anim_pos(self,param_01);
	var_03 notify("newanim");
	var_03 detachall();
	var_03 setmodel("fastrope_arms");
	var_03 useanimtree(var_05.player_animtree);
	thread maps\_vehicle_aianim::func_20CB(var_03,param_01);
	wait 0.1;
	if(isdefined(level.var_3BAA))
	{
		param_00 playerlinkto(var_03,"tag_player",0.35,120,28,30,30,0);
	}
	else
	{
		param_00 playerlinkto(var_03,"tag_player",0.35,60,28,30,30,0);
	}

	param_00 freezecontrols(0);
	var_03 hide();
	var_06 = getanimlength(var_05.var_20FE);
	var_06 = var_06 - param_02;
	self waittill("unloading");
	if(getdvar("fastrope_arms") != "0")
	{
		var_03 show();
	}

	param_00 disableweapons();
	wait var_06;
	param_00 unlink();
	param_00 enableweapons();
	setsaveddvar("hud_drawhud","1");
	level notify("stop_draw_hud_on_death");
}

//Function Number: 3
func_3BAB(param_00)
{
	setsaveddvar("g_friendlyNameDist",0);
	setsaveddvar("g_friendlyfireDist",0);
	maps\_utility::hide_player_model();
	self allowsprint(0);
	self allowprone(0);
	self allowstand(0);
	self enableinvulnerability();
	self.ignoreme = 1;
	wait 0.05;
	self setplayerangles((0,35,0));
	param_00 waittill("unloading");
	self notify("stop_quake");
	wait 6;
	maps\_utility::autosave_by_name("on_the_ground");
	self allowprone(0);
	self allowstand(1);
	self allowcrouch(0);
	wait 0.05;
	self allowprone(1);
	self allowcrouch(1);
	self disableinvulnerability();
	self.ignoreme = 0;
	self allowsprint(1);
	wait 4;
	maps\_utility::show_player_model();
	if(self == level.player)
	{
		for(var_01 = 0;var_01 < 24;var_01++)
		{
			self setorigin(self.origin + (2,0,0));
			wait 0.05;
		}
	}

	setsaveddvar("g_friendlyNameDist",15000);
	setsaveddvar("g_friendlyfireDist",128);
}

//Function Number: 4
player_heli_ropeanimoverride_idle(param_00,param_01,param_02)
{
	self endon("unloading");
	maps\_vehicle_aianim::func_2120(param_00,param_01,param_02);
}

//Function Number: 5
func_3BAD(param_00,param_01)
{
	var_02 = "heli_ride_in";
	var_03 = getentarray(var_02,"targetname");
	if(!var_03.size)
	{
		var_03 = common_scripts\utility::getstructarray("heli_ride_in","targetname");
		if(!var_03.size)
		{
		}
	}

	var_03 = var_03[0];
	if(isdefined(param_01))
	{
		maps\_vehicle::func_2677(level.gag_heliride_spawner.var_208D,param_01);
	}

	var_04 = maps\_vehicle::vehicle_spawn(level.gag_heliride_spawner);
	var_04 thread func_3BA8(var_03,param_00);
	return var_04;
}
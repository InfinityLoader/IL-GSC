/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hms_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 599 ms
 * Timestamp: 4/22/2024 2:21:27 AM
*******************************************************************/

//Function Number: 1
setupplayerinventory(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.map_without_loadout) || isdefined(level.map_without_loadout) && level.map_without_loadout == 0)
	{
		if(maps\_utility::is_default_start())
		{
			return;
		}
	}

	level.player takeallweapons();
	if(isdefined(param_00))
	{
		level.player giveweapon(param_00);
	}

	if(isdefined(param_01))
	{
		level.player giveweapon(param_01);
	}

	if(isdefined(param_02))
	{
		level.player setlethalweapon(param_02);
		level.player giveweapon(param_02);
	}

	if(isdefined(param_03))
	{
		level.player settacticalweapon(param_03);
		level.player giveweapon(param_03);
	}

	if(isdefined(param_04))
	{
		if(param_04 == param_00 || param_04 == param_01)
		{
			level.player switchtoweapon(param_04);
			return;
		}

		level.player switchtoweapon(param_00);
	}
}

//Function Number: 2
initializeallyarray()
{
	level.allies = [];
}

//Function Number: 3
spawnandinitnamedally(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.allies))
	{
		initializeallyarray();
	}

	if(!isdefined(level.allies[param_00]))
	{
		if(isdefined(param_04))
		{
			var_05 = maps\_utility::spawn_targetname(param_04,1);
		}
		else
		{
			var_05 = maps\_utility::spawn_targetname(param_01,1);
		}

		var_05.name = param_00;
		var_05.animname = param_00;
		var_05.script_friendname = param_00;
		var_05.script_parameters = param_00;
		if(isdefined(param_02))
		{
			if(param_02 == 1)
			{
				var_05 thread maps\_utility::disable_surprise();
			}
		}

		if(isdefined(param_03))
		{
			if(param_03 == 1)
			{
				var_05 thread maps\_utility::deletable_magic_bullet_shield();
			}
		}

		level.allies[param_00] = var_05;
	}

	if(isdefined(param_01))
	{
		var_06 = common_scripts\utility::getstruct(param_01,"targetname");
		if(isdefined(var_06))
		{
			level.allies[param_00] forceteleport(var_06.origin,var_06.angles);
		}
	}
}

//Function Number: 4
getnamedally(param_00)
{
	var_01 = level.allies[param_00];
	return var_01;
}

//Function Number: 5
updatenamedally(param_00,param_01)
{
	level.allies[param_00] = param_01;
}

//Function Number: 6
getdialogai(param_00,param_01)
{
	var_02 = filteraiarray(param_00,param_01);
	if(var_02.size > 1)
	{
		return undefined;
	}

	return var_02[0];
}

//Function Number: 7
filteraiarray(param_00,param_01)
{
	var_02 = getaispeciesarray("all","all");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(!isalive(var_05))
		{
			continue;
		}

		switch(param_01)
		{
			case "script_parameters":
				if(isdefined(var_05.script_parameters) && var_05.script_parameters == param_00)
				{
					var_03[var_03.size] = var_05;
				}
				break;
		}
	}

	return var_03;
}

//Function Number: 8
allyredirectgotonode(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(level.allies[param_00].goalradius > 64)
	{
		level.allies[param_00].goalradius = 64;
	}

	var_08 = getnode(param_01,"targetname");
	level.allies[param_00] maps\_utility::enable_ai_color();
	level.allies[param_00] maps\_utility::set_goal_node(var_08);
	if(isdefined(param_03))
	{
		executefunction(param_02,param_03,param_04,param_05,param_06,param_07);
	}
}

//Function Number: 9
spawnsquadfunc(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_00,"targetname");
	maps\_utility::array_spawn_function(var_06,param_01,param_02,param_03,param_04,param_05);
	maps\_utility::array_spawn(var_06,1);
}

//Function Number: 10
flagmonitor(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	common_scripts\utility::flag_wait(param_00);
	executefunction(param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 11
executefunction(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	if(isdefined(param_05))
	{
		var_06 = 4;
	}
	else if(isdefined(param_04))
	{
		var_06 = 3;
	}
	else if(isdefined(param_03))
	{
		var_06 = 2;
	}
	else if(isdefined(param_02))
	{
		var_06 = 1;
	}

	if(param_00 == 1)
	{
		switch(var_06)
		{
			case 0:
				thread [[ param_01 ]]();
				break;

			case 1:
				thread [[ param_01 ]](param_02);
				break;

			case 2:
				thread [[ param_01 ]](param_02,param_03);
				break;

			case 3:
				thread [[ param_01 ]](param_02,param_03,param_04);
				break;

			case 4:
				thread [[ param_01 ]](param_02,param_03,param_04,param_05);
				break;
		}

		return;
	}

	switch(var_06)
	{
		case 0:
			[[ param_01 ]]();
			break;

		case 1:
			[[ param_01 ]](param_02);
			break;

		case 2:
			[[ param_01 ]](param_02,param_03);
			break;

		case 3:
			[[ param_01 ]](param_02,param_03,param_04);
			break;

		case 4:
			[[ param_01 ]](param_02,param_03,param_04,param_05);
			break;
	}
}

//Function Number: 12
objsetupdefault(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getent(param_00,"targetname");
	if(!isdefined(var_05))
	{
		var_05 = (0,0,0);
	}

	common_scripts\utility::flag_wait(param_02);
	objective_add(maps\_utility::obj(param_00),"active",param_01,var_05.origin);
	objective_current(maps\_utility::obj(param_00));
	if(isdefined(param_04))
	{
		objective_setpointertextoverride(maps\_utility::obj(param_00),param_04);
	}

	common_scripts\utility::flag_wait(param_03);
	maps\_utility::objective_complete(maps\_utility::obj(param_00));
}

//Function Number: 13
objsetupentity(param_00,param_01,param_02,param_03,param_04,param_05)
{
	common_scripts\utility::flag_wait(param_03);
	objective_add(maps\_utility::obj(param_00),"active",param_02,(0,0,0));
	if(isdefined(param_01))
	{
		objective_onentity(maps\_utility::obj(param_00),param_01);
	}

	objective_current(maps\_utility::obj(param_00));
	if(isdefined(param_05))
	{
		objective_setpointertextoverride(maps\_utility::obj(param_00),param_05);
	}

	common_scripts\utility::flag_wait(param_04);
	maps\_utility::objective_complete(maps\_utility::obj(param_00));
}

//Function Number: 14
aideleteonflag(param_00,param_01,param_02)
{
	var_03 = [];
	var_03 = common_scripts\utility::add_to_array(var_03,self);
	thread aiarraydeleteonflag(var_03,param_00,param_01,param_02);
}

//Function Number: 15
aiarraydeleteonflag(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 2048;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	common_scripts\utility::flag_wait(param_01);
	param_00 = maps\_utility::remove_dead_from_array(param_00);
	if(param_03 == 1)
	{
		maps\_utility::array_delete(param_00);
		return;
	}

	thread maps\_utility::ai_delete_when_out_of_sight(param_00,param_02);
}

//Function Number: 16
aiarrayfallbackonflag(param_00,param_01,param_02,param_03,param_04)
{
	param_00 = maps\_utility::remove_dead_from_array(param_00);
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		param_00[var_05] thread aifallbackonflag(param_01,param_02,param_03,param_04);
	}
}

//Function Number: 17
aifallbackonflag(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = getent(param_01,"targetname");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 3;
	}

	common_scripts\utility::flag_wait(param_00);
	if(param_02 == 0)
	{
		wait(randomfloat(param_03));
	}

	self cleargoalvolume();
	self setgoalvolumeauto(var_04);
}

//Function Number: 18
printlnscreenandconsole(param_00)
{
	if(isdefined(level.showdebugtoggle) && level.showdebugtoggle == 1)
	{
		iprintln(param_00);
	}
}

//Function Number: 19
debugprint3dcontinuous(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(level.showdebugtoggle == 1)
	{
		param_01 endon("death");
		if(isdefined(param_05) && isdefined(param_06))
		{
			param_05 endon(param_06);
		}

		if(!isdefined(param_04))
		{
			param_04 = 600000;
		}

		if(!isdefined(param_03))
		{
			param_03 = 3;
		}

		if(!isdefined(param_02))
		{
			param_02 = "green";
		}

		var_07 = (0,0,0);
		switch(param_02)
		{
			case "white":
				var_07 = (9,9,9);
				break;

			case "black":
				var_07 = (0.5,0.5,0.5);
				break;

			case "red":
				var_07 = (9,0.5,0.5);
				break;

			case "green":
				var_07 = (0.5,9,0.5);
				break;

			case "blue":
				var_07 = (0.5,0.5,9);
				break;

			case "yellow":
				var_07 = (9,9,0.5);
				break;

			case "purple":
				var_07 = (9,0.5,9);
				break;

			case "cyan":
				var_07 = (0.5,9,9);
				break;
		}

		for(var_08 = 0;var_08 < param_04 * 20;var_08++)
		{
			wait(0.05);
		}
	}
}

//Function Number: 20
transformpointbyentity(param_00,param_01)
{
	return transformpoint(param_00,param_01.origin,param_01.angles);
}

//Function Number: 21
transformpoint(param_00,param_01,param_02)
{
	var_03 = length(param_00);
	var_04 = vectortoangles(param_00);
	var_05 = combineangles(param_02,var_04);
	var_06 = anglestoforward(var_05);
	return param_01 + var_06 * var_03;
}

//Function Number: 22
playdialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	common_scripts\utility::create_dvar("display_placeholderdialog",0);
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(isdefined(param_03))
	{
		if(isdefined(param_04))
		{
			param_04 endon(param_03);
		}
		else
		{
			level endon(param_03);
		}
	}

	if(isdefined(param_04) && isalive(param_04))
	{
		param_04 endon("death");
		param_04 endon("dying");
	}

	if(!isdefined(param_02))
	{
		param_02 = param_01;
	}

	var_08 = tablelookuprownum(param_00,2,param_01 + "(Start)");
	if(var_08 == -1)
	{
		var_09 = 1;
	}
	else
	{
		var_09 = 0;
	}

	if(var_09 == 1)
	{
		var_08 = tablelookuprownum(param_00,2,param_01);
		var_0A = var_08;
	}
	else
	{
		var_0A = tablelookuprownum(param_01,2,param_02 + "(End)");
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(param_05 == 1)
	{
		var_0B = randomintrange(var_08,var_0A + 1);
		_dialogtablelookup(param_00,var_0B,param_03,param_04,param_06,param_07);
	}
	else
	{
		for(var_0C = var_08;var_0C <= var_0A;var_0C++)
		{
			_dialogtablelookup(param_00,var_0C,param_03,param_04,param_06,param_07);
		}
	}

	level notify(param_02);
}

//Function Number: 23
_dialogtablelookup(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = tablelookupbyrow(param_00,param_01,1);
	var_07 = tablelookupbyrow(param_00,param_01,4);
	var_08 = tablelookupbyrow(param_00,param_01,5);
	if(var_08 == "")
	{
		var_08 = 2;
	}
	else
	{
		var_08 = float(var_08);
	}

	var_09 = tablelookupbyrow(param_00,param_01,6);
	if(var_09 == "")
	{
		var_09 = 2;
	}

	var_09 = float(var_09);
	var_0A = tablelookupbyrow(param_00,param_01,7);
	var_0B = tablelookupbyrow(param_00,param_01,9);
	var_0C = tablelookupbyrow(param_00,param_01,8);
	if(var_08 == 1)
	{
		var_08 = "(whispering)";
	}
	else if(var_08 == 1.5)
	{
		var_08 = "(intense whispering)";
	}
	else if(var_08 == 2)
	{
		var_08 = "";
	}
	else if(var_08 == 2.5)
	{
		var_08 = "(loud voice)";
	}
	else if(var_08 == 3)
	{
		var_08 = "(shouting)";
	}
	else if(var_08 == 4)
	{
		var_08 = "(screaming)";
	}

	if(var_0A == "")
	{
		var_0A = "";
	}
	else
	{
		var_0A = "[" + var_0A + "]";
	}

	var_07 = var_0A + var_08 + var_07;
	var_0D = tablelookupbyrow(param_00,param_01,12);
	if(var_0C != "")
	{
		var_0C = float(var_0C);
		wait(var_0C);
	}

	var_0E = getdvarint("display_placeholderdialog");
	if(var_0E == 1)
	{
		thread maps\_utility::add_dialogue_line(var_06,var_07);
	}

	if(var_0D != "" && soundexists(var_0D))
	{
		if(var_0A == "[Radio]")
		{
			if(isdefined(param_03) && isai(param_03) && isalive(param_03))
			{
				param_03 thread _clearradiodialogondeath();
			}

			if(isdefined(level.scr_radio[var_0D]))
			{
				if(param_04 == 1)
				{
					if(isdefined(level.player_radio_emitter))
					{
						maps\_utility::radio_dialogue_overlap(var_0D);
					}
					else
					{
						maps\_utility::radio_dialogue(var_0D);
					}
				}
				else
				{
					maps\_utility::radio_dialogue(var_0D);
				}

				level notify("RadioDialogFinished");
			}
		}
		else if(var_0A == "[World]")
		{
			var_0F = getent(param_05,"targetname");
			if(isdefined(param_02))
			{
				var_0F thread _clearworlddialogonnotify(param_02);
			}

			if(isdefined(level.scr_radio[var_0D]))
			{
				var_0F maps\_utility::play_sound_on_entity(var_0D);
			}

			level notify("WorldDialogFinished");
		}
		else
		{
			var_10 = getdialogai(var_06,"script_parameters");
			if(isdefined(var_10) && isai(var_10))
			{
				var_10 endon("death");
				if(isdefined(param_02))
				{
					var_10 thread _clearcharacterdialogonnotify(param_02);
				}

				if(isdefined(level.scr_sound[var_06][var_0D]))
				{
					var_10 thread _clearcharacterdialogondeath();
					var_10 maps\_utility::dialogue_queue(var_0D);
				}

				level notify("CharacterDialogFinished");
			}
		}
	}

	if(var_0D == "" || !soundexists(var_0D))
	{
		wait(var_09);
	}

	if(var_0B == "")
	{
		var_0B = "";
		return;
	}

	level notify(var_0B);
}

//Function Number: 24
waittillbcsdone(param_00)
{
	self endon("death");
	self endon("dying");
	if(!isdefined(level.dds))
	{
		return;
	}

	if(!isdefined(self.dds_characterid))
	{
		return;
	}

	if(isdefined(self.dds_disable) && self.dds_disable == 1)
	{
		return;
	}

	for(;;)
	{
		wait 0.05;
		if(maps\_dds::talker_is_talking_currently(self))
		{
			wait(0.5);
			continue;
		}
		else
		{
			maps\_utility::set_battlechatter(0);
			break;
		}
	}
}

//Function Number: 25
makeavailableforbcs(param_00)
{
	self endon("death");
	self endon("dying");
	if(!isdefined(level.dds))
	{
		return;
	}

	if(!isdefined(self.dds_characterid))
	{
		return;
	}

	if(isdefined(self.dds_disable) && self.dds_disable == 1)
	{
		level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
		return;
	}

	level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
}

//Function Number: 26
_clearradiodialogondeath()
{
	level endon("RadioDialogFinished");
	common_scripts\utility::waittill_either("death","pain_death");
	maps\_utility::radio_dialogue_stop();
}

//Function Number: 27
_clearcharacterdialogondeath()
{
	level endon("CharacterDialogFinished");
	common_scripts\utility::waittill_any("death","pain_death");
	if(isdefined(self))
	{
		self stopsounds();
	}
}

//Function Number: 28
_clearcharacterdialogonnotify(param_00)
{
	self endon("death");
	self endon("pain_death");
	level waittill(param_00);
	self stopsounds();
}

//Function Number: 29
_clearworlddialogonnotify(param_00)
{
	level endon("WorldDialogFinished");
	level waittill(param_00);
	var_01 = self getlinkedchildren(0);
	if(!isdefined(var_01))
	{
		return;
	}

	foreach(var_03 in var_01)
	{
		var_03 stopsounds();
	}
}

//Function Number: 30
displayruleofthirds()
{
	level.player endon("death");
	precacheshader("line_vertical");
	common_scripts\utility::create_dvar("ruleofthirds","1");
	var_00 = "line_vertical";
	var_01 = [];
	var_01[0] = _createhudline(213,0,1,480,var_00);
	var_01[1] = _createhudline(426,0,1,480,var_00);
	var_01[2] = _createhudline(0,160,640,1,var_00);
	var_01[3] = _createhudline(0,320,640,1,var_00);
	for(;;)
	{
		var_02 = getdvarint("ruleofthirds");
		if(var_02 != 1)
		{
			foreach(var_04 in var_01)
			{
				var_04.alpha = 0;
			}
		}
		else if(var_02 == 1)
		{
			foreach(var_04 in var_01)
			{
				var_04.alpha = 1;
			}
		}

		wait(0.05);
	}
}

//Function Number: 31
_createhudline(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = newclienthudelem(level.player);
	var_07.x = param_00;
	var_07.y = param_01;
	var_07.sort = 1;
	var_07.horzalign = "fullscreen";
	var_07.vertalign = "fullscreen";
	var_07.alpha = 1;
	var_07 setshader(param_04,param_02,param_03);
	return var_07;
}

//Function Number: 32
cointossweighted(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 50;
	}

	return randomint(100) <= param_00;
}

//Function Number: 33
_glass_physics_wakeup()
{
	var_00 = getentarray("glass_phys_wakeup","targetname");
	var_01 = 36;
	if(var_00.size > 0)
	{
		foreach(var_03 in var_00)
		{
			if(!isdefined(var_03.target))
			{
			}

			var_03.glass_id = getglass(var_03.target);
			if(!isdefined(var_03.glass_id))
			{
				continue;
			}

			if(!isdefined(var_03.origin))
			{
				var_03.origin = (0,0,0);
			}

			var_03 thread _glass_physics_wakeup_update(var_01);
		}
	}
}

//Function Number: 34
_glass_physics_wakeup_update(param_00)
{
	level waittillmatch(self.glass_id,"glass_destroyed");
	var_01 = param_00;
	if(isdefined(self.radius))
	{
		var_01 = self.radius;
	}

	wakeupphysicssphere(self.origin,var_01);
	if(getdvarint("debug_glass_phys_wake",0))
	{
		iprintln("Glass physics wakeup occurred for glass " + self.glass_id + " at (" + self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + ")" + " with radius: " + var_01);
	}
}
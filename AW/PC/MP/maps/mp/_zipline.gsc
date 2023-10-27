/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_zipline.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 203 ms
 * Timestamp: 10/27/2023 1:49:54 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = [];
	var_01 = getentarray("zipline","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = maps\mp\gametypes\_gameobjects::createuseobject("neutral",var_01[var_02],var_00,(0,0,0));
		var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
		var_03 maps\mp\gametypes\_gameobjects::setusetime(0.25);
		var_03 maps\mp\gametypes\_gameobjects::setusetext(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::setusehinttext(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_03.onbeginuse = ::onbeginuse;
		var_03.onuse = ::onuse;
		var_04 = [];
		var_05 = getent(var_01[var_02].target,"targetname");
		if(!isdefined(var_05))
		{
		}

		while(isdefined(var_05))
		{
			var_04[var_04.size] = var_05;
			if(isdefined(var_05.target))
			{
				var_05 = getent(var_05.target,"targetname");
				continue;
			}

			break;
		}

		var_03.targets = var_04;
	}

	precachemodel("tag_player");
	init_elevator();
}

//Function Number: 2
onbeginuse(param_00)
{
	param_00 playsound("scrambler_pullout_lift_plr");
}

//Function Number: 3
onuse(param_00)
{
	param_00 thread zip(self);
}

//Function Number: 4
zip(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("zipline_drop");
	level endon("game_ended");
	var_01 = spawn("script_origin",param_00.trigger.origin);
	var_01.origin = param_00.trigger.origin;
	var_01.angles = self.angles;
	var_01 setmodel("tag_player");
	self playerlinktodelta(var_01,"tag_player",1,180,180,180,180);
	thread watchdeath(var_01);
	thread watchdrop(var_01);
	var_02 = param_00.targets;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = distance(var_01.origin,var_02[var_03].origin) / 600;
		var_05 = 0;
		if(var_03 == 0)
		{
			var_05 = var_04 * 0.2;
		}

		var_01 moveto(var_02[var_03].origin,var_04,var_05);
		if(var_01.angles != var_02[var_03].angles)
		{
			var_01 rotateto(var_02[var_03].angles,var_04 * 0.8);
		}

		wait(var_04);
	}

	self notify("destination");
	self unlink();
	var_01 delete();
}

//Function Number: 5
watchdrop(param_00)
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
watchdeath(param_00)
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
init_elevator()
{
	var_00 = [];
	var_01 = getentarray("elevator_button","targetname");
	level.elevator = spawnstruct();
	level.elevator.location = "floor1";
	level.elevator.states = [];
	level.elevator.states["elevator"] = "closed";
	level.elevator.destinations = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = maps\mp\gametypes\_gameobjects::createuseobject("neutral",var_01[var_02],var_00,(0,0,0));
		var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
		var_03 maps\mp\gametypes\_gameobjects::setusetime(0.25);
		var_03 maps\mp\gametypes\_gameobjects::setusetext(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::setusehinttext(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_03.onbeginuse = ::onbeginuse_elevator;
		var_03.onuse = ::onuse_elevator;
		var_03.location = var_01[var_02].script_label;
		level.elevator.states[var_01[var_02].script_label] = "closed";
		if(isdefined(var_01[var_02].target))
		{
			var_04 = common_scripts\utility::getstruct(var_01[var_02].target,"targetname");
			if(isdefined(var_04))
			{
				level.elevator.destinations[var_01[var_02].script_label] = var_04;
			}
		}
	}
}

//Function Number: 8
onbeginuse_elevator(param_00)
{
}

//Function Number: 9
onuse_elevator(param_00)
{
	switch(self.location)
	{
		case "floor1":
			break;

		case "floor2":
			break;

		case "elevator":
			break;
	}
}

//Function Number: 10
open(param_00)
{
	level.elevator.states[param_00] = "opening";
	var_01 = getent("e_door_" + param_00 + "_left","targetname");
	var_02 = getent("e_door_" + param_00 + "_right","targetname");
	if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "fahrenheit")
	{
		var_01 moveto(var_01.origin - anglestoforward(var_01.angles) * 35,2);
		var_02 moveto(var_02.origin + anglestoforward(var_02.angles) * 35,2);
		var_01 playsound("elev_door_open");
	}
	else
	{
		var_01 moveto(var_01.origin - anglestoright(var_01.angles) * 35,2);
		var_02 moveto(var_02.origin + anglestoright(var_02.angles) * 35,2);
	}

	wait(2);
	level.elevator.states[param_00] = "opened";
	if(param_00 == "elevator")
	{
		level thread autoclose();
	}
}

//Function Number: 11
close(param_00)
{
	level.elevator.states[param_00] = "closing";
	var_01 = getent("e_door_" + param_00 + "_left","targetname");
	var_02 = getent("e_door_" + param_00 + "_right","targetname");
	if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "fahrenheit")
	{
		var_01 moveto(var_01.origin + anglestoforward(var_01.angles) * 35,2);
		var_02 moveto(var_02.origin - anglestoforward(var_02.angles) * 35,2);
		var_01 playsound("elev_door_close");
	}
	else
	{
		var_01 moveto(var_01.origin + anglestoright(var_01.angles) * 35,2);
		var_02 moveto(var_02.origin - anglestoright(var_02.angles) * 35,2);
	}

	wait(2);
	level.elevator.states[param_00] = "closed";
}

//Function Number: 12
autoclose()
{
	level endon("stop_autoClose");
	wait(10);
	level thread close(level.elevator.location);
	level thread close("elevator");
}

//Function Number: 13
move()
{
	level.elevator.states["elevator"] = "moving";
	var_00 = getent("e_door_elevator_left","targetname");
	var_01 = getent("e_door_elevator_right","targetname");
	var_02 = getent("elevator","targetname");
	if(level.elevator.location == "floor1")
	{
		level.elevator.location = "floor2";
		var_03 = var_00.origin[2] - level.elevator.destinations["floor1"].origin[2];
		var_00 moveto((var_00.origin[0],var_00.origin[1],level.elevator.destinations["floor2"].origin[2] + var_03),5);
		var_03 = var_01.origin[2] - level.elevator.destinations["floor1"].origin[2];
		var_01 moveto((var_01.origin[0],var_01.origin[1],level.elevator.destinations["floor2"].origin[2] + var_03),5);
		var_02 moveto(level.elevator.destinations["floor2"].origin,5);
	}
	else
	{
		level.elevator.location = "floor1";
		var_03 = var_01.origin[2] - level.elevator.destinations["floor2"].origin[2];
		var_00 moveto((var_00.origin[0],var_00.origin[1],level.elevator.destinations["floor1"].origin[2] + var_03),5);
		var_03 = var_01.origin[2] - level.elevator.destinations["floor2"].origin[2];
		var_01 moveto((var_01.origin[0],var_01.origin[1],level.elevator.destinations["floor1"].origin[2] + var_03),5);
		var_02 moveto(level.elevator.destinations["floor1"].origin,5);
	}

	wait(5);
	var_02 playsound("elev_bell_ding");
	level.elevator.states["elevator"] = "closed";
}
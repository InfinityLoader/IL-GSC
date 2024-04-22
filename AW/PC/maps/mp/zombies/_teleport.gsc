/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_teleport.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 454 ms
 * Timestamp: 4/22/2024 2:13:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["trash_chute_burst"] = loadfx("vfx/props/dlc_prop_trash_chute_burst");
	precachempanim("incinerator_hatch_open");
	precachempanim("incinerator_hatch_close");
	if(!isdefined(level.zmteleportreadyhint))
	{
		level.zmteleportreadyhint = &"ZOMBIES_TELEPORT_USE";
	}

	if(!isdefined(level.zmteleportlookarcs))
	{
		level.zmteleportlookarcs = [20,20,0,30];
	}

	level.teleportrooms = common_scripts\utility::getstructarray("teleport_room","targetname");
	if(level.teleportrooms.size)
	{
		level.teleportroomindex = 0;
	}

	level.zombieteleporters = common_scripts\utility::getstructarray("zombie_teleport","targetname");
	common_scripts\utility::array_thread(level.zombieteleporters,::teleporter_init);
	level thread teleporter_cost();
}

//Function Number: 2
teleporter_init()
{
	self.disabled = 0;
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_05 = var_04.script_noteworthy;
		if(!isdefined(var_05))
		{
			var_05 = "<undefined>";
		}

		if(isdefined(level.zmteleporterinit) && [[ level.zmteleporterinit ]](var_04,var_05))
		{
			continue;
		}

		switch(var_05)
		{
			case "start":
				self.start = var_04;
				break;

			case "end":
				thread teleport_add_location(var_04);
				break;

			case "hatch":
				self.hatch = var_04;
				break;

			default:
				teleport_error("Target Ent @ " + var_04.origin + " had script_noteworthy: \'" + var_05 + "\'.");
				break;
		}
	}

	if(!isdefined(self.start))
	{
		teleport_error("Teleporter at" + self.origin + " has no start trigger.");
		return;
	}

	thread teleporter_run();
}

//Function Number: 3
teleporter_disable_all()
{
	common_scripts\utility::array_thread(level.zombieteleporters,::teleporter_disable);
}

//Function Number: 4
teleporter_disable()
{
	self notify("teleporter_disable");
	self endon("teleporter_disable");
	if(self.disabled)
	{
		return;
	}

	if(self.inuse)
	{
		self waittill("teleportReady");
	}

	self.disabled = 1;
	self.start sethintstring(&"ZOMBIES_EMPTY_STRING");
	self.start setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
	self.start maps\mp\zombies\_util::tokenhintstring(0);
}

//Function Number: 5
teleporter_enable_all()
{
	common_scripts\utility::array_thread(level.zombieteleporters,::teleporter_enable);
}

//Function Number: 6
teleporter_enable()
{
	if(!self.disabled)
	{
		return;
	}

	self.disabled = 0;
	self.start sethintstring(level.zmteleportreadyhint);
	var_00 = teleporter_get_cost();
	self.start setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_00));
	self.start maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_00));
	self.start maps\mp\zombies\_util::tokenhintstring(1);
}

//Function Number: 7
teleporter_run()
{
	self.inuse = 0;
	wait 0.05;
	if(isdefined(self.script_flag_true))
	{
		self.start sethintstring(&"ZOMBIES_REQUIRES_POWER");
		self.start maps\mp\zombies\_util::tokenhintstring(0);
		common_scripts\utility::flag_wait(self.script_flag_true);
	}

	if(!self.locations.size)
	{
		self waittill("location_added");
	}

	thread teleporter_update_cost();
	var_00 = 1;
	for(;;)
	{
		self.start setcursorhint("HINT_NOICON");
		self.start sethintstring(level.zmteleportreadyhint);
		self.start maps\mp\zombies\_util::tokenhintstring(1);
		self.inuse = 0;
		self notify("teleportReady");
		for(;;)
		{
			var_01 = self.start maps\mp\zombies\_util::waittilltriggerortokenuse();
			var_02 = var_01[0];
			var_03 = var_01[1];
			if(self.disabled)
			{
				continue;
			}

			if(var_03 == "token")
			{
				var_02 maps\mp\gametypes\zombies::spendtoken(self.start.tokencost);
			}
			else
			{
				var_04 = teleporter_get_cost();
				if(isdefined(level.penaltycostincrease))
				{
					for(var_05 = 0;var_05 < level.penaltycostincrease;var_05++)
					{
						var_06 = maps\mp\zombies\_util::getincreasedcost(var_04);
						var_04 = var_06;
					}
				}

				if(isdefined(var_02) && var_04 > 0 && !var_02 maps\mp\gametypes\zombies::attempttobuy(var_04))
				{
					continue;
				}
			}

			break;
		}

		self.inuse = 1;
		level notify("teleportUse",self,var_02);
		self.start sethintstring(&"ZOMBIES_EMPTY_STRING");
		self.start maps\mp\zombies\_util::tokenhintstring(0);
		if(isdefined(level.zmteleporterused))
		{
			[[ level.zmteleporterused ]](var_02);
		}

		if(isdefined(self.hatch))
		{
			playfx(common_scripts\utility::getfx("trash_chute_burst"),self.hatch.origin,anglestoup(self.hatch.angles),-1 * anglestoforward(self.hatch.angles));
			playsoundatpos(self.hatch.origin,"trash_chute_teleport_open");
			self.hatch scriptmodelplayanim("incinerator_hatch_open","hatch");
			self.hatch waittillmatch("teleport","hatch");
		}

		thread teleport_players_loop();
		wait(var_00);
		self notify("end_teleport_players_loop");
		if(isdefined(self.hatch))
		{
			self.hatch scriptmodelplayanim("incinerator_hatch_close","hatch");
			self.hatch waittillmatch("end","hatch");
		}
	}
}

//Function Number: 8
teleport_players_loop()
{
	self endon("end_teleport_players_loop");
	for(;;)
	{
		var_00 = [];
		foreach(var_02 in level.players)
		{
			if(var_02 istouching(self.start))
			{
				var_00[var_00.size] = var_02;
			}
		}

		level notify("teleportPlayers",var_00);
		self notify("teleportPlayers",var_00);
		thread teleport_players(var_00);
		wait 0.05;
	}
}

//Function Number: 9
teleporter_cost()
{
	thread teleporter_update_cost_on_teleport();
	thread teleporter_update_cost_on_round_end();
}

//Function Number: 10
teleporter_update_cost()
{
	foreach(var_01 in level.zombieteleporters)
	{
		var_02 = var_01 teleporter_get_cost();
		var_01.start setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_02));
		var_01.start maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_02));
		var_01.start maps\mp\zombies\_util::tokenhintstring(1);
	}
}

//Function Number: 11
teleporter_get_cost()
{
	var_00 = [100,500,2000];
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "incinerator")
	{
		return 0;
	}

	var_01 = level.teleport_cost_index;
	if(var_01 >= var_00.size)
	{
		var_01 = var_00.size - 1;
	}

	if(var_01 < 0)
	{
		var_01 = 0;
	}

	return var_00[var_01];
}

//Function Number: 12
teleporter_update_cost_on_teleport()
{
	level.teleport_cost_index = 0;
	for(;;)
	{
		teleporter_update_cost();
		level waittill("teleportUse",var_00,var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		level.teleport_cost_index++;
	}
}

//Function Number: 13
teleporter_update_cost_on_round_end(param_00)
{
	for(;;)
	{
		level waittill("zombie_wave_ended");
		level.teleport_cost_index = 0;
		teleporter_update_cost();
	}
}

//Function Number: 14
player_teleport_unlink(param_00)
{
	self endon("disconnect");
	wait(param_00);
	self unlink();
}

//Function Number: 15
teleport_players_through_chute(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = 2;
	var_04 = (0,0,-40);
	foreach(var_06 in param_00)
	{
		if(!isdefined(var_06) || !isalive(var_06))
		{
			continue;
		}

		var_07 = var_06 getstance();
		if(var_07 == "prone")
		{
			var_06 setstance("crouch");
		}

		var_06 playsoundtoplayer("trash_chute_teleport",var_06);
		var_08 = level.teleportrooms[level.teleportroomindex];
		var_09 = var_08.origin;
		var_0A = var_08.angles;
		var_06 player_teleport(var_09,var_0A);
		var_06.inteleport = 1;
		if(param_01)
		{
			var_06 thread maps\mp\zombies\_zombies_audio::playertrashchute();
		}

		if(isdefined(var_08.target))
		{
			var_0B = common_scripts\utility::getstruct(var_08.target,"targetname");
			if(!isdefined(var_08.playerlinkent))
			{
				var_08.playerlinkent = spawn("script_model",var_08.origin);
				var_08.playerlinkent setmodel("tag_origin");
				var_08.playerlinkent.angles = var_08.angles;
			}

			var_08.playerlinkent.origin = var_08.origin + var_04;
			var_0C = level.zmteleportlookarcs[0];
			var_0D = level.zmteleportlookarcs[1];
			var_0E = level.zmteleportlookarcs[2];
			var_0F = level.zmteleportlookarcs[3];
			var_06 playerlinktodelta(var_08.playerlinkent,"tag_origin",1,var_0C,var_0D,var_0E,var_0F);
			var_08.playerlinkent moveto(var_0B.origin + var_04,var_03,var_03,0);
			var_06 thread player_teleport_unlink(var_03);
		}

		if(isdefined(level.zmteleporterroomenter))
		{
			[[ level.zmteleporterroomenter ]](param_00,param_02);
		}

		level.teleportroomindex++;
		level.teleportroomindex = level.teleportroomindex % level.teleportrooms.size;
	}

	wait(var_03);
}

//Function Number: 16
teleport_players(param_00)
{
	if(!param_00.size)
	{
		return;
	}

	if(isdefined(level.teleportroomindex))
	{
		teleport_players_through_chute(param_00);
	}
	else if(isdefined(level.zmteleporterplayers))
	{
		[[ level.zmteleporterplayers ]](param_00);
	}

	var_01 = self.locations;
	if(isdefined(self.overridelocations))
	{
		var_01 = self.overridelocations;
		self.overridelocations = undefined;
	}

	while(isdefined(var_01) && var_01.size)
	{
		var_02 = common_scripts\utility::random(var_01);
		foreach(var_04 in param_00)
		{
			var_05 = var_02.origin;
			var_06 = var_02.angles;
			if(var_02.playerlocations.size)
			{
				var_05 = var_02.playerlocations[var_02.nextplayloc].origin;
				var_06 = var_02.playerlocations[var_02.nextplayloc].angles;
				var_02.nextplayloc++;
				var_02.nextplayloc = var_02.nextplayloc % var_02.playerlocations.size;
			}

			if(isdefined(var_04))
			{
				var_04 player_teleport(var_05,var_06);
			}
		}

		if(isdefined(var_02.fxloc))
		{
			playfx(common_scripts\utility::getfx("trash_chute_burst"),var_02.fxloc.origin,anglestoforward(var_02.fxloc.angles));
		}

		if(isdefined(var_02.script_wait))
		{
			wait(var_02.script_wait);
		}

		var_01 = var_02.locations;
	}

	if(isdefined(level.zmteleporterplayers))
	{
		self thread [[ level.zmteleporterplayers ]](param_00);
	}

	thread reset_teleport_flag_after_time(param_00,0.75);
}

//Function Number: 17
reset_teleport_flag_after_time(param_00,param_01)
{
	wait(param_01);
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03))
		{
			var_03.inteleport = 0;
		}
	}
}

//Function Number: 18
player_teleport(param_00,param_01)
{
	self setorigin(param_00,1);
	self setplayerangles(param_01);
}

//Function Number: 19
set_default_angles()
{
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}
}

//Function Number: 20
teleport_error(param_00)
{
}

//Function Number: 21
teleport_add_location(param_00)
{
	if(!isdefined(self.locations))
	{
		self.locations = [];
	}

	param_00 set_default_angles();
	if(!isdefined(param_00.playerlocations))
	{
		param_00.nextplayloc = 0;
		param_00.playerlocations = [];
	}

	if(isdefined(param_00.script_flag))
	{
		common_scripts\utility::flag_wait(param_00.script_flag);
	}

	if(isdefined(param_00.target))
	{
		var_01 = common_scripts\utility::getstructarray(param_00.target,"targetname");
		var_02 = [];
		foreach(var_04 in var_01)
		{
			var_05 = var_04.script_noteworthy;
			if(!isdefined(var_05))
			{
				var_05 = "end";
			}

			switch(var_05)
			{
				case "player":
					var_04 set_default_angles();
					param_00.playerlocations[param_00.playerlocations.size] = var_04;
					break;

				case "end":
					var_02[var_02.size] = var_04;
					break;

				case "fx":
					var_04 set_default_angles();
					param_00.fxloc = var_04;
					break;

				default:
					break;
			}
		}

		if(var_02.size)
		{
			foreach(var_08 in var_02)
			{
				param_00 thread teleport_add_location(var_08);
			}

			if(!self.locations.size)
			{
				param_00 waittill("location_added");
			}
		}
	}

	self notify("location_added");
	self.locations[self.locations.size] = param_00;
}
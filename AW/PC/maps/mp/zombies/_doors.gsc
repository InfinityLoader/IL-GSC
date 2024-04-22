/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_doors.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 391 ms
 * Timestamp: 4/22/2024 2:13:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	common_scripts\utility::flag_init("door_opened");
	if(!isdefined(level.doorhintstrings))
	{
		level.doorhintstrings = [];
	}

	level.zombiedoors = common_scripts\utility::getstructarray("door","targetname");
	common_scripts\utility::array_thread(level.zombiedoors,::init_door);
}

//Function Number: 2
init_door()
{
	self.door_type = self.script_noteworthy;
	if(!isdefined(self.door_type))
	{
		self.door_type = "normal";
	}

	switch(self.door_type)
	{
		case "normal":
			thread init_door_normal();
			break;

		default:
			break;
	}
}

//Function Number: 3
door_set_cost(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	self.cost = param_00;
	foreach(var_02 in self.triggers)
	{
		var_02 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.cost));
	}
}

//Function Number: 4
init_door_normal()
{
	self.triggers = [];
	self.movers = [];
	self.blood = 0;
	if(!isdefined(self.target))
	{
		door_error("Door struct without any targets at " + self.origin + ".");
		return;
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02.script_noteworthy;
		if(!isdefined(var_03) && isdefined(var_02.classname))
		{
			switch(var_02.classname)
			{
				case "script_brushmodel":
				case "script_model":
					var_03 = "mover";
					break;

				case "trigger_use_touch":
				case "trigger_use":
					var_03 = "trigger";
					break;
			}
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		switch(var_03)
		{
			case "trigger":
				if(init_door_trigger(var_02))
				{
					self.triggers[self.triggers.size] = var_02;
				}
				break;

			case "mover":
				if(init_door_mover(var_02))
				{
					self.movers[self.movers.size] = var_02;
				}
				break;

			case "trap":
				self.traptrigger = var_02;
				break;

			default:
				door_error("Unknown ent type \'" + var_03 + "\' on entity at " + var_02.origin + ".");
				break;
		}
	}

	if(self.triggers.size && self.movers.size)
	{
		run_door();
	}
}

//Function Number: 5
init_door_trigger(param_00)
{
	return 1;
}

//Function Number: 6
init_door_mover(param_00)
{
	if(!isdefined(param_00.target))
	{
		door_error("Door mover without a target key at " + self.origin + ".");
		return 0;
	}

	param_00.closed_pos = param_00.origin;
	param_00.is_door = 1;
	param_00.blood = [];
	param_00.movegoals = [];
	var_01 = common_scripts\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03.script_noteworthy;
		if(!isdefined(var_04))
		{
			var_04 = "goal";
		}

		switch(var_04)
		{
			case "goal":
				param_00.movegoals[param_00.movegoals.size] = var_03;
				break;

			default:
				door_error("Unknown door target struct type \'" + var_04 + "\' on struct at " + var_03.origin + ".");
				break;
		}
	}

	var_06 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_06)
	{
		var_04 = var_03.script_noteworthy;
		if(!isdefined(var_04))
		{
			var_04 = "link";
		}

		switch(var_04)
		{
			case "link_blood":
				param_00.blood[param_00.blood.size] = var_03;
				var_03 ghost();
				var_03 linkto(param_00);
				break;

			case "link":
				var_03 linkto(param_00);
				break;

			default:
				door_error("Unknown door target ent type \'" + var_04 + "\' on ent at " + var_03.origin + ".");
				break;
		}
	}

	if(param_00.movegoals.size > 0)
	{
		return 1;
	}

	door_error("Door mover at " + param_00.origin + "doesn\'t have a goal stuct.");
	return 0;
}

//Function Number: 7
all_doors_open()
{
	foreach(var_01 in level.zombiedoors)
	{
		if(!isdefined(var_01.open) && var_01.open)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
run_door()
{
	foreach(var_01 in self.triggers)
	{
		thread run_door_trigger(var_01);
	}

	self waittill("open",var_03);
	self.open = 1;
	if(isdefined(var_03))
	{
		var_03 thread maps\mp\zombies\_zombies_audio::moneyspend();
	}

	common_scripts\utility::flag_set("door_opened");
	if(isdefined(self.script_flag))
	{
		common_scripts\utility::flag_set(self.script_flag,var_03);
		if(isdefined(level.doorbitmaskarray[self.script_flag]))
		{
			level.doorsopenedbitmask = level.doorsopenedbitmask | level.doorbitmaskarray[self.script_flag];
		}
	}

	foreach(var_01 in self.triggers)
	{
		thread end_door_trigger(var_01);
	}

	foreach(var_07 in self.movers)
	{
		thread run_door_mover(var_07);
	}

	if(isdefined(self.traversalnodepairs))
	{
		for(var_09 = 0;var_09 < self.traversalnodepairs.size;var_09++)
		{
			connectnodepair(self.traversalnodepairs[var_09][0],self.traversalnodepairs[var_09][1]);
		}
	}

	thread run_door_trap();
}

//Function Number: 9
run_door_trigger(param_00)
{
	self endon("open");
	door_set_cost(self.script_count);
	thread run_door_hint(param_00);
	for(;;)
	{
		var_01 = param_00 maps\mp\zombies\_util::waittilltriggerortokenuse();
		var_02 = var_01[0];
		var_03 = var_01[1];
		if(!door_has_power())
		{
			continue;
		}

		if(var_03 == "token")
		{
			var_02 maps\mp\gametypes\zombies::spendtoken(param_00.tokencost);
			break;
		}
		else
		{
			var_04 = self.cost;
			if(var_02 maps\mp\gametypes\zombies::attempttobuy(var_04))
			{
				break;
			}
		}

		var_02 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
	}

	maps\mp\zombies\_zombies_audio_announcer::announcerdoordialog();
	self notify("open",var_02);
}

//Function Number: 10
run_door_trap()
{
	if(!isdefined(self.traptrigger))
	{
		return;
	}

	if(isdefined(self.traptrigger.target))
	{
		var_00 = common_scripts\utility::getstruct(self.traptrigger.target,"targetname");
		if(isdefined(var_00))
		{
			self.trapdir = anglestoforward(var_00.angles);
		}
	}

	foreach(var_02 in self.movers)
	{
		var_02.unresolved_collision_notify_min = 1;
		var_02.unresolved_collision_func = ::door_trap_kill;
		var_02.parent = self;
	}

	self.trapactive = 0;
	thread run_door_trap_trigger();
	for(;;)
	{
		self waittill("trap_trigger",var_04,var_05);
		self.trapowner = var_04;
		self.trapactive = 1;
		thread door_trap_end(var_05);
	}
}

//Function Number: 11
door_trap_end(param_00)
{
	self notify("door_trap_end");
	self endon("door_trap_end");
	wait(param_00);
	self.trapactive = 0;
}

//Function Number: 12
run_door_trap_trigger()
{
	var_00 = 0.1;
	for(;;)
	{
		self.traptrigger waittill("trigger",var_01);
		if(!self.trapactive)
		{
			continue;
		}

		if(isplayer(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\zombies\_util::isdoortrapimmune())
		{
			continue;
		}

		if(is_any_player_touching(self.traptrigger))
		{
			continue;
		}

		if(isdefined(self.trapdir))
		{
			var_02 = var_01 getvelocity();
			var_03 = var_01.origin - self.traptrigger.origin;
			var_04 = var_01.origin + var_02 * var_00 - self.traptrigger.origin;
			var_03 = (var_03[0],var_03[1],0);
			var_04 = (var_04[0],var_04[1],0);
			var_05 = vectordot(self.trapdir,var_03);
			var_06 = vectordot(self.trapdir,var_04);
			if(var_05 * var_06 > 0)
			{
				continue;
			}
		}

		foreach(var_08 in self.movers)
		{
			var_08 moveto(var_08.closed_pos,var_00,var_00);
			var_08 playsound("trap_security_door_slam");
		}

		wait(var_00);
		earthquake(0.2,0.5,self.traptrigger.origin,500);
		wait(0.1);
		var_0A = 1;
		foreach(var_08 in self.movers)
		{
			var_08 moveto(var_08.open_pos,var_0A);
			var_08 playsound("trap_security_door_reset");
		}

		wait(var_0A);
		wait(0.5);
	}
}

//Function Number: 13
door_trap_kill(param_00)
{
	if(!isdefined(param_00) || isplayer(param_00))
	{
		return;
	}

	if(param_00 maps\mp\zombies\_util::isdoortrapimmune())
	{
		return;
	}

	self.parent door_add_blood();
	param_00 dodamage(param_00.health,param_00.origin,self.parent.trapowner,self,"MOD_CRUSH","trap_zm_mp","torso_upper");
}

//Function Number: 14
door_add_blood()
{
	if(self.blood)
	{
		return;
	}

	self.blood = 1;
	foreach(var_01 in self.movers)
	{
		foreach(var_03 in var_01.blood)
		{
			var_03 show();
		}
	}
}

//Function Number: 15
is_any_player_touching(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 istouching(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
run_door_hint(param_00)
{
	self endon("open");
	if(door_requires_power())
	{
		for(;;)
		{
			if(!door_has_power())
			{
				param_00 sethintstring(&"ZOMBIES_REQUIRES_POWER");
				param_00 setsecondaryhintstring("");
				param_00 maps\mp\zombies\_util::tokenhintstring(0);
				common_scripts\utility::flag_wait(self.script_flag_true);
			}

			param_00 sethintstring(gethintstring(param_00));
			param_00 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(self.cost));
			param_00 maps\mp\zombies\_util::tokenhintstring(1);
			if(isdefined(self.script_flag_true))
			{
				common_scripts\utility::flag_waitopen(self.script_flag_true);
			}
		}

		return;
	}

	param_00 sethintstring(gethintstring(param_00));
	param_00 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(self.cost));
	param_00 maps\mp\zombies\_util::tokenhintstring(1);
}

//Function Number: 17
door_requires_power()
{
	return isdefined(self.script_flag_true);
}

//Function Number: 18
door_has_power()
{
	if(door_requires_power())
	{
		return common_scripts\utility::flag(self.script_flag_true);
	}

	return 1;
}

//Function Number: 19
end_door_trigger(param_00)
{
	param_00 sethintstring("");
	param_00 setsecondaryhintstring("");
	param_00 maps\mp\zombies\_util::tokenhintstring(0);
	if(level.currentgen)
	{
		param_00 delete();
	}
}

//Function Number: 20
run_door_mover(param_00)
{
	var_01 = common_scripts\utility::random(param_00.movegoals);
	param_00 moveto(var_01.origin,1);
	param_00.open_pos = var_01.origin;
	var_02 = "interact_door";
	if(isdefined(param_00.script_parameters))
	{
		if(soundexists(param_00.script_parameters))
		{
			var_02 = param_00.script_parameters;
		}
	}

	param_00 playsound(var_02);
	if(param_00 maps\mp\_movers::script_mover_is_dynamic_path())
	{
		param_00 connectpaths();
	}
}

//Function Number: 21
door_error(param_00)
{
}

//Function Number: 22
registerhintstring(param_00,param_01,param_02)
{
	if(!isdefined(level.doorhintstrings))
	{
		level.doorhintstrings = [];
	}

	if(!isdefined(level.doorhintstrings[param_01]))
	{
		level.doorhintstrings[param_01] = [];
	}

	level.doorhintstrings[param_01][param_02] = param_00;
}

//Function Number: 23
gethintstring(param_00)
{
	if(isdefined(param_00.script_flag) && isdefined(param_00.script_index))
	{
		var_01 = level.doorhintstrings[param_00.script_flag];
		if(isdefined(var_01) && isdefined(var_01[param_00.script_index]))
		{
			return var_01[param_00.script_index];
		}
	}

	return &"ZOMBIES_DOOR_BUY";
}

//Function Number: 24
doorhasbeenopened()
{
	return common_scripts\utility::flag_exist("door_opened") && common_scripts\utility::flag("door_opened");
}
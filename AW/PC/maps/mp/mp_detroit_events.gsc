/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_detroit_events.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 256 ms
 * Timestamp: 4/22/2024 2:17:22 AM
*******************************************************************/

//Function Number: 1
trams()
{
	level.trams = getentarray("ambient_tram","targetname");
	common_scripts\utility::array_thread(level.trams,::tram_init);
	var_00 = ["mp_detroit_train_01","mp_detroit_train_02"];
	foreach(var_02 in var_00)
	{
		precachempanim(var_02);
	}

	foreach(var_05 in level.trams)
	{
		var_05 playloopsound("mp_detroit_tram_close");
	}

	for(;;)
	{
		foreach(var_05 in level.trams)
		{
			if(!var_05.active)
			{
				var_08 = common_scripts\utility::random(var_00);
				var_05 thread tram_animate(var_08);
				break;
			}
		}

		wait(randomfloatrange(10,15));
	}
}

//Function Number: 2
object_init_reset()
{
	self.reset_origin = self.origin;
	self.reset_angles = self.angles;
}

//Function Number: 3
object_reset()
{
	self dontinterpolate();
	self.origin = self.reset_origin;
	self.angles = self.reset_angles;
}

//Function Number: 4
tram_init()
{
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
		foreach(var_02 in var_00)
		{
			var_02 linkto(self);
		}
	}

	self.active = 0;
	object_init_reset();
}

//Function Number: 5
tram_reset()
{
	object_reset();
}

//Function Number: 6
tram_spline_debug()
{
	for(;;)
	{
		while(self.active || !getdvarint("detroit_tram_spline_debug",0))
		{
			wait 0.05;
		}

		tram_reset();
		self.active = 1;
		var_00 = tram_spline_vehicle_spawn();
		var_00 waittill("playSpaceStart");
		var_00 thread tram_spline_stay_in_playspace();
		while(getdvarint("detroit_tram_spline_debug",0))
		{
			wait 0.05;
		}

		thread tram_spline_leave(var_00,40);
	}
}

//Function Number: 7
tram_spline_vehicle_spawn()
{
	var_00 = spawnvehicle("tag_origin","detroit_tram","detroit_tram_mp",self.origin,self.angles);
	var_00.owner = self.owner;
	var_01 = getvehiclenode(self.target,"targetname");
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = var_01;
	while(isdefined(var_05.target))
	{
		var_05 = getvehiclenode(var_05.target,"targetname");
		if(common_scripts\utility::string_starts_with(var_05.targetname,"play_space_edge"))
		{
			if(!isdefined(var_02))
			{
				var_02 = var_05;
				continue;
			}

			var_03 = var_05;
		}

		if(common_scripts\utility::string_starts_with(var_05.targetname,"track_end"))
		{
			var_04 = var_05;
		}
	}

	thread tram_node_notify(var_00,var_02,"playSpaceStart");
	thread tram_node_notify(var_00,var_03,"playSpaceEnd");
	thread tram_node_notify(var_00,var_04,"trackEnd");
	var_00 attachpath(var_01);
	var_00 startpath(var_01);
	var_00.spline_speed = 25;
	var_00.spline_accel = 15;
	var_00.spline_decel = 20;
	var_00.spline_fast_decel = var_00.spline_decel * 2;
	self linkto(var_00);
	return var_00;
}

//Function Number: 8
tram_spline_move(param_00)
{
	self.active = 1;
	var_01 = tram_spline_vehicle_spawn();
	self.endtime = gettime() + param_00 * 1000;
	self.owner setclientomnvar("ui_warbird_countdown",self.endtime);
	wait 0.05;
	var_02 = 40;
	var_01 tram_set_forward();
	var_01 vehicle_setspeedimmediate(var_02,var_01.spline_accel,var_01.spline_decel);
	var_01 tram_stop_player_control();
	var_03 = common_scripts\utility::waittill_any_return("playSpaceStart","player_exit");
	if(var_03 != "player_exit")
	{
		var_01 tram_start_player_control();
		var_01 thread tram_spline_stay_in_playspace(::tram_start_player_control,::tram_stop_player_control);
		common_scripts\utility::waittill_notify_or_timeout("player_exit",self.endtime - gettime() / 1000);
	}

	var_01 tram_stop_player_control();
	thread tram_spline_leave(var_01,var_02);
}

//Function Number: 9
tram_spline_leave(param_00,param_01)
{
	param_00 notify("stop_stay_in_playspace");
	param_00 tram_set_forward();
	param_00 vehicle_setspeed(param_01,param_00.spline_accel,param_00.spline_decel);
	param_00 waittill("trackEnd");
	self unlink();
	param_00 delete();
	maps\mp\_utility::decrementfauxvehiclecount();
	self.active = 0;
}

//Function Number: 10
tram_spline_stay_in_playspace(param_00,param_01)
{
	self endon("stop_stay_in_playspace");
	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("playSpaceStart","playSpaceEnd");
		if(isdefined(param_01))
		{
			self [[ param_01 ]]();
		}

		self vehicle_setspeed(0,self.spline_accel,self.spline_fast_decel);
		while(self.veh_speed != 0)
		{
			wait 0.05;
		}

		if(var_02 == "playSpaceStart")
		{
			tram_set_forward();
		}
		else
		{
			tram_set_reverse();
		}

		self vehicle_setspeed(self.spline_speed,self.spline_accel,self.spline_decel);
		self waittill(var_02);
		if(isdefined(param_00))
		{
			self [[ param_00 ]]();
		}
	}
}

//Function Number: 11
tram_node_notify(param_00,param_01,param_02)
{
	param_00 endon("death");
	for(;;)
	{
		param_01 waittill("trigger",var_03);
		if(var_03 == param_00)
		{
			param_00 notify(param_02);
			self notify(param_02);
		}
	}
}

//Function Number: 12
tram_set_forward()
{
	self.current_dir = "forward";
	self.veh_transmission = self.current_dir;
	self.veh_pathdir = self.current_dir;
}

//Function Number: 13
tram_set_reverse()
{
	self.current_dir = "reverse";
	self.veh_transmission = self.current_dir;
	self.veh_pathdir = self.current_dir;
}

//Function Number: 14
tram_start_player_control()
{
	thread tram_update_player_spline_control();
}

//Function Number: 15
tram_stop_player_control()
{
	self notify("stop_player_control");
}

//Function Number: 16
tram_update_player_spline_control()
{
	self endon("death");
	self endon("player_exit");
	self endon("stop_player_control");
	var_00 = self.owner;
	var_00 endon("disconnect");
	self setacceleration(self.spline_accel);
	self setdeceleration(self.spline_decel);
	for(;;)
	{
		var_01 = var_00 getnormalizedmovement();
		var_02 = var_01[0];
		var_03 = var_01[1];
		var_04 = var_00 getnormalizedmovement();
		var_05 = length(var_04);
		if(var_05 < 0.1)
		{
			self vehicle_setspeed(0);
		}
		else
		{
			var_06 = var_00 getplayerangles();
			var_04 = (var_04[0],var_04[1] * -1,0);
			var_07 = vectortoangles(var_04);
			var_07 = common_scripts\utility::flat_angle(combineangles(var_07,var_06));
			var_04 = anglestoforward(var_07);
			var_08 = anglestoforward(self.angles);
			var_09 = vectordot(var_04,var_08);
			if(var_09 > 0)
			{
				if(self.current_dir != "forward" && self.veh_speed != 0)
				{
					self vehicle_setspeed(0,self.spline_accel,self.spline_fast_decel);
				}
				else if(self.current_dir != "forward")
				{
					tram_set_forward();
				}
				else
				{
					self vehicle_setspeed(self.spline_speed,self.spline_accel,self.spline_decel);
				}
			}
			else if(self.current_dir != "reverse" && self.veh_speed != 0)
			{
				self vehicle_setspeed(0,self.spline_accel,self.spline_fast_decel);
			}
			else if(self.current_dir != "reverse")
			{
				tram_set_reverse();
			}
			else
			{
				self vehicle_setspeed(self.spline_speed,self.spline_accel,self.spline_decel);
			}
		}

		wait 0.05;
	}
}

//Function Number: 17
tram_animate(param_00)
{
	var_01 = common_scripts\utility::getstruct("tram_node","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	self.active = 1;
	self scriptmodelplayanimdeltamotionfrompos(param_00,var_01.origin,var_01.angles,"tram_anim");
	self waittillmatch("end","tram_anim");
	self.active = 0;
}

//Function Number: 18
tram_move(param_00,param_01)
{
	self endon("dropped");
	var_02 = 3.14159;
	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.active = 1;
	for(var_03 = self;isdefined(var_03.target);var_03 = var_04)
	{
		var_04 = common_scripts\utility::getstruct(var_03.target,"targetname");
		var_05 = param_00;
		var_06 = undefined;
		if(isdefined(var_04.script_noteworthy))
		{
			switch(var_04.script_noteworthy)
			{
				case "fast":
					var_05 = param_01;
					break;

				case "clockwise_fast":
					var_05 = param_01;
					var_06 = -90;
					break;

				case "clockwise":
					var_06 = -90;
					break;

				case "counterclockwise_fast":
					var_05 = param_01;
					var_06 = 90;
					break;

				case "counterclockwise":
					var_06 = 90;
					break;

				default:
					break;
			}
		}

		if(isdefined(var_06))
		{
			var_07 = spawn("script_origin",var_04.origin);
			self vehicle_jetbikesethoverforcescale(var_07);
			var_08 = distance(var_07.origin,self.origin);
			var_09 = var_08 * 2 * var_02;
			var_0A = var_09 * abs(var_06) / 360;
			var_0B = var_0A / var_05;
			var_07 rotateyaw(var_06,var_0B);
			var_07 waittill("rotatedone");
			self unlink();
			var_07 delete();
			continue;
		}

		var_0A = distance(self.origin,var_04.origin);
		var_0B = var_0A / var_05;
		self moveto(var_04.origin,var_0B);
		self waittill("movedone");
	}

	self.active = 0;
}
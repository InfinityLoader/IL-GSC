/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _grapple_traverse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 237 ms
 * Timestamp: 4/22/2024 2:21:17 AM
*******************************************************************/

//Function Number: 1
grapple_traverse(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.grapple_traverse_init))
	{
		grapple_traverse_init();
	}

	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self.istraversing = 1;
	self.grapple_end_anim = param_03;
	self.grapple_target_ent = param_01;
	self.grapple_end_events = ["death","killgrapple","traverse_finish"];
	if(!isdefined(param_01))
	{
		self.grapple_end_events[self.grapple_end_events.size] = "killanimscript";
	}

	foreach(var_05 in self.grapple_end_events)
	{
		self endon(var_05);
	}

	self traversemode("nogravity");
	self traversemode("noclip");
	if(!isdefined(param_01))
	{
		self.traversestartnode = self getnegotiationstartnode();
		self.traverseendnode = self getnegotiationendnode();
	}

	thread grapple_traverse_cleanup(self.traverseendnode);
	var_07 = (0,0,0);
	var_08 = (0,0,0);
	var_09 = (1,0,0);
	if(isdefined(param_01) && isdefined(param_02))
	{
		var_07 = param_01 gettagorigin(param_02);
		var_09 = var_07 - self.origin;
	}
	else if(isdefined(param_01))
	{
		var_07 = param_01.origin;
		var_09 = var_07 - self.origin;
	}
	else
	{
		var_07 = trace_end_position(self.traversestartnode,self.traverseendnode);
		var_09 = self.traverseendnode.origin - var_07;
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
		var_08 = param_01 gettagangles(param_02);
	}
	else if(isdefined(param_01))
	{
		var_08 = param_01.angles;
	}
	else
	{
		var_08 = self.traverseendnode.origin - var_07;
		var_08 = (var_08[0],var_08[1],0);
		var_08 = vectortoangles(var_08);
	}

	self.grapple_end_ent = common_scripts\utility::spawn_tag_origin();
	self.grapple_end_ent.origin = var_07;
	self.grapple_end_ent.angles = var_08;
	if(isdefined(param_01))
	{
		self.grapple_end_ent linkto(param_01);
	}

	self.grapple_end_ent thread grapple_delete_monitor(self);
	var_0A = self.origin;
	grapple_add_void_point(self.grapple_end_ent.origin,64,grapple_travel_time(var_0A,self.grapple_end_ent.origin) + 2);
	self orientmode("face angle",vectortoyaw(self.grapple_end_ent.origin - var_0A));
	if(isdefined(param_00))
	{
		self.grapple_config = level.grapple_traverse_configs[param_00];
	}
	else
	{
		var_0B = angleclamp180(vectortoangles(self.grapple_end_ent.origin - var_0A)[0]);
		foreach(var_0D in level.grapple_traverse_configs)
		{
			if(var_0B > var_0D[0] && var_0B <= var_0D[1])
			{
				self.grapple_config = var_0D;
				break;
			}
		}

		if(!isdefined(self.grapple_config))
		{
			self.grapple_config = level.grapple_traverse_configs[0];
		}
	}

	var_09 = vectornormalize((var_09[0],var_09[1],0));
	grapple_fire(var_09);
	grapple_travel(self.origin,self.angles);
	grapple_land();
	self notify("traverse_finish");
}

//Function Number: 2
grapple_delete_monitor(param_00)
{
	self endon("death");
	if(isdefined(param_00) && isdefined(param_00.grapple_end_events))
	{
		param_00 common_scripts\utility::waittill_any(param_00.grapple_end_events[0],param_00.grapple_end_events[1],param_00.grapple_end_events[2],param_00.grapple_end_events[3],param_00.grapple_end_events[4],param_00.grapple_end_events[5]);
	}

	self delete();
}

//Function Number: 3
grapple_traverse_cleanup(param_00)
{
	var_01 = common_scripts\utility::waittill_any_return(self.grapple_end_events[0],self.grapple_end_events[1],self.grapple_end_events[2],self.grapple_end_events[3],self.grapple_end_events[4],self.grapple_end_events[5]);
	if(isdefined(param_00) && var_01 == "killanimscript")
	{
		self forceteleport(param_00.origin,self.angles,10000);
	}

	if(isdefined(self))
	{
		self.istraversing = undefined;
		self.grapple_land_over = undefined;
		self.grapple_config = undefined;
		self.grapple_end_anim = undefined;
		self.grapple_end_ent = undefined;
		self.grapple_target_ent = undefined;
		self.grapple_end_events = undefined;
	}
}

//Function Number: 4
grapple_traverse_init()
{
	level.grapple_traverse_init = 1;
	var_00 = [];
	var_00[var_00.size] = [-180,-80,%grapple_traverse_vert_enter,%grapple_traverse_vert_loop,%grapple_traverse_up_exit,%grapple_traverse_over_exit];
	var_00[var_00.size] = [-80,-55,%grapple_traverse_up_enter,%grapple_traverse_up_loop,%grapple_traverse_up_exit,%grapple_traverse_over_exit];
	var_00[var_00.size] = [-55,-15,%grapple_traverse_up_enter_45,%grapple_traverse_up_loop_45,%grapple_traverse_up_exit_45,%grapple_traverse_over_exit_45];
	var_00[var_00.size] = [-15,15,%grapple_traverse_horiz_enter,%grapple_traverse_horiz_loop,%grapple_traverse_horiz_exit,%grapple_traverse_horiz_over_exit];
	var_00[var_00.size] = [15,180,%grapple_traverse_horiz_enter,%grapple_traverse_horiz_loop,%grapple_traverse_horiz_exit,%grapple_traverse_horiz_over_exit];
	level.grapple_traverse_configs = var_00;
}

//Function Number: 5
grapple_animate(param_00,param_01,param_02)
{
	foreach(var_04 in self.grapple_end_events)
	{
		self endon(var_04);
	}

	if(!isdefined(self.grapple_config))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_06 = 0;
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}

	self.traverseanim = param_00;
	if(isdefined(self.grapple_target_ent))
	{
		self animscripted("grappleanim",self.origin,vectortoangles(self.grapple_end_ent.origin - self.origin),param_00);
	}
	else
	{
		self setflaggedanimknoball("grappleanim",param_00,%body,1,var_06,1);
	}

	self setanimtime(param_00,0);
	thread animscripts\shared::donotetracks("grappleanim");
	wait(max(getanimlength(param_00) - param_01,0));
}

//Function Number: 6
grapple_anim_lerp(param_00,param_01,param_02)
{
	foreach(var_04 in self.grapple_end_events)
	{
		self endon(var_04);
	}

	self endon(param_02);
	var_06 = distance(param_01,self.grapple_end_ent.origin);
	if(var_06 <= 0)
	{
		return;
	}

	for(;;)
	{
		var_07 = distance(self.origin,self.grapple_end_ent.origin);
		var_08 = clamp(1 - var_07 / var_06,0.0001,0.9999);
		self setanimtime(param_00,var_08);
		wait(0.05);
	}
}

//Function Number: 7
grapple_fire(param_00)
{
	if(!isdefined(self.grapple_config))
	{
		return;
	}

	var_01 = self.grapple_end_ent.origin - (0,0,8);
	if(isdefined(self.grapple_target_ent))
	{
		var_01 = self.grapple_end_ent.origin;
		self.grapple_surface_type = "metal";
	}
	else
	{
		var_02 = bullettrace(var_01,var_01 + param_00 * 60,0);
		var_01 = var_02["position"];
		self.grapple_surface_type = var_02["surfacetype"];
	}

	thread grapple_fire_rope_thread(var_01,param_00);
	grapple_animate(self.grapple_config[2],0,0.2);
	self notify("traverse_grapple_fired");
}

//Function Number: 8
grapple_fire_rope_thread(param_00,param_01)
{
	self endon("death");
	self waittillmatch("grapple_fire","grappleanim");
	maps\_grapple::aud_grapple_launch();
	magicbullet("s1_grapple_impact",param_00 + param_01 * -1,param_00 + param_01,level.player);
	var_02 = maps\_utility::spawn_anim_model("grapple_rope",self gettagorigin("tag_weapon_left"));
	var_02 linkto(self,"tag_weapon_left",(0,0,0),(0,0,0));
	var_02 thread maps\_anim::anim_single_solo(var_02,"fire_third_person");
	var_02 show();
	var_03 = maps\_utility::spawn_anim_model("grapple_rope_stretch",param_00);
	var_03 show();
	if(isdefined(self.grapple_target_ent))
	{
		var_03 linkto(self.grapple_target_ent);
	}

	var_02 drawfacingentity(var_03);
	var_03 drawfacingentity(var_02);
	if(distancesquared(param_00,self gettagorigin("tag_weapon_left")) > 64009)
	{
		var_03 thread maps\_grapple::grapple_rope_length_thread(var_02,1);
	}
	else
	{
		var_03 thread maps\_grapple::grapple_rope_length_thread(var_02,2);
		var_02 hide();
	}

	var_03 thread grapple_delete_monitor(self);
	var_02 thread grapple_delete_monitor(self);
	self waittill("traverse_grapple_fired");
	if(isdefined(var_02))
	{
		var_02 hide();
	}

	if(isdefined(var_03))
	{
		var_03 thread maps\_grapple::grapple_rope_length_thread(var_02,2);
	}

	self waittill("traverse_grapple_traveled");
	if(isdefined(var_03))
	{
		var_03 delete();
	}

	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 9
grapple_travel_time(param_00,param_01)
{
	var_02 = distance(param_00,param_01) / 600;
	return var_02;
}

//Function Number: 10
grapple_travel(param_00,param_01)
{
	if(!isdefined(self.grapple_config))
	{
		return;
	}

	self endon("death");
	self.grapple_end_ent endon("death");
	var_02 = grapple_end_anim();
	self setanimtime(var_02,0);
	var_03 = getstartorigin(self.grapple_end_ent.origin,self.grapple_end_ent.angles,var_02);
	var_04 = getstartangles(self.grapple_end_ent.origin,self.grapple_end_ent.angles,var_02);
	var_05 = vectortoyaw(self.grapple_end_ent.origin - param_00);
	var_06 = grapple_travel_time(param_00,var_03);
	var_07 = self.grapple_config[3];
	thread grapple_animate(var_07);
	thread grapple_anim_lerp(var_07,param_00,"traverse_grapple_traveled");
	var_08 = common_scripts\utility::spawn_tag_origin();
	var_08.origin = param_00;
	var_08.angles = param_01;
	self linkto(var_08,"tag_origin",(0,0,0),(0,0,0));
	if(var_06 > 0)
	{
		var_08 moveto(var_03,var_06,0,0,self.grapple_end_ent);
	}

	var_08 thread grapple_delete_monitor(self);
	while(var_06 >= 0)
	{
		self orientmode("face angle",var_05);
		var_06 = var_06 - 0.05;
		wait(0.05);
	}

	wait(0.05);
	self unlink();
	self orientmode("face angle",getstartangles(self.grapple_end_ent.origin,self.grapple_end_ent.angles,var_02)[1]);
	self notify("traverse_grapple_traveled");
}

//Function Number: 11
grapple_land()
{
	if(!isdefined(self.grapple_config))
	{
		return;
	}

	self endon("death");
	maps\_grapple::grapple_landing_sound(self.grapple_surface_type);
	self notify("stop_grapplesound_npc");
	var_00 = grapple_end_anim();
	self.traverseanim = var_00;
	self.traverseanimroot = %animscript_root;
	if(isdefined(self.grapple_target_ent))
	{
		self linkto(self.grapple_target_ent);
		self animscripted("grappleanim",self.grapple_end_ent.origin,self.grapple_end_ent.angles,var_00);
	}
	else
	{
		self setflaggedanimknoballrestart("grappleanim",var_00,%animscript_root,1,0,1);
	}

	childthread animscripts\shared::donotetracks("grappleanim",::animscripts\traverse\shared::handletraversenotetracks);
	wait(getanimlength(var_00));
	self notify("grappleanim","end");
	self notify("traverse_grapple_landed");
}

//Function Number: 12
grapple_end_anim()
{
	if(isdefined(self.grapple_end_anim))
	{
		return self.grapple_end_anim;
	}

	if(isdefined(self.grapple_land_over) && self.grapple_land_over)
	{
		return self.grapple_config[5];
	}

	return self.grapple_config[4];
}

//Function Number: 13
trace_end_position(param_00,param_01)
{
	var_02 = 32.5;
	var_03 = param_01.origin;
	var_04 = self aiphysicstrace(var_03,var_03 - (0,0,50),undefined,undefined,1,1,1);
	if(var_04["fraction"] < 1)
	{
		var_03 = var_04["position"];
	}

	var_05 = self.origin - var_03;
	var_06 = vectornormalize((var_05[0],var_05[1],0));
	if(isdefined(param_01.angles))
	{
		var_06 = anglestoforward(param_01.angles) * -1;
	}

	var_03 = var_03 + var_06 * 100;
	var_03 = var_03 - (0,0,5);
	var_04 = self aiphysicstrace(var_03,(param_01.origin[0],param_01.origin[1],var_03[2]),undefined,undefined,1,1,1);
	if(var_04["fraction"] < 1)
	{
		var_03 = var_04["position"];
	}
	else
	{
		var_03 = var_03 + var_06 * 60;
	}

	var_07 = param_01.origin[2] - var_02;
	var_08 = (var_03[0],var_03[1],param_01.origin[2]) + (0,0,70) + var_06 * -10;
	var_04 = self aiphysicstrace(var_08,var_08 + (0,0,-100),undefined,undefined,1,1,1);
	if(var_04["fraction"] < 1)
	{
		var_07 = var_04["position"][2];
	}

	var_07 = var_07 + 0.5;
	var_03 = (var_03[0],var_03[1],var_07);
	var_03 = var_03 + var_06 * -15;
	if(vectordot(param_01.origin - var_03,var_06) > 0)
	{
		var_03 = (param_01.origin[0],param_01.origin[1],var_03[2]) + var_06;
	}

	self.grapple_land_over = var_07 - 16 > param_01.origin[2];
	return var_03;
}

//Function Number: 14
grapple_add_void_point(param_00,param_01,param_02)
{
	if(!isdefined(level.grapple_void_points))
	{
		level.grapple_void_points = [];
	}

	var_03 = spawnstruct();
	var_03.origin = param_00;
	var_03.radiussq = param_01 * param_01;
	var_03.endtime = gettime() + param_02 * 1000;
	var_04 = gettime();
	foreach(var_07, var_06 in level.grapple_void_points)
	{
		if(var_06.endtime <= var_04)
		{
			level.grapple_void_points[var_07] = var_03;
			return;
		}
	}

	level.grapple_void_points[level.grapple_void_points.size] = var_03;
}
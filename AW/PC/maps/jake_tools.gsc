/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: jake_tools.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 958 ms
 * Timestamp: 4/22/2024 2:32:18 AM
*******************************************************************/

//Function Number: 1
create_overlay_element(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	var_02 setshader(param_00,640,480);
	var_02.alignx = "left";
	var_02.aligny = "top";
	var_02.sort = 1;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = param_01;
	var_02.foreground = 1;
	return var_02;
}

//Function Number: 2
hide_geo()
{
	self hide();
	self notsolid();
	if(self.spawnflags & 1)
	{
		self connectpaths();
	}
}

//Function Number: 3
hideall(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = getentarray("hide","script_noteworthy");
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		switch(var_02.classname)
		{
			case "script_vehicle":
				var_02 delete();
				break;

			case "script_model":
				var_02 hide();
				break;

			case "script_brushmodel":
				var_02 hide();
				var_02 notsolid();
				if(var_02.spawnflags & 1)
				{
					var_02 connectpaths();
				}
				break;

			case "trigger_multiple_flag_looking":
			case "trigger_multiple_flag_lookat":
			case "trigger_multiple_breachIcon":
			case "trigger_multiple_flag_set":
			case "trigger_use_touch":
			case "trigger_use":
			case "trigger_multiple":
			case "trigger_radius":
				var_02 common_scripts\utility::trigger_off();
				break;
		}
	}
}

//Function Number: 4
ai_notify(param_00,param_01)
{
	self endon("death");
	param_01 = int(param_01 * 1000);
	var_02 = gettime();
	var_03 = gettime();
	while(var_03 < var_02 + param_01)
	{
		wait(0.05);
		var_03 = gettime();
		self notify(param_00);
	}

	self notify("ai_notify_complete");
}

//Function Number: 5
get_all_ents_in_chain(param_00)
{
	var_01 = [];
	var_02 = self;
	var_03 = 0;
	while(isdefined(var_02.target))
	{
		wait(0.05);
		if(isdefined(var_02.target))
		{
			switch(param_00)
			{
				case "vehiclenode":
					var_02 = getvehiclenode(var_02.target,"targetname");
					break;

				case "pathnode":
					var_02 = getnode(var_02.target,"targetname");
					break;

				case "ent":
					var_02 = getent(var_02.target,"targetname");
					break;

				default:
					break;
			}

			var_01[var_01.size] = var_02;
			continue;
		}

		break;
	}

	if(var_01.size > 0)
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 6
wait_for_level_notify_or_timeout(param_00,param_01)
{
	level endon(param_00);
	wait(param_01);
}

//Function Number: 7
get_ai_within_radius(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = getaiarray(param_02);
	}
	else
	{
		var_03 = getaiarray();
	}

	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		if(distance(param_01,self.origin) <= param_00)
		{
			common_scripts\utility::array_add(var_04,var_03[var_05]);
		}
	}

	return var_04;
}

//Function Number: 8
ai_stun(param_00)
{
	self endon("death");
	if(isdefined(self) && isalive(self) && maps\_utility::flashbangisactive())
	{
		maps\_utility::flashbangstart(param_00);
	}
}

//Function Number: 9
start_teleport(param_00)
{
	self forceteleport(param_00.origin,param_00.angles);
	self setgoalpos(self.origin);
	self setgoalnode(param_00);
}

//Function Number: 10
waittill_player_in_range(param_00,param_01)
{
	for(;;)
	{
		if(distance(param_00,level.player.origin) <= param_01)
		{
			break;
		}

		wait(0.5);
	}
}

//Function Number: 11
vehicle_go_to_end_and_delete(param_00,param_01)
{
	var_02 = getvehiclenode(param_00,"targetname");
	var_03 = "";
	switch(param_01)
	{
		case "truck":
			var_03 = "vehicle_pickup_4door";
			break;

		case "bmp":
			var_03 = "vehicle_bmp";
			break;

		default:
			break;
	}

	var_04 = spawnvehicle(var_03,"plane","truck",var_02.origin,var_02.angles);
	if(param_01 == "truck")
	{
		var_04 truck_headlights_on();
	}

	var_04 attachpath(var_02);
	var_04 startpath();
	var_04 vehicle_setspeed(23,20);
	var_04 waittill("reached_end_node");
	var_04 delete();
}

//Function Number: 12
truck_headlights_on()
{
	playfxontag(level._effect["headlight_truck"],self,"tag_headlight_left");
	playfxontag(level._effect["headlight_truck"],self,"tag_headlight_right");
}

//Function Number: 13
set_goalvolume(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_00))
	{
		param_01 = getent(param_00,"targetname");
	}

	var_02 = getnode(param_01.target,"targetname");
	self.goalvolume = param_01;
	self setgoalnode(var_02);
	self.goalradius = var_02.radius;
	self setgoalvolume(param_01);
}

//Function Number: 14
waittill_touching_entity(param_00)
{
	self endon("death");
	while(!self istouching(param_00))
	{
		wait(0.05);
	}
}

//Function Number: 15
reset_goalvolume()
{
	self endon("death");
	self setgoalpos(self.origin);
	self.goalvolume = undefined;
}

//Function Number: 16
print3dthread(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 0.25;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_01))
	{
		self notify("stop_3dprint");
		self endon("stop_3dprint");
		self endon("death");
		for(;;)
		{
			if(isdefined(self))
			{
			}

			wait(0.05);
		}

		return;
	}

	wait(0.05);
}

//Function Number: 17
smoke_detect()
{
	self endon("smoke_has_been_thrown");
	self.smokethrown = 0;
	while(self.smokethrown == 0)
	{
		wait(0.05);
		var_00 = getentarray("grenade","classname");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			if(var_00[var_01].model == "projectile_us_smoke_grenade")
			{
				if(var_00[var_01] istouching(self))
				{
					self.smokethrown = 1;
					self notify("smoke_has_been_thrown");
				}
			}
		}
	}
}

//Function Number: 18
dialogue_execute(param_00)
{
	self endon("death");
	maps\_utility::dialogue_queue(param_00);
}

//Function Number: 19
trigarraywait(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(var_01.size == 1)
	{
		trigwait(param_00);
		return;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] thread trigarraywait2(var_01);
	}

	var_01[0] waittill("trigger");
}

//Function Number: 20
trigarraywait2(param_00)
{
	self waittill("trigger");
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] notify("trigger");
		param_00[var_01] common_scripts\utility::trigger_off();
	}
}

//Function Number: 21
trigwait(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 waittill("trigger");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 22
triggersenable(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	if(param_02 == 1)
	{
		common_scripts\utility::array_thread(var_03,::common_scripts\utility::trigger_on);
		return;
	}

	common_scripts\utility::array_thread(var_03,::common_scripts\utility::trigger_off);
}

//Function Number: 23
triggeractivate(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 notify("trigger",level.player);
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 24
aa_ai_functions()
{
}

//Function Number: 25
look_at_position(param_00)
{
	var_01 = vectortoangles(self.origin - param_00.origin);
	self setpotentialthreat(var_01[1]);
}

//Function Number: 26
set_threatbias(param_00)
{
	if(!isdefined(self.old_threatbias))
	{
		self.old_threatbias = self.threatbias;
	}

	self.threatbias = param_00;
}

//Function Number: 27
reset_threatbias()
{
	if(isdefined(self.old_threatbias))
	{
		self.threatbias = self.old_threatbias;
	}

	self.old_threatbias = undefined;
}

//Function Number: 28
set_walkdist(param_00)
{
	if(!isdefined(self.old_walkdist))
	{
		self.old_walkdist = self.walkdist;
	}

	self.walkdist = param_00;
}

//Function Number: 29
reset_walkdist()
{
	if(isdefined(self.old_walkdist))
	{
		self.walkdist = self.old_walkdist;
	}

	self.old_walkdist = undefined;
}

//Function Number: 30
set_health(param_00)
{
	self.old_health = self.health;
	self.health = param_00;
}

//Function Number: 31
reset_health()
{
	if(isdefined(self.old_health))
	{
		self.health = self.old_health;
	}
}

//Function Number: 32
set_animname(param_00)
{
	if(!isdefined(self.old_animname))
	{
		self.old_animname = self.animname;
	}

	self.animname = param_00;
}

//Function Number: 33
reset_animname()
{
	if(isdefined(self.old_animname))
	{
		self.animname = self.old_animname;
	}

	self.old_animname = undefined;
}

//Function Number: 34
set_maxsightdistsqrd(param_00)
{
	if(!isdefined(self.old_maxsightdistsqrd))
	{
		self.old_maxsightdistsqrd = self.maxsightdistsqrd;
	}

	self.maxsightdistsqrd = param_00;
}

//Function Number: 35
reset_maxsightdistsqrd()
{
	if(isdefined(self.old_maxsightdistsqrd))
	{
		self.maxsightdistsqrd = self.old_maxsightdistsqrd;
	}

	self.old_maxsightdistsqrd = undefined;
}

//Function Number: 36
set_threatbiasgroup(param_00)
{
	if(!threatbiasgroupexists(param_00))
	{
	}

	if(!isdefined(self.old_threatbiasgroupname))
	{
		self.old_threatbiasgroupname = self.threatbiasgroupname;
	}

	self.threatbiasgroupname = param_00;
	self setthreatbiasgroup(param_00);
}

//Function Number: 37
reset_threatbiasgroup()
{
	if(isdefined(self.old_threatbiasgroupname))
	{
		self.threatbiasgroupname = self.old_threatbiasgroupname;
		self setthreatbiasgroup(self.old_threatbiasgroupname);
		if(!threatbiasgroupexists(self.old_threatbiasgroupname))
		{
		}
	}
	else
	{
		self.threatbiasgroupname = undefined;
		self setthreatbiasgroup();
	}

	self.old_threatbiasgroupname = undefined;
}

//Function Number: 38
setgoalradius(param_00)
{
	if(!isdefined(self.old_goalradius))
	{
		self.old_goalradius = self.goalradius;
	}

	self.goalradius = param_00;
}

//Function Number: 39
resetgoalradius()
{
	if(isdefined(self.old_goalradius))
	{
		self.goalradius = self.old_goalradius;
	}

	self.old_goalradius = undefined;
}

//Function Number: 40
setinterval(param_00)
{
	if(!isdefined(self.old_interval))
	{
		self.old_interval = self.interval;
	}

	self.interval = param_00;
}

//Function Number: 41
resetinterval()
{
	if(isdefined(self.old_interval))
	{
		self.interval = self.old_interval;
	}

	self.old_interval = undefined;
}

//Function Number: 42
set_accuracy(param_00)
{
	if(!isdefined(self.old_accuracy))
	{
		self.old_accuracy = self.baseaccuracy;
	}

	self.baseaccuracy = param_00;
}

//Function Number: 43
reset_accuracy()
{
	if(isdefined(self.old_accuracy))
	{
		self.baseaccuracy = self.old_accuracy;
	}

	self.old_accuracy = undefined;
}

//Function Number: 44
get_closest_ally(param_00)
{
	var_01 = undefined;
	if(!isdefined(param_00))
	{
		var_02 = level.player getorigin();
	}
	else
	{
		var_02 = var_01 getorigin();
	}

	if(isdefined(level.excludedai))
	{
		var_01 = maps\_utility::get_closest_ai_exclude(var_02,"allies",level.excludedai);
	}
	else
	{
		var_01 = maps\_utility::get_closest_ai(var_02,"allies");
	}

	return var_01;
}

//Function Number: 45
get_closest_axis()
{
	var_00 = maps\_utility::get_closest_ai(level.player getorigin(),"axis");
	return var_00;
}

//Function Number: 46
groupwarp(param_00,param_01)
{
	var_02 = getnodearray(param_01,"targetname");
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(isdefined(var_02[var_03]))
		{
			param_00[var_03] teleport(var_02[var_03].origin);
		}
	}
}

//Function Number: 47
getaiarraytouchingvolume(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = getent(param_01,"targetname");
	}

	if(param_00 == "all")
	{
		var_03 = getaiarray();
	}
	else
	{
		var_03 = getaiarray(param_01);
	}

	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		if(var_03[var_05] istouching(param_02))
		{
			var_04[var_04.size] = var_03[var_05];
		}
	}

	return var_04;
}

//Function Number: 48
npcdelete(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = [];
		param_03[0] = level.price;
	}

	var_04 = getent(param_00,"targetname");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 = undefined;
	if(param_01 == "all")
	{
		var_05 = getaiarray();
	}
	else
	{
		var_05 = getaiarray(param_01);
	}

	if(isdefined(param_03))
	{
		for(var_06 = 0;var_06 < param_03.size;var_06++)
		{
			if(maps\_utility::is_in_array(var_05,param_03[var_06]))
			{
				var_05 = common_scripts\utility::array_remove(var_05,param_03[var_06]);
			}
		}
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		if(var_05[var_06] istouching(var_04))
		{
			var_05[var_06] invulnerable(0);
			if(param_02 == 1)
			{
				var_05[var_06] kill((0,0,0));
				continue;
			}

			var_05[var_06] delete();
		}
	}
}

//Function Number: 49
getdudefromarray(param_00,param_01)
{
	var_02 = undefined;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(isdefined(param_00[var_03].script_noteworthy) && param_00[var_03].script_noteworthy == param_01)
		{
			var_02 = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 50
getdudesfromarray(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_01))
	{
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			if(isdefined(param_00[var_03].script_noteworthy) && param_00[var_03].script_noteworthy == param_01)
			{
				var_02[var_02.size] = param_00[var_03];
			}
		}
	}
	else
	{
	}

	if(var_02.size > 0)
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 51
gotonode(param_00)
{
	self endon("death");
	var_01 = getnode(param_00,"targetname");
	setgoalradius(var_01.radius);
	self setgoalnode(var_01);
	self waittill("goal");
	resetgoalradius();
}

//Function Number: 52
gotonodeanddelete(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	var_01 = getnode(param_00,"targetname");
	self setgoalnode(var_01);
	setgoalradius(var_01.radius);
	self waittill("goal");
	self delete();
}

//Function Number: 53
gotonodeandwait(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	var_01 = getnode(param_00,"targetname");
	self setgoalnode(var_01);
	setgoalradius(var_01.radius);
	self waittill("goal");
	set_animname("guy");
	self waittill("stop_waiting_at_node");
	resetgoalradius();
}

//Function Number: 54
forcetonode(param_00)
{
	self endon("death");
	var_01 = getnode(param_00,"targetname");
	self pushplayer(1);
	self setgoalnode(var_01);
	self waittill("goal");
	self pushplayer(0);
	resetgoalradius();
}

//Function Number: 55
setposture(param_00)
{
	if(param_00 == "all")
	{
		self allowedstances("stand","crouch","prone");
		return;
	}

	self allowedstances(param_00);
}

//Function Number: 56
invulnerable(param_00)
{
	if(param_00 == 0)
	{
		if(isdefined(self.magic_bullet_shield))
		{
			maps\_utility::stop_magic_bullet_shield();
		}
	}
	else if(!isdefined(self.magic_bullet_shield))
	{
		thread maps\_utility::magic_bullet_shield();
	}

	self.a.disablepain = param_00;
}

//Function Number: 57
killentity()
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	self.allowdeath = 1;
	invulnerable(0);
	self kill();
}

//Function Number: 58
gotovolume(param_00)
{
	self endon("death");
	var_01 = getent(param_00,"targetname");
	var_02 = getnode(var_01.target,"targetname");
	self setgoalnode(var_02);
	self setgoalvolume(var_01);
	self.goalradius = var_02.radius;
}

//Function Number: 59
aa_spawning_functions()
{
}

//Function Number: 60
aa_door_functions()
{
}

//Function Number: 61
door_open(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_01 == 1)
	{
		self playsound(level.scr_sound["snd_wood_door_kick"]);
	}

	if(self.classname == "script_brushmodel")
	{
		var_03 = getent(self.target,"targetname");
	}
	else
	{
		var_04 = getent(self.target,"targetname");
		var_03 = getent(var_04.script_linkto,"script_linkname");
	}

	switch(param_00)
	{
		case "explosive":
			thread door_fall_over();
			door_connectpaths(param_02);
			self playsound(level.scr_sound["snd_breach_wooden_door"]);
			earthquake(0.4,1,self.origin,1000);
			radiusdamage(self.origin,56,level.maxdetpackdamage,level.mindetpackdamage);
			break;

		case "kicked":
			self rotateyaw(-175,0.5);
			door_connectpaths(param_02);
			break;

		case "kicked_down":
			thread door_fall_over();
			door_connectpaths(param_02);
			break;

		default:
			self rotateyaw(-175,0.5);
			door_connectpaths();
			break;
	}

	var_05 = var_03.script_exploder;
	common_scripts\_exploder::exploder(var_05);
}

//Function Number: 62
door_connectpaths(param_00)
{
	if(self.classname == "script_brushmodel")
	{
		self connectpaths();
		return;
	}

	var_01 = getent(self.target,"targetname");
	var_01 hide();
	var_01 notsolid();
	var_01 connectpaths();
}

//Function Number: 63
door_fall_over()
{
	var_00 = anglestoforward(self.angles);
	var_01 = (var_00[0] * 20,var_00[1] * 20,var_00[2] * 20);
	self moveto(self.origin + var_01,0.5,0,0.5);
	self rotatepitch(90,0.45,0.4);
	wait(0.449);
	self rotatepitch(-4,0.2,0,0.2);
	wait(0.2);
	self rotatepitch(4,0.15,0.15);
}

//Function Number: 64
debug_circle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 16;
	var_07 = 360 / var_06;
	var_08 = [];
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		var_0A = var_07 * var_09;
		var_0B = cos(var_0A) * param_01;
		var_0C = sin(var_0A) * param_01;
		var_0D = param_00[0] + var_0B;
		var_0E = param_00[1] + var_0C;
		var_0F = param_00[2];
		var_08[var_08.size] = (var_0D,var_0E,var_0F);
	}

	if(isdefined(param_04))
	{
		wait(param_04);
	}

	thread debug_circle_drawlines(var_08,param_02,param_03,param_05,param_00);
}

//Function Number: 65
debug_circle_drawlines(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_03 = 0;
	}

	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_05 + 1 >= param_00.size)
		{
			var_07 = param_00[0];
		}
		else
		{
			var_07 = param_00[var_05 + 1];
		}

		thread debug_line(var_06,var_07,param_01,param_02);
		if(param_03)
		{
			thread debug_line(param_04,var_06,param_01,param_02);
		}
	}
}

//Function Number: 66
debug_line(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait(0.05);
	}
}
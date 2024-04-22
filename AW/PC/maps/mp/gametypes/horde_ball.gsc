/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\horde_ball.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 75
 * Decompile Time: 1085 ms
 * Timestamp: 4/22/2024 2:11:01 AM
*******************************************************************/

//Function Number: 1
setup()
{
	level.ball_starts = [];
	level.goal_starts = [];
	level.balls = [];
	level.goals = [];
	ball_create_goals();
	ball_create_ball_starts();
	ball_init_map_min_max();
	level._effect["ball_trail"] = loadfx("vfx/trail/vfx_uplink_ball_trl");
	level._effect["ball_idle"] = loadfx("vfx/unique/vfx_uplink_ball_idle");
	level._effect["ball_download"] = loadfx("vfx/trail/vfx_uplink_ball_trl2");
	level._effect["ball_download_end"] = loadfx("vfx/unique/vfx_uplink_ball_impact");
	level._effect["ball_goal_enemy"] = loadfx("vfx/unique/vfx_uplink_goal");
	level._effect["ball_goal_friendly"] = loadfx("vfx/unique/vfx_uplink_goal_friendly");
	level._effect["ball_goal_activated_enemy"] = loadfx("vfx/unique/vfx_uplink_ball_score");
	level._effect["ball_goal_activated_friendly"] = loadfx("vfx/unique/vfx_uplink_ball_score_friendly");
	level._effect["ball_teleport"] = loadfx("vfx/unique/vfx_uplink_ball_glow");
	level._effect["ball_physics_impact"] = loadfx("vfx/treadfx/footstep_dust");
	level.horde_ball_score_count = 5;
	level.horde_ball_score = 0;
	setomnvar("ui_uplink_num_balls",1);
}

//Function Number: 2
ball_create_ball_starts()
{
	var_00 = common_scripts\utility::getstructarray("ball_start","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,common_scripts\utility::getstructarray("ball_start_non_augmented","targetname"));
	var_00 = common_scripts\utility::array_combine(var_00,common_scripts\utility::getstructarray("horde_collect","targetname"));
	foreach(var_02 in var_00)
	{
		ball_add_start(var_02.origin);
	}
}

//Function Number: 3
ball_add_start(param_00)
{
	var_01 = 30;
	var_02 = spawnstruct();
	var_02.origin = param_00 + (0,0,var_01);
	var_02.in_use = 0;
	var_03 = undefined;
	var_04 = -1;
	foreach(var_06 in level.goal_starts)
	{
		var_07 = 99999999;
		var_07 = min(var_07,distance2dsquared(var_02.origin,var_06.origin));
		if(var_07 > var_04)
		{
			var_04 = var_07;
			var_03 = var_06;
		}
	}

	var_02.preferred_goal = var_03;
	level.ball_starts[level.ball_starts.size] = var_02;
}

//Function Number: 4
ball_init_map_min_max()
{
	level.ball_mins = (1000,1000,1000);
	level.ball_maxs = (-1000,-1000,-1000);
	var_00 = getallnodes();
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			level.ball_mins = maps\mp\gametypes\_spawnlogic::expandmins(level.ball_mins,var_02.origin);
			level.ball_maxs = maps\mp\gametypes\_spawnlogic::expandmaxs(level.ball_maxs,var_02.origin);
		}

		return;
	}

	level.ball_mins = level.spawnmins;
	level.ball_maxs = level.spawnmaxs;
}

//Function Number: 5
ball_create_goals()
{
	var_00 = common_scripts\utility::getstructarray("ball_goal_allies","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,common_scripts\utility::getstructarray("ball_goal_axis","targetname"));
	foreach(var_02 in var_00)
	{
		var_02.radius = 70;
		var_02.team = "axis";
		var_02.ball_in_goal = 0;
	}

	level.goal_starts = var_00;
}

//Function Number: 6
run_horde_ball()
{
	level endon("uplink_completed");
	level.horde_ball_score = 0;
	var_00 = 0;
	while(level.horde_ball_score < level.horde_ball_score_count)
	{
		level notify("next_horde_ball");
		ball_spawn(var_00);
		var_00 = 1;
		level waittill("horde_ball_scored");
		horde_ball_cleanup();
		wait(1);
	}
}

//Function Number: 7
ball_spawn(param_00)
{
	var_01 = common_scripts\utility::random(level.ball_starts);
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("prop_drone_sphere");
	var_02 thread physics_impact_watch();
	var_03 = 24;
	var_04 = getent("ball_pickup_1","targetname");
	if(isdefined(var_04))
	{
		var_04.origin = var_02.origin;
	}
	else
	{
		var_04 = spawn("trigger_radius",var_02.origin - (0,0,var_03 / 2),0,var_03,var_03);
	}

	if(!isdefined(var_04.linkto_on))
	{
		var_04 enablelinkto();
		var_04.linkto_on = 1;
	}

	var_04 linkto(var_02);
	var_04.no_moving_platfrom_unlink = 1;
	var_05 = maps\mp\gametypes\_gameobjects::createcarryobject("any",var_04,[var_02],(0,0,32));
	var_05.objectiveonvisuals = 1;
	var_05 maps\mp\gametypes\_gameobjects::allowcarry("any");
	var_05 ball_waypoint_neutral();
	var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_05.objidpingenemy = 1;
	var_05.objpingdelay = 1;
	var_05.allowweapons = 0;
	var_05.carryweapon = "iw5_carrydrone_mp";
	var_05.keepcarryweapon = 1;
	var_05.waterbadtrigger = 0;
	var_05.visualgroundoffset = (0,0,30);
	var_05.canuseobject = ::ball_can_pickup;
	var_05.onpickup = ::ball_on_pickup;
	var_05.setdropped = ::ball_set_dropped;
	var_05.onreset = ::ball_on_reset;
	var_05.carryweaponthink = ::ball_pass_shoot_watch;
	var_05.in_goal = 0;
	var_05.lastcarrierscored = 0;
	var_05.requireslos = 1;
	var_05 ball_assign_start(var_01);
	level.balls = [var_05];
	var_05 ball_fx_start();
	if(param_00)
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_incoming","horde",1,1);
	}

	var_05 ball_on_reset(1);
	level goal_spawn(var_01);
	var_05 thread ball_location_hud(0);
}

//Function Number: 8
ball_assign_start(param_00)
{
	foreach(var_02 in self.visuals)
	{
		var_02.baseorigin = param_00.origin;
	}

	self.trigger.baseorigin = param_00.origin;
	if(isdefined(self.current_start))
	{
		self.current_start.in_use = 0;
	}

	self.current_start = param_00;
	param_00.in_use = 1;
}

//Function Number: 9
ball_location_hud(param_00)
{
	self endon("death");
	level endon("next_horde_ball");
	if(param_00 > 4 || param_00 < 0)
	{
		return;
	}

	for(;;)
	{
		var_01 = common_scripts\utility::waittill_any_return("pickup_object","dropped","reset");
		switch(var_01)
		{
			case "pickup_object":
				if(isplayer(self.carrier))
				{
					setomnvar("ui_uplink_ball_carrier" + param_00 + 1,self.carrier getentitynumber());
				}
				break;
	
			case "dropped":
				setomnvar("ui_uplink_ball_carrier" + param_00 + 1,-2);
				break;
	
			case "reset":
				setomnvar("ui_uplink_ball_carrier" + param_00 + 1,-1);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 10
ball_fx_active()
{
	return isdefined(self.ball_fx_active) && self.ball_fx_active;
}

//Function Number: 11
ball_fx_start()
{
	if(!ball_fx_active())
	{
		var_00 = self.visuals[0];
		playfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"tag_origin");
		playfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"tag_origin");
		self.ball_fx_active = 1;
	}
}

//Function Number: 12
ball_fx_stop()
{
	if(ball_fx_active())
	{
		var_00 = self.visuals[0];
		stopfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"tag_origin");
		killfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"tag_origin");
	}

	self.ball_fx_active = 0;
}

//Function Number: 13
goal_spawn(param_00)
{
	var_01 = param_00.preferred_goal;
	var_01 set_goal_useobject();
	var_01 start_goal_fx();
	level.goals = [var_01];
}

//Function Number: 14
set_goal_useobject()
{
	self.trigger = spawn("trigger_radius",self.origin - (0,0,self.radius),0,self.radius,self.radius * 2);
	self.useobject = maps\mp\gametypes\_gameobjects::createuseobject(self.team,self.trigger,[],(0,0,self.radius * 2.1));
	self.useobject.goal = self;
	self.useobject maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_goal");
	self.useobject maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_goal");
	self.useobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	self.useobject maps\mp\gametypes\_gameobjects::allowuse("enemy");
	self.useobject maps\mp\gametypes\_gameobjects::setkeyobject(level.balls);
	self.useobject maps\mp\gametypes\_gameobjects::setusetime(0);
	self.useobject.onuse = ::ball_carrier_touched_goal;
	self.useobject.canuseobject = ::ball_goal_can_use;
}

//Function Number: 15
start_goal_fx()
{
	self.score_fx["friendly"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_friendly"),self.origin,(1,0,0));
	self.score_fx["enemy"] = spawnfx(common_scripts\utility::getfx("ball_goal_activated_enemy"),self.origin,(1,0,0));
	thread ball_play_fx_joined_team();
	foreach(var_01 in level.players)
	{
		ball_goal_fx_for_player(var_01);
	}
}

//Function Number: 16
ball_play_fx_joined_team()
{
	level endon("next_horde_ball");
	level endon("uplink_completed");
	for(;;)
	{
		level waittill("joined_team",var_00);
		ball_goal_fx_for_player(var_00);
	}
}

//Function Number: 17
ball_goal_fx_for_player(param_00)
{
	var_01 = ball_get_view_team(param_00);
	param_00 player_delete_ball_goal_fx();
	var_02 = common_scripts\utility::ter_op(self.team == var_01,"ball_goal_friendly","ball_goal_enemy");
	var_03 = spawnfxforclient(common_scripts\utility::getfx(var_02),self.origin,param_00,(1,0,0));
	setfxkillondelete(var_03,1);
	param_00.ball_goal_fx[var_02] = var_03;
	triggerfx(var_03);
}

//Function Number: 18
player_delete_ball_goal_fx()
{
	if(!isdefined(self.ball_goal_fx))
	{
		return;
	}

	foreach(var_01 in self.ball_goal_fx)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 19
horde_ball_cleanup()
{
	level notify("stop_horde_ball");
	foreach(var_01 in level.balls)
	{
		if(isdefined(var_01.carrier))
		{
			var_01 ball_set_dropped(1);
		}

		var_01 thread delete_horde_ball();
	}

	level.balls = [];
	foreach(var_04 in level.goals)
	{
		var_04.useobject maps\mp\gametypes\_gameobjects::set2dicon("enemy",undefined);
		var_04.useobject maps\mp\gametypes\_gameobjects::set3dicon("enemy",undefined);
		var_04.useobject maps\mp\gametypes\_gameobjects::deleteuseobject();
	}

	foreach(var_07 in level.players)
	{
		var_07 player_delete_ball_goal_fx();
	}

	level.goals = [];
}

//Function Number: 20
delete_horde_ball()
{
	while(isdefined(self.in_goal) && self.in_goal == 1)
	{
		wait(0.05);
	}

	if(isdefined(self.projectile))
	{
		self.projectile delete();
	}

	ball_fx_stop();
	ball_waypoint_clear();
	maps\mp\gametypes\_gameobjects::deletecarryobject();
}

//Function Number: 21
ball_waypoint_neutral()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball");
}

//Function Number: 22
ball_waypoint_held()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_friendly");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_enemy");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_friendly");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_enemy");
}

//Function Number: 23
ball_waypoint_upload()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_upload");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_upload");
}

//Function Number: 24
ball_waypoint_download()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_ball_download");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_ball_download");
}

//Function Number: 25
ball_waypoint_clear()
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",undefined);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",undefined);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",undefined);
}

//Function Number: 26
ball_play_local_team_sound(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::getotherteam(param_00);
	foreach(var_05 in level.players)
	{
		if(var_05.team == param_00)
		{
			var_05 playlocalsound(param_01);
			continue;
		}

		if(var_05.team == var_03)
		{
			var_05 playlocalsound(param_02);
		}
	}
}

//Function Number: 27
ball_score_sound(param_00)
{
	ball_play_local_team_sound(param_00,"mp_obj_notify_pos_lrg","mp_obj_notify_neg_lrg");
}

//Function Number: 28
physics_impact_watch()
{
	self endon("death");
	level endon("uplink_completed");
	for(;;)
	{
		self waittill("physics_impact",var_00,var_01,var_02,var_03);
		var_04 = level._effect["ball_physics_impact"];
		if(isdefined(var_03) && isdefined(level._effect["ball_physics_impact_" + var_03]))
		{
			var_04 = level._effect["ball_physics_impact_" + var_03];
		}

		playfx(var_04,var_00,var_01);
		wait(0.3);
	}
}

//Function Number: 29
ball_can_pickup(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		return 0;
	}

	if(isdefined(self.droptime) && self.droptime >= gettime())
	{
		return 0;
	}

	if(isdefined(param_00.agent_type) && param_00.agent_type == "dog")
	{
		return 0;
	}

	if(!param_00 common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(param_00 isusingturret())
	{
		return 0;
	}

	if(isdefined(param_00.manuallyjoiningkillstreak) && param_00.manuallyjoiningkillstreak)
	{
		return 0;
	}

	if(isdefined(param_00.using_remote_turret) && param_00.using_remote_turret)
	{
		return 0;
	}

	if(isdefined(param_00.inlaststand) && param_00.inlaststand)
	{
		return 0;
	}

	if(isdefined(param_00.usingarmory) && param_00.usingarmory)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(!valid_ball_pickup_weapon(var_01))
		{
			return 0;
		}
	}

	var_02 = param_00.changingweapon;
	if(isdefined(var_02) && param_00 isreloading())
	{
		if(!valid_ball_pickup_weapon(var_02))
		{
			return 0;
		}
	}

	if(isdefined(param_00.exo_shield_on) && param_00.exo_shield_on == 1)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(param_00 player_no_pickup_time())
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
valid_ball_pickup_weapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_00 == "iw5_carrydrone_mp")
	{
		return 0;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return 0;
	}

	if(param_00 == "iw5_combatknifegoliath_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
player_no_pickup_time()
{
	return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

//Function Number: 32
ball_on_pickup(param_00)
{
	var_01 = self.visuals[0] getlinkedparent();
	if(isdefined(var_01))
	{
		self.visuals[0] unlink();
	}

	self.visuals[0] physicsstop();
	self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
	self.visuals[0] show();
	self.visuals[0] ghost();
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	self.current_start.in_use = 0;
	var_02 = 0;
	if(isdefined(self.projectile))
	{
		var_02 = 1;
		self.projectile delete();
	}

	var_03 = param_00.team;
	var_04 = maps\mp\_utility::getotherteam(param_00.team);
	if(!var_02)
	{
		if(isplayer(param_00))
		{
			thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_acquire","horde",1,1);
		}
		else
		{
			thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_enemy","horde",1,1);
		}
	}
	else if(self.lastcarrierteam != param_00.team && isbot(param_00))
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_intercept","horde",1,1);
	}

	param_00 playsound("mp_ul_ball_catch");
	ball_play_local_team_sound(var_03,"mp_obj_notify_pos_sml","mp_obj_notify_neg_sml");
	ball_fx_stop();
	self.lastcarrierscored = 0;
	self.lastcarrier = param_00;
	self.lastcarrierteam = param_00.team;
	self.ownerteam = param_00.team;
	ball_waypoint_held();
	param_00 setweaponammoclip("iw5_carrydrone_mp",1);
	param_00 maps\mp\_utility::giveperk("specialty_ballcarrier",0);
	param_00.ball_carried = self;
	param_00.objective = 1;
	param_00.hasperksprintfire = param_00 hasperk("specialty_sprintfire",1);
	param_00 maps\mp\_utility::giveperk("specialty_sprintfire",0);
	param_00 common_scripts\utility::_disableusability();
	param_00 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
	param_00 thread player_update_pass_target(self);
	param_00 thread player_drop_on_last_stand();
	maps\mp\gametypes\_gamelogic::sethasdonecombat(param_00,1);
}

//Function Number: 33
player_drop_on_last_stand()
{
	self endon("death");
	self.ball_carried endon("dropped");
	level endon("uplink_completed");
	self waittill("player_start_last_stand");
	if(isdefined(self.ball_carried))
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_lost","horde",1,1);
		self.ball_carried thread ball_set_dropped(1);
	}
}

//Function Number: 34
player_update_pass_target(param_00)
{
	self endon("disconnect");
	self endon("cancel_update_pass_target");
	level endon("uplink_completed");
	if(!isdefined(self) || isbot(self))
	{
		return;
	}

	player_update_pass_target_hudoutline();
	childthread player_joined_update_pass_target_hudoutline();
	var_01 = 0.2;
	for(;;)
	{
		var_02 = undefined;
		if(!self isonladder())
		{
			var_03 = anglestoforward(self getplayerangles());
			var_04 = self geteye();
			var_05 = [];
			foreach(var_07 in level.players)
			{
				if(var_07.team != self.team)
				{
					continue;
				}

				if(!maps\mp\_utility::isreallyalive(var_07))
				{
					continue;
				}

				if(!param_00 ball_can_pickup(var_07))
				{
					continue;
				}

				var_08 = var_07 geteye();
				var_09 = distancesquared(var_08,var_04);
				if(var_09 > 1000000)
				{
					continue;
				}

				var_0A = vectornormalize(var_08 - var_04);
				var_0B = vectordot(var_03,var_0A);
				if(var_0B > var_01)
				{
					var_07.pass_dot = var_0B;
					var_07.pass_origin = var_08;
					var_05[var_05.size] = var_07;
				}
			}

			var_05 = maps\mp\_utility::quicksort(var_05,::compare_player_pass_dot);
			foreach(var_07 in var_05)
			{
				if(sighttracepassed(var_04,var_07.pass_origin,0,self,var_07))
				{
					var_02 = var_07;
					break;
				}
			}
		}

		player_set_pass_target(var_02);
		wait 0.05;
	}
}

//Function Number: 35
compare_player_pass_dot(param_00,param_01)
{
	return param_00.pass_dot >= param_01.pass_dot;
}

//Function Number: 36
player_update_pass_target_hudoutline()
{
	var_00 = [];
	var_01 = [];
	foreach(var_03 in level.participants)
	{
		if(isplayer(var_03))
		{
			var_00 = common_scripts\utility::array_add(var_00,var_03);
			continue;
		}

		var_01 = common_scripts\utility::array_add(var_01,var_03);
	}

	foreach(var_06 in var_00)
	{
		if(isplayer(self) && var_06 != self)
		{
			self hudoutlinedisableforclient(var_06);
			if(!isdefined(var_06.inlaststand) || !var_06.inlaststand)
			{
				var_06 hudoutlinedisableforclient(self);
			}
		}

		if(var_06 maps\mp\_utility::isjuggernaut())
		{
			continue;
		}

		if(level.currentaliveenemycount < 3)
		{
			continue;
		}

		foreach(var_08 in var_01)
		{
			var_08 hudoutlinedisableforclient(var_06);
		}
	}

	if(isdefined(self.carryobject))
	{
		if(isplayer(self))
		{
			foreach(var_06 in var_00)
			{
				if(var_06 == self)
				{
					continue;
				}

				if(var_06 maps\mp\_utility::isjuggernaut())
				{
					continue;
				}

				if(isdefined(var_06.inlaststand) && var_06.inlaststand)
				{
					continue;
				}

				if(isdefined(self.pass_target) && self.pass_target == var_06)
				{
					self hudoutlineenableforclient(var_06,1,0);
					var_06 hudoutlineenableforclient(self,1,0);
					continue;
				}

				self hudoutlineenableforclient(var_06,5,0);
				var_06 hudoutlineenableforclient(self,5,0);
			}

			if(level.currentaliveenemycount >= 3)
			{
				foreach(var_08 in var_01)
				{
					var_08 hudoutlineenableforclient(self,3,1);
				}

				return;
			}

			return;
		}

		foreach(var_08 in var_02)
		{
			if(var_08 maps\mp\_utility::isjuggernaut())
			{
				continue;
			}

			if(level.currentaliveenemycount < 3)
			{
				continue;
			}

			self hudoutlineenableforclient(var_08,0,0);
		}
	}
}

//Function Number: 37
player_joined_update_pass_target_hudoutline()
{
	self endon("cancel_update_pass_target");
	level endon("uplink_completed");
	for(;;)
	{
		level common_scripts\utility::waittill_any("participant_added","player_joined","player_last_stand");
		player_update_pass_target_hudoutline();
	}
}

//Function Number: 38
player_set_pass_target(param_00)
{
	if(isdefined(self.pass_target) && isdefined(param_00) && self.pass_target == param_00)
	{
		return;
	}

	if(!isdefined(self.pass_target) && !isremovedentity(self.pass_target) && !isdefined(param_00))
	{
		return;
	}

	player_clear_pass_target();
	if(isdefined(param_00))
	{
		var_01 = (0,0,80);
		self.pass_icon = param_00 maps\mp\_entityheadicons::setheadicon(self,"waypoint_ball_pass",var_01,10,10,0,0.05,0,1,0,0,"tag_origin");
		self.pass_target = param_00;
		self setclientomnvar("ui_uplink_can_pass",1);
		self setballpassallowed(1);
	}

	player_update_pass_target_hudoutline();
}

//Function Number: 39
player_clear_pass_target()
{
	if(isdefined(self.pass_icon))
	{
		self.pass_icon destroy();
	}

	self setclientomnvar("ui_uplink_can_pass",0);
	self.pass_target = undefined;
	self setballpassallowed(0);
	player_update_pass_target_hudoutline();
}

//Function Number: 40
ball_set_dropped(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.isresetting = 1;
	self.droptime = gettime();
	self notify("dropped");
	waittillframeend;
	var_01 = self.carrier;
	if(isdefined(var_01) && var_01.team != "spectator")
	{
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = self.safeorigin;
	}

	var_02 = var_02 + (0,0,40);
	var_03 = (0,0,0);
	for(var_04 = 0;var_04 < self.visuals.size;var_04++)
	{
		self.visuals[var_04].origin = var_02;
		self.visuals[var_04].angles = var_03;
		self.visuals[var_04] show();
	}

	self.trigger.origin = var_02;
	ball_dont_interpolate();
	self.curorigin = self.trigger.origin;
	ball_carrier_cleanup();
	ball_fx_start();
	self.ownerteam = "any";
	ball_waypoint_neutral();
	if(isdefined(var_01))
	{
		var_01 player_update_pass_target_hudoutline();
	}

	maps\mp\gametypes\_gameobjects::updatecompassicons();
	maps\mp\gametypes\_gameobjects::updateworldicons();
	self.isresetting = 0;
	if(!param_00)
	{
		ball_physics_launch((0,0,80));
	}

	var_05 = spawnstruct();
	var_05.carryobject = self;
	var_05.deathoverridecallback = ::ball_overridemovingplatformdeath;
	self.trigger thread maps\mp\_movers::handle_moving_platforms(var_05);
	return 1;
}

//Function Number: 41
ball_overridemovingplatformdeath(param_00)
{
}

//Function Number: 42
ball_dont_interpolate()
{
	self.visuals[0] dontinterpolate();
	self.ball_fx_active = 0;
}

//Function Number: 43
ball_carrier_cleanup()
{
	if(isdefined(self.carrier))
	{
		self.carrier.nopickuptime = gettime() + 500;
		self.carrier player_clear_pass_target();
		self.carrier notify("cancel_update_pass_target");
		self.carrier setballpassallowed(0);
		self.carrier setclientomnvar("ui_uplink_can_pass",0);
		self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
		if(!self.carrier.hasperksprintfire)
		{
			self.carrier maps\mp\_utility::_unsetperk("specialty_sprintfire");
		}

		self.carrier common_scripts\utility::_enableusability();
		self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
		self.carrier.objective = 0;
		var_00 = self.carrier;
		maps\mp\gametypes\_gameobjects::clearcarrier();
		var_00.ball_carried = undefined;
	}
}

//Function Number: 44
ball_on_reset(param_00)
{
	if(!isdefined(param_00) && param_00)
	{
		ball_assign_random_start();
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_reset","horde",1,1);
	}

	var_01 = self.visuals[0];
	var_01 maps\mp\_movers::notify_moving_platform_invalid();
	var_02 = var_01 getlinkedparent();
	if(isdefined(var_02))
	{
		var_01 unlink();
	}

	var_01 physicsstop();
	ball_dont_interpolate();
	if(isdefined(self.projectile))
	{
		self.projectile delete();
	}

	var_03 = "none";
	var_04 = self.lastcarrierteam;
	if(isdefined(var_04))
	{
		var_03 = maps\mp\_utility::getotherteam(var_04);
	}

	ball_carrier_cleanup();
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	ball_waypoint_download();
	maps\mp\gametypes\_gameobjects::setposition(var_01.baseorigin + (0,0,4000),(0,0,0));
	var_05 = 3;
	var_01 moveto(var_01.baseorigin,var_05,0,var_05);
	var_01 rotatevelocity((0,720,0),var_05,0,var_05);
	if(!isdefined(param_00) && param_00)
	{
		playsoundatpos(var_01.baseorigin,"uplink_ball_reset");
	}

	self.ownerteam = "any";
	thread ball_download_fx(var_01,var_05);
	thread ball_download_wait(var_05);
}

//Function Number: 45
ball_assign_random_start()
{
	var_00 = undefined;
	var_01 = common_scripts\utility::array_randomize(level.ball_starts);
	foreach(var_03 in var_01)
	{
		if(var_03.in_use)
		{
			continue;
		}

		var_00 = var_03;
		break;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	ball_assign_start(var_00);
}

//Function Number: 46
ball_download_fx(param_00,param_01)
{
	level endon("uplink_completed");
	playfxontag(level._effect["ball_download"],param_00,"tag_origin");
	common_scripts\utility::waittill_notify_or_timeout("pickup_object",param_01);
	stopfxontag(level._effect["ball_download"],param_00,"tag_origin");
}

//Function Number: 47
ball_download_wait(param_00)
{
	self endon("pickup_object");
	level endon("uplink_completed");
	wait(param_00);
	playfx(level._effect["ball_download_end"],self.current_start.origin);
	ball_waypoint_neutral();
	ball_fx_start();
}

//Function Number: 48
ball_pass_shoot_watch()
{
	thread ball_pass_watch();
	thread ball_shoot_watch();
}

//Function Number: 49
ball_pass_watch()
{
	self endon("ball_shoot");
	level endon("uplink_completed");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		self waittill("ball_pass",var_00);
		if(var_00 != "iw5_carrydrone_mp")
		{
			continue;
		}

		break;
	}

	self notify("ball_pass");
	if(isdefined(self.carryobject) && isdefined(self.pass_target))
	{
		thread ball_pass_or_throw_active();
		var_01 = self.pass_target;
		var_02 = self.pass_target.origin;
		wait(0.15);
		if(isdefined(self.pass_target))
		{
			var_01 = self.pass_target;
		}

		self playsound("mp_ul_ball_throw");
		self.carryobject thread ball_pass_projectile(self,var_01,var_02);
	}
}

//Function Number: 50
ball_shoot_watch()
{
	self endon("ball_pass");
	level endon("uplink_completed");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		self waittill("weapon_fired",var_00);
		if(var_00 != "iw5_carrydrone_mp")
		{
			continue;
		}

		break;
	}

	self notify("ball_shoot");
	if(isdefined(self.carryobject))
	{
		var_01 = getdvarfloat("scr_ball_shoot_extra_pitch",-12);
		var_02 = getdvarfloat("scr_ball_shoot_force",320);
		var_03 = self getplayerangles();
		var_03 = var_03 + (var_01,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		thread ball_pass_or_throw_active();
		wait(0.25);
		self playsound("mp_ul_ball_throw");
		self.carryobject thread ball_physics_launch_drop(var_04 * var_02,self);
	}
}

//Function Number: 51
ball_pass_or_throw_active()
{
	self endon("death");
	self endon("disconnect");
	level endon("uplink_completed");
	self.pass_or_throw_active = 1;
	self allowmelee(0);
	while("iw5_carrydrone_mp" == self getcurrentweapon())
	{
		wait 0.05;
	}

	self allowmelee(1);
	self.pass_or_throw_active = 0;
}

//Function Number: 52
ball_pass_projectile(param_00,param_01,param_02)
{
	ball_set_dropped(1);
	if(isdefined(param_01))
	{
		param_02 = param_01.origin;
	}

	var_03 = (0,0,40);
	var_04 = vectornormalize(param_02 + var_03 - self.visuals[0].origin);
	var_05 = var_04 * 1000;
	self.projectile = magicgrenademanual("gamemode_ball",self.visuals[0].origin,var_05,30,param_00,1);
	if(isdefined(param_01))
	{
		self.projectile missile_settargetent(param_01);
	}

	self.visuals[0] linkto(self.projectile);
	ball_dont_interpolate();
	ball_clear_contents();
	thread ball_on_projectile_hit_client();
	thread ball_on_projectile_death();
	thread ball_pass_touch_goal();
}

//Function Number: 53
ball_on_projectile_hit_client()
{
	self endon("pass_end");
	level endon("uplink_completed");
	self.projectile waittill("projectile_impact_player",var_00);
	self.trigger notify("trigger",var_00);
}

//Function Number: 54
ball_on_projectile_death()
{
	level endon("stop_horde_ball");
	level endon("uplink_completed");
	self.projectile waittill("death");
	if(!isdefined(self.carrier) && !self.in_goal)
	{
		ball_physics_launch((0,0,10));
	}

	ball_restore_contents();
	var_00 = self.visuals[0];
	var_00 notify("pass_end");
}

//Function Number: 55
ball_pass_touch_goal()
{
	var_00 = self.visuals[0];
	var_00 endon("pass_end");
	ball_touch_goal_watch(var_00);
}

//Function Number: 56
ball_physics_launch_drop(param_00,param_01)
{
	ball_set_dropped(1);
	ball_physics_launch(param_00,param_01);
}

//Function Number: 57
ball_touch_goal_watch(param_00)
{
	level endon("stop_horde_ball");
	level endon("uplink_completed");
	for(;;)
	{
		foreach(var_02 in level.goals)
		{
			if(!var_02.useobject ball_goal_can_use())
			{
				continue;
			}

			var_03 = distance(param_00.origin,var_02.origin);
			if(var_03 <= var_02.radius)
			{
				thread ball_touched_goal(var_02);
				return;
			}

			if(isdefined(param_00.origin_prev))
			{
				var_04 = line_interect_sphere(param_00.origin_prev,param_00.origin,var_02.origin,var_02.radius);
				if(var_04)
				{
					thread ball_touched_goal(var_02);
					return;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 58
ball_goal_can_use(param_00)
{
	var_01 = self.goal;
	if(var_01.ball_in_goal)
	{
		return 0;
	}

	return 1;
}

//Function Number: 59
ball_touched_goal(param_00)
{
	ball_play_score_fx(param_00);
	var_01 = param_00.team;
	var_02 = maps\mp\_utility::getotherteam(var_01);
	ball_score_sound(var_02);
	if(isdefined(self.lastcarrier))
	{
		self.lastcarrierscored = 1;
		self.lastcarrier thread maps\mp\gametypes\_rank::xppointspopup("horde_uplink",300);
	}

	thread ball_score_event(param_00,1);
}

//Function Number: 60
ball_play_score_fx(param_00)
{
	param_00.score_fx["friendly"] hide();
	param_00.score_fx["enemy"] hide();
	foreach(var_02 in level.players)
	{
		var_03 = ball_get_view_team(var_02);
		if(var_03 == param_00.team)
		{
			param_00.score_fx["friendly"] showtoplayer(var_02);
			continue;
		}

		param_00.score_fx["enemy"] showtoplayer(var_02);
	}

	triggerfx(param_00.score_fx["friendly"]);
	triggerfx(param_00.score_fx["enemy"]);
}

//Function Number: 61
ball_score_event(param_00,param_01)
{
	self notify("score_event");
	self.in_goal = 1;
	param_00.ball_in_goal = 1;
	var_02 = self.visuals[0];
	if(isdefined(self.projectile))
	{
		self.projectile delete();
	}

	var_02 physicsstop();
	maps\mp\gametypes\_gameobjects::allowcarry("none");
	ball_waypoint_upload();
	level.horde_ball_score = level.horde_ball_score + param_01;
	if(level.horde_ball_score < level.horde_ball_score_count)
	{
		thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_success","horde",1,1);
		if(param_01 > 1)
		{
			level thread maps\mp\gametypes\_horde_util::showteamsplashhorde("horde_uplink_touchdown");
		}
		else
		{
			level thread maps\mp\gametypes\_horde_util::showteamsplashhorde("horde_uplink_fieldgoal");
		}
	}

	level.currentpointtotal = level.currentpointtotal + 300 * param_01;
	level notify("pointsEarned");
	var_03 = 0.4;
	var_04 = 1.2;
	var_05 = 1;
	var_06 = var_03 + var_05;
	var_07 = var_06 + var_04;
	var_02 moveto(param_00.origin,var_03,0,var_03);
	var_02 rotatevelocity((1080,1080,0),var_07,var_07,0);
	wait(var_06);
	param_00.ball_in_goal = 0;
	var_02 movez(4000,var_04,var_04 * 0.1,0);
	wait(var_04);
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	self.in_goal = 0;
	level notify("horde_ball_scored");
}

//Function Number: 62
ball_carrier_touched_goal(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.carryobject))
	{
		return;
	}

	var_01 = self.goal.team;
	var_02 = maps\mp\_utility::getotherteam(var_01);
	ball_score_sound(var_02);
	ball_play_score_fx(self.goal);
	if(isdefined(param_00.shoot_charge_bar))
	{
		param_00.shoot_charge_bar.inuse = 0;
	}

	var_03 = param_00.carryobject;
	var_03.lastcarrierscored = 1;
	var_03 ball_set_dropped(1);
	var_03 thread ball_score_event(self.goal,2);
	param_00 thread maps\mp\gametypes\_rank::xppointspopup("horde_uplink",600);
}

//Function Number: 63
ball_return_home()
{
	self.in_goal = 0;
	var_00 = self.visuals[0];
	playfx(common_scripts\utility::getfx("ball_teleport"),var_00.origin);
	if(isdefined(self.carrier))
	{
		self.carrier maps\mp\_utility::delaythread(0.05,::player_update_pass_target_hudoutline);
	}

	thread maps\mp\gametypes\_gameobjects::returnhome();
}

//Function Number: 64
ball_clear_contents()
{
	self.visuals[0].old_contents = self.visuals[0] setcontents(0);
}

//Function Number: 65
ball_restore_contents()
{
	if(isdefined(self.visuals[0].old_contents))
	{
		self.visuals[0] setcontents(self.visuals[0].old_contents);
		self.visuals[0].old_contents = undefined;
	}
}

//Function Number: 66
line_interect_sphere(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = vectordot(var_04,param_00 - param_02);
	var_05 = var_05 * var_05;
	var_06 = param_00 - param_02;
	var_06 = var_06 * var_06;
	var_07 = param_03 * param_03;
	return var_05 - var_06 + var_07 >= 0;
}

//Function Number: 67
ball_get_view_team(param_00)
{
	var_01 = param_00.team;
	if(var_01 != "allies" && var_01 != "axis")
	{
		var_01 = "allies";
	}

	return var_01;
}

//Function Number: 68
ball_physics_launch(param_00,param_01)
{
	var_02 = self.visuals[0];
	var_02.origin_prev = undefined;
	ball_fx_start();
	var_02 physicslaunchserver(var_02.origin,param_00);
	thread ball_physics_touch_cant_pickup_player(param_01);
	thread ball_physics_out_of_level();
	thread ball_physics_timeout(param_01);
	thread ball_physics_bad_trigger_watch();
	thread ball_physics_touch_goal();
}

//Function Number: 69
ball_physics_touch_cant_pickup_player(param_00)
{
	var_01 = self.visuals[0];
	var_02 = self.trigger;
	var_01 endon("physics_finished");
	level endon("uplink_completed");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isdefined(param_00) && param_00 == var_03 && var_03 player_no_pickup_time())
		{
			continue;
		}

		if(self.droptime >= gettime())
		{
			continue;
		}

		if(!ball_can_pickup(var_03))
		{
			thread ball_physics_fake_bounce();
		}
	}
}

//Function Number: 70
ball_physics_out_of_level()
{
	level endon("stop_horde_ball");
	self endon("reset");
	self endon("pickup_object");
	level endon("uplink_completed");
	var_00 = self.visuals[0];
	var_01[0] = 200;
	var_01[1] = 200;
	var_01[2] = 1000;
	var_02[0] = 200;
	var_02[1] = 200;
	var_02[2] = 200;
	for(;;)
	{
		for(var_03 = 0;var_03 < 2;var_03++)
		{
			if(var_00.origin[var_03] > level.ball_maxs[var_03] + var_01[var_03])
			{
				ball_return_home();
				return;
			}

			if(var_00.origin[var_03] < level.ball_mins[var_03] - var_02[var_03])
			{
				ball_return_home();
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 71
ball_physics_timeout(param_00)
{
	self endon("reset");
	self endon("pickup_object");
	self endon("score_event");
	level endon("uplink_completed");
	var_01 = getdvarfloat("scr_ball_reset_time",15);
	var_02 = 10;
	var_03 = 3;
	if(var_01 >= var_02)
	{
		wait(var_03);
		var_01 = var_01 - var_03;
	}

	wait(var_01);
	ball_return_home();
}

//Function Number: 72
ball_physics_bad_trigger_watch()
{
	level endon("uplink_completed");
	self.visuals[0] endon("physics_finished");
	self.visuals[0] endon("death");
	thread ball_physics_bad_trigger_at_rest();
	wait(0.1);
	for(;;)
	{
		if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger())
		{
			ball_return_home();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 73
ball_physics_bad_trigger_at_rest()
{
	self endon("pickup_object");
	self endon("reset");
	self endon("score_event");
	level endon("uplink_completed");
	var_00 = self.visuals[0];
	var_00 endon("death");
	var_00 waittill("physics_finished");
	thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers("coop_gdn_satellite_lost","horde",1,1);
	if(maps\mp\gametypes\_gameobjects::istouchingbadtrigger())
	{
		ball_return_home();
	}
}

//Function Number: 74
ball_physics_fake_bounce()
{
	var_00 = self.visuals[0];
	if(!var_00 physicsisactive())
	{
		return;
	}

	var_01 = var_00 physicsgetlinvel();
	var_02 = length(var_01) / 10;
	var_03 = -1 * vectornormalize(var_01);
	var_00 physicsstop();
	var_00 physicslaunchserver(var_00.origin,var_03 * var_02);
}

//Function Number: 75
ball_physics_touch_goal()
{
	var_00 = self.visuals[0];
	var_00 endon("physics_finished");
	ball_touch_goal_watch(var_00);
}
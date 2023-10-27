/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_vehicle_aianim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 111
 * Decompile Time: 1766 ms
 * Timestamp: 10/27/2023 2:02:18 AM
*******************************************************************/

//Function Number: 1
guy_enter(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.vehicletype))
	{
		return;
	}

	var_02 = self.classname;
	var_03 = level.vehicle_aianims[var_02];
	var_04 = level.vehicle_aianims[var_02].size;
	self.attachedguys[self.attachedguys.size] = param_00;
	var_05 = set_pos(param_00,var_04);
	if(!isdefined(var_05))
	{
		return;
	}

	if(var_05 == 0)
	{
		param_00.drivingvehicle = 1;
	}

	var_06 = anim_pos(self,var_05);
	self.usedpositions[var_05] = 1;
	param_00.vehicle_position = var_05;
	param_00.vehicle_idling = 0;
	if(isdefined(var_06.delay))
	{
		param_00.delay = var_06.delay;
		if(isdefined(var_06.delayinc))
		{
			self.delayer = param_00.delay;
		}
	}

	if(isdefined(var_06.delayinc))
	{
		self.delayer = self.delayer + var_06.delayinc;
		param_00.delay = self.delayer;
	}

	param_00.ridingvehicle = self;
	param_00.orghealth = param_00.health;
	param_00.vehicle_idle = var_06.idle;
	param_00.vehicle_standattack = var_06.standattack;
	param_00.deathanim = var_06.death;
	param_00.death_flop_dir = var_06.death_flop_dir;
	param_00.min_unload_frac_to_flop = var_06.min_unload_frac_to_flop;
	param_00.deathanimscript = var_06.deathscript;
	param_00.standing = 0;
	if(isdefined(var_06.getout))
	{
		param_00.get_out_time = getanimlength(var_06.getout);
		param_00.get_out_anim = var_06.getout;
	}

	param_00.allowdeath = 0;
	if(isdefined(param_00.deathanim) && !isdefined(param_00.magic_bullet_shield) && vehicle_allows_rider_death())
	{
		if(param_00.vehicle_position != 0 || vehicle_allows_driver_death())
		{
			param_00.allowdeath = !isdefined(param_00.script_allowdeath) || param_00.script_allowdeath;
			if(isdefined(var_06.death_no_ragdoll))
			{
				param_00.noragdoll = var_06.death_no_ragdoll;
			}
		}
	}

	if(param_00.classname == "script_model")
	{
		if(isdefined(var_06.death) && param_00.allowdeath && !isdefined(param_00.script_allowdeath) || param_00.script_allowdeath)
		{
			thread guy_death(param_00,var_06);
		}
	}

	if(!isdefined(param_00.vehicle_idle))
	{
		param_00.allowdeath = 1;
	}

	self.riders[self.riders.size] = param_00;
	if(param_00.classname != "script_model" && maps\_utility::spawn_failed(param_00))
	{
		return;
	}

	var_07 = vehicle_animpos_get_tag_origin(var_06);
	var_08 = vehicle_animpos_get_tag_angles(var_06);
	link_to_sittag(param_00,var_06.sittag,var_06.sittag_offset,var_06.linktoblend,var_06.sittag_on_turret,var_06.mgturret);
	if(isai(param_00))
	{
		param_00 teleport(var_07,var_08);
		param_00.a.disablelongdeath_saved = param_00.a.disablelongdeath;
		param_00.a.disablelongdeath = 1;
		if(isdefined(var_06.bhasgunwhileriding) && !var_06.bhasgunwhileriding)
		{
			param_00 maps\_utility::gun_remove();
		}

		if(guy_should_man_turret(var_06))
		{
			thread guy_man_turret(param_00,var_05,param_01);
		}
	}
	else
	{
		if(isdefined(var_06.bhasgunwhileriding) && !var_06.bhasgunwhileriding)
		{
			detach_models_with_substr(param_00,"weapon_");
		}

		param_00.origin = var_07;
		param_00.angles = var_08;
	}

	if(var_05 == 0 && isdefined(var_03[0].death))
	{
		thread driverdead(param_00);
	}

	self notify("guy_entered",param_00,var_05);
	thread guy_handle(param_00,var_05);
	if(isdefined(var_06.rider_func))
	{
		param_00 [[ var_06.rider_func ]]();
		return;
	}

	if(isdefined(self.parachute_unload))
	{
		param_00.parachute_unload = 1;
	}

	if(isdefined(var_06.getin_idle_func))
	{
		thread [[ var_06.getin_idle_func ]](param_00,var_05);
		return;
	}

	thread guy_idle(param_00,var_05);
}

//Function Number: 2
vehicle_animpos_get_tag_origin(param_00)
{
	var_01 = self;
	if(isdefined(param_00.sittag_on_turret) && param_00.sittag_on_turret)
	{
		var_01 = self.mgturret[param_00.mgturret];
	}

	return var_01 gettagorigin(param_00.sittag);
}

//Function Number: 3
vehicle_animpos_get_tag_angles(param_00)
{
	var_01 = self;
	if(isdefined(param_00.sittag_on_turret) && param_00.sittag_on_turret)
	{
		var_01 = self.mgturret[param_00.mgturret];
	}

	return var_01 gettagangles(param_00.sittag);
}

//Function Number: 4
vehicle_allows_driver_death()
{
	if(!isdefined(self.script_allow_driver_death))
	{
		return 0;
	}

	return self.script_allow_driver_death;
}

//Function Number: 5
vehicle_allows_rider_death()
{
	if(!isdefined(self.script_allow_rider_deaths))
	{
		return 1;
	}

	return self.script_allow_rider_deaths;
}

//Function Number: 6
guy_should_man_turret(param_00)
{
	if(!isdefined(param_00.mgturret))
	{
		return 0;
	}

	if(!isdefined(self.script_nomg))
	{
		return 1;
	}

	return !self.script_nomg;
}

//Function Number: 7
handle_attached_guys()
{
	var_00 = self.classname;
	self.attachedguys = [];
	if(!isdefined(level.vehicle_aianims) && isdefined(level.vehicle_aianims[var_00]))
	{
		return;
	}

	var_01 = level.vehicle_aianims[var_00].size;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go")
	{
		thread ai_wait_go();
	}

	self.runningtovehicle = [];
	self.usedpositions = [];
	self.getinorgs = [];
	self.delayer = 0;
	var_02 = level.vehicle_aianims[var_00];
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self.usedpositions[var_03] = 0;
		if(isdefined(self.script_nomg) && self.script_nomg && isdefined(var_02[var_03].bisgunner) && var_02[var_03].bisgunner)
		{
			self.usedpositions[1] = 1;
		}
	}
}

//Function Number: 8
load_ai_goddriver(param_00)
{
	load_ai(param_00,1);
}

//Function Number: 9
guy_death(param_00,param_01)
{
	waittillframeend;
	param_00 setcandamage(1);
	param_00 endon("death");
	param_00.allowdeath = 0;
	param_00.health = 10150;
	if(isdefined(param_00.script_startinghealth))
	{
		param_00.health = param_00.health + param_00.script_startinghealth;
	}

	param_00 endon("jumping_out");
	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
	{
		while(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
		{
			wait(0.05);
		}
	}

	while(param_00.health > 10000)
	{
		param_00 waittill("damage");
	}

	thread guy_deathimate_me(param_00,param_01);
}

//Function Number: 10
guy_deathimate_me(param_00,param_01)
{
	var_02 = gettime() + getanimlength(param_01.death) * 1000;
	var_03 = param_00.angles;
	var_04 = param_00.origin;
	param_00 = convert_guy_to_drone(param_00);
	[[ level.global_kill_func ]]("MOD_RIFLE_BULLET","torso_upper",var_04);
	detach_models_with_substr(param_00,"weapon_");
	param_00 linkto(self);
	param_00 notsolid();
	param_00 setanim(param_01.death);
	if(isai(param_00))
	{
		param_00 animscripts\shared::dropallaiweapons();
	}
	else
	{
		detach_models_with_substr(param_00,"weapon_");
	}

	if(isdefined(param_01.death_delayed_ragdoll))
	{
		param_00 unlink();
		param_00 startragdoll();
		wait(param_01.death_delayed_ragdoll);
		param_00 delete();
	}
}

//Function Number: 11
load_ai(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = vehicle_get_riders();
	}

	maps\_utility::ent_flag_clear("unloaded");
	maps\_utility::ent_flag_clear("loaded");
	common_scripts\utility::array_levelthread(param_00,::get_in_vehicle,param_01,param_02);
}

//Function Number: 12
is_rider(param_00)
{
	for(var_01 = 0;var_01 < self.riders.size;var_01++)
	{
		if(self.riders[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
vehicle_get_riders()
{
	var_00 = [];
	var_01 = getaiarray(self.script_team);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.script_vehicleride))
		{
			continue;
		}

		if(var_03.script_vehicleride != self.script_vehicleride)
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	return var_00;
}

//Function Number: 14
get_my_vehicleride()
{
	var_00 = [];
	var_01 = getentarray("script_vehicle","code_classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.script_vehicleride))
		{
			continue;
		}

		if(var_03.script_vehicleride != self.script_vehicleride)
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	return var_00[0];
}

//Function Number: 15
get_in_vehicle(param_00,param_01,param_02)
{
	if(is_rider(param_00))
	{
		return;
	}

	if(!handle_detached_guys_check())
	{
		return;
	}

	guy_runtovehicle(param_00,self,param_01,param_02);
}

//Function Number: 16
handle_detached_guys_check()
{
	if(vehicle_hasavailablespots())
	{
		return 1;
	}
}

//Function Number: 17
vehicle_hasavailablespots()
{
	if(level.vehicle_aianims[self.classname].size - self.runningtovehicle.size)
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
guy_runtovehicle_loaded(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("stop_loading");
	var_02 = param_00 common_scripts\utility::waittill_any_return("long_death","death","enteredvehicle");
	if(var_02 != "enteredvehicle" && isdefined(param_00.forced_startingposition))
	{
		param_01.usedpositions[param_00.forced_startingposition] = 0;
	}

	param_01.runningtovehicle = common_scripts\utility::array_remove(param_01.runningtovehicle,param_00);
	vehicle_loaded_if_full(param_01);
}

//Function Number: 19
vehicle_loaded_if_full(param_00)
{
	if(isdefined(param_00.vehicletype) && isdefined(param_00.vehicle_loaded_notify_size))
	{
		if(param_00.riders.size == param_00.vehicle_loaded_notify_size)
		{
			param_00 maps\_utility::ent_flag_set("loaded");
			return;
		}

		return;
	}

	if(!param_00.runningtovehicle.size && param_00.riders.size)
	{
		if(param_00.usedpositions[0])
		{
			param_00 maps\_utility::ent_flag_set("loaded");
			return;
		}

		param_00 thread vehicle_reload();
		return;
	}
}

//Function Number: 20
vehicle_reload()
{
	var_00 = self.riders;
	maps\_vehicle::vehicle_unload();
	maps\_utility::ent_flag_wait("unloaded");
	var_00 = maps\_utility::array_removedead(var_00);
	thread maps\_vehicle::vehicle_load_ai(var_00);
}

//Function Number: 21
remove_magic_bullet_shield_from_guy_on_unload_or_death(param_00)
{
	common_scripts\utility::waittill_any("unload","death");
	param_00 maps\_utility::stop_magic_bullet_shield();
}

//Function Number: 22
guy_runtovehicle(param_00,param_01,param_02,param_03)
{
	param_01 endon("stop_loading");
	var_04 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_05 = level.vehicle_aianims[param_01.classname];
	if(isdefined(param_01.runtovehicleoverride))
	{
		param_01 thread [[ param_01.runtovehicleoverride ]](param_00);
		return;
	}

	param_01 endon("death");
	param_00 endon("death");
	param_01.runningtovehicle[param_01.runningtovehicle.size] = param_00;
	thread guy_runtovehicle_loaded(param_00,param_01);
	var_06 = [];
	var_07 = undefined;
	var_08 = 0;
	var_09 = 0;
	for(var_0A = 0;var_0A < var_05.size;var_0A++)
	{
		if(isdefined(var_05[var_0A].getin))
		{
			var_09 = 1;
		}
	}

	if(!var_09)
	{
		param_00 notify("enteredvehicle");
		param_01 guy_enter(param_00,var_04);
		return;
	}

	if(!isdefined(param_00.get_in_moving_vehicle))
	{
		while(param_01 vehicle_getspeed() > 1)
		{
			wait(0.05);
		}
	}

	var_0B = param_01 get_availablepositions(param_03);
	if(isdefined(param_00.script_startingposition))
	{
		var_07 = param_01 vehicle_getinstart(param_00.script_startingposition);
	}
	else if(!param_01.usedpositions[0])
	{
		var_07 = param_01 vehicle_getinstart(0);
		if(param_02)
		{
			param_00 thread maps\_utility::magic_bullet_shield();
			thread remove_magic_bullet_shield_from_guy_on_unload_or_death(param_00);
		}
	}
	else if(var_0B.availablepositions.size)
	{
		var_07 = common_scripts\utility::getclosest(param_00.origin,var_0B.availablepositions);
	}
	else
	{
		var_07 = undefined;
	}

	if(!var_0B.availablepositions.size && var_0B.nonanimatedpositions.size)
	{
		param_00 notify("enteredvehicle");
		param_01 guy_enter(param_00,var_04);
		return;
	}
	else if(!isdefined(var_07))
	{
		return;
	}

	var_08 = var_07.origin;
	var_0C = var_07.angles;
	param_00.forced_startingposition = var_07.vehicle_position;
	param_01.usedpositions[var_07.vehicle_position] = 1;
	param_00.script_moveoverride = 1;
	param_00 notify("stop_going_to_node");
	param_00 maps\_utility::set_forcegoal();
	param_00 maps\_utility::disable_arrivals();
	param_00.goalradius = 16;
	param_00 setgoalpos(var_08);
	param_00 waittill("goal");
	param_00 maps\_utility::enable_arrivals();
	param_00 maps\_utility::unset_forcegoal();
	param_00 notify("boarding_vehicle");
	var_0D = anim_pos(param_01,var_07.vehicle_position);
	if(isdefined(var_0D.delay))
	{
		param_00.delay = var_0D.delay;
		if(isdefined(var_0D.delayinc))
		{
			self.delayer = param_00.delay;
		}
	}

	if(isdefined(var_0D.delayinc))
	{
		self.delayer = self.delayer + var_0D.delayinc;
		param_00.delay = self.delayer;
	}

	param_01 link_to_sittag(param_00,var_0D.sittag,var_0D.sittag_offset,var_0D.linktoblend);
	param_00.allowdeath = 0;
	var_0D = var_05[var_07.vehicle_position];
	if(isdefined(var_07))
	{
		if(isdefined(var_0D.vehicle_getinanim))
		{
			if(isdefined(var_0D.vehicle_getoutanim))
			{
				var_0E = isdefined(param_00.no_vehicle_getoutanim);
				if(!var_0E)
				{
					param_01 clearanim(var_0D.vehicle_getoutanim,0);
				}
			}

			param_01 = param_01 getanimatemodel();
			param_01 thread setanimrestart_once(var_0D.vehicle_getinanim,var_0D.vehicle_getinanim_clear);
			level thread maps\_anim::start_notetrack_wait(param_01,"vehicle_anim_flag");
		}

		if(isdefined(var_0D.vehicle_getinsoundtag))
		{
			var_08 = param_01 gettagorigin(var_0D.vehicle_getinsoundtag);
		}
		else
		{
			var_08 = param_01.origin;
		}

		if(isdefined(var_0D.vehicle_getinsound))
		{
			thread common_scripts\utility::play_sound_in_space(var_0D.vehicle_getinsound,var_08);
		}

		var_0F = undefined;
		var_10 = undefined;
		if(isdefined(var_0D.getin_enteredvehicletrack))
		{
			var_0F = [];
			var_0F[0] = var_0D.getin_enteredvehicletrack;
			var_10 = [];
			var_10[0] = ::entered_vehicle_notify;
			param_01 link_to_sittag(param_00,var_0D.sittag,var_0D.sittag_offset,var_0D.linktoblend);
		}

		param_01 animontag(param_00,var_0D.sittag,var_0D.getin,var_0F,var_10);
	}

	param_00 notify("enteredvehicle");
	param_01 guy_enter(param_00,var_04);
}

//Function Number: 23
entered_vehicle_notify()
{
	self notify("enteredvehicle");
}

//Function Number: 24
driverdead(param_00)
{
	if(maps\_vehicle::ishelicopter())
	{
		return;
	}

	self.driver = param_00;
	self endon("death");
	param_00 endon("jumping_out");
	param_00 waittill("death");
	if(isdefined(self.vehicle_keeps_going_after_driver_dies))
	{
		return;
	}

	self notify("driver dead");
	self.deaddriver = 1;
	if(isdefined(self.hasstarted) && self.hasstarted)
	{
		self setwaitspeed(0);
		self vehicle_setspeed(0,10);
		self waittill("reached_wait_speed");
	}

	maps\_vehicle::vehicle_unload();
}

//Function Number: 25
copy_cat()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel(self.model);
	var_01 = self getattachsize();
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_00 attach(self getattachmodelname(var_02));
	}

	return var_00;
}

//Function Number: 26
guy_becomes_real_ai(param_00,param_01)
{
	if(isai(param_00))
	{
		return param_00;
	}

	if(param_00.drone_delete_on_unload == 1)
	{
		param_00 delete();
		return;
	}

	param_00 = maps\_utility::swap_drone_to_ai(param_00);
	var_02 = self.classname;
	var_03 = level.vehicle_aianims[var_02].size;
	var_04 = anim_pos(self,param_01);
	link_to_sittag(param_00,var_04.sittag,var_04.sittag_offset,var_04.linktoblend);
	param_00.vehicle_idle = var_04.idle;
	thread guy_idle(param_00,param_01);
	return param_00;
}

//Function Number: 27
link_to_sittag(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	if(isdefined(param_04) && param_04)
	{
		var_06 = self.mgturret[param_05];
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_03 && !isdefined(param_00.script_drone))
	{
		param_00 linktoblendtotag(var_06,param_01,0);
		return;
	}

	param_00 linkto(var_06,param_01,param_02,(0,0,0));
}

//Function Number: 28
anim_pos(param_00,param_01)
{
	return level.vehicle_aianims[param_00.classname][param_01];
}

//Function Number: 29
guy_deathhandle(param_00,param_01)
{
	param_00 waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self.riders = common_scripts\utility::array_remove(self.riders,param_00);
	self.usedpositions[param_01] = 0;
}

//Function Number: 30
setup_aianimthreads()
{
	if(!isdefined(level.vehicle_aianimthread))
	{
		level.vehicle_aianimthread = [];
	}

	if(!isdefined(level.vehicle_aianimcheck))
	{
		level.vehicle_aianimcheck = [];
	}

	level.vehicle_aianimthread["idle"] = ::guy_idle;
	level.vehicle_aianimthread["duck"] = ::guy_duck;
	level.vehicle_aianimthread["duck_once"] = ::guy_duck_once;
	level.vehicle_aianimcheck["duck_once"] = ::guy_duck_once_check;
	level.vehicle_aianimthread["weave"] = ::guy_weave;
	level.vehicle_aianimcheck["weave"] = ::guy_weave_check;
	level.vehicle_aianimthread["turn_right"] = ::guy_turn_right;
	level.vehicle_aianimcheck["turn_right"] = ::guy_turn_right_check;
	level.vehicle_aianimthread["turn_left"] = ::guy_turn_left;
	level.vehicle_aianimcheck["turn_left"] = ::guy_turn_right_check;
	level.vehicle_aianimthread["turn_hardright"] = ::guy_turn_hardright;
	level.vehicle_aianimthread["turn_hardleft"] = ::guy_turn_hardleft;
	level.vehicle_aianimthread["turret_fire"] = ::guy_turret_fire;
	level.vehicle_aianimthread["turret_turnleft"] = ::guy_turret_turnleft;
	level.vehicle_aianimthread["turret_turnright"] = ::guy_turret_turnright;
	level.vehicle_aianimthread["unload"] = ::guy_unload;
	level.vehicle_aianimthread["pre_unload"] = ::guy_pre_unload;
	level.vehicle_aianimcheck["pre_unload"] = ::guy_pre_unload_check;
	level.vehicle_aianimthread["idle_alert"] = ::guy_idle_alert;
	level.vehicle_aianimcheck["idle_alert"] = ::guy_idle_alert_check;
	level.vehicle_aianimthread["idle_alert_to_casual"] = ::guy_idle_alert_to_casual;
	level.vehicle_aianimcheck["idle_alert_to_casual"] = ::guy_idle_alert_to_casual_check;
	level.vehicle_aianimthread["reaction"] = ::guy_turret_turnright;
}

//Function Number: 31
guy_handle(param_00,param_01)
{
	param_00.vehicle_idling = 1;
	thread guy_deathhandle(param_00,param_01);
}

//Function Number: 32
guy_stand_attack(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	param_00.standing = 1;
	var_03 = 0;
	for(;;)
	{
		var_04 = gettime() + 2000;
		while(gettime() < var_04 && isdefined(param_00.enemy))
		{
			animontag(param_00,var_02.sittag,param_00.vehicle_standattack,undefined,undefined,"firing");
		}

		var_05 = randomint(5) + 10;
		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			animontag(param_00,var_02.sittag,var_02.standidle);
		}
	}
}

//Function Number: 33
guy_stand_down(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	if(!isdefined(var_02.standdown))
	{
		thread guy_stand_attack(param_00,param_01);
		return;
	}

	animontag(param_00,var_02.sittag,var_02.standdown);
	param_00.standing = 0;
	thread guy_idle(param_00,param_01);
}

//Function Number: 34
driver_idle_speed(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	for(;;)
	{
		if(self vehicle_getspeed() == 0)
		{
			param_00.vehicle_idle = var_02.idle_animstop;
		}
		else
		{
			param_00.vehicle_idle = var_02.idle_anim;
		}

		wait(0.25);
	}
}

//Function Number: 35
guy_reaction(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	if(isdefined(var_02.reaction))
	{
		animontag(param_00,var_02.sittag,var_02.reaction);
	}

	thread guy_idle(param_00,param_01);
}

//Function Number: 36
guy_turret_turnleft(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	animontag(param_00,var_02.sittag,param_00.turret_turnleft);
}

//Function Number: 37
guy_turret_turnright(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	animontag(param_00,var_02.sittag,param_00.turret_turnleft);
}

//Function Number: 38
guy_turret_fire(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.vehicle_turret_fire))
	{
		maps\_vehicle_code::_get_dummy() setanimrestart(var_02.vehicle_turret_fire);
	}

	if(isdefined(var_02.turret_fire))
	{
		if(isdefined(var_02.turret_fire_tag))
		{
			animontag(param_00,var_02.turret_fire_tag,var_02.turret_fire);
		}
		else
		{
			animontag(param_00,var_02.sittag,var_02.turret_fire);
		}
	}

	thread guy_idle(param_00,param_01);
}

//Function Number: 39
guy_idle(param_00,param_01,param_02)
{
	param_00 endon("newanim");
	if(!isdefined(param_02))
	{
		self endon("death");
	}

	param_00 endon("death");
	param_00.vehicle_idling = 1;
	param_00 notify("gotime");
	if(!isdefined(param_00.vehicle_idle))
	{
		return;
	}

	var_03 = anim_pos(self,param_01);
	if(isdefined(var_03.mgturret))
	{
		return;
	}

	if(isdefined(var_03.hideidle) && var_03.hideidle)
	{
		param_00 hide();
	}

	if(isdefined(var_03.idle_animstop) && isdefined(var_03.idle_anim))
	{
		thread driver_idle_speed(param_00,param_01);
	}

	for(;;)
	{
		param_00 notify("idle");
		play_new_idle(param_00,var_03);
	}
}

//Function Number: 40
play_new_idle(param_00,param_01)
{
	if(isdefined(param_00.vehicle_idle_override))
	{
		animontag(param_00,param_01.sittag,param_00.vehicle_idle_override);
		return;
	}

	if(isdefined(param_01.idleoccurrence))
	{
		var_02 = randomoccurrance(param_00,param_01.idleoccurrence);
		animontag(param_00,param_01.sittag,param_00.vehicle_idle[var_02]);
		return;
	}

	if(isdefined(param_01.playerpiggyback) && isdefined(var_02.player_idle))
	{
		animontag(param_01,var_02.sittag,var_02.player_idle);
		return;
	}

	if(isdefined(var_02.vehicle_idle))
	{
		thread setanimrestart_once(var_02.vehicle_idle);
	}

	animontag(param_01,var_02.sittag,param_01.vehicle_idle);
}

//Function Number: 41
randomoccurrance(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_03 = var_03 + param_01[var_04];
		var_02[var_04] = var_03;
	}

	var_05 = randomint(var_03);
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(var_05 < var_02[var_04])
		{
			return var_04;
		}
	}
}

//Function Number: 42
guy_duck_once_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).duck_once);
}

//Function Number: 43
guy_duck_once(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.duck_once))
	{
		if(isdefined(var_02.vehicle_duck_once))
		{
			thread setanimrestart_once(var_02.vehicle_duck_once);
		}

		animontag(param_00,var_02.sittag,var_02.duck_once);
	}

	thread guy_idle(param_00,param_01);
}

//Function Number: 44
guy_weave_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).weave);
}

//Function Number: 45
guy_weave(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.weave))
	{
		if(isdefined(var_02.vehicle_weave))
		{
			thread setanimrestart_once(var_02.vehicle_weave);
		}

		animontag(param_00,var_02.sittag,var_02.weave);
	}

	thread guy_idle(param_00,param_01);
}

//Function Number: 46
guy_duck(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.duckin))
	{
		animontag(param_00,var_02.sittag,var_02.duckin);
	}

	thread guy_duck_idle(param_00,param_01);
}

//Function Number: 47
guy_duck_idle(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	var_03 = randomoccurrance(param_00,var_02.duckidleoccurrence);
	animontag(param_00,var_02.sittag,var_02.duckidle[var_03]);
}

//Function Number: 48
guy_duck_out(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.ducking) && param_00.ducking)
	{
		animontag(param_00,var_02.sittag,var_02.duckout);
		param_00.ducking = 0;
	}

	thread guy_idle(param_00,param_01);
}

//Function Number: 49
guy_unload_que(param_00)
{
	self endon("death");
	self.unloadque = common_scripts\utility::array_add(self.unloadque,param_00);
	param_00 common_scripts\utility::waittill_any("death","jumpedout");
	self.unloadque = common_scripts\utility::array_remove(self.unloadque,param_00);
	if(!self.unloadque.size)
	{
		maps\_utility::ent_flag_set("unloaded");
		self.unload_group = "default";
	}
}

//Function Number: 50
riders_unloadable(param_00)
{
	if(!self.riders.size)
	{
		return 0;
	}

	for(var_01 = 0;var_01 < self.riders.size;var_01++)
	{
		if(!isalive(self.riders[var_01]))
		{
			continue;
		}

		if(check_unloadgroup(self.riders[var_01].vehicle_position,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 51
get_unload_group()
{
	var_00 = [];
	var_01 = [];
	var_02 = "default";
	if(isdefined(self.unload_group))
	{
		var_02 = self.unload_group;
	}

	var_01 = level.vehicle_unloadgroups[self.classname][var_02];
	if(!isdefined(var_01))
	{
		var_01 = level.vehicle_unloadgroups[self.classname]["default"];
	}

	if(isdefined(var_01))
	{
		foreach(var_04 in var_01)
		{
			var_00[var_04] = var_04;
		}
	}

	return var_00;
}

//Function Number: 52
check_unloadgroup(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.unload_group;
	}

	var_02 = self.classname;
	if(!isdefined(level.vehicle_unloadgroups[var_02]))
	{
		return 1;
	}

	if(!isdefined(level.vehicle_unloadgroups[var_02][param_01]))
	{
		return 1;
	}

	var_03 = level.vehicle_unloadgroups[var_02][param_01];
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(param_00 == var_03[var_04])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
getoutrig_model_idle(param_00,param_01,param_02)
{
	self endon("unloading");
	animontag(param_00,param_01,param_02);
}

//Function Number: 54
getoutrig_model(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.classname;
	if(param_04)
	{
		thread getoutrig_model_idle(param_01,param_02,level.vehicle_attachedmodels[var_05][param_00.fastroperig].idleanim);
		self waittill("unloading");
	}

	self.unloadque = common_scripts\utility::array_add(self.unloadque,param_01);
	thread getoutrig_abort(param_01,param_02,param_03);
	if(!isdefined(self.crashing))
	{
		animontag(param_01,param_02,param_03);
	}

	param_01 unlink();
	if(!isdefined(self))
	{
		param_01 delete();
		return;
	}

	self.unloadque = common_scripts\utility::array_remove(self.unloadque,param_01);
	if(!self.unloadque.size)
	{
		self notify("unloaded");
	}

	self.fastroperig[param_00.fastroperig] = undefined;
	wait(10);
	param_01 delete();
}

//Function Number: 55
getoutrig_disable_abort_notify_after_riders_out()
{
	wait(0.05);
	while(isalive(self) && self.unloadque.size > 2)
	{
		wait(0.05);
	}

	if(!isalive(self) || isdefined(self.crashing) && self.crashing)
	{
		return;
	}

	self notify("getoutrig_disable_abort");
}

//Function Number: 56
getoutrig_abort_while_deploying()
{
	self endon("end_getoutrig_abort_while_deploying");
	while(!isdefined(self.crashing))
	{
		wait(0.05);
	}

	var_00 = [];
	foreach(var_02 in self.riders)
	{
		if(isalive(var_02))
		{
			common_scripts\utility::add_to_array(var_00,var_02);
		}
	}

	common_scripts\utility::array_levelthread(var_00,::maps\_utility::deleteent);
	self notify("crashed_while_deploying");
	var_00 = undefined;
}

//Function Number: 57
getoutrig_abort(param_00,param_01,param_02)
{
	var_03 = getanimlength(param_02);
	var_04 = var_03 - 1;
	if(self.vehicletype == "mi17")
	{
		var_04 = var_03 - 0.5;
	}

	var_05 = 2.5;
	self endon("getoutrig_disable_abort");
	thread getoutrig_disable_abort_notify_after_riders_out();
	thread getoutrig_abort_while_deploying();
	common_scripts\utility::waittill_notify_or_timeout("crashed_while_deploying",var_05);
	self notify("end_getoutrig_abort_while_deploying");
	while(!isdefined(self.crashing))
	{
		wait(0.05);
	}

	thread animontag(param_00,param_01,param_02);
	waittillframeend;
	param_00 setanimtime(param_02,var_04 / var_03);
	var_06 = self;
	if(isdefined(self.achievement_attacker))
	{
		var_06 = self.achievement_attacker;
	}

	for(var_07 = 0;var_07 < self.riders.size;var_07++)
	{
		if(!isdefined(self.riders[var_07]))
		{
			continue;
		}

		if(!isdefined(self.riders[var_07].ragdoll_getout_death))
		{
			continue;
		}

		if(self.riders[var_07].ragdoll_getout_death != 1)
		{
			continue;
		}

		if(!isdefined(self.riders[var_07].ridingvehicle))
		{
			continue;
		}

		self.riders[var_07].forcefallthroughonropes = 1;
		if(isalive(self.riders[var_07]))
		{
			thread animontag_ragdoll_death_fall(self.riders[var_07],self,var_06);
		}
	}
}

//Function Number: 58
setanimrestart_once(param_00,param_01)
{
	self endon("death");
	self endon("dont_clear_anim");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = getanimlength(param_00);
	var_03 = maps\_vehicle_code::_get_dummy();
	var_03 endon("death");
	var_03 setflaggedanimrestart("vehicle_anim_flag",param_00,1,0,1);
	wait(var_02);
	if(param_01 && !isdefined(self.dont_clear_vehicle_anim) || !self.dont_clear_vehicle_anim)
	{
		var_03 clearanim(param_00,0);
	}
}

//Function Number: 59
getout_rigspawn(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = self.classname;
	var_04 = anim_pos(self,param_01);
	if(isdefined(self.attach_model_override) && isdefined(self.attach_model_override[var_04.fastroperig]))
	{
		var_05 = 1;
	}
	else
	{
		var_05 = 0;
	}

	if(!isdefined(var_04.fastroperig) || isdefined(self.fastroperig[var_04.fastroperig]) || var_05)
	{
		return;
	}

	var_06 = param_00 gettagorigin(level.vehicle_attachedmodels[var_03][var_04.fastroperig].tag);
	var_07 = param_00 gettagangles(level.vehicle_attachedmodels[var_03][var_04.fastroperig].tag);
	self.fastroperiganimating[var_04.fastroperig] = 1;
	var_08 = spawn("script_model",var_06);
	var_08.angles = var_07;
	var_08.origin = var_06;
	var_08 setmodel(level.vehicle_attachedmodels[var_03][var_04.fastroperig].model);
	self.fastroperig[var_04.fastroperig] = var_08;
	var_08 useanimtree(#animtree);
	var_08 linkto(param_00,level.vehicle_attachedmodels[var_03][var_04.fastroperig].tag,(0,0,0),(0,0,0));
	thread getoutrig_model(var_04,var_08,level.vehicle_attachedmodels[var_03][var_04.fastroperig].tag,level.vehicle_attachedmodels[var_03][var_04.fastroperig].dropanim,param_02);
	return var_08;
}

//Function Number: 60
check_sound_tag_dupe(param_00)
{
	if(!isdefined(self.sound_tag_dupe))
	{
		self.sound_tag_dupe = [];
	}

	var_01 = 0;
	if(!isdefined(self.sound_tag_dupe[param_00]))
	{
		self.sound_tag_dupe[param_00] = 1;
	}
	else
	{
		var_01 = 1;
	}

	thread check_sound_tag_dupe_reset(param_00);
	return var_01;
}

//Function Number: 61
check_sound_tag_dupe_reset(param_00)
{
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self.sound_tag_dupe[param_00] = 0;
	var_01 = getarraykeys(self.sound_tag_dupe);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(self.sound_tag_dupe[var_01[var_02]])
		{
			return;
		}
	}

	self.sound_tag_dupe = undefined;
}

//Function Number: 62
guy_unload_custom(param_00,param_01)
{
	if(!check_unloadgroup(param_01))
	{
		thread guy_idle(param_00,param_01);
		return;
	}

	self.unloadque = common_scripts\utility::array_add(self.unloadque,param_00);
	var_02 = param_00 [[ param_00.customunloadfunc ]](self,param_01);
	if(!var_02)
	{
		thread guy_idle(param_00,param_01);
	}
	else
	{
		guy_disassociate_internal(param_00,param_01);
	}

	self.unloadque = common_scripts\utility::array_remove(self.unloadque,param_00);
	waittillframeend;
	if(!self.unloadque.size)
	{
		maps\_utility::ent_flag_set("unloaded");
		self.unload_group = "default";
	}
}

//Function Number: 63
guy_unload(param_00,param_01)
{
	if(isdefined(param_00.customunloadfunc))
	{
		guy_unload_custom(param_00,param_01);
		return;
	}

	var_02 = anim_pos(self,param_01);
	var_03 = self.vehicletype;
	if(!check_unloadgroup(param_01))
	{
		thread guy_idle(param_00,param_01);
		return;
	}

	if(!isdefined(var_02.getout) && !isdefined(var_02.bnoanimunload))
	{
		thread guy_idle(param_00,param_01);
		return;
	}

	if(isdefined(var_02.hideidle) && var_02.hideidle)
	{
		param_00 show();
	}

	thread guy_unload_que(param_00);
	self endon("death");
	if(isai(param_00) && isalive(param_00))
	{
		param_00 endon("death");
	}

	if(isdefined(param_00.getoffvehiclefunc))
	{
		if(isdefined(var_02.delay))
		{
			wait(var_02.delay);
			var_02.delay = undefined;
			param_00.delay = undefined;
		}

		param_00 [[ param_00.getoffvehiclefunc ]]();
	}

	if(isdefined(param_00.onrotatingvehicleturret))
	{
		param_00.onrotatingvehicleturret = undefined;
		if(isdefined(param_00.getoffvehiclefunc))
		{
			param_00 [[ param_00.getoffvehiclefunc ]]();
		}
	}

	var_04 = getanimatemodel();
	if(isdefined(var_02.vehicle_getoutanim))
	{
		var_04 thread setanimrestart_once(var_02.vehicle_getoutanim,var_02.vehicle_getoutanim_clear);
		var_05 = 0;
		if(isdefined(var_02.vehicle_getoutsoundtag))
		{
			var_05 = check_sound_tag_dupe(var_02.vehicle_getoutsoundtag);
			var_06 = var_04 gettagorigin(var_02.vehicle_getoutsoundtag);
		}
		else
		{
			var_06 = var_05.origin;
		}

		if(isdefined(var_02.vehicle_getoutsound) && !var_05)
		{
			thread common_scripts\utility::play_sound_in_space(var_02.vehicle_getoutsound,var_06);
		}

		var_05 = undefined;
	}

	var_07 = 0;
	if(isdefined(var_02.getout_timed_anim))
	{
		var_07 = var_07 + getanimlength(var_02.getout_timed_anim);
	}

	if(isdefined(var_02.delay))
	{
		var_07 = var_07 + var_02.delay;
	}

	if(isdefined(param_00.delay))
	{
		var_07 = var_07 + param_00.delay;
	}

	if(var_07 > 0)
	{
		thread guy_idle(param_00,param_01);
		wait(var_07);
	}

	var_08 = isdefined(var_02.getout_combat);
	if(!var_08 && param_00.standing)
	{
		guy_stand_down(param_00,param_01);
	}
	else if(!var_08 && !param_00.vehicle_idling && isdefined(param_00.vehicle_idle))
	{
		param_00 waittill("idle");
	}

	param_00.deathanim = undefined;
	param_00.deathanimscript = undefined;
	param_00 notify("newanim");
	if(isdefined(var_02.bhasgunwhileriding) && !var_02.bhasgunwhileriding)
	{
		if(!isdefined(param_00.disable_gun_recall))
		{
			param_00 maps\_utility::gun_recall();
		}
	}

	if(isai(param_00))
	{
		param_00 pushplayer(1);
	}

	var_09 = 0;
	if(isdefined(var_02.bnoanimunload))
	{
		var_09 = 1;
	}
	else if(!isdefined(var_02.getout) || !isdefined(self.script_unloadmgguy) && isdefined(var_02.bisgunner) && var_02.bisgunner || isdefined(self.script_keepdriver) && param_01 == 0)
	{
		thread guy_idle(param_00,param_01);
		return;
	}

	if(param_00 should_give_orghealth())
	{
		param_00.health = param_00.orghealth;
	}

	param_00.orghealth = undefined;
	if(isai(param_00) && isalive(param_00))
	{
		param_00 endon("death");
	}

	param_00.allowdeath = 0;
	if(isdefined(var_02.exittag))
	{
		var_0A = var_02.exittag;
	}
	else
	{
		var_0A = var_03.sittag;
	}

	if(var_08 && param_00.standing)
	{
		var_0B = var_02.getout_combat;
	}
	else if(isdefined(param_01.get_out_override))
	{
		var_0B = param_01.get_out_override;
	}
	else if(isdefined(param_01.playerpiggyback) && isdefined(var_03.player_getout))
	{
		var_0B = var_03.player_getout;
	}
	else
	{
		var_0B = var_03.getout;
	}

	if(!var_09)
	{
		if(!isdefined(param_00.parachute_unload))
		{
			thread guy_unlink_on_death(param_00);
		}

		if(isdefined(var_02.fastroperig))
		{
			if(!isdefined(self.fastroperig[var_02.fastroperig]))
			{
				thread guy_idle(param_00,param_01);
				var_0C = getout_rigspawn(var_04,param_00.vehicle_position,0);
			}
		}

		if(isdefined(var_02.getoutsnd))
		{
			param_00 thread maps\_utility::play_sound_on_tag(var_02.getoutsnd,"J_Wrist_RI",1);
		}

		if(isdefined(param_00.playerpiggyback) && isdefined(var_02.player_getout_sound))
		{
			param_00 thread maps\_utility::play_sound_on_entity(var_02.player_getout_sound);
		}

		if(isdefined(var_02.getoutloopsnd))
		{
			param_00 thread maps\_utility::play_loop_sound_on_tag(var_02.getoutloopsnd);
		}

		if(isdefined(param_00.playerpiggyback) && isdefined(var_02.player_getout_sound_loop))
		{
			level.player thread common_scripts\utility::play_loop_sound_on_entity(var_02.player_getout_sound_loop);
		}

		param_00 notify("newanim");
		param_00 notify("jumping_out");
		var_0D = 0;
		if(!isai(param_00))
		{
			var_0D = 1;
		}

		if(!isdefined(param_00.script_stay_drone))
		{
			param_00 = guy_becomes_real_ai(param_00,param_01);
		}

		if(!isalive(param_00))
		{
			return;
		}

		param_00.ragdoll_getout_death = 1;
		if(isdefined(var_02.rappel_kill_achievement))
		{
			param_00 maps\_utility::enable_achievement_harder_they_fall();
		}

		if(isdefined(var_02.ragdoll_getout_death))
		{
			param_00.ragdoll_getout_death = 1;
			if(isdefined(var_02.ragdoll_fall_anim))
			{
				param_00.ragdoll_fall_anim = var_02.ragdoll_fall_anim;
			}
		}

		if(var_0D)
		{
			self.riders = common_scripts\utility::array_add(self.riders,param_00);
			thread guy_deathhandle(param_00,param_01);
			thread guy_unload_que(param_00);
			param_00.ridingvehicle = self;
		}

		if(isai(param_00))
		{
			param_00 endon("death");
		}

		param_00 notify("newanim");
		param_00 notify("jumping_out");
		if(isdefined(var_02.littlebirde_getout_unlinks) && var_02.littlebirde_getout_unlinks)
		{
			thread stable_unlink(param_00);
		}

		if(isdefined(var_02.getout_secondary))
		{
			animontag(param_00,var_0A,var_0B);
			var_0E = var_0A;
			if(isdefined(var_02.getout_secondary_tag))
			{
				var_0E = var_02.getout_secondary_tag;
			}

			animontag(param_00,var_0E,var_02.getout_secondary);
		}
		else if(isdefined(var_02.parachute_unload))
		{
			if(!isdefined(self.angle_offset))
			{
				self.angle_offset = 0;
				self.origin_offset = (0,0,0);
				self.unload_delay = 0.5;
			}
			else
			{
				self.unload_delay = self.unload_delay + randomfloatrange(0.5,1);
				wait(self.unload_delay);
			}

			if(!isdefined(self))
			{
				return;
			}

			var_0F = spawn("script_model",self gettagorigin(var_0A));
			var_0F.angles = (0,self.angles[1] + self.angle_offset,0);
			self.angle_offset = self.angle_offset + 5;
			var_0F setmodel("tag_origin");
			var_10 = maps\_utility::groundpos(self.origin) + (0,0,self.unload_anim_height);
			var_0F.origin = var_10 + (randomintrange(10,20),randomintrange(10,20),0);
			var_11 = spawn("script_model",var_0F.origin);
			var_11.angles = var_0F.angles;
			var_11 setmodel(self.unload_model);
			var_11.animname = "parachute";
			var_11 useanimtree(level.scr_animtree["parachute"]);
			var_11 hide();
			var_11 maps\_utility::ent_flag_init("parachute_open");
			if(isdefined(var_02.parachute_function))
			{
				var_0F parachute_unload(param_00,var_11,self.unload_model_unload_anim,var_0B,var_02.parachute_function);
			}
			else
			{
				var_0F parachute_unload(param_00,var_11,self.unload_model_unload_anim,var_0B);
			}

			var_0F delete();
		}
		else
		{
			param_00.anim_end_early = 1;
			animontag(param_00,var_0A,var_0B);
		}

		if(isdefined(param_00.playerpiggyback) && isdefined(var_02.player_getout_sound_loop))
		{
			level.player thread common_scripts\utility::stop_loop_sound_on_entity(var_02.player_getout_sound_loop);
		}

		if(isdefined(var_02.getoutloopsnd))
		{
			param_00 thread common_scripts\utility::stop_loop_sound_on_entity(var_02.getoutloopsnd);
		}

		if(isdefined(param_00.playerpiggyback) && isdefined(var_02.player_getout_sound_end))
		{
			level.player thread maps\_utility::play_sound_on_entity(var_02.player_getout_sound_end);
		}
	}
	else if(!isai(param_00))
	{
		if(param_00.drone_delete_on_unload == 1)
		{
			param_00 delete();
			return;
		}

		param_00 = maps\_utility::swap_drone_to_ai(param_00);
	}

	self.riders = common_scripts\utility::array_remove(self.riders,param_00);
	self.usedpositions[param_01] = 0;
	param_00.ridingvehicle = undefined;
	param_00.drivingvehicle = undefined;
	if(!isalive(self) && !isdefined(var_02.unload_ondeath))
	{
		param_00 delete();
		return;
	}

	param_00 unlink();
	if(!isdefined(param_00.magic_bullet_shield))
	{
		if(isdefined(param_00.noragdoll))
		{
			param_00.noragdoll = undefined;
		}
	}

	if(isalive(param_00))
	{
		if(isai(param_00))
		{
			if(isdefined(param_00.a.disablelongdeath_saved))
			{
				param_00.a.disablelongdeath = param_00.a.disablelongdeath_saved;
			}
			else
			{
				param_00.a.disablelongdeath = !param_00 isbadguy();
			}
		}

		param_00.forced_startingposition = undefined;
		param_00 notify("jumpedout");
		param_00 maps\_utility::disable_achievement_harder_they_fall();
		if(isai(param_00))
		{
			if(isdefined(var_02.getoutstance))
			{
				param_00.desired_anim_pose = var_02.getoutstance;
				param_00 allowedstances("crouch");
				param_00 thread animscripts\utility::updateanimpose();
				param_00 allowedstances("stand","crouch","prone");
			}

			param_00 pushplayer(0);
			if(guy_resets_goalpos(param_00))
			{
				param_00.goalradius = 600;
				param_00 setgoalpos(param_00.origin);
			}
		}
	}

	if(isdefined(var_02.getout_delete) && var_02.getout_delete)
	{
		param_00 delete();
		return;
	}

	param_00 guy_cleanup_vehiclevars();
}

//Function Number: 64
parachute_unload(param_00,param_01,param_02,param_03,param_04)
{
	param_00 unlink();
	var_05 = param_01 gettagorigin("tag_driver");
	var_06 = param_01 gettagangles("tag_driver");
	param_00 forceteleport(var_05,var_06);
	param_00 linkto(param_01,"tag_driver");
	param_01 animscripted("parachute_unload",self.origin,self.angles,param_02);
	if(isdefined(param_04))
	{
		param_01 thread parachute_notetrack_logic("parachute_unload","show_parachute",param_04);
	}
	else
	{
		param_01 thread parachute_notetrack_logic("parachute_unload","show_parachute");
	}

	param_00 animscripted("parachute_unload",param_00.origin,param_00.angles,param_03);
	level thread parachute_death_monitor(param_00,param_01);
	param_01 waittillmatch("end","parachute_unload");
	param_01 notify("parachute_landed");
	if(isalive(param_00))
	{
		param_00 unlink();
	}
}

//Function Number: 65
parachute_movement(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = vectornormalize(common_scripts\utility::flat_angle(var_01));
	var_03 = self.origin + var_02 * 10000;
	thread maps\_utility::draw_line_from_ent_for_time(self,var_03,1,0,0,10);
	self moveto(var_03,1);
}

//Function Number: 66
parachute_death_monitor(param_00,param_01)
{
	param_01 endon("parachute_landed");
	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
	{
		return;
	}

	if(!isai(param_00))
	{
		param_00 setcandamage(1);
	}

	var_02 = undefined;
	var_03 = undefined;
	for(;;)
	{
		param_00 waittill("damage",var_02,var_03);
		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_02 < 1)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(isplayer(var_03))
		{
			break;
		}
	}

	if(!param_01 maps\_utility::ent_flag("parachute_open"))
	{
		param_01 notify("rider_dead");
		thread animontag_ragdoll_death_fall(param_00,undefined,var_03);
		wait(2);
		param_01 delete();
		return;
	}

	iprintln("parachute death anim here!");
}

//Function Number: 67
parachute_notetrack_logic(param_00,param_01,param_02)
{
	self endon("rider_dead");
	self waittillmatch(param_01,param_00);
	if(isdefined(param_02))
	{
		self thread [[ param_02 ]]();
	}

	maps\_utility::ent_flag_set("parachute_open");
}

//Function Number: 68
guy_resets_goalpos(param_00)
{
	if(isdefined(param_00.script_delayed_playerseek))
	{
		return 0;
	}

	if(param_00 maps\_utility::has_color())
	{
		return 0;
	}

	if(isdefined(param_00.qsetgoalpos))
	{
		return 0;
	}

	if(!isdefined(param_00.target))
	{
		return 1;
	}

	var_01 = getnodearray(param_00.target,"targetname");
	if(var_01.size > 1)
	{
		return 0;
	}

	var_02 = getent(param_00.target,"targetname");
	if(isdefined(var_02) && var_02.classname == "info_volume")
	{
		param_00 setgoalvolumeauto(var_02);
		return 0;
	}

	return 1;
}

//Function Number: 69
animontag(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 notify("animontag_thread");
	param_00 endon("animontag_thread");
	if(!isdefined(param_05))
	{
		param_05 = "animontagdone";
	}

	if(isdefined(self.modeldummy))
	{
		var_06 = self.modeldummy;
	}
	else
	{
		var_06 = self;
	}

	if(!isdefined(param_01))
	{
		var_07 = param_00.origin;
		var_08 = param_00.angles;
	}
	else
	{
		var_07 = var_08 gettagorigin(param_03);
		var_08 = var_07 gettagangles(param_02);
	}

	if(isdefined(param_00.ragdoll_getout_death) && !isdefined(param_00.no_vehicle_ragdoll))
	{
		level thread animontag_ragdoll_death(param_00,self);
	}

	param_00 animscripted(param_05,var_07,var_08,param_02);
	if(isai(param_00))
	{
		thread donotetracks(param_00,var_06,param_05);
	}

	if(isdefined(param_00.anim_end_early))
	{
		param_00.anim_end_early = undefined;
		var_09 = getanimlength(param_02) - 0.25;
		if(var_09 > 0)
		{
			wait(var_09);
		}

		param_00 stopanimscripted();
		param_00.interval = 0;
		param_00 thread recover_interval();
	}
	else
	{
		if(isdefined(param_03))
		{
			for(var_0A = 0;var_0A < param_03.size;var_0A++)
			{
				param_00 waittillmatch(param_03[var_0A],param_05);
				param_00 thread [[ param_04[var_0A] ]]();
			}
		}

		param_00 waittillmatch("end",param_05);
	}

	param_00 notify("anim_on_tag_done");
	param_00.ragdoll_getout_death = undefined;
}

//Function Number: 70
recover_interval()
{
	self endon("death");
	wait(2);
	if(self.interval == 0)
	{
		self.interval = 80;
	}
}

//Function Number: 71
animontag_ragdoll_death(param_00,param_01)
{
	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield)
	{
		return;
	}

	if(!isai(param_00))
	{
		param_00 setcandamage(1);
	}

	param_00 endon("anim_on_tag_done");
	if(!isdefined(param_00.cansurvivevehicleexplosion) || !param_00.cansurvivevehicleexplosion)
	{
		thread animontag_unloading_vehicle_explosion(param_00,param_01);
	}

	var_02 = undefined;
	var_03 = undefined;
	var_04 = param_01.health <= 0;
	for(;;)
	{
		if(!var_04 && !isdefined(param_01) && param_01.health > 0)
		{
			break;
		}

		param_00 waittill("damage",var_02,var_03);
		if(isdefined(param_00.forcefallthroughonropes))
		{
			break;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_02 < 1)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(isplayer(var_03))
		{
			break;
		}
	}

	if(!isalive(param_00))
	{
		return;
	}

	thread animontag_ragdoll_death_fall(param_00,param_01,var_03);
}

//Function Number: 72
animontag_ragdoll_death_fall(param_00,param_01,param_02)
{
	param_00.deathanim = undefined;
	param_00.deathfunction = undefined;
	param_00.anim_disablepain = 1;
	if(isdefined(param_00.ragdoll_fall_anim))
	{
		var_03 = getmovedelta(param_00.ragdoll_fall_anim,0,1);
		var_04 = physicstrace(param_00.origin + (0,0,16),param_00.origin - (0,0,10000));
		var_05 = distance(param_00.origin + (0,0,16),var_04);
		if(abs(var_03[2] + 16) <= abs(var_05))
		{
			param_00 thread maps\_utility::play_sound_on_entity("generic_death_falling");
			param_00 animscripted("fastrope_fall",param_00.origin,param_00.angles,param_00.ragdoll_fall_anim);
			param_00 waittillmatch("start_ragdoll","fastrope_fall");
		}
	}

	if(!isdefined(param_00))
	{
		return;
	}

	param_00.deathanim = undefined;
	param_00.deathfunction = undefined;
	param_00.anim_disablepain = 1;
	param_00 notify("rope_death",param_02);
	maps\_spawner::death_achievements_rappel(param_02);
	param_00 kill(param_02.origin,param_02);
	if(isdefined(param_00.script_stay_drone))
	{
		param_00 notsolid();
		var_06 = getweaponmodel(param_00.weapon);
		var_07 = param_00.weapon;
		if(isdefined(var_06))
		{
			param_00 detach(var_06,"tag_weapon_right");
			var_08 = param_00 gettagorigin("tag_weapon_right");
			var_09 = param_00 gettagangles("tag_weapon_right");
			level.gun = spawn("weapon_" + var_07,(0,0,0));
			level.gun.angles = var_09;
			level.gun.origin = var_08;
		}
	}
	else
	{
		param_00 animscripts\shared::dropallaiweapons();
	}

	if(isdefined(param_00.death_flop_dir))
	{
		if(isdefined(param_00.get_out_time))
		{
			var_0A = 0.33;
			if(isdefined(param_00.min_unload_frac_to_flop))
			{
				var_0A = param_00.min_unload_frac_to_flop;
			}

			var_0B = param_00 getanimtime(param_00.get_out_anim);
			if(var_0B < var_0A)
			{
				wait(param_00.get_out_time * var_0A - var_0B);
			}

			if(isremovedentity(param_00))
			{
				return;
			}
		}

		var_0C = length(param_00.death_flop_dir);
		var_0D = vectornormalize(param_01 localtoworldcoords(param_00.death_flop_dir) - param_00.origin) * var_0C;
		param_00 startragdollfromimpact("torso_lower",var_0D);
		return;
	}

	param_00 startragdoll();
}

//Function Number: 73
animontag_unloading_vehicle_explosion(param_00,param_01)
{
	param_00 endon("anim_on_tag_done");
	param_00 endon("death");
	param_01 waittill("death",var_02,var_03,var_04);
	var_05 = 0;
	if(isdefined(param_00.min_unload_frac_to_flop))
	{
		var_06 = param_00 getanimtime(param_00.get_out_anim);
		if(var_06 < param_00.min_unload_frac_to_flop)
		{
			var_05 = 1;
		}
	}

	if(!isremovedentity(param_00))
	{
		if(var_05)
		{
			param_00 notify("killanimscript");
			waittillframeend;
			param_00 thread delayed_exploded_guy_deletion();
		}

		if(isdefined(var_02))
		{
			param_00 kill(param_00.origin,var_02);
			return;
		}

		param_00 kill();
	}
}

//Function Number: 74
delayed_exploded_guy_deletion()
{
	wait 0.05;
	if(!isremovedentity(self))
	{
		self delete();
	}
}

//Function Number: 75
donotetracks(param_00,param_01,param_02)
{
	param_00 endon("newanim");
	param_01 endon("death");
	param_00 endon("death");
	param_00 animscripts\shared::donotetracks(param_02);
}

//Function Number: 76
animatemoveintoplace(param_00,param_01,param_02,param_03)
{
	param_00 animscripted("movetospot",param_01,param_02,param_03);
	param_00 waittillmatch("end","movetospot");
}

//Function Number: 77
guy_vehicle_death(param_00,param_01,param_02)
{
	if(!isalive(param_00))
	{
		return;
	}

	if(isdefined(self.no_rider_death))
	{
		return;
	}

	var_03 = anim_pos(self,param_00.vehicle_position);
	param_00.vehicle_attacker = param_01;
	if(isdefined(var_03.explosion_death))
	{
		return guy_blowup(param_00);
	}

	if(isdefined(level.vehicle_rider_death_func) && isdefined(level.vehicle_rider_death_func[self.classname]))
	{
		self [[ level.vehicle_rider_death_func[self.classname] ]]();
		return;
	}

	if(isdefined(var_03.unload_ondeath) && isdefined(self))
	{
		if(isdefined(self.dontunloadondeath) && self.dontunloadondeath)
		{
			return;
		}

		thread guy_idle(param_00,param_00.vehicle_position,1);
		wait(var_03.unload_ondeath);
		if(isdefined(param_00) && isdefined(self))
		{
			self.groupedanim_pos = param_00.vehicle_position;
			maps\_vehicle::vehicle_ai_event("unload");
		}

		return;
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00.ragdoll_getout_death) && param_02 != "bm21_troops")
		{
			return;
		}

		[[ level.global_kill_func ]]("MOD_RIFLE_BULLET","torso_upper",param_00.origin);
		if(param_02 == "bm21_troops")
		{
			param_00.allowdeath = 1;
			param_00 kill();
			return;
		}

		param_00 delete();
	}
}

//Function Number: 78
guy_turn_right_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).turn_right);
}

//Function Number: 79
guy_turn_right(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.vehicle_turn_right))
	{
		thread setanimrestart_once(var_02.vehicle_turn_right);
	}

	animontag(param_00,var_02.sittag,var_02.turn_right);
	thread guy_idle(param_00,param_01);
}

//Function Number: 80
guy_turn_left(param_00,param_01)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_02 = anim_pos(self,param_01);
	if(isdefined(var_02.vehicle_turn_left))
	{
		thread setanimrestart_once(var_02.vehicle_turn_left);
	}

	animontag(param_00,var_02.sittag,var_02.turn_left);
	thread guy_idle(param_00,param_01);
}

//Function Number: 81
guy_turn_left_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).turn_left);
}

//Function Number: 82
guy_turn_hardright(param_00,param_01)
{
	var_02 = level.vehicle_aianims[self.classname][param_01];
	if(isdefined(var_02.idle_hardright))
	{
		param_00.vehicle_idle_override = var_02.idle_hardright;
	}
}

//Function Number: 83
guy_turn_hardleft(param_00,param_01)
{
	var_02 = level.vehicle_aianims[self.classname][param_01];
	if(isdefined(var_02.idle_hardleft))
	{
		param_00.vehicle_idle_override = var_02.idle_hardleft;
	}
}

//Function Number: 84
ai_wait_go()
{
	self endon("death");
	self waittill("loaded");
	maps\_vehicle::gopath(self);
}

//Function Number: 85
set_pos(param_00,param_01)
{
	var_02 = param_00.script_startingposition;
	if(isdefined(param_00.forced_startingposition))
	{
		var_02 = param_00.forced_startingposition;
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	if(!isdefined(self.usedpositions))
	{
		return;
	}

	for(var_03 = 0;var_03 < self.usedpositions.size;var_03++)
	{
		if(self.usedpositions[var_03])
		{
			continue;
		}

		return var_03;
	}

	if(isdefined(param_00.script_vehicleride))
	{
	}
}

//Function Number: 86
guy_man_turret(param_00,param_01,param_02)
{
	var_03 = anim_pos(self,param_01);
	var_04 = self.mgturret[var_03.mgturret];
	if(!isalive(param_00))
	{
		return;
	}

	var_04 endon("death");
	param_00 endon("death");
	if(isdefined(param_02) && param_02 && isdefined(var_03.passenger_2_turret_func))
	{
		[[ var_03.passenger_2_turret_func ]](self,param_00,param_01,var_04);
	}

	maps\_vehicle_code::set_turret_team(var_04);
	var_04 setdefaultdroppitch(0);
	wait(0.1);
	param_00 endon("guy_man_turret_stop");
	level thread maps\_mgturret::mg42_setdifficulty(var_04,maps\_utility::getdifficulty());
	var_04 setturretignoregoals(1);
	if(isdefined(var_03.sittag_on_turret) && var_03.sittag_on_turret)
	{
		var_04 thread maps\_mgturret_auto_nonai::main(param_00,var_03);
		return;
	}

	for(;;)
	{
		if(!isdefined(param_00 getturret()))
		{
			param_00 useturret(var_04);
		}

		wait(1);
	}
}

//Function Number: 87
guy_unlink_on_death(param_00)
{
	param_00 endon("jumpedout");
	param_00 waittill("death");
	if(isdefined(param_00))
	{
		param_00 unlink();
	}
}

//Function Number: 88
guy_blowup(param_00)
{
	if(!isdefined(param_00.vehicle_position))
	{
		return;
	}

	var_01 = param_00.vehicle_position;
	var_02 = anim_pos(self,var_01);
	if(!isdefined(var_02.explosion_death))
	{
		return;
	}

	[[ level.global_kill_func ]]("MOD_RIFLE_BULLET","torso_upper",param_00.origin);
	param_00.deathanim = var_02.explosion_death;
	var_03 = self.angles;
	var_04 = param_00.origin;
	if(isdefined(var_02.explosion_death_offset))
	{
		var_04 = var_04 + anglestoforward(var_03) * var_02.explosion_death_offset[0];
		var_04 = var_04 + anglestoright(var_03) * var_02.explosion_death_offset[1];
		var_04 = var_04 + anglestoup(var_03) * var_02.explosion_death_offset[2];
	}

	param_00 = convert_guy_to_drone(param_00);
	detach_models_with_substr(param_00,"weapon_");
	param_00 notsolid();
	param_00.origin = var_04;
	param_00.angles = var_03;
	param_00 animscripted("deathanim",var_04,var_03,var_02.explosion_death);
	var_05 = 0.3;
	if(isdefined(var_02.explosion_death_ragdollfraction))
	{
		var_05 = var_02.explosion_death_ragdollfraction;
	}

	var_06 = getanimlength(var_02.explosion_death);
	var_07 = gettime() + var_06 * 1000;
	wait(var_06 * var_05);
	var_08 = (0,0,1);
	var_09 = param_00.origin;
	if(getdvar("ragdoll_enable") == "0")
	{
		param_00 delete();
		return;
	}

	if(isai(param_00))
	{
		param_00 animscripts\shared::dropallaiweapons();
	}
	else
	{
		detach_models_with_substr(param_00,"weapon_");
	}

	while(!param_00 isragdoll() && gettime() < var_07)
	{
		var_09 = param_00.origin;
		wait(0.05);
		var_08 = param_00.origin - var_09;
		param_00 startragdoll();
	}

	wait(0.05);
	var_08 = var_08 * 20000;
	for(var_0A = 0;var_0A < 3;var_0A++)
	{
		if(isdefined(param_00))
		{
			var_09 = param_00.origin;
		}

		wait(0.05);
	}

	if(!param_00 isragdoll())
	{
		param_00 delete();
	}
}

//Function Number: 89
convert_guy_to_drone(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = spawn("script_model",param_00.origin);
	var_03.angles = param_00.angles;
	var_03 setmodel(param_00.model);
	var_04 = param_00 getattachsize();
	for(var_05 = 0;var_05 < var_04 && param_02 || var_05 < 1;var_05++)
	{
		var_03 attach(param_00 getattachmodelname(var_05),param_00 getattachtagname(var_05));
	}

	var_03 useanimtree(#animtree);
	if(isdefined(param_00.team))
	{
		var_03.team = param_00.team;
	}

	if(!param_01)
	{
		param_00 delete();
	}

	var_03 makefakeai();
	return var_03;
}

//Function Number: 90
vehicle_animate(param_00,param_01)
{
	self useanimtree(param_01);
	self setanim(param_00);
}

//Function Number: 91
vehicle_getinstart(param_00)
{
	var_01 = anim_pos(self,param_00);
	return vehicle_getanimstart(var_01.getin,var_01.sittag,param_00);
}

//Function Number: 92
vehicle_getanimstart(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_04 = undefined;
	var_05 = undefined;
	var_06 = self gettagorigin(param_01);
	var_07 = self gettagangles(param_01);
	var_04 = getstartorigin(var_06,var_07,param_00);
	var_05 = getstartangles(var_06,var_07,param_00);
	var_03.origin = var_04;
	var_03.angles = var_05;
	var_03.vehicle_position = param_02;
	return var_03;
}

//Function Number: 93
is_position_in_group(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = param_00.classname;
	var_04 = level.vehicle_unloadgroups[var_03][param_02];
	foreach(var_06 in var_04)
	{
		if(var_06 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 94
get_availablepositions(param_00)
{
	var_01 = level.vehicle_aianims[self.classname];
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < self.usedpositions.size;var_04++)
	{
		if(self.usedpositions[var_04])
		{
			continue;
		}

		if(isdefined(var_01[var_04].getin) && is_position_in_group(self,var_04,param_00))
		{
			var_02[var_02.size] = vehicle_getinstart(var_04);
			continue;
		}

		var_03[var_03.size] = var_04;
	}

	var_05 = spawnstruct();
	var_05.availablepositions = var_02;
	var_05.nonanimatedpositions = var_03;
	return var_05;
}

//Function Number: 95
getanimatemodel()
{
	if(isdefined(self.modeldummy))
	{
		return self.modeldummy;
	}

	return self;
}

//Function Number: 96
detach_models_with_substr(param_00,param_01)
{
	var_02 = param_00 getattachsize();
	var_03 = [];
	var_04 = [];
	var_05 = 0;
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_07 = param_00 getattachmodelname(var_06);
		var_08 = param_00 getattachtagname(var_06);
		if(issubstr(var_07,param_01))
		{
			var_03[var_05] = var_07;
			var_04[var_05] = var_08;
			var_05++;
		}
	}

	for(var_06 = 0;var_06 < var_03.size;var_06++)
	{
		param_00 detach(var_03[var_06],var_04[var_06]);
	}
}

//Function Number: 97
should_give_orghealth()
{
	if(!isai(self))
	{
		return 0;
	}

	if(!isdefined(self.orghealth))
	{
		return 0;
	}

	return !isdefined(self.magic_bullet_shield);
}

//Function Number: 98
guy_pre_unload_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).pre_unload);
}

//Function Number: 99
guy_pre_unload(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	if(!isdefined(var_02.pre_unload))
	{
		return;
	}

	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	animontag(param_00,var_02.sittag,var_02.pre_unload);
	animontag(param_00,var_02.sittag,var_02.pre_unload_idle);
}

//Function Number: 100
guy_idle_alert(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	if(!isdefined(var_02.idle_alert))
	{
		return;
	}

	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	animontag(param_00,var_02.sittag,var_02.idle_alert);
}

//Function Number: 101
guy_idle_alert_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).idle_alert);
}

//Function Number: 102
guy_idle_alert_to_casual(param_00,param_01)
{
	var_02 = anim_pos(self,param_01);
	if(!isdefined(var_02.idle_alert))
	{
		return;
	}

	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	animontag(param_00,var_02.sittag,var_02.idle_alert_to_casual);
	thread guy_idle(param_00,param_01);
}

//Function Number: 103
guy_idle_alert_to_casual_check(param_00,param_01)
{
	return isdefined(anim_pos(self,param_01).idle_alert_to_casual);
}

//Function Number: 104
stable_unlink(param_00)
{
	self waittill("stable_for_unlink");
	if(isalive(param_00))
	{
		param_00 unlink();
	}
}

//Function Number: 105
track_entered_vehicle()
{
}

//Function Number: 106
animate_guys(param_00)
{
	var_01 = [];
	foreach(var_03 in self.riders)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(isdefined(level.vehicle_aianimcheck[param_00]) && ![[ level.vehicle_aianimcheck[param_00] ]](var_03,var_03.vehicle_position))
		{
			continue;
		}

		if(isdefined(level.vehicle_aianimthread[param_00]))
		{
			var_03 notify("newanim");
			var_03.queued_anim_threads = [];
			thread [[ level.vehicle_aianimthread[param_00] ]](var_03,var_03.vehicle_position);
			var_01[var_01.size] = var_03;
			continue;
		}

		var_03 notify("newanim");
		var_03.queued_anim_threads = [];
		thread guy_vehicle_anim_simple(var_03,var_03.vehicle_position,param_00);
		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 107
guy_vehicle_anim_simple(param_00,param_01,param_02)
{
	param_00 endon("newanim");
	self endon("death");
	param_00 endon("death");
	var_03 = anim_pos(self,param_01);
	if(isdefined(var_03.aianim_simple_vehicle[param_02]))
	{
		thread setanimrestart_once(var_03.aianim_simple_vehicle[param_02]);
	}

	animontag(param_00,var_03.sittag,var_03.aianim_simple[param_02]);
	guy_idle(param_00,param_01);
}

//Function Number: 108
guy_cleanup_vehiclevars()
{
	self.vehicle_idling = undefined;
	self.standing = undefined;
	self.vehicle_position = undefined;
	self.delay = undefined;
}

//Function Number: 109
delete_corpses_around_vehicle()
{
	var_00 = self getcentroid();
	var_01 = self getpointinbounds(1,0,0);
	var_02 = distance(var_01,var_00);
	var_03 = getcorpsearray();
	foreach(var_05 in var_03)
	{
		if(distance(var_05.origin,var_00) < var_02)
		{
			var_05 delete();
		}
	}
}

//Function Number: 110
disassociate_guy_from_vehicle()
{
	if(isdefined(self.ridingvehicle))
	{
		self.ridingvehicle guy_disassociate_internal(self,self.vehicle_position);
	}
}

//Function Number: 111
guy_disassociate_internal(param_00,param_01)
{
	param_00 notify("jumpedout");
	self.riders = common_scripts\utility::array_remove(self.riders,param_00);
	self.usedpositions[param_01] = 0;
	param_00.ridingvehicle = undefined;
	param_00.drivingvehicle = undefined;
	param_00 guy_cleanup_vehiclevars();
}
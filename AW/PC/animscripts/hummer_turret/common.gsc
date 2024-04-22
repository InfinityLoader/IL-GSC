/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: hummer_turret\common.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 452 ms
 * Timestamp: 4/22/2024 1:58:52 AM
*******************************************************************/

//Function Number: 1
humvee_turret_init(param_00,param_01)
{
	self endon("killanimscript");
	animscripts\utility::initialize(param_01);
	self.no_ai = 1;
	self.nodrop = 1;
	self.a.movement = "stop";
	self.a.special = param_01;
	self.a.usingturret = param_00;
	self.ignoreme = 1;
	if(isdefined(self.minigun_ignoreme))
	{
		self.ignoreme = self.minigun_ignoreme;
	}

	self.iscustomanimating = 0;
	self setturretanim(self.primaryturretanim);
	self setanimknobrestart(self.primaryturretanim,1,0.2,1);
	if(isdefined(self.weapon))
	{
		animscripts\shared::placeweaponon(self.weapon,"none");
	}

	self.getoffvehiclefunc = ::turret_cleanup_on_unload;
	self notify("guy_man_turret_stop");
	param_00 notify("stop_burst_fire_unmanned");
	param_00.turretstate = "start";
	param_00.aiowner = self;
	param_00.firetime = 0;
	param_00 setmode("sentry");
	param_00 setsentryowner(self);
	param_00 setdefaultdroppitch(0);
	param_00 setturretcanaidetach(0);
	gunner_pain_init();
	level thread handle_gunner_pain(self,param_00);
	level thread handle_gunner_death(self,param_00);
	param_00 thread turret_track_rotatedirection(self);
	param_00.dofiring = 0;
	thread firedirector(param_00);
	wait(0.05);
	if(isalive(self))
	{
		thread gunner_turning_anims(param_00);
	}
}

//Function Number: 2
gunner_pain_init()
{
	self.allowpain = 0;
	maps\_utility::setflashbangimmunity(1);
	self.og_health = self.health;
	self.health = 200;
}

//Function Number: 3
gunner_pain_reset()
{
	self.allowpain = 1;
	maps\_utility::setflashbangimmunity(0);
	self.health = self.og_health;
}

//Function Number: 4
handle_gunner_pain(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	param_00 endon("dismount");
	param_00 endon("jumping_out");
	for(;;)
	{
		var_02 = "flashbang";
		var_03 = param_00 common_scripts\utility::waittill_any_return("damage",var_02);
		var_04 = common_scripts\utility::random(param_00.turretpainanims);
		if(var_03 == var_02)
		{
			var_04 = param_00.turretflashbangedanim;
			param_00 animscripts\face::saygenericdialogue("flashbang");
		}

		param_00 docustomanim(param_01,var_04,0);
		param_01 notify("pain_done");
	}
}

//Function Number: 5
turret_recenter()
{
	turret_aim_straight();
	self waittill("pain_done");
	turret_aim_restore();
}

//Function Number: 6
handle_gunner_death(param_00,param_01)
{
	param_00 endon("dismount");
	param_01 endon("turret_cleanup");
	param_00.deathanim = param_00.turretdeathanim;
	param_00.nomeleedeathorient = 1;
	param_00.noragdoll = 1;
	param_00 waittill("death");
	level thread turret_cleanup(param_00,param_01);
}

//Function Number: 7
turret_cleanup_on_unload()
{
	var_00 = self.ridingvehicle.mgturret[0];
	if(isalive(self))
	{
		self.no_ai = undefined;
		self.nodrop = undefined;
		self.ignoreme = 0;
		self.a.special = "none";
		self.a.usingturret = undefined;
		self.deathanim = undefined;
		gunner_pain_reset();
		self.iscustomanimating = undefined;
		self.turretspecialanims = undefined;
		self.turretpainanims = undefined;
		self.getoffvehiclefunc = undefined;
		self stopuseturret();
		if(isdefined(self.weapon))
		{
			animscripts\shared::placeweaponon(self.weapon,"right");
		}
	}

	level thread turret_cleanup(self,var_00);
}

//Function Number: 8
turret_cleanup(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	param_01 notify("kill_fireController");
	param_01 notify("turret_cleanup");
	param_01 setmode("manual");
	param_01 cleartargetentity();
	param_01 setdefaultdroppitch(param_01.default_drop_pitch);
	if(isdefined(param_00))
	{
		param_00 clearanim(param_00.additiveusegunroot,0);
		param_00 clearanim(param_00.additiverotateroot,0);
		param_00 clearanim(param_00.turretspecialanimsroot,0);
	}

	param_01.fireinterval = undefined;
	param_01.closeenoughaimdegrees = undefined;
	param_01.firecontrollerfunc = undefined;
	param_01.turretstate = "free";
	param_01.aiowner = undefined;
	param_01.firetime = undefined;
	if(isdefined(param_01.specialcleanupfunc))
	{
		level [[ param_01.specialcleanupfunc ]](param_00,param_01);
	}
}

//Function Number: 9
turret_track_rotatedirection(param_00)
{
	self endon("turret_cleanup");
	self endon("death");
	param_00 endon("death");
	param_00 endon("detach");
	var_01 = "tag_aim";
	var_02 = self gettagangles(var_01);
	turret_update_rotatedirection("none");
	for(;;)
	{
		var_03 = self gettagangles(var_01);
		var_04 = anglestoright(var_02);
		var_05 = anglestoforward(var_03);
		var_06 = vectordot(var_04,var_05);
		if(var_06 == 0)
		{
			turret_update_rotatedirection("none");
		}
		else if(var_06 > 0)
		{
			turret_update_rotatedirection("right");
		}
		else
		{
			turret_update_rotatedirection("left");
		}

		var_02 = self gettagangles(var_01);
		wait(0.05);
	}
}

//Function Number: 10
turret_update_rotatedirection(param_00)
{
	if(!isdefined(self.rotatedirection) || self.rotatedirection != param_00)
	{
		self.rotatedirection = param_00;
	}
}

//Function Number: 11
gunner_turning_anims(param_00)
{
	self endon("death");
	param_00 endon("death");
	self endon("dismount");
	param_00 endon("turret_cleanup");
	var_01 = 0.3;
	var_02 = 0.3;
	for(;;)
	{
		param_00 waittill("new_fireTarget");
		wait(0.05);
		if(!isdefined(param_00.firetarget) || self.iscustomanimating)
		{
			continue;
		}

		var_03 = undefined;
		if(!param_00 turret_aiming_near_target(param_00.firetarget,param_00.closeenoughaimdegrees))
		{
			if(param_00.rotatedirection == "right")
			{
				var_03 = self.additiveturretrotateright;
			}
			else if(param_00.rotatedirection == "left")
			{
				var_03 = self.additiveturretrotateleft;
			}

			if(isdefined(var_03))
			{
				self setanimlimited(self.additiverotateroot,1,var_01,1);
				self setanimknoblimited(var_03,1,0,1);
				while(isdefined(param_00.firetarget) && !param_00 turret_aiming_near_target(param_00.firetarget,param_00.closeenoughaimdegrees))
				{
					if(self.iscustomanimating)
					{
						break;
					}

					wait(0.05);
				}

				self clearanim(self.additiverotateroot,var_02);
			}
		}
	}
}

//Function Number: 12
vehicle_passenger_2_turret(param_00,param_01,param_02,param_03)
{
	param_00.usedpositions[self.vehicle_position] = 0;
	maps\_vehicle_aianim::guy_cleanup_vehiclevars();
	guy_gets_on_turret(param_00,param_01,param_02,param_03);
}

//Function Number: 13
guy_goes_directly_to_turret(param_00,param_01,param_02,param_03)
{
	guy_gets_on_turret(param_00,param_01,param_02,param_03);
}

//Function Number: 14
guy_gets_on_turret(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_02 endon("death");
	self stopanimscripted();
	self notify("newanim");
	self.drivingvehicle = undefined;
	self.no_ai = 1;
	param_03 = %humvee_passenger_2_turret;
	if(!isdefined(param_03))
	{
		param_03 = self.passenger_2_turret_anim;
	}

	var_04 = maps\_vehicle_aianim::anim_pos(param_00,param_01);
	var_05 = param_00 gettagorigin(var_04.sittag);
	var_06 = param_00 gettagangles(var_04.sittag);
	param_02 setdefaultdroppitch(0);
	param_02 thread turret_animate(param_02.passenger2turret_anime);
	self animscripted("passenger2turret",var_05,var_06,param_03);
	wait(getanimlength(param_03));
	self stopanimscripted();
	param_02 turret_aim_restore();
	self useturret(param_02);
}

//Function Number: 15
turret_animate(param_00)
{
	if(isdefined(self.idleanim))
	{
		self clearanim(self.idleanim,0);
		self.idleanim = undefined;
	}

	self setflaggedanimknobrestart("minigun_turret",param_00,1,0,1);
	self waittillmatch("end","minigun_turret");
	self clearanim(param_00,0);
}

//Function Number: 16
turret_animfirstframe(param_00)
{
	self setanimknobrestart(param_00,1,0,0);
	self.idleanim = param_00;
}

//Function Number: 17
firedirector(param_00)
{
	self endon("death");
	param_00 endon("death");
	self endon("dismount");
	param_00 endon("kill_fireController");
	param_00 thread turret_target_updater(self);
	wait(0.05);
	self thread [[ param_00.firecontrollerfunc ]](param_00);
	var_01 = undefined;
	for(;;)
	{
		var_01 = param_00.firetarget;
		while(param_00 target_confirm(var_01))
		{
			if(param_00 turret_aiming_near_target(var_01,param_00.closeenoughaimdegrees))
			{
				break;
			}

			wait(0.05);
		}

		if(param_00 target_confirm(var_01) && !self.ignoreall)
		{
			param_00.dofiring = 1;
		}

		while(param_00 target_confirm(var_01) && !self.ignoreall && !self.iscustomanimating)
		{
			wait(0.05);
		}

		if(param_00.dofiring || self.ignoreall)
		{
			param_00.dofiring = 0;
		}

		wait(0.05);
	}
}

//Function Number: 18
target_confirm(param_00)
{
	if(isdefined(self.dontshoot))
	{
		return 0;
	}

	if(!isdefined(self.firetarget))
	{
		return 0;
	}

	if(!turret_target_validate(param_00))
	{
		return 0;
	}

	if(param_00 != self.firetarget)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
turret_target_updater(param_00)
{
	param_00 endon("death");
	self endon("death");
	param_00 endon("dismount");
	self endon("kill_fireController");
	self.firetarget = undefined;
	var_01 = undefined;
	var_02 = undefined;
	for(;;)
	{
		var_01 = self getturrettarget(0);
		var_03 = 0;
		if(turret_target_validate(var_01) || !isdefined(var_01))
		{
			if(!isdefined(var_01) && isdefined(var_02))
			{
				var_03 = 1;
			}
			else if(isdefined(var_01) && !isdefined(var_02))
			{
				var_03 = 1;
			}
			else if(isdefined(var_01) && var_01 != var_02)
			{
				var_03 = 1;
			}

			if(var_03)
			{
				self.firetarget = var_01;
				var_02 = var_01;
				self notify("new_fireTarget");
			}
		}

		wait(0.05);
	}
}

//Function Number: 20
turret_target_validate(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.ignoreme) && param_00.ignoreme)
	{
		return 0;
	}

	if(issubstr(param_00.code_classname,"actor") && !isalive(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
set_manual_target(param_00,param_01,param_02,param_03)
{
	self endon("turret_cleanup");
	var_04 = self getmode();
	if(var_04 != "manual")
	{
		self setmode("manual");
	}

	if(!isdefined(param_01) && !isdefined(param_02))
	{
		param_01 = 1.5;
		param_02 = 3;
	}

	custom_anim_wait();
	self settargetentity(param_00);
	self waittill("turret_on_target");
	if(isdefined(param_03))
	{
		self waittill(param_03);
	}
	else if(isdefined(param_02))
	{
		wait(randomfloatrange(param_01,param_02));
	}
	else
	{
		wait(param_01);
	}

	custom_anim_wait();
	self cleartargetentity(param_00);
	if(isdefined(var_04))
	{
		self setmode(var_04);
	}
}

//Function Number: 22
doshoot(param_00)
{
	self notify("doshoot_starting");
	self setanimlimited(self.additiveusegunroot,1,0.1);
	self setanimknoblimited(self.additiveturretfire,1,0.1);
	param_00.turretstate = "fire";
	param_00 thread fire(self);
}

//Function Number: 23
fire(param_00)
{
	param_00 endon("death");
	self endon("death");
	param_00 endon("dismount");
	self endon("kill_fireController");
	self endon("stopfiring");
	self endon("custom_anim");
	for(;;)
	{
		self shootturret();
		wait(self.fireinterval);
	}
}

//Function Number: 24
doaim(param_00)
{
	param_00.turretstate = "aim";
	param_00 notify("stopfiring");
	thread doaim_idle_think(param_00);
}

//Function Number: 25
doaim_idle_think(param_00)
{
	self notify("doaim_idle_think");
	self endon("doaim_idle_think");
	self endon("custom_anim");
	self endon("doshoot_starting");
	self endon("death");
	param_00 endon("death");
	var_01 = param_00.ownervehicle;
	var_02 = -1;
	for(;;)
	{
		if(var_01 vehicle_getspeed() < 1 && var_02)
		{
			self setanimlimited(self.additiveusegunroot,1,0.1);
			self setanimknoblimited(self.additiveturretidle,1,0.1);
			var_02 = 0;
		}
		else if(var_01 vehicle_getspeed() >= 1 && !var_02)
		{
			self setanimlimited(self.additiveusegunroot,1,0.1);
			self setanimknoblimited(self.additiveturretdriveidle,1,0.1);
			var_02 = 1;
		}

		wait(0.05);
	}
}

//Function Number: 26
turret_gunner_custom_anim(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	self endon("dismount");
	self endon("jumping_out");
	var_03 = self.turretspecialanims[param_01];
	custom_anim_wait();
	var_04 = param_00 reload_disable_safe();
	docustomanim(param_00,var_03,param_02);
	if(var_04)
	{
		param_00 reload_enable();
	}
}

//Function Number: 27
reload_disable_safe()
{
	var_00 = 0;
	if(!isdefined(self.disablereload) || !self.disablereload)
	{
		var_00 = 1;
		self.disablereload = 1;
	}

	return var_00;
}

//Function Number: 28
reload_enable()
{
	self.disablereload = 0;
}

//Function Number: 29
doreload(param_00)
{
	if(isdefined(param_00.disablereload))
	{
		return;
	}

	self endon("death");
	param_00 endon("death");
	self endon("dismount");
	self endon("jumping_out");
	if(animscripts\battlechatter::bcsenabled())
	{
		if(level.chatinitialized)
		{
			thread maps\_utility::custom_battlechatter("inform_reloading");
		}
	}
	else if(isdefined(self.team))
	{
		maps\_dds::dds_notify("act_reload",self.team == "allies");
	}

	docustomanim(param_00,self.turretreloadanim,1);
}

//Function Number: 30
docustomanim(param_00,param_01,param_02)
{
	self notify("do_custom_anim");
	self endon("do_custom_anim");
	self.iscustomanimating = 1;
	self.customanim = param_01;
	param_00.turretstate = "customanim";
	param_00 turretfiredisable();
	if(param_00 getbarrelspinrate() > 0)
	{
		param_00 stopbarrelspin();
	}

	param_00 notify("kill_fireController");
	self notify("custom_anim");
	if(isdefined(param_02) && param_02)
	{
		param_00 turret_aim_straight();
	}

	self setanimknoblimitedrestart(self.turretspecialanimsroot,1,0.2);
	self setflaggedanimknobrestart("special_anim",param_01,1,0,1);
	for(;;)
	{
		self waittill("special_anim",var_03);
		if(var_03 == "end")
		{
			break;
		}
	}

	self clearanim(self.turretspecialanimsroot,0.2);
	self setanimlimited(self.primaryturretanim,1);
	self setanimlimited(self.additiveusegunroot,1);
	if(isdefined(param_02) && param_02)
	{
		param_00 turret_aim_restore();
	}

	self.customanim = undefined;
	self.iscustomanimating = 0;
	param_00 turretfireenable();
	thread firedirector(param_00);
}

//Function Number: 31
custom_anim_wait()
{
	self endon("death");
	if(!isdefined(self.iscustomanimating))
	{
		return;
	}

	while(self.iscustomanimating)
	{
		wait(0.05);
	}
}

//Function Number: 32
turret_aim_straight(param_00)
{
	if(self getmode() == "sentry")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		var_01 = self gettagangles("tag_flash");
		param_00 = (0,var_01[1],var_01[2]);
	}

	self.oldmode = self getmode();
	self setmode("manual");
	var_02 = anglestoforward(param_00);
	var_03 = var_02 * 96;
	var_04 = self gettagorigin("tag_aim") + var_03;
	self.temptarget = spawn("script_origin",var_04);
	self.temptarget.ignoreme = 1;
	self.temptarget linkto(self.ownervehicle);
	self cleartargetentity();
	self settargetentity(self.temptarget);
	self waittill("turret_on_target");
}

//Function Number: 33
turret_aim_restore()
{
	self cleartargetentity();
	if(isdefined(self.temptarget))
	{
		self.temptarget unlink();
		self.temptarget delete();
	}

	if(isdefined(self.oldmode))
	{
		self setmode(self.oldmode);
		self.oldmode = undefined;
	}
}

//Function Number: 34
turret_aiming_near_target(param_00,param_01)
{
	var_02 = turret_get_angle_to_target(param_00);
	if(var_02 <= param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
turret_get_angle_to_target(param_00)
{
	var_01 = vectortoyaw(param_00.origin - self.origin);
	var_02 = self gettagangles("tag_flash")[1];
	var_03 = animscripts\utility::absangleclamp180(var_02 - var_01);
	return var_03;
}

//Function Number: 36
lerp_out_drop_pitch(param_00)
{
	var_01 = maps\_utility::create_blend(::blend_droppitch,20,0);
	var_01.time = param_00;
}

//Function Number: 37
blend_droppitch(param_00,param_01,param_02)
{
	var_03 = param_01 * 1 - param_00 + param_02 * param_00;
	self setdefaultdroppitch(var_03);
}
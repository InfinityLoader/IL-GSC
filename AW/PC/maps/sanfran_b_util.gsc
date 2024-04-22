/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 740 ms
 * Timestamp: 4/22/2024 2:35:36 AM
*******************************************************************/

//Function Number: 1
teleport_to_scriptstruct(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
	level.player setorigin(var_01.origin);
	if(isdefined(var_01.angles))
	{
		level.player setplayerangles(var_01.angles);
	}

	var_02 = getentarray("hero","script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(isspawner(var_04))
		{
			var_02 = common_scripts\utility::array_remove(var_02,var_04);
		}
	}

	var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		if(var_07 < var_06.size)
		{
			var_02[var_07] forceteleport(var_06[var_07].origin,var_06[var_07].angles);
			var_02[var_07] setgoalpos(var_06[var_07].origin);
			continue;
		}

		var_02[var_07] forceteleport(level.player.origin,level.player.angles);
		var_02[var_07] setgoalpos(level.player.origin);
	}
}

//Function Number: 2
equip_microwave_grenade()
{
	self.grenadeweapon = "microwave_grenade";
	self.grenadeammo = 2;
}

//Function Number: 3
add_to_threat_bias(param_00)
{
	if(self.classname == "script_model")
	{
		return;
	}

	createthreatbiasgroup(param_00);
	self setthreatbiasgroup(param_00);
}

//Function Number: 4
set_flag_when_in_volume(param_00,param_01)
{
	self endon("death");
	while(!self istouching(param_00))
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set(param_01);
}

//Function Number: 5
bloody_death(param_00)
{
	self endon("death");
	if(!issentient(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.bloody_death) && self.bloody_death)
	{
		return;
	}

	self.bloody_death = 1;
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	var_01 = [];
	var_01[0] = "j_hip_le";
	var_01[1] = "j_hip_ri";
	var_01[2] = "j_head";
	var_01[3] = "j_spine4";
	var_01[4] = "j_elbow_le";
	var_01[5] = "j_elbow_ri";
	var_01[6] = "j_clavicle_le";
	var_01[7] = "j_clavicle_ri";
	for(var_02 = 0;var_02 < 3 + randomint(5);var_02++)
	{
		var_03 = randomintrange(0,var_01.size);
		thread bloody_death_fx(var_01[var_03],undefined);
		wait(randomfloat(0.1));
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 6
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 7
wait_for_number_enemies_alive(param_00)
{
	level.player endon("death");
	while(getaicount("axis") > param_00)
	{
		wait(0.05);
	}
}

//Function Number: 8
temp_subtitle(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = -42;
	var_02 settext(param_00);
	var_02.fontscale = 1.46;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "bottom";
	var_02.sort = 1;
	wait(param_01);
	var_02 destroy();
}

//Function Number: 9
setup_level_rumble_ent()
{
	if(!isdefined(level.rumble_ent))
	{
		level.rumble_ent = maps\_utility::get_rumble_ent("steady_rumble",0);
	}

	level.rumble_ent.intensity = 0;
}

//Function Number: 10
rumble_set_ent_rumble_intensity_for_time(param_00,param_01,param_02)
{
	param_00.intensity = param_01;
	wait(param_02);
	param_00.intensity = 0;
}

//Function Number: 11
enemy_is_in_vehicle()
{
	return isdefined(self.ridingvehicle);
}

//Function Number: 12
hide_friendname_until_flag_or_notify(param_00)
{
	if(!isdefined(self.name))
	{
		return;
	}

	level.player endon("death");
	self endon("death");
	self.old_name = self.name;
	self.name = " ";
	if(common_scripts\utility::flag_exist(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}
	else
	{
		level waittill(param_00);
	}

	self.name = self.old_name;
}

//Function Number: 13
kill_no_react()
{
	if(!isalive(self))
	{
		return;
	}

	self.allowdeath = 1;
	self.a.nodeath = 1;
	thread maps\_utility::set_battlechatter(0);
	self kill();
}

//Function Number: 14
drone_track_player()
{
	self endon("death");
	for(;;)
	{
		var_00 = anglestoforward(level.player getplayerangles()) * 512;
		var_00 = var_00 + (randomintrange(-300,300),randomintrange(-300,300),randomintrange(96,164));
		var_01 = level.player geteye() + var_00;
		var_02 = 3;
		if(bullettracepassed(self gettagorigin("tag_flash"),var_01,0,self))
		{
			self vehicle_setspeedimmediate(40);
			self setvehgoalpos(var_01);
			self waittill("goal");
			self vehicle_setspeedimmediate(0);
		}
		else
		{
			wait(randomfloatrange(2,5));
			continue;
		}

		wait(randomfloatrange(5,10));
	}
}

//Function Number: 15
drone_fire_timing()
{
	self endon("death");
	for(;;)
	{
		maps\_utility::ent_flag_set("fire_disabled");
		wait(randomfloatrange(3,5));
		maps\_utility::ent_flag_clear("fire_disabled");
		wait(randomfloatrange(1,3));
	}
}

//Function Number: 16
init_bobbing_boats()
{
	level.bobbing_objects = [];
	var_00 = maps\_bobbing_boats::createdefaultbobsettings();
	var_01 = getentarray("bobbing_ship","script_noteworthy");
	maps\_bobbing_boats::prep_bobbing(var_01,::maps\_bobbing_boats::bobbingobject,var_00,0);
	level.bobbing_objects = maps\_shg_utility::array_combine_unique(level.bobbing_objects,var_01);
	var_02 = maps\_bobbing_boats::createdefaultbobsettings();
	var_02.max_pitch = 1;
	var_03 = getentarray("bobbing_ship_big","script_noteworthy");
	maps\_bobbing_boats::prep_bobbing(var_03,::maps\_bobbing_boats::bobbingobject,var_02,0);
	level.bobbing_objects = maps\_shg_utility::array_combine_unique(level.bobbing_objects,var_03);
	maps\_bobbing_boats::start_bobbing(level.bobbing_objects);
}

//Function Number: 17
warbird_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	thread warbird_fire_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		thread warbird_fire(param_00);
	}
}

//Function Number: 18
warbird_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_03 = 3;
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_04 = getaiarray("allies");
		if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
		{
			var_05 = 33;
			if(randomint(100) <= var_05)
			{
				var_04 = common_scripts\utility::array_add(var_04,level.player);
			}
		}

		var_06 = [];
		foreach(var_08 in var_04)
		{
			if(isdefined(var_08.ignoreme) && var_08.ignoreme)
			{
				continue;
			}
			else
			{
				var_06[var_06.size] = var_08;
			}
		}

		var_06 = sortbydistance(var_06,self.origin);
		var_0A = undefined;
		foreach(var_08 in var_06)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			if(!isalive(var_08))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0C = self.mgturret[0] gettagorigin("tag_flash");
				var_0D = var_08 geteye();
				var_0E = vectornormalize(var_0D - var_0C);
				var_0F = var_0D + var_0E * 20;
				if(!sighttracepassed(var_0F,var_0D,0,var_08,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0A = var_08;
			break;
		}

		if(isdefined(var_0A))
		{
			var_01 settargetentity(var_0A);
			var_02 settargetentity(var_0A);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0A,param_00);
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(var_03);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 19
wait_for_warbird_fire_target_done(param_00,param_01)
{
	param_00 endon("death");
	if(!maps\_utility::ent_flag("fire_turrets"))
	{
		return;
	}

	self endon("fire_turrets");
	if(param_00 == level.player)
	{
		var_02 = 0.6;
	}
	else
	{
		var_02 = 3;
	}

	var_03 = 0;
	while(var_03 < var_02)
	{
		if(isdefined(param_01) && param_01)
		{
			var_04 = self.mgturret[0] gettagorigin("tag_flash");
			var_05 = param_00 geteye();
			var_06 = vectornormalize(var_05 - var_04);
			var_07 = var_04 + var_06 * 20;
			if(!sighttracepassed(var_07,var_05,0,param_00,self.mgturret[0]))
			{
				return;
			}
		}

		var_03 = var_03 + 0.3;
		wait(0.3);
	}
}

//Function Number: 20
warbird_fire_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 21
ambient_warbird_wait_to_fire()
{
	self endon("death");
	level endon("stop_ambient_warbird_firing");
	if(!maps\_utility::ent_flag_exist("ambient_warbird_fire"))
	{
		maps\_utility::ent_flag_init("ambient_warbird_fire");
	}

	for(;;)
	{
		maps\_utility::ent_flag_wait("ambient_warbird_fire");
		self notify("fire_turrets");
		maps\_utility::ent_flag_set("fire_turrets");
		self notify("warbird_fire");
		maps\_utility::ent_flag_waitopen("ambient_warbird_fire");
		self notify("warbird_stop_firing");
		maps\_utility::ent_flag_clear("fire_turrets");
	}
}

//Function Number: 22
ambient_warbird_shooting_think(param_00)
{
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	for(;;)
	{
		self waittill("warbird_fire");
		thread ambient_warbird_fire();
	}
}

//Function Number: 23
ambient_warbird_fire()
{
	self endon("death");
	level endon("stop_ambient_warbird_firing");
	var_00 = self.mgturret[0];
	var_01 = self.mgturret[1];
	var_02 = 2;
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_03 = getentarray("ambient_warbird_targets","script_noteworthy");
		var_03 = sortbydistance(var_03,self.origin);
		var_04 = var_03[0];
		if(isdefined(var_04))
		{
			var_00 settargetentity(var_04);
			var_01 settargetentity(var_04);
			var_00 turretfireenable();
			var_01 turretfireenable();
			var_00 startfiring();
			var_01 startfiring();
			wait(var_02);
			var_00 cleartargetentity();
			var_01 cleartargetentity();
			var_00 turretfiredisable();
			var_01 turretfiredisable();
		}

		wait(0.05);
	}
}

//Function Number: 24
wait_to_stop_firing()
{
	self endon("death");
	self waittill("warbird_stop_firing");
}

//Function Number: 25
dynamic_boost_jump()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("player_can_boost_jump");
		if(!isdefined(level.player.high_jump_enabled) || !level.player.high_jump_enabled)
		{
			level.player maps\_player_high_jump::enable_high_jump();
		}

		common_scripts\utility::flag_waitopen("player_can_boost_jump");
		if(isdefined(level.player.high_jump_enabled) && level.player.high_jump_enabled)
		{
			level.player maps\_player_high_jump::disable_high_jump();
		}
	}
}

//Function Number: 26
warbird_wait_for_unload()
{
	self endon("death");
	self waittill("unloaded");
	maps\_utility::ent_flag_set("unloaded");
}

//Function Number: 27
get_passengers()
{
	var_00 = self.riders;
	var_00 = common_scripts\utility::array_remove(var_00,var_00[0]);
	return var_00;
}

//Function Number: 28
ignore_until_unloaded()
{
	foreach(var_01 in self)
	{
		var_01.ignoreme = 1;
		var_01 thread wait_until_unloaded();
	}
}

//Function Number: 29
wait_until_unloaded()
{
	self endon("death");
	self waittill("jumpedout");
	self.ignoreme = 0;
}

//Function Number: 30
heli_wait_for_unload()
{
	self endon("death");
	self waittill("unloaded");
}

//Function Number: 31
setup_atlas_drone(param_00)
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	thread drone_fire_timing();
	maps\_utility::add_damage_function(::atlas_drone_damage_function);
	soundscripts\_snd::snd_message("attack_drone_audio_handler");
	if(!isdefined(level.deck_drones))
	{
		level.deck_drones = [];
	}

	level.deck_drones = common_scripts\utility::array_add(level.deck_drones,self);
	common_scripts\utility::flag_wait(param_00);
	level.deck_drones = common_scripts\utility::array_remove(level.deck_drones,self);
	self kill();
}

//Function Number: 32
atlas_drone_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_04) && param_04 == "MOD_IMPACT" || param_04 == "MOD_PROJECTILE")
	{
		var_07 = param_01 getcurrentweapon();
		if(isdefined(var_07) && issubstr(var_07,"microdronelauncher"))
		{
			maps\_vehicle::vehicle_set_health(1);
			level.deck_drones = common_scripts\utility::array_remove(level.deck_drones,self);
			self dodamage(99999,self.origin,param_01);
		}
	}
}

//Function Number: 33
setup_corpses(param_00)
{
	if(!isdefined(param_00) || !param_00)
	{
		var_01 = common_scripts\utility::getstructarray("org_corpse","script_noteworthy");
		var_02 = getent("corpse_spawner","targetname");
	}
	else
	{
		var_01 = common_scripts\utility::getstructarray("org_civ_corpse","script_noteworthy");
		var_02 = getent("civ_corpse_spawner","targetname");
	}

	foreach(var_04 in var_01)
	{
		var_02.count++;
		var_05 = var_02 maps\_utility::spawn_ai(1);
		var_05.ignoreme = 1;
		var_05 thread maps\_utility::set_battlechatter(0);
		var_05.allowdeath = 0;
		var_05.animname = "generic";
		var_05.name = " ";
		var_05 notsolid();
		if(isdefined(var_05.weapon) && var_05.weapon != "none")
		{
			var_05 maps\_utility::gun_remove();
		}

		var_05 thermaldrawdisable();
		if(issubstr(var_04.script_parameters,"death"))
		{
			var_04 thread maps\_anim::anim_single_solo(var_05,var_04.script_parameters);
			var_06 = var_05 maps\_utility::getanim(var_04.script_parameters);
			var_05 common_scripts\utility::delaycall(0.05,::setanimtime,var_06,1);
			continue;
		}

		var_04 thread maps\_anim::anim_generic_loop(var_05,var_04.script_parameters);
	}
}

//Function Number: 34
water_sheeting()
{
	var_00 = getentarray("trig_water_sheeting","targetname");
	common_scripts\utility::array_thread(var_00,::water_sheeting_think);
}

//Function Number: 35
water_sheeting_think()
{
	self waittill("trigger");
	for(;;)
	{
		if(level.player istouching(self))
		{
			level.player setwatersheeting(1,1.5);
			wait(0.5);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 36
disable_awareness(param_00)
{
	self.dontmelee = 1;
	self.ignoresuppression = 1;
	self.suppressionwait_old = self.suppressionwait;
	self.suppressionwait = 0;
	maps\_utility::disable_surprise();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	self.grenadeawareness = 0;
	self.disablefriendlyfirereaction = 1;
	self.dodangerreact = 0;
	maps\_utility::enable_dontevershoot();
	self.ignoreall = 1;
	self.ignoreme = 1;
}

//Function Number: 37
enable_awareness()
{
	self.ignoreall = 0;
	self.dontmelee = undefined;
	self.ignoresuppression = 0;
	self.suppressionwait = self.suppressionwait_old;
	self.suppressionwait_old = undefined;
	maps\_utility::enable_surprise();
	self.ignorerandombulletdamage = 0;
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
	self.grenadeawareness = 1;
	self.ignoreme = 0;
	maps\_utility::disable_dontevershoot();
	self.disablefriendlyfirereaction = undefined;
	self.dodangerreact = 1;
}

//Function Number: 38
disable_awareness_limited()
{
	self.ignoresuppression = 1;
	self.suppressionwait = 0;
	maps\_utility::disable_surprise();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	self.grenadeawareness = 0;
	self.disablefriendlyfirereaction = 1;
	self.dodangerreact = 0;
}

//Function Number: 39
hanger_reinforcements_think()
{
	self endon("death");
	thread equip_microwave_grenade();
	self.ignoreall = 1;
	maps\_utility::set_goal_radius(16);
	self waittill("goal");
	if(isdefined(self) && isalive(self))
	{
		self.ignoreall = 0;
	}
}

//Function Number: 40
postspawn_rpg_vehicle()
{
	self setmodel("projectile_rpg7");
	var_00 = common_scripts\utility::getfx("rpg_trail");
	playfxontag(var_00,self,"tag_origin");
	var_00 = common_scripts\utility::getfx("rpg_muzzle");
	playfxontag(var_00,self,"tag_origin");
	self playsound("weap_rpg_fire_npc");
	if(isdefined(self.script_sound))
	{
		if(isdefined(self.script_wait))
		{
			common_scripts\utility::delaycall(self.script_wait,::playsound,self.script_sound);
		}
		else
		{
			self playsound(self.script_sound);
		}
	}
	else
	{
		self playloopsound("weap_rpg_loop");
	}

	self waittill("reached_end_node");
	self notify("explode",self.origin);
	var_01 = 0;
	if(isdefined(self.script_exploder))
	{
		common_scripts\_exploder::exploder(self.script_exploder);
		var_01 = 1;
	}
	else if(isdefined(self.currentnode))
	{
		var_02 = undefined;
		var_03 = self.currentnode;
		while(isdefined(var_03))
		{
			var_02 = var_03;
			if(!isdefined(var_03.target))
			{
				break;
			}

			var_03 = getvehiclenode(var_03.target,"targetname");
		}

		if(isdefined(var_02.target))
		{
			var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
			if(isdefined(var_04))
			{
				level thread rpg_explosion(var_04.origin,var_04.angles);
				var_01 = 1;
			}
		}
	}

	if(!var_01)
	{
		var_04 = spawnstruct();
		var_04.origin = self.origin;
		var_04.angles = (-90,0,0);
		level thread rpg_explosion(var_04.origin,var_04.angles);
	}

	self delete();
}

//Function Number: 41
rpg_explosion(param_00,param_01)
{
	var_02 = common_scripts\utility::getfx("rpg_explode");
	playfx(var_02,param_00,anglestoforward(param_01),anglestoup(param_01));
	radiusdamage(param_00,200,150,50);
	thread common_scripts\utility::play_sound_in_space("null",param_00);
}

//Function Number: 42
hide_navy_boats()
{
	var_00 = getentarray("navy_ship","targetname");
	var_01 = getentarray("navy_ship_right","targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 hide();
	}
}

//Function Number: 43
show_navy_boats()
{
	var_00 = getentarray("navy_ship","targetname");
	var_01 = getentarray("navy_ship_right","targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 show();
	}
}

//Function Number: 44
hanger_bad_path()
{
	var_00 = getent("hanger_stairs_bad_place","targetname");
	badplace_brush("bad_place",-1,var_00,"axis");
}

//Function Number: 45
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 46
ending_fade_out(param_00)
{
	setblur(10,param_00);
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}

	waittillframeend;
	var_01 destroy();
}

//Function Number: 47
fall_fail()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00 == level.player)
		{
			setdvar("ui_deadquote","");
			setblur(30,2);
			maps\_utility::missionfailedwrapper();
		}
	}
}

//Function Number: 48
warbird_heavy_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	for(;;)
	{
		self waittill("warbird_fire");
		maps\_utility::ent_flag_set("fire_turrets");
		thread warbird_heavy_fire(param_00);
		self waittill("warbird_stop_firing");
		maps\_utility::ent_flag_clear("fire_turrets");
	}
}

//Function Number: 49
warbird_heavy_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_01 notify("stop_burst_fire_unmanned");
	var_02 notify("stop_burst_fire_unmanned");
	var_03 = 0.4;
	var_04 = var_03 / 2;
	var_01 thread burst_fire_warbird(var_03,0);
	var_02 thread burst_fire_warbird(var_03,var_04);
	var_05 = common_scripts\utility::get_enemy_team(self.script_team);
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_06 = getaiarray(var_05);
		if(isdefined(level.flying_attack_drones))
		{
			var_07 = level.flying_attack_drones;
		}
		else
		{
			var_07 = [];
		}

		if(isdefined(level.drones) && isdefined(level.drones[var_05].array))
		{
			var_06 = common_scripts\utility::array_combine(var_06,level.drones[var_05].array);
		}

		if(var_05 == level.player.team)
		{
			var_06 = common_scripts\utility::array_add(var_06,level.player);
		}

		var_06 = common_scripts\utility::array_combine(var_06,var_07);
		var_08 = [];
		foreach(var_0A in var_06)
		{
			if(isdefined(var_0A.ignoreme) && var_0A.ignoreme)
			{
				continue;
			}
			else
			{
				var_08[var_08.size] = var_0A;
			}
		}

		var_08 = sortbydistance(var_08,self.origin);
		var_0C = undefined;
		foreach(var_0A in var_08)
		{
			if(!isdefined(var_0A))
			{
				continue;
			}

			if(!isalive(var_0A))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0E = self.mgturret[0] gettagorigin("tag_flash");
				var_0F = var_0A geteye();
				var_10 = vectornormalize(var_0F - var_0E);
				var_11 = var_0E + var_10 * 20;
				if(!sighttracepassed(var_11,var_0F,0,var_0A,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0C = var_0A;
			break;
		}

		if(isdefined(var_0C))
		{
			var_01 settargetentity(var_0C);
			var_02 settargetentity(var_0C);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0C,param_00);
			var_01 notify("stop_firing");
			var_02 notify("stop_firing");
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(0.05);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 50
burst_fire_warbird(param_00,param_01)
{
	self endon("death");
	self endon("stop_burst_fire_warbird");
	var_02 = 1;
	var_03 = 1;
	var_04 = 1;
	var_05 = 1;
	var_06 = gettime();
	var_07 = "start";
	for(;;)
	{
		var_08 = var_06 - gettime() * 0.001;
		if(self isfiringturret() && var_08 <= 0)
		{
			if(var_07 != "fire")
			{
				var_07 = "fire";
				thread doshoottuned(param_00,param_01);
			}

			var_08 = var_04 + randomfloat(var_05);
			thread turrettimer(var_08);
			self waittill("turretstatechange");
			var_08 = var_02 + randomfloat(var_03);
			var_06 = gettime() + int(var_08 * 1000);
			continue;
		}

		if(var_07 != "aim")
		{
			var_07 = "aim";
		}

		thread turrettimer(var_08);
		self waittill("turretstatechange");
	}
}

//Function Number: 51
doshoottuned(param_00,param_01)
{
	self endon("death");
	self endon("turretstatechange");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	for(;;)
	{
		self shootturret();
		wait(param_00);
	}
}

//Function Number: 52
turrettimer(param_00)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("turretstatechange");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("turretstatechange");
	}
}
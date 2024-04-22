/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_mob_turret.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 334 ms
 * Timestamp: 4/22/2024 2:35:32 AM
*******************************************************************/

//Function Number: 1
setup_mob_turret()
{
	level.player maps\_shg_utility::setup_player_for_scene();
	soundscripts\_snd::snd_message("mob_audio_setup");
	if(level.nextgen)
	{
		thread maps\_utility::fog_set_changes("sanfran_b_guns_bright",0.05);
		level.player setclutforplayer("",1);
		level.player lightsetforplayer("sanfran_b_guns_bright");
		level.player common_scripts\utility::delaycall(0.5,::lightsetforplayer,"sanfran_b_guns_a");
		setblur(6,0);
		maps\_utility::delaythread(0.5,::maps\_utility::fog_set_changes,"sanfran_b_guns",0.05);
	}
	else
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_guns_bright",0.05);
		level.player lightsetforplayer("sanfran_b_guns_bright");
		wait(1.1);
		thread maps\_utility::vision_set_fog_changes("sanfran_b_guns",0.05);
		level.player lightsetforplayer("sanfran_b_guns");
	}

	common_scripts\utility::noself_delaycall(0.5,::setblur,0,1);
	setsaveddvar("sm_usedSunCascadeCount",3);
	setsaveddvar("sm_sunSampleSizeNear",6);
	setsaveddvar("r_fog_ev_adjust",1);
	common_scripts\_exploder::exploder(3636);
	thread maps\sanfran_b_lighting::ending_viewmodelblur();
	level.player soundscripts\_snd::snd_message("mob_xform");
	var_00 = getentarray("railgun_turn_off_clip","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_04 = getent("mob_turret_right","targetname");
	level.mob_turret_right = var_04;
	var_04.angles = (-5,0,5);
	var_04.angles = var_04.angles - (0,325,0);
	var_04 setmodel("vehicle_mob_deck_large_calibur_turret_vm");
	var_05 = (-0.99,0,0);
	level.player maps\sanfran_b_code::sonar_off();
	level.player notify("end_sonar_vision");
	level.player link_player_to_mob_turret(var_04,0);
	thread attachdistortionfx(var_04);
	common_scripts\utility::flag_set("player_on_turret_1");
	var_04 thread control_mob_turret(var_05);
	var_06 = "first_cargo_ship_destroyed";
	var_07 = 6.25;
	var_04 thread railgun_track_damage(var_06,var_07);
	common_scripts\utility::flag_wait(var_06);
	wait(var_07);
	common_scripts\utility::flag_set("player_switching_to_turret_2");
	thread maps\sanfran_b_code::static_overlay();
	common_scripts\utility::flag_clear("cargo_ship_destroyed");
	common_scripts\utility::flag_clear("player_firing_mob_turret");
	level.player unlink_player_from_mob_turret(var_04);
	if(level.nextgen)
	{
		level.player lightsetforplayer("sanfran_b_guns_bright");
		thread maps\_utility::fog_set_changes("sanfran_b_guns_bright",0.05);
		level.player common_scripts\utility::delaycall(0.5,::lightsetforplayer,"sanfran_b_guns_b");
		setblur(6,0);
		maps\_utility::delaythread(0.5,::maps\_utility::fog_set_changes,"sanfran_b_guns",0.05);
	}
	else
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_guns_bright",0.05);
		level.player lightsetforplayer("sanfran_b_guns_bright");
		wait(1.1);
		thread maps\_utility::vision_set_fog_changes("sanfran_b_guns",0.5);
		level.player lightsetforplayer("sanfran_b_guns");
	}

	common_scripts\utility::noself_delaycall(0.5,::setblur,0,1);
	if(level.nextgen)
	{
		level.defaultsundir = getmapsunangles();
		lerpsunangles(level.defaultsundir,(-23,80,0),0.1);
	}

	level.player soundscripts\_snd::snd_message("mob_xform");
	var_08 = getent("mob_turret_left","targetname");
	level.mob_turret_left = var_08;
	var_08.angles = (5,0,-5);
	var_08.angles = var_08.angles + (0,152,0);
	var_08 setmodel("vehicle_mob_deck_large_calibur_turret_vm");
	var_05 = (-0.55,0.45,0);
	var_09 = getent("railgun_turn_off","targetname");
	level.deletable_turret = var_09;
	var_09 hide();
	level.player link_player_to_mob_turret(var_08,0);
	thread attachdistortionfx(var_08);
	common_scripts\utility::flag_set("player_on_turret_2");
	var_0A = "second_cargo_ship_destroyed";
	var_07 = 7.5;
	var_08 thread railgun_track_damage(var_0A,var_07);
	var_08 thread railgun_damage_timer();
	var_08 thread control_mob_turret(var_05);
	common_scripts\_exploder::exploder(3700);
	common_scripts\utility::flag_wait(var_0A);
	wait(var_07);
	thread maps\sanfran_b_code::static_overlay();
	level.player unlink_player_from_mob_turret(var_08);
	wait(0.25);
	level.player notify("laser_off");
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran_b_end",0.1);
	}
	else
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_end",0.1);
	}

	level.player lightsetforplayer("sanfran_b_end");
	common_scripts\_exploder::exploder(9028);
	maps\_utility::stop_exploder(3636);
	thread maps\sanfran_b_lighting::ending_viewmodelblur_reset();
	resetsundirection();
	setsaveddvar("r_fog_ev_adjust",1.5);
}

//Function Number: 2
link_player_to_mob_turret(param_00,param_01)
{
	var_02 = 1;
	var_03 = "tag_aim_animated";
	var_04 = anglestoforward(param_00 gettagangles(var_03));
	var_05 = var_04 * 15;
	var_06 = anglestoup(param_00 gettagangles(var_03));
	var_07 = var_06 * 200;
	var_08 = param_00 common_scripts\utility::spawn_tag_origin();
	var_08.origin = var_08.origin + var_05 + var_07;
	var_08 linkto(param_00,var_03);
	self playerlinktodelta(param_00,"tag_player",1,0,0,0,0,1);
	self enablemousesteer(1);
	wait(0.5);
	param_00 start_railgun_hud();
	param_00.animname = "mob_turret";
	param_00 maps\_utility::assign_animtree();
	param_00 setflaggedanimknob("turret_transform",%sf_b_mob_turret_transform,1,0,1);
	var_09 = undefined;
	if(isdefined(param_01))
	{
		var_0A = -30;
		var_0B = 12;
		if(param_01 < 0)
		{
			var_09 = param_01 / var_0A;
		}
		else
		{
			var_09 = param_01 / var_0B;
		}

		if(param_01 < 0)
		{
			param_00.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
			param_00.mob_pitch_sign = -1;
			param_00 setanimknob(param_00.mob_pitch_anim,1,0,0);
			param_00 setanimtime(param_00.mob_pitch_anim,var_09);
		}
		else
		{
			param_00.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
			param_00.mob_pitch_sign = 1;
			param_00 setanimknob(param_00.mob_pitch_anim,1,0,0);
			param_00 setanimtime(param_00.mob_pitch_anim,var_09);
		}
	}

	if(var_02)
	{
		self unlink();
		var_0C = 2.65;
		self playerlinktoblend(var_08,"tag_origin",var_0C,0.25,0.25);
		common_scripts\utility::delaycall(var_0C,::playerlinktodelta,var_08,"tag_origin",1,0,0,0,0,1);
	}

	param_00 waittillmatch("end","turret_transform");
	param_00.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
	param_00.mob_yaw_sign = -1;
	param_00 setanimknoball(param_00.mob_yaw_anim,%root,1,0,0);
	if(isdefined(var_09))
	{
		param_00 setanimknob(param_00.mob_pitch_anim,1,0,0);
		param_00 setanimtime(param_00.mob_pitch_anim,var_09);
	}

	var_08 thread delete_on_player_unlink();
}

//Function Number: 3
unlink_player_from_mob_turret(param_00)
{
	self enablemousesteer(0);
	self unlink();
	param_00 notify("end_control_mob_turret");
	param_00 stop_railgun_hud();
}

//Function Number: 4
delete_on_player_unlink()
{
	while(level.player islinked())
	{
		wait(0.1);
	}

	self delete();
}

//Function Number: 5
should_pause_yaw_anim(param_00,param_01,param_02)
{
	if(isdefined(self.mob_yaw_anim))
	{
		if(abs(param_00) < 0.1)
		{
			return 1;
		}

		if(param_01 < param_02[0] && param_00 > 0)
		{
			return 1;
		}

		if(param_01 > param_02[1] && param_00 < 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
control_mob_turret(param_00)
{
	self endon("end_control_mob_turret");
	maps\_utility::anim_stopanimscripted();
	childthread control_mob_fire();
	for(;;)
	{
		var_01 = level.player getnormalizedcameramovements();
		var_02 = var_01[0] * 0.5;
		var_03 = var_01[1] * 0.25;
		var_04 = 0;
		if(isdefined(self.mob_yaw_anim))
		{
			var_04 = self getanimtime(self.mob_yaw_anim);
			var_04 = var_04 * self.mob_yaw_sign;
		}

		self.current_yaw = var_04;
		if(should_pause_yaw_anim(var_03,var_04,param_00))
		{
			self setanimknob(self.mob_yaw_anim,1,0,0);
			soundscripts\_snd::snd_message("mob_turret_move","lat_stop");
		}
		else if(var_04 == 0)
		{
			if(var_03 < 0)
			{
				self.mob_yaw_anim = %sf_b_mob_turret_center_to_l;
				self.mob_yaw_sign = 1;
			}
			else
			{
				self.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
				self.mob_yaw_sign = -1;
			}

			self setanimknob(self.mob_yaw_anim,1,0,abs(var_03));
			soundscripts\_snd::snd_message("mob_turret_move","lat_move");
		}
		else if(var_04 > 0)
		{
			self.mob_yaw_anim = %sf_b_mob_turret_center_to_l;
			self.mob_yaw_sign = 1;
			self setanimknob(self.mob_yaw_anim,1,0,var_03 * -1);
			soundscripts\_snd::snd_message("mob_turret_move","lat_move");
			self setanimtime(self.mob_yaw_anim,var_04);
		}
		else
		{
			self.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
			self.mob_yaw_sign = -1;
			self setanimknob(self.mob_yaw_anim,1,0,var_03);
			soundscripts\_snd::snd_message("mob_turret_move","lat_move");
			self setanimtime(self.mob_yaw_anim,var_04 * self.mob_yaw_sign);
		}

		var_05 = 0;
		if(isdefined(self.mob_pitch_anim))
		{
			var_05 = self getanimtime(self.mob_pitch_anim);
			var_05 = var_05 * self.mob_pitch_sign;
		}

		self.current_pitch = var_05;
		if(isdefined(self.mob_pitch_anim) && abs(var_02) < 0.1)
		{
			self setanimknob(self.mob_pitch_anim,1,0,0);
			soundscripts\_snd::snd_message("mob_turret_move","vert_stop");
		}
		else if(var_05 == 0)
		{
			if(var_02 < 0)
			{
				self.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
				self.mob_pitch_sign = 1;
			}
			else
			{
				self.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
				self.mob_pitch_sign = -1;
			}

			self setanimknob(self.mob_pitch_anim,1,0.2,0);
			wait(0.2);
			self setanimtime(self.mob_pitch_anim,0.001);
		}
		else if(var_05 > 0)
		{
			self.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
			self.mob_pitch_sign = 1;
			self setanimknob(self.mob_pitch_anim,1,0,var_02 * -1);
			soundscripts\_snd::snd_message("mob_turret_move","vert_move");
			self setanimtime(self.mob_pitch_anim,var_05);
		}
		else
		{
			self.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
			self.mob_pitch_sign = -1;
			self setanimknob(self.mob_pitch_anim,1,0,var_02);
			soundscripts\_snd::snd_message("mob_turret_move","vert_move");
			self setanimtime(self.mob_pitch_anim,var_05 * self.mob_pitch_sign);
		}

		wait(0.05);
	}
}

//Function Number: 7
control_mob_fire()
{
	var_00 = 3000;
	self.ms_until_ready_to_fire = 0;
	for(;;)
	{
		if(level.player attackbuttonpressed())
		{
			common_scripts\utility::flag_set("player_firing_mob_turret");
			mob_fire();
			self.ms_until_ready_to_fire = var_00;
			while(self.ms_until_ready_to_fire > 0)
			{
				wait(0.05);
				self.ms_until_ready_to_fire = self.ms_until_ready_to_fire - 50;
			}
		}

		wait(0.05);
	}
}

//Function Number: 8
mob_fire()
{
	var_00 = "tag_flash1";
	self setanimknobrestart(%sf_b_mob_turret_fire,1,0,1);
	thread fire_effects("tag_flash1");
	soundscripts\_snd::snd_message("mob_fire");
	thread fire_effects("tag_flash");
}

//Function Number: 9
fire_effects(param_00)
{
	var_01 = self gettagorigin(param_00);
	var_02 = self gettagangles(param_00);
	var_03 = anglestoforward(var_02);
	var_04 = var_01 + var_03 * 2000;
	magicbullet("mob_turret_missile",var_01,var_04,level.player);
	wait(0.05);
	playfx(common_scripts\utility::getfx("mob_turret_flash_view"),self gettagorigin(param_00),anglestoforward(self gettagangles(param_00)),anglestoup(self gettagangles(param_00)));
	thread fire_emp_wave(var_01,var_04);
	thread fire_archlight_rumbles();
	thread mob_fire_linger_smoke(param_00);
	if(param_00 == "tag_flash")
	{
		var_05 = 1;
	}
	else
	{
		var_05 = -1;
	}

	var_06 = 160;
	var_07 = var_05 * anglestoright(var_02) * var_06;
	thread calculate_water_pos(var_01 + var_07,var_03);
}

//Function Number: 10
fire_archlight_rumbles()
{
	maps\sanfran_b_util::setup_level_rumble_ent();
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.85,0.5);
	wait(0.5);
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.65,0.3);
	wait(0.3);
	thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.2);
}

//Function Number: 11
fire_emp_wave(param_00,param_01)
{
	var_02 = 500;
	var_03 = maps\_utility::getvehiclearray();
	var_04 = [];
	foreach(var_06 in var_03)
	{
		if(!isdefined(var_06.healthbuffer) || var_06.health < var_06.healthbuffer)
		{
			continue;
		}

		if(isdefined(var_06.classname) && issubstr(var_06.classname,"warbird"))
		{
			var_07 = vectorfromlinetopoint(param_00,param_01,var_06.origin);
			if(length(var_07) < var_02)
			{
				var_04[var_04.size] = var_06;
			}
		}
	}

	foreach(var_06 in var_04)
	{
		if(isdefined(var_06) && isalive(var_06) && var_06.health > var_06.healthbuffer)
		{
			var_06 thread destroy_warbird();
		}
	}
}

//Function Number: 12
destroy_warbird()
{
	self kill(level.player.origin,level.player);
	wait(0.05);
	if(isdefined(self))
	{
		self notify("crash_done");
		self notify("in_air_explosion");
	}
}

//Function Number: 13
kill_before_water()
{
	var_00 = 66500;
	var_01 = 67000;
	while(isdefined(self) && isalive(self))
	{
		var_02 = 0;
		var_03 = length(physicstrace(self.origin,self.origin + (0,0,-10000),self));
		if(var_03 <= var_00)
		{
			var_02 = 1;
		}
		else if(var_03 <= var_01)
		{
			var_02 = randomint(var_01 - var_00) < var_01 - var_03 - var_00;
		}

		if(var_02)
		{
			self notify("near_goal");
			return;
		}

		wait(0.1);
	}
}

//Function Number: 14
mob_fire_linger_smoke(param_00)
{
	wait(0.5);
	for(var_01 = 0;var_01 < 50;var_01++)
	{
		playfxontag(common_scripts\utility::getfx("mob_turret_flash_view_muzzlesmoke"),self,param_00);
		wait(0.05);
	}
}

//Function Number: 15
calculate_water_pos(param_00,param_01)
{
	var_02 = (-4546,69221,-2723);
	var_03 = (-5,0,5);
	var_04 = var_02 - param_00;
	var_05 = anglestoup(var_03);
	var_06 = vectordot(var_04,var_05);
	var_07 = param_00 + var_05 * var_06;
	var_08 = param_00 + param_01 * 10000;
	var_04 = var_02 - var_08;
	var_05 = anglestoup(var_03);
	var_06 = vectordot(var_04,var_05);
	var_09 = var_08 + var_05 * var_06;
}

//Function Number: 16
attachdistortionfx(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01 linkto(param_00,"tag_player",(5,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("drone_cam_distortion"),var_01,"tag_origin");
}

//Function Number: 17
start_railgun_hud()
{
	setomnvar("ui_railgun",1);
	thread railgun_hud_update();
}

//Function Number: 18
stop_railgun_hud()
{
	level notify("stop_railgun_hud");
	setomnvar("ui_railgun",0);
}

//Function Number: 19
railgun_hud_update()
{
	level endon("stop_railgun_hud");
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		if(isdefined(self.ms_until_ready_to_fire))
		{
			var_00 = self.ms_until_ready_to_fire;
		}

		if(isdefined(self.current_pitch))
		{
			var_01 = int(self.current_pitch + 1 * 50 + 0.5);
		}

		if(isdefined(self.current_yaw))
		{
			var_02 = int(self.current_yaw + 1 * 50 + 0.5);
		}

		luinotifyevent(&"railgun_hud_update",3,var_00,var_01,var_02);
		wait 0.05;
	}
}

//Function Number: 20
railgun_track_damage(param_00,param_01)
{
	level endon(param_00);
	var_02 = 2000;
	self.health = var_02;
	self setcandamage(1);
	var_03 = "overlay_static_digital";
	var_04 = newclienthudelem(level.player);
	var_04.x = 0;
	var_04.y = 0;
	var_04.alignx = "left";
	var_04.aligny = "top";
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04 setshader(var_03,640,480);
	var_04.alpha = 0;
	var_04.sort = -3;
	var_05 = newclienthudelem(level.player);
	var_05.x = 0;
	var_05.y = 0;
	var_05.alignx = "left";
	var_05.aligny = "top";
	var_05.horzalign = "fullscreen";
	var_05.vertalign = "fullscreen";
	var_05 setshader(var_03,640,480);
	var_05.alpha = 0;
	var_05.sort = -3;
	var_04 thread destroy_on_flag(param_00,param_01);
	var_05 thread destroy_on_flag(param_00,param_01);
	while(self.health > 0)
	{
		self waittill("damage",var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F);
		if(isdefined(var_0A) && var_0A == "MOD_RIFLE_BULLET")
		{
			self.health = self.health + int(var_06 * 0.9);
			if(!common_scripts\utility::flag("player_on_turret_2"))
			{
				if(randomintrange(1,99) < 20)
				{
					level.player playrumbleonentity("light_1s");
				}
			}
			else if(randomintrange(1,99) < 10)
			{
				level.player playrumbleonentity("light_1s");
			}

			continue;
		}

		var_05 thread railgun_track_damage_static();
		level.player playrumbleonentity("heavy_1s");
		var_04.alpha = min(var_02 - self.health / var_02 * 0.3,0.2);
	}

	level.player playrumbleonentity("artillery_rumble");
	level.player freezecontrols(1);
	setdvar("ui_deadquote",&"SANFRAN_B_DEFEND_FLEET_FAILED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 21
railgun_damage_timer()
{
	while(self.health > 0)
	{
		self dodamage(randomintrange(25,50),self.origin,self,self,"MOD_RIFLE_BULLET");
		wait(randomfloatrange(0.05,0.15));
	}
}

//Function Number: 22
railgun_track_damage_static()
{
	level notify("railgun_track_damage_static");
	level endon("railgun_track_damage_static");
	self.alpha = 0.4;
	wait(randomfloatrange(0.1,0.2));
	while(self.alpha > 0)
	{
		self.alpha = self.alpha - 0.05;
		wait(0.05);
	}
}

//Function Number: 23
destroy_on_flag(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_00);
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	self destroy();
}
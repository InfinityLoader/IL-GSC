/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _jetbike.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 782 ms
 * Timestamp: 4/22/2024 2:05:01 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("jetbike",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mil_hoverbike_ai");
	maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	if(issubstr(param_02,"slow"))
	{
		maps\_vehicle::build_aianims(::setanims_slow,::set_vehicle_anims_slow);
	}
	else
	{
		maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	}

	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_death_jolt_delay(9999);
	if(!isdefined(level.jetbike_anims_initialized))
	{
		setup_worldhands_anims();
		setup_player_driving_anims();
		level.jetbike_anims_initialized = 1;
	}

	precachemodel("vehicle_mil_hoverbike_vm");
	precachemodel("vehicle_mil_hoverbike_ai");
	precachemodel("vehicle_mil_hoverbike_ai_obj");
	if(level.nextgen)
	{
		precacheshader("m/mtl_hoverbike_screen_ui_01");
		precacheshader("m/mtl_hoverbike_screen_ui_02");
		precacheshader("m/mtl_hoverbike_screen_ui_03");
		precacheshader("m/mtl_hoverbike_screen_ui_04");
		precacheshader("m/mtl_mil_hoverbike_screens_off");
	}
	else
	{
		precacheshader("mq/mtl_hoverbike_screen_ui_01");
		precacheshader("mq/mtl_hoverbike_screen_ui_02");
		precacheshader("mq/mtl_hoverbike_screen_ui_03");
		precacheshader("mq/mtl_hoverbike_screen_ui_04");
		precacheshader("mq/mtl_mil_hoverbike_screens_off");
	}

	level._effect["hoverbike_pads_idle"] = loadfx("vfx/vehicle/hoverbike_pads_idle");
	level._effect["hoverbike_pads_slow"] = loadfx("vfx/vehicle/hoverbike_pads_slow");
	level._effect["hoverbike_pads_fast"] = loadfx("vfx/vehicle/hoverbike_pads_fast");
	level._effect["hoverbike_exhaust_idle"] = loadfx("vfx/vehicle/hoverbike_exhaust_idle");
	level._effect["hoverbike_exhaust_slow"] = loadfx("vfx/vehicle/hoverbike_exhaust_slow");
	level._effect["hoverbike_exhaust_fast"] = loadfx("vfx/vehicle/hoverbike_exhaust_fast");
	level._effect["hoverbike_tread_water_idle"] = loadfx("vfx/treadfx/hoverbike_tread_water_idle");
	level._effect["hoverbike_tread_water_slow"] = loadfx("vfx/treadfx/hoverbike_tread_water_slow");
	level._effect["hoverbike_tread_water_fast"] = loadfx("vfx/treadfx/hoverbike_tread_water_fast");
	level._effect["hoverbike_tread_asphalt_idle"] = loadfx("vfx/treadfx/hoverbike_tread_asphalt_idle");
	level._effect["hoverbike_tread_asphalt_slow"] = loadfx("vfx/treadfx/hoverbike_tread_asphalt_slow");
	level._effect["hoverbike_tread_asphalt_fast"] = loadfx("vfx/treadfx/hoverbike_tread_asphalt_fast");
}

//Function Number: 2
jetbike_allow_player_use(param_00)
{
	self makeunusable();
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"tag_origin",(0,0,64),(0,0,0));
	var_01 sethintstring(&"DETROIT_PROMPT_USE");
	var_01 makeusable();
	var_01 waittill("trigger");
	var_01 delete();
	thread jetbike_allow_player_use_internal(param_00);
}

//Function Number: 3
jetbike_blend_out_fake_speed(param_00)
{
	self.blend_out_fake_speed_start_ms = gettime();
	self.blend_out_fake_speed_blend_ms = param_00 * 1000;
}

//Function Number: 4
jetbike_stop_player_use()
{
	stop_jetbike_handle_viewmodel_anims();
	self notify("player_dismount");
	level.player dismountvehicle();
	self detach(level.scr_model["world_body"],"tag_driver");
}

//Function Number: 5
jetbike_speedometer_on()
{
	thread jetbike_speedometer_on_thread();
}

//Function Number: 6
jetbike_speedometer_on_thread()
{
	setomnvar("ui_hoverbike",1);
	wait(0.2);
	level.player setclientomnvar("ui_hoverbike_bootup",1);
	wait(0.2);
	if(level.nextgen)
	{
		self overridematerial("m/mtl_mil_hoverbike_screen_center_off","m/mtl_hoverbike_screen_ui_01");
		self overridematerial("m/mtl_mil_hoverbike_screen_right_off","m/mtl_hoverbike_screen_ui_02");
		self overridematerial("m/mtl_mil_hoverbike_screen_top_off","m/mtl_hoverbike_screen_ui_03");
		self overridematerial("m/mtl_mil_hoverbike_lights_off","m/mtl_hoverbike_screen_ui_04");
	}
	else
	{
		self overridematerial("mq/mtl_mil_hoverbike_screen_center_off","mq/mtl_hoverbike_screen_ui_01");
		self overridematerial("mq/mtl_mil_hoverbike_screen_right_off","mq/mtl_hoverbike_screen_ui_02");
		self overridematerial("mq/mtl_mil_hoverbike_screen_top_off","mq/mtl_hoverbike_screen_ui_03");
		self overridematerial("mq/mtl_mil_hoverbike_lights_off","mq/mtl_hoverbike_screen_ui_04");
	}

	thread jetbike_speedometer_think();
}

//Function Number: 7
jetbike_speedometer_off()
{
	self notify("jetbike_speedometer_off");
	level.player setclientomnvar("ui_hoverbike_bootup",0);
	setomnvar("ui_hoverbike",0);
	self overridematerialreset();
}

//Function Number: 8
jetbike_speedometer_think()
{
	self endon("jetbike_speedometer_off");
	for(;;)
	{
		waittillframeend;
		if(isdefined(self.fakespeed))
		{
			var_00 = self.fakespeed;
		}
		else
		{
			var_00 = maps\_shg_utility::get_differentiated_speed() / 17.6;
		}

		var_00 = var_00 * 1.396825;
		var_01 = int(clamp(abs(var_00),0,100));
		level.player setclientomnvar("ui_hoverbike_speed",var_01);
		wait 0.05;
	}
}

//Function Number: 9
create_anim_ent_for_my_position(param_00)
{
	if(isstring(param_00))
	{
		param_00 = maps\_utility::getanim(param_00);
	}

	var_01 = getstartorigin((0,0,0),(0,0,0),param_00);
	var_02 = getstartangles((0,0,0),(0,0,0),param_00);
	var_03 = transformmove(self.origin,self.angles,var_01,var_02,(0,0,0),(0,0,0));
	var_04 = spawnstruct();
	var_04.origin = var_03["origin"];
	var_04.angles = var_03["angles"];
	return var_04;
}

//Function Number: 10
smooth_vehicle_animation_wait(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 maps\_utility::getanim(param_02);
	var_06 = getstartorigin(param_01.origin,param_01.angles,var_05);
	var_07 = getstartangles(param_01.origin,param_01.angles,var_05);
	if(isdefined(param_04))
	{
	}
	else
	{
		param_04 = 1;
	}

	var_08 = param_00.origin + var_06 - param_00.origin * param_04;
	param_00 vehicledriveto(var_08,param_03);
	var_09 = var_06 - param_00.origin;
	var_0A = vectordot(var_09,var_06 - param_00.origin);
	var_0B = param_00 vehicle_getspeed();
	if(vectordot(vectornormalize(var_09),anglestoforward(param_00.angles)) > cos(75))
	{
		for(;;)
		{
			var_0C = vectordot(var_09,var_06 - param_00.origin);
			if(var_0C <= 0)
			{
				break;
			}

			var_0D = maps\_utility::linear_interpolate(var_0C / var_0A,param_03,var_0B);
			param_00 vehicledriveto(var_08,var_0D);
			wait(0.05);
		}
	}
}

//Function Number: 11
smooth_vehicle_animation_play(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = [];
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 2;
	}

	var_06 = param_05 * 0.5;
	var_07 = param_00 maps\_utility::getanim(param_02);
	var_08 = getstartorigin(param_01.origin,param_01.angles,var_07);
	var_09 = getstartangles(param_01.origin,param_01.angles,var_07);
	var_0A = transformmove(param_00.origin,param_00.angles,var_08,var_09,param_01.origin,param_01.angles);
	var_0B = level common_scripts\utility::spawn_tag_origin();
	var_0B.origin = var_0A["origin"];
	var_0B.angles = var_0A["angles"];
	var_0C = level common_scripts\utility::spawn_tag_origin();
	var_0C.origin = param_00.origin;
	var_0C.angles = param_00.angles;
	param_00 linkto(var_0B,"tag_origin");
	foreach(var_0E in param_03)
	{
		var_0E linkto(var_0B,"tag_origin");
	}

	var_0B linkto(var_0C,"tag_origin");
	var_0C moveto(var_08,param_05,param_05 * 0.3,param_05 * 0.3);
	var_0C rotateto(var_09,var_06,var_06 * 0.3,var_06 * 0.3);
	var_10 = getanimlength(var_07);
	if(param_04)
	{
		var_0B maps\_utility::delaythread(var_10 - 0.05,::maps\_anim::anim_set_rate,[param_00],param_02,0);
	}

	foreach(var_0E in param_03)
	{
	}

	var_0B thread maps\_anim::anim_single_solo(param_00,param_02,"tag_origin");
	var_0B thread maps\_anim::anim_single(param_03,param_02,"tag_origin");
	wait(var_10);
	foreach(var_0E in param_03)
	{
		if(isdefined(var_0E))
		{
			var_0E unlink();
		}
	}

	if(!param_04)
	{
		param_00 unlink();
		var_0B delete();
		var_0C delete();
	}
}

//Function Number: 12
jetbike_allow_player_use_internal(param_00)
{
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_01 = maps\_utility::spawn_anim_model("world_body");
	var_01 hide();
	var_02 = 0.5;
	level.player playerlinktoblend(var_01,"tag_player",var_02,var_02 * 0.3,var_02 * 0.3);
	level.player common_scripts\utility::delaycall(var_02,::playerlinktodelta,var_01,"tag_player",1,20,20,10,10,1);
	var_03 = 1;
	var_04 = getanimlength(var_01 maps\_utility::getanim("mount_jetbike"));
	level.player common_scripts\utility::delaycall(var_04 - var_03,::lerpviewangleclamp,var_03,var_03 * 0.5,var_03 * 0.5,0,0,0,0);
	var_01 common_scripts\utility::delaycall(var_02,::show);
	var_05 = [var_01,self];
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::getanim("mount_jetbike");
	}

	var_06 = create_anim_ent_for_my_position(param_00);
	var_06 maps\_anim::anim_single(var_05,"mount_jetbike");
	var_01 delete();
	self attach(level.scr_model["world_body"],"tag_driver");
	level.player.attackeraccuracy = 0;
	self stopanimscripted();
	level.player mountvehicle(self);
	level.player.drivingvehicle = self;
	self vehicle_jetbikesethoverforcescale(1);
	maps\_utility::ent_flag_set("jetbike_is_hovering");
	level.player enablemousesteer(1);
	self returnplayercontrol();
	thread jetbike_player_think();
}

//Function Number: 13
jetbike_handle_fake_speed()
{
	self endon("death");
	level.player endon("death");
	self endon("player_dismount");
	level endon("stop hovering player bike");
	self.boost_timer = 0;
	var_00 = 5;
	var_01 = 1;
	var_02 = 20;
	var_03 = 2;
	var_04 = 0.5;
	var_05 = 20;
	var_06 = 5;
	var_07 = 1;
	var_08 = 1;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	var_0C = 0;
	for(;;)
	{
		var_0D = 0;
		var_0E = var_0D && !var_0A;
		var_0A = var_0D;
		if(!var_09 && var_0E && var_08 > 0)
		{
			var_09 = 1;
		}

		if(var_09 && !var_0D)
		{
			var_09 = 0;
		}

		if(var_09)
		{
			var_08 = var_08 - 0.05 / var_00;
		}
		else
		{
			var_08 = var_08 + 0.05 / var_01;
		}

		if(var_08 < 0)
		{
			var_09 = 0;
		}

		var_08 = clamp(var_08,0,1);
		if(var_09)
		{
			var_0F = maps\_shg_utility::linear_map_clamp(self vehicle_getspeed(),15,65,3,1);
			self.boost_timer = self.boost_timer + 0.05;
			var_0B = var_0B + 0.05 / var_03;
			self vehicle_jetbikesetthrustscale(var_0F);
			self vehicle_jetbikesethoverforcescale(0.75);
		}
		else
		{
			self.boost_timer = 0;
			var_0B = var_0B - 0.05 / var_04;
			self vehicle_jetbikesetthrustscale(1);
			self vehicle_jetbikesethoverforcescale(1);
		}

		if(level.player getnormalizedmovement()[0] > 0.75)
		{
			var_0C = var_0C + 0.05 / var_06;
		}
		else
		{
			var_0C = var_0C - 0.05 / var_07;
		}

		var_0B = clamp(var_0B,0,1);
		var_0C = clamp(var_0C,0,1);
		var_10 = self vehicle_getspeed() + var_0B * var_02 + var_0C * var_05;
		vehicle_set_fake_speed(var_10);
		wait(0.05);
	}
}

//Function Number: 14
vehicle_set_fake_speed(param_00)
{
	if(param_00 == 0)
	{
		self.fakespeed = undefined;
	}
	else
	{
		self.fakespeed = param_00;
	}

	if(isdefined(self.blend_out_fake_speed_start_ms))
	{
		var_01 = gettime() - self.blend_out_fake_speed_start_ms;
		var_02 = maps\_shg_utility::linear_map_clamp(var_01,0,self.blend_out_fake_speed_blend_ms,1,0.0001);
	}
	else
	{
		var_02 = 1;
	}

	self vehicle_setfakespeed(param_00 * var_02);
}

//Function Number: 15
jetbike_handle_viewmodel_anims()
{
	self endon("death");
	self endon("stop_jetbike_handle_viewmodel_anims");
	var_00 = 0.6;
	var_01 = 0;
	var_02 = 0.5;
	var_03 = 0.7;
	var_04 = 0.8;
	var_05 = 0.1;
	var_06 = 0.4;
	var_07 = 0.1;
	var_08 = 0;
	var_09 = 0.35;
	var_0A = 0.3;
	var_0B = getanimlength(level.scr_anim["frankenbike_worldbody"]["jump_end"]) - var_0A;
	var_0C = 0;
	var_0D = 0;
	var_0E = 0;
	var_0F = 0;
	var_10 = 0;
	var_11 = 0;
	var_12 = 0;
	var_13 = 0;
	var_14 = 0;
	var_15 = 0;
	var_16 = 0;
	for(;;)
	{
		waittillframeend;
		var_17 = 0 - level.player getnormalizedcameramovements()[1] * 1.007936;
		var_13 = maps\_utility::linear_interpolate(var_03,var_17,var_13);
		var_18 = var_13 - var_14 * 20;
		var_14 = var_13;
		var_15 = maps\_utility::linear_interpolate(var_04,var_18,var_15);
		var_19 = clamp(var_13 - var_15 * var_01,-1,1);
		var_1A = self vehicle_getspeed();
		if(isdefined(self.fakespeed))
		{
			var_1A = self.fakespeed;
		}

		var_1B = maps\_shg_utility::linear_map_clamp(var_1A,15,80,0,1);
		var_1C = clamp(level.player getnormalizedmovement()[0] * 1.007936,0,1);
		var_16 = maps\_utility::linear_interpolate(var_02,var_1C,var_16);
		var_1D = var_16;
		var_1E = clamp(1 - max(var_1B,var_1D),0,1);
		var_1F = var_1B;
		var_20 = self vehicle_jetbikegettotalrepulsorfraction() > 1.7;
		var_21 = self vehicle_jetbikegettotalrepulsorfraction() < 0.7;
		var_22 = 0;
		var_23 = 0;
		if(var_21)
		{
			var_0D = var_0D + 0.05;
			var_0E = 0;
		}
		else
		{
			var_0D = 0;
			var_0E = var_0E + 0.05;
		}

		if(var_20)
		{
			var_0C = var_0C + 0.05;
		}
		else
		{
			var_0C = 0;
		}

		if(!var_10 && !var_11 && var_0C > var_05)
		{
			soundscripts\_snd::snd_message("jetbike_hit_ramp");
			var_10 = 1;
			var_22 = 1;
		}

		if(!var_10 && !var_11 && !var_20 && var_0D > var_09)
		{
			soundscripts\_snd::snd_message("jetbike_hit_cliff");
			var_10 = 1;
			var_23 = 1;
			var_0F = var_06;
		}

		if(var_10 && var_0F > var_06 && var_0C > var_08)
		{
			soundscripts\_snd::snd_message("jetbike_hit_landing");
			var_10 = 0;
			var_11 = 1;
		}

		if(var_10 && var_0F > var_06 && var_0E > var_07)
		{
			soundscripts\_snd::snd_message("jetbike_soft_landing");
			var_10 = 0;
		}

		if(var_12 > var_0B)
		{
			soundscripts\_snd::snd_message("jetbike_landing_finished");
			var_11 = 0;
		}

		if(var_10)
		{
			var_0F = var_0F + 0.05;
		}
		else
		{
			var_0F = 0;
		}

		if(var_11)
		{
			var_12 = var_12 + 0.05;
		}
		else
		{
			var_12 = 0;
		}

		if(isdefined(self.blend_out_fake_speed_start_ms))
		{
			var_24 = gettime() - self.blend_out_fake_speed_start_ms;
			var_25 = maps\_shg_utility::linear_map_clamp(var_24,0,self.blend_out_fake_speed_blend_ms,1,0);
			var_10 = 0;
			var_22 = 0;
			var_23 = 0;
			var_11 = 0;
			var_1E = maps\_utility::linear_interpolate(var_25,0,var_1E);
			var_26 = maps\_utility::linear_interpolate(var_25,0,var_19);
			var_1F = maps\_utility::linear_interpolate(var_25,1,var_1F);
			var_0A = 0;
		}

		jetbike_set_viewmodel_state(var_10,var_22,var_23,var_11,var_1E,var_19,var_1F,var_0A);
		wait(0.05);
	}
}

//Function Number: 16
stop_jetbike_handle_viewmodel_anims()
{
	self notify("stop_jetbike_handle_viewmodel_anims");
	foreach(var_01 in ["frankenbike_jetbike","frankenbike_worldbody"])
	{
		self clearanim(level.scr_anim[var_01]["branch"],0.2);
	}
}

//Function Number: 17
getanimtimeseconds(param_00)
{
	return self getanimtime(param_00) * getanimlength(param_00);
}

//Function Number: 18
getanimtimeremainingseconds(param_00)
{
	return 1 - self getanimtime(param_00) * getanimlength(param_00);
}

//Function Number: 19
jetbike_set_viewmodel_state(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = 0.2;
	var_09 = 0.2;
	var_0A = 1;
	var_0B = 0.2;
	var_0C = 0.05;
	var_0D = clamp(param_05,0,1);
	var_0E = clamp(0 - param_05,0,1);
	var_0F = clamp(1 - abs(param_05),0,1);
	foreach(var_11 in ["frankenbike_jetbike","frankenbike_worldbody"])
	{
		self setanimlimited(level.scr_anim[var_11]["idle_slow_branch"],param_04,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast_branch"],1 - param_04,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_slow"],var_0F,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_slow_lt"],var_0D,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_slow_rt"],var_0E,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast_throttle"],1 - param_06,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast_direction_branch"],param_06,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast"],var_0F,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast_lt"],var_0D,var_0C);
		self setanimlimited(level.scr_anim[var_11]["idle_fast_rt"],var_0E,var_0C);
		if(param_00)
		{
			if(param_01)
			{
				self setanimknob(level.scr_anim[var_11]["jump_st"],1,var_08);
			}
			else if(param_02)
			{
				self setanimknob(level.scr_anim[var_11]["jump_loop"],1,var_0A);
			}
			else if(getanimtimeremainingseconds(level.scr_anim[var_11]["jump_st"]) < var_09)
			{
				self setanimknob(level.scr_anim[var_11]["jump_loop"],1,var_09);
			}

			continue;
		}

		if(param_03)
		{
			self setanimknob(level.scr_anim[var_11]["jump_end"],1,var_0B);
			continue;
		}

		self setanimknob(level.scr_anim[var_11]["idle_branch"],1,param_07);
	}
}

//Function Number: 20
debug_tags()
{
	for(;;)
	{
		if(self gettagindex("tag_camera") != -1)
		{
		}

		wait 0.05;
	}
}

//Function Number: 21
jetbike_dismount_riding_player()
{
	jetbike_stop_hovering();
	wait(1);
	self setmodel("vehicle_mil_hoverbike_ai");
	var_00 = 0.5;
	level.player lerpfov(65,var_00);
	var_01 = level.player common_scripts\utility::spawn_tag_origin();
	level.player playerlinkto(var_01);
	var_01 moveto(self gettagorigin("tag_detach"),var_00);
	wait(var_00);
	level.player unlink();
	level.player enableweapons();
	level.player allowcrouch(1);
	self makeunusable();
}

//Function Number: 22
jetbike_start_hovering()
{
	maps\_utility::ent_flag_set("jetbike_is_hovering");
	self vehicle_jetbikesethoverforcescale(0.6,0);
	self vehicle_jetbikesethoverforcescale(1,1.5);
	wait(1);
}

//Function Number: 23
jetbike_start_hovering_now()
{
	maps\_utility::ent_flag_set("jetbike_is_hovering");
	self vehicle_jetbikesethoverforcescale(1);
}

//Function Number: 24
jetbike_stop_hovering()
{
	maps\_utility::ent_flag_clear("jetbike_is_hovering");
	self vehicle_jetbikesethoverforcescale(0,5);
}

//Function Number: 25
jetbike_stop_hovering_now()
{
	maps\_utility::ent_flag_clear("jetbike_is_hovering");
	self vehicle_jetbikesethoverforcescale(0);
}

//Function Number: 26
jetbike_player_think()
{
	thread jetbike_handle_viewmodel_anims();
	thread jetbike_handle_fake_speed();
	self.saved_bg_viewbobmax = getdvarfloat("bg_viewBobMax");
	setsaveddvar("bg_viewBobMax",0);
	thread vehicle_handle_debugfly();
	thread collision_watcher();
}

//Function Number: 27
jetbike_stop_player_think()
{
	self notify("player_dismount");
	setsaveddvar("bg_viewBobMax",self.saved_bg_viewbobmax);
}

//Function Number: 28
jetbike_npc_load(param_00,param_01)
{
	param_01 vehicle_jetbikesethoverforcescale(0);
	maps\_utility::guy_runtovehicle_load(param_00,param_01);
	var_02 = 1;
	param_01 vehicle_jetbikesethoverforcescale(0.75);
	param_01 vehicle_jetbikesethoverforcescale(1,var_02);
	maps\_utility::ent_flag_set("jetbike_is_hovering");
	wait(var_02);
	param_01 thread stop_hovering_on_unload();
}

//Function Number: 29
notify_wrapper(param_00)
{
	self notify(param_00);
}

//Function Number: 30
stop_hovering_on_unload()
{
	self endon("death");
	self waittill("unloading");
	self vehicle_jetbikesethoverforcescale(0,2);
	maps\_utility::ent_flag_clear("jetbike_is_hovering");
}

//Function Number: 31
init_local()
{
	maps\_utility::ent_flag_init("jetbike_is_hovering");
	thread jetbike_audio();
	thread jetbike_tread_fx();
	thread jetbike_thrust_fx();
}

//Function Number: 32
jetbike_audio()
{
	self endon("death");
	var_00 = spawnstruct();
	var_00.player_mode = 0;
	var_00.preset_name = "jetbike";
	var_01 = ::vehicle_scripts\_jetbike_aud::jetbike_constructor;
	if(issubstr(self.classname,"jetbike_rail") || issubstr(self.classname,"jetbike_player"))
	{
		var_00.player_mode = 1;
	}

	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	var_02 = 3;
	var_03 = 0;
	for(;;)
	{
		maps\_utility::ent_flag_wait("jetbike_is_hovering");
		soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
		maps\_utility::ent_flag_waitopen("jetbike_is_hovering");
		soundscripts\_snd::snd_message("snd_stop_vehicle",var_02,var_03);
	}
}

//Function Number: 33
jetbike_tread_fx()
{
	self endon("death");
	self notify("only_one_jetbike_tread_fx");
	self endon("only_one_jetbike_tread_fx");
	wait(randomfloat(0.3));
	for(;;)
	{
		maps\_utility::ent_flag_wait("jetbike_is_hovering");
		var_00 = self.origin + anglestoup(self.angles) * 32;
		var_01 = self.origin + anglestoup(self.angles) * -32;
		var_02 = bullettrace(var_00,var_01,0,self);
		if(var_02["fraction"] < 1 && var_02["fraction"] > 0)
		{
			var_03 = var_02["position"];
			var_04 = var_02["normal"];
			var_05 = anglestoforward(self.angles);
			var_06 = maps\_shg_utility::get_differentiated_speed() / 17.6;
			switch(var_02["surfacetype"])
			{
				case "water_waist":
					if(var_06 < 1)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_water_idle"),var_03,var_04,var_05);
					}
					else if(var_06 < 25)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_water_slow"),var_03,var_04,var_05);
					}
					else
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_water_fast"),var_03,var_04,var_05);
					}
					break;
	
				case "asphalt_wet":
					if(var_06 < 1)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_idle"),var_03,var_04,var_05);
					}
					else if(var_06 < 20)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_slow"),var_03,var_04,var_05);
					}
					else
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_fast"),var_03,var_04,var_05);
					}
					break;
	
				default:
					if(var_06 < 1)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_idle"),var_03,var_04,var_05);
					}
					else if(var_06 < 20)
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_slow"),var_03,var_04,var_05);
					}
					else
					{
						playfx(common_scripts\utility::getfx("hoverbike_tread_asphalt_fast"),var_03,var_04,var_05);
					}
					break;
			}
		}

		if(maps\_vehicle_code::tread_wait() <= 0)
		{
			wait(0.1);
		}
	}
}

//Function Number: 34
jetbike_thrust_fx()
{
	thread jetbike_thrust_fx_internal("hoverbike_pads_","tag_pad_br");
	thread jetbike_thrust_fx_internal("hoverbike_pads_","tag_pad_fr");
	thread jetbike_thrust_fx_internal("hoverbike_pads_","tag_pad_fl");
	thread jetbike_thrust_fx_internal("hoverbike_exhaust_","tag_exhaust");
}

//Function Number: 35
jetbike_thrust_fx_internal(param_00,param_01)
{
	self endon("death");
	wait(randomfloat(0.3));
	var_02 = undefined;
	var_03 = undefined;
	for(;;)
	{
		var_04 = undefined;
		if(maps\_utility::ent_flag("jetbike_is_hovering"))
		{
			var_05 = maps\_shg_utility::get_differentiated_speed() / 17.6;
			if(var_05 > 20)
			{
				var_04 = "fast";
			}
			else if(var_05 > 1)
			{
				var_04 = "slow";
			}
			else
			{
				var_04 = "idle";
			}
		}

		if(!isdefined(var_04) || isdefined(var_03) && var_03 != var_04)
		{
			if(isdefined(var_02))
			{
				maps\_shg_utility::kill_fx_with_handle(var_02);
				var_02 = undefined;
			}

			var_03 = undefined;
		}

		if(isdefined(var_04) && !isdefined(var_03))
		{
			var_02 = maps\_shg_utility::play_fx_with_handle(param_00 + var_04,self,param_01,1);
			var_03 = var_04;
		}

		if(!isdefined(var_03) && !maps\_utility::ent_flag("jetbike_is_hovering"))
		{
			maps\_utility::ent_flag_wait("jetbike_is_hovering");
		}

		wait(0.05);
	}
}

//Function Number: 36
setanims_slow()
{
	return setanims(1);
}

//Function Number: 37
setanims(param_00)
{
	var_01[0] = spawnstruct();
	var_01[0].sittag = "tag_driver";
	var_01[0].getin = %hoverbike_mount_driver_dir1;
	var_01[0].getout = %hoverbike_dismount_driver;
	if(isdefined(param_00) && param_00)
	{
		var_01[0].idle = %hoverbike_driving_idle_guy1;
	}
	else
	{
		var_01[0].idle = %hoverbike_driving_idle_npc;
	}

	var_01[0].aianim_simple["hoverbike_driving_flashlight_left_1"] = %hoverbike_driving_flashlight_left_guy1;
	var_01[0].aianim_simple["hoverbike_driving_flashlight_left_2"] = %hoverbike_driving_flashlight_left_guy2;
	var_01[0].aianim_simple["hoverbike_driving_flashlight_right_1"] = %hoverbike_driving_flashlight_right_guy1;
	var_01[0].aianim_simple["hoverbike_driving_flashlight_right_2"] = %hoverbike_driving_flashlight_right_guy2;
	var_01[0].aianim_simple["hoverbike_driving_gesture_lft_1"] = %hoverbike_driving_gesture_lft_guy1;
	var_01[0].aianim_simple["hoverbike_driving_gesture_lft_2"] = %hoverbike_driving_gesture_lft_guy2;
	var_01[0].aianim_simple["hoverbike_driving_gesture_rt_1"] = %hoverbike_driving_gesture_rt_guy1;
	var_01[0].aianim_simple["hoverbike_driving_gesture_rt_2"] = %hoverbike_driving_gesture_rt_guy2;
	var_01[0].aianim_simple["hoverbike_driving_idle_1"] = %hoverbike_driving_idle_guy1;
	var_01[0].aianim_simple["hoverbike_driving_idle_2"] = %hoverbike_driving_idle_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_idle_1"] = %hoverbike_driving_lean_left_idle_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_idle_2"] = %hoverbike_driving_lean_left_idle_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_into_1"] = %hoverbike_driving_lean_left_into_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_into_2"] = %hoverbike_driving_lean_left_into_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_out_1"] = %hoverbike_driving_lean_left_out_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_left_out_2"] = %hoverbike_driving_lean_left_out_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_idle_1"] = %hoverbike_driving_lean_right_idle_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_idle_2"] = %hoverbike_driving_lean_right_idle_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_into_1"] = %hoverbike_driving_lean_right_into_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_into_2"] = %hoverbike_driving_lean_right_into_guy2;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_out_1"] = %hoverbike_driving_lean_right_out_guy1;
	var_01[0].aianim_simple["hoverbike_driving_lean_right_out_2"] = %hoverbike_driving_lean_right_out_guy2;
	var_01[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_1"] = %hoverbike_driving_look_over_lft_shoulder_guy1;
	var_01[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_2"] = %hoverbike_driving_look_over_lft_shoulder_guy2;
	var_01[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_1"] = %hoverbike_driving_look_over_rt_shoulder_guy1;
	var_01[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_2"] = %hoverbike_driving_look_over_rt_shoulder_guy2;
	return var_01;
}

//Function Number: 38
set_vehicle_anims_slow(param_00)
{
	return set_vehicle_anims(param_00,1);
}

//Function Number: 39
set_vehicle_anims(param_00,param_01)
{
	if(isdefined(param_01) && param_01)
	{
		param_00[0].vehicle_idle = %hoverbike_driving_idle_vehicle1;
	}
	else
	{
		param_00[0].vehicle_idle = %hoverbike_driving_idle_vehicle;
	}

	param_00[0].aianim_simple_vehicle["hoverbike_driving_flashlight_left_1"] = %hoverbike_driving_flashlight_left_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_flashlight_left_2"] = %hoverbike_driving_flashlight_left_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_flashlight_right_1"] = %hoverbike_driving_flashlight_right_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_flashlight_right_2"] = %hoverbike_driving_flashlight_right_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_gesture_lft_1"] = %hoverbike_driving_gesture_lft_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_gesture_lft_2"] = %hoverbike_driving_gesture_lft_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_gesture_rt_1"] = %hoverbike_driving_gesture_rt_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_gesture_rt_2"] = %hoverbike_driving_gesture_rt_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_idle_1"] = %hoverbike_driving_idle_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_idle_2"] = %hoverbike_driving_idle_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_idle_1"] = %hoverbike_driving_lean_left_idle_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_idle_2"] = %hoverbike_driving_lean_left_idle_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_into_1"] = %hoverbike_driving_lean_left_into_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_into_2"] = %hoverbike_driving_lean_left_into_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_out_1"] = %hoverbike_driving_lean_left_out_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_left_out_2"] = %hoverbike_driving_lean_left_out_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_idle_1"] = %hoverbike_driving_lean_right_idle_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_idle_2"] = %hoverbike_driving_lean_right_idle_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_into_1"] = %hoverbike_driving_lean_right_into_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_into_2"] = %hoverbike_driving_lean_right_into_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_out_1"] = %hoverbike_driving_lean_right_out_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_lean_right_out_2"] = %hoverbike_driving_lean_right_out_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_look_over_lft_shoulder_1"] = %hoverbike_driving_look_over_lft_shoulder_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_look_over_lft_shoulder_2"] = %hoverbike_driving_look_over_lft_shoulder_vehicle2;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_look_over_rt_shoulder_1"] = %hoverbike_driving_look_over_rt_shoulder_vehicle1;
	param_00[0].aianim_simple_vehicle["hoverbike_driving_look_over_rt_shoulder_2"] = %hoverbike_driving_look_over_rt_shoulder_vehicle2;
	return param_00;
}

//Function Number: 40
setup_worldhands_anims()
{
	level.scr_anim["world_body"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vm;
	level.scr_anim["world_body"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
	level.scr_anim["world_body"]["mount_jetbike"] = %det_exfil_droponbike_drop_vm;
	maps\_anim::addnotetrack_customfunction("world_body","bike_swap",::level_jetbike_to_vm_model,"mount_jetbike");
	maps\_anim::addnotetrack_notify("world_body","fov_start","exit_drive_FOV_start","mount_jetbike");
	maps\_anim::addnotetrack_notify("world_body","fov_end","exit_drive_FOV_end","mount_jetbike");
	maps\_anim::addnotetrack_notify("world_body","on_button","exit_drive_on_button_pressed","mount_jetbike");
}

//Function Number: 41
setup_player_driving_anims()
{
	level.scr_anim["frankenbike_jetbike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
	level.scr_anim["frankenbike_worldbody"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
	level.scr_anim["frankenbike_jetbike"]["branch"] = %hoverbike_vehicle_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_branch"] = %hoverbike_vehicle_idle_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_branch"] = %hoverbike_vehicle_idle_slow_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_slow"] = %hoverbike_drive_idle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_branch"] = %hoverbike_vehicle_idle_fast_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_direction_branch"] = %hoverbike_vehicle_idle_fast_direction_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_fast"] = %hoverbike_drive_fast_idle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_st"] = %hoverbike_drive_jump_st_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_loop"] = %hoverbike_drive_jump_loop_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_end"] = %hoverbike_drive_jump_end_vehicle;
	level.scr_anim["frankenbike_worldbody"]["branch"] = %hoverbike_vm_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_branch"] = %hoverbike_vm_idle_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_branch"] = %hoverbike_vm_idle_slow_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_slow"] = %hoverbike_drive_idle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_branch"] = %hoverbike_vm_idle_fast_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_direction_branch"] = %hoverbike_vm_idle_fast_direction_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_fast"] = %hoverbike_drive_fast_idle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_st"] = %hoverbike_drive_jump_st_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_loop"] = %hoverbike_drive_jump_loop_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_end"] = %hoverbike_drive_jump_end_vm;
	level.scr_anim["player_bike"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vehicle;
	level.scr_anim["player_bike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
	level.scr_anim["player_bike"]["mount_jetbike"] = %det_exfil_droponbike_drop_vmbike;
}

//Function Number: 42
vehicle_handle_debugfly()
{
}

//Function Number: 43
project_into_plane(param_00,param_01)
{
	param_01 = vectornormalize(param_01);
	return param_00 - param_01 * vectordot(param_01,param_00);
}

//Function Number: 44
collision_watcher()
{
	self endon("player_dismount");
	childthread contact_watcher();
	childthread accel_watcher();
	childthread stop_hovering_on_player_death();
}

//Function Number: 45
jetbike_collision_hit_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = length(param_04);
	var_07 = [];
	var_07["none"] = common_scripts\utility::getfx("car_contact_spark_sml");
	var_07["asphalt"] = common_scripts\utility::getfx("car_contact_asphalt_sml");
	var_07["concrete"] = common_scripts\utility::getfx("car_contact_concrete_sml");
	var_07["dirt"] = common_scripts\utility::getfx("car_contact_dirt_sml");
	var_07["water"] = common_scripts\utility::getfx("veh_collision_water");
	var_07["metal"] = common_scripts\utility::getfx("veh_collision_water");
	var_08 = [];
	var_08["none"] = common_scripts\utility::getfx("car_contact_spark_med");
	var_08["bark"] = common_scripts\utility::getfx("car_contact_spark_med");
	var_08["brick"] = common_scripts\utility::getfx("car_contact_spark_med");
	var_08["asphalt"] = common_scripts\utility::getfx("veh_collision_wet_asphalt");
	var_08["concrete"] = common_scripts\utility::getfx("car_contact_concrete_med");
	var_08["dirt"] = common_scripts\utility::getfx("car_contact_dirt_med");
	var_08["water"] = common_scripts\utility::getfx("veh_collision_water");
	var_08["metal"] = common_scripts\utility::getfx("veh_collision_water");
	var_09 = [];
	var_09["none"] = common_scripts\utility::getfx("car_contact_spark_lrg");
	var_09["bark"] = common_scripts\utility::getfx("car_contact_spark_lrg");
	var_09["brick"] = common_scripts\utility::getfx("car_contact_spark_lrg");
	var_09["asphalt"] = common_scripts\utility::getfx("veh_collision_wet_asphalt");
	var_09["concrete"] = common_scripts\utility::getfx("car_contact_concrete_lrg");
	var_09["dirt"] = common_scripts\utility::getfx("car_contact_dirt_lrg");
	var_09["water"] = common_scripts\utility::getfx("veh_collision_water");
	var_09["metal"] = common_scripts\utility::getfx("veh_collision_water");
	if(var_06 > 600)
	{
		if(isdefined(param_05) && isdefined(var_09[param_05]))
		{
			playfx(var_09[param_05],param_02);
		}
		else
		{
			playfx(common_scripts\utility::getfx("car_contact_spark_lrg"),param_02);
		}
	}

	if(var_06 > 300)
	{
		if(isdefined(param_05) && isdefined(var_08[param_05]))
		{
			playfx(var_08[param_05],param_02);
			return;
		}

		playfx(common_scripts\utility::getfx("veh_collision_wet_asphalt"),param_02);
		return;
	}

	if(var_06 > 100)
	{
		if(isdefined(param_05) && isdefined(var_07[param_05]))
		{
			playfx(var_07[param_05],param_02);
			return;
		}

		playfx(common_scripts\utility::getfx("car_contact_spark_sml"),param_02);
		return;
	}
}

//Function Number: 46
non_player_contact_watcher()
{
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01,var_02,var_03,var_04);
		jetbike_collision_hit_func(self,var_00,var_01,var_02,var_03,var_04);
	}
}

//Function Number: 47
contact_watcher()
{
	var_00 = 50;
	var_01 = 200;
	var_02 = 50;
	var_03 = 0.5;
	for(;;)
	{
		self waittill("veh_contact",var_04,var_05,var_06,var_07,var_08);
		var_09 = [];
		var_09["vehicle"] = self;
		var_09["hit_entity"] = var_04;
		var_09["pos"] = var_05;
		var_09["impulse"] = var_06;
		var_09["relativeVel"] = var_07;
		var_09["surface"] = var_08;
		soundscripts\_snd::snd_message("aud_impact_system_jetbike",var_09);
		var_0A = length(var_06);
		var_0B = length(project_into_plane(var_06,anglestoup(self.angles)));
		if(var_0B > var_00)
		{
		}

		if(var_0B > 100)
		{
			level.player playrumbleonentity("damage_heavy");
		}

		jetbike_collision_hit_func(self,var_04,var_05,var_06,var_07,var_08);
	}
}

//Function Number: 48
accel_watcher()
{
	var_00 = 4825;
	var_01 = 14475;
	for(;;)
	{
		wait 0.05;
		var_02 = project_into_plane(maps\_shg_utility::get_differentiated_acceleration(),anglestoup(self.angles));
		var_03 = project_into_plane(var_02,(0,0,1));
		var_04 = length(var_03);
		var_05 = maps\_shg_utility::linear_map_clamp(var_04,var_00,var_01,0,350);
		if(var_05 > 0)
		{
			if(var_05 > level.player.health)
			{
			}

			level.player dodamage(var_05,self.origin,self,level.player,"MOD_CRUSH");
		}
	}
}

//Function Number: 49
stop_hovering_on_player_death()
{
	level.player waittill("death");
	self vehicle_jetbikesethoverforcescale(0);
	maps\_utility::ent_flag_clear("jetbike_is_hovering");
}

//Function Number: 50
angles_clamp_180(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 51
angle_lerp(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 52
angles_lerp(param_00,param_01,param_02)
{
	return (angle_lerp(param_00[0],param_01[0],param_02),angle_lerp(param_00[1],param_01[1],param_02),angle_lerp(param_00[2],param_01[2],param_02));
}

//Function Number: 53
level_jetbike_to_vm_model(param_00)
{
	level.jetbike setmodel("vehicle_mil_hoverbike_vm");
}
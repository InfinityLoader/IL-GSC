/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _water.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 713 ms
 * Timestamp: 4/22/2024 2:24:58 AM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	precacheshellshock("underwater");
	level._effect["water_bubbles"] = loadfx("vfx/water/player_bubbles_underwater");
	level._effect["water_vm_gasping_breath"] = loadfx("vfx/water/underwater_bubble_vm_gasping_breath_lt");
	level._effect["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");
	level._effect["water_screen_plunge"] = loadfx("vfx/water/screen_fx_plunge");
	level._effect["water_screen_emerge"] = loadfx("vfx/water/screen_fx_emerge");
	level._effect["water_wake"] = loadfx("vfx/treadfx/body_wake_water");
	level._effect["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");
	level._effect["water_splash_enter"] = loadfx("vfx/water/body_splash");
	level._effect["water_wake_ai"] = loadfx("vfx/treadfx/body_wake_water");
	level._effect["water_wake_stationary_ai"] = loadfx("vfx/treadfx/body_wake_water_stationary");
	level._effect["water_splash_enter_ai"] = loadfx("vfx/water/body_splash");
	var_01 = getentarray("trigger_underwater","targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread watchplayerenterwater();
		level thread water_trigger_register(var_03);
	}

	level.dofunderwater = [];
	level.dofunderwater["nearStart"] = 0;
	level.dofunderwater["nearEnd"] = 1;
	level.dofunderwater["farStart"] = 30;
	level.dofunderwater["farEnd"] = 210;
	level.dofunderwater["nearBlur"] = 4;
	level.dofunderwater["farBlur"] = 4;
	level.underwater_visionset_callback = ::water_default_vision_set_enabled;
	level.underwater_sound_ent = spawn("script_origin",level.player.origin);
	maps\_swim_player::init_player_swim(param_00);
	setdvarifuninitialized("underwater_walk_speed_scale_ai",0.6);
	setdvarifuninitialized("underwater_wading_speed_factor",1);
}

//Function Number: 2
water_trigger_register(param_00)
{
	if(!isdefined(level.underwatertriggers))
	{
		level.underwatertriggers = [param_00];
		return;
	}

	level.underwatertriggers[level.underwatertriggers.size] = param_00;
}

//Function Number: 3
disable_swim_or_underwater_walk()
{
	if(isdefined(self.swimming))
	{
		maps\_swim_player::disable_player_swim();
		return;
	}

	if(isdefined(self.underwater_walk))
	{
		maps\_swim_player::disable_player_underwater_walk();
	}
}

//Function Number: 4
watchplayerenterwater()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(!isalive(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.inwater) || !var_00.inwater)
		{
			var_00.inwater = 1;
			if(!isdefined(var_00.water_trigger_current))
			{
				var_00 thread playerinwater(self);
			}
		}
	}
}

//Function Number: 5
water_depth_below(param_00)
{
	var_01 = level getwaterline(param_00);
	var_02 = (self.origin[0],self.origin[1],var_01 + 1);
	var_03 = var_02;
	if(isplayer(self))
	{
		var_03 = playerphysicstrace(var_02,var_02 - (0,0,1000),self);
	}
	else
	{
		var_03 = self aiphysicstrace(var_02,var_02 - (0,0,1000),15,60,1);
	}

	return var_02[2] - var_03[2] - 1;
}

//Function Number: 6
playerinwater(param_00)
{
	self notify("playerInWater");
	self endon("playerInWater");
	self endon("death");
	thread inwaterwake();
	thread playerwaterclearwait();
	if(isdefined(param_00))
	{
		self.water_trigger_current = param_00;
	}

	var_01 = water_depth_below(self.water_trigger_current);
	if(!isdefined(self.water_lastemerge))
	{
		self.water_lastemerge = 0;
	}

	if(!isdefined(self.ent_flag) || !isdefined(self.ent_flag["water_trigger_paused"]))
	{
		maps\_utility::ent_flag_init("water_trigger_paused");
	}

	for(;;)
	{
		maps\_utility::ent_flag_waitopen("water_trigger_paused");
		var_02 = 0;
		if(isdefined(param_00) && self istouching(param_00))
		{
			var_02 = 1;
		}
		else
		{
			foreach(var_04 in level.underwatertriggers)
			{
				if((!isdefined(param_00) || var_04 != param_00) && self istouching(var_04))
				{
					var_02 = 1;
					self.water_touching = var_02;
					param_00 = var_04;
					self.water_trigger_current = var_04;
					setsaveddvar("player_swimWaterSurface",getwaterline(param_00));
					break;
				}
			}
		}

		self.water_touching = var_02;
		var_06 = self.origin[2];
		if(isdefined(param_00))
		{
			var_06 = getwaterline(param_00);
		}

		if(var_02 && !isdefined(self.underwater) && !isabovewaterline(param_00) && gettime() - self.water_lastemerge > 700)
		{
			if(!isdefined(self.grapple) || !self.grapple["grappling"])
			{
				water_set_depth(1000);
				under_water_set(1,getwaterline(param_00));
			}
		}

		if(isdefined(self.underwater) && isabovewaterline(param_00) || !var_02)
		{
			water_set_depth(water_depth_below(param_00));
			under_water_set(0,getwaterline(param_00));
			var_07 = self getvelocity();
			self setvelocity((var_07[0],var_07[1],min(0,var_07[2])));
		}

		if(var_02 && !isdefined(self.underwater))
		{
			if(self isonground())
			{
				var_01 = level getwaterline(param_00) - self.origin[2];
			}
			else
			{
				var_01 = water_depth_below(param_00);
			}

			water_set_depth(var_01);
			if(isdefined(self.swimming))
			{
				var_08 = water_depth_state(self.water_depth);
				var_06 = getwaterline(param_00);
				if(player_can_stop_swimming(var_06) && var_08 != "chest")
				{
					self.water_lastemerge = gettime();
					maps\_swim_player::disable_player_swim();
				}
			}
		}

		if(!var_02 && self ismantling() || player_can_stop_swimming(var_06))
		{
			self.inwater = undefined;
			self.water_trigger_current = undefined;
			self.water_touching = undefined;
			if(!isdefined(self.underwater) && water_depth_state(self.water_depth) != "puddle")
			{
				self playlocalsound("underwater_exit");
			}

			water_set_depth(0);
			under_water_set(0);
			disable_swim_or_underwater_walk();
			self notify("out_of_water");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 7
under_water_set(param_00,param_01)
{
	if(param_00 && !isdefined(self.underwater) || !self.underwater)
	{
		self.underwater = 1;
		thread playerunderwater();
		water_vision_set_enabled(1);
		if(!isdefined(self.mechdata) || !self.mechdata.active)
		{
			maps\_swim_player::enable_player_swim(0,0,param_01);
			return;
		}

		maps\_swim_player::enable_player_underwater_walk(0,0,param_01);
		return;
	}

	if(!param_00 && isdefined(self.underwater) && self.underwater)
	{
		self.underwater = undefined;
		self.water_lastemerge = gettime();
		self notify("above_water");
		water_vision_set_enabled(0);
		if(isdefined(self.swimming))
		{
			if(player_can_stop_swimming(param_01))
			{
				maps\_swim_player::disable_player_swim();
			}
			else
			{
				maps\_swim_player::player_set_swimming("surface",0,0,param_01);
			}
		}
		else if(isdefined(self.underwater_walk))
		{
			if(self isonground() || !isdefined(param_01) || !player_in_deep_water())
			{
				maps\_swim_player::disable_player_underwater_walk();
			}
		}

		self stopshellshock();
	}
}

//Function Number: 8
player_in_deep_water()
{
	return isdefined(self.water_depth) && water_depth_state(self.water_depth) == "deep";
}

//Function Number: 9
player_can_stop_swimming(param_00)
{
	if(!isdefined(self.swimming))
	{
		return 1;
	}

	if(!isdefined(self.water_touching) || !self.water_touching || self isonground() || !isdefined(param_00) || !player_in_deep_water())
	{
		var_01 = self.origin + (0,0,-1);
		var_02 = playerphysicstrace(var_01,self.origin);
		if(distancesquared(var_02,self.origin) < 0.001)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
water_vision_set_enabled(param_00)
{
	[[ level.underwater_visionset_callback ]](param_00);
}

//Function Number: 11
water_default_vision_set_enabled(param_00)
{
	if(param_00)
	{
		var_01 = 1;
		var_02 = "generic_underwater";
		if(isdefined(level.visionset_underwater))
		{
			var_02 = level.visionset_underwater;
		}

		self setclienttriggervisionset(var_02,var_01);
		self visionsetnakedforplayer(var_02,var_01);
		maps\_utility::vision_set_fog_changes(var_02,var_01);
		if(isdefined(level.clut_underwater))
		{
			self setclutforplayer(level.clut_underwater,0);
		}

		if(isdefined(level.underwater_lightset))
		{
			set_light_set_for_player(level.underwater_lightset);
		}

		if(isdefined(level.dofunderwater))
		{
			thread setdof(level.dofunderwater);
		}

		playfx(common_scripts\utility::getfx("water_screen_plunge"),self.origin);
		self setwatersheeting(0);
		setunderwateraudiozone();
		self playlocalsound("underwater_enter");
		return;
	}

	revertvisionsetforplayer(0);
	if(isdefined(level.lightset_previous))
	{
		set_light_set_for_player(level.lightset_previous);
	}

	if(isdefined(level.clut_previous))
	{
		self setclutforplayer(level.clut_previous,1);
	}

	if(isdefined(level.dofdefault))
	{
		thread setdof(level.dofdefault);
	}

	playfx(common_scripts\utility::getfx("water_screen_emerge"),self.origin);
	self setwatersheeting(1,1);
	clearunderwateraudiozone();
	self playlocalsound("breathing_better");
	self playlocalsound("underwater_exit");
	var_03 = undefined;
	if(isdefined(self.water_trigger_current))
	{
		var_03 = getwaterline(self.water_trigger_current);
	}

	if(isdefined(var_03))
	{
		var_04 = (self.origin[0],self.origin[1],var_03);
		playfx(level._effect["water_splash_emerge"],var_04,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}
}

//Function Number: 12
water_set_depth(param_00)
{
	var_01 = water_depth_state(param_00);
	var_02 = "none";
	if(isdefined(self.water_depth))
	{
		var_02 = water_depth_state(self.water_depth);
	}

	if(param_00 > 0)
	{
		self.water_depth = param_00;
	}
	else
	{
		self.water_depth = undefined;
	}

	if(isdefined(self.mechdata) && self.mechdata.active)
	{
		return;
	}

	if(var_02 != var_01)
	{
		switch(var_01)
		{
			case "puddle":
				thread wading_footsteps(0,1);
				water_set_control_options(1,1,1);
				thread aud_water_footsteps_override("");
				soundscripts\_audio_mix_manager::mm_add_submix("mute_footsteps");
				break;

			case "ankle":
				thread wading_footsteps(0.25,0.75,"_ankle");
				thread aud_water_footsteps_override("_ankle");
				soundscripts\_audio_mix_manager::mm_add_submix("mute_footsteps");
				water_set_control_options(1,0,0);
				break;

			case "knee":
				thread wading_footsteps(0.6,0.55,"_knee");
				thread aud_water_footsteps_override("_knee");
				soundscripts\_audio_mix_manager::mm_add_submix("mute_footsteps");
				water_set_control_options(1,0,1);
				break;

			case "thigh":
				thread wading_footsteps(1,0.45,"_waist");
				thread aud_water_footsteps_override("_waist");
				soundscripts\_audio_mix_manager::mm_add_submix("mute_footsteps");
				water_set_control_options(0,0,1);
				break;

			case "chest":
				thread wading_footsteps(0.5,0.33,"_waist");
				thread aud_water_footsteps_override("_waist");
				soundscripts\_audio_mix_manager::mm_add_submix("mute_footsteps");
				water_set_control_options(0,0,1);
				break;

			case "deep":
				thread wading_footsteps(0,1);
				water_set_control_options(0,1,1);
				break;

			default:
				thread wading_footsteps(0,1);
				self notify("override_footsteps");
				soundscripts\_audio_mix_manager::mm_clear_submix("mute_footsteps",0.2);
				water_set_control_options(1,1,1);
				break;
		}
	}
}

//Function Number: 13
water_set_control_options(param_00,param_01,param_02)
{
	if(param_00 && isdefined(level.water_allow_jump) && !level.water_allow_jump)
	{
		param_00 = 0;
	}

	if(param_01 && isdefined(level.water_allow_sprint) && !level.water_allow_sprint)
	{
		param_01 = 0;
	}

	if(param_02 && isdefined(level.water_allow_prone) && !level.water_allow_prone)
	{
		param_02 = 0;
	}

	self allowjump(param_00);
	self allowsprint(param_01);
	self allowprone(param_02);
}

//Function Number: 14
water_depth_state(param_00)
{
	if(!isdefined(param_00) || param_00 <= 0)
	{
		return "none";
	}

	if(param_00 <= 8)
	{
		return "puddle";
	}

	if(param_00 <= 20)
	{
		return "ankle";
	}

	if(param_00 <= 30)
	{
		return "knee";
	}

	if(param_00 <= 50)
	{
		return "thigh";
	}

	if(param_00 <= 60)
	{
		return "chest";
	}

	return "deep";
}

//Function Number: 15
wading_adjust_angles(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[2];
	var_03 = anglestoright(self.angles);
	var_04 = anglestoforward(self.angles);
	var_05 = (var_03[0],0,var_03[1] * -1);
	var_06 = (var_04[0],0,var_04[1] * -1);
	var_07 = var_06 * var_01;
	var_07 = var_07 + var_05 * var_02;
	return var_07 + (0,param_00[1],0);
}

//Function Number: 16
wading_footsteps(param_00,param_01,param_02)
{
	self endon("death");
	if(param_01 >= 1)
	{
		thread wading_footsteps_ends();
		return;
	}

	param_01 = param_01 * getdvarfloat("underwater_wading_speed_factor");
	var_03 = isdefined(self.water_wading_wobble_target);
	self.water_wading_wobble_target = param_00;
	self.water_wading_move_speed_target = param_01;
	self.water_wading_waterdepthtype = param_02;
	if(!isdefined(self.water_wading_wobble))
	{
		self.water_wading_wobble = 0;
		self.water_wading_move_speed = param_01;
	}

	if(var_03)
	{
		return;
	}

	self notify("wading_footsteps");
	self endon("wading_footsteps");
	if(!isdefined(self.water_ground_ref_ent))
	{
		self.water_ground_ref_ent = spawn("script_model",(0,0,0));
		self playersetgroundreferenceent(self.water_ground_ref_ent);
	}

	var_04 = 0;
	var_05 = 0.05;
	var_06 = 0;
	var_07 = 0;
	for(;;)
	{
		self.water_wading_wobble = self.water_wading_wobble + self.water_wading_wobble_target - self.water_wading_wobble * 0.1;
		self.water_wading_move_speed = self.water_wading_move_speed + self.water_wading_move_speed_target - self.water_wading_move_speed * 0.1;
		var_08 = 3 * self.water_wading_wobble;
		var_09 = 4 * self.water_wading_wobble;
		var_0A = 3 * self.water_wading_wobble;
		param_01 = self.water_wading_move_speed;
		if(!isdefined(self.movespeedscale) || self.movespeedscale == 0)
		{
			maps\_utility::blend_movespeedscale(param_01,0.25);
		}

		var_0B = distance((0,0,0),self getvelocity());
		var_0C = min(var_0B,200);
		if(var_0C == 0)
		{
			self.water_ground_ref_ent rotateto((0,0,0),0.25,0.125,0.125);
			var_04 = self.water_ground_ref_ent.angles[0];
		}
		else
		{
			var_04 = var_04 + var_0C * 0.3;
			if(cos(var_04) > 0)
			{
				var_04 = var_04 + var_0C * 0.1;
				if(!var_06)
				{
					var_06 = 1;
					maps\_utility::blend_movespeedscale(param_01,0.25);
				}
			}
			else if(var_06)
			{
				var_0D = "walk";
				if(self issprinting())
				{
					var_0D = "sprint";
				}
				else if(self getnormalizedmovement()[0] > 0.5)
				{
					var_0D = "run";
				}

				if(self getstance() != "stand")
				{
					var_0D = "crouch" + var_0D;
				}

				var_0E = "_r";
				if(var_07 < 0)
				{
					var_0E = "_l";
				}

				aud_water_footsteps_foley(var_0D,self.water_wading_waterdepthtype,var_0E);
				var_06 = 0;
				maps\_utility::blend_movespeedscale(max(0.2,param_01 * 0.75),0.15);
			}

			var_0F = sin(var_04) - 0.75 * var_08;
			var_10 = sin(var_04 * -0.5) * var_09;
			var_07 = sin(var_04 * 0.5) * var_0A;
			var_11 = wading_adjust_angles((var_0F,var_10,var_07));
			self.water_ground_ref_ent rotateto(var_11,var_05,var_05 * 0.5,var_05 * 0.5);
		}

		wait(0.05);
	}
}

//Function Number: 17
aud_water_footsteps_override(param_00)
{
	self endon("death");
	self notify("override_footsteps");
	self endon("override_footsteps");
	self playlocalsound("step_run_plr_water" + param_00 + "_l");
	for(;;)
	{
		level.player waittill("foley",var_01,var_02,var_03);
		if(isdefined(self.water_ground_ref_ent))
		{
			switch(var_01)
			{
				case "crouchwalk":
				case "crouchrun":
				case "run":
				case "sprint":
				case "walk":
					break;
			}
		}

		var_04 = "_r";
		if(var_03)
		{
			var_04 = "_l";
		}

		aud_water_footsteps_foley(var_01,param_00,var_04);
	}
}

//Function Number: 18
aud_water_footsteps_foley(param_00,param_01,param_02)
{
	var_03 = "_plr";
	if(!isplayer(self))
	{
		var_03 = "";
	}

	switch(param_00)
	{
		case "stationarycrouchscuff":
			aud_water_sound("step_scrape" + var_03 + "_water" + param_01);
			aud_water_sound("step_crchwalk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "stationaryscuff":
			aud_water_sound("step_scrape" + var_03 + "_water" + param_01);
			aud_water_sound("step_walk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "crouchscuff":
			aud_water_sound("step_scrape" + var_03 + "_water" + param_01);
			aud_water_sound("step_crchwalk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "runscuff":
			aud_water_sound("step_scrape" + var_03 + "_water" + param_01);
			aud_water_sound("step_run" + var_03 + "_water" + param_01 + param_02);
			break;

		case "sprintscuff":
			aud_water_sound("step_scrape" + var_03 + "_water" + param_01);
			aud_water_sound("step_sprint" + var_03 + "_water" + param_01 + param_02);
			break;

		case "prone":
			aud_water_sound("step_prone" + var_03 + "_water" + param_01 + param_02);
			break;

		case "crouchwalk":
			aud_water_sound("step_crchwalk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "crouchrun":
			aud_water_sound("step_crchwalk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "walk":
			aud_water_sound("step_walk" + var_03 + "_water" + param_01 + param_02);
			break;

		case "run":
			aud_water_sound("step_run" + var_03 + "_water" + param_01 + param_02);
			break;

		case "sprint":
			aud_water_sound("step_sprint" + var_03 + "_water" + param_01 + param_02);
			break;

		case "jump":
			aud_water_sound("step_jump" + var_03 + "_water" + param_01);
			break;

		case "lightland":
			aud_water_sound("step_land" + var_03 + "_lt_water" + param_01);
			break;

		case "mediumland":
			aud_water_sound("step_land" + var_03 + "_med_water" + param_01);
			break;

		case "heavyland":
			aud_water_sound("step_land" + var_03 + "_hv_water" + param_01);
			break;

		case "damageland":
			aud_water_sound("step_land" + var_03 + "_dmg_water" + param_01);
			break;

		default:
			break;
	}
}

//Function Number: 19
aud_water_sound(param_00)
{
	if(isplayer(self))
	{
		self playlocalsound(param_00);
		return;
	}

	self playsound(param_00);
}

//Function Number: 20
wading_footsteps_ends()
{
	self endon("death");
	self notify("wading_footsteps");
	self endon("wading_footsteps");
	self.water_wading_wobble_target = undefined;
	if(isdefined(self.water_ground_ref_ent))
	{
		var_00 = 0.25;
		self.water_ground_ref_ent rotateto((0,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
		maps\_utility::blend_movespeedscale(1,var_00);
		wait(var_00);
		if(isdefined(self.water_ground_ref_ent))
		{
			self.water_ground_ref_ent delete();
		}

		self.water_ground_ref_ent = undefined;
		self.water_wading_wobble = undefined;
		self.water_wading_move_speed_target = undefined;
		self.water_wading_move_speed = undefined;
		self.water_wading_waterdepthtype = undefined;
		self playersetgroundreferenceent(undefined);
		self notify("blend_movespeedscale");
		maps\_utility_code::movespeed_set_func(1);
	}
}

//Function Number: 21
setunderwateraudiozone()
{
	if(isdefined(level.aud) && isdefined(level.aud.water) && isdefined(level.aud.water.enter_water_override))
	{
		soundscripts\_snd::snd_message(level.aud.water.enter_water_override);
		return;
	}

	soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
	level.underwater_sound_ent = soundscripts\_snd_playsound::snd_play_loop_2d("underwater_bubbles_lp");
	soundscripts\_snd_filters::snd_set_filter("underwater",1,0);
	soundscripts\_audio_reverb::rvb_start_preset("underwater",1);
	level.player seteqlerp(1,1);
}

//Function Number: 22
clearunderwateraudiozone()
{
	if(isdefined(level.aud) && isdefined(level.aud.water) && isdefined(level.aud.water.exit_water_override))
	{
		soundscripts\_snd::snd_message(level.aud.water.exit_water_override);
		return;
	}

	var_00 = level._audio.zone_mgr.current_zone;
	soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
	level.underwater_sound_ent soundscripts\_snd_playsound::snd_stop_sound();
	if(isdefined(level._audio.zone_mgr.zones[var_00]))
	{
		var_01 = level._audio.zone_mgr.zones[var_00];
		var_02 = var_01["priority"];
		var_03 = var_01["interrupt_fade"];
		if(isdefined(var_01["filter"]))
		{
			if(var_01["filter"] != "none")
			{
				soundscripts\_snd_filters::snd_set_filter(var_01["filter"],0);
				soundscripts\_snd_filters::snd_set_filter_lerp(1);
			}
		}
		else
		{
			soundscripts\_snd_filters::snd_clear_filter(1);
			soundscripts\_audio_reverb::rvb_deactive_reverb();
		}

		if(isdefined(var_01["reverb"]))
		{
			if(var_01["reverb"] != "none")
			{
				soundscripts\_audio_reverb::rvb_start_preset(var_01["reverb"]);
			}
		}
		else
		{
			soundscripts\_snd_filters::snd_clear_filter(1);
			soundscripts\_audio_reverb::rvb_deactive_reverb();
		}
	}
	else
	{
		soundscripts\_snd_filters::snd_clear_filter(1);
		soundscripts\_audio_reverb::rvb_deactive_reverb();
	}

	level.player seteqlerp(1,0);
}

//Function Number: 23
override_deadquote()
{
	wait(0.5);
	if((!isdefined(level.player.failingmission) || level.player.failingmission == 0) && isdefined(level.player.is_drowning) && level.player.is_drowning)
	{
		maps\_player_death::set_deadquote(self.drowning_deadquote);
	}
}

//Function Number: 24
playerwaterclearwait()
{
	self endon("playerInWater");
	var_00 = common_scripts\utility::waittill_any_return("death","out_of_water");
	if(var_00 == "death")
	{
		if(isdefined(self.drowning_deadquote))
		{
			thread override_deadquote();
			return;
		}

		return;
	}

	self.inwater = undefined;
	self.water_trigger_current = undefined;
	under_water_set(0);
	water_set_depth(0);
	disable_swim_or_underwater_walk();
}

//Function Number: 25
inwaterwake()
{
	self endon("death");
	self endon("playerInWater");
	self endon("out_of_water");
	if(!isdefined(self.water_wake_speed))
	{
		self.water_wake_speed = 50;
	}

	var_00 = "";
	if(isai(self))
	{
		var_00 = "_ai";
	}

	var_01 = (0,0,0);
	if(isplayer(self))
	{
		var_01 = self getvelocity();
	}
	else
	{
		var_01 = anglestoforward(self.angles) * self.water_wake_speed;
	}

	var_02 = distance(var_01,(0,0,0));
	if(var_02 > 90 && isdefined(self.water_trigger_current))
	{
		var_03 = self.origin;
		var_03 = (var_03[0],var_03[1],getwaterline(self.water_trigger_current));
		var_03 = var_03 + (var_01[0],var_01[1],0) * 0.25;
		playfx(level._effect["water_splash_enter" + var_00],var_03,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}

	while(isdefined(self.water_trigger_current))
	{
		var_01 = (0,0,0);
		if(isplayer(self))
		{
			var_01 = self getvelocity();
		}
		else
		{
			var_01 = anglestoforward(self.angles) * self.water_wake_speed;
		}

		var_02 = distance(var_01,(0,0,0));
		if(var_02 > 0)
		{
			wait(max(1 - var_02 / 120,0.1));
		}
		else
		{
			wait(0.3);
		}

		var_03 = self.origin;
		if(var_02 > 5)
		{
			var_04 = vectornormalize((var_01[0],var_01[1],0));
			var_05 = anglestoforward(vectortoangles(var_04) + (270,180,0));
			var_03 = (var_03[0],var_03[1],getwaterline(self.water_trigger_current)) + var_02 / 4 * var_04;
			playfx(level._effect["water_wake" + var_00],var_03,var_05);
			continue;
		}

		var_03 = (var_03[0],var_03[1],getwaterline(self.water_trigger_current));
		playfx(level._effect["water_wake_stationary" + var_00],var_03,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}
}

//Function Number: 26
playerunderwater()
{
	self endon("death");
	self endon("above_water");
	childthread player_underwater_shock();
	thread underwaterbubbles();
	thread underwatercloudy();
}

//Function Number: 27
player_underwater_shock()
{
	for(;;)
	{
		self shellshock("underwater",60);
		wait(60);
	}
}

//Function Number: 28
onplayerdeath()
{
	self endon("above_water");
	self waittill("death");
	self.inwater = undefined;
	self.water_trigger_current = undefined;
	under_water_set(0);
	water_set_depth(0);
	disable_swim_or_underwater_walk();
}

//Function Number: 29
underwaterbubbles()
{
	self endon("death");
	self endon("above_water");
	var_00 = common_scripts\utility::spawn_tag_origin();
	waittillframeend;
	var_00 linktoplayerview(level.player,"tag_origin",(25,0,0),(0,0,0),0);
	thread delete_vm_underwater_org(var_00);
	for(;;)
	{
		if(self.underwater == 1)
		{
			playfxontag(common_scripts\utility::getfx("water_bubbles"),var_00,"tag_origin");
		}
		else
		{
			killfxontag(common_scripts\utility::getfx("water_bubbles"),var_00,"tag_origin");
		}

		wait(0.25);
	}
}

//Function Number: 30
delete_vm_underwater_org(param_00)
{
	common_scripts\utility::waittill_any("above_water","death");
	killfxontag(common_scripts\utility::getfx("water_bubbles"),param_00,"tag_origin");
	param_00 unlinkfromplayerview(level.player);
	wait 0.05;
	param_00 delete();
}

//Function Number: 31
underwatercloudy()
{
	if(isdefined(level.underwater_cloudy))
	{
		var_00 = common_scripts\utility::spawn_tag_origin();
		var_00.angles = (0,0,0);
		var_00.origin = level.player geteye() - (0,0,0);
		var_00 linktoplayerview(level.player,"tag_origin",(70,0,-1),(-90,0,0),0);
		playfxontag(common_scripts\utility::getfx(level.underwater_cloudy),var_00,"tag_origin");
		self waittill("above_water");
		killfxontag(common_scripts\utility::getfx(level.underwater_cloudy),var_00,"tag_origin");
		var_00 unlinkfromplayerview(level.player);
		var_00 delete();
	}
}

//Function Number: 32
isabovewaterline(param_00)
{
	if(getplayereyeheight() > level getwaterline(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
getplayereyeheight()
{
	var_00 = self geteye();
	return var_00[2];
}

//Function Number: 34
getwaterline(param_00)
{
	var_01 = 3;
	var_02 = maps\_utility::getent_or_struct(param_00.target,"targetname");
	var_03 = var_02.origin[2] + var_01;
	return var_03;
}

//Function Number: 35
setdof(param_00)
{
	self setdepthoffield(param_00["nearStart"],param_00["nearEnd"],param_00["farStart"],param_00["farEnd"],param_00["nearBlur"],param_00["farBlur"]);
}

//Function Number: 36
set_light_set_for_player(param_00)
{
	if(isdefined(level.lightset_current))
	{
		level.lightset_previous = level.lightset_current;
	}

	level.lightset_current = param_00;
	self lightsetforplayer(param_00);
}

//Function Number: 37
revertvisionsetforplayer(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(self.ridevisionset))
	{
		self setclienttriggervisionset(self.ridevisionset,param_00);
		self visionsetnakedforplayer(self.ridevisionset,param_00);
	}

	if(isdefined(level.visionset_default))
	{
		self setclienttriggervisionset(level.visionset_default,param_00);
		self visionsetnakedforplayer(level.visionset_default,param_00);
		maps\_utility::vision_set_fog_changes(level.visionset_default,param_00);
		return;
	}

	self setclienttriggervisionset("",param_00);
	self visionsetnakedforplayer("",param_00);
}

//Function Number: 38
watchaienterwater(param_00)
{
	param_00 notify("watchAIEnterWater");
	param_00 endon("watchAIEnterWater");
	param_00 endon("death");
	for(;;)
	{
		foreach(var_02 in level.underwatertriggers)
		{
			if((!isdefined(param_00.inwater) || !param_00.inwater) && param_00 istouching(var_02))
			{
				param_00.inwater = 1;
				if(!isdefined(param_00.water_trigger_current))
				{
					param_00 thread aiinwater(var_02);
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 39
aiinwater(param_00)
{
	self notify("aiInWater");
	self endon("aiInWater");
	self endon("death");
	if(isdefined(param_00))
	{
		self.water_trigger_current = param_00;
	}

	if(!isdefined(self.water_lastemerge))
	{
		self.water_lastemerge = 0;
	}

	if(!isdefined(self.ent_flag) || !isdefined(self.ent_flag["water_trigger_paused"]))
	{
		maps\_utility::ent_flag_init("water_trigger_paused");
	}

	if(!isdefined(self.mechdata) || !self.mechdata.active)
	{
		thread inwaterwake();
	}

	for(;;)
	{
		maps\_utility::ent_flag_waitopen("water_trigger_paused");
		var_01 = 0;
		if(isdefined(param_00) && self istouching(param_00))
		{
			var_01 = 1;
		}
		else
		{
			foreach(var_03 in level.underwatertriggers)
			{
				if((!isdefined(param_00) || var_03 != param_00) && self istouching(var_03))
				{
					var_01 = 1;
					param_00 = var_03;
					self.water_trigger_current = var_03;
					break;
				}
			}
		}

		if(var_01 && !isdefined(self.underwater) && !isabovewaterline(param_00) && gettime() - self.water_lastemerge > 700)
		{
			ai_enable_swim_or_underwater_walk();
		}

		if(isdefined(self.underwater) && isabovewaterline(param_00) || !var_01)
		{
			ai_disable_swim_or_underwater_walk();
			self.water_lastemerge = gettime();
		}

		if(isdefined(self.water_trigger_current) && var_01)
		{
			ai_water_set_depth(water_depth_below(self.water_trigger_current));
		}
		else
		{
			ai_water_set_depth(0);
		}

		if(!var_01)
		{
			self.inwater = undefined;
			self.water_trigger_current = undefined;
			ai_disable_swim_or_underwater_walk();
			self notify("out_of_water");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 40
ai_water_set_depth(param_00)
{
	var_01 = water_depth_state(param_00);
	var_02 = "none";
	if(isdefined(self.water_depth))
	{
		var_02 = water_depth_state(self.water_depth);
	}

	if(param_00 > 0)
	{
		self.water_depth = param_00;
	}
	else
	{
		self.water_depth = undefined;
	}

	if(isdefined(self.mechdata) && self.mechdata.active)
	{
		return;
	}

	if(var_02 != var_01)
	{
		switch(var_01)
		{
			case "ankle":
				thread ai_wading_footsteps("_ankle");
				break;

			case "knee":
				thread ai_wading_footsteps("_knee");
				break;

			case "thigh":
			case "chest":
				thread ai_wading_footsteps("_waist");
				break;

			case "deep":
			case "puddle":
			default:
				thread ai_wading_footsteps();
				break;
		}
	}
}

//Function Number: 41
ai_wading_footsteps(param_00)
{
	self notify("ai_wading_footsteps");
	self endon("ai_wading_footsteps");
	self endon("death");
	self.playfootstepoverride = undefined;
	if(isdefined(param_00))
	{
		self.playfootstepoverride = ::ai_water_footstep;
		self.water_foley_type = param_00;
	}
}

//Function Number: 42
ai_water_footstep(param_00,param_01)
{
	self notify("ai_water_footstep");
	self endon("ai_water_footstep");
	self endon("death");
	self.water_step = animscripts\notetracks::get_notetrack_movement();
	aud_water_footsteps_foley(self.water_step,self.water_foley_type,"");
	self.water_wake_speed = 100;
	if(self.water_step == "run")
	{
		self.water_wake_speed = 75;
	}
	else if(self.water_step == "walk")
	{
		self.water_wake_speed = 50;
	}

	wait(2);
	self.water_wake_speed = 0;
}

//Function Number: 43
get_underwater_walk_speed_scale_ai()
{
	var_00 = getdvarfloat("underwater_walk_speed_scale_ai");
	return var_00;
}

//Function Number: 44
ai_enable_swim_or_underwater_walk()
{
	self.underwater = 1;
	if(!isdefined(self.mech) || !self.mech)
	{
		self.swimming = 1;
	}
	else
	{
		self.underwater_walk = 1;
	}

	if(isdefined(self.swimming))
	{
		return;
	}

	if(isdefined(self.underwater_walk))
	{
		maps\_utility::set_moveplaybackrate(get_underwater_walk_speed_scale_ai(),undefined,1);
		maps\_utility::walkdist_force_walk();
	}
}

//Function Number: 45
ai_disable_swim_or_underwater_walk()
{
	self.underwater = 0;
	if(isdefined(self.swimming))
	{
		self.swimming = undefined;
		return;
	}

	if(isdefined(self.underwater_walk))
	{
		maps\_utility::walkdist_reset();
		maps\_utility::restore_moveplaybackrate(1,1);
		self.underwater_walk = undefined;
	}
}
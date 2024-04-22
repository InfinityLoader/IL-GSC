/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _swim_player.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 252 ms
 * Timestamp: 4/22/2024 2:23:25 AM
*******************************************************************/

//Function Number: 1
init_player_swim(param_00)
{
	if(isdefined(level.swim_arms_model))
	{
		return;
	}

	if(isdefined(param_00))
	{
		level.swim_arms_model = param_00;
	}
	else
	{
		level.swim_arms_model = "worldhands_atlas_pmc_smp";
	}

	level.swim_end_hide_viewarms = undefined;
	precachemodel(level.swim_arms_model);
	setdvar("underwater_aim_speed_scale",0.5);
	setdvar("underwater_walk_speed_scale",0.45);
	setdvar("underwater_gravity_scale",0.6);
	common_scripts\utility::flag_init("pause_dynamic_dof");
	common_scripts\utility::flag_init("player_swimming_drown");
}

//Function Number: 2
get_underwater_walk_speed_scale_default()
{
	return 0.45;
}

//Function Number: 3
enable_player_underwater_walk(param_00,param_01,param_02)
{
	player_set_swimming("underwater",param_00,param_01,param_02,1);
	self notify("kill_barrel_vfx");
}

//Function Number: 4
disable_player_underwater_walk(param_00,param_01,param_02)
{
	player_set_swimming("none",undefined,undefined,undefined,1);
}

//Function Number: 5
enable_player_swim(param_00,param_01,param_02)
{
	player_set_swimming("underwater",param_00,param_01,param_02);
}

//Function Number: 6
disable_player_swim()
{
	player_set_swimming("none");
}

//Function Number: 7
player_set_swimming(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	switch(param_00)
	{
		case "underwater":
			if(!param_04)
			{
				self.swimming = param_00;
				maps\_underwater::underwater_hud_enable(1);
				maps\_underwater::player_underwater_start(param_01);
			}
			else
			{
				self.underwater_walk = param_00;
			}
	
			if(!isdefined(param_02) || param_02)
			{
				thread player_dynamic_dof(250);
			}
	
			break;

		case "surface":
			if(!param_04)
			{
				self.swimming = param_00;
				setsaveddvar("cg_footsteps",0);
				setsaveddvar("cg_equipmentSounds",0);
				setsaveddvar("cg_landingSounds",0);
				thread viewmodel_swim_animations("swimming_end",0,param_00 == "surface");
				self allowswim(1);
				if(isdefined(param_03))
				{
					setsaveddvar("player_swimWaterSurfaceEnabled",1);
					setsaveddvar("player_swimWaterSurface",param_03);
				}
				else
				{
					setsaveddvar("player_swimWaterSurfaceEnabled",0);
					setsaveddvar("player_swimWaterSurface",0);
				}
			}
	
			var_05 = getdvarfloat("underwater_aim_speed_scale");
			self enableslowaim(var_05,var_05);
			if(!param_04)
			{
				level.water_current = (0,0,0);
				thread player_swimming_moving_water();
				self setstance("stand");
			}
			else
			{
				self setmovespeedscale(getdvarfloat("underwater_walk_speed_scale"));
				if(!isdefined(level.origgravity))
				{
					level.origgravity = self getgravity();
				}
	
				var_06 = getdvarfloat("underwater_gravity_scale") * level.origgravity;
				self setgravityoverride(int(var_06));
				if(!isdefined(level.origacceleration))
				{
					level.origacceleration = getdvarfloat("mechAcceleration");
				}
	
				if(100 != level.origacceleration)
				{
					if(isdefined(self.mechdata) && self.mechdata.active)
					{
						setsaveddvar("mechAcceleration",100);
					}
					else
					{
					}
				}
	
				if(!isdefined(level.origairacceleration))
				{
					level.origairacceleration = getdvarfloat("mechAirAcceleration",0.6);
				}
	
				if(0.1 != level.origairacceleration)
				{
					if(isdefined(self.mechdata) && self.mechdata.active)
					{
						setsaveddvar("mechAirAcceleration",0.1);
					}
					else
					{
					}
				}
	
				disable_fall_damage();
			}
			break;

		default:
			if(!param_04)
			{
				self.swimming = undefined;
				level notify("stop_player_swimming");
				setsaveddvar("cg_footsteps",1);
				setsaveddvar("cg_equipmentSounds",1);
				setsaveddvar("cg_landingSounds",1);
				setsaveddvar("player_swimWaterCurrent",(0,0,0));
				self notify("swimming_end");
				self allowswim(0);
			}
			else
			{
				self.underwater_walk = undefined;
				self setmovespeedscale(1);
				self enableslowaim(1,1);
				self resetgravityoverride();
				level.origgravity = undefined;
				setsaveddvar("mechAcceleration",level.origacceleration);
				level.origacceleration = undefined;
				setsaveddvar("mechAirAcceleration",level.origairacceleration);
				level.origairacceleration = undefined;
				enable_fall_damage();
			}
	
			self disableslowaim();
			level.water_current = (0,0,0);
			break;
	}

	if(param_00 != "underwater")
	{
		if(!param_04)
		{
			maps\_underwater::underwater_hud_enable(0);
			maps\_underwater::player_underwater_end();
		}

		self notify("stop_dynamic_dof");
	}
}

//Function Number: 8
disable_fall_damage()
{
	self.bg_falldamageminheight_orig = getdvarint("bg_fallDamageMinHeight");
	self.bg_falldamagemaxheight_orig = getdvarint("bg_fallDamageMaxHeight");
	setsaveddvar("bg_fallDamageMinHeight",2000);
	setsaveddvar("bg_fallDamageMaxHeight",3500);
}

//Function Number: 9
enable_fall_damage()
{
	setsaveddvar("bg_fallDamageMinHeight",self.bg_falldamageminheight_orig);
	setsaveddvar("bg_fallDamageMaxHeight",self.bg_falldamagemaxheight_orig);
}

//Function Number: 10
viewmodel_swim_handle_notetracks()
{
	for(;;)
	{
		self waittill("swim_notes",var_00);
		switch(var_00)
		{
			case "lagos_swimming_into_stroke":
			case "lagos_swimming_stroke":
				soundscripts\_snd_playsound::snd_play_2d("underwater_swim_stroke");
				break;
	
			case "lagos_swimming_drowning_start":
				soundscripts\_snd_playsound::snd_play_2d("underwater_drowning");
				break;
		}
	}
}

//Function Number: 11
viewmodel_swim_animations_loop(param_00,param_01,param_02)
{
	self endon("viewmodel_swim_animations");
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(!isdefined(param_00))
	{
		for(;;)
		{
			var_03 = self getnormalizedmovement();
			if(abs(var_03[0]) > 0.25 || abs(var_03[1]) > 0.25)
			{
				if(common_scripts\utility::cointoss())
				{
					soundscripts\_snd_playsound::snd_play_2d("step_walk_plr_water_knee_l");
				}
				else
				{
					soundscripts\_snd_playsound::snd_play_2d("step_walk_plr_water_knee_r");
				}

				wait(0.5);
			}

			wait(0.05);
		}
	}

	param_00 childthread viewmodel_swim_handle_notetracks();
	var_04 = %wm_unarmed_underwater_swim_idle_loop;
	if(isdefined(level.swim_anim_idle_loop))
	{
		var_04 = level.swim_anim_idle_loop;
	}

	var_05 = %wm_unarmed_underwater_swim_loop_into;
	if(isdefined(level.swim_anim_loop_into))
	{
		var_05 = level.swim_anim_loop_into;
	}

	var_06 = %wm_unarmed_underwater_swim_loop;
	if(isdefined(level.swim_anim_loop))
	{
		var_06 = level.swim_anim_loop;
	}

	var_07 = %wm_unarmed_underwater_swim_drown;
	if(isdefined(level.swim_anim_drown))
	{
		var_07 = level.swim_anim_drown;
	}

	var_08 = %wm_unarmed_underwater_swim_arms_off_screen;
	if(isdefined(level.swim_anim_offscreen))
	{
		var_08 = level.swim_anim_offscreen;
	}

	var_09 = getnotetracktimes(var_06,"anim_interupt");
	var_0A = getanimlength(var_04);
	var_0B = getanimlength(var_05);
	var_0C = getanimlength(var_06);
	var_0D = 1;
	var_0E = 2;
	var_0F = 3;
	var_10 = 4;
	var_11 = var_0D;
	param_00 setflaggedanimknob("swim_notes",var_08,1,0);
	param_00 setflaggedanimknob("swim_notes",var_04,1,0.5);
	self.swimming_gravity_vel = (0,0,0);
	var_12 = 0;
	if(!isdefined(self.ent_flag) || !isdefined(self.ent_flag["water_trigger_paused"]))
	{
		maps\_utility::ent_flag_init("water_trigger_paused");
	}

	for(;;)
	{
		if(self ismantling())
		{
			return;
		}

		var_13 = self getnormalizedmovement();
		var_14 = self getnormalizedcameramovements();
		if(maps\_utility::ent_flag("water_trigger_paused"))
		{
			var_13 = (0,0,0);
			var_14 = (0,0,0);
		}

		var_15 = 0;
		if(var_13[0] > 0.2)
		{
			var_15 = 1;
		}

		var_16 = var_11;
		var_17 = (0,0,0);
		if(!var_15 && param_02)
		{
			var_17 = (0,0,-10);
			self.swimming_gravity_vel = self.swimming_gravity_vel + var_17 * 0.05;
			self.swimming_gravity_vel = (self.swimming_gravity_vel[0],self.swimming_gravity_vel[1],max(-50,self.swimming_gravity_vel[2]));
			var_18 = self.origin + self.swimming_gravity_vel * 0.05;
			var_18 = playerphysicstrace(self.origin,var_18,self);
			self setorigin(var_18);
		}
		else
		{
			self.swimming_gravity_vel = (0,0,0);
		}

		if(common_scripts\utility::flag("player_swimming_drown"))
		{
			if(var_11 == var_0F)
			{
				var_19 = param_00 getanimtime(var_06);
				foreach(var_1B in var_09)
				{
					if(var_19 > var_1B - 0.1 && var_19 < var_1B + 0.1)
					{
						var_11 = var_10;
					}
				}
			}
			else
			{
				var_11 = var_10;
			}
		}

		if(var_11 == var_0D)
		{
			if(var_15)
			{
				var_11 = var_0E;
			}
			else if(var_12 >= var_0A)
			{
				var_16 = 0;
			}
		}
		else if(var_11 == var_0E)
		{
			if(var_12 >= var_0B)
			{
				if(var_15)
				{
					var_11 = var_0F;
				}
				else
				{
					var_11 = var_0D;
				}
			}
		}
		else if(var_11 == var_0F)
		{
			if(var_15)
			{
				if(var_12 >= var_0C)
				{
					var_16 = 0;
				}
			}
			else
			{
				var_19 = param_00 getanimtime(var_06);
				foreach(var_1B in var_09)
				{
					if(var_19 > var_1B - 0.1 && var_19 < var_1B + 0.1)
					{
						var_11 = var_0D;
					}
				}
			}
		}

		if(var_16 != var_11)
		{
			if(var_11 == var_0D)
			{
				if(var_16 == var_0F || var_16 == var_0E)
				{
					param_00 setflaggedanimknobrestart("swim_notes",var_04,1,1);
				}
				else
				{
					param_00 setflaggedanimknobrestart("swim_notes",var_04);
				}
			}
			else if(var_11 == var_0E)
			{
				param_00 notify("swim_notes","lagos_swimming_into_stroke");
				param_00 setflaggedanimknobrestart("swim_notes",var_05);
			}
			else if(var_11 == var_0F)
			{
				param_00 setflaggedanimknobrestart("swim_notes",var_06);
			}
			else if(var_11 == var_10)
			{
				param_00 setflaggedanimknobrestart("swim_notes",var_07,1,0.75);
			}

			var_12 = 0.05;
		}

		wait(0.05);
		var_12 = var_12 + 0.05;
	}
}

//Function Number: 12
viewmodel_swim_animations(param_00,param_01,param_02)
{
	self notify("viewmodel_swim_animations");
	self endon("viewmodel_swim_animations");
	self disableweapons();
	self hideviewmodel();
	if(isdefined(self.swimming_arms))
	{
		self.swimming_arms hide();
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!param_02)
	{
		if(!isdefined(self.swimming_arms) || self.swimming_arms.model != level.swim_arms_model)
		{
			var_03 = spawn("script_model",self.origin);
			var_03 setmodel(level.swim_arms_model);
			var_03 dontcastshadows();
			var_03 setcontents(0);
			var_03 useanimtree(#animtree);
			var_03 linktoplayerview(self,"tag_origin",(0,0,-60),(0,0,0),1);
			self.swimming_arms = var_03;
		}

		if(isdefined(self.swimming_arms))
		{
			self.swimming_arms show();
		}
	}

	if(isdefined(self.swimming_arms))
	{
		viewmodel_swim_animations_loop(self.swimming_arms,param_00,param_01 && !param_02);
	}

	if(!common_scripts\utility::flag("missionfailed") && isdefined(self.swimming_arms) && !self ismantling())
	{
		self.swimming_arms setflaggedanimknobrestart("swim_notes",%wm_unarmed_underwater_swim_arms_off_screen);
		var_04 = getanimlength(%wm_unarmed_underwater_swim_arms_off_screen);
		if(!isdefined(level.swim_end_hide_viewarms))
		{
			wait(var_04);
		}
	}

	if(isdefined(self.swimming_arms))
	{
		self.swimming_arms hide();
	}

	self notify("viewmodel_swim_animations_loop");
	self enableweapons();
	if(!isdefined(level.swim_end_hide_viewarms))
	{
		self showviewmodel();
	}
}

//Function Number: 13
player_swimming_moving_water()
{
	var_00 = getentarray("moving_water_flags","script_noteworthy");
	foreach(var_02 in var_00)
	{
		thread moving_water_flag(var_02);
	}

	thread move_swimming_player_with_current();
}

//Function Number: 14
moving_water_flag(param_00)
{
	level endon("stop_player_swimming");
	var_01 = getent(param_00.target,"targetname");
	var_02 = var_01.origin - param_00.origin;
	for(;;)
	{
		common_scripts\utility::flag_wait(param_00.script_flag);
		level.water_current = var_02;
		common_scripts\utility::flag_waitopen(param_00.script_flag);
		level.water_current = (0,0,0);
	}
}

//Function Number: 15
move_swimming_player_with_current()
{
	level endon("stop_player_swimming");
	var_00 = undefined;
	for(;;)
	{
		if(!isdefined(var_00) || level.water_current != var_00)
		{
			setsaveddvar("player_swimWaterCurrent",level.water_current);
			var_00 = level.water_current;
		}

		wait(0.05);
	}
}

//Function Number: 16
player_dynamic_dof(param_00)
{
	if(!maps\_utility::is_gen4())
	{
		return;
	}

	level endon("stop_player_swimming");
	self endon("stop_dynamic_dof");
	for(;;)
	{
		wait(0.05);
		if(common_scripts\utility::flag("pause_dynamic_dof"))
		{
			wait(0.05);
			continue;
		}

		var_01 = self playerads();
		if(var_01 > 0)
		{
			continue;
		}

		var_02 = getdvarfloat("ads_dof_tracedist",4096);
		var_03 = getdvarfloat("ads_dof_nearStartScale",0.25);
		var_04 = getdvarfloat("ads_dof_nearEndScale",0.85);
		var_05 = getdvarfloat("ads_dof_farStartScale",1.15);
		var_06 = getdvarfloat("ads_dof_farEndScale",3);
		var_07 = getdvarfloat("ads_dof_nearBlur",4);
		var_08 = getdvarfloat("ads_dof_farBlur",2.5);
		var_09 = self geteye();
		var_0A = self getplayerangles();
		if(isdefined(self.dof_ref_ent))
		{
			var_0B = combineangles(self.dof_ref_ent.angles,var_0A);
		}
		else
		{
			var_0B = var_0A;
		}

		var_0C = vectornormalize(anglestoforward(var_0B));
		var_0D = bullettrace(var_09,var_09 + var_0C * var_02,1,self,1);
		var_0E = getaiarray("axis");
		if(var_0D["fraction"] == 1)
		{
			var_02 = 2048;
			var_0F = 256;
			var_10 = var_02 * var_05 * 2;
		}
		else
		{
			var_02 = distance(var_09,var_0D["position"]);
			if(var_02 > param_00)
			{
				maps\_art::dof_disable_script(0.5);
				continue;
			}

			var_0F = var_02 * var_03;
			var_10 = var_02 * var_05;
		}

		foreach(var_12 in var_0E)
		{
			var_13 = vectornormalize(var_12.origin - var_09);
			var_14 = vectordot(var_0C,var_13);
			if(var_14 < 0.923)
			{
				continue;
			}

			var_15 = distance(var_09,var_12.origin);
			if(var_15 - 30 < var_0F)
			{
				var_0F = var_15 - 30;
			}

			if(var_15 + 30 > var_10)
			{
				var_10 = var_15 + 30;
			}
		}

		if(var_0F > var_10)
		{
			var_0F = var_10 - 256;
		}

		if(var_0F > var_02)
		{
			var_0F = var_02 - 30;
		}

		if(var_0F < 1)
		{
			var_0F = 1;
		}

		if(var_10 < var_02)
		{
			var_10 = var_02;
		}

		var_17 = var_0F * var_03;
		var_18 = var_10 * var_06;
		maps\_art::dof_enable_script(var_17,var_0F,var_07,var_10,var_18,var_08,0.5);
	}

	wait(0.05);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\seoul_zipline.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 504 ms
 * Timestamp: 10/27/2023 1:54:01 AM
*******************************************************************/

//Function Number: 1
precache_stuff()
{
	precache_fx();
	load_scripted_anims();
}

//Function Number: 2
precache_fx()
{
	level._effect["warbird_harpoon_spiral"] = loadfx("vfx/vehicle/warbird_harpoon_spiral");
	level._effect["warbird_zip_rope_glow"] = loadfx("vfx/vehicle/warbird_zip_rope_glow");
	level._effect["dust_harpoon_impact"] = loadfx("vfx/dust/dust_harpoon_impact");
}

//Function Number: 3
load_scripted_anims()
{
	load_generic_human_anims();
	load_script_model_anims();
	precachemodel("npc_zipline_rope_left");
}

//Function Number: 4
load_generic_human_anims()
{
	level.scr_anim["generic"]["npc_inverted_zipline_launch_1"] = %npc_inverted_zipline_launch_1;
	level.scr_anim["generic"]["npc_inverted_zipline_launch_2"] = %npc_inverted_zipline_launch_2;
	level.scr_anim["generic"]["npc_inverted_zipline_launch_3"] = %npc_inverted_zipline_launch_3;
	level.scr_anim["generic"]["npc_inverted_zipline_launch_4"] = %npc_inverted_zipline_launch_4;
	level.scr_anim["generic"]["zipline_land_spc_1"] = %npc_inverted_zipline_spc_1;
	level.scr_anim["generic"]["zipline_land_spc_2"] = %npc_inverted_zipline_spc_2;
	level.scr_anim["generic"]["zipline_land_spc_3"] = %npc_inverted_zipline_spc_3;
	level.scr_anim["generic"]["zipline_land_spc_4"] = %npc_inverted_zipline_spc_4;
	level.scr_anim["generic"]["zipline_land_1"] = %npc_inverted_zipline_1;
	level.scr_anim["generic"]["zipline_land_2"] = %npc_inverted_zipline_2;
	level.scr_anim["generic"]["zipline_land_3"] = %npc_inverted_zipline_3;
	level.scr_anim["generic"]["zipline_land_4"] = %npc_inverted_zipline_4;
	level.scr_anim["generic"]["zipline_land_6"] = %npc_inverted_zipline_6;
	level.scr_anim["generic"]["zipline_land_7"] = %npc_inverted_zipline_7;
	level.scr_anim["generic"]["zipline_land_8"] = %npc_inverted_zipline_8;
	level.scr_anim["generic"]["zipline_land_9"] = %npc_inverted_zipline_9;
	level.scr_anim["generic"]["zipline_ground_land_ra"] = %zipline_right_land_guy_a;
	level.scr_anim["generic"]["zipline_ground_land_rb"] = %zipline_right_land_guy_b;
	level.scr_anim["generic"]["zipline_ground_land_la"] = %zipline_left_landing_guy_a;
	level.scr_anim["generic"]["zipline_ground_land_lb"] = %zipline_left_landing_guy_b;
	level.scr_anim["generic"]["zipline_idleloop_ra"][0] = %zipline_right_slidedown_guy_a;
	level.scr_anim["generic"]["zipline_idleloop_rb"][0] = %zipline_right_slidedown_guy_b;
	level.scr_anim["generic"]["zipline_idleloop_la"][0] = %zipline_left_slidedown_guy_a;
	level.scr_anim["generic"]["zipline_idleloop_lb"][0] = %zipline_left_slidedown_guy_b;
}

//Function Number: 5
load_script_model_anims()
{
	level.scr_animtree["_zipline_rope_fl"] = #animtree;
	level.scr_model["_zipline_rope_fl"] = "npc_zipline_rope_left";
	level.scr_anim["_zipline_rope_fl"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
	level.scr_anim["_zipline_rope_fl"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
	level.scr_anim["_zipline_rope_fl"]["retract_rope"] = %fastzip_launcher_retract_left;
	maps\_anim::addnotetrack_customfunction("_zipline_rope_fl","fx_harpoon_launch",::harpoon_launch_effects,"fastzip_fire");
}

//Function Number: 6
harpoon_launch_effects(param_00)
{
	playfxontag(common_scripts\utility::getfx("warbird_harpoon_spiral"),param_00,"jnt_harpoon");
	playfxontag(common_scripts\utility::getfx("warbird_zip_rope_glow"),param_00,"harpooncablebend");
}

//Function Number: 7
spawn_npc_and_use_scripted_zipline(param_00,param_01,param_02)
{
	if(isstring(param_00))
	{
		var_03 = getent(param_00,"targetname");
	}
	else
	{
		var_03 = param_01;
	}

	var_03.count = 1;
	var_04 = var_03 maps\_utility::spawn_ai(1);
	maps\_utility::spawn_failed(var_04);
	wait 0.05;
	var_04.animname = "generic";
	level notify("zipline_guys_spawned",var_04);
	var_04 thread seoul_zipline_scripted(param_01,param_02);
	return var_04;
}

//Function Number: 8
seoul_zipline_scripted(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isstring(param_00))
	{
		var_04 = maps\_utility::getent_or_struct_or_node(param_00,"targetname");
	}
	else
	{
		var_04 = param_00;
	}

	var_06 = var_04.origin;
	if(isdefined(var_04.target))
	{
		var_05 = maps\_utility::getent_or_struct_or_node(var_04.target,"targetname");
	}
	else if(isdefined(var_04.script_noteworthy))
	{
		var_05 = maps\_utility::getent_or_struct_or_node(var_04.script_noteworthy,"targetname");
	}
	else
	{
		return;
	}

	var_07 = var_05.origin;
	self.zipline_end_org = var_07;
	var_08 = vectortoangles(var_07 - var_06);
	var_09 = maps\_utility::spawn_anim_model("_zipline_rope_fl",var_06,var_08);
	var_09 setmodel("npc_zipline_rope_left");
	var_0A = randomfloat(100);
	if(var_0A < 25)
	{
		var_0B = "zipline_idleloop_ra";
	}
	else if(var_0B < 50)
	{
		var_0B = "zipline_idleloop_rb";
	}
	else if(var_0B < 75)
	{
		var_0B = "zipline_idleloop_la";
	}
	else
	{
		var_0B = "zipline_idleloop_la";
	}

	if(var_07[2] > var_06[2])
	{
		var_03 = get_launch_anim(var_05,1);
	}

	if(!isdefined(param_01))
	{
		if(var_07[2] > var_06[2])
		{
			param_01 = "zipline_land_8";
		}
		else
		{
			var_0A = randomfloat(100);
			if(var_0A < 25)
			{
				param_01 = "zipline_ground_land_ra";
			}
			else if(var_0A < 50)
			{
				param_01 = "zipline_ground_land_rb";
			}
			else if(var_0A < 50)
			{
				param_01 = "zipline_ground_land_la";
			}
			else
			{
				param_01 = "zipline_ground_land_lb";
			}
		}
	}

	seoul_zipline_scripted_custom(var_06,var_07,var_09,"fastzip_fire","fastzip_slide",var_0B,var_03,param_01,param_02);
}

//Function Number: 9
seoul_zipline_scripted_custom(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	param_02 do_reposition_zipline_compensation(param_02,param_00,param_01,param_03);
	param_02 do_rotate_zipline_compensation(param_02,param_00,param_01,param_03,param_04);
	var_09 = param_01[2] > param_00[2];
	var_0A = param_02 fire_rope(param_00,param_01,param_03);
	var_0B = var_0A[0];
	var_0C = var_0A[1];
	var_0D = var_0A[2];
	param_02 thread remove_zipline_on_death(param_08,var_0B,self);
	if(!isdefined(self) || !isalive(self))
	{
		return 1;
	}

	if(isdefined(self) && isalive(self))
	{
		var_0E = get_uncliip_zipline_waittime(param_07,var_09);
		self.is_using_zipline = 1;
		thread allow_death_during_zipline();
		fastzip_slide(param_02,param_05,param_04,var_0C,var_0E);
		fastzip_launch(param_06,var_09);
		fastzip_land(param_07,var_09,var_0E);
		self notify("end_allow_death_during_zipline");
		self.is_using_zipline = undefined;
	}

	if(!isdefined(param_08) || !param_08)
	{
		param_02 retract_rope(var_0B);
		param_02 delete();
	}

	return 1;
}

//Function Number: 10
remove_zipline_on_death(param_00,param_01,param_02)
{
	param_02 waittill("death");
	if(isdefined(self) && !isdefined(param_00) || !param_00)
	{
		retract_rope(param_01);
		self delete();
	}
}

//Function Number: 11
allow_death_during_zipline()
{
	self endon("end_allow_death_during_zipline");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.delayeddeath) && self.delayeddeath)
		{
			stop_zip_idle_anim();
			var_00 = self getlinkedparent();
			if(isdefined(var_00))
			{
				self unlink();
			}

			self animmode("gravity");
		}

		wait 0.05;
	}
}

//Function Number: 12
get_launch_anim(param_00,param_01)
{
	if(1)
	{
		var_02 = randomfloat(100);
		if(param_01)
		{
			if(var_02 < 25)
			{
				return "npc_inverted_zipline_launch_1";
			}

			if(var_02 < 50)
			{
				return "npc_inverted_zipline_launch_2";
			}

			if(var_02 < 75)
			{
				return "npc_inverted_zipline_launch_3";
			}

			return "npc_inverted_zipline_launch_4";
		}

		if(var_02 < 25)
		{
			return %npc_inverted_zipline_launch_1;
		}

		if(var_02 < 50)
		{
			return %npc_inverted_zipline_launch_2;
		}

		if(var_02 < 75)
		{
			return %npc_inverted_zipline_launch_3;
		}

		return %npc_inverted_zipline_launch_4;
	}

	if(param_01)
	{
		return param_00.animation;
	}

	return maps\_utility::getanim(param_00.animation);
}

//Function Number: 13
get_uncliip_zipline_waittime(param_00,param_01)
{
	if(!param_01)
	{
		return 0.4329;
	}

	return 0;
}

//Function Number: 14
main()
{
}

//Function Number: 15
fastzip_launch(param_00,param_01)
{
	self endon("death");
	if(isalive(self))
	{
		if(isdefined(param_00))
		{
			unlink_from_zip();
			stop_zip_idle_anim();
			common_scripts\utility::delay_script_call(0.2,::set_post_slide_blend_time,0.2);
			if(isstring(param_00))
			{
				level.scr_goaltime[self.animname][param_00] = self.anim_blend_time_override;
				thread maps\_anim::anim_single_solo(self,param_00);
				var_02 = getanimlength(maps\_utility::getanim(param_00));
				wait(truncate_time_ms(var_02));
				return;
			}

			self setflaggedanimknoballrestart("traverseAnim",param_01,%body,1,0.2,1);
			var_02 = getanimlength(param_01);
			wait(var_02);
			return;
		}

		set_post_slide_blend_time(0.2);
	}
}

//Function Number: 16
truncate_time_ms(param_00)
{
	var_01 = param_00 * 20;
	var_01 = int(var_01);
	return var_01 * 0.05;
}

//Function Number: 17
set_post_slide_blend_time(param_00)
{
	self.anim_blend_time_override = param_00;
}

//Function Number: 18
stop_zip_idle_anim()
{
	self notify("stop_loop");
	self stopanimscripted();
}

//Function Number: 19
unlink_from_zip()
{
	if(!isdefined(self))
	{
		return;
	}

	var_00 = self getlinkedparent();
	if(isdefined(var_00))
	{
		self unlink();
	}
}

//Function Number: 20
fastzip_land(param_00,param_01,param_02)
{
	self endon("death");
	if(isalive(self))
	{
		common_scripts\utility::delay_script_call(param_02,::unlink_from_zip);
		stop_zip_idle_anim();
		var_03 = undefined;
		if(isstring(param_00))
		{
			var_03 = maps\_utility::getanim(param_00);
		}
		else
		{
			var_03 = param_00;
		}

		var_04 = getanimlength(var_03);
		var_05 = 0;
		var_06 = 0;
		var_07 = 0;
		if(animhasnotetrack(var_03,"finish"))
		{
			var_05 = var_04 * getnotetracktimes(var_03,"finish")[0];
		}
		else
		{
			var_05 = var_04;
		}

		if(animhasnotetrack(var_03,"land"))
		{
			var_06 = var_04 * getnotetracktimes(var_03,"land")[0];
			var_07 = 1;
		}

		level.scr_goaltime[self.animname][param_00] = self.anim_blend_time_override;
		soundscripts\_snd::snd_message("seo_zipline_rappel_land",self);
		if(param_01)
		{
			thread maps\_anim::anim_single_solo(self,param_00);
		}
		else
		{
			thread maps\_anim::anim_generic_custom_animmode(self,"nogravity",param_00,undefined,undefined,0);
		}

		wait(param_02);
		if(var_07)
		{
			wait(var_06 - param_02 - 0.05);
			self animmode("gravity");
			wait(var_05 - var_06 - param_02 - 0.05);
		}
		else
		{
			wait(var_05 - param_02);
		}

		self stopanimscripted();
		return;
	}

	self.istraversing = undefined;
	self animmode("none");
	self notify("zipline_done");
}

//Function Number: 21
get_adjusted_anim_rate(param_00,param_01,param_02)
{
	var_03 = getmovedelta(param_00,0,1);
	var_03 = rotatevector(var_03,self.angles);
	var_04 = (self.origin[0] + var_03[0],self.origin[1] + var_03[1],self.origin[2]) + (0,0,70);
	var_05 = physicstrace(var_04,self.origin + (0,0,-5120),self);
	var_06 = var_05[2] - self.origin[2];
	var_07 = animscripts\utility::get_trajectory_time_given_x(0,var_06,-1 * self.velocity[2],-1 * getdvarint("g_gravity"));
	var_07 = var_07 - param_02;
	var_08 = param_02 / var_07;
	if(var_06 >= var_03[2])
	{
		return 1;
	}

	if(var_08 <= 0)
	{
		return 1;
	}

	return var_08;
}

//Function Number: 22
fastzip_slide(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = param_00 maps\_utility::getanim(param_02);
	param_00 setanimlimited(%add_slide,1,0,0);
	param_00 setanimlimited(var_05,1,0,0);
	var_06 = anglestoforward(param_00.angles);
	var_06 = (var_06[0],var_06[1],0);
	var_07 = vectortoangles(var_06);
	var_08 = param_00 gettagorigin_rotatecompensation("tag_player_attach");
	var_09 = var_08[0];
	var_0A = var_08[1];
	self forceteleport(var_09,var_07,100000);
	if(isstring(param_01))
	{
		thread maps\_anim::anim_loop_solo(self,param_01,"stop_loop");
	}
	else
	{
		thread play_loop_until_message(param_01,"stop_loop");
	}

	soundscripts\_snd::snd_message("seo_zipline_rappel_begin");
	wait(0.05);
	self linkto(param_00,"tag_player_attach");
	param_00 setanimlimited(%add_slide,1,0,1);
	param_00 setanimlimited(var_05,1,0,1);
	wait(param_03 - 0.1 - param_04);
	thread fastzip_slide_end(param_00,var_05,param_04);
}

//Function Number: 23
fastzip_slide_end(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	wait(param_02);
	var_03 = 1;
	while(var_03 > 0)
	{
		var_03 = var_03 - 0.1;
		param_00 setanimrate(param_01,var_03);
		wait 0.05;
	}

	param_00 setanimrate(param_01,0);
}

//Function Number: 24
play_loop_until_message(param_00,param_01)
{
	self endon("death");
	self setflaggedanimknoballrestart("idle",param_00,%body,1,0.1,1);
	self waittill(param_01);
	self clearanim(param_00,0.2);
}

//Function Number: 25
gettagorigin_rotatecompensation(param_00)
{
	var_01 = self gettagorigin("jnt_shuttleClip");
	var_02 = self gettagorigin(param_00);
	var_03 = distance(var_01,var_02);
	var_04 = var_01 + (0,0,-1) * var_03;
	return [var_04,var_02 - var_04];
}

//Function Number: 26
do_rotate_zipline_compensation(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 gettagorigin("jnt_winchCableBend");
	var_06 = distance(param_02,param_01);
	var_07 = param_02 - param_01;
	var_08 = var_06 / 2400;
	param_00 setanim(param_00 maps\_utility::getanim(param_04),1,0,0);
	param_00 setanimtime(param_00 maps\_utility::getanim(param_04),var_08);
	wait 0.05;
	var_09 = param_00 gettagorigin("jnt_shuttleRoot");
	param_00 setanimtime(param_00 maps\_utility::getanim(param_04),0);
	var_0A = var_09 - param_01;
	var_0B = vectortoangles(var_0A);
	var_0C = vectortoangles(var_07);
	var_0D = combineangles(var_0C,invertangles(var_0B));
	var_0E = combineangles(var_0D,var_0C);
	param_00.angles = var_0E;
}

//Function Number: 27
do_reposition_zipline_compensation(param_00,param_01,param_02,param_03)
{
	param_00 maps\_anim::anim_first_frame_solo(param_00,param_03);
	var_04 = param_00 gettagorigin("jnt_winchCableBend");
	param_00.origin = param_00.origin + param_01 - var_04;
}

//Function Number: 28
fire_rope(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 1;
	var_06 = 7;
	var_07 = distance(param_01,param_00) / 12;
	if(var_07 <= 200)
	{
		var_08 = var_07 / 200;
	}
	else
	{
		var_08 = 1;
		var_07 = 200;
	}

	if(var_05)
	{
		var_09 = param_01 - param_00;
		var_09 = vectornormalize(var_09);
		var_04 = param_01 + var_09 * 2400;
		var_0A = bullettrace(param_01,var_04,0);
		if(var_0A["fraction"] < 1)
		{
			var_04 = var_0A["position"];
		}

		var_0B = distance(param_00,var_04) / 12;
		var_0B = var_0B - 3.75;
		if(var_0B <= 200)
		{
			var_03 = var_0B / 200;
		}
		else
		{
			var_03 = 1;
			var_0B = 200;
		}
	}
	else
	{
		var_03 = var_08;
	}

	var_0C = maps\_utility::getanim(param_02);
	var_0D = getanimlength(var_0C);
	var_0E = var_0D * var_03 / var_06 - 0.05;
	soundscripts\_snd::snd_message("seo_zipline_harpoon_fire",param_00,param_01,var_0E);
	self setflaggedanimknob(param_02,var_0C,1,0.2,var_06);
	thread maps\_anim::start_notetrack_wait(self,param_02,param_02,self.animname,var_0C);
	thread maps\_anim::animscriptdonotetracksthread(self,param_02,param_02);
	if(var_0E > 0.05)
	{
		wait(var_0E);
	}

	self setanim(var_0C,1,0,0);
	self setanimtime(var_0C,var_03);
	var_0F = self gettagorigin("jnt_harpoon");
	var_10 = anglestoright(self gettagangles("jnt_harpoon"));
	self.hit_ground_pos = physicstrace(var_0F + var_10 * -75,var_0F + var_10 * 75,self);
	playfx(common_scripts\utility::getfx("dust_harpoon_impact"),self.hit_ground_pos);
	soundscripts\_snd::snd_message("seo_zipline_harpoon_impact",self.hit_ground_pos);
	level notify("zipline_triggered",self.origin,self.hit_ground_pos);
	wait 0.05;
	self setanim(var_0C,1,0,0);
	self setanimtime(var_0C,1);
	var_11 = self gettagorigin("jnt_harpoon");
	var_12 = distance(var_0F,var_11);
	if(var_12 > 0)
	{
		var_13 = distance(var_0F,self.hit_ground_pos) - 15;
		var_14 = 1 - var_03 * var_13 / var_12;
		self setanim(var_0C,1,0,0);
		self setanimtime(var_0C,var_14 + var_03);
	}

	var_15 = var_0D * var_08 / 1;
	return [var_07,var_15,var_04];
}

//Function Number: 29
sndxt_fastzip_fire(param_00)
{
	var_01 = self;
	var_02 = randomfloatrange(0.1,0.2);
	wait(var_02);
	var_01 soundscripts\_snd_playsound::snd_play("tac_fastzip_fire");
	wait(var_02);
	common_scripts\utility::play_sound_in_space("tac_fastzip_proj_impact",param_00);
}

//Function Number: 30
retract_rope(param_00)
{
	var_01 = param_00 / 200;
	var_01 = 1 - min(var_01,1);
	var_02 = 30;
	var_03 = 1;
	var_04 = maps\_utility::getanim("retract_rope");
	self setanimknob(var_04,1,0.2,var_03);
	self setanimtime(var_04,var_01);
	playfx(common_scripts\utility::getfx("dust_harpoon_impact"),self.hit_ground_pos);
	soundscripts\_snd::snd_message("seo_zipline_retract_rope",self.hit_ground_pos);
	var_05 = var_02 * 1 - var_01 / 30 * var_03;
	wait(var_05 + 0.05);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _player_fastzip.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 347 ms
 * Timestamp: 4/22/2024 2:22:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::flag_init("use_fastzip_hint");
	common_scripts\utility::flag_init("flag_zipline_fire_button_pressed");
	maps\_utility::add_control_based_hint_strings("hint_use_fastzip",&"FASTZIP_HARPOON_SWITCH",::should_end_fastzip_hint);
	maps\_utility::add_control_based_hint_strings("hint_fire_fastzip",&"FASTZIP_FIRE_ZIPLINE",::should_end_fastzip_fire_hint);
	precacheturret("zipline_gun_player");
	load_fx();
	load_model_anims();
	load_player_anims();
}

//Function Number: 2
load_fx()
{
	level._effect["zipline_flash_view"] = loadfx("vfx/muzzleflash/zipline_flash_view");
	level._effect["harpoon_dust"] = loadfx("vfx/trail/harpoon_dust");
	level._effect["landing_target_valid"] = loadfx("fx/misc/ui_flagbase_gold");
	level._effect["landing_target_invalid"] = loadfx("fx/misc/ui_flagbase_red");
}

//Function Number: 3
load_model_anims()
{
	level.scr_anim["_turret_fastzip"]["fastzip_aim_idle"] = %fastzip_launcher_ads;
}

//Function Number: 4
load_player_anims()
{
	level.scr_anim["_player_arms_fastzip"]["fastzip_pullout"] = %fastzip_launcher_pullout_vm;
	level.scr_anim["_player_arms_fastzip"]["fastzip_ads"] = %fastzip_launcher_ads_vm;
	level.scr_anim["_player_arms_fastzip"]["fastzip_putaway"] = %fastzip_launcher_putaway_vm;
	level.scr_anim["_player_arms_fastzip"]["fastzip_land"] = %fastzip_launcher_land_vm;
}

//Function Number: 5
should_end_fastzip_hint()
{
	return common_scripts\utility::flag("use_fastzip_hint");
}

//Function Number: 6
should_end_fastzip_fire_hint()
{
	return common_scripts\utility::flag("flag_zipline_fire_button_pressed");
}

//Function Number: 7
fire_hint_display()
{
	self endon("flag_zipline_fire_button_pressed");
	wait(4);
	if(!common_scripts\utility::flag("flag_zipline_fire_button_pressed"))
	{
		maps\_utility::hintdisplayhandler("hint_fire_fastzip");
	}
}

//Function Number: 8
copy_script_model(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 maps\_utility::assign_animtree(param_00.animname);
	var_01 setmodel(param_00.model);
	return var_01;
}

//Function Number: 9
fastzip_turret_think(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = copy_script_model(param_02);
	var_04.animname = "_player_arms_fastzip";
	var_04 hide();
	var_05 = getentarray("valid_landing","targetname");
	wait_for_player_switch_to_turret();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	level.player allowjump(0);
	var_06 = getdvarint("turret_adsEnabled",1);
	setsaveddvar("turret_adsEnabled",0);
	waittillframeend;
	self notify("using_zip");
	var_07 = param_00.zipline_gun_model[param_01];
	var_08 = vehicle_scripts\_xh9_warbird::setup_zipline_gun("zipline_gun_player",param_00,param_01,var_07.model,var_07.rope_model,"_turret_fastzip");
	var_09 = vehicle_scripts\_xh9_warbird::setup_zipline_gun("zipline_gun_rope",param_00,param_01,var_07.rope_model,undefined,"_turret_fastzip");
	fastzip_turret_pullout(param_00,param_01,var_04,var_07);
	var_08 show();
	var_04 hide();
	var_08 makeusable();
	var_08 setmode("manual");
	var_09 setmode("manual");
	var_08 useby(self);
	var_08 turretfiredisable();
	self disableturretdismount();
	var_08 makeunusable();
	var_08.ground_target = common_scripts\utility::spawn_tag_origin();
	var_09 settargetentity(var_08.ground_target,(0,0,0));
	thread fire_hint_display();
	wait_to_fire_rope(param_00,var_08,var_05);
	self playrumbleonentity("damage_heavy");
	var_0A = var_09 fire_rope(var_08,var_08.ground_target.origin,var_07);
	var_08 set_landing_target_fx(undefined);
	var_08 useby(self);
	var_08 settargetentity(var_08.ground_target);
	setsaveddvar("turret_adsEnabled",var_06);
	fastzip_turret_putaway(param_00,param_01,var_04,var_08,var_07);
	thread player_fastzip(var_09,var_08.ground_target.origin,var_04,param_03);
	var_0B = maps\_utility::get_rumble_ent("steady_rumble");
	var_0B.intensity = 0.2;
	self waittill("fastzip_arrived");
	stopallrumbles();
	self waittill("fastzip_landed");
	var_04 delete();
	self playrumbleonentity("damage_heavy");
	wait(0.5);
	var_09 retract_rope(var_0A,"left");
	var_09 delete();
	var_08.ground_target delete();
	var_08 delete();
}

//Function Number: 10
fastzip_turret_pullout(param_00,param_01,param_02,param_03)
{
	param_02 linkto(param_00,param_01,(0,0,0),(0,0,0));
	var_04 = [];
	var_04[0] = param_02;
	var_04[1] = param_03;
	param_03 clear_script_model_anim(0);
	soundscripts\_snd::snd_message("fastzip_turret_switch_to");
	param_00 maps\_anim::anim_first_frame(var_04,"fastzip_pullout",param_01);
	var_05 = 0.15;
	level.player playerlinktoblend(param_02,"tag_player",var_05);
	level.player common_scripts\utility::delaycall(var_05,::playerlinktodelta,param_02,"tag_player",1,0,0,0,0,1);
	param_02 common_scripts\utility::delaycall(var_05,::show);
	maps\_utility::delaythread(1.2,::maps\_utility::lerp_fov_overtime,2,55);
	param_00 maps\_anim::anim_single(var_04,"fastzip_pullout",param_01);
	param_02 maps\_utility::anim_stopanimscripted();
	param_02 setanim(level.scr_anim["_player_arms_fastzip"]["fastzip_ads"],1,0,1);
	param_02 unlink();
	param_03 hide();
	if(isdefined(param_03.attachment))
	{
		param_03.attachment hide();
	}

	soundscripts\_snd::snd_message("fastzip_turret_switch_complete");
	self unlink();
}

//Function Number: 11
set_landing_target_fx(param_00)
{
	if(!isdefined(self.current_landing_fx))
	{
		if(isdefined(param_00))
		{
			self.current_landing_fx = param_00;
			playfxontag(common_scripts\utility::getfx(self.current_landing_fx),self.ground_target,"tag_origin");
		}

		return;
	}

	if(isdefined(self.current_landing_fx) && !isdefined(param_00))
	{
		stopfxontag(common_scripts\utility::getfx(self.current_landing_fx),self.ground_target,"tag_origin");
		self.current_landing_fx = undefined;
		return;
	}

	if(self.current_landing_fx != param_00)
	{
		stopfxontag(common_scripts\utility::getfx(self.current_landing_fx),self.ground_target,"tag_origin");
		self.current_landing_fx = param_00;
		playfxontag(common_scripts\utility::getfx(self.current_landing_fx),self.ground_target,"tag_origin");
	}
}

//Function Number: 12
wait_to_fire_rope(param_00,param_01,param_02)
{
	param_01.ground_target.angles = (-90,0,0);
	param_01.current_landing_fx = undefined;
	for(;;)
	{
		var_03 = param_01 gettagorigin("tag_player");
		var_04 = param_01 gettagangles("tag_player");
		var_05 = vectornormalize(anglestoforward(var_04));
		var_06 = var_03 + var_05 * 100;
		var_07 = var_03 + var_05 * 10000;
		var_08 = 0;
		param_01.ground_target.origin = var_07;
		var_09 = bullettrace(var_06,var_07,0);
		if(isdefined(var_09["position"]))
		{
			param_01.ground_target.origin = var_09["position"];
			foreach(var_0B in param_02)
			{
				if(param_01.ground_target istouching(var_0B))
				{
					var_08 = 1;
					param_01 set_landing_target_fx("landing_target_valid");
					break;
				}
			}

			if(var_08)
			{
				if(self attackbuttonpressed())
				{
					common_scripts\utility::flag_set("flag_zipline_fire_button_pressed");
					soundscripts\_snd::snd_message("fastzip_turret_fire");
					return;
				}
			}
			else
			{
				param_01 set_landing_target_fx("landing_target_invalid");
			}
		}
		else
		{
			param_01 set_landing_target_fx(undefined);
		}

		wait(0.05);
	}
}

//Function Number: 13
fire_rope(param_00,param_01,param_02)
{
	var_03 = 200;
	var_04 = 210;
	var_05 = var_04 / 30;
	param_00 detach(param_02.rope_model);
	param_02 detach(param_02.rope_model);
	self show();
	var_06 = param_00 gettagorigin("tag_player");
	var_07 = distance(var_06,param_01) / 12;
	var_08 = var_07 / var_03;
	playfxontag(common_scripts\utility::getfx("harpoon_dust"),self,"jnt_harpoon");
	playfxontag(common_scripts\utility::getfx("zipline_flash_view"),self,"TAG_FLASH");
	var_09 = %fastzip_launcher_fire_left;
	var_0A = getanimlength(var_09);
	var_0B = var_0A / var_05 * var_08;
	self setanimknob(var_09,1,0.2,var_05);
	param_00 setanimknob(var_09,1,0.2,1);
	var_0B = var_0B - 0.05;
	if(var_0B > 0.05)
	{
		wait(var_0B);
	}

	self setanim(var_09,1,0,0);
	self setanimtime(var_09,var_08);
	return var_07;
}

//Function Number: 14
fastzip_turret_putaway(param_00,param_01,param_02,param_03,param_04)
{
	thread maps\_utility::lerp_fov_overtime(2,65);
	param_03 hide();
	param_04 show();
	if(isdefined(param_04.attachment))
	{
		param_04.attachment show();
	}

	var_05 = [];
	var_05[0] = param_02;
	var_05[1] = param_04;
	param_03 clear_script_model_anim(0.2);
	param_00 maps\_anim::anim_first_frame(var_05,"fastzip_putaway",param_01);
	self playerlinktodelta(param_02,"tag_player",1,0,0,0,0,1);
	soundscripts\_snd::snd_message("fastzip_turret_putaway");
	self setplayerangles(self getplayerangles());
	wait(0.2);
	param_02 show();
	param_00 maps\_anim::anim_single(var_05,"fastzip_putaway",param_01);
	param_04 maps\_utility::anim_stopanimscripted();
	param_04 clear_script_model_anim(0);
	param_04 setanim(%fastzip_launcher_folded_idle_left,1,0,1);
}

//Function Number: 15
player_fastzip(param_00,param_01,param_02,param_03)
{
	thread player_camera_shake();
	self notify("fastzip_start");
	var_04 = %fastzip_launcher_slidedown_left;
	param_00 setanimlimited(%add_slide,1,0,1);
	param_00 setanimlimited(var_04,1,0,1);
	self playerlinktodelta(param_00,"TAG_PLAYER_ATTACH",1,20,20,20,20,1);
	soundscripts\_snd::snd_message("fastzip_rappel");
	if(isdefined(param_03))
	{
		wait(param_03);
	}
	else
	{
		wait(0.05);
	}

	var_05 = self.origin;
	var_06["fraction"] = 1;
	var_07 = (0,0,0);
	var_08 = (0,0,0);
	while(var_06["fraction"] == 1)
	{
		wait(0.05);
		var_09 = self.origin;
		var_08 = var_09 - var_05;
		var_07 = var_08 * 3;
		var_06 = bullettrace(var_09,var_09 + var_07,0,self);
		var_05 = var_09;
	}

	self unlink();
	self notify("kill_camera_shake");
	thread player_fastzip_land(var_08,param_02);
	self notify("fastzip_arrived");
	param_00 setanimlimited(var_04,1,0,0);
}

//Function Number: 16
player_fastzip_land(param_00,param_01)
{
	var_02 = param_00 * 20;
	self setvelocity(var_02);
	thread prevent_look_until_notify("fastzip_hit_the_ground");
	var_03 = undefined;
	while(!self isonground())
	{
		var_03 = self getvelocity();
		wait(0.05);
	}

	self notify("fastzip_hit_the_ground");
	soundscripts\_snd::snd_message("fastzip_hit_the_ground");
	var_04 = vectortoangles(param_00);
	var_05 = spawnstruct();
	var_05.origin = self.origin;
	var_05.angles = (0,var_04[1] + 90,0);
	var_05 maps\_anim::anim_first_frame_solo(param_01,"fastzip_land");
	var_06 = getmovedelta(param_01 maps\_utility::getanim("fastzip_land"),0,1);
	var_07 = param_01 localtoworldcoords(var_06);
	var_08 = var_07 + (0,0,24);
	var_09 = playerphysicstraceinfo(var_07,var_08);
	if(var_09["fraction"] > 0)
	{
		var_08 = var_09["position"] - (0,0,1);
	}

	var_09 = playerphysicstraceinfo(var_08,var_08 - (0,0,36));
	if(var_09["fraction"] > 0)
	{
		if(var_09["fraction"] < 1)
		{
			var_0A = var_09["position"];
			var_0B = var_0A - var_07;
			var_05.origin = var_05.origin + var_0B;
		}

		self playerlinktodelta(param_01,"tag_player",1,20,20,20,20,1);
		var_05 maps\_anim::anim_single_solo(param_01,"fastzip_land");
		self unlink();
	}
	else
	{
	}

	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player allowjump(1);
	self notify("fastzip_landed");
}

//Function Number: 17
prevent_look_until_notify(param_00)
{
	var_01 = getdvarint("aim_turnrate_pitch");
	var_02 = getdvarint("aim_turnrate_pitch_ads");
	var_03 = getdvarint("aim_turnrate_yaw");
	var_04 = getdvarint("aim_turnrate_yaw_ads");
	setsaveddvar("aim_turnrate_pitch",0);
	setsaveddvar("aim_turnrate_pitch_ads",0);
	setsaveddvar("aim_turnrate_yaw",0);
	setsaveddvar("aim_turnrate_yaw_ads",0);
	self waittill(param_00);
	setsaveddvar("aim_turnrate_pitch",var_01);
	setsaveddvar("aim_turnrate_pitch_ads",var_02);
	setsaveddvar("aim_turnrate_yaw",var_03);
	setsaveddvar("aim_turnrate_yaw_ads",var_04);
}

//Function Number: 18
player_camera_shake()
{
	self endon("fastzip_arrived");
	self endon("kill_camera_shake");
	var_00 = 0.1;
	var_01 = 0.8;
	var_02 = 0.1;
	var_03 = 0.45;
	var_04 = var_01;
	for(;;)
	{
		earthquake(min(var_00,var_03),var_02,self.origin,100);
		wait(var_02);
		var_04 = var_04 - var_02;
		if(var_04 < 0)
		{
			var_00 = var_00 + 0.1;
			var_04 = var_01;
		}
	}
}

//Function Number: 19
player_camera_shake_land()
{
	self endon("kill_camera_shake");
	var_00 = 0.5;
	var_01 = 0.2;
	while(var_00 > 0)
	{
		earthquake(var_00,var_01,self.origin,100);
		wait(var_01);
		var_00 = var_00 - 0.1;
	}
}

//Function Number: 20
retract_rope(param_00,param_01)
{
	var_02 = 200;
	var_03 = param_00 / var_02;
	var_03 = 1 - min(var_03,1);
	var_04 = 30;
	var_05 = 1;
	var_06 = %fastzip_launcher_retract_left;
	if(param_01 == "right")
	{
		var_06 = %fastzip_launcher_retract_right;
	}

	self setanimknob(var_06,1,0.2,var_05);
	self setanimtime(var_06,var_03);
	var_07 = var_04 * 1 - var_03 / 30 * var_05;
	wait(var_07 + 0.05);
}

//Function Number: 21
clear_script_model_anim(param_00)
{
	self clearanim(%root,param_00);
}

//Function Number: 22
clear_player_anim()
{
	self clearanim(%root,0);
}

//Function Number: 23
wait_for_player_to_complete_reloading()
{
	while(level.player isreloading())
	{
		wait 0.05;
	}
}

//Function Number: 24
wait_for_player_switch_to_turret()
{
	thread display_hint_until_zip_activated();
	var_00 = 0;
	while(var_00 < 1)
	{
		var_00 = 0;
		while(level.player usebuttonpressed() && var_00 < 1)
		{
			var_00 = var_00 + 0.1;
			wait 0.05;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("use_fastzip_hint");
}

//Function Number: 25
display_hint_until_zip_activated()
{
	self endon("using_zip");
	for(;;)
	{
		maps\_utility::hintdisplayhandler("hint_use_fastzip");
		wait(35);
	}
}
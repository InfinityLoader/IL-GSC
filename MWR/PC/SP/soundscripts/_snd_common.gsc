/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_snd_common.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 149
 * Decompile Time: 2394 ms
 * Timestamp: 10/27/2023 2:50:53 AM
*******************************************************************/

//Function Number: 1
snd_common_init()
{
	register_common_snd_messages();
	create_common_envelop_arrays();
	register_radio_squelches();
	apply_common_globalmix();
	level.mute_device_active = 0;
	level.player.radiation_state = "radiation_none";
	level._snd.context_overrides = [["mute",0],["slomo",0],["deathsdoor",0],["underwater",0],["diveboat",0],["wpn_int_med",0],["bullet_metal_vehicle",0],["bullet_whizby_glass",0],["finale_handgun",0]];
	soundsettimescalefactor("interface",0);
	soundsettimescalefactor("notimescale",0);
	if(common_scripts\utility::issp())
	{
		thread snd_ads_mix();
	}
}

//Function Number: 2
register_radio_squelches()
{
	level.scr_radio["squelches"]["plt"]["on"] = "squelch_on_plt";
	level.scr_radio["squelches"]["plt"]["off"] = "squelch_off_plt";
	level.scr_radio["squelches"]["hqr"]["on"] = "squelch_on_hqr";
	level.scr_radio["squelches"]["hqr"]["off"] = "squelch_off_hqr";
	level.scr_radio["squelches"]["prophet"]["on"] = "squelch_on_prophet";
	level.scr_radio["squelches"]["prophet"]["off"] = "squelch_off_hqr";
	level.scr_radio["squelches"]["battle_commander"]["on"] = "squelch_on_plt";
	level.scr_radio["squelches"]["battle_commander"]["off"] = "squelch_off_hqr";
	level.scr_radio["squelches"]["cormack_sfa"]["on"] = "squelch_on_plt";
	level.scr_radio["squelches"]["cormack_sfa"]["off"] = "squelch_off_hqr";
}

//Function Number: 3
create_common_envelop_arrays()
{
	level._snd.envs["explo_shake_over_distance"] = [[0,1],[0.25,0.65],[0.35,0.5],[0.75,0.2],[1,0.1]];
	level._snd.envs["veh_crash_intensity_to_pitch"] = [[0,0.7],[0.1,0.7],[0.5,0.8],[0.9,1],[1,1.1]];
	level._snd.envs["veh_crash_vel_to_lfe_vol"] = [[0,0],[200,0.05],[500,0.25],[850,0.35],[1000,0.6]];
	level._snd.envs["aud_mute_device_falloff"] = [[0,1],[0.1,0.9],[0.2,0.88],[0.3,0.85],[0.4,0.82],[0.5,0.8],[0.6,0.65],[0.7,0.5],[0.8,0.35],[0.9,0.15],[1,0]];
}

//Function Number: 4
apply_common_globalmix()
{
	if(common_scripts\utility::issp())
	{
		soundscripts\_audio_mix_manager::mm_add_submix("sp_common_global_mix");
	}
}

//Function Number: 5
init_ambient_explosion_arrays()
{
	if(level.currentgen)
	{
		level._snd.ambientexp["exp_generic_explo_shot"] = [["exp_generic_explo_shot_04",0.17],["exp_generic_explo_shot_07",0.11],["exp_generic_explo_shot_10",0.22],["exp_generic_explo_shot_12",0.15],["exp_generic_explo_shot_13",0.08],["exp_generic_explo_shot_20",0.15],["exp_generic_explo_shot_22",0.25]];
		return;
	}

	level._snd.ambientexp["exp_generic_explo_shot"] = [["exp_generic_explo_shot_01",0.13],["exp_generic_explo_shot_02",0.25],["exp_generic_explo_shot_03",0.12],["exp_generic_explo_shot_04",0.17],["exp_generic_explo_shot_05",0.16],["exp_generic_explo_shot_06",0.14],["exp_generic_explo_shot_07",0.11],["exp_generic_explo_shot_08",0.21],["exp_generic_explo_shot_09",0.16],["exp_generic_explo_shot_10",0.22],["exp_generic_explo_shot_11",0.13],["exp_generic_explo_shot_12",0.15],["exp_generic_explo_shot_13",0.08],["exp_generic_explo_shot_14",0.16],["exp_generic_explo_shot_16",0.2],["exp_generic_explo_shot_17",0.1],["exp_generic_explo_shot_18",0.08],["exp_generic_explo_shot_19",0.12],["exp_generic_explo_shot_20",0.15],["exp_generic_explo_shot_21",0.15],["exp_generic_explo_shot_22",0.25]];
}

//Function Number: 6
init_impact_system_arrays()
{
	level._snd.veh_collision.surfaces = ["vehicle","wood","metal"];
}

//Function Number: 7
init_boost_land_arrays()
{
	level._snd.boost_jump.surfaces = ["ice","asphalt","concrete","metal","metal_solid"];
}

//Function Number: 8
register_common_snd_messages()
{
	soundscripts\_snd::snd_register_message("player_death",::player_death);
	soundscripts\_snd::snd_register_message("friendly_fire_mission_failed",::friendly_fire_mission_failed);
	soundscripts\_snd::snd_register_message("end_mission_fade_to_black",::end_mission_fade_to_black);
	soundscripts\_snd::snd_register_message("wpn_deam160_init",::wpn_deam160_init);
	soundscripts\_snd::snd_register_message("wpn_deam160_charge",::wpn_deam160_charge);
	soundscripts\_snd::snd_register_message("wpn_deam160_charge_dots_increase",::wpn_deam160_charge_dots_increase);
	soundscripts\_snd::snd_register_message("wpn_deam160_full_charge",::wpn_deam160_full_charge);
	soundscripts\_snd::snd_register_message("wpn_deam160_shot",::wpn_deam160_shot);
	soundscripts\_snd::snd_register_message("variable_grenade_type_switch",::variable_grenade_type_switch);
	soundscripts\_snd::snd_register_message("paint_grenade_detonate",::paint_grenade_detonate);
	soundscripts\_snd::snd_register_message("emp_grenade_detonate",::emp_grenade_detonate);
	soundscripts\_snd::snd_register_message("smart_grenade_detonate",::smart_grenade_detonate);
	soundscripts\_snd::snd_register_message("foam_grenade",::foam_grenade);
	soundscripts\_snd::snd_register_message("aud_sonar_vision_on",::aud_sonar_vision_on);
	soundscripts\_snd::snd_register_message("aud_sonar_vision_off",::aud_sonar_vision_off);
	soundscripts\_snd::snd_register_message("explo_ambientExp_dirt",::explo_ambientexp_dirt);
	soundscripts\_snd::snd_register_message("explo_ambientExp_fireball",::explo_ambientexp_fireball);
	soundscripts\_snd::snd_register_message("play_vehicle_collision",::snd_play_vehicle_collision);
	soundscripts\_snd::snd_register_message("start_vehicle_shell_shock",::start_vehicle_shell_shock);
	soundscripts\_snd::snd_register_message("aud_radiation_shellshock",::aud_radiation_shellshock);
	soundscripts\_snd::snd_register_message("boost_jump_enable",::boost_jump_enable);
	soundscripts\_snd::snd_register_message("boost_jump_disable",::boost_jump_disable);
	soundscripts\_snd::snd_register_message("boost_jump_disable_npc",::boost_jump_disable_npc);
	soundscripts\_snd::snd_register_message("boost_jump_player",::boost_jump_player);
	soundscripts\_snd::snd_register_message("boost_land_player",::boost_land_player);
	soundscripts\_snd::snd_register_message("boost_jump_npc",::boost_jump_npc);
	soundscripts\_snd::snd_register_message("boost_land_npc",::boost_land_npc);
	soundscripts\_snd::snd_register_message("pdrone_death_explode",::pdrone_death_explode);
	soundscripts\_snd::snd_register_message("pdrone_emp_death",::pdrone_emp_death);
	soundscripts\_snd::snd_register_message("pdrone_crash_land",::pdrone_crash_land);
	soundscripts\_snd::snd_register_message("doorshield_ripoff",::doorshield_ripoff);
	soundscripts\_snd::snd_register_message("doorshield_throw",::doorshield_throw);
	soundscripts\_snd::snd_register_message("exo_raise_shield",::exo_raise_shield);
	soundscripts\_snd::snd_register_message("exo_lower_shield",::exo_lower_shield);
	soundscripts\_snd::snd_register_message("snd_cloak_init",::snd_cloak_init);
	soundscripts\_snd::snd_register_message("exo_cloak_button_press",::exo_cloak_button_press);
	soundscripts\_snd::snd_register_message("exo_cloak_enable",::exo_cloak_enable);
	soundscripts\_snd::snd_register_message("exo_cloak_disable",::exo_cloak_disable);
	soundscripts\_snd::snd_register_message("exo_cloak_battery_low",::exo_cloak_battery_low);
	soundscripts\_snd::snd_register_message("exo_cloak_battery_dead",::exo_cloak_battery_dead);
	soundscripts\_snd::snd_register_message("exo_cloak_battery_recharge",::exo_cloak_battery_recharge);
	soundscripts\_snd::snd_register_message("npc_cloak_buttons",::npc_cloak_buttons);
	soundscripts\_snd::snd_register_message("npc_cloak_enable",::npc_cloak_enable);
	soundscripts\_snd::snd_register_message("npc_cloak_disable",::npc_cloak_enable);
	soundscripts\_snd::snd_register_message("overdrive_on",::overdrive_on);
	soundscripts\_snd::snd_register_message("overdrive_off",::overdrive_off);
	soundscripts\_snd::snd_register_message("sonic_blast",::sonic_blast);
	soundscripts\_snd::snd_register_message("sonic_blast_aftershock",::sonic_blast_aftershock);
	soundscripts\_snd::snd_register_message("sonic_blast_done",::sonic_blast_done);
	soundscripts\_snd::snd_register_message("exo_stim_on",::exo_stim_on);
	soundscripts\_snd::snd_register_message("boost_dodge_activate_plr",::boost_dodge_activate_plr);
	soundscripts\_snd::snd_register_message("boost_land_hud_enable",::boost_land_hud_enable);
	soundscripts\_snd::snd_register_message("boost_land_hud_disable",::boost_land_hud_disable);
	soundscripts\_snd::snd_register_message("boost_land_out_of_fuel",::boost_land_out_of_fuel);
	soundscripts\_snd::snd_register_message("boost_land_use_fuel",::boost_land_use_fuel);
	soundscripts\_snd::snd_register_message("boost_land_assist_npc",::boost_land_assist_npc);
	soundscripts\_snd::snd_register_message("boost_land_assist_npc_ground",::boost_land_assist_npc_ground);
	soundscripts\_snd::snd_register_message("tracking_grenade_hover",::tracking_grenade_hover);
	soundscripts\_snd::snd_register_message("tracking_grenade_jump",::tracking_grenade_jump);
	soundscripts\_snd::snd_register_message("tracking_grenade_strike",::tracking_grenade_strike);
	soundscripts\_snd::snd_register_message("tracking_grenade_dud",::tracking_grenade_dud);
	soundscripts\_snd::snd_register_message("tracking_grenade_beep",::tracking_grenade_beep);
	soundscripts\_snd::snd_register_message("anml_doberman",::anml_doberman);
	soundscripts\_snd::snd_register_message("finish_mission_fade",::finish_mission_fade);
	soundscripts\_snd::snd_register_message("aud_start_ragtime_warfare",::aud_start_ragtime_warfare);
	soundscripts\_snd::snd_register_message("aud_stop_ragtime_warfare",::aud_stop_ragtime_warfare);
}

//Function Number: 9
player_death()
{
	level notify("kill_deaths_door_audio");
	soundscripts\_audio_mix_manager::mm_clear_submix("deaths_door");
	soundscripts\_audio_mix_manager::mm_add_submix("player_dead");
	soundscripts\_snd_playsound::snd_play_2d("bullet_large_fatal");
}

//Function Number: 10
friendly_fire_mission_failed()
{
	if(!isdefined(level.ff_mission_failed_already_playing) && common_scripts\utility::issp())
	{
		soundscripts\_audio_mix_manager::mm_add_submix("friendly_fire_failed_mix");
		soundscripts\_snd_playsound::snd_play_2d("friendly_fire_mission_failed");
		level.ff_mission_failed_already_playing = 1;
	}
}

//Function Number: 11
end_mission_fade_to_black()
{
	if(common_scripts\utility::issp())
	{
		soundscripts\_audio_mix_manager::mm_add_submix("fade_to_black_end_mix");
	}
}

//Function Number: 12
wpn_deam160_init()
{
	level.wpn_deam160_aud_charges = 0;
}

//Function Number: 13
wpn_deam160_shot(param_00)
{
	var_01 = param_00;
	level.wpn_deam160_aud_charges = 0;
	switch(var_01)
	{
		case "large":
			break;

		case "medium":
			break;

		case "small":
			break;
	}
}

//Function Number: 14
wpn_deam160_charge(param_00)
{
	var_01 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_charge_hi",level.player,"oneshot");
	thread wpn_deam160_play_charge_loop_sfx();
	level.player thread wpn_deam160_watch_weapon_change();
	level.player thread wpn_deam160_is_chargeable();
	level waittill("aud_deam160_charge_break");
	if(isdefined(var_01))
	{
		var_01 scalevolume(0,0.05);
	}
}

//Function Number: 15
wpn_deam160_watch_weapon_change()
{
	level endon("aud_deam160_charge_break");
	for(;;)
	{
		if(self isthrowinggrenade() || self isreloading() || self ismeleeing() || self ismantling())
		{
			level notify("aud_deam160_charge_break");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 16
wpn_deam160_is_chargeable()
{
	level endon("aud_deam160_charge_break");
	for(;;)
	{
		var_00 = weaponischargeable(self getcurrentweapon());
		if(!var_00)
		{
			level notify("aud_deam160_charge_break");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 17
wpn_deam160_play_charge_loop_sfx()
{
	level endon("aud_deam160_charge_break");
	var_00 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_charge_hi_lp",level.player,"loop","aud_deam160_charge_break");
	var_00 scalevolume(0,0.05);
	wait(2);
	if(isdefined(var_00))
	{
		var_00 scalevolume(1,0.4);
	}
}

//Function Number: 18
wpn_deam160_charge_dots_increase(param_00)
{
	level.wpn_deam160_aud_charges++;
}

//Function Number: 19
wpn_deam160_full_charge()
{
	var_00 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_full_charge_beep_lp",level.player,"loop","aud_deam160_charge_break");
	level waittill("aud_deam160_charge_break");
}

//Function Number: 20
variable_grenade_type_switch(param_00)
{
	level.aud_var_nade_type = param_00;
	soundscripts\_snd_playsound::snd_play_2d("var_grenade_change_type");
}

//Function Number: 21
paint_grenade_detonate()
{
	var_00 = self;
	soundscripts\_snd_playsound::snd_play_at("wpn_paint_grenade_exp",var_00.origin);
}

//Function Number: 22
emp_grenade_detonate()
{
	var_00 = self;
	soundscripts\_snd_playsound::snd_play_at("wpn_emp_grenade_exp",var_00.origin);
}

//Function Number: 23
smart_grenade_detonate()
{
	level notify("kill_tracking_loop");
	var_00 = self;
	soundscripts\_snd_playsound::snd_play_at("wpn_smart_grenade_exp",var_00.origin);
}

//Function Number: 24
foam_grenade(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("foam_grenade_mix",0.5);
	var_01 = self.origin;
	wait(2.1);
	soundscripts\_audio::deprecated_aud_play_linked_sound("foam_bomb_equip",param_00);
	wait(1.1);
	soundscripts\_audio::deprecated_aud_play_linked_sound("foam_bomb_pin_pull",param_00);
	wait(1.3);
	soundscripts\_audio::deprecated_aud_play_sound_at("foam_bomb_wall_stick",var_01);
	level waittill("vfx_foam_corridor_explode_start");
	soundscripts\_audio::deprecated_aud_play_sound_at("foam_bomb_corridor_exp",var_01);
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("foam_grenade_mix",0.5);
}

//Function Number: 25
aud_microwave_grenade()
{
	var_00 = self.origin;
	thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_exp",var_00);
	var_01 = thread soundscripts\_snd_playsound::snd_play_loop_at("wpn_mw_grenade_pulse_sweeps_lp",var_00,"mw_nade_death",0.2,0.45);
	var_02 = thread soundscripts\_snd_playsound::snd_play_loop_at("wpn_mw_grenade_pulse_big_lp",var_00,"mw_nade_death",0.2,0.45);
	self waittill("death");
	thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_die",var_00);
	if(isdefined(var_02))
	{
		var_02 scalevolume(0,0.3);
	}

	if(isdefined(var_01))
	{
		var_01 scalevolume(0,0.3);
	}

	wait(0.3);
	if(isdefined(var_02))
	{
		var_02 stopsounds();
	}

	if(isdefined(var_01))
	{
		var_01 stopsounds();
	}
}

//Function Number: 26
aud_microwave_grenade_sparks_env(param_00)
{
	if(isdefined(param_00))
	{
		thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_elect",param_00);
	}
}

//Function Number: 27
aud_microwave_grenade_sparks_dude(param_00)
{
	if(isdefined(param_00))
	{
		param_00 thread soundscripts\_snd_playsound::snd_play_linked("wpn_mw_grenade_elect");
	}
}

//Function Number: 28
snd_ads_mix()
{
	level.player endon("death");
	for(;;)
	{
		while(!level.player maps\_utility::isads())
		{
			wait(0.05);
		}

		if(weaponclass(level.player getcurrentweapon()) == "sniper")
		{
			soundscripts\_audio_mix_manager::mm_add_submix("sniper_ads_mix");
		}
		else
		{
			soundscripts\_audio_mix_manager::mm_add_submix("ads_mix");
		}

		while(level.player maps\_utility::isads())
		{
			wait(0.05);
		}

		soundscripts\_audio_mix_manager::mm_clear_submix("ads_mix");
		soundscripts\_audio_mix_manager::mm_clear_submix("sniper_ads_mix");
	}
}

//Function Number: 29
snd_mute_device(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	thread sndx_mute_device_bubble_fx();
	thread sndx_mute_device_bubble_off_fx();
	if(!isdefined(self.aud))
	{
		self.aud = spawnstruct();
	}

	self.aud.mute_device_mix_enable = 1;
	self.aud.mute_device_in_bubble = 1;
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}
	else
	{
		var_06 = param_02 + 250;
	}

	level.mute_device_active = 1;
	if(isdefined(param_04))
	{
		self.aud.mute_device_filter = 1;
		thread soundscripts\_snd_filters::snd_fade_in_filter(param_04,0.5);
	}

	var_07 = 0;
	thread sndx_mute_device_stopper(param_00,param_03,var_07);
	while(isdefined(self.aud.mute_device_mix_enable))
	{
		var_08 = distance(self.origin,level.player.origin);
		if(var_08 < param_01)
		{
			if(!isdefined(self.aud.mute_device_start))
			{
				self notify("mute_device_bubble_enter");
				soundscripts\_audio_mix_manager::mm_add_submix(param_00,0.05);
				self.aud.loop_ent = soundscripts\_snd_playsound::snd_play_loop_2d("mute_device_active_lp","stop_mute_device_lp",5,3,1);
				self.aud.mute_device_start = 1;
			}

			soundscripts\_audio_mix_manager::mm_blend_submix(param_00,1);
			if(!isdefined(self.aud.mute_device_filter) && isdefined(param_04))
			{
				self.aud.mute_device_filter = 1;
				thread soundscripts\_snd_filters::snd_fade_in_filter(param_04,0.5);
				if(!isdefined(self.aud.mute_device_enter))
				{
					self notify("mute_device_bubble_enter");
					soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_enter",0.05);
					self.aud.mute_device_in_bubble = 1;
					thread sndx_mute_device_wait_to_play(self.aud.mute_device_enter);
					self.aud.loop_ent scalevolume(1,2);
				}
			}

			continue;
		}

		if(var_08 < var_06 && self.aud.mute_device_start == 1)
		{
			var_09 = var_08 - param_01 / var_06 - param_01;
			clamp(var_09,0,1);
			var_0A = soundscripts\_snd::snd_map(var_09,level._snd.envs["aud_mute_device_falloff"]);
			soundscripts\_audio_mix_manager::mm_blend_submix(param_00,var_0A);
			if(isdefined(self.aud.mute_device_filter))
			{
				self.aud.mute_device_filter = undefined;
				thread soundscripts\_snd_filters::snd_fade_out_filter(1);
				if(!isdefined(self.aud.mute_device_exit))
				{
					thread sndx_mute_device_delay_notify("mute_device_bubble_exit",0.5);
					soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_exit",0.05);
					self.aud.mute_device_in_bubble = 0;
					thread sndx_mute_device_wait_to_play(self.aud.mute_device_exit);
					self.aud.loop_ent scalevolume(0,2);
				}
			}

			continue;
		}

		if(self.aud.mute_device_start == 1)
		{
			soundscripts\_audio_mix_manager::mm_blend_submix(param_00,0);
			if(isdefined(self.aud.mute_device_filter))
			{
				wait(0.05);
				self.aud.mute_device_filter = undefined;
				thread soundscripts\_snd_filters::snd_fade_out_filter(1);
				self.aud.loop_ent scalevolume(0,2);
			}
		}

		wait(0.05);
	}

	level.mute_device_active = 0;
}

//Function Number: 30
sndx_mute_device_delay_notify(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	wait(var_02);
	self notify(param_00);
}

//Function Number: 31
sndx_mute_device_stopper(param_00,param_01,param_02)
{
	self endon("death");
	self endon("turn_off");
	thread sndx_mute_device_kill(param_00,"death");
	thread sndx_mute_device_kill(param_00,"turn_off");
	var_03 = 30;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	wait(var_03);
	self notify("complete");
	thread sndx_mute_device_stop(param_00);
}

//Function Number: 32
sndx_mute_device_stop(param_00)
{
	if(isdefined(self.aud.loop_ent))
	{
		level notify("stop_mute_device_lp");
	}

	if(self.aud.mute_device_in_bubble)
	{
		thread sndx_mute_device_delay_notify("mute_device_bubble_exit",0.5);
		thread sndx_mute_device_delay_notify("mute_device_bubble_off",1);
		if(!isdefined(self.aud.mute_device_exit))
		{
			soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_exit",0.05);
		}
	}

	self.aud.mute_device_mix_enable = undefined;
	soundscripts\_audio_mix_manager::mm_clear_submix(param_00,3);
	self.aud.mute_device_filter = undefined;
	soundscripts\_snd_filters::snd_fade_out_filter(3);
}

//Function Number: 33
sndx_mute_device_kill(param_00,param_01)
{
	self endon("complete");
	var_02 = "death";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self waittill(var_02);
	thread sndx_mute_device_stop(param_00);
	self notify("complete");
}

//Function Number: 34
sndx_mute_device_wait_to_play(param_00)
{
	param_00 = 1;
	wait(2);
	param_00 = undefined;
}

//Function Number: 35
sndx_mute_device_debug_timer(param_00)
{
	self endon("death");
	var_01 = param_00;
}

//Function Number: 36
sndx_mute_device_bubble_fx()
{
	self endon("mute_device_bubble_off");
	while(isdefined(self))
	{
		self waittill("mute_device_bubble_enter");
		playfxontag_safe("mute_breach_distort_vm_enter");
		self waittill("mute_device_bubble_exit");
		killfxontag_safe("mute_breach_distort_vm_enter");
		playfxontag_safe("mute_breach_distort_vm_exit");
		wait(0.05);
	}
}

//Function Number: 37
sndx_mute_device_bubble_off_fx()
{
	while(isdefined(self))
	{
		self waittill("mute_device_bubble_off");
		wait(0.05);
	}
}

//Function Number: 38
playfxontag_safe(param_00)
{
	if(isdefined(self) && isdefined(level._effect[param_00]))
	{
		playfxontag(common_scripts\utility::getfx(param_00),self,"tag_origin");
	}
}

//Function Number: 39
killfxontag_safe(param_00)
{
	if(isdefined(self) && isdefined(level._effect[param_00]))
	{
		killfxontag(common_scripts\utility::getfx(param_00),self,"tag_origin");
	}
}

//Function Number: 40
aud_sonar_vision_on()
{
	soundscripts\_audio_mix_manager::mm_add_submix("sonar_vision",0.05);
	soundscripts\_audio::deprecated_aud_play_2d_sound("sonar_vision_on");
}

//Function Number: 41
aud_sonar_vision_off()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("sonar_vision_off");
	soundscripts\_audio_mix_manager::mm_clear_submix("sonar_vision",1);
}

//Function Number: 42
pdrone_death_explode()
{
	var_00 = self;
	var_01 = var_00.origin;
	while(isdefined(var_00))
	{
		var_01 = var_00.origin;
		wait(0.05);
	}

	soundscripts\_snd_playsound::snd_play_at("pdrone_exp",var_01);
}

//Function Number: 43
pdrone_emp_death(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("pdrone_emp_death");
	param_00 soundscripts\_snd_playsound::snd_play_linked("pdrone_deathspin","kill_drone_deathspin");
}

//Function Number: 44
pdrone_crash_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("pdrone_exp",param_00);
	level notify("kill_drone_deathspin");
}

//Function Number: 45
doorshield_ripoff()
{
	snd_enable_soundcontextoverride("bullet_metal_vehicle");
	soundscripts\_audio_mix_manager::mm_add_submix("doorshield_rip_player");
	soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_foley_plr",0.15);
	soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_grabs_plr",0.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_tension_plr",0.85);
	soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_rip_plr",1.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_debris_plr",1.15);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("doorshield_rip_player");
}

//Function Number: 46
doorshield_throw()
{
	soundscripts\_snd_playsound::snd_play_2d("exo_throw_start");
	snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

//Function Number: 47
exo_raise_shield()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("exo_shield_open",0.5);
	snd_enable_soundcontextoverride("bullet_metal_vehicle");
}

//Function Number: 48
exo_lower_shield()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("exo_shield_close",0.05);
	snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

//Function Number: 49
boost_jump_enable()
{
}

//Function Number: 50
boost_jump_disable()
{
}

//Function Number: 51
boost_jump_disable_npc(param_00)
{
	var_01 = param_00;
	soundscripts\_audio::deprecated_aud_play_linked_sound("tac_npc_boost_power_dwn",var_01);
}

//Function Number: 52
boost_jump_player()
{
	if(!isdefined(level._snd.boost_jump))
	{
		level._snd.boost_jump = spawnstruct();
		level._snd.boost_jump.is_jumping = 0;
		thread init_boost_land_arrays();
	}

	var_00 = self;
	if(var_00 == level.player)
	{
		level._snd.boost_jump.is_jumping = 1;
	}
}

//Function Number: 53
boost_land_player(param_00)
{
	var_01 = 40;
	var_02 = 10;
	if(!isdefined(level._snd.boost_jump))
	{
		level._snd.boost_jump = spawnstruct();
		level._snd.boost_jump.is_jumping = 0;
		thread init_boost_land_arrays();
	}

	var_03 = self;
	if(var_03 == level.player)
	{
		if(level._snd.boost_jump.is_jumping == 1)
		{
			var_04 = sndx_boost_land_get_impact_vol(param_00,var_01,var_02);
			var_05 = sndx_boost_land_get_impact_size(param_00,var_01,var_02);
			var_06 = "pc_boost_land_" + var_05;
			level._snd.boost_jump.is_jumping = 0;
			if(isdefined(level._snd.boost_jump.jump_sound))
			{
				soundscripts\_audio::aud_fade_out_and_delete(level._snd.boost_jump.jump_sound,0.5);
			}

			if(param_00 < var_02)
			{
				return;
			}

			var_07 = playerphysicstraceinfo(var_03.origin + (0,0,16),var_03.origin + (0,0,-16),var_03)["surfacetype"];
			var_08 = snd_is_valid_surface(var_07,level._snd.boost_jump.surfaces);
			if(var_08)
			{
				var_09 = "boost_land_surface_" + var_05 + "_" + var_07;
				return;
			}
		}
	}
}

//Function Number: 54
sndx_boost_land_get_impact_vol(param_00,param_01,param_02)
{
	param_00 = clamp(param_00,param_02,param_01);
	var_03 = param_00 / param_01;
	return var_03;
}

//Function Number: 55
sndx_boost_land_get_impact_size(param_00,param_01,param_02)
{
	if(param_00 <= param_02)
	{
		var_03 = "lt";
	}
	else if(param_01 <= param_02)
	{
		var_03 = "med";
	}
	else
	{
		var_03 = "hvy";
	}

	return var_03;
}

//Function Number: 56
boost_jump_npc()
{
	var_00 = self;
	if(level.script == "recovery")
	{
		soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_jump_rec",var_00);
		return;
	}

	soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_jump",var_00);
}

//Function Number: 57
boost_land_npc()
{
	var_00 = self;
	if(level.script == "recovery")
	{
		soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_land_med_rec",var_00);
		return;
	}

	soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_land_med",var_00);
}

//Function Number: 58
boost_dodge_activate_plr()
{
	level._snd.boost_jump.is_jumping = 0;
	if(isdefined(level._snd.boost_jump.jump_sound))
	{
		soundscripts\_audio::aud_fade_out_and_delete(level._snd.boost_jump.jump_sound,0.5);
	}
}

//Function Number: 59
boost_land_hud_enable()
{
	soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_pwrup");
}

//Function Number: 60
boost_land_hud_disable()
{
	soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_pwrdown");
}

//Function Number: 61
boost_land_use_fuel(param_00)
{
	var_01 = 0.5;
	if(!isdefined(level.aud.boost_land_on))
	{
		level.aud.boost_land_on = 1;
		thread boost_land_play_oneshot();
		level.player soundscripts\_snd_playsound::snd_play_loop_linked("tac_pc_boost_land_assist_jet_lp",param_00,0.1,0.2);
		level waittill(param_00);
		var_02 = getlevelticks();
		if(!isdefined(level.aud.boost_land_release_start_time))
		{
			level.aud.boost_land_release_start_time = var_02;
			soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_release");
		}
		else if(var_02 - level.aud.boost_land_release_start_time >= var_01 / 0.05)
		{
			level.aud.boost_land_release_start_time = var_02;
			soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_release");
		}

		level.aud.boost_land_on = undefined;
	}
}

//Function Number: 62
boost_land_velocity_finder()
{
	for(;;)
	{
		var_00 = length(level.player getvelocity());
		iprintlnbold(var_00);
		wait(0.05);
	}
}

//Function Number: 63
boost_land_play_oneshot()
{
	var_00 = 1000;
	var_01 = 7500;
	var_02 = 500;
	if(!isdefined(level.aud.boost_land_first_shot))
	{
		level.aud.boost_land_first_shot = 1;
	}

	if(!isdefined(level.aud.boost_land_max_locked_out))
	{
		level.aud.boost_land_max_locked_out = 0;
	}

	var_03 = length(level.player getvelocity());
	if(var_03 >= var_00 || level.aud.boost_land_first_shot == 1)
	{
		if(level.aud.boost_land_max_locked_out == 0)
		{
			thread boost_land_max_shot_timer();
			soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_max");
			level.aud.boost_land_first_shot = 0;
			return;
		}

		if(level.aud.boost_land_max_locked_out == 1)
		{
			soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_sml");
			return;
		}

		return;
	}

	if(var_03 < var_00 && var_03 >= var_02)
	{
		soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_med");
		return;
	}

	if(var_03 < var_01)
	{
		soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_sml");
		return;
	}
}

//Function Number: 64
boost_land_max_shot_timer()
{
	var_00 = 4;
	if(!isdefined(level.aud.boost_land_max_shot_timer))
	{
		level.aud.boost_land_max_shot_timer = 0;
	}

	for(;;)
	{
		level.aud.boost_land_max_shot_timer = level.aud.boost_land_max_shot_timer + 0.1;
		level.aud.boost_land_max_locked_out = 1;
		wait(0.1);
		if(level.aud.boost_land_max_shot_timer > var_00)
		{
			level.aud.boost_land_max_shot_timer = 0;
			level.aud.boost_land_max_locked_out = 0;
			break;
		}
	}
}

//Function Number: 65
boost_land_release_shot_timer()
{
	var_00 = 0.1;
	if(!isdefined(level.aud.boost_land_release_shot_timer))
	{
		level.aud.boost_land_release_shot_timer = 0;
	}

	for(;;)
	{
		level.aud.boost_land_release_shot_timer = level.aud.boost_land_release_shot_timer + 0.1;
		level.aud.boost_land_release_locked_out = 1;
		wait(0.1);
		if(level.aud.boost_land_release_shot_timer > var_00)
		{
			level.aud.boost_land_release_shot_timer = 0;
			level.aud.boost_land_release_locked_out = 0;
			break;
		}
	}
}

//Function Number: 66
boost_land_assist_npc()
{
	soundscripts\_snd_playsound::snd_play_linked("boost_land_assist_npc");
}

//Function Number: 67
boost_land_assist_npc_ground()
{
	soundscripts\_snd_playsound::snd_play_linked("boost_land_assist_npc_ground");
}

//Function Number: 68
boost_land_out_of_fuel()
{
}

//Function Number: 69
tracking_grenade_hover(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("track_grenade_hover","kill_tracking_loop");
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("track_grenade_loop","kill_tracking_loop",undefined,1.2);
	param_00 waittill("death");
	level notify("kill_tracking_loop");
}

//Function Number: 70
tracking_grenade_jump(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("track_grenade_jump");
}

//Function Number: 71
tracking_grenade_strike(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("track_grenade_strike");
	param_00 notify("kill_tracking_loop");
}

//Function Number: 72
tracking_grenade_dud(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("track_grenade_dud");
	level notify("kill_tracking_loop");
}

//Function Number: 73
tracking_grenade_beep(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("track_grenade_beep");
}

//Function Number: 74
anml_doberman(param_00)
{
	var_01 = "anml_doberman_" + param_00;
	if(isdefined(self.snd_guid))
	{
		level notify(self.snd_guid);
	}

	self.snd_guid = "anml_doberman_" + soundscripts\_snd::snd_new_guid();
	if(param_00 == "death")
	{
		soundscripts\_snd_playsound::snd_play_at(var_01,self.origin,self.snd_guid,0,0.1);
		return;
	}

	soundscripts\_snd_playsound::snd_play_linked(var_01,self.snd_guid,0,0.15);
}

//Function Number: 75
finish_mission_fade(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("mute_all",param_00);
}

//Function Number: 76
snd_cloak_init()
{
	common_scripts\utility::flag_init("snd_cloak_is_enabled");
}

//Function Number: 77
exo_cloak_button_press()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("exo_cloak_buttons");
}

//Function Number: 78
exo_cloak_enable()
{
	if(!common_scripts\utility::flag("snd_cloak_is_enabled"))
	{
		common_scripts\utility::flag_set("snd_cloak_is_enabled");
		soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable_click",level.player);
		soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable",level.player);
		soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_enable_wide",0.4);
	}

	thread exo_cloak_battery_low();
}

//Function Number: 79
exo_cloak_disable()
{
	common_scripts\utility::flag_clear("snd_cloak_is_enabled");
	soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable_click",level.player);
	soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_disable",level.player);
	soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_disable_wide",0.2);
	wait(1);
	thread exo_cloak_battery_recharge();
}

//Function Number: 80
exo_cloak_battery_low()
{
	level notify("kill_exo_cloak_battery_low");
	level endon("kill_exo_cloak_battery_low");
	var_00 = level._cloaked_stealth_settings.cloak_battery_level;
	var_01 = undefined;
	while(common_scripts\utility::flag("snd_cloak_is_enabled"))
	{
		var_02 = level._cloaked_stealth_settings.cloak_battery_level;
		if(var_02 <= 0.26 && var_00 > 0.26)
		{
			var_01 = soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_battery_low",level.player,"loop","notify_stop_exo_cloak_battery_low");
		}
		else if(var_02 >= 0.26 && var_00 < 0.26)
		{
			level notify("notify_stop_exo_cloak_battery_low");
		}

		var_00 = var_02;
		wait(0.05);
	}

	if(isdefined(var_01))
	{
		var_01 scalevolume(0,0.25);
		wait(0.25);
		level notify("notify_stop_exo_cloak_battery_low");
	}
}

//Function Number: 81
exo_cloak_battery_dead()
{
	common_scripts\utility::flag_clear("snd_cloak_is_enabled");
	soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_disable",level.player);
	soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_battery_dead",0.25);
	wait(3);
	thread exo_cloak_battery_recharge();
}

//Function Number: 82
exo_cloak_battery_recharge()
{
	var_00 = soundscripts\_audio::deprecated_aud_play_2d_sound("exo_cloak_battery_recharge");
	while(level._cloaked_stealth_settings.cloak_battery_level < 1 && !common_scripts\utility::flag("snd_cloak_is_enabled"))
	{
		wait(0.1);
	}

	if(isdefined(var_00))
	{
		var_00 scalevolume(0,0.25);
	}
}

//Function Number: 83
npc_cloak_buttons(param_00)
{
	var_01 = self;
	if(param_00 == "cornercrouch_right_cloak_toggle")
	{
		soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,1);
		soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,6.5);
		return;
	}

	if(param_00 == "cornercrouch_left_cloak_toggle")
	{
		soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,1);
		soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,6.75);
		return;
	}

	soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,1.2);
	soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons",var_01,6.4);
}

//Function Number: 84
npc_cloak_enable()
{
	var_00 = self;
	var_01 = gettime();
	if(var_01 > 1000)
	{
	}
}

//Function Number: 85
overdrive_on()
{
	level.player method_850D();
	snd_enable_soundcontextoverride("slomo");
	soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
	level.player setreverb("snd_enveffectsprio_level","sewer",1,0.7,1);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
	soundscripts\_snd_filters::snd_fade_in_filter("overdrive",1);
	soundscripts\_audio_mix_manager::mm_add_submix("overdrive",1);
	soundscripts\_snd_timescale::snd_set_timescale("overdrive_timescale");
	soundscripts\_snd_playsound::snd_play_2d("overdrive_start",undefined,undefined,0.25);
	soundscripts\_snd_playsound::snd_play_loop_2d("overdrive_loop","kill_overdrive_loop",1,2);
	level.player waittill("death");
	soundscripts\_audio_mix_manager::mm_clear_submix("overdrive",2.5);
	level notify("kill_overdrive_loop");
}

//Function Number: 86
overdrive_off()
{
	soundscripts\_snd_playsound::snd_play_2d("overdrive_stop");
	level notify("kill_overdrive_loop");
	soundscripts\_audio_mix_manager::mm_clear_submix("overdrive",2);
	soundscripts\_snd_timescale::snd_set_timescale("default");
	level.player deactivatereverb("snd_enveffectsprio_level",1);
	soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
	soundscripts\_snd_filters::snd_fade_out_filter(2);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
	snd_disable_soundcontextoverride("slomo");
	level.player method_850E();
}

//Function Number: 87
sonic_blast()
{
	level.aud.sonic_blast_started = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("sonic_attack");
	soundscripts\_snd_playsound::snd_play_2d("sonic_attack_shoot");
	soundscripts\_snd_filters::snd_fade_in_filter("sonic_attack",0.25);
	wait(1.5);
	soundscripts\_snd_filters::snd_fade_out_filter(3);
}

//Function Number: 88
sonic_blast_aftershock()
{
	if(isdefined(level.aud.sonic_blast_started) && level.aud.sonic_blast_started == 1)
	{
		level.aud.sonic_blast_started = 0;
		return;
	}

	soundscripts\_snd_playsound::snd_play_2d("sonic_attack_aftershock");
}

//Function Number: 89
sonic_blast_done()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("sonic_attack");
}

//Function Number: 90
exo_stim_on()
{
	soundscripts\_snd_playsound::snd_play_2d("stim_activate");
}

//Function Number: 91
aud_start_ragtime_warfare()
{
	soundscripts\_audio_mix_manager::mm_add_submix("ragtime_warfare_cheat_mix");
	soundsettimescalefactor("music",0);
	level.player thread common_scripts\utility::play_loop_sound_on_entity("cheat_chaplin_music",undefined,undefined,2);
	level.player thread common_scripts\utility::play_loop_sound_on_entity("cheat_chaplin_projector_loop",undefined,undefined,2);
}

//Function Number: 92
aud_stop_ragtime_warfare()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("ragtime_warfare_cheat_mix");
	level.player common_scripts\utility::stop_loop_sound_on_entity("cheat_chaplin_music");
	level.player common_scripts\utility::stop_loop_sound_on_entity("cheat_chaplin_projector_loop");
}

//Function Number: 93
aud_radiation_shellshock(param_00,param_01)
{
	level.player endon("death");
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
	if(level.player.radiation_state != param_00)
	{
		level.player.radiation_state = param_00;
		switch(level.player.radiation_state)
		{
			case "radiation_high":
				break;

			case "radiation_med":
				break;

			case "radiation_low":
				break;

			case "radiation_none":
				break;
		}
	}
}

//Function Number: 94
start_next_radiation_level(param_00,param_01,param_02)
{
	var_03 = 0.5;
	soundscripts\_snd_filters::snd_fade_out_filter(var_03);
	soundscripts\_snd_filters::snd_fade_in_filter(param_00,var_03);
	stop_shellshock_loop();
	level.player thread common_scripts\utility::play_loop_sound_on_entity(param_01);
	level.player playsound(param_02);
}

//Function Number: 95
stop_radiation_level(param_00,param_01)
{
	var_02 = 0.5;
	wait(param_00);
	soundscripts\_snd_filters::snd_fade_out_filter(var_02);
	wait(1);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
	stop_shellshock_loop();
	level.player playsound(param_01);
}

//Function Number: 96
stop_shellshock_loop()
{
	level.player common_scripts\utility::stop_loop_sound_on_entity("item_geigercounter_high");
	level.player common_scripts\utility::stop_loop_sound_on_entity("item_geigercounter_med");
}

//Function Number: 97
explo_ambientexp_dirt(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.pos = param_00;
	var_02.exploder_num_ = param_01;
	var_02.incoming_alias_ = "exp_generic_incoming";
	var_02.speed_of_sound_ = 1;
	var_02.duck_alias_ = "exp_generic_explo_sub_kick";
	var_02.duck_dist_threshold_ = 1000;
	var_02.explo_delay_chance_ = 60;
	var_02.shake_dist_threshold_ = 2000;
	var_02.explo_debris_alias_ = "exp_debris_dirt_chunks";
	var_02.ground_zero_alias_ = "exp_grnd_zero_stone";
	var_02.ground_zero_dist_threshold_ = 500;
	snd_ambient_explosion(var_02);
}

//Function Number: 98
explo_ambientexp_fireball(param_00)
{
	var_01 = spawnstruct();
	var_01.pos = param_00;
	var_01.speed_of_sound_ = 1;
	var_01.duck_alias_ = "exp_generic_explo_sub_kick";
	var_01.duck_dist_threshold_ = 1000;
	var_01.explo_delay_chance_ = 60;
	var_01.shake_dist_threshold_ = 2000;
	var_01.explo_debris_alias_ = "exp_debris_dirt_chunks";
	var_01.ground_zero_alias_ = "exp_grnd_zero_stone";
	var_01.ground_zero_dist_threshold_ = 500;
	snd_ambient_explosion(var_01);
}

//Function Number: 99
snd_air_vehicle_smart_flyby(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	var_06 = 0;
	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	while(isdefined(self))
	{
		if(var_06)
		{
			var_07 = distance(self.origin,level.player.origin);
		}
		else
		{
			var_07 = distance2d(self.origin,level.player.origin);
		}

		if(var_07 < param_01)
		{
			var_08 = spawn("script_origin",self.origin);
			var_08 linkto(self);
			var_08 playsound(param_00,"sounddone");
			var_08 thread sndx_air_vehicle_smart_flyby_deathspin(self,param_04);
			var_08 thread sndx_air_vehicle_smart_flyby_sounddone();
			var_08 waittill("flyby_ent",var_09);
			if(var_09 == "deathspin")
			{
				var_08 scalevolume(0,0.3);
				wait(0.4);
				var_08 stopsounds();
				var_08 delete();
				return;
			}
			else if(var_09 == "sounddone")
			{
				wait(0.1);
				var_08 delete();
				return;
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 100
sndx_air_vehicle_smart_flyby_deathspin(param_00,param_01)
{
	self endon("flyby_ent");
	param_00 waittill("deathspin");
	self notify("flyby_ent","deathspin");
	if(isdefined(param_01))
	{
		var_02 = spawn("script_origin",self.origin);
		var_02 linkto(self);
		var_02 playsound(param_01,"sounddone");
		var_02 waittill("sounddone");
		var_02 delete();
	}
}

//Function Number: 101
sndx_air_vehicle_smart_flyby_sounddone()
{
	self endon("flyby_ent");
	self waittill("sounddone");
	self notify("flyby_ent","sounddone");
}

//Function Number: 102
snd_advanced_flyby_system(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	self endon("death");
	self endon("deathspin");
	self vehicle_turnengineoff();
	if(!isdefined(self.audio))
	{
		self.audio = spawnstruct();
	}

	self.audio.prev_dist = sndx_advanced_flyby_dist_check(param_04);
	self.audio.flying_over = 0;
	self.audio.flying_by = 0;
	self.audio.death_spining = 0;
	self.audio.approaching = 1;
	self.audio.debug_id = param_0A;
	if(isdefined(param_05))
	{
		thread sndx_advanced_flyby_deathspin(param_05,param_0A);
	}

	if(isdefined(param_06))
	{
		var_0C = spawn("script_origin",self.origin);
		var_0C linkto(self);
		thread sndx_advanced_flyby_destruct(var_0C,param_06,param_0A);
	}

	self.audio.min_flyingover_wait = 5;
	if(isdefined(param_07))
	{
		self.audio.min_flyingover_wait = param_07;
	}

	self.audio.min_flyingby_wait = 3;
	if(isdefined(param_08))
	{
		self.audio.min_flyingby_wait = param_08;
	}

	var_0D = 0.05;
	if(isdefined(param_09))
	{
		var_0D = param_09;
	}

	if(isarray(param_01))
	{
		foreach(var_10, var_0F in param_01)
		{
			thread sndx_advanced_flyby_spawn_sound(var_10,var_0F,param_0A);
		}
	}

	if(isarray(param_02))
	{
		while(isdefined(self))
		{
			var_11 = sndx_advanced_flyby_dist_check(param_04);
			for(var_12 = 0;var_12 < param_02.size;var_12++)
			{
				if(var_11 < param_02[var_12])
				{
					if(var_12 == 0)
					{
						if(self.audio.approaching && self.audio.flying_over == 0 && self.audio.death_spining == 0)
						{
							var_13 = sndx_advanced_flyby_construct_alias(param_00,var_12,param_03,param_0A);
							if(isdefined(var_13))
							{
								thread sndx_advanced_flyby_playsound(var_13,var_12);
							}
						}
						else if(var_11 < self.audio.prev_dist)
						{
							self.audio.approaching = 1;
						}
						else
						{
							self.audio.approaching = 0;
						}
					}
					else if(var_11 > self.audio.prev_dist)
					{
						if(self.audio.approaching && self.audio.flying_over == 0 && self.audio.flying_by == 0 && self.audio.death_spining == 0)
						{
							self.audio.approaching = 0;
							var_13 = sndx_advanced_flyby_construct_alias(param_00,var_12,param_03,param_0A);
							if(isdefined(var_13))
							{
								thread sndx_advanced_flyby_playsound(var_13,var_12);
							}
						}
					}
					else
					{
						self.audio.approaching = 1;
					}

					break;
				}
			}

			self.audio.prev_dist = var_11;
			wait(var_0D);
		}
	}
}

//Function Number: 103
sndx_advanced_flyby_spawn_sound(param_00,param_01,param_02)
{
	self endon("death");
	self endon("deathspin");
	wait(param_01);
	thread sndx_advanced_flyby_playsound(param_00);
}

//Function Number: 104
sndx_advanced_flyby_dist_check(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(var_01)
	{
		var_02 = distance(self.origin,level.player.origin);
	}
	else
	{
		var_02 = distance2d(self.origin,level.player.origin);
	}

	return var_02;
}

//Function Number: 105
sndx_advanced_flyby_construct_alias(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = self vehicle_getvelocity();
	var_06 = length(var_05) * 0.05681818;
	if(var_06 > 5)
	{
		if(isarray(param_02))
		{
			var_07 = level.player getvelocity();
			var_08 = var_05 - var_07;
			var_09 = length(var_08) * 0.05681818;
			for(var_0A = 0;var_0A < param_02.size;var_0A++)
			{
				var_04 = var_0A + 1;
				if(var_09 > param_02[var_0A])
				{
					var_04 = var_0A;
					break;
				}
			}
		}

		if(var_04 == 0)
		{
			var_0B = "fast";
		}
		else if(var_05 == 1)
		{
			var_0B = "med";
		}
		else
		{
			var_0B = "slow";
		}

		if(param_01 == 0)
		{
			var_0C = "close";
		}
		else if(param_02 == 1)
		{
			var_0C = "mid";
		}
		else if(param_02 == 2)
		{
			var_0C = "far";
		}
		else
		{
			return undefined;
		}

		var_0D = param_00 + "_" + var_0B + "_" + var_0C;
		if(param_01 == 0)
		{
			self.audio.flying_over = 1;
		}
		else
		{
			self.audio.flying_by = 1;
		}

		return var_0D;
	}

	return undefined;
}

//Function Number: 106
sndx_advanced_flyby_playsound(param_00,param_01)
{
	thread sndx_advanced_flyby_retrigger_wait(param_01);
	var_02 = soundscripts\_audio::deprecated_aud_play_linked_sound(param_00,self);
	thread sndx_advanced_flyby_cleanup(var_02,"deathspin");
}

//Function Number: 107
sndx_advanced_flyby_deathspin(param_00,param_01)
{
	self endon("crash_done");
	self waittill("deathspin");
	var_02 = soundscripts\_audio::deprecated_aud_play_linked_sound(param_00,self);
	thread sndx_advanced_flyby_cleanup(var_02,"crash_done");
}

//Function Number: 108
sndx_advanced_flyby_destruct(param_00,param_01,param_02)
{
	self waittill("crash_done");
	var_03 = spawn("script_origin",param_00.origin);
	var_03 soundscripts\_snd_playsound::snd_play(param_01,"sounddone");
	var_03 waittill("sounddone");
	var_03 delete();
}

//Function Number: 109
sndx_advanced_flyby_retrigger_wait(param_00)
{
	if(isdefined(param_00))
	{
		if(param_00 == 0)
		{
			wait(self.audio.min_flyingover_wait);
			if(isdefined(self))
			{
				self.audio.flying_over = 0;
				return;
			}

			return;
		}

		wait(self.audio.min_flyingby_wait);
		if(isdefined(self))
		{
			self.audio.flying_by = 0;
			return;
		}
	}
}

//Function Number: 110
sndx_advanced_flyby_cleanup(param_00,param_01,param_02)
{
	self waittill(param_01);
	if(isdefined(param_00))
	{
		var_03 = 0.3;
		if(isdefined(param_02))
		{
			var_03 = param_02;
		}

		param_00 scalevolume(0,var_03);
		wait(var_03);
		if(isdefined(param_00))
		{
			param_00 stopsounds();
			wait(0.1);
			if(isdefined(param_00))
			{
				param_00 delete();
				return;
			}
		}
	}
}

//Function Number: 111
snd_ambient_explosion(param_00)
{
	var_01 = sndx_ambient_explosion_args_validation(param_00);
	thread sndx_ambient_explosion_internal(var_01);
}

//Function Number: 112
sndx_ambient_explosion_args_validation(param_00)
{
	if(!isdefined(level._snd.ambientexp))
	{
		init_ambient_explosion_arrays();
	}

	if(!isdefined(param_00.explo_shot_array_))
	{
		param_00.explo_shot_array_ = level._snd.ambientexp["exp_generic_explo_shot"];
		if(!isdefined(param_00.explo_tail_alias_))
		{
			param_00.explo_tail_alias_ = "exp_generic_explo_tail";
		}
	}

	if(isdefined(param_00.duck_alias_))
	{
		if(isdefined(param_00.duck_dist_threshold_))
		{
			param_00.duck_dist_threshold_ = max(param_00.duck_dist_threshold_,0);
		}
		else
		{
			param_00.duck_dist_threshold_ = 1000;
		}
	}

	if(isdefined(param_00.explo_delay_chance_))
	{
		param_00.explo_delay_chance_ = max(param_00.explo_delay_chance_,0);
	}
	else
	{
		param_00.explo_delay_chance_ = 50;
	}

	if(isdefined(param_00.shake_dist_threshold_))
	{
		param_00.shake_dist_threshold_ = max(param_00.shake_dist_threshold_,0);
	}

	if(!isdefined(param_00.shake_envelope_))
	{
		param_00.shake_envelope_ = level._snd.envs["explo_shake_over_distance"];
	}

	if(isdefined(param_00.shake_durration_))
	{
		param_00.shake_durration_ = max(param_00.shake_durration_,0);
	}
	else
	{
		param_00.shake_durration_ = 0.5;
	}

	if(isdefined(param_00.ground_zero_alias_))
	{
		if(isdefined(param_00.ground_zero_dist_threshold_))
		{
			param_00.ground_zero_dist_threshold_ = max(param_00.ground_zero_dist_threshold_,0);
		}
		else
		{
			param_00.ground_zero_dist_threshold_ = 500;
		}
	}

	return param_00;
}

//Function Number: 113
sndx_ambient_explosion_internal(param_00)
{
	var_01 = param_00.pos;
	var_02 = param_00.exploder_num_;
	var_03 = param_00.incoming_alias_;
	var_04 = param_00.speed_of_sound_;
	var_05 = param_00.explo_shot_array_;
	var_06 = param_00.duck_alias_;
	var_07 = param_00.duck_dist_threshold_;
	var_08 = param_00.explo_delay_chance_;
	var_09 = param_00.explo_tail_alias_;
	var_0A = param_00.shake_dist_threshold_;
	var_0B = param_00.shake_envelope_;
	var_0C = param_00.shake_durration_;
	var_0D = param_00.explo_debris_alias_;
	var_0E = param_00.ground_zero_alias_;
	var_0F = param_00.ground_zero_dist_threshold_;
	var_10 = distance(level.player.origin,var_01);
	if(isdefined(var_04) && var_04 == 1)
	{
		var_11 = var_10 * 8.333333E-05;
		wait(var_11);
	}

	if(isdefined(var_02))
	{
		if(isdefined(var_03))
		{
			common_scripts\utility::play_sound_in_space(var_03,var_01);
		}

		common_scripts\_exploder::exploder(var_02);
	}

	var_12 = randomint(var_05.size);
	var_13 = var_05[var_12];
	var_14 = var_13[0];
	thread common_scripts\utility::play_sound_in_space(var_14,var_01);
	if(isdefined(var_06))
	{
		if(var_10 < var_07)
		{
			thread common_scripts\utility::play_sound_in_space(var_06,var_01);
		}
	}

	var_15 = var_13[1];
	if(isdefined(var_15))
	{
		if(soundscripts\_audio::aud_percent_chance(var_08))
		{
			wait(var_15);
		}
	}

	if(isdefined(var_09))
	{
		thread common_scripts\utility::play_sound_in_space(var_09,var_01);
	}

	if(isdefined(var_0A))
	{
		if(var_10 < var_0A)
		{
			var_16 = var_10 / var_0A;
			var_17 = soundscripts\_audio::deprecated_aud_map2(var_16,var_0B);
			earthquake(var_17,var_0C,level.player.origin,var_0A);
		}
	}

	if(isdefined(var_0D))
	{
		thread common_scripts\utility::play_sound_in_space(var_0D,var_01);
	}

	if(isdefined(var_0E) && var_10 < var_0F)
	{
		thread common_scripts\utility::play_sound_in_space(var_0E,var_01);
	}
}

//Function Number: 114
snd_impact(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 + "_" + param_01 + "_" + param_02;
	if(isdefined(param_04))
	{
		var_06 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_05,param_04,undefined,undefined,undefined,undefined,param_03);
	}
	else
	{
		var_06 = soundscripts\_audio::deprecated_aud_play_sound_at(var_06,param_04);
	}

	return var_06;
}

//Function Number: 115
snd_play_vehicle_collision(param_00,param_01,param_02)
{
	var_03 = param_00["vehicle"];
	var_04 = var_03 sndx_vehicle_collision_args_setup(param_00,param_01,param_02);
	var_03 thread sndx_play_vehicle_collision_internal(var_04);
}

//Function Number: 116
start_vehicle_shell_shock(param_00)
{
	level.player endon("death");
	var_01 = 1;
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
	soundscripts\_snd_filters::snd_fade_in_filter("vehicle_shellshock",0.5);
	var_02 = min(0,param_00 - var_01);
	wait(var_02);
	soundscripts\_snd_filters::snd_fade_out_filter(var_01);
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
}

//Function Number: 117
sndx_vehicle_collision_args_setup(param_00,param_01,param_02)
{
	if(!isdefined(self.audio))
	{
		self.audio = spawnstruct();
	}

	if(!isarray(param_01))
	{
		param_01 = [];
	}

	self.audio.debug = soundscripts\_audio::aud_get_optional_param(0,param_01["Debug"]);
	self.audio.vehicleid = soundscripts\_audio::aud_get_optional_param("veh_impact",param_01["VehicleID"]);
	self.audio.pv_minvelocitythreshold = soundscripts\_audio::aud_get_optional_param(25,param_01["PV_MinVelocityThreshold"]);
	self.audio.pv_maxvelocity = soundscripts\_audio::aud_get_optional_param(1000,param_01["PV_MaxVelocity"]);
	self.audio.pv_numvelocityranges = soundscripts\_audio::aud_get_optional_param(3,param_01["PV_NumVelocityRanges"]);
	self.audio.pv_maxsmlvelocity = soundscripts\_audio::aud_get_optional_param(100,param_01["PV_MaxSmlVelocity"]);
	self.audio.pv_maxmedvelocity = soundscripts\_audio::aud_get_optional_param(600,param_01["PV_MaxMedVelocity"]);
	self.audio.pv_maxlrgvelocity = soundscripts\_audio::aud_get_optional_param(1000,param_01["PV_MaxLrgVelocity"]);
	self.audio.npc_minvelocitythreshold = soundscripts\_audio::aud_get_optional_param(25,param_01["NPC_MinVelocityThreshold"]);
	self.audio.npc_maxvelocity = soundscripts\_audio::aud_get_optional_param(800,param_01["NPC_MaxVelocity"]);
	self.audio.npc_numvelocityranges = soundscripts\_audio::aud_get_optional_param(3,param_01["NPC_NumVelocityRanges"]);
	self.audio.npc_maxsmlvelocity = soundscripts\_audio::aud_get_optional_param(100,param_01["NPC_MaxSmlVelocity"]);
	self.audio.npc_maxmedvelocity = soundscripts\_audio::aud_get_optional_param(400,param_01["NPC_MaxMedVelocity"]);
	self.audio.npc_maxlrgvelocity = soundscripts\_audio::aud_get_optional_param(800,param_01["NPC_MaxLrgVelocity"]);
	self.audio.minlfevolumethreshold = soundscripts\_audio::aud_get_optional_param(0,param_01["MinLFEVolumeThreshold"]);
	self.audio.fallvelmultiplier = soundscripts\_audio::aud_get_optional_param(2,param_01["FallVelMultiplier"]);
	self.audio.mintimethreshold = soundscripts\_audio::aud_get_optional_param(250,param_01["MinTimeThreshold"]);
	self.audio.tireskidprobability = soundscripts\_audio::aud_get_optional_param(35,param_01["TireSkidProbability"]);
	self.audio.maxdistancethreshold = soundscripts\_audio::aud_get_optional_param(6000,param_01["MaxDistanceThreshold"]);
	self.audio.medvolmin = soundscripts\_audio::aud_get_optional_param(0.1,param_01["MedVolMin"]);
	self.audio.lrgvolmin = soundscripts\_audio::aud_get_optional_param(0.3,param_01["LrgVolMin"]);
	self.audio.nonplayerimpvolreduction = soundscripts\_audio::aud_get_optional_param(0,param_01["NonPlayerImpVolReduction"]);
	if(!isdefined(self.audio.prev_impacttime))
	{
		self.audio.prev_impacttime = 0;
	}

	if(!isdefined(level._snd.veh_collision))
	{
		level._snd.veh_collision = spawnstruct();
		init_impact_system_arrays();
		level._snd.veh_collision.is_scraping = 0;
		level._snd.veh_collision.scrapeenabled = soundscripts\_audio::aud_get_optional_param(1,param_01["ScrapeEnabled"]);
		level._snd.veh_collision.scrapeseperationtime = soundscripts\_audio::aud_get_optional_param(0.5,param_01["ScrapeSeperationTime"]);
		level._snd.veh_collision.scrapefadeouttime = soundscripts\_audio::aud_get_optional_param(0.5,param_01["ScrapeFadeOutTime"]);
		level._snd.veh_collision.scrapeupdaterate = soundscripts\_audio::aud_get_optional_param(0.05,param_01["ScrapeUpdateRate"]);
	}

	if(param_00["surface"] == "none")
	{
		param_00["surface"] = "vehicle";
	}

	var_03 = level._snd.veh_collision.surfaces;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	if(!snd_is_valid_surface(param_00["surface"],var_03))
	{
		param_00["surface"] = "default";
	}

	return param_00;
}

//Function Number: 118
sndx_play_vehicle_collision_internal(param_00)
{
	var_01 = self;
	var_02 = param_00["hit_entity"];
	var_03 = param_00["pos"];
	var_04 = param_00["impulse"];
	var_05 = param_00["relativeVel"];
	var_06 = param_00["surface"];
	var_07 = (var_05[0],var_05[1],0);
	var_08 = length(var_07);
	var_09 = abs(var_05[2]) * self.audio.fallvelmultiplier;
	var_0A = distance(var_03,level.player.origin);
	var_0B = gettime();
	var_0C = var_0B - self.audio.prev_impacttime;
	var_0D = undefined;
	var_0E = undefined;
	var_0F = 0;
	if(isdefined(level.player.drivingvehicle))
	{
		var_0D = level.player.drivingvehicle;
		if((isdefined(var_02) && var_02 == var_0D) || var_01 == var_0D)
		{
			var_0E = var_0D;
			var_0F = 1;
			if(level._snd.veh_collision.is_scraping)
			{
				thread sndx_vehicle_collision_scrape_timer();
			}
		}
	}

	if(var_0A < self.audio.maxdistancethreshold && var_08 > self.audio.pv_minvelocitythreshold)
	{
		var_08 = clamp(var_08,0,self.audio.pv_maxvelocity);
		var_09 = clamp(var_09,0,self.audio.pv_maxvelocity);
		var_10 = var_08;
		if(var_09 > var_08)
		{
			var_10 = var_09;
		}

		if(var_0F)
		{
			var_11 = sndx_vehicle_collision_get_impact_size(var_10,self.audio.pv_maxsmlvelocity,self.audio.pv_maxmedvelocity);
			var_12 = sndx_vehicle_collision_get_impact_vol(var_10,self.audio.pv_maxsmlvelocity,self.audio.pv_maxmedvelocity,self.audio.pv_maxlrgvelocity);
			var_13 = "PV-IMPACT";
		}
		else
		{
			var_11 = sndx_vehicle_collision_get_impact_size(var_13,self.audio.npc_maxsmlvelocity,self.audio.npc_maxmedvelocity);
			var_12 = sndx_vehicle_collision_get_impact_vol(var_12,self.audio.npc_maxsmlvelocity,self.audio.npc_maxmedvelocity,self.audio.npc_maxlrgvelocity);
			var_13 = "NPC-IMPACT";
			if(var_11 == "sml")
			{
				return;
			}

			clamp(var_12,self.audio.nonplayerimpvolreduction,1);
			var_12 = var_12 - self.audio.nonplayerimpvolreduction;
		}

		if(var_0C < self.audio.mintimethreshold)
		{
			if(var_11 == "sml")
			{
				return;
			}

			if(!var_0F)
			{
				return;
			}
		}

		self.audio.prev_impacttime = var_0B;
		if(var_0F)
		{
			if(level._snd.veh_collision.scrapeenabled)
			{
				if(var_0C <= self.audio.mintimethreshold)
				{
					level._snd.veh_collision.scrape_pos = var_03;
					if(!level._snd.veh_collision.is_scraping)
					{
						thread sndx_vehicle_collision_scrape(var_0D);
					}
					else
					{
						return;
					}
				}
				else if(level._snd.veh_collision.is_scraping)
				{
					sndx_vehicle_collision_stop_scrapes();
				}
			}
		}

		if(isdefined(var_0D) && var_01 != var_0D)
		{
			if(randomint(100) < self.audio.tireskidprobability)
			{
				soundscripts\_audio::deprecated_aud_play_sound_at("vehicle_tire_skid",var_03);
			}
		}

		var_14 = soundscripts\_audio::deprecated_aud_map2(var_12,level._snd.envs["veh_crash_intensity_to_pitch"]);
		var_15 = snd_impact(self.audio.vehicleid,var_06,var_11,var_03,var_0E);
		var_15 scalevolume(var_12,0.1);
		var_15 scalepitch(var_14,0.1);
		if(var_0F && var_11 != "sml")
		{
			var_16 = soundscripts\_audio::deprecated_aud_map2(var_10,level._snd.envs["veh_crash_vel_to_lfe_vol"]);
			if(var_16 > self.audio.minlfevolumethreshold)
			{
				var_17 = snd_impact(self.audio.vehicleid,var_06,"lfe",var_03);
				var_17 scalevolume(var_16,0.1);
				return;
			}
		}
	}
}

//Function Number: 119
sndx_vehicle_collision_get_impact_size(param_00,param_01,param_02)
{
	if(param_00 <= param_01)
	{
		var_03 = "sml";
	}
	else if(param_01 <= var_03)
	{
		var_03 = "med";
	}
	else
	{
		var_03 = "lrg";
	}

	return var_03;
}

//Function Number: 120
sndx_vehicle_collision_get_impact_vol(param_00,param_01,param_02,param_03)
{
	if(param_00 <= param_01)
	{
		var_04 = param_00 / param_01;
	}
	else if(param_01 <= self.audio.pv_maxmedvelocity)
	{
		var_04 = param_01 / param_03;
		if(var_04 < self.audio.medvolmin)
		{
			var_04 = self.audio.medvolmin;
		}
	}
	else
	{
		var_04 = param_01 / var_04;
		if(var_04 < self.audio.lrgvolmin)
		{
			var_04 = self.audio.lrgvolmin;
		}
	}

	return var_04;
}

//Function Number: 121
sndx_vehicle_collision_scrape(param_00)
{
	level._snd.veh_collision.is_scraping = 1;
	level endon("aud_stop_vehicle_scraping");
	while(level._snd.veh_collision.is_scraping)
	{
		if(isdefined(param_00))
		{
			var_01 = param_00.origin;
			if(isdefined(level._snd.veh_collision.scrape_pos))
			{
				var_01 = level._snd.veh_collision.scrape_pos;
			}

			var_02 = param_00.audio.vehicleid + "_scrape";
			var_03 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_02,param_00,undefined,undefined,undefined,undefined,var_01);
			if(!isdefined(level._snd.veh_collision.scrape_sounds))
			{
				level._snd.veh_collision.scrape_sounds = [];
			}

			level._snd.veh_collision.scrape_sounds[level._snd.veh_collision.scrape_sounds.size] = var_03;
		}

		wait(0.05);
		wait(level._snd.veh_collision.scrapeseperationtime);
	}
}

//Function Number: 122
sndx_vehicle_collision_scrape_timer()
{
	level notify("aud_vehicle_collision_scrape_timer_reset");
	level endon("aud_vehicle_collision_scrape_timer_reset");
	wait(level._snd.veh_collision.scrapeupdaterate);
	waittillframeend;
	sndx_vehicle_collision_stop_scrapes();
}

//Function Number: 123
sndx_vehicle_collision_stop_scrapes(param_00)
{
	var_01 = level._snd.veh_collision.scrapefadeouttime;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	level notify("aud_stop_vehicle_scraping");
	level._snd.veh_collision.is_scraping = 0;
	if(isdefined(level._snd.veh_collision.scrape_sounds))
	{
		for(var_02 = 0;var_02 < level._snd.veh_collision.scrape_sounds.size;var_02++)
		{
			if(isdefined(level._snd.veh_collision.scrape_sounds[var_02]))
			{
				var_03 = level._snd.veh_collision.scrape_sounds[var_02];
				thread soundscripts\_audio::aud_fade_out_and_delete(var_03,var_01);
			}
		}

		level._snd.veh_collision.scrape_sounds = undefined;
	}
}

//Function Number: 124
sndx_vehicle_collision_print_stats(param_00,param_01,param_02,param_03)
{
	if(self.audio.debug)
	{
		if(!isdefined(param_01))
		{
			param_01 = "-";
		}

		if(!isdefined(param_02))
		{
			param_02 = "-";
		}

		if(!isdefined(param_03))
		{
			param_03 = "-";
		}

		if(self.audio.output_type)
		{
			if(isdefined(param_00))
			{
				return;
			}

			return;
		}
	}
}

//Function Number: 125
sndx_vehicle_collision_print_impact(param_00,param_01,param_02,param_03)
{
	if(self.audio.debug)
	{
		if(!isdefined(param_00))
		{
			param_00 = "-";
		}

		if(!isdefined(param_01))
		{
			param_01 = "-";
		}

		if(!isdefined(param_02))
		{
			param_02 = "-";
		}

		if(!isdefined(param_03))
		{
			param_03 = "-";
		}
	}
}

//Function Number: 126
sndx_vehicle_collision_dpad_up()
{
	soundscripts\_audio_mix_manager::mm_add_submix("impact_system_solo");
}

//Function Number: 127
sndx_vehicle_collision_dpad_down()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("impact_system_solo");
}

//Function Number: 128
sndx_vehicle_collision_dpad_left()
{
	if(isdefined(self.audio.input_type))
	{
		self.audio.output_type = 1;
	}
}

//Function Number: 129
sndx_vehicle_collision_dpad_right()
{
	if(isdefined(self.audio.input_type))
	{
		self.audio.output_type = 0;
	}
}

//Function Number: 130
snd_is_valid_surface(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		if(param_00 == param_01[var_03])
		{
			var_02 = 1;
			break;
		}
	}

	return var_02;
}

//Function Number: 131
snd_dpad_functions(param_00,param_01,param_02,param_03)
{
	level.player notifyonplayercommand("dpad_action_01","+actionslot 1");
	level.player notifyonplayercommand("dpad_action_02","+actionslot 2");
	level.player notifyonplayercommand("dpad_action_03","+actionslot 3");
	level.player notifyonplayercommand("dpad_action_04","+actionslot 4");
	thread sndx_dpad_function_watch("dpad_action_01",param_00);
	thread sndx_dpad_function_watch("dpad_action_02",param_01);
	thread sndx_dpad_function_watch("dpad_action_03",param_02);
	thread sndx_dpad_function_watch("dpad_action_04",param_03);
}

//Function Number: 132
sndx_dpad_function_watch(param_00,param_01)
{
	if(isdefined(param_00))
	{
		for(;;)
		{
			level.player waittill(param_00);
			if(isdefined(param_01))
			{
				thread [[ param_01 ]]();
			}

			wait(0.05);
		}
	}
}

//Function Number: 133
snd_waittill_within_radius(param_00,param_01,param_02)
{
	var_03 = 0;
	param_01 = soundscripts\_audio::aud_get_optional_param(1,param_01);
	param_02 = soundscripts\_audio::aud_get_optional_param(0.1,param_02);
	while(isdefined(self) && !var_03)
	{
		if(param_01)
		{
			if(distance(self.origin,level.player.origin) < param_00)
			{
				var_03 = 1;
			}

			continue;
		}

		if(distance2d(self.origin,level.player.origin) < param_00)
		{
			var_03 = 1;
		}

		wait(param_02);
	}

	return var_03;
}

//Function Number: 134
snd_notify_within_radius(param_00,param_01,param_02,param_03)
{
	thread sndx_notify_within_radius(param_00,param_01,param_02);
}

//Function Number: 135
sndx_notify_within_radius(param_00,param_01,param_02,param_03)
{
	var_04 = snd_waittill_within_radius(param_01,param_02,param_03);
	level notify(param_00,var_04);
}

//Function Number: 136
snd_debug_value_add(param_00,param_01,param_02)
{
}

//Function Number: 137
snd_debug_value_update(param_00,param_01)
{
}

//Function Number: 138
snd_debug_value_delete(param_00)
{
}

//Function Number: 139
sndx_debug_value_add(param_00,param_01,param_02,param_03)
{
}

//Function Number: 140
sndx_debug_value_reorder(param_00,param_01)
{
}

//Function Number: 141
sndx_debug_value_destroy(param_00)
{
}

//Function Number: 142
snd_debug_timer(param_00,param_01)
{
}

//Function Number: 143
snd_wait_for_enemies_aware(param_00)
{
	for(;;)
	{
		var_01 = getaiarray("axis");
		foreach(var_03 in var_01)
		{
			if(var_03 isenemyaware())
			{
				if(isstring(param_00))
				{
					level notify(param_00);
				}

				return;
			}
		}

		wait(0.2);
	}
}

//Function Number: 144
snd_wait_for_enemies_see_player(param_00)
{
	for(;;)
	{
		var_01 = getaiarray("axis");
		foreach(var_03 in var_01)
		{
			if(var_03 cansee(level.player))
			{
				if(isstring(param_00))
				{
					level notify(param_00);
				}

				return;
			}
		}

		wait(0.2);
	}
}

//Function Number: 145
snd_enemies_can_see_player()
{
	var_00 = 0;
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		if(var_03 cansee(level.player))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 146
snd_get_num_enemies_aware()
{
	var_00 = 0;
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		if(var_03 isenemyaware())
		{
			var_00 = var_00 + 1;
		}
	}

	return var_00;
}

//Function Number: 147
_snd_update_soundcontextoverride()
{
	foreach(var_01 in level._snd.context_overrides)
	{
		if(var_01[1])
		{
			enablesoundcontextoverride(var_01[0]);
			return;
		}
	}

	disablesoundcontextoverride();
}

//Function Number: 148
snd_enable_soundcontextoverride(param_00)
{
	foreach(var_03, var_02 in level._snd.context_overrides)
	{
		if(var_02[0] == param_00)
		{
			level._snd.context_overrides[var_03][1] = 1;
			_snd_update_soundcontextoverride();
			return;
		}
	}

	soundscripts\_audio::aud_print_error("Trying to enable override sound context that was not configured: " + param_00);
}

//Function Number: 149
snd_disable_soundcontextoverride(param_00)
{
	foreach(var_03, var_02 in level._snd.context_overrides)
	{
		if(var_02[0] == param_00)
		{
			level._snd.context_overrides[var_03][1] = 0;
			_snd_update_soundcontextoverride();
			return;
		}
	}

	soundscripts\_audio::aud_print_error("Trying to disable override sound context that was not configured: " + param_00);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_blackhawk.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 162 ms
 * Timestamp: 10/27/2023 2:46:15 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("blackhawk",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_blackhawk");
	maps\_vehicle::build_deathmodel("vehicle_blackhawk_low");
	maps\_vehicle::build_deathmodel("vehicle_blackhawk_low_thermal");
	maps\_vehicle::build_deathmodel("vehicle_blackhawk_hero_sas_night");
	maps\_vehicle::build_drive(%bh_rotors,undefined,0);
	var_03 = [];
	var_03["vehicle_blackhawk"] = "fx/explosions/helicopter_explosion";
	var_03["vehicle_blackhawk_sas_night"] = "fx/explosions/helicopter_explosion";
	var_03["vehicle_blackhawk_hero_sas_night"] = "fx/explosions/helicopter_explosion";
	var_03["vehicle_blackhawk_hero"] = "fx/explosions/helicopter_explosion";
	var_03["vehicle_blackhawk_low"] = "fx/explosions/large_vehicle_explosion";
	var_03["vehicle_blackhawk_low_thermal"] = "fx/explosions/large_vehicle_explosion";
	var_04 = var_03[param_00];
	maps\_vehicle::build_deathfx("fx/explosions/grenadeexp_default","tag_engine_left","blackhawk_helicopter_hit",undefined,undefined,undefined,0.2,1);
	maps\_vehicle::build_deathfx("fx/explosions/grenadeexp_default","elevator_jnt","blackhawk_helicopter_secondary_exp",undefined,undefined,undefined,0.5,1);
	maps\_vehicle::build_deathfx("fx/fire/fire_smoke_trail_L","elevator_jnt","blackhawk_helicopter_dying_loop",1,0.05,1,0.5,1);
	maps\_vehicle::build_deathfx("fx/explosions/aerial_explosion","tag_engine_right","blackhawk_helicopter_secondary_exp",undefined,undefined,undefined,2.5,1);
	maps\_vehicle::build_deathfx("fx/explosions/aerial_explosion","tag_deathfx","blackhawk_helicopter_secondary_exp",undefined,undefined,undefined,4);
	maps\_vehicle::build_deathfx(var_04,undefined,"blackhawk_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_attach_models(::set_attached_models);
	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_light(param_02,"cockpit_blue_cargo01","tag_light_cargo01","fx/misc/aircraft_light_cockpit_red","interior",0);
	maps\_vehicle::build_light(param_02,"cockpit_blue_cockpit01","tag_light_cockpit01","fx/misc/aircraft_light_cockpit_blue","interior",0);
	maps\_vehicle::build_light(param_02,"white_blink","tag_light_belly","fx/misc/aircraft_light_white_blink_daylight","running",0);
	maps\_vehicle::build_light(param_02,"white_blink_tail","tag_light_tail","fx/misc/aircraft_light_white_blink_daylight","running",0.3);
	maps\_vehicle::build_light(param_02,"wingtip_green","tag_light_L_wing","fx/misc/aircraft_light_wingtip_red","running",0);
	maps\_vehicle::build_light(param_02,"wingtip_red","tag_light_R_wing","fx/misc/aircraft_light_wingtip_green","running",0);
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
init_local()
{
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.fastropeoffset = 762;
	self.script_badplace = 0;
	handle_audio();
}

//Function Number: 3
handle_audio()
{
	self endon("death");
	var_00 = 0;
	var_01 = 12000;
	vehicle_scripts\_blackhawk_aud::snd_init_blackhawk();
	thread monitor_death_stop_sounds();
	for(;;)
	{
		if(!isdefined(self.script_disablevehicleaudio) || !self.script_disablevehicleaudio)
		{
			var_02 = distance(self.origin,level.player.origin);
			if(var_00 && var_02 > var_01)
			{
				vehicle_scripts\_blackhawk_aud::snd_stop_blackhawk(1);
				var_00 = 0;
				wait(0.1);
			}
			else if(!var_00 && var_02 < var_01)
			{
				vehicle_scripts\_blackhawk_aud::snd_start_blackhawk();
				var_00 = 1;
			}
		}
		else if(var_00)
		{
			vehicle_scripts\_blackhawk_aud::snd_stop_blackhawk(1);
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 4
monitor_death_stop_sounds()
{
	self waittill("death");
	vehicle_scripts\_blackhawk_aud::snd_stop_blackhawk(1);
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01].vehicle_getoutanim = %bh_idle;
	}

	return param_00;
}

//Function Number: 6
setplayer_anims(param_00)
{
	param_00[3].player_idle = %bh_player_idle;
	if(!isdefined(level.override_blackhawk_unload_audio))
	{
		param_00[3].player_getout_sound = "fastrope_start_plr";
		param_00[3].player_getout_sound_loop = "fastrope_loop_plr";
		param_00[3].player_getout_sound_end = "fastrope_end_plr";
	}

	param_00[3].player_getout = %bh_player_drop;
	param_00[3].player_animtree = #animtree;
	return param_00;
}

//Function Number: 7
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].idle = %bh_pilot_idle;
	var_00[1].idle = %bh_copilot_idle;
	var_00[2].idle = %bh_1_idle;
	var_00[3].idle = %bh_2_idle;
	var_00[4].idle = %bh_4_idle;
	var_00[5].idle = %bh_5_idle;
	var_00[6].idle = %bh_8_idle;
	var_00[7].idle = %bh_6_idle;
	var_00[0].sittag = "tag_detach";
	var_00[1].sittag = "tag_detach";
	var_00[2].sittag = "tag_detach";
	var_00[3].sittag = "tag_detach";
	var_00[4].sittag = "tag_detach";
	var_00[5].sittag = "tag_detach";
	var_00[6].sittag = "tag_detach";
	var_00[7].sittag = "tag_detach";
	var_00[2].getout = %bh_1_drop;
	var_00[3].getout = %bh_2_drop;
	var_00[4].getout = %bh_4_drop;
	var_00[5].getout = %bh_5_drop;
	var_00[6].getout = %bh_8_drop;
	var_00[7].getout = %bh_6_drop;
	var_00[2].getoutstance = "crouch";
	var_00[3].getoutstance = "crouch";
	var_00[4].getoutstance = "crouch";
	var_00[5].getoutstance = "crouch";
	var_00[6].getoutstance = "crouch";
	var_00[7].getoutstance = "crouch";
	var_00[2].ragdoll_getout_death = 1;
	var_00[3].ragdoll_getout_death = 1;
	var_00[4].ragdoll_getout_death = 1;
	var_00[5].ragdoll_getout_death = 1;
	var_00[6].ragdoll_getout_death = 1;
	var_00[7].ragdoll_getout_death = 1;
	var_00[2].ragdoll_fall_anim = %fastrope_fall;
	var_00[3].ragdoll_fall_anim = %fastrope_fall;
	var_00[4].ragdoll_fall_anim = %fastrope_fall;
	var_00[5].ragdoll_fall_anim = %fastrope_fall;
	var_00[6].ragdoll_fall_anim = %fastrope_fall;
	var_00[7].ragdoll_fall_anim = %fastrope_fall;
	var_00[2].getoutsnd = "fastrope_getout_npc";
	var_00[3].getoutsnd = "fastrope_getout_npc";
	var_00[4].getoutsnd = "fastrope_getout_npc";
	var_00[5].getoutsnd = "fastrope_getout_npc";
	var_00[6].getoutsnd = "fastrope_getout_npc";
	var_00[7].getoutsnd = "fastrope_getout_npc";
	var_00[2].getoutloopsnd = "fastrope_loop_npc";
	var_00[3].getoutloopsnd = "fastrope_loop_npc";
	var_00[4].getoutloopsnd = "fastrope_loop_npc";
	var_00[5].getoutloopsnd = "fastrope_loop_npc";
	var_00[6].getoutloopsnd = "fastrope_loop_npc";
	var_00[7].getoutloopsnd = "fastrope_loop_npc";
	var_00[2].fastroperig = "TAG_FastRope_RI";
	var_00[3].fastroperig = "TAG_FastRope_RI";
	var_00[4].fastroperig = "TAG_FastRope_LE";
	var_00[5].fastroperig = "TAG_FastRope_LE";
	var_00[6].fastroperig = "TAG_FastRope_RI";
	var_00[7].fastroperig = "TAG_FastRope_LE";
	return setplayer_anims(var_00);
}

//Function Number: 8
unload_groups()
{
	var_00 = [];
	var_00["left"] = [];
	var_00["right"] = [];
	var_00["both"] = [];
	var_00["left"][var_00["left"].size] = 4;
	var_00["left"][var_00["left"].size] = 5;
	var_00["left"][var_00["left"].size] = 7;
	var_00["right"][var_00["right"].size] = 2;
	var_00["right"][var_00["right"].size] = 3;
	var_00["right"][var_00["right"].size] = 6;
	var_00["both"][var_00["both"].size] = 2;
	var_00["both"][var_00["both"].size] = 3;
	var_00["both"][var_00["both"].size] = 4;
	var_00["both"][var_00["both"].size] = 5;
	var_00["both"][var_00["both"].size] = 6;
	var_00["both"][var_00["both"].size] = 7;
	var_00["default"] = var_00["both"];
	return var_00;
}

//Function Number: 9
set_attached_models()
{
	var_00 = [];
	var_00["TAG_FastRope_LE"] = spawnstruct();
	var_00["TAG_FastRope_LE"].model = "rope_test";
	var_00["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
	var_00["TAG_FastRope_LE"].idleanim = %bh_rope_idle_le;
	var_00["TAG_FastRope_LE"].dropanim = %bh_rope_drop_le;
	var_00["TAG_FastRope_RI"] = spawnstruct();
	var_00["TAG_FastRope_RI"].model = "rope_test_ri";
	var_00["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
	var_00["TAG_FastRope_RI"].idleanim = %bh_rope_idle_ri;
	var_00["TAG_FastRope_RI"].dropanim = %bh_rope_drop_ri;
	var_01 = getarraykeys(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		precachemodel(var_00[var_01[var_02]].model);
	}

	return var_00;
}
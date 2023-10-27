/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1566.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 2:21:16 AM
*******************************************************************/

//Function Number: 1
func_3E56(param_00)
{
	return param_00 == "vehicle_little_bird_armed";
}

//Function Number: 2
main(param_00,param_01,param_02)
{
	if(func_3E56(param_00))
	{
		lib_016B::func_2874();
	}

	maps\_vehicle::build_template("littlebird",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_little_bird_armed");
	maps\_vehicle::build_deathmodel("vehicle_little_bird_bench");
	maps\_vehicle::build_drive(%mi28_rotors,undefined,0,3);
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small","tag_engine","littlebird_helicopter_secondary_exp",undefined,undefined,undefined,0,1);
	maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L","tag_engine","littlebird_helicopter_dying_loop",1,0.05,1,0.5,1);
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small","tag_engine",undefined,undefined,undefined,undefined,2.5,1);
	maps\_vehicle::build_deathfx("explosions/helicopter_explosion_little_bird",undefined,"littlebird_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound");
	maps\_vehicle::build_rocket_deathfx("explosions/helicopter_explosion_little_bird_dcburn","tag_deathfx","littlebird_helicopter_crash",undefined,undefined,undefined,undefined,1,undefined,0);
	maps\_vehicle::build_deathquake(0.8,1.6,2048);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_life(799);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_mainturret();
	maps\_vehicle::build_unload_groups(::func_3E58);
	maps\_vehicle::build_aianims(::func_3A9D,::func_3A9C);
	var_03 = randomfloatrange(0,1);
	var_04 = maps\_vehicle::get_light_model(param_00,param_02);
	maps\_vehicle::build_light(var_04,"white_blink","TAG_LIGHT_BELLY","misc/aircraft_light_white_blink","running",var_03);
	maps\_vehicle::build_light(var_04,"red_blink1","TAG_LIGHT_TAIL1","misc/aircraft_light_red_blink_occ","running",var_03);
	maps\_vehicle::build_light(var_04,"red_blink2","TAG_LIGHT_TAIL2","misc/aircraft_light_red_blink_occ","running",var_03);
	var_05 = getdvar("mapname");
	if(!isdefined(level.script))
	{
		level.script = tolower(var_05);
	}

	var_06 = "minigun_littlebird_spinnup";
	if(func_3E57())
	{
		var_06 = "minigun_littlebird";
	}

	maps\_vehicle::build_turret(var_06,"TAG_MINIGUN_ATTACH_LEFT","vehicle_little_bird_minigun_left");
	maps\_vehicle::build_turret(var_06,"TAG_MINIGUN_ATTACH_RIGHT","vehicle_little_bird_minigun_right");
}

//Function Number: 3
func_3E57()
{
	return issubstr(level.script,"oilrig");
}

//Function Number: 4
init_local()
{
	self endon("death");
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	thread maps\_vehicle::littlebird_landing();
	thread maps\_vehicle::lights_on("running");
	waittillframeend;
	if(!func_3E57())
	{
		foreach(var_01 in self.mgturret)
		{
			var_01 setautorotationdelay(4);
		}
	}

	if(func_3E56(self.model))
	{
		return;
	}

	maps\_vehicle::mgoff();
	foreach(var_01 in self.mgturret)
	{
		var_01 hide();
	}
}

//Function Number: 5
func_3A9C(param_00)
{
	return param_00;
}

//Function Number: 6
func_3A9D()
{
	level.scr_anim["generic"]["stage_littlebird_right"] = %little_bird_premount_guy3;
	level.scr_anim["generic"]["stage_littlebird_left"] = %little_bird_premount_guy3;
	var_00 = [];
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_pilot1";
	var_00[1].sittag = "tag_pilot2";
	var_00[2].sittag = "tag_detach_right";
	var_00[3].sittag = "tag_detach_right";
	var_00[4].sittag = "tag_detach_right";
	var_00[5].sittag = "tag_detach_left";
	var_00[6].sittag = "tag_detach_left";
	var_00[7].sittag = "tag_detach_left";
	var_00[0].idle[0] = %helicopter_pilot1_idle;
	var_00[0].idle[1] = %helicopter_pilot1_twitch_clickpannel;
	var_00[0].idle[2] = %helicopter_pilot1_twitch_lookback;
	var_00[0].idle[3] = %helicopter_pilot1_twitch_lookoutside;
	var_00[0].idleoccurrence[0] = 500;
	var_00[0].idleoccurrence[1] = 100;
	var_00[0].idleoccurrence[2] = 100;
	var_00[0].idleoccurrence[3] = 100;
	var_00[1].idle[0] = %helicopter_pilot2_idle;
	var_00[1].idle[1] = %helicopter_pilot2_twitch_clickpannel;
	var_00[1].idle[2] = %helicopter_pilot2_twitch_lookoutside;
	var_00[1].idle[3] = %helicopter_pilot2_twitch_radio;
	var_00[1].idleoccurrence[0] = 450;
	var_00[1].idleoccurrence[1] = 100;
	var_00[1].idleoccurrence[2] = 100;
	var_00[1].idleoccurrence[3] = 100;
	var_00[2].idle[0] = %little_bird_casual_idle_guy1;
	var_00[3].idle[0] = %little_bird_casual_idle_guy3;
	var_00[4].idle[0] = %little_bird_casual_idle_guy2;
	var_00[5].idle[0] = %little_bird_casual_idle_guy1;
	var_00[6].idle[0] = %little_bird_casual_idle_guy3;
	var_00[7].idle[0] = %little_bird_casual_idle_guy2;
	var_00[2].idleoccurrence[0] = 100;
	var_00[3].idleoccurrence[0] = 166;
	var_00[4].idleoccurrence[0] = 122;
	var_00[5].idleoccurrence[0] = 177;
	var_00[6].idleoccurrence[0] = 136;
	var_00[7].idleoccurrence[0] = 188;
	var_00[2].idle[1] = %little_bird_aim_idle_guy1;
	var_00[3].idle[1] = %little_bird_aim_idle_guy3;
	var_00[4].idle[1] = %little_bird_aim_idle_guy2;
	var_00[5].idle[1] = %little_bird_aim_idle_guy1;
	var_00[7].idle[1] = %little_bird_aim_idle_guy2;
	var_00[2].idleoccurrence[1] = 200;
	var_00[3].idleoccurrence[1] = 266;
	var_00[4].idleoccurrence[1] = 156;
	var_00[5].idleoccurrence[1] = 277;
	var_00[7].idleoccurrence[1] = 288;
	var_00[2].idle_alert = %little_bird_alert_idle_guy1;
	var_00[3].idle_alert = %little_bird_alert_idle_guy3;
	var_00[4].idle_alert = %little_bird_alert_idle_guy2;
	var_00[5].idle_alert = %little_bird_alert_idle_guy1;
	var_00[6].idle_alert = %little_bird_alert_idle_guy3;
	var_00[7].idle_alert = %little_bird_alert_idle_guy2;
	var_00[2].idle_alert_to_casual = %little_bird_alert_2_aim_guy1;
	var_00[3].idle_alert_to_casual = %little_bird_alert_2_aim_guy3;
	var_00[4].idle_alert_to_casual = %little_bird_alert_2_aim_guy2;
	var_00[5].idle_alert_to_casual = %little_bird_alert_2_aim_guy1;
	var_00[6].idle_alert_to_casual = %little_bird_alert_2_aim_guy3;
	var_00[7].idle_alert_to_casual = %little_bird_alert_2_aim_guy2;
	var_00[2].getout = %little_bird_dismount_guy1;
	var_00[3].getout = %little_bird_dismount_guy3;
	var_00[4].getout = %little_bird_dismount_guy2;
	var_00[5].getout = %little_bird_dismount_guy1;
	var_00[6].getout = %little_bird_dismount_guy3;
	var_00[7].getout = %little_bird_dismount_guy2;
	var_00[2].littlebirde_getout_unlinks = 1;
	var_00[3].littlebirde_getout_unlinks = 1;
	var_00[4].littlebirde_getout_unlinks = 1;
	var_00[5].littlebirde_getout_unlinks = 1;
	var_00[6].littlebirde_getout_unlinks = 1;
	var_00[7].littlebirde_getout_unlinks = 1;
	var_00[2].getin = %little_bird_mount_guy1;
	var_00[2].getin_enteredvehicletrack = "mount_finish";
	var_00[3].getin = %little_bird_mount_guy3;
	var_00[3].getin_enteredvehicletrack = "mount_finish";
	var_00[4].getin = %little_bird_mount_guy2;
	var_00[4].getin_enteredvehicletrack = "mount_finish";
	var_00[5].getin = %little_bird_mount_guy1;
	var_00[5].getin_enteredvehicletrack = "mount_finish";
	var_00[6].getin = %little_bird_mount_guy3;
	var_00[6].getin_enteredvehicletrack = "mount_finish";
	var_00[7].getin = %little_bird_mount_guy2;
	var_00[7].getin_enteredvehicletrack = "mount_finish";
	var_00[2].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[3].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[4].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[5].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[6].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[7].getin_idle_func = ::maps\_vehicle_aianim::guy_idle_alert;
	var_00[2].pre_unload = %little_bird_aim_2_prelanding_guy1;
	var_00[3].pre_unload = %little_bird_aim_2_prelanding_guy3;
	var_00[4].pre_unload = %little_bird_aim_2_prelanding_guy2;
	var_00[5].pre_unload = %little_bird_aim_2_prelanding_guy1;
	var_00[6].pre_unload = %little_bird_aim_2_prelanding_guy3;
	var_00[7].pre_unload = %little_bird_aim_2_prelanding_guy2;
	var_00[2].pre_unload_idle = %little_bird_prelanding_idle_guy1;
	var_00[3].pre_unload_idle = %little_bird_prelanding_idle_guy3;
	var_00[4].pre_unload_idle = %little_bird_prelanding_idle_guy2;
	var_00[5].pre_unload_idle = %little_bird_prelanding_idle_guy1;
	var_00[6].pre_unload_idle = %little_bird_prelanding_idle_guy3;
	var_00[7].pre_unload_idle = %little_bird_prelanding_idle_guy2;
	var_00[0].bhasgunwhileriding = 0;
	var_00[1].bhasgunwhileriding = 0;
	return var_00;
}

//Function Number: 7
func_3E58()
{
	var_00 = [];
	var_1C["first_guy_left"] = 0;
	var_1C["first_guy_right"] = 0;
	var_1C["stage_guy_left"] = 0;
	var_1C["stage_guy_right"] = 0;
	var_1C["left"] = var_1C["left"].size;
	var_1C["left"] = var_1C["left"].size;
	var_1C["left"] = var_1C["left"].size;
	var_1C["right"] = var_1C["right"].size;
	var_1C["right"] = var_1C["right"].size;
	var_1C["right"] = var_1C["right"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	var_1C["passengers"] = var_1C["passengers"].size;
	return var_1C;
}
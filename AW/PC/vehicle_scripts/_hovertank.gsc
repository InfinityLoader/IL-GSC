/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hovertank.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 1156 ms
 * Timestamp: 4/22/2024 2:04:57 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_utility::set_console_status();
	maps\_vehicle::build_template("hovertank",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_hovertank);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	build_hovertank_death(param_02);
	common_scripts\utility::flag_init("hovertank_reload_hint");
	if(isdefined(level.trigger_hint_string) && !isdefined(level.trigger_hint_string["hovertank_reload"]))
	{
		maps\_utility::add_hint_string("hovertank_reload",&"LAB_HOVERTANK_RELOAD_HINT",::break_hovertank_reload_hint);
	}

	precache_for_hovertank();
}

//Function Number: 2
build_hovertank_death(param_00)
{
}

//Function Number: 3
add_hovertank_turret(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "hovertank_turret";
	}

	if(!isdefined(param_02))
	{
		param_02 = "vehicle_mil_hovertank_vm";
	}

	var_03 = spawnturret("misc_turret",param_00 gettagorigin("tag_origin"),param_01);
	var_03 linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	level.hovertank_turret = var_03;
	var_03 setmode("manual");
	var_03 setmodel(param_02);
	var_03 hide();
	var_03 turretfiredisable();
	param_00.turret = var_03;
	return var_03;
}

//Function Number: 4
hovertank_swap_model(param_00,param_01,param_02)
{
	if(param_02)
	{
		param_00 hide();
		param_01 show();
		param_01 setviewmodeldepth(1);
		return;
	}

	param_01 hide();
	param_00 show();
}

//Function Number: 5
hovertank_ride(param_00,param_01)
{
	self setplayerangles(param_00 gettagangles("tag_turret"));
	param_00 hide();
	param_01 show();
	param_01 setviewmodeldepth(1);
	self drivevehicleandcontrolturret(param_00,1);
	self.driving_hovertank = param_00;
	self.drivingvehicle = param_00;
	param_01 useby(self);
	param_01 makeunusable();
	self disableturretdismount();
	soundscripts\_audio::aud_disable_deathsdoor_audio();
	self.aim_turnrate_pitch = getdvarint("aim_turnrate_pitch");
	self.aim_turnrate_pitch_ads = getdvarint("aim_turnrate_pitch_ads");
	self.aim_turnrate_yaw = getdvarint("aim_turnrate_yaw");
	self.aim_turnrate_yaw_ads = getdvarint("aim_turnrate_yaw_ads");
	self.aim_accel_turnrate_lerp = getdvarint("aim_accel_turnrate_lerp");
	setsaveddvar("aim_turnrate_pitch",70);
	setsaveddvar("aim_turnrate_pitch_ads",70);
	setsaveddvar("aim_turnrate_yaw",125);
	setsaveddvar("aim_turnrate_yaw_ads",85);
	setsaveddvar("aim_accel_turnrate_lerp",200);
	param_00 makevehiclenotcollidewithplayers();
	thread end_ride_on_hovertank_done(param_00,param_01);
	hovertank_hud_init(self);
	self notify("noHealthOverlay");
	level.cover_warnings_disabled = 1;
	maps\_utility::ent_flag_clear("near_death_vision_enabled");
	maps\_utility::ent_flag_set("player_no_auto_blur");
	param_00.initialhealth = 5000;
	param_00.health = param_00.healthbuffer + param_00.initialhealth;
	param_00.currenthealth = param_00.health;
	param_00 thread trophy_system();
	param_00 thread handle_hovertank_death();
	give_hovertank_weapons(param_01);
	param_00 thread hovertank_rumble();
	param_00 thread hovertank_physics();
	param_00 thread hovertank_audio();
	param_00 thread handle_hovertank_collisions();
	param_00 thread hovertank_fx();
	param_01 thread hovertank_ride_anims();
}

//Function Number: 6
hovertank_fx()
{
	self endon("death");
	var_00 = self;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"tag_origin",(10,0,10),(-90,0,0));
	for(;;)
	{
		var_02 = var_00 vehicle_hovertankgetthrottleforce();
		var_03 = var_02[0];
		var_04 = var_02[1];
		wait(1);
	}

	var_01 delete();
}

//Function Number: 7
init_hovertank_weapons()
{
	precacheitem("hovertank_antiair");
	precacheitem("hovertank_cannon");
	precacheitem("hovertank_missile_small");
	precacheshellshock("hovertank_cannon");
	precacheshader("reticle_hovertank_cannon");
	precacheshader("reticle_hovertank_emp");
	precacheshader("reticle_hovertank_missiles");
	precacheshader("hud_minimap_tracking_drone_red");
	precacheshader("s1_icon_hovertank_missile_small");
	precacheshader("s1_icon_hovertank_canon");
	precacheshader("s1_icon_hovertank_antiair");
	precacheshader("s1_icon_hovertank_missile_small_ps3");
	precacheshader("s1_icon_hovertank_canon_ps3");
	precacheshader("s1_icon_hovertank_antiair_ps3");
	precacheshader("s1_icon_hovertank_missile_small_pc");
	precacheshader("s1_icon_hovertank_canon_pc");
	precacheshader("s1_icon_hovertank_antiair_pc");
	setdvarifuninitialized("ht_missile_start_forward",0);
	setdvarifuninitialized("ht_missile_start_right",64);
	setdvarifuninitialized("ht_missile_start_up",0);
	setdvarifuninitialized("ht_missile_end_min",0);
	setdvarifuninitialized("ht_missile_end_max",64);
	setdvarifuninitialized("ht_missile_end_forward",128);
	setdvarifuninitialized("ht_missile_end_up",64);
	setdvarifuninitialized("ht_missile_end_rad",16);
	setdvarifuninitialized("ht_missile_mode_line",0);
	level._effect["hovertank_aa_explosion"] = loadfx("vfx/explosion/hovertank_aa_explosion");
	level._effect["trophy_flash"] = loadfx("vfx/muzzleflash/hovertank_trophy_flash");
	level._effect["trophy_explosion"] = loadfx("vfx/explosion/hovertank_trophy_explosion");
	level._effect["hovertank_anti_pers_muzzle_flash_vm"] = loadfx("vfx/muzzleflash/hovertank_anti_pers_muzzle_flash_vm");
	level._effect["hovertank_anti_pers_trail_rocket_2"] = loadfx("vfx/trail/hovertank_anti_pers_trail_rocket_2");
	level._effect["hovertank_cannon_flash_view"] = loadfx("vfx/muzzleflash/hovertank_cannon_flash_view");
	level._effect["hovertank_cannon_dust_ring"] = loadfx("vfx/dust/hovertank_cannon_dust_ring");
	level._effect["hovertank_aa_flash_vm"] = loadfx("vfx/muzzleflash/hovertank_aa_flash_vm");
	level.physicssphereradius["hovertank_missile_small"] = 60;
	level.physicssphereradius["hovertank_antiair"] = 600;
	level.physicssphereradius["hovertank_cannon"] = 1000;
	level.physicssphereforce["hovertank_missile_small"] = 3;
	level.physicssphereforce["hovertank_antiair"] = 0;
	level.physicssphereforce["hovertank_cannon"] = 6;
	level.weapon_reload_time["hovertank_missile_small"] = 0;
	level.weapon_reload_time["hovertank_antiair"] = 0.45;
	level.weapon_reload_time["hovertank_cannon"] = 1;
	level.weapon_input_cooldown_active["hovertank_missile_small"] = 0;
	level.weapon_input_cooldown_active["hovertank_antiair"] = 0;
	level.weapon_input_cooldown_active["hovertank_cannon"] = 0;
	level.weapon_ready_to_fire["hovertank_missile_small"] = 1;
	level.weapon_ready_to_fire["hovertank_antiair"] = 1;
	level.weapon_ready_to_fire["hovertank_cannon"] = 1;
	level.weapon_ammo_max["hovertank_missile_small"] = 25;
	level.weapon_ammo_max["hovertank_antiair"] = 1;
	level.weapon_ammo_max["hovertank_cannon"] = 1;
	level.weapon_ammo_count["hovertank_missile_small"] = level.weapon_ammo_max["hovertank_missile_small"];
	level.weapon_ammo_count["hovertank_antiair"] = level.weapon_ammo_max["hovertank_antiair"];
	level.weapon_ammo_count["hovertank_cannon"] = level.weapon_ammo_max["hovertank_cannon"];
	level.weapon_ammo_bar_value["hovertank_missile_small"] = 1;
	level.weapon_ammo_bar_value["hovertank_antiair"] = 1;
	level.weapon_ammo_bar_value["hovertank_cannon"] = 1;
	level.weapon_ammo_bar_color["hovertank_missile_small"] = (1,1,1);
	level.weapon_ammo_bar_color["hovertank_antiair"] = (1,1,1);
	level.weapon_ammo_bar_color["hovertank_cannon"] = (1,1,1);
	level.weapon_cooldown_active["hovertank_missile_small"] = 0;
	level.weapon_cooldown_active["hovertank_antiair"] = 0;
	level.weapon_cooldown_active["hovertank_cannon"] = 0;
	level.weapon_cooldown_time["hovertank_missile_small"] = 0.1;
	level.weapon_cooldown_time["hovertank_antiair"] = 1;
	level.weapon_cooldown_time["hovertank_cannon"] = 1;
	level.hovertank_projectile_callback = ::hovertank_projectile_callback;
	level.hovertank_weapon = [];
	level.hovertank_weapon[0] = spawnstruct();
	level.hovertank_weapon[1] = spawnstruct();
	level.hovertank_weapon[2] = spawnstruct();
	level.weapon_name["missile"] = "hovertank_missile_small";
	level.weapon_name["antiair"] = "hovertank_antiair";
	level.weapon_name["cannon"] = "hovertank_cannon";
	level.hovertank_weapon[0].weapon = "hovertank_cannon";
	level.hovertank_weapon[1].weapon = "hovertank_missile_small";
	level.hovertank_weapon[2].weapon = "hovertank_antiair";
	level.hovertank_weapon[0].overlay = "reticle_hovertank_cannon";
	level.hovertank_weapon[0].fov = "65";
	level.hovertank_weapon[0].name = level.weapon_name["cannon"];
	level.hovertank_weapon[0].hudelem_x = 0;
	level.hovertank_weapon[0].hudelem_y = 0;
	level.hovertank_weapon[0].shader_width = 800;
	level.hovertank_weapon[0].shader_height = 52;
	level.hovertank_weapon[1].overlay = "reticle_hovertank_missiles";
	level.hovertank_weapon[1].fov = "65";
	level.hovertank_weapon[1].name = level.weapon_name["missile"];
	level.hovertank_weapon[1].hudelem_x = 0;
	level.hovertank_weapon[1].hudelem_y = 0;
	level.hovertank_weapon[1].shader_width = 96;
	level.hovertank_weapon[1].shader_height = 96;
	level.hovertank_weapon[2].overlay = "reticle_hovertank_emp";
	level.hovertank_weapon[2].fov = "65";
	level.hovertank_weapon[2].name = level.weapon_name["antiair"];
	level.hovertank_weapon[2].hudelem_x = 0;
	level.hovertank_weapon[2].hudelem_y = 0;
	level.hovertank_weapon[2].shader_width = 16;
	level.hovertank_weapon[2].shader_height = 16;
	level.current_weapon = level.hovertank_weapon[0].name;
}

//Function Number: 8
get_current_weapon_name()
{
	return level.current_weapon;
}

//Function Number: 9
get_weapon_from_index(param_00)
{
	var_01 = "none";
	switch(param_00)
	{
		case 0:
			var_01 = "hovertank_cannon";
			break;

		case 1:
			var_01 = "hovertank_missile_small";
			break;

		case 2:
			var_01 = "hovertank_antiair";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 10
get_index_from_weapon(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "hovertank_cannon":
			var_01 = 0;
			break;

		case "hovertank_missile_small":
			var_01 = 1;
			break;

		case "hovertank_antiair":
			var_01 = 2;
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 11
hovertank_hud_init(param_00)
{
	var_01 = issplitscreen();
	var_02 = 1;
	if(!maps\_utility::is_specialop() || maps\_utility::is_coop())
	{
		var_02 = getdvarint("widescreen",1);
	}

	if(var_01)
	{
		foreach(var_04 in level.hovertank_weapon)
		{
			var_04.hudelem_x = var_04.hudelem_x * 0.8;
			var_04.hudelem_y = var_04.hudelem_y * 0.8;
			var_04.shader_width = int(var_04.shader_width * 0.8);
			var_04.shader_height = int(var_04.shader_height * 0.8);
		}

		level.hovertank_hud_mode_fontscale = level.hovertank_hud_mode_fontscale * 0.8;
		level.hovertank_hud_misc_fontscale = level.hovertank_hud_misc_fontscale * 0.8;
		level.hovertank_hud_weapon_fontscale = level.hovertank_hud_weapon_fontscale * 0.8;
		level.hovertank_hud_data_fontscale = level.hovertank_hud_data_fontscale * 0.8;
	}

	level.hovertank_hud_mode_fontscale = 2.5;
	level.hovertank_hud_misc_fontscale = 2;
	level.hovertank_hud_weapon_fontscale = 1.5;
	level.hovertank_hud_data_fontscale = 1;
	level.huditem["crosshairs"][0] = newclienthudelem(param_00);
	level.huditem["crosshairs"][0].x = level.hovertank_weapon[0].hudelem_x;
	level.huditem["crosshairs"][0].y = level.hovertank_weapon[0].hudelem_y;
	level.huditem["crosshairs"][0].alignx = "center";
	level.huditem["crosshairs"][0].aligny = "middle";
	level.huditem["crosshairs"][0].horzalign = "center";
	level.huditem["crosshairs"][0].vertalign = "middle";
	level.huditem["crosshairs"][0] setshader(level.hovertank_weapon[0].overlay,level.hovertank_weapon[0].shader_width,level.hovertank_weapon[0].shader_height);
	level.huditem["crosshairs"][0].sort = -2;
	level.huditem["crosshairs"][0].alpha = 0;
	level.huditem["crosshairs"][1] = newclienthudelem(param_00);
	level.huditem["crosshairs"][1].x = level.hovertank_weapon[1].hudelem_x;
	level.huditem["crosshairs"][1].y = level.hovertank_weapon[1].hudelem_y;
	level.huditem["crosshairs"][1].alignx = "center";
	level.huditem["crosshairs"][1].aligny = "middle";
	level.huditem["crosshairs"][1].horzalign = "center";
	level.huditem["crosshairs"][1].vertalign = "middle";
	level.huditem["crosshairs"][1] setshader(level.hovertank_weapon[1].overlay,level.hovertank_weapon[1].shader_width,level.hovertank_weapon[1].shader_height);
	level.huditem["crosshairs"][1].sort = -2;
	level.huditem["crosshairs"][1].alpha = 0;
	var_06 = 24;
	var_07 = 15;
	var_08 = 0.25;
	level.huditem["crosshairs"][2][0] = newclienthudelem(param_00);
	level.huditem["crosshairs"][2][0].x = level.hovertank_weapon[2].hudelem_x;
	level.huditem["crosshairs"][2][0].y = level.hovertank_weapon[2].hudelem_y;
	level.huditem["crosshairs"][2][0].alignx = "center";
	level.huditem["crosshairs"][2][0].aligny = "middle";
	level.huditem["crosshairs"][2][0].horzalign = "center";
	level.huditem["crosshairs"][2][0].vertalign = "middle";
	level.huditem["crosshairs"][2][0] setshader(level.hovertank_weapon[2].overlay,level.hovertank_weapon[2].shader_width,level.hovertank_weapon[2].shader_height);
	level.huditem["crosshairs"][2][0].sort = -2;
	level.huditem["crosshairs"][2][0].alpha = 0;
	level.huditem["crosshairs"][2][1] = newclienthudelem(param_00);
	level.huditem["crosshairs"][2][1].x = level.hovertank_weapon[2].hudelem_x + var_06;
	level.huditem["crosshairs"][2][1].y = level.hovertank_weapon[2].hudelem_y - var_07;
	level.huditem["crosshairs"][2][1].alignx = "center";
	level.huditem["crosshairs"][2][1].aligny = "middle";
	level.huditem["crosshairs"][2][1].horzalign = "center";
	level.huditem["crosshairs"][2][1].vertalign = "middle";
	level.huditem["crosshairs"][2][1] setshader(level.hovertank_weapon[2].overlay,int(level.hovertank_weapon[2].shader_width * 1 + var_08),int(level.hovertank_weapon[2].shader_height * 1 + var_08));
	level.huditem["crosshairs"][2][1].sort = -2;
	level.huditem["crosshairs"][2][1].alpha = 0;
	level.huditem["crosshairs"][2][2] = newclienthudelem(param_00);
	level.huditem["crosshairs"][2][2].x = level.hovertank_weapon[2].hudelem_x + var_06 * 2;
	level.huditem["crosshairs"][2][2].y = level.hovertank_weapon[2].hudelem_y - var_07 * 2;
	level.huditem["crosshairs"][2][2].alignx = "center";
	level.huditem["crosshairs"][2][2].aligny = "middle";
	level.huditem["crosshairs"][2][2].horzalign = "center";
	level.huditem["crosshairs"][2][2].vertalign = "middle";
	level.huditem["crosshairs"][2][2] setshader(level.hovertank_weapon[2].overlay,int(level.hovertank_weapon[2].shader_width * 1 + var_08 * 2),int(level.hovertank_weapon[2].shader_height * 1 + var_08 * 2));
	level.huditem["crosshairs"][2][2].sort = -2;
	level.huditem["crosshairs"][2][2].alpha = 0;
	var_09 = common_scripts\utility::ter_op(var_01,102.4,128);
	var_0A = common_scripts\utility::ter_op(var_01,89.6,112);
	var_0B = 50;
	var_0C = var_0B;
	var_0D = 0;
	if(var_01)
	{
		var_0D = 162;
		if(!var_02)
		{
			var_0D = var_0D * 0.8888889;
		}
	}
	else if(!var_02)
	{
		var_0D = var_0D * 0.8333333;
	}

	var_0E = -60;
	level.huditem["weapon_icon"][0] = newclienthudelem(param_00);
	level.huditem["weapon_icon"][0].x = var_0D;
	level.huditem["weapon_icon"][0].y = var_0E;
	level.huditem["weapon_icon"][0].alignx = "center";
	level.huditem["weapon_icon"][0].aligny = "bottom";
	level.huditem["weapon_icon"][0].horzalign = "center";
	level.huditem["weapon_icon"][0].vertalign = "bottom";
	if(!level.player usinggamepad())
	{
		level.huditem["weapon_icon"][0] setshader("s1_icon_hovertank_canon_pc",var_0C,var_0B);
	}
	else if(level.ps3 || level.ps4)
	{
		level.huditem["weapon_icon"][0] setshader("s1_icon_hovertank_canon_ps3",var_0C,var_0B);
	}
	else
	{
		level.huditem["weapon_icon"][0] setshader("s1_icon_hovertank_canon",var_0C,var_0B);
	}

	level.huditem["weapon_icon"][0].icon_width = var_0C;
	level.huditem["weapon_icon"][0].icon_height = var_0B;
	level.huditem["weapon_icon"][0].alpha = 0;
	level.huditem["weapon_icon"][0].font = "objective";
	level.huditem["weapon_key"][0] = newclienthudelem(param_00);
	level.huditem["weapon_key"][0].x = var_0D;
	level.huditem["weapon_key"][0].y = var_0E;
	level.huditem["weapon_key"][0].alignx = "center";
	level.huditem["weapon_key"][0].aligny = "bottom";
	level.huditem["weapon_key"][0].horzalign = "center";
	level.huditem["weapon_key"][0].vertalign = "bottom";
	level.huditem["weapon_key"][0].alpha = 0;
	level.huditem["weapon_key"][0].font = "objective";
	level.huditem["weapon_key"][0] settext("[{+actionslot 3}]");
	var_0F = 70;
	var_10 = -45;
	var_0D = var_0F * -1;
	if(var_01)
	{
		var_0D = 165;
		if(!var_02)
		{
			var_0D = var_0D * 0.8888889;
		}

		var_0D = ceil(var_0D) + 1;
	}
	else if(!var_02)
	{
		var_0D = var_0D * 0.8333333;
		var_0D = var_0D + 3;
	}

	var_0E = var_10;
	level.huditem["weapon_icon"][1] = newclienthudelem(param_00);
	level.huditem["weapon_icon"][1].x = var_0D;
	level.huditem["weapon_icon"][1].y = var_0E;
	level.huditem["weapon_icon"][1].alignx = "center";
	level.huditem["weapon_icon"][1].aligny = "bottom";
	level.huditem["weapon_icon"][1].horzalign = "center";
	level.huditem["weapon_icon"][1].vertalign = "bottom";
	if(!level.player usinggamepad())
	{
		level.huditem["weapon_icon"][1] setshader("s1_icon_hovertank_missile_small_pc",var_0C,var_0B);
	}
	else if(level.ps3 || level.ps4)
	{
		level.huditem["weapon_icon"][1] setshader("s1_icon_hovertank_missile_small_ps3",var_0C,var_0B);
	}
	else
	{
		level.huditem["weapon_icon"][1] setshader("s1_icon_hovertank_missile_small",var_0C,var_0B);
	}

	level.huditem["weapon_icon"][1].icon_width = var_0C;
	level.huditem["weapon_icon"][1].icon_height = var_0B;
	level.huditem["weapon_icon"][1].alpha = 0;
	level.huditem["weapon_icon"][1].font = "objective";
	level.huditem["weapon_key"][1] = newclienthudelem(param_00);
	level.huditem["weapon_key"][1].x = var_0D;
	level.huditem["weapon_key"][1].y = var_0E;
	level.huditem["weapon_key"][1].alignx = "center";
	level.huditem["weapon_key"][1].aligny = "bottom";
	level.huditem["weapon_key"][1].horzalign = "center";
	level.huditem["weapon_key"][1].vertalign = "bottom";
	level.huditem["weapon_key"][1].alpha = 0;
	level.huditem["weapon_key"][1].font = "objective";
	level.huditem["weapon_key"][1] settext("[{weapnext}]");
	var_0D = var_0F;
	if(var_01)
	{
		var_0D = 165;
		if(!var_02)
		{
			var_0D = var_0D * 0.8888889;
		}

		var_0D = ceil(var_0D) + 1;
	}
	else if(!var_02)
	{
		var_0D = var_0D * 0.8333333;
		var_0D = var_0D + 3;
	}

	var_0E = var_10;
	level.huditem["weapon_icon"][2] = newclienthudelem(param_00);
	level.huditem["weapon_icon"][2].x = var_0D;
	level.huditem["weapon_icon"][2].y = var_0E;
	level.huditem["weapon_icon"][2].alignx = "center";
	level.huditem["weapon_icon"][2].aligny = "bottom";
	level.huditem["weapon_icon"][2].horzalign = "center";
	level.huditem["weapon_icon"][2].vertalign = "bottom";
	if(!level.player usinggamepad())
	{
		level.huditem["weapon_icon"][2] setshader("s1_icon_hovertank_antiair_pc",var_0C,var_0B);
	}
	else if(level.ps3 || level.ps4)
	{
		level.huditem["weapon_icon"][2] setshader("s1_icon_hovertank_antiair_ps3",var_0C,var_0B);
	}
	else
	{
		level.huditem["weapon_icon"][2] setshader("s1_icon_hovertank_antiair",var_0C,var_0B);
	}

	level.huditem["weapon_icon"][2].icon_width = var_0C;
	level.huditem["weapon_icon"][2].icon_height = var_0B;
	level.huditem["weapon_icon"][2].alpha = 0;
	level.huditem["weapon_icon"][2].font = "objective";
	level.huditem["weapon_key"][2] = newclienthudelem(param_00);
	level.huditem["weapon_key"][2].x = var_0D;
	level.huditem["weapon_key"][2].y = var_0E;
	level.huditem["weapon_key"][2].alignx = "center";
	level.huditem["weapon_key"][2].aligny = "bottom";
	level.huditem["weapon_key"][2].horzalign = "center";
	level.huditem["weapon_key"][2].vertalign = "bottom";
	level.huditem["weapon_key"][2].alpha = 0;
	level.huditem["weapon_key"][2].font = "objective";
	level.huditem["weapon_key"][2] settext("[{+actionslot 4}]");
}

//Function Number: 12
give_hovertank_weapons(param_00)
{
	maps\_utility::add_global_spawn_function("axis",::set_up_target);
	level.hovertank_player = self;
	level.last_hovertank_weapon_anim = "";
	level.last_hovertank_weapon_anim_complete_time = gettime();
	var_01 = self;
	var_01 disableweapons();
	var_01 enableinvulnerability();
	var_01 painvisionoff();
	var_01 maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");
	var_01 notify("noHealthOverlay");
	thread shotfired();
	thread change_weapons(param_00);
	thread missile_reload_system();
	thread missile_fire_audio();
	thread weapon_fire(param_00);
	maps\_utility::delaythread(1,::hud_blink_current_weapon_name,0);
	level.huditem["crosshairs"][0].alpha = 0.6;
}

//Function Number: 13
remove_hovertank_weapons()
{
	level notify("hovertank_end");
	maps\_utility::remove_global_spawn_function("axis",::set_up_target);
	var_00 = self;
	level.huditem = common_scripts\utility::array_removeundefined(level.huditem);
	maps\_utility::deep_array_thread(level.huditem,::maps\_hud_util::destroyelem);
	var_00 disableinvulnerability();
	level.hovertank_player = undefined;
}

//Function Number: 14
hovertank_rumble()
{
	level endon("hovertank_end");
	level.player endon("death");
	var_00 = 12;
	var_01 = 0.2;
	var_02 = 0.0001;
	var_03 = 0.6;
	var_04 = 0;
	self.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	self.rumble_entity.intensity = 0;
	for(;;)
	{
		var_05 = var_04;
		var_04 = self vehicle_getspeed();
		var_06 = var_01 * clamp(var_04 / var_00,0,1);
		var_06 = var_06 * randomfloat(1);
		var_07 = 0;
		var_08 = var_04 - var_05;
		if(var_08 > 0)
		{
			var_07 = var_03 * clamp(1 - var_05 / var_04,var_02,1) - var_02;
		}

		self.rumble_entity.intensity = clamp(var_06 + var_07,0,1);
		wait(0.1);
	}
}

//Function Number: 15
get_hovertank_shake_value()
{
	var_00 = 0;
	var_01 = 12;
	return self vehicle_getspeed() / var_01;
}

//Function Number: 16
hovertank_rumble_stop()
{
	level waittill("hovertank_end");
	stopallrumbles();
}

//Function Number: 17
hovertank_physics()
{
	self endon("death");
	for(;;)
	{
		wakeupphysicssphere(self.origin,200);
		wait(0.05);
	}
}

//Function Number: 18
end_ride_on_hovertank_done(param_00,param_01)
{
	self endon("disconnect");
	param_00 waittill("hovertank_done");
	endride(param_00,param_01);
}

//Function Number: 19
endride(param_00,param_01)
{
	self drivevehicleandcontrolturretoff(param_00);
	param_01 useby(self);
	level notify("hovertank_cannon_reload_hint");
	common_scripts\utility::flag_clear("hovertank_reload_hint");
	remove_hovertank_weapons();
	maps\_utility::remove_damage_function(::track_health_damage_function);
	maps\_utility::remove_damage_function(::trophy_system_backup);
	level.cover_warnings_disabled = undefined;
	maps\_utility::ent_flag_set("near_death_vision_enabled");
	maps\_utility::ent_flag_clear("player_no_auto_blur");
	thread maps\_gameskill::healthoverlay();
	soundscripts\_audio::aud_enable_deathsdoor_audio();
	setsaveddvar("aim_turnrate_pitch",self.aim_turnrate_pitch);
	setsaveddvar("aim_turnrate_pitch_ads",self.aim_turnrate_pitch_ads);
	setsaveddvar("aim_turnrate_yaw",self.aim_turnrate_yaw);
	setsaveddvar("aim_turnrate_yaw_ads",self.aim_turnrate_yaw_ads);
	setsaveddvar("aim_accel_turnrate_lerp",self.aim_accel_turnrate_lerp);
	self.driving_hovertank = undefined;
	self.drivingvehicle = undefined;
	self notify("hovertank_dismounted");
}

//Function Number: 20
hoverscreen_reveal(param_00)
{
	if(isdefined(level.use_hovertank_chromatic_aberration) && level.use_hovertank_chromatic_aberration)
	{
		level.chromo_offset = 30;
	}

	var_01 = level.hovertank_turret gettagorigin("tag_aim_animated");
	thread hoverscreen_turnon_movie();
	level.player common_scripts\utility::delaycall(param_00,::freezecontrols,0);
	setsaveddvar("r_hudoutlineenable",1);
	if(isdefined(level.use_hovertank_chromatic_aberration) && level.use_hovertank_chromatic_aberration)
	{
		setsaveddvar("r_chromaticAberrationTweaks",1);
		setsaveddvar("r_chromaticAberration",0);
		setsaveddvar("r_chromaticSeparationG",-10);
		setsaveddvar("r_chromaticSeparationR",10);
	}

	level.player freezecontrols(1);
	wait(0.05);
	setomnvar("ui_labtank",1);
	luinotifyevent(&"qflash01");
	level.hovertank_turret overridematerial("mtl_hovertank_body_gun","mtl_hovertank_body_gun_no_z");
	level.hovertank_turret hidepart("TAG_AIM_HIDE");
	level.hovertank_turret hidepart("TAG_AIM_UNHIDE");
}

//Function Number: 21
hoverscreen_turnon_movie()
{
	wait(0.05);
	level.hovertank_turret showpart("TAG_BOOT");
	stopcinematicingame();
	level.hovertank_turret overridematerial("mtl_hovertank_int_screen02","m/mtl_hovertank_int_screen01");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("lab_tank_bootup");
	wait(1.26);
	level.hovertank_turret overridematerialreset();
	wait(0.74);
	level.hovertank_turret hidepart("TAG_BOOT");
	stopcinematicingame();
}

//Function Number: 22
hoverscreen_turnoff_movie()
{
	wait(0.05);
	level.hovertank_turret showpart("TAG_BOOT");
	stopcinematicingame();
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("lab_tank_shutdown");
	wait(0.5);
	level.hovertank_turret overridematerial("mtl_hovertank_int_screen02","m/mtl_hovertank_int_screen01");
	wait(0.5);
	level.hovertank_turret hidepart("TAG_BOOT");
	stopcinematicingame();
}

//Function Number: 23
hoverscreen_turnoff(param_00,param_01)
{
	if(isdefined(level.use_hovertank_chromatic_aberration) && level.use_hovertank_chromatic_aberration)
	{
		level.chromo_offset = 30;
	}

	var_02 = level.hovertank_turret gettagorigin("tag_aim_animated");
	thread hoverscreen_turnoff_movie();
	wait(param_01);
	setsaveddvar("r_hudoutlineenable",1);
	if(isdefined(level.use_hovertank_chromatic_aberration) && level.use_hovertank_chromatic_aberration)
	{
		setsaveddvar("r_chromaticAberrationTweaks",1);
		setsaveddvar("r_chromaticAberration",0);
		setsaveddvar("r_chromaticSeparationG",-10);
		setsaveddvar("r_chromaticSeparationR",10);
	}

	wait(0.05);
	level.hovertank_turret overridematerial("mtl_hovertank_body_gun","mtl_hovertank_body_gun_no_z");
	wait(0.05);
}

//Function Number: 24
hoverscreen_hit(param_00,param_01)
{
	level notify("hoverscreen_hit_" + param_00);
	level endon("hoverscreen_hit_" + param_00);
	level endon("hovertank_end");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = int(900.2);
	var_03 = int(521.5);
	if(!isdefined(level.huditem["hovertank_hit01"]) || !isdefined(level.huditem["hovertank_hit01"][param_00]))
	{
		level.huditem["hovertank_hit01"][param_00] = newclienthudelem(level.player);
		level.huditem["hovertank_hit01"][param_00].x = 0;
		level.huditem["hovertank_hit01"][param_00].y = 10;
		level.huditem["hovertank_hit01"][param_00].alignx = "center";
		level.huditem["hovertank_hit01"][param_00].aligny = "bottom";
		level.huditem["hovertank_hit01"][param_00].horzalign = "center";
		level.huditem["hovertank_hit01"][param_00].vertalign = "bottom";
		var_04 = "mtl_hovertank_screen_hit_0" + param_00;
		level.huditem["hovertank_hit01"][param_00] setshader(var_04,var_02,var_03);
		level.huditem["hovertank_hit01"][param_00].alpha = 0;
		level.huditem["hovertank_hit01"][param_00].color = (1,1,1);
	}

	var_05 = 0;
	if(isdefined(level.use_hovertank_chromatic_aberration) && level.use_hovertank_chromatic_aberration)
	{
		thread hoverscreen_chromo_anim2(0.5,param_01);
	}

	for(var_05 = 0;var_05 < 5;var_05++)
	{
		level.huditem["hovertank_hit01"][param_00].alpha = abs(var_05 / 5);
		level.huditem["hovertank_hit01"][param_00].alpha = level.huditem["hovertank_hit01"][param_00].alpha * param_01;
		wait(0.05);
	}

	for(var_05 = 0;var_05 < 5;var_05++)
	{
		level.huditem["hovertank_hit01"][param_00].color = (1,0.97,0.85);
		level.huditem["hovertank_hit01"][param_00].alpha = 1 - abs(var_05 / 5 * 2 - 1);
		level.huditem["hovertank_hit01"][param_00].alpha = level.huditem["hovertank_hit01"][param_00].alpha * param_01;
		wait(0.05);
	}

	level.huditem["hovertank_hit01"][param_00] destroy();
}

//Function Number: 25
hoverscreen_chromo_anim2(param_00,param_01)
{
	var_02 = 1;
	if(param_01)
	{
		var_02 = param_01;
	}

	setsaveddvar("r_chromaticAberration",1);
	var_03 = param_00 * 20;
	var_04 = 0;
	level.chromo_offset = 20 * var_02;
	var_05 = level.chromo_offset;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_06 = 1 / var_03 * var_05;
		level.chromo_offset = level.chromo_offset - var_06;
		setsaveddvar("r_chromaticSeparationG",level.chromo_offset * -1);
		setsaveddvar("r_chromaticSeparationR",level.chromo_offset);
		wait(0.05);
	}

	level.chromo_offset = 0;
	setsaveddvar("r_chromaticSeparationG",0);
	setsaveddvar("r_chromaticSeparationR",0);
}

//Function Number: 26
hoverscreen_chromo_anim(param_00,param_01)
{
	setsaveddvar("r_chromaticAberration",2);
	var_02 = param_00 * 20;
	var_03 = 0;
	param_01 hudoutlineenable(0);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_02 + 1 - var_03 / 60 * 5;
		setsaveddvar("r_chromaticSeparationG",var_04 * -1);
		setsaveddvar("r_chromaticSeparationR",var_04);
		wait(0.05);
	}
}

//Function Number: 27
hoverscreen_chromo_anim_turnoff(param_00,param_01)
{
	setsaveddvar("r_chromaticAberration",2);
	var_02 = param_00 * 20;
	var_03 = 0;
	param_01 hudoutlineenable(0);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_02 + 1 - var_03 / 60 * 5;
		setsaveddvar("r_chromaticSeparationG",var_04 * -1);
		setsaveddvar("r_chromaticSeparationR",var_04);
		wait(0.05);
	}
}

//Function Number: 28
change_weapons(param_00)
{
	level endon("hovertank_end");
	var_01 = 0;
	var_02 = "cannon";
	level.current_weapon = level.hovertank_weapon[var_01].name;
	level.player thread change_weapons_listener();
	wait(0.05);
	for(;;)
	{
		var_03 = level.hovertank_player common_scripts\utility::waittill_any_return("antiair_button","cannon_button","missiles_button");
		if(issubstr(var_03,"cannon"))
		{
			if(issubstr(level.current_weapon,"cannon"))
			{
				continue;
			}

			var_01 = 0;
		}
		else if(issubstr(var_03,"missile"))
		{
			if(issubstr(level.current_weapon,"missile"))
			{
				continue;
			}

			var_01 = 1;
		}
		else if(issubstr(var_03,"antiair"))
		{
			if(issubstr(level.current_weapon,"antiair"))
			{
				continue;
			}

			var_01 = 2;
		}
		else
		{
		}

		level.hovertank_player notify("shot weapon");
		level.current_weapon = level.hovertank_weapon[var_01].name;
		if(!issubstr(level.current_weapon,"missile"))
		{
			level.hovertank_player notify("stop_missile_fire_audio");
		}

		if(isdefined(param_00))
		{
			var_04 = 0.3;
			if(issubstr(level.current_weapon,"cannon") && var_02 == "antiair")
			{
				param_00 setanimknobrestart(%lab_htank_emp_to_cannon_vmhtank,1,var_04);
				level.last_hovertank_weapon_anim = "emp_to_cannon";
				level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength(%lab_htank_emp_to_cannon_vmhtank);
				soundscripts\_snd::snd_message("hovertank_switch_to_cannon");
				var_02 = "cannon";
			}
			else if(issubstr(level.current_weapon,"antiair") && var_02 == "cannon")
			{
				if(gettime() >= level.last_hovertank_weapon_anim_complete_time)
				{
					param_00 setanimknobrestart(%lab_htank_cannon_to_emp_vmhtank,1,0);
				}
				else
				{
					param_00 setanimknobrestart(%lab_htank_cannon_to_emp_vmhtank,1,var_04);
				}

				level.last_hovertank_weapon_anim = "cannon_to_emp";
				level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength(%lab_htank_cannon_to_emp_vmhtank);
				soundscripts\_snd::snd_message("hovertank_switch_to_emp");
				var_02 = "antiair";
			}
			else
			{
				soundscripts\_snd::snd_message("hovertank_switch_to_missile");
			}
		}

		foreach(var_0A, var_06 in level.huditem["crosshairs"])
		{
			if(var_0A != var_01)
			{
				if(isarray(var_06))
				{
					foreach(var_08 in var_06)
					{
						var_08 fadeovertime(0.01666667);
						var_08.alpha = 0;
					}

					continue;
				}

				var_06 fadeovertime(0.01666667);
				var_06.alpha = 0;
			}
		}

		thread hud_blink_current_weapon_name(var_01);
		level.hovertank_player thread maps\_utility::play_sound_on_entity("ac130_weapon_switch");
		wait(0.05);
		if(isarray(level.huditem["crosshairs"][var_01]))
		{
			foreach(var_0A, var_08 in level.huditem["crosshairs"][var_01])
			{
				if(var_0A == 0)
				{
					var_08.alpha = 1;
					continue;
				}

				if(var_0A == 1)
				{
					var_08.alpha = 0.25;
					continue;
				}

				var_08.alpha = 0.1;
			}

			continue;
		}

		level.huditem["crosshairs"][var_01].alpha = 0.6;
	}
}

//Function Number: 29
change_weapons_listener()
{
	level endon("hovertank_end");
	self notifyonplayercommand("antiair_button","+stance");
	self notifyonplayercommand("cannon_button","weapnext");
	self notifyonplayercommand("missiles_button","+usereload");
	notifyoncommand("LISTEN_attack_button_pressed","+attack");
	notifyoncommand("LISTEN_attack_button_pressed","+attack_akimbo_accessible");
	var_00 = "default";
	for(;;)
	{
		if(!level.player common_scripts\utility::is_player_gamepad_enabled())
		{
			self notifyonplayercommand("antiair_button","+actionslot 4");
			self notifyonplayercommand("cannon_button","+actionslot 3");
			self notifyonplayercommand("missiles_button","weapnext");
		}
		else
		{
			self notifyonplayercommandremove("antiair_button","+actionslot 4");
			self notifyonplayercommandremove("cannon_button","+actionslot 3");
			self notifyonplayercommandremove("missiles_button","weapnext");
		}

		if(issubstr(getbuttonsconfig(),"nomad_tactical"))
		{
			if(var_00 != "nomad")
			{
				self notifyonplayercommandremove("antiair_button","+stance");
				self notifyonplayercommandremove("antiair_button","+melee_zoom");
				self notifyonplayercommand("antiair_button","+melee_breath");
				var_00 = "nomad_tactical";
			}
		}
		else if(issubstr(getbuttonsconfig(),"tactical"))
		{
			if(var_00 != "tactical")
			{
				self notifyonplayercommandremove("antiair_button","+stance");
				self notifyonplayercommandremove("antiair_button","+melee_breath");
				self notifyonplayercommand("antiair_button","+melee_zoom");
				var_00 = "tactical";
			}
		}
		else
		{
			self notifyonplayercommandremove("antiair_button","+melee_zoom");
			self notifyonplayercommandremove("antiair_button","+melee_breath");
			self notifyonplayercommand("antiair_button","+stance");
			var_00 = "default";
		}

		wait(0.1);
	}
}

//Function Number: 30
scale_missile_reticle_with_dist(param_00)
{
	var_01 = 3000;
	var_02 = 600;
	var_03 = 0.1;
	level endon("hovertank_end");
	for(;;)
	{
		if(issubstr(level.current_weapon,"missile"))
		{
			var_04 = [];
			var_05 = level.hovertank_player geteye() + 15000 * anglestoforward(level.hovertank_player getplayerangles());
			if(isdefined(param_00))
			{
				var_04 = bullettrace(level.hovertank_player geteye() + anglestoforward(param_00 gettagangles("tag_flash")) * 32,var_05,1,param_00);
			}
			else
			{
				var_04 = bullettrace(level.player geteye() + anglestoforward(level.player getgunangles()) * 32,var_05,1,level.player);
			}

			var_06 = distance(level.player.origin,var_04["position"]);
			if(var_06 > var_01)
			{
				var_06 = var_01;
			}
			else if(var_06 < var_02)
			{
				var_06 = var_02;
			}

			var_07 = 1 - var_06 - var_02 / var_01 - var_02;
			if(var_07 < 0.3)
			{
				var_07 = 0.3;
			}

			level.huditem["crosshairs"][1] scaleovertime(var_03,int(level.hovertank_weapon[1].shader_width * var_07),int(level.hovertank_weapon[1].shader_height * var_07));
		}

		wait(var_03);
	}
}

//Function Number: 31
missile_reload_system()
{
	level endon("hovertank_end");
	var_00 = "hovertank_missile_small";
	var_01 = 0.1;
	for(;;)
	{
		var_02 = level.weapon_ammo_count[var_00] / level.weapon_ammo_max[var_00];
		level.weapon_ammo_bar_value[var_00] = clamp(level.weapon_ammo_count[var_00] / level.weapon_ammo_max[var_00],0.04,1);
		if(level.weapon_ammo_count[var_00] < level.weapon_ammo_max[var_00])
		{
			level.weapon_ammo_count[var_00]++;
		}

		if(var_02 < 0.3)
		{
			level.weapon_ammo_bar_color[var_00] = (1,1,0);
		}
		else
		{
			level.weapon_ammo_bar_color[var_00] = (1,1,1);
		}

		wait(var_01);
	}
}

//Function Number: 32
weapon_fire_notify()
{
	level endon("hovertank_end");
	for(;;)
	{
		if(level.hovertank_player attackbuttonpressed())
		{
			level.hovertank_player notify("LISTEN_attack_button_pressed");
			level.hovertank_player.firingweapons = 1;
		}
		else
		{
			level.hovertank_player.firingweapons = 0;
			level.hovertank_player waittill("LISTEN_attack_button_pressed");
		}

		wait(0.05);
	}
}

//Function Number: 33
weapon_fire(param_00)
{
	level endon("hovertank_end");
	thread weapon_fire_notify();
	var_01 = 0;
	var_02 = 0.2;
	var_03 = 1;
	var_04 = level.hovertank_player geteye()[2];
	var_05 = 1.5;
	var_06 = 0;
	for(;;)
	{
		level.hovertank_player waittill("LISTEN_attack_button_pressed");
		level.time_of_hovertank_fire = gettime();
		level.player_angles_at_last_hovertank_fire = level.hovertank_player getplayerangles();
		var_07 = undefined;
		if(!level.weapon_ready_to_fire[level.current_weapon] || level.weapon_cooldown_active[level.current_weapon] || level.weapon_input_cooldown_active[level.current_weapon])
		{
			continue;
		}
		else
		{
			if(issubstr(level.current_weapon,"missile"))
			{
				var_06 = var_06 + 1 % 2;
			}

			var_08 = (0,0,0);
			if(isdefined(param_00))
			{
				var_08 = param_00 get_weapon_fire_pos(level.current_weapon,var_06);
			}
			else
			{
				var_08 = level.player geteye();
			}

			var_09 = level.hovertank_player geteye() + 15000 * anglestoforward(level.hovertank_player getplayerangles());
			if(level.time_of_hovertank_fire - var_01 > var_02 * 1000)
			{
				var_03 = 1;
			}

			if(level.time_of_hovertank_fire - var_01 > var_05 * 1000)
			{
				var_04 = level.hovertank_player geteye()[2];
			}

			if(issubstr(level.current_weapon,"missile"))
			{
				var_07 = [];
				if(isdefined(param_00))
				{
					var_07 = bullettrace(level.hovertank_player geteye() + anglestoforward(param_00 gettagangles("tag_flash")) * 32,var_09,1,param_00);
				}
				else
				{
					var_07 = bullettrace(level.player geteye() + anglestoforward(level.player getgunangles()) * 32,var_09,1,level.player);
				}

				var_0A = 0;
				var_0B = 0;
				var_09 = (0,0,0);
				if(getdvarint("ht_missile_mode_line"))
				{
					var_0C = (0,0,0);
					if(isdefined(param_00))
					{
						var_0C = param_00 gettagangles("tag_flash");
					}
					else
					{
						var_0C = level.player getgunangles();
					}

					if(var_06 == 0)
					{
						var_0A = anglestoright(var_0C) * randomintrange(-1 * getdvarint("ht_missile_end_max"),getdvarint("ht_missile_end_min"));
					}
					else
					{
						var_0A = anglestoright(var_0C) * randomintrange(getdvarint("ht_missile_end_min"),getdvarint("ht_missile_end_max"));
					}

					var_09 = var_08 + anglestoforward(var_0C) * getdvarint("ht_missile_end_forward") + anglestoup(var_0C) * getdvarint("ht_missile_end_up") + var_0A;
				}
				else
				{
					if(var_06 == 0)
					{
						var_0B = randomintrange(90,180);
					}
					else
					{
						var_0B = randomintrange(0,90);
					}

					var_0C = (0,0,0);
					if(isdefined(param_00))
					{
						var_0C = param_00 gettagangles("tag_flash");
					}
					else
					{
						var_0C = level.player getgunangles();
					}

					var_09 = var_08 + anglestoforward((0,var_0C[1],0)) * getdvarint("ht_missile_end_forward") + anglestoup((0,var_0C[1],0)) * getdvarint("ht_missile_end_rad") * sin(var_0B) + anglestoright((0,var_0C[1],0)) * getdvarint("ht_missile_end_rad") * cos(var_0B);
				}
			}
			else
			{
				var_01 = level.time_of_hovertank_fire;
				var_07 = bullettrace(level.hovertank_player geteye() + 150 * anglestoforward(level.hovertank_player getplayerangles()),var_09,1,param_00);
				if(isdefined(var_07["position"]))
				{
					var_09 = var_07["position"];
					var_04 = level.hovertank_player geteye()[2] - var_07["position"][2];
					var_04 = common_scripts\utility::ter_op(var_04 > 0,var_04,0);
				}
				else
				{
					var_09 = level.hovertank_player geteye() + var_04 / cos(90 - level.hovertank_player getplayerangles()[0]) * anglestoforward(level.hovertank_player getplayerangles());
				}
			}

			var_0D = magicbullet(level.current_weapon,var_08,var_09,level.hovertank_player);
			if(isdefined(level.hovertank_projectile_callback))
			{
				var_0E = [level.current_weapon,var_07];
				var_0D thread [[ level.hovertank_projectile_callback ]](var_0E);
			}

			level.hovertank_player notify("missile_fire",var_0D,level.current_weapon);
			level.hovertank_player notify("LISTEN_hovertank_weapon_fired");
			var_0F = (0,0,0);
			var_0C = (0,0,0);
			if(isdefined(param_00))
			{
				var_0F = param_00.origin;
				var_0C = param_00 gettagangles("tag_flash");
			}
			else
			{
				var_0F = level.player.origin;
				var_0C = level.player getgunangles();
			}

			var_10 = 0.5;
			if(issubstr(level.current_weapon,"cannon"))
			{
				if(isdefined(param_00))
				{
					playfxontag(common_scripts\utility::getfx("hovertank_cannon_flash_view"),param_00,"tag_flash");
				}

				playfxontag(common_scripts\utility::getfx("hovertank_cannon_dust_ring"),param_00,"tag_flash_animated");
				earthquake(1,0.5,level.hovertank_player.origin,500);
				level.hovertank_player shellshock("hovertank_cannon",2);
				level.hovertank_player playrumbleonentity("heavygun_fire");
				soundscripts\_snd::snd_message("hovertank_cannon_fire");
				if(isdefined(param_00))
				{
					if(level.last_hovertank_weapon_anim == "cannon_fire" || gettime() >= level.last_hovertank_weapon_anim_complete_time)
					{
						param_00 setanimknobrestart(%lab_htank_cannon_fire_vmhtank,1,0);
					}
					else
					{
						param_00 setanimknobrestart(%lab_htank_cannon_fire_vmhtank,1,var_10);
					}

					level.last_hovertank_weapon_anim = "cannon_fire";
					level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength(%lab_htank_cannon_fire_vmhtank);
					param_00 setanimrestart(%lab_htank_cannon_cylinder_vmhtank,1,0);
					soundscripts\_snd::snd_message("hovertank_barrel_turn");
				}

				physicsjolt(var_0F,300,250,anglestoforward(var_0C) * -0.1);
			}
			else if(issubstr(level.current_weapon,"antiair"))
			{
				playfxontag(common_scripts\utility::getfx("hovertank_aa_flash_vm"),param_00,"tag_flash_2");
				level.hovertank_player shellshock("hovertank_cannon",1);
				level.hovertank_player playrumbleonentity("heavygun_fire");
				soundscripts\_snd::snd_message("hovertank_antiair_fire");
				physicsjolt(var_0F,300,250,anglestoforward(var_0C) * -0.01);
				if(isdefined(param_00))
				{
					if(level.last_hovertank_weapon_anim == "emp_fire" || gettime() >= level.last_hovertank_weapon_anim_complete_time)
					{
						param_00 setanimknobrestart(%lab_htank_emp_fire_vmhtank,1,0);
					}
					else
					{
						param_00 setanimknobrestart(%lab_htank_emp_fire_vmhtank,1,var_10);
					}

					level.last_hovertank_weapon_anim = "emp_fire";
					level.last_hovertank_weapon_anim_complete_time = gettime() + 1000 * getanimlength(%lab_htank_emp_fire_vmhtank);
					soundscripts\_snd::snd_message("hovertank_antiair_recoil");
				}
			}
			else if(issubstr(level.current_weapon,"missile"))
			{
				level.hovertank_player shellshock("hovertank_cannon",0.1);
				level.hovertank_player playrumbleonentity("silencer_fire");
				physicsjolt(var_0F,300,250,anglestoforward(var_0C) * -0.01);
			}
		}

		thread weapon_reload(level.current_weapon);
	}
}

//Function Number: 34
get_weapon_fire_pos(param_00,param_01)
{
	if(issubstr(param_00,"missile"))
	{
		var_02 = 1;
		if(param_01 == 0)
		{
			var_02 = -1;
		}

		var_03 = self gettagangles("tag_aim_animated");
		var_04 = self gettagorigin("tag_aim_animated");
		var_05 = getdvarint("ht_missile_start_forward",64);
		var_06 = getdvarint("ht_missile_start_up",32);
		var_07 = getdvarint("ht_missile_start_right",32);
		var_08 = var_04 + anglestoforward(var_03) * var_05 + anglestoup(var_03) * var_06 + anglestoright(var_03) * var_07 * var_02;
		return var_08;
	}

	if(issubstr(var_07,"antiair"))
	{
		return self gettagorigin("tag_flash_2");
	}

	if(issubstr(var_07,"cannon"))
	{
		return self gettagorigin("tag_flash");
	}

	return level.hovertank_player geteye();
}

//Function Number: 35
hovertank_projectile_callback(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[1];
	self.team = "allies";
	if(issubstr(var_01,"missile"))
	{
		playfx(common_scripts\utility::getfx("hovertank_anti_pers_muzzle_flash_vm"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
		var_03 = -64;
		var_04 = 64;
		var_05 = target_getarray();
		var_06 = [];
		for(var_07 = 0;var_07 < var_05.size;var_07++)
		{
			if(!isdefined(var_05[var_07].missile_targetting))
			{
				if(target_isincircle(var_05[var_07],level.hovertank_player,75,60))
				{
					var_06[var_06.size] = var_05[var_07];
				}
			}
		}

		var_08 = undefined;
		var_09 = undefined;
		if(var_06.size == 0)
		{
			var_08 = spawn("script_origin",var_02["position"] + (randomintrange(var_03,var_04),randomintrange(var_03,var_04),randomintrange(var_03,var_04)));
			var_08.missile_targetting = 1;
		}
		else
		{
			var_09 = var_06[0];
			var_08 = var_09;
			var_09.missile_targetting = 1;
		}

		target_set(var_08);
		target_hidefromplayer(var_08,level.hovertank_player);
		self missile_settargetent(var_08);
		thread missile_delayed_trail();
		self waittill("death");
		if(isdefined(var_09))
		{
			var_09.missile_targetting = undefined;
		}

		if(isdefined(var_08) && var_08.classname == "script_origin")
		{
			var_08 delete();
			return;
		}

		return;
	}

	if(issubstr(var_01,"antiair"))
	{
		self endon("death");
		var_0A = [];
		if(isdefined(level.emp_vulnerable_list))
		{
			var_0A = level.emp_vulnerable_list;
		}

		var_0B = var_0A;
		var_0C = 512;
		var_0D = var_0C * var_0C;
		thread detonate_hovertank_aa_projectile_on_death(var_0C * 2);
		for(;;)
		{
			var_0A = var_0B;
			foreach(var_0F in var_0A)
			{
				if(!isdefined(var_0F) || !isalive(var_0F))
				{
					var_0B = common_scripts\utility::array_remove(var_0B,var_0F);
					continue;
				}

				if(distancesquared(self.origin,var_0F.origin) < var_0D)
				{
					self notify("death");
					waittillframeend;
					self delete();
				}
			}

			wait(0.05);
		}

		return;
	}

	if(issubstr(var_01,"cannon"))
	{
		return;
	}
}

//Function Number: 36
missile_delayed_trail()
{
	var_00 = 0.5;
	wait(var_00);
	if(isdefined(self))
	{
		playfxontag(common_scripts\utility::getfx("hovertank_anti_pers_trail_rocket_2"),self,"tag_origin");
		self waittill("death");
	}
}

//Function Number: 37
detonate_hovertank_aa_projectile_on_death(param_00)
{
	self waittill("death");
	if(isdefined(self))
	{
		radiusdamage(self.origin,param_00,1,1,level.hovertank_player,"MOD_ENERGY","hovertank_antiair");
		playfx(common_scripts\utility::getfx("hovertank_aa_explosion"),self.origin);
	}
}

//Function Number: 38
manual_cannon_reload()
{
	level endon("hovertank_end");
	var_00 = "hovertank_cannon";
	for(;;)
	{
		var_01 = 0;
		while(!var_01)
		{
			var_02 = 0.3;
			while(level.hovertank_player usebuttonpressed() && !level.weapon_cooldown_active[var_00])
			{
				var_02 = var_02 - 0.05;
				if(var_02 < 0)
				{
					var_01 = 1;
					break;
				}

				wait(0.05);
			}

			wait(0.05);
		}

		if(!level.weapon_cooldown_active[var_00])
		{
			thread weapon_reload(var_00,1);
		}

		wait(0.05);
	}
}

//Function Number: 39
weapon_reload(param_00,param_01)
{
	level endon("hovertank_end");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	level.weapon_ready_to_fire[param_00] = 0;
	if(!param_01)
	{
		level.weapon_ammo_count[param_00]--;
	}

	if(!issubstr(param_00,"missile"))
	{
		level.weapon_ammo_bar_value[param_00] = level.weapon_ammo_count[param_00] / level.weapon_ammo_max[param_00];
	}

	if((issubstr(param_00,"cannon") && level.weapon_ammo_count[param_00] == 0) || param_01)
	{
		level notify("hovertank_cannon_reload_hint");
		common_scripts\utility::flag_clear("hovertank_reload_hint");
	}

	if(!param_01)
	{
		if(level.weapon_reload_time[param_00] > 0)
		{
			wait(level.weapon_reload_time[param_00]);
		}
	}

	if(level.weapon_ammo_count[param_00] <= 0 || param_01)
	{
		if(issubstr(param_00,"antiair"))
		{
			level.hovertank_player thread maps\_utility::play_sound_on_entity("ac130_40mm_reload");
		}
		else if(issubstr(param_00,"missile"))
		{
			level.hovertank_player thread maps\_utility::play_sound_on_entity("ac130_25mm_reload");
		}
		else
		{
			soundscripts\_snd::snd_message("ht_cannon_reload");
		}

		level.weapon_cooldown_active[param_00] = 1;
		if(level.weapon_cooldown_time[param_00] > 0)
		{
			weapon_ammo_bar_reload(param_00,param_01);
			if(issubstr(param_00,"cannon"))
			{
				level notify("kill_reload_sound");
			}
		}

		if(!issubstr(param_00,"missile"))
		{
			level.weapon_ammo_count[param_00] = level.weapon_ammo_max[param_00];
		}

		level.weapon_cooldown_active[param_00] = 0;
	}
	else if(issubstr(param_00,"cannon") && level.weapon_ammo_count[param_00] == 1)
	{
		thread hovertank_cannon_reload_hint();
	}

	level.weapon_ready_to_fire[param_00] = 1;
}

//Function Number: 40
weapon_ammo_bar_reload(param_00,param_01)
{
	level endon("hovertank_end");
	if(issubstr(param_00,"missile"))
	{
		wait(level.weapon_cooldown_time[param_00]);
		return;
	}

	var_02 = level.weapon_ammo_count[param_00];
	var_03 = level.weapon_ammo_max[param_00];
	if(var_02 == var_03)
	{
		return;
	}

	level.weapon_ammo_bar_color[param_00] = (1,0,0);
	var_04 = 0.05;
	var_05 = 0.05;
	var_06 = 0;
	var_07 = 0;
	if(param_01)
	{
		var_07 = level.weapon_cooldown_time[param_00] * 1 - level.weapon_ammo_bar_value[param_00];
		var_05 = var_04 / var_07 * var_03 - var_02 / var_03;
	}
	else
	{
		var_07 = level.weapon_cooldown_time[param_00];
		var_05 = var_04 / var_07;
	}

	while(var_06 < var_07)
	{
		level.weapon_ammo_bar_value[param_00] = level.weapon_ammo_bar_value[param_00] + var_05;
		var_06 = var_06 + var_04;
		wait(var_04);
	}

	level.weapon_ammo_bar_value[param_00] = 1;
	level.weapon_ammo_bar_color[param_00] = (1,1,1);
}

//Function Number: 41
hovertank_cannon_reload_hint()
{
	level notify("hovertank_cannon_reload_hint");
	level endon("hovertank_cannon_reload_hint");
	wait(5);
	common_scripts\utility::flag_set("hovertank_reload_hint");
	maps\_utility::display_hint_timeout("hovertank_reload",10);
}

//Function Number: 42
break_hovertank_reload_hint()
{
	return !common_scripts\utility::flag("hovertank_reload_hint");
}

//Function Number: 43
shotfired()
{
	level endon("hovertank_end");
	for(;;)
	{
		level.hovertank_player waittill("projectile_impact",var_00,var_01,var_02);
		if(is_hovertank_weapon(var_00,"cannon"))
		{
		}
		else if(is_hovertank_weapon(var_00,"antiair"))
		{
			earthquake(0.2,0.5,var_01,2000);
		}

		if(is_hovertank_weapon(var_00))
		{
			thread shotfiredphysicssphere(var_01,var_00);
		}

		wait(0.05);
	}
}

//Function Number: 44
is_hovertank_weapon(param_00,param_01)
{
	if(isdefined(param_01))
	{
		return issubstr(tolower(param_00),param_01);
	}

	return issubstr(tolower(param_00),"cannon") || issubstr(tolower(param_00),"antiair") || issubstr(tolower(param_00),"missile");
}

//Function Number: 45
missile_fire_audio()
{
	level endon("hovertank_end");
	var_00 = 0;
	var_01 = "stopped";
	var_02 = "stopped";
	level.gun_state = var_01;
	thread missile_fire_audio_end();
	var_03 = 0;
	var_04 = 100;
	for(;;)
	{
		if(gettime() - var_03 > var_04)
		{
			if(!issubstr(level.current_weapon,"missile"))
			{
				var_02 = "stopped";
			}
			else if(level.hovertank_player.firingweapons)
			{
				if(level.weapon_ammo_count[level.current_weapon] > 2)
				{
					var_02 = "full_loop";
				}
				else
				{
					var_02 = "slow_loop";
				}
			}
			else
			{
				var_02 = "stopped";
			}

			if(var_02 != var_01)
			{
				switch(var_02)
				{
					case "stopped":
						soundscripts\_snd::snd_message("hovertank_missile_small_stop");
						var_01 = "stopped";
						level.gun_state = var_01;
						break;
	
					case "full_loop":
						soundscripts\_snd::snd_message("hovertank_missile_small_start");
						var_01 = "full_loop";
						level.gun_state = var_01;
						break;
	
					case "slow_loop":
						soundscripts\_snd::snd_message("hovertank_missile_small_slow");
						var_01 = "slow_loop";
						level.gun_state = var_01;
						break;
	
					default:
						break;
				}

				var_03 = gettime();
			}

			wait(0.05);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 46
missile_fire_audio_end()
{
	level waittill("hovertank_end");
	if(level.gun_state != "stopped")
	{
		soundscripts\_snd::snd_message("hovertank_missile_small_stop");
	}
}

//Function Number: 47
shotfiredphysicssphere(param_00,param_01)
{
	wait(0.1);
}

//Function Number: 48
hud_blink_current_weapon_name(param_00)
{
	level notify("LISTEN_end_hud_blink_current_weapon_name");
	level endon("LISTEN_end_hud_blink_current_weapon_name");
	level endon("hovertank_end");
	if(!isdefined(level.huditem["weapon_icon"]))
	{
		return;
	}

	foreach(var_02 in level.huditem["weapon_icon"])
	{
		var_02.alpha = 1;
		var_02.color = (0.3,0.3,0.3);
	}

	level.huditem["weapon_icon"][param_00].alpha = 1;
	for(;;)
	{
		update_hovertank_icons();
		level.huditem["weapon_icon"][param_00] fadeovertime(0.2);
		level.huditem["weapon_icon"][param_00].color = (1,1,1);
		wait(0.25);
		level.huditem["weapon_icon"][param_00] fadeovertime(0.2);
		level.huditem["weapon_icon"][param_00].color = (0.5,0.5,0.5);
		wait(0.25);
	}
}

//Function Number: 49
hovertank_ride_anims()
{
	self endon("death");
	self useanimtree(#animtree);
	self setanim(%lab_htank_idle_vm);
	self setanim(%lab_htank_idle_vmhtank);
	for(;;)
	{
		self waittill("large_hit_react");
		var_00 = getanimlength(%lab_htank_react_large_vmhtank);
		self setanimknobrestart(%lab_htank_react_large_vmhtank,1,0);
		wait(var_00);
		self setanimknob(%lab_htank_idle_vmhtank,1,0.5);
	}
}

//Function Number: 50
init_hovertank()
{
	if(isdefined(self) && self != level)
	{
		self useanimtree(#animtree);
		if(self.vehicletype != "hovertank_npc_physics_tank")
		{
			self vehicle_hovertanksethoverforcescale(0.7);
		}

		self.script_bulletshield = 1;
		self.script_grenadeshield = 1;
		self.script_badplace = 1;
	}
}

//Function Number: 51
precache_for_hovertank()
{
	precacheturret("hovertank_turret");
	precachemodel("vehicle_mil_hovertank_vm");
	precachemodel("vehicle_mil_hovertank_simple_vm");
	precachemodel("viewbody_sentinel_covert");
	precacherumble("steady_rumble");
	precacherumble("heavygun_fire");
	precacherumble("damage_heavy");
	precacherumble("damage_light");
	precacherumble("silencer_fire");
	precachemodel("vehicle_mil_hovertank_screen01");
	precachestring("LAB_TROPHY_SYSTEM");
	precache_lui_hovertank_screens();
	init_hovertank_weapons();
}

//Function Number: 52
precache_lui_hovertank_screens()
{
	precachestring(&"flash01");
	precachestring(&"qflash01");
	precachestring(&"flash02");
	precachestring(&"flash03");
	precachestring(&"flash04");
	precachestring(&"qflash05");
	precachestring(&"flash05");
	precachestring(&"flash06");
	precachestring(&"hit01");
	precachestring(&"hit02");
	precachestring(&"hit03");
	precachestring(&"hit04");
	precachestring(&"hit05");
	precachestring(&"hit06");
	precachestring(&"off01");
	precachestring(&"off02");
	precachestring(&"off03");
	precachestring(&"off04");
	precachestring(&"off05");
	precachestring(&"off06");
	precacheshader("mtl_hovertank_screen_hit_01");
	precacheshader("mtl_hovertank_screen_hit_02");
	precacheshader("mtl_hovertank_screen_hit_03");
	precacheshader("mtl_hovertank_screen_hit_04");
	precacheshader("mtl_hovertank_screen_hit_05");
	precacheshader("mtl_hovertank_screen_hit_06");
}

//Function Number: 53
hovertank_audio()
{
	self endon("death");
	var_00 = spawnstruct();
	var_00.player_mode = 1;
	var_00.preset_name = "hovertank";
	var_01 = ::vehicle_scripts\_hovertank_aud::hovertank_constructor;
	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	if(var_00.player_mode == 1)
	{
		soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
	}

	level.player waittill("hovertank_dismounted");
	soundscripts\_snd::snd_message("snd_stop_vehicle");
}

//Function Number: 54
handle_hovertank_collisions()
{
	self endon("death");
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(self.last_collision_time) && self.last_collision_time == gettime())
		{
			continue;
		}

		self.last_collision_time = gettime();
		var_05 = [];
		var_05["vehicle"] = self;
		var_05["hit_entity"] = var_00;
		var_05["pos"] = var_01;
		var_05["impulse"] = var_02;
		var_05["relativeVel"] = var_03;
		var_05["surface"] = var_04;
		soundscripts\_snd::snd_message("aud_impact_system_hovertank",var_05);
	}
}

//Function Number: 55
set_up_target()
{
	if(isdefined(self))
	{
		if(isdefined(self.script_parameters) && self.script_parameters == "no_target")
		{
			return;
		}

		target_set(self,get_npc_center_offset());
		target_hidefromplayer(self,level.hovertank_player);
	}
}

//Function Number: 56
get_npc_center_offset()
{
	if(isai(self) && isalive(self))
	{
		var_00 = self geteye()[2];
		var_01 = self.origin[2];
		var_02 = var_00 - var_01 / 2;
		return (0,0,var_02);
	}

	return (0,0,0);
}

//Function Number: 57
monitor_player_damage()
{
	level.player endon("end_monitor_player_damage");
	level.player.death_invulnerable_activated = 0;
	var_00 = 1;
	switch(level.gameskill)
	{
		case 2:
			var_00 = 1.5;
			break;

		case 3:
			var_00 = 1.5;
			break;

		default:
			var_00 = 1;
			break;
	}

	level.player_ugv_health = 600 * var_00;
	level.player_ugv_health_max_health = 600 * var_00;
	for(;;)
	{
		level.player waittill("damage",var_01,var_02,var_03,var_04,var_05);
		level.player_ugv_health_hurtagain = 1;
		if(!level.player.death_invulnerable_activated)
		{
			level.player_ugv_health = level.player_ugv_health - var_01;
		}
	}
}

//Function Number: 58
pass_hovertank_damage_to_player()
{
	level endon("hovertank_end");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		var_0A = var_03;
		if(isdefined(var_01))
		{
			if(isdefined(var_01.team) && var_01.team == level.player.team)
			{
				continue;
			}

			var_0B = distance(self.origin,var_01.origin);
			var_0A = var_03 + var_02 * var_0B * -1;
		}

		level.player dodamage(0.1,var_0A,var_01);
	}
}

//Function Number: 59
handle_hovertank_death()
{
	level endon("hovertank_end");
	self waittill("death");
	level.player freezecontrols(1);
	setdvar("ui_deadquote",&"LAB_MISSION_FAILED_TANK_DESTROYED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 60
health_monitor()
{
	level.huditem["health_text"] = level.player maps\_hud_util::createclientfontstring("default",1.2);
	level.huditem["health_text"] maps\_hud_util::setpoint("LEFT",undefined,60,-50);
	level.huditem["health_text"] settext("Armor Status");
	level.huditem["health_text"].alpha = 0.6;
	level.huditem["health_bar"] = level.player maps\_hud_util::createclientprogressbar(level.player,60,"white","black",100,10);
	level.huditem["health_bar"] maps\_hud_util::setpoint("LEFT",undefined,65,-38);
	level.huditem["health_bar"] maps\_hud_util::updatebar(1);
	level.huditem["health_bar"].alpha = 0.6;
	level.huditem["health_bar"].bar.alpha = 0.6;
	maps\_utility::add_damage_function(::track_health_damage_function);
}

//Function Number: 61
track_health_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = get_tank_health_percent();
	if(var_07 < 0)
	{
		var_07 = 0;
	}

	level.huditem["health_bar"] maps\_hud_util::updatebar(var_07);
}

//Function Number: 62
get_tank_health_percent()
{
	if(isdefined(self))
	{
		var_00 = self.health - self.healthbuffer;
		var_01 = var_00 / self.maxhealth - self.healthbuffer;
		var_02 = int(ceil(var_01 * 100)) / 100;
		return var_02;
	}

	return 0;
}

//Function Number: 63
update_health_bar(param_00)
{
	var_01 = 5;
	var_02 = 20 * var_01;
	var_03 = 0;
	while(var_03 < var_02 && isdefined(self))
	{
		maps\_hud_util::updatebar(var_03 / var_02);
		var_03++;
		wait(0.05);
	}
}

//Function Number: 64
trophy_system()
{
	level endon("hovertank_end");
	level.missiles = [];
	thread trackmissiles();
	self.trophytags = ["TAG_VFX_TROPHY_RT","TAG_VFX_TROPHY_LT"];
	var_00 = self;
	var_01 = 450;
	var_02 = var_01 * var_01;
	self.trophyammomax = 100;
	self.trophyammo = self.trophyammomax;
	self.trophy_cost = 1;
	thread trophy_ammo_counter();
	thread trophy_reload_bar();
	maps\_utility::add_damage_function(::trophy_system_backup);
	for(;;)
	{
		if(level.missiles.size < 1)
		{
			wait(0.05);
			continue;
		}

		if(self.trophyammo < self.trophy_cost)
		{
			wait(0.05);
			continue;
		}

		var_03 = level.missiles;
		foreach(var_05 in var_03)
		{
			wait(0.05);
			if(!has_trophy_ammo())
			{
				break;
			}

			if(!isdefined(var_05))
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			if(isdefined(var_05.team) && var_05.team == "allies")
			{
				continue;
			}

			var_06 = distancesquared(var_05.origin,self.origin);
			if(var_06 < var_02)
			{
				deploy_trophy(var_05);
			}
		}
	}
}

//Function Number: 65
trophy_system_backup(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(has_trophy_ammo() && param_04 == "MOD_PROJECTILE")
	{
		deploy_trophy(undefined,param_03);
		self.health = self.currenthealth;
		return;
	}

	if(param_04 == "MOD_PROJECTILE")
	{
		soundscripts\_snd::snd_message("defenseless_tank_impact");
	}
}

//Function Number: 66
set_trophy_ammo(param_00)
{
	self.trophyammo = param_00;
	level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar(self.trophyammo / self.trophyammomax);
}

//Function Number: 67
get_trophy_ammo()
{
	return self.trophyammo;
}

//Function Number: 68
has_trophy_ammo()
{
	return self.trophyammo >= self.trophy_cost;
}

//Function Number: 69
fires_explosives(param_00)
{
	if(issubstr(self.classname,"rpg"))
	{
		return 1;
	}

	if(issubstr(self.classname,"tank"))
	{
		return 1;
	}

	if(isdefined(self.model) && issubstr(self.model,"warbird"))
	{
		return 1;
	}

	if(isdefined(param_00) && issubstr(param_00,"rpg"))
	{
		return 1;
	}

	if(isdefined(param_00) && issubstr(param_00,"ft101"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 70
deploy_trophy(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = spawn("script_origin",param_01);
	}

	self notify("trophy_deployed",param_00.origin);
	var_02 = get_closest_tag(param_00.origin,self.trophytags);
	if(!isdefined(self.last_trophy_time))
	{
		self.last_trophy_time = 0;
	}

	var_03 = 0.2;
	if(gettime() - self.last_trophy_time > var_03 * 1000)
	{
		playfx(common_scripts\utility::getfx("trophy_flash"),var_02,param_00.origin - var_02);
		var_04 = common_scripts\utility::spawn_tag_origin();
		var_04.origin = param_00.origin;
		if(isdefined(param_00.angles))
		{
			var_04.angles = param_00.angles;
		}
		else
		{
			var_04.angles = vectortoangles(param_00.origin - level.player.origin);
		}

		playfxontag(common_scripts\utility::getfx("trophy_explosion"),var_04,"tag_origin");
		soundscripts\_snd::snd_message("hovertank_trophy_system",param_00);
		var_05 = vectornormalize(var_04.origin - level.hovertank.turret.origin);
		var_06 = anglestoright(level.hovertank.turret gettagangles("tag_aim_animated"));
		var_07 = vectordot(var_06,var_05);
		var_08 = anglestoforward(level.hovertank.turret gettagangles("tag_aim_animated"));
		var_09 = vectorcross(var_05,var_08);
		var_0A = 0.2;
		var_0B = 0.05;
		if(var_09[2] >= 0.4)
		{
			thread hoverscreen_hit(3,var_0A);
			thread hoverscreen_hit(4,var_0A);
			thread hoverscreen_hit(2,var_0B);
			thread hoverscreen_hit(5,var_0B);
		}
		else if(var_09[2] <= -0.4)
		{
			thread hoverscreen_hit(1,var_0A);
			thread hoverscreen_hit(6,var_0A);
			thread hoverscreen_hit(2,var_0B);
			thread hoverscreen_hit(5,var_0B);
		}
		else if(var_09[2] > -0.4 && var_09[2] < 0.4)
		{
			thread hoverscreen_hit(2,var_0A);
			thread hoverscreen_hit(5,var_0A);
			thread hoverscreen_hit(3,var_0B);
			thread hoverscreen_hit(4,var_0B);
			thread hoverscreen_hit(1,var_0B);
			thread hoverscreen_hit(6,var_0B);
		}

		var_04 common_scripts\utility::delaycall(0.05,::delete);
	}

	self.last_trophy_time = gettime();
	self.trophyammo = self.trophyammo - self.trophy_cost;
	if(isdefined(level.huditem["trophy_reload_bar"]))
	{
		level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar(self.trophyammo / self.trophyammomax);
	}

	param_00 delete();
}

//Function Number: 71
trophy_reload_bar()
{
	level.huditem["trophy_reload_bar"] = level.player maps\_hud_util::createclientprogressbar(level.player,60,"white","black",100,10);
	level.huditem["trophy_reload_bar"] maps\_hud_util::setpoint("LEFT",undefined,65,-3);
	level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar(1);
	level.huditem["trophy_reload_bar"].alpha = 0.6;
	level.huditem["trophy_reload_bar"].bar.alpha = 0.6;
	level.huditem["trophy_reload_bar_split"] = [];
}

//Function Number: 72
trophy_reload()
{
	update_trophy_reload_progress_bar();
}

//Function Number: 73
update_trophy_reload_progress_bar()
{
	level endon("hovertank_end");
	var_00 = 5;
	var_01 = 20 * var_00;
	var_02 = 0;
	var_03 = 0.05;
	while(var_02 < var_00 && isdefined(self))
	{
		level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar(self.trophyammo / 100);
		self.trophyammo = self.trophyammo + self.trophy_cost / var_00 * var_03;
		var_02 = var_02 + var_03;
		wait(var_03);
	}

	level.huditem["trophy_reload_bar"] maps\_hud_util::updatebar(self.trophyammo / 100);
}

//Function Number: 74
trophy_ammo_counter()
{
	level endon("hovertank_end");
	level.huditem["trophy_ammo_counter_text"] = level.player maps\_hud_util::createclientfontstring("default",1.2);
	level.huditem["trophy_ammo_counter_text"] maps\_hud_util::setpoint("LEFT",undefined,60,-15);
	level.huditem["trophy_ammo_counter_text"] settext(&"LAB_TROPHY_SYSTEM");
	level.huditem["trophy_ammo_counter_text"].alpha = 0.6;
}

//Function Number: 75
get_closest_tag(param_00,param_01)
{
	var_02 = 1000000000;
	var_03 = (0,0,0);
	foreach(var_05 in param_01)
	{
		var_06 = self.turret gettagorigin(var_05);
		var_07 = distancesquared(var_06,param_00);
		if(var_07 < var_02)
		{
			var_02 = var_07;
			var_03 = var_06;
		}
	}

	return var_03;
}

//Function Number: 76
trackmissiles()
{
	level endon("hovertank_end");
	for(;;)
	{
		var_00 = getentarray("rocket","classname");
		var_01 = [];
		foreach(var_03 in var_00)
		{
			if(isdefined(var_03.team) && var_03.team == "allies")
			{
				continue;
			}
			else
			{
				var_01[var_01.size] = var_03;
			}
		}

		level.missiles = var_01;
		wait(0.05);
	}
}

//Function Number: 77
weapon_ammo_bar()
{
	level endon("hovertank_end");
	for(;;)
	{
		for(var_00 = 0;var_00 < 3;var_00++)
		{
			var_01 = level.hovertank_weapon[var_00].weapon;
		}

		wait(0.05);
	}
}

//Function Number: 78
missile_tracking_hud()
{
	level endon("hovertank_end");
	self.tracked = 1;
	target_set(self);
	target_setshader(self,"hud_minimap_tracking_drone_red");
}

//Function Number: 79
update_hovertank_icons()
{
	update_hovertank_icons_proc(0,"s1_icon_hovertank_canon");
	update_hovertank_icons_proc(1,"s1_icon_hovertank_missile_small");
	update_hovertank_icons_proc(2,"s1_icon_hovertank_antiair");
}

//Function Number: 80
update_hovertank_icons_proc(param_00,param_01)
{
	if(!level.player usinggamepad())
	{
		level.huditem["weapon_icon"][param_00] setshader(param_01 + "_pc",get_icon_width(param_00),get_icon_height(param_00));
		level.huditem["weapon_key"][param_00].alpha = 1;
		return;
	}

	if(level.ps3 || level.ps4)
	{
		level.huditem["weapon_icon"][param_00] setshader(param_01 + "_ps3",get_icon_width(param_00),get_icon_height(param_00));
		level.huditem["weapon_key"][param_00].alpha = 0;
		return;
	}

	level.huditem["weapon_icon"][param_00] setshader(param_01,get_icon_width(param_00),get_icon_height(param_00));
	level.huditem["weapon_key"][param_00].alpha = 0;
}

//Function Number: 81
get_icon_width(param_00)
{
	return level.huditem["weapon_icon"][param_00].icon_width;
}

//Function Number: 82
get_icon_height(param_00)
{
	return level.huditem["weapon_icon"][param_00].icon_height;
}
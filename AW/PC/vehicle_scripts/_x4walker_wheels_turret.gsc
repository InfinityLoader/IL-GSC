/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _x4walker_wheels_turret.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1012 ms
 * Timestamp: 4/22/2024 2:05:46 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel("vehicle_vm_x4walkerSplit_wheels");
	precachemodel("vehicle_vm_x4walkerSplit_turret");
	precachemodel("projectile_rpg7");
	precacheshader("bls_ui_turret_targetlock");
	precacheshader("bls_ui_turret_targetlock_white");
	precacheshader("bls_ui_turret_targetacquired");
	precacheitem("mobile_turret_missile");
	precacherumble("heavy_1s");
	precacheshader("bls_ui_turret_overlay_sm");
	precacheshader("bls_ui_turret_overlay_vignette");
	precacheshader("bls_ui_turret_missle");
	precacheshader("bls_ui_turret_chevron");
	precacheshader("bls_ui_turret_chevron_right");
	precacheshader("bls_ui_turret_reticle_tl");
	precacheshader("bls_ui_turret_reticle_tr");
	precacheshader("bls_ui_turret_reticle_bl");
	precacheshader("bls_ui_turret_reticle_br");
	precacheshader("bls_ui_turret_reticule_hpip");
	precacheshader("bls_ui_turret_reticule_vpip");
	precacheshader("bls_ui_turret_warning");
	precachestring(&"_X4WALKER_WHEELS_ENTER");
	maps\_utility::set_console_status();
	maps\_vehicle::build_template("x4walker_wheels_turret",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::local_init);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_shoot_shock("mobile_turret_shoot");
	maps\_vehicle::build_aianims(::set_ai_anims);
	build_walker_death(param_02);
	if(issubstr(param_02,"explosive"))
	{
		maps\_vehicle::build_turret("x4walker_turret_explosive","tag_turret","vehicle_npc_x4walkerSplit_turret",undefined,"manual",0.2,0);
	}
	else
	{
		maps\_vehicle::build_turret("x4walker_turret","tag_turret","vehicle_npc_x4walkerSplit_turret",undefined,"manual",0.2,0);
	}

	register_vehicle_anims(param_02);
	register_player_anims();
	register_fx();
	level.x4walker_wheels_seoul_turret = 0;
	level.x4walker_wheels_fusion_turret = 0;
	level.x4walker_player_invulnerability = 1;
}

//Function Number: 2
build_walker_death(param_00)
{
	level._effect["walkerexplode"] = loadfx("vfx/explosion/vehicle_x4walker_explosion");
	maps\_vehicle::build_deathmodel("vehicle_x4walker_wheels","vehicle_x4walker_wheels_destroyed");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_x4walker_explosion","TAG_ORIGIN");
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,0,0);
}

//Function Number: 3
register_vehicle_anims(param_00)
{
	maps\_vehicle_shg::add_vehicle_anim(param_00,"idle",%x4walker_wheels_turret_idle);
	maps\_vehicle_shg::add_vehicle_anim(param_00,"cockpit_idle",%x4walker_wheels_turret_cockpit_idle);
}

//Function Number: 4
register_fx()
{
	level._effect["x4walker_wheels_rpg_fv"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
}

//Function Number: 5
local_init()
{
	self useanimtree(#animtree);
	thread manage_player_using_mobile_turret();
	thread monitor_vehicle_mount();
	thread animation_think();
	thread monitor_wheel_movements();
	thread clean_up_vehicle();
	maps\_utility::ent_flag_init("player_in_transition");
	common_scripts\utility::flag_init("player_in_x4walker");
	waittillframeend;
	self.mgturret[0] maketurretsolid();
	self.mgturret[0] useanimtree(#animtree);
	self notify("stop_vehicle_shoot_shock");
	vehicle_scripts\_x4walker_wheels_turret_aud::snd_init_x4_walker_wheels_turret();
}

//Function Number: 6
set_ai_anims()
{
	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].sittag = "tag_guy";
	return var_00;
}

//Function Number: 7
register_player_anims()
{
	level.scr_anim["_vehicle_player_rig"]["enter_left_turret"] = %x4walker_turret_cockpit_in_l_vm;
	level.scr_anim["_vehicle_player_rig"]["enter_right_turret"] = %x4walker_turret_cockpit_in_r_vm;
	level.scr_anim["_vehicle_player_rig"]["enter_back_turret"] = %x4walker_turret_cockpit_in_b_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_left_turret"] = %x4walker_turret_cockpit_out_l_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_right_turret"] = %x4walker_turret_cockpit_out_r_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_back_turret"] = %x4walker_turret_cockpit_out_b_vm;
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_left_turret");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_right_turret");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_back_turret");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_left_turret");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_right_turret");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_back_turret");
}

//Function Number: 8
manage_player_using_mobile_turret()
{
	self endon("death");
	self endon("disable_mobile_turret");
	thread handle_vehicle_dof();
	self.enter_use_tags = [];
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		var_01 = spawn("script_model",(0,0,0));
		var_01 setmodel("tag_origin");
		var_01 hide();
		self.enter_use_tags[var_00] = var_01;
	}

	var_02 = self gettagorigin("tag_body");
	var_03 = self gettagorigin("tag_wheel_front_left");
	var_04 = self gettagorigin("tag_wheel_front_right");
	var_05 = self gettagorigin("tag_wheel_back_left");
	var_06 = self gettagorigin("tag_wheel_back_right");
	self.enter_use_tags[0].origin = (var_03[0] + var_05[0] * 0.5,var_03[1] + var_05[1] * 0.5,var_02[2]);
	self.enter_use_tags[1].origin = (var_04[0] + var_06[0] * 0.5,var_04[1] + var_06[1] * 0.5,var_02[2]);
	self.enter_use_tags[2].origin = (var_05[0] + var_06[0] * 0.5,var_05[1] + var_06[1] * 0.5,var_02[2]);
	if(!isdefined(level.mt_use_tags))
	{
		level.mt_use_tags = [];
	}

	foreach(var_01 in self.enter_use_tags)
	{
		var_01 linkto(self);
		var_01 sethintstring(&"_X4WALKER_WHEELS_ENTER");
		var_01 makeusable();
		level.mt_use_tags[level.mt_use_tags.size] = var_01;
	}

	waittillframeend;
	self.tag_player_view = common_scripts\utility::spawn_tag_origin();
	self.tag_player_view linkto(self.mgturret[0],"tag_barrel",(-38.9526,6.01624,-46.3999),(0,0,0));
	self.hint_button_locations = [];
	self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
	self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin + anglestoright(self.mgturret[0].angles) * 60 + (0,0,10);
	self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
	self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoright(self.mgturret[0].angles) * 60 + (0,0,10);
	self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
	self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoforward(self.mgturret[0].angles) * 75 + (0,0,10);
	self.hint_buttons = [];
	foreach(var_0A in self.hint_button_locations)
	{
		var_0A dontinterpolate();
		var_0A linkto(self.mgturret[0]);
		self.hint_buttons[self.hint_buttons.size] = var_0A maps\_shg_utility::hint_button_create("x","tag_origin",50,150);
	}

	for(;;)
	{
		self makeunusable();
		wait_for_any_trigger_hit(self.enter_use_tags);
		if(isdefined(level.player.linked_to_cover))
		{
			continue;
		}

		maps\_utility::ent_flag_set("player_in_transition");
		soundscripts\_snd::snd_message("player_enter_walker_anim");
		var_0C = player_enter_turret();
		maps\_utility::ent_flag_clear("player_in_transition");
		thread monitor_turret_rotation_rate();
		level.player notify("player_in_x4walker");
		common_scripts\utility::flag_set("player_in_x4walker");
		disable_sonic_aoe();
		setsaveddvar("ammoCounterHide",1);
		var_0D = undefined;
		if(common_scripts\utility::flag_exist("seoul_player_can_exit_x4walker"))
		{
			common_scripts\utility::flag_wait("seoul_player_can_exit_x4walker");
		}
		else
		{
			var_0D = level.player thread display_exit_hint();
		}

		var_0E = undefined;
		while(!isdefined(var_0E))
		{
			wait_for_exit_message();
			if(!isalive(level.player) || !isdefined(level.player.drivingvehicleandturret))
			{
				break;
			}

			var_0E = find_best_exit_anim(var_0C);
			if(isdefined(level.template_script) && level.template_script == "seoul")
			{
				var_0E = "exit_back_turret";
			}

			if(!isdefined(var_0E))
			{
			}
		}

		if(isdefined(var_0D))
		{
			var_0D destroy();
		}

		maps\_utility::ent_flag_set("player_in_transition");
		level.player disableslowaim();
		self.mgturret[0] maketurretsolid();
		thread maps\_utility::lerp_fov_overtime(2,65);
		if(isdefined(level.player.drivingvehicleandturret) && isalive(level.player))
		{
			soundscripts\_snd::snd_message("player_exit_walker_anim");
			player_exit_turret(var_0E);
		}

		maps\_utility::ent_flag_clear("player_in_transition");
		common_scripts\utility::flag_clear("player_in_x4walker");
		enable_sonic_aoe();
		if(common_scripts\utility::flag_exist("seoul_player_can_exit_x4walker") && common_scripts\utility::flag("seoul_player_can_exit_x4walker"))
		{
			return;
		}
	}
}

//Function Number: 9
disable_sonic_aoe()
{
	thread maps\_sonicaoe::disablesonicaoe();
}

//Function Number: 10
enable_sonic_aoe()
{
	thread maps\_sonicaoe::enablesonicaoe();
}

//Function Number: 11
rotate_player_to_facing_angles(param_00)
{
	var_01 = level.player common_scripts\utility::spawn_tag_origin();
	level.player playerlinktoabsolute(var_01,"tag_origin");
	var_01 rotateto(param_00.angles,1);
	wait(1);
	level.player unlink();
	var_01 delete();
}

//Function Number: 12
display_exit_hint()
{
	var_00 = maps\_hud_util::createclientfontstring("default",1.5);
	var_00.alpha = 0.7;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.y = 100;
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 0;
	var_00.hidewhendead = 1;
	var_00.hidewheninmenu = 1;
	var_00 settext(&"_X4WALKER_WHEELS_EXIT");
	return var_00;
}

//Function Number: 13
getcompasstext(param_00)
{
	var_01 = getnorthyaw();
	param_00 = param_00 - var_01;
	if(param_00 < 0)
	{
		param_00 = param_00 + 360;
	}
	else if(param_00 > 360)
	{
		param_00 = param_00 - 360;
	}

	if(param_00 < 45 || param_00 > 315)
	{
		var_02 = "N";
	}
	else if(var_01 < 135)
	{
		var_02 = "E";
	}
	else if(var_01 < 225)
	{
		var_02 = "S";
	}
	else if(var_01 < 315)
	{
		var_02 = "W";
	}
	else
	{
		var_02 = "";
	}

	return var_02;
}

//Function Number: 14
warning_update_text()
{
	self endon("death");
	self waittill("play_damage_warning");
	self notify("destroy_compass_text");
	self.compass_text settext(&"FUSION_X4_WARNING");
	self.hud_warning.alpha = 1;
	self.compass_text thread pulse_compass_text();
}

//Function Number: 15
update_hud_text()
{
	self endon("death");
	self endon("player_exited_mobile_turret");
	self endon("destroy_hud_text");
	for(;;)
	{
		self.hud_text[0] settext(maps\_utility::round_float(self vehicle_getsteering(),1,0));
		self.hud_text[1] settext(maps\_utility::round_float(self vehicle_getspeed(),1,0));
		wait 0.05;
	}
}

//Function Number: 16
pulse_compass_text()
{
	self endon("death");
	self endon("player_exited_mobile_turret");
	self endon("destroy_hud_text");
	var_00 = -0.1;
	for(;;)
	{
		self.alpha = self.alpha + var_00;
		if(self.alpha <= 0 || self.alpha >= 1)
		{
			var_00 = var_00 * -1;
		}

		wait 0.05;
	}
}

//Function Number: 17
compass_update_text()
{
	self endon("destroy_hud_text");
	self endon("destroy_compass_text");
	for(;;)
	{
		var_00 = level.player getplayerangles();
		var_01 = getcompasstext(var_00[1]);
		self.compass_text settext(var_01);
		wait 0.05;
	}
}

//Function Number: 18
turret_hud_elem_init_nofade(param_00)
{
	self.alignx = "center";
	self.aligny = "middle";
	self.hidewhendead = 1;
	self.hidewheninmenu = 1;
	if(!level.x4walker_wheels_seoul_turret)
	{
		self.positioninworld = 1;
		self.relativeoffset = 1;
		self settargetent(param_00,"tag_aim_animated");
	}
}

//Function Number: 19
turret_hud_elem_init(param_00)
{
	self fadeovertime(0.5);
	self.alpha = 1;
	turret_hud_elem_init_nofade(param_00);
}

//Function Number: 20
turret_hud_elem_fadeout()
{
	self fadeovertime(0.1);
	self.alpha = 0;
}

//Function Number: 21
hudoutline_toggle_target(param_00)
{
	var_01 = self;
	var_02 = 1;
	if(issubstr(var_01.classname,"script_vehicle_cover_drone"))
	{
		return;
	}

	if((isdefined(var_01.team) && var_01.team == "allies") || isdefined(var_01.script_team) && var_01.script_team != "axis")
	{
		var_02 = 3;
	}

	if(param_00)
	{
		var_01 hudoutlineenable(var_02,1);
		return;
	}

	var_01 hudoutlinedisable();
}

//Function Number: 22
hudoutline_toggle_all(param_00)
{
	var_01 = [];
	var_01 = common_scripts\utility::array_combine(var_01,getaiarray("axis","allies"));
	var_01 = common_scripts\utility::array_combine(var_01,vehicle_getarray());
	foreach(var_03 in var_01)
	{
		var_03 hudoutline_toggle_target(param_00);
	}
}

//Function Number: 23
hudoutline_spawner_think()
{
	level endon("x4walker_hudoutline_think_stop");
	for(;;)
	{
		self waittill("spawned",var_00);
		var_00 hudoutline_toggle_target(1);
	}
}

//Function Number: 24
hudoutline_spawner_all()
{
	var_00 = [];
	var_00 = common_scripts\utility::array_combine(var_00,getspawnerarray());
	var_00 = common_scripts\utility::array_combine(var_00,vehicle_getspawnerarray());
	foreach(var_02 in var_00)
	{
		var_02 thread hudoutline_spawner_think();
	}
}

//Function Number: 25
hudoutline_dvars_set()
{
	if(!isdefined(level.hudoutlinedvars))
	{
		level.hudoutlinedvars = [];
	}

	level.hudoutlinedvars["r_hudoutlineenable"] = getdvar("r_hudoutlineenable",0);
	level.hudoutlinedvars["r_hudoutlinepostmode"] = getdvar("r_hudoutlinepostmode",0);
	level.hudoutlinedvars["r_hudoutlinehalolumscale"] = getdvar("r_hudoutlinehalolumscale",0);
	level.hudoutlinedvars["r_hudoutlinehaloblurradius"] = getdvar("r_hudoutlinehaloblurradius",0);
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehalolumscale",2);
	setsaveddvar("r_hudoutlinehaloblurradius",0.7);
}

//Function Number: 26
hudoutline_dvars_reset()
{
	if(!isdefined(level.hudoutlinedvars))
	{
		return;
	}

	foreach(var_01 in getarraykeys(level.hudoutlinedvars))
	{
		setsaveddvar(var_01,level.hudoutlinedvars[var_01]);
	}
}

//Function Number: 27
hudoutline_think()
{
	common_scripts\utility::flag_wait("player_in_x4walker");
	hudoutline_dvars_set();
	hudoutline_toggle_all(1);
	hudoutline_spawner_all();
	common_scripts\utility::flag_waitopen("player_in_x4walker");
	level notify("x4walker_hudoutline_think_stop");
	hudoutline_dvars_reset();
	hudoutline_toggle_all(0);
}

//Function Number: 28
player_show_turret_hud()
{
	var_00 = 100000;
	var_01 = 60;
	var_02 = -30000;
	var_03 = 25000;
	var_04 = 5000;
	var_05 = -23000;
	var_06 = 40000;
	var_07 = -40000;
	var_08 = -14500;
	var_09 = 28000;
	var_0A = 21500;
	var_0B = -22500;
	level.player endon("death");
	var_0C = getdvar("hud_fade_ammodisplay");
	setsaveddvar("hud_fade_ammodisplay",0.05);
	self.missiles = [];
	for(var_0D = 0;var_0D < 4;var_0D++)
	{
		if(var_0D > 1)
		{
			var_02 = var_03;
		}

		self.missiles[var_0D] = newhudelem();
		self.missiles[var_0D] setshader("bls_ui_turret_missle",48,48);
		self.missiles[var_0D] turret_hud_elem_init(self.mgturret[0]);
		self.missiles[var_0D].x = var_00;
		self.missiles[var_0D].y = var_02 + var_0D % 2 * var_04;
		self.missiles[var_0D].z = var_01 + var_05;
	}

	var_0E = newhudelem();
	var_0E setshader("bls_ui_turret_overlay_sm",1024,512);
	var_0E turret_hud_elem_init(self.mgturret[0]);
	var_0E.sort = 2;
	var_0E.x = var_00;
	var_0E.z = var_01;
	var_0F = undefined;
	if(level.x4walker_wheels_seoul_turret)
	{
		var_0F = newhudelem();
		var_0F setshader("bls_ui_turret_overlay_vignette",640,480);
		var_0F.horzalign = "fullscreen";
		var_0F.vertalign = "fullscreen";
	}

	self.chevron = newhudelem();
	self.chevron setshader("bls_ui_turret_chevron",32,32);
	self.chevron turret_hud_elem_init(self.mgturret[0]);
	self.chevron.x = var_00;
	self.chevron.y = var_06;
	self.chevron.z = var_01;
	self.chevron_right = newhudelem();
	self.chevron_right setshader("bls_ui_turret_chevron_right",32,32);
	self.chevron_right turret_hud_elem_init(self.mgturret[0]);
	self.chevron_right.x = var_00;
	self.chevron_right.y = var_07;
	self.chevron_right.z = var_01;
	self.compass_text = maps\_hud_util::createfontstring("small",1);
	self.compass_text turret_hud_elem_init(self.mgturret[0]);
	self.compass_text.x = var_00;
	self.compass_text.y = 0;
	self.compass_text.z = var_01 + var_0A;
	self.hud_warning = newhudelem();
	self.hud_warning setshader("bls_ui_turret_warning",90,24);
	self.hud_warning turret_hud_elem_init_nofade(self.mgturret[0]);
	self.hud_warning.alpha = 0;
	self.hud_warning.x = var_00;
	self.hud_warning.y = 0;
	self.hud_warning.z = var_01 + var_0A;
	self.hud_text = [];
	for(var_0D = 0;var_0D < 2;var_0D++)
	{
		self.hud_text[var_0D] = maps\_hud_util::createfontstring("hudsmall",0.75);
		self.hud_text[var_0D] turret_hud_elem_init(self.mgturret[0]);
		self.hud_text[var_0D].x = var_00;
		self.hud_text[var_0D].y = var_08 + var_0D * var_09;
		self.hud_text[var_0D].z = var_01 + var_0B;
	}

	thread update_hud_text();
	thread compass_update_text();
	thread warning_update_text();
	thread player_show_missile_reticle();
	if(isdefined(level.x4walker_wheels_fusion_turret) && level.x4walker_wheels_fusion_turret)
	{
		thread hudoutline_think();
	}

	common_scripts\utility::waittill_any("dismount_vehicle_and_turret","death");
	var_0E turret_hud_elem_fadeout();
	self.chevron turret_hud_elem_fadeout();
	self.chevron_right turret_hud_elem_fadeout();
	self.hud_warning turret_hud_elem_fadeout();
	self.compass_text turret_hud_elem_fadeout();
	foreach(var_11 in self.missiles)
	{
		var_11 turret_hud_elem_fadeout();
	}

	foreach(var_11 in self.hud_text)
	{
		var_11 turret_hud_elem_fadeout();
	}

	common_scripts\utility::waittill_any("player_exited_mobile_turret","death");
	setsaveddvar("hud_fade_ammodisplay",var_0C);
	var_0E destroy();
	if(isdefined(var_0F))
	{
		var_0F destroy();
	}

	self.chevron destroy();
	self.chevron_right destroy();
	self.hud_warning destroy();
	self notify("destroy_hud_text");
	self.compass_text destroy();
	foreach(var_11 in self.missiles)
	{
		var_11 destroy();
	}

	foreach(var_11 in self.hud_text)
	{
		var_11 destroy();
	}
}

//Function Number: 29
reticle_show()
{
	var_00 = 32;
	var_01 = 32;
	foreach(var_03 in self)
	{
		var_03 moveovertime(0.1);
		var_03.alpha = 1;
	}

	self["tl"].x = 0 - var_00;
	self["tl"].y = 0 - var_01;
	self["tr"].x = var_00;
	self["tr"].y = 0 - var_01;
	self["br"].x = var_00;
	self["br"].y = var_01;
	self["bl"].x = 0 - var_00;
	self["bl"].y = var_01;
	self["cross_l"].x = 0 - var_00;
	self["cross_l"].y = 0;
	self["cross_r"].x = var_00;
	self["cross_r"].y = 0;
	self["cross_b"].x = 0;
	self["cross_b"].y = 0 - var_01;
	self["cross_t"].x = 0;
	self["cross_t"].y = var_01;
}

//Function Number: 30
reticle_hide()
{
	var_00 = 16;
	var_01 = 16;
	foreach(var_03 in self)
	{
		var_03.alpha = 0;
	}

	self["tl"].x = 0 - var_00;
	self["tl"].y = 0 - var_01;
	self["tr"].x = var_00;
	self["tr"].y = 0 - var_01;
	self["br"].x = var_00;
	self["br"].y = var_01;
	self["bl"].x = 0 - var_00;
	self["bl"].y = var_01;
	self["cross_l"].x = 0 - var_00;
	self["cross_l"].y = 0;
	self["cross_r"].x = var_00;
	self["cross_r"].y = 0;
	self["cross_b"].x = 0;
	self["cross_b"].y = 0 - var_01;
	self["cross_t"].x = 0;
	self["cross_t"].y = var_01;
}

//Function Number: 31
player_show_missile_reticle()
{
	self.player_driver endon("death");
	var_00 = 16;
	var_01 = 16;
	self.reticle = [];
	self.reticle["tl"] = newhudelem();
	self.reticle["tr"] = newhudelem();
	self.reticle["br"] = newhudelem();
	self.reticle["bl"] = newhudelem();
	self.reticle["cross_l"] = newhudelem();
	self.reticle["cross_r"] = newhudelem();
	self.reticle["cross_b"] = newhudelem();
	self.reticle["cross_t"] = newhudelem();
	foreach(var_03 in self.reticle)
	{
		var_03.elemtype = "icon";
		var_03.width = 32;
		var_03.height = 32;
		var_03.foreground = 1;
		var_03.children = [];
		var_03 maps\_hud_util::setparent(level.uiparent);
		var_03.alignx = "center";
		var_03.aligny = "middle";
		var_03.horzalign = "center";
		var_03.vertalign = "middle";
		var_03.alpha = 0;
		var_03.hidewhendead = 1;
	}

	self.reticle["tl"].x = 0 - var_00;
	self.reticle["tl"].y = 0 - var_01;
	self.reticle["tl"] setshader("bls_ui_turret_reticle_tl",32,32);
	self.reticle["tr"].x = var_00;
	self.reticle["tr"].y = 0 - var_01;
	self.reticle["tr"] setshader("bls_ui_turret_reticle_tr",32,32);
	self.reticle["br"].x = var_00;
	self.reticle["br"].y = var_01;
	self.reticle["br"] setshader("bls_ui_turret_reticle_br",32,32);
	self.reticle["bl"].x = 0 - var_00;
	self.reticle["bl"].y = var_01;
	self.reticle["bl"] setshader("bls_ui_turret_reticle_bl",32,32);
	self.reticle["cross_l"].x = 0 - var_00;
	self.reticle["cross_l"].y = 0;
	self.reticle["cross_l"] setshader("bls_ui_turret_reticule_hpip",16,16);
	self.reticle["cross_r"].x = var_00;
	self.reticle["cross_r"].y = 0;
	self.reticle["cross_r"] setshader("bls_ui_turret_reticule_hpip",16,16);
	self.reticle["cross_b"].x = 0;
	self.reticle["cross_b"].y = 0 - var_01;
	self.reticle["cross_b"] setshader("bls_ui_turret_reticule_vpip",16,16);
	self.reticle["cross_t"].x = 0;
	self.reticle["cross_t"].y = var_01;
	self.reticle["cross_t"] setshader("bls_ui_turret_reticule_vpip",16,16);
	self waittill("dismount_vehicle_and_turret");
	foreach(var_03 in self.reticle)
	{
		var_03 turret_hud_elem_fadeout();
	}

	self waittill("player_exited_mobile_turret");
	foreach(var_03 in self.reticle)
	{
		var_03 destroy();
	}
}

//Function Number: 32
player_enter_turret()
{
	level.player endon("death");
	self endon("disable_mobile_turret");
	if(!isalive(level.player))
	{
		return;
	}

	level.player enabledeathshield(1);
	foreach(var_01 in self.enter_use_tags)
	{
		var_01 makeunusable();
	}

	foreach(var_04 in self.hint_buttons)
	{
		if(isdefined(var_04))
		{
			var_04 maps\_shg_utility::hint_button_clear();
		}
	}

	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	var_06 = maps\_vehicle_shg::spawn_player_rig();
	var_06 hide();
	var_07 = distancesquared(level.player.origin,self.enter_use_tags[0].origin);
	var_08 = distancesquared(level.player.origin,self.enter_use_tags[1].origin);
	var_09 = distancesquared(level.player.origin,self.enter_use_tags[2].origin);
	var_0A = var_07;
	var_0B = "enter_left_turret";
	if(var_08 < var_0A)
	{
		var_0A = var_08;
		var_0B = "enter_right_turret";
	}

	if(var_09 < var_0A)
	{
		var_0A = var_09;
		var_0B = "enter_back_turret";
	}

	level.player notify("player_starts_entering_mobile_turret");
	maps\_anim::anim_first_frame_solo(var_06,var_0B,"tag_body");
	level.player playerlinktoblend(var_06,"tag_player",0.2,0.1,0.1);
	wait(0.2);
	thread maps\_utility::lerp_fov_overtime(2,55);
	var_06 show();
	var_06 dontcastshadows();
	var_06.vehicle_to_swap = self;
	maps\_anim::anim_single_solo(var_06,var_0B,"tag_body");
	level.player unlink();
	var_06 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	if(level.x4walker_wheels_seoul_turret)
	{
	}
	else
	{
		level.player drivevehicleandcontrolturret(self);
	}

	self.mgturret[0] setcontents(0);
	self.mgturret[0] useby(level.player);
	self.mgturret[0] makeunusable();
	level.player disableturretdismount();
	if(level.x4walker_wheels_seoul_turret)
	{
		level.player playerlinkto(self.mgturret[0],"tag_guy",0,180,180,90,2,0);
	}
	else
	{
		level.player playerlinkto(self.mgturret[0],"tag_guy",0,180,180,11,13,0);
	}

	level.player.drivingvehicleandturret = self;
	level.player playerlinkedturretanglesenable();
	if(level.x4walker_wheels_seoul_turret)
	{
		level.player enableslowaim(0.65,0.65);
	}
	else
	{
		level.player enableslowaim(0.5,0.35);
	}

	self.player_driver = level.player;
	thread camera_shake();
	self.player_driver playrumbleonentity("damage_light");
	thread randomize_turret_spread();
	self notify("driving_vehicle_and_turret");
	self.player_driver notify("player_enters_mobile_turret");
	thread vehicle_scripts\_x4walker_wheels_turret_aud::snd_start_x4_walker_wheels_turret("plr");
	thread player_show_turret_hud();
	if(level.x4walker_player_invulnerability)
	{
		level.player enabledeathshield(0);
		level.player enableinvulnerability();
	}

	return var_0B;
}

//Function Number: 33
camera_shake()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	level.player endon("death");
	var_00 = 7;
	var_01 = 512;
	var_02 = 0.5;
	var_03 = 1;
	for(;;)
	{
		if(self vehicle_getspeed() == 0)
		{
			var_04 = 0.08;
		}
		else
		{
			var_04 = 0.12;
		}

		earthquake(var_04,var_00,level.player.origin,var_01);
		wait(var_03 + randomfloat(var_02));
	}
}

//Function Number: 34
randomize_turret_spread()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	level.player endon("death");
	for(;;)
	{
		var_00 = randomfloatrange(0.2,1);
		self.mgturret[0] setplayerspread(var_00);
		wait(0.05);
	}
}

//Function Number: 35
find_best_exit_anim(param_00)
{
	var_01 = ["exit_left_turret","exit_right_turret","exit_back_turret"];
	var_02 = [0,1,2];
	if(isdefined(param_00))
	{
		if(param_00 == "enter_right_turret")
		{
			var_02 = [1,0,2];
		}
	}

	var_03 = maps\_vehicle_shg::spawn_player_rig();
	var_03 hide();
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_02[var_04];
		var_06 = var_01[var_05];
		var_07 = var_03 maps\_utility::getanim(var_06);
		maps\_anim::anim_first_frame_solo(var_03,var_06,"tag_body");
		var_08 = getmovedelta(var_07,0,1);
		var_09 = var_03 localtoworldcoords(var_08);
		var_0A = var_09 + (0,0,15);
		var_0B = playerphysicstrace(var_0A,var_09);
		var_0C = var_0B[2] - var_09[2];
		if(var_0C < 1)
		{
			var_03 delete();
			return var_06;
		}
	}

	var_03 delete();
	return undefined;
}

//Function Number: 36
player_exit_turret(param_00)
{
	level.player endon("death");
	self endon("disable_mobile_turret");
	if(!isalive(level.player))
	{
		return;
	}

	level.player disableinvulnerability();
	level.player enabledeathshield(1);
	self.mgturret[0] setturretdismountorg(self.tag_player_view.origin);
	self.mgturret[0] useby(level.player);
	level.player playerlinktodelta(self.tag_player_view,"tag_origin",1);
	level.player maps\_shg_utility::setup_player_for_scene();
	wait_for_turret_reset();
	level.player unlink();
	var_01 = maps\_vehicle_shg::spawn_player_rig();
	var_01 hide();
	maps\_anim::anim_first_frame_solo(var_01,param_00,"tag_body");
	level.player playerlinktoblend(var_01,"tag_player",0.2,0.1,0.1);
	wait(0.2);
	var_01 show();
	var_01 dontcastshadows();
	var_01.vehicle_to_swap = self;
	level.player.drivingvehicleandturret = undefined;
	self.player_driver = undefined;
	if(!isdefined(self.burning))
	{
		if(!level.x4walker_wheels_seoul_turret)
		{
			level.player drivevehicleandcontrolturretoff(self);
		}
	}
	else if(isdefined(self.damage_fx))
	{
		foreach(var_03 in self.damage_fx)
		{
			stopfxontag(common_scripts\utility::getfx(var_03.name),self.mgturret[0],var_03.tag);
		}
	}

	self notify("dismount_vehicle_and_turret");
	level.player playerlinktodelta(var_01,"tag_player",1,0,0,0,0,1);
	thread vehicle_scripts\_x4walker_wheels_turret_aud::snd_start_x4_walker_wheels_turret("npc");
	maps\_anim::anim_single_solo(var_01,param_00,"tag_body");
	level.player playrumbleonentity("damage_light");
	level.player unlink();
	var_01 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	foreach(var_06 in self.enter_use_tags)
	{
		var_06 makeusable();
	}

	self.hint_buttons = [];
	foreach(var_09 in self.hint_button_locations)
	{
		self.hint_buttons[self.hint_buttons.size] = var_09 maps\_shg_utility::hint_button_create("x","tag_origin",50,150);
	}

	level.player enabledeathshield(0);
	self notify("player_exited_mobile_turret");
	level.player notify("player_exited_mobile_turret");
}

//Function Number: 37
wait_for_turret_reset()
{
	var_00 = 0;
	while(!var_00)
	{
		wait(0.05);
		var_01 = self.mgturret[0] gettagangles("tag_barrel");
		var_02 = anglestoforward(self.angles);
		var_03 = anglestoforward(var_01);
		var_04 = vectordot(var_02,var_03);
		var_00 = var_04 > 0.95;
	}
}

//Function Number: 38
handle_vehicle_dof()
{
	self endon("death");
	for(;;)
	{
		self waittill("enter_vehicle_dof");
		maps\_art::dof_enable_script(10,70,4,9500,10000,0,0.5);
		self waittill("exit_vehicle_dof");
		maps\_art::dof_disable_script(0.5);
	}
}

//Function Number: 39
wait_for_exit_message()
{
	self endon("dismount_vehicle_and_turret");
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
}

//Function Number: 40
wait_for_any_trigger_hit(param_00)
{
	if(param_00.size > 1)
	{
		for(var_01 = 1;var_01 < param_00.size;var_01++)
		{
			param_00[var_01] endon("trigger");
		}
	}

	if(param_00.size > 0)
	{
		param_00[0] waittill("trigger");
	}
}

//Function Number: 41
make_mobile_turret_usable()
{
	self makeunusable();
	if(isdefined(self.enter_use_tags))
	{
		foreach(var_01 in self.enter_use_tags)
		{
			var_01 makeusable();
		}
	}

	if(isdefined(self.hint_button_locations))
	{
		self.hint_buttons = [];
		foreach(var_04 in self.hint_button_locations)
		{
			self.hint_buttons[self.hint_buttons.size] = var_04 maps\_shg_utility::hint_button_create("x","tag_origin",50,150);
		}
	}
}

//Function Number: 42
make_mobile_turret_unusable()
{
	self makeunusable();
	if(isdefined(self.enter_use_tags))
	{
		foreach(var_01 in self.enter_use_tags)
		{
			var_01 makeunusable();
		}
	}

	if(isdefined(self.hint_buttons))
	{
		foreach(var_04 in self.hint_buttons)
		{
			var_04 maps\_shg_utility::hint_button_clear();
		}

		self.hint_buttons = [];
	}
}

//Function Number: 43
monitor_vehicle_mount()
{
	self endon("death");
	self setanim(maps\_vehicle_shg::get_vehicle_anim("idle"));
	for(;;)
	{
		self waittill("driving_vehicle_and_turret");
		if(!isdefined(self.player_driver))
		{
			thread handle_vehicle_ai();
			make_mobile_turret_unusable();
		}
		else
		{
			thread monitor_turret_shoot();
			thread camera_shake_on_turret_fire();
			thread rocket_think();
		}

		wait_for_exit_message();
	}
}

//Function Number: 44
animation_think()
{
	self endon("death");
	for(;;)
	{
		self waittill("play_anim",var_00);
		clear_anims();
		self setanim(maps\_vehicle_shg::get_vehicle_anim(var_00),1,0.2,1);
	}
}

//Function Number: 45
clear_anims()
{
	self clearanim(%walker_wheels_turret,0.2);
}

//Function Number: 46
monitor_turret_shoot()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	for(;;)
	{
		self.mgturret[0] waittill("turret_fire");
		self.mgturret[0] setanimrestart(%x4walker_wheels_turret_cockpit_fire,1,0,1);
	}
}

//Function Number: 47
camera_shake_on_turret_fire()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	for(;;)
	{
		self.mgturret[0] waittill("turret_fire");
		earthquake(0.2,0.1,self.player_driver.origin,128);
		self.player_driver playrumbleonentity("heavy_1s");
	}
}

//Function Number: 48
rocket_think()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	self endon("end_rocket_think");
	thread monitor_missile_input();
	for(;;)
	{
		self waittill("target_missile_system");
		thread rocket_target_think();
		self waittill("fire_missile_system");
		thread fire_rockets();
		if(isdefined(self.rocket_targets) && self.rocket_targets.size > 0)
		{
			self notify("disable_missile_input");
			wait(2);
			self.mgturret[0] setanimknob(%x4walkersplit_cockpit_rockets_down,1,0.2,1);
			wait(0.5);
			self.mgturret[0] setanimknob(%x4walkersplit_cockpit_rockets_up,1,0.2,1);
			thread monitor_missile_input();
		}
	}
}

//Function Number: 49
rocket_target_think()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	self endon("fire_missile_system");
	if(!isdefined(self.rocket_targets))
	{
		self.rocket_targets = [];
	}

	var_00 = 4;
	for(;;)
	{
		if(self.rocket_targets.size < var_00)
		{
			add_target_on_dot();
		}

		wait(0.05);
	}
}

//Function Number: 50
acquired_animation(param_00)
{
	self endon("death");
	param_00 endon("dismount_vehicle_and_turret");
	wait(0.3);
	target_setshader(self,"bls_ui_turret_targetlock_white");
}

//Function Number: 51
add_target_on_los()
{
	var_00 = anglestoforward(self.player_driver getplayerangles());
	var_00 = vectornormalize(var_00);
	var_01 = self.player_driver geteye();
	var_02 = bullettrace(var_01,var_01 + var_00 * 2048,1,self);
	var_03 = var_02["entity"];
	if(isdefined(var_03) && isai(var_03) && isalive(var_03) && !maps\_vehicle_code::attacker_isonmyteam(var_03) && !maps\_vehicle_code::attacker_troop_isonmyteam(var_03))
	{
		if(!isdefined(var_03.target_marked) || !var_03.target_marked)
		{
			var_03.target_marked = 1;
			target_set(var_03,(0,0,20));
			target_setshader(var_03,"bls_ui_turret_targetacquired");
			var_03 thread acquired_animation(self);
			soundscripts\_snd::snd_message("x4_walker_hud_target_aquired",var_03);
			thread remove_target(var_03);
			self.rocket_targets[self.rocket_targets.size] = var_03;
		}
	}
}

//Function Number: 52
update_missile_hud()
{
	if(isdefined(self.missiles) && isdefined(self.rocket_targets))
	{
		for(var_00 = 0;var_00 < self.rocket_targets.size;var_00++)
		{
			self.missiles[var_00] fadeovertime(0.1);
			self.missiles[var_00].alpha = 0.1;
		}

		while(var_00 < self.missiles.size)
		{
			self.missiles[var_00] fadeovertime(0.1);
			self.missiles[var_00].alpha = 1;
			var_00++;
		}
	}
}

//Function Number: 53
add_target_on_dot()
{
	var_00 = anglestoforward(self.player_driver getplayerangles());
	var_00 = vectornormalize(var_00);
	var_01 = self.player_driver geteye();
	var_02 = (0,0,32);
	var_03 = get_all_valid_rocket_targets();
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.target_marked) && var_05.target_marked)
		{
			continue;
		}

		if(isdefined(var_05.ridingvehicle))
		{
			if(!isdefined(var_05.rappeller) || !var_05.rappeller)
			{
				continue;
			}
		}

		var_06 = var_05.origin;
		if(isai(var_05))
		{
			var_06 = var_05 geteye();
		}

		var_07 = var_06 - var_01;
		var_08 = length(var_07);
		if(var_08 > 2648)
		{
			var_09 = bullettrace(var_01,var_06 + get_missile_target_offset(var_05),1,self);
			if(!isdefined(var_09["entity"]) || !var_09["entity"] == var_05)
			{
				continue;
			}
		}

		var_07 = vectornormalize(var_07);
		var_0A = vectordot(var_00,var_07);
		var_0B = abs(acos(var_0A));
		if(var_0B > 4)
		{
			continue;
		}

		var_05.target_marked = 1;
		target_set(var_05,(0,0,20));
		target_setshader(var_05,"bls_ui_turret_targetacquired");
		var_05 thread acquired_animation(self);
		soundscripts\_snd::snd_message("x4_walker_hud_target_aquired",var_05);
		thread remove_target(var_05);
		self.rocket_targets[self.rocket_targets.size] = var_05;
		return;
	}
}

//Function Number: 54
get_missile_target_offset(param_00)
{
	if(isai(param_00))
	{
		return (0,0,0);
	}

	if(isdefined(param_00.vehicletype))
	{
		if(param_00 maps\_vehicle::ishelicopter())
		{
			return (0,0,-80);
		}

		return (0,0,48);
	}

	if(isdefined(param_00.destructibleinfo))
	{
		return (0,0,48);
	}

	return (0,0,0);
}

//Function Number: 55
get_all_valid_rocket_targets()
{
	var_00 = getaiarray("axis");
	var_01 = getentarray("script_vehicle","code_classname");
	var_02 = [];
	foreach(var_04 in var_00)
	{
		if(!isalive(var_04))
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	foreach(var_07 in var_01)
	{
		if(isspawner(var_07))
		{
			continue;
		}

		if(!isalive(var_07))
		{
			continue;
		}

		if(isdefined(var_07.script_team) && var_07.script_team != "axis")
		{
			continue;
		}

		if(isdefined(var_07.mobile_turret_rocket_target) && !var_07.mobile_turret_rocket_target)
		{
			continue;
		}

		var_02[var_02.size] = var_07;
	}

	return var_02;
}

//Function Number: 56
remove_target(param_00)
{
	wait_to_remove_target(param_00);
	if(isdefined(param_00))
	{
		param_00.target_marked = undefined;
		target_remove(param_00);
	}

	if(isdefined(self) && isdefined(self.rocket_targets))
	{
		var_01 = [];
		foreach(var_03 in self.rocket_targets)
		{
			if(isdefined(var_03))
			{
				if(isdefined(param_00) && var_03 == param_00)
				{
					continue;
				}

				var_01[var_01.size] = var_03;
			}
		}

		self.rocket_targets = var_01;
	}
}

//Function Number: 57
wait_to_remove_target(param_00)
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	self endon("force_clear_all_turret_locks");
	param_00 endon("death");
	param_00 waittill("remove_target");
}

//Function Number: 58
monitor_missile_input()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	self endon("disable_missile_input");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		var_01 = self.player_driver fragbuttonpressed();
		if(var_01 && !var_00)
		{
			var_00 = 1;
			setsaveddvar("cg_drawCrosshair",0);
			self.reticle reticle_show();
			self notify("target_missile_system");
		}
		else if(!var_01 && var_00)
		{
			var_00 = 0;
			setsaveddvar("cg_drawCrosshair",1);
			self.reticle reticle_hide();
			self notify("fire_missile_system");
		}

		update_missile_hud();
	}

	setsaveddvar("cg_drawCrosshair",1);
}

//Function Number: 59
fire_rockets()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	var_00 = [];
	foreach(var_02 in self.rocket_targets)
	{
		var_00[var_00.size] = var_02;
	}

	var_04 = 0;
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.target_marked))
		{
			continue;
		}

		self.player_driver playrumbleonentity("heavy_1s");
		earthquake(0.3,1,self.player_driver.origin,256);
		target_setshader(var_02,"bls_ui_turret_targetlock");
		soundscripts\_snd::snd_message("x4_walker_hud_missile_launched",var_02);
		thread fire_rocket_at(var_02,var_04);
		var_04++;
		wait(0.35);
	}
}

//Function Number: 60
fire_rocket_at(param_00,param_01)
{
	if(!isdefined(self.launcher_index))
	{
		self.launcher_index = 0;
	}
	else
	{
		self.launcher_index++;
		self.launcher_index = self.launcher_index % 4;
	}

	var_02 = param_00.origin;
	param_01 = self.launcher_index + 1;
	var_03 = "TAG_LAUNCHER" + param_01;
	var_04 = undefined;
	switch(param_01)
	{
		case 1:
			var_04 = %x4walkersplit_cockpit_rockets_fire4;
			break;

		case 2:
			var_04 = %x4walkersplit_cockpit_rockets_fire3;
			break;

		case 3:
			var_04 = %x4walkersplit_cockpit_rockets_fire2;
			break;

		case 4:
			var_04 = %x4walkersplit_cockpit_rockets_fire1;
			break;
	}

	self.mgturret[0] setanimknob(var_04,1,0,1);
	var_05 = self.mgturret[0] gettagorigin(var_03);
	var_06 = self.mgturret[0] gettagangles(var_03);
	var_07 = var_05 + anglestoforward(var_06) * 512;
	playfxontag(common_scripts\utility::getfx("x4walker_wheels_rpg_fv"),self.mgturret[0],var_03);
	if(isdefined(self.player_driver))
	{
		var_08 = magicbullet("mobile_turret_missile",var_05,var_07,self.player_driver);
	}
	else
	{
		var_08 = magicbullet("mobile_turret_missile",var_06,var_08);
	}

	var_08 soundscripts\_snd::snd_message("x4_walker_fire_missile",param_00);
	var_08 missile_settargetent(param_00);
	var_08 missile_setflightmodedirect();
	var_08 waittill("death");
	if(isdefined(param_00))
	{
		if(isai(param_00))
		{
			check_fire_and_forget();
		}

		param_00 notify("remove_target");
	}
}

//Function Number: 61
check_fire_and_forget()
{
	if(getdvar("mapname") == "fusion")
	{
		if(!isdefined(level.fire_and_forget))
		{
			level.fire_and_forget = 0;
		}

		level.fire_and_forget++;
		if(level.fire_and_forget >= 10 && level.fire_and_forget < 20)
		{
			maps\_utility::giveachievement_wrapper("LEVEL_4A");
		}
	}
}

//Function Number: 62
handle_vehicle_ai()
{
	if(isdefined(self.ai_func_override))
	{
		self thread [[ self.ai_func_override ]]();
		return;
	}

	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
}

//Function Number: 63
swap_cockpit_model(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.vehicle_to_swap))
	{
		param_00.vehicle_to_swap notify("enter_vehicle_dof");
		param_00.vehicle_to_swap setmodel("vehicle_vm_x4walkerSplit_wheels");
		param_00.vehicle_to_swap.mgturret[0] setmodel("vehicle_vm_x4walkerSplit_turret");
		param_00.vehicle_to_swap vehicle_teleport(param_00.vehicle_to_swap.origin,param_00.vehicle_to_swap.angles);
		param_00.vehicle_to_swap notify("play_anim","cockpit_idle");
		level notify("swapped_x4walker",param_00.vehicle_to_swap);
	}
}

//Function Number: 64
swap_world_model(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.vehicle_to_swap))
	{
		param_00.vehicle_to_swap notify("exit_vehicle_dof");
		param_00.vehicle_to_swap setmodel("vehicle_npc_x4walkerSplit_wheels");
		param_00.vehicle_to_swap.mgturret[0] setmodel("vehicle_npc_x4walkerSplit_turret");
		param_00.vehicle_to_swap vehicle_teleport(param_00.vehicle_to_swap.origin,param_00.vehicle_to_swap.angles);
		param_00.vehicle_to_swap notify("play_anim","idle");
	}
}

//Function Number: 65
clean_up_vehicle()
{
	self waittill("death");
	if(isdefined(self))
	{
		if(isdefined(self.enter_use_tags))
		{
			foreach(var_01 in self.enter_use_tags)
			{
				var_01 delete();
			}
		}

		if(isdefined(self.hint_buttons))
		{
			foreach(var_04 in self.hint_buttons)
			{
				var_04 maps\_shg_utility::hint_button_clear();
			}

			self.hint_buttons = [];
		}

		if(isdefined(self.tag_player_view))
		{
			self.tag_player_view delete();
		}
	}
}

//Function Number: 66
clean_up_vehicle_seoul()
{
	if(isdefined(self))
	{
		if(isdefined(self.enter_use_tags))
		{
			foreach(var_01 in self.enter_use_tags)
			{
				var_01 delete();
			}
		}

		if(isdefined(self.tag_player_view))
		{
			self.tag_player_view delete();
		}
	}
}

//Function Number: 67
monitor_wheel_movements()
{
	self endon("death");
	level endon("kill_wheel_watcher");
	var_00 = ["tag_wheel_back_left","tag_wheel_back_right","tag_wheel_front_left","tag_wheel_front_right"];
	self.last_wheel_pos = [];
	self.current_wheel_pos = [];
	var_01 = 0.05;
	if(level.currentgen)
	{
		var_01 = 0.5;
	}

	for(;;)
	{
		foreach(var_03 in var_00)
		{
			self.current_wheel_pos[var_03] = self gettagorigin(var_03);
		}

		wait(var_01);
		foreach(var_03 in var_00)
		{
			self.last_wheel_pos[var_03] = self.current_wheel_pos[var_03];
		}
	}
}

//Function Number: 68
monitor_turret_rotation_rate()
{
	self endon("death");
	self endon("dismount_vehicle_and_turret");
	self.gun_struct = spawnstruct();
	self.gun_struct.data_index = 0;
	self.gun_struct.max_points = 3;
	self.gun_struct.data = [];
	for(var_00 = 0;var_00 < self.gun_struct.max_points;var_00++)
	{
		self.gun_struct.data[var_00] = spawnstruct();
		var_01 = self.player_driver getplayerangles();
		self.gun_struct.data[self.gun_struct.data_index].yaw = var_01[1];
		self.gun_struct.data[self.gun_struct.data_index].pitch = var_01[0];
		self.gun_struct.data[self.gun_struct.data_index].time = gettime();
		self.gun_struct.data_index = self.gun_struct.data_index + 1 % self.gun_struct.max_points;
	}

	for(;;)
	{
		if(isdefined(self.player_driver) && isdefined(self.mgturret[0]))
		{
			var_01 = self.player_driver getplayerangles();
			self.gun_struct.data[self.gun_struct.data_index].yaw = var_01[1];
			self.gun_struct.data[self.gun_struct.data_index].pitch = var_01[0];
			self.gun_struct.data[self.gun_struct.data_index].time = gettime();
			self.gun_struct.data_index = self.gun_struct.data_index + 1 % self.gun_struct.max_points;
			var_02 = angleclamp180(var_01[0]);
			var_03 = maps\_shg_utility::linear_map_clamp(var_02,-11,13,-6400,25000);
			self.chevron.z = var_03;
			var_02 = angleclamp(var_01[1]);
			var_03 = maps\_shg_utility::linear_map_clamp(var_02,0,360,-6400,25000);
			self.chevron_right.z = var_03;
		}

		wait(0.05);
	}
}

//Function Number: 69
get_wheel_velocity(param_00)
{
	if(isdefined(self.current_wheel_pos[param_00]) && isdefined(self.last_wheel_pos[param_00]))
	{
		var_01 = self.current_wheel_pos[param_00] - self.last_wheel_pos[param_00];
		return var_01 * 20;
	}

	return (0,0,0);
}

//Function Number: 70
get_gun_pitch_rate()
{
	if(!isdefined(self.gun_struct))
	{
		return 0;
	}

	var_00 = self.gun_struct.data_index;
	var_01 = self.gun_struct.data_index + 1 % self.gun_struct.max_points;
	var_02 = self.gun_struct.data_index + self.gun_struct.max_points - 1 % self.gun_struct.max_points;
	var_03 = self.gun_struct.data[var_00].pitch + self.gun_struct.data[var_01].pitch / 2;
	var_04 = self.gun_struct.data[var_01].pitch + self.gun_struct.data[var_02].pitch / 2;
	var_05 = angleclamp180(var_04 - var_03);
	var_06 = self.gun_struct.data[var_02].time - self.gun_struct.data[var_00].time;
	return var_05 * 1000 / var_06;
}

//Function Number: 71
get_gun_yaw_rate()
{
	if(!isdefined(self.gun_struct))
	{
		return 0;
	}

	var_00 = self.gun_struct.data_index;
	var_01 = self.gun_struct.data_index + 1 % self.gun_struct.max_points;
	var_02 = self.gun_struct.data_index + self.gun_struct.max_points - 1 % self.gun_struct.max_points;
	var_03 = self.gun_struct.data[var_00].yaw + self.gun_struct.data[var_01].yaw / 2;
	var_04 = self.gun_struct.data[var_01].yaw + self.gun_struct.data[var_02].yaw / 2;
	var_05 = angleclamp180(self.gun_struct.data[var_02].yaw - self.gun_struct.data[var_00].yaw);
	var_06 = self.gun_struct.data[var_02].time - self.gun_struct.data[var_00].time;
	return var_05 * 1000 / var_06;
}
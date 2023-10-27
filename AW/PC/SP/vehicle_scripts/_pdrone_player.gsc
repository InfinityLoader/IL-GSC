/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_pdrone_player.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 857 ms
 * Timestamp: 10/27/2023 2:06:30 AM
*******************************************************************/

//Function Number: 1
_precache()
{
	precachemodel("vehicle_sniper_drone_outerparts");
	precachemodel("vehicle_vm_sniper_drone");
	precachemodel("vehicle_pdrone_player");
	precachemodel("dem_tablet_pc_01");
	precachemodel("worldhands_atlas_pmc_smp");
	precacheshader("overlay_static_digital");
	precacheshader("s1_pdrone_player_overlay");
	precacheshader("ugv_vignette_overlay");
}

//Function Number: 2
_anims_player()
{
	level.scr_model["drone_deploy_player_arms"] = "worldhands_atlas_pmc_smp";
	level.scr_animtree["drone_deploy_player_arms"] = #animtree;
	level.scr_anim["drone_deploy_player_arms"]["deploy"] = %assault_drone_deploy_vm;
	level.scr_anim["drone_deploy_player_arms"]["use"] = %rec_drone_deploy_vm;
	level.scr_anim["drone_deploy_player_arms"]["stop_use"] = %rec_drone_deploy_out_vm;
}

//Function Number: 3
_anims_drone()
{
	level.scr_model["drone_deploy_drone"] = "vehicle_pdrone_player";
	level.scr_animtree["drone_deploy_drone"] = #animtree;
	level.scr_anim["drone_deploy_drone"]["deploy"] = %assault_drone_deploy;
}

//Function Number: 4
_anims_proxy()
{
	level.scr_animtree["drone_player_proxy"] = #animtree;
	level.scr_anim["drone_player_proxy"]["loop"][0] = %pdrone_player_proxy_idle;
}

//Function Number: 5
_anims()
{
	_anims_player();
	_anims_drone();
	_anims_proxy();
}

//Function Number: 6
_fx()
{
	level._effect["pdrone_large_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_large_explosion");
}

//Function Number: 7
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("pdrone_player",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_life(10000,0,10000);
	maps\_vehicle::build_turret("pdrone_player_turret_sp","tag_origin","vehicle_sniper_drone_turret_mp",undefined,"manual",0.2,0,0,(0,0,0));
	_precache();
	_anims();
	_fx();
}

//Function Number: 8
init_local()
{
	thread start_player_pdrone_audio();
}

//Function Number: 9
start_player_pdrone_audio()
{
	var_00 = spawnstruct();
	var_00.preset_name = "pdrone_player";
	var_01 = ::vehicle_scripts\_pdrone_player_aud::snd_pdrone_player_constructor;
	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 10
pdrone_deploy_check(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 125;
	}

	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(!isdefined(param_02))
	{
		param_02 = 45;
	}

	var_03 = level.player geteye();
	var_04 = 1;
	var_05 = common_scripts\utility::flat_angle(level.player getgunangles());
	var_06 = 0;
	var_07 = 0;
	if(var_07 <= 5)
	{
		var_08 = (1,0,0);
		var_09 = var_05;
		switch(var_07)
		{
			case 1:
				break;

			case 2:
				break;

			case 3:
				break;

			case 4:
				break;

			case 5:
				break;
		}
	}
}

//Function Number: 11
pdrone_deploy(param_00,param_01,param_02)
{
	var_03 = maps\_utility::spawn_anim_model("drone_deploy_player_arms",level.player.origin);
	var_04 = maps\_utility::spawn_anim_model("drone_deploy_drone",level.player.origin);
	var_05 = level.player common_scripts\utility::spawn_tag_origin();
	level.player enableinvulnerability();
	level.player maps\_shg_utility::setup_player_for_scene();
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06 linkto(var_03,"tag_player",(0,0,0),(0,0,0));
	if(level.player getstance() == "prone")
	{
		while(level.player getstance() != "crouch")
		{
			level.player setstance("crouch");
			wait 0.05;
		}

		var_07 = 49;
	}

	var_07 = 0;
	if(level.player getstance() == "crouch")
	{
		var_07 = 20;
	}

	level.player.dronedeploystance = level.player getstance();
	var_03.origin = level.player.origin - (0,0,var_07);
	var_04.origin = level.player.origin - (0,0,var_07);
	var_05.origin = level.player.origin - (0,0,var_07);
	var_05 maps\_anim::anim_first_frame_solo(var_03,"deploy");
	soundscripts\_snd::snd_message("snd_player_drone_deploy",var_04);
	var_03 hide();
	var_08 = 0.5;
	level.player playerlinktoblend(var_06,"tag_origin",var_08);
	wait(var_08);
	var_03 show();
	thread introscreen_fade_in();
	var_05 maps\_anim::anim_single([var_03,var_04],"deploy");
	var_09 = param_00 maps\_utility::spawn_vehicle();
	var_09 setmodel("vehicle_pdrone_player");
	if(isdefined(param_02))
	{
		var_09 vehicle_teleport(param_02.origin,param_02.angles);
	}
	else
	{
		var_09 vehicle_teleport(var_04.origin,var_04.angles);
	}

	level.player unlink();
	var_03 delete();
	var_04 delete();
	var_05 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableinvulnerability();
	if(isdefined(param_01) && param_01)
	{
		var_09 thread pdrone_orient_to_closest_ai_target();
	}

	return var_09;
}

//Function Number: 12
pdrone_orient_to_closest_target(param_00)
{
	if(!isdefined(param_00) || param_00.size == 0)
	{
		return;
	}

	var_01 = common_scripts\utility::getclosest(self.origin,param_00,100000);
	if(isdefined(var_01) && isalive(var_01))
	{
		var_02 = var_01.origin - self.origin;
		var_03 = vectortoangles(var_02);
		self vehicle_teleport(self.origin,var_03);
	}
}

//Function Number: 13
pdrone_orient_to_closest_ai_target()
{
	pdrone_orient_to_closest_target(getaiarray("axis"));
}

//Function Number: 14
pdrone_orient_to_closest_ent_target()
{
	var_00 = [];
	foreach(var_02 in getarraykeys(self.ent_targets))
	{
		var_00 = common_scripts\utility::array_combine(var_00,getentarray(self.ent_targets[var_02],var_02));
	}

	pdrone_orient_to_closest_target(var_00);
}

//Function Number: 15
introscreen_fade_in()
{
	wait(4);
	thread maps\_introscreen::introscreen_generic_fade_in("black",0.4,0.3,0.3);
}

//Function Number: 16
_pdrone_stop_use_anim()
{
	var_00 = maps\_utility::spawn_anim_model("drone_deploy_player_arms",level.player.origin);
	var_01 = level.player common_scripts\utility::spawn_tag_origin();
	level.player playerlinktoabsolute(var_00,"tag_player");
	var_01 maps\_anim::anim_single_solo(var_00,"stop_use");
	level.player unlink();
	var_02 = level.player getdroptofloorposition(level.player.origin + (0,0,60));
	if(isdefined(var_02))
	{
		level.player setorigin(var_02);
	}

	var_00 delete();
	var_01 delete();
}

//Function Number: 17
_get_if_defined_or_default(param_00,param_01)
{
	if(isdefined(param_00))
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 18
_pdrone_player_proxy_delicate_flower(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02);
		if(isplayer(var_02) && var_01 > 50)
		{
			break;
		}
	}

	self.player_proxy_took_damage = 1;
	pdrone_player_force_exit();
}

//Function Number: 19
_pdrone_player_proxy(param_00)
{
	var_01 = getent("pdrone_player_proxy","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02.animname = "drone_player_proxy";
	var_02.name = "Mitchell";
	var_02.no_ai = 1;
	var_02 maps\_utility::gun_remove();
	var_02.ignoreme = 1;
	var_02.ignoreall = 1;
	var_02.team = "axis";
	var_02.no_friendly_fire_penalty = 1;
	var_02 disableaimassist();
	var_02 thread maps\_utility::magic_bullet_shield(1);
	var_02 hudoutlineenable(3,1,1);
	var_02 attach("dem_tablet_pc_01","tag_weapon_left");
	var_03 = self.saved.return_tag;
	if(isdefined(param_00))
	{
		var_03 = param_00;
	}

	self.player_proxy = var_02;
	self.player_proxy_org = var_03;
	childthread _pdrone_player_proxy_delicate_flower(var_02);
	var_02 forceteleport(var_03.origin,var_03.angles);
	var_03 maps\_anim::anim_loop_solo(var_02,"loop","stop_loop");
}

//Function Number: 20
_pdrone_player_proxy_clear()
{
	if(isdefined(self.player_proxy))
	{
		self.player_proxy_org notify("stop_loop");
		if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
		{
			maps\_utility::stop_magic_bullet_shield();
		}

		self.player_proxy hide();
		self.player_proxy common_scripts\utility::delaycall(0.1,::delete);
	}
}

//Function Number: 21
pdrone_player_use(param_00,param_01,param_02,param_03)
{
	param_00.saved = spawnstruct();
	param_00.data = spawnstruct();
	param_00.data.volumes_targetname = param_01;
	param_00.team = level.player.team;
	param_00.time = param_02;
	param_00.is_pdrone = 1;
	param_00.turret = param_00.mgturret[0];
	param_00.turret hide();
	if(isdefined(param_03))
	{
		param_00.losing_connection_multipler = param_03;
	}
	else
	{
		param_00.losing_connection_multipler = 1.5;
	}

	param_00.data.player_command_for_exit = "stance";
	if(!level.player usinggamepad())
	{
		param_00.data.player_command_for_exit = "activate";
	}
}

//Function Number: 22
pdrone_player_spawn(param_00,param_01,param_02,param_03)
{
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	pdrone_player_use(var_04,param_01,param_02,param_03);
	return var_04;
}

//Function Number: 23
_save_dvars()
{
	self.saved.vehhelicoptercontrolsaltitude = getdvarint("vehHelicopterControlsAltitude",1);
	self.saved.vehhelicoptercontrolsystem = getdvarint("vehHelicopterControlSystem",1);
	self.saved.r_hudoutlineenable = getdvar("r_hudoutlineenable",0);
	self.saved.r_hudoutlinepostmode = getdvar("r_hudoutlinepostmode",0);
	self.saved.r_hudoutlinehalolumscale = getdvar("r_hudoutlinehalolumscale",0);
	self.saved.r_hudoutlinehaloblurradius = getdvar("r_hudoutlinehaloblurradius",0);
	self.saved.aim_turnrate_pitch = getdvarint("aim_turnrate_pitch");
	self.saved.aim_turnrate_yaw = getdvarint("aim_turnrate_yaw");
	self.saved.playerhealth_regularregendelay = level.player.gs.playerhealth_regularregendelay;
	self.saved.longregentime = level.player.gs.longregentime;
}

//Function Number: 24
_reset_dvars()
{
	setsaveddvar("vehHelicopterControlsAltitude",self.saved.vehhelicoptercontrolsaltitude);
	setsaveddvar("vehHelicopterControlSystem",self.saved.vehhelicoptercontrolsystem);
	setsaveddvar("r_hudoutlineenable",self.saved.r_hudoutlineenable);
	setsaveddvar("r_hudoutlinepostmode",self.saved.r_hudoutlinepostmode);
	setsaveddvar("r_hudoutlinehalolumscale",self.saved.r_hudoutlinehalolumscale);
	setsaveddvar("r_hudoutlinehaloblurradius",self.saved.r_hudoutlinehaloblurradius);
	setsaveddvar("aim_turnrate_pitch",self.saved.aim_turnrate_pitch);
	setsaveddvar("aim_turnrate_yaw",self.saved.aim_turnrate_yaw);
	level.player.gs.playerhealth_regularregendelay = self.saved.playerhealth_regularregendelay;
	level.player.gs.longregentime = self.saved.playerhealth_regularregendelay;
}

//Function Number: 25
_set_dvars()
{
	setsaveddvar("vehHelicopterControlsAltitude",1);
	setsaveddvar("vehHelicopterControlSystem",1);
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehalolumscale",1);
	setsaveddvar("r_hudoutlinehaloblurradius",0.7);
	setsaveddvar("aim_turnrate_pitch",100);
	setsaveddvar("aim_turnrate_yaw",130);
	level.player.gs.playerhealth_regularregendelay = level.player.gs.playerhealth_regularregendelay / 500;
	level.player.gs.longregentime = level.player.gs.longregentime / 500;
}

//Function Number: 26
_vmodel_anims(param_00,param_01)
{
	self useanimtree(#animtree);
	var_02 = getanimlength(param_01);
	for(;;)
	{
		self setanimknob(param_00);
		level.player waittill("weapon_fired");
		if(1)
		{
			level.player.rumble_entity.intensity = level.player.rumble_entity.intensity + 0.1;
		}

		while(level.player attackbuttonpressed())
		{
			self setanimknobrestart(param_01);
			wait(var_02 / 6);
		}

		if(1)
		{
			level.player.rumble_entity.intensity = level.player.rumble_entity.intensity - 0.1;
		}
	}
}

//Function Number: 27
_debug_vector_to_string(param_00)
{
	return "( " + param_00[0] + " , " + param_00[1] + ", " + param_00[2] + " )";
}

//Function Number: 28
_vmodel_sway()
{
	for(;;)
	{
		var_00 = self vehicle_getbodyvelocity();
		var_01 = length(var_00);
		if(1)
		{
			if(var_01 > 100)
			{
				if(!isdefined(self.movement_rumble))
				{
					level.player.rumble_entity.intensity = level.player.rumble_entity.intensity + 0.01;
					self.movement_rumble = 1;
				}
			}
			else if(isdefined(self.movement_rumble))
			{
				level.player.rumble_entity.intensity = level.player.rumble_entity.intensity - 0.01;
				self.movement_rumble = undefined;
			}
		}

		var_02 = 400;
		var_03 = 0;
		var_04 = 0;
		var_05 = 4;
		if(var_00[1] < 0)
		{
			var_06 = clamp(var_00[1] * -1,0,var_02);
			var_03 = var_06 / var_02;
		}
		else if(var_00[1] > 0)
		{
			var_07 = clamp(var_00[1],0,var_02);
			var_04 = var_07 / var_02;
		}

		var_08 = -1 * var_03 * var_05 + var_04 * var_05;
		var_09 = 0;
		var_0A = 0;
		var_0B = 1;
		if(var_00[0] < 0)
		{
			var_0C = clamp(var_00[0] * -1,0,var_02);
			var_09 = var_0C / var_02;
		}
		else if(var_00[0] > 0)
		{
			var_0D = clamp(var_00[0],0,var_02);
			var_0A = var_0D / var_02;
		}

		var_0E = -1 * var_09 * var_0B + var_0A * var_0B;
		self.vmodelbarrel unlinkfromplayerview(level.player);
		self.vmodelouter unlinkfromplayerview(level.player);
		self.vmodelbarrel linktoplayerview(level.player,"tag_origin",(-5,0,-1.75),(var_0E,0,var_08),1);
		self.vmodelouter linktoplayerview(level.player,"tag_origin",(6,0,-3),(var_0E,0,var_08),1);
		wait 0.05;
	}
}

//Function Number: 29
_vmodel_enter()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("vehicle_sniper_drone_outerparts");
	var_00 linktoplayerview(level.player,"tag_origin",(6,0,-3),(0,0,0),1);
	var_00 childthread _vmodel_anims(%sniper_drone_outerparts_idle,%sniper_drone_outerparts_fire);
	self.vmodelouter = var_00;
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("vehicle_vm_sniper_drone");
	var_01 linktoplayerview(level.player,"tag_origin",(-5,0,-1.75),(0,0,0),1);
	var_01 childthread _vmodel_anims(%sniper_drone_vm_idle,%sniper_drone_vm_fire);
	self.vmodelbarrel = var_01;
	childthread _vmodel_sway();
}

//Function Number: 30
_vmodel_exit()
{
	self.vmodelouter unlinkfromplayerview(level.player);
	self.vmodelouter delete();
	self.vmodelbarrel unlinkfromplayerview(level.player);
	self.vmodelbarrel delete();
}

//Function Number: 31
_monitor_threat_count()
{
	for(;;)
	{
		setomnvar("ui_assaultdrone_threat_count",self.hud_targets.size);
		self waittill("update_threat_count");
	}
}

//Function Number: 32
_reduce_hud_target_count_on_death(param_00)
{
	param_00 common_scripts\utility::waittill_either("death","fake_death");
	self.hud_targets = common_scripts\utility::array_remove(self.hud_targets,param_00);
	self.hud_targets = maps\_utility::remove_dead_from_array(self.hud_targets);
	self notify("update_threat_count");
	if(self.hud_targets.size == 0)
	{
		self notify("all_threats_eliminated");
	}
}

//Function Number: 33
_sethudoutline(param_00)
{
	param_00 hudoutlineenable(1,1,0);
	childthread _reduce_hud_target_count_on_death(param_00);
}

//Function Number: 34
_sethudoutline_on_spawn(param_00)
{
	for(;;)
	{
		param_00 waittill("spawned",var_01);
		self.hud_targets = common_scripts\utility::array_add(self.hud_targets,var_01);
		_sethudoutline(var_01);
	}
}

//Function Number: 35
_mark_newlyspawned()
{
	var_00 = common_scripts\utility::array_combine(getspawnerarray(),vehicle_getspawnerarray());
	foreach(var_02 in var_00)
	{
		childthread _sethudoutline_on_spawn(var_02);
	}
}

//Function Number: 36
_set_hudoutline_on_enemies()
{
	self.hud_targets = getaiarray("axis");
	self.hud_allies = getaiarray("allies");
	if(isdefined(self.vehicle_targets))
	{
		var_00 = [];
		foreach(var_02 in getarraykeys(self.vehicle_targets))
		{
			var_00 = common_scripts\utility::array_combine(var_00,getentarray(self.vehicle_targets[var_02],var_02));
		}

		self.hud_targets = common_scripts\utility::array_combine(self.hud_targets,var_00);
	}

	if(isdefined(self.ent_targets))
	{
		var_04 = [];
		foreach(var_02 in getarraykeys(self.ent_targets))
		{
			var_04 = common_scripts\utility::array_combine(var_04,getentarray(self.ent_targets[var_02],var_02));
		}

		self.hud_targets = common_scripts\utility::array_combine(self.hud_targets,var_04);
	}

	foreach(var_08 in self.hud_targets)
	{
		_sethudoutline(var_08);
	}

	childthread _mark_newlyspawned();
	childthread _monitor_threat_count();
	foreach(var_0B in self.hud_allies)
	{
		var_0B hudoutlineenable(6,1,0);
	}
}

//Function Number: 37
_remove_hudoutline_on_enemies()
{
	var_00 = common_scripts\utility::array_combine(self.hud_targets,self.hud_allies);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && !isremovedentity(var_02))
		{
			var_02 hudoutlinedisable();
		}
	}
}

//Function Number: 38
pdrone_player_enter(param_00,param_01,param_02)
{
	level.player endon("drone_exit");
	_save_dvars();
	_set_dvars();
	level.cansave = 0;
	level.player enableinvulnerability();
	if(isdefined(param_00) && param_00)
	{
		childthread _pdrone_player_proxy(param_01);
	}

	if(!isdefined(param_01))
	{
		self.saved.return_tag = level.player common_scripts\utility::spawn_tag_origin();
	}
	else
	{
		self.saved.return_tag = param_01;
	}

	self.no_threat_return_node = param_02;
	level.player maps\_utility::teleport_player(self);
	level.player drivevehicleandcontrolturret(self,0);
	if(1)
	{
		level.player.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
		level.player.rumble_entity.intensity = 0.088;
	}

	self.turret useby(level.player);
	self.turret makeunusable();
	level.player disableturretdismount();
	level.player.is_driving_pdrone = 1;
	self hide();
	self makeentitysentient("allies");
	_vmodel_enter();
	maps\_shg_utility::hide_player_hud();
	_setup_overlay_static();
	_setup_hud();
	thread _remove_hud_on_death();
	_set_hudoutline_on_enemies();
	childthread _listen_drone_input();
}

//Function Number: 39
pdrone_player_is_driving()
{
	return isdefined(level.player.is_driving_pdrone) && level.player.is_driving_pdrone;
}

//Function Number: 40
_pdrone_player_exit_return_control()
{
	wait(0.2);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player freezecontrols(0);
}

//Function Number: 41
pdrone_player_death()
{
	wait(0.25);
	var_00 = self gettagorigin("tag_origin");
	radiusdamage(var_00,256,250,50,level.player);
	playfx(common_scripts\utility::getfx("pdrone_large_death_explosion"),var_00);
	soundscripts\_snd::snd_message("pdrone_death_explode");
}

//Function Number: 42
pdrone_player_exit(param_00)
{
	pdrone_player_force_exit();
	_remove_drone_control();
	level.cansave = 1;
	maps\_shg_utility::show_player_hud();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene();
	if(isalive(level.player))
	{
		thread maps\_introscreen::introscreen_generic_fade_in("black",0.1,0.3,0.3);
		wait(0.35);
		_pdrone_player_proxy_clear();
		_remove_hud();
		_remove_overlay_static();
		_reset_dvars();
		if(1)
		{
			level.player stoprumble("steady_rumble");
			if(isdefined(level.player.rumble_entity))
			{
				level.player.rumble_entity delete();
			}
		}

		if(level.player.is_driving_pdrone)
		{
			level.player drivevehicleandcontrolturretoff(self);
			level.player.is_driving_pdrone = 0;
			self.turret delete();
		}

		level.player disableinvulnerability();
		_vmodel_exit();
		_remove_hudoutline_on_enemies();
		if(isdefined(self.no_threat_return_node) && self.hud_targets.size < 2)
		{
			self.saved.return_tag = self.no_threat_return_node;
		}

		if(isdefined(self.saved.return_tag))
		{
			level.player maps\_utility::teleport_player(self.saved.return_tag);
		}

		if(isdefined(self.player_proxy_took_damage) && self.player_proxy_took_damage)
		{
			var_01 = level.player.health * 0.2 / level.player.damagemultiplier;
			level.player dodamage(var_01,self.origin,level.player);
		}

		if(self.customhealth <= 0 && distance(self.saved.return_tag.origin,self.origin) > 150)
		{
			thread pdrone_player_death();
		}

		if(isdefined(param_00) && param_00)
		{
			_pdrone_stop_use_anim();
		}

		thread _pdrone_player_exit_return_control();
	}
}

//Function Number: 43
_make_overlay(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(level.player);
	var_04.x = 0;
	var_04.y = 0;
	if(param_02)
	{
		var_04.horzalign = "fullscreen";
		var_04.vertalign = "fullscreen";
	}
	else
	{
		var_04.horzalign = "center";
		var_04.vertalign = "middle";
	}

	var_04.sort = param_03;
	var_04 setshader(param_00,640,480);
	var_04.alpha = param_01;
	return var_04;
}

//Function Number: 44
_setup_overlay_static()
{
	self.overlaystatic = _make_overlay("overlay_static_digital",0,1,0);
}

//Function Number: 45
_setup_hud()
{
	setomnvar("ui_assaultdrone_toggle",1);
}

//Function Number: 46
_remove_overlay_static()
{
	self.overlaystatic destroy();
}

//Function Number: 47
_remove_hud()
{
	setomnvar("ui_assaultdrone_toggle",0);
}

//Function Number: 48
_remove_hud_on_death()
{
	level waittill("missionfailed");
	if(isdefined(self) && pdrone_player_is_driving())
	{
		_remove_hud();
	}
}

//Function Number: 49
_set_overlay_static_alpha(param_00)
{
	self.overlaystatic.alpha = param_00;
}

//Function Number: 50
_manage_timer(param_00)
{
	var_01 = param_00;
	var_02 = 0.05;
	while(var_01 >= 0)
	{
		setomnvar("ui_assaultdrone_countdown",param_00 - var_01);
		wait(var_02);
		var_01 = var_01 - var_02;
	}

	pdrone_player_force_exit();
}

//Function Number: 51
_do_a_lil_damage_and_heal(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	level.player dodamage(1,param_00.origin,param_00);
}

//Function Number: 52
_monitor_volume_array()
{
	level.player endon("drone_exit");
	var_00 = 1;
	var_01 = common_scripts\utility::spawn_tag_origin();
	for(;;)
	{
		var_01.origin = self.origin;
		var_01.angles = self.angles;
		var_02 = var_01 getistouchingentities(self.data.volume_array);
		if(!isdefined(var_02) || !isarray(var_02) || var_02.size == 0)
		{
			var_03 = 50 * var_00;
			self notify("damage",var_03);
			var_00 = var_00 * self.losing_connection_multipler;
			setomnvar("ui_assaultdrone_connection",0);
		}
		else
		{
			if(var_00 > 1)
			{
				var_00 = var_00 / self.losing_connection_multipler;
				var_00 = max(1,var_00);
			}

			setomnvar("ui_assaultdrone_connection",1);
		}

		wait(0.25);
	}
}

//Function Number: 53
_monitor_damage()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		thread _do_a_lil_damage_and_heal(var_01);
		self.lastdamageat = gettime();
		self.customhealth = self.customhealth - var_00;
		if(self.customhealth <= 0)
		{
			self notify("custom_death");
			break;
		}
	}
}

//Function Number: 54
_monitor_regen()
{
	self.disableregen = 0;
	for(;;)
	{
		if(!self.disableregen && gettime() - self.lastdamageat > 1000)
		{
			self.customhealth = min(self.customhealth + 10,self.custommaxhealth);
		}

		wait 0.05;
	}
}

//Function Number: 55
_monitor_static()
{
	self.extra_static = 0;
	for(;;)
	{
		var_00 = 1 - self.customhealth / self.custommaxhealth;
		var_00 = var_00 * 0.3;
		var_00 = var_00 + self.extra_static;
		_set_overlay_static_alpha(var_00);
		wait 0.05;
	}
}

//Function Number: 56
_monitor_touch()
{
	for(;;)
	{
		self waittill("touch",var_00);
		if(isai(var_00))
		{
			self notify("damage",4000);
			if(isdefined(var_00.targetname) && issubstr(var_00.targetname,"pdrone_player_proxy"))
			{
				var_00 dodamage(100,self.origin,level.player);
			}
			else if(var_00.team != "allies")
			{
				var_00 kill();
			}
		}

		wait 0.05;
	}
}

//Function Number: 57
_bootup_static()
{
	self.extra_static = 0.5;
	while(self.extra_static > 0)
	{
		wait(0.15);
		self.extra_static = self.extra_static - 0.05;
	}

	self.extra_static = 0;
}

//Function Number: 58
_monitor_health()
{
	self.custommaxhealth = 4000;
	self.customhealth = self.custommaxhealth;
	self.lastdamageat = gettime();
	childthread _monitor_damage();
	childthread _monitor_regen();
	childthread _monitor_static();
	childthread _bootup_static();
	childthread _monitor_touch();
	if(isdefined(self.data.volumes_targetname))
	{
		self.data.volume_array = getentarray(self.data.volumes_targetname,"targetname");
		childthread _monitor_volume_array();
	}

	self waittill("custom_death");
	var_00 = 0.3;
	while(var_00 <= 1)
	{
		var_00 = var_00 + 0.05;
		_set_overlay_static_alpha(var_00);
		wait 0.05;
	}

	pdrone_player_force_exit();
}

//Function Number: 59
_monitor_controls()
{
	self endon("monitor_controls_end");
	var_00 = spawnstruct();
	self.controlcheck = var_00;
	var_00 maps\_utility::ent_flag_init("move_done");
	var_00 maps\_utility::ent_flag_init("steer_done");
	var_00 maps\_utility::ent_flag_init("attack_done");
	var_00 maps\_utility::ent_flag_init("ads_done");
	var_00 maps\_utility::ent_flag_init("up_done");
	var_00 maps\_utility::ent_flag_init("down_done");
	while(!var_00 maps\_utility::ent_flag("move_done") || !var_00 maps\_utility::ent_flag("steer_done") || !var_00 maps\_utility::ent_flag("attack_done") || !var_00 maps\_utility::ent_flag("ads_done") || !var_00 maps\_utility::ent_flag("up_done") || !var_00 maps\_utility::ent_flag("down_done"))
	{
		var_01 = level.player getnormalizedmovement();
		if(length(var_01) > 0.1)
		{
			var_00 maps\_utility::ent_flag_set("move_done");
		}

		var_01 = level.player getnormalizedcameramovements();
		if(length(var_01) > 0.1 || !level.player usinggamepad())
		{
			var_00 maps\_utility::ent_flag_set("steer_done");
		}

		if(level.player attackbuttonpressed())
		{
			var_00 maps\_utility::ent_flag_set("attack_done");
		}

		if(level.player adsbuttonpressed())
		{
			var_00 maps\_utility::ent_flag_set("ads_done");
		}

		if(level.player fragbuttonpressed())
		{
			var_00 maps\_utility::ent_flag_set("up_done");
		}

		if(level.player secondaryoffhandbuttonpressed())
		{
			var_00 maps\_utility::ent_flag_set("down_done");
		}

		wait 0.05;
	}
}

//Function Number: 60
_show_contols()
{
	childthread _monitor_controls();
	setomnvar("ui_assaultdrone_controls",0);
	setomnvar("ui_assaultdrone_controls_exit",0);
	wait(1);
	var_00 = self.controlcheck;
	setomnvar("ui_assaultdrone_controls",1);
	var_00 maps\_utility::ent_flag_wait("move_done");
	var_00 maps\_utility::ent_flag_wait("steer_done");
	setomnvar("ui_assaultdrone_controls",0);
	wait(1);
	setomnvar("ui_assaultdrone_controls",2);
	var_00 maps\_utility::ent_flag_wait("attack_done");
	var_00 maps\_utility::ent_flag_wait("ads_done");
	setomnvar("ui_assaultdrone_controls",0);
	wait(1);
	setomnvar("ui_assaultdrone_controls_exit",1);
	setomnvar("ui_assaultdrone_controls",3);
	var_00 maps\_utility::ent_flag_wait("up_done");
	var_00 maps\_utility::ent_flag_wait("down_done");
	setomnvar("ui_assaultdrone_controls",0);
}

//Function Number: 61
pdrone_player_loop()
{
	level.player endon("drone_exit");
	level.player endon("death");
	childthread _monitor_health();
	childthread _show_contols();
	if(isdefined(self.time) && self.time > 0)
	{
		childthread _manage_timer(self.time);
	}

	for(;;)
	{
		self.maxhealth = 500000;
		self.health = self.maxhealth;
		wait 0.05;
	}
}

//Function Number: 62
pdrone_player_get_current_fov()
{
	return self.data.current_fov;
}

//Function Number: 63
pdrone_player_force_exit()
{
	if(!isdefined(self.is_pdrone))
	{
		return;
	}

	level.player notify("drone_exit");
}

//Function Number: 64
pdrone_player_add_vehicle_target(param_00,param_01)
{
	if(!isdefined(self.vehicle_targets))
	{
		self.vehicle_targets = [];
	}

	self.vehicle_targets[param_00] = param_01;
}

//Function Number: 65
pdrone_player_add_ent_target(param_00,param_01)
{
	if(!isdefined(self.ent_targets))
	{
		self.ent_targets = [];
	}

	self.ent_targets[param_00] = param_01;
}

//Function Number: 66
_listen_for_hold_to_exit_set_flags(param_00)
{
	for(;;)
	{
		level.player waittill("hold_to_exit_start");
		param_00 maps\_utility::ent_flag_set("exit_button_pressed");
		level.player waittill("hold_to_exit_stop");
		param_00 maps\_utility::ent_flag_clear("exit_button_pressed");
	}
}

//Function Number: 67
_listen_for_hold_to_exit()
{
	var_00 = spawnstruct();
	var_00 maps\_utility::ent_flag_init("exit_button_pressed");
	childthread _listen_for_hold_to_exit_set_flags(var_00);
	for(;;)
	{
		var_00 maps\_utility::ent_flag_wait("exit_button_pressed");
		var_01 = 0;
		while(var_00 maps\_utility::ent_flag("exit_button_pressed"))
		{
			if(var_01 >= 1 || !level.player usinggamepad())
			{
				level.player notify("drone_exit");
				break;
			}

			wait 0.05;
			var_01 = var_01 + 0.05;
		}
	}
}

//Function Number: 68
_listen_drone_input()
{
	level.player notifyonplayercommand("weapon_fired","+attack");
	if(isdefined(self.data.player_command_for_exit))
	{
		wait(2);
		level.player notifyonplayercommand("hold_to_exit_start","+" + self.data.player_command_for_exit);
		level.player notifyonplayercommand("hold_to_exit_stop","-" + self.data.player_command_for_exit);
		childthread _listen_for_hold_to_exit();
	}
}

//Function Number: 69
_remove_drone_control()
{
	if(isdefined(self.data.player_command_for_exit))
	{
		notifyoncommandremove("hold_to_exit_start","+" + self.data.player_command_for_exit);
		notifyoncommandremove("hold_to_exit_stop","-" + self.data.player_command_for_exit);
	}
}
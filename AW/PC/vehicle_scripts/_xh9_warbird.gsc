/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _xh9_warbird.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 746 ms
 * Timestamp: 4/22/2024 2:05:51 AM
*******************************************************************/

//Function Number: 1
is_using_model_memory_sharing()
{
	return !maps\_utility::is_gen4();
}

//Function Number: 2
main(param_00,param_01,param_02)
{
	var_03 = 0;
	if(issubstr(param_02,"_stealth"))
	{
		var_03 = 1;
		if(issubstr(param_02,"_stealth_col"))
		{
			precachemodel("vehicle_xh9_warbird_cloaked_mp");
		}
	}

	if(issubstr(param_02,"_stealth_low"))
	{
		level.cloak_new = 1;
		precachemodel("vehicle_xh9_warbird_low_cloak");
	}

	if(issubstr(param_02,"_atlas_desert"))
	{
		precachemodel("vehicle_xh9_warbird_desert");
	}

	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = issubstr(param_02,"_no_treadfx");
	if(issubstr(param_02,"_no_turret"))
	{
		var_04 = 1;
	}
	else if(issubstr(param_02,"_heavy_turret"))
	{
		var_06 = 1;
		precacheturret("warbird_heavy_turret");
	}
	else if(issubstr(param_02,"_usarmy_turret"))
	{
		var_07 = 1;
		precacheturret("warbird_side_turret_usarmy_sp");
	}
	else if(issubstr(param_02,"_side_turret"))
	{
		var_08 = 1;
		precacheturret("warbird_side_turret_sp");
	}
	else if(issubstr(param_02,"_cheap"))
	{
		var_09 = 1;
		var_04 = 1;
	}

	if(issubstr(param_02,"_no_cloak"))
	{
		var_05 = 1;
	}

	if(issubstr(param_02,"_no_zipline"))
	{
		var_0A = 1;
	}

	if(!var_09)
	{
		if(!var_0A)
		{
			precachemodel("npc_zipline_gun_left");
			precachemodel("npc_zipline_rope_left");
			precachemodel("npc_zipline_gun_right");
			precachemodel("npc_zipline_rope_right");
			precachemodel("npc_optics_zipline_gun");
			precacheturret("zipline_gun");
			precacheturret("zipline_gun_rope");
		}

		maps\_utility::set_console_status();
		if(!var_05)
		{
			if(is_using_model_memory_sharing())
			{
				precachemodel("vehicle_xh9_warbird_cloaked_transparent");
				precachemodel("vehicle_xh9_warbird_decloaking_masked");
			}
			else
			{
				precachemodel("vehicle_xh9_warbird_cloaked_in_out");
			}
		}

		if(var_03)
		{
			precachemodel("vehicle_xh9_warbird_turret_left_stealth");
			precachemodel("vehicle_xh9_warbird_turret_right_stealth");
		}
		else
		{
			precachemodel("vehicle_xh9_warbird_turret_left");
			precachemodel("vehicle_xh9_warbird_turret_right");
		}
	}

	maps\_vehicle::build_template("xh9_warbird",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	if(!var_09)
	{
		maps\_vehicle::build_deathmodel("vehicle_xh9_warbird");
	}

	if(!var_0B)
	{
		maps\_vehicle::build_treadfx();
	}

	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_unload_groups(::unload_groups);
	maps\_vehicle::build_bulletshield(1);
	if(!var_04)
	{
		if(var_03)
		{
			maps\_vehicle::build_turret("warbird_turret","tag_turret_left","vehicle_xh9_warbird_turret_left_stealth",undefined,"manual",undefined,0,0,undefined);
			maps\_vehicle::build_turret("warbird_turret","tag_turret_right","vehicle_xh9_warbird_turret_right_stealth",undefined,"manual",undefined,0,0,undefined);
		}
		else if(var_06)
		{
			maps\_vehicle::build_turret("warbird_heavy_turret","tag_turret_left","vehicle_xh9_warbird_turret_left",undefined,"manual",undefined,0,0,undefined);
			maps\_vehicle::build_turret("warbird_heavy_turret","tag_turret_right","vehicle_xh9_warbird_turret_right",undefined,"manual",undefined,0,0,undefined);
		}
		else if(var_07)
		{
			maps\_vehicle::build_turret("warbird_side_turret_usarmy_sp","tag_turret_zipline_fl","npc_zipline_gun_right",undefined,"manual",undefined,0,0,(12,0,-16));
		}
		else if(var_08)
		{
			maps\_vehicle::build_turret("warbird_side_turret_sp","tag_turret_zipline_fl","npc_zipline_gun_right",undefined,"manual",undefined,0,0,undefined);
		}
		else
		{
			maps\_vehicle::build_turret("warbird_turret","tag_turret_left","vehicle_xh9_warbird_turret_left",undefined,"manual",undefined,0,0,undefined);
			maps\_vehicle::build_turret("warbird_turret","tag_turret_right","vehicle_xh9_warbird_turret_right",undefined,"manual",undefined,0,0,undefined);
		}
	}

	var_0C = randomfloatrange(0,1);
	if(!var_09)
	{
		maps\_vehicle::build_deathfx("vfx/explosion/vehicle_warbird_explosion_midair","tag_origin","sfb_warbird_death_explo",undefined,undefined,undefined,-1,1);
	}

	if(!issubstr(param_02,"_stealth_col"))
	{
		maps\_vehicle::build_light(param_02,"white_blink_tail","tag_light_tail","vfx/lights/light_wingtip_red_med_point","running",var_0C);
		maps\_vehicle::build_light(param_02,"wingtip_red_body_r","TAG_light_body_R","vfx/lights/light_wingtip_red_med_point","running",var_0C);
		maps\_vehicle::build_light(param_02,"wingtip_red_body_l","TAG_light_body_L","vfx/lights/light_wingtip_red_med_point","running",var_0C);
		maps\_vehicle::build_light(param_02,"wingtip_red_body_r","TAG_light_R_wing","vfx/lights/light_wingtip_red_med_point","running",var_0C);
		maps\_vehicle::build_light(param_02,"wingtip_red_body_l","TAG_light_L_wing","vfx/lights/light_wingtip_red_med_point","running",var_0C);
		maps\_vehicle::build_light(param_02,"headlight_L","TAG_light_front_R","vfx/lights/headlight_gaz","headlights",0);
		maps\_vehicle::build_light(param_02,"headlight_R","TAG_light_front_L","vfx/lights/headlight_gaz","headlights",0);
	}

	maps\_vehicle::build_is_helicopter();
	if(!var_09 && !var_0A)
	{
		load_script_model_anims();
	}
}

//Function Number: 3
load_script_model_anims()
{
	level.scr_animtree["_zipline_gun_fl"] = #animtree;
	level.scr_model["_zipline_gun_fl"] = "npc_zipline_gun_right";
	level.scr_anim["_zipline_gun_fl"]["folded_idle"] = %fastzip_launcher_folded_idle_right;
	level.scr_anim["_zipline_gun_fl"]["rest_idle"] = %fastzip_launcher_rest_idle_right;
	level.scr_anim["_zipline_gun_fl"]["readyup"] = %fastzip_launcher_readyup_right;
	level.scr_anim["_zipline_gun_fl"]["jumpout"] = %fastzip_launcher_jumpout_right;
	level.scr_anim["_zipline_gun_fl"]["fastzip_pullout"] = %fastzip_launcher_pullout;
	level.scr_anim["_zipline_gun_fl"]["fastzip_putaway"] = %fastzip_launcher_putaway;
	level.scr_anim["_zipline_gun_fl"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_right;
	level.scr_anim["_zipline_gun_fl"]["fastzip_fire"] = %fastzip_launcher_fire_right_npc;
	level.scr_anim["_zipline_gun_fl"]["fastzip_slide"] = %fastzip_launcher_slidedown_right_npc;
	level.scr_anim["_zipline_gun_fl"]["retract_rope"] = %fastzip_launcher_retract_right;
	level.scr_animtree["_zipline_gun_fr"] = #animtree;
	level.scr_model["_zipline_gun_fr"] = "npc_zipline_gun_left";
	level.scr_anim["_zipline_gun_fr"]["folded_idle"] = %fastzip_launcher_folded_idle_left;
	level.scr_anim["_zipline_gun_fr"]["rest_idle"] = %fastzip_launcher_rest_idle_left;
	level.scr_anim["_zipline_gun_fr"]["readyup"] = %fastzip_launcher_readyup_left;
	level.scr_anim["_zipline_gun_fr"]["jumpout"] = %fastzip_launcher_jumpout_left;
	level.scr_anim["_zipline_gun_fr"]["fastzip_pullout"] = %fastzip_launcher_pullout;
	level.scr_anim["_zipline_gun_fr"]["fastzip_putaway"] = %fastzip_launcher_putaway;
	level.scr_anim["_zipline_gun_fr"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_left;
	level.scr_anim["_zipline_gun_fr"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
	level.scr_anim["_zipline_gun_fr"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
	level.scr_anim["_zipline_gun_fr"]["retract_rope"] = %fastzip_launcher_retract_left;
	level.scr_animtree["_zipline_gun_kl"] = #animtree;
	level.scr_model["_zipline_gun_kl"] = "npc_zipline_gun_left";
	level.scr_anim["_zipline_gun_kl"]["folded_idle"] = %fastzip_launcher_folded_idle_left;
	level.scr_anim["_zipline_gun_kl"]["rest_idle"] = %fastzip_launcher_rest_idle_left;
	level.scr_anim["_zipline_gun_kl"]["readyup"] = %fastzip_launcher_readyup_left;
	level.scr_anim["_zipline_gun_kl"]["jumpout"] = %fastzip_launcher_jumpout_left;
	level.scr_anim["_zipline_gun_kl"]["fastzip_pullout"] = %fastzip_launcher_pullout;
	level.scr_anim["_zipline_gun_kl"]["fastzip_putaway"] = %fastzip_launcher_putaway;
	level.scr_anim["_zipline_gun_kl"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_left;
	level.scr_anim["_zipline_gun_kl"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
	level.scr_anim["_zipline_gun_kl"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
	level.scr_anim["_zipline_gun_kl"]["retract_rope"] = %fastzip_launcher_retract_left;
	level.scr_animtree["_zipline_gun_kr"] = #animtree;
	level.scr_model["_zipline_gun_kr"] = "npc_zipline_gun_right";
	level.scr_anim["_zipline_gun_kr"]["folded_idle"] = %fastzip_launcher_folded_idle_right;
	level.scr_anim["_zipline_gun_kr"]["rest_idle"] = %fastzip_launcher_rest_idle_right;
	level.scr_anim["_zipline_gun_kr"]["readyup"] = %fastzip_launcher_readyup_right;
	level.scr_anim["_zipline_gun_kr"]["jumpout"] = %fastzip_launcher_jumpout_right;
	level.scr_anim["_zipline_gun_kr"]["fastzip_pullout"] = %fastzip_launcher_pullout;
	level.scr_anim["_zipline_gun_kr"]["fastzip_putaway"] = %fastzip_launcher_putaway;
	level.scr_anim["_zipline_gun_kr"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_right;
	level.scr_anim["_zipline_gun_kr"]["fastzip_fire"] = %fastzip_launcher_fire_right_npc;
	level.scr_anim["_zipline_gun_kr"]["fastzip_slide"] = %fastzip_launcher_slidedown_right_npc;
	level.scr_anim["_zipline_gun_kr"]["retract_rope"] = %fastzip_launcher_retract_right;
}

//Function Number: 4
init_local()
{
	self.script_badplace = 0;
	maps\_utility::ent_flag_init("left_door_open");
	maps\_utility::ent_flag_init("right_door_open");
	waittillframeend;
	if(issubstr(self.classname,"_no_turret") && !issubstr(self.classname,"cheap"))
	{
		if(issubstr(self.classname,"_stealth"))
		{
			thread spawn_turret_model("tag_turret_left","vehicle_xh9_warbird_turret_left_stealth");
			thread spawn_turret_model("tag_turret_right","vehicle_xh9_warbird_turret_right_stealth");
		}
		else
		{
			thread spawn_turret_model("tag_turret_left","vehicle_xh9_warbird_turret_left");
			thread spawn_turret_model("tag_turret_right","vehicle_xh9_warbird_turret_right");
		}
	}

	thread handle_rotors();
	if(!issubstr(self.classname,"_no_zipline") && !issubstr(self.classname,"cheap"))
	{
		thread spawn_script_model_turret("_zipline_gun_fl","tag_turret_zipline_fl","TAG_GUNNER_FL","npc_zipline_rope_right");
		thread spawn_script_model_turret("_zipline_gun_fr","tag_turret_zipline_fr","TAG_GUNNER_FR","npc_zipline_rope_left");
		thread spawn_script_model_turret("_zipline_gun_kl","tag_turret_zipline_kl","TAG_GUNNER_KL","npc_zipline_rope_left","npc_optics_zipline_gun");
		thread spawn_script_model_turret("_zipline_gun_kr","tag_turret_zipline_kr","TAG_GUNNER_KR","npc_zipline_rope_right");
	}

	self.emp_death_function = ::warbird_emp_death;
	maps\_utility::add_damage_function(::warbird_emp_damage_function);
}

//Function Number: 5
spawn_turret_model(param_00,param_01)
{
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel(param_01);
	var_02 linkto(self,param_00,(0,0,14),(-8,0,0));
	if(!isdefined(self.turret_models))
	{
		self.turret_models = [];
	}

	self.turret_models[param_00] = var_02;
	self waittill("death");
	var_02 delete();
}

//Function Number: 6
show_blurry_rotors()
{
	self.blurry_rotors_on = 1;
	self hidepart("TAG_STATIC_MAIN_ROTOR_L");
	self hidepart("TAG_STATIC_MAIN_ROTOR_R");
	self hidepart("TAG_STATIC_TAIL_ROTOR");
	self showpart("TAG_SPIN_MAIN_ROTOR_L");
	self showpart("TAG_SPIN_MAIN_ROTOR_R");
	self showpart("TAG_SPIN_TAIL_ROTOR");
}

//Function Number: 7
handle_rotors()
{
	self endon("death");
	self endon("stop_handle_rotors");
	show_blurry_rotors();
	if(isdefined(self.no_anim_rotors) && self.no_anim_rotors)
	{
		return;
	}

	self setanim(%warbird_rotors_spin,1,0.2,1);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		var_02 = self vehicle_getvelocity();
		var_03 = anglestoforward(self.angles);
		var_04 = vectordot(var_02,var_03);
		if(var_04 > 0)
		{
			var_01 = var_04 / 3000;
			var_01 = min(var_01,1);
		}
		else if(var_04 < 0)
		{
			var_01 = var_04 / 1000;
			var_01 = max(var_01,-1);
		}
		else
		{
			var_01 = 0;
		}

		if(var_00 < var_01)
		{
			var_00 = var_00 + 0.1;
			var_00 = min(var_00,var_01);
		}
		else if(var_00 > var_01)
		{
			var_00 = var_00 - 0.1;
			var_00 = max(var_00,var_01);
		}

		if(var_00 > 0)
		{
			self setanimknob(%warbird_rotors_forward,1,0.2,0);
			self setanimtime(%warbird_rotors_forward,var_00);
			self setanim(%rotors_tilt,1,0.2,1);
		}
		else if(var_00 < 0)
		{
			self setanimknob(%warbird_rotors_backward,1,0.2,0);
			self setanimtime(%warbird_rotors_backward,var_00 * -1);
			self setanim(%rotors_tilt,1,0.2,1);
		}
		else
		{
			self clearanim(%rotors_tilt,0.2);
		}

		wait(0.1);
	}
}

//Function Number: 8
open_doors_for_unload(param_00)
{
	var_01 = self gettagangles(param_00);
	var_02 = anglestoforward(var_01);
	var_03 = anglestoright(self.angles);
	var_04 = vectordot(var_03,var_02);
	if(var_04 > 0)
	{
		if(!maps\_utility::ent_flag("right_door_open"))
		{
			thread open_right_door();
			return;
		}

		return;
	}

	if(!maps\_utility::ent_flag("left_door_open"))
	{
		thread open_left_door();
	}
}

//Function Number: 9
open_right_door()
{
	if(!isdefined(self.right_door_anim) || self.right_door_anim != "opening")
	{
		self.right_door_anim = "opening";
		self setanim(%warbird_doors,1,0.2,1);
		self setanim(%warbird_door_r_open,1,0.2,1);
		var_00 = getanimlength(%warbird_door_r_open);
		wait(var_00);
		maps\_utility::ent_flag_set("right_door_open");
	}
}

//Function Number: 10
open_left_door()
{
	if(!isdefined(self.left_door_anim) || self.left_door_anim != "opening")
	{
		self.left_door_anim = "opening";
		self setanim(%warbird_doors,1,0.2,1);
		self setanim(%warbird_door_l_open,1,0.2,1);
		var_00 = getanimlength(%warbird_door_l_open);
		wait(var_00);
		maps\_utility::ent_flag_set("left_door_open");
	}
}

//Function Number: 11
copy_animation_to_model(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 copyanimtreestate(self);
}

//Function Number: 12
copy_animation_to_cloak_models()
{
	copy_animation_to_model(self.cloaked_model);
	copy_animation_to_model(self.decloaking_model);
}

//Function Number: 13
handle_cloak_models_animation()
{
	self endon("death");
	self endon("stop_cloaked_models_animation");
	for(;;)
	{
		copy_animation_to_cloak_models();
		wait(0.05);
	}
}

//Function Number: 14
spawn_script_model_turret(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::spawn_anim_model(param_00);
	if(isdefined(param_03))
	{
		var_05 attach(param_03);
		var_05.rope_model = param_03;
	}

	if(isdefined(param_04))
	{
		var_06 = spawn("script_model",(0,0,0));
		var_06 setmodel("npc_optics_zipline_gun");
		var_06 linkto(var_05,"TAG_DE_TECH",(0,0,0),(0,0,0));
		var_05.attachment = var_06;
	}

	var_05 linkto(self,param_01,(0,0,0),(0,0,0));
	var_05 setanim(level.scr_anim[param_00]["folded_idle"],1,0,1);
	if(!isdefined(self.zipline_gun_model))
	{
		self.zipline_gun_model = [];
	}

	self.zipline_gun_model[param_01] = var_05;
	self.zipline_gunner_tag[param_01] = param_02;
	self waittill("death");
	if(isdefined(var_05.attachment))
	{
		var_05.attachment delete();
	}

	var_05 delete();
}

//Function Number: 15
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 16
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].idle = %helicopter_pilot1_idle;
	var_00[1].idle = %helicopter_pilot1_idle;
	var_00[2].idle = %helicopter_pilot1_idle;
	var_00[3].idle = %helicopter_pilot1_idle;
	var_00[4].idle = %helicopter_pilot1_idle;
	var_00[5].idle = %helicopter_pilot1_idle;
	var_00[0].sittag = "TAG_DRIVER";
	var_00[1].sittag = "TAG_GUY0";
	var_00[2].sittag = "TAG_GUY2";
	var_00[3].sittag = "TAG_GUY3";
	var_00[4].sittag = "TAG_GUY5";
	var_00[5].sittag = "TAG_PASSENGER";
	var_00[1].bnoanimunload = 1;
	var_00[2].bnoanimunload = 1;
	var_00[3].bnoanimunload = 1;
	var_00[4].bnoanimunload = 1;
	var_00[1].rider_func = ::setup_fastzip_unload;
	var_00[2].rider_func = ::setup_fastzip_unload;
	var_00[3].rider_func = ::setup_fastzip_unload;
	var_00[4].rider_func = ::setup_fastzip_unload;
	var_00[1].death_flop_dir = (0,2500,0);
	var_00[2].death_flop_dir = (0,2500,0);
	var_00[3].death_flop_dir = (0,-2500,0);
	var_00[4].death_flop_dir = (0,-2500,0);
	var_00[5].death_flop_dir = (0,-2500,0);
	return var_00;
}

//Function Number: 17
unload_groups()
{
	var_00 = [];
	var_00["default"] = [];
	var_00["default"][var_00["default"].size] = 1;
	var_00["default"][var_00["default"].size] = 2;
	var_00["default"][var_00["default"].size] = 3;
	var_00["default"][var_00["default"].size] = 4;
	return var_00;
}

//Function Number: 18
show_attached_clone_model(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = spawn("script_model",self getorigin());
		param_00 setmodel(param_01);
		param_00 useanimtree(#animtree);
	}

	param_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	copy_animation_to_cloak_models();
	param_00 show();
	return param_00;
}

//Function Number: 19
show_cloaked_warbird()
{
	self.cloaked_model = show_attached_clone_model(self.cloaked_model,"vehicle_xh9_warbird_cloaked_transparent");
}

//Function Number: 20
show_decloaking_warbird()
{
	self.decloaking_model = show_attached_clone_model(self.decloaking_model,"vehicle_xh9_warbird_decloaking_masked");
}

//Function Number: 21
cloak_warbird()
{
	if(is_using_model_memory_sharing())
	{
		self hide();
		show_cloaked_warbird();
		thread handle_cloak_models_animation();
	}
	else if(isdefined(level.cloak_new) && level.cloak_new)
	{
		self.uncloak_model = self.model;
		self setmodel("vehicle_xh9_warbird_low_cloak");
	}
	else
	{
		self.uncloak_model = self.model;
		self setmodel("vehicle_xh9_warbird_cloaked_in_out");
		if(issubstr(self.classname,"_stealth_col"))
		{
			wait(0.25);
			self setmodel("vehicle_xh9_warbird_cloaked_mp");
		}
	}

	if(isdefined(self.blurry_rotors_on) && self.blurry_rotors_on)
	{
		show_blurry_rotors();
	}

	waittillframeend;
	waittillframeend;
	set_cloak_parameter(0,0);
	if(isdefined(self.zipline_gun_model))
	{
		foreach(var_01 in self.zipline_gun_model)
		{
			var_01 hide();
		}
	}

	if(isdefined(self.turret_models))
	{
		foreach(var_04 in self.turret_models)
		{
			var_04 hide();
		}
	}

	if(isdefined(self.mgturret))
	{
		foreach(var_07 in self.mgturret)
		{
			var_07 hide();
		}
	}
}

//Function Number: 22
set_cloak_parameter(param_00,param_01)
{
	if(isdefined(self.uncloak_model))
	{
		self setmaterialscriptparam(param_00,param_01);
	}

	if(isdefined(self.cloaked_model))
	{
		self.cloaked_model setmaterialscriptparam(param_00,param_01);
	}

	if(isdefined(self.decloaking_model))
	{
		self.decloaking_model setmaterialscriptparam(param_00,param_01);
	}
}

//Function Number: 23
setmodel_warbird(param_00)
{
	self endon("death");
	wait(param_00);
	if(is_using_model_memory_sharing())
	{
		self show();
		if(isdefined(self.cloaked_model))
		{
			self.cloaked_model hide();
		}

		if(isdefined(self.decloaking_model))
		{
			self.decloaking_model hide();
		}

		self notify("stop_cloaked_models_animation");
	}
	else if(isdefined(self.uncloak_model))
	{
		self setmodel(self.uncloak_model);
	}

	maps\_vehicle::vehicle_lights_on("running");
	show_blurry_rotors();
}

//Function Number: 24
uncloak_warbird(param_00)
{
	var_01 = 8.3;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(issubstr(self.classname,"_stealth_col") && !is_using_model_memory_sharing())
	{
		self setmodel("vehicle_xh9_warbird_cloaked_in_out");
	}

	if(is_using_model_memory_sharing())
	{
		show_decloaking_warbird();
		thread setmodel_warbird(var_01);
	}
	else if(isdefined(self.uncloak_model))
	{
		thread setmodel_warbird(var_01);
	}

	set_cloak_parameter(1,var_01);
	wait(var_01);
	if(isdefined(self.blurry_rotors_on) && self.blurry_rotors_on)
	{
		show_blurry_rotors();
	}

	if(isdefined(self.zipline_gun_model))
	{
		foreach(var_03 in self.zipline_gun_model)
		{
			var_03 show();
		}
	}

	if(isdefined(self.turret_models))
	{
		foreach(var_06 in self.turret_models)
		{
			var_06 show();
		}
	}

	if(isdefined(self.mgturret))
	{
		foreach(var_09 in self.mgturret)
		{
			var_09 show();
		}
	}
}

//Function Number: 25
warbird_emp_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_ENERGY" && isdefined(self.emp_death_function))
	{
		if(!isdefined(self.emp_hits) || self.emp_hits < 1)
		{
			self.emp_hits = 1;
			return;
		}

		self thread [[ self.emp_death_function ]](param_01,param_04);
	}
}

//Function Number: 26
warbird_emp_death(param_00,param_01)
{
	self endon("death");
	self endon("in_air_explosion");
	self notify("emp_death");
	soundscripts\_snd::snd_message("warbird_emp_death");
	maps\_vehicle::vehicle_lights_off("all");
	self.emp_crash = 1;
	self.vehicle_stays_alive = 1;
	var_02 = self vehicle_getvelocity();
	var_03 = 250;
	if(isdefined(level.get_warbird_crash_location_override))
	{
		var_04 = [[ level.get_warbird_crash_location_override ]]();
	}
	else
	{
		var_05 = (self.origin[0] + var_03[0] * 5,self.origin[1] + var_03[1] * 5,self.origin[2] - 2000);
		var_04 = physicstrace(self.origin + vectornormalize(var_05 - self.origin) * 100,var_05);
	}

	self notify("newpath");
	self notify("deathspin");
	thread warbird_deathspin();
	var_06 = 1000;
	self vehicle_setspeed(var_06,40,1000);
	self setneargoalnotifydist(var_03);
	self setvehgoalpos(var_04,0);
	thread warbird_emp_crash_movement(var_04,var_03,var_06);
	common_scripts\utility::waittill_any("goal","near_goal");
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
	maps\_vehicle_code::vehicle_kill_common(param_00,param_01);
	self notify("death_finished");
	wait(0.05);
	thread kill_and_delete(param_00);
}

//Function Number: 27
kill_and_delete(param_00)
{
	self kill(self.origin,param_00);
	self delete();
}

//Function Number: 28
warbird_deathspin()
{
	level.scr_animtree["warbird_dummy"] = #animtree;
	level.scr_anim["warbird_dummy"]["roll_left"][0] = %rotate_x_l;
	level.scr_anim["warbird_dummy"]["roll_right"][0] = %rotate_x_r;
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 linkto(self);
	if(isdefined(self.death_model_override))
	{
		var_00 setmodel(self.death_model_override);
	}
	else
	{
		var_00 setmodel(self.model);
	}

	var_00 endon("death");
	self hide();
	soundscripts\_snd::snd_message("warbird_emp_death");
	var_00.animname = "warbird_dummy";
	var_00 maps\_utility::assign_animtree();
	if(common_scripts\utility::cointoss())
	{
		var_01 = "roll_left";
	}
	else
	{
		var_01 = "roll_right";
	}

	var_00 thread maps\_anim::anim_loop_solo(var_00,var_01);
	thread common_scripts\utility::delete_on_death(var_00);
	var_02 = 0;
	var_03 = 0.4;
	var_04 = 0.01;
	var_05 = 0.05;
	while(var_02 < var_03)
	{
		var_00 setanimrate(level.scr_anim[var_00.animname][var_01][0],var_02);
		var_02 = var_02 + var_04;
		wait(0.05);
	}
}

//Function Number: 29
warbird_emp_crash_movement(param_00,param_01,param_02)
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	var_03 = 400;
	var_04 = 100;
	var_05 = undefined;
	var_06 = 90 * randomintrange(-2,3);
	for(;;)
	{
		if(self.origin[2] < param_00[2] + param_01)
		{
			self notify("near_goal");
		}

		wait(0.05);
	}
}

//Function Number: 30
setup_fastzip_unload()
{
	self.customunloadfunc = ::fastzip_unload;
	self.ridingvehicle thread maps\_vehicle_aianim::guy_idle(self,self.vehicle_position);
	thread guy_death_inside_warbird();
}

//Function Number: 31
setup_fastzip_anims(param_00)
{
	if(param_00 == "tag_turret_zipline_fl" || param_00 == "tag_turret_zipline_kr")
	{
		var_01 = "zipline_guy_right";
		self.zipline_animname = var_01;
		level.scr_anim[var_01]["rest_idle"] = %zipline_right_rest;
		level.scr_anim[var_01]["readyup"] = %zipline_right_readyup;
		level.scr_anim[var_01]["jumpout"] = %zipline_right_jumpedout;
		level.scr_anim[var_01]["fire"] = %zipline_right_fire;
		level.scr_anim[var_01]["slide_idle_a"][0] = %zipline_right_slidedown_guy_a;
		level.scr_anim[var_01]["slide_idle_b"][0] = %zipline_right_slidedown_guy_b;
		level.scr_anim[var_01]["zipline_right_land_guy_a"] = %zipline_right_land_guy_a;
		level.scr_anim[var_01]["zipline_right_land_guy_b"] = %zipline_right_land_guy_b;
		return;
	}

	var_01 = "zipline_guy_left";
	self.zipline_animname = var_01;
	level.scr_anim[var_01]["rest_idle"] = %zipline_left_rest;
	level.scr_anim[var_01]["readyup"] = %zipline_left_readyup;
	level.scr_anim[var_01]["jumpout"] = %zipline_left_jumpedout;
	level.scr_anim[var_01]["fire"] = %zipline_left_fire;
	level.scr_anim[var_01]["slide_idle_a"][0] = %zipline_left_slidedown_guy_a;
	level.scr_anim[var_01]["slide_idle_b"][0] = %zipline_left_slidedown_guy_b;
	level.scr_anim[var_01]["zipline_left_landing_guy_a"] = %zipline_left_landing_guy_a;
	level.scr_anim[var_01]["zipline_left_landing_guy_b"] = %zipline_left_landing_guy_b;
}

//Function Number: 32
fastzip_unload(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_07, var_05 in param_00.zipline_gun_model)
	{
		var_06 = distance2d(var_05.origin,self.origin);
		if(!isdefined(var_03) || var_06 < var_03)
		{
			if(!isdefined(var_05.turret))
			{
				var_03 = var_06;
				var_02 = var_07;
			}
		}
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	setup_fastzip_anims(var_02);
	var_08 = param_00.zipline_gunner_tag[var_02];
	if(!isdefined(var_08))
	{
		return 0;
	}

	var_09 = find_unload_node(param_00,var_08);
	if(!isdefined(var_09))
	{
		return 0;
	}

	var_0A = calculate_rope_target(param_00,var_02,var_09);
	if(!validate_target_pos(param_00,var_08,var_0A))
	{
		return 0;
	}

	var_0B = param_00.zipline_gun_model[var_02];
	var_0C = setup_zipline_gun("zipline_gun",param_00,var_02,var_0B.model,var_0B.rope_model,var_0B.animname);
	var_0D = setup_zipline_gun("zipline_gun_rope",param_00,var_02,var_0B.rope_model,undefined,var_0B.animname);
	var_0B.turret = var_0C;
	var_0E = common_scripts\utility::spawn_tag_origin();
	var_0E.origin = var_0A;
	var_0C thread common_scripts\utility::delete_on_death(var_0E);
	self.allowdeath = 1;
	self.noragdoll = undefined;
	get_ready_to_use_turret(param_00,var_0B,var_08);
	if(!isdefined(self) || !isalive(self))
	{
		return 1;
	}

	var_0B hide();
	var_0C show();
	var_0C setturretignoregoals(1);
	self useturret(var_0C);
	var_0C settargetentity(var_0E);
	var_0D settargetentity(var_0E);
	var_0C waittill("turret_on_target");
	if(!isdefined(self) || !isalive(self))
	{
		return 1;
	}

	self stopuseturret();
	self linkto(param_00,var_08);
	param_00 thread maps\_anim::anim_single_solo(self,"fire",var_08,undefined,self.zipline_animname);
	var_0F = var_0D fire_rope(var_0C,var_0E.origin,var_0B);
	var_0B show();
	var_0C hide();
	if(!isdefined(self) || !isalive(self))
	{
		return 1;
	}

	play_jump_out_anim(param_00,var_0B,var_08);
	self notify("fastzip_jumped_out");
	if(isdefined(self) && isalive(self))
	{
		var_10 = var_09.animation;
		var_11 = [];
		var_11["zipline_right_land_guy_a"] = "slide_idle_a";
		var_11["zipline_right_land_guy_b"] = "slide_idle_b";
		var_11["zipline_left_landing_guy_a"] = "slide_idle_a";
		var_11["zipline_left_landing_guy_b"] = "slide_idle_b";
		var_12 = var_11[var_10];
		if(!isdefined(var_12))
		{
			var_12 = "slide_idle_a";
		}

		fastzip_slide(var_0D,var_12);
		wait(0.1);
		fastzip_land(var_0D,var_09.origin,var_10);
		wait(1);
		var_0D retract_rope(var_0F);
	}

	var_0E delete();
	var_0C delete();
	var_0D delete();
	var_0B.turret = undefined;
	return 1;
}

//Function Number: 33
get_ready_to_use_turret(param_00,param_01,param_02)
{
	self endon("death");
	thread play_rest_anim(param_00,param_01,param_02);
	wait(0.05);
	param_00 thread open_doors_for_unload(param_02);
	play_ready_up_anim(param_00,param_01,param_02);
}

//Function Number: 34
find_unload_node(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = 1;
	if(param_01 == "TAG_GUNNER_FL" || param_01 == "TAG_GUNNER_KR")
	{
		var_04 = 0;
	}

	var_05 = param_00 gettagorigin(param_01);
	var_06 = param_00 gettagangles(param_01);
	var_07 = anglestoforward(var_06);
	var_08 = anglestoright(var_06);
	var_09 = common_scripts\utility::getstructarray(param_00.currentnode.target,"targetname");
	foreach(var_0B in var_09)
	{
		if(!isdefined(var_0B.script_unloadtype))
		{
			continue;
		}

		var_0C = var_0B.origin - var_05;
		var_0D = vectornormalize(var_0C);
		var_0E = (var_0C[0],var_0C[1],0);
		var_0F = vectornormalize(var_0E);
		var_10 = vectordot(var_07,var_0D);
		if(var_10 < 0)
		{
			continue;
		}

		var_11 = vectordot(var_08,var_0F);
		if(!var_04 && !isdefined(var_03) || var_11 > var_03)
		{
			var_02 = var_0B;
			var_03 = var_11;
			continue;
		}

		if(var_04 && !isdefined(var_03) || var_11 < var_03)
		{
			var_02 = var_0B;
			var_03 = var_11;
		}
	}

	if(!isdefined(var_02))
	{
		return undefined;
	}

	return var_02;
}

//Function Number: 35
calculate_rope_target(param_00,param_01,param_02)
{
	var_03 = param_00 gettagorigin(param_01);
	var_04 = param_02.origin - var_03;
	var_05 = vectortoangles(var_04);
	var_06 = param_00.zipline_gun_model[param_01];
	var_07 = spawn("script_model",param_02.origin);
	var_07.animname = var_06.animname;
	var_07.angles = var_05;
	var_07 maps\_utility::assign_animtree();
	var_07 setmodel(var_06.rope_model);
	var_07 hide();
	var_08 = var_07 maps\_utility::getanim("fastzip_fire");
	var_07 setanimknob(var_08,1,0,0);
	var_09 = var_07 get_ai_fastzip_pos();
	var_0A = var_09[0];
	var_0B = var_09[1];
	var_0C = param_02.origin - var_0A;
	var_07.origin = var_07.origin + var_0C;
	wait(0.05);
	var_0D = var_07 gettagorigin("jnt_shuttleRoot");
	var_07 delete();
	return var_0D;
}

//Function Number: 36
validate_target_pos(param_00,param_01,param_02)
{
	var_03 = param_00 gettagorigin(param_01);
	var_04 = param_00 gettagangles(param_01);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoup(var_04) * -1;
	var_07 = param_02 - var_03;
	var_08 = vectornormalize(var_07);
	var_09 = vectordot(var_08,var_06);
	if(var_09 > cos(30))
	{
		return undefined;
	}

	var_0A = (var_07[0],var_07[1],0);
	var_0B = vectornormalize(var_0A);
	var_0C = vectordot(var_0B,var_05);
	if(var_0C < cos(45))
	{
		return undefined;
	}

	var_0D = length(var_07);
	if(var_0D > 2400)
	{
		return undefined;
	}

	return 1;
}

//Function Number: 37
play_rest_anim(param_00,param_01,param_02)
{
	self notify("newanim");
	maps\_utility::anim_stopanimscripted();
	self unlink();
	param_01 clear_script_model_anim(0);
	param_01 setanim(param_01 maps\_utility::getanim("rest_idle"),1,0,0);
	param_00 maps\_anim::anim_first_frame_solo(self,"rest_idle",param_02,self.zipline_animname);
	self linkto(param_00,param_02);
}

//Function Number: 38
play_ready_up_anim(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	wait(randomfloatrange(0,0.25));
	param_00 thread maps\_anim::anim_single_solo(param_01,"readyup",param_02);
	param_00 maps\_anim::anim_single_solo(self,"readyup",param_02,undefined,self.zipline_animname);
}

//Function Number: 39
play_jump_out_anim(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = [self,param_01];
	param_00 thread maps\_anim::anim_single_solo(param_01,"jumpout",param_02);
	param_00 maps\_anim::anim_single_solo(self,"jumpout",param_02,undefined,self.zipline_animname);
}

//Function Number: 40
aim_test(param_00,param_01,param_02)
{
	var_03 = self gettagorigin("tag_aim");
	var_04 = self gettagangles("tag_aim");
	var_04 = (angleclamp180(var_04[0]),angleclamp180(var_04[1]),angleclamp180(var_04[2]));
	param_00.origin = var_03 + anglestoforward(var_04) * 100;
	while(var_04[0] > -5)
	{
		var_03 = self gettagorigin("tag_aim");
		var_04 = var_04 - (0.1,0,0);
		param_00.origin = var_03 + anglestoforward(var_04) * 100;
		wait(0.05);
	}

	wait(2);
	while(var_04[0] < 60)
	{
		var_03 = self gettagorigin("tag_aim");
		var_05 = self gettagangles("tag_aim");
		var_06 = self gettagorigin("tag_weapon");
		var_07 = self gettagangles("tag_weapon");
		var_08 = self gettagorigin("tag_flash");
		var_09 = self gettagangles("tag_flash");
		var_0A = param_01 gettagorigin(param_02);
		var_0B = param_01 gettagangles(param_02);
		var_04 = var_04 + (0.3,0,0);
		param_00.origin = var_03 + anglestoforward(var_04) * 100;
		wait(0.05);
	}

	wait(1);
	while(var_04[0] > 0)
	{
		var_03 = self gettagorigin("tag_aim");
		var_04 = var_04 - (0.3,0,0);
		param_00.origin = var_03 + anglestoforward(var_04) * 100;
		wait(0.05);
	}

	self notify("aim_test_done");
}

//Function Number: 41
spawn_zipline_turret(param_00,param_01,param_02,param_03)
{
	var_04 = spawnturret("misc_turret",(0,0,0),param_00);
	var_04 linkto(self,param_01,(0,0,0),(0,0,0));
	var_04 setmodel(param_02);
	var_04.angles = self.angles;
	var_04.script_team = self.script_team;
	maps\_vehicle_code::set_turret_team(var_04);
	var_04 setdefaultdroppitch(0);
	var_04 setmode("manual");
	var_04 makeunusable();
	var_04 useanimtree(#animtree);
	var_04.animname = param_03;
	return var_04;
}

//Function Number: 42
setup_zipline_gun(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_01 spawn_zipline_turret(param_00,param_02,param_03,param_05);
	if(isdefined(param_04))
	{
		var_06 attach(param_04);
	}

	var_06 hide();
	var_06 setdefaultdroppitch(0);
	var_06 maps\_utility::anim_stopanimscripted();
	var_06 clear_script_model_anim(0);
	var_06 setanim(var_06 maps\_utility::getanim("fastzip_aim_idle"),1,0,0);
	param_01 thread common_scripts\utility::delete_on_death(var_06);
	return var_06;
}

//Function Number: 43
clear_script_model_anim(param_00)
{
	self clearanim(%root,param_00);
}

//Function Number: 44
fire_rope(param_00,param_01,param_02)
{
	var_03 = 210;
	var_04 = var_03 / 30;
	param_00 detach(param_02.rope_model);
	param_02 detach(param_02.rope_model);
	self show();
	var_05 = param_00 gettagorigin("tag_barrel");
	var_06 = param_01 - var_05;
	var_06 = vectornormalize(var_06);
	var_07 = param_01 + var_06 * 2400;
	var_08 = bullettrace(param_01,var_07,0);
	if(var_08["fraction"] < 1)
	{
		var_07 = var_08["position"];
	}

	var_09 = distance(var_05,var_07) / 12;
	var_0A = var_09 / 200;
	thread sndxt_fastzip_fire(var_07);
	var_0B = maps\_utility::getanim("fastzip_fire");
	var_0C = getanimlength(var_0B);
	var_0D = var_0C / var_04 * var_0A;
	self setanimknob(var_0B,1,0.2,var_04);
	param_00 setanimknob(var_0B,1,0.2,1);
	var_0D = var_0D - 0.05;
	if(var_0D > 0.05)
	{
		wait(var_0D);
	}

	self setanim(var_0B,1,0,0);
	self setanimtime(var_0B,var_0A);
	return var_09;
}

//Function Number: 45
sndxt_fastzip_fire(param_00)
{
	var_01 = self;
	var_02 = randomfloatrange(0.1,0.2);
	wait(var_02);
	var_01 soundscripts\_snd_playsound::snd_play("tac_fastzip_fire");
	wait(var_02);
	common_scripts\utility::play_sound_in_space("tac_fastzip_proj_impact",param_00);
}

//Function Number: 46
fastzip_slide(param_00,param_01)
{
	var_02 = param_00 maps\_utility::getanim("fastzip_slide");
	param_00 setanimlimited(%add_slide,1,0,0);
	param_00 setanimlimited(var_02,1,0,0);
	thread maps\_anim::anim_loop_solo(self,param_01,"stop_loop",undefined,self.zipline_animname);
	var_03 = param_00 get_ai_fastzip_pos();
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06.origin = self.origin;
	var_06.angles = self.angles;
	self linkto(var_06,"tag_origin",(0,0,0),(0,0,0));
	var_06 moveto(var_04,0.2,0.1,0);
	var_06 rotateto(var_05,0.2,0.1,0);
	var_06 waittill("movedone");
	self forceteleport(var_04,var_05);
	self linkto(param_00,"jnt_shuttleRoot",(0,0,0),(0,0,0));
	var_06 delete();
	param_00 setanimlimited(%add_slide,1,0,1.2);
	param_00 setanimlimited(var_02,1,0,1.2);
}

//Function Number: 47
fastzip_land(param_00,param_01,param_02)
{
	var_03 = (0,0,0);
	var_04 = [];
	if(isdefined(self) && isalive(self))
	{
		var_05 = self.origin;
		var_06 = self.origin;
		var_07 = distance(self.origin,param_01);
		for(;;)
		{
			wait(0.05);
			var_08 = param_00 get_ai_fastzip_pos();
			var_09 = var_08[0];
			var_0A = var_08[1];
			var_0B = distance(var_06,var_09);
			var_0C = distance(var_09,param_01);
			var_0D = distance(var_09,var_05);
			if(var_0C < var_0B * 4)
			{
				break;
			}

			if(var_07 < var_0D + var_0B)
			{
				break;
			}

			var_06 = var_09;
		}

		if(isdefined(self))
		{
			var_0E = common_scripts\utility::spawn_tag_origin();
			var_0E.origin = self.origin;
			var_0E.angles = self.angles;
			self linkto(var_0E,"tag_origin",(0,0,0),(0,0,0));
			var_0F = (0,self.angles[1],0);
			var_0E moveto(param_01,0.2,0.1,0);
			var_0E rotateto(var_0F,0.2,0.1,0);
			var_0E waittill("movedone");
			if(isalive(self))
			{
				self unlink();
				self notify("stop_loop");
				self forceteleport(param_01,var_0F);
				thread maps\_anim::anim_single_solo(self,param_02,undefined,undefined,self.zipline_animname);
			}

			var_0E delete();
		}
	}

	var_10 = param_00 maps\_utility::getanim("fastzip_slide");
	param_00 setanimlimited(var_10,1,0,0);
	if(isdefined(self) && isalive(self))
	{
		self endon("death");
		self waittill(param_02);
		if(maps\_vehicle_aianim::guy_resets_goalpos(self))
		{
			self setgoalpos(self.origin);
		}
	}
}

//Function Number: 48
retract_rope(param_00)
{
	var_01 = param_00 / 200;
	var_01 = 1 - min(var_01,1);
	var_02 = 30;
	var_03 = 1;
	var_04 = maps\_utility::getanim("retract_rope");
	self setanimknob(var_04,1,0.2,var_03);
	self setanimtime(var_04,var_01);
	var_05 = var_02 * 1 - var_01 / 30 * var_03;
	wait(var_05 + 0.05);
}

//Function Number: 49
get_ai_fastzip_pos()
{
	var_00 = self gettagorigin("jnt_shuttleRoot");
	var_01 = self gettagangles("jnt_shuttleRoot");
	var_02 = angleclamp180(var_01[0]);
	var_02 = clamp(var_02,-20,20);
	var_03 = (var_02,var_01[1],var_01[2]);
	var_04 = anglestoup(var_03);
	var_00 = var_00 + var_04 * -70;
	return [var_00,var_03];
}

//Function Number: 50
guy_death_inside_warbird()
{
	self endon("fastzip_jumped_out");
	var_00 = self.ridingvehicle;
	thread kill_on_fastzip_jump();
	self waittill("death");
	if(isdefined(var_00))
	{
		if(!self isragdoll())
		{
			if((self.damagemod == "MOD_PROJECTILE_SPLASH" || self.damagemod == "MOD_EXPLOSIVE") && isdefined(self.death_flop_dir))
			{
				var_01 = length(self.death_flop_dir);
				var_02 = vectornormalize(var_00 localtoworldcoords(self.death_flop_dir) - self.origin);
				self startragdollfromimpact("torso_lower",var_02 * var_01);
				return;
			}

			self linkto(var_00);
			self.noragdoll = 1;
			var_00 waittill("death");
			if(isdefined(self))
			{
				self delete();
				return;
			}

			return;
		}
	}
}

//Function Number: 51
kill_on_fastzip_jump()
{
	self endon("death");
	self waittill("fastzip_jumped_out");
	self.noragdoll = undefined;
}
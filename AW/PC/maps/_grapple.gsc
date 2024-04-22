/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _grapple.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 156
 * Decompile Time: 2580 ms
 * Timestamp: 4/22/2024 2:21:16 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01)
{
	setsaveddvar("use_new_sva_system",1);
	if(!isdefined(param_00))
	{
		param_00 = "viewbody_generic_s1";
	}

	level.grapple_defaultscriptedbodymodel = param_00;
	if(!isdefined(param_01))
	{
		param_01 = "viewmodel_base_viewhands";
	}

	level.grapple_defaultviewhandsmodel = param_01;
	level thread grapple_init();
}

//Function Number: 2
grapple_give(param_00,param_01)
{
	self notify("grapple_give");
	self endon("death");
	thread grapple_quick_fire_listener();
	self.grapple["enabled"] = 1;
	self.grapple["grappling"] = 0;
	if(isdefined(param_00))
	{
		self.grapple["model_body"] setmodel(param_00);
	}
	else if(isdefined(level.grapple_defaultscriptedbodymodel))
	{
		self.grapple["model_body"] setmodel(level.grapple_defaultscriptedbodymodel);
	}

	if(isdefined(param_01))
	{
		self.grapple["model_hands"] setmodel(param_01);
	}
	else if(isdefined(level.grapple_defaultviewhandsmodel))
	{
		self.grapple["model_hands"] setmodel(level.grapple_defaultviewhandsmodel);
	}

	self disableoffhandsecondaryweapons();
	thread grapple_enabled_listener();
}

//Function Number: 3
grapple_take()
{
	self notify("grapple_take");
	grapple_switch(0);
	self.grapple["enabled"] = 0;
	grapple_set_hint("");
	grapple_update_preview(0,0);
	self enableoffhandsecondaryweapons();
}

//Function Number: 4
grapple_switch(param_00,param_01,param_02)
{
	var_03 = self getcurrentweapon();
	var_04 = var_03;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!param_00)
	{
		if(var_03 != "none" && var_03 != self.grapple["weapon"])
		{
			return;
		}

		if(isdefined(self.grapple["weapon_prev"]) && self hasweapon(self.grapple["weapon_prev"]))
		{
			var_04 = self.grapple["weapon_prev"];
		}
		else
		{
			var_05 = self getweaponslistprimaries();
			var_06 = var_04;
			foreach(var_08 in var_05)
			{
				if(var_08 != self.grapple["weapon"])
				{
					if(self getweaponammoclip(var_08) > 0)
					{
						var_04 = var_08;
						break;
					}
					else
					{
						var_06 = var_08;
					}
				}
			}

			if(var_04 == var_03)
			{
				var_04 = var_06;
			}
		}

		grapple_set_hint("");
		self.grapple["ready_time"] = max(gettime() + 1000,self.grapple["ready_time"]);
	}
	else
	{
		if(var_03 == self.grapple["weapon"])
		{
			return;
		}

		self.grapple["weapon_prev"] = var_03;
		self giveweapon(self.grapple["weapon"]);
		var_04 = self.grapple["weapon"];
		self.grapple["ready_time"] = max(gettime() + 250,self.grapple["ready_time"]);
		self.grapple["switching_to_grapple"] = 1;
	}

	if(var_03 != var_04 || self.grapple["quick_fire_up"])
	{
		if(var_04 == self.grapple["weapon"])
		{
			self.grapple["ammoCounterHide"] = 1;
			setsaveddvar("ammoCounterHide",1);
			self allowads(0);
			self allowsprint(0);
			self disableusability();
			self.grapple["useReticle"] = param_02;
			setsaveddvar("cg_drawCrosshair",param_02);
			if(isdefined(self.exo_active) && self.exo_active)
			{
				thread maps\_player_exo::player_exo_deactivate();
				self.grapple["exo_deactivated"] = 1;
			}
		}
		else
		{
			self.grapple["ammoCounterHide"] = 0;
			self.grapple["useReticle"] = 1;
			self enableusability();
			if(self.grapple["exo_deactivated"])
			{
				if(isdefined(self.exo_active) && !self.exo_active && !self.grapple["no_enable_exo"])
				{
					thread maps\_player_exo::player_exo_activate();
				}

				self.grapple["exo_deactivated"] = 0;
				self.grapple["no_enable_exo"] = 0;
			}
		}

		if(isdefined(param_01) && param_01)
		{
			self switchtoweaponimmediate(var_04);
			return;
		}

		self switchtoweapon(var_04);
	}
}

//Function Number: 5
grapple_magnet_register(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	param_01 = tolower(param_01);
	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(isdefined(param_05) && !isdefined(param_05.type))
	{
		param_05.type = "";
	}

	if(!isdefined(param_06))
	{
		if(isdefined(param_05) && isdefined(param_05.afterlandanim))
		{
			param_06 = param_05.afterlandanim;
		}
		else
		{
			param_06 = param_00.afterlandanim;
		}
	}

	var_07 = undefined;
	foreach(var_0A, var_09 in level.grapple_magnets)
	{
		if(!isdefined(var_07) && !isdefined(var_09.object))
		{
			var_07 = var_0A;
			continue;
		}

		if(isdefined(var_09.object) && var_09.object == param_00 && var_09.tag == param_01 && var_09.tag_offset == param_02)
		{
			level.grapple_magnets[var_0A].specialstruct = param_05;
			level.grapple_magnets[var_0A].notifyname = param_03;
			level.grapple_magnets[var_0A].afterlandanim = param_06;
			return level.grapple_magnets[var_0A];
		}
	}

	if(!isdefined(var_07))
	{
		var_07 = level.grapple_magnets.size;
	}

	var_09 = spawnstruct();
	var_09.object = param_00;
	var_09.tag = param_01;
	var_09.tag_offset = param_02;
	var_09.static = !isdefined(param_00.classname) || param_00.classname == "script_struct";
	var_09.is_ai = isai(param_00);
	var_09.specialstruct = param_05;
	var_09.notifyname = param_03;
	var_09.afterlandanim = param_06;
	level.grapple_magnets[var_07] = var_09;
	if(isdefined(param_04))
	{
		var_09.next = param_04;
	}
	else if(isdefined(param_00.target) && param_01 == "" || param_01 == "tag_origin")
	{
		param_04 = getent(param_00.target,"targetname");
		if(!isdefined(param_04))
		{
			param_04 = common_scripts\utility::getstruct(param_00.target,"targetname");
		}

		if(isdefined(param_04))
		{
			var_09.next = grapple_magnet_register(param_04);
		}
	}

	if(var_09.static)
	{
		var_09.static_origin = grapple_magnet_origin(var_09);
		if(isdefined(var_09.next) && var_09.next.static)
		{
			var_0B = grapple_magnet_origin(var_09.next);
			var_09.static_length = distance(var_09.static_origin,var_0B);
			var_09.static_sphere_radius = var_09.static_length * 0.5;
			var_09.static_sphere_center = vectorlerp(var_09.static_origin,var_0B,0.5);
		}
	}

	if(!isdefined(param_00.grapple_magnets))
	{
		param_00.grapple_magnets = [var_09];
	}
	else
	{
		param_00.grapple_magnets[param_00.grapple_magnets.size] = var_09;
	}

	if(isai(param_00) && !isdefined(param_00.grapple_death_styles))
	{
		param_00.grapple_death_styles = level.grapple_death_styles;
	}

	return var_09;
}

//Function Number: 6
grapple_magnet_unregister(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	param_01 = tolower(param_01);
	foreach(var_07, var_03 in level.grapple_magnets)
	{
		if(isdefined(var_03) && isdefined(var_03.object) && var_03.object == param_00 && var_03.tag == param_01)
		{
			level.grapple_magnets[var_07].object = undefined;
			grapple_validate_magnets(level.grapple_magnets[var_07]);
			foreach(var_06, var_05 in param_00.grapple_magnets)
			{
				if(isdefined(var_05) && var_05 == level.grapple_magnets[var_07])
				{
					param_00.grapple_magnets[var_06] = undefined;
					break;
				}
			}
		}
	}

	if(isdefined(param_00.grapple_magnets) && param_00.grapple_magnets.size == 0)
	{
		param_00.grapple_magnets = undefined;
		param_00.grapple_death_styles = undefined;
	}
}

//Function Number: 7
grapple_init()
{
	maps\_grapple_anim::grapple_init_anims_player();
	maps\_grapple_anim::grapple_init_anims_props();
	grapple_init_anims_weapon();
	maps\_grapple_anim::grapple_init_anims_actors();
	grapple_precache();
	grapple_register_snd_messages();
	grapple_init_magnets();
	grapple_init_death_styles();
	maps\_utility::add_extra_autosave_check("grappling",::grapple_autosave_grappling_check,"grappling.");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isdefined(var_01.grapple_initialized))
			{
				var_01 grapple_init_player();
				var_01.grapple_initialized = 1;
			}

			var_02 = issaverecentlyloaded();
			if(var_02 && !var_01.grapple["recent_load_reset"])
			{
				if(var_01.grapple["grappled_count"] > 1)
				{
					var_01.grapple["grappled_count"] = 1;
				}

				var_01 grapple_switch(0,1);
				if(var_01.grapple["enabled"])
				{
					var_01 thread grapple_quick_fire_listener();
					var_01 thread grapple_enabled_listener();
					var_01.grapple["grappling"] = 0;
				}

				var_01.grapple["recent_load_reset"] = 1;
				continue;
			}

			if(!var_02)
			{
				var_01.grapple["recent_load_reset"] = 0;
			}
		}

		wait(0.25);
	}
}

//Function Number: 8
grapple_init_magnets()
{
	level.grapple_magnets = [];
	var_00 = common_scripts\utility::getstructarray("grapple_magnet","script_noteworthy");
	foreach(var_02 in var_00)
	{
		grapple_magnet_register(var_02);
	}

	var_00 = getentarray("grapple_magnet","script_noteworthy");
	foreach(var_02 in var_00)
	{
		grapple_magnet_register(var_02);
	}

	if(common_scripts\utility::issp())
	{
		thread grapple_magnet_actor_monitor();
	}
}

//Function Number: 9
grapple_magnet_actor_monitor()
{
	for(;;)
	{
		wait(0.5);
		var_00 = getaiarray("axis");
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02) && var_02 grapple_ai_alive() && !isdefined(var_02.grapple_magnets))
			{
				grapple_magnet_register(var_02,"J_SpineUpper");
				var_02 thread grapple_magnet_unregister_on_death("J_SpineUpper");
			}
		}
	}
}

//Function Number: 10
grapple_magnet_unregister_on_death(param_00)
{
	self notify("grapple_unregister_on_death");
	self endon("grapple_unregister_on_death");
	self waittill("death");
	if(isdefined(self))
	{
		grapple_magnet_unregister(self,param_00);
	}
}

//Function Number: 11
grapple_notify_players_magnet_unregister(param_00)
{
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.grapple) && isdefined(var_02.grapple["magnet_current"]))
		{
			if(isdefined(var_02.grapple["magnet_current"].magnet) && var_02.grapple["magnet_current"].magnet == param_00)
			{
				var_02.grapple["magnet_current"].valid = 0;
				var_02.grapple["magnet_current"].magnet = undefined;
				var_02.grapple["magnet_current"].origin = undefined;
			}
		}
	}
}

//Function Number: 12
grapple_precache()
{
	level._effect["grapple_cam"] = loadfx("vfx/map/irons_estate/grapple_cam");
	precachemodel("vm_spydeco");
	grapple_model_precache("model_player_from","tag_origin");
	grapple_model_precache("model_player_to","tag_origin");
	grapple_model_precache("model_player_trans","tag_origin");
	grapple_model_precache("model_preview","tag_origin");
	grapple_model_precache("model_preview_hint","tag_origin");
	grapple_model_precache("model_rope_attach_world","tag_origin");
	grapple_model_precache("model_player_move_tag","tag_origin");
	grapple_model_precache("model_player_move_lerp","tag_origin");
	grapple_model_precache("model_rope_attach_player","tag_origin");
	grapple_model_precache("model_attach_world","tag_origin");
	grapple_model_precache("model_ai_link","tag_origin");
	grapple_model_precache("model_rope_fire","grapple_rope");
	grapple_model_precache("model_rope_idle","grapple_rope_stretch");
	grapple_model_precache("model_hands","grapple_hands");
	grapple_model_precache("model_body","grapple_body");
	precacheitem("s1_grapple");
	precacheitem("s1_grapple_impact");
	precacherumble("subtle_tank_rumble");
	precacherumble("heavygun_fire");
	precacherumble("falling_land");
	precacherumble("damage_light");
	precacheshader("grapple_reticle_indicator");
	precacheshader("grapple_reticle_indicator_small");
	setdvarifuninitialized("grapple_enabled",1);
	setdvarifuninitialized("grapple_tutorial",1);
	setdvarifuninitialized("grapple_hint_always",1);
	setdvarifuninitialized("grapple_hint_button_always",1);
	setdvarifuninitialized("grapple_magnet_fov",48);
	setdvarifuninitialized("grapple_magnet_fov_ai",5);
	setdvarifuninitialized("grapple_magnet_enabled",1);
	setdvarifuninitialized("grapple_magnet_required",1);
	setdvarifuninitialized("grapple_magnet_show_offset",0);
	setdvarifuninitialized("grapple_magnet_lines",1);
	setdvarifuninitialized("grapple_mantle_reach",64);
	setdvarifuninitialized("grapple_mantle_kill_radius",75);
	setdvarifuninitialized("grapple_mantle_required",1);
	setdvarifuninitialized("grapple_lerp_velocity",1);
	setdvarifuninitialized("grapple_status_text",0);
	setdvarifuninitialized("grapple_ai_priority",0.02);
	setdvarifuninitialized("grapple_concealed_kill_range_min",100);
	setdvarifuninitialized("grapple_concealed_kill_range",400);
	setdvarifuninitialized("grapple_concealed_kill_range_z",80);
	setdvarifuninitialized("grapple_concealed_kill",1);
	grapple_register_hint("grapple_input_tutorial",&"GRAPPLE_INPUT_TUTORIAL",&"GRAPPLE_INPUT_TUTORIAL",::grapple_hint_hide_tutorial);
	grapple_register_hint("grapple_kill",&"GRAPPLE_KILL",&"GRAPPLE_KILL",::grapple_hint_hide_kill);
	grapple_register_hint("grapple_kill_pull",&"GRAPPLE_KILL_PULL",&"GRAPPLE_KILL_PULL",::grapple_hint_hide_kill_pull);
}

//Function Number: 13
grapple_register_snd_messages()
{
	soundscripts\_snd::snd_register_message("aud_grapple_launch",::aud_grapple_launch);
	level.grapple_snd_pain = ["ie_as1_quietpain1","ie_as1_quietpain2","ie_as2_quietpain1","ie_as2_quietpain2","ie_as3_quietpain1","ie_as3_quietpain2"];
	level.grapple_snd_death = ["ie_as1_quietdeath1","ie_as1_quietdeath2","ie_as2_quietdeath1","ie_as2_quietdeath2","ie_as3_quietdeath1","ie_as3_quietdeath2"];
}

//Function Number: 14
aud_grapple_launch()
{
	if(common_scripts\utility::issp())
	{
		if(isai(self))
		{
			snd_play_linked_notify_on_ent("linelauncher_fire","stop_grapplesound_npc",0.2);
			snd_play_linked_notify_on_ent("linelauncher_move","stop_grapplesound_npc",0.1);
			return;
		}

		soundscripts\_snd_playsound::snd_play_2d("linelauncher_fire_player");
		soundscripts\_snd_playsound::snd_play_2d("linelauncher_cable_fly_player","stop_grapplesound",undefined,0.2);
		return;
	}
}

//Function Number: 15
snd_play_linked_notify_on_ent(param_00,param_01,param_02)
{
	thread snd_play_linked_notify_on_ent_thread(param_00,param_01,param_02);
}

//Function Number: 16
snd_play_linked_notify_on_ent_thread(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",self.origin);
	var_03 linkto(self);
	var_03 playsound(param_00);
	self waittill(param_01);
	var_03 scalevolume(0,param_02);
	wait(param_02);
	var_03 stopsounds();
	wait 0.05;
	var_03 delete();
}

//Function Number: 17
grapple_after_land_anim()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_entity) && isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.afterlandanim) && var_00.land_magnet.tag != "")
	{
		var_01 = var_00.land_magnet.afterlandanim;
		grapple_setup_rope_attached_player(self,self,0);
		grapple_rope_state(2);
		var_02 = self.grapple["model_body"];
		var_02 unlink();
		var_02 linkto(var_00.land_entity,var_00.land_magnet.tag,(0,0,0),(0,0,0));
		var_02 dontinterpolate();
		var_03 = var_00.land_entity gettagorigin(var_00.land_magnet.tag);
		var_04 = var_00.land_entity gettagangles(var_00.land_magnet.tag);
		var_02 show();
		var_02 animscripted("grapple_after_land_anim",var_03,var_04,var_01,undefined,undefined,0.2);
		self unlink();
		self playerlinktoblend(var_02,"tag_player",0.2);
		grapple_disable_weapon();
		self notify("grapple_land_anim");
		wait(getanimlength(var_01));
		var_02 hide();
		var_05 = self.grapple["model_player_from"];
		var_05 unlink();
		var_05.origin = self.origin;
		if(isdefined(var_05.land_entity))
		{
			if(isdefined(var_05.land_magnet) && var_05.land_magnet.tag != "")
			{
				var_05 linkto(var_05.land_entity,var_05.land_magnet.tag);
			}
			else
			{
				var_05 linkto(var_05.land_entity);
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 18
grapple_rope_length_thread(param_00,param_01,param_02)
{
	self notify("grapple_rope_length_thread");
	self endon("grapple_rope_length_thread");
	param_00 endon("death");
	self endon("death");
	if(param_01 == 0)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = 2000;
	self useanimtree(#animtree);
	var_04 = %vm_grapple_idle_rope;
	self setanim(var_04,1,0,0);
	while(isdefined(param_00) && isdefined(self))
	{
		var_05 = distance(self.origin,param_00.origin);
		if(param_01 == 1)
		{
			var_05 = var_05 - 253;
		}

		var_05 = var_05 + param_02;
		var_06 = clamp(var_05 / var_03,1E-05,0.99999);
		self setanimtime(var_04,var_06);
		wait(0.05);
	}
}

//Function Number: 19
grapple_rope_state(param_00,param_01,param_02)
{
	var_03 = self.grapple["model_rope_fire"];
	var_04 = self.grapple["model_rope_idle"];
	self.grapple["rope_state"] = param_00;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	switch(param_00)
	{
		case 0:
			var_03 hide();
			var_03 drawfacingentity(undefined);
			var_04 hide();
			var_04 drawfacingentity(undefined);
			var_04 notify("grapple_rope_length_thread");
			break;

		case 1:
			var_03 show();
			var_03 dontinterpolate();
			var_03.angles = self getplayerangles();
			if(param_02)
			{
				var_03 drawfacingentity(undefined);
			}
			else
			{
				var_03 drawfacingentity(self.grapple["model_rope_attach_world"]);
			}
	
			var_04 show();
			var_04.angles = vectortoangles(self.grapple["model_rope_attach_player"].origin - var_03.origin);
			if(param_02)
			{
				var_04 drawfacingentity(undefined);
			}
			else
			{
				var_04 drawfacingentity(self.grapple["model_rope_attach_player"]);
			}
	
			var_04 thread grapple_rope_length_thread(self.grapple["model_rope_attach_player"],param_00,param_01);
			break;

		case 2:
			var_03 hide();
			var_03 drawfacingentity(undefined);
			var_04 show();
			var_04 dontinterpolate();
			var_04.angles = vectortoangles(self.grapple["model_rope_attach_player"].origin - var_04.origin);
			if(param_02)
			{
				var_04 drawfacingentity(undefined);
			}
			else
			{
				var_04 drawfacingentity(self.grapple["model_rope_attach_player"]);
			}
	
			var_04 thread grapple_rope_length_thread(self.grapple["model_rope_attach_player"],param_00,param_01);
			break;
	}
}

//Function Number: 20
grapple_init_anims_weapon()
{
	level.grapple_weapon_anim = [];
	level.grapple_weapon_anim["fire"] = "fire";
	level.grapple_weapon_anim["travel"] = "reload";
	level.grapple_weapon_anim["ready"] = "raise";
}

//Function Number: 21
grapple_init_death_style(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.7;
	}

	var_09 = spawnstruct();
	var_09.name = param_00;
	var_09.normal = param_01;
	var_09.dot = param_02;
	var_09.hint = param_03;
	var_09.validator = param_04;
	var_09.handler = param_05;
	var_09.handler_parm1 = param_06;
	var_09.handler_parm2 = param_07;
	var_09.handler_parm3 = param_08;
	level.grapple_death_styles[var_09.name] = var_09;
	return var_09;
}

//Function Number: 22
grapple_init_death_styles()
{
	level.grapple_death_styles = [];
	grapple_init_death_style("death_grapple_pull_back_obs",(1,0,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed_obs,::grapple_death_pull,"_obs","death_grapple_back");
	grapple_init_death_style("death_grapple_pull_front_obs",(-1,0,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed_obs,::grapple_death_pull,"_obs","death_grapple_front");
	grapple_init_death_style("death_grapple_pull_right_obs",(0,1,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed_obs,::grapple_death_pull,"_obs","death_grapple_right");
	grapple_init_death_style("death_grapple_pull_left_obs",(0,-1,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed_obs,::grapple_death_pull,"_obs","death_grapple_left");
	grapple_init_death_style("grapple_death_pull_above_obs",(0,0,-1),cos(30),"grapple_kill_pull",::grapple_death_valid_pull_obs,::grapple_death_pull,"_above_obs");
	grapple_init_death_style("grapple_death_pull_above_obs_45",(0,0,-1),cos(60),"grapple_kill_pull",::grapple_death_valid_pull_obs,::grapple_death_pull,"_above_obs_45");
	grapple_init_death_style("death_grapple_pull_back",(1,0,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed,::grapple_death_pull,"","death_grapple_back");
	grapple_init_death_style("death_grapple_pull_front",(-1,0,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed,::grapple_death_pull,"","death_grapple_front");
	grapple_init_death_style("death_grapple_pull_right",(0,1,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed,::grapple_death_pull,"","death_grapple_right");
	grapple_init_death_style("death_grapple_pull_left",(0,-1,0),cos(46),"grapple_kill_pull",::grapple_death_valid_pull_concealed,::grapple_death_pull,"","death_grapple_left");
	grapple_init_death_style("grapple_death_pull_above",(0,0,-1),cos(30),"grapple_kill_pull",::grapple_death_valid_pull,::grapple_death_pull,"_above");
	grapple_init_death_style("grapple_death_pull_above_45",(0,0,-1),cos(60),"grapple_kill_pull",::grapple_death_valid_pull,::grapple_death_pull,"_above_45");
	level.grapple_death_styles["default"] = level.grapple_death_styles["death_grapple_back"];
}

//Function Number: 23
grapple_anim_length(param_00,param_01)
{
	if(isdefined(level.scr_anim[param_00]) && isdefined(level.scr_anim[param_00][param_01]))
	{
		return getanimlength(level.scr_anim[param_00][param_01]);
	}

	return 0;
}

//Function Number: 24
grapple_anim_anim(param_00,param_01)
{
	if(isdefined(level.scr_anim[param_00]) && isdefined(level.scr_anim[param_00][param_01]))
	{
		return level.scr_anim[param_00][param_01];
	}

	return undefined;
}

//Function Number: 25
grapple_anim_tree(param_00)
{
	return level.scr_animtree[param_00];
}

//Function Number: 26
grapple_shutdown()
{
	foreach(var_01 in level.players)
	{
		var_01 grapple_shutdown_player();
	}

	level.grapple = undefined;
}

//Function Number: 27
grapple_init_player()
{
	grapple_shutdown_player();
	self.grapple = [];
	grapple_models_init_player();
	self.grapple["preview_visible"] = 0;
	self.grapple["preview_good"] = 0;
	grapple_setup_rope_attached();
	grapple_setup_rope_fire();
	grapple_update_preview(0,0);
	self.grapple["ready_time"] = 0;
	self.grapple["ready_weapon"] = 0;
	self.grapple["allowed"] = 0;
	self.grapple["grappling"] = 0;
	self.grapple["connected"] = 0;
	self.grapple["aborted"] = 0;
	self.grapple["mantle"] = undefined;
	self.grapple["listening"] = 0;
	self.grapple["in_range_min"] = 0;
	self.grapple["in_range_max"] = 0;
	self.grapple["weapon"] = "s1_grapple";
	self.grapple["weapon_prev"] = undefined;
	thread grapple_quick_fire_listener();
	self.grapple["dist_min"] = 100;
	self.grapple["dist_max"] = 1500;
	self.grapple["dist_max_2d"] = 1500;
	self.grapple["dist_max_kill"] = 800;
	self.grapple["speed"] = 600;
	self.grapple["mantle_kills"] = 1;
	self.grapple["ammoCounterHide"] = 0;
	self.grapple["useReticle"] = 1;
	self.grapple["exo_deactivated"] = 0;
	self.grapple["no_enable_exo"] = 0;
	self.grapple["no_enable_weapon"] = 0;
	self.grapple["weapon_enabled"] = 1;
	self.grapple["concealed"] = 0;
	self.grapple["style"] = undefined;
	self.grapple["hint_scale"] = 1;
	self.grapple["hint"] = undefined;
	self.grapple["hintText"] = undefined;
	self.grapple["poll_velocity"] = (0,0,0);
	self.grapple["grapple_while_falling"] = 1;
	self.grapple["grappled_count"] = 0;
	self.grapple["linked_hands"] = 0;
	self.grapple["kill_obstructed_clear"] = 0;
	self.grapple["recent_load_reset"] = 0;
	self.grapple["enabled"] = 0;
	self.grapple["magnet_current"] = spawnstruct();
	self.grapple["magnet_test"] = spawnstruct();
	grapple_magnet_state(self.grapple["magnet_current"]);
	grapple_magnet_state(self.grapple["magnet_test"]);
	thread grapple_weapon_listener();
	thread grapple_start_listener();
	thread grapple_projectile_listener();
	thread grapple_death_listener();
	self.grapple["model_hands"] dontcastshadows();
	self.grapple["model_body"] dontcastshadows();
	self.grapple["model_rope_fire"] dontcastshadows();
	self.grapple["model_rope_idle"] dontcastshadows();
	grapple_give();
}

//Function Number: 28
grapple_grappling_stealth_getstance()
{
	return "crouch";
}

//Function Number: 29
grapple_grappling_stealth_getinshadow()
{
	return 1;
}

//Function Number: 30
grapple_set_grappling(param_00)
{
	if(!isdefined(self.grapple))
	{
		return;
	}

	if(self.grapple["grappling"] == param_00)
	{
		return;
	}

	if(!param_00)
	{
		grapple_motion_blur_disable();
	}

	if(isdefined(self._stealth))
	{
		if(param_00)
		{
			self.grapple["stealth_orig_stance"] = self._stealth.logic.getstance_func;
			self._stealth.logic.getstance_func = ::grapple_grappling_stealth_getstance;
			if(isdefined(self._stealth.logic.getinshadow_func))
			{
				self.grapple["stealth_orig_shadow"] = self._stealth.logic.getinshadow_func;
			}

			self._stealth.logic.getinshadow_func = ::grapple_grappling_stealth_getinshadow;
		}
		else
		{
			if(isdefined(self.grapple["stealth_orig_stance"]))
			{
				self._stealth.logic.getstance_func = self.grapple["stealth_orig_stance"];
			}

			if(isdefined(self.grapple["stealth_orig_shadow"]))
			{
				self._stealth.logic.getinshadow_func = self.grapple["stealth_orig_shadow"];
			}

			self.grapple["stealth_orig_stance"] = undefined;
			self.grapple["stealth_orig_shadow"] = undefined;
		}
	}

	self.grapple["grappling"] = param_00;
}

//Function Number: 31
grapple_autosave_grappling_check()
{
	if(isdefined(level.player.grapple) && level.player.grapple["grappling"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
grapple_setup_rope_attached_player(param_00,param_01,param_02,param_03)
{
	var_04 = self.grapple["model_rope_attach_player"];
	var_04 unlink();
	var_05 = (-3,6,-2);
	if(isdefined(param_02) && param_02)
	{
		if(self.grapple["style"] == "ceiling")
		{
			var_05 = (-5,0,3);
		}
		else
		{
			var_05 = (-3,0,-6.6);
		}
	}

	if(isplayer(param_01))
	{
		var_04.origin = self.origin + (0,0,60);
		var_04.angles = self getplayerangles();
	}
	else
	{
		var_04.origin = param_01.origin;
		var_04.angles = param_01.angles;
	}

	if(isdefined(param_03))
	{
		var_04 linkto(param_00,param_03,var_05 + (0,0,60),(0,0,0));
	}
	else
	{
		var_04.origin = var_04.origin + rotatevector(var_05,var_04.angles);
		var_04 linkto(param_00);
	}

	var_04 dontinterpolate();
	var_06 = self.grapple["model_rope_idle"];
	var_06 dontinterpolate();
}

//Function Number: 33
grapple_setup_rope_attached(param_00)
{
	if(!isdefined(self.grapple["rope_state"]))
	{
		self.grapple["rope_state"] = 0;
	}

	var_01 = self.grapple["model_attach_world"];
	var_02 = self.grapple["model_rope_attach_world"];
	var_03 = self.grapple["model_rope_attach_player"];
	var_04 = self.grapple["model_rope_idle"];
	var_05 = self.grapple["model_player_move_tag"];
	var_06 = self.grapple["model_player_move_lerp"];
	var_02 unlink();
	var_02.origin = var_01.origin + rotatevector((0,0,0),var_01.angles);
	var_02.angles = var_01.angles;
	var_02 linkto(var_01);
	var_05.origin = self.origin;
	var_05.angles = self.angles;
	var_06.origin = var_05.origin;
	var_06.angles = var_05.angles;
	var_06 dontinterpolate();
	var_06 linkto(var_05);
	grapple_setup_rope_attached_player(var_06,self,param_00);
	var_04 unlink();
	var_04.origin = var_02.origin;
	var_04.angles = var_02.angles;
	var_04 linkto(var_02);
	var_04 thread grapple_rope_length_thread(var_03,self.grapple["rope_state"]);
	var_04 dontinterpolate();
	var_05 dontinterpolate();
	var_02 dontinterpolate();
}

//Function Number: 34
grapple_setup_rope_fire()
{
	var_00 = self.grapple["model_rope_attach_world"];
	var_01 = self.grapple["model_rope_fire"];
	var_02 = self.grapple["model_player_move_tag"];
	var_03 = self.grapple["model_player_move_lerp"];
	var_01 unlink();
	var_02.origin = self.origin;
	var_02.angles = self.angles;
	var_01.origin = self.origin + (0,0,60);
	var_01.origin = var_01.origin + rotatevector((0,0,0),self getplayerangles());
	var_01.angles = self getplayerangles();
	var_01 linkto(var_03);
	var_01 dontinterpolate();
	var_02 dontinterpolate();
}

//Function Number: 35
grapple_models_init_player()
{
	foreach(var_03, var_01 in level.grapple["models"])
	{
		var_02 = undefined;
		if(isdefined(level.scr_model[var_01]))
		{
			var_02 = maps\_utility::spawn_anim_model(var_01,(0,0,0));
		}
		else
		{
			var_02 = spawn("script_model",(0,0,0));
			if(isdefined(var_02))
			{
				var_02 setmodel(var_01);
			}
		}

		if(isdefined(var_02))
		{
			var_02 notsolid();
			var_02 setcontents(0);
			var_02 hide();
		}
		else
		{
		}

		self.grapple[var_03] = var_02;
	}
}

//Function Number: 36
grapple_model_precache(param_00,param_01,param_02)
{
	var_03 = param_01;
	if(isdefined(level.scr_model[param_01]))
	{
		var_03 = level.scr_model[param_01];
	}

	precachemodel(var_03);
	if(!isdefined(level.grapple))
	{
		level.grapple = [];
	}

	if(!isdefined(level.grapple["models"]))
	{
		level.grapple["models"] = [];
	}

	level.grapple["models"][param_00] = param_01;
}

//Function Number: 37
grapple_shutdown_player()
{
	self notify("grapple_shutdown_player");
	if(isdefined(self.grapple) && isdefined(self.grapple["weapon"]))
	{
		grapple_take();
	}

	if(isdefined(self.grapple))
	{
		grapple_update_preview(0,0);
		grapple_set_status("");
		foreach(var_02, var_01 in level.grapple["models"])
		{
			if(isdefined(self.grapple[var_02]))
			{
				self.grapple[var_02] delete();
			}
		}

		grapple_set_grappling(0);
		self.grapple = undefined;
		self.grapple_victim_landanim = undefined;
	}

	self allowfire(1);
}

//Function Number: 38
grapple_weapon_listener()
{
	self endon("death");
	self endon("grapple_shutdown_player");
	level endon("missionfailed");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		var_01 = var_00 == self.grapple["weapon"];
		if(!var_01 || var_01 != self.grapple["ready_weapon"])
		{
			self.grapple["ready_time"] = max(gettime() + 250,self.grapple["ready_time"]);
		}

		if(self.grapple["quick_fire_down"] && self.grapple["weapon_enabled"])
		{
			self.grapple["ready_time"] = gettime();
		}

		self.grapple["ready_weapon"] = var_01;
		if(!var_01 && var_00 != "none" && self hasweapon(self.grapple["weapon"]) && !self isreloading())
		{
			if(!isdefined(self.grapple["switching_to_grapple"]) || !self.grapple["switching_to_grapple"])
			{
				grapple_take_weapon();
			}
		}

		if(!self.grapple["enabled"])
		{
			wait(0.05);
			continue;
		}

		if(!var_01 && var_00 != "none")
		{
			setsaveddvar("cg_drawCrosshair",self.grapple["useReticle"] && !self.grapple["grappling"]);
		}

		if(var_01)
		{
			self.grapple["switching_to_grapple"] = 0;
			self allowfire(0);
		}
		else
		{
			self allowfire(1);
			setsaveddvar("ammoCounterHide",self.grapple["ammoCounterHide"]);
			self allowads(!self.grapple["ammoCounterHide"]);
			self allowsprint(!self.grapple["ammoCounterHide"]);
		}

		self.grapple["kill_obstructed_clear"] = 0;
		if(self.grapple["magnet_current"].valid && isdefined(self.grapple["magnet_current"].magnet) && isai(self.grapple["magnet_current"].magnet.object))
		{
			var_02 = self.origin + anglestoforward(self.angles) * 16 + (0,0,10);
			var_03 = playerphysicstrace(self.origin,var_02,self);
			if(distancesquared(var_03,var_02) > 0.01)
			{
				var_02 = self.origin + anglestoforward(self.angles) * -48 + (0,0,10);
				var_03 = playerphysicstrace(self.origin,var_02,self);
				if(distancesquared(var_03,var_02) < 0.01)
				{
					self.grapple["kill_obstructed_clear"] = 1;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 39
grapple_enabled()
{
	if(!getdvarint("grapple_enabled"))
	{
		return 0;
	}

	if(!isdefined(self.grapple))
	{
		return 0;
	}

	if(!self.grapple["enabled"])
	{
		return 0;
	}

	if(isdefined(self.tagging) && isdefined(self.tagging["tagging_mode"]) && self.tagging["tagging_mode"])
	{
		return 0;
	}

	if(isdefined(self.using_ammo_cache) && self.using_ammo_cache)
	{
		return 0;
	}

	if(self ismeleeing())
	{
		return 0;
	}

	if(self isthrowinggrenade() || self isholdinggrenade())
	{
		return 0;
	}

	if(self ismantling())
	{
		return 0;
	}

	var_00 = weaponclass(self getcurrentweapon());
	if(var_00 == "item" || var_00 == "shield")
	{
		return 0;
	}

	if(common_scripts\utility::flag_exist("player_has_cardoor") && common_scripts\utility::flag("player_has_cardoor"))
	{
		return 0;
	}

	if(common_scripts\utility::flag_exist("player_pulling_cardoor") && common_scripts\utility::flag("player_pulling_cardoor"))
	{
		return 0;
	}

	if(!self.grapple["grapple_while_falling"] && !self islinked() && !self isonground())
	{
		return 0;
	}

	if(isdefined(self.underwater))
	{
		return 0;
	}

	return 1;
}

//Function Number: 40
grapple_hint_hide_unusable()
{
	if(!isdefined(self.grapple))
	{
		return 1;
	}

	if(!isdefined(self.grapple["allowed"]))
	{
		return 1;
	}

	if(!self.grapple["allowed"])
	{
		return 1;
	}

	if(!grapple_enabled())
	{
		return 1;
	}

	if(maps\_utility::isads())
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
grapple_hint_hide_tutorial()
{
	if(grapple_hint_hide_unusable())
	{
		return 1;
	}

	if(!getdvarint("grapple_hint_button_always"))
	{
		if(self.grapple["grappled_count"] >= 2)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 42
grapple_hint_hide_kill()
{
	if(grapple_hint_hide_unusable())
	{
		return 1;
	}

	if(!isdefined(grapple_special_hint()) && !isdefined(self.grapple["mantle"]) || !isdefined(self.grapple["mantle"]["victim"]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
grapple_hint_hide_kill_pull()
{
	if(grapple_hint_hide_unusable())
	{
		return 1;
	}

	if(!isdefined(self.grapple["deathstyle"]) || !isdefined(self.grapple["deathstyle"].hint))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
grapple_not_connected()
{
	if(!isdefined(self.grapple))
	{
		return 1;
	}

	if(!isdefined(self.grapple["connected"]))
	{
		return 1;
	}

	if(!self.grapple["connected"])
	{
		return 1;
	}

	if(!grapple_enabled())
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
grapple_register_hint(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.grapple_hints))
	{
		level.grapple_hints = [];
	}

	if(!isdefined(param_01))
	{
		param_01 = param_02;
	}

	if(!isdefined(param_02))
	{
		param_02 = param_01;
	}

	level.grapple_hints[param_00] = 1;
	maps\_utility::add_hint_string(param_00 + "_gamepad",param_01,param_03);
	maps\_utility::add_hint_string(param_00 + "_pc",param_02,param_03);
}

//Function Number: 46
grapple_set_hint(param_00)
{
	if(isdefined(self.grapple["hintText"]) && self.grapple["hintText"] == param_00)
	{
		return;
	}

	if(param_00 == "grapple_kill_pull" && getdvarint("grapple_concealed_kill") == 2)
	{
		return;
	}

	if(isdefined(self.grapple["hint"]))
	{
		self.grapple["hint"] maps\_utility::hint_delete();
		self.grapple["hint"] = undefined;
		self.grapple["hintText"] = undefined;
	}

	if(isdefined(param_00) && param_00 != "")
	{
		if(isdefined(level.grapple_hints[param_00]))
		{
			if(self usinggamepad())
			{
				maps\_utility::display_hint(param_00 + "_gamepad");
				return;
			}

			maps\_utility::display_hint(param_00 + "_pc");
			return;
		}

		self.grapple["hint"] = maps\_utility::hint_create(param_00);
		self.grapple["hintText"] = param_00;
		if(isdefined(self.grapple["hint"]))
		{
			self.grapple["hint"].elm.aligny = "bottom";
			self.grapple["hint"].elm.vertalign = "bottom";
			if(isdefined(self.grapple["hint"].bg))
			{
				self.grapple["hint"].bg.aligny = "bottom";
				self.grapple["hint"].bg.vertalign = "bottom";
			}
		}

		return self.grapple["hint"];
	}
}

//Function Number: 47
grapple_text_compare(param_00,param_01)
{
	if(isdefined(param_00) && !isdefined(param_01))
	{
		return 1;
	}

	if(!isdefined(param_00) && isdefined(param_01))
	{
		return 1;
	}

	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 0;
	}

	if(isstring(param_00) && isstring(param_01) && param_00 == param_01)
	{
		return 0;
	}

	if(!isstring(param_00) && !isstring(param_01) && param_00 == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 48
grapple_status_text_show(param_00,param_01,param_02,param_03)
{
	if(!getdvarint("grapple_status_text"))
	{
		return;
	}

	self notify("grapple_status_text_show_" + param_01);
	self endon("grapple_status_text_show_" + param_01);
	var_04 = gettime();
	var_05 = "status_text_" + param_01;
	var_06 = var_05 + "_last";
	var_07 = var_05 + "_hint";
	var_08 = var_05 + "_dim";
	self.grapple[var_08] = 0;
	var_09 = self.grapple[var_05];
	while(gettime() - var_04 <= param_00)
	{
		if(isdefined(var_09) && !isstring(var_09) || var_09 != "")
		{
			if(grapple_text_compare(var_09,self.grapple[var_06]))
			{
				if(isdefined(self.grapple[var_07]))
				{
					self.grapple[var_07] maps\_utility::hint_delete();
				}

				self.grapple[var_07] = maps\_utility::hint_create(var_09);
				if(getdvarint("grapple_hint_always"))
				{
					self.grapple[var_07].elm.color = (1,1,1);
				}
				else
				{
					self.grapple[var_07].elm.color = (1,0,0);
				}

				self.grapple[var_07].elm.y = param_03;
				self.grapple[var_07].elm.x = param_02;
				self.grapple[var_06] = var_09;
			}

			if(isdefined(self.grapple[var_07]) && !self.grapple[var_08])
			{
				if(self.grapple["allowed"] || gettime() - var_04 >= param_00 * 0.95 || !isdefined(self.grapple[var_05]) || isstring(self.grapple[var_05]) != isstring(var_09) || self.grapple[var_05] != var_09)
				{
					self.grapple[var_07].elm.alpha = self.grapple[var_07].elm.alpha * 0.5;
					self.grapple[var_08] = 1;
				}
			}

			continue;
		}

		if(isdefined(self.grapple[var_07]))
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(self.grapple[var_07]))
	{
		self.grapple[var_07] maps\_utility::hint_delete();
		self.grapple[var_07] = undefined;
		self.grapple[var_06] = undefined;
		self.grapple[var_08] = undefined;
	}
}

//Function Number: 49
grapple_commit_status()
{
	self notify("grapple_commit_status");
	if(!isdefined(self.grapple))
	{
		return;
	}

	var_00 = self.grapple["icon_name_desired"];
	var_01 = self.grapple["icon_allowed_desired"];
	var_02 = self.grapple["icon_entity_style"];
	if(!isdefined(var_00))
	{
		var_00 = "";
	}

	if(!isdefined(var_01))
	{
		var_01 = 0;
	}

	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	if(!isalive(self))
	{
		var_00 = "";
	}

	if(!grapple_enabled())
	{
		var_00 = "";
	}

	if(maps\_utility::isads())
	{
		var_00 = "";
	}

	if(var_00 != "")
	{
		if(getdvarint("grapple_hint_always") == 0)
		{
			if(self.grapple["ready_time"] > gettime())
			{
				var_00 = "";
			}
		}
		else if(!var_01)
		{
			var_00 = "";
		}
	}

	var_00 = "";
	var_03 = var_00 + "_" + var_01 + "_" + var_02;
	var_04 = undefined;
	var_05 = self.grapple["weapon_enabled"] && self getcurrentweapon() == self.grapple["weapon"];
	if(getdvarint("grapple_hint_always") == 0)
	{
		grapple_commit_reticles((1,0,0),var_00 != "");
	}
	else
	{
		grapple_commit_reticles((1,1,1),var_00 != "");
	}

	var_06 = (1,1,1);
	if(getdvarint("grapple_hint_always") == 0)
	{
		if(var_01)
		{
			var_06 = (0,1,0);
		}
		else
		{
			var_06 = (1,0,0);
		}
	}

	if(var_02 == "kill")
	{
		var_06 = (1,0.5,0);
	}

	if(!isdefined(self.grapple["icon_name"]) || self.grapple["icon_name"] != var_03)
	{
		self.grapple["icon_name"] = var_03;
		if(var_00 == "")
		{
			if(isdefined(self.grapple["icon"]))
			{
				self.grapple["icon"] destroy();
				self.grapple["icon"] = undefined;
			}

			return;
		}

		if(isdefined(self.grapple["icon"]))
		{
			var_04 = self.grapple["icon"];
		}
		else
		{
			var_04 = newhudelem();
		}

		var_04.x = 0;
		var_04.sort = 999;
		var_04.alignx = "center";
		var_04.aligny = "middle";
		var_04.horzalign = "center";
		var_04.vertalign = "middle";
		var_04.fontscale = 2.5;
		var_04.hidewheninmenu = 1;
		var_04 settext("^3[{+smoke}]^7 Grapple");
		var_04.y = 100;
		if(getdvarint("grapple_hint_always") != 0)
		{
			var_04.alpha = 1;
		}

		self.grapple["icon"] = var_04;
	}

	if(isdefined(self.grapple["icon"]))
	{
		self.grapple["icon"].color = var_06;
	}

	grapple_commit_reticles(var_06,0);
}

//Function Number: 50
grapple_commit_reticles(param_00,param_01)
{
	var_02 = ["grapple_reticle_indicator"];
	var_03 = [param_01];
	foreach(var_07, var_05 in var_02)
	{
		if(var_03[var_07] && !isdefined(self.grapple[var_05]))
		{
			var_06 = newhudelem();
			var_06.x = 0;
			var_06.y = 0;
			var_06.sort = 999;
			var_06.alignx = "center";
			var_06.aligny = "middle";
			var_06.horzalign = "center";
			var_06.vertalign = "middle";
			var_06.hidewheninmenu = 1;
			var_06 setshader(var_05,128,128);
			self.grapple[var_05] = var_06;
		}
		else if(!var_03[var_07] && isdefined(self.grapple[var_05]))
		{
			self.grapple[var_05] destroy();
			self.grapple[var_05] = undefined;
		}

		if(var_03[var_07] && isdefined(self.grapple[var_05]))
		{
			self.grapple[var_05].color = param_00;
		}
	}
}

//Function Number: 51
grapple_set_status(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	self.grapple["icon_name_desired"] = param_00;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.grapple["icon_allowed_desired"] = param_02;
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self.grapple["icon_entity_style"] = param_01;
	if(!isdefined(param_03))
	{
		param_03 = "";
	}

	self.grapple["status_text_reason"] = param_03;
	thread grapple_commit_status();
}

//Function Number: 52
grapple_update_preview(param_00,param_01)
{
	var_02 = 1.5;
	if(level.ps3)
	{
		var_02 = 1.2;
	}
	else if(level.xenon)
	{
		var_02 = 0.8;
	}

	if(!isdefined(self.grapple))
	{
		return;
	}

	if(param_00 && !maps\_utility::isads() && isdefined(self.grapple["model_preview_hint"]))
	{
		var_03 = self.grapple["grappled_count"] < 2 || getdvarint("grapple_hint_button_always");
		if(getdvarint("grapple_tutorial") && var_03 && !isdefined(self.grapple["quick_hint_text"]))
		{
			if(!self.grapple["magnet_current"].valid)
			{
				grapple_set_hint("grapple_input_tutorial");
			}
			else
			{
				var_04 = newhudelem();
				var_04 settext("^3[{+smoke}]^7");
				var_04.alignx = "center";
				var_04.aligny = "middle";
				var_04.horzalign = "center";
				var_04.vertalign = "middle";
				var_04.positioninworld = 1;
				var_04.fontscale = var_02;
				var_04.alpha = 1;
				var_04.vistime = gettime();
				var_04.hidewheninmenu = 1;
				self.grapple["model_preview"] dontinterpolate();
				self.grapple["model_preview_hint"] dontinterpolate();
				var_04 settargetent(self.grapple["model_preview_hint"],"tag_origin");
				self.grapple["quick_hint_text"] = var_04;
			}
		}

		if(!getdvarint("grapple_hint_button_always") && self.grapple["grappled_count"] && getdvarint("grapple_tutorial") && isdefined(self.grapple["quick_hint_text"]) && gettime() - self.grapple["quick_hint_text"].vistime > 1000 && self.grapple["quick_hint_text"].alpha > 0)
		{
			self.grapple["quick_hint_text"].alpha = self.grapple["quick_hint_text"].alpha - 0.05;
		}

		if(isdefined(grapple_special_hint()))
		{
			grapple_set_hint(grapple_special_hint());
		}
		else if(isdefined(self.grapple["deathstyle"]))
		{
			grapple_set_hint(self.grapple["deathstyle"].hint);
		}
		else if(isdefined(self.grapple["mantle"]) && isdefined(self.grapple["mantle"]["victim"]))
		{
			grapple_set_hint("grapple_kill");
		}

		if(!isdefined(self.grapple["quick_hint_icon"]))
		{
			var_04 = newhudelem();
			var_04.x = 0;
			var_04.y = 0;
			var_04.z = 0;
			var_04.alignx = "center";
			var_04.aligny = "middle";
			var_04.horzalign = "center";
			var_04.vertalign = "middle";
			var_04.positioninworld = 1;
			var_04.hidewheninmenu = 1;
			self.grapple["model_preview"] dontinterpolate();
			var_04 settargetent(self.grapple["model_preview_hint"],"tag_origin");
			self.grapple["quick_hint_icon"] = var_04;
		}

		if(!param_01)
		{
			if(isdefined(self.grapple["quick_hint_mantle"]))
			{
				self.grapple["quick_hint_mantle"] destroy();
			}
		}

		if(self.grapple["magnet_current"].valid)
		{
			self.grapple["quick_hint_icon"] setshader("grapple_reticle_indicator_small",32,32);
			self.grapple["quick_hint_icon"].positioninworld = 1;
			self.grapple["quick_hint_icon"] settargetent(self.grapple["model_preview_hint"],"tag_origin");
		}
		else
		{
			self.grapple["quick_hint_icon"] setshader("grapple_reticle_indicator",128,128);
			self.grapple["quick_hint_icon"].positioninworld = 0;
		}

		if(self.grapple["magnet_current"].valid && isdefined(self.grapple["magnet_current"].magnet) && isai(self.grapple["magnet_current"].magnet.object))
		{
			if(isdefined(self.grapple["quick_hint_icon"]))
			{
				self.grapple["quick_hint_icon"].color = (1,0.5,0);
			}

			if(isdefined(self.grapple["quick_hint_text"]))
			{
				self.grapple["quick_hint_text"].color = (1,0.5,0);
				return;
			}

			return;
		}

		if(isdefined(self.grapple["quick_hint_icon"]))
		{
			self.grapple["quick_hint_icon"].color = (1,1,1);
		}

		if(isdefined(self.grapple["quick_hint_text"]))
		{
			self.grapple["quick_hint_text"].color = (1,1,1);
			return;
		}

		return;
	}

	if(isdefined(self.grapple["quick_hint_text"]))
	{
		self.grapple["quick_hint_text"] destroy();
	}

	if(isdefined(self.grapple["quick_hint_icon"]))
	{
		self.grapple["quick_hint_icon"] destroy();
	}

	if(isdefined(self.grapple["quick_hint_icon"]))
	{
		self.grapple["quick_hint_icon"] destroy();
	}

	if(isdefined(self.grapple["quick_hint_mantle"]))
	{
		self.grapple["quick_hint_mantle"] destroy();
	}
}

//Function Number: 53
grapple_update_preview_position(param_00,param_01,param_02)
{
	var_03 = self.grapple["model_preview"];
	var_04 = self.grapple["model_preview_hint"];
	if(isdefined(var_03.linked_entity) && isdefined(param_02.land_entity) && isdefined(var_03.linked_magnet) && isdefined(param_02.land_magnet) && var_03.linked_entity == param_02.land_entity && var_03.linked_magnet == param_02.land_magnet && !isdefined(param_02.land_magnet.next))
	{
		return;
	}

	var_03 unlink();
	var_03.linked_entity = undefined;
	var_03.linked_magnet = undefined;
	var_03.origin = param_00;
	var_03.angles = param_01;
	if(isdefined(param_02.land_entity))
	{
		if(isdefined(param_02.land_magnet) && param_02.land_magnet.tag != "")
		{
			var_03.origin = param_02.land_magnet.object gettagorigin(param_02.land_magnet.tag);
			var_03.angles = param_02.land_magnet.object gettagangles(param_02.land_magnet.tag);
			var_03.origin = var_03.origin + rotatevector(param_02.land_magnet.tag_offset,self.angles);
			var_03 linkto(param_02.land_entity,param_02.land_magnet.tag);
		}
		else
		{
			var_03 linkto(param_02.land_entity);
		}

		var_03.linked_entity = param_02.land_entity;
		var_03.linked_magnet = param_02.land_magnet;
	}

	if(self.grapple["magnet_current"].valid && !isdefined(self.grapple["magnet_current"].magnet) || self.grapple["magnet_current"].magnet.tag == "")
	{
		if(isdefined(self.grapple["mantle"]))
		{
			var_04.origin = (var_03.origin[0],var_03.origin[1],self.grapple["mantle"]["ledge"][2]);
		}
		else
		{
			var_04.origin = var_03.origin + (0,0,8);
		}

		var_05 = grapple_special_indicator_offset();
		var_04.origin = var_04.origin + var_05;
		var_04 linkto(var_03);
		return;
	}

	var_05.origin = var_04 gettagorigin("tag_origin");
	var_05 = grapple_special_indicator_offset();
	var_04.origin = var_04.origin + var_05;
	var_04 linkto(var_03);
}

//Function Number: 54
grapple_quick_fire_listener()
{
	self notify("grapple_quick_fire_listener");
	self endon("death");
	self endon("grapple_shutdown_player");
	self endon("grapple_take");
	self endon("grapple_quick_fire_listener");
	self.grapple["quick_fire_action"] = "smoke";
	self notifyonplayercommand("quickFireDown","+" + self.grapple["quick_fire_action"]);
	self notifyonplayercommand("quickFireUp","-" + self.grapple["quick_fire_action"]);
	childthread grapple_quick_fire_wait_and_set("quickFireDown","quick_fire_button_down",1,0);
	childthread grapple_quick_fire_wait_and_set("quickFireUp","quick_fire_button_up",1,1);
	self.grapple["quick_fire_down"] = 0;
	self.grapple["quick_fire_up"] = 0;
	self.grapple["quick_fire_button_down"] = 0;
	self.grapple["quick_fire_button_up"] = 0;
	self.grapple["quick_fire_executed"] = 0;
	self.grapple["quick_firing"] = 0;
	var_00 = 0;
	for(;;)
	{
		var_00 = var_00 + 1;
		if(var_00 >= 2)
		{
			self.grapple["quick_firing"] = 0;
		}

		if(self.grapple["quick_fire_button_up"])
		{
			if(self.grapple["quick_fire_down"] && !self.grapple["quick_fire_up"])
			{
				self.grapple["quick_fire_button_up"] = 0;
				self.grapple["quick_fire_up"] = 1;
				self.grapple["quick_firing"] = 1;
				if(self getcurrentweapon() == self.grapple["weapon"])
				{
					self.grapple["quick_fire_trace"] = undefined;
				}

				while(self.grapple["allowed"] && self getcurrentweapon() != self.grapple["weapon"])
				{
					wait(0.05);
				}

				self enableweaponswitch();
				if(self.grapple["allowed"])
				{
					grapple_start("grapple_quick");
				}
				else
				{
					grapple_switch(0);
				}

				self.grapple["quick_fire_down"] = 0;
				self.grapple["quick_fire_up"] = 0;
			}
			else
			{
				self.grapple["quick_fire_button_down"] = 0;
			}
		}

		if(!self.grapple["quick_fire_down"] && !self.grapple["quick_fire_button_down"])
		{
			self.grapple["quick_fire_button_up"] = 0;
		}

		if(!self.grapple["quick_fire_down"] && self.grapple["quick_fire_button_down"])
		{
			if(self getcurrentweapon() != self.grapple["weapon"] && getdvarint("grapple_hint_always") && !self.grapple["allowed"] || maps\_utility::isads())
			{
				thread grapple_status_text_show(1000,"reason",0,90);
				wait(0.05);
				continue;
			}

			if(isdefined(self.tagging) && isdefined(self.tagging["drone"]))
			{
				wait(0.05);
				continue;
			}

			self.grapple["quick_fire_button_down"] = 0;
			if(self getcurrentweapon() == self.grapple["weapon"] || !self fragbuttonpressed())
			{
				if(self getcurrentweapon() != self.grapple["weapon"])
				{
					var_01 = self.grapple["model_player_to"];
					if(grapple_special() == "callback")
					{
						self.grapple["ready_time"] = gettime();
						grapple_start("grapple_quick");
					}
					else
					{
						self.grapple["quick_fire_down"] = 1;
						self.grapple["quick_firing"] = 1;
						var_02 = grapple_trace_parms();
						self.grapple["quick_fire_trace"] = grappletrace(var_02["start"],var_02["end"],self);
						if(isdefined(self.grapple["quick_fire_trace"]["entity"]))
						{
							var_03 = self.grapple["quick_fire_trace"]["entity"];
							var_04 = self.grapple["quick_fire_trace"]["position"] - var_03.origin;
							var_04 = rotatevector(var_04,var_03.angles * -1);
							self.grapple["quick_fire_trace"]["local_position"] = var_04;
						}

						var_00 = 0;
						grapple_switch(1,1);
						self disableweaponswitch();
					}
				}
				else
				{
					grapple_start("grapple");
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 55
grapple_quick_fire_wait_and_set(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		self waittill(param_00);
		if(self.grapple["listening"])
		{
			self.grapple[param_01] = param_02;
		}
		else
		{
			self.grapple[param_01] = param_03;
		}

		wait(0.05);
	}
}

//Function Number: 56
grapple_enabled_listener_flag()
{
	self notify("grapple_enabled_listener_flag");
	self endon("grapple_enabled_listener_flag");
	self.grapple["listening"] = 1;
	common_scripts\utility::waittill_any("death","grapple_started","grapple_shutdown_player");
	if(isdefined(self) && isdefined(self.grapple))
	{
		self.grapple["listening"] = 0;
	}
}

//Function Number: 57
grapple_enabled_listener()
{
	self notify("grapple_enabled_listener");
	self endon("grapple_enabled_listener");
	self endon("death");
	self endon("grapple_started");
	self endon("grapple_shutdown_player");
	thread grapple_enabled_listener_flag();
	var_00 = self.grapple["model_player_to"];
	for(;;)
	{
		var_01 = "grapple_invalid";
		var_02 = "";
		var_03 = &"GRAPPLE_NO_FOOTING";
		var_04 = self.grapple["ready_time"] <= gettime();
		var_05 = grapple_enabled();
		if(self.grapple["quick_firing"] || self.grapple["grappling"])
		{
			if(!var_05)
			{
				grapple_update_preview(0,0);
				grapple_set_status(var_01,var_02,0,var_03);
			}

			wait(0.05);
			continue;
		}

		self.grapple["allowed"] = 0;
		self.grapple["in_range_min"] = 0;
		self.grapple["in_range_max"] = 0;
		self.grapple["mantle"] = undefined;
		if(!var_05)
		{
			grapple_update_preview(0,0);
			grapple_set_status(var_01,var_02,self.grapple["allowed"],var_03);
			wait(0.05);
			continue;
		}

		grapple_magnet_update();
		var_06 = undefined;
		if(self.grapple["magnet_current"].valid && isdefined(self.grapple["magnet_current"].tracevalidation))
		{
			var_06 = self.grapple["magnet_current"].tracevalidation;
		}
		else if(getdvarint("grapple_magnet_required") && self.grapple["magnet_current"].possible)
		{
			var_03 = self.grapple["magnet_current"].tracevalidation["reason"];
		}
		else if(!getdvarint("grapple_magnet_required"))
		{
			var_07 = grapple_trace_parms();
			var_08 = grappletrace(var_07["start"],var_07["end"],self,0);
			var_06 = grapple_trace_validate(var_08,var_07["dist"],var_07["forward"],var_07["angles"]);
		}

		var_06 = grapple_trace_validate_mantle(var_06,self.grapple["magnet_current"]);
		if(isdefined(var_06) && !isdefined(self.grapple["magnet_current"].magnet) && getdvarint("grapple_mantle_required") && !isdefined(var_06["mantle"]))
		{
			var_06 = undefined;
		}

		if(!isdefined(var_06))
		{
			grapple_update_preview(0,0);
			grapple_set_status(var_01,var_02,self.grapple["allowed"],var_03);
			wait(0.05);
			continue;
		}

		var_00.land_entity = undefined;
		var_00.land_tag = undefined;
		var_00 unlink();
		self.grapple["allowed"] = var_06["allowed"];
		self.grapple["style"] = var_06["style"];
		self.grapple["in_range_max"] = var_06["in_range_max"];
		self.grapple["in_range_min"] = var_06["in_range_min"];
		self.grapple["mantle"] = var_06["mantle"];
		self.grapple["surface_trace"] = var_06["surface_trace"];
		self.grapple["deathstyle"] = var_06["deathstyle"];
		var_00.land_entity = var_06["land_entity"];
		var_00.land_magnet = var_06["land_magnet"];
		var_00.origin = var_06["tag_origin"];
		var_00.angles = var_06["tag_angles"];
		var_00.style = var_06["style"];
		var_03 = var_06["reason"];
		var_09 = var_06["valid_surface"];
		var_0A = self.grapple["dist_min"];
		if(isdefined(var_06["dist_min"]))
		{
			var_0A = var_06["dist_min"];
		}

		if(isdefined(var_00.land_entity))
		{
			if(isdefined(var_00.land_magnet) && var_00.land_magnet.tag != "")
			{
				var_00 linkto(var_00.land_entity,var_00.land_magnet.tag);
			}
			else
			{
				var_00 linkto(var_00.land_entity);
			}
		}

		var_00 dontinterpolate();
		var_0B = self.grapple["model_preview"];
		var_0C = var_06["surface_trace"]["normal"];
		var_0D = vectordot(var_0C,(0,0,1));
		if(abs(var_0D) > 0.99999)
		{
			var_0E = vectorcross(anglestoforward(self getplayerangles()),var_0C);
		}
		else
		{
			var_0E = vectorcross((0,0,1),var_0C);
		}

		var_0F = vectorcross(var_0C,var_0E);
		grapple_update_preview_position(var_06["surface_trace"]["position"],axistoangles(var_0F,var_0E,var_0C),var_00);
		var_10 = 0;
		if(var_09 && distancesquared(var_00.origin,self.origin) > var_0A * var_0A)
		{
			var_10 = 1;
		}

		if(!var_09 && self.grapple["in_range_max"] && self.grapple["in_range_min"])
		{
			var_03 = &"GRAPPLE_INVALID_SURFACE";
			self.grapple["allowed"] = 0;
		}
		else if(!self.grapple["in_range_max"])
		{
			var_03 = &"GRAPPLE_TOO_FAR";
			self.grapple["allowed"] = 0;
		}
		else if(!self.grapple["in_range_min"])
		{
			var_03 = &"GRAPPLE_TOO_CLOSE";
			self.grapple["allowed"] = 0;
		}

		if(self.grapple["allowed"])
		{
			var_01 = "grapple_valid";
			var_02 = "";
			var_03 = "";
		}

		var_02 = grapple_entity_style(self.grapple["surface_trace"]["entity"],var_06["land_magnet"]);
		if(isdefined(var_02))
		{
			var_01 = "grapple_valid";
			self.grapple["allowed"] = self.grapple["in_range_max"];
		}
		else if(self getstance() == "prone")
		{
			var_01 = "grapple_invalid";
			var_03 = &"GRAPPLE_NO_FOOTING";
			self.grapple["allowed"] = 0;
		}

		grapple_update_preview(self.grapple["allowed"],isdefined(self.grapple["mantle"]));
		grapple_set_status(var_01,var_02,self.grapple["allowed"],var_03);
		wait(0.05);
	}
}

//Function Number: 58
grapple_trace_validate(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05["allowed"] = 0;
	var_05["in_range_min"] = 0;
	var_05["in_range_max"] = 0;
	var_05["mantle"] = undefined;
	var_05["surface_trace"] = param_00;
	var_05["valid_surface"] = grapple_check_surface_type(param_00,param_04);
	var_05["deathstyle"] = undefined;
	var_06 = self geteye();
	var_07 = distancesquared((param_00["position"][0],param_00["position"][1],0),(var_06[0],var_06[1],0));
	var_08 = param_00["fraction"] * param_01;
	var_09 = param_00["normal"];
	var_0A = undefined;
	if(isdefined(param_04))
	{
		var_0A = param_04.magnet;
	}

	if(isdefined(var_0A) && isdefined(var_0A.specialstruct) && isdefined(var_0A.specialstruct.forcestyle))
	{
		var_05["style"] = var_0A.specialstruct.forcestyle;
	}
	else
	{
		var_05["style"] = grapple_get_style(param_00["position"],var_09);
	}

	var_0B = param_00["normal"] * -1;
	var_0C = "";
	var_0D = param_00["position"];
	if(isdefined(var_0A) && isdefined(var_0A.object) && var_0A.tag != "")
	{
		var_0C = var_0A.tag;
		var_0D = var_0A.object gettagorigin(var_0C);
		var_0D = var_0D + rotatevector(var_0A.tag_offset,var_0A.object gettagangles(var_0C));
	}

	if(var_05["style"] == "ceiling")
	{
		var_05["tag_origin"] = var_0D + (0,0,-75);
		var_05["tag_angles"] = param_03;
	}
	else if(var_05["style"] == "floor")
	{
		var_05["tag_origin"] = var_0D;
		var_05["tag_angles"] = param_03;
	}
	else
	{
		var_05["tag_origin"] = var_0D + (0,0,-30);
		var_05["tag_angles"] = vectortoangles(var_0B);
	}

	var_05["reason"] = &"GRAPPLE_TOO_FAR";
	var_0E = self.grapple["dist_max"];
	var_0F = self.grapple["dist_max_2d"];
	var_10 = self.grapple["dist_min"];
	if(isdefined(var_0A) && isdefined(var_0A.specialstruct))
	{
		if(isdefined(var_0A.specialstruct.distmin))
		{
			var_10 = var_0A.specialstruct.distmin;
			var_05["dist_min"] = var_10;
		}

		if(isdefined(var_0A.specialstruct.distmax))
		{
			var_0E = var_0A.specialstruct.distmax;
			var_05["dist_max"] = var_0E;
		}
	}

	if(var_08 <= var_0E && var_07 <= var_0F * var_0F && param_00["fraction"] < 1)
	{
		var_05["in_range_max"] = 1;
		var_05["reason"] = &"GRAPPLE_TOO_CLOSE";
		if(var_08 >= var_10)
		{
			var_05["in_range_min"] = 1;
			var_11 = vectordot(var_09,param_02 * -1);
			if(var_05["style"] == "wall")
			{
				var_12 = vectornormalize((param_02[0],param_02[1],min(0,param_02[2])));
				var_11 = vectordot(var_09,var_12 * -1);
			}

			var_13 = getdvarfloat("grapple_surface_dot_limit");
			var_05["reason"] = &"GRAPPLE_TOO_SHARP";
			if(var_11 >= var_13 || var_05["style"] == "floor")
			{
				if(var_0C == "")
				{
					var_14 = playerphysicstraceinfo(var_05["tag_origin"] + var_09 * 50,var_0D + var_09 * -50,self);
					var_05["tag_origin"] = var_14["position"] + var_09;
					var_05["tag_angles"] = (0,var_05["tag_angles"][1],0);
				}

				var_15 = playerphysicstraceinfo(var_05["tag_origin"],var_05["tag_origin"] + var_09 * 0.1,self);
				var_05["reason"] = &"GRAPPLE_NO_SPACE";
				if(var_0C != "")
				{
					var_05["allowed"] = 1;
				}
				else if(var_05["valid_surface"] && isdefined(var_15["fraction"]) && var_15["fraction"] == 1 && grapple_abort_trace_passed(var_05["tag_origin"]))
				{
					var_05["allowed"] = 1;
				}

				var_05["land_entity"] = param_00["entity"];
				var_05["land_magnet"] = undefined;
				if(isdefined(var_0A) && isdefined(var_0A.object))
				{
					var_05["land_magnet"] = var_0A;
					if(!var_0A.static)
					{
						var_05["land_entity"] = var_0A.object;
					}

					if(var_0C != "" && isdefined(var_0A.afterlandanim) && isdefined(var_05["land_entity"]))
					{
						var_16 = self.grapple["model_body"];
						var_16 unlink();
						var_16 linkto(var_05["land_entity"],var_0C,(0,0,0),(0,0,0));
						var_16 dontinterpolate();
						var_16 setanimknobrestart(var_0A.afterlandanim,1,0,0);
						var_05["tag_origin"] = var_16 gettagorigin("tag_player");
						var_05["tag_angles"] = var_16 gettagangles("tag_player");
					}
				}

				if(var_05["allowed"] && !isdefined(var_05["mantle"]))
				{
					var_05["reason"] = &"GRAPPLE_NO_FOOTING";
					var_05["allowed"] = grapple_check_footing(var_05);
				}
			}
		}
	}

	var_17 = grapple_entity_style(param_00["entity"],var_0A);
	if(isdefined(var_17))
	{
		var_05["allowed"] = var_05["in_range_max"];
		var_05["deathstyle"] = grapple_death_style(param_00["entity"]);
	}

	return var_05;
}

//Function Number: 59
grapple_trace_validate_mantle(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_02 = undefined;
	var_03 = "";
	if(isdefined(param_01) && param_01.valid)
	{
		var_02 = param_01.magnet;
	}

	if(isdefined(var_02) && isdefined(var_02.object) && var_02.tag != "")
	{
		var_03 = var_02.tag;
	}

	if(param_00["style"] == "wall" && var_03 == "")
	{
		var_04 = self canmantleex(param_00["tag_origin"],param_00["tag_angles"],0,getdvarint("grapple_mantle_reach"),1);
		if(isdefined(var_04["valid"]) && var_04["valid"])
		{
			var_04["victim"] = grapple_mantle_find_victim(var_04);
			var_05 = self.grapple["model_player_to"];
			var_04["position_local"] = rotatevectorinverted(var_04["position"] - var_05.origin,var_05.angles);
			var_04["ledge_local"] = rotatevectorinverted(var_04["ledge"] - var_05.origin,var_05.angles);
			param_00["mantle"] = var_04;
			if(isdefined(var_04["over"]) && var_04["over"])
			{
				param_00["tag_origin"] = (param_00["tag_origin"][0],param_00["tag_origin"][1],var_04["ledge"][2] + -32);
			}
			else
			{
				param_00["tag_origin"] = (param_00["tag_origin"][0],param_00["tag_origin"][1],var_04["ledge"][2] + -64);
			}
		}
	}

	return param_00;
}

//Function Number: 60
grapple_mantle_find_victim(param_00)
{
	var_01 = getdvarfloat("grapple_mantle_kill_radius");
	var_01 = var_01 * var_01;
	if(self.grapple["mantle_kills"])
	{
		var_02 = param_00["position"];
		var_03 = getaiarray("axis");
		foreach(var_05 in var_03)
		{
			if(!var_05 grapple_ai_alive())
			{
				continue;
			}

			if(distancesquared(var_05.origin,var_02) > var_01)
			{
				continue;
			}

			if(issubstr(var_05.classname,"mech"))
			{
				continue;
			}

			return var_05;
		}
	}

	return undefined;
}

//Function Number: 61
grapple_mantle_victim(param_00,param_01)
{
	self notify("grapple_mantle_victim");
	self endon("grapple_mantle_victim");
	if(!isdefined(self.animname))
	{
		self.animname = "generic";
	}

	childthread grapple_mantle_victim_ignore_thread(param_01);
	self endon("death");
	var_02 = "";
	if(param_01.grapple["mantle"]["over"])
	{
		var_03 = "land_mantle_kill_over";
	}
	else
	{
		var_03 = "land_mantle_kill_up";
	}

	if(common_scripts\utility::cointoss())
	{
		var_02 = "_2";
	}

	var_03 = var_03 + var_02;
	if(isdefined(self.grapple_death_rig))
	{
		self.grapple_death_rig delete();
	}

	self.grapple_death_rig = common_scripts\utility::spawn_tag_origin();
	self.grapple_death_rig thread grapple_mantle_victim_rig_cleanup(self);
	self.grapple_death_rig.origin = param_01.grapple["mantle"]["position"];
	self.grapple_death_rig.angles = param_01.grapple["model_player_to"].angles;
	self.grapple_death_rig dontinterpolate();
	param_01.grapple_victim_landanim = var_03;
	self.grapple_death_rig thread maps\_anim::anim_reach_solo(self,var_03);
	self waittill("grapple_landing_anim");
	animscripts\shared::dropallaiweapons();
	if(var_03 == "land_mantle_kill_up")
	{
		soundscripts\_snd_playsound::snd_play_2d("grapple_mantle_kill_throw");
		thread aud_fall_scream();
	}
	else
	{
		soundscripts\_snd_playsound::snd_play_2d("grapple_mantle_kill_kick");
	}

	self.grapple_death_rig maps\_anim::anim_single_solo(self,var_03);
}

//Function Number: 62
aud_fall_scream()
{
	wait(2);
	soundscripts\_snd_playsound::snd_play_2d("grapple_kill_falling_scream");
}

//Function Number: 63
grapple_mantle_victim_rig_cleanup(param_00)
{
	self notify("grapple_mantle_victim_rig_cleanup");
	self endon("grapple_mantle_victim_rig_cleanup");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 64
grapple_mantle_victim_ignore_thread(param_00)
{
	grapple_ai_prep_for_kill(0);
	param_00 waittill("grapple_abort");
	if(isdefined(self))
	{
		maps\_utility::ai_unignore_everything();
		self notify("grapple_mantle_victim");
	}
}

//Function Number: 65
grapple_trace_parms()
{
	var_00 = [];
	var_00["dist"] = self.grapple["dist_max"];
	var_00["angles"] = self getplayerangles();
	var_00["start"] = self geteye();
	if(self.grapple["magnet_current"].valid)
	{
		var_01 = self.grapple["magnet_current"].origin;
		var_00["angles"] = vectortoangles(var_01 - self geteye());
	}
	else if(self.grapple["quick_fire_up"] && isdefined(self.grapple["quick_fire_trace"]) && self.grapple["quick_fire_trace"]["fraction"] < 1)
	{
		var_01 = self.grapple["quick_fire_trace"]["position"];
		if(isdefined(self.grapple["quick_fire_trace"]["entity"]))
		{
			var_02 = self.grapple["quick_fire_trace"]["entity"];
			var_01 = self.grapple["quick_fire_trace"]["local_position"];
			var_01 = rotatevector(var_01,var_02.angles);
			var_01 = var_02.origin + var_01;
		}

		var_00["angles"] = vectortoangles(var_01 - self geteye());
	}

	var_00["forward"] = anglestoforward(var_00["angles"]);
	var_00["right"] = vectorcross(var_00["forward"],(0,0,1));
	var_00["end"] = var_00["start"] + var_00["forward"] * var_00["dist"];
	return var_00;
}

//Function Number: 66
grapple_magnets_dynamic(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = self.grapple["magnet_test"];
	var_07 = [];
	foreach(var_09 in level.grapple_magnets)
	{
		if(!isdefined(var_09))
		{
			var_05 = 1;
			continue;
		}

		if(!isdefined(var_09.object))
		{
			var_05 = 1;
			continue;
		}

		var_0A = grapple_magnet_origin(var_09);
		if(!grapple_valid_magnet_angle(var_06,var_09,var_0A,param_00))
		{
			continue;
		}

		if(isdefined(var_09.next))
		{
			if(!getdvarint("grapple_magnet_lines"))
			{
				continue;
			}

			var_0B = grapple_magnet_origin(var_09.next);
			var_0C = (param_00[0],param_00[1],var_0A[2]);
			var_0D = param_00 + param_01 * param_02;
			var_0D = (var_0D[0],var_0D[1],var_0A[2]);
			var_0E = 0;
			var_0F = distance(var_0A,var_0B);
			if(var_0F > 0)
			{
				var_0E = min(0.5,16 / var_0F);
			}

			var_10 = closestpointstwosegs(var_0A,var_0B,var_0C,var_0D);
			var_0A = vectorlerp(var_0A,var_0B,clamp(var_10[0],var_0E,1 - var_0E));
		}

		var_11 = param_03;
		var_12 = 0;
		if(var_09.is_ai)
		{
			var_13 = "";
			if(isdefined(var_09.specialstruct) && isdefined(var_09.specialstruct.type))
			{
				var_13 = var_09.specialstruct.type;
			}

			if(!issubstr(var_13,"callback") && !isdefined(grapple_death_style(var_09.object)))
			{
				var_11 = 2;
			}
			else if(self islookingat(var_09.object))
			{
				var_12 = 1;
			}
			else
			{
				var_14 = 300;
				var_15 = clamp(distance(var_0A,param_00),0,var_14);
				var_16 = var_15 / var_14;
				if(isdefined(self.grapple["magnet_current"].magnet) && self.grapple["magnet_current"].magnet == var_09)
				{
					var_16 = 0;
				}

				var_11 = param_03 + param_04 - param_03 * var_16;
			}
		}

		var_17 = grapple_magnet_state(var_06,var_0A,param_00,param_01,param_02,var_11);
		if(var_17 || var_12 && var_06.dot >= 0)
		{
			if(var_12)
			{
				var_06.dot = 1;
				var_06.possible = 1;
			}

			var_09.grapple_origin = var_0A;
			var_07[var_07.size] = var_09;
		}
	}

	if(var_05)
	{
		var_19 = [];
		foreach(var_09 in level.grapple_magnets)
		{
			if(isdefined(var_09) && isdefined(var_09.object))
			{
				var_19[var_19.size] = var_09;
			}
		}

		level.grapple_magnets = var_19;
	}

	return var_07;
}

//Function Number: 67
grapple_validate_magnets(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 grapple_magnet_validate_current(param_00);
	}
}

//Function Number: 68
grapple_magnet_validate_current(param_00)
{
	var_01 = self.grapple["magnet_current"];
	if(isdefined(var_01))
	{
		var_02 = 0;
		if(isdefined(var_01.magnet) && !isdefined(var_01.magnet.object))
		{
			var_02 = 1;
		}

		if(isdefined(param_00) && isdefined(var_01.magnet) && param_00 == var_01.magnet)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			if(var_01.valid)
			{
				grapple_update_preview(0,0);
			}

			var_01.magnet = undefined;
			var_01.origin = undefined;
			var_01.valid = 0;
			return;
		}

		if(!isdefined(param_00))
		{
			var_03 = self geteye();
			var_04 = anglestoforward(self getplayerangles());
			var_05 = self.grapple["dist_max"];
			var_06 = getdvarfloat("grapple_magnet_fov");
			var_07 = cos(var_06 * 0.5);
			if(isdefined(var_01.magnet))
			{
				var_01.origin = grapple_magnet_origin(var_01.magnet);
			}

			grapple_magnet_state(var_01,var_01.origin,var_03,var_04,var_05,var_07);
			if(var_01.possible)
			{
				grapple_magnet_trace_validate(var_01,var_01.origin,var_03,var_04);
				return;
			}
		}
	}
}

//Function Number: 69
grapple_magnet_update()
{
	self.grapple["ai_targeted"] = undefined;
	if(self.grapple["magnet_current"].valid && isdefined(self.grapple["magnet_current"].magnet) && isai(self.grapple["magnet_current"].magnet.object))
	{
		self.grapple["ai_targeted"] = self.grapple["magnet_current"].magnet.object;
	}

	self.grapple["magnet_current"].valid = 0;
	if(!getdvarint("grapple_magnet_enabled"))
	{
		return;
	}

	var_00 = self geteye();
	var_01 = anglestoforward(self getplayerangles());
	var_02 = self.grapple["dist_max"];
	var_03 = getdvarfloat("grapple_magnet_fov");
	var_04 = cos(var_03 * 0.5);
	var_05 = getdvarfloat("grapple_magnet_fov_ai");
	var_06 = cos(var_05 * 0.5);
	var_07 = undefined;
	var_08 = grapple_magnets_dynamic(var_00,var_01,var_02,var_04,var_06);
	foreach(var_0A in var_08)
	{
		var_07 = grapple_magnet_evaluate(var_0A,var_0A.grapple_origin,var_00,var_01,var_07);
	}

	var_0C = grapplegetmagnets(var_00,var_01,var_02,var_03);
	foreach(var_0E in var_0C)
	{
		var_07 = grapple_magnet_evaluate(undefined,var_0E,var_00,var_01,var_07);
	}
}

//Function Number: 70
grapple_magnet_evaluate(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.grapple["magnet_current"];
	var_06 = self.grapple["magnet_test"];
	var_06.magnet = param_00;
	grapple_magnet_state_basics(var_06,param_01,param_02,param_03);
	var_07 = !var_05.valid;
	var_08 = var_05.dot;
	var_09 = var_06.dot;
	if(!var_07 && isdefined(var_06.magnet) && isai(var_06.magnet.object) && self islookingat(var_06.magnet.object))
	{
		var_07 = 1;
		param_04 = var_06.magnet.object;
	}

	if(isdefined(self.grapple["ai_targeted"]) && self.grapple["ai_targeted"] grapple_ai_alive())
	{
		if(isdefined(var_06.magnet) && isai(var_06.magnet.object) && var_06.magnet.object == self.grapple["ai_targeted"])
		{
			var_09 = clamp(var_09 + getdvarfloat("grapple_ai_priority"),0,max(var_09,0.9999));
		}
		else if(!isdefined(var_06.magnet) || !isai(var_06.magnet.object))
		{
			var_09 = var_09 - getdvarfloat("grapple_ai_priority");
		}
	}

	if(!grapple_magnet_validate_ground(param_00))
	{
		var_09 = -1;
		var_07 = 0;
	}

	if(!var_07 && var_09 > var_08 && !isdefined(param_04) || isdefined(var_06.magnet) && isdefined(var_06.magnet.object) && var_06.magnet.object == param_04)
	{
		var_07 = 1;
	}

	if(var_07)
	{
		if(grapple_magnet_trace_validate(var_06,param_01,param_02,param_03) || !self.grapple["magnet_current"].valid)
		{
			self.grapple["surface_trace"] = var_06.tracevalidation["surface_trace"];
			var_0A = var_05;
			self.grapple["magnet_current"] = var_06;
			self.grapple["magnet_test"] = var_0A;
		}
	}

	return param_04;
}

//Function Number: 71
grapple_magnet_origin(param_00)
{
	if(isdefined(param_00.static_origin))
	{
		return param_00.static_origin;
	}

	var_01 = param_00.object.origin;
	if(param_00.tag != "")
	{
		var_01 = param_00.object gettagorigin(param_00.tag);
	}

	if(isdefined(param_00.tag_offset) && lengthsquared(param_00.tag_offset) > 0)
	{
		if(param_00.tag != "")
		{
			var_02 = rotatevector(param_00.tag_offset,param_00.object gettagangles(param_00.tag));
		}
		else if(isdefined(var_01.object.angles))
		{
			var_02 = rotatevector(var_01.tag_offset,var_01.object.angles);
		}
		else
		{
			var_02 = var_01.tag_offset;
		}

		var_01 = var_01 + var_02;
	}

	return var_01;
}

//Function Number: 72
grapple_magnet_state_basics(param_00,param_01,param_02,param_03)
{
	param_00.origin = param_01;
	if(isdefined(param_00.origin))
	{
		var_04 = param_00.origin - param_02;
		param_00.dot = vectordot(vectornormalize(var_04),param_03);
		if(isdefined(level.grapple_void_points) && level.grapple_void_points.size > 0)
		{
			var_05 = gettime();
			var_06 = 0;
			foreach(var_08 in level.grapple_void_points)
			{
				if(var_08.endtime > var_05)
				{
					var_06 = 1;
					if(distancesquared(param_00.origin,var_08.origin) <= var_08.radiussq)
					{
						param_00.dot = -1;
						break;
					}
				}
			}

			if(!var_06)
			{
				level.grapple_void_points = [];
				return;
			}

			return;
		}

		return;
	}

	var_05.dot = -1;
}

//Function Number: 73
grapple_magnet_state(param_00,param_01,param_02,param_03,param_04,param_05)
{
	grapple_magnet_state_basics(param_00,param_01,param_02,param_03);
	param_00.valid = 0;
	param_00.possible = 0;
	param_00.tracevalidation = [];
	param_00.tracevalidation["reason"] = "";
	if(!grapple_valid_magnet_angle(param_00,param_00.magnet,param_00.origin,param_02))
	{
		return param_00.possible;
	}

	if(isdefined(param_00.origin))
	{
		var_06 = param_00.origin - param_02;
		if(lengthsquared(var_06) <= param_04 * param_04)
		{
			if(param_00.dot >= param_05)
			{
				param_00.possible = 1;
			}
		}
	}

	if(!param_00.possible)
	{
		param_00.dot = -1;
	}

	return param_00.possible;
}

//Function Number: 74
grapple_valid_magnet_angle(param_00,param_01,param_02,param_03)
{
	param_00.anglevalid = 1;
	if(!isdefined(param_01))
	{
		return 1;
	}

	if(isdefined(param_01.specialstruct) && isdefined(param_01.tag) && isdefined(param_01.specialstruct.dotlimitmin) || isdefined(param_01.specialstruct.dotlimitmax))
	{
		if(!isdefined(param_02) || !isdefined(param_01.object))
		{
			return 0;
		}

		var_04 = (1,0,0);
		if(isdefined(param_01.specialstruct.dotlimittagfwd))
		{
			var_04 = param_01.specialstruct.dotlimittagfwd;
		}

		var_05 = rotatevector(var_04,param_01.object gettagangles(param_01.tag));
		var_06 = vectornormalize(param_02 - param_03);
		var_07 = vectordot(var_06,var_05);
		if(isdefined(param_01.specialstruct.dotlimitmin) && var_07 < param_01.specialstruct.dotlimitmin)
		{
			param_00.anglevalid = 0;
			return 0;
		}

		if(isdefined(param_01.specialstruct.dotlimitmax) && var_07 > param_01.specialstruct.dotlimitmax)
		{
			param_00.anglevalid = 0;
			return 0;
		}
	}

	return 1;
}

//Function Number: 75
grapple_magnet_trace_validate(param_00,param_01,param_02,param_03)
{
	param_00.valid = 0;
	var_04 = 2;
	var_05 = var_04 * 2 * var_04 * 2;
	var_06 = param_02;
	var_07 = param_01;
	var_08 = vectornormalize(var_07 - var_06);
	var_07 = var_07 + var_08 * var_04;
	if(isdefined(param_00.magnet) && isai(param_00.magnet.object))
	{
		if(!isdefined(grapple_entity_style(param_00.magnet.object,param_00.magnet)))
		{
			param_00.valid = 0;
			return param_00.valid;
		}
	}

	if(isdefined(param_00.magnet) && isdefined(param_00.magnet.specialstruct) && isdefined(param_00.magnet.specialstruct.ignorecollision) && param_00.magnet.specialstruct.ignorecollision)
	{
		var_09 = [];
		var_09["fraction"] = 0.99999;
		var_09["position"] = param_01;
		var_09["normal"] = var_08 * -1;
		var_09["entity"] = param_00.magnet.object;
		var_09["valid"] = 1;
	}
	else
	{
		var_0A = 0;
		if(isdefined(param_00.magnet) && isdefined(param_00.magnet.object) && param_00.magnet.tag != "")
		{
			var_0A = 1;
		}

		var_09 = grappletrace(var_06,var_07,self,0,var_0A);
	}

	if(var_09["fraction"] < 1)
	{
		if(isdefined(var_09["entity"]) && isdefined(var_09["entity"].grapple_magnets))
		{
			if(isdefined(param_00.magnet) && isdefined(param_00.magnet.object) && param_00.magnet.object != var_09["entity"])
			{
				return param_00.valid;
			}
		}

		if(isai(var_09["entity"]) || distancesquared(var_09["position"],var_07) <= var_05)
		{
			param_00.tracevalidation = grapple_trace_validate(var_09,distance(var_06,var_07),var_08,vectortoangles(var_08),param_00);
			param_00.valid = param_00.tracevalidation["allowed"];
			if(param_00.valid)
			{
				param_00.tracevalidation["surface_trace"]["valid"] = 1;
			}
		}
		else
		{
		}
	}
	else
	{
	}

	return param_00.valid;
}

//Function Number: 76
grapple_check_footing(param_00)
{
	var_01 = param_00["surface_trace"]["entity"];
	if(isdefined(var_01) && isdefined(var_01.grapple_magnets) && var_01.grapple_magnets.size > 0 && !isdefined(param_00["land_magnet"]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 77
grapple_check_surface_type(param_00,param_01)
{
	if(param_00["fraction"] >= 1)
	{
		return 0;
	}

	if(!isdefined(param_00["valid"]) || param_00["valid"] == 0)
	{
		return 0;
	}

	if(isdefined(param_00["entity"]) && isai(param_00["entity"]))
	{
		if(isdefined(param_01) && isdefined(param_01.magnet) && isdefined(param_01.magnet.specialstruct) && issubstr(param_01.magnet.specialstruct.type,"callback"))
		{
			return 1;
		}

		if(isdefined(param_01) && isdefined(param_01.magnet) && isai(param_01.magnet.object) && param_01.magnet.object == param_00["entity"])
		{
			return 1;
		}

		return 0;
	}

	if(isdefined(param_00["entity"]) && common_scripts\utility::string_find(param_00["entity"].classname,"drone") != -1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 78
grapple_break_glass()
{
	var_00 = grapple_trace_parms();
	grappletrace(var_00["start"],var_00["end"],self,1);
}

//Function Number: 79
grapple_death_listener()
{
	self notify("grapple_death_listener");
	self endon("grapple_death_listener");
	self endon("grapple_shutdown_player");
	self waittill("death");
	if(isdefined(self.grapple))
	{
		if(isdefined(self.grapple["model_hands"]))
		{
			self.grapple["model_hands"] hide();
		}

		if(isdefined(self.grapple["model_body"]))
		{
			self.grapple["model_body"] hide();
		}
	}
}

//Function Number: 80
grapple_projectile_listener()
{
	self endon("grapple_shutdown_player");
	for(;;)
	{
		self waittill("missile_fire",var_00);
		if(self getcurrentweapon() == self.grapple["weapon"])
		{
			var_00 delete();
		}
	}
}

//Function Number: 81
grapple_start_listener()
{
	self endon("grapple_shutdown_player");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("grapple_quick");
		if(!isdefined(var_00))
		{
			continue;
		}

		grapple_start(var_00);
	}
}

//Function Number: 82
grapple_notify_magnet()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet))
	{
		if(isdefined(var_00.land_magnet.notifyname) && var_00.land_magnet.notifyname != "")
		{
			var_01 = var_00.land_magnet.object;
			if(isdefined(var_00.land_entity))
			{
				var_00.land_entity notify(var_00.land_magnet.notifyname,self);
			}

			self notify(var_00.land_magnet.notifyname,var_00.land_entity,var_01);
		}
	}
}

//Function Number: 83
grapple_start(param_00)
{
	self.grapple["landing_view_anim"] = undefined;
	self.grapple["no_enable_weapon"] = 0;
	self.grapple["no_disable_invulnerability"] = 0;
	self.grapple["start_stance"] = self getstance();
	var_01 = self.grapple["model_player_to"];
	if(!grapple_enabled() || self.grapple["ready_time"] > gettime() || !isdefined(self.grapple["surface_trace"]) || !grapple_magnet_validate_ground(var_01.land_magnet))
	{
		if(param_00 == "grapple_quick")
		{
			grapple_quick_fire_switch_back(0);
		}

		return;
	}

	self notify("grapple_started",var_01.land_magnet);
	if(grapple_special() == "callback")
	{
		[[ var_01.land_magnet.specialstruct.callback ]](self,var_01.land_entity,var_01.land_magnet);
		thread grapple_enabled_listener();
		return;
	}

	self.grapple["grappled_count"]++;
	var_02 = grapple_entity_style(self.grapple["surface_trace"]["entity"],self.grapple["magnet_current"].magnet);
	if(!isdefined(var_02) && isai(self.grapple["surface_trace"]["entity"]))
	{
		self.grapple["allowed"] = 0;
	}

	if(self.grapple["allowed"])
	{
		thread grapple_break_glass();
	}

	self enableinvulnerability();
	if(self.grapple["allowed"] && isdefined(var_02))
	{
		if(param_00 == "grapple_quick")
		{
			self.grapple["quick_fire_executed"] = 1;
		}

		grapple_entity(self.grapple["surface_trace"]["entity"]);
		if(param_00 == "grapple_quick")
		{
			grapple_quick_fire_switch_back(0);
		}

		if(!self.grapple["no_disable_invulnerability"])
		{
			self disableinvulnerability();
		}

		return;
	}
	else if(!self.grapple["allowed"])
	{
		thread grapple_status_text_show(1000,"reason",0,90);
		if(param_00 == "grapple_quick")
		{
			grapple_quick_fire_switch_back(0);
		}

		thread grapple_enabled_listener();
		if(!self.grapple["no_disable_invulnerability"])
		{
			self disableinvulnerability();
		}

		return;
	}

	if(param_00 == "grapple_quick")
	{
		self.grapple["quick_fire_executed"] = 1;
	}

	grapple_set_hint("");
	grapple_set_status("");
	self.grapple["allowed"] = 0;
	self.grapple["connected"] = 0;
	grapple_enable_normal_mantle_hint(0);
	var_03 = self.grapple["model_attach_world"];
	var_03 unlink();
	if(isdefined(self.grapple["mantle"]))
	{
		if(isdefined(self.grapple["mantle"]["victim"]))
		{
			self.grapple["mantle"]["victim"] thread grapple_mantle_victim(self.grapple["mantle"],self);
		}
	}

	self.grapple["no_enable_weapon"] = grapple_special_no_enable_weapon();
	if(grapple_special_no_enable_exo())
	{
		self.grapple["no_enable_exo"] = grapple_special_no_enable_exo();
	}

	var_04 = grapple_to_position(var_01);
	if(isdefined(var_04) && var_04)
	{
		self.grapple["connected"] = 1;
		thread grapple_sync_attach_rotation();
		if(isdefined(var_01.land_entity))
		{
			var_05 = self.grapple["model_player_move_tag"];
			var_06 = self.grapple["model_player_from"];
			var_05 unlink();
			var_05.origin = self.origin;
			var_05.angles = (0,self.angles[1],0);
			var_05 linkto(var_06);
		}
	}

	self notify("grapple_finished",var_01.land_entity);
	if(!self.grapple["aborted"])
	{
		grapple_notify_magnet();
	}

	wait(0.25);
	grapple_enable_weapon();
	if(isdefined(self.grapple["quick_fire_executed"]) && self.grapple["quick_fire_executed"])
	{
		if(self isreloading() || self ismantling())
		{
			grapple_quick_fire_switch_back(1);
		}
		else
		{
			grapple_quick_fire_switch_back(0);
		}
	}
	else if(!isdefined(self.grapple["mantle"]))
	{
		self forceviewmodelanimation(self getcurrentweapon(),"raise");
	}

	wait(0.25);
	grapple_set_grappling(0);
	grapple_enable_normal_mantle_hint(1);
	if(!self.grapple["connected"])
	{
		grapple_rope_state(0);
	}

	thread grapple_enabled_listener();
	if(!self.grapple["no_disable_invulnerability"])
	{
		self disableinvulnerability();
	}
}

//Function Number: 84
grapple_death_style(param_00)
{
	var_01 = self geteye();
	var_02 = clamp(var_01[2],param_00.origin[2] + 30,param_00 geteye()[2]);
	var_03 = (param_00.origin[0],param_00.origin[1],var_02);
	var_04 = vectornormalize(var_03 - var_01);
	var_05 = undefined;
	if(isdefined(param_00.grapple_death_styles))
	{
		foreach(var_07 in param_00.grapple_death_styles)
		{
			var_08 = rotatevector(var_07.normal,param_00.angles);
			var_09 = vectordot(var_04,var_08);
			if(var_09 >= var_07.dot)
			{
				if(!isdefined(var_07.validator) || self [[ var_07.validator ]](param_00))
				{
					return var_07;
				}
			}
		}
	}

	return var_05;
}

//Function Number: 85
grapple_ai_death_play(param_00,param_01)
{
	var_02 = param_00 grapple_death_style(param_01);
	if(isdefined(var_02) && isdefined(var_02.handler))
	{
		if(!isdefined(param_01.animname))
		{
			param_01.animname = "generic";
		}

		if(isdefined(var_02.handler_parm3))
		{
			param_00 [[ var_02.handler ]](var_02,param_00,param_01,var_02.handler_parm1,var_02.handler_parm2,var_02.handler_parm3);
			return;
		}

		if(isdefined(var_02.handler_parm2))
		{
			param_00 [[ var_02.handler ]](var_02,param_00,param_01,var_02.handler_parm1,var_02.handler_parm2);
			return;
		}

		if(isdefined(var_02.handler_parm1))
		{
			param_00 [[ var_02.handler ]](var_02,param_00,param_01,var_02.handler_parm1);
			return;
		}

		param_00 [[ var_02.handler ]](var_02,param_00,param_01);
		return;
	}
}

//Function Number: 86
grapple_ai_alive()
{
	return isalive(self) && !maps\_utility::doinglongdeath();
}

//Function Number: 87
grapple_kill(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!param_00 grapple_ai_alive())
	{
		return;
	}

	maps\_upgrade_challenge::give_player_challenge_kill(1);
	param_00 unlink();
	param_00 notify("tagged_death");
	while(isdefined(param_00.grapple_magnets) && param_00.grapple_magnets.size > 0)
	{
		grapple_magnet_unregister(param_00,param_00.grapple_magnets[0].tag);
	}

	param_00.diequietly = 1;
	param_00.allowdeath = 1;
	if(!param_01)
	{
		param_00.a.nodeath = 1;
	}

	if(isdefined(self.ent_flag["_stealth_in_shadow"]) && self.ent_flag["_stealth_in_shadow"])
	{
		param_00.target = "ignore_corpse";
	}

	param_00.dodamagetoall = 1;
	if(!param_01 && !isdefined(param_00.grapple_ragdolled))
	{
		param_00 startragdoll();
		param_00.grapple_ragdolled = 1;
	}

	grapple_kills_increment();
	param_00 kill(param_00.origin,param_00,param_00);
}

//Function Number: 88
grapple_kills_increment()
{
	if(!isdefined(level.grapple_kill_count))
	{
		level.grapple_kill_count = 0;
	}

	level.grapple_kill_count = level.grapple_kill_count + 1;
	if(getdvar("mapname") == "irons_estate" && level.grapple_kill_count >= 20)
	{
		maps\_utility::player_giveachievement_wrapper("LEVEL_8A");
	}
}

//Function Number: 89
grapple_death_valid_standard(param_00)
{
	if(!isplayer(self))
	{
		return 0;
	}

	if(!self isonground() && !self islinked())
	{
		return 0;
	}

	return 1;
}

//Function Number: 90
grapple_death_handler_standard(param_00,param_01,param_02)
{
	grapple_fire_rope("grapple_death");
	param_02 grapple_ai_prep_for_kill();
	param_02 soundscripts\_snd_playsound::snd_play_linked(common_scripts\utility::random(level.grapple_snd_pain));
	grapple_notify_closest_ai("witness_kill",param_02 geteye(),300,1);
	var_03 = anglestoforward(param_01 getplayerangles());
	var_04 = (param_00.normal[0],param_00.normal[1],0);
	if(length2dsquared(var_04) > 0)
	{
		var_05 = (var_03[0],var_03[1],0);
		var_06 = vectortoangles(rotatevectorinverted(var_05,vectortoangles(var_04)));
		param_02 forceteleport(param_02.origin,var_06);
	}

	param_02 maps\_utility::set_deathanim(param_00.name);
	param_01 grapple_kill(param_02,1);
	param_01 waittill("grapple_fire_rope_finished");
	if(common_scripts\utility::issp())
	{
		soundscripts\_snd_playsound::snd_play_2d(common_scripts\utility::random(level.grapple_snd_death));
	}
	else
	{
		param_02 soundscripts\_snd_playsound::snd_play_linked(common_scripts\utility::random(level.grapple_snd_death));
	}

	param_01 thread maps\_utility::play_sound_on_entity("rappel_clipout");
	param_01 playrumbleonentity("heavygun_fire");
	param_01 screenshakeonentity(5,5,3,0.5,0,0.25,128,3,3,3,1);
}

//Function Number: 91
grapple_death_valid_pull_concealed_obs(param_00)
{
	if(!self.grapple["kill_obstructed_clear"])
	{
		return 0;
	}

	return grapple_death_valid_pull_concealed(param_00);
}

//Function Number: 92
grapple_death_valid_pull_concealed(param_00)
{
	if(!grapple_death_valid_pull(param_00))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,param_00.origin);
	var_02 = getdvarfloat("grapple_concealed_kill_range");
	if(var_01 > var_02 * var_02)
	{
		return 0;
	}

	var_03 = getdvarfloat("grapple_concealed_kill_range_min");
	if(var_01 < var_03 * var_03)
	{
		return 0;
	}

	if(abs(self.origin[2] - param_00.origin[2]) > getdvarfloat("grapple_concealed_kill_range_z"))
	{
		return 0;
	}

	if(getdvarint("grapple_concealed_kill") == 1 && (!isdefined(self.ent_flag["_stealth_in_shadow"]) || !self.ent_flag["_stealth_in_shadow"]) && !self.grapple["concealed"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 93
grapple_death_valid_pull_obs(param_00)
{
	if(!self.grapple["kill_obstructed_clear"])
	{
		return 0;
	}

	return grapple_death_valid_pull(param_00);
}

//Function Number: 94
grapple_can_stand()
{
	if(!isdefined(self.grapple["last_stand_check"]) || gettime() - self.grapple["last_stand_check"] >= 50)
	{
		self.grapple["can_stand"] = distancesquared(playerphysicstrace(self.origin + (0,0,1),self.origin),self.origin) < 0.0001;
		self.grapple["last_stand_check"] = gettime();
	}

	return self.grapple["can_stand"];
}

//Function Number: 95
grapple_death_valid_pull(param_00)
{
	if(getdvarint("grapple_concealed_kill") == 0)
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,param_00.origin);
	var_02 = getdvarfloat("grapple_concealed_kill_range_min");
	if(var_01 < var_02 * var_02)
	{
		return 0;
	}

	if(!isplayer(self))
	{
		return 0;
	}

	if(self islinked())
	{
		return 0;
	}

	if(!self isonground())
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(var_01 > self.grapple["dist_max_kill"] * self.grapple["dist_max_kill"])
	{
		return 0;
	}

	if(!grapple_can_stand())
	{
		return 0;
	}

	return 1;
}

//Function Number: 96
grapple_ai_prep_for_kill(param_00)
{
	if(!isdefined(param_00) || param_00)
	{
		animscripts\shared::dropallaiweapons();
	}

	self notify("death");
	maps\_utility::ai_ignore_everything();
	maps\_utility::anim_stopanimscripted();
	self notify("stop_animmode");
	self notify("stop_sound");
	self stopsounds();
}

//Function Number: 97
grapple_death_pull(param_00,param_01,param_02,param_03,param_04)
{
	param_01.grapple["grappling"] = 1;
	var_05 = param_01.grapple["model_rope_fire"];
	var_06 = param_01.grapple["model_rope_idle"];
	var_07 = param_01.grapple["model_ai_link"];
	param_02 grapple_ai_prep_for_kill();
	param_01 grapple_stand_and_lock_stances();
	param_01 grapple_fire_rope("grapple_pull_death_start" + param_03);
	param_01 childthread grapple_death_pull_rope_state();
	param_02 soundscripts\_snd_playsound::snd_play_linked("grapple_kill_cloth");
	param_01 soundscripts\_snd_playsound::snd_play_2d("grapple_kill_pull","stop_grapple_kill_pull_sound",undefined,0.5);
	param_01 soundscripts\_snd_playsound::snd_play_2d("grapple_kill_pull_lyr2","stop_grapple_kill_pull_sound",undefined,0.1);
	param_02 soundscripts\_snd_playsound::snd_play_linked(common_scripts\utility::random(level.grapple_snd_pain));
	if(isdefined(level._stealth))
	{
		param_01 grapple_notify_closest_ai("witness_kill",param_02 geteye(),300,1);
		param_01 grapple_notify_ai_capsule("gunshot_teammate",level.player geteye(),param_02 geteye(),100,1);
	}

	param_02 notify("tagged_death");
	if(isdefined(param_04) && param_04 != "")
	{
		var_08 = anglestoforward(param_01 getplayerangles());
		var_09 = (param_00.normal[0],param_00.normal[1],0);
		if(length2dsquared(var_09) > 0)
		{
			var_0A = (var_08[0],var_08[1],0);
			var_0B = vectortoangles(rotatevectorinverted(var_0A,vectortoangles(var_09)));
			param_02 forceteleport(param_02.origin,var_0B);
		}

		param_02 thread maps\_anim::anim_single_solo(param_02,param_04);
	}
	else
	{
		param_04 = "grapple_pull_death_start" + param_03;
		param_02 thread maps\_anim::anim_single_solo(param_02,param_04);
	}

	param_01 childthread grapple_view_model_hands_hide_show("grapple_fire_rope_finished");
	param_02 thread _waittillmatch_notify("single anim","pull","pull");
	var_0C = param_02 common_scripts\utility::waittill_any_timeout(getanimlength(level.scr_anim["generic"][param_04]),"pull");
	param_01 grapple_rope_state(1);
	param_02 soundscripts\_snd_playsound::snd_play_linked("ie_as1_quietyank1");
	param_01 playrumbleonentity("heavygun_fire");
	param_01 screenshakeonentity(5,5,3,0.5,0,0.25,128,3,3,3,1);
	var_0D = self.grapple["model_body"];
	var_0D unlink();
	var_0D hide();
	var_0D.origin = param_01.origin;
	var_0D.angles = param_01.angles;
	var_0D dontinterpolate();
	var_0D.end_anim_name = "grapple_pull_death_end" + param_03;
	var_0E = common_scripts\utility::random(level.grapple_death_pull_suffixes);
	var_0D.end_anim_name = var_0D.end_anim_name + var_0E;
	var_0D maps\_anim::anim_first_frame_solo(var_0D,var_0D.end_anim_name);
	var_0F = getstartorigin(level.player.origin,level.player.angles,level.scr_anim["generic"][var_0D.end_anim_name]);
	var_10 = getstartangles(level.player.origin,level.player.angles,level.scr_anim["generic"][var_0D.end_anim_name]);
	param_02.loopanims = [];
	param_02.loops = 0;
	param_02 thread maps\_anim::anim_loop_solo(param_02,"grapple_pull_death_loop" + param_03);
	var_07 unlink();
	var_07.origin = param_02 gettagorigin("tag_origin");
	var_07.angles = param_02 gettagangles("tag_origin");
	param_02 linkto(var_07);
	var_11 = getdvarfloat("grapple_pull_speed");
	var_12 = distance(var_0F,param_02.origin);
	var_13 = var_12 / var_11;
	param_01 playrumblelooponentity("subtle_tank_rumble");
	if(var_13 >= 0.1)
	{
		param_01 screenshakeonentity(2,2,1,var_13,0,min(var_13 - 0.05,0.25),128,3,3,3,1);
	}

	var_07 childthread grapple_rope_pull_lerp(var_0F,var_13);
	var_14 = min(0.1,var_13);
	var_07 rotateto(var_10,var_14,min(var_14,0.05),0);
	var_15 = 0.2;
	var_16 = var_13 - var_15;
	if(var_16 > 0)
	{
		wait(var_16);
	}
	else
	{
		var_15 = max(0,var_15 + var_16);
	}

	param_01 notify("grapple_loop_viewmodel_anim");
	param_01 thread maps\_utility::play_sound_on_entity("rappel_clipout");
	param_01 grapple_switch(0,1);
	param_01 screenshakeonentity(5,5,3,0.5,0,0.25,128,3,3,3,1);
	param_01 playerlinktoblend(var_0D,"tag_player",var_15);
	if(var_15 > 0)
	{
		wait(var_15);
	}

	param_01 stoprumble("subtle_tank_rumble");
	param_01 playrumbleonentity("heavygun_fire");
	param_02 unlink();
	var_0D show();
	var_17 = [param_02,var_0D];
	var_18 = undefined;
	if(isdefined(level.scr_anim["grapple_rope"][var_0D.end_anim_name]))
	{
		var_18 = maps\_utility::spawn_anim_model("grapple_rope");
		param_01.grapple["model_rope_fire"] hide();
		param_01.grapple["model_rope_idle"] hide();
		var_17[var_17.size] = var_18;
	}
	else
	{
		var_0D attach("vm_spydeco","tag_weapon_left");
		var_0D.knife_attached = 1;
	}

	param_02.a.nodeath = 1;
	param_02.allowdeath = 1;
	var_0D thread maps\_anim::anim_single(var_17,var_0D.end_anim_name);
	var_19 = getanimlength(level.scr_anim["generic"][var_0D.end_anim_name]);
	var_0D grapple_setup_death_event_handlers("single anim",param_01,param_02,var_19);
	var_0D waittillmatch("end","single anim");
	var_0D hide();
	if(isdefined(var_18))
	{
		var_18 delete();
	}

	param_01 unlink();
	param_01 grapple_unlock_stances();
	param_01 notify("grapple_death_pull_complete");
	param_01.grapple["grappling"] = 0;
}

//Function Number: 98
grapple_death_pull_rope_state()
{
	if(self.grapple["start_stance"] != "stand")
	{
		grapple_rope_state(1);
		return;
	}

	grapple_rope_state(1,undefined,1);
}

//Function Number: 99
grapple_rope_pull_lerp(param_00,param_01)
{
	var_02 = gettime();
	var_03 = self.origin;
	var_04 = 0;
	while(var_04 <= param_01)
	{
		var_04 = float(gettime() - var_02) / 1000;
		var_05 = clamp(var_04 / param_01,0,1);
		var_06 = clamp(var_05 * var_05 * 1.25,0,1);
		var_07 = clamp(var_05 * var_05 * 1,0,1);
		var_08 = vectorlerp(var_03,param_00,var_06);
		var_09 = vectorlerp(var_03,param_00,var_07);
		self.origin = (var_08[0],var_08[1],var_09[2]);
		wait(0.05);
	}
}

//Function Number: 100
grapple_setup_death_event_handlers(param_00,param_01,param_02,param_03)
{
	self notify("grapple_setup_death_event_handlers");
	self endon("grapple_setup_death_event_handlers");
	childthread grapple_death_pull_event(param_00,param_01,param_02,param_03,"grab");
	childthread grapple_death_pull_event(param_00,param_01,param_02,param_03,"impact");
	childthread grapple_death_pull_event(param_00,param_01,param_02,param_03,"weapon_up");
	childthread grapple_death_pull_event(param_00,param_01,param_02,param_03,"start_ragdoll");
	childthread grapple_death_pull_event(param_00,param_01,param_02,param_03,"end");
	childthread grapple_death_pull_event_sounds(param_00,"start_stab_neck_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_stab_neck_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"stab_neck_kill_sound","grapple_kill_stab_neck",0.35);
	childthread grapple_death_pull_event_sounds(param_00,"finish_stab_neck_sound");
	childthread grapple_death_pull_event_sounds(param_00,"start_stab_neck_above_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_stab_neck_above_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"stab_neck_above_kill_sound","grapple_kill_stab_neck",0.35);
	childthread grapple_death_pull_event_sounds(param_00,"finish_stab_neck_above_sound");
	childthread grapple_death_pull_event_sounds(param_00,"start_knife_chest_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_knife_chest_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"knife_chest_kill_sound","grapple_kill_knife_chest");
	childthread grapple_death_pull_event_sounds(param_00,"finish_knife_chest_sound","grapple_kill_body_drop",undefined,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"start_neck_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_neck_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"neck_kill_sound","grapple_kill_neck",0.1);
	childthread grapple_death_pull_event_sounds(param_00,"finish_neck_sound","grapple_kill_body_drop",1,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"start_above_knife_chest_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_above_knife_chest_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"above_knife_chest_kill_sound","grapple_kill_knife_chest");
	childthread grapple_death_pull_event_sounds(param_00,"finish_above_knife_chest_sound","grapple_kill_body_drop",0.5,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"start_above_neck_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_above_neck_pull_sound","grapple_kill_pull_end");
	childthread grapple_death_pull_event_sounds(param_00,"above_neck_kill_sound","grapple_kill_neck",0.1);
	childthread grapple_death_pull_event_sounds(param_00,"finish_above_neck_sound","grapple_kill_body_drop",1,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"start_choke_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_choke_pull_sound","grapple_kill_pull_end",0.05);
	childthread grapple_death_pull_event_sounds(param_00,"choke_kill_sound","grapple_kill_choke");
	childthread grapple_death_pull_event_sounds(param_00,"finish_choke_sound","grapple_kill_body_drop",0.1,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"start_above_choke_sound","grapple_kill_pull_whoosh");
	childthread grapple_death_pull_event_sounds(param_00,"end_above_choke_pull_sound","grapple_kill_pull_end",0.05);
	childthread grapple_death_pull_event_sounds(param_00,"above_choke_kill_sound","grapple_kill_choke");
	childthread grapple_death_pull_event_sounds(param_00,"finish_above_choke_sound","grapple_kill_body_drop",0.1,param_02);
	childthread grapple_death_pull_event_sounds(param_00,"grapple_kill_low_start","grapple_kill_low_start");
	childthread grapple_death_pull_event_sounds(param_00,"grapple_kill_low_end");
}

//Function Number: 101
grapple_death_pull_event(param_00,param_01,param_02,param_03,param_04)
{
	self notify("grapple_death_pull_event_" + param_04);
	self endon("grapple_death_pull_event_" + param_04);
	thread _waittillmatch_notify(param_00,param_04,param_04);
	var_05 = common_scripts\utility::waittill_any_timeout(param_03,param_04);
	param_01 notify("death_pull_event",param_04);
	var_06 = 0;
	if(isdefined(param_01.grapple["mantle"]) && isdefined(param_01.grapple["mantle"]["victim"]))
	{
		var_06 = 1;
	}

	switch(param_04)
	{
		case "grab":
			if(!isdefined(self.end_anim_name) || !isdefined(level.scr_anim["grapple_rope"][self.end_anim_name]))
			{
				param_01 grapple_rope_state(0);
			}
	
			param_01 playrumbleonentity("heavygun_fire");
			break;

		case "impact":
			param_01 playrumbleonentity("heavygun_fire");
			if(isdefined(param_02))
			{
				param_02 soundscripts\_snd_playsound::snd_play_linked(common_scripts\utility::random(level.grapple_snd_death));
			}
			break;

		case "weapon_up":
			param_01 grapple_enable_weapon();
			param_01 grapple_switch(0,1,0);
			if(isdefined(self.knife_attached))
			{
				self detach("vm_spydeco","tag_weapon_left");
			}
	
			self.knife_attached = undefined;
			break;

		case "start_ragdoll":
			if(isdefined(param_02))
			{
				param_02 unlink();
				if(!isdefined(param_02.grapple_ragdolled))
				{
					param_02 startragdoll();
					param_02.grapple_ragdolled = 1;
				}
	
				if(var_06)
				{
					param_01 grapple_kill(param_02,0);
				}
			}
			break;

		case "end":
			if(isdefined(param_02))
			{
				if(!var_06)
				{
					param_02 maps\_utility::anim_stopanimscripted();
					var_07 = self.origin + (0,0,30);
					var_08 = param_02 aiphysicstrace(var_07,var_07 + anglestoforward(self.angles) * -60);
					var_09 = param_02 aiphysicstrace(var_08,var_08 - (0,0,60));
					param_02 unlink();
					param_02 forceteleport((var_09[0],var_09[1],var_09[2] + 30),param_02.angles,1000);
				}
	
				param_01 grapple_kill(param_02,0);
			}
			break;
	}
}

//Function Number: 102
grapple_death_pull_event_sounds(param_00,param_01,param_02,param_03,param_04)
{
	self notify("grapple_death_pull_event_sounds" + param_01);
	self endon("grapple_death_pull_event_sounds" + param_01);
	self waittillmatch(param_01,param_00);
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	if(isdefined(param_02))
	{
		if(param_02 != "grapple_kill_body_drop")
		{
			soundscripts\_snd_playsound::snd_play_2d(param_02);
		}
		else
		{
			param_04 soundscripts\_snd_playsound::snd_play_linked(param_02);
		}

		if(param_02 == "grapple_kill_pull_whoosh")
		{
			soundscripts\_snd::snd_message("aud_grapple_kill_foliage");
			if(param_01 != "start_stab_neck_sound" && param_01 != "start_stab_neck_above_sound")
			{
				level notify("stop_grapple_kill_pull_sound");
				soundscripts\_snd::snd_message("aud_stealth_melee");
			}
		}

		if(param_01 == "finish_stab_neck_sound" || param_01 == "finish_stab_neck_sound")
		{
			soundscripts\_snd::snd_message("aud_stealth_melee");
		}
	}
}

//Function Number: 103
grapple_view_model_hands_hide_show(param_00)
{
	if(isdefined(param_00))
	{
		self waittill(param_00);
	}

	self hideviewmodel();
	for(;;)
	{
		if(self getcurrentweapon() != self.grapple["weapon"])
		{
			self showviewmodel();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 104
_waittillmatch_notify(param_00,param_01,param_02)
{
	self waittillmatch(param_01,param_00);
	self notify(param_02);
}

//Function Number: 105
grapple_loop_viewmodel_anim(param_00,param_01)
{
	self notify("grapple_loop_viewmodel_anim");
	self endon("grapple_loop_viewmodel_anim");
	self endon("death");
	for(;;)
	{
		self setviewmodelanim(level.scr_viewanim[param_01]);
		var_02 = 0;
		if(isarray(level.scr_anim[param_00][param_01]))
		{
			var_02 = getanimlength(level.scr_anim[param_00][param_01][0]) - 0.2;
		}
		else
		{
			var_02 = getanimlength(level.scr_anim[param_00][param_01]) - 0.2;
		}

		wait(var_02);
	}
}

//Function Number: 106
grapple_entity(param_00)
{
	self endon("grapple_abort");
	var_01 = grapple_entity_style(param_00,self.grapple["magnet_current"].magnet);
	if(isdefined(var_01))
	{
		self notify("grapple_started");
		self.grapple["allowed"] = 0;
		grapple_notify_magnet();
		grapple_set_hint("");
		grapple_set_status("");
		grapple_update_preview(0,0);
		if(isai(param_00))
		{
			grapple_attach_bolt(param_00,"J_SpineUpper");
		}
		else
		{
			grapple_attach_bolt(param_00,"tag_origin");
		}

		if(grapple_special() == "callback_fired")
		{
			grapple_fire_rope();
			self waittill("grapple_rope_impact");
			var_02 = self.grapple["model_player_to"];
			[[ var_02.land_magnet.specialstruct.callback ]](self,var_02.land_entity,var_02.land_magnet);
			thread grapple_enabled_listener();
			return;
		}

		switch(var_02)
		{
			case "kill":
				var_01.isbeinggrappled = 1;
				grapple_ai_death_play(self,var_01);
				break;
		}

		self.grapple["ready_time"] = max(gettime() + 600,self.grapple["ready_time"]);
		self notify("grapple_entity_finished");
		self freezecontrols(0);
		grapple_enable_weapon();
		grapple_rope_state(0);
		self.grapple["model_attach_world"] hide();
		if(isdefined(self.grapple["quick_fire_executed"]) && self.grapple["quick_fire_executed"])
		{
			grapple_quick_fire_switch_back(1);
		}
		else if(!isdefined(self.grapple["mantle"]))
		{
			self forceviewmodelanimation(self getcurrentweapon(),"raise");
		}

		thread grapple_enabled_listener();
	}
}

//Function Number: 107
grapple_entity_style(param_00,param_01)
{
	if(isdefined(param_00))
	{
		if(isai(param_00) && param_00 grapple_ai_alive())
		{
			if(isdefined(param_01) && isdefined(param_01.specialstruct) && issubstr(param_01.specialstruct.type,"callback"))
			{
				return "callback";
			}
			else if(param_00.team != self.team && isdefined(grapple_death_style(param_00)))
			{
				return "kill";
			}
		}
	}

	return undefined;
}

//Function Number: 108
grapple_take_weapon()
{
	self forceviewmodelanimationclear();
	self takeweapon(self.grapple["weapon"]);
}

//Function Number: 109
grapple_disconnect()
{
	self notify("grapple_disconnect");
	grapple_set_hint("");
	grapple_rope_state(0);
	thread maps\_utility::play_sound_on_entity("rappel_clipout");
	self stoprumble("subtle_tank_rumble");
	grapple_take_weapon();
	self freezecontrols(0);
	grapple_unlock_stances();
}

//Function Number: 110
grapple_sync_attach_rotation()
{
	self endon("death");
	self endon("grapple_shutdown_player");
	self endon("grapple_disconnect");
	self endon("grapple_started");
	self notify("grapple_sync_attach_rotation");
	self endon("grapple_sync_attach_rotation");
	var_00 = self.grapple["model_player_move_tag"];
	var_01 = self.grapple["model_player_from"];
	for(;;)
	{
		var_00 unlink();
		var_00.angles = (0,self.angles[1],0);
		var_00 linkto(var_01);
		wait(0.05);
	}
}

//Function Number: 111
grapple_get_style(param_00,param_01)
{
	var_02 = vectordot(param_01,(0,0,1));
	if(var_02 > cos(45))
	{
		return "floor";
	}

	if(var_02 < 0 - cos(45))
	{
		return "ceiling";
	}

	return "wall";
}

//Function Number: 112
grapple_wait_for_ads_timeout(param_00)
{
	var_01 = gettime();
	while(gettime() - var_01 < param_00 * 1000)
	{
		if(self adsbuttonpressed())
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 113
grapple_velocity_monitor()
{
	self notify("grapple_velocity_monitor");
	self endon("death");
	self endon("grapple_shutdown_player");
	self endon("grapple_velocity_monitor");
	var_00 = self.origin;
	for(;;)
	{
		wait(0.05);
		self.grapple["poll_velocity"] = self.origin - var_00 * 20;
		var_00 = self.origin;
	}
}

//Function Number: 114
grapple_abort_trace_passed(param_00)
{
	var_01 = self geteye();
	var_02 = param_00 + (0,0,var_01[2] - self.origin[2]);
	var_03 = vectornormalize(var_02 - var_01);
	var_01 = var_01 + var_03 * 30;
	var_02 = var_02 - var_03 * 30;
	var_04 = grappletrace(var_01,var_02,self,0);
	if(isdefined(var_04["fraction"]) && var_04["fraction"] < 1)
	{
		if(isai(var_04["entity"]) && var_04["entity"].team == self.team)
		{
			return 1;
		}

		return 0;
	}

	return 1;
}

//Function Number: 115
grapple_abort_monitor(param_00,param_01)
{
	self endon("grapple_shutdown_player");
	self notify("grapple_abort_monitor");
	self endon("grapple_abort_monitor");
	if(grapple_special_no_abort())
	{
		return;
	}

	var_02 = 0;
	var_03 = 0;
	self.grapple["abort_forced"] = 0;
	self.grapple["last_valid_origin"] = self.origin;
	while(isdefined(self.grapple) && self.grapple["grappling"])
	{
		wait(0.05);
		var_04 = (self.origin[0],self.origin[1],self.grapple["model_player_to"].origin[2]);
		if(distancesquared(playerphysicstrace(var_04,self.origin),self.origin) < 0.0001)
		{
			if(distancesquared(playerphysicstrace(self.origin + (0,0,1),self.origin),self.origin) < 0.0001)
			{
				self.grapple["last_valid_origin"] = self.origin;
			}
		}

		var_05 = 1;
		if(self.grapple["abort_forced"])
		{
			var_05 = 0;
		}
		else
		{
			var_05 = grapple_abort_trace_passed(param_01.origin);
		}

		if(!var_05)
		{
			var_03 = var_03 + 1;
		}

		if(!var_05 && var_02 || self.grapple["abort_forced"] || var_03 > 4)
		{
			grapple_abort(self.grapple["abort_forced"]);
		}

		if(var_05 && !var_02)
		{
			var_02 = 1;
		}
	}
}

//Function Number: 116
grapple_abort(param_00)
{
	grapple_set_grappling(0);
	self.grapple["aborted"] = 1;
	self.grapple["no_enable_exo"] = 0;
	self.grapple["no_enable_weapon"] = 0;
	self notify("grapple_abort");
	grapple_disconnect();
	killfxontag(level._effect["grapple_cam"],self.grapple["model_player_to"],"tag_origin");
	self unlink();
	grapple_enable_normal_mantle_hint(1);
	var_01 = self.grapple["poll_velocity"];
	self setorigin(self.grapple["last_valid_origin"]);
	self.origin = self.grapple["last_valid_origin"];
	self setvelocity(var_01);
	self screenshakeonentity(5,5,3,0.5,0,0.25,128,3,3,3,1);
	self playrumbleonentity("damage_light");
	self lerpfov(65,0.2);
	if(common_scripts\utility::issp())
	{
		level notify("stop_grapplesound");
	}
	else
	{
		self.grapple["model_player_move_tag"] stopsounds();
	}

	self disableinvulnerability();
}

//Function Number: 117
grapple_complete_player_move(param_00)
{
	var_01 = self.grapple["model_player_from"];
	var_02 = self.grapple["model_player_to"];
	var_01 unlink();
	var_01.origin = var_02.origin;
	var_01.angles = var_02.angles;
	var_01.style = var_02.style;
	var_01.land_entity = undefined;
	var_01.land_magnet = undefined;
	if(isdefined(var_02.land_entity))
	{
		var_01.land_entity = var_02.land_entity;
		if(isdefined(var_02.land_magnet) && var_02.land_magnet.tag != "")
		{
			var_01 linkto(var_02.land_entity,var_02.land_magnet.tag);
		}
		else
		{
			var_01 linkto(var_02.land_entity);
		}

		if(isdefined(var_02.land_magnet))
		{
			var_01.land_magnet = var_02.land_magnet;
		}
	}

	var_01 dontinterpolate();
	if(!isdefined(self.grapple["mantle"]) && !isdefined(grapple_special_landing_anims()))
	{
		self unlink();
		self setorigin(var_02.origin);
		self playerlinktodelta(var_02,"tag_origin",1,45,45,45,45,0);
	}

	grapple_enable_weapon();
	grapple_setup_rope_attached(param_00);
	self notify("grapple_complete_player_move");
}

//Function Number: 118
grapple_to_position(param_00)
{
	self endon("grapple_shutdown_player");
	self endon("grapple_abort");
	var_01 = 0;
	grapple_set_grappling(1);
	self.grapple["aborted"] = 0;
	var_02 = self.grapple["model_player_move_tag"];
	var_03 = self.grapple["model_player_from"];
	param_00 = self.grapple["model_player_to"];
	grapple_update_preview(0,0);
	grapple_attach_bolt(self.grapple["model_preview"]);
	thread grapple_velocity_monitor();
	if(grapple_special() == "weapon")
	{
		grapple_fire_rope("grapple_hip_fire",::grapple_fire_finished);
	}
	else
	{
		grapple_fire_rope(undefined,::grapple_fire_finished);
	}

	thread grapple_abort_monitor(var_02,param_00);
	grapple_stand_and_lock_stances();
	var_02 unlink();
	var_02.angles = self getplayerangles();
	var_02.origin = self geteye() - anglestoup(var_02.angles) * 60;
	var_02 dontinterpolate();
	self.grapple["landingParms"] = grapple_landing_prep();
	childthread grapple_lerp_velocity_to_linked(var_02);
	self playrumblelooponentity("subtle_tank_rumble");
	if(common_scripts\utility::issp())
	{
		soundscripts\_snd_playsound::snd_play_2d("linelauncher_move_player","stop_grapplesound",undefined,0.2);
		soundscripts\_snd_playsound::snd_play_2d("linelauncher_wind","stop_grapplesound",undefined,0.35);
		level notify("aud_grapple_start");
		soundscripts\_snd::snd_message("aud_grapple_from_foliage");
	}
	else
	{
		var_02 playsound("linelauncher_move_player");
	}

	var_04 = var_02 grapple_move(self,param_00);
	self stoprumble("subtle_tank_rumble");
	if(self.grapple["style"] == "ceiling")
	{
		var_01 = 1;
		wait(max(0.05,var_04));
		grapple_complete_player_move(1);
		grapple_rope_state(2);
		self playerlinktodelta(var_03,"tag_origin",1,180,180,180,180,0);
	}
	else if(self.grapple["style"] == "wall")
	{
		wait(max(0.05,var_04) + 0.1);
		grapple_complete_player_move(1);
		if(isdefined(self.grapple["mantle"]) || isdefined(grapple_special_landing_anims()))
		{
			self forceviewmodelanimationclear();
			grapple_disconnect();
			self unlink();
		}
		else
		{
			var_01 = 1;
			grapple_rope_state(2);
			self playerlinktodelta(var_03,"tag_origin",1,180,180,180,180,1);
		}
	}
	else if(self.grapple["style"] == "floor")
	{
		wait(max(0.05,var_04));
		grapple_complete_player_move();
		self unlink();
		grapple_disconnect();
		var_01 = 0;
	}

	level notify("stop_grapplesound");
	if(grapple_after_land_anim())
	{
		var_05 = param_00.land_magnet;
		if(!isdefined(var_05) || !isdefined(var_05.specialstruct) || !isdefined(var_05.specialstruct.afterlandanimconnected) || !var_05.specialstruct.afterlandanimconnected)
		{
			self unlink();
			grapple_disconnect();
			var_01 = 0;
		}
		else
		{
			self playerlinktodelta(var_03,undefined,1,180,180,180,180,0);
		}
	}

	return var_01;
}

//Function Number: 119
grapple_lerp_velocity_to_linked(param_00)
{
	self endon("death");
	self endon("grapple_disconnect");
	var_01 = grapple_move_time(self.grapple["model_player_to"]);
	var_02 = self.grapple["velocity_when_fired"];
	var_03 = length(var_02);
	var_04 = self.grapple["model_player_move_lerp"];
	var_04 unlink();
	var_04.origin = param_00.origin + var_02 * 0.05;
	var_04.angles = param_00.angles;
	var_04 dontinterpolate();
	self playerlinktodelta(var_04,"tag_origin",1,0,0,0,0,0);
	self.grapple["velocity_lerping"] = 0;
	if(getdvarint("grapple_lerp_velocity") && var_03 > 0)
	{
		self endon("grapple_velocity_lerp_end");
		self.grapple["velocity_lerping"] = 1;
		var_05 = var_01;
		if(var_05 > 0)
		{
			var_06 = min(var_03 * 0.01,var_05 * 0.75);
			var_04 grapple_decelerate_move_to(var_02,param_00.origin,param_00,undefined,var_05,var_06,1,self.grapple["model_player_to"],(0,0,60));
		}
	}

	var_04.origin = param_00.origin;
	var_04 linkto(param_00);
}

//Function Number: 120
grapple_move_time(param_00)
{
	var_01 = self.grapple["speed"];
	if(!isdefined(var_01))
	{
		var_01 = 200;
	}

	var_02 = distance(self.origin,param_00.origin);
	var_03 = var_02 / var_01;
	return var_03;
}

//Function Number: 121
grapple_move(param_00,param_01)
{
	self notify("newmove");
	self endon("newmove");
	param_00 endon("death");
	var_02 = param_00 grapple_move_time(param_01);
	var_03 = vectornormalize(param_01.origin - self.origin);
	if(param_00 grapple_special() == "weapon")
	{
		param_00 grapple_with_weapon_start(param_01.land_magnet.specialstruct);
		var_02 = var_02 * 1 / param_01.land_magnet.specialstruct.movescale;
	}

	var_04 = var_02 * 0.9;
	var_05 = var_02 * 0.05;
	var_06 = gettime();
	self moveto(param_01.origin,var_02,var_04,var_05,param_01);
	if(param_00 grapple_special() == "weapon")
	{
		param_00 thread grapple_with_weapon_travel(param_01.land_magnet.specialstruct);
	}

	if(var_02 > 0.5)
	{
		wait(var_02 * 0.2);
		playfxontag(level._effect["grapple_cam"],param_00.grapple["model_player_to"],"tag_origin");
		grapple_motion_blur_enable();
		if(param_00 grapple_special() != "weapon")
		{
			param_00 lerpfov(85,var_02 * 0.3);
		}
	}

	param_00 screenshakeonentity(1.5,1,1,var_02,var_02 * 0.8,0,128,3,1,1);
	var_07 = param_00.grapple["landingParms"];
	var_08 = 0;
	param_00 notify("grapple_moving",param_00.grapple["magnet_current"].magnet);
	var_09 = 0;
	while(!var_07["anim_started"] || !var_07["trans_started"] || !var_07["fov_lerp_started"] || var_09 > 0)
	{
		var_08 = max(0,var_02 - float(gettime() - var_06) / 1000);
		if(!var_07["anim_started"] && var_08 <= var_07["anim_time"])
		{
			param_00 notify("grapple_landing_started");
			param_00 notify("grapple_landing_anim_started");
			var_09 = param_00 thread grapple_landing_anim(var_07);
			var_07["anim_started"] = 1;
		}

		if(!var_07["trans_started"] && var_08 <= var_07["trans_time"])
		{
			param_00 notify("grapple_landing_started");
			param_00 notify("grapple_landing_trans_started");
			param_00 thread grapple_landing_trans(var_07,param_01);
			var_07["trans_started"] = 1;
		}

		if(!var_07["fov_lerp_started"] && var_08 <= var_07["fov_lerp_time"])
		{
			param_00 notify("grapple_landing_started");
			param_00 notify("grapple_landing_fov_started");
			if(param_00 grapple_special() != "weapon")
			{
				param_00 lerpfov(65,var_07["fov_lerp_time"]);
			}

			var_07["fov_lerp_started"] = 1;
		}

		if(!var_07["prep_start_started"] && var_08 <= var_07["prep_start_time"])
		{
			param_00 notify("grapple_prep_land");
			param_00.grapple["landing_prep_started"] = 1;
			var_07["prep_start_started"] = 1;
		}

		var_09 = var_09 - 0.05;
		wait(0.05);
	}

	param_00 notify("grapple_rig_hidden");
	if(isdefined(param_00.grapple["model_hands"]))
	{
		param_00.grapple["model_hands"] hide();
	}

	if(isdefined(param_00.grapple["model_body"]))
	{
		param_00.grapple["model_body"] hide();
	}

	return max(0,var_08);
}

//Function Number: 122
grapple_landing_prep()
{
	var_00 = self getplayerangles();
	var_01 = anglestoforward(var_00);
	var_02 = grapple_special_landing_anims();
	var_03 = "land_straight";
	var_04 = self.grapple["surface_trace"]["normal"] * -1;
	if(self.grapple["style"] == "wall")
	{
		var_05 = vectordot(var_01,var_04);
		if(var_05 < 0.87)
		{
			var_06 = vectorcross((0,0,1),var_04);
			var_07 = vectordot(var_01,var_06);
			if(var_07 < 0)
			{
				var_03 = "land_left";
			}
			else
			{
				var_03 = "land_right";
			}
		}
	}

	if(isdefined(self.grapple["mantle"]))
	{
		if(isdefined(self.grapple["mantle"]["victim"]) && isdefined(self.grapple_victim_landanim))
		{
			var_03 = self.grapple_victim_landanim;
		}
		else if(self.grapple["mantle"]["over"])
		{
			var_03 = "land_mantle_over";
		}
		else
		{
			var_03 = "land_mantle_up";
		}
	}

	var_08 = [];
	var_09 = [];
	var_0A = [];
	var_0B = [];
	var_0C = [];
	var_0D = [];
	var_0E = [];
	var_0F = [];
	var_08["hands"] = self.grapple["model_hands"];
	var_09["hands"] = grapple_anim_tree("grapple_hands");
	if(isdefined(var_02))
	{
		var_0A["hands"] = var_02[1];
		var_0D["hands"] = getanimlength(var_02[1]);
	}
	else
	{
		var_0A["hands"] = grapple_anim_anim("grapple_hands",var_03);
		var_0D["hands"] = grapple_anim_length("grapple_hands",var_03);
	}

	var_0E["hands"] = isdefined(var_0A["hands"]);
	var_08["body"] = self.grapple["model_body"];
	var_09["body"] = grapple_anim_tree("grapple_body");
	if(isdefined(var_02))
	{
		var_0A["body"] = var_02[0];
		var_0D["body"] = getanimlength(var_02[0]);
	}
	else
	{
		var_0A["body"] = grapple_anim_anim("grapple_body",var_03);
		var_0D["body"] = grapple_anim_length("grapple_body",var_03);
	}

	var_0E["body"] = isdefined(var_0A["body"]);
	var_10 = 0;
	var_11 = 0;
	var_12 = 0;
	var_0E["hands"] = 0;
	var_0E["body"] = 0;
	switch(self.grapple["style"])
	{
		case "ceiling":
			var_10 = var_0D["hands"] * 0.5;
			var_11 = var_10;
			var_12 = var_0D["hands"] * 0.75;
			var_0E["hands"] = 1;
			break;

		case "wall":
			var_10 = var_0D["hands"] * 0.5;
			var_11 = var_10;
			var_12 = var_0D["hands"] * 0.75;
			break;

		default:
			var_10 = 0.2;
			var_11 = var_10;
			var_12 = 0;
			break;
	}

	if(isdefined(self.grapple["mantle"]) || isdefined(var_02))
	{
		var_0E["hands"] = 1;
		var_0E["body"] = 0;
		var_13 = self.grapple["model_player_to"];
		if(isdefined(var_02))
		{
			if(isdefined(var_13.land_magnet.tag) && var_13.land_magnet.tag != "")
			{
				var_0B["body"] = var_13.land_magnet.object gettagorigin(var_13.land_magnet.tag);
				var_0C["body"] = var_13.land_magnet.object gettagangles(var_13.land_magnet.tag);
			}
			else
			{
				var_0B["body"] = var_13.land_magnet.object.origin;
				var_0C["body"] = var_13.land_magnet.object.angles;
			}
		}
		else
		{
			var_0B["body"] = self.grapple["mantle"]["position"] + (0,0,0.5);
			var_0C["body"] = (0,vectortoyaw(var_04),0);
		}

		if(isdefined(var_0B["body"]))
		{
			var_0B["body"] = rotatevectorinverted(var_0B["body"] - var_13.origin,var_13.angles);
			var_0C["body"] = var_0C["body"] - var_13.angles;
		}

		var_14 = 0.33;
		var_10 = var_14;
		var_11 = var_14;
		var_12 = var_14;
	}

	if(isdefined(var_0A["hands"]) && !self.grapple["linked_hands"])
	{
		var_08["hands"] linktoplayerview(self,"tag_origin",(0,0,0),(0,0,0),1);
		self.grapple["linked_hands"] = 1;
	}

	if(isdefined(var_08["hands"]) && isdefined(var_0A["hands"]) && isdefined(var_09["hands"]))
	{
		var_08["hands"] useanimtree(var_09["hands"]);
		var_08["hands"] setanim(var_0A["hands"],1,0,0);
		var_08["hands"] setanimtime(var_0A["hands"],0);
	}

	if(isdefined(var_08["body"]) && isdefined(var_0A["body"]) && isdefined(var_09["body"]))
	{
		var_08["body"] useanimtree(var_09["body"]);
		var_08["body"] setanim(var_0A["body"],1,0,0);
		var_08["body"] setanimtime(var_0A["body"],0);
	}

	var_15 = [];
	var_15["anim_time"] = var_12;
	var_15["anim_name"] = var_03;
	var_15["anim_ents"] = var_08;
	var_15["anim_ents_tree"] = var_09;
	var_15["anim_ents_anim"] = var_0A;
	var_15["anim_ents_view_anim"] = var_0F;
	var_15["anim_ents_time"] = var_0D;
	var_15["anim_ents_origin"] = var_0B;
	var_15["anim_ents_angles"] = var_0C;
	var_15["anim_ents_vis"] = var_0E;
	var_15["anim_started"] = 0;
	var_15["trans_time"] = var_10;
	var_15["trans_duration"] = var_11;
	var_15["trans_started"] = 0;
	var_15["fov_lerp_time"] = max(var_10,var_12) * 1.25;
	var_15["fov_lerp_started"] = 0;
	var_15["prep_start_time"] = max(var_10,var_12) + 0.05;
	var_15["prep_start_started"] = 0;
	return var_15;
}

//Function Number: 123
grapple_landing_anim(param_00)
{
	var_01 = 0;
	var_02 = param_00["anim_ents"];
	var_03 = self.grapple["model_player_to"];
	if(isdefined(self.grapple["mantle"]) && isdefined(self.grapple["mantle"]["victim"]))
	{
		self.grapple["mantle"]["victim"] notify("grapple_landing_anim");
	}

	foreach(var_0B, var_05 in var_02)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = var_05.origin;
		var_07 = var_05.angles;
		if(isdefined(param_00["anim_ents_origin"][var_0B]))
		{
			var_08 = 0;
			var_05 unlink();
			var_05.origin = var_03.origin + rotatevector(param_00["anim_ents_origin"][var_0B],var_03.angles);
			var_06 = var_05.origin;
			if(isdefined(param_00["anim_ents_angles"][var_0B]))
			{
				var_05.angles = var_03.angles + param_00["anim_ents_angles"][var_0B];
				var_07 = var_05.angles;
			}

			if(isdefined(self.grapple["model_player_to"].land_entity))
			{
				var_05 linkto(self.grapple["model_player_to"].land_entity);
			}

			var_01 = max(var_01,param_00["anim_ents_time"][var_0B]);
		}

		if(!param_00["anim_ents_vis"][var_0B])
		{
			var_05 hide();
		}
		else
		{
			var_05 show();
			var_05 thread grapple_delayed_hide(param_00["anim_ents_time"][var_0B]);
		}

		if(isdefined(param_00["anim_ents_view_anim"][var_0B]))
		{
			self.grapple["landing_view_anim"] = param_00["anim_ents_view_anim"][var_0B];
			self setviewmodelanim(level.scr_viewanim[param_00["anim_ents_view_anim"][var_0B]]);
		}
		else if(isdefined(param_00["anim_ents_anim"][var_0B]) && isdefined(param_00["anim_ents_tree"][var_0B]))
		{
			var_09 = param_00["anim_ents_anim"][var_0B];
			var_05 useanimtree(param_00["anim_ents_tree"][var_0B]);
			var_05 animscripted("grapple_landing_anim",var_06,var_07,var_09,undefined,undefined,0.1);
			if(isdefined(param_00["anim_ents_origin"][var_0B]))
			{
				var_0A = undefined;
				if(isdefined(self.grapple["mantle"]) && isdefined(self.grapple["mantle"]["victim"]))
				{
					var_0A = self.grapple["mantle"]["victim"];
				}

				var_05 grapple_setup_death_event_handlers("grapple_landing_anim",self,var_0A,getanimlength(var_09));
			}

			if(var_0B == "hands")
			{
				thread grapple_view_model_hands_hide_show();
			}
		}

		var_05 dontinterpolate();
	}

	return var_01;
}

//Function Number: 124
grapple_landing_trans(param_00,param_01)
{
	self endon("death");
	self endon("grapple_disconnect");
	self notify("grapple_abort_monitor");
	var_02 = param_00["trans_time"];
	var_03 = param_00["trans_duration"];
	var_04 = self getplayerangles();
	var_05 = max(45,var_04[0]);
	if(self.grapple["style"] == "ceiling")
	{
		var_05 = min(-45,var_04[0]);
	}

	var_06 = (var_05,param_01.angles[1],0);
	var_07 = var_03 * 0.2;
	var_08 = var_03 * 0.1;
	var_09 = self.grapple["model_player_trans"];
	var_09.origin = self.origin;
	var_09.angles = self getplayerangles();
	var_09 dontinterpolate();
	if(grapple_special_land_hide_rope())
	{
		grapple_rope_state(0,0);
	}
	else
	{
		grapple_rope_state(2,100);
	}

	if(isdefined(param_00["anim_ents_origin"]["body"]) && isdefined(param_00["anim_ents"]["body"]))
	{
		grapple_setup_rope_attached_player(self,self,0);
		var_0A = param_00["anim_ents"]["body"];
		self playerlinktoblend(var_0A,"tag_player",var_03,var_07,var_08);
		wait(var_03);
		grapple_landing_landed(undefined,undefined,undefined,undefined);
		wait(0.05);
		self playerlinktodelta(var_0A,"tag_player",1,0,0,0,0,1);
		self forceviewmodelanimation(self.grapple["weapon"],level.grapple_weapon_anim["travel"]);
		grapple_disable_weapon();
		var_0A show();
		self.grapple["model_hands"] hide();
		return;
	}

	grapple_setup_rope_attached_player(var_09,var_09,0,"tag_player");
	var_0B = var_03 * 0.75;
	var_0C = var_03 - var_0B;
	var_0D = undefined;
	self playerlinkto(var_09,"tag_player",1,0,0,0,0);
	var_0E = param_01.origin + vectornormalize(self.grapple["poll_velocity"]) * 10;
	var_0D = param_01.origin;
	var_09 rotateto(var_06,var_03,var_07,var_08);
	var_09 grapple_decelerate_move_to(self.grapple["poll_velocity"],var_0E,param_01.land_entity,undefined,var_0B,var_0B * 0.75,0);
	grapple_landing_landed(var_09,var_0D,var_0C,param_01);
}

//Function Number: 125
grapple_landing_landed(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::issp())
	{
		self.grapple["model_player_move_tag"] stopsounds();
	}
	else
	{
		level notify("stop_grapplesound");
	}

	grapple_landing_sound(self.grapple["surface_trace"]["surfacetype"]);
	grapple_notify_closest_ai("grapple_impact",self.origin,250);
	self playrumbleonentity("falling_land");
	self screenshakeonentity(2,1,2,0.5,0,0.1,128,3,3,3);
	if(isdefined(param_01) && isdefined(param_00) && isdefined(param_02))
	{
		param_00 moveto(param_01,param_02,param_02 * 0.25,param_02 * 0.25,param_03);
	}

	var_04 = self.grapple["model_rope_idle"];
	var_04 hide();
	grapple_setup_rope_attached_player(self,self,0);
	killfxontag(level._effect["grapple_cam"],self.grapple["model_player_to"],"tag_origin");
}

//Function Number: 126
grapple_landing_sound(param_00)
{
	var_01 = "linelauncher_land_plr_concrete";
	if(isdefined(param_00))
	{
		if(getsubstr(param_00,0,5) == "metal")
		{
			var_01 = "linelauncher_land_plr_metal";
		}
		else if(getsubstr(param_00,0,4) == "wood")
		{
			var_01 = "linelauncher_land_plr_wood";
		}
		else if(getsubstr(param_00,0,4) == "dirt")
		{
			var_01 = "linelauncher_land_plr_dirt";
		}
		else if(getsubstr(param_00,0,5) == "grass")
		{
			var_01 = "linelauncher_land_plr_grass";
		}
	}

	var_02 = "linelauncher_land_concrete";
	if(isdefined(param_00))
	{
		if(getsubstr(param_00,0,5) == "metal")
		{
			var_02 = "linelauncher_land_metal";
		}
		else if(getsubstr(param_00,0,4) == "wood")
		{
			var_02 = "linelauncher_land_wood";
		}
		else if(getsubstr(param_00,0,4) == "dirt")
		{
			var_02 = "linelauncher_land_dirt";
		}
		else if(getsubstr(param_00,0,5) == "grass")
		{
			var_02 = "linelauncher_land_grass";
		}
	}

	if(common_scripts\utility::issp() && isplayer(self))
	{
		soundscripts\_snd_playsound::snd_play_2d(var_01);
		soundscripts\_snd_playsound::snd_play_2d("linelauncher_plr_mantle");
		soundscripts\_snd::snd_message("aud_grapple_land");
		return;
	}

	if(isai(self))
	{
		self playsound(var_02);
		return;
	}

	self playsound(var_01);
}

//Function Number: 127
grapple_motion_blur_enable()
{
	if(common_scripts\utility::issp() && level.nextgen)
	{
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbVelocityScalar",4);
	}
}

//Function Number: 128
grapple_motion_blur_disable()
{
	if(common_scripts\utility::issp() && level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
		setsaveddvar("r_mbVelocityScalar",1);
	}
}

//Function Number: 129
grapple_special()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct))
	{
		return var_00.land_magnet.specialstruct.type;
	}

	return "";
}

//Function Number: 130
grapple_special_landing_anims()
{
	var_00 = self.grapple["model_player_to"];
	var_01 = undefined;
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct))
	{
		if(isdefined(var_00.land_magnet.specialstruct.landanimbody) || isdefined(var_00.land_magnet.specialstruct.landanimhands))
		{
			var_01 = [var_00.land_magnet.specialstruct.landanimbody,var_00.land_magnet.specialstruct.landanimhands];
		}
	}

	return var_01;
}

//Function Number: 131
grapple_special_no_enable_exo()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.noenableexo))
	{
		return var_00.land_magnet.specialstruct.noenableexo;
	}

	return 0;
}

//Function Number: 132
grapple_special_no_enable_weapon()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.noenableweapon))
	{
		return var_00.land_magnet.specialstruct.noenableweapon;
	}

	return 0;
}

//Function Number: 133
grapple_special_hint()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.hint))
	{
		return var_00.land_magnet.specialstruct.hint;
	}

	return undefined;
}

//Function Number: 134
grapple_special_land_hide_rope()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.landhiderope))
	{
		return var_00.land_magnet.specialstruct.landhiderope;
	}

	return 0;
}

//Function Number: 135
grapple_special_indicator_offset()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.indicatoroffset))
	{
		return var_00.land_magnet.specialstruct.indicatoroffset;
	}

	return (0,0,0);
}

//Function Number: 136
grapple_special_no_abort()
{
	var_00 = self.grapple["model_player_to"];
	if(isdefined(var_00.land_magnet) && isdefined(var_00.land_magnet.specialstruct) && isdefined(var_00.land_magnet.specialstruct.noabort))
	{
		return var_00.land_magnet.specialstruct.noabort;
	}

	return 0;
}

//Function Number: 137
grapple_magnet_validate_ground(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.specialstruct) && isdefined(param_00.specialstruct.requireonground) && param_00.specialstruct.requireonground && !self isonground())
	{
		return 0;
	}

	return 1;
}

//Function Number: 138
grapple_notify_closest_ai(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	var_04 = getaiarray("axis");
	var_04 = common_scripts\utility::get_array_of_closest(param_01,var_04,undefined,undefined,param_02,undefined);
	foreach(var_06 in var_04)
	{
		if(var_06.ignoreall)
		{
			continue;
		}

		var_06 notify(param_00,param_01);
		if(!isdefined(param_03) || !param_03)
		{
			break;
		}
	}
}

//Function Number: 139
grapple_notify_ai_capsule(param_00,param_01,param_02,param_03,param_04)
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	var_05 = param_02 - param_01;
	var_06 = vectornormalize(var_05);
	var_07 = length(var_05);
	var_08 = getaiarray("axis");
	var_08 = common_scripts\utility::get_array_of_closest(param_02,var_08,undefined,undefined,var_07 + param_03 * 2,undefined);
	foreach(var_0A in var_08)
	{
		if(var_0A.ignoreall)
		{
			continue;
		}

		if(!isalive(var_0A))
		{
			continue;
		}

		var_0B = var_0A geteye();
		var_0C = var_0B - param_01;
		var_0D = vectordot(var_0C,var_06);
		if(var_0D > param_03 * -1 && var_0D < var_07 + param_03)
		{
			var_0E = param_01 + var_06 * var_0D;
			var_0F = distance(var_0E,var_0B);
			if(var_0F <= param_03)
			{
				var_0A notify(param_00,param_02);
				if(!isdefined(param_04) || !param_04)
				{
					break;
				}
			}
		}
	}
}

//Function Number: 140
grapple_decelerate_move_to(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	var_09 = self.origin;
	var_0A = vectornormalize(param_00);
	var_0B = length(param_00) / param_05 * 2;
	var_0C = gettime() - 25;
	var_0D = param_04 * 1000;
	if(isdefined(param_07) && !isdefined(param_08))
	{
		param_08 = (0,0,0);
	}

	if(isdefined(param_02) && !isdefined(param_03) && isdefined(param_01))
	{
		param_01 = param_01 - param_02.origin;
		param_01 = rotatevectorinverted(param_01,param_02.angles);
	}

	while(gettime() - var_0C < var_0D)
	{
		var_0E = float(gettime() - var_0C) / 1000;
		var_0F = min(var_0E,param_05);
		var_10 = var_09 + param_00 * var_0F;
		var_11 = var_10 + var_0A * var_0B * -0.5 * var_0F * var_0F;
		var_12 = var_0E / param_04;
		var_12 = 1 - 0.5 + cos(var_12 * 180) * 0.5;
		var_13 = param_01;
		if(isdefined(param_02) && !isdefined(param_03) && isdefined(param_01))
		{
			var_13 = param_02.origin + rotatevector(param_01,param_02.angles);
		}
		else if(isdefined(param_02) && isdefined(param_03))
		{
			var_13 = param_02 gettagorigin(param_03);
		}

		if(param_06)
		{
			var_14 = vectorlerp(var_11,var_13,var_12);
			var_15 = var_12 * var_12;
			var_16 = vectorlerp(var_11,var_13,var_15);
			var_14 = (var_14[0],var_14[1],var_16[2]);
		}
		else
		{
			var_14 = vectorlerp(var_11,var_13,var_12);
		}

		var_17 = playerphysicstrace(self.origin,var_14,level.player);
		if(distancesquared(var_17,var_14) > 0.01)
		{
			var_14 = (var_14[0],var_14[1],self.origin[2]);
		}

		self.origin = var_14;
		if(isdefined(param_07))
		{
			self.angles = vectortoangles(param_07.origin - self.origin + param_08);
		}

		wait(0.05);
	}
}

//Function Number: 141
grapple_delayed_hide(param_00)
{
	self endon("death");
	wait(param_00);
	self hide();
}

//Function Number: 142
grapple_fire_rope(param_00,param_01)
{
	self endon("death");
	self endon("grapple_disconnect");
	self notify("grapple_fire_rope");
	self playrumbleonentity("heavygun_fire");
	self screenshakeonentity(2,1,1,0.5,0,0.5,128,2,1,1);
	soundscripts\_snd::snd_message("aud_grapple_launch");
	var_02 = anglestoup(self.grapple["model_preview"].angles);
	self.grapple["landing_prep_started"] = 0;
	self.grapple["velocity_when_fired"] = self getvelocity();
	var_03 = self.grapple["model_rope_fire"];
	var_04 = self.grapple["model_rope_idle"];
	var_05 = self.grapple["model_attach_world"];
	var_06 = self.grapple["model_player_move_tag"];
	var_07 = self.grapple["model_player_from"];
	self freezecontrols(1);
	self setplayerangles(vectortoangles(var_05.origin - self geteye()));
	self.angles = (0,self getplayerangles()[1],0);
	grapple_setup_rope_attached();
	grapple_setup_rope_fire();
	var_06 unlink();
	var_06.origin = self.origin;
	var_06.angles = self.angles;
	var_06 dontinterpolate();
	if(self islinked() && isdefined(var_07))
	{
		var_06 linkto(var_07);
	}
	else if(self isonground())
	{
		var_08 = playerphysicstraceinfo(self.origin,self.origin + (0,0,-10));
		if(isdefined(var_08["entity"]))
		{
			var_06 linkto(var_08["entity"]);
		}
	}
	else
	{
		var_06.velocity = self getvelocity();
	}

	var_09 = "fire";
	if(isdefined(param_00))
	{
		self setviewmodelanim(level.scr_viewanim[param_00]);
		var_09 = param_00;
	}
	else
	{
		self forceviewmodelanimation(self.grapple["weapon"],level.grapple_weapon_anim["fire"]);
	}

	var_0A = grapple_anim_length("grapple_rope",var_09);
	var_03 thread maps\_anim::anim_single_solo(var_03,var_09);
	grapple_rope_state(1);
	thread grapple_fire_rope_impact(0.15);
	thread grapple_fire_rope_finish(var_0A - 0.05,param_01);
}

//Function Number: 143
grapple_fire_rope_impact(param_00)
{
	var_01 = anglestoup(self.grapple["model_preview"].angles);
	var_02 = self.grapple["model_attach_world"];
	wait(param_00);
	if(!isai(self.grapple["surface_trace"]["entity"]))
	{
		magicbullet("s1_grapple_impact",var_02.origin + var_01,var_02.origin - var_01);
		var_02 show();
	}

	self notify("grapple_rope_impact");
}

//Function Number: 144
grapple_fire_rope_finish(param_00,param_01)
{
	self endon("death");
	self endon("grapple_disconnect");
	self endon("grapple_fire_rope");
	self.grapple["fire_rope_finished"] = 0;
	if(self.grapple["landing_prep_started"])
	{
		self.grapple["fire_rope_finished"] = 1;
		self notify("grapple_fire_rope_finished");
		if(isdefined(param_01))
		{
			self [[ param_01 ]]();
		}

		return;
	}

	var_02 = common_scripts\utility::waittill_any_timeout(param_00,"grapple_entity_finished","grapple_complete_player_move","grapple_prep_land");
	if(var_02 == "timeout" || var_02 == "grapple_prep_land")
	{
		if(isdefined(param_01))
		{
			self [[ param_01 ]]();
		}

		self.grapple["fire_rope_finished"] = 1;
		self notify("grapple_fire_rope_finished");
	}
}

//Function Number: 145
grapple_fire_finished()
{
	self freezecontrols(0);
	if(grapple_special() != "weapon")
	{
		var_00 = self.grapple["landingParms"];
		var_01 = isdefined(var_00["anim_ents"]["hands"]) && isdefined(var_00["anim_ents_anim"]["hands"]) && isdefined(var_00["anim_ents_tree"]["hands"]);
		var_01 = var_01 | isdefined(self.grapple["landing_view_anim"]);
		if(!var_01)
		{
			self setviewmodelanim(level.scr_viewanim["grapple_fire_end"]);
			wait(getanimlength(level.scr_anim["grapple_hands"]["grapple_fire_end"]) - 0.05);
			self forceviewmodelanimation(self.grapple["weapon"],level.grapple_weapon_anim["travel"]);
		}
	}
}

//Function Number: 146
grapple_attach_bolt(param_00,param_01)
{
	var_02 = self.grapple["model_attach_world"];
	var_02 unlink();
	var_02 hide();
	if(param_00 == self.grapple["model_preview"])
	{
		var_02.origin = self.grapple["model_preview"].origin;
		var_03 = vectortoangles(vectornormalize(var_02.origin - self geteye()));
		var_02.angles = var_03;
		if(isdefined(self.grapple["model_player_to"].land_entity))
		{
			if(isdefined(self.grapple["model_player_to"].land_magnet) && self.grapple["model_player_to"].land_magnet.tag != "")
			{
				var_02 linkto(self.grapple["model_player_to"].land_entity,self.grapple["model_player_to"].land_magnet.tag);
			}
			else
			{
				var_02 linkto(self.grapple["model_player_to"].land_entity);
			}
		}
	}
	else if(isdefined(param_00))
	{
		var_02.origin = param_00 gettagorigin(param_01);
		var_03 = vectortoangles(vectornormalize(var_02.origin - self geteye()));
		var_02.angles = var_03;
		var_02 linkto(param_00,param_01);
	}

	var_02 dontinterpolate();
	return var_02;
}

//Function Number: 147
grapple_stand_and_lock_stances()
{
	self disableweaponswitch();
	maps\_utility::playerallowweaponpickup(0);
	self allowprone(0);
	self allowcrouch(0);
	self allowmelee(0);
	self setstance("stand");
}

//Function Number: 148
grapple_unlock_stances()
{
	self enableweaponswitch();
	maps\_utility::playerallowweaponpickup(1);
	self allowprone(1);
	self allowcrouch(1);
	self allowmelee(1);
	grapple_enable_weapon();
	grapple_motion_blur_disable();
}

//Function Number: 149
grapple_enable_weapon()
{
	self.grapple["weapon_enabled"] = 1;
	if(self.grapple["no_enable_weapon"])
	{
		return;
	}

	self enableweapons();
}

//Function Number: 150
grapple_disable_weapon()
{
	self.grapple["weapon_enabled"] = 0;
	self disableweapons();
}

//Function Number: 151
grapple_quick_fire_switch_back(param_00)
{
	self endon("death");
	while(!param_00 && self.grapple["weapon_enabled"] && self isreloading())
	{
		wait(0.05);
	}

	grapple_switch(0,param_00);
	self.grapple["ready_time"] = gettime() + 3000;
	self.grapple["quick_fire_executed"] = 0;
	while(self getcurrentweapon() == self.grapple["weapon"] || self getcurrentweapon() == "none")
	{
		wait(0.05);
	}
}

//Function Number: 152
grapple_enable_normal_mantle_hint(param_00)
{
	if(param_00)
	{
		setsaveddvar("cg_drawMantleHint","1");
		return;
	}

	setsaveddvar("cg_drawMantleHint","0");
}

//Function Number: 153
grapple_with_weapon_start(param_00)
{
	wait(0.4);
	var_01 = self.grapple["model_player_move_lerp"];
	self playerlinktodelta(var_01,"tag_origin",1,param_00.anglelimit,param_00.anglelimit,param_00.anglelimit,param_00.anglelimit,0);
	self forceviewmodelanimationclear();
	grapple_setup_rope_attached(0);
	grapple_rope_state(1);
	thread grapple_with_weapon_turnrates("end_grapple_with_weapon");
	thread grapple_with_weapon_infinite_ammo("end_grapple_with_weapon");
	self enableinvulnerability();
	grapple_enable_weapon();
	self switchtoweaponimmediate(param_00.weapon);
	self disableweaponswitch();
	wait(0.6);
}

//Function Number: 154
grapple_with_weapon_travel(param_00)
{
	if(isdefined(param_00.slowmodelay))
	{
		wait(param_00.slowmodelay);
	}

	if(!isdefined(param_00.slowmodelta))
	{
		param_00.slowmodelta = 0.15;
	}

	setslowmotion(1,param_00.slowmospeed,param_00.slowmodelta);
	common_scripts\utility::waittill_any("grapple_landing_trans_started","grapple_abort",param_00.slowmostop);
	self enableweaponswitch();
	self disableinvulnerability();
	setslowmotion(param_00.slowmospeed,1,0.25);
	self notify("end_grapple_with_weapon");
}

//Function Number: 155
grapple_with_weapon_turnrates(param_00)
{
	self.aim_turnrate_pitch = getdvarint("aim_turnrate_pitch");
	self.aim_turnrate_pitch_ads = getdvarint("aim_turnrate_pitch_ads");
	self.aim_turnrate_yaw = getdvarint("aim_turnrate_yaw");
	self.aim_turnrate_yaw_ads = getdvarint("aim_turnrate_yaw_ads");
	self.aim_accel_turnrate_lerp = getdvarint("aim_accel_turnrate_lerp");
	setsaveddvar("aim_turnrate_pitch",180);
	setsaveddvar("aim_turnrate_pitch_ads",110);
	setsaveddvar("aim_turnrate_yaw",500);
	setsaveddvar("aim_turnrate_yaw_ads",250);
	setsaveddvar("aim_accel_turnrate_lerp",1200);
	self waittill(param_00);
	setsaveddvar("aim_turnrate_pitch",self.aim_turnrate_pitch);
	setsaveddvar("aim_turnrate_pitch_ads",self.aim_turnrate_pitch_ads);
	setsaveddvar("aim_turnrate_yaw",self.aim_turnrate_yaw);
	setsaveddvar("aim_turnrate_yaw_ads",self.aim_turnrate_yaw_ads);
	setsaveddvar("aim_accel_turnrate_lerp",self.aim_accel_turnrate_lerp);
}

//Function Number: 156
grapple_with_weapon_infinite_ammo(param_00)
{
	self endon("death");
	self endon(param_00);
	while(isdefined(self.weapon))
	{
		if(isdefined(self.weapon) && self.weapon == "none")
		{
			break;
		}

		self.bulletsinclip = weaponclipsize(self.weapon);
		wait(0.5);
	}
}
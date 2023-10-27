/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_car_door_shield.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 777 ms
 * Timestamp: 10/27/2023 1:58:22 AM
*******************************************************************/

//Function Number: 1
init_door_shield()
{
	precachefx();
	precacheitem("weapon_suv_door_shield_fl");
	precacheitem("weapon_suv_door_shield_fr");
	precacheitem("weapon_boxtruck_door_shield_fl");
	precacheitem("weapon_boxtruck_door_shield_fr");
	if(!1)
	{
		precachemodel("npc_atlas_suv_door_fl");
	}

	precachemodel("vm_atlas_suv_door_fr");
	precachemodel("vm_atlas_suv_door_fl");
	precachemodel("vm_civ_boxtruck_door_fr");
	precachemodel("vm_civ_boxtruck_door_fl");
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",4);
	setsaveddvar("r_hudoutlinecloaklumscale",3);
	setsaveddvar("r_hudoutlinecloakblurradius",0.35);
	maps\_utility::add_control_based_hint_strings("hint_door_throw",&"_CAR_DOOR_SHIELD_THROW_HINT",::should_break_on_throw);
	if(!player_anims())
	{
		return;
	}

	common_scripts\utility::flag_init("player_has_cardoor");
	common_scripts\utility::flag_init("player_pulling_cardoor");
	var_00 = getentarray("trig_door_shield","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_vb_anim_org","targetname");
	doors_intialize(var_00,var_01);
	thread monitor_interaction_toggle_player_has_door(var_00);
	thread handle_car_door_throw_hint();
}

//Function Number: 2
doors_intialize(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(level.player usinggamepad())
		{
			var_03 sethintstring(&"_CAR_DOOR_SHIELD_INTERACT");
		}
		else
		{
			var_03 sethintstring(&"_CAR_DOOR_SHIELD_INTERACT_PC");
		}

		var_03.vb_anim_org = var_03 get_closest_scene(param_01);
		var_03 thread door_shield_think();
	}
}

//Function Number: 3
precachefx()
{
	level._effect["car_door_shield_ripoff"] = loadfx("vfx/sparks/car_door_ripoff_sparks");
	level._effect["large_glass_1"] = loadfx("vfx/weaponimpact/large_glass_1");
	level._effect["seo_suv_doorshield_hit"] = loadfx("vfx/map/seoul/seo_suv_doorshield_hit");
	level._effect["seo_suv_doorshield_hit_break"] = loadfx("vfx/map/seoul/seo_suv_doorshield_hit_break");
}

//Function Number: 4
get_closest_scene(param_00)
{
	return common_scripts\utility::getclosest(self.origin,param_00,160);
}

//Function Number: 5
monitor_interaction_toggle_player_has_door(param_00)
{
	for(;;)
	{
		common_scripts\utility::flag_wait("player_has_cardoor");
		common_scripts\utility::flag_clear("player_pulling_cardoor");
		param_00 = common_scripts\utility::array_removeundefined(param_00);
		foreach(var_02 in param_00)
		{
			var_02 common_scripts\utility::trigger_off();
			var_02 thread button_hint_disable();
		}

		common_scripts\utility::flag_waitopen("player_has_cardoor");
		param_00 = common_scripts\utility::array_removeundefined(param_00);
		foreach(var_02 in param_00)
		{
			var_02 common_scripts\utility::trigger_on();
			var_02 thread button_hint_display();
		}

		wait 0.05;
	}
}

//Function Number: 6
door_shield_think()
{
	var_00 = getent(self.target,"targetname");
	var_01 = getent(var_00.target,"targetname");
	var_01.normal_stencil = 1;
	var_01 thread stecil_when_in_view();
	if(isdefined(level.template_script) && level.template_script != "seoul")
	{
		thread button_hint_display();
	}
	else if(!isdefined(level.template_script))
	{
		thread button_hint_display();
	}

	var_02 = get_door_anime(var_01.model);
	if(isdefined(self.vb_anim_org))
	{
		var_03 = spawn_player_rig_for_carshield("player_rig",self.vb_anim_org.origin);
		var_03 hide();
		self.vb_anim_org maps\_anim::anim_first_frame_solo(var_03,var_02);
		var_01.origin = var_03 gettagorigin("tag_weapon_left");
		var_01.angles = var_03 gettagangles("tag_weapon_left");
		var_03 delete();
	}
	else
	{
		iprintlnbold("self.vb_anim_org  not defined, skipping door pull anims");
	}

	var_04 = get_broken_state_tags(var_01.model);
	for(var_05 = 1;var_05 < var_04.size;var_05++)
	{
		var_01 hidepart(var_04[var_05],var_01.model);
	}

	for(var_06 = 0;!var_06;var_06 = 1)
	{
		self waittill("trigger");
		if(isdefined(level.player.grapple) && level.player.grapple["quick_firing"] || level.player.grapple["grappling"])
		{
			continue;
		}
	}

	self sethintstring("");
	self delete();
	level.player notify("car_door_pulled");
	level.player common_scripts\utility::flag_set("player_pulling_cardoor");
	check_for_door(var_01);
	var_00 common_scripts\utility::delaycall(0.9,::delete);
}

//Function Number: 7
button_hint_display()
{
	self.button = maps\_shg_utility::hint_button_trigger("x");
	self waittill("trigger");
	button_hint_disable();
}

//Function Number: 8
button_hint_disable()
{
	if(isdefined(self.button))
	{
		self.button maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 9
stecil_when_in_view()
{
	self endon("death");
	self endon("end_hud_outline");
	self endon("door_weapon_removed");
	target_set(self);
	target_hidefromplayer(self,level.player);
	while(isdefined(self))
	{
		while(!self.normal_stencil)
		{
			wait 0.05;
		}

		var_00 = distance(level.player.origin,self.origin);
		if(var_00 < 200 && target_isincircle(self,level.player,65,150))
		{
			self hudoutlineenable(6,1);
			continue;
		}

		self hudoutlinedisable();
		wait(0.05);
	}
}

//Function Number: 10
check_for_door(param_00)
{
	var_01 = level.player getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"door"))
		{
			level.player takeweapon(var_03);
			break;
		}
	}

	thread equip_new_door(param_00,isdefined(self.vb_anim_org));
	if(isdefined(self.vb_anim_org))
	{
		level.player play_vb_cardoor_anim(self.vb_anim_org,param_00);
	}
}

//Function Number: 11
play_vb_cardoor_anim(param_00,param_01)
{
	var_02 = get_door_anime(param_01.model);
	var_03 = spawn_player_rig_for_carshield("player_rig",param_00.origin);
	var_03 hide();
	thread car_door_ripoff_fx(param_01);
	self freezecontrols(1);
	var_04 = 0.4;
	param_00 thread maps\_anim::anim_first_frame_solo(var_03,var_02);
	get_cardoor_in_players_hands(var_03,param_01);
	self playerlinktoblend(var_03,"tag_player",var_04);
	maps\_shg_utility::setup_player_for_scene(1);
	thread delete_nearest_car_door_vehicle_collision();
	var_03 show();
	level.player enableinvulnerability();
	soundscripts\_snd::snd_message("doorshield_ripoff");
	param_00 maps\_anim::anim_single_solo(var_03,var_02);
	level.player disableinvulnerability();
	self unlink();
	var_03 delete();
	maps\_shg_utility::setup_player_for_gameplay();
	self freezecontrols(0);
	self notify("player_has_cardoor");
}

//Function Number: 12
car_door_ripoff_fx(param_00)
{
	if(issubstr(param_00.model,"fr"))
	{
		wait(1.6);
		var_01 = common_scripts\utility::spawn_tag_origin();
		var_01 linkto(param_00,"tag_flash",(0,35,0),(0,0,0));
		playfxontag(common_scripts\utility::getfx("car_door_shield_ripoff"),var_01,"tag_origin");
		wait(2);
		var_01 delete();
		return;
	}

	wait(1.6);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"tag_flash",(0,-35,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("car_door_shield_ripoff"),var_02,"tag_origin");
	wait(2);
	var_02 delete();
}

//Function Number: 13
get_cardoor_in_players_hands(param_00,param_01)
{
	param_01 linkto(param_00,"tag_weapon_left",(0,0,0),(0,0,0));
}

//Function Number: 14
spawn_player_rig_for_carshield(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "player_rig";
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player.origin;
	}

	var_02 = maps\_utility::spawn_anim_model(param_00);
	return var_02;
}

//Function Number: 15
equip_new_door(param_00,param_01)
{
	var_02 = get_weapon_model(param_00.model);
	var_03 = get_door_model(param_00.model);
	give_door_shield_weapon(param_00,var_02,var_03,param_01);
	level notify("player_owns_cardoor_shield");
	common_scripts\utility::flag_set("player_has_cardoor");
}

//Function Number: 16
get_door_model(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "atlas_suv_door_03_gj":
		case "vm_atlas_suv_door_fl":
			break;

		case "atlas_suv_door_04_gj":
		case "atlas_suv_door_02_gj":
		case "vm_atlas_suv_door_fr":
			break;

		case "npc_civ_boxtruck_door_fl":
			break;

		case "npc_civ_boxtruck_door_fr":
			break;
	}
}

//Function Number: 17
get_weapon_model(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "atlas_suv_door_03_gj":
		case "vm_atlas_suv_door_fl":
			break;

		case "atlas_suv_door_04_gj":
		case "atlas_suv_door_02_gj":
		case "vm_atlas_suv_door_fr":
			break;

		case "npc_civ_boxtruck_door_fl":
			break;

		case "npc_civ_boxtruck_door_fr":
			break;
	}
}

//Function Number: 18
get_door_anime(param_00)
{
	var_01 = undefined;
	if(issubstr(param_00,"boxtruck"))
	{
		var_01 = "doorshield_bt_ripoff";
		if(issubstr(param_00,"fr"))
		{
			var_01 = "doorshield_bt_ripoff_r";
		}
	}
	else
	{
		var_01 = "doorshield_ripoff";
		if(issubstr(param_00,"fr"))
		{
			var_01 = "doorshield_ripoff_r";
		}
	}

	return var_01;
}

//Function Number: 19
get_yaw_offset_if_vm_model(param_00)
{
	if(param_00 == "vm_atlas_suv_door_fr" || param_00 == "vm_atlas_suv_door_fl" || param_00 == "vm_civ_boxtruck_door_fr" || param_00 == "vm_civ_boxtruck_door_fl")
	{
		return -90;
	}

	return 0;
}

//Function Number: 20
give_door_shield_weapon(param_00,param_01,param_02,param_03)
{
	param_00 notify("end_hud_outline");
	param_00 hudoutlinedisable();
	level.player.cardoor_old_weapon = level.player getcurrentweapon();
	level.player.cardoor_weapon = param_01;
	level.player giveweapon(param_01);
	level.player switchtoweapon(param_01);
	if(isdefined(param_03) && param_03)
	{
		level.player waittill("player_has_cardoor");
	}

	if(param_00.model != param_02)
	{
		param_00 setmodel(param_02);
	}

	param_00 linktoplayerview(level.player,"TAG_WEAPON_LEFT",(0,0,0),(0,get_yaw_offset_if_vm_model(param_02),0),1);
	level.player thread delete_weapon_on_notify(param_00,param_01);
	thread weapon_pickups_disable(param_00);
	thread monitor_door_state(param_00,level.player);
	thread monitor_throw_door(param_00);
	thread monitor_grenades(param_00);
	thread monitor_weapon_switch(param_00);
	thread monitor_door_broken(param_00);
	thread monitor_weapon_remove(param_00,param_01);
}

//Function Number: 21
weapon_pickups_disable(param_00)
{
	level.player maps\_utility::playerallowweaponpickup(0,"door_shield");
	param_00 waittill("door_weapon_removed");
	level.player maps\_utility::playerallowweaponpickup(1,"door_shield");
}

//Function Number: 22
handle_npc_death(param_00)
{
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		var_03 thread kill_npc_on_impact(param_00);
	}
}

//Function Number: 23
monitor_throw_door(param_00)
{
	param_00 endon("door_weapon_removed");
	level.player endon("kill_throw_monitor");
	var_01 = ["weapon_suv_door_shield_fr","weapon_suv_door_shield_fl","weapon_boxtruck_door_shield_fr","weapon_boxtruck_door_shield_fl"];
	for(;;)
	{
		while(!level.player attackbuttonpressed() && !level.player meleebuttonpressed())
		{
			wait 0.05;
		}

		var_02 = level.player getcurrentweapon();
		foreach(var_04 in var_01)
		{
			if(var_02 == var_04)
			{
				thread play_throw_anim(var_04,param_00,1);
				soundscripts\_snd::snd_message("doorshield_throw");
				level.player notify("kill_throw_monitor");
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 24
play_throw_anim(param_00,param_01,param_02,param_03)
{
	wait(0.1);
	level.player exo_door_throw(param_01,param_02);
	level.player takeweapon(param_00);
	if(!isdefined(param_03) || param_03 == 1)
	{
		level.player switchtoweapon(level.player.cardoor_old_weapon);
	}

	common_scripts\utility::flag_clear("player_has_cardoor");
}

//Function Number: 25
exo_door_throw(param_00,param_01)
{
	var_02 = undefined;
	if(!1)
	{
		var_03 = level.player.origin;
		var_02 = spawn("script_model",var_03 + (0,0,48));
		var_02 setmodel("npc_atlas_suv_door_FL");
		var_02.origin = param_00.origin;
		var_02.angles = param_00.angles;
		param_00 delete();
	}
	else
	{
		var_02 = param_00;
		param_00 unlinkfromplayerview(level.player);
		param_00 show();
	}

	var_02.original_origin = var_02.origin;
	var_02.angles = (0,self.angles[1],self.angles[2]);
	thread handle_npc_death(var_02);
	var_04 = common_scripts\utility::spawn_tag_origin();
	target_set(var_04);
	target_hidefromplayer(var_04,level.player);
	var_05 = undefined;
	if(param_01)
	{
		var_06 = getaiarray("axis");
		var_06 = sortbydistance(var_06,level.player.origin);
		var_07 = undefined;
		foreach(var_09 in var_06)
		{
			var_04.origin = var_09 geteye();
			if(target_isincircle(var_04,level.player,65,100))
			{
				var_07 = var_09;
			}
		}

		if(isdefined(var_07))
		{
			var_05 = var_07;
		}
		else
		{
			var_05 = undefined;
		}
	}

	var_04 delete();
	var_02 soundscripts\_snd::snd_message("doorshield_throw");
	var_02 fire_door_shield(var_05,param_01);
}

//Function Number: 26
fire_door_shield(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_05 = 100;
	if(isdefined(param_00) && issentient(param_00) && param_01)
	{
		var_02 = vectornormalize(param_00.origin - self.origin) * var_05;
		var_06 = distance(self.origin,param_00.origin);
		var_03 = min(200,var_06);
		var_04 = min(250,var_06) + var_06 / 5;
	}
	else if(param_01)
	{
		var_07 = anglestoforward(level.player getgunangles());
		var_08 = self.origin + var_07 * var_05;
		var_02 = var_08 - self.origin;
		var_03 = 200;
		var_04 = 250;
	}
	else
	{
		var_07 = anglestoforward(level.player getgunangles());
		var_08 = self.origin + var_08 * var_07;
		var_02 = var_08 - self.origin;
		var_03 = 40;
		var_04 = 41;
	}

	self physicslaunchserver(self.origin,var_02 * randomfloatrange(var_03,var_04),20000,1080);
	level.player notify("car_door_thrown");
	self notify("door_weapon_removed");
}

//Function Number: 27
kill_npc_on_impact(param_00)
{
	param_00 endon("physics_finished");
	self endon("death");
	while(distance(self.origin,param_00.origin) > 100)
	{
		wait 0.05;
	}

	thread maps\_utility::flashbangstart(2);
	if(issubstr(self.classname,"mech"))
	{
		return;
	}

	while(distance(self.origin,param_00.origin) > 50)
	{
		wait 0.05;
	}

	var_01 = vectornormalize(self gettagorigin("tag_eye") - param_00.original_origin);
	var_01 = vectornormalize(var_01 + (0,0,0.2));
	self startragdollfromimpact("torso_lower",var_01 * 3400);
	maps\_utility::giveachievement_wrapper("CARMA");
	self kill();
}

//Function Number: 28
player_anims(param_00)
{
	var_01 = undefined;
	if(isdefined(level.scr_model))
	{
		if(isdefined(level.scr_model["player_rig"]))
		{
			var_01 = "player_rig";
		}
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	level.scr_anim[var_01]["doorshield_ripoff"] = %vm_doorshield_pullout_viewbody;
	level.scr_anim[var_01]["doorshield_ripoff_r"] = %vm_doorshield_passenger_pullout_viewbody;
	level.scr_anim[var_01]["doorshield_bt_ripoff"] = %vm_doorshield_truck_driver_pullout_viewbody;
	level.scr_anim[var_01]["doorshield_bt_ripoff_r"] = %vm_doorshield_truck_passenger_pullout_viewbody;
	return 1;
}

//Function Number: 29
monitor_grenades(param_00)
{
	param_00 endon("death");
	param_00 endon("door_weapon_removed");
	level.player endon("car_door_thrown");
	var_01 = "none";
	for(;;)
	{
		if(level.player isthrowinggrenade())
		{
			var_01 = get_player_grenade_button();
			wait(0.1);
			param_00 hide();
			for(;;)
			{
				wait_for_thrown_grenade(param_00);
				if(var_01 == "frag_button" && level.player secondaryoffhandbuttonpressed())
				{
					var_01 = "secondary_offhand_button";
					continue;
				}

				if(var_01 == "secondary_offhand_button" && level.player fragbuttonpressed())
				{
					var_01 = "frag_button";
					continue;
				}

				break;
			}

			param_00 show();
			while(level.player isthrowinggrenade())
			{
				wait 0.05;
			}
		}
		else if(!is_current_weapon_shield(level.player getcurrentweapon()))
		{
			param_00 hide();
			while(!is_current_weapon_shield(level.player getcurrentweapon()))
			{
				wait 0.05;
			}

			param_00 show();
		}

		wait 0.05;
	}
}

//Function Number: 30
monitor_weapon_switch(param_00)
{
	param_00 endon("door_weapon_removed");
	level.player endon("car_door_thrown");
	for(;;)
	{
		level.player waittill("weapon_switch_started",var_01);
		if(issubstr(level.player getcurrentweapon(),"door"))
		{
			var_02 = 1;
			if(weaponinventorytype(var_01) != "offhand" && var_01 != "none")
			{
				var_02 = 0;
			}

			thread play_throw_anim(level.player getcurrentweapon(),param_00,0,var_02);
			return;
		}
	}
}

//Function Number: 31
monitor_door_broken(param_00)
{
	param_00 endon("door_weapon_removed");
	level.player endon("car_door_thrown");
	for(;;)
	{
		level.player waittill("car_door_broken");
		if(issubstr(level.player getcurrentweapon(),"door"))
		{
			thread play_throw_anim(level.player getcurrentweapon(),param_00,0);
			return;
		}
	}
}

//Function Number: 32
monitor_weapon_remove(param_00,param_01)
{
	param_00 endon("death");
	level.player endon("car_door_thrown");
	for(;;)
	{
		if(!level.player hasweapon(param_01))
		{
			param_00 notify("door_weapon_removed");
			wait 0.05;
			var_02 = getweaponarray();
			foreach(var_04 in var_02)
			{
				if(var_04.classname == "weapon_" + param_01)
				{
					thread play_throw_anim(param_01,param_00,0);
					var_04 delete();
				}
			}

			if(level.player getcurrentweapon() == "none")
			{
				level.player switchtoweapon(level.player.cardoor_old_weapon);
			}
		}

		wait 0.05;
	}
}

//Function Number: 33
get_player_grenade_button()
{
	var_00 = level.player getcurrentoffhand();
	if(isdefined(level.player.variable_grenade))
	{
		foreach(var_02 in level.player.variable_grenade["normal"])
		{
			if(var_02 == var_00)
			{
				return "frag_button";
			}
		}

		foreach(var_02 in level.player.variable_grenade["special"])
		{
			if(var_02 == var_00)
			{
				return "secondary_offhand_button";
			}
		}
	}
	else if(var_00 == "frag_grenade_var" || var_00 == "frag_grenade")
	{
		return "frag_button";
	}
	else if(var_00 == "flash_grenade_var" || var_00 == "flash_grenade")
	{
		return "secondary_offhand_button";
	}

	if(level.player fragbuttonpressed())
	{
		return "frag_button";
	}
	else if(level.player secondaryoffhandbuttonpressed())
	{
		return "secondary_offhand_button";
	}

	return "none";
}

//Function Number: 34
is_current_weapon_shield(param_00)
{
	return param_00 == "weapon_suv_door_shield_fr" || param_00 == "weapon_suv_door_shield_fl" || param_00 == "weapon_boxtruck_door_shield_fr" || param_00 == "weapon_boxtruck_door_shield_fl";
}

//Function Number: 35
wait_for_thrown_grenade(param_00)
{
	param_00 endon("death");
	level.player endon("car_door_thrown");
	param_00 endon("door_weapon_removed");
	level.player endon("offhand_end");
	while(level.player isthrowinggrenade())
	{
		wait 0.05;
	}
}

//Function Number: 36
get_broken_state_tags(param_00)
{
	var_01 = [];
	var_02 = [];
	var_02[0] = "TAG_GLASS_LEFT_FRONT";
	var_02[1] = "TAG_GLASS_LEFT_FRONT_D1";
	var_02[2] = "TAG_GLASS_LEFT_FRONT_D2";
	var_02[3] = "TAG_GLASS_LEFT_FRONT_D3";
	var_02[4] = "TAG_GLASS_LEFT_FRONT_D4";
	foreach(var_04 in var_02)
	{
		if(maps\_utility::hastag(param_00,var_04))
		{
			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}

//Function Number: 37
monitor_door_state(param_00,param_01)
{
	param_00 notify("kill_duplicate_threads");
	param_00 endon("kill_duplicate_threads");
	param_00 endon("death");
	param_00 endon("door_weapon_removed");
	param_01 endon("car_door_thrown");
	param_00.state_num = 0;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = get_broken_state_tags(param_00.model);
	for(var_05 = 1;var_05 < var_04.size;var_05++)
	{
		param_00 hidepart(var_04[var_05],param_00.model);
	}

	var_06 = [];
	var_06[0] = 125;
	var_06[1] = 125;
	var_06[2] = 125;
	var_06[3] = 125;
	param_00.door_state_health = var_06[0];
	childthread monitor_player_damage(param_01,param_00,var_04,var_06);
	childthread monitor_car_door_shield_damage(param_01,param_00,var_04,var_06);
}

//Function Number: 38
monitor_player_damage(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		param_00 waittill("riotshield_hit",var_04,var_05);
		handle_car_door_shield_damage(param_00,param_01,param_02,param_03,var_04,var_05.origin,var_05.angles);
		wait 0.05;
	}
}

//Function Number: 39
monitor_car_door_shield_damage(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		param_00 waittill("car_door_shield_damaged",var_04,var_05,var_06);
		handle_car_door_shield_damage(param_00,param_01,param_02,param_03,var_04,var_05,var_06);
		wait 0.05;
	}
}

//Function Number: 40
handle_car_door_shield_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(is_current_weapon_shield(param_00 getcurrentweapon()))
	{
		var_07 = param_01 get_closest_on_glass_plane(param_05);
		var_08 = var_07[0];
		var_09 = var_07[1];
		var_0A = var_07[2];
		var_0B = 0;
		if(param_01.state_num < param_02.size - 1)
		{
			param_01.door_state_health = param_01.door_state_health - param_04;
			if(param_01.door_state_health <= 0)
			{
				var_0B = 1;
				param_01.state_num++;
				if(param_01.state_num != param_02.size - 1)
				{
					var_0C = 0.4 + randomfloat(100) * 0.01 * 0.25;
					var_0D = 0.2 + randomfloat(100) * 0.01 * 0.5;
					earthquake(var_0C,var_0D,param_00.origin,100);
					playfx(common_scripts\utility::getfx("seo_suv_doorshield_hit"),var_08,var_09,var_0A);
					level.player notify("doorshield_hit");
				}
				else
				{
					playfx(common_scripts\utility::getfx("seo_suv_doorshield_hit_break"),var_08,var_09,var_0A);
					earthquake(1.2,0.75,level.player.origin,100);
					level.player notify("car_door_broken");
					soundscripts\_snd::snd_message("car_door_broken");
				}

				foreach(var_0F in param_02)
				{
					param_01 hidepart(var_0F,param_01.model);
				}

				param_01 showpart(param_02[param_01.state_num],param_01.model);
				param_01.door_state_health = param_03[param_01.state_num];
				wait 0.05;
			}
		}

		if(!var_0B)
		{
			var_0C = 0.3 + randomfloat(100) * 0.01 * 0.25;
			var_0D = 0.2 + randomfloat(100) * 0.01 * 0.5;
			earthquake(var_0C,var_0D,param_00.origin,100);
			playfx(common_scripts\utility::getfx("large_glass_1"),var_08,var_09,var_0A);
		}
	}
}

//Function Number: 41
get_closest_on_glass_plane(param_00)
{
	var_01 = param_00;
	var_02 = level.player getplayerangles();
	var_03 = anglestoforward(var_02);
	var_04 = level.player geteye();
	var_04 = var_04 + var_03 * 15;
	var_05 = vectordot(var_03,var_01 - var_04);
	var_06 = var_01 - var_05 * var_03;
	return [var_06,var_03,anglestoup(var_02)];
}

//Function Number: 42
get_origin_and_dir_on_glass_plane(param_00,param_01)
{
	var_02 = level.player getplayerangles();
	var_03 = anglestoforward(var_02);
	var_04 = level.player geteye();
	var_04 = var_04 + var_03 * 15;
	var_05 = var_04 - param_00;
	var_06 = anglestoforward(param_01);
	var_07 = vectordot(var_06,var_03);
	if(var_07 == 0)
	{
		return [param_00,var_03,anglestoup(var_02)];
	}

	var_08 = vectordot(var_05,var_03) / var_07;
	return [param_00 + var_06 * var_08,var_03,anglestoup(var_02)];
}

//Function Number: 43
delete_weapon_on_notify(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("door_weapon_removed");
	self waittill("remove_car_doors");
	if(self hasweapon(param_01))
	{
		self takeweapon(param_01);
	}

	self switchtoweapon(self.cardoor_old_weapon);
	param_00 delete();
}

//Function Number: 44
handle_car_door_throw_hint()
{
	level.player endon("death");
	level.player endon("kill_throw_monitor");
	level.player endon("donot_show_throw_hint");
	level waittill("player_owns_cardoor_shield");
	maps\_utility::hintdisplaymintimehandler("hint_door_throw",5);
}

//Function Number: 45
should_break_on_throw()
{
	if(common_scripts\utility::flag("player_has_cardoor"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 46
delete_nearest_car_door_vehicle_collision()
{
	var_00 = getentarray("car_door_vehicle_clip","targetname");
	var_01 = common_scripts\utility::array_sort_by_handler(var_00,::distance_from_player);
	if(isdefined(var_01[0]))
	{
		var_01[0] delete();
	}
}

//Function Number: 47
distance_from_player()
{
	return distance(level.player.origin,self.origin);
}
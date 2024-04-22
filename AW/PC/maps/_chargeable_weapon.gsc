/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _chargeable_weapon.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 474 ms
 * Timestamp: 4/22/2024 2:20:12 AM
*******************************************************************/

//Function Number: 1
setup_charged_shot()
{
	level._effect["charged_shot_tracer_low"] = loadfx("vfx/trail/charged_shot_1_trail");
	level._effect["charged_shot_tracer_med"] = loadfx("vfx/trail/charged_shot_2_trail");
	level._effect["charged_shot_tracer_high"] = loadfx("vfx/trail/charged_shot_3_trail");
	level._effect["charged_shot_impact_low"] = loadfx("vfx/weaponimpact/charged_shot_impact_1");
	level._effect["charged_shot_impact_med"] = loadfx("vfx/weaponimpact/charged_shot_impact_2");
	level._effect["charged_shot_impact_high"] = loadfx("vfx/weaponimpact/charged_shot_impact_3");
	level._effect["charged_shot_character_smoke"] = loadfx("vfx/smoke/charged_shot_character_smoke");
	soundscripts\_snd::snd_message("wpn_deam160_init");
	precacherumble("steady_rumble");
	foreach(var_01 in level.players)
	{
		var_01 thread monitor_charge_time();
		var_01 thread player_handle_charged_shot();
	}
}

//Function Number: 2
cleanup()
{
	player_cleanup_rumble();
	player_cleanup_reticle();
	player_cleanup_charge_indicator();
	player_cleanup_sound();
}

//Function Number: 3
get_max_charge_time()
{
	var_00 = getminchargetime(self getcurrentweapon());
	var_01 = getchargetimepershot(self getcurrentweapon());
	var_02 = getmaxchargeshots(self getcurrentweapon());
	var_03 = var_00 + var_01 * var_02;
	return var_03;
}

//Function Number: 4
monitor_player_death()
{
	self waittill("death");
	cleanup();
}

//Function Number: 5
monitor_charge_time()
{
	self endon("death");
	player_init_rumble();
	player_init_reticle();
	player_init_charge_indicator();
	player_init_sound();
	thread monitor_player_death();
	var_00 = 0;
	var_01 = 1;
	for(;;)
	{
		var_02 = weaponischargeable(self getcurrentweapon());
		var_03 = var_02 && !self isthrowinggrenade() && !self isreloading() && !self ismeleeing() && !self ismantling();
		var_04 = level.player getchargetime();
		if(var_03)
		{
			var_05 = var_00 == 0 && var_04 > 0;
			var_06 = var_00 > 0 && var_04 == 0;
			var_07 = getminchargetime(self getcurrentweapon());
			var_08 = get_max_charge_time();
			var_01 = 0;
			player_do_rumble(var_04,var_07,var_08);
			player_do_reticle(var_04,var_07,var_08);
			player_do_charge_indicator(var_04,var_07,var_08,var_00);
			player_do_sound(var_04,var_05,var_06);
			player_do_camera_shake(var_04,var_07,var_08);
		}
		else if(!var_01)
		{
			cleanup();
			var_01 = 1;
		}

		var_00 = var_04;
		wait(0.05);
	}
}

//Function Number: 6
player_handle_charged_shot()
{
	self endon("death");
	for(;;)
	{
		level.player waittill("energy_fire",var_00);
		var_01 = getminchargetime(level.player getcurrentweapon());
		var_02 = level.player get_max_charge_time();
		thread player_charged_shot(var_00,var_01,var_02);
	}
}

//Function Number: 7
set_default_hud_parameters()
{
	self.alignx = "left";
	self.aligny = "top";
	self.horzalign = "center";
	self.vertalign = "middle";
	self.hidewhendead = 0;
	self.hidewheninmenu = 0;
	self.sort = 205;
	self.foreground = 1;
	self.alpha = 0.65;
}

//Function Number: 8
player_init_sound()
{
	if(isdefined(self.charged_shot_soundent))
	{
		self.charged_shot_soundent delete();
	}

	self.charged_shot_soundent = common_scripts\utility::spawn_tag_origin();
}

//Function Number: 9
player_do_sound(param_00,param_01,param_02)
{
	self.charged_shot_soundent.origin = self.origin;
	self.charged_shot_soundent.angles = self.angles;
	if(param_01)
	{
		soundscripts\_snd::snd_message("wpn_deam160_charge");
	}

	if(param_02)
	{
		level notify("aud_deam160_charge_break");
	}
}

//Function Number: 10
player_cleanup_sound()
{
	self.charged_shot_soundent stoploopsound();
}

//Function Number: 11
player_init_reticle()
{
	precacheshader("charged_shot_reticle");
	precacheshader("charged_shot_reticle_corner_tl");
	precacheshader("charged_shot_reticle_corner_bl");
	precacheshader("charged_shot_reticle_corner_tr");
	precacheshader("charged_shot_reticle_corner_br");
	self.charged_shot_reticle_corners = [];
	self.charged_shot_reticle = maps\_hud_util::createicon("charged_shot_reticle",16,16);
	self.charged_shot_reticle set_default_hud_parameters();
	self.charged_shot_reticle.alignx = "center";
	self.charged_shot_reticle.aligny = "middle";
	self.charged_shot_reticle_corners["tl"] = maps\_hud_util::createicon("charged_shot_reticle_corner_tl",16,16);
	self.charged_shot_reticle_corners["tl"] set_default_hud_parameters();
	self.charged_shot_reticle_corners["tl"].alignx = "right";
	self.charged_shot_reticle_corners["tl"].aligny = "bottom";
	self.charged_shot_reticle_corners["tr"] = maps\_hud_util::createicon("charged_shot_reticle_corner_tr",16,16);
	self.charged_shot_reticle_corners["tr"] set_default_hud_parameters();
	self.charged_shot_reticle_corners["tr"].alignx = "left";
	self.charged_shot_reticle_corners["tr"].aligny = "bottom";
	self.charged_shot_reticle_corners["bl"] = maps\_hud_util::createicon("charged_shot_reticle_corner_bl",16,16);
	self.charged_shot_reticle_corners["bl"] set_default_hud_parameters();
	self.charged_shot_reticle_corners["bl"].alignx = "right";
	self.charged_shot_reticle_corners["bl"].aligny = "top";
	self.charged_shot_reticle_corners["br"] = maps\_hud_util::createicon("charged_shot_reticle_corner_br",16,16);
	self.charged_shot_reticle_corners["br"] set_default_hud_parameters();
	self.charged_shot_reticle_corners["br"].alignx = "left";
	self.charged_shot_reticle_corners["br"].aligny = "top";
	player_cleanup_reticle();
}

//Function Number: 12
player_do_reticle(param_00,param_01,param_02)
{
	if(param_00 > param_01)
	{
		var_03 = compute_spread(param_00,param_01,param_02);
		var_04 = tan(var_03);
		var_05 = var_04 * 620;
		var_06 = var_04 * 620;
		self.charged_shot_reticle.alpha = 1;
		self.charged_shot_reticle setshader("charged_shot_reticle",int(var_06),int(var_06));
		var_07 = var_04 * 320;
		var_08 = var_04 * 320;
		var_05 = clamp(var_04,16,32);
		var_06 = clamp(var_04,16,24);
		self.charged_shot_reticle_corners["tl"].x = -2 - var_07;
		self.charged_shot_reticle_corners["tl"].y = -2 - var_08;
		self.charged_shot_reticle_corners["tl"].alpha = 1;
		self.charged_shot_reticle_corners["tl"] setshader("charged_shot_reticle_corner_tl",int(var_05),int(var_06));
		self.charged_shot_reticle_corners["tr"].x = 2 + var_07;
		self.charged_shot_reticle_corners["tr"].y = -2 - var_08;
		self.charged_shot_reticle_corners["tr"].alpha = 1;
		self.charged_shot_reticle_corners["tr"] setshader("charged_shot_reticle_corner_tr",int(var_05),int(var_06));
		self.charged_shot_reticle_corners["bl"].x = -2 - var_07;
		self.charged_shot_reticle_corners["bl"].y = 2 + var_08;
		self.charged_shot_reticle_corners["bl"].alpha = 1;
		self.charged_shot_reticle_corners["bl"] setshader("charged_shot_reticle_corner_bl",int(var_05),int(var_06));
		self.charged_shot_reticle_corners["br"].x = 2 + var_07;
		self.charged_shot_reticle_corners["br"].y = 2 + var_08;
		self.charged_shot_reticle_corners["br"].alpha = 1;
		self.charged_shot_reticle_corners["br"] setshader("charged_shot_reticle_corner_br",int(var_05),int(var_06));
		player_set_all_reticle_colors((1,1,1));
		return;
	}

	player_restore_reticle();
}

//Function Number: 13
player_restore_reticle()
{
	self.charged_shot_reticle.alpha = 1;
	self.charged_shot_reticle_corners["tl"].alpha = 1;
	self.charged_shot_reticle_corners["tr"].alpha = 1;
	self.charged_shot_reticle_corners["bl"].alpha = 1;
	self.charged_shot_reticle_corners["br"].alpha = 1;
	self.charged_shot_reticle_corners["tl"].x = -2;
	self.charged_shot_reticle_corners["tl"].y = -2;
	self.charged_shot_reticle_corners["tr"].x = 2;
	self.charged_shot_reticle_corners["tr"].y = -2;
	self.charged_shot_reticle_corners["bl"].x = -2;
	self.charged_shot_reticle_corners["bl"].y = 2;
	self.charged_shot_reticle_corners["br"].x = 2;
	self.charged_shot_reticle_corners["br"].y = 2;
	self.charged_shot_reticle setshader("charged_shot_reticle",16,16);
	self.charged_shot_reticle_corners["tl"] setshader("charged_shot_reticle_corner_tl",16,16);
	self.charged_shot_reticle_corners["bl"] setshader("charged_shot_reticle_corner_bl",16,16);
	self.charged_shot_reticle_corners["tr"] setshader("charged_shot_reticle_corner_tr",16,16);
	self.charged_shot_reticle_corners["br"] setshader("charged_shot_reticle_corner_br",16,16);
	player_set_all_reticle_colors((1,1,1));
}

//Function Number: 14
player_cleanup_reticle()
{
	self.charged_shot_reticle.alpha = 0;
	self.charged_shot_reticle_corners["tl"].alpha = 0;
	self.charged_shot_reticle_corners["tr"].alpha = 0;
	self.charged_shot_reticle_corners["bl"].alpha = 0;
	self.charged_shot_reticle_corners["br"].alpha = 0;
}

//Function Number: 15
player_init_rumble()
{
	self.charged_shot_rumble_ent = common_scripts\utility::spawn_tag_origin();
}

//Function Number: 16
player_do_rumble(param_00,param_01,param_02)
{
	var_03 = maps\_shg_utility::linear_map_clamp(param_00,param_01,param_02,0,0.1);
	if(var_03 > 0)
	{
		if(!isdefined(self.charged_shot_rumble_ent.rumbling))
		{
			self.charged_shot_rumble_ent.rumbling = 1;
			self.charged_shot_rumble_ent playrumblelooponentity("steady_rumble");
		}

		self.charged_shot_rumble_ent.origin = self.origin + (0,0,1 - clamp(var_03,0,1) * 1000);
		return;
	}

	player_cleanup_rumble();
}

//Function Number: 17
player_cleanup_rumble()
{
	if(isdefined(self.charged_shot_rumble_ent.rumbling))
	{
		self.charged_shot_rumble_ent stoprumble("steady_rumble");
		self.charged_shot_rumble_ent.rumbling = undefined;
	}
}

//Function Number: 18
player_init_charge_indicator()
{
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		precacheshader("charged_shot_reticle_pip" + var_00);
	}

	self.charge_indicator_hud = maps\_hud_util::createicon("charged_shot_reticle_pip1",32,32);
	self.charge_indicator_hud set_default_hud_parameters();
	self.charge_indicator_hud.sort = 1;
	self.charge_indicator_hud.horzalign = "fullscreen";
	self.charge_indicator_hud.alignx = "center";
	self.charge_indicator_hud.vertalign = "fullscreen";
	self.charge_indicator_hud.x = 320;
	self.charge_indicator_hud.y = 170;
	self.charge_indicator_hud.color = (1,1,1);
	self.charge_indicator_hud.alpha = 0;
}

//Function Number: 19
player_set_all_reticle_colors(param_00)
{
	self.charge_indicator_hud.color = param_00;
	self.charged_shot_reticle.color = param_00;
	self.charged_shot_reticle_corners["tl"].color = param_00;
	self.charged_shot_reticle_corners["tr"].color = param_00;
	self.charged_shot_reticle_corners["bl"].color = param_00;
	self.charged_shot_reticle_corners["br"].color = param_00;
}

//Function Number: 20
player_color_pulse(param_00)
{
	var_01 = param_00;
	var_02 = 25;
	soundscripts\_snd::snd_message("wpn_deam160_full_charge");
	while(level.player getchargetime() >= get_max_charge_time())
	{
		var_01 = var_01 + var_02;
		var_03 = sin(var_01 - param_00) + 1 * 0.5;
		self.charge_indicator_hud.color = (var_03,var_03,var_03);
		var_02 = min(45,var_02 + 0.5);
		wait 0.05;
	}

	self.charge_indicator_hud.color = (1,1,1);
	level notify("aud_deam160_charge_break");
}

//Function Number: 21
player_do_charge_indicator(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(param_02 > 0)
	{
		var_05 = int(maps\_shg_utility::linear_map_clamp(param_03,0,param_02,0,4));
		var_04 = int(maps\_shg_utility::linear_map_clamp(param_00,0,param_02,0,4));
		if(var_05 < var_04)
		{
			soundscripts\_snd::snd_message("wpn_deam160_charge_dots_increase");
		}
	}

	if(var_04 > 0)
	{
		self.charge_indicator_hud.alpha = 1;
		self.charge_indicator_hud setshader("charged_shot_reticle_pip" + var_04,32,32);
	}
	else
	{
		self.charge_indicator_hud.alpha = 0;
	}

	if(param_00 >= param_02 && param_03 != param_00)
	{
		thread player_color_pulse(param_00);
	}
}

//Function Number: 22
player_cleanup_charge_indicator()
{
	self.charge_indicator_hud.alpha = 0;
}

//Function Number: 23
player_do_camera_shake(param_00,param_01,param_02)
{
	if(param_00 > param_01)
	{
		var_03 = maps\_shg_utility::linear_map_clamp(param_00,param_01,param_02,0.01,0.1);
		earthquake(var_03,0.2,self.origin,512);
	}
}

//Function Number: 24
compute_spread(param_00,param_01,param_02)
{
	return maps\_shg_utility::linear_map_clamp(param_00,param_01,param_02,1,5);
}

//Function Number: 25
play_charged_shot_fx(param_00,param_01,param_02)
{
	var_03 = param_02 - param_01;
	var_04 = param_01 + var_03 * 0.2;
	var_05 = param_02;
	var_06 = self getgunangles();
	var_07 = anglestoforward(var_06);
	var_08 = transformmove(self geteye(),var_06,(0,0,0),(0,0,0),(4,0,-1),(0,0,0))["origin"];
	var_09 = var_08 + 1000 * var_07;
	var_0A = anglestoup(var_06);
	var_0B = anglestoright(var_06);
	var_0C = undefined;
	var_0D = undefined;
	if(param_00 >= var_05)
	{
		var_0C = common_scripts\utility::getfx("charged_shot_impact_high");
		var_0D = common_scripts\utility::getfx("charged_shot_tracer_high");
		soundscripts\_snd::snd_message("wpn_deam160_shot","large");
	}
	else if(param_00 >= var_04)
	{
		var_0C = common_scripts\utility::getfx("charged_shot_impact_med");
		var_0D = common_scripts\utility::getfx("charged_shot_tracer_med");
		soundscripts\_snd::snd_message("wpn_deam160_shot","medium");
	}
	else
	{
		var_0C = common_scripts\utility::getfx("charged_shot_impact_low");
		var_0D = common_scripts\utility::getfx("charged_shot_tracer_low");
		soundscripts\_snd::snd_message("wpn_deam160_shot","small");
	}

	if(isdefined(var_0D))
	{
		playfx(var_0D,var_08,var_07,var_0A);
	}

	if(isdefined(var_0C))
	{
		var_0E = bullettrace(var_08,var_09,0,self,0);
		if(var_0E["fraction"] < 1)
		{
			var_0F = var_0E["position"];
			playfx(var_0C,var_0F,var_0E["normal"]);
		}
	}
}

//Function Number: 26
player_charged_shot(param_00,param_01,param_02)
{
	var_03 = int(maps\_shg_utility::linear_map_clamp(param_00,param_01,param_02,1,5));
	var_04 = maps\_shg_utility::linear_map_clamp(param_00,param_01,param_02,0.1,0.6);
	var_05 = int(var_03 - 1 * 0.5);
	thread play_charged_shot_fx(param_00,param_01,param_02);
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		if(var_06 == var_05)
		{
			earthquake(var_04,var_03 * 0.05 * 4,level.player.origin,100);
		}

		wait 0.05;
	}
}

//Function Number: 27
ai_detect_charged_damage()
{
	var_00 = spawnstruct();
	var_00 endon("end_charged_shot_damage_thread");
	thread ai_charged_shot_wait_for_death(var_00);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(isdefined(self))
		{
			self.last_damage_pos = var_04;
			if(isdefined(var_05) && var_05 == "MOD_ENERGY")
			{
				playfx(common_scripts\utility::getfx("charged_shot_character_smoke"),self.origin);
			}

			if(self.health <= 0)
			{
				break;
			}
		}
	}
}

//Function Number: 28
ai_charged_shot_wait_for_death(param_00)
{
	level.player endon("death");
	self waittill("death");
	wait(0.05);
	param_00 notify("end_charged_shot_damage_thread");
}
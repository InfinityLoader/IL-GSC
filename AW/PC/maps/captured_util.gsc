/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 85
 * Decompile Time: 1222 ms
 * Timestamp: 4/22/2024 2:26:38 AM
*******************************************************************/

//Function Number: 1
warp_to_start(param_00)
{
	var_01 = param_00;
	if(isstring(param_00))
	{
		var_01 = common_scripts\utility::getstruct(param_00,"targetname");
		if(!isdefined(var_01))
		{
			var_01 = getent(param_00,"targetname");
		}
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(self islinked())
	{
		self unlink();
	}

	if(self == level.player)
	{
		self setorigin(var_01.origin);
		level.player setplayerangles(var_01.angles);
		return;
	}

	self forceteleport(var_01.origin,var_01.angles);
}

//Function Number: 2
warp_allies(param_00,param_01,param_02)
{
	if(!isdefined(level.allies) || !isdefined(level.allies.size))
	{
		return;
	}

	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	var_03 = ["r","b","y"];
	if(!isdefined(param_02))
	{
		param_02 = level.allies.size;
	}

	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		level.allies[var_04] thread warp_to_start(param_00 + "_" + var_04);
		if(isdefined(param_01) && param_01)
		{
			level.allies[var_04] maps\_utility::set_force_color(var_03[var_04]);
		}
	}
}

//Function Number: 3
spawn_allies(param_00)
{
	if(!isdefined(param_00))
	{
		if(start_point_is_before("test_chamber"))
		{
			param_00 = 3;
		}
		else if(start_point_is_between(["test_chamber","mb2"],1))
		{
			param_00 = 1;
		}
		else if(start_point_is_after("mb2"))
		{
			param_00 = 2;
		}
		else
		{
			param_00 = 3;
		}
	}

	if(!isdefined(level.allies))
	{
		level.allies = [];
	}
	else if(level.allies.size >= param_00)
	{
		return;
	}

	var_01 = getentarray("spawner_ally","script_noteworthy");
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::spawnfunc_ally);
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		var_03 = getent("ally_" + var_02,"targetname") maps\_utility::spawn_ai();
		var_03.animname = "ally_" + var_02;
		level.allies[var_02] = var_03;
	}

	if(isdefined(level.allies[0]) && isalive(level.allies[0]))
	{
		level.ally = level.allies[0];
	}
}

//Function Number: 4
spawnfunc_ally()
{
	maps\_utility::make_hero();
	maps\_utility::magic_bullet_shield();
}

//Function Number: 5
dialogue_nag_loop(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	self notify("start_nag_loop");
	self endon("start_nag_loop");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 4;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 300;
	}

	var_06 = param_03 - param_02;
	for(;;)
	{
		foreach(var_08 in param_00)
		{
			thread dialogue_nag_player(var_08);
			common_scripts\utility::flag_waitopen("flag_currently_nagging");
			wait(randomfloatrange(param_02,param_03));
			param_03 = min(param_05,param_03 + param_04);
			param_02 = param_03 - var_06;
		}

		wait(0.05);
		param_00 = common_scripts\utility::array_randomize(param_00);
	}
}

//Function Number: 6
dialogue_nag_player(param_00)
{
	common_scripts\utility::flag_set("flag_currently_nagging");
	maps\_utility::dialogue_queue(param_00);
	common_scripts\utility::flag_clear("flag_currently_nagging");
}

//Function Number: 7
radio_dialogue_nag_loop(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	self notify("start_nag_loop");
	self endon("start_nag_loop");
	if(!isdefined(param_02))
	{
		param_02 = 8;
	}

	if(!isdefined(param_03))
	{
		param_03 = 12;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 300;
	}

	var_07 = param_03 - param_02;
	for(;;)
	{
		foreach(var_09 in param_00)
		{
			if(isdefined(param_06))
			{
				common_scripts\utility::flag_clear(param_06);
			}

			maps\_utility::smart_radio_dialogue(var_09);
			if(isdefined(param_06))
			{
				common_scripts\utility::flag_set(param_06);
			}

			wait(randomfloatrange(param_02,param_03));
			param_03 = min(param_05,param_03 + param_04);
			param_02 = param_03 - var_07;
		}

		wait(0.05);
		param_00 = common_scripts\utility::array_randomize(param_00);
	}
}

//Function Number: 8
delay_retreat(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_02))
	{
		thread opfor_retreat(param_00,param_02,param_03);
	}

	common_scripts\utility::flag_wait_or_timeout(param_03,param_01);
	if(common_scripts\utility::flag(param_03) && !isdefined(level.opfor_retreat))
	{
		tprintln("Retreat trigger: " + param_03,1);
		thread retreat_proc(param_03,param_04,param_05);
		return;
	}

	if(!isdefined(level.opfor_retreat))
	{
		tprintln("Retreat timeout: " + param_01 + " | " + param_03,1);
	}

	thread retreat_proc(param_03,param_04,param_05,param_06);
	level.opfor_retreat = undefined;
}

//Function Number: 9
opfor_retreat(param_00,param_01,param_02)
{
	level endon(param_02);
	if(!isarray(param_01))
	{
		param_01 = [int(min(0,param_01)),int(max(-1,param_01))];
	}

	if(param_01[0] < 0)
	{
		for(var_03 = param_01[0];var_03 < 0;var_03++)
		{
			level waittill("ai_killed",var_04);
			tprintln("kills: " + var_03 + 1 + " || " + maps\_utility::get_ai_group_sentient_count(param_00));
			if(!isdefined(var_04.script_aigroup) || var_04.script_aigroup != param_00)
			{
				var_03--;
			}
		}
	}

	if(param_01[1] >= 0)
	{
		while(maps\_utility::get_ai_group_sentient_count(param_00) > param_01[1])
		{
			wait(0.1);
		}
	}

	tprintln("Retreat kills: " + maps\_utility::get_ai_group_sentient_count(param_00) + " | " + param_02,1);
	level.opfor_retreat = 1;
	common_scripts\utility::flag_set(param_02);
}

//Function Number: 10
retreat_proc(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::flag(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}

	if(isdefined(param_01) && !isarray(param_01))
	{
		param_01 = [param_01];
	}

	if(isdefined(param_01))
	{
		var_04 = [];
		foreach(var_06 in param_01)
		{
			var_06 = getent(var_06,"targetname");
			if(isdefined(var_06))
			{
				var_04[var_04.size] = var_06;
			}
		}

		if(var_04.size > 0)
		{
			param_01 = var_04;
		}
		else
		{
			param_01 = undefined;
		}
	}

	if(isdefined(param_01))
	{
		param_01[0] notify("trigger");
		wait(0.05);
		if(isdefined(param_02) && param_02)
		{
			foreach(var_06 in param_01)
			{
				if(isdefined(var_06))
				{
					var_06 delete();
				}
			}
		}
	}

	if(isdefined(param_03) && !isarray(param_03))
	{
		param_03 = [param_03];
	}

	if(isdefined(param_03))
	{
		foreach(var_0B in param_03)
		{
			level notify(var_0B);
		}
	}
}

//Function Number: 11
kt_time(param_00)
{
	if(!isdefined(level.killer_tracker))
	{
		return param_00;
	}

	if(level.killer_tracker > 2)
	{
		return param_00 * clamp(level.killer_tracker - 1,1,5);
	}

	return param_00;
}

//Function Number: 12
setup_player_for_animated_sequence(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		if(!isdefined(param_01))
		{
			param_01 = 60;
		}
	}

	if(!isdefined(param_08))
	{
		param_08 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = level.player.origin;
	}

	if(!isdefined(param_03))
	{
		param_03 = level.player.angles;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = "player_rig";
	}

	var_09 = maps\_utility::spawn_anim_model(param_06,param_02);
	level.player.rig = var_09;
	var_09.angles = param_03;
	var_09.animname = param_06;
	if(isdefined(param_07))
	{
		var_0A = maps\_utility::spawn_anim_model(param_07);
	}
	else
	{
		var_0A = common_scripts\utility::spawn_tag_origin();
	}

	level.player.mover = var_0A;
	var_0A.origin = param_02;
	var_0A.angles = param_03;
	var_09 linkto(var_0A);
	if(param_00)
	{
		if(isarray(param_01))
		{
			level.player playerlinktodelta(var_09,"tag_origin",param_08,param_01[0],param_01[1],param_01[2],param_01[3],1);
		}
		else
		{
			level.player playerlinktodelta(var_09,"tag_origin",param_08,param_01,param_01,param_01,param_01,1);
		}
	}

	if(param_04)
	{
		thread player_animated_sequence_restrictions(param_05);
	}
}

//Function Number: 13
player_animated_sequence_restrictions(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		level.player waittill("notify_player_animated_sequence_restrictions");
	}

	level.player.disablereload = 1;
	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowmelee(0);
	level.player allowprone(0);
	level.player allowsprint(0);
}

//Function Number: 14
player_animated_sequence_cleanup()
{
	if(!isdefined(level.player.early_weapon_enabled) || !level.player.early_weapon_enabled)
	{
		level.player.early_weapon_enabled = undefined;
		level.player.disablereload = 0;
		level.player enableweapons();
		level.player enableoffhandweapons();
		level.player enableweaponswitch();
	}

	level.player allowcrouch(1);
	level.player allowjump(1);
	level.player allowmelee(1);
	level.player allowprone(1);
	level.player allowsprint(1);
	level.player unlink();
	if(isdefined(level.player.mover))
	{
		level.player.mover delete();
	}

	if(isdefined(level.player.rig))
	{
		level.player.rig delete();
	}
}

//Function Number: 15
smooth_player_link(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = [0,0,0,0];
	}
	else if(!isarray(param_02))
	{
		param_02 = [param_02,param_02,param_02,param_02];
	}

	level.player playerlinktoblend(param_00,"tag_player",param_01);
	wait(param_01);
	level.player playerlinktodelta(param_00,"tag_player",1,param_02[0],param_02[1],param_02[2],param_02[3],1);
	param_00 show();
}

//Function Number: 16
anim_set_real_time(param_00,param_01,param_02)
{
	common_scripts\utility::array_thread(param_00,::anim_self_set_real_time,param_01,param_02);
}

//Function Number: 17
anim_self_set_real_time(param_00,param_01)
{
	var_02 = maps\_utility::getanim(param_00);
	var_03 = param_01 / getanimlength(var_02);
	self setanimtime(var_02,var_03);
}

//Function Number: 18
start_one_handed_gunplay(param_00)
{
	self endon("death");
	self notify("stop_one_handed_gunplay");
	self endon("stop_one_handed_gunplay");
	self.melee_threat = -1024;
	self.gun_threat = -512;
	if(!isdefined(param_00))
	{
		param_00 = self getcurrentweapon();
	}

	self disableweaponswitch();
	self setautopickup(0);
	self.one_weap = "init";
	self.one_ammo = 15;
	self.one_frac = 1;
	self.one_time = 0;
	self.ot = [];
	self.ot["gun"] = 5000;
	self.ot["aggro"] = 6000;
	self.ot["flash"] = 10000;
	self.ot["gen"] = 15000;
	self.ot["p_kill"] = 15000;
	self.ot["a_kill"] = 15000;
	level one_handed_help_vo_setup();
	level.player thread one_handed_help_flash_ally_tracker(1000);
	self giveweapon("iw5_mahem_sp");
	thread one_handed_swap_tracking();
	if(issubstr(param_00,"knife"))
	{
		one_handed_switch_to_melee(1);
	}
	else
	{
		one_handed_weapon_check_swap(param_00);
	}

	thread one_handed_pickup_handling();
	thread one_handed_drop_handling();
	thread one_handed_grenade_handling();
	thread one_handed_ammo_tracking();
	thread one_handed_mantle_handling();
	thread one_handed_exododge_handling();
}

//Function Number: 19
one_handed_pickup_handling()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("start_one_handed_pickup_handling");
	self endon("start_one_handed_pickup_handling");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(isdefined(var_00) && var_00 != "none" && var_00 != "iw5_kvahazmatknifeonearm_sp")
		{
			one_handed_weapon_check_swap(var_00);
		}
	}
}

//Function Number: 20
one_handed_drop_handling()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("start_one_handed_drop_handling");
	self endon("start_one_handed_drop_handling");
	for(;;)
	{
		self waittill("pickup",var_00,var_01);
		if(!isdefined(var_00.dropped))
		{
			self notify("one_handed_weapon_swap",1);
		}

		if(!isdefined(var_01))
		{
			tprintln("Bug this if you didn\'t just throw a grenade");
			continue;
		}
		else
		{
			if(!issubstr(var_01.classname,"knife"))
			{
				var_02 = spawn(maps\_utility::string("weapon_" + one_handed_get_base_weapon(var_01.classname)),var_01.origin);
				var_02.angles = var_01.angles;
				var_02.dropped = 1;
				var_02 itemweaponsetammo(self.one_ammo,0);
				var_01 delete();
				if(self.one_frac <= 0.33)
				{
					var_02.low_ammo = 1;
				}

				continue;
			}

			self notify("melee_weapon_dropped");
			var_01 delete();
		}
	}
}

//Function Number: 21
one_handed_grenade_handling()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("start_one_handed_grenade_handling");
	self endon("start_one_handed_grenade_handling");
	for(;;)
	{
		self waittill("grenade_fire");
		var_00 = self getweaponammoclip(self getcurrentweapon());
		var_01 = one_handed_get_base_weapon(self getcurrentweapon());
		if(isdefined(var_01) && issubstr(var_01,"knife"))
		{
			continue;
		}

		if(isdefined(var_01))
		{
			var_02 = vectornormalize(anglestoforward(self.angles));
			var_03 = vectornormalize(anglestoright(self.angles));
			var_04 = self.origin + randomfloatrange(16,24) * var_03 + randomfloatrange(-6,6) * var_02 + (0,0,4);
			var_05 = spawn(maps\_utility::string("weapon_" + var_01),var_04);
			var_05.angles = (0,randomint(360),0);
			var_05 itemweaponsetammo(var_00,0);
		}

		one_handed_switch_to_melee(1);
	}
}

//Function Number: 22
one_handed_ammo_tracking()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("start_one_handed_ammo_tracking");
	self endon("start_one_handed_ammo_tracking");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_notify_or_timeout_return("one_hand_pickup",0.05);
		var_01 = gettime();
		self.one_weap = self getcurrentweapon();
		if(self.one_weap != "none" && self.one_weap != "iw5_kvahazmatknifeonearm_sp")
		{
			var_02 = self.one_frac;
			self.one_ammo = self getammocount(self.one_weap);
			self.one_frac = self.one_ammo / weaponclipsize(self.one_weap);
			if(self.one_ammo <= 0 && !isdefined(self.switch_to_melee))
			{
				if(issubstr(self.one_weap,"titan45"))
				{
					soundscripts\_snd::snd_message("aud_cap_45_onearm_toss");
				}
				else
				{
					soundscripts\_snd::snd_message("aud_cap_sml_onearm_toss");
				}

				thread one_handed_switch_to_melee();
				continue;
			}

			if(var_02 > 0.33 && self.one_frac <= 0.33)
			{
				self.one_time = var_01 + randomintrange(500,2000);
			}

			if(!isdefined(level.one_handed_help))
			{
				continue;
			}

			if(self.one_frac <= 0.33 && var_01 > self.one_time)
			{
				thread one_handed_help_try(var_01);
			}

			continue;
		}

		if(isdefined(level.one_handed_help) && self.one_weap != "none" && var_01 > self.one_time)
		{
			thread one_handed_help_try(gettime(),4000);
		}
	}
}

//Function Number: 23
one_handed_swap_tracking()
{
	self endon("death");
	self notify("stop_one_handed_swap_tracking");
	self endon("stop_one_handed_swap_tracking");
	if(!isdefined(level.swap_num))
	{
		level.swap_num = 0;
	}

	for(;;)
	{
		self waittill("one_handed_weapon_swap",var_00);
		if(isdefined(var_00))
		{
			level.swap_num = level.swap_num + var_00;
		}
		else
		{
			level.swap_num = level.swap_num + 1;
		}

		if(level.swap_num >= 20)
		{
			maps\_utility::giveachievement_wrapper("LEVEL_14A");
			self notify("stop_one_handed_swap_tracking");
		}
	}
}

//Function Number: 24
one_handed_mantle_handling()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("stop_one_handed_mantle_handling");
	self endon("stop_one_handed_mantle_handling");
	for(;;)
	{
		self waittill("foley",var_00);
		var_01 = self getcurrentweapon();
		if(issubstr(var_00,"mantle") && isdefined(self.switch_to_melee) && !issubstr(var_01,"knife"))
		{
			self takeweapon(self getcurrentweapon());
		}
	}
}

//Function Number: 25
one_handed_exododge_handling()
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("stop_one_handed_exododge_handling");
	self endon("stop_one_handed_exododge_handling");
	for(;;)
	{
		self waittill("exo_dodge");
		var_00 = self getcurrentweapon();
		if(isdefined(self.switch_to_melee) && !issubstr(var_00,"knife"))
		{
			self takeweapon(self getcurrentweapon());
		}
	}
}

//Function Number: 26
one_handed_modify_threatbias(param_00)
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	if(isstring(param_00))
	{
		param_00 = tolower(param_00);
		switch(param_00)
		{
			case "stand":
				self.threat_stance = "stand";
				param_00 = -128;
				break;

			case "crouch":
				self.threat_stance = "crouch";
				param_00 = -512;
				break;

			case "prone":
				self.threat_stance = "prone";
				param_00 = -1024;
				break;

			case "none":
				self.threat_stance = "none";
				param_00 = 0;
				break;

			case "standard":
				param_00 = int(1024);
				break;

			case "aggro":
				param_00 = 2048;
				break;

			default:
				param_00 = 0;
				break;
		}
	}

	self.melee_threat = -1024 + param_00;
	self.gun_threat = -512 + param_00;
	if(self.one_weap != "none" && self.one_weap != "iw5_kvahazmatknifeonearm_sp")
	{
		setthreatbias("axis","player",self.gun_threat);
		return;
	}

	setthreatbias("axis","player",self.melee_threat);
}

//Function Number: 27
one_handed_weapon_check_swap(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_00) && !issubstr(param_00,"onearm_sp") || param_00 != self.one_weap)
	{
		var_02 = self getweaponammoclip(param_00);
		if(!isdefined(param_01) || param_01)
		{
			self takeweapon(self getcurrentweapon());
		}

		var_03 = "iw5_titan45onearm_sp_xmags";
		if(issubstr(tolower(param_00),"pbw"))
		{
			var_03 = "iw5_pbwonearm_sp_xmags";
		}
		else if(issubstr(tolower(param_00),"hmr9"))
		{
			var_03 = "iw5_hmr9onearm_sp_xmags";
		}
		else if(issubstr(tolower(param_00),"sn6"))
		{
			var_03 = "iw5_sn6onearm_sp_xmags";
		}

		if(var_02 <= 0)
		{
			var_02 = weaponclipsize(var_03);
		}

		if(!isdefined(param_01) || param_01)
		{
			setthreatbias("axis","player",self.gun_threat);
			self notify("stop_switch_to_melee");
			self.switch_to_melee = undefined;
			self giveweapon(var_03);
			soundscripts\_snd::snd_message("aud_onearm_weapon_swap",var_03);
			self switchtoweapon(var_03);
			self setweaponammostock(var_03,0);
			self setweaponammoclip(var_03,var_02);
			self enablealternatemelee();
		}

		return var_03;
	}

	if(!isdefined(var_03) || var_03)
	{
		setthreatbias("axis","player",self.gun_threat);
		self notify("stop_switch_to_melee");
		self.switch_to_melee = undefined;
		self setweaponammostock(var_02,0);
	}

	return var_02;
}

//Function Number: 28
one_handed_get_base_weapon(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = self getcurrentweapon();
	}

	param_00 = tolower(param_00);
	var_03 = param_02;
	if(issubstr(param_00,"titan45"))
	{
		var_03 = "iw5_titan45pickup_sp_xmags";
	}
	else if(issubstr(param_00,"hmr9"))
	{
		var_03 = "iw5_hmr9pickup_sp_xmags";
	}
	else if(issubstr(param_00,"sn6"))
	{
		var_03 = "iw5_sn6pickup_sp_xmags";
	}
	else if(issubstr(param_00,"knife") && !isdefined(param_01) || !param_01)
	{
		var_03 = "iw5_kvahazmatknife_sp";
	}

	return var_03;
}

//Function Number: 29
one_handed_switch_to_melee(param_00)
{
	self endon("death");
	self endon("stop_switch_to_melee");
	self notify("start_one_handed_switch_to_melee");
	self endon("start_one_handed_switch_to_melee");
	if(isdefined(param_00) && !param_00)
	{
		param_00 = undefined;
	}

	self notify("bullet_weapon_dropped");
	setthreatbias("axis","player",self.melee_threat);
	self giveweapon("iw5_kvahazmatknifeonearm_sp");
	self switchtoweapon("iw5_kvahazmatknifeonearm_sp");
	self.switch_to_melee = 1;
	while(!isdefined(param_00) && !issubstr(self getcurrentweapon(),"knife"))
	{
		wait(0.05);
	}

	self.switch_to_melee = undefined;
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(var_03 != "iw5_kvahazmatknifeonearm_sp" && var_03 != "iw5_mahem_sp" && var_03 != "flash_grenade")
		{
			self takeweapon(var_03);
		}
	}
}

//Function Number: 30
one_handed_melee_take_weapon(param_00)
{
	self endon("death");
	self notify("stop_switch_to_melee");
	wait(0.5);
	var_01 = one_handed_weapon_check_swap(param_00,0);
	setthreatbias("axis","player",self.gun_threat);
	self.switch_to_melee = undefined;
	self takeweapon("iw5_kvahazmatknifeonearm_sp");
	self giveweapon(var_01);
	self switchtoweapon(var_01);
	self setweaponammostock(var_01,0);
	self setweaponammoclip(var_01,int(randomfloatrange(0.5,1) * weaponclipsize(var_01)));
	self notify("one_handed_weapon_swap",1);
}

//Function Number: 31
one_handed_help_try(param_00,param_01)
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	if(!common_scripts\utility::flag("flag_one_handed_help_try"))
	{
		common_scripts\utility::flag_set("flag_one_handed_help_try");
	}
	else
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = gettime();
	}

	if(!isdefined(param_01))
	{
		param_01 = 6000;
	}

	if(param_00 > self.ot["gun"] && common_scripts\utility::cointoss() && level.ally one_handed_help_gun())
	{
		self.one_time = param_00 + param_01;
		self.ot["gun"] = param_00 + 10000;
		common_scripts\utility::flag_clear("flag_one_handed_help_try");
		return 1;
	}

	if(param_00 > self.ot["aggro"] && common_scripts\utility::cointoss() && level.ally one_handed_help_aggro())
	{
		self.one_time = param_00 + param_01;
		self.ot["aggro"] = param_00 + 12000;
		common_scripts\utility::flag_clear("flag_one_handed_help_try");
		return 1;
	}

	if(param_00 > self.ot["flash"] && common_scripts\utility::cointoss() && level.ally one_handed_help_flash())
	{
		self.one_time = param_00 + param_01;
		self.ot["flash"] = param_00 + 20000;
		common_scripts\utility::flag_clear("flag_one_handed_help_try");
		return 1;
	}

	if(param_00 > self.ot["gen"] && common_scripts\utility::cointoss() && level.ally one_handed_help_gen())
	{
		self.one_time = param_00 + param_01 / 2;
		self.ot["gen"] = param_00 + 15000;
		common_scripts\utility::flag_clear("flag_one_handed_help_try");
		return 1;
	}

	common_scripts\utility::flag_clear("flag_one_handed_help_try");
	return 0;
}

//Function Number: 32
one_handed_help_flash_ally_tracker(param_00)
{
	self endon("death");
	self endon("stop_one_handed_gunplay");
	self notify("start_one_handed_help_flash_ally_tracker");
	self endon("start_one_handed_help_flash_ally_tracker");
	self.ot["ally_seen"] = gettime();
	self.ot["vis_delay"] = param_00;
	for(;;)
	{
		wait(0.1);
		var_01 = gettime();
		var_02 = self.ot["flash"] - self.ot["vis_delay"];
		if(var_02 > var_01)
		{
			wait(var_02 - var_01 / 1000);
			continue;
		}

		if(isdefined(level.ally))
		{
			if(maps\_utility::player_can_see_ai(level.ally))
			{
				self.ot["ally_seen"] = var_01;
			}
		}
	}
}

//Function Number: 33
one_handed_help_gun()
{
	self endon("death");
	var_00 = [];
	foreach(var_02 in getweaponarray())
	{
		if(!isdefined(var_02.low_ammo))
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = common_scripts\utility::getclosest(level.player.origin,var_00,128);
	if(isdefined(var_04) && level.player get_player_speed() < 24)
	{
		var_05 = weaponclass(getsubstr(var_04.classname,7));
		var_06 = level.player get_relative_direction(var_04);
		var_07 = randomint(level.one_vo[var_05][var_06].size);
		maps\_utility::smart_dialogue(level.one_vo[var_05][var_06][var_07]);
		return 1;
	}

	var_07 = common_scripts\utility::getclosest(self.origin,var_03,128);
	if(isdefined(var_07) && self.a.state != "move" && maps\_utility::player_can_see_ai(self))
	{
		var_05 = weaponclass(getsubstr(var_07.classname,7));
		var_07 = randomint(level.one_vo[var_07]["ally"].size);
		maps\_utility::smart_dialogue(level.one_vo[var_06]["ally"][var_07]);
		return 1;
	}

	return 0;
}

//Function Number: 34
one_handed_help_gen()
{
	self endon("death");
	if(!maps\_utility::player_can_see_ai(self) && randomint(10) < 7)
	{
		return 0;
	}

	var_00 = [];
	if(level.player.one_weap != "none" && level.player.one_weap != "iw5_kvahazmatknifeonearm_sp")
	{
		var_00 = ["cap_gdn_goodonammo","cap_gdn_goodonammo","cap_gdn_checkyourammo","cap_gdn_checkyourammo","cap_gdn_checkyourammo"];
	}

	if(distancesquared(level.ally.origin,level.player.origin) < 65536)
	{
		var_00 = ["cap_gdn_hangintheremitchell","cap_gdn_weregonnamakeit"];
	}

	if(self cansee(level.player) && level.player.one_weap == "iw5_kvahazmatknifeonearm_sp")
	{
		var_00 = common_scripts\utility::array_combine(var_00,["cap_gdn_youreouttimeto"]);
	}

	if(var_00.size > 0)
	{
		level.ally maps\_utility::smart_dialogue(common_scripts\utility::random(var_00));
		return 1;
	}

	return 0;
}

//Function Number: 35
one_handed_help_flash()
{
	if(animscripts\combat::waitforstancechange())
	{
		return 0;
	}

	var_00 = common_scripts\utility::get_array_of_closest(level.player.origin,getaiarray("axis"),undefined,undefined,1024,192);
	if(self.grenadeammo < 1)
	{
		maps\_utility::set_grenadeammo(100);
	}

	var_01 = undefined;
	if(!isdefined(self.a) || !isdefined(self.a.array))
	{
		return 0;
	}
	else if(isdefined(self.a.array["grenade_exposed"]))
	{
		var_01 = self.a.array["grenade_exposed"];
	}
	else if(isdefined(self.a.array["exposed_grenade"]))
	{
		var_01 = self.a.array["exposed_grenade"];
	}
	else
	{
		return 0;
	}

	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	var_02 = animscripts\combat_utility::getgrenadethrowoffset(var_01);
	if(level.player.ot["ally_seen"] + level.player.ot["vis_delay"] > gettime())
	{
		return 0;
	}

	var_03 = undefined;
	self.script_forcegrenade = 1;
	foreach(var_05 in var_00)
	{
		if(self cansee(var_05))
		{
			var_03 = self magicgrenade(self.origin + var_02,var_05 getshootatpos(),2);
		}

		if(isdefined(var_03))
		{
			break;
		}
	}

	self.script_forcegrenade = 0;
	if(self.grenadeammo > 10)
	{
		maps\_utility::set_grenadeammo(0);
	}

	if(!isdefined(var_03))
	{
		return 0;
	}

	thread animscripts\door::teamflashbangimmune();
	thread maps\_utility::smart_dialogue(common_scripts\utility::random(["cap_gdn_flashouttakecover","cap_gdn_throwingflash"]));
	return 1;
}

//Function Number: 36
getappropanim(param_00)
{
}

//Function Number: 37
ally_one_handed_grenade_proc()
{
	level.player endon("stop_one_handed_gunplay");
	self endon("death");
	self notify("stop_ally_grenade_help");
	self endon("stop_ally_grenade_help");
	for(;;)
	{
		level.player common_scripts\utility::waittill_notify_or_timeout("bullet_weapon_dropped",randomfloat(1));
		if(getthreatbias("axis","player") > -1024)
		{
			continue;
		}

		var_00 = common_scripts\utility::get_array_of_closest(level.player.origin,getaiarray("axis"),undefined,undefined,1024,192);
		if(self.grenadeammo < 1)
		{
			maps\_utility::set_grenadeammo(1);
		}

		var_01 = undefined;
		if(isdefined(self.a.array["grenade_exposed"]))
		{
			var_01 = self.a.array["grenade_exposed"];
		}
		else if(isdefined(self.a.array["exposed_grenade"]))
		{
			var_01 = self.a.array["exposed_grenade"];
		}

		if(isdefined(var_01) && isarray(var_01))
		{
			var_01 = var_01[randomint(var_01.size)];
		}

		var_02 = animscripts\combat_utility::getgrenadethrowoffset(var_01);
		var_03 = 0;
		self.script_forcegrenade = 1;
		foreach(var_05 in var_00)
		{
			animscripts\combat_utility::setactivegrenadetimer(var_05);
			var_03 = animscripts\combat_utility::trygrenadethrow(var_05,var_05 getshootatpos(),var_01,var_02,1,0,1);
			if(var_03)
			{
				if(self.grenadeweapon == "flash_grenade")
				{
					self notify("flashbang_thrown");
				}

				self.teamflashbangimmunity = 1;
				maps\_utility::anim_stopanimscripted();
				self notify("move_interrupt");
				self.update_move_anim_type = undefined;
				self.a.movement = "stop";
				common_scripts\utility::waittill_any("done_grenade_throw","killanimscript");
				thread animscripts\move::restartmoveloop(1);
				maps\_utility::set_force_color("r");
				break;
			}
		}

		self.script_forcegrenade = 0;
		if(var_03)
		{
			wait(randomfloatrange(8,10));
			self.teamflashbangimmunity = undefined;
			continue;
		}

		wait(0.25);
	}
}

//Function Number: 38
one_handed_help_aggro()
{
	self endon("death");
	var_00 = [];
	foreach(var_02 in common_scripts\utility::get_array_of_closest(level.player.origin,getaiarray("axis"),undefined,undefined,384))
	{
		if(isplayer(var_02.enemy))
		{
			var_00[var_00.size] = var_02;
		}
	}

	foreach(var_02 in var_00)
	{
		if(self cansee(var_02))
		{
			self.aggressivemode = 1;
			maps\_utility::set_favoriteenemy(var_02);
			var_02 thread opfor_help_aggro();
			return 1;
		}
	}

	return 0;
}

//Function Number: 39
opfor_help_aggro()
{
	self endon("aggro_cleanup");
	thread opfor_help_aggro_cleanup(5);
	self.aggro_target = 1;
	self.health = 1;
	self waittill("death",var_00);
	level.ally.aggressivemode = undefined;
	if(!isdefined(var_00) || isplayer(var_00))
	{
		return;
	}

	wait(randomfloatrange(0.25,0.75));
	level.ally maps\_utility::smart_dialogue(common_scripts\utility::random(["cap_gdn_gotyourback","cap_gdn_igotchamitchell","cap_gdn_thankmelater"]));
}

//Function Number: 40
opfor_help_aggro_cleanup(param_00)
{
	self endon("death");
	wait(param_00);
	self.aggro_target = undefined;
	self.health = 100;
	level.player.ot["aggro"] = 0;
	level.ally.aggressivemode = undefined;
	level.ally maps\_utility::set_favoriteenemy(undefined);
	self notify("aggro_cleanup");
}

//Function Number: 41
get_player_speed()
{
	self endon("death");
	var_00 = self getentityvelocity();
	return sqrt(squared(var_00[0]) + squared(var_00[1]));
}

//Function Number: 42
get_relative_direction(param_00)
{
	var_01 = vectortoangles(vectornormalize(anglestoforward(animscripts\battlechatter::getrelativeangles(self))));
	var_02 = vectortoangles(param_00.origin - self.origin);
	var_03 = int(var_01[1] - var_02[1] + 360) % 360;
	if(var_03 > 315 || var_03 < 45)
	{
		return "twelve";
	}

	if(var_03 > 225)
	{
		return "nine";
	}

	if(var_03 > 135)
	{
		return "six";
	}

	return "three";
}

//Function Number: 43
one_handed_help_vo_setup()
{
	if(isdefined(level.one_vo))
	{
		return;
	}

	var_00 = [];
	var_00["smg"] = [];
	var_00["pistol"] = [];
	var_00["pistol"]["twelve"] = ["cap_gdn_pistolatyour12","cap_gdn_weaponatyour12"];
	var_00["pistol"]["nine"] = ["cap_gdn_pistolatyour9","cap_gdn_weaponatyour9"];
	var_00["pistol"]["six"] = ["cap_gdn_pistolatyour6","cap_gdn_weaponatyour6"];
	var_00["pistol"]["three"] = ["cap_gdn_pistolatyour3","cap_gdn_weaponatyour3"];
	var_00["smg"]["twelve"] = ["cap_gdn_smgatyour12","cap_gdn_weaponatyour12"];
	var_00["smg"]["nine"] = ["cap_gdn_smgatyour9","cap_gdn_weaponatyour9"];
	var_00["smg"]["six"] = ["cap_gdn_smgatyour6","cap_gdn_weaponatyour6"];
	var_00["smg"]["three"] = ["cap_gdn_smgatyour3","cap_gdn_weaponatyour3"];
	var_00["pistol"]["ally"] = ["cap_gdn_foundapistol","cap_gdn_pistolhere","cap_gdn_weaponsoverhere","cap_gdn_extragunsheremitchell"];
	var_00["smg"]["ally"] = ["cap_gdn_foundansmg","cap_gdn_smghere","cap_gdn_weaponsoverhere","cap_gdn_extragunsheremitchell"];
	level.one_vo = var_00;
}

//Function Number: 44
opfor_death_mod()
{
	self endon("stop_opfor_one_handed");
	level.player endon("stop_one_handed_gunplay");
	self waittill("death",var_00,var_01,var_02);
	var_03 = self.enemy;
	if(!isdefined(var_03))
	{
		var_03 = self;
	}

	if(isremovedentity(self))
	{
		return;
	}

	maps\_utility::place_weapon_on(one_handed_get_base_weapon(self.weapon,1,"iw5_titan45onearmgundown_sp_xmags"),"right");
	if(isplayer(var_00) && var_02 == "iw5_kvahazmatknifeonearm_sp")
	{
		self notify("opfor_melee_kill");
		self.dropweapon = 0;
		level.player one_handed_melee_take_weapon(self.weapon);
	}

	if(!isdefined(level.one_handed_help))
	{
		return 0;
	}

	wait(randomfloatrange(0.25,0.75));
	var_04 = gettime();
	if(var_04 > level.player.ot["p_kill"] && isplayer(var_00) && var_03 == level.ally && common_scripts\utility::cointoss())
	{
		level.player.ot["p_kill"] = var_04 + 15000;
		level.ally maps\_utility::smart_dialogue(common_scripts\utility::random(["cap_gdn_goodshot","cap_gdn_thanksforthesave"]));
		return;
	}

	if(var_04 > level.player.ot["a_kill"] && var_04 > level.player.one_time && isplayer(var_03) && var_00 == level.ally && common_scripts\utility::cointoss())
	{
		level.player.ot["a_kill"] = var_04 + 15000;
		level.ally maps\_utility::smart_dialogue(common_scripts\utility::random(["cap_gdn_thankmelater","cap_gdn_gotyourback","cap_gdn_igotchamitchell"]));
	}
}

//Function Number: 45
opfor_ammo_drop_mod()
{
	self endon("stop_opfor_one_handed");
	level.player endon("stop_one_handed_gunplay");
	self endon("opfor_melee_kill");
	self waittill("weapon_dropped",var_00);
	wait(0.05);
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getsubstr(var_00.classname,7);
	if(isdefined(self.dropweapon) && !self.dropweapon)
	{
		var_00 delete();
		return;
	}

	if(weaponclass(var_01) == "pistol" || weaponclass(var_01) == "smg")
	{
		var_00 itemweaponsetammo(int(randomfloatrange(0.7,1) * weaponclipsize(var_01)),0);
		return;
	}

	var_00 delete();
}

//Function Number: 46
door_setup(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isstring(param_00))
	{
		var_03 = getent(param_00,"targetname");
	}
	else
	{
		var_03 = param_00;
	}

	if(var_03.classname != "script_model" && var_03.classname != "script_brushmodel")
	{
	}

	var_04 = undefined;
	if(isdefined(var_03.target))
	{
		var_05 = getentarray(var_03.target,"targetname");
		foreach(var_07 in var_05)
		{
			if(var_07.classname == "script_brushmodel")
			{
				var_04 = var_07;
				continue;
			}

			if(var_07.classname == "script_origin")
			{
				if(!isdefined(param_02))
				{
					var_03.hinge = var_07;
					var_03.hinge.tag_name = param_02;
					var_03 linkto(var_03.hinge);
				}
			}
		}
	}

	if(isdefined(param_02))
	{
		var_03.hinge = common_scripts\utility::spawn_tag_origin();
		var_03.hinge.origin = var_03 gettagorigin(param_02);
		var_03.hinge.angles = var_03 gettagangles(param_02);
		if(!isdefined(param_01))
		{
			var_03 linkto(var_03.hinge);
		}
	}

	if(isdefined(var_04))
	{
		var_03.col_brush = var_04;
		if(isdefined(param_02))
		{
			var_03.col_brush linkto(var_03,param_02);
		}
		else
		{
			var_03.col_brush linkto(var_03);
		}
	}
	else if(var_03.classname == "script_brushmodel")
	{
		var_03.col_brush = var_03;
	}

	var_03.original_angles = var_03.angles;
	if(isdefined(param_01))
	{
		var_03 maps\_utility::assign_animtree(param_01);
	}

	return var_03;
}

//Function Number: 47
door_close(param_00,param_01,param_02)
{
	var_03 = self;
	if(isdefined(self._lastanimtime))
	{
		self._lastanimtime = undefined;
		self stopuseanimtree();
	}

	var_04 = undefined;
	if(isdefined(var_03.hinge))
	{
		if(!var_03 islinked())
		{
			var_03 linkto(var_03.hinge);
		}

		var_04 = var_03.hinge;
	}
	else
	{
		var_04 = var_03;
	}

	var_05 = 0.05;
	if(isdefined(param_01))
	{
		var_05 = param_01;
	}

	if(isdefined(param_00))
	{
		var_04 rotateyaw(param_00,var_05);
	}
	else
	{
		var_04 rotateto(var_03.original_angles,var_05);
	}

	if(isdefined(param_02))
	{
		wait(param_02);
	}
	else
	{
		wait(var_05);
	}

	if(isdefined(var_03.col_brush))
	{
		var_03.col_brush disconnectpaths();
	}
}

//Function Number: 48
door_open(param_00,param_01,param_02)
{
	var_03 = self;
	if(isdefined(self._lastanimtime))
	{
		self._lastanimtime = undefined;
		self stopuseanimtree();
	}

	var_04 = undefined;
	if(isdefined(var_03.hinge))
	{
		if(!var_03 islinked())
		{
			var_03 linkto(var_03.hinge);
		}

		var_04 = var_03.hinge;
	}
	else
	{
		var_04 = var_03;
	}

	var_05 = undefined;
	var_06 = undefined;
	if(isarray(param_00))
	{
		var_05 = param_00[0];
		var_06 = param_00[1];
	}
	else
	{
		var_05 = param_00;
	}

	var_07 = 0.05;
	if(isdefined(param_01))
	{
		var_07 = param_01;
	}

	var_04 rotateyaw(var_05,var_07);
	if(isdefined(param_02))
	{
		wait(param_02);
	}
	else
	{
		wait(var_07);
	}

	if(isdefined(var_03.col_brush))
	{
		var_03.col_brush connectpaths();
	}

	if(isdefined(param_02) && param_02 < var_07)
	{
		wait(var_07 - param_02);
	}

	wait(0.05);
	if(isdefined(var_06))
	{
		var_04 rotateyaw(var_06,2.5,0.05,2.45);
	}
}

//Function Number: 49
door_lower(param_00,param_01,param_02)
{
	self moveto(param_00,param_01);
	if(isdefined(param_02))
	{
		wait(param_02);
	}
	else
	{
		wait(param_01);
	}

	self.col_brush disconnectpaths();
}

//Function Number: 50
door_raise(param_00,param_01,param_02)
{
	self moveto(param_00,param_01);
	if(isdefined(param_02))
	{
		wait(param_02);
	}
	else
	{
		wait(param_01);
	}

	self.col_brush connectpaths();
}

//Function Number: 51
captured_caravan_spawner(param_00,param_01,param_02,param_03,param_04)
{
	level endon("stop_caravan_spawner");
	if(level.currentgen)
	{
		if(isdefined(param_04))
		{
			var_05 = tff_get_zone_cleanup_notify(param_04);
			if(var_05 != "")
			{
				level endon(var_05);
			}
		}
	}

	var_06 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 2;
	}

	if(!isdefined(param_03))
	{
		param_03 = 3;
	}

	for(;;)
	{
		var_07 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
		if(level.currentgen)
		{
			if(isdefined(param_04))
			{
				var_07 thread tff_cleanup_vehicle(param_04);
			}
		}

		var_07 thread captured_caravan_truck_remover();
		wait(randomfloatrange(param_02,param_03));
		if(param_00 == "intro_drive_trucks")
		{
			thread soundscripts\_snd::snd_message("aud_intro_caravan_passby");
		}

		if(isdefined(param_01))
		{
			if(var_06 >= param_01)
			{
				break;
			}

			var_06 = var_06 + 1;
		}
	}
}

//Function Number: 52
captured_caravan_truck_remover(param_00)
{
	self waittill("reached_end_node");
	self delete();
}

//Function Number: 53
debug_show_pos(param_00,param_01,param_02,param_03)
{
	self notify("stop_debug_show_pos");
	self endon("stop_debug_show_pos");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 8;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	for(;;)
	{
		self notify("stop_circle");
		maps\_utility::draw_circle_until_notify(self.origin,param_00,param_01,param_02,param_03,self,"stop_circle");
		wait(0.05);
	}
}

//Function Number: 54
debug_text(param_00,param_01)
{
	self notify("stop_debug_show_pos");
	self endon("stop_debug_show_pos");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = (1,1,1);
	}

	if(isdefined(param_01))
	{
		thread maps\_utility::notify_delay("stop_debug_show_pos",param_01);
	}

	wait(0.05);
}

//Function Number: 55
debug_show_pos_once(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = 8;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	maps\_utility::draw_circle_until_notify(param_00,param_01,param_02,param_03,param_04,level,param_05);
	wait(0.05);
}

//Function Number: 56
debug_show_vec(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,0,0);
	}

	if(!isdefined(param_03))
	{
		var_07 = 100;
	}

	if(isdefined(param_04))
	{
		thread maps\_debug::print3ddraw(param_00,param_04,param_02,param_05,param_06);
	}

	thread maps\_debug::drawarrow(param_00,param_01,param_02,param_03);
	wait(0.05 * param_03);
	self notify("stop_print3ddraw");
}

//Function Number: 57
mission_timer()
{
	if(!getdvarint("timer_enabled"))
	{
		return;
	}

	var_00 = 1;
	level.time_array = [];
	level.location_array = [];
	level.display_array = [];
	level.time_display_array = [];
	var_01 = mission_timer_hud_creator(10,420);
	var_01 settimerstatic(var_00);
	for(;;)
	{
		var_02 = level.location_array.size;
		for(;;)
		{
			wait(1);
			var_01 settimerstatic(var_00);
			if(var_02 != level.location_array.size)
			{
				level.time_array[level.time_array.size] = var_00;
				var_00 = var_00 + 1;
				break;
			}

			var_00 = var_00 + 1;
		}

		if(level.location_array[level.location_array.size - 1] == "end")
		{
			break;
		}
	}

	level notify("new_event_message");
	var_03 = mission_timer_hud_creator(380,30);
	var_03 settext("Event Timings");
	var_04 = 0;
	foreach(var_06 in level.display_array)
	{
		var_06 settext(level.location_array[var_04] + " " + "=");
		var_04 = var_04 + 1;
	}

	var_04 = 0;
	foreach(var_09 in level.time_display_array)
	{
		var_09 settimerstatic(level.time_array[var_04]);
		var_04 = var_04 + 1;
	}
}

//Function Number: 58
mission_timer_event(param_00)
{
	if(!getdvarint("timer_enabled"))
	{
		return;
	}

	level.location_array[level.location_array.size] = param_00;
	var_01 = level.location_array.size;
	var_02 = var_01 * 20;
	var_02 = var_02 + 50;
	while(level.time_array.size != level.location_array.size)
	{
		wait(0.05);
	}

	var_03 = mission_timer_hud_creator(300,var_02);
	level.display_array[level.display_array.size] = var_03;
	var_03 = mission_timer_hud_creator(400,var_02);
	level.time_display_array[level.time_display_array.size] = var_03;
}

//Function Number: 59
mission_timer_hud_creator(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = param_00;
	var_02.y = param_01;
	var_02.sort = 0;
	var_02.alignx = "right";
	var_02.aligny = "middle";
	var_02.fontscale = 2;
	var_02.font = "objective";
	var_02.color = (1,1,1);
	return var_02;
}

//Function Number: 60
waittill_entity_activate_looking_at(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0.5;
	if(isdefined(param_04))
	{
		var_0A = param_04;
	}

	var_0B = 64;
	if(isdefined(param_03))
	{
		var_0B = param_03;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}
	else
	{
		param_05 = 0;
	}

	var_0C = param_00;
	if(isdefined(param_06))
	{
		var_0C = param_00 common_scripts\utility::spawn_tag_origin();
		var_0C linkto(param_00,param_06,(0,0,0),(0,0,0));
	}

	if(!isdefined(param_07))
	{
		param_07 = 5;
	}

	if(isdefined(param_02))
	{
		var_0D = param_02;
	}
	else
	{
		var_0D = "flag_waittill_entity_activate_looking_at";
	}

	if(!common_scripts\utility::flag_exist(var_0D))
	{
		common_scripts\utility::flag_init(var_0D);
	}

	var_0E = 0;
	var_0F = 0;
	for(;;)
	{
		if(isdefined(param_09))
		{
			common_scripts\utility::flag_wait(param_09);
		}

		if((isdefined(param_01) && param_01 != "melee" && level.player meleebuttonpressed()) || level.player isthrowinggrenade() || !level.player isonground() || level.player getstance() == "prone")
		{
			common_scripts\utility::flag_clear(var_0D);
			var_0F = 0;
			level.player enableweaponpickup();
		}
		else if(level.player maps\_utility::player_looking_at(var_0C.origin,var_0A,1))
		{
			var_10 = undefined;
			if(param_05)
			{
				var_10 = level.player geteye();
			}
			else
			{
				var_10 = level.player.origin;
			}

			if(isdefined(param_08))
			{
				if(common_scripts\utility::flag(param_08))
				{
					if(!common_scripts\utility::flag(var_0D))
					{
						var_0E = 1;
					}
				}
				else
				{
					common_scripts\utility::flag_clear(var_0D);
					var_0F = 0;
					level.player enableweaponpickup();
				}
			}
			else if(distance(var_10,var_0C.origin) <= var_0B)
			{
				if(!common_scripts\utility::flag(var_0D))
				{
					var_0E = 1;
				}
			}
			else
			{
				common_scripts\utility::flag_clear(var_0D);
				var_0F = 0;
				level.player enableweaponpickup();
			}
		}
		else
		{
			common_scripts\utility::flag_clear(var_0D);
			var_0F = 0;
			level.player enableweaponpickup();
		}

		if(isdefined(param_01))
		{
			if(param_01 == "melee" && level.player meleebuttonpressed())
			{
				var_0F++;
			}
		}
		else if(level.player usebuttonpressed())
		{
			var_0F++;
		}

		if(common_scripts\utility::flag(var_0D) && var_0F >= param_07)
		{
			break;
		}

		if(var_0E)
		{
			common_scripts\utility::flag_set(var_0D);
			if(isdefined(param_02))
			{
				maps\_utility::display_hint_timeout(param_02);
			}

			var_0E = 0;
			level.player disableweaponpickup();
		}

		wait(0.05);
	}

	level.player enableweaponpickup();
	common_scripts\utility::flag_clear(var_0D);
	if(isdefined(param_06))
	{
		var_0C delete();
	}
}

//Function Number: 61
ignore_everything()
{
	if(isdefined(self.script_drone))
	{
		return;
	}

	if(isdefined(self._ignore_settings_old))
	{
		unignore_everything();
	}

	self._ignore_settings_old = [];
	self.disableplayeradsloscheck = save_ignore_setting(self.disableplayeradsloscheck,"disableplayeradsloscheck",1);
	self.ignoreall = save_ignore_setting(self.ignoreall,"ignoreall",1);
	self.ignoreme = save_ignore_setting(self.ignoreme,"ignoreme",1);
	self.grenadeawareness = save_ignore_setting(self.grenadeawareness,"grenadeawareness",0);
	self.ignoreexplosionevents = save_ignore_setting(self.ignoreexplosionevents,"ignoreexplosionevents",1);
	self.ignorerandombulletdamage = save_ignore_setting(self.ignorerandombulletdamage,"ignorerandombulletdamage",1);
	self.ignoresuppression = save_ignore_setting(self.ignoresuppression,"ignoresuppression",1);
	self.dontavoidplayer = save_ignore_setting(self.dontavoidplayer,"dontavoidplayer",1);
	self.newenemyreactiondistsq = save_ignore_setting(self.newenemyreactiondistsq,"newEnemyReactionDistSq",0);
	self.disablebulletwhizbyreaction = save_ignore_setting(self.disablebulletwhizbyreaction,"disableBulletWhizbyReaction",1);
	self.disablefriendlyfirereaction = save_ignore_setting(self.disablefriendlyfirereaction,"disableFriendlyFireReaction",1);
	self.dontmelee = save_ignore_setting(self.dontmelee,"dontMelee",1);
	self.flashbangimmunity = save_ignore_setting(self.flashbangimmunity,"flashBangImmunity",1);
	self.dodangerreact = save_ignore_setting(self.dodangerreact,"doDangerReact",0);
	self.neversprintforvariation = save_ignore_setting(self.neversprintforvariation,"neverSprintForVariation",1);
	self.a.disablepain = save_ignore_setting(self.a.disablepain,"a.disablePain",1);
	self.allowpain = save_ignore_setting(self.allowpain,"allowPain",0);
	self.ignoresonicaoe = save_ignore_setting(self.ignoresonicaoe,"IgnoreSonicAoE",1);
	self pushplayer(1);
}

//Function Number: 62
save_ignore_setting(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		self._ignore_settings_old[param_01] = param_00;
	}
	else
	{
		self._ignore_settings_old[param_01] = "none";
	}

	return param_02;
}

//Function Number: 63
unignore_everything(param_00)
{
	if(isremovedentity(self))
	{
		return;
	}

	if(isdefined(self.script_drone))
	{
		return;
	}

	if(isdefined(param_00) && param_00)
	{
		if(isdefined(self._ignore_settings_old))
		{
			self._ignore_settings_old = undefined;
		}
	}

	self.disableplayeradsloscheck = restore_ignore_setting("disableplayeradsloscheck",0);
	self.ignoreall = restore_ignore_setting("ignoreall",0);
	self.ignoreme = restore_ignore_setting("ignoreme",0);
	self.grenadeawareness = restore_ignore_setting("grenadeawareness",1);
	self.ignoreexplosionevents = restore_ignore_setting("ignoreexplosionevents",0);
	self.ignorerandombulletdamage = restore_ignore_setting("ignorerandombulletdamage",0);
	self.ignoresuppression = restore_ignore_setting("ignoresuppression",0);
	self.dontavoidplayer = restore_ignore_setting("dontavoidplayer",0);
	self.newenemyreactiondistsq = restore_ignore_setting("newEnemyReactionDistSq",262144);
	self.disablebulletwhizbyreaction = restore_ignore_setting("disableBulletWhizbyReaction",undefined);
	self.disablefriendlyfirereaction = restore_ignore_setting("disableFriendlyFireReaction",undefined);
	self.dontmelee = restore_ignore_setting("dontMelee",undefined);
	self.flashbangimmunity = restore_ignore_setting("flashBangImmunity",undefined);
	self.dodangerreact = restore_ignore_setting("doDangerReact",1);
	self.neversprintforvariation = restore_ignore_setting("neverSprintForVariation",undefined);
	self.a.disablepain = restore_ignore_setting("a.disablePain",0);
	self.allowpain = restore_ignore_setting("allowPain",1);
	self._ignore_settings_old = undefined;
}

//Function Number: 64
restore_ignore_setting(param_00,param_01)
{
	if(isdefined(self._ignore_settings_old))
	{
		if(isstring(self._ignore_settings_old[param_00]) && self._ignore_settings_old[param_00] == "none")
		{
			return param_01;
		}
		else
		{
			return self._ignore_settings_old[param_00];
		}
	}

	return param_01;
}

//Function Number: 65
cap_civilian_damage_proc(param_00)
{
	level endon("start_autopsy_enter");
	level.captured_mission_failed = "";
	self.no_friendly_fire_penalty = 1;
	if(isdefined(param_00))
	{
		self.health = param_00;
	}
	else
	{
		self.health = 300;
	}

	for(;;)
	{
		self waittill("damage",var_01,var_02);
		if(isplayer(var_02))
		{
			if(self.health - var_01 <= 0)
			{
				if(level.captured_mission_failed != "true")
				{
					level.captured_mission_failed = "true";
					if(!level.missionfailed)
					{
						setdvar("ui_deadquote",&"CAPTURED_FAIL_UNARMED");
						maps\_utility::missionfailedwrapper();
					}
				}
			}

			continue;
		}

		self kill(var_02 geteye(),var_02);
	}
}

//Function Number: 66
kill_no_react()
{
	if(!isalive(self))
	{
		return;
	}

	if(isdefined(self.magic_bullet_shield))
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	self.allowdeath = 1;
	self.a.nodeath = 1;
	maps\_utility::set_battlechatter(0);
	self kill();
}

//Function Number: 67
start_point_is_after(param_00,param_01)
{
	return start_point_check("after",param_00,param_01);
}

//Function Number: 68
start_point_is_before(param_00,param_01)
{
	return start_point_check("before",param_00,param_01);
}

//Function Number: 69
start_point_is_between(param_00,param_01)
{
	return start_point_check("between",param_00,param_01);
}

//Function Number: 70
start_point_check(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = [];
	if(!isarray(param_01))
	{
		var_04[0] = param_01;
	}
	else
	{
		var_04 = param_01;
	}

	var_05 = var_04.size;
	for(var_06 = 0;var_06 < var_04.size;var_06++)
	{
		var_04[var_06] = tolower(var_04[var_06]);
	}

	var_07 = getarraykeys(level.start_arrays);
	var_08 = [];
	for(var_06 = 0;var_06 < var_07.size;var_06++)
	{
		for(var_09 = 0;var_09 < var_04.size;var_09++)
		{
			if(var_07[var_06] == var_04[var_09])
			{
				var_08 = common_scripts\utility::array_add(var_08,var_06);
				var_04 = maps\_utility::array_remove_index(var_04,var_09);
				break;
			}
		}

		if(var_07[var_06] == level.start_point)
		{
			var_03 = var_06;
		}
	}

	switch(param_00)
	{
		case "before":
			if(isdefined(param_02) && param_02 && var_03 <= var_08[0])
			{
				return 1;
			}
			else if(var_03 < var_08[0])
			{
				return 1;
			}
			break;

		case "between":
			if(isdefined(param_02) && param_02 && var_03 >= var_08[0] && var_03 <= var_08[1])
			{
				return 1;
			}
			else if(var_03 > var_08[0] && var_03 < var_08[1])
			{
				return 1;
			}
			break;

		case "after":
			if(isdefined(param_02) && param_02 && var_03 >= var_08[0])
			{
				return 1;
			}
			else if(var_03 > var_08[0])
			{
				return 1;
			}
			break;
	}

	return 0;
}

//Function Number: 71
waittill_notify_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self waittill(param_00);
	if(isdefined(param_05))
	{
		self [[ param_01 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		self [[ param_01 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		self [[ param_01 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self [[ param_01 ]](param_02);
		return;
	}

	self [[ param_01 ]]();
}

//Function Number: 72
waittill_notify_func_ent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 waittill(param_01);
	if(isdefined(param_06))
	{
		self [[ param_02 ]](param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		self [[ param_02 ]](param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		self [[ param_02 ]](param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		self [[ param_02 ]](param_03);
		return;
	}

	self [[ param_02 ]]();
}

//Function Number: 73
ambient_fan_rotate()
{
	self rotatepitch(randomint(360),0.1);
	for(;;)
	{
		self rotatepitch(360,3);
		wait(3);
	}
}

//Function Number: 74
physics_bodies_on(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	if(isdefined(param_01))
	{
		if(param_01 > 0)
		{
			wait(param_01);
		}
	}

	if(!isdefined(level.hanging_bodies))
	{
		level.hanging_bodies = [];
	}

	if(isdefined(param_02))
	{
		var_04 = ["cap_hanging_bodybag_clean","cap_hanging_bodybag_clean_b","cap_hanging_bodybag_clean_c","cap_hanging_bodybag_02_clean","cap_hanging_bodybag_02_clean_b","cap_hanging_bodybag_02_clean_c"];
	}
	else
	{
		var_04 = ["cap_hanging_bodybag","cap_hanging_bodybag_02","cap_hanging_bodybag_b","cap_hanging_bodybag_c","cap_hanging_bodybag_02_b","cap_hanging_bodybag_02_c"];
	}

	foreach(var_06 in var_03)
	{
		var_07 = common_scripts\utility::random(var_04);
		var_08 = spawn("script_model",var_06.origin);
		var_08 setmodel(var_07);
		var_08.angles = var_06.angles;
		level.hanging_bodies = common_scripts\utility::array_add(level.hanging_bodies,var_08);
	}
}

//Function Number: 75
physics_bodies_off()
{
	if(isdefined(level.hanging_bodies))
	{
		var_00 = [];
		foreach(var_02 in level.hanging_bodies)
		{
			var_02 physicsstop();
			var_02 delete();
			level.hanging_bodies = common_scripts\utility::array_remove(level.hanging_bodies,var_02);
		}
	}
}

//Function Number: 76
captured_hint_radius(param_00,param_01,param_02,param_03)
{
}

//Function Number: 77
tprintln(param_00,param_01)
{
	if(!isdefined(level.debugging_on))
	{
		return 0;
	}

	return 1;
}

//Function Number: 78
jkuprint(param_00,param_01,param_02)
{
	setdvarifuninitialized("jkudebug",0);
	if(!isdefined(param_01))
	{
		param_01 = "onscreen";
	}

	if(!isdefined(param_02))
	{
		param_02 = 100;
	}

	if(getdvarint("jkudebug") == 1)
	{
		switch(param_01)
		{
			case "onscreen":
				iprintln(param_00);
				break;

			case "3d":
				if(!isdefined(self.origin))
				{
					break;
				}
				break;

			case "3dattached":
				thread jkuprint3dattached(param_00,param_02);
				break;

			case "console":
				break;

			case "bold":
				iprintlnbold(param_00);
				break;

			default:
				break;
		}
	}
}

//Function Number: 79
jkuprint3dattached(param_00,param_01)
{
	if(!isdefined(self))
	{
	}

	self endon("death");
	self endon("jkuprint_stop");
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		wait 0.05;
	}
}

//Function Number: 80
jkupoint(param_00,param_01,param_02)
{
	setdvarifuninitialized("jkudebug",0);
	if(getdvarint("jkudebug") == 1)
	{
		if(!isdefined(self.origin))
		{
			return;
		}
		else
		{
			var_03 = self.origin;
		}

		if(!isdefined(param_00))
		{
			param_00 = 6;
		}

		if(!isdefined(param_01))
		{
			param_01 = (1,1,1);
		}

		if(!isdefined(param_02))
		{
			param_02 = 400;
		}
	}
}

//Function Number: 81
jkuline(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	setdvarifuninitialized("jkudebug",0);
	if(getdvarint("jkudebug") == 1)
	{
		if(!isdefined(param_02))
		{
			param_02 = (1,1,1);
		}

		if(!isdefined(param_03))
		{
			param_03 = 1;
		}

		if(!isdefined(param_04))
		{
			param_04 = 0;
		}

		if(!isdefined(param_05))
		{
			param_05 = 200;
		}

		if(isdefined(param_06))
		{
			if(isdefined(param_07))
			{
				var_08 = 40;
				param_01 = self.origin + anglestoforward(self.angles) * var_08;
			}
			else
			{
				var_08 = distance2d(param_01,param_02);
			}

			var_09 = var_08 * 0.2;
			var_0A = var_08 * 0.5;
			var_0B = var_08 * 0.175;
			var_0C = param_00 - param_01;
			var_0D = param_01 + anglestoforward(vectortoangles(var_0C)) * var_09;
			var_0E = param_01 + anglestoforward(vectortoangles(var_0C)) * var_0A;
			return;
		}
	}
}

//Function Number: 82
tff_get_zone_cleanup_notify(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "intro_drive":
			var_01 = "tff_pre_intro_drive_to_s2walk";
			break;

		case "s2walk":
			var_01 = "tff_pre_s2walk_to_interrogate";
			break;

		case "helipad":
			var_01 = "tff_pre_helipad_to_mechbattle";
			break;
	}

	return var_01;
}

//Function Number: 83
tff_cleanup_vehicle(param_00)
{
	var_01 = tff_get_zone_cleanup_notify(param_00);
	if(var_01 == "")
	{
		return;
	}

	level waittill(var_01);
	if(isarray(self))
	{
		foreach(var_03 in self)
		{
			if(!isdefined(var_03))
			{
				return;
			}

			if(isremovedentity(var_03))
			{
				return;
			}

			if(var_03 maps\_vehicle::isvehicle())
			{
				var_03 maps\_vehicle_code::_freevehicle();
			}

			var_03 delete();
		}

		return;
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isremovedentity(self))
	{
		return;
	}

	if(maps\_vehicle::isvehicle())
	{
		maps\_vehicle_code::_freevehicle();
	}

	self delete();
}

//Function Number: 84
captured_player_cuffs()
{
	var_00 = self;
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("s1_vm_handcuffs");
	var_01 linkto(var_00,"tag_weapon_left",(0,0,0),(0,0,0));
	return var_01;
}

//Function Number: 85
captured_worker_weapons()
{
	var_00 = self;
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("npc_titan45_nocamo");
	var_01 linkto(var_00,"tag_stowed_hip_rear",(-12,10,-2),(30,150,0));
	var_00.no_friendly_fire_penalty = 1;
	var_00 waittill("death");
	var_01 delete();
}
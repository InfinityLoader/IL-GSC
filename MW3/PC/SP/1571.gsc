/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1571.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 107
 * Decompile Time: 137 ms
 * Timestamp: 10/27/2023 2:21:19 AM
*******************************************************************/

//Function Number: 1
func_3F62(param_00)
{
	return tablelookup(level.var_3F63,1,param_00,2);
}

//Function Number: 2
func_3F64(param_00)
{
	return tablelookup(level.var_3F63,2,param_00,3);
}

//Function Number: 3
func_3F65()
{
	if(getdvarint("survival_chaos") == 1)
	{
		thread maps/_so_survival_chaos::chaos_pre_preload();
	}

	maps\so_survival_precache::main();
	if(!isdefined(level.var_3F63))
	{
		level.var_3F63 = "sp/survival_waves.csv";
	}

	level.uav_missile_override = "remote_missile_survival";
	level.givexp_kill_func = ::maps\_so_survival_ai::givexp_kill;
	maps\_so_survival_armory::armory_preload();
	maps\_so_survival_ai::ai_preload();
	maps\_so_survival_perks::perks_preload();
	maps\_so_survival_challenge::precache_challenge_strings();
	precacheitem("smoke_grenade_fast");
	precacherumble("damage_light");
	precacheminimapsentrycodeassets();
	precachestring(&"SO_SURVIVAL_SURVIVAL_OBJECTIVE");
	precachestring(&"SO_SURVIVAL_WAVE_TITLE");
	precachestring(&"SO_SURVIVAL_WAVE_SUCCESS_TITLE");
	precachestring(&"SO_SURVIVAL_SURVIVE_TIME");
	precachestring(&"SO_SURVIVAL_WAVE_TIME");
	precachestring(&"SO_SURVIVAL_PARTNER_READY");
	precachestring(&"SO_SURVIVAL_READY_UP_WAIT");
	precachestring(&"SO_SURVIVAL_READY_UP");
	precacheshader("gradient_inset_rect");
	precacheshader("teamperk_blast_shield");
	precacheshader("specialty_self_revive");
	maps\_so_survival_code::precache_loadout_item(func_3F62("weapon_1"));
	maps\_so_survival_code::precache_loadout_item(func_3F62("weapon_2"));
	maps\_so_survival_code::precache_loadout_item(func_3F62("weapon_3"));
	maps\_load::set_player_viewhand_model("viewhands_player_delta");
	thread maps\_so_survival_code::mp_ents_cleanup();
	thread func_00D8();
	level.cheap_air_strobe_fx = 1;
	if(getdvarint("survival_chaos") == 1)
	{
		thread maps/_so_survival_chaos::chaos_preload();
	}

	precachemenu("so_survival_dvar_reset");
}

//Function Number: 4
func_00D8()
{
	var_00 = getentarray("trigger_multiple_flag_set","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_flag) && var_02.script_flag == "start_survival")
		{
			var_02 common_scripts\utility::trigger_off();
		}
	}
}

//Function Number: 5
hurtplayersthink(param_00)
{
	level endon("special_op_terminated");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01) && isplayer(var_01) && var_01 == self)
		{
			break;
		}
	}

	maps\_utility::kill_wrapper();
}

//Function Number: 6
func_3F66()
{
	maps\_so_survival_armory::armory_postload();
	maps\_so_survival_loot::loot_postload();
	if(getdvarint("survival_chaos") == 1)
	{
		thread maps/_so_survival_chaos::chaos_postload();
	}
}

//Function Number: 7
func_3F67()
{
	foreach(var_01 in level.players)
	{
		var_01 openpopupmenu("so_survival_dvar_reset");
	}

	common_scripts\utility::flag_init("bosses_spawned");
	common_scripts\utility::flag_init("aggressive_mode");
	common_scripts\utility::flag_init("boss_music");
	common_scripts\utility::flag_init("slamzoom_finished");
	common_scripts\utility::flag_set("so_player_death_nofail");
	level.var_16BC = 1;
	level.var_16BD = ::func_16C2;
	level.suppress_challenge_success_print = 1;
	level.var_17F7 = 5;
	level.var_1990 = ::func_3F69;
	level.var_1991 = ::func_3F68;
	level.skip_pilot_kill_count = 1;
	level.var_3C36 = 128;
	level.var_3C37 = 0;
	setsaveddvar("ai_foliageSeeThroughDist",-15536);
	setsaveddvar("g_friendlyfireDamageScale",0.5);
	forcesharedammo();
	thread maps\_specialops::enable_challenge_timer("start_survival","win_survival",undefined,1);
	thread maps\_specialops::fade_challenge_in(undefined,0);
	thread maps\_specialops::fade_challenge_out("win_survival");
	level.wave_spawn_locs = maps\_squad_enemies::squad_setup(1);
	maps\_drone_ai::init();
	maps\_so_survival_armory::armory_init();
	maps\_so_survival_loot::loot_init();
	maps\_so_survival_ai::ai_init();
	maps\_so_survival_perks::perks_init();
	if(getdvarint("survival_chaos") != 1)
	{
		maps\_so_survival_challenge::challenge_init();
	}

	maps\_so_survival_dialog::survival_dialog_init();
	maps\_audio::aud_disable_deathsdoor_audio();
	thread func_3F71();
	thread func_3F6C();
	if(getdvarint("survival_chaos") == 1)
	{
		thread maps/_so_survival_chaos::chaos_init();
	}
}

//Function Number: 8
func_3F68()
{
	return level.current_wave;
}

//Function Number: 9
func_3F69()
{
	foreach(var_01 in level.players)
	{
	}

	var_03 = level.challenge_end_time - level.challenge_start_time / 1000;
	var_04 = level.current_wave;
	var_05 = 0;
	foreach(var_01 in level.players)
	{
		var_05 = var_05 + var_01.game_performance["credits"];
	}

	var_08 = 999 * min(var_05 / var_04 * 10000,1);
	if(var_04 == 1)
	{
		return int(var_08);
	}

	var_09 = var_04 * 1000;
	var_0A = int(var_09 + var_08);
	return var_0A;
}

//Function Number: 10
func_3F6A(param_00,param_01)
{
	if(maps\_utility::is_coop())
	{
		return maps\_utility::get_other_player(param_00).game_performance[param_01];
	}

	return undefined;
}

//Function Number: 11
func_16C2()
{
	var_00 = int(min(level.challenge_end_time - level.challenge_start_time,86400000));
	var_01 = int(var_00 % 1000 / 100);
	var_02 = int(var_00 / 1000) % 60;
	var_03 = int(var_00 / -5536) % 60;
	var_04 = int(var_00 / 3600000);
	if(var_04 < 10)
	{
		var_04 = "0" + var_04;
	}

	if(var_03 < 10)
	{
		var_03 = "0" + var_03;
	}

	if(var_02 < 10)
	{
		var_02 = "0" + var_02;
	}

	var_05 = var_04 + ":" + var_03 + ":" + var_02 + "." + var_01;
	var_06 = func_3F69();
	foreach(var_08 in level.players)
	{
		var_09 = var_08.game_performance["kill"];
		var_0A = func_3F6A(var_08,"kill");
		var_0B = var_08.game_performance["headshot"];
		var_0C = func_3F6A(var_08,"headshot");
		var_0D = var_08.game_performance["accuracy"] + "%";
		var_0E = func_3F6A(var_08,"accuracy");
		if(isdefined(var_0E))
		{
			var_0E = var_0E + "%";
		}

		var_0F = var_08.game_performance["credits"];
		var_10 = func_3F6A(var_08,"credits");
		var_11 = var_08.game_performance["downed"];
		var_12 = func_3F6A(var_08,"downed");
		var_13 = var_08.game_performance["revives"];
		var_14 = func_3F6A(var_08,"revives");
		var_08 maps\_utility::set_eog_success_heading(level.current_wave);
		if(maps\_utility::is_coop())
		{
			setdvar("ui_hide_hint",1);
			var_08 maps\_utility::add_custom_eog_summary_line("","@SPECIAL_OPS_PERFORMANCE_YOU","@SPECIAL_OPS_PERFORMANCE_PARTNER");
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS",var_09,var_0A);
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_HEADSHOT",var_0B,var_0C);
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_ACCURACY",var_0D,var_0E);
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_REVIVES",var_13,var_14);
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED",var_0F,var_10);
			var_08 maps\_utility::add_custom_eog_summary_line_blank();
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME",var_05);
			var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE",var_06);
			continue;
		}

		setdvar("ui_hide_hint",0);
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS",var_09);
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_HEADSHOT",var_0B);
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_ACCURACY",var_0D);
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED",var_0F);
		var_08 maps\_utility::add_custom_eog_summary_line_blank();
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME",var_05);
		var_08 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE",var_06);
	}
}

//Function Number: 12
func_3F6C()
{
	wait 0.05;
	maps\_so_survival_armory::armory_setup_players();
	thread func_3F6D();
	thread func_3F6E();
	if(getdvarint("survival_chaos") == 1)
	{
		thread maps/_so_survival_chaos::chaos_wave();
	}
	else
	{
		thread survival_wave();
	}

	thread func_3FB8();
	thread func_3FB1();
	thread func_3FD9();
}

//Function Number: 13
func_3F6D()
{
	wait 2;
	if(getdvarint("survival_chaos") == 1)
	{
		objective_add(1,"active",&"SO_SURVIVAL_CHAOS_OBJECTIVE");
	}
	else
	{
		objective_add(1,"active",&"SO_SURVIVAL_SURVIVAL_OBJECTIVE");
	}

	objective_current_nomessage(1);
}

//Function Number: 14
func_3F6E()
{
	level waittill("so_player_has_died");
	if(!common_scripts\utility::flag("start_survival"))
	{
		common_scripts\utility::flag_wait("start_survival");
	}

	if(!common_scripts\utility::flag("so_player_death_nofail"))
	{
		return;
	}

	common_scripts\utility::flag_set("win_survival");
}

//Function Number: 15
func_3F6F()
{
	level endon("special_op_terminated");
	for(;;)
	{
		level waittill("wave_ended",var_00);
		if(var_00 >= 0)
		{
			common_scripts\utility::flag_set("so_player_death_nofail");
			return;
		}
	}
}

//Function Number: 16
func_3F70()
{
	common_scripts\utility::flag_wait_or_timeout("start_survival",5);
}

//Function Number: 17
func_3F71()
{
	if(level.console)
	{
		setsaveddvar("aim_aimAssistRangeScale","1");
		setsaveddvar("aim_autoAimRangeScale","0");
	}

	var_00 = getentarray("trigger_hurt","classname");
	foreach(var_02 in level.players)
	{
		var_02 thread func_3F7F();
		var_02 thread give_loadout();
		foreach(var_04 in var_00)
		{
			var_02 thread hurtplayersthink(var_04);
		}
	}

	thread func_3F93();
	func_3F70();
	level.var_D9 = [];
	level.var_DA = [];
	foreach(var_02 in level.players)
	{
		var_02 thread func_3FA8();
		var_02 thread func_3F78();
		var_02 thread func_3F79();
		var_02 thread func_00DB();
	}
}

//Function Number: 18
func_00DB()
{
	self endon("death");
	self endon("disconnect");
	thread func_00DC();
	thread func_00DD();
}

//Function Number: 19
func_00DC()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00) && isdefined(var_01) && isdefined(weaponinventorytype(var_01)) && weaponinventorytype(var_01) == "item" && issubstr(var_01,"c4"))
		{
			if(level.var_D9.size)
			{
				level.var_D9 = common_scripts\utility::array_removeundefined(level.var_D9);
				if(level.var_D9.size >= 20)
				{
					level.var_D9[0] detonate();
				}
			}

			level.var_D9[level.var_D9.size] = var_00;
		}
	}
}

//Function Number: 20
func_00DD()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00) && isdefined(var_01) && isdefined(weaponinventorytype(var_01)) && weaponinventorytype(var_01) == "item" && issubstr(var_01,"claymore"))
		{
			if(level.var_DA.size)
			{
				level.var_DA = common_scripts\utility::array_removeundefined(level.var_DA);
				if(level.var_DA.size >= 20)
				{
					level.var_DA[0] detonate();
				}
			}

			level.var_DA[level.var_DA.size] = var_00;
		}
	}
}

//Function Number: 21
give_loadout()
{
	self endon("death");
	self takeallweapons();
	func_3F72("weapon_1");
	func_3F72("weapon_2");
	func_3F72("weapon_3");
	func_3F73("grenade_1");
	func_3F73("grenade_2");
	func_3F74("armor_1");
	wait 0.05;
	func_3F75("equipment_1");
	func_3F75("equipment_2");
	func_3F75("equipment_3");
	func_3F76("airsupport_1");
	func_3F76("airsupport_2");
	func_3F76("airsupport_3");
	func_3F77("perk_1");
	func_3F77("perk_2");
	func_3F77("perk_3");
}

//Function Number: 22
func_3F72(param_00)
{
	var_01 = func_3F62(param_00);
	var_02 = func_3F64(var_01);
	if(var_01 != "")
	{
		self giveweapon(var_01);
		var_03 = weaponclass(var_01);
		if(var_03 == "pistol")
		{
			level.coop_incap_weapon = var_01;
		}

		if(var_02 == "max")
		{
			self setweaponammostock(var_01,weaponmaxammo(var_01));
		}
		else
		{
			self setweaponammostock(var_01,int(var_02));
		}

		if(param_00 == "weapon_1")
		{
			self switchtoweapon(var_01);
		}
	}
}

//Function Number: 23
func_3F73(param_00)
{
	var_01 = func_3F62(param_00);
	var_02 = func_3F64(var_01);
	if(var_01 != "")
	{
		self giveweapon(var_01);
		if(var_02 == "max")
		{
			self setweaponammostock(var_01,weaponmaxammo(var_01));
		}
		else
		{
			self setweaponammostock(var_01,int(var_02));
		}

		if(var_01 == "flash_grenade")
		{
			self setoffhandsecondaryclass("flash");
		}
	}
}

//Function Number: 24
func_3F74(param_00)
{
	var_01 = func_3F62(param_00);
	var_02 = int(func_3F64(var_01));
	if(var_01 != "")
	{
		maps\_so_survival_armory::give_armor_amount(var_01,var_02);
	}
}

//Function Number: 25
func_3F75(param_00)
{
	var_01 = func_3F62(param_00);
	if(var_01 != "")
	{
		var_02 = maps\_so_survival_armory::get_func_give("equipment",var_01);
		self thread [[ var_02 ]](var_01);
	}
}

//Function Number: 26
func_3F76(param_00)
{
	var_01 = func_3F62(param_00);
	if(var_01 != "")
	{
		var_02 = maps\_so_survival_armory::get_func_give("airsupport",var_01);
		self thread [[ var_02 ]](var_01);
	}
}

//Function Number: 27
func_3F77(param_00)
{
	var_01 = func_3F62(param_00);
	if(var_01 != "")
	{
		thread maps\_so_survival_perks::give_perk(var_01);
	}
}

//Function Number: 28
func_3F78()
{
	if(!maps\_utility::is_coop())
	{
		return;
	}

	for(;;)
	{
		level waittill("wave_ended");
		var_00 = 120;
		var_00 = var_00 - level.current_wave * 8;
		var_00 = max(var_00,30);
		self.laststand_info.bleedout_time_default = var_00;
	}
}

//Function Number: 29
func_3F79()
{
	level endon("special_op_terminated");
	self endon("death");
	if(!isdefined(self.var_3F7A))
	{
		self.var_3F7A = [];
	}

	var_00 = self getweaponslistprimaries();
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(!func_3F7B(var_01))
		{
			continue;
		}

		var_02 = !maps\_utility::array_contains(var_00,var_01);
		if(!var_02)
		{
			continue;
		}

		if(!func_3F7C(var_01))
		{
			if(func_3F7D(var_01))
			{
				func_3F07(var_01);
			}
		}

		var_03 = self getweaponslistprimaries();
		foreach(var_05 in var_00)
		{
			if(!maps\_utility::array_contains(var_03,var_05))
			{
				if(!func_3F7B(var_05))
				{
					continue;
				}

				func_3F07(var_05);
			}
		}

		var_00 = var_03;
		func_3F7E();
	}
}

//Function Number: 30
func_3F7B(param_00)
{
	if(weaponclass(param_00) == "none" || weaponclass(param_00) == "rocketlauncher" || weaponclass(param_00) == "item")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
func_3F7C(param_00)
{
	if(!isdefined(self.var_3F7A))
	{
		return 0;
	}

	if(!isdefined(self.var_3F7A[param_00]))
	{
		return 0;
	}

	if(gettime() - self.var_3F7A[param_00] <= 10000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_3F7D(param_00)
{
	var_01 = self getweaponammoclip(param_00);
	var_02 = self getweaponammostock(param_00);
	var_03 = weaponclipsize(param_00);
	var_04 = weaponmaxammo(param_00);
	if(var_01 == var_03)
	{
		return 0;
	}

	if(var_02 <= 0)
	{
		return 0;
	}

	var_05 = var_03 - var_01;
	var_06 = 0;
	if(var_05 > var_02)
	{
		var_06 = var_02;
	}
	else
	{
		var_06 = var_05;
	}

	self setweaponammoclip(param_00,var_01 + var_06);
	self setweaponammostock(param_00,var_02 - var_06);
	return 1;
}

//Function Number: 33
func_3F07(param_00)
{
	if(!isdefined(self.var_3F7A))
	{
		self.var_3F7A = [];
	}

	self.var_3F7A[param_00] = gettime();
}

//Function Number: 34
func_3F7E()
{
	if(!isdefined(self.var_3F7A) || !self.var_3F7A.size)
	{
		return;
	}

	var_00 = [];
	foreach(var_03, var_02 in self.var_3F7A)
	{
		if(func_3F7C(var_03))
		{
			var_00[var_03] = self.var_3F7A[var_03];
		}
	}

	self.var_3F7A = var_00;
}

//Function Number: 35
func_3F7F()
{
	self disableweapons();
	self disableoffhandweapons();
	self freezecontrols(1);
	if(isdefined(self.last_modelfunc))
	{
		self detachall();
		self setmodel("");
	}

	var_00 = 1.75;
	var_01 = 16000;
	var_02 = self.origin;
	self playersetstreamorigin(var_02);
	self.origin = var_02 + (0,0,var_01);
	var_03 = spawn("script_model",(69,69,69));
	var_03 setmodel("tag_origin");
	var_03.origin = self.origin;
	var_03.angles = self.angles;
	self playerlinkto(var_03,undefined,1,0,0,0,0);
	var_03.angles = (var_03.angles[0] + 89,var_03.angles[1],0);
	var_03 moveto(var_02 + (0,0,0),var_00,0,var_00);
	wait 0.05;
	self playsound("survival_slamzoom_out");
	wait var_00 - 0.55;
	self visionsetnakedforplayer("coup_sunblind",0.25);
	var_03 rotateto((var_03.angles[0] - 89,var_03.angles[1],0),0.5,0.3,0.2);
	wait 0.2;
	self visionsetnakedforplayer("",1);
	wait 0.5;
	self unlink();
	self enableweapons();
	self enableoffhandweapons();
	self freezecontrols(0);
	self playerclearstreamorigin();
	self notify("player_update_model");
	wait 0.5;
	common_scripts\utility::flag_set("slamzoom_finished");
	var_03 delete();
}

//Function Number: 36
func_3F80()
{
	level.pmc_alljuggernauts = 0;
	level.skip_juggernaut_intro_sound = 1;
	level.survival_wave_intermission = 0;
	level.remotemissile.fov_is_altered = 12;
	setsaveddvar("g_compassShowEnemies","0");
	common_scripts\utility::array_thread(level.players,::maps\_remotemissile_utility::setup_remote_missile_target);
	maps\_utility::add_global_spawn_function("axis",::maps\_so_survival_code::ai_remote_missile_fof_outline);
	level.current_wave = 1;
	level thread func_3F81();
}

//Function Number: 37
func_3F81()
{
	level endon("special_op_terminated");
	var_00 = undefined;
	var_01 = 0;
	for(;;)
	{
		level waittill("wave_ended",var_02);
		var_03 = var_02 + 1;
		if(!maps\_so_survival_ai::wave_exist(var_03))
		{
			if(!isdefined(var_00))
			{
				var_00 = 0;
				var_01 = 1;
			}

			if(var_00 == level.survival_repeat_wave.size)
			{
				var_00 = 0;
				var_01++;
			}

			var_04 = spawnstruct();
			var_04.idx = var_03 - 1;
			var_04.num = var_03;
			var_04.survival_ai_class_overrides = level.survival_repeat_wave[var_00].survival_ai_class_overrides;
			var_04.var_3D4C = level.survival_repeat_wave[var_00].var_3D4C;
			var_04.var_3D4D = level.survival_repeat_wave[var_00].var_3D4D;
			var_04.var_3D4E = level.survival_repeat_wave[var_00].var_3D4E;
			var_04.bossai = level.survival_repeat_wave[var_00].bossai;
			var_04.bossnonai = level.survival_repeat_wave[var_00].bossnonai;
			var_04.var_3D4F = level.survival_repeat_wave[var_00].var_3D4F;
			var_04.dogtype = level.survival_repeat_wave[var_00].dogtype;
			var_04.dogquantity = level.survival_repeat_wave[var_00].dogquantity;
			var_04.repeating = level.survival_repeat_wave[var_00].repeating;
			var_05 = level.survival_wave[var_02];
			level.survival_wave = [];
			level.survival_wave[var_02] = var_05;
			level.survival_wave[var_04.num] = var_04;
			var_00++;
			level.survival_waves_repeated++;
		}
	}
}

//Function Number: 38
survival_wave()
{
	level endon("special_op_terminated");
	func_3F80();
	thread func_3FB6();
	func_3F70();
	if(!common_scripts\utility::flag("start_survival"))
	{
		common_scripts\utility::flag_set("start_survival");
	}

	level notify("wave_started",level.current_wave);
	setsaveddvar("bg_viewKickScale","0.2");
	for(;;)
	{
		if(isdefined(level.leaders.size) && level.leaders.size >= 3)
		{
		}

		var_00 = maps\_so_survival_ai::get_squad_array(level.current_wave);
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(var_03 > 0)
			{
				var_01 = var_01 + func_3F8A(1,var_03);
			}
		}

		level.special_ai = [];
		var_05 = maps\_so_survival_ai::get_special_ai(level.current_wave);
		if(isdefined(var_05))
		{
			foreach(var_07 in var_05)
			{
				if(issubstr(var_07,"dog"))
				{
					thread maps\_so_survival_ai::spawn_dogs(var_07,maps\_so_survival_ai::get_dog_quantity(level.current_wave));
					continue;
				}

				var_08 = maps\_so_survival_ai::get_special_ai_type_quantity(level.current_wave,var_07);
				if(isdefined(var_08) && var_08 > 0)
				{
					var_09 = func_3F8C(var_07,var_08);
				}
			}
		}

		if(var_00[0] > 0)
		{
			thread func_3F8D(1,var_00[0]);
		}

		if(func_3F8F(level.current_wave))
		{
			thread func_3F90();
		}

		level thread func_3F82();
		var_0B = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		while(var_0B > 4)
		{
			level common_scripts\utility::waittill_any_timeout(1,"axis_died");
			var_0B = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		}

		common_scripts\utility::flag_set("aggressive_mode");
		maps\_squad_enemies::squad_disband(0,::maps\_so_survival_ai::aggressive_squad_leader);
		level.squad_leader_behavior_func = ::maps\_so_survival_ai::aggressive_ai;
		level.special_ai_behavior_func = ::maps\_so_survival_ai::aggressive_ai;
		if(isdefined(level.special_ai) && level.special_ai.size > 0)
		{
			foreach(var_0D in level.special_ai)
			{
				var_0D thread maps\_so_survival_ai::aggressive_ai();
			}
		}

		var_0B = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		while(var_0B > 0)
		{
			level common_scripts\utility::waittill_any_timeout(1,"axis_died");
			var_0B = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		}

		level.squad_leader_behavior_func = ::maps\_so_survival_ai::default_ai;
		level.special_ai_behavior_func = ::maps\_so_survival_ai::default_ai;
		if(func_3F8F(level.current_wave))
		{
			common_scripts\utility::flag_wait("bosses_spawned");
			while(isdefined(level.bosses) && level.bosses.size)
			{
				wait 0.1;
			}
		}

		common_scripts\utility::flag_clear("aggressive_mode");
		level notify("wave_ended",level.current_wave);
		setsaveddvar("g_compassShowEnemies","0");
		if(common_scripts\utility::flag("boss_music"))
		{
			level notify("end_boss_music");
			common_scripts\utility::flag_clear("boss_music");
			maps\_utility::music_stop(3);
		}

		func_3F89();
		survival_wave_intermission();
		level.current_wave++;
		level notify("wave_started",level.current_wave);
	}
}

//Function Number: 39
func_3F82()
{
	level endon("wave_ended");
	wait 7;
	setsaveddvar("g_compassShowEnemies","1");
}

//Function Number: 40
survival_wave_intermission()
{
	level endon("special_op_terminated");
	level.survival_wave_intermission = 1;
	var_00 = 30;
	var_01 = 5;
	if(var_00 > 0)
	{
		wait 5;
		var_00 = var_00 - 5;
		common_scripts\utility::array_thread(level.players,::func_3F83,"survival_all_ready",var_00 + var_01);
		level common_scripts\utility::waittill_any_timeout(var_00,"survival_all_ready");
		level notify("survival_all_ready");
	}

	foreach(var_03 in level.players)
	{
		var_03 thread matchstarttimer(var_01);
	}

	wait var_01;
	level.survival_wave_intermission = 0;
}

//Function Number: 41
func_3F83(param_00,param_01)
{
	self endon("death");
	level endon("special_op_terminated");
	level endon(param_00);
	var_02 = maps\_specialops::so_hud_ypos() - 130;
	self.var_3F84 = maps\_specialops::so_create_hud_item(-2,var_02,&"SO_SURVIVAL_READY_UP",self,1);
	self.var_3F84 func_3F86();
	thread func_3F87("survival_player_ready",param_00,self.var_3F84,param_01);
	thread func_3F88(param_00);
	if(level.console)
	{
		self notifyonplayercommand("survival_player_ready","+stance");
	}
	else
	{
		self notifyonplayercommand("survival_player_ready","skip");
	}

	self waittill("survival_player_ready");
	if(!isdefined(level.var_3F85))
	{
		level.var_3F85 = 1;
	}
	else
	{
		level.var_3F85++;
	}

	self.var_3F84 maps\_specialops::so_remove_hud_item(1);
	if(level.var_3F85 == level.players.size)
	{
		level notify(param_00);
		return;
	}

	var_03 = maps\_utility::get_other_player(self);
	if(isdefined(var_03) && isdefined(var_03.var_3F84))
	{
		var_03.var_3F84.label = &"SO_SURVIVAL_PARTNER_READY";
	}

	self.var_3F84 = maps\_specialops::so_create_hud_item(-2,var_02,&"SO_SURVIVAL_READY_UP_WAIT",self,1);
	self.var_3F84 func_3F86();
}

//Function Number: 42
func_3F86()
{
	self.alignx = "left";
	self.fontscale = 0.75;
	self.alpha = 0;
	if(issplitscreen())
	{
		self.horzalign = "center";
		self.x = 36;
		self.y = -22;
	}

	thread maps\_hud_util::fade_over_time(1,0.5);
}

//Function Number: 43
func_3F87(param_00,param_01,param_02,param_03)
{
	level endon(param_01);
	self endon(param_00);
	for(param_03 = int(param_03);isdefined(param_02) && param_03 > 0;param_03--)
	{
		param_02 setvalue(param_03);
		wait 1;
	}
}

//Function Number: 44
func_3F88(param_00)
{
	level waittill(param_00);
	level.var_3F85 = undefined;
	if(isdefined(self.var_3F84))
	{
		self.var_3F84 maps\_specialops::so_remove_hud_item(1);
	}
}

//Function Number: 45
func_3F89()
{
	foreach(var_01 in level.players)
	{
		if(maps\_utility::is_player_down(var_01))
		{
			var_01.laststand_getup_fast = 1;
		}
	}
}

//Function Number: 46
func_3F8A(param_00,param_01)
{
	level endon("special_op_terminated");
	for(param_00 = int(param_00);param_00;param_00--)
	{
		var_02 = maps\_squad_enemies::spawn_far_squad(level.wave_spawn_locs,func_3F8B("leader"),func_3F8B("follower"),param_01 - 1);
		foreach(var_04 in var_02)
		{
			var_04 setthreatbiasgroup("axis");
			var_04 thread maps\_so_survival_ai::setup_ai_weapon();
		}
	}

	return level.leaders.size;
}

//Function Number: 47
func_3F8B(param_00)
{
	var_01 = maps\_so_survival_ai::get_squad_type(level.current_wave);
	var_02 = maps\_so_survival_ai::get_ai_classname(var_01);
	if(isdefined(param_00))
	{
	}

	return var_02;
}

//Function Number: 48
func_3F8C(param_00,param_01)
{
	var_02 = [];
	if(maps\_utility::is_coop())
	{
	}

	var_03 = maps\_so_survival_ai::get_ai_classname(param_01);
	var_04 = maps\_so_survival_code::get_spawners_by_classname(var_03)[0];
	var_05 = 0;
	while(var_05 < var_02)
	{
		wait 0.05;
		var_06 = maps\_so_survival_code::get_furthest_from_these(level.wave_spawn_locs,var_7B,4);
		var_04.count = 1;
		var_04.origin = var_06.origin;
		var_04.angles = var_06.angles;
		if(getdvarint("survival_chaos") == 1)
		{
			var_07 = var_04 maps\_utility::spawn_ai();
		}
		else
		{
			var_07 = var_04 maps\_utility::spawn_ai(1);
		}

		if(isdefined(var_07))
		{
			var_07 setthreatbiasgroup("axis");
			var_07.ally_ref = maps\_so_survival_ai::get_ai_struct(param_01);
			level.special_ai[level.special_ai.size] = var_07;
			var_07 thread maps\_so_survival_code::clear_from_special_ai_array_when_dead();
			var_07 thread maps\_so_survival_ai::setup_ai_weapon();
			var_07 thread [[ level.special_ai_behavior_func ]]();
		}

		var_05++ = var_7B[var_7B.size];
	}

	return level.special_ai;
}

//Function Number: 49
func_3F8D(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	var_02 = level.leaders.size;
	for(var_03 = 0;var_03 < param_00;var_03++)
	{
		if(level.leaders.size >= var_02)
		{
			wait 0.05;
			continue;
		}

		var_04 = getaiarray();
		if(var_04.size >= 32 - param_01)
		{
			wait 0.05;
			continue;
		}

		var_05 = maps\_squad_enemies::spawn_far_squad(level.wave_spawn_locs,func_3F8B("leader"),func_3F8B("follower"),param_01 - 1);
		foreach(var_07 in var_05)
		{
			var_07 setthreatbiasgroup("axis");
			var_07 thread maps\_so_survival_ai::setup_ai_weapon();
		}
	}
}

//Function Number: 50
func_3F8E(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	var_02 = level.special_ai.size;
	var_03 = 0;
	while(var_03 < param_01)
	{
		if(level.special_ai.size >= var_02)
		{
			wait 0.05;
			continue;
		}

		var_04 = getaiarray();
		if(var_04.size > 31)
		{
			wait 0.05;
			continue;
		}

		func_3F8C(param_00,1);
		var_03++;
		wait 0.05;
	}
}

//Function Number: 51
func_3F8F(param_00)
{
	var_01 = maps\_so_survival_ai::get_bosses_ai(param_00);
	var_02 = maps\_so_survival_ai::get_bosses_nonai(param_00);
	if(isdefined(var_01) || isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
func_3F90()
{
	common_scripts\utility::flag_clear("bosses_spawned");
	if(level.survival_wave[level.current_wave].var_3D4F && common_scripts\utility::flag_exist("aggressive_mode") && !common_scripts\utility::flag("aggressive_mode"))
	{
		common_scripts\utility::flag_wait("aggressive_mode");
	}

	level notify("boss_spawning",level.current_wave);
	level.bosses = [];
	var_00 = maps\_so_survival_ai::get_bosses_ai(level.current_wave);
	var_01 = maps\_so_survival_ai::get_bosses_nonai(level.current_wave);
	if(isdefined(var_00))
	{
		if(getdvarint("survival_chaos") == 1)
		{
			func_3F91(var_00,0);
		}
		else
		{
			func_3F91(var_00,1);
		}

		if(level.bosses.size && isdefined(var_01))
		{
			level common_scripts\utility::waittill_any_timeout(30,"juggernaut_jumpedout");
			wait 6;
		}
	}

	if(isdefined(var_01))
	{
		thread func_3F92(var_01,!isdefined(var_00));
	}

	common_scripts\utility::flag_set("bosses_spawned");
}

//Function Number: 53
func_3F91(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03 == "jug_minigun")
		{
			continue;
		}

		if(!issubstr(var_03,"jug_"))
		{
			continue;
		}

		var_04 = maps\_so_survival_code::chopper_wait_for_cloest_open_path_start(maps\_so_survival_code::random_player_origin(),"drop_path_start","script_unload");
		thread maps\_so_survival_ai::spawn_juggernaut(var_03,var_04);
		wait 0.5;
	}

	if(param_01)
	{
		thread func_3FB7("juggernaut");
	}
}

//Function Number: 54
func_3F92(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(issubstr(var_03,"chopper"))
		{
			var_04 = maps\_so_survival_code::chopper_wait_for_cloest_open_path_start(maps\_so_survival_code::random_player_origin(),"chopper_boss_path_start","script_stopnode");
			var_05 = maps\_so_survival_ai::spawn_chopper_boss(var_03,var_04);
			continue;
		}
	}

	if(param_01)
	{
		thread func_3FB7("chopper");
	}
}

//Function Number: 55
spawn_allies(param_00,param_01,param_02)
{
	var_03 = maps\_so_survival_code::chopper_wait_for_cloest_open_path_start(param_00,"drop_path_start","script_unload");
	level notify("so_airsupport_incoming",param_01);
	maps\_so_survival_ai::spawn_ally_team(param_01,3,var_03,param_02);
}

//Function Number: 56
func_3F93()
{
	wait 0.05;
	level.var_3F94["accuracy"] = 3;
	level.var_3F94["damagetaken"] = 2;
	level.var_3F94["time"] = 2;
	if(maps\_utility::is_coop())
	{
		level.var_3F94["wavebonus"] = 50;
		level.var_3F94["headshot"] = 50;
		level.var_3F94["kill"] = 50;
	}
	else
	{
		level.var_3F94["wavebonus"] = 25;
		level.var_3F94["headshot"] = 20;
		level.var_3F94["kill"] = 10;
	}

	foreach(var_01 in level.players)
	{
		var_01.game_performance = [];
		var_01.game_performance["headshot"] = 0;
		var_01.game_performance["accuracy"] = 0;
		var_01.game_performance["damagetaken"] = 0;
		var_01.game_performance["kill"] = 0;
		var_01.game_performance["credits"] = 0;
		var_01.game_performance["downed"] = 0;
		var_01.game_performance["revives"] = 0;
		var_01.var_3F95 = [];
		var_01.var_3F95["headshot"] = 0;
		var_01.var_3F95["accuracy"] = 0;
		var_01.var_3F95["time"] = 0;
		var_01.var_3F95["damagetaken"] = 0;
		var_01.var_3F95["kill"] = 0;
		var_01.var_3F95["wavebonus"] = 0;
		var_01 func_3FD2();
		var_01 thread func_3F97();
	}

	maps\_utility::add_global_spawn_function("axis",::func_3F9E);
}

//Function Number: 57
func_3F96()
{
	maps\_specialops::_setplayerdata_single("surHUD_performance_reward",0);
	foreach(var_02, var_01 in self.var_3F95)
	{
		self.var_3F95[var_02] = 0;
		maps\_specialops::_setplayerdata_array("surHUD_performance",var_02,0);
		maps\_specialops::_setplayerdata_array("surHUD_performance_p2",var_02,0);
		maps\_specialops::_setplayerdata_array("surHUD_performance_credit",var_02,0);
	}
}

//Function Number: 58
func_3F97()
{
	self endon("death");
	thread func_3F99();
	thread func_3F9B();
	thread func_3F9A();
	thread func_3F9C();
	thread func_3F9D();
	thread func_3F9F();
	thread func_3FA2();
	thread func_3FA3();
	thread func_3FA4();
	for(;;)
	{
		level waittill("wave_ended");
		maps\_player_stats::career_stat_increment("waves_survived",1);
		waittillframeend;
		var_00 = func_3FA6();
		if(var_00["total"])
		{
			thread maps\_utility::givexp("personal_wave_reward",var_00["total"]);
		}

		thread func_3FD3(var_00);
		level waittill("wave_started");
		self.var_3F98 = 0;
	}
}

//Function Number: 59
func_3F99()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		level waittill("wave_started");
		func_3F96();
		self.stats["kills"] = 0;
		self.stats["shots_fired"] = 0;
		self.stats["shots_hit"] = 0;
	}
}

//Function Number: 60
func_3F9A()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("so_revive_success");
		self.game_performance["revives"]++;
	}
}

//Function Number: 61
func_3F9B()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("player_downed");
		self.game_performance["downed"]++;
	}
}

//Function Number: 62
func_3F9C()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		self waittill("deposit_credits",var_00,var_01);
		if(self.survival_credit >= -15536 && !isdefined(self.var_DE))
		{
			self.var_DE = 1;
			thread maps\_specialops::so_achievement_update("GET_RICH_OR_DIE_TRYING");
		}

		if(isdefined(var_01) && var_01)
		{
			continue;
		}

		if(var_00 > 0)
		{
			self.game_performance["credits"] = self.game_performance["credits"] + var_00;
		}
	}
}

//Function Number: 63
func_3F9D()
{
	level endon("special_op_terminated");
	self endon("death");
	func_3F70();
	for(;;)
	{
		var_00 = gettime();
		level waittill("wave_ended");
		self.var_3F95["time"] = gettime() - var_00;
		level waittill("wave_started");
	}
}

//Function Number: 64
func_3F9E()
{
	level endon("special_op_terminated");
	if(!isai(self))
	{
		return;
	}

	var_00 = 0;
	self waittill("death",var_01,var_02,var_03,var_04,var_05,var_06,var_07);
	if(maps\_so_survival_code::was_headshot() && isplayer(var_01))
	{
		var_08 = "player.performance array is missing headshot setting";
		var_01.var_3F95["headshot"]++;
		var_01.game_performance["headshot"]++;
		var_01 notify("sur_ch_headshot");
	}
}

//Function Number: 65
func_3F9F()
{
	level endon("special_op_terminated");
	self endon("death");
	if(isdefined(self.armor))
	{
		self.var_3FA0 = self.armor["points"];
	}
	else
	{
		self.var_3FA0 = 0;
	}

	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01) && var_01 != self && isdefined(var_01.team) && var_01.team == self.team)
		{
			continue;
		}

		thread func_3FA1(var_00);
	}
}

//Function Number: 66
func_3FA1(param_00)
{
	var_01 = 100 + self.var_3FA0;
	var_02 = int(min(var_01,param_00));
	self.var_3F95["damagetaken"] = self.var_3F95["damagetaken"] + var_02;
	self.game_performance["damagetaken"] = self.game_performance["damagetaken"] + var_02;
	waittillframeend;
	if(isdefined(self.armor))
	{
		self.var_3FA0 = self.armor["points"];
		return;
	}

	self.var_3FA0 = 0;
}

//Function Number: 67
func_3FA2()
{
	level endon("special_op_terminated");
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		self waittill("weapon_fired");
		var_02 = max(1,float(self.stats["shots_fired"]));
		var_03 = float(self.stats["shots_hit"]);
		var_00 = var_00 + var_02;
		var_01 = var_01 + var_03;
		self.var_3F95["accuracy"] = maps\_so_survival_code::int_capped(100 * var_03 / var_02,0,100);
		self.game_performance["accuracy"] = maps\_so_survival_code::int_capped(100 * var_01 / var_00,0,100);
	}
}

//Function Number: 68
func_3FA3()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		level waittill("specops_player_kill",var_00);
		if(isdefined(var_00) && isplayer(var_00) && var_00 == self)
		{
			self.var_3F95["kill"]++;
			self.game_performance["kill"]++;
		}
	}
}

//Function Number: 69
func_3FA4()
{
	level endon("special_op_terminated");
	self endon("death");
	for(;;)
	{
		level waittill("wave_ended",var_00);
		self.var_3F95["wavebonus"] = var_00;
		if(!isdefined(self.var_DF))
		{
			self.var_DF = 1;
			thread maps\_specialops::so_achievement_update("I_LIVE");
		}

		if(var_00 == 9)
		{
			thread maps\_specialops::so_achievement_update("SURVIVOR");
		}

		if(var_00 == 14)
		{
			thread maps\_specialops::so_achievement_update("UNSTOPPABLE");
		}
	}
}

//Function Number: 70
func_3FA6()
{
	var_00 = self.var_3F95["headshot"] * level.var_3F94["headshot"];
	var_01 = int(max(self.var_3F95["accuracy"] - 25,0)) * level.var_3F94["accuracy"];
	var_02 = 400;
	var_02 = var_02 - self.var_3F95["damagetaken"] * level.var_3F94["damagetaken"];
	var_02 = int(max(var_02,0));
	var_03 = self.var_3F95["kill"] * level.var_3F94["kill"];
	var_04 = 0;
	var_05 = 90;
	var_06 = max(var_05 - int(self.var_3F95["time"] / 1000),0);
	var_04 = int(level.var_3F94["time"] * var_06);
	var_07 = self.var_3F95["wavebonus"] * level.var_3F94["wavebonus"];
	var_08 = [];
	var_09 = 0;
	foreach(var_0B in var_7B)
	{
		var_09 = var_09 + var_0B;
	}

	var_7B["total"] = func_3FA7(var_09);
	thread func_3FD4(var_7B);
	return var_7B;
}

//Function Number: 71
func_3FA7(param_00)
{
	return int(max(0,int(param_00)));
}

//Function Number: 72
func_3FA8()
{
	self endon("death");
	if(!isdefined(self.var_3FA9))
	{
		self.var_3FA9 = 0;
	}

	self.var_3FAA = [];
	self.var_3F98 = 0;
	thread func_3FAD();
	var_00 = self.origin;
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		self.var_3FAB = 0;
		self.var_3FAC = self.origin;
		var_01 = 0;
		var_00 = self.origin;
		while(var_01 <= 20)
		{
			if(distance(var_00,self.origin) < 220)
			{
				var_01++;
			}
			else
			{
				var_01 = var_01 - 2;
			}

			if(self.health < 40)
			{
				var_01--;
			}

			if(self.stats["kills"] - var_02 > 0)
			{
				var_01 = var_01 + self.stats["kills"] - var_02;
			}

			if(var_01 <= 0 || level.survival_wave_intermission || maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
			{
				var_01 = 0;
				var_00 = self.origin;
			}

			var_02 = self.stats["kills"];
			wait 1;
		}

		self.var_3FAB = 1;
		self.var_3FAC = self.origin;
		self.var_3FAA[self.var_3FAA.size] = self.var_3FAC;
		self notify("camping");
		while(distance(var_00,self.origin) < 260)
		{
			self.var_3F98++;
			wait 1;
		}

		self notify("stopped camping");
	}
}

//Function Number: 73
func_3FAD()
{
	self endon("death");
	level.var_3FAE = 8;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(self.var_3FAB) || !isdefined(self.var_3FAC) || !isdefined(self.var_3F98))
		{
			continue;
		}

		if(self.var_3FAB)
		{
			thread func_3FAF(self.var_3FAC,self.var_3F98);
			thread func_3FB0(self.var_3FAC,self.var_3F98);
			wait level.var_3FAE;
		}
	}
}

//Function Number: 74
func_3FAF(param_00,param_01)
{
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		var_04 thread maps\_so_survival_code::throw_grenade_at_player(self);
	}
}

//Function Number: 75
func_3FB0(param_00,param_01)
{
	if(isdefined(level.bosses) && level.bosses.size)
	{
		var_02 = level.bosses[randomint(level.bosses.size)];
	}
}

//Function Number: 76
func_3FB1()
{
	level endon("special_op_terminated");
	foreach(var_01 in level.players)
	{
		var_01 func_3FB9();
	}

	func_3F70();
	foreach(var_01 in level.players)
	{
		var_01.survival_credit = 0;
		if(getdvarint("survival_chaos") != 1)
		{
			var_01 thread func_3FB2();
			var_01 thread func_3FB5();
		}
	}
}

//Function Number: 77
func_3FB2()
{
	self endon("death");
	for(;;)
	{
		self.var_3FB3 = self.summary["rankxp"];
		self.var_3FB4 = self.survival_credit;
		self waittill("xp_updated",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = self.summary["rankxp"] - self.var_3FB3;
		self.survival_credit = self.survival_credit + var_01;
		if(isdefined(self.rankupdatetotal) && self.rankupdatetotal > var_01)
		{
			thread func_3FBA(self.var_3FB4,self.rankupdatetotal);
		}
		else
		{
			thread func_3FBA(self.var_3FB4,var_01);
		}

		self notify("deposit_credits",var_01);
	}
}

//Function Number: 78
func_3FB5()
{
	self endon("death");
	for(;;)
	{
		self.var_3FB3 = self.summary["rankxp"];
		self.var_3FB4 = self.survival_credit;
		self waittill("credit_updated",var_00);
		var_01 = self.survival_credit - self.var_3FB4;
		if(isdefined(self.rankupdatetotal) && self.rankupdatetotal > var_01)
		{
			thread func_3FBA(self.var_3FB4,self.rankupdatetotal);
		}
		else
		{
			thread func_3FBA(self.var_3FB4,var_01);
		}

		self notify("deposit_credits",var_01,var_00);
	}
}

//Function Number: 79
func_3FB6(param_00)
{
	level endon("special_op_terminated");
	var_01 = "so_survival_regular_music";
	wait 1.5;
	maps\_utility::musicplaywrapper(var_01);
	wait 5;
	maps\_utility::music_stop(20);
}

//Function Number: 80
func_3FB7(param_00)
{
	level endon("special_op_terminated");
	level endon("end_boss_music");
	common_scripts\utility::flag_set("boss_music");
	maps\_utility::music_stop(3);
	if(param_00 == "chopper")
	{
		var_01 = "so_survival_boss_music_01";
	}
	else if(var_01 == "juggernaut")
	{
		var_01 = "so_survival_boss_music_02";
	}
	else
	{
		var_01 = "so_survival_boss_music_01";
	}

	var_02 = maps\_utility::musiclength(var_01) + 2;
	while(common_scripts\utility::flag("boss_music"))
	{
		maps\_utility::musicplaywrapper(var_01);
		wait var_02;
	}
}

//Function Number: 81
hud_init()
{
	level endon("special_op_terminated");
}

//Function Number: 82
func_3FB8()
{
	thread hud_init();
	thread func_3FD5();
	foreach(var_01 in level.players)
	{
		var_01 maps\_so_survival_code::player_reward_splash_init();
		var_01 thread func_3FD0();
		var_01 thread func_3FBF();
		if(getdvarint("survival_chaos") != 1)
		{
			var_01 thread func_3FCD();
		}

		var_01 thread perk_hud();
		var_01 thread func_3FC8();
	}
}

//Function Number: 83
func_3FB9()
{
	maps\_specialops::_setplayerdata_single("surHUD_credits",0);
	maps\_specialops::_setplayerdata_single("surHUD_credits_delta",0);
	maps\_specialops::surhud_enable("credits");
}

//Function Number: 84
func_3FBA(param_00,param_01)
{
	self notify("stop_animate_credits");
	self endon("stop_animate_credits");
	maps\_specialops::_setplayerdata_single("surHUD_credits_delta",0);
	maps\_specialops::surhud_animate("credits");
	maps\_specialops::_setplayerdata_single("surHUD_credits",self.survival_credit);
	maps\_specialops::_setplayerdata_single("surHUD_credits_delta",param_01);
}

//Function Number: 85
func_3FBB()
{
	level endon("special_op_terminated");
	var_00 = "Player is either dead or removed while trying to setup its hud.";
	var_01 = 28;
	var_02 = maps\_specialops::so_hud_ypos();
	var_03 = var_02 + 12 + var_01;
	self.var_3FBC = maps\_specialops::so_create_hud_item(-1,var_02,&"SO_SURVIVAL_SURVIVE_TIME",self,1);
	self.var_3FBD = maps\_specialops::so_create_hud_item(-1,var_02 - var_01,undefined,self,1);
	self.var_3FBC.alignx = "left";
	self.var_3FBD.alignx = "left";
	self.var_3FBD setshader("hud_show_timer",var_01,var_01);
	self.var_3FBD.alpha = 0;
	self.var_3FBC.alpha = 0;
	thread func_3FBE(self.var_3FBC,self.var_3FBD);
}

//Function Number: 86
func_3FBE(param_00,param_01)
{
	level endon("special_op_terminated");
	self endon("death");
	func_3F70();
	for(;;)
	{
		param_00.label = "";
		param_00 settenthstimerup(0);
		var_02 = gettime();
		param_00 thread maps\_hud_util::fade_over_time(1,0.5);
		param_01 thread maps\_hud_util::fade_over_time(1,0.5);
		level waittill("wave_ended");
		param_00.label = "";
		var_03 = max(1,gettime() - var_02 / 1000);
		param_00 settenthstimerstatic(var_03);
		var_04 = "";
		if(1)
		{
			var_04 = common_scripts\utility::waittill_any_timeout(1.75,"wave_started");
		}

		if(isdefined(var_04) && var_04 == "wave_started")
		{
			param_00 thread maps\_hud_util::fade_over_time(0,0);
			param_01 thread maps\_hud_util::fade_over_time(0,0);
			continue;
		}

		param_00 thread maps\_hud_util::fade_over_time(0,0.5);
		param_01 thread maps\_hud_util::fade_over_time(0,0.5);
		level waittill("wave_started");
	}
}

//Function Number: 87
func_3FBF()
{
	self endon("death");
	self.var_3FC0 = 0;
	if(issplitscreen())
	{
		self.var_3FC1 = 112 + self == level.player * 27;
	}
	else
	{
		self.var_3FC1 = 196;
	}

	if(getdvarint("survival_chaos") == 1)
	{
		self.var_3FC2 = 38;
	}
	else
	{
		self.var_3FC2 = 28;
	}

	self.var_3FC3 = func_3FCF(self.var_3FC0,self.var_3FC1);
	self.var_3FC3 setshader("teamperk_blast_shield",self.var_3FC2,self.var_3FC2);
	self.var_3FC3.alpha = 0.85;
	self.var_3FC4 = func_3FCF(self.var_3FC0,self.var_3FC1);
	self.var_3FC4.alpha = 0;
	thread func_3FC6();
	waittillframeend;
	for(;;)
	{
		if(isdefined(self.armor) && isdefined(self.armor["points"]) && self.armor["points"])
		{
			if(getdvarint("survival_chaos") == 1)
			{
				var_00 = 250;
			}
			else
			{
				var_00 = 100;
			}

			var_01 = maps\_so_survival_code::float_capped(self.armor["points"] / var_00 / 2,0,1);
			var_02 = 1 - maps\_so_survival_code::float_capped(self.armor["points"] - var_00 / 2 / var_00 / 2,0,1);
			self.var_3FC3.alpha = 0.85;
			self.var_3FC3.color = (1,maps\_so_survival_code::float_capped(var_01,0,0.95),maps\_so_survival_code::float_capped(var_01,0,0.7));
			if(getdvarint("survival_chaos") == 1)
			{
				if(self.armor["points"] < var_00)
				{
					thread func_3FC5();
				}
			}
			else
			{
				thread func_3FC5();
			}
		}
		else
		{
			self.var_3FC3.alpha = 0;
		}

		common_scripts\utility::waittill_any("damage","health_update");
	}
}

//Function Number: 88
func_3FC5()
{
	self endon("death");
	self.var_3FC4.alpha = 0.85;
	var_00 = 20;
	for(var_01 = 0;var_01 <= var_00;var_01++)
	{
		var_02 = randomint(int(max(1,5 - var_01 / var_00 / 5))) - int(2 - var_01 / var_00 / 2);
		self.var_3FC3.x = self.var_3FC0 + var_02;
		self.var_3FC3.y = self.var_3FC1 + var_02;
		var_03 = int(var_01 * 40 / var_00);
		self.var_3FC4 setshader("teamperk_blast_shield",self.var_3FC2 + var_03,self.var_3FC2 + var_03);
		self.var_3FC4.alpha = max(var_00 * 0.85 - var_01 / var_00,0);
		wait 0.05;
	}

	self.var_3FC4.alpha = 0;
	self.var_3FC3.x = self.var_3FC0;
	self.var_3FC3.y = self.var_3FC1;
}

//Function Number: 89
func_3FC6(param_00)
{
	self endon("death");
	self.var_3FC7 = func_3FCF(self.var_3FC0,self.var_3FC1);
	self.var_3FC7.alpha = 0.85;
	self.var_3FC7.elemtype = "font";
	self.var_3FC7.label = &"SO_SURVIVAL_ARMOR_POINTS";
	self.var_3FC7.y = self.var_3FC7.y - 2;
	self.var_3FC7.x = self.var_3FC7.x - 58;
	self.var_3FC7.font = "hudbig";
	self.var_3FC7.fontscale = 0.5;
	self.var_3FC7.width = 0;
	self.var_3FC7.color = (1,0.95,0.7);
	self.var_3FC7.alignx = "left";
	if(isdefined(self.armor))
	{
		self.var_3FC7 setvalue(self.armor["points"]);
	}
	else
	{
		self.var_3FC7 setvalue(0);
	}

	var_01 = 14;
	for(;;)
	{
		if(!isdefined(self.armor) || !isdefined(self.armor["points"]) || !self.armor["points"])
		{
			self.var_3FC7.alpha = 0;
			wait 0.05;
			continue;
		}

		self.var_3FC7.alpha = 0.85;
		var_02 = "";
		var_03 = 2;
		var_04 = 6;
		while(var_04 > 0 || var_01 > 0)
		{
			var_02 = common_scripts\utility::waittill_any_timeout(0.5,"damage","health_update");
			self.var_3FC7 setvalue(self.armor["points"]);
			var_04 = var_04 - 0.5;
			if(var_01 > 0)
			{
				var_01 = var_01 - 0.5;
			}

			if(self.armor["points"] <= 0)
			{
				var_03 = 0.5;
				break;
			}
		}

		self.var_3FC7 fadeovertime(var_03);
		self.var_3FC7.alpha = 0;
		if(var_02 != "damage" && var_02 != "health_update")
		{
			common_scripts\utility::waittill_any("damage","health_update");
		}
	}
}

//Function Number: 90
func_3FC8()
{
	self endon("death");
	maps\_specialops::surhud_disable("enemy");
	maps\_specialops::_setplayerdata_single("surHUD_enemy",0);
	for(;;)
	{
		level common_scripts\utility::waittill_either("axis_spawned","axis_died");
		if(!common_scripts\utility::flag("aggressive_mode"))
		{
			maps\_specialops::surhud_disable("enemy");
			continue;
		}

		if(getdvarint("survival_chaos") != 1)
		{
			maps\_specialops::surhud_enable("enemy");
			maps\_specialops::_setplayerdata_single("surHUD_enemy",level.enemy_remaining);
		}
	}
}

//Function Number: 91
perk_hud()
{
	self endon("death");
	self.var_3FC9 = spawnstruct();
	if(getdvarint("survival_chaos") == 1)
	{
		self.var_3FC9.var_3FCA = -138 + level.perk_offset;
	}
	else
	{
		self.var_3FC9.var_3FCA = -138;
	}

	if(issplitscreen())
	{
		self.var_3FC9.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.var_3FC9.var_3FCB = 196;
	}

	self.var_3FC9.var_3FCC = 28;
	self.var_3FC9.icon = func_3FCF(self.var_3FC9.var_3FCA,self.var_3FC9.var_3FCB);
	self.var_3FC9.icon.color = (1,1,1);
	self.var_3FC9.icon.alpha = 0;
	for(;;)
	{
		self waittill("give_perk",var_00);
		var_01 = level.armory["airsupport"][var_00].icon;
		self.var_3FC9.icon setshader(var_01,self.var_3FC9.var_3FCC,self.var_3FC9.var_3FCC);
		self.var_3FC9.icon.alpha = 0.85;
	}
}

//Function Number: 92
func_3FCD()
{
	self endon("death");
	self.var_3FCE = spawnstruct();
	self.var_3FCE.var_3FCA = -104;
	if(issplitscreen())
	{
		self.var_3FCE.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.var_3FCE.var_3FCB = 196;
	}

	self.var_3FCE.var_3FCC = 28;
	self.var_3FCE.icon = func_3FCF(self.var_3FCE.var_3FCA,self.var_3FCE.var_3FCB);
	self.var_3FCE.icon setshader("specialty_self_revive",self.var_3FCE.var_3FCC,self.var_3FCE.var_3FCC);
	self.var_3FCE.icon.color = (1,1,1);
	self.var_3FCE.icon.alpha = 0;
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("laststand_lives_updated","player_downed");
		if(var_00 == "player_downed")
		{
			self.var_3FCE.icon.alpha = 0;
			continue;
		}

		if(maps\_laststand::get_lives_remaining() > 0)
		{
			self.var_3FCE.icon.alpha = 1;
			continue;
		}

		self.var_3FCE.icon.alpha = 0;
	}
}

//Function Number: 93
func_3FCF(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.hidden = 0;
	var_02.elemtype = "icon";
	var_02.hidewheninmenu = 1;
	var_02.archived = 0;
	var_02.x = param_00;
	var_02.y = param_01;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	return var_02;
}

//Function Number: 94
func_3FD0()
{
	self endon("death");
	maps\_specialops::surhud_disable("wave");
	maps\_specialops::_setplayerdata_single("surHUD_wave",0);
	for(;;)
	{
		level waittill("wave_started");
		maps\_specialops::surhud_enable("wave");
		maps\_specialops::_setplayerdata_single("surHUD_wave",level.current_wave);
	}
}

//Function Number: 95
matchstarttimer(param_00)
{
	var_01 = func_3FD1("hudbig",1);
	var_01 maps\_hud_util::setpoint("CENTER","CENTER",0,0);
	var_01.sort = 1001;
	var_01.glowcolor = (0.15,0.35,0.85);
	var_01.color = (0.95,0.95,0.95);
	var_01.foreground = 0;
	var_01.hidewheninmenu = 1;
	var_01 fontpulseinit();
	matchstarttimer_internal(int(param_00),var_01);
	var_01 destroy();
}

//Function Number: 96
fontpulseinit(param_00)
{
	self.basefontscale = self.fontscale;
	if(isdefined(param_00))
	{
		self.maxfontscale = min(param_00,6.3);
	}
	else
	{
		self.maxfontscale = min(self.fontscale * 2,6.3);
	}

	self.inframes = 2;
	self.outframes = 4;
}

//Function Number: 97
func_3FD1(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.elemtype = "font";
	var_02.font = "hudbig";
	var_02.fontscale = param_01;
	var_02.basefontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 maps\_hud_util::setparent(level.uiparent);
	var_02.hidden = 0;
	return var_02;
}

//Function Number: 98
matchstarttimer_internal(param_00,param_01)
{
	while(param_00 > 0)
	{
		if(param_00 > 99)
		{
			param_01.alpha = 0;
		}
		else
		{
			param_01.alpha = 1;
		}

		foreach(var_03 in level.players)
		{
			var_03 playsound("so_countdown_beep");
		}

		param_01 thread fontpulse();
		wait param_01.inframes * 0.05;
		param_01 setvalue(param_00);
		param_00--;
		wait 1 - param_01.inframes * 0.05;
	}
}

//Function Number: 99
fontpulse()
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	self changefontscaleovertime(self.inframes * 0.05);
	self.fontscale = self.maxfontscale;
	wait self.inframes * 0.05;
	self changefontscaleovertime(self.outframes * 0.05);
	self.fontscale = self.basefontscale;
}

//Function Number: 100
func_3FD2()
{
	func_3F96();
	maps\_specialops::surhud_disable("performance");
}

//Function Number: 101
func_3FD3(param_00)
{
	self endon("death");
	if(maps\_utility::is_coop())
	{
		waittillframeend;
	}

	foreach(var_04, var_02 in self.var_3F95)
	{
		maps\_specialops::_setplayerdata_array("surHUD_performance",var_04,self.var_3F95[var_04]);
		maps\_specialops::_setplayerdata_array("surHUD_performance_credit",var_04,param_00[var_04]);
		if(maps\_utility::is_coop())
		{
			var_03 = maps\_utility::get_other_player(self);
			maps\_specialops::_setplayerdata_array("surHUD_performance_p2",var_04,var_03.var_3F95[var_04]);
		}
	}

	maps\_specialops::_setplayerdata_single("surHUD_performance_reward",param_00["total"]);
	wait 1;
	maps\_specialops::surhud_animate("performance");
}

//Function Number: 102
func_3FD4(param_00)
{
	var_01 = "---------------------------------------------";
	var_02 = "COOP";
	if(!maps\_utility::is_coop())
	{
		var_02 = "SOLO";
	}

	foreach(var_05, var_04 in param_00)
	{
		if(var_05 == "total")
		{
			continue;
		}
	}
}

//Function Number: 103
func_3FD5()
{
	level endon("special_op_terminated");
	func_3F70();
	for(;;)
	{
		level waittill("wave_started");
		thread func_3FD6("");
		level waittill("wave_ended",var_00);
		maps\_so_survival_code::waittill_players_ready_for_splash(10);
		thread func_3FD7(var_00);
	}
}

//Function Number: 104
func_3FD6(param_00)
{
	var_01 = spawnstruct();
	var_01.title = &"SO_SURVIVAL_WAVE_TITLE";
	var_01.duration = 1.5;
	var_01.sound = "survival_wave_start_splash";
	common_scripts\utility::array_thread(level.players,::func_3FD8,var_01);
}

//Function Number: 105
func_3FD7(param_00)
{
	var_01 = spawnstruct();
	var_01.title = &"SO_SURVIVAL_WAVE_SUCCESS_TITLE";
	var_01.title_set_value = param_00;
	var_01.duration = 2.5;
	var_01.sound = "survival_wave_end_splash";
	common_scripts\utility::array_thread(level.players,::func_3FD8,var_01);
}

//Function Number: 106
func_3FD8(param_00)
{
	if(isdefined(self.doingnotify) && self.doingnotify)
	{
		while(self.doingnotify)
		{
			wait 0.05;
		}
	}

	if(!isdefined(param_00.duration))
	{
		param_00.duration = 1.5;
	}

	param_00.title_glowcolor = (0.15,0.35,0.85);
	param_00.title_color = (0.95,0.95,0.95);
	param_00.type = "wave";
	param_00.title_font = "hudbig";
	param_00.playsoundlocally = 1;
	param_00.zoomin = 1;
	param_00.var_3E34 = 1;
	param_00.fadein = 1;
	param_00.fadeout = 1;
	if(issplitscreen())
	{
		param_00.title_basefontscale = 1;
		param_00.desc_basefontscale = 1.2;
	}
	else
	{
		param_00.title_basefontscale = 1.1;
		param_00.desc_basefontscale = 1.2;
	}

	maps\_so_survival_code::splash_notify_message(param_00);
}

//Function Number: 107
func_3FD9()
{
	level endon("special_op_terminated");
	foreach(var_01 in level.players)
	{
		var_01 maps\_specialops::surhud_disable("armory");
		var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","name","");
		var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","icon","");
		var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","desc","");
	}

	for(;;)
	{
		level waittill("armory_open",var_03);
		var_04 = "";
		var_05 = "";
		var_06 = var_03.icon;
		if(var_03.armory_type == "weapon")
		{
			var_04 = "@SO_SURVIVAL_ARMORY_WEAPON_AV";
			var_05 = "@SO_SURVIVAL_ARMORY_WEAPON_DESC";
		}
		else if(var_03.armory_type == "airsupport")
		{
			var_04 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_AV";
			var_05 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_DESC";
		}
		else if(var_03.armory_type == "equipment")
		{
			var_04 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_AV";
			var_05 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_DESC";
		}

		foreach(var_01 in level.players)
		{
			var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","name",var_04);
			var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","icon",var_06);
			var_01 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory","desc",var_05);
			var_01 maps\_specialops::surhud_animate("armory");
		}
	}
}
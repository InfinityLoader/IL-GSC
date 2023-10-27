/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_load.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 66
 * Decompile Time: 934 ms
 * Timestamp: 10/27/2023 1:37:15 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	level.func["setsaveddvar"] = ::function_0168;
	level.func["useanimtree"] = ::method_826D;
	level.func["setanim"] = ::method_825C;
	level.func["setanimknob"] = ::method_8254;
	level.func["setflaggedanimknob"] = ::method_8263;
	level.func["setflaggedanimknobrestart"] = ::method_8265;
	level.func["setanimlimited"] = ::method_825D;
	level.func["setanimtime"] = ::method_826F;
	level.func["getanimtime"] = ::method_8260;
	level.func["getanimlength"] = ::getanimlength;
	level.func["clearanim"] = ::method_8253;
	level.func["kill"] = ::method_82E7;
	level.func["magicgrenade"] = ::function_0193;
	func_6EA5();
	level.global_callbacks = [];
	level.global_callbacks["_autosave_stealthcheck"] = ::func_3D2C;
	level.global_callbacks["_patrol_endon_spotted_flag"] = ::func_3D2C;
	level.global_callbacks["_spawner_stealth_default"] = ::func_3D2C;
	level.global_callbacks["_idle_call_idle_func"] = ::func_3D2C;
	if(!isdefined(level.var_8A0D))
	{
		level.var_8A0D = "cheat_bw";
	}

	visionsetthermal(level.var_8A0D);
	visionsetpain("near_death");
	level.func["damagefeedback"] = ::maps\_damagefeedback::func_86E0;
	common_scripts\utility::func_F1B(getentarray("script_model_pickup_claymore","classname"),::func_1CA5);
	common_scripts\utility::func_F1B(getentarray("ammo_cache","targetname"),::ammo_cache_think_global);
	maps\_utility::array_delete(getentarray("trigger_multiple_softlanding","classname"));
	if(getdvar("debug") == "")
	{
		setdvar("debug","0");
	}

	if(getdvar("fallback") == "")
	{
		setdvar("fallback","0");
	}

	if(getdvar("angles") == "")
	{
		setdvar("angles","0");
	}

	if(getdvar("noai") == "")
	{
		setdvar("noai","off");
	}

	if(getdvar("scr_RequiredMapAspectratio") == "")
	{
		setdvar("scr_RequiredMapAspectratio","1");
	}

	setdvar("ac130_player_num",-1);
	setdvar("ui_remotemissile_playernum",0);
	setdvar("ui_pmc_won",0);
	setdvar("ui_actionSlot_1_forceActive","off");
	setdvar("ui_actionSlot_2_forceActive","off");
	setdvar("ui_actionSlot_3_forceActive","off");
	setdvar("ui_actionSlot_4_forceActive","off");
	setdvar("ui_dog_grenade",0);
	setdvar("hideHudFast",0);
	setdvar("ui_securing","");
	setdvar("ui_securing_progress",0);
	setdvar("hud_showObjectives",1);
	setdvar("hud_showIntel",1);
	setdvar("minimap_sp",0);
	setdvar("minimap_full_sp",0);
	if(!isdefined(level.var_56F7))
	{
		anim.var_56F7 = [];
		animscripts/notetracks::func_646F();
	}

	common_scripts\utility::func_3385("introscreen_complete");
	maps\_utility::add_start("no_game",::func_7A66);
	add_no_game_starts();
	level._loadstarted = 1;
	level.first_frame = 1;
	level.level_specific_dof = 0;
	thread func_653E();
	level.var_8A69 = [];
	level.var_6952 = [];
	level.run_call_after_wait_array = [];
	level.run_noself_call_after_wait_array = [];
	level.do_wait_endons_array = [];
	level.var_7BD = [];
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	level.var_2740["center"] = "dirt_effect_center";
	level.var_2740["left"] = "dirt_effect_left";
	level.var_2740["right"] = "dirt_effect_right";
	precachemenu(level.var_2740["center"]);
	precachemenu(level.var_2740["left"]);
	precachemenu(level.var_2740["right"]);
	precachematerial("fullscreen_dirt_bottom_b");
	precachematerial("fullscreen_dirt_bottom");
	precachematerial("fullscreen_dirt_left");
	precachematerial("fullscreen_dirt_right");
	precachematerial("fullscreen_bloodsplat_bottom");
	precachematerial("fullscreen_bloodsplat_left");
	precachematerial("fullscreen_bloodsplat_right");
	precachematerial("black");
	precachematerial("white");
	level.ai_number = 0;
	if(!isdefined(level.flag))
	{
		common_scripts\utility::func_4549();
	}
	else
	{
		var_00 = getarraykeys(level.flag);
		common_scripts\utility::array_levelthread(var_00,::check_flag_for_stat_tracking);
	}

	func_4561();
	if(issplitscreen())
	{
		function_0168("cg_fovScale","0.75");
	}
	else
	{
		function_0168("cg_fovScale","1");
	}

	level.var_62B6 = 0;
	common_scripts\utility::func_3385("missionfailed");
	common_scripts\utility::func_3385("auto_adjust_initialized");
	common_scripts\utility::func_3385("_radiation_poisoning");
	common_scripts\utility::func_3385("gameskill_selected");
	common_scripts\utility::func_3385("battlechatter_on_thread_waiting");
	common_scripts\utility::func_3385("start_is_set");
	thread maps\_gameskill::aa_init_stats();
	thread func_5DBE();
	level.default_run_speed = 190;
	function_0168("g_speed",level.default_run_speed);
	if(maps\_utility::func_4840())
	{
		function_0168("sv_saveOnStartMap",0);
	}
	else if(isdefined(level.var_2131))
	{
		function_0168("sv_saveOnStartMap",0);
	}
	else
	{
		function_0168("sv_saveOnStartMap",1);
	}

	common_scripts\utility::create_lock("mg42_drones");
	common_scripts\utility::create_lock("mg42_drones_target_trace");
	level.dronestruct = [];
	foreach(var_03, var_02 in level.struct)
	{
		if(!isdefined(var_02.targetname))
		{
			continue;
		}

		if(var_02.targetname == "delete_on_load")
		{
			level.struct[var_03] = undefined;
		}
	}

	common_scripts\utility::func_7CF9();
	common_scripts\utility::func_3385("respawn_friendlies");
	common_scripts\utility::func_3385("player_flashed");
	level.connectpathsfunction = ::connectpaths;
	level.disconnectpathsfunction = ::disconnectpaths;
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	level.isaifunc = ::isai;
	level.createclientfontstring_func = ::maps\_hud_util::func_20D1;
	level.hudsetpoint_func = ::maps\_hud_util::func_70A4;
	level.var_5014 = ::makeentitysentient;
	level.var_3507 = ::freeentitysentient;
	level.laseron_func = ::method_82EC;
	level.laseroff_func = ::method_82ED;
	level.var_7B06 = ::maps\_player_stats::func_6454;
	level.var_7B05 = ::maps\_player_stats::func_6461;
	level.var_2A05 = 1;
	level.autosave_threat_check_enabled = 1;
	level.getnodefunction = ::getnode;
	level.getnodearrayfunction = ::getnodearray;
	level.addaieventlistener_func = ::method_8310;
	if(!isdefined(level._notetrackfx))
	{
		level._notetrackfx = [];
	}

	foreach(var_05 in level.players)
	{
		var_05.maxhealth = level.player.health;
		var_05.var_73FD = 0;
		var_05.var_47AD = 0;
		var_05 thread func_8D33();
	}

	level.var_4C11 = -5000;
	level.var_4190 = [];
	thread func_610A();
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_05 = level.players[var_07];
		var_05 thread maps\_utility::flashmonitor();
		var_05 thread maps\_utility::func_7414();
	}

	precachemodel("fx");
	precachemodel("tag_origin");
	precachemodel("tag_ik_target");
	precacheshellshock("victoryscreen");
	precacheshellshock("default");
	precacheshellshock("flashbang");
	precacheshellshock("dog_bite");
	precacherumble("damage_heavy");
	precacherumble("damage_light");
	precacherumble("grenade_rumble");
	precacherumble("artillery_rumble");
	precacherumble("slide_start");
	precacherumble("slide_loop");
	precachestring(&"GAME_GET_TO_COVER");
	precachestring(&"GAME_LAST_STAND_GET_BACK_UP");
	precachestring(&"SCRIPT_GRENADE_DEATH");
	precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE1");
	precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE2");
	precachestring(&"SCRIPT_EXPLODING_VEHICLE_DEATH");
	precachestring(&"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
	precachestring(&"SCRIPT_EXPLODING_BARREL_DEATH");
	precachematerial("hud_grenadeicon");
	precachematerial("hud_grenadepointer");
	precachematerial("hud_burningcaricon");
	precachematerial("death_juggernaut");
	precachematerial("death_friendly_fire");
	precachematerial("hud_destructibledeathicon");
	precachematerial("hud_burningbarrelicon");
	precachematerial("waypoint_ammo");
	level._effect["deathfx_bloodpool_generic"] = loadfx("fx/impacts/deathfx_bloodpool_generic");
	animscripts/pain::initpainfx();
	animscripts/melee::func_516B();
	level.createfx_enabled = getdvar("createfx") != "";
	func_761D();
	maps\_mgturret::func_4FDD();
	common_scripts\_exploder::func_71F8();
	maps\_gameskill::func_70C9();
	maps\_art::func_4FDD();
	maps\_anim::func_44DF();
	thread common_scripts\_fx::func_460F();
	if(level.createfx_enabled)
	{
	}

	maps\_global_fx_code::func_44DF();
	maps\_global_fx::func_4FDD();
	func_2493();
	maps\_detonategrenades::func_44DF();
	maps\_lights::func_44DF();
	maps\_names::func_7193();
	if(isdefined(level.var_3F50))
	{
		thread [[ level.var_3F50 ]]();
	}
	else
	{
		thread handle_starts();
	}

	if(!isdefined(level.trigger_flags))
	{
		common_scripts\utility::func_45C2();
	}

	level.var_4B2C = [];
	maps\_audio::init_audio();
	maps\_trigger::func_459F();
	function_0168("ufoHitsTriggers","0");
	func_283A();
	if(getdvar("g_connectpaths") == "2")
	{
		level waittill("eternity");
	}

	maps\_autosave::func_4FDD();
	if(!isdefined(level.animsounds))
	{
		thread func_4515();
	}

	maps\_anim::func_44DF();
	anim.var_87B9 = 0;
	if(!isdefined(level.var_52F1))
	{
		level.var_52F1 = 0;
	}

	if(!maps\_utility::func_4840())
	{
		maps\_loadout::func_4568();
		function_0168("ui_campaign",level.var_1973);
	}

	common_scripts\_destructible::func_44DF();
	thread maps\_vehicle::init_vehicles();
	func_7085();
	common_scripts\_dynamic_world::func_44DF();
	thread maps\_autosave::beginningoflevelsave();
	thread maps\_introscreen::func_4FDD();
	thread maps\_endmission::func_4FDD();
	thread maps\_damagefeedback::func_44DF();
	maps\_friendlyfire::func_4FDD();
	common_scripts\utility::array_levelthread(getentarray("badplace","targetname"),::badplace_think);
	common_scripts\utility::array_levelthread(getentarray("delete_on_load","targetname"),::maps\_utility::func_2588);
	common_scripts\utility::func_F1B(getnodearray("traverse","targetname"),::func_82DD);
	common_scripts\utility::func_F1B(getentarray("piano_key","targetname"),::pianothink);
	common_scripts\utility::func_F1B(getentarray("piano_damage","targetname"),::pianodamagethink);
	common_scripts\utility::func_F1B(getentarray("water","targetname"),::func_8D74);
	common_scripts\utility::func_F1B(getentarray("kill_all_players","targetname"),::func_4AB8);
	common_scripts\utility::func_3385("allow_ammo_pickups");
	common_scripts\utility::flag_set("allow_ammo_pickups");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_grenade_launcher","targetname"),::ammo_pickup,"grenade_launcher");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_rpg","targetname"),::ammo_pickup,"rpg");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_c4","targetname"),::ammo_pickup,"c4");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_claymore","targetname"),::ammo_pickup,"claymore");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_556","targetname"),::ammo_pickup,"556");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_762","targetname"),::ammo_pickup,"762");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_45","targetname"),::ammo_pickup,"45");
	common_scripts\utility::func_F1B(getentarray("ammo_pickup_pistol","targetname"),::ammo_pickup,"pistol");
	thread maps\_intelligence::func_4FDD();
	thread maps\_gameskill::playerhealthregeninit();
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_05 = level.players[var_07];
		if(!maps\_utility::in_alien_mode())
		{
			var_05 thread maps\_gameskill::func_5FB3();
		}

		var_05 thread playerdamagerumble();
	}

	thread maps\_player_death::func_4FDD();
	thread massnodeinitfunctions();
	common_scripts\utility::func_3385("spawning_friendlies");
	common_scripts\utility::func_3385("friendly_wave_spawn_enabled");
	common_scripts\utility::func_337C("spawning_friendlies");
	level.friendly_spawner["rifleguy"] = getentarray("rifle_spawner","script_noteworthy");
	level.friendly_spawner["smgguy"] = getentarray("smg_spawner","script_noteworthy");
	level.var_77C6 = [];
	level.var_77C6["allies"] = [];
	level.var_77C6["axis"] = [];
	level.var_77C6["team3"] = [];
	level.var_77C6["neutral"] = [];
	thread maps\_spawner::func_3D6E();
	thread maps\_spawner::friendlychains();
	thread maps\_spawner::func_356E();
	common_scripts\utility::func_F1B(getentarray("friendly_spawn","targetname"),::maps\_spawner::friendlyspawnwave);
	common_scripts\utility::func_F1B(getentarray("flood_and_secure","targetname"),::maps\_spawner::func_3437);
	common_scripts\utility::func_F1B(getentarray("window_poster","targetname"),::func_8DFD);
	if(!isdefined(level.var_8358))
	{
		level.var_8358 = [];
		level.var_8357 = [];
	}

	level.var_73D7 = [];
	level.var_77D2 = [];
	maps\_spawner::func_4FDD();
	common_scripts\utility::func_F1B(getentarray("background_block","targetname"),::background_block);
	maps\_hud::func_44DF();
	thread func_4E86();
	thread maps\_animatedmodels::func_4FDD();
	thread func_8D8F();
	if(level.script == level.var_52F3.var_4DBC[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP"))
	{
		maps\_utility::func_252F(0.1,::update_gamer_profile);
	}

	level notify("load_finished");
	func_696F();
}

//Function Number: 2
update_gamer_profile()
{
	level.player setlocalplayerprofiledata("hasEverPlayed_SP",1);
	function_01D2();
}

//Function Number: 3
func_696F()
{
	if(isdefined(level.var_60C7))
	{
		foreach(var_01 in level.var_60C7)
		{
			[[ var_01 ]]();
		}
	}
}

//Function Number: 4
func_6EA5()
{
	level.early_level = [];
	level.early_level["prologue"] = 1;
	level.early_level["deer_hunt"] = 1;
	level.early_level["nml"] = 1;
	level.early_level["homecoming"] = 1;
}

//Function Number: 5
func_8D8F()
{
	var_00 = getentarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].classname) && getsubstr(var_00[var_01].classname,0,7) == "weapon_")
		{
			var_02 = var_00[var_01];
			var_03 = getsubstr(var_02.classname,7);
			if(isdefined(var_02.var_6B30))
			{
				var_04 = weaponclipsize(var_03);
				var_05 = weaponmaxammo(var_03);
				var_02 itemweaponsetammo(var_04,var_05,var_04,0);
				var_06 = weaponaltweaponname(var_03);
				if(var_06 != "none")
				{
					var_07 = weaponclipsize(var_06);
					var_08 = weaponmaxammo(var_06);
					var_02 itemweaponsetammo(var_07,var_08,var_07,1);
				}

				continue;
			}

			var_09 = 0;
			var_04 = undefined;
			var_0A = undefined;
			var_0B = 0;
			var_0C = undefined;
			var_0D = undefined;
			if(isdefined(var_02.var_6B2E))
			{
				var_04 = var_02.var_6B2E;
				var_09 = 1;
			}

			if(isdefined(var_02.var_6B2F))
			{
				var_0A = var_02.var_6B2F;
				var_09 = 1;
			}

			if(isdefined(var_02.var_6B2C))
			{
				var_0C = var_02.var_6B2C;
				var_0B = 1;
			}

			if(isdefined(var_02.script_ammo_alt_extra))
			{
				var_0D = var_02.script_ammo_alt_extra;
				var_0B = 1;
			}

			if(var_09)
			{
				if(!isdefined(var_04))
				{
				}

				if(!isdefined(var_0A))
				{
				}

				var_02 itemweaponsetammo(var_04,var_0A);
			}

			if(var_0B)
			{
				if(!isdefined(var_0C))
				{
				}

				if(!isdefined(var_0D))
				{
				}

				var_02 itemweaponsetammo(var_0C,var_0D,0,1);
			}
		}
	}
}

//Function Number: 6
func_30BC(param_00)
{
	level endon("killexplodertridgers" + param_00.script_exploder);
	param_00 waittill("trigger");
	if(isdefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance)
	{
		if(!param_00 maps\_utility::script_delay())
		{
			wait(4);
		}

		level thread func_30BC(param_00);
	}

	if(!param_00 maps\_utility::script_delay() && isdefined(param_00.var_6BAB))
	{
		wait(param_00.var_6BAB);
	}

	common_scripts\utility::exploder(param_00.script_exploder);
	level notify("killexplodertridgers" + param_00.script_exploder);
}

//Function Number: 7
badplace_think(param_00)
{
	if(!isdefined(level.badplaces))
	{
		level.badplaces = 0;
	}

	level.badplaces++;
	badplace_cylinder("badplace" + level.badplaces,-1,param_00.origin,param_00.radius,1024);
}

//Function Number: 8
playerdamagerumble()
{
	for(;;)
	{
		self waittill("damage",var_00);
		if(isdefined(self.var_78E8))
		{
			continue;
		}

		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 9
map_is_early_in_the_game()
{
	if(isdefined(level.early_level[level.script]))
	{
		return level.early_level[level.script];
	}

	return 0;
}

//Function Number: 10
func_82DD()
{
	var_00 = getent(self.target,"targetname");
	self.var_82CB = var_00.origin[2];
	self.var_82CC = var_00.origin[2] - self.origin[2];
	var_00 delete();
}

//Function Number: 11
pianodamagethink()
{
	var_00 = self getorigin();
	var_01[0] = "large";
	var_01[1] = "small";
	for(;;)
	{
		self waittill("trigger");
		thread common_scripts\utility::func_5D1F("bullet_" + common_scripts\utility::func_6306(var_01) + "_piano",var_00);
	}
}

//Function Number: 12
pianothink()
{
	var_00 = self getorigin();
	var_01 = "piano_" + self.script_noteworthy;
	self sethintstring(&"SCRIPT_PLATFORM_PIANO");
	for(;;)
	{
		self waittill("trigger");
		thread common_scripts\utility::func_5D1F(var_01,var_00);
	}
}

//Function Number: 13
func_8D74()
{
	var_00 = getent(self.target,"targetname");
	var_01 = var_00.origin[2];
	var_00 = undefined;
	level.var_25C5 = 8;
	level.var_25C4 = 33;
	level.depth_allow_stand = 50;
	var_02 = 0;
	for(;;)
	{
		wait(0.05);
		if(!level.player.var_47AD && var_02)
		{
			var_02 = 0;
			level.player method_8274(1);
			level.player method_8273(1);
			level.player method_8272(1);
			thread func_8D75(level.default_run_speed);
		}

		self waittill("trigger");
		level.player.var_47AD = 1;
		var_02 = 1;
		while(level.player istouching(self))
		{
			level.player.var_47AD = 1;
			var_03 = level.player getorigin();
			var_04 = var_03[2] - var_01;
			if(var_04 > 0)
			{
				break;
			}

			var_05 = castint(level.default_run_speed - abs(var_04 * 5));
			if(var_05 < 50)
			{
				var_05 = 50;
			}

			thread func_8D75(var_05);
			if(abs(var_04) > level.var_25C4)
			{
				level.player method_8273(0);
			}
			else
			{
				level.player method_8273(1);
			}

			if(abs(var_04) > level.var_25C5)
			{
				level.player method_8274(0);
				continue;
			}

			level.player method_8274(1);
			wait(0.5);
		}

		level.player.var_47AD = 0;
		wait(0.05);
	}
}

//Function Number: 14
func_8D75(param_00)
{
	level notify("ramping_water_movement_speed");
	level endon("ramping_water_movement_speed");
	var_01 = 0.5;
	var_02 = castint(var_01 * 20);
	var_03 = getdvarint("g_speed");
	var_04 = 0;
	if(param_00 < var_03)
	{
		var_04 = 1;
	}

	var_05 = castint(abs(var_03 - param_00));
	var_06 = castint(var_05 / var_02);
	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		var_03 = getdvarint("g_speed");
		if(var_04)
		{
			function_0168("g_speed",var_03 - var_06);
		}
		else
		{
			function_0168("g_speed",var_03 + var_06);
		}

		wait(0.05);
	}

	function_0168("g_speed",param_00);
}

//Function Number: 15
massnodeinitfunctions()
{
	var_00 = getallnodes();
	thread maps\_mgturret::func_11B1(var_00);
	thread maps\_mgturret::saw_mgturretlink(var_00);
	thread maps\_colors::init_color_grouping(var_00);
}

//Function Number: 16
func_448F(param_00)
{
	var_01 = newhudelem();
	var_01.alignx = "left";
	var_01.aligny = "middle";
	var_01.x = 10;
	var_01.y = 400;
	var_01 settext(param_00);
	var_01.alpha = 0;
	var_01.fontscale = 3;
	wait(1);
	var_01 fadeovertime(1);
	var_01.alpha = 1;
	wait(5);
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait(1);
	var_01 destroy();
}

//Function Number: 17
handle_starts()
{
	level.var_7A9D = addstruct();
	common_scripts\utility::create_dvar("start","");
	if(getdvar("scr_generateClipModels") != "" && getdvar("scr_generateClipModels") != "0")
	{
	}

	if(!isdefined(level.var_7A3F))
	{
		level.var_7A3F = [];
	}

	var_00 = tolower(getdvar("start"));
	var_01 = get_start_dvars();
	if(isdefined(level.start_point))
	{
		var_00 = level.start_point;
	}

	var_02 = 0;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(var_00 == var_01[var_03])
		{
			var_02 = var_03;
			level.start_point = var_01[var_03];
			break;
		}
	}

	if(isdefined(level.var_24AA) && !isdefined(level.start_point))
	{
		foreach(var_06, var_05 in var_01)
		{
			if(level.var_24AA == var_05)
			{
				var_02 = var_06;
				level.start_point = var_05;
				break;
			}
		}
	}

	if(!isdefined(level.start_point))
	{
		if(isdefined(level.default_start))
		{
			level.start_point = "default";
		}
		else if(maps\_utility::func_4DA7())
		{
			level.start_point = level.var_7A3F[0]["name"];
		}
		else
		{
			level.start_point = "default";
		}
	}

	var_07 = getdvarint("sv_loadingsavegame",0);
	if(var_07 != 0)
	{
		var_08 = getdvar("sv_savegametransient","");
		function_020F(var_08);
		if(var_08 != "")
		{
			common_scripts\utility::flag_set(var_08 + "_loaded");
		}
	}
	else if(level.start_point != "default")
	{
		var_09 = level.var_79F6[level.start_point];
		if(isdefined(var_09["transient"]))
		{
			function_020F(var_09["transient"]);
			common_scripts\utility::flag_set(var_09["transient"] + "_loaded");
		}
		else
		{
			function_020F("");
		}
	}
	else
	{
		function_020F("");
	}

	waittillframeend;
	common_scripts\utility::flag_set("start_is_set");
	thread func_7A5C();
	if(level.start_point == "default")
	{
		if(isdefined(level.default_start))
		{
			level thread [[ level.default_start ]]();
		}
	}
	else
	{
		var_09 = level.var_79F6[level.start_point];
		thread [[ var_09["start_func"] ]]();
	}

	if(maps\_utility::func_47DB())
	{
		var_0A = func_39B0(var_01);
		setdvar("start",var_0A);
	}

	waittillframeend;
	if(var_07 != 0)
	{
		wait(0.1);
	}

	var_0B = [];
	if(!maps\_utility::func_47DB() && level.start_point != "no_game")
	{
		var_0C = gettime();
		for(var_03 = 0;var_03 < level.var_7A3F.size;var_03++)
		{
			var_09 = level.var_7A3F[var_03];
			if(var_09["name"] == level.start_point)
			{
				break;
			}

			if(!isdefined(var_09["catchup_function"]))
			{
				continue;
			}

			[[ var_09["catchup_function"] ]]();
		}
	}

	for(var_03 = var_02;var_03 < level.var_7A3F.size;var_03++)
	{
		var_09 = level.var_7A3F[var_03];
		if(!isdefined(var_09["logic_func"]))
		{
			continue;
		}

		if(already_ran_function(var_09["logic_func"],var_0B))
		{
			continue;
		}

		level.var_7A9D [[ var_09["logic_func"] ]]();
		var_0B[var_0B.size] = var_09["logic_func"];
	}
}

//Function Number: 18
already_ran_function(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
func_39B0(param_00)
{
	var_01 = " ** No starts have been set up for this map with maps_utility::add_start().";
	if(param_00.size)
	{
		var_01 = " ** ";
		for(var_02 = param_00.size - 1;var_02 >= 0;var_02--)
		{
			var_01 = var_01 + param_00[var_02] + " ";
		}
	}

	setdvar("start",var_01);
	return var_01;
}

//Function Number: 20
create_start(param_00,param_01)
{
	var_02 = 1;
	var_03 = (0.9,0.9,0.9);
	if(param_01 != -1)
	{
		var_04 = 5;
		if(param_01 != var_04)
		{
			var_02 = 1 - abs(var_04 - param_01) / var_04;
		}
		else
		{
			var_03 = (1,1,0);
		}
	}

	if(var_02 == 0)
	{
		var_02 = 0.05;
	}

	var_05 = newhudelem();
	var_05.alignx = "left";
	var_05.aligny = "middle";
	var_05.x = 80;
	var_05.y = 80 + param_01 * 18;
	var_05 settext(param_00);
	var_05.alpha = 0;
	var_05.foreground = 1;
	var_05.color = var_03;
	var_05.fontscale = 1.75;
	var_05 fadeovertime(0.5);
	var_05.alpha = var_02;
	return var_05;
}

//Function Number: 21
func_7A5C()
{
}

//Function Number: 22
func_7A66()
{
	common_scripts\utility::array_call(function_016B(),::delete);
	common_scripts\utility::array_call(function_016D(),::delete);
}

//Function Number: 23
get_start_dvars()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_7A3F.size;var_01++)
	{
		var_00[var_00.size] = level.var_7A3F[var_01]["name"];
	}

	return var_00;
}

//Function Number: 24
func_27E7()
{
	level.display_starts_pressed = 1;
	if(level.var_7A3F.size <= 0)
	{
	}

	var_00 = get_start_dvars();
	var_00[var_00.size] = "default";
	var_00[var_00.size] = "cancel";
	var_01 = func_7A52();
	var_02 = create_start("Selected Start:",-1);
	var_02.color = (1,1,1);
	var_03 = [];
	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = var_00[var_04];
		var_06 = "[" + var_00[var_04] + "]";
		if(var_05 != "cancel" && var_05 != "default")
		{
			if(isdefined(level.var_79F6[var_05]["start_loc_string"]))
			{
				var_06 = var_06 + " -> ";
				var_06 = var_06 + level.var_79F6[var_05]["start_loc_string"];
			}
		}

		var_03[var_03.size] = var_06;
	}

	var_07 = var_00.size - 1;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	while(var_07 > 0)
	{
		if(var_00[var_07] == level.start_point)
		{
			var_0A = 1;
			break;
		}

		var_07--;
	}

	if(!var_0A)
	{
		var_07 = var_00.size - 1;
	}

	func_7A53(var_01,var_03,var_07);
	var_0B = var_07;
	for(;;)
	{
		if(!level.player buttonpresseddevonly("F10"))
		{
			level.display_starts_pressed = 0;
		}

		if(var_0B != var_07)
		{
			func_7A53(var_01,var_03,var_07);
			var_0B = var_07;
		}

		if(!var_08)
		{
			if(level.player buttonpresseddevonly("UPARROW") || level.player buttonpresseddevonly("DPAD_UP") || level.player buttonpresseddevonly("APAD_UP"))
			{
				var_08 = 1;
				var_07--;
			}
		}
		else if(!level.player buttonpresseddevonly("UPARROW") && !level.player buttonpresseddevonly("DPAD_UP") && !level.player buttonpresseddevonly("APAD_UP"))
		{
			var_08 = 0;
		}

		if(!var_09)
		{
			if(level.player buttonpresseddevonly("DOWNARROW") || level.player buttonpresseddevonly("DPAD_DOWN") || level.player buttonpresseddevonly("APAD_DOWN"))
			{
				var_09 = 1;
				var_07++;
			}
		}
		else if(!level.player buttonpresseddevonly("DOWNARROW") && !level.player buttonpresseddevonly("DPAD_DOWN") && !level.player buttonpresseddevonly("APAD_DOWN"))
		{
			var_09 = 0;
		}

		if(var_07 < 0)
		{
			var_07 = var_00.size - 1;
		}

		if(var_07 >= var_00.size)
		{
			var_07 = 0;
		}

		if(level.player buttonpresseddevonly("BUTTON_B"))
		{
			func_7A26(var_01,var_02);
			break;
		}

		if(level.player buttonpresseddevonly("kp_enter") || level.player buttonpresseddevonly("BUTTON_A") || level.player buttonpresseddevonly("enter"))
		{
			if(var_00[var_07] == "cancel")
			{
				func_7A26(var_01,var_02);
				break;
			}

			setdvar("start",var_00[var_07]);
			level.player openpopupmenu("start");
		}

		wait(0.05);
	}
}

//Function Number: 25
func_7A52()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 11;var_01++)
	{
		var_02 = create_start("",var_01);
		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 26
func_7A53(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = var_03 + param_02 - 5;
		if(isdefined(param_01[var_04]))
		{
			var_05 = param_01[var_04];
		}
		else
		{
			var_05 = "";
		}

		param_00[var_03] settext(var_05);
	}
}

//Function Number: 27
func_7A26(param_00,param_01)
{
	param_01 destroy();
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02] destroy();
	}
}

//Function Number: 28
background_block()
{
	self.origin = self.origin - self.var_6B53;
}

//Function Number: 29
func_6F7F(param_00)
{
	level.var_5F6A = param_00;
	precachemodel(level.var_5F6A);
}

//Function Number: 30
func_7085()
{
	var_00 = "1.0 1.0 1.0";
	var_01 = "0.9 0.9 0.9";
	var_02 = "0.85 0.85 0.85";
	function_0168("con_typewriterColorBase",var_00);
}

//Function Number: 31
ammo_pickup(param_00)
{
	var_01 = [];
	if(param_00 == "grenade_launcher")
	{
		var_01[var_01.size] = "alt_m4_grenadier";
		var_01[var_01.size] = "alt_m4m203_acog";
		var_01[var_01.size] = "alt_m4m203_acog_payback";
		var_01[var_01.size] = "alt_m4m203_eotech";
		var_01[var_01.size] = "alt_m4m203_motion_tracker";
		var_01[var_01.size] = "alt_m4m203_reflex";
		var_01[var_01.size] = "alt_m4m203_reflex_arctic";
		var_01[var_01.size] = "alt_m4m203_silencer";
		var_01[var_01.size] = "alt_m4m203_silencer_reflex";
		var_01[var_01.size] = "alt_m16_grenadier";
		var_01[var_01.size] = "alt_ak47_grenadier";
		var_01[var_01.size] = "alt_ak47_desert_grenadier";
		var_01[var_01.size] = "alt_ak47_digital_grenadier";
		var_01[var_01.size] = "alt_ak47_fall_grenadier";
		var_01[var_01.size] = "alt_ak47_woodland_grenadier";
	}
	else if(param_00 == "rpg")
	{
		var_01[var_01.size] = "rpg";
		var_01[var_01.size] = "rpg_player";
		var_01[var_01.size] = "rpg_straight";
	}
	else if(param_00 == "c4")
	{
		var_01[var_01.size] = "c4";
	}
	else if(param_00 == "claymore")
	{
		var_01[var_01.size] = "claymore";
	}
	else if(param_00 == "556")
	{
		var_01[var_01.size] = "m4_grenadier";
		var_01[var_01.size] = "m4_grunt";
		var_01[var_01.size] = "m4_sd_cloth";
		var_01[var_01.size] = "m4_shotgun";
		var_01[var_01.size] = "m4_silencer";
		var_01[var_01.size] = "m4_silencer_acog";
		var_01[var_01.size] = "m4m203_acog";
		var_01[var_01.size] = "m4m203_acog_payback";
		var_01[var_01.size] = "m4m203_eotech";
		var_01[var_01.size] = "m4m203_motion_tracker";
		var_01[var_01.size] = "m4m203_reflex";
		var_01[var_01.size] = "m4m203_reflex_arctic";
		var_01[var_01.size] = "m4m203_silencer";
		var_01[var_01.size] = "m4m203_silencer_reflex";
		var_01[var_01.size] = "m4m203_silencer";
	}
	else if(param_00 == "762")
	{
		var_01[var_01.size] = "ak47";
		var_01[var_01.size] = "ak47_acog";
		var_01[var_01.size] = "ak47_eotech";
		var_01[var_01.size] = "ak47_grenadier";
		var_01[var_01.size] = "ak47_reflex";
		var_01[var_01.size] = "ak47_shotgun";
		var_01[var_01.size] = "ak47_silencer";
		var_01[var_01.size] = "ak47_thermal";
		var_01[var_01.size] = "ak47_desert";
		var_01[var_01.size] = "ak47_desert_acog";
		var_01[var_01.size] = "ak47_desert_eotech";
		var_01[var_01.size] = "ak47_desert_grenadier";
		var_01[var_01.size] = "ak47_desert_reflex";
		var_01[var_01.size] = "ak47_digital";
		var_01[var_01.size] = "ak47_digital_acog";
		var_01[var_01.size] = "ak47_digital_eotech";
		var_01[var_01.size] = "ak47_digital_grenadier";
		var_01[var_01.size] = "ak47_digital_reflex";
		var_01[var_01.size] = "ak47_fall";
		var_01[var_01.size] = "ak47_fall_acog";
		var_01[var_01.size] = "ak47_fall_eotech";
		var_01[var_01.size] = "ak47_fall_grenadier";
		var_01[var_01.size] = "ak47_fall_reflex";
		var_01[var_01.size] = "ak47_woodland";
		var_01[var_01.size] = "ak47_woodland_acog";
		var_01[var_01.size] = "ak47_woodland_eotech";
		var_01[var_01.size] = "ak47_woodland_grenadier";
		var_01[var_01.size] = "ak47_woodland_reflex";
	}
	else if(param_00 == "45")
	{
		var_01[var_01.size] = "ump45";
		var_01[var_01.size] = "ump45_acog";
		var_01[var_01.size] = "ump45_eotech";
		var_01[var_01.size] = "ump45_reflex";
		var_01[var_01.size] = "ump45_silencer";
		var_01[var_01.size] = "ump45_arctic";
		var_01[var_01.size] = "ump45_arctic_acog";
		var_01[var_01.size] = "ump45_arctic_eotech";
		var_01[var_01.size] = "ump45_arctic_reflex";
		var_01[var_01.size] = "ump45_digital";
		var_01[var_01.size] = "ump45_digital_acog";
		var_01[var_01.size] = "ump45_digital_eotech";
		var_01[var_01.size] = "ump45_digital_reflex";
	}
	else if(param_00 == "pistol")
	{
		var_01[var_01.size] = "beretta";
		var_01[var_01.size] = "beretta393";
		var_01[var_01.size] = "usp";
		var_01[var_01.size] = "usp_scripted";
		var_01[var_01.size] = "usp_silencer";
		var_01[var_01.size] = "glock";
	}

	var_02 = spawn("trigger_radius",self.origin,0,25,32);
	for(;;)
	{
		common_scripts\utility::flag_wait("allow_ammo_pickups");
		var_02 waittill("trigger",var_03);
		if(!common_scripts\utility::flag("allow_ammo_pickups"))
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(!isplayer(var_03))
		{
			continue;
		}

		var_04 = undefined;
		var_05 = undefined;
		var_06 = var_03 getweaponslistall();
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			for(var_08 = 0;var_08 < var_01.size;var_08++)
			{
				if(var_06[var_07] == var_01[var_08])
				{
					var_04 = var_06[var_07];
				}
			}
		}

		if(!isdefined(var_04) && param_00 == "claymore")
		{
			var_05 = 1;
			var_04 = "claymore";
			break;
		}

		if(!isdefined(var_04) && param_00 == "c4")
		{
			var_05 = 1;
			var_04 = "c4";
			break;
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(var_03 getfractionmaxammo(var_04) >= 1)
		{
			continue;
		}

		break;
	}

	if(isdefined(var_05))
	{
		var_03 giveweapon(var_04);
	}
	else
	{
		var_09 = 1;
		if(param_00 == "556" || param_00 == "762")
		{
			var_09 = 30;
		}
		else if(param_00 == "45")
		{
			var_09 = 25;
		}
		else if(param_00 == "pistol")
		{
			var_09 = 15;
		}

		var_03 setweaponammostock(var_04,var_03 getweaponammostock(var_04) + var_09);
	}

	var_03 playlocalsound("grenade_pickup");
	var_02 delete();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 32
func_653E()
{
	wait(0.05);
	level.first_frame = -1;
}

//Function Number: 33
func_4E86()
{
	if(isdefined(game["total characters"]))
	{
		var_00 = game["total characters"];
	}
	else
	{
	}

	var_01 = function_016B("allies");
	var_02 = var_01.size;
	var_03 = 0;
	var_04 = function_016F("allies");
	var_05 = var_04.size;
	var_06 = 0;
	for(;;)
	{
		if((var_02 <= 0 && var_05 <= 0) || var_00 <= 0)
		{
		}

		if(var_02 > 0)
		{
			if(isdefined(var_01[var_03].var_6BD8))
			{
				var_02--;
				var_03++;
				continue;
			}

			var_01[var_03] codescripts\character::func_55AB();
			var_01[var_03] thread codescripts\character::load(game["character" + var_00 - 1]);
			var_02--;
			var_03++;
			var_00--;
			continue;
		}

		if(var_05 > 0)
		{
			if(isdefined(var_04[var_06].var_6BD8))
			{
				var_05--;
				var_06++;
				continue;
			}

			var_07 = game["character" + var_00 - 1];
			maps\_utility::func_6101(var_07["model"]);
			maps\_utility::func_6101(var_07["model"]);
			var_04[var_06] thread maps\_utility::spawn_setcharacter(game["character" + var_00 - 1]);
			var_05--;
			var_06++;
			var_00--;
			continue;
		}
	}
}

//Function Number: 34
check_flag_for_stat_tracking(param_00)
{
	if(!common_scripts\utility::issuffix(param_00,"aa_"))
	{
	}

	[[ level.sp_stat_tracking_func ]](param_00);
}

//Function Number: 35
func_610A()
{
	waittillframeend;
	if(!isdefined(level.var_6AF3))
	{
	}

	var_00 = getarraykeys(level.var_6AF3);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isarray(level.var_6AF3[var_00[var_01]]))
		{
			for(var_02 = 0;var_02 < level.var_6AF3[var_00[var_01]].size;var_02++)
			{
				precachemodel(level.var_6AF3[var_00[var_01]][var_02]);
			}

			continue;
		}

		precachemodel(level.var_6AF3[var_00[var_01]]);
	}
}

//Function Number: 36
func_5DBE()
{
	setdvar("player_died_recently","0");
	thread func_5DC3();
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,"missionfailed");
	level.player maps\_utility::add_wait(::maps\_utility::func_8B71,"death");
	maps\_utility::func_2852();
	var_00 = [];
	var_00[0] = 70;
	var_00[1] = 30;
	var_00[2] = 0;
	var_00[3] = 0;
	setdvar("player_died_recently",var_00[level.gameskill]);
}

//Function Number: 37
func_5DC3()
{
	for(;;)
	{
		var_00 = getdvarint("player_died_recently",0);
		if(var_00 > 0)
		{
			var_00 = var_00 - 5;
			setdvar("player_died_recently",var_00);
		}

		wait(5);
	}
}

//Function Number: 38
func_6408()
{
	self notify("new_recon_player");
	self endon("new_recon_player");
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(var_02))
	{
		var_02 = "script_kill";
	}

	var_03 = 0;
	var_04 = "none";
	var_05 = (0,0,0);
	if(isdefined(var_00))
	{
		var_04 = var_00.classname;
		var_05 = var_00.origin;
		var_06 = vectornormalize(var_05 - self.origin);
		var_07 = anglestoforward(self getangles());
		var_03 = vectordot(var_06,var_07);
	}

	function_0143(self.origin,"script_player_death: playerid %s, enemy %s, enemyposition %v, enemydotproduct %f, cause %s, weapon %s",self.unique_id,var_04,var_05,var_03,var_01,var_02);
	if(isdefined(var_00))
	{
		function_0143(var_00.origin,"script_player_killer: playerid %s, enemy %s, playerposition %v, enemydotproduct %f, cause %s, weapon %s",self.unique_id,var_04,self.origin,var_03,var_01,var_02);
	}

	function_021E("kills","attackername %s attackerteam %s attackerx %f attackery %f attackerz %f attackerweapon %s victimx %f victimy %f victimz %f victimname %s victimteam %s damage %i damagetype %s damagelocation %s attackerisbot %i victimisbot %i timesincespawn %f",var_00.classname,"enemy",var_00.origin[0],var_00.origin[1],var_00.origin[2],var_02,self.origin[0],self.origin[1],self.origin[2],self.unique_id,"player",0,var_01,"",1,0,function_013F() * 0.05);
}

//Function Number: 39
func_6409()
{
	self notify("new_player_downed_recon");
	self endon("new_player_downed_recon");
	self endon("death");
	for(;;)
	{
		self waittill("player_downed");
		var_00 = function_013F() * 0.05;
		var_01 = var_00;
		if(isdefined(self.var_4BFA))
		{
			var_00 = var_01 - self.var_4BFA;
		}

		self.var_4BFA = var_01;
		function_0143(self.origin,"script_player_downed: playerid %s, leveltime %d, deltatime %d",self.unique_id,var_01,var_00);
	}
}

//Function Number: 40
func_4561()
{
	level.players = getentarray("player","classname");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00].unique_id = "player" + var_00;
	}

	level.player = level.players[0];
	if(level.players.size > 1)
	{
		level.var_5D60 = level.players[1];
	}

	level notify("level.players initialized");
	foreach(var_02 in level.players)
	{
		var_02 thread func_6408();
		if(maps\_utility::func_4840())
		{
			var_02 thread func_6409();
		}
	}
}

//Function Number: 41
func_4AB8()
{
	self waittill("trigger",var_00);
	maps\_utility::func_4B09();
}

//Function Number: 42
func_8D33()
{
	if(!isdefined(level.var_3566))
	{
		level.var_3566 = loadfx("fx/misc/thermal_tapereflect_inverted");
	}

	self endon("death");
	var_00 = self getcurrentweapon();
	if(weap_has_thermal(var_00))
	{
		thread func_8078();
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(weap_has_thermal(var_01))
		{
			thread func_8078();
			continue;
		}

		self notify("acogThermalTracker");
	}
}

//Function Number: 43
weap_has_thermal(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponhasthermalscope(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_8078()
{
	self endon("death");
	self notify("acogThermalTracker");
	self endon("acogThermalTracker");
	var_00 = 0;
	for(;;)
	{
		var_01 = var_00;
		var_00 = self playerads();
		if(func_84B2(var_00,var_01))
		{
			func_8075();
		}
		else if(func_84B1(var_00,var_01))
		{
			func_8074();
		}

		wait(0.05);
	}
}

//Function Number: 45
func_84B2(param_00,param_01)
{
	if(param_00 <= param_01)
	{
		return 0;
	}

	if(param_00 <= 0.65)
	{
		return 0;
	}

	return !isdefined(self.var_4806);
}

//Function Number: 46
func_84B1(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		return 0;
	}

	if(param_00 >= 0.8)
	{
		return 0;
	}

	return isdefined(self.var_4806);
}

//Function Number: 47
func_8075()
{
	self.var_4806 = 1;
	var_00 = function_016B("allies");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_3FF5))
		{
			continue;
		}

		var_02.var_3FF5 = 1;
		var_02 thread func_4F66(self.unique_id);
	}

	if(maps\_utility::func_47D0())
	{
		var_04 = maps\_utility::func_3922(self);
		if(!isdefined(var_04.var_3FF5))
		{
			var_04.var_3FF5 = 1;
			var_04 thread func_4F66(self.unique_id,self);
		}
	}
}

//Function Number: 48
func_8074()
{
	self.var_4806 = undefined;
	level notify("thermal_fx_off" + self.unique_id);
	var_00 = function_016B("allies");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].var_3FF5 = undefined;
	}

	if(maps\_utility::func_47D0())
	{
		var_02 = maps\_utility::func_3922(self);
		var_02.var_3FF5 = undefined;
	}
}

//Function Number: 49
func_4F66(param_00,param_01)
{
	if(isdefined(self.var_3FE4))
	{
	}

	level endon("thermal_fx_off" + param_00);
	self endon("death");
	for(;;)
	{
		if(isdefined(param_01))
		{
			playfxontagforclients(level.var_3566,self,"J_Spine4",param_01);
		}
		else
		{
			playfxontag(level.var_3566,self,"J_Spine4");
		}

		wait(0.2);
	}
}

//Function Number: 50
func_1CA5()
{
	precacheitem("claymore");
	self endon("deleted");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"WEAPON_CLAYMORE_PICKUP");
	self makeusable();
	var_00 = weaponmaxammo("claymore") + weaponclipsize("claymore");
	if(isdefined(self.var_6B2E))
	{
		var_00 = self.var_6B2E;
	}

	while(var_00 > 0)
	{
		self waittill("trigger",var_01);
		var_01 playsound("weap_pickup");
		var_02 = 0;
		if(!var_01 hasweapon("claymore"))
		{
			var_01 giveweapon("claymore");
		}
		else
		{
			var_02 = var_01 getammocount("claymore");
		}

		if(isdefined(var_00) && var_00 > 0)
		{
			var_00 = var_02 + var_00;
			var_03 = weaponmaxammo("claymore");
			var_04 = weaponclipsize("claymore");
			if(var_00 >= var_04)
			{
				var_00 = var_00 - var_04;
				var_01 setweaponammoclip("claymore",var_04);
			}

			if(var_00 >= var_03)
			{
				var_00 = var_00 - var_03;
				var_01 setweaponammostock("claymore",var_03);
			}
			else if(var_00 > 0)
			{
				var_01 setweaponammostock("claymore",var_00);
				var_00 = 0;
			}
		}
		else
		{
			var_01 givemaxammo("claymore");
		}

		var_05 = 4;
		if(isdefined(var_01.var_64DA) && var_01.var_64DA == 4)
		{
			var_05 = 2;
		}

		var_01 setactionslot(var_05,"weapon","claymore");
		var_01 switchtoweapon("claymore");
	}

	if(isdefined(self.target))
	{
		var_06 = getentarray(self.target,"targetname");
		foreach(var_08 in var_06)
		{
			var_08 delete();
		}
	}

	self makeunusable();
	self delete();
}

//Function Number: 51
ammo_cache_think_global(param_00)
{
	self endon("remove_ammo_cache");
	self.use_trigger = spawn("script_model",self.origin + (0,0,28));
	self.use_trigger setmodel("tag_origin");
	self.use_trigger makeusable();
	self.use_trigger setcursorhint("HINT_NOICON");
	var_01 = &"WEAPON_CACHE_USE_HINT";
	if(getdvar("consoleGame") == "true")
	{
		var_01 = &"WEAPON_CACHE_USE_CONTROLLER_HINT";
	}

	self.use_trigger sethintstring(var_01);
	if(!isdefined(param_00) || isdefined(param_00) && param_00)
	{
		thread func_0D02();
	}

	for(;;)
	{
		self.use_trigger waittill("trigger",var_02);
		if(isdefined(var_02.dont_allow_ammo_cache))
		{
			continue;
		}

		var_02.var_87E3 = 1;
		self notify("used_ammo_cache");
		self.use_trigger makeunusable();
		var_02 playsound("player_refill_all_ammo");
		var_02 disableweapons();
		var_03 = var_02 getweaponslistall();
		foreach(var_05 in var_03)
		{
			if(var_05 == "claymore")
			{
				continue;
			}

			if(var_05 == "c4")
			{
				continue;
			}

			var_02 givemaxammo(var_05);
			var_06 = weaponclipsize(var_05);
			if(isdefined(var_06))
			{
				if(var_02 getweaponammoclip(var_05) < var_06)
				{
					var_02 setweaponammoclip(var_05,var_06);
				}
			}
		}

		wait(1.5);
		var_02 enableweapons();
		self.use_trigger makeusable();
		var_02.var_87E3 = undefined;
	}
}

//Function Number: 52
func_0D02()
{
	self endon("remove_ammo_cache");
	var_00 = spawn("trigger_radius",self.origin,0,320,72);
	var_01 = newhudelem();
	var_01 setmaterial("waypoint_ammo",1,1);
	var_01.alpha = 0;
	var_01.color = (1,1,1);
	var_01.x = self.origin[0];
	var_01.y = self.origin[1];
	var_01.z = self.origin[2] + 16;
	var_01 setwaypoint(1,1);
	self.ammo_icon = var_01;
	self.var_D03 = var_00;
	if(isdefined(self.icon_always_show) && self.icon_always_show)
	{
		ammo_icon_fade_in(var_01);
	}

	wait(0.05);
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		while(var_02 istouching(var_00))
		{
			var_03 = 1;
			var_04 = var_02 getcurrentweapon();
			if(var_04 == "none")
			{
				var_03 = 0;
			}
			else if(var_02 getfractionmaxammo(var_04) > 0.9)
			{
				var_03 = 0;
			}

			if(maps\_utility::func_5E89(self.origin,0.8,1) && var_03)
			{
				ammo_icon_fade_in(var_01);
				continue;
			}

			ammo_icon_fade_out(var_01);
			wait(0.25);
		}

		ammo_icon_fade_out(var_01);
	}
}

//Function Number: 53
ammo_icon_fade_in(param_00)
{
	if(param_00.alpha != 0)
	{
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0.3;
	wait(0.2);
}

//Function Number: 54
ammo_icon_fade_out(param_00)
{
	if(param_00.alpha == 0)
	{
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0;
	wait(0.2);
}

//Function Number: 55
func_8DFD()
{
	var_00 = getglass(self.target);
	if(!isdefined(var_00))
	{
	}

	level waittillmatch(var_00,"glass_destroyed");
	self delete();
}

//Function Number: 56
func_3D2C(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 57
func_8D97()
{
	common_scripts\utility::create_dvar("weaponlist","0");
	if(!getdvarint("weaponlist"))
	{
	}

	var_00 = getentarray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.code_classname))
		{
			continue;
		}

		if(issubstr(var_03.code_classname,"weapon"))
		{
			var_01[var_03.classname] = 1;
		}
	}

	foreach(var_06 in var_01)
	{
	}

	var_08 = function_016D();
	var_09 = [];
	foreach(var_0B in var_08)
	{
		var_09[var_0B.code_classname] = 1;
	}

	foreach(var_06 in var_09)
	{
	}
}

//Function Number: 58
func_761D()
{
	level.var_7609 = addstruct();
	func_761C();
	function_01DD("_cheat_player_press_slowmo","+melee");
	function_01DD("_cheat_player_press_slowmo","+melee_breath");
	function_01DD("_cheat_player_press_slowmo","+melee_zoom");
}

//Function Number: 59
func_761C()
{
	level.var_7609.var_4D93 = 0;
	level.var_7609.var_4D94 = 0.25;
	level.var_7609.var_7901 = 0.4;
	level.var_7609.var_7900 = 1;
}

//Function Number: 60
add_no_game_starts()
{
	var_00 = getentarray("script_origin_start_nogame","classname");
	if(!var_00.size)
	{
	}

	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_6CBF))
		{
			continue;
		}

		maps\_utility::add_start("no_game_" + var_02.var_6CBF,::func_7A66);
	}
}

//Function Number: 61
func_283A()
{
	if(!maps\_utility::func_4813())
	{
	}

	function_0168("ufoHitsTriggers","1");
	level.var_7C32 = 1;
	if(isdefined(level.custom_no_game_setupfunc))
	{
		level [[ level.custom_no_game_setupfunc ]]();
	}

	maps\_loadout::func_4568();
	maps\_audio::init_audio();
	maps\_global_fx::func_4FDD();
	do_no_game_start_teleport();
	common_scripts\utility::array_call(getentarray("truckjunk","targetname"),::delete);
	common_scripts\utility::array_call(getentarray("truckjunk","script_noteworthy"),::delete);
	level waittill("eternity");
}

//Function Number: 62
do_no_game_start_teleport()
{
	var_00 = getentarray("script_origin_start_nogame","classname");
	if(!var_00.size)
	{
	}

	var_00 = sortbydistance(var_00,level.player.origin);
	if(level.start_point == "no_game")
	{
		level.player maps\_utility::func_7FFD(var_00[0]);
	}

	var_01 = getsubstr(level.start_point,8);
	var_02 = 0;
	foreach(var_04 in var_00)
	{
		if(!isdefined(var_04.var_6CBF))
		{
			continue;
		}

		if(var_01 != var_04.var_6CBF)
		{
			continue;
		}

		if(isdefined(var_04.script_visionset))
		{
			maps\_utility::func_8A02(var_04.script_visionset,0);
		}

		level.player maps\_utility::func_7FFD(var_04);
		var_02 = 1;
		break;
	}

	if(!var_02)
	{
		level.player maps\_utility::func_7FFD(var_00[0]);
	}
}

//Function Number: 63
func_4515()
{
	level.animsounds = [];
	level.animsound_aliases = [];
	waittillframeend;
	waittillframeend;
	var_00 = getarraykeys(level.scr_notetrack);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		func_4575(var_00[var_01]);
	}

	var_00 = getarraykeys(level.var_6AEC);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		init_animsounds_for_animname(var_00[var_01]);
	}
}

//Function Number: 64
init_animsounds_for_animname(param_00)
{
	var_01 = getarraykeys(level.var_6AEC[param_00]);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = level.var_6AEC[param_00][var_03];
		level.animsound_aliases[param_00][var_03]["#" + var_03]["soundalias"] = var_04;
		level.animsound_aliases[param_00][var_03]["#" + var_03]["created_by_animSound"] = 1;
	}
}

//Function Number: 65
func_4575(param_00)
{
	foreach(var_0A, var_02 in level.scr_notetrack[param_00])
	{
		foreach(var_09, var_04 in var_02)
		{
			foreach(var_06 in var_04)
			{
				var_07 = var_06["sound"];
				if(!isdefined(var_07))
				{
					continue;
				}

				level.animsound_aliases[param_00][var_0A][var_09]["soundalias"] = var_07;
				if(isdefined(var_06["created_by_animSound"]))
				{
					level.animsound_aliases[param_00][var_0A][var_09]["created_by_animSound"] = 1;
				}
			}
		}
	}
}

//Function Number: 66
func_2493()
{
	animscripts/utility::func_7039("default",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("asphalt",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("brick",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("carpet",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("cloth",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("concrete",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("cushion",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("dirt",loadfx("fx/impacts/footstep_dust"));
	animscripts/utility::func_7039("foliage",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("grass",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("gravel",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("mud",loadfx("fx/impacts/footstep_mud"));
	animscripts/utility::func_7039("rock",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("sand",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("wood",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("water",loadfx("fx/impacts/footstep_water"));
	animscripts/utility::func_7039("snow",loadfx("fx/misc/blank"));
	animscripts/utility::func_7039("ice",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("default",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("asphalt",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("brick",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("carpet",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("cloth",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("concrete",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("cushion",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("dirt",loadfx("fx/impacts/footstep_dust"));
	animscripts/utility::func_703A("foliage",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("grass",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("gravel",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("mud",loadfx("fx/impacts/footstep_mud"));
	animscripts/utility::func_703A("rock",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("sand",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("wood",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("water",loadfx("fx/impacts/footstep_water"));
	animscripts/utility::func_703A("snow",loadfx("fx/misc/blank"));
	animscripts/utility::func_703A("ice",loadfx("fx/misc/blank"));
	var_00 = "bodyfall small";
	var_01 = "J_SpineLower";
	var_02 = "bodyfall_";
	var_03 = "_small";
	animscripts/utility::setnotetrackeffect(var_00,var_01,"dirt",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"concrete",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"asphalt",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"rock",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	var_04 = ["brick","carpet","foliage","grass","gravel","ice","metal","painted metal","mud","plaster","sand","snow","slush","water","wood","ceramic"];
	foreach(var_06 in var_04)
	{
		animscripts/utility::func_707F(var_00,var_06,var_02,var_03);
	}

	var_00 = "bodyfall small";
	var_01 = "J_SpineLower";
	var_02 = "bodyfall_";
	var_03 = "_large";
	animscripts/utility::setnotetrackeffect(var_00,var_01,"dirt",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"concrete",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"asphalt",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	animscripts/utility::setnotetrackeffect(var_00,var_01,"rock",loadfx("fx/impacts/bodyfall_default_large_runner"),var_02,var_03);
	foreach(var_06 in var_04)
	{
		animscripts/utility::func_707F(var_00,var_06,var_02,var_03);
	}
}
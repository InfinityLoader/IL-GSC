/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\gametypes\escape.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 67
 * Decompile Time: 3448 ms
 * Timestamp: 10/27/2023 12:03:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\cp\_globallogic::init();
	level thread func_C56E();
	func_9569();
	func_97B3();
	func_97B4();
	scripts\cp\_music_and_dialog::init();
	level.var_1B5C = "cp/alien/dpad_tree.csv";
	level.var_C048 = 0;
	level.var_C047 = 0;
	level.wave_num = 0;
	level.var_A9FB = ::func_13F37;
	level.disable_zombie_exo_abilities = 1;
	level.var_93A2 = ::scripts\cp\zombies\zombies_spawning::func_9C12;
	level.var_4C55 = ::lib_0D5B::func_8361;
	level.var_BC70 = ::lib_0D5B::func_12ED5;
	level.var_7FF3 = ::function_00B4;
	level.callbackplayerdamage = ::scripts\cp\zombies\zombie_damage::func_375A;
	level.var_D869 = ::func_13F4B;
	level.var_12DED = ::func_6733;
	level.var_D84B = ::func_5032;
	level.var_C00B = 1;
	level.var_3763 = ::func_13F15;
	level.var_672C = ::func_672B;
	level.var_D75C = "cp/zombies/zombie_powertable.csv";
	level.var_10E5A = "mp/statstable.csv";
	level.var_7666 = "cp/zombies/mode_string_tables/zombies_statstable.csv";
	level.var_7665 = "cp/zombies/zombie_attachmentmap.csv";
	level.var_164B = ::scripts\cp\zombies\_powerups::is_in_active_volume;
	scripts\cp\_weapon::func_13CCB();
	scripts\cp\_utility::func_8CC6(0);
	if(!isdefined(level.var_D782))
	{
		level.var_D782 = [];
	}

	level.var_C7E9 = [];
	level.var_8B38 = getdvarint("scr_aliens_hardcore");
	level.var_E4DD = getdvarint("scr_aliens_ricochet");
	level.var_3B1D = getdvarint("scr_aliens_casual");
	level.var_13F5B = 1;
	level.var_4CC4 = 1;
	level.var_A8E0 = 0;
	level.var_A8F7 = [];
	level.var_3B0F = 1;
	level.var_9925 = 0;
	scripts\cp\_outline::func_C776();
	level.var_C8A4 = 5;
	level.var_69D8 = 0.1;
	level.var_FEFD = 0.1;
	level.var_218B = 0.2;
	level.var_B4B0 = 10;
	level.var_6705 = "objective_complete";
	func_C905();
	scripts\cp\zombies\zombie_afterlife_arcade::func_94D7();
	lib_0D5A::func_97B7();
	scripts\cp\gametypes\zombie::func_D810();
	scripts\mp\_mp_agent::init_agent("mp/default_agent_definition.csv");
	lib_0CBC::main();
	level scripts\cp\_hud_message::init();
	level.var_8136 = ::func_7EA0;
	level thread lib_0D5E::func_96D5();
	func_53DC();
	level thread func_673B();
	level.var_D763 = "cp/zombies/escape_loot.csv";
	level.var_D760 = 1;
	level.var_10DA7 = int(0);
	level.var_D761 = level.var_10DA7;
	level.var_D79E = 1000;
	level.var_D79F = 2500;
	level.var_D79D = 0;
	level.var_EC22 = level.var_D79E;
	level.var_76EC = 0;
	level thread scripts\cp\_interaction::func_4627();
	level thread scripts\cp\_utility::func_83DA();
	level thread func_13BD5();
	level thread lib_0D56::init();
}

//Function Number: 2
func_673B()
{
	var_00 = 1;
	var_01 = level.var_13C3D[0];
	for(;;)
	{
		level waittill("objective_complete",var_02);
		var_03 = level.var_13C3D[var_00];
		thread func_1077D(var_03,var_02,var_01);
		level.var_502E = var_03;
		if(var_00 < level.var_13C3D.size)
		{
			var_00++;
		}

		var_01 = var_03;
	}
}

//Function Number: 3
func_1077D(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = scripts\common\utility::getstructarray(param_01.target,"targetname");
	foreach(var_06 in var_04)
	{
		if(var_06.script_noteworthy == "waypoint_spot")
		{
			var_03 = var_06;
			break;
		}
	}

	var_08 = bullettrace(var_03.origin,var_03.origin + (0,0,-100),0);
	var_03 = var_08["position"];
	var_09 = spawn("script_model",var_03 + (0,0,40));
	var_09 setmodel(function_00EA(param_00));
	var_09.var_39C = param_00;
	var_09.var_C40A = param_02;
	var_09 thread func_13600();
	var_09 thread func_E723();
	var_09.var_7542 = spawnfx(level._effect["weapon_glow"],var_09.origin);
	wait(0.5);
	triggerfx(var_09.var_7542);
}

//Function Number: 4
func_E723()
{
	self endon("death");
	for(;;)
	{
		self rotateyaw(360,2);
		wait(2);
	}
}

//Function Number: 5
func_13600()
{
	var_00 = 0;
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02 hasweapon(self.var_39C))
			{
				continue;
			}

			if(distancesquared(var_02.origin,self.origin) > 22500)
			{
				continue;
			}
			else
			{
				var_02 playlocalsound("zmb_powerup_activate");
				scripts\common\utility::func_136F7();
				var_02 thread func_830B(var_02,self.var_39C,self.var_C40A);
				playfx(level._effect["weapon_pickup"],var_02.origin + (0,0,30));
				var_00++;
				if(level.players.size - var_00 == 0)
				{
					self.var_7542 delete();
					self delete();
					return;
				}
			}

			wait(0.05);
		}

		wait(0.25);
	}
}

//Function Number: 6
func_830B(param_00,param_01,param_02)
{
	while(param_00 ismeleeing())
	{
		wait(0.2);
	}

	param_00 allowmelee(0);
	param_00 takeweapon(param_02);
	param_00 scripts\cp\_utility::func_12C6(param_01,undefined,undefined,1);
	param_00 switchtoweapon(param_01);
	while(param_00 method_81C2())
	{
		wait(0.1);
	}

	param_00 givemaxammo(param_01);
	param_00 allowmelee(1);
}

//Function Number: 7
func_136D7()
{
	while(!isdefined(level.players))
	{
		wait(0.1);
	}
}

//Function Number: 8
func_97B3()
{
	scripts\common\utility::flag_init("insta_kill");
	scripts\common\utility::flag_init("introscreen_over");
}

//Function Number: 9
func_97B4()
{
	level._effect["alien_hive_explode"] = loadfx("vfx/core/expl/alien_hive_explosion");
	level._effect["goon_spawn_bolt"] = loadfx("vfx/iw7/_requests/coop/vfx_clown_spawn.vfx");
	level._effect["bloody_death"] = loadfx("vfx/core/base/vfx_tentacle_death_burst");
	level._effect["stun_attack"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_geotrail_tesla_01.vfx");
	level._effect["stun_shock"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_shock_flash.vfx");
	level._effect["weapon_glow"] = loadfx("vfx/iw7/_requests/coop/zmb_part_glow_green");
	level._effect["weapon_pickup"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zom_powerup_pickup.vfx");
}

//Function Number: 10
func_C905()
{
	level.var_13C3D = [];
	var_00 = "cp/escape_weapon_progression.csv";
	var_01 = 0;
	for(;;)
	{
		var_02 = randomintrange(1,3);
		var_03 = tablelookupbyrow(var_00,var_01,var_02);
		if(var_03 == "")
		{
			break;
		}

		level.var_13C3D[var_01] = var_03;
		var_01++;
	}

	level.var_502E = level.var_13C3D[0];
}

//Function Number: 11
func_9569()
{
	level.var_C5A4 = ::func_13F47;
	level.onspawnplayer = ::func_13F46;
	level.var_C580 = ::func_13F45;
}

//Function Number: 12
func_13F47()
{
	scripts\cp\_persistence::func_DEB5();
	scripts\cp\_analytics::func_10C5A("mp/zombieMatchdata.ddl","mp/zombieclientmatchdata.ddl","cp/zombies/zombie_analytics.csv");
	scripts\cp\_laststand::func_F579(3000,5000);
	scripts\cp\_persistence::func_DCD1();
	level.var_4D58 = 20;
	scripts\cp\_utility::func_1B70();
	if(scripts\cp\_utility::func_462B("loot"))
	{
		scripts\cp\zombies\_powerups::func_9670();
	}

	if(scripts\cp\_utility::func_462B("pillage"))
	{
		thread lib_0D5E::func_CB5A();
	}

	level thread func_8931();
	level thread func_E4A1();
	level scripts\common\utility::func_5127(0.2,::lib_0D4D::func_97B2);
	level.var_13E26 = getdvarint("scr_aliens_xpscale");
	level.var_13E26 = min(level.var_13E26,4);
	level.var_13E26 = max(level.var_13E26,0);
	level.var_7674 = ::lib_0D5D::func_DEE2;
	lib_0CFE::func_97B6();
	lib_0CFE::func_96CF();
	thread lib_0D59::func_9589();
	scripts\cp\zombies\zmb_zombies_weapons::init();
	level thread scripts\cp\_interaction::init();
	scripts\cp\zombies\zombies_spawning::func_6512();
	level thread scripts\cp\zombies\zombies_spawning::func_6514();
	level thread func_66F3();
}

//Function Number: 13
func_66F3()
{
	func_66F2();
	var_00 = 0;
	var_01 = 1;
	var_02 = 2;
	var_03 = 3;
	var_04 = 3;
	level thread func_672B();
	var_05 = level.initial_active_volumes[0];
	var_06 = 0;
	for(;;)
	{
		scripts\common\utility::func_6E2A("score goal reached");
		var_07 = strtok(tablelookup(level.var_6728,var_00,var_06,var_01)," ");
		level.var_6716 = int(var_07[level.players.size - 1]);
		var_08 = tablelookup(level.var_6728,var_00,var_06,var_02);
		level.var_4BAC = 0;
		setomnvar("zom_escape_gate_score",level.var_6716);
		if(level.var_6716 == 0)
		{
			break;
		}

		func_12E14();
		if(!isdefined(level.var_1BEC))
		{
			wait(var_04);
		}

		var_09 = getent(var_08,"script_noteworthy");
		var_0A = func_B296(var_09);
		scripts\common\utility::flag_wait("score goal reached");
		var_05 = var_08;
		var_0A destroy();
		func_C5EB(var_09);
		level notify("next_area_opened",var_08);
		var_06++;
	}

	func_61F5();
}

//Function Number: 14
func_61F5()
{
	var_00 = [[ level.var_79A0 ]]();
	var_01 = scripts\common\utility::random(var_00);
	func_B295(var_01);
	var_02 = spawn("script_origin",var_01.origin);
	var_02 makeusable();
	var_02 sethintstring(&"CP_ZMB_INTERACTIONS_ESCAPE_THE_PARK");
	var_02 thread func_135D0(var_01);
}

//Function Number: 15
func_135D0(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		if(isdefined(var_01.var_111AF))
		{
			continue;
		}

		func_D055(param_00,var_01);
	}
}

//Function Number: 16
func_66F2()
{
	scripts\common\utility::flag_init("score goal reached");
}

//Function Number: 17
func_12E14()
{
	var_00 = level.var_4BAC / level.var_6716;
	setomnvar("zom_escape_gate_percent",var_00);
	setomnvar("zom_escape_gate_score",level.var_6716);
}

//Function Number: 18
func_794B(param_00,param_01)
{
	var_02 = -25536;
	var_03 = [];
	var_04 = [];
	var_05 = [];
	foreach(var_07 in level.var_1BEC)
	{
		if(isdefined(var_07.script_area) && isdefined(var_07.script_noteworthy) && var_07.script_noteworthy != "fast_travel")
		{
			if(var_07.script_area == param_00)
			{
				var_03[var_03.size] = var_07;
			}

			if(var_07.script_area == param_01)
			{
				var_04[var_04.size] = var_07;
			}
		}
	}

	foreach(var_0A in var_03)
	{
		foreach(var_0C in var_04)
		{
			if(distancesquared(var_0A.origin,var_0C.origin) > var_02)
			{
				continue;
			}

			if(isdefined(var_0A.script_noteworthy) && isdefined(var_0C.script_noteworthy) && var_0A.script_noteworthy == var_0C.script_noteworthy)
			{
				var_05[var_05.size] = var_0C;
			}
		}
	}

	return scripts\common\utility::random(var_05);
}

//Function Number: 19
func_B296(param_00)
{
	var_01 = newhudelem();
	var_01 setshader("waypoint_blitz_goal",8,8);
	var_01 setwaypoint(1,1);
	var_02 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_04 in var_02)
	{
		if(var_04.script_noteworthy == "waypoint_spot")
		{
			var_05 = spawn("script_origin",var_04.origin);
			scripts\common\utility::func_136F7();
			var_01 settargetent(var_05);
			return var_01;
		}
	}
}

//Function Number: 20
func_B295(param_00)
{
	var_01 = (0,0,45);
	var_02 = newhudelem();
	var_02 setshader("waypoint_blitz_goal",8,8);
	var_02 setwaypoint(1,1);
	var_03 = spawn("script_origin",param_00.origin + var_01);
	var_02 settargetent(var_03);
}

//Function Number: 21
func_C5EB(param_00)
{
	level notify("objective_complete",param_00);
	if(isdefined(level.var_4B72))
	{
		level.var_4B72 hide();
	}

	param_00 playsound("zmb_clear_barricade");
	var_01 = getentarray(param_00.target,"targetname");
	playfx(level._effect["debris_buy"],param_00.origin);
	foreach(var_04, var_03 in param_00.var_C898)
	{
		var_03 thread func_BC9C(var_04);
	}

	level.var_76EC = level.var_76EC + 1;
	foreach(var_06 in level.players)
	{
		var_06 setclientomnvar("zombie_wave_number",level.var_76EC);
	}

	level.var_4B72 = getent(param_00.script_noteworthy + "_exit_path","script_noteworthy");
	if(isdefined(level.var_4B72))
	{
		level.var_4B72 show();
		level.var_4B72 notsolid();
	}

	wait(1);
	param_00 connectpaths();
	param_00 delete();
}

//Function Number: 22
func_BC9C(param_00)
{
	self endon("death");
	wait(param_00 * 0.2);
	self movez(10,0.5);
	self rotateto(self.angles + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)),0.5);
	wait(0.5);
	self movez(1000,3,2,1);
	wait(2);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 23
func_672B()
{
	level endon("game_ended");
	level endon("update_escape_timer");
	if(!scripts\common\utility::istrue(level.var_9ADC))
	{
		scripts\common\utility::flag_wait("introscreen_over");
		iprintlnbold("Escape the park!");
		level.var_9ADC = 1;
	}

	if(!isdefined(level.var_672E))
	{
		level.var_672E = level.var_672A;
	}

	if(level.var_672E != level.var_672A)
	{
		iprintlnbold("LEFTOVER TIME ADDED: " + level.var_672E);
		level.var_672A = level.var_672A + level.var_672E;
		level.var_672E = int(level.var_672A);
	}

	level.var_672E = int(level.var_672E);
	var_00 = gettime() + level.var_672A * 1000;
	setomnvar("zm_ui_timer",int(var_00));
	while(gettime() < var_00)
	{
		wait(1);
		level.var_672E--;
	}

	level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
}

//Function Number: 24
func_13F45()
{
}

//Function Number: 25
func_13F46()
{
	onspawnplayer();
	thread lib_0D62::func_13F11();
}

//Function Number: 26
func_8931()
{
	wait(5);
	level notify("spawn_nondeterministic_entities");
}

//Function Number: 27
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			var_00 scripts\cp\_analytics::func_C4B8();
			if(isdefined(var_00.var_4539))
			{
				var_00.var_452A = var_00.var_4539;
			}
			else
			{
				var_00.var_452A = gettime();
			}

			var_00 thread scripts\cp\_outline::func_C77A();
			var_00 thread scripts\cp\_globallogic::func_D0FB();
			var_00 lib_0A54::func_96EB();
			var_00 scripts\cp\_persistence::func_F282();
			if(!isdefined(var_00.var_C8A2))
			{
				var_00.var_C8A2 = [];
			}

			if(!isdefined(var_00.var_D7A0))
			{
				var_00.var_D7A0 = [];
			}

			if(!isdefined(var_00.var_D782))
			{
				var_00.var_D782 = [];
			}

			if(!isdefined(var_00.var_D783))
			{
				var_00.var_D783 = [];
			}

			var_00 lib_0D59::func_96DB();
			var_00 thread func_13F4A();
			var_00.var_55E3 = 0;
			var_00.var_55CD = 0;
			var_00 scripts\cp\_utility::allow_player_teleport(0);
			var_00.var_D721 = 0;
			var_00.var_1189F = 0;
			var_00.var_F1E7 = 0;
			var_00.ignorme_count = 0;
			if(scripts\common\utility::flag("introscreen_over"))
			{
				if(isdefined(level.var_4C6C))
				{
					var_00 thread [[ level.var_4C6C ]]();
				}
				else
				{
					var_00 thread func_D0E1();
				}

				if(scripts\cp\_challenge::func_4B4B() && scripts\cp\_utility::func_462B("challenge"))
				{
					if(isdefined(level.var_3C1A))
					{
						var_00 thread [[ level.var_3C1A ]]();
					}
				}
			}

			var_00 scripts\cp\zombies\zombie_afterlife_arcade::func_D0F7(var_00);
			var_00 scripts\cp\_persistence::func_AAC4("waveNum",level.wave_num,1);
			if(isdefined(level.custom_onplayerconnect_func))
			{
				[[ level.custom_onplayerconnect_func ]](var_00);
			}

			var_00 thread lib_0D2D::func_EC1E(var_00);
		}
	}
}

//Function Number: 28
func_D0E1()
{
	self endon("disconnect");
	self notify("intro_done");
	self notify("stop_intro");
	self waittill("spawned");
	self.pers["hotjoined"] = 1;
	if(isdefined(self.var_9AFF))
	{
		self.var_9AFF fadeovertime(1);
		wait(1);
		if(isdefined(self.var_9AFF))
		{
			self.var_9AFF destroy();
		}
	}

	self setclientomnvar("ui_hide_hud",0);
	self.var_DDAF = 0;
}

//Function Number: 29
onspawnplayer()
{
	self.pers["gamemodeLoadout"] = level.var_1B77;
	self setclientomnvar("ui_refresh_hud",1);
	self.var_5BC1 = 1;
	self.var_6D82 = 0;
	self.var_9F28 = 0;
	self.var_9F23 = 0;
	self.var_9D81 = 0;
	self.var_9D6F = undefined;
	self.var_9E29 = undefined;
	self.var_3294 = undefined;
	self.var_FE4B = undefined;
	self.var_CF3E = undefined;
	self.var_C016 = 0;
	self.var_C004 = 0;
	self.var_55E3 = 0;
	self.var_55CD = 0;
	self.var_3859 = 1;
	self.ignorme_count = 0;
	self.ignoreme = 0;
	self setclientomnvar("zm_ui_player_in_laststand",0);
	thread lib_0CFD::func_139D2();
	if(isdefined(level.custom_onspawnplayer_func))
	{
		self [[ level.custom_onspawnplayer_func ]]();
	}

	scripts\cp\_globallogic::func_D0FC();
	scripts\cp\_globallogic::func_D0F9();
	var_00 = func_7CA5(self);
	thread scripts\cp\_persistence::func_13683(var_00);
	func_F53A(999999);
	thread func_B5C6();
	thread func_13A8E();
	thread scripts\cp\_utility::func_D3A5();
	thread scripts\cp\_hud_util::func_13F0D();
	thread scripts\cp\zombies\zmb_zombies_weapons::func_13C66();
	thread scripts\cp\powers\coop_powers::power_watch_hint();
	thread scripts\cp\zombies\zmb_zombies_weapons::func_26E0();
	thread scripts\cp\zombies\zmb_zombies_weapons::func_DF57();
}

//Function Number: 30
func_7CA5(param_00)
{
	var_01 = param_00.var_10DA8;
	if(isdefined(var_01))
	{
		param_00.var_10DA8 = undefined;
		return var_01;
	}

	return scripts\cp\_persistence::func_7CA5();
}

//Function Number: 31
func_F53A(param_00)
{
	param_00 = int(param_00);
	self.var_B48A = param_00;
}

//Function Number: 32
func_E196()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		func_E197(var_01);
	}
}

//Function Number: 33
func_E197(param_00)
{
	var_01 = getarraykeys(param_00.var_D782);
	foreach(var_03 in var_01)
	{
		if(param_00.var_D782[var_03].var_10307 == "secondary")
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(param_00))
		{
			param_00 thread func_135E6();
			continue;
		}

		param_00 thread func_DDD1(var_03);
	}
}

//Function Number: 34
func_135E6()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("spawned_player");
	wait(1);
	var_00 = getarraykeys(self.var_D782);
	if(var_00.size < 1)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(self.var_D782[var_02].var_10307 == "secondary")
		{
			continue;
		}

		thread func_DDD1(var_02);
	}
}

//Function Number: 35
func_DDD1(param_00)
{
	var_01 = self.var_D782[param_00].var_10307;
	if(scripts\common\utility::istrue(self.var_D782[param_00].var_19))
	{
		while(scripts\common\utility::istrue(self.var_D782[param_00].var_19))
		{
			wait(0.05);
		}
	}

	if(scripts\common\utility::istrue(self.var_D782[param_00].var_12F6A))
	{
		while(scripts\common\utility::istrue(self.var_D782[param_00].var_12F6A))
		{
			wait(0.05);
		}
	}

	thread scripts\cp\powers\coop_powers::func_8397(param_00,var_01,undefined,undefined,undefined,undefined,1);
	if(scripts\common\utility::istrue(level.var_F0B8))
	{
		scripts\cp\powers\coop_powers::func_D740(10,"secondary");
	}

	if(scripts\common\utility::istrue(level.var_94A8))
	{
		scripts\cp\powers\coop_powers::func_D740(100);
	}
}

//Function Number: 36
func_E4A1()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("spawn_wave_done");
		foreach(var_01 in level.players)
		{
			if(scripts\cp\_laststand::player_in_laststand(var_01))
			{
				scripts\cp\_laststand::func_992F(var_01);
			}
		}

		level thread func_E196();
	}
}

//Function Number: 37
func_13F4B(param_00)
{
	param_00.var_10DA8 = param_00 scripts\cp\_persistence::func_7B8B();
	lib_0D50::func_EB61(param_00);
	param_00 lib_0D5D::func_E072();
	func_E49A(param_00);
	func_F5A8(param_00);
	func_1142A(param_00);
	scripts\cp\zombies\zombie_afterlife_arcade::func_12859(param_00);
}

//Function Number: 38
func_E49A(param_00)
{
	param_00 scripts\cp\_utility::func_4191();
	var_01 = param_00.var_501C;
	var_02 = weaponclipsize(var_01);
	var_03 = function_0249(var_01);
	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_04[var_04.size] = var_01;
	var_05[var_01] = var_02;
	var_06[var_01] = var_03;
	param_00 scripts\cp\_utility::func_1785(var_04,var_05,var_06,var_01);
	param_00.var_D7CE = var_01;
	param_00.var_D7D0 = var_03;
	param_00.var_D7CF = var_02;
	param_00.var_AA45 = var_01;
}

//Function Number: 39
func_F5A8(param_00)
{
	var_01 = func_13F26(param_00);
	param_00.var_72E2 = var_01.origin;
	param_00.var_72E0 = var_01.angles;
}

//Function Number: 40
func_13F26(param_00)
{
	if(!isdefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0)
	{
		return [[ level.var_8136 ]]();
	}

	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.players)
	{
		if(var_06 == param_00)
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_06))
		{
			continue;
		}

		var_01 = var_01 + var_06.origin[0];
		var_02 = var_02 + var_06.origin[1];
		var_03 = var_03 + var_06.origin[2];
		var_04++;
	}

	var_08 = (var_01 / var_04,var_02 / var_04,var_03 / var_04);
	var_09 = sortbydistance(level.active_player_respawn_locs,var_08);
	foreach(var_0B in var_09)
	{
		if(canspawn(var_0B.origin) && !positionwouldtelefrag(var_0B.origin))
		{
			return var_0B;
		}
	}

	return var_09[0];
}

//Function Number: 41
func_1142A(param_00)
{
	param_00.var_10932 = undefined;
}

//Function Number: 42
func_5032()
{
	var_00 = 0;
	if(!scripts\common\utility::istrue(level.var_9AF6))
	{
		var_00 = 10;
	}

	if(scripts\common\utility::istrue(game["gamestarted"]))
	{
		var_00 = 0;
	}

	if(var_00 > 0)
	{
		var_01 = level func_135D3();
		level thread func_100EA();
		if(isdefined(level.var_9AAC))
		{
			level thread [[ level.var_9AAC ]]();
		}

		wait(var_00 - 3);
		if(isdefined(level.var_D703))
		{
			[[ level.var_D703 ]]();
		}

		scripts\common\utility::flag_set("introscreen_over");
		level.var_9AF6 = 1;
	}
	else
	{
		wait(1);
		level.var_9AF6 = 1;
		scripts\common\utility::flag_set("introscreen_over");
	}

	if(scripts\common\utility::istrue(level.var_18F))
	{
		return;
	}

	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		level.players[var_02] scripts\cp\_utility::func_7385(0);
		level.players[var_02] enableweapons();
		if(!isdefined(level.players[var_02].pers["team"]))
		{
			continue;
		}
	}
}

//Function Number: 43
func_100EA()
{
	if(isdefined(level.introscreen_text_func))
	{
		[[ level.introscreen_text_func ]]();
	}
}

//Function Number: 44
func_135D3()
{
	var_00 = undefined;
	if(level.players.size == 0)
	{
		level waittill("connected",var_00);
	}
	else
	{
		var_00 = level.players[0];
	}

	return var_00;
}

//Function Number: 45
func_13F4A()
{
	self setclientomnvar("ui_hide_hud",1);
	self endon("disconnect");
	self endon("stop_intro");
	self.var_9AFF = newclienthudelem(self);
	self.var_9AFF.x = 0;
	self.var_9AFF.y = 0;
	self.var_9AFF setshader("black",640,480);
	self.var_9AFF.alignx = "left";
	self.var_9AFF.aligny = "top";
	self.var_9AFF.sort = 1;
	self.var_9AFF.horzalign = "fullscreen";
	self.var_9AFF.vertalign = "fullscreen";
	self.var_9AFF.alpha = 1;
	self.var_9AFF.foreground = 1;
	if(!scripts\common\utility::flag("introscreen_over"))
	{
		scripts\common\utility::flag_wait("introscreen_over");
	}

	self.var_9AFF fadeovertime(3);
	self.var_9AFF.alpha = 0;
	wait(3.5);
	self.var_9AFF destroy();
	self setclientomnvar("ui_hide_hud",0);
	thread func_CD55();
}

//Function Number: 46
func_CD55()
{
	wait(0.5);
	wait(0.5);
}

//Function Number: 47
func_B5C6()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("shock_melee_upgrade activated");
	self.var_B648 = 1;
	var_00 = 1;
	self.var_B648 = 0;
	var_01 = gettime();
	for(;;)
	{
		var_02 = gettime();
		if(var_02 - var_01 >= level.var_D3D7)
		{
			self.var_B648 = 1;
		}
		else
		{
			self.var_B648 = 0;
		}

		if(self meleebuttonpressed() && !self method_81B8() && !self usebuttonpressed())
		{
			var_01 = gettime();
			if(var_00 == 1)
			{
				var_00 = 0;
			}
		}
		else if(!self meleebuttonpressed())
		{
			var_00 = 1;
		}
		else
		{
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 48
func_8BF4()
{
	var_00 = 0;
	var_01 = self getweaponslist("primary");
	if(var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			if(func_9E11(var_03))
			{
				var_00 = 1;
				break;
			}
		}
	}

	return var_00;
}

//Function Number: 49
func_9E11(param_00)
{
	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return param_00 == "iw7_glprox_zm";
}

//Function Number: 50
func_13A8E()
{
	self endon("death");
	self endon("disconnect");
	self endon("endExpJump");
	level endon("game_ended");
	var_00 = undefined;
	self notifyonplayercommand("fired","+attack");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("weapon_switch_started","weapon_change","weaponchange");
		self notify("stop_regen_on_weapons");
		wait(0.1);
		var_01 = self getweaponslistall();
		foreach(var_03 in var_01)
		{
			if(func_9E11(var_03))
			{
				thread func_DE7E(var_03);
				var_00 = 1;
				continue;
			}

			var_00 = 0;
		}
	}
}

//Function Number: 51
func_DE7E(param_00)
{
	self endon("stop_regen_on_weapons");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = 3;
	var_02 = 4;
	for(;;)
	{
		var_03 = self getweaponammoclip(param_00);
		while(var_03 <= var_01)
		{
			var_03 = self getweaponammoclip(param_00);
			self setweaponammoclip(param_00,var_03 + 1);
			wait(var_02);
		}

		wait(var_02);
	}
}

//Function Number: 52
func_13F37(param_00)
{
	var_01 = param_00 scripts\cp\_persistence::func_7B8B();
	var_01 = var_01 * 0.05;
	var_01 = int(var_01 / 10) * 10;
	return var_01;
}

//Function Number: 53
func_13F15(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	[[ level.var_3764 ]](param_00,param_01,param_02,param_04,param_05,param_07,param_08,param_09);
	lib_0D56::func_AFD5();
}

//Function Number: 54
func_53DC()
{
	if(getdvarint("zm_damage_numbers",0) == 1)
	{
		setomnvar("zm_dev_damage",1);
		return;
	}

	setomnvar("zm_dev_damage",0);
}

//Function Number: 55
func_D810()
{
	var_00 = " LB_" + getdvar("ui_mapname");
	if(scripts\cp\_utility::isplayingsolo())
	{
		var_00 = var_00 + "_SOLO";
	}
	else
	{
		var_00 = var_00 + "_COOP";
	}

	precacheleaderboards(var_00);
}

//Function Number: 56
func_7EA0()
{
	return scripts\cp\_globallogic::func_7DDA(scripts\common\utility::getstructarray("escape_player_start","targetname"));
}

//Function Number: 57
func_F963(param_00)
{
	var_01 = 40;
	var_02 = 200;
	var_03 = 10;
	var_04 = 15;
	param_00.var_EC1F = scripts\cp\_utility::createprimaryprogressbar(0,0,var_02,var_03);
	param_00.var_EC1F scripts\cp\_utility::setpoint("center","center",0,var_01);
	param_00.var_4BAB = scripts\cp\_utility::createfontstring("objective",1);
	param_00.var_4BAB scripts\cp\_utility::setpoint("center","center",var_02 / 2 * -1,var_01 + var_04);
	param_00.var_EC1C = scripts\cp\_utility::createfontstring("objective",1);
	param_00.var_EC1C scripts\cp\_utility::setpoint("center","center",var_02 / 2,var_01 + var_04);
	func_F31E(param_00,0);
	func_F588(param_00,level.var_6716);
}

//Function Number: 58
func_F31E(param_00,param_01)
{
	param_00.var_4BAB setvalue(param_01);
}

//Function Number: 59
func_F588(param_00,param_01)
{
	param_00.var_EC1C setvalue(param_01);
}

//Function Number: 60
func_F589(param_00,param_01)
{
	param_00.var_EC1F scripts\cp\_utility::updatebarscale(param_01);
}

//Function Number: 61
func_12DA7(param_00,param_01)
{
	if(level.var_6716 == 0)
	{
		var_02 = 0;
	}
	else
	{
		var_02 = var_02 / level.var_6716;
	}

	setomnvar("zom_escape_gate_percent",var_02);
}

//Function Number: 62
func_6733(param_00,param_01)
{
	param_00 thread func_12DA6(param_00,param_01);
}

//Function Number: 63
func_12DA6(param_00,param_01)
{
	wait(0.1);
	level.var_4BAC = int(min(level.var_4BAC + param_01 * level.var_4415,level.var_6716));
	func_12DA7(param_00,level.var_4BAC);
	if(level.var_4BAC >= level.var_6716)
	{
		scripts\common\utility::flag_set("score goal reached");
	}

	lib_0D5A::func_12DEC(param_00,param_01);
}

//Function Number: 64
func_13BD5()
{
	level endon("game_ended");
	level.wave_num = 1;
	scripts\common\utility::flag_wait("introscreen_over");
}

//Function Number: 65
func_13BD7()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("introscreen_over");
	for(;;)
	{
		wait(30);
		level notify("escape_start_next_wave");
	}
}

//Function Number: 66
func_D055(param_00,param_01)
{
	var_02 = "player_after_escape_pos";
	param_01 iprintlnbold("You successfully escaped from the park!");
	var_03 = scripts\common\utility::getstructarray(var_02,"targetname")[0];
	param_01 setorigin(var_03.origin);
	param_01.var_111AF = 1;
	func_11743(param_01);
}

//Function Number: 67
func_11743(param_00)
{
	foreach(param_00 in level.players)
	{
		if(!scripts\common\utility::istrue(param_00.var_111AF))
		{
			return;
		}
	}

	level thread [[ level.endgame ]]("ally",level.end_game_string_index["all_escape"]);
}
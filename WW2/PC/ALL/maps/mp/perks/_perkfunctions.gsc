/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 201
 * Decompile Time: 2515 ms
 * Timestamp: 10/27/2023 3:25:21 AM
*******************************************************************/

//Function Number: 1
func_8658()
{
	thread func_2867();
}

//Function Number: 2
func_2867()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetCrouchMovement");
	for(;;)
	{
		maps\mp\gametypes\_weapons::func_A13B();
		wait 0.05;
	}
}

//Function Number: 3
func_A056()
{
	self notify("unsetCrouchMovement");
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 4
func_86F4()
{
	var_00 = spawn("script_model",self.var_116);
	var_00.var_1A7 = self.var_1A7;
	var_00 makeportableradar(self);
	self.var_6F81 = var_00;
	thread func_78A8(var_00);
}

//Function Number: 5
func_78A8(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("personal_uav_remove");
	self endon("personal_uav_removed");
	for(;;)
	{
		param_00 moveto(self.var_116,0.05);
		wait 0.05;
	}
}

//Function Number: 6
func_A076()
{
	if(isdefined(self.var_6F81))
	{
		self notify("personal_uav_removed");
		level maps\mp\gametypes\_portable_radar::func_2D49(self.var_6F81);
		self.var_6F81 = undefined;
	}
}

//Function Number: 7
func_86E8()
{
}

//Function Number: 8
func_A073()
{
}

//Function Number: 9
func_8673()
{
}

//Function Number: 10
func_A05B()
{
}

//Function Number: 11
func_8711()
{
}

//Function Number: 12
func_A079()
{
}

//Function Number: 13
func_8721()
{
	if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
	{
		self setviewkickscale(0);
		return;
	}

	thread monitorsharpfocus();
}

//Function Number: 14
monitorsharpfocus()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("stopSharpFocusMonitor");
	self endon("stopSharpFocusMonitor");
	scaleflinchbasedonweapon(self getcurrentweapon());
	for(;;)
	{
		self waittill("weapon_change",var_00);
		scaleflinchbasedonweapon(var_00);
	}
}

//Function Number: 15
scaleflinchbasedonweapon(param_00)
{
	if(maps\mp\_utility::func_472A(param_00) == "weapon_sniper")
	{
		self setviewkickscale(0.35);
		return;
	}

	self setviewkickscale(0.9);
}

//Function Number: 16
func_A07B()
{
	self notify("stopSharpFocusMonitor");
	self setviewkickscale(1);
}

//Function Number: 17
func_866D()
{
	self endon("death");
	self endon("disconnect");
	self endon("endDoubleLoad");
	level endon("game_ended");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getweaponslist("primary");
		foreach(var_02 in var_00)
		{
			var_03 = self getweaponammoclip(var_02);
			var_04 = weaponclipsize(var_02);
			var_05 = var_04 - var_03;
			var_06 = self getweaponammostock(var_02);
			if(var_03 != var_04 && var_06 > 0)
			{
				if(var_03 + var_06 >= var_04)
				{
					self method_82FA(var_02,var_04);
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self method_82FA(var_02,var_03 + var_06);
				if(var_06 - var_05 > 0)
				{
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammostock(var_02,0);
			}
		}
	}
}

//Function Number: 18
func_A059()
{
	self notify("endDoubleLoad");
}

//Function Number: 19
func_86C6(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}
	else
	{
		param_00 = int(param_00) * 2;
	}

	maps\mp\_utility::func_870F(param_00);
	self.var_7AD7 = param_00;
}

//Function Number: 20
func_A070()
{
	maps\mp\_utility::func_870F(0);
	self.var_7AD7 = 0;
}

//Function Number: 21
func_8736(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		self.var_94BE = 0.5;
		return;
	}

	self.var_94BE = int(param_00) / 10;
}

//Function Number: 22
func_A082()
{
	self.var_94BE = 1;
}

//Function Number: 23
func_8733()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self setaimspreadmovementscale(0.5);
}

//Function Number: 24
func_A07F()
{
	self notify("end_SteadyAimPro");
	self setaimspreadmovementscale(1);
}

//Function Number: 25
func_6F6D()
{
	self endon("disconnect");
	self waittill("death");
	self.var_73B = undefined;
}

//Function Number: 26
func_870E()
{
}

//Function Number: 27
func_A078()
{
	self notify("end_perkUseTracker");
}

//Function Number: 28
func_8675()
{
	if(isdefined(self.var_36B9))
	{
		return;
	}

	self.var_FB = maps\mp\gametypes\_tweakables::func_46F7("player","maxhealth") * 4;
	self.var_BC = self.var_FB;
	self.var_36B9 = 1;
	self.var_119A[0] = "";
	self visionsetnakedforplayer("end_game",5);
	thread func_36BB(7);
	self.var_4B62 = 1;
}

//Function Number: 29
func_A05C()
{
	self notify("stopEndGame");
	self.var_36B9 = undefined;
	maps\mp\_utility::func_7E50();
	if(!isdefined(self.var_36C2))
	{
		return;
	}

	self.var_36C2 maps\mp\gametypes\_hud_util::func_2DCC();
	self.var_36BD maps\mp\gametypes\_hud_util::func_2DCC();
}

//Function Number: 30
func_36BB(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait(param_00 + 1);
	maps\mp\_utility::func_728();
}

//Function Number: 31
func_9162()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("adjustedStance","+stance");
	for(;;)
	{
		self waittill("adjustedStance");
		if(self.var_64CD != 0)
		{
			continue;
		}

		func_A07D();
	}
}

//Function Number: 32
func_598F()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("jumped","+goStand");
	for(;;)
	{
		self waittill("jumped");
		if(self.var_64CD != 0)
		{
			continue;
		}

		func_A07D();
	}
}

//Function Number: 33
func_A07D()
{
	self.var_64CD = level.var_162E;
	self resetspreadoverride();
	maps\mp\gametypes\_weapons::func_A13B();
	self method_82E8();
	self allowjump(1);
}

//Function Number: 34
setimprovedobjectives()
{
	self.var_696D = 1.5;
}

//Function Number: 35
unsetimprovedobjectives()
{
	self.var_696D = 1;
}

//Function Number: 36
func_8638()
{
	self.var_5A73 = 1.5;
}

//Function Number: 37
func_A052()
{
	self.var_5A73 = 1;
}

//Function Number: 38
func_8734()
{
	maps\mp\_utility::func_47A2("specialty_bulletaccuracy");
	maps\mp\_utility::func_47A2("specialty_holdbreath");
}

//Function Number: 39
func_A080()
{
	maps\mp\_utility::func_735("specialty_bulletaccuracy");
	maps\mp\_utility::func_735("specialty_holdbreath");
}

//Function Number: 40
func_8663()
{
}

//Function Number: 41
func_A057()
{
}

//Function Number: 42
func_86C2()
{
	if(!maps\mp\_utility::func_56D7())
	{
		self setmotiontrackervisible(0);
	}
}

//Function Number: 43
func_A06F()
{
	self setmotiontrackervisible(1);
}

//Function Number: 44
func_8741()
{
	self thermalvisionon();
}

//Function Number: 45
func_A083()
{
	self thermalvisionoff();
}

//Function Number: 46
func_86E0()
{
	thread func_6AF6();
}

//Function Number: 47
func_A071()
{
	self notify("stop_oneManArmyTracker");
}

//Function Number: 48
func_6AF6()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_oneManArmyTracker");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 != "onemanarmy_mp")
		{
			continue;
		}

		thread func_83B7();
	}
}

//Function Number: 49
func_5765(param_00)
{
	if(param_00 == game["menu_onemanarmy"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_defaults_splitscreen"]) && param_00 == game["menu_onemanarmy_defaults_splitscreen"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_custom_splitscreen"]) && param_00 == game["menu_onemanarmy_custom_splitscreen"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
func_83B7()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_603();
	common_scripts\utility::func_600();
	common_scripts\utility::func_601();
	self openpopupmenu(game["menu_onemanarmy"]);
	thread func_2449();
	self waittill("menuresponse",var_00,var_01);
	common_scripts\utility::func_617();
	common_scripts\utility::func_614();
	common_scripts\utility::func_615();
	if(var_01 == "back" || !func_5765(var_00) || maps\mp\_utility::func_581D())
	{
		if(self getcurrentweapon() == "onemanarmy_mp")
		{
			common_scripts\utility::func_603();
			common_scripts\utility::func_600();
			common_scripts\utility::func_601();
			self switchtoweapon(common_scripts\utility::func_4550());
			self waittill("weapon_change");
			common_scripts\utility::func_617();
			common_scripts\utility::func_614();
			common_scripts\utility::func_615();
		}

		return;
	}

	thread func_47A0(var_01);
}

//Function Number: 51
func_2449()
{
	self endon("menuresponse");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	common_scripts\utility::func_617();
	common_scripts\utility::func_614();
	common_scripts\utility::func_615();
	self closepopupmenu();
}

//Function Number: 52
func_47A0(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::func_649("specialty_omaquickchange"))
	{
		var_01 = 3;
		self method_8615("foly_onemanarmy_bag3_plr");
		self method_860E("foly_onemanarmy_bag3_npc","allies",self);
		self method_860E("foly_onemanarmy_bag3_npc","axis",self);
	}
	else
	{
		var_01 = 6;
		self method_8615("foly_onemanarmy_bag6_plr");
		self method_860E("foly_onemanarmy_bag6_npc","allies",self);
		self method_860E("foly_onemanarmy_bag6_npc","axis",self);
	}

	thread func_6A6D(var_01);
	common_scripts\utility::func_602();
	common_scripts\utility::func_600();
	common_scripts\utility::func_601();
	wait(var_01);
	common_scripts\utility::func_616();
	common_scripts\utility::func_614();
	common_scripts\utility::func_615();
	maps\mp\gametypes\_class::func_4773(self.var_12C["team"],param_00,0);
	if(isdefined(self.var_2013))
	{
		self attach(self.var_2013,"J_spine4",1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

//Function Number: 53
func_6A6D(param_00)
{
	self endon("disconnect");
	var_01 = maps\mp\gametypes\_hud_util::func_2821(0,-25);
	var_02 = maps\mp\gametypes\_hud_util::func_2822(0,-25);
	var_02 settext(&"MPUI_CHANGING_KIT");
	var_01 maps\mp\gametypes\_hud_util::func_A0E3(0,1 / param_00);
	var_03 = 0;
	while(var_03 < param_00 && isalive(self) && !level.var_3F9D)
	{
		wait 0.05;
		var_03 = var_03 + 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::func_2DCC();
	var_02 maps\mp\gametypes\_hud_util::func_2DCC();
}

//Function Number: 54
func_8639()
{
	self method_821A("primaryoffhand","specialty_s1_temp");
}

//Function Number: 55
func_A053()
{
	self method_821A("primaryoffhand","none");
}

//Function Number: 56
func_8689()
{
	self.var_3A0F = 0;
}

//Function Number: 57
func_A065()
{
	self.var_3A0F = 1;
}

//Function Number: 58
func_8739()
{
	maps\mp\_utility::func_642("s2_tactical_insertion_device_mp");
	self givestartammo("s2_tactical_insertion_device_mp");
	thread func_63EF();
}

//Function Number: 59
func_240A()
{
	self notify("clearPreviousTISpawnpointStarted");
	self endon("clearPreviousTISpawnpointStarted");
	common_scripts\utility::knock_off_battery("disconnect","joined_team","joined_spectators");
	if(isdefined(self.var_872A))
	{
		func_2D54(self.var_872A);
	}
}

//Function Number: 60
func_A17C()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	while(maps\mp\_utility::func_57A0(self))
	{
		var_00 = getnodesinradiussorted(self.var_116,128,0,64);
		self.var_9A28 = undefined;
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02) && nodeexposedtosky(var_02,1))
			{
				var_03 = var_02.var_116 + (0,0,10);
				var_04 = bullettrace(self geteye(),var_03,0,self);
				if(bullettracepassed(self geteye(),var_03,0,self))
				{
					if(func_583F(var_03))
					{
						self.var_9A28 = var_03;
						break;
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 61
func_583F(param_00)
{
	if(canspawn(param_00) && self isonground())
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
func_63EF()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	thread func_240A();
	thread func_A17C();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 != "s2_tactical_insertion_device_mp")
		{
			continue;
		}

		if(isdefined(self.var_872A))
		{
			func_2D54(self.var_872A);
		}

		if(!isdefined(self.var_9A28))
		{
			self iclientprintlnbold("Invalid spawn location");
			self givestartammo("s2_tactical_insertion_device_mp");
			continue;
		}

		if(maps\mp\_utility::func_9AC1())
		{
			continue;
		}

		var_02 = playerphysicstrace(self.var_9A28 + (0,0,16),self.var_9A28 - (0,0,2048)) + (0,0,1);
		var_03 = spawn("script_model",var_02);
		var_03.var_1D = self.var_1D;
		var_03.var_1A7 = self.var_1A7;
		var_03.var_117 = self;
		var_03.var_3773 = spawn("script_origin",var_02);
		var_03 thread func_47EB(self);
		var_03.var_7464 = self.var_9A28;
		var_03 setotherent(self);
		var_03 common_scripts\utility::func_5FA9(self.var_1A7,1);
		var_03 method_861D("tac_insert_spark_lp");
		thread func_A950();
		self.var_872A = var_03;
	}
}

//Function Number: 63
func_63EB()
{
	self notify("third_person_ti");
	self endon("third_person_ti");
	for(;;)
	{
		if(isdefined(self.var_1156))
		{
			self method_802E("npc_usa_emergency_flare","tag_inhand");
			self.var_1156 = undefined;
		}

		self waittillmatch("s2_tactical_insertion_device_mp","grenade_pullback");
		self attach("npc_usa_emergency_flare","tag_inhand",1);
		self.var_1156 = "npc_usa_emergency_flare";
		maps\mp\_utility::func_A6D1(3,"death");
		self method_802E("npc_usa_emergency_flare","tag_inhand");
		self.var_1156 = undefined;
	}
}

//Function Number: 64
func_47EB(param_00)
{
	self setmodel(level.var_906A["enemy"]);
	thread maps\mp\gametypes\_damage::func_8676(100,undefined,::func_6AE7,undefined,0);
	thread func_47EA(param_00);
	thread func_47ED(param_00);
	thread func_47EC(self.var_1A7,level.var_9069["enemy"],param_00);
	var_01 = spawn("script_model",self.var_116 + (0,0,0));
	var_01.var_1D = self.var_1D;
	var_01 setmodel(level.var_906A["friendly"]);
	var_01 method_80B1();
	var_01 thread func_47EC(self.var_1A7,level.var_9069["friendly"],param_00);
	var_01 method_861D("tac_insert_spark_lp");
	self waittill("death");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 65
func_47EC(param_00,param_01,param_02)
{
	self endon("death");
	wait 0.05;
	var_03 = self gettagangles("tag_fx");
	var_04 = spawnfx(param_01,self gettagorigin("tag_fx"),anglestoforward(var_03),anglestoup(var_03));
	triggerfx(var_04);
	thread func_6F57(var_04);
	for(;;)
	{
		self method_805C();
		var_04 method_805C();
		foreach(var_06 in level.var_744A)
		{
			if(var_06.var_1A7 == param_00 && level.var_984D && param_01 == level.var_9069["friendly"])
			{
				self showtoclient(var_06);
				var_04 showtoclient(var_06);
				continue;
			}

			if(var_06.var_1A7 != param_00 && level.var_984D && param_01 == level.var_9069["enemy"])
			{
				self showtoclient(var_06);
				var_04 showtoclient(var_06);
				continue;
			}

			if(!level.var_984D && var_06 == param_02 && param_01 == level.var_9069["friendly"])
			{
				self showtoclient(var_06);
				var_04 showtoclient(var_06);
				continue;
			}

			if(!level.var_984D && var_06 != param_02 && param_01 == level.var_9069["enemy"])
			{
				self showtoclient(var_06);
				var_04 showtoclient(var_06);
			}
		}

		level common_scripts\utility::func_A732("joined_team","player_spawned");
	}
}

//Function Number: 66
func_6F57(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 67
func_6AE7(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_117) && param_00 != self.var_117)
	{
		param_00 notify("destroyed_explosive");
		param_00 thread maps\mp\gametypes\_missions::func_7750("ch_darkbringer");
	}

	playfx(level.var_9062,self.var_116);
	self.var_117 thread maps\mp\_utility::func_5C43("ti_destroyed",undefined,undefined,self.var_116);
	param_00 thread func_2D54(self);
}

//Function Number: 68
func_47ED(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PICKUP_TI");
	thread func_A10D(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 method_8617("tac_insert_pickup_plr");
		var_01 thread func_8739();
		var_01 thread func_2D54(self);
	}
}

//Function Number: 69
func_A10D(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\mp\_utility::func_871E(param_00);
		level common_scripts\utility::func_A732("joined_team","player_spawned");
	}
}

//Function Number: 70
func_2D54(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_117))
	{
		param_00.var_117.var_6E6E = 0;
		param_00.var_117 notify("stop_watchTISpawn");
	}

	if(isdefined(param_00.var_3773))
	{
		param_00.var_3773 delete();
	}

	if(isdefined(param_00.var_9D65))
	{
		param_00.var_9D65 delete();
	}

	if(isdefined(param_00.var_359B["friendly"]))
	{
		param_00.var_359B["friendly"] delete();
	}

	if(isdefined(param_00.var_359B["enemy"]))
	{
		param_00.var_359B["enemy"] delete();
	}

	if(isdefined(param_00.var_117))
	{
		param_00.var_117.var_872A = undefined;
	}

	param_00 stoploopsound();
	param_00 delete();
}

//Function Number: 71
func_47EA(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self.var_3773 setcursorhint("HINT_NOICON");
	self.var_3773 sethintstring(&"MP_DESTROY_TI");
	self.var_3773 maps\mp\_utility::earlyendon(param_00);
	for(;;)
	{
		self.var_3773 waittill("trigger",var_01);
		var_01 notify("destroyed_explosive");
		level thread maps\mp\gametypes\_rank::func_1457("tac_insert_enemy_destroyed",var_01);
		level thread maps\mp\gametypes\_rank::func_1457("tac_insert_destroyed",param_00);
		var_01 maps\mp\gametypes\_missions::func_7750("ch_boot_field");
		if(var_01 maps\mp\_utility::func_649("specialty_detectexplosive"))
		{
			var_01 maps\mp\gametypes\_missions::func_7750("ch_perks3_engineer");
		}

		param_00 luinotifyevent(&"tac_insert_destroyed",0);
		thread func_6AE7(var_01);
	}
}

//Function Number: 72
func_A950()
{
	self endon("disconnect");
	self endon("stop_watchTISpawn");
	self waittill("spawned_player");
	if(!self.var_99BD)
	{
		return;
	}

	var_00 = self.var_116;
	self method_808C();
	self setorigin(var_00 + (0,0,2000));
	self allowads(0);
	var_01 = magicbullet("tactical_insertion_parachute_mp",self.var_116,var_00);
	self playerlinkto(var_01,undefined,0,180,180,180,180,1);
	var_02 = spawn("script_model",var_01.var_116);
	var_02 setmodel("tag_origin");
	var_02 method_8449(var_01);
	var_03 = spawn("script_model",var_02.var_116);
	var_03 method_805C();
	if(self.var_1A7 == "allies")
	{
		var_03 setmodel("usa_carepackage_parachute_anim");
	}
	else
	{
		var_03 setmodel("ger_carepackage_parachute_anim");
	}

	var_03.var_62A0 = 0.5;
	var_03 scriptmodelplayanim("carepackage_parachute_loop");
	var_03 method_8449(var_02,"tag_origin",(20,-20,40),(0,90,0));
	var_03 method_805B();
	var_04 = spawn("script_model",var_03.var_116);
	var_04.var_1D = var_03.var_1D;
	var_04 setmodel("ger_carepackage_parachute");
	var_04 setcandamage(1);
	var_04 method_805C();
	var_04 method_8449(var_03);
	var_04 thread func_A94F(var_01);
	var_01 thread func_9A1E(self,var_02,var_03,var_04);
}

//Function Number: 73
func_A94F(param_00)
{
	common_scripts\utility::func_A732("damage","death");
	if(isdefined(param_00))
	{
		param_00 notify("death");
	}
}

//Function Number: 74
func_9A1E(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	self waittill("death");
	param_00 unlink();
	param_00 allowads(1);
	param_02 method_8278("carepackage_parachute_detach");
	param_02 common_scripts\utility::func_2CBE(2.7,::delete);
	param_01 common_scripts\utility::func_2CBE(3,::delete);
	param_03 delete();
}

//Function Number: 75
func_86ED(param_00,param_01)
{
	if(isplayer(self) || function_01EF(self))
	{
		if(isdefined(param_00.var_90DA))
		{
			if(param_01)
			{
				if(!isdefined(self.paintedattackers))
				{
					self.paintedattackers = [];
				}

				self.paintedattackers[param_00.var_48CA] = gettime();
			}
			else
			{
				if(!isdefined(self.paintedexpeditionaryattackers))
				{
					self.paintedexpeditionaryattackers = [];
				}

				self.paintedexpeditionaryattackers[param_00.var_48CA] = gettime();
			}

			self.var_6DEC = 1;
			self setperk("specialty_radarblip",1,0);
			thread func_A074(param_00.var_90DA,param_00);
			thread func_A930();
		}
	}
}

//Function Number: 76
func_A930()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("unsetPainted");
	self waittill("death");
	self.var_6DEC = 0;
	self.paintedattackers = [];
	self.paintedexpeditionaryattackers = [];
}

//Function Number: 77
func_A074(param_00,param_01)
{
	self notify("painted_again");
	self endon("painted_again");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self.var_6DEC = 0;
	self unsetperk("specialty_radarblip",1);
	self notify("unsetPainted");
}

//Function Number: 78
func_576D()
{
	return isdefined(self.var_6DEC) && self.var_6DEC;
}

//Function Number: 79
func_8710()
{
	if(isdefined(self.var_76F6))
	{
		self givemaxammo(self.var_76F6);
	}

	if(isdefined(self.var_8356))
	{
		self givemaxammo(self.var_8356);
	}
}

//Function Number: 80
func_8680()
{
	maps\mp\_utility::func_47A2("specialty_pistoldeath");
}

//Function Number: 81
func_A061()
{
	maps\mp\_utility::func_735("specialty_pistoldeath");
}

//Function Number: 82
func_8642()
{
	thread maps\mp\killstreaks\_killstreaks::func_478D("airdrop_assault",0,0,self);
}

//Function Number: 83
func_A054()
{
}

//Function Number: 84
func_8752()
{
	thread maps\mp\killstreaks\_killstreaks::func_478D("uav",0,0,self);
}

//Function Number: 85
func_A085()
{
}

//Function Number: 86
func_8735()
{
	maps\mp\_utility::func_47A2("specialty_bulletdamage");
	thread func_A94C();
}

//Function Number: 87
func_A94C()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	func_A081();
}

//Function Number: 88
func_A081()
{
	maps\mp\_utility::func_735("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 89
func_86B4(param_00,param_01,param_02)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_juiced");
	level endon("end_game");
	self.var_5739 = 1;
	if(!isdefined(param_00))
	{
		param_00 = 1.25;
	}

	self.var_64CD = param_00;
	maps\mp\gametypes\_weapons::func_A13B();
	if(level.var_910F)
	{
		var_03 = 56;
		var_04 = 21;
	}
	else
	{
		var_03 = 80;
		var_04 = 32;
	}

	if(!isdefined(param_01))
	{
		param_01 = 7;
	}

	if(!isdefined(param_02) || param_02 == 1)
	{
		self.var_5980 = maps\mp\gametypes\_hud_util::func_2833("hudsmall",1);
		self.var_5980 maps\mp\gametypes\_hud_util::func_8707("CENTER","CENTER",0,var_03);
		self.var_5980 settimer(param_01);
		self.var_5980.var_56 = (0.8,0.8,0);
		self.var_5980.var_1F = 0;
		self.var_5980.var_A0 = 1;
		self.var_597F = maps\mp\gametypes\_hud_util::func_280B(level.var_90D9,var_04,var_04);
		self.var_597F.var_18 = 0;
		self.var_597F maps\mp\gametypes\_hud_util::func_86EF(self.var_5980);
		self.var_597F maps\mp\gametypes\_hud_util::func_8707("BOTTOM","TOP");
		self.var_597F.var_1F = 1;
		self.var_597F.ignoreme = 1;
		self.var_597F.var_A0 = 1;
		self.var_597F fadeovertime(1);
		self.var_597F.var_18 = 0.85;
	}

	thread func_A06C();
	thread func_A06D();
	wait(param_01 - 2);
	if(isdefined(self.var_597F))
	{
		self.var_597F fadeovertime(2);
		self.var_597F.var_18 = 0;
	}

	if(isdefined(self.var_5980))
	{
		self.var_5980 fadeovertime(2);
		self.var_5980.var_18 = 0;
	}

	wait(2);
	func_A06B();
}

//Function Number: 90
func_A06B(param_00)
{
	if(!isdefined(param_00))
	{
		self.var_64CD = level.var_162E;
		maps\mp\gametypes\_weapons::func_A13B();
	}

	if(isdefined(self.var_597F))
	{
		self.var_597F destroy();
	}

	if(isdefined(self.var_5980))
	{
		self.var_5980 destroy();
	}

	self.var_5739 = undefined;
	self notify("unset_juiced");
}

//Function Number: 91
func_A06D()
{
	self endon("disconnect");
	self endon("unset_juiced");
	for(;;)
	{
		wait 0.05;
		if(maps\mp\_utility::func_581D())
		{
			thread func_A06B();
			break;
		}
	}
}

//Function Number: 92
func_A06C()
{
	self endon("disconnect");
	self endon("unset_juiced");
	common_scripts\utility::knock_off_battery("death","faux_spawn");
	thread func_A06B(1);
}

//Function Number: 93
func_86BC(param_00)
{
	if(isdefined(param_00))
	{
		self.var_5D2E = param_00;
		if(isplayer(self) && isdefined(self.var_6089) && self.var_6089 > 0)
		{
			var_01 = clamp(self.var_5D2E / self.var_6089,0,1);
			self setclientomnvar("ui_light_armor_percent",var_01);
			return;
		}

		return;
	}

	self.var_5D2E = undefined;
	self.var_6089 = undefined;
	self setclientomnvar("ui_light_armor_percent",0);
}

//Function Number: 94
func_86BB(param_00)
{
	self notify("give_light_armor");
	if(isdefined(self.var_5D2E))
	{
		func_A06E();
	}

	thread func_7CE7();
	thread func_7CE8();
	if(isdefined(param_00))
	{
		self.var_6089 = param_00;
	}
	else
	{
		self.var_6089 = 150;
	}

	func_86BC(self.var_6089);
	if(isdefined(level.var_5677) && level.var_5677)
	{
		self.var_F67 = newclienthudelem(self);
		self.var_F67.maxsightdistsqrd = 0;
		self.var_F67.var_1D7 = 0;
		self.var_F67.ignoreme = -5;
		self.var_F67.var_C6 = "fullscreen";
		self.var_F67.var_1CA = "fullscreen";
		self.var_F67 setshader("combathigh_overlay",640,480);
		self.var_F67.var_18 = 1;
	}
}

//Function Number: 95
func_7CE7()
{
	self endon("disconnect");
	self endon("give_light_armor");
	self endon("remove_light_armor");
	self waittill("death");
	func_A06E();
}

//Function Number: 96
func_A06E()
{
	func_86BC(undefined);
	if(isdefined(level.var_5677) && level.var_5677)
	{
		self.var_F67 destroy();
	}

	self notify("remove_light_armor");
}

//Function Number: 97
func_7CE8()
{
	self endon("disconnect");
	self endon("remove_light_armor");
	level common_scripts\utility::knock_off_battery("round_end_finished","game_ended");
	thread func_A06E();
}

//Function Number: 98
func_4B76()
{
	return isdefined(self.var_5D2E) && self.var_5D2E > 0;
}

//Function Number: 99
func_6391()
{
	self endon("death");
	self endon("disconnect");
	self.var_5720 = 0;
	for(;;)
	{
		if(self.var_BC < self.var_FB && !self.var_5720)
		{
			self.var_5720 = 1;
			func_867F();
		}
		else if(self.var_5720 && self.var_BC >= self.var_FB)
		{
			self.var_5720 = 0;
			func_A060();
		}

		wait 0.05;
	}
}

//Function Number: 100
func_867F()
{
	if(isdefined(self.var_5720))
	{
		if(self.var_5720)
		{
			maps\mp\gametypes\_weapons::func_A13B();
			maps\mp\_utility::func_47A2("specialty_quickdraw_new");
		}
	}
}

//Function Number: 101
func_A060()
{
	maps\mp\gametypes\_weapons::func_A13B();
	if(maps\mp\_utility::func_649("specialty_quickdraw_new"))
	{
		maps\mp\_utility::func_735("specialty_quickdraw_new");
	}
}

//Function Number: 102
fightorflightregeneratehealth()
{
	self.var_50A0 = 1;
	self.var_98E1 = 1.5;
	self.var_98E2 = 13.33;
	self notify("damage");
}

//Function Number: 103
func_63E3()
{
	self endon("disconnect");
	self endon("death");
	level endon("round_switch");
	level endon("halftime");
	self.var_4B65 = 0;
	if(level.var_6EB1 <= 0 || level.var_8E2 <= 0)
	{
	}

	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.var_744A)
		{
			if(!isdefined(var_02) || !isdefined(var_02.var_1A7))
			{
				continue;
			}

			if((level.var_984D && var_02.var_1A7 != self.var_1A7) || !level.var_984D && var_02 != self)
			{
				if(distancesquared(var_02.var_116,self.var_116) < level.var_6EB1)
				{
					self.var_4B65 = 1;
				}

				if(distancesquared(var_02.var_116,self.var_116) < level.var_8E2)
				{
					var_00 = 1;
				}
			}
		}

		if(!var_00 && self.var_4B65)
		{
			self.var_4B65 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 104
func_867A()
{
	self.var_9AAE = 2;
}

//Function Number: 105
func_A05E()
{
	self.var_9AAE = 1;
}

//Function Number: 106
func_870D()
{
	self endon("disconnect");
	self endon("stop_radar_ping_on_spawn");
	common_scripts\utility::func_A70C(self,"spawned_player",level,"prematch_over");
	function_0256(self.var_116,self,1300);
}

//Function Number: 107
func_A077()
{
	self notify("stop_radar_ping_on_spawn");
}

//Function Number: 108
func_86F1()
{
	thread func_6F4E();
}

//Function Number: 109
func_A075()
{
	self notify("removePerception");
}

//Function Number: 110
func_6F4E()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("removePerception");
	self endon("round_switch");
	if(!isplayer(self))
	{
		return;
	}

	thread watchdeathorgameendperception();
	for(;;)
	{
		var_00 = 0;
		var_01 = level.var_744A;
		var_02 = 0;
		var_03 = maps\mp\_utility::func_649("specialty_perception");
		foreach(var_05 in var_01)
		{
			if(maps\mp\_utility::func_581D())
			{
				break;
			}

			if(!isdefined(var_05) || !maps\mp\_utility::func_57A0(var_05))
			{
				continue;
			}

			if(var_05 == self || level.var_984D && var_05.var_1A7 == self.var_1A7)
			{
				continue;
			}

			var_06 = self.var_116 - var_05.var_116;
			var_07 = anglestoforward(var_05 getangles());
			var_08 = vectordot(var_06,var_07);
			if(var_08 <= 0)
			{
				continue;
			}

			var_09 = vectornormalize(var_06);
			var_0A = vectornormalize(var_07);
			var_08 = vectordot(var_09,var_0A);
			if(var_08 < 0.9659258)
			{
				continue;
			}

			var_00++;
			var_0B = var_05 geteye();
			var_0C = self geteye();
			if(bullettracepassed(var_0B,var_0C,0,self))
			{
				thread func_A932();
				thread func_A933();
				var_02 = var_02 | func_4601(var_05);
				thread func_6011(var_05);
				continue;
			}

			if(var_00 >= 3)
			{
				wait 0.05;
				var_00 = 0;
			}
		}

		if(var_02 > 4)
		{
			var_02 = 1;
		}
		else
		{
			var_02 = 0;
		}

		if(var_03)
		{
			func_A147(var_02,0);
		}

		wait 0.05;
	}
}

//Function Number: 111
func_A932()
{
	level endon("game_ended");
	if(isdefined(self.var_92F1) && self.var_92F1)
	{
		return;
	}

	common_scripts\utility::knock_off_battery("disconnect","removePerception","death","perceptionChallengeCheckDone");
	if(isdefined(self))
	{
		self.var_92F1 = 0;
	}
}

//Function Number: 112
func_A933()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("removePerception");
	self endon("death");
	if(isdefined(self.var_92F1) && self.var_92F1)
	{
		return;
	}

	self.var_92F1 = 1;
	wait(10);
	self notify("perceptionChallengeCheckDone");
}

//Function Number: 113
watchdeathorgameendperception()
{
	self endon("disconnect");
	self endon("removePerception");
	common_scripts\utility::func_A70C(self,"death",level,"game_ended");
	thread func_A147(0,1);
}

//Function Number: 114
func_A147(param_00,param_01)
{
	if(isai(self) || function_026D(self))
	{
		return;
	}

	var_02 = common_scripts\utility::func_44F5("perception_glow");
	var_03 = 0;
	if(isdefined(self.var_6F4C))
	{
		var_03 = self.var_6F4C;
	}

	if(isdefined(param_01) && param_01)
	{
		if(isdefined(self.var_106) || self.var_106)
		{
			function_0295(var_02,self,"j_head",self);
		}
	}
	else if(var_03 != param_00)
	{
		if(param_00)
		{
			playfxontagforclients(var_02,self,"j_head",self);
		}
		else
		{
			function_0295(var_02,self,"j_head",self);
		}
	}

	self.var_6F4C = param_00;
}

//Function Number: 115
func_4601(param_00)
{
	var_01 = anglestoforward(self getangles());
	var_02 = (var_01[0],var_01[1],var_01[2]);
	var_02 = vectornormalize(var_02);
	var_03 = param_00.var_116 - self.var_116;
	var_04 = (var_03[0],var_03[1],var_03[2]);
	var_04 = vectornormalize(var_04);
	var_05 = vectordot(var_02,var_04);
	if(var_05 >= 0.9238795)
	{
		return 2;
	}

	if(var_05 >= 0.3826834)
	{
		return common_scripts\utility::func_98E7(maps\mp\_utility::func_5746(self.var_116,var_02,param_00.var_116),4,1);
	}

	if(var_05 >= -0.3826834)
	{
		return common_scripts\utility::func_98E7(maps\mp\_utility::func_5746(self.var_116,var_02,param_00.var_116),128,64);
	}

	if(var_05 >= -0.9238795)
	{
		return common_scripts\utility::func_98E7(maps\mp\_utility::func_5746(self.var_116,var_02,param_00.var_116),32,8);
	}

	return 16;
}

//Function Number: 116
func_6011(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	var_01 = param_00 getentitynumber();
	if(!isdefined(self.var_6F4D))
	{
		self.var_6F4D = [];
	}
	else if(isdefined(self.var_6F4D[var_01]))
	{
		self notify("markAsPerceptionSource");
		self endon("markAsPerceptionSource");
	}

	self.var_6F4D[var_01] = 1;
	param_00 common_scripts\utility::func_A71A(10,"death","disconnect");
	self.var_6F4D[var_01] = 0;
}

//Function Number: 117
func_8743()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetThrowEquipmentFarther");
	level endon("game_ended");
	for(;;)
	{
		self method_8424(1.25);
		self waittill("grenade_pullback",var_00);
		if(var_00 == "killstreak_carepackage_grenade_mp" || var_00 == "killstreak_carepackage_grenade_axis_mp" || var_00 == "killstreak_emergency_carepackage_grenade_mp" || var_00 == "killstreak_emergency_carepackage_grenade_axis_mp" || var_00 == "gamemode_ball")
		{
			self method_8424(1);
		}

		self waittill("grenade_fire",var_01,var_02);
	}
}

//Function Number: 118
func_A084()
{
	self method_8424(1);
	self notify("unsetThrowEquipmentFarther");
}

//Function Number: 119
func_8722()
{
	self method_8425(1.7);
}

//Function Number: 120
func_A07C()
{
	self method_8425(1);
}

//Function Number: 121
func_8656()
{
	self endon("disconnect");
	self endon("unsetCookingGrenadeDeath");
	level endon("game_ended");
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		var_01 = common_scripts\utility::func_A70E(self,"death",self,"grenade_fire",self,"offhand_end");
		if(var_01[0] == "death" && var_00 != "c4_mp")
		{
			var_02 = magicgrenademanual(var_00,self.var_116,(0,0,0),1.25,self,1);
			var_02.var_5751 = 1;
			maps\mp\gametypes\_weapons::func_3BE8(var_02,var_00);
			return;
		}
	}
}

//Function Number: 122
func_A055()
{
	self notify("unsetCookingGrenadeDeath");
}

//Function Number: 123
func_8678()
{
	if(isai(self) || function_026D(self))
	{
		return;
	}

	if((level.var_910F || self issplitscreenplayer()) && !function_03BA())
	{
		self setclientdvars("1806","90","1310","90","2385","0.50");
		return;
	}

	self setclientdvars("1806","225","1310","225","2385","0.60");
}

//Function Number: 124
func_A05D()
{
	if(isai(self) || function_026D(self))
	{
		return;
	}

	if((level.var_910F || self issplitscreenplayer()) && !function_03BA())
	{
		self setclientdvars("1806","75","1310","75","2385","0.45");
		return;
	}

	self setclientdvars("1806","175","1310","175","2385","0.45");
}

//Function Number: 125
setsnowblind()
{
	self endon("death");
	self endon("disconnect");
	self allowads(0);
}

//Function Number: 126
unsetsnowblind()
{
	self endon("death");
	self endon("disconnect");
	self allowads(1);
}

//Function Number: 127
monitorthaw()
{
	self endon("death");
	self endon("disconnect");
	self.isinthaw = 0;
	for(;;)
	{
		if(self.isinthaw && self.var_BC >= self.var_FB)
		{
			unsetthaw();
			self.isinthaw = 0;
		}
		else if(self.var_BC < self.var_FB && !self.isinthaw)
		{
			self.isinthaw = 1;
			setthaw();
		}

		wait 0.05;
	}
}

//Function Number: 128
setthaw()
{
	if(isdefined(self.isinthaw))
	{
		if(self.isinthaw)
		{
			self method_8308(0);
		}
	}
}

//Function Number: 129
unsetthaw()
{
	self method_8308(1);
}

//Function Number: 130
sethumbug()
{
	thread monitorhumbug();
}

//Function Number: 131
monitorhumbug()
{
	self notify("stopHumbugMonitor");
	self endon("stopHumbugMonitor");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	common_scripts\utility::func_A70C(self,"spawned_player",level,"prematch_over");
	for(;;)
	{
		function_0256(self.var_116,self);
		self setperk("specialty_radarblip",1,0);
		wait(0.35);
		self unsetperk("specialty_radarblip",1);
		wait(5.65);
	}
}

//Function Number: 132
unsethumbug()
{
	self notify("stopHumbugMonitor");
}

//Function Number: 133
setgpsjammer()
{
	self makescrambler(self);
}

//Function Number: 134
unsetgpsjammer()
{
	self clearscrambler();
}

//Function Number: 135
setshifty()
{
	thread setshiftyunlimitedpistolammunition();
}

//Function Number: 136
refillpistolmagazineonswitch()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("weapon_change");
	self endon("stopRefillPistolMagazineOnSwitch");
	wait(0.1);
	var_00 = self getcurrentweapon();
	if(maps\mp\_utility::func_472A(var_00) == "weapon_pistol")
	{
		self method_82FA(var_00,weaponclipsize(var_00));
	}
}

//Function Number: 137
setshiftyunlimitedpistolammunition()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("stopUnlimitedPistolAmmo");
	self endon("stopUnlimitedPistolAmmo");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("weapon_change","reload");
		var_00 = self getcurrentweapon();
		if(var_00 != "none" && !maps\mp\_utility::func_5740(var_00) && maps\mp\_utility::func_472A(var_00) == "weapon_pistol")
		{
			var_01 = self getfractionmaxammo(var_00);
			if(var_01 < 1)
			{
				self givemaxammo(var_00);
			}
		}
	}
}

//Function Number: 138
unsetshifty()
{
	self notify("stopRefillPistolMagazineOnSwitch");
	self notify("stopUnlimitedPistolAmmo");
}

//Function Number: 139
setdeadeye()
{
	self.critchance = 10;
	self.deadeyekillcount = 0;
}

//Function Number: 140
setdeadeyeinternal()
{
	if(self.critchance < 50)
	{
		self.critchance = self.deadeyekillcount + 1 * 10;
	}
	else
	{
		self.critchance = 50;
	}

	var_00 = randomint(100);
	if(var_00 <= self.critchance)
	{
		maps\mp\_utility::func_47A2("specialty_moredamage");
	}
}

//Function Number: 141
unsetdeadeye()
{
	if(maps\mp\_utility::func_649("specialty_moredamage"))
	{
		maps\mp\_utility::func_735("specialty_moredamage");
	}
}

//Function Number: 142
setescalationboostafterkill()
{
}

//Function Number: 143
unsetescalationboostafterkill()
{
	self setclientomnvar("ui_escalation_active",0);
}

//Function Number: 144
handleescalationboostafterkill()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("escalationBoostAfterKill");
	self endon("escalationBoostAfterKill");
	self setclientomnvar("ui_escalation_active",1);
	if(self.var_7AD2 >= 2)
	{
		var_00 = self getcurrentweapon();
		var_01 = weaponclipsize(var_00);
		var_02 = self getweaponammostock(var_00);
		var_03 = self getweaponammoclip(var_00);
		var_04 = min(var_01 - var_03,var_02);
		var_05 = min(var_03 + var_04,var_01);
		self method_82FA(var_00,int(var_05));
		self setweaponammostock(var_00,int(var_02 - var_04));
		if(self isdualwielding())
		{
			var_02 = self getweaponammostock(var_00);
			var_03 = self getweaponammoclip(var_00,"left");
			var_04 = min(var_01 - var_03,var_02);
			var_05 = min(var_03 + var_04,var_01);
			self method_82FA(var_00,int(var_05),"left");
			self setweaponammostock(var_00,int(var_02 - var_04));
		}

		if(maps\mp\_utility::func_649("specialty_boostafterreload"))
		{
			thread handleclassifiedboostafterreload();
		}
	}

	maps\mp\_utility::func_47A2("specialty_quickdraw_new");
	wait(6);
	if(maps\mp\_utility::func_649("specialty_quickdraw_new"))
	{
		maps\mp\_utility::func_735("specialty_quickdraw_new");
	}

	self setclientomnvar("ui_escalation_active",0);
}

//Function Number: 145
setresistancedivisionscramblerindicator()
{
	if(function_0367())
	{
		return;
	}

	if(isdefined(level.disabledivisionpassives) && level.disabledivisionpassives)
	{
		return;
	}

	if(maps\mp\_utility::isdivisionsglobaloverhaulenabled() && !isdefined(self.var_12C["loadoutContainsAltSwitchWeapon"]) || self.var_12C["loadoutContainsAltSwitchWeapon"])
	{
		self setclientomnvar("ui_show_division_resistance_ability_prompt",0);
		maps\mp\_utility::func_47A2("specialty_gpsjammer");
		maps\mp\_utility::func_47A2("specialty_sixthsense");
		self.var_12C["resistanceScramblerIndicatorActive"] = undefined;
		return;
	}

	var_00 = maps\mp\gametypes\_divisions::func_461D(self.var_79);
	if(!isdefined(self.var_12C["resistanceScramblerIndicatorActive"]))
	{
		self.var_12C["resistanceScramblerIndicatorActive"] = 1;
	}

	self setclientomnvar("ui_show_division_resistance_ability_prompt",1);
	if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
	{
		if(self.var_12C["resistanceScramblerIndicatorActive"])
		{
			self setclientomnvar("ui_resistance_state",3);
		}
		else
		{
			self setclientomnvar("ui_resistance_state",2);
		}
	}
	else
	{
		switch(var_00)
		{
			case "specialty_class_resistance_grandmaster":
			case "specialty_class_resistance_master":
				if(self.var_12C["resistanceScramblerIndicatorActive"])
				{
					self setclientomnvar("ui_resistance_state",3);
				}
				else
				{
					self setclientomnvar("ui_resistance_state",2);
				}
				break;

			case "specialty_class_resistance_expert":
			case "specialty_class_resistance_enlisted":
				if(self.var_12C["resistanceScramblerIndicatorActive"])
				{
					self setclientomnvar("ui_resistance_state",1);
				}
				else
				{
					self setclientomnvar("ui_resistance_state",0);
				}
				break;
		}
	}

	thread toggleresistancedivisionscramblerindicator(var_00,self.var_12C["resistanceScramblerIndicatorActive"]);
	thread monitortoggleresistancedivisionscramblerindicator();
}

//Function Number: 146
monitortoggleresistancedivisionscramblerindicator()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("stopMonitorToggleResistanceDivisionScramblerIndicator");
	self endon("stopMonitorToggleResistanceDivisionScramblerIndicator");
	var_00 = maps\mp\gametypes\_divisions::func_461D(self.var_79);
	self notifyonplayercommand("leftDpad","+actionslot 3");
	for(;;)
	{
		self waittill("leftDpad");
		if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
		{
			if(self.var_12C["resistanceScramblerIndicatorActive"])
			{
				self setclientomnvar("ui_resistance_state",2);
				self.var_12C["resistanceScramblerIndicatorActive"] = 0;
			}
			else
			{
				self setclientomnvar("ui_resistance_state",3);
				self.var_12C["resistanceScramblerIndicatorActive"] = 1;
			}
		}
		else
		{
			switch(var_00)
			{
				case "specialty_class_resistance_grandmaster":
				case "specialty_class_resistance_master":
					if(self.var_12C["resistanceScramblerIndicatorActive"])
					{
						self setclientomnvar("ui_resistance_state",2);
						self.var_12C["resistanceScramblerIndicatorActive"] = 0;
					}
					else
					{
						self setclientomnvar("ui_resistance_state",3);
						self.var_12C["resistanceScramblerIndicatorActive"] = 1;
					}
					break;
	
				case "specialty_class_resistance_expert":
				case "specialty_class_resistance_enlisted":
					if(self.var_12C["resistanceScramblerIndicatorActive"])
					{
						self setclientomnvar("ui_resistance_state",0);
						self.var_12C["resistanceScramblerIndicatorActive"] = 0;
					}
					else
					{
						self setclientomnvar("ui_resistance_state",1);
						self.var_12C["resistanceScramblerIndicatorActive"] = 1;
					}
					break;
			}
		}

		thread toggleresistancedivisionscramblerindicator(var_00,self.var_12C["resistanceScramblerIndicatorActive"]);
		wait(0.1);
	}
}

//Function Number: 147
toggleresistancedivisionscramblerindicator(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("toggleResistanceDivisionScramblerIndicator");
	self endon("toggleResistanceDivisionScramblerIndicator");
	if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
	{
		if(!param_01)
		{
			if(maps\mp\_utility::func_649("specialty_sixthsense"))
			{
				maps\mp\_utility::func_735("specialty_sixthsense");
			}

			wait(0.1);
			if(maps\mp\_utility::func_649("specialty_gpsjammer"))
			{
				maps\mp\_utility::func_735("specialty_gpsjammer");
				return;
			}

			return;
		}

		maps\mp\_utility::func_47A2("specialty_gpsjammer");
		wait(0.15);
		maps\mp\_utility::func_47A2("specialty_sixthsense");
		return;
	}

	switch(param_00)
	{
		case "specialty_class_resistance_grandmaster":
		case "specialty_class_resistance_master":
			if(!param_01)
			{
				if(maps\mp\_utility::func_649("specialty_sixthsense"))
				{
					maps\mp\_utility::func_735("specialty_sixthsense");
				}
	
				wait(0.1);
				if(maps\mp\_utility::func_649("specialty_gpsjammer"))
				{
					maps\mp\_utility::func_735("specialty_gpsjammer");
				}
			}
			else
			{
				maps\mp\_utility::func_47A2("specialty_gpsjammer");
				wait(0.15);
				maps\mp\_utility::func_47A2("specialty_sixthsense");
			}
			break;

		case "specialty_class_resistance_expert":
		case "specialty_class_resistance_enlisted":
			if(!param_01)
			{
				if(maps\mp\_utility::func_649("specialty_gpsjammer"))
				{
					maps\mp\_utility::func_735("specialty_gpsjammer");
				}
	
				wait(0.15);
			}
			else
			{
				maps\mp\_utility::func_47A2("specialty_gpsjammer");
			}
			break;
	}
}

//Function Number: 148
unsetresistancedivisionscramblerindicator()
{
	self notify("stopMonitorToggleResistanceDivisionScramblerIndicator");
	self notify("toggleResistanceDivisionScramblerIndicator");
	self setclientomnvar("ui_resistance_state",-1);
	self setclientomnvar("ui_show_division_resistance_ability_prompt",0);
	self notifyonplayercommandremove("leftDpad","+actionslot 3");
}

//Function Number: 149
handlegrenadiertrainingunlocks()
{
	var_00 = 0;
	for(var_01 = 3;var_01 < 6;var_01++)
	{
		if(shouldgrantgrenadierperkindex(var_01))
		{
			var_02 = maps\mp\_utility::func_452B(self.var_5DFA[var_01]);
			if(!isdefined(var_02) || var_02 == "none")
			{
				continue;
			}

			maps\mp\_utility::func_47A3(var_02,var_01);
			var_00++;
		}
	}

	if(var_00 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 150
shouldgrantgrenadierperkindex(param_00)
{
	var_01 = param_00 - 3 + 1;
	if(var_01 <= 0 || var_01 > 3)
	{
		return;
	}

	if(isdefined(level.disabledivisionpassives) && level.disabledivisionpassives)
	{
		if(var_01 == 1)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	if(!maps\mp\_utility::func_649("specialty_trainingUnlocker" + var_01))
	{
		return 0;
	}

	if(!isdefined(self.var_12C["grenadier_kills"]))
	{
		self.var_12C["grenadier_kills"] = 0;
	}

	var_02 = self.var_12C["grenadier_kills"];
	switch(var_01)
	{
		case 1:
			if(var_02 >= 5)
			{
				return 1;
			}
			break;

		case 2:
			if(var_02 >= 10)
			{
				return 1;
			}
			break;

		case 3:
			if(var_02 >= 15)
			{
				return 1;
			}
			break;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 151
monitorgrenadierprogress()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.enteredfrenzyloop) && self.enteredfrenzyloop == 1)
	{
		return;
	}
	else
	{
		self.enteredfrenzyloop = 0;
	}

	if(!isdefined(self.grenadierprogressfromtime))
	{
		self.grenadierprogressfromtime = 0;
	}

	var_00 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,level.var_3FDC);
	if(!isdefined(var_00) || var_00 == -1)
	{
		var_00 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,"default");
	}

	var_01 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,5)) / 100;
	if(!isdefined(self.previousgrenadiertier))
	{
		self.previousgrenadiertier = 0;
	}

	if(!isdefined(self.grenadierfrenzy))
	{
		self.grenadierfrenzy = 0;
	}

	while(self.var_79 == 7 && !self.grenadierfrenzy && !self.enteredfrenzyloop)
	{
		wait(1);
		self.grenadierprogressfromtime = self.grenadierprogressfromtime + var_01;
		var_02 = getgrenadierprogress();
		var_03 = int(var_02);
		if(var_03 > self.previousgrenadiertier)
		{
			if(var_03 <= 3)
			{
				grantgrenadiertierreward(var_03);
				if(var_03 == 3 && self.var_79 == 7)
				{
					var_04 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,3));
					self.enteredfrenzyloop = 1;
					thread monitorfrenzypoints(var_02 - var_03,var_04);
				}
			}

			self.previousgrenadiertier = var_03;
		}

		if(self.var_79 != 7)
		{
			self setclientomnvar("ui_grenadier_progress_meter",-1);
			return;
		}

		self setclientomnvar("ui_grenadier_progress_meter",var_02);
	}
}

//Function Number: 152
getgrenadiermodvalue_a()
{
	if(!isdefined(self.var_12C["sessionProgressionA_Modifier"]))
	{
		return 1;
	}

	var_00 = 0;
	if(self.var_12C["sessionProgressionA_Modifier"] >= 1)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionA_Modifier"] >= 8)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionA_Modifier"] >= 15)
	{
		var_00++;
	}

	var_01 = var_00 * 10 / 100;
	var_02 = self.var_12C["sessionProgressionA_Modifier"] * 0.02;
	var_03 = clamp(1 - var_01 + var_02,0.01,1);
	return var_03;
}

//Function Number: 153
getgrenadiermodvalue_b()
{
	if(!isdefined(self.var_12C["sessionProgressionB_Modifier"]))
	{
		return 1;
	}

	var_00 = 0;
	if(self.var_12C["sessionProgressionB_Modifier"] >= 1)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionB_Modifier"] >= 10)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionB_Modifier"] >= 25)
	{
		var_00++;
	}

	var_01 = var_00 * 2 / 100;
	var_02 = self.var_12C["sessionProgressionB_Modifier"] * 0.002;
	return 1 + clamp(var_01 + var_02,0,0.25);
}

//Function Number: 154
getgrenadiermodvalue_c()
{
	if(!isdefined(self.var_12C["sessionProgressionC_Modifier"]))
	{
		return 1;
	}

	var_00 = 0;
	if(self.var_12C["sessionProgressionC_Modifier"] >= 1)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionC_Modifier"] >= 10)
	{
		var_00++;
	}

	if(self.var_12C["sessionProgressionC_Modifier"] >= 20)
	{
		var_00++;
	}

	var_01 = var_00 * 5 / 100;
	var_02 = self.var_12C["sessionProgressionC_Modifier"] * 0.01;
	return 1 - clamp(var_01 + var_02,0,0.9);
}

//Function Number: 155
grantgrenadiertierreward(param_00)
{
	if(!isdefined(param_00) || param_00 < 1 || param_00 > 3)
	{
		return;
	}

	self.var_12C["sessionProgressionA_Modifier"] = 10 * param_00;
	self.var_12C["sessionProgressionB_Modifier"] = 10 * param_00;
	self.var_12C["sessionProgressionC_Modifier"] = 10 * param_00;
	var_01 = "specialty_trainingUnlocker" + param_00;
	if(maps\mp\_utility::func_649(var_01))
	{
		var_02 = 3 + param_00 - 1;
		var_03 = maps\mp\_utility::func_452B(self.var_5DFA[var_02]);
		if(isdefined(var_03) && var_03 != "none")
		{
			maps\mp\_utility::func_47A3(var_03,var_02);
			maps\mp\perks\_perks::func_F36();
		}
	}
}

//Function Number: 156
processgrenadierkill()
{
	if(self.var_79 != 7)
	{
		return;
	}

	var_00 = self.var_12C["grenadier_kills"];
	togglegrenadierfrenzy(1);
}

//Function Number: 157
togglegrenadierfrenzy(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.grenadierfrenzy))
		{
			self.grenadierfrenzy = 0;
		}

		if(self.grenadierfrenzy == 0)
		{
			self.grenadierfrenzy = 1;
			self notify("enteredFrenzy");
			if(getdvarint("spv_grenadier_frenzy_mode",0) == 1)
			{
				self.var_12C["sessionProgressionA_Modifier"] = 100;
				self.var_12C["sessionProgressionB_Modifier"] = 100;
				self.var_12C["sessionProgressionC_Modifier"] = 100;
				maps\mp\gametypes\_weapons::func_A13B();
				maps\mp\_utility::func_870F();
				return;
			}

			if(getdvarint("spv_grenadier_frenzy_mode",0) == 2)
			{
				maps\mp\_utility::func_47A2("specialty_sprintreload");
				maps\mp\_utility::func_47A2("specialty_fastreload");
				maps\mp\_utility::func_47A2("specialty_sprintfire");
				maps\mp\_utility::func_47A2("specialty_divefire");
				maps\mp\_utility::func_47A2("specialty_falldamage");
				maps\mp\_utility::func_47A2("specialty_lightweight");
				maps\mp\_utility::func_47A2("specialty_quieter");
				maps\mp\_utility::func_47A2("specialty_crouchmovement");
				maps\mp\_utility::func_47A2("specialty_stalker");
				maps\mp\_utility::func_47A2("specialty_reducedsway");
				maps\mp\_utility::func_47A2("specialty_scavenger");
				maps\mp\_utility::func_47A2("specialty_bulletresupply");
				maps\mp\_utility::func_47A2("specialty_extraammo");
				maps\mp\_utility::func_47A2("specialty_regenbullets");
				maps\mp\_utility::func_47A2("specialty_explosiveearlywarning");
				maps\mp\_utility::func_47A2("specialty_throwback");
				maps\mp\_utility::func_47A2("specialty_blastshield2");
				self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale",55) / 100;
				maps\mp\_utility::func_47A2("specialty_moreminimap");
				maps\mp\_utility::func_47A2("specialty_eagleeyes");
				maps\mp\_utility::func_47A2("specialty_silentkill");
				maps\mp\_utility::func_47A2("specialty_coldblooded");
				maps\mp\_utility::func_47A2("specialty_spygame");
				maps\mp\_utility::func_47A2("specialty_heartbreaker");
				maps\mp\_utility::func_47A2("specialty_perception");
				maps\mp\_utility::func_47A2("specialty_detectexplosive");
				self.var_90DA = 6;
				maps\mp\_utility::func_47A2("specialty_paint_pro");
				maps\mp\_utility::func_47A2("specialty_minimapdangerinfo");
				maps\mp\_utility::func_47A2("specialty_radarimmune");
				maps\mp\_utility::func_47A2("specialty_delaymine");
				maps\mp\_utility::func_47A2("specialty_shortfuse");
				return;
			}

			if(getdvarint("spv_grenadier_frenzy_mode",0) == 3)
			{
				self.var_12C["sessionProgressionA_Modifier"] = 100;
				self.var_12C["sessionProgressionB_Modifier"] = 100;
				self.var_12C["sessionProgressionC_Modifier"] = 100;
				maps\mp\_utility::func_47A2("specialty_sprintreload");
				maps\mp\_utility::func_47A2("specialty_fastreload");
				maps\mp\_utility::func_47A2("specialty_sprintfire");
				maps\mp\_utility::func_47A2("specialty_divefire");
				maps\mp\_utility::func_47A2("specialty_falldamage");
				maps\mp\_utility::func_47A2("specialty_lightweight");
				maps\mp\_utility::func_47A2("specialty_quieter");
				maps\mp\_utility::func_47A2("specialty_crouchmovement");
				maps\mp\_utility::func_47A2("specialty_stalker");
				maps\mp\_utility::func_47A2("specialty_reducedsway");
				maps\mp\_utility::func_47A2("specialty_scavenger");
				maps\mp\_utility::func_47A2("specialty_bulletresupply");
				maps\mp\_utility::func_47A2("specialty_extraammo");
				maps\mp\_utility::func_47A2("specialty_regenbullets");
				maps\mp\_utility::func_47A2("specialty_explosiveearlywarning");
				maps\mp\_utility::func_47A2("specialty_throwback");
				maps\mp\_utility::func_47A2("specialty_blastshield2");
				self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale",55) / 100;
				maps\mp\_utility::func_47A2("specialty_moreminimap");
				maps\mp\_utility::func_47A2("specialty_eagleeyes");
				maps\mp\_utility::func_47A2("specialty_silentkill");
				maps\mp\_utility::func_47A2("specialty_coldblooded");
				maps\mp\_utility::func_47A2("specialty_spygame");
				maps\mp\_utility::func_47A2("specialty_heartbreaker");
				maps\mp\_utility::func_47A2("specialty_detectexplosive");
				self.var_90DA = 6;
				maps\mp\_utility::func_47A2("specialty_paint_pro");
				maps\mp\_utility::func_47A2("specialty_minimapdangerinfo");
				maps\mp\_utility::func_47A2("specialty_radarimmune");
				maps\mp\_utility::func_47A2("specialty_delaymine");
				maps\mp\_utility::func_47A2("specialty_shortfuse");
				var_01 = common_scripts\utility::func_44F5("perception_glow");
				playfxontagforclients(var_01,self,"j_head",self);
				maps\mp\gametypes\_weapons::func_A13B();
				maps\mp\_utility::func_870F();
				return;
			}

			return;
		}

		return;
	}

	self.grenadierfrenzy = 0;
	self.var_12C["sessionProgressionA_Modifier"] = 30;
	self.var_12C["sessionProgressionB_Modifier"] = 30;
	self.var_12C["sessionProgressionC_Modifier"] = 30;
	thread monitorfrenzypoints();
}

//Function Number: 158
getgrenadierprogress()
{
	var_00 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,level.var_3FDC);
	if(!isdefined(var_00) || var_00 == -1)
	{
		var_00 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,"default");
	}

	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	if(self.var_15C < int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,1)))
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,1));
		var_04 = self.var_15C - var_02 / var_03 - var_02;
	}
	else if(self.var_15C < int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,2)))
	{
		var_01 = 1;
		var_02 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,1));
		var_03 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,2));
		var_04 = self.var_15C - var_02 / var_03 - var_02;
	}
	else if(self.var_15C < int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,3)))
	{
		var_01 = 2;
		var_02 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,2));
		var_03 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,3));
		var_04 = self.var_15C - var_02 / var_03 - var_02;
	}
	else if(self.var_15C >= int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,3)))
	{
		var_01 = 3;
		var_02 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,3));
		var_03 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_00,4));
		var_06 = self.var_15C - var_02 / var_03;
		return var_01 + var_06;
	}

	var_06 = var_02 + var_05;
	var_07 = self.grenadierprogressfromtime;
	return var_06 + var_07;
}

//Function Number: 159
monitorfrenzypoints(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	if(self.var_79 != 7)
	{
		return;
	}

	if(isdefined(param_01))
	{
		self.grenadierfrenzystartscore = param_01;
	}
	else
	{
		self.grenadierfrenzystartscore = self.var_15C;
	}

	if(isdefined(param_00))
	{
		self.grenadierfrenzycurrentscore = param_00;
	}
	else
	{
		self.grenadierfrenzycurrentscore = 0;
	}

	self.frenzyscorefromtime = 0;
	self.grenadierworkingtowardfrenzy = 1;
	var_02 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,level.var_3FDC);
	if(!isdefined(var_02) || var_02 == -1)
	{
		var_02 = tablelookuprownum("mp/grenadierUpgradeTable.csv",0,"default");
	}

	var_03 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_02,4));
	var_04 = int(tablelookupbyrow("mp/grenadierUpgradeTable.csv",var_02,5)) / 100;
	self.previousgrenadierfrenzyscore = self.var_15C;
	while(self.var_79 == 7 && self.grenadierfrenzycurrentscore + self.frenzyscorefromtime * var_03 < var_03)
	{
		wait(1);
		self.frenzyscorefromtime = self.frenzyscorefromtime + var_04;
		var_05 = self.var_15C - self.previousgrenadierfrenzyscore;
		self.grenadierfrenzycurrentscore = self.grenadierfrenzycurrentscore + var_05;
		self.previousgrenadierfrenzyscore = self.var_15C;
		self setclientomnvar("ui_grenadier_progress_meter",3 + self.grenadierfrenzycurrentscore / var_03 + self.frenzyscorefromtime);
	}

	if(self.var_79 != 7)
	{
		return;
	}

	self.grenadierworkingtowardfrenzy = 0;
	self.previousgrenadierfrenzyscore = 0;
	self setclientomnvar("ui_grenadier_progress_meter",4);
	togglegrenadierfrenzy(1);
}

//Function Number: 160
processgrenadierheadshot()
{
	if(maps\mp\_utility::func_649("specialty_sessionProgressionC"))
	{
		if(!isdefined(self.var_12C["sessionProgressionC_Modifier"]))
		{
			self.var_12C["sessionProgressionC_Modifier"] = 0;
		}

		self.var_12C["sessionProgressionC_Modifier"]++;
		maps\mp\_utility::func_870F();
		if(self.var_12C["sessionProgressionC_Modifier"] == 1)
		{
			self luinotifyevent(&"grenadier_tier_earned",1,10);
			return;
		}

		if(self.var_12C["sessionProgressionC_Modifier"] == 10)
		{
			self luinotifyevent(&"grenadier_tier_earned",1,11);
			return;
		}

		if(self.var_12C["sessionProgressionC_Modifier"] == 20)
		{
			self luinotifyevent(&"grenadier_tier_earned",1,12);
			return;
		}

		return;
	}
}

//Function Number: 161
setsprintfasterovertime()
{
	thread runsprintfasterovertime();
}

//Function Number: 162
runsprintfasterovertime()
{
	self endon("death");
	self endon("disconnect");
	self endon("sprintFasterOverTime_unset");
	for(;;)
	{
		if(self issprinting())
		{
			graduallyincreasespeed();
			self.sprintfasterovertimemovespeedscale = undefined;
			maps\mp\gametypes\_weapons::func_A13B();
		}

		wait(0.1);
	}
}

//Function Number: 163
graduallyincreasespeed()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("sprintFasterOverTime_reset");
	self endon("sprintFasterOverTime_unset");
	thread sprintfasterovertime_monitormovement();
	thread sprintfasterovertime_monitordamage();
	self.sprintfasterovertimemovespeedscale = 1.07;
	while(self.sprintfasterovertimemovespeedscale < 1.1)
	{
		self.sprintfasterovertimemovespeedscale = self.sprintfasterovertimemovespeedscale + 0.01;
		maps\mp\gametypes\_weapons::func_A13B();
		wait(1.166668);
	}

	self notify("sprintFasterOverTime_maxspeed");
	self waittill("sprintFasterOverTime_reset");
}

//Function Number: 164
sprintfasterovertime_monitormovement()
{
	self endon("death");
	self endon("disconnect");
	self endon("sprintFasterOverTime_unset");
	for(;;)
	{
		if(!self issprinting() || self method_82E5() || !self isonground())
		{
			wait(0.4);
			if(!self issprinting() || self method_82E5() || !self isonground())
			{
				self notify("sprintFasterOverTime_reset");
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 165
sprintfasterovertime_monitordamage()
{
	self endon("death");
	self endon("disconnect");
	self waittill("damage");
	self notify("sprintFasterOverTime_reset");
}

//Function Number: 166
unsetsprintfasterovertime()
{
	self notify("sprintFasterOverTime_unset");
	self.sprintfasterovertimemovespeedscale = undefined;
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 167
setregeneratebulletsovertime()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetRegenerateBulletsOverTime");
	level endon("game_ended");
	for(;;)
	{
		wait(30);
		var_00 = 0;
		var_01 = self getweaponslistprimaries();
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				var_04 = maps\mp\_utility::func_472A(var_03);
				if(maps\mp\gametypes\_weapons::func_5684(var_03) || var_04 == "weapon_riot" || issubstr(var_03,"riotshield") || var_04 == "weapon_projectile" || issubstr(var_03,"exocrossbow") || issubstr(var_03,"microdronelauncher") || maps\mp\_utility::func_5670(var_03) && issubstr(var_03,"grenade_launcher"))
				{
					continue;
				}

				if(maps\mp\gametypes\_weapons::func_5696(var_03))
				{
					var_05 = self getweaponammostock(var_03);
					if(!maps\mp\_utility::func_5670(var_03) && self getfractionmaxammo(var_03) < 1)
					{
						self setweaponammostock(var_03,var_05 + weaponclipsize(var_03));
						var_00 = 1;
					}
				}
			}
		}

		if(var_00)
		{
			maps\mp\gametypes\_damagefeedback::func_A102("resupply_bullets");
		}
	}
}

//Function Number: 168
unsetregeneratebulletsovertime()
{
	self notify("unsetRegenerateBulletsOverTime");
}

//Function Number: 169
setregenerateequipmentovertime()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetRegenerateEquipmentOverTime");
	level endon("game_ended");
	for(;;)
	{
		wait(40);
		var_00 = self method_831F();
		if(var_00 != "none")
		{
			var_01 = self getweaponammoclip(var_00);
			if(!isdefined(self.var_60A0) || var_01 < self.var_60A0)
			{
				self method_82FA(var_00,var_01 + 1);
				maps\mp\gametypes\_damagefeedback::func_A102("resupply_equipment");
			}
		}

		wait(10);
		var_02 = self method_834A();
		if(var_02 != "none")
		{
			var_01 = self getweaponammoclip(var_02);
			if(function_03AD(var_02) && !isdefined(self.var_6088) || var_01 < self.var_6088)
			{
				self method_82FA(var_02,var_01 + 1);
				maps\mp\gametypes\_damagefeedback::func_A102("resupply_equipment");
				if(var_01 == 0)
				{
					self notify("got_lethal_resupply");
				}
			}
		}
	}
}

//Function Number: 170
unsetregenerateequipmentovertime()
{
	self notify("unsetRegenerateEquipmentOverTime");
}

//Function Number: 171
setlaunched()
{
	self endon("disconnect");
	self endon("death");
	self endon("stopAdditionalLauncherAmmoOnSpawn");
	level endon("game_ended");
	if(!maps\mp\_utility::func_649("specialty_class_specialist"))
	{
		common_scripts\utility::func_A70C(self,"spawned_player",level,"prematch_over");
	}

	var_00 = self getweaponslistprimaries();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			var_03 = maps\mp\_utility::func_472A(var_02);
			if(isdefined(var_03) && var_03 == "weapon_projectile")
			{
				self givemaxammo(var_02);
			}
		}
	}
}

//Function Number: 172
unsetlaunched()
{
	self notify("stopAdditionalLauncherAmmoOnSpawn");
}

//Function Number: 173
setrandomgun()
{
	self endon("disconnect");
	self endon("death");
	self endon("stopRandomGun");
	level endon("game_ended");
	for(var_00 = undefined;!isdefined(var_00) || var_00 == "";var_00 = getnextrandomgun())
	{
	}

	self.curwunderlustgun = var_00;
	if(!function_0367())
	{
		common_scripts\utility::func_A70C(self,"spawned_player",self,"faux_spawn",self,"changed_class",level,"prematch_over");
	}

	wait 0.05;
	givenextrandomgun(self getcurrentweapon(),var_00);
	thread watchforweaponpickup();
	self notifyonplayercommand("nextRandomWeaponButtonDown","+weapnext");
	self notifyonplayercommand("nextRandomWeaponButtonUp","-weapnext");
	for(;;)
	{
		self waittill("nextRandomWeaponButtonDown");
		var_01 = gettime();
		self waittill("nextRandomWeaponButtonUp");
		var_02 = gettime();
		if(var_02 - var_01 > 250)
		{
			continue;
		}

		if(isdefined(self.var_2016) && isdefined(self.var_2016.var_201C) && self.var_2016.var_201C == "iw5_carrydrone_mp" || self.var_2016.var_201C == "relic_mp")
		{
			continue;
		}

		if(common_scripts\_plant_weapon::func_5855())
		{
			continue;
		}

		if(!isdefined(self.var_20CC))
		{
			self notify("weapon_plant_cleanup");
			givenextrandomgun(self getcurrentweapon());
			wait(0.65);
		}
	}
}

//Function Number: 174
watchforweaponpickup()
{
	self endon("disconnect");
	self endon("death");
	self endon("stopRandomGun");
	level endon("game_ended");
	for(;;)
	{
		self waittill("pickup_weapon",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(issubstr(maps\mp\_utility::func_472A(var_00),"weapon_") == 0 || maps\mp\_utility::func_5740(var_00))
		{
			continue;
		}

		var_01 = self getweaponslistprimaries();
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(issubstr(var_03,var_00) == 0)
				{
					self takeweapon(var_03);
				}
			}
		}
	}
}

//Function Number: 175
getnextrandomgun()
{
	if(!isdefined(self.wanderlustgunindex) || !isdefined(self.var_12C["wanderlustGunList"]) || self.var_12C["wanderlustGunList"].size <= self.wanderlustgunindex + 3)
	{
		var_00 = [];
		if(isdefined(self.wanderlustgunindex) && isdefined(self.var_12C["wanderlustGunList"]))
		{
			if(self.wanderlustgunindex < self.var_12C["wanderlustGunList"].size)
			{
				var_00[var_00.size] = self.var_12C["wanderlustGunList"][self.wanderlustgunindex];
			}

			if(self.wanderlustgunindex + 1 < self.var_12C["wanderlustGunList"].size)
			{
				var_00[var_00.size] = self.var_12C["wanderlustGunList"][self.wanderlustgunindex + 1];
			}

			if(self.wanderlustgunindex + 2 < self.var_12C["wanderlustGunList"].size)
			{
				var_00[var_00.size] = self.var_12C["wanderlustGunList"][self.wanderlustgunindex + 2];
			}

			if(self.wanderlustgunindex + 3 < self.var_12C["wanderlustGunList"].size)
			{
				var_00[var_00.size] = self.var_12C["wanderlustGunList"][self.wanderlustgunindex + 3];
			}
		}

		self.wanderlustgunindex = 0;
		var_01 = [];
		foreach(var_03 in level.wanderlustweaponlist)
		{
			if(common_scripts\utility::func_562E(var_03["Variant 0"].hidebaseweapon))
			{
				var_04 = var_03["Variant 1"].var_A9E0;
			}
			else
			{
				var_04 = var_03["Variant 0"].var_A9E0;
			}

			var_05 = 6;
			var_06 = maps\mp\_utility::func_472A(var_04);
			if(var_06 == "weapon_heavy" || var_06 == "weapon_sniper")
			{
				var_05--;
			}

			var_07 = getattachmentsforweapon(var_04,var_05);
			var_08 = 0;
			for(var_09 = 0;var_09 < var_07.size;var_09++)
			{
				if(issubstr(var_07[var_09],"_sight"))
				{
					var_08 = 1;
				}
			}

			if(!var_08 && var_06 == "weapon_sniper")
			{
				var_07[var_07.size] = "hold_breath_3";
			}

			var_0A = [];
			for(var_09 = 0;var_09 < var_07.size;var_09++)
			{
				var_0A[var_09] = maps\mp\_utility::func_452A(var_07[var_09]);
			}

			for(var_09 = var_07.size;var_09 < 6;var_09++)
			{
				var_0A[var_09] = 0;
			}

			var_0B = maps\mp\gametypes\_class::func_1D66(var_04,var_0A[0],var_0A[1],var_0A[2],var_0A[3],var_0A[4],var_0A[5],0,0,0,0,0,undefined,5);
			var_01[var_01.size] = var_0B;
		}

		var_01 = common_scripts\utility::func_F92(var_01);
		var_0D = common_scripts\utility::func_F73(var_00,var_01);
		self.var_12C["wanderlustGunList"] = var_0D;
	}

	var_0D = self.var_12C["wanderlustGunList"];
	var_0E = [];
	var_0F = var_0D[self.wanderlustgunindex % var_0D.size];
	var_0E[var_0E.size] = var_0F;
	if(self.wanderlustgunindex + 1 < var_0D.size)
	{
		var_0E[var_0E.size] = var_0D[self.wanderlustgunindex + 1];
	}

	if(self.wanderlustgunindex + 2 < var_0D.size)
	{
		var_0E[var_0E.size] = var_0D[self.wanderlustgunindex + 2];
	}

	if(self.wanderlustgunindex + 3 < var_0D.size)
	{
		var_0E[var_0E.size] = var_0D[self.wanderlustgunindex + 3];
	}

	self method_8512(var_0E);
	self.wanderlustprevgunindex = self.wanderlustgunindex;
	self.wanderlustgunindex++;
	return var_0F;
}

//Function Number: 176
givenextrandomgun(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("giveNextRandomGun");
	self endon("giveNextRandomGun");
	waittillframeend;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		for(var_02 = undefined;!isdefined(var_02) || var_02 == "";var_02 = getnextrandomgun())
		{
		}

		self.curwunderlustgun = var_02;
	}

	var_03 = gettime();
	while(!self method_8512(var_02))
	{
		if(var_03 + 7500 <= gettime())
		{
			givenextrandomgun(self getcurrentweapon());
			return;
		}
		else
		{
			wait 0.05;
		}
	}

	var_04 = self getweaponslistprimaries();
	if(isdefined(var_04))
	{
		foreach(var_06 in var_04)
		{
			if(issubstr(var_06,var_02) == 0)
			{
				self takeweapon(var_06);
			}
		}
	}

	if(self getclientomnvar("ui_show_division_sniper_ability_prompt") == 1)
	{
		self setclientomnvar("ui_show_division_sniper_ability_prompt",0);
	}

	maps\mp\_utility::func_642(var_02);
	thread watchwanderlustweaponchange(var_02);
	var_08 = weaponclipsize(var_02);
	self method_82FA(var_02,var_08);
	if(maps\mp\_utility::func_472A(var_02) == "weapon_shotgun" && var_08 < 5)
	{
		self setweaponammostock(var_02,var_08 * 3);
	}
	else if(issubstr(var_02,"akimbo"))
	{
		self setweaponammostock(var_02,var_08 * 4);
	}
	else if(var_08 < 50)
	{
		self setweaponammostock(var_02,var_08);
	}
	else
	{
		self setweaponammostock(var_02,0);
	}

	self switchtoweapon(var_02);
	var_09 = maps\mp\_utility::func_4431(var_02);
	self.var_12C["primaryWeapon"] = var_09;
	self.var_7704 = var_02;
}

//Function Number: 177
watchwanderlustweaponchange(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("giveNextRandomGun");
	wait(2.5);
	var_01 = self getcurrentweapon();
	if(!isdefined(var_01) || var_01 == "" || var_01 == "none")
	{
		givenextrandomgun(var_01);
	}
}

//Function Number: 178
unsetrandomgun()
{
	self notify("stopRandomGun");
	self notify("giveNextRandomGun");
	self notifyonplayercommandremove("nextRandomWeaponButtonDown","+weapnext");
	self notifyonplayercommandremove("nextRandomWeaponButtonUp","-weapnext");
}

//Function Number: 179
getattachmentsforweapon(param_00,param_01)
{
	if(param_01 <= 0)
	{
		return [];
	}

	var_02 = function_0060(param_00);
	var_02 = common_scripts\utility::func_F92(var_02);
	var_03 = [];
	var_04 = [];
	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		var_06 = 0;
		var_07 = var_02[var_05];
		if(!var_06 && issubstr(var_07,"special_grip") || issubstr(var_07,"bipod") || issubstr(var_07,"hold_breath") || param_00 == "winchester1897_mp" && issubstr(var_07,"dragon_breath"))
		{
			var_06 = 1;
		}

		if(!var_06 && issubstr(var_07,"iron_sight") || issubstr(var_07,"telescopic_sight") || issubstr(var_07,"lens_sight") || issubstr(var_07,"aperture_sight"))
		{
			if(common_scripts\utility::func_24A6())
			{
				var_06 = 1;
			}
		}

		if(!var_06 && issubstr(var_07,"akimbo") || issubstr(var_07,"tactical_knife"))
		{
			if(randomint(100) >= 80)
			{
				var_06 = 1;
			}
		}

		if(!var_06 && issubstr(var_07,"grenade_launcher") || issubstr(var_07,"dragon_breath"))
		{
			if(randomint(100) >= 90)
			{
				var_06 = 1;
			}
		}

		if(!var_06 && isdefined(var_03) && var_03.size > 0)
		{
			foreach(var_09 in var_03)
			{
				if(isdefined(level.attachmentcombosvalues[var_09]))
				{
					var_0A = tablelookup("mp/attachmentcombos_mtx12.csv",0,var_07,level.attachmentcombosvalues[var_09]);
					if(isdefined(var_0A) && var_0A != "")
					{
						var_06 = 1;
						break;
					}
				}
			}
		}

		if(!var_06)
		{
			var_03[var_03.size] = var_07;
			var_04[var_04.size] = var_07;
			if(var_04.size >= param_01)
			{
				break;
			}
		}
	}

	return var_04;
}

//Function Number: 180
buildwunderlustweaponlist()
{
	var_00 = [];
	var_01 = function_027A("mp/statstable.csv");
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = tablelookupbyrow("mp/statstable.csv",var_02,0);
		if(!issubstr(var_03,"weapon_"))
		{
			continue;
		}

		if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive" || var_03 == "weapon_reticle" || var_03 == "weapon_camo" || var_03 == "weapon_attachment" || var_03 == "weapon_charm" || var_03 == "weapon_class_camo")
		{
			continue;
		}

		var_04 = tablelookupbyrow("mp/statstable.csv",var_02,1);
		if(var_03 == "weapon_other" && tolower(getsubstr(var_04,0,7)) != "weapon_")
		{
			continue;
		}

		var_05 = tablelookupbyrow("mp/statstable.csv",var_02,2);
		if(var_05 == "")
		{
			continue;
		}

		if(maps\mp\_utility::func_5716(var_05))
		{
			continue;
		}

		if(issubstr(var_05,"flamethrower") || issubstr(var_05,"tesla") || issubstr(var_05,"riotshield"))
		{
			continue;
		}

		var_06 = tablelookupbyrow("mp/statstable.csv",var_02,18);
		if(var_06 == "")
		{
			continue;
		}

		var_07 = 0;
		if(tablelookupbyrow("mp/statstable.csv",var_02,53) == "1")
		{
			var_07 = 1;
		}

		var_08 = tablelookupbyrow("mp/statstable.csv",var_02,56);
		if(!maps\mp\_utility::productionlevelstringtouidvarbool(var_08))
		{
			continue;
		}

		if(!maps\mp\_utility::isproductionlevelactive(maps\mp\_utility::productionlevelstringtoindex(var_08)))
		{
			continue;
		}

		var_09 = int(var_06);
		var_0A = getbaseweaponguid(var_09);
		var_0B = getweaponvariantid(var_09);
		var_0C = var_0A + "";
		var_0D = "Variant " + var_0B;
		if(!isdefined(var_00[var_0C]))
		{
			var_00[var_0C] = [];
		}

		if(!isdefined(var_00[var_0C][var_0D]))
		{
			var_00[var_0C][var_0D] = spawnstruct();
			var_00[var_0C][var_0D].var_A9E0 = var_05;
			var_00[var_0C][var_0D].hidebaseweapon = var_07;
		}
	}

	var_0E = [];
	foreach(var_10 in var_00)
	{
		if(isdefined(var_10) && isdefined(var_10["Variant 0"]) && !common_scripts\utility::func_562E(var_10["Variant 0"].hidebaseweapon) && isdefined(var_10["Variant 0"].var_A9E0))
		{
			var_0E = common_scripts\utility::func_F6F(var_0E,var_10);
			continue;
		}

		if(isdefined(var_10) && isdefined(var_10["Variant 0"]) && common_scripts\utility::func_562E(var_10["Variant 0"].hidebaseweapon) && isdefined(var_10["Variant 1"]) && isdefined(var_10["Variant 1"].var_A9E0))
		{
			var_0E = common_scripts\utility::func_F6F(var_0E,var_10);
		}
	}

	level.wanderlustweaponlist = var_0E;
	var_12 = [];
	var_13 = function_027B("mp/attachmentcombos_mtx12.csv");
	for(var_14 = 0;var_14 < var_13;var_14++)
	{
		var_15 = tablelookupbyrow("mp/attachmentcombos_mtx12.csv",0,var_14);
		var_12[var_15] = var_14;
	}

	level.attachmentcombosvalues = var_12;
}

//Function Number: 181
setperkstreaks()
{
	if(!isdefined(self.var_12C["specialist_perkstreak_score"]))
	{
		self.var_12C["specialist_perkstreak_score"] = 0;
	}

	self setclientomnvar("specialistPoints",self.var_12C["specialist_perkstreak_score"]);
}

//Function Number: 182
unsetperkstreaks()
{
}

//Function Number: 183
handlespecialisttrainingunlocks()
{
	var_00 = 0;
	for(var_01 = 6;var_01 < 9;var_01++)
	{
		if(shouldgrantspecialistperkindex(var_01))
		{
			var_02 = maps\mp\_utility::func_452B(self.var_5DFA[var_01]);
			if(!isdefined(var_02) || var_02 == "none")
			{
				continue;
			}

			maps\mp\_utility::func_47A3(var_02,var_01);
			var_00++;
		}
	}

	if(shouldgrantspecialistallbasictrainings())
	{
		grantallbasictrainingsforspecialist();
		var_00++;
	}

	if(var_00 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 184
isspecialistperk(param_00)
{
	if(!isdefined(self) || !isdefined(self.var_5DFA))
	{
		return 0;
	}

	for(var_01 = 6;var_01 < 9;var_01++)
	{
		if(param_00 == maps\mp\_utility::func_452B(self.var_5DFA[var_01]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 185
hasspecialistperkunlocked(param_00)
{
	if(!isdefined(self) || !isdefined(self.var_5DFA))
	{
		return 0;
	}

	for(var_01 = 6;var_01 < 9;var_01++)
	{
		if(param_00 == maps\mp\_utility::func_452B(self.var_5DFA[var_01]))
		{
			return shouldgrantspecialistperkindex(var_01);
		}
	}

	return 0;
}

//Function Number: 186
shouldgrantspecialistperkindex(param_00)
{
	var_01 = param_00 - 6 + 1;
	if(var_01 <= 0 || var_01 > 3)
	{
		return;
	}

	if(!isdefined(self.var_12C["specialist_perkstreak_score"]))
	{
		self.var_12C["specialist_perkstreak_score"] = 0;
	}

	var_02 = self.var_12C["specialist_perkstreak_score"];
	return var_02 >= getdvarint("specialistBasicTraining" + var_01 + "_score");
}

//Function Number: 187
shouldgrantspecialistallbasictrainings()
{
	if(!isdefined(self.var_12C["specialist_perkstreak_score"]))
	{
		self.var_12C["specialist_perkstreak_score"] = 0;
	}

	var_00 = self.var_12C["specialist_perkstreak_score"];
	return var_00 >= getdvarint("specialistBasicTraining4_score");
}

//Function Number: 188
processspecialistevent(param_00)
{
	if(!maps\mp\_utility::func_649("specialty_perkstreaks") || !maps\mp\_utility::func_57A0(self))
	{
		return;
	}

	var_01 = maps\mp\gametypes\_rank::func_4671(param_00);
	if(var_01 <= 0)
	{
		return;
	}

	if(!isdefined(self.var_12C["specialist_perkstreak_score"]))
	{
		self.var_12C["specialist_perkstreak_score"] = 0;
	}

	var_02 = self.var_12C["specialist_perkstreak_score"];
	var_03 = var_02 + var_01;
	self.var_12C["specialist_perkstreak_score"] = var_03;
	self setclientomnvar("specialistPoints",var_03);
	for(var_04 = 0;var_04 < 4;var_04++)
	{
		var_05 = getdvarint("specialistBasicTraining" + var_04 + 1 + "_score");
		if(var_03 >= var_05)
		{
			if(var_02 < var_05)
			{
				if(var_04 == 3)
				{
					grantallbasictrainingsforspecialist();
					maps\mp\perks\_perks::func_F36();
					thread maps\mp\gametypes\_hud_message::func_9102("specialist_tier_earned",var_04 + 1);
					maps\mp\gametypes\_missions::func_7750("ch_dlc3_specialist");
					continue;
				}

				var_06 = 6 + var_04;
				var_07 = maps\mp\_utility::func_452B(self.var_5DFA[var_06]);
				if(isdefined(var_07) && var_07 != "none")
				{
					maps\mp\_utility::func_47A3(var_07,var_06);
					maps\mp\perks\_perks::func_F36();
					thread maps\mp\gametypes\_hud_message::func_9102("specialist_tier_earned",var_04 + 1);
					maps\mp\gametypes\_missions::func_7750("ch_dlc3_specialist");
				}
			}
		}
	}
}

//Function Number: 189
grantallbasictrainingsforspecialist()
{
	maps\mp\_utility::func_47A2("specialty_class_hustle");
	maps\mp\_utility::func_47A2("specialty_class_gunslinger");
	maps\mp\_utility::func_47A2("specialty_class_energetic");
	maps\mp\_utility::func_47A2("specialty_class_inconspicuous");
	maps\mp\_utility::func_47A2("specialty_class_scoped");
	maps\mp\_utility::func_47A2("specialty_class_duelist");
	maps\mp\_utility::func_47A2("specialty_class_rifleman");
	maps\mp\_utility::func_47A2("specialty_class_forage");
	maps\mp\_utility::func_47A2("specialty_class_serrated");
	maps\mp\_utility::func_47A2("specialty_class_hunker");
	maps\mp\_utility::func_47A2("specialty_class_launched");
	maps\mp\_utility::func_47A2("specialty_class_undercover");
	maps\mp\_utility::func_47A2("specialty_class_lookout");
	maps\mp\_utility::func_47A2("specialty_class_instincts");
	maps\mp\_utility::func_47A2("specialty_class_flanker");
	maps\mp\_utility::func_47A2("specialty_class_espionage");
	maps\mp\_utility::func_47A2("specialty_class_shifty");
	maps\mp\_utility::func_47A2("specialty_class_saboteur");
	maps\mp\_utility::func_47A2("specialty_class_clandestine");
	maps\mp\_utility::func_47A2("specialty_class_escalation");
	if(getdvarint("6019",1) == 1)
	{
		maps\mp\_utility::func_47A2("specialty_class_remedy");
	}
}

//Function Number: 190
resetspecialistperkstreak()
{
	if(maps\mp\_utility::func_585F())
	{
		return;
	}

	self.var_12C["specialist_perkstreak_score"] = 0;
	self setclientomnvar("specialistPoints",0);
}

//Function Number: 191
fasterhealthregenkilltrigger()
{
	if(self.var_BC < self.var_FB)
	{
		self.var_50A0 = 1;
		self notify("damage");
	}
}

//Function Number: 192
handleclassifiedboostaftermultikillorheadshot(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_01 = self.var_7AD2 >= 2;
	if(var_01)
	{
		var_02 = "classified_bonus_multikill";
		switch(self.var_7AD2)
		{
			case 6:
				var_02 = "classified_bonus_sixkill";
				break;

			case 5:
				var_02 = "classified_bonus_fivekill";
				break;

			case 4:
				var_02 = "classified_bonus_fourkill";
				break;

			case 3:
				var_02 = "classified_bonus_triplekill";
				break;

			case 2:
				var_02 = "classified_bonus_doublekill";
				break;
		}

		level thread maps\mp\gametypes\_rank::func_1457(var_02,self);
	}

	if(param_00)
	{
		level thread maps\mp\gametypes\_rank::func_1457("classified_bonus_headshot",self);
	}

	if(var_01 || param_00)
	{
		maps\mp\gametypes\_missions::func_7750("ch_commando_skill");
		var_03 = 0;
		var_04 = self getweaponslistprimaries();
		if(isdefined(var_04))
		{
			foreach(var_06 in var_04)
			{
				var_07 = maps\mp\_utility::func_472A(var_06);
				if(maps\mp\gametypes\_weapons::func_5684(var_06) || var_07 == "weapon_riot" || issubstr(var_06,"riotshield") || var_07 == "weapon_projectile" || issubstr(var_06,"exocrossbow") || issubstr(var_06,"microdronelauncher") || maps\mp\_utility::func_5670(var_06) && issubstr(var_06,"grenade_launcher"))
				{
					continue;
				}

				if(maps\mp\gametypes\_weapons::func_5696(var_06))
				{
					var_08 = self getweaponammostock(var_06);
					if(!maps\mp\_utility::func_5670(var_06) && self getfractionmaxammo(var_06) < 1)
					{
						self setweaponammostock(var_06,var_08 + weaponclipsize(var_06));
						var_03 = 1;
					}
				}
			}
		}

		if(var_03)
		{
			maps\mp\gametypes\_damagefeedback::func_A102("resupply_bullets");
		}
	}
}

//Function Number: 193
setclassifiedboostafterreload()
{
}

//Function Number: 194
unsetclassifiedboostafterreload()
{
	self setclientomnvar("ui_classifiedboost_active",0);
	self.classifiedboostafterreloadactive = 0;
}

//Function Number: 195
handleclassifiedboostafterreload()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("classifiedBoostAfterReload");
	self endon("classifiedBoostAfterReload");
	self setclientomnvar("ui_classifiedboost_active",1);
	self.classifiedboostafterreloadactive = 1;
	var_00 = maps\mp\_utility::func_649("specialty_rof");
	if(!var_00)
	{
		maps\mp\_utility::func_47A2("specialty_rof");
	}

	var_01 = maps\mp\_utility::func_649("specialty_bulletaccuracy");
	if(!var_01)
	{
		maps\mp\_utility::func_47A2("specialty_bulletaccuracy");
	}

	wait(3.5);
	if(maps\mp\_utility::func_649("specialty_rof") && !var_00)
	{
		maps\mp\_utility::func_735("specialty_rof");
	}

	if(maps\mp\_utility::func_649("specialty_bulletaccuracy") && !var_01)
	{
		maps\mp\_utility::func_735("specialty_bulletaccuracy");
	}

	self setclientomnvar("ui_classifiedboost_active",0);
	self.classifiedboostafterreloadactive = 0;
}

//Function Number: 196
isclassifiedsecondbt(param_00)
{
	if(!isdefined(self) || !isdefined(self.var_5DFA))
	{
		return 0;
	}

	if(param_00 == maps\mp\_utility::func_452B(self.var_5DFA[4]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 197
hasclassifiedsecondbt()
{
	return isdefined(self.var_6F65) && isdefined(self.var_6F65["specialty_class_commando_grandmaster"]);
}

//Function Number: 198
setserumbasictraining()
{
	thread handleserumbasictraining();
}

//Function Number: 199
unsetserumbasictraining()
{
	self notify("unsetRegenerateSerumOverTime");
}

//Function Number: 200
serumbasictraininglistener()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetRegenerateSerumOverTime");
	level endon("game_ended");
	for(;;)
	{
		self waittill("altered_state_apply");
		var_00 = maps/mp/killstreaks/_raid_ss_serum_util::getserumkillstreakslot("basic_training_serum");
		var_01 = maps/mp/killstreaks/_raid_ss_serum_util::getserumkillstreakslot("raid_ss_serum_a","raid_ss_serum_b","raid_ss_serum_c");
		if(isdefined(var_00) && !common_scripts\utility::func_562E(self.basictrainingserumactive))
		{
			maps/mp/killstreaks/_raid_ss_serum_util::disableserum(var_00);
			continue;
		}

		if(isdefined(var_01) && common_scripts\utility::func_562E(self.basictrainingserumactive))
		{
			maps/mp/killstreaks/_raid_ss_serum_util::disableserum(var_01);
		}
	}
}

//Function Number: 201
handleserumbasictraining()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetRegenerateSerumOverTime");
	level endon("game_ended");
	var_00 = 1;
	if(maps\mp\_utility::func_551F() || getdvar("1924") == "hub")
	{
		return;
	}

	wait(0.1);
	if(!isdefined(self.var_12C["basicTrainingSerumsUsed"]))
	{
		self.var_12C["basicTrainingSerumsUsed"] = 0;
	}

	if(!isdefined(self.var_12C["basicTrainingSerumEarnProgress"]))
	{
		self.var_12C["basicTrainingSerumEarnTimeRemaining"] = 0;
		self.var_12C["basicTrainingSerumEarnProgress"] = 1;
	}

	thread serumbasictraininglistener();
	for(;;)
	{
		if(self.var_12C["basicTrainingSerumEarnProgress"] >= 1)
		{
			var_01 = self.var_12C["basicTrainingSerumsUsed"];
			if(common_scripts\utility::func_562E(self.raidserumactive))
			{
				self waittill("serum_finished");
			}

			thread maps\mp\killstreaks\_killstreaks::func_478D("basic_training_serum",0,0,self,1);
			if(!var_00)
			{
				thread maps\mp\gametypes\_hud_message::func_5A78("basic_training_serum",500,undefined,undefined);
			}

			while(var_01 == self.var_12C["basicTrainingSerumsUsed"])
			{
				wait 0.05;
			}

			wait(level.serumbasictrainingactiveduration);
		}

		var_00 = 0;
		var_02 = gettime();
		while(self.var_12C["basicTrainingSerumEarnProgress"] < 1)
		{
			var_03 = gettime();
			self.var_12C["basicTrainingSerumEarnTimeRemaining"] = self.var_12C["basicTrainingSerumEarnTimeRemaining"] - max(0,var_03 - var_02);
			self.var_12C["basicTrainingSerumEarnProgress"] = max(0,1 - self.var_12C["basicTrainingSerumEarnTimeRemaining"] / level.serumbasictrainingcooldowninterval);
			self setclientomnvar("ks_count1",self.var_12C["basicTrainingSerumEarnProgress"]);
			var_02 = var_03;
			wait(0.15);
		}
	}
}
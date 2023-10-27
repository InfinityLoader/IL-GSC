/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_glidebomb.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 343 ms
 * Timestamp: 10/27/2023 3:24:58 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_67B = [];
	level.var_67B["Particle_FX"] = spawnstruct();
	level.var_611["fritz_streamers"] = loadfx("vfx/trail/fritzx_streamers");
	level.var_611["fritz_explosion_1P"] = loadfx("vfx/explosion/fritzx_explosion_01_1p");
	level.var_611["fritz_flying_1P"] = loadfx("vfx/vehicle/fritzx_flying_1p");
	level.var_611["glidebomb_hatchdoors_light_bright"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_bright");
	level.var_611["glidebomb_hatchdoors_light_med"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_med");
	level.var_611["glidebomb_hatchdoors_light_low"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_low");
	level.var_67B["Audio"] = spawnstruct();
	level.var_67B["Launch_Value"] = spawnstruct();
	level.var_67B["Launch_Value"].var_A416 = 24000;
	level.var_67B["Launch_Value"].var_4DF8 = 7000;
	level.var_67B["Launch_Value"].var_9826 = 1500;
	level.var_5A61["fritzx"] = ::func_9E2F;
	level.var_5A7D["fritzx_projectile_mp"] = "fritzx";
	level.var_5A7D["azon_projectile_mp"] = "fritzx";
	level.var_5A7D["fritzx_projectile_grenadier_mp"] = "fritzx";
	level.var_5A7D["azon_projectile_grenadier_mp"] = "fritzx";
}

//Function Number: 2
func_9E2F(param_00)
{
	if(maps\mp\_utility::func_5668())
	{
		return 0;
	}

	if(isdefined(self.var_6E6B) && self.var_6E6B)
	{
		self iclientprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
		return 0;
	}

	if(isdefined(self.var_4B69))
	{
		self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	var_01 = maps\mp\killstreaks\_killstreaks::func_5345("fritzx",1,0,0);
	if(var_01 != "success")
	{
		wait(0.75);
		var_02 = self getcurrentweapon();
		if(var_02 == "none" || maps\mp\_utility::func_5740(var_02))
		{
			self switchtoweapon(common_scripts\utility::func_4550());
		}

		return 0;
	}

	maps\mp\_utility::func_744E();
	maps\mp\_utility::func_8A5B("fritzx");
	self.var_3EE8 = 0;
	thread func_92D3(var_01);
	return 1;
}

//Function Number: 3
func_92D3(param_00)
{
	maps\mp\_utility::func_3E8E(1);
	var_01 = level.var_5A6B;
	if(isdefined(level.var_47CD))
	{
		var_01 = level.var_47CD;
	}

	thread lib_0526::func_8A61(0.05,level.var_5A7C,var_01);
	lib_0526::func_A232(1);
	if(level.var_3FDC == "scorestreak_training")
	{
		maps/mp/gametypes/scorestreak_training::func_244D();
	}

	var_02 = func_49DA();
	thread func_3496(param_00,var_02);
}

//Function Number: 4
func_3EEA(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00))
	{
		var_02 = param_00 maps\mp\_utility::func_649("specialty_improvedstreaks");
	}

	var_03 = 0;
	var_04 = 1;
	var_05 = 1;
	var_06 = "fritzx_projectile_mp";
	if(var_02)
	{
		var_06 = "fritzx_projectile_grenadier_mp";
	}

	var_07 = getweaponexplosionradius(var_06);
	var_08 = 100;
	var_09 = 0;
	var_0A = getweaponexplosiondistancefordamage(var_06,var_09,var_08);
	if(var_0A > var_07)
	{
		var_0A = var_07;
	}

	var_0B = var_0A * 2;
	self.var_5A88 = spawnplane("script_model",param_01);
	self.var_5A88 method_8351(param_00,"scorestreak_minimap_mortar_strike_kill",var_0B,var_0B,var_04,var_03,"","scorestreak_minimap_mortar_strike_kill_fullscreen");
	self.var_5A88 method_8352(4000,var_05);
	self.var_5A88 method_8449(self,"tag_origin",(0,0,0),(0,0,0));
	if(var_0A < var_07)
	{
		var_0C = var_07 * 2;
		self.var_29E1 = spawnplane("script_model",param_01);
		self.var_29E1 method_8351(param_00,"scorestreak_minimap_mortar_strike_damage",var_0C,var_0C,var_04,var_03,"","scorestreak_minimap_mortar_strike_damage_fullscreen");
		self.var_29E1 method_8352(4000,var_05);
		self.var_29E1 method_8449(self,"tag_origin",(0,0,0),(0,0,0));
	}
}

//Function Number: 5
func_3EE9()
{
	var_00 = 0;
	if(isdefined(self.var_29E1))
	{
		self.var_29E1 method_8352(80,var_00);
	}

	if(isdefined(self.var_5A88))
	{
		self.var_5A88 method_8352(80,var_00);
	}

	wait(0.08);
	if(isdefined(self.var_29E1))
	{
		self.var_29E1 delete();
	}

	if(isdefined(self.var_5A88))
	{
		self.var_5A88 delete();
	}
}

//Function Number: 6
func_49DA()
{
	var_00 = 120;
	var_01 = 0;
	var_02 = func_4433();
	thread func_700F();
	var_03 = spawn("script_model",var_02.var_92FA);
	var_03 setmodel("tag_origin");
	var_03.var_1D = (90,0,0);
	self method_81E2(var_03,"tag_origin");
	var_04 = spawn("script_model",var_02.var_92FA + (-1 * var_01,0,-1 * var_00 - 52));
	var_04 notsolid();
	if(isdefined(self.var_1A7) && self.var_1A7 == "allies")
	{
		var_04 setmodel("usa_glidebomb_hatchdoors");
	}
	else
	{
		var_04 setmodel("ger_glidebomb_hatchdoors");
	}

	var_04 method_805C();
	var_04 showtoclient(self);
	var_04 scriptmodelplayanim("ks_usa_glidebomb_hatchdoors_open");
	var_05 = spawn("script_model",var_02.var_92FA + (-1 * var_01,0,-1 * var_00));
	if(isdefined(level.crafting_table))
	{
		playfxontagforclients(common_scripts\utility::func_44F5(level.crafting_table),var_04,"TAG_ORIGIN",self);
	}
	else
	{
		playfxontagforclients(common_scripts\utility::func_44F5("glidebomb_hatchdoors_light_med"),var_04,"TAG_ORIGIN",self);
	}

	thread func_5A06(var_04);
	var_06 = getnorthyaw();
	if(var_06 != 0)
	{
		var_03.var_1D = var_03.var_1D + (0,var_06,0);
		var_04.var_1D = var_04.var_1D + (0,var_06,0);
		var_05.var_1D = var_05.var_1D + (0,var_06,0);
	}

	var_07 = "ger_glidebomb_fritzx";
	if(isdefined(self.var_1A7) && self.var_1A7 == "allies")
	{
		var_07 = "usa_glidebomb_azon";
	}

	var_05 setmodel(var_07);
	var_05 method_805C();
	var_05 showtoclient(self);
	if(isdefined(level.var_47CD))
	{
		self lightsetforplayer(level.var_47CD);
	}

	wait(0.7);
	if(isdefined(level.var_47CE))
	{
		self lightsetforplayer(level.var_47CE);
	}

	var_08 = spawnstruct();
	var_08.var_3290 = var_04;
	var_08.var_92FA = var_02.var_92FA;
	var_08.var_8203 = var_05;
	var_08.var_1E99 = var_03;
	var_08.var_3DBF = var_00;
	var_08.var_4C35 = var_01;
	var_08.var_3EE5 = var_05.var_1D;
	return var_08;
}

//Function Number: 7
func_5A06(param_00)
{
	level waittill("bomb_start");
	if(isdefined(level.crafting_table))
	{
		function_0295(common_scripts\utility::func_44F5(level.crafting_table),param_00,"TAG_ORIGIN",self);
		return;
	}

	function_0295(common_scripts\utility::func_44F5("glidebomb_hatchdoors_light_med"),param_00,"TAG_ORIGIN",self);
}

//Function Number: 8
func_3496(param_00,param_01)
{
	var_02 = param_01.var_92FA;
	var_03 = param_01.var_92FA + (-1 * param_01.var_4C35 + 68,0,-1 * param_01.var_3DBF);
	var_04 = maps\mp\_utility::func_649("specialty_improvedstreaks");
	if(isdefined(var_04) && var_04)
	{
		var_05 = "azon_projectile_grenadier_mp";
		if(isdefined(self.var_1A7) && self.var_1A7 == "axis")
		{
			var_05 = "fritzx_projectile_grenadier_mp";
		}
	}
	else
	{
		var_05 = "azon_projectile_mp";
		if(isdefined(self.var_1A7) && self.var_1A7 == "axis")
		{
			var_05 = "fritzx_projectile_mp";
		}
	}

	param_01.var_8203 method_805C();
	param_01.var_8203 delete();
	var_06 = var_02 + (-1 * param_01.var_4C35,0,-1 * param_01.var_3DBF);
	var_07 = var_02 + (0,getnorthyaw(),0);
	var_08 = magicbullet(var_05,var_06,var_07,self);
	var_08.var_1D = param_01.var_3EE5;
	var_08 method_866D(1,1);
	var_08 thread func_49F7(self);
	var_08.var_5A2C = param_01.var_1E99;
	var_08.var_5A2C setscriptmoverkillcam("script_entity");
	var_08.var_5A2C.var_5A32 = gettime();
	var_08.var_117 = self;
	var_08.var_1A7 = self.var_1A7;
	var_08.var_5CC6 = param_00;
	var_08.var_1B9 = "remote";
	var_08.var_4C35 = param_01.var_4C35;
	var_08.var_3DBF = param_01.var_3DBF;
	thread func_3162(var_07,var_06);
	self method_8200(var_08);
	param_01.var_1E99 thread func_1E9A(var_08,self);
	self thermalvisionfofoverlayon();
	level.var_7C66 = 1;
	var_08 thread maps\mp\gametypes\_damage::func_8676(10,undefined,::func_624B,undefined,1);
	var_08 func_3EEA(self,var_03);
	maps\mp\_matchdata::func_5E9A("fritzx",var_08.var_116);
	thread func_2380(var_08,param_01);
}

//Function Number: 9
func_3162(param_00,param_01)
{
	self endon("missile_strike_complete");
	self endon("ms_early_exit");
	self endon("disconnect");
	wait(2);
	self method_84B4();
	var_02 = (param_00[0],param_00[1],param_00[2] - 10000);
	var_03 = bullettrace(param_01,var_02,0);
	var_04 = var_03["position"];
	var_05 = length(param_01 - var_04);
	self method_84B7(0.35,var_05,1,0.5,var_04);
}

//Function Number: 10
func_700F()
{
	lib_0380::func_6840("ks_fritz_plr_plane",[self]);
}

//Function Number: 11
func_49F7(param_00)
{
	var_01 = self;
	if(isdefined(param_00))
	{
		thread func_3EE7(var_01,param_00);
	}

	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		if(!isdefined(param_00) || var_04 != param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(isdefined(var_02) && var_02.size > 0)
	{
		thread func_3EE6(var_01,var_02);
	}
}

//Function Number: 12
func_3EE7(param_00,param_01)
{
	wait(1);
	var_02 = lib_0380::func_6844("ks_fritz_plr_inc",[param_01],param_00);
	param_00 waittill("death");
	lib_0380::func_6850(var_02);
	lib_0380::func_6842("ks_fritz_plr_exp_trans",[param_01],param_00.var_116);
}

//Function Number: 13
func_3EE6(param_00,param_01)
{
	var_02 = lib_0380::func_6844("ks_fritz_npc_inc",param_01,param_00);
	param_00 waittill("death");
	lib_0380::func_6850(var_02);
	lib_0380::func_6842("ks_fritz_exp_trans",param_01,param_00.var_116);
}

//Function Number: 14
func_1E9A(param_00,param_01)
{
	param_01 endon("disconnect");
	param_01 endon("missile_strike_complete");
	param_01 endon("ms_early_exit");
	param_00 endon("death");
	var_02 = (param_00.var_4C35,0,param_00.var_3DBF);
	self.var_116 = param_00.var_116 + var_02;
	self.var_1D = vectortoangles((0,0,-1));
	var_03 = param_00.var_116;
	var_04 = 0;
	var_05 = 0;
	var_06 = getnorthyaw();
	if(var_06 != 0)
	{
		self.var_1D = self.var_1D + (0,var_06,0);
	}

	level notify("bomb_start");
	for(;;)
	{
		var_07 = param_00.var_3DBF;
		var_08 = param_00.var_4C35;
		var_09 = param_00.var_116 - var_03;
		if(length(var_09) > 0.01)
		{
			var_0A = vectornormalize(var_09);
			if(var_04)
			{
				if(getnorthyaw() != 0)
				{
					var_0B = var_0A * -1 * var_07 + (-1 * var_08,0,0);
				}
				else
				{
					var_0B = var_0B * -1 * var_08 + (0,-1 * var_09,0);
				}

				var_0C = self.var_1D;
				if(var_05 < 1)
				{
					var_02 = vectorlerp(var_02,var_0B,var_05);
					var_0C = angleslerp(self.var_1D,param_00.var_1D,var_05);
					var_05 = var_05 + 0.05;
				}
				else
				{
					var_02 = var_0B;
					var_0C = param_00.var_1D;
				}

				self.var_116 = param_00.var_116 + var_02;
				self.var_1D = var_0C;
			}
			else
			{
				var_0D = (0,0,-1);
				var_0E = anglestoforward(param_00.var_1D);
				var_0F = vectordot(var_0D,var_0E);
				if(var_0F > 0.99)
				{
					var_04 = 1;
					param_01 maps\mp\_utility::func_3E8E(0);
					if(getdvarint("5270",1))
					{
						param_01 setclientomnvar("ui_show_fritzx_hud",1);
					}

					param_01 thread func_7CF0(param_00,param_01);
					playfxontag(common_scripts\utility::func_44F5("fritz_streamers"),param_00,"tag_tip_fx");
					playfxontagforclients(common_scripts\utility::func_44F5("fritz_flying_1P"),param_00,"tag_tip_fx",param_01);
					var_0B = var_0A * -1 * var_07;
					var_02 = vectorlerp(var_02,var_0B,var_05);
					self.var_116 = param_00.var_116 + var_02;
					self.var_1D = angleslerp(self.var_1D,param_00.var_1D,var_05);
					var_05 = var_05 + 0.05;
					param_01 thread func_5C81(param_00);
				}
				else
				{
					self.var_116 = param_00.var_116 + (var_08,0,var_07);
				}
			}
		}

		var_03 = param_00.var_116;
		param_01 playrumbleonentity("damage_light");
		wait 0.05;
	}
}

//Function Number: 15
func_2380(param_00,param_01)
{
	param_00 thread func_7EB5();
	thread func_7242(param_01,param_00);
	thread func_7243(param_00);
	thread func_7244(param_00);
	thread func_7489();
	self.var_4B69 = 1;
	param_00 waittill("death");
	level notify("bomb_end");
	param_00 thread func_3EE9();
	if(isdefined(self))
	{
		lib_0526::func_A232(0);
		self.var_4B69 = undefined;
		if(isdefined(param_00))
		{
			playfxontagforclients(common_scripts\utility::func_44F5("fritz_explosion_1P"),param_00,"tag_tip_fx",self);
		}

		self notify("missile_strike_complete");
	}
}

//Function Number: 16
func_7CF0(param_00,param_01)
{
	param_01 endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isbot(param_01))
	{
		param_01 notifyonplayercommand("ExitButtonDown","+activate");
		param_01 notifyonplayercommand("ExitButtonUp","-activate");
	}

	param_01 notifyonplayercommand("ExitButtonDown","+usereload");
	param_01 notifyonplayercommand("ExitButtonUp","-usereload");
	for(;;)
	{
		self waittill("ExitButtonDown");
		if(isdefined(func_A778(0.5,param_00,param_01)))
		{
			self notify("ms_early_exit");
			return;
		}
	}
}

//Function Number: 17
func_A778(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	level endon("game_ended");
	param_02 endon("ExitButtonUp");
	param_01 endon("death");
	wait(param_00);
	return 1;
}

//Function Number: 18
func_7CEF(param_00)
{
	if(!isbot(param_00))
	{
		param_00 notifyonplayercommandremove("ExitButtonDown","+activate");
		param_00 notifyonplayercommandremove("ExitButtonUp","-activate");
	}

	param_00 notifyonplayercommandremove("ExitButtonDown","+usereload");
	param_00 notifyonplayercommandremove("ExitButtonUp","-usereload");
}

//Function Number: 19
func_4434(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.var_A280 = [];
		var_03.var_9099 = 0;
	}

	foreach(var_06 in level.var_744A)
	{
		if(!maps\mp\_utility::func_57A0(var_06))
		{
			continue;
		}

		if(var_06.var_1A7 == self.var_1A7)
		{
			continue;
		}

		if(var_06.var_1A7 == "spectator")
		{
			continue;
		}

		var_07 = 999999999;
		var_08 = undefined;
		foreach(var_03 in param_00)
		{
			var_03.var_A280[var_03.var_A280.size] = var_06;
			var_0A = distance2d(var_03.var_1A4.var_116,var_06.var_116);
			if(var_0A <= var_07)
			{
				var_07 = var_0A;
				var_08 = var_03;
			}
		}

		var_08.var_9099 = var_08.var_9099 + 2;
	}

	var_0D = param_00[0];
	foreach(var_11, var_03 in param_00)
	{
		foreach(var_06 in var_03.var_A280)
		{
			var_03.var_9099 = var_03.var_9099 + 1;
			if(bullettracepassed(var_06.var_116 + (0,0,32),var_03.var_116,0,var_06))
			{
				var_03.var_9099 = var_03.var_9099 + 3;
			}

			if(var_03.var_9099 > var_0D.var_9099)
			{
				var_0D = var_03;
				continue;
			}

			if(var_03.var_9099 == var_0D.var_9099)
			{
				if(common_scripts\utility::func_24A6())
				{
					var_0D = var_03;
				}
			}
		}
	}

	return var_0D;
}

//Function Number: 20
func_624B(param_00,param_01,param_02,param_03)
{
	playfx(level.var_7C65["explode"],self.var_116);
	var_04 = "fritzx_destroyed";
	maps\mp\gametypes\_damage::func_6B4B(param_00,param_01,param_02,param_03,var_04,undefined,undefined,0);
	func_3EE9();
	self delete();
}

//Function Number: 21
func_4433()
{
	var_00 = spawnstruct();
	var_01 = common_scripts\utility::func_44BE("remoteMissileSpawn","targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_1A2))
		{
			var_03.var_1A4 = getent(var_03.var_1A2,"targetname");
		}
	}

	if(var_01.size > 0)
	{
		var_05 = func_4434(var_01);
	}
	else
	{
		var_05 = undefined;
	}

	var_00.var_92FA = undefined;
	var_00.var_9834 = undefined;
	if(isdefined(var_05))
	{
		var_00.var_92FA = var_05.var_116;
		var_00.var_9834 = var_05.var_1A4.var_116;
		var_06 = 5500;
		if(isdefined(level.var_7C62))
		{
			var_06 = level.var_7C62;
		}

		var_07 = vectornormalize(var_00.var_92FA - var_00.var_9834);
		var_00.var_92FA = var_07 * var_06 + var_00.var_9834;
	}
	else
	{
		var_08 = (0,0,level.var_67B["Launch_Value"].var_A416);
		var_06 = level.var_67B["Launch_Value"].var_4DF8;
		var_09 = level.var_67B["Launch_Value"].var_9826;
		var_0A = anglestoforward(self.var_1D);
		var_00.var_92FA = self.var_116 + var_08 + var_0A * var_06 * -1;
		var_00.var_9834 = self.var_116 + var_0A * var_09;
	}

	return var_00;
}

//Function Number: 22
func_7489()
{
	common_scripts\utility::func_A732("missile_strike_complete","ms_early_exit");
	func_7445();
}

//Function Number: 23
func_7445()
{
	self endon("disconnect");
	self method_8201();
	maps\mp\_utility::func_3E8E(1);
	func_7CEF(self);
	self setclientomnvar("ui_show_fritzx_hud",0);
	if(!level.var_3F9D || isdefined(self.var_3B4B))
	{
		lib_0526::func_745C();
	}

	wait 0.05;
	maps\mp\gametypes\_hostmigration::func_A782();
	self thermalvisionfofoverlayoff();
	self setshadows(1);
	lib_0526::func_7D04(0.05);
	lib_0526::func_A232(0);
	wait 0.05;
	self method_84B6();
	self method_81E3();
	maps\mp\_utility::func_3E8E(0);
	if(maps\mp\_utility::func_581D())
	{
		maps\mp\_utility::func_2414();
	}

	if(getdvarint("311"))
	{
		maps\mp\_utility::func_8742(1);
	}

	maps\mp\_utility::func_7447();
}

//Function Number: 24
func_7244(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	common_scripts\utility::knock_off_battery("joined_team","joined_spectators");
	self notify("missile_strike_complete");
	level.var_7C66 = undefined;
}

//Function Number: 25
func_7EB5()
{
	var_00 = self getentitynumber();
	level.var_7EBB[var_00] = self;
	self waittill("death");
	level.var_7EBB[var_00] = undefined;
	level.var_7C66 = undefined;
}

//Function Number: 26
func_7242(param_00,param_01)
{
	common_scripts\utility::knock_off_battery("ms_early_exit","missile_strike_complete","disconnect");
	param_00.var_3290 method_805C();
	param_00.var_3290 delete();
	if(isdefined(self))
	{
		self method_8201();
		if(isdefined(param_01))
		{
			function_0295(common_scripts\utility::func_44F5("fritz_flying_1P"),param_01,"tag_tip_fx",self);
		}
	}
}

//Function Number: 27
func_7243(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	level waittill("game_ended");
	self notify("missile_strike_complete");
}

//Function Number: 28
func_A68D(param_00)
{
	self endon("missile_strike_complete");
	wait(param_00);
	self setshadows(0);
}

//Function Number: 29
func_5C81(param_00)
{
	self endon("disconnect");
	self endon("missile_strike_complete");
	self endon("ms_early_exit");
	var_01 = 0;
	for(;;)
	{
		if(var_01 >= 1.2)
		{
			param_00.var_3DBF = param_00.var_3DBF - 4;
			if(param_00.var_4C35 < 32)
			{
				param_00.var_4C35 = param_00.var_4C35 + 0.7;
			}
			else
			{
				param_00.var_4C35 = param_00.var_4C35 + 0.2;
			}
		}
		else if(param_00.var_4C35 < 32)
		{
			param_00.var_4C35 = param_00.var_4C35 + 0.5;
		}

		if(param_00.var_3DBF <= 5)
		{
			param_00.var_3DBF = 5;
			break;
		}

		var_01 = var_01 + 0.05;
		wait 0.05;
	}
}
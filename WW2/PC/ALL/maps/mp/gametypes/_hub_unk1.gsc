/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hub_unk1.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 98
 * Decompile Time: 1630 ms
 * Timestamp: 10/27/2023 3:23:38 AM
*******************************************************************/

//Function Number: 1
func_4F43()
{
	precacherumble("light_1s");
	level.var_707C = loadfx("vfx/map/mp_hub/clay_plate_death");
	level.var_5959 = loadfx("vfx/explosion/jerrycan_destruct_runner");
	level.var_60FF = loadfx("vfx/map/mp_hub/watermelon_death");
	level.melonmodel = "Hub_range_watermelon_01";
	level.var_AA65 = loadfx("vfx/map/mp_hub/hub_impact_wooden_human_target_sml");
	level.var_AA66 = loadfx("vfx/map/mp_hub/hub_impact_wooden_human_target_exp");
	if(getdvarint("986",0) == 0)
	{
		level.var_94F1 = loadfx("vfx/unique/vfx_supplydrop_indicator_go");
		level.var_94F2 = loadfx("vfx/unique/vfx_supplydrop_indicator_stop");
		level.var_4B12 = loadfx("vfx/map/mp_hub/hub_firingrange_hard_reward");
		level.is_arm_or_head_damage = loadfx("vfx/map/mp_hub/hub_firingrange_medium_reward");
		precacheturret("sentry_supplydrop_mp");
	}
}

//Function Number: 2
func_8636(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		foreach(var_04 in param_02)
		{
			if(isdefined(var_04))
			{
				self endon(var_04);
			}
		}
	}

	wait(param_00);
	if(isdefined(self))
	{
		self notify(param_01);
	}
}

//Function Number: 3
func_7471(param_00)
{
	var_01 = self;
	if(isdefined(var_01.var_537A) && var_01.var_537A == 1)
	{
		return;
	}

	var_01 notify("virtualLobbyActive");
	if(level.var_A220)
	{
	}
	else
	{
		if(!isdefined(var_01.var_1E99) && isdefined(param_00))
		{
			var_02 = getent(param_00,"targetname");
			var_03 = var_02.var_116;
			var_04 = var_02.var_1D;
			var_05 = spawn("script_model",var_03);
			var_05.var_1D = var_04;
			var_05 setmodel("tag_player");
			var_05.var_92F0 = var_03;
			var_05.var_92B8 = var_04;
			var_05.var_8066 = (0,0,0);
			var_05.var_9815 = var_01;
			var_01.var_1E99 = var_05;
			var_05.var_721C = var_01;
			var_05.var_1A5 = "camera2player";
		}

		var_01 method_81E2(var_01.var_1E99,"tag_player");
	}

	var_01.var_537A = 1;
	var_01.var_C7 = 1;
	var_01 allowlook(0);
	var_01 func_870B(1);
}

//Function Number: 4
func_7472()
{
	if(isdefined(self.var_537A) && self.var_537A == 0)
	{
		return;
	}

	self setclientdvar("3078","1");
	self.var_537A = 0;
	self.var_C7 = 0;
	self allowlook(1);
	if(!level.var_A220)
	{
		self method_81E3();
		self setangles(self.var_8068);
	}
	else
	{
	}

	var_00 = [self.var_5721,self.var_5692,self.var_572A,self.var_572F];
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02))
		{
			var_02 = 0;
		}
	}

	func_870B(func_5790(1));
	if(!self.var_5721 && !self.var_5692 && !self.var_572A && !self.var_572F && !self.var_5722)
	{
		func_7446();
		return;
	}

	if(self.var_5721)
	{
		maps\mp\gametypes\_hub_range::func_37BD();
		return;
	}

	if(self.var_572F)
	{
		maps\mp\_utility::func_642(self.var_8B27);
		self switchtoweaponimmediate(self.var_8B27);
		return;
	}
}

//Function Number: 5
func_7446()
{
	self takeallweapons();
	self.gator_light = "none";
	self.primarypaintjobid = 0;
	self.primarycharmguid = 0;
	self.var_835C = "none";
	self.secondarypaintjobid = 0;
	self.secondarycharmguid = 0;
	self.var_60FB = "none";
	maps\mp\_utility::func_642("emote_weapon_mp");
	self switchtoweaponimmediate("emote_weapon_mp");
	self method_85B6();
	self method_812B(0);
	self method_812A(0);
	self method_85BE(0);
	self method_85BF(0);
	self method_8326();
	maps\mp\_utility::func_5E4();
	maps\mp\_utility::func_47A2("specialty_marathon");
	maps\mp\_utility::func_47A2("specialty_falldamage");
}

//Function Number: 6
func_73E5(param_00)
{
	if(isdefined(param_00) && param_00 == 1)
	{
		var_01 = spawn("script_origin",(0,0,0));
		self.var_2608 = var_01;
		self method_8200(var_01);
		return;
	}

	if(isdefined(self.var_2608))
	{
		self method_8201();
		self.var_2608 delete();
	}
}

//Function Number: 7
func_7DF8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self allowmovement(param_00);
	self method_8309(param_01);
	self allowads(param_02);
	self method_8113(0);
	self method_8308(0);
	self method_8307(0);
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self allowjump(param_05);
	if(isdefined(param_03))
	{
		self setclientomnvar("ui_hub_enable_pause",param_03);
	}

	if(isdefined(param_04))
	{
		self allowlook(param_04);
	}
}

//Function Number: 8
func_A04C()
{
	self allowmovement(1);
	self method_8309(1);
	self allowads(1);
	self method_8113(1);
	self method_8308(1);
	self method_8307(1);
	self allowjump(1);
	self allowlook(1);
	if(self getclientomnvar("ui_hub_enable_pause") == 0)
	{
		self setclientomnvar("ui_hub_enable_pause",1);
	}
}

//Function Number: 9
func_63EA()
{
}

//Function Number: 10
func_721A(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(param_00 == "mp_emote_superhero_landing")
	{
		var_02 = getentarray("invalid_psd_area","targetname");
		if(isdefined(var_02))
		{
			foreach(var_04 in var_02)
			{
				if(self istouching(var_04) && self.var_116[2] < 300)
				{
					self iclientprintln(&"HUB_DONT_BE_A_HERO");
					return 0;
				}
			}
		}
	}

	if(!isdefined(param_01) || !param_01)
	{
		var_06 = self.var_116;
		wait 0.05;
		if(self.var_116 != var_06 && lengthsquared(self method_81AD()) >= 25)
		{
			return 0;
		}
	}

	if(!isdefined(self.var_99FD))
	{
		return 0;
	}

	if(self.var_56A4)
	{
		if(isdefined(self.var_155F))
		{
			self.var_155F func_1543((0,0,0),self);
		}
	}

	var_07 = tablelookup("mp/animOverrideTable.csv",0,param_00,1);
	var_08 = tablelookup("mp/animOverrideTable.csv",0,param_00,3);
	var_09 = 0;
	var_0A = 0;
	var_0B = 3;
	if(isdefined(var_07) && var_07 != "")
	{
		var_0B = int(var_07);
	}

	if(var_0B == 2)
	{
		var_0C = self getplayerscurrentanimname(1);
		if(common_scripts\utility::func_9467(var_0C,"mp_emote_"))
		{
			return 0;
		}

		if(var_08 == "")
		{
			if(var_09 || var_0C != param_00)
			{
				self setanimoverride(1,param_00);
				self method_85B3(1,0);
				var_0A = 1;
			}
		}
		else if(var_09 || var_0C != param_00 && var_0C != var_08)
		{
			self setanimoverride(2,param_00);
			self setanimoverride(3,var_08);
			self method_85B3(1,0);
			var_0A = 1;
		}
	}
	else
	{
		var_0C = self getplayerscurrentanimname(0);
		if(common_scripts\utility::func_9467(var_0C,"mp_emote_"))
		{
			return 0;
		}

		var_0D = tablelookup("mp/animOverrideTable.csv",0,var_0C,4);
		if(isdefined(var_0D) && var_0D != "" && var_0C != param_00)
		{
			self setanimoverride(4,var_0D);
			self setanimoverride(5,param_00);
			self method_85B3(0,1);
			var_0A = 1;
		}
		else if(var_08 == "")
		{
			if(var_09 || var_0C != param_00)
			{
				self setanimoverride(0,param_00);
				self method_85B3(0,0);
				var_0A = 1;
			}
		}
		else if(var_09 || var_0C != param_00 && var_0C != var_08)
		{
			self setanimoverride(4,param_00);
			self setanimoverride(5,var_08);
			self method_85B3(0,1);
			var_0A = 1;
		}
	}

	if(var_0A)
	{
		var_0E = function_01AF("mp/animOverrideTable.csv",0,param_00,2);
		if(isdefined(var_0E) && var_0E != &"")
		{
			if(getsystemtime() - self.var_99FD > 2.5)
			{
				self.var_99FD = getsystemtime();
				var_0F = func_459B(160);
				foreach(var_11 in var_0F)
				{
					if(var_11.var_1A7 != self.var_1A7 || var_11.var_572A)
					{
						continue;
					}

					var_11 iclientprintln(&"HUB_EMOTE_CHAT_SYNTAX",self.var_109,var_0E);
				}
			}
		}
	}

	return 1;
}

//Function Number: 11
func_459B(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		if(maps\mp\_utility::func_57A0(var_04))
		{
			if(!isdefined(param_01) || isdefined(param_01) && var_04.var_5721 || var_04.var_572F)
			{
				if(common_scripts\utility::func_302B(self.var_116,var_04.var_116) < squared(param_00))
				{
					var_02 = common_scripts\utility::func_972(var_02,var_04);
				}
			}
		}
	}

	return var_02;
}

//Function Number: 12
func_63C0()
{
	self endon("disconnect");
	var_00 = getdvar("hub_emote");
	for(;;)
	{
		if(maps\mp\_utility::func_57A0(self) && var_00 != getdvar("hub_emote"))
		{
			var_00 = getdvar("hub_emote");
			func_721A(var_00);
			thread maps\mp\gametypes\_hud_util::func_3005("Current emote: " + var_00,-100,1,"hideCurrentEmoteStatus");
			wait(1);
			self notify("hideCurrentEmoteStatus");
		}

		wait 0.05;
	}
}

//Function Number: 13
func_637C()
{
	self endon("disconnect");
	var_00 = getdvarint("hub_setThirdPerson");
	for(;;)
	{
		if(maps\mp\_utility::func_57A0(self) && var_00 != getdvarint("hub_setThirdPerson"))
		{
			var_00 = getdvarint("hub_setThirdPerson");
			if(var_00 == 1)
			{
				self method_85C7();
			}
			else
			{
				self method_85C8();
			}

			wait(1);
		}

		wait 0.05;
	}
}

//Function Number: 14
func_639E()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		if(!self isonground())
		{
			var_00 = self.var_116[2];
			while(!self isonground() && isalive(self))
			{
				if(self.var_116[2] > var_00)
				{
					var_00 = self.var_116[2];
				}

				wait 0.05;
			}

			var_01 = var_00 - self.var_116[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			var_02 = int(var_01 / 12);
			var_03 = maps\mp\gametypes\_hud_util::func_2097("ch_hq_falls");
			if(var_02 > var_03 && isalive(self))
			{
				maps\mp\gametypes\_missions::func_7750("ch_hq_falls",var_02,1);
			}
		}

		wait 0.05;
	}
}

//Function Number: 15
func_4834(param_00,param_01)
{
	var_02 = [];
	var_02["division"] = maps\mp\gametypes\_class::func_1E02(param_01);
	var_02["primaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_1E0A(param_01,0),0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		var_02["primaryAttachmentsGUID"][var_03] = maps\mp\gametypes\_class::func_1E0B(param_01,0,var_03);
	}

	var_02["primaryCamoGUID"] = maps\mp\gametypes\_class::func_1E0C(param_01,0);
	var_02["primaryCamo2GUID"] = maps\mp\gametypes\_class::func_1E0D(param_01,0);
	var_02["primaryReticleGUID"] = maps\mp\gametypes\_class::func_1E0F(param_01,0);
	var_02["primaryCustomization"] = maps\mp\gametypes\_class::func_1E0E(param_01,0);
	var_02["primaryPaintjobId"] = maps\mp\gametypes\_class::cac_getweaponpaintjob(param_01,0);
	var_02["primaryCharmGUID"] = maps\mp\gametypes\_class::cac_getweaponcharm(param_01,0);
	var_02["secondaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_1E0A(param_01,1),0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		var_02["secondaryAttachmentsGUID"][var_03] = maps\mp\gametypes\_class::func_1E0B(param_01,1,var_03);
	}

	var_02["secondaryCamoGUID"] = maps\mp\gametypes\_class::func_1E0C(param_01,1);
	var_02["secondaryCamo2GUID"] = maps\mp\gametypes\_class::func_1E0D(param_01,1);
	var_02["secondaryReticleGUID"] = maps\mp\gametypes\_class::func_1E0F(param_01,1);
	var_02["secondaryCustomization"] = maps\mp\gametypes\_class::func_1E0E(param_01,1);
	var_02["secondaryPaintjobId"] = maps\mp\gametypes\_class::cac_getweaponpaintjob(param_01,1);
	var_02["secondaryCharmGUID"] = maps\mp\gametypes\_class::cac_getweaponcharm(param_01,1);
	var_02["meleeWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_1E07(),0);
	var_02["equipmentStruct"] = maps\mp\_utility::func_44CE(maps\mp\gametypes\_class::func_1E03(param_01,0),0);
	var_02["offhandStruct"] = maps\mp\_utility::func_44CE(maps\mp\gametypes\_class::func_1E03(param_01,1),0);
	for(var_03 = 0;var_03 < 9;var_03++)
	{
		var_02["perkGUID" + var_03] = maps\mp\gametypes\_class::func_1E09(param_01,var_03);
	}

	return var_02;
}

//Function Number: 16
func_9C8C(param_00)
{
	var_01 = [];
	var_01["division"] = param_00.var_79;
	var_01["primaryWeaponStruct"] = param_00.var_7709;
	var_01["secondaryWeaponStruct"] = param_00.var_835D;
	var_01["meleeWeaponStruct"] = param_00.var_60FC;
	var_01["equipmentStruct"] = param_00.var_37FE;
	var_01["offhandStruct"] = param_00.var_69AD;
	var_01["primaryAttachmentsGUID"] = [];
	var_01["secondaryAttachmentsGUID"] = [];
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		var_01["primaryAttachmentsGUID"][var_02] = param_00.var_76F3[var_02];
		var_01["secondaryAttachmentsGUID"][var_02] = param_00.var_8353[var_02];
	}

	var_01["primaryCustomization"] = param_00.var_144;
	var_01["secondaryCustomization"] = param_00.var_176;
	var_01["primaryCamoGUID"] = param_00.var_76F5;
	var_01["secondaryCamoGUID"] = param_00.var_8355;
	var_01["primaryCamo2GUID"] = param_00.var_76F4;
	var_01["secondaryCamo2GUID"] = param_00.var_8354;
	var_01["primaryReticleGUID"] = param_00.var_7700;
	var_01["primaryCustomization"] = param_00.var_144;
	var_01["primaryPaintjobId"] = param_00.primarypaintjobid;
	var_01["primaryCharmGUID"] = param_00.primarycharmguid;
	var_01["secondaryReticleGUID"] = param_00.var_8359;
	var_01["secondaryCustomization"] = param_00.var_176;
	var_01["secondaryPaintjobId"] = param_00.secondarypaintjobid;
	var_01["secondaryCharmGUID"] = param_00.secondarycharmguid;
	for(var_02 = 0;var_02 < 9;var_02++)
	{
		var_01["perkGUID" + var_02] = param_00.var_6F69[var_02];
	}

	return var_01;
}

//Function Number: 17
func_4618()
{
	var_00 = maps\mp\_utility::func_1E01();
	if(!isdefined(self.var_294D))
	{
		self.var_294D = maps\mp\gametypes\_class::func_1E05();
	}

	if(level.var_4F50 && isdefined(self.var_9FB3))
	{
		self.var_294D = self.var_9FB3;
	}

	var_01 = maps\mp\_utility::func_445D("lobby" + self.var_294D + 1);
	if(level.var_A220)
	{
		if(isdefined(self.var_A597))
		{
			var_02 = func_9C8C(self.var_A597);
		}
		else
		{
			var_02 = func_4834(var_01,var_02);
		}
	}
	else
	{
		var_02 = self.var_5E01[var_01][var_02];
	}

	self.var_79 = var_02["division"];
	var_03 = var_02["primaryWeaponStruct"];
	var_04 = var_02["secondaryWeaponStruct"];
	var_05 = var_02["meleeWeaponStruct"];
	var_06 = var_02["equipmentStruct"];
	var_07 = var_02["offhandStruct"];
	var_08 = var_02["perkGUID3"];
	var_09 = 0;
	var_0A = var_08 == 73400412;
	var_0B = maps\mp\_utility::func_4431(maps\mp\_utility::func_4737(var_04));
	if(maps\mp\_utility::func_5856(var_0B))
	{
		var_0B = maps\mp\gametypes\_class::func_4432(var_0B);
	}

	if(maps\mp\_utility::func_472A(var_0B) == "weapon_pistol")
	{
		if(var_0A)
		{
			switch(var_0B)
			{
				case "enfieldno2_mp":
				case "reich_mp":
				case "p38_mp":
				case "luger_mp":
				case "m1911_mp":
					var_09 = 50332864;
					break;

				case "m712_mp":
					var_09 = 50333920;
					break;

				default:
					break;
			}

			for(var_0C = 0;var_0C < var_02["secondaryAttachmentsGUID"].size;var_0C++)
			{
				if(var_02["secondaryAttachmentsGUID"][var_0C] == 50338160)
				{
					var_02["secondaryAttachmentsGUID"][var_0C] = 0;
				}
			}
		}
	}
	else
	{
	}

	if(isdefined(var_03) && isdefined(var_03.var_48CA) && var_03.var_48CA != 0)
	{
		var_0F = maps\mp\_utility::func_4737(var_03);
		self.gator_light = maps\mp\gametypes\_class::func_1D66(var_0F,var_02["primaryAttachmentsGUID"][0],var_02["primaryAttachmentsGUID"][1],var_02["primaryAttachmentsGUID"][2],var_02["primaryAttachmentsGUID"][3],var_02["primaryAttachmentsGUID"][4],var_02["primaryAttachmentsGUID"][5],maps\mp\_utility::func_472D(var_03),var_02["primaryCamoGUID"],var_02["primaryCamo2GUID"],var_02["primaryReticleGUID"],var_02["primaryCustomization"],self,self.var_79);
		self.primarypaintjobid = var_02["primaryPaintjobId"];
		self.primarycharmguid = var_02["primaryCharmGUID"];
	}

	if(isdefined(var_04) && isdefined(var_04.var_48CA) && var_04.var_48CA != 0)
	{
		var_0F = maps\mp\_utility::func_4737(var_04);
		self.var_835C = maps\mp\gametypes\_class::func_1D66(var_0F,var_02["secondaryAttachmentsGUID"][0],var_02["secondaryAttachmentsGUID"][1],var_02["secondaryAttachmentsGUID"][2],var_02["secondaryAttachmentsGUID"][3],var_02["secondaryAttachmentsGUID"][4],var_09,maps\mp\_utility::func_472D(var_04),var_02["secondaryCamoGUID"],var_02["secondaryCamo2GUID"],var_02["secondaryReticleGUID"],var_02["secondaryCustomization"],self,self.var_79);
		self.secondarypaintjobid = var_02["secondaryPaintjobId"];
		self.secondarycharmguid = var_02["secondaryCharmGUID"];
	}

	if(isdefined(var_06) && isdefined(var_06.var_48CA) && var_06.var_48CA != 0)
	{
		self.var_37FC = maps\mp\_utility::func_4737(var_06);
	}

	if(isdefined(var_07) && isdefined(var_07.var_48CA) && var_07.var_48CA != 0)
	{
		self.var_69AB = maps\mp\_utility::func_4737(var_07);
	}

	self.var_5DF9 = [];
	for(var_0C = 0;var_0C < 9;var_0C++)
	{
		self.var_5DF9[var_0C] = var_02["perkGUID" + var_0C];
	}
}

//Function Number: 18
func_478C()
{
	var_00 = common_scripts\utility::func_46AF();
	var_01 = self getrankedplayerdata(var_00,"meleeWeapon","weapon");
	var_02 = maps\mp\_utility::func_452B(var_01);
	if(function_01A9(var_02) != "melee")
	{
		var_02 = "combatknife_mp";
	}

	maps\mp\_utility::func_642(var_02);
}

//Function Number: 19
func_115E()
{
	if(isdefined(self.var_2FAC) && self.var_2FAC)
	{
		return;
	}

	var_00 = maps\mp\_utility::func_1E01();
	var_01 = maps\mp\gametypes\_class::func_1E05();
	if(level.var_4F50 && isdefined(self.var_9FB3))
	{
		var_01 = self.var_9FB3;
	}

	var_02 = maps\mp\_utility::func_445D("lobby" + var_01 + 1);
	if(level.var_A220)
	{
		if(isdefined(self.var_A597))
		{
			var_03 = func_9C8C(self.var_A597);
		}
		else
		{
			var_03 = func_4834(var_01,var_03);
		}
	}
	else
	{
		var_03 = self.var_5E01[var_01][var_03];
	}

	var_04 = var_03["division"];
	var_05 = var_03["primaryWeaponStruct"];
	var_06 = undefined;
	if(isdefined(var_05) && isdefined(var_05.var_48CA) && var_05.var_48CA != 0)
	{
		var_07 = maps\mp\_utility::func_4737(var_05);
		var_06 = maps\mp\gametypes\_class::func_1D66(var_07,var_03["primaryAttachmentsGUID"][0],var_03["primaryAttachmentsGUID"][1],var_03["primaryAttachmentsGUID"][2],var_03["primaryAttachmentsGUID"][3],var_03["primaryAttachmentsGUID"][4],var_03["primaryAttachmentsGUID"][5],maps\mp\_utility::func_472D(var_05),var_03["primaryCamoGUID"],var_03["primaryCamo2GUID"],var_03["primaryReticleGUID"],var_03["primaryCustomization"],self,var_04);
	}

	if(isdefined(var_06) && maps\mp\_utility::func_472A(var_06) != "weapon_other" && var_06 != "riotshield_mp")
	{
		var_08 = 0;
		if(isdefined(var_03["primaryPaintjobId"]))
		{
			var_08 = var_03["primaryPaintjobId"];
		}

		self setstowedweapon(func_2164(var_06),var_08);
		return;
	}

	if(isdefined(var_06) && var_06 == "riotshield_mp")
	{
		self setstowedweapon("none",0);
	}
}

//Function Number: 20
func_2164(param_00)
{
	if(isdefined(self.var_12C["altModeActive"]) && isdefined(self.var_79) && !self.var_12C["altModeActive"] && self.var_79 != 5 && maps\mp\_utility::func_472A(param_00) == "weapon_smg" && issubstr(param_00,"suppressor"))
	{
		param_00 = maps\mp\gametypes\_division_change::func_7CCD(param_00);
	}

	return param_00;
}

//Function Number: 21
func_3663()
{
	self.var_2FAC = undefined;
	func_115E();
}

//Function Number: 22
func_2FA2()
{
	self.var_2FAC = 1;
	self clearstowedweapon();
}

//Function Number: 23
func_2811(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\mp\gametypes\_hud_util::func_27ED("mphubfont",param_03);
	if(isarray(param_02))
	{
		var_05 maps\mp\gametypes\_hud_util::func_8707(param_04,param_04,param_02[0],param_02[1]);
	}
	else
	{
		var_05 maps\mp\gametypes\_hud_util::func_8707(param_04,param_04,0,param_02);
	}

	var_05.ignoreme = 1001;
	var_05.var_56 = (1,1,1);
	var_05.var_18 = 0.8;
	var_05.var_A0 = 0;
	var_05.var_C2 = 1;
	var_05.var_E5 = param_01;
	var_05.var_109 = param_00;
	var_05.var_17A = 0;
	if(!isdefined(self.var_308C))
	{
		self.var_308C = [];
		thread func_2386();
	}

	if(isdefined(self.var_308C[param_00]))
	{
		func_2DD2(param_00);
	}

	self.var_308C[param_00] = var_05;
	return var_05;
}

//Function Number: 24
func_3010(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_2811(param_00,param_01,param_03,param_04,"CENTER");
	if(isstring(param_02))
	{
		var_06 settext(param_02);
	}
	else if(function_02A2(param_02))
	{
		var_06 setvalue(param_02);
	}
	else if(isplayer(param_02))
	{
		var_06 setplayernamestring(param_02);
	}
	else if(!isdefined(param_02))
	{
	}
	else
	{
		func_2DD2(param_00);
		return;
	}

	if(isdefined(param_05))
	{
		wait(param_05);
		if(isdefined(self.var_308C[param_00]))
		{
			func_2DD2(param_00);
			return;
		}

		return;
	}

	return var_06;
}

//Function Number: 25
func_2835(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_308C) && isdefined(self.var_308C[param_00]))
	{
		func_A12B(param_00,param_02);
		return;
	}

	return func_3010(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 26
func_A12B(param_00,param_01)
{
	var_02 = self.var_308C[param_00];
	if(!isdefined(var_02))
	{
		return;
	}

	if(isstring(param_01))
	{
		var_02 settext(param_01);
		return;
	}

	if(function_02A2(param_01))
	{
		var_02 setvalue(param_01);
		return;
	}

	if(isplayer(param_01))
	{
		var_02 setplayernamestring(param_01);
		return;
	}
}

//Function Number: 27
func_454D(param_00)
{
	if(isdefined(self.var_308C))
	{
		return self.var_308C[param_00];
	}

	return undefined;
}

//Function Number: 28
func_2DD2(param_00)
{
	var_01 = self.var_308C[param_00];
	var_01 destroy();
	self.var_308C[param_00] = undefined;
}

//Function Number: 29
func_2386(param_00)
{
	if(!isdefined(param_00) || !param_00)
	{
		common_scripts\utility::knock_off_battery("disconnect","death");
	}

	if(isdefined(self.var_308C))
	{
		foreach(var_03, var_02 in self.var_308C)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			self.var_308C[var_03] = undefined;
			var_02 destroy();
		}
	}
}

//Function Number: 30
func_4F3B(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	self fadeovertime(param_00);
	self.var_18 = param_02;
}

//Function Number: 31
func_4F3C(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	self fadeovertime(param_00);
	self.var_18 = param_02;
}

//Function Number: 32
func_7889(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 waittill(param_02);
	param_00 scriptmodelplayanim(param_01);
	param_00.var_74B8 = 0;
	param_00.var_74B7 = 0;
}

//Function Number: 33
func_788A(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_00 waittill(param_02);
	param_00 method_8495(param_01,param_03.var_116,param_03.var_1D);
}

//Function Number: 34
func_A13F()
{
	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01))
		{
			var_01 func_2835("numPlayers",&"HUB_SOLDIERS_IN_HUB",level.var_744A.size,[-370,-220],1);
		}
	}
}

//Function Number: 35
func_238C()
{
	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01))
		{
			var_01 func_2DD2("numPlayers");
		}
	}
}

//Function Number: 36
func_5790(param_00)
{
	if(isdefined(self.var_572A) && self.var_572A)
	{
		return 1;
	}
	else if(isdefined(self.var_5692) && self.var_5692)
	{
		return 1;
	}
	else if(isdefined(self.var_572B) && self.var_572B)
	{
		return 1;
	}
	else if(isdefined(self.var_4B84) && self.var_4B84)
	{
		return 1;
	}
	else if(isdefined(self.var_5733) && self.var_5733)
	{
		return 1;
	}
	else if(isdefined(self.var_537A) && !maps\mp\_utility::func_57A0(self))
	{
		return 1;
	}
	else if(isdefined(self.var_5722) && self.var_5722)
	{
		return 1;
	}
	else if(isdefined(self.var_584B) && self.var_584B)
	{
		return 1;
	}
	else if(isdefined(self.var_5791) && self.var_5791)
	{
		return 1;
	}
	else if(isdefined(self.var_537A) && self.var_537A)
	{
		return 1;
	}
	else if(isdefined(self.var_572F) && self.var_572F)
	{
		return 1;
	}
	else if(isdefined(self.var_57E0) && self.var_57E0)
	{
		return 1;
	}
	else if(isdefined(self.var_56AD) && self.var_56AD)
	{
		return 1;
	}
	else if(self playerisweaponplantenabled())
	{
		return 1;
	}
	else if(isdefined(self.isintimertag) && self.isintimertag)
	{
		return 1;
	}

	if(!isdefined(param_00) || param_00)
	{
		if(isdefined(self.var_5721) && self.var_5721)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 37
func_870B(param_00)
{
	if(isdefined(self.var_56AD) && self.var_56AD && param_00 == 0)
	{
		return;
	}

	self setclientomnvar("ui_hub_is_preoccupied",param_00);
}

//Function Number: 38
func_6010(param_00,param_01)
{
	param_00.var_4E03 = common_scripts\utility::func_972(param_00.var_4E03,param_01);
}

//Function Number: 39
func_A03C(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		param_00.var_4E03 = common_scripts\utility::func_F98(param_01,param_00.var_4E03);
		return;
	}

	if(isdefined(param_00))
	{
		param_00.var_4E03 = common_scripts\utility::func_FA0(param_00.var_4E03);
	}
}

//Function Number: 40
func_4F44(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = 1.5;
	var_02 = 0.6;
	var_03 = 2;
	while(!isdefined(self.var_ACA4))
	{
		wait 0.05;
	}

	self.var_56C8 = 1;
	self.var_ACA4.var_18 = 0;
	self.var_162C.var_18 = 0;
	self.var_ACA4.var_E5 = func_474C(self.var_295A);
	self.var_ACA4 thread func_4F3B(var_01,self,1);
	self.var_162C thread func_4F3B(var_01,self,1);
	wait(var_01);
	wait(var_03);
	self.var_ACA4 thread func_4F3C(var_02,self,0);
	self.var_162C thread func_4F3C(var_02,self,0);
	wait(var_02);
	self.var_56C8 = 0;
}

//Function Number: 41
func_474C(param_00)
{
	switch(param_00)
	{
		case "hq_zone_trigger":
			return &"HUB_ZONE_HEADQUARTERS";

		case "spawn_zone_trigger":
			return &"HUB_ZONE_SPAWN";

		case "beach_zone_trigger":
			return &"HUB_ZONE_BEACH";

		case "theatre_zone_trigger":
			return &"HUB_ZONE_THEATRE";

		case "firingrange_zone_trigger":
			return &"HUB_ZONE_FIRINGRANGE";

		case "offTower_zone_trigger":
			return &"HUB_ZONE_OFFTOWER";

		case "":
			return "something broke";
	}
}

//Function Number: 42
func_77B4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self notify("pulseDurationEnded");
	self endon("pulseDurationEnded");
	param_05 endon("death");
	param_05 endon("disconnect");
	if(isdefined(param_04))
	{
		thread func_8636(param_04,"pulseDurationEnded",undefined);
	}

	self.var_5798 = 1;
	while(isdefined(self))
	{
		if(isdefined(self))
		{
			func_4F3B(param_00,param_05,param_06);
		}

		wait(param_00);
		wait(param_02);
		if(isdefined(self))
		{
			func_4F3C(param_01,param_05,param_07);
		}

		wait(param_01);
		wait(param_03);
	}
}

//Function Number: 43
func_532E()
{
	if(getdvar("1459") != "")
	{
		return;
	}

	wait(1);
	setdvarifuninitialized("spv_hub_ball_kswitch",0);
	level.var_1564[0] = common_scripts\utility::func_46B5("ball_spawn_point_1","targetname");
	level.var_1564[1] = common_scripts\utility::func_46B5("ball_spawn_point_2","targetname");
	level.var_1564[2] = common_scripts\utility::func_46B5("ball_spawn_point_3","targetname");
	for(var_00 = 0;var_00 < level.var_1564.size;var_00++)
	{
		level.var_1564[var_00] thread func_1553();
	}
}

//Function Number: 44
func_1553()
{
	for(;;)
	{
		if(getdvarint("spv_hub_ball_kswitch",0) == 1)
		{
			return;
		}

		var_00 = spawn("script_model",self.var_116);
		if(self.var_116 == level.var_1564[0].var_116)
		{
			var_00 setmodel("npc_soccer_ball_02");
		}
		else if(self.var_116 == level.var_1564[2].var_116)
		{
			var_00 setmodel("npc_soccer_ball_04");
		}
		else
		{
			var_00 setmodel("npc_soccer_ball_03");
		}

		var_00 method_805B();
		var_00 thread func_6FA2();
		var_01 = 24;
		var_02 = spawn("trigger_radius",var_00.var_116 - (0,0,var_01 / 2),0,var_01,var_01);
		var_02 enablelinkto();
		var_02 linkto(var_00);
		var_02.var_66F0 = 1;
		var_03 = [var_00];
		var_04 = maps\mp\gametypes\_gameobjects::func_27D6("any",var_02,var_03,(0,0,32),0,0,1);
		var_04 maps\mp\gametypes\_gameobjects::func_C1D("any");
		var_04 maps\mp\gametypes\_gameobjects::func_8A60("any");
		var_04.var_698F = 0;
		var_04.var_6993 = 1;
		var_04.var_C33 = 0;
		var_04.var_201C = "hub_ball_mp";
		var_04.var_59D8 = 1;
		var_04.var_A965 = 0;
		var_04.var_A581 = (0,0,30);
		var_04.var_1F84 = ::func_150E;
		var_04.var_6B62 = ::func_1535;
		var_04.var_866E = ::func_1550;
		var_04.var_201D = ::func_1555;
		var_04.var_7D25 = 1;
		var_04.var_152D = self.var_81E1;
		maps\mp\_utility::func_68B(var_04.var_698A);
		maps\mp\_utility::func_68B(var_04.var_698B);
		maps\mp\_utility::func_68B(var_04.var_698C);
		var_04.var_2562 = undefined;
		var_04.var_2561 = undefined;
		var_04.var_698A = undefined;
		var_04.var_698B = undefined;
		var_04.var_698C = undefined;
		var_04 thread monitorballkswitch();
		for(;;)
		{
			var_02 waittill("trigger",var_05);
			if(isplayer(var_05))
			{
				if(!var_05.var_56A4 && !isdefined(var_05.var_155F))
				{
					break;
				}
			}
		}

		wait(120);
	}
}

//Function Number: 45
monitorballkswitch()
{
	level endon("game_ended");
	self endon("death");
	self endon("deleted");
	while(getdvarint("spv_hub_ball_kswitch",0) == 0)
	{
		wait(1);
	}

	maps\mp\gametypes\_gameobjects::func_23DA();
	maps\mp\gametypes\_gameobjects::func_2D2F();
}

//Function Number: 46
func_150E(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(self.var_34B1) && self.var_34B1 >= gettime())
	{
		return 0;
	}

	if(isbot(param_00) || function_01EF(param_00))
	{
		return 0;
	}

	if(param_00 func_72F0())
	{
		return 0;
	}

	if(param_00 func_5790())
	{
		return 0;
	}

	var_01 = param_00 getplayerscurrentanimname(1);
	if(common_scripts\utility::func_9467(var_01,"mp_emote_"))
	{
		return 0;
	}

	var_01 = param_00 getplayerscurrentanimname(0);
	if(common_scripts\utility::func_9467(var_01,"mp_emote_"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 47
func_1535(param_00)
{
	self notify("pickup_object");
	var_01 = self.var_A582[0] getlinkedparent();
	if(isdefined(var_01))
	{
		self.var_A582[0] unlink();
	}

	self.var_A582[0] method_84E0();
	self.var_A582[0] method_805B();
	self.var_A582[0] method_8511();
	param_00 method_82FA("hub_ball_mp",1);
	param_00 method_8617("grid_ball_pickup");
	param_00 maps\mp\_utility::func_47A2("specialty_ballcarrier");
	param_00 method_812B(1);
	param_00.var_56A4 = 1;
	param_00.var_155F = self;
	if(isdefined(self.var_152D))
	{
		param_00 thread maps\mp\gametypes\_missions::func_7750("ch_hq_data_ball" + self.var_152D);
		var_02 = param_00 maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_ball1");
		var_03 = param_00 maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_ball2");
		var_04 = param_00 maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_ball3");
		var_05 = var_02 + var_03 + var_04;
		param_00 thread maps\mp\gametypes\_missions::func_7750("ch_hq_balls",var_05,1);
	}

	param_00 common_scripts\utility::func_601();
}

//Function Number: 48
func_1550(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.var_57A6 = 1;
	self.var_34B1 = gettime();
	self notify("dropped");
	var_01 = self.var_2006;
	if(isdefined(var_01) && var_01.var_1A7 != "spectator")
	{
		var_02 = var_01 gettagorigin("TAG_ACCESSORY_RIGHT");
	}
	else
	{
		var_02 = self.var_802F;
	}

	var_03 = (0,0,0);
	for(var_04 = 0;var_04 < self.var_A582.size;var_04++)
	{
		self.var_A582[var_04].var_116 = var_02;
		self.var_A582[var_04].var_1D = var_03;
		self.var_A582[var_04] method_805B();
	}

	self.var_9D65.var_116 = var_02;
	func_151D();
	self.var_28D4 = self.var_9D65.var_116;
	func_1511();
	maps\mp\gametypes\_gameobjects::func_23DA();
	self.var_57A6 = 0;
	if(!param_00)
	{
		func_1542((0,0,80));
	}

	thread func_1533();
	return 1;
}

//Function Number: 49
func_151D()
{
	self.var_A582[0] method_808C();
	self.var_1521 = 0;
}

//Function Number: 50
func_1511()
{
	if(isdefined(self.var_2006))
	{
		var_00 = self.var_2006;
		var_00.var_6735 = gettime() + 500;
		var_00 common_scripts\utility::func_615();
		var_00.var_56A4 = 0;
		var_00.var_155F = undefined;
		var_00 maps\mp\_utility::func_735("specialty_ballcarrier");
		var_00 method_812B(0);
		var_00 switchtoweaponimmediate("emote_weapon_mp");
	}
}

//Function Number: 51
func_1555()
{
	self endon("disconnect");
	thread func_1557();
	self.var_2016 waittill("dropped");
}

//Function Number: 52
func_1557()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	var_00 = getdvarfloat("scr_ball_shoot_extra_pitch",-12);
	var_01 = getdvarfloat("scr_ball_shoot_force",500);
	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 != "hub_ball_mp")
		{
			continue;
		}

		break;
	}

	if(isdefined(self.var_2016))
	{
		self method_85C9(1);
		wait(0.1);
		var_03 = self getangles();
		var_03 = var_03 + (var_00,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		self method_85C9(0);
		lib_0468::func_A27("passBall");
		self method_8617("grid_ball_throw");
		self.var_2016 thread func_1543(var_04 * var_01,self);
	}
}

//Function Number: 53
func_1556()
{
	self endon("death");
	self endon("disconnect");
	self.var_6EA7 = 1;
	self method_812A(0);
	while("hub_ball_mp" == self getcurrentweapon())
	{
		wait 0.05;
	}

	wait(1);
	self method_812A(1);
	self.var_6EA7 = 0;
}

//Function Number: 54
func_1543(param_00,param_01)
{
	func_1550(1);
	func_1542(param_00,param_01);
}

//Function Number: 55
func_1542(param_00,param_01)
{
	var_02 = self.var_A582[0];
	var_02.var_6C43 = undefined;
	var_02 physicslaunchserver(var_02.var_116 + (0.1,0,0.25),param_00);
	thread func_1546(param_01);
}

//Function Number: 56
func_1546(param_00)
{
	var_01 = self.var_A582[0];
	var_02 = self.var_9D65;
	var_01 endon("physics_finished");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isdefined(param_00) && param_00 == var_03 && var_03 func_72F0())
		{
			continue;
		}

		if(self.var_34B1 >= gettime())
		{
			continue;
		}

		if(var_01.var_116 == var_01.var_162D + (0,0,4000))
		{
			continue;
		}

		if(!func_150E(var_03))
		{
		}
	}
}

//Function Number: 57
func_6FA2()
{
	self endon("death");
	for(;;)
	{
		self waittill("physics_impact",var_00,var_01,var_02,var_03);
		var_04 = vectordot(var_02,var_01);
		if(var_04 > 0.5)
		{
			self method_8617("grid_ball_bounce");
		}

		wait(0.3);
	}
}

//Function Number: 58
func_72F0()
{
	return isdefined(self.var_6735) && self.var_6735 > gettime();
}

//Function Number: 59
func_1541()
{
	var_00 = self.var_A582[0];
	if(!var_00 method_8524())
	{
		return;
	}

	var_01 = var_00 method_841B();
	var_02 = length(var_01) / 10;
	var_03 = -1 * vectornormalize(var_01);
	var_00 method_84E0();
	var_00 physicslaunchserver(var_00.var_116,var_03 * var_02);
}

//Function Number: 60
ability_invulnerable()
{
	self.var_A582[0] method_808C();
	self.var_A582[0] method_84E0();
	self.var_A582[0].var_116 = (0,0,0);
}

//Function Number: 61
func_1533()
{
	self endon("death");
	self endon("deleted");
	thread func_8636(60,"ballIsInactive",["death","deleted","pickup_object"]);
	var_00 = common_scripts\utility::func_A715("ballIsInactive","pickup_object");
	if(var_00 == "ballIsInactive")
	{
		maps\mp\gametypes\_gameobjects::func_2D2F();
		return;
	}
}

//Function Number: 62
func_531B()
{
	self.var_746C = [];
	self.var_5711 = 0;
	self.var_5710 = 0;
}

//Function Number: 63
func_34DA()
{
	if(isdefined(level) && isdefined(level.var_744A))
	{
		foreach(var_01 in level.var_744A)
		{
		}
	}
}

//Function Number: 64
func_0F54(param_00,param_01)
{
	return !common_scripts\utility::func_F79(param_00.var_4E03,param_01);
}

//Function Number: 65
func_8BA6(param_00)
{
	return isdefined(self.var_5710) && !self.var_5710 || self.var_5711 && func_0F54(self,param_00);
}

//Function Number: 66
func_4D12(param_00)
{
	if(isdefined(self.var_746C) && common_scripts\utility::func_F79(self.var_746C,param_00))
	{
		self.var_746C = common_scripts\utility::func_F93(self.var_746C,param_00);
		self nametagvisibleto(self.var_746C);
	}
}

//Function Number: 67
func_8C0D(param_00)
{
	if(isdefined(self.var_746C) && !common_scripts\utility::func_F79(self.var_746C,param_00))
	{
		self.var_746C = common_scripts\utility::func_F6F(self.var_746C,param_00);
		self nametagvisibleto(self.var_746C);
	}
}

//Function Number: 68
func_8BEB()
{
	foreach(var_01 in level.var_744A)
	{
		if(var_01 == self)
		{
			continue;
		}

		var_01 func_8C0D(self);
	}

	self.var_5710 = 0;
	self.var_5711 = 0;
}

//Function Number: 69
func_8BFB()
{
	func_8BEB();
}

//Function Number: 70
func_4D02()
{
	self.var_5710 = 1;
	foreach(var_01 in level.var_744A)
	{
		if(var_01 == self)
		{
			continue;
		}

		var_01 func_4D12(self);
	}
}

//Function Number: 71
func_4D09()
{
	self.var_5711 = 1;
	foreach(var_01 in level.var_744A)
	{
		if(var_01 == self)
		{
			continue;
		}

		if(var_01 func_8BA6(self))
		{
			var_01 func_8C0D(self);
			continue;
		}

		var_01 func_4D12(self);
	}
}

//Function Number: 72
func_7B90()
{
	foreach(var_01 in level.var_744A)
	{
		if(var_01 == self)
		{
			continue;
		}

		if(isdefined(var_01))
		{
			if(func_8BA6(var_01))
			{
				var_01 func_8C0D(self);
			}
			else
			{
				var_01 func_4D12(self);
			}

			if(var_01 func_8BA6(self))
			{
				func_8C0D(var_01);
				continue;
			}

			func_4D12(var_01);
		}
	}
}

//Function Number: 73
func_1EB6(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0.5;
	var_06 = 0.5;
	if(var_05 + var_06 > param_02)
	{
		var_05 = param_02 * 0.4;
		var_06 = param_02 * 0.4;
	}

	var_07 = func_43F8();
	var_08 = self getangles();
	self freezecontrols(1);
	var_09 = spawn("script_model",var_07);
	var_09 setmodel("tag_player");
	var_09.var_1D = var_08;
	self method_81E2(var_09,"tag_player",250);
	wait(0.25);
	var_09 moveto(param_00,param_02,var_05,var_06);
	var_09 rotateto(vectortoangles(param_01 - param_00),param_02);
	wait(param_02);
	wait(param_03);
	var_09 moveto(var_07,param_04,var_05,var_06);
	var_09 rotateto(var_08,param_04);
	wait(param_04);
	self method_81E3(250);
	wait(0.25);
	var_09 delete();
	self freezecontrols(0);
}

//Function Number: 74
func_86A9(param_00)
{
	self setclientdvar("4990",param_00);
}

//Function Number: 75
func_43F8()
{
	var_00 = 512;
	var_01 = getdvarint("1586");
	var_02 = getdvarint("2766");
	var_03 = getdvarint("3711");
	var_04 = self getangles();
	var_05 = anglestoforward(var_04);
	var_06 = self getviewheight();
	var_07 = self.var_116;
	var_07 = (var_07[0],var_07[1],var_07[2] + var_06);
	var_08 = var_07 + var_00 * var_05;
	var_07 = (var_07[0],var_07[1],var_07[2] + 8);
	var_09 = var_04;
	var_09 = (0.5 * var_09[0],var_09[1] - var_01,var_09[2]);
	var_0A = anglestoaxis(var_09);
	var_07 = var_07 - var_02 * var_0A["forward"];
	var_07 = var_07 + var_03 * var_0A["right"];
	return var_07;
}

//Function Number: 76
func_636B()
{
	level endon("game_ended");
	level.var_2939 = 1;
	for(;;)
	{
		if(getdvarint("hub_cameraAdjustMode") == 1)
		{
			if(getdvarint("hub_cam_preset_1") == 1)
			{
				if(level.var_2939 != 1)
				{
					setdvar("2766",level.var_1728);
					setdvar("cg_fov",65);
					setdvar("3711",level.var_1727);
					setdvar("1586",364);
					setdvar("4505",0);
					level.var_2939 = 1;
				}
			}
			else if(getdvarint("hub_cam_preset_2") == 1)
			{
				if(level.var_2939 != 2)
				{
					setdvar("2766",57);
					setdvar("cg_fov",73);
					setdvar("3711",22);
					setdvar("1586",364);
					setdvar("4505",0);
					level.var_2939 = 2;
				}
			}
			else if(getdvarint("hub_cam_preset_3") == 1)
			{
				if(level.var_2939 != 3)
				{
					setdvar("2766",60);
					setdvar("cg_fov",72);
					setdvar("3711",18);
					setdvar("1586",364);
					setdvar("4505",0);
					level.var_2939 = 3;
				}
			}
			else if(getdvarint("hub_cam_preset_4") == 1)
			{
				if(level.var_2939 != 4)
				{
					setdvar("2766",89);
					setdvar("cg_fov",70);
					setdvar("3711",level.var_1727);
					setdvar("1586",360);
					setdvar("4505",-5);
					level.var_2939 = 4;
				}
			}
			else if(getdvarint("hub_cam_preset_5") == 1)
			{
				if(level.var_2939 != 5)
				{
					setdvar("2766",114);
					setdvar("cg_fov",75);
					setdvar("3711",20);
					setdvar("1586",-1);
					setdvar("4505",-5);
					level.var_2939 = 5;
				}
			}

			setdvar("hub_cam_preset_1",0);
			setdvar("hub_cam_preset_2",0);
			setdvar("hub_cam_preset_3",0);
			setdvar("hub_cam_preset_4",0);
			setdvar("hub_cam_preset_5",0);
		}

		wait 0.05;
	}
}

//Function Number: 77
func_2DD4(param_00)
{
	level endon("game_ended");
	self waittillmatch("end",param_00);
	self delete();
}

//Function Number: 78
func_83DC(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	if(!isdefined(param_04))
	{
		param_04 = "NA";
	}

	if(!isdefined(param_00))
	{
		param_00 = "unknown_event";
	}

	if(!isdefined(param_01))
	{
		param_01 = "unknown_category";
	}

	function_00F5("script_mp_hub_event: game_time %d, player_name %s, player_id %d, event_category %s, event_name %s, event_value_int %d, event_value_float %f, event_value_string %s, player_count %d",gettime(),self.var_109,self.var_2418,param_01,param_00,param_02,param_03,param_04,level.var_744A.size);
}

//Function Number: 79
func_50F0(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}

	if(getdvarint("3708",0) == 1 && getdvarint("3645",0) == 1)
	{
		return;
	}

	if(!isdefined(param_01))
	{
	}

	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	if(!isdefined(param_03))
	{
		param_03 = "NA";
	}

	var_04 = "unknown_event";
	var_05 = "unknown_category";
	var_06 = 0;
	switch(param_00.size)
	{
		case 1:
			var_06 = self getrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0]) + param_01;
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],var_06);
			var_04 = param_00[param_00.size - 1];
			break;

		case 2:
			var_06 = self getrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1]) + param_01;
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],var_06);
			var_04 = param_00[param_00.size - 1];
			var_05 = param_00[param_00.size - 2];
			break;

		case 3:
			var_06 = self getrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2]) + param_01;
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],var_06);
			var_04 = param_00[param_00.size - 1];
			var_05 = param_00[param_00.size - 2];
			break;

		case 4:
			var_06 = self getrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3]) + param_01;
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3],var_06);
			var_04 = param_00[param_00.size - 1];
			var_05 = param_00[param_00.size - 2];
			break;

		case 5:
			var_06 = self getrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3],param_00[4]) + param_01;
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3],param_00[4],var_06);
			var_04 = param_00[param_00.size - 1];
			var_05 = param_00[param_00.size - 2];
			break;

		default:
			break;
	}

	func_83DC(var_04,var_05,param_01,param_02,param_03);
	return var_06;
}

//Function Number: 80
func_84DE(param_00,param_01)
{
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}

	if(getdvarint("3708",0) == 1 && getdvarint("3645",0) == 1)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	var_02 = "unknown_event";
	var_03 = "unknown_category";
	switch(param_00.size)
	{
		case 1:
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_01);
			var_02 = param_00[param_00.size - 1];
			break;

		case 2:
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_01);
			var_02 = param_00[param_00.size - 1];
			var_03 = param_00[param_00.size - 2];
			break;

		case 3:
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_01);
			var_02 = param_00[param_00.size - 1];
			var_03 = param_00[param_00.size - 2];
			break;

		case 4:
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3],param_01);
			var_02 = param_00[param_00.size - 1];
			var_03 = param_00[param_00.size - 2];
			break;

		case 5:
			self setrankedplayerdata(common_scripts\utility::func_46AA(),param_00[0],param_00[1],param_00[2],param_00[3],param_00[4],param_01);
			var_02 = param_00[param_00.size - 1];
			var_03 = param_00[param_00.size - 2];
			break;

		default:
			break;
	}
}

//Function Number: 81
func_5E88(param_00,param_01,param_02,param_03)
{
	if(function_0279(self))
	{
		return;
	}

	var_04 = self.var_4F4C;
	if(!isdefined(var_04))
	{
		var_04 = -1;
	}

	var_05 = self.var_2418;
	if(!isdefined(var_05))
	{
		var_05 = -1;
	}

	self dlogevent("telemetry_hq_event",["base",["hq_guid",function_0398(),"utc_timestamp_join",var_04,"data_center_id",function_0397(),"game_time",gettime(),"player_index",var_05,"player_count",level.var_744A.size,"event_name",param_00,"event_category",param_01,"duration_seconds",param_02],param_00,param_03]);
}

//Function Number: 82
func_582B()
{
	if(function_0367() && level.var_744A.size > 20 && getdvarint("3708",0) != 1 && getdvarint("3645",0) != 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
func_7D1D(param_00)
{
	self notify("cancelEntSwitch");
	if(!isdefined(self.var_4F4D))
	{
		self.var_4F4D = 0;
	}

	if(!isdefined(self.var_4F4B))
	{
		self.var_4F4B = [];
	}

	switch(param_00)
	{
		case 3:
		case 2:
		case 1:
		case 0:
			if(!isdefined(self.var_4F4B[param_00]) || self.var_4F4B[param_00] == 0)
			{
				self.var_4F4B[param_00] = 1;
				self.var_4F4D = self.var_4F4D + 1;
			}
	
			self method_85EA("ET_PLAYER");
			break;

		default:
			break;
	}
}

//Function Number: 84
func_86FE()
{
	self endon("cancelEntSwitch");
	self endon("disconnect");
	level endon("game_ended");
	wait(4);
	self method_85EA("ET_PLAYER_HUB");
}

//Function Number: 85
func_7E4E(param_00)
{
	self notify("cancelEntSwitch");
	if(!isdefined(self.var_4F4D))
	{
		self.var_4F4D = 0;
	}

	if(!isdefined(self.var_4F4B))
	{
		self.var_4F4B = [];
	}

	switch(param_00)
	{
		case 3:
		case 2:
		case 1:
		case 0:
			if(isdefined(self.var_4F4B[param_00]) && self.var_4F4B[param_00] == 1)
			{
				self.var_4F4B[param_00] = 0;
				self.var_4F4D = self.var_4F4D - 1;
			}
			else
			{
				self.var_4F4B[param_00] = 0;
			}
			break;

		default:
			break;
	}

	if(self.var_4F4D == 0)
	{
		thread func_86FE();
	}
}

//Function Number: 86
func_7D1E(param_00)
{
	if(!isdefined(self.var_4F4E))
	{
		self.var_4F4E = 0;
	}

	if(!isdefined(self.var_4F4F))
	{
		self.var_4F4F = [];
	}

	switch(param_00)
	{
		case 2:
		case 1:
		case 0:
			if(!isdefined(self.var_4F4F[param_00]) || self.var_4F4F[param_00] == 0)
			{
				self.var_4F4F[param_00] = 1;
				self.var_4F4E = self.var_4F4E + 1;
			}
	
			self setclientomnvar("blockPlaylistUpdateWarning",1);
			break;

		default:
			break;
	}
}

//Function Number: 87
func_7E4F(param_00)
{
	if(!isdefined(self.var_4F4E))
	{
		self.var_4F4E = 0;
	}

	if(!isdefined(self.var_4F4F))
	{
		self.var_4F4F = [];
	}

	switch(param_00)
	{
		case 2:
		case 1:
		case 0:
			if(isdefined(self.var_4F4F[param_00]) && self.var_4F4F[param_00] == 1)
			{
				self.var_4F4F[param_00] = 0;
				self.var_4F4E = self.var_4F4E - 1;
			}
			else
			{
				self.var_4F4F[param_00] = 0;
			}
			break;

		default:
			break;
	}

	if(self.var_4F4E == 0)
	{
		self setclientomnvar("blockPlaylistUpdateWarning",0);
	}
}

//Function Number: 88
func_8698(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = getgroundposition(param_00,20,512,120,0);
	if(isdefined(var_02))
	{
		self setorigin(var_02,param_01);
		return;
	}

	self setorigin(param_00,param_01);
}

//Function Number: 89
func_83DE(param_00)
{
	level endon("game_ended");
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] notify(param_00[var_01 + 1]);
		var_01++;
	}
}

//Function Number: 90
func_8627()
{
	var_00 = undefined;
	var_01 = undefined;
	if(isdefined(self.color))
	{
		if(issubstr(self.color,"huba"))
		{
			var_00 = 500;
		}
		else if(issubstr(self.color,"hubb"))
		{
			var_00 = 499;
			var_01 = 499;
		}
		else if(issubstr(self.color,"hubc"))
		{
			var_00 = 501;
		}
		else if(issubstr(self.color,"hubd"))
		{
			var_00 = 502;
		}

		if(!isdefined(var_01) && isdefined(self.var_18A8))
		{
			if(issubstr(self.var_18A8,"huba"))
			{
				var_01 = 500;
			}
			else if(issubstr(self.var_18A8,"hubb"))
			{
				var_00 = 499;
				var_01 = 499;
			}
			else if(issubstr(self.var_18A8,"hubc"))
			{
				var_01 = 501;
			}
			else if(issubstr(self.var_18A8,"hubd"))
			{
				var_01 = 502;
			}
			else if(issubstr(self.var_18A8,"hube"))
			{
				var_01 = 503;
			}
		}
	}
	else if(issubstr(self.var_106,"huba"))
	{
		var_00 = 500;
	}
	else if(issubstr(self.var_106,"hubb"))
	{
		var_00 = 499;
		var_01 = 499;
	}
	else if(issubstr(self.var_106,"hubc"))
	{
		var_00 = 501;
	}
	else if(issubstr(self.var_106,"hubd"))
	{
		var_00 = 502;
	}
	else if(issubstr(self.var_106,"hube"))
	{
		var_00 = 499;
		var_01 = 499;
	}

	if(!isdefined(var_00))
	{
		var_00 = randomintrange(500,503);
	}

	if(!isdefined(var_01))
	{
		var_01 = randomintrange(500,504);
	}

	self setcostumemodels([var_01,var_00,0,0,0]);
}

//Function Number: 91
func_4B02(param_00,param_01,param_02)
{
	level endon("game_ended");
	for(;;)
	{
		for(var_03 = 1;var_03 < param_02.size;var_03++)
		{
			param_00 method_8495(param_02[0],self.var_831A.var_116,self.var_831A.var_1D,"animEnded");
			foreach(var_05 in param_01)
			{
				if(var_05.var_ED2[0] == "")
				{
					continue;
				}

				var_05.var_378F method_8495(var_05.var_ED2[0],self.var_831A.var_116,self.var_831A.var_1D);
			}

			param_00 waittillmatch("end","animEnded");
			param_00 method_8495(param_02[var_03],self.var_831A.var_116,self.var_831A.var_1D,"animEnded");
			foreach(var_05 in param_01)
			{
				if(var_05.var_ED2[var_03] == "")
				{
					continue;
				}

				var_05.var_378F method_8495(var_05.var_ED2[var_03],self.var_831A.var_116,self.var_831A.var_1D);
			}

			param_00 waittillmatch("end","animEnded");
		}
	}
}

//Function Number: 92
func_4F45(param_00)
{
	if(!function_025F() && !function_03AE() || common_scripts\utility::func_562E(level.var_AC5A))
	{
		while(!istransientqueued(param_00))
		{
			wait 0.05;
		}
	}
}

//Function Number: 93
func_74AB(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	var_04 = "idle";
	for(;;)
	{
		param_00 method_8495(param_01[var_04],param_02.var_116,param_02.var_1D,"idle");
		if(var_04 != "idle")
		{
			param_00 waittillmatch("end","idle");
			var_04 = "idle";
			continue;
		}

		var_04 = param_00 common_scripts\utility::func_A712(param_03);
	}
}

//Function Number: 94
func_3E1F(param_00)
{
	param_00.var_3E1E = 1;
	param_00.var_3E27 = 0;
}

//Function Number: 95
func_3E28(param_00)
{
	if(isdefined(param_00))
	{
		self setkioskheadiconvisibility(param_00,1);
	}
}

//Function Number: 96
func_3E15(param_00)
{
	self setkioskheadiconvisibility(param_00,0);
}

//Function Number: 97
func_4B90()
{
	if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"forceTutorialDivision") >= 1 || self getrankedplayerdata(common_scripts\utility::func_46AE(),"matchesCompleted") >= 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 98
removeunusedpatchclip()
{
	var_00 = ["patchclip_item_16_128_128","patchclip_item_16_64_64","patchclip_player_16_256_256","patchclip_player_16_128_128","patchclip_player_16_64_64","patchclip_player_128_128_128","patchclip_player_64_64_64","patchclip_player_32_32_32","patchclip_nosight_16_128_128","patchclip_vehicle_16_256_256","patchclip_vehicle_16_128_128","patchclip_vehicle_16_64_64","patchclip_nosight_16_64_64","patchclip_vehicle_128_128_128","patchclip_vehicle_64_64_64","patchclip_vehicle_32_32_32","patchclip_nosight_64_64_64","patchclip_nosight_32_32_32"];
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02,"targetname");
		if(isdefined(var_03))
		{
			var_03 delete();
		}
	}
}
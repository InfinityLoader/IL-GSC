/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\sotf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1929 ms
 * Timestamp: 10/27/2023 12:13:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	scripts\mp\_globallogic::init();
	scripts\mp\_globallogic::func_FA99();
	if(function_011C())
	{
		level.var_987C = ::func_987C;
		[[ level.var_987C ]]();
		level thread scripts\mp\_utility::func_DF2D();
	}
	else
	{
		scripts\mp\_utility::func_DF0B(level.gametype,65);
		scripts\mp\_utility::func_DF11(level.gametype,10);
		scripts\mp\_utility::func_DF08(level.gametype,1);
		scripts\mp\_utility::func_DF1A(level.gametype,1);
		scripts\mp\_utility::func_DF02(level.gametype,0);
		scripts\mp\_utility::func_DEF4(level.gametype,0);
		level.var_B40E = 0;
		level.var_B40A = 0;
		level.var_B410 = 0;
	}

	func_F7F4();
	level.teambased = 1;
	level.var_C81E = 500;
	level.var_C580 = ::func_C580;
	level.var_C5A4 = ::func_C5A4;
	level.var_8136 = ::func_8136;
	level.onspawnplayer = ::onspawnplayer;
	level.var_C55E = ::func_C55E;
	level.var_4C85 = ::func_10449;
	level.var_4854 = ::func_4854;
	level.var_CB4B = ::func_CB4B;
	level.var_92B5 = ::func_92B5;
	level.var_C2C6 = ::func_C2C6;
	level.var_112C2 = 0;
	level.var_112C4 = 0;
	level.var_13264 = "littlebird_neutral_mp";
	level.var_1307A = [];
	level.var_61C0 = 1;
	level.var_6DE5 = 1;
	if(level.var_B40A || level.var_B410)
	{
		level.var_B93A = ::scripts\mp\_damage::func_7678;
	}

	game["dialog"]["gametype"] = "hunted";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "sotf_hint";
	game["dialog"]["defense_obj"] = "sotf_hint";
}

//Function Number: 2
func_987C()
{
	scripts\mp\_utility::func_F69D();
	setdynamicdvar("scr_sotf_crateamount",getmatchrulesdata("sotfData","crateAmount"));
	setdynamicdvar("scr_sotf_crategunamount",getmatchrulesdata("sotfData","crateGunAmount"));
	setdynamicdvar("scr_sotf_cratetimer",getmatchrulesdata("sotfData","crateDropTimer"));
	setdynamicdvar("scr_sotf_roundlimit",1);
	scripts\mp\_utility::func_DF08("sotf",1);
	setdynamicdvar("scr_sotf_winlimit",1);
	scripts\mp\_utility::func_DF1A("sotf",1);
	setdynamicdvar("scr_sotf_halftime",0);
	scripts\mp\_utility::func_DEF4("sotf",0);
	setdynamicdvar("scr_sotf_promode",0);
}

//Function Number: 3
func_C580()
{
	level._effect["signal_chest_drop"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["signal_chest_drop_mover"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

//Function Number: 4
func_C5A4()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	var_02 = &"OBJECTIVES_WAR";
	var_03 = &"OBJECTIVES_WAR_SCORE";
	var_04 = &"OBJECTIVES_WAR_HINT";
	scripts\mp\_utility::func_F7C1("allies",var_02);
	scripts\mp\_utility::func_F7C1("axis",var_02);
	if(level.splitscreen)
	{
		scripts\mp\_utility::func_F7C0("allies",var_02);
		scripts\mp\_utility::func_F7C0("axis",var_02);
	}
	else
	{
		scripts\mp\_utility::func_F7C0("allies",var_03);
		scripts\mp\_utility::func_F7C0("axis",var_03);
	}

	scripts\mp\_utility::func_F7BE("allies",var_04);
	scripts\mp\_utility::func_F7BE("axis",var_04);
	func_98CE();
	var_05 = [];
	scripts\mp\_gameobjects::main(var_05);
	level thread func_10440();
}

//Function Number: 5
func_98CE()
{
	scripts\mp\_spawnlogic::func_F62D("TDM");
	level.var_108E4 = (0,0,0);
	level.var_108E2 = (0,0,0);
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_allies_start");
	scripts\mp\_spawnlogic::func_182D("mp_tdm_spawn_axis_start");
	scripts\mp\_spawnlogic::func_1829("allies","mp_tdm_spawn");
	scripts\mp\_spawnlogic::func_1829("axis","mp_tdm_spawn");
	level.var_B32E = scripts\mp\_spawnlogic::func_6CAF(level.var_108E4,level.var_108E2);
	function_01B4(level.var_B32E);
}

//Function Number: 6
func_F7F4()
{
	func_50A2();
	var_00 = func_80C5(level.var_CBDF);
	var_01 = scripts\mp\_utility::func_8234(var_00["name"]);
	var_02 = tablelookup("mp/sotfWeapons.csv",2,var_01,0);
	setomnvar("ui_sotf_pistol",int(var_02));
	level.var_10447["axis"]["loadoutPrimary"] = "none";
	level.var_10447["axis"]["loadoutPrimaryAttachment"] = "none";
	level.var_10447["axis"]["loadoutPrimaryAttachment2"] = "none";
	level.var_10447["axis"]["loadoutPrimaryCamo"] = "none";
	level.var_10447["axis"]["loadoutPrimaryReticle"] = "none";
	level.var_10447["axis"]["loadoutSecondary"] = var_00["name"];
	level.var_10447["axis"]["loadoutSecondaryAttachment"] = "none";
	level.var_10447["axis"]["loadoutSecondaryAttachment2"] = "none";
	level.var_10447["axis"]["loadoutSecondaryCamo"] = "none";
	level.var_10447["axis"]["loadoutSecondaryReticle"] = "none";
	level.var_10447["axis"]["loadoutEquipment"] = "throwingknife_mp";
	level.var_10447["axis"]["loadoutOffhand"] = "flash_grenade_mp";
	level.var_10447["axis"]["loadoutStreakType"] = "assault";
	level.var_10447["axis"]["loadoutKillstreak1"] = "none";
	level.var_10447["axis"]["loadoutKillstreak2"] = "none";
	level.var_10447["axis"]["loadoutKillstreak3"] = "none";
	level.var_10447["axis"]["loadoutJuggernaut"] = 0;
	level.var_10447["axis"]["loadoutPerks"] = ["specialty_longersprint","specialty_extra_deadly"];
	level.var_10447["allies"] = level.var_10447["axis"];
}

//Function Number: 7
func_8136()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = scripts\mp\_utility::getotherteam(var_00);
	}

	if(scripts\mp\_spawnlogic::func_100BA())
	{
		var_01 = scripts\mp\_spawnlogic::func_8140("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = scripts\mp\_spawnlogic::func_813F(var_01);
	}
	else
	{
		var_01 = scripts\mp\_spawnlogic::func_81BA(var_02);
		var_02 = scripts\mp\_spawnscoring::func_8136(var_02);
	}

	return var_02;
}

//Function Number: 8
onspawnplayer()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.var_4004 = self.pers["class"];
	self.var_A95C = self.pers["lastClass"];
	self.pers["gamemodeLoadout"] = level.var_10447[self.pers["team"]];
	level notify("sotf_player_spawned",self);
	self.var_C400 = undefined;
	self.var_BF24 = undefined;
	thread func_13706();
}

//Function Number: 9
func_13706()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("giveLoadout");
	var_00 = self getcurrentweapon();
	self setweaponammostock(var_00,0);
	self.var_C400 = var_00;
	thread func_CB4B();
}

//Function Number: 10
func_C579(param_00,param_01)
{
	if(param_00 == "kill")
	{
		var_02 = scripts\mp\_rank::func_8104("score_increment");
		return var_02;
	}

	return 0;
}

//Function Number: 11
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\mp\gametypes\common::func_C55E(param_00,param_01,param_02,param_03,param_04);
	param_01 func_CA68();
}

//Function Number: 12
func_10440()
{
	level thread func_10DF0();
}

//Function Number: 13
func_10DF0()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = getdvarint("scr_sotf_crateamount",1);
	var_01 = getdvarint("scr_sotf_cratetimer",30);
	level waittill("sotf_player_spawned",var_02);
	for(;;)
	{
		if(!isalive(var_02))
		{
			var_02 = func_6CBD(level.players);
			if(!isdefined(var_02))
			{
				continue;
			}

			continue;
		}

		while(isalive(var_02))
		{
			if(level.var_61C0)
			{
				for(var_03 = 0;var_03 < var_00;var_03++)
				{
					level thread func_10839(var_02);
				}

				level thread func_1011A("sotf_crate_incoming");
				wait(var_01);
				continue;
			}

			wait(0.05);
		}
	}
}

//Function Number: 14
func_1011A(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\mp\_hud_message::func_10151(param_00);
	}
}

//Function Number: 15
func_6CBD(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isalive(var_02))
		{
			return var_02;
		}
	}

	level waittill("sotf_player_spawned",var_04);
	return var_04;
}

//Function Number: 16
func_10839(param_00)
{
	var_01 = scripts\common\utility::getstructarray("sotf_chest_spawnpoint","targetname");
	if(level.var_6DE5)
	{
		var_02 = func_7E1D(var_01);
		level.var_6DE5 = 0;
	}
	else
	{
		var_02 = func_80C0(var_02);
	}

	if(isdefined(var_02))
	{
		func_D482(var_02);
		level thread scripts\mp\killstreaks\_airdrop::func_5857(param_00,var_02,randomfloat(360),"airdrop_sotf");
	}
}

//Function Number: 17
func_D482(param_00)
{
	var_01 = param_00 + (0,0,30);
	var_02 = param_00 + (0,0,-1000);
	var_03 = bullettrace(var_01,var_02,0,undefined);
	var_04 = var_03["position"] + (0,0,1);
	var_05 = var_03["entity"];
	if(isdefined(var_05))
	{
		for(var_06 = var_05 getlinkedparent();isdefined(var_06);var_06 = var_05 getlinkedparent())
		{
			var_05 = var_06;
		}
	}

	if(isdefined(var_05))
	{
		var_07 = spawn("script_model",var_04);
		var_07 setmodel("tag_origin");
		var_07.angles = (90,randomintrange(-180,179),0);
		var_07 linkto(var_05);
		thread func_D4BE(scripts\common\utility::getfx("signal_chest_drop_mover"),var_07);
		return;
	}

	playfx(scripts\common\utility::getfx("signal_chest_drop"),var_04);
}

//Function Number: 18
func_D4BE(param_00,param_01)
{
	level endon("game_ended");
	wait(0.05);
	playfxontag(param_00,param_01,"tag_origin");
	wait(6);
	stopfxontag(param_00,param_01,"tag_origin");
	wait(0.05);
	param_01 delete();
}

//Function Number: 19
func_7E1D(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in param_00)
	{
		var_05 = distance2dsquared(level.var_B32E,var_04.origin);
		if(!isdefined(var_01) || var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	level.var_1307A[level.var_1307A.size] = var_01.origin;
	return var_01.origin;
}

//Function Number: 20
func_80C0(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = 0;
		if(isdefined(level.var_1307A) && level.var_1307A.size > 0)
		{
			foreach(var_05 in level.var_1307A)
			{
				if(param_00[var_02].origin == var_05)
				{
					var_03 = 1;
					break;
				}
			}

			if(var_03)
			{
				continue;
			}

			var_01[var_01.size] = param_00[var_02].origin;
			continue;
		}

		var_01[var_01.size] = param_00[var_02].origin;
	}

	if(var_01.size > 0)
	{
		var_07 = randomint(var_01.size);
		var_08 = var_01[var_07];
		level.var_1307A[level.var_1307A.size] = var_08;
		return var_08;
	}

	level.var_61C0 = 0;
	return undefined;
}

//Function Number: 21
func_50A2()
{
	var_00 = [];
	var_01 = [];
	for(var_02 = 0;tablelookupbyrow("mp/sotfWeapons.csv",var_02,0) != "";var_02++)
	{
		var_03 = tablelookupbyrow("mp/sotfWeapons.csv",var_02,2);
		var_04 = tablelookupbyrow("mp/sotfWeapons.csv",var_02,1);
		var_05 = func_9F3D(var_03);
		if(isdefined(var_04) && var_05 && var_04 == "weapon_pistol")
		{
			var_06 = 30;
			var_00[var_00.size]["name"] = var_03;
			var_00[var_00.size - 1]["weight"] = var_06;
			continue;
		}

		if(isdefined(var_04) && var_05 && var_04 == "weapon_shotgun" || var_04 == "weapon_smg" || var_04 == "weapon_assault" || var_04 == "weapon_sniper" || var_04 == "weapon_dmr" || var_04 == "weapon_lmg" || var_04 == "weapon_projectile")
		{
			var_06 = 0;
			switch(var_04)
			{
				case "weapon_shotgun":
					var_06 = 35;
					break;

				case "weapon_assault":
				case "weapon_smg":
					var_06 = 25;
					break;

				case "weapon_dmr":
				case "weapon_sniper":
					var_06 = 15;
					break;

				case "weapon_lmg":
					var_06 = 10;
					break;

				case "weapon_projectile":
					var_06 = 30;
					break;
			}

			var_01[var_01.size]["name"] = var_03 + "_mp";
			var_01[var_01.size - 1]["group"] = var_04;
			var_01[var_01.size - 1]["weight"] = var_06;
			continue;
		}

		continue;
	}

	var_01 = func_10437(var_01);
	level.var_CBDF = var_00;
	level.var_13C73 = var_01;
}

//Function Number: 22
func_10449(param_00,param_01)
{
	scripts\mp\killstreaks\_airdrop::func_17BF("airdrop_sotf","sotf_weapon",100,::func_1044A,param_00,param_00,&"KILLSTREAKS_HINTS_WEAPON_PICKUP");
}

//Function Number: 23
func_1044A(param_00)
{
	self endon("death");
	self endon("restarting_physics");
	level endon("game_ended");
	if(isdefined(game["strings"][self.var_485F + "_hint"]))
	{
		var_01 = game["strings"][self.var_485F + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	var_02 = "icon_hunted";
	scripts\mp\killstreaks\_airdrop::func_485D(var_01,var_02);
	thread scripts\mp\killstreaks\_airdrop::func_484E();
	childthread func_4866(60);
	childthread func_D3C2();
	var_03 = 0;
	var_04 = getdvarint("scr_sotf_crategunamount",6);
	for(;;)
	{
		self waittill("captured",var_05);
		var_05 playlocalsound("ammo_crate_use");
		var_06 = func_80C5(level.var_13C73);
		var_06 = func_80B1(var_06);
		var_07 = var_05.var_A978;
		var_08 = var_05 method_80FB(var_07);
		if(var_06 == var_07)
		{
			var_05 method_817C(var_06);
			var_05 setweaponammostock(var_06,var_08);
		}
		else
		{
			if(isdefined(var_07) && var_07 != "none")
			{
				var_09 = var_05 method_80B8(var_07);
				if(isdefined(var_09) && var_08 > 0)
				{
					var_09.var_336 = "dropped_weapon";
				}
			}

			var_05 giveweapon(var_06,0,0,0,1);
			var_05 setweaponammostock(var_06,0);
			var_05 scripts\mp\_utility::_switchtoweaponimmediate(var_06);
			if(var_05 getweaponammoclip(var_06) == 1)
			{
				var_05 setweaponammostock(var_06,1);
			}

			var_05.var_C400 = var_06;
		}

		var_03++;
		var_04 = var_04 - 1;
		if(var_04 > 0)
		{
			foreach(var_05 in level.players)
			{
				scripts\mp\_entityheadicons::func_F73D(var_05,"blitz_time_0" + var_04 + "_blue",(0,0,24),14,14,undefined,undefined,undefined,undefined,undefined,0);
				self.var_4853 = "blitz_time_0" + var_04 + "_blue";
			}
		}

		if(self.var_485F == "sotf_weapon" && var_03 == getdvarint("scr_sotf_crategunamount",6))
		{
			scripts\mp\killstreaks\_airdrop::func_51AA();
		}
	}
}

//Function Number: 24
func_4866(param_00)
{
	wait(param_00);
	while(isdefined(self.var_9B04) && self.var_9B04)
	{
		scripts\common\utility::func_136F7();
	}

	scripts\mp\killstreaks\_airdrop::func_51AA();
}

//Function Number: 25
func_D3C2()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		scripts\mp\_entityheadicons::func_F73D(var_00,self.var_4853,(0,0,24),14,14,undefined,undefined,undefined,undefined,undefined,0);
	}
}

//Function Number: 26
func_4854(param_00)
{
	for(var_01 = 0;var_01 < level.var_1307A.size;var_01++)
	{
		if(param_00 != level.var_1307A[var_01])
		{
			continue;
		}

		level.var_1307A = scripts\common\utility::func_22A9(level.var_1307A,param_00);
	}

	level.var_61C0 = 1;
}

//Function Number: 27
func_9F3D(param_00)
{
	var_01 = tablelookup("mp/sotfWeapons.csv",2,param_00,3);
	var_02 = tablelookup("mp/sotfWeapons.csv",2,param_00,4);
	if(var_01 == "TRUE" && var_02 == "" || getdvarint(var_02,0) == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_80C5(param_00)
{
	var_01 = func_F674(param_00);
	var_02 = randomint(level.var_13CA7["sum"]);
	var_03 = undefined;
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(!var_01[var_04]["weight"])
		{
			continue;
		}

		if(var_01[var_04]["weight"] > var_02)
		{
			var_03 = var_01[var_04];
			break;
		}
	}

	return var_03;
}

//Function Number: 29
func_80B1(param_00)
{
	var_01 = [];
	var_02 = [];
	var_03 = [];
	var_04 = scripts\mp\_utility::func_8234(param_00["name"]);
	var_05 = scripts\mp\_utility::func_8217(var_04);
	if(var_05.size > 0)
	{
		var_06 = randomint(5);
		for(var_07 = 0;var_07 < var_06;var_07++)
		{
			var_01 = func_81F5(param_00,var_02,var_05);
			if(var_01.size == 0)
			{
				break;
			}

			var_08 = randomint(var_01.size);
			var_02[var_02.size] = var_01[var_08];
			var_09 = scripts\mp\_utility::func_2496(var_01[var_08],var_04);
			var_03[var_03.size] = var_09;
		}

		var_0A = scripts\mp\_utility::func_8225(param_00["name"]);
		if(var_0A == "weapon_dmr" || var_0A == "weapon_sniper" || var_04 == "iw7_ripper")
		{
			var_0B = 0;
			foreach(var_0D in var_02)
			{
				if(scripts\mp\_utility::getattachmenttype(var_0D) == "rail")
				{
					var_0B = 1;
					break;
				}
			}

			if(!var_0B && param_00["name"] != "iw7_m1_mp")
			{
				var_0F = strtok(var_04,"_")[1];
				var_03[var_03.size] = var_0F + "scope";
			}
		}

		if(var_03.size > 0)
		{
			var_03 = scripts\common\utility::func_1D3A(var_03);
			foreach(var_11 in var_03)
			{
				param_00["name"] = param_00["name"] + "_" + var_11;
			}
		}
	}

	return param_00["name"];
}

//Function Number: 30
func_81F5(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_02)
	{
		if(var_05 == "gl" || var_05 == "shotgun")
		{
			continue;
		}

		var_06 = func_248A(var_05,param_01);
		if(!var_06)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	return var_03;
}

//Function Number: 31
func_248A(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02] || !scripts\mp\_utility::func_249D(param_00,param_01[var_02]))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 32
func_3E46(param_00)
{
	foreach(var_02 in param_00)
	{
		if(var_02 == "thermal" || var_02 == "vzscope" || var_02 == "acog" || var_02 == "ironsight")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 33
func_CB4B()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		scripts\common\utility::func_136F7();
		var_00 = self getweaponslistprimaries();
		if(var_00.size > 1)
		{
			foreach(var_02 in var_00)
			{
				if(var_02 == self.var_C400)
				{
					var_03 = self method_80FB(var_02);
					var_04 = self method_80B8(var_02);
					if(isdefined(var_04) && var_03 > 0)
					{
						var_04.var_336 = "dropped_weapon";
					}

					break;
				}
			}

			var_00 = scripts\common\utility::func_22A9(var_00,self.var_C400);
			self.var_C400 = var_00[0];
		}
	}
}

//Function Number: 34
func_AFC3()
{
	self.pers["killChains"]++;
	scripts\mp\_persistence::func_10E56("round","killChains",self.pers["killChains"]);
}

//Function Number: 35
func_CA68()
{
	if(level.var_1CA1)
	{
		switch(self.var_110EE)
		{
			case 2:
				scripts\mp\_utility::func_8387("specialty_fastsprintrecovery");
				thread scripts\mp\_hud_message::func_10151("specialty_fastsprintrecovery_sotf",self.var_110EE);
				thread func_AFC3();
				break;

			case 3:
				scripts\mp\_utility::func_8387("specialty_lightweight");
				thread scripts\mp\_hud_message::func_10151("specialty_lightweight_sotf",self.var_110EE);
				thread func_AFC3();
				break;

			case 4:
				scripts\mp\_utility::func_8387("specialty_stalker");
				thread scripts\mp\_hud_message::func_10151("specialty_stalker_sotf",self.var_110EE);
				thread func_AFC3();
				break;

			case 5:
				scripts\mp\_utility::func_8387("specialty_regenfaster");
				thread scripts\mp\_hud_message::func_10151("specialty_regenfaster_sotf",self.var_110EE);
				thread func_AFC3();
				break;

			case 6:
				scripts\mp\_utility::func_8387("specialty_deadeye");
				thread scripts\mp\_hud_message::func_10151("specialty_deadeye_sotf",self.var_110EE);
				thread func_AFC3();
				break;
		}
	}
}

//Function Number: 36
func_92B5(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		param_00 scripts\mp\_entityheadicons::func_F73D(var_03,param_01,(0,0,24),14,14,undefined,undefined,undefined,undefined,undefined,0);
		self.var_4853 = param_01;
	}
}

//Function Number: 37
func_C2C6(param_00)
{
	scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(param_00);
}

//Function Number: 38
func_F674(param_00)
{
	level.var_13CA7["sum"] = 0;
	var_01 = param_00;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!var_01[var_02]["weight"])
		{
			continue;
		}

		level.var_13CA7["sum"] = level.var_13CA7["sum"] + var_01[var_02]["weight"];
		var_01[var_02]["weight"] = level.var_13CA7["sum"];
	}

	return var_01;
}

//Function Number: 39
func_10437(param_00)
{
	var_01 = [];
	var_02 = [];
	for(var_03 = 1;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03]["weight"];
		var_01 = param_00[var_03];
		for(var_05 = var_03 - 1;var_05 >= 0 && func_9D1D(param_00[var_05]["weight"],var_04);var_05--)
		{
			var_02 = param_00[var_05];
			param_00[var_05] = var_01;
			param_00[var_05 + 1] = var_02;
		}
	}

	return param_00;
}

//Function Number: 40
func_9D1D(param_00,param_01)
{
	return param_00 < param_01;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_persistence.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 102
 * Decompile Time: 4992 ms
 * Timestamp: 10/27/2023 12:09:47 AM
*******************************************************************/

//Function Number: 1
func_F4CA(param_00)
{
	self [[ level.var_462C[param_00].var_F286 ]]();
}

//Function Number: 2
func_12C11(param_00)
{
	self [[ level.var_462C[param_00].var_12BF4 ]]();
}

//Function Number: 3
func_7B8B()
{
	return self getplayerdata("cp","alienSession","currency");
}

//Function Number: 4
func_7BA6()
{
	return self.var_B48A;
}

//Function Number: 5
func_11426()
{
	func_F525(0);
}

//Function Number: 6
func_7CA5()
{
	if(isdefined(level.var_10DA7))
	{
		return level.var_10DA7;
	}

	return 500;
}

//Function Number: 7
func_13683(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	wait(1);
	func_F525(param_00);
}

//Function Number: 8
func_F525(param_00)
{
	self setplayerdata("cp","alienSession","currency",int(param_00));
	func_666A("currency",int(param_00),1);
}

//Function Number: 9
func_82F9(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_03))
	{
		param_00 = int(param_00 * lib_0CFF::func_D877());
		param_00 = lib_0A54::func_E759(param_00,5);
	}

	if(isdefined(level.currency_scale_func))
	{
		param_00 = [[ level.currency_scale_func ]](self,param_00);
	}

	var_05 = func_7B8B();
	var_06 = func_7BA6();
	var_07 = var_05 + param_00;
	var_07 = min(var_07,var_06);
	if(!isdefined(self.var_11A21))
	{
		self.var_11A21 = param_00;
	}

	if(is_valid_give_type(param_04))
	{
		self.var_11A21 = self.var_11A21 + var_07 - var_05;
		self notify("consumable_charge",param_00 * 0.5);
	}

	level notify("currency_changed");
	func_666A("currencytotal",int(self.var_11A21),1);
	func_F525(var_07);
	if(isdefined(level.var_12DED))
	{
		[[ level.var_12DED ]](self,param_00);
	}

	var_08 = 30000;
	var_09 = gettime();
	if(var_07 >= var_06)
	{
		if(!isdefined(self.var_BF4A))
		{
			self.var_BF4A = var_09 + var_08;
		}
		else if(var_09 < self.var_BF4A)
		{
			return;
		}

		if(!level.var_7669)
		{
			scripts\cp\_utility::setlowermessage("maxmoney",&"COOP_GAME_PLAY_MONEY_MAX",4);
			self.var_BF4A = var_09 + var_08;
		}
	}

	if(is_valid_give_type(param_04))
	{
		thread scripts\cp\_utility::add_to_notify_queue("player_earned_money",param_00);
	}

	self notify("currency_earned",param_00);
	if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		scripts\cp\_utility::func_316C("currency_earned_buffered",param_00);
	}

	func_666A("score",int(self.var_11A21),1);
}

//Function Number: 10
is_valid_give_type(param_00)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	switch(param_00)
	{
		case "pillage":
		case "nuke":
		case "magicWheelRefund":
		case "crafted":
		case "carpenter":
		case "bonus":
		case "atm":
			return 0;

		default:
			return 1;
	}

	return 1;
}

//Function Number: 11
func_11445(param_00,param_01,param_02,param_03)
{
	var_04 = func_7B8B();
	var_05 = max(0,var_04 - param_00);
	var_06 = int(var_04 - var_05);
	if(isdefined(level.var_3CA6))
	{
		[[ level.var_3CA6 ]](self,param_02,param_03);
	}

	if(scripts\cp\_utility::func_9BA0("next_purchase_free") && param_00 >= 1 && param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty")
	{
		scripts\cp\_utility::func_C151("next_purchase_free");
	}
	else
	{
		func_F525(var_05);
	}

	if(var_06 < 1)
	{
		return;
	}

	if(isdefined(param_02))
	{
		scripts\cp\_analytics::func_12E2E(var_06,param_02);
	}

	func_666A("currencyspent",var_06);
	if(scripts\cp\_utility::func_9BA0("door_buy_refund") && param_00 > 0)
	{
		if(param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty")
		{
			func_82F9(int(var_06 * 0.3),undefined,undefined,1,"bonus");
			scripts\cp\_utility::func_C151("door_buy_refund");
		}
	}

	if(scripts\cp\_interaction::func_FF5A(param_02))
	{
		self notify("consumable_charge",param_00 * 0.07);
	}

	if(param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty")
	{
		scripts\cp\_utility::func_316C("currency_spent_buffered",param_00);
	}

	if(isdefined(param_01) && param_01)
	{
	}
}

//Function Number: 12
func_D0BB(param_00,param_01)
{
	if(!isdefined(param_01) || isdefined(param_01) && param_01 != "atm" && param_01 != "laststand" && param_01 != "bleedoutPenalty")
	{
		if(scripts\cp\_utility::func_9BA0("next_purchase_free"))
		{
			param_00 = 0;
		}
	}

	var_02 = func_7B8B();
	return var_02 >= param_00;
}

//Function Number: 13
func_12873(param_00)
{
	if(func_D0BB(param_00))
	{
		func_11445(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 14
func_9CF1(param_00)
{
	var_01 = undefined;
	var_01 = strtok(param_00,"_")[0];
	var_02 = level.var_43E9[param_00].var_12BD1;
	var_03 = func_7BAA();
	return var_03 >= var_02;
}

//Function Number: 15
func_D225()
{
	level.var_13F56 = 1;
	func_F54A(0);
	func_F548(0);
	self method_832D(func_7BAA(),func_7BA9());
}

//Function Number: 16
func_F6A0(param_00,param_01,param_02,param_03,param_04)
{
	foreach(var_07, var_06 in level.players)
	{
		if(var_07 == 4)
		{
			continue;
		}

		if(isdefined(param_00) && isdefined(param_01) && isdefined(param_02) && isdefined(param_03) && isdefined(param_04))
		{
			var_06 setplayerdata("cp",param_00,param_01,param_02,param_03,param_04);
			continue;
		}

		if(isdefined(param_00) && isdefined(param_01) && isdefined(param_02) && isdefined(param_03) && !isdefined(param_04))
		{
			var_06 setplayerdata("cp",param_00,param_01,param_02,param_03);
			continue;
		}

		if(isdefined(param_00) && isdefined(param_01) && isdefined(param_02) && !isdefined(param_03) && !isdefined(param_04))
		{
			var_06 setplayerdata("cp",param_00,param_01,param_02);
			continue;
		}

		if(isdefined(param_00) && isdefined(param_01) && !isdefined(param_02) && !isdefined(param_03) && !isdefined(param_04))
		{
			var_06 setplayerdata("cp",param_00,param_01);
			continue;
		}
	}
}

//Function Number: 17
func_F282()
{
	thread func_6669();
}

//Function Number: 18
func_6669()
{
	self endon("disconnect");
	wait(0.5);
	var_00 = self getentitynumber();
	if(var_00 == 4)
	{
		var_00 = 0;
	}

	var_01 = "unknownPlayer";
	if(isdefined(self.name))
	{
		var_01 = self.name;
	}

	if(!level.console)
	{
		var_01 = getsubstr(var_01,0,19);
	}
	else if(func_8C44(var_01))
	{
		var_01 = func_DFD7(var_01);
	}

	for(var_02 = 0;var_02 < 4;var_02++)
	{
		self setplayerdata("cp","EoGPlayer",var_02,"connected",0);
	}

	foreach(var_04 in level.players)
	{
		var_04 func_E1EA(var_00);
		var_04 setplayerdata("cp","EoGPlayer",var_00,"connected",1);
		var_04 setplayerdata("cp","EoGPlayer",var_00,"name",var_01);
		var_04 setplayerdata("common","round","totalXp",0);
		var_04 setplayerdata("common","aarUnlockCount",0);
	}

	var_06 = [0,0,0,0];
	foreach(var_08 in level.players)
	{
		var_09 = var_08 getentitynumber();
		if(var_09 == 4)
		{
			var_09 = 0;
		}

		var_06[int(var_09)] = 1;
		if(var_08 == self)
		{
			continue;
		}

		var_00 = var_08 getentitynumber();
		if(var_00 == 4)
		{
			var_00 = 0;
		}

		var_0A = var_08 getplayerdata("cp","EoGPlayer",var_00,"name");
		var_0B = var_08 getplayerdata("cp","EoGPlayer",var_00,"kills");
		var_0C = var_08 getplayerdata("cp","EoGPlayer",var_00,"score");
		var_0D = var_08 getplayerdata("cp","EoGPlayer",var_00,"assists");
		var_0E = var_08 getplayerdata("cp","EoGPlayer",var_00,"revives");
		var_0F = var_08 getplayerdata("cp","EoGPlayer",var_00,"drillrestarts");
		var_10 = var_08 getplayerdata("cp","EoGPlayer",var_00,"drillplants");
		var_11 = var_08 getplayerdata("cp","EoGPlayer",var_00,"downs");
		var_12 = var_08 getplayerdata("cp","EoGPlayer",var_00,"deaths");
		var_13 = var_08 getplayerdata("cp","EoGPlayer",var_00,"hivesdestroyed");
		var_14 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currency");
		var_15 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currencyspent");
		var_16 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currencytotal");
		var_17 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currency");
		var_18 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currencyspent");
		var_19 = var_08 getplayerdata("cp","EoGPlayer",var_00,"currencytotal");
		var_1A = var_08 getplayerdata("cp","EoGPlayer",var_00,"traps");
		var_1B = var_08 getplayerdata("cp","EoGPlayer",var_00,"deployables");
		var_1C = var_08 getplayerdata("cp","EoGPlayer",var_00,"deployablesused");
		var_1D = var_08 getplayerdata("cp","EoGPlayer",var_00,"consumablesearned");
		var_1E = var_08 getplayerdata("cp","EoGPlayer",var_00,"headShots");
		var_1F = var_08 getplayerdata("cp","EoGPlayer",var_00,"connected");
		self setplayerdata("cp","EoGPlayer",var_00,"name",var_0A);
		self setplayerdata("cp","EoGPlayer",var_00,"kills",var_0B);
		self setplayerdata("cp","EoGPlayer",var_00,"score",var_0C);
		self setplayerdata("cp","EoGPlayer",var_00,"assists",var_0D);
		self setplayerdata("cp","EoGPlayer",var_00,"revives",var_0E);
		self setplayerdata("cp","EoGPlayer",var_00,"drillrestarts",var_0F);
		self setplayerdata("cp","EoGPlayer",var_00,"drillplants",var_10);
		self setplayerdata("cp","EoGPlayer",var_00,"downs",var_11);
		self setplayerdata("cp","EoGPlayer",var_00,"deaths",var_12);
		self setplayerdata("cp","EoGPlayer",var_00,"hivesdestroyed",var_13);
		self setplayerdata("cp","EoGPlayer",var_00,"currency",var_14);
		self setplayerdata("cp","EoGPlayer",var_00,"currencyspent",var_15);
		self setplayerdata("cp","EoGPlayer",var_00,"currencytotal",var_16);
		self setplayerdata("cp","EoGPlayer",var_00,"tickets",var_17);
		self setplayerdata("cp","EoGPlayer",var_00,"ticketsspent",var_18);
		self setplayerdata("cp","EoGPlayer",var_00,"tickettotal",var_19);
		self setplayerdata("cp","EoGPlayer",var_00,"traps",var_1A);
		self setplayerdata("cp","EoGPlayer",var_00,"deployables",var_1B);
		self setplayerdata("cp","EoGPlayer",var_00,"deployablesused",var_1C);
		self setplayerdata("cp","EoGPlayer",var_00,"consumablesearned",var_1D);
		self setplayerdata("cp","EoGPlayer",var_00,"headShots",var_1E);
		self setplayerdata("cp","EoGPlayer",var_00,"connected",var_1F);
	}

	foreach(var_23, var_22 in var_06)
	{
		if(!var_22)
		{
			func_E1EA(var_23);
		}
	}
}

//Function Number: 19
func_E1EA(param_00)
{
	if(param_00 == 4)
	{
		param_00 = 0;
	}

	self setplayerdata("cp","EoGPlayer",param_00,"name","");
	self setplayerdata("cp","EoGPlayer",param_00,"kills",0);
	self setplayerdata("cp","EoGPlayer",param_00,"score",0);
	self setplayerdata("cp","EoGPlayer",param_00,"assists",0);
	self setplayerdata("cp","EoGPlayer",param_00,"revives",0);
	self setplayerdata("cp","EoGPlayer",param_00,"drillrestarts",0);
	self setplayerdata("cp","EoGPlayer",param_00,"drillplants",0);
	self setplayerdata("cp","EoGPlayer",param_00,"downs",0);
	self setplayerdata("cp","EoGPlayer",param_00,"deaths",0);
	self setplayerdata("cp","EoGPlayer",param_00,"hivesdestroyed",0);
	self setplayerdata("cp","EoGPlayer",param_00,"currency",0);
	self setplayerdata("cp","EoGPlayer",param_00,"currencyspent",0);
	self setplayerdata("cp","EoGPlayer",param_00,"currencytotal",0);
	self setplayerdata("cp","EoGPlayer",param_00,"tickets",0);
	self setplayerdata("cp","EoGPlayer",param_00,"ticketsspent",0);
	self setplayerdata("cp","EoGPlayer",param_00,"tickettotal",0);
	self setplayerdata("cp","EoGPlayer",param_00,"traps",0);
	self setplayerdata("cp","EoGPlayer",param_00,"deployables",0);
	self setplayerdata("cp","EoGPlayer",param_00,"deployablesused",0);
	self setplayerdata("cp","EoGPlayer",param_00,"consumablesearned",0);
	self setplayerdata("cp","EoGPlayer",param_00,"headShots",0);
}

//Function Number: 20
func_666D(param_00)
{
	if(scripts\cp\_endgame::func_7668())
	{
		return;
	}

	var_01 = param_00 getentitynumber();
	func_F6A0("EoGPlayer",var_01,"connected",0);
}

//Function Number: 21
func_666A(param_00,param_01,param_02)
{
	var_03 = self getentitynumber();
	var_04 = param_01;
	if(!isdefined(param_02) || !param_02)
	{
		var_05 = self getplayerdata("cp","EoGPlayer",var_03,param_00);
		var_04 = int(var_05) + int(param_01);
	}

	func_12887(param_00,var_04,1);
	if(var_03 == 4)
	{
		var_03 = 0;
	}

	func_F6A0("EoGPlayer",var_03,param_00,var_04);
}

//Function Number: 22
func_12887(param_00,param_01,param_02)
{
	var_03 = func_7AC0(param_00);
	if(!isdefined(var_03))
	{
		return;
	}

	func_AAC4(var_03,param_01,param_02);
}

//Function Number: 23
func_AAC4(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(param_02))
	{
		var_03 = param_01;
	}
	else
	{
		var_04 = self getplayerdata("cp","alienSession",param_01);
		var_03 = var_04 + param_01;
	}

	self setplayerdata("cp","alienSession",param_00,var_03);
}

//Function Number: 24
func_13CC6()
{
	self.var_CA6F = [];
	foreach(var_03, var_01 in level.var_4377)
	{
		if(strtok(var_03,"_")[0] == "weapon")
		{
			var_02 = func_7858(var_03);
			self.var_CA6F[var_02] = 1;
		}
	}

	thread func_D353();
}

//Function Number: 25
func_7858(param_00)
{
	var_01 = "";
	var_02 = strtok(param_00,"_");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(var_04 == "weapon" && var_03 == 0)
		{
			continue;
		}

		if(var_04 == "zm")
		{
			var_01 = var_01 + "zm";
			break;
		}

		if(var_03 < var_02.size - 1)
		{
			var_01 = var_01 + var_04 + "_";
			continue;
		}

		var_01 = var_01 + var_04;
		break;
	}

	if(var_01 == "")
	{
		return "none";
	}

	return var_01;
}

//Function Number: 26
func_13CD1(param_00,param_01)
{
	self setplayerdata("cp",param_00,param_01,"hits",0);
	self setplayerdata("cp",param_00,param_01,"shots",0);
	self setplayerdata("cp",param_00,param_01,"kills",0);
}

//Function Number: 27
func_12E4D(param_00,param_01,param_02)
{
	if(!func_9D0B(param_00,param_02))
	{
		return;
	}

	func_12E4C("weaponStats",param_00,"hits",param_01);
	var_03 = "personal";
	if(isdefined(level.var_CA74))
	{
		var_03 = level.var_CA74;
	}

	lib_0A54::func_12E04(var_03,"shots_hit",param_01);
}

//Function Number: 28
func_9D0B(param_00,param_01)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_01 == "MOD_MELEE")
	{
		return 0;
	}

	if(func_C01C(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 29
func_C01C(param_00)
{
	switch(param_00)
	{
		case "iw7_spiked_bat_zm_pap2":
		case "iw7_spiked_bat_zm_pap1":
		case "iw7_spiked_bat_zm":
		case "iw7_machete_zm_pap2":
		case "iw7_machete_zm_pap1":
		case "iw7_machete_zm":
		case "iw7_golf_club_zm_pap2":
		case "iw7_golf_club_zm_pap1":
		case "iw7_golf_club_zm":
		case "iw7_two_headed_axe_zm_pap2":
		case "iw7_two_headed_axe_zm_pap1":
		case "iw7_two_headed_axe_zm":
		case "iw7_katana_zm_pap2":
		case "iw7_katana_zm_pap1":
		case "iw7_nunchucks_zm_pap2":
		case "iw7_nunchucks_zm_pap1":
		case "iw7_katana_zm":
		case "iw7_nunchucks_zm":
		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 30
func_12E4F(param_00,param_01)
{
	if(!self.var_FFA9)
	{
		return;
	}

	func_12E4C("weaponStats",param_00,"shots",param_01);
	var_02 = "personal";
	if(isdefined(level.var_CA74))
	{
		var_02 = level.var_CA74;
	}

	lib_0A54::func_12E04(var_02,"shots_fired",param_01);
}

//Function Number: 31
func_12E4E(param_00,param_01)
{
	func_12E4C("weaponStats",param_00,"kills",param_01);
}

//Function Number: 32
func_12E4C(param_00,param_01,param_02,param_03)
{
	if(!isplayer(self))
	{
		return;
	}

	var_04 = func_7858(param_01);
	if(!isdefined(var_04) || !isdefined(self.var_CA6F[var_04]))
	{
		return;
	}

	if(isdefined(level.var_13C4C))
	{
		var_04 = [[ level.var_13C4C ]](var_04);
	}

	if(issubstr(var_04,"dlc"))
	{
		var_05 = strtok(var_04,"d");
		var_04 = var_05[0] + "DLC";
		var_05 = strtok(var_05[1],"c");
		var_04 = var_04 + var_05[1];
	}

	var_06 = int(self getplayerdata("cp",param_00,var_04,param_02));
	var_07 = var_06 + int(param_03);
	self setplayerdata("cp",param_00,var_04,param_02,var_07);
}

//Function Number: 33
func_D353()
{
	self endon("disconnect");
	self notify("weaponstats_track_shots");
	self endon("weaponstats_track_shots");
	for(;;)
	{
		self waittill("weapon_fired",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = 1;
		func_12E4F(var_00,var_01);
	}
}

//Function Number: 34
func_DCD1()
{
	if(!isdefined(level.var_13F4F))
	{
		level.var_13F4F = "cp/zombies/rankTable.csv";
	}

	level.var_13F4E = [];
	level.var_13F3E = int(tablelookup(level.var_13F4F,0,"maxrank",1));
	for(var_00 = 0;var_00 <= level.var_13F3E;var_00++)
	{
		var_01 = func_7C00(var_00);
		if(var_01 == "")
		{
			break;
		}

		if(!isdefined(level.var_13F4E[var_00]))
		{
			var_02 = spawnstruct();
			var_02.var_92B8 = var_00;
			var_02.var_DE3F = var_01;
			var_02.var_B111 = func_7A81(var_00);
			var_02.var_928E = func_7A25(var_00);
			var_02.var_119D4 = func_7D08(var_00);
			var_02.var_13E1A = [];
			var_02.var_13E1A["min"] = func_7AE7(var_00);
			var_02.var_13E1A["next"] = func_7B1D(var_00);
			var_02.var_13E1A["max"] = func_7AD1(var_00);
			var_02.name = [];
			var_02.name["short"] = func_7C65(var_00);
			var_02.name["full"] = func_79DB(var_00);
			var_02.name["ingame"] = func_7A3E(var_00);
			level.var_13F4E[var_00] = var_02;
		}
	}
}

//Function Number: 35
func_7C00(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,1);
}

//Function Number: 36
func_7AE7(param_00)
{
	return int(tablelookup(level.var_13F4F,0,param_00,2));
}

//Function Number: 37
func_7AD1(param_00)
{
	return int(tablelookup(level.var_13F4F,0,param_00,7));
}

//Function Number: 38
func_7B1D(param_00)
{
	return int(tablelookup(level.var_13F4F,0,param_00,3));
}

//Function Number: 39
func_7A81(param_00)
{
	return int(tablelookup(level.var_13F4F,0,param_00,14));
}

//Function Number: 40
func_7C65(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,4);
}

//Function Number: 41
func_79DB(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,5);
}

//Function Number: 42
func_7A3E(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,17);
}

//Function Number: 43
func_7A25(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,6);
}

//Function Number: 44
func_7D08(param_00)
{
	return int(tablelookup(level.var_13F4F,0,param_00,19));
}

//Function Number: 45
func_7C98(param_00)
{
	return tablelookup(level.var_13F4F,0,param_00,8);
}

//Function Number: 46
func_7BAA()
{
	return self getplayerdata("cp","progression","playerLevel","rank");
}

//Function Number: 47
func_7BB8()
{
	return self getplayerdata("cp","progression","playerLevel","xp");
}

//Function Number: 48
func_7BA9()
{
	return self getplayerdata("cp","progression","playerLevel","prestige");
}

//Function Number: 49
func_7BB0()
{
	return self getplayerdata("cp","alienSession","experience");
}

//Function Number: 50
func_F54A(param_00)
{
	self setplayerdata("cp","alienSession","experience",param_00);
}

//Function Number: 51
func_8310(param_00)
{
	var_01 = func_7BB0();
	var_02 = param_00 + var_01;
	func_F54A(var_02);
}

//Function Number: 52
func_7BAF()
{
	return self getplayerdata("cp","alienSession","shots");
}

//Function Number: 53
func_F549(param_00)
{
	self setplayerdata("cp","alienSession","shots",param_00);
}

//Function Number: 54
func_830F(param_00)
{
	var_01 = func_7BAF();
	var_02 = param_00 + var_01;
	func_F549(var_02);
}

//Function Number: 55
func_F548(param_00)
{
	self setplayerdata("cp","alienSession","ranked_up",int(param_00));
}

//Function Number: 56
func_7BAE()
{
	return self getplayerdata("cp","alienSession","ranked_up");
}

//Function Number: 57
func_12E0F(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = func_7BAE();
	var_02 = param_00 + var_01;
	func_F548(var_02);
}

//Function Number: 58
func_F545(param_00)
{
	self setplayerdata("cp","progression","playerLevel","rank",param_00);
}

//Function Number: 59
func_F552(param_00)
{
	self setplayerdata("cp","progression","playerLevel","xp",param_00);
	if(isdefined(self.var_11A3D))
	{
		self setplayerdata("common","round","totalXp",self.var_11A3D);
	}
}

//Function Number: 60
func_F543(param_00)
{
	self setplayerdata("cp","progression","playerLevel","prestige",param_00);
	self setplayerdata("cp","progression","playerLevel","xp",0);
	self setplayerdata("cp","progression","playerLevel","rank",0);
}

//Function Number: 61
func_7BF7(param_00)
{
	var_01 = 0;
	if(param_00 >= level.var_13F4E[level.var_13F3E].var_13E1A["max"])
	{
		return level.var_13F3E;
	}

	if(isdefined(level.var_13F4E))
	{
		for(var_02 = 0;var_02 < level.var_13F4E.size;var_02++)
		{
			if(param_00 >= level.var_13F4E[var_02].var_13E1A["min"])
			{
				if(param_00 < level.var_13F4E[var_02].var_13E1A["max"])
				{
					var_01 = level.var_13F4E[var_02].var_92B8;
					break;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 62
func_7C2B(param_00,param_01)
{
	return int(param_01 * func_7A84(param_00) * func_7D6B(param_00));
}

//Function Number: 63
func_7A84(param_00)
{
	if(isdefined(param_00.var_13E26))
	{
		return param_00.var_13E26;
	}

	return 1;
}

//Function Number: 64
func_1358C(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	wait(param_01);
	give_player_xp(param_00);
}

//Function Number: 65
func_7D6B(param_00)
{
	if(isdefined(param_00.var_13C37) && scripts\common\utility::istrue(param_00.kill_with_extra_xp_passive))
	{
		param_00.kill_with_extra_xp_passive = 0;
		return param_00.var_13C37;
	}

	return 1;
}

//Function Number: 66
give_player_xp(param_00,param_01)
{
	if(!level.onlinegame)
	{
		return;
	}

	param_00 = func_7C2B(self,param_00);
	if(isdefined(self.var_11A3D))
	{
		self.var_11A3D = self.var_11A3D + param_00;
		scripts\cp\zombies\zombie_analytics::func_AF87(param_00,self.var_11A3D,self,level.wave_num);
	}

	thread func_8310(param_00);
	var_02 = 0;
	var_03 = func_7BAA();
	var_04 = func_7BB8();
	var_05 = var_04 + param_00;
	func_F552(var_05);
	if(scripts\common\utility::istrue(param_01) && param_00 > 0)
	{
		self setclientomnvar("zom_xp_reward",param_00);
		self setclientomnvar("zom_xp_notify",gettime());
	}

	var_06 = func_7BF7(var_05);
	if(var_06 > var_03)
	{
		if(var_06 == level.var_13F3E + 1)
		{
			var_02 = 1;
		}

		func_F545(var_06);
		if(var_02 == 0)
		{
			var_07 = var_06 + 1;
			var_08 = func_7C98(var_06);
			thread scripts\cp\_hud_message::func_10151(var_08,var_07);
			self notify("ranked_up",var_06);
			func_12E0F();
		}

		self method_832D(func_7BAA(),func_7BA9());
		process_rank_merits(var_06);
	}
}

//Function Number: 67
process_rank_merits(param_00)
{
	scripts\cp\_merits::func_D9AD("mt_prestige_1");
	if(param_00 >= 40)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_2");
	}

	if(param_00 >= 60)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_3");
	}

	if(param_00 >= 80)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_4");
	}

	if(param_00 >= 100)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_5");
	}

	if(param_00 >= 120)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_6");
	}

	if(param_00 >= 140)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_7");
	}

	if(param_00 >= 160)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_8");
	}

	if(param_00 >= 180)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_9");
	}

	if(param_00 >= 200)
	{
		scripts\cp\_merits::func_D9AD("mt_prestige_10");
	}
}

//Function Number: 68
func_93CB(param_00,param_01,param_02)
{
	var_03 = self getplayerdata("cp",param_00,param_01);
	var_04 = var_03 + param_02;
	self setplayerdata("cp",param_00,param_01,var_04);
}

//Function Number: 69
func_93C9(param_00,param_01)
{
	func_93CB("alienSession",param_00,param_01);
}

//Function Number: 70
func_7A0E()
{
	return func_77FB("hivesDestroyed");
}

//Function Number: 71
func_77FB(param_00)
{
	return self getplayerdata("cp","alienSession",param_00);
}

//Function Number: 72
func_F2A3(param_00,param_01)
{
	self setplayerdata("cp","alienSession",param_00,param_01);
}

//Function Number: 73
func_12DAF(param_00)
{
	if(isdefined(level.var_12DB0))
	{
		param_00 [[ level.var_12DB0 ]]();
		return;
	}

	param_00 lib_0A54::func_12E04(lib_0A54::func_7CE6(),"team_support_deploy");
}

//Function Number: 74
func_12DDB(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 func_AAC4("challengesAttempted",1);
		if(param_00)
		{
			var_02 func_AAC4("challengesCompleted",1);
		}
	}
}

//Function Number: 75
func_12DDE(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 func_AAC4("waveNum",param_00,1);
	}
}

//Function Number: 76
func_12DDC(param_00,param_01)
{
	var_02 = func_7A76(param_01);
	foreach(var_04 in param_00)
	{
		var_04 func_AAC4("escapedRank" + var_02,1,1);
		var_04 func_AAC4("hits",1,1);
	}
}

//Function Number: 77
func_12D8D(param_00,param_01)
{
	if(!isdefined(param_01) || !isplayer(param_01))
	{
		return;
	}

	if(scripts\cp\_utility::func_9CEB(param_00))
	{
		param_01 func_AAC4("trapKills",1);
	}
}

//Function Number: 78
func_DEC0(param_00)
{
	level.var_6712 = param_00;
}

//Function Number: 79
func_7A76(param_00)
{
	for(var_01 = 0;var_01 < level.var_6712.size - 1;var_01++)
	{
		if(param_00 >= level.var_6712[var_01] && param_00 < level.var_6712[var_01 + 1])
		{
			return var_01;
		}
	}
}

//Function Number: 80
func_8C44(param_00)
{
	return issubstr(param_00,"[") && issubstr(param_00,"]");
}

//Function Number: 81
func_DFD7(param_00)
{
	var_01 = strtok(param_00,"]");
	return var_01[1];
}

//Function Number: 82
func_DEB5()
{
	var_00 = [];
	var_01["kills"] = "kills";
	var_01["deployables"] = "deployables";
	var_01["drillplants"] = "drillPlants";
	var_01["revives"] = "revives";
	var_01["downs"] = "downed";
	var_01["drillrestarts"] = "repairs";
	var_01["score"] = "score";
	var_01["currencyspent"] = "currencySpent";
	var_01["currencytotal"] = "currencyTotal";
	var_01["hivesdestroyed"] = "hivesDestroyed";
	var_01["waveNum"] = "waveNum";
	level.var_666C = var_01;
}

//Function Number: 83
func_7AC0(param_00)
{
	return level.var_666C[param_00];
}

//Function Number: 84
func_CE64()
{
	self endon("disconnect");
	for(;;)
	{
		wait(1);
		func_AAC4("time",1);
	}
}

//Function Number: 85
func_DDE9(param_00,param_01,param_02,param_03)
{
	if(scripts\cp\_utility::func_9E27(param_00,param_01,param_02,param_03))
	{
		increment_player_career_headshot_kills(param_03);
	}

	param_03 increment_player_career_kills(param_03);
	param_03 func_666A("kills",1);
}

//Function Number: 86
increment_player_career_total_waves(param_00)
{
	if(isdefined(param_00.wave_num_when_joined))
	{
		increment_zombiecareerstats(param_00,"Total_Waves",level.wave_num - param_00.wave_num_when_joined);
		return;
	}

	increment_zombiecareerstats(param_00,"Total_Waves",level.wave_num);
}

//Function Number: 87
increment_player_career_total_score(param_00)
{
	increment_zombiecareerstats(param_00,"Total_Score",param_00.score_earned);
}

//Function Number: 88
increment_player_career_shots_fired(param_00)
{
	increment_zombiecareerstats(param_00,"Shots_Fired",1);
}

//Function Number: 89
increment_player_career_shots_on_target(param_00)
{
	increment_zombiecareerstats(param_00,"Shots_on_Target",1);
}

//Function Number: 90
increment_player_career_explosive_kills(param_00)
{
	increment_zombiecareerstats(param_00,"Explosive_Kills",1);
}

//Function Number: 91
increment_player_career_doors_opened(param_00)
{
	increment_zombiecareerstats(param_00,"Doors_Opened",1);
}

//Function Number: 92
increment_player_career_perks_used(param_00)
{
	increment_zombiecareerstats(param_00,"Perks_Used",1);
}

//Function Number: 93
increment_player_career_kills(param_00)
{
	increment_zombiecareerstats(param_00,"Kills",1);
	updateleaderboardstats(param_00,"Kills",1,level.script,level.players.size,1);
}

//Function Number: 94
increment_player_career_headshot_kills(param_00)
{
	param_00 increment_zombiecareerstats(param_00,"Headshot_Kills",1);
	updateleaderboardstats(param_00,"Headshots",1,level.script,level.players.size,1);
}

//Function Number: 95
increment_player_career_revives(param_00)
{
	param_00 increment_zombiecareerstats(param_00,"Revives",1);
	updateleaderboardstats(param_00,"Revives",1,level.script,level.players.size,1);
}

//Function Number: 96
increment_player_career_downs(param_00)
{
	param_00 increment_zombiecareerstats(param_00,"Downs",1);
	updateleaderboardstats(param_00,"Downs",1,level.script,level.players.size,1);
}

//Function Number: 97
update_players_career_highest_wave(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		update_player_career_highest_wave(var_03,param_00,param_01,level.players.size);
	}
}

//Function Number: 98
update_player_career_highest_wave(param_00,param_01,param_02,param_03)
{
	updateifgreaterthan_zombiecareerstats(param_00,"Highest_Wave",param_01);
	update_highest_wave_lb(param_00,param_01,"Highest_Wave",param_02,param_03);
	updateleaderboardstats(param_00,"Rounds",param_01,param_02,param_03,1);
}

//Function Number: 99
increment_zombiecareerstats(param_00,param_01,param_02)
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = param_00 getplayerdata("cp","coopCareerStats",param_01);
	var_04 = var_03 + param_02;
	param_00 setplayerdata("cp","coopCareerStats",param_01,int(var_04));
}

//Function Number: 100
updateifgreaterthan_zombiecareerstats(param_00,param_01,param_02)
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	var_03 = param_00 getplayerdata("cp","coopCareerStats",param_01);
	if(param_02 > var_03)
	{
		param_00 setplayerdata("cp","coopCareerStats",param_01,param_02);
	}
}

//Function Number: 101
update_highest_wave_lb(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	var_05 = param_00 getplayerdata("cp","leaderboarddata",param_03,"leaderboardDataPerMap",param_04,param_02);
	if(param_01 > var_05)
	{
		param_00 setplayerdata("cp","leaderboarddata",param_03,"leaderboardDataPerMap",param_04,param_02,param_01);
	}
}

//Function Number: 102
updateleaderboardstats(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	var_06 = param_00 getplayerdata("cp","leaderboarddata",param_03,"leaderboardDataPerMap",param_04,param_01);
	param_02 = var_06 + param_05;
	if(param_02 > var_06)
	{
		param_00 setplayerdata("cp","leaderboarddata",param_03,"leaderboardDataPerMap",param_04,param_01,param_02);
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 465
 * Decompile Time: 21064 ms
 * Timestamp: 10/27/2023 12:30:26 AM
*******************************************************************/

//Function Number: 1
func_F7D0()
{
}

//Function Number: 2
func_12D01()
{
}

//Function Number: 3
func_F6DC()
{
}

//Function Number: 4
func_12CA9()
{
}

//Function Number: 5
func_F650()
{
	if(!isplayer(self))
	{
		return;
	}

	func_2694();
	func_2695();
}

//Function Number: 6
func_2695()
{
	self waittill("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	self method_8021();
}

//Function Number: 7
func_12C76()
{
	if(!isplayer(self))
	{
		return;
	}

	self notify("endAutoSpotAdsWatcher");
	self method_8021();
}

//Function Number: 8
func_2694()
{
	self endon("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		if(self isusingturret())
		{
			self method_8021();
			continue;
		}

		var_01 = self method_822E();
		if(var_01 < 1 && var_00)
		{
			var_00 = 0;
			self method_8021();
		}

		if(var_01 < 1 && !var_00)
		{
			continue;
		}

		if(var_01 == 1 && !var_00)
		{
			var_00 = 1;
			self method_8022();
		}
	}
}

//Function Number: 9
func_F81B()
{
	self.var_11B2C = "specialty_regenfaster";
}

//Function Number: 10
func_12D19()
{
	self.var_11B2C = undefined;
}

//Function Number: 11
func_11906()
{
	self.var_8C1A = undefined;
	scripts\mp\_utility::func_E150("specialty_regenfaster");
	self setclientdvar("ui_regen_faster_end_milliseconds",0);
	self notify("timeOutRegenFaster");
}

//Function Number: 12
func_F73A()
{
	self.var_FC6B = 0.25;
}

//Function Number: 13
func_12CCC()
{
	self.var_FC6B = 0;
}

//Function Number: 14
func_F83C()
{
	thread func_BA14();
}

//Function Number: 15
func_BA14()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_monitorSharpFocus");
	for(;;)
	{
		func_12F1A();
		self waittill("weapon_change");
	}
}

//Function Number: 16
func_12F1A()
{
	var_00 = self getcurrentweapon();
	var_01 = undefined;
	if(level.tactical)
	{
		if(weaponclass(var_00) == "sniper")
		{
			var_01 = 0.85;
		}
		else
		{
			var_01 = 0.5;
		}
	}
	else if(weaponclass(var_00) == "sniper")
	{
		var_01 = 0.85;
	}
	else
	{
		var_01 = 0.25;
	}

	scripts\mp\_weapons::func_12F58(var_01);
}

//Function Number: 17
func_12D29()
{
	self notify("stop_monitorSharpFocus");
	scripts\mp\_weapons::func_12F58(1);
}

//Function Number: 18
func_FB0D()
{
	self.var_C826 = 0.2;
	self.overrideviewkickscalesniper = 0.425;
	scripts\mp\_weapons::func_12F58();
}

//Function Number: 19
func_12D64()
{
	self.var_C826 = undefined;
	self.overrideviewkickscalesniper = undefined;
	scripts\mp\_weapons::func_12F58();
}

//Function Number: 20
func_F633()
{
	self.var_13C70 = 0.08;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 21
func_12C6D()
{
	self.var_13C70 = undefined;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 22
func_F632()
{
	self.var_13C6E = 1;
	var_00 = scripts\mp\_class::func_3224(self.var_AE7F,self.var_AE86,self.var_AE88,self.var_AE90,self.var_AE91);
	var_01 = scripts\mp\_class::func_3224(self.var_AE94,self.var_AE9A,self.var_AE9C,self.var_AEA4,self.var_AEA5);
	if(scripts\mp\_utility::func_8225(var_00) == "weapon_projectile")
	{
		self setweaponammoclip(var_00,weaponclipsize(var_00));
	}

	if(scripts\mp\_utility::func_8225(var_01) == "weapon_projectile")
	{
		self setweaponammoclip(var_01,weaponclipsize(var_01));
	}
}

//Function Number: 23
func_12C6C()
{
	self.var_13C6E = undefined;
}

//Function Number: 24
func_F6D7()
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
					self setweaponammoclip(var_02,var_04);
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammoclip(var_02,var_03 + var_06);
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

//Function Number: 25
func_12CA8()
{
	self notify("endDoubleLoad");
}

//Function Number: 26
func_F78F(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}
	else
	{
		param_00 = int(param_00) * 2;
	}

	scripts\mp\_utility::setrecoilscale(param_00);
	self.recoilscale = param_00;
}

//Function Number: 27
func_12CEC()
{
	scripts\mp\_utility::setrecoilscale(0);
	self.recoilscale = 0;
}

//Function Number: 28
setfastcrouch()
{
	thread watchfastcrouch();
}

//Function Number: 29
watchfastcrouch()
{
	self endon("death");
	self endon("disconnect");
	self endon("fastcrouch_unset");
	for(;;)
	{
		var_00 = self getstance() == "crouch" && !self method_81BE();
		if(!isdefined(self.fastcrouchspeedmod))
		{
			if(var_00)
			{
				self.fastcrouchspeedmod = 0.3;
				scripts\mp\_weapons::func_12ED5();
			}
		}
		else if(!var_00)
		{
			self.fastcrouchspeedmod = undefined;
			scripts\mp\_weapons::func_12ED5();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 30
unsetfastcrouch()
{
	self notify("fastcrouch_unset");
	if(isdefined(self.fastcrouchspeedmod))
	{
		self.fastcrouchspeedmod = undefined;
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 31
func_F821()
{
	self endon("unsetRShieldRadar");
	wait(0.75);
	self method_81F3();
	thread func_F822();
}

//Function Number: 32
func_F822()
{
	self endon("unsetRShieldRadar");
	scripts\common\utility::waittill_any_3("disconnect","death");
	if(isdefined(self))
	{
		func_12D1D();
	}
}

//Function Number: 33
func_12D1D()
{
	self method_8079();
	self notify("unsetRShieldRadar");
}

//Function Number: 34
func_F823()
{
	self method_81F4();
	thread func_F824();
}

//Function Number: 35
func_F824()
{
	self endon("unsetRShieldScrambler");
	scripts\common\utility::waittill_any_3("disconnect","death");
	if(isdefined(self))
	{
		func_12D1E();
	}
}

//Function Number: 36
func_12D1E()
{
	self method_807C();
	self notify("unsetRShieldScrambler");
}

//Function Number: 37
func_F869(param_00)
{
	scripts\mp\_utility::func_8387("specialty_hard_shell");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	param_00 = int(param_00);
	if(param_00 == 10)
	{
		self.stunscalar = 0;
		return;
	}

	self.stunscalar = param_00 / 10;
}

//Function Number: 38
func_12D3C()
{
	self.stunscalar = 1;
}

//Function Number: 39
func_20E0(param_00,param_01,param_02)
{
	if(param_01 scripts\mp\_utility::_hasperk("specialty_stun_resistance"))
	{
		if(isdefined(param_01.stunscalar) && isdefined(param_02))
		{
			param_02 = param_02 * param_01.stunscalar;
		}

		var_03 = scripts\common\utility::func_116D7(isdefined(param_00.var_222),param_00.var_222,param_00);
		var_04 = scripts\common\utility::func_116D7(isdefined(param_01.var_222),param_01.var_222,param_01);
		if(isplayer(var_03) && var_03 != param_01)
		{
			param_00 scripts\mp\_damagefeedback::func_12E84("hittacresist",undefined,undefined,undefined,1);
		}

		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_03,var_04)))
		{
			param_01 scripts\mp\_missions::func_E280(var_03);
		}
	}

	return param_02;
}

//Function Number: 40
func_FB17()
{
	if(isagent(self))
	{
		return;
	}

	self endon("unsetWeaponLaser");
	wait(0.5);
	thread func_FB18();
}

//Function Number: 41
func_12D68()
{
	self notify("unsetWeaponLaser");
	if(isdefined(self.var_CA6A) && self.var_CA6A)
	{
		scripts\mp\_utility::func_561C();
	}

	self.var_CA6A = undefined;
	self.var_CA69 = undefined;
}

//Function Number: 42
func_FB1C(param_00)
{
	for(;;)
	{
		param_00 = getweaponbasename(param_00);
		if(isdefined(param_00) && param_00 == "iw6_kac_mp" || param_00 == "iw6_arx160_mp")
		{
			break;
		}

		self waittill("weapon_change",param_00);
	}
}

//Function Number: 43
func_FB18()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetWeaponLaser");
	self.var_CA6A = 0;
	var_00 = self getcurrentweapon();
	for(;;)
	{
		func_FB1C(var_00);
		if(self.var_CA6A == 0)
		{
			self.var_CA6A = 1;
			scripts\mp\_utility::func_6282();
		}

		childthread func_FB19();
		childthread func_FB1A(1);
		self.var_CA69 = undefined;
		self waittill("weapon_change",var_00);
		if(self.var_CA6A == 1)
		{
			self.var_CA6A = 0;
			scripts\mp\_utility::func_561C();
		}
	}
}

//Function Number: 44
func_FB1A(param_00)
{
	self endon("weapon_change");
	for(;;)
	{
		self waittill("weapon_switch_started");
		childthread func_FB1B(param_00);
	}
}

//Function Number: 45
func_FB1B(param_00)
{
	self notify("setWeaponLaser_onWeaponSwitchStart");
	self endon("setWeaponLaser_onWeaponSwitchStart");
	if(self.var_CA6A == 1)
	{
		self.var_CA69 = 1;
		self.var_CA6A = 0;
		scripts\mp\_utility::func_561C();
	}

	wait(param_00);
	self.var_CA69 = undefined;
	if(self.var_CA6A == 0 && self method_822E() <= 0.6)
	{
		self.var_CA6A = 1;
		scripts\mp\_utility::func_6282();
	}
}

//Function Number: 46
func_FB19()
{
	self endon("weapon_change");
	for(;;)
	{
		if(!isdefined(self.var_CA69) || self.var_CA69 == 0)
		{
			if(self method_822E() > 0.6)
			{
				if(self.var_CA6A == 1)
				{
					self.var_CA6A = 0;
					scripts\mp\_utility::func_561C();
				}
			}
			else if(self.var_CA6A == 0)
			{
				self.var_CA6A = 1;
				scripts\mp\_utility::func_6282();
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 47
func_F860()
{
	self method_829B(0.5);
}

//Function Number: 48
func_12D37()
{
	self notify("end_SteadyAimPro");
	self method_829B(1);
}

//Function Number: 49
func_2B69(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("end_perkUseTracker");
	level endon("game_ended");
	for(;;)
	{
		self waittill("empty_offhand");
		if(!scripts\common\utility::func_9EC1())
		{
			continue;
		}

		self [[ param_01 ]](scripts\mp\_utility::_hasperk("specialty_blastshield"));
	}
}

//Function Number: 50
func_CA67()
{
	self endon("disconnect");
	self waittill("death");
	self.var_1439 = undefined;
}

//Function Number: 51
func_F6DE()
{
	if(isdefined(self.endgame))
	{
		return;
	}

	self.maxhealth = scripts\mp\_tweakables::func_81E7("player","maxhealth") * 4;
	self.health = self.maxhealth;
	self.endgame = 1;
	self.var_250E[0] = "";
	self visionsetnakedforplayer("end_game",5);
	thread func_6325(7);
	scripts\mp\_gamelogic::func_F73B(self,1);
}

//Function Number: 52
func_12CAA()
{
	self notify("stopEndGame");
	self.endgame = undefined;
	scripts\mp\_utility::func_E2D8(1);
	if(!isdefined(self.var_632B))
	{
		return;
	}

	self.var_632B scripts\mp\_hud_util::destroyelem();
	self.var_6328 scripts\mp\_hud_util::destroyelem();
}

//Function Number: 53
func_6325(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait(param_00 + 1);
	scripts\mp\_utility::func_1417();
}

//Function Number: 54
func_F827()
{
	self.var_C2AD = 1.2;
}

//Function Number: 55
func_12D21()
{
	self.var_C2AD = 1;
}

//Function Number: 56
func_F698()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetCombatSpeed");
	self.var_93CF = 0;
	func_12C96();
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isdefined(var_01.team))
		{
			continue;
		}

		if(level.teambased && var_01.team == self.team)
		{
			continue;
		}

		if(self.var_93CF)
		{
			continue;
		}

		func_F699();
		self.var_93CF = 1;
		thread func_636C();
	}
}

//Function Number: 57
func_636C()
{
	self notify("endOfSpeedWatcher");
	self endon("endOfSpeedWatcher");
	self endon("death");
	self endon("disconnect");
	self waittill("healed");
	func_12C96();
	self.var_93CF = 0;
}

//Function Number: 58
func_F699()
{
	if(isdefined(self.var_9E59) && self.var_9E59)
	{
		return;
	}

	if(self.var_13CCF <= 0.8)
	{
		self.var_440B = 1.4;
	}
	else if(self.var_13CCF <= 0.9)
	{
		self.var_440B = 1.3;
	}
	else
	{
		self.var_440B = 1.2;
	}

	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 59
func_12C96()
{
	self.var_440B = 1;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 60
func_12C95()
{
	func_12C96();
	self notify("unsetCombatSpeed");
}

//Function Number: 61
func_F788()
{
	if(!isdefined(self.var_47ED))
	{
		self.var_BCF6 = scripts\mp\_utility::func_ACD8();
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 62
func_12CE6()
{
	self.var_BCF6 = 1;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 63
func_F663()
{
	self.killstreakscaler = 1.5;
}

//Function Number: 64
func_12C7F()
{
	self.killstreakscaler = 1;
}

//Function Number: 65
func_F862()
{
	scripts\mp\_utility::func_8387("specialty_bulletaccuracy");
	scripts\mp\_utility::func_8387("specialty_holdbreath");
}

//Function Number: 66
func_12D39()
{
	scripts\mp\_utility::func_E150("specialty_bulletaccuracy");
	scripts\mp\_utility::func_E150("specialty_holdbreath");
}

//Function Number: 67
func_F6C1()
{
}

//Function Number: 68
func_12CA1()
{
}

//Function Number: 69
func_F78A()
{
	if(!scripts\mp\killstreaks\_emp_common::isemped())
	{
		self method_81F4();
	}
}

//Function Number: 70
func_12CE9()
{
	self method_807C();
}

//Function Number: 71
func_F885()
{
	self thermalvisionon();
}

//Function Number: 72
func_12D49()
{
	self thermalvisionoff();
}

//Function Number: 73
func_F7C6()
{
	thread func_C50C();
}

//Function Number: 74
func_12CF9()
{
	self notify("stop_oneManArmyTracker");
}

//Function Number: 75
func_C50C()
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

		thread func_F1CC();
	}
}

//Function Number: 76
func_9EC5(param_00)
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

//Function Number: 77
func_F1CC()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::func_1C76(0);
	scripts\common\utility::func_1C58(0);
	scripts\common\utility::func_1C6E(0);
	thread func_4293();
	self waittill("menuresponse",var_00,var_01);
	scripts\common\utility::func_1C76(1);
	scripts\common\utility::func_1C58(1);
	scripts\common\utility::func_1C6E(1);
	if(var_01 == "back" || !func_9EC5(var_00) || scripts\mp\_utility::func_9FC6())
	{
		if(self getcurrentweapon() == "onemanarmy_mp")
		{
			scripts\common\utility::func_1C76(0);
			scripts\common\utility::func_1C58(0);
			scripts\common\utility::func_1C6E(0);
			scripts\mp\_utility::_switchtoweapon(scripts\common\utility::getlastweapon());
			self waittill("weapon_change");
			scripts\common\utility::func_1C76(1);
			scripts\common\utility::func_1C58(1);
			scripts\common\utility::func_1C6E(1);
		}

		return;
	}

	thread func_8384(var_01);
}

//Function Number: 78
func_4293()
{
	self endon("menuresponse");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	scripts\common\utility::func_1C76(1);
	scripts\common\utility::func_1C58(1);
	scripts\common\utility::func_1C6E(1);
}

//Function Number: 79
func_8384(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(scripts\mp\_utility::_hasperk("specialty_omaquickchange"))
	{
		var_01 = 3;
		scripts\mp\_utility::func_D4FB(self,"foly_onemanarmy_bag3_plr","foly_onemanarmy_bag3_npc");
	}
	else
	{
		var_01 = 6;
		scripts\mp\_utility::func_D4FB(self,"foly_onemanarmy_bag6_plr","foly_onemanarmy_bag6_npc");
	}

	thread func_C4A0(var_01);
	scripts\common\utility::allow_weapon(0);
	scripts\common\utility::func_1C58(0);
	scripts\common\utility::func_1C6E(0);
	wait(var_01);
	scripts\common\utility::allow_weapon(1);
	scripts\common\utility::func_1C58(1);
	scripts\common\utility::func_1C6E(1);
	self.var_C47E = 1;
	scripts\mp\_class::func_8379(self.pers["team"],param_00);
	if(isdefined(self.var_3AF4))
	{
		self attach(self.var_3AF4,"J_spine4",1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

//Function Number: 80
func_C4A0(param_00)
{
	self endon("disconnect");
	var_01 = scripts\mp\_hud_util::createprimaryprogressbar();
	var_02 = scripts\mp\_hud_util::createprimaryprogressbartext();
	var_02 settext(&"MPUI_CHANGING_KIT");
	var_01 scripts\mp\_hud_util::updatebar(0,1 / param_00);
	var_03 = 0;
	while(var_03 < param_00 && isalive(self) && !level.var_7669)
	{
		wait(0.05);
		var_03 = var_03 + 0.05;
	}

	var_01 scripts\mp\_hud_util::destroyelem();
	var_02 scripts\mp\_hud_util::destroyelem();
}

//Function Number: 81
func_F634()
{
	self.var_11B2C = "specialty_afterburner";
	self method_8434(0,scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),600,650));
	self method_8430(0,scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),900,900));
}

//Function Number: 82
func_12C6E()
{
	self.var_11B2C = undefined;
	self method_8434(0,400);
	self method_8430(0,900);
}

//Function Number: 83
func_F667()
{
	self method_8376("primaryoffhand","icon_perks_blast_shield");
}

//Function Number: 84
func_12C82()
{
	self method_8376("primaryoffhand","none");
}

//Function Number: 85
func_F719()
{
}

//Function Number: 86
func_12CC1()
{
}

//Function Number: 87
func_F870()
{
	var_00 = "secondary";
	var_01 = scripts\mp\_powers::func_808C(var_00);
	if(isdefined(var_01))
	{
		scripts\mp\_powers::func_E15E(var_01);
	}

	scripts\mp\_powers::func_8397("power_tacInsert",var_00,0);
	thread func_BA34();
}

//Function Number: 88
func_12D41()
{
	self notify("end_monitorTIUse");
}

//Function Number: 89
func_41D2()
{
	scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	if(isdefined(self.var_F851))
	{
		func_51D7(self.var_F851);
	}
}

//Function Number: 90
func_12F47()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	while(scripts\mp\_utility::func_9F19(self))
	{
		if(func_9FE9())
		{
			self.var_11947 = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 91
func_9FE9()
{
	if(canspawn(self.origin) && self isonground() && !scripts\mp\_utility::func_11A44())
	{
		return 1;
	}

	return 0;
}

//Function Number: 92
func_11899(param_00)
{
	if(scripts\mp\_utility::func_9F19(param_00.var_222))
	{
		param_00.var_222 func_51D7(self);
	}
}

//Function Number: 93
func_BA34()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	thread func_12F47();
	thread func_41D2();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 != "flare_mp")
		{
			continue;
		}

		if(isdefined(self.var_F851))
		{
			func_51D7(self.var_F851);
		}

		if(!isdefined(self.var_11947))
		{
			continue;
		}

		if(scripts\mp\_utility::touchingbadtrigger())
		{
			continue;
		}

		var_02 = self.var_11947 + (0,0,16);
		var_03 = self.var_11947 - (0,0,2048);
		var_04 = playerphysicstrace(var_02,var_03) + (0,0,1);
		var_05 = [];
		var_05[0] = self;
		var_06 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
		var_07 = scripts\common\trace::func_DCED(var_02,var_03,var_05,var_06,0);
		var_08 = spawn("script_model",var_04);
		var_08.angles = self.angles;
		var_08.team = self.team;
		var_08.var_222 = self;
		var_08.var_6578 = spawn("script_origin",var_04);
		var_08 thread func_83EC(self);
		var_08.var_D424 = self.var_11947;
		var_08 method_831F(self);
		var_08 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static",self);
		var_08 scripts\mp\_weapons::func_69FF(var_07["entity"]);
		scripts\mp\_weapons::func_C5AC(var_08);
		self.var_F851 = var_08;
	}
}

//Function Number: 94
func_83EC(param_00)
{
	self setmodel(level.var_108D3["enemy"]);
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877(self.team,(0,0,20));
	}
	else
	{
		scripts\mp\_entityheadicons::func_F7F2(param_00,(0,0,20));
	}

	thread func_83E8(param_00);
	thread func_83E9(param_00);
	thread func_83EE(param_00);
	thread func_83EF(param_00);
	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01 setmodel(level.var_108D3["friendly"]);
	var_01 method_82C7(0);
	var_01 linkto(self);
	var_01 playloopsound("tactical_insert_lp");
	thread func_83ED(self,var_01,param_00);
	self waittill("death");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 95
func_83ED(param_00,param_01,param_02)
{
	param_00 endon("death");
	wait(0.05);
	var_03 = [];
	var_03["enemy"] = param_00;
	var_03["friendly"] = param_01;
	for(;;)
	{
		foreach(var_05 in var_03)
		{
			var_05 hide();
		}

		foreach(var_08 in level.players)
		{
			var_09 = "friendly";
			if(param_02 scripts\mp\_utility::func_9DD6(var_08))
			{
				var_09 = "enemy";
			}

			var_05 = var_03[var_09];
			var_05 show();
			scripts\common\utility::func_136F7();
			playfxontagforclients(level.var_108D2[var_09],var_05,"tag_fx",var_08);
		}

		level waittill("joined_team");
		foreach(var_09, var_05 in var_03)
		{
			stopfxontag(level.var_108D2[var_09],var_05,"tag_fx");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 96
func_51BF(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 97
func_83E8(param_00)
{
	scripts\mp\_damage::func_B9C6(100,"tactical_insertion",::func_83EB,::func_83EA,1);
}

//Function Number: 98
func_83EB(param_00,param_01,param_02,param_03,param_04)
{
	return scripts\mp\_damage::func_89C3(param_01,param_02);
}

//Function Number: 99
func_83EA(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 notify("destroyed_insertion",self.var_222);
		param_00 notify("destroyed_equipment");
		self.var_222 thread scripts\mp\_utility::func_AAEC("ti_destroyed",undefined,undefined,self.origin);
	}

	param_00 thread func_51D7(self);
}

//Function Number: 100
func_83EE(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_TI");
	thread func_12E8B(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 playsound("tactical_insert_flare_pu");
		if(!var_01 scripts\mp\_utility::func_9E59())
		{
			var_01 thread func_F870();
		}

		var_01 thread func_51D7(self);
	}
}

//Function Number: 101
func_12E8B(param_00)
{
	self endon("death");
	for(;;)
	{
		scripts\mp\_utility::func_F838(param_00);
		level scripts\common\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 102
func_83EF(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	thread func_51D7(self);
}

//Function Number: 103
func_51D7(param_00)
{
	if(isdefined(param_00.var_6578))
	{
		param_00.var_6578 delete();
	}

	var_01 = param_00.origin;
	var_02 = param_00.angles;
	var_03 = param_00 getlinkedparent();
	param_00 delete();
	var_04 = spawn("script_model",var_01);
	var_04.angles = var_02;
	var_04 setmodel(level.var_108D3["friendly"]);
	var_04 method_82C7(0);
	if(isdefined(var_03))
	{
		var_04 linkto(var_03);
	}

	thread func_5F2B(var_04);
}

//Function Number: 104
func_5F2B(param_00)
{
	wait(1);
	stopfxontag(level.var_108D2["friendly"],param_00,"tag_fx");
	stopfxontag(level.var_108D2["enemy"],param_00,"tag_fx");
	param_00 delete();
}

//Function Number: 105
func_83E9(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self.var_6578 setcursorhint("HINT_NOICON");
	self.var_6578 sethintstring(&"MP_PATCH_DESTROY_TI");
	self.var_6578 scripts\mp\_utility::func_B2A0(param_00);
	for(;;)
	{
		self.var_6578 waittill("trigger",var_01);
		var_01 notify("destroyed_insertion",param_00);
		var_01 notify("destroyed_equipment");
		if(isdefined(param_00) && var_01 != param_00)
		{
			param_00 thread scripts\mp\_utility::func_AAEC("ti_destroyed",undefined,undefined,self.origin);
		}

		var_01 thread func_51D7(self);
	}
}

//Function Number: 106
func_F7D5(param_00)
{
	if(isplayer(self))
	{
		var_01 = 0.5;
		if(!scripts\mp\_utility::_hasperk("specialty_engineer") && !scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
		{
			self.var_C881 = 1;
			var_02 = scripts\mp\_utility::func_C794(self,"orange",param_00,0,0,"perk");
			thread func_13AE8(var_02,var_01);
			thread func_13AE9(var_02);
		}
	}
}

//Function Number: 107
func_13AE8(param_00,param_01)
{
	self notify("painted_again");
	self endon("painted_again");
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_1(param_01,"death");
	self.var_C881 = 0;
	scripts\mp\_utility::func_C78F(param_00,self);
	self notify("painted_end");
}

//Function Number: 108
func_13AE9(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("painted_again","painted_end");
	scripts\mp\_utility::func_C78F(param_00,self);
}

//Function Number: 109
func_9ED2()
{
	return isdefined(self.var_C881) && self.var_C881;
}

//Function Number: 110
func_F64B()
{
}

//Function Number: 111
func_12C71()
{
}

//Function Number: 112
func_F819()
{
	if(isdefined(self.var_D8D6))
	{
		self givemaxammo(self.var_D8D6);
	}

	if(isdefined(self.var_F0BB))
	{
		self givemaxammo(self.var_F0BB);
	}
}

//Function Number: 113
func_12D17()
{
}

//Function Number: 114
func_F818()
{
	if(isdefined(self.var_D8E1))
	{
		self givemaxammo(self.var_D8E1);
	}

	if(isdefined(self.var_F0C4))
	{
		self givemaxammo(self.var_F0C4);
	}
}

//Function Number: 115
func_12D16()
{
}

//Function Number: 116
func_F737()
{
	thread func_F738();
}

//Function Number: 117
func_F738()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("unsetGunsmith");
	self waittill("giveLoadout");
	if(self.var_AE86.size == 0 && self.var_AE9A.size == 0)
	{
		return;
	}

	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		if(scripts\mp\_utility::func_9E6C(var_00))
		{
			continue;
		}

		if(!scripts\mp\_utility::isstrstart(var_00,"iw6_") && !scripts\mp\_utility::isstrstart(var_00,"iw7_"))
		{
			continue;
		}

		var_01 = undefined;
		if(scripts\mp\_utility::func_8225(var_00) == "weapon_pistol")
		{
			if(self.var_AE9A.size > 0)
			{
				var_01 = self.var_AE9A;
			}
		}
		else if(self.var_AE86.size > 0)
		{
			var_01 = self.var_AE86;
		}

		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = 0;
		var_03 = scripts\mp\_utility::func_821A(var_00);
		if(var_03.size == 0)
		{
			var_02 = 1;
		}
		else
		{
			foreach(var_05 in var_01)
			{
				if(!scripts\common\utility::func_2286(var_03,var_05))
				{
					var_02 = 1;
					break;
				}
			}
		}

		if(!var_02)
		{
			continue;
		}

		var_07 = [];
		var_08 = scripts\mp\_utility::func_8217(var_00);
		foreach(var_05 in var_01)
		{
			if(scripts\common\utility::func_2286(var_08,var_05))
			{
				var_07[var_07.size] = var_05;
			}
		}

		var_01 = var_07;
		var_0B = [];
		foreach(var_0D in var_03)
		{
			var_0E = 1;
			foreach(var_10 in var_01)
			{
				if(!scripts\mp\_utility::func_249D(var_10,var_0D))
				{
					var_0E = 0;
					break;
				}
			}

			if(var_0E)
			{
				var_0B[var_0B.size] = var_0D;
			}
		}

		var_03 = var_0B;
		var_13 = var_01.size + var_03.size;
		if(var_13 > 4)
		{
			var_03 = scripts\common\utility::array_randomize(var_03);
		}

		for(var_14 = 0;var_01.size < 4 && var_14 < var_03.size;var_14++)
		{
			var_01[var_01.size] = var_03[var_14];
		}

		var_15 = getweaponbasename(var_00);
		var_16 = var_15;
		foreach(var_14, var_05 in var_01)
		{
			var_18 = scripts\mp\_utility::func_2496(var_05,var_00);
			var_01[var_14] = var_18;
		}

		var_01 = scripts\common\utility::func_1D3A(var_01);
		foreach(var_05 in var_01)
		{
			var_16 = var_16 + "_" + var_05;
		}

		if(var_16 != var_15)
		{
			var_1B = self getweaponammoclip(var_00);
			var_1C = self getweaponammostock(var_00);
			scripts\mp\_utility::func_141E(var_00);
			self giveweapon(var_16);
			self setweaponammoclip(var_16,var_1B);
			self setweaponammostock(var_16,var_1C);
			scripts\mp\_utility::_switchtoweapon(var_16);
		}
	}
}

//Function Number: 118
func_12CCB()
{
	self notify("unsetGunsmith");
}

//Function Number: 119
func_F71F()
{
	self setclientomnvar("ui_gambler_show",-1);
	func_F720();
}

//Function Number: 120
func_F720()
{
}

//Function Number: 121
func_765A()
{
	if(!isai(self))
	{
		return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",self.var_4006,"abilitiesPicked",scripts\mp\_utility::func_7D91(6,0));
	}
	else
	{
		var_00 = [];
		if(isdefined(self.pers["loadoutPerks"]))
		{
			var_00 = scripts\common\utility::array_combine(var_00,self.pers["loadoutPerks"]);
		}

		foreach(var_02 in var_00)
		{
			if(scripts\mp\_utility::func_7DF6(var_02) == "specialty_gambler")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 122
func_8367(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetGambler");
	level endon("game_ended");
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		scripts\mp\_utility::func_7670("prematch_done");
	}
	else if(scripts\mp\_utility::func_766C("prematch_done") && self.var_110F4 != "specialist")
	{
		self waittill("giveLoadout");
	}

	if(!isdefined(self.var_1519))
	{
		self.var_1519 = 0;
	}

	if(!self.var_1519)
	{
		var_01 = func_80AD(param_00);
		self.var_7658 = var_01;
	}
	else
	{
		var_01 = self.var_7658;
	}

	scripts\mp\_utility::func_8387(var_01.var_92B8);
	if(var_01.var_92B8 == "specialty_hardline")
	{
		scripts\mp\killstreaks\_killstreaks::func_F866();
	}

	if(func_1012B())
	{
		self playlocalsound("mp_suitcase_pickup");
		self setclientomnvar("ui_gambler_show",var_01.var_E76D);
		thread func_7659();
	}

	if(level.gametype != "infect")
	{
		self.var_1519 = 1;
	}
}

//Function Number: 123
func_1012B()
{
	var_00 = 1;
	if(!level.ingraceperiod && self.var_1519)
	{
		var_00 = 0;
	}

	if(!scripts\mp\_utility::func_1C7D() && level.gametype != "infect")
	{
		var_00 = 0;
	}

	return var_00;
}

//Function Number: 124
func_7659()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetGambler");
	level endon("game_ended");
	self waittill("luinotifyserver",var_00,var_01);
	if(var_00 == "gambler_anim_complete")
	{
		self setclientomnvar("ui_gambler_show",-1);
	}
}

//Function Number: 125
func_80AD(param_00)
{
	var_01 = [];
	var_01 = thread func_10437(param_00);
	var_01 = thread func_F674(var_01);
	var_02 = randomint(level.var_151A["sum"]);
	var_03 = undefined;
	foreach(var_05 in var_01)
	{
		if(!var_05.var_13CE8 || var_05.var_92B8 == "specialty_gambler")
		{
			continue;
		}

		if(var_05.var_13CE8 > var_02)
		{
			var_03 = var_05;
			break;
		}
	}

	return var_03;
}

//Function Number: 126
func_10437(param_00)
{
	var_01 = [];
	var_02 = [];
	for(var_03 = 1;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03].var_13CE8;
		var_01 = param_00[var_03];
		for(var_05 = var_03 - 1;var_05 >= 0 && func_9D1D(param_00[var_05].var_13CE8,var_04);var_05--)
		{
			var_02 = param_00[var_05];
			param_00[var_05] = var_01;
			param_00[var_05 + 1] = var_02;
		}
	}

	return param_00;
}

//Function Number: 127
func_9D1D(param_00,param_01)
{
	return param_00 < param_01;
}

//Function Number: 128
func_F674(param_00)
{
	level.var_151A["sum"] = 0;
	foreach(var_02 in param_00)
	{
		if(!var_02.var_13CE8)
		{
			continue;
		}

		level.var_151A["sum"] = level.var_151A["sum"] + var_02.var_13CE8;
		var_02.var_13CE8 = level.var_151A["sum"];
	}

	return param_00;
}

//Function Number: 129
func_12CC5()
{
	self notify("unsetGambler");
}

//Function Number: 130
func_F69B()
{
}

//Function Number: 131
func_12C97()
{
}

//Function Number: 132
func_F871()
{
	thread func_F872();
}

//Function Number: 133
func_F872()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetTagger");
	level endon("game_ended");
	for(;;)
	{
		self waittill("eyesOn");
		var_00 = self method_8156();
		foreach(var_02 in var_00)
		{
			if(level.teambased && var_02.team == self.team)
			{
				continue;
			}

			if(isalive(var_02) && var_02.sessionstate == "playing")
			{
				if(!isdefined(var_02.var_CA55))
				{
					var_02.var_CA55 = 0;
				}

				if(!var_02.var_CA55)
				{
					var_02.var_CA55 = 1;
				}

				var_02 thread func_C7B2(self);
			}
		}
	}
}

//Function Number: 134
func_C7B2(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("eyesOff");
	level endon("game_ended");
	for(;;)
	{
		var_01 = 1;
		var_02 = param_00 method_8156();
		foreach(var_04 in var_02)
		{
			if(var_04 == self)
			{
				var_01 = 0;
				break;
			}
		}

		if(var_01)
		{
			self.var_CA55 = 0;
			self notify("eyesOff");
		}

		wait(0.5);
	}
}

//Function Number: 135
func_12D42()
{
	self notify("unsetTagger");
}

//Function Number: 136
func_F7E9()
{
	thread func_F7EA();
}

//Function Number: 137
func_F7EA()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetPitcher");
	level endon("game_ended");
	scripts\mp\_utility::func_8387("specialty_throwback");
	self method_82F3(1.5);
	for(;;)
	{
		self method_82F4(1.25);
		self waittill("grenade_pullback",var_00);
		if(var_00 == "airdrop_marker_mp" || var_00 == "killstreak_uplink_mp" || var_00 == "deployable_vest_marker_mp" || var_00 == "deployable_weapon_crate_marker_mp" || var_00 == "airdrop_juggernaut_mp")
		{
			self method_82F4(1);
		}

		self waittill("grenade_fire",var_01,var_02);
	}
}

//Function Number: 138
func_12D0C()
{
	self method_82F3(1);
	self method_82F4(1);
	scripts\mp\_utility::func_E150("specialty_throwback");
	self notify("unsetPitcher");
}

//Function Number: 139
func_F670()
{
	self.var_11B2C = "specialty_boom";
}

//Function Number: 140
func_F671(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetBoom");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	scripts\common\utility::func_136F7();
	function_0222(self.origin,param_00,800,1500);
	param_00 func_2CA9(self.origin,self);
}

//Function Number: 141
func_2CA9(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(param_01 == var_03)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9DD6(var_03) && isalive(var_03) && !var_03 scripts\mp\_utility::_hasperk("specialty_gpsjammer") && distancesquared(param_00,var_03.origin) <= 490000)
		{
			scripts\mp\_missions::func_D991("ch_trait_ping");
		}
	}
}

//Function Number: 142
func_2CA8(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("removearchetype");
	var_02 = scripts\common\utility::waittill_any_timeout_1(7,"death");
	if(var_02 == "timeout" && isdefined(self.var_B370[param_01]))
	{
		self.var_B370[param_01] = undefined;
		return;
	}

	self waittill("spawned_player");
	self.var_B370 = undefined;
}

//Function Number: 143
func_12C87()
{
	self.var_11B2C = undefined;
	self notify("unsetBoom");
}

//Function Number: 144
func_4C8E(param_00)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_custom_juiced");
	level endon("game_ended");
	self.var_9E62 = 1;
	self.var_BCF6 = 1.1;
	scripts\mp\_weapons::func_12ED5();
	scripts\mp\_utility::func_8387("specialty_fastreload");
	scripts\mp\_utility::func_8387("specialty_quickdraw");
	scripts\mp\_utility::func_8387("specialty_stalker");
	scripts\mp\_utility::func_8387("specialty_fastoffhand");
	scripts\mp\_utility::func_8387("specialty_fastsprintrecovery");
	scripts\mp\_utility::func_8387("specialty_quickswap");
	thread func_12C9C();
	thread func_12C9E();
	thread func_12C9D();
	var_01 = param_00 * 1000 + gettime();
	if(!isai(self))
	{
		self setclientomnvar("ui_juiced_end_milliseconds",var_01);
	}

	wait(param_00);
	func_12C9B();
}

//Function Number: 145
func_12C9B(param_00)
{
	if(!isdefined(param_00))
	{
		if(scripts\mp\_utility::func_9E59())
		{
			if(isdefined(self.var_A4AA))
			{
				self.var_BCF6 = self.var_A4AA;
			}
			else
			{
				self.var_BCF6 = 0.7;
			}
		}
		else
		{
			self.var_BCF6 = 1;
			if(scripts\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.var_BCF6 = scripts\mp\_utility::func_ACD8();
			}
		}

		scripts\mp\_weapons::func_12ED5();
	}

	scripts\mp\_utility::func_E150("specialty_fastreload");
	scripts\mp\_utility::func_E150("specialty_quickdraw");
	scripts\mp\_utility::func_E150("specialty_stalker");
	scripts\mp\_utility::func_E150("specialty_fastoffhand");
	scripts\mp\_utility::func_E150("specialty_fastsprintrecovery");
	scripts\mp\_utility::func_E150("specialty_quickswap");
	self.var_9E62 = undefined;
	if(!isai(self))
	{
		self setclientomnvar("ui_juiced_end_milliseconds",0);
	}

	self notify("unset_custom_juiced");
}

//Function Number: 146
func_12C9E()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	for(;;)
	{
		wait(0.05);
		if(scripts\mp\_utility::func_9FC6())
		{
			thread func_12C9B();
			break;
		}
	}
}

//Function Number: 147
func_12C9C()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	scripts\common\utility::waittill_any_3("death","faux_spawn");
	thread func_12C9B(1);
}

//Function Number: 148
func_12C9D()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	thread func_12C9B();
}

//Function Number: 149
func_F897()
{
}

//Function Number: 150
func_F898()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetTriggerHappy");
	level endon("game_ended");
	var_00 = self.var_A978;
	var_01 = self getweaponammostock(var_00);
	var_02 = self getweaponammoclip(var_00);
	self method_817C(var_00);
	var_03 = self getweaponammoclip(var_00);
	var_04 = var_03 - var_02;
	var_05 = var_01 - var_04;
	if(var_04 > var_01)
	{
		self setweaponammoclip(var_00,var_02 + var_01);
		var_05 = 0;
	}

	self setweaponammostock(var_00,var_05);
	self playlocalsound("ammo_crate_use");
	self setclientomnvar("ui_trigger_happy",1);
	wait(0.2);
	self setclientomnvar("ui_trigger_happy",0);
}

//Function Number: 151
func_12D51()
{
	self setclientomnvar("ui_trigger_happy",0);
	self notify("unsetTriggerHappy");
}

//Function Number: 152
func_F754()
{
}

//Function Number: 153
func_12CD7()
{
}

//Function Number: 154
func_F668()
{
}

//Function Number: 155
func_12C83()
{
}

//Function Number: 156
func_F810()
{
}

//Function Number: 157
func_12D13()
{
}

//Function Number: 158
func_F6F4()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extraammo");
	level endon("game_ended");
	if(self.var_81D1)
	{
		self waittill("giveLoadout");
	}

	var_00 = scripts\mp\_utility::func_81F6();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && var_02 != "none")
		{
			self givemaxammo(var_02);
		}
	}
}

//Function Number: 159
func_12CB3()
{
	self notify("unset_extraammo");
}

//Function Number: 160
func_F6F8()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extraequipment");
	level endon("game_ended");
	if(self.var_81D1)
	{
		self waittill("giveLoadout");
	}

	var_00 = self.var_AE78;
	if(isdefined(var_00) && var_00 != "specialty_null")
	{
		if(var_00 != "specialty_tacticalinsertion" && var_00 != "smoke_grenade_mp" && var_00 != "player_trophy_system_mp" && var_00 != "shoulder_cannon_mp")
		{
			self setweaponammoclip(var_00,2);
		}
	}
}

//Function Number: 161
func_12CB7()
{
	self notify("unset_extraequipment");
}

//Function Number: 162
func_F6F6()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extradeadly");
	level endon("game_ended");
}

//Function Number: 163
func_12CB5()
{
	self notify("unset_extradeadly");
}

//Function Number: 164
func_10D79(param_00)
{
	if(isdefined(param_00) && param_00 != self)
	{
		var_01 = self getweaponslistoffhands();
		var_02 = 1;
		var_03 = 0;
		foreach(var_05 in var_01)
		{
			if(var_05 != "throwingknife_mp")
			{
				var_03 = self getweaponammoclip(var_05);
				var_02 = var_02 + var_03;
			}
		}

		var_07 = 1;
		var_08 = spawn("script_origin",self.origin);
		var_08.var_222 = param_00;
		if(!isdefined(var_08.team))
		{
			var_08.team = param_00.team;
		}

		var_08.var_42E0 = var_02;
		var_08 thread scripts\mp\_weapons::func_42D8(var_07);
		var_08 notify("explode",var_08.origin);
		var_08 delete();
	}
}

//Function Number: 165
func_F65B()
{
	lib_0D69::func_116E(1);
	lib_0DD9::func_28F2();
}

//Function Number: 166
func_12C7B()
{
	lib_0D69::func_116E(0);
	lib_0DD9::func_28F6();
}

//Function Number: 167
func_F7CF()
{
}

//Function Number: 168
func_12D00()
{
}

//Function Number: 169
func_F62C()
{
	lib_0DCD::func_1664();
}

//Function Number: 170
func_12C66()
{
	lib_0DCD::func_1667();
}

//Function Number: 171
func_F782()
{
	if(!isdefined(level._effect["life_pack_pickup"]))
	{
		level._effect["life_pack_pickup"] = loadfx("vfx/iw7/_requests/mp/vfx_health_pickup");
	}

	thread func_13ABD();
}

//Function Number: 172
func_13ABD()
{
	self endon("death");
	self endon("disconnect");
	self notify("unset_lifepack");
	self endon("unset_lifepack");
	for(;;)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		var_03 = self.origin;
		var_04 = 20;
		var_05 = 20;
		var_06 = spawn("script_model",self.origin + (0,0,10));
		var_06 setmodel("weapon_life_pack");
		var_06.var_222 = self;
		var_06.team = self.team;
		var_06 method_8429(self);
		var_07 = spawn("trigger_radius",self.origin,0,var_04,var_05);
		var_07 thread func_13AC1(var_06);
		var_07 thread func_13ABC(var_06);
		var_06 thread func_90F0();
		var_06 rotateyaw(1000,30,0.2,0.2);
		var_06 thread func_13ABE(10,var_07);
		var_06 thread func_13AC0();
		foreach(var_09 in level.players)
		{
			var_06 func_F784(var_09);
		}
	}
}

//Function Number: 173
func_160B(param_00,param_01,param_02)
{
	self.var_AC67 = 1;
	if(isdefined(param_01) && param_01 > 0)
	{
		thread func_13ABB(param_01);
	}

	if(isdefined(param_02) && param_02)
	{
		thread func_13AC2();
	}

	scripts\mp\_utility::func_8387("specialty_regenfaster");
	self setclientomnvar("ui_life_link",1);
	self notify("enabled_life_pack_boost");
	self.var_AC70 = param_00;
	scripts\mp\_gamescore::func_11AC9(param_00,self,"medic_lifepack");
}

//Function Number: 174
func_13ABB(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(param_00);
	if(isdefined(self.var_AC67))
	{
		func_55F9();
	}
}

//Function Number: 175
func_55F9()
{
	if(isdefined(self) && isdefined(self.var_AC67))
	{
		self.var_AC67 = undefined;
		self setclientomnvar("ui_life_link",0);
		self notify("disabled_life_pack_boost");
		scripts\mp\_utility::func_E150("specialty_regenfaster");
		scripts\mp\_gamescore::func_12D6E(self.var_AC70,self,"medic_lifepack");
		self.var_AC70 = undefined;
	}
}

//Function Number: 176
func_F784(param_00)
{
	if(level.teambased && param_00.team == self.team && param_00 != self.var_222)
	{
		func_F783(param_00);
		self showtoplayer(param_00);
		thread func_13ABF(param_00);
		return;
	}

	self method_8429(param_00);
}

//Function Number: 177
func_F783(param_00)
{
	if(isdefined(param_00.var_AC67))
	{
		if(isdefined(param_00.var_AC6F) && param_00.var_AC6F.size > 0)
		{
			foreach(var_02 in param_00.var_AC6F)
			{
				if(self == var_02.var_C858)
				{
					scripts\mp\_utility::func_C78F(var_02.var_92B8,var_02.var_C858);
					param_00.var_AC6F = scripts\common\utility::func_22A9(param_00.var_AC6F,var_02);
					var_02 = undefined;
				}
			}

			return;
		}

		return;
	}

	if(!isdefined(var_03.var_AC6F))
	{
		var_03.var_AC6F = [];
	}

	var_04 = spawnstruct();
	var_04.var_92B8 = scripts\mp\_utility::func_C794(self,"cyan",var_03,1,0,"equipment");
	var_04.var_C858 = self;
	var_03.var_AC6F = scripts\common\utility::array_add_safe(var_03.var_AC6F,var_04);
}

//Function Number: 178
func_13ABF(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 scripts\common\utility::waittill_any_3("enabled_life_pack_boost","disabled_life_pack_boost");
		func_F783(param_00);
	}
}

//Function Number: 179
func_90F0()
{
	self endon("death");
	self endon("phase_resource_pickup");
	var_00 = self.origin;
	for(;;)
	{
		self moveto(var_00 + (0,0,15),1,0.2,0.2);
		wait(1);
		self moveto(var_00,1,0.2,0.2);
		wait(1);
	}
}

//Function Number: 180
func_13AC1(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(var_01.team != param_00.team)
		{
			continue;
		}

		if(isdefined(var_01.var_AC67))
		{
			continue;
		}

		if(var_01 == param_00.var_222)
		{
			continue;
		}

		var_01 func_160B(param_00.var_222,5,1);
		var_01 playlocalsound("scavenger_pack_pickup");
		var_02 = spawnfx(scripts\common\utility::getfx("life_pack_pickup"),self.origin);
		triggerfx(var_02);
		var_02 thread scripts\mp\_utility::func_5106(2);
		foreach(var_04 in level.players)
		{
			if(var_04.team == var_01.team)
			{
				continue;
			}

			var_02 method_8429(var_04);
		}

		param_00 delete();
	}
}

//Function Number: 181
func_13ABC(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 182
func_13ABE(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	param_01 delete();
	self delete();
}

//Function Number: 183
func_13AC0()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 184
func_13AC2()
{
	self endon("disconnect");
	self waittill("death");
	func_55F9();
}

//Function Number: 185
func_12CE4()
{
	func_55F9();
	self notify("unset_lifepack");
}

//Function Number: 186
func_F891()
{
	if(!isdefined(level._effect["toughen_up_screen"]))
	{
		level._effect["toughen_up_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_toughen_up_scrn");
	}

	thread func_13B87();
}

//Function Number: 187
func_13B87()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetToughenUp");
	level endon("game_ended");
	var_00 = 0;
	var_01 = 15;
	var_02 = 7.5;
	var_03 = 4;
	var_04 = 5;
	var_05 = 2;
	var_06 = [];
	var_06 = scripts\common\utility::array_add_safe(var_06,(35,0,10));
	var_06 = scripts\common\utility::array_add_safe(var_06,(0,35,10));
	var_06 = scripts\common\utility::array_add_safe(var_06,(-35,0,10));
	var_06 = scripts\common\utility::array_add_safe(var_06,(0,-35,10));
	self waittill("spawned_player");
	for(;;)
	{
		self waittill("got_a_kill",var_07,var_08,var_09);
		if(!isdefined(self.var_11A47))
		{
			self.var_11A47 = 1;
			var_0A = function_01E1(scripts\common\utility::getfx("toughen_up_screen"),self geteye(),self);
			triggerfx(var_0A);
			thread func_24AD("j_forehead",level.var_3257["section"].var_741D);
			thread func_24AD("tag_reflector_arm_le",level.var_3257["section"].var_741D);
			thread func_24AD("tag_reflector_arm_ri",level.var_3257["section"].var_741D);
			thread func_24AD("j_spineupper",level.var_3257["section"].var_741D);
			thread func_24AD("tag_shield_back",level.var_3257["section"].var_741D);
			thread func_24AD("j_hip_le",level.var_3257["section"].var_741D);
			thread func_24AD("j_hip_ri",level.var_3257["section"].var_741D);
			if(var_05 == 1)
			{
				scripts\mp\_utility::func_F741(var_01);
				thread func_13B89(var_04);
			}
			else
			{
				scripts\mp\_lightarmor::func_F786(self,100);
				thread func_13B8A();
			}

			var_0A thread func_13B8D(self);
			continue;
		}

		if(var_05 == 1)
		{
			self notify("toughen_up_reset");
			thread func_13B89(var_04);
		}
	}
}

//Function Number: 188
func_24AD(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self gettagorigin(param_00);
	var_06 = spawn("script_model",var_05);
	var_06 setmodel(param_01);
	var_07 = (0,0,0);
	var_08 = (0,0,0);
	if(isdefined(param_02))
	{
		var_07 = param_02;
	}

	if(isdefined(param_03))
	{
		var_08 = param_03;
	}

	var_06.angles = self.angles;
	var_06 linkto(self,param_00,var_07,var_08);
	var_06 thread func_13B8D(self);
	var_06 thread func_13B88();
	return var_06;
}

//Function Number: 189
func_F892(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",self.origin + (0,0,50));
	var_04.team = self.var_222.team;
	if(param_03 == "friendly")
	{
		var_04 setmodel(level.var_3257["section"].var_741D);
	}
	else
	{
		var_04 setmodel(level.var_3257["section"].var_6564);
	}

	var_04 linkto(self,"tag_origin",param_01,(0,90 * param_02 + 1,0));
	var_04 hide();
	var_04 thread func_13B8D(self.var_222);
	var_04 thread func_13B88();
	var_04 thread func_F893(param_03,self.var_222);
}

//Function Number: 190
func_13B8A()
{
	self endon("disconnect");
	self waittill("remove_light_armor");
}

//Function Number: 191
func_13B8D(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect","toughen_up_end");
	param_00.var_11A47 = undefined;
	if(param_00 scripts\mp\_lightarmor::func_8C07(param_00))
	{
		param_00 func_12CE5();
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 192
func_13B88()
{
	self endon("death");
	level waittill("game_ended");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 193
func_13B89(param_00)
{
	self endon("death");
	self endon("toughen_up_reset");
	while(param_00 > 0)
	{
		param_00 = param_00 - 1;
		wait(1);
	}

	self notify("toughen_up_end");
}

//Function Number: 194
func_F893(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == param_01)
		{
			continue;
		}

		if(!lib_0DF8::func_9DDF(var_03))
		{
			if(func_3911(var_03,param_00))
			{
				self showtoplayer(var_03);
			}
		}

		thread func_13B8C(var_03,param_00);
		thread func_13B8B(var_03,param_00);
	}
}

//Function Number: 195
func_13B8C(param_00,param_01)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		param_00 waittill("spawned_player");
		self method_8429(param_00);
		if(func_3911(param_00,param_01))
		{
			self showtoplayer(param_00);
		}

		thread func_13B8B(param_00,param_01);
	}
}

//Function Number: 196
func_3911(param_00,param_01)
{
	var_02 = 0;
	if((param_01 == "friendly" && param_00.team == self.team) || param_01 == "enemy" && param_00.team != self.team)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 197
func_13B8B(param_00,param_01)
{
}

//Function Number: 198
func_12D4D()
{
	scripts\mp\_utility::func_41B4();
	func_12CE5();
	self notify("unsetToughenUp");
}

//Function Number: 199
func_F82D()
{
	thread lib_0D6F::func_13B32();
	thread func_12F0D();
}

//Function Number: 200
func_12F0D()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetScoutPing");
	var_00 = 50;
	var_01 = 1200;
	for(;;)
	{
		var_02 = var_00;
		var_03 = var_01;
		if(isdefined(self.var_EC82))
		{
			var_02 = self.var_EC82;
		}

		if(isdefined(self.var_EC83))
		{
			var_03 = self.var_EC83;
		}

		var_02 = int(var_02);
		var_03 = int(var_03);
		if(var_02 != var_00)
		{
			function_02A1(self.origin,self.team,var_02,var_03);
		}

		wait(var_01 / 1200);
	}
}

//Function Number: 201
func_12F0E(param_00)
{
	var_01 = 0;
	var_02 = 150;
	var_03 = 3000;
	if(isdefined(self.var_EC80))
	{
		var_01 = self.var_EC80;
	}

	if(isdefined(self.var_EC81))
	{
		if(param_00 > self.var_EC81)
		{
			var_04 = param_00 - self.var_EC81;
			var_01 = var_01 + var_04 / 10;
		}
		else if(param_00 < self.var_EC81)
		{
			var_04 = self.var_EC81 - param_00;
			var_01 = var_01 - var_04 / 10;
		}
	}

	if(isdefined(self.var_EC80))
	{
		if(var_01 > self.var_EC80 || var_01 < self.var_EC80)
		{
			var_02 = var_02 + var_02 * var_01 * 1.5;
			var_03 = var_03 - var_03 * var_01 / 1.5;
			self.var_EC82 = var_02;
			self.var_EC83 = var_03;
		}
	}

	if(param_00 == 0)
	{
		self.var_EC82 = undefined;
		self.var_EC83 = undefined;
	}

	self.var_EC80 = var_01;
	self.var_EC81 = param_00;
}

//Function Number: 202
func_12D26()
{
	self.var_EC82 = undefined;
	self.var_EC83 = undefined;
	self.var_EC80 = undefined;
	self.var_EC81 = undefined;
	self notify("unsetScoutPing");
	thread lib_0D6F::func_3886();
}

//Function Number: 203
func_F6A1()
{
	thread func_139D8();
}

//Function Number: 204
func_12C9A()
{
}

//Function Number: 205
func_3E41()
{
	self endon("disconnect");
	self waittill("spawned_player");
	thread func_139D8();
}

//Function Number: 206
func_139D8()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		var_03 = var_00 method_8113();
		var_04 = "primary";
		var_05 = "none";
		var_06 = getarraykeys(var_00.var_D782);
		foreach(var_08 in var_06)
		{
			if(var_00.var_D782[var_08].var_10307 == var_04)
			{
				var_05 = var_08;
			}
		}

		if(var_05 == "none")
		{
			continue;
		}

		var_0A = 20;
		var_0B = 20;
		var_0C = spawn("script_model",var_03.origin + (0,0,10));
		var_0C.var_222 = self;
		var_0C.team = self.team;
		var_0D = spawn("trigger_radius",var_03.origin,0,var_0A,var_0B);
		var_0D thread func_139D9(var_0C);
		var_0C thread func_139DA(30,var_0D);
		var_0C thread func_139DB();
		var_0C func_B29E(var_05);
	}
}

//Function Number: 207
func_12F4D()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self))
		{
			self.origin = self.origin;
			if(isdefined(self.var_2C68))
			{
				self.var_2C68.origin = self.origin;
			}
		}
		else
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 208
func_4650(param_00,param_01,param_02)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self.trigger setcursorhint("HINT_NOICON");
	switch(param_02)
	{
		case "power_c4":
			self.trigger sethintstring(&"MP_PICKUP_C4");
			break;

		case "power_biospike":
			self.trigger sethintstring(&"MP_PICKUP_BIOSPIKE");
			break;

		case "power_bouncingBetty":
			self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
			break;

		case "power_semtex":
			self.trigger sethintstring(&"MP_PICKUP_SEMTEX");
			break;

		case "power_smokeGrenade":
			self.trigger sethintstring(&"MP_PICKUP_SMOKE_GRENADE");
			break;

		case "power_domeshield":
			self.trigger sethintstring(&"MP_PICKUP_DOME_SHIELD");
			break;

		case "power_shardBall":
			self.trigger sethintstring(&"MP_PICKUP_SHARD_BALL");
			break;

		case "power_splashGrenade":
			self.trigger sethintstring(&"MP_PICKUP_SPLASH_GRENADE");
			break;

		case "power_clusterGrenade":
			self.trigger sethintstring(&"MP_PICKUP_CLUSTER_GRENADE");
			break;

		case "power_smokeWall":
			self.trigger sethintstring(&"MP_PICKUP_SMOKE_WALL");
			break;

		case "power_empGrenade":
			self.trigger sethintstring(&"MP_PICKUP_EMP_GRENADE");
			break;

		case "power_blackholeGrenade":
			self.trigger sethintstring(&"MP_PICKUP_BLACKHOLE_GRENADE");
			break;

		case "power_blinkKnife":
			self.trigger sethintstring(&"MP_PICKUP_TELEPORT_KNIFE");
			break;

		case "power_throwingReap":
			self.trigger sethintstring(&"MP_PICKUP_THROWING_REAP");
			break;

		case "power_thermobaric":
			self.trigger sethintstring(&"MP_PICKUP_THERMOBARIC");
			break;

		case "power_playerTrophySystem":
			self.trigger sethintstring(&"MP_PICKUP_PLAYER_TROPHY");
			break;

		case "power_discMarker":
			self.trigger sethintstring(&"MP_PICKUP_DISC_MARKER");
			break;

		case "power_caseBomb":
			self.trigger sethintstring(&"MP_PICKUP_CASE_BOMB");
			break;

		case "power_transponder":
			self.trigger sethintstring(&"MP_PICKUP_TRANSPONDER");
			break;

		case "power_gasGrenade":
			self.trigger sethintstring(&"MP_PICKUP_GAS_GRENADE");
			break;

		case "power_blackoutGrenade":
			self.trigger sethintstring(&"MP_PICKUP_BLACKOUT_GRENADE");
			break;

		case "power_copycatGrenade":
			self.trigger sethintstring(&"MP_PICKUP_COPYCAT_GRENADE");
			break;

		case "power_arcGrenade":
			self.trigger sethintstring(&"MP_PICKUP_ARC_MINE");
			break;
	}

	self.trigger makeusable();
	foreach(var_04 in level.players)
	{
		if(var_04 == param_00)
		{
			self.trigger enableplayeruse(var_04);
			continue;
		}

		self.trigger disableplayeruse(var_04);
	}

	self.trigger thread scripts\mp\_utility::notusableforjoiningplayers(param_00);
	if(isdefined(param_01) && param_01)
	{
		thread func_12F4D();
	}

	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		param_00 playlocalsound("scavenger_pack_pickup");
		var_06 = param_02;
		var_07 = "primary";
		param_00 notify("start_copycat");
		param_00 notify("corpse_steal");
		var_08 = "none";
		var_09 = getarraykeys(param_00.var_D782);
		foreach(var_0B in var_09)
		{
			if(param_00.var_D782[var_0B].var_10307 == var_07)
			{
				var_08 = var_0B;
			}
		}

		param_00 scripts\mp\_powers::func_E15E(var_08);
		param_00 scripts\mp\_powers::func_8397(var_06,var_07,1);
		param_00 thread scripts\mp\_weapons::func_139D7(var_06,var_07);
		self.trigger delete();
		self delete();
		self notify("death");
	}
}

//Function Number: 209
func_B29E(param_00)
{
	if(scripts\mp\_utility::func_9F19(self.var_222))
	{
		self method_831F(self.var_222);
		self.trigger = spawn("script_origin",self.origin,0,1,1);
		self.trigger.var_222 = self;
		thread func_4650(self.var_222,1,param_00);
	}
}

//Function Number: 210
func_139D9(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 211
func_139DA(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	self.trigger delete();
	param_01 delete();
	self delete();
}

//Function Number: 212
func_139DB()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 213
func_F7E6()
{
	thread func_13AEE();
	thread func_13AED();
}

//Function Number: 214
func_13AEE()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("phase_shift_start");
		self.var_CAB0 = 0.2;
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 215
func_13AED()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("phase_shift_completed");
		self.var_CAB0 = undefined;
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 216
func_12D0A()
{
	self.var_CAB0 = undefined;
}

//Function Number: 217
func_F6CC()
{
	self.var_11B2C = "specialty_dodge";
	self method_8412(1);
	if(scripts\mp\_utility::func_9D46())
	{
		self method_8454(6);
	}
	else
	{
		self method_8454(3);
	}

	lib_0DCE::func_139F9();
}

//Function Number: 218
func_12CA4()
{
	self.var_11B2C = undefined;
	self method_8412(0);
}

//Function Number: 219
func_F6F7()
{
	self method_842E(1,100);
	self method_842C(1,100);
}

//Function Number: 220
func_12CB6()
{
	self method_842E(1,50);
	self method_842C(1,50);
}

//Function Number: 221
func_F846()
{
	self.var_11B2C = "specialty_sixth_sense";
	func_12F1B(0,0);
	thread func_10225();
}

//Function Number: 222
func_12D2E()
{
	self.var_11B2C = undefined;
	self.var_10224 = undefined;
	self notify("removeSixthSense");
	func_12F1B(0,0);
}

//Function Number: 223
func_F6E9()
{
}

//Function Number: 224
func_12CAD()
{
}

//Function Number: 225
func_10225()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeSixthSense");
	self endon("round_switch");
	thread watchdeathsixthsense();
	for(;;)
	{
		var_00 = 0;
		var_01 = level.players;
		var_02 = 0;
		var_03 = scripts\mp\_utility::_hasperk("specialty_enhanced_sixth_sense");
		if(!scripts\mp\killstreaks\_emp_common::isemped())
		{
			foreach(var_05 in var_01)
			{
				if(!isdefined(var_05) || !scripts\mp\_utility::func_9F19(var_05))
				{
					continue;
				}

				if(var_05.team == self.team)
				{
					continue;
				}

				if(var_05 scripts\mp\_utility::_hasperk("specialty_coldblooded"))
				{
					continue;
				}

				if(!lib_0DF8::func_213D(self,var_05))
				{
					continue;
				}

				var_06 = self.origin - var_05.origin;
				var_07 = anglestoforward(var_05 getplayerangles());
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
					thread watchperceptionchallengedeath();
					thread watchperceptionchallengeprogress();
					var_02 = var_02 | func_8125(var_05);
					thread markassixthsensesource(var_05);
					continue;
				}

				if(var_00 >= 3)
				{
					scripts\common\utility::func_136F7();
					var_00 = 0;
				}
			}
		}

		if(var_02 > 4)
		{
			var_02 = 255;
		}
		else
		{
			var_02 = 0;
		}

		func_12F1B(var_02,var_03);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 226
watchperceptionchallengedeath()
{
	self endon("disconnect");
	if(scripts\mp\_utility::func_9FB3(self.startperceptionchallengewatch))
	{
		return;
	}

	scripts\common\utility::waittill_any_3("removesixthsense","death","perceptionChallengeCheckDone");
	self.startperceptionchallengewatch = 0;
}

//Function Number: 227
watchperceptionchallengeprogress()
{
	self endon("disconnect");
	self endon("removesixthsense");
	self endon("death");
	if(scripts\mp\_utility::func_9FB3(self.startperceptionchallengewatch))
	{
		return;
	}

	self.startperceptionchallengewatch = 1;
	wait(10);
	scripts\mp\_missions::func_D991("ch_trait_perception");
	self notify("perceptionChallengeCheckDone");
}

//Function Number: 228
watchdeathsixthsense()
{
	self endon("disconnect");
	self endon("removesixthsense");
	self waittill("death");
	self setclientomnvar("ui_edge_glow",0);
}

//Function Number: 229
func_12F1B(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(self.var_10224))
	{
		var_02 = self.var_10224;
	}

	if(isdefined(param_01) && param_01)
	{
		if(var_02 != param_00)
		{
			self.var_10224 = param_00;
		}
	}

	self setclientomnvar("ui_edge_glow",param_00);
}

//Function Number: 230
func_8125(param_00)
{
	var_01 = anglestoforward(self getplayerangles());
	var_02 = (var_01[0],var_01[1],var_01[2]);
	var_02 = vectornormalize(var_02);
	var_03 = param_00.origin - self.origin;
	var_04 = (var_03[0],var_03[1],var_03[2]);
	var_04 = vectornormalize(var_04);
	var_05 = vectordot(var_02,var_04);
	if(var_05 >= 0.9238795)
	{
		return 2;
	}

	if(var_05 >= 0.3826834)
	{
		return scripts\common\utility::func_116D7(scripts\mp\_utility::func_9E7A(self.origin,var_02,param_00.origin),4,1);
	}

	if(var_05 >= -0.3826834)
	{
		return scripts\common\utility::func_116D7(scripts\mp\_utility::func_9E7A(self.origin,var_02,param_00.origin),128,64);
	}

	if(var_05 >= -0.9238795)
	{
		return scripts\common\utility::func_116D7(scripts\mp\_utility::func_9E7A(self.origin,var_02,param_00.origin),32,8);
	}

	return 16;
}

//Function Number: 231
markassixthsensesource(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	var_01 = param_00 getentitynumber();
	if(!isdefined(self.sixthsensesource))
	{
		self.sixthsensesource = [];
	}
	else if(isdefined(self.sixthsensesource[var_01]))
	{
		self notify("markAsSixthSenseSource");
		self endon("markAsSixthSenseSource");
	}

	self.sixthsensesource[var_01] = 1;
	param_00 scripts\common\utility::waittill_any_timeout_1(10,"death");
	self.sixthsensesource[var_01] = 0;
}

//Function Number: 232
func_F67B()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	for(;;)
	{
		var_00 = 0;
		var_01 = level.players;
		var_02 = 0;
		if(!scripts\mp\killstreaks\_emp_common::isemped())
		{
			foreach(var_04 in var_01)
			{
				if(!isdefined(var_04) || !scripts\mp\_utility::func_9F19(var_04))
				{
					continue;
				}

				if(var_04.team == self.team)
				{
					continue;
				}

				if(var_04 scripts\mp\_utility::_hasperk("specialty_empimmune"))
				{
					continue;
				}

				if(!lib_0DF8::func_213D(self,var_04))
				{
					continue;
				}

				var_05 = self.origin - var_04.origin;
				var_06 = anglestoforward(var_04 getplayerangles());
				var_07 = vectordot(var_05,var_06);
				if(var_07 <= 0)
				{
					continue;
				}

				var_08 = vectornormalize(var_05);
				var_09 = vectornormalize(var_06);
				var_07 = vectordot(var_08,var_09);
				if(var_07 < 0.9659258)
				{
					continue;
				}

				var_00++;
				var_0A = var_04 geteye();
				var_0B = self geteye();
				if(bullettracepassed(var_0A,var_0B,0,self))
				{
					var_02 = 1;
					break;
				}

				if(var_00 >= 3)
				{
					scripts\common\utility::func_136F7();
					var_00 = 0;
				}
			}

			scripts\common\utility::func_136F7();
		}

		func_12E6C(var_02);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 233
func_12E6C(param_00)
{
}

//Function Number: 234
func_12C8C()
{
}

//Function Number: 235
func_F704()
{
	scripts\mp\_utility::func_8387("specialty_pistoldeath");
}

//Function Number: 236
func_12CBD()
{
	scripts\mp\_utility::func_E150("specialty_pistoldeath");
}

//Function Number: 237
func_F67E()
{
	thread scripts\mp\killstreaks\_killstreaks::func_8374("airdrop_assault",0,0,self);
}

//Function Number: 238
func_12C8D()
{
}

//Function Number: 239
func_F89F()
{
	thread scripts\mp\killstreaks\_killstreaks::func_8374("uav",0,0,self);
}

//Function Number: 240
func_12D53()
{
}

//Function Number: 241
func_F864()
{
	scripts\mp\_utility::func_8387("specialty_bulletdamage");
	thread func_13B63();
}

//Function Number: 242
func_13B63()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	func_12D3A();
}

//Function Number: 243
func_12D3A()
{
	scripts\mp\_utility::func_E150("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 244
func_F678()
{
	scripts\mp\_utility::func_8387("specialty_pistoldeath");
}

//Function Number: 245
func_12C8A()
{
	if(scripts\mp\_utility::_hasperk("specialty_pistoldeath"))
	{
		scripts\mp\_utility::func_E150("specialty_pistoldeath");
	}
}

//Function Number: 246
func_F769(param_00)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_juiced");
	level endon("game_ended");
	self.var_9E62 = 1;
	self.var_BCF6 = 1.25;
	scripts\mp\_weapons::func_12ED5();
	scripts\mp\_utility::func_8387("specialty_fastreload");
	scripts\mp\_utility::func_8387("specialty_quickdraw");
	scripts\mp\_utility::func_8387("specialty_stalker");
	scripts\mp\_utility::func_8387("specialty_fastoffhand");
	scripts\mp\_utility::func_8387("specialty_fastsprintrecovery");
	scripts\mp\_utility::func_8387("specialty_quickswap");
	thread func_12CDD();
	thread func_12CDF();
	thread func_12CDE();
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_01 = param_00 * 1000 + gettime();
	if(!isai(self))
	{
		self setclientomnvar("ui_juiced_end_milliseconds",var_01);
	}

	wait(param_00);
	func_12CDC();
}

//Function Number: 247
func_12CDC(param_00)
{
	if(!isdefined(param_00))
	{
		if(scripts\mp\_utility::func_9E59())
		{
			if(isdefined(self.var_A4AA))
			{
				self.var_BCF6 = self.var_A4AA;
			}
			else
			{
				self.var_BCF6 = 0.7;
			}
		}
		else
		{
			self.var_BCF6 = 1;
			if(scripts\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.var_BCF6 = scripts\mp\_utility::func_ACD8();
			}
		}

		scripts\mp\_weapons::func_12ED5();
	}

	scripts\mp\_utility::func_E150("specialty_fastreload");
	scripts\mp\_utility::func_E150("specialty_quickdraw");
	scripts\mp\_utility::func_E150("specialty_stalker");
	scripts\mp\_utility::func_E150("specialty_fastoffhand");
	scripts\mp\_utility::func_E150("specialty_fastsprintrecovery");
	scripts\mp\_utility::func_E150("specialty_quickswap");
	self.var_9E62 = undefined;
	if(!isai(self))
	{
		self setclientomnvar("ui_juiced_end_milliseconds",0);
	}

	self notify("unset_juiced");
}

//Function Number: 248
func_12CDF()
{
	self endon("disconnect");
	self endon("unset_juiced");
	for(;;)
	{
		wait(0.05);
		if(scripts\mp\_utility::func_9FC6())
		{
			thread func_12CDC();
			break;
		}
	}
}

//Function Number: 249
func_12CDD()
{
	self endon("disconnect");
	self endon("unset_juiced");
	scripts\common\utility::waittill_any_3("death","faux_spawn");
	thread func_12CDC(1);
}

//Function Number: 250
func_12CDE()
{
	self endon("disconnect");
	self endon("unset_juiced");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	thread func_12CDC();
}

//Function Number: 251
func_8C03()
{
	return isdefined(self.var_9E62);
}

//Function Number: 252
func_F696()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_combathigh");
	level endon("end_game");
	self.var_4D2D = 0;
	if(level.splitscreen)
	{
		var_00 = 56;
		var_01 = 21;
	}
	else
	{
		var_00 = 112;
		var_01 = 32;
	}

	if(isdefined(self.var_A4B1))
	{
		self.var_A4B1 destroy();
	}

	if(isdefined(self.var_A4B0))
	{
		self.var_A4B0 destroy();
	}

	self.var_4404 = newclienthudelem(self);
	self.var_4404.x = 0;
	self.var_4404.y = 0;
	self.var_4404.alignx = "left";
	self.var_4404.aligny = "top";
	self.var_4404.horzalign = "fullscreen";
	self.var_4404.vertalign = "fullscreen";
	self.var_4404 setshader("combathigh_overlay",640,480);
	self.var_4404.sort = -10;
	self.var_4404.archived = 1;
	self.var_4405 = scripts\mp\_hud_util::createtimer("hudsmall",1);
	self.var_4405 scripts\mp\_hud_util::setpoint("CENTER","CENTER",0,var_00);
	self.var_4405 settimer(10);
	self.var_4405.color = (0.8,0.8,0);
	self.var_4405.archived = 0;
	self.var_4405.foreground = 1;
	self.var_4403 = scripts\mp\_hud_util::createicon("specialty_painkiller",var_01,var_01);
	self.var_4403.alpha = 0;
	self.var_4403 scripts\mp\_hud_util::setparent(self.var_4405);
	self.var_4403 scripts\mp\_hud_util::setpoint("BOTTOM","TOP");
	self.var_4403.archived = 1;
	self.var_4403.sort = 1;
	self.var_4403.foreground = 1;
	self.var_4404.alpha = 0;
	self.var_4404 fadeovertime(1);
	self.var_4403 fadeovertime(1);
	self.var_4404.alpha = 1;
	self.var_4403.alpha = 0.85;
	thread func_12C93();
	thread func_12C94();
	wait(8);
	self.var_4403 fadeovertime(2);
	self.var_4403.alpha = 0;
	self.var_4404 fadeovertime(2);
	self.var_4404.alpha = 0;
	self.var_4405 fadeovertime(2);
	self.var_4405.alpha = 0;
	wait(2);
	self.var_4D2D = undefined;
	scripts\mp\_utility::func_E150("specialty_combathigh");
}

//Function Number: 253
func_12C93()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	self waittill("death");
	thread scripts\mp\_utility::func_E150("specialty_combathigh");
}

//Function Number: 254
func_12C94()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	for(;;)
	{
		wait(0.05);
		if(scripts\mp\_utility::func_9FC6())
		{
			thread scripts\mp\_utility::func_E150("specialty_combathigh");
			break;
		}
	}
}

//Function Number: 255
func_12C92()
{
	self notify("unset_combathigh");
	self.var_4404 destroy();
	self.var_4403 destroy();
	self.var_4405 destroy();
}

//Function Number: 256
func_F785()
{
	scripts\mp\_lightarmor::func_F786(self,150);
}

//Function Number: 257
func_12CE5()
{
	scripts\mp\_lightarmor::func_ACAC();
}

//Function Number: 258
func_F81D()
{
	self notify("stopRevenge");
	wait(0.05);
	if(!isdefined(self.var_A9A3))
	{
		return;
	}

	if(level.teambased && self.team == self.var_A9A3.team)
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_10158 = self;
	var_00.var_928E = "compassping_revenge";
	var_00.var_C364 = (0,0,64);
	var_00.width = 10;
	var_00.height = 10;
	var_00.archived = 0;
	var_00.var_50AE = 1.5;
	var_00.var_4554 = 0;
	var_00.var_CB9B = 1;
	var_00.var_6ABA = 0;
	var_00.var_9B3F = 0;
	self.var_E48E = var_00;
	self.var_A9A3 scripts\mp\_entityheadicons::func_F73D(var_00.var_10158,var_00.var_928E,var_00.var_C364,var_00.width,var_00.height,var_00.archived,var_00.var_50AE,var_00.var_4554,var_00.var_CB9B,var_00.var_6ABA,var_00.var_9B3F);
	thread func_13B2A();
	thread func_13B2C();
	thread func_13B2B();
	thread func_13B2D();
	thread func_13B64();
}

//Function Number: 259
func_13B2A()
{
	self endon("stopRevenge");
	self endon("disconnect");
	var_00 = self.var_A9A3;
	for(;;)
	{
		var_00 waittill("spawned_player");
		var_00 scripts\mp\_entityheadicons::func_F73D(self.var_E48E.var_10158,self.var_E48E.var_928E,self.var_E48E.var_C364,self.var_E48E.width,self.var_E48E.height,self.var_E48E.archived,self.var_E48E.var_50AE,self.var_E48E.var_4554,self.var_E48E.var_CB9B,self.var_E48E.var_6ABA,self.var_E48E.var_9B3F);
	}
}

//Function Number: 260
func_13B2C()
{
	self endon("stopRevenge");
	self waittill("killed_enemy");
	self notify("stopRevenge");
}

//Function Number: 261
func_13B2B()
{
	self endon("stopRevenge");
	self.var_A9A3 waittill("disconnect");
	self notify("stopRevenge");
}

//Function Number: 262
func_13B64()
{
	var_00 = self.var_A9A3;
	self waittill("stopRevenge");
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00.var_6647)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02 destroy();
	}
}

//Function Number: 263
func_13B2D()
{
	var_00 = self.var_C2BB;
	var_01 = self.var_A9A3;
	var_01 endon("disconnect");
	level endon("game_ended");
	self endon("stopRevenge");
	self waittill("disconnect");
	if(!isdefined(var_01))
	{
		return;
	}

	foreach(var_03 in var_01.var_6647)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_03 destroy();
	}
}

//Function Number: 264
func_12D1A()
{
	self notify("stopRevenge");
}

//Function Number: 265
func_F7E5()
{
	self.var_38EB = 1;
	thread lib_0D67::func_CAAF();
}

//Function Number: 266
func_12D09()
{
	self.var_38EB = 0;
}

//Function Number: 267
func_F880()
{
	self.var_3925 = 1;
	thread lib_0D67::func_1166B();
}

//Function Number: 268
func_12D46()
{
	self.var_3925 = 0;
}

//Function Number: 269
func_F7E4()
{
	self.var_8C1C = 1;
	thread lib_0D67::func_E88E();
}

//Function Number: 270
func_12D08()
{
	self.var_8C1C = 0;
}

//Function Number: 271
func_F7E0()
{
	lib_0DE9::func_8659("phase");
}

//Function Number: 272
func_12D05()
{
	lib_0DE9::func_865A();
}

//Function Number: 273
func_F62F()
{
	self.var_8BC2 = 1;
}

//Function Number: 274
func_12C68()
{
	self.var_8BC2 = 0;
}

//Function Number: 275
func_F630()
{
	self.var_8BC3 = 1;
	self notify("force_regeneration");
}

//Function Number: 276
func_12C69()
{
	self.var_8BC3 = 1;
}

//Function Number: 277
func_F6F1()
{
	lib_0D6F::func_F6F2();
}

//Function Number: 278
func_12CB1()
{
}

//Function Number: 279
func_F64E()
{
	lib_0D6C::func_261D();
}

//Function Number: 280
func_12C74()
{
}

//Function Number: 281
func_F64D()
{
	lib_0D68::func_2616();
}

//Function Number: 282
func_12C73()
{
}

//Function Number: 283
func_F64F()
{
	lib_0D6F::func_2620();
}

//Function Number: 284
func_12C75()
{
}

//Function Number: 285
func_F790()
{
	self.var_11B2E = "specialty_mark_targets";
	scripts\mp\perks\_perk_mark_targets::func_B381();
}

//Function Number: 286
func_12CED()
{
	self.var_11B2C = undefined;
}

//Function Number: 287
func_F65A()
{
	lib_0D6B::func_F6E6("battery");
}

//Function Number: 288
func_12C7A()
{
}

//Function Number: 289
func_F67A()
{
}

//Function Number: 290
func_12C8B()
{
}

//Function Number: 291
func_F669()
{
	self.var_8CC1 = 1;
	self notify("force_regen");
}

//Function Number: 292
func_12C84()
{
	self.var_8CC1 = undefined;
	self notify("force_regen");
}

//Function Number: 293
func_F82C()
{
	lib_0D6B::func_F6E6("scorestreak");
}

//Function Number: 294
func_12D25()
{
}

//Function Number: 295
func_F86B()
{
	self.var_11B2C = "specialty_superpack";
	lib_0D6B::func_F6E6("super");
}

//Function Number: 296
func_12D3E()
{
	self.var_11B2C = undefined;
}

//Function Number: 297
func_F84F()
{
}

//Function Number: 298
func_12D32()
{
}

//Function Number: 299
func_F6CE()
{
	scripts\mp\_utility::func_17C0("dodgeDefense",0.5,0,::func_5804);
}

//Function Number: 300
func_12CA5()
{
	scripts\mp\_utility::func_E0E6("dodgeDefense",0);
}

//Function Number: 301
func_5804(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_02.var_5812) && param_02.var_5812 && param_02 scripts\mp\_utility::_hasperk("specialty_dodge_defense"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 302
func_F6CF()
{
}

//Function Number: 303
func_12CA6()
{
}

//Function Number: 304
func_F72D()
{
	self.var_11B2C = "specialty_ground_pound";
	lib_0DE9::func_8659();
}

//Function Number: 305
func_12CC7()
{
	self.var_11B2C = undefined;
	lib_0DE9::func_865A();
}

//Function Number: 306
func_F793()
{
	self giveweapon("iw7_fistsperk_mp");
	self method_84E8("iw7_fistsperk_mp");
	if(self hasweapon("iw7_fists_mp"))
	{
		var_00 = self getcurrentweapon();
		scripts\mp\_utility::func_141E("iw7_fists_mp");
		self giveweapon("iw7_fistslethal_mp");
		if(var_00 == "iw7_fists_mp")
		{
			scripts\mp\_utility::_switchtoweapon("iw7_fistslethal_mp");
			if(isdefined(self.var_81D1) && self.var_81D1 && isdefined(self.var_10922) && self.var_10922 == "iw7_fists_mp")
			{
				self method_833B("iw7_fistslethal_mp");
				self.var_10922 = "iw7_fistslethal_mp";
				return;
			}
		}
	}
}

//Function Number: 307
func_12CEE()
{
	scripts\mp\_utility::func_141E("iw7_fistsperk_mp");
	if(self hasweapon("iw7_fistslethal_mp"))
	{
		var_00 = self getcurrentweapon();
		scripts\mp\_utility::func_141E("iw7_fistslethal_mp");
		self giveweapon("iw7_fists_mp");
		if(var_00 == "iw7_fistslethal_mp")
		{
			scripts\mp\_utility::_switchtoweapon("iw7_fists_mp");
		}
	}
}

//Function Number: 308
func_F807()
{
}

//Function Number: 309
func_12D0F()
{
}

//Function Number: 310
sethardline()
{
	self endon("death");
	self endon("disconnect");
	self endon("perk_end_hardline");
	self.hardlineactive["kills"] = 0;
	self.hardlineactive["assists"] = 0;
	thread watchhardlineassists();
	while(self.hardlineactive["kills"] < 8)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		if(isdefined(var_01) && !scripts\mp\_utility::func_9E6C(var_01))
		{
			self.hardlineactive["kills"] = self.hardlineactive["kills"] + 1;
		}
	}

	self.hardlineactive = undefined;
}

//Function Number: 311
watchhardlineassists()
{
	self endon("death");
	self endon("disconnect");
	self endon("perk_end_hardline");
	for(;;)
	{
		self waittill("assist_hardline");
		if(self.hardlineactive["assists"] == 1)
		{
			self.hardlineactive["kills"] = self.hardlineactive["kills"] + 1;
			self.hardlineactive["assists"] = 0;
			continue;
		}

		self.hardlineactive["assists"] = self.hardlineactive["assists"] + 1;
	}
}

//Function Number: 312
unsethardline()
{
	self.hardlineactive = undefined;
	self notify("perk_end_hardline");
}

//Function Number: 313
func_F74A()
{
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_01))
			{
				continue;
			}

			if(var_01.team == self.team)
			{
				continue;
			}

			if(var_01 scripts\mp\_utility::_hasperk("specialty_coldblooded"))
			{
				continue;
			}

			if(var_01 scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
			{
				continue;
			}

			if(length2d(var_01 getvelocity()) < 150 && !isdefined(var_01.var_37EE) && distance2d(self.origin,var_01.origin) < 1024)
			{
				thread func_49EE(var_01);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 314
func_49EE(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(!isdefined(self) || !scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	param_00.var_37EE = 1;
	var_01 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_01 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_01,"active",param_00.origin,"cb_compassping_sniper_enemy",self);
		scripts\mp\objidpoolmanager::minimap_objective_team(var_01,self.team);
		param_00 thread func_13A35(var_01);
	}

	while(length2d(param_00 getvelocity()) < 150)
	{
		wait(2);
	}

	scripts\mp\objidpoolmanager::returnminimapid(var_01);
	param_00.var_37EE = undefined;
}

//Function Number: 315
func_13A35(param_00)
{
	scripts\common\utility::waittill_any_3("death","disconnect");
	scripts\mp\objidpoolmanager::returnminimapid(param_00);
	self.var_37EE = undefined;
}

//Function Number: 316
func_12CD3()
{
}

//Function Number: 317
func_F7CD()
{
}

//Function Number: 318
func_12CFE()
{
}

//Function Number: 319
func_F894()
{
	thread func_E8A9();
	thread func_E8AA();
}

//Function Number: 320
func_12D4E()
{
}

//Function Number: 321
func_F7DE()
{
	self.var_11B2C = "specialty_personal_trophy";
	thread scripts\mp\_playertrophy_system::func_D446();
}

//Function Number: 322
func_12D04()
{
	self.var_11B2C = undefined;
	thread scripts\mp\_playertrophy_system::func_D448();
}

//Function Number: 323
func_F6CA()
{
	thread lib_0D6C::func_56E7();
}

//Function Number: 324
func_12CA3()
{
}

//Function Number: 325
func_F6EB()
{
	self.var_11B2C = "specialty_equipment_ping";
}

//Function Number: 326
func_12CAE()
{
	self.var_11B2C = undefined;
}

//Function Number: 327
func_F825()
{
	self.var_11B2C = "specialty_rugged_eqp";
}

//Function Number: 328
func_12D1F()
{
	self.var_11B2C = undefined;
	thread lib_0E19::supertrophy_onruggedequipmentunset();
	thread lib_0DF0::microturret_onruggedequipmentunset();
}

//Function Number: 329
func_6BC4(param_00,param_01)
{
}

//Function Number: 330
func_F78D()
{
	self.var_11B2C = "specialty_man_at_arms";
}

//Function Number: 331
func_12CEB()
{
	self.var_11B2C = undefined;
}

//Function Number: 332
func_F7CB()
{
	self endon("disconnect");
	self endon("unsetOutlineKillstreaks");
	self.engstructks = engineer_createengstruct();
	var_00 = self.engstructks;
	thread engineer_watchownerdisconnect(var_00,"unsetOutlineKillstreaks");
	for(;;)
	{
		var_01 = level.var_1655;
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.model))
				{
					if(engineer_shouldoutlineent(var_03,var_00))
					{
						engineer_addoutlinedent(var_03,var_00);
					}
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 333
func_12CFC()
{
	self notify("unsetOutlineKillstreaks");
	if(isdefined(self.engstructks))
	{
		thread engineer_clearoutlinedents(self.engstructks);
	}

	self.engstructks = undefined;
}

//Function Number: 334
func_F6E4()
{
	self endon("disconnect");
	self endon("unsetEngineer");
	self.engstructeqp = engineer_createengstruct();
	var_00 = self.engstructeqp;
	thread engineer_watchownerdisconnect(var_00,"unsetEngineer");
	for(;;)
	{
		var_01 = func_7D96();
		foreach(var_03 in var_01)
		{
			if(engineer_shouldoutlineent(var_03,var_00))
			{
				engineer_addoutlinedent(var_03,var_00);
			}
		}

		wait(0.1);
	}
}

//Function Number: 335
func_12CAB()
{
	self notify("unsetEngineer");
	if(isdefined(self.engstructeqp))
	{
		thread engineer_clearoutlinedents(self.engstructeqp);
	}

	self.engstructeqp = undefined;
}

//Function Number: 336
engineer_createengstruct()
{
	var_00 = spawnstruct();
	var_00.var_222 = self;
	var_00.var_C78E = [];
	var_00.outlinedids = [];
	return var_00;
}

//Function Number: 337
engineer_addoutlinedent(param_00,param_01)
{
	var_02 = param_00 getentitynumber();
	var_03 = param_01.outlinedids[var_02];
	if(isdefined(var_03))
	{
		thread engineer_removeoutlinedent(var_02,param_01);
	}

	var_03 = scripts\mp\_utility::func_C794(param_00,"red",param_01.var_222,0,1,"level_script");
	param_01.var_C78E[var_02] = param_00;
	param_01.outlinedids[var_02] = var_03;
	thread engineer_removeoutlinedentondeath(var_02,param_01);
}

//Function Number: 338
engineer_removeoutlinedent(param_00,param_01)
{
	param_01 notify("engineer_removeOutlinedEnt_" + param_00);
	var_02 = param_01.var_C78E[param_00];
	var_03 = param_01.outlinedids[param_00];
	scripts\mp\_utility::func_C78F(var_03,var_02);
	param_01.var_C78E[param_00] = undefined;
	param_01.outlinedids[param_00] = undefined;
}

//Function Number: 339
engineer_removeoutlinedentondeath(param_00,param_01)
{
	param_01 endon("engineer_clearOutlinedEnts");
	param_01 endon("engineer_removeOutlinedEnt_" + param_00);
	var_02 = param_01.var_C78E[param_00];
	var_02 waittill("death");
	thread engineer_removeoutlinedent(param_00,param_01);
}

//Function Number: 340
engineer_clearoutlinedents(param_00)
{
	param_00 notify("engineer_clearOutlinedEnts");
	foreach(var_03, var_02 in param_00.outlinedids)
	{
		scripts\mp\_utility::func_C78F(var_02,param_00.var_C78E[var_03]);
	}
}

//Function Number: 341
engineer_shouldoutlineent(param_00,param_01)
{
	var_02 = param_00 getentitynumber();
	if(isdefined(param_01.outlinedids[var_02]))
	{
		return 0;
	}

	var_03 = param_00.var_222;
	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_03,param_01.var_222)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 342
engineer_watchownerdisconnect(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_00.var_222 endon(param_01);
	}

	param_00 endon("engineer_clearOutlinedEnts");
	param_00.var_222 waittill("disconnect");
	thread engineer_clearoutlinedents(param_00);
}

//Function Number: 343
func_7D96()
{
	return scripts\common\utility::func_22AF(scripts\common\utility::func_2282([level.var_B779,level.var_B726,level.var_69D6,level.var_11267.var_12801,level.var_590F,level.var_2ABD,level.spidergrenade.activeagents,level.spidergrenade.proxies]));
}

//Function Number: 344
func_F693()
{
}

//Function Number: 345
func_12C90()
{
}

//Function Number: 346
func_FB15()
{
	self.var_11B2C = "specialty_wall_lock";
	thread lib_0D70::func_E8AC();
}

//Function Number: 347
func_12D66()
{
	self.var_11B2C = undefined;
}

//Function Number: 348
func_F826()
{
	self.var_11B2C = "specialty_rush";
	thread lib_0D6F::func_B947();
}

//Function Number: 349
func_12D20()
{
	self notify("removeCombatHigh");
	self.speedonkillmod = undefined;
	self.var_11B2C = undefined;
}

//Function Number: 350
func_F747()
{
	thread func_E859();
}

//Function Number: 351
func_12CD2()
{
}

//Function Number: 352
func_F7A4()
{
	self.var_11B2C = "specialty_momentum";
	thread func_E863();
}

//Function Number: 353
func_E863()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(self method_81BD())
		{
			func_848B();
			self.var_BCF6 = 1;
			scripts\mp\_weapons::func_12ED5();
		}

		wait(0.1);
	}
}

//Function Number: 354
func_848B()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("momentum_reset");
	self endon("momentum_unset");
	thread func_B944();
	thread func_B943();
	var_00 = 0;
	while(var_00 < 0.06)
	{
		self.var_BCF6 = self.var_BCF6 + 0.01;
		scripts\mp\_weapons::func_12ED5();
		wait(0.2083333);
		var_00 = var_00 + 0.01;
	}

	self notify("momentum_max_speed");
	thread momentum_endaftermax();
	self waittill("momentum_reset");
}

//Function Number: 355
momentum_endaftermax()
{
	self endon("momentum_unset");
	self waittill("momentum_reset");
}

//Function Number: 356
func_B944()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
		{
			wait(0.4);
			if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
			{
				self notify("momentum_reset");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 357
func_B943()
{
	self endon("death");
	self endon("disconnect");
	self waittill("damage");
	self notify("momentum_reset");
}

//Function Number: 358
func_12CF2()
{
	self notify("momentum_unset");
	self.var_11B2C = undefined;
}

//Function Number: 359
func_F829()
{
	self.var_11B2C = "specialty_scavenger_eqp";
	lib_0D6B::func_F6E6("equipment");
}

//Function Number: 360
func_12D22()
{
	self.var_11B2C = undefined;
}

//Function Number: 361
func_F854()
{
	thread lib_0D67::func_1091C();
}

//Function Number: 362
func_12D34()
{
	foreach(var_01 in level.players)
	{
		var_01 notify("end_spawnview");
	}
}

//Function Number: 363
func_F73C()
{
	thread lib_0DEB::func_E855();
}

//Function Number: 364
func_12CCD()
{
}

//Function Number: 365
func_F71D()
{
	self.var_11B2C = "specialty_ftlslide";
	if(scripts\mp\_utility::func_9D46() && level.tactical)
	{
		self method_845A("assassin_mlgslide_mp_tactical");
		return;
	}

	if(scripts\mp\_utility::func_9D46())
	{
		self method_845A("assassin_mlgslide_mp");
		return;
	}

	if(level.tactical)
	{
		self method_845A("assassin_slide_mp_tactical");
		return;
	}

	self method_845A("assassin_slide_mp");
}

//Function Number: 366
func_12CC3()
{
	self.var_11B2C = undefined;
}

//Function Number: 367
func_F753()
{
	thread lib_0D70::func_E7FE();
}

//Function Number: 368
func_12CD6()
{
}

//Function Number: 369
func_F721()
{
	thread func_12EA3();
}

//Function Number: 370
func_12CC6()
{
	thread func_E127();
}

//Function Number: 371
func_F86D()
{
	self endon("disconnect");
	self.var_11B2C = "specialty_support_killstreaks";
	self waittill("equipKillstreaksFinished");
	if(!isdefined(self.pers["killstreaks"][1]))
	{
		foreach(var_01 in self.pers["killstreaks"])
		{
			var_01.var_5FB9 = 0;
		}
	}
}

//Function Number: 372
func_12D40()
{
	self notify("end_support_killstreaks");
	self.var_11B2C = undefined;
}

//Function Number: 373
func_F7D2()
{
	self.var_C829 = 0.98;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 374
func_12D02()
{
	self.var_C829 = undefined;
}

//Function Number: 375
func_F657()
{
	self setclientomnvar("ui_uplink_carrier_hud",1);
	if(level.var_218A == 0)
	{
		self setclientomnvar("ui_uplink_carrier_armor_max",100);
	}
	else
	{
		self setclientomnvar("ui_uplink_carrier_armor_max",level.var_3AEC);
	}

	if(level.var_D6AF != 0)
	{
		self setclientomnvar("ui_uplink_timer_hud",1);
	}
}

//Function Number: 376
func_12C77()
{
	self notify("unsetBallCarrier");
	self setclientomnvar("ui_uplink_carrier_hud",0);
	self setclientomnvar("ui_uplink_carrier_armor",-1);
	if(level.var_D6AF != 0)
	{
		self setclientomnvar("ui_uplink_timer_hud",0);
	}
}

//Function Number: 377
func_F694()
{
	self.var_11B2C = "specialty_cloak_aerial";
}

//Function Number: 378
func_12C91()
{
	self.var_11B2C = undefined;
}

//Function Number: 379
func_F852()
{
	self.var_11B2C = "specialty_spawn_radar";
	self.var_8C2B = 1;
}

//Function Number: 380
func_12D33()
{
	self.var_11B2C = undefined;
	self.var_8C2B = 1;
}

//Function Number: 381
func_F752()
{
}

//Function Number: 382
func_12CD5()
{
}

//Function Number: 383
func_F886()
{
}

//Function Number: 384
func_12D4A()
{
}

//Function Number: 385
func_F631()
{
	self.var_11B2C = "specialty_ads_awareness";
	thread func_E832();
	self setscriptablepartstate("heightened_senses","default");
}

//Function Number: 386
func_E832()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetADSAwareness");
	self.awarenessradius = 256;
	self.awarenessqueryrate = 2;
	thread awarenessmonitorstance();
	for(;;)
	{
		wait(self.awarenessqueryrate);
		foreach(var_01 in level.players)
		{
			if(var_01.team == self.team)
			{
				continue;
			}

			if(var_01 scripts\mp\_utility::_hasperk("specialty_coldblooded"))
			{
				continue;
			}

			if(var_01 isonground() && !var_01 method_81BD() && !var_01 method_8446() && !var_01 method_81BE())
			{
				continue;
			}

			if(distance2d(var_01.origin,self.origin) < self.awarenessradius)
			{
				thread playincomingwarning(var_01);
			}
		}
	}
}

//Function Number: 387
playincomingwarning(param_00)
{
	self setscriptablepartstate("heightened_senses","scrn_pulse");
	self playrumbleonentity("damage_heavy");
	param_00 playsoundtoplayer("ghost_senses_ping",self);
	wait(0.2);
	if(isdefined(self))
	{
		self setscriptablepartstate("heightened_senses","default");
		if(scripts\mp\_utility::func_9F19(self))
		{
			self playrumbleonentity("damage_heavy");
			if(isdefined(param_00) && scripts\mp\_utility::func_9F19(param_00))
			{
				param_00 playsoundtoplayer("ghost_senses_ping",self);
				return;
			}
		}
	}
}

//Function Number: 388
awarenessmonitorstance()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getstance();
		var_01 = self getvelocity();
		switch(var_00)
		{
			case "stand":
				self.awarenessradius = 400;
				self.awarenessqueryrate = 2;
				break;
	
			case "crouch":
				self.awarenessradius = 650;
				self.awarenessqueryrate = 1;
				break;
	
			case "prone":
				self.awarenessradius = 700;
				self.awarenessqueryrate = 0.5;
				break;
		}

		wait(0.01);
	}
}

//Function Number: 389
awarenessaudiopulse()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_awareness");
	for(;;)
	{
		playsoundatpos(self.origin + (0,0,5),"ghost_senses_ping");
		wait(2);
	}
}

//Function Number: 390
func_12C6B()
{
	self notify("unsetADSAwareness");
	self.var_11B2C = undefined;
	self setscriptablepartstate("heightened_senses","default");
}

//Function Number: 391
func_F815()
{
	self.var_11B2C = "specialty_rearguard";
	scripts\mp\perks\_perk_rearguard_shield::func_E814();
}

//Function Number: 392
func_12D14()
{
	self.var_11B2C = undefined;
	self.var_8C19 = undefined;
}

//Function Number: 393
func_F675()
{
	self.var_3248 = spawnstruct();
	self.var_3248.player = self;
	self.var_3248.var_639D = [];
	self.var_3248.var_655F = [];
	self.var_3248.var_6556 = [];
	self.var_3248 thread func_139B6();
	self.var_3248 thread func_139B7();
}

//Function Number: 394
func_12C88()
{
	self notify("unsetBulletOutline");
	self.var_3248 = undefined;
}

//Function Number: 395
func_139B6()
{
	self.player endon("death");
	self.player endon("disconnect");
	self.player endon("unsetBulletOutline");
	while(isdefined(self.player))
	{
		var_00 = gettime();
		foreach(var_03, var_02 in self.var_639D)
		{
			if(!isdefined(var_02))
			{
				func_324C(undefined,var_03);
				continue;
			}

			if(var_02 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
			{
				func_324C(var_02,var_03);
				continue;
			}

			if(var_00 >= self.var_6556[var_03])
			{
				func_324C(var_02,var_03);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 396
func_139B7()
{
	self.player scripts\common\utility::waittill_any_3("disconnect","unsetBulletOutline");
	foreach(var_02, var_01 in self.var_639D)
	{
		if(isdefined(var_01))
		{
			func_324C(var_01,var_02);
		}
	}
}

//Function Number: 397
func_3249(param_00,param_01,param_02)
{
	var_03 = param_00 getentitynumber();
	var_04 = gettime() + param_01 * 1000;
	self.var_639D[var_03] = param_00;
	if(!isdefined(self.var_655F[var_03]))
	{
		self.var_655F[var_03] = scripts\mp\_utility::func_C794(param_00,"red",self.player,1,0,"perk");
	}

	if(!isdefined(self.var_6556[var_03]) || !isdefined(param_02) || param_02)
	{
		self.var_6556[var_03] = var_04;
	}
}

//Function Number: 398
func_324C(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00 getentitynumber();
	}

	self.var_639D[param_01] = undefined;
	self.var_6556[param_01] = undefined;
	if(isdefined(param_00))
	{
		scripts\mp\_utility::func_C78F(self.var_655F[param_01],param_00);
	}

	self.var_655F[param_01] = undefined;
}

//Function Number: 399
func_324B(param_00,param_01,param_02,param_03)
{
	if(!param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_EXPLOSIVE_BULLET")
	{
		return;
	}

	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(!isplayer(param_00) || scripts\mp\_utility::func_9F22(param_00) || !isplayer(param_01) || scripts\mp\_utility::func_9F22(param_01))
	{
		return;
	}

	var_04 = param_00;
	if(isdefined(param_00.var_222))
	{
		var_04 = param_00.var_222;
	}

	var_05 = param_01;
	if(isdefined(param_01.var_222))
	{
		var_05 = param_01.var_222;
	}

	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_04,var_05)))
	{
		return;
	}

	if(isplayer(param_00) && isplayer(param_01) && scripts\mp\_utility::func_C7A0(param_00 geteye(),param_01 geteye()))
	{
		return;
	}

	if(isdefined(param_00.var_3248) && !param_01 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
	{
		param_00.var_3248 func_3249(param_01,1);
	}

	if(isdefined(param_01.var_3248) && !param_00 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
	{
		param_01.var_3248 func_3249(param_00,2,0);
	}
}

//Function Number: 400
func_E8A9()
{
	self endon("death");
	self endon("disconnect");
	var_00 = scripts\mp\_utility::func_81EC();
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(!isdefined(var_02) || !scripts\mp\_utility::func_9F19(var_02))
			{
				continue;
			}

			if(var_02.team == self.team || var_02 == self)
			{
				continue;
			}

			if(var_02 scripts\mp\_utility::_hasperk("specialty_empimmune"))
			{
				continue;
			}

			if(var_02 lib_0DDF::func_9FC1())
			{
				thread func_B375(var_02,var_00);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 401
func_E8AA()
{
	self endon("death");
	self endon("disconnect");
	self endon("track_killstreak_end");
	for(;;)
	{
		if(scripts\mp\_utility::func_9FC6())
		{
			scripts\common\utility::func_136F7();
			scripts\mp\_utility::func_E150("specialty_tracker");
			while(scripts\mp\_utility::func_9FC6())
			{
				scripts\common\utility::func_136F7();
			}

			scripts\mp\_utility::func_8387("specialty_tracker");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 402
func_B375(param_00,param_01)
{
	if(!isdefined(param_00.var_61AA))
	{
		param_00.var_61AA = [];
	}

	if(isdefined(param_00.var_61AA[param_01]) && param_00.var_61AA[param_01] == "active")
	{
		return;
	}

	param_00.var_61AA[param_01] = "active";
	thread func_61C2(param_00,param_01);
	param_00 scripts\common\utility::waittill_any_3("death","cloak_end");
	param_00.var_61AA[param_01] = undefined;
}

//Function Number: 403
func_61C2(param_00,param_01)
{
	var_02 = ["j_shoulder_ri","j_shoulder_le","j_hip_ri","j_hip_le","j_spine4","j_wrist_ri","j_wrist_le"];
	while(param_00 lib_0DDF::func_9FC1())
	{
		playfxontagforclients(scripts\common\utility::getfx("tracker_cloak_tag"),param_00,var_02[randomint(var_02.size - 1)],self);
		wait(0.25);
	}

	param_00.var_61AA[param_01] = undefined;
}

//Function Number: 404
func_12EA3()
{
	self endon("remove_gpsjammer");
	self endon("death");
	self endon("disconnect");
	if(isai(self))
	{
		while(isdefined(self.var_26B9) && self.var_26B9 > 0)
		{
			scripts\common\utility::func_136F7();
		}
	}

	if(level.var_B7CC == 0)
	{
		return;
	}

	if(level.var_1190C < 0.05)
	{
		return;
	}

	var_00 = 1;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = self.origin;
	var_07 = 0;
	if(1)
	{
		var_07 = 1;
		self method_8522(1);
		thread ghostadvanceduavwatcher();
		return;
	}

	thread ghostadvanceduavwatcher();
	for(;;)
	{
		var_07 = 0;
		if(scripts\mp\_utility::func_9FC6() || scripts\common\utility::istrue(self.var_9EE6) || scripts\common\utility::istrue(self.var_9DBC) || self ismantling())
		{
			var_07 = 1;
		}
		else
		{
			if(var_05 > 1)
			{
				var_05 = 0;
				if(distancesquared(var_06,self.origin) < level.var_B75E)
				{
					var_02 = 1;
				}
				else
				{
					var_02 = 0;
				}

				var_06 = self.origin;
			}

			var_08 = self getvelocity();
			var_09 = lengthsquared(var_08);
			if(var_09 > level.var_B7CC && var_02 == 0)
			{
				var_07 = 1;
			}
		}

		if(var_07 == 1)
		{
			var_03 = 0;
			if(var_00 == 0)
			{
				var_01 = 0;
				var_00 = 1;
				self method_8522(1);
			}
		}
		else
		{
			var_03++;
			if(var_00 == 1 && var_03 >= level.var_848A)
			{
				var_01 = 1;
				var_00 = 0;
				self method_8522(0);
			}
		}

		if(var_01 == 1)
		{
			level notify("radar_status_change");
		}

		var_05 = var_05 + level.var_1190C;
		wait(level.var_1190C);
	}
}

//Function Number: 405
ghostadvanceduavwatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_gpsjammer");
	for(;;)
	{
		if(level.teambased)
		{
			if(isdefined(level.activeadvanceduavs) && scripts\mp\_utility::func_9FB3(level.activeadvanceduavs[scripts\mp\_utility::getotherteam(self.team)]))
			{
				self method_8522(0);
				while(scripts\mp\_utility::func_9FB3(level.activeadvanceduavs[scripts\mp\_utility::getotherteam(self.team)]))
				{
					scripts\common\utility::func_136F7();
				}

				self method_8522(1);
			}
		}
		else
		{
			foreach(var_01 in level.players)
			{
				if(var_01 == self)
				{
					continue;
				}

				if(scripts\mp\_utility::func_9FB3(level.activeadvanceduavs[var_01.var_86BD]) && level.activeadvanceduavs[var_01.var_86BD] > 0)
				{
					self method_8522(0);
					while(scripts\mp\_utility::func_9FB3(level.activeadvanceduavs[var_01.var_86BD]) && level.activeadvanceduavs[var_01.var_86BD] > 0)
					{
						level waittill("uav_update");
					}

					self method_8522(1);
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 406
func_E127()
{
	self notify("remove_gpsjammer");
	self method_8522(0);
}

//Function Number: 407
func_F72F()
{
	level._effect["groundPoundShield_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	thread lib_0DE9::func_8655(6,8,::func_866A,"groundPoundShield_unset");
}

//Function Number: 408
func_12CC9()
{
	self notify("groundPoundShield_unset");
}

//Function Number: 409
func_866A(param_00)
{
	thread func_866C();
}

//Function Number: 410
func_866C()
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundLand");
	wait(0.25);
	func_866B();
}

//Function Number: 411
func_866B()
{
	if(isdefined(self.var_865C))
	{
		thread func_8662(self.var_865C);
	}

	var_00 = self.origin + anglestoforward(self.angles) * 5;
	var_01 = self.angles + (0,90,0);
	var_02 = spawn("script_model",var_00);
	var_02.angles = var_01;
	var_02 setmodel("weapon_shinguard_col_wm");
	var_03 = spawn("script_model",var_00);
	var_03.angles = var_01;
	var_03 setmodel("weapon_shinguard_fr_wm");
	var_03.var_C79D = scripts\mp\_utility::func_C793(var_03,"cyan",0,0,"equipment");
	var_04 = spawn("script_model",var_00);
	var_04.angles = var_01;
	var_04 setmodel("weapon_shinguard_en_wm");
	var_04.var_C79D = scripts\mp\_utility::func_C793(var_04,"orange",0,0,"equipment");
	var_02.var_13434 = var_03;
	var_02.var_13433 = var_04;
	var_02.var_222 = self;
	var_02 setcandamage(1);
	var_02 method_847F(1);
	var_02.health = 9999;
	var_02.var_FC9B = 210;
	self.var_865C = var_02;
	var_05 = level.var_3CB5;
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(level.teambased && var_07.team == self.team)
		{
			var_04 method_8429(var_07);
			continue;
		}

		var_03 method_8429(var_07);
	}

	thread func_8669(var_02);
	thread func_8665(var_02);
	thread func_8666(var_02,3.25);
	thread func_8664(var_02);
	thread func_8660(var_02);
	thread func_8668(var_02);
	thread func_8658();
	return var_02;
}

//Function Number: 412
func_8662(param_00)
{
	self notify("groundPoundShield_end");
	if(!isdefined(param_00))
	{
		return;
	}

	thread func_8663();
	thread func_8661(param_00);
}

//Function Number: 413
func_865D(param_00)
{
	self notify("groundPoundShield_end");
	if(!isdefined(param_00))
	{
		return;
	}

	thread func_865E();
	thread func_8661(param_00);
}

//Function Number: 414
func_8668(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isdefined(var_02))
		{
			if(var_02 == self || var_02.team != self.team)
			{
				param_00.var_FC9B = param_00.var_FC9B - var_01;
			}
		}

		param_00.health = 9999;
		thread func_865F(var_02,var_04,var_03);
		if(param_00.var_FC9B <= 0)
		{
			thread func_865D(param_00);
			return;
		}
		else if(param_00.var_FC9B <= 105)
		{
			if(param_00.var_13434.model != "weapon_shinguard_dam_wm")
			{
				param_00.var_13434 setmodel("weapon_shinguard_dam_wm");
				scripts\mp\_utility::func_C7AA(param_00.var_13434);
			}

			if(param_00.var_13433.model != "weapon_shinguard_dam_wm")
			{
				param_00.var_13433 setmodel("weapon_shinguard_dam_wm");
				scripts\mp\_utility::func_C7AA(param_00.var_13433);
			}
		}
	}
}

//Function Number: 415
func_8664(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	var_01 = self isjumping();
	var_02 = undefined;
	for(;;)
	{
		var_02 = var_01;
		var_01 = self isjumping();
		if(!var_02 && var_01)
		{
			thread func_8662(param_00);
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 416
func_8666(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	wait(param_01);
	thread func_8662(param_00);
}

//Function Number: 417
func_8665(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	while(isdefined(param_00))
	{
		if(lengthsquared(param_00.origin - self.origin) > 11664)
		{
			thread func_8662(param_00);
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 418
func_8660(param_00)
{
	self endon("groundPoundShield_deleteShield");
	scripts\common\utility::waittill_any_3("death","disconnect","groundPound_unset");
	thread func_8661(param_00);
}

//Function Number: 419
func_8669(param_00)
{
	self endon("groundPoundShield_deleteShield");
	var_01 = self.team;
	for(;;)
	{
		level waittill("joined_team",var_02);
		if(level.teambased && var_02.team == var_01)
		{
			param_00.var_13434 showtoplayer(var_02);
			param_00.var_13433 method_8429(var_02);
			continue;
		}

		param_00.var_13434 method_8429(var_02);
		param_00.var_13433 showtoplayer(var_02);
	}
}

//Function Number: 420
func_8661(param_00)
{
	self notify("groundPoundShield_deleteShield");
	scripts\mp\_utility::func_C78F(param_00.var_13434.var_C79D,param_00.var_13434);
	scripts\mp\_utility::func_C78F(param_00.var_13433.var_C79D,param_00.var_13433);
	param_00.var_13434 delete();
	param_00.var_13433 delete();
	param_00 delete();
}

//Function Number: 421
func_8658()
{
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	self playlocalsound("heavy_shield_up");
	self playsoundtoteam("heavy_shield_up_npc","axis",self);
	self playsoundtoteam("heavy_shield_up_npc","allies",self);
}

//Function Number: 422
func_8663()
{
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	self playlocalsound("heavy_shield_down");
	self playsoundtoteam("heavy_shield_down_npc","axis",self);
	self playsoundtoteam("heavy_shield_down_npc","allies",self);
}

//Function Number: 423
func_865F(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
	playfx(scripts\common\utility::getfx("groundPoundShield_impact"),param_01,-1 * param_02);
	playsoundatpos(param_01,"ds_shield_impact");
	param_00 scripts\mp\_damagefeedback::func_12E84("hitbulletstorm");
}

//Function Number: 424
func_865E()
{
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShield_end");
	self endon("groundPoundShield_deleteShield");
}

//Function Number: 425
func_F730()
{
	level._effect["groundPoundShock_impact_sm"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	thread lib_0DE9::func_8655(7,8,::func_866E,"groundPoundShock_unset");
}

//Function Number: 426
func_12CCA()
{
	self notify("groundPoundShock_unset");
}

//Function Number: 427
func_866E(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	self endon("groundPoundShock_unset");
	var_01 = undefined;
	var_02 = undefined;
	switch(param_00)
	{
		case "groundPoundLandTier0":
			var_02 = scripts\common\utility::getfx("groundPoundShock_impact_sm");
			var_01 = 144;
			break;

		case "groundPoundLandTier1":
			var_02 = scripts\common\utility::getfx("groundPoundShock_impact_sm");
			var_01 = 180;
			break;

		case "groundPoundLandTier2":
			var_02 = scripts\common\utility::getfx("groundPoundShock_impact_lrg");
			var_01 = 216;
			break;
	}

	thread func_866F(var_01,var_02);
	var_03 = undefined;
	if(level.teambased)
	{
		var_03 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(self.team));
	}
	else
	{
		var_03 = level.var_3CB5;
	}

	var_04 = var_01 * var_01;
	var_05 = scripts\common\trace::func_48BC(0,1,0,0,1,0,0);
	foreach(var_07 in var_03)
	{
		if(!isdefined(var_07) || var_07 == self || !var_07 scripts\mp\killstreaks\_emp_common::func_FFC5())
		{
			continue;
		}

		if(lengthsquared(var_07 geteye() - self geteye()) > var_04)
		{
			continue;
		}

		var_08 = function_0287(self geteye(),var_07 geteye(),var_05,undefined,0,"physicsquery_closest");
		if(isdefined(var_08) && var_08.size > 0)
		{
			continue;
		}

		thread func_866D(var_07);
	}

	var_0A = scripts\mp\_weapons::func_7E8C(self.origin,var_01,0,undefined);
	foreach(var_0C in var_0A)
	{
		if(isdefined(var_0C.var_222) && !scripts\mp\_weapons::func_7415(self,var_0C.var_222))
		{
			continue;
		}

		var_0C notify("emp_damage",self,3);
	}
}

//Function Number: 428
func_866D(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 scripts\mp\killstreaks\_emp_common::func_20C3();
	scripts\mp\_gamescore::func_11ACE(self,param_00,"groundpound_mp");
	param_00 shellshock("concussion_grenade_mp",3);
	wait(3);
	param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
	if(isdefined(self))
	{
		scripts\mp\_gamescore::func_12D6F(self,param_00,"groundpound_mp");
	}
}

//Function Number: 429
func_866F(param_00,param_01)
{
	playfx(param_01,self.origin + (0,0,20),(0,0,1));
}

//Function Number: 430
func_F72E()
{
	thread lib_0DE9::func_8655(8,8,::func_865B,"groundPoundBoost_unset");
}

//Function Number: 431
func_12CC8()
{
	self notify("groundPoundBoost_unset");
}

//Function Number: 432
func_865B(param_00)
{
	scripts\common\utility::func_F367(self method_842D(0));
}

//Function Number: 433
func_F65D()
{
	level._effect["battleSlideShield_damage"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	thread func_2904();
}

//Function Number: 434
func_12C7D()
{
	self notify("battleSlideShield_unset");
}

//Function Number: 435
func_2904()
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self notify("battleSlideShield_monitor");
	self endon("battleSlideShield_monitor");
	for(;;)
	{
		self waittill("sprint_slide_begin");
		thread func_2906();
	}
}

//Function Number: 436
func_2905(param_00)
{
	self endon("disconnect");
	self endon("battleSlide_unset");
	while(isdefined(param_00))
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		thread func_28FB(param_00,var_02,var_04,var_03);
		if(param_00.health <= 0)
		{
			thread func_28F9(param_00);
			param_00 delete();
			continue;
		}

		if(param_00.health <= 125)
		{
			if(param_00.model != "weapon_shinguard_dam_wm")
			{
				param_00 setmodel("weapon_shinguard_dam_wm");
			}

			continue;
		}

		if(param_00.model != "weapon_shinguard_wm")
		{
			param_00 setmodel("weapon_shinguard_wm");
		}
	}
}

//Function Number: 437
func_2906()
{
	if(isdefined(self.var_28F8))
	{
		thread func_2900(self.var_28F8);
	}

	var_00 = scripts\common\utility::spawn_tag_origin();
	var_00 setmodel("weapon_shinguard_wm");
	var_00 setcandamage(1);
	var_00.health = 250;
	var_00 linkto(self,"tag_origin",(30,0,0),(0,90,0));
	var_00 show();
	self.var_28F8 = var_00;
	thread func_28FD(var_00);
	thread func_28FE(var_00);
	thread func_28FF(var_00);
	thread func_2909(var_00);
	thread func_2905(var_00);
	thread func_28FC(var_00);
	thread func_2907(var_00);
	return var_00;
}

//Function Number: 438
func_2900(param_00)
{
	self notify("battleSlideShield_end");
	if(!isdefined(param_00))
	{
		return;
	}

	thread func_2901(param_00);
	param_00 delete();
}

//Function Number: 439
func_28FC(param_00)
{
	param_00 endon("death");
	scripts\common\utility::waittill_any_3("death","disconnect","battleSlide_unset");
	param_00 delete();
}

//Function Number: 440
func_28FD(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_unlink");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	for(;;)
	{
		if(!self isonground())
		{
			param_00 delete();
			self notify("battleSlideShield_end");
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 441
func_28FE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_unlink");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	self waittill("sprint_begin");
	param_00 delete();
	self notify("battleSlideShield_end");
}

//Function Number: 442
func_2902(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	for(;;)
	{
		if(lengthsquared(param_00.origin - self.origin) > 11664)
		{
			thread func_2900(param_00);
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 443
func_2903(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	wait(3.5);
	thread func_2900(param_00);
}

//Function Number: 444
func_2908(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 unlink();
	self notify("battleSlideShield_unlink");
	thread func_2903(param_00);
	thread func_2902(param_00);
	self notify("battleSlideShield_unlink");
}

//Function Number: 445
func_28FF(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_unlink");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	self waittill("sprint_slide_end");
	wait(0.75);
	param_00 delete();
	self notify("battleSlideShield_end");
}

//Function Number: 446
func_2909(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	self endon("battleSlideShield_unlink");
	self endon("battleSlideShield_end");
	param_00 endon("death");
	self waittill("sprint_slide_end");
	for(;;)
	{
		if(lengthsquared(self getvelocity()) < 100)
		{
			thread func_2908(param_00);
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 447
func_28F9(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	thread func_28FA(param_00);
	self notify("battleSlideShield_end");
}

//Function Number: 448
func_2907(param_00)
{
	self endon("disconnect");
	self endon("battleSlide_unset");
	param_00 endon("death");
	self playlocalsound("heavy_shield_up");
	self playsoundtoteam("heavy_shield_up_npc","axis",self);
	self playsoundtoteam("heavy_shield_up_npc","allies",self);
}

//Function Number: 449
func_2901(param_00)
{
	self endon("disconnect");
	self endon("battleSlide_unset");
	param_00 endon("death");
	self playlocalsound("heavy_shield_down");
	self playsoundtoteam("heavy_shield_down_npc","axis",self);
	self playsoundtoteam("heavy_shield_down_npc","allies",self);
}

//Function Number: 450
func_28FB(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("battleSlide_unset");
	param_00 endon("death");
	playfx(scripts\common\utility::getfx("battleSlideShield_damage"),param_02,-1 * param_03);
	playsoundatpos(param_02,"ds_shield_impact");
	param_01 scripts\mp\_damagefeedback::func_12E84("hitbulletstorm");
}

//Function Number: 451
func_28FA(param_00)
{
}

//Function Number: 452
func_F65C()
{
}

//Function Number: 453
func_12C7C()
{
}

//Function Number: 454
func_7DF8()
{
	return 100;
}

//Function Number: 455
func_F888()
{
	level._effect["thrusterRadFr"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr");
	level._effect["thrusterRadEn"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en");
	func_11886();
}

//Function Number: 456
func_12D4B()
{
	if(isdefined(self.var_1188A))
	{
		self.var_1188A delete();
	}

	self notify("thruster_unset");
}

//Function Number: 457
func_11886()
{
	self endon("death");
	self endon("disconnect");
	self endon("thruster_unset");
	level endon("game_ended");
	for(;;)
	{
		self waittill("doubleJumpBoostBegin");
		thread func_11878();
		thread func_11870();
	}
}

//Function Number: 458
func_11878()
{
	self endon("death");
	self endon("disconnect");
	self endon("thruster_unset");
	level endon("game_ended");
	self endon("doubleJumpBoostEnd");
	if(!scripts\mp\_utility::_hasperk("specialty_quieter"))
	{
		self playsoundonmovingent("demolition_jump_expl");
	}

	thread func_11885();
	if(!isdefined(self.var_1188A))
	{
		self.var_1188A = spawn("script_model",self.origin);
		self.var_1188A setmodel("tag_origin");
	}
	else
	{
		self.var_1188A.origin = self.origin;
	}

	wait(0.05);
	for(;;)
	{
		self playrumbleonentity("damage_light");
		scripts\mp\_shellshock::func_1245(0.1,0.3,self.origin,120);
		var_00 = playerphysicstrace(self.origin + (0,0,10),self.origin - (0,0,600)) + (0,0,1);
		self.var_1188A.origin = var_00;
		self.var_1188A.angles = (90,0,0);
		wait(0.05);
		scripts\mp\_utility::func_D486(self.var_1188A,"tag_origin",self.team,scripts\common\utility::getfx("thrusterRadFr"),scripts\common\utility::getfx("thrusterRadEn"));
		wait(0.33);
	}
}

//Function Number: 459
func_11870()
{
	self endon("death");
	self endon("disconnect");
	self endon("thruster_unset");
	level endon("game_ended");
	self endon("doubleJumpBoostEnd");
	for(;;)
	{
		scripts\mp\_utility::func_DC0B(self.origin,12,64,5,12,self,undefined,"MOD_IMPACT","thruster_mp",1);
		wait(0.05);
	}
}

//Function Number: 460
func_11885()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("doubleJumpBoostEnd","thruster_unset");
	wait(0.05);
}

//Function Number: 461
func_E859()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		if(self method_8416() && self method_822E() > 0.3 && self method_842B(0) > 0)
		{
			func_68D6();
			thread func_13AA5();
			self waittill("hover_ended");
			func_6334();
		}

		wait(0.1);
	}
}

//Function Number: 462
func_13AA5()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self endon("walllock_ended");
	while(self method_822E() > 0.3)
	{
		wait(0.05);
	}

	self notify("hover_ended");
}

//Function Number: 463
func_68D6()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self.var_9E37 = 1;
	self allowmovement(0);
	self allowjump(0);
	self playlocalsound("ghost_wall_attach");
	var_00 = scripts\common\utility::spawn_tag_origin();
	self playerlinkto(var_00);
	thread func_B2F5(var_00);
}

//Function Number: 464
func_B2F5(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	var_01 = self method_8433(0);
	self method_8434(0,1);
	wait(2);
	self notify("hover_ended");
	self method_8434(0,var_01);
	self method_842C(0,0);
}

//Function Number: 465
func_6334()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self.var_9E37 = undefined;
	self allowmovement(1);
	self allowjump(1);
	self playlocalsound("ghost_wall_detach");
	self unlink();
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_helicopter_flock.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 851 ms
 * Timestamp: 10/27/2023 12:28:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachevehicle("attack_littlebird_mp");
	precachemodel("vehicle_apache_mp");
	precachemodel("vehicle_apache_mg");
	precacheturret("apache_minigun_mp");
	precachevehicle("apache_strafe_mp");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("littlebird_flock",::func_128ED);
	level.var_8D4F = [];
}

//Function Number: 2
func_128ED(param_00,param_01)
{
	var_02 = 5;
	if(func_8DB7() || scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	scripts\mp\_utility::func_93FA();
	scripts\mp\_utility::func_93FA();
	scripts\mp\_utility::func_93FA();
	scripts\mp\_utility::func_93FA();
	var_03 = func_F1C9(param_00,"littlebird_flock");
	if(!isdefined(var_03) || !var_03)
	{
		scripts\mp\_utility::func_4FC1();
		scripts\mp\_utility::func_4FC1();
		scripts\mp\_utility::func_4FC1();
		scripts\mp\_utility::func_4FC1();
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	level thread scripts\mp\_utility::func_115DE("used_littlebird_flock",self,self.team);
	return 1;
}

//Function Number: 3
func_8DB7()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_8D4F.size;var_01++)
	{
		if(isdefined(level.var_8D4F[var_01]))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 4
func_F1C9(param_00,param_01)
{
	self playlocalsound(game["voice"][self.team] + "KS_lbd_inposition");
	scripts\mp\_utility::func_1197(param_01,"map_artillery_selector",1,500);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_02,var_03);
	if(func_8DB7() || scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		self notify("cancel_location");
		return 0;
	}

	level.var_8D4F = [];
	level.var_8D50 = [];
	thread func_AD8A();
	thread func_6CDC(param_00,var_02,::func_3785,var_03);
	self setblurforplayer(0,0.3);
	return 1;
}

//Function Number: 5
func_AD8A()
{
	self endon("death");
	self endon("disconnect");
	self playlocalsound(game["voice"][self.team] + "KS_hqr_littlebird");
	wait(3);
	self playlocalsound(game["voice"][self.team] + "KS_lbd_inbound");
}

//Function Number: 6
func_6CDC(param_00,param_01,param_02,param_03)
{
	self notify("used");
	wait(0.05);
	thread scripts\mp\_utility::stoplocationselection(0);
	if(isdefined(self))
	{
		self thread [[ param_02 ]](param_00,param_01,param_03);
	}
}

//Function Number: 7
func_3785(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	thread func_89D0();
	var_03 = func_7EBE(param_01,param_02,0);
	var_04 = func_7EBE(param_01,param_02,-520);
	var_05 = func_7EBE(param_01,param_02,520);
	var_06 = func_7EBE(param_01,param_02,-1040);
	var_07 = func_7EBE(param_01,param_02,1040);
	level thread func_58E8(param_00,self,var_03,0);
	wait(0.3);
	level thread func_58E8(param_00,self,var_04,1);
	level thread func_58E8(param_00,self,var_05,2);
	wait(0.3);
	level thread func_58E8(param_00,self,var_06,3);
	level thread func_58E8(param_00,self,var_07,4);
	scripts\mp\_matchdata::func_AFC9("littlebird_flock",param_01);
}

//Function Number: 8
func_7EBE(param_00,param_01,param_02)
{
	param_00 = param_00 * (1,1,0);
	var_03 = (0,param_01,0);
	var_04 = 12000;
	var_05 = [];
	if(isdefined(param_02) && param_02 != 0)
	{
		param_00 = param_00 + anglestoright(var_03) * param_02 + (0,0,randomint(300));
	}

	var_06 = param_00 + anglestoforward(var_03) * -1 * var_04;
	var_07 = param_00 + anglestoforward(var_03) * var_04;
	var_08 = scripts\mp\killstreaks\_airdrop::func_7EC0(param_00) + 256;
	var_05["start"] = var_06 + (0,0,var_08);
	var_05["end"] = var_07 + (0,0,var_08);
	return var_05;
}

//Function Number: 9
func_58E8(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(!isdefined(param_01))
	{
		return;
	}

	var_04 = vectortoangles(param_02["end"] - param_02["start"]);
	var_05 = func_1082F(param_01,param_02["start"],var_04,param_03);
	var_05.var_AC68 = param_00;
	var_05.var_1D41 = 0;
	var_05 thread func_13B7E();
	var_05 thread func_139E8();
	var_05 thread func_6F4A();
	var_05 thread func_10DBD();
	var_05 thread func_B9E7();
	var_05 endon("death");
	var_05 method_830A(120,60);
	var_05 method_83E5(48,48);
	var_05 method_8362(param_02["end"],0);
	var_05 waittill("goal");
	var_05 method_830A(30,40);
	var_05 method_83E5(32,32);
	var_05 method_8362(param_02["start"],0);
	wait(2);
	var_05 method_830A(100,60);
	var_05 method_83E5(64,64);
	var_05 waittill("goal");
	var_05 notify("gone");
	var_05 scripts\mp\killstreaks\_helicopter::func_E139();
}

//Function Number: 10
func_1082F(param_00,param_01,param_02,param_03)
{
	var_04 = spawnhelicopter(param_00,param_01,param_02,"apache_strafe_mp","vehicle_apache_mp");
	if(!isdefined(var_04))
	{
		return;
	}

	var_04 scripts\mp\killstreaks\_helicopter::func_1852();
	var_04 thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_04.health = 999999;
	var_04.maxhealth = 2000;
	var_04.var_E1 = 0;
	var_04 setcandamage(1);
	var_04.var_222 = param_00;
	var_04.team = param_00.team;
	var_04.var_A644 = 0;
	var_04.var_110EA = "littlebird_flock";
	var_04.var_8DD9 = "littlebird";
	var_04.var_10955 = ::func_3758;
	var_05 = spawnturret("misc_turret",var_04.origin,"apache_minigun_mp");
	var_05 linkto(var_04,"tag_turret",(0,0,0),(0,0,0));
	var_05 setmodel("vehicle_apache_mg");
	var_05.angles = var_04.angles;
	var_05.var_222 = var_04.var_222;
	var_05.team = var_05.var_222.team;
	var_05 method_81F5();
	var_05.var_131A0 = var_04;
	var_06 = var_04.origin + anglestoforward(var_04.angles) * -200 + anglestoright(var_04.angles) * -200 + (0,0,50);
	var_05.var_A63A = spawn("script_model",var_06);
	var_05.var_A63A setscriptmoverkillcam("explosive");
	var_05.var_A63A linkto(var_04,"tag_origin");
	var_04.var_B6BC = var_05;
	var_04.var_B6BC method_82D1(0);
	var_04.var_B6BC method_830F("auto_nonai");
	var_04.var_B6BC method_8336(var_04.var_222);
	if(level.teambased)
	{
		var_04.var_B6BC method_835E(var_04.var_222.team);
	}

	level.var_8D4F[param_03] = var_04;
	return var_04;
}

//Function Number: 11
func_13B7E()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	scripts\mp\_hostmigration::func_13708(60);
	self notify("death");
}

//Function Number: 12
func_B9E7()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	self endon("stopFiring");
	for(;;)
	{
		self waittill("killedPlayer",var_00);
		self.var_A644++;
		level.var_8D50[level.var_8D50.size] = var_00;
	}
}

//Function Number: 13
func_10DBD()
{
	self endon("gone");
	self endon("death");
	self endon("stopFiring");
	for(;;)
	{
		self.var_B6BC waittill("turret_on_target");
		var_00 = 1;
		var_01 = self.var_B6BC method_8166(0);
		foreach(var_03 in level.var_8D50)
		{
			if(var_01 == var_03)
			{
				self.var_B6BC method_807E();
				var_00 = 0;
				break;
			}
		}

		if(var_00)
		{
			self.var_B6BC method_837E();
		}
	}
}

//Function Number: 14
func_89D0()
{
	level endon("game_ended");
	self endon("flock_done");
	thread func_C169();
	self waittill("killstreak_disowned");
	for(var_00 = 0;var_00 < level.var_8D4F.size;var_00++)
	{
		if(isdefined(level.var_8D4F[var_00]))
		{
			level.var_8D4F[var_00] notify("stopFiring");
		}
	}

	for(var_00 = 0;var_00 < level.var_8D4F.size;var_00++)
	{
		if(isdefined(level.var_8D4F[var_00]))
		{
			level.var_8D4F[var_00] notify("death");
			wait(0.1);
		}
	}
}

//Function Number: 15
func_C169()
{
	level endon("game_ended");
	self endon("disconnect");
	if(!scripts\mp\_utility::func_2DD9())
	{
		self endon("joined_team");
		self endon("joined_spectators");
	}

	while(func_8DB7())
	{
		wait(0.5);
	}

	self notify("flock_done");
}

//Function Number: 16
func_6F4A()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.var_10955))
		{
			self [[ self.var_10955 ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 17
func_3758(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.var_1D41) && self.var_1D41)
	{
		return;
	}

	if(!isdefined(param_01) || param_01 == self)
	{
		return;
	}

	if(!scripts\mp\_weapons::func_7415(self.var_222,param_01))
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	if(isdefined(param_03) && param_03 & level.var_92C6)
	{
		self.var_1390F = 1;
	}

	self.var_1390B = 1;
	var_0C = param_02;
	if(isplayer(param_01))
	{
		param_01 scripts\mp\_damagefeedback::func_12E84("helicopter");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0C = var_0C + param_02 * level.var_218B;
			}
		}
	}

	if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
	{
		param_01.var_222 scripts\mp\_damagefeedback::func_12E84("helicopter");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remotemissile_projectile_mp":
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "stinger_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				self.var_A859 = 1;
				var_0C = self.maxhealth + 1;
				break;

			case "sam_projectile_mp":
				self.var_A859 = 1;
				var_0C = self.maxhealth * 0.25;
				break;

			case "emp_grenade_mp":
				self.var_A859 = 0;
				var_0C = self.maxhealth + 1;
				break;
		}

		scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_05,self);
	}

	self.var_E1 = self.var_E1 + var_0C;
	if(self.var_E1 >= self.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(self.var_222) || param_01 != self.var_222)
		{
			self.var_1D41 = 1;
			param_01 notify("destroyed_helicopter");
			param_01 notify("destroyed_killstreak",param_05);
			thread scripts\mp\_utility::func_115DE("callout_destroyed_helicopter",param_01);
			param_01 thread scripts\mp\_utility::func_83B4("kill",param_05,300);
		}

		self notify("death");
	}
}

//Function Number: 18
func_139E8()
{
	self endon("gone");
	self waittill("death");
	thread scripts\mp\killstreaks\_helicopter::func_AAC7();
}
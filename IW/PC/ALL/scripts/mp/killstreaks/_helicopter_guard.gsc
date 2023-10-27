/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_helicopter_guard.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 1425 ms
 * Timestamp: 10/27/2023 12:28:43 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("littlebird_support",::func_128EE);
	level.var_8DBA = [];
	level.var_8DBA["littlebird_support"] = spawnstruct();
	level.var_8DBA["littlebird_support"].var_11901 = 60;
	level.var_8DBA["littlebird_support"].health = 999999;
	level.var_8DBA["littlebird_support"].maxhealth = 2000;
	level.var_8DBA["littlebird_support"].var_110EA = "littlebird_support";
	level.var_8DBA["littlebird_support"].var_13260 = "attack_littlebird_mp";
	level.var_8DBA["littlebird_support"].var_39B = "littlebird_guard_minigun_mp";
	level.var_8DBA["littlebird_support"].var_13CA9 = "vehicle_little_bird_minigun_left";
	level.var_8DBA["littlebird_support"].var_13CAA = "vehicle_little_bird_minigun_right";
	level.var_8DBA["littlebird_support"].var_13CD9 = "tag_flash";
	level.var_8DBA["littlebird_support"].var_13CDA = "tag_flash_2";
	level.var_8DBA["littlebird_support"].var_F267 = "auto_nonai";
	level.var_8DBA["littlebird_support"].var_B91A = "vehicle_aas_72x_killstreak";
	level.var_8DBA["littlebird_support"].var_115EB = "used_littlebird_support";
	func_AADA();
	func_AAD8();
}

//Function Number: 2
func_128EE(param_00,param_01)
{
	var_02 = "littlebird_support";
	var_03 = 1;
	if(isdefined(level.var_AD89) || scripts\mp\killstreaks\_helicopter::func_68C3(var_02))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(!level.var_1A66.size)
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_03 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_04 = func_49E1(var_02);
	if(!isdefined(var_04))
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	thread func_10DBE(var_04);
	level thread scripts\mp\_utility::func_115DE(level.var_8DBA[var_02].var_115EB,self,self.team);
	return 1;
}

//Function Number: 3
func_49E1(param_00)
{
	var_01 = func_AAD2(self.origin);
	if(isdefined(var_01.angles))
	{
		var_02 = var_01.angles;
	}
	else
	{
		var_02 = (0,0,0);
	}

	var_03 = scripts\mp\killstreaks\_airdrop::func_7EC0(self.origin);
	var_04 = func_AAD1(self.origin);
	var_05 = anglestoforward(self.angles);
	var_06 = var_04.origin * (1,1,0) + (0,0,1) * var_03 + var_05 * -100;
	var_07 = var_01.origin;
	var_08 = spawnhelicopter(self,var_07,var_02,level.var_8DBA[param_00].var_13260,level.var_8DBA[param_00].var_B91A);
	if(!isdefined(var_08))
	{
		return;
	}

	var_08 scripts\mp\killstreaks\_helicopter::func_1852();
	var_08 thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_08.health = level.var_8DBA[param_00].health;
	var_08.maxhealth = level.var_8DBA[param_00].maxhealth;
	var_08.var_E1 = 0;
	var_08.var_2B3 = 100;
	var_08.var_7247 = 40;
	var_08.var_222 = self;
	var_08 method_831F(self);
	var_08.team = self.team;
	var_08 method_830A(45,45);
	var_08 method_83E5(var_08.var_2B3,100,40);
	var_08 method_8378(120,60);
	var_08 method_8316(512);
	var_08.var_A644 = 0;
	var_08.var_8DD9 = "littlebird";
	var_08.var_8DBB = "littlebird_support";
	var_08.var_11587 = 2000;
	var_08 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",self);
	var_08.var_1157A = var_06;
	var_08.var_4BF7 = var_04;
	var_09 = spawnturret("misc_turret",var_08.origin,level.var_8DBA[param_00].var_39B);
	var_09 linkto(var_08,level.var_8DBA[param_00].var_13CD9,(0,0,0),(0,0,0));
	var_09 setmodel(level.var_8DBA[param_00].var_13CA9);
	var_09.angles = var_08.angles;
	var_09.var_222 = var_08.var_222;
	var_09.team = self.team;
	var_09 method_81F5();
	var_09.var_131A0 = var_08;
	var_08.var_B6C0 = var_09;
	var_08.var_B6C0 method_82D1(0);
	var_0A = var_08.origin + anglestoforward(var_08.angles) * -100 + anglestoright(var_08.angles) * -100 + (0,0,50);
	var_09.var_A63A = spawn("script_model",var_0A);
	var_09.var_A63A setscriptmoverkillcam("explosive");
	var_09.var_A63A linkto(var_08,"tag_origin");
	var_09 = spawnturret("misc_turret",var_08.origin,level.var_8DBA[param_00].var_39B);
	var_09 linkto(var_08,level.var_8DBA[param_00].var_13CDA,(0,0,0),(0,0,0));
	var_09 setmodel(level.var_8DBA[param_00].var_13CAA);
	var_09.angles = var_08.angles;
	var_09.var_222 = var_08.var_222;
	var_09.team = self.team;
	var_09 method_81F5();
	var_09.var_131A0 = var_08;
	var_08.var_B6C1 = var_09;
	var_08.var_B6C1 method_82D1(0);
	var_0A = var_08.origin + anglestoforward(var_08.angles) * -100 + anglestoright(var_08.angles) * 100 + (0,0,50);
	var_09.var_A63A = spawn("script_model",var_0A);
	var_09.var_A63A setscriptmoverkillcam("explosive");
	var_09.var_A63A linkto(var_08,"tag_origin");
	if(level.teambased)
	{
		var_08.var_B6C0 method_835E(self.team);
		var_08.var_B6C1 method_835E(self.team);
	}

	var_08.var_B6C0 method_830F(level.var_8DBA[param_00].var_F267);
	var_08.var_B6C1 method_830F(level.var_8DBA[param_00].var_F267);
	var_08.var_B6C0 method_8336(self);
	var_08.var_B6C1 method_8336(self);
	var_08.var_B6C0 thread func_AACB();
	var_08.var_B6C1 thread func_AACB();
	var_08.var_254D = 10000;
	var_08.var_254C = 150;
	var_08.var_2550 = missile_createattractorent(var_08,var_08.var_254D,var_08.var_254C);
	var_08.var_8BE5 = 0;
	var_08.var_61A3 = 0;
	var_08 thread func_AAD4();
	var_08 thread func_AADB();
	var_08 thread func_AAE1();
	var_08 thread func_AADD();
	var_08 thread func_AADC();
	var_08 thread func_AADE();
	var_08 thread func_AAD6();
	level.var_AD89 = var_08;
	var_08.var_222 scripts\mp\_matchdata::func_AFC9(level.var_8DBA[var_08.var_8DBB].var_110EA,var_08.var_1157A);
	return var_08;
}

//Function Number: 4
func_AAD6()
{
	playfxontag(level.var_3F19["light"]["left"],self,"tag_light_nose");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail1");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail2");
}

//Function Number: 5
func_10DBE(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 method_8305(self);
	param_00 method_8362(param_00.var_1157A);
	param_00 waittill("near_goal");
	param_00 method_83E5(param_00.var_2B3,60,30);
	param_00 waittill("goal");
	param_00 method_8362(param_00.var_4BF7.origin,1);
	param_00 waittill("goal");
	param_00 thread func_AACF();
	param_00 thread scripts\mp\killstreaks\_flares::func_6EAA(::func_AADF);
	param_00 thread scripts\mp\killstreaks\_flares::func_6EAB(::func_AAE0);
}

//Function Number: 6
func_AACF()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.var_222))
	{
		thread func_AAD5();
		return;
	}

	self.var_222 endon("disconnect");
	self endon("owner_gone");
	self method_83E5(self.var_7247,20,20);
	for(;;)
	{
		if(isdefined(self.var_222) && isalive(self.var_222))
		{
			var_00 = func_AAD0(self.var_222.origin);
			if(isdefined(var_00) && var_00 != self.var_4BF7)
			{
				self.var_4BF7 = var_00;
				func_AAD7();
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_AAD7()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	self notify("lbSupport_moveToPlayer");
	self endon("lbSupport_moveToPlayer");
	self.var_9A95 = 1;
	self method_8362(self.var_4BF7.origin + (0,0,100),1);
	self waittill("goal");
	self.var_9A95 = 0;
	self notify("hit_goal");
}

//Function Number: 8
func_AADB()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread scripts\mp\killstreaks\_helicopter::func_AAC7();
}

//Function Number: 9
func_AAE1()
{
	level endon("game_ended");
	self endon("death");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	var_00 = level.var_8DBA[self.var_8DBB].var_11901;
	scripts\mp\_hostmigration::func_13708(var_00);
	thread func_AAD5();
}

//Function Number: 10
func_AADD()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 waittill("killstreak_disowned");
	self notify("owner_gone");
	thread func_AAD5();
}

//Function Number: 11
func_AADC()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	for(;;)
	{
		self.var_222 waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(isplayer(var_01))
		{
			if(var_01 != self.var_222 && distance2d(var_01.origin,self.origin) <= self.var_11587 && !var_01 scripts\mp\_utility::_hasperk("specialty_blindeye") && !level.var_8B38 && level.teambased && var_01.team == self.team)
			{
				self method_8305(var_01);
				if(isdefined(self.var_B6C0))
				{
					self.var_B6C0 method_8347(var_01);
				}

				if(isdefined(self.var_B6C1))
				{
					self.var_B6C1 method_8347(var_01);
				}
			}
		}
	}
}

//Function Number: 12
func_AADE()
{
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	thread func_AAD5();
}

//Function Number: 13
func_AAD5()
{
	self endon("death");
	self notify("leaving");
	level.var_AD89 = undefined;
	self method_8076();
	var_00 = scripts\mp\killstreaks\_airdrop::func_7EC0(self.origin);
	var_01 = self.origin + (0,0,var_00);
	self method_83E5(self.var_2B3,60);
	self method_830A(45,180);
	self method_8362(var_01);
	self waittill("goal");
	var_01 = var_01 + anglestoforward(self.angles) * 15000;
	var_02 = spawn("script_origin",var_01);
	if(isdefined(var_02))
	{
		self method_8305(var_02);
		var_02 thread func_13589(3);
	}

	self method_8362(var_01);
	self waittill("goal");
	self notify("gone");
	scripts\mp\killstreaks\_helicopter::func_E139();
}

//Function Number: 14
func_13589(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 15
func_AAD4()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(!scripts\mp\_weapons::func_7415(self.var_222,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_08) && var_08 & level.var_92C4)
		{
			self.var_1390E = 1;
		}

		if(isdefined(var_08) && var_08 & level.var_92C6)
		{
			self.var_1390F = 1;
		}

		self.var_1390B = 1;
		var_0E = var_00;
		if(isplayer(var_01))
		{
			if(var_01 != self.var_222 && distance2d(var_01.origin,self.origin) <= self.var_11587 && !var_01 scripts\mp\_utility::_hasperk("specialty_blindeye") && !level.var_8B38 && level.teambased && var_01.team == self.team)
			{
				self method_8305(var_01);
				if(isdefined(self.var_B6C0))
				{
					self.var_B6C0 method_8347(var_01);
				}

				if(isdefined(self.var_B6C1))
				{
					self.var_B6C1 method_8347(var_01);
				}
			}

			var_01 scripts\mp\_damagefeedback::func_12E84("helicopter");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0E = var_0E + var_00 * level.var_218B;
				}
			}
		}

		if(isdefined(var_01.var_222) && isplayer(var_01.var_222))
		{
			var_01.var_222 scripts\mp\_damagefeedback::func_12E84("helicopter");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remotemissile_projectile_mp":
				case "javelin_mp":
				case "remote_mortar_missile_mp":
				case "stinger_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.var_A859 = 1;
					var_0E = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.var_A859 = 1;
					var_0E = self.maxhealth * 0.25;
					break;
	
				case "emp_grenade_mp":
					var_0E = 0;
					thread func_AACE();
					break;
	
				case "osprey_player_minigun_mp":
					self.var_A859 = 0;
					var_0E = var_0E * 2;
					break;
			}

			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_01,var_09,self);
		}

		self.var_E1 = self.var_E1 + var_0E;
		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.var_222) || var_01 != self.var_222)
			{
				var_01 notify("destroyed_helicopter");
				var_01 notify("destroyed_killstreak",var_09);
				thread scripts\mp\_utility::func_115DE("callout_destroyed_little_bird",var_01);
				var_01 thread scripts\mp\_utility::func_83B4("kill",var_09,300);
				var_01 thread scripts\mp\_rank::func_EC2D("destroyed_little_bird");
			}

			if(isdefined(self.var_222))
			{
				self.var_222 thread scripts\mp\_utility::func_AAEC("lbguard_destroyed");
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 16
func_AACE()
{
	self notify("lbSupport_EMPGrenaded");
	self endon("lbSupport_EMPGrenaded");
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	self.var_61A3 = 1;
	if(isdefined(self.var_B6C1))
	{
		self.var_B6C1 notify("stop_shooting");
	}

	if(isdefined(self.var_B6C0))
	{
		self.var_B6C0 notify("stop_shooting");
	}

	if(isdefined(level._effect["ims_sensor_explode"]))
	{
		if(isdefined(self.var_B6C1))
		{
			playfxontag(scripts\common\utility::getfx("ims_sensor_explode"),self.var_B6C1,"tag_aim");
		}

		if(isdefined(self.var_B6C0))
		{
			playfxontag(scripts\common\utility::getfx("ims_sensor_explode"),self.var_B6C0,"tag_aim");
		}
	}

	wait(3.5);
	self.var_61A3 = 0;
	if(isdefined(self.var_B6C1))
	{
		self.var_B6C1 notify("turretstatechange");
	}

	if(isdefined(self.var_B6C0))
	{
		self.var_B6C0 notify("turretstatechange");
	}
}

//Function Number: 17
func_AADF(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("death");
	for(var_04 = 0;var_04 < param_03.size;var_04++)
	{
		if(isdefined(param_03[var_04]) && !param_02.var_8BE5)
		{
			param_02.var_8BE5 = 1;
			var_05 = spawn("script_origin",param_02.origin);
			var_05.angles = param_02.angles;
			var_05 movegravity(anglestoright(param_03[var_04].angles) * -1000,0.05);
			var_05 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
			for(var_06 = 0;var_06 < param_03.size;var_06++)
			{
				if(isdefined(param_03[var_06]))
				{
					param_03[var_06] missile_settargetent(var_05);
				}
			}

			var_07 = param_02.origin + anglestoright(param_03[var_04].angles) * 200;
			param_02 method_83E5(param_02.var_2B3,100,40);
			param_02 method_8362(var_07,1);
			wait(2);
			param_02 method_83E5(param_02.var_7247,20,20);
			break;
		}
	}
}

//Function Number: 18
func_AAE0(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 endon("death");
	if(isdefined(self) && !param_02.var_8BE5)
	{
		param_02.var_8BE5 = 1;
		var_03 = spawn("script_origin",param_02.origin);
		var_03.angles = param_02.angles;
		var_03 movegravity(anglestoright(self.angles) * -1000,0.05);
		var_03 thread scripts\mp\killstreaks\_flares::func_6E9F(5);
		self missile_settargetent(var_03);
		var_04 = param_02.origin + anglestoright(self.angles) * 200;
		param_02 method_83E5(param_02.var_2B3,100,40);
		param_02 method_8362(var_04,1);
		wait(2);
		param_02 method_83E5(param_02.var_7247,20,20);
	}
}

//Function Number: 19
func_AAD2(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_1A6B)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 20
func_AAD1(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_1A66)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 21
func_AAD0(param_00)
{
	var_01 = undefined;
	var_02 = distance2d(self.var_4BF7.origin,param_00);
	var_03 = var_02;
	foreach(var_05 in self.var_4BF7.var_BEAA)
	{
		var_06 = distance2d(var_05.origin,param_00);
		if(var_06 < var_02 && var_06 < var_03)
		{
			var_01 = var_05;
			var_03 = var_06;
		}
	}

	return var_01;
}

//Function Number: 22
func_AACA(param_00,param_01)
{
	if(param_00.size <= 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
func_AAD3()
{
	var_00 = [];
	if(isdefined(self.var_EE01))
	{
		var_01 = scripts\common\utility::func_7A9C();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = scripts\common\utility::getstruct(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 24
func_AADA()
{
	level.var_1A6B = scripts\common\utility::getstructarray("chopper_boss_path_start","targetname");
	foreach(var_01 in level.var_1A6B)
	{
		var_01.var_BEAA = var_01 func_AAD3();
	}
}

//Function Number: 25
func_AAD9()
{
	level.var_1A67 = scripts\common\utility::getstructarray("chopper_boss_path","targetname");
	foreach(var_01 in level.var_1A67)
	{
		var_01.var_BEAA = var_01 func_AAD3();
	}
}

//Function Number: 26
func_AAD8()
{
	level.var_1A66 = scripts\common\utility::getstructarray("so_chopper_boss_path_struct","script_noteworthy");
	foreach(var_01 in level.var_1A66)
	{
		var_01.var_BEAA = var_01 func_AAD3();
		foreach(var_03 in level.var_1A66)
		{
			if(var_01 == var_03)
			{
				continue;
			}

			if(!func_AACA(var_01.var_BEAA,var_03) && func_AACA(var_03 func_AAD3(),var_01))
			{
				var_01.var_BEAA[var_01.var_BEAA.size] = var_03;
			}
		}
	}
}

//Function Number: 27
func_AACB()
{
	self.var_131A0 endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self method_81A0() && !self.var_131A0.var_61A3)
		{
			thread func_AACC();
			continue;
		}

		thread func_AACD();
	}
}

//Function Number: 28
func_AACC()
{
	self.var_131A0 endon("death");
	self.var_131A0 endon("leaving");
	self endon("stop_shooting");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 40;
	var_02 = 80;
	var_03 = 1;
	var_04 = 2;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			var_07 = self method_8166(0);
			if(isdefined(var_07) && !isdefined(var_07.var_10916) || gettime() - var_07.var_10916 / 1000 > 5 && isdefined(var_07.team) && var_07.team != "spectator" && scripts\mp\_utility::func_9F19(var_07))
			{
				self.var_131A0 method_8305(var_07);
				self method_837E();
			}

			wait(var_00);
		}

		wait(randomfloatrange(var_03,var_04));
	}
}

//Function Number: 29
func_AACD()
{
	self notify("stop_shooting");
	if(isdefined(self.var_131A0.var_222))
	{
		self.var_131A0 method_8305(self.var_131A0.var_222);
	}
}
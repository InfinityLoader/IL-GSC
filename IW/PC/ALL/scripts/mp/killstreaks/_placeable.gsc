/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_placeable.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1476 ms
 * Timestamp: 10/27/2023 12:29:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_CC09))
	{
		level.var_CC09 = [];
	}
}

//Function Number: 2
func_838E(param_00,param_01)
{
	var_02 = func_49FC(param_00);
	func_E152();
	self.var_3AA0 = var_02;
	var_03 = func_C4CA(param_00,var_02,1,param_01);
	self.var_3AA0 = undefined;
	func_E2E0();
	return isdefined(var_02);
}

//Function Number: 3
func_49FC(param_00)
{
	if(isdefined(self.var_9D81) && self.var_9D81)
	{
		return;
	}

	var_01 = level.var_CC09[param_00];
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel(var_01.var_B91A);
	var_02.angles = self.angles;
	var_02.var_222 = self;
	var_02.team = self.team;
	var_02.var_451C = var_01;
	var_02.var_6DEC = 1;
	if(isdefined(var_01.var_C4DE))
	{
		var_02 [[ var_01.var_C4DE ]](param_00);
	}

	var_02 func_4DA6(param_00);
	var_02 thread func_11901(param_00);
	var_02 thread func_89FA(param_00);
	var_02 thread func_C547(param_00);
	var_02 thread func_C533(param_00);
	var_02 thread func_4988(param_00);
	return var_02;
}

//Function Number: 4
func_89FA(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_01 func_C4CA(param_00,self,0);
	}
}

//Function Number: 5
func_C4CA(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("disconnect");
	param_01 thread func_C4D5(param_00,self);
	scripts\common\utility::allow_weapon(0);
	if(!isai(self))
	{
		self notifyonplayercommand("placePlaceable","+attack");
		self notifyonplayercommand("placePlaceable","+attack_akimbo_accessible");
		self notifyonplayercommand("cancelPlaceable","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancelPlaceable","+actionslot 5");
			self notifyonplayercommand("cancelPlaceable","+actionslot 6");
			self notifyonplayercommand("cancelPlaceable","+actionslot 7");
		}
	}

	for(;;)
	{
		if(isdefined(param_03) && param_03 == 1 && !self method_81B5() && self isonground() && !self ismantling())
		{
			var_04 = "placePlaceable";
		}
		else
		{
			var_04 = scripts\common\utility::func_13734("placePlaceable","cancelPlaceable","force_cancel_placement");
		}

		if(!isdefined(param_01))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}
		else if((var_04 == "cancelPlaceable" && param_02) || var_04 == "force_cancel_placement")
		{
			param_01 func_C4D2(param_00,var_04 == "force_cancel_placement" && !isdefined(param_01.var_6DEC));
			return 0;
		}
		else if(param_01.var_3872)
		{
			param_01 thread func_C56B(param_00);
			scripts\common\utility::allow_weapon(1);
			return 1;
		}
		else
		{
			wait(0.05);
		}
	}
}

//Function Number: 6
func_C4D2(param_00,param_01)
{
	if(isdefined(self.var_3A9D))
	{
		var_02 = self.var_3A9D;
		var_02 method_80F3();
		var_02.var_9D81 = undefined;
		var_02.var_3AA0 = undefined;
		var_02 scripts\common\utility::allow_weapon(1);
	}

	if(isdefined(self.var_2C68))
	{
		self.var_2C68 delete();
	}

	if(isdefined(self.var_3AA2))
	{
		self.var_3AA2 delete();
	}

	var_03 = level.var_CC09[param_00];
	if(isdefined(var_03.var_C4D3))
	{
		self [[ var_03.var_C4D3 ]](param_00);
	}

	if(isdefined(param_01) && param_01)
	{
		scripts\mp\_weapons::func_66A8();
	}

	self delete();
}

//Function Number: 7
func_C56B(param_00)
{
	var_01 = level.var_CC09[param_00];
	self.origin = self.var_CC24;
	self.angles = self.var_3AA2.angles;
	self playsound(var_01.var_CC15);
	func_10146(param_00);
	if(isdefined(var_01.var_C56C))
	{
		self [[ var_01.var_C56C ]](param_00);
	}

	self setcursorhint("HINT_NOICON");
	self sethintstring(var_01.var_17B);
	var_02 = self.var_222;
	var_02 method_80F3();
	var_02.var_9D81 = undefined;
	self.var_3A9D = undefined;
	self.var_9EE4 = 1;
	self.var_6DEC = undefined;
	if(isdefined(var_01.var_8C79))
	{
		if(level.teambased)
		{
			scripts\mp\_entityheadicons::func_F877(self.team,(0,0,var_01.var_8C79));
		}
		else
		{
			scripts\mp\_entityheadicons::func_F7F2(var_02,(0,0,var_01.var_8C79));
		}
	}

	thread func_898C(param_00);
	thread func_898E(param_00);
	self makeusable();
	scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground",self.var_222);
	foreach(var_04 in level.players)
	{
		if(var_04 == var_02)
		{
			self enableplayeruse(var_04);
			continue;
		}

		self disableplayeruse(var_04);
	}

	if(isdefined(self.var_10085))
	{
		level thread scripts\mp\_utility::func_115DE(var_01.var_10A38,var_02);
		self.var_10085 = 0;
	}

	var_06 = spawnstruct();
	var_06.var_AD39 = self.var_BD3B;
	var_06.var_CF14 = 1;
	var_06.var_6371 = "carried";
	if(isdefined(var_01.var_C55B))
	{
		var_06.var_4E53 = var_01.var_C55B;
	}

	thread scripts\mp\_movers::func_892F(var_06);
	thread func_13AFA();
	self notify("placed");
	self.var_3AA2 delete();
	self.var_3AA2 = undefined;
}

//Function Number: 8
func_C4D5(param_00,param_01)
{
	var_02 = level.var_CC09[param_00];
	self.var_3AA2 = param_01 func_4992(param_00);
	self.var_9EE4 = undefined;
	self.var_3A9D = param_01;
	param_01.var_9D81 = 1;
	func_4DA6(param_00);
	func_8ED4(param_00);
	if(isdefined(var_02.var_C4D6))
	{
		self [[ var_02.var_C4D6 ]](param_00);
	}

	thread func_12EEC(param_00,param_01);
	thread func_C4D7(param_00,param_01);
	self notify("carried");
}

//Function Number: 9
func_12EEC(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	level endon("game_ended");
	self endon("placed");
	self endon("death");
	self.var_3872 = 1;
	var_02 = -1;
	var_03 = level.var_CC09[param_00];
	var_04 = (0,0,0);
	if(isdefined(var_03.var_CC23))
	{
		var_04 = (0,0,var_03.var_CC23);
	}

	var_05 = self.var_3AA2;
	for(;;)
	{
		var_06 = param_01 canplayerplacesentry(1,var_03.var_CC25);
		self.var_CC24 = var_06["origin"];
		var_05.origin = self.var_CC24 + var_04;
		var_05.angles = var_06["angles"];
		self.var_3872 = param_01 isonground() && var_06["result"] && abs(self.var_CC24[2] - param_01.origin[2]) < var_03.var_CC22;
		if(isdefined(var_06["entity"]))
		{
			self.var_BD3B = var_06["entity"];
		}
		else
		{
			self.var_BD3B = undefined;
		}

		if(self.var_3872 != var_02)
		{
			if(self.var_3872)
			{
				var_05 setmodel(var_03.var_B924);
				param_01 method_80F4(var_03.var_CC28);
			}
			else
			{
				var_05 setmodel(var_03.var_B925);
				param_01 method_80F4(var_03.var_38E3);
			}
		}

		var_02 = self.var_3872;
		wait(0.05);
	}
}

//Function Number: 10
func_4DA6(param_00)
{
	self makeunusable();
	func_8EC3();
	var_01 = level.var_CC09[param_00];
	if(isdefined(var_01.var_C4E7))
	{
		self [[ var_01.var_C4E7 ]](param_00);
	}
}

//Function Number: 11
func_8EC3()
{
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877("none",(0,0,0));
		return;
	}

	if(isdefined(self.var_222))
	{
		scripts\mp\_entityheadicons::func_F7F2(undefined,(0,0,0));
	}
}

//Function Number: 12
func_898C(param_00)
{
	self endon("carried");
	var_01 = level.var_CC09[param_00];
	scripts\mp\_damage::func_B9C6(var_01.maxhealth,var_01.var_4D4A,::func_898F,::func_B938,1);
}

//Function Number: 13
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_06 = self.var_451C;
	if(isdefined(var_06.var_1C9D) && var_06.var_1C9D)
	{
		var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	}

	if(isdefined(var_06.var_1C8F) && var_06.var_1C8F)
	{
		var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	}

	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89AC(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	if(isdefined(var_06.var_B938))
	{
		var_05 = self [[ var_06.var_B938 ]](param_01,param_02,var_05);
	}

	return var_05;
}

//Function Number: 14
func_898F(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_451C;
	var_05 = scripts\mp\_damage::func_C548(self.var_110EA,param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_52DA);
	if(var_05 && isdefined(var_04.var_C4F3))
	{
		self [[ var_04.var_C4F3 ]](self.var_110EA,param_00,self.var_222,param_02);
	}
}

//Function Number: 15
func_898E(param_00)
{
	self endon("carried");
	self waittill("death");
	var_01 = level.var_CC09[param_00];
	if(isdefined(self))
	{
		func_4DA6(param_00);
		if(isdefined(var_01.var_B91D))
		{
			self setmodel(var_01.var_B91D);
		}

		if(isdefined(var_01.var_C4EB))
		{
			self [[ var_01.var_C4EB ]](param_00);
		}

		self delete();
	}
}

//Function Number: 16
func_C4D7(param_00,param_01)
{
	self endon("placed");
	self endon("death");
	param_01 endon("disconnect");
	param_01 waittill("death");
	if(self.var_3872)
	{
		thread func_C56B(param_00);
		return;
	}

	func_C4D2(param_00);
}

//Function Number: 17
func_C547(param_00)
{
	self endon("death");
	level endon("game_ended");
	self.var_222 waittill("killstreak_disowned");
	func_4045(param_00);
}

//Function Number: 18
func_C533(param_00)
{
	self endon("death");
	level waittill("game_ended");
	func_4045(param_00);
}

//Function Number: 19
func_4045(param_00)
{
	if(isdefined(self.var_9EE4))
	{
		self notify("death");
		return;
	}

	func_C4D2(param_00);
}

//Function Number: 20
func_13AFA()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		thread func_C570(var_00);
	}
}

//Function Number: 21
func_C570(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	self disableplayeruse(param_00);
}

//Function Number: 22
func_11901(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = level.var_CC09[param_00];
	var_02 = var_01.var_AC71;
	while(var_02 > 0)
	{
		wait(1);
		scripts\mp\_hostmigration::func_13834();
		if(!isdefined(self.var_3A9D))
		{
			var_02 = var_02 - 1;
		}
	}

	if(isdefined(self.var_222) && isdefined(var_01.var_844E))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC(var_01.var_844E);
	}

	self notify("death");
}

//Function Number: 23
func_E18E()
{
	if(self hasweapon("iw6_riotshield_mp"))
	{
		self.var_E2E6 = "iw6_riotshield_mp";
		scripts\mp\_utility::func_141E("iw6_riotshield_mp");
	}
}

//Function Number: 24
func_E152()
{
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}
}

//Function Number: 25
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\mp\_utility::func_12C6(self.var_E2E6);
		self.var_E2E6 = undefined;
	}
}

//Function Number: 26
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\mp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 27
func_4988(param_00)
{
	var_01 = level.var_CC09[param_00];
	if(isdefined(var_01.var_B91C))
	{
		var_02 = spawn("script_model",self.origin);
		var_02.angles = self.angles;
		var_02 hide();
		var_02 thread scripts\mp\_weapons::func_2C69(self.var_222);
		var_02 setmodel(var_01.var_B91C);
		var_02 linkto(self);
		var_02 method_82C7(0);
		self.var_2C68 = var_02;
		self waittill("death");
		if(isdefined(var_02))
		{
			var_02 delete();
			self.var_2C68 = undefined;
		}
	}
}

//Function Number: 28
func_10146(param_00)
{
	self show();
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 show();
		level notify("update_bombsquad");
	}
}

//Function Number: 29
func_8ED4(param_00)
{
	self hide();
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 hide();
	}
}

//Function Number: 30
func_4992(param_00)
{
	if(isdefined(self.var_9D81) && self.var_9D81)
	{
		return;
	}

	var_01 = spawnturret("misc_turret",self.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = self.angles;
	var_01.var_222 = self;
	var_02 = level.var_CC09[param_00];
	var_01 setmodel(var_02.var_B91A);
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(self);
	var_01 method_8335(self);
	var_01 setcandamage(0);
	var_01 method_82C7(0);
	return var_01;
}
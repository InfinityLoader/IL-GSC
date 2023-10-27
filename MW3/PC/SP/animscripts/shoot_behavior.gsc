/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\shoot_behavior.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 437 ms
 * Timestamp: 10/27/2023 2:18:45 AM
*******************************************************************/

//Function Number: 1
func_0CD7(param_00)
{
	self endon("killanimscript");
	self notify("stop_deciding_how_to_shoot");
	self endon("stop_deciding_how_to_shoot");
	self endon("death");
	maps\_gameskill::resetmisstime();
	self.var_CD9 = param_00;
	self.var_CAB = undefined;
	self.var_CB1 = undefined;
	self.var_CDA = "none";
	self.var_CDB = 0;
	self.var_CDC = undefined;
	if(!isdefined(self.var_CDD))
	{
		self.var_CDD = 0;
	}

	var_01 = isdefined(self.var_CAF) && self.var_CAF.type != "Cover Prone" && self.var_CAF.type != "Conceal Prone";
	if(var_01)
	{
		wait 0.05;
	}

	var_02 = self.var_CAB;
	var_03 = self.var_CB1;
	var_04 = self.var_CDA;
	if(!isdefined(self.has_no_ir))
	{
		self.a.var_CDF = 1;
		animscripts/shared::func_CE0();
	}

	if(animscripts/combat_utility::issniper())
	{
		func_0D09();
	}

	if(var_01 && !self.a.var_CE2 || !animscripts/utility::func_CE3())
	{
		thread func_0CFA();
	}

	thread func_0CFE();
	self.var_CE4 = undefined;
	for(;;)
	{
		if(isdefined(self.var_CE5))
		{
			if(!isdefined(self.enemy))
			{
				self.var_CB1 = self.var_CE5;
				self.var_CE5 = undefined;
				func_0CE7();
			}
			else
			{
				self.var_CE5 = undefined;
			}
		}

		var_05 = undefined;
		if(self.weapon == "none")
		{
			func_0CE8();
		}
		else if(animscripts/utility::func_BB6())
		{
			var_05 = func_0CF5();
		}
		else if(animscripts/utility::func_C95())
		{
			var_05 = func_0CF6();
		}
		else
		{
			var_05 = func_0CF2();
		}

		if(isdefined(self.a.var_CE6))
		{
			[[ self.a.var_CE6 ]]();
		}

		if(func_0CFF(var_02,self.var_CAB) || !isdefined(self.var_CAB) && func_0CFF(var_03,self.var_CB1) || func_0CFF(var_04,self.var_CDA))
		{
			self notify("shoot_behavior_change");
		}

		var_02 = self.var_CAB;
		var_03 = self.var_CB1;
		var_04 = self.var_CDA;
		if(!isdefined(var_05))
		{
			func_0CE7();
		}
	}
}

//Function Number: 2
func_0CE7()
{
	self endon("enemy");
	self endon("done_changing_cover_pos");
	self endon("weapon_position_change");
	self endon("enemy_visible");
	if(isdefined(self.var_CAB))
	{
		self.var_CAB endon("death");
		self endon("do_slow_things");
		wait 0.05;
		while(isdefined(self.var_CAB))
		{
			self.var_CB1 = self.var_CAB getshootatpos();
			wait 0.05;
		}

		return;
	}

	self waittill("do_slow_things");
}

//Function Number: 3
func_0CE8()
{
	self.var_CAB = undefined;
	self.var_CB1 = undefined;
	self.var_CDA = "none";
	self.var_CD9 = "normal";
}

//Function Number: 4
func_0CE9()
{
	return !animscripts/combat_utility::issniper() && !animscripts/utility::func_CEA(self.weapon);
}

//Function Number: 5
func_0CEB()
{
	if(!animscripts/utility::func_CE3())
	{
		return 0;
	}

	if(!isdefined(self.var_CAF) && !self canshootenemy())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_0CEC()
{
	if(!func_0CEB())
	{
		if(animscripts/combat_utility::issniper())
		{
			func_0D09();
		}

		if(self.var_748)
		{
			self.var_CD9 = "ambush";
			return "retry";
		}

		if(!isdefined(self.enemy))
		{
			func_0D01();
			return;
		}

		func_0CF7();
		if((self.providecoveringfire || randomint(5) > 0) && func_0CE9())
		{
			self.var_CD9 = "suppress";
		}
		else
		{
			self.var_CD9 = "ambush";
		}

		return "retry";
	}

	func_0D00();
	func_0D03();
}

//Function Number: 7
func_0CED(param_00)
{
	if(!param_00)
	{
		func_0D01();
		return;
	}

	self.var_CAB = undefined;
	self.var_CB1 = animscripts/utility::func_CEE();
	func_0D05();
}

//Function Number: 8
func_0CEF(param_00)
{
	self.var_CDA = "none";
	self.var_CAB = undefined;
	if(!param_00)
	{
		func_0CF0();
		if(func_0CF4())
		{
			self.var_CE4 = undefined;
			self notify("return_to_cover");
			self.var_CDC = 1;
			return;
		}

		return;
	}

	self.var_CB1 = animscripts/utility::func_CEE();
	if(func_0CF4())
	{
		self.var_CE4 = undefined;
		if(func_0CE9())
		{
			self.var_CD9 = "suppress";
		}

		if(randomint(3) == 0)
		{
			self notify("return_to_cover");
			self.var_CDC = 1;
		}

		return "retry";
	}
}

//Function Number: 9
func_0CF0()
{
	if(isdefined(self.enemy) && self cansee(self.enemy))
	{
		func_0D00();
		return;
	}

	var_00 = self getanglestolikelyenemypath();
	if(!isdefined(var_00))
	{
		if(isdefined(self.var_CAF))
		{
			var_00 = self.var_CAF.angles;
		}
		else if(isdefined(self.var_CF1))
		{
			var_00 = self.var_CF1.angles;
		}
		else if(isdefined(self.enemy))
		{
			var_00 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
		}
		else
		{
			var_00 = self.angles;
		}
	}

	var_01 = 1024;
	if(isdefined(self.enemy))
	{
		var_01 = distance(self.origin,self.enemy.origin);
	}

	var_02 = self geteye() + anglestoforward(var_00) * var_01;
	if(!isdefined(self.var_CB1) || distancesquared(var_02,self.var_CB1) > 25)
	{
		self.var_CB1 = var_02;
	}
}

//Function Number: 10
func_0CF2()
{
	if(self.var_CD9 == "normal")
	{
		func_0CEC();
		return;
	}

	if(func_0CEB())
	{
		self.var_CD9 = "normal";
		self.var_CE4 = undefined;
		return "retry";
	}

	func_0CF7();
	if(animscripts/combat_utility::issniper())
	{
		func_0D09();
	}

	var_00 = animscripts/utility::func_CF3();
	if(self.var_CD9 == "suppress" || self.team == "allies" && !isdefined(self.enemy) && !var_00)
	{
		func_0CED(var_00);
		return;
	}

	func_0CEF(var_00);
}

//Function Number: 11
func_0CF4()
{
	if(!isdefined(self.var_CE4))
	{
		if(self isbadguy())
		{
			self.var_CE4 = gettime() + randomintrange(10000,-5536);
		}
		else
		{
			self.var_CE4 = gettime() + randomintrange(4000,10000);
		}
	}

	return self.var_CE4 < gettime();
}

//Function Number: 12
func_0CF5()
{
	if(!func_0CEB())
	{
		func_0CF7();
		func_0D01();
		return;
	}

	func_0D00();
	self.var_CDA = "single";
	var_00 = lengthsquared(self.origin - self.var_CB1);
	if(var_00 < squared(512))
	{
		self notify("return_to_cover");
		self.var_CDC = 1;
	}
}

//Function Number: 13
func_0CF6()
{
	if(self.var_CD9 == "normal")
	{
		if(!func_0CEB())
		{
			if(!isdefined(self.enemy))
			{
				func_0D01();
				return;
			}

			func_0CF7();
			self.var_CD9 = "ambush";
			return "retry";
		}

		func_0D00();
		self.var_CDA = "single";
		return;
	}

	if(func_0CEB())
	{
		self.var_CD9 = "normal";
		self.var_CE4 = undefined;
		return "retry";
	}

	func_0CF7();
	self.var_CAB = undefined;
	self.var_CDA = "none";
	self.var_CB1 = animscripts/utility::func_CEE();
	if(!isdefined(self.var_CE4))
	{
		self.var_CE4 = gettime() + randomintrange(4000,8000);
	}

	if(self.var_CE4 < gettime())
	{
		self.var_CD9 = "normal";
		self.var_CE4 = undefined;
		return "retry";
	}
}

//Function Number: 14
func_0CF7()
{
	if(isdefined(self.enemy) && !self.var_CDD && self.script != "combat")
	{
		if(isai(self.enemy) && isdefined(self.enemy.script) && self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")
		{
			if(isdefined(self.enemy.a.var_CF8) && self.enemy.a.var_CF8 == "hide")
			{
				return;
			}
		}

		self.var_CF9 = self.enemy.origin;
	}
}

//Function Number: 15
func_0CFA()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		self waittill("suppression");
		if(self.var_738 > self.var_CFB)
		{
			if(func_0CFC())
			{
				self notify("return_to_cover");
				self.var_CDC = 1;
			}
		}
	}
}

//Function Number: 16
func_0CFC()
{
	if(self.var_CDD)
	{
		return 0;
	}

	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		return 1;
	}

	if(gettime() < self.var_CFD + 800)
	{
		return 0;
	}

	if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5)
	{
		if(gettime() < self.var_CFD + 3000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 17
func_0CFE()
{
	self endon("death");
	common_scripts\utility::waittill_any("killanimscript","stop_deciding_how_to_shoot");
	self.a.var_CDF = 0;
	animscripts/shared::func_CE0();
}

//Function Number: 18
func_0CFF(param_00,param_01)
{
	if(isdefined(param_00) != isdefined(param_01))
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	return param_00 != param_01;
}

//Function Number: 19
func_0D00()
{
	self.var_CAB = self.enemy;
	self.var_CB1 = self.var_CAB getshootatpos();
}

//Function Number: 20
func_0D01()
{
	self.var_CAB = undefined;
	self.var_CB1 = undefined;
	self.var_CDA = "none";
	if(self.var_748)
	{
		self.var_CD9 = "ambush";
	}

	if(!self.var_CDD)
	{
		self notify("return_to_cover");
		self.var_CDC = 1;
	}
}

//Function Number: 21
func_0D02()
{
	return level.gameskill == 3 && isplayer(self.enemy);
}

//Function Number: 22
func_0D03()
{
	if(isdefined(self.var_CAB.enemy) && isdefined(self.var_CAB.enemy.var_78A))
	{
		return func_0D06("single",0);
	}

	if(animscripts/combat_utility::issniper())
	{
		return func_0D06("single",0);
	}

	if(animscripts/utility::func_CEA(self.weapon))
	{
		if(animscripts/utility::func_C97())
		{
			return func_0D06("single",0);
		}
		else
		{
			return func_0D06("semi",0);
		}
	}

	if(weaponburstcount(self.weapon) > 0)
	{
		return func_0D06("burst",0);
	}

	if(isdefined(self.juggernaut) && self.juggernaut)
	{
		return func_0D06("full",1);
	}

	var_00 = distancesquared(self getshootatpos(),self.var_CB1);
	var_01 = weaponclass(self.weapon) == "mg";
	if(self.providecoveringfire && var_01)
	{
		return func_0D06("full",0);
	}

	if(var_00 < -3036)
	{
		if(isdefined(self.var_CAB) && isdefined(self.var_CAB.magic_bullet_shield))
		{
			return func_0D06("single",0);
		}
		else
		{
			return func_0D06("full",0);
		}
	}
	else if(var_00 < 810000 || func_0D02())
	{
		if(weaponissemiauto(self.weapon) || func_0D07())
		{
			return func_0D06("semi",1);
		}
		else
		{
			return func_0D06("burst",1);
		}
	}
	else if(self.providecoveringfire || var_01 || var_00 < 2560000)
	{
		if(func_0D07())
		{
			return func_0D06("semi",0);
		}
		else
		{
			return func_0D06("burst",0);
		}
	}

	return func_0D06("single",0);
}

//Function Number: 23
func_0D05()
{
	var_00 = distancesquared(self getshootatpos(),self.var_CB1);
	if(weaponissemiauto(self.weapon))
	{
		if(var_00 < 2560000)
		{
			return func_0D06("semi",0);
		}

		return func_0D06("single",0);
	}

	if(weaponclass(self.weapon) == "mg")
	{
		return func_0D06("full",0);
	}

	if(self.providecoveringfire || var_00 < 2560000)
	{
		if(func_0D07())
		{
			return func_0D06("semi",0);
		}
		else
		{
			return func_0D06("burst",0);
		}
	}

	return func_0D06("single",0);
}

//Function Number: 24
func_0D06(param_00,param_01)
{
	self.var_CDA = param_00;
	self.var_CDB = param_01;
}

//Function Number: 25
func_0D07()
{
	if(weaponclass(self.weapon) != "rifle")
	{
		return 0;
	}

	if(self.team != "allies")
	{
		return 0;
	}

	var_00 = animscripts/utility::func_D08(int(self.origin[1]),10000) + 2000;
	var_01 = int(self.origin[0]) + gettime();
	return var_01 % 2 * var_00 > var_00;
}

//Function Number: 26
func_0D09()
{
	self.snipershotcount = 0;
	self.sniperhitcount = 0;
	thread func_0D0C();
}

//Function Number: 27
func_0D0C()
{
	self endon("killanimscript");
	self endon("enemy");
	self endon("return_to_cover");
	self notify("new_glint_thread");
	self endon("new_glint_thread");
	if(isdefined(self.var_D0D) && self.var_D0D)
	{
		return;
	}

	if(!isdefined(level._effect["sniper_glint"]))
	{
		return;
	}

	if(!isalive(self.enemy))
	{
		return;
	}

	var_00 = common_scripts\utility::getfx("sniper_glint");
	wait 0.2;
	for(;;)
	{
		if(self.weapon == self.primaryweapon && animscripts/combat_utility::func_D0E())
		{
			if(distancesquared(self.origin,self.enemy.origin) > 65536)
			{
				playfxontag(var_00,self,"tag_flash");
			}

			var_01 = randomfloatrange(3,5);
			wait var_01;
		}

		wait 0.2;
	}
}
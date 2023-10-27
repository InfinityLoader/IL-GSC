/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\shoot_behavior.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 483 ms
 * Timestamp: 10/27/2023 1:24:27 AM
*******************************************************************/

//Function Number: 1
func_2439(param_00)
{
	self endon("killanimscript");
	self notify("stop_deciding_how_to_shoot");
	self endon("stop_deciding_how_to_shoot");
	self endon("death");
	maps\_gameskill::func_660F();
	self.var_7443 = param_00;
	self.var_7439 = undefined;
	self.var_7445 = undefined;
	self.var_744B = "none";
	self.var_31EA = 0;
	self.shouldreturntocover = undefined;
	if(!isdefined(self.changingcoverpos))
	{
		self.changingcoverpos = 0;
	}

	var_01 = isdefined(self.var_1FCA) && self.var_1FCA.type != "Cover Prone" && self.var_1FCA.type != "Conceal Prone";
	if(var_01)
	{
		wait(0.05);
	}

	var_02 = self.var_7439;
	var_03 = self.var_7445;
	var_04 = self.var_744B;
	if(!isdefined(self.var_3FE4))
	{
		self.a.var_4BDF = 1;
		animscripts/shared::func_86F8();
	}

	if(animscripts/combat_utility::issniper())
	{
		resetsniperaim();
	}

	if(var_01 && !self.a.atconcealmentnode || !animscripts/utility::func_19F6())
	{
		thread func_8CE9();
	}

	thread func_699F();
	self.var_CF9 = undefined;
	for(;;)
	{
		if(isdefined(self.var_7447))
		{
			if(!isdefined(self.enemy))
			{
				self.var_7445 = self.var_7447;
				self.var_7447 = undefined;
				func_8AC9();
			}
			else
			{
				self.var_7447 = undefined;
			}
		}

		var_05 = undefined;
		if(self.weapon == "none")
		{
			func_5663();
		}
		else if(animscripts/utility::func_87FA())
		{
			var_05 = func_68B6();
		}
		else if(animscripts/utility::func_87FE())
		{
			var_05 = pistolshoot();
		}
		else
		{
			var_05 = func_66AE();
		}

		if(isdefined(self.a.var_78F5))
		{
			[[ self.a.var_78F5 ]]();
		}

		if(checkchanged(var_02,self.var_7439) || !isdefined(self.var_7439) && checkchanged(var_03,self.var_7445) || checkchanged(var_04,self.var_744B))
		{
			self notify("shoot_behavior_change");
		}

		var_02 = self.var_7439;
		var_03 = self.var_7445;
		var_04 = self.var_744B;
		if(!isdefined(var_05))
		{
			func_8AC9();
		}
	}
}

//Function Number: 2
func_8AC9()
{
	self endon("enemy");
	self endon("done_changing_cover_pos");
	self endon("weapon_position_change");
	self endon("enemy_visible");
	if(isdefined(self.var_7439))
	{
		self.var_7439 endon("death");
		self endon("do_slow_things");
		wait(0.05);
		while(isdefined(self.var_7439))
		{
			self.var_7445 = self.var_7439 getshootatpos();
			wait(0.05);
		}
	}

	self waittill("do_slow_things");
}

//Function Number: 3
func_5663()
{
	self.var_7439 = undefined;
	self.var_7445 = undefined;
	self.var_744B = "none";
	self.var_7443 = "normal";
}

//Function Number: 4
func_74CC()
{
	return !animscripts/combat_utility::issniper() && !animscripts/utility::isshotgun(self.weapon);
}

//Function Number: 5
func_74C0()
{
	if(!animscripts/utility::func_19F6())
	{
		return 0;
	}

	if(!isdefined(self.var_1FCA) && !self canshootenemy())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
rifleshootobjectivenormal()
{
	if(!func_74C0())
	{
		if(animscripts/combat_utility::issniper())
		{
			resetsniperaim();
		}

		if(self.doingambush)
		{
			self.var_7443 = "ambush";
			return "retry";
		}

		if(!isdefined(self.enemy))
		{
			havenothingtoshoot();
		}

		func_50A6();
		if((self.providecoveringfire || randomint(5) > 0) && func_74CC())
		{
			self.var_7443 = "suppress";
		}
		else
		{
			self.var_7443 = "ambush";
		}

		return "retry";
	}

	func_70C2();
	func_70C5();
}

//Function Number: 7
rifleshootobjectivesuppress(param_00)
{
	if(!param_00)
	{
		havenothingtoshoot();
	}

	self.var_7439 = undefined;
	self.var_7445 = animscripts/utility::func_3A97();
	setshootstyleforsuppression();
}

//Function Number: 8
func_66AF(param_00)
{
	self.var_744B = "none";
	self.var_7439 = undefined;
	if(!param_00)
	{
		func_3A1A();
		if(func_74CA())
		{
			self.var_CF9 = undefined;
			self notify("return_to_cover");
			self.shouldreturntocover = 1;
		}
	}

	self.var_7445 = animscripts/utility::func_3A97();
	if(func_74CA())
	{
		self.var_CF9 = undefined;
		if(func_74CC())
		{
			self.var_7443 = "suppress";
		}

		if(randomint(3) == 0)
		{
			self notify("return_to_cover");
			self.shouldreturntocover = 1;
		}

		return "retry";
	}
}

//Function Number: 9
func_3A1A()
{
	if(isdefined(self.enemy) && self cansee(self.enemy))
	{
		func_70C2();
	}

	var_00 = self getanglestolikelyenemypath();
	if(!isdefined(var_00))
	{
		if(isdefined(self.var_1FCA))
		{
			var_00 = self.var_1FCA.angles;
		}
		else if(isdefined(self.var_CFA))
		{
			var_00 = self.var_CFA.angles;
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
	if(!isdefined(self.var_7445) || distancesquared(var_02,self.var_7445) > 25)
	{
		self.var_7445 = var_02;
	}
}

//Function Number: 10
func_66AE()
{
	if(self.var_7443 == "normal")
	{
		rifleshootobjectivenormal();
	}
	else
	{
		if(func_74C0())
		{
			self.var_7443 = "normal";
			self.var_CF9 = undefined;
			return "retry";
		}

		func_50A6();
		if(animscripts/combat_utility::issniper())
		{
			resetsniperaim();
		}

		var_00 = animscripts/utility::cansuppressenemy();
		if(self.var_7443 == "suppress" || self.team == "allies" && !isdefined(self.enemy) && !var_00)
		{
			rifleshootobjectivesuppress(var_00);
		}
		else
		{
			func_66AF(var_00);
		}
	}
}

//Function Number: 11
func_74CA()
{
	if(!isdefined(self.var_CF9))
	{
		if(self isbadguy())
		{
			self.var_CF9 = gettime() + randomintrange(10000,-5536);
		}
		else
		{
			self.var_CF9 = gettime() + randomintrange(4000,10000);
		}
	}

	return self.var_CF9 < gettime();
}

//Function Number: 12
func_68B6()
{
	if(!func_74C0())
	{
		func_50A6();
		havenothingtoshoot();
	}

	func_70C2();
	func_70C3("single",0);
	var_00 = lengthsquared(self.origin - self.var_7445);
	if(var_00 < squared(512))
	{
		self notify("return_to_cover");
		self.shouldreturntocover = 1;
	}
}

//Function Number: 13
pistolshoot()
{
	if(self.var_7443 == "normal")
	{
		if(!func_74C0())
		{
			if(!isdefined(self.enemy))
			{
				havenothingtoshoot();
			}

			func_50A6();
			self.var_7443 = "ambush";
			return "retry";
		}

		func_70C2();
		func_70C3("single",0);
	}

	if(func_74C0())
	{
		self.var_7443 = "normal";
		self.var_CF9 = undefined;
		return "retry";
	}

	func_50A6();
	self.var_7439 = undefined;
	self.var_744B = "none";
	self.var_7445 = animscripts/utility::func_3A97();
	if(!isdefined(self.var_CF9))
	{
		self.var_CF9 = gettime() + randomintrange(4000,8000);
	}

	if(self.var_CF9 < gettime())
	{
		self.var_7443 = "normal";
		self.var_CF9 = undefined;
		return "retry";
	}
}

//Function Number: 14
func_50A6()
{
	if(isdefined(self.enemy) && !self.changingcoverpos && self.script != "combat")
	{
		if(isai(self.enemy) && isdefined(self.enemy.script) && self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")
		{
			if(isdefined(self.enemy.a.covermode) && self.enemy.a.covermode == "hide")
			{
			}
		}

		self.var_1F80 = self.enemy.origin;
	}
}

//Function Number: 15
func_8CE9()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		self waittill("suppression");
		if(self.suppressionmeter > self.var_7D6A)
		{
			if(func_63DB())
			{
				self notify("return_to_cover");
				self.shouldreturntocover = 1;
			}
		}
	}
}

//Function Number: 16
func_63DB()
{
	if(self.changingcoverpos)
	{
		return 0;
	}

	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		return 1;
	}

	if(gettime() < self.coverposestablishedtime + 800)
	{
		return 0;
	}

	if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5)
	{
		if(gettime() < self.coverposestablishedtime + 3000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 17
func_699F()
{
	self endon("death");
	common_scripts\utility::func_8B2A("killanimscript","stop_deciding_how_to_shoot");
	self.a.var_4BDF = 0;
	animscripts/shared::func_86F8();
}

//Function Number: 18
checkchanged(param_00,param_01)
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
func_70C2()
{
	self.var_7439 = self.enemy;
	self.var_7445 = self.var_7439 getshootatpos();
}

//Function Number: 20
havenothingtoshoot()
{
	self.var_7439 = undefined;
	self.var_7445 = undefined;
	self.var_744B = "none";
	if(self.doingambush)
	{
		self.var_7443 = "ambush";
	}

	if(!self.changingcoverpos)
	{
		self notify("return_to_cover");
		self.shouldreturntocover = 1;
	}
}

//Function Number: 21
func_749F()
{
	return level.gameskill == 3 && isplayer(self.enemy);
}

//Function Number: 22
func_70C5()
{
	if(isdefined(self.var_7439.enemy) && isdefined(self.var_7439.enemy.syncedmeleetarget))
	{
		return func_70C3("single",0);
	}

	if(animscripts/combat_utility::issniper())
	{
		return func_70C3("single",0);
	}

	if(animscripts/utility::isshotgun(self.weapon))
	{
		if(animscripts/utility::func_8D9B())
		{
			return func_70C3("single",0);
		}
		else
		{
			return func_70C3("semi",0);
		}
	}

	if(weaponclass(self.weapon) == "grenade")
	{
		return func_70C3("single",0);
	}

	if(weaponburstcount(self.weapon) > 0)
	{
		return func_70C3("burst",0);
	}

	if(isdefined(self.juggernaut) && self.juggernaut)
	{
		return func_70C3("full",1);
	}

	var_00 = distancesquared(self getshootatpos(),self.var_7445);
	var_01 = weaponclass(self.weapon) == "mg";
	if(self.providecoveringfire && var_01)
	{
		return func_70C3("full",0);
	}

	if(var_00 < -3036)
	{
		if(isdefined(self.var_7439) && isdefined(self.var_7439.magic_bullet_shield))
		{
			return func_70C3("single",0);
		}
		else
		{
			return func_70C3("full",0);
		}
	}
	else if(var_00 < 810000 || func_749F())
	{
		if(weaponissemiauto(self.weapon) || func_74AA())
		{
			return func_70C3("semi",1);
		}
		else
		{
			return func_70C3("burst",1);
		}
	}
	else if(self.providecoveringfire || var_01 || var_00 < 2560000)
	{
		if(func_74AA())
		{
			return func_70C3("semi",0);
		}
		else
		{
			return func_70C3("burst",0);
		}
	}

	return func_70C3("single",0);
}

//Function Number: 23
setshootstyleforsuppression()
{
	var_00 = distancesquared(self getshootatpos(),self.var_7445);
	if(weaponissemiauto(self.weapon))
	{
		if(var_00 < 2560000)
		{
			return func_70C3("semi",0);
		}

		return func_70C3("single",0);
	}

	if(weaponclass(self.weapon) == "mg")
	{
		return func_70C3("full",0);
	}

	if(self.providecoveringfire || var_00 < 2560000)
	{
		if(func_74AA())
		{
			return func_70C3("semi",0);
		}
		else
		{
			return func_70C3("burst",0);
		}
	}

	return func_70C3("single",0);
}

//Function Number: 24
func_70C3(param_00,param_01)
{
	self.var_744B = param_00;
	self.var_31EA = param_01;
}

//Function Number: 25
func_74AA()
{
	if(weaponclass(self.weapon) != "rifle")
	{
		return 0;
	}

	if(self.team != "allies")
	{
		return 0;
	}

	var_00 = animscripts/utility::func_69E4(int(self.origin[1]),10000) + 2000;
	var_01 = int(self.origin[0]) + gettime();
	return var_01 % 2 * var_00 > var_00;
}

//Function Number: 26
resetsniperaim()
{
	self.var_766F = 0;
	self.var_766E = 0;
	thread func_7665();
}

//Function Number: 27
func_7665()
{
	self endon("killanimscript");
	self endon("enemy");
	self endon("return_to_cover");
	self notify("new_glint_thread");
	self endon("new_glint_thread");
	if(isdefined(self.var_277C) && self.var_277C)
	{
	}

	if(!isdefined(level._effect["sniper_glint"]))
	{
	}

	if(!isalive(self.enemy))
	{
	}

	var_00 = common_scripts\utility::func_3AB9("sniper_glint");
	wait(0.2);
	for(;;)
	{
		if(self.weapon == self.primaryweapon && animscripts/combat_utility::func_5EFE())
		{
			if(distancesquared(self.origin,self.enemy.origin) > 65536)
			{
				playfxontag(var_00,self,"tag_flash");
			}

			var_01 = randomfloatrange(3,5);
			wait(var_01);
		}

		wait(0.2);
	}
}
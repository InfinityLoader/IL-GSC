/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_behavior.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 637 ms
 * Timestamp: 10/27/2023 2:18:09 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self.var_CF9 = self.origin;
	var_01 = gettime();
	var_02 = spawnstruct();
	var_02.var_F2E = var_01 - 1;
	var_02.var_F2F = var_01 - 1;
	func_0F69();
	func_0F68();
	self.var_F30 = gettime();
	self.a.var_F31 = var_01;
	self.a.var_F32 = 0;
	self.a.movement = "stop";
	self.var_F33 = var_01 + 3000;
	thread func_0F50();
	var_03 = gettime() > 2500;
	var_04 = func_0F40();
	for(;;)
	{
		if(animscripts/combat_utility::func_F34())
		{
			if(animscripts/combat_utility::func_F35(1))
			{
				wait 0.05;
				continue;
			}
		}

		if(isdefined(param_00.var_F36))
		{
			var_05 = gettime();
			thread func_0F60();
			[[ param_00.var_F36 ]]();
			if(gettime() == var_05)
			{
				self notify("dont_end_idle");
			}
		}

		if(isdefined(param_00.var_F37))
		{
			if([[ param_00.var_F37 ]]())
			{
				continue;
			}
		}

		self safeteleport(self.var_CAF.origin,var_04);
		if(!var_03)
		{
			idle(param_00,0.05 + randomfloat(1.5));
			var_03 = 1;
			continue;
		}

		if(func_0F44(param_00))
		{
			continue;
		}

		if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
		{
			if(func_0F61(param_00,level.player))
			{
				continue;
			}
		}

		if(func_0F42())
		{
			return;
		}

		var_06 = 0;
		var_07 = 0;
		if(isalive(self.enemy))
		{
			var_06 = func_0F49();
			var_07 = animscripts/utility::func_F39();
		}

		if(var_06)
		{
			if(self.a.var_F3A < gettime())
			{
				if(animscripts/combat_utility::func_F3B())
				{
					return;
				}
			}

			func_0F45(param_00);
			continue;
		}

		if(isdefined(self.aggressivemode) || func_0F67())
		{
			if(func_0F6D())
			{
				return;
			}
		}

		if(var_07)
		{
			func_0F46(param_00,var_02);
			continue;
		}

		if(func_0F48(param_00,var_02))
		{
			return;
		}
	}
}

//Function Number: 2
func_067F(param_00)
{
	self.var_F3D = undefined;
	self.a.var_F3E = undefined;
	if(isdefined(self.var_F33) && self.var_F33 <= gettime())
	{
		self.var_F3F = gettime() + 5000;
		self.var_F33 = undefined;
	}
}

//Function Number: 3
func_0F40()
{
	var_00 = (self.var_CAF.angles[0],animscripts/utility::func_F41(self.var_CAF),self.var_CAF.angles[2]);
	return var_00;
}

//Function Number: 4
func_0F42()
{
	if(self atdangerousnode() && self.a.var_F43 < gettime())
	{
		if(animscripts/combat_utility::func_F3B())
		{
			return 1;
		}

		self.a.var_F43 = gettime() + 30000;
	}

	return 0;
}

//Function Number: 5
func_0F44(param_00)
{
	if(func_0F4B(param_00))
	{
		if(func_0F49())
		{
			func_0F6B();
		}

		self.a.var_F31 = gettime();
		return 1;
	}

	if(func_0F52(param_00,0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_0F45(param_00)
{
	if(distancesquared(self.origin,self.enemy.origin) > 562500)
	{
		if(func_0F61(param_00,self.enemy))
		{
			return;
		}
	}

	if(func_0F55(param_00,"normal"))
	{
		func_0F6B();
		self.a.var_F31 = gettime();
		return;
	}

	idle(param_00);
}

//Function Number: 7
func_0F46(param_00,param_01)
{
	if(self.var_748)
	{
		if(func_0F55(param_00,"ambush"))
		{
			return;
		}
	}
	else if(self.providecoveringfire || gettime() >= param_01.var_F2F)
	{
		var_02 = "suppress";
		if(!self.providecoveringfire && gettime() - self.var_F47 > 5000 && randomint(3) < 2)
		{
			var_02 = "ambush";
		}
		else if(!animscripts/shoot_behavior::func_CE9())
		{
			var_02 = "ambush";
		}

		if(func_0F55(param_00,var_02))
		{
			param_01.var_F2F = gettime() + randomintrange(3000,20000);
			if(func_0F49())
			{
				self.a.var_F31 = gettime();
			}

			return;
		}
	}

	if(func_0F61(param_00,self.enemy))
	{
		return;
	}

	idle(param_00);
}

//Function Number: 8
func_0F48(param_00,param_01)
{
	if(func_0F52(param_00,0.1))
	{
		return 0;
	}

	if(isdefined(self.enemy))
	{
		if(func_0F61(param_00,self.enemy))
		{
			return 0;
		}
	}

	if(!self.var_748 && gettime() >= param_01.var_F2E)
	{
		if(func_0F56(param_00))
		{
			param_01.var_F2E = gettime() + randomintrange(4000,15000);
			return 0;
		}
	}

	if(gettime() > self.a.var_F3A)
	{
		if(func_0F6C())
		{
			return 1;
		}
	}

	if(self.var_748 || gettime() >= param_01.var_F2F && isdefined(self.enemy))
	{
		if(func_0F55(param_00,"ambush"))
		{
			if(func_0F49())
			{
				func_0F6B();
			}

			self.a.var_F31 = gettime();
			param_01.var_F2F = gettime() + randomintrange(6000,20000);
			return 0;
		}
	}

	idle(param_00);
	return 0;
}

//Function Number: 9
func_0F49()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.enemy.origin,self.var_CF9) < 256)
	{
		return 0;
	}

	return animscripts/utility::func_F4A();
}

//Function Number: 10
func_0F4B(param_00)
{
	if(!animscripts/utility::func_F4C())
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = 1;
	while(animscripts/utility::func_F4C())
	{
		var_02 = 0;
		self safeteleport(self.var_CAF.origin);
		var_03 = 1;
		if(isdefined(self.favor_blindfire))
		{
			var_03 = common_scripts\utility::cointoss();
		}

		if(var_03)
		{
			if(func_0F6E(param_00))
			{
				self notify("killanimscript");
				return 1;
			}
		}

		if(self.a.var_CE2 && animscripts/utility::func_CE3())
		{
			return 0;
		}

		if(func_0F49() || animscripts/utility::func_F39())
		{
			if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
			{
				if(func_0F61(param_00,level.player))
				{
					continue;
				}
			}

			if(func_0F52(param_00,0))
			{
				continue;
			}

			if(self.team != "allies" && gettime() >= var_01)
			{
				if(func_0F64(param_00))
				{
					var_01 = gettime();
					if(!isdefined(self.favor_blindfire))
					{
						var_01 = var_01 + randomintrange(3000,12000);
					}

					continue;
				}
			}

			if(func_0F61(param_00,self.enemy))
			{
				var_02 = 1;
				continue;
			}
		}

		if(func_0F52(param_00,0.1))
		{
			continue;
		}

		idle(param_00);
	}

	if(!var_02 && randomint(2) == 0)
	{
		func_0F58(param_00);
	}

	return 1;
}

//Function Number: 11
func_0F4E(param_00)
{
	var_01 = [];
	if(param_00 == 1)
	{
	}
	else if(var_01 == 2)
	{
	}
	else
	{
		for(var_02 = 0;var_02 < var_01;var_02++ = var_7B[1])
		{
			var_7B[var_02] = var_02;
		}

		for(var_02 = 0;var_02 < var_01;var_02++ = 1 - var_7B[0])
		{
			var_03 = var_02 + randomint(var_01 - var_02);
			var_04 = var_7B[var_03];
			var_7B[var_03] = var_7B[var_02];
			var_7B[var_02] = var_04;
		}
	}

	return var_7B;
}

//Function Number: 12
func_0F4F(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	thread func_0F60();
	var_04 = gettime();
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = [[ param_00 ]](param_01,param_02,param_03);
	}
	else if(isdefined(param_02))
	{
		var_05 = [[ param_00 ]](param_01,param_02);
	}
	else if(isdefined(param_01))
	{
		var_05 = [[ param_00 ]](param_01);
	}
	else
	{
		var_05 = [[ param_00 ]]();
	}

	if(!var_05)
	{
		self notify("dont_end_idle");
	}

	return var_05;
}

//Function Number: 13
func_0F50()
{
	self endon("killanimscript");
	self.var_F47 = gettime() - 100000;
	self.var_F51 = self.var_F47;
	for(;;)
	{
		self waittill("suppression");
		var_00 = gettime();
		if(self.var_F47 < var_00 - 700)
		{
			self.var_F51 = var_00;
		}

		self.var_F47 = var_00;
	}
}

//Function Number: 14
func_0F52(param_00,param_01)
{
	if(self.bulletsinclip > weaponclipsize(self.weapon) * param_01)
	{
		return 0;
	}

	self.var_F53 = 1;
	var_02 = func_0F4F(param_00.var_F54);
	self.var_F53 = 0;
	return var_02;
}

//Function Number: 15
func_0F55(param_00,param_01)
{
	thread animscripts/shoot_behavior::func_CD7(param_01);
	if(!self.fixednode && !self.var_748)
	{
		thread func_0F66();
	}

	var_02 = func_0F4F(param_00.var_F55);
	self notify("stop_deciding_how_to_shoot");
	return var_02;
}

//Function Number: 16
func_0F56(param_00)
{
	if(self.a.var_CE2 && animscripts/utility::func_CE3())
	{
		return 0;
	}

	if(self.a.var_F31 + 6000 > gettime())
	{
		return func_0F58(param_00);
	}

	var_01 = func_0F4F(param_00.var_7A8,2 + randomfloat(2));
	if(var_01)
	{
		return 1;
	}

	return func_0F4F(param_00.var_F57);
}

//Function Number: 17
func_0F58(param_00)
{
	var_01 = func_0F4F(param_00.var_F57);
	if(var_01)
	{
		return 1;
	}

	return func_0F4F(param_00.var_7A8,0);
}

//Function Number: 18
idle(param_00,param_01)
{
	self.var_F5A = 0;
	if(isdefined(param_00.var_F5B))
	{
		if(!self.a.var_F32 && gettime() - self.var_F51 < 600)
		{
			if([[ param_00.var_F5B ]]())
			{
				return 1;
			}
		}
		else
		{
			thread func_0F5F(param_00);
		}
	}

	if(!self.a.var_F32)
	{
		thread func_0F5E(param_00.idle);
		self.a.var_F32 = 1;
	}

	if(isdefined(param_01))
	{
		func_0F5C(param_01);
	}
	else
	{
		func_0F5D();
	}

	if(self.var_F5A)
	{
		self waittill("flinch_done");
	}

	self notify("stop_waiting_to_flinch");
}

//Function Number: 19
func_0F5C(param_00)
{
	self endon("end_idle");
	wait param_00;
}

//Function Number: 20
func_0F5D()
{
	self endon("end_idle");
	wait 0.3 + randomfloat(0.1);
	self waittill("do_slow_things");
}

//Function Number: 21
func_0F5E(param_00)
{
	self endon("killanimscript");
	self [[ param_00 ]]();
}

//Function Number: 22
func_0F5F(param_00)
{
	self endon("killanimscript");
	self endon("stop_waiting_to_flinch");
	var_01 = self.var_F47;
	for(;;)
	{
		self waittill("suppression");
		var_02 = gettime();
		if(var_01 < var_02 - 2000)
		{
			break;
		}

		var_01 = var_02;
	}

	self.var_F5A = 1;
	thread func_0F60();
	var_03 = [[ param_00.var_F5B ]]();
	if(!var_03)
	{
		self notify("dont_end_idle");
	}

	self.var_F5A = 0;
	self notify("flinch_done");
}

//Function Number: 23
func_0F60()
{
	self endon("killanimscript");
	self endon("dont_end_idle");
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self notify("end_idle");
	self.a.var_F32 = 0;
}

//Function Number: 24
func_0F61(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_01.origin - self.origin);
	if(vectordot(var_02,var_03) < 0)
	{
		return 0;
	}

	if(self.var_748 && !animscripts/utility::func_CBC())
	{
		return 0;
	}

	if(animscripts/utility::func_F62())
	{
		return func_0F4F(param_00.var_F63,param_01);
	}

	return func_0F4F(param_00.var_73C,param_01);
}

//Function Number: 25
func_0F64(param_00)
{
	if(!animscripts/utility::func_F65())
	{
		return 0;
	}

	return func_0F4F(param_00.var_F64);
}

//Function Number: 26
func_0F66()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		if(self.fixednode || self.var_748)
		{
			return;
		}

		wait 0.5 + randomfloat(0.75);
		if(!isdefined(self.enemy))
		{
			continue;
		}

		if(func_0F67())
		{
			if(func_0F6D())
			{
				return;
			}
		}

		if(!animscripts/utility::func_CBC() && !animscripts/utility::func_CF3())
		{
			if(gettime() > self.a.var_F3A)
			{
				if(func_0F6C())
				{
					return;
				}
			}
		}
	}
}

//Function Number: 27
func_0F67()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(self.enemy common_scripts\utility::isflashed())
	{
		return 1;
	}

	if(isplayer(self.enemy))
	{
		if(isdefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
		{
			return 1;
		}
	}
	else if(isai(self.enemy) && self.enemy animscripts/utility::func_F4C())
	{
		return 1;
	}

	if(isdefined(self.enemy.var_F53) && self.enemy.var_F53)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_0F68()
{
	self.a.var_F43 = 0;
}

//Function Number: 29
func_0F69()
{
	var_00 = gettime();
	if(isdefined(self.var_F6A) && var_00 > self.a.var_F3A)
	{
		self.a.var_F3A = var_00 + randomintrange(2000,5000);
		return;
	}

	if(isdefined(self.enemy))
	{
		var_01 = distance2d(self.origin,self.enemy.origin);
		if(var_01 < self.var_77C)
		{
			self.a.var_F3A = var_00 + randomintrange(5000,10000);
			return;
		}

		if(var_01 > self.var_77E && var_01 < self.goalradius)
		{
			self.a.var_F3A = var_00 + randomintrange(2000,5000);
			return;
		}

		self.a.var_F3A = var_00 + randomintrange(10000,15000);
		return;
	}

	self.a.var_F3A = var_00 + randomintrange(5000,15000);
}

//Function Number: 30
func_0F6B()
{
	if(isdefined(self.aggressivemode))
	{
		self.var_F30 = gettime() + randomintrange(500,1000);
		return;
	}

	self.var_F30 = gettime() + randomintrange(3000,5000);
}

//Function Number: 31
func_0F6C()
{
	return func_0F6D();
}

//Function Number: 32
func_0F6D()
{
	if(self.fixednode || self.var_748)
	{
		return 0;
	}

	if(isdefined(self.aggressivemode) && gettime() >= self.var_F30)
	{
		return animscripts/combat_utility::func_F35(0);
	}

	var_00 = 0;
	if(!isdefined(self.enemy) || !self.enemy common_scripts\utility::isflashed())
	{
		var_00 = animscripts/combat_utility::func_F3B();
	}

	if(!var_00 && isdefined(self.enemy) && !animscripts/utility::func_F4A())
	{
		if(gettime() >= self.var_F30)
		{
			return animscripts/combat_utility::func_F35(0);
		}
	}

	return var_00;
}

//Function Number: 33
func_0F6E(param_00)
{
	if(isdefined(param_00.var_F37))
	{
		if([[ param_00.var_F37 ]]())
		{
			return 1;
		}
	}

	return animscripts/combat_utility::func_F3B();
}

//Function Number: 34
func_0F6F()
{
	self.a.array["turn_left_45"] = %exposed_tracking_turn45l;
	self.a.array["turn_left_90"] = %exposed_tracking_turn90l;
	self.a.array["turn_left_135"] = %exposed_tracking_turn135l;
	self.a.array["turn_left_180"] = %exposed_tracking_turn180l;
	self.a.array["turn_right_45"] = %exposed_tracking_turn45r;
	self.a.array["turn_right_90"] = %exposed_tracking_turn90r;
	self.a.array["turn_right_135"] = %exposed_tracking_turn135r;
	self.a.array["turn_right_180"] = %exposed_tracking_turn180r;
}

//Function Number: 35
func_0F70()
{
	self.a.array["turn_left_45"] = %exposed_crouch_turn_90_left;
	self.a.array["turn_left_90"] = %exposed_crouch_turn_90_left;
	self.a.array["turn_left_135"] = %exposed_crouch_turn_180_left;
	self.a.array["turn_left_180"] = %exposed_crouch_turn_180_left;
	self.a.array["turn_right_45"] = %exposed_crouch_turn_90_right;
	self.a.array["turn_right_90"] = %exposed_crouch_turn_90_right;
	self.a.array["turn_right_135"] = %exposed_crouch_turn_180_right;
	self.a.array["turn_right_180"] = %exposed_crouch_turn_180_right;
}

//Function Number: 36
func_0F71(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node;
		var_02 = abs(angleclamp180(self.angles[1] - var_01.angles[1] + param_00));
		if(self.a.pose == "stand" && var_01 gethighestnodestance() != "stand")
		{
			if(var_02 > 45 && var_02 < 90)
			{
				self orientmode("face angle",self.angles[1]);
			}
			else
			{
				self orientmode("face current");
			}

			var_03 = 1.5;
			var_04 = getnotetracktimes(%exposed_stand_2_crouch,"anim_pose = \"crouch\")[0];
			var_04 = min(1,var_04 * 1.1);
			var_05 = var_04 * getanimlength(%exposed_stand_2_crouch) / var_03;
			self setflaggedanimknoballrestart("crouchanim",%exposed_stand_2_crouch,%body,1,0.2,var_03);
			animscripts/notetracks::func_D4F(var_05,"crouchanim");
			self clearanim(%body,0.2);
		}

		self orientmode("face angle",self.angles[1]);
		var_06 = angleclamp180(self.angles[1] - var_01.angles[1] + param_00);
		if(abs(var_06) > 45)
		{
			if(self.a.pose == "stand")
			{
				func_0F6F();
			}
			else
			{
				func_0F70();
			}

			self.var_F72 = 45;
			self.var_F3D = 1;
			animscripts/combat::func_F73(var_06);
			self.var_F3D = undefined;
		}
	}
}

//Function Number: 37
func_0F37()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.var_F6A))
	{
		self.var_F6A = undefined;
		return 0;
	}

	if(!isdefined(self.node))
	{
		return 0;
	}

	if(randomint(3) == 0)
	{
		return 0;
	}

	if(self.fixednode || self.var_748 || self.var_766 || self.keepclaimednodeifvalid)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.node.origin) > 256)
	{
		return 0;
	}

	var_00 = self findshufflecovernode();
	if(isdefined(var_00) && var_00 != self.node && self usecovernode(var_00))
	{
		self.var_F74 = 1;
		self.var_F75 = var_00;
		self.var_F6A = 1;
		wait 0.5;
		return 1;
	}

	return 0;
}
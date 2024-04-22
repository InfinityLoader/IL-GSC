/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: door.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 171 ms
 * Timestamp: 4/22/2024 2:00:27 AM
*******************************************************************/

//Function Number: 1
doorenterexitcheck()
{
	self endon("killanimscript");
	if(isdefined(self.disabledoorbehavior))
	{
		return;
	}

	for(;;)
	{
		var_00 = self getdoorpathnode();
		if(isdefined(var_00))
		{
			break;
		}

		wait(0.2);
	}

	var_01 = var_00.type == "Door Interior" || self comparenodedirtopathdir(var_00);
	if(var_01)
	{
		doorenter(var_00);
	}
	else
	{
		doorexit(var_00);
	}

	for(;;)
	{
		var_02 = self getdoorpathnode();
		if(!isdefined(var_02) || var_02 != var_00)
		{
			break;
		}

		wait(0.2);
	}

	thread doorenterexitcheck();
}

//Function Number: 2
teamflashbangimmune()
{
	self endon("killanimscript");
	self.teamflashbangimmunity = 1;
	wait(5);
	self.teamflashbangimmunity = undefined;
}

//Function Number: 3
dodoorgrenadethrow(param_00)
{
	thread teamflashbangimmune();
	if(self.grenadeweapon == "flash_grenade")
	{
		self notify("flashbang_thrown");
	}

	self orientmode("face current");
	param_00.nextdoorgrenadetime = gettime() + 5000;
	self.minindoortime = gettime() + 100000;
	self notify("move_interrupt");
	self.update_move_anim_type = undefined;
	self clearanim(%combatrun,0.2);
	self.a.movement = "stop";
	self waittill("done_grenade_throw");
	self orientmode("face default");
	self.minindoortime = gettime() + 5000;
	self.grenadeweapon = self.oldgrenadeweapon;
	self.oldgrenadeweapon = undefined;
	animscripts\run::endfaceenemyaimtracking();
	thread animscripts\move::pathchangelistener();
	thread animscripts\move::restartmoveloop(1);
}

//Function Number: 4
doorenter_trygrenade(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 3;
	var_07 = undefined;
	var_07 = %cqb_stand_grenade_throw;
	var_08 = anglestoforward(param_00.angles);
	if(param_00.type == "Door Interior" && !self comparenodedirtopathdir(param_00))
	{
		var_08 = -1 * var_08;
	}

	var_09 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] + 64);
	var_0A = var_09;
	if(param_02)
	{
		var_0B = anglestoright(param_00.angles);
		var_0C = param_00.origin - self.origin;
		var_0D = vectordot(var_0B,var_0C);
		if(var_0D > 20)
		{
			var_0D = 20;
		}
		else if(var_0D < -20)
		{
			var_0D = -20;
		}

		var_0A = var_09 + var_0D * var_0B;
	}

	while(var_06 > 0)
	{
		if(isdefined(self.grenade) || !isdefined(self.enemy))
		{
			return;
		}

		if(onsamesideofdoor(param_00,var_08))
		{
			return;
		}

		if(!self seerecently(self.enemy,0.2) && self.a.pose == "stand" && distance2dandheightcheck(self.enemy.origin - param_00.origin,360000,16384))
		{
			if(isdefined(param_00.nextdoorgrenadetime) && param_00.nextdoorgrenadetime > gettime())
			{
				return;
			}

			if(self canshootenemy())
			{
				return;
			}

			var_0C = param_00.origin - self.origin;
			if(lengthsquared(var_0C) < param_03)
			{
				return;
			}

			if(vectordot(var_0C,var_08) < 0)
			{
				return;
			}

			self.oldgrenadeweapon = self.grenadeweapon;
			self.grenadeweapon = param_01;
			animscripts\combat_utility::setactivegrenadetimer(self.enemy);
			if(!var_05)
			{
				var_0E = var_09 + var_08 * 100;
				if(!self isgrenadepossafe(self.enemy,var_0E,128))
				{
					return;
				}
			}

			var_05 = 1;
			if(animscripts\combat_utility::trygrenadethrow(self.enemy,var_0A,var_07,animscripts\combat_utility::getgrenadethrowoffset(var_07),1,0,1))
			{
				dodoorgrenadethrow(param_00);
				return;
			}
		}

		var_06--;
		wait(param_04);
		var_0F = self getdoorpathnode();
		if(!isdefined(var_0F) || var_0F != param_00)
		{
			return;
		}
	}
}

//Function Number: 5
indoorcqbtogglecheck()
{
	self endon("killanimscript");
	if(isdefined(self.disabledoorbehavior))
	{
		return;
	}

	self.isindoor = 0;
	for(;;)
	{
		if(self isindoor() && !self.doingambush)
		{
			doorenter_enable_cqbwalk();
		}
		else if(!isdefined(self.minindoortime) || self.minindoortime < gettime())
		{
			self.minindoortime = undefined;
			doorexit_disable_cqbwalk();
		}

		wait(0.2);
	}
}

//Function Number: 6
doorenter_enable_cqbwalk()
{
	if(!isdefined(self.neverenablecqb) && !self.doingambush)
	{
		self.isindoor = 1;
		if(!isdefined(self.cqbwalking) || !self.cqbwalking)
		{
			maps\_utility::enable_cqbwalk(1);
		}
	}
}

//Function Number: 7
doorexit_disable_cqbwalk()
{
	if(!isdefined(self.cqbenabled))
	{
		self.isindoor = 0;
		if(isdefined(self.cqbwalking) && self.cqbwalking)
		{
			maps\_utility::disable_cqbwalk();
		}
	}
}

//Function Number: 8
distance2dandheightcheck(param_00,param_01,param_02)
{
	return param_00[0] * param_00[0] + param_00[1] * param_00[1] < param_01 && param_00[2] * param_00[2] < param_02;
}

//Function Number: 9
onsamesideofdoor(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = param_00.origin - self.enemy.origin;
	return vectordot(var_02,param_01) * vectordot(var_03,param_01) > 0;
}

//Function Number: 10
doorenter(param_00)
{
	for(;;)
	{
		if(isdefined(self.doorfragchance) && self.doorfragchance == 0 || self.doorfragchance < randomfloat(1))
		{
			break;
		}

		if(distance2dandheightcheck(self.origin - param_00.origin,562500,25600))
		{
			doorenter_trygrenade(param_00,"fraggrenade",0,302500,0.3);
			param_00 = self getdoorpathnode();
			if(!isdefined(param_00))
			{
				return;
			}

			break;
		}

		wait(0.1);
	}

	for(;;)
	{
		if(distance2dandheightcheck(self.origin - param_00.origin,36864,6400))
		{
			doorenter_enable_cqbwalk();
			self.minindoortime = gettime() + 6000;
			if(isdefined(self.doorflashchance) && self.doorflashchance == 0 || self.doorflashchance < randomfloat(1))
			{
				return;
			}

			doorenter_trygrenade(param_00,"flash_grenade",1,4096,0.2);
			return;
		}

		wait(0.1);
	}
}

//Function Number: 11
doorexit(param_00)
{
	for(;;)
	{
		if(!self.isindoor || distancesquared(self.origin,param_00.origin) < 1024)
		{
			return;
		}

		wait(0.1);
	}
}
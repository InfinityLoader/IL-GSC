/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\zombie_sasquatch\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1342 ms
 * Timestamp: 10/26/2023 11:59:08 PM
*******************************************************************/

//Function Number: 1
sasquatch_init(param_00)
{
	var_01 = gettime();
	self.var_3135.allowthrowtime = var_01 + 8000;
	self.var_3135.allowrushtime = var_01 + 5000;
	return level.var_111AE;
}

//Function Number: 2
isintrees(param_00)
{
	return level.var_6AD5;
}

//Function Number: 3
updateeveryframe(param_00)
{
	if(!isalive(self))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_EF47) && self.var_EF47)
	{
		return level.var_6AD5;
	}

	var_01 = getclosestplayer();
	self.var_3135.var_10C = var_01;
	return level.var_111AE;
}

//Function Number: 4
shouldswingaround(param_00)
{
	return level.var_6AD5;
}

//Function Number: 5
shouldthrowrock(param_00)
{
	if(!isdefined(self.var_3135.var_10C))
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.allowthrowtime)
	{
		return level.var_6AD5;
	}

	var_01 = distance2dsquared(self.var_3135.var_10C.origin,self.origin);
	if(var_01 > 360000)
	{
		return level.var_6AD5;
	}

	if(var_01 < 16384)
	{
		return level.var_6AD5;
	}

	if(!self method_805F(self.var_3135.var_10C))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 6
throwattack_check(param_00)
{
	var_01 = lib_0A1B::func_2930();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(!isalive(var_01))
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.origin,var_01.origin) > 518400)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 7
throwattack_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.var_9928[param_00].target = self.var_3135.var_10C;
	self method_8286(self.origin);
	self method_8287(64);
	lib_0A1B::func_296C(1,self.var_3135.var_10C);
}

//Function Number: 8
throwattack(param_00)
{
	var_01 = 5000;
	if(gettime() - self.var_3135.var_9928[param_00].var_10DFF > var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("throwevent","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 9
throwattack_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	lib_0A1B::func_296C(0);
	self.var_3135.allowthrowtime = gettime() + 8000;
}

//Function Number: 10
func_10039(param_00)
{
	if(!isdefined(self.var_3135.var_10C))
	{
		return level.var_6AD5;
	}

	var_01 = self.var_3135.var_10C;
	if(isdefined(self.var_3135.lastmeleefailtarget) && self.var_3135.lastmeleefailtarget == var_01 && gettime() - self.var_3135.lastmeleefailtime < 3000)
	{
		return level.var_6AD5;
	}

	var_02 = var_01.origin - self.origin;
	var_03 = length2dsquared(var_02);
	if(var_03 > 65536)
	{
		return level.var_6AD5;
	}

	if(abs(var_02[2]) > 72 && var_03 < 10000)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 11
melee_setup(param_00)
{
	self.var_3135.var_B64D = self.var_3135.var_10C;
	return level.var_111AE;
}

//Function Number: 12
func_B5B5()
{
	var_00 = self.var_3135.var_B64D;
	if(!isdefined(var_00))
	{
		return 1;
	}

	if(!isalive(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
melee_cleanup()
{
	self.var_3135.var_B64D = undefined;
}

//Function Number: 14
melee_failed(param_00,param_01)
{
	self.var_3135.lastmeleefailtime = gettime();
	self.var_3135.lastmeleefailtarget = param_01;
	self.var_3135.lastmeleefailreason = param_00;
}

//Function Number: 15
melee_charge_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.var_9928[param_00].prevgoalpos = self.origin;
}

//Function Number: 16
melee_charge(param_00)
{
	if(func_B5B5())
	{
		return level.var_6AD5;
	}

	var_01 = self.var_3135.var_B64D;
	var_02 = gettime() - self.var_3135.var_9928[param_00].var_10DFF;
	var_03 = isdefined(self method_8150());
	if(var_02 > 200 && !var_03)
	{
		melee_failed(1,var_01);
		return level.var_6AD5;
	}

	if(var_02 > 5000)
	{
		melee_failed(3,var_01);
		return level.var_6AD5;
	}

	var_04 = var_01.origin - self.origin;
	var_05 = length2dsquared(var_04);
	var_06 = var_05;
	if(var_03)
	{
		var_07 = self method_841E();
		var_06 = var_07 * var_07;
	}

	if(var_06 > 200704)
	{
		melee_failed(2,var_01);
		return level.var_6AD5;
	}

	if(var_05 < 5184)
	{
		var_08 = self method_84AC();
		var_09 = getclosestpointonnavmesh(var_01.origin,self);
		if(navisstraightlinereachable(var_08,var_09,self))
		{
			self.var_3135.var_9928[param_00].bsuccess = 1;
			return level.var_111AE;
		}
	}

	var_0A = var_01.origin;
	var_0B = 144;
	if(distance2dsquared(var_0A,self.var_3135.var_9928[param_00].prevgoalpos) > var_0B)
	{
		self method_8286(var_0A);
		self method_8287(24);
		self.var_3135.var_9928[param_00].prevgoalpos = var_0A;
	}

	return level.var_E87A;
}

//Function Number: 17
melee_charge_cleanup(param_00)
{
	if(!isdefined(self.var_3135.var_9928[param_00].bsuccess))
	{
		melee_cleanup();
	}

	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 18
melee_attack_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	lib_0A1B::func_2965(self.var_3135.var_B64D);
	self method_8286(self.origin);
	self method_8287(64);
}

//Function Number: 19
melee_attack(param_00)
{
	if(func_B5B5())
	{
		return level.var_6AD5;
	}

	var_01 = 10000;
	if(gettime() - self.var_3135.var_9928[param_00].var_10DFF > var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("meleeattack","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 20
melee_attack_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	melee_cleanup();
	lib_0A1B::func_2914();
}

//Function Number: 21
shouldrush(param_00)
{
	var_01 = self.var_3135.var_10C;
	if(!isdefined(var_01) || !isalive(var_01))
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.allowrushtime)
	{
		return level.var_6AD5;
	}

	var_02 = var_01.origin - self.origin;
	var_03 = length2dsquared(var_02);
	if(var_03 > 589824)
	{
		return level.var_6AD5;
	}

	if(var_03 < 32400)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_233))
	{
		var_04 = self method_84F9(84);
		if(isdefined(var_04))
		{
			return level.var_6AD5;
		}

		if(self method_841E() > 1179648)
		{
			return level.var_6AD5;
		}
	}

	if(!self method_805F(var_01))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 22
rush_charge_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.var_9928[param_00].var_2C5 = self.origin;
	self.var_3135.var_9928[param_00].var_3140 = 1;
	self.var_1198.var_BD23 = "sprint";
	self.var_1198.brushorienttoenemy = 1;
	self.var_1198.brushrequested = 1;
	self.var_3135.var_B64D = self.var_3135.var_10C;
}

//Function Number: 23
rush_charge(param_00)
{
	var_01 = 0;
	var_02 = 1;
	var_03 = 2;
	if(func_B5B5())
	{
		return level.var_111AE;
	}

	var_04 = gettime();
	var_05 = self.var_3135.var_9928[param_00].var_10DFF;
	var_06 = 8000;
	if(var_04 > var_05 + var_06)
	{
		self.var_3135.var_9928[param_00].bfailure = 1;
		return level.var_6AD5;
	}

	if(distance2dsquared(self.origin,self.var_3135.var_9928[param_00].var_2C5) > 262144)
	{
		return level.var_111AE;
	}

	var_07 = self.var_3135.var_B64D.origin - self.origin;
	if(length2dsquared(var_07) < 20736)
	{
		self.var_3135.var_9928[param_00].bsuccess = 1;
		return level.var_111AE;
	}

	if(var_04 > var_05 + 200 && !isdefined(self.var_233))
	{
		self.var_3135.var_9928[param_00].bfailure = 1;
		return level.var_6AD5;
	}

	var_08 = self method_84F9(84);
	if(isdefined(var_08))
	{
		self.var_3135.var_9928[param_00].bfailure = 1;
		return level.var_6AD5;
	}

	if(self.var_3135.var_9928[param_00].var_3140)
	{
		var_09 = 1000;
		if(var_04 > self.var_3135.var_9928[param_00].var_10DFF + var_09)
		{
			var_0A = vectornormalize((var_07[0],var_07[1],0));
			var_0B = self method_813A();
			var_0B = vectornormalize((var_0B[0],var_0B[1],0));
			if(vectordot(var_07,var_0B) < 0.966)
			{
				var_0C = self.origin + var_0B * 208;
				var_0D = self method_84AC();
				var_0E = navtrace(var_0D,var_0C,self,1);
				if(var_0E["fraction"] < 1)
				{
					var_0C = var_0E["position"];
				}

				self method_8286(var_0C);
				self method_8287(24);
				self.var_3135.var_9928[param_00].var_3140 = 0;
			}
			else
			{
				self method_8286(self.var_3135.var_B64D.origin);
				self method_8287(24);
			}
		}
		else
		{
			self method_8286(self.var_3135.var_B64D.origin);
			self method_8287(24);
		}
	}
	else if(self method_841E() < 144)
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 24
rush_charge_cleanup(param_00)
{
	if(!isdefined(self.var_3135.var_9928[param_00].bsuccess))
	{
		melee_cleanup();
		self.var_3135.allowrushtime = gettime() + 1000;
	}

	self.var_1198.var_BD23 = "run";
	self.var_1198.brushrequested = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 25
rush_attack_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	lib_0A1B::func_2965(self.var_3135.var_B64D);
}

//Function Number: 26
rush_attack(param_00)
{
	var_01 = gettime();
	var_02 = 5000;
	if(var_01 > self.var_3135.var_9928[param_00] + var_02)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("rushattack","end"))
	{
		self.var_3135.allowrushtime = var_01 + 5000;
		return level.var_111AE;
	}

	self method_8286(self.origin);
	self method_8287(36);
	return level.var_E87A;
}

//Function Number: 27
rush_attack_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	lib_0A1B::func_2914();
	melee_cleanup();
}

//Function Number: 28
shouldtaunt(param_00)
{
	if(isdefined(self.killed_player))
	{
		self.killed_player = undefined;
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 29
taunt_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.btauntrequested = 1;
	self method_8286(self.origin);
	self method_8287(64);
}

//Function Number: 30
func_5ABE(param_00)
{
	var_01 = 6000;
	if(gettime() - self.var_3135.var_9928[param_00] > var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("tauntevent","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 31
taunt_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.btauntrequested = undefined;
}

//Function Number: 32
wander_init(param_00)
{
	var_01 = spawnstruct();
	var_01.curtargetpos = self.origin;
	var_01.nextchecktime = gettime();
	self.var_3135.var_9928[param_00] = var_01;
}

//Function Number: 33
getclosestplayer()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03.ignoreme || isdefined(var_03.var_222) && var_03.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_03))
		{
			continue;
		}

		var_04 = distance2dsquared(self.origin,var_03.origin);
		if(!isdefined(var_00) || var_04 < var_01)
		{
			var_00 = var_03;
			var_01 = var_04;
		}
	}

	return var_00;
}

//Function Number: 34
wander(param_00)
{
	if(isdefined(self.var_3135.var_10C) && !scripts\common\utility::istrue(self.var_3135.var_10C.ignoreme))
	{
		var_01 = self.var_3135.var_10C.origin;
		if(!isdefined(self.var_233) || distance2dsquared(var_01,self.var_3135.var_9928[param_00].curtargetpos) > 1296)
		{
			self.var_3135.var_9928[param_00].curtargetpos = var_01;
			var_02 = getclosestpointonnavmesh(var_01,self);
			self method_8286(var_02);
		}
	}
	else if(gettime() >= self.var_3135.var_9928[param_00].nextchecktime || isdefined(self.var_3135.var_10C) && scripts\common\utility::istrue(self.var_3135.var_10C.ignoreme))
	{
		var_03 = getclosestplayer();
		if(isdefined(var_03))
		{
			self.var_3135.var_9928[param_00].curtargetpos = var_03.origin;
			var_02 = getclosestpointonnavmesh(var_03.origin,self);
			self method_8286(var_02);
			self.var_3135.var_9928[param_00].nextchecktime = self.var_3135.var_9928[param_00].nextchecktime + 2000;
		}
	}

	return level.var_E87A;
}

//Function Number: 35
wander_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\dlc4\behavior_utils.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 226 ms
 * Timestamp: 10/26/2023 11:58:36 PM
*******************************************************************/

//Function Number: 1
pickbetterenemy(param_00,param_01)
{
	var_02 = self method_805F(param_00);
	var_03 = self method_805F(param_01);
	if(var_02 != var_03)
	{
		if(var_02)
		{
			return param_00;
		}

		return param_01;
	}

	var_04 = distancesquared(self.origin,param_00.origin);
	var_05 = distancesquared(self.origin,param_01.origin);
	if(var_04 < var_05)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 2
shouldignoreenemy(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(param_00.ignoreme || isdefined(param_00.var_222) && param_00.var_222.ignoreme)
	{
		return 1;
	}

	if(lib_0F74::func_1002C(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_12E8A()
{
	if(isdefined(self.myenemy) && !shouldignoreenemy(self.myenemy))
	{
		if(gettime() - self.myenemystarttime < 3000)
		{
			return self.myenemy;
		}
	}

	var_00 = undefined;
	foreach(var_02 in level.players)
	{
		if(shouldignoreenemy(var_02))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.isfasttravelling))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			var_00 = var_02;
			continue;
		}

		var_00 = pickbetterenemy(var_00,var_02);
	}

	if(!isdefined(var_00))
	{
		self.myenemy = undefined;
		return undefined;
	}

	if(!isdefined(self.myenemy) || var_00 != self.myenemy)
	{
		self.myenemy = var_00;
		self.myenemystarttime = gettime();
	}
}

//Function Number: 4
getpredictedenemypos(param_00,param_01)
{
	var_02 = param_00 getvelocity();
	var_03 = length2d(var_02);
	var_04 = param_00.origin + var_02 * param_01;
	return var_04;
}

//Function Number: 5
facepoint(param_00)
{
	var_01 = scripts\common\utility::func_824D(param_00);
	if(abs(var_01) < 8)
	{
		var_02 = (self.angles[0],self.angles[1] + var_01,self.angles[2]);
		self method_8289("face angle abs",var_02);
		return;
	}

	self.desiredyaw = var_02;
}
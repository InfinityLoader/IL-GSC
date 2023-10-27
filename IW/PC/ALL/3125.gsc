/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3125.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:12 AM
*******************************************************************/

//Function Number: 1
func_D4D9(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1B::func_2923();
	lib_0A1D::func_2364(param_00,param_01,param_02);
}

//Function Number: 2
func_B644(param_00,param_01,param_02)
{
	var_03 = lib_0A1B::func_2924();
	return distancesquared(self.origin,var_03) <= param_02 * param_02;
}

//Function Number: 3
func_B643(param_00,param_01,param_02)
{
	var_03 = 50;
	var_04 = lib_0A1B::func_2924();
	return distancesquared(self.origin,var_04) <= var_03;
}

//Function Number: 4
func_D4D7(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1B::func_2925();
	if(!isdefined(var_04))
	{
		self method_8289("face angle abs",self.angles);
	}
	else if(isplayer(var_04) && var_04 == self.var_10C)
	{
		self method_8289("face enemy");
	}
	else
	{
		var_05 = var_04.origin - self.origin;
		var_06 = vectornormalize(var_05);
		var_07 = vectortoangles(var_06);
		self method_8289("face angle abs",var_07);
	}

	self method_82AF(param_01);
	self endon(param_01 + "_finished");
	func_592C(param_00,param_01);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 5
func_592C(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_01,var_02);
		if(!isarray(var_02))
		{
			var_02 = [var_02];
		}

		foreach(var_04 in var_02)
		{
			switch(var_04)
			{
				case "end":
					break;
	
				case "stop":
					var_05 = lib_0A1B::func_2925();
					if(!isdefined(var_05))
					{
						return;
					}
		
					if(!isalive(var_05))
					{
						return;
					}
		
					var_06 = distancesquared(var_05.origin,self.origin);
					if(var_06 > 4096)
					{
						return;
					}
					break;
	
				case "start_melee":
				case "fire":
					var_05 = lib_0A1B::func_2925();
					if(!isdefined(var_05))
					{
						return;
					}
		
					if(isalive(var_05))
					{
						func_CA1F(var_05);
					}
					break;
	
				default:
					lib_0A1D::func_2345(var_04,param_01);
					break;
			}
		}
	}
}

//Function Number: 6
func_7FAC()
{
	var_00 = randomfloatrange(self.meleemindamage,self.meleemaxdamage);
	return var_00;
}

//Function Number: 7
func_CA1F(param_00)
{
	if(!isalive(param_00))
	{
		return;
	}

	self.var_B5C7 = 1;
	var_01 = func_7FAC();
	var_02 = 1;
	var_03 = distancesquared(self.origin,param_00.origin);
	if(var_03 > self.meleerangesq)
	{
		return;
	}

	if(isplayer(param_00))
	{
		var_04 = func_3D76(param_00);
		var_05 = func_3D95(param_00);
		if(var_04 || var_05)
		{
			return;
		}
		else
		{
			if(isdefined(param_00.var_9E59) && param_00.var_9E59)
			{
				var_01 = var_01 * 0.65;
				earthquake(0.25,0.25,param_00.origin,100);
			}

			var_02 = param_00 getviewkickscale();
			param_00 func_F329(var_01);
		}
	}

	if(isdefined(self.var_B62B))
	{
		[[ self.var_B62B ]](self,param_00);
	}

	param_00 dodamage(var_01,self.origin,self,self);
	param_00 thread func_F5FE(var_02);
}

//Function Number: 8
func_F5FE(param_00)
{
	scripts\common\utility::func_136F7();
	self setviewkickscale(param_00);
}

//Function Number: 9
func_3D95(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = vectornormalize(self.origin - param_00.origin);
	var_03 = vectordot(var_02,var_01);
	if(param_00 meleebuttonpressed() && isdefined(param_00.var_B648) && param_00.var_B648 == 1 && var_03 > 0.5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_3D76(param_00)
{
	return 0;
}

//Function Number: 11
func_F329(param_00)
{
	var_01 = 10;
	var_02 = 2;
	var_03 = 50;
	var_04 = min(1,param_00 / var_03);
	var_05 = var_01 - var_02 * var_04;
	var_06 = var_02 + var_05;
	self setviewkickscale(var_06);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2565.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:23:20 AM
*******************************************************************/

//Function Number: 1
func_360D(param_00,param_01,param_02,param_03)
{
	if(isarray(param_01))
	{
		self.var_EF6D[param_00] = param_01;
	}
	else
	{
		self.var_EF6D[param_00] = [param_01];
	}

	self.var_EF70[param_00] = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self.var_EF6E[param_00] = param_03;
}

//Function Number: 2
func_360C(param_00)
{
	self.var_E5C4 = param_00;
}

//Function Number: 3
func_352D(param_00)
{
	if(!isdefined(self.var_EF6D))
	{
		return;
	}

	self.var_EF6D[param_00] = undefined;
	self.var_EF70[param_00] = undefined;
	self.var_EF6E[param_00] = undefined;
	if(self.var_EF6D.size == 0)
	{
		self.var_EF6D = undefined;
		self.var_EF70 = undefined;
		self.var_EF6E = undefined;
	}
}

//Function Number: 4
func_3552(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.var_27F7 = param_00;
}

//Function Number: 5
func_3555(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self.var_13C83[param_00] = param_01;
}

//Function Number: 6
func_3551(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.var_290A = param_00;
	if(!param_00)
	{
		self method_8484();
	}
}

//Function Number: 7
func_3540(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.var_30E9 = param_00;
}

//Function Number: 8
func_353F(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.var_30E7 = param_00;
	if(param_00)
	{
		self notify("rodeo_disabled");
		return;
	}

	self notify("rodeo_enabled");
}

//Function Number: 9
func_3553(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		self.var_3131 = 1;
		return;
	}

	self.var_3131 = undefined;
}

//Function Number: 10
func_3609(param_00)
{
	self.var_1A48 = param_00;
}

//Function Number: 11
func_35AC()
{
	return lib_0A1B::func_9ED3("right_leg") || lib_0A1B::func_9ED3("left_leg");
}

//Function Number: 12
func_3554(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self.var_32D5 = param_00;
}

//Function Number: 13
func_3634(param_00)
{
	thread func_1375A(param_00);
}

//Function Number: 14
func_1375A(param_00)
{
	level.player endon("death");
	self waittill("death");
	wait(0.1);
	level.player method_84C7(param_00,1);
	if(level.player method_84C6("c12AchievementRodeoLeft") && level.player method_84C6("c12AchievementRodeoRight") && level.player method_84C6("c12AchievementSelfdestruct"))
	{
		scripts\sp\_utility::func_834F("KILL_C12S");
	}
}

//Function Number: 15
func_35A8(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	scripts\common\utility::array_thread(param_00,::func_3638,param_01,param_02,param_03,param_04);
}

//Function Number: 16
func_3638(param_00,param_01,param_02,param_03)
{
	level.player endon("death");
	var_04 = scripts\common\utility::spawn_tag_origin(self.origin + (0,0,25));
	var_04.var_E297 = 0;
	var_04 endon("death");
	var_04 thread func_3639(param_00);
	thread func_363A(var_04,param_03);
	if(isdefined(param_02))
	{
		level waittill(param_02);
	}

	if(level.var_7683 == 3)
	{
		wait(10);
	}

	for(;;)
	{
		while(distance2dsquared(var_04.origin,level.player.origin) < squared(128))
		{
			wait(0.05);
		}

		if(func_35DB(param_03) && !var_04.var_E297)
		{
			var_04 lib_0E46::func_48C4("tag_origin",undefined,undefined,undefined,5000,0,1,0,0,param_01,0,0);
			while(distance2dsquared(var_04.origin,level.player.origin) >= squared(128))
			{
				if(func_35DB(param_03))
				{
					wait(0.05);
					continue;
				}

				break;
			}

			var_04 lib_0E46::func_DFE3();
		}

		wait(0.05);
	}
}

//Function Number: 17
func_3639(param_00)
{
	while(!isdefined(param_00.var_3508))
	{
		wait(0.05);
	}

	param_00.var_3508 scripts\common\utility::waittill_any_3("death","begin_rodeo","self_destruct");
	self delete();
}

//Function Number: 18
func_35DB(param_00)
{
	var_01 = level.player getweaponslistprimaries();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		switch(getweaponbasename(var_04))
		{
			case "iw7_atomizer":
				return 0;

			case "iw7_penetrationrail":
			case "iw7_chargeshot":
			case "iw7_lockon":
			case "iw7_steeldragon":
				var_02[var_02.size] = var_04;
				break;
		}
	}

	if(var_02.size == 0)
	{
		return 1;
	}

	foreach(var_04 in var_02)
	{
		var_07 = 0;
		if(param_00)
		{
			var_07 = int(weaponclipsize(var_04) / 2);
		}

		if(level.player getweaponammostock(var_04) + level.player getweaponammoclip(var_04) > var_07)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 19
func_363A(param_00,param_01)
{
	level.player endon("death");
	param_00 endon("death");
	var_02 = scripts\common\utility::spawn_tag_origin(self.origin,self.angles);
	var_03 = self;
	var_04 = getsubstr(var_03.classname,7);
	if(param_01)
	{
		var_05 = function_0249(var_04);
		var_06 = 0;
	}
	else
	{
		var_05 = 1;
		var_06 = 1;
	}

	for(;;)
	{
		var_03 method_81CC(var_06,var_05);
		var_03 waittill("trigger");
		if(isdefined(var_03))
		{
			var_03 delete();
		}

		if(level.player method_80FB(var_04) == var_06 + var_05)
		{
			level.player switchtoweapon(var_04);
			if(param_01)
			{
				level.player setweaponammoclip(var_04,weaponclipsize(var_04));
				level.player setweaponammostock(var_04,var_05);
			}
		}

		param_00.var_E297 = 1;
		while(distance2dsquared(var_02.origin,level.player.origin) < squared(512))
		{
			wait(1);
		}

		wait(10);
		if(level.var_7683 == 3)
		{
			wait(10);
		}

		param_00.var_E297 = 0;
		var_03 = spawn("weapon_" + var_04,var_02.origin,1);
		var_03.angles = var_02.angles;
	}
}
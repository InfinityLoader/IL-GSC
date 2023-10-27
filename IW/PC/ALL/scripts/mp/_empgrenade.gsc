/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_empgrenade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 409 ms
 * Timestamp: 10/27/2023 12:15:12 AM
*******************************************************************/

//Function Number: 1
func_13A12()
{
	var_00 = scripts\common\utility::spawn_tag_origin();
	var_00 linkto(self);
	self.var_A63A = var_00;
	thread func_A639(var_00);
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	var_01 = self.var_222;
	self waittill("explode",var_02);
	thread func_0118(var_02,256,var_01,var_00);
}

//Function Number: 2
func_C5CB(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		return;
	}
	else if(param_02 == "MOD_IMPACT")
	{
		return;
	}

	if(issubstr(self.var_13C2E,"iw7_tacburst_mpl"))
	{
		func_20BF(param_00,param_04);
	}

	func_20C3(param_00,param_04,param_01);
}

//Function Number: 3
func_0118(param_00,param_01,param_02,param_03)
{
	var_04 = "gltacburst";
	if(issubstr(self.var_13C2E,"iw7_tacburst_mpl"))
	{
		var_04 = "gltacburst_big";
	}
	else if(issubstr(self.var_13C2E,"iw7_tacburst_mpl_epic2"))
	{
		var_04 = "gltacburst_regen";
	}

	var_05 = scripts\mp\_weapons::func_7E8C(param_00,param_01,0);
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(self,var_07))
		{
			continue;
		}

		var_08 = scripts\common\utility::func_116D7(isdefined(var_07.var_222),var_07.var_222,var_07);
		if(!scripts\mp\_weapons::func_7415(param_02,var_08) && var_08 != param_02)
		{
			continue;
		}

		var_07 notify("emp_damage",param_02,3,param_00,var_04,"MOD_EXPLOSIVE");
	}

	var_0A = scripts\mp\_utility::func_807C(param_00,param_01);
	foreach(var_0C in var_0A)
	{
		if(!isdefined(var_0C))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_0C))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(var_0C,self))
		{
			continue;
		}

		if(var_0C != param_02 && scripts\mp\_utility::func_9E05(param_02.team,var_0C))
		{
			continue;
		}

		if(!var_0C scripts\mp\killstreaks\_emp_common::func_FFC5())
		{
			param_02 scripts\mp\_damagefeedback::func_12E84("hiticonempimmune",undefined,undefined,undefined,1);
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_0C.var_9F72))
		{
			continue;
		}

		var_0C dodamage(1,param_02.origin,param_02,param_03,"MOD_EXPLOSIVE",var_04);
		var_0C scripts\mp\killstreaks\_emp_common::func_20C7(3);
		if(var_04 == "gltacburst_big")
		{
			var_0C func_20BF(self,param_02);
		}

		thread scripts\mp\_gamescore::func_11ACF(param_02,var_0C,var_04,3);
	}
}

//Function Number: 4
func_20C3(param_00,param_01,param_02)
{
	if(!scripts\mp\killstreaks\_emp_common::func_FFC5())
	{
		if(param_01 != self)
		{
			param_01 scripts\mp\_damagefeedback::func_12E84("hiticonempimmune",undefined,undefined,undefined,1);
		}

		return;
	}

	var_03 = 3;
	if(self == param_01)
	{
		var_03 = 1;
	}

	scripts\mp\killstreaks\_emp_common::func_20C7(var_03);
	thread scripts\mp\_gamescore::func_11ACF(param_01,self,scripts\common\utility::func_116D7(issubstr(param_02,"iw7_tacburst_mpl"),"gltacburst_big","gltacburst"),var_03);
}

//Function Number: 5
func_20BF(param_00,param_01)
{
	var_02 = 2;
	var_03 = 4;
	if(self == param_01)
	{
		var_02 = 0.75;
		var_03 = 1.5;
	}

	var_04 = 1 - distance(self.origin,param_00.origin) / 256;
	if(var_04 < 0)
	{
		var_04 = 0;
	}

	var_05 = var_02 + var_03 * var_04;
	var_05 = scripts\mp\perks\_perkfunctions::func_20E0(param_01,self,var_05);
	thread scripts\mp\_gamescore::func_11ACF(param_01,self,"gltacburst_big",var_05);
	param_01 notify("stun_hit");
	self notify("concussed",param_01);
	scripts\mp\_weapons::func_F7FC();
	thread scripts\mp\_weapons::func_40EA(var_05);
	self shellshock("concussion_grenade_mp",var_05);
	self.var_44ED = gettime() + var_05 * 1000;
}

//Function Number: 6
func_61B2(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("emp_rumble_loop");
	self notify("emp_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_light");
		wait(0.05);
	}
}

//Function Number: 7
func_A639(param_00)
{
	param_00 endon("death");
	self waittill("death");
	wait(5);
	param_00 delete();
}

//Function Number: 8
func_B92C(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03) || !isdefined(param_04) || !isdefined(param_01) || !isdefined(param_02))
	{
		return param_00;
	}

	if(param_04 != "gltacburst")
	{
		return param_00;
	}

	if(param_01 != param_02)
	{
		return param_00;
	}

	if(distancesquared(param_02.origin,param_03.origin) <= 16384)
	{
		return param_00;
	}

	return 0;
}
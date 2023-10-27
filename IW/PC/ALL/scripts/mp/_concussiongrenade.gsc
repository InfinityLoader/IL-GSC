/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_concussiongrenade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 561 ms
 * Timestamp: 10/27/2023 12:14:55 AM
*******************************************************************/

//Function Number: 1
func_44EE(param_00)
{
	param_00 thread func_13A20();
}

//Function Number: 2
func_13A20()
{
	var_00 = scripts\common\utility::spawn_tag_origin();
	var_00 linkto(self);
	self.var_A63A = var_00;
	thread func_A639(var_00);
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	var_01 = self.var_222;
	self waittill("explode",var_02);
	thread func_0118(var_02,512,var_01,var_00);
}

//Function Number: 3
func_0118(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_weapons::func_7E8C(param_00,param_01,0);
	foreach(var_06 in var_04)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = scripts\common\utility::func_116D7(isdefined(var_06.var_222),var_06.var_222,var_06);
		if(!scripts\mp\_weapons::func_7415(param_02,var_07) && var_07 != param_02)
		{
			continue;
		}

		var_06 notify("emp_damage",param_02,3,param_00,"emp_grenade_mp","MOD_EXPLOSIVE");
		param_02 scripts\mp\_damage::combatrecordtacticalstat("power_concussionGrenade");
	}
}

//Function Number: 4
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

	func_20BF(param_00,param_04);
	func_20C3(param_00,param_04);
	param_04 scripts\mp\_damage::combatrecordtacticalstat("power_concussionGrenade");
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

	var_04 = 1 - distance(self.origin,param_00.origin) / 512;
	if(var_04 < 0)
	{
		var_04 = 0;
	}

	var_05 = var_02 + var_03 * var_04;
	var_05 = scripts\mp\perks\_perkfunctions::func_20E0(param_01,self,var_05);
	thread scripts\mp\_gamescore::func_11ACF(param_01,self,"concussion_grenade_mp",var_05);
	param_01 notify("stun_hit");
	self notify("concussed",param_01);
	scripts\mp\_weapons::func_F7FC();
	thread scripts\mp\_weapons::func_40EA(var_05);
	self shellshock("concussion_grenade_mp",var_05);
	self.var_44ED = gettime() + var_05 * 1000;
}

//Function Number: 6
func_20C3(param_00,param_01)
{
	if(!scripts\mp\killstreaks\_emp_common::func_FFC5())
	{
		if(param_01 != self)
		{
			param_01 scripts\mp\_damagefeedback::func_12E84("hiticonempimmune",undefined,undefined,undefined,1);
		}

		return;
	}

	var_02 = 3;
	if(self == param_01)
	{
		var_02 = 1;
	}

	scripts\mp\killstreaks\_emp_common::func_20C7(var_02);
	thread scripts\mp\_gamescore::func_11ACF(param_01,self,"emp_grenade_mp",var_02);
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

	if(param_04 != "concussion_grenade_mp" && param_04 != "emp_grenade_mp")
	{
		return param_00;
	}

	if(param_01 != param_02)
	{
		return param_00;
	}

	if(distancesquared(param_02.origin,param_03.origin) <= 65536)
	{
		return param_00;
	}

	return 0;
}
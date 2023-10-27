/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_air_superiority.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 481 ms
 * Timestamp: 10/27/2023 12:28:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_B923 = [];
	var_00.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
	var_00.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
	var_00.var_93B9 = "veh_mig29_dist_loop";
	var_00.var_4464 = "compass_objpoint_airstrike_friendly";
	var_00.var_4463 = "compass_objpoint_airstrike_busy";
	var_00.var_2B3 = 4000;
	var_00.var_8863 = 20000;
	var_00.var_5715 = 4000;
	var_00.var_8D13 = 250;
	var_00.var_C23A = 3;
	var_00.var_C74F = "airstrike_mp_roll";
	var_00.var_10407 = "veh_mig29_sonic_boom";
	var_00.var_C4C6 = ::func_24D8;
	var_00.var_C52E = ::func_40F7;
	var_00.var_EC44 = "destroyed_air_superiority";
	var_00.var_3774 = "callout_destroyed_air_superiority";
	var_00.var_13523 = undefined;
	var_00.var_A640 = (-800,0,200);
	level.var_CC43["air_superiority"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("air_superiority",::func_C5BB);
	level.var_115C0["axis"] = 0;
	level.var_115C0["allies"] = 0;
}

//Function Number: 2
func_C5BB(param_00)
{
	var_01 = scripts\mp\_utility::getotherteam(self.team);
	if((level.teambased && level.var_115C0[var_01]) || !level.teambased && isdefined(level.var_1A94) && level.var_1A94 == self)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	thread func_5AB7(param_00.var_AC68,"air_superiority");
	scripts\mp\_matchdata::func_AFC9("air_superiority",self.origin);
	thread scripts\mp\_utility::func_115DE("used_air_superiority",self);
	return 1;
}

//Function Number: 3
func_5AB7(param_00,param_01)
{
	var_02 = level.var_CC43[param_01];
	var_03 = scripts\mp\killstreaks\_plane::func_8069(var_02.var_5715);
	wait(1);
	var_04 = scripts\mp\_utility::getotherteam(self.team);
	level.var_115C0[var_04] = 1;
	level.var_1A94 = self;
	func_5976(param_01,param_00,var_03.var_1157A,var_03.var_6F25,var_03.height);
	self waittill("aa_flyby_complete");
	wait(2);
	scripts\mp\_hostmigration::func_13834();
	if(isdefined(self))
	{
		func_5976(param_01,param_00,var_03.var_1157A,-1 * var_03.var_6F25,var_03.height);
		self waittill("aa_flyby_complete");
	}

	level.var_115C0[var_04] = 0;
	level.var_1A94 = undefined;
}

//Function Number: 4
func_5976(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_CC43[param_00];
	var_06 = scripts\mp\killstreaks\_plane::func_7EBE(param_02,param_03,var_05.var_8863,1,param_04,var_05.var_2B3,-0.5 * var_05.var_8863,param_00);
	level thread scripts\mp\killstreaks\_plane::func_5857(param_01,self,param_01,var_06["startPoint"] + (0,0,randomint(var_05.var_8D13)),var_06["endPoint"] + (0,0,randomint(var_05.var_8D13)),var_06["attackTime"],var_06["flyTime"],param_03,param_00);
}

//Function Number: 5
func_24D8(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self.var_222 endon("killstreak_disowned");
	level endon("game_ended");
	wait(param_02);
	var_05 = func_6CAA(self.var_222,self.team);
	var_06 = level.var_CC43[param_04];
	var_07 = var_06.var_C23A;
	for(var_08 = var_05.size - 1;var_08 >= 0 && var_07 > 0;var_08--)
	{
		var_09 = var_05[var_08];
		if(isdefined(var_09) && isalive(var_09))
		{
			func_6D58(var_09);
			var_07--;
			wait(1);
		}
	}
}

//Function Number: 6
func_40F7(param_00,param_01,param_02)
{
	param_00 notify("aa_flyby_complete");
}

//Function Number: 7
func_6CC8(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_03))
	{
		foreach(var_06 in param_03)
		{
			if([[ param_02 ]](param_00,param_01,var_06))
			{
				param_04.var_1157E[param_04.var_1157E.size] = var_06;
			}
		}
	}

	return param_04;
}

//Function Number: 8
func_6CAA(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_1157E = [];
	var_03 = undefined;
	if(level.teambased)
	{
		var_03 = ::scripts\mp\_utility::func_9FE7;
	}
	else
	{
		var_03 = ::scripts\mp\_utility::func_9FD8;
	}

	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_04 = scripts\mp\_utility::getotherteam(param_01);
	}

	func_6CC8(param_00,var_04,var_03,level.var_8D79,var_02);
	if(isdefined(level.var_AAC8))
	{
		if([[ var_03 ]](param_00,var_04,level.var_AAC8))
		{
			var_02.var_1157E[var_02.var_1157E.size] = level.var_AAC8;
		}
	}

	func_6CC8(param_00,var_04,var_03,level.var_CC46,var_02);
	func_6CC8(param_00,var_04,var_03,level.var_AD8B,var_02);
	func_6CC8(param_00,var_04,var_03,level.var_8DD3,var_02);
	return var_02.var_1157E;
}

//Function Number: 9
func_6D58(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = undefined;
	if(isdefined(self.var_222))
	{
		var_01 = self.var_222;
	}

	var_02 = 384 * anglestoforward(self.angles);
	var_03 = self gettagorigin("tag_missile_1") + var_02;
	var_04 = scripts\mp\_utility::func_1309("aamissile_projectile_mp",var_03,var_03 + var_02,var_01);
	var_04.var_131D8 = self;
	var_03 = self gettagorigin("tag_missile_2") + var_02;
	var_05 = scripts\mp\_utility::func_1309("aamissile_projectile_mp",var_03,var_03 + var_02,var_01);
	var_05.var_131D8 = self;
	var_06 = [var_04,var_05];
	param_00 notify("targeted_by_incoming_missile",var_06);
	thread func_10DC4(param_00,0.25,var_06);
}

//Function Number: 10
func_10DC4(param_00,param_01,param_02)
{
	wait(param_01);
	if(isdefined(param_00))
	{
		var_03 = undefined;
		if(param_00.model != "vehicle_av8b_harrier_jet_mp")
		{
			var_03 = param_00 gettagorigin("tag_missile_target");
		}

		if(!isdefined(var_03))
		{
			var_03 = param_00 gettagorigin("tag_body");
		}

		var_04 = var_03 - param_00.origin;
		foreach(var_06 in param_02)
		{
			if(isvalidmissile(var_06))
			{
				var_06 missile_settargetent(param_00,var_04);
				var_06 missile_setflightmodedirect();
			}
		}
	}
}

//Function Number: 11
func_52CA(param_00,param_01)
{
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",level.var_8DD3);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",level.var_AD8B);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",level.var_8D79);
	if(isdefined(level.var_AAC8))
	{
		var_02 = [];
		var_02[0] = level.var_AAC8;
		scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",var_02);
	}

	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",level.var_DF74);
	scripts\mp\killstreaks\_killstreaks::func_532A(param_00,param_01,"aamissile_projectile_mp",level.var_CC46);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_gas_airstrike.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 569 ms
 * Timestamp: 10/27/2023 12:28:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_B923 = [];
	var_00.var_B923["allies"] = "vehicle_mig29_desert";
	var_00.var_B923["axis"] = "vehicle_mig29_desert";
	var_00.var_93B9 = "veh_mig29_dist_loop";
	var_00.var_4464 = "compass_objpoint_airstrike_friendly";
	var_00.var_4463 = "compass_objpoint_airstrike_busy";
	var_00.var_2B3 = 5000;
	var_00.var_8863 = 15000;
	var_00.var_8D13 = 500;
	var_00.var_C74F = "airstrike_mp_roll";
	var_00.var_C4C6 = ::func_5D24;
	var_00.var_C52E = ::func_40F7;
	var_00.var_3ED0 = 1;
	var_00.var_F1CA = "KS_hqr_airstrike";
	var_00.var_93BA = "KS_ast_inbound";
	var_00.var_2C5A = "projectile_cbu97_clusterbomb";
	var_00.var_C21A = 3;
	var_00.var_5703 = 350;
	var_00.var_5FEF = 200;
	var_00.var_5FEA = 120;
	var_00.var_5FF4 = loadfx("vfx/core/smktrail/poisonous_gas_linger_medium_thick_killer_instant");
	var_00.var_5FEE = 0.25;
	var_00.var_5FED = 0.5;
	var_00.var_5FEC = 13;
	var_00.var_5FE7 = 1;
	var_00.var_5FE8 = 10;
	var_00.var_C263 = "gas_strike_mp";
	var_00.var_A640 = (0,0,60);
	level.var_CC43["gas_airstrike"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("gas_airstrike",::func_C5BB);
}

//Function Number: 2
func_C5BB(param_00,param_01)
{
	var_02 = scripts\mp\_utility::getotherteam(self.team);
	if(isdefined(level.var_C22F))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	var_03 = scripts\mp\killstreaks\_plane::func_F1AA(param_00,"gas_airstrike",::func_5AB7);
	return isdefined(var_03) && var_03;
}

//Function Number: 3
func_5AB7(param_00,param_01,param_02,param_03)
{
	level.var_C22F = 0;
	wait(1);
	var_04 = scripts\mp\killstreaks\_plane::func_806A();
	var_05 = anglestoforward((0,param_02,0));
	func_5976(param_03,param_00,param_01,var_05,var_04);
	self waittill("gas_airstrike_flyby_complete");
}

//Function Number: 4
func_5976(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_CC43[param_00];
	var_06 = scripts\mp\killstreaks\_plane::func_7EBE(param_02,param_03,var_05.var_8863,1,param_04,var_05.var_2B3,0,param_00);
	level thread scripts\mp\killstreaks\_plane::func_5857(param_01,self,param_01,var_06["startPoint"] + (0,0,randomint(var_05.var_8D13)),var_06["endPoint"] + (0,0,randomint(var_05.var_8D13)),var_06["attackTime"],var_06["flyTime"],param_03,param_00);
}

//Function Number: 5
func_40F7(param_00,param_01,param_02)
{
	param_00 notify("gas_airstrike_flyby_complete");
}

//Function Number: 6
func_5D24(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	wait(param_02);
	var_05 = level.var_CC43[param_04];
	var_06 = var_05.var_C21A;
	var_07 = var_05.var_5703 / var_05.var_2B3;
	while(var_06 > 0)
	{
		thread func_5D35(param_03,param_04);
		var_06--;
		wait(var_07);
	}
}

//Function Number: 7
func_5D35(param_00,param_01)
{
	level.var_C22F++;
	var_02 = self;
	var_03 = level.var_CC43[param_01];
	var_04 = anglestoforward(var_02.angles);
	var_05 = func_10836(var_03.var_2C5A,var_02.origin,var_02.angles);
	var_05 movegravity(var_04 * var_03.var_2B3 / 1.5,3);
	var_06 = spawn("script_model",var_05.origin);
	var_06 setmodel("tag_origin");
	var_06.origin = var_05.origin;
	var_06.angles = var_05.angles;
	var_05 setmodel("tag_origin");
	wait(0.1);
	var_07 = var_06.origin;
	var_08 = var_06.angles;
	if(level.splitscreen)
	{
		playfxontag(level.var_1AFD,var_06,"tag_origin");
	}
	else
	{
		playfxontag(level.var_1AF7,var_06,"tag_origin");
	}

	wait(1);
	var_09 = bullettrace(var_06.origin,var_06.origin + (0,0,-1000000),0,undefined);
	var_0A = var_09["position"];
	var_05 func_C4CD(param_00,var_0A,param_01);
	var_06 delete();
	var_05 delete();
	level.var_C22F--;
	if(level.var_C22F == 0)
	{
		level.var_C22F = undefined;
	}
}

//Function Number: 8
func_10836(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01);
	var_03.angles = param_02;
	var_03 setmodel(param_00);
	return var_03;
}

//Function Number: 9
func_C4CD(param_00,param_01,param_02)
{
	var_03 = level.var_CC43[param_02];
	var_04 = spawn("trigger_radius",param_01,0,var_03.var_5FEF,var_03.var_5FEA);
	var_04.var_222 = param_00;
	var_05 = var_03.var_5FEF;
	var_06 = spawnfx(var_03.var_5FF4,param_01);
	triggerfx(var_06);
	wait(randomfloatrange(var_03.var_5FEE,var_03.var_5FED));
	var_07 = var_03.var_5FEC;
	var_08 = spawn("script_model",param_01 + var_03.var_A640);
	var_08 linkto(var_04);
	self.var_A63A = var_08;
	while(var_07 > 0)
	{
		foreach(var_0A in level.var_3CB5)
		{
			var_0A func_20CC(param_00,param_01,var_04,self,var_03.var_5FE8);
		}

		wait(var_03.var_5FE7);
		var_07 = var_07 - var_03.var_5FE7;
	}

	self.var_A63A delete();
	var_04 delete();
	var_06 delete();
}

//Function Number: 10
func_20CC(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 scripts\mp\_utility::func_9DD6(self) && isalive(self) && self istouching(param_02))
	{
		param_03 radiusdamage(self.origin,1,param_04,param_04,param_00,"MOD_RIFLE_BULLET","gas_strike_mp");
		if(!scripts\mp\_utility::func_9FC6())
		{
			var_05 = scripts\mp\perks\_perkfunctions::func_20E0(param_00,self,2);
			self shellshock("default",var_05);
		}
	}
}
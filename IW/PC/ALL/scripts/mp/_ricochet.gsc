/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_ricochet.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 478 ms
 * Timestamp: 10/27/2023 12:21:27 AM
*******************************************************************/

//Function Number: 1
func_E4E3()
{
	level.var_E4DF = [];
	level._effect["proto_ricochet_temp"] = loadfx("vfx/old/misc/proto_ricochet_temp");
	level._effect["proto_ricochet_shot_temp"] = loadfx("vfx/old/misc/proto_ricochet_shot_temp");
	level.var_E4DF["proto_ricochet_device_mp"] = spawnstruct();
	level.var_E4DF["proto_ricochet_device_mp"].var_C739 = 60;
	level.var_E4DF["proto_ricochet_device_mp"].var_B9DC = ::func_E4E5;
	level.var_E4DF["proto_ricochet_device_mp"].model = "prop_mp_ricochet_temp";
	level.var_E4DF["proto_ricochet_device_mp"].var_7542 = "proto_ricochet_temp";
}

//Function Number: 2
func_E4E9(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 waittill("missile_stuck",var_01);
	var_02 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] + level.var_E4DF[param_00.var_13C2E].var_C739);
	var_03 = spawn("script_model",var_02);
	var_03 setmodel(level.var_E4DF[param_00.var_13C2E].model);
	var_03.angles = param_00.angles;
	var_03.team = self.team;
	var_03.var_222 = self;
	var_03.var_15F = param_00;
	var_04 = (var_02[0],var_02[1],var_02[2] + 12);
	var_03.var_7542 = spawnfx(scripts\common\utility::getfx(level.var_E4DF[param_00.var_13C2E].var_7542),var_04);
	triggerfx(var_03.var_7542);
	var_05 = 16;
	var_06 = anglestoup(var_03.angles);
	var_06 = var_05 * var_06;
	var_07 = var_03.origin + var_06;
	var_03.trigger = spawn("script_origin",var_07);
	var_03.trigger linkto(var_03);
	var_03 setcandamage(1);
	var_03 thread func_E4E0(self);
	var_03 thread [[ level.var_E4DF[param_00.var_13C2E].var_B9DC ]](self);
	var_03 method_831F(self);
}

//Function Number: 3
func_E4E8()
{
	if(isdefined(self.var_15F))
	{
		self.var_15F delete();
	}

	if(isdefined(self.var_7542))
	{
		self.var_7542 delete();
	}

	self delete();
	self notify("death");
}

//Function Number: 4
func_E4E7()
{
	self endon("death");
	while(getdvarint("scr_ric_debug",0) == 1)
	{
		wait(1);
	}

	wait(6);
	func_E4E8();
}

//Function Number: 5
func_E4E0(param_00)
{
	scripts\mp\_damage::func_B9C6(100,"trophy",::func_E4E2,::func_E4E4,0);
}

//Function Number: 6
func_E4E4(param_00,param_01,param_02,param_03,param_04)
{
	return 0;
}

//Function Number: 7
func_E4E2(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive");
}

//Function Number: 8
func_E4E5(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	thread func_E4E7();
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		var_0B = func_E4E1(var_04,var_03);
		if(isdefined(var_0B))
		{
			var_0C = var_04 + var_0B * 5000;
			if(getdvarint("scr_ric_debug",0) == 1)
			{
			}

			if(getdvarint("scr_ric_debug",0) != 1)
			{
				scripts\mp\_utility::func_1309(var_0A,var_04,var_0C,param_00);
			}

			var_0D = scripts\common\utility::getfx("proto_ricochet_shot_temp");
			playfx(var_0D,var_04,var_0B * -1,(0,0,1));
		}
	}
}

//Function Number: 9
func_E4E1(param_00,param_01)
{
	var_02 = (param_01[0],param_01[1],0);
	var_03 = getdvarfloat("scr_ric_spread",7);
	var_04 = undefined;
	var_05 = -15536;
	foreach(var_07 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_07))
		{
			continue;
		}

		if(var_07.team == self.team)
		{
			continue;
		}

		var_08 = (var_07.origin[0],var_07.origin[1],var_07.origin[2] + 36);
		var_09 = var_08 - param_00;
		var_0A = distance(var_07.origin,param_00);
		var_09 = var_09 * 1 / var_0A;
		var_0B = vectordot(var_09,param_01);
		if(abs(var_0B) < 0.707)
		{
			if(var_0A < 500)
			{
				if(var_0A < var_05)
				{
					var_04 = var_08;
					var_05 = var_0A;
				}
			}
		}
	}

	if(isdefined(var_04))
	{
		var_09 = var_04 - param_00;
		var_09 = var_09 * 1 / var_05;
		var_0D = randomfloatrange(-180,180);
		var_0E = vectorcross((0,0,1),var_09);
		var_0F = vectorcross(var_09,var_0E);
		var_10 = sin(var_0D);
		var_11 = cos(var_0D);
		var_12 = randomfloatrange(var_03 * -1,var_03);
		var_12 = tan(var_12);
		var_13 = var_0E * var_11 + var_0F * var_10 * var_12 + var_09;
		return var_13;
	}
}
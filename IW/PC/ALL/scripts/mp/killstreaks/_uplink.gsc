/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_uplink.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1463 ms
 * Timestamp: 10/27/2023 12:29:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_12F81 = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("uplink",::func_1290C);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("uplink_support",::func_1290C);
	level.var_768F = 0;
	level.var_4418 = [];
	level.var_4418["giveComExpBenefits"] = ::func_835B;
	level.var_4418["removeComExpBenefits"] = ::func_E0DF;
	level.var_4418["getRadarStrengthForTeam"] = ::func_80A8;
	level.var_4418["getRadarStrengthForPlayer"] = ::func_80A7;
	level._effect["uav_beam"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_energy_beam");
	unblockteamradar("axis");
	unblockteamradar("allies");
	level thread func_12F82();
	level thread func_12F83();
	if(level.var_768F)
	{
		level thread func_C799();
	}

	var_00 = spawnstruct();
	var_00.var_110EA = "uplink";
	var_00.var_39B = "ims_projectile_mp";
	var_00.var_B91A = "mp_satcom";
	var_00.var_B924 = "mp_satcom_obj";
	var_00.var_B925 = "mp_satcom_obj_red";
	var_00.var_B91C = "mp_satcom_bombsquad";
	var_00.var_17B = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
	var_00.var_CC28 = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
	var_00.var_38E3 = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
	var_00.var_8C79 = 42;
	var_00.var_10A38 = "used_uplink";
	var_00.var_AC71 = 30;
	var_00.maxhealth = 340;
	var_00.var_1C9D = 1;
	var_00.var_1C8F = 1;
	var_00.var_4D4A = "trophy";
	var_00.var_EC44 = "destroyed_uplink";
	var_00.var_52DA = "satcom_destroyed";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_CC23 = 16;
	var_00.var_C56C = ::func_C56B;
	var_00.var_C4D6 = ::func_C4D5;
	var_00.var_CC15 = "mp_killstreak_satcom_deploy";
	var_00.var_1673 = "mp_killstreak_satcom_loop";
	var_00.var_C55B = ::func_12F80;
	var_00.var_C4EB = ::func_C4EA;
	var_00.var_C4F3 = ::func_C4F2;
	var_00.var_4E74 = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
	level.var_CC09["uplink"] = var_00;
	level.var_CC09["uplink_support"] = var_00;
}

//Function Number: 2
func_C799()
{
	if(!level.teambased)
	{
		return;
	}

	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 thread func_1383D();
	}
}

//Function Number: 3
func_1383D()
{
	self waittill("spawned_player");
	foreach(var_01 in level.players)
	{
		if(var_01.team == "spectator")
		{
			continue;
		}

		var_02 = scripts\mp\_utility::func_C795(var_01,"cyan",var_01.team,0,0,"killstreak");
	}
}

//Function Number: 4
func_12F82()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("update_uplink");
		level childthread func_12E5B();
	}
}

//Function Number: 5
func_12E5B()
{
	self notify("updateAllUplinkThreads");
	self endon("updateAllUplinkThreads");
	level childthread func_4419();
	if(level.teambased)
	{
		level childthread func_12F41("axis");
		level childthread func_12F41("allies");
	}
	else
	{
		level childthread func_12EF4();
	}

	level childthread func_12E79();
}

//Function Number: 6
func_4419()
{
	var_00 = [];
	if(!level.teambased)
	{
		level waittill("radar_status_change_players");
	}
	else
	{
		while(var_00.size < 2)
		{
			level waittill("radar_status_change",var_01);
			var_00[var_00.size] = var_01;
		}
	}

	level notify("start_com_exp");
}

//Function Number: 7
func_12F41(param_00)
{
	var_01 = func_80A8(param_00);
	var_02 = var_01 == 1;
	var_03 = var_01 >= 2;
	var_04 = var_01 >= 3;
	var_05 = var_01 >= 4;
	if(var_03)
	{
		unblockteamradar(param_00);
	}

	if(var_04)
	{
		level.var_254[param_00] = "fast_radar";
	}
	else
	{
		level.var_254[param_00] = "normal_radar";
	}

	foreach(var_07 in level.var_C928)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(var_07.team != param_00)
		{
			continue;
		}

		var_07.var_FFC7 = var_02;
		var_07 method_82DF(var_02);
		var_07.var_254 = level.var_254[var_07.team];
		var_07.var_255 = var_05;
		var_07 func_12F09(param_00);
		wait(0.05);
	}

	setteamradar(param_00,var_03);
	level notify("radar_status_change",param_00);
}

//Function Number: 8
func_12EF4()
{
	foreach(var_01 in level.var_C928)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = func_80A7(var_01);
		func_F7F7(var_01,var_02);
		var_01 func_12F09();
		wait(0.05);
	}

	level notify("radar_status_change_players");
}

//Function Number: 9
func_12E79()
{
	level waittill("start_com_exp");
	foreach(var_01 in level.var_C928)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 func_835B();
		wait(0.05);
	}
}

//Function Number: 10
func_835B()
{
	if(scripts\mp\_utility::_hasperk("specialty_comexp"))
	{
		var_00 = func_80A6(self);
		func_F7F7(self,var_00);
		func_12F09();
	}
}

//Function Number: 11
func_12F09(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		var_01 = func_80A8(param_00);
	}
	else
	{
		var_01 = func_80A7(self);
	}

	if(scripts\mp\_utility::_hasperk("specialty_comexp"))
	{
		var_01 = func_80A6(self);
	}

	if(var_01 > 0)
	{
		self setclientomnvar("ui_satcom_active",1);
		return;
	}

	self setclientomnvar("ui_satcom_active",0);
}

//Function Number: 12
func_E0DF()
{
	self.var_FFC7 = 0;
	self method_82DF(0);
	self.var_255 = 0;
	self.var_254 = "normal_radar";
	self.var_16E = 0;
	self.var_194 = 0;
}

//Function Number: 13
func_F7F7(param_00,param_01)
{
	var_02 = param_01 == 1;
	var_03 = param_01 >= 2;
	var_04 = param_01 >= 3;
	var_05 = param_01 >= 4;
	param_00.var_FFC7 = var_02;
	param_00 method_82DF(var_02);
	param_00.var_255 = var_05;
	param_00.var_254 = "normal_radar";
	param_00.var_16E = var_03;
	param_00.var_194 = 0;
	if(var_04)
	{
		param_00.var_254 = "fast_radar";
	}
}

//Function Number: 14
func_1290C(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_placeable::func_838E(param_01,1);
	if(var_02)
	{
		scripts\mp\_matchdata::func_AFC9("uplink",self.origin);
	}

	self.var_9D81 = undefined;
	return var_02;
}

//Function Number: 15
func_C4D5(param_00)
{
	var_01 = self getentitynumber();
	if(isdefined(level.var_12F81[var_01]))
	{
		func_11099();
	}
}

//Function Number: 16
func_13A7B()
{
	self waittill("satComTimedOut");
	foreach(var_01 in level.var_C928)
	{
		if(isdefined(var_01.var_2A3B))
		{
			var_01.var_2A3B delete();
		}
	}
}

//Function Number: 17
func_12AEF()
{
	self endon("satComTimedOut");
	var_00 = 3;
	var_01 = 3;
	var_02 = 0.5;
	thread func_13A7B();
	for(;;)
	{
		foreach(var_04 in level.var_C928)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(level.teambased && var_04.team == self.team)
			{
				continue;
			}

			if(var_04 scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_04))
			{
				if(isdefined(var_04.var_2A3B))
				{
					var_04.var_2A3B delete();
				}

				continue;
			}

			if(isdefined(var_04.var_12AF1))
			{
				if(isdefined(var_04.var_2A3B))
				{
					var_04.var_2A3B delete();
				}

				var_04.var_12AF1.origin = var_04.origin;
				var_04.var_12AF2.origin = var_04.origin;
				var_04.var_12AF2.alpha = 0.95;
				var_04.var_12AF2 thread func_6AB8(var_01,var_02);
			}
			else
			{
				var_05 = spawn("script_model",var_04.origin);
				var_05 setmodel("tag_origin");
				var_05.var_222 = var_04;
				var_04.var_12AF1 = var_05;
				var_04.var_12AF2 = var_05 scripts\mp\_entityheadicons::func_F73D(self.team,"headicon_enemy",(0,0,32),2,2,1,0.01,0,1,1,0);
				var_04.var_12AF2.alpha = 0.95;
				var_04.var_12AF2 thread func_6AB8(var_01,var_02);
			}

			var_04.var_2A3B = function_0173(scripts\common\utility::getfx("uav_beam"),var_00,var_04.origin);
		}

		wait(var_01);
	}
}

//Function Number: 18
func_B37E()
{
	var_00 = 3;
	var_01 = 3;
	var_02 = 0.5;
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_12AF1))
	{
		if(isdefined(self.var_2A3B))
		{
			self.var_2A3B delete();
		}

		self.var_12AF1.origin = self.origin;
		self.var_12AF2.origin = self.origin;
		self.var_12AF2.alpha = 0.95;
		self.var_12AF2 thread func_6AB8(var_01,var_02);
	}
	else
	{
		var_03 = spawn("script_model",self.origin);
		var_03 setmodel("tag_origin");
		var_03.var_222 = self;
		self.var_12AF1 = var_03;
		self.var_12AF2 = var_03 scripts\mp\_entityheadicons::func_F73D(scripts\mp\_utility::getotherteam(self.team),"headicon_enemy",(0,0,32),14,14,1,0.01,0,1,1,0);
		self.var_12AF2.alpha = 0.95;
		self.var_12AF2 thread func_6AB8(var_01,var_02);
	}

	self.var_2A3B = function_0173(scripts\common\utility::getfx("uav_beam"),var_00,self.origin);
	wait(var_01);
	if(isdefined(self.var_2A3B))
	{
		self.var_2A3B delete();
	}
}

//Function Number: 19
func_6AB8(param_00,param_01)
{
	self notify("fadeOut");
	self endon("fadeOut");
	var_02 = param_00 - param_01;
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self fadeovertime(var_02);
	self.alpha = 0;
}

//Function Number: 20
func_C56B(param_00)
{
	var_01 = level.var_CC09[param_00];
	self.var_222 notify("uplink_deployed");
	self setmodel(var_01.var_B91A);
	self.var_933C = 0;
	self method_831F(self.var_222);
	scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground",self.var_222);
	self.var_451C = var_01;
	if(level.var_768F)
	{
		thread func_12AEF();
	}

	func_10E04(1);
	thread func_13A10();
}

//Function Number: 21
func_10E04(param_00)
{
	func_1868(self);
	self playloopsound(self.var_451C.var_1673);
}

//Function Number: 22
func_11099()
{
	scripts\mp\_weapons::func_11061();
	self method_8292();
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 method_8292();
	}

	func_E188(self);
	self stoploopsound();
}

//Function Number: 23
func_C4F2(param_00,param_01,param_02,param_03)
{
	param_01 notify("destroyed_equipment");
}

//Function Number: 24
func_C4EA(param_00,param_01,param_02,param_03)
{
	scripts\mp\_weapons::func_11061();
	scripts\mp\_weapons::func_66A6();
	func_E188(self);
	self method_8292();
	if(!self.var_933C)
	{
		wait(3);
	}

	scripts\mp\_weapons::func_66A8();
}

//Function Number: 25
func_1868(param_00)
{
	var_01 = param_00 getentitynumber();
	level.var_12F81[var_01] = param_00;
	level notify("update_uplink");
}

//Function Number: 26
func_E188(param_00)
{
	param_00 notify("satComTimedOut");
	var_01 = param_00 getentitynumber();
	level.var_12F81[var_01] = undefined;
	level notify("update_uplink");
}

//Function Number: 27
func_80A8(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_12F81)
	{
		if(isdefined(var_03) && var_03.team == param_00)
		{
			var_01++;
		}
	}

	if(var_01 == 0 && isdefined(level.var_8DD7) && level.var_8DD7.team == param_00)
	{
		var_01++;
	}

	if(var_01 == 1)
	{
		var_01 = 2;
	}

	return clamp(var_01,0,4);
}

//Function Number: 28
func_80A7(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_12F81)
	{
		if(isdefined(var_03))
		{
			if(isdefined(var_03.var_222))
			{
				if(var_03.var_222.var_86BD == param_00.var_86BD)
				{
					var_01++;
				}

				continue;
			}

			var_04 = var_03 getentitynumber();
			level.var_12F81[var_04] = undefined;
		}
	}

	if(!level.teambased && var_01 > 0)
	{
		var_01++;
	}

	return clamp(var_01,0,4);
}

//Function Number: 29
func_80A6(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_12F81)
	{
		if(isdefined(var_03))
		{
			var_01++;
		}
	}

	if(!level.teambased && var_01 > 0)
	{
		var_01++;
	}

	return clamp(var_01,0,4);
}

//Function Number: 30
func_12F80(param_00)
{
	self.var_933C = 1;
	self notify("death");
}

//Function Number: 31
func_13A10()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		scripts\mp\_weapons::func_66A9();
		func_11099();
		wait(var_01);
		func_10E04(0);
	}
}

//Function Number: 32
func_12F83()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_01 = isdefined(var_00.var_FFC7) && var_00.var_FFC7;
		var_00 method_82DF(var_01);
	}
}
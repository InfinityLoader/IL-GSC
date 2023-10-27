/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_fighter_mp.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 403 ms
 * Timestamp: 10/27/2023 3:20:29 AM
*******************************************************************/

//Function Number: 1
func_00F9(param_00,param_01,param_02)
{
	func_764D();
}

//Function Number: 2
func_764D()
{
	level.var_611["p47_dmg_impact"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_impacts_lrg");
	level.var_611["p47_dmg_impact_notrail"] = loadfx("vfx/vehicle/fighter_dmg_impact_notrail");
	level.var_611["p47_dmg_light"] = loadfx("vfx/vehicle/p47_dmg_light");
	level.var_611["p47_dmg_heavy"] = loadfx("vfx/vehicle/p47_dmg_heavy");
	level.var_611["p47_contrail"] = loadfx("vfx/vehicle/p47_contrail");
	level.var_611["p47_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_p47_wing_evap");
	level.var_611["p47_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
	level.var_611["bf109_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_wing_evap");
	level.var_611["bf109_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
	level.var_611["bf109_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");
	if(getdvarint("fighter_firing_mode") == 1)
	{
		level.var_611["p47_muzzle01"] = loadfx("vfx/vehicle/p47_muzzle01");
		level.var_611["p47_muzzle02"] = loadfx("vfx/vehicle/p47_muzzle02");
	}

	level.var_611["p47_death"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
	level.var_611["20mm_metal_impact_1"] = loadfx("vfx/weaponimpact/20mm_metal_impact_1");
	level.var_611["p47_dmg_impact_ext_vel"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_spark_impact_rnr");
	level.var_611["p47_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");
	if(getdvarint("fighter_firing_mode") == 1)
	{
		level.var_611["p47_muzzle01_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle01_ext_vel");
		level.var_611["p47_muzzle02_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle02_ext_vel");
	}
}

//Function Number: 3
fighterinitmg(param_00)
{
	var_01 = 0;
	if(isdefined(self.var_81FD))
	{
		var_01 = self.var_81FD;
	}

	self.var_615C = [];
	foreach(var_03 in param_00)
	{
		var_04 = self gettagangles(var_03.var_95A6);
		var_05 = self gettagorigin(var_03.var_95A6);
		var_06 = combineangles(var_04,(0,-1 * var_01,0));
		var_07 = undefined;
		if(isdefined(var_03.var_6A1B))
		{
			var_07 = var_05 + rotatevector(var_03.var_6A1B,var_04);
		}
		else
		{
			var_07 = var_05;
		}

		var_08 = spawnturret(var_03.var_231A,var_07,var_03.var_5135);
		var_08.maxhealth = var_03.var_5135;
		var_08.var_1D = var_06;
		var_08 method_808C();
		if(isdefined(var_03.var_6A1B))
		{
			var_08 linkto(self,var_03.var_95A6,var_03.var_6A1B,(0,-1 * var_01,0));
		}
		else
		{
			var_08 linkto(self,var_03.var_95A6,(0,0,0),(0,-1 * var_01,0));
		}

		var_08 setmodel(var_03.var_106);
		var_08.var_5847 = 1;
		var_08.var_6DB3 = self;
		var_08 makeusable();
		if(isdefined(var_03.var_FC))
		{
			var_08.var_FC = var_03.var_FC;
		}

		self.var_615C[self.var_615C.size] = var_08;
	}
}

//Function Number: 4
buildfighterturret(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_A372))
	{
		level.var_A372 = [];
	}

	var_05 = level.var_A635;
	var_06 = spawnstruct();
	var_06.var_231A = param_00;
	var_06.var_5135 = param_01;
	var_06.var_95A6 = param_02;
	var_06.var_106 = param_03;
	if(isdefined(param_04) && param_04 == 1)
	{
		var_06.var_9B81 = 1;
	}
	else
	{
		var_06.var_9B81 = 0;
	}

	return var_06;
}

//Function Number: 5
func_8A4D(param_00)
{
	var_01 = [];
	var_02 = buildfighterturret("misc_turret",param_00,"TAG_TURRET_ATTACH_LEFT","usa_fighter_thunderbolt_turret",1);
	var_01[var_01.size] = var_02;
	var_02 = buildfighterturret("misc_turret",param_00,"TAG_TURRET_ATTACH_RIGHT","usa_fighter_thunderbolt_turret",1);
	var_01[var_01.size] = var_02;
	fighterinitmg(var_01);
}

//Function Number: 6
destroyturrets()
{
	foreach(var_01 in self.var_615C)
	{
		var_01 makeunusable();
		var_01 delete();
	}

	self.var_615C = undefined;
}

//Function Number: 7
deathcleanup()
{
	func_36B3();
	func_941A();
	if(0)
	{
		func_93FF();
	}
}

//Function Number: 8
func_51FB(param_00)
{
	func_8A4D(param_00);
	self.var_2A89 = "tag_trail_fx";
	self.var_9BDD = "tag_trail_fx";
	if(self method_8445("tag_trail_fx") < 0)
	{
		self.var_2A89 = "tag_origin";
	}

	if(self method_8445("tag_trail_fx") < 0)
	{
		self.var_9BDD = "tag_origin";
	}

	if(0)
	{
		thread func_721B();
	}

	thread func_3F3B();
	thread func_3F5D();
	thread fx_speed_handler();
	thread func_6DB8();
}

//Function Number: 9
spawn_tag_origin_internal()
{
	if(isdefined(level.var_5FEB))
	{
		var_00 = spawn("script_model",level.var_5FEB);
	}
	else
	{
		var_00 = spawn("script_model",(0,0,0));
	}

	var_00 setmodel("tag_origin");
	if(isdefined(self.var_116))
	{
		var_00.var_116 = self.var_116;
	}

	if(isdefined(self.var_1D))
	{
		var_00.var_1D = self.var_1D;
	}

	return var_00;
}

//Function Number: 10
func_6DB8()
{
	self endon("death");
	var_00 = self method_8251();
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(self.var_29B1))
	{
		self.var_29B1 = [];
		thread func_6DB7();
	}

	var_01 = 0;
	var_02 = common_scripts\utility::func_44F5("20mm_metal_impact_1");
	var_03 = -1;
	var_04 = 3;
	for(;;)
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_09);
		if(!isdefined(var_08))
		{
			continue;
		}

		if(isdefined(var_06) && var_06 == self)
		{
			continue;
		}

		maps\mp\_audio_submixes::func_7FFA("raid_hit_air_dmg_plr",var_08,undefined,undefined,undefined,undefined,[var_00]);
		var_0A = level.var_744A;
		var_0A = common_scripts\utility::func_F93(var_0A,var_00);
		if(var_0A.size > 0)
		{
			maps\mp\_audio_submixes::func_7FFA("raid_hit_air_dmg_npc",var_08,undefined,undefined,undefined,undefined,var_0A);
		}

		var_01 = 1;
		var_02 = common_scripts\utility::func_44F5("20mm_metal_impact_1");
		var_03 = 1.5;
		var_04 = 9;
		if(self.var_29B1.size < var_04)
		{
			var_0B = spawn_tag_origin_internal();
			var_0B.var_3F2F = var_02;
			var_0B.var_116 = var_08;
			var_0B.var_1D = self gettagangles(self.var_9BDD);
			var_0B linkto(self,self.var_9BDD);
			self.var_29B1[self.var_29B1.size] = var_0B;
			playfxontag(var_0B.var_3F2F,var_0B,"tag_origin");
			if(var_03 > 0)
			{
				thread func_6DB9(var_03,var_0B);
			}
		}
	}
}

//Function Number: 11
func_6DB7()
{
	self waittill("death");
	if(isdefined(self.var_29B1))
	{
		foreach(var_01 in self.var_29B1)
		{
			if(isdefined(var_01))
			{
				stopfxontag(var_01.var_3F2F,var_01,"tag_origin");
				var_01 delete();
			}
		}

		self.var_29B1 = undefined;
	}
}

//Function Number: 12
func_6DB9(param_00,param_01)
{
	wait(param_00);
	if(isdefined(param_01) && isdefined(self) && isdefined(self.var_29B1))
	{
		stopfxontag(param_01.var_3F2F,param_01,"tag_origin");
		self.var_29B1 = common_scripts\utility::func_F93(self.var_29B1,param_01);
	}

	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 13
func_721B()
{
	self endon("death");
	self endon("stop_engineeffects");
	common_scripts\utility::func_3799("engineeffects");
	common_scripts\utility::func_379A("engineeffects");
	var_00 = undefined;
	if(self.var_1C8 == "usa_fighter_thunderbolt_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("p47_exhaust");
	}
	else if(self.var_1C8 == "ger_fighter_bf109_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("bf109_exhaust");
	}

	if(isdefined(var_00))
	{
		for(;;)
		{
			common_scripts\utility::func_379C("engineeffects");
			playfxontag(var_00,self,self.var_9BDD);
			common_scripts\utility::func_37A1("engineeffects");
			stopfxontag(var_00,self,self.var_9BDD);
		}
	}
}

//Function Number: 14
func_93FF()
{
	common_scripts\utility::func_3796("engineeffects");
}

//Function Number: 15
func_720A()
{
	var_00 = undefined;
	if(self.var_1C8 == "usa_fighter_thunderbolt_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("p47_contrail_ext_vel");
	}
	else if(self.var_1C8 == "ger_fighter_bf109_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("bf109_contrail_ext_vel");
	}

	if(isdefined(var_00))
	{
		playfxontag(var_00,self,self.var_9BDD);
	}
}

//Function Number: 16
func_93FB()
{
	var_00 = undefined;
	if(self.var_1C8 == "usa_fighter_thunderbolt_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("p47_contrail_ext_vel");
	}
	else if(self.var_1C8 == "ger_fighter_bf109_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("bf109_contrail_ext_vel");
	}

	if(isdefined(var_00))
	{
		stopfxontag(var_00,self,self.var_9BDD);
	}
}

//Function Number: 17
func_36B3()
{
	self notify("end_contrails");
	self endon("death");
	func_93FB();
}

//Function Number: 18
func_74EE()
{
	var_00 = undefined;
	if(self.var_1C8 == "usa_fighter_thunderbolt_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("p47_wing_evap");
	}
	else if(self.var_1C8 == "ger_fighter_bf109_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("bf109_wing_evap");
	}

	if(isdefined(var_00))
	{
		playfxontag(var_00,self,self.var_9BDD);
	}
}

//Function Number: 19
func_941A()
{
	var_00 = undefined;
	if(self.var_1C8 == "usa_fighter_thunderbolt_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("p47_wing_evap");
	}
	else if(self.var_1C8 == "ger_fighter_bf109_player_mp")
	{
		var_00 = common_scripts\utility::func_44F5("bf109_wing_evap");
	}

	if(isdefined(var_00))
	{
		stopfxontag(var_00,self,self.var_9BDD);
	}
}

//Function Number: 20
func_36EF()
{
	self notify("end_wing_evap");
	self endon("death");
	wait 0.05;
	func_941A();
}

//Function Number: 21
func_3F3B()
{
	level endon("death");
	self endon("end_contrails");
	self endon("death");
	var_00 = 0;
	var_01 = 15;
	var_02 = 25;
	while(isdefined(self))
	{
		var_03 = self.var_1D;
		var_04 = var_03[0];
		var_05 = var_03[2];
		var_06 = 0;
		if((var_05 > var_01 && var_05 < 360 - var_01) || var_05 < -1 * var_01 && var_05 > -1 * 360 - var_01)
		{
			var_06 = 1;
		}

		if((var_04 > var_02 && var_04 < 360 - var_02) || var_04 < -1 * var_02 && var_04 > -1 * 360 - var_02)
		{
			var_06 = 1;
		}

		if(var_06 && !var_00)
		{
			func_720A();
			var_00 = 1;
			continue;
		}

		if(!var_06 && var_00)
		{
			func_93FB();
			var_00 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 22
fx_speed_handler()
{
	level endon("death");
	self endon("death");
	var_00 = self method_8251();
	if(!isdefined(var_00))
	{
		return;
	}

	if(isbot(var_00) || function_01EF(var_00))
	{
		return;
	}

	var_01 = 0;
	while(isdefined(self))
	{
		var_02 = var_00 getnormalizedmovement()[0];
		if(var_02 >= 0.5)
		{
			if(!var_01)
			{
				playfxontagforclients(level.var_611["mp_raid_bomber_speedup"],self,self.var_9BDD,var_00);
				var_01 = 1;
			}

			continue;
		}

		if(var_01)
		{
			function_0294(level.var_611["mp_raid_bomber_speedup"],self,self.var_9BDD,var_00);
			var_01 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 23
func_3F5D()
{
	level endon("death");
	self endon("end_wing_evap");
	self endon("death");
	var_00 = 0;
	var_01 = 30;
	var_02 = 40;
	while(isdefined(self))
	{
		var_03 = self.var_1D;
		var_04 = var_03[2];
		var_05 = 0;
		if((var_04 > var_01 && var_04 < 360 - var_01) || var_04 < -1 * var_01 && var_04 > -1 * 360 - var_01)
		{
			var_05 = 1;
		}

		if(var_05 && !var_00)
		{
			func_74EE();
			var_00 = 1;
			continue;
		}

		if(!var_05 && var_00)
		{
			func_941A();
			var_00 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 24
func_996C()
{
	self endon("death");
	for(;;)
	{
		self waittill("veh_collision",var_00,var_01,var_02);
		if(!isdefined(var_02) || !isplayer(var_02))
		{
			if(isdefined(self.var_6703) && !self.var_6703)
			{
				self notify("veh_collision_except_player");
			}

			continue;
		}

		var_03 = 0;
	}
}
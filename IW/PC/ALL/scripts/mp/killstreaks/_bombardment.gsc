/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_bombardment.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 834 ms
 * Timestamp: 10/27/2023 12:28:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_FAB1();
	scripts\mp\killstreaks\_killstreaks::func_DEFB("bombardment",::func_128DC,undefined,undefined,::triggeredbombardmentweapon,::func_13C8B);
	level.var_4D82["bombardment"] = 160000;
	var_00 = ["passive_fast_launch","passive_decreased_explosions","passive_extra_selection","passive_increased_cost","passive_impulse_explosion","passive_single_explosion"];
	scripts\mp\_killstreak_loot::func_DF07("bombardment",var_00);
}

//Function Number: 2
func_FAB1()
{
	level._effect["spike_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_bombard_blast_source.vfx");
	level._effect["spike_fire"] = loadfx("vfx/iw7/_requests/mp/vfx_bombardment_aerial_blast.vfx");
	level._effect["spike_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_bombard_projectile_trail.vfx");
}

//Function Number: 3
func_13C8B(param_00)
{
	if(scripts\mp\_utility::func_9FB3(level.var_2C48))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	scripts\mp\killstreaks\_mapselect::func_10DC2(0,0,undefined);
}

//Function Number: 4
func_128DC(param_00)
{
	var_01 = func_F1AC(param_00.var_AC68,param_00.var_110EA,param_00);
	if(!isdefined(var_01) || !var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_F1AC(param_00,param_01,param_02)
{
	scripts\common\utility::func_1C6E(0);
	scripts\common\utility::func_1C76(0);
	var_03 = 3;
	var_04 = "Multi-Strike";
	var_05 = "used_bombardment";
	var_06 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_02.var_1318B);
	if(var_06 != "")
	{
		var_05 = var_05 + "_" + var_06;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_extra_selection"))
	{
		var_03 = 4;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_impulse_explosion"))
	{
		var_04 = "Single-Strike";
		var_07 = undefined;
	}
	else
	{
		var_08 = spawn("script_origin",self.origin);
		self playlocalsound("bombardment_killstreak_bootup");
		var_08 playloopsound("bombardment_killstreak_hud_loop");
		self setsoundsubmix("mp_killstreak_overlay");
		var_07 = scripts\mp\killstreaks\_mapselect::func_8112(param_01,var_03);
		self playlocalsound("bombardment_killstreak_shutdown");
		self method_84D6();
		var_08 stoploopsound("");
		if(isdefined(var_08))
		{
			var_08 delete();
		}

		if(!isdefined(var_07))
		{
			scripts\common\utility::func_1C6E(1);
			scripts\common\utility::func_1C76(1);
			return 0;
		}
	}

	if(scripts\mp\_utility::func_9FB3(level.var_2C48))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		scripts\common\utility::func_1C6E(1);
		scripts\common\utility::func_1C76(1);
		return 0;
	}

	thread func_6CD4(var_07,param_01,var_04,param_02);
	level thread scripts\mp\_utility::func_115DE(var_05,self);
	scripts\mp\_matchdata::func_AFC9(param_01,self.origin);
	return 1;
}

//Function Number: 6
func_6CD4(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	var_04 = getent("airstrikeheight","targetname");
	var_05 = var_04.origin[2] + 10000;
	if(!isdefined(var_05))
	{
		var_05 = 20000;
	}

	if(!isdefined(param_02))
	{
		param_02 = "Multi-Strike";
	}

	level.var_2C48 = 1;
	thread func_139B2();
	var_06 = [];
	if(param_02 == "Single-Strike")
	{
		var_07 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle"];
		var_08 = physics_createcontents(var_07);
		var_09 = [];
		foreach(var_0B in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_0B))
			{
				continue;
			}

			if(level.teambased && var_0B.team == self.team)
			{
				continue;
			}

			if(!level.teambased && var_0B == self)
			{
				continue;
			}

			if(var_0B method_84D9())
			{
				continue;
			}

			var_0C = var_0B.origin + (0,0,var_05);
			var_0D = scripts\common\trace::func_DCED(var_0C,var_0B.origin - (0,0,10000),level.var_3CB5,var_08);
			var_0E = var_0D["position"];
			var_09[var_09.size] = spawnstruct();
			var_09[var_09.size - 1].var_AEC4 = var_0E;
		}

		var_06 = createkillcaments(var_09,var_05,param_03);
		scripts\common\utility::func_1C6E(1);
		scripts\common\utility::func_1C76(1);
		scripts\mp\_hostmigration::func_13708(0.5);
		foreach(var_13, var_11 in var_09)
		{
			var_12 = spawnstruct();
			var_12.origin = var_11.var_AEC4;
			var_12.var_110EA = param_01;
			var_12.var_257 = 350;
			var_12.team = self.team;
			playsoundatpos(var_11.var_AEC4,"bombardment_laser_on_epic");
			level.var_2300[level.var_2300.size] = var_12;
			level thread func_6D84(self,var_05,var_11.var_AEC4,self.angles,var_12,var_06[var_13],0,param_03);
			wait(0.1);
		}
	}
	else
	{
		var_13 = createkillcaments(param_01,var_06,var_04);
		scripts\common\utility::func_1C6E(1);
		scripts\common\utility::func_1C76(1);
		scripts\mp\_hostmigration::func_13708(0.5);
		foreach(var_13, var_15 in param_01)
		{
			thread sfx_bombardment_designator(var_15.var_AEC4,param_03);
			if(param_02 == "Multi-Strike")
			{
				var_16 = func_7DBB(var_15.var_AEC4,var_05,500,param_03);
				thread func_6D7D(var_16,var_05,param_01,var_06[var_13],param_03);
				if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_fast_launch"))
				{
					wait(0.1);
				}
				else
				{
					wait(0.2);
				}
			}
		}
	}

	scripts\mp\_hostmigration::func_13708(7);
	level.var_2C48 = undefined;
	self notify("bombardment_finished");
	thread func_D910();
	if(isdefined(var_06) && var_06.size > 0)
	{
		foreach(var_18 in var_06)
		{
			var_18 delete();
		}
	}
}

//Function Number: 7
sfx_bombardment_designator(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("ks_bombardment_mp");
	var_03 = "active";
	var_04 = 5;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_01,"passive_fast_launch"))
	{
		var_03 = "active_fast";
		var_04 = 5;
	}

	var_02 setscriptablepartstate("buildup",var_03,0);
	scripts\mp\_hostmigration::func_13708(var_04);
	var_02 setscriptablepartstate("buildup","neutral",0);
	var_02 delete();
}

//Function Number: 8
createkillcaments(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = 1.5;
	foreach(var_06 in param_00)
	{
		var_07 = findclosestunobstructedpointonnavmeshradius(var_06.var_AEC4,param_01,500,param_02);
		var_08 = spawn("script_model",var_07 + (0,0,30));
		var_08 thread func_5114(var_04,var_07 + (0,0,1500),2,1,0.05);
		var_03[var_03.size] = var_08;
		wait(0.2);
		var_04 = var_04 - 0.2;
	}

	return var_03;
}

//Function Number: 9
func_139B2()
{
	self endon("bombardment_finished");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("disconnect","joined_team");
	if(scripts\mp\_utility::func_9FB3(level.var_2C48))
	{
		level.var_2C48 = undefined;
	}
}

//Function Number: 10
func_D910()
{
	scripts\mp\_hostmigration::func_13708(8);
	scripts\mp\_utility::func_D915("killstreak ended - bombardment",self);
}

//Function Number: 11
func_5114(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(param_00);
	if(scripts\mp\_utility::func_9FB3(param_05))
	{
		var_07 = 0;
		var_08 = [];
		for(var_09 = 0;var_09 < param_06;var_09++)
		{
			var_0A = randomint(100);
			var_0B = randomint(360);
			var_0C = param_01[0] + var_0A * cos(var_0B);
			var_0D = param_01[1] + var_0A * sin(var_0B);
			var_0E = param_01[2];
			var_0F = (var_0C,var_0D,var_0E);
			var_08[var_08.size] = var_0F;
		}

		while(var_07 < param_06)
		{
			self moveto(var_08[var_07],0.05);
			var_07++;
			scripts\common\utility::func_136F7();
		}

		return;
	}

	self moveto(param_01,param_02,param_03,param_04);
}

//Function Number: 12
findclosestunobstructedpointonnavmeshradius(param_00,param_01,param_02,param_03)
{
	var_04 = getclosestpointonnavmesh(param_00);
	var_05 = undefined;
	var_06 = func_7DBB(param_00,param_01,param_02,param_03);
	foreach(var_08 in var_06)
	{
		var_09 = getclosestpointonnavmesh(var_08);
		var_0A = var_09 + (0,0,20);
		var_0B = var_0A + (0,0,10000);
		var_0C = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
		var_0D = scripts\common\trace::func_DCED(var_0A,var_0B,level.var_3CB5,var_0C);
		if(isdefined(var_0D["hittype"]) && var_0D["hittype"] == "hittype_none")
		{
			var_0E = distance2dsquared(param_00,var_09);
			if(!isdefined(var_05) || var_0E < var_05)
			{
				var_05 = var_0E;
				var_04 = var_09;
			}
		}
	}

	return var_04;
}

//Function Number: 13
func_7DBB(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = 7;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_fast_launch"))
	{
		var_05 = 4;
	}

	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = randomint(param_02);
		var_08 = randomint(360);
		var_09 = param_00[0] + var_07 * cos(var_08);
		var_0A = param_00[1] + var_07 * sin(var_08);
		var_0B = param_00[2];
		var_0C = (var_09,var_0A,var_0B);
		var_0D = var_0C + (0,0,param_01);
		var_0E = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip","physicscontents_solid","physicscontents_vehicle"];
		var_0F = physics_createcontents(var_0E);
		var_10 = scripts\common\trace::func_DCED(var_0D,var_0C - (0,0,10000),level.var_3CB5,var_0F);
		var_04[var_04.size] = var_10["position"];
	}

	return var_04;
}

//Function Number: 14
func_6D7D(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	level endon("game_ended");
	foreach(var_06 in param_00)
	{
		if(!isdefined(self))
		{
			break;
		}

		var_07 = var_06 + (0,0,param_01);
		var_08 = var_06;
		var_09 = randomfloatrange(0.3,0.5);
		if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_fast_launch"))
		{
			var_09 = randomfloatrange(0.1,0.3);
		}

		var_0A = spawnstruct();
		var_0A.origin = var_08;
		var_0A.var_110EA = param_02;
		var_0A.var_257 = 350;
		var_0A.team = self.team;
		level.var_2300[level.var_2300.size] = var_0A;
		level thread func_6D84(self,var_07,var_08,self.angles,var_0A,param_03,0,param_04);
		wait(var_09);
	}
}

//Function Number: 15
func_6D84(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("game_ended");
	var_08 = spawn("script_model",param_02 + (0,0,3));
	var_08 setmodel("ks_bombardment_mp");
	var_08 method_82DD(param_00);
	var_08 method_831F(param_00);
	var_08.var_13C2E = "bombproj_mp";
	var_08.var_110E8 = param_07;
	var_08.var_A63A = param_05;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_07,"passive_fast_launch"))
	{
		var_08 setscriptablepartstate("target","active_fast");
	}
	else
	{
		var_08 setscriptablepartstate("target","active");
	}

	var_09 = 2;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_07,"passive_fast_launch"))
	{
		var_09 = 1.5;
	}

	scripts\mp\_hostmigration::func_13708(var_09);
	var_08 setscriptablepartstate("fire","active");
	if(isdefined(param_00))
	{
		wait(0.5);
		var_08 setscriptablepartstate("explosion","active",0);
		var_08 thread scripts\mp\_utility::func_5106(5);
		level.var_2300 = scripts\common\utility::func_22A9(level.var_2300,param_04);
		return;
	}

	level.var_2300 = scripts\common\utility::func_22A9(level.var_2300,param_04);
	if(isdefined(param_05))
	{
		param_05 delete();
	}
}

//Function Number: 16
func_511A(param_00,param_01,param_02)
{
	self endon("death");
	wait(param_00);
	playfxontag(scripts\common\utility::getfx(param_01),self,param_02);
}

//Function Number: 17
triggeredbombardmentweapon(param_00)
{
	if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_impulse_explosion"))
	{
		param_00.var_EF88 = "gesture_script_weapon";
		param_00.var_394 = "ks_gesture_generic_mp";
		param_00.var_6D6B = "offhand_fired";
	}

	return 1;
}
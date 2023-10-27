/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_aastrike.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 507 ms
 * Timestamp: 10/27/2023 12:27:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("aamissile_projectile_mp");
	precachemodel("vehicle_av8b_harrier_jet_mp");
	level.var_115C0["axis"] = 0;
	level.var_115C0["allies"] = 0;
	level.var_E5DE = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("aastrike",::func_128D1);
}

//Function Number: 2
func_128D1(param_00,param_01)
{
	scripts\mp\_matchdata::func_AFC9("aastrike",self.origin);
	thread func_6CD2(param_00);
	thread scripts\mp\_utility::func_115DE("used_aastrike",self,self.team);
	return 1;
}

//Function Number: 3
func_4CD2()
{
	self endon("stopFindingTargets");
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	for(;;)
	{
		wait(0.05);
		func_6CC7();
		wait(randomintrange(4,5));
	}
}

//Function Number: 4
func_6CC7()
{
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	var_00 = [];
	var_01 = [];
	var_02 = [];
	if(isdefined(level.var_AD8B) && level.var_AD8B.size)
	{
		foreach(var_04 in level.var_AD8B)
		{
			if(isdefined(var_04.team) && var_04.team != self.team)
			{
				var_00[var_00.size] = var_04;
			}
		}
	}

	if(isdefined(level.var_8DD3) && level.var_8DD3.size)
	{
		foreach(var_07 in level.var_8DD3)
		{
			if(var_07.team != self.team)
			{
				var_01[var_01.size] = var_07;
			}
		}
	}

	var_09 = scripts\mp\_utility::getotherteam(self.team);
	if(isdefined(level.var_1679[var_09]))
	{
		foreach(var_0B in level.var_12AF3[var_09])
		{
			var_02[var_02.size] = var_0B;
		}
	}

	var_0D = 0;
	foreach(var_04 in var_00)
	{
		wait(3);
		if(var_0D % 2)
		{
			thread func_6D58(var_04,self.team,1);
		}
		else
		{
			thread func_6D58(var_04,self.team,0);
		}

		var_0D++;
	}

	foreach(var_07 in var_01)
	{
		wait(3);
		thread func_6D58(var_07,self.team,1);
	}

	foreach(var_0B in var_02)
	{
		wait(0.5);
		thread func_6D58(var_0B,self.team,0);
	}
}

//Function Number: 5
func_5FB5()
{
	self endon("stopFindingTargets");
	var_00 = self.team;
	if(scripts\mp\_utility::func_2DD9())
	{
		self waittill("killstreak_disowned");
	}
	else
	{
		scripts\common\utility::waittill_either("killstreak_disowned","game_ended");
	}

	self notify("owner_gone");
	level.var_115C0[scripts\mp\_utility::getotherteam(var_00)] = 0;
	level.var_1A94 = undefined;
}

//Function Number: 6
func_6CD2(param_00)
{
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	level.var_115C0[scripts\mp\_utility::getotherteam(self.team)] = 1;
	level.var_1A94 = self;
	thread func_5FB5();
	thread func_4CD2();
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		wait(6);
		if(var_01 == 1 || var_01 == 3)
		{
			thread func_5857(1);
			continue;
		}

		thread func_5857(0);
	}

	wait(3);
	self notify("stopFindingTargets");
	level.var_115C0[scripts\mp\_utility::getotherteam(self.team)] = 0;
	level.var_1A94 = undefined;
}

//Function Number: 7
func_6D58(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = (0,0,14000);
	var_04 = (0,0,1500);
	var_05 = 15000;
	var_06 = 20000;
	var_07 = param_00.origin;
	var_03 = (0,0,1) * var_07 + (0,0,1000);
	var_08 = param_00.angles * (0,1,0);
	var_09 = anglestoforward(var_08);
	var_0A = param_00.origin + var_04 + var_09 * var_05 * -1;
	var_0B = param_00.origin + var_04 + var_09 * var_06;
	var_0C = scripts\mp\_utility::func_1309("aamissile_projectile_mp",var_0A + (0,0,-75),param_00.origin,self);
	var_0C missile_settargetent(param_00);
	var_0C missile_setflightmodedirect();
	var_0D = scripts\mp\_utility::func_1309("aamissile_projectile_mp",var_0A + (randomint(500),randomint(500),-75),param_00.origin,self);
	var_0D missile_settargetent(param_00);
	var_0D missile_setflightmodedirect();
	if(param_02)
	{
		var_0E = spawnplane(self,"script_model",var_0A,"compass_objpoint_airstrike_friendly","compass_objpoint_airstrike_friendly");
	}
	else
	{
		var_0E = spawnplane(self,"script_model",var_0B);
	}

	if(self.team == "allies")
	{
		var_0E setmodel("vehicle_av8b_harrier_jet_mp");
	}
	else
	{
		var_0E setmodel("vehicle_av8b_harrier_jet_opfor_mp");
	}

	var_0F = distance(var_0A,var_0B);
	var_0E.angles = vectortoangles(var_0B - var_0A);
	var_0E thread func_1506(var_0F);
	var_0E thread func_D4FA();
	var_0F = distance(var_0A,var_0B);
	var_0E moveto(var_0B * 2,var_0F / 2000,0,0);
	wait(var_0F / 3000);
	var_0E delete();
}

//Function Number: 8
func_1506(param_00)
{
	self playloopsound("veh_aastrike_flyover_loop");
	wait(param_00 / 2 / 2000);
	self stoploopsound();
	self playloopsound("veh_aastrike_flyover_outgoing_loop");
}

//Function Number: 9
func_5857(param_00)
{
	self endon("disconnect");
	var_01 = randomint(level.var_108FB.size - 1);
	var_02 = level.var_108FB[var_01].origin * (1,1,0);
	var_03 = 20000;
	var_04 = 20000;
	var_05 = getent("airstrikeheight","targetname");
	var_06 = (0,0,var_05.origin[2] + randomintrange(-100,600));
	var_07 = anglestoforward((0,randomint(45),0));
	var_08 = var_02 + var_06 + var_07 * var_03 * -1;
	var_09 = var_02 + var_06 + var_07 * var_04;
	var_0A = var_08 + (randomintrange(400,500),randomintrange(400,500),randomintrange(200,300));
	var_0B = var_09 + (randomintrange(400,500),randomintrange(400,500),randomintrange(200,300));
	if(param_00)
	{
		var_0C = spawnplane(self,"script_model",var_08,"hud_minimap_harrier_green","hud_minimap_harrier_red");
	}
	else
	{
		var_0C = spawnplane(self,"script_model",var_09);
	}

	var_0D = spawnplane(self,"script_model",var_0A);
	if(self.team == "allies")
	{
		var_0C setmodel("vehicle_av8b_harrier_jet_mp");
		var_0D setmodel("vehicle_av8b_harrier_jet_mp");
	}
	else
	{
		var_0C setmodel("vehicle_av8b_harrier_jet_opfor_mp");
		var_0D setmodel("vehicle_av8b_harrier_jet_opfor_mp");
	}

	var_0C.angles = vectortoangles(var_09 - var_08);
	var_0C playloopsound("veh_aastrike_flyover_loop");
	var_0C thread func_D4FA();
	var_0D.angles = vectortoangles(var_09 - var_0A);
	var_0D thread func_D4FA();
	var_0E = distance(var_08,var_09);
	var_0C moveto(var_09 * 2,var_0E / 1800,0,0);
	wait(randomfloatrange(0.25,0.5));
	var_0D moveto(var_0B * 2,var_0E / 1800,0,0);
	wait(var_0E / 1600);
	var_0C delete();
	var_0D delete();
}

//Function Number: 10
func_D4FA()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_left_wingtip");
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_aastrike.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 187 ms
 * Timestamp: 10/27/2023 1:20:10 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precacheitem("aamissile_projectile_mp");
	precachemodel("vehicle_av8b_harrier_jet_mp");
	level.teamairdenied["axis"] = 0;
	level.teamairdenied["allies"] = 0;
	level.rockets = [];
	level.killstreakfuncs["aastrike"] = ::func_8425;
}

//Function Number: 2
func_8425(param_00,param_01)
{
	maps\mp\_matchdata::func_4F1D("aastrike",self.origin);
	thread func_3295(param_00);
	thread maps\mp\_utility::func_7FA0("used_aastrike",self,self.team);
	return 1;
}

//Function Number: 3
cycletargets()
{
	self endon("stopFindingTargets");
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	for(;;)
	{
		wait(0.05);
		func_328F();
		wait(randomintrange(4,5));
	}
}

//Function Number: 4
func_328F()
{
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	var_00 = [];
	var_01 = [];
	var_02 = [];
	if(isdefined(level.littlebirds) && level.littlebirds.size)
	{
		foreach(var_04 in level.littlebirds)
		{
			if(isdefined(var_04.team) && var_04.team != self.team)
			{
				var_00[var_00.size] = var_04;
			}
		}
	}

	if(isdefined(level.helis) && level.helis.size)
	{
		foreach(var_07 in level.helis)
		{
			if(var_07.team != self.team)
			{
				var_01[var_01.size] = var_07;
			}
		}
	}

	var_09 = maps\mp\_utility::getotherteam(self.team);
	if(isdefined(level.activeuavs[var_09]))
	{
		foreach(var_0B in level.uavmodels[var_09])
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
			thread func_32F7(var_04,self.team,1);
		}
		else
		{
			thread func_32F7(var_04,self.team,0);
		}

		var_0D++;
	}

	foreach(var_07 in var_01)
	{
		wait(3);
		thread func_32F7(var_07,self.team,1);
	}

	foreach(var_0B in var_02)
	{
		wait(0.5);
		thread func_32F7(var_0B,self.team,0);
	}
}

//Function Number: 5
earlyabortwatcher()
{
	self endon("stopFindingTargets");
	var_00 = self.team;
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		self waittill("killstreak_disowned");
	}
	else
	{
		common_scripts\utility::func_8B4F("killstreak_disowned","game_ended");
	}

	self notify("owner_gone");
	level.teamairdenied[maps\mp\_utility::getotherteam(var_00)] = 0;
	level.airdeniedplayer = undefined;
}

//Function Number: 6
func_3295(param_00)
{
	self endon("disconnect");
	self endon("owner_gone");
	self endon("game_ended");
	level.teamairdenied[maps\mp\_utility::getotherteam(self.team)] = 1;
	level.airdeniedplayer = self;
	thread earlyabortwatcher();
	thread cycletargets();
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		wait(6);
		if(var_01 == 1 || var_01 == 3)
		{
			thread func_2896(1);
			continue;
		}

		thread func_2896(0);
	}

	wait(3);
	self notify("stopFindingTargets");
	level.teamairdenied[maps\mp\_utility::getotherteam(self.team)] = 0;
	level.airdeniedplayer = undefined;
}

//Function Number: 7
func_32F7(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
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
	var_0C = magicbullet("aamissile_projectile_mp",var_0A + (0,0,-75),param_00.origin,self);
	var_0C missile_settargetent(param_00);
	var_0C missile_setflightmodedirect();
	var_0D = magicbullet("aamissile_projectile_mp",var_0A + (randomint(500),randomint(500),-75),param_00.origin,self);
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
	var_0E thread aasoundmanager(var_0F);
	var_0E thread func_6034();
	var_0F = distance(var_0A,var_0B);
	var_0E moveto(var_0B * 2,var_0F / 2000,0,0);
	wait(var_0F / 3000);
	var_0E delete();
}

//Function Number: 8
aasoundmanager(param_00)
{
	self playloopsound("veh_aastrike_flyover_loop");
	wait(param_00 / 2 / 2000);
	self stoploopsound();
	self playloopsound("veh_aastrike_flyover_outgoing_loop");
}

//Function Number: 9
func_2896(param_00)
{
	self endon("disconnect");
	var_01 = randomint(level.spawnpoints.size - 1);
	var_02 = level.spawnpoints[var_01].origin * (1,1,0);
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
	var_0C thread func_6034();
	var_0D.angles = vectortoangles(var_09 - var_0A);
	var_0D thread func_6034();
	var_0E = distance(var_08,var_09);
	var_0C moveto(var_09 * 2,var_0E / 1800,0,0);
	wait(randomfloatrange(0.25,0.5));
	var_0D moveto(var_0B * 2,var_0E / 1800,0,0);
	wait(var_0E / 1600);
	var_0C delete();
	var_0D delete();
}

//Function Number: 10
func_6034()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.fx_airstrike_contrail,self,"tag_left_wingtip");
}
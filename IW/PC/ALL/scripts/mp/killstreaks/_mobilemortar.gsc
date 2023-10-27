/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_mobilemortar.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 889 ms
 * Timestamp: 10/27/2023 12:29:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_114DD = loadfx("vfx/props/barrelexp.vfx");
	level.var_114DC = loadfx("vfx/core/expl/large_vehicle_explosion.vfx");
	level.var_114DE = loadfx("vfx/core/muzflash/ac130_105mm");
	level.var_114DA = loadfx("vfx/core/smktrail/ground_smoke_launch_a");
	level.var_114DB = loadfx("vfx/core/smktrail/ground_smoke_launch_a");
	level.var_8638 = [];
	level.var_8638["mp_alpha"][0]["origin"] = (-2748.91,2921.33,125.394);
	level.var_8638["mp_alpha"][0]["angles"] = (0,16,0);
	level.var_8638["mp_alpha"][1]["origin"] = (707.795,-499.191,-7.875);
	level.var_8638["mp_alpha"][1]["angles"] = (0,90,0);
	level.var_8638["mp_alpha"][2]["origin"] = (81.8557,2343.87,-7.875);
	level.var_8638["mp_alpha"][2]["angles"] = (0,-90.1,0);
	level.var_8638["mp_bravo"][0]["origin"] = (-761.529,1221.7,1212.13);
	level.var_8638["mp_bravo"][0]["angles"] = (0,-92.373,0);
	level.var_8638["mp_bravo"][1]["origin"] = (1474.99,971.865,1140.13);
	level.var_8638["mp_bravo"][1]["angles"] = (0,-178.401,0);
	level.var_8638["mp_bravo"][2]["origin"] = (-1366.57,-370.995,975.807);
	level.var_8638["mp_bravo"][2]["angles"] = (0,0.807495,0);
	level.var_8638["mp_dome"][0]["origin"] = (960.279,-482.564,-388.872);
	level.var_8638["mp_dome"][0]["angles"] = (0,100.536,0);
	level.var_8638["mp_dome"][1]["origin"] = (-921.941,166.449,-418.131);
	level.var_8638["mp_dome"][1]["angles"] = (0,25.4524,0);
	level.var_8638["mp_dome"][2]["origin"] = (43.3564,2102.85,-290.875);
	level.var_8638["mp_dome"][2]["angles"] = (0,-95.0347,0);
	level.var_8638["mp_plaza2"][0]["origin"] = (-1579.34,-2349.41,556.125);
	level.var_8638["mp_plaza2"][0]["angles"] = (0,5.32288,0);
	level.var_8638["mp_plaza2"][1]["origin"] = (-135.286,1622.04,607.13);
	level.var_8638["mp_plaza2"][1]["angles"] = (0,173.639,0);
	level.var_8638["mp_plaza2"][2]["origin"] = (-1544.55,1966.84,632.024);
	level.var_8638["mp_plaza2"][2]["angles"] = (0,0.796509,0);
	level.var_8638["mp_radar"][0]["origin"] = (896.685,2692.74,1208.13);
	level.var_8638["mp_radar"][0]["angles"] = (0,-178.313,0);
	level.var_8638["mp_radar"][1]["origin"] = (-2455.87,1564.41,1308.9);
	level.var_8638["mp_radar"][1]["angles"] = (0,1.93471,0);
	level.var_8638["mp_radar"][2]["origin"] = (1609,-1098.99,1162.13);
	level.var_8638["mp_radar"][2]["angles"] = (0,170.421,0);
	level.var_8638["mp_interchange"][0]["origin"] = (-2067.08,1218.17,-82.0487);
	level.var_8638["mp_interchange"][0]["angles"] = (0,-26.2946,0);
	level.var_8638["mp_interchange"][1]["origin"] = (-1198.2,-1782.62,103.665);
	level.var_8638["mp_interchange"][1]["angles"] = (0,23.3544,0);
	level.var_8638["mp_interchange"][2]["origin"] = (2391.95,899.034,87.7839);
	level.var_8638["mp_interchange"][2]["angles"] = (0,-136.134,0);
	level.var_8638["mp_lambeth"][0]["origin"] = (1641.37,-1318.01,-260.173);
	level.var_8638["mp_lambeth"][0]["angles"] = (0,133.329,0);
	level.var_8638["mp_lambeth"][1]["origin"] = (-1346.56,-880.226,-191.875);
	level.var_8638["mp_lambeth"][1]["angles"] = (0,0.432892,0);
	level.var_8638["mp_lambeth"][2]["origin"] = (1403.95,3083.4,-287.354);
	level.var_8638["mp_lambeth"][2]["angles"] = (0,-106.321,0);
	level.var_8638["mp_paris"][0]["origin"] = (-2427.42,619.217,188.826);
	level.var_8638["mp_paris"][0]["angles"] = (0,-2.90588,0);
	level.var_8638["mp_paris"][1]["origin"] = (2066.95,796.542,-88.322);
	level.var_8638["mp_paris"][1]["angles"] = (0,177.292,0);
	level.var_8638["mp_paris"][2]["origin"] = (506.406,-2165.36,-64.1201);
	level.var_8638["mp_paris"][2]["angles"] = (0,89.5715,0);
	level.var_8638["mp_hardhat"][0]["origin"] = (2033.65,-1428.62,299.86);
	level.var_8638["mp_hardhat"][0]["angles"] = (0,177.979,0);
	level.var_8638["mp_hardhat"][1]["origin"] = (-1044.73,82.9179,181.022);
	level.var_8638["mp_hardhat"][1]["angles"] = (0,-2.68066,0);
	level.var_8638["mp_hardhat"][2]["origin"] = (1248.95,1322.56,304.125);
	level.var_8638["mp_hardhat"][2]["angles"] = (0,-93.4772,0);
	level.var_8638["mp_carbon"][0]["origin"] = (-47.1408,-2841.26,3940.01);
	level.var_8638["mp_carbon"][0]["angles"] = (0,-101.667,0);
	level.var_8638["mp_carbon"][1]["origin"] = (-1686.2,-4727.09,3756.16);
	level.var_8638["mp_carbon"][1]["angles"] = (0,87.6436,0);
	level.var_8638["mp_carbon"][2]["origin"] = (-3761.18,-3716.69,3568.91);
	level.var_8638["mp_carbon"][2]["angles"] = (0,-4.20761,0);
	level.var_8638["mp_seatown"][0]["origin"] = (1339.87,763.592,175.114);
	level.var_8638["mp_seatown"][0]["angles"] = (0,178.551,0);
	level.var_8638["mp_seatown"][1]["origin"] = (1317.92,-725.589,232.125);
	level.var_8638["mp_seatown"][1]["angles"] = (0,177.738,0);
	level.var_8638["mp_seatown"][2]["origin"] = (-961.699,-1581.56,144.125);
	level.var_8638["mp_seatown"][2]["angles"] = (0,90.0176,0);
	level.var_8638["mp_bootleg"][0]["origin"] = (-988.964,1833.74,-99.9509);
	level.var_8638["mp_bootleg"][0]["angles"] = (0,-78.8909,0);
	level.var_8638["mp_bootleg"][1]["origin"] = (1105.84,-1116.13,-72.3048);
	level.var_8638["mp_bootleg"][1]["angles"] = (0,176.558,0);
	level.var_8638["mp_bootleg"][2]["origin"] = (-2027.31,84.2235,-51.875);
	level.var_8638["mp_bootleg"][2]["angles"] = (0,-5.12868,0);
	level.var_8638["mp_meteora"][0]["origin"] = (-590.972,1667.65,-99.6187);
	level.var_8638["mp_meteora"][0]["angles"] = (0,-89.7745,0);
	level.var_8638["mp_meteora"][1]["origin"] = (-1371.02,-1095.66,4.125);
	level.var_8638["mp_meteora"][1]["angles"] = (0,179.879,0);
	level.var_8638["mp_meteora"][2]["origin"] = (938.851,-1376.99,-60.0877);
	level.var_8638["mp_meteora"][2]["angles"] = (0,110.545,0);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("mobile_mortar",::func_128EF);
}

//Function Number: 2
func_128EF(param_00,param_01)
{
	if(!isdefined(level.var_8638[level.script]))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	if(isdefined(self.var_1B3) && !scripts\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");
		return 0;
	}
	else if(isdefined(level.var_B8F4))
	{
		self iprintlnbold(&"KILLSTREAKS_GROUND_APPROACHES_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	var_02 = func_F1C4();
	if(!isdefined(var_02))
	{
		return 0;
	}
	else
	{
		thread scripts\mp\_utility::stoplocationselection(0);
	}

	var_03 = func_49F1(self,var_02);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_03 thread func_BD1E("entrance");
	return 1;
}

//Function Number: 3
func_F1C4()
{
	var_00 = undefined;
	for(;;)
	{
		thread func_1012E();
		scripts\mp\_utility::func_1197("mobile_mortar","map_artillery_selector",0,500);
		self endon("stop_location_selection");
		self waittill("confirm_location",var_01);
		for(var_02 = 0;var_02 < 3;var_02++)
		{
			var_03 = level.var_8638[level.script][var_02]["origin"] * (1,1,0);
			var_04 = distancesquared(var_01,var_03);
			if(var_04 < -5536)
			{
				var_00 = var_02;
				break;
			}
		}

		if(isdefined(var_00))
		{
			for(var_02 = 0;var_02 < 3;var_02++)
			{
				if(self.var_AECD[var_02] != -1)
				{
					if(var_02 == var_00)
					{
						scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_AECD[var_02],"compass_objpoint_mortar_target");
						continue;
					}

					scripts\mp\objidpoolmanager::minimap_objective_state(self.var_AECD[var_02],"invisible");
				}
			}
		}
		else
		{
			for(var_02 = 0;var_02 < 3;var_02++)
			{
				if(self.var_AECD[var_02] != -1)
				{
					scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_AECD[var_02],"compass_objpoint_tank_enemy");
				}
			}
		}

		wait(0.5);
		self notify("picked_location");
		wait(0.05);
		if(isdefined(var_00))
		{
			break;
		}
	}

	return var_00;
}

//Function Number: 4
func_1012E()
{
	var_00 = scripts\mp\_hud_util::createfontstring("bigfixed",0.5);
	var_00 scripts\mp\_hud_util::setpoint("CENTER","CENTER",0,-150);
	var_00 settext(&"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
	self.var_AECD = [];
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		self.var_AECD[var_01] = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(self.var_AECD[var_01] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(self.var_AECD[var_01],"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_position(self.var_AECD[var_01],level.var_8638[level.script][var_01]["origin"]);
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_AECD[var_01],"active");
			scripts\mp\objidpoolmanager::minimap_objective_team(self.var_AECD[var_01],self.team);
			scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_AECD[var_01],"compass_objpoint_tank_friendly");
		}
	}

	scripts\common\utility::waittill_any_3("cancel_location","picked_location","stop_location_selection");
	var_00 scripts\mp\_hud_util::destroyelem();
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_AECD[var_01]);
	}
}

//Function Number: 5
func_49F1(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_airdrop::func_7EC0(level.var_8638[level.script][param_01]["origin"]);
	var_03 = bullettrace(level.var_8638[level.script][param_01]["origin"] + (0,0,var_02),level.var_8638[level.script][param_01]["origin"] - (0,0,var_02),0);
	var_04 = var_03["position"] + anglestoforward(level.var_8638[level.script][param_01]["angles"]) * -1000;
	var_05 = spawn("script_model",var_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_05.angles = level.var_8638[level.script][param_01]["angles"];
	var_05 setmodel("vehicle_bradley");
	var_05 setcandamage(1);
	var_05.maxhealth = level.var_8D73 * 2;
	var_05.health = var_05.maxhealth;
	var_05.var_222 = param_00;
	var_05.var_D40F = [];
	var_05.var_AA24 = var_05.origin;
	if(level.teambased)
	{
		var_05.team = param_00.team;
	}

	var_05.var_B0ED = level.var_108FB[0].origin[0];
	var_05.var_8EF9 = level.var_108FB[0].origin[0];
	var_05.var_B0EE = level.var_108FB[0].origin[1];
	var_05.var_8EFA = level.var_108FB[0].origin[1];
	var_06 = 200;
	if(level.var_108FB.size > 1)
	{
		for(var_07 = 1;var_07 < level.var_108FB.size;var_07++)
		{
			if(level.var_108FB[var_07].origin[0] < var_05.var_B0ED)
			{
				var_05.var_B0ED = level.var_108FB[var_07].origin[0];
			}
			else if(level.var_108FB[var_07].origin[0] > var_05.var_8EF9)
			{
				var_05.var_8EF9 = level.var_108FB[var_07].origin[0];
			}

			if(level.var_108FB[var_07].origin[1] < var_05.var_B0EE)
			{
				var_05.var_B0EE = level.var_108FB[var_07].origin[1];
				continue;
			}

			if(level.var_108FB[var_07].origin[1] > var_05.var_8EFA)
			{
				var_05.var_8EFA = level.var_108FB[var_07].origin[1];
			}
		}
	}
	else
	{
		var_06 = -2000;
	}

	var_05.var_B0ED = var_05.var_B0ED + var_06;
	var_05.var_8EF9 = var_05.var_8EF9 - var_06;
	var_05.var_B0EE = var_05.var_B0EE + var_06;
	var_05.var_8EFA = var_05.var_8EFA - var_06;
	if(level.teambased)
	{
		var_08 = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(var_08 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_08,"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_position(var_08,var_03["position"]);
			scripts\mp\objidpoolmanager::minimap_objective_state(var_08,"active");
			scripts\mp\objidpoolmanager::minimap_objective_team(var_08,var_05.team);
			scripts\mp\objidpoolmanager::minimap_objective_icon(var_08,"compass_objpoint_tank_friendly");
		}

		var_05.var_C2BB = var_08;
		var_08 = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(var_08 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_08,"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_position(var_08,var_03["position"]);
			scripts\mp\objidpoolmanager::minimap_objective_state(var_08,"active");
			scripts\mp\objidpoolmanager::minimap_objective_team(var_08,level.var_C74B[var_05.team]);
			scripts\mp\objidpoolmanager::minimap_objective_icon(var_08,"compass_objpoint_tank_enemy");
		}

		var_05.var_C2BA = var_08;
	}

	var_05 thread func_13B7E();
	var_05 thread scripts\mp\killstreaks\_helicopter::func_8D40();
	var_05 thread func_139E8();
	var_05 thread func_13B18();
	level.var_B8F4 = var_05;
	return var_05;
}

//Function Number: 6
func_BD1E(param_00)
{
	level endon("game_ended");
	self endon("death");
	if(param_00 == "entrance")
	{
		var_01 = self.origin + anglestoforward(self.angles) * 1000;
	}
	else
	{
		self notify("leaving");
		var_01 = self.origin + anglestoforward(self.angles) * -1000;
	}

	var_02 = 3;
	self moveto(var_01,var_02,var_02 * 0.6,var_02 * 0.4);
	wait(var_02);
	if(param_00 == "entrance")
	{
		thread func_BB64();
		return;
	}

	stopfxontag(level.var_114DA,self.var_7626,"tag_origin");
	stopfxontag(level.var_114DB,self.var_7626,"tag_origin");
	self.var_7626 delete();
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BB);
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
	level.var_B8F4 = undefined;
	self delete();
}

//Function Number: 7
func_6CC6()
{
	var_00 = undefined;
	foreach(var_02 in level.players)
	{
		if(var_02 == self.var_222)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_blindeye"))
		{
			continue;
		}

		if(level.teambased && var_02.team == self.var_222.team)
		{
			continue;
		}

		if(distancesquared(self.origin,var_02.origin) < 1000000)
		{
			continue;
		}

		for(var_03 = 0;var_03 < self.var_D40F.size;var_03++)
		{
			if(var_02 == self.var_D40F[var_03])
			{
				continue;
			}
		}

		if(distancesquared(var_02.origin,self.var_AA24) < 500000)
		{
			continue;
		}

		if(level.teambased)
		{
			var_04 = 0;
			for(var_03 = 0;var_03 < level.players.size;var_03++)
			{
				if(level.players[var_03].team != var_02.team && distancesquared(var_02.origin,level.players[var_03].origin) < 250000)
				{
					var_04 = 1;
					break;
				}
			}

			if(var_04 == 1)
			{
				continue;
			}
		}

		wait(0.05);
		var_05 = bullettrace(var_02.origin + (0,0,var_02 scripts\mp\killstreaks\_airdrop::func_7EC0(var_02.origin)),var_02.origin + (0,0,100),0);
		if(var_05["surfacetype"] != "none")
		{
			continue;
		}

		var_00 = var_02.origin;
		self.var_AA24 = var_02.origin;
		self.var_D40F[self.var_D40F.size] = var_02;
		break;
	}

	return var_00;
}

//Function Number: 8
func_6CC2()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		var_02 = (randomfloatrange(self.var_B0ED,self.var_8EF9),randomfloatrange(self.var_B0EE,self.var_8EFA),0);
		if(distancesquared(self.origin * (1,1,0),var_02) < 1000000)
		{
			continue;
		}

		if(distancesquared(self.var_222.origin * (1,1,0),var_02) < 250000)
		{
			continue;
		}

		if(distancesquared(self.origin * (1,1,0),self.var_AA24) < 500000)
		{
			continue;
		}

		var_03 = 0;
		if(level.teambased)
		{
			foreach(var_05 in level.players)
			{
				if(var_05.team == self.var_222.team && distancesquared(var_05.origin * (1,1,0),var_02) < 250000)
				{
					var_03 = 1;
					break;
				}
			}
		}

		if(var_03 == 0)
		{
			var_00 = var_02;
			self.var_AA24 = var_02;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = (randomfloatrange(self.var_B0ED,self.var_8EF9),randomfloatrange(self.var_B0EE,self.var_8EFA),0);
	}

	return var_00;
}

//Function Number: 9
func_BB64()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	var_00 = 0;
	self.var_7626 = spawn("script_model",self.origin);
	self.var_7626 setmodel("tag_origin");
	self.var_7626.angles = self.angles;
	self.var_7626 method_8002(-90);
	for(;;)
	{
		var_01 = func_6CC6();
		if(!isdefined(var_01))
		{
			var_01 = func_6CC2();
		}

		var_02 = self.origin[2] + 3500;
		var_03 = bullettrace(var_01 + (0,0,var_02),var_01 - (0,0,var_02),0);
		var_04 = var_01 + (0,0,var_02);
		var_05 = var_01 + (0,0,var_03["position"][2]);
		self playsound("bmp_fire");
		playfx(level.var_114DE,self.origin + anglestoforward(self.angles) * 50);
		if(var_00 < 3)
		{
			playfxontag(level.var_114DA,self.var_7626,"tag_origin");
			playfxontag(level.var_114DB,self.var_7626,"tag_origin");
			var_00++;
		}

		thread func_BB98();
		level thread func_6D78(self,var_04,var_05);
		self waittill("mortar_fire_done");
		wait(2.5);
	}
}

//Function Number: 10
func_6D78(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = param_00.var_222;
	var_04 = scripts\mp\_utility::func_1309("javelin_mp",param_00.origin + (0,0,150),param_01,var_03);
	var_05 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_05 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_05,"invisible",(0,0,0));
		scripts\mp\objidpoolmanager::minimap_objective_position(var_05,param_02);
		scripts\mp\objidpoolmanager::minimap_objective_state(var_05,"active");
		scripts\mp\objidpoolmanager::minimap_objective_team(var_05,param_00.team);
		scripts\mp\objidpoolmanager::minimap_objective_icon(var_05,"compass_objpoint_mortar_target");
	}

	var_04.var_C2BB = var_05;
	var_06 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_06 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_06,"invisible",(0,0,0));
		scripts\mp\objidpoolmanager::minimap_objective_position(var_06,param_02);
		scripts\mp\objidpoolmanager::minimap_objective_state(var_06,"active");
		scripts\mp\objidpoolmanager::minimap_objective_team(var_06,level.var_C74B[param_00.team]);
		scripts\mp\objidpoolmanager::minimap_objective_icon(var_06,"compass_objpoint_mortar_target");
	}

	var_04.var_C2BA = var_06;
	var_07 = 0;
	for(;;)
	{
		if(!isdefined(var_04) || var_07 > 115 || distancesquared(var_04.origin,param_01) < 500)
		{
			break;
		}
		else
		{
			wait(0.05);
		}

		var_07++;
	}

	if(isdefined(var_04))
	{
		var_04 delete();
	}

	if(isdefined(var_03))
	{
		var_08 = scripts\mp\_utility::func_1309("javelin_mp",param_01 + (0,0,200),param_02,var_03);
	}
	else
	{
		var_08 = scripts\mp\_utility::func_1309("javelin_mp",param_02 + (0,0,200),var_03);
	}

	var_08.var_C2BB = var_05;
	var_08.var_C2BA = var_06;
	var_08 thread func_13B16(param_00);
}

//Function Number: 11
func_13B16(param_00)
{
	level endon("game_ended");
	self waittill("death");
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BB);
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
	if(isdefined(param_00))
	{
		param_00 notify("mortar_fire_done");
	}
}

//Function Number: 12
func_BB98()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	var_00 = self.origin + anglestoforward(self.angles) * -20;
	var_01 = self.origin;
	var_02 = self.angles;
	self moveto(var_00,0.1);
	self rotatepitch(-3,0.1);
	wait(0.1);
	self moveto(var_01,0.15);
	self rotateto(var_02,0.15);
	wait(0.15);
}

//Function Number: 13
func_13B7E()
{
	level endon("game_ended");
	self endon("death");
	scripts\mp\_hostmigration::func_13708(90);
	self setcandamage(0);
	thread func_BD1E("exit");
}

//Function Number: 14
func_13B18()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		radiusdamage(self.origin,200,20,20);
		wait(1);
	}
}

//Function Number: 15
func_139E8()
{
	level endon("game_ended");
	self endon("leaving");
	self waittill("death");
	playfx(level.var_114DD,self.origin);
	playfx(level.var_114DC,self.origin);
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("vehicle_bradley_destroyed");
	var_00.angles = self.angles;
	stopfxontag(level.var_114DA,self.var_7626,"tag_origin");
	stopfxontag(level.var_114DB,self.var_7626,"tag_origin");
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BB);
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
	self.var_7626 delete();
	self delete();
	wait(3.5);
	var_00 delete();
	level.var_B8F4 = undefined;
}

//Function Number: 16
func_139E5()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(self.health < 0)
		{
			break;
		}
	}
}
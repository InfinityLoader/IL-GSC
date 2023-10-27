/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_mobilemortar.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 297 ms
 * Timestamp: 10/27/2023 1:21:15 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.tankfire = loadfx("fx/props/barrelexp");
	level.tankexplode = loadfx("fx/explosions/large_vehicle_explosion");
	level.tankflash = loadfx("fx/muzzleflashes/ac130_105mm");
	level.tankdust1 = loadfx("fx/smoke/ground_smoke_launch_a");
	level.tankdust2 = loadfx("fx/smoke/ground_smoke_launch_a");
	level.ground_support_locs = [];
	level.ground_support_locs["mp_alpha"][0]["origin"] = (-2748.91,2921.33,125.394);
	level.ground_support_locs["mp_alpha"][0]["angles"] = (0,16,0);
	level.ground_support_locs["mp_alpha"][1]["origin"] = (707.795,-499.191,-7.875);
	level.ground_support_locs["mp_alpha"][1]["angles"] = (0,90,0);
	level.ground_support_locs["mp_alpha"][2]["origin"] = (81.8557,2343.87,-7.875);
	level.ground_support_locs["mp_alpha"][2]["angles"] = (0,-90.1,0);
	level.ground_support_locs["mp_bravo"][0]["origin"] = (-761.529,1221.7,1212.13);
	level.ground_support_locs["mp_bravo"][0]["angles"] = (0,-92.373,0);
	level.ground_support_locs["mp_bravo"][1]["origin"] = (1474.99,971.865,1140.13);
	level.ground_support_locs["mp_bravo"][1]["angles"] = (0,-178.401,0);
	level.ground_support_locs["mp_bravo"][2]["origin"] = (-1366.57,-370.995,975.807);
	level.ground_support_locs["mp_bravo"][2]["angles"] = (0,0.807495,0);
	level.ground_support_locs["mp_dome"][0]["origin"] = (960.279,-482.564,-388.872);
	level.ground_support_locs["mp_dome"][0]["angles"] = (0,100.536,0);
	level.ground_support_locs["mp_dome"][1]["origin"] = (-921.941,166.449,-418.131);
	level.ground_support_locs["mp_dome"][1]["angles"] = (0,25.4524,0);
	level.ground_support_locs["mp_dome"][2]["origin"] = (43.3564,2102.85,-290.875);
	level.ground_support_locs["mp_dome"][2]["angles"] = (0,-95.0347,0);
	level.ground_support_locs["mp_plaza2"][0]["origin"] = (-1579.34,-2349.41,556.125);
	level.ground_support_locs["mp_plaza2"][0]["angles"] = (0,5.32288,0);
	level.ground_support_locs["mp_plaza2"][1]["origin"] = (-135.286,1622.04,607.13);
	level.ground_support_locs["mp_plaza2"][1]["angles"] = (0,173.639,0);
	level.ground_support_locs["mp_plaza2"][2]["origin"] = (-1544.55,1966.84,632.024);
	level.ground_support_locs["mp_plaza2"][2]["angles"] = (0,0.796509,0);
	level.ground_support_locs["mp_radar"][0]["origin"] = (896.685,2692.74,1208.13);
	level.ground_support_locs["mp_radar"][0]["angles"] = (0,-178.313,0);
	level.ground_support_locs["mp_radar"][1]["origin"] = (-2455.87,1564.41,1308.9);
	level.ground_support_locs["mp_radar"][1]["angles"] = (0,1.93471,0);
	level.ground_support_locs["mp_radar"][2]["origin"] = (1609,-1098.99,1162.13);
	level.ground_support_locs["mp_radar"][2]["angles"] = (0,170.421,0);
	level.ground_support_locs["mp_interchange"][0]["origin"] = (-2067.08,1218.17,-82.0487);
	level.ground_support_locs["mp_interchange"][0]["angles"] = (0,-26.2946,0);
	level.ground_support_locs["mp_interchange"][1]["origin"] = (-1198.2,-1782.62,103.665);
	level.ground_support_locs["mp_interchange"][1]["angles"] = (0,23.3544,0);
	level.ground_support_locs["mp_interchange"][2]["origin"] = (2391.95,899.034,87.7839);
	level.ground_support_locs["mp_interchange"][2]["angles"] = (0,-136.134,0);
	level.ground_support_locs["mp_lambeth"][0]["origin"] = (1641.37,-1318.01,-260.173);
	level.ground_support_locs["mp_lambeth"][0]["angles"] = (0,133.329,0);
	level.ground_support_locs["mp_lambeth"][1]["origin"] = (-1346.56,-880.226,-191.875);
	level.ground_support_locs["mp_lambeth"][1]["angles"] = (0,0.432892,0);
	level.ground_support_locs["mp_lambeth"][2]["origin"] = (1403.95,3083.4,-287.354);
	level.ground_support_locs["mp_lambeth"][2]["angles"] = (0,-106.321,0);
	level.ground_support_locs["mp_paris"][0]["origin"] = (-2427.42,619.217,188.826);
	level.ground_support_locs["mp_paris"][0]["angles"] = (0,-2.90588,0);
	level.ground_support_locs["mp_paris"][1]["origin"] = (2066.95,796.542,-88.322);
	level.ground_support_locs["mp_paris"][1]["angles"] = (0,177.292,0);
	level.ground_support_locs["mp_paris"][2]["origin"] = (506.406,-2165.36,-64.1201);
	level.ground_support_locs["mp_paris"][2]["angles"] = (0,89.5715,0);
	level.ground_support_locs["mp_hardhat"][0]["origin"] = (2033.65,-1428.62,299.86);
	level.ground_support_locs["mp_hardhat"][0]["angles"] = (0,177.979,0);
	level.ground_support_locs["mp_hardhat"][1]["origin"] = (-1044.73,82.9179,181.022);
	level.ground_support_locs["mp_hardhat"][1]["angles"] = (0,-2.68066,0);
	level.ground_support_locs["mp_hardhat"][2]["origin"] = (1248.95,1322.56,304.125);
	level.ground_support_locs["mp_hardhat"][2]["angles"] = (0,-93.4772,0);
	level.ground_support_locs["mp_carbon"][0]["origin"] = (-47.1408,-2841.26,3940.01);
	level.ground_support_locs["mp_carbon"][0]["angles"] = (0,-101.667,0);
	level.ground_support_locs["mp_carbon"][1]["origin"] = (-1686.2,-4727.09,3756.16);
	level.ground_support_locs["mp_carbon"][1]["angles"] = (0,87.6436,0);
	level.ground_support_locs["mp_carbon"][2]["origin"] = (-3761.18,-3716.69,3568.91);
	level.ground_support_locs["mp_carbon"][2]["angles"] = (0,-4.20761,0);
	level.ground_support_locs["mp_seatown"][0]["origin"] = (1339.87,763.592,175.114);
	level.ground_support_locs["mp_seatown"][0]["angles"] = (0,178.551,0);
	level.ground_support_locs["mp_seatown"][1]["origin"] = (1317.92,-725.589,232.125);
	level.ground_support_locs["mp_seatown"][1]["angles"] = (0,177.738,0);
	level.ground_support_locs["mp_seatown"][2]["origin"] = (-961.699,-1581.56,144.125);
	level.ground_support_locs["mp_seatown"][2]["angles"] = (0,90.0176,0);
	level.ground_support_locs["mp_bootleg"][0]["origin"] = (-988.964,1833.74,-99.9509);
	level.ground_support_locs["mp_bootleg"][0]["angles"] = (0,-78.8909,0);
	level.ground_support_locs["mp_bootleg"][1]["origin"] = (1105.84,-1116.13,-72.3048);
	level.ground_support_locs["mp_bootleg"][1]["angles"] = (0,176.558,0);
	level.ground_support_locs["mp_bootleg"][2]["origin"] = (-2027.31,84.2235,-51.875);
	level.ground_support_locs["mp_bootleg"][2]["angles"] = (0,-5.12868,0);
	level.ground_support_locs["mp_meteora"][0]["origin"] = (-590.972,1667.65,-99.6187);
	level.ground_support_locs["mp_meteora"][0]["angles"] = (0,-89.7745,0);
	level.ground_support_locs["mp_meteora"][1]["origin"] = (-1371.02,-1095.66,4.125);
	level.ground_support_locs["mp_meteora"][1]["angles"] = (0,179.879,0);
	level.ground_support_locs["mp_meteora"][2]["origin"] = (938.851,-1376.99,-60.0877);
	level.ground_support_locs["mp_meteora"][2]["angles"] = (0,110.545,0);
	level.killstreakfuncs["mobile_mortar"] = ::func_8441;
}

//Function Number: 2
func_8441(param_00,param_01)
{
	if(!isdefined(level.ground_support_locs[level.script]))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	if(isdefined(self.laststand) && !maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");
		return 0;
	}
	else if(isdefined(level.mobilemortar))
	{
		self iprintlnbold(&"KILLSTREAKS_GROUND_APPROACHES_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_4995())
	{
		return 0;
	}

	var_02 = selectentrancelocation();
	if(!isdefined(var_02))
	{
		return 0;
	}
	else
	{
		thread maps\mp\_utility::stoplocationselection(0);
	}

	var_03 = func_2107(self,var_02);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_03 thread func_54C0("entrance");
	return 1;
}

//Function Number: 3
selectentrancelocation()
{
	var_00 = undefined;
	for(;;)
	{
		thread func_7514();
		maps\mp\_utility::_beginlocationselection("mobile_mortar","map_artillery_selector",0,500);
		self endon("stop_location_selection");
		self waittill("confirm_location",var_01);
		for(var_02 = 0;var_02 < 3;var_02++)
		{
			var_03 = level.ground_support_locs[level.script][var_02]["origin"] * (1,1,0);
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
				if(var_02 == var_00)
				{
					objective_icon(self.locationobjectives[var_02],"compass_objpoint_mortar_target");
					continue;
				}

				objective_state(self.locationobjectives[var_02],"invisible");
			}
		}
		else
		{
			for(var_02 = 0;var_02 < 3;var_02++)
			{
				objective_icon(self.locationobjectives[var_02],"compass_objpoint_tank_enemy");
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
func_7514()
{
	var_00 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",0.5);
	var_00 maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,-150);
	var_00 settext(&"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
	self.locationobjectives = [];
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		self.locationobjectives[var_01] = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(self.locationobjectives[var_01],"invisible",(0,0,0));
		objective_position(self.locationobjectives[var_01],level.ground_support_locs[level.script][var_01]["origin"]);
		objective_state(self.locationobjectives[var_01],"active");
		objective_team(self.locationobjectives[var_01],self.team);
		objective_icon(self.locationobjectives[var_01],"compass_objpoint_tank_friendly");
	}

	common_scripts\utility::func_8B2A("cancel_location","picked_location","stop_location_selection");
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		maps\mp\_utility::_objective_delete(self.locationobjectives[var_01]);
	}
}

//Function Number: 5
func_2107(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_airdrop::func_3AB0(level.ground_support_locs[level.script][param_01]["origin"]);
	var_03 = bullettrace(level.ground_support_locs[level.script][param_01]["origin"] + (0,0,var_02),level.ground_support_locs[level.script][param_01]["origin"] - (0,0,var_02),0);
	var_04 = var_03["position"] + anglestoforward(level.ground_support_locs[level.script][param_01]["angles"]) * -1000;
	var_05 = spawn("script_model",var_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_05.angles = level.ground_support_locs[level.script][param_01]["angles"];
	var_05 setmodel("vehicle_bradley");
	var_05 setcandamage(1);
	var_05.maxhealth = level.heli_maxhealth * 2;
	var_05.health = var_05.maxhealth;
	var_05.owner = param_00;
	var_05.playersattacked = [];
	var_05.lasttarget = var_05.origin;
	if(level.teambased)
	{
		var_05.team = param_00.team;
	}

	var_05.var_4FAD = level.spawnpoints[0].origin[0];
	var_05.var_421D = level.spawnpoints[0].origin[0];
	var_05.lowy = level.spawnpoints[0].origin[1];
	var_05.highy = level.spawnpoints[0].origin[1];
	var_06 = 200;
	if(level.spawnpoints.size > 1)
	{
		for(var_07 = 1;var_07 < level.spawnpoints.size;var_07++)
		{
			if(level.spawnpoints[var_07].origin[0] < var_05.var_4FAD)
			{
				var_05.var_4FAD = level.spawnpoints[var_07].origin[0];
			}
			else if(level.spawnpoints[var_07].origin[0] > var_05.var_421D)
			{
				var_05.var_421D = level.spawnpoints[var_07].origin[0];
			}

			if(level.spawnpoints[var_07].origin[1] < var_05.lowy)
			{
				var_05.lowy = level.spawnpoints[var_07].origin[1];
				continue;
			}

			if(level.spawnpoints[var_07].origin[1] > var_05.highy)
			{
				var_05.highy = level.spawnpoints[var_07].origin[1];
			}
		}
	}
	else
	{
		var_06 = -2000;
	}

	var_05.var_4FAD = var_05.var_4FAD + var_06;
	var_05.var_421D = var_05.var_421D - var_06;
	var_05.lowy = var_05.lowy + var_06;
	var_05.highy = var_05.highy - var_06;
	if(level.teambased)
	{
		var_08 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_08,"invisible",(0,0,0));
		objective_position(var_08,var_03["position"]);
		objective_state(var_08,"active");
		objective_team(var_08,var_05.team);
		objective_icon(var_08,"compass_objpoint_tank_friendly");
		var_05.objidfriendly = var_08;
		var_08 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_08,"invisible",(0,0,0));
		objective_position(var_08,var_03["position"]);
		objective_state(var_08,"active");
		objective_team(var_08,level.otherteam[var_05.team]);
		objective_icon(var_08,"compass_objpoint_tank_enemy");
		var_05.objidenemy = var_08;
	}

	var_05 thread func_8D2E();
	var_05 thread maps\mp\killstreaks\_helicopter::func_40A5();
	var_05 thread func_8CD6();
	var_05 thread func_8D11();
	level.mobilemortar = var_05;
	return var_05;
}

//Function Number: 6
func_54C0(param_00)
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
		thread func_53ED();
	}

	stopfxontag(level.tankdust1,self.fxent,"tag_origin");
	stopfxontag(level.tankdust2,self.fxent,"tag_origin");
	self.fxent delete();
	maps\mp\_utility::_objective_delete(self.objidfriendly);
	maps\mp\_utility::_objective_delete(self.objidenemy);
	level.mobilemortar = undefined;
	self delete();
}

//Function Number: 7
findtarget()
{
	var_00 = undefined;
	foreach(var_02 in level.players)
	{
		if(var_02 == self.owner)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_blindeye"))
		{
			continue;
		}

		if(level.teambased && var_02.team == self.owner.team)
		{
			continue;
		}

		if(distancesquared(self.origin,var_02.origin) < 1000000)
		{
			continue;
		}

		for(var_03 = 0;var_03 < self.playersattacked.size;var_03++)
		{
			if(var_02 == self.playersattacked[var_03])
			{
				continue;
			}
		}

		if(distancesquared(var_02.origin,self.lasttarget) < 500000)
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
		var_05 = bullettrace(var_02.origin + (0,0,var_02 maps\mp\killstreaks\_airdrop::func_3AB0(var_02.origin)),var_02.origin + (0,0,100),0);
		if(var_05["surfacetype"] != "none")
		{
			continue;
		}

		var_00 = var_02.origin;
		self.lasttarget = var_02.origin;
		self.playersattacked[self.playersattacked.size] = var_02;
		break;
	}

	return var_00;
}

//Function Number: 8
findrandomtarget()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		var_02 = (randomfloatrange(self.var_4FAD,self.var_421D),randomfloatrange(self.lowy,self.highy),0);
		if(distancesquared(self.origin * (1,1,0),var_02) < 1000000)
		{
			continue;
		}

		if(distancesquared(self.owner.origin * (1,1,0),var_02) < 250000)
		{
			continue;
		}

		if(distancesquared(self.origin * (1,1,0),self.lasttarget) < 500000)
		{
			continue;
		}

		var_03 = 0;
		if(level.teambased)
		{
			foreach(var_05 in level.players)
			{
				if(var_05.team == self.owner.team && distancesquared(var_05.origin * (1,1,0),var_02) < 250000)
				{
					var_03 = 1;
					break;
				}
			}
		}

		if(var_03 == 0)
		{
			var_00 = var_02;
			self.lasttarget = var_02;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = (randomfloatrange(self.var_4FAD,self.var_421D),randomfloatrange(self.lowy,self.highy),0);
	}

	return var_00;
}

//Function Number: 9
func_53ED()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	var_00 = 0;
	self.fxent = spawn("script_model",self.origin);
	self.fxent setmodel("tag_origin");
	self.fxent.angles = self.angles;
	self.fxent addpitch(-90);
	for(;;)
	{
		var_01 = findtarget();
		if(!isdefined(var_01))
		{
			var_01 = findrandomtarget();
		}

		var_02 = self.origin[2] + 3500;
		var_03 = bullettrace(var_01 + (0,0,var_02),var_01 - (0,0,var_02),0);
		var_04 = var_01 + (0,0,var_02);
		var_05 = var_01 + (0,0,var_03["position"][2]);
		self playsound("bmp_fire");
		playfx(level.tankflash,self.origin + anglestoforward(self.angles) * 50);
		if(var_00 < 3)
		{
			playfxontag(level.tankdust1,self.fxent,"tag_origin");
			playfxontag(level.tankdust2,self.fxent,"tag_origin");
			var_00++;
		}

		thread mortarrecoil();
		level thread func_330F(self,var_04,var_05);
		self waittill("mortar_fire_done");
		wait(2.5);
	}
}

//Function Number: 10
func_330F(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = param_00.owner;
	var_04 = magicbullet("javelin_mp",param_00.origin + (0,0,150),param_01,var_03);
	var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_05,"invisible",(0,0,0));
	objective_position(var_05,param_02);
	objective_state(var_05,"active");
	objective_team(var_05,param_00.team);
	objective_icon(var_05,"compass_objpoint_mortar_target");
	var_04.objidfriendly = var_05;
	var_06 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_06,"invisible",(0,0,0));
	objective_position(var_06,param_02);
	objective_state(var_06,"active");
	objective_team(var_06,level.otherteam[param_00.team]);
	objective_icon(var_06,"compass_objpoint_mortar_target");
	var_04.objidenemy = var_06;
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
		var_08 = magicbullet("javelin_mp",param_01 + (0,0,200),param_02,var_03);
	}
	else
	{
		var_08 = magicbullet("javelin_mp",param_02 + (0,0,200),var_03);
	}

	var_08.objidfriendly = var_05;
	var_08.objidenemy = var_06;
	var_08 thread func_8D10(param_00);
}

//Function Number: 11
func_8D10(param_00)
{
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::_objective_delete(self.objidfriendly);
	maps\mp\_utility::_objective_delete(self.objidenemy);
	if(isdefined(param_00))
	{
		param_00 notify("mortar_fire_done");
	}
}

//Function Number: 12
mortarrecoil()
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
func_8D2E()
{
	level endon("game_ended");
	self endon("death");
	maps\mp\gametypes\_hostmigration::func_8B0D(90);
	self setcandamage(0);
	thread func_54C0("exit");
}

//Function Number: 14
func_8D11()
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
func_8CD6()
{
	level endon("game_ended");
	self endon("leaving");
	self waittill("death");
	playfx(level.tankfire,self.origin);
	playfx(level.tankexplode,self.origin);
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("vehicle_bradley_destroyed");
	var_00.angles = self.angles;
	stopfxontag(level.tankdust1,self.fxent,"tag_origin");
	stopfxontag(level.tankdust2,self.fxent,"tag_origin");
	maps\mp\_utility::_objective_delete(self.objidfriendly);
	maps\mp\_utility::_objective_delete(self.objidenemy);
	self.fxent delete();
	self delete();
	wait(3.5);
	var_00 delete();
	level.mobilemortar = undefined;
}

//Function Number: 16
func_8CD5()
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
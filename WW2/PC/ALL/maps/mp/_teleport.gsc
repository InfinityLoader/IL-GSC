/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_teleport.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 851 ms
 * Timestamp: 10/27/2023 3:21:49 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	thread func_5F8E();
}

//Function Number: 2
func_5F8E()
{
	var_00 = common_scripts\utility::func_46B7("teleport_world_origin","targetname");
	var_01 = level.var_3FDC;
	if(!var_00.size || !var_01 == "dom" || var_01 == "ctf" || var_01 == "hp" || var_01 == "undead" || var_01 == "ball")
	{
		return;
	}

	common_scripts\utility::func_3C87("teleport_setup_complete");
	level.var_9891 = [];
	level.var_9876 = 1;
	level.var_98B7 = 0;
	level.var_98B6 = 0;
	level.var_9888 = 0;
	level.var_988A = 0;
	level.var_9880 = undefined;
	level.var_98A8 = [];
	level.var_98A7 = [];
	level.var_9892 = [];
	level.var_98A1 = [];
	level.var_9898 = level.var_6BAF;
	level.var_6BAF = ::func_9898;
	level.var_98C4 = ::func_9881;
	level.var_98C5 = ::func_9882;
}

//Function Number: 3
func_988B()
{
	level.var_98B3 = [];
	var_00 = common_scripts\utility::func_46B7("teleport_world_origin","targetname");
	if(!var_00.size)
	{
		return;
	}

	level.var_98C1 = [];
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_165))
		{
			var_02.var_165 = "zone_" + level.var_98C1.size;
		}

		var_02.var_109 = var_02.var_165;
		func_98A0(var_02);
		level.var_9892[var_02.var_109] = [];
		level.var_98A1[var_02.var_109] = [];
		level.var_98C1[var_02.var_165] = var_02;
	}

	var_04 = getallnodes();
	foreach(var_06 in var_04)
	{
		var_02 = func_9879(var_06.var_116);
		level.var_9892[var_02.var_109][level.var_9892[var_02.var_109].size] = var_06;
	}

	for(var_08 = 0;var_08 < getzonecount();var_08++)
	{
		var_02 = func_9879(getzoneorigin(var_08));
		level.var_98A1[var_02.var_109][level.var_98A1[var_02.var_109].size] = var_08;
	}

	if(!isdefined(level.var_98C0))
	{
		if(isdefined(level.var_98C1["start"]))
		{
			func_98AF("start");
			return;
		}

		foreach(var_0B, var_0A in level.var_98C1)
		{
			func_98AF(var_0B);
			break;
		}
	}
}

//Function Number: 4
func_9898()
{
	func_988B();
	var_00 = undefined;
	var_01 = undefined;
	switch(level.var_3FDC)
	{
		case "dom":
			var_01 = ::func_9896;
			break;

		case "ctf":
			var_01 = ::func_9895;
			break;

		case "undead":
		case "hp":
			var_01 = ::func_9897;
			break;

		default:
			break;
	}

	if(isdefined(var_00))
	{
		level [[ var_00 ]]();
	}

	level [[ level.var_9898 ]]();
	if(isdefined(var_01))
	{
		level [[ var_01 ]]();
	}

	common_scripts\utility::func_3C8F("teleport_setup_complete");
}

//Function Number: 5
func_98AB()
{
	func_98AA();
}

//Function Number: 6
func_98A9()
{
	func_98AA();
}

//Function Number: 7
func_98AA()
{
	foreach(var_01 in level.var_98C1)
	{
		var_01.var_832E = [];
		var_01.var_8328 = [];
		var_01.var_8329 = [];
	}

	var_03 = getentarray("sd_bomb_pickup_trig","targetname");
	foreach(var_05 in var_03)
	{
		var_06 = func_9879(var_05.var_116);
		if(isdefined(var_06))
		{
			var_06.var_832E[var_06.var_832E.size] = var_05;
			func_9878(var_05,var_06.var_109);
		}
	}

	var_08 = getentarray("sd_bomb","targetname");
	foreach(var_0A in var_08)
	{
		var_06 = func_9879(var_0A.var_116);
		if(isdefined(var_06))
		{
			var_06.var_8328[var_06.var_8328.size] = var_0A;
			func_9878(var_0A,var_06.var_109);
		}
	}

	var_0C = getentarray("bombzone","targetname");
	foreach(var_0E in var_0C)
	{
		var_06 = func_9879(var_0E.var_116);
		if(isdefined(var_06))
		{
			var_06.var_8329[var_06.var_8329.size] = var_0E;
			func_9878(var_0E,var_06.var_109);
		}
	}

	var_10 = [];
	foreach(var_01 in level.var_98C1)
	{
		if(var_01.var_832E.size && var_01.var_832E.size && var_01.var_832E.size)
		{
			var_10[var_10.size] = var_01.var_109;
		}
	}

	func_987F(var_10);
	var_13 = level.var_98C1[level.var_98C0];
	func_98AC(var_13.var_832E);
	func_98AC(var_13.var_8328);
	func_98AC(var_13.var_8329);
}

//Function Number: 8
func_9878(param_00,param_01)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	if(!isdefined(param_01))
	{
		param_01 = "hide_from_getEnt";
	}

	foreach(var_03 in param_00)
	{
		var_03.var_8063 = var_03.var_1A5;
		var_03.var_1A5 = var_03.var_1A5 + "_" + param_01;
	}
}

//Function Number: 9
func_987F(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = getarraykeys(level.var_98C1);
	}

	var_01 = game["teleport_zone_dom"];
	if(!isdefined(var_01))
	{
		var_01 = common_scripts\utility::func_7A33(param_00);
		game["teleport_zone_dom"] = var_01;
	}

	func_98B8(var_01,0);
	level.var_9876 = 0;
}

//Function Number: 10
func_98AC(param_00)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_8063))
		{
			var_02.var_1A5 = var_02.var_8063;
		}
	}
}

//Function Number: 11
func_9895()
{
	level.var_9880 = ::func_989A;
}

//Function Number: 12
func_9897()
{
	if(!isdefined(level.var_687F))
	{
		level.var_687F = 5;
	}

	level.var_762C = [];
	level.var_75BF = [];
	level.var_BCF = level.var_ACB3;
	foreach(var_01 in level.var_ACB3)
	{
		if(var_01.var_81E1 > level.var_687F)
		{
			level.var_75BF[level.var_75BF.size] = var_01;
			continue;
		}

		level.var_762C[level.var_762C.size] = var_01;
	}

	level.var_ACB3 = level.var_762C;
	level.var_9880 = ::func_989C;
}

//Function Number: 13
func_9896()
{
	foreach(var_01 in level.var_98C1)
	{
		var_01.var_3CC5 = [];
		var_01.var_3211 = [];
	}

	level.var_BCA = level.var_3CC5;
	foreach(var_04 in level.var_3CC5)
	{
		var_05 = func_9879(var_04.var_116);
		if(isdefined(var_05))
		{
			var_04.var_98BF = var_05.var_109;
			var_05.var_3CC5[var_05.var_3CC5.size] = var_04;
			var_05.var_3211[var_05.var_3211.size] = var_04.var_A222;
		}
	}

	level.var_320A = [];
	foreach(var_11, var_01 in level.var_98C1)
	{
		foreach(var_10, var_09 in var_01.var_3CC5)
		{
			var_0A = spawnstruct();
			var_0A.var_9DA5 = var_09.var_116;
			var_0A.var_A57F = var_09.var_A222.var_A582[0].var_116;
			var_0A.var_15FA = var_09.var_A222.var_15FA;
			var_0A.var_15F9 = var_09.var_A222.var_15F9;
			var_0A.var_15FB = var_09.var_A222.var_15FB;
			var_0A.var_68E0 = var_09.var_A222.var_28D4;
			var_0A.var_68FA = [];
			foreach(var_0C in level.var_985B)
			{
				var_0D = "objpoint_" + var_0C + "_" + var_09.var_A222.var_37D8;
				var_0E = maps\mp\gametypes\_objpoints::func_45D6(var_0D);
				if(isdefined(var_0E))
				{
					var_0A.var_68FA[var_0C] = (var_0E.maxsightdistsqrd,var_0E.var_1D7,var_0E.var_1D9);
				}
			}

			var_0D = "objpoint_broadcaster_" + var_09.var_A222.var_37D8;
			var_0E = maps\mp\gametypes\_objpoints::func_45D6(var_0D);
			if(isdefined(var_0E))
			{
				var_0A.var_68FA["broadcaster"] = (var_0E.maxsightdistsqrd,var_0E.var_1D7,var_0E.var_1D9);
			}

			level.var_320A[var_01.var_109][var_09.var_A222.var_E5] = var_0A;
		}
	}

	level.var_3CC5 = level.var_98C1[level.var_98C0].var_3CC5;
	level.var_3211 = level.var_98C1[level.var_98C0].var_3211;
	foreach(var_01 in level.var_98C1)
	{
		foreach(var_04 in var_01.var_3CC5)
		{
			if(var_01.var_109 == level.var_98C0)
			{
				continue;
			}

			var_04.var_A222.var_A582[0] delete();
			var_04.var_A222 maps\mp\gametypes\_gameobjects::func_2D58();
		}
	}

	level.var_9880 = ::func_989B;
	func_989B(level.var_98C0);
	level.var_987B = 1;
	level thread func_987C();
}

//Function Number: 14
func_987C()
{
	while(!isdefined(level.var_19E8))
	{
		wait 0.05;
	}

	foreach(var_01 in level.var_98C1)
	{
		foreach(var_03 in var_01.var_3CC5)
		{
			var_04 = level.var_320A[var_01.var_109][var_03.var_A222.var_E5];
			var_04.var_671A = var_03.var_671A;
			if(var_01.var_109 != level.var_98C0)
			{
				var_03 delete();
			}
		}
	}
}

//Function Number: 15
func_9894()
{
	level.var_9880 = ::func_9899;
}

//Function Number: 16
func_989B(param_00)
{
	var_01 = level.var_98C1[level.var_98C0];
	var_02 = level.var_98C1[param_00];
	if(param_00 == level.var_98C0)
	{
		return;
	}

	foreach(var_04 in level.var_3211)
	{
		var_04 maps\mp\gametypes\_gameobjects::func_86EC("neutral");
		var_04 maps\mp\gametypes\_gameobjects::func_860A("enemy","waypoint_captureneutral" + var_04.var_E5);
		var_04 maps\mp\gametypes\_gameobjects::func_860E("enemy","waypoint_captureneutral" + var_04.var_E5);
		var_04 maps\mp\gametypes\_gameobjects::func_860A("friendly","waypoint_captureneutral" + var_04.var_E5);
		var_04 maps\mp\gametypes\_gameobjects::func_860E("friendly","waypoint_captureneutral" + var_04.var_E5);
		var_04 maps\mp\gametypes\_gameobjects::func_860A("broadcaster","waypoint_captureneutral" + var_04.var_E5);
		var_04 maps\mp\gametypes\_gameobjects::func_860E("broadcaster","waypoint_captureneutral" + var_04.var_E5,3);
		var_04.var_3C66 = 1;
	}

	foreach(var_04 in level.var_3CC5)
	{
		var_07 = level.var_320A[param_00][var_04.var_A222.var_E5];
		var_04.var_116 = var_07.var_9DA5;
		var_04.var_A222.var_A582[0].var_116 = var_07.var_A57F;
		var_04.var_A222.var_15FA = var_07.var_15FA;
		var_04.var_A222.var_15F9 = var_07.var_15F9;
		var_04.var_A222 maps/mp/gametypes/dom::func_A192();
		var_04.var_98BF = param_00;
		var_04.var_671A = var_07.var_671A;
		if(isdefined(var_04.var_A222.var_698A))
		{
			objective_position(var_04.var_A222.var_698A,var_07.var_68E0);
		}

		if(isdefined(var_04.var_A222.var_698B))
		{
			objective_position(var_04.var_A222.var_698B,var_07.var_68E0);
		}

		if(isdefined(var_04.var_A222.var_698C))
		{
			objective_position(var_04.var_A222.var_698C,var_07.var_68E0);
		}

		foreach(var_09 in level.var_985B)
		{
			var_0A = "objpoint_" + var_09 + "_" + var_04.var_A222.var_37D8;
			var_0B = maps\mp\gametypes\_objpoints::func_45D6(var_0A);
			var_0B.maxsightdistsqrd = var_07.var_68FA[var_09][0];
			var_0B.var_1D7 = var_07.var_68FA[var_09][1];
			var_0B.var_1D9 = var_07.var_68FA[var_09][2];
		}

		var_0A = "objpoint_broadcaster_" + var_04.var_A222.var_37D8;
		var_0B = maps\mp\gametypes\_objpoints::func_45D6(var_0A);
		var_0B.maxsightdistsqrd = var_07.var_68FA["broadcaster"][0];
		var_0B.var_1D7 = var_07.var_68FA["broadcaster"][1];
		var_0B.var_1D9 = var_07.var_68FA["broadcaster"][2];
	}

	maps/mp/gametypes/dom::func_3CC7();
	foreach(var_0F in level.var_3211)
	{
		var_10 = var_0F.var_E5;
		foreach(var_12 in level.var_98C1["start"].var_3211)
		{
			if(var_12.var_E5 == var_10)
			{
				var_0F.var_5CBA = var_12.var_5CBA;
			}
		}
	}

	foreach(var_0F in level.var_3CC5)
	{
		var_10 = var_0F.var_E5;
		foreach(var_17 in level.var_98C1["start"].var_3CC5)
		{
			if(var_17.var_E5 == var_10)
			{
				var_0F.var_5CBA = var_17.var_5CBA;
			}
		}
	}
}

//Function Number: 17
func_9885(param_00,param_01)
{
	foreach(var_03 in level.var_98C1[param_01].var_3CC5)
	{
		if(param_00.var_A222.var_E5 == var_03.var_A222.var_E5)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 18
func_989A(param_00)
{
	if(game["switchedsides"])
	{
		level.var_289D["axis"] = getent("post_event_capzone_allies","targetname");
		level.var_289D["allies"] = getent("post_event_capzone_axis","targetname");
	}
	else
	{
		level.var_289D["allies"] = getent("post_event_capzone_allies","targetname");
		level.var_289D["axis"] = getent("post_event_capzone_axis","targetname");
	}

	var_01 = [];
	var_01["allies"] = level.var_1FC6["allies"];
	var_01["axis"] = level.var_1FC6["axis"];
	var_02["allies"] = level.var_9853["allies"];
	var_02["axis"] = level.var_9853["axis"];
	var_03["allies"] = level.var_289D["allies"].var_116;
	var_03["axis"] = level.var_289D["axis"].var_116;
	foreach(var_05 in var_01)
	{
		var_05 maps\mp\gametypes\_gameobjects::func_6497(var_03[var_05.var_6DB2],(0,0,85));
		var_05.var_9D65 common_scripts\utility::func_9D9F();
	}

	foreach(var_08 in level.var_9853)
	{
		var_08 maps\mp\gametypes\_gameobjects::func_6497(var_03[var_08.var_6DB2],(0,0,85));
		if(isdefined(var_08.var_2006))
		{
			var_08 maps\mp\gametypes\_gameobjects::func_8A60("any");
			var_08 maps\mp\gametypes\_gameobjects::func_860A("friendly",level.var_5014);
			var_08 maps\mp\gametypes\_gameobjects::func_860E("friendly",level.var_5015);
			var_08 maps\mp\gametypes\_gameobjects::func_860A("enemy",level.var_5011);
			var_08 maps\mp\gametypes\_gameobjects::func_860E("enemy",level.var_5012);
			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_C30("none");
			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_8A60("friendly");
			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860A("friendly",level.var_5028);
			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860E("friendly",level.var_5029);
			if(var_08.var_6DB2 == "allies")
			{
				level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860A("broadcaster",level.var_5018);
				level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860E("broadcaster",level.var_5018,1);
				continue;
			}

			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860A("broadcaster",level.var_5018);
			level.var_1FC6[var_08.var_6DB2] maps\mp\gametypes\_gameobjects::func_860E("broadcaster",level.var_5018,2);
		}
	}

	maps/mp/gametypes/ctf::func_1FC3();
	foreach(var_05 in var_01)
	{
		var_05.var_9D65 common_scripts\utility::func_9DA3();
	}
}

//Function Number: 19
func_989C(param_00)
{
	level.var_ACB3 = level.var_75BF;
	if(level.var_7A62 == 0)
	{
		level.var_76EE = level.var_ACB3.size - 1;
	}
	else
	{
		level.var_ACB9 = [];
		maps/mp/gametypes/hp::func_8C31();
	}

	setomnvar("ui_hardpoint_timer",0);
	level notify("zone_moved");
}

//Function Number: 20
func_9899(param_00)
{
	var_01 = func_4380(param_00);
	foreach(var_03 in level.var_31F9)
	{
		var_04 = var_03.var_28D4 + var_01;
		var_05 = func_9886(var_04);
		if(isdefined(var_05))
		{
			var_05.var_5B59 = gettime();
			var_06 = var_05.var_116 - var_03.var_28D4;
			var_03.var_28D4 = var_03.var_28D4 + var_06;
			var_03.var_9D65.var_116 = var_03.var_9D65.var_116 + var_06;
			var_03.var_A582[0].var_116 = var_03.var_A582[0].var_116 + var_06;
			var_03.var_A582[1].var_116 = var_03.var_A582[1].var_116 + var_06;
			continue;
		}

		var_03 maps/mp/gametypes/conf::func_7D6F();
	}
}

//Function Number: 21
func_9886(param_00)
{
	var_01 = gettime();
	var_02 = getnodesinradiussorted(param_00,300,0,200,"Path");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(isdefined(var_04.var_5B59) && var_04.var_5B59 == var_01)
		{
			continue;
		}

		return var_04;
	}

	return undefined;
}

//Function Number: 22
func_9879(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in level.var_98C1)
	{
		var_05 = distancesquared(var_04.var_116,param_00);
		if(!isdefined(var_01) || var_05 < var_01)
		{
			var_01 = var_05;
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 23
func_989D(param_00)
{
	level.var_98B6 = param_00;
}

//Function Number: 24
func_989E(param_00)
{
	level.var_98B7 = param_00;
}

//Function Number: 25
func_9889(param_00)
{
	level.var_9888 = param_00;
}

//Function Number: 26
func_98B0(param_00,param_01)
{
	level.var_9891[param_00] = param_01;
}

//Function Number: 27
func_98B2(param_00,param_01)
{
	level.var_98A8[param_01] = param_00;
}

//Function Number: 28
func_98B1(param_00,param_01)
{
	level.var_98A7[param_01] = param_00;
}

//Function Number: 29
func_98A0(param_00)
{
	if(isdefined(param_00.var_6C5B) && param_00.var_6C5B)
	{
		return;
	}

	param_00.var_989F = [];
	param_00.var_989F["none"] = [];
	param_00.var_989F["allies"] = [];
	param_00.var_989F["axis"] = [];
	var_01 = common_scripts\utility::func_46B7("teleport_zone_" + param_00.var_109,"targetname");
	if(isdefined(param_00.var_1A2))
	{
		var_02 = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
		var_01 = common_scripts\utility::func_F73(var_02,var_01);
	}

	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04.var_165))
		{
			var_04.var_165 = "teleport_origin";
		}

		switch(var_04.var_165)
		{
			case "teleport_origin":
				var_05 = var_04.var_116 + (0,0,1);
				var_06 = var_04.var_116 - (0,0,250);
				var_07 = bullettrace(var_05,var_06,0);
				if(var_07["fraction"] == 1)
				{
					break;
				}
				var_04.var_116 = var_07["position"];
				break;

			case "telport_origin_nodrop":
				if(!isdefined(var_04.var_8260))
				{
					var_04.var_8260 = "none,axis,allies";
				}
	
				var_08 = strtok(var_04.var_8260,", ");
				foreach(var_0A in var_08)
				{
					if(!isdefined(param_00.var_989F[var_0A]))
					{
						continue;
					}
	
					if(!isdefined(var_04.var_1D))
					{
						var_04.var_1D = (0,0,0);
					}
	
					var_0B = param_00.var_989F[var_0A].size;
					param_00.var_989F[var_0A][var_0B] = var_04;
				}
				break;

			default:
				break;
		}
	}

	param_00.var_6C5B = 1;
}

//Function Number: 30
func_98AF(param_00)
{
	level.var_98C0 = param_00;
	if(isdefined(level.var_9891[param_00]))
	{
		maps\mp\_compass::func_8A2F(level.var_9891[param_00]);
	}
}

//Function Number: 31
func_987E(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level.var_98C0;
	}

	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_988E))
		{
			var_04.var_988E = "ent_" + var_04 getentitynumber();
		}

		if(!isdefined(level.var_98B3[var_04.var_988E]))
		{
			func_988C(var_04);
		}

		if(level.var_98B3[var_04.var_988E].var_AC7C == param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 32
func_988C(param_00)
{
	if(!isdefined(param_00.var_988E))
	{
		param_00.var_988E = "ent_" + param_00 getentitynumber();
	}

	if(isdefined(level.var_98B3[param_00.var_988E]))
	{
		return;
	}

	var_01 = spawnstruct();
	var_01.var_186 = param_00;
	var_02 = undefined;
	foreach(var_04 in level.var_98C1)
	{
		var_05 = distance(var_04.var_116,param_00.var_116);
		if(!isdefined(var_02) || var_05 < var_02)
		{
			var_02 = var_05;
			var_01.var_AC7C = var_04.var_109;
		}
	}

	level.var_98B3[param_00.var_988E] = var_01;
}

//Function Number: 33
func_988D(param_00)
{
	foreach(var_03, var_02 in level.var_98C1)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 34
func_98B8(param_00,param_01)
{
	if(!level.var_9876)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = level.var_98A8[param_00];
	if(isdefined(var_02) && param_01)
	{
		[[ var_02 ]]();
	}

	var_03 = level.var_98C1[level.var_98C0];
	var_04 = level.var_98C1[param_00];
	if(!isdefined(var_03) || !isdefined(var_04))
	{
		return;
	}

	if(level.var_988A)
	{
		func_98BC(param_00);
		func_98B9(param_00);
	}

	if(level.var_9888)
	{
		func_98BB(param_00);
	}

	if(isdefined(level.var_9880))
	{
		[[ level.var_9880 ]](param_00);
	}

	func_98AF(param_00);
	level notify("teleport_to_zone",param_00);
	var_05 = level.var_98A7[param_00];
	if(isdefined(var_05) && param_01)
	{
		[[ var_05 ]]();
	}

	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["post_teleport"]))
	{
		[[ level.var_19D5["post_teleport"] ]]();
	}
}

//Function Number: 35
func_98B9(param_00)
{
	var_01 = maps/mp/agents/_agent_utility::func_43FD("all");
	foreach(var_03 in var_01)
	{
		func_98BA(param_00,var_03);
	}
}

//Function Number: 36
func_98BC(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		func_98BA(param_00,var_02);
	}
}

//Function Number: 37
func_98BA(param_00,param_01)
{
	var_02 = level.var_98C1[level.var_98C0];
	var_03 = level.var_98C1[param_00];
	var_04 = gettime();
	if(isplayer(param_01) && param_01.var_178 == "intermission" || param_01.var_178 == "spectator")
	{
		var_05 = getentarray("mp_global_intermission","classname");
		var_05 = func_987E(var_05,param_00);
		var_06 = var_05[0];
		param_01 method_808C();
		param_01 setorigin(var_06.var_116);
		param_01 setangles(var_06.var_1D);
		return;
	}

	var_07 = undefined;
	var_08 = var_03.var_1D;
	if(isplayer(var_03))
	{
		var_08 = var_03 getangles();
	}

	foreach(var_0E, var_0A in var_05.var_989F)
	{
		var_05.var_989F[var_0E] = common_scripts\utility::func_F92(var_0A);
		foreach(var_0C in var_0A)
		{
			var_0C.var_2307 = 0;
		}
	}

	var_0F = [];
	if(level.var_984D)
	{
		if(isdefined(var_03.var_1A7) && isdefined(var_05.var_989F[var_03.var_1A7]))
		{
			var_0F = var_05.var_989F[var_03.var_1A7];
		}
	}
	else
	{
		var_0F = var_05.var_989F["none"];
	}

	foreach(var_11, var_0C in var_0F)
	{
		if(!var_0C.var_2307)
		{
			var_07 = var_0C.var_116;
			var_08 = var_0C.var_1D;
			var_0C.var_2307 = 1;
			break;
		}
	}

	var_12 = var_05.var_116 - var_04.var_116;
	var_13 = var_03.var_116 + var_12;
	if(!isdefined(var_07) && level.var_98B7)
	{
		if(canspawn(var_13) && !positionwouldtelefrag(var_13))
		{
			var_07 = var_13;
		}
	}

	if(!isdefined(var_07) && level.var_98B6)
	{
		var_14 = getnodesinradiussorted(var_13,300,0,200,"Path");
		for(var_15 = 0;var_15 < var_14.size;var_15++)
		{
			var_16 = var_14[var_15];
			if(isdefined(var_16.var_5B59) && var_16.var_5B59 == var_06)
			{
				continue;
			}

			var_0C = var_16.var_116;
			if(canspawn(var_0C) && !positionwouldtelefrag(var_0C))
			{
				var_16.var_5B59 = var_06;
				var_07 = var_0C;
				break;
			}
		}
	}

	if(!isdefined(var_07))
	{
		var_03 maps\mp\_utility::func_728();
		return;
	}

	var_03 method_843C();
	var_03 method_808C();
	var_03 setorigin(var_07);
	var_03 setangles(var_08);
	thread func_98BD(var_03);
}

//Function Number: 38
func_98BD(param_00)
{
	wait 0.05;
	if(isdefined(param_00))
	{
		var_01 = func_9879(param_00.var_116);
		if(var_01.var_109 != level.var_98C0)
		{
			param_00 maps\mp\_utility::func_728();
		}
	}
}

//Function Number: 39
func_4380(param_00)
{
	var_01 = level.var_98C1[param_00];
	var_02 = level.var_98C1[level.var_98C0];
	var_03 = var_01.var_116 - var_02.var_116;
	return var_03;
}

//Function Number: 40
func_98BB(param_00)
{
}

//Function Number: 41
func_9893()
{
	if(isdefined(self))
	{
		self notify("death");
	}
}

//Function Number: 42
func_0FB4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_00))
	{
		return;
	}

	common_scripts\utility::func_FB2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 43
func_0F8B(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		return;
	}

	common_scripts\utility::func_F8A(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 44
func_9883()
{
	return getentarray("care_package","targetname");
}

//Function Number: 45
func_9884()
{
	var_00 = [];
	var_01 = getentarray("script_model","classname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_1B7B))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 46
func_98A2(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	var_02 = param_00.var_116;
	var_03 = param_00.var_116 - (0,0,param_01);
	var_04 = bullettrace(var_02,var_03,0,param_00);
	if(var_04["fraction"] < 1)
	{
		param_00.var_116 = var_04["position"];
		return 1;
	}

	return 0;
}

//Function Number: 47
func_9873(param_00,param_01)
{
	if(func_987A(param_00))
	{
		return;
	}

	func_9872(param_00,param_01);
	if(isdefined(param_00.var_1A2))
	{
		var_02 = getentarray(param_00.var_1A2,"targetname");
		var_03 = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
		var_04 = common_scripts\utility::func_F73(var_02,var_03);
		common_scripts\utility::func_F8A(var_04,::func_9873,param_01);
	}
}

//Function Number: 48
func_98AE(param_00)
{
	func_9873(self,param_00);
}

//Function Number: 49
func_98AD(param_00)
{
	func_9872(self,param_00);
}

//Function Number: 50
func_9872(param_00,param_01)
{
	if(isdefined(param_00))
	{
		if(!func_987A(param_00))
		{
			param_00.var_116 = param_00.var_116 + param_01;
			param_00.var_5B59 = gettime();
		}
	}
}

//Function Number: 51
func_987A(param_00)
{
	return isdefined(param_00.var_5B59) && param_00.var_5B59 == gettime();
}

//Function Number: 52
func_9881()
{
	return level.var_9892[level.var_98C0];
}

//Function Number: 53
func_9882()
{
	return level.var_98A1[level.var_98C0];
}
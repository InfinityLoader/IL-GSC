/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_mansion\mp_mansion.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 198 ms
 * Timestamp: 10/27/2023 12:13:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_mansion\mp_mansion_precache::main();
	scripts\mp\maps\mp_mansion\gen\mp_mansion_art::main();
	scripts\mp\maps\mp_mansion\mp_mansion_fx::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_mansion");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",4);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	function_027A((-2201,1073,-8),(20,20,20),(0,0,0));
	thread fix_collision();
	thread spawn_oob_trigger();
	level.modifiedspawnpoints["-992 1760 -124"]["mp_ball_spawn"]["origin"] = (-992,1760,-121);
	level.modifiedspawnpoints["1656 576 -28"]["mp_ball_spawn"]["origin"] = (1656,576,-25);
	level.modifiedspawnpoints["1552 -632 -108"]["mp_ball_spawn"]["origin"] = (1552,-632,-105);
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("clip64x64x128","targetname");
	var_01 = spawn("script_model",(736,-208,280));
	var_01.angles = (0,180,90);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("clip512x512x8","targetname");
	var_03 = spawn("script_model",(328,1784,-256));
	var_03.angles = (0,270,-75);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = spawn("script_model",(16,2096,-256));
	var_04.angles = (0,360,-75);
	var_04 clonebrushmodeltoscriptmodel(var_02);
	var_05 = spawn("script_model",(-948,-1164,508));
	var_05.angles = (360,262,95);
	var_05 clonebrushmodeltoscriptmodel(var_02);
	var_06 = getent("player64x64x64","targetname");
	var_07 = spawn("script_model",(1808,920,-40));
	var_07.angles = (0,0,0);
	var_07 clonebrushmodeltoscriptmodel(var_06);
	var_08 = spawn("script_model",(1880,848,-40));
	var_08.angles = (0,0,0);
	var_08 clonebrushmodeltoscriptmodel(var_06);
	var_09 = spawn("script_model",(220,1404,8));
	var_09.angles = (0,0,0);
	var_09 clonebrushmodeltoscriptmodel(var_06);
	var_0A = getent("player32x32x32","targetname");
	var_0B = spawn("script_model",(832,1683,154));
	var_0B.angles = (0,0,6);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = getent("clip512x512x8","targetname");
	var_0D = spawn("script_model",(432,-344,280));
	var_0D.angles = (0,0,0);
	var_0D clonebrushmodeltoscriptmodel(var_0C);
	var_0E = getent("clip512x512x8","targetname");
	var_0F = spawn("script_model",(-3152,-208,448));
	var_0F.angles = (0,0,180);
	var_0F clonebrushmodeltoscriptmodel(var_0E);
	var_10 = getent("clip512x512x8","targetname");
	var_11 = spawn("script_model",(-2992,-576,448));
	var_11.angles = (0,45,-180);
	var_11 clonebrushmodeltoscriptmodel(var_10);
	var_12 = getent("clip512x512x8","targetname");
	var_13 = spawn("script_model",(-2704,-624,448));
	var_13.angles = (0,0,180);
	var_13 clonebrushmodeltoscriptmodel(var_12);
	var_14 = getent("clip512x512x8","targetname");
	var_15 = spawn("script_model",(-2728,-112,448));
	var_15.angles = (0,0,180);
	var_15 clonebrushmodeltoscriptmodel(var_14);
	var_16 = getent("player32x32x8","targetname");
	var_17 = spawn("script_model",(1276,-1424,74));
	var_17.angles = (88.4,270,-90);
	var_17 clonebrushmodeltoscriptmodel(var_16);
	var_18 = getent("player32x32x8","targetname");
	var_19 = spawn("script_model",(1268,-1424,74));
	var_19.angles = (88.4,270,-90);
	var_19 clonebrushmodeltoscriptmodel(var_18);
	var_1A = getent("player512x512x8","targetname");
	var_1B = spawn("script_model",(-1485,-1796,468));
	var_1B.angles = (0,90,-76);
	var_1B clonebrushmodeltoscriptmodel(var_1A);
	var_1C = getent("player512x512x8","targetname");
	var_1D = spawn("script_model",(-1085,-1804,476));
	var_1D.angles = (0,270,-76);
	var_1D clonebrushmodeltoscriptmodel(var_1C);
	var_1E = getent("player128x128x8","targetname");
	var_1F = spawn("script_model",(-800,-1100,226));
	var_1F.angles = (360,90,-74);
	var_1F clonebrushmodeltoscriptmodel(var_1E);
	var_20 = getent("player512x512x8","targetname");
	var_21 = spawn("script_model",(1396,412,-248));
	var_21.angles = (360,180,90);
	var_21 clonebrushmodeltoscriptmodel(var_20);
	var_22 = getent("player256x256x8","targetname");
	var_23 = spawn("script_model",(2348,408,-144));
	var_23.angles = (360,180,90);
	var_23 clonebrushmodeltoscriptmodel(var_22);
	var_24 = getent("player256x256x8","targetname");
	var_25 = spawn("script_model",(1708,408,-148));
	var_25.angles = (360,180,90);
	var_25 clonebrushmodeltoscriptmodel(var_24);
	var_26 = getent("player256x256x8","targetname");
	var_27 = spawn("script_model",(-932,900,-104));
	var_27.angles = (0,125,90);
	var_27 clonebrushmodeltoscriptmodel(var_26);
	var_28 = getent("player256x256x8","targetname");
	var_29 = spawn("script_model",(-1140,1020,-108));
	var_29.angles = (360,180,90);
	var_29 clonebrushmodeltoscriptmodel(var_28);
	var_2A = getent("player128x128x8","targetname");
	var_2B = spawn("script_model",(-560,448,320));
	var_2B.angles = (270,0,0);
	var_2B clonebrushmodeltoscriptmodel(var_2A);
	var_2C = getent("player128x128x8","targetname");
	var_2D = spawn("script_model",(-568,560,220));
	var_2D.angles = (0,270,-90);
	var_2D clonebrushmodeltoscriptmodel(var_2C);
	var_2C = getent("player32x32x128","targetname");
	var_2D = spawn("script_model",(-576,368,272));
	var_2D.angles = (90,68,-22);
	var_2D clonebrushmodeltoscriptmodel(var_2C);
	var_2E = getent("player512x512x8","targetname");
	var_2F = spawn("script_model",(1040,-288,240));
	var_2F.angles = (270,330,-60);
	var_2F clonebrushmodeltoscriptmodel(var_2E);
}

//Function Number: 3
spawn_oob_trigger()
{
	wait(1);
	var_00 = spawn("trigger_radius",(710,1550,275),0,100,10);
	var_01 = spawn("trigger_radius",(-1220,1112,210),0,60,15);
	var_00 hide();
	var_01 hide();
	level.var_C7B3[level.var_C7B3.size] = var_00;
	level.var_C7B3[level.var_C7B3.size] = var_01;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_screenshotcity.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 282 ms
 * Timestamp: 10/27/2023 12:21:28 AM
*******************************************************************/

//Function Number: 1
func_BC86()
{
	var_00 = getent("weapon_loc_screenshot_1","targetname");
	var_01 = var_00.origin + (0,0,0);
	var_02 = var_00.angles + (0,0,0);
	level.var_CB4F.origin = var_01;
	level.var_CB4F.angles = var_02;
	var_03 = getent("camera_weapon_screenshot_1","targetname");
	var_04 = var_03.origin + (100,0,0);
	var_05 = var_03.angles + (0,0,0);
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = var_04;
	level.var_37A6.angles = var_05;
}

//Function Number: 2
move_to_blue_background_side_on()
{
	var_00 = getent("weapon_loc_screenshot_1","targetname");
	var_01 = var_00.origin + (0,0,0);
	var_02 = var_00.angles + (0,-25,0);
	level.var_CB4F.origin = var_01;
	level.var_CB4F.angles = var_02;
	var_03 = getent("camera_weapon_screenshot_1","targetname");
	var_04 = var_03.origin + (100,0,0);
	var_05 = var_03.angles + (0,0,0);
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = var_04;
	level.var_37A6.angles = var_05;
}

//Function Number: 3
func_BC8C()
{
	var_00 = getent("weapon_loc_screenshot_2","targetname");
	var_01 = var_00.origin + (0,0,0);
	var_02 = var_00.angles + (0,0,0);
	level.var_CB4F.origin = var_01;
	level.var_CB4F.angles = var_02;
	var_03 = getent("camera_weapon_screenshot_2","targetname");
	var_04 = var_03.origin + (100,0,0);
	var_05 = var_03.angles + (0,0,0);
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = var_04;
	level.var_37A6.angles = var_05;
}

//Function Number: 4
move_to_grey_background_side_on()
{
	var_00 = getent("weapon_loc_screenshot_2","targetname");
	var_01 = var_00.origin + (0,0,0);
	var_02 = var_00.angles + (0,-25,0);
	level.var_CB4F.origin = var_01;
	level.var_CB4F.angles = var_02;
	var_03 = getent("camera_weapon_screenshot_2","targetname");
	var_04 = var_03.origin + (100,0,0);
	var_05 = var_03.angles + (0,0,0);
	level.var_37A6 dontinterpolate();
	level.var_37A6.origin = var_04;
	level.var_37A6.angles = var_05;
}

//Function Number: 5
func_11452(param_00)
{
	var_01 = tablelookup("mp/weaponScreenshotList.csv",0,param_00,1);
	func_BC86();
	wait(2);
	wait(2);
	move_to_blue_background_side_on();
	wait(2);
	wait(2);
	func_BC8C();
	wait(2);
	wait(2);
	move_to_grey_background_side_on();
	wait(2);
	wait(2);
}

//Function Number: 6
func_ECE1()
{
	self endon("disconnect");
	var_00 = getent("weapon_loc_hq1","targetname");
	var_01 = var_00.origin + (0,0,0);
	var_02 = var_00.angles + (0,0,0);
	level.var_CB4F = spawn("script_weapon",var_01,0,0,5);
	level.var_CB4F.angles = var_02;
	level.var_37A6.origin = level.var_37AA.var_13C7B.origin;
	level.var_37A6.angles = level.var_37AA.var_13C7B.angles;
	wait(1);
	setomnvar("ui_screenshot_ready",1);
	for(;;)
	{
		self waittill("luinotifyserver",var_03,var_04);
		if(var_03 == "take_screenshot")
		{
			if(var_04 == -1)
			{
				setomnvar("ui_screenshot_ready",0);
				wait(0.1);
				setomnvar("ui_screenshot_ready",1);
				continue;
			}

			setomnvar("ui_screenshot_ready",0);
			func_11452(var_04);
			setomnvar("ui_screenshot_ready",1);
		}
	}
}
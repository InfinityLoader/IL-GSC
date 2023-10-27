/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 18665.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:22:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("mp_village");
	var_00.startdist = 700;
	var_00.halfwaydist = 4792;
	var_00.red = 0.467;
	var_00.green = 0.499;
	var_00.blue = 0.478;
	var_00.maxopacity = 0.663;
	var_00.sunendfadeangle = 1;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.819;
	var_00.sungreen = 0.708;
	var_00.sunblue = 0.622;
	var_00.sundir = (0.268,0.844,0.465);
	var_00.sunbeginfadeangle = 0;
	var_00.var_1AF5 = 38;
	var_00.normalfogscale = 0.68;
}
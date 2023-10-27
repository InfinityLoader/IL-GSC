/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\mp_prisonbreak_fog.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 1:29:39 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak");
	var_00.startdist = 500;
	var_00.halfwaydist = 25000;
	var_00.red = 0.62;
	var_00.green = 0.78;
	var_00.blue = 0.86;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0.5;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.55;
	var_00.sungreen = 0.45;
	var_00.sunblue = 0.31;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0.99,0.112215,-0.0120798);
	var_00.sunbeginfadeangle = 10;
	var_00.sunendfadeangle = 92;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 2;
	var_00.skyfogmaxangle = 64;
	var_00.hdroverride = "mp_prisonbreak_HDR";
	var_00 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak_indoor");
	var_00.startdist = 2500;
	var_00.halfwaydist = 9500;
	var_00.red = 0.627451;
	var_00.green = 0.717647;
	var_00.blue = 0.745098;
	var_00.maxopacity = 0.41;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.554666;
	var_00.sungreen = 0.458303;
	var_00.sunblue = 0.312117;
	var_00.sundir = (0.99,0.112215,-0.0120798);
	var_00.sunbeginfadeangle = 10;
	var_00.sunendfadeangle = 92;
	var_00.normalfogscale = 1;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak_HDR");
	var_00.startdist = 500;
	var_00.halfwaydist = 4500;
	var_00.red = 0.62;
	var_00.green = 0.71;
	var_00.blue = 0.86;
	var_00.hdrcolorintensity = 1.2;
	var_00.maxopacity = 0.71;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.55;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.43;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0.99,0.112215,-0.0120798);
	var_00.sunbeginfadeangle = 10;
	var_00.sunendfadeangle = 92;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 8;
	var_00.skyfogmaxangle = 82;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\odin_fog.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:38:18 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	sunflare();
	var_00 = maps\_utility::create_vision_set_fog("odin");
	var_00.startdist = 0;
	var_00.halfwaydist = 97381.1;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 0.00387937;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
	var_00.hdroverride = "odin_HDR";
	var_00 = maps\_utility::create_vision_set_fog("odin_HDR");
	var_00.startdist = 0;
	var_00.halfwaydist = -32767;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0.0234375;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
	var_00 = maps\_utility::create_vision_set_fog("odin_interior");
	var_00.startdist = 0;
	var_00.halfwaydist = 97381.1;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 0.00387937;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
	var_00.hdroverride = "odin_interior_HDR";
	var_00 = maps\_utility::create_vision_set_fog("odin_interior_HDR");
	var_00.startdist = 0;
	var_00.halfwaydist = -32767;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0.0234375;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
	var_00 = maps\_utility::create_vision_set_fog("odin_spin");
	var_00.startdist = 0;
	var_00.halfwaydist = 97381.1;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 0.00387937;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
	var_00.hdroverride = "odin_spin_HDR";
	var_00 = maps\_utility::create_vision_set_fog("odin_spin_HDR");
	var_00.startdist = 0;
	var_00.halfwaydist = -32767;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0.0234375;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 180;
	var_00.skyfogmaxangle = 178;
}

//Function Number: 2
sunflare()
{
	var_00 = maps\_utility::create_sunflare_setting("odin_default");
	var_00.position = (3.5,245,0);
	var_00 = maps\_utility::create_sunflare_setting("odin_escape");
	var_00.position = (1,290,0);
	var_00 = maps\_utility::create_sunflare_setting("odin_spin_end");
	var_00.position = (-39,230,0);
	maps\_art::func_7D49("odin_default",0);
}
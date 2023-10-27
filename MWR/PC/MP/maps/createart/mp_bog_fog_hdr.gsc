/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\mp_bog_fog_hdr.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:36:43 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_bog");
	var_00.startdist = 1267.61;
	var_00.halfwaydist = 2049;
	var_00.red = 1;
	var_00.green = 0.784136;
	var_00.blue = 0.675201;
	var_00.hdrcolorintensity = 4.59;
	var_00.maxopacity = 0.378365;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 0;
	var_00.sunblue = 0;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (1,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 180;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 48.0714;
	var_00.skyfogmaxangle = 96.2788;
	var_00.heightfogenabled = 1;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 206.435;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.615273,0.477913,0.407925);
	var_00.atmosfoghazecolor = (0.902738,0.722815,0.670975);
	var_00.atmosfoghazestrength = 0.501789;
	var_00.atmosfoghazespread = 0.831624;
	var_00.atmosfogextinctionstrength = 0.75;
	var_00.atmosfoginscatterstrength = 4.85015;
	var_00.atmosfoghalfplanedistance = 513.962;
	var_00.atmosfogstartdistance = 959.662;
	var_00.atmosfogdistancescale = 0.803994;
	var_00.atmosfogskydistance = 94808;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 8.06833;
	var_00.atmosfogskyfalloffanglerange = 14.8565;
	var_00.atmosfogsundirection = (-0.273865,-0.959554,0.0652224);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -42;
	var_00.atmosfogheightfoghalfplanedistance = 170;
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 3764.17;
	var_00.halfwaydist = 19391;
	var_00.red = 1;
	var_00.green = 0.925269;
	var_00.blue = 0.847076;
	var_00.hdrcolorintensity = 12.2088;
	var_00.maxopacity = 0.7;
	var_00.transitiontime = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
}

//Function Number: 2
setupfog()
{
}
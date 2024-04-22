/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_kremlin_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:06:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_kremlin");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 14.029;
	var_00.maxopacity = 1;
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
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.632813,0.664063,0.863912);
	var_00.atmosfoghazecolor = (0.273438,0.212994,0.184211);
	var_00.atmosfoghazestrength = 0.625;
	var_00.atmosfoghazespread = 0.03125;
	var_00.atmosfogextinctionstrength = 0.218894;
	var_00.atmosfoginscatterstrength = 17.2165;
	var_00.atmosfoghalfplanedistance = 559.826;
	var_00.atmosfogstartdistance = 786.628;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 40960;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 48;
	var_00.atmosfogskyfalloffanglerange = 234;
	var_00.atmosfogsundirection = (-0.697483,-0.70711,0.116246);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -2816;
	var_00.atmosfogheightfoghalfplanedistance = 1089;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_kremlin_cg");
	var_00.startdist = 1000;
	var_00.halfwaydist = 60000;
	var_00.red = 0.937662;
	var_00.green = 0.808827;
	var_00.blue = 0.755741;
	var_00.hdrcolorintensity = 13.5029;
	var_00.maxopacity = 0.8;
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
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.632813,0.664063,0.863912);
	var_00.atmosfoghazecolor = (0.273438,0.212994,0.184211);
	var_00.atmosfoghazestrength = 0.625;
	var_00.atmosfoghazespread = 0.03125;
	var_00.atmosfogextinctionstrength = 0.218894;
	var_00.atmosfoginscatterstrength = 17.2165;
	var_00.atmosfoghalfplanedistance = 559.826;
	var_00.atmosfogstartdistance = 786.628;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 40960;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 48;
	var_00.atmosfogskyfalloffanglerange = 234;
	var_00.atmosfogsundirection = (-0.697483,-0.70711,0.116246);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -2816;
	var_00.atmosfogheightfoghalfplanedistance = 1089;
}

//Function Number: 2
setupfog()
{
}
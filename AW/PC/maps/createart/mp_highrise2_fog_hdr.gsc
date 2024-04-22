/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_highrise2_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:06:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_highrise2");
	var_00.startdist = 512;
	var_00.halfwaydist = 40680;
	var_00.red = 0.235424;
	var_00.green = 0.287027;
	var_00.blue = 0.442895;
	var_00.hdrcolorintensity = 12.779;
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
	var_00.skyfogintensity = 0.585938;
	var_00.skyfogminangle = 80.4541;
	var_00.skyfogmaxangle = 84.0245;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.304688,0.343751,0.640625);
	var_00.atmosfoghazecolor = (0.210938,0.46875,0.53125);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.703125;
	var_00.atmosfogextinctionstrength = 0.59375;
	var_00.atmosfoginscatterstrength = 14;
	var_00.atmosfoghalfplanedistance = 31653.1;
	var_00.atmosfogstartdistance = 2229.18;
	var_00.atmosfogdistancescale = 1.4375;
	var_00.atmosfogskydistance = 172032;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.336212,0.0627645,0.939693);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_highrise2_cg");
	var_00.startdist = 2500;
	var_00.halfwaydist = 10000;
	var_00.red = 0.076557;
	var_00.green = 0.10521;
	var_00.blue = 0.174557;
	var_00.hdrcolorintensity = 15.3417;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 0;
	var_00.sunblue = 0;
	var_00.hdrsuncolorintensity = -5.75;
	var_00.sundir = (1,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 180;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.171875;
	var_00.skyfogminangle = 84;
	var_00.skyfogmaxangle = 92;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.304688,0.343751,0.640625);
	var_00.atmosfoghazecolor = (0.210938,0.46875,0.53125);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.703125;
	var_00.atmosfogextinctionstrength = 0.59375;
	var_00.atmosfoginscatterstrength = 14;
	var_00.atmosfoghalfplanedistance = 31653.1;
	var_00.atmosfogstartdistance = 2229.18;
	var_00.atmosfogdistancescale = 1.4375;
	var_00.atmosfogskydistance = 172032;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.336212,0.0627645,0.939693);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
}

//Function Number: 2
setupfog()
{
}
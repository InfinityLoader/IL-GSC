/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_perplex_1_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:06:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_perplex_1");
	var_00.startdist = 3764.17;
	var_00.halfwaydist = 64447;
	var_00.red = 0;
	var_00.green = 0;
	var_00.blue = 0;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0;
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
	var_00.atmosfogsunfogcolor = (0.469932,0.625251,0.83676);
	var_00.atmosfoghazecolor = (0.568226,0.671186,0.746161);
	var_00.atmosfoghazestrength = 0.577555;
	var_00.atmosfoghazespread = 0.795437;
	var_00.atmosfogextinctionstrength = 0.763293;
	var_00.atmosfoginscatterstrength = 18.5055;
	var_00.atmosfoghalfplanedistance = 178370;
	var_00.atmosfogstartdistance = 3842.45;
	var_00.atmosfogdistancescale = 4.95186;
	var_00.atmosfogskydistance = 9245;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -56.199;
	var_00.atmosfogskyfalloffanglerange = 216.127;
	var_00.atmosfogsundirection = (0.124871,0.989631,-0.0709827);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1341.25;
	var_00.atmosfogheightfoghalfplanedistance = 9224.48;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_perplex_1_cg");
	var_00.startdist = 8500;
	var_00.halfwaydist = 15000;
	var_00.red = 0.4;
	var_00.green = 0.51;
	var_00.blue = 0.721;
	var_00.hdrcolorintensity = 17.234;
	var_00.maxopacity = 0.98;
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
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.372977,0.470068,0.617505);
	var_00.atmosfoghazecolor = (0.535814,0.64177,0.747756);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.466405;
	var_00.atmosfogextinctionstrength = 0.418555;
	var_00.atmosfoginscatterstrength = 20.2722;
	var_00.atmosfoghalfplanedistance = 154105;
	var_00.atmosfogstartdistance = 12189;
	var_00.atmosfogdistancescale = 6.22972;
	var_00.atmosfogskydistance = 9245;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -56.199;
	var_00.atmosfogskyfalloffanglerange = 216.127;
	var_00.atmosfogsundirection = (0.124871,0.989631,-0.0709827);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = -3274.9;
	var_00.atmosfogheightfoghalfplanedistance = 2229.34;
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 2000000000;
	var_00.halfwaydist = 2000000001;
	var_00.red = 0;
	var_00.green = 0;
	var_00.blue = 0;
	var_00.hdrcolorintensity = 1;
	var_00.maxopacity = 0;
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
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.557561,0.671111,0.854297);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0;
	var_00.atmosfogextinctionstrength = 0.751259;
	var_00.atmosfoginscatterstrength = 15.5178;
	var_00.atmosfoghalfplanedistance = 96473.1;
	var_00.atmosfogstartdistance = 2395.82;
	var_00.atmosfogdistancescale = 3.3968;
	var_00.atmosfogskydistance = 33522;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -72.241;
	var_00.atmosfogskyfalloffanglerange = 113.177;
	var_00.atmosfogsundirection = (0.521951,0.633078,0.571646);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
}

//Function Number: 2
setupfog()
{
}
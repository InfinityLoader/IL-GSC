/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_levity_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:06:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 3764.17;
	var_00.halfwaydist = 19391;
	var_00.red = 1;
	var_00.green = 0.925269;
	var_00.blue = 0.847076;
	var_00.hdrcolorintensity = 12.2088;
	var_00.maxopacity = 0.7;
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
	var_00.atmosfogsunfogcolor = (0.589472,0.741909,0.976563);
	var_00.atmosfoghazecolor = (0.71582,0.828125,0.728939);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.875;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity");
	var_00.startdist = 2048;
	var_00.halfwaydist = 74632;
	var_00.red = 0.679688;
	var_00.green = 0.84375;
	var_00.blue = 0.960938;
	var_00.hdrcolorintensity = 16.5;
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
	var_00.skyfogintensity = 0.554688;
	var_00.skyfogminangle = 28;
	var_00.skyfogmaxangle = 138;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.589472,0.741909,0.976563);
	var_00.atmosfoghazecolor = (0.71582,0.828125,0.728939);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.875;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity_osp");
	var_00.startdist = 2048;
	var_00.halfwaydist = 74632;
	var_00.red = 0.679688;
	var_00.green = 0.84375;
	var_00.blue = 0.960938;
	var_00.hdrcolorintensity = 16.5;
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
	var_00.skyfogintensity = 0.554688;
	var_00.skyfogminangle = 28;
	var_00.skyfogmaxangle = 138;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.589472,0.741909,0.976563);
	var_00.atmosfoghazecolor = (0.71582,0.828125,0.728939);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.875;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity_warbird");
	var_00.startdist = 2048;
	var_00.halfwaydist = 74632;
	var_00.red = 0.679688;
	var_00.green = 0.84375;
	var_00.blue = 0.960938;
	var_00.hdrcolorintensity = 16.5;
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
	var_00.skyfogintensity = 0.554688;
	var_00.skyfogminangle = 28;
	var_00.skyfogmaxangle = 138;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.589472,0.741909,0.976563);
	var_00.atmosfoghazecolor = (0.71582,0.828125,0.728939);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.875;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity_drone");
	var_00.startdist = 2048;
	var_00.halfwaydist = 74632;
	var_00.red = 0.679688;
	var_00.green = 0.84375;
	var_00.blue = 0.960938;
	var_00.hdrcolorintensity = 16.5;
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
	var_00.skyfogintensity = 0.554688;
	var_00.skyfogminangle = 28;
	var_00.skyfogmaxangle = 138;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.589472,0.741909,0.976563);
	var_00.atmosfoghazecolor = (0.71582,0.828125,0.728939);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.875;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity_int");
	var_00.startdist = 2048;
	var_00.halfwaydist = 74632;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 16.5;
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
	var_00.skyfogintensity = 0.554688;
	var_00.skyfogminangle = 28;
	var_00.skyfogmaxangle = 138;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.46875;
	var_00.atmosfogextinctionstrength = 0.976563;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 82824;
	var_00.atmosfogstartdistance = 1115.96;
	var_00.atmosfogdistancescale = 1.8;
	var_00.atmosfogskydistance = 34464;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.623563,-0.230032,0.747164);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 2304;
	var_00.atmosfogheightfoghalfplanedistance = 833;
	var_00 = maps\mp\_art::create_vision_set_fog("dna_bomb");
	var_00.startdist = 670.438;
	var_00.halfwaydist = 2489.07;
	var_00.red = 0.802175;
	var_00.green = 0.697121;
	var_00.blue = 0.750972;
	var_00.hdrcolorintensity = 10.5;
	var_00.maxopacity = 0.649765;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0;
	var_00.sunblue = 0;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (-0.273734,-0.956553,-0.100377);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 180;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.484637,0.920391,0.255807);
	var_00.atmosfoghazecolor = (1,0.778993,0.417681);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0322783;
	var_00.atmosfogextinctionstrength = 0.916667;
	var_00.atmosfoginscatterstrength = 19.5137;
	var_00.atmosfoghalfplanedistance = 1640.34;
	var_00.atmosfogstartdistance = 71.7805;
	var_00.atmosfogdistancescale = 9.42623;
	var_00.atmosfogskydistance = 24590;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -8;
	var_00.atmosfogskyfalloffanglerange = 0;
	var_00.atmosfogsundirection = (-0.474168,-0.865133,0.163429);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 293.646;
	var_00.atmosfogheightfoghalfplanedistance = 1471.65;
	var_00 = maps\mp\_art::create_vision_set_fog("dna_bomb_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 1232.4;
	var_00.red = 0.563022;
	var_00.green = 0.920391;
	var_00.blue = 0.375355;
	var_00.hdrcolorintensity = 15.9699;
	var_00.maxopacity = 0.870537;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.291899;
	var_00.sungreen = 0.435754;
	var_00.sunblue = 0.1819;
	var_00.hdrsuncolorintensity = 16.6475;
	var_00.sundir = (-0.546391,-0.14727,0.824481);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 36.694;
	var_00.normalfogscale = 2.78604;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.484637,0.920391,0.255807);
	var_00.atmosfoghazecolor = (1,0.778993,0.417681);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0322783;
	var_00.atmosfogextinctionstrength = 0.916667;
	var_00.atmosfoginscatterstrength = 16.3525;
	var_00.atmosfoghalfplanedistance = 1640.34;
	var_00.atmosfogstartdistance = 71.7805;
	var_00.atmosfogdistancescale = 9.42623;
	var_00.atmosfogskydistance = 24590;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -8;
	var_00.atmosfogskyfalloffanglerange = 0;
	var_00.atmosfogsundirection = (-0.474168,-0.865133,0.163429);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 293.646;
	var_00.atmosfogheightfoghalfplanedistance = 1471.65;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_levity_cg");
	var_00.startdist = 5913.09;
	var_00.halfwaydist = 5838.19;
	var_00.red = 0.595624;
	var_00.green = 0.802827;
	var_00.blue = 0.914234;
	var_00.hdrcolorintensity = 14.7868;
	var_00.maxopacity = 0.52563;
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
	var_00.atmosfogsunfogcolor = (0.5,0.5,0.5);
	var_00.atmosfoghazecolor = (0.5,0.5,0.5);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.75;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 0;
	var_00.atmosfoghalfplanedistance = 5000;
	var_00.atmosfogstartdistance = 0;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0,0,1);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
}

//Function Number: 2
setupfog()
{
}
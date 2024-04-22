/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_urban_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:07:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_urban");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 9.27271;
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
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0.15625;
	var_00.atmosfoghazespread = 0.304688;
	var_00.atmosfogextinctionstrength = 0.867188;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 8232.1;
	var_00.atmosfogstartdistance = 619.551;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0650701,0.893814,0.443693);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1664;
	var_00.atmosfogheightfoghalfplanedistance = 1896;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_urban_cg");
	var_00.startdist = 593.954;
	var_00.halfwaydist = 10106.9;
	var_00.red = 0.854913;
	var_00.green = 0.903469;
	var_00.blue = 0.954951;
	var_00.hdrcolorintensity = 11.2892;
	var_00.maxopacity = 0.151804;
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
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0.15625;
	var_00.atmosfoghazespread = 0.304688;
	var_00.atmosfogextinctionstrength = 0.867188;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 8232.1;
	var_00.atmosfogstartdistance = 619.551;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0650701,0.893814,0.443693);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1664;
	var_00.atmosfogheightfoghalfplanedistance = 1896;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_urban_osp");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 9.27271;
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
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0.15625;
	var_00.atmosfoghazespread = 0.304688;
	var_00.atmosfogextinctionstrength = 0.867188;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 8232.1;
	var_00.atmosfogstartdistance = 619.551;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0650701,0.893814,0.443693);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1664;
	var_00.atmosfogheightfoghalfplanedistance = 1896;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_urban_drone");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 9.27271;
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
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0.15625;
	var_00.atmosfoghazespread = 0.304688;
	var_00.atmosfogextinctionstrength = 0.867188;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 8232.1;
	var_00.atmosfogstartdistance = 619.551;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0650701,0.893814,0.443693);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1664;
	var_00.atmosfogheightfoghalfplanedistance = 1896;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_urban_warbird");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 9.27271;
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
	var_00.atmosfogsunfogcolor = (1,1,1);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0.15625;
	var_00.atmosfoghazespread = 0.304688;
	var_00.atmosfogextinctionstrength = 0.867188;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 8232.1;
	var_00.atmosfogstartdistance = 619.551;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0650701,0.893814,0.443693);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1664;
	var_00.atmosfogheightfoghalfplanedistance = 1896;
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
	var_00.atmosfogsunfogcolor = (0.03125,1,0.03125);
	var_00.atmosfoghazecolor = (0.0625,1,0.0625);
	var_00.atmosfoghazestrength = 0.429688;
	var_00.atmosfoghazespread = 0.664063;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 17.3333;
	var_00.atmosfoghalfplanedistance = 43.699;
	var_00.atmosfogstartdistance = 24;
	var_00.atmosfogdistancescale = 0.4375;
	var_00.atmosfogskydistance = 294912;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 39;
	var_00.atmosfogskyfalloffanglerange = 300;
	var_00.atmosfogsundirection = (-0.237131,0.864942,0.442317);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1.48761;
	var_00.atmosfogheightfoghalfplanedistance = 351.288;
	var_00 = maps\mp\_art::create_vision_set_fog("dna_bomb_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 786.324;
	var_00.red = 0.563022;
	var_00.green = 0.920391;
	var_00.blue = 0.375355;
	var_00.hdrcolorintensity = 15.2199;
	var_00.maxopacity = 0.870537;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 0;
	var_00.sunblue = 0;
	var_00.hdrsuncolorintensity = 1;
	var_00.sundir = (-0.273734,-0.956553,-0.100377);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 180;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 1;
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
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 3764.17;
	var_00.halfwaydist = 19391;
	var_00.red = 1;
	var_00.green = 0.925269;
	var_00.blue = 0.847076;
	var_00.hdrcolorintensity = 9.45248;
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
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_detroit_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:06:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit");
	var_00.startdist = 635;
	var_00.halfwaydist = 87700;
	var_00.red = 1;
	var_00.green = 0.872;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 14.75;
	var_00.maxopacity = 0.1;
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
	var_00.atmosfogsunfogcolor = (0.875,0.828126,0.78125);
	var_00.atmosfoghazecolor = (0.851,0.781,0.603);
	var_00.atmosfoghazestrength = 0.18;
	var_00.atmosfoghazespread = 0.004;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 14.5123;
	var_00.atmosfoghalfplanedistance = 18293;
	var_00.atmosfogstartdistance = 1108.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 8192;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.424507,-0.862204,0.276401);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 474.857;
	var_00.atmosfogheightfoghalfplanedistance = 9190.17;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit_cg");
	var_00.startdist = 372.392;
	var_00.halfwaydist = 5144.82;
	var_00.red = 0.253603;
	var_00.green = 0.278088;
	var_00.blue = 0.332763;
	var_00.hdrcolorintensity = 13.3262;
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
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.5,0.5,0.5);
	var_00.atmosfoghazecolor = (0.5,0.5,0.5);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.25;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit_water");
	var_00.startdist = 0;
	var_00.halfwaydist = 70;
	var_00.red = 0.0760404;
	var_00.green = 0.0357562;
	var_00.blue = 0.0189094;
	var_00.hdrcolorintensity = 17.5;
	var_00.maxopacity = 0.8;
	var_00.transitiontime = 0.05;
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
	var_00.atmosfogsunfogcolor = (0.875,0.828126,0.78125);
	var_00.atmosfoghazecolor = (0.851,0.781,0.603);
	var_00.atmosfoghazestrength = 0.18;
	var_00.atmosfoghazespread = 0.004;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 14.5123;
	var_00.atmosfoghalfplanedistance = 18293;
	var_00.atmosfogstartdistance = 1108.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 8192;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.424507,-0.862204,0.276401);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 474.857;
	var_00.atmosfogheightfoghalfplanedistance = 9190.17;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit_osp");
	var_00.startdist = 635;
	var_00.halfwaydist = 87700;
	var_00.red = 1;
	var_00.green = 0.872;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 14.75;
	var_00.maxopacity = 0.1;
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
	var_00.atmosfogsunfogcolor = (0.875,0.828126,0.78125);
	var_00.atmosfoghazecolor = (0.851,0.781,0.603);
	var_00.atmosfoghazestrength = 0.18;
	var_00.atmosfoghazespread = 0.004;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 14.5123;
	var_00.atmosfoghalfplanedistance = 18293;
	var_00.atmosfogstartdistance = 1108.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 8192;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.424507,-0.862204,0.276401);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 474.857;
	var_00.atmosfogheightfoghalfplanedistance = 9190.17;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit_drone");
	var_00.startdist = 635;
	var_00.halfwaydist = 87700;
	var_00.red = 1;
	var_00.green = 0.872;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 14.75;
	var_00.maxopacity = 0.1;
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
	var_00.atmosfogsunfogcolor = (0.875,0.828126,0.78125);
	var_00.atmosfoghazecolor = (0.851,0.781,0.603);
	var_00.atmosfoghazestrength = 0.18;
	var_00.atmosfoghazespread = 0.004;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 14.5123;
	var_00.atmosfoghalfplanedistance = 18293;
	var_00.atmosfogstartdistance = 1108.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 8192;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.424507,-0.862204,0.276401);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 474.857;
	var_00.atmosfogheightfoghalfplanedistance = 9190.17;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_detroit_warbird");
	var_00.startdist = 635;
	var_00.halfwaydist = 87700;
	var_00.red = 1;
	var_00.green = 0.872;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 14.75;
	var_00.maxopacity = 0.1;
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
	var_00.atmosfogsunfogcolor = (0.875,0.828126,0.78125);
	var_00.atmosfoghazecolor = (0.851,0.781,0.603);
	var_00.atmosfoghazestrength = 0.18;
	var_00.atmosfoghazespread = 0.004;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 14.5123;
	var_00.atmosfoghalfplanedistance = 18293;
	var_00.atmosfogstartdistance = 1108.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 8192;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.424507,-0.862204,0.276401);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 474.857;
	var_00.atmosfogheightfoghalfplanedistance = 9190.17;
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
}

//Function Number: 2
setupfog()
{
}
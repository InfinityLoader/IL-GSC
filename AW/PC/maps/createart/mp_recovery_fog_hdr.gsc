/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_recovery_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:07:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery");
	var_00.startdist = 8574.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.542536,0.728916,0.984167);
	var_00.atmosfoghazecolor = (0.481452,0.68751,0.858319);
	var_00.atmosfoghazestrength = 0.306074;
	var_00.atmosfoghazespread = 0.48213;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.8513;
	var_00.atmosfoghalfplanedistance = 185733;
	var_00.atmosfogstartdistance = 8537.85;
	var_00.atmosfogdistancescale = 4.98959;
	var_00.atmosfogskydistance = 4503;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -49.767;
	var_00.atmosfogskyfalloffanglerange = 61.9999;
	var_00.atmosfogsundirection = (0.0906647,-0.170486,0.98118);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -4383.85;
	var_00.atmosfogheightfoghalfplanedistance = 2590.56;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery_b");
	var_00.startdist = 9086.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.151062,0.306365,0.500976);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0399045;
	var_00.atmosfogextinctionstrength = 0.630971;
	var_00.atmosfoginscatterstrength = 18.1648;
	var_00.atmosfoghalfplanedistance = 18395.9;
	var_00.atmosfogstartdistance = 3321.11;
	var_00.atmosfogdistancescale = 2.29389;
	var_00.atmosfogskydistance = 79135;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -48.3518;
	var_00.atmosfogskyfalloffanglerange = 158.55;
	var_00.atmosfogsundirection = (0.751941,0.583464,0.306846);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4054.98;
	var_00.atmosfogheightfoghalfplanedistance = 3749.81;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery_post");
	var_00.startdist = 9086.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.82093,0.807553,0.619587);
	var_00.atmosfoghazecolor = (0.54891,0.546546,0.250224);
	var_00.atmosfoghazestrength = 0.468297;
	var_00.atmosfoghazespread = 0.035982;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 23.7;
	var_00.atmosfoghalfplanedistance = 96562.1;
	var_00.atmosfogstartdistance = 241.803;
	var_00.atmosfogdistancescale = 0.461619;
	var_00.atmosfogskydistance = 128751;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -82.4759;
	var_00.atmosfogskyfalloffanglerange = 213.773;
	var_00.atmosfogsundirection = (0.705549,0.543144,0.455188);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -2853.48;
	var_00.atmosfogheightfoghalfplanedistance = 1029.03;
	var_00 = maps\mp\_art::create_vision_set_fog("poison_gas");
	var_00.startdist = 0;
	var_00.halfwaydist = 2049;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
	var_00.maxopacity = 0.375;
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
	var_00.atmosfogsunfogcolor = (0.401493,0.727799,0.374929);
	var_00.atmosfoghazecolor = (0.380729,0.469112,0.320673);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.587452;
	var_00.atmosfogextinctionstrength = 0.708175;
	var_00.atmosfoginscatterstrength = 15.6236;
	var_00.atmosfoghalfplanedistance = 286.17;
	var_00.atmosfogstartdistance = 248.099;
	var_00.atmosfogdistancescale = 2.96578;
	var_00.atmosfogskydistance = 153992;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -2.43056;
	var_00.atmosfogskyfalloffanglerange = 71.8547;
	var_00.atmosfogsundirection = (0.881182,0.272293,0.386489);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 3536.6;
	var_00.atmosfogheightfoghalfplanedistance = 6329.3;
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
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0322783;
	var_00.atmosfogextinctionstrength = 0.916667;
	var_00.atmosfoginscatterstrength = 19.306;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery_cg");
	var_00.startdist = 9086.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.630515,0.844624,0.980895);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0399045;
	var_00.atmosfogextinctionstrength = 0.681299;
	var_00.atmosfoginscatterstrength = 19.3113;
	var_00.atmosfoghalfplanedistance = 102590;
	var_00.atmosfogstartdistance = 25793.2;
	var_00.atmosfogdistancescale = 1.21885;
	var_00.atmosfogskydistance = 133021;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -3.02394;
	var_00.atmosfogskyfalloffanglerange = 12;
	var_00.atmosfogsundirection = (0.751941,0.583464,0.306846);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4054.98;
	var_00.atmosfogheightfoghalfplanedistance = 3749.81;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery_b_cg");
	var_00.startdist = 9086.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.630515,0.844624,0.980895);
	var_00.atmosfoghazecolor = (1,1,1);
	var_00.atmosfoghazestrength = 0;
	var_00.atmosfoghazespread = 0.0399045;
	var_00.atmosfogextinctionstrength = 0.681299;
	var_00.atmosfoginscatterstrength = 19.3113;
	var_00.atmosfoghalfplanedistance = 102590;
	var_00.atmosfogstartdistance = 25793.2;
	var_00.atmosfogdistancescale = 1.21885;
	var_00.atmosfogskydistance = 133021;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -3.02394;
	var_00.atmosfogskyfalloffanglerange = 12;
	var_00.atmosfogsundirection = (0.751941,0.583464,0.306846);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4054.98;
	var_00.atmosfogheightfoghalfplanedistance = 3749.81;
	var_00 = maps\mp\_art::create_vision_set_fog("poison_gas_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 2049;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
	var_00.maxopacity = 0.375;
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
	var_00.atmosfogsunfogcolor = (0.401493,0.727799,0.374929);
	var_00.atmosfoghazecolor = (0.380729,0.469112,0.320673);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.587452;
	var_00.atmosfogextinctionstrength = 0.708175;
	var_00.atmosfoginscatterstrength = 15.6236;
	var_00.atmosfoghalfplanedistance = 286.17;
	var_00.atmosfogstartdistance = 248.099;
	var_00.atmosfogdistancescale = 2.96578;
	var_00.atmosfogskydistance = 153992;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -2.43056;
	var_00.atmosfogskyfalloffanglerange = 71.8547;
	var_00.atmosfogsundirection = (0.881182,0.272293,0.386489);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 3536.6;
	var_00.atmosfogheightfoghalfplanedistance = 6329.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_recovery_post_cg");
	var_00.startdist = 9086.61;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 16.1053;
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
	var_00.atmosfogsunfogcolor = (0.82093,0.807553,0.619587);
	var_00.atmosfoghazecolor = (0.54891,0.546546,0.250224);
	var_00.atmosfoghazestrength = 0.468297;
	var_00.atmosfoghazespread = 0.035982;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 23.7;
	var_00.atmosfoghalfplanedistance = 96562.1;
	var_00.atmosfogstartdistance = -1000;
	var_00.atmosfogdistancescale = 0.461619;
	var_00.atmosfogskydistance = 128751;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -82.4759;
	var_00.atmosfogskyfalloffanglerange = 213.773;
	var_00.atmosfogsundirection = (0.705549,0.543144,0.455188);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -2853.48;
	var_00.atmosfogheightfoghalfplanedistance = 1029.03;
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
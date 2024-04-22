/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_laser2_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 152 ms
 * Timestamp: 4/22/2024 2:06:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2");
	var_00.startdist = 2825.95;
	var_00.halfwaydist = 8727.52;
	var_00.red = 0.87037;
	var_00.green = 0.923157;
	var_00.blue = 0.975854;
	var_00.hdrcolorintensity = 15.75;
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
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.53205,0.649501,0.82051);
	var_00.atmosfoghazecolor = (1,0.98318,0.961183);
	var_00.atmosfoghazestrength = 0.156844;
	var_00.atmosfoghazespread = 0.0465312;
	var_00.atmosfogextinctionstrength = 0.865019;
	var_00.atmosfoginscatterstrength = 19.5247;
	var_00.atmosfoghalfplanedistance = 35932.4;
	var_00.atmosfogstartdistance = 20409.7;
	var_00.atmosfogdistancescale = 4.58162;
	var_00.atmosfogskydistance = 37357;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 7.41976;
	var_00.atmosfogskyfalloffanglerange = 128.58;
	var_00.atmosfogsundirection = (0.679888,-0.536065,0.500387);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 704.352;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_interior");
	var_00.startdist = 2026.34;
	var_00.halfwaydist = 33123.1;
	var_00.red = 0.87037;
	var_00.green = 0.923157;
	var_00.blue = 0.975854;
	var_00.hdrcolorintensity = 16.4021;
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
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.891419,0.891419,0.891419);
	var_00.atmosfoghazecolor = (0.955511,0.955511,0.955511);
	var_00.atmosfoghazestrength = 0.118191;
	var_00.atmosfoghazespread = 0.362051;
	var_00.atmosfogextinctionstrength = 0.729523;
	var_00.atmosfoginscatterstrength = 18.8722;
	var_00.atmosfoghalfplanedistance = 130783;
	var_00.atmosfogstartdistance = 3207.66;
	var_00.atmosfogdistancescale = 5.31526;
	var_00.atmosfogskydistance = 225543;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -54.0513;
	var_00.atmosfogskyfalloffanglerange = 160.871;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("generic_underwater");
	var_00.startdist = 5;
	var_00.halfwaydist = 200;
	var_00.red = 0.74661;
	var_00.green = 0.999995;
	var_00.blue = 0.87276;
	var_00.hdrcolorintensity = 13.3491;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.891419,0.891419,0.891419);
	var_00.atmosfoghazecolor = (0.955511,0.955511,0.955511);
	var_00.atmosfoghazestrength = 0.28436;
	var_00.atmosfoghazespread = 0.362051;
	var_00.atmosfogextinctionstrength = 0.786086;
	var_00.atmosfoginscatterstrength = 18.8627;
	var_00.atmosfoghalfplanedistance = 67166.8;
	var_00.atmosfogstartdistance = 4764.43;
	var_00.atmosfogdistancescale = 8.98823;
	var_00.atmosfogskydistance = 30000;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -30.5422;
	var_00.atmosfogskyfalloffanglerange = 77.2588;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_mid");
	var_00.startdist = 6028.39;
	var_00.halfwaydist = 114845;
	var_00.red = 0.87037;
	var_00.green = 0.923157;
	var_00.blue = 0.975854;
	var_00.hdrcolorintensity = 20.1906;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.950023,0.968949,0.930216);
	var_00.atmosfoghazecolor = (0.64108,0.717447,0.730207);
	var_00.atmosfoghazestrength = 0.0307251;
	var_00.atmosfoghazespread = 0.136874;
	var_00.atmosfogextinctionstrength = 0.848469;
	var_00.atmosfoginscatterstrength = 19.1952;
	var_00.atmosfoghalfplanedistance = 107494;
	var_00.atmosfogstartdistance = 4744.23;
	var_00.atmosfogdistancescale = 6.61407;
	var_00.atmosfogskydistance = 799234;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 5.53519;
	var_00.atmosfogskyfalloffanglerange = 698.214;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_osp");
	var_00.startdist = 1392.68;
	var_00.halfwaydist = 8727.52;
	var_00.red = 0.87037;
	var_00.green = 0.923157;
	var_00.blue = 0.975854;
	var_00.hdrcolorintensity = 20.1906;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.961025,0.958042,0.913618);
	var_00.atmosfoghazecolor = (0.730207,0.693009,0.658697);
	var_00.atmosfoghazestrength = 0.00924057;
	var_00.atmosfoghazespread = 0.08535;
	var_00.atmosfogextinctionstrength = 0.725779;
	var_00.atmosfoginscatterstrength = 17.8445;
	var_00.atmosfoghalfplanedistance = 129236;
	var_00.atmosfogstartdistance = 6773.61;
	var_00.atmosfogdistancescale = 9.2114;
	var_00.atmosfogskydistance = 516977;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 5.53519;
	var_00.atmosfogskyfalloffanglerange = 348.597;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
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
	var_00.atmosfoginscatterstrength = 17.3333;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_cg");
	var_00.startdist = 1000;
	var_00.halfwaydist = 80000;
	var_00.red = 0.882353;
	var_00.green = 0.92549;
	var_00.blue = 0.94902;
	var_00.hdrcolorintensity = 15.7643;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.961025,0.939155,0.918061);
	var_00.atmosfoghazecolor = (0.854635,0.843753,0.833715);
	var_00.atmosfoghazestrength = 0.0733538;
	var_00.atmosfoghazespread = 0.00338919;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 19.4243;
	var_00.atmosfoghalfplanedistance = 177384;
	var_00.atmosfogstartdistance = 5096.75;
	var_00.atmosfogdistancescale = 9.15421;
	var_00.atmosfogskydistance = 263993;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -82.1234;
	var_00.atmosfogskyfalloffanglerange = 38.0611;
	var_00.atmosfogsundirection = (0.792736,-0.211463,0.571711);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_interior_cg");
	var_00.startdist = 1000;
	var_00.halfwaydist = 80000;
	var_00.red = 0.882353;
	var_00.green = 0.92549;
	var_00.blue = 0.94902;
	var_00.hdrcolorintensity = 15.7643;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.961025,0.939155,0.918061);
	var_00.atmosfoghazecolor = (0.854635,0.843753,0.833715);
	var_00.atmosfoghazestrength = 0.0733538;
	var_00.atmosfoghazespread = 0.00338919;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 19.4243;
	var_00.atmosfoghalfplanedistance = 177384;
	var_00.atmosfogstartdistance = 5096.75;
	var_00.atmosfogdistancescale = 9.15421;
	var_00.atmosfogskydistance = 263993;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -82.1234;
	var_00.atmosfogskyfalloffanglerange = 38.0611;
	var_00.atmosfogsundirection = (0.792736,-0.211463,0.571711);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("generic_underwater_cg");
	var_00.startdist = 5;
	var_00.halfwaydist = 200;
	var_00.red = 0.74661;
	var_00.green = 0.999995;
	var_00.blue = 0.87276;
	var_00.hdrcolorintensity = 13.3491;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.891419,0.891419,0.891419);
	var_00.atmosfoghazecolor = (0.955511,0.955511,0.955511);
	var_00.atmosfoghazestrength = 0.28436;
	var_00.atmosfoghazespread = 0.362051;
	var_00.atmosfogextinctionstrength = 0.786086;
	var_00.atmosfoginscatterstrength = 18.8627;
	var_00.atmosfoghalfplanedistance = 67166.8;
	var_00.atmosfogstartdistance = 4764.43;
	var_00.atmosfogdistancescale = 8.98823;
	var_00.atmosfogskydistance = 30000;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -30.5422;
	var_00.atmosfogskyfalloffanglerange = 77.2588;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_mid_cg");
	var_00.startdist = 1000;
	var_00.halfwaydist = 80000;
	var_00.red = 0.882353;
	var_00.green = 0.92549;
	var_00.blue = 0.94902;
	var_00.hdrcolorintensity = 15.7643;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.961025,0.939155,0.918061);
	var_00.atmosfoghazecolor = (0.854635,0.843753,0.833715);
	var_00.atmosfoghazestrength = 0.0733538;
	var_00.atmosfoghazespread = 0.00338919;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 19.4243;
	var_00.atmosfoghalfplanedistance = 177384;
	var_00.atmosfogstartdistance = 5096.75;
	var_00.atmosfogdistancescale = 9.15421;
	var_00.atmosfogskydistance = 263993;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = -82.1234;
	var_00.atmosfogskyfalloffanglerange = 38.0611;
	var_00.atmosfogsundirection = (0.792736,-0.211463,0.571711);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_laser2_osp_cg");
	var_00.startdist = 1392.68;
	var_00.halfwaydist = 8727.52;
	var_00.red = 0.87037;
	var_00.green = 0.923157;
	var_00.blue = 0.975854;
	var_00.hdrcolorintensity = 20.1906;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.961025,0.958042,0.913618);
	var_00.atmosfoghazecolor = (0.730207,0.693009,0.658697);
	var_00.atmosfoghazestrength = 0.00924057;
	var_00.atmosfoghazespread = 0.08535;
	var_00.atmosfogextinctionstrength = 0.725779;
	var_00.atmosfoginscatterstrength = 17.8445;
	var_00.atmosfoghalfplanedistance = 129236;
	var_00.atmosfogstartdistance = 6773.61;
	var_00.atmosfogdistancescale = 9.2114;
	var_00.atmosfogskydistance = 516977;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 5.53519;
	var_00.atmosfogskyfalloffanglerange = 348.597;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
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
	var_00.sunred = 0.584985;
	var_00.sungreen = 0.601561;
	var_00.sunblue = 0.420894;
	var_00.hdrsuncolorintensity = 13.249;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 150;
	var_00.normalfogscale = 0.125;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.891419,0.891419,0.891419);
	var_00.atmosfoghazecolor = (0.955511,0.955511,0.955511);
	var_00.atmosfoghazestrength = 0.28436;
	var_00.atmosfoghazespread = 0.362051;
	var_00.atmosfogextinctionstrength = 0.786086;
	var_00.atmosfoginscatterstrength = 18.8627;
	var_00.atmosfoghalfplanedistance = 67166.8;
	var_00.atmosfogstartdistance = 431.43;
	var_00.atmosfogdistancescale = 8.98823;
	var_00.atmosfogskydistance = 30000;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -30.5422;
	var_00.atmosfogskyfalloffanglerange = 77.2588;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
}

//Function Number: 2
setupfog()
{
}
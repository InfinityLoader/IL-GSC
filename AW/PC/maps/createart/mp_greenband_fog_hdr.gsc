/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_greenband_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 2:06:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 4218.91;
	var_00.halfwaydist = 44312.4;
	var_00.red = 0.974245;
	var_00.green = 0.985384;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 8.99603;
	var_00.maxopacity = 0.804817;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.744535,0.917258,0.840571);
	var_00.atmosfoghazecolor = (0.597675,0.82608,1);
	var_00.atmosfoghazestrength = 0.0597306;
	var_00.atmosfoghazespread = 0.0342385;
	var_00.atmosfogextinctionstrength = 0.129979;
	var_00.atmosfoginscatterstrength = 20.95;
	var_00.atmosfoghalfplanedistance = 36369.3;
	var_00.atmosfogstartdistance = 359.882;
	var_00.atmosfogdistancescale = 0.942111;
	var_00.atmosfogskydistance = 114206;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -8.08144;
	var_00.atmosfogskyfalloffanglerange = 40.7857;
	var_00.atmosfogsundirection = (0.34768,0.935352,0.0650736);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = -8409.9;
	var_00.atmosfogheightfoghalfplanedistance = 5433.97;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband");
	var_00.startdist = 4218.91;
	var_00.halfwaydist = 44312.4;
	var_00.red = 0.974245;
	var_00.green = 0.985384;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 8.99603;
	var_00.maxopacity = 0.804817;
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
	var_00.atmosfogsunfogcolor = (0.839182,0.917799,1);
	var_00.atmosfoghazecolor = (0.437488,0.396474,0.365713);
	var_00.atmosfoghazestrength = 0.184731;
	var_00.atmosfoghazespread = 0.0342385;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.6692;
	var_00.atmosfoghalfplanedistance = 4062.13;
	var_00.atmosfogstartdistance = 330.485;
	var_00.atmosfogdistancescale = 0.178651;
	var_00.atmosfogskydistance = 114206;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -35.0835;
	var_00.atmosfogskyfalloffanglerange = 439.952;
	var_00.atmosfogsundirection = (0.713151,0.501338,0.489976);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -1370.37;
	var_00.atmosfogheightfoghalfplanedistance = 1209.94;
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
	var_00.atmosfoginscatterstrength = 18.3197;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_cg");
	var_00.startdist = 539.329;
	var_00.halfwaydist = 19351.3;
	var_00.red = 0.942224;
	var_00.green = 0.900525;
	var_00.blue = 0.819773;
	var_00.hdrcolorintensity = 12.6121;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = -90;
	var_00.skyfogmaxangle = -90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.304083,0.362307,0.414063);
	var_00.atmosfoghazecolor = (0.523362,0.417289,0.265773);
	var_00.atmosfoghazestrength = 0.078122;
	var_00.atmosfoghazespread = 0.0234375;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 15.5;
	var_00.atmosfoghalfplanedistance = 949.531;
	var_00.atmosfogstartdistance = 990.194;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100107;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 4.9961;
	var_00.atmosfogskyfalloffanglerange = 42;
	var_00.atmosfogsundirection = (0.540978,0.823536,0.170678);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1023.66;
	var_00.atmosfogheightfoghalfplanedistance = 897;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_patio_cg");
	var_00.startdist = 539.329;
	var_00.halfwaydist = 19351.3;
	var_00.red = 0.942224;
	var_00.green = 0.900525;
	var_00.blue = 0.819773;
	var_00.hdrcolorintensity = 12.6121;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = -90;
	var_00.skyfogmaxangle = -90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.304083,0.362307,0.414063);
	var_00.atmosfoghazecolor = (0.523362,0.417289,0.265773);
	var_00.atmosfoghazestrength = 0.078122;
	var_00.atmosfoghazespread = 0.0234375;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 15.5;
	var_00.atmosfoghalfplanedistance = 949.531;
	var_00.atmosfogstartdistance = 990.194;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100107;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 4.9961;
	var_00.atmosfogskyfalloffanglerange = 42;
	var_00.atmosfogsundirection = (0.540978,0.823536,0.170678);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1023.66;
	var_00.atmosfogheightfoghalfplanedistance = 897;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_patio");
	var_00.startdist = 3764.17;
	var_00.halfwaydist = 19391;
	var_00.red = 1;
	var_00.green = 0.925269;
	var_00.blue = 0.847076;
	var_00.hdrcolorintensity = 12.2088;
	var_00.maxopacity = 0.7;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = -90;
	var_00.skyfogmaxangle = -90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.304083,0.362307,0.414063);
	var_00.atmosfoghazecolor = (0.523362,0.417289,0.265773);
	var_00.atmosfoghazestrength = 0.078122;
	var_00.atmosfoghazespread = 0.0234375;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 15.5;
	var_00.atmosfoghalfplanedistance = 949.531;
	var_00.atmosfogstartdistance = 990.194;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100107;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 4.9961;
	var_00.atmosfogskyfalloffanglerange = 42;
	var_00.atmosfogsundirection = (0.540978,0.823536,0.170678);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1023.66;
	var_00.atmosfogheightfoghalfplanedistance = 897;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_indoor");
	var_00.startdist = 5120;
	var_00.halfwaydist = 22529;
	var_00.red = 0.783203;
	var_00.green = 0.90828;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 13;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = -90;
	var_00.skyfogmaxangle = -90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.304083,0.362307,0.414063);
	var_00.atmosfoghazecolor = (0.523362,0.417289,0.265773);
	var_00.atmosfoghazestrength = 0.078122;
	var_00.atmosfoghazespread = 0.0234375;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 15.5;
	var_00.atmosfoghalfplanedistance = 949.531;
	var_00.atmosfogstartdistance = 990.194;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100107;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 4.9961;
	var_00.atmosfogskyfalloffanglerange = 42;
	var_00.atmosfogsundirection = (0.540978,0.823536,0.170678);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1023.66;
	var_00.atmosfogheightfoghalfplanedistance = 897;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_indoor_cg");
	var_00.startdist = 539.329;
	var_00.halfwaydist = 19351.3;
	var_00.red = 0.942224;
	var_00.green = 0.900525;
	var_00.blue = 0.819773;
	var_00.hdrcolorintensity = 12.6121;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 0.829919;
	var_00.sunblue = 0.649238;
	var_00.hdrsuncolorintensity = 13;
	var_00.sundir = (0.078125,0.078125,-1);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 133;
	var_00.normalfogscale = 10;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = -90;
	var_00.skyfogmaxangle = -90;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.304083,0.362307,0.414063);
	var_00.atmosfoghazecolor = (0.523362,0.417289,0.265773);
	var_00.atmosfoghazestrength = 0.078122;
	var_00.atmosfoghazespread = 0.0234375;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 15.5;
	var_00.atmosfoghalfplanedistance = 949.531;
	var_00.atmosfogstartdistance = 990.194;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100107;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 4.9961;
	var_00.atmosfogskyfalloffanglerange = 42;
	var_00.atmosfogsundirection = (0.540978,0.823536,0.170678);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 1023.66;
	var_00.atmosfogheightfoghalfplanedistance = 897;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_osp");
	var_00.startdist = 4218.91;
	var_00.halfwaydist = 44312.4;
	var_00.red = 0.974245;
	var_00.green = 0.985384;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 8.99603;
	var_00.maxopacity = 0.804817;
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
	var_00.atmosfogsunfogcolor = (0.839182,0.917799,1);
	var_00.atmosfoghazecolor = (0.437488,0.396474,0.365713);
	var_00.atmosfoghazestrength = 0.184731;
	var_00.atmosfoghazespread = 0.0342385;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.6692;
	var_00.atmosfoghalfplanedistance = 4062.13;
	var_00.atmosfogstartdistance = 330.485;
	var_00.atmosfogdistancescale = 0.178651;
	var_00.atmosfogskydistance = 114206;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -35.0835;
	var_00.atmosfogskyfalloffanglerange = 439.952;
	var_00.atmosfogsundirection = (0.713151,0.501338,0.489976);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -1370.37;
	var_00.atmosfogheightfoghalfplanedistance = 1209.94;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_drone");
	var_00.startdist = 4218.91;
	var_00.halfwaydist = 44312.4;
	var_00.red = 0.974245;
	var_00.green = 0.985384;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 8.99603;
	var_00.maxopacity = 0.804817;
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
	var_00.atmosfogsunfogcolor = (0.839182,0.917799,1);
	var_00.atmosfoghazecolor = (0.437488,0.396474,0.365713);
	var_00.atmosfoghazestrength = 0.184731;
	var_00.atmosfoghazespread = 0.0342385;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.6692;
	var_00.atmosfoghalfplanedistance = 4062.13;
	var_00.atmosfogstartdistance = 330.485;
	var_00.atmosfogdistancescale = 0.178651;
	var_00.atmosfogskydistance = 114206;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -35.0835;
	var_00.atmosfogskyfalloffanglerange = 439.952;
	var_00.atmosfogsundirection = (0.713151,0.501338,0.489976);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -1370.37;
	var_00.atmosfogheightfoghalfplanedistance = 1209.94;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_greenband_warbird");
	var_00.startdist = 4218.91;
	var_00.halfwaydist = 44312.4;
	var_00.red = 0.974245;
	var_00.green = 0.985384;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 8.99603;
	var_00.maxopacity = 0.804817;
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
	var_00.atmosfogsunfogcolor = (0.839182,0.917799,1);
	var_00.atmosfoghazecolor = (0.437488,0.396474,0.365713);
	var_00.atmosfoghazestrength = 0.184731;
	var_00.atmosfoghazespread = 0.0342385;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.6692;
	var_00.atmosfoghalfplanedistance = 4062.13;
	var_00.atmosfogstartdistance = 330.485;
	var_00.atmosfogdistancescale = 0.178651;
	var_00.atmosfogskydistance = 114206;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -35.0835;
	var_00.atmosfogskyfalloffanglerange = 439.952;
	var_00.atmosfogsundirection = (0.713151,0.501338,0.489976);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = -1370.37;
	var_00.atmosfogheightfoghalfplanedistance = 1209.94;
}

//Function Number: 2
setupfog()
{
}
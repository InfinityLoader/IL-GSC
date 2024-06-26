/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_climate_3_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:06:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_climate_3");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 12.029;
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
	var_00.atmosfogsunfogcolor = (0.292273,0.365213,0.414204);
	var_00.atmosfoghazecolor = (0.256471,0.316059,0.398438);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.3125;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 21.5;
	var_00.atmosfoghalfplanedistance = 69164.9;
	var_00.atmosfogstartdistance = 1097.03;
	var_00.atmosfogdistancescale = 1.625;
	var_00.atmosfogskydistance = 74615;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -22;
	var_00.atmosfogskyfalloffanglerange = 34;
	var_00.atmosfogsundirection = (0.576587,0.641213,0.506352);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_climate_3_osp");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 12.029;
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
	var_00.atmosfogsunfogcolor = (0.276147,0.309338,0.414204);
	var_00.atmosfoghazecolor = (0.342408,0.398438,0.398438);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.3125;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 17.5;
	var_00.atmosfoghalfplanedistance = 18398.8;
	var_00.atmosfogstartdistance = 834.73;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 878;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.574733,0.617683,0.536796);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\mp\_art::create_vision_set_fog("generic_underwater");
	var_00.startdist = 0;
	var_00.halfwaydist = 63.9821;
	var_00.red = 0.533715;
	var_00.green = 0.736301;
	var_00.blue = 0.64293;
	var_00.hdrcolorintensity = 12.0527;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.453196;
	var_00.sungreen = 0.201765;
	var_00.sunblue = 0.22625;
	var_00.hdrsuncolorintensity = 9.93274;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 55.5863;
	var_00.sunendfadeangle = 100.333;
	var_00.normalfogscale = 0.515695;
	var_00.skyfogintensity = 0.991031;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (1,0,0);
	var_00.atmosfoghazecolor = (0,1,0);
	var_00.atmosfoghazestrength = 0.28436;
	var_00.atmosfoghazespread = 0.362051;
	var_00.atmosfogextinctionstrength = 0.786086;
	var_00.atmosfoginscatterstrength = 18.8627;
	var_00.atmosfoghalfplanedistance = 67166.8;
	var_00.atmosfogstartdistance = 5227.58;
	var_00.atmosfogdistancescale = 8.98823;
	var_00.atmosfogskydistance = 30000;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -30.5422;
	var_00.atmosfogskyfalloffanglerange = 77.2588;
	var_00.atmosfogsundirection = (0.881624,-0.108345,0.459347);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 4481.58;
	var_00.atmosfogheightfoghalfplanedistance = 1276.3;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_climate_3_cg");
	var_00.startdist = 765.049;
	var_00.halfwaydist = 14030.9;
	var_00.red = 0.597909;
	var_00.green = 0.780539;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 15.4563;
	var_00.maxopacity = 0.797289;
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
	var_00.atmosfogsunfogcolor = (0.258941,0.309338,0.414204);
	var_00.atmosfoghazecolor = (0.342408,0.370747,0.398438);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.3125;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 21.5;
	var_00.atmosfoghalfplanedistance = 18398.8;
	var_00.atmosfogstartdistance = 1097.03;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 100000;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -21;
	var_00.atmosfogskyfalloffanglerange = 34;
	var_00.atmosfogsundirection = (0.574733,0.617683,0.536796);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_climate_3_osp_cg");
	var_00.startdist = 17346.3;
	var_00.halfwaydist = 32487.6;
	var_00.red = 1;
	var_00.green = 0.957944;
	var_00.blue = 0.747583;
	var_00.hdrcolorintensity = 12.029;
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
	var_00 = maps\mp\_art::create_vision_set_fog("generic_underwater_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 63.9821;
	var_00.red = 0.533715;
	var_00.green = 0.736301;
	var_00.blue = 0.64293;
	var_00.hdrcolorintensity = 12.0527;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.453196;
	var_00.sungreen = 0.201765;
	var_00.sunblue = 0.22625;
	var_00.hdrsuncolorintensity = 9.93274;
	var_00.sundir = (0.0834606,-0.0251091,-0.996195);
	var_00.sunbeginfadeangle = 55.5863;
	var_00.sunendfadeangle = 100.333;
	var_00.normalfogscale = 0.515695;
	var_00.skyfogintensity = 0.991031;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
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
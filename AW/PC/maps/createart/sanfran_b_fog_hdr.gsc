/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\sanfran_b_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 72 ms
 * Timestamp: 4/22/2024 2:07:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	sunflare();
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 20;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0785,0.863,0.498);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_cg");
	var_00.startdist = 7318;
	var_00.halfwaydist = 33163;
	var_00.red = 0.653;
	var_00.green = 0.783;
	var_00.blue = 0.893;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 20;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0785,0.863,0.498);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior");
	var_00.startdist = 4733.46;
	var_00.halfwaydist = 58114.5;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 12.5713;
	var_00.maxopacity = 0.0940583;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_end");
	var_00.startdist = 511.935;
	var_00.halfwaydist = 1137.68;
	var_00.red = 0.751464;
	var_00.green = 0.836627;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 13.3907;
	var_00.maxopacity = 0.441519;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 20;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.915,0.00728,0.402);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger_bright");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 18.8;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.915,0.00728,0.402);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_info_center");
	var_00.startdist = 4733.46;
	var_00.halfwaydist = 58114.5;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 12.5713;
	var_00.maxopacity = 0.0940583;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_bridge");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 20.945;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0785,0.863,0.498);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior_dark");
	var_00.startdist = 4733.46;
	var_00.halfwaydist = 58114.5;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 12.5713;
	var_00.maxopacity = 0.120154;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 20.945;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0785,0.863,0.498);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior_darker");
	var_00.startdist = 4733.46;
	var_00.halfwaydist = 58114.5;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 12.5713;
	var_00.maxopacity = 0.0940583;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior_darker_cg");
	var_00.startdist = 4733.46;
	var_00.halfwaydist = 58114.5;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 12.5713;
	var_00.maxopacity = 0.0940583;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark");
	var_00.startdist = 184.62;
	var_00.halfwaydist = 1563.7;
	var_00.red = 1;
	var_00.green = 0.968265;
	var_00.blue = 0.878297;
	var_00.hdrcolorintensity = 13.5;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark_fog");
	var_00.startdist = 84.6196;
	var_00.halfwaydist = 4000;
	var_00.red = 1;
	var_00.green = 0.877827;
	var_00.blue = 0.816297;
	var_00.hdrcolorintensity = 13.5;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark_nofog");
	var_00.startdist = 84.6196;
	var_00.halfwaydist = 963.696;
	var_00.red = 1;
	var_00.green = 0.968265;
	var_00.blue = 0.878297;
	var_00.hdrcolorintensity = 11.5;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_darker_fog");
	var_00.startdist = 84.6196;
	var_00.halfwaydist = 4000;
	var_00.red = 1;
	var_00.green = 0.968265;
	var_00.blue = 0.878297;
	var_00.hdrcolorintensity = 14;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_light_fog");
	var_00.startdist = 84.6196;
	var_00.halfwaydist = 4000;
	var_00.red = 1;
	var_00.green = 0.968265;
	var_00.blue = 0.878297;
	var_00.hdrcolorintensity = 14;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_info_top");
	var_00.startdist = 404.952;
	var_00.halfwaydist = 2744.19;
	var_00.red = 1;
	var_00.green = 0.968265;
	var_00.blue = 0.878297;
	var_00.hdrcolorintensity = 13.3907;
	var_00.maxopacity = 0.0186271;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger_top");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 18.8;
	var_00.atmosfoghalfplanedistance = 6207.61;
	var_00.atmosfogstartdistance = 2128.97;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (-0.915,0.00728,0.402);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_guns");
	var_00.startdist = 1600;
	var_00.halfwaydist = 12000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.49,0.74,0.99);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.124639;
	var_00.atmosfoghazespread = 0.0317359;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 22.3249;
	var_00.atmosfoghalfplanedistance = 19762.8;
	var_00.atmosfogstartdistance = 4950.64;
	var_00.atmosfogdistancescale = 1.26979;
	var_00.atmosfogskydistance = 138458;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 90;
	var_00.atmosfogsundirection = (0.0785,0.863,0.498);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior_cg");
	var_00.startdist = 10000;
	var_00.halfwaydist = 60000;
	var_00.red = 0.7791;
	var_00.green = 0.8164;
	var_00.blue = 0.8721;
	var_00.hdrcolorintensity = 14.25;
	var_00.maxopacity = 0.588;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_interior_dark_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 80000;
	var_00.red = 0.6458;
	var_00.green = 0.7765;
	var_00.blue = 0.9042;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 0.7;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
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
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark_cg");
	var_00.startdist = 65;
	var_00.halfwaydist = 65;
	var_00.red = 0.921788;
	var_00.green = 0.524897;
	var_00.blue = 0.083862;
	var_00.hdrcolorintensity = 10.3907;
	var_00.maxopacity = 0.35;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark_fog_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 5869;
	var_00.red = 0.511;
	var_00.green = 0.49;
	var_00.blue = 0.469;
	var_00.hdrcolorintensity = 15;
	var_00.maxopacity = 0.55;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_darker_fog_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 5869;
	var_00.red = 0.511;
	var_00.green = 0.49;
	var_00.blue = 0.469;
	var_00.hdrcolorintensity = 15;
	var_00.maxopacity = 0.55;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_light_fog_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 1250;
	var_00.red = 0.462;
	var_00.green = 0.314;
	var_00.blue = 0.165;
	var_00.hdrcolorintensity = 15;
	var_00.maxopacity = 0.55;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = 0;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 0;
	var_00.normalfogscale = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_info_top_cg");
	var_00.startdist = 170;
	var_00.halfwaydist = 27169.75;
	var_00.red = 0.878431;
	var_00.green = 0.772549;
	var_00.blue = 0.705882;
	var_00.hdrcolorintensity = 14.263;
	var_00.maxopacity = 0.0186271;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
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
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger_top_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 87645;
	var_00.red = 0.591;
	var_00.green = 0.608;
	var_00.blue = 0.62;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
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
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_guns_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 87645;
	var_00.red = 0.591;
	var_00.green = 0.608;
	var_00.blue = 0.62;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_guns_bright");
	var_00.startdist = 0;
	var_00.halfwaydist = 87645;
	var_00.red = 0.591;
	var_00.green = 0.608;
	var_00.blue = 0.62;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_guns_bright_cg");
	var_00.startdist = 7318;
	var_00.halfwaydist = 33163;
	var_00.red = 0.653;
	var_00.green = 0.783;
	var_00.blue = 0.893;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.860149;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger_cg");
	var_00.startdist = 10000;
	var_00.halfwaydist = 60000;
	var_00.red = 0.785;
	var_00.green = 0.815;
	var_00.blue = 0.831;
	var_00.hdrcolorintensity = 16;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
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
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_hanger_bright_cg");
	var_00.startdist = 10000;
	var_00.halfwaydist = 60000;
	var_00.red = 0.785;
	var_00.green = 0.815;
	var_00.blue = 0.831;
	var_00.hdrcolorintensity = 16;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
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
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_exterior_dark_nofog_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 5869;
	var_00.red = 0.511;
	var_00.green = 0.49;
	var_00.blue = 0.469;
	var_00.hdrcolorintensity = 15;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 0;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_bridge_cg");
	var_00.startdist = 7318;
	var_00.halfwaydist = 33163;
	var_00.red = 0.653;
	var_00.green = 0.783;
	var_00.blue = 0.893;
	var_00.hdrcolorintensity = 14.7;
	var_00.maxopacity = 0.275;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sanfran_b_nightvision_cg");
	var_00.startdist = 10;
	var_00.halfwaydist = 70000;
	var_00.red = 0.878431;
	var_00.green = 0.772549;
	var_00.blue = 0.705882;
	var_00.hdrcolorintensity = 12.4876;
	var_00.maxopacity = 0.7;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00 = maps\_utility::create_vision_set_fog("sfb_neutral");
	var_00.startdist = 2600;
	var_00.halfwaydist = 19000;
	var_00.red = 0.86477;
	var_00.green = 0.92;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 0.5;
	var_00.sungreen = 0.5;
	var_00.sunblue = 0.5;
	var_00.hdrsuncolorintensity = -8;
	var_00.sundir = (0,0,0);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 1;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0;
	var_00.skyfogminangle = 0;
	var_00.skyfogmaxangle = 0;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.571,0.756,0.97);
	var_00.atmosfoghazecolor = (1,1,0.897);
	var_00.atmosfoghazestrength = 0.069;
	var_00.atmosfoghazespread = 0.0169;
	var_00.atmosfogextinctionstrength = 0.1558;
	var_00.atmosfoginscatterstrength = 21.3;
	var_00.atmosfoghalfplanedistance = 26980.6;
	var_00.atmosfogstartdistance = 33187;
	var_00.atmosfogdistancescale = 1.028;
	var_00.atmosfogskydistance = 32106;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = 7.91;
	var_00.atmosfogskyfalloffanglerange = 89.367;
	var_00.atmosfogsundirection = (-0.543,0.726,0.415);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 1000;
}

//Function Number: 2
sunflare()
{
	var_00 = maps\_utility::create_sunflare_setting("default");
	var_00.position = (-30,85,0);
	maps\_art::sunflare_changes("default",0);
}
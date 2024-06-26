/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_zombie_lab_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 4/22/2024 2:07:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab");
	var_00.startdist = 310.345;
	var_00.halfwaydist = 1654.67;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_cg");
	var_00.startdist = 0.893372;
	var_00.halfwaydist = 6539.69;
	var_00.red = 0.248502;
	var_00.green = 0.266121;
	var_00.blue = 0.28345;
	var_00.hdrcolorintensity = 11.3279;
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
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_interior");
	var_00.startdist = 1000;
	var_00.halfwaydist = 3000;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_interior_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 6567;
	var_00.red = 0.439216;
	var_00.green = 0.521569;
	var_00.blue = 0.545098;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.961875;
	var_00.hdrsuncolorintensity = 8.21756;
	var_00.sundir = (-0.890653,-0.43211,0.123501);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 75.455;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 60;
	var_00.skyfogmaxangle = 86.6304;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_infected");
	var_00.startdist = 310.345;
	var_00.halfwaydist = 1654.67;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_infected_cg");
	var_00.startdist = 150;
	var_00.halfwaydist = 1654.67;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_infected_crazy");
	var_00.startdist = 310.345;
	var_00.halfwaydist = 1654.67;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_infected_crazy_cg");
	var_00.startdist = 310.345;
	var_00.halfwaydist = 1654.67;
	var_00.red = 0.0521825;
	var_00.green = 0.0586488;
	var_00.blue = 0.0653548;
	var_00.hdrcolorintensity = 13.5363;
	var_00.maxopacity = 0.950129;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.926996;
	var_00.hdrsuncolorintensity = 8.71153;
	var_00.sundir = (-0.890628,0.176135,0.419236);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 62.4934;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 0.90825;
	var_00.skyfogminangle = 48.5106;
	var_00.skyfogmaxangle = 74.0837;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_autopsy_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 6567;
	var_00.red = 0.439216;
	var_00.green = 0.521569;
	var_00.blue = 0.545098;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.961875;
	var_00.hdrsuncolorintensity = 8.21756;
	var_00.sundir = (-0.890653,-0.43211,0.123501);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 75.455;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 60;
	var_00.skyfogmaxangle = 86.6304;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_zombie_lab_morgue_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 6567;
	var_00.red = 0.439216;
	var_00.green = 0.521569;
	var_00.blue = 0.545098;
	var_00.hdrcolorintensity = 11;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00.sunred = 1;
	var_00.sungreen = 1;
	var_00.sunblue = 0.961875;
	var_00.hdrsuncolorintensity = 8.21756;
	var_00.sundir = (-0.890653,-0.43211,0.123501);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 75.455;
	var_00.normalfogscale = 1.00853;
	var_00.skyfogintensity = 1;
	var_00.skyfogminangle = 60;
	var_00.skyfogmaxangle = 86.6304;
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
}

//Function Number: 2
setupfog()
{
}
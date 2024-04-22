/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_solar_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 4/22/2024 2:07:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 512;
	var_00.halfwaydist = 43009;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.953236,0.974485,0.999997);
	var_00.atmosfoghazecolor = (0.99999,0.96967,0.94534);
	var_00.atmosfoghazestrength = 1;
	var_00.atmosfoghazespread = 0.406232;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.7492;
	var_00.atmosfoghalfplanedistance = 8801.57;
	var_00.atmosfogstartdistance = 3298.9;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 99963;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 32;
	var_00.atmosfogsundirection = (-0.149352,0.80657,0.571961);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 752;
	var_00.atmosfogheightfoghalfplanedistance = 982.303;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar");
	var_00.startdist = 512;
	var_00.halfwaydist = 34817;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.851475,0.89798,0.999993);
	var_00.atmosfoghazecolor = (1,1,0.999981);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.312462;
	var_00.atmosfogextinctionstrength = 0.601563;
	var_00.atmosfoginscatterstrength = 20.9992;
	var_00.atmosfoghalfplanedistance = 6288.93;
	var_00.atmosfogstartdistance = 1025.38;
	var_00.atmosfogdistancescale = 0.5;
	var_00.atmosfogskydistance = 131072;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 184;
	var_00.atmosfogsundirection = (-0.161074,0.794633,0.585332);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 513.71;
	var_00.atmosfogheightfoghalfplanedistance = 1344.97;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar_osp");
	var_00.startdist = 512;
	var_00.halfwaydist = 34817;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.851475,0.89798,0.999993);
	var_00.atmosfoghazecolor = (1,1,0.999981);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.312462;
	var_00.atmosfogextinctionstrength = 0.601563;
	var_00.atmosfoginscatterstrength = 20.9992;
	var_00.atmosfoghalfplanedistance = 6288.93;
	var_00.atmosfogstartdistance = 1025.38;
	var_00.atmosfogdistancescale = 0.5;
	var_00.atmosfogskydistance = 131072;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 184;
	var_00.atmosfogsundirection = (-0.161074,0.794633,0.585332);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 513.71;
	var_00.atmosfogheightfoghalfplanedistance = 1344.97;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar_warbird");
	var_00.startdist = 512;
	var_00.halfwaydist = 34817;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.851475,0.89798,0.999993);
	var_00.atmosfoghazecolor = (1,1,0.999981);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.312462;
	var_00.atmosfogextinctionstrength = 0.601563;
	var_00.atmosfoginscatterstrength = 20.9992;
	var_00.atmosfoghalfplanedistance = 6288.93;
	var_00.atmosfogstartdistance = 1025.38;
	var_00.atmosfogdistancescale = 0.5;
	var_00.atmosfogskydistance = 131072;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 184;
	var_00.atmosfogsundirection = (-0.161074,0.794633,0.585332);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 513.71;
	var_00.atmosfogheightfoghalfplanedistance = 1344.97;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar_drone");
	var_00.startdist = 512;
	var_00.halfwaydist = 34817;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.851475,0.89798,0.999993);
	var_00.atmosfoghazecolor = (1,1,0.999981);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.312462;
	var_00.atmosfogextinctionstrength = 0.601563;
	var_00.atmosfoginscatterstrength = 20.9992;
	var_00.atmosfoghalfplanedistance = 6288.93;
	var_00.atmosfogstartdistance = 1025.38;
	var_00.atmosfogdistancescale = 0.5;
	var_00.atmosfogskydistance = 131072;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 184;
	var_00.atmosfogsundirection = (-0.161074,0.794633,0.585332);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 513.71;
	var_00.atmosfogheightfoghalfplanedistance = 1344.97;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar_int");
	var_00.startdist = 512;
	var_00.halfwaydist = 43009;
	var_00.red = 0.794189;
	var_00.green = 0.794189;
	var_00.blue = 0.794189;
	var_00.hdrcolorintensity = 17;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.911458;
	var_00.sunblue = 0.781251;
	var_00.hdrsuncolorintensity = 17.5;
	var_00.sundir = (-0.146883,0.796223,0.586902);
	var_00.sunbeginfadeangle = 0;
	var_00.sunendfadeangle = 129.989;
	var_00.normalfogscale = 1;
	var_00.skyfogintensity = 0.999991;
	var_00.skyfogminangle = -10;
	var_00.skyfogmaxangle = 180;
	var_00.heightfogenabled = 0;
	var_00.heightfogbaseheight = 0;
	var_00.heightfoghalfplanedistance = 1000;
	var_00.atmosfogenabled = 1;
	var_00.atmosfogsunfogcolor = (0.953236,0.974485,0.999997);
	var_00.atmosfoghazecolor = (0.99999,0.96967,0.94534);
	var_00.atmosfoghazestrength = 1;
	var_00.atmosfoghazespread = 0.406232;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 20.7492;
	var_00.atmosfoghalfplanedistance = 8801.57;
	var_00.atmosfogstartdistance = 3298.9;
	var_00.atmosfogdistancescale = 1;
	var_00.atmosfogskydistance = 99963;
	var_00.atmosfogskyangularfalloffenabled = 0;
	var_00.atmosfogskyfalloffstartangle = 0;
	var_00.atmosfogskyfalloffanglerange = 32;
	var_00.atmosfogsundirection = (-0.149352,0.80657,0.571961);
	var_00.atmosfogheightfogenabled = 1;
	var_00.atmosfogheightfogbaseheight = 752;
	var_00.atmosfogheightfoghalfplanedistance = 982.303;
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
	var_00.atmosfoginscatterstrength = 18.9426;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_solar_cg");
	var_00.startdist = 0;
	var_00.halfwaydist = 47158.6;
	var_00.red = 0.763819;
	var_00.green = 0.853701;
	var_00.blue = 0.935127;
	var_00.hdrcolorintensity = 17.2868;
	var_00.maxopacity = 0.295194;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 1;
	var_00.sunred = 0.999986;
	var_00.sungreen = 0.917968;
	var_00.sunblue = 0.859375;
	var_00.hdrsuncolorintensity = 16.6678;
	var_00.sundir = (-0.130212,0.625343,0.76941);
	var_00.sunbeginfadeangle = 12.9988;
	var_00.sunendfadeangle = 89.9966;
	var_00.normalfogscale = 0.0625;
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
}

//Function Number: 2
setupfog()
{
}
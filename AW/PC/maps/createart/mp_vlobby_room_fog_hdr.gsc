/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_vlobby_room_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 55 ms
 * Timestamp: 4/22/2024 2:07:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_virtual_lobby");
	var_00.startdist = 161.017;
	var_00.halfwaydist = 11144;
	var_00.red = 0.225708;
	var_00.green = 0.270302;
	var_00.blue = 0.335938;
	var_00.hdrcolorintensity = 0;
	var_00.maxopacity = 0.976563;
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
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.523438,0.523438,0.523438);
	var_00.atmosfoghazecolor = (0.523438,0.523438,0.523438);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.164063;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 13.5;
	var_00.atmosfoghalfplanedistance = 1257.86;
	var_00.atmosfogstartdistance = 886.364;
	var_00.atmosfogdistancescale = 1.5;
	var_00.atmosfogskydistance = 17622;
	var_00.atmosfogskyangularfalloffenabled = 1;
	var_00.atmosfogskyfalloffstartangle = -33;
	var_00.atmosfogskyfalloffanglerange = 200;
	var_00.atmosfogsundirection = (0.412467,-0.716527,0.562548);
	var_00.atmosfogheightfogenabled = 0;
	var_00.atmosfogheightfogbaseheight = 0;
	var_00.atmosfogheightfoghalfplanedistance = 168;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_virtual_lobby_fr");
	var_00.startdist = 91.14;
	var_00.halfwaydist = 2489.07;
	var_00.red = 0.914;
	var_00.green = 0.976;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 6;
	var_00.maxopacity = 0.649765;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_virtual_lobby_fr_cg");
	var_00.startdist = 91.14;
	var_00.halfwaydist = 2489.07;
	var_00.red = 0.914;
	var_00.green = 0.976;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 6;
	var_00.maxopacity = 0.649765;
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
	var_00 = maps\mp\_art::create_vision_set_fog("");
	var_00.startdist = 91.14;
	var_00.halfwaydist = 2489.07;
	var_00.red = 0.914;
	var_00.green = 0.976;
	var_00.blue = 1;
	var_00.hdrcolorintensity = 16.288;
	var_00.maxopacity = 0.649765;
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
	var_00 = maps\mp\_art::create_vision_set_fog("mp_vlobby_room");
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
	var_00.atmosfogenabled = 0;
	var_00.atmosfogsunfogcolor = (0.369932,0.477196,0.546875);
	var_00.atmosfoghazecolor = (0.5,0.5,0.5);
	var_00.atmosfoghazestrength = 0.5;
	var_00.atmosfoghazespread = 0.25;
	var_00.atmosfogextinctionstrength = 1;
	var_00.atmosfoginscatterstrength = 19;
	var_00.atmosfoghalfplanedistance = 20926.6;
	var_00.atmosfogstartdistance = -0.62921;
	var_00.atmosfogdistancescale = 1.0045;
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
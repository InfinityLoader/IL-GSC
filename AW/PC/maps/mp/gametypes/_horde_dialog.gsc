/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_dialog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 144 ms
 * Timestamp: 4/22/2024 2:09:37 AM
*******************************************************************/

//Function Number: 1
hordedialoginit()
{
	level.hordedialog = [];
	game["dialog"]["REPLACEMEREPLACEMEREPLACEME"] = "REPLACEMEREPLACEMEREPLACEME";
	game["dialog"]["coop_gdn_intro"] = "coop_gdn_intro";
	game["dialog"]["coop_gdn_sensorsareshowing"] = "coop_gdn_sensorsareshowing";
	game["dialog"]["coop_gdn_badguysincoming"] = "coop_gdn_badguysincoming";
	game["dialog"]["coop_gdn_readyupenemy"] = "coop_gdn_readyupenemy";
	game["dialog"]["coop_gdn_isrshowingalarge"] = "coop_gdn_isrshowingalarge";
	game["dialog"]["coop_gdn_eyesopenteam"] = "coop_gdn_eyesopenteam";
	game["dialog"]["coop_gdn_hostileemtroops"] = "coop_gdn_hostileemtroops";
	game["dialog"]["coop_gdn_enemyhazmat"] = "coop_gdn_enemyhazmat";
	game["dialog"]["coop_gdn_epm3"] = "coop_gdn_epm3";
	game["dialog"]["coop_gdn_enemydronehandlers"] = "coop_gdn_enemydronehandlers";
	game["dialog"]["coop_gdn_hostilesincoming"] = "coop_gdn_hostilesincoming";
	game["dialog"]["coop_gdn_tangosinbound"] = "coop_gdn_tangosinbound";
	game["dialog"]["coop_gdn_enemyunitsapproaching"] = "coop_gdn_enemyunitsapproaching";
	game["dialog"]["coop_gdn_wereseeingmicrodronesignature"] = "coop_gdn_wereseeingmicrodronesignature";
	game["dialog"]["coop_gdn_teambeadvisedenemiesareusing"] = "coop_gdn_teambeadvisedenemiesareusing";
	game["dialog"]["coop_gdn_rockets"] = "coop_gdn_rockets";
	game["dialog"]["coop_gdn_warbird_inc"] = "coop_gdn_warbird_inc";
	game["dialog"]["coop_gdn_incomingmechs"] = "coop_gdn_incomingmechs";
	level.hordedialog["round_begin"] = ["coop_gdn_sensorsareshowing","coop_gdn_badguysincoming","coop_gdn_readyupenemy","coop_gdn_hostilesincoming","coop_gdn_tangosinbound","coop_gdn_enemyunitsapproaching"];
	game["dialog"]["coop_gdn_roundover"] = "coop_gdn_roundover";
	game["dialog"]["coop_gdn_locationdefended"] = "coop_gdn_locationdefended";
	game["dialog"]["coop_gdn_hardpoint"] = "coop_gdn_hardpoint";
	game["dialog"]["coop_gdn_allgodtagssecured"] = "coop_gdn_allgodtagssecured";
	game["dialog"]["coop_gdn_dogtagsareinthefield"] = "coop_gdn_dogtagsareinthefield";
	game["dialog"]["coop_gdn_intelaquired"] = "coop_gdn_intelaquired";
	game["dialog"]["coop_gdn_allintelaquired"] = "coop_gdn_allintelaquired";
	game["dialog"]["coop_gdn_hostilesincomingsearchdowned"] = "coop_gdn_hostilesincomingsearchdowned";
	game["dialog"]["coop_gdn_empbombsshowingonsensors"] = "coop_gdn_empbombsshowingonsensors";
	game["dialog"]["coop_gdn_satellite_start"] = "coop_gdn_satellite_start";
	game["dialog"]["coop_gdn_satellite_acquire"] = "coop_gdn_satellite_acquire";
	game["dialog"]["coop_gdn_satellite_lost"] = "coop_gdn_satellite_lost";
	game["dialog"]["coop_gdn_satellite_enemy"] = "coop_gdn_satellite_enemy";
	game["dialog"]["coop_gdn_satellite_intercept"] = "coop_gdn_satellite_intercept";
	game["dialog"]["coop_gdn_satellite_incoming"] = "coop_gdn_satellite_incoming";
	game["dialog"]["coop_gdn_satellite_reset"] = "coop_gdn_satellite_reset";
	game["dialog"]["coop_gdn_satellite_returned"] = "coop_gdn_satellite_returned";
	game["dialog"]["coop_gdn_get_it_back"] = "coop_gdn_get_it_back";
	game["dialog"]["coop_gdn_uplink_station"] = "coop_gdn_uplink_station";
	game["dialog"]["coop_gdn_satellite_success"] = "coop_gdn_satellite_success";
	game["dialog"]["coop_gdn_objective_complete"] = "coop_gdn_objective_complete";
	game["dialog"]["coop_gdn_tangosarepoppingsmoke"] = "coop_gdn_tangosarepoppingsmoke";
	game["dialog"]["coop_gdn_sentryguns"] = "coop_gdn_sentryguns";
	game["dialog"]["coop_gdn_weaponsoffline"] = "coop_gdn_weaponsoffline";
	game["dialog"]["coop_gdn_systemhack"] = "coop_gdn_systemhack";
	game["dialog"]["coop_gdn_nanostrike"] = "coop_gdn_nanostrike";
	game["dialog"]["coop_gdn_exoarmoryisup"] = "coop_gdn_exoarmoryisup";
	game["dialog"]["coop_gdn_weaponsarmory"] = "coop_gdn_weaponsarmory";
	game["dialog"]["coop_gdn_statupgradesavailable"] = "coop_gdn_statupgradesavailable";
	game["dialog"]["coop_gdn_exolauncherupgrages"] = "coop_gdn_exolauncherupgrages";
	game["dialog"]["coop_gdn_enemydrones"] = "coop_gdn_enemydrones";
	game["dialog"]["coop_gdn_enemydrones"] = "coop_gdn_enemydrones";
	game["dialog"]["coop_gdn_sensorsshowingem"] = "coop_gdn_sensorsshowingem";
	game["dialog"]["coop_gdn_enemyairsupport"] = "coop_gdn_enemyairsupport";
	game["dialog"]["coop_gdn_enemyk9units"] = "coop_gdn_enemyk9units";
	game["dialog"]["coop_gdn_supportdropincoming"] = "coop_gdn_supportdropincoming";
	game["dialog"]["coop_gdn_allydownedrepeat"] = "coop_gdn_allydownedrepeat";
	game["dialog"]["coop_gdn_friendlyisdownlocate"] = "coop_gdn_friendlyisdownlocate";
	game["dialog"]["coop_gdn_friendlydowned"] = "coop_gdn_friendlydowned";
	game["dialog"]["coop_gdn_teammatewounded"] = "coop_gdn_teammatewounded";
	level.hordedialog["laststand"] = ["coop_gdn_allydownedrepeat","coop_gdn_friendlyisdownlocate","coop_gdn_friendlydowned","coop_gdn_teammatewounded"];
	game["dialog"]["coop_gdn_notgoodenough"] = "coop_gdn_notgoodenough";
	game["dialog"]["coop_gdn_yougotmassacredoutthere"] = "coop_gdn_yougotmassacredoutthere";
	game["dialog"]["coop_gdn_notagoodeffort"] = "coop_gdn_notagoodeffort";
	game["dialog"]["coop_gdn_notimpressed"] = "coop_gdn_notimpressed";
	game["dialog"]["coop_gdn_wevelostitfallback"] = "coop_gdn_wevelostitfallback";
	game["dialog"]["coop_gdn_wegothammeredoutthere"] = "coop_gdn_wegothammeredoutthere";
	level.hordedialog["fail_angry"] = ["coop_gdn_notgoodenough","coop_gdn_yougotmassacredoutthere","coop_gdn_notagoodeffort","coop_gdn_notimpressed","coop_gdn_wevelostitfallback","coop_gdn_wegothammeredoutthere"];
	game["dialog"]["coop_gdn_goodjobbutyoucandobetter"] = "coop_gdn_goodjobbutyoucandobetter";
	game["dialog"]["coop_gdn_goodeffortteam"] = "coop_gdn_goodeffortteam";
	game["dialog"]["coop_gdn_welldonteam"] = "coop_gdn_welldonteam";
	game["dialog"]["coop_gdn_nicelydoneletstryagain"] = "coop_gdn_nicelydoneletstryagain";
	game["dialog"]["coop_gdn_welldonegentlemen"] = "coop_gdn_welldonegentlemen";
	game["dialog"]["coop_gdn_jobwelldone"] = "coop_gdn_jobwelldone";
	level.hordedialog["fail_happy"] = ["coop_gdn_goodjobbutyoucandobetter","coop_gdn_goodeffortteam","coop_gdn_welldonteam","coop_gdn_nicelydoneletstryagain","coop_gdn_welldonegentlemen","coop_gdn_jobwelldone"];
	game["dialog"]["coop_gdn_sensorsareshowingmanticore"] = "coop_gdn_sensorsareshowingmanticore";
	game["dialog"]["coop_gdn_hitthedeck"] = "coop_gdn_hitthedeck";
	game["dialog"]["coop_gdn_watchout"] = "coop_gdn_watchout";
	game["dialog"]["coop_gdn_takecover"] = "coop_gdn_takecover";
	game["dialog"]["coop_gdn_teamreportstatus"] = "coop_gdn_teamreportstatus";
	game["dialog"]["coop_gdn_doesanyonehaveme"] = "coop_gdn_doesanyonehaveme";
	game["dialog"]["coop_gdn_alliedforcesthisisgideon"] = "coop_gdn_alliedforcesthisisgideon";
	game["dialog"]["coop_gdn_isanyoneoutthere"] = "coop_gdn_isanyoneoutthere";
	game["dialog"]["coop_gdn_welcomebackteam"] = "coop_gdn_welcomebackteam";
	game["dialog"]["coop_gdn_armoriesaredownexosareoffline"] = "coop_gdn_armoriesaredownexosareoffline";
	game["dialog"]["coop_gdn_irsisshowingfastmovers"] = "coop_gdn_irsisshowingfastmovers";
	game["dialog"]["coop_gdn_thatdnabombshouldhavetaken"] = "coop_gdn_thatdnabombshouldhavetaken";
	game["dialog"]["coop_gdn_headsupteamsomthings"] = "coop_gdn_headsupteamsomthings";
	game["dialog"]["coop_gdn_heretheycome"] = "coop_gdn_heretheycome";
	game["dialog"]["coop_gdn_whatthebloddyhell"] = "coop_gdn_whatthebloddyhell";
	game["dialog"]["coop_gdn_whatthehellisgoingon"] = "coop_gdn_whatthehellisgoingon";
	game["dialog"]["coop_gdn_teamreportwhatthehell"] = "coop_gdn_teamreportwhatthehell";
	game["dialog"]["coop_gdn_exosarebackupuseboostjump"] = "coop_gdn_exosarebackupuseboostjump";
	game["dialog"]["coop_gdn_iaminboundwithanextraction"] = "coop_gdn_iaminboundwithanextraction";
	game["dialog"]["coop_gdn_moveitteam30sec"] = "coop_gdn_moveitteam30sec";
	game["dialog"]["coop_gdn_teammoveyourasses"] = "coop_gdn_teammoveyourasses";
	game["dialog"]["coop_gdn_moveitteam15sec"] = "coop_gdn_moveitteam15sec";
	thread hordevoroundstart();
	thread hordevolaststand();
}

//Function Number: 2
hordevoroundstart()
{
	level endon("game_ended");
	level endon("zombies_started");
	level.hordedialog["round_begin"] = common_scripts\utility::array_randomize(level.hordedialog["round_begin"]);
	level.roundstartlineindex = 0;
	var_00 = "";
	for(;;)
	{
		level common_scripts\utility::waittill_any("round_begin","all_players_ready");
		wait(1);
		switch(level.currentroundnumber)
		{
			case 1:
				break;
	
			case 3:
				break;
	
			case 4:
				var_00 = "coop_gdn_enemyk9units";
				break;
	
			case 5:
				var_00 = "coop_gdn_enemydrones";
				break;
	
			case 6:
				break;
	
			case 7:
				var_00 = "coop_gdn_hostileemtroops";
				break;
	
			case 8:
				var_00 = "coop_gdn_teambeadvisedenemiesareusing";
				break;
	
			case 9:
				break;
	
			case 10:
				var_00 = "coop_gdn_incomingmechs";
				break;
	
			case 11:
				if(maps\mp\_utility::getmapname() == "mp_prison_z")
				{
					break;
				}
				else
				{
					if(level.hordelevelflip > 1)
					{
						var_00 = "coop_gdn_enemyk9units";
					}
					else
					{
						var_00 = "coop_gdn_warbird_inc";
					}
		
					break;
				}
		
				break;
	
			case 12:
				var_00 = "coop_gdn_epm3";
				break;
	
			case 13:
				break;
	
			case 14:
				var_00 = "coop_gdn_enemydronehandlers";
				break;
	
			case 15:
				var_00 = "coop_gdn_warbird_inc";
				break;
	
			case 16:
				break;
	
			case 17:
				var_00 = "coop_gdn_enemydronesintheair";
				break;
	
			case 18:
				var_00 = "coop_gdn_wereseeingmicrodronesignature";
				break;
	
			case 19:
				break;
	
			case 20:
				var_00 = "coop_gdn_incomingmechs";
				break;
	
			case 22:
				break;
	
			case 23:
				var_00 = "coop_gdn_warbird_inc";
				break;
	
			case 24:
				break;
	
			default:
				var_00 = hordegetroundstartline();
				break;
		}

		if(level.currentroundnumber < 26)
		{
			thread hordeleaderdialogallplayers(var_00,"horde",1);
		}

		wait(0.05);
	}
}

//Function Number: 3
hordegetroundstartline()
{
	var_00 = level.hordedialog["round_begin"][level.roundstartlineindex];
	level.roundstartlineindex++;
	if(level.roundstartlineindex >= level.hordedialog["round_begin"].size)
	{
		level.roundstartlineindex = 0;
	}

	return var_00;
}

//Function Number: 4
hordevolaststand()
{
	level endon("game_ended");
	level.hordedialog["laststand"] = common_scripts\utility::array_randomize(level.hordedialog["laststand"]);
	var_00 = -1;
	var_01 = "";
	for(;;)
	{
		level waittill("player_last_stand");
		if(maps\mp\gametypes\_horde_util::getnumplayers() < 2)
		{
			continue;
		}

		if(var_00 >= level.hordedialog["laststand"].size - 1)
		{
			var_00 = 0;
		}
		else
		{
			var_00++;
		}

		var_01 = level.hordedialog["laststand"][var_00];
		foreach(var_03 in level.players)
		{
			var_03 maps\mp\_utility::leaderdialogonplayer(var_01,"horde",1);
		}

		wait(0.05);
	}
}

//Function Number: 5
zombiedialog()
{
	level endon("game_ended");
	wait(3);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_armoriesaredownexosareoffline",level.players,"horde");
	wait(5);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_thatdnabombshouldhavetaken",level.players,"horde");
	wait(7.5);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_headsupteamsomthings",level.players,"horde");
	level notify("beginZombieSpawn");
	while(level.zombiesdead < 5)
	{
		wait(0.25);
	}

	wait(randomfloatrange(1,3));
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_whatthebloddyhell",level.players,"horde");
	wait(randomintrange(8,12));
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_teamreportwhatthehell",level.players,"horde");
	wait(4);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_whatthehellisgoingon",level.players,"horde");
}

//Function Number: 6
hordeleaderdialogallplayers(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	foreach(var_05 in level.players)
	{
		var_05 maps\mp\_utility::leaderdialogonplayer(param_00,param_01,param_02);
	}
}

//Function Number: 7
hordevomissionfail()
{
	if(level.currentroundnumber < 15 && level.hordelevelflip < 2)
	{
		hordeleaderdialogallplayers(level.hordedialog["fail_angry"][randomintrange(0,level.hordedialog["fail_angry"].size)],"horde",1);
		return;
	}

	hordeleaderdialogallplayers(level.hordedialog["fail_happy"][randomintrange(0,level.hordedialog["fail_happy"].size)],"horde",1);
}

//Function Number: 8
extraction_nag_lines()
{
	level endon("zombies_ended");
	level endon("game_ended");
	wait(22);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_moveitteam15sec",level.players,"horde");
	wait(8);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_teammoveyourasses",level.players,"horde");
}
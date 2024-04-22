/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_lab_sq.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 140
 * Decompile Time: 2031 ms
 * Timestamp: 4/22/2024 2:19:54 AM
*******************************************************************/

//Function Number: 1
init_sidequest()
{
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("main",::init_main_sidequest,::sidequest_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage1",::stage1_init,::stage1_logic,::stage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage2",::stage2_init,::stage2_logic,::stage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage3",::stage3_init,::stage3_logic,::stage3_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage4",::stage4_init,::stage4_logic,::stage4_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage5",::stage5_init,::stage5_logic,::stage5_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage6",::stage6_init,::stage6_logic,::stage6_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage7",::stage7_init,::stage7_logic,::stage7_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage8",::stage8_init,::stage8_logic,::stage8_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage9",::stage9_init,::stage9_logic,::stage9_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage10",::stage10_init,::stage10_logic,::stage10_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage11",::stage11_init,::stage11_logic,::stage11_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("song",::init_song_sidequest,::sidequest_logic_song);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage1",::songstage1_init,::songstage1_logic,::songstage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage2",::songstage2_init,::songstage2_logic,::songstage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage3",::songstage3_init,::songstage3_logic,::songstage3_end);
	thread maps\mp\killstreaks\_aerial_utility::init();
	level._effect["sq_light"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
	level._effect["incinerator_ash"] = loadfx("vfx/weaponimpact/dlc_ash_ee_impact");
	level._effect["dlc_prop_biometric_lock_fail"] = loadfx("vfx/props/dlc_prop_biometric_lock_fail");
	level._effect["dlc_prop_biometric_lock_on"] = loadfx("vfx/props/dlc_prop_biometric_lock_on");
	level._effect["dlc_prop_biometric_lock_pass"] = loadfx("vfx/props/dlc_prop_biometric_lock_pass");
	level._effect["dlc_prop_scanner_door_lock_fail"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_fail");
	level._effect["dlc_prop_scanner_door_lock_on"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_on");
	level._effect["dlc_prop_scanner_door_lock_pass"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_pass");
	level.chopper_fx["light"]["warbird"] = loadfx("vfx/lights/air_light_wingtip_red");
	level.chopper_fx["engine"]["warbird"] = loadfx("vfx/distortion/distortion_warbird_mp");
	maps\mp\killstreaks\_aerial_utility::makehelitype("warbird","vfx/explosion/vehicle_warbird_explosion_midair",::maps\mp\killstreaks\_warbird::warbirdlightfx);
	maps\mp\killstreaks\_aerial_utility::addairexplosion("warbird","vfx/explosion/vehicle_warbird_explosion_midair");
	level thread start_lab_sidequest();
	level thread init_vo();
	level thread side_quest_end();
	level thread onplayerconnected();
	level thread onanyplayerspawned();
}

//Function Number: 2
start_lab_sidequest()
{
	wait(3);
	level thread setupweaponstationblocker();
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

//Function Number: 3
setupweaponstationblocker()
{
	var_00 = getent("weapon_upgrade_blocker_model","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(var_00.target))
	{
		var_01 = getent(var_00.target,"targetname");
		if(isdefined(var_01))
		{
			var_01 vehicle_jetbikesethoverforcescale(var_00);
		}
	}

	wait 0.05;
	var_00.offsetmove = 76;
	var_00.origin = var_00.origin + (0,0,-1 * var_00.offsetmove);
}

//Function Number: 4
init_vo()
{
	wait 0.05;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq","easter_egg",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","sq","sq",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","sq","sq","sq",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer3","sq","sq","easter_egg",undefined);
}

//Function Number: 5
init_main_sidequest()
{
}

//Function Number: 6
sidequest_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage1");
	level waittill("main_stage1_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage2");
	level waittill("main_stage2_over");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage3");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage4");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage5");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage6");
	while(!var_00 || !var_01 || !var_02 || !var_03)
	{
		var_04 = level common_scripts\utility::waittill_any_return_no_endon_death("main_stage3_over","main_stage4_over","main_stage5_over","main_stage6_over");
		if(var_04 == "main_stage3_over")
		{
			var_00 = 1;
			continue;
		}

		if(var_04 == "main_stage4_over")
		{
			var_01 = 1;
			continue;
		}

		if(var_04 == "main_stage5_over")
		{
			var_02 = 1;
			continue;
		}

		if(var_04 == "main_stage6_over")
		{
			var_03 = 1;
		}
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("All badges collected, need to upgrade them.");
	level notify("main_stage3456_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage7");
	level waittill("main_stage7_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage8");
	level waittill("main_stage8_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage9");
	level waittill("main_stage9_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage10");
	level waittill("main_stage10_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage11");
	level waittill("main_stage11_over");
	givesidequestachievement();
}

//Function Number: 7
givesidequestachievement()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_GAMEOVERMAN");
	}
}

//Function Number: 8
generic_stage_start()
{
	level._stage_active = 1;
}

//Function Number: 9
generic_stage_complete()
{
	level._stage_active = 0;
}

//Function Number: 10
complete_sidequest()
{
}

//Function Number: 11
onanyplayerspawned()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isdefined(var_00) && isdefined(var_00.badgeupgradecount))
		{
			var_00 setclientomnvar("ui_zm_ee_int",var_00.badgeupgradecount);
		}
	}
}

//Function Number: 12
onplayerconnected()
{
	for(;;)
	{
		level waittill("connected",var_00);
		thread monitorplayer(var_00);
	}
}

//Function Number: 13
monitorplayer(param_00)
{
	param_00 waittill("begin_last_stand");
	level.wenttolaststand = 1;
}

//Function Number: 14
stage1_init()
{
	var_00 = getent("blackbox2","targetname");
	if(isdefined(var_00))
	{
		var_00 hide();
	}
}

//Function Number: 15
stage1_logic()
{
	var_00 = common_scripts\utility::getstruct("blackbox1Use","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	var_01 playloopsound("ee_black_box_loop");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage1_over");
	var_00 waittill("activated",var_02);
	var_02 playergivebox();
	var_02 playlocalsound("ee_grab_black_box");
	var_01 stoploopsound();
	var_02 thread playerplaysqvo(1,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage1");
	wait 0.05;
	var_01 delete();
}

//Function Number: 16
stage1_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("This looks encrypted.");
	var_01 = getent("blackbox1","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01 delete();
}

//Function Number: 17
playerplaysqvo(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(maps\mp\zombies\_util::is_true(self.speaking))
	{
		self waittill("done_speaking");
	}

	thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq","sq",undefined,param_00);
}

//Function Number: 18
waittilldonespeaking(param_00)
{
	param_00 endon("disconnect");
	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 19
playsqvowaittilldone(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(param_00);
	if(isdefined(var_03))
	{
		var_03 playerplaysqvo(param_01,0);
		wait 0.05;
		waittilldonespeaking(var_03);
		if(isdefined(param_02))
		{
			wait(param_02);
		}
	}
}

//Function Number: 20
announcerinworldplaysqvo(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02 > 0)
	{
		wait(param_02);
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("sq","sq",param_01,undefined,param_00,1,undefined,level.players);
}

//Function Number: 21
announcerinworldplaysqvowaittilldone(param_00,param_01,param_02)
{
	announcerinworldplaysqvo(param_00,param_01,param_02);
	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
}

//Function Number: 22
announcerglobalplaysqvo(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority","sq",undefined,param_00,1,undefined,level.players);
}

//Function Number: 23
announcerglobalplaysqvowaittilldone(param_00,param_01)
{
	announcerglobalplaysqvo(param_00,param_01);
	maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
}

//Function Number: 24
doblackboxhint(param_00,param_01)
{
	level endon(param_01);
	var_02 = common_scripts\utility::getstruct("blackbox2Use","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,param_01);
		var_02 waittill("activated",var_05);
		playsoundatpos(var_02.origin,"ui_button_error");
		if(gettime() > var_03)
		{
			announcerinworldplaysqvowaittilldone(param_00,var_02.origin,0.5);
			if(!var_04)
			{
				doblackboxhintresponse(var_05,param_00);
				var_04 = 1;
			}

			var_03 = gettime() + 20000;
		}

		wait(1);
	}
}

//Function Number: 25
doblackboxhintresponse(param_00,param_01)
{
	var_02 = -1;
	if(param_01 == 2)
	{
		switch(param_00.characterindex)
		{
			case 0:
				var_02 = 16;
				break;

			case 1:
				var_02 = 13;
				break;

			case 2:
				var_02 = 13;
				break;

			case 3:
				var_02 = 14;
				break;

			default:
				break;
		}
	}
	else if(param_01 == 3)
	{
		switch(param_00.characterindex)
		{
			case 0:
				var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(2);
				var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(1);
				if(isdefined(var_04))
				{
					var_02 = 13;
				}
				else if(isdefined(var_03))
				{
					var_02 = 14;
				}
				else
				{
					var_02 = 15;
				}
				break;

			case 1:
				var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(2);
				if(isdefined(var_03))
				{
					var_02 = randomintrange(10,13);
				}
				else
				{
					var_02 = 11;
				}
				break;

			case 2:
				var_02 = randomintrange(10,13);
				break;

			case 3:
				var_02 = randomintrange(11,14);
				break;

			default:
				break;
		}
	}

	if(var_02 != -1)
	{
		param_00 playerplaysqvo(var_02);
	}
}

//Function Number: 26
stage2_init()
{
}

//Function Number: 27
stage2_logic()
{
	var_00 = common_scripts\utility::getstruct("blackbox2Use","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playerhasbox,undefined,"main_stage2_over");
	var_00 waittill("activated",var_01);
	var_01 playertakebox();
	var_01 playlocalsound("ee_computer_negative");
	var_02 = getent("blackbox2","targetname");
	if(isdefined(var_02))
	{
		var_02 show();
	}

	announcerinworldplaysqvowaittilldone(1,var_00.origin,0.5);
	var_01 thread playerplaysqvo(2,1);
	thread doblackboxhint(2,"main_stage3456_over");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage2");
}

//Function Number: 28
stage2_end(param_00)
{
	var_01 = getent("blackbox2","targetname");
	if(isdefined(var_01))
	{
		var_01 show();
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Blackbox placed, need all ID badges");
}

//Function Number: 29
playerhasbox()
{
	return maps\mp\zombies\_util::is_true(self.hasbox);
}

//Function Number: 30
playergivebox()
{
	setomnvar("ui_zm_ee_player_index",self getentitynumber());
	self.hasbox = 1;
	thread playertakeboxondisconnect();
}

//Function Number: 31
playertakeboxondisconnect()
{
	self endon("playerTakeBox");
	self waittill("disconnect");
	setomnvar("ui_zm_ee_player_index",-1);
}

//Function Number: 32
playertakebox()
{
	if(!isdefined(self.hasbox))
	{
		return;
	}

	setomnvar("ui_zm_ee_player_index",-1);
	self.hasbox = undefined;
	self notify("playerTakeBox");
}

//Function Number: 33
stage3_init()
{
	var_04 = getentarray("cage1","targetname");
	if(var_04.size > 0)
	{
		level.sq_cage1 = var_04[0];
		for(var_05 = 1;var_05 < var_04.size;var_05++)
		{
			var_04[var_05] vehicle_jetbikesethoverforcescale(level.sq_cage1);
		}
	}

	var_06 = getentarray("cage2","targetname");
	if(var_06.size > 0)
	{
		level.sq_cage2 = var_06[0];
		for(var_05 = 1;var_05 < var_06.size;var_05++)
		{
			var_06[var_05] vehicle_jetbikesethoverforcescale(level.sq_cage2);
		}
	}

	var_07 = getent("badge_s3","targetname");
	if(isdefined(var_07))
	{
		var_07 vehicle_jetbikesethoverforcescale(level.sq_cage2);
	}
}

//Function Number: 34
stage3_logic()
{
	var_00 = getentarray("cage1","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	var_01 = getentarray("cage2","targetname");
	if(var_01.size == 0)
	{
		return;
	}

	var_02 = getent("cageWedge","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = getent("badge_s3","targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	foreach(var_05 in level.players)
	{
		var_05 thread playermonitorgroundslam(var_00);
	}

	cagewedgelogic(var_02);
	thread cagewigglelogic();
	thread cagelogic(var_03);
}

//Function Number: 35
stage3_end(param_00)
{
	var_01 = getent("cageWedge","targetname");
	if(isdefined(var_01))
	{
		var_01 delete();
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 1 collected.");
}

//Function Number: 36
cagewedgelogic(param_00)
{
	level endon("main_stage3_over");
	var_01 = 50 * level.players.size;
	var_02 = (-1442,2098,12);
	var_03 = var_02 - param_00.origin;
	var_04 = var_03[0] / var_01;
	var_05 = var_03[1] / var_01;
	var_06 = var_03[2] / var_01;
	param_00.health = 9999;
	param_00 setcandamage(1);
	for(var_07 = 0;var_07 < var_01;var_07++)
	{
		param_00 waittill("damage");
		param_00.health = 9999;
		param_00.origin = param_00.origin + (var_04,var_05,var_06);
		param_00 thread wedgewiggle();
	}

	param_00 moveto(param_00.origin + (0,0,-100),1);
	param_00 playsoundonmovingent("ee_wedge_wiggle_done");
	wait(1);
	level notify("cage_wedge_complete");
}

//Function Number: 37
wedgewiggle()
{
	if(maps\mp\zombies\_util::is_true(self.iswiggling))
	{
		return;
	}

	self.iswiggling = 1;
	self playsoundonmovingent("ee_wedge_wiggle");
	var_00 = randomint(10);
	self rotatepitch(var_00,0.1);
	wait(0.15);
	self rotatepitch(-1 * var_00,0.1);
	wait(0.15);
	self.iswiggling = 0;
}

//Function Number: 38
cagewigglelogic()
{
	level endon("main_stage3_over");
	for(;;)
	{
		level.sq_cage1 waittill("cage1_hit_hard");
		waittillframeend;
		if(maps\mp\zombies\_util::is_true(level.sq_cage1.ismoving))
		{
			continue;
		}

		level wigglecage();
	}
}

//Function Number: 39
wigglecage()
{
	level.sq_cage1 endon("move_start");
	var_00 = level.sq_cage1.origin;
	var_01 = var_00 + (0,0,-20);
	level.sq_cage1 playsoundonmovingent("ee_lift_down_blocked");
	level.sq_cage1.iswiggling = 1;
	level.sq_cage1 moveto(var_01,0.5,0,0.1);
	wait(0.6);
	level.sq_cage1 moveto(var_00,0.5,0.2,0.1);
	wait(0.6);
	level.sq_cage1.iswiggling = undefined;
	level notify("cage_wiggle_complete");
}

//Function Number: 40
cagelogic(param_00)
{
	level endon("main_stage3_over");
	var_01 = 0.5;
	level.sq_cage1.upposition = level.sq_cage1.origin;
	level.sq_cage1.downposition = level.sq_cage1.upposition + (0,0,-154);
	level.sq_cage2.downposition = level.sq_cage2.origin;
	level.sq_cage2.upposition = level.sq_cage2.downposition + (0,0,154);
	for(;;)
	{
		level.sq_cage1 waittill("cage1_hit_hard");
		if(maps\mp\zombies\_util::is_true(level.sq_cage1.iswiggling))
		{
			level.sq_cage1.hitcount = 0;
			continue;
		}

		var_02 = gettime() + var_01 * 1000;
		while(gettime() < var_02 && level.sq_cage1.hitcount < level.players.size)
		{
			wait 0.05;
		}

		if(level.sq_cage1.hitcount == level.players.size)
		{
			level thread movecages(param_00);
			level waittill("cage_move_complete");
		}

		level.sq_cage1.hitcount = 0;
	}
}

//Function Number: 41
movecages(param_00)
{
	level.sq_cage1 notify("move_start");
	level.sq_cage2 notify("move_start");
	level.sq_cage1.ismoving = 1;
	level.sq_cage2.ismoving = 1;
	level.sq_cage1 moveto(level.sq_cage1.downposition,1,0,0.1);
	level.sq_cage2 moveto(level.sq_cage2.upposition,1,0,0.1);
	level.sq_cage1 playsoundonmovingent("ee_lift_down");
	wait(1.1);
	level thread collectbadgestage3(param_00);
	wait(5);
	level.sq_cage2 playsoundonmovingent("ee_lift_up");
	level notify("cage2_reset");
	level.sq_cage1 moveto(level.sq_cage1.upposition,2,0.3,0.5);
	level.sq_cage2 moveto(level.sq_cage2.downposition,2,0.3,0.5);
	wait(2.1);
	level.sq_cage1.ismoving = 0;
	level.sq_cage2.ismoving = 0;
	level notify("cage_move_complete");
}

//Function Number: 42
collectbadgestage3(param_00)
{
	level endon("main_stage3_over");
	level endon("cage2_reset");
	var_01 = 3;
	var_02 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playercancollectstagebadge,var_01,"main_stage3_over");
	var_02 playlocalsound("ee_badge_collected");
	var_02 playerincrementbadge();
	if(var_02.characterindex == var_01)
	{
		var_02 thread playerplaysqvo(3,0.5);
	}

	param_00 delete();
	thread maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage3");
}

//Function Number: 43
playermonitorgroundslam(param_00)
{
	level endon("main_stage3_over");
	for(;;)
	{
		self waittill("ground_slam",var_01);
		if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone("military"))
		{
			continue;
		}

		var_02 = self geteye();
		var_03 = var_02 + (0,0,-100);
		var_04 = bullettrace(var_02,var_03,0,self);
		var_05 = var_04["entity"];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(!common_scripts\utility::array_contains(param_00,var_05))
		{
			continue;
		}

		if(!isdefined(level.sq_cage1.hitcount))
		{
			level.sq_cage1.hitcount = 1;
		}
		else
		{
			level.sq_cage1.hitcount++;
		}

		level.sq_cage1 notify("cage1_hit_hard");
	}
}

//Function Number: 44
stage4_init()
{
}

//Function Number: 45
stage4_logic()
{
	var_00 = common_scripts\utility::getstruct("incinerator_teleport","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = spawnstruct();
	var_01 thread maps\mp\zombies\_teleport::teleport_add_location(var_00);
	level.incinerator_active = 0;
	for(;;)
	{
		level waittill("teleportUse",var_02);
		if(level.incinerator_active)
		{
			continue;
		}

		if(var_02 stage4_is_incinerator_teleporter())
		{
			continue;
		}

		if(level.players.size == 1)
		{
			var_02 stage4_second_teleport_solo_wait(var_01.locations);
			continue;
		}

		var_02 stage4_second_teleport_wait(var_01.locations);
	}
}

//Function Number: 46
stage4_is_incinerator_teleporter()
{
	return isdefined(self.script_noteworthy) && self.script_noteworthy == "incinerator";
}

//Function Number: 47
stage4_second_teleport_solo_wait(param_00)
{
	self endon("teleport_solo_wait");
	thread stage4_second_teleport_solo_timer(5);
	for(;;)
	{
		level waittill("teleportUse",var_01);
		if(var_01 stage4_is_incinerator_teleporter())
		{
			continue;
		}

		var_01 thread stage4_override_teleport_loc(param_00);
		break;
	}

	level thread stage4_run_incinerator();
	self notify("teleport_solo_timer_end");
}

//Function Number: 48
stage4_second_teleport_solo_timer(param_00)
{
	self endon("teleport_solo_timer_end");
	wait(param_00);
	self notify("teleport_solo_wait");
}

//Function Number: 49
stage4_second_teleport_wait(param_00)
{
	self endon("teleportPlayers");
	for(;;)
	{
		level waittill("teleportUse",var_01);
		if(var_01 stage4_is_incinerator_teleporter())
		{
			continue;
		}

		var_01 thread stage4_override_teleport_loc(param_00);
		break;
	}

	thread stage4_override_teleport_loc(param_00);
	level thread stage4_run_incinerator();
}

//Function Number: 50
stage4_override_teleport_loc(param_00)
{
	self.overridelocations = param_00;
}

//Function Number: 51
stage4_run_incinerator()
{
	var_00 = 30;
	level.incinerator_active = 1;
	level notify("incinerator_start");
	level thread stage4_incinerator_ground();
	wait(3);
	level thread stage4_incinerator_pusher(var_00);
	wait(var_00);
	stage4_activate_all_teleporters();
	wait(1);
	stage4_double_check_players_out();
	level.incinerator_active = 0;
	level notify("incinerator_end");
}

//Function Number: 52
stage4_activate_all_teleporters()
{
	foreach(var_01 in level.zombieteleporters)
	{
		if(var_01 stage4_is_incinerator_teleporter())
		{
			var_01 thread stage4_trigger_teleporter();
		}
	}
}

//Function Number: 53
stage4_double_check_players_out()
{
	var_00 = stage4_get_players_in_incinerator();
	stage4_force_players_out(var_00);
}

//Function Number: 54
stage4_get_players_in_incinerator()
{
	var_00 = [];
	var_01 = getent("incinerator_volume","targetname");
	if(isdefined(var_01))
	{
		foreach(var_03 in level.players)
		{
			if(var_03 istouching(var_01))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 55
stage4_force_players_out(param_00)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	if(!param_00.size)
	{
		return;
	}

	var_01 = [];
	foreach(var_03 in level.zombieteleporters)
	{
		if(var_03 stage4_is_incinerator_teleporter())
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = common_scripts\utility::random(var_01);
	var_05 thread maps\mp\zombies\_teleport::teleport_players(param_00);
}

//Function Number: 56
stage4_trigger_teleporter()
{
	while(self.inuse)
	{
		wait 0.05;
	}

	self.start notify("trigger");
}

//Function Number: 57
stage4_incinerator_pusher(param_00)
{
	var_01 = getent("incinerator_mover","targetname");
	var_01.start = var_01.origin;
	var_01.end = common_scripts\utility::getstruct(var_01.target,"targetname").origin;
	var_01.unresolved_collision_func = ::stage4_force_players_out;
	var_01 moveto(var_01.end,param_00);
	var_01 playloopsound("incinerator_room_machine_loop");
	wait(param_00);
	var_01 stoploopsound();
	wait(3);
	var_01.origin = var_01.start;
}

//Function Number: 58
stage4_incinerator_ground()
{
	var_00 = getentarray("incinerator_ground","targetname");
	if(!isdefined(level.incinerator_key))
	{
		var_01 = common_scripts\utility::random(var_00);
		var_02 = common_scripts\utility::getstructarray(var_01.target,"targetname");
		var_03 = (max(var_02[0].origin[0],var_02[1].origin[0]),max(var_02[0].origin[1],var_02[1].origin[1]),0);
		var_04 = (min(var_02[0].origin[0],var_02[1].origin[0]),min(var_02[0].origin[1],var_02[1].origin[1]),0);
		var_05 = (randomfloatrange(var_04[0],var_03[0]),randomfloatrange(var_04[1],var_03[1]),0);
		var_06 = spawn("script_model",var_05 + (0,0,1));
		var_06 setmodel("dlc_badge_decker");
		var_06.hidden = 1;
		var_06 hide();
		var_07 = 0;
		var_06 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::stage4_can_collect_badge,var_07,"main_stage4_over",80);
		var_06 thread stage4_key_pickup();
		level.incinerator_key = var_06;
	}

	common_scripts\utility::array_thread(var_00,::stage4_incinerator_ground_run);
}

//Function Number: 59
stage4_can_collect_badge(param_00)
{
	if(!isdefined(level.incinerator_key) || level.incinerator_key.hidden)
	{
		return 0;
	}

	return playercancollectstagebadge(param_00);
}

//Function Number: 60
stage4_incinerator_ground_run()
{
	level endon("incinerator_end");
	var_00 = 20;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(!isdefined(var_02) && isplayer(var_02))
		{
			continue;
		}

		var_06 = var_02 geteye();
		var_07 = var_06 + anglestoforward(var_02 getplayerangles()) * 5000;
		var_08 = bullettrace(var_06,var_07,0);
		var_04 = var_08["position"];
		playfx(common_scripts\utility::getfx("incinerator_ash"),var_04);
		if(isdefined(level.incinerator_key) && level.incinerator_key.hidden)
		{
			var_09 = distance2d(level.incinerator_key.origin,var_04);
			if(var_09 < var_00)
			{
				level thread stage4_key_show();
			}
		}
	}
}

//Function Number: 61
stage4_key_show()
{
	var_00 = level.incinerator_key;
	var_00 endon("death");
	var_00.hidden = 0;
	var_00 show();
	var_01 = 50;
	var_02 = 0.6;
	var_03 = 5;
	var_00 moveto(var_00.origin + (0,0,var_01),var_02,0,var_02);
	var_04 = 360 * var_03 / var_02 * 2;
	var_00 rotatevelocity((var_04,var_04,0),var_02 * 2);
	wait(var_02);
	var_00 moveto(var_00.origin - (0,0,var_01),var_02,var_02,0);
}

//Function Number: 62
stage4_key_pickup()
{
	self waittill("activated",var_00);
	self delete();
	var_00 playlocalsound("ee_badge_collected");
	var_01 = 0;
	if(var_00.characterindex == var_01)
	{
		var_00 thread playerplaysqvo(3,0.5);
	}

	var_00 playerincrementbadge();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage4");
}

//Function Number: 63
stage4_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 2 collected.");
}

//Function Number: 64
stage5_init()
{
}

//Function Number: 65
stage5_logic()
{
	var_00 = getentarray("execKeypadModel","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	var_01 = getent("securityWindow","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = getent("badge_s5","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_01 show();
	var_02 show();
	var_00 = common_scripts\utility::array_randomize(var_00);
	foreach(var_04 in var_00)
	{
		level thread keypadlogic(var_04);
	}

	foreach(var_07 in level.players)
	{
		var_07 thread playermonitorcure();
	}

	for(var_09 = 0;var_09 < 4;var_09++)
	{
		var_0A = level common_scripts\utility::waittill_any_return_no_endon_death("keyPadUsed","cureStationUsed");
		if(var_0A == "cureStationUsed")
		{
			var_09 = 0;
			foreach(var_07 in level.players)
			{
				var_07.keypaduses = undefined;
			}

			continue;
		}
	}

	level notify("main_stage4_ending");
	var_01 moveto(var_01.origin + (0,40,0),3);
	wait(3.5);
	var_0D = 1;
	var_02 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playercancollectstagebadge,var_0D,"main_stage5_over",80);
	var_02 waittill("activated",var_07);
	var_02 delete();
	var_07 playlocalsound("ee_badge_collected");
	if(var_07.characterindex == var_0D)
	{
		var_07 thread playerplaysqvo(3,0.5);
	}

	var_07 playerincrementbadge();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage5");
}

//Function Number: 66
stage5_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 3 collected.");
	foreach(var_03 in level.players)
	{
		var_03.keypaduses = undefined;
	}
}

//Function Number: 67
keypadlogic(param_00)
{
	level endon("main_stage5_over");
	var_01 = 0;
	for(;;)
	{
		if(var_01)
		{
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"),param_00,"tag_origin");
		}

		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),param_00,"tag_origin");
		param_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playercanactivatekeypad,param_00,"main_stage5_over");
		var_01 = 0;
		param_00 waittill("activated",var_02);
		var_02 playlocalsound("ee_pad_activated");
		level notify("keyPadUsed");
		var_01 = 1;
		maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),param_00,"tag_origin");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"),param_00,"tag_origin");
		var_03 = level common_scripts\utility::waittill_any_return_no_endon_death("cureStationUsed","main_stage4_ending");
		if(var_03 == "main_stage4_ending")
		{
			return;
		}
	}
}

//Function Number: 68
playercanactivatekeypad(param_00)
{
	var_01 = maps\mp\zombies\_util::isplayerinfected(self);
	if(var_01)
	{
		if(!isdefined(self.keypaduses))
		{
			self.keypaduses = 1;
		}
		else if(level.players.size == 2 && self.keypaduses >= 2)
		{
			var_01 = 0;
		}
		else if(level.players.size == 3)
		{
			var_02 = 0;
			foreach(var_04 in level.players)
			{
				if(isdefined(var_04.keypaduses) && var_04.keypaduses >= 2)
				{
					var_02 = 1;
					var_01 = 0;
					break;
				}
			}
		}
		else if(level.players.size == 4 && self.keypaduses >= 1)
		{
			var_01 = 0;
		}
		else
		{
			self.keypaduses++;
		}
	}

	if(!var_01)
	{
		thread playfailfxkeypad(param_00);
	}

	return var_01;
}

//Function Number: 69
playfailfxkeypad(param_00)
{
	if(maps\mp\zombies\_util::is_true(param_00.failfxon))
	{
		return;
	}

	param_00.failfxon = 1;
	param_00 endon("activated");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),param_00,"tag_origin");
	playfxontag(common_scripts\utility::getfx("dlc_prop_biometric_lock_fail"),param_00,"tag_origin");
	param_00 playsoundonmovingent("ui_button_error");
	wait(1);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),param_00,"tag_origin");
	param_00.failfxon = undefined;
}

//Function Number: 70
playermonitorcure()
{
	level endon("main_stage5_over");
	for(;;)
	{
		self waittill("cured");
		level notify("cureStationUsed");
	}
}

//Function Number: 71
playercancollectstagebadge(param_00)
{
	if(self.characterindex == param_00)
	{
		return 1;
	}
	else
	{
		foreach(var_02 in level.players)
		{
			if(var_02.characterindex == param_00)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 72
stage6_init()
{
}

//Function Number: 73
stage6_logic()
{
	for(;;)
	{
		level waittill("magicBoxUse",var_00);
		thread stage6_magicbox(var_00);
	}
}

//Function Number: 74
stage6_magicbox(param_00)
{
	level endon("main_stage6_over");
	param_00 endon("pickupReady");
	if(!isdefined(param_00.modelent))
	{
		return;
	}

	param_00.modelent setcandamage(1);
	for(;;)
	{
		param_00.modelent waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isdefined(var_02) || !isdefined(var_0A))
		{
			continue;
		}

		var_0B = maps\mp\_utility::getbaseweaponname(var_0A);
		if(var_0B != "iw5_em1zm")
		{
			continue;
		}

		break;
	}

	var_0C = 2;
	var_0D = undefined;
	foreach(var_0F in level.players)
	{
		if(var_0F.characterindex == var_0C)
		{
			var_0D = var_0F;
			break;
		}
	}

	if(isdefined(var_0D))
	{
		var_0D clientclaimtrigger(param_00);
	}
	else
	{
		param_00 releaseclaimedtrigger();
	}

	param_00.weaponmodel setmodel("dlc_badge_lilith");
	param_00.magicboxgivefunc = ::stage6_magicbox_give_badge;
	param_00.magicboxpickupstrfunc = ::stage6_magicbox_pickup_str;
	param_00.magicboxcanpickupfunc = ::stage6_magicbox_can_pickup;
	param_00 thread stage6_magicbox_func_cleanup();
}

//Function Number: 75
stage6_magicbox_pickup_str()
{
	return &"ZOMBIES_EMPTY_STRING";
}

//Function Number: 76
stage6_magicbox_can_pickup(param_00)
{
	return 1;
}

//Function Number: 77
stage6_magicbox_give_badge(param_00,param_01)
{
	if(param_00 == "trigger")
	{
		param_01 playlocalsound("ee_badge_collected");
		var_02 = 2;
		if(param_01.characterindex == var_02)
		{
			param_01 thread playerplaysqvo(3,1);
		}

		param_01 playerincrementbadge();
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage6");
	}
}

//Function Number: 78
stage6_magicbox_func_cleanup()
{
	self waittill("magicBoxUseEnd");
	self.magicboxgivefunc = undefined;
	self.magicboxpickupstrfunc = undefined;
	self.magicboxpickupmodel = undefined;
	self.magicboxcanpickupfunc = undefined;
}

//Function Number: 79
stage6_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 4 collected.");
}

//Function Number: 80
stage7_init()
{
	level.processenemykilledfunc = ::processenemykilled;
	level.sq_droppedbadges = [];
	thread doblackboxhint(3,"main_stage7_over");
	foreach(var_01 in level.players)
	{
		if(var_01 playergetbadgecount() <= 0)
		{
			var_01 playerincrementbadge(1);
		}
	}
}

//Function Number: 81
stage7_logic()
{
	for(;;)
	{
		var_00 = 1;
		foreach(var_02 in level.players)
		{
			if(!var_02 playerisbadgeupgradedstage7())
			{
				var_00 = 0;
				break;
			}
		}

		if(var_00)
		{
			break;
		}

		wait 0.05;
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage7");
}

//Function Number: 82
stage7_end(param_00)
{
	level.processenemykilledfunc = undefined;
	foreach(var_02 in level.sq_droppedbadges)
	{
		level thread removebadge(var_02,1);
	}

	level.sq_droppedbadges = undefined;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge fully upgraded.");
}

//Function Number: 83
processenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self))
	{
		return;
	}

	if(isdefined(param_03) && param_03 == "MOD_SUICIDE")
	{
		return;
	}

	if(maps\mp\zombies\_util::istrapweapon(param_04))
	{
		return;
	}

	if(isdefined(param_01) && isplayer(param_01) && maps\mp\_utility::ismeleemod(param_03) && !param_01 playerisbadgeupgradedstage7())
	{
		param_01 playlocalsound("orbital_pkg_use");
		param_01 playerincrementbadge();
		return;
	}

	if(level.sq_droppedbadges.size >= 5)
	{
		return;
	}

	var_09 = randomfloat(1);
	if(var_09 < 0.5)
	{
		level thread dropbadge(self.origin);
	}
}

//Function Number: 84
dropbadge(param_00)
{
	param_00 = param_00 + (0,0,16);
	var_01 = spawn("script_model",param_00);
	var_01.angles = (0,0,0);
	var_01 setmodel("dlc_badge_generic_anim");
	var_01 notsolid();
	var_02 = spawn("trigger_radius",param_00,0,32,32);
	var_01.trigger = var_02;
	level.sq_droppedbadges[level.sq_droppedbadges.size] = var_01;
	var_01 thread badgepickup();
	var_01 thread badgetimer();
	var_01 thread badgeshowtoplayers();
	var_01 thread badgebounce();
}

//Function Number: 85
badgeshowtoplayers()
{
	self hide();
	self.trigger hide();
	foreach(var_01 in level.players)
	{
		if(!var_01 playerisbadgeupgradedstage7())
		{
			self showtoplayer(var_01);
			self.trigger hide();
		}
	}
}

//Function Number: 86
badgebounce()
{
	self scriptmodelplayanimdeltamotion("mp_dogtag_spin","badge");
}

//Function Number: 87
badgepickup()
{
	self endon("deleted");
	var_00 = self.origin;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(isplayer(var_01) && !var_01 playerisbadgeupgradedstage7())
		{
			var_01 playerincrementbadge();
			var_01 playlocalsound("ee_badge_collected_zombies");
			level.pickedupbadges = 1;
			thread removebadge(self);
			return;
		}
	}
}

//Function Number: 88
badgetimer()
{
	self endon("deleted");
	wait(15);
	thread badgestartflashing();
	wait(8);
	level thread removebadge(self);
}

//Function Number: 89
badgestartflashing()
{
	self endon("deleted");
	for(;;)
	{
		self ghost();
		wait(0.25);
		self show();
		wait(0.25);
	}
}

//Function Number: 90
removebadge(param_00,param_01)
{
	param_00 notify("deleted");
	wait 0.05;
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
	if(!maps\mp\zombies\_util::is_true(param_01))
	{
		level.sq_droppedbadges = common_scripts\utility::array_removeundefined(level.sq_droppedbadges);
	}
}

//Function Number: 91
playerisbadgeupgradedstage7()
{
	return playergetbadgecount() >= 49;
}

//Function Number: 92
playergetbadgecount()
{
	if(!isdefined(self.badgeupgradecount))
	{
		return 0;
	}

	return self.badgeupgradecount;
}

//Function Number: 93
playerincrementbadge(param_00)
{
	if(!isdefined(param_00))
	{
		if(!isdefined(self.badgeupgradecount))
		{
			self.badgeupgradecount = 0;
		}

		self.badgeupgradecount++;
	}
	else
	{
		self.badgeupgradecount = param_00;
	}

	self setclientomnvar("ui_zm_ee_int",self.badgeupgradecount);
}

//Function Number: 94
stage8_init()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 playerisbadgeupgradedstage7())
		{
			var_01 playerincrementbadge(49);
		}
	}

	thread doblackboxhint(4,"main_stage8_over");
}

//Function Number: 95
stage8_logic()
{
	var_00 = common_scripts\utility::getstructarray("cardReader","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		level thread cardreaderlogic(var_02);
	}

	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		level waittill("cardReaderUsed");
	}

	wait(2);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage8");
}

//Function Number: 96
stage8_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("All badges used in card readers.");
}

//Function Number: 97
cardreaderlogic(param_00)
{
	level endon("main_stage8_over");
	var_01 = int(param_00.script_noteworthy);
	var_02 = undefined;
	if(isdefined(param_00.target))
	{
		var_02 = getent(param_00.target,"targetname");
	}

	var_02.characterindex = var_01;
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"),var_02,"tag_origin");
	param_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",::playermatchescardreader,var_02,"main_stage8_over");
	param_00 waittill("activated",var_03);
	var_02 notify("activated");
	var_03 playlocalsound("ee_pad_activated");
	var_03 playerincrementbadge();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_pass"),var_02,"tag_origin");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"),var_02,"tag_origin");
	var_04 = 11;
	switch(maps\mp\zombies\_util::get_player_index(var_03))
	{
		case 0:
			var_04 = 9;
			break;

		case 1:
			var_04 = 8;
			break;

		case 2:
			var_04 = 10;
			break;

		case 3:
		default:
			var_04 = 11;
			break;
	}

	announcerinworldplaysqvowaittilldone(var_04,param_00.origin,0.5);
	if(var_03.characterindex == var_01)
	{
		var_03 thread playerplaysqvo(4,0.5);
	}

	level notify("cardReaderUsed");
}

//Function Number: 98
playermatchescardreader(param_00)
{
	var_01 = isdefined(param_00.characterindex) && self.characterindex == param_00.characterindex;
	if(!var_01)
	{
		thread cardreaderfailfx(param_00);
	}

	return var_01;
}

//Function Number: 99
cardreaderfailfx(param_00)
{
	if(maps\mp\zombies\_util::is_true(param_00.failfxon))
	{
		return;
	}

	param_00.failfxon = 1;
	param_00 endon("activated");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"),param_00,"tag_origin");
	playfxontag(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_fail"),param_00,"tag_origin");
	param_00 playsoundonmovingent("ui_button_error");
	wait(1);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"),param_00,"tag_origin");
	param_00.failfxon = undefined;
}

//Function Number: 100
stage9_init()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 playerisbadgeupgradedstage8())
		{
			var_01 playerincrementbadge(50);
		}
	}
}

//Function Number: 101
stage9_logic()
{
	var_00 = common_scripts\utility::getstruct("blackbox2Use","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"main_stage9_over");
	var_00 waittill("activated",var_01);
	announcerinworldplaysqvowaittilldone(5,var_00.origin,0.5);
	thread playblackboxvo(var_00.origin);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage9");
}

//Function Number: 102
stage9_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Black box tells you secrets.");
}

//Function Number: 103
playblackboxvo(param_00)
{
	level.mysteryguyent2 = spawn("script_model",param_00);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer3","mystery_",level.mysteryguyent2,0);
	wait(0.5);
	var_01 = level.mysteryguyent2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq","sq",undefined,1,1,undefined,level.players);
	if(!isdefined(var_01) || !var_01)
	{
		return;
	}
	else
	{
		level.mysteryguyent2 waittill("done_speaking");
		wait(0.5);
		announcerinworldplaysqvowaittilldone(12,param_00);
		wait(0.5);
	}

	if(level.players.size < 4)
	{
		return;
	}

	playsqvowaittilldone(0,17,0.5);
	playsqvowaittilldone(1,14,1);
	playsqvowaittilldone(2,14,0.75);
	playsqvowaittilldone(3,15);
}

//Function Number: 104
playerisbadgeupgradedstage8()
{
	return playergetbadgecount() >= 50;
}

//Function Number: 105
stage10_init()
{
}

//Function Number: 106
stage10_logic()
{
	var_00 = getentarray("exo_terminal","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		level thread exoterminallogic(var_02);
	}

	waittillexoterminalsused();
	maps\mp\zombies\_teleport::teleporter_disable_all();
	thread playrewardvo();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage10");
}

//Function Number: 107
stage10_end(param_00)
{
	level notify("special_weapon_box_unlocked");
	foreach(var_02 in level.players)
	{
		var_02.usedexoterminalsq = undefined;
	}

	var_04 = getent("weapon_upgrade_blocker_model","targetname");
	if(isdefined(var_04))
	{
		var_05 = var_04.origin + (0,0,var_04.offsetmove);
		var_04 moveto(var_05,2,0.5,0.5);
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Super weapon upgrade station unlocked.");
}

//Function Number: 108
waittillexoterminalsused()
{
	var_00 = 0.5;
	for(;;)
	{
		level waittill("sq_terminal_triggered");
		var_01 = gettime() + var_00 * 1000;
		while(gettime() < var_01 && getterminalusecount() < level.players.size)
		{
			wait 0.05;
		}

		if(getterminalusecount() == level.players.size)
		{
			break;
		}

		foreach(var_03 in level.players)
		{
			var_03.usedexoterminalsq = undefined;
		}
	}
}

//Function Number: 109
getterminalusecount()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_02.usedexoterminalsq))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 110
exoterminallogic(param_00)
{
	level endon("main_stage10_over");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01.usedexoterminalsq = 1;
		level notify("sq_terminal_triggered");
	}
}

//Function Number: 111
playrewardvo()
{
	announcerglobalplaysqvowaittilldone(6);
	announcerglobalplaysqvowaittilldone(7,1);
	wait(1);
	thread song_play();
	if(level.players.size < 4)
	{
		return;
	}

	playsqvowaittilldone(2,5,0.5);
	playsqvowaittilldone(1,5,0.5);
	playsqvowaittilldone(0,5,1);
	playsqvowaittilldone(3,5,2);
	playsqvowaittilldone(2,6,1);
	playsqvowaittilldone(1,6,0.5);
	playsqvowaittilldone(0,6,1);
	playsqvowaittilldone(3,6,0.5);
	playsqvowaittilldone(0,7,1);
	playsqvowaittilldone(2,7);
}

//Function Number: 112
stage11_init()
{
	level.heli_crash_nodes = common_scripts\utility::getstructarray("heli_crash_node","targetname");
}

//Function Number: 113
stage11_logic()
{
	var_00 = common_scripts\utility::getstruct("heliStart","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = common_scripts\utility::getstruct("carepackageEnd","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = common_scripts\utility::getstruct("heliEnd1","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	level.warbird = spawnhelicopter(level.players[0],var_00.origin,(0,0,0),"warbird_player_mp","vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak");
	level.warbird.team = "allies";
	level.warbird.heli_type = "warbird";
	var_03 = 40;
	level.warbird vehicle_setspeed(var_03,var_03 / 4,var_03 / 4);
	level.warbird setneargoalnotifydist(100);
	level.warbird setcandamage(1);
	level.warbird.health = 9999;
	maps\mp\_utility::incrementfauxvehiclecount();
	level.warbird thread warbirdtravellogic(var_00);
	level.warbird thread warbirdmonitorhealth(var_01);
	var_04 = monitorplayerslogic();
	level.warbird warbirdwaitlogic(var_00,var_04);
	level.warbird warbirdtraveltoend(var_01,var_02);
	maps\mp\zombies\_teleport::teleporter_enable_all();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage11");
}

//Function Number: 114
warbirdtravellogic(param_00)
{
	level endon("main_stage10_over");
	self endon("stopLoop");
	var_01 = param_00;
	for(;;)
	{
		var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
		if(!isdefined(var_02))
		{
			return;
		}

		self setvehgoalpos(var_02.origin,0);
		self waittill("near_goal");
	}
}

//Function Number: 115
warbirdmonitorhealth(param_00)
{
	level endon("main_stage10_over");
	level endon("warbird_crash_abort");
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(var_0A == level.ocp_weap_name)
		{
			self setcandamage(0);
			thread maps\mp\killstreaks\_aerial_utility::heli_crash();
			thread orbital_package_heli_crash_sound();
			param_00.indoors = 1;
			param_00.start = var_04;
			maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage(param_00);
			return;
		}

		self.health = 9999;
	}
}

//Function Number: 116
orbital_package_heli_crash_sound()
{
	wait(0.75);
	playsoundatpos((433,-306,91),"orbital_pkg_pod_impact");
}

//Function Number: 117
monitorplayerslogic()
{
	level endon("main_stage10_over");
	var_00 = undefined;
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02 maps\mp\zombies\_zombies_zone_manager::isplayerinzone("courtyard"))
			{
				var_00 = var_02;
				break;
			}
		}

		if(isdefined(var_00))
		{
			return var_00;
		}

		wait 0.05;
	}
}

//Function Number: 118
playhelicopterseevo()
{
	if(level.players.size < 4)
	{
		return;
	}

	playsqvowaittilldone(3,7,0.5);
	playsqvowaittilldone(2,8,0.5);
	playsqvowaittilldone(1,8);
}

//Function Number: 119
playhelicopterend1vo()
{
	if(level.players.size < 4)
	{
		return;
	}

	playsqvowaittilldone(0,8,0.1);
	playsqvowaittilldone(3,8,1);
	playsqvowaittilldone(0,9,0.75);
	playsqvowaittilldone(3,9,0.1);
	playsqvowaittilldone(0,10,1);
	playsqvowaittilldone(1,8);
}

//Function Number: 120
playhelicopterend2vo()
{
	if(level.players.size < 4)
	{
		return;
	}

	playsqvowaittilldone(2,9,0.3);
	playsqvowaittilldone(0,11,0.2);
	playsqvowaittilldone(1,9,0.5);
	playsqvowaittilldone(0,12,1);
	playsqvowaittilldone(3,10);
}

//Function Number: 121
warbirdwaitlogic(param_00,param_01)
{
	self notify("stopLoop");
	self setvehgoalpos(param_00.origin,1);
	self setlookatent(param_01);
	common_scripts\utility::waittill_notify_or_timeout("near_goal",10);
	for(;;)
	{
		var_02 = 1;
		foreach(param_01 in level.players)
		{
			if(!param_01 maps\mp\zombies\_zombies_zone_manager::isplayerinzone("courtyard"))
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 122
side_quest_end()
{
	level.side_quest_end = 0;
	while(!maps\mp\zombies\_util::is_true(level.pickedupbadges) && !maps\mp\zombies\_util::is_true(level.wenttolaststand) && !maps\mp\zombies\_util::is_true(level.cheated))
	{
		wait 0.05;
	}

	setomnvar("ui_zm_ee_bool",1);
	level.side_quest_end = 1;
}

//Function Number: 123
warbirdtraveltoend(param_00,param_01)
{
	if(!level.side_quest_end)
	{
		param_00 = undefined;
		var_02 = common_scripts\utility::getstruct("heliEnd2","targetname");
		if(isdefined(var_02))
		{
			param_01 = var_02;
		}
	}

	self setvehgoalpos(param_01.origin,1);
	self clearlookatent();
	if(isdefined(param_00))
	{
		param_00.indoors = 0;
		level.zmkillstreakcrateprevo = 0;
		maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage(param_00);
		var_03 = common_scripts\utility::waittill_any_timeout_no_endon_death(6,"crashing","death");
		if(isdefined(var_03) && var_03 == "timeout" && !maps\mp\zombies\_util::is_true(level.warbird.iscrashing))
		{
			level notify("warbird_crash_abort");
			self setcandamage(0);
			thread maps\mp\killstreaks\_aerial_utility::heli_crash();
		}

		level thread playhelicopterend1vo();
		song_stop();
		set_side_quest_coop_data(0);
		self waittill("death");
		return;
	}

	level thread playhelicopterend2vo();
	thread [[ level.pickup["nuke"]["func"] ]](level.players[0]);
	level.zombiegamepaused = 1;
	wait(6);
	foreach(var_05 in level.players)
	{
		var_05 setclientomnvar("ui_killstreak_remote",1);
		var_05 setclientomnvar("ui_killstreak_blackout",1);
		var_05 setclientomnvar("ui_killstreak_blackout_fade_end",gettime() + 3000);
	}

	wait(6);
	set_side_quest_coop_data(1);
	level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam,game["end_reason"]["zombies_completed"]);
}

//Function Number: 124
set_side_quest_coop_data(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.joinedround1) || !var_02.joinedround1)
		{
			continue;
		}

		var_03 = var_02 getcoopplayerdatareservedint("eggData");
		if(param_00)
		{
			var_03 = var_03 | 3;
			var_02.sidequest = 2;
		}
		else
		{
			var_03 = var_03 | 1;
			var_02.sidequest = 1;
		}

		var_02 setcoopplayerdatareservedint("eggData",var_03);
		setmatchdata("players",var_02.clientid,"startPrestige",var_02.sidequest);
	}
}

//Function Number: 125
stage11_end(param_00)
{
	if(isdefined(level.warbird) && !maps\mp\zombies\_util::is_true(level.warbird.iscrashing))
	{
		level.warbird delete();
		maps\mp\_utility::decrementfauxvehiclecount();
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("The End.");
}

//Function Number: 126
init_song_sidequest()
{
	level.sq_song_ent = getent("sq_song","targetname");
	if(!isdefined(level.sq_song_ent))
	{
		level.sq_song_ent = spawn("script_model",(0,0,0));
	}
}

//Function Number: 127
sidequest_logic_song()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage1");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage2");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage3");
	var_03 = 0;
	for(;;)
	{
		var_04 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over","song_stage2_over","song_stage3_over");
		var_03++;
		if(var_03 < 3)
		{
			thread song_play(var_03);
			continue;
		}

		thread song_play();
		break;
	}
}

//Function Number: 128
song_play(param_00)
{
	level notify("sq_song_play");
	level endon("sq_song_play");
	level endon("sq_song_stop");
	if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing))
	{
		level.sq_song_ent stopsounds();
		level.sq_song_ent.playing = 0;
		wait(0.2);
	}

	var_01 = "zmb_mus_ee_01";
	if(!isdefined(param_00) || param_00 <= 0)
	{
		param_00 = musiclength("zmb_mus_ee_01");
	}
	else
	{
		var_01 = "zmb_mus_ee_01_prvw";
	}

	level.sq_song_ent playsoundonmovingent(var_01);
	level.sq_song_ent.playing = 1;
	wait(param_00);
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
}

//Function Number: 129
song_stop()
{
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
	level notify("sq_song_stop");
}

//Function Number: 130
song_fake_use(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.origin = param_00;
	var_03 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"song_stage" + param_01 + "_over",param_02);
	var_03 waittill("activated",var_04);
	return var_04;
}

//Function Number: 131
songstage1_init()
{
}

//Function Number: 132
songstage1_logic()
{
	var_00 = song_fake_use((1690,1401,122),1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage1");
}

//Function Number: 133
songstage1_end(param_00)
{
}

//Function Number: 134
songstage2_init()
{
}

//Function Number: 135
songstage2_logic()
{
	var_00 = song_fake_use((-508,2318,104),2);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage2");
}

//Function Number: 136
songstage2_end(param_00)
{
}

//Function Number: 137
songstage3_init()
{
}

//Function Number: 138
songstage3_logic()
{
	var_00 = song_fake_use((238,4044,92),3,100);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage3");
}

//Function Number: 139
songstage3_end(param_00)
{
}

//Function Number: 140
musiclength(param_00)
{
	var_01 = tablelookup("mp/sound/soundlength_zm_mp.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 2;
	}

	var_01 = int(var_01);
	var_01 = var_01 * 0.001;
	return var_01;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_conf_center_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 577 ms
 * Timestamp: 4/22/2024 2:30:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	setupconfcentervo();
	thread startconfcenterdialoguethreads();
}

//Function Number: 2
setupconfcentervo()
{
	var_00 = "Burke";
	var_01 = "Ilona";
	level.scr_sound["Ilona"]["grk_iln_prophetpleaseclarify"] = "grk_iln_prophetpleaseclarify";
}

//Function Number: 3
startconfcenterdialoguethreads()
{
	thread confcenterintrodialogue();
	thread confcentersupportadialogue();
	thread confcentersupportbdialogue();
	thread confcentersupportcdialogue();
	thread confcenterkilldialogue();
	thread confcentercombatdialogue();
	thread confcenteroutrodialogue();
}

//Function Number: 4
confcenterintrodialogue()
{
	common_scripts\utility::flag_wait("FlagConfCenterVOStart");
	wait(1);
	thread maps\greece_conf_center::dronecontrolobjdisplay();
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneIntro");
	common_scripts\utility::flag_set("FlagSetObjDroneSupport");
	common_scripts\utility::flag_wait("FlagSniperDroneLaunched");
	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneIntroPrompt");
	thread maps\greece_conf_center::playerinteractdronecontrol();
	common_scripts\utility::flag_wait("FlagPlayerStartDroneInteract");
	wait(3);
	soundscripts\_snd::snd_message("start_drone_launch_music");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneLaunch");
	common_scripts\utility::flag_wait("FlagPlayerStartDroneFlight");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFlight");
	common_scripts\utility::flag_set("FlagMonitorZoomOnHades");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneZoom");
	common_scripts\utility::flag_wait("FlagPlayerZoomOnHades1");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneIntroZoom");
	common_scripts\utility::flag_wait("FlagPlayerEndDroneFlight");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneInPosition");
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportA");
}

//Function Number: 5
confcentersupportadialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginConfCenterSupportA");
	wait(1);
	common_scripts\utility::flag_set("FlagBeginGateSetup");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginSupport");
	thread gateguarddialogue();
	common_scripts\utility::flag_wait("FlagGateGuardsAtAllyVehicle");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginGateSetup");
	thread gateguardreminderdialogue();
	common_scripts\utility::flag_wait("FlagAllyShootGateGuard");
	wait(1);
	if(common_scripts\utility::flag("FlagBodyStashGuardsAlerted"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneGateGuardsAlerted");
	}
	else
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndGateSetupAlt");
	}

	common_scripts\utility::flag_wait("FlagEndGateSetup");
	common_scripts\utility::flag_set("FlagBeginCourtyardSetup");
	if(!common_scripts\utility::flag("FlagAllCourtyardGuardsDead"))
	{
		thread begincourtyarddialogue();
		wait(1);
		thread courtyardguardcheckgatedialogue();
		common_scripts\utility::flag_wait_either("FlagCourtyardAlliesBreachGate","FlagCourtyardAlliesBreachGateAlt");
	}

	wait(0.1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndCourtyardSetup");
	common_scripts\utility::flag_wait("FlagEndCourtyardSetup");
	wait(0.5);
	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneCourtyardClear");
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportB");
}

//Function Number: 6
confcentersupportbdialogue()
{
	level endon("alarm_mission_end");
	level endon("burke_killed");
	common_scripts\utility::flag_wait("FlagBeginConfCenterSupportB");
	wait(0.1);
	common_scripts\utility::flag_set("FlagBeginWalkwaySetup");
	wait(5);
	if(!common_scripts\utility::flag("FlagAllWalkwayGuardsDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndWalkwaySetup");
		common_scripts\utility::flag_wait_either("FlagAllWalkwayGuardsDead","FlagWalkwayAlliesPerformKill");
		wait(1);
		if(common_scripts\utility::flag("FlagWalkwayAlliesPerformKill"))
		{
			thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndStruggleSetup");
		}
		else
		{
			thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdronePoolAllyKill");
		}
	}
	else
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndStruggleSetup");
	}

	wait(1);
	common_scripts\utility::flag_set("FlagBeginStruggleSetup");
	common_scripts\utility::flag_wait("FlagStruggleGuardAttacks");
	wait(2);
	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginStruggleSetup");
	wait 0.05;
	var_00 = playerquickkill(level.playertargets,2,1);
	wait(3);
	if(isdefined(var_00))
	{
		if(var_00 == 1)
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneStruggleKillClean");
		}
		else
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneStruggleKillSloppy");
		}
	}

	common_scripts\utility::flag_set("FlagBeginPoolSetup");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneMoveToPool");
	if(!common_scripts\utility::flag("FlagAllPoolGuardsDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginPoolSetup");
		thread playeridlereminderdialogue("FlagAllPoolGuardsDead");
		common_scripts\utility::flag_wait("FlagAllPoolGuardsDead");
		wait(1);
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndPoolSetup");
	}

	wait(1);
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportC");
}

//Function Number: 7
confcentersupportcdialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginConfCenterSupportC");
	wait(1);
	common_scripts\utility::flag_wait("FlagAtriumAlliesReadyToBreach");
	thread atriumsetupdialogue();
	wait(1);
	common_scripts\utility::flag_set("FlagBeginAtriumSetup");
	thread atriumreminderdialogue();
	thread atriumlookatdialogue();
	thread atriumshootfirstdialogue();
	common_scripts\utility::flag_wait("FlagAtriumEnemiesAllMarked");
	wait 0.05;
	var_00 = playerquickkill(level.playertargets,level.atriumtimewindow * 0.66,1);
	wait(1);
	if(isdefined(var_00))
	{
		soundscripts\_snd::snd_message("stop_atrium_fight");
		if(common_scripts\utility::flag("FlagPlayerShootFirstAtrium"))
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneJumpGunSuccess");
		}
		else if(var_00 == 1)
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneAtriumClearFast");
		}
		else
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneAtriumClearSlow");
		}
	}

	common_scripts\utility::flag_wait("FlagEndAtriumSetup");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndAtriumSetup");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneAtriumStairs");
	wait(1);
	if(!common_scripts\utility::flag("FlagAllRooftopGuardsDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginRooftopSetup");
		wait(1);
		thread rooftopreminderdialogue();
	}

	common_scripts\utility::flag_set("FlagBeginRooftopSetup");
	wait 0.05;
	if(!common_scripts\utility::flag("FlagAllRooftopGuardsDead"))
	{
		var_01 = playerquickkill();
		wait(1);
		if(isdefined(var_01))
		{
			if(var_01 == 1)
			{
				maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndRooftopSetup");
			}
			else
			{
				maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneKillEnemySlow",undefined,undefined,undefined,1);
			}
		}
	}

	common_scripts\utility::flag_wait("FlagEndRooftopSetup");
	if(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		if(!common_scripts\utility::flag("FlagAnyParkingGuardsDead"))
		{
			thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginParkingSetup");
		}

		common_scripts\utility::flag_set("FlagBeginParkingSetup");
		wait(1);
		thread parkingreminderdialogue();
		thread parkinginvestigatorsdialogue();
		thread parkingstairskilldialogue();
		common_scripts\utility::flag_wait("FlagAllParkingGuardsDead");
		wait(1);
	}

	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndParkingSetup");
	common_scripts\utility::flag_wait("FlagAtriumAlliesExit");
	common_scripts\utility::flag_set("FlagBeginConfCenterKill");
	level notify("ConfRoomSetupBreach");
	soundscripts\_snd::snd_message("parking_lot_clear");
}

//Function Number: 8
begincourtyarddialogue()
{
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginCourtyardSetup");
	if(common_scripts\utility::flag("FlagCourtyardAnyOverwatchDead"))
	{
		return;
	}

	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginCourtyardOverwatch");
}

//Function Number: 9
atriumsetupdialogue()
{
	level endon("SniperdroneAtriumPlayerSignalBreach");
	level endon("SniperdroneAtriumPlayerFirstShot");
	level endon("alarm_mission_end");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginAtriumSetup1");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginAtriumSetup2");
}

//Function Number: 10
gateguardreminderdialogue()
{
	wait(3);
	if(!common_scripts\utility::flag("FlagOkayToShootDrone"))
	{
		thread maps\_utility::display_hint("look_at_truck");
	}
}

//Function Number: 11
atriumlookatdialogue()
{
	level endon("SniperdroneAtriumPlayerFirstShot");
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagPlayerLookingAtAtrium");
	common_scripts\utility::flag_set("FlagUnMarkAtrium");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneAtriumStartBreach");
	thread maps\greece_conf_center::monitorplayersignalatriumbreach();
	common_scripts\utility::flag_wait("FlagPlayerSignalAtriumBreach");
	level notify("SniperdroneAtriumPlayerSignalBreach");
	wait(1);
	common_scripts\utility::flag_set("FlagAtriumAlliesPerformBreach");
}

//Function Number: 12
atriumshootfirstdialogue()
{
	level endon("SniperdroneAtriumPlayerSignalBreach");
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagPlayerShootFirstAtrium");
	common_scripts\utility::flag_set("FlagUnMarkAtrium");
	maps\_utility::radio_dialogue_stop();
	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneJumpGun");
	wait(1);
	common_scripts\utility::flag_set("FlagAtriumAlliesPerformBreach");
}

//Function Number: 13
confcenterfailalarmsoundeddialogue()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFailAlert",undefined,undefined,undefined,1);
}

//Function Number: 14
confcenterfailhadeskilledearlydialogue()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFailKillHades");
}

//Function Number: 15
confcenterfailburkekilleddialogue(param_00)
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	if(param_00 == 0)
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFailStruggleSetup");
		return;
	}

	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFailAlert",undefined,undefined,undefined,1);
}

//Function Number: 16
confcenterfailtimerexpiredialogue()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneFailTimerExpire");
}

//Function Number: 17
confcenterfailinvalidtargetdialogue()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneKillEnemyBad",undefined,undefined,undefined,1);
}

//Function Number: 18
confcenterfailtimeoutdialogue()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SniperDroneFailTimeout");
}

//Function Number: 19
playeridlereminderdialogue(param_00,param_01,param_02)
{
	level endon("alarm_mission_end");
	level endon("end_sniper_drone");
	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	wait(param_01);
	var_03 = 0;
	while(!common_scripts\utility::flag(param_00))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneTakingTooLong",undefined,undefined,undefined,1);
		wait(param_01);
		if(param_02 == 1)
		{
			var_03++;
			if(var_03 >= 6)
			{
				thread confcenterfailtimeoutdialogue();
				wait(1);
				common_scripts\utility::flag_set("FlagAlarmMissionEnd");
				maps\greece_conf_center::destroyatriumfighttimer();
				level notify("alarm_mission_end");
			}
		}
	}
}

//Function Number: 20
confcenterkilldialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginConfCenterKill");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginKillHades");
	thread maps\greece_conf_center::monitorzoomonhades2();
	thread confroomreminderdialogue();
	common_scripts\utility::flag_wait("FlagPlayerZoomOnHades2");
	soundscripts\_snd::snd_message("begin_kill_hades_sequence");
	soundscripts\_snd::snd_message("start_hades_transition");
	common_scripts\utility::flag_set("FlagHadesSpeechStarted");
	maps\_utility::delaythread(1,::maps\_hms_utility::playdialog,level.dialogtable,"SniperdroneViewHades");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesSpeech",undefined,undefined,undefined,0,1);
	common_scripts\utility::flag_set("FlagOkayToKillHades");
	level.confhades.default_health = level.confhades.health;
	level.confhades.health = 10000;
	level.confhades.maxhealth = 10000;
	thread hadesreminderdialogue();
	common_scripts\utility::flag_wait("FlagConfHadesDead");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndKillHades");
	common_scripts\utility::flag_wait("FlagConfRoomAlliesBodyScan");
	soundscripts\_snd::snd_message("start_hades_double_stinger");
	soundscripts\_snd::snd_message("hades_rigged_walla");
	var_00 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneNotHades",undefined,"stop_talking",var_00);
	common_scripts\utility::flag_wait("FlagConfRoomAlliesRecover");
	maps\greece_conf_center::markallies();
	soundscripts\_snd::snd_message("start_cc_open_combat");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginCombat");
	common_scripts\utility::flag_wait("FlagConfRoomAlliesExit");
	common_scripts\utility::flag_set("FlagBeginConfCenterCombat");
}

//Function Number: 21
confcentercombatdialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginConfCenterCombat");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginKVAMove");
	wait(1);
	thread combatreminderdialogue();
	common_scripts\utility::flag_wait("FlagSomeAmbushSouthGuardsDead");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEnemyTechnical");
	common_scripts\utility::flag_wait_all("FlagAllAmbushGuardsDead","FlagEnemyVehicleTurretDisabled");
	common_scripts\utility::flag_set("FlagBeginConfCenterOutro");
}

//Function Number: 22
combatreminderdialogue()
{
	level endon("alarm_mission_end");
	wait(10);
	while(!common_scripts\utility::flag("FlagBeginConfCenterOutro"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SupportDroneSupportReminder",undefined,undefined,undefined,1);
		wait(20);
	}
}

//Function Number: 23
confcenteroutrodialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginConfCenterOutro");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneMoreCombat");
	common_scripts\utility::flag_wait("FlagHadesVehicleDriveStart");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesEscape");
	common_scripts\utility::flag_wait("FlagHadesVehicleDroneLaunch");
	wait(0.5);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesLaunchesDrones");
	common_scripts\utility::flag_wait("FlagPlayerEndDroneStatic");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndCombat");
}

//Function Number: 24
gateguarddialogue()
{
	level endon("alarm_mission_end");
	level endon("GateGuardsDead");
	var_00 = maps\_utility::get_living_ai("GatePlayerTarget1","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 endon("death");
		var_00 endon("dying");
		var_00 endon("stop_talking");
		common_scripts\utility::flag_wait("FlagAllyVehicleDriveBy");
		wait(1);
		maps\_hms_utility::playdialog(level.dialogtable,"GateGuardApproachAllyVehicle",undefined,"stop_talking",var_00);
		common_scripts\utility::flag_wait("FlagGateGuardsAtAllyVehicle");
		maps\_hms_utility::playdialog(level.dialogtable,"GateGuardAtAllyVehicle",undefined,"stop_talking",var_00);
		wait(10);
		maps\_hms_utility::playdialog(level.dialogtable,"GateGuardTimeout",undefined,"stop_talking",var_00);
		thread confcenterfailtimeoutdialogue();
		wait(1);
		common_scripts\utility::flag_set("FlagAlarmMissionEnd");
	}
}

//Function Number: 25
courtyardguardcheckgatedialogue()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("CourtyardAllyTarget1","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 endon("death");
		var_00 endon("dying");
		var_00 endon("stop_talking");
		level waittill("GateGuardDialog1");
		maps\_hms_utility::playdialog(level.dialogtable,"CourtyardGuardApproachingGate",undefined,"stop_talking",var_00);
		thread courtyardreminderdialogue();
		level waittill("GateGuardDialog2");
		maps\_hms_utility::playdialog(level.dialogtable,"CourtyardGuardAtGate",undefined,"stop_talking",var_00);
	}
}

//Function Number: 26
courtyardreminderdialogue()
{
	level endon("alarm_mission_end");
	wait(1);
	if(!common_scripts\utility::flag("FlagCourtyardAnyOverwatchDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginCourtyardReminder");
		thread maps\_utility::display_hint_timeout_mintime("courtyard_overwatch",5,3);
		return;
	}

	if(common_scripts\utility::flag("FlagCourtyardAllOverwatchDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginCourtyardNext");
	}
}

//Function Number: 27
walkwayguarddialogue()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("WalkwayAllyTarget1","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 endon("death");
		var_00 endon("dying");
		var_00 endon("stop_talking");
		maps\_hms_utility::playdialog(level.dialogtable,"WalkwayGuardTalkOnPhone",undefined,"stop_talking",var_00);
	}
}

//Function Number: 28
walkwayplayerkilldialogue()
{
	level endon("alarm_mission_end");
	wait(1);
	thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneKillEnemyGood",undefined,undefined,undefined,1);
}

//Function Number: 29
atriumreminderdialogue()
{
	level endon("SniperdroneAtriumPlayerSignalBreach");
	level endon("SniperdroneAtriumPlayerFirstShot");
	level endon("alarm_mission_end");
	wait(10);
	if(!common_scripts\utility::flag("FlagUnMarkAtrium"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginAtriumReminder");
	}

	wait(10);
	thread playeridlereminderdialogue("FlagAtriumAlliesPerformBreach");
	thread maps\_utility::display_hint_timeout_mintime("atrium_view",10,3);
}

//Function Number: 30
rooftopreminderdialogue()
{
	level endon("alarm_mission_end");
	wait(10);
	if(!common_scripts\utility::flag("FlagAllRooftopGuardsDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginRooftopReminder");
		thread playeridlereminderdialogue("FlagAllRooftopGuardsDead");
	}
}

//Function Number: 31
parkingreminderdialogue()
{
	level endon("alarm_mission_end");
	wait(10);
	if(!common_scripts\utility::flag("FlagUnMarkParkingCars"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBeginParkingReminder");
	}

	wait(10);
	thread playeridlereminderdialogue("FlagUnMarkParkingCars");
	thread maps\_utility::display_hint_timeout_mintime("car_alarm",10,3);
}

//Function Number: 32
parkinginvestigatorsdialogue()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("ParkingPlayerTarget1","script_noteworthy");
	var_01 = maps\_utility::get_living_ai("ParkingPlayerTarget2","script_noteworthy");
	var_02 = maps\_utility::get_living_ai("ParkingPlayerTarget3","script_noteworthy");
	if(isdefined(var_00) && isdefined(var_01) && isdefined(var_02))
	{
		var_00 endon("death");
		var_00 endon("dying");
		var_00 endon("stop_talking");
		var_01 endon("death");
		var_01 endon("dying");
		var_01 endon("stop_talking");
		var_02 endon("death");
		var_02 endon("dying");
		var_02 endon("stop_talking");
		common_scripts\utility::flag_wait("FlagParkingGuardsMovingToCar");
		wait(1);
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneParkingCarAlarmActivated");
		wait(1);
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneParkingOneOnStairs");
		wait(1);
		common_scripts\utility::flag_set("FlagParkingAlliesOrderedToKill");
		common_scripts\utility::flag_wait("FlagParkingGuardsNearCar");
		wait(1);
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneParkingGuardsInPosition");
		thread parkingguardsreminderdialogue();
	}
}

//Function Number: 33
parkingstairskilldialogue()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait_either("FlagParkingAlliesPerformKill","FlagParkingPlayerStealKill");
	wait(1);
	if(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneParkingStairsGuardKilled");
	}
}

//Function Number: 34
parkingguardsreminderdialogue()
{
	level endon("alarm_mission_end");
	wait(5);
	while(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneParkingGuardsReminder",undefined,undefined,undefined,1);
		wait(10);
	}
}

//Function Number: 35
confroomreminderdialogue()
{
	level endon("alarm_mission_end");
	var_00 = getent("TriggerConfRoomPlayer","targetname");
	wait(10);
	if(!common_scripts\utility::flag("FlagPlayerZoomOnHades2"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneViewHadesDirection");
	}

	wait(10);
	thread playeridlereminderdialogue("FlagPlayerZoomOnHades2");
	thread maps\_utility::display_hint_timeout_mintime("hades_zoom",10,3);
}

//Function Number: 36
hadesreminderdialogue()
{
	level endon("alarm_mission_end");
	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesShot",undefined,undefined,undefined,0,1);
	}

	wait(1);
	thread hadesspeechdialogue();
	wait(10);
	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesSecondReminder",undefined,"stop_talking",level.confhades,0,1);
	}

	wait(10);
	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesReminder",undefined,"stop_talking",level.confhades,0,1);
	}
}

//Function Number: 37
hadesspeechdialogue()
{
	level endon("alarm_mission_end");
	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneHadesSpeechMore","stop_hades_speech","stop_talking",level.confhades,0,1);
	}

	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		thread maps\greece_conf_center::failkillhadeslate();
	}
}

//Function Number: 38
playerquickkill(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = level.playertargets;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_00.size > 0)
	{
		if(param_02 == 0)
		{
			maps\_utility::waittill_dead_or_dying(param_00,1);
		}

		var_03 = gettime();
		maps\_hms_utility::printlnscreenandconsole("START time: " + var_03 + " milliseconds");
		maps\_utility::waittill_dead_or_dying(param_00);
		var_04 = gettime();
		maps\_hms_utility::printlnscreenandconsole("END time: " + var_04 + " milliseconds");
		var_05 = var_04 - var_03 * 0.001;
		if(var_05 <= param_01)
		{
			maps\_hms_utility::printlnscreenandconsole("Player killed targets QUICKLY: in " + var_05 + " seconds");
			return 1;
		}

		maps\_hms_utility::printlnscreenandconsole("Player killed targets SLOWLY: in " + var_05 + " seconds");
		return 0;
	}
}

//Function Number: 39
playerstealthkill(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.playertargets;
	}

	var_01 = 1;
	var_02 = undefined;
	while(param_00.size > 0)
	{
		param_00 = maps\_utility::array_removedead_or_dying(param_00);
		foreach(var_04 in param_00)
		{
			if(isalive(var_04) && maps\_utility::is_in_array(level.alertedenemies,var_04))
			{
				if(isdefined(var_04.script_noteworthy))
				{
					var_02 = var_04.script_noteworthy;
				}

				var_01 = 0;
			}
		}

		wait 0.05;
	}

	if(var_01 == 0)
	{
		if(isdefined(var_02))
		{
			maps\_hms_utility::printlnscreenandconsole("Player killed targets LOUDLY: " + var_02 + " was alerted");
		}
		else
		{
			maps\_hms_utility::printlnscreenandconsole("Player killed targets LOUDLY: a GUY was alerted");
		}
	}
	else
	{
		maps\_hms_utility::printlnscreenandconsole("Player killed targets QUIETLY!!!");
	}

	return var_01;
}
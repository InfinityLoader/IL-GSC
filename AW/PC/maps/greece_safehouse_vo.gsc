/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_safehouse_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 464 ms
 * Timestamp: 4/22/2024 2:31:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	scancamerainitvariables();
	thread cafeintrodialog();
	thread camerascanintrodialogue();
	thread camerascanoutrodialog();
	thread safehousekilldialogue();
	thread safehouseclearfirstfloordialogue();
	thread safehouseclearsecondfloordialogue();
	thread safehouseplanningguardsdialog();
	thread safehousetransitiondialogue();
	thread safehouseoutrodialogue();
	thread scancameraswitching();
	thread safehousefollowreminder1();
	thread safehousefollowreminder2();
	thread safehousefollowreminder3();
	thread safehousefrontdoorreminder();
	thread safehousecourtyarddistraction();
}

//Function Number: 2
scancamerainitvariables()
{
	level.scancounter = 0;
	level.dialogcounter = 0;
}

//Function Number: 3
cafeintrodialog()
{
	common_scripts\utility::flag_wait("FlagIntroScreenComplete");
}

//Function Number: 4
camerascanintrodialogue()
{
	level endon("lazy_mission_end");
	common_scripts\utility::flag_wait("FlagScanTargetBegin");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedUplink");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedPulse");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeZoomReminder");
	common_scripts\utility::flag_set("FlagCameraScanUnlockZoom");
	level.player waittill("Zoom_In");
	wait(0.5);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedPulseGoodA",undefined,"CancelMarketScanDialog");
	common_scripts\utility::flag_set("FlagCameraScanUnlockVoHints");
	common_scripts\utility::flag_wait("FlagFollowTargetMarked");
	level notify("SafehouseKVATargetMarked");
	common_scripts\utility::flag_set("FlagScanTargetComplete");
	wait(3);
	level.player notify("DisableSecurityCameras");
}

//Function Number: 5
camerascanoutrodialog()
{
	common_scripts\utility::flag_wait("FlagIlanaMidMarketStartMoving");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeYouFollow");
}

//Function Number: 6
scancamerafoundpotentialtarget()
{
	if(!common_scripts\utility::flag("FlagCameraScanUnlockVoHints"))
	{
		return;
	}

	if(level.scancounter == 0)
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedTry",undefined,"CancelMarketScanDialog",undefined,1);
		level.scancounter++;
	}
	else
	{
		return;
	}

	wait(10);
	level.scancounter--;
}

//Function Number: 7
scancameraswitching()
{
	common_scripts\utility::flag_wait("FlagCafeCameraUnlockSwitching");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedSwitch","SafehouseCafeFeedSwitch","CancelMarketScanDialog",undefined,1);
	level.player setclientomnvar("ui_greece_camera_instructions",1);
	while(!common_scripts\utility::flag("FlagMarketCameraSwitched"))
	{
		level endon("MarketCameraSwitch");
		wait(10);
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedSwitch","SafehouseCafeFeedSwitch","CancelMarketScanDialog",undefined,1);
	}
}

//Function Number: 8
scancameratargetdialogue()
{
	level endon("lazy_mission_end");
	level endon("MarketTimerExpired");
	if(self.team == "axis" && !common_scripts\utility::flag("FlagKVATargetWaitTimerExpired"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeSuccess");
		return;
	}

	if(level.dialogcounter == 0)
	{
		level.dialogcounter++;
		return;
	}

	if(level.dialogcounter == 1)
	{
		level.dialogcounter++;
		return;
	}

	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedNo",undefined,"CancelMarketScanDialog",undefined,1);
}

//Function Number: 9
scaninitremindermonitor()
{
	level endon("PlayerInitiateScan");
	level endon("lazy_mission_end");
	var_00 = 0;
	while(!common_scripts\utility::flag("FlagScanTargetBegin"))
	{
		wait(10);
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeFeedReminder",undefined,undefined,undefined,1);
		wait(5);
		var_00++;
		if(var_00 == 3)
		{
			break;
		}
	}

	wait(1);
	if(!common_scripts\utility::flag("FlagScanTargetBegin"))
	{
		thread maps\greece_safehouse::failtargetescaped1();
	}
}

//Function Number: 10
scantakestoolongmonitor()
{
	level endon("SafehouseKVATargetMarked");
	level endon("lazy_mission_end");
	wait(level.markettimewindow - 30);
	while(!common_scripts\utility::flag("FlagFollowTargetMarked"))
	{
		thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeTakingTooLong",undefined,undefined,undefined,1);
		wait(randomfloatrange(8,10));
	}
}

//Function Number: 11
safehousefollowreminder1()
{
	level.player endon("NotifyPlayerReachedMidMarket");
	var_00 = 0;
	common_scripts\utility::flag_wait("FlagCafeVideologComplete");
	wait(30);
	while(!common_scripts\utility::flag("FlagTriggerPlayerMidMarket"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"UndercoverReminder",undefined,undefined,undefined,1);
		var_00++;
		if(var_00 == 3)
		{
			break;
		}

		wait(15);
	}

	wait(1);
	if(!common_scripts\utility::flag("FlagTriggerPlayerMidMarket"))
	{
		thread maps\greece_safehouse::failtargetescaped2();
	}
}

//Function Number: 12
safehousefollowreminder2()
{
	level.player endon("NotifyPlayerReachedAlley");
	var_00 = 0;
	common_scripts\utility::flag_wait("FlagIlanaMidMarketStartMoving");
	wait(30);
	while(!common_scripts\utility::flag("FlagTriggerPlayerEnterAlley"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"UndercoverReminder",undefined,undefined,undefined,1);
		var_00++;
		if(var_00 == 3)
		{
			break;
		}

		wait(15);
	}

	wait(1);
	if(!common_scripts\utility::flag("FlagTriggerStartTakedownTimer"))
	{
		thread maps\greece_safehouse::failtargetescaped2();
	}
}

//Function Number: 13
safehousefollowreminder3()
{
	level.player endon("NotifyPlayerReachedCourtyard");
	var_00 = 0;
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterAlley");
	wait(20);
	while(!common_scripts\utility::flag("FlagTriggerStartTakedownTimer"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"UndercoverReminder",undefined,undefined,undefined,1);
		var_00++;
		if(var_00 == 3)
		{
			break;
		}

		wait(15);
	}

	wait(1);
	if(!common_scripts\utility::flag("FlagTriggerStartTakedownTimer"))
	{
		thread maps\greece_safehouse::failtargetescaped2();
	}
}

//Function Number: 14
safehousecourtyarddistraction()
{
	common_scripts\utility::flag_wait("FlagTriggerStartIlanaTakedownEnter");
	soundscripts\_snd::snd_message("start_kva_assault_music");
	thread safehousecourtyarddistractioninterrupt();
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseDistraction","CourtyardDistractionDialogComplete","CourtyardDistractionDialogInterrupt");
}

//Function Number: 15
safehousecourtyarddistractioninterrupt()
{
	level waittill("PlayerInitiateKeyManKill");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseAlert",undefined,undefined,undefined,1);
}

//Function Number: 16
safehousekilldialogue()
{
	common_scripts\utility::flag_wait("FlagSafehouseCourtyardTakedownComplete");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFollowTargetKilled");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseWeaponReady");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFollowKey");
}

//Function Number: 17
safehousekillreminder()
{
	self endon("death");
	level endon("KVAFollowTargetAlerted");
	self endon("remove_outline");
	var_00 = 0;
	while(isalive(self))
	{
		wait(5);
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFollowTakingTooLong",undefined,undefined,undefined,1);
		var_00++;
		if(var_00 == 3)
		{
			break;
		}
	}

	wait(1);
	if(!common_scripts\utility::flag("FlagTriggerStartTakedownTimer"))
	{
		thread maps\greece_safehouse::failtargetescaped3();
	}
}

//Function Number: 18
xslicestartdialogue()
{
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"XsliceStart");
}

//Function Number: 19
safehousefrontdoorreminder()
{
	level endon("SafehousePlayerNearEntrance");
	common_scripts\utility::flag_wait("FlagFollowTargetUnmarked");
	while(!common_scripts\utility::flag("FlagTriggerPlayerNearBackDoor"))
	{
		wait(15);
		maps\_hms_utility::playdialog(level.dialogtable,"CombatReminder",undefined,undefined,undefined,1);
	}
}

//Function Number: 20
safehouseclearfirstfloordialogue()
{
	level endon("SafehouseAlerted");
	common_scripts\utility::flag_wait("FlagTriggerPlayerNearBackDoor");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseEntrance");
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterSafehouse");
	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseThreatGrenade");
	common_scripts\utility::flag_wait("FlagSafehouseThreatGrenadeDetonated");
	if(!common_scripts\utility::flag("FlagKVASafehousePatrollerDeath"))
	{
		wait(1);
		if(!common_scripts\utility::flag("FlagKVASafehousePatrollerDeath"))
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SafehousePatrolDude");
		}

		common_scripts\utility::flag_wait("FlagKVASafehousePatrollerDeath");
		wait(1.5);
		if(!common_scripts\utility::flag("FlagSafehousePlanningGuardsAlerted"))
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFirstFloorNextKill");
			return;
		}

		return;
	}

	if(common_scripts\utility::flag("FlagKVASafehousePatrollerDeath"))
	{
		wait(1);
		if(!common_scripts\utility::flag("FlagSafehousePlanningGuardsAlerted"))
		{
			maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFirstFloorNextKill");
			return;
		}
	}
}

//Function Number: 21
safehouseplanningguardsdialog()
{
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterSafehouse");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFirstFloorGuardsTalk");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFirstFloorTooLong",undefined,"SafehousePlanningGuardsAlerted");
}

//Function Number: 22
safehouseclearsecondfloordialogue()
{
	common_scripts\utility::flag_wait("FlagFirstFloorSafehouseKVAkilled");
	soundscripts\_snd::snd_message("start_safehouse_guard_02_music");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseFirstFloorClear");
	thread safehousesecondfloorilonacouchkill();
	common_scripts\utility::flag_wait("FlagTriggerPlayerOnInsideStairway");
	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseSecondHadesTalk",undefined,"SafehouseAbortVideoChat",undefined,undefined,undefined,"SafehouseVideoHadesOrg");
	level notify("SafehouseVideoChatConversationStarted");
	wait(1);
	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseSecondHadesWatch");
	level waittill("HadesTalkReallyFinished");
	soundscripts\_snd::snd_message("start_safehouse_guard_03_music");
	wait(1.5);
	if(!common_scripts\utility::flag("FlagPacingGuardDamaged"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseSecondHadesWatchKill");
	}

	thread safehousesecondfloorreminder();
	common_scripts\utility::flag_wait_all("FlagFirstFloorSafehouseKVAkilled","FlagSecondFloorSafehouseKVAkilled");
	common_scripts\utility::flag_set("FlagPacingNpcDeath");
	soundscripts\_snd::snd_message("start_safehouse_stairs_music");
	soundscripts\_snd::snd_message("start_safehouse_exo_trans_music");
	wait(1);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseAllClear");
	common_scripts\utility::flag_set("FlagSafeHouseTransitionStart");
	maps\_utility::autosave_by_name("safehouse_cleared");
}

//Function Number: 23
safehousesecondfloorilonacouchkill()
{
	common_scripts\utility::flag_wait("FlagTriggerSafehouseIlonaUpstairs");
	if(!common_scripts\utility::flag("FlagSafehouseSleepingGuardKilled"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseHesMine");
	}
}

//Function Number: 24
safehousesecondfloorreminder()
{
	var_00 = maps\_utility::get_living_ai("PacingGuard","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 endon("death");
		var_00 endon("PacingGuardDamaged");
		var_01 = 0;
		while(isalive(var_00))
		{
			wait(10);
			maps\_hms_utility::playdialog(level.dialogtable,"SafehouseSecondFloorTakingTooLong",undefined,"guy_alerted",var_00);
			var_01++;
			if(var_01 == 3)
			{
				break;
			}
		}

		wait(1);
		var_02 = common_scripts\utility::getstruct("safehouse_pacing_npc","targetname");
		var_02 notify("PacingGuard");
	}
}

//Function Number: 25
safehousetransitiondialogue()
{
	common_scripts\utility::flag_wait("FlagSafeHouseTransitionStart");
	wait(1);
	common_scripts\utility::flag_set("FlagSetObjComputerInteract");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseTapCom");
	thread safehousebagdropreminder();
	thread maps\greece_safehouse::safehousemonitorbagdropinteract();
	common_scripts\utility::flag_wait("FlagPlayerUsedSafehouseComputer");
	common_scripts\utility::flag_set("FlagComputerInteractComplete");
	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseGearUp");
	maps\greece_safehouse::safehousechangeclothes();
}

//Function Number: 26
safehousebagdropreminder()
{
	wait(10);
	if(!common_scripts\utility::flag("FlagPlayerUsedSafehouseComputer"))
	{
		maps\_hms_utility::playdialog(level.dialogtable,"SafehouseTapComTakingTooLong");
	}
}

//Function Number: 27
safehousefailcoverblown()
{
	common_scripts\utility::flag_set("FlagSafehouseHideHint");
	level notify("SafehouseAlerted");
	maps\_utility::radio_dialogue_stop();
	wait(0.5);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCoverBlown",undefined,undefined,undefined,1);
}

//Function Number: 28
safehousefailkvaalerted()
{
	level notify("SafehouseAlerted");
	maps\_utility::radio_dialogue_stop();
	wait(0.5);
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseAlert",undefined,undefined,undefined,1);
}

//Function Number: 29
safehouseoutrodialogue()
{
	common_scripts\utility::flag_wait("FlagSafeHouseOutroStart");
	soundscripts\_snd::snd_message("mhunt_safehouse_cc_expl_distant");
	maps\greece_conf_center_fx::confcenterexplosion();
	wait(0.2);
	thread maps\_hms_utility::playdialog(level.dialogtable,"SafehouseExitBegin");
	level waittill("NotifyIlonaExitDialog");
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneEndDroneControl");
	soundscripts\_snd::snd_message("safehouse_escape_music");
	common_scripts\utility::flag_set("FlagSetObjSafehouseGapJump");
	wait(0.1);
	maps\_hms_utility::playdialog(level.dialogtable,"SniperdroneBuildingExplode");
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerAtTopOfStairs");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseExitStairs");
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingDownStairs");
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseExitHearVoices");
	common_scripts\utility::flag_set("FlagAlleysTransitionStart");
}

//Function Number: 30
safehousefailtargetescaped()
{
	maps\_utility::radio_dialogue_stop();
	wait 0.05;
	maps\_hms_utility::playdialog(level.dialogtable,"SafehouseCafeNoScanFailure");
}
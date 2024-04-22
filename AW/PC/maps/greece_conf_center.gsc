/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_conf_center.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 282
 * Decompile Time: 4315 ms
 * Timestamp: 4/22/2024 2:30:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	confcenterprecache();
	confcenterflaginit();
	confcenterglobalvars();
	confcenterglobalsetup();
	maps\greece_conf_center_anim::main();
	maps\greece_conf_center_vo::main();
	maps\greece_conf_center_fx::main();
	animscripts\traverse\boost::precache_boost_fx_npc();
	maps\_stealth::main();
	maps\_patrol_extended::main();
	deliverytrucksetup();
	if(level.currentgen)
	{
		thread tff_spawn_vehicles_conf_center();
	}
}

//Function Number: 2
confcenterprecache()
{
	precacheitem("rpg_player");
	precacheitem("stinger");
	precacheitem("hms_kamikazedrone");
	precachemodel("vehicle_civ_full_size_technical_turret");
	precacheturret("50cal_turret_technical_lagos");
	precachemodel("viewhands_atlas_military");
	precachemodel("vb_civilian_mitchell");
	precacheshellshock("greece_drone_slowview");
	precacheshellshock("greece_drone_destroyed");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("iw5_sn6_sp_silencer01");
	precacheitem("iw5_uts19_sp");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp_opticsreddot_silencerpistol");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precachemodel("weapon_parabolic_knife");
	precachemodel("npc_bal27_nocamo");
	precachemodel("greece_drone_control_pad");
	precachemodel("greece_drone_control_pad_touched");
	precachemodel("civ_urban_male_body_f");
	precachemodel("civ_urban_male_body_g");
	precachemodel("body_civ_sf_male_a");
	precachemodel("head_m_act_cau_bedrosian_base");
	precachemodel("head_m_act_asi_chang_base");
	precachemodel("head_male_mp_manasi");
	precacherumble("silencer_fire");
	precacherumble("heavygun_fire");
	precacherumble("subtle_tank_rumble");
	precacherumble("damage_light");
	precacherumble("damage_heavy");
	precacheshader("hud_icon_remoteturret");
	precacheshader("veh_hud_target_offscreen");
	precacheshader("veh_hud_missile_offscreen");
	precacheshader("ac130_hud_friendly_ai_offscreen");
	maps\_controlled_sniperdrone::precacheassets();
	maps\_hms_door_interact::precachedooranimations();
	precachestring(&"GREECE_OBJ_DRONE");
	precachestring(&"GREECE_OBJ_DRONE_POINTER");
	precachestring(&"GREECE_OBJ_POSITION_POINTER");
	precachestring(&"GREECE_OBJ_HADES_POINTER");
	precachestring(&"GREECE_OBJ_ATRIUM_POINTER");
	precachestring(&"GREECE_HINT_DRONE_USE");
	precachestring(&"GREECE_HINT_DRONE_USE_KB");
	maps\_utility::add_hint_string("courtyard_overwatch",&"GREECE_HINT_COURTYARD_OVERWATCH",::hintcourtyardoverwatchoff);
	maps\_utility::add_hint_string("atrium_view",&"GREECE_HINT_ATRIUM",::hintatriumviewoff);
	maps\_utility::add_hint_string("car_alarm",&"GREECE_HINT_CAR_ALARM",::hintcaralarmoff);
	maps\_utility::add_hint_string("hades_zoom",&"GREECE_HINT_HADES_ZOOM",::hinthadeszoomoff);
	maps\_utility::add_control_based_hint_strings("mute_breach",&"GREECE_HINT_MUTE_BREACH",::hintmutebreachoff);
	maps\_utility::add_control_based_hint_strings("drone_zoom",&"GREECE_HINT_DRONE_ZOOM",::hintdronezoomoff,&"GREECE_HINT_DRONE_ZOOM_KB");
	maps\_utility::add_hint_string("support_allies",&"GREECE_HINT_SUPPORT_ALLIES",::hintsupportalliesoff);
	maps\_utility::add_hint_string("look_at_truck",&"GREECE_HINT_LOOK_AT_TRUCK",::hintlookattruckoff);
	precachestring(&"GREECE_DRONE_ALERT_FAIL");
	precachestring(&"GREECE_DRONE_KILLHADES_FAIL");
	precachestring(&"GREECE_DRONE_NOKILLHADES_FAIL");
	precachestring(&"GREECE_DRONE_BURKEKILLED_FAIL");
	precachestring(&"GREECE_DRONE_TIMEREXPIRE_FAIL");
	precachestring(&"GREECE_DRONE_INVALIDTARGET_FAIL");
	precachestring(&"GREECE_ATRIUM_TIMER_LABEL");
}

//Function Number: 3
confcenterflaginit()
{
	common_scripts\utility::flag_init("FlagSetObjDroneSupport");
	if(!common_scripts\utility::flag_exist("FlagAlarmMissionEnd"))
	{
		common_scripts\utility::flag_init("FlagAlarmMissionEnd");
	}

	common_scripts\utility::flag_init("FlagPlayerStartDroneInteract");
	common_scripts\utility::flag_init("FlagPlayerStartDroneFlight");
	common_scripts\utility::flag_init("FlagPlayerEndDroneFlight");
	common_scripts\utility::flag_init("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_init("FlagPlayerEndDroneStatic");
	common_scripts\utility::flag_init("FlagPlayerEndDroneControl");
	common_scripts\utility::flag_init("FlagSniperDroneFlinch");
	common_scripts\utility::flag_init("FlagSniperDroneHit");
	common_scripts\utility::flag_init("FlagSniperDroneAnimating");
	common_scripts\utility::flag_init("FlagSniperDroneLookAt");
	common_scripts\utility::flag_init("FlagBeginConfCenterSupportA");
	common_scripts\utility::flag_init("FlagBeginConfCenterSupportB");
	common_scripts\utility::flag_init("FlagBeginConfCenterSupportC");
	common_scripts\utility::flag_init("FlagBeginConfCenterKill");
	common_scripts\utility::flag_init("FlagBeginConfCenterCombat");
	common_scripts\utility::flag_init("FlagBeginConfCenterOutro");
	common_scripts\utility::flag_init("FlagBeginGateSetup");
	common_scripts\utility::flag_init("FlagBeginCourtyardSetup");
	common_scripts\utility::flag_init("FlagBeginWalkwaySetup");
	common_scripts\utility::flag_init("FlagBeginPoolSetup");
	common_scripts\utility::flag_init("FlagBeginStruggleSetup");
	common_scripts\utility::flag_init("FlagBeginAtriumSetup");
	common_scripts\utility::flag_init("FlagBeginRooftopSetup");
	common_scripts\utility::flag_init("FlagBeginParkingSetup");
	common_scripts\utility::flag_init("FlagEndGateSetup");
	common_scripts\utility::flag_init("FlagEndCourtyardSetup");
	common_scripts\utility::flag_init("FlagEndWalkwaySetup");
	common_scripts\utility::flag_init("FlagEndPoolSetup");
	common_scripts\utility::flag_init("FlagEndStruggleSetup");
	common_scripts\utility::flag_init("FlagEndAtriumSetup");
	common_scripts\utility::flag_init("FlagEndRooftopSetup");
	common_scripts\utility::flag_init("FlagEndParkingSetup");
	common_scripts\utility::flag_init("FlagMonitorZoomOnHades");
	common_scripts\utility::flag_init("FlagPlayerZoomOnHades1");
	common_scripts\utility::flag_init("FlagPlayerZoomOnHades2");
	common_scripts\utility::flag_init("FlagContinueDroneFlyin");
	common_scripts\utility::flag_init("FlagForcePlayerADS");
	common_scripts\utility::flag_init("FlagForcePlayerSlowMovement");
	common_scripts\utility::flag_init("FlagGateBreachComplete");
	common_scripts\utility::flag_init("FlagConfCenterAlliesVulnerable");
	common_scripts\utility::flag_init("FlagAllyVehicleDriveBy");
	common_scripts\utility::flag_init("FlagGateGuardsApproachingAllyVehicle");
	common_scripts\utility::flag_init("FlagGateGuardsAtAllyVehicle");
	common_scripts\utility::flag_init("FlagAllyShootGateGuard");
	common_scripts\utility::flag_init("FlagCourtyardGuardNearGate");
	common_scripts\utility::flag_init("FlagCourtyardAlliesBreachGate");
	common_scripts\utility::flag_init("FlagCourtyardAlliesBreachGateAlt");
	common_scripts\utility::flag_init("FlagCourtyardAnyOverwatchDead");
	common_scripts\utility::flag_init("FlagCourtyardAllOverwatchDead");
	common_scripts\utility::flag_init("FlagWalkwayAlliesPerformKill");
	common_scripts\utility::flag_init("FlagPlayerKillPoolGuard");
	common_scripts\utility::flag_init("FlagStopPoolWater");
	common_scripts\utility::flag_init("FlagPoolKillReady");
	common_scripts\utility::flag_init("FlagPoolKillBegin");
	common_scripts\utility::flag_init("FlagPoolKillSpecial");
	common_scripts\utility::flag_init("FlagCourtyardBurkeJumpCompleted");
	common_scripts\utility::flag_init("FlagStruggleBurkeApproaches");
	common_scripts\utility::flag_init("FlagStruggleGuardAttacks");
	common_scripts\utility::flag_init("FlagStruggleBurkeRecovers");
	common_scripts\utility::flag_init("FlagPlayerLookingAtAtrium");
	common_scripts\utility::flag_init("FlagPlayerSignalAtriumBreach");
	common_scripts\utility::flag_init("FlagPlayerShootFirstAtrium");
	common_scripts\utility::flag_init("FlagAtriumAlliesReadyToBreach");
	common_scripts\utility::flag_init("FlagAtriumEnemiesReactToBreach");
	common_scripts\utility::flag_init("FlagAtriumEnemiesAllMarked");
	common_scripts\utility::flag_init("FlagAtriumAlliesPerformBreach");
	common_scripts\utility::flag_init("FlagAtriumEnemiesAlmostAllDead");
	common_scripts\utility::flag_init("FlagParkingCarAlarmActivated");
	common_scripts\utility::flag_init("FlagParkingCarAlarmDisableAutosave");
	common_scripts\utility::flag_init("FlagUnMarkParkingCars");
	common_scripts\utility::flag_init("FlagParkingGuardsMovingToCar");
	common_scripts\utility::flag_init("FlagParkingAlliesOnStairs");
	common_scripts\utility::flag_init("FlagParkingAlliesOrderedToKill");
	common_scripts\utility::flag_init("FlagParkingAlliesPerformKill");
	common_scripts\utility::flag_init("FlagParkingPlayerStealKill");
	common_scripts\utility::flag_init("FlagParkingGuardsNearCar");
	common_scripts\utility::flag_init("FlagAtriumAlliesExit");
	common_scripts\utility::flag_init("FlagConfRoomAlliesReadyToBreach");
	common_scripts\utility::flag_init("FlagOkayToKillHades");
	common_scripts\utility::flag_init("FlagHadesSpeechStarted");
	common_scripts\utility::flag_init("FlagConfRoomAlliesBodyScan");
	common_scripts\utility::flag_init("FlagConfRoomExplosion");
	common_scripts\utility::flag_init("FlagConfRoomAlliesRecover");
	common_scripts\utility::flag_init("FlagConfRoomAlliesExit");
	common_scripts\utility::flag_init("FlagEnemyVehiclePathEnd");
	common_scripts\utility::flag_init("FlagEnemyVehicleActivateTurret");
	common_scripts\utility::flag_init("FlagEnemyVehicleTurretDisabled");
	common_scripts\utility::flag_init("FlagSpawnEnemyReinforcements");
	common_scripts\utility::flag_init("FlagEnemyReinforcementsDriveEnd");
	common_scripts\utility::flag_init("FlagHadesVehicleDriveStart");
	common_scripts\utility::flag_init("FlagAllGateGuardsDead");
	common_scripts\utility::flag_init("FlagAllCourtyardGuardsDead");
	common_scripts\utility::flag_init("FlagAllWalkwayGuardsDead");
	common_scripts\utility::flag_init("FlagAllPoolGuardsDead");
	common_scripts\utility::flag_init("FlagAllAtriumGuardsDead");
	common_scripts\utility::flag_init("FlagAllRooftopGuardsDead");
	common_scripts\utility::flag_init("FlagAllParkingGuardsDead");
	common_scripts\utility::flag_init("FlagAnyParkingGuardsDead");
	common_scripts\utility::flag_init("FlagSomeAmbushSouthGuardsDead");
	common_scripts\utility::flag_init("FlagAllAmbushSouthGuardsDead");
	common_scripts\utility::flag_init("FlagAllAmbushEastGuardsDead");
	common_scripts\utility::flag_init("FlagAllAmbushVehicleGuardsDead");
	common_scripts\utility::flag_init("FlagAllAmbushGuardsDead");
	common_scripts\utility::flag_init("FlagHadesVehicleDroneLaunch");
	common_scripts\utility::flag_init("FlagPlayerShotConfRoomWindows");
	common_scripts\utility::flag_init("FlagDisableAutosave");
	common_scripts\utility::flag_init("FlagBodyStashGuard1Killed");
	common_scripts\utility::flag_init("FlagBodyStashGuard2Killed");
	common_scripts\utility::flag_init("FlagBodyStashGuardsAlerted");
	common_scripts\utility::flag_init("FlagShowTruckBlood");
	common_scripts\utility::flag_init("FlagOkayToShootDrone");
	common_scripts\utility::flag_init("FlagUnMarkAtrium");
	common_scripts\utility::flag_init("FlagStopPoolWater");
	common_scripts\utility::flag_init("FlagSniperDroneCloakOff");
	common_scripts\utility::flag_init("FlagGreeceTripleKillAchievement");
}

//Function Number: 4
confcenterglobalvars()
{
	setdvarifuninitialized("mission_fail_enabled",1);
	setdvarifuninitialized("level_debug",1);
	setdvarifuninitialized("stealth_debug_prints",0);
	level.showdebugtoggle = 0;
	level.dialogtable = "sp/greece_dialog.csv";
	level.breachactors = [];
	level.confhades = undefined;
	level.allyinfiltrators = [];
	level.infiltratorburke = undefined;
	level.ialliesatgate = 0;
	level.atriumtimer = undefined;
	level.playertargets = [];
	level.allenemypatrollers = [];
	level.allenemyambushers = [];
	level.allenemyvehicles = [];
	level.alerttimedelay = 0;
	level.alertedenemies = [];
	level.bmarkallies = 0;
	level.triplekillcount = 0;
	level.allieswarningtime = undefined;
	level.alliesvulnerabletime = undefined;
	level.hudalerttimer = undefined;
	level.parkingalarmcar = undefined;
	level.bsaveinprogress = undefined;
	level.patrol_scriptedanims = [];
	level.patrol_scriptedanims["casual"] = "casual_stand_idle";
	level.patrol_scriptedanims["bored"] = "patrol_bored_idle";
	level.patrol_scriptedanims["search"] = "so_hijack_search_gear_check_loop";
	level.patrol_scriptedanims["lookdown"] = "prague_sniper_lookout_idle";
	level.patrol_scriptedanims["react"] = "patrol_bored_react_look";
	level.patrol_scriptedanims["shortidle"] = "patrolstand_idle";
	level.patrol_scriptedanims["ready"] = "readystand_idle";
}

//Function Number: 5
confcenterglobalsetup()
{
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	maps\_patrol_anims::main();
	maps\_idle::idle_main();
	maps\_idle_smoke::main();
	maps\_idle_phone::main();
	thread confcenterbegin();
}

//Function Number: 6
confcenterstartpoints()
{
	maps\_utility::add_start("start_conf_center_intro",::initconfcenterintro);
	maps\_utility::add_start("start_conf_center_support1",::initconfcentersupporta);
	maps\_utility::add_start("start_conf_center_support2",::initconfcentersupportb);
	maps\_utility::add_start("start_conf_center_support3",::initconfcentersupportc);
	maps\_utility::add_start("start_conf_center_kill",::initconfcenterkill);
	maps\_utility::add_start("start_conf_center_combat",::initconfcentercombat);
	maps\_utility::add_start("start_conf_center_outro",::initconfcenteroutro);
	maps\greece_starts::add_greece_starts("conference_center");
}

//Function Number: 7
initconfcenterintro()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenterIntro","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	common_scripts\utility::flag_set("FlagSniperDroneLaunched");
	common_scripts\utility::flag_set("FlagConfCenterStart");
	soundscripts\_snd::snd_message("start_conf_center_intro_checkpoint");
}

//Function Number: 8
initconfcentersupporta()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol(0,0);
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveStealthCheck",::autosaveconfcenterstealthcheck,"Can\'t autosave during sniperdrone stealth!");
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportA");
	common_scripts\utility::flag_set("init_begin_confcenter_support_a_lighting");
	soundscripts\_snd::snd_message("start_conf_center_support1_checkpoint");
}

//Function Number: 9
initconfcentersupportb()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveStealthCheck",::autosaveconfcenterstealthcheck,"Can\'t autosave during sniperdrone stealth!");
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportB");
	common_scripts\utility::flag_set("init_begin_confcenter_support_b_lighting");
	soundscripts\_snd::snd_message("start_conf_center_support2_checkpoint");
}

//Function Number: 10
initconfcentersupportc()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveStealthCheck",::autosaveconfcenterstealthcheck,"Can\'t autosave during sniperdrone stealth!");
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterSupportC");
	common_scripts\utility::flag_set("init_begin_confcenter_support_c_lighting");
	soundscripts\_snd::snd_message("start_conf_center_support3_checkpoint");
}

//Function Number: 11
initconfcenterkill()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveStealthCheck",::autosaveconfcenterstealthcheck,"Can\'t autosave during sniperdrone stealth!");
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterKill");
	common_scripts\utility::flag_set("init_begin_confcenter_kill_lighting");
	soundscripts\_snd::snd_message("start_conf_center_kill_checkpoint");
}

//Function Number: 12
initconfcentercombat()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterCombat");
	common_scripts\utility::flag_set("FlagConfRoomAlliesRecover");
	common_scripts\utility::flag_set("FlagSniperDroneFlinch");
	common_scripts\utility::flag_set("init_begin_confcenter_combat_lighting");
	common_scripts\utility::flag_set("FlagSniperDroneCloakOff");
	soundscripts\_snd::snd_message("start_conf_center_combat_checkpoint");
}

//Function Number: 13
initconfcenteroutro()
{
	confcenterobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	thread monitorstartdronecontrol();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartConfCenter",1,1,"IlanaConfCenter");
	thread maps\greece_safehouse::safehousesetupsniperdroneilana();
	maps\greece_safehouse::safehouseforceopensafehousedoor();
	thread maps\greece_safehouse::safehouseremoveplayerblocker();
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	common_scripts\utility::flag_set("FlagAllAmbushGuardsDead");
	common_scripts\utility::flag_set("FlagAllAmbushEastGuardsDead");
	common_scripts\utility::flag_set("FlagEnemyVehicleTurretDisabled");
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("FlagBeginConfCenterOutro");
	common_scripts\utility::flag_set("FlagSniperDroneFlinch");
	common_scripts\utility::flag_set("init_begin_confcenter_outro_lighting");
	common_scripts\utility::flag_set("FlagSniperDroneCloakOff");
	soundscripts\_snd::snd_message("start_conf_center_outro_checkpoint");
}

//Function Number: 14
confcenterobjectivesetup()
{
	waittillframeend;
	confcentersetcompletedobjflags();
	thread setobjsniperdronesupport();
}

//Function Number: 15
confcentersetcompletedobjflags()
{
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_conf_center_"))
	{
		return;
	}

	if(var_00 == "start_conf_center_intro")
	{
		return;
	}

	common_scripts\utility::flag_set("FlagSetObjDroneSupport");
	if(var_00 == "start_conf_center_support1")
	{
		return;
	}

	if(var_00 == "start_conf_center_support2")
	{
		return;
	}

	if(var_00 == "start_conf_center_support3")
	{
		return;
	}

	if(var_00 == "start_conf_center_kill")
	{
		return;
	}

	if(var_00 == "start_conf_center_combat")
	{
		return;
	}

	if(var_00 == "start_conf_center_outro")
	{
	}
}

//Function Number: 16
setobjsniperdronesupport()
{
	common_scripts\utility::flag_wait("FlagSetObjDroneSupport");
	objective_add(maps\_utility::obj("DroneSupport"),"active",&"GREECE_OBJ_DRONE",(0,0,0));
	objective_current(maps\_utility::obj("DroneSupport"));
	common_scripts\utility::flag_wait("FlagPlayerEndDroneControl");
	maps\_utility::objective_complete(maps\_utility::obj("DroneSupport"));
}

//Function Number: 17
confcenterbegin()
{
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	common_scripts\utility::flag_wait("FlagConfCenterStart");
	if(level.currentgen)
	{
		setsaveddvar("r_znear",30);
	}

	confcenterobjectivesetup();
}

//Function Number: 18
playerinteractdronecontrol()
{
	var_00 = getent("InteractDroneControl","targetname");
	thread droneusetrigger();
	common_scripts\utility::flag_wait("FlagPlayerStartDroneInteract");
	objective_position(maps\_utility::obj("DroneSupport"),(0,0,0));
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = level.player.origin;
	var_01.angles = level.player.angles;
	wait(0.5);
	var_02 = maps\_utility::spawn_anim_model("player_safehouse_rig",level.player.origin);
	var_03 = maps\_utility::spawn_anim_model("drone_control_pad",level.player.origin);
	level.player playerlinkto(var_02,"tag_player",0,0,0,0,0);
	var_02.drone_control_pad = var_03;
	var_04 = [var_02,var_03];
	var_01 thread maps\_anim::anim_single(var_04,"drone_launch_control_pad");
	wait(1.25);
	level.player lerpfov(40,0.5);
	level.player setblurforplayer(10,0.5);
	wait(0.25);
	maps\_hud_util::fade_out(0.25,"white");
	if(level.currentgen)
	{
		level notify("tff_pre_intro_to_confcenter");
		unloadtransient("greece_intro_tr");
		loadtransient("greece_confcenter_tr");
		while(!istransientloaded("greece_confcenter_tr"))
		{
			wait(0.05);
		}

		level notify("tff_post_intro_to_confcenter");
	}

	soundscripts\_snd::snd_message("drone_control_pad_end");
	common_scripts\utility::flag_set("FlagPlayerStartDroneFlight");
	thread monitorstartdronecontrol(1,0);
	wait(4);
	common_scripts\utility::flag_set("FlagPlayerStartDroneControl");
	common_scripts\utility::flag_set("init_begin_confcenter_support_a_lighting");
	var_02 delete();
	var_01 delete();
	var_03 delete();
	thread maps\greece_code::blimp_animation("ConfBlimpOrg","cc_blimp");
}

//Function Number: 19
droneusetrigger()
{
	level endon("SafehouseAlerted");
	var_00 = getent("UseTriggerDroneControl","targetname");
	var_00 makeusable();
	var_00 setcursorhint("HINT_NOICON");
	var_00 maps\_utility::addhinttrigger(&"GREECE_HINT_DRONE_USE",&"GREECE_HINT_DRONE_USE_KB");
	var_00 waittill("trigger",var_01);
	var_00 delete();
	common_scripts\utility::flag_set("FlagPlayerStartDroneInteract");
}

//Function Number: 20
hintdroneusetriggeroff()
{
	return common_scripts\utility::flag("FlagPlayerStartDroneInteract");
}

//Function Number: 21
dronecontrolobjdisplay()
{
	var_00 = getent("UseTriggerDroneControl","targetname");
	while(!common_scripts\utility::flag("FlagPlayerStartDroneInteract"))
	{
		if(level.player istouching(var_00))
		{
			objective_position(maps\_utility::obj("DroneSupport"),(0,0,0));
			continue;
		}

		objective_position(maps\_utility::obj("DroneSupport"),var_00.origin);
		wait(0.05);
	}
}

//Function Number: 22
dronecontrolpadscreentouch(param_00)
{
	param_00.drone_control_pad setmodel("greece_drone_control_pad_touched");
	level.player playrumbleonentity("damage_light");
}

//Function Number: 23
monitorstartdronecontrol(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	spawnconfcenterai();
	if(!isdefined(level.player._stealth))
	{
		level.player maps\_stealth_utility::stealth_default();
	}

	level.player enemiesignoreplayerdrone(1);
	var_02 = getent("PlayerDroneTargetpoint","targetname");
	switch(level.start_point)
	{
		case "start_conf_center_support2":
			var_03 = getent("PlayerDroneStartpoint2","targetname");
			var_04 = getent("PlayerDroneLookAt2","targetname");
			break;

		case "start_conf_center_support3":
			var_03 = getent("PlayerDroneStartpoint3","targetname");
			var_04 = getent("PlayerDroneLookAt3","targetname");
			break;

		case "start_conf_center_kill":
			var_03 = getent("PlayerDroneStartpoint4","targetname");
			var_04 = getent("PlayerDroneLookAt4","targetname");
			break;

		case "start_conf_center_outro":
		case "start_conf_center_combat":
			var_03 = getent("PlayerDroneStartpoint5","targetname");
			var_04 = getent("PlayerDroneLookAt5","targetname");
			break;

		default:
			var_03 = getent("PlayerDroneStartpoint1","targetname");
			var_04 = getent("PlayerDroneLookAt1","targetname");
			break;
	}

	var_05 = [];
	var_05[var_05.size] = getent("SniperDroneBottomNW","targetname");
	var_05[var_05.size] = getent("SniperDroneBottomNE","targetname");
	var_05[var_05.size] = getent("SniperDroneBottomSW","targetname");
	var_05[var_05.size] = getent("SniperDroneBottomSE","targetname");
	level.player thread maps\_controlled_sniperdrone::startdronecontrol(var_02,var_03,var_04,param_00,param_01,var_05);
	maps\_compass::setupminimap("compass_map_greece_alt");
	if(param_00 == 1)
	{
		wait(0.25);
		level.player setblurforplayer(0,1);
		wait(0.25);
		maps\_hud_util::fade_in(0.5,"white");
		common_scripts\utility::flag_set("init_confcenter_start_lighting");
	}

	thread monitorparkingcars();
	thread monitorenddronecontrol();
	thread sniperdronedeathwatch();
	thread truckblood();
}

//Function Number: 24
monitorenddronecontrol()
{
	common_scripts\utility::flag_wait("FlagPlayerEndDroneControl");
	maps\_controlled_sniperdrone::enddronecontrol();
	level notify("end_sniper_drone");
	level.player enemiesignoreplayerdrone(0);
	level.allyinfiltrators = maps\_utility::remove_dead_from_array(level.allyinfiltrators);
	maps\_utility::array_notify(level.allyinfiltrators,"remove_outline");
	maps\_utility::array_notify(level.allyinfiltrators,"bloodless");
	maps\_utility::array_delete(level.allyinfiltrators);
	level.allenemypatrollers = maps\_utility::remove_dead_from_array(level.allenemypatrollers);
	maps\_utility::array_notify(level.allenemypatrollers,"remove_outline");
	maps\_utility::array_notify(level.allenemypatrollers,"bloodless");
	maps\_utility::array_delete(level.allenemypatrollers);
	level.allenemyambushers = maps\_utility::remove_dead_from_array(level.allenemyambushers);
	maps\_utility::array_notify(level.allenemyambushers,"remove_outline");
	maps\_utility::array_notify(level.allenemyambushers,"bloodless");
	maps\_utility::array_delete(level.allenemyambushers);
	thread maps\_utility::autosave_by_name("end_drone_control");
	wait(1);
	if(level.nextgen)
	{
		maps\_utility::array_delete(level.allenemyvehicles);
	}
}

//Function Number: 25
sniperdronedeathwatch(param_00)
{
	common_scripts\utility::flag_wait("FlagSniperDroneHit");
	common_scripts\utility::flag_set("FlagSniperDroneAnimating");
	soundscripts\_snd::snd_message("start_wasp_death_explo");
	thread maps\_controlled_sniperdrone::disabledronefiringduringcrash();
	level.player disableweapons();
	level.player shellshock("greece_drone_destroyed",1);
	var_01 = "death";
	param_00 = level.player.sniperdronelink;
	param_00.animname = "sniper_drone_flight";
	param_00 maps\_utility::assign_animtree("sniper_drone_flight");
	playfxontag(common_scripts\utility::getfx("sniperdrone_cc_death_fx"),level.player.sniperdronedata.barrelviewmodel,"TAG_ORIGIN");
	maps\greece_conf_center_fx::confcenterresidualsmoke();
	param_00.frameviewmodel.animname = "sniperdrone_outerparts";
	param_00.frameviewmodel maps\_utility::assign_animtree("sniperdrone_outerparts");
	param_00.barrelviewmodel.animname = "sniperdrone_barrel";
	param_00.barrelviewmodel maps\_utility::assign_animtree("sniperdrone_barrel");
	param_00.frameviewmodel setanim(param_00.frameviewmodel maps\_utility::getanim(var_01));
	param_00.barrelviewmodel setanim(param_00.barrelviewmodel maps\_utility::getanim(var_01));
	var_02 = getanimlength(param_00 maps\_utility::getanim(var_01));
	var_02 = var_02 - 1;
	thread sniperdronedeathshowstatic(var_02);
	param_00 maps\_anim::anim_single_solo(param_00,var_01);
	common_scripts\utility::flag_clear("FlagSniperDroneAnimating");
	if(level.currentgen)
	{
		setsaveddvar("r_znear",4);
		level notify("tff_pre_confcenter_to_intro");
		unloadtransient("greece_confcenter_tr");
		loadtransient("greece_intro_tr");
		while(!istransientloaded("greece_intro_tr"))
		{
			wait(0.05);
		}

		level notify("tff_post_confcenter_to_intro");
	}

	level notify("EndDroneControl");
	common_scripts\utility::flag_set("FlagPlayerEndDroneControl");
}

//Function Number: 26
sniperdronedeathshowstatic(param_00)
{
	wait(param_00);
	common_scripts\utility::flag_set("FlagPlayerEndDroneStatic");
	level notify("StartDroneStatic");
	soundscripts\_snd::snd_message("start_drone_death_static");
}

//Function Number: 27
sniperdroneflyin(param_00)
{
	common_scripts\utility::flag_set("FlagSniperDroneAnimating");
	var_01 = "flyin";
	var_02 = "flyin_idle";
	var_03 = "flyin_end";
	var_04 = common_scripts\utility::getstruct("DroneFlyInOrg","targetname");
	param_00.animname = "sniper_drone_flight";
	param_00 maps\_utility::assign_animtree("sniper_drone_flight");
	var_05 = [param_00];
	var_04 maps\_anim::anim_first_frame_solo(param_00,"flyin");
	level.player setplayerangles(param_00.angles * (1,1,0));
	level.player playerlinktodelta(param_00,"tag_origin",1,10,10,5,5,1);
	param_00.frameviewmodel.animname = "sniperdrone_outerparts";
	param_00.frameviewmodel maps\_utility::assign_animtree("sniperdrone_outerparts");
	param_00.barrelviewmodel.animname = "sniperdrone_barrel";
	param_00.barrelviewmodel maps\_utility::assign_animtree("sniperdrone_barrel");
	if(level.currentgen)
	{
		if(istransientloaded("greece_intro_tr"))
		{
			maps\_utility::transient_unload("greece_intro_tr");
		}
	}

	thread maps\greece_conf_center_fx::confcenterlightglowfx();
	param_00.frameviewmodel setanim(param_00.frameviewmodel maps\_utility::getanim(var_01));
	param_00.barrelviewmodel setanim(param_00.barrelviewmodel maps\_utility::getanim(var_01));
	var_04 maps\_anim::anim_single(var_05,var_01);
	common_scripts\utility::flag_set("FlagMonitorZoomOnHades");
	thread monitorzoomonhades1();
	var_06 = getanimlength(level.scr_anim["sniper_drone_flight"][var_02][0]);
	var_04 thread maps\_anim::anim_loop(var_05,var_02,"end_loop");
	while(!common_scripts\utility::flag("FlagContinueDroneFlyin"))
	{
		wait(var_06);
	}

	var_04 notify("end_loop");
	param_00 stopanimscripted();
	soundscripts\_snd::snd_message("unmute_wasp_oneshots");
	level notify("audio_resume_moving_truck");
	wait(0.05);
	param_00.frameviewmodel setanim(param_00.frameviewmodel maps\_utility::getanim(var_03));
	param_00.barrelviewmodel setanim(param_00.barrelviewmodel maps\_utility::getanim(var_03));
	var_04 maps\_anim::anim_single(var_05,var_03);
	param_00 stopanimscripted();
	common_scripts\utility::flag_set("FlagPlayerEndDroneFlight");
	thread autosavesniperdronestealth("conf_center_fly_in");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveStealthCheck",::autosaveconfcenterstealthcheck,"Can\'t autosave during sniperdrone stealth!");
	common_scripts\utility::flag_clear("FlagSniperDroneAnimating");
}

//Function Number: 28
truckdrivein(param_00)
{
	var_01 = "flyin";
	var_02 = "flyin_end";
	var_03 = common_scripts\utility::getstruct("DroneFlyInOrg","targetname");
	var_04 = getent("BodyStashOrg","targetname");
	var_05 = getent("delivery_truck","targetname");
	soundscripts\_snd::snd_message("start_veh_moving_truck",var_05);
	var_06 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	var_07 = [var_05];
	var_05 hudoutlineenable(2);
	if(param_00 == 0)
	{
		var_03 maps\_anim::anim_single(var_07,var_01);
		common_scripts\utility::flag_wait("FlagContinueDroneFlyin");
	}

	var_03 maps\_anim::anim_single(var_07,var_02);
	var_08 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_09 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_08 show();
	var_09 show();
	var_06 show();
	var_0A = "bodystash_idle";
	var_04 thread maps\_anim::anim_loop_solo(var_06,var_0A,"endBodystashIdle");
	common_scripts\utility::flag_wait_any("FlagBodyStashGuard1Killed","FlagBodyStashGuard2Killed","FlagBodyStashGuardsAlerted");
	var_05 hudoutlinedisable();
}

//Function Number: 29
sniperdroneflyintogglezoomnotetrack(param_00)
{
	if(common_scripts\utility::flag("FlagForcePlayerADS"))
	{
		common_scripts\utility::flag_clear("FlagForcePlayerADS");
	}
	else
	{
		common_scripts\utility::flag_set("FlagForcePlayerADS");
	}

	level.confhades hudoutlineenable(5,0);
	wait(3);
	level.confhades hudoutlinedisable();
}

//Function Number: 30
truckstartwalknotetrack(param_00)
{
	common_scripts\utility::flag_set("FlagAllyVehicleDriveBy");
}

//Function Number: 31
progressionsupportphase1()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginGateSetup");
	maps\_hms_utility::printlnscreenandconsole("--- Begin GATE ---");
	setupvalidtargetsbyname("EnemyPatrolGate");
	common_scripts\utility::flag_wait_any("FlagBodyStashGuard1Killed","FlagBodyStashGuard2Killed","FlagBodyStashGuardsAlerted");
	level notify("disableCourtyardCorpseDetection");
	thread courtyardspecialdetection();
	if(!common_scripts\utility::flag("FlagCourtyardAnyOverwatchDead"))
	{
		thread autosavesniperdronestealth("conf_center_gate_start");
	}

	common_scripts\utility::flag_wait("FlagAllGateGuardsDead");
	if(!common_scripts\utility::flag("FlagCourtyardAnyOverwatchDead"))
	{
		thread autosavesniperdronestealth("conf_center_gate_end");
	}

	maps\_hms_utility::printlnscreenandconsole("--- End GATE ---");
	common_scripts\utility::flag_set("FlagEndGateSetup");
	maps\_hms_utility::printlnscreenandconsole("Allies at GateExt!");
	if(!common_scripts\utility::flag("FlagAllCourtyardGuardsDead"))
	{
		common_scripts\utility::flag_wait("FlagBeginCourtyardSetup");
		maps\_hms_utility::printlnscreenandconsole("--- Begin COURTYARD ---");
		thread setupplayertargets("CourtyardPlayerTarget");
		common_scripts\utility::flag_wait("FlagAllCourtyardGuardsDead");
	}

	common_scripts\utility::flag_wait("FlagGateBreachComplete");
	common_scripts\utility::flag_set("FlagEndCourtyardSetup");
	thread autosavesniperdronestealth("conf_center_courtyard_end");
	maps\_hms_utility::printlnscreenandconsole("--- End COURTYARD ---");
}

//Function Number: 32
progressionsupportphase2()
{
	level endon("alarm_mission_end");
	level endon("burke_killed");
	common_scripts\utility::flag_wait("FlagBeginWalkwaySetup");
	thread atriumdoorsopenonalarm();
	maps\_hms_utility::printlnscreenandconsole("--- Begin WALKWAY ---");
	thread burkecourtyardboostjump();
	thread allywalkwaykill();
	thread allypoolsetup();
	thread atriumbreachmonitoralliesinposition();
	common_scripts\utility::flag_wait_either("FlagAllWalkwayGuardsDead","FlagWalkwayAlliesPerformKill");
	thread autosavesniperdronestealth("conf_center_walkway_end");
	maps\_hms_utility::printlnscreenandconsole("--- End WALKWAY ---");
	common_scripts\utility::flag_set("FlagEndWalkwaySetup");
	common_scripts\utility::flag_wait("FlagBeginStruggleSetup");
	thread autosavesniperdronestealth("conf_center_struggle_start");
	maps\_hms_utility::printlnscreenandconsole("--- Begin STRUGGLE ---");
	thread allysetupstruggle();
	common_scripts\utility::flag_wait("FlagStruggleGuardAttacks");
	wait(2);
	thread setupplayertargets("StrugglePlayerTarget",1,0);
	maps\_utility::waittill_dead(level.playertargets);
	common_scripts\utility::flag_wait("FlagStruggleBurkeRecovers");
	thread autosavesniperdronestealth("conf_center_struggle_end");
	maps\_hms_utility::printlnscreenandconsole("--- End STRUGGLE ---");
	common_scripts\utility::flag_set("FlagEndStruggleSetup");
	if(!common_scripts\utility::flag("FlagAllPoolGuardsDead"))
	{
		thread allyredirectnoteworthy("InfiltratorBurke","Pool");
		common_scripts\utility::flag_wait("FlagBeginPoolSetup");
		maps\_hms_utility::printlnscreenandconsole("--- Begin POOL ---");
		level notify("disablePoolCorpseDetection");
		thread setupplayertargets("PoolPlayerTarget");
		thread setuppoolallytargets();
		common_scripts\utility::flag_wait("FlagAllPoolGuardsDead");
		thread autosavesniperdronestealth("conf_center_pool_end");
		maps\_hms_utility::printlnscreenandconsole("--- End POOL ---");
	}

	common_scripts\utility::flag_set("FlagEndPoolSetup");
	atriumbreachidleburke(0);
	atriumbreachidleinfiltrators(0);
}

//Function Number: 33
progressionsupportphase3()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagAtriumAlliesReadyToBreach");
	common_scripts\utility::flag_wait("FlagBeginAtriumSetup");
	maps\_hms_utility::printlnscreenandconsole("--- Begin ATRIUM ---");
	setupvalidtargetsbyname("EnemyPatrolAtrium");
	thread setobjatrium();
	thread monitorplayershootfirstatrium();
	thread monitorplayerlookingatatrium();
	thread monitoratriumfighttimer();
	thread alliesbreachatriumonalarm();
	common_scripts\utility::flag_wait("FlagAtriumAlliesPerformBreach");
	soundscripts\_snd::snd_message("start_atrium_breach_music");
	thread alliesbreachatrium();
	common_scripts\utility::flag_wait("FlagAtriumEnemiesAllMarked");
	monitoratriumenemieskilled();
	thread autosavesniperdronestealth("conf_center_atrium_start");
	maps\_hms_utility::printlnscreenandconsole("--- End ATRIUM  ---");
	common_scripts\utility::flag_set("FlagEndAtriumSetup");
	thread alliesexitatrium();
	if(!common_scripts\utility::flag("FlagAllRooftopGuardsDead"))
	{
		common_scripts\utility::flag_wait("FlagBeginRooftopSetup");
		maps\_hms_utility::printlnscreenandconsole("--- Begin ROOFTOP ---");
		thread setupplayertargets("RooftopPlayerTarget");
		maps\_utility::waittill_dead(level.playertargets);
		thread autosavesniperdronestealth("conf_center_rooftop_end");
		maps\_hms_utility::printlnscreenandconsole("--- End ROOFTOP ---");
	}

	common_scripts\utility::flag_set("FlagEndRooftopSetup");
	if(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		common_scripts\utility::flag_wait("FlagBeginParkingSetup");
		maps\_hms_utility::printlnscreenandconsole("--- Begin PARKING ---");
		thread alliesparkingkillalt();
		markparkingcars();
		common_scripts\utility::flag_wait("FlagAllParkingGuardsDead");
		_caralarmstop();
		thread autosavesniperdronestealth("conf_center_parking_end");
		maps\_hms_utility::printlnscreenandconsole("--- End PARKING ---");
	}

	common_scripts\utility::flag_set("FlagEndParkingSetup");
}

//Function Number: 34
alliesbreachatriumonalarm()
{
	level waittill("alarm_mission_end");
	if(common_scripts\utility::flag("FlagAtriumAlliesReadyToBreach") && !common_scripts\utility::flag("FlagAtriumAlliesPerformBreach"))
	{
		thread alliesbreachatrium();
	}
}

//Function Number: 35
setobjatrium()
{
	level endon("alarm_mission_end");
	var_00 = getent("PlayerDroneLookAt3","targetname");
	objective_position(maps\_utility::obj("DroneSupport"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("DroneSupport"),&"GREECE_OBJ_ATRIUM_POINTER");
	common_scripts\utility::flag_wait_either("FlagPlayerLookingAtAtrium","FlagPlayerShootFirstAtrium");
	objective_position(maps\_utility::obj("DroneSupport"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("DroneSupport")," ");
}

//Function Number: 36
alliesexitatrium()
{
	thread allyredirectnoteworthy("InfiltratorBurke","AtriumExit");
	thread atriumboostjump();
	maps\greece_code::waittillaiarrayneargoal(level.allyinfiltrators);
	thread burkeopenatriumexitdoor();
	common_scripts\utility::flag_wait("FlagAtriumAlliesExit");
	if(!common_scripts\utility::flag("FlagAnyParkingGuardsDead"))
	{
		thread autosavesniperdronestealth("conf_center_atrium_end");
	}

	thread alliesparkingsetup();
}

//Function Number: 37
burkeopenatriumexitdoor()
{
	var_00 = level.infiltratorburke thread maps\_hms_door_interact::opendoor("AtriumExitDoorStruct","slow");
	var_01 = getent("AtriumExitDoorClip","targetname");
	var_01 delete();
	var_00 waittill("Open");
	common_scripts\utility::flag_set("FlagAtriumAlliesExit");
	thread allyburkeparkingsetup();
}

//Function Number: 38
monitorplayerlookingatatrium()
{
	level endon("SniperdroneAtriumPlayerFirstShot");
	level endon("alarm_mission_end");
	var_00 = getent("AtriumPlayerLookAtTarget","targetname");
	waittillplayerlookattargetintrigger(var_00,"TriggerAtriumPlayer",30,0);
	common_scripts\utility::flag_set("FlagPlayerLookingAtAtrium");
}

//Function Number: 39
monitorplayershootfirstatrium()
{
	level endon("SniperdroneAtriumPlayerSignalBreach");
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai_array("EnemyPatrolAtrium_AI","targetname");
	foreach(var_02 in var_00)
	{
		var_02.noalarm = 1;
	}

	waittillaiarraydeadoralerted(var_00,1);
	level notify("SniperdroneAtriumPlayerFirstShot");
	common_scripts\utility::flag_set("FlagPlayerShootFirstAtrium");
}

//Function Number: 40
waittillaiarraydeadoralerted(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isalive(var_05) && !var_05.ignoreforfixednodesafecheck)
		{
			var_03[var_03.size] = var_05;
		}
	}

	param_00 = var_03;
	var_07 = spawnstruct();
	if(isdefined(param_02))
	{
		var_07 endon("thread_timed_out");
		var_07 thread maps\_utility::waittill_dead_timeout(param_02);
	}

	var_07.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_07.count)
	{
		var_07.count = param_01;
	}

	common_scripts\utility::array_thread(param_00,::waittilldeadoralertedthread,var_07);
	while(var_07.count > 0)
	{
		var_07 waittill("waittill_dead_guy_dead_or_alerted");
	}
}

//Function Number: 41
waittilldeadoralertedthread(param_00)
{
	common_scripts\utility::waittill_any("death","pain_death","guy_alerted");
	param_00.count--;
	param_00 notify("waittill_dead_guy_dead_or_alerted");
}

//Function Number: 42
disablealliescolor()
{
	foreach(var_01 in level.allyinfiltrators)
	{
		var_01 maps\_utility::disable_ai_color();
	}
}

//Function Number: 43
enablealliescolor()
{
	foreach(var_01 in level.allyinfiltrators)
	{
		var_01 maps\_utility::enable_ai_color();
	}
}

//Function Number: 44
atriumboostjump()
{
	var_00 = common_scripts\utility::getstruct("Infiltrator1AtriumBoostJumpOrg","targetname");
	var_01 = common_scripts\utility::getstruct("Infiltrator2AtriumBoostJumpOrg","targetname");
	var_02 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_03 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	thread atriumboostjumpguy(var_02,var_00);
	thread atriumboostjumpguy(var_03,var_01);
}

//Function Number: 45
atriumboostjumpguy(param_00,param_01)
{
	param_00 maps\greece_code::clear_set_goal();
	wait 0.05;
	var_02 = "atrium_boost_jump";
	param_01 maps\_anim::anim_reach_solo(param_00,var_02);
	param_01 maps\_anim::anim_single_solo_run(param_00,var_02);
	thread allyredirectnoteworthy(param_00.script_noteworthy,"AtriumExit");
}

//Function Number: 46
progressionkillhades()
{
	common_scripts\utility::flag_wait("FlagBeginConfCenterKill");
	level.confhades hudoutlineenable(5,0);
	alliesbreachconfroom();
	common_scripts\utility::flag_set("FlagConfRoomAlliesExit");
}

//Function Number: 47
progressioncombat()
{
	common_scripts\utility::flag_wait_either("FlagBeginConfCenterCombat","FlagConfRoomAlliesRecover");
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	thread monitorplayeractivity();
	thread spawnenemiesambusherssouth();
	level.player maps\_utility::set_ignoreme(1);
	maps\_utility::remove_extra_autosave_check("ConfCenterAutosaveStealthCheck");
	thread confcentervehiclesvulnerable();
	wait 0.05;
	thread maps\_utility::autosave_by_name("conf_center_combat");
	maps\_utility::add_extra_autosave_check("ConfCenterAutosaveCombatCheck",::autosaveconfcentercombatcheck,"Can\'t autosave during sniperdrone combat!");
	common_scripts\utility::flag_wait("FlagConfRoomAlliesRecover");
	thread alliesparkingdefend();
	common_scripts\utility::flag_wait("FlagSomeAmbushSouthGuardsDead");
	resetvulnerabletimers();
	thread spawnenemiesambusherseast();
	thread spawnenemyambushvehicle();
}

//Function Number: 48
progressionoutro()
{
	common_scripts\utility::flag_wait("FlagBeginConfCenterOutro");
	resetvulnerabletimers();
	wait(10);
	var_00 = getent("HadesEscapePlayerLookAtTarget","targetname");
	thread maps\_utility::autosave_by_name("conf_center_outro");
	waittillplayerlookattargetintrigger(var_00,"TriggerHadesEscapePlayer",30,0,20);
	level.player maps\_utility::set_ignoreme(0);
	level notify("HadesVehicleDriveStart");
	maps\_utility::remove_extra_autosave_check("ConfCenterAutosaveCombatCheck");
	common_scripts\utility::flag_set("FlagHadesVehicleDriveStart");
	foreach(var_02 in level.allyinfiltrators)
	{
		if(isdefined(var_02))
		{
			if(!isdefined(var_02.magic_bullet_shield) || var_02.magic_bullet_shield == 0)
			{
				var_02 thread maps\_utility::magic_bullet_shield(1);
			}
		}
	}
}

//Function Number: 49
setupplayertargets(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_04 = getaiarray("axis");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	foreach(var_06 in var_04)
	{
		if(isalive(var_06) && isdefined(var_06.script_noteworthy))
		{
			if(common_scripts\utility::string_starts_with(var_06.script_noteworthy,param_00))
			{
				var_03 = common_scripts\utility::add_to_array(var_03,var_06);
			}
		}
	}

	level.playertargets = maps\_utility::array_removedead(level.playertargets);
	level.playertargets = maps\_utility::array_merge(var_03,level.playertargets);
	foreach(var_09 in var_03)
	{
		if(isalive(var_09))
		{
			var_09 thread markplayertarget(param_01,param_02);
		}
	}
}

//Function Number: 50
markplayertarget(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_00 == 1)
	{
		maps\greece_code::setalertoutline();
	}
	else
	{
		maps\greece_code::settargetoutline();
	}

	var_02 = undefined;
	for(var_03 = 0;var_03 < level.playertargets.size;var_03++)
	{
		if(self == level.playertargets[var_03])
		{
			var_02 = var_03;
		}
	}

	var_04 = var_02 + 1;
	if(param_01 == 1)
	{
		thread objmarkerplayertarget(var_04);
	}
}

//Function Number: 51
monitormarkedplayertarget(param_00,param_01)
{
	level endon("end_sniper_drone");
	self endon("death");
	self endon("dying");
	self endon("guy_alerted");
	self endon("removeTargetObj");
	wait(0.1);
	if(param_01 == 1)
	{
		thread objmarkerplayertarget(param_00);
	}
}

//Function Number: 52
objmarkerplayertarget(param_00)
{
	objective_setpointertextoverride(maps\_utility::obj("DroneSupport")," ");
	wait(0.05);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"TAG_EYE",(0,0,12),(0,0,0));
	objective_additionalentity(maps\_utility::obj("DroneSupport"),param_00,var_01);
	common_scripts\utility::waittill_any("death","dying","removeTargetObj");
	objective_additionalposition(maps\_utility::obj("DroneSupport"),param_00,(0,0,0));
	var_01 delete();
}

//Function Number: 53
removeplayertarget()
{
	self notify("removeTargetObj");
	level.playertargets common_scripts\utility::array_remove(level.playertargets,self);
	if(target_istarget(self))
	{
		target_remove(self);
	}

	self hudoutlineenable(1,1);
}

//Function Number: 54
clearplayertargetlist()
{
	level.playertargets = maps\_utility::array_removedead(level.playertargets);
	foreach(var_01 in level.playertargets)
	{
		level.playertargets = common_scripts\utility::array_remove(level.playertargets,var_01);
	}
}

//Function Number: 55
objmarkervehicle(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_01 == 1)
	{
		objective_onentity(maps\_utility::obj("DroneSupport"),self,(0,0,64));
		objective_setpointertextoverride(maps\_utility::obj("DroneSupport"),&"GREECE_OBJ_HADES_POINTER");
	}

	thread objoutlinevehicle(param_02,param_00);
	common_scripts\utility::flag_wait(param_00);
	level notify(param_00);
	self hudoutlinedisable();
	if(param_01 == 1)
	{
		objective_position(maps\_utility::obj("DroneSupport"),(0,0,0));
	}
}

//Function Number: 56
objoutlinevehicle(param_00,param_01)
{
	level endon(param_01);
	if(param_00 == 1)
	{
		wait(20);
	}

	if(level.nextgen)
	{
		self hudoutlineenable(1,1);
		return;
	}

	foreach(var_03 in level.sniper_marked_cars)
	{
		var_03 hudoutlineenable(1,1);
	}
}

//Function Number: 57
spawnconfcenterai()
{
	setsaveddvar("r_hudoutlineenable",1);
	spawnallyinfiltrators();
	thread spawnhadesescapevehicle();
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_conf_center_") || var_00 == "start_conf_center_intro" || var_00 == "start_conf_center_support1" || var_00 == "start_conf_center_support2" || var_00 == "start_conf_center_support3" || var_00 == "start_conf_center_kill" || var_00 == "start_conf_center_combat")
	{
		if(var_00 != "start_conf_center_support2" && var_00 != "start_conf_center_support3" && var_00 != "start_conf_center_kill" && var_00 != "start_conf_center_combat")
		{
			spawnenemiespatrollersa();
			thread progressionsupportphase1();
		}

		if(var_00 != "start_conf_center_support3" && var_00 != "start_conf_center_kill" && var_00 != "start_conf_center_combat")
		{
			spawnenemiespatrollersb();
			thread progressionsupportphase2();
		}

		if(var_00 != "start_conf_center_kill" && var_00 != "start_conf_center_combat")
		{
			spawnenemiespatrollersc();
			thread progressionsupportphase3();
		}

		if(var_00 != "start_conf_center_combat")
		{
			thread monitorlevelalarm();
			thread monitorconfroomwindows();
			thread confroomsetup();
		}

		thread progressioncombat();
	}

	thread spawnenemiesextra();
	thread progressionoutro();
	initconfcenterstealthsettings();
	initalerttime();
}

//Function Number: 58
spawnallyinfiltrators()
{
	maps\_utility::array_spawn_function_targetname("AllyInfiltrator",::thinkallyinfiltrator);
	level.allyinfiltrators = maps\_utility::array_spawn_targetname("AllyInfiltrator");
	level.allyinfiltrators = maps\_utility::array_index_by_script_index(level.allyinfiltrators);
	level.infiltratorburke = level.allyinfiltrators[0];
	level.infiltratorburke.name = "Gideon";
	level.infiltratorburke.animname = "infiltratorburke";
	level.infiltratorburke.script_parameters = "Gideon";
	level.infiltratorburke maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01","primary");
	level.allyinfiltrators[1] maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01","primary");
	level.allyinfiltrators[1].name = "Drelick";
	level.allyinfiltrators[1].animname = "infiltrator1";
	level.allyinfiltrators[1].script_parameters = "Drelick";
	level.allyinfiltrators[2] maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01","primary");
	level.allyinfiltrators[2].name = "Baron";
	level.allyinfiltrators[2].animname = "infiltrator2";
	level.allyinfiltrators[2].script_parameters = "Baron";
	wait(0.05);
	var_00 = level.start_point;
	if(var_00 == "start_conf_center_support1")
	{
		alliesdrivein(0,1);
		return;
	}

	if(var_00 == "start_conf_center_support2")
	{
		thread alliesredirect("GateInt",0,1);
		markallies();
		wait(0.05);
		alliesdrivein(1,0);
		return;
	}

	if(var_00 == "start_conf_center_support3")
	{
		atriumbreachidleinfiltrators(1);
		atriumbreachidleburke(1);
		markallies();
		wait(0.05);
		common_scripts\utility::flag_set("FlagAtriumAlliesReadyToBreach");
		alliesdrivein(1,0);
		return;
	}

	if(var_00 == "start_conf_center_kill")
	{
		thread alliesredirect("ParkingStairs1",0,1);
		markallies();
		alliesdrivein(1,0);
		return;
	}

	if(var_00 == "start_conf_center_combat")
	{
		allyconfroomdeath(1);
		thread alliesredirect("ConfRoomExit",0,1);
		markallies();
		alliesdrivein(1,0);
		return;
	}

	if(var_00 == "start_conf_center_outro")
	{
		allyconfroomdeath(1);
		thread alliesredirect("ParkingEnd",0,1);
		maps\_utility::activate_trigger_with_targetname("TrigBurke107");
		maps\_utility::activate_trigger_with_targetname("TrigAllies107");
		markallies();
		alliesdrivein(1,0);
		return;
	}

	thread alliesdrivein(0,0);
}

//Function Number: 59
spawnenemiespatrollersa()
{
	maps\_utility::array_spawn_function_targetname("EnemyPatrolGate",::thinkpatrolenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyPatrolGate");
	level.allenemypatrollers = maps\_utility::array_merge(var_00,level.allenemypatrollers);
	thread enemypatrolgatethread(var_00);
	maps\_utility::array_spawn_function_targetname("EnemyPatrolCourtyard",::thinkpatrolenemy);
	var_01 = maps\_utility::array_spawn_targetname("EnemyPatrolCourtyard");
	level.allenemypatrollers = maps\_utility::array_merge(var_01,level.allenemypatrollers);
	thread enemypatrolcourtyardthread(var_01);
	setupvalidtargetsbyarray(var_01);
}

//Function Number: 60
spawnenemiespatrollersb()
{
	maps\_utility::array_spawn_function_targetname("EnemyPatrolWalkway",::thinkpatrolenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyPatrolWalkway");
	level.allenemypatrollers = maps\_utility::array_merge(var_00,level.allenemypatrollers);
	thread enemypatrolwalkwaythread(var_00);
	setupvalidtargetsbyarray(var_00);
	maps\_utility::array_spawn_function_targetname("EnemyPatrolPool",::thinkpatrolenemy);
	var_01 = maps\_utility::array_spawn_targetname("EnemyPatrolPool");
	level.allenemypatrollers = maps\_utility::array_merge(var_01,level.allenemypatrollers);
	thread enemypatrolpoolthread(var_01);
	setupvalidtargetsbyarray(var_01);
}

//Function Number: 61
spawnenemiespatrollersc()
{
	maps\_utility::array_spawn_function_targetname("EnemyPatrolAtrium",::thinkpatrolenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyPatrolAtrium");
	level.allenemypatrollers = maps\_utility::array_merge(var_00,level.allenemypatrollers);
	thread enemypatrolatriumthread(var_00);
	maps\_utility::array_spawn_function_targetname("EnemyPatrolRooftop",::thinkpatrolenemy);
	var_01 = maps\_utility::array_spawn_targetname("EnemyPatrolRooftop");
	level.allenemypatrollers = maps\_utility::array_merge(var_01,level.allenemypatrollers);
	thread enemypatrolrooftopthread(var_01);
	setupvalidtargetsbyarray(var_01);
	maps\_utility::array_spawn_function_targetname("EnemyPatrolParking",::thinkpatrolenemy);
	var_02 = maps\_utility::array_spawn_targetname("EnemyPatrolParking");
	level.allenemypatrollers = maps\_utility::array_merge(var_02,level.allenemypatrollers);
	thread enemypatrolparkingthread(var_02);
	setupvalidtargetsbyarray(var_02);
}

//Function Number: 62
spawnenemiesextra()
{
	maps\_utility::array_spawn_function_targetname("EnemyPatrolExtra",::thinkpatrolenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyPatrolExtra");
	level.allenemypatrollers = maps\_utility::array_merge(var_00,level.allenemypatrollers);
	setupvalidtargetsbyarray(var_00);
	thread maps\greece_code::aiarrayidleloop(var_00);
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::set_ignoreall(1);
		var_02 maps\_utility::set_ignoreme(1);
	}

	common_scripts\utility::flag_wait_either("FlagConfRoomExplosion","FlagBeginConfCenterCombat");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	level.allenemyambushers = maps\_utility::array_merge(var_00,level.allenemyambushers);
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "ExtraPlayerTarget3")
		{
			var_02 kill();
			continue;
		}

		var_02 thread extraenemiescombat();
	}
}

//Function Number: 63
extraenemiescombat()
{
	self endon("death");
	maps\_utility::enable_arrivals();
	maps\_utility::enable_exits();
	maps\greece_code::enableawareness();
	maps\_utility::clear_run_anim();
	maps\_stealth_utility::disable_stealth_for_ai();
	self notify("end_patrol");
	self notify("new_anim_reach");
	disableenemyalert();
	thread notifyonplayerkill();
	self notify("guy_alerted");
	wait 0.05;
	maps\_utility::set_ignoreall(0);
	maps\_utility::set_ignoreme(0);
	self.enemyteam = "allies";
	self.alertlevel = "combat";
	self.combatmode = "cover";
	aiidleloopdisable(1);
	thread maps\_utility::set_battlechatter(1);
	var_00 = maps\_utility::get_closest_ai(self.origin,self.enemyteam);
	if(isdefined(var_00))
	{
		maps\_utility::set_favoriteenemy(var_00);
	}

	var_01 = getent("EnemyAmbushParkingVol","targetname");
	self setgoalvolumeauto(var_01);
	common_scripts\utility::flag_wait_either("FlagBeginConfCenterCombat","FlagConfRoomAlliesRecover");
	maps\greece_code::setalertoutline();
	markdronetargetenemy();
	thread maps\greece_code::clearalertoutline();
	common_scripts\utility::flag_wait("FlagSomeAmbushSouthGuardsDead");
	var_01 = getent("EnemyAmbushEastFallbackVol","targetname");
	self setgoalvolumeauto(var_01);
}

//Function Number: 64
spawnenemystruggle()
{
	var_00 = getent("EnemyPatrolStruggle","targetname");
	var_00 maps\_utility::add_spawn_function(::thinkpatrolenemy);
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01 maps\_utility::set_ignoreme(1);
	var_01.no_stopanimscripted = 1;
	var_01 maps\_stealth_utility::disable_stealth_for_ai();
	var_01 maps\_utility::disable_danger_react();
	var_01 maps\_utility::disable_bulletwhizbyreaction();
	var_01 maps\_utility::forceuseweapon("iw5_uts19_sp","primary");
	level.allenemypatrollers = common_scripts\utility::add_to_array(level.allenemypatrollers,var_01);
	return var_01;
}

//Function Number: 65
spawnenemiesambusherssouth()
{
	wait(3);
	maps\_utility::array_spawn_function_targetname("EnemyAmbushSouth",::thinkambushenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyAmbushSouth");
	thread enemyambushsouthopendoors();
	var_01 = maps\_utility::get_living_ai_array("EnemyPatrolExtra_AI","targetname");
	var_00 = maps\_utility::array_merge(var_01,var_00);
	level.allenemyambushers = maps\_utility::array_merge(var_00,level.allenemyambushers);
	foreach(var_03 in var_00)
	{
		var_03.oldfightdist = var_03.pathenemyfightdist;
		var_03.pathenemyfightdist = 8;
	}

	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	waittillenemiesreducedto(3,var_00);
	common_scripts\utility::flag_set("FlagSomeAmbushSouthGuardsDead");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	foreach(var_03 in var_00)
	{
		var_03.pathenemyfightdist = var_03.oldfightdist;
		var_03 thread enemyambushsouthshiftvol();
	}
}

//Function Number: 66
enemyambushsouthopendoors()
{
	var_00 = getentarray("SouthDoorClip","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_04 = getentarray("EnemyAmbushSouthDoor","targetname");
	foreach(var_06 in var_04)
	{
		if(var_06.script_noteworthy == "SouthDoor1")
		{
			var_07 = 120;
		}
		else
		{
			var_07 = -120;
		}

		var_08 = randomfloatrange(0.25,0.45);
		var_06 rotateto(var_06.angles + (0,var_07,0),var_08,0,0.2);
	}
}

//Function Number: 67
enemyambushsouthshiftvol()
{
	self endon("death");
	if(self.script_noteworthy == "Low")
	{
		var_00 = getent("EnemyAmbushEastFallbackVol","targetname");
		self setgoalvolumeauto(var_00);
	}
	else if(self.script_noteworthy == "Stairs")
	{
		var_00 = getent("EnemyAmbushBridgeVol","targetname");
		self setgoalvolumeauto(var_00);
	}
	else if(self.script_noteworthy == "High")
	{
		var_00 = getent("EnemyAmbushSouthHighVol1","targetname");
		self setgoalvolumeauto(var_00);
	}

	self.health = 1;
}

//Function Number: 68
spawnenemiesambusherseast()
{
	maps\_utility::array_spawn_function_targetname("EnemyAmbushEast",::thinkambushenemy);
	var_00 = maps\_utility::array_spawn_targetname("EnemyAmbushEast");
	level.allenemyambushers = maps\_utility::array_merge(var_00,level.allenemyambushers);
	thread enemyambusheastopendoors();
	wait(1);
	var_01 = [];
	var_02 = maps\_utility::get_living_ai_array("EnemyAmbushVehicleOperators","script_noteworthy");
	var_01 = maps\_utility::array_merge(var_01,var_02);
	var_03 = maps\_utility::get_living_ai_array("EnemyAmbushEast_AI","targetname");
	var_01 = maps\_utility::array_merge(var_01,var_03);
	waittillenemiesreducedto(3,var_01);
	common_scripts\utility::flag_set("FlagAllAmbushGuardsDead");
	common_scripts\utility::flag_wait("FlagSpawnEnemyReinforcements");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	var_04 = maps\_utility::get_living_ai_array("EnemyAmbushVehicleOperators","script_noteworthy");
	var_05 = maps\_utility::array_merge(var_00,var_04);
	var_06 = getent("EnemyAmbushEastFallbackVol","targetname");
	foreach(var_08 in var_05)
	{
		var_08 setgoalvolumeauto(var_06);
		var_08.health = 1;
	}
}

//Function Number: 69
enemyambusheastopendoors()
{
	var_00 = getent("EastDoorStartClip","targetname");
	var_00 delete();
	var_01 = getentarray("EastDoorEndClip","targetname");
	foreach(var_03 in var_01)
	{
		var_03 movez(1024,0.1);
		var_03 disconnectpaths();
	}

	var_05 = getentarray("EnemyAmbushEastDoor","targetname");
	foreach(var_07 in var_05)
	{
		if(var_07.script_noteworthy == "EastDoor1")
		{
			var_08 = -150;
		}
		else
		{
			var_08 = 100;
		}

		var_09 = randomfloatrange(0.25,0.45);
		var_07 rotateto(var_07.angles + (0,var_08,0),var_09,0,0.2);
	}
}

//Function Number: 70
spawnenemyambushvehicle()
{
	var_00 = "EnemyAmbushVehicleOperators";
	maps\_utility::array_spawn_function_noteworthy(var_00,::thinkambushenemy);
	thread enemyambushvehiclebadplace();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("EnemyAmbushVehicle");
	var_01 soundscripts\_snd::snd_message("mhunt_cc_assault_veh_01_approach");
	var_01.veh_pathtype = "constrained";
	level.allenemyvehicles = common_scripts\utility::add_to_array(level.allenemyvehicles,var_01);
	var_01 markdronetargetvehicle();
	if(level.currentgen)
	{
		var_01 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
	}

	var_02 = [];
	foreach(var_04 in var_01.riders)
	{
		level.allenemyambushers = common_scripts\utility::add_to_array(level.allenemyambushers,var_04);
		var_02 = common_scripts\utility::add_to_array(var_02,var_04);
		var_04 markdronetargetenemy();
		var_04 thread enemyvehicleguyfallback();
	}

	var_01 enemyvehicleturretthread();
	common_scripts\utility::flag_set("FlagEnemyVehicleTurretDisabled");
	if(isdefined(var_01))
	{
		var_01 unmarkandremoveoutline(0);
	}
}

//Function Number: 71
enemyvehicleguyfallback()
{
	self endon("death");
	common_scripts\utility::flag_wait("FlagSpawnEnemyReinforcements");
	var_00 = getent("EnemyAmbushEastFallbackVol","targetname");
	self setgoalvolumeauto(var_00);
	self.health = 1;
}

//Function Number: 72
waittillenemiesreducedto(param_00,param_01)
{
	for(;;)
	{
		maps\_utility::waittill_dead_or_dying(param_01,1);
		param_01 = maps\_utility::array_removedead_or_dying(param_01);
		if(param_01.size <= param_00)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 73
enemyvehicleturretthread()
{
	self endon("death");
	level endon("FlagAllAmbushEastGuardsDead");
	var_00 = self.mgturret[0];
	var_00 setturretteam("axis");
	soundscripts\_snd::snd_message("cc_technical_turret_fire",var_00);
	var_01 = undefined;
	foreach(var_03 in self.riders)
	{
		if(var_03.vehicle_position == 1)
		{
			var_01 = var_03;
		}
	}

	var_01 endon("death");
	var_01.ignoreall = 1;
	var_00 turretfiredisable();
	var_05 = undefined;
	var_06 = getentarray("ParkingAlarmCar","targetname");
	foreach(var_08 in var_06)
	{
		if(isdefined(var_08.script_parameters) && var_08.script_parameters == "BlowUp")
		{
			var_05 = var_08;
		}
	}

	var_0A = getent("AmbushVehicleTarget","targetname");
	common_scripts\utility::flag_wait("FlagEnemyVehicleActivateTurret");
	var_01.ignoreall = 0;
	var_00 turretfireenable();
	var_00 setaispread(2);
	var_00 setconvergencetime(2);
	var_05 thread enemyturrettargetcar(var_00,var_0A);
	maps\_hms_utility::printlnscreenandconsole("Enemy vehicle turret is now using normal AI");
	thread enemyturretfire(var_00,var_01);
	var_0B = [];
	var_0B = level.allyinfiltrators;
	for(;;)
	{
		var_0C = common_scripts\utility::array_randomize(var_0B);
		if(isdefined(var_0C[0]))
		{
			var_01 maps\_utility::set_favoriteenemy(var_0C[0]);
			var_00 settargetentity(var_0C[0]);
		}

		wait(randomfloatrange(3,8));
	}
}

//Function Number: 74
enemyturretfire(param_00,param_01)
{
	param_01 endon("death");
	self endon("death");
	level endon("StartDroneStatic");
	var_02 = "tag_flash2";
	for(;;)
	{
		param_00 waittill("turret_fire");
		wait 0.05;
		var_03 = param_00 gettagorigin(var_02);
		magicbullet("50cal_turret_technical_lagos",var_03,var_03 + anglestoforward(param_00 gettagangles(var_02)) * 100);
		playfx(common_scripts\utility::getfx("technical_muzzle_flash"),var_03,anglestoforward(param_00 gettagangles(var_02)));
	}
}

//Function Number: 75
enemyturrettargetcar(param_00,param_01)
{
	if(isdefined(self))
	{
		self endon("death");
		self waittill("damage");
		wait(randomfloatrange(2,3));
		maps\_hms_utility::printlnscreenandconsole("Force destruction of turret target car");
		maps\_vehicle::vehicle_set_health(1);
		wait(0.05);
		soundscripts\_snd::snd_message("mhunt_cc_parked_car_expl");
		radiusdamage(param_01.origin,100,10,1);
		physicsexplosionsphere(param_01.origin,100,80,1);
	}
}

//Function Number: 76
enemyambushvehiclebadplace()
{
	var_00 = getent("AmbushVehicleBadPlaceVol","targetname");
	badplace_brush("AmbushVehicleBadPlaceVol",-1,var_00,"axis");
	common_scripts\utility::flag_wait("FlagEnemyVehiclePathEnd");
	badplace_delete("AmbushVehicleBadPlaceVol");
}

//Function Number: 77
hadesvehiclebadplace()
{
	var_00 = getent("HadesVehicleBadPlaceVol","targetname");
	badplace_brush("HadesVehicleBadPlaceVol",-1,var_00,"axis");
	common_scripts\utility::flag_wait("FlagPlayerEndDroneStatic");
	badplace_delete("HadesVehicleBadPlaceVol");
}

//Function Number: 78
spawnenemyreinforcementsvehicles()
{
	var_00 = "EnemyReinforcements1VehicleOperators";
	maps\_utility::array_spawn_function_noteworthy(var_00,::thinkambushenemy);
	var_01 = "EnemyReinforcements2VehicleOperators";
	maps\_utility::array_spawn_function_noteworthy(var_01,::thinkambushenemy);
	common_scripts\utility::flag_wait_either("FlagSpawnEnemyReinforcements","FlagBeginConfCenterOutro");
	wait(1);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("EnemyReinforcements1Vehicle");
	var_02 soundscripts\_snd::snd_message("mhunt_cc_assault_veh_02_approach");
	var_02.veh_pathtype = "constrained";
	level.allenemyvehicles = common_scripts\utility::add_to_array(level.allenemyvehicles,var_02);
	var_02 thread enemyreinforcementsvehicleturretthread();
	var_02 markdronetargetvehicle();
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("EnemyReinforcements2Vehicle");
	var_02 soundscripts\_snd::snd_message("mhunt_cc_assault_veh_03_approach");
	var_03.veh_pathtype = "constrained";
	level.allenemyvehicles = common_scripts\utility::add_to_array(level.allenemyvehicles,var_03);
	var_03 thread enemyreinforcementsvehicleturretthread();
	var_03 markdronetargetvehicle();
	if(level.currentgen)
	{
		var_02 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
		var_03 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
	}
}

//Function Number: 79
enemyreinforcementsvehicleturretthread()
{
	level endon("end_sniper_drone");
	level endon("StartDroneStatic");
	self endon("death");
	foreach(var_01 in self.riders)
	{
		level.allenemyambushers = common_scripts\utility::add_to_array(level.allenemyambushers,var_01);
	}

	var_03 = self.mgturret[0];
	var_03 setturretteam("axis");
	var_03 turretfiredisable();
	soundscripts\_snd::snd_message("cc_technical_turret_fire",var_03);
	var_04 = undefined;
	foreach(var_01 in self.riders)
	{
		if(var_01.vehicle_position == 1)
		{
			var_04 = var_01;
		}
	}

	var_04 endon("death");
	var_04.ignoreall = 1;
	var_04.battlechatter = 0;
	maps\_utility::ent_flag_wait("unloaded");
	var_04.ignoreall = 0;
	var_03 turretfireenable();
	var_03 setaispread(10);
	var_03 setconvergencetime(2);
	thread enemyturretfire(var_03,var_04);
	var_07 = [];
	var_07 = level.allyinfiltrators;
	for(;;)
	{
		var_08 = common_scripts\utility::array_randomize(var_07);
		if(isdefined(var_08[0]))
		{
			var_04 maps\_utility::set_favoriteenemy(var_08[0]);
			var_03 settargetentity(var_08[0]);
		}

		wait(randomfloatrange(3,8));
	}
}

//Function Number: 80
spawnhadesescapevehicle()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("HadesEscapeVehicle");
	var_00.escapevehicle = 1;
	maps\_hms_utility::printlnscreenandconsole("Spawning Hades escape vehicle");
	if(level.currentgen)
	{
		var_00 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
	}

	foreach(var_02 in var_00.riders)
	{
		level.allenemyambushers = common_scripts\utility::add_to_array(level.allenemyambushers,var_02);
	}

	level.allenemyvehicles = common_scripts\utility::add_to_array(level.allenemyvehicles,var_00);
	thread setupgaragedoor();
	thread spawnenemyreinforcementsvehicles();
	common_scripts\utility::flag_wait("FlagHadesVehicleDriveStart");
	wait(1);
	thread hadesvehiclebadplace();
	var_04 = "HadesEscapeVehicleStart";
	var_00 soundscripts\_snd::snd_message("mhunt_cc_hades_veh_escape");
	maps\_hms_utility::printlnscreenandconsole("Hades is escaping!!!");
	var_00 thread objmarkervehicle("FlagSniperDroneHit",1,0);
	var_00 markdronetargetvehicle();
	var_05 = getvehiclenode(var_04,"targetname");
	var_00 attachpath(var_05);
	var_00 startpath(var_05);
	var_00 thread maps\_vehicle::vehicle_paths(var_05);
	var_00 vehicle_setspeed(20,10,15);
	common_scripts\utility::flag_wait("FlagHadesVehicleDroneLaunch");
	firekamikazedrones(var_00);
}

//Function Number: 81
firekamikazedrones(param_00)
{
	var_01 = 7;
	var_02 = param_00.origin;
	var_03 = 4;
	var_04 = length(level.player.origin - param_00.origin);
	var_03 = maps\_utility::linear_interpolate(min(max(var_04 - 1500,0) / 2000,1),2.5,4);
	var_05 = 0;
	for(var_06 = 0;var_06 < var_01;var_06++)
	{
		var_07 = common_scripts\utility::mod(var_06 * 360 / var_01,360);
		var_08 = var_03 - var_05;
		var_09 = randomfloatrange(3.6,6);
		var_0A = randomfloatrange(50,80);
		var_0B = 0;
		if(var_06 == 0)
		{
			var_0B = 1;
		}

		var_0C = 0;
		if(var_06 == 6)
		{
			var_0C = 1;
		}

		thread mangarocketparentupdate(param_00,var_02,var_0B,var_08,var_07,var_09,var_0A,var_0C);
		var_0D = 0.15;
		var_05 = var_05 + var_0D + 0.05;
		wait(var_0D);
	}
}

//Function Number: 82
mangarocketparentupdate(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.player geteye() - param_01;
	var_09 = vectornormalize(anglestoforward(level.player getplayerangles()));
	var_0A = level.player geteye() - level.player.origin;
	var_0A = var_0A / 2;
	var_09 = common_scripts\utility::randomvectorincone(var_09,30) * 100;
	var_0B = param_00.origin + (16,0,96);
	var_0C = level.player geteye() + var_09;
	var_0D = (param_01[0],param_01[1],var_0C[2]) + (0,0,100);
	var_0E = common_scripts\utility::spawn_tag_origin();
	var_0E.origin = var_0B;
	var_0E.parentorigin = var_0B;
	var_0E.droneviewmodel = spawn("script_model",var_0B);
	var_0E.droneviewmodel setmodel("vehicle_atlas_assault_drone");
	playfx(common_scripts\utility::getfx("kamikaze_drone_launch"),var_0B);
	soundscripts\_snd::snd_message("start_kdrone_launch",param_00);
	playfxontag(common_scripts\utility::getfx("kamikaze_drone_trail"),var_0E,"tag_origin");
	soundscripts\_snd::snd_message("start_kdrone_loop",var_0E);
	thread mangarocketupdate(param_01,level.player,var_0E,param_04,param_05,param_06);
	var_0F = 0;
	var_10 = 1 / param_03 * 20;
	var_11 = 0;
	var_12 = 0;
	while(var_11 <= 1)
	{
		wait(0.05);
		var_0C = level.player geteye() + var_09;
		var_0D = (param_01[0],param_01[1],var_0C[2]) + (0,0,100);
		var_13 = squared(1 - var_0F) * var_0B + 2 * var_0F * 1 - var_0F * var_0D + squared(var_0F) * var_0C;
		var_0E.parentorigin = var_13;
		var_14 = 2 * 1 - var_0F * var_0D - var_0B + 2 * var_0F * var_0C - var_0D;
		var_0E.tangent = vectornormalize(var_14);
		var_0E.angles = vectortoangles(var_0E.tangent);
		var_0E.droneviewmodel.angles = vectortoangles(var_08 * (1,1,0));
		var_11 = var_11 + var_10;
		if(param_02)
		{
			var_0F = pow(var_11,3);
		}
		else
		{
			var_0F = squared(var_11);
		}

		if(var_12)
		{
			break;
		}

		if(var_11 > 1)
		{
			var_11 = 1;
			var_12 = 1;
		}
	}

	stopfxontag(common_scripts\utility::getfx("kamikaze_drone_trail"),var_0E,"tag_origin");
	var_15 = anglestoforward(level.player getplayerangles()) * -1;
	playfx(common_scripts\utility::getfx("kamikaze_drone_explosion"),var_0E.origin,var_15,(0,0,1));
	soundscripts\_snd::snd_message("kamikaze_drone_explo",var_0E);
	soundscripts\_snd::snd_message("start_sniper_drone_death");
	var_16 = randomfloatrange(0.8,1.6);
	earthquake(var_16,0.2,var_0E.origin,512);
	var_0E notify("MangaRocketUpdate");
	var_0E.droneviewmodel delete();
	var_0E delete();
	if(param_07)
	{
		wait(0.3);
		level.player notify("kamikaze_damaged_lens");
		common_scripts\utility::flag_set("FlagSniperDroneHit");
	}
}

//Function Number: 83
mangarocketupdate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_02 endon("MangaRocketUpdate");
	var_06 = vectortoangles(param_01.origin - param_00);
	var_07 = param_03;
	var_08 = (0,0,0);
	if(common_scripts\utility::cointoss())
	{
		param_04 = param_04 * -1;
	}

	var_09 = param_05 / 5;
	var_0A = 0;
	for(;;)
	{
		wait(0.05);
		var_07 = var_07 + param_04;
		var_08 = (1,0,0) * var_0A;
		if(isdefined(param_02.tangent))
		{
			var_06 = vectortoangles(param_02.tangent);
		}

		var_08 = (0,0,1) * var_0A;
		var_0B = transformmove(param_02.parentorigin,var_06,(0,0,0),(0,0,var_07),var_08,(0,0,0));
		var_08 = var_0B["origin"];
		param_02.origin = vectorlerp(param_02.origin,var_08,0.5);
		param_02.droneviewmodel.origin = param_02.origin;
		var_0A = var_0A + var_09;
		var_0A = clamp(var_0A,0,param_05);
	}
}

//Function Number: 84
confroomsetup()
{
	var_00 = common_scripts\utility::getstruct("CC_Breach","targetname");
	var_01 = getent("ConfHades","targetname");
	level.confhades = var_01 maps\_utility::spawn_ai();
	level.confhades.name = "Hades";
	level.confhades.animname = "Hades";
	level.confhades.health = 1;
	level.confhades.no_friendly_fire_penalty = 1;
	level.confhades.noragdoll = 1;
	level.confhades.disablearrivals = 1;
	level.confhades.disableexits = 1;
	level.confhades.neverenablecqb = 1;
	level.confhades.alwaysrunforward = 1;
	level.confhades orientmode("face default");
	level.confhades.combatmode = "no_cover";
	level.confhades maps\_utility::gun_remove();
	level.confhades.grenadeammo = 0;
	level.confhades maps\_utility::set_run_anim("run_hunched_combat",1);
	level.confhades.run_override_weights = level.scr_anim["Hades"]["run_hunched_weights"];
	level.confhades maps\_utility::set_ignoreall(1);
	level.confhades.allowdeath = 1;
	level.confhades.team = "axis";
	level.allenemypatrollers = common_scripts\utility::array_add(level.allenemypatrollers,level.confhades);
	level.confhades thread maps\greece_code::clearalertoutline();
	thread monitorhadesdeath();
	thread monitorhadesalert();
	thread progressionkillhades();
	level.confhades thread maps\greece_code::bloodsprayexitwoundtrace(3000,level.player,"TAG_WEAPON_CHEST",1);
	level.confhades thread monitorsniperdronetriplekill();
	var_00 thread maps\_anim::anim_loop_solo(level.confhades,"pacing_idle","stopPacingIdles");
	maps\_utility::array_spawn_function_targetname("EnemyPatrolMeeting",::thinkpatrolenemy,0);
	var_02 = maps\_utility::array_spawn_targetname("EnemyPatrolMeeting");
	var_03 = 1;
	foreach(var_05 in var_02)
	{
		var_05.allowdeath = 1;
		var_05.animname = "BodyGuard" + var_03;
		var_03++;
		var_00 thread maps\_anim::anim_loop_solo(var_05,"pacing_idle","stopPacingIdles");
		var_05.idlepoint = var_00;
		var_05 thread disablestealthonhadesdeath();
	}

	var_07 = ["kva_civilian_a","kva_civilian_b","kva_civilian_c","kva_civilian_d"];
	var_08 = ["kva_civilian_a_head","kva_civilian_b_head","kva_civilian_c_head"];
	maps\greece_code::aiarrayoverridemodelrandom(var_02,var_07,var_08);
	level.breachactors = maps\_utility::array_merge(var_02,level.breachactors);
	level.allenemypatrollers = maps\_utility::array_merge(var_02,level.allenemypatrollers);
	thread setupmeetingcivilians();
	thread confroomstandingidles(var_00,var_02,level.confhades);
	var_09 = getent("conf_room_door","targetname");
	var_09 maps\_utility::assign_animtree("conf_room_door");
	level.breachactors = common_scripts\utility::array_insert(level.breachactors,var_09,0);
	soundscripts\_snd::snd_message("start_hades_breach_door",var_09);
}

//Function Number: 85
setupmeetingcivilians()
{
	var_00 = common_scripts\utility::getstruct("CC_Breach","targetname");
	var_01 = maps\_utility::array_spawn_targetname("ConfRoomVip",1);
	var_02 = "vip_idle";
	var_03 = ["civ_urban_male_body_f","civ_urban_male_body_g","body_civ_sf_male_a"];
	var_04 = ["head_m_act_cau_bedrosian_base","head_m_act_asi_chang_base","head_male_mp_manasi"];
	maps\greece_code::aiarrayoverridemodelrandom(var_01,var_03,var_04);
	foreach(var_06 in var_01)
	{
		var_06.animname = var_06.script_noteworthy;
		var_07 = "Breach";
		if(var_06.animname == "Vip3")
		{
			var_07 = "speech";
		}

		var_00 thread maps\_anim::anim_loop_solo(var_06,var_02,var_07);
		var_06.allowdeath = 1;
		var_06 thread maps\greece_code::setragdolldeath();
	}

	level.breachactors = maps\_utility::array_merge(level.breachactors,var_01);
}

//Function Number: 86
monitorhadesdeath()
{
	level endon("end_sniper_drone");
	level.confhades endon("guy_alerted");
	var_00 = common_scripts\utility::getstruct("CC_Breach","targetname");
	var_01 = "cc_breach";
	level.confhades waittill("damage");
	var_00 notify("stopPacingIdles");
	var_00 notify("speech");
	var_00 notify("Breach");
	level.confhades.ignoreall = 1;
	level.confhades maps\_stealth_utility::disable_stealth_for_ai();
	level.confhades disableenemyalert();
	common_scripts\utility::flag_set("FlagConfHadesDead");
	level notify("stop_hades_speech");
	level.confhades notify("removeTargetObj");
	level.confhades notify("stop_talking");
	maps\_utility::radio_dialogue_overlap_stop();
	if(common_scripts\utility::flag("FlagOkayToKillHades"))
	{
		common_scripts\utility::flag_set("FlagForcePlayerSlowMovement");
		thread hadesscriptedanimdeath(var_00,var_01);
		wait(0.5);
		thread maps\_controlled_sniperdrone::disabledronefiringafterkill();
		common_scripts\utility::flag_wait("FlagConfRoomExplosion");
		level.confhades thread unmarkandremoveoutline(0.1);
		wait(3);
		common_scripts\utility::flag_clear("FlagForcePlayerSlowMovement");
		return;
	}

	thread failkillhadessoon();
}

//Function Number: 87
failkillhadessoon()
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - PLAYER KILLED HADES TOO SOON!!!");
	confcentertotalcombat(1);
	maps\greece_conf_center_vo::confcenterfailhadeskilledearlydialogue();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_KILLHADES_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 88
failkillhadeslate()
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - PLAYER TOOK TOO LONG TO KILL HADES!!!");
	maps\greece_conf_center_vo::confcenterfailtimeoutdialogue();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_NOKILLHADES_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 89
hadesscriptedanimdeath(param_00,param_01)
{
	level.confhades maps\greece_code::giveplayerchallengekillpoint();
	level.confhades notify("scripted_death");
	level.confhades.bscripteddeath = 1;
	level.confhades maps\_utility::anim_stopanimscripted();
	wait(0.05);
	param_00 maps\_anim::anim_single_solo(level.confhades,param_01);
	level.confhades maps\greece_code::kill_no_react(0);
}

//Function Number: 90
monitorhadesalert(param_00)
{
	level.confhades endon("death");
	level.confhades endon("damage");
	level.confhades waittill("guy_alerted");
	var_01 = common_scripts\utility::getstruct("CC_Breach","targetname");
	var_02 = "cc_breach";
	var_01 notify("stopPacingIdles");
	var_01 notify("speech");
	var_01 notify("Breach");
	if(isdefined(level.confhades))
	{
		level.confhades maps\_utility::anim_stopanimscripted();
		level.confhades maps\_utility::gun_remove();
		level.confhades.sidearm = "none";
		level.confhades maps\_utility::forceuseweapon("iw5_sn6_sp","primary");
		var_03 = getnodearray("ConfRoomHadesCover","targetname");
		var_04 = common_scripts\utility::random(var_03);
		if(isdefined(var_04))
		{
			level.confhades maps\_utility::set_goal_node(var_04);
		}
	}
}

//Function Number: 91
disablestealthonhadesdeath()
{
	self endon("death");
	common_scripts\utility::flag_wait("FlagConfHadesDead");
	if(common_scripts\utility::flag("FlagOkayToKillHades"))
	{
		maps\_stealth_utility::disable_stealth_for_ai();
		self.disablebulletwhizbyreaction = 1;
		maps\_utility::disable_danger_react();
		self.ignoreall = 1;
		self.ignoreme = 1;
	}
}

//Function Number: 92
alliesbreachconfroom()
{
	level endon("alarm_mission_end");
	level notify("ConfRoomSetupBreach");
	var_00 = common_scripts\utility::getstruct("CC_Breach","targetname");
	foreach(var_02 in level.allyinfiltrators)
	{
		var_02 maps\_stealth_utility::disable_stealth_for_ai();
		var_02 thread allysetupconfroom(var_00);
	}

	maps\_hms_utility::printlnscreenandconsole("Allies at ConfRoomBreach!");
	common_scripts\utility::flag_wait("FlagHadesSpeechStarted");
	var_04 = maps\_utility::get_living_ai_array("EnemyPatrolMeeting_AI","targetname");
	if(isdefined(level.confhades))
	{
		level.confhades thread confroombreachhadesspeech(var_00);
	}

	var_05 = maps\_utility::get_living_ai("Vip3","script_noteworthy");
	if(isdefined(var_05))
	{
		var_05 thread confroombreachhadesspeech(var_00);
	}

	common_scripts\utility::flag_wait("FlagOkayToKillHades");
	thread setupplayertargets("ConfRoomPlayerTarget",1,1);
	thread monitorconfroomenemies();
	common_scripts\utility::flag_wait("FlagConfHadesDead");
	soundscripts\_snd::snd_message("hades_is_dead");
	var_06 = level.breachactors[0];
	level.breachactors = common_scripts\utility::array_remove(level.breachactors,level.breachactors[0]);
	var_00 notify("Breach");
	soundscripts\_snd::snd_message("start_hades_breach");
	thread alliesexitconfroom();
	var_07 = getent("conf_room_door_clip","targetname");
	var_07 delete();
	var_00 thread maps\_anim::anim_single_solo(var_06,"cc_breach");
	thread allybreachconfroomanddie(var_00);
	level.breachactors = maps\_utility::array_removedead_or_dying(level.breachactors);
	foreach(var_09 in level.breachactors)
	{
		var_09 maps\_utility::anim_stopanimscripted();
	}

	var_00 thread maps\_anim::anim_single(level.breachactors,"cc_breach");
	var_00 maps\_anim::anim_single_run(level.allyinfiltrators,"cc_breach");
}

//Function Number: 93
monitorconfroomenemies()
{
	level endon("alarm_mission_end");
	setupvalidtargetsbyname("EnemyPatrolMeeting");
	var_00 = maps\_utility::get_living_ai_array("EnemyPatrolMeeting_AI","targetname");
	maps\_utility::waittill_dead_or_dying(var_00,1);
	wait(0.05);
	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		level.confhades notify("stop_talking");
		common_scripts\utility::flag_set("FlagAlarmMissionEnd");
		destroyatriumfighttimer();
		level notify("alarm_mission_end");
	}
}

//Function Number: 94
allybreachconfroomanddie(param_00)
{
	var_01 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	level.allyinfiltrators = common_scripts\utility::array_remove(level.allyinfiltrators,var_01);
	param_00 maps\_anim::anim_single_solo(var_01,"cc_breach");
	allyconfroomdeath(0);
}

//Function Number: 95
allyconfroomdeath(param_00)
{
	var_01 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	if(isdefined(var_01))
	{
		if(maps\_utility::is_in_array(level.allyinfiltrators,var_01))
		{
			level.allyinfiltrators = common_scripts\utility::array_remove(level.allyinfiltrators,var_01);
		}

		var_01 unmarkandremoveoutline();
		var_01 maps\_utility::stop_magic_bullet_shield();
		if(param_00)
		{
			var_01 delete();
			return;
		}

		var_01 maps\greece_code::kill_no_react();
	}
}

//Function Number: 96
allysetupconfroom(param_00)
{
	if(self.animname == "infiltratorburke")
	{
		common_scripts\utility::flag_wait_either("FlagParkingAlliesOnStairs","FlagBeginConfCenterKill");
		var_01 = getent("StairwayTakedownOrg","targetname");
		var_01 notify("stop_stairway_idle");
		wait(0.05);
	}

	maps\greece_code::clear_set_goal();
	wait 0.05;
	param_00 maps\_anim::anim_reach_solo(self,"breach_stairs");
	param_00 maps\_anim::anim_single_solo_run(self,"breach_stairs");
	param_00 maps\_anim::anim_reach_solo(self,"squad_setup_in");
	param_00 maps\_anim::anim_single_solo(self,"squad_setup_in");
	param_00 thread maps\_anim::anim_loop_solo(self,"squad_setup","Breach");
}

//Function Number: 97
confroombreachbodyguarddeath(param_00)
{
	playfxontag(common_scripts\utility::getfx("blood_impact_splat"),param_00,"TAG_EYE");
	param_00 maps\greece_code::kill_no_react();
}

//Function Number: 98
confroomstandingidles(param_00,param_01,param_02)
{
	var_03 = "standing_idle";
	common_scripts\utility::flag_wait_any("FlagParkingCarAlarmActivated","FlagBeginConfCenterKill");
	param_00 notify("stopPacingIdles");
	param_00 thread maps\_anim::anim_loop_solo(param_02,var_03,"speech");
	foreach(var_05 in param_01)
	{
		param_00 thread maps\_anim::anim_loop_solo(var_05,var_03,"Breach");
	}
}

//Function Number: 99
confroombreachhadesspeech(param_00)
{
	self endon("death");
	level endon("alarm_mission_end");
	level endon("stop_hades_speech");
	param_00 notify("speech");
	param_00 maps\_anim::anim_single_solo(self,"speech");
	var_01 = "vip_idle";
	if(self == level.confhades)
	{
		var_01 = "post_speech_idle";
	}

	if(!common_scripts\utility::flag("FlagConfHadesDead"))
	{
		param_00 thread maps\_anim::anim_loop_solo(self,var_01,"Breach");
	}
}

//Function Number: 100
confroomragdoll(param_00)
{
	if(isalive(param_00))
	{
		param_00 maps\greece_code::kill_no_react();
	}

	param_00 startragdoll();
}

//Function Number: 101
confroomexplosiondronereaction()
{
	var_00 = level.player.sniperdronelink;
	var_00.animname = "sniper_drone_flight";
	var_00 maps\_utility::assign_animtree("sniper_drone_flight");
	var_01 = "explosion_reaction";
	var_02 = [var_00];
	var_00.frameviewmodel.animname = "sniperdrone_outerparts";
	var_00.frameviewmodel maps\_utility::assign_animtree("sniperdrone_outerparts");
	var_00.barrelviewmodel.animname = "sniperdrone_barrel";
	var_00.barrelviewmodel maps\_utility::assign_animtree("sniperdrone_barrel");
	var_00.frameviewmodel setanim(var_00.frameviewmodel maps\_utility::getanim(var_01));
	var_00.barrelviewmodel setanim(var_00.barrelviewmodel maps\_utility::getanim(var_01));
	common_scripts\utility::flag_set("FlagSniperDroneAnimating");
	common_scripts\utility::flag_set("FlagSniperDroneCloakOff");
	soundscripts\_snd::snd_message("wasp_cloak_off");
	var_00 maps\_anim::anim_single(var_02,var_01);
	common_scripts\utility::flag_clear("FlagSniperDroneAnimating");
}

//Function Number: 102
alliesexitconfroom()
{
	level waittill("ConfRoomExplosion");
	var_00 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	if(isdefined(var_00) && maps\_utility::is_in_array(level.allyinfiltrators,var_00))
	{
		level.allyinfiltrators = common_scripts\utility::array_remove(level.allyinfiltrators,var_00);
	}

	thread alliesredirect("ConfRoomExit");
}

//Function Number: 103
thinkallyinfiltrator()
{
	self endon("death");
	maps\_utility::forceuseweapon("iw5_bal27_sp_silencer01_variablereddot","primary");
	thread maps\_utility::magic_bullet_shield(1);
	thread maps\_utility::set_battlechatter(0);
	self.dontmelee = 1;
	self.meleealwayswin = 1;
	maps\_utility::enable_cqbwalk();
	maps\_utility::set_goal_radius(64);
	maps\_utility::disable_surprise();
	maps\_utility::disable_danger_react();
	maps\_utility::enable_dontevershoot();
	self.grenadeammo = 0;
	maps\_stealth_accuracy_friendly::friendly_acc_hidden();
	self.canjumppath = 1;
	if(self.script_noteworthy == "InfiltratorBurke")
	{
		maps\_utility::set_force_color("p");
		return;
	}

	maps\_utility::set_force_color("c");
}

//Function Number: 104
initthinkpatrolenemy(param_00)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00 == 1)
	{
		self.animname = "generic";
	}

	self.grenadeammo = 0;
	self.fovcosine = cos(45);
	maps\_utility::set_goal_radius(64);
	self.diequietly = 1;
	self clearenemy();
	thread maps\_utility::set_battlechatter(0);
	thread maps\greece_code::clearalertoutline();
	thread maps\_sniper_setup_ai::waitforplayerbulletwhizby();
	thread monitorisenemyvalidtarget();
	thread maps\greece_code::bloodsprayexitwoundtrace(1500,level.player);
	thread monitorsniperdronetriplekill();
}

//Function Number: 105
thinkpatrolenemy(param_00)
{
	self endon("death");
	initthinkpatrolenemy(param_00);
	if(!isdefined(self._stealth))
	{
		maps\_stealth_utility::stealth_default();
	}

	maps\_stealth_utility::stealth_disable_seek_player_on_spotted();
	var_01 = [];
	var_01["saw"] = ::maps\_sniper_setup_ai::sawcorpse;
	maps\_stealth_utility::stealth_corpse_behavior_custom(var_01);
}

//Function Number: 106
thinkmeetingcivilian()
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	self forceteleport(var_00.origin,var_00.angles);
	self.animname = "generic";
	var_01 = var_00.animation;
	var_00 thread maps\_anim::anim_generic_loop(self,var_01);
	self.allowdeath = 1;
}

//Function Number: 107
thinkambushenemy()
{
	self endon("death");
	maps\_utility::disable_long_death();
	maps\_utility::disable_bulletwhizbyreaction();
	self.grenadeammo = 0;
	thread maps\greece_code::bloodsprayexitwoundtrace(1500,level.player);
	thread monitorsniperdronetriplekill();
	common_scripts\utility::flag_wait_either("FlagBeginConfCenterCombat","FlagConfRoomAlliesRecover");
	maps\greece_code::setalertoutline(1);
	markdronetargetenemy();
	thread maps\greece_code::clearalertoutline();
	thread notifyonplayerkill();
	var_00 = level.player maps\_utility::get_player_gameskill();
	if(var_00 <= 2)
	{
		if(self.classname == "actor_enemy_kva_civ_lmg" || self.classname == "actor_enemy_kva_civ_rpg")
		{
			maps\_utility::disable_surprise();
			self.disablebulletwhizbyreaction = 1;
			self.grenadeammo = 0;
			self.health = 500;
			self.minpaindamage = 75;
			self.a.disablelongdeath = 1;
			self.a.disablelongpain = 1;
			self.ignoresuppression = 1;
			self.disablereactionanims = 1;
			self.no_pistol_switch = 1;
			self.dontmelee = 1;
			self setmodel("kva_heavy_body");
			thread codescripts\character::setheadmodel("kva_heavy_head");
		}
	}
}

//Function Number: 108
enemypatrolgatethread(param_00)
{
	level endon("alarm_mission_end");
	var_01 = getent("BodyStashOrg","targetname");
	var_02 = "bodystash_in";
	var_03 = "bodystash_idle";
	var_04 = "bodystash_start_idle";
	var_05 = maps\_utility::get_living_ai("GatePlayerTarget1","script_noteworthy");
	var_05.animname = "guard1";
	var_05.health = 999999;
	var_05 maps\_utility::set_run_anim("active_patrolwalk_gundown");
	var_05 maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	var_06 = maps\_utility::get_living_ai("GatePlayerTarget2","script_noteworthy");
	var_06.animname = "guard2";
	var_06.health = 999999;
	var_06 maps\_utility::set_run_anim("casual_killer_walk_F");
	var_06 maps\_utility::forceuseweapon("iw5_bal27_sp","primary");
	var_01 thread maps\_anim::anim_loop_solo(var_05,var_04,"stopIdleLoop");
	var_01 thread maps\_anim::anim_loop_solo(var_06,var_04,"stopIdleLoop");
	common_scripts\utility::flag_wait("FlagAllyVehicleDriveBy");
	var_07 = getent("delivery_truck","targetname");
	var_08 = level.infiltratorburke;
	var_08.ignoreall = 1;
	var_09 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_09.ignoreall = 1;
	var_0A = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_0A.ignoreall = 1;
	common_scripts\utility::flag_set("FlagGateGuardsApproachingAllyVehicle");
	thread monitorplayerlookatgateguards();
	var_06 thread bodystashguardapproach(var_01,1,"casual_killer_walk_start",0);
	var_05 bodystashguardapproach(var_01,1,"active_patrolwalk_gundown_point_r",1);
	common_scripts\utility::flag_set("FlagGateGuardsAtAllyVehicle");
	thread setupplayertargets("GatePlayerTarget");
	var_05 maps\_stealth_utility::disable_stealth_for_ai();
	var_05.ignoreall = 1;
	var_05.dropweapon = 0;
	var_06 maps\_stealth_utility::disable_stealth_for_ai();
	var_06.ignoreall = 1;
	var_06.dropweapon = 0;
	var_05 thread bodystashguardalertwatch();
	var_06 thread bodystashguardalertwatch();
	var_05 thread bodystashguardkillwatch();
	var_06 thread bodystashguardkillwatch();
	var_0B = common_scripts\utility::flag_wait_any_return("FlagBodyStashGuard1Killed","FlagBodyStashGuard2Killed","FlagBodyStashGuardsAlerted");
	soundscripts\_snd::snd_message("start_tower_bells");
	level notify("GateGuardsDead");
	if(var_0B == "FlagBodyStashGuard2Killed")
	{
		thread markallies(1);
	}
	else
	{
		thread markallies(0);
	}

	var_01 notify("endBodystashIdle");
	if(common_scripts\utility::flag("FlagBodyStashGuard1Killed"))
	{
		var_05 thread bodystashguarddeath(var_01,"bodystash_alt");
	}
	else
	{
		var_05 thread bodystashguarddeath(var_01,"bodystash");
	}

	if(common_scripts\utility::flag("FlagBodyStashGuard2Killed"))
	{
		var_06 thread bodystashguarddeath(var_01,"bodystash");
	}
	else
	{
		var_06 thread bodystashguarddeath(var_01,"bodystash_alt");
	}

	thread alliesexittruck(var_01,var_07,var_09,var_0A,var_08);
}

//Function Number: 109
bodystashguarddeath(param_00,param_01)
{
	if(isdefined(self))
	{
		self endon("death");
		disableenemyalert();
		self notify("removeTargetObj");
		self notify("bloodless");
		if(self.script_noteworthy == "GatePlayerTarget1")
		{
			animscripts\shared::dropallaiweapons();
			self notify("stop_talking");
			maps\_utility::radio_dialogue_stop();
			if(param_01 == "bodystash_alt")
			{
				self hudoutlinedisable();
				if(target_istarget(self))
				{
					target_remove(self);
				}
			}
		}
		else
		{
			self hudoutlinedisable();
			if(target_istarget(self))
			{
				target_remove(self);
			}
		}

		maps\_utility::set_ignoreme(1);
		var_02 = maps\_utility::getanim(param_01);
		maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " is playing anime " + param_01 + " with animname " + self.animname);
		thread bodystashguardnofeedback();
		if(self.script_noteworthy == "GatePlayerTarget1")
		{
			if(param_01 == "bodystash_alt")
			{
				maps\greece_code::giveplayerchallengekillpoint();
				self notify("scripted_death");
			}

			self.bscripteddeath = 1;
			param_00 maps\_anim::anim_single_solo(self,param_01);
			self.allowdeath = 1;
			self.a.nodeath = 1;
			animscripts\notetracks::notetrackstartragdoll("ragdoll");
			self stopanimscripted();
			self kill();
			return;
		}

		if(self.script_noteworthy == "GatePlayerTarget2")
		{
			if(param_01 == "bodystash")
			{
				maps\greece_code::giveplayerchallengekillpoint();
				self notify("scripted_death");
			}

			self.bscripteddeath = 1;
			param_00 maps\_anim::anim_single_solo(self,param_01);
			self hide();
			self.a.nodeath = 1;
			animscripts\notetracks::notetrackstartragdoll("ragdoll");
			self kill();
			return;
		}
	}
}

//Function Number: 110
bodystashguardnofeedback()
{
	self endon("death");
	wait(0.1);
	maps\_utility::remove_damagefeedback();
}

//Function Number: 111
alliesexittruck(param_00,param_01,param_02,param_03,param_04)
{
	thread gatebreach();
	if(common_scripts\utility::flag("FlagBodyStashGuard2Killed"))
	{
		param_00 thread maps\_anim::anim_single_solo(param_01,"bodystash");
		param_02 thread allyexittruck(param_00,"bodystash");
		param_03 thread allyexittruck(param_00,"bodystash");
	}
	else
	{
		param_00 thread maps\_anim::anim_single_solo(param_01,"bodystash_alt");
		param_02 thread allyexittruck(param_00,"bodystash_alt");
		param_03 thread allyexittruck(param_00,"bodystash_alt");
	}

	if(common_scripts\utility::flag("FlagBodyStashGuard1Killed"))
	{
		param_04 allyexittruck(param_00,"bodystash_alt");
		return;
	}

	param_04 allyexittruck(param_00,"bodystash");
}

//Function Number: 112
allyexittruck(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo_run(self,param_01);
	self.ignoreall = 0;
	if(self.script_noteworthy == "InfiltratorBurke")
	{
		level notify("AlliesExitTruck");
		level.balliesintruck = 0;
	}

	common_scripts\utility::flag_set("FlagAllGateGuardsDead");
	gatebreachallyreachandidle();
}

//Function Number: 113
deliverytrucksetup()
{
	var_00 = getent("delivery_truck","targetname");
	var_00.animname = "truck";
	var_00 maps\_utility::assign_animtree("truck");
	var_01 = getent("delivery_truck_collision","targetname");
	var_01 linkto(var_00,"tag_origin");
	soundscripts\_snd::snd_message("veh_moving_truck_chkpt",var_00);
}

//Function Number: 114
guyragdollnotetrack(param_00)
{
	param_00 animscripts\shared::dropallaiweapons();
	param_00 maps\greece_code::kill_no_react();
	var_01 = (0.5,0.5,1);
	var_02 = 100000;
	param_00 startragdollfromimpact(param_00.origin,var_01 * var_02);
	param_00 startragdoll();
}

//Function Number: 115
guyextrabloodnotetrack(param_00)
{
	if(param_00.script_noteworthy == "InfiltratorBurke")
	{
		var_01 = maps\_utility::get_living_ai("GatePlayerTarget1","script_noteworthy");
	}
	else
	{
		var_01 = maps\_utility::get_living_ai("GatePlayerTarget2","script_noteworthy");
	}

	if(isdefined(var_01))
	{
		playfxontag(common_scripts\utility::getfx("blood_impact_splat"),var_01,"TAG_EYE");
		var_01 notify("bloodless");
	}

	common_scripts\utility::flag_set("FlagAllyShootGateGuard");
}

//Function Number: 116
bodystashguardalertwatch()
{
	level endon("alarm_mission_end");
	self endon("death");
	self endon("damage");
	self waittill("guy_alerted");
	if(self.script_noteworthy == "GatePlayerTarget1")
	{
		var_00 = maps\_utility::get_living_ai("GatePlayerTarget2","script_noteworthy");
	}
	else
	{
		var_00 = maps\_utility::get_living_ai("GatePlayerTarget1","script_noteworthy");
	}

	if(isdefined(var_00))
	{
		var_00 disableenemyalert();
	}

	wait(0.1);
	common_scripts\utility::flag_set("FlagBodyStashGuardsAlerted");
	var_01 = getent("delivery_truck","targetname");
	self setentitytarget(var_01);
}

//Function Number: 117
bodystashguardkillwatch()
{
	level endon("alarm_mission_end");
	self endon("death");
	self endon("disableAlert");
	thread maps\greece_code::bloodsprayexitwoundtrace(1000,level.player,"TAG_WEAPON_CHEST",1);
	self waittill("damage");
	if(self.script_noteworthy == "GatePlayerTarget1")
	{
		common_scripts\utility::flag_set("FlagBodyStashGuard1Killed");
		return;
	}

	common_scripts\utility::flag_set("FlagBodyStashGuard2Killed");
}

//Function Number: 118
bodystashguardapproach(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("damage");
	wait(param_03);
	var_04 = "bodystash_in";
	var_05 = "bodystash_idle";
	param_00 notify("stopIdleLoop");
	if(param_01)
	{
		param_00 maps\_anim::anim_single_solo(self,var_04);
	}
	else
	{
		param_00 maps\_anim::anim_reach_solo(self,var_05);
	}

	param_00 thread maps\_anim::anim_loop_solo(self,var_05,"endBodystashIdle");
}

//Function Number: 119
monitorplayerlookatgateguards()
{
	common_scripts\utility::flag_wait("FlagGateGuardsAtAllyVehicle");
	var_00 = getent("delivery_truck","targetname");
	waittillplayerlookattarget(var_00,15,0);
	common_scripts\utility::flag_set("FlagOkayToShootDrone");
}

//Function Number: 120
gatebreachallyreachandidle()
{
	self endon("death");
	var_00 = common_scripts\utility::getstruct("conf_center_org","targetname");
	var_01 = "gate_breach_in";
	var_02 = "gate_breach_idle";
	var_00 maps\_anim::anim_reach_solo(self,var_01);
	var_00 maps\_anim::anim_single_solo(self,var_01);
	maps\_utility::set_goal_pos(self.origin);
	level.ialliesatgate++;
	if(!common_scripts\utility::flag("FlagAllCourtyardGuardsDead"))
	{
		var_00 thread maps\_anim::anim_loop_solo(self,var_02,"stop_loop");
	}
}

//Function Number: 121
gatebreach()
{
	for(;;)
	{
		if(level.ialliesatgate == 3)
		{
			break;
		}

		wait 0.05;
	}

	var_00 = common_scripts\utility::flag_wait_any_return("FlagCourtyardAlliesBreachGate","FlagCourtyardAlliesBreachGateAlt");
	var_01 = common_scripts\utility::getstruct("conf_center_org","targetname");
	var_02 = "gate_breach";
	if(var_00 == "FlagCourtyardAlliesBreachGateAlt")
	{
		var_02 = "gate_breach_alt";
	}

	var_03 = getent("conf_center_gate","targetname");
	var_03.animname = "gate";
	var_03 maps\_utility::assign_animtree("gate");
	var_04 = level.infiltratorburke;
	var_05 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_06 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_07 = maps\_utility::get_living_ai("CourtyardAllyTarget1","script_noteworthy");
	var_08 = maps\_utility::get_living_ai("CourtyardAllyTarget2","script_noteworthy");
	var_09 = maps\_utility::get_living_ai("CourtyardAllyTarget3","script_noteworthy");
	var_01 notify("stop_loop");
	thread gatebreachandclear(var_01,var_04,var_02,var_00);
	thread gatebreachandclear(var_01,var_05,var_02,var_00);
	thread gatebreachandclear(var_01,var_06,var_02,var_00);
	if(isdefined(var_07))
	{
		thread gatebreachvictimdie(var_01,var_07,var_02,0,var_00);
	}

	if(isdefined(var_08))
	{
		thread gatebreachotherguysdie(var_08.idlepoint,var_08,"so_hijack_search_gear_check_reaction",0,var_00);
	}

	if(isdefined(var_09))
	{
		thread gatebreachotherguysdie(var_09.idlepoint,var_09,"patrol_bored_duckandrun_b",1,var_00);
	}

	var_01 maps\_anim::anim_single_solo(var_03,"gate_breach");
	common_scripts\utility::flag_set("FlagGateBreachComplete");
}

//Function Number: 122
gatebreachandclear(param_00,param_01,param_02,param_03)
{
	param_01.no_stopanimscripted = 1;
	param_00 maps\_anim::anim_single_solo_run(param_01,param_02);
	param_01.no_stopanimscripted = undefined;
	if(param_03 == "FlagCourtyardAlliesBreachGate")
	{
		allyredirectnoteworthy(param_01.script_noteworthy,"GateInt");
	}
}

//Function Number: 123
gatebreachvictimdie(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("death");
	param_01 maps\_utility::set_ignoreme(1);
	if(param_04 == "FlagCourtyardAlliesBreachGate")
	{
		param_01.animname = "victim";
		param_01.health = 999999;
		param_01.no_stopanimscripted = 1;
		param_01 thread gatebreachoutlineguard();
		param_01 disableenemyalert();
		param_01.bscripteddeath = 1;
		param_00 maps\_anim::anim_single_solo(param_01,param_02);
		param_01 maps\greece_code::kill_no_react(0);
		param_01 animscripts\notetracks::notetrackstartragdoll("ragdoll");
		return;
	}

	param_01 maps\_utility::anim_stopanimscripted();
	param_01 thread maps\_sniper_setup_ai::alertai();
	param_01 maps\_utility::clear_generic_idle_anim();
	param_01 maps\_utility::clear_generic_run_anim();
	if(common_scripts\utility::flag("FlagCourtyardGuardNearGate"))
	{
		wait 0.05;
		param_01 maps\_anim::anim_single_solo(param_01,"breach_react_blowback_v2");
	}

	param_01.favoriteenemy = level.infiltratorburke;
	param_01 maps\_utility::set_ignoreme(0);
	param_01 findnearbycovernode(512);
	param_01.combatmode = "cover";
}

//Function Number: 124
gatebreachotherguysdie(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("death");
	if(param_03 == 1)
	{
		param_01 thread maps\greece_code::setragdolldeath();
	}

	if(param_04 == "FlagCourtyardAlliesBreachGate")
	{
		level waittill("ConfCenterGateBreach");
		wait(0.1);
	}

	param_01 maps\greece_code::setalertoutline();
	param_01 maps\_utility::set_ignoreme(0);
	if(isdefined(param_00))
	{
		param_00 maps\_anim::anim_single_solo(param_01,param_02);
	}
}

//Function Number: 125
gatebreachoutlineguard()
{
	self endon("death");
	level waittill("ConfCenterGateBreach");
	wait(0.1);
	maps\greece_code::setalertoutline();
}

//Function Number: 126
gatebreachvictimapproach()
{
	level endon("alarm_mission_end");
	self endon("damage");
	self endon("death");
	self endon("corpse");
	self endon("bulletwhizby");
	self endon("guy_alerted");
	common_scripts\utility::flag_wait("FlagAllyShootGateGuard");
	wait(3);
	self.script_animation = "gundown";
	maps\_patrol::set_patrol_run_anim_array();
	aiidleloopdisable(0);
	var_00 = common_scripts\utility::getstruct("Goal1CourtyardAllyTarget1","script_noteworthy");
	var_01 = var_00.animation;
	var_00 maps\_anim::anim_reach_solo(self,var_01);
	common_scripts\utility::flag_set("FlagCourtyardGuardNearGate");
	thread markallytargets("Courtyard");
	var_00 maps\_anim::anim_single_solo(self,var_01);
	level notify("CourtyardGuardAtGate");
	common_scripts\utility::flag_set("FlagCourtyardAlliesBreachGate");
}

//Function Number: 127
monitorcourtyardplayertargets()
{
	level endon("alarm_mission_end");
	var_00 = [];
	var_01 = maps\_utility::get_living_ai_array("EnemyPatrolCourtyard_AI","targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "CourtyardPlayerTarget1" || var_03.script_noteworthy == "CourtyardPlayerTarget2")
		{
			var_00 = common_scripts\utility::array_add(var_00,var_03);
		}
	}

	maps\_utility::waittill_dead_or_dying(var_01,1);
	common_scripts\utility::flag_set("FlagCourtyardAnyOverwatchDead");
	var_05 = [];
	var_05["sight_dist"] = 400;
	var_05["detect_dist"] = 100;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_05);
	maps\_utility::waittill_dead_or_dying(var_01);
	common_scripts\utility::flag_set("FlagCourtyardAllOverwatchDead");
	common_scripts\utility::flag_wait("FlagAllCourtyardGuardsDead");
	var_05["sight_dist"] = 800;
	var_05["detect_dist"] = 200;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_05);
}

//Function Number: 128
monitorcourtyardallytargets()
{
	var_00 = [];
	common_scripts\utility::flag_wait("FlagBeginCourtyardSetup");
	var_01 = maps\_utility::get_living_ai("CourtyardAllyTarget1","script_noteworthy");
	if(isdefined(var_01))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_01);
	}

	var_02 = maps\_utility::get_living_ai("CourtyardAllyTarget2","script_noteworthy");
	if(isdefined(var_02))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_02);
	}

	var_03 = maps\_utility::get_living_ai("CourtyardAllyTarget3","script_noteworthy");
	if(isdefined(var_03))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_03);
	}

	if(var_00.size > 0)
	{
		foreach(var_05 in var_00)
		{
			var_05 maps\greece_code::settargetoutline();
			var_05 thread monitorcourtyardallytargetdeath();
		}

		return;
	}

	common_scripts\utility::flag_set("FlagCourtyardAlliesBreachGateAlt");
}

//Function Number: 129
monitorcourtyardallytargetdeath()
{
	level endon("CourtyardGuardAtGate");
	common_scripts\utility::waittill_any("death","corpse","bulletwhizby");
	common_scripts\utility::flag_set("FlagCourtyardAlliesBreachGateAlt");
}

//Function Number: 130
gatebreachdoorsexplode(param_00)
{
	thread maps\greece_conf_center_fx::confcentergatecharge();
	level notify("ConfCenterGateBreach");
	maps\_utility::radio_dialogue_stop();
	soundscripts\_snd::snd_message("start_gate_breach_music");
	wait(0.5);
}

//Function Number: 131
enemypatrolcourtyardthread(param_00)
{
	level endon("alarm_mission_end");
	thread maps\greece_code::aiarrayidleloop(param_00);
	thread enemygroupcorpsedetection(param_00,"disableCourtyardCorpseDetection");
	thread monitorcourtyardplayertargets();
	thread monitorcourtyardallytargets();
	foreach(var_02 in param_00)
	{
		if(var_02.script_noteworthy == "CourtyardPlayerTarget1" || var_02.script_noteworthy != "CourtyardPlayerTarget2")
		{
			var_02.dropweapon = 0;
		}
	}

	var_02 = maps\_utility::get_living_ai("CourtyardAllyTarget1","script_noteworthy");
	var_02 thread gatebreachvictimapproach();
	level waittill("ConfCenterGateBreach");
	wait(0.1);
	maps\_hms_utility::printlnscreenandconsole("Courtyard enemies are alerted!!!");
	var_04 = maps\_utility::get_living_ai_array("EnemyPatrolCourtyard_AI","targetname");
	foreach(var_02 in var_04)
	{
		if(var_02.script_noteworthy != "CourtyardAllyTarget1" && var_02.script_noteworthy != "CourtyardAllyTarget2" && var_02.script_noteworthy != "CourtyardAllyTarget3")
		{
			var_02 thread maps\_sniper_setup_ai::alertai();
		}
	}
}

//Function Number: 132
courtyardspecialdetection()
{
	level endon("alarm_mission_end");
	level endon("disableCourtyardSpecialDetection");
	var_00 = [];
	var_01 = maps\_utility::get_living_ai("CourtyardAllyTarget1","script_noteworthy");
	if(isdefined(var_01) && isalive(var_01))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_01);
	}

	var_02 = maps\_utility::get_living_ai("CourtyardAllyTarget2","script_noteworthy");
	if(isdefined(var_02) && isalive(var_02))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_02);
	}

	var_03 = maps\_utility::get_living_ai("CourtyardAllyTarget3","script_noteworthy");
	if(isdefined(var_03) && isalive(var_03))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_03);
	}

	maps\_utility::waittill_dead_or_dying(var_00,1);
	foreach(var_05 in var_00)
	{
		wait(randomfloat(0.1));
		if(isdefined(var_05) && isalive(var_05))
		{
			var_05 thread maps\_sniper_setup_ai::alertai(0);
		}
	}
}

//Function Number: 133
enemygroupcorpsedetection(param_00,param_01)
{
	level endon("alarm_mission_end");
	level endon(param_01);
	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	if(isdefined(param_00[0].script_stealthgroup))
	{
		var_02 = maps\_stealth_shared_utilities::group_get_ai_in_group(param_00[0].script_stealthgroup);
		maps\_utility::waittill_dead_or_dying(var_02,1);
		foreach(var_04 in var_02)
		{
			if(var_04 != self)
			{
				wait(randomfloat(0.1));
				if(isdefined(var_04) && isalive(var_04))
				{
					var_04 thread maps\_sniper_setup_ai::alertai(0);
				}
			}
		}
	}
}

//Function Number: 134
rooftopwatchparkingguards()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("RooftopPlayerTarget1","script_noteworthy");
	var_00 endon("death");
	var_01 = maps\_utility::get_living_ai("RooftopPlayerTarget2","script_noteworthy");
	var_01 endon("death");
	wait 0.05;
	var_02 = maps\_utility::get_living_ai_array("EnemyPatrolParking_AI","targetname");
	var_02 = maps\_utility::array_removedead_or_dying(var_02);
	maps\_utility::waittill_dead_or_dying(var_02,1);
	if(isdefined(var_00) && isalive(var_00))
	{
		var_00 thread maps\_sniper_setup_ai::alertai(0);
	}

	if(isdefined(var_01) && isalive(var_01))
	{
		var_01 thread maps\_sniper_setup_ai::alertai(0);
	}
}

//Function Number: 135
enemypatrolwalkwaythread(param_00)
{
	level endon("alarm_mission_end");
	thread maps\greece_code::aiarrayidleloop(param_00);
}

//Function Number: 136
enemypatrolpoolthread(param_00)
{
	level endon("alarm_mission_end");
	thread maps\greece_code::aiarrayidleloop(param_00);
	thread enemygroupcorpsedetection(param_00,"disablePoolCorpseDetection");
	var_01 = maps\_utility::get_living_ai("PoolAllyTarget1","script_noteworthy");
	if(isdefined(var_01))
	{
		var_01 thread setuppoolkillvictim();
	}

	foreach(var_03 in param_00)
	{
		var_03 thread monitorpoolguard();
	}
}

//Function Number: 137
monitorpoolguard()
{
	level endon("alarm_mission_end");
	self endon("disablePoolAlert");
	common_scripts\utility::waittill_any("death","guy_alerted");
	common_scripts\utility::flag_set("FlagPoolKillBegin");
}

//Function Number: 138
setuppoolkillvictim()
{
	level endon("alarm_mission_end");
	self.animname = "victim";
	self.idlepoint = common_scripts\utility::getstruct("OrgPoolKill","script_noteworthy");
	self.idlepoint thread maps\_anim::anim_loop_solo(self,"hms_greece_cc_takedown_idle","stop_loop");
	maps\_utility::gun_remove();
	self attach("prop_cigarette","tag_inhand",1);
	self.allowdeath = 1;
	self.customreactanime = "hms_greece_cc_takedown_react";
	thread monitorpoolkillvictim();
	thread monitorpoolkillvictimdeath();
	thread monitorpoolkillvictimalert();
}

//Function Number: 139
monitorpoolkillvictim()
{
	level endon("alarm_mission_end");
	self endon("death");
	common_scripts\utility::flag_wait("FlagPoolKillReady");
	self notify("disablePoolAlert");
	disableenemyalert();
	maps\_stealth_utility::stealth_set_group_default();
	self.disablecorpsealert = 1;
	maps\_stealth_utility::disable_stealth_for_ai();
	self.no_stopanimscripted = 1;
	maps\_utility::set_ignoreme(1);
	maps\_utility::set_ignoreall(1);
	common_scripts\utility::waittill_any("guy_alerted","bulletwhizby","projectile_impact","damage");
	common_scripts\utility::flag_set("FlagPoolKillBegin");
}

//Function Number: 140
monitorpoolkillvictimalert()
{
	var_00 = common_scripts\utility::getstruct("OrgPoolKill","script_noteworthy");
	level endon("alarm_mission_end");
	self endon("disableAlert");
	self endon("allyPoolKill");
	self endon("death");
	self waittill("guy_alerted");
	wait 0.05;
	if(isdefined(self.damagelocation))
	{
		return;
	}

	self notify("poolGuy_alerted");
	var_00 notify("stop_loop");
	self detach("prop_cigarette","tag_inhand");
	maps\_utility::forceuseweapon("iw5_sn6_sp","primary");
	if(self.health == 999999)
	{
		self.health = self.default_health;
	}

	maps\_utility::set_ignoreme(0);
	maps\_utility::set_ignoreall(0);
	var_01 = getnode("PoolEnemyCover","script_noteworthy");
	maps\_utility::set_goal_node(var_01);
	self.combatmode = "cover";
	self.allyclaimedtarget = 0;
	self waittill("goal");
	self.allyclaimedtarget = 0;
	wait(level.alerttimedelay);
	common_scripts\utility::flag_set("FlagAlarmMissionEnd");
}

//Function Number: 141
monitorpoolkillvictimdeath()
{
	var_00 = common_scripts\utility::getstruct("OrgPoolKill","script_noteworthy");
	var_01 = "hms_greece_cc_takedown_death";
	level endon("alarm_mission_end");
	self endon("death");
	self endon("poolGuy_alerted");
	self endon("allyPoolKill");
	common_scripts\utility::flag_wait("FlagPoolKillReady");
	self.default_health = self.health;
	self.health = 999999;
	self waittill("damage");
	common_scripts\utility::flag_set("FlagPlayerKillPoolGuard");
	wait 0.05;
	var_00 notify("stop_loop");
	self.ignoreall = 1;
	maps\_stealth_utility::disable_stealth_for_ai();
	disableenemyalert();
	maps\greece_code::giveplayerchallengekillpoint();
	self notify("scripted_death");
	self.bscripteddeath = 1;
	thread unmarkandremoveoutline(0.5);
	var_00 maps\_anim::anim_single_solo(self,var_01);
	maps\greece_code::kill_no_react(0,level.player);
}

//Function Number: 142
enemypatrolatriumthread(param_00)
{
	level endon("alarm_mission_end");
	thread maps\greece_code::aiarrayidleloop(param_00);
	thread enemygroupcorpsedetection(param_00,"disableAtriumCorpseDetection");
	common_scripts\utility::flag_wait("FlagAtriumEnemiesReactToBreach");
	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	var_01 = getent("OrgAtriumMuteCharge","targetname");
	var_02 = 750;
	var_03 = common_scripts\utility::get_array_of_closest(var_01.origin,param_00);
	foreach(var_05 in var_03)
	{
		if(isalive(var_05))
		{
			var_05 thread enemyatriumflashbang(var_01);
			var_06 = distancesquared(var_05.origin,var_01.origin);
			var_07 = var_06 * 5E-07;
			wait(var_07);
		}
	}

	common_scripts\utility::flag_set("FlagAtriumEnemiesAllMarked");
	common_scripts\utility::flag_wait("FlagAtriumEnemiesAlmostAllDead");
	var_09 = getent("AtriumFallbackVol","targetname");
	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	foreach(var_05 in param_00)
	{
		wait(randomfloatrange(0.5,1.5));
		if(isdefined(var_05))
		{
			var_0B = "FallbackVol" + var_05.script_noteworthy;
			var_0C = getent(var_0B,"script_noteworthy");
			if(isdefined(var_0C))
			{
				var_05 setgoalvolumeauto(var_0C);
			}
		}
	}
}

//Function Number: 143
enemyatriumflashbang(param_00)
{
	self endon("death");
	self endon("dying");
	self notify("end_patrol");
	self notify("new_anim_reach");
	disableenemyalert();
	maps\_stealth_utility::disable_stealth_for_ai();
	aiidleloopdisable(0);
	wait(0.05);
	if(!maps\_utility::is_in_array(level.alertedenemies,self))
	{
		level.alertedenemies = common_scripts\utility::add_to_array(level.alertedenemies,self);
	}

	level.playertargets = common_scripts\utility::add_to_array(level.playertargets,self);
	if(distancesquared(param_00.origin,self.origin) < 850000)
	{
		var_01 = 5;
		if(isdefined(self) && isalive(self))
		{
			self stopanimscripted();
			thread markplayertarget(1,0);
			maps\_utility::flashbangstart(var_01);
		}

		wait(var_01);
	}

	aienablestealthcombat();
}

//Function Number: 144
monitoratriumenemieskilled()
{
	level endon("AtriumTimerExpire");
	level.playertargets = maps\_utility::array_removedead_or_dying(level.playertargets);
	var_00 = level.playertargets.size - 3;
	maps\_utility::waittill_dead(level.playertargets,var_00);
	maps\_hms_utility::printlnscreenandconsole("Atrium enemies falling back...");
	common_scripts\utility::flag_set("FlagAtriumEnemiesAlmostAllDead");
	common_scripts\utility::flag_wait("FlagAllAtriumGuardsDead");
	level notify("AtriumTimerFreeze");
	var_01 = [];
	var_01["sight_dist"] = 800;
	var_01["detect_dist"] = 200;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_01);
}

//Function Number: 145
enemypatrolrooftopthread(param_00)
{
	thread maps\greece_code::aiarrayidleloop(param_00);
	thread enemygroupcorpsedetection(param_00,"disableRooftopCorpseDetection");
	thread rooftopwatchparkingguards();
	foreach(var_02 in param_00)
	{
		var_02.dropweapon = 0;
	}
}

//Function Number: 146
enemypatrolparkingthread(param_00)
{
	level endon("alarm_mission_end");
	thread maps\greece_code::aiarrayidleloop(param_00);
	thread enemygroupcorpsedetection(param_00,"disableParkingCorpseDetection");
	thread monitorparkingguards(param_00);
	thread setupparkinginvestigators();
}

//Function Number: 147
monitorparkingguards(param_00)
{
	thread monitorparkingguardsdead(param_00);
	common_scripts\utility::flag_wait("FlagUnMarkParkingCars");
	thread setupplayertargets("ParkingPlayerTarget");
}

//Function Number: 148
monitorparkingguardsdead(param_00)
{
	maps\_utility::waittill_dead_or_dying(param_00,1);
	common_scripts\utility::flag_set("FlagAnyParkingGuardsDead");
}

//Function Number: 149
setupparkinginvestigators()
{
	var_00 = [];
	var_01 = maps\_utility::get_living_ai("ParkingPlayerTarget1","script_noteworthy");
	if(isdefined(var_01))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_01);
	}

	var_02 = maps\_utility::get_living_ai("ParkingPlayerTarget2","script_noteworthy");
	if(isdefined(var_02))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_02);
	}

	var_03 = maps\_utility::get_living_ai("ParkingPlayerTarget3","script_noteworthy");
	if(isdefined(var_03))
	{
		var_00 = common_scripts\utility::add_to_array(var_00,var_03);
	}

	thread monitorparkinginvestigatorsneargoal(var_00);
	thread monitorparkinginvestigatorsdead(var_00);
	common_scripts\utility::flag_wait("FlagParkingCarAlarmActivated");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	var_04 = level.parkingalarmcar.script_noteworthy;
	foreach(var_06 in var_00)
	{
		var_06 notify("end_patrol");
		var_06.alertgroup = 0;
	}

	thread aiarraymovetonewidlepos(var_00,var_04);
	common_scripts\utility::flag_set("FlagParkingGuardsMovingToCar");
}

//Function Number: 150
monitorparkinginvestigatorsdead(param_00)
{
	level endon("parking_guard_shot");
	maps\_utility::waittill_dead_or_dying(param_00,1);
	common_scripts\utility::flag_set("FlagUnMarkParkingCars");
	level notify("parking_guard_shot");
}

//Function Number: 151
monitorparkinginvestigatorsneargoal(param_00)
{
	var_01 = 0;
	var_02 = [];
	var_02 = maps\_utility::array_merge(param_00,var_02);
	var_03 = getent("ParkingGuardsNearCar","targetname");
	var_04 = param_00.size - 1;
	for(;;)
	{
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		foreach(var_06 in var_02)
		{
			if(var_06 istouching(var_03))
			{
				var_02 = common_scripts\utility::array_remove(var_02,var_06);
				var_01++;
				maps\_hms_utility::printlnscreenandconsole("Number " + var_01 + " guy hit trigger: " + var_06.script_noteworthy);
			}
		}

		if(var_01 == var_04)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("FlagParkingGuardsNearCar");
	wait(5);
	_caralarmstop();
}

//Function Number: 152
aiarraymovetonewidlepos(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = "walk";
	}

	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	foreach(var_05 in param_00)
	{
		var_05 thread aimovetonewidlepos(param_01,param_02,param_03);
	}
}

//Function Number: 153
aimovetonewidlepos(param_00,param_01,param_02)
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	self endon("damage");
	self endon("death");
	self endon("enemy");
	self endon("corpse");
	self endon("bulletwhizby");
	self endon("brokenglass");
	self endon("guy_alerted");
	self notify("end_patrol");
	self notify("new_anim_reach");
	waittillframeend;
	self.idlepointreached = 0;
	var_03 = param_00 + self.script_noteworthy;
	var_04 = common_scripts\utility::getstruct(var_03,"script_noteworthy");
	if(isdefined(var_04))
	{
		if(!isdefined(param_02))
		{
			param_02 = 0;
		}

		if(!isdefined(param_01))
		{
			param_01 = "walk";
		}

		if(isdefined(var_04.script_animation))
		{
			var_05 = var_04.script_animation;
			self.script_animation = var_05;
			maps\_patrol::set_patrol_run_anim_array();
		}

		aiidleloopdisable(param_02);
		self.idlepoint = var_04;
		var_06 = self.idlepoint.animation;
		if(param_01 == "teleport")
		{
			self forceteleport(self.idlepoint.origin,self.idlepoint.angles);
		}
		else
		{
			var_07 = var_06 + "_in";
			if(maps\_utility::hasanim(var_07))
			{
				self.idlepoint maps\_anim::anim_reach_solo(self,var_07);
				self.idlepoint maps\_anim::anim_single_solo(self,var_07);
			}
			else
			{
				self.idlepoint maps\_anim::anim_reach_solo(self,var_06);
			}
		}

		self.idlepointreached = 1;
		self notify("goal");
		self.idlepoint thread maps\_anim::anim_loop_solo(self,self.idlepoint.animation,"stop_loop");
	}
}

//Function Number: 154
chooseidlepointreactanimation(param_00)
{
	self endon("damage");
	self endon("death");
	self endon("dying");
	if(isdefined(self) && isalive(self))
	{
		if(self.animname == "generic" && isdefined(level.scr_anim["generic"][param_00]))
		{
			self.idlepoint maps\_anim::anim_single_solo(self,param_00);
			return;
		}

		if(maps\_utility::hasanim(param_00))
		{
			self.idlepoint maps\_anim::anim_single_solo(self,param_00);
			return;
		}
	}
}

//Function Number: 155
aiidleloopdisable(param_00)
{
	self endon("damage");
	self endon("death");
	self endon("dying");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self) && isalive(self))
	{
		if(!isdefined(self.no_stopanimscripted))
		{
			maps\_utility::anim_stopanimscripted();
		}

		if(param_00 == 1)
		{
			var_01 = self.customreactanime;
			if(isdefined(var_01))
			{
				if(maps\_utility::hasanim(var_01))
				{
					thread maps\_anim::anim_single_solo_run(self,var_01);
				}
			}
		}

		if(isdefined(self.idlepoint))
		{
			self.idlepoint notify("stop_loop");
			var_02 = self.idlepoint.animation;
			if(isdefined(self.idlepointreached) && self.idlepointreached == 1 && isdefined(var_02))
			{
				if(param_00 == 1)
				{
					chooseidlepointreactanimation(var_02 + "_react");
				}
				else
				{
					chooseidlepointreactanimation(var_02 + "_out");
				}
			}

			self.idlepoint = undefined;
		}
	}
}

//Function Number: 156
aienabletotalcombat(param_00)
{
	self endon("death");
	if(isdefined(self.bscripteddeath) && self.bscripteddeath == 1)
	{
		return;
	}

	if(isdefined(self.no_stopanimscripted) && self.no_stopanimscripted == 1)
	{
		for(;;)
		{
			if(!isdefined(self.no_stopanimscripted))
			{
				break;
			}

			if(self.no_stopanimscripted == 0)
			{
				break;
			}

			wait(0.05);
		}
	}

	if(isdefined(self.default_health))
	{
		self.health = self.default_health;
		self.default_health = undefined;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	maps\_utility::enable_arrivals();
	maps\_utility::enable_exits();
	maps\greece_code::enableawareness();
	maps\_utility::clear_run_anim();
	maps\_stealth_utility::disable_stealth_for_ai();
	self notify("end_patrol");
	self notify("new_anim_reach");
	disableenemyalert();
	self notify("guy_alerted");
	waittillframeend;
	switch(self.team)
	{
		case "allies":
			if(level.balliesintruck == 0)
			{
				self notify("stop_loop");
				thread maps\_utility::set_battlechatter(1);
				maps\_utility::enable_danger_react(10);
				maps\_stealth_accuracy_friendly::friendly_acc_spotted();
				self.enemyteam = "axis";
			}
			break;

		case "axis":
			aiidleloopdisable(param_00);
			thread maps\_utility::set_battlechatter(1);
			maps\greece_code::setalertoutline();
			thread maps\greece_code::clearalertoutline();
			self notify("removeTargetObj");
			self.enemyteam = "allies";
			self.alertlevel = "combat";
			self.combatmode = "cover";
			maps\_utility::clear_generic_idle_anim();
			maps\_utility::clear_generic_run_anim();
			break;
	}

	var_01 = maps\_utility::get_closest_ai(self.origin,self.enemyteam);
	if(isdefined(var_01))
	{
		maps\_utility::set_favoriteenemy(var_01);
	}

	var_02 = self findbestcovernode();
	if(isdefined(var_02))
	{
		maps\_utility::set_goal_radius(64);
		maps\_utility::set_forcegoal();
		maps\_utility::set_goal_node(var_02);
		self waittill("goal");
		maps\_utility::unset_forcegoal();
	}
}

//Function Number: 157
aienablestealthcombat()
{
	maps\_stealth_utility::disable_stealth_for_ai();
	maps\_utility::enable_arrivals();
	maps\_utility::enable_exits();
	switch(self.team)
	{
		case "allies":
			self.enemyteam = "axis";
			self.ignoreall = 0;
			self.ignoreme = 0;
			maps\_utility::disable_dontevershoot();
			maps\_stealth_accuracy_friendly::friendly_acc_spotted();
			break;

		case "axis":
			maps\_utility::clear_generic_idle_anim();
			maps\_utility::clear_run_anim();
			self allowedstances("stand","crouch","prone");
			self.enemyteam = "allies";
			maps\_utility::disable_long_death();
			thread aistealthcombatenemygotocover();
			break;
	}

	var_00 = get_closest_ai_flat(self.origin,self.enemyteam);
	if(isdefined(var_00))
	{
		maps\_utility::set_favoriteenemy(var_00);
	}
}

//Function Number: 158
aistealthcombatenemygotocover()
{
	self endon("death");
	self endon("dying");
	var_00 = "Vol" + self.script_noteworthy;
	var_01 = getentarray(var_00,"script_noteworthy");
	if(var_01.size > 0)
	{
		if(var_01.size > 1)
		{
			var_01 = common_scripts\utility::array_randomize(var_01);
		}

		self setgoalvolumeauto(var_01[0]);
		return;
	}

	var_02 = self findbestcovernode();
	if(isdefined(var_02))
	{
		maps\_utility::set_goal_node(var_02);
	}
}

//Function Number: 159
aidisablestealthcombat()
{
	maps\_stealth_utility::enable_stealth_for_ai();
	maps\_utility::enable_dontevershoot();
	maps\_stealth_accuracy_friendly::friendly_acc_hidden();
	if(isdefined(self.enemy))
	{
		var_00 = self.enemy;
		if(isdefined(var_00.script_noteworthy))
		{
			maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " has enemy " + var_00.script_noteworthy);
		}

		self clearenemy();
	}

	maps\_utility::enable_cqbwalk();
	self.ignoreall = 1;
	self.ignoreme = 1;
}

//Function Number: 160
monitorallyenemy()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self.enemy))
		{
			var_00 = self.enemy;
			if(isdefined(var_00.script_noteworthy))
			{
				maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " has enemy " + var_00.script_noteworthy);
			}
		}

		wait(0.05);
	}
}

//Function Number: 161
alliesredirect(param_00,param_01,param_02)
{
	level endon("end_sniper_drone");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	level.allyinfiltrators = maps\_utility::array_removedead_or_dying(level.allyinfiltrators);
	foreach(var_04 in level.allyinfiltrators)
	{
		var_04 allyredirect(param_00,param_01,param_02);
	}

	maps\_hms_utility::printlnscreenandconsole("Allies moving to " + param_00);
}

//Function Number: 162
allyredirectnoteworthy(param_00,param_01,param_02,param_03)
{
	level endon("end_sniper_drone");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = maps\_utility::get_living_ai(param_00,"script_noteworthy");
	var_04 allyredirect(param_01,param_02,param_03);
	maps\_hms_utility::printlnscreenandconsole(param_00 + "ally moving to " + param_01);
}

//Function Number: 163
allyredirect(param_00,param_01,param_02)
{
	maps\_utility::set_goal_radius(64);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_01)
	{
		maps\_utility::set_forcegoal();
		thread allyclearforcegoalonend();
	}

	var_03 = getnode(param_00 + self.script_noteworthy,"targetname");
	if(param_02 == 1)
	{
		maps\_utility::teleport_ai(var_03);
		self notify("goal");
	}
	else
	{
		maps\_utility::set_goal_node(var_03);
	}

	if(level.showdebugtoggle == 1)
	{
		thread maps\_utility::draw_line_from_ent_to_ent_until_notify(self,var_03,1,1,1,self,"goal");
	}
}

//Function Number: 164
allyclearforcegoalonend()
{
	self endon("death");
	self waittill("goal");
	maps\_utility::unset_forcegoal();
}

//Function Number: 165
alliesdrivein(param_00,param_01)
{
	var_02 = "bodystash_idle";
	var_03 = "bodystash";
	var_04 = getent("BodyStashOrg","targetname");
	var_05 = getent("delivery_truck","targetname");
	var_05 maps\_utility::assign_animtree("truck");
	var_05.animname = "truck";
	var_06 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	var_07 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_08 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	if(param_00)
	{
		var_04 maps\_anim::anim_last_frame_solo(var_05,var_03);
		level.balliesintruck = 0;
		return;
	}

	var_09 = [var_05,var_07,var_08,var_06];
	var_07 hide();
	var_08 hide();
	var_06 hide();
	var_04 maps\_anim::anim_first_frame(var_09,var_03);
	level.balliesintruck = 1;
	thread truckdrivein(param_01);
}

//Function Number: 166
allywalkwaykill()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_00.animname = "infiltrator2";
	var_01 = common_scripts\utility::getstruct("IdleWalkwayAllyTarget1","script_noteworthy");
	monitorallywalkwaykillvictim(var_01,var_00);
	var_00 maps\greece_code::clear_set_goal();
	thread allyredirectnoteworthy("Infiltrator2","Walkway");
}

//Function Number: 167
monitorallywalkwaykillvictim(param_00,param_01)
{
	var_02 = maps\_utility::get_living_ai("WalkwayAllyTarget1","script_noteworthy");
	if(isdefined(var_02))
	{
		var_02 endon("death");
		var_02 markalliesenemytarget();
		var_02 maps\greece_code::settargetoutline();
	}

	param_00 maps\_anim::anim_reach_solo(param_01,"parabolic_knifekill");
	common_scripts\utility::flag_set("FlagWalkwayAlliesPerformKill");
	thread maps\greece_conf_center_vo::walkwayguarddialogue();
	maps\_hms_utility::printlnscreenandconsole("Allies at Walkway!");
	if(isdefined(var_02))
	{
		if(maps\_utility::is_in_array(level.alertedenemies,var_02))
		{
			param_01 allyshootwalkwaytarget();
			return;
		}

		param_01.no_stopanimscripted = 1;
		var_02 thread allywalkwaykillvictim(param_00);
		param_00 maps\_anim::anim_single_solo_run(param_01,"parabolic_knifekill");
		param_01.no_stopanimscripted = undefined;
	}
}

//Function Number: 168
allyshootwalkwaytarget()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("WalkwayAllyTarget1","script_noteworthy");
	var_00 endon("death");
	while(!common_scripts\utility::flag("FlagAllWalkwayGuardsDead"))
	{
		if(isdefined(var_00))
		{
			var_00 disableenemyalert();
			maps\greece_code::shootguy(var_00);
			soundscripts\_snd::snd_message("npc_shoots_pool_enemy");
		}

		wait(0.2);
	}
}

//Function Number: 169
allywalkwaykillvictim(param_00)
{
	self endon("death");
	param_00 notify("stop_loop");
	maps\_stealth_utility::disable_stealth_for_ai();
	self.no_stopanimscripted = 1;
	disableenemyalert();
	thread monitorwalkwaykillvictim();
	self.health = 10;
	maps\_utility::set_ignoreall(1);
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_stealth_utility::disable_stealth_for_ai();
	self.animname = "victim";
	param_00 thread maps\_anim::anim_single_solo(self,"parabolic_knifekill");
	self.allowdeath = 1;
	level waittill("WalkwayGuyStruggle");
	self.health = 1000000;
	self.bscripteddeath = 1;
	level notify("WalkwayAllyKill");
	maps\_utility::radio_dialogue_stop();
	param_00 waittill("parabolic_knifekill");
	maps\greece_code::kill_no_react();
}

//Function Number: 170
monitorwalkwaykillvictim()
{
	level endon("WalkwayAllyKill");
	self waittill("death");
	maps\_utility::radio_dialogue_stop();
	thread maps\greece_conf_center_vo::walkwayplayerkilldialogue();
	wait 0.05;
	var_00 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_00 maps\_utility::anim_stopanimscripted();
}

//Function Number: 171
allypoolsetup()
{
	level endon("alarm_mission_end");
	var_00 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_00.animname = "infiltrator1";
	var_00.ignoreall = 1;
	var_00 thread maps\_utility::waterfx("FlagStopPoolWater");
	var_01 = common_scripts\utility::getstruct("OrgPoolKill","script_noteworthy");
	var_01 maps\_anim::anim_reach_solo(var_00,"pool_traverse_in");
	var_01 maps\_anim::anim_single_solo(var_00,"pool_traverse_in");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"pool_traverse_idle","stop_traverse_loop");
	var_00 thread allypoolkill();
}

//Function Number: 172
allypoolkill()
{
	level endon("alarm_mission_end");
	common_scripts\utility::flag_wait("FlagBeginStruggleSetup");
	var_00 = common_scripts\utility::getstruct("OrgPoolKill","script_noteworthy");
	self.ignoreall = 0;
	var_00 notify("stop_traverse_loop");
	var_00 maps\_anim::anim_single_solo(self,"pool_traverse_out");
	common_scripts\utility::flag_set("FlagPoolKillReady");
	if(!common_scripts\utility::flag("FlagPoolKillBegin") && !common_scripts\utility::flag("FlagEndPoolSetup"))
	{
		var_00 thread maps\_anim::anim_loop_solo(self,"hms_greece_cc_takedown_idle","stop_loop");
	}

	common_scripts\utility::flag_wait_either("FlagPoolKillBegin","FlagEndPoolSetup");
	var_01 = "hms_greece_cc_takedown";
	var_02 = maps\_utility::get_living_ai("PoolAllyTarget1","script_noteworthy");
	if(!isdefined(var_02) || maps\_utility::is_in_array(level.alertedenemies,var_02) || isdefined(var_02.damagelocation))
	{
		var_01 = "hms_greece_cc_takedown_fail";
	}

	var_00 notify("stop_loop");
	wait 0.05;
	if(var_01 == "hms_greece_cc_takedown")
	{
		common_scripts\utility::flag_set("FlagPoolKillSpecial");
	}

	thread allyexitpool(var_00,var_01);
	thread allyexithandlevictim(var_02,var_00,var_01);
	thread poolalliesadvance();
}

//Function Number: 173
victimpoolkill(param_00,param_01)
{
	self notify("allyPoolKill");
	self.bscripteddeath = 1;
	self.health = 99999;
	maps\_utility::set_allowdeath(0);
	maps\greece_conf_center_fx::confcenterpoolsplash();
	maps\greece_conf_center_fx::confcenterpoolallywaterdrip();
	maps\_utility::clear_deathanim();
	maps\greece_conf_center_anim::stealthkillvictim(self);
	self.no_stopanimscripted = 1;
	maps\_utility::set_ignoreall(1);
	param_00 maps\_anim::anim_single_solo(self,param_01);
	maps\_utility::set_allowdeath(1);
	maps\greece_code::kill_no_react();
}

//Function Number: 174
poolalliesadvance()
{
	for(;;)
	{
		var_00 = maps\_utility::get_living_ai_array("EnemyPatrolPool_AI","targetname");
		if(common_scripts\utility::flag("FlagPoolKillSpecial") && var_00.size == 1)
		{
			break;
		}
		else if(var_00.size == 0)
		{
			break;
		}

		wait(0.1);
	}

	common_scripts\utility::flag_set("FlagAllPoolGuardsDead");
}

//Function Number: 175
setuppoolallytargets()
{
	thread alliesshootpooltargets();
	var_00 = maps\_utility::get_living_ai("PoolAllyTarget1","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 markalliesenemytarget();
		var_00 maps\greece_code::settargetoutline();
	}
}

//Function Number: 176
alliesshootpooltargets()
{
	common_scripts\utility::flag_wait("FlagPoolKillBegin");
	var_00 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	var_01 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	wait(0.2);
	var_01 thread allyshootpooltarget(common_scripts\utility::flag("FlagPoolKillSpecial"));
	wait(0.1);
	var_00 thread allyshootpooltarget(common_scripts\utility::flag("FlagPoolKillSpecial"));
}

//Function Number: 177
allyshootpooltarget(param_00)
{
	level endon("alarm_mission_end");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = maps\_utility::get_living_ai_array("EnemyPatrolPool_AI","targetname");
	if(param_00 == 1)
	{
		var_02 = maps\_utility::get_living_ai("PoolAllyTarget1","script_noteworthy");
		if(isdefined(var_02))
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_02);
		}
	}

	while(!common_scripts\utility::flag("FlagAllPoolGuardsDead"))
	{
		var_01 = array_removeclaimedtargets(var_01);
		if(self.script_noteworthy == "InfiltratorBurke")
		{
			var_03 = maps\greece_code::get_farthest_living(self.origin,var_01);
		}
		else
		{
			var_03 = maps\_utility::get_closest_living(self.origin,var_01);
		}

		if(isdefined(var_03))
		{
			var_03.allyclaimedtarget = 1;
			var_03 disableenemyalert();
			if(var_03.script_noteworthy == "PoolAllyTarget1")
			{
				var_03.favoriteenemy = self;
			}

			maps\greece_code::shootguy(var_03,1);
			soundscripts\_snd::snd_message("npc_shoots_pool_enemy");
			thread alertallpoolguards();
		}

		wait(0.5);
		if(var_01.size == 0)
		{
			break;
		}
	}
}

//Function Number: 178
alertallpoolguards()
{
	var_00 = maps\_utility::get_living_ai_array("EnemyPatrolPool_AI","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "PoolAllyTarget1" && common_scripts\utility::flag("FlagPoolKillReady"))
		{
			continue;
		}

		var_02 maps\_utility::anim_stopanimscripted();
		var_02 thread maps\_sniper_setup_ai::alertai();
		var_02 maps\_utility::clear_generic_idle_anim();
		var_02 maps\_utility::clear_generic_run_anim();
		var_02 maps\_utility::set_ignoreme(0);
		var_02 findnearbycovernode(512);
		var_02.combatmode = "cover";
	}
}

//Function Number: 179
array_removeclaimedtargets(param_00)
{
	param_00 = maps\_utility::array_removedead_or_dying(param_00);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.allyclaimedtarget))
		{
			param_00 = common_scripts\utility::array_remove(param_00,var_02);
		}
	}

	return param_00;
}

//Function Number: 180
allypoolclimb()
{
	level endon("alarm_mission_end");
	var_00 = getent("OrgPoolKill","script_noteworthy");
	self.ignoreall = 0;
	var_00 maps\_anim::anim_single_solo(self,"pool_traverse_out");
	var_01 = "hms_greece_cc_takedown";
	if(common_scripts\utility::flag("FlagPlayerKillPoolGuard"))
	{
		var_01 = "hms_greece_cc_takedown_fail";
	}

	var_00 = getent("OrgPoolKill","script_noteworthy");
	thread allyexitpool(var_00,var_01);
}

//Function Number: 181
allyexitpool(param_00,param_01)
{
	level endon("alarm_mission_end");
	self.no_stopanimscripted = 1;
	param_00 maps\_anim::anim_single_solo_run(self,param_01);
	var_02 = maps\_utility::get_living_ai_array("EnemyPatrolPool_AI","targetname");
	var_03 = 0;
	if(param_01 == "hms_greece_cc_takedown")
	{
		var_03 = 1;
	}

	if(var_02.size > var_03)
	{
		maps\_utility::set_goal_pos(self.origin);
		var_04 = maps\_utility::get_living_ai("PoolAllyTarget1","script_noteworthy");
		if(isdefined(var_04) && param_01 != "hms_greece_cc_takedown")
		{
			thread maps\greece_code::shootguy(var_04,1);
		}
		else
		{
			thread allyshootpooltarget(0);
		}
	}

	wait(1);
	common_scripts\utility::flag_set("FlagStopPoolWater");
	self.no_stopanimscripted = undefined;
}

//Function Number: 182
allyexithandlevictim(param_00,param_01,param_02)
{
	level endon("alarm_mission_end");
	if(isdefined(param_00))
	{
		param_00 endon("death");
		if(!common_scripts\utility::flag("FlagPlayerKillPoolGuard") && param_02 == "hms_greece_cc_takedown")
		{
			param_00 victimpoolkill(param_01,param_02);
		}
	}
}

//Function Number: 183
alliesparkingsetup()
{
	foreach(var_01 in level.allyinfiltrators)
	{
		var_01 clearenemy();
	}

	level endon("ConfRoomSetupBreach");
	wait(1);
	thread allyredirectnoteworthy("Infiltrator1","ParkingStairs1");
	wait(2);
	allyredirectnoteworthy("Infiltrator2","ParkingStairs1");
	var_03 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_03 maps\greece_code::waittillaineargoal();
	common_scripts\utility::flag_set("FlagParkingAlliesOnStairs");
	maps\_hms_utility::printlnscreenandconsole("Allies at ParkingStairs!");
}

//Function Number: 184
allyburkeparkingsetup()
{
	level endon("ConfRoomSetupBreach");
	thread allyredirectnoteworthy("InfiltratorBurke","ParkingStairs1");
	level.infiltratorburke maps\greece_code::waittillaineargoal();
}

//Function Number: 185
alliesparkingkill()
{
	common_scripts\utility::flag_wait("FlagParkingCarAlarmActivated");
	var_00 = maps\_utility::get_living_ai("ParkingAllyTarget1","script_noteworthy");
	var_01 = getent("StairwayTakedownOrg","targetname");
	var_02 = "stairway_takedown";
	var_03 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 maps\greece_code::settargetoutline();
	}

	common_scripts\utility::flag_wait_all("FlagParkingAlliesOnStairs","FlagParkingGuardsMovingToCar");
	wait(1);
	if(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		if(isdefined(var_00))
		{
			maps\_hms_utility::printlnscreenandconsole("Gideon is now moving toward parking stairs kill...");
			var_01 maps\_anim::anim_reach_solo(var_03,var_02);
			if(isdefined(var_00) && isalive(var_00))
			{
				var_00 thread alliesparkingkillvictim(var_01,var_02);
				maps\_hms_utility::printlnscreenandconsole("Gideon is now performing parking stairs kill...");
				var_01 maps\_anim::anim_single_solo(var_03,var_02);
				var_00 notify("ParkingAllyKill");
				if(!common_scripts\utility::flag("FlagParkingPlayerStealKill"))
				{
					var_01 thread maps\_anim::anim_loop_solo(var_03,"stairway_takedown_idle","stop_stairway_idle");
				}
			}
			else if(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
			{
				thread allyredirectnoteworthy("InfiltratorBurke","ParkingStairs2");
			}
		}
		else
		{
			thread allyredirectnoteworthy("InfiltratorBurke","ParkingStairs2");
		}
	}

	common_scripts\utility::flag_set("FlagParkingAlliesPerformKill");
}

//Function Number: 186
alliesparkingkillvictim(param_00,param_01)
{
	self endon("death");
	thread monitorparkingkillvictim();
	self.health = 10;
	maps\_utility::set_ignoreall(1);
	self notify("end_patrol");
	self.animname = "victim";
	if(isdefined(self.idlepoint))
	{
		self.idlepoint notify("stop_loop");
	}

	disableenemyalert();
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_stealth_utility::disable_stealth_for_ai();
	self.bscripteddeath = 1;
	param_00 thread maps\_anim::anim_single_solo(self,param_01);
	self.allowdeath = 1;
	param_00 waittill(param_01);
	maps\greece_code::kill_no_react(0);
}

//Function Number: 187
monitorparkingkillvictim()
{
	self waittill("death");
	self endon("ParkingAllyKill");
	common_scripts\utility::flag_set("FlagParkingPlayerStealKill");
	wait 0.05;
	level.infiltratorburke maps\_utility::anim_stopanimscripted();
	thread allyredirectnoteworthy("InfiltratorBurke","ParkingStairs2");
	common_scripts\utility::flag_set("FlagParkingAlliesPerformKill");
}

//Function Number: 188
alliesparkingkillalt()
{
	level endon("parking_alarm_activated");
	level endon("alarm_mission_end");
	level endon("ConfRoomSetupBreach");
	common_scripts\utility::flag_wait_all("FlagParkingAlliesOnStairs","FlagAnyParkingGuardsDead");
	wait(1);
	var_00 = maps\_utility::get_living_ai("ParkingAllyTarget1","script_noteworthy");
	while(!common_scripts\utility::flag("FlagAllParkingGuardsDead"))
	{
		if(isdefined(var_00))
		{
			var_00 disableenemyalert();
			level.infiltratorburke maps\greece_code::shootguy(var_00);
			level.infiltratorburke soundscripts\_snd::snd_message("npc_shoots_pool_enemy");
		}

		wait(0.2);
	}

	wait(1);
	thread allyredirectnoteworthy("InfiltratorBurke","ParkingStairs2");
}

//Function Number: 189
allysetupstruggle()
{
	var_00 = [];
	var_01 = getent("burkeambush_door","targetname");
	var_01.animname = "burkeambush_door";
	var_01 maps\_utility::assign_animtree("burkeambush_door");
	var_00 = common_scripts\utility::add_to_array(var_00,var_01);
	level.infiltratorburke maps\_utility::disable_pain();
	var_02 = getent("BurkeAmbushOrg","targetname");
	common_scripts\utility::flag_wait("FlagCourtyardBurkeJumpCompleted");
	common_scripts\utility::flag_set("FlagStruggleBurkeApproaches");
	var_02 maps\_anim::anim_reach_solo(level.infiltratorburke,"burkeambush");
	var_03 = spawnenemystruggle();
	var_03.animname = "attacker";
	var_03.allowdeath = 1;
	level.enemystruggler = var_03;
	var_00 = common_scripts\utility::add_to_array(var_00,var_03);
	setupvalidtargetsbyname("EnemyPatrolStruggle");
	common_scripts\utility::flag_set("FlagStruggleGuardAttacks");
	thread allystruggleslomo(var_03);
	thread allystrugglesuccess(var_03,var_01);
	thread monitorallystrugglefailure(var_02,var_03,level.infiltratorburke);
	level.infiltratorburke.hasbeenhit = 0;
	var_02 thread maps\_anim::anim_single_solo_run(level.infiltratorburke,"burkeambush");
	var_02 maps\_anim::anim_single(var_00,"burkeambush");
	var_03 notify("AttackComplete");
}

//Function Number: 190
burkeambushnohitnotetrack(param_00)
{
	var_01 = getent("BurkeAmbushOrg","targetname");
	var_02 = "burkeambush_nohit";
	if(!isalive(level.enemystruggler))
	{
		level.infiltratorburke maps\_utility::anim_stopanimscripted();
		wait 0.05;
		level.infiltratorburke maps\_utility::set_ignoreall(1);
		var_03 = maps\_utility::get_living_ai("PoolPlayerTarget3","script_noteworthy");
		if(isdefined(var_03))
		{
			level.infiltratorburke maps\_utility::set_favoriteenemy(var_03);
		}

		var_01 maps\_anim::anim_single_solo_run(level.infiltratorburke,var_02);
		level.infiltratorburke maps\_utility::set_ignoreall(0);
		return;
	}

	level.infiltratorburke.hasbeenhit = 1;
}

//Function Number: 191
allystruggleslomo(param_00)
{
	wait(2);
	if(isdefined(param_00))
	{
		level notify("BeginGideonKillWatch");
		param_00 thread objmarkerplayertarget(1);
		setslowmotion(1,0.5,0.5);
		soundscripts\_snd::snd_message("start_burke_ambush_slomo");
		param_00 common_scripts\utility::waittill_any("death","AttackComplete");
		setslowmotion(0.5,1,0.5);
		soundscripts\_snd::snd_message("stop_burke_ambush_slomo");
	}
}

//Function Number: 192
allystrugglesuccess(param_00,param_01)
{
	level endon("alarm_mission_end");
	var_02 = level.infiltratorburke.weapon;
	var_03 = getent("BurkeAmbushOrg","targetname");
	param_00 waittill("death");
	if(isalive(level.infiltratorburke))
	{
		common_scripts\utility::flag_set("FlagStruggleBurkeRecovers");
		if(level.infiltratorburke.hasbeenhit)
		{
			var_03 waittill("burkeambush");
		}
		else
		{
			var_03 waittill("burkeambush_nohit");
		}

		if(level.infiltratorburke.weapon == "none")
		{
			level.infiltratorburke.weapon = var_02;
			level.infiltratorburke maps\_utility::forceuseweapon(level.infiltratorburke.weapon,"primary");
			level.infiltratorburke maps\_utility::enable_pain();
		}
	}
}

//Function Number: 193
monitorallystrugglefailure(param_00,param_01,param_02)
{
	param_01 endon("death");
	level waittill("BeginGideonKillWatch");
	param_02 waittill("damage",var_03,var_04);
	var_05 = 0;
	if(isdefined(var_04) && var_04 == level.player)
	{
		var_05 = 1;
	}

	thread failburkekilled(param_00,param_01,param_02,var_05);
}

//Function Number: 194
failburkekilled(param_00,param_01,param_02,param_03)
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	param_01 notify("AttackComplete");
	thread burkestruggledeath();
	level notify("burke_killed");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - BURKE KILLED!!!");
	confcentertotalcombat(0);
	maps\greece_conf_center_vo::confcenterfailburkekilleddialogue(param_03);
	wait(1);
	if(param_03 == 0)
	{
		setdvar("ui_deadquote",&"GREECE_DRONE_BURKEKILLED_FAIL");
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 195
burkestruggledeath()
{
	var_00 = getent("BurkeAmbushOrg","targetname");
	level.infiltratorburke.no_stopanimscripted = 1;
	var_01 = level.infiltratorburke.origin + (-40,10,32);
	playfx(common_scripts\utility::getfx("blood_impact_splat"),var_01);
	var_00 maps\_anim::anim_single_solo(level.infiltratorburke,"burkeambush_death");
	level.infiltratorburke maps\_utility::stop_magic_bullet_shield();
	level.infiltratorburke maps\greece_code::kill_no_react();
	level.infiltratorburke unmarkandremoveoutline(0);
}

//Function Number: 196
atriumbreachidleinfiltrators(param_00)
{
	var_01 = common_scripts\utility::getstruct("atrium_breach_org","targetname");
	level.mute_charge = maps\_utility::spawn_anim_model("mute_charge");
	level.mute_charge hide();
	level.breach_charge = maps\_utility::spawn_anim_model("breach_charge");
	level.breach_charge hide();
	level.breach_charge.include_in_idle = 1;
	var_02 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_03 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	if(param_00)
	{
		var_04 = getent("AtriumBreachTeleport_Infiltrator1","targetname");
		var_05 = getent("AtriumBreachTeleport_Infiltrator2","targetname");
		var_02 forceteleport(var_04.origin,var_04.angles);
		var_03 forceteleport(var_05.origin,var_05.angles);
	}

	thread atriumbreachidle(var_01,var_02,level.breach_charge,param_00);
	thread atriumbreachidle(var_01,var_03,level.mute_charge,param_00);
}

//Function Number: 197
atriumbreachidleburke(param_00)
{
	var_01 = common_scripts\utility::getstruct("atrium_breach_org","targetname");
	level.breach_charge_2 = maps\_utility::spawn_anim_model("breach_charge");
	level.breach_charge_2.animname = "breach_charge_2";
	level.breach_charge_2.include_in_idle = 1;
	var_02 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	if(param_00)
	{
		var_03 = getent("AtriumBreachTeleport_InfiltratorBurke","targetname");
		var_02 forceteleport(var_03.origin,var_03.angles);
	}

	thread atriumbreachidle(var_01,var_02,level.breach_charge_2,param_00);
}

//Function Number: 198
atriumbreachidle(param_00,param_01,param_02,param_03)
{
	var_04 = "mutebreach_setup";
	var_05 = "mutebreach_idle";
	param_01 clearenemy();
	var_06 = [];
	var_06[0] = param_01;
	var_07 = [];
	var_07[0] = param_01;
	if(isdefined(param_02))
	{
		var_06[1] = param_02;
		if(isdefined(param_02.include_in_idle))
		{
			var_07[1] = param_02;
		}
	}

	if(param_03 == 0)
	{
		param_00 maps\_anim::anim_reach_solo(param_01,var_04);
		param_01.readyforatriumbreach = 1;
		param_00 maps\_anim::anim_single(var_06,var_04);
	}

	param_01.readyforatriumbreach = 1;
	if(!common_scripts\utility::flag("FlagAtriumAlliesPerformBreach"))
	{
		param_00 thread maps\_anim::anim_loop(var_07,var_05,"EndAtriumBreachIdle");
	}
}

//Function Number: 199
atriumbreachmonitoralliesinposition()
{
	var_00 = level.allyinfiltrators;
	var_01 = 0;
	while(!common_scripts\utility::flag("FlagAtriumAlliesReadyToBreach"))
	{
		foreach(var_03 in var_00)
		{
			if(isdefined(var_03.readyforatriumbreach) && var_03.readyforatriumbreach == 1)
			{
				var_01++;
				maps\_hms_utility::printlnscreenandconsole(var_01 + " allies are ready to breach Atrium!");
				var_00 = common_scripts\utility::array_remove(var_00,var_03);
			}
		}

		if(var_01 == 3)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("FlagAtriumAlliesReadyToBreach");
	maps\_hms_utility::printlnscreenandconsole("Allies at AtriumBreach!");
}

//Function Number: 200
atriumbreachexplosionnotetrack(param_00)
{
	maps\greece_conf_center_fx::confcenteratriumflashcharge();
	soundscripts\_snd::snd_message("start_atrium_fight");
	level.breach_charge stopanimscripted();
	level.breach_charge_2 stopanimscripted();
	level.breach_charge delete();
	level.breach_charge_2 delete();
	wait(1);
	common_scripts\utility::flag_set("FlagAtriumEnemiesReactToBreach");
	rumbleatriumbreach();
}

//Function Number: 201
showentnotetrack(param_00)
{
	param_00 show();
}

//Function Number: 202
alliesbreachatrium()
{
	var_00 = common_scripts\utility::getstruct("atrium_breach_org","targetname");
	var_01 = "mutebreach";
	var_02 = getent("atrium_door_bottom","targetname");
	var_03 = getent("atrium_door_bottom_clip","targetname");
	var_02 maps\_utility::assign_animtree("atrium_door");
	var_02.animname = "atrium_door_bottom";
	var_04 = getent("atrium_door_top","targetname");
	var_05 = getent("atrium_door_top_clip","targetname");
	var_04 maps\_utility::assign_animtree("atrium_door");
	var_04.animname = "atrium_door_top";
	var_06 = level.breach_charge;
	var_07 = level.breach_charge_2;
	var_08 = maps\_utility::get_living_ai("Infiltrator1","script_noteworthy");
	var_09 = maps\_utility::get_living_ai("Infiltrator2","script_noteworthy");
	var_0A = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	var_0B = [var_08,var_09,var_0A];
	var_0C = [var_02,var_04,var_06,var_07];
	var_00 notify("EndAtriumBreachIdle");
	wait 0.05;
	var_0D = getdvarfloat("ai_eventDistGunshot");
	var_0E = getdvarfloat("ai_eventDistGunshotTeam");
	setsaveddvar("ai_eventDistGunshot",50);
	setsaveddvar("ai_eventDistGunshotTeam",50);
	var_05 delete();
	var_03 delete();
	var_0F = [];
	var_0F["sight_dist"] = 400;
	var_0F["detect_dist"] = 100;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_0F);
	thread atriumdoorbreachdamage();
	var_00 thread maps\_anim::anim_single(var_0C,var_01);
	var_00 maps\_anim::anim_single_run(var_0B,var_01);
	thread alliesredirect("AtriumFight1");
	foreach(var_11 in level.allyinfiltrators)
	{
		var_11 aienablestealthcombat();
	}

	enablealliescolor();
	maps\_utility::activate_trigger_with_targetname("TrigBurke101");
	maps\_utility::activate_trigger_with_targetname("TrigAllies101");
	common_scripts\utility::flag_wait("FlagAtriumEnemiesAlmostAllDead");
	wait(randomfloatrange(1,3));
	if(!common_scripts\utility::flag("FlagAllAtriumGuardsDead"))
	{
		thread alliesredirect("AtriumFight2");
		maps\_utility::activate_trigger_with_targetname("TrigBurke102");
		maps\_utility::activate_trigger_with_targetname("TrigAllies102");
	}

	common_scripts\utility::flag_wait("FlagEndAtriumSetup");
	setsaveddvar("ai_eventDistGunshot",var_0D);
	setsaveddvar("ai_eventDistGunshotTeam",var_0E);
	disablealliescolor();
	foreach(var_14 in level.allyinfiltrators)
	{
		var_14 aidisablestealthcombat();
		var_14 maps\greece_code::disableawareness();
	}

	var_0F = [];
	var_0F["sight_dist"] = 800;
	var_0F["detect_dist"] = 200;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_0F);
}

//Function Number: 203
atriumdoorbreachdamage()
{
	wait(0.5);
	var_00 = getent("AtriumDoorBreachDamageVol","targetname");
	var_01 = var_00 maps\_utility::get_ai_touching_volume("axis");
	var_01 = maps\_utility::array_removedead_or_dying(var_01);
	foreach(var_03 in var_01)
	{
		var_03 kill();
	}
}

//Function Number: 204
atriumdoorsopenonalarm()
{
	level waittill("alarm_mission_end");
	while(!common_scripts\utility::flag("FlagEndStruggleSetup"))
	{
		if(common_scripts\utility::flag("FlagAlarmMissionEnd"))
		{
			atriumdoorsopen();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 205
atriumdoorsopen()
{
	var_00 = maps\_utility::get_living_ai_array("EnemyPatrolAtrium_AI","targetname");
	var_01 = getent("atrium_door_top","targetname");
	var_02 = getent("atrium_door_top_clip","targetname");
	var_03 = getent("atrium_door_top_org","targetname");
	var_02 delete();
	var_01 linkto(var_03);
	var_03 rotateto(var_03.angles + (0,120,0),0.35,0,0.35);
	var_04 = maps\_utility::get_closest_index(var_01.origin,var_00);
	if(isdefined(var_00[var_04]))
	{
		var_05 = var_00[var_04];
		var_00 = common_scripts\utility::array_remove(var_00,var_05);
		var_06 = getent("WalkwayTopVol","targetname");
		var_05 setgoalvolumeauto(var_06);
	}

	var_07 = getent("atrium_door_bottom","targetname");
	var_08 = getent("atrium_door_bottom_clip","targetname");
	var_09 = getent("atrium_door_bottom_org","targetname");
	var_08 delete();
	var_07 linkto(var_09);
	var_09 rotateto(var_09.angles + (0,120,0),0.35,0,0.35);
	var_0A = getent("WalkwayBottomVol","targetname");
	var_0B = common_scripts\utility::get_array_of_closest(var_07.origin,var_00);
	if(isdefined(var_0B[0]))
	{
		var_0B[0] setgoalvolumeauto(var_0A);
	}

	if(isdefined(var_0B[1]))
	{
		var_0B[1] setgoalvolumeauto(var_0A);
	}
}

//Function Number: 206
alliesparkingdefend()
{
	level endon("AlliesWillAllDie");
	foreach(var_01 in level.allyinfiltrators)
	{
		var_01 thread aienabletotalcombat(0);
	}

	enablealliescolor();
	maps\_utility::activate_trigger_with_targetname("TrigBurke103");
	maps\_utility::activate_trigger_with_targetname("TrigAllies103");
	common_scripts\utility::flag_wait("FlagSomeAmbushSouthGuardsDead");
	thread alliesredirect("ParkingDefend1");
	maps\_utility::activate_trigger_with_targetname("TrigBurke105");
	maps\_utility::activate_trigger_with_targetname("TrigAllies105");
	common_scripts\utility::flag_wait_all("FlagAllAmbushGuardsDead","FlagEnemyVehicleTurretDisabled");
	thread alliesredirect("ParkingDefend2");
	maps\_utility::activate_trigger_with_targetname("TrigBurke106");
	maps\_utility::activate_trigger_with_targetname("TrigAllies106");
	common_scripts\utility::flag_set("FlagSpawnEnemyReinforcements");
	common_scripts\utility::flag_wait("FlagBeginConfCenterOutro");
	wait(0.5);
	thread parkingburkejumpdown();
	wait(0.5);
	thread allyredirectnoteworthy("Infiltrator2","ParkingEnd");
	maps\_utility::activate_trigger_with_targetname("TrigAllies107");
}

//Function Number: 207
parkingburkejumpdown()
{
	var_00 = common_scripts\utility::getstruct("BurkeParkingBoostJumpOrg","targetname");
	var_01 = "parking_boostjump";
	level.infiltratorburke maps\_utility::set_ignoreall(1);
	wait 0.05;
	var_00 maps\_anim::anim_reach_solo(level.infiltratorburke,var_01);
	var_00 maps\_anim::anim_single_solo_run(level.infiltratorburke,var_01);
	level.infiltratorburke maps\_utility::set_ignoreall(0);
	thread allyredirectnoteworthy("InfiltratorBurke","ParkingEnd");
	maps\_utility::activate_trigger_with_targetname("TrigBurke107");
}

//Function Number: 208
monitorzoomonburke()
{
	common_scripts\utility::flag_wait("FlagBeginZoomOnBurke");
	waittillplayerlookattarget(level.infiltratorburke);
	common_scripts\utility::flag_set("FlagEndZoomOnBurke");
}

//Function Number: 209
monitorzoomonhades1()
{
	level.confhades hudoutlineenable(5,0);
	level.player allowads(1);
	thread maps\_utility::hintdisplayhandler("drone_zoom");
	waittillplayerlookattarget(level.confhades,5,1);
	common_scripts\utility::flag_set("FlagPlayerZoomOnHades1");
	wait(3);
	common_scripts\utility::flag_set("FlagContinueDroneFlyin");
	level.confhades hudoutlinedisable();
	thread autosavesniperdronestealth("conf_center_hades_zoom_1");
}

//Function Number: 210
hintdronezoomoff()
{
	return level.player adsbuttonpressed(1);
}

//Function Number: 211
hintlookattruckoff()
{
	if(common_scripts\utility::flag("FlagOkayToShootDrone") || common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 212
monitorzoomonhades2()
{
	waittillplayerlookattargetintrigger(level.confhades,"TriggerConfRoomPlayer",15,1);
	thread autosavesniperdronestealth("conf_center_hades_zoom_2");
	common_scripts\utility::flag_set("FlagPlayerZoomOnHades2");
}

//Function Number: 213
waittillplayerlookattarget(param_00,param_01,param_02)
{
	param_00 endon("death");
	level endon("alarm_mission_end");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	param_00 thread monitorplayerlookat(param_01,param_02);
	param_00 waittill("PlayerLookAt");
	if(isdefined(param_00.name))
	{
		maps\_hms_utility::printlnscreenandconsole("Player has successfully looked at target" + param_00.name);
		return;
	}

	maps\_hms_utility::printlnscreenandconsole("Player has successfully looked at target");
}

//Function Number: 214
drawplayerlookatdebug(param_00,param_01,param_02,param_03)
{
	var_04 = level.player getgunangles();
	param_01 = level.player getplayerangles();
	var_05 = anglestoforward(param_01 + (0,param_03,0));
	var_06 = anglestoforward(param_01 + (0,param_03 * -1,0));
	var_07 = anglestoforward(param_01 + (param_03,0,0));
	var_08 = anglestoforward(param_01 + (param_03 * -1,0,0));
	thread maps\_utility::draw_circle_for_time(param_02,50,1,0,0,0.05);
}

//Function Number: 215
monitorplayerlookat(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = undefined;
	var_03 = cos(param_00);
	for(;;)
	{
		wait(0.05);
		if(issentient(self))
		{
			var_02 = self geteye();
		}
		else
		{
			var_02 = self.origin;
		}

		if(level.showdebugtoggle == 1)
		{
			drawplayerlookatdebug(level.player geteye(),level.player getgunangles(),var_02,param_00);
		}

		if(param_01 == 1 && !level.player adsbuttonpressed())
		{
			continue;
		}

		if(common_scripts\utility::within_fov(level.player geteye(),level.player getgunangles(),var_02,var_03) == 1)
		{
			self notify("PlayerLookAt");
			return;
		}
	}
}

//Function Number: 216
waittillplayerlookattargetintrigger(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 30;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = getent(param_01,"targetname");
	thread waittillplayerlookattarget(param_00,param_02,param_03);
	var_06 = spawnstruct();
	var_06.threads = 0;
	param_00 childthread common_scripts\utility::waittill_string("PlayerLookAt",var_06);
	var_06.threads++;
	var_05 childthread common_scripts\utility::waittill_string("trigger",var_06);
	var_06.threads++;
	while(var_06.threads)
	{
		if(isdefined(param_04))
		{
			var_06 common_scripts\utility::waittill_notify_or_timeout("returned",param_04);
			continue;
		}

		var_06 waittill("returned");
		var_06.threads--;
	}
}

//Function Number: 217
waittillplayerlookatescapevehicle()
{
	var_00 = getent("TriggerEscapeVehiclePlayer","targetname");
	var_01 = getent("HadesEscapeVehicle","targetname");
	thread waittillplayerlookattarget(var_01,15,1);
	var_02 = spawnstruct();
	var_02.threads = 0;
	var_01 childthread common_scripts\utility::waittill_string("PlayerLookAt",var_02);
	var_02.threads++;
	var_00 childthread common_scripts\utility::waittill_string("trigger",var_02);
	var_02.threads++;
	while(var_02.threads)
	{
		var_02 waittill("returned");
		var_02.threads--;
	}
}

//Function Number: 218
initconfcenterstealthsettings()
{
	var_00 = [];
	var_00["ai_eventDistNewEnemy"] = [];
	var_00["ai_eventDistNewEnemy"]["spotted"] = 256;
	var_00["ai_eventDistNewEnemy"]["hidden"] = 128;
	var_00["ai_eventDistExplosion"] = [];
	var_00["ai_eventDistExplosion"]["spotted"] = 512;
	var_00["ai_eventDistExplosion"]["hidden"] = 512;
	var_00["ai_eventDistDeath"] = [];
	var_00["ai_eventDistDeath"]["spotted"] = 512;
	var_00["ai_eventDistDeath"]["hidden"] = 512;
	var_00["ai_eventDistPain"] = [];
	var_00["ai_eventDistPain"]["spotted"] = 256;
	var_00["ai_eventDistPain"]["hidden"] = 256;
	var_00["ai_eventDistBullet"] = [];
	var_00["ai_eventDistBullet"]["spotted"] = 96;
	var_00["ai_eventDistBullet"]["hidden"] = 96;
	var_00["ai_eventDistFootstep"] = [];
	var_00["ai_eventDistFootstep"]["spotted"] = 256;
	var_00["ai_eventDistFootstep"]["hidden"] = 256;
	var_00["ai_eventDistFootstepWalk"] = [];
	var_00["ai_eventDistFootstepWalk"]["spotted"] = 128;
	var_00["ai_eventDistFootstepWalk"]["hidden"] = 128;
	var_00["ai_eventDistFootstepSprint"] = [];
	var_00["ai_eventDistFootstepSprint"]["spotted"] = 512;
	var_00["ai_eventDistFootstepSprint"]["hidden"] = 512;
	maps\_stealth_utility::stealth_ai_event_dist_custom(var_00);
	var_01 = [];
	var_01["sight_dist"] = 800;
	var_01["detect_dist"] = 200;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_01);
}

//Function Number: 219
initalerttime()
{
	var_00 = [];
	var_00[0] = 4.5;
	var_00[1] = 3;
	var_00[2] = 2;
	var_00[3] = 1;
	level.alerttimedelay = var_00[level.gameskill];
}

//Function Number: 220
monitoratriumfighttimer()
{
	level endon("AtriumTimerFreeze");
	level endon("alarm_mission_end");
	var_00 = [];
	var_00[0] = 40;
	var_00[1] = 30;
	var_00[2] = 20;
	var_00[3] = 15;
	level.atriumtimewindow = var_00[level.gameskill];
	var_01 = [];
	var_01[0] = 15;
	var_01[1] = 10;
	var_01[2] = 5;
	var_01[3] = 0;
	var_02 = var_01[level.gameskill];
	wait(3);
	level.atriumtimer = maps\_hud_util::get_countdown_hud();
	level.atriumtimer.label = &"GREECE_ATRIUM_TIMER_LABEL";
	level.atriumtimer.x = -110;
	level.atriumtimer.y = 45;
	level.atriumtimer.alignx = "left";
	level.atriumtimer.horzalign = "center";
	level.atriumtimer.color = (0.95,0.95,1);
	level.atriumtimer settenthstimerstatic(level.atriumtimewindow);
	level.atriumtimer setpulsefx(30,900000,700);
	common_scripts\utility::flag_wait("FlagAtriumEnemiesAllMarked");
	level.atriumtimer settenthstimer(level.atriumtimewindow);
	thread freezeatriumfighttimer();
	thread markatriumenemiesatwarning(var_02);
	wait(level.atriumtimewindow);
	level notify("AtriumTimerExpire");
	destroyatriumfighttimer();
	maps\_hms_utility::printlnscreenandconsole("TIMER EXPIRED!!!");
	soundscripts\_snd::snd_message("atrium_timer_expire");
	thread failatriumfighttimerexpire();
}

//Function Number: 221
markatriumenemiesatwarning(param_00)
{
	level endon("AtriumTimerFreeze");
	if(param_00 > 0)
	{
		var_01 = level.atriumtimewindow - param_00;
		wait(var_01);
		thread setupplayertargets("AtriumPlayerTarget",1,1);
		var_02 = maps\_utility::get_living_ai_array("EnemyPatrolAtrium_AI","targetname");
		level waittill("AtriumTimerExpire");
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		foreach(var_04 in var_02)
		{
			var_04 setthreatdetection("enhanceable");
		}
	}
}

//Function Number: 222
failatriumfighttimerexpire()
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - TIMER EXPIRED!!!");
	confcentertotalcombat(0);
	maps\greece_conf_center_vo::confcenterfailtimerexpiredialogue();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_TIMEREXPIRE_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 223
freezeatriumfighttimer()
{
	level endon("AtriumTimerExpire");
	var_00 = gettime();
	level waittill("AtriumTimerFreeze");
	var_01 = gettime();
	var_02 = var_01 - var_00 * 0.001;
	var_03 = level.atriumtimewindow - var_02;
	level.atriumtimer settenthstimerstatic(var_03);
	wait(5);
	destroyatriumfighttimer();
}

//Function Number: 224
destroyatriumfighttimer()
{
	if(isdefined(level.atriumtimer))
	{
		level.atriumtimer destroy();
	}
}

//Function Number: 225
monitorparkingcars()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("ConfRoomExplosion");
	if(level.currentgen)
	{
		if(!istransientloaded("greece_confcenter_tr"))
		{
			level waittill("tff_post_intro_to_confcenter");
		}

		var_00 = level.sniper_marked_cars;
	}
	else
	{
		var_00 = getentarray("ParkingAlarmCar","targetname");
	}

	foreach(var_02 in var_00)
	{
		var_02 thread monitorparkingcaralarm();
		var_02 thread monitorparkingcarexplode();
	}

	common_scripts\utility::flag_wait("FlagParkingCarAlarmActivated");
	maps\_hms_utility::printlnscreenandconsole("Parking car alarm is on!");
	if(common_scripts\utility::flag("FlagBeginParkingSetup") || common_scripts\utility::flag("FlagAllRooftopGuardsDead"))
	{
		thread alliesparkingkill();
		return;
	}

	var_04 = level.start_point;
	if(var_04 != "start_conf_center_combat" && var_04 != "start_conf_center_outro")
	{
		thread failinvalidtarget();
	}
}

//Function Number: 226
markparkingcars()
{
	var_00 = getentarray("ParkingAlarmCar","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread objmarkervehicle("FlagUnMarkParkingCars",0,0);
	}
}

//Function Number: 227
monitorparkingcarexplode()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("parking_car_explode");
	level endon("ConfRoomExplosion");
	var_00 = level.start_point;
	if(var_00 != "start_conf_center_combat" && var_00 != "start_conf_center_outro")
	{
		self waittill("death");
		thread failinvalidtarget();
		level notify("parking_car_explode");
	}
}

//Function Number: 228
monitorparkingcaralarm()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("parking_alarm_activated");
	level endon("parking_guard_shot");
	var_00 = level.start_point;
	if(var_00 != "start_conf_center_kill" && var_00 != "start_conf_center_combat" && var_00 != "start_conf_center_outro")
	{
		self waittill("damage");
		soundscripts\_snd::snd_message("start_car_alarm",self);
		level.parkingalarmcar = self;
		level.parkingalarmcar.balarmon = 1;
		common_scripts\utility::flag_set("FlagParkingCarAlarmActivated");
		common_scripts\utility::flag_set("FlagParkingCarAlarmDisableAutosave");
		common_scripts\utility::flag_set("disable_autosaves");
		common_scripts\utility::flag_set("FlagUnMarkParkingCars");
		level notify("disableParkingCorpseDetection");
		level notify("parking_alarm_activated");
		thread _caralarmfx();
	}
}

//Function Number: 229
_caralarmfx()
{
	self endon("death");
	level endon("parking_alarm_deactivated");
	var_00 = self.classname;
	for(var_01 = 0;var_01 < 15;var_01++)
	{
		if(!isdefined(level.vehicle_lights_group[var_00]))
		{
			continue;
		}

		foreach(var_04, var_03 in level.vehicle_lights_group[var_00])
		{
			if(var_04 == "all" || var_04 == "frontlights")
			{
				continue;
			}

			thread maps\_vehicle::vehicle_lights_on(var_04);
		}

		wait(1);
		foreach(var_04, var_03 in level.vehicle_lights_group[var_00])
		{
			if(var_04 == "all" || var_04 == "frontlights")
			{
				continue;
			}

			thread maps\_vehicle::vehicle_lights_off(var_04);
		}

		wait(1);
	}

	_caralarmstop();
}

//Function Number: 230
_caralarmstop()
{
	if(isdefined(level.parkingalarmcar) && level.parkingalarmcar.balarmon == 1)
	{
		level.parkingalarmcar soundscripts\_snd::snd_message("stop_car_alarm");
		level notify("parking_alarm_deactivated");
		level.parkingalarmcar.balarmon = 0;
	}

	common_scripts\utility::flag_clear("FlagParkingCarAlarmDisableAutosave");
	common_scripts\utility::flag_clear("disable_autosaves");
}

//Function Number: 231
enemiesignoreplayerdrone(param_00)
{
	if(param_00 == 1)
	{
		createthreatbiasgroup("player_drone");
		self setthreatbiasgroup("player_drone");
		setignoremegroup("player_drone","axis");
		return;
	}

	self setthreatbiasgroup();
}

//Function Number: 232
monitorlevelalarm()
{
	level endon("end_sniper_drone");
	maps\_hms_utility::printlnscreenandconsole("Now monitoring level alarm...");
	common_scripts\utility::flag_wait("FlagAlarmMissionEnd");
	thread faillevelalarm();
}

//Function Number: 233
faillevelalarm()
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	soundscripts\_snd::snd_message("cc_kva_alerted_walla");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - ALARM SOUNDED!!!");
	confcentertotalcombat(0);
	maps\greece_conf_center_vo::confcenterfailalarmsoundeddialogue();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 234
setupvalidtargetsbyname(param_00)
{
	var_01 = param_00 + "_AI";
	var_02 = maps\_utility::get_living_ai_array(var_01,"targetname");
	setupvalidtargetsbyarray(var_02);
	maps\_hms_utility::printlnscreenandconsole(param_00 + " enemies have been designated as valid targets");
}

//Function Number: 235
setupvalidtargetsbyarray(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 notify("valid_target");
	}
}

//Function Number: 236
monitorisenemyvalidtarget()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	self endon("valid_target");
	self waittill("death");
	thread failinvalidtarget();
}

//Function Number: 237
failinvalidtarget()
{
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - PLAYER KILLED INVALID TARGET!!!");
	maps\greece_conf_center_vo::confcenterfailinvalidtargetdialogue();
	confcentertotalcombat(0);
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_INVALIDTARGET_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 238
confcentertotalcombat(param_00)
{
	maps\_hms_utility::printlnscreenandconsole("TOTAL COMBAT!!!");
	level.allyinfiltrators = maps\_utility::array_removedead(level.allyinfiltrators);
	level.allenemypatrollers = maps\_utility::array_removedead(level.allenemypatrollers);
	common_scripts\utility::flag_set("disable_autosaves");
	common_scripts\utility::flag_set("FlagDisableAutosave");
	thread releasemeetingcivilians();
	level.player enemiesignoreplayerdrone(0);
	var_01 = maps\_utility::array_merge(level.allyinfiltrators,level.allenemypatrollers);
	foreach(var_03 in var_01)
	{
		var_03 thread aienabletotalcombat(param_00);
	}
}

//Function Number: 239
releasemeetingcivilians()
{
	var_00 = common_scripts\utility::getstruct("CC_Breach","targetname");
	var_01 = "cc_breach";
	if(!common_scripts\utility::flag("FlagOkayToKillHades"))
	{
		maps\_hms_utility::printlnscreenandconsole("MEETING CIVILIANS FREAK OUT!!!");
		var_00 notify("stopPacingIdles");
		var_00 notify("speech");
		var_00 notify("Breach");
		var_02 = maps\_utility::get_living_ai_array("ConfRoomVip_AI","targetname");
		foreach(var_04 in var_02)
		{
			var_04 maps\_utility::anim_stopanimscripted();
		}

		wait(0.05);
		var_00 thread maps\_anim::anim_single(var_02,var_01);
	}
}

//Function Number: 240
autosavesniperdronestealth(param_00)
{
	var_01 = undefined;
	if(isdefined(level.curautosave))
	{
		var_01 = level.curautosave;
	}

	wait 0.05;
	thread maps\_utility::autosave_by_name(param_00);
	wait(5);
	if(isdefined(var_01))
	{
		if(var_01 != level.curautosave)
		{
			maps\_hms_utility::printlnscreenandconsole("*** Sniperdrone stealth autosave " + param_00 + " SUCCESS! ***");
			return;
		}

		maps\_hms_utility::printlnscreenandconsole("*** Sniperdrone stealth autosave " + param_00 + " FAILED! ***");
	}
}

//Function Number: 241
autosaveconfcenterstealthcheck()
{
	if(isdefined(level.alertedenemies))
	{
		level.alertedenemies = maps\_utility::array_removedead_or_dying(level.alertedenemies);
		if(!common_scripts\utility::flag("FlagAlarmMissionEnd") && level.alertedenemies.size == 0)
		{
			common_scripts\utility::flag_clear("FlagDisableAutosave");
		}

		common_scripts\utility::flag_clear("disable_autosaves");
		if(level.alertedenemies.size > 0)
		{
			maps\_hms_utility::printlnscreenandconsole("Tried to autosave but there are " + level.alertedenemies.size + " enemies alerted!!!");
			foreach(var_01 in level.alertedenemies)
			{
				if(isdefined(var_01.script_noteworthy))
				{
					maps\_hms_utility::printlnscreenandconsole("This guy is alerted... " + var_01.script_noteworthy);
					continue;
				}

				maps\_hms_utility::printlnscreenandconsole("A nameless guy is alerted... ");
			}

			return 0;
		}
	}

	if(common_scripts\utility::flag("FlagConfHadesDead") && !common_scripts\utility::flag("FlagOkayToKillHades"))
	{
		maps\_hms_utility::printlnscreenandconsole("Tried to autosave but player killed Hades too early");
		return 0;
	}

	if(common_scripts\utility::flag("FlagPlayerShotConfRoomWindows") && !common_scripts\utility::flag("FlagOkayToKillHades"))
	{
		maps\_hms_utility::printlnscreenandconsole("Tried to autosave but FlagPlayerShotConfRoomWindows is set to TRUE!!!");
		return 0;
	}

	if(common_scripts\utility::flag("FlagDisableAutosave"))
	{
		maps\_hms_utility::printlnscreenandconsole("Tried to autosave but FlagDisableAutosave is set to TRUE!!!");
		return 0;
	}

	if(common_scripts\utility::flag("FlagParkingCarAlarmDisableAutosave"))
	{
		maps\_hms_utility::printlnscreenandconsole("Tried to autosave but FlagParkingCarAlarmDisableAutosave is set to TRUE!!!");
		return 0;
	}

	if(common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		maps\_hms_utility::printlnscreenandconsole("Tried to autosave but FlagAlarmMissionEnd is set to TRUE!!!");
		return 0;
	}

	return 1;
}

//Function Number: 242
autosaveconfcentercombatcheck()
{
	if(common_scripts\utility::flag("FlagConfCenterAlliesVulnerable"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 243
monitorconfroomwindows()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	var_00 = getent("ConfRoomWindows","targetname");
	for(;;)
	{
		var_01 = var_00 common_scripts\utility::waittill_any_return("damage","bullethit");
		common_scripts\utility::flag_set("FlagPlayerShotConfRoomWindows");
		wait 0.05;
		if(!common_scripts\utility::flag("FlagConfHadesDead"))
		{
			common_scripts\utility::flag_set("FlagAlarmMissionEnd");
			destroyatriumfighttimer();
			level notify("alarm_mission_end");
		}

		wait 0.05;
	}
}

//Function Number: 244
confcentervehiclesvulnerable()
{
	var_00 = getentarray("ParkingAlarmCar","targetname");
	var_01 = getentarray("ConfCenterCombatCar","targetname");
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.script_mp_style_helicopter))
		{
			var_03.script_mp_style_helicopter = 0;
			var_03 maps\_vehicle::vehicle_set_health(900);
			var_03 thread vehicleexplodeondeath();
		}
	}
}

//Function Number: 245
vehicleexplodeondeath()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	self waittill("death");
	radiusdamage(self.origin,400,400,10);
	physicsexplosionsphere(self.origin,300,100,1.5);
}

//Function Number: 246
monitorplayeractivity()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("HadesVehicleDriveStart");
	wait(5);
	resetvulnerabletimers();
	var_00 = 0;
	for(;;)
	{
		wait 0.05;
		var_01 = maps\_utility::array_removedead_or_dying(level.allenemyambushers);
		var_02 = gettime();
		if(var_01.size < 3)
		{
			resetvulnerabletimers();
			continue;
		}

		if(var_00 == 0 && level.allieswarningtime <= var_02)
		{
			if(!common_scripts\utility::flag("FlagSomeAmbushSouthGuardsDead"))
			{
				maps\_hms_utility::printlnscreenandconsole("*** WARNING *** - Player has been idle for too long");
				thread maps\_utility::display_hint_timeout_mintime("support_allies",5,3);
			}

			var_00 = 1;
		}

		if(level.alliesvulnerabletime <= var_02)
		{
			common_scripts\utility::flag_set("FlagConfCenterAlliesVulnerable");
			foreach(var_04 in level.allyinfiltrators)
			{
				if(isdefined(var_04.magic_bullet_shield) && var_04.magic_bullet_shield == 1)
				{
					var_04 thread maps\_utility::stop_magic_bullet_shield();
				}

				var_05 = level.player maps\_utility::get_player_gameskill();
				if(var_05 >= 3)
				{
					var_04.health = 1;
				}

				var_04 thread monitorallydeath();
			}

			maps\_hms_utility::printlnscreenandconsole("*** ALLIES ARE NOW VULNERABLE ***");
			break;
		}
	}
}

//Function Number: 247
getallyassisttime()
{
	var_00 = level.player maps\_utility::get_player_gameskill();
	var_01[0] = 30;
	var_01[1] = 20;
	var_01[2] = 15;
	var_01[3] = 10;
	return var_01[var_00];
}

//Function Number: 248
resetvulnerabletimers()
{
	var_00 = getallyassisttime();
	maps\_hms_utility::printlnscreenandconsole("Ally assist time = " + var_00);
	var_01 = gettime();
	level.alliesvulnerabletime = var_01 + var_00 * 1000;
	var_02 = var_00 * 0.5;
	maps\_hms_utility::printlnscreenandconsole("Ally warning time = " + var_02);
	level.allieswarningtime = var_01 + var_02 * 1000;
}

//Function Number: 249
notifyonplayerkill()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("HadesVehicleDriveStart");
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_02) && var_02 == "hms_sniperdrone")
	{
		resetvulnerabletimers();
		return;
	}

	if(isdefined(var_01) && var_01 == "MOD_EXPLOSIVE")
	{
		resetvulnerabletimers();
	}
}

//Function Number: 250
monitorallydeath()
{
	level endon("end_sniper_drone");
	level endon("alarm_mission_end");
	level endon("HadesVehicleDriveStart");
	self waittill("death");
	maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " has DIED!!!");
	thread killallallies();
	if(self.script_noteworthy == "InfiltratorBurke")
	{
		thread failallydeath();
	}
}

//Function Number: 251
killallallies()
{
	level notify("AlliesWillAllDie");
	wait(randomfloatrange(1,3));
	var_00 = maps\_utility::array_removedead_or_dying(level.allyinfiltrators);
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "InfiltratorBurke")
		{
			thread failallydeath();
		}

		var_02 kill();
	}
}

//Function Number: 252
failallydeath()
{
	common_scripts\utility::flag_set("FlagDisableAutosave");
	level notify("alarm_mission_end");
	wait(0.05);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - PLAYER DID NOT PROTECT ALLIES!!!");
	maps\greece_conf_center_vo::confcenterfailburkekilleddialogue(0);
	wait(1);
	setdvar("ui_deadquote",&"GREECE_DRONE_BURKEKILLED_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 253
hintsupportalliesoff()
{
	return common_scripts\utility::flag("FlagHadesVehicleDriveStart");
}

//Function Number: 254
markallies(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00 == 1)
	{
		level waittill("outline_allies");
	}

	level.bmarkallies = 1;
	foreach(var_02 in level.allyinfiltrators)
	{
		var_02 thread markdronetargetally();
		var_02 hudoutlineenable(2);
	}
}

//Function Number: 255
unmarkallies()
{
	level.bmarkallies = 0;
	foreach(var_01 in level.allyinfiltrators)
	{
		var_01 unmarkandremoveoutline(0);
	}
}

//Function Number: 256
markdronetargetally()
{
	self endon("death");
	self endon("dying");
	thread unmarkdronetarget();
	while(!common_scripts\utility::flag("FlagSniperDroneHit"))
	{
		if(level.bmarkallies == 1)
		{
			maps\greece_code::settargetandshader(self,"hud_icon_remoteturret","ac130_hud_friendly_ai_offscreen");
		}

		wait(0.1);
	}
}

//Function Number: 257
markalliesenemytarget()
{
}

//Function Number: 258
markallytargets(param_00)
{
	var_01 = [];
	var_02 = [];
	var_02 = getaiarray("axis");
	var_03 = param_00 + "AllyTarget";
	foreach(var_05 in var_02)
	{
		if(isalive(var_05) && isdefined(var_05.script_noteworthy))
		{
			if(common_scripts\utility::string_starts_with(var_05.script_noteworthy,var_03))
			{
				var_01 = common_scripts\utility::add_to_array(var_01,var_05);
			}
		}
	}

	foreach(var_08 in var_01)
	{
		if(isalive(var_08))
		{
			var_08 thread markalliesenemytarget();
		}
	}
}

//Function Number: 259
markdronetargetenemy()
{
	maps\greece_code::settargetandshader(self,"hud_icon_remoteturret","veh_hud_target_offscreen");
	thread unmarkdronetarget();
}

//Function Number: 260
markdronetargetvehicle()
{
	maps\greece_code::settargetandshader(self,"hud_icon_remoteturret","veh_hud_missile_offscreen");
	thread unmarkdronetarget();
}

//Function Number: 261
unmarkdronetarget()
{
	self endon("death");
	self endon("dying");
	common_scripts\utility::flag_wait("FlagSniperDroneHit");
	if(target_istarget(self))
	{
		target_remove(self);
	}
}

//Function Number: 262
unmarkandremoveoutline(param_00)
{
	if(isdefined(self))
	{
		if(isdefined(param_00))
		{
			wait(param_00);
		}

		self hudoutlinedisable();
		if(target_istarget(self))
		{
			target_remove(self);
		}
	}
}

//Function Number: 263
rumbleatriumbreach()
{
	level.player playrumbleonentity("damage_light");
	earthquake(0.1,0.2,level.player.origin,100);
}

//Function Number: 264
rumblesniperdronenearexplosion()
{
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,1.5,level.player.origin,100);
}

//Function Number: 265
rumbleplayerdistantexplosion()
{
	level.player playrumbleonentity("subtle_tank_rumble");
	earthquake(0.2,0.5,level.player.origin,100);
}

//Function Number: 266
setupgaragedoor()
{
	var_00 = common_scripts\utility::getstruct("HadesGarageDoor","targetname");
	var_01 = maps\_utility::spawn_anim_model("rolling_door",(0,0,0));
	var_00 maps\_anim::anim_first_frame_solo(var_01,"intro_weapon_cache_rollingdoor");
	common_scripts\utility::flag_wait("FlagHadesVehicleDriveStart");
	var_00 maps\_anim::anim_single_solo(var_01,"intro_weapon_cache_rollingdoor");
}

//Function Number: 267
guytruckbloodnotetrack(param_00)
{
	common_scripts\utility::flag_set("FlagShowTruckBlood");
}

//Function Number: 268
truckblood()
{
	var_00 = getent("TruckBlood","targetname");
	var_00 hide();
	common_scripts\utility::flag_wait("FlagShowTruckBlood");
	var_00 show();
	common_scripts\utility::flag_wait("FlagPlayerEndDroneControl");
	var_00 delete();
}

//Function Number: 269
getclosestflat(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	if(!isdefined(param_03))
	{
		param_03 = 200;
	}

	var_04 = undefined;
	foreach(var_06 in param_01)
	{
		var_07 = param_00[2] - var_06.origin[2];
		if(var_07 >= param_03 * -1 && var_07 <= param_03)
		{
			var_08 = distance(var_06.origin,param_00);
			if(var_08 <= param_02)
			{
				var_04 = var_06;
				param_02 = var_08;
			}
		}
	}

	if(isdefined(var_04))
	{
		return var_04;
	}

	var_0A = sortbydistance(param_01,param_00);
	return param_01[0];
}

//Function Number: 270
get_closest_ai_flat(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_01))
	{
		var_05 = getaiarray(param_01);
	}
	else
	{
		var_05 = getaiarray();
	}

	if(var_05.size == 0)
	{
		return undefined;
	}

	if(isdefined(param_02))
	{
		var_05 = common_scripts\utility::array_remove_array(var_05,param_02);
	}

	return getclosestflat(param_00,var_05,param_03,param_04);
}

//Function Number: 271
disableenemyalert()
{
	self notify("disableAlert");
	self.disable_alert = 1;
	if(maps\_utility::is_in_array(level.alertedenemies,self))
	{
		level.alertedenemies common_scripts\utility::array_remove(level.alertedenemies,self);
	}
}

//Function Number: 272
monitorplayersignalatriumbreach()
{
	thread maps\_utility::hintdisplayhandler("mute_breach");
	thread waittillplayersignalatriumbreach();
}

//Function Number: 273
hintmutebreachoff()
{
	if(common_scripts\utility::flag("FlagPlayerSignalAtriumBreach") || common_scripts\utility::flag("FlagPlayerShootFirstAtrium") || common_scripts\utility::flag("FlagAlarmMissionEnd") || common_scripts\utility::flag("FlagParkingCarAlarmActivated"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 274
waittillplayersignalatriumbreach()
{
	level endon("SniperdroneAtriumPlayerFirstShot");
	level endon("alarm_mission_end");
	for(;;)
	{
		if(level.player usebuttonpressed())
		{
			soundscripts\_snd::snd_message("atrium_breach_signal_start");
			common_scripts\utility::flag_set("FlagPlayerSignalAtriumBreach");
			break;
		}

		wait 0.05;
	}
}

//Function Number: 275
burkecourtyardboostjump()
{
	var_00 = common_scripts\utility::getstruct("BurkeCourtyardBoostJumpOrg","targetname");
	var_01 = "courtyard_boostjump";
	var_02 = maps\_utility::get_living_ai("InfiltratorBurke","script_noteworthy");
	var_00 maps\_anim::anim_reach_solo(var_02,var_01);
	var_00 maps\_anim::anim_single_solo_run(var_02,var_01);
	common_scripts\utility::flag_set("FlagCourtyardBurkeJumpCompleted");
	if(!common_scripts\utility::flag("FlagStruggleBurkeApproaches"))
	{
		thread allyredirectnoteworthy("InfiltratorBurke","Walkway");
	}
}

//Function Number: 276
tff_spawn_vehicles_conf_center()
{
	if(!istransientloaded("greece_confcenter_tr"))
	{
		level waittill("tff_post_intro_to_confcenter");
	}

	var_00 = getentarray("ParkingAlarmCar","targetname");
	var_01 = getentarray("ConfCenterCombatCar","targetname");
	level.sniper_marked_cars = [];
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_vehicle();
		level.sniper_marked_cars[level.sniper_marked_cars.size] = var_04;
		var_04 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
	}

	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_utility::spawn_vehicle();
		var_04 thread maps\greece_code::tff_cleanup_vehicle("confcenter");
	}

	common_scripts\utility::flag_wait("FlagUnMarkParkingCars");
	foreach(var_04 in level.sniper_marked_cars)
	{
		var_04 hudoutlinedisable();
	}
}

//Function Number: 277
hinthadeszoomoff()
{
	if(common_scripts\utility::flag("FlagPlayerZoomOnHades2") || common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 278
hintcaralarmoff()
{
	if(common_scripts\utility::flag("FlagUnMarkParkingCars") || common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 279
hintatriumviewoff()
{
	if(common_scripts\utility::flag("FlagUnMarkAtrium") || common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 280
hintcourtyardoverwatchoff()
{
	if(common_scripts\utility::flag("FlagCourtyardAnyOverwatchDead") || common_scripts\utility::flag("FlagAlarmMissionEnd"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 281
monitorsniperdronetriplekill()
{
	level endon("alarm_mission_end");
	level endon("end_sniper_drone");
	common_scripts\utility::waittill_any("death","scripted_death");
	level.triplekillcount++;
	if(level.triplekillcount == 1)
	{
		thread achievementsniperdronetriplekill();
	}
}

//Function Number: 282
achievementsniperdronetriplekill()
{
	level endon("alarm_mission_end");
	level endon("end_sniper_drone");
	wait(0.2);
	if(level.triplekillcount >= 3)
	{
		common_scripts\utility::flag_set("FlagGreeceTripleKillAchievement");
		maps\_utility::giveachievement_wrapper("LEVEL_6A");
	}

	level.triplekillcount = 0;
}
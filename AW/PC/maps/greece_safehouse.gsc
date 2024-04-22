/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_safehouse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 191
 * Decompile Time: 2914 ms
 * Timestamp: 4/22/2024 2:31:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	safehouseprecache();
	safehouseflaginit();
	safehouseglobalvars();
	safehouseglobalsetup();
	setdvar("debug_character_count","on");
	thread openingsplashscreen();
	maps\greece_safehouse_anim::main();
	maps\greece_safehouse_vo::main();
	maps\greece_safehouse_fx::main();
	maps\_hms_door_interact::precachedooranimations();
	maps\_drone_civilian::init();
	safehousedoorinit();
	thread safehousetvdestructible();
}

//Function Number: 2
openingsplashscreen()
{
	var_00 = level.start_point;
	if(var_00 == "start_safehouse_intro" || var_00 == "default")
	{
		level.player disableweapons();
		level.player freezecontrols(1);
		thread maps\_shg_utility::play_chyron_video("chyron_text_greece",1,2);
		common_scripts\utility::flag_wait("chyron_video_done");
		level.player enableweapons();
		level.player freezecontrols(0);
		common_scripts\utility::flag_set("FlagSafeHouseIntro");
		common_scripts\utility::flag_set("introscreen_complete");
		common_scripts\utility::flag_set("FlagIntroScreenComplete");
	}
}

//Function Number: 3
safehouseprecache()
{
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("iw5_sn6_sp_silencer01");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacheitem("paint_grenade_var");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp_opticsreddot_silencerpistol");
	precacheitem("iw5_kf5_sp");
	precacheitem("iw5_kf5_sp_silencer01");
	precacheitem("hms_security_camera");
	precacherumble("silencer_fire");
	precacherumble("tank_rumble");
	precacherumble("steady_rumble");
	precacherumble("grenade_rumble");
	precachemodel("viewhands_atlas_military");
	precachemodel("vb_civilian_mitchell");
	precachemodel("vm_civilian_mitchell");
	precachemodel("kva_civilian_a_head");
	precachemodel("kva_civilian_b_head");
	precachemodel("kva_civilian_c_head");
	precachemodel("kva_civilian_d");
	precachemodel("civ_urban_male_waiter_body");
	precachemodel("kva_civilian_d_keyman");
	precachemodel("head_m_gen_cau_clark");
	precachemodel("kva_civilian_a_ambusher");
	precachemodel("head_civ_sf_male_a");
	precachemodel("head_civ_sf_male_b");
	precachemodel("head_civ_sf_male_c");
	precachemodel("head_civ_sf_male_d");
	precachemodel("head_london_male_b_drone");
	precachemodel("head_m_gen_mde_smith");
	precachemodel("head_m_gen_cau_young");
	precachemodel("head_m_gen_asi_pease");
	precachemodel("head_m_act_cau_kanik_base");
	precachemodel("head_m_act_afr_adams_base");
	precachemodel("head_hero_ilana_blend");
	precachemodel("head_f_gen_cau_coyle");
	precachemodel("head_m_gen_afr_davis");
	precachemodel("head_m_act_afr_adams_base");
	precachemodel("head_f_gen_afr_rice");
	precachemodel("weapon_parabolic_knife");
	precachemodel("viewbody_atlas_military");
	precachemodel("body_ilana_civilian_backpack");
	precachemodel("cafe_chair_02_anim");
	precachemodel("greece_cafe_chair_03_anim");
	precachemodel("greece_cafe_gps_pad");
	precachemodel("backpack_drone_small");
	precachemodel("backpack_drone_large");
	precachemodel("backpack_drone_flat");
	precachemodel("greece_duffelbag_rigged");
	precachemodel("greece_duffelbag_rigged_empty");
	precachemodel("vehicle_sniper_drone");
	precachemodel("vehicle_sniper_drone_cloak");
	precachemodel("coffee_cup");
	precachemodel("lag_umbrella_01_b");
	precachemodel("npc_titan45_base_loot");
	precachemodel("npc_kf5_base_loot");
	precachemodel("body_complete_civilian_suit_male_1");
	precachemodel("greece_blimp_rigged");
	precachemodel("goose");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_KILL");
	precachestring(&"GREECE_OBJ_MARKET_FOLLOW");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_JUMP");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_SUITUP");
	precachestring(&"GREECE_MARKET_TARGETESCAPE1_FAIL");
	precachestring(&"GREECE_MARKET_TARGETESCAPE2_FAIL");
	precachestring(&"GREECE_SAFEHOUSE_EXECUTE_PROMPT");
	precachestring(&"GREECE_HINT_DRONE_ZOOM_KB");
	precachestring(&"GREECE_SAFEHOUSE_SUIT_UP");
	precachestring(&"GREECE_SAFEHOUSE_SUIT_UP_KB");
	maps\_utility::add_control_based_hint_strings("cafe_scan",&"GREECE_CAFE_SCAN_PROMPT",::hintcamerascanoff,&"GREECE_CAFE_SCAN_PROMPT_KB");
	maps\_utility::add_control_based_hint_strings("sonic_ready",&"SONICAOE_READY",::hintsafehouseexitsonicoff);
	maps\_utility::add_control_based_hint_strings("camera_zoom",&"GREECE_HINT_DRONE_ZOOM",::hintcamerazoomoff,&"GREECE_HINT_DRONE_ZOOM_KB");
	maps\_hms_greece_civilian::precachecivilian();
	maps\_hms_door_interact::precachedooranimations();
	maps\greece_security_camera::precachesecuritycamera();
}

//Function Number: 4
safehouseflaginit()
{
	common_scripts\utility::flag_init("FlagIntroScreenComplete");
	common_scripts\utility::flag_init("FlagSetObjScanTarget");
	common_scripts\utility::flag_init("FlagSetObjFollowTarget");
	common_scripts\utility::flag_init("FlagChangeObjFollowTarget");
	common_scripts\utility::flag_init("FlagClearObjFollowTarget");
	common_scripts\utility::flag_init("FlagSetObjClearSafehouse");
	common_scripts\utility::flag_init("FlagSetObjComputerInteract");
	common_scripts\utility::flag_init("FlagSetObjSafehouseGapJump");
	common_scripts\utility::flag_init("FlagSafeHouseIntro");
	common_scripts\utility::flag_init("FlagSafeHouseFollowStart");
	common_scripts\utility::flag_init("FlagSafeHouseKillStart");
	common_scripts\utility::flag_init("FlagSafeHouseClearStart");
	common_scripts\utility::flag_init("FlagSafeHouseTransitionStart");
	common_scripts\utility::flag_init("FlagSafeHouseOutroStart");
	common_scripts\utility::flag_init("FlagFollowTargetMarked");
	common_scripts\utility::flag_init("FlagFollowTargetUnmarked");
	common_scripts\utility::flag_init("FlagFollowTargetTeleport");
	common_scripts\utility::flag_init("FlagSafehouseMeleeKillInitiated");
	common_scripts\utility::flag_init("FlagFollowTargetKilled");
	common_scripts\utility::flag_init("FlagSafehouseKeyCardCatch");
	common_scripts\utility::flag_init("FlagFollowTargetReachedFirstStop");
	common_scripts\utility::flag_init("FlagFollowTargetReachedSecondStop");
	common_scripts\utility::flag_init("FlagFollowTargetReachedFinalStop");
	common_scripts\utility::flag_init("FlagScanRemoveHint");
	common_scripts\utility::flag_init("FlagCatchKillCompleted");
	common_scripts\utility::flag_init("FlagFirstFloorSafehouseKVAkilled");
	common_scripts\utility::flag_init("FlagSecondFloorSafehouseKVAkilled");
	common_scripts\utility::flag_init("FlagPacingGuardAlerted");
	common_scripts\utility::flag_init("FlagSafehouseIlanaTransitionReachStarted");
	common_scripts\utility::flag_init("FlagSafehouseIlanaTransitionIdleStarted");
	common_scripts\utility::flag_init("FlagIlanaMidMarketStartMoving");
	common_scripts\utility::flag_init("FlagCameraScanUnlockVoHints");
	common_scripts\utility::flag_init("FlagSafeHouseCloseSafehouseGates");
	common_scripts\utility::flag_init("FlagPlayerUsedSafehouseComputer");
	common_scripts\utility::flag_init("FlagSafehouseVideoChatEnded");
	common_scripts\utility::flag_init("FlagSafehouseIlanaAtStairs");
	common_scripts\utility::flag_init("FlagMarketCoupleAtGoal");
	common_scripts\utility::flag_init("FlagStartMarketCouple");
	common_scripts\utility::flag_init("FlagSafehouseIlanaTeleportToBack");
	common_scripts\utility::flag_init("FlagIlanaMoveToBackDoor");
	common_scripts\utility::flag_init("FlagIlanaEnterSafehouse");
	common_scripts\utility::flag_init("FlagIlanaMoveToLaunchPos");
	common_scripts\utility::flag_init("FlagScanTargetEnable");
	common_scripts\utility::flag_init("FlagScanTargetBegin");
	common_scripts\utility::flag_init("FlagScanTargetComplete");
	common_scripts\utility::flag_init("FlagKillTargetComplete");
	common_scripts\utility::flag_init("FlagClearSafehouseComplete");
	common_scripts\utility::flag_init("FlagComputerInteractComplete");
	common_scripts\utility::flag_init("FlagWindowShootersBreakOut");
	common_scripts\utility::flag_init("FlagSafehouseExitKVADead");
	common_scripts\utility::flag_init("FlagSafehouseStairKVADead");
	common_scripts\utility::flag_init("FlagKickSafehouseExitGate");
	common_scripts\utility::flag_init("FlagEnableSafehouseGapJump");
	common_scripts\utility::flag_init("FlagPlayerJumping");
	common_scripts\utility::flag_init("FlagPlayerJumpWatcherStop");
	common_scripts\utility::flag_init("FlagSafehouseGapJumpStarted");
	common_scripts\utility::flag_init("FlagSafehouseGapJumpCompleted");
	common_scripts\utility::flag_init("FlagSafehousePlayerGapJumpCompleted");
	common_scripts\utility::flag_init("FlagSafehouseExitGateOpen");
	common_scripts\utility::flag_init("FlagTriggerExitPlayerComingDownStairs");
	common_scripts\utility::flag_init("FlagTriggerExitPlayerLeavingBuilding");
	common_scripts\utility::flag_init("FlagKVATargetInAlley");
	common_scripts\utility::flag_init("FlagDeleteSafehouseCivilians");
	common_scripts\utility::flag_init("FlagPacingGuardDamaged");
	common_scripts\utility::flag_init("FlagPacingNpcDeath");
	common_scripts\utility::flag_init("IlanaSafehouseDoorIdleStart");
	common_scripts\utility::flag_init("FlagSniperDroneLaunched");
	common_scripts\utility::flag_init("FlagIlanaSafehouseExitAtSecondFloorWait");
	common_scripts\utility::flag_init("FlagKVAsafehouseGuardDeath");
	common_scripts\utility::flag_init("FlagCafeCameraUnlockSwitching");
	common_scripts\utility::flag_init("FlagCameraScanUnlockZoom");
	common_scripts\utility::flag_init("FlagKVATargetWaitTimerExpired");
	common_scripts\utility::flag_init("FlagKVASafehousePatrollerDeath");
	common_scripts\utility::flag_init("FlagSafehouseThreatGrenadeDetonated");
	common_scripts\utility::flag_init("FlagSafehouseCourtyardTakedownComplete");
	common_scripts\utility::flag_init("FlagDeleteMarketFirstWalkers");
	common_scripts\utility::flag_init("FlagSonicAoEActivated");
	common_scripts\utility::flag_init("FlagFXPlayed");
	common_scripts\utility::flag_init("SonicIntroCheckActivated");
	common_scripts\utility::flag_init("FlagSafehouseHideHint");
	common_scripts\utility::flag_init("FlagMarketCameraSwitched");
	common_scripts\utility::flag_init("FlagSafehousePlanningGuardsAlerted");
	common_scripts\utility::flag_init("FlagPopulateMarket");
	common_scripts\utility::flag_init("FlagCafeVideologComplete");
	common_scripts\utility::flag_init("FlagStartCafeVideoLog");
	common_scripts\utility::flag_init("FlagSafehouseBackyardFail");
	common_scripts\utility::flag_init("FlagConfCenterVOStart");
}

//Function Number: 5
safehouseglobalvars()
{
	level.showdebugtoggle = 0;
	level.dialogtable = "sp/greece_dialog.csv";
	level.potentialscantargets = [];
	level.kvafollowtarget = undefined;
	level.kvasafehouseguardarray = [];
	level.bplayerscanon = 0;
	setsaveddvar("r_hudoutlineenable",1);
	common_scripts\utility::create_dvar("display_placeholderdialog",0);
}

//Function Number: 6
safehouseglobalsetup()
{
	thread safehousebeginentrance();
	thread safehousebeginexit();
}

//Function Number: 7
safehousestartpoints()
{
	maps\_utility::add_start("start_safehouse_intro",::initsafehouseintro);
	maps\_utility::add_start("start_safehouse_follow",::initsafehousefollow);
	maps\_utility::add_start("start_safehouse_xslice",::initsafehousekill);
	maps\_utility::add_start("start_safehouse_clear",::initsafehouseclear);
	maps\_utility::add_start("start_safehouse_transition",::initsafehousetransition);
	maps\greece_starts::add_greece_starts("safehouse");
}

//Function Number: 8
safehousestartpointsfinal()
{
	maps\_utility::add_start("start_safehouse_exit",::initsafehouseoutro);
	maps\greece_starts::add_greece_starts("safehouse_final");
}

//Function Number: 9
initsafehouseintro()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseIntro","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol",undefined,undefined,undefined,"iw5_titan45_sp_opticsreddot_silencerpistol");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_01,0);
	}

	level.player setviewmodel("vm_civilian_mitchell");
	common_scripts\utility::flag_wait("FlagSafeHouseIntro");
	soundscripts\_snd::snd_message("start_safehouse_intro_checkpoint");
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseIntro",1,1,"IlanaSafehouse");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] thread maps\greece_code::disableawareness();
	thread cafeilanaseat();
	safehousetoggleexitflagtriggers(0);
	level.player playerchangemode("no_combat_slow");
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.2,0.6,50,500);
	thread safehousetranstoalleygatesetup();
	thread cafeinitvendorgate();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	thread cafegeeseflyinganimation();
	common_scripts\utility::flag_set("FlagSafeHouseStart");
	common_scripts\utility::flag_set("init_safehouse_intro_lighting");
}

//Function Number: 10
initsafehousefollow()
{
	safehouseobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseFollow","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol",undefined,undefined,undefined,"iw5_titan45_sp_opticsreddot_silencerpistol");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_01,0);
	}

	level.player setviewmodel("vm_civilian_mitchell");
	soundscripts\_snd::snd_message("start_safehouse_follow_checkpoint");
	thread cafecameraumbrella();
	thread cafeinitvendorgate();
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseFollow",1,1,"IlanaSafehouse");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] thread maps\greece_code::disableawareness();
	cafesetuptouristilana();
	thread cafeendcamerascan(undefined);
	thread cafemarketmoveilana(undefined,undefined);
	thread spawnkvafollowtarget();
	thread cafeinitvendorgate();
	safehousetoggleexitflagtriggers(0);
	level.player playerchangemode("no_combat_slow");
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.2,0.6,50,500);
	thread safehousetranstoalleygatesetup();
	common_scripts\utility::flag_set("FlagScanTargetComplete");
	common_scripts\utility::flag_set("FlagFollowTargetMarked");
	common_scripts\utility::flag_set("FlagSafeHouseStart");
	common_scripts\utility::flag_set("init_safehouse_follow_lighting");
}

//Function Number: 11
initsafehousekill()
{
	common_scripts\utility::flag_set("init_safehouse_xslice");
	safehouseobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseKill","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol",undefined,undefined,undefined,"iw5_titan45_sp_opticsreddot_silencerpistol");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_01,0);
	}

	level.player setviewmodel("vm_civilian_mitchell");
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	soundscripts\_snd::snd_message("start_safehouse_xslice_checkpoint");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseKill",1,1,"IlanaSafehouse");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] thread maps\greece_code::disableawareness();
	safehousetoggleexitflagtriggers(0);
	thread safehouseexittogglegates("open");
	thread cafeinitvendorgate();
	spawncivilians();
	thread spawnkvafollowtarget();
	cafesetuptouristilana();
	thread safehouseilanaclearsafehouse();
	thread safehousedoorplayerblocker();
	level.player playerchangemode("no_combat_fast");
	level.player thread playerrubberbandmovespeedscale(level.kvafollowtarget,0.2,0.5,200,500);
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	thread maps\greece_safehouse_vo::xslicestartdialogue();
	thread xslicefade();
	thread safehousetranstoalleygatesetup();
	common_scripts\utility::flag_set("FlagSetObjClearSafehouse");
	common_scripts\utility::flag_set("FlagSafeHouseKillStart");
	common_scripts\utility::flag_set("FlagFollowTargetReachedFinalStop");
}

//Function Number: 12
initsafehouseclear()
{
	safehouseobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseClear","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol",undefined,undefined,undefined,"iw5_titan45_sp_opticsreddot_silencerpistol");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_01,0);
	}

	level.player setviewmodel("vm_civilian_mitchell");
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	soundscripts\_snd::snd_message("start_safehouse_clear_checkpoint");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseClear",1,1,"IlanaSafehouse");
	level.allies["Ilona"] thread maps\greece_code::disableawareness();
	level.allies["Ilona"] thread cafesetupilanabackpack();
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] maps\_utility::enable_cqbwalk();
	thread safehouseilanaopendooridle();
	safehousetoggleexitflagtriggers(0);
	level.player playerchangemode("stealth_combat");
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.3,1,50,300);
	thread safehouseexittogglegates("closed");
	thread safehousebackyarddamagetriggers();
	thread safehousebackyarddamagetriggerstoggle();
	thread safehouseilanaclearsafehouse();
	thread safehousedoorplayerblocker();
	spawncivilians();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	thread safehousetranstoalleygatesetup();
	common_scripts\utility::flag_set("FlagSetObjClearSafehouse");
	common_scripts\utility::flag_set("FlagSafeHouseClearStart");
	common_scripts\utility::flag_set("init_safehouse_clear_start_lighting");
}

//Function Number: 13
initsafehousetransition()
{
	safehouseobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseTransition","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol",undefined,undefined,undefined,"iw5_titan45_sp_opticsreddot_silencerpistol");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_01 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_01,0);
	}

	level.player setviewmodel("vm_civilian_mitchell");
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseTransition",1,1,"IlanaSafehouse");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] thread cafesetupilanabackpack();
	safehouseforceopensafehousedoor();
	safehousetoggleexitflagtriggers(0);
	thread safehouseexittogglegates("closed");
	thread safehouseremoveplayerblocker();
	thread safehouseilanabagdropwait();
	thread safehousebackyarddamagetriggers();
	thread safehousebackyarddamagetriggerstoggle();
	common_scripts\utility::trigger_off("SafehousePlayerNearBackDoorTrig1","targetname");
	common_scripts\utility::trigger_off("SafehousePlayerNearBackDoorTrig2","targetname");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	thread safehousetranstoalleygatesetup();
	common_scripts\utility::flag_set("FlagSetObjClearSafehouse");
	common_scripts\utility::flag_set("FlagSafeHouseTransitionStart");
	common_scripts\utility::flag_set("init_safehouse_transition_start_lighting");
	common_scripts\utility::flag_set("FlagPacingNpcDeath");
	soundscripts\_snd::snd_message("start_safehouse_transition_checkpoint");
}

//Function Number: 14
initsafehouseoutro()
{
	safehouseobjectivesetup();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartSafehouseOutro","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	maps\_hms_utility::spawnandinitnamedally("Ilona","IlanaStartSafehouseOutro",1,1,"IlanaSafehouseExoSuit");
	common_scripts\_exploder::exploder(666);
	thread animatedpalmtrees();
	thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	maps\greece_conf_center_fx::confcenterresidualsmoke();
	maps\greece_safehouse_fx::ambientcloudskill();
	thread safehouseexittogglegates("closed");
	thread safehouseremoveplayerblocker();
	safehouseforceopensafehousedoor();
	common_scripts\utility::trigger_off("SafehousePlayerNearBackDoorTrig1","targetname");
	common_scripts\utility::trigger_off("SafehousePlayerNearBackDoorTrig2","targetname");
	thread safehousetranstoalleygatesetup();
	thread safehouseexitdeadbodysetupcouchguard();
	thread safehouseexitdeadbodysetuppacingguard();
	maps\_hud_util::fade_out(0.25,"white");
	common_scripts\utility::flag_set("FlagSafeHouseOutroStart");
	maps\_utility::delete_exploder(666);
	common_scripts\utility::flag_set("init_safehouse_outro_start_lighting");
	soundscripts\_snd::snd_message("start_safehouse_exit_checkpoint");
}

//Function Number: 15
safehouseobjectivesetup()
{
	waittillframeend;
	safehousesetcompletedobjflags();
	thread setobjmarketscan();
	thread setobjfollowtarget();
	thread setobjinfilsafehouse();
	thread setobjintercepthades();
}

//Function Number: 16
safehousesetcompletedobjflags()
{
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_safehouse_"))
	{
		return;
	}

	if(var_00 == "start_safehouse_intro")
	{
		return;
	}

	if(var_00 == "start_safehouse_follow")
	{
		return;
	}

	if(var_00 == "start_safehouse_xslice")
	{
		return;
	}

	if(var_00 == "start_safehouse_clear")
	{
		return;
	}

	if(var_00 == "start_safehouse_transition")
	{
		return;
	}

	if(var_00 == "start_safehouse_outro")
	{
	}
}

//Function Number: 17
setobjmarketscan()
{
	common_scripts\utility::flag_wait("FlagSetObjScanTarget");
	objective_add(maps\_utility::obj("ScanKeyman"),"active",&"GREECE_OBJ_SAFEHOUSE_SCAN",(0,0,0));
	objective_current(maps\_utility::obj("ScanKeyman"));
	common_scripts\utility::flag_wait("FlagScanTargetComplete");
	maps\_utility::objective_complete(maps\_utility::obj("ScanKeyman"));
}

//Function Number: 18
setobjfollowtarget()
{
	common_scripts\utility::flag_wait("FlagSetObjFollowTarget");
	if(isdefined(level.kvafollowtarget))
	{
		objective_add(maps\_utility::obj("InfilSafehouse"),"active",&"GREECE_OBJ_SAFEHOUSE_INFIL",(0,0,0));
		objective_current(maps\_utility::obj("InfilSafehouse"));
		objective_onentity(maps\_utility::obj("InfilSafehouse"),level.kvafollowtarget);
		objective_setpointertextoverride(maps\_utility::obj("InfilSafehouse"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
		common_scripts\utility::flag_wait("FlagClearObjFollowTarget");
		objective_position(maps\_utility::obj("InfilSafehouse"),(0,0,0));
	}
}

//Function Number: 19
setobjinfilsafehouse()
{
	common_scripts\utility::flag_wait("FlagSetObjClearSafehouse");
	objective_onentity(maps\_utility::obj("InfilSafehouse"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InfilSafehouse"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	common_scripts\utility::flag_wait_either("FlagPacingNpcDeath","FlagTriggerPlayerOnInsideStairway");
	objective_position(maps\_utility::obj("InfilSafehouse"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InfilSafehouse"),"");
	common_scripts\utility::flag_wait("FlagSetObjComputerInteract");
	var_00 = getent("ComputerInteractObj","targetname");
	objective_position(maps\_utility::obj("InfilSafehouse"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InfilSafehouse"),&"GREECE_OBJ_SAFEHOUSE_SUITUP");
	common_scripts\utility::flag_wait("FlagComputerInteractComplete");
	maps\_utility::objective_complete(maps\_utility::obj("InfilSafehouse"));
}

//Function Number: 20
setobjintercepthades()
{
	common_scripts\utility::flag_wait("FlagSetObjSafehouseGapJump");
	objective_add(maps\_utility::obj("InterceptHades"),"active",&"GREECE_OBJ_INTERCEPT_HADES",(0,0,0));
	objective_onentity(maps\_utility::obj("InterceptHades"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	objective_current(maps\_utility::obj("InterceptHades"));
}

//Function Number: 21
levelintroscreen()
{
	maps\_utility::intro_screen_create(&"GREECE_INTRO_LINE1",&"GREECE_INTRO_LINE2",&"GREECE_INTRO_LINE3");
	maps\_utility::intro_screen_custom_func(::maps\greece_code::manhuntintroscreen);
}

//Function Number: 22
setupaiforanimsequence()
{
	self.goalradius = 8;
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.battlechatter = 0;
}

//Function Number: 23
safehousebeginentrance()
{
	common_scripts\utility::flag_wait("FlagSafeHouseStart");
	safehouseobjectivesetup();
	thread safehouseexittogglegates("open");
	thread cafesetupplayerseat();
	thread cafemarketplayerfollowtarget();
	thread safehousefollowplayernotifies();
	cafesetuptouristilana();
	thread safehousetranstoalleygatesetup();
	thread safehousedoorplayerblocker();
	spawncivilians();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
}

//Function Number: 24
animatedpalmtrees()
{
	var_00 = getentarray("palmtree","targetname");
	foreach(var_02 in var_00)
	{
		var_02.animname = "palm_tree";
		var_02 maps\_utility::assign_animtree();
		var_03 = "light_sway";
		var_04 = randomfloatrange(0.5,0.7);
		var_02 setanimrestart(level.scr_anim[var_02.animname][var_03][0],1,0,var_04);
	}
}

//Function Number: 25
marketscancomplete()
{
	self waittill("target_scanned");
	common_scripts\utility::flag_set("FlagFollowTargetMarked");
}

//Function Number: 26
spawnkvasafehouseguards()
{
	thread spawnsafehousepatroller();
	maps\_utility::array_spawn_function_targetname("KVAsafehouseGuard",::safehouseenemyinit,0);
	level.kvasafehouseguardarray = maps\_utility::array_spawn_targetname("KVAsafehouseGuard");
	foreach(var_01 in level.kvasafehouseguardarray)
	{
		var_01.dropweapon = 0;
		if(!isdefined(var_01.target))
		{
			continue;
		}

		var_01.allowdeath = 1;
		if(var_01.target == "safehouse_pacing_npc")
		{
			var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
			var_01 forceteleport(var_02.origin,var_02.angles);
			var_01.animname = "generic";
			var_03 = var_02.targetname;
			var_04 = var_02.script_noteworthy;
			var_01 thread safehousepacingguard(var_02);
			var_01 thread maps\greece_code::bloodsprayexitwoundtrace(undefined,undefined,undefined,1);
		}

		if(var_01.script_noteworthy == "SafehouseSleepingGuard")
		{
			var_01 thread safehousesleepingguard();
			var_01 thread sleepingguardcustombloodspray();
		}
	}

	thread safehouseplanningguards();
}

//Function Number: 27
sleepingguardcustombloodspray()
{
	self endon("delete");
	self waittill("damage",var_00,var_01,var_02,var_03);
	if(var_01 == level.allies["Ilona"])
	{
		var_04 = self geteye();
	}
	else
	{
		var_04 = var_04;
	}

	playfx(common_scripts\utility::getfx("blood_impact_splat_sm"),var_04);
}

//Function Number: 28
spawnkvafollowtarget()
{
	maps\_utility::array_spawn_function_targetname("KVAfollowTarget",::marketenemyinit);
	maps\_utility::array_spawn_function_targetname("KVAfollowTarget",::marketscancomplete);
	level.kvafollowtarget = maps\_utility::spawn_targetname("KVAfollowTarget");
	level.kvafollowtarget thread initscanvariables();
	var_00 = ["kva_civilian_d_keyman"];
	var_01 = ["head_m_gen_cau_young"];
	level.kvafollowtarget maps\greece_code::aioverridemodelrandom(var_00,var_01);
	thread marketmovekvafollowtarget();
}

//Function Number: 29
spawnsafehousepatroller()
{
	var_00 = getent("KVAsafehousePatroller","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.health = 1;
	var_01.dropweapon = 0;
	var_01.battlechatter = 0;
	var_01.animname = "Victim";
	var_01.script_parameters = "Victim";
	var_01.ragdoll_immediate = 1;
	var_01.diequietly = 1;
	var_01.fovcosine = cos(45);
	var_01.grenadeawareness = 0;
	var_01 thread safehousepatrolleralertwatch();
	common_scripts\utility::flag_wait("FlagKVASafehousePatrollerDeath");
	level notify("SafehousePatrollerDead");
}

//Function Number: 30
safehousepatrolleralertwatch()
{
	level endon("SafehousePatrollerDead");
	maps\_stealth_utility::stealth_enemy_waittill_alert();
	wait(1);
	var_00 = getent("SafehousePlanningOrg","targetname");
	var_00 notify("fail_left");
	var_00 notify("fail_right");
	thread maps\greece_safehouse_vo::safehousefailkvaalerted();
	wait(1);
	common_scripts\utility::flag_set("FlagSafehouseHideHint");
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - KVA ALERTED!!!");
	setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 31
safehousesleepingguard()
{
	var_00 = common_scripts\utility::getstruct("safehousekill","targetname");
	var_01 = "safehouse_sleeping_guard_idle";
	var_02 = "safehouse_sleeping_guard_kill";
	self.animname = "generic";
	maps\_utility::gun_remove();
	self.health = 100000;
	self.diequietly = 1;
	var_03 = getent("safehouse_pillow","targetname");
	var_03.animname = "safehouse_pillow";
	var_03 maps\_utility::assign_animtree("safehouse_pillow");
	var_00 thread maps\_anim::anim_first_frame_solo(var_03,"safehouse_enter2");
	var_00 thread maps\_anim::anim_loop_solo(self,var_01,"StopSleepLoop");
	thread safehousesleepingguarddeath(var_00);
}

//Function Number: 32
safehousesleepingguarddeath(param_00)
{
	self endon("SafehouseSleepingGuardCancelDeath");
	var_01 = "safehouse_sleeping_guard_death";
	self waittill("damage",var_02,var_03);
	if(isdefined(var_03) && var_03 == level.player)
	{
		maps\greece_code::giveplayerchallengekillpoint();
	}

	common_scripts\utility::flag_set("FlagSafehouseSleepingGuardKilled");
	param_00 notify("StopSleepLoop");
	maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(self,var_01);
	maps\greece_code::kill_no_react();
}

//Function Number: 33
safehousesleepingguardanimcheck(param_00)
{
	var_01 = level.allies["Ilona"];
	var_02 = getent("safehouse_pillow","targetname");
	var_02.animname = "safehouse_pillow";
	var_02 maps\_utility::assign_animtree("safehouse_pillow");
	var_03 = maps\_utility::get_living_ai("SafehouseSleepingGuard","script_noteworthy");
	if(common_scripts\utility::flag("FlagSafehouseSleepingGuardKilled"))
	{
		param_00 thread maps\_anim::anim_single_solo(var_02,"safehouse_sleeping_guard_kill_alt");
		param_00 maps\_anim::anim_single_solo(var_01,"safehouse_sleeping_guard_kill_alt");
		thread safehouseexitdeadbodysetupcouchguard(param_00,"safehouse_sleeping_guard_kill",var_02,1);
		return;
	}

	var_03 notify("SafehouseSleepingGuardCancelDeath");
	var_04 = [var_03,var_01,var_02];
	param_00 notify("StopSleepLoop");
	var_03 maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single(var_04,"safehouse_sleeping_guard_kill");
	thread safehouseexitdeadbodysetupcouchguard(param_00,"safehouse_sleeping_guard_kill",var_02,0);
	var_03 maps\greece_code::kill_no_react();
}

//Function Number: 34
safehouseexitdeadbodysetupcouchguard(param_00,param_01,param_02,param_03)
{
	common_scripts\utility::flag_wait("FlagSafeHouseOutroStart");
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = common_scripts\utility::getstruct("safehousekill","targetname");
	}

	if(!isdefined(param_01))
	{
		param_01 = "safehouse_sleeping_guard_kill";
	}

	if(!isdefined(param_02))
	{
		param_02 = getent("safehouse_pillow","targetname");
		param_02.animname = "safehouse_pillow";
		param_02 maps\_utility::assign_animtree("safehouse_pillow");
	}

	if(param_03 == 1)
	{
		param_00 thread maps\_anim::anim_single_solo(param_02,param_01 + "_alt");
	}
	else if(param_03 == 0)
	{
		param_00 thread maps\_anim::anim_single_solo(param_02,param_01);
	}

	var_04 = getent("SafehouseSleepingGuard","script_noteworthy");
	var_04.count = 1;
	var_05 = var_04 maps\_utility::spawn_ai();
	var_05.animname = "generic";
	var_05 maps\_utility::gun_remove();
	var_05.dropweapon = 0;
	if(param_03 == 1)
	{
		param_01 = "safehouse_sleeping_guard_death";
	}

	param_00 maps\_anim::anim_single_solo(var_05,param_01);
	var_05 maps\greece_code::kill_no_react();
}

//Function Number: 35
safehousepacingguard(param_00)
{
	var_01 = "safehouse_videochat_01";
	var_02 = "safehouse_videochat_idle";
	var_03 = "safehouse_videochat_alert";
	self.animname = "pacing_guard";
	self.script_parameters = "pacing_guard";
	maps\_utility::gun_remove();
	self.health = 100000;
	self.ragdoll_immediate = 1;
	thread safehousevideochatmovie();
	param_00 thread maps\_anim::anim_loop_solo(self,var_02,"PacingGuard");
	level waittill("SafehouseVideoChatConversationStarted");
	param_00 notify("PacingGuard");
	thread safehousepacingguardalertmonitor(param_00);
	thread safehousepacingguarddeath(param_00);
	param_00 maps\_anim::anim_single_solo(self,var_01);
	if(isalive(self) && !common_scripts\utility::flag("FlagPacingGuardAlerted") && !common_scripts\utility::flag("FlagPacingGuardDamaged"))
	{
		param_00 thread maps\_anim::anim_loop_solo(self,var_02,"PacingGuard");
	}
}

//Function Number: 36
safehousepacingguarddeath(param_00)
{
	level endon("SafehouseAbortVideoChat");
	var_01 = "safehouse_videochat_death";
	self waittill("damage",var_02,var_03);
	if(isdefined(var_03) && var_03 == level.player)
	{
		maps\greece_code::giveplayerchallengekillpoint();
	}

	self notify("PacingGuardDamaged");
	common_scripts\utility::flag_set("FlagPacingGuardDamaged");
	common_scripts\utility::flag_set("FlagPacingNpcDeath");
	common_scripts\utility::flag_set("FlagClearSafehouseComplete");
	thread safehouseexitdeadbodysetuppacingguard(param_00,var_01);
	param_00 notify("PacingGuard");
	maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(self,var_01);
	maps\greece_code::kill_no_react();
}

//Function Number: 37
safehouseexitdeadbodysetuppacingguard(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = common_scripts\utility::getstruct("safehouse_pacing_npc","targetname");
	}

	if(!isdefined(param_01))
	{
		param_01 = "safehouse_videochat_death";
	}

	common_scripts\utility::flag_wait("FlagSafeHouseOutroStart");
	var_02 = getent("PacingGuard","script_noteworthy");
	var_02.count = 1;
	var_03 = var_02 maps\_utility::spawn_ai();
	var_03.animname = "pacing_guard";
	var_03 maps\_utility::gun_remove();
	var_03.dropweapon = 0;
	param_00 maps\_anim::anim_single_solo(var_03,param_01);
	var_03 maps\greece_code::kill_no_react();
}

//Function Number: 38
safehousepacingguardalertmonitor(param_00)
{
	self endon("PacingGuardDamaged");
	thread safehouseguardsightwatch(param_00,"PacingGuard");
	thread safehouseguardalertwatch(param_00,"PacingGuard");
	thread safehouseguardtriggerwatch("TriggerSafehouseForceAlertPacingGuard",param_00,"PacingGuard",0);
	thread safehousepacingguardtriggerwatch(param_00);
	thread safehousepacingguardconversationmonitor();
	maps\_utility::disable_surprise();
	self notify("guy_alerted");
	var_01 = "safehouse_videochat_alert";
	param_00 waittill("PacingGuard");
	if(isalive(self))
	{
		common_scripts\utility::flag_set("FlagPacingGuardAlerted");
		level notify("SafehouseAbortVideoChat");
		maps\_utility::anim_stopanimscripted();
		self.allowdeath = 1;
		self.ignoreall = 0;
		self.health = 1;
		maps\_utility::disable_dontevershoot();
		maps\_utility::gun_recall();
		param_00 thread maps\_anim::anim_single_solo(self,var_01);
		if(common_scripts\utility::flag("FlagSafehouseVideoChatEnded"))
		{
			self endon("death");
			thread maps\greece_safehouse_vo::safehousefailkvaalerted();
			wait(1);
			common_scripts\utility::flag_set("FlagSafehouseHideHint");
			maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - KVA ALERTED!!!");
			setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
			maps\_utility::missionfailedwrapper();
		}
	}
}

//Function Number: 39
safehousepacingguardconversationmonitor()
{
	level endon("HadesTalkReallyFinished");
	common_scripts\utility::flag_wait_either("FlagPacingNpcDeath","FlagPacingGuardAlerted");
	thread maps\greece_safehouse_vo::safehousefailkvaalerted();
	wait(1);
	common_scripts\utility::flag_set("FlagSafehouseHideHint");
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - KVA ALERTED!!!");
	setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 40
safehousevideochatmovie()
{
	var_00 = getentarray("SafehousePostCallScreen","targetname");
	level waittill("SafehouseVideoChatConversationStarted");
	thread videochatpostscreenhide(var_00,1);
	soundscripts\_snd::snd_message("start_videochat_screen_turn_on");
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingameloop("manhunt_vidchat");
	level common_scripts\utility::waittill_either("HadesTalkFinished","SafehouseAbortVideoChat");
	soundscripts\_snd::snd_message("start_videochat_screen_turn_off");
	wait(1);
	stopcinematicingame();
	setsaveddvar("cg_cinematicfullscreen","1");
	common_scripts\utility::flag_set("FlagSafehouseVideoChatEnded");
	wait(0.1);
	level notify("HadesTalkReallyFinished");
	thread videochatpostscreenhide(var_00,0);
	common_scripts\utility::flag_wait("FlagPlayerUsedSafehouseComputer");
	maps\_utility::array_delete(var_00);
}

//Function Number: 41
videochatpostscreenhide(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(param_01 == 1)
		{
			var_03 hide();
			continue;
		}

		var_03 show();
	}
}

//Function Number: 42
playerchangemode(param_00)
{
	switch(param_00)
	{
		case "no_combat_slow":
			self disableweapons();
			self allowmelee(0);
			self allowcrouch(0);
			self allowprone(0);
			self allowsprint(0);
			self allowdodge(0);
			self allowjump(0);
			self allowstand(1);
			self setmovespeedscale(0.3);
			break;

		case "no_combat_fast":
			self disableweapons();
			self allowmelee(0);
			self allowcrouch(0);
			self allowprone(0);
			self allowsprint(0);
			self allowdodge(0);
			self allowjump(0);
			self allowstand(1);
			self setmovespeedscale(0.5);
			break;

		case "stealth_combat":
			self enableweapons();
			self allowmelee(1);
			maps\_utility::playerallowalternatemelee(1);
			self allowcrouch(1);
			self allowprone(1);
			self allowsprint(0);
			self allowdodge(0);
			self allowjump(1);
			self allowstand(1);
			self setmovespeedscale(0.8);
			if(!isdefined(self._stealth))
			{
				maps\_stealth_utility::stealth_default();
			}
			break;

		case "full_combat":
			self enableweapons();
			self allowmelee(1);
			self allowcrouch(1);
			self allowprone(1);
			self allowsprint(1);
			self allowdodge(1);
			self allowjump(1);
			self allowstand(1);
			self setmovespeedscale(1);
			break;
	}
}

//Function Number: 43
playerrubberbandmovespeedscale(param_00,param_01,param_02,param_03,param_04)
{
	self endon("CancelMoveSpeedScale");
	for(;;)
	{
		if(isdefined(param_00))
		{
			break;
		}

		wait 0.05;
	}

	for(;;)
	{
		var_05 = distance(self.origin,param_00.origin);
		if(var_05 >= param_04)
		{
			var_06 = param_02;
		}
		else if(var_05 <= param_03)
		{
			var_06 = param_01;
		}
		else
		{
			var_07 = param_04 - param_03;
			var_08 = param_02 - param_01;
			var_09 = var_05 - param_03;
			var_0A = var_09 / var_07;
			var_0B = var_0A * var_08;
			var_06 = param_01 + var_0B;
		}

		self setmovespeedscale(var_06);
		wait(0.5);
	}
}

//Function Number: 44
spawncivilians()
{
	thread spawnmalecivilians();
	thread spawnmalecivilianswithface();
	thread spawnfemalecivilians();
	thread cafewaiter();
	thread cafesittingreader();
	thread cafecivilianmeetandgreet();
	thread marketvendor();
	thread markethost();
	thread cafeteasipper();
	thread fountaincivilians();
	thread spawnposttakedowncivilians();
	thread spawnpotentialtargets();
}

//Function Number: 45
spawnposttakedowncivilians()
{
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	wait(1);
	if(level.nextgen)
	{
		var_00 = getent("civilian_male","targetname");
		var_01 = getent("civilian_female","targetname");
		var_02 = common_scripts\utility::getstructarray("male_standing_round2_nodes","script_noteworthy");
		var_03 = common_scripts\utility::getstructarray("male_sitting_round2_nodes","script_noteworthy");
		var_04 = common_scripts\utility::getstructarray("female_standing_round2_nodes","script_noteworthy");
		var_05 = common_scripts\utility::getstructarray("female_sitting_round2_nodes","script_noteworthy");
		var_06 = maps\_utility::array_merge(var_02,var_03);
		var_07 = maps\_utility::array_merge(var_04,var_05);
		var_08 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_06);
		var_09 = maps\_hms_greece_civilian::populatedronecivilians(var_01,var_07);
		common_scripts\utility::flag_wait("FlagPlayerStartDroneControl");
		maps\_utility::array_delete(var_08);
		maps\_utility::array_delete(var_09);
	}
}

//Function Number: 46
fountaincivilians()
{
	var_00 = common_scripts\utility::getstruct("fountainOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("fountain_civ1",1);
	var_01 thread initscanvariables();
	var_01.animname = "civ1";
	var_02 = maps\_utility::spawn_targetname("fountain_civ2",1);
	var_02.script_noteworthy = "PotentialTarget";
	var_02 thread initscanvariables();
	var_02.animname = "civ2";
	var_03 = [var_01,var_02];
	var_00 thread maps\_anim::anim_loop(var_03,"market_fntn_civ_talk");
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_03);
}

//Function Number: 47
spawnmalecivilians()
{
	var_00 = getent("civilian_male","targetname");
	var_01 = common_scripts\utility::getstructarray("male_standing_idle_nodes","targetname");
	var_02 = common_scripts\utility::getstructarray("male_sitting_idle_nodes","targetname");
	var_03 = maps\_utility::array_merge(var_01,var_02);
	var_04 = [];
	if(level.nextgen)
	{
		var_05 = 1.25;
	}
	else
	{
		var_05 = 4;
	}

	for(var_06 = 0;var_06 < var_03.size / var_05;var_06++)
	{
		var_04 = common_scripts\utility::add_to_array(var_04,var_03[var_06]);
	}

	var_03 = common_scripts\utility::array_remove_array(var_03,var_04);
	var_07 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_03);
	common_scripts\utility::array_thread(var_07,::initscanvariables);
	common_scripts\utility::flag_wait("FlagPopulateMarket");
	var_08 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_04);
	common_scripts\utility::array_thread(var_08,::initscanvariables);
	common_scripts\utility::flag_wait("init_safehouse_follow_lighting");
	maps\_utility::array_delete(var_08);
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_07);
}

//Function Number: 48
spawnmalecivilianswithface()
{
	var_00 = getent("civilian_male_w_face","targetname");
	var_01 = common_scripts\utility::getstructarray("male_standing_idle_nodes_w_face","targetname");
	var_02 = common_scripts\utility::getstructarray("male_sitting_idle_nodes_w_face","targetname");
	var_03 = maps\_utility::array_merge(var_01,var_02);
	var_04 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_03);
	common_scripts\utility::array_thread(var_04,::initscanvariables);
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_04);
}

//Function Number: 49
spawnfemalecivilians()
{
	var_00 = getent("civilian_female","targetname");
	var_01 = common_scripts\utility::getstructarray("female_standing_idle_nodes","targetname");
	var_02 = common_scripts\utility::getstructarray("female_sitting_idle_nodes","targetname");
	var_03 = maps\_utility::array_merge(var_01,var_02);
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size / 1.25;var_05++)
	{
		var_04 = common_scripts\utility::add_to_array(var_04,var_03[var_05]);
	}

	var_03 = common_scripts\utility::array_remove_array(var_03,var_04);
	var_06 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_03);
	common_scripts\utility::array_thread(var_06,::initscanvariables);
	var_07 = ["civ_urban_female_body_b_yellow","civ_urban_female_body_b_olive","civ_urban_female_body_e_gold","civ_urban_female_body_b_blue","civ_urban_female_body_d"];
	var_08 = ["head_f_gen_cau_peterson","head_f_act_cau_hamilton_base","head_f_gen_cau_giovanni","head_f_gen_cau_withers","head_f_gen_cau_coyle"];
	foreach(var_0A in var_06)
	{
		if(isdefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "casual")
		{
			var_0B = common_scripts\utility::random(var_08);
			var_0C = common_scripts\utility::random(var_07);
			var_0A thread codescripts\character::setheadmodel(var_0B);
			var_0A setmodel(var_0C);
		}
	}

	common_scripts\utility::flag_wait("FlagPopulateMarket");
	var_0E = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_04);
	common_scripts\utility::array_thread(var_0E,::initscanvariables);
	common_scripts\utility::flag_wait("init_safehouse_follow_lighting");
	maps\_utility::array_delete(var_0E);
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_06);
}

//Function Number: 50
spawnpotentialtargets()
{
	var_00 = getent("civilian_male","targetname");
	var_01 = common_scripts\utility::getstructarray("potential_target_node","targetname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_05 = var_00 maps\_utility::dronespawn();
		var_05.animname = "generic";
		var_02 = common_scripts\utility::add_to_array(var_02,var_05);
		var_00.count = 1;
		var_05.origin = var_04.origin;
		var_05.angles = var_04.angles;
		if(isdefined(var_04.script_noteworthy))
		{
			var_05.script_noteworthy = var_04.script_noteworthy;
		}

		wait(0.05);
		var_05 thread initscanvariables();
		var_05 thread potentialtargetanimations(var_04);
	}

	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_02);
}

//Function Number: 51
potentialtargetanimations(param_00)
{
	var_01 = param_00.animation;
	maps\_anim::anim_loop_solo(self,var_01);
}

//Function Number: 52
spawntempcivilians(param_00)
{
	var_01 = getent("civilian_temp","targetname");
	var_02 = common_scripts\utility::getstructarray("civ_temp_idle_nodes","targetname");
	var_03 = maps\_hms_greece_civilian::populatedronecivilians(var_01,var_02);
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::array_delete(var_03);
}

//Function Number: 53
spawndecoycivilians()
{
	var_00 = common_scripts\utility::getstruct("KVAtargetWalkOrg","targetname");
	for(var_01 = 1;var_01 < 9;var_01++)
	{
		var_02 = "MarketDecoy" + var_01;
		var_03 = getent(var_02,"targetname");
		if(isdefined(var_03))
		{
			thread marketdecoywalk(var_02,var_00,var_03);
			continue;
		}

		break;
	}
}

//Function Number: 54
marketdecoywalk(param_00,param_01,param_02)
{
	if(param_00 == "MarketDecoy3")
	{
		level waittill("MarketStartWalker03");
	}
	else if(param_00 == "MarketDecoy7")
	{
		return;
	}
	else if(param_00 == "MarketDecoy8")
	{
		level waittill("MarketStartWalker08");
	}

	var_03 = param_02 maps\_utility::spawn_ai(1);
	var_03 thread initscanvariables();
	var_03 maps\_utility::set_ignoreall(1);
	var_03.animname = param_00;
	thread maps\_hms_utility::debugprint3dcontinuous(param_00,var_03,"blue",1,600000,var_03,"death");
	param_01 maps\_anim::anim_single_solo(var_03,"hms_greece_market_decoy_walker");
	wait 0.05;
	switch(param_00)
	{
		case "MarketDecoy8":
		case "MarketDecoy6":
		case "MarketDecoy5":
		case "MarketDecoy4":
		case "MarketDecoy1":
			var_04 = getnodearray("MarketDecoyWalkerDeleteNode","targetname");
			var_05 = common_scripts\utility::getclosest(var_03.origin,var_04);
			var_03 maps\_utility::set_run_anim("civilian_slow_walk_male");
			var_03 maps\_utility::set_goal_node(var_05);
			var_03 maps\_utility::set_goal_radius(32);
			var_03 waittill("goal");
			var_03 delete();
			break;

		case "MarketDecoy7":
		case "MarketDecoy3":
		case "MarketDecoy2":
			var_03.animname = "generic";
			var_03 thread maps\_anim::anim_loop_solo(var_03,"london_civ_idle");
			common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
			var_03 delete();
			break;
	}
}

//Function Number: 55
spawnwalkingcivilians(param_00,param_01)
{
	var_02 = [];
	var_03 = getentarray("WalkingCivilian","targetname");
	if(param_01 == 1)
	{
		var_04 = getentarray("FirstWalkingCivilian","targetname");
		var_05 = maps\_utility::array_spawn(var_04,1);
		foreach(var_07 in var_05)
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_07);
			var_07 thread initscanvariables();
			var_07 thread deletewalkingcivilians(param_00);
		}

		var_03 = maps\_utility::array_merge(var_03,var_04);
		wait(1);
	}

	while(!common_scripts\utility::flag(param_00))
	{
		var_09 = common_scripts\utility::random(var_03);
		if(isdefined(level.cameralinkpoint))
		{
			var_0A = level.cameralinkpoint.origin;
		}
		else
		{
			var_0A = level.player geteye();
		}

		var_0B = level.player getplayerangles();
		if(!common_scripts\utility::within_fov(var_0A,var_0B,var_09.origin,cos(15)))
		{
			var_0C = var_09 maps\_utility::spawn_ai();
			if(isdefined(var_0C))
			{
				var_09.count = 1;
				var_02 = common_scripts\utility::add_to_array(var_02,var_0C);
				var_0C thread initscanvariables();
				var_0C thread deletewalkingcivilians(param_00);
				if(!common_scripts\utility::flag(param_00))
				{
					wait(randomfloatrange(6,10));
				}
			}
		}

		wait 0.05;
	}

	var_02 = maps\_utility::array_removedead_or_dying(var_02);
	maps\_utility::array_delete(var_02);
}

//Function Number: 56
deletewalkingcivilians(param_00)
{
	waittill_notify_or_flag(param_00,"goal");
	self delete();
}

//Function Number: 57
waittill_notify_or_flag(param_00,param_01)
{
	self endon(param_01);
	common_scripts\utility::flag_wait(param_00);
}

//Function Number: 58
spawnaddwalkers()
{
	thread spawnaddwalker("MarketAmbWalker1","MarketStartAmbWalker01","back","front",0);
	thread spawnaddwalker("MarketAmbWalker2","MarketStartAmbWalker02","left","left",0);
	thread spawnaddwalker("MarketAmbWalker3","MarketStartAmbWalker03","back","right",0);
	thread spawnaddwalker("MarketAmbWalker4","MarketStartAmbWalker04","left","front",0.1);
	thread spawnaddwalker("MarketAmbWalker5","MarketStartAmbWalker05","back","front",0);
	if(level.nextgen)
	{
		thread spawnaddwalker("MarketAmbWalker7","MarketStartAmbWalker07","right","front",0);
		thread spawnaddwalker("MarketAmbWalker8","MarketStartAmbWalker08","back","front",0);
		thread spawnaddwalker("MarketAmbWalker9","MarketStartAmbWalker09","left","right",0);
		thread spawnaddwalker("MarketAmbWalker10","MarketStartAmbWalker10","back","right",0);
		thread spawnaddwalker("MarketAmbWalker11","MarketStartAmbWalker11","right","right",0);
	}
}

//Function Number: 59
spawnaddwalker(param_00,param_01,param_02,param_03,param_04)
{
	level endon("FlagDeltaSafehouseCivilians");
	var_05 = getent(param_00,"targetname");
	var_06 = param_00 + "_start";
	var_07 = common_scripts\utility::getstruct(var_06,"targetname");
	var_08 = param_00 + "_end";
	var_09 = common_scripts\utility::getstruct(var_08,"targetname");
	var_0A = var_05 maps\_utility::spawn_ai(1);
	var_0A.animname = "generic";
	var_0A maps\_utility::set_ignoreall(1);
	var_0A.walk_override_weights = [];
	var_0A.walk_override_weights[0] = 1;
	var_0A.run_override_weights = [];
	var_0A.run_override_weights[0] = 1;
	var_0A maps\_utility::set_run_anim("civilian_slow_walk_male",1);
	var_0A thread initscanvariables();
	var_0A thread waitforwalkerdelete();
	thread maps\_hms_utility::debugprint3dcontinuous(param_00,var_0A,"green",1,600000,var_0A,"anim_reach_complete");
	var_07 thread maps\_anim::anim_loop_solo(var_0A,"london_civ_idle");
	level waittill(param_01);
	wait(param_04);
	var_07 notify("stop_loop");
	var_0A maps\_utility::anim_stopanimscripted();
	var_0B = undefined;
	switch(param_02)
	{
		case "back":
			var_0B = "civ_idletrans_out_b";
			break;

		case "left":
			var_0B = "civ_idletrans_out_l";
			break;

		case "right":
			var_0B = "civ_idletrans_out_r";
			break;
	}

	var_07 maps\_anim::anim_single_solo_run(var_0A,var_0B);
	var_0C = undefined;
	switch(param_03)
	{
		case "front":
			var_0C = "civ_idletrans_in_f";
			break;

		case "left":
			var_0C = "civ_idletrans_in_l";
			break;

		case "right":
			var_0C = "civ_idletrans_in_r";
			break;
	}

	if(isalive(var_0A))
	{
		var_09 maps\_anim::anim_reach_solo(var_0A,var_0C);
		var_09 maps\_anim::anim_single_solo(var_0A,var_0C);
		var_09 thread maps\_anim::anim_loop_solo(var_0A,"london_civ_idle");
	}
}

//Function Number: 60
waitforwalkerdelete()
{
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	self delete();
}

//Function Number: 61
initscanvariables()
{
	var_00 = 1000;
	var_01 = 2000;
	self.marked = 0;
	self.frequency = randomintrange(var_00,var_01);
	self.potentialtarget = 0;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "PotentialTarget")
	{
		self.potentialtarget = 1;
		level.potentialscantargets = common_scripts\utility::add_to_array(level.potentialscantargets,self);
	}
}

//Function Number: 62
cafewaiter()
{
	var_00 = getent("ilana_tea_cup","targetname");
	var_00.animname = "tea_cup";
	var_00 maps\_utility::assign_animtree("tea_cup");
	var_00 hide();
	common_scripts\utility::flag_wait("FlagSafeHouseIntro");
	var_01 = common_scripts\utility::getstruct("CafeWaiterOrg","targetname");
	var_02 = maps\_utility::spawn_targetname("IntroCafeWaiter",1);
	var_02 setmodel("civ_urban_male_waiter_body");
	var_02 thread codescripts\character::setheadmodel("head_m_act_afr_adams_base");
	var_02.animname = "waiter";
	var_00 show();
	var_01 thread maps\_anim::anim_single_solo(var_00,"hms_greece_market_intro");
	if(level.nextgen)
	{
		playfxontag(common_scripts\utility::getfx("steam_coffee"),var_00,"jnt_cup");
	}

	var_01 maps\_anim::anim_single_solo(var_02,"hms_greece_market_intro");
	var_02 delete();
}

//Function Number: 63
markethost()
{
	common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
	var_00 = common_scripts\utility::getstruct("CafeWaiterOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("marketHost",1);
	var_01 setmodel("civ_urban_male_body_f");
	var_01 thread codescripts\character::setheadmodel("head_m_gen_mde_smith");
	var_01.animname = "Host";
	wait(0.4);
	var_00 maps\_anim::anim_single_solo(var_01,"market_host_in");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"market_host_loop");
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	var_01 delete();
}

//Function Number: 64
cafeteasipper()
{
	var_00 = getent("tea_time_org","targetname");
	var_01 = maps\_utility::spawn_targetname("TeaGuy",1);
	var_01 setmodel("civ_urban_male_body_b");
	var_01 thread codescripts\character::setheadmodel("head_m_gen_cau_young");
	var_01.animname = "TeaGuy";
	var_02 = getent("tea_cup","targetname");
	var_02.animname = "tea_cup";
	var_02 maps\_utility::assign_animtree("tea_cup");
	var_03 = var_01 gettagorigin("TAG_WEAPON_RIGHT");
	var_04 = var_01 gettagangles("TAG_WEAPON_RIGHT");
	var_05 = (0,0,0);
	var_02.origin = var_03;
	var_02.angles = var_04;
	var_02 linkto(var_01,"TAG_WEAPON_RIGHT");
	var_06 = [var_01,var_02];
	var_02 thread maps\_anim::anim_loop_solo(var_02,"cafe_tea_time");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"cafe_tea_time");
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_06);
}

//Function Number: 65
marketvendor()
{
	common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
	var_00 = common_scripts\utility::getstruct("sweeperOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("MarketSweeper",1);
	var_01 setmodel("civ_urban_female_body_b");
	var_01 thread codescripts\character::setheadmodel("head_f_gen_cau_coyle");
	var_01.animname = "market_sweeper";
	var_02 = getent("market_broom","targetname");
	var_02.animname = "broom";
	var_02 maps\_utility::assign_animtree("broom");
	var_03 = [var_01,var_02];
	var_00 thread maps\_anim::anim_loop_solo(var_01,"market_vendor_sweep_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_02,"market_vendor_sweep_loop");
	var_04 = common_scripts\utility::getstruct("MarketVendorOrg","targetname");
	var_05 = maps\_utility::spawn_targetname("MarketVendor",1);
	var_05.animname = "market_vendor";
	var_05 setmodel("civ_african_male_body_d");
	var_05 thread codescripts\character::setheadmodel("head_m_act_afr_adams_base");
	var_06 = maps\_utility::spawn_anim_model("lemon01");
	var_07 = maps\_utility::spawn_anim_model("lemon02");
	var_08 = maps\_utility::spawn_anim_model("lemon03");
	var_09 = maps\_utility::spawn_anim_model("lemon04");
	var_0A = maps\_utility::spawn_anim_model("lemon05");
	var_0B = [var_06,var_07,var_08,var_09,var_0A];
	var_04 thread maps\_anim::anim_loop_solo(var_05,"market_vendor_loop");
	var_04 thread maps\_anim::anim_loop(var_0B,"market_vendor_lemons_loop");
	common_scripts\utility::flag_wait_either("FlagTriggerPlayerAtCafeWindow","FlagStartMarketCouple");
	var_0C = maps\_utility::spawn_targetname("MarketVendorMale",1);
	var_0C.animname = "market_male";
	var_0D = maps\_utility::spawn_targetname("MarketVendorFemale",1);
	var_0D.animname = "market_female";
	var_0E = maps\_utility::spawn_anim_model("lemon");
	var_0F = [var_0C,var_0D];
	var_04 maps\_anim::anim_single(var_0F,"market_vendor_in");
	var_04 thread maps\_anim::anim_loop(var_0F,"market_shopper_loop");
	var_04 thread maps\_anim::anim_loop_solo(var_0E,"market_shopper_loop");
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	var_05 delete();
	var_0C delete();
	var_0D delete();
	maps\_utility::array_delete(var_0B);
	maps\_utility::array_delete(var_03);
}

//Function Number: 66
cafesittingreader()
{
	var_00 = common_scripts\utility::getstructarray("CafeSittingReader","targetname");
	var_01 = getent("civilian_male","targetname");
	foreach(var_03 in var_00)
	{
		var_04 = var_01 maps\_utility::dronespawn();
		var_01.count = 1;
		var_04.animname = "generic";
		var_04.origin = var_03.origin;
		var_04.angles = var_03.angles;
		var_04 attach("greece_cafe_gps_pad","tag_inhand",1);
		var_04 thread cafesittingreaderplaynextanim("cafe_civ_sit_read_idle_01");
		var_04 thread waitforreaderdelete();
	}
}

//Function Number: 67
waitforreaderdelete()
{
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	self delete();
}

//Function Number: 68
cafesittingreaderchoosenextanim(param_00)
{
	level endon("FlagDeleteSafehouseCivilians");
	switch(param_00)
	{
		case "cafe_civ_sit_read_idle_01":
			self waittill("CurrentReadingAnimDone");
			cafesittingreaderplaynextanim("cafe_civ_sit_read_trans2crossed_01");
			break;

		case "cafe_civ_sit_read_trans2crossed_01":
			self waittill("CurrentReadingAnimDone");
			cafesittingreaderplaynextanim("cafe_civ_sit_read_idlecrossed_01");
			break;

		case "cafe_civ_sit_read_idlecrossed_01":
			if(common_scripts\utility::cointoss())
			{
				self waittill("CurrentReadingAnimDone");
				cafesittingreaderplaynextanim("cafe_civ_sit_read_trans2sit_01");
			}
			else
			{
				self waittill("CurrentReadingAnimDone");
				cafesittingreaderplaynextanim("cafe_civ_sit_read_trans2sit_long_01");
			}
			break;

		case "cafe_civ_sit_read_trans2sit_01":
			self waittill("CurrentReadingAnimDone");
			cafesittingreaderplaynextanim("cafe_civ_sit_read_idle_01");
			break;

		case "cafe_civ_sit_read_trans2sit_long_01":
			if(common_scripts\utility::cointoss())
			{
				self waittill("CurrentReadingAnimDone");
				cafesittingreaderplaynextanim("cafe_civ_sit_read_trans2crossed_01");
			}
			else
			{
				self waittill("CurrentReadingAnimDone");
				cafesittingreaderplaynextanim("cafe_civ_sit_read_idle_01");
			}
			break;
	}
}

//Function Number: 69
cafesittingreaderplaynextanim(param_00)
{
	thread cafesittingreaderchoosenextanim(param_00);
	maps\_anim::anim_single_solo(self,param_00);
	self notify("CurrentReadingAnimDone");
}

//Function Number: 70
cafecivilianmeetandgreet()
{
	var_00 = maps\_utility::spawn_targetname("MaleGreet",1);
	var_00 setmodel("civ_urban_male_body_c");
	var_00 thread codescripts\character::setheadmodel("head_m_gen_asi_pease");
	var_00.animname = "greet_male";
	var_01 = maps\_utility::spawn_targetname("FemaleGreet",1);
	var_01 setmodel("civ_urban_female_body_b_blue_afr_light");
	var_01 thread codescripts\character::setheadmodel("head_f_gen_afr_rice");
	var_01.animname = "greet_female";
	var_02 = getent("Menu1","targetname");
	var_03 = getent("Menu2","targetname");
	var_02 maps\_utility::assign_animtree("market_menu1");
	var_03 maps\_utility::assign_animtree("market_menu2");
	var_02.animname = "market_menu1";
	var_03.animname = "market_menu2";
	var_04 = [var_00,var_02];
	var_05 = [var_01,var_03];
	var_06 = "cafe_meet_02_trans_in_guy1";
	var_07 = "cafe_meet_02_trans_in_fem";
	var_08 = "cafe_meet_02_loop_guy1";
	var_09 = "cafe_meet_02_loop_fem";
	var_0A = getent("CafeMeet02AnimOrg","targetname");
	var_0A thread maps\_anim::anim_first_frame_solo(var_02,"cafe_meet_02_trans_in_guy1");
	var_0A thread maps\_anim::anim_loop(var_05,var_09,"Guy2StopLoopAndGreet");
	var_00 hide();
	common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
	var_00 show();
	wait(6);
	var_0A maps\_anim::anim_reach_solo(var_00,var_06);
	var_0A notify("Guy2StopLoopAndGreet");
	var_0A thread maps\_anim::anim_single(var_04,var_06);
	var_0A maps\_anim::anim_single(var_05,var_07);
	var_0A thread maps\_anim::anim_loop(var_04,var_08);
	var_0A thread maps\_anim::anim_loop(var_05,var_09);
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	maps\_utility::array_delete(var_04);
	maps\_utility::array_delete(var_05);
}

//Function Number: 71
cafesetupplayerseat()
{
	level endon("lazy_mission_end");
	common_scripts\utility::flag_wait("FlagSafeHouseIntro");
	thread cafeinitvendorgate();
	level.player lerpfov(50,0);
	var_00 = common_scripts\utility::getstruct("PlayerVBCafeStruct","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_cafe_rig",level.player.origin,level.player.angles);
	var_02 = maps\_utility::spawn_anim_model("cafe_control_pad",var_00.origin);
	var_03 = maps\_utility::spawn_anim_model("backpack_drone_large",var_00.origin);
	var_00 thread maps\_anim::anim_first_frame_solo(var_03,"hms_greece_market_intro");
	var_00 thread maps\_anim::anim_single_solo(var_03,"hms_greece_market_intro");
	var_04 = maps\_utility::spawn_anim_model("player_chair",var_00.origin);
	var_00 thread maps\_anim::anim_single_solo(var_04,"hms_greece_market_intro");
	level.player playerlinktoblend(var_01,"tag_player",0.1);
	thread cafeplayercameralook(var_01);
	var_05 = [var_01,var_02];
	var_00 maps\_anim::anim_single(var_05,"hms_greece_market_intro");
	level notify("MarketIntroExpandCamControl");
	var_00 thread maps\_anim::anim_loop(var_05,"hms_greece_market_intro_loop","PlayerCafeSittingEnder");
	common_scripts\utility::flag_set("FlagSetObjScanTarget");
	common_scripts\utility::flag_set("FlagScanTargetEnable");
	thread maps\greece_safehouse_vo::scaninitremindermonitor();
	thread maps\_utility::hintdisplayhandler("cafe_scan",undefined,undefined,undefined,undefined,200);
	for(;;)
	{
		if(level.player usebuttonpressed())
		{
			break;
		}

		wait 0.05;
	}

	level notify("PlayerInitiateScan");
	common_scripts\utility::flag_set("FlagScanRemoveHint");
	thread maps\_utility::autosave_by_name("safehouse_market_scan_begin");
	level.player playerlinktoblend(var_01,"tag_player",1);
	var_00 notify("PlayerCafeSittingEnder");
	var_01 maps\_utility::anim_stopanimscripted();
	var_00 thread maps\_anim::anim_single(var_05,"hms_greece_market_intro_activate");
	wait(3.15);
	level.player disableslowaim();
	common_scripts\utility::flag_set("FlagPopulateMarket");
	maps\greece_security_camera::scanfadeintro();
	wait(1);
	common_scripts\utility::flag_set("FlagScanTargetBegin");
	thread cafecameraumbrella();
	thread spawnkvafollowtarget();
	thread spawnwalkingcivilians("FlagDeleteMarketFirstWalkers",1);
	level.player thread maps\greece_security_camera::securitycameraenable();
	level.bplayerscanon = 1;
	soundscripts\_snd::snd_message("mhunt_cafe_cam_enter_front");
	thread cafecamerascancounter();
	thread marketkvafollowtargettimer();
	var_06 = common_scripts\utility::getstruct("mitchellOrg","targetname");
	var_07 = maps\_utility::spawn_anim_model("Mitchell",var_00.origin);
	var_07 maps\_utility::assign_animtree("Mitchell");
	var_07 setmodel("civ_urban_male_body_b");
	var_07 thread codescripts\character::setheadmodel("head_civ_sf_male_c");
	var_07.animname = "Mitchell";
	var_06 thread maps\_anim::anim_loop_solo(var_07,"Mitchell_scanning");
	common_scripts\utility::flag_wait("FlagScanTargetComplete");
	var_07 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
	thread cafeendcamerascan(var_04);
}

//Function Number: 72
hintcamerascanoff()
{
	return common_scripts\utility::flag("FlagScanRemoveHint");
}

//Function Number: 73
hintcamerazoomoff()
{
	return common_scripts\utility::flag("FlagFollowTargetMarked");
}

//Function Number: 74
cafeplayercameralook(param_00)
{
	level waittill("MarketIntroUnlockCamControl");
	level.player playerlinktoblend(param_00,"tag_player",0.1);
	level.player playerlinktodelta(param_00,"tag_player",0,10,10,10,10,0,0);
	level.player enableslowaim(0.1,0.1);
	level waittill("MarketIntroExpandCamControl");
	level.player playerlinktodelta(param_00,"tag_player",0,45,40,30,25,0,0);
	level.player enableslowaim(0.2,0.2);
}

//Function Number: 75
cafecamerascancounter()
{
	var_00 = 0;
	level.player endon("DisableScanning");
	for(;;)
	{
		if(var_00 == 1)
		{
			common_scripts\utility::flag_set("FlagCafeCameraUnlockSwitching");
		}
		else if(var_00 < 1)
		{
			level.player waittill("CafeScanResultsNegative");
			var_00++;
		}

		wait(0.05);
	}
}

//Function Number: 76
cafeendcamerascan(param_00)
{
	common_scripts\utility::flag_wait("FlagScanTargetComplete");
	level.bplayerscanon = 0;
	level.player maps\greece_security_camera::securitycameradisable();
	soundscripts\_snd::snd_message("mhunt_cafe_cam_exit_front");
	maps\greece_code::setdefaulthudoutlinedvars();
	common_scripts\utility::flag_set("FlagSafeHouseFollowStart");
	level.player lerpfov(50,0);
	if(!common_scripts\utility::flag("FlagFollowTargetReachedFirstStop"))
	{
		level notify("market_target_teleport");
		wait 0.05;
		level.kvafollowtarget maps\_utility::anim_stopanimscripted();
		thread marketkvafollowtargetwalk2();
	}

	var_01 = common_scripts\utility::getstruct("PlayerVBCafeStruct","targetname");
	var_02 = maps\_utility::spawn_anim_model("player_cafe_rig",var_01.origin);
	var_03 = maps\_utility::spawn_anim_model("cafe_control_pad",var_01.origin);
	var_04 = maps\_utility::spawn_anim_model("backpack_drone_large",var_01.origin);
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::spawn_anim_model("player_chair",var_01.origin);
	}

	var_05 = [var_02,var_03,var_04];
	var_01 thread maps\_anim::anim_first_frame_solo(param_00,"hms_greece_market_outro");
	var_01 maps\_anim::anim_first_frame(var_05,"hms_greece_market_outro");
	level.player unlink();
	wait 0.05;
	level.player playerlinktoblend(var_02,"tag_player",0.1);
	thread maps\greece_security_camera::scanfadeoutro();
	wait(0.4);
	thread cafeintrofov();
	thread cafevideolog();
	var_01 thread maps\_anim::anim_single_solo(param_00,"hms_greece_market_outro");
	var_01 maps\_anim::anim_single(var_05,"hms_greece_market_outro");
	level.player unlink();
	var_02 delete();
	var_03 delete();
	var_04 delete();
	thread maps\_utility::autosave_by_name("safehouse_market_follow");
	common_scripts\utility::flag_set("FlagSetObjFollowTarget");
	common_scripts\utility::flag_set("FlagStartCafeVideoLog");
}

//Function Number: 77
cafevideolog()
{
	thread maps\greece_vo::cafe_irons_speech_bink();
	common_scripts\utility::flag_wait("FlagStartCafeVideoLog");
	maps\_shg_utility::play_videolog("manhunt_videolog_02","screen_add");
	thread soundscripts\_snd::snd_message("start_kva_follow_music");
	common_scripts\utility::flag_set("FlagCafeVideologComplete");
}

//Function Number: 78
cafeintrofov()
{
	level waittill("CafeTransitionBackFOV");
	level.player lerpfov(65,0.5);
}

//Function Number: 79
cafesetuptouristilana()
{
	level.allies["Ilona"] maps\_utility::set_run_anim("civilian_hurried_walk",1);
	level.allies["Ilona"] maps\_utility::set_idle_anim("london_station_civ1_idle");
	level.allies["Ilona"] maps\_utility::gun_remove();
	level.allies["Ilona"].disablefacialfilleranims = 1;
	level.allies["Ilona"] thread safehouseilanaweaponshot();
}

//Function Number: 80
cafesetupilanabackpack()
{
	self setmodel("body_ilana_civilian_backpack");
	self waittill("DeleteIlanaBackpack");
	self setmodel("body_ilana_civilian");
}

//Function Number: 81
cafeilanaseat()
{
	var_00 = common_scripts\utility::getstruct("IlanaCafeMove1Struct","targetname");
	var_01 = getent("ilana_tea_cup","targetname");
	var_01.animname = "tea_cup";
	var_01 maps\_utility::assign_animtree("tea_cup");
	var_02 = level.allies["Ilona"];
	var_03 = maps\_utility::spawn_anim_model("backpack_drone_small",var_00.origin);
	var_00 thread maps\_anim::anim_first_frame_solo(var_03,"hms_greece_market_intro");
	var_00 thread maps\_anim::anim_single_solo(var_03,"hms_greece_market_intro");
	var_04 = maps\_utility::spawn_anim_model("ilana_chair",var_00.origin);
	var_00 thread maps\_anim::anim_first_frame_solo(var_04,"hms_greece_market_intro");
	var_00 thread maps\_anim::anim_single_solo(var_04,"hms_greece_market_intro");
	var_02.disablefacialfilleranims = 1;
	var_00 maps\_anim::anim_single_solo(var_02,"hms_greece_market_intro");
	var_00 thread maps\_anim::anim_loop_solo(var_02,"hms_greece_market_intro_loop","IlanaMarketEnder1");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"hms_greece_market_intro_loop","IlanaMarketEnder1");
	common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
	var_00 notify("IlanaMarketEnder1");
	var_02 maps\_utility::anim_stopanimscripted();
	thread cafemarketmoveilana(var_03,var_04);
}

//Function Number: 82
cafeinitvendorgate()
{
	var_00 = common_scripts\utility::getstruct("IlanaCafeMove4Struct","targetname");
	var_01 = getent("MarketIlanaExitGate","targetname");
	var_01.animname = "vendorgate";
	var_01 maps\_utility::assign_animtree("vendorgate");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"hms_greece_market_vendor_exit");
}

//Function Number: 83
cafemarketmoveilana(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstruct("IlanaCafeMove1Struct","targetname");
	var_04 = common_scripts\utility::getstruct("IlanaCafeMove2Struct","targetname");
	var_05 = common_scripts\utility::getstruct("IlanaCafeMove3Struct","targetname");
	var_06 = common_scripts\utility::getstruct("IlanaCafeMove4Struct","targetname");
	var_07 = common_scripts\utility::getstruct("CafeWaiterOrg","targetname");
	var_08 = level.allies["Ilona"];
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::spawn_anim_model("backpack_drone_small",var_03.origin);
	}

	if(!isdefined(param_01))
	{
		param_01 = maps\_utility::spawn_anim_model("ilana_chair",var_03.origin);
	}

	if(!isdefined(param_02))
	{
		param_02 = getent("ilana_tea_cup","targetname");
		param_02.animname = "tea_cup";
		param_02 maps\_utility::assign_animtree("tea_cup");
	}

	var_09 = getent("MarketIlanaExitGate","targetname");
	var_0A = [var_08,param_00];
	var_04 maps\_anim::anim_first_frame(var_0A,"hms_greece_market_outro");
	wait(0.4);
	thread cafeoutrositter();
	var_08.disablefacialfilleranims = 0;
	param_02 show();
	var_07 thread maps\_anim::anim_single_solo(param_02,"hms_greece_market_outro");
	var_04 thread maps\_anim::anim_single_solo(param_01,"hms_greece_market_outro");
	var_04 maps\_anim::anim_single(var_0A,"hms_greece_market_outro");
	var_05 thread maps\_anim::anim_loop(var_0A,"hms_greece_market_vendor_loop","IlanaMarketEnder3");
	common_scripts\utility::flag_wait_all("FlagTriggerPlayerMidMarket","FlagMarketCoupleAtGoal","FlagCafeVideologComplete");
	common_scripts\utility::flag_set("FlagIlanaMidMarketStartMoving");
	thread cafemarketslowdownplayermore();
	var_05 notify("IlanaMarketEnder3");
	var_08.disablefacialfilleranims = 0;
	var_06 thread maps\_anim::anim_single_solo(var_09,"hms_greece_market_vendor_exit");
	var_06 maps\_anim::anim_single(var_0A,"hms_greece_market_vendor_exit");
	level.allies["Ilona"] notify("IlanaExitMarket");
	var_0B = level.allies["Ilona"].goalradius;
	level.allies["Ilona"].goalradius = 16;
	level.allies["Ilona"] maps\_utility::set_goal_node_targetname("MarketIlanaDisappearNode");
	level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
	param_00 delete();
	level.allies["Ilona"] waittill("goal");
	var_0C = getnode("MarketIlanaBackAlleyWait","targetname");
	level.allies["Ilona"] maps\_utility::teleport_ai(var_0C);
	common_scripts\utility::flag_set("FlagSafehouseIlanaTeleportToBack");
	wait 0.05;
	level.allies["Ilona"].goalradius = var_0B;
	level.allies["Ilona"] thread cafesetupilanabackpack();
	common_scripts\utility::flag_wait("FlagFollowTargetKilled");
	thread safehouseilanaclearsafehouse();
}

//Function Number: 84
cafemarketslowdownplayermore()
{
	if(!common_scripts\utility::flag("FlagKVATargetInAlley"))
	{
		level.player notify("CancelMoveSpeedScale");
		wait 0.05;
		level.player thread playerrubberbandmovespeedscale(level.kvafollowtarget,0.1,0.5,400,1000);
		common_scripts\utility::flag_wait("FlagKVATargetInAlley");
		wait(1);
	}

	common_scripts\utility::flag_wait("FlagSafehouseIlanaTeleportToBack");
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player playerchangemode("no_combat_fast");
	level.player thread playerrubberbandmovespeedscale(level.kvafollowtarget,0.2,0.5,200,800);
}

//Function Number: 85
cafeoutrositter()
{
	var_00 = common_scripts\utility::getstruct("CafeSitterOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("OutroCafeSitter",1);
	var_01 setmodel("civ_urban_male_body_e");
	var_01 thread codescripts\character::setheadmodel("head_m_act_cau_kanik_base");
	var_01.animname = "sitter";
	var_02 = maps\_utility::spawn_anim_model("sitter_chair",var_00.origin);
	var_03 = common_scripts\utility::getstruct("CafeSitterPartnerOrg","targetname");
	var_04 = getent("civilian_female","targetname");
	var_05 = var_04 maps\_utility::dronespawn();
	var_04.count = 1;
	var_05.origin = var_03.origin;
	var_05.angles = var_03.angles;
	var_06 = ["civ_urban_female_body_b_yellow","civ_urban_female_body_b_olive","civ_urban_female_body_e_gold","civ_urban_female_body_b_blue","civ_urban_female_body_d"];
	var_07 = ["head_f_gen_cau_peterson","head_f_act_cau_hamilton_base","head_f_gen_cau_giovanni","head_f_gen_cau_withers","head_f_gen_cau_coyle"];
	var_08 = common_scripts\utility::random(var_07);
	var_09 = common_scripts\utility::random(var_06);
	var_05 thread codescripts\character::setheadmodel(var_08);
	var_05 setmodel(var_09);
	var_05.animname = "generic";
	var_0A = var_03.animation;
	var_03 thread maps\_anim::anim_generic_loop(var_05,var_0A);
	var_00 thread maps\_anim::anim_single_solo(var_02,"hms_greece_market_outro");
	var_00 maps\_anim::anim_single_solo(var_01,"hms_greece_market_outro");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"hms_greece_market_outro_loop");
	common_scripts\utility::flag_wait("FlagDeleteSafehouseCivilians");
	var_01 delete();
	var_05 delete();
}

//Function Number: 86
cafemarketilanabackyardwait()
{
	var_00 = common_scripts\utility::getstruct("IlanaBackCourtyardWait","targetname");
	var_01 = "london_guard_idle1";
	var_00 maps\_anim::anim_reach_solo(self,var_01);
	var_00 thread maps\_anim::anim_loop_solo(self,var_01,"IlanaStopBackyardWait");
	common_scripts\utility::flag_wait("FlagSafehouseMeleeKillInitiated");
	var_00 notify("IlanaStopBackyardWait");
	maps\_utility::anim_stopanimscripted();
}

//Function Number: 87
cafemarketplayerfollowtarget()
{
	common_scripts\utility::flag_wait("FlagFollowTargetReachedFinalStop");
	common_scripts\utility::flag_set("FlagSafeHouseKillStart");
}

//Function Number: 88
marketenemyinit()
{
	self.maxvisibledist = 0.1;
	self.health = 1;
	self.fovcosine = cos(80);
	maps\_utility::set_goalradius(32);
	maps\_utility::gun_remove();
	maps\_utility::set_ignoreall(1);
	self.animname = "KeyMan";
	self.script_parameters = "KeyMan";
	maps\_utility::disable_exits();
	maps\_utility::disable_arrivals();
	maps\_utility::set_idle_anim("civilian_stand_idle");
	maps\_utility::set_run_anim("civilian_cool_walk",1);
	maps\_utility::disable_surprise();
	self.battlechatter = 0;
	thread maps\greece_code::clearalertoutline();
}

//Function Number: 89
safehousetranstoalleygatesetup()
{
	var_00 = common_scripts\utility::getstruct("gateOrg","targetname");
	var_01 = getent("greece_alley_gate","targetname");
	var_01 maps\_utility::assign_animtree("alley_gate");
	var_01.animname = "alley_gate";
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"safehouse_gate_bash");
}

//Function Number: 90
marketmovekvafollowtarget()
{
	self endon("death");
	var_00 = level.start_point;
	if(var_00 == "start_safehouse_follow")
	{
		var_01 = getent("KVAFollowTargetTeleport1","targetname");
		level.kvafollowtarget forceteleport(var_01.origin,var_01.angles);
		return;
	}

	if(var_00 == "start_safehouse_xslice")
	{
		var_01 = getent("KVAFollowTargetTeleport2","targetname");
		level.kvafollowtarget forceteleport(var_01.origin,var_01.angles);
		thread marketkvafollowtargetkill();
		return;
	}

	thread marketkvafollowtargetwalk1();
}

//Function Number: 91
failtargetescaped1()
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - TARGET ESCAPED!!!");
	level notify("lazy_mission_end");
	common_scripts\utility::flag_set("FlagScanRemoveHint");
	maps\greece_safehouse_vo::safehousefailtargetescaped();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_MARKET_TARGETESCAPE1_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 92
failtargetescaped2()
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - TARGET ESCAPED!!!");
	level notify("lazy_mission_end");
	maps\greece_safehouse_vo::safehousefailtargetescaped();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_MARKET_TARGETESCAPE2_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 93
failtargetescaped3()
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - TARGET ESCAPED!!!");
	level notify("lazy_mission_end");
	maps\greece_safehouse_vo::safehousefailtargetescaped();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_MARKET_TARGETESCAPE3_FAIL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 94
marketkvafollowtargetwalk1()
{
	level endon("market_target_teleport");
	var_00 = common_scripts\utility::getstruct("KVAtargetWalkOrg","targetname");
	level waittill("MarketCameraSwitch");
	thread spawnaddwalkers();
	thread spawndecoycivilians();
	common_scripts\utility::flag_set("FlagDeleteMarketFirstWalkers");
	var_00 maps\_anim::anim_single_solo(level.kvafollowtarget,"hms_greece_market_target_walk");
	common_scripts\utility::flag_set("FlagFollowTargetReachedFirstStop");
	thread marketkvafollowtargetwalk2();
}

//Function Number: 95
marketkvafollowtargetwalk2()
{
	var_00 = common_scripts\utility::getstruct("KVAtargetWalkOrg","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.kvafollowtarget,"hms_greece_market_target_idle","KVAFollowTargetStopIdle");
	common_scripts\utility::flag_wait_either("FlagTriggerStartKVATargetWalkExit","FlagKVATargetWaitTimerExpired");
	var_00 notify("KVAFollowTargetStopIdle");
	level.kvafollowtarget maps\_utility::anim_stopanimscripted();
	thread monitorkvatargetinalley();
	thread marketkvafollowtargetgate();
	var_00 maps\_anim::anim_single_solo(level.kvafollowtarget,"hms_greece_market_target_exit");
	level.kvafollowtarget notify("badplace_end");
	common_scripts\utility::flag_set("FlagFollowTargetReachedSecondStop");
	thread marketkvafollowtargetkill();
}

//Function Number: 96
marketkvafollowtargetgate()
{
	var_00 = common_scripts\utility::getstruct("marketgateOrg","targetname");
	var_01 = getent("market_gate","targetname");
	var_01.animname = "marketgate";
	var_01 maps\_utility::assign_animtree("marketgate");
	var_00 maps\_anim::anim_single_solo(var_01,"hms_greece_market_target_exit");
}

//Function Number: 97
monitorkvatargetinalley()
{
	var_00 = getent("TrigKVATargetInAlley","targetname");
	for(;;)
	{
		if(level.kvafollowtarget istouching(var_00))
		{
			break;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("FlagKVATargetInAlley");
}

//Function Number: 98
marketkvafollowtargettimer()
{
	var_00 = [];
	var_00[0] = 180;
	var_00[1] = 120;
	var_00[2] = 90;
	var_00[3] = 45;
	level.markettimewindow = var_00[level.gameskill];
	var_01 = maps\_hud_util::get_countdown_hud();
	var_01.label = &"GREECE_MARKET_TIMER_LABEL_CAPS";
	var_01.x = -110;
	var_01.y = 45;
	var_01.alignx = "left";
	var_01.horzalign = "center";
	var_01.color = (0.95,0.95,1);
	var_01 setpulsefx(30,900000,700);
	var_01 settenthstimer(level.markettimewindow);
	thread freezemarkettimer(var_01);
	thread maps\greece_safehouse_vo::scantakestoolongmonitor();
	thread marketscanautohighlight();
	thread monitorfollowtargetescape();
	wait(level.markettimewindow + 3);
	if(!common_scripts\utility::flag("FlagFollowTargetMarked"))
	{
		common_scripts\utility::flag_set("FlagKVATargetWaitTimerExpired");
		level notify("MarketTimerExpired");
		level.player notify("DisableScanning");
		wait(3);
		destroymarkettimer(var_01);
	}
}

//Function Number: 99
freezemarkettimer(param_00)
{
	level endon("MarketTimerExpired");
	var_01 = gettime();
	common_scripts\utility::flag_wait("FlagFollowTargetMarked");
	var_02 = gettime();
	var_03 = var_02 - var_01 * 0.001;
	var_04 = level.markettimewindow - var_03;
	if(var_04 <= 0)
	{
		var_04 = 0.01;
	}

	param_00 settenthstimerstatic(var_04);
	wait(3);
	destroymarkettimer(param_00);
}

//Function Number: 100
destroymarkettimer(param_00)
{
	if(isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 101
marketscanautohighlight()
{
	if(level.gameskill <= 1)
	{
		wait(level.markettimewindow - level.markettimewindow / 4);
		if(!common_scripts\utility::flag("FlagFollowTargetMarked"))
		{
			foreach(var_01 in level.potentialscantargets)
			{
				var_01 hudoutlineenable(5,0);
			}
		}
	}
}

//Function Number: 102
monitorfollowtargetescape()
{
	level waittill("MarketTimerExpired");
	if(!common_scripts\utility::flag("FlagFollowTargetMarked"))
	{
		thread failtargetescaped1();
	}
}

//Function Number: 103
marketguybadplace()
{
	level endon("lazy_mission_end");
	if(!isdefined(self.hasbadplace) || self.hasbadplace == 0)
	{
		self.hasbadplace = 1;
		createmovingbadplace();
	}
}

//Function Number: 104
createmovingbadplace()
{
	level endon("lazy_mission_end");
	self endon("badplace_end");
	var_00 = 1;
	var_01 = 128;
	for(;;)
	{
		var_02 = anglestoforward(self.angles);
		badplace_arc(self.script_noteworthy + "arc",var_00,self.origin,64,var_01,var_02,15,15,"neutral","allies");
		badplace_cylinder(self.script_noteworthy + "cyl",var_00,self.origin,32,var_01,"neutral","allies");
		wait(var_00 + 0.05);
	}
}

//Function Number: 105
marketkvafollowtargetkill()
{
	var_00 = level.allies["Ilona"];
	var_01 = level.kvafollowtarget;
	var_02 = getent("SafehouseKVAAmbusher","targetname");
	var_03 = var_02 maps\_utility::spawn_ai(1);
	var_03 setmodel("kva_civilian_a_ambusher");
	var_03.animname = "Victim";
	var_03.script_parameters = "Victim";
	var_03.fovcosine = cos(60);
	var_03 maps\_utility::gun_remove();
	var_00.disablefacialfilleranims = 0;
	var_04 = "courtyard_takedown_enter";
	var_05 = "courtyard_takedown_idle";
	var_06 = "courtyard_takedown";
	var_07 = getent("safehouse_pillow","targetname");
	var_07 hide();
	var_08 = [var_03,var_01];
	var_09 = common_scripts\utility::getstruct("SafehouseCourtyardTakedownOrg","targetname");
	var_01 thread setupaiforanimsequence();
	var_03 thread setupaiforanimsequence();
	level.kvafollowtarget attach("weapon_parabolic_knife","TAG_WEAPON_RIGHT",1);
	var_09 thread maps\_anim::anim_loop_solo(var_03,var_05,"StartSafehouseTakedown");
	common_scripts\utility::flag_set("FlagChangeObjFollowTarget");
	var_01 thread safehousecourtyardtakedownknifenpc(var_09,var_04,var_05);
	common_scripts\utility::flag_wait("FlagTriggerStartIlanaTakedownEnter");
	var_09 maps\_anim::anim_single_solo(var_00,var_04);
	var_09 thread maps\_anim::anim_loop_solo(var_00,var_05,"StartSafehouseTakedown");
	level.player thread marketkvafollowtargetbuttoncapture(var_09);
	var_01 thread maps\greece_safehouse_vo::safehousekillreminder();
	var_01 thread marketkvafollowtargetstopidle(var_09);
	var_03 thread marketkvaambusherstopidle(var_09);
	var_00 thread safehousecourtyardtakedownilonafail(var_09);
	foreach(var_0B in var_08)
	{
		var_0B thread marketkvafollowtargetalertmonitor();
		var_0B thread safehousecourtyardsightwatch();
	}

	common_scripts\utility::flag_wait("FlagSafehouseMeleeKillInitiated");
	level notify("PlayerInitiateKeyManKill");
	level notify("CourtyardDistractionDialogInterrupt");
	level.player notify("CancelMoveSpeedScale");
	level.kvafollowtarget notify("remove_outline");
	common_scripts\utility::flag_set("FlagClearObjFollowTarget");
	level.player hideviewmodel();
	var_0D = maps\_utility::spawn_anim_model("player_cafe_rig",level.player.origin);
	var_0D hide();
	maps\greece_safehouse_fx::guarddustdrag();
	var_09 maps\_anim::anim_first_frame_solo(var_0D,var_06);
	level.player playerlinktoblend(var_0D,"tag_player",0.4);
	wait(0.4);
	var_0D show();
	if(level.currentgen)
	{
		if(istransientloaded("greece_market_audio_tr"))
		{
			level notify("tff_unload_market_audio");
			unloadtransient("greece_market_audio_tr");
		}
	}

	var_09 thread maps\_anim::anim_single(var_08,var_06);
	var_09 thread maps\_anim::anim_single_solo(var_0D,var_06);
	thread safehousetakedownreturnplayercontrol(getanimlength(var_0D maps\_utility::getanim(var_06)),var_0D);
	level.kvafollowtarget thread safehousekvafollowtargetdeath(getanimlength(level.kvafollowtarget maps\_utility::getanim(var_06)));
	var_03 thread safehousekvafollowtargetdeath(getanimlength(var_03 maps\_utility::getanim(var_06)));
	thread safehousecourtyardtakedownprops();
	soundscripts\_snd::snd_message("start_safehouse_stealth_music");
	var_09 maps\_anim::anim_single_solo(var_00,var_06);
	thread safehouseilanaopendooridle();
	common_scripts\utility::flag_set("FlagFollowTargetUnmarked");
}

//Function Number: 106
safehousecourtyardtakedownknifenpc(param_00,param_01,param_02)
{
	param_00 thread maps\_anim::anim_loop_solo(self,param_02,"StopKnifeNPCLoop");
	common_scripts\utility::flag_wait("FlagTriggerStartIlanaTakedownEnter");
	wait(0.1);
	param_00 notify("StopKnifeNPCLoop");
	maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(self,param_01);
	param_00 thread maps\_anim::anim_loop_solo(self,param_02,"StartSafehouseTakedown");
}

//Function Number: 107
safehousecourtyardtakedownilonafail(param_00)
{
	common_scripts\utility::flag_wait("FlagTriggerStartTakedownTimer");
	level common_scripts\utility::waittill_either("CourtyardDistractionDialogComplete","SafehouseTakedownAlert");
	wait(0.1);
	if(common_scripts\utility::flag("FlagSafehouseMeleeKillInitiated"))
	{
		return;
	}

	param_00 notify("StartSafehouseTakedown");
	self notify("stop_talking");
	wait 0.05;
	param_00 maps\_anim::anim_single_solo(self,"courtyard_takedown_fail");
}

//Function Number: 108
safehousecourtyardtakedownprops()
{
	level waittill("CourtyardTakedownUnholsterWeapon");
	level.allies["Ilona"] maps\_utility::forceuseweapon("iw5_titan45_sp_opticsreddot_silencerpistol","primary");
	level.allies["Ilona"] maps\_utility::gun_recall();
}

//Function Number: 109
marketkvafollowtargetstopidle(param_00)
{
	common_scripts\utility::flag_wait("FlagTriggerStartTakedownTimer");
	level common_scripts\utility::waittill_either("CourtyardDistractionDialogComplete","SafehouseTakedownAlert");
	level notify("CourtyardDistractionDialogInterrupt");
	wait(0.1);
	if(common_scripts\utility::flag("FlagSafehouseMeleeKillInitiated"))
	{
		return;
	}

	if(common_scripts\utility::flag("FlagFollowTargetUnmarked"))
	{
		return;
	}

	param_00 notify("StartSafehouseTakedown");
	thread marketkvafollowtargetalerted(param_00);
	common_scripts\utility::flag_set("FlagClearObjFollowTarget");
	common_scripts\utility::flag_set("FlagFollowTargetUnmarked");
	common_scripts\utility::trigger_off("UseTriggerKillKVAfollowTarget","targetname");
}

//Function Number: 110
marketkvaambusherstopidle(param_00)
{
	level common_scripts\utility::waittill_either("CourtyardDistractionDialogComplete","SafehouseTakedownAlert");
	level notify("CourtyardDistractionDialogInterrupt");
	wait(0.1);
	if(common_scripts\utility::flag("FlagSafehouseMeleeKillInitiated"))
	{
		return;
	}

	param_00 notify("StartSafehouseTakedown");
	self notify("stop_talking");
	wait 0.05;
	param_00 maps\_anim::anim_single_solo(self,"courtyard_takedown_fail");
	self.surprisedbymedistsq = 1;
	self stopanimscripted();
	self.combatmode = "no_cover";
	maps\_utility::set_goalradius(512);
	self.battlechatter = 1;
	self.allowdeath = 1;
	self.maxvisibledist = 1;
	self.health = 100;
	maps\_utility::set_favoriteenemy(level.allies["Ilona"]);
	maps\_utility::enable_arrivals();
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::clear_generic_run_anim();
}

//Function Number: 111
marketkvafollowtargetnecksnaprumble(param_00)
{
	level.player playrumbleonentity("damage_heavy");
	wait(1);
	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}

//Function Number: 112
marketkvafollowtargetalerted(param_00)
{
	level notify("KVAFollowTargetAlerted");
	self notify("remove_outline");
	common_scripts\utility::flag_set("FlagFollowTargetUnmarked");
	common_scripts\utility::trigger_off("UseTriggerKillKVAfollowTarget","targetname");
	self notify("stop_talking");
	param_00 maps\_anim::anim_single_solo(self,"courtyard_takedown_fail");
	self.surprisedbymedistsq = 1;
	self stopanimscripted();
	maps\_utility::disable_dontevershoot();
	self.combatmode = "no_cover";
	maps\_utility::set_goalradius(512);
	self.battlechatter = 1;
	self.allowdeath = 1;
	self.ignoreall = 0;
	self.maxvisibledist = 1;
	self.health = 100;
	maps\_utility::enable_arrivals();
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::clear_generic_run_anim();
	if(!common_scripts\utility::flag("FlagSafehouseMeleeKillInitiated"))
	{
		maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - KVA ALERTED!!!");
		thread maps\greece_safehouse_vo::safehousefailkvaalerted();
		wait(1);
		common_scripts\utility::flag_set("FlagSafehouseHideHint");
		setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 113
marketkvafollowtargetalertmonitor()
{
	self endon("death");
	level endon("SafehouseTakedownAlert");
	level endon("PlayerInitiateKeyManKill");
	for(;;)
	{
		if(level.player istouching(self))
		{
			break;
		}

		wait 0.05;
	}

	level notify("SafehouseTakedownAlert");
}

//Function Number: 114
safehousecourtyardsightwatch()
{
	self endon("death");
	level endon("SafehouseTakedownAlert");
	level endon("PlayerInitiateKeyManKill");
	var_00 = getent("TrigKVACourtyardAlert","targetname");
	for(;;)
	{
		if(self cansee(level.player))
		{
			break;
		}

		if(level.player istouching(var_00))
		{
			break;
		}

		wait 0.05;
	}

	level notify("SafehouseTakedownAlert");
}

//Function Number: 115
safehousefollowplayernotifies()
{
	level endon("lazy_mission_end");
	common_scripts\utility::flag_wait("FlagTriggerPlayerMidMarket");
	level.player notify("NotifyPlayerReachedMidMarket");
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterAlley");
	level.player notify("NotifyPlayerReachedAlley");
	wait(1);
	thread maps\_utility::autosave_by_name("safehouse_market_alley");
	common_scripts\utility::flag_wait("FlagTriggerStartTakedownTimer");
	level.player notify("NotifyPlayerReachedCourtyard");
}

//Function Number: 116
safehousebackyarddamagetriggers()
{
	var_00 = getentarray("SafehouseBackyardDamageDetectionTrig","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread safehousebackyardalertmonitoron();
		var_02 thread safehousebackyardalertmonitoroff();
	}
}

//Function Number: 117
safehousebackyarddamagetriggerstoggle()
{
	level.bplayerisinsidesafehouse = 0;
	var_00 = getentarray("SafehousePlayerIsInsideTrigger","targetname");
	var_01 = getentarray("SafehousePlayerIsOutsideTrigger","targetname");
	foreach(var_03 in var_01)
	{
		var_03 common_scripts\utility::trigger_off();
	}

	common_scripts\utility::array_thread(var_00,::safehousebackyarddamagetriggerwaits,1,var_01);
	common_scripts\utility::array_thread(var_01,::safehousebackyarddamagetriggerwaits,0,var_00);
}

//Function Number: 118
safehousebackyarddamagetriggerwaits(param_00,param_01)
{
	for(;;)
	{
		self waittill("trigger",var_02);
		level.bplayerisinsidesafehouse = param_00;
		foreach(var_04 in param_01)
		{
			var_04 common_scripts\utility::trigger_on();
		}

		wait 0.05;
	}
}

//Function Number: 119
safehousebackyardalertmonitoron()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.bplayerisinsidesafehouse == 0)
		{
			common_scripts\utility::flag_set("FlagSafehouseBackyardFail");
			thread maps\greece_safehouse_vo::safehousefailcoverblown();
			wait(1);
			maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - AUTHORITIES ALERTED!!!");
			if(common_scripts\utility::flag("FlagClearSafehouseComplete") || common_scripts\utility::flag("FlagSafeHouseTransitionStart"))
			{
				setdvar("ui_deadquote",&"GREECE_SAFEHOUSE_POLICE_FAIL");
				maps\_utility::missionfailedwrapper();
			}
			else
			{
				setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
			}

			maps\_utility::missionfailedwrapper();
		}

		wait 0.05;
	}
}

//Function Number: 120
safehousebackyardalertmonitoroff()
{
	common_scripts\utility::flag_wait("FlagSafeHouseOutroStart");
	common_scripts\utility::trigger_off();
}

//Function Number: 121
safehousetakedownreturnplayercontrol(param_00,param_01)
{
	wait(param_00);
	level.player unlink();
	param_01 delete();
	level.player showviewmodel();
	level.player giveweapon("iw5_titan45_sp_opticsreddot_silencerpistol");
	level.player switchtoweaponimmediate("iw5_titan45_sp_opticsreddot_silencerpistol");
	level.player enableweaponswitch();
	thread maps\_utility::autosave_by_name("safehouse_courtyard_takedown");
	common_scripts\utility::flag_set("FlagSafehouseCourtyardTakedownComplete");
	wait(0.5);
	common_scripts\utility::flag_set("FlagSetObjClearSafehouse");
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player playerchangemode("stealth_combat");
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.3,1,50,300);
	thread safehousebackyarddamagetriggers();
	thread safehousebackyarddamagetriggerstoggle();
}

//Function Number: 122
safehousekvafollowtargetdeath(param_00)
{
	wait(param_00);
	maps\greece_code::kill_no_react();
	common_scripts\utility::flag_set("FlagFollowTargetKilled");
}

//Function Number: 123
marketkvafollowtargetbuttoncapture(param_00)
{
	self endon("death");
	level endon("KVAFollowTargetAlerted");
	var_01 = getent("UseTriggerKillKVAfollowTarget","targetname");
	thread marketkvafollowtargetbuttonhint(var_01);
	var_01 sethintstring(&"GREECE_SAFEHOUSE_EXECUTE_PROMPT");
	thread marketkvafollowtargetmeleecheck(var_01);
	common_scripts\utility::flag_wait("FlagSafehouseMeleeKillInitiated");
	param_00 notify("StartSafehouseTakedown");
	var_01 delete();
}

//Function Number: 124
marketkvafollowtargetmeleecheck(param_00)
{
	level endon("KVAFollowTargetAlerted");
	for(;;)
	{
		var_01 = distance2d(level.player.origin,param_00.origin);
		if(var_01 <= 72 && level.player meleebuttonpressed())
		{
			break;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("FlagSafehouseMeleeKillInitiated");
	common_scripts\utility::flag_set("init_safehouse_melee_kill_initiated_post");
}

//Function Number: 125
marketkvafollowtargetbuttonhint(param_00)
{
	self endon("death");
	var_01 = level.kvafollowtarget maps\_shg_utility::hint_button_tag("melee","j_spine4",70,200,undefined,param_00);
	common_scripts\utility::flag_wait_either("FlagSafehouseMeleeKillInitiated","FlagClearObjFollowTarget");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 126
safehouseenemyinit(param_00)
{
	self.maxvisibledist = 0.1;
	self.health = 1;
	maps\_utility::set_goalradius(32);
	maps\_utility::enable_cqbwalk();
	maps\_utility::enable_dontevershoot();
	self.battlechatter = 0;
	maps\_utility::set_ignoreall(1);
	if(param_00 == 1)
	{
		maps\_utility::gun_remove();
	}

	self.grenadeammo = 0;
}

//Function Number: 127
safehouseenemiesignoreplayer(param_00)
{
	if(param_00 == 1)
	{
		createthreatbiasgroup("player_safehouse");
		self setthreatbiasgroup("player_safehouse");
		setignoremegroup("player_safehouse","axis");
		return;
	}

	self setthreatbiasgroup();
}

//Function Number: 128
safehousetvdestructible()
{
	var_00 = getent("safehouse_tv_screen","targetname");
	var_01 = getent("safehouse_tv_glass","targetname");
	var_01 soundscripts\_snd::snd_message("mhunt_tv_broadcast");
	var_02 = getent("safehouse_tv_light_primary","script_noteworthy");
	var_03 = getent("safehouse_tv_light_secondary","script_noteworthy");
	var_04 = "greece_safehouse_tv_destroyed_glass";
	var_05 = "greece_safehouse_tv_screen_static";
	precachemodel(var_04);
	precachemodel(var_05);
	var_01 setcandamage(1);
	var_01 common_scripts\utility::waittill_any("damage","SonicAoEDamage");
	var_01 setmodel(var_04);
	var_00 setmodel(var_05);
	var_03 setlightintensity(0);
	var_02 setlightintensity(0.25);
	var_01 soundscripts\_snd::snd_message("mhunt_tv_dest_expl");
	var_06 = getent("SafehousePlanningOrg","targetname");
	var_06 notify("fail_left");
	var_06 notify("fail_right");
	level notify("SafehousePlanningGuardsAlerted");
}

//Function Number: 129
safehouseilanaweaponshot()
{
	common_scripts\utility::flag_wait("FlagFollowTargetUnmarked");
	maps\_utility::clear_run_anim();
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::enable_cqbwalk();
}

//Function Number: 130
safehouseilanaopendooridle()
{
	var_00 = "keycard_door_open_in";
	var_01 = "keycard_door_open_idle";
	var_02 = common_scripts\utility::getstruct("safehousekill","targetname");
	var_03 = level.allies["Ilona"];
	var_04 = maps\_utility::spawn_anim_model("keycard",var_02.origin);
	var_03.keycard = var_04;
	var_05 = [var_03,var_04];
	var_04 hide();
	var_02 maps\_anim::anim_single(var_05,var_00);
	var_02 thread maps\_anim::anim_loop(var_05,var_01,"EndKeycardIdle");
	common_scripts\utility::flag_wait("FlagTriggerPlayerNearBackDoor");
	level notify("SafehousePlayerNearEntrance");
	common_scripts\utility::flag_set("IlanaSafehouseDoorIdleStart");
	if(!common_scripts\utility::flag("FlagSafehouseBackyardFail"))
	{
		thread maps\_utility::autosave_by_name("safehouse_door_entry");
	}
}

//Function Number: 131
safehouseilanaopensafehousedoor()
{
	common_scripts\utility::flag_wait("IlanaSafehouseDoorIdleStart");
	var_00 = "keycard_door_open";
	var_01 = "keycard_wall_idle";
	var_02 = "safehouse_enter";
	var_03 = common_scripts\utility::getstruct("safehousekill","targetname");
	var_04 = level.allies["Ilona"];
	var_05 = var_04.keycard;
	var_06 = getent("safehouse_door","targetname");
	var_07 = getent("safehouse_door_collision","targetname");
	var_08 = [var_06,var_05];
	var_03 notify("EndKeycardIdle");
	var_03 thread maps\_anim::anim_single(var_08,var_00);
	var_03 maps\_anim::anim_single_solo(var_04,var_00);
	var_03 thread maps\_anim::anim_loop_solo(var_04,var_01,"stopIdleLoop");
	var_07 connectpaths();
	var_09 = getaiarray("axis");
	foreach(var_0B in var_09)
	{
		var_0B thread maps\_variable_grenade::handle_detection();
	}

	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterSafehouse");
	thread safehouseplayermovespeedscale1stfloor();
	var_03 notify("stopIdleLoop");
	var_0D = maps\_utility::spawn_anim_model("threat_grenade");
	var_0D hide();
	wait(0.1);
	var_03 thread maps\_anim::anim_single_solo(var_04,"threat_grenade_npc");
	var_0E = getent("IlanathreatGrenadeOrg","targetname");
	var_0E thread maps\_variable_grenade::detection_grenade_think(level.player,3000,undefined,15);
	soundscripts\_snd::snd_message("start_threat_grenade_mixer");
	var_03 maps\_anim::anim_single_solo(var_0D,"threat_grenade_npc");
	var_03 thread maps\_anim::anim_loop_solo(var_04,var_01,"stopIdleLoop");
	thread safehouseremovethreatgrenade(var_0D);
	common_scripts\utility::flag_set("FlagSafehouseThreatGrenadeDetonated");
	common_scripts\utility::flag_wait("FlagKVASafehousePatrollerDeath");
	soundscripts\_snd::snd_message("start_safehouse_guard_01_music");
	thread safehouseilanaplanningguardsearlykill();
	var_03 notify("stopIdleLoop");
	var_03 maps\_anim::anim_single_solo(var_04,var_02);
	if(!common_scripts\utility::flag("FlagSafehousePlanningGuardRightKilled") && !common_scripts\utility::flag("FlagSafehousePlanningGuardLeftKilled"))
	{
		var_03 thread maps\_anim::anim_loop_solo(var_04,"safehouse_enter_idle","stopEnterIdleLoop");
		level notify("SafehouseIlanaStartedPlanningGuardsIdle");
		common_scripts\utility::flag_wait_either("FlagSafehousePlanningGuardRightKilled","FlagSafehousePlanningGuardLeftKilled");
		thread safehouseilanastairway();
	}
}

//Function Number: 132
safehouseilanaplanningguardsearlykill()
{
	level endon("SafehouseIlanaStartedPlanningGuardsIdle");
	var_00 = maps\_utility::get_living_ai("PlanningGuard_left","script_noteworthy");
	var_01 = maps\_utility::get_living_ai("PlanningGuard_right","script_noteworthy");
	common_scripts\utility::flag_wait_any("FlagSafehousePlanningGuardRightKilled","FlagSafehousePlanningGuardLeftKilled");
	level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
	wait 0.05;
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseSecondRoomWait");
	if(common_scripts\utility::flag("FlagSafehousePlanningGuardRightKilled"))
	{
		level.allies["Ilona"] maps\greece_code::shootguy(var_00,1,1);
	}
	else if(common_scripts\utility::flag("FlagSafehousePlanningGuardLeftKilled"))
	{
		level.allies["Ilona"] maps\greece_code::shootguy(var_01,1,1);
	}

	common_scripts\utility::flag_wait("FlagFirstFloorSafehouseKVAkilled");
	thread safehouseilanastairway();
}

//Function Number: 133
safehouseplayermovespeedscale1stfloor()
{
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterFirstRoom");
	var_00 = maps\_utility::get_living_ai("KVAsafehousePatroller_AI","targetname");
	if(isdefined(var_00) && isalive(var_00))
	{
		level.player notify("CancelMoveSpeedScale");
		wait 0.05;
		level.player thread playerrubberbandmovespeedscale(var_00,0.3,1,100,600);
	}

	common_scripts\utility::flag_wait("FlagKVASafehousePatrollerDeath");
	var_01 = getent("FirstFloorSpeedScaleOrg","targetname");
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player thread playerrubberbandmovespeedscale(var_01,0.3,1,150,900);
	common_scripts\utility::flag_wait("FlagSafehouseIlanaAtStairs");
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.3,1,50,300);
}

//Function Number: 134
safehouseplayermovespeedscale2ndfloor()
{
	common_scripts\utility::flag_wait("FlagTriggerSafehousePlayerPastCouch");
	var_00 = getent("SecondFloorSpeedScaleOrg","targetname");
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player thread playerrubberbandmovespeedscale(var_00,0.3,1,150,900);
}

//Function Number: 135
safehousedoorplayerblocker()
{
	var_00 = getent("SafehouseDoorPlayerBlocker","targetname");
	level waittill("SafehousePlayerBlockerDelete");
	if(isdefined(var_00))
	{
		var_00 notsolid();
		var_00 delete();
	}
}

//Function Number: 136
safehouseremovethreatgrenade(param_00)
{
}

//Function Number: 137
safehouseforceopensafehousedoor()
{
	var_00 = "keycard_door_open";
	var_01 = getent("safehouse_door","targetname");
	var_02 = getent("safehouse_door_collision","targetname");
	var_01 setanim(var_01 maps\_utility::getanim(var_00));
	var_01 safehousedoorsetlocked(0);
	var_02 connectpaths();
}

//Function Number: 138
safehousedoorinit()
{
	var_00 = getent("safehouse_door","targetname");
	var_00.animname = "keycard_door";
	var_00 maps\_utility::assign_animtree("keycard_door");
	var_01 = getent("safehouse_door_collision","targetname");
	var_01 linkto(var_00,"jo_door_l");
	var_01 disconnectpaths();
	var_02 = common_scripts\utility::getstruct("safehousekill","targetname");
	var_02 maps\_anim::anim_first_frame_solo(var_00,"keycard_door_open");
	var_00 safehousedoorsetlocked(1);
}

//Function Number: 139
safehousedoorsetlocked(param_00)
{
	if(param_00)
	{
		self hidepart("TAG_PANEL_UNLOCKED");
		self showpart("TAG_PANEL_LOCKED");
		return;
	}

	self hidepart("TAG_PANEL_LOCKED");
	self showpart("TAG_PANEL_UNLOCKED");
}

//Function Number: 140
safehousedoorunlockednotetrack(param_00)
{
	var_01 = getent("safehouse_door","targetname");
	var_01 safehousedoorsetlocked(0);
}

//Function Number: 141
safehouseilanaclearsafehouse()
{
	thread safehouseilanaopensafehousedoor();
	common_scripts\utility::flag_wait("FlagTriggerSpawnSafehouseGuards");
	thread spawnkvasafehouseguards();
	level.allies["Ilona"] maps\_utility::enable_cqbwalk();
	var_00 = level.allies["Ilona"].grenadeammo;
	level.allies["Ilona"].grenadeammo = 0;
	common_scripts\utility::flag_set("FlagIlanaEnterSafehouse");
	common_scripts\utility::flag_wait("FlagClearSafehouseComplete");
	thread safehouseilanatransition();
	level.player thread playerchangemode("full_combat");
	level.player notify("CancelMoveSpeedScale");
	level.allies["Ilona"] maps\_utility::disable_cqbwalk();
	level.allies["Ilona"].ignoreall = 0;
	level.allies["Ilona"].grenadeammo = var_00;
	common_scripts\utility::flag_wait("FlagTriggerPlayerExitAfterBagdrop");
}

//Function Number: 142
safehouseilanastairway()
{
	var_00 = level.allies["Ilona"];
	var_01 = getent("safehouse_pillow","targetname");
	var_01.animname = "safehouse_pillow";
	var_01 maps\_utility::assign_animtree("safehouse_pillow");
	var_01 show();
	var_02 = common_scripts\utility::getstruct("safehousekill","targetname");
	thread safehouseplayermovespeedscale2ndfloor();
	if(common_scripts\utility::flag("FlagFirstFloorSafehouseKVAkilled"))
	{
		var_02 maps\_anim::anim_reach_solo(var_00,"safehouse_enter2_alt");
		common_scripts\utility::flag_set("FlagSafehouseIlanaAtStairs");
		var_02 thread maps\_anim::anim_single_solo(var_01,"safehouse_enter2_alt");
		var_02 maps\_anim::anim_single_solo(var_00,"safehouse_enter2_alt");
	}
	else
	{
		common_scripts\utility::flag_set("FlagSafehouseIlanaAtStairs");
		var_02 notify("stopEnterIdleLoop");
		var_02 thread maps\_anim::anim_single_solo(var_01,"safehouse_enter2");
		var_02 maps\_anim::anim_single_solo(var_00,"safehouse_enter2");
	}

	safehousesleepingguardanimcheck(var_02);
	var_02 thread maps\_anim::anim_loop_solo(var_00,"safehouse_enter2_idle","StopIlanaEnter2Idle");
	common_scripts\utility::flag_wait("FlagPacingNpcDeath");
	var_02 notify("StopIlanaEnter2Idle");
	var_02 maps\_anim::anim_single_solo(var_00,"safehouse_enter3");
	if(!common_scripts\utility::flag("FlagPlayerUsedSafehouseComputer"))
	{
		var_02 thread maps\_anim::anim_loop_solo(var_00,"safehouse_enter3_idle","StopIlanaEnter3Idle");
	}
}

//Function Number: 143
safehouseilanabagdropwait()
{
	common_scripts\utility::flag_wait("FlagSafeHouseTransitionStart");
	var_00 = level.allies["Ilona"];
	var_01 = common_scripts\utility::getstruct("safehousekill","targetname");
	var_01 maps\_anim::anim_single_solo(var_00,"safehouse_enter3");
	if(!common_scripts\utility::flag("FlagComputerInteractComplete"))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00,"safehouse_enter3_idle","StopIlanaEnter3Idle");
	}
}

//Function Number: 144
safehouseilanaexitstairs()
{
	var_00 = getent("IlanaStairsAnimOrg","targetname");
	var_01 = level.allies["Ilona"];
	var_00 maps\_anim::anim_reach_solo(var_01,"exit_stairs");
	var_00 maps\_anim::anim_single_solo(var_01,"exit_stairs");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"exit_1stfloor_idle","stop_1stfloor_idle");
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingDownStairs");
	level notify("SafehousePlayerBlockerDelete");
	var_00 notify("stop_1stfloor_idle");
	var_00 maps\_anim::anim_single_solo(var_01,"exit_1stfloor_all");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitDoorwayWait");
}

//Function Number: 145
safehouseilanasonicexocheck(param_00)
{
	level waittill("SonicAoEStarted");
	param_00 notify("stop_arch_idle");
	common_scripts\utility::flag_set("SonicIntroCheckActivated");
}

//Function Number: 146
safehouseilanatransition()
{
	var_00 = getent("IlanaTransitionAnimOrg","targetname");
	var_01 = "room3_transition_out";
	var_02 = level.allies["Ilona"];
	if(common_scripts\utility::flag("FlagSafehouseIlanaTransitionIdleStarted"))
	{
		var_00 notify("stopIdleLoop");
		var_00 maps\_anim::anim_single_solo(var_02,var_01);
	}
}

//Function Number: 147
safehouseremoveplayerblocker()
{
	var_00 = getent("SafehouseHorribleCatchKillPlayerBlocker","targetname");
	var_00 movez(-128,0.1);
	var_00 delete();
}

//Function Number: 148
safehouseplanningguards()
{
	thread safehouseplanningguard("right");
	thread safehouseplanningguard("left");
	thread safehouseilanasetupteamkill();
}

//Function Number: 149
safehouseplanningguard(param_00,param_01)
{
	if(param_00 == "left")
	{
		var_02 = "right";
	}
	else
	{
		var_02 = "left";
	}

	var_03 = "plan_idle";
	var_04 = "StopPlanningIdle_" + param_00;
	var_05 = getent("SafehousePlanningOrg","targetname");
	var_06 = maps\_utility::get_living_ai("PlanningGuard_" + param_00,"script_noteworthy");
	var_06.animname = "planner_" + param_00;
	var_06.default_health = var_06.health;
	var_06.health = 100000;
	var_06.fail_success_allowed = 1;
	var_06.allowdeath = 1;
	var_06.script_parameters = "planner_" + param_00;
	var_06.fovcosine = cos(45);
	var_06.grenadeawareness = 0;
	var_06.ragdoll_immediate = 1;
	var_06.diequietly = 1;
	var_06 maps\_utility::forceuseweapon("iw5_kf5_sp_silencer01","primary");
	wait 0.05;
	var_06 maps\_utility::gun_remove();
	var_06 endon("plan_anims_done");
	var_05 thread maps\_anim::anim_loop_solo(var_06,var_03,var_04);
	if(param_00 == "right")
	{
		var_06 thread safehouseplanningguardsweapons("SafehousePlanningGuardRightPlanFail");
	}
	else
	{
		var_06 thread safehouseplanningguardsweapons("SafehousePlanningGuardLeftPlanFail");
	}

	thread safehouseplanningguardfailwatch(var_05,var_06,param_00,var_02);
	var_06 maps\_utility::set_ignoreall(1);
	common_scripts\utility::flag_wait("FlagTriggerPlayerEnterSafehouse2");
	var_06 maps\_utility::set_ignoreall(0);
	var_06 waittill("damage",var_07,var_08,var_09,var_0A,var_0B);
	if(isdefined(var_08) && var_08 == level.player)
	{
		var_06 maps\greece_code::giveplayerchallengekillpoint();
	}

	common_scripts\utility::flag_set(var_06.script_deathflag);
	var_06 setthreatdetection("disable");
	var_06 notify("fail_watch_end");
	var_05 notify(var_04);
	var_05 notify("fail_" + var_02);
	var_09 = var_09 * -1;
	var_0C = vectordot((1,0,0),var_09);
	var_03 = "plan_success";
	if(param_00 == "left")
	{
		if(var_0C <= 0.15 && var_0C >= -0.15)
		{
			var_03 = "plan_success_alt2";
		}
		else if(var_0C <= -0.15)
		{
			var_03 = "plan_success_alt";
		}
	}
	else if(var_0C >= 0)
	{
		var_03 = "plan_success_alt";
	}

	var_05 maps\_anim::anim_single_solo(var_06,var_03);
	var_06 maps\greece_code::kill_no_react();
}

//Function Number: 150
safehouseplanningguardsweapons(param_00)
{
	wait(1);
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("npc_kf5_base_loot");
	var_01.origin = self gettagorigin("tag_weapon_right");
	var_01.angles = self gettagangles("tag_weapon_right");
	level waittill(param_00);
	maps\_utility::gun_recall();
	var_01 delete();
}

//Function Number: 151
safehouseplanningguardfailendnotetrack(param_00)
{
	param_00.fail_success_allowed = 0;
	param_00.health = param_00.default_health;
	param_00.allowdeath = 1;
}

//Function Number: 152
safehouseplanningguardfailwatch(param_00,param_01,param_02,param_03)
{
	param_01 endon("fail_watch_end");
	var_04 = "plan_fail";
	var_05 = "StopPlanningIdle_" + param_02;
	var_06 = "fail_" + param_02;
	var_07 = "fail_" + param_03;
	param_01 thread safehouseguardsightwatch(param_00,var_06);
	param_01 thread safehouseguardalertwatch(param_00,var_06,var_07);
	param_01 thread safehouseguardtriggerwatch("TriggerSafehouseForceAlertPlanningGuards",param_00,var_06,0);
	param_01 thread safehouseguardtriggerwatch("TriggerSafehouseAlertPlanningGuards",param_00,var_06,1);
	param_01 maps\_utility::disable_surprise();
	param_00 waittill(var_06);
	param_00 notify(var_05);
	param_01.planning_fail = 1;
	param_01.health = param_01.default_health;
	param_01.allowdeath = 1;
	level notify("SafehousePlanningGuardsAlerted");
	common_scripts\utility::flag_set("FlagSafehousePlanningGuardsAlerted");
	param_00 maps\_anim::anim_single_solo(param_01,var_04);
	param_01.ignoreall = 0;
	param_01 maps\_utility::disable_dontevershoot();
	param_01 notify("plan_anims_done");
	for(;;)
	{
		level endon("SafehousePlanningGuardsKilled");
		thread maps\greece_safehouse_vo::safehousefailkvaalerted();
		wait(1);
		common_scripts\utility::flag_set("FlagSafehouseHideHint");
		maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - KVA ALERTED!!!");
		setdvar("ui_deadquote",&"GREECE_DRONE_ALERT_FAIL");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 153
safehouseguardalertwatch(param_00,param_01,param_02)
{
	self endon("fail_watch_end");
	self endon("death");
	common_scripts\utility::waittill_any("bulletwhizby","gunshot","silenced_shot","projectile_impact");
	param_00 notify(param_01);
	if(isdefined(param_02))
	{
		param_00 notify(param_02);
	}
}

//Function Number: 154
safehouseguardsightwatch(param_00,param_01)
{
	self endon("fail_watch_end");
	self endon("death");
	for(;;)
	{
		if(self cansee(level.player))
		{
			break;
		}

		wait 0.05;
	}

	param_00 notify(param_01);
}

//Function Number: 155
safehouseguardtriggerwatch(param_00,param_01,param_02,param_03)
{
	self endon("fail_watch_end");
	self endon("death");
	var_04 = getent(param_00,"targetname");
	for(;;)
	{
		if(level.player istouching(var_04))
		{
			if(param_03 == 1)
			{
				var_05 = level.player getstance();
				if(var_05 != "crouch" && var_05 != "prone")
				{
					break;
				}
			}
			else
			{
				break;
			}
		}

		wait 0.05;
	}

	param_01 notify(param_02);
}

//Function Number: 156
safehousepacingguardtriggerwatch(param_00)
{
	self endon("fail_watch_end");
	self endon("death");
	var_01 = getent("TriggerSafehouseAlertPacingGuard","targetname");
	for(;;)
	{
		if(level.player istouching(var_01))
		{
			if(common_scripts\utility::flag("FlagSafehouseVideoChatEnded"))
			{
				var_02 = level.player getstance();
				if(var_02 != "crouch" && var_02 != "prone")
				{
					break;
				}
			}
			else
			{
				break;
			}
		}

		wait 0.05;
	}

	param_00 notify("PacingGuard");
}

//Function Number: 157
safehouseilanasetupteamkill()
{
	var_00 = maps\_utility::get_living_ai("PlanningGuard_right","script_noteworthy");
	if(isdefined(var_00))
	{
		var_00 thread maps\greece_code::bloodsprayexitwoundtrace(undefined,undefined,"tag_eye",1);
	}

	var_01 = maps\_utility::get_living_ai("PlanningGuard_left","script_noteworthy");
	if(isdefined(var_01))
	{
		var_01 thread maps\greece_code::bloodsprayexitwoundtrace(undefined,undefined,undefined,1);
	}

	thread safehouseplanningguarddeathcheck();
	common_scripts\utility::flag_wait("FlagIlanaShootPlanningGuard");
	if(common_scripts\utility::flag("FlagFirstFloorSafehouseKVAkilled"))
	{
		return;
	}
	else
	{
		var_02 = level.allies["Ilona"] gettagorigin("TAG_WEAPON");
		if(common_scripts\utility::flag("FlagSafehousePlanningGuardRightKilled"))
		{
			magicbullet("iw5_sn6_sp_silencer01",var_02,var_01 geteye());
		}
		else
		{
			magicbullet("iw5_sn6_sp_silencer01",var_02,var_00 geteye());
		}
	}

	common_scripts\utility::flag_wait_all("FlagSafehousePlanningGuardRightKilled","FlagSafehousePlanningGuardLeftKilled");
	common_scripts\utility::flag_set("FlagFirstFloorSafehouseKVAkilled");
	level notify("SafehousePlanningGuardsKilled");
	thread maps\_utility::autosave_by_name("safehouse_first_floor_clear");
}

//Function Number: 158
safehouseplanningguarddeathcheck()
{
	common_scripts\utility::flag_wait_all("FlagSafehousePlanningGuardRightKilled","FlagSafehousePlanningGuardLeftKilled");
	common_scripts\utility::flag_set("FlagFirstFloorSafehouseKVAkilled");
	level notify("SafehousePlanningGuardsKilled");
}

//Function Number: 159
safehousemonitorbagdropinteract()
{
	level endon("SafehouseAlerted");
	var_00 = getent("UseTriggerSafehouseComputerInteract","targetname");
	var_00 makeusable();
	thread safehousemonitorbagdrophint();
	var_00 maps\_utility::addhinttrigger(&"GREECE_SAFEHOUSE_SUIT_UP",&"GREECE_SAFEHOUSE_SUIT_UP_KB");
	var_00 waittill("trigger",var_01);
	level.player notify("CancelMoveSpeedScale");
	var_00 delete();
	common_scripts\utility::flag_set("FlagPlayerUsedSafehouseComputer");
}

//Function Number: 160
safehousemonitorbagdrophint()
{
	var_00 = getent("ComputerInteractObj","targetname");
	var_01 = maps\_shg_utility::hint_button_position("use",var_00.origin,128);
	common_scripts\utility::flag_wait_either("FlagPlayerUsedSafehouseComputer","FlagSafehouseHideHint");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 161
safehouseilanacheckdeckweapon()
{
	level waittill("SafehouseIlanaCheckDeckGunPlaced");
	maps\_utility::gun_remove();
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("npc_titan45_base_loot");
	var_00 attach("weapon_silencer_01","TAG_SILENCER");
	var_00.origin = self gettagorigin("tag_weapon_right");
	var_00.angles = self gettagangles("tag_weapon_right");
}

//Function Number: 162
safehousechangeclothes()
{
	var_00 = "bag_drop";
	var_01 = "drone_pre_launch";
	var_02 = "drone_launch";
	var_03 = "drone_post_launch";
	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = common_scripts\utility::getstruct("BagDropOrg","targetname");
	var_08 = common_scripts\utility::getstruct("BagDropOrg","targetname");
	var_09 = level.allies["Ilona"];
	var_05 = common_scripts\utility::array_add(var_05,var_09);
	var_09 notify("DeleteIlanaBackpack");
	var_08 notify("endCheckDeckIdle");
	var_0A = maps\_utility::spawn_anim_model("player_cafe_rig",var_07.origin);
	var_0A hide();
	var_04 = common_scripts\utility::array_add(var_04,var_0A);
	var_0B = maps\_utility::spawn_anim_model("backpack_drone_large",var_07.origin);
	var_04 = common_scripts\utility::array_add(var_04,var_0B);
	var_0C = maps\_utility::spawn_anim_model("backpack_drone_small",var_07.origin);
	var_05 = common_scripts\utility::array_add(var_05,var_0C);
	var_09 maps\_utility::gun_remove();
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player givestartammo("iw5_titan45_sp_opticsreddot_silencerpistol");
	var_07 maps\_anim::anim_first_frame(var_04,var_00);
	level.player playerlinktoblend(var_0A,"tag_player",0.4);
	wait(0.4);
	var_0A show();
	common_scripts\utility::flag_set("greece_safehouse_exso_dressup");
	var_07 thread maps\_anim::anim_single(var_04,var_00);
	var_08 thread maps\_anim::anim_single(var_05,var_00);
	var_0D = common_scripts\utility::getstruct("bagdropimpulse","targetname");
	wait(0.72);
	physicsexplosionsphere(var_0D.origin,96,0,1.25);
	var_0E = getent("greece_safehouse_penholder","targetname");
	var_0F = var_0E.origin;
	var_10 = var_0E.angles;
	var_11 = anglestoforward(var_10);
	var_12 = anglestoup(var_10);
	var_0E hide();
	playfx(level._effect["destp_penholder_dyndst"],var_0F,var_11,var_12);
	maps\greece_safehouse_fx::sniperdroneprep();
	soundscripts\_snd::snd_message("safehouse_exo_trans_fade_out");
	maps\_hud_util::fade_out(1.75,"black");
	var_0B delete();
	var_13 = common_scripts\utility::getstruct("SafehouseSmallBackpackOrg","targetname");
	var_14 = spawn("script_model",var_13.origin);
	var_14 setmodel("greece_duffelbag_rigged_empty");
	var_14.angles = var_13.angles;
	level.allies["Ilona"] stopanimscripted();
	level.allies["Ilona"] delete();
	maps\_hms_utility::spawnandinitnamedally("Ilona",undefined,1,1,"IlanaSafehouseExoSuit");
	var_09 = level.allies["Ilona"];
	var_09 maps\_utility::gun_remove();
	level.player unlink();
	var_0A delete();
	wait 0.05;
	var_15 = maps\_utility::spawn_anim_model("player_safehouse_rig",var_07.origin);
	level.player playerlinktoblend(var_15,"tag_player",0.1);
	wait(1.25);
	var_16 = common_scripts\utility::getstruct("BagDropOrg2","targetname");
	var_17 = maps\_utility::spawn_anim_model("sniper_drone",var_07.origin);
	var_06 = common_scripts\utility::array_add(var_06,var_17);
	var_06 = common_scripts\utility::array_add(var_06,var_09);
	var_0C delete();
	soundscripts\_snd::snd_message("start_sniper_drone_deploy");
	soundscripts\_snd::snd_message("balcony_sniper_drone_idle",var_17);
	var_09.disablefacialfilleranims = 0;
	var_16 thread maps\_anim::anim_single_solo(var_15,var_01);
	var_16 thread maps\_anim::anim_loop(var_06,var_01,"StopDronePrelaunchIdle");
	soundscripts\_snd::snd_message("safehouse_exo_trans_fade_in");
	maps\_hud_util::fade_in(3,"black");
	common_scripts\utility::flag_set("greece_safehouse_exso_dressup_fadeout");
	var_16 waittill(var_01);
	common_scripts\utility::flag_set("FlagConfCenterVOStart");
	level.player unlink();
	var_15 delete();
	level.player setviewmodel("viewhands_atlas_military");
	level.player giveweapon("iw5_hmr9_sp_variablereddot");
	level.player enableweapons();
	level.player allowcrouch(1);
	level.player allowprone(1);
	common_scripts\utility::flag_wait("FlagTriggerPlayerExitAfterBagdrop");
	playfxontag(common_scripts\utility::getfx("sniper_drone_fan_distortion"),var_17,"TAG_ORIGIN");
	maps\greece_safehouse_fx::dronedraftplants();
	maps\greece_safehouse_fx::ambientcloudsloadin();
	var_16 notify("StopDronePrelaunchIdle");
	var_06 = common_scripts\utility::array_remove(var_06,var_17);
	var_17 thread safehousesniperdronelaunch(var_16,var_02);
	var_17 thread safehousesniperdronecloaking();
	var_16 maps\_anim::anim_single(var_06,var_02);
	var_16 thread maps\_anim::anim_loop_solo(level.allies["Ilona"],var_03,"StopSniperDroneLaunchIdle");
	thread safehouseenddronecontrolsetup(var_16,var_09,var_17);
}

//Function Number: 163
safehousesniperdronelaunch(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo(self,param_01);
	if(level.currentgen)
	{
		self delete();
	}
}

//Function Number: 164
safehousesniperdronecloaking()
{
	level waittill("SafehouseDroneStartCloak");
	soundscripts\_snd::snd_message("wasp_cloak_on");
	self setmodel("vehicle_sniper_drone_cloak");
	self drawpostresolve();
	self setmaterialscriptparam(1,0.05);
	wait(0.05);
	self setmaterialscriptparam(0,3);
}

//Function Number: 165
safehouseenddronecontrolsetup(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait("FlagPlayerEndDroneControl");
	param_00 notify("StopSniperDroneLaunchIdle");
	param_01 stopanimscripted();
	param_01.disablefacialfilleranims = 0;
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitBalconyWait");
	if(isdefined(param_02))
	{
		param_02 delete();
	}
}

//Function Number: 166
safehousesetupsniperdroneilana()
{
	var_00 = "drone_post_launch";
	var_01 = [];
	var_02 = common_scripts\utility::getstruct("BagDropOrg2","targetname");
	var_03 = level.allies["Ilona"];
	var_04 = maps\_utility::spawn_anim_model("sniper_drone",var_02.origin);
	var_04 thread safehousesniperdronecloaking();
	var_01 = common_scripts\utility::array_add(var_01,var_04);
	var_01 = common_scripts\utility::array_add(var_01,var_03);
	var_02 thread maps\_anim::anim_loop(var_01,var_00,"StopSniperDroneLaunchIdle");
	thread safehouseenddronecontrolsetup(var_02,var_03,var_04);
	wait(2);
	level notify("SafehouseDroneStartCloak");
}

//Function Number: 167
safehousebeginexit()
{
	common_scripts\utility::flag_wait("FlagSafeHouseOutroStart");
	maps\_utility::lerp_fov_overtime(0.5,65);
	thread safehousespawnwindowshooters();
	thread safehousespawnbackalleykva();
	thread safehousespawnbackalleyrooftopkva();
	thread safehouseilanasafehouseexit();
	thread safehouseexitautosaves();
	thread maps\greece_code::sunflareswap("sunflare_dim");
	thread safehousedoorplayerblocker();
	safehousetoggleexitflagtriggers(1);
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
}

//Function Number: 168
adsmonitor()
{
	for(;;)
	{
		if(level.player adsbuttonpressed())
		{
			iprintln("ADS");
		}

		wait(1);
	}
}

//Function Number: 169
safehouseexitautosaves()
{
	common_scripts\utility::flag_wait("FlagSafehouseExitKVADead");
	wait(1);
	thread maps\_utility::autosave_now();
	common_scripts\utility::flag_wait_all("FlagSafehouseStairKVADead","FlagKickSafehouseExitGate");
	wait(1);
	thread maps\_utility::autosave_now();
}

//Function Number: 170
safehouseilanasafehouseexit()
{
	thread safehouseexit2floor();
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitSecondFloorDoorwayWait");
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingBackInside");
	safehouseilanaexitstairs();
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingDownStairs");
	common_scripts\utility::flag_wait_either("FlagSpawnStairKVA","FlagSafehouseExitKVADead");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitOutsideWait");
	level.player playerchangemode("full_combat");
	level.player notify("CancelMoveSpeedScale");
	common_scripts\utility::flag_wait_either("FlagSpawnGateExitKVA","FlagSafehouseStairKVADead");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitAlleyWait");
}

//Function Number: 171
setflagaftertime(param_00,param_01)
{
	wait(param_01);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 172
safehouseexit2floor()
{
	var_00 = common_scripts\utility::getstruct("BagDropOrg2","targetname");
	var_01 = "exit_2floor";
	var_02 = level.allies["Ilona"];
	var_02.disablefacialfilleranims = 1;
	thread safehouseexit2floorviewmodel();
	var_00 thread maps\_anim::anim_first_frame_solo(var_02,var_01);
	wait(0.65);
	var_00 thread maps\_anim::anim_single_solo_run(var_02,var_01);
	level waittill("NotifyIlonaExitGunShow");
	var_02 maps\_utility::gun_recall();
	var_02.disablefacialfilleranims = 0;
}

//Function Number: 173
safehouseexit2floorviewmodel()
{
	var_00 = common_scripts\utility::getstruct("BagDropOrg2","targetname");
	var_01 = "exit_2floor";
	var_02 = maps\_utility::spawn_anim_model("player_safehouse_rig");
	var_03 = maps\_utility::spawn_anim_model("drone_control_pad");
	var_04 = [var_02,var_03];
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_00 maps\_anim::anim_first_frame(var_04,var_01);
	level.player playerlinktoblend(var_02,"tag_player",0.4);
	wait(0.4);
	maps\_hud_util::fade_in(0.25,"white");
	wait(0.25);
	level.player setblurforplayer(0,1);
	var_00 maps\_anim::anim_single(var_04,var_01);
	level.player unlink();
	var_02 delete();
	var_03 delete();
	level.player giveweapon("iw5_hmr9_sp_variablereddot");
	level.player switchtoweaponimmediate("iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	foreach(var_06 in level.player getweaponslistoffhands())
	{
		level.player setweaponammostock(var_06,4);
	}

	level.player allowfire(1);
	level.player allowads(1);
	setsaveddvar("ammoCounterHide",0);
	level.player allowsprint(0);
	level.player allowdodge(0);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowstand(1);
	level.player allowjump(1);
	level.player enableoffhandweapons();
	level.player enableweapons();
	level.player allowmelee(1);
	thread maps\_player_exo::player_exo_activate();
	level.player notify("CancelMoveSpeedScale");
	wait 0.05;
	level.player thread playerrubberbandmovespeedscale(level.allies["Ilona"],0.5,1,100,300);
	var_00 waittill(var_01);
}

//Function Number: 174
ilanaturn2exit()
{
	var_00 = getent("SafehouseTurn2ExitOrg","targetname");
	var_01 = "turn2exit";
	var_02 = level.allies["Ilona"];
	var_00 maps\_anim::anim_reach_solo(var_02,var_01);
	var_00 maps\_anim::anim_single_solo_run(var_02,var_01);
	thread maps\_hms_utility::allyredirectgotonode("Ilona","IlanaSafehouseExitDoorwayWait");
}

//Function Number: 175
hintsafehouseexitsonicoff()
{
	return common_scripts\utility::flag("FlagSonicAoEActivated");
}

//Function Number: 176
safehousetoggleexitflagtriggers(param_00)
{
	var_01 = getentarray("SafehouseExitFlagTrigger","targetname");
	foreach(var_03 in var_01)
	{
		if(param_00 == 1)
		{
			var_03 common_scripts\utility::trigger_on();
			continue;
		}

		var_03 common_scripts\utility::trigger_off();
	}
}

//Function Number: 177
safehouseexittogglegates(param_00)
{
	var_01 = getent("SafehouseBackyardEntryGate","targetname");
	var_01.animname = "safehousegate";
	var_01 maps\_utility::assign_animtree("safehousegate");
	var_02 = getent("SafehouseBackyardEntryGateCollision","targetname");
	var_02 linkto(var_01,"jo_gate_door");
	switch(param_00)
	{
		case "open":
			var_01 thread maps\_anim::anim_first_frame_solo(var_01,"market_marketgate_open");
			common_scripts\utility::flag_wait("FlagSafehouseCourtyardTakedownComplete");
			wait(0.5);
			var_01 thread maps\_anim::anim_first_frame_solo(var_01,"market_marketgate_closed");
			common_scripts\utility::flag_set("FlagDeleteSafehouseCivilians");
			break;

		case "closed":
			var_01 thread maps\_anim::anim_first_frame_solo(var_01,"market_marketgate_closed");
			break;
	}
}

//Function Number: 178
safehousespawnwindowshooters()
{
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingDownStairs");
	maps\_utility::array_spawn_function_targetname("SafehouseWindowShooters",::safehousewindowshooterthink);
	maps\_utility::array_spawn_function_targetname("SafehouseWindowShooters",::_initsafehouseexitkvabehavior);
	var_00 = maps\_utility::array_spawn_targetname("SafehouseWindowShooters");
	self endon("CancelMoveSpeedScale");
	wait 0.05;
	level.player allowsprint(1);
	level.player allowdodge(1);
	level.player setmovespeedscale(1);
}

//Function Number: 179
safehousewindowshooterthink()
{
	self endon("death");
	var_00 = "Goal" + self.script_noteworthy;
	var_01 = getent(var_00,"targetname");
	maps\_utility::set_goal_radius(32);
	maps\_utility::set_goal_pos(var_01.origin);
	var_02 = "Org" + self.script_noteworthy;
	var_03 = getent(var_02,"targetname");
	self setentitytarget(var_03);
	childthread safehousewindowshootermovetarget(var_03);
	childthread safehousewindowshutterdestroy();
	childthread safehousewindowshootermonitor();
	common_scripts\utility::flag_wait_either("FlagWindowShootersBreakOut","FlagTriggerExitPlayerLeavingBuilding");
	self clearentitytarget(var_03);
	wait 0.05;
	var_04 = getent("WindowShooterVol","targetname");
	self setgoalvolume(var_04);
	maps\_utility::set_favoriteenemy(level.player);
	var_05 = "Goal" + self.script_noteworthy;
	var_01 = getnode(var_05,"targetname");
	maps\_utility::set_goal_node(var_01);
}

//Function Number: 180
safehousewindowshootermovetarget(param_00)
{
	var_01 = param_00.origin;
	for(;;)
	{
		var_02 = var_01 + (0,randomfloatrange(-16,16),randomfloatrange(-8,8));
		param_00 moveto(var_02,randomfloatrange(0.5,2));
		wait(randomfloatrange(0.1,0.5));
	}
}

//Function Number: 181
safehousewindowshutterdestroy()
{
	wait(randomfloatrange(0.1,0.3));
	thread maps\greece_safehouse_fx::safehousesonicdustfx();
	var_00 = getent("OrgWindowBlast","targetname");
	physicsexplosionsphere(var_00.origin,200,200,1);
	var_01 = getentarray("SafehouseWindowShutter","targetname");
	maps\_utility::array_delete(var_01);
}

//Function Number: 182
safehousewindowshootermonitor()
{
	common_scripts\utility::waittill_either("damage","death");
	common_scripts\utility::flag_set("FlagWindowShootersBreakOut");
}

//Function Number: 183
safehousespawnbackalleyrooftopkva()
{
	common_scripts\utility::flag_wait("FlagSpawnRooftopKVA");
	var_00 = maps\_utility::spawn_targetname("SafehouseRooftopKVA");
	var_00 maps\_utility::disable_long_death();
	var_01 = getent("RooftopKVAGoalVolume","targetname");
	var_00 maps\_utility::set_goal_radius(64);
	var_00.grenadeammo = 0;
}

//Function Number: 184
safehousespawnbackalleykva()
{
	common_scripts\utility::flag_wait("FlagSpawnStairKVA");
	thread _spawntargetnamegotogoal("SafehouseExitCornerKVA","SafehouseExitCornerCover");
	thread _spawntargetnamegotogoal("SafehouseStairGuard","StairCover");
	common_scripts\utility::flag_wait("FlagSpawnGateExitKVA");
	thread _spawntargetnamegotogoal("ExitGateKVA","ExitGateCover");
}

//Function Number: 185
_spawntargetnamegotogoal(param_00,param_01)
{
	var_02 = maps\_utility::spawn_targetname(param_00);
	var_02 maps\_utility::set_goal_radius(64);
	var_03 = getnode(param_01,"targetname");
	var_02 maps\_utility::set_goal_node(var_03);
	var_02 thread _initsafehouseexitkvabehavior();
}

//Function Number: 186
_initsafehouseexitkvabehavior()
{
	maps\_utility::disable_surprise();
	maps\_utility::set_ignoresuppression(1);
	self.grenadeammo = 0;
	maps\_utility::disable_long_death();
}

//Function Number: 187
safehouseexitplayerjumpwatcher()
{
	level endon("FlagPlayerJumpWatcherStop");
	common_scripts\utility::flag_clear("FlagPlayerJumping");
	notifyoncommand("playerjump","+gostand");
	notifyoncommand("playerjump","+moveup");
	for(;;)
	{
		level.player waittill("playerjump");
		wait(0.1);
		if(!level.player isonground())
		{
			common_scripts\utility::flag_set("FlagPlayerJumping");
		}

		while(!level.player isonground())
		{
			wait(0.05);
		}

		common_scripts\utility::flag_clear("FlagPlayerJumping");
	}
}

//Function Number: 188
safehouseexitplayerleaps(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.965;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!level.player istouching(param_00))
	{
		return 0;
	}

	if(level.player getstance() != "stand")
	{
		return 0;
	}

	if(param_03 && level.player isonground())
	{
		return 0;
	}

	var_04 = level.player getplayerangles();
	var_04 = (0,var_04[1],0);
	var_05 = anglestoforward(var_04);
	var_06 = vectordot(var_05,param_01);
	if(var_06 < param_02)
	{
		return 0;
	}

	var_07 = level.player getvelocity();
	var_08 = distance((var_07[0],var_07[1],0),(0,0,0));
	if(var_08 < 162)
	{
		return 0;
	}

	return 1;
}

//Function Number: 189
xslicefade()
{
	maps\_hud_util::start_overlay("black");
	wait(0.1);
	maps\_hud_util::fade_in(1,"black");
}

//Function Number: 190
cafegeeseflyinganimation()
{
	var_00 = getent("CafeGooseOrg","targetname");
	var_01 = maps\_utility::spawn_anim_model("goose_01");
	var_02 = maps\_utility::spawn_anim_model("goose_02");
	var_03 = maps\_utility::spawn_anim_model("goose_03");
	var_04 = [var_01,var_02,var_03];
	wait(2);
	var_00 maps\_anim::anim_single(var_04,"market_intro_geese");
	maps\_utility::array_delete(var_04);
}

//Function Number: 191
cafecameraumbrella()
{
	var_00 = common_scripts\utility::getstruct("mitchel_blocker","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("lag_umbrella_01_b");
	common_scripts\utility::flag_wait("FlagSafeHouseFollowStart");
	var_01 delete();
}
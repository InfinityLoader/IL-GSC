/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_ending.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 122
 * Decompile Time: 1829 ms
 * Timestamp: 4/22/2024 2:31:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	endingprecache();
	endingflaginit();
	endingglobalvars();
	endingglobalsetup();
	maps\greece_ending_fx::main();
	maps\greece_ending_anim::main();
	maps\greece_ending_vo::main();
}

//Function Number: 2
endingprecache()
{
	maps\_microdronelauncher::init();
	precachemodel("viewhands_atlas_military");
	precachemodel("vb_civilian_mitchell");
	precachemodel("viewbody_atlas_military");
	precachemodel("greece_finale_truck");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp_opticsreddot_silencerpistol");
	precacheitem("iw5_arx160_sp");
	precacheitem("iw5_uts19_sp");
	precacheitem("rpg_player");
	precacheshader("fullscreen_lit_bloodsplat_01");
	precacheshader("waypoint_threat_tagged");
	precachemodel("breach_charge");
	precachemodel("breach_charge_obj");
	precachemodel("npc_titan45_base_loot");
	precachemodel("weapon_parabolic_knife");
	precachemodel("npc_mp_tactical_knife");
	precachemodel("npc_bal27_nocamo");
	precachemodel("kva_leader_head_cut_throat");
	precacheshellshock("greece_finale_car_impact");
	precacheshellshock("greece_finale_car_recovery");
	precacheitem("iw5_microdronelauncher_sp");
	precacherumble("grenade_rumble");
	precacherumble("artillery_rumble");
	precachestring(&"GREECE_HINT_ENDING_PLACE_CHARGE");
	precachestring(&"GREECE_HINT_ENDING_PLACE_CHARGE_KB");
	precachestring(&"GREECE_HINT_ENDING_OPEN_DOOR");
	precachestring(&"GREECE_HINT_ENDING_OPEN_DOOR_KB");
	precachestring(&"GREECE_FAIL_ENDING_KILL_HADES");
	precachestring(&"GREECE_FAIL_ENDING_PLACE_EXPLOSIVE");
	precachestring(&"GREECE_FAIL_ENDING_LEFT_MISSION");
	precachestring(&"GREECE_FAIL_ENDING_LATE_TRIGGER");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	precachestring(&"GREECE_OBJ_INTERCEPT_HADES");
	precachestring(&"GREECE_ENDING_AMBUSH_TIMER");
	precachestring(&"GREECE_OBJ_ENDING_PLACEBREACH");
	precachestring(&"GREECE_OBJ_ENDING_HADESVEHICLE");
	maps\_utility::add_hint_string("leaving_area",&"GREECE_HINT_ENDING_LEAVING_AREA",::hintleavingareaoff);
	maps\_utility::add_control_based_hint_strings("detonate_charge",&"GREECE_HINT_ENDING_DETONATE_CHARGE",::hintdetonateambushoff);
	maps\_utility::add_control_based_hint_strings("player_stab",&"GREECE_HINT_ENDING_MELEE_HADES",::hintplayerstaboff);
	maps\_utility::add_control_based_hint_strings("player_grab_gun",&"GREECE_HINT_ENDING_GRAB_GUN",::hintgrabgunoff,&"GREECE_HINT_ENDING_GRAB_GUN_KB");
	precachemodel("kva_heavy_head");
	precachemodel("kva_heavy_body");
	precacheitem("iw5_maul_sp");
	precachemodel("datachit_greece");
	maps\_hms_door_interact::precachedooranimations();
}

//Function Number: 3
endingflaginit()
{
	common_scripts\utility::flag_init("FlagEndingStart");
	common_scripts\utility::flag_init("FlagEndingAmbushStart");
	common_scripts\utility::flag_init("FlagEndingFightStart");
	common_scripts\utility::flag_init("FlagEndingHadesStart");
	common_scripts\utility::flag_init("FlagEndingIlanaShootIntoAir");
	common_scripts\utility::flag_init("FlagEndingTooFarWarn");
	common_scripts\utility::flag_init("FlagEndingTruckExplode");
	common_scripts\utility::flag_init("FlagEndingStoreFrontDestruction");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractBegin");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractGetToCover");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractNow");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractSuccess");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractFail");
	common_scripts\utility::flag_init("FlagEndingSetAmbushInteractComplete");
	common_scripts\utility::flag_init("FlagEndingForceShotgunSpawn");
	common_scripts\utility::flag_init("FlagEndingSpecialEnemiesDead");
	common_scripts\utility::flag_init("FlagGrabGunHintOff");
	common_scripts\utility::flag_init("FlagGrabGunSuccess");
	common_scripts\utility::flag_init("FlagEndingHadesVehicleInteractBegin");
	common_scripts\utility::flag_init("FlagEndingHadesVehicleInteractComplete");
	common_scripts\utility::flag_init("FlagEndingHadesStabInteractSuccess");
	common_scripts\utility::flag_init("FlagEndingHadesStabInteractFail");
	common_scripts\utility::flag_init("FlagEndingSetObjInterceptHades");
	common_scripts\utility::flag_init("FlagEndingMarkObjSetAmbush");
	common_scripts\utility::flag_init("FlagEndingUnMarkObjSetAmbush");
	common_scripts\utility::flag_init("FlagEndingMarkObjHadesVehicle");
	common_scripts\utility::flag_init("FlagEndingClearObjInterceptHades");
	common_scripts\utility::flag_init("FlagEndingIlanaWaitingAtAmbushPoint");
	common_scripts\utility::flag_init("FlagEndingLeavingAreaHintOff");
}

//Function Number: 4
endingglobalvars()
{
	level.showdebugtoggle = 0;
	level.dialogtable = "sp/greece_dialog.csv";
}

//Function Number: 5
endingglobalsetup()
{
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	level.endinghades = undefined;
	level.ambushtimer = undefined;
	thread endingbegin();
	thread endingobjectivesetup();
}

//Function Number: 6
endingstartpoints()
{
	maps\_utility::add_start("start_ending_ambush",::initendingambush);
	maps\_utility::add_start("start_ending_fight",::initendingfight);
	maps\_utility::add_start("start_ending_hades",::initendinghades);
	maps\greece_starts::add_greece_starts("ending");
}

//Function Number: 7
initendingambush()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartEnding","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	thread setupfinalebarrier();
	thread maps\greece_code::sunflareswap("sunflare_dim");
	thread endingburningsniper();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartEnding",1,1,"IlanaEnding");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingAmbush1Cover");
	var_00 = getentarray("EndingPreCrashTrigger","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}

	var_04 = getentarray("EndingPostCrashTrigger","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	var_07 = getent("UseTriggerEndingHadesVehicleInteract","targetname");
	var_07 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_set("FlagEndingStart");
	soundscripts\_snd::snd_message("start_ending_ambush_checkpoint");
	if(level.currentgen)
	{
		thread maps\greece_sniper_scramble::closeendinggates();
	}
}

//Function Number: 8
initendingfight()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartEndingFight","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	thread maps\greece_code::sunflareswap("sunflare_dim");
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
	thread maps\greece_ending_fx::endingfirehydrantfx();
	thread maps\greece_ending_fx::endingvehicledamageresidualfx();
	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartEndingFight",1,1,"IlanaEnding");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingFightStartCover");
	var_00 = getentarray("EndingPreCrashTrigger","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	var_04 = getentarray("EndingPostCrashTrigger","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 common_scripts\utility::trigger_on();
	}

	thread endingsetupvehicles();
	thread endingstorefrontdestroyedsetup();
	thread fruit_table_impact();
	thread setupfinalebarrier();
	thread spawnendingheli();
	var_07 = getent("UseTriggerEndingHadesVehicleInteract","targetname");
	var_07 common_scripts\utility::trigger_off();
	thread endingcrashglaunchercorpse(undefined,undefined,0);
	thread endingfightstart();
	level.allies["Ilona"] thread ilanaendingmovement();
	level notify("storefront_crash_veh3");
	common_scripts\utility::flag_set("FlagEndingFightStart");
	soundscripts\_snd::snd_message("start_ending_fight_checkpoint");
}

//Function Number: 9
initendinghades()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartEndingHades","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	thread maps\greece_code::sunflareswap("sunflare_dim");
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
	thread maps\greece_ending_fx::endingfirehydrantfx();
	thread maps\greece_ending_fx::endingvehicledamageresidualfx();
	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartEndingHades",1,1,"IlanaEnding");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingHadesStartCover");
	var_00 = getentarray("EndingPreCrashTrigger","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	var_04 = getentarray("EndingPostCrashTrigger","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	thread endingsetupvehicles();
	thread endingstorefrontdestroyedsetup();
	thread fruit_table_impact();
	thread setupfinalebarrier();
	thread spawnendingheli();
	var_07 = getent("UseTriggerEndingHadesVehicleInteract","targetname");
	var_07 common_scripts\utility::trigger_on();
	level.allies["Ilona"] thread ilanaendingmovement();
	level notify("storefront_crash_veh3");
	common_scripts\utility::flag_set("FlagEndingHadesStart");
	soundscripts\_snd::snd_message("start_ending_hades_checkpoint");
}

//Function Number: 10
endingobjectivesetup()
{
	waittillframeend;
	thread objintercepthades();
	endingsetcompletedobjflags();
}

//Function Number: 11
endingsetcompletedobjflags()
{
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_ending_"))
	{
		return;
	}

	common_scripts\utility::flag_set("FlagEndingSetObjInterceptHades");
	if(var_00 == "start_ending_ambush")
	{
		return;
	}

	common_scripts\utility::flag_set("FlagEndingMarkObjSetAmbush");
	common_scripts\utility::flag_set("FlagEndingUnMarkObjSetAmbush");
	if(var_00 == "start_ending_fight")
	{
		return;
	}

	common_scripts\utility::flag_set("FlagEndingMarkObjHadesVehicle");
	if(var_00 == "start_ending_hades")
	{
	}
}

//Function Number: 12
objintercepthades()
{
	common_scripts\utility::flag_wait("FlagEndingSetObjInterceptHades");
	var_00 = getent("EndingPlayerIED","targetname");
	var_00 hide();
	objective_add(maps\_utility::obj("InterceptHades"),"active",&"GREECE_OBJ_INTERCEPT_HADES",(0,0,0));
	objective_current(maps\_utility::obj("InterceptHades"));
	while(!isdefined(level.allies))
	{
		wait 0.05;
	}

	objective_onentity(maps\_utility::obj("InterceptHades"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	common_scripts\utility::flag_wait("FlagEndingMarkObjSetAmbush");
	var_01 = getent("EndingDetpackObj","targetname");
	objective_position(maps\_utility::obj("InterceptHades"),var_01.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_ENDING_PLACEBREACH");
	var_00 show();
	var_00 maps\_utility::glow();
	common_scripts\utility::flag_wait("FlagEndingUnMarkObjSetAmbush");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	var_00 maps\_utility::stopglow();
	var_00 delete();
	common_scripts\utility::flag_wait("FlagEndingMarkObjHadesVehicle");
	var_02 = getent("EndingHadesVehicleObj","targetname");
	objective_position(maps\_utility::obj("InterceptHades"),var_02.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_ENDING_HADESVEHICLE");
	var_03 = getent("hades_vehicle","targetname");
	var_03 hudoutlineenable(3,1,0);
	common_scripts\utility::flag_wait("FlagEndingClearObjInterceptHades");
	maps\_utility::objective_complete(maps\_utility::obj("InterceptHades"));
	var_03 hudoutlinedisable();
}

//Function Number: 13
endingbegin()
{
	common_scripts\utility::flag_wait_either("FlagEndingStart","FlagTriggerEndingStart");
	common_scripts\utility::flag_set("FlagEndingAmbushStart");
	common_scripts\utility::flag_set("FlagEndingSetObjInterceptHades");
	level.allies["Ilona"] thread ilanaendingmovement();
	thread endinghideprecrashents();
	thread endingsetupcivilians();
	thread endingsetupvehicles();
	thread endingstorefrontdestroyedsetup();
	thread fruit_table_impact();
	thread setupfinalebarrier();
	thread spawnendingheli();
	thread monitorendingplayerentrancemantle();
	thread monitorendingilanaentrancemantle();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	}
}

//Function Number: 14
monitorendingplayerentrancemantle()
{
	while(!common_scripts\utility::flag("FlagTriggerEndingJumpDown"))
	{
		if(level.player ismantling())
		{
			physicsexplosionsphere(level.player.origin,200,0,0.5);
			break;
		}

		wait 0.05;
	}
}

//Function Number: 15
monitorendingilanaentrancemantle()
{
	var_00 = maps\_hms_utility::getnamedally("Ilona");
	maps\_utility::trigger_wait_targetname("EndingIlanaEntranceMantle");
	physicsexplosionsphere(var_00.origin,200,0,0.5);
}

//Function Number: 16
endinghideprecrashents()
{
	var_00 = getentarray("EndingCrashGlauncherPickup","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 17
endinghidebigfinaleents()
{
	var_00 = getentarray("EndingCrashGlauncherPickup","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 18
endingcomplete()
{
	level waittill("EndingFadeOut");
	soundscripts\_snd::snd_message("mhunt_level_end");
	level.player maps\_hud_util::fade_out(0.5);
	wait(2);
	maps\_utility::nextmission();
}

//Function Number: 19
failhadesstabplayer(param_00)
{
	wait(param_00);
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - HADES KILLED PLAYER!!!");
	setdvar("ui_deadquote"," ");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 20
ilanaendingmovement()
{
	var_00 = level.start_point;
	wait 0.05;
	if(var_00 == "start_ending_fight")
	{
		thread ilanaendingfight();
		return;
	}

	if(var_00 == "start_ending_hades")
	{
		thread ilanaendinghades();
		return;
	}

	thread ilanaendingambush();
}

//Function Number: 21
ilanaendingambush()
{
	var_00 = getentarray("EndingPreCrashTrigger","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}

	var_04 = getentarray("EndingPostCrashTrigger","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	var_07 = getent("UseTriggerEndingHadesVehicleInteract","targetname");
	var_07 common_scripts\utility::trigger_off();
	endingtruckclip(0);
	common_scripts\utility::flag_wait_either("FlagEndingStart","FlagTriggerEndingStart");
	var_08 = common_scripts\utility::getstruct("EndingIlanaGunfireOrg","targetname");
	var_08 maps\_anim::anim_reach_solo(level.allies["Ilona"],"ilana_shoot_into_air");
	var_08 thread maps\_anim::anim_single_solo(level.allies["Ilona"],"ilana_shoot_into_air");
	level waittill("EndingFinaleCivsFlee");
	common_scripts\utility::flag_set("FlagEndingIlanaShootIntoAir");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingAmbush1Cover");
	common_scripts\utility::flag_wait("FlagEndingSetAmbushInteractGetToCover");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingAmbush2Cover");
	common_scripts\utility::flag_wait("FlagEndingFightStart");
	thread ilanaendingfight();
	endingtruckclip(1);
}

//Function Number: 22
ilanaendingfight()
{
	thread endingautosavetacticalthread();
	level.player thread maps\_hms_ai_utility::assistplayer();
	var_00 = maps\_hms_utility::getnamedally("Ilona");
	var_01 = getnode("AllyEndingFightStartCover","targetname");
	var_00 thread maps\_hms_ai_utility::gototogoal(var_01,"default",1);
	common_scripts\utility::flag_wait_all("FlagEndingPlayerAdvanceFight1","FlagEndingTruckExplode");
	if(isdefined(var_00.bestcovernode))
	{
		var_00.bestcovernode = undefined;
	}

	var_00 thread maps\_hms_ai_utility::playerleashbehavior();
	thread monitorplayerleftlowerpassage();
	common_scripts\utility::flag_wait_all("FlagEndingEnemiesAllDead","FlagEndingSpecialEnemiesDead");
	level notify("EndingEndAutosaveThread");
	thread maps\_utility::autosave_by_name();
	var_02 = getnode("AllyEndingHadesStartCover","targetname");
	var_00 maps\_hms_ai_utility::playerleashdisable();
	wait 0.05;
	var_00 thread maps\_hms_ai_utility::gototogoal(var_02,"cqb",1);
	thread ilanaendinghades();
}

//Function Number: 23
ilanaendinghades()
{
	soundscripts\_snd::snd_music_message("start_finale_streets_fight_end_music");
}

//Function Number: 24
monitorsetupambushtimer()
{
	level endon("AmbushTimerFreeze");
	level endon("AmbushLeaveMission");
	var_00 = 20;
	level.ambushtimer = maps\_hud_util::get_countdown_hud();
	level.ambushtimer.label = &"GREECE_ENDING_AMBUSH_TIMER";
	level.ambushtimer.x = -110;
	level.ambushtimer.y = 45;
	level.ambushtimer.alignx = "left";
	level.ambushtimer.horzalign = "center";
	level.ambushtimer.color = (0.95,0.95,1);
	level.ambushtimer settenthstimer(var_00);
	level.ambushtimer setpulsefx(30,900000,700);
	soundscripts\_snd::snd_music_message("start_finale_ied_setup_music");
	thread successsetupambushtimer(level.ambushtimer);
	var_01 = common_scripts\utility::waittill_notify_or_timeout_return("AmbushLeaveMission",var_00);
	wait(0.1);
	destroysetupambushtimer(level.ambushtimer);
	common_scripts\utility::flag_set("FlagEndingUnMarkObjSetAmbush");
	if(isdefined(var_01) && var_01 == "AmbushLeaveMission")
	{
		return;
	}

	var_02 = getent("UseTriggerEndingSetupAmbushInteract","targetname");
	var_02 makeunusable();
	level notify("AmbushTimerExpire");
	maps\_hms_utility::printlnscreenandconsole("TIMER EXPIRED!!!");
	thread failsetupambushtimerexpire();
	thread endinghadesconvoyenter();
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyEndingAmbush2Cover");
	var_03 = getent("hades_vehicle","targetname");
	level.allies["Ilona"] setentitytarget(var_03);
}

//Function Number: 25
failsetupambushtimerexpire()
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - TIMER EXPIRED!!!");
	thread maps\_utility::hint_fade();
	wait(1);
	maps\greece_ending_vo::endingfailtimerexpiredialogue();
	wait(0.5);
	setdvar("ui_deadquote",&"GREECE_FAIL_ENDING_PLACE_EXPLOSIVE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 26
failsetupambushleavemission()
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - LEFT MISSION AREA!!!");
	thread maps\_utility::hint_fade();
	destroysetupambushtimer(level.ambushtimer);
	wait(0.1);
	setdvar("ui_deadquote",&"GREECE_FAIL_ENDING_LEFT_MISSION");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 27
successsetupambushtimer(param_00)
{
	level endon("AmbushTimerExpire");
	level endon("AmbushLeaveMission");
	level waittill("AmbushTimerFreeze");
	destroysetupambushtimer(param_00);
}

//Function Number: 28
destroysetupambushtimer(param_00)
{
	if(isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 29
monitorleaveareawarning()
{
	var_00 = [];
	var_01 = getent("TriggerEndingSetupAmbushWarning1","targetname");
	var_00 = common_scripts\utility::add_to_array(var_00,var_01);
	var_02 = getent("TriggerEndingSetupAmbushWarning2","targetname");
	var_00 = common_scripts\utility::add_to_array(var_00,var_02);
	var_03 = 0;
	maps\greece_code::waittillplayeristouchinganytrigger(var_00);
	thread maps\_utility::display_hint("leaving_area");
	common_scripts\utility::flag_set("FlagEndingTooFarWarn");
	while(!common_scripts\utility::flag("FlagEndingUnMarkObjSetAmbush"))
	{
		wait 0.05;
		if(level.player istouching(var_01) == 1 || level.player istouching(var_02) == 1)
		{
			if(var_03 == 1)
			{
				common_scripts\utility::flag_clear("FlagEndingLeavingAreaHintOff");
				wait 0.05;
				thread maps\_utility::display_hint("leaving_area");
				var_03 = 0;
				continue;
			}
			else
			{
				continue;
			}

			continue;
		}

		if(level.player istouching(var_01) == 0 && level.player istouching(var_02) == 0)
		{
			var_03 = 1;
			common_scripts\utility::flag_set("FlagEndingLeavingAreaHintOff");
		}
	}

	common_scripts\utility::flag_set("FlagEndingLeavingAreaHintOff");
	var_01 common_scripts\utility::trigger_off();
	var_02 common_scripts\utility::trigger_off();
}

//Function Number: 30
hintleavingareaoff()
{
	return common_scripts\utility::flag("FlagEndingLeavingAreaHintOff");
}

//Function Number: 31
monitorplaceambushinteract()
{
	level endon("AmbushTimerExpire");
	level endon("AmbushLeaveMission");
	common_scripts\utility::flag_wait("FlagTriggerEndingJumpDown");
	level notify("audio_stop_restaurant_think");
	thread monitorleaveareawarning();
	var_00 = getent("UseTriggerEndingSetupAmbushInteract","targetname");
	var_00 makeusable();
	var_00 setcursorhint("HINT_NOICON");
	var_00 maps\_utility::addhinttrigger(&"GREECE_HINT_ENDING_PLACE_CHARGE",&"GREECE_HINT_ENDING_PLACE_CHARGE_KB");
	thread monitorplacebreachhint();
	var_00 waittill("trigger",var_01);
	var_00 delete();
	level notify("AmbushTimerFreeze");
	thread maps\_player_exo::player_exo_deactivate();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	thread maps\_utility::autosave_by_name("ending_ambush_start");
	common_scripts\utility::flag_set("FlagEndingSetAmbushInteractBegin");
	common_scripts\utility::flag_set("init_ending_ambush_interact_lighting_level");
	common_scripts\utility::flag_set("FlagEndingUnMarkObjSetAmbush");
	var_02 = common_scripts\utility::getstruct("EndingPlayerSetAmbushOrg","targetname");
	var_03 = maps\_utility::spawn_anim_model("player_ending_rig",var_02.origin,var_02.angles);
	var_03 hide();
	var_02 maps\_anim::anim_first_frame_solo(var_03,"ied_enter");
	var_04 = maps\_utility::spawn_anim_model("ied_device",var_02.origin);
	var_04.animname = "ied_device";
	var_04 maps\_anim::setanimtree();
	var_04 hide();
	var_02 maps\_anim::anim_first_frame_solo(var_04,"ied_enter");
	var_05 = [var_03,var_04];
	level.player playerlinktoblend(var_03,"tag_player",0.3);
	soundscripts\_snd::snd_message("player_place_ied_foley");
	wait(0.3);
	var_03 show();
	var_04 show();
	thread monitordetonateambushinteract();
	var_06 = spawn("script_model",var_03.origin);
	var_06 setmodel("kva_leader_head_cut_throat");
	var_07 = var_03 gettagorigin("TAG_WEAPON_RIGHT");
	var_08 = var_03 gettagangles("TAG_WEAPON_RIGHT");
	var_06.origin = var_07;
	var_06.angles = var_08;
	var_06 linkto(var_03,"TAG_WEAPON_RIGHT",(-15,7,-3),(0,-20,180));
	var_02 maps\_anim::anim_single(var_05,"ied_enter");
	var_06 delete();
	level notify("EndingAmbushWindowEnd");
	if(common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess"))
	{
		thread successdetonateambushinteract(var_02,var_05,var_04,var_03);
		return;
	}

	thread faildetonateambushinteract(var_02,var_05,var_04,var_03);
}

//Function Number: 32
monitorplacebreachhint()
{
	var_00 = getent("EndingDetpackObj","targetname");
	var_01 = maps\_shg_utility::hint_button_position("use",var_00.origin,128);
	common_scripts\utility::flag_wait_either("FlagEndingSetAmbushInteractBegin","FlagEndingUnMarkObjSetAmbush");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 33
monitordetonateambushinteract()
{
	level waittill("EndingAmbushGetToCover");
	common_scripts\utility::flag_set("FlagEndingSetAmbushInteractGetToCover");
	level waittill("EndingAmbushStartConvoy");
	thread endinghadesconvoyenter();
	level waittill("EndingAmbushSlowMotion");
	common_scripts\utility::flag_set("FlagEndingSetAmbushInteractNow");
	thread convoydetonateambushinteract();
}

//Function Number: 34
successdetonateambushinteract(param_00,param_01,param_02,param_03)
{
	param_00 notify("player_detonate_ied");
	common_scripts\utility::flag_set("Init_FlagEndingSetAmbushInteractBeginLighting");
	thread maps\greece_ending_fx::endingambushbreachexplosionfx();
	param_00 maps\_anim::anim_single(param_01,"ied_success");
	level.player unlink();
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	param_02 delete();
	param_03 delete();
	common_scripts\utility::flag_set("FlagEndingSetAmbushInteractComplete");
	thread maps\_utility::autosave_by_name("ending_ambush_end");
	thread maps\_player_exo::player_exo_activate();
}

//Function Number: 35
faildetonateambushinteract(param_00,param_01,param_02,param_03)
{
	maps\_hms_utility::printlnscreenandconsole("MISSION FAIL - CONVOY ESCAPED!!!");
	param_00 thread maps\_anim::anim_single(param_01,"ied_fail");
	wait(1);
	maps\greece_ending_vo::endingfailtimerexpiredialogue();
	wait(1);
	setdvar("ui_deadquote",&"GREECE_FAIL_ENDING_LATE_TRIGGER");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 36
convoydetonateambushinteract()
{
	var_00 = undefined;
	wait(0.4);
	thread monitordetonateambushsuccess();
	level.hint_nofadein = 1;
	thread maps\_utility::hintdisplayhandler("detonate_charge");
	wait(0.25);
	if(!common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess"))
	{
		var_00 = 1;
		setslowmotion(1,0.1,0.1);
		wait(0.2);
	}

	thread monitordetonateambushfail();
	var_01 = common_scripts\utility::flag_wait_any_return("FlagEndingSetAmbushInteractSuccess","FlagEndingSetAmbushInteractFail");
	level.hint_nofadein = undefined;
	if(isdefined(var_00))
	{
		if(var_01 == "FlagEndingSetAmbushInteractSuccess")
		{
			setslowmotion(0.1,1,0.25);
			return;
		}

		setslowmotion(0.1,1,0.25);
	}
}

//Function Number: 37
hintdetonateambushoff()
{
	if(common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess") || common_scripts\utility::flag("FlagEndingSetAmbushInteractFail"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
monitordetonateambushsuccess()
{
	level endon("EndingAmbushWindowEnd");
	soundscripts\_snd::snd_message("start_ied_convoy_ambush_expl");
	thread monitordetonateambushbuttonpress();
	level.player waittill("detonate_ied");
	common_scripts\utility::flag_set("FlagEndingSetAmbushInteractSuccess");
	level notify("EndingAmbushWindowEnd");
	soundscripts\_snd::snd_message("start_ied_convoy_slomo_end");
}

//Function Number: 39
monitordetonateambushbuttonpress()
{
	level endon("EndingAmbushWindowEnd");
	while(!common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess"))
	{
		if(level.player adsbuttonpressed() || level.player attackbuttonpressed())
		{
			level.player notify("detonate_ied");
		}

		wait 0.05;
	}
}

//Function Number: 40
monitordetonateambushfail()
{
	level waittill("EndingAmbushWindowEnd");
	soundscripts\_snd::snd_message("stop_ied_convoy_ambush_expl");
	if(!common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess"))
	{
		common_scripts\utility::flag_set("FlagEndingSetAmbushInteractFail");
	}
}

//Function Number: 41
endinghadesconvoyenter()
{
	wait(0.1);
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_01 = getent("hades_vehicle","targetname");
	var_02 = getent("hades_vehicle_clip","targetname");
	var_02 linkto(var_01);
	var_03 = getent("convoy_vehicle_2","targetname");
	var_04 = getent("convoy_vehicle_2_clip","targetname");
	var_04 linkto(var_03);
	var_05 = getent("convoy_vehicle_3","targetname");
	var_06 = getent("convoy_vehicle_3_clip","targetname");
	var_06 linkto(var_05);
	var_07 = getent("convoy_vehicle_4","targetname");
	var_08 = getent("convoy_vehicle_4_clip","targetname");
	var_08 linkto(var_07);
	var_09 = [var_01,var_03,var_05,var_07];
	thread endinghadesconvoyhitplayer();
	var_00 maps\_anim::anim_single(var_09,"convoy_enter");
	if(common_scripts\utility::flag("FlagEndingSetAmbushInteractSuccess"))
	{
		thread endinghadesconvoycrash();
		return;
	}

	thread endinghadesconvoyfail();
}

//Function Number: 42
endinghadesconvoycrash()
{
	thread endinghadesconvoycrashslomo();
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_01 = getent("hades_vehicle","targetname");
	var_02 = getent("convoy_vehicle_2","targetname");
	var_03 = getent("convoy_vehicle_3","targetname");
	var_04 = [var_01,var_02,var_03];
	thread endingcrashglaunchercorpse(var_00,"convoy_crash",1);
	thread maps\greece_ending_fx::endingvehicledamagefx();
	thread maps\greece_ending_fx::endingshopcrashfx();
	thread maps\greece_ending_fx::endingfirehydrantfx();
	common_scripts\utility::flag_set("FlagEndingStoreFrontDestruction");
	soundscripts\_snd::snd_message("convoy_crash_emitters");
	foreach(var_06 in var_04)
	{
		var_06 maps\_utility::anim_stopanimscripted();
	}

	var_00 maps\_anim::anim_single(var_04,"convoy_crash");
	thread setuphadescrashedvehicle();
	level notify("EndingDeleteVehicleClip");
	var_08 = getentarray("HadesConvoyVehicleVol","script_noteworthy");
	foreach(var_0A in var_08)
	{
		var_0A delete();
	}
}

//Function Number: 43
endinghadesconvoycrashslomo()
{
	setslowmotion(1,0.75,0.5);
	level waittill("EndingDeleteVehicleClip");
	setslowmotion(0.75,1,0.5);
}

//Function Number: 44
endinghadesconvoyfail()
{
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	thread endingcrashglaunchercorpse(var_00,"convoy_fail",1);
	var_01 = getent("hades_vehicle","targetname");
	var_02 = getent("convoy_vehicle_2","targetname");
	var_03 = getent("convoy_vehicle_3","targetname");
	var_04 = [var_01,var_02,var_03];
	var_00 maps\_anim::anim_single(var_04,"convoy_fail");
}

//Function Number: 45
endinghadesconvoyhitplayer()
{
	level endon("AmbushTimerFreeze");
	level endon("EndingDeleteVehicleClip");
	var_00 = getentarray("HadesConvoyVehicleVol","script_noteworthy");
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			if(level.player istouching(var_02))
			{
				level.player kill();
			}
		}

		wait 0.05;
	}
}

//Function Number: 46
endingfightstart()
{
	thread spawnendingenemies();
	var_00 = getentarray("EndingPostCrashTrigger","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}
}

//Function Number: 47
spawnendingenemies()
{
	if(level.currentgen)
	{
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("FlagEndingSpecialEnemiesDead",undefined,15,0);
	}

	soundscripts\_snd::snd_music_message("start_finale_streets_fight_music");
	thread spawnendingenemies01();
	thread spawnendingenemies02();
	thread spawnendingenemies03();
	thread spawnendingenemies04();
	thread spawnendingenemies05();
	thread spawnendingenemies06();
	thread spawnendingshotguna();
	thread spawnendingshotgunb();
}

//Function Number: 48
monitorendingenemies(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = param_00.size - param_02;
	maps\_utility::waittill_dead_or_dying(param_00,var_03);
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 49
spawnendingenemies01()
{
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	maps\_utility::array_spawn_function_targetname("EndingEnemy01",::endingcombatenemysetup);
	var_01 = maps\_utility::array_spawn_targetname("EndingEnemy01",1);
	thread spawnendingenemies01flood();
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "Truck3crawl")
		{
			var_03 thread maps\greece_ending_fx::stumbleonfirefx();
			var_03 thread endingenemycrawlthread("payback_pmc_sandstorm_stumble_1","run_death_flop");
			continue;
		}

		if(var_03.script_noteworthy == "Truck3stumble")
		{
			var_03 thread maps\greece_ending_fx::stumbleonfirefx();
			var_03 thread endingenemystumblethread("hms_greece_finale_exit_veh3_npc");
			continue;
		}

		var_03.animname = "veh3_guy2_exit";
		var_03 thread endingenemytruckexitthread(var_00);
	}

	thread maps\_hms_utility::aiarrayfallbackonflag(var_01,"FlagEndingPlayerAdvanceFight2","EndingEnemyVolCenter01");
	thread maps\_hms_utility::aiarraydeleteonflag(var_01,"FlagEndingPlayerAdvanceFight4");
	var_05 = getent("convoy_vehicle_3","targetname");
	var_00 thread maps\_anim::anim_single_solo(var_05,"enemy_exit");
}

//Function Number: 50
spawnendingenemies01flood()
{
	maps\_utility::array_spawn_function_targetname("EndingEnemy01flood",::endingcombatenemysetup);
	var_00 = getentarray("EndingEnemy01flood","targetname");
	thread maps\_utility::flood_spawn(var_00);
	thread maps\greece_code::killfloodspawnersonflag(3001,"FlagEndingPlayerAdvanceFight2");
	common_scripts\utility::flag_wait_either("FlagEndingPlayerAdvanceFight3","FlagTriggerEndingEnemy02Left");
	var_01 = maps\_utility::get_living_ai_array("EndingEnemy01flood_AI","targetname");
	var_02 = getent("EndingEnemyVolLowerRight01","targetname");
	foreach(var_04 in var_01)
	{
		var_04 setgoalvolumeauto(var_02);
	}

	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight4");
	var_01 = maps\_utility::get_living_ai_array("EndingEnemy01flood_AI","targetname");
	var_06 = getent("EndingEnemyVolCenter03","targetname");
	foreach(var_04 in var_01)
	{
		var_04 setgoalvolumeauto(var_06);
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_01,256);
}

//Function Number: 51
spawnendingenemies02()
{
	var_00 = common_scripts\utility::flag_wait_any_return("FlagTriggerEndingEnemy02Right","FlagTriggerEndingEnemy02Left");
	var_01 = getent("convoy_vehicle_3","targetname");
	var_01 notify("force_explosion");
	thread spawnendingenemies02flood();
	maps\_utility::array_spawn_function_targetname("EndingEnemy02",::endingcombatenemysetup);
	var_02 = maps\_utility::array_spawn_targetname("EndingEnemy02",1);
	var_03 = maps\_utility::get_living_ai_array("EndingEnemy02Floater","script_noteworthy");
	var_04 = [];
	switch(var_00)
	{
		case "FlagTriggerEndingEnemy02Right":
			var_04 = common_scripts\utility::getstructarray("EndingEnemy02TeleportRight","targetname");
			break;

		case "FlagTriggerEndingEnemy02Left":
			var_04 = common_scripts\utility::getstructarray("EndingEnemy02TeleportLeft","targetname");
			break;
	}

	endingenemyfloatersteleport(var_03,var_04);
	switch(var_00)
	{
		case "FlagTriggerEndingEnemy02Right":
			thread maps\_hms_utility::aiarrayfallbackonflag(var_02,"FlagEndingPlayerAdvanceFight3","EndingEnemyVolCenter02");
			thread maps\_hms_utility::aiarrayfallbackonflag(var_02,"FlagTriggerEndingShotgunALeft","EndingEnemyVolCenter02");
			break;

		case "FlagTriggerEndingEnemy02Left":
			thread maps\_hms_utility::aiarrayfallbackonflag(var_02,"FlagEndingPlayerAdvanceFight3","EndingEnemyVolCenter02");
			thread maps\_hms_utility::aiarrayfallbackonflag(var_02,"FlagTriggerEndingShotgunARight","EndingEnemyVolCenter02");
			break;
	}

	thread maps\_hms_utility::aiarraydeleteonflag(var_02,"FlagEndingPlayerAdvanceFight5");
}

//Function Number: 52
spawnendingenemies02flood()
{
	maps\_utility::array_spawn_function_targetname("EndingEnemy02flood",::endingcombatenemysetup);
	var_00 = getentarray("EndingEnemy02flood","targetname");
	thread maps\_utility::flood_spawn(var_00);
	thread maps\greece_code::killfloodspawnersonflag(3002,"FlagEndingPlayerAdvanceFight3");
	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight3");
	wait(1);
	var_01 = maps\_utility::get_living_ai_array("EndingEnemy02flood_AI","targetname");
	var_02 = getent("EndingEnemyVolUpperLeft02","targetname");
	foreach(var_04 in var_01)
	{
		var_04 setgoalvolumeauto(var_02);
	}

	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight4");
	var_01 = maps\_utility::get_living_ai_array("EndingEnemy02flood_AI","targetname");
	var_06 = getent("EndingEnemyVolCenter02","targetname");
	foreach(var_04 in var_01)
	{
		var_04 setgoalvolumeauto(var_06);
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_01,256);
}

//Function Number: 53
spawnendingenemies03()
{
	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight2");
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	maps\_utility::array_spawn_function_targetname("EndingEnemy03",::endingcombatenemysetup);
	var_01 = maps\_utility::array_spawn_targetname("EndingEnemy03",1);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "Truck2smg")
		{
			var_03.animname = "veh2_guy_exit";
			var_03 thread endingenemytruckexitthread(var_00);
		}

		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "EndingUpperLeft")
		{
			var_03 thread maps\_hms_utility::aifallbackonflag("FlagEndingPlayerAdvanceFight3","EndingEnemyVolUpperLeft02");
		}
	}

	thread maps\_hms_utility::aiarrayfallbackonflag(var_01,"FlagEndingPlayerAdvanceFight4","EndingEnemyVolCenter03");
	thread maps\_hms_utility::aiarraydeleteonflag(var_01,"FlagEndingPlayerAdvanceFight6");
	var_05 = getent("convoy_vehicle_2","targetname");
	var_00 thread maps\_anim::anim_single_solo(var_05,"enemy_exit");
}

//Function Number: 54
spawnendingenemies04()
{
	var_00 = common_scripts\utility::flag_wait_any_return("FlagTriggerEndingEnemy04Right","FlagTriggerEndingEnemy04Left");
	thread spawnendingenemies04flood();
	maps\_utility::array_spawn_function_targetname("EndingEnemy04",::endingcombatenemysetup);
	var_01 = maps\_utility::array_spawn_targetname("EndingEnemy04",1);
	var_02 = maps\_utility::get_living_ai_array("EndingEnemy04Floater","script_noteworthy");
	var_03 = [];
	switch(var_00)
	{
		case "FlagTriggerEndingEnemy04Right":
			var_03 = common_scripts\utility::getstructarray("EndingEnemy04TeleportRight","targetname");
			break;

		case "FlagTriggerEndingEnemy04Left":
			var_03 = common_scripts\utility::getstructarray("EndingEnemy04TeleportLeft","targetname");
			break;
	}

	endingenemyfloatersteleport(var_02,var_03);
	foreach(var_05 in var_01)
	{
		if(isdefined(var_05.script_noteworthy))
		{
			if(var_05.script_noteworthy == "Truck2crawl")
			{
				var_01 = common_scripts\utility::array_remove(var_01,var_05);
				var_05 thread endingenemycrawlthread("civilian_crawl_1","civilian_crawl_1_death_A");
				continue;
			}

			if(var_05.script_noteworthy == "Truck1rpg")
			{
				var_01 = common_scripts\utility::array_remove(var_01,var_05);
				var_05 thread endingenemysetupsuperguy();
			}
		}
	}

	thread maps\_hms_utility::aiarrayfallbackonflag(var_01,"FlagEndingPlayerAdvanceFight6","EndingEnemyVolCenter03");
}

//Function Number: 55
spawnendingenemies04flood()
{
	maps\_utility::array_spawn_function_targetname("EndingEnemy04flood",::endingcombatenemysetup);
	var_00 = getentarray("EndingEnemy04flood","targetname");
	thread maps\_utility::flood_spawn(var_00);
	thread maps\greece_code::killfloodspawnersonflag(3004,"FlagEndingPlayerAdvanceFight5");
	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight5");
	wait(1);
	var_01 = maps\_utility::get_living_ai_array("EndingEnemy04flood_AI","targetname");
	var_02 = getent("EndingEnemyVolCenter03","targetname");
	foreach(var_04 in var_01)
	{
		var_04 setgoalvolumeauto(var_02);
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_01,256);
}

//Function Number: 56
spawnendingenemies05()
{
	var_00 = common_scripts\utility::flag_wait_any_return("FlagTriggerEndingEnemy05Right","FlagTriggerEndingEnemy05Left");
	maps\_utility::array_spawn_function_targetname("EndingEnemy05",::endingcombatenemysetup);
	var_01 = maps\_utility::array_spawn_targetname("EndingEnemy05",1);
	var_02 = maps\_utility::get_living_ai_array("EndingEnemy05Floater","script_noteworthy");
	var_03 = [];
	switch(var_00)
	{
		case "FlagTriggerEndingEnemy05Right":
			var_03 = common_scripts\utility::getstructarray("EndingEnemy05TeleportRight","targetname");
			break;

		case "FlagTriggerEndingEnemy05Left":
			var_03 = common_scripts\utility::getstructarray("EndingEnemy05TeleportLeft","targetname");
			break;
	}

	endingenemyfloatersteleport(var_02,var_03);
	thread maps\_hms_utility::aiarrayfallbackonflag(var_01,"FlagEndingPlayerAdvanceFight6","EndingEnemyVolCenter03");
}

//Function Number: 57
spawnendingenemies06()
{
	common_scripts\utility::flag_wait("FlagEndingPlayerAdvanceFight5");
	maps\_utility::array_spawn_function_targetname("EndingEnemy06",::endingcombatenemysetup);
	var_00 = maps\_utility::array_spawn_targetname("EndingEnemy06",1);
	thread monitorforceshotgunspawn();
}

//Function Number: 58
spawnendingshotguna()
{
	var_00 = common_scripts\utility::flag_wait_any_return("FlagTriggerEndingShotgunALeft","FlagTriggerEndingShotgunAMid","FlagTriggerEndingShotgunARight");
	maps\_utility::array_spawn_function_targetname("EndingShotgunA",::endingcombatenemysetup);
	var_01 = maps\_utility::array_spawn_targetname("EndingShotgunA",1);
	var_02 = maps\_utility::get_living_ai_array("EndingShotgunAFloater","script_noteworthy");
	var_03 = [];
	switch(var_00)
	{
		case "FlagTriggerEndingShotgunALeft":
			var_03 = common_scripts\utility::getstructarray("EndingShotgunATeleportLeft","targetname");
			break;

		case "FlagTriggerEndingShotgunAMid":
			var_03 = common_scripts\utility::getstructarray("EndingShotgunATeleportMid","targetname");
			break;

		case "FlagTriggerEndingShotgunARight":
			var_03 = common_scripts\utility::getstructarray("EndingShotgunATeleportRight","targetname");
			break;
	}

	endingenemyshotgunnersteleport(var_02,var_03,"FlagEndingPlayerAdvanceFight3");
	thread maps\_hms_utility::aiarraydeleteonflag(var_01,"FlagEndingPlayerAdvanceFight6");
}

//Function Number: 59
spawnendingshotgunb()
{
	var_00 = common_scripts\utility::flag_wait_any_return("FlagTriggerEndingShotgunBLeft","FlagTriggerEndingShotgunBMid","FlagTriggerEndingShotgunBRight","FlagEndingForceShotgunSpawn");
	var_01 = "EndingShotgunB";
	if(var_00 == "FlagEndingForceShotgunSpawn")
	{
		var_01 = "EndingAltShotgunB";
	}

	maps\_utility::array_spawn_function_targetname(var_01,::endingcombatenemysetup);
	var_02 = maps\_utility::array_spawn_targetname(var_01,1);
	var_03 = maps\_utility::get_living_ai_array("EndingShotgunBFloater","script_noteworthy");
	var_04 = [];
	switch(var_00)
	{
		case "FlagTriggerEndingShotgunBLeft":
			var_04 = common_scripts\utility::getstructarray("EndingShotgunBTeleportLeft","targetname");
			break;

		case "FlagTriggerEndingShotgunBMid":
			var_04 = common_scripts\utility::getstructarray("EndingShotgunBTeleportMid","targetname");
			break;

		case "FlagTriggerEndingShotgunBRight":
			var_04 = common_scripts\utility::getstructarray("EndingShotgunBTeleportRight","targetname");
			break;

		case "FlagEndingForceShotgunSpawn":
			var_04 = common_scripts\utility::getstructarray("EndingShotgunBTeleportAlt","targetname");
			break;
	}

	if(var_00 == "FlagEndingForceShotgunSpawn")
	{
		foreach(var_06 in var_02)
		{
			var_06 thread endingenemysetupsuperguy();
		}
	}
	else
	{
		var_08 = maps\_utility::get_living_ai("EndingShotgunBNonFloater","script_noteworthy");
		var_09 = getnode("EndingShotgunBCenterGoal","targetname");
		var_08 thread maps\_hms_ai_utility::setupshotgunkva(level.player,var_09);
		var_08 thread shotgunabortdefendgoalonflag("FlagEndingPlayerAdvanceFight6");
	}

	endingenemyshotgunnersteleport(var_03,var_04,"FlagEndingPlayerAdvanceFight6");
	maps\_utility::waittill_dead_or_dying(var_02);
	common_scripts\utility::flag_set("FlagEndingSpecialEnemiesDead");
}

//Function Number: 60
shotgunabortdefendgoalonflag(param_00,param_01,param_02)
{
	self endon("death");
	if(isdefined(param_01) && isdefined(param_02))
	{
		common_scripts\utility::flag_wait_any(param_00,param_01,param_02);
	}
	else if(isdefined(param_01))
	{
		common_scripts\utility::flag_wait_either(param_00,param_01);
	}
	else
	{
		common_scripts\utility::flag_wait(param_00);
	}

	self notify("Abort_Defend_Goal");
}

//Function Number: 61
monitorforceshotgunspawn()
{
	wait(1);
	var_00 = getaiarray("axis");
	var_01 = maps\_utility::get_living_ai_array("EndingCineKVA_AI","targetname");
	var_00 = common_scripts\utility::array_remove_array(var_00,var_01);
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	monitorendingenemies(var_00,"FlagEndingForceShotgunSpawn",1);
}

//Function Number: 62
endingenemytruckexitthread(param_00)
{
	self endon("death");
	param_00 thread maps\_anim::anim_single_solo_run(self,"enemy_exit");
	self.allowdeath = 1;
	thread explosiveragdolldeath();
	param_00 waittill("enemy_exit");
}

//Function Number: 63
endingenemystumblethread(param_00)
{
	self endon("death");
	self.ignoresonicaoe = 1;
	self.health = 1;
	self.allowdeath = 1;
	thread maps\greece_code::setragdolldeath();
	thread explosiveragdolldeath();
	self.animname = "generic";
	maps\_utility::gun_remove();
	maps\_utility::set_ignoreall(1);
	maps\_utility::disable_arrivals();
	maps\_utility::disable_exits();
	var_01 = self.script_noteworthy + "Org";
	var_02 = common_scripts\utility::getstruct(var_01,"script_noteworthy");
	var_02 maps\_anim::anim_single_solo(self,param_00);
	if(isdefined(self))
	{
		self kill(self.origin,level.player);
	}
}

//Function Number: 64
endingenemycrawlthread(param_00,param_01)
{
	self endon("death");
	self.iscrawling = 1;
	self.ignoresonicaoe = 1;
	self.health = 1;
	maps\_utility::set_goal_radius(32);
	self.allowdeath = 1;
	self.animname = "generic";
	maps\_utility::gun_remove();
	maps\_utility::set_ignoreall(1);
	maps\_utility::disable_arrivals();
	maps\_utility::disable_exits();
	maps\_utility::set_deathanim(param_01);
	maps\_utility::set_run_anim(param_00,1);
	var_02 = self.script_noteworthy + "Org";
	var_03 = common_scripts\utility::getstruct(var_02,"script_noteworthy");
	self forceteleport(var_03.origin,var_03.angles);
	var_04 = self.script_noteworthy + "Goal";
	var_05 = common_scripts\utility::getstruct(var_04,"script_noteworthy");
	maps\_utility::set_goal_pos(var_05.origin);
	thread monitorenemycrawlplayerdist();
	common_scripts\utility::waittill_either("goal","player_near");
	maps\_anim::anim_single_solo(self,param_01);
	if(isdefined(self))
	{
		self kill(self.origin,level.player);
	}
}

//Function Number: 65
monitorenemycrawlplayerdist()
{
	self endon("death");
	for(;;)
	{
		if(maps\_utility::players_within_distance(64,self.origin))
		{
			self notify("player_near");
		}

		wait(0.1);
	}
}

//Function Number: 66
endingenemyfloatersteleport(param_00,param_01)
{
	param_00 = common_scripts\utility::array_randomize(param_00);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_01[var_02];
		param_00[var_02] forceteleport(var_03.origin,var_03.angles);
		if(isdefined(var_03.target))
		{
			var_04 = var_03.target;
			var_05 = getent(var_04,"targetname");
			if(isdefined(var_05))
			{
				param_00[var_02] setgoalvolumeauto(var_05);
			}
			else
			{
				var_06 = common_scripts\utility::getstruct(var_04,"targetname");
				param_00[var_02] maps\_utility::set_goal_pos(var_06.origin);
			}
		}
	}
}

//Function Number: 67
endingenemyshotgunnersteleport(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_01[var_03];
		param_00[var_03] forceteleport(var_04.origin,var_04.angles);
		if(isdefined(var_04.target))
		{
			var_05 = var_04.target;
			var_06 = getnode(var_05,"targetname");
			param_00[var_03] thread maps\_hms_ai_utility::setupshotgunkva(level.player,var_06);
			param_00[var_03] thread shotgunabortdefendgoalonflag(param_02);
		}
	}
}

//Function Number: 68
endingcombatenemysetup()
{
	maps\_utility::disable_surprise();
	maps\_utility::disable_long_death();
	thread explosiveragdolldeath();
	thread explosivedamagemonitor();
}

//Function Number: 69
explosiveragdolldeath()
{
	self.ragdoll_immediate = 1;
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(self))
	{
		return;
	}

	self stopanimscripted();
	if((isdefined(var_01) && var_01 == "MOD_MELEE") || var_01 == "MOD_RIFLE_BULLET" || var_01 == "MOD_PISTOL_BULLET")
	{
		self.ragdoll_immediate = undefined;
		return;
	}

	animscripts\shared::dropallaiweapons();
}

//Function Number: 70
explosivedamagemonitor()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_01 != level.player)
		{
			continue;
		}

		var_05 = 0;
		if(var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE" || var_04 == "MOD_PROJECTILE")
		{
			var_05 = var_00 * 1;
		}
		else if(var_04 == "MOD_EXPLOSIVE_SPLASH" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE_SPLASH")
		{
			var_05 = var_00 * 0.5;
		}

		if(var_05 > 0)
		{
			self dodamage(var_05,self.origin,level.player);
		}
	}
}

//Function Number: 71
explosiveimpulse()
{
	self endon("death");
	var_00 = 128;
	for(;;)
	{
		self waittill("missile_fire",var_01,var_02);
		if(var_02 == "iw5_microdronelauncher_sp")
		{
			var_01 waittill("explode");
			var_03 = var_01.origin;
			if(!isdefined(var_03))
			{
				continue;
			}

			earthquake(0.4,0.35,var_03,1024);
			wait(0.1);
			physicsexplosionsphere(var_03,var_00,0,randomfloatrange(2,3));
		}
	}
}

//Function Number: 72
endingenemysetupsuperguy()
{
	maps\_utility::disable_surprise();
	self.disablebulletwhizbyreaction = 1;
	self.grenadeammo = 0;
	self.health = 1000;
	self.minpaindamage = 75;
	self.a.disablelongdeath = 1;
	self.a.disablelongpain = 1;
	self.ignoresuppression = 1;
	self.disablereactionanims = 1;
	self.no_pistol_switch = 1;
	self.dontmelee = 1;
	self setmodel("kva_heavy_body");
	thread codescripts\character::setheadmodel("kva_heavy_head");
	maps\_utility::set_battlechatter(0);
	thread maps\_hms_ai_utility::painmanagement();
	thread explosivedamagemonitor();
	thread maps\_hms_ai_utility::_shotgunnerambience();
	self waittill("death");
	if(soundexists("shotgunner_death_fx"))
	{
		var_00 = spawn("script_origin",self.origin);
		var_00 thread maps\_utility::play_sound_on_entity("shotgunner_death_fx","deathsfx_ended");
		var_00 waittill("deathsfx_ended");
		var_00 delete();
	}
}

//Function Number: 73
endingcrashglaunchercorpse(param_00,param_01,param_02)
{
	var_03 = maps\_utility::spawn_targetname("EndingEnemyGlauncherCorpse",1);
	var_03 maps\_utility::gun_remove();
	var_03.health = 9999999;
	var_03.animname = "generic";
	var_03 maps\_utility::set_ignoreall(1);
	var_03 maps\_utility::set_ignoreme(1);
	if(param_02 == 1)
	{
		param_00 maps\_anim::anim_single_solo(var_03,param_01);
		var_03 maps\greece_code::kill_no_react(0);
	}
	else
	{
		var_03 kill();
	}

	var_04 = getentarray("EndingCrashGlauncherPickup","targetname");
	foreach(var_06 in var_04)
	{
		var_06 show();
		var_06 hudoutlineenable(2);
		var_06 thread monitorplayerpickupglauncher();
		var_06 thread glaunchericonthink();
	}

	level.player thread explosiveimpulse();
}

//Function Number: 74
monitorplayerpickupglauncher(param_00)
{
	for(;;)
	{
		if(level.player hasweapon("iw5_microdronelauncher_sp"))
		{
			self notify("remove_glauncher_icon");
			break;
		}

		wait 0.05;
	}

	level.player givemaxammo("iw5_microdronelauncher_sp");
	level.player setweaponammoclip("iw5_microdronelauncher_sp",weaponclipsize("iw5_microdronelauncher_sp"));
}

//Function Number: 75
glaunchericonthink()
{
	self endon("remove_glauncher_icon");
	common_scripts\utility::flag_wait("FlagEndingFightStart");
	var_00 = spawn("trigger_radius",self.origin,0,320,72);
	var_01 = newhudelem();
	var_01 setshader("waypoint_threat_tagged",1,1);
	var_01.alpha = 0;
	var_01.color = (1,1,1);
	var_01.x = self.origin[0];
	var_01.y = self.origin[1];
	var_01.z = self.origin[2] + 16;
	var_01 setwaypoint(1,1);
	self.glauncher_icon = var_01;
	self.glauncher_icon_trig = var_00;
	if(isdefined(self.icon_always_show) && self.icon_always_show)
	{
		glauncher_icon_fade_in(var_01);
		return;
	}

	wait(0.05);
	while(isdefined(self))
	{
		var_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		while(var_02 istouching(var_00))
		{
			var_03 = 1;
			if(level.player hasweapon("iw5_microdronelauncher_sp"))
			{
				var_03 = 0;
			}

			if(isdefined(self) && maps\_utility::player_looking_at(self.origin,0.8,1) && var_03)
			{
				glauncher_icon_fade_in(var_01);
				continue;
			}

			glauncher_icon_fade_out(var_01);
			wait(0.25);
		}

		glauncher_icon_fade_out(var_01);
	}
}

//Function Number: 76
glauncher_icon_fade_in(param_00)
{
	if(param_00.alpha != 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0.3;
	wait(0.2);
}

//Function Number: 77
glauncher_icon_fade_out(param_00)
{
	if(param_00.alpha == 0)
	{
		return;
	}

	param_00 fadeovertime(0.2);
	param_00.alpha = 0;
	wait(0.2);
}

//Function Number: 78
monitorplayerleftlowerpassage()
{
	maps\_utility::trigger_wait_targetname("EndingLeftLowerVol");
	thread sendallenemiesintriggertogoalvol("EndingLeftUpperVol","EndingEnemyVolCenter03");
}

//Function Number: 79
sendallenemiesintriggertogoalvol(param_00,param_01)
{
	var_02 = getaiarray("axis");
	var_03 = getent(param_00,"targetname");
	var_04 = getent(param_01,"targetname");
	var_05 = [];
	var_02 = maps\_utility::array_removedead_or_dying(var_02);
	foreach(var_07 in var_02)
	{
		if(isdefined(var_07) && var_07 istouching(var_03))
		{
			var_05 = common_scripts\utility::add_to_array(var_05,var_07);
			var_07 setgoalvolumeauto(var_04);
			var_07.favoriteenemy = level.player;
		}
	}

	maps\_hms_utility::printlnscreenandconsole("Sending " + var_05.size + " enemies to volume " + param_01);
}

//Function Number: 80
endingsetupvehicles()
{
	var_00 = getent("hades_vehicle","targetname");
	var_00 maps\_utility::assign_animtree("hades_vehicle");
	var_00.animname = "hades_vehicle";
	var_01 = getent("enemy_vehicle","targetname");
	var_01 maps\_utility::assign_animtree("enemy_vehicle");
	var_01.animname = "enemy_vehicle";
	var_02 = getent("convoy_vehicle_2","targetname");
	var_02 maps\_utility::assign_animtree("convoy_vehicle_2");
	var_02.animname = "convoy_vehicle_2";
	var_03 = getent("convoy_vehicle_3","targetname");
	var_03 maps\_utility::assign_animtree("convoy_vehicle_3");
	var_03.animname = "convoy_vehicle_3";
	thread monitorconvoyvehicle3();
	var_04 = getent("convoy_vehicle_4","targetname");
	var_04 maps\_utility::assign_animtree("convoy_vehicle_4");
	var_04.animname = "convoy_vehicle_4";
	var_05 = level.start_point;
	if(var_05 == "start_ending_fight" || var_05 == "start_ending_hades")
	{
		thread setuphadescrashedvehicle();
		thread setupconvoycrashedvehicles();
	}
}

//Function Number: 81
setuphadescrashedvehicle()
{
	level.endinghades = maps\_utility::spawn_script_noteworthy("EndingHades",1);
	level.endinghades.animname = "Hades";
	level.endinghades.script_parameters = "Hades";
	level.endinghades.neverdelete = 1;
	level.endinghades setupaiforendinganim(1);
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.endinghades,"start_idle","stop_loop");
	var_01 = maps\_utility::spawn_script_noteworthy("EndingNPC1",1);
	var_01.animname = "npc1";
	var_01.neverdelete = 1;
	var_01 setupaiforendinganim(1);
	var_00 maps\_anim::anim_first_frame_solo(var_01,"start_idle");
}

//Function Number: 82
setupconvoycrashedvehicles()
{
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_01 = getent("convoy_vehicle_2","targetname");
	var_02 = getent("convoy_vehicle_3","targetname");
	var_03 = [var_01,var_02];
	var_00 thread maps\_anim::anim_first_frame(var_03,"enemy_exit");
	var_04 = getent("convoy_vehicle_4","targetname");
	var_00 thread maps\_anim::anim_last_frame_solo(var_04,"convoy_enter");
	var_05 = getent("hades_vehicle","targetname");
	var_00 maps\_anim::anim_first_frame_solo(var_05,"enemy_exit");
}

//Function Number: 83
setupfinalebarrier()
{
	var_00 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_01 = getent("greece_finale_barrier","targetname");
	var_01 maps\_utility::assign_animtree("finale_barrier");
	var_01.animname = "finale_barrier";
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"start_action");
}

//Function Number: 84
monitorhadesvehicleinteract()
{
	var_00 = getent("UseTriggerEndingHadesVehicleInteract","targetname");
	var_00 common_scripts\utility::trigger_on();
	var_00 makeusable();
	var_00 setcursorhint("HINT_NOICON");
	var_00 maps\_utility::addhinttrigger(&"GREECE_HINT_ENDING_OPEN_DOOR",&"GREECE_HINT_ENDING_OPEN_DOOR_KB");
	thread monitorhadesvehiclehint();
	var_00 waittill("trigger",var_01);
	var_00 delete();
	common_scripts\utility::flag_set("FlagEndingHadesVehicleInteractBegin");
	common_scripts\utility::flag_set("FlagEndingClearObjInterceptHades");
	thread bigfinale();
}

//Function Number: 85
monitorhadesvehiclehint()
{
	var_00 = getent("EndingHadesVehicleObj","targetname");
	var_01 = maps\_shg_utility::hint_button_position("use",var_00.origin,128);
	common_scripts\utility::flag_wait("FlagEndingHadesVehicleInteractBegin");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 86
bigfinale()
{
	thread maps\_player_exo::player_exo_deactivate();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	thread maps\_utility::autosave_by_name("ending_finale_start");
	soundscripts\_snd::snd_music_message("start_finale_hades_extraction_music");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::battlechatter_off("allies");
	thread endinghidebigfinaleents();
	level.endinghades setthreatdetection("disable");
	var_00 = maps\_utility::get_living_ai("EndingNPC1","script_noteworthy");
	var_00 setthreatdetection("disable");
	level notify("EndingStartBigFinale");
	var_01 = getent("EndingPlayerHadesVehicleOrg","targetname");
	var_02 = maps\_utility::spawn_anim_model("player_ending_rig",var_01.origin,var_01.angles);
	var_02 hide();
	var_01 maps\_anim::anim_first_frame_solo(var_02,"start_action");
	level.player playerlinktoblend(var_02,"tag_player",0.3);
	wait(0.3);
	var_02 show();
	var_03 = getent("hades_vehicle","targetname");
	var_04 = getent("enemy_vehicle","targetname");
	var_05 = getent("greece_finale_barrier","targetname");
	var_06 = maps\_hms_utility::getnamedally("Ilona");
	var_06 setupaiforendinganim();
	thread setupbigfinaleguys();
	thread setupfinalebarrier();
	thread bigfinaleenemytruckdamagesetup(var_04);
	var_01 notify("hades_vehicle_interact");
	thread maps\greece_ending_fx::endingplayercarpinnedfx();
	thread bigfinaleplayershoot(var_01,var_02);
	var_07 = [var_03,var_04,level.endinghades,var_06,var_05];
	var_01 maps\_anim::anim_single(var_07,"start_action");
	level notify("EndingFinalePlayerHit");
	soundscripts\_snd::snd_message("start_finale_suv_damage");
	thread maps\_utility::autosave_by_name("ending_finale_player_hit");
	thread bigfinaleplayerstab();
	thread bigfinaleplayergrabgun(var_01,var_02);
	var_06 maps\_utility::anim_stopanimscripted();
	var_08 = [var_04,var_06,level.endinghades];
	var_01 maps\_anim::anim_single(var_08,"fight_action");
	level notify("EndingFinaleStabSlomoEnd");
	var_09 = [var_02,var_04,var_06,level.endinghades];
	if(common_scripts\utility::flag("FlagEndingHadesStabInteractSuccess"))
	{
		var_01 maps\_anim::anim_single(var_09,"fight_success");
	}
	else
	{
		var_0A = [var_04,var_06,level.endinghades];
		bigfinaleplayerstabfail(var_01,var_0A,var_02);
		return;
	}

	var_0B = maps\_utility::spawn_anim_model("finale_data");
	level notify("EndingFinalePlayerHideKnife");
	var_0C = [var_05,var_07,level.endinghades,var_0B];
	var_02 thread maps\_anim::anim_single_solo(var_03,"end_sequence");
	thread endingcomplete();
	var_07.disablefacialfilleranims = 1;
	var_02 maps\_anim::anim_single(var_0C,"end_sequence");
}

//Function Number: 87
setupbigfinaleguys()
{
	var_00 = getent("enemy_vehicle","targetname");
	var_01 = var_00 gettagorigin("TAG_DRIVER");
	var_02 = var_00 gettagangles("TAG_DRIVER");
	var_03 = var_00 gettagorigin("TAG_PASSENGER");
	var_04 = var_00 gettagangles("TAG_PASSENGER");
	var_05 = (-3,-8,-44.5);
	var_06 = maps\_utility::spawn_script_noteworthy("EndingNPC2",1);
	var_06.animname = "npc2";
	var_06.health = 999999999;
	var_06 setupaiforendinganim();
	var_06 linkto(var_00,"TAG_DRIVER",var_05,(0,0,0));
	var_06 forceteleport(var_01 + var_05,var_02);
	var_06 maps\_utility::forceuseweapon("iw5_titan45_sp","primary");
	var_06 thread maps\_anim::anim_single_solo(var_06,"veh_idle");
	var_07 = maps\_utility::spawn_script_noteworthy("EndingNPC3",1);
	var_07.animname = "npc3";
	var_07.health = 999999999;
	var_07 setupaiforendinganim();
	var_07 linkto(var_00,"TAG_PASSENGER",var_05,(0,0,0));
	var_07 forceteleport(var_03 + var_05,var_04);
	var_07 thread maps\_anim::anim_single_solo(var_07,"veh_idle");
	level waittill("EndingFinalePlayerHit");
	var_06 thread maps\_anim::anim_single_solo(var_06,"veh_death");
	var_07 thread maps\_anim::anim_single_solo(var_07,"veh_death");
}

//Function Number: 88
bigfinaleplayershoot(param_00,param_01)
{
	param_00 thread maps\_anim::anim_single_solo(param_01,"start_action");
	level waittill("EndingFinaleShootSlomoStart");
	level.player takeallweapons();
	level.player disableweaponswitch();
	level.player playerlinktodelta(param_01,"tag_player",0,30,30,15,15,0,0);
	level.player enableslowaim(0.75,0.75);
	level.player enableweapons();
	level.player giveweapon("iw5_titan45_sp_opticsreddot_silencerpistol");
	level.player switchtoweaponimmediate("iw5_titan45_sp_opticsreddot_silencerpistol");
	soundscripts\_snd::snd_message("start_hades_suv_extraction");
	setslowmotion(1,0.25,0.25);
	level waittill("EndingFinaleShootSlomoEnd");
	soundscripts\_snd::snd_message("stop_hades_suv_extraction");
	setslowmotion(0.25,1,0.25);
	level waittill("EndingFinalePlayerHit");
	level.player playerlinktoblend(param_01,"tag_player",0);
	thread bigfinalehadesknife();
	thread bigfinalehitflash();
	level.player disableweapons();
	level.player takeallweapons();
	level.player shellshock("greece_finale_car_impact",0.5);
	earthquake(0.65,0.6,level.player.origin,128);
	level.player playrumbleonentity("damage_heavy");
	level.player dodamage(level.player.health - 1,(0,0,0));
	wait(0.5);
	level.player shellshock("greece_finale_car_recovery",10);
}

//Function Number: 89
bigfinalehitflash()
{
	var_00 = maps\_hud_util::get_optional_overlay("white");
	var_00.alpha = 1;
	wait(0.05);
	maps\_hud_util::fade_in(0.1,"white");
}

//Function Number: 90
bigfinaleplayerlosegun(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("npc_titan45_base_loot");
	var_02 = param_00 gettagorigin("TAG_WEAPON_RIGHT");
	var_03 = param_00 gettagangles("TAG_WEAPON_RIGHT");
	var_01.origin = var_02;
	var_01.angles = var_03;
	var_01 linkto(param_00,"TAG_WEAPON_RIGHT");
	level waittill("EndingFinaleHidePlayerGun");
	var_01 delete();
}

//Function Number: 91
bigfinaleilanashoot()
{
	var_00 = maps\_hms_utility::getnamedally("Ilona");
	var_01 = getnode("AllyEndingHadesTruckCover1","targetname");
	var_00 thread maps\_hms_ai_utility::gototogoal(var_01,"cqb",1);
	level waittill("EndingIlanaShootTruck");
	var_02 = getent("enemy_vehicle","targetname");
	var_03 = maps\_utility::get_living_ai("EndingNPC2","script_noteworthy");
	var_00.favoriteenemy = var_03;
	var_00 setentitytarget(var_02);
	var_00 thread bigfinaleilanamagicshoot(var_03);
	level waittill("EndingFinaleVehCrashGate");
	wait 0.05;
	var_00.favoriteenemy = undefined;
	var_00 clearentitytarget(var_02);
	var_04 = getnode("AllyEndingHadesTruckCover2","targetname");
	var_00 thread maps\_hms_ai_utility::gototogoal(var_04,"default",1);
}

//Function Number: 92
bigfinaleilanamagicshoot(param_00)
{
	level endon("EndingFinaleVehCrashGate");
	var_01 = self geteye();
	for(;;)
	{
		var_02 = param_00 geteye();
		self shoot();
		wait(randomfloatrange(0.1,0.2));
	}
}

//Function Number: 93
bigfinaleplayerknife(param_00)
{
	level waittill("EndingFinalePlayerShowKnife");
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("npc_mp_tactical_knife");
	var_02 = param_00 gettagorigin("TAG_WEAPON_LEFT");
	var_03 = param_00 gettagangles("TAG_WEAPON_LEFT");
	var_01.origin = var_02;
	var_01.angles = var_03;
	var_01 linkto(param_00,"TAG_WEAPON_LEFT");
	level waittill("EndingFinalePlayerHideKnife");
	param_00 notify("EndingFinaleCheckGun");
	var_01 delete();
}

//Function Number: 94
bigfinalehadesknife()
{
	var_00 = spawn("script_model",level.endinghades.origin);
	var_00 setmodel("npc_mp_tactical_knife");
	var_01 = level.endinghades gettagorigin("tag_weapon_right");
	var_02 = level.endinghades gettagangles("tag_weapon_right");
	var_00.origin = var_01;
	var_00.angles = var_02;
	var_00 linkto(level.endinghades,"TAG_WEAPON_RIGHT");
	level waittill("EndingFinalePlayerHideKnife");
	var_00 delete();
}

//Function Number: 95
bigfinaleplayerstab()
{
	var_00 = undefined;
	level waittill("EndingFinaleStabSlomoStart");
	level notify("EndingFinaleHidePlayerGun");
	thread monitorhadesstabsuccess();
	level.hint_nofadein = 1;
	thread maps\_utility::hintdisplayhandler("player_stab",undefined,undefined,undefined,undefined,200);
	wait(0.25);
	if(!common_scripts\utility::flag("FlagEndingHadesStabInteractSuccess"))
	{
		var_00 = 1;
		setslowmotion(1,0.25,0.25);
		wait(0.25);
	}

	thread monitorhadesstabfail();
	common_scripts\utility::flag_wait_either("FlagEndingHadesStabInteractSuccess","FlagEndingHadesStabInteractFail");
	level.hint_nofadein = undefined;
	if(isdefined(var_00))
	{
		setslowmotion(0.25,1,0.25);
	}

	level notify("EndingFinaleStabSlomoEnd");
}

//Function Number: 96
hintplayerstaboff()
{
	if(common_scripts\utility::flag("FlagEndingHadesStabInteractSuccess") || common_scripts\utility::flag("FlagEndingHadesStabInteractFail"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 97
monitorhadesstabsuccess()
{
	level endon("EndingFinaleStabSlomoEnd");
	thread monitorhadesstabbuttonpress();
	level.player waittill("stab_hades");
	common_scripts\utility::flag_set("FlagEndingHadesStabInteractSuccess");
	level notify("EndingFinaleStabSlomoEnd");
}

//Function Number: 98
monitorhadesstabbuttonpress()
{
	level endon("EndingFinaleStabSlomoEnd");
	while(!common_scripts\utility::flag("FlagEndingHadesStabInteractSuccess"))
	{
		if(level.player meleebuttonpressed() || level.player attackbuttonpressed())
		{
			level.player notify("stab_hades");
		}

		wait 0.05;
	}
}

//Function Number: 99
monitorhadesstabfail()
{
	level waittill("EndingFinaleStabSlomoEnd");
	if(!common_scripts\utility::flag("FlagEndingHadesStabInteractSuccess"))
	{
		common_scripts\utility::flag_set("FlagEndingHadesStabInteractFail");
	}
}

//Function Number: 100
bigfinaleplayerstabfail(param_00,param_01,param_02)
{
	var_03 = getanimlength(param_02 maps\_utility::getanim("fight_fail")) - 1.5;
	soundscripts\_snd::snd_message("start_hades_kill_interact_fail");
	level notify("failBloodDrips");
	earthquake(0.65,0.6,level.player.origin,128);
	level.player playrumbleonentity("damage_heavy");
	level.player dodamage(level.player.health - 1,(0,0,0));
	thread endingfinalebloodsplat(var_03,0.05,1,1);
	param_00 thread maps\_anim::anim_single_solo(param_02,"fight_fail");
	thread failhadesstabplayer(var_03);
	param_00 maps\_anim::anim_single(param_01,"fight_fail");
}

//Function Number: 101
setupaiforendinganim(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	maps\_utility::set_battlechatter(0);
	maps\_utility::disable_surprise();
	maps\_utility::disable_danger_react();
	maps\_utility::disable_pain();
	self.ignoresonicaoe = 1;
	self.name = " ";
	if(param_00 == 1)
	{
		thread maps\_utility::deletable_magic_bullet_shield();
	}
}

//Function Number: 102
endingsetupcivilians()
{
	maps\_utility::array_spawn_function_targetname("EndingCivFlee",::endingcivfleesetup);
	var_00 = maps\_utility::array_spawn_targetname("EndingCivFlee",1);
	foreach(var_02 in var_00)
	{
		var_02 thread endingcivilianflee();
	}
}

//Function Number: 103
endingcivfleesetup()
{
	self pushplayer(0);
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	self.allowdeath = 1;
	self.allowpain = 0;
}

//Function Number: 104
endingcivilianflee(param_00)
{
	self endon("death");
	self.animname = "generic";
	self.ignoresonicaoe = 1;
	var_01 = self.script_noteworthy + "Org";
	var_02 = common_scripts\utility::getstruct(var_01,"script_noteworthy");
	var_03 = self.script_noteworthy;
	var_04 = var_03 + "_idle";
	var_05 = var_03 + "_end";
	var_06 = var_03 + "_goal";
	var_07 = common_scripts\utility::getstruct(var_06,"targetname");
	if(isdefined(var_04) && maps\_utility::hasanim(var_04))
	{
		var_02 thread maps\_anim::anim_loop_solo(self,var_04,var_05);
	}

	common_scripts\utility::flag_wait_either("FlagEndingIlanaShootIntoAir","FlagTriggerEndingJumpDown");
	wait 0.05;
	if(isdefined(self))
	{
		if(isdefined(var_04) && maps\_utility::hasanim(var_04))
		{
			self notify(var_05);
			var_02 notify(var_05);
			maps\_utility::anim_stopanimscripted();
			var_08 = var_03 + "_react";
			if(self.script_noteworthy == "EndingCiv05")
			{
				var_02 maps\_anim::anim_single_solo(self,var_08);
				self.ignoresonicaoe = undefined;
				maps\_utility::set_goal_pos(self.origin);
				wait(randomfloatrange(1,3));
			}
			else
			{
				var_02 maps\_anim::anim_single_solo_run(self,var_08);
			}
		}
	}

	if(isdefined(self))
	{
		self.ignoresonicaoe = undefined;
		maps\_utility::set_goal_pos(var_07.origin);
	}

	thread maps\_hms_utility::aideleteonflag("FlagEndingSetAmbushInteractBegin",256,0);
}

//Function Number: 105
delete_on_goal()
{
	self endon("death");
	self waittill("goal");
	while(self cansee(level.player))
	{
		wait(1);
	}

	self delete();
}

//Function Number: 106
monitorconvoyvehicle3()
{
	var_00 = getent("convoy_vehicle_3","targetname");
	var_00 setcandamage(1);
	var_00 setcanradiusdamage(1);
	var_00 thread monitorconvoyvehicle3damage();
	var_00 common_scripts\utility::waittill_either("player_damage","force_explosion");
	maps\greece_ending_fx::endingcrashtruckexplosionfx();
}

//Function Number: 107
monitorconvoyvehicle3damage()
{
	self endon("force_explosion");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_01 != level.player)
		{
			continue;
		}

		if(var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE" || var_04 == "MOD_PROJECTILE" || var_04 == "MOD_EXPLOSIVE_SPLASH" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE_SPLASH")
		{
			break;
		}
	}

	self notify("player_damage");
}

//Function Number: 108
endingstorefrontdestroyedsetup()
{
	var_00 = getentarray("store_front_clean","targetname");
	var_01 = getentarray("store_front_destroyed","targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	level waittill("storefront_crash_veh3");
	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	foreach(var_03 in var_00)
	{
		var_03 delete();
	}

	var_09 = getent("storefront_glass_shatter_org","targetname");
	glassradiusdamage(var_09.origin,300,100,0);
}

//Function Number: 109
fruit_table_impact()
{
	var_00 = getent("fruit_table_des_org","targetname");
	var_01 = getent("fruit_table_impact_org","targetname");
	var_02 = getentarray("fruit_table_stuff","targetname");
	var_03 = anglestoforward(var_00.angles);
	level waittill("Planter_crash_veh3");
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05))
		{
			var_05 delete();
		}
	}

	physicsexplosionsphere(var_01.origin,300,0,3);
	playfx(level._effect["fruit_table_impact_lrg_x"],var_00.origin,var_03);
}

//Function Number: 110
endingfinalebloodsplat(param_00,param_01,param_02,param_03)
{
	level endon("noHealthOverlay");
	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04 setshader("fullscreen_lit_bloodsplat_01",640,480);
	var_04.splatter = 1;
	var_04.alignx = "left";
	var_04.aligny = "top";
	var_04.sort = 1;
	var_04.foreground = 0;
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.enablehudlighting = 1;
	var_04.color = (0,0,0);
	thread endingfinalebloodremove(var_04);
	thread endingfinaleblooddrips(var_04);
	var_05 = 0;
	var_06 = 0.05;
	var_07 = 0.3;
	wait(var_06);
	var_08 = 1 - level.player.health / level.player.maxhealth;
	var_09 = var_08 * var_08 * 1.2;
	var_09 = clamp(var_09,0,1);
	if(var_05 > var_09)
	{
		var_05 = var_05 - var_07 * var_06;
	}

	if(var_05 < var_09)
	{
		var_05 = var_09;
	}

	var_04.color = (var_05,0,0);
}

//Function Number: 111
endingfinaleblooddrips(param_00)
{
	level endon("noHealthOverlay");
	level waittill("failBloodDrips");
	var_01 = 0;
	var_02 = 0;
	for(var_01 = 0;var_01 < 80;var_01++)
	{
		var_03 = var_02 / 80;
		param_00.color = (255,var_03,0);
		var_02 = var_02 + 1;
		wait 0.05;
	}
}

//Function Number: 112
endingfinalebloodremove(param_00)
{
	level waittill("noHealthOverlay");
	param_00 destroy();
}

//Function Number: 113
endingtruckclip(param_00)
{
	var_01 = getentarray("EndingTruckClip","targetname");
	if(param_00 == 1)
	{
		var_02 = 1024;
	}
	else
	{
		var_02 = -1024;
	}

	foreach(var_04 in var_01)
	{
		var_05 = var_04.origin;
		var_06 = var_05 + (0,0,var_02);
		var_04 moveto(var_06,0.1);
	}
}

//Function Number: 114
bigfinaleplayergrabgun(param_00,param_01)
{
	thread monitorplayergrabgun();
	param_00 maps\_anim::anim_first_frame_solo(param_01,"fight_action");
	param_00 maps\_anim::anim_single_solo(param_01,"fight_action");
	level notify("EndingFinaleGrabGunWindowEnd");
	if(common_scripts\utility::flag("FlagGrabGunSuccess"))
	{
		param_00 maps\_anim::anim_single_solo(param_01,"fight_action_reach");
		return;
	}

	param_00 maps\_anim::anim_single_solo(param_01,"fight_action_noreach");
}

//Function Number: 115
monitorplayergrabgun()
{
	level waittill("EndingFinaleGrabGunWindowStart");
	thread maps\_utility::hintdisplayhandler("player_grab_gun",undefined,undefined,undefined,undefined,200);
	monitorgrabgunbuttonpress();
	common_scripts\utility::flag_set("FlagGrabGunHintOff");
}

//Function Number: 116
hintgrabgunoff()
{
	return common_scripts\utility::flag("FlagGrabGunHintOff");
}

//Function Number: 117
monitorgrabgunbuttonpress()
{
	level endon("EndingFinaleGrabGunWindowEnd");
	while(!common_scripts\utility::flag("FlagGrabGunHintOff"))
	{
		if(level.player usebuttonpressed())
		{
			common_scripts\utility::flag_set("FlagGrabGunSuccess");
			break;
		}

		wait 0.05;
	}
}

//Function Number: 118
spawnendingheli()
{
}

//Function Number: 119
endingtruckfiredamagevol()
{
	level endon("EndingStartBigFinale");
	var_00 = getent("EndingTruckFire","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		var_01 dodamage(5,var_00.origin,var_00,var_00,"MOD_CRUSH");
		wait(0.1);
	}
}

//Function Number: 120
endingburningsniper()
{
	var_00 = maps\_utility::spawn_targetname("EndingBurningSniper",1);
	var_00 maps\_utility::gun_remove();
	var_00.animname = "generic";
	var_00 thread maps\greece_sniper_scramble_fx::ragdollonfirefx();
	var_01 = common_scripts\utility::getstruct("EndingBurningSniperOrg","targetname");
	var_02 = "burning_corpse";
	var_01 maps\_anim::anim_single_solo(var_00,var_02);
	var_00 maps\greece_code::kill_no_react(0);
	common_scripts\utility::flag_wait("FlagTriggerEndingJumpDown");
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 121
bigfinaleenemytruckdamagesetup(param_00)
{
	param_00 hidepart("TAG_HOOD_damage1a","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage1b","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage1c","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage2","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage3","greece_finale_truck");
	param_00 hidepart("TAG_GLASS_damage1","greece_finale_truck");
	param_00 hidepart("TAG_GRILL_damage1","greece_finale_truck");
	param_00 hidepart("TAG_GRILL_damage2","greece_finale_truck");
	level waittill("show_damage1");
	param_00 showpart("TAG_HOOD_damage1a","greece_finale_truck");
	param_00 showpart("TAG_HOOD_damage1b","greece_finale_truck");
	param_00 showpart("TAG_HOOD_damage1c","greece_finale_truck");
	param_00 showpart("TAG_GLASS_damage1","greece_finale_truck");
	param_00 showpart("TAG_GRILL_damage1","greece_finale_truck");
	param_00 showpart("TAG_GRILL_damage2","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_healthy","greece_finale_truck");
	param_00 hidepart("TAG_GLASS_FRONT","greece_finale_truck");
	level waittill("show_damage2");
	param_00 showpart("TAG_HOOD_damage2","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage1a","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage1b","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage1c","greece_finale_truck");
	level waittill("show_damage3");
	param_00 showpart("TAG_HOOD_damage3","greece_finale_truck");
	param_00 hidepart("TAG_HOOD_damage2","greece_finale_truck");
	param_00 hidepart("left_wheel_01_jnt","greece_finale_truck");
}

//Function Number: 122
endingautosavetacticalthread()
{
	level endon("EndingEndAutosaveThread");
	var_00 = undefined;
	for(;;)
	{
		if(isdefined(level.curautosave))
		{
			var_00 = level.curautosave;
		}

		wait 0.05;
		thread maps\_utility::autosave_by_name_silent("ending_fight_silent");
		wait(5);
		if(isdefined(var_00))
		{
			if(var_00 != level.curautosave)
			{
				maps\_hms_utility::printlnscreenandconsole("*** Autosave success! ***");
				wait(10);
			}
		}
	}
}
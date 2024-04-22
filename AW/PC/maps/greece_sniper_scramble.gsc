/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_sniper_scramble.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 178
 * Decompile Time: 2664 ms
 * Timestamp: 4/22/2024 2:31:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	sniperscrambleprecache();
	sniperscrambleflaginit();
	sniperscrambleglobalvars();
	sniperscrambleglobalsetup();
	maps\greece_sniper_scramble_fx::main();
	maps\greece_sniper_scramble_anim::main();
	maps\greece_sniper_scramble_vo::main();
	thread vehicle_scripts\_pdrone_tactical_picker::main();
	maps\_stingerm7_greece::init();
}

//Function Number: 2
sniperscrambleprecache()
{
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacheitem("hms_rail_sniper");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp_opticsreddot_silencerpistol");
	precacherumble("silencer_fire");
	precacherumble("damage_light");
	precacherumble("damage_heavy");
	precacherumble("artillery_rumble");
	precacherumble("tank_rumble");
	precacherumble("subtle_tank_rumble");
	precachemodel("viewhands_atlas_military");
	precachemodel("vb_civilian_mitchell");
	precachemodel("npc_variable_grenade_nonlethal");
	precacheshader("damage_feedback");
	precachemodel("greece_sniper_tower_des");
	precachemodel("greece_sniper_tower_des_01");
	precachemodel("greece_sniper_tower_des_02");
	precachemodel("greece_sniper_tower_des_03");
	precachemodel("greece_sniper_tower_des_04");
	precachemodel("greece_sniper_tower_des_05");
	precachemodel("greece_sniper_tower_des_06");
	precachemodel("greece_sniper_tower_des_07");
	precachemodel("greece_cable_car_rigged");
	precachestring(&"GREECE_HINT_MOVE_TRUCK");
	precachestring(&"GREECE_HINT_MOVE_TRUCK_KB");
	precachestring(&"GREECE_FAIL_SCRAMBLE_LEFT_ILONA");
	precachestring(&"GREECE_FAIL_SCRAMBLE_SUPPRESS_SNIPER");
	precachestring(&"GREECE_OBJ_SCRAMBLE_SUPPRESS");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	precachestring(&"GREECE_OBJ_SCRAMBLE_DESTROY");
	precachestring(&"GREECE_OBJ_SCRAMBLE_ELIMINATE_SNIPER");
	precachestring(&"GREECE_OBJ_INTERCEPT_HADES");
	precachestring(&"GREECE_OBJ_SCRAMBLE_PICKUPSTINGER");
	precachestring(&"GREECE_OBJ_SCRAMBLE_PUSHTRUCK");
	maps\_utility::add_hint_string("scramble_suppress_sniper_1",&"GREECE_HINT_SCRAMBLE_SUPPRESS",::hintscramblesuppress1off);
	maps\_utility::add_hint_string("scramble_suppress_sniper_2",&"GREECE_HINT_SCRAMBLE_SUPPRESS",::hintscramblesuppress2off);
	maps\_utility::add_hint_string("scramble_advance_to_ilona",&"GREECE_HINT_SCRAMBLE_ADVANCE",::hintscrambleadvanceoff);
	maps\_hms_door_interact::precachedooranimations();
}

//Function Number: 3
sniperscrambleflaginit()
{
	common_scripts\utility::flag_init("FlagAlleysPipComplete");
	common_scripts\utility::flag_init("FlagAlleysIlanaReadyToExit");
	common_scripts\utility::flag_init("FlagScrambleSniperSuppressed");
	common_scripts\utility::flag_init("FlagScrambleIlanaBeginOpenIntroDoor");
	common_scripts\utility::flag_init("FlagScrambleIlanaEndOpenIntroDoor");
	common_scripts\utility::flag_init("FlagScrambleStartIntro");
	common_scripts\utility::flag_init("FlagScrambleStartHotel");
	common_scripts\utility::flag_init("FlagScrambleStartDrones");
	common_scripts\utility::flag_init("FlagScrambleStartFinale");
	common_scripts\utility::flag_init("FlagScrambleHotelIlanaStartRun");
	common_scripts\utility::flag_init("FlagScrambleHotelIlanaReachedGoal");
	common_scripts\utility::flag_init("FlagScrambleHotelIlanaJumpDown");
	common_scripts\utility::flag_init("FlagScrambleHotelBadLeapfrog");
	common_scripts\utility::flag_init("FlagScrambleHotelPlayerHasDecided");
	common_scripts\utility::flag_init("FlagScrambleCheckPlayerDecision");
	common_scripts\utility::flag_init("FlagScrambleReadyForWoundedSoldier");
	common_scripts\utility::flag_init("FlagScrambleDestroyFishTank");
	common_scripts\utility::flag_init("FlagScrambleWoundedSoldierKilled");
	common_scripts\utility::flag_init("FlagScrambleSniperKilled");
	common_scripts\utility::flag_init("FlagScramblePlayerJumping");
	common_scripts\utility::flag_init("FlagScrambleGapJumpStarted");
	common_scripts\utility::flag_init("FlagScrambleGapJumpCompleted");
	common_scripts\utility::flag_init("FlagScrambleIlanaGapJumpCompleted");
	common_scripts\utility::flag_init("FlagScrambleHotelJumpStarted");
	common_scripts\utility::flag_init("FlagScrambleHotelJumpCompleted");
	common_scripts\utility::flag_init("FlagScrambleCafeJumpStarted");
	common_scripts\utility::flag_init("FlagScrambleCafeJumpCompleted");
	common_scripts\utility::flag_init("FlagScrambleGetRPG");
	common_scripts\utility::flag_init("FlagScramblePlayerFireMissile");
	common_scripts\utility::flag_init("FlagScrambleObjSniperPos");
	common_scripts\utility::flag_init("FlagScrambleObjGapJumpPos");
	common_scripts\utility::flag_init("FlagScrambleObjSuppressSniper");
	common_scripts\utility::flag_init("FlagScrambleObjPoolCafePos");
	common_scripts\utility::flag_init("FlagScrambleObjWoundedSoldierPos");
	common_scripts\utility::flag_init("FlagScrambleObjRPGPos");
	common_scripts\utility::flag_init("FlagScrambleObjMoveTruckPos");
	common_scripts\utility::flag_init("FlagScrambleObjDestroyTower");
	common_scripts\utility::flag_init("FlagScramblePlayerHasStinger");
	common_scripts\utility::flag_init("FlagScrambleIlanaStartMoveTruck");
	common_scripts\utility::flag_init("FlagScrambleIlanaEndMoveTruck");
	common_scripts\utility::flag_init("FlagScramblePlayerStartMoveTruck");
	common_scripts\utility::flag_init("FlagScramblePlayerEndMoveTruck");
	common_scripts\utility::flag_init("FlagScrambleBeginHothall");
	common_scripts\utility::flag_init("FlagScrambleEndHothall");
	common_scripts\utility::flag_init("FlagDelayRPGReminderDialogue");
}

//Function Number: 4
sniperscramblegameskillmultiplier()
{
	var_00 = level.player maps\_utility::get_player_gameskill();
	var_01[0] = 1.25;
	var_01[1] = 1;
	var_01[2] = 0.75;
	var_01[3] = 0.5;
	var_02 = var_01[var_00];
	if(level.player hasweapon("iw5_stingerm7greece_sp"))
	{
		var_02 = var_02 * 0.75;
	}

	return var_02;
}

//Function Number: 5
sniperscrambleglobalvars()
{
	level.showdebugtoggle = 0;
	level.dialogtable = "sp/greece_dialog.csv";
	level.sniperpos = getent("SniperEnemyPos","targetname");
	level.sniperpos.bsniperenabled = 0;
	level.snipertargetent = undefined;
	level.sniperalltargets = getentarray("SniperTargetPos","targetname");
	level.snipervisibletargets = [];
	var_00 = spawnstruct();
	var_00.sniper_fx_base = common_scripts\utility::spawn_tag_origin();
	var_00.sniper_fx_base.origin = level.sniperpos.origin;
	var_00.player_visible_duration = 0;
	var_00.sniper_target_location = undefined;
	var_00.suppression_time = 0;
	var_00.shot_delay = 0;
	var_00.draw_debug = 0;
	var_00.debug_hud_elem = setup_sniper_debug_hud_elem();
	var_00.requires_player_los = 1;
	var_00.sniper_finale = 0;
	var_00.player_in_disable_sniper_volume = 0;
	var_00.minburstfireinterval = 0.8;
	var_00.maxburstfireinterval = 1.6;
	var_00.minburstdelay = 1.5;
	var_00.maxburstdelay = 2;
	level.sniper_scramble_data = var_00;
}

//Function Number: 6
sniperscrambleglobalsetup()
{
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	thread sniperscramblebegin();
	thread sniperscrambleobjectivesetup();
	thread maps\greece_code::setdefaulthudoutlinedvars();
}

//Function Number: 7
sniperscramblestartpoints()
{
	maps\_utility::add_start("start_sniper_scramble_intro",::initsniperscrambleintro);
	maps\_utility::add_start("start_sniper_scramble_hotel",::initsniperscramblehotel);
	maps\_utility::add_start("start_sniper_scramble_drones",::initsniperscrambledrones);
	maps\_utility::add_start("start_sniper_scramble_finale",::initsniperscramblefinale);
	maps\greece_starts::add_greece_starts("sniper_scramble");
}

//Function Number: 8
initsniperscrambleintro()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartScrambleIntro","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartScrambleIntro",1,1,"IlanaSniperScramble");
	thread ilanascrambleinit();
	thread gondolaanimation();
	thread scramblemodifyplayerviewkick();
	thread scramblevisitorcentergateopen();
	common_scripts\utility::flag_set("FlagSniperScrambleStart");
	common_scripts\utility::flag_set("FlagAlleysPipComplete");
	common_scripts\utility::flag_set("FlagAlleysIlanaReadyToExit");
	common_scripts\utility::flag_set("init_sniper_scramble_finale_lighting");
	soundscripts\_snd::snd_message("start_sniper_scramble_intro_checkpoint");
}

//Function Number: 9
initsniperscramblehotel()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartScrambleHotel","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartScrambleHotel",1,1,"IlanaSniperScramble");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyStartScrambleHotelCover");
	thread scramblesetupexittruck();
	thread torresblood();
	thread sniperscrambleinit();
	snipersettargetent(undefined);
	thread monitorsupersafevol();
	thread updatesnipershooting();
	thread snipershootnearhotelciv();
	thread scramblecivhotel();
	thread scramblecivhothall();
	thread scramblecivpool();
	thread gondolaanimation();
	level.allies["Ilona"] thread ilanascramblemovement();
	level.player thread initsniperscramblesuppressionfeedback();
	thread scramblemodifyplayerviewkick();
	thread scrambledestroycafewall();
	common_scripts\utility::flag_set("FlagScrambleStartHotel");
	common_scripts\utility::flag_set("init_sniper_scramble_hotel_lighting");
	soundscripts\_snd::snd_message("start_sniper_scramble_hotel_checkpoint");
}

//Function Number: 10
initsniperscrambledrones()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartScrambleDrones","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartScrambleDrones",1,1,"IlanaSniperScramble");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyStartScrambleDronesCover");
	thread scramblesetupexittruck();
	thread torresblood();
	thread sniperscrambleinit();
	snipersettargetent(undefined);
	thread monitorsupersafevol();
	thread updatesnipershooting();
	thread scramblecivdrones();
	thread gondolaanimation();
	level.allies["Ilona"] thread ilanascramblemovement();
	level.player thread initsniperscramblesuppressionfeedback();
	thread scramblemodifyplayerviewkick();
	common_scripts\utility::flag_set("FlagScrambleStartDrones");
	common_scripts\utility::flag_set("init_sniper_scramble_drones_lighting");
	soundscripts\_snd::snd_message("start_sniper_scramble_drones_checkpoint");
}

//Function Number: 11
initsniperscramblefinale()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartScrambleFinale","targetname"));
	maps\_hms_utility::setupplayerinventory("iw5_titan45_sp_opticsreddot_silencerpistol","iw5_hmr9_sp_variablereddot","fraggrenade","flash_grenade","iw5_hmr9_sp_variablereddot");
	maps\_variable_grenade::give_player_variable_grenade();
	thread maps\_player_exo::player_exo_activate();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
		maps\greece_conf_center_fx::confcenterresidualsmoke();
		maps\greece_safehouse_fx::ambientcloudskill();
	}

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartScrambleFinale",1,1,"IlanaSniperScramble");
	thread scramblesetupexittruck();
	thread torresblood();
	thread sniperscrambleinit();
	snipersettargetent(undefined);
	thread monitorsupersafevol();
	thread updatesnipershooting();
	thread scramblefinaleallies();
	thread gondolaanimation();
	thread pitbulldestroyedanimation();
	level.allies["Ilona"] thread ilanascramblemovement();
	level.player thread initsniperscramblesuppressionfeedback();
	thread scramblemodifyplayerviewkick();
	common_scripts\utility::flag_set("FlagScrambleStartFinale");
	common_scripts\utility::flag_set("init_sniper_scramble_finale_lighting");
	soundscripts\_snd::snd_message("start_sniper_scramble_finale_checkpoint");
}

//Function Number: 12
sniperscrambleobjectivesetup()
{
	waittillframeend;
	thread objscramblekillsniper();
	sniperscramblesetcompletedobjflags();
}

//Function Number: 13
sniperscramblesetcompletedobjflags()
{
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_sniper_scramble_"))
	{
		return;
	}

	if(var_00 == "start_sniper_scramble_intro")
	{
		return;
	}

	common_scripts\utility::flag_set("FlagScrambleObjSniperPos");
	if(var_00 == "start_sniper_scramble_hotel")
	{
		return;
	}

	if(var_00 == "start_sniper_scramble_drones")
	{
		return;
	}

	if(var_00 == "start_sniper_scramble_finale")
	{
	}
}

//Function Number: 14
objscramblekillsniper()
{
	common_scripts\utility::flag_wait("FlagScrambleObjSniperPos");
	var_00 = getent("ScrambleSniperObj","targetname");
	thread objscramblegapjump();
	thread objscramblesuppress(var_00);
	thread objscramblepoolcafe();
	thread objscramblejumpdown();
	thread objscramblefollowilana();
	thread objscramblewoundedsoldier();
	thread objscramblerpg();
	thread objscramblesnipertower(var_00);
	var_01 = getentarray("ScrambleSniperWindowTarget","targetname");
	for(;;)
	{
		if(level.player hasweapon("iw5_stingerm7greece_sp"))
		{
			break;
		}

		wait(0.5);
	}

	common_scripts\utility::flag_set("FlagScrambleObjDestroyTower");
	foreach(var_03 in var_01)
	{
		var_03 hudoutlineenable(1,0);
	}

	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	foreach(var_03 in var_01)
	{
		var_03 hudoutlinedisable();
		var_03 delete();
	}

	var_07 = getent("ScrambleSniperWindowTargetBack","targetname");
	var_07 delete();
	thread objscramblemovetruck();
}

//Function Number: 15
objscramblegapjump()
{
	common_scripts\utility::flag_wait("FlagScrambleObjGapJumpPos");
	var_00 = getent("ScrambleGapJumpObj","targetname");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,var_00.origin);
	common_scripts\utility::flag_wait("FlagScrambleGapJumpStarted");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,(0,0,0));
}

//Function Number: 16
objscramblesuppress(param_00)
{
	common_scripts\utility::flag_wait("FlagScrambleObjSuppressSniper");
	objective_position(maps\_utility::obj("InterceptHades"),param_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_SUPPRESS");
	thread objscramblesuppressdisplay();
	thread objscrambleplayerrunfirst(param_00);
	common_scripts\utility::flag_wait("FlagScrambleHotelIlanaReachedGoal");
	level notify("EndObjScrambleSuppress");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
}

//Function Number: 17
objscrambleplayerrunfirst(param_00)
{
	common_scripts\utility::flag_wait("FlagScrambleObjPoolCafePos");
	level notify("EndObjScrambleSuppress");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	if(!common_scripts\utility::flag("FlagScrambleHotelIlanaReachedGoal"))
	{
		objective_position(maps\_utility::obj("InterceptHades"),param_00.origin);
		objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_SUPPRESS");
		thread objscramblesuppressdisplay();
	}
}

//Function Number: 18
objscramblesuppressdisplay()
{
	level endon("EndObjScrambleSuppress");
	for(;;)
	{
		wait(0.1);
		if(common_scripts\utility::flag("FlagScrambleSniperSuppressed"))
		{
			objective_setpointertextoverride(maps\_utility::obj("InterceptHades")," ");
			continue;
		}

		objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_SUPPRESS");
	}
}

//Function Number: 19
objscramblepoolcafe()
{
	common_scripts\utility::flag_wait("FlagScrambleObjPoolCafePos");
	var_00 = getent("ScramblePoolCafeObj","targetname");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,(0,0,0));
}

//Function Number: 20
objscramblejumpdown()
{
	common_scripts\utility::flag_wait("FlagScrambleHotelIlanaJumpDown");
	var_00 = getent("ScrambleJumpDownObj","targetname");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,var_00.origin);
	common_scripts\utility::flag_wait("FlagScrambleCafeJumpStarted");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,(0,0,0));
}

//Function Number: 21
objscramblefollowilana()
{
	common_scripts\utility::flag_wait("FlagScrambleDronesAdead");
	objective_onentity(maps\_utility::obj("InterceptHades"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerAlmostNearWoundedSoldier");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
}

//Function Number: 22
objscrambledrones()
{
	var_00 = getent("ScrambleSniperObj","targetname");
	common_scripts\utility::flag_wait("FlagScrambleStartDrones");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	common_scripts\utility::flag_wait("FlagScrambleDronesAdead");
	objective_position(maps\_utility::obj("InterceptHades"),var_00.origin);
}

//Function Number: 23
objscramblewoundedsoldier()
{
	common_scripts\utility::flag_wait("FlagScrambleObjWoundedSoldierPos");
	var_00 = getent("ScrambleWoundedSoldierObj","targetname");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,var_00.origin);
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearWoundedSoldier");
	objective_additionalposition(maps\_utility::obj("InterceptHades"),1,(0,0,0));
}

//Function Number: 24
objscramblerpg()
{
	common_scripts\utility::flag_wait("FlagScrambleObjRPGPos");
	var_00 = getent("ScrambleRPGObj","targetname");
	var_01 = getent("ScrambleStairs1Obj","targetname");
	var_02 = getent("ScrambleStairs2Obj","targetname");
	objective_add(maps\_utility::obj("InterceptHades"),"active",&"GREECE_OBJ_SCRAMBLE_ELIMINATE_SNIPER",(0,0,0));
	objective_current(maps\_utility::obj("InterceptHades"));
	objective_position(maps\_utility::obj("InterceptHades"),var_01.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades")," ");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerOnStairs");
	objective_position(maps\_utility::obj("InterceptHades"),var_02.origin);
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearRPG");
	objective_position(maps\_utility::obj("InterceptHades"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_PICKUPSTINGER");
	var_03 = getent("ScrambleStingerPickup","targetname");
	var_03 hudoutlineenable(3);
}

//Function Number: 25
objscramblesnipertower(param_00)
{
	common_scripts\utility::flag_wait("FlagScrambleObjDestroyTower");
	objective_position(maps\_utility::obj("InterceptHades"),param_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_DESTROY");
	common_scripts\utility::flag_wait("FlagScramblePlayerFireMissile");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
}

//Function Number: 26
objscramblemovetruck()
{
	common_scripts\utility::flag_wait("FlagScrambleObjMoveTruckPos");
	var_00 = getent("ScrambleMoveTruckObj","targetname");
	objective_add(maps\_utility::obj("InterceptHades"),"active",&"GREECE_OBJ_INTERCEPT_HADES",(0,0,0));
	objective_current(maps\_utility::obj("InterceptHades"));
	objective_position(maps\_utility::obj("InterceptHades"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SCRAMBLE_PUSHTRUCK");
	var_01 = getent("ScrambleExitTruck","targetname");
	var_01 hudoutlineenable(3);
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades")," ");
	var_01 hudoutlinedisable();
}

//Function Number: 27
sniperscrambleinit()
{
	thread ilanascrambleinit();
	thread snipersetupglass();
	thread monitorphysicschairs();
	thread monitormantlevols();
	level.player thread monitorlastweapon();
	level.player thread stingerpronestatemonitor();
	if(level.nextgen || istransientloaded("greece_middle_tr"))
	{
		thread scramblestartdoorinit();
	}

	thread scramblemodifyplayerviewkick();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	}
}

//Function Number: 28
scramblemodifyplayerviewkick()
{
	var_00 = level.player getviewkickscale();
	level.player setviewkickscale(0.15);
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	level.player setviewkickscale(var_00);
	killfxontag(common_scripts\utility::getfx("railgun_sniper_glint"),level.sniper_scramble_data.sniper_fx_base,"tag_origin");
}

//Function Number: 29
sniperscramblebegin()
{
	common_scripts\utility::flag_wait("FlagSniperScrambleStart");
	thread sniperscrambleinit();
	thread scrambledestroycafewall();
	level.player thread initsniperscramblesuppressionfeedback();
	thread sniperintro();
	thread scrambleplayergapjump();
	thread scramblesetupexittruck();
	thread torresblood();
	thread gondolaanimation();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	}
}

//Function Number: 30
sniperintro()
{
	common_scripts\utility::flag_set("FlagScrambleStartIntro");
	thread scramblecivpatio();
	thread ilanascrambleopenstartdoor();
	thread snipershootintrodoor();
	thread snipershootfirstcivilian();
}

//Function Number: 31
snipershootintrodoor()
{
	level.sniperpos.bsniperenabled = 0;
	level waittill("ScrambleSniperFireFirstShot");
	var_00 = common_scripts\utility::getstruct("SniperFirstTargetPos","script_noteworthy");
	snipershoot(var_00.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	level waittill("ScrambleSniperFireSecondShot");
	var_01 = common_scripts\utility::getstruct("SniperSecondTargetPos","script_noteworthy");
	snipershoot(var_01.origin,1.25,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_01.origin);
	level waittill("ScrambleSniperFireThirdShot");
	var_02 = common_scripts\utility::getstruct("SniperThirdTargetPos","script_noteworthy");
	snipershoot(var_02.origin,1.25,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_02.origin);
}

//Function Number: 32
snipershoothothall()
{
	level.sniperpos.bsniperenabled = 0;
	level waittill("hothall_sniper_shot");
	var_00 = common_scripts\utility::getstruct("HothallSniperTarget1","script_noteworthy");
	snipershoot(var_00.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	level waittill("hothall_sniper_shot");
	var_01 = maps\_utility::get_living_ai("HothallSniperTarget2","script_noteworthy");
	var_02 = var_01 snipertargetgettagpos();
	snipershoot(var_02,1.25,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_01.origin);
	level waittill("hothall_sniper_shot");
	var_03 = common_scripts\utility::getstruct("HothallSniperTarget1","script_noteworthy");
	snipershoot(var_03.origin,1.25,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_03.origin);
	level waittill("hothall_sniper_shot");
	var_04 = maps\_utility::get_living_ai("HothallSniperTarget4","script_noteworthy");
	var_05 = var_04 snipertargetgettagpos();
	snipershoot(var_05,1.25,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_04.origin);
	level.sniperpos.bsniperenabled = 1;
}

//Function Number: 33
updatescopeglintwarning()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 2;
	var_04 = var_03 * 2;
	var_05 = 10;
	var_06 = var_05 / 2;
	var_07 = level.player geteye();
	for(;;)
	{
		wait(0.05);
		if(level.sniper_scramble_data.player_visible_duration <= 0)
		{
			if(var_00)
			{
				killfxontag(common_scripts\utility::getfx("railgun_sniper_glint"),level.sniper_scramble_data.sniper_fx_base,"tag_origin");
				var_00 = 0;
			}

			continue;
		}

		if(!var_00)
		{
			playfxontag(common_scripts\utility::getfx("railgun_sniper_glint"),level.sniper_scramble_data.sniper_fx_base,"tag_origin");
			var_00 = 1;
			var_08 = level.player.origin - level.sniperpos.origin;
			level.sniper_scramble_data.sniper_fx_base.angles = vectortoangles(var_08);
		}

		var_01 = var_01 + var_03;
		var_01 = common_scripts\utility::mod(var_01,360 + var_03);
		var_09 = sin(var_01);
		var_02 = var_02 + var_04;
		var_02 = common_scripts\utility::mod(var_02,360 + var_04);
		var_0A = sin(var_02);
		var_0B = vectorcross(vectornormalize(level.player geteye() - level.sniperpos.origin),(0,0,1));
		var_0C = var_0B * var_09 * var_05;
		var_0C = (var_0C[0],var_0C[1],var_0A * var_06);
		var_07 = vectorlerp(var_07,level.player geteye() + var_0C,0.5);
		var_0D = var_07 - level.sniperpos.origin;
		level.sniper_scramble_data.sniper_fx_base.angles = vectortoangles(var_0D);
	}
}

//Function Number: 34
snipershoot(param_00,param_01,param_02)
{
	level endon("ScrambleSniperKilled");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(isdefined(param_02) && level.sniper_scramble_data.shot_delay < 2)
	{
		level.sniper_scramble_data.shot_delay = 2;
	}

	var_03 = level.sniperpos.origin;
	var_04 = vectornormalize(param_00 - var_03);
	playfx(common_scripts\utility::getfx("railgun_sniper_tracer"),var_03,var_04,(0,0,1));
	magicbullet("hms_rail_sniper",var_03,param_00);
	thread snipernearshotshake(param_00,param_01);
	level.sniperpos.lastshottime = gettime();
	if(level.sniper_scramble_data.draw_debug == 1)
	{
		thread common_scripts\utility::draw_line_for_time(level.sniperpos.origin,param_00,1,1,1,0.5);
		thread maps\_utility::draw_circle_for_time(param_00,32,1,0,0,1);
	}
}

//Function Number: 35
snipernearshotshake(param_00,param_01)
{
	wait(0.05);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = vectorfromlinetopoint(level.sniperpos.origin,param_00,level.player.origin);
	var_03 = length(var_02);
	if(var_03 > 500 * param_01)
	{
		return;
	}

	var_04 = 100 * param_01;
	var_05 = 200 * param_01;
	var_06 = undefined;
	var_07 = undefined;
	if(var_03 <= var_04)
	{
		level.player playrumbleonentity("damage_light");
		var_06 = randomfloatrange(0.4,0.5) * param_01;
		var_07 = randomfloatrange(0.6,0.8);
		thread maps\_utility::dirt_on_screen_from_position(param_00);
	}
	else if(var_03 <= var_05)
	{
		level.player playrumbleonentity("damage_light");
		var_06 = randomfloatrange(0.2,0.4) * param_01;
		var_07 = randomfloatrange(0.4,0.6);
	}
	else
	{
		var_06 = randomfloatrange(0.1,0.3) * param_01;
		var_07 = randomfloatrange(0.2,0.4);
	}

	earthquake(var_06,var_07,level.player.origin,100);
}

//Function Number: 36
updatesnipersuppression()
{
	level endon("ScrambleSniperKilled");
	var_00 = getent("ScrambleSniperWindow","targetname");
	var_00 thread monitorsnipertowersuppressiondamage();
	thread updatesuppressionduration(var_00);
	while(isdefined(var_00))
	{
		var_00 waittill("bullethit");
		level.sniper_scramble_data.suppression_time = 4;
		wait(0.05);
	}
}

//Function Number: 37
updatesuppressionduration(param_00)
{
	level endon("ScrambleSniperKilled");
	var_01 = 0;
	while(isdefined(param_00))
	{
		wait(0.05);
		if(level.sniper_scramble_data.suppression_time > 0)
		{
			if(!var_01)
			{
				var_01 = 1;
				level notify("ScrambleSniperSuppressed");
				common_scripts\utility::flag_set("FlagScrambleSniperSuppressed");
			}

			level.sniper_scramble_data.suppression_time = level.sniper_scramble_data.suppression_time - 0.05;
			continue;
		}

		if(var_01)
		{
			var_01 = 0;
			common_scripts\utility::flag_clear("FlagScrambleSniperSuppressed");
		}
	}
}

//Function Number: 38
sniperissuppressed()
{
	return level.sniper_scramble_data.suppression_time > 0;
}

//Function Number: 39
snipersettargetent(param_00)
{
	if(isdefined(param_00))
	{
		level notify("StopSniperTargetSearch");
		level.snipertargetent = param_00;
		return;
	}

	thread updatesnipertargeting();
}

//Function Number: 40
updatesnipershooting()
{
	childthread updatesnipersuppression();
	childthread updatescopeglintwarning();
	level.sniperpos.bsniperenabled = 1;
	while(!common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		wait(0.05);
		if(isshotdelayed() || !shouldfireattarget())
		{
			continue;
		}

		var_01 = snipergettargetpos();
		soundscripts\_snd::snd_message("windmill_sniper_shot_multi",var_01);
		snipershoot(var_01);
		var_02 = randomfloatrange(level.sniper_scramble_data.minburstdelay,level.sniper_scramble_data.maxburstdelay);
		if(isdefined(level.snipertargetent) && isplayer(level.snipertargetent))
		{
			var_02 = var_02 * sniperscramblegameskillmultiplier();
		}

		wait(var_02);
	}
}

//Function Number: 41
isshotdelayed()
{
	if(sniperissuppressed())
	{
		return 1;
	}

	if(level.sniperpos.bsniperenabled == 0)
	{
		return 1;
	}

	return level.sniper_scramble_data.shot_delay > 0;
}

//Function Number: 42
shouldfireattarget()
{
	if(level.sniper_scramble_data.player_in_disable_sniper_volume)
	{
		return 0;
	}

	if(sniperissuppressed())
	{
		return 0;
	}

	if(level.sniperpos.bsniperenabled == 0)
	{
		return 0;
	}

	return isdefined(level.snipertargetent) || isdefined(level.sniper_scramble_data.sniper_target_location);
}

//Function Number: 43
snipergettargetpos()
{
	if(isdefined(level.snipertargetent))
	{
		return getentitytargetlocationwithspread(level.snipertargetent);
	}

	return level.sniper_scramble_data.sniper_target_location;
}

//Function Number: 44
calculate_lateral_move_accuracy(param_00)
{
	var_01 = param_00.origin - level.sniperpos.origin * (1,1,0);
	var_01 = vectornormalize(var_01);
	var_01 = (var_01[1],var_01[0] * -1,0);
	var_02 = abs(vectordot(var_01,param_00 getvelocity()));
	var_02 = clamp(var_02,0,250) / 250;
	var_02 = 1 - var_02;
	var_02 = clamp(var_02,0.3,1);
	return var_02;
}

//Function Number: 45
calculate_stance_accuracy(param_00)
{
	if(param_00 getstance() == "crouch")
	{
		return 0.75;
	}
	else if(param_00 getstance() == "prone")
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 46
calculate_sprinting_jumping_accuracy(param_00)
{
	if(param_00 issprinting() || param_00 isjumping())
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 47
getentitytargetlocationwithspread(param_00)
{
	var_01 = param_00 geteye();
	var_02 = param_00 geteye() - param_00.origin;
	var_03 = (0,0,var_02[2] * 0.85);
	var_04 = 0.3;
	var_05 = param_00.origin - level.sniperpos.origin;
	var_05 = var_05 * (1,1,0);
	var_05 = vectornormalize(var_05);
	if(isplayer(param_00))
	{
		var_04 = 1;
		if(level.sniper_scramble_data.sniper_finale)
		{
			var_04 = var_04 * calculate_lateral_move_accuracy(level.player);
			var_04 = var_04 * calculate_stance_accuracy(level.player);
			var_04 = var_04 * calculate_sprinting_jumping_accuracy(level.player);
			if(level.player hasweapon("iw5_stingerm7greece_sp"))
			{
				var_04 = var_04 * 0.5;
				var_04 = clamp(var_04,0.5,1);
			}
		}
	}

	var_06 = vectorcross((0,0,1),var_05);
	var_07 = var_06 * 8 / var_04 * randomfloatrange(-1,1);
	var_08 = (0,0,4) / var_04 * randomfloatrange(-1,1);
	var_09 = var_07 + var_08;
	var_0A = param_00.origin + var_03 + var_09;
	return var_0A;
}

//Function Number: 48
targetinsafevolume(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(var_03.bisactivated == 1 && param_00 istouching(var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 49
updatesnipertargeting()
{
	level notify("UpdateSniperTargeting");
	level endon("UpdateSniperTargeting");
	var_00 = getentarray("TriggerScrambleSafeVol","targetname");
	foreach(var_02 in var_00)
	{
		var_02.bisactivated = 1;
	}

	for(;;)
	{
		wait(0.05);
		level.sniper_scramble_data.shot_delay = level.sniper_scramble_data.shot_delay - 0.05;
		level.sniper_scramble_data.shot_delay = max(level.sniper_scramble_data.shot_delay,0);
		if(!common_scripts\utility::flag("FlagScrambleSniperSuppressed") && updatesnipertargetentitylocation(var_00))
		{
			continue;
		}

		level.snipertargetent = undefined;
		level.sniper_scramble_data.player_visible_duration = 0;
		updatesnipertargetlocation();
	}
}

//Function Number: 50
updatesnipertargetentitylocation(param_00)
{
	var_01 = undefined;
	if(level.sniper_scramble_data.requires_player_los && !level.player ismantling() && !targetinsafevolume(level.player,param_00))
	{
		var_01 = bullettrace(level.sniperpos.origin,level.player geteye(),0,level.player,0,0,0,0,0);
	}

	if((isdefined(var_01) && var_01["fraction"] == 1) || !level.sniper_scramble_data.requires_player_los)
	{
		level.sniper_scramble_data.player_visible_duration = level.sniper_scramble_data.player_visible_duration + 0.05;
		if(level.sniper_scramble_data.player_visible_duration < 2)
		{
			return 1;
		}

		level.snipertargetent = level.player;
		return 1;
	}

	var_01 = undefined;
	if(!targetinsafevolume(level.allies["Ilona"],param_00))
	{
		var_01 = bullettrace(level.sniperpos.origin,level.player geteye(),0,level.allies["Ilona"],0,0,0,0,0);
	}

	if(isdefined(var_01) && var_01["fraction"] == 1)
	{
		level.snipertargetent = level.allies["Ilona"];
		level.sniper_scramble_data.player_visible_duration = 0;
		return 1;
	}

	return 0;
}

//Function Number: 51
updatesnipertargetlocation()
{
	var_00 = 48;
	var_01 = 216;
	var_02 = 2000;
	if(findsnipertargetnearactor(var_01,var_02))
	{
		return;
	}

	if(findrandomlocationneartarget(var_00,var_01))
	{
		return;
	}

	level.sniper_scramble_data.sniper_target_location = undefined;
}

//Function Number: 52
findsnipertargetnearactor(param_00,param_01)
{
	var_02 = squared(param_00);
	level.sniperalltargets = maps\_utility::array_removedead_or_dying(level.sniperalltargets);
	foreach(var_06, var_04 in level.sniperalltargets)
	{
		if(isdefined(var_04.lasttime) && gettime() - var_04.lasttime < param_01)
		{
			continue;
		}

		if(distance2dsquared(level.player.origin,var_04.origin) > var_02)
		{
			continue;
		}

		if(level.player maps\_utility::point_in_fov(var_04.origin) == 0)
		{
			continue;
		}

		if(isai(var_04))
		{
			var_04.lasttime = gettime();
			var_05 = var_04 snipertargetgettagpos();
		}
		else
		{
			var_05 = var_06.origin;
		}

		level.sniper_scramble_data.sniper_target_location = var_05;
		return 1;
	}

	return 0;
}

//Function Number: 53
findrandomlocationneartarget(param_00,param_01)
{
	var_02 = level.player;
	if(isdefined(level.snipertargetent))
	{
		var_02 = level.snipertargetent;
	}

	for(var_03 = 0;var_03 <= 5;var_03++)
	{
		if(common_scripts\utility::cointoss())
		{
			var_04 = (var_02.angles[0],var_02.angles[1] + randomintrange(-45,45),var_02.angles[2]);
			var_05 = anglestoforward(var_04);
			var_06 = var_02.origin + var_05 * randomfloatrange(param_00,param_01);
			if(!bullettracepassed(level.sniperpos.origin,var_06,0,undefined))
			{
				continue;
			}
		}
		else
		{
			var_04 = (var_02.angles[0],var_02.angles[1] + randomintrange(-15,15),var_02.angles[2] + randomintrange(-45,45));
			var_07 = anglestoright(var_04);
			if(common_scripts\utility::cointoss())
			{
				var_06 = var_02 geteye() + var_07 * randomfloatrange(param_00,param_01);
			}
			else
			{
				var_06 = var_02 geteye() - var_07 * randomfloatrange(param_00,param_01);
			}
		}

		level.sniper_scramble_data.sniper_target_location = var_06;
		return 1;
	}

	return 0;
}

//Function Number: 54
setup_sniper_debug_hud_elem()
{
	var_00 = newhudelem();
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.x = 40;
	var_00.y = 40;
	var_00.alpha = 0.6;
	var_00.fontscale = 1.5;
	var_00.foreground = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	return var_00;
}

//Function Number: 55
snipersetupglass()
{
	level endon("ScrambleSniperKilled");
	var_00 = getentarray("ScrambleGlassTrigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread sniperdestroyglass();
	}
}

//Function Number: 56
sniperdestroyglass()
{
	level endon("ScrambleSniperKilled");
	self waittill("trigger");
	glassradiusdamage(self.origin,48,1000,1000);
}

//Function Number: 57
snipershootfirstcivilian()
{
	level waittill("ScramblePatioCivShot");
	var_00 = maps\_utility::get_living_ai("PatioFlee01","script_noteworthy");
	if(isdefined(var_00))
	{
		var_01 = var_00 geteye();
		soundscripts\_snd::snd_message("windmill_sniper_shot",var_01);
		thread snipershoot(var_01,1,1);
		playfx(common_scripts\utility::getfx("scramble_blood_impact_splat"),var_01);
	}

	wait(1);
	level.sniperpos.bsniperenabled = 1;
	snipersettargetent(undefined);
	thread monitorsupersafevol();
	thread updatesnipershooting();
}

//Function Number: 58
snipershootcafewall()
{
	var_00 = common_scripts\utility::getstruct("ShootCafeWallOrg","targetname");
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	soundscripts\_snd::snd_message("mhunt_snpr_dest_cafe_wall",var_00);
	thread snipershoot(var_00.origin,1.5,1);
	thread maps\greece_sniper_scramble_fx::snipercafewallburstfx();
	wait(0.45);
	physicsexplosionsphere(var_00.origin,100,10,0.5);
}

//Function Number: 59
snipershootilana()
{
	level.sniperpos.bsniperenabled = 0;
	level waittill("ScrambleRestaurantIlanaShot");
	var_00 = common_scripts\utility::getstruct("ScrambleIlanaTarget1","targetname");
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	thread snipershoot(var_00.origin,1,1);
	level waittill("ScrambleRestaurantIlanaShot");
	wait(0.2);
	var_01 = common_scripts\utility::getstruct("ScrambleIlanaTarget2","targetname");
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_01.origin);
	thread snipershoot(var_01.origin,1,1);
	level waittill("ScrambleRestaurantCivShot");
	var_02 = maps\_utility::get_living_ai("ScrambleCivRestaurantDoorOpener_AI","targetname");
	if(isdefined(var_02))
	{
		var_03 = var_02 gettagorigin("J_Spine4");
		soundscripts\_snd::snd_message("windmill_sniper_shot",var_03);
		thread snipershoot(var_03,1,1);
		playfx(common_scripts\utility::getfx("scramble_blood_impact_splat"),var_03);
		soundscripts\_snd::snd_message("restaurant_door_civ_killed",var_02);
	}

	level.sniperpos.bsniperenabled = 1;
	snipersettargetent(level.player);
}

//Function Number: 60
openrestaurantdoor(param_00)
{
	self rotateto(self.angles + (0,param_00,0),0.35,0,0.35);
	earthquake(0.25,0.2,self.origin,256);
}

//Function Number: 61
snipershootrestaurantfishtank()
{
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerInRestaurant");
	level.sniperpos.bsniperenabled = 0;
	snipersettargetent(undefined);
	maps\_utility::trigger_wait_targetname("TrigFishTankDestruction");
	level.player allowsprint(0);
	level.player allowdodge(0);
	var_00 = getent("ScrambleFishTankShootOrg","script_noteworthy");
	soundscripts\_snd::snd_message("restaurant_fish_tank_destruct",var_00);
	thread snipershoot(var_00.origin,1.5,1);
	common_scripts\utility::flag_set("FlagScrambleDestroyFishTank");
	maps\_hms_utility::printlnscreenandconsole("FFFFFIIIIIIISSSSSSSHHHHHHHH!!!!");
	wait(1);
	level.sniperpos.bsniperenabled = 1;
	snipersettargetent(undefined);
	thread monitorrestaurantglassfrenzyvol();
}

//Function Number: 62
snipershootnearhotelciv()
{
	level.sniperpos.bsniperenabled = 0;
	wait(1);
	var_00 = getent("ScrambleHotelNearCiv","script_noteworthy");
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	thread snipershoot(var_00.origin,1.5,1);
}

//Function Number: 63
snipershootstingerpot()
{
	maps\_utility::trigger_wait_targetname("FinaleAlly02Trig");
	wait(1);
	var_00 = common_scripts\utility::getstruct("SniperStingerTargetPos","targetname");
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	thread snipershoot(var_00.origin,1.5,1);
	physicsexplosionsphere(var_00.origin,100,10,0.5);
}

//Function Number: 64
monitorplayerapproachfishtank()
{
	var_00 = getent("ScrambleFishTankLookAtOrg","script_noteworthy");
	var_01 = getent("TrigFishTankDestruction","targetname");
	for(;;)
	{
		wait 0.05;
		if(maps\_utility::players_within_distance(300,var_00.origin) && maps\_utility::within_fov_of_players(var_00.origin,cos(120)))
		{
			return 1;
		}

		if(level.player istouching(var_01))
		{
			return 0;
		}
	}
}

//Function Number: 65
scrambleplayerfishtankstumble()
{
	var_00 = getent("ScrambleFishTankLookAtOrg","script_noteworthy");
	var_01 = vectortoangles(var_00.origin - level.player.origin);
	var_02 = "fishtank_stumble";
	var_03 = maps\_utility::spawn_anim_model("player_scramble_rig",level.player.origin,level.player.angles);
	var_03 hide();
	level.player thread maps\_shg_utility::setup_player_for_scene();
	level.player setmovespeedscale(0.5);
	var_03 linkto(level.player);
	var_03 show();
	level.player maps\_anim::anim_single_solo(var_03,var_02);
	var_03 unlink();
	var_03 delete();
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowstand(1);
	level.player enableoffhandweapons();
	level.player enableweapons();
	level.player allowmelee(1);
	level.player maps\_utility::blend_movespeedscale(0.8,2);
	wait(3);
	level.player allowdodge(1);
	level.player allowsprint(1);
	level.player maps\_utility::blend_movespeedscale_default(2);
}

//Function Number: 66
spawnrestaurantfishswimming()
{
	var_00 = getent("restaurant_fish_org","targetname");
	var_01 = getent("restaurant_fish_tank_glass","targetname");
	var_02 = getent("restaurant_fish_org","targetname");
	var_03 = getent("restaurant_fish_tank_glass","targetname");
	var_04 = maps\_utility::spawn_anim_model("fish_a_01");
	var_05 = maps\_utility::spawn_anim_model("fish_a_02");
	var_06 = maps\_utility::spawn_anim_model("fish_a_03");
	var_07 = maps\_utility::spawn_anim_model("fish_a_04");
	var_08 = maps\_utility::spawn_anim_model("fish_a_05");
	var_09 = maps\_utility::spawn_anim_model("fish_a_06");
	level.fish_a = [var_04,var_05,var_06,var_07,var_08,var_09];
	var_0A = maps\_utility::spawn_anim_model("fish_b_01");
	var_0B = maps\_utility::spawn_anim_model("fish_b_02");
	var_0C = maps\_utility::spawn_anim_model("fish_b_03");
	level.fish_b = [var_0A,var_0B,var_0C];
	var_0D = common_scripts\utility::array_combine(level.fish_a,level.fish_b);
	var_00 thread maps\_anim::anim_loop(level.fish_a,"fish_a_swimming");
	var_00 thread maps\_anim::anim_loop(level.fish_b,"fish_b_swimming");
	thread maps\greece_sniper_scramble_fx::fishbubblesfx();
	common_scripts\utility::flag_wait("FlagScrambleDestroyFishTank");
	maps\_hms_utility::printlnscreenandconsole("Fish Tank Destruction triggered! =D");
	var_03 delete();
	thread maps\greece_sniper_scramble_fx::killfishbubblesfx();
	playfx(level._effect["restaurant_fish_tank_water_splash"],var_02.origin);
	var_0E = common_scripts\utility::getstruct("fishfall_01_org","targetname");
	var_0F = common_scripts\utility::getstruct("fishfall_02_org","targetname");
	var_10 = common_scripts\utility::getstruct("fishfall_03_org","targetname");
	var_11 = common_scripts\utility::getstruct("fishfall_04_org","targetname");
	var_12 = common_scripts\utility::getstruct("fishfall_05_org","targetname");
	var_13 = common_scripts\utility::getstruct("fishfall_06_org","targetname");
	var_14 = common_scripts\utility::getstruct("fishfall_07_org","targetname");
	var_15 = common_scripts\utility::getstruct("fishfall_08_org","targetname");
	var_16 = common_scripts\utility::getstruct("fishfall_09_org","targetname");
	var_0E thread maps\_anim::anim_single_solo(var_04,"fish_falling");
	var_0F thread maps\_anim::anim_single_solo(var_05,"fish_falling");
	var_10 thread maps\_anim::anim_single_solo(var_06,"fish_falling");
	var_11 thread maps\_anim::anim_single_solo(var_07,"fish_falling");
	var_12 thread maps\_anim::anim_single_solo(var_08,"fish_falling");
	var_13 thread maps\_anim::anim_single_solo(var_09,"fish_falling");
	var_14 thread maps\_anim::anim_single_solo(var_0A,"fish_falling");
	var_15 thread maps\_anim::anim_single_solo(var_0B,"fish_falling");
	var_16 thread maps\_anim::anim_single_solo(var_0C,"fish_falling");
	thread fish_animloop(var_04,"fish_deathflop_a",level.fish_a);
	thread fish_animloop(var_0A,"fish_deathflop_b",level.fish_b);
}

//Function Number: 67
fish_animloop(param_00,param_01,param_02)
{
	var_03 = param_00 maps\_utility::getanim(param_01)[0];
	var_04 = getanimlength(var_03);
	for(;;)
	{
		for(var_05 = 0;var_05 < param_02.size;var_05++)
		{
			wait(randomfloatrange(0.1,1));
			param_02[var_05] setanimrestart(var_03);
		}

		wait(var_04);
	}
}

//Function Number: 68
snipershootwoundedsoldier()
{
	var_00 = maps\_utility::get_living_ai("FinaleAlly01","script_noteworthy");
	level.sniperpos.bsniperenabled = 0;
	level waittill("ScrambleSniperShootWoundedSoldier");
	if(isdefined(var_00))
	{
		var_01 = var_00 snipertargetgettagpos();
		soundscripts\_snd::snd_message("windmill_sniper_shot",var_01);
		thread snipershoot(var_01,1.5,1);
		wait(0.05);
		var_02 = var_00 gettagorigin("TAG_EYE");
		playfx(common_scripts\utility::getfx("scramble_blood_impact_splat"),var_02);
	}

	common_scripts\utility::flag_set("FlagScrambleWoundedSoldierKilled");
	wait(1);
	level.sniperpos.bsniperenabled = 1;
	thread scramblerestaurantexitclip(0);
	level.player allowdodge(1);
	level.player allowsprint(1);
}

//Function Number: 69
scramblegapjumpslomo()
{
	wait(0.85);
	setslowmotion(1,0.2,0.5);
	wait(0.4);
	setslowmotion(0.2,1,0.3);
}

//Function Number: 70
snipershootgapjump()
{
	level.sniperpos.bsniperenabled = 0;
	level waittill("ScrambleSniperShootGapJump");
	var_00 = common_scripts\utility::getstruct("ScrambleGapJumpTarget1","targetname");
	snipershoot(var_00.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_00.origin);
	level waittill("ScrambleSniperShootGapJump");
	var_01 = common_scripts\utility::getstruct("ScrambleGapJumpTarget2","targetname");
	snipershoot(var_01.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_01.origin);
	level waittill("ScrambleSniperShootGapJump");
	var_02 = common_scripts\utility::getstruct("ScrambleGapJumpTarget3","targetname");
	snipershoot(var_02.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_02.origin);
	common_scripts\utility::flag_wait("FlagScrambleGapJumpCompleted");
	thread snipershootnearhotelciv();
}

//Function Number: 71
snipershoothoteljump(param_00)
{
	level.sniperpos.bsniperenabled = 0;
	var_01 = "_right";
	if(param_00 == 1)
	{
		var_01 = "_left";
	}

	level waittill("ScrambleSniperShootHotelJump");
	var_02 = "HotelJumpSniperTarget1" + var_01;
	var_03 = common_scripts\utility::getstruct(var_02,"targetname");
	snipershoot(var_03.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_03.origin);
	level waittill("ScrambleSniperShootHotelJump");
	var_04 = "HotelJumpSniperTarget2" + var_01;
	var_05 = common_scripts\utility::getstruct(var_04,"targetname");
	snipershoot(var_05.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_05.origin);
	wait(1);
	level.sniperpos.bsniperenabled = 1;
}

//Function Number: 72
snipershootcafejump(param_00)
{
	level.sniperpos.bsniperenabled = 0;
	var_01 = "_right";
	if(param_00 == 1)
	{
		var_01 = "_left";
	}

	level waittill("ScrambleSniperShootCafeJump");
	var_02 = "CafeJumpSniperTarget1" + var_01;
	var_03 = common_scripts\utility::getstruct(var_02,"targetname");
	snipershoot(var_03.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_03.origin);
	level waittill("ScrambleSniperShootCafeJump");
	var_04 = "CafeJumpSniperTarget2" + var_01;
	var_05 = common_scripts\utility::getstruct(var_04,"targetname");
	snipershoot(var_05.origin,1.5,1);
	soundscripts\_snd::snd_message("windmill_sniper_shot",var_05.origin);
}

//Function Number: 73
ilanascrambleinit()
{
	var_00 = level.allies["Ilona"];
	var_00 maps\_utility::enable_bulletwhizbyreaction();
	var_00 maps\_utility::enable_pain();
	common_scripts\utility::flag_set("init_sniper_scramble_lighting");
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
}

//Function Number: 74
ilanascrambleopenstartdoor()
{
	var_00 = common_scripts\utility::getstruct("SniperScrambleStartDoorOrg","targetname");
	var_00 maps\_anim::anim_reach_solo(level.allies["Ilona"],"scramble_intro_door_in");
	var_00 maps\_anim::anim_single_solo(level.allies["Ilona"],"scramble_intro_door_in");
	var_00 thread maps\_anim::anim_loop_solo(level.allies["Ilona"],"scramble_intro_door_loop","ScrambleIlanaOpenIntroDoor");
	common_scripts\utility::flag_wait("FlagScrambleIlanaBeginOpenIntroDoor");
	soundscripts\_snd::snd_message("stop_alleys_emergency_audio");
	var_00 notify("ScrambleIlanaOpenIntroDoor");
	wait(0.05);
	thread maps\_utility::autosave_by_name("scramble_intro_start");
	thread ilanasmokescreen(var_00);
	var_01 = getent("ScrambleIntroDoor","targetname");
	var_02 = getent("ScrambleIntroDoorClip","targetname");
	thread scramblestartdoorshots(var_01);
	var_00 thread maps\_anim::anim_single_solo(var_01,"scramble_intro_door_out");
	var_00 maps\_anim::anim_single_solo_run(level.allies["Ilona"],"scramble_intro_door_out");
	var_02 delete();
	common_scripts\utility::flag_set("FlagScrambleIlanaEndOpenIntroDoor");
	level notify("ScrambleSniperShootFirstCivilian");
	level.allies["Ilona"] thread ilanascramblemovement();
}

//Function Number: 75
scramblestartdoorshots(param_00)
{
	level waittill("ScrambleSniperFireFirstShot");
	param_00 showpart("tag_destroyed1","greece_door_interior");
	param_00 showpart("tag_door_handle_destroyed1","greece_door_interior");
	param_00 showpart("tag_door_handle_base_destroyed1","greece_door_interior");
	param_00 hidepart("tag_intact","greece_door_interior");
	param_00 hidepart("tag_door_handle","greece_door_interior");
	level waittill("ScrambleSniperFireSecondShot");
	param_00 hidepart("tag_door_handle_destroyed1","greece_door_interior");
	param_00 hidepart("tag_door_handle_base_destroyed1","greece_door_interior");
	param_00 hidepart("tag_destroyed1","greece_door_interior");
	param_00 showpart("tag_destroyed2","greece_door_interior");
	param_00 showpart("tag_door_handle_base_destroyed2","greece_door_interior");
	param_00 showpart("tag_door_handle_destroyed2","greece_door_interior");
}

//Function Number: 76
scramblestartdoorinit()
{
	var_00 = getent("ScrambleIntroDoor","targetname");
	var_00.animname = "sniper_intro_door";
	var_00 maps\_utility::assign_animtree("sniper_intro_door");
	var_01 = common_scripts\utility::getstruct("SniperScrambleStartDoorOrg","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"scramble_intro_door_out");
	var_00 hidepart("tag_destroyed1","greece_door_interior");
	var_00 hidepart("tag_door_handle_destroyed1","greece_door_interior");
	var_00 hidepart("tag_door_handle_base_destroyed1","greece_door_interior");
	var_00 hidepart("tag_destroyed2","greece_door_interior");
	var_00 hidepart("tag_door_handle_destroyed2","greece_door_interior");
	var_00 hidepart("tag_door_handle_base_destroyed2","greece_door_interior");
}

//Function Number: 77
ilanasmokescreen(param_00)
{
	var_01 = maps\_utility::spawn_anim_model("smoke_grenade");
	param_00 maps\_anim::anim_single_solo(var_01,"scramble_intro_door_out");
	var_01 delete();
	var_02 = common_scripts\utility::getstruct("ScrambleSmokeScreenOrg","targetname");
	playfx(common_scripts\utility::getfx("smoke_screen"),var_02.origin);
	thread maps\greece_sniper_scramble_fx::smokescreenemitterfx();
	var_03 = getent("ScrambleSmokeSafeVol","script_noteworthy");
	var_03.bisactivated = 1;
	wait(15);
	var_03.bisactivated = 0;
}

//Function Number: 78
ilanatogglesnipersuppression(param_00)
{
	var_01 = getent("ScrambleSniperWindow","targetname");
	if(param_00 == 1)
	{
		level.allies["Ilona"] setentitytarget(var_01);
		return;
	}

	level.allies["Ilona"] clearentitytarget(var_01);
	level notify("StopIlanaSuppression");
}

//Function Number: 79
ilanasuppresspos(param_00)
{
	level endon("StopIlanaSuppression");
	for(;;)
	{
		magicbullet("iw5_hmr9_sp",level.allies["Ilona"] geteye(),param_00.origin);
		wait(randomfloatrange(0.1,0.5));
	}
}

//Function Number: 80
ilanascramblemovement()
{
	var_00 = level.start_point;
	maps\_hms_ai_utility::playerleashdisable();
	maps\_utility::set_battlechatter(0);
	self.oldgrenadeammo = self.grenadeammo;
	self.grenadeammo = 0;
	maps\_utility::set_force_color("g");
	wait(0.05);
	if(var_00 == "start_sniper_scramble_hotel")
	{
		maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigThird");
		thread ilanascramblehotel();
		return;
	}

	if(var_00 == "start_sniper_scramble_drones")
	{
		maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigSixth");
		thread ilanascrambledrones();
		return;
	}

	if(var_00 == "start_sniper_scramble_finale")
	{
		maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigEleventh");
		thread ilanascramblefinale();
		return;
	}

	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigFirst");
	thread ilanascrambleintro();
}

//Function Number: 81
ilanascrambleintro()
{
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerExitAlleys");
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigSecond");
	common_scripts\utility::flag_wait("FlagScrambleGapJumpCompleted");
	thread ilanascramblehotel();
}

//Function Number: 82
ilanascramblehotel()
{
	thread monitorslidesafevol();
	thread scrambleplayerhoteljump();
	level.sniperpos.bsniperenabled = 0;
	level.player allowsprint(0);
	level.player allowdodge(0);
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerMovingThroughHotel");
	var_00 = getent("hothall_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.allies["Ilona"],"scram_hothall");
	common_scripts\utility::flag_set("FlagScrambleBeginHothall");
	thread snipershoothothall();
	var_00 maps\_anim::anim_single_solo(level.allies["Ilona"],"scram_hothall");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyStartScrambleWindowCover");
	wait 0.05;
	level.allies["Ilona"] waittill("goal");
	level.allies["Ilona"] maps\_utility::enable_sprint();
	common_scripts\utility::flag_set("FlagScrambleEndHothall");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearSecondJump");
	thread maps\_utility::autosave_by_name("scramble_hotel_jump_start");
	common_scripts\utility::flag_wait("FlagScrambleCheckPlayerDecision");
	level.allies["Ilona"] pushplayer(1);
	for(;;)
	{
		if(common_scripts\utility::flag("FlagScrambleHotelJumpStarted"))
		{
			level notify("ScrambleHotelPlayerJumpedFirst");
			common_scripts\utility::flag_set("FlagScrambleHotelPlayerHasDecided");
			sniperhoteltargetplayerfirst();
			break;
		}
		else if(common_scripts\utility::flag("FlagScrambleSniperSuppressed"))
		{
			level notify("ScrambleHotelPlayerSuppressedFirst");
			common_scripts\utility::flag_set("FlagScrambleHotelPlayerHasDecided");
			sniperhoteltargetilanafirst();
			break;
		}

		wait(0.05);
	}

	thread scramblecivdrones();
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	thread maps\_utility::autosave_by_name("scramble_cafe_jump_start");
	wait(1);
	level.sniper_scramble_data.suppression_time = 0;
	ilanatogglesnipersuppression(0);
	snipersettargetent(undefined);
	var_01 = common_scripts\utility::getstruct("cafeWindowOrg","targetname");
	var_02 = "cafe_traversal";
	var_03 = distance(level.allies["Ilona"].origin,var_01.origin);
	if(var_03 > 64)
	{
		var_01 = common_scripts\utility::getstruct("cafeWindowOrgAlt","targetname");
		var_02 = "cafe_traversal_alt";
	}

	var_01 maps\_anim::anim_reach_solo(level.allies["Ilona"],var_02);
	common_scripts\utility::flag_set("FlagScrambleHotelIlanaJumpDown");
	var_01 thread maps\_anim::anim_single_solo_run(level.allies["Ilona"],var_02);
	wait(1);
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigFiftyFifth");
	level.allies["Ilona"] pushplayer(0);
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerCompletedThirdJump");
	wait(1);
	common_scripts\utility::flag_set("FlagScrambleStartDrones");
	thread ilanascrambledrones();
}

//Function Number: 83
sniperhoteltargetilanafirst()
{
	maps\_hms_utility::printlnscreenandconsole("Player is suppressing sniper - Ilana is running!");
	thread monitorhotelilanaleapfrog();
	common_scripts\utility::flag_wait_either("FlagScrambleHotelJumpCompleted","FlagScrambleHotelJumpStarted");
	thread monitorhotelplayerleapfrog();
	snipersettargetent(level.player);
	ilanatogglesnipersuppression(1);
	maps\_hms_utility::printlnscreenandconsole("Player jumped down - Ilana is suppressing!");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	level.player notify("ScramblePlayerCompletedLeapfrog");
	ilanatogglesnipersuppression(0);
	snipersettargetent(undefined);
	maps\_hms_utility::printlnscreenandconsole("Player at end - HOTEL COMPLETE!");
}

//Function Number: 84
sniperhoteltargetplayerfirst()
{
	thread monitorhotelplayerleapfrog();
	snipersettargetent(level.player);
	ilanatogglesnipersuppression(1);
	maps\_hms_utility::printlnscreenandconsole("Player jumped down - Ilana is suppressing!");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	level.player notify("ScramblePlayerCompletedLeapfrog");
	ilanatogglesnipersuppression(0);
	snipersettargetent(undefined);
	maps\_hms_utility::printlnscreenandconsole("Player at end - Ilana is waiting for suppression...");
	level.sniper_scramble_data.suppression_time = 0;
	wait(1);
	common_scripts\utility::flag_wait("FlagScrambleSniperSuppressed");
	maps\_hms_utility::printlnscreenandconsole("Player is suppressing sniper - Ilana is running!");
	thread monitorhotelilanaleapfrog();
	common_scripts\utility::flag_wait("FlagScrambleHotelIlanaReachedGoal");
	maps\_hms_utility::printlnscreenandconsole("Ilana at end - HOTEL COMPLETE!");
}

//Function Number: 85
hintscramblesuppress1off()
{
	if(common_scripts\utility::flag("FlagScrambleSniperSuppressed") || common_scripts\utility::flag("FlagScrambleHotelIlanaStartRun"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 86
hintscramblesuppress2off()
{
	if(common_scripts\utility::flag("FlagScrambleSniperSuppressed") || common_scripts\utility::flag("FlagScrambleHotelIlanaStartRun") || common_scripts\utility::flag("FlagScrambleHotelJumpStarted"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 87
hintscrambleadvanceoff()
{
	return common_scripts\utility::flag("FlagScrambleHotelJumpStarted");
}

//Function Number: 88
monitorhotelplayerleapfrog()
{
	level.player endon("ScramblePlayerCompletedLeapfrog");
	level.player waittill("damage");
	common_scripts\utility::flag_set("FlagScrambleHotelBadLeapfrog");
}

//Function Number: 89
monitorhotelilanaleapfrog()
{
	common_scripts\utility::flag_set("FlagScrambleHotelIlanaStartRun");
	level.allies["Ilona"] maps\_utility::enable_sprint();
	snipersettargetent(level.allies["Ilona"]);
	thread maps\greece_sniper_scramble_fx::windowhoteljumpglassshatter(0.5);
	var_00 = getent("ScrambleIlanaCornerClip","targetname");
	var_00 delete();
	var_01 = common_scripts\utility::getstruct("hotelWindowOrg","targetname");
	var_01 maps\_anim::anim_single_solo_run(level.allies["Ilona"],"hotel_traversal");
	level.allies["Ilona"] maps\_utility::enable_ai_color();
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyStartScrambleCafeCover");
	thread ilanaleapfrogadjustgoal();
	maps\_utility::trigger_wait_targetname("SniperScrambleHotelIlanaAtGoal");
	level.allies["Ilona"] maps\_utility::disable_sprint();
	level notify("IlanaLeapfrogGoal");
	common_scripts\utility::flag_set("FlagScrambleHotelIlanaReachedGoal");
	maps\_hms_utility::printlnscreenandconsole("Ilana at goal");
	if(!common_scripts\utility::flag("FlagScrambleHotelJumpCompleted"))
	{
		snipersettargetent(undefined);
	}
}

//Function Number: 90
ilanaleapfrogadjustgoal()
{
	level endon("IlanaLeapfrogGoal");
	var_00 = getnode("AllyStartScrambleCafeCover","targetname");
	var_01 = undefined;
	for(;;)
	{
		wait 0.05;
		if(!maps\_utility::players_within_distance(64,var_00.origin))
		{
			continue;
		}

		var_01 = ilanaleapfroggetgoal();
		if(isdefined(var_01))
		{
			level.allies["Ilona"] maps\_utility::set_goal_node(var_01);
			var_00 = var_01;
		}
	}
}

//Function Number: 91
ilanaleapfroggetgoal()
{
	var_00 = undefined;
	var_01 = getnodearray("ilana_leapfrog","script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(maps\_utility::players_within_distance(64,var_03.origin))
		{
			continue;
		}
		else
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 92
ilanascrambledrones()
{
	thread scramblespawndronesa();
	thread spawnrestaurantfishswimming();
	thread scramblecivrestaurantdooropener();
	var_00 = getentarray("ScrambleDronesToRestaurantTrig","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	level.allies["Ilona"] maps\_utility::enable_ai_color();
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigSixth");
	common_scripts\utility::flag_wait("FlagScrambleDronesAdead");
	maps\_utility::disable_trigger_with_targetname("SniperScrambleColorTrigSixth");
	maps\_utility::disable_trigger_with_targetname("SniperScrambleColorTrigSeventh");
	wait(0.05);
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigEighth");
	thread maps\_utility::autosave_by_name("scramble_drone_fight_end");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}

	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerUnderBridge");
	level.allies["Ilona"] maps\_utility::enable_sprint();
	var_06 = common_scripts\utility::getstruct("RestaurantDoorOpenOrg","script_noteworthy");
	thread snipershootilana();
	var_06 maps\_anim::anim_reach_solo(level.allies["Ilona"],"RestaurantOpenDoor");
	thread scramblerestaurantcivexit();
	thread scramblerestaurantdoorsopen();
	var_06 maps\_anim::anim_single_solo(level.allies["Ilona"],"RestaurantOpenDoor");
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigTenth");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerMidRestaurant");
	thread scramblefinaleallies();
	thread pitbulldestroyedanimation();
	thread ilanascramblefinale();
}

//Function Number: 93
scramblerestaurantcivexit()
{
	var_00 = common_scripts\utility::getstruct("RestaurantDoorOpenOrg","script_noteworthy");
	var_01 = maps\_utility::get_living_ai("ScrambleCivRestaurantDoorOpener_AI","targetname");
	var_00 notify("scramble_open_restaurant");
	var_00 maps\_anim::anim_single_solo(var_01,"RestaurantOpenDoor");
	var_01 maps\greece_code::kill_no_react(0);
}

//Function Number: 94
scramblerestaurantdoorsopen()
{
	var_00 = common_scripts\utility::getstruct("RestaurantDoorOpenOrg","script_noteworthy");
	var_01 = getent("ScrambleRestaurantDoors","targetname");
	var_00 thread maps\_anim::anim_single_solo(var_01,"RestaurantOpenDoor");
	level waittill("ScrambleRestaurantDoorsOpen");
	soundscripts\_snd::snd_message("restaurant_doors_open",var_01);
	var_02 = getent("ScrambleRestaurantDoorClip","targetname");
	var_02 delete();
	var_03 = getent("ScrambleRestaurantDoorOpenClip","targetname");
	var_03 movez(128,0.1);
}

//Function Number: 95
monitorrestaurantglassfrenzyvol()
{
	var_00 = getent("SniperScrambleRestaurantFrenzy","targetname");
	var_01 = getentarray("ScrambleRestaurantGlass","script_noteworthy");
	while(!common_scripts\utility::flag("FlagTriggerScramblePlayerAlmostNearWoundedSoldier"))
	{
		if(level.player istouching(var_00))
		{
			var_01 = sortbydistance(var_01,level.player.origin);
			if(isdefined(var_01[0]) && maps\_utility::players_within_distance(256,var_01[0].origin))
			{
				var_02 = var_01[0];
				level.sniperpos.bsniperenabled = 0;
				snipershoot(var_02.origin);
				soundscripts\_snd::snd_message("windmill_sniper_shot_multi",var_02.origin);
				var_01 = common_scripts\utility::array_remove(var_01,var_02);
				wait(randomfloatrange(0.5,1.5));
			}
			else
			{
				level.sniperpos.bsniperenabled = 1;
				level.sniper_scramble_data.requires_player_los = 0;
				snipersettargetent(level.player);
			}

			continue;
		}

		level.sniper_scramble_data.requires_player_los = 1;
		level.snipertargetent = undefined;
		wait(0.05);
	}

	level.sniperpos.bsniperenabled = 0;
	level.sniper_scramble_data.requires_player_los = 1;
}

//Function Number: 96
monitorsupersafevol()
{
	level endon("ScrambleSniperKilled");
	var_00 = getentarray("ScrambleSuperSafeVol","script_noteworthy");
	var_01 = 0;
	for(;;)
	{
		wait(0.5);
		if(targetinsafevolume(level.player,var_00))
		{
			level.sniper_scramble_data.player_in_disable_sniper_volume = 1;
			continue;
		}

		level.sniper_scramble_data.player_in_disable_sniper_volume = 0;
	}
}

//Function Number: 97
monitorslidesafevol()
{
	level endon("ScrambleSniperKilled");
	var_00 = getent("ScrambleSlideSafeVol","script_noteworthy");
	var_00.bisactivated = 0;
	while(!common_scripts\utility::flag("FlagScrambleHotelIlanaReachedGoal"))
	{
		if(level.player istouching(var_00))
		{
			snipersettargetent(level.player);
			soundscripts\_snd::snd_message("windmill_sniper_shot",level.player geteye());
			snipershoot(level.player geteye(),1.5,1);
			wait(0.05);
			maps\_hms_utility::printlnscreenandconsole("*** FORCE KILL PLAYER ***");
			level.player stopanimscripted();
			level.player kill();
			level notify("ScramblePlayerLeftIlana");
			maps\greece_sniper_scramble_vo::scramblefailplayerleftilanadialogue();
			wait(1);
			setdvar("ui_deadquote",&"GREECE_FAIL_SCRAMBLE_LEFT_ILONA");
			maps\_utility::missionfailedwrapper();
			return;
		}

		wait(0.05);
	}

	var_00.bisactivated = 1;
}

//Function Number: 98
ilanascramblefinale()
{
	thread sniperdeath();
	thread snipershootwoundedsoldier();
	thread scramblecivfinale();
	thread scramblefiredamagemonitor();
	thread scramblerestaurantexitclip(1);
	thread destroydroppedgun();
	level.player allowsprint(0);
	level.player allowdodge(0);
	var_00 = level.allies["Ilona"];
	var_01 = common_scripts\utility::getstruct("ScrambleIlanaLookAllyOrg","targetname");
	var_01 maps\_anim::anim_reach_solo(var_00,"scramble_check_ally_enter");
	var_01 maps\_anim::anim_single_solo(var_00,"scramble_check_ally_enter");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"scramble_check_ally_idle","wounded_loop_end");
	var_00 maps\_utility::disable_sprint();
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearWoundedSoldier");
	thread maps\_utility::autosave_by_name("scramble_finale_start");
	common_scripts\utility::flag_wait("FlagScrambleReadyForWoundedSoldier");
	thread playerscramblefinale();
	var_01 notify("wounded_loop_end");
	thread woundedsoldierdeath(var_01);
	var_01 maps\_anim::anim_single_solo_run(var_00,"scramble_check_ally_exit");
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigTwelfth");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerLeavingRestaurant");
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigThirteenth");
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerOnStreet");
	level.allies["Ilona"] maps\_utility::set_ignoresuppression(1);
	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigSixteenth");
	for(;;)
	{
		if(level.player hasweapon("iw5_stingerm7greece_sp"))
		{
			break;
		}

		wait(0.1);
	}

	thread maps\_utility::autosave_by_name("scramble_finale_stinger");
	var_02 = getentarray("ScrambleFinaleColorTrig","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_04 common_scripts\utility::trigger_off();
	}

	maps\_utility::activate_trigger_with_targetname("SniperScrambleColorTrigSeventeenth");
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	level.allies["Ilona"] maps\_utility::disable_ai_color();
	maps\_utility::clear_color_order("g","allies");
	level.allies["Ilona"] maps\_utility::set_ignoresuppression(0);
	level.allies["Ilona"].grenadeammo = level.allies["Ilona"].oldgrenadeammo;
	level.allies["Ilona"] maps\_utility::set_battlechatter(0);
	thread maps\_utility::autosave_by_name("scramble_finale_end");
	thread ilanasetupmovetruck();
}

//Function Number: 99
playerscramblefinale()
{
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerOnStreet");
	thread scramblespawndronesb();
	level.sniper_scramble_data.sniper_finale = 1;
	level.sniper_scramble_data.minburstdelay = 1;
	level.sniper_scramble_data.maxburstdelay = 3;
	thread monitorplayerfirerpgattower();
	thread scrambleatlasrpg();
}

//Function Number: 100
scramblesniperkillplayerfailmsg()
{
	level endon("ScrambleSniperKilled");
	level.player waittill("death",var_00,var_01,var_02);
	if(level.player hasweapon("iw5_stingerm7greece_sp"))
	{
		return;
	}

	if(isdefined(var_01) && var_01 == "MOD_EXPLOSIVE")
	{
		return;
	}

	if(isdefined(var_00) && var_00.classname == "script_vehicle_pdrone_kva")
	{
		return;
	}

	setdvar("ui_deadquote",&"GREECE_FAIL_SCRAMBLE_SUPPRESS_SNIPER");
}

//Function Number: 101
woundedsoldierdeath(param_00)
{
	var_01 = maps\_utility::get_living_ai("FinaleAlly01","script_noteworthy");
	param_00 maps\_anim::anim_single_solo(var_01,"sanchez_wounded_death");
	var_01 maps\greece_code::kill_no_react();
}

//Function Number: 102
ilanascramblefinalemoveandsuppress()
{
	level endon("ScrambleSniperKilled");
	level.allies["Ilona"].bissuppressingsniper = 0;
	var_00 = getnodearray("ScrambleIlanaFinaleSuppressSniper","script_noteworthy");
	while(!common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		var_01 = level.allies["Ilona"] getcovernode();
		if(isdefined(var_01) && maps\_utility::is_in_array(var_00,var_01) && level.allies["Ilona"].bissuppressingsniper == 0)
		{
			ilanatogglesnipersuppression(1);
			snipersettargetent(level.allies["Ilona"]);
			level.allies["Ilona"].bissuppressingsniper = 1;
			maps\_hms_utility::printlnscreenandconsole("*** Ilana IS suppressing sniper ***");
			continue;
		}

		ilanatogglesnipersuppression(0);
		snipersettargetent(undefined);
		level.allies["Ilona"].bissuppressingsniper = 0;
		wait(0.1);
	}

	ilanatogglesnipersuppression(0);
	level.allies["Ilona"].bissuppressingsniper = 0;
	maps\_hms_utility::printlnscreenandconsole("*** Ilana IS NOT suppressing sniper ***");
}

//Function Number: 103
ilanasetupmovetruck()
{
	var_00 = common_scripts\utility::getstruct("ScramblePlayerExitOrg","targetname");
	var_00 maps\_anim::anim_reach_solo(level.allies["Ilona"],"run_to_truck");
	var_00 maps\_anim::anim_single_solo(level.allies["Ilona"],"run_to_truck");
	var_00 thread maps\_anim::anim_loop_solo(level.allies["Ilona"],"move_truck_idle","ilana_move_truck_end");
	common_scripts\utility::flag_set("FlagScrambleIlanaStartMoveTruck");
}

//Function Number: 104
ilanamovetruck()
{
	var_00 = common_scripts\utility::getstruct("ScramblePlayerExitOrg","targetname");
	var_00 notify("ilana_move_truck_end");
	level.allies["Ilona"] maps\_utility::anim_stopanimscripted();
	var_00 thread maps\_anim::anim_single_solo_run(level.allies["Ilona"],"move_truck");
	wait(1);
	var_01 = getnode("AllyEndingStartCover","targetname");
	level.allies["Ilona"] maps\_utility::set_goal_node(var_01);
	wait(5);
	level.allies["Ilona"] maps\_utility::gun_recall();
}

//Function Number: 105
scramblesnipertowerdestruction()
{
	var_00 = getent("sniper_tower_org","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("greece_sniper_tower_des");
	var_02 = [];
	var_02[0] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_01",var_00.origin);
	var_02[0].animname = "greece_sniper_tower_des_01";
	var_02[0] maps\_anim::setanimtree();
	var_02[1] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_02",var_00.origin);
	var_02[1].animname = "greece_sniper_tower_des_02";
	var_02[1] maps\_anim::setanimtree();
	var_02[2] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_03",var_00.origin);
	var_02[2].animname = "greece_sniper_tower_des_03";
	var_02[2] maps\_anim::setanimtree();
	var_02[3] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_04",var_00.origin);
	var_02[3].animname = "greece_sniper_tower_des_04";
	var_02[3] maps\_anim::setanimtree();
	var_02[4] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_05",var_00.origin);
	var_02[4].animname = "greece_sniper_tower_des_05";
	var_02[4] maps\_anim::setanimtree();
	var_02[5] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_06",var_00.origin);
	var_02[5].animname = "greece_sniper_tower_des_06";
	var_02[5] maps\_anim::setanimtree();
	var_02[6] = maps\_utility::spawn_anim_model("greece_sniper_tower_des_07",var_00.origin);
	var_02[6].animname = "greece_sniper_tower_des_07";
	var_02[6] maps\_anim::setanimtree();
	var_00 maps\_anim::anim_first_frame(var_02,"windmill_explode");
	var_00 thread maps\_anim::anim_single(var_02,"windmill_explode");
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	maps\_utility::array_delete(var_02);
}

//Function Number: 106
scramblesnipertowerdestructionshake()
{
	level.player playrumbleonentity("tank_rumble");
	earthquake(0.6,0.25,level.player.origin,128);
	wait(0.5);
	level.player playrumbleonentity("subtle_tank_rumble");
	earthquake(0.2,10,level.player.origin,128);
}

//Function Number: 107
scramblesniperragdoll()
{
	var_00 = maps\_utility::array_spawn_targetname("ScrambleSniperRagdoll",1);
	foreach(var_02 in var_00)
	{
		var_02.animname = "generic";
		var_03 = var_02.script_noteworthy + "Org";
		var_04 = common_scripts\utility::getstruct(var_03,"targetname");
		var_05 = var_04.animation;
		var_02 maps\_utility::gun_remove();
		var_02 thread sniperscrambleragdollkill(var_04,var_05);
	}
}

//Function Number: 108
sniperscrambleragdollkill(param_00,param_01)
{
	thread maps\greece_sniper_scramble_fx::ragdollonfirefx();
	param_00 maps\_anim::anim_single_solo(self,param_01);
	self kill();
	wait(3);
	if(isdefined(self) && self isragdoll())
	{
		self delete();
	}
}

//Function Number: 109
sniperdeath()
{
	var_00 = getent("SniperDeathDamageTrigger","targetname");
	var_00 common_scripts\utility::trigger_off();
	common_scripts\utility::flag_wait("FlagScramblePlayerHasStinger");
	level.sniper_scramble_data.shot_delay = 3;
	var_00 common_scripts\utility::trigger_on();
	var_00 waittill("trigger");
	level notify("ScrambleSniperKilled");
	common_scripts\utility::flag_set("FlagScrambleSniperKilled");
	soundscripts\_snd::snd_message("mhunt_snpr_tower_collapse");
	thread scramblesnipertowerdestructionshake();
	thread maps\greece_sniper_scramble_fx::snipertowerexplosionfx();
	thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
	thread maps\greece_sniper_scramble_fx::movetruckfirefx();
	wait(0.15);
	var_01 = getent("sniper_tower","targetname");
	var_01 delete();
	thread scramblesnipertowerdestruction();
	thread scramblesniperragdoll();
}

//Function Number: 110
sniperdeathinternal()
{
	if(common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		return;
	}

	level notify("ScrambleSniperKilled");
	common_scripts\utility::flag_set("FlagScrambleSniperKilled");
	soundscripts\_snd::snd_message("mhunt_snpr_tower_collapse");
	thread scramblesnipertowerdestructionshake();
	thread maps\greece_sniper_scramble_fx::snipertowerexplosionfx();
	thread maps\greece_sniper_scramble_fx::snipertowerresidualfx();
	thread maps\greece_sniper_scramble_fx::movetruckfirefx();
	wait(0.15);
	var_00 = getent("sniper_tower","targetname");
	var_00 delete();
	thread scramblesnipertowerdestruction();
	thread scramblesniperragdoll();
}

//Function Number: 111
setdronehealth(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 maps\_vehicle::vehicle_set_health(100);
	}
}

//Function Number: 112
scramblespawndronesa()
{
	wait(0.05);
	thread maps\_utility::autosave_by_name("scramble_drone_fight_A");
	if(level.currentgen)
	{
		wait(2);
	}

	soundscripts\_snd::snd_message("start_swarm_drones_context");
	var_00 = vehicle_scripts\_pdrone::start_flying_attack_drones("ScrambleDroneA");
	maps\_hms_utility::printlnscreenandconsole("Drones A: spawning " + var_00.size + " drones");
	common_scripts\utility::array_thread(var_00,::droneflyinshooting,6);
}

//Function Number: 113
scramblespawndronesb()
{
	wait(0.05);
	thread maps\_utility::autosave_by_name("scramble_drone_fight_B");
	if(level.currentgen)
	{
		wait(2);
	}

	soundscripts\_snd::snd_message("start_swarm_drones_context");
	var_00 = vehicle_scripts\_pdrone::start_flying_attack_drones("ScrambleDroneB");
	maps\_hms_utility::printlnscreenandconsole("Drones B: spawning " + var_00.size + " drones");
	common_scripts\utility::array_thread(var_00,::droneflyinshooting,6);
	thread monitorfinalesafevol();
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	soundscripts\_snd::snd_message("stop_swarm_drones_context");
	var_00 = maps\_utility::array_removedead(var_00);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 maps\_utility::ent_flag_set("fire_disabled");
			var_02.pacifist = 1;
			var_02 vehicle_scripts\_pdrone::pdrone_emp_death();
		}

		wait(randomfloat(0.1));
	}
}

//Function Number: 114
scrambleatlasrpg()
{
	wait(1);
	level.numberofdronestokill = 3;
	var_00 = getent("Atlas_RPG_Origin","targetname");
	var_01 = getentarray("Atlas_RPG_Target","targetname");
	for(var_02 = 0;var_02 < 8;var_02++)
	{
		var_03 = common_scripts\utility::random(var_01);
		var_04 = magicbullet("iw5_stingerm7greece_sp",var_00.origin,var_03.origin);
		var_04 thread maps\_stingerm7_greece::_randommissilemovement(var_03);
		var_04 thread _destroyprojectileafterdelay(randomfloatrange(1,2));
		soundscripts\_snd::snd_message("ally_shoot_rpg_at_drones",var_00);
		wait(randomfloatrange(0.15,0.25));
	}

	common_scripts\utility::flag_set("FlagScrambleGetRPG");
}

//Function Number: 115
_destroyprojectileafterdelay(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(isdefined(self))
	{
		var_01 = self.origin;
		var_02 = self.angles;
		playfx(common_scripts\utility::getfx("stinger_rocket_explosion"),var_01,anglestoforward(var_02),anglestoup(var_02));
		if(level.numberofdronestokill != 0)
		{
			var_03 = common_scripts\utility::getclosest(self.origin,level.flying_attack_drones);
			if(isdefined(var_03) && var_03.health > 0)
			{
				var_03 dodamage(var_03.health,level.player.origin);
			}

			level.numberofdronestokill--;
		}

		self delete();
	}
}

//Function Number: 116
monitorfinalesafevol()
{
	level endon("ScrambleSniperKilled");
	var_00 = getent("ScrambleFinaleSafeVol","script_noteworthy");
	var_00.bisactivated = 1;
	for(;;)
	{
		if(common_scripts\utility::flag("FlagScrambleDronesBdead") || level.player hasweapon("iw5_stingerm7greece_sp"))
		{
			break;
		}

		wait(0.5);
	}

	snipersettargetent(undefined);
	var_00.bisactivated = 0;
	for(;;)
	{
		if(level.player hasweapon("iw5_stingerm7greece_sp"))
		{
			break;
		}

		wait(0.1);
	}

	level.sniperpos.bsniperenabled = 0;
	wait(5);
	level.sniperpos.bsniperenabled = 1;
	snipersettargetent(level.player);
	level.sniper_scramble_data.requires_player_los = 0;
}

//Function Number: 117
droneflyinshooting(param_00)
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	self laseron();
	thread monitordeaddrones();
	maps\_utility::ent_flag_set("fire_disabled");
	self.pacifist = 1;
	var_01 = self.script_noteworthy + "Target";
	var_02 = getent(var_01,"targetname");
	var_03 = param_00 - 3;
	if(var_03 < 1)
	{
		var_03 = 1;
	}

	var_04 = param_00 + 3;
	var_05 = randomfloatrange(var_03,var_04);
	if(isdefined(var_02))
	{
		thread dronetargetmove(var_02,var_05);
		thread dronefireatscriptedtarget(var_02,"pdrone_end_flyin");
	}

	wait(var_05);
	self notify("pdrone_end_flyin");
	maps\_utility::ent_flag_clear("fire_disabled");
	if(common_scripts\utility::cointoss())
	{
		self.favoriteenemy = level.player;
	}

	self.pacifist = 0;
}

//Function Number: 118
dronetargetmove(param_00,param_01)
{
	self endon("death");
	self endon("emp_death");
	self endon("pdrone_end_flyin");
	var_02 = level.player.origin + (randomfloatrange(-100,100),randomfloatrange(-100,100),0);
	param_00 moveto(var_02,param_01);
	for(;;)
	{
		if(maps\_hms_utility::cointossweighted(25))
		{
			physicsexplosionsphere(param_00.origin,100,10,0.5);
		}

		wait(0.1);
	}
}

//Function Number: 119
dronefireatscriptedtarget(param_00,param_01)
{
	self endon("death");
	self endon("emp_death");
	if(isdefined(self.owner))
	{
		self.owner endon("pdrone_returning");
	}

	self endon(param_01);
	var_02 = 0.3;
	var_03 = 0.095;
	if(level.currentgen)
	{
		var_03 = 0.2499;
	}

	var_04 = -10 / var_02;
	var_05 = 10 / var_02;
	var_06 = -5 / var_02;
	var_07 = 5 / var_02;
	for(;;)
	{
		var_08 = (randomfloatrange(var_04,var_05),randomfloatrange(var_04,var_05),randomfloatrange(var_06,var_07));
		self setturrettargetent(param_00,var_08);
		var_09 = self gettagorigin("tag_flash");
		var_0A = self gettagorigin("tag_flash");
		self fireweapon();
		wait(var_03);
	}
}

//Function Number: 120
monitordeaddrones()
{
	self waittill("death");
	if(isdefined(self.script_noteworthy))
	{
		maps\_hms_utility::printlnscreenandconsole("Drone destroyed: " + self.script_noteworthy);
		return;
	}

	maps\_hms_utility::printlnscreenandconsole("Drone destroyed!");
}

//Function Number: 121
monitorphysicschairs()
{
	var_00 = getentarray("SniperPhysicsDamageTrigger","targetname");
	common_scripts\utility::array_thread(var_00,::snipershotphysicsimpulse);
}

//Function Number: 122
snipershotphysicsimpulse()
{
	level endon("ScrambleSniperKilled");
	for(;;)
	{
		self waittill("trigger");
		physicsexplosionsphere(self.origin,100,10,0.5);
		wait(1);
	}
}

//Function Number: 123
scrambleplayergapjump()
{
	var_00 = level.player;
	var_01 = level.allies["Ilona"];
	var_02 = getent("TriggerScrambleGapJumpStart","targetname");
	var_03 = getent("ScramblePlayerGapJumpRef1","targetname");
	var_04 = anglestoforward(var_03.angles);
	thread scrambleplayerjumpwatcher(0);
	waitforscramblejump(var_02,var_04,1);
	level notify("ScrambleJumpWatcherStop");
	common_scripts\utility::flag_set("FlagScrambleGapJumpStarted");
	soundscripts\_snd::snd_message("gap_jump_squib_occlusion");
	thread scramblegapjumpslomo();
	thread snipershootgapjump();
	thread scramblecivhotel();
	thread scramblecivhothall();
	var_05 = "parkour_jump";
	var_06 = common_scripts\utility::getstruct("ScrambleGapJumpOrg","targetname");
	var_07 = common_scripts\utility::getstruct("ScrambleGapJumpIlonaOrg","targetname");
	var_08 = maps\_utility::spawn_anim_model("player_scramble_rig",var_06.origin,var_06.angles);
	var_08 hide();
	var_06 maps\_anim::anim_first_frame_solo(var_08,var_05);
	level.player maps\_shg_utility::setup_player_for_scene();
	thread maps\greece_sniper_scramble_fx::windowgapjumpglassshatter();
	soundscripts\_snd::snd_message("hotel_crowd_panic_walla");
	thread scrambleilanagapjump(var_07,var_05);
	level.player playerlinktoblend(var_08,"tag_player",0.2);
	wait(0.2);
	thread scramblehideplayergapjump(var_08);
	if(level.currentgen)
	{
		thread tff_trans_middle_to_outro();
		thread maps\_utility::tff_sync(4);
	}

	var_06 maps\_anim::anim_single_solo(var_08,var_05);
	level.player unlink();
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	var_08 delete();
	thread scramblecivpool();
	thread maps\_utility::autosave_by_name("scramble_gap_jump_end");
	common_scripts\utility::flag_set("FlagScrambleGapJumpCompleted");
	common_scripts\utility::flag_set("FlagScrambleStartHotel");
	common_scripts\utility::flag_set("init_sniper_scramble_hotel_lighting");
}

//Function Number: 124
scramblehideplayergapjump(param_00)
{
	wait(0.1);
	param_00 show();
}

//Function Number: 125
tff_trans_middle_to_outro()
{
	level notify("tff_pre_middle_to_outro");
	unloadtransient("greece_middle_tr");
	loadtransient("greece_outro_tr");
	while(!istransientloaded("greece_outro_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_middle_to_outro");
}

//Function Number: 126
scrambleilanagapjump(param_00,param_01)
{
	var_02 = level.allies["Ilona"];
	param_00 maps\_anim::anim_single_solo_run(var_02,param_01);
	common_scripts\utility::flag_set("FlagScrambleIlanaGapJumpCompleted");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AllyStartScrambleHotelCover");
	wait(1);
	level.sniperpos.bsniperenabled = 0;
}

//Function Number: 127
scrambleplayerhoteljump()
{
	common_scripts\utility::flag_wait("FlagScrambleCheckPlayerDecision");
	var_00 = level.player;
	var_01 = getent("TriggerScrambleHotelJumpStart","targetname");
	var_02 = getent("ScramblePlayerHotelJumpRef","targetname");
	var_03 = anglestoforward(var_02.angles);
	thread scrambleplayerjumpwatcher(0);
	waitforscramblejump(var_01,var_03,0);
	level notify("ScrambleJumpWatcherStop");
	common_scripts\utility::flag_set("FlagScrambleHotelJumpStarted");
	soundscripts\_snd::snd_message("scramble_amb_siren_loop");
	soundscripts\_snd::snd_message("pool_civ_01_cower_setup");
	var_04 = getent("ScrambleHotelWindowClip","targetname");
	var_04 delete();
	var_05 = "hotel_jump";
	var_06 = getent("TriggerScrambleHotelJumpStartL","targetname");
	if(level.player istouching(var_06))
	{
		var_07 = common_scripts\utility::getstruct("ScrambleHotelJumpOrgL","targetname");
		var_08 = 1;
	}
	else
	{
		var_07 = common_scripts\utility::getstruct("ScrambleHotelJumpOrgR","targetname");
		var_08 = 0;
	}

	thread snipershoothoteljump(var_08);
	var_09 = maps\_utility::spawn_anim_model("player_scramble_rig",var_07.origin,var_07.angles);
	var_09 hide();
	var_07 maps\_anim::anim_first_frame_solo(var_09,var_05);
	level.player maps\_shg_utility::setup_player_for_scene();
	thread maps\greece_sniper_scramble_fx::windowhoteljumpglassshatter(0.1);
	level.player disableweapons();
	level.player playerlinktoblend(var_09,"tag_player",0.2);
	wait(0.2);
	var_09 show();
	var_07 maps\_anim::anim_single_solo(var_09,var_05);
	level.player unlink();
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	var_09 delete();
	level.player allowsprint(1);
	level.player allowdodge(1);
	thread maps\_utility::autosave_by_name("scramble_hotel_jump_end");
	common_scripts\utility::flag_set("FlagScrambleHotelJumpCompleted");
	thread scrambleplayercafejump();
}

//Function Number: 128
scrambleplayercafejump()
{
	level endon("ScramblePlayerLeftIlana");
	common_scripts\utility::flag_wait("FlagScrambleHotelIlanaReachedGoal");
	var_00 = level.player;
	var_01 = getent("TriggerScrambleCafeJumpStart","targetname");
	var_02 = getent("ScramblePlayerCafeJumpRef","targetname");
	var_03 = getent("TriggerScrambleCafeJumpStartL","targetname");
	var_04 = getent("TriggerScrambleCafeJumpStartR","targetname");
	var_05 = anglestoforward(var_02.angles);
	thread scrambleplayerjumpwatcher(0);
	waitforscramblejump(var_01,var_05,0);
	level notify("ScrambleJumpWatcherStop");
	common_scripts\utility::flag_set("FlagScrambleCafeJumpStarted");
	var_06 = getent("ScrambleCafeWindowClip","targetname");
	var_06 delete();
	var_07 = "cafe_jump";
	if(level.player istouching(var_03))
	{
		var_08 = common_scripts\utility::getstruct("ScrambleCafeJumpOrgL","targetname");
		var_09 = 1;
	}
	else
	{
		var_08 = common_scripts\utility::getstruct("ScrambleCafeJumpOrgR","targetname");
		var_09 = 0;
	}

	thread snipershootcafejump(var_09);
	var_0A = maps\_utility::spawn_anim_model("player_scramble_rig",var_08.origin,var_08.angles);
	var_0A hide();
	var_08 maps\_anim::anim_first_frame_solo(var_0A,var_07);
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player playerlinktoblend(var_0A,"tag_player",0.2);
	wait(0.2);
	var_0A show();
	var_08 maps\_anim::anim_single_solo(var_0A,var_07);
	level.player unlink();
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	var_0A delete();
	thread maps\_utility::autosave_by_name("scramble_cafe_jump_end");
	common_scripts\utility::flag_set("FlagScrambleCafeJumpCompleted");
}

//Function Number: 129
scrambleplayerjumpwatcher(param_00)
{
	level endon("ScrambleJumpWatcherStop");
	common_scripts\utility::flag_clear("FlagScramblePlayerJumping");
	if(param_00)
	{
		notifyoncommand("playerjump","+usereload");
		notifyoncommand("playerjump","+gostand");
		notifyoncommand("playerjump","+moveup");
	}
	else
	{
		notifyoncommand("playerjump","+gostand");
		notifyoncommand("playerjump","+moveup");
	}

	for(;;)
	{
		level.player waittill("playerjump");
		common_scripts\utility::flag_set("FlagScramblePlayerJumping");
		wait(0.1);
		while(!level.player isonground())
		{
			wait(0.05);
		}

		common_scripts\utility::flag_clear("FlagScramblePlayerJumping");
	}
}

//Function Number: 130
waitforscramblejump(param_00,param_01,param_02)
{
	for(;;)
	{
		wait(0.05);
		if(level.player isreloading())
		{
			continue;
		}

		if(isdefined(level.player.using_ammo_cache) && level.player.using_ammo_cache == 1)
		{
			continue;
		}

		if(level.player istouching(param_00) && common_scripts\utility::flag("FlagScramblePlayerJumping") && scrambleplayerleaps(param_00,param_01,0.6,param_02))
		{
			break;
		}
	}
}

//Function Number: 131
scrambleplayerleaps(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.965;
	}

	if(level.player getstance() != "stand")
	{
		return 0;
	}

	var_04 = level.player getplayerangles() * (1,1,0);
	var_05 = anglestoforward(var_04);
	param_01 = vectornormalize(param_01 * (1,1,0));
	if(vectordot(var_05,param_01) < param_02)
	{
		return 0;
	}

	if(param_03)
	{
		var_06 = maps\greece_code::calculateleftstickdeadzone() * (1,-1,0);
		var_07 = transformmove((0,0,0),var_04,(0,0,0),(0,0,0),var_06,(0,0,0));
		if(vectordot(var_07["origin"],param_01) < 0.2)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 132
scramblecivsetup()
{
	self pushplayer(0);
	maps\_utility::set_ignoreall(1);
	thread civsniperdamagemonitor();
}

//Function Number: 133
scramblecivpatio()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivPatioCower",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivPatioCower",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_01)
	{
		var_03 thread scrambleciviliancower();
		if(var_03.script_noteworthy == "PatioCower01")
		{
			soundscripts\_snd::snd_message("patio_civ_01_cower",var_03);
		}
	}

	maps\_utility::array_spawn_function_targetname("ScrambleCivPatioFlee",::scramblecivsetup);
	var_05 = maps\_utility::array_spawn_targetname("ScrambleCivPatioFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_05);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_05)
	{
		if(var_03.script_noteworthy == "PatioFlee01")
		{
			var_07 = "FlagScrambleIlanaBeginOpenIntroDoor";
		}
		else if(var_03.script_noteworthy == "PatioFlee03")
		{
			var_07 = "FlagScrambleIlanaEndOpenIntroDoor";
		}
		else
		{
			var_07 = "FlagScrambleGapJumpStarted";
		}

		if(var_03.script_noteworthy == "PatioFlee01")
		{
			var_08 = 1;
			var_09 = 1;
			var_0A = 1;
			var_03 thread maps\_utility::magic_bullet_shield();
		}
		else
		{
			var_0A = 0;
			var_08 = 0;
			var_09 = 0;
		}

		if(var_03.script_noteworthy == "PatioFlee01")
		{
			soundscripts\_snd::snd_message("patio_intro_civ_death",var_03);
		}

		if(var_03.script_noteworthy == "PatioFlee03")
		{
			soundscripts\_snd::snd_message("patio_civ_03_scream",var_03);
		}

		var_03 thread scramblecivilianflee(var_07,var_09,0,var_08,var_0A);
	}

	common_scripts\utility::flag_wait("FlagScrambleGapJumpCompleted");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 134
scramblecivhotel()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivHotelFlee",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivHotelFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_01)
	{
		var_04 = undefined;
		if(var_03.script_noteworthy != "HotelFlee01")
		{
			var_04 = "FlagScrambleBeginHothall";
		}

		if(var_03.script_noteworthy == "HotelFlee02")
		{
			soundscripts\_snd::snd_message("hotel_civ_04_death",var_03);
		}

		var_03 thread scramblecivilianflee(var_04,0);
	}

	common_scripts\utility::flag_wait("FlagScrambleHotelJumpCompleted");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 135
scramblecivhothall()
{
	var_00 = getent("hothall_org","targetname");
	var_01 = maps\_utility::spawn_targetname("hothall_male01","targetname");
	var_01.animname = "hothall_male01";
	var_02 = maps\_utility::spawn_targetname("hothall_male02","targetname");
	var_02.animname = "hothall_male02";
	var_03 = maps\_utility::spawn_targetname("hothall_female01","targetname");
	var_03.animname = "hothall_female01";
	var_04 = maps\_utility::spawn_targetname("hothall_female02","targetname");
	var_04.animname = "hothall_female02";
	var_05 = [var_01,var_02,var_03,var_04];
	foreach(var_07 in var_05)
	{
		var_07.ignoresonicaoe = 1;
		var_07 thread scramblecivsetup();
	}

	var_01 thread scramblehothallciv(var_00,1);
	var_02 thread scramblehothallciv(var_00,0);
	var_03 thread scramblehothallciv(var_00,1);
	var_04 thread scramblehothallciv(var_00,0);
	soundscripts\_snd::snd_message("hotel_female_01_hallway",var_03);
	common_scripts\utility::flag_wait("FlagScrambleHotelJumpCompleted");
	var_05 = maps\_utility::array_removedead(var_05);
	maps\_utility::array_delete(var_05);
}

//Function Number: 136
scramblehothallciv(param_00,param_01)
{
	self endon("death");
	param_00 thread maps\_anim::anim_loop_solo(self,"scram_hothall_idle","stop_hothall_idle");
	if(param_01 == 0)
	{
		self.health = 1000000;
	}

	common_scripts\utility::flag_wait("FlagScrambleBeginHothall");
	param_00 notify("stop_hothall_idle");
	param_00 maps\_anim::anim_single_solo(self,"scram_hothall");
	if(param_01 == 1)
	{
		param_00 thread maps\_anim::anim_loop_solo(self,"scram_hothall_idle_end");
		return;
	}

	maps\greece_code::kill_no_react();
}

//Function Number: 137
scramblecivpool()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivPoolCower",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivPoolCower",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_01)
	{
		var_03 thread scrambleciviliancower();
		if(var_03.script_noteworthy == "PoolCower01")
		{
			soundscripts\_snd::snd_message("pool_civ_01_cower",var_03);
		}
	}

	maps\_utility::array_spawn_function_targetname("ScrambleCivPoolFlee",::scramblecivsetup);
	var_05 = maps\_utility::array_spawn_targetname("ScrambleCivPoolFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_05);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_05)
	{
		if(var_03.script_noteworthy == "PoolFlee01" || var_03.script_noteworthy == "PoolFlee02")
		{
			var_07 = "FlagTriggerScramblePlayerNearSecondJump";
		}
		else
		{
			var_07 = "FlagScrambleHotelJumpCompleted";
		}

		var_08 = 0;
		var_03 thread scramblecivilianflee(var_07,var_08,1,0);
	}

	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerCompletedThirdJump");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 138
scramblecivdrones()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivDronesCower",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivDronesCower",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "DronesCower01Org")
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 0;
		}

		var_03 thread scrambleciviliancower(undefined,var_04);
	}

	maps\_utility::array_spawn_function_targetname("ScrambleCivDronesFlee",::scramblecivsetup);
	var_06 = maps\_utility::array_spawn_targetname("ScrambleCivDronesFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_06);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_06)
	{
		if(var_03.script_noteworthy == "DronesFlee06" || var_03.script_noteworthy == "DronesFlee07" || var_03.script_noteworthy == "DronesFlee08" || var_03.script_noteworthy == "DronesFlee09")
		{
			var_08 = 1;
		}
		else
		{
			var_08 = 0;
		}

		if(var_03.script_noteworthy == "DronesFlee02")
		{
			soundscripts\_snd::snd_message("drone_civ_02_flee",var_03);
		}

		var_09 = "FlagScrambleStartDrones";
		var_03 thread scramblecivilianflee(var_09,var_08,0);
	}

	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearWoundedSoldier");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 139
scramblecivrestaurant()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivRestaurantCower",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivRestaurantCower",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_01)
	{
		var_03 thread scrambleciviliancower();
		if(var_03.script_noteworthy == "RestaurantCower03")
		{
			soundscripts\_snd::snd_message("restaurant_civ_03_cower",var_03);
		}
	}

	maps\_utility::array_spawn_function_targetname("ScrambleCivRestaurantFlee",::scramblecivsetup);
	var_05 = maps\_utility::array_spawn_targetname("ScrambleCivRestaurantFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_05);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_05)
	{
		var_03 thread scramblecivilianflee("FlagTriggerScramblePlayerInRestaurant",0,0);
	}

	thread snipershootrestaurantfishtank();
	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerLeavingRestaurant");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 140
scramblecivrestaurantdooropener()
{
	var_00 = common_scripts\utility::getstruct("RestaurantDoorOpenOrg","script_noteworthy");
	maps\_utility::array_spawn_function_targetname("ScrambleCivRestaurantDoorOpener",::scramblecivsetup);
	var_01 = maps\_utility::spawn_targetname("ScrambleCivRestaurantDoorOpener",1);
	var_01 pushplayer(0);
	var_01.animname = "generic";
	var_01.ignoresonicaoe = 1;
	var_01.health = 9999999;
	var_01 thread sniperbloodsprayexitwoundtrace();
	var_02 = getent("ScrambleRestaurantDoors","targetname");
	var_02.animname = "sniper_restaurant_door";
	var_02 maps\_utility::assign_animtree("sniper_restaurant_door");
	var_00 maps\_anim::anim_first_frame_solo(var_02,"RestaurantOpenDoor");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"RestaurantOpenDoor_idle","scramble_open_restaurant");
}

//Function Number: 141
scramblecivfinale()
{
	thread scramblefinalecar();
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleCivFinaleCower",::scramblecivsetup);
	var_01 = maps\_utility::array_spawn_targetname("ScrambleCivFinaleCower",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "FinaleCower04Org" || var_03.script_noteworthy == "FinaleCower05Org")
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 0;
		}

		var_03 thread scrambleciviliancower(undefined,var_04);
		if(var_03.script_noteworthy == "FinaleCower04")
		{
			soundscripts\_snd::snd_message("finale_civ_04_cower",var_03);
		}
	}

	maps\_utility::array_spawn_function_targetname("ScrambleCivFinaleFlee",::scramblecivsetup);
	var_06 = maps\_utility::array_spawn_targetname("ScrambleCivFinaleFlee",1);
	var_00 = maps\_utility::array_merge(var_00,var_06);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_03 in var_06)
	{
		if(var_03.script_noteworthy == "FinaleFlee02")
		{
			var_08 = 1;
		}
		else
		{
			var_08 = 0;
		}

		var_09 = "FlagTriggerScramblePlayerNearStreet";
		var_03 thread scramblecivilianflee(var_09,var_08,0);
	}

	common_scripts\utility::flag_wait("FlagEndingStart");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 142
scramblefinalecar()
{
	level endon("AmbushTimerFreeze");
	var_00 = getent("ScrambleFinaleCar","targetname");
	var_00 thread scramblevehicleexplodeondeath();
	for(;;)
	{
		var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isdefined(var_0A))
		{
			return;
		}

		if(var_0A == "hms_rail_sniper" && isdefined(level.sniperpos))
		{
			var_00 maps\_vehicle::force_kill();
			var_0B = maps\_utility::get_living_ai("FinaleCower07","script_noteworthy");
			if(isdefined(var_0B))
			{
				var_0B maps\greece_code::kill_no_react(0);
				var_0B animscripts\notetracks::notetrackstartragdoll("ragdoll");
			}
		}

		wait 0.05;
	}
}

//Function Number: 143
scrambleciviliancower(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self pushplayer(0);
	self.allowpain = 0;
	self.animname = "generic";
	self.ignoresonicaoe = 1;
	var_02 = self.script_noteworthy + "Org";
	var_03 = common_scripts\utility::getstruct(var_02,"script_noteworthy");
	if(isdefined(var_03.targetname) && var_03.targetname == "DronesCowerCasual")
	{
		thread codescripts\character::setheadmodel("head_f_act_cau_hamilton_base");
		self setmodel("civ_urban_female_body_b_olive");
	}

	if(param_01 == 1)
	{
		thread civkillwhennearplayer(0);
	}

	var_04 = self.script_noteworthy;
	var_05 = var_04 + "_idle";
	var_06 = var_04 + "_end";
	thread maps\greece_code::setragdolldeath(var_06,var_03);
	thread sniperbloodsprayexitwoundtrace();
	var_03 thread maps\_anim::anim_loop_solo(self,var_05,var_06);
	var_07 = var_04 + "_reaction";
	if(isdefined(var_07) && maps\_utility::hasanim(var_07))
	{
		if(isdefined(param_00))
		{
			common_scripts\utility::flag_wait(param_00);
		}
		else
		{
			for(;;)
			{
				if(distancesquared(self.origin,level.player.origin) < 40000)
				{
					break;
				}

				wait(0.1);
			}
		}

		self notify(var_06);
		var_03 notify(var_06);
		var_03 maps\_anim::anim_single_solo(self,var_07);
		var_08 = var_04 + "_newidle";
		if(isdefined(var_08) && maps\_utility::hasanim(var_08))
		{
			var_03 thread maps\_anim::anim_loop_solo(self,var_08,var_06);
			return;
		}

		var_03 thread maps\_anim::anim_loop_solo(self,var_05,var_06);
	}
}

//Function Number: 144
scramblecivilianflee(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self pushplayer(0);
	self.animname = "generic";
	self.ignoresonicaoe = 1;
	self.allowpain = 0;
	var_05 = self.script_noteworthy + "Org";
	var_06 = common_scripts\utility::getstruct(var_05,"script_noteworthy");
	thread sniperbloodsprayexitwoundtrace();
	if(param_03 == 1)
	{
		thread maps\greece_code::setragdolldeath();
	}
	else
	{
		maps\_hms_utility::printlnscreenandconsole("No ragdoll death on " + self.script_noteworthy);
	}

	if(param_02 == 1)
	{
		thread civkillwhennearplayer();
	}

	var_07 = self.script_noteworthy;
	var_08 = var_07 + "_idle";
	var_09 = var_07 + "_end";
	var_0A = var_07 + "_goal";
	var_0B = common_scripts\utility::getstruct(var_0A,"targetname");
	if(isdefined(param_00))
	{
		var_06 thread maps\_anim::anim_loop_solo(self,var_08,var_09);
		common_scripts\utility::flag_wait(param_00);
	}

	if(isdefined(param_04))
	{
		wait(param_04);
	}

	wait 0.05;
	if(isdefined(self))
	{
		self notify(var_09);
		var_06 notify(var_09);
		maps\_utility::anim_stopanimscripted();
		var_0C = var_07 + "_reaction";
		if(isdefined(var_0B))
		{
			var_06 maps\_anim::anim_single_solo_run(self,var_0C);
		}
		else
		{
			var_06 maps\_anim::anim_single_solo(self,var_0C);
		}
	}

	if(isdefined(self))
	{
		var_0D = var_07 + "_newidle";
		if(param_01 == 1)
		{
			if(isdefined(self.magic_bullet_shield))
			{
				maps\_utility::stop_magic_bullet_shield();
			}

			self.allowdeath = 1;
			self.a.nodeath = 1;
			self kill();
			return;
		}

		if(isdefined(var_0D) && maps\_utility::hasanim(var_0D))
		{
			var_06 thread maps\_anim::anim_loop_solo(self,var_0D,var_09);
			return;
		}

		self.ignoresonicaoe = undefined;
		maps\greece_code::clearragdolldeath();
		if(isdefined(var_0B))
		{
			maps\_utility::set_goal_pos(var_0B.origin);
			return;
		}

		maps\_utility::set_goal_pos(self.origin);
		return;
	}
}

//Function Number: 145
civkillwhennearplayer(param_00)
{
	level endon("ScrambleSniperKilled");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00 == 1)
	{
		self endon("goal");
	}

	for(;;)
	{
		wait(0.05);
		if(isshotdelayed())
		{
			continue;
		}

		var_01 = distancesquared(level.player.origin,self.origin);
		var_02 = randomintrange(20000,40000);
		if(var_01 <= var_02)
		{
			if(isdefined(self.magic_bullet_shield))
			{
				maps\_utility::stop_magic_bullet_shield();
			}

			soundscripts\_snd::snd_message("windmill_sniper_shot_multi",self geteye());
			var_03 = snipertargetgettagpos();
			snipershoot(var_03,1,1);
		}
	}
}

//Function Number: 146
scramblefinaleallies()
{
	var_00 = [];
	maps\_utility::array_spawn_function_targetname("ScrambleFinaleAlly",::maps\_utility::set_ignoreall,1);
	var_00 = maps\_utility::array_spawn_targetname("ScrambleFinaleAlly",1);
	level.sniperalltargets = maps\_utility::array_merge(level.sniperalltargets,var_00);
	foreach(var_02 in var_00)
	{
		var_02.health = 1;
		var_02.allowdeath = 1;
		var_02 maps\_utility::gun_remove();
		var_02 maps\_utility::set_ignoreall(1);
		var_02 maps\_utility::set_ignoreme(1);
		var_02 maps\_utility::set_battlechatter(0);
		var_02 thread maps\greece_code::setragdolldeath();
	}

	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "FinaleAlly01")
		{
			var_02 thread scramblefinalefirstwoundedally();
			var_02 thread sniperbloodsprayexitwoundtrace(1);
			continue;
		}

		if(var_02.script_noteworthy == "FinaleAlly02")
		{
			var_02.name = "Rivers";
			var_02.animname = "Rivers";
			var_02.script_parameters = "Rivers";
		}
		else
		{
			var_02.name = " ";
			var_02.animname = "generic";
		}

		var_02 thread scramblefinaleextrawoundedally();
		var_02 thread sniperbloodsprayexitwoundtrace();
	}

	thread snipershootstingerpot();
	common_scripts\utility::flag_wait("FlagEndingStart");
	var_00 = maps\_utility::array_removedead(var_00);
	maps\_utility::array_notify(var_00,"delete");
	wait(0.05);
	maps\_utility::array_delete(var_00);
}

//Function Number: 147
scramblefinalefirstwoundedally()
{
	var_00 = common_scripts\utility::getstruct("ScrambleIlanaLookAllyOrg","targetname");
	var_01 = "sanchez_wounded_idle";
	self.name = "Torres";
	self.animname = "Torres";
	self.script_parameters = "Torres";
	self.health = 10000;
	self.maxhealth = 10000;
	var_00 thread maps\_anim::anim_loop_solo(self,var_01,"wounded_loop_end");
}

//Function Number: 148
scramblefinaleextrawoundedally()
{
	self endon("death");
	var_00 = self.script_noteworthy + "Org";
	var_01 = common_scripts\utility::getstruct(var_00,"script_noteworthy");
	var_02 = var_01.animation;
	var_01 thread maps\_anim::anim_first_frame_solo(self,var_02);
	var_03 = self.script_noteworthy + "Trig";
	maps\_utility::trigger_wait_targetname(var_03);
	var_01 maps\_anim::anim_single_solo(self,var_02);
	maps\greece_code::kill_no_react(0);
}

//Function Number: 149
monitorplayerfirerpgattower()
{
	var_00 = getent("ScrambleSniperWindow","targetname");
	level endon("ScrambleSniperKilled");
	level.player waittill("missile_fire",var_01,var_02);
	thread firestingerrumble();
	common_scripts\utility::flag_set("FlagScramblePlayerFireMissile");
	thread slowmotiontowerdestruction();
}

//Function Number: 150
firestingerrumble()
{
	level.player playrumbleonentity("artillery_rumble");
	earthquake(0.5,0.3,level.player.origin,100);
}

//Function Number: 151
slowmotiontowerdestruction()
{
	level.sniperpos.bsniperenabled = 0;
	level.player enableinvulnerability();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player allowdodge(0);
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	wait(1.5);
	level.player disableinvulnerability();
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player allowsprint(1);
	level.player allowdodge(1);
}

//Function Number: 152
monitormantlevols()
{
	while(!common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		if(level.player ismantling())
		{
			physicsexplosionsphere(level.player.origin,200,0,0.1);
			glassradiusdamage(level.player.origin,500,1000,100);
			wait(1);
		}

		wait(0.05);
	}
}

//Function Number: 153
monitorlastweapon()
{
	level.player endon("death");
	level endon("missionfailed");
	wait(0.5);
	self.saved_lastweapon = undefined;
	while(!common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		var_00 = maps\_utility::get_storable_current_weapon();
		if(var_00 == "iw5_stingerm7greece_sp")
		{
			common_scripts\utility::flag_set("FlagScramblePlayerHasStinger");
			break;
		}

		if(isdefined(var_00) && var_00 != "none" && var_00 != "c4")
		{
			if(!isdefined(self.saved_lastweapon) || var_00 != self.saved_lastweapon)
			{
				self.saved_lastweapon = var_00;
			}
		}

		wait(0.05);
	}
}

//Function Number: 154
stingerpronestatemonitor()
{
	level.player endon("death");
	level endon("missionfailed");
	while(!common_scripts\utility::flag("FlagScrambleSniperKilled"))
	{
		var_00 = self getcurrentweapon();
		if(var_00 == "iw5_stingerm7greece_sp")
		{
			level.player allowprone(0);
			continue;
		}

		level.player allowprone(1);
		wait(0.05);
	}
}

//Function Number: 155
sniperbloodsprayexitwoundtrace(param_00)
{
	self endon("delete");
	self endon("bloodless");
	var_01 = 1000;
	var_02 = "TAG_WEAPON_CHEST";
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00 == 1)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
	}
	else
	{
		self waittill("death",var_0C,var_0D,var_0C);
	}

	if(!isdefined(var_0C))
	{
		return;
	}

	if(var_0C == "hms_rail_sniper" && isdefined(level.sniperpos))
	{
		var_0E = self gettagorigin(var_02);
		var_0F = level.sniperpos.origin;
		var_10 = vectortoangles(var_0E - var_0F);
		var_11 = var_0E + var_10 * var_01;
		var_12 = bullettrace(var_0E,var_11,0);
		if(isdefined(var_12["position"]))
		{
			var_13 = var_12["position"];
			playfx(common_scripts\utility::getfx("blood_impact_splat"),var_13);
			soundscripts\_snd::snd_message("mhunt_snpr_blood_impact_splat");
		}
	}
}

//Function Number: 156
scramblesetupexittruck()
{
	var_00 = common_scripts\utility::getstruct("ScrambleTruckExitOrg","targetname");
	var_01 = getent("ScrambleExitTruck","targetname");
	var_01 maps\_utility::assign_animtree("exit_truck");
	var_01.animname = "exit_truck";
	var_00 maps\_anim::anim_first_frame_solo(var_01,"move_truck");
}

//Function Number: 157
monitormovetruckinteract()
{
	var_00 = getent("UseTriggerScrambleMoveTruckInteract","targetname");
	var_00 makeusable();
	thread scramblemonitormovetruckhint();
	var_00 maps\_utility::addhinttrigger(&"GREECE_HINT_MOVE_TRUCK",&"GREECE_HINT_MOVE_TRUCK_KB");
	var_00 waittill("trigger",var_01);
	var_00 delete();
	level notify("ScramblePlayerMoveTruck");
	common_scripts\utility::flag_set("FlagScramblePlayerStartMoveTruck");
	thread playermovetruck();
	thread maps\greece_code::sunflareswap("sunflare_dim");
}

//Function Number: 158
scramblemonitormovetruckhint()
{
	var_00 = getent("ScrambleMoveTruckObj","targetname");
	var_01 = maps\_shg_utility::hint_button_position("use",var_00.origin,128);
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 159
playermovetruck()
{
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	var_00 = common_scripts\utility::getstruct("ScramblePlayerExitOrg","targetname");
	soundscripts\_snd::snd_message("finale_street_crowd");
	thread maps\greece_ending::endingburningsniper();
	var_01 = maps\_utility::spawn_anim_model("player_scramble_rig",var_00.origin,var_00.angles);
	var_01 hide();
	var_00 maps\_anim::anim_first_frame_solo(var_01,"move_truck");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	level.player playerlinktoblend(var_01,"tag_player",0.3);
	wait(0.3);
	var_01 show();
	thread ilanamovetruck();
	thread truckmovetruck();
	var_00 maps\_anim::anim_single_solo(var_01,"move_truck");
	level.player unlink();
	level.player thread maps\_shg_utility::setup_player_for_gameplay();
	var_01 delete();
	if(level.currentgen)
	{
		thread closeendinggatestransition();
	}

	thread maps\_utility::autosave_by_name("scramble_move_truck_end");
	common_scripts\utility::flag_set("FlagScramblePlayerEndMoveTruck");
}

//Function Number: 160
truckmovetruck()
{
	var_00 = common_scripts\utility::getstruct("ScrambleTruckExitOrg","targetname");
	var_01 = getent("ScrambleExitTruck","targetname");
	var_02 = getent("ScrambleExitCarClip","targetname");
	thread maps\greece_sniper_scramble_fx::movetrucktiresmokefx();
	var_02 delete();
	var_00 maps\_anim::anim_single_solo(var_01,"move_truck");
}

//Function Number: 161
gondolaanimation()
{
	var_00 = getent("gondolaOrg","targetname");
	var_01 = maps\_utility::spawn_anim_model("gondola_01");
	var_02 = maps\_utility::spawn_anim_model("gondola_02");
	var_03 = maps\_utility::spawn_anim_model("gondola_03");
	var_04 = maps\_utility::spawn_anim_model("gondola_04");
	var_05 = [var_01,var_02,var_03,var_04];
	wait(2);
	var_00 thread maps\_anim::anim_loop(var_05,"gondola_loop","stop_gondolas");
	soundscripts\_snd::snd_message("gondola_movement_loops",var_05);
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	level notify("stop_gondola_audio");
	var_00 notify("stop_gondolas");
	maps\_utility::array_delete(var_05);
}

//Function Number: 162
pitbulldestroyedanimation()
{
	var_00 = getent("pitbull_veh","targetname");
	var_00.animname = "pitbull_veh";
	var_00 maps\_utility::assign_animtree("pitbull_veh");
	var_00 maps\_anim::anim_loop_solo(var_00,"pitbull_destroyed");
}

//Function Number: 163
scrambledestroycafewall()
{
	var_00 = getentarray("cafe_wall_clean","targetname");
	var_01 = getentarray("cafe_wall_destroyed","targetname");
	if(level.nextgen)
	{
		foreach(var_03 in var_01)
		{
			var_03 hide();
		}
	}

	common_scripts\utility::flag_wait("FlagTriggerScramblePlayerNearThirdJump");
	thread snipershootcafewall();
	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	foreach(var_03 in var_00)
	{
		var_03 delete();
	}
}

//Function Number: 164
initsniperscramblesuppressionfeedback()
{
	if(isdefined(self.hud_damagefeedback))
	{
		self.saved_hud_damagefeedback = self.hud_damagefeedback;
	}

	self.hud_damagefeedback = newclienthudelem(self);
	self.hud_damagefeedback.horzalign = "center";
	self.hud_damagefeedback.vertalign = "middle";
	self.hud_damagefeedback.x = -12;
	self.hud_damagefeedback.y = -12;
	self.hud_damagefeedback.alpha = 0;
	self.hud_damagefeedback.archived = 1;
	self.hud_damagefeedback setshader("damage_feedback",24,48);
	level waittill("ScrambleSniperKilled");
	if(isdefined(self.saved_hud_damagefeedback))
	{
		self.hud_damagefeedback destroy();
		self.hud_damagefeedback = self.saved_hud_damagefeedback;
	}
}

//Function Number: 165
updatesuppressionfeedback()
{
	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeovertime(1);
	self.hud_damagefeedback.alpha = 0;
	soundscripts\_snd::snd_message("sniper_suppression_hit_alert");
}

//Function Number: 166
monitorsnipertowersuppressiondamage()
{
	level endon("ScrambleSniperKilled");
	var_00 = getent("ScrambleSniperWindow","targetname");
	while(isdefined(var_00))
	{
		var_00 waittill("bullethit",var_01);
		if(isdefined(var_01))
		{
			if(isplayer(var_01))
			{
				var_01 thread updatesuppressionfeedback();
			}
		}

		wait 0.05;
	}
}

//Function Number: 167
civsniperdamagemonitor()
{
	self endon("delete");
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_02) && var_02 == "hms_rail_sniper")
	{
		var_03 = self gettagorigin("J_Spine4");
		var_04 = createsniperimpulse(var_03);
		self.a.nodeath = 1;
		animscripts\notetracks::notetrackstartragdoll("ragdoll");
		self stopanimscripted();
		wait(0.1);
		physicsexplosionsphere(var_04,32,0,5);
	}
}

//Function Number: 168
createsniperimpulse(param_00)
{
	var_01 = 128;
	var_02 = level.sniperpos.origin - param_00 * (1,1,0);
	var_02 = vectornormalize(var_02);
	var_03 = param_00 + var_02 * 16;
	if(level.sniper_scramble_data.draw_debug == 1)
	{
		thread maps\_utility::draw_circle_for_time(var_03,var_01,1,0,0,5);
	}

	return var_03;
}

//Function Number: 169
snipertargetgettagpos()
{
	var_00 = undefined;
	if(common_scripts\utility::cointoss())
	{
		var_00 = self gettagorigin("TAG_EYE");
	}
	else
	{
		var_00 = self gettagorigin("J_Spine4");
	}

	return var_00;
}

//Function Number: 170
closeendinggatestransition()
{
	maps\_utility::trigger_wait_targetname("close_gate_before_hades_fight");
	thread closeendinggates();
	thread scramblesetupexittruck();
	level notify("tff_pre_outro_to_hades_fight");
	unloadtransient("greece_outro_tr");
	loadtransient("greece_hades_fight_tr");
	while(!istransientloaded("greece_hades_fight_tr"))
	{
		wait(0.05);
	}

	level notify("tff_post_outro_to_hades_fight");
}

//Function Number: 171
closeendinggates()
{
	var_00 = getent("left_gate_to_close","targetname");
	var_01 = getent("right_gate_to_close","targetname");
	var_02 = getent("block_alley_gate","targetname");
	var_02 moveto((var_02.origin[0],var_02.origin[1],var_02.origin[2] + 104),0.1);
	var_00 rotateyaw(-95,0.6);
	var_01 rotateyaw(110,0.4);
}

//Function Number: 172
scramblefiredamagemonitor()
{
	var_00 = getent("ScrambleTruckFire","targetname");
	thread scrambletruckfiredamagevol(var_00,"AmbushTimerFreeze");
	var_01 = getent("ScrambleTruckFireA","targetname");
	thread scrambletruckfiredamagevol(var_01,"ScramblePlayerMoveTruck");
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	var_02 = getent("ScrambleTruckFireB","targetname");
	thread scrambletruckfiredamagevol(var_02,"AmbushTimerFreeze");
}

//Function Number: 173
scrambletruckfiredamagevol(param_00,param_01)
{
	level endon(param_01);
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		var_02 dodamage(5,param_00.origin,param_00,param_00,"MOD_CRUSH");
		wait(0.1);
	}
}

//Function Number: 174
scramblerestaurantexitclip(param_00)
{
	var_01 = getent("ScrambleRestaurantExitClipVol","targetname");
	if(param_00 == 1)
	{
		var_02 = 128;
	}
	else
	{
		var_02 = -128;
	}

	var_03 = var_01.origin;
	var_04 = var_03 + (-10,0,var_02);
	var_01 moveto(var_04,0.1);
}

//Function Number: 175
scramblevisitorcentergateopen()
{
	var_00 = getent("AlleysVisitorCenterGate","targetname");
	var_00.animname = "visitorgate";
	var_00 maps\_utility::assign_animtree("visitorgate");
	var_01 = getent("AlleysVisitorCenterGateCollision","targetname");
	var_01 linkto(var_00,"jo_gate_door");
	var_02 = getent("AlleysVisitorCenterGateUseTrigger","targetname");
	var_02 makeunusable();
	var_03 = common_scripts\utility::getstruct("AlleysVisitorCenterGateRipOrg","targetname");
	var_04 = "alleys_gate_rip";
	var_03 maps\_anim::anim_last_frame_solo(var_00,var_04);
	var_01 connectpaths();
}

//Function Number: 176
torresblood()
{
	var_00 = getent("TorresBlood","targetname");
	var_00 hide();
	common_scripts\utility::flag_wait("FlagScrambleWoundedSoldierKilled");
	var_00 show();
	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	var_00 delete();
}

//Function Number: 177
destroydroppedgun()
{
	level endon("ScrambleSniperKilled");
	for(;;)
	{
		level.player waittill("pickup",var_00,var_01);
		if(level.player hasweapon("iw5_stingerm7greece_sp"))
		{
			if(isdefined(var_01))
			{
				var_01 delete();
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 178
scramblevehicleexplodeondeath()
{
	level endon("AmbushTimerFreeze");
	self waittill("death");
	radiusdamage(self.origin,200,100,10);
	physicsexplosionsphere(self.origin,300,100,1.5);
	earthquake(0.5,0.3,self.origin,600);
}
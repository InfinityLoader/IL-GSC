/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_alleys.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 88
 * Decompile Time: 1333 ms
 * Timestamp: 4/22/2024 2:30:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	alleysprecache();
	alleysflaginit();
	alleysglobalvars();
	alleysglobalsetup();
	maps\greece_alleys_anim::main();
	maps\greece_alleys_vo::main();
	maps\_drone_civilian::init();
}

//Function Number: 2
alleysprecache()
{
	precachemodel("viewhands_atlas_military");
	precachemodel("vb_civilian_mitchell");
	precachemodel("viewbody_atlas_military");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacheitem("iw5_kf5_sp");
	precacheitem("iw5_kf5_sp_opticsthermal");
	precacheitem("iw5_maul_sp");
	precacheitem("iw5_maul_sp_opticsreddot");
	precacheitem("iw5_ak12_sp");
	precacheitem("iw5_ak12_sp_opticstargetenhancer");
	precacheitem("iw5_hbra3_sp");
	precacheitem("iw5_hbra3_sp_opticsacog2");
	precacheitem("iw5_mahemstraight_sp");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp_opticsreddot_silencerpistol");
	precacheitem("iw5_arx160_sp");
	precacherumble("silencer_fire");
	precacheshellshock("greece_drone_slowview");
	precachestring(&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	precachestring(&"GREECE_OBJ_ENDING_HADESVEHICLE");
	precachestring(&"GREECE_OBJ_INTERCEPT_HADES");
	precachestring(&"GREECE_ALLEYS_GATERIP_PROMPT");
	precachestring(&"GREECE_ALLEYS_GATERIP_PROMPT_KB");
	precachemodel("kva_heavy_head");
	precachemodel("kva_heavy_body");
	precacheitem("iw5_maul_sp");
	maps\_hms_door_interact::precachedooranimations();
}

//Function Number: 3
alleysflaginit()
{
	common_scripts\utility::flag_init("FlagSetObjRooftops");
	common_scripts\utility::flag_init("FlagSafehouseGapJumpCompleted");
	common_scripts\utility::flag_init("FlagSafehouseExitGateOpen");
	common_scripts\utility::flag_init("FlagDeleteAlleyCivilians");
	common_scripts\utility::flag_init("FlagStartMantoss");
	common_scripts\utility::flag_init("FlagTrans2AlleysAllExecutionersDead");
	common_scripts\utility::flag_init("Trans2AlleysSquadADead");
	common_scripts\utility::flag_init("FlagAlleysDeleteAI");
	common_scripts\utility::flag_init("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_init("FlagAlleysFinalBldgClear");
	common_scripts\utility::flag_init("FlagSniperScrambleStart");
	common_scripts\utility::flag_init("FlagAlleysPipComplete");
	common_scripts\utility::flag_init("AlleysVisitorGateIsOpen");
	common_scripts\utility::flag_init("AlleysGateRipStarted");
	common_scripts\utility::flag_init("FlagAlleysIlanaReadyToExit");
	common_scripts\utility::flag_init("FlagAlleysEnemySpawnsVO");
	common_scripts\utility::flag_init("FlagAlleysIlanaMoveToExit");
	common_scripts\utility::flag_init("FlagAlleysAllEnemiesDead");
}

//Function Number: 4
alleysglobalvars()
{
	level.dialogtable = "sp/greece_dialog.csv";
}

//Function Number: 5
alleysglobalsetup()
{
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	thread trans2alleysbegin();
	thread alleysbegin();
}

//Function Number: 6
alleysstartpoints()
{
	maps\_utility::add_start("start_alleys_transition",::initalleystransition);
	maps\_utility::add_start("start_alleys",::initalleys);
	maps\_utility::add_start("start_alleys_art",::initalleysart);
	maps\_utility::add_start("start_alleys_end",::initalleysend);
	maps\greece_starts::add_greece_starts("alley");
}

//Function Number: 7
initalleystransition()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartAlleysTransition","targetname"));
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

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartAlleysTransition",1,1,"IlanaAlleysTransition");
	common_scripts\utility::flag_set("FlagAlleysTransitionStart");
	common_scripts\utility::flag_set("init_alleys_transition_start_lighting");
	thread maps\greece_safehouse::safehousetranstoalleygatesetup();
	soundscripts\_snd::snd_message("start_alleys_transition_checkpoint");
	common_scripts\utility::flag_set("FlagKickSafehouseExitGate");
}

//Function Number: 8
initalleys()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartAlleys","targetname"));
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

	maps\_hms_utility::spawnandinitnamedally("Ilona","AllyStartAlleys",1,1,"IlanaAlleys");
	thread ilanaalleybehavior();
	soundscripts\_snd::snd_message("start_alleys_checkpoint");
	common_scripts\utility::flag_set("FlagAlleysStart");
	common_scripts\utility::flag_set("init_alleys_lighting");
}

//Function Number: 9
initalleysart()
{
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartAlleysArt","targetname"));
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

	soundscripts\_snd::snd_message("start_alleys_checkpoint");
	common_scripts\utility::flag_set("FlagAlleysArtStart");
	common_scripts\utility::flag_set("init_alleys_lighting");
}

//Function Number: 10
initalleysend()
{
	var_00 = common_scripts\utility::getstructarray("PlayerStartAlleysEnd","targetname");
	var_01 = common_scripts\utility::random(var_00);
	maps\_utility::teleport_player(var_01);
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

	maps\_hms_utility::spawnandinitnamedally("Ilona",var_01.target,1,1,"IlanaAlleys");
	thread ilanaalleybehavior();
	soundscripts\_snd::snd_message("start_alleys_checkpoint");
	common_scripts\utility::flag_set("FlagAlleysEndStart");
}

//Function Number: 11
trans2alleysobjectivesetup()
{
	waittillframeend;
	thread objtransitiontoalleys();
	alleyssetcompletedobjflags();
}

//Function Number: 12
alleysobjectivesetup()
{
	waittillframeend;
	alleyssetcompletedobjflags();
}

//Function Number: 13
alleyssetcompletedobjflags()
{
	var_00 = level.start_point;
	if(!common_scripts\utility::string_starts_with(var_00,"start_alleys"))
	{
		return;
	}

	if(var_00 == "start_alleys_transition")
	{
		return;
	}

	if(var_00 == "start_alleys")
	{
		common_scripts\utility::flag_set("FlagAlleysTransitionStart");
		common_scripts\utility::flag_set("FlagTrans2AlleysAllExecutionersDead");
		common_scripts\utility::flag_set("ObjTriggerFlagTransitionToAlleys");
		return;
	}

	if(var_00 == "start_alleys_end")
	{
		common_scripts\utility::flag_set("FlagAlleysTransitionStart");
		common_scripts\utility::flag_set("ObjTriggerFlagTransitionToAlleys");
	}
}

//Function Number: 14
objtransitiontoalleys()
{
	common_scripts\utility::flag_wait("FlagAlleysTransitionStart");
	objective_add(maps\_utility::obj("InterceptHades"),"active",&"GREECE_OBJ_INTERCEPT_HADES");
	objective_onentity(maps\_utility::obj("InterceptHades"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	objective_current(maps\_utility::obj("InterceptHades"));
	common_scripts\utility::flag_wait("ObjTriggerFlagTransitionToAlleys");
	var_00 = getent("AlleysVisitorCenterGateObj","targetname");
	objective_position(maps\_utility::obj("InterceptHades"),var_00.origin);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
	common_scripts\utility::flag_set("FlagAlleysStart");
	level waittill("AlleysAllEnemiesDead");
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_ENDING_HADESVEHICLE");
	common_scripts\utility::flag_wait("AlleysGateRipStarted");
	var_01 = getent("ObjMarkerRooftopsStart","targetname");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),"");
	common_scripts\utility::flag_wait("AlleysVisitorGateIsOpen");
	objective_onentity(maps\_utility::obj("InterceptHades"),level.allies["Ilona"]);
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades"),&"GREECE_OBJ_SAFEHOUSE_FOLLOW");
	common_scripts\utility::flag_wait("FlagTriggerSniperScrambleStart");
	objective_position(maps\_utility::obj("InterceptHades"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("InterceptHades")," ");
}

//Function Number: 15
trans2alleysbegin()
{
	common_scripts\utility::flag_wait("FlagAlleysTransitionStart");
	trans2alleysobjectivesetup();
	thread trans2alleyscivilians();
	thread trans2alleysilanagatebash();
	thread alleysallymovement();
	thread trans2alleyscombat();
}

//Function Number: 16
alleysbegin()
{
	common_scripts\utility::flag_wait_any("FlagAlleysStart","FlagAlleysArtStart","FlagAlleysEndStart");
	alleysobjectivesetup();
	thread alleysspawnrpgenemies();
	thread alleyscombat();
	thread alleysvisitorcentergate();
	thread alleysvideolog();
	thread alleysvehiclemonitor();
	if(!isdefined(level.map_without_loadout) || level.map_without_loadout == 0)
	{
		thread maps\greece_code::blimp_animation("blimpOrg","market_intro_blimp");
	}
}

//Function Number: 17
monitormantlevols()
{
	while(!common_scripts\utility::flag("FlagSniperScrambleStart"))
	{
		if(level.player ismantling())
		{
			glassradiusdamage(level.player.origin,32,1000,100);
			wait(1);
		}

		wait(0.05);
	}
}

//Function Number: 18
alleysallymovement()
{
	common_scripts\utility::flag_wait("FlagSafehouseExitGateOpen");
	thread ilanaalleytransbehavior();
}

//Function Number: 19
trans2alleysilanagatebash()
{
	var_00 = getent("alley_gate_collision","targetname");
	var_01 = common_scripts\utility::getstruct("gateOrg","targetname");
	var_02 = getent("greece_alley_gate","targetname");
	var_02 maps\_utility::assign_animtree("alley_gate");
	var_02.animname = "alley_gate";
	var_03 = level.allies["Ilona"];
	var_03.animname = "Ilona";
	common_scripts\utility::flag_wait("FlagKickSafehouseExitGate");
	var_01 maps\_anim::anim_reach_solo(var_03,"safehouse_gate_bash");
	var_01 thread maps\_anim::anim_single_solo_run(var_03,"safehouse_gate_bash");
	level waittill("GateAnimStart");
	thread trans2alleysunblockplayer();
	var_01 thread maps\_anim::anim_single_solo(var_02,"safehouse_gate_bash");
	var_00 movez(-128,0.1);
	var_00 connectpaths();
	common_scripts\utility::flag_set("FlagSafehouseExitGateOpen");
	maps\greece_safehouse_fx::safehousegatebashfx();
	soundscripts\_snd::snd_music_message("start_safehouse_gate_bash");
	soundscripts\_snd::snd_message("start_trans_to_alleys_panic");
	if(level.currentgen)
	{
		thread trans2alleysslowplayer();
	}
}

//Function Number: 20
trans2alleysunblockplayer()
{
	var_00 = getent("alley_gate_collision_player","targetname");
	wait(1);
	if(level.currentgen)
	{
		wait(1);
	}

	var_00 movez(-128,0.1);
	var_00 connectpaths();
}

//Function Number: 21
trans2alleysslowplayer()
{
	level.player allowsprint(0);
	level.player allowdodge(0);
	common_scripts\utility::flag_wait("FlagTrigTrans2AlleyIlanaAdvance");
	level.player allowsprint(1);
	level.player allowdodge(1);
}

//Function Number: 22
ilanaalleytransbehavior()
{
	var_00 = maps\_hms_utility::getnamedally("Ilona");
	var_00 endon("ContinueToAlleys");
	var_01 = getnode("Trans2AlleysStartNode","targetname");
	var_02 = getnode("AlleyTransCover1","targetname");
	var_00 maps\_utility::set_run_anim("trans_alley_sprint_wpn_ilana",0);
	var_00 maps\_hms_ai_utility::gototogoal(var_02,"default");
	var_00 maps\_utility::clear_run_anim();
	common_scripts\utility::flag_wait("FlagTrigTrans2AlleyIlanaAdvance");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AlleyTransCover2");
	if(level.currentgen)
	{
		setculldist(3000);
		var_03 = ["AlleysCannotRetreat"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("FlagTrigAlleysFinalBldgInteriorLastRoom",var_03,18,0);
	}

	common_scripts\utility::flag_wait("FlagTrigTrans2AlleyCivBattle");
	thread maps\_hms_utility::allyredirectgotonode("Ilona","AlleyTransCover3");
	thread ilanaalleybehavior();
}

//Function Number: 23
ilanaalleybehavior()
{
	var_00 = level.start_point;
	if(var_00 != "start_alleys_end")
	{
		thread maps\_hms_utility::allyredirectgotonode("Ilona","AlleyStartCover");
		common_scripts\utility::flag_wait("FlagTrans2AlleysCivCleanup");
	}

	level.player thread maps\_hms_ai_utility::assistplayer();
	var_01 = maps\_hms_utility::getnamedally("Ilona");
	var_01 thread _initalliedaialleycombatbehavior();
	var_01 thread alleyscheckifplayerretreated();
	level waittill("AlleysShotgunnersAllDead");
	common_scripts\utility::flag_wait("FlagTrigAlleysIlanaMoveToCourtyard");
	var_01 maps\_hms_ai_utility::playerleashdisable();
	wait 0.05;
	var_02 = getnode("AlleysIlanaFinalBldgCourtyardNode","targetname");
	var_01 maps\_hms_ai_utility::gototogoal(var_02,"default",1);
	wait 0.05;
	common_scripts\utility::flag_set("FlagAlleysCombatBeginEnemyRetreat");
	while(level.alleysremainingenemies.size > 0)
	{
		level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
		wait(0.1);
	}

	common_scripts\utility::flag_set("FlagAlleysAllEnemiesDead");
	level notify("AlleysAllEnemiesDead");
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgUpperRetreat");
	var_01 maps\_utility::set_goal_radius(64);
	var_03 = getnode("AlleysIlanaFinalBldgStairsNode","targetname");
	var_01 maps\_hms_ai_utility::gototogoal(var_03,"default",1);
	common_scripts\utility::flag_wait("FlagAlleysIlanaMoveToExit");
	var_04 = getnode("AlleysIlanaFinalBldgNearExitNode","targetname");
	var_01 maps\_hms_ai_utility::gototogoal(var_04,"default",1);
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgInteriorNearExit");
	common_scripts\utility::flag_set("FlagAlleysIlanaReadyToExit");
}

//Function Number: 24
alleyscheckifplayerretreated()
{
	var_00 = getent("TrigAlleysPlayerHasRetreated","targetname");
	var_01 = getnode("AlleyTransCover1","targetname");
	thread maps\_hms_ai_utility::playerleashbehavior();
	var_02 = 1;
	while(!common_scripts\utility::flag("FlagAlleysAllEnemiesDead"))
	{
		if(var_02 == 1 && level.player istouching(var_00))
		{
			maps\_hms_ai_utility::playerleashdisable();
			wait 0.05;
			maps\_hms_ai_utility::gototogoal(var_01,"default",1);
			var_02 = 0;
			continue;
		}

		if(var_02 == 0)
		{
			thread maps\_hms_ai_utility::playerleashbehavior();
			var_02 = 1;
		}

		wait(5);
	}

	maps\_hms_ai_utility::playerleashdisable();
}

//Function Number: 25
_initalliedaialleycombatbehavior()
{
	var_00 = self.maxsightdistsqrd;
	self.maxsightdistsqrd = 67108864;
	self.disablebulletwhizbyreaction = 1;
	self.ignoresuppression = 1;
	maps\_utility::disable_surprise();
	var_01 = self.minpaindamage;
	thread maps\_hms_ai_utility::adjustallyaccuracyovertime();
	thread maps\_hms_ai_utility::painmanagement();
	common_scripts\utility::flag_wait_either("FlagSniperScrambleStart","FlagAlleysFinalBldgClear");
	self notify("disable_accuracy_adjust");
	self notify("disable_pain_management");
	self.maxsightdistsqrd = var_00;
	self.disablebulletwhizbyreaction = 0;
	self.ignoresuppression = 0;
	maps\_utility::enable_surprise();
	self.minpaindamage = var_01;
}

//Function Number: 26
trans2alleyscombat()
{
	var_00 = getentarray("Trans2AlleysSquadASpawner","targetname");
	common_scripts\utility::flag_wait_either("FlagTrigTrans2AlleysCombat","FlagTrans2AlleysAllExecutionersDead");
	var_01 = maps\_utility::array_spawn(var_00);
	foreach(var_03 in var_01)
	{
		level.alleysremainingenemies = common_scripts\utility::add_to_array(level.alleysremainingenemies,var_03);
	}

	maps\_utility::waittill_dead_or_dying(var_01);
	common_scripts\utility::flag_set("Trans2AlleysSquadADead");
}

//Function Number: 27
alleyscombat()
{
	level.alleysremainingenemies = [];
	thread alleyscombatenemyorders();
	thread alleyscombatfrontlinefloodspawns();
	thread alleyscombatfrontlineleftside();
	thread alleyscombatfrontlineleftbackstairs();
	thread alleyscombatfrontlineleftsideinteriorfloor1();
	thread alleyscombatfrontlinerightside();
	thread alleyscombatfrontlinerightbackatm();
	thread alleyscombatmidlineleftside();
	thread alleyscombatmidlinerightside();
	thread alleyscombatmidlinerightsideinterior();
	thread alleyscombatbacklineleftside();
	thread alleyscombatbacklineleftinteriorfloor1();
	thread alleyscombatbacklinerightside();
	thread alleyscombatbacklinerightinteriorfloor1();
	thread alleyscombatbacklinerightinteriorfloor2();
	thread alleyscombatfinalbuilding();
	thread alleyscombatfinalbuildinginterior();
	thread alleyscombatfinalbuildingshotgunners();
	thread alleyscombattriggertoggles();
	thread alleyscombatinteriorfakebulletssetup();
}

//Function Number: 28
alleysvisitorcentergate()
{
	var_00 = getent("AlleysVisitorCenterGate","targetname");
	var_00.animname = "visitorgate";
	var_00 maps\_utility::assign_animtree("visitorgate");
	var_01 = getent("AlleysVisitorCenterGateCollision","targetname");
	var_02 = getent("AlleysVisitorCenterGateUseTrigger","targetname");
	var_02 makeunusable();
	var_03 = common_scripts\utility::getstruct("AlleysVisitorCenterGateRipOrg","targetname");
	var_04 = "alleys_gate_rip";
	wait(0.5);
	var_03 maps\_anim::anim_first_frame_solo(var_00,var_04);
	level waittill("AlleysAllEnemiesDead");
	var_02 makeusable();
	var_02 setcursorhint("HINT_NOICON");
	var_02 maps\_utility::addhinttrigger(&"GREECE_ALLEYS_GATERIP_PROMPT",&"GREECE_ALLEYS_GATERIP_PROMPT_KB");
	thread alleysmonitorgateriphint();
	var_02 waittill("trigger",var_05);
	var_02 delete();
	common_scripts\utility::flag_set("AlleysGateRipStarted");
	level notify("NotifyAlleysGateRipStarted");
	maps\greece_fx::visitorcentergatebashfx();
	thread maps\greece_sniper_scramble::scramblestartdoorinit();
	level.player allowcrouch(0);
	level.player disableweapons();
	var_06 = maps\_utility::spawn_anim_model("player_alleys_rig",level.player.origin,level.player.angles);
	var_06 hide();
	var_07 = [var_06,var_00];
	var_03 maps\_anim::anim_first_frame_solo(var_06,var_04);
	level.player playerlinktoblend(var_06,"tag_player",0.4);
	wait(0.4);
	var_06 show();
	var_03 maps\_anim::anim_single(var_07,var_04);
	level.player unlink();
	var_06 delete();
	level.player enableweapons();
	level.player allowcrouch(1);
	thread maps\_utility::autosave_now();
	common_scripts\utility::flag_set("AlleysVisitorGateIsOpen");
}

//Function Number: 29
alleysgateripunblockpath()
{
	var_00 = getent("AlleysVisitorCenterGateCollision","targetname");
	wait(1);
	var_00 notsolid();
	var_00 connectpaths();
	var_00 delete();
	wait(1);
	common_scripts\utility::flag_set("FlagAlleysIlanaMoveToExit");
}

//Function Number: 30
alleysmonitorgateriphint()
{
	var_00 = getent("AlleysVisitorCenterGateObj","targetname");
	var_01 = maps\_shg_utility::hint_button_position("use",var_00.origin,128);
	common_scripts\utility::flag_wait("AlleysGateRipStarted");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 31
alleyscombatinteriorfakebulletssetup()
{
	var_00 = getentarray("InteriorFakeBulletsTrig","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread alleyscombatinteriorfakebulletsactivate();
	}
}

//Function Number: 32
alleyscombatinteriorfakebulletsactivate()
{
	var_00 = getent(self.target,"targetname");
	var_01 = getentarray(var_00.target,"targetname");
	self waittill("trigger",var_02);
	var_03 = randomintrange(17,23);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = common_scripts\utility::random(var_01);
		magicbullet("iw5_arx160_sp",var_00.origin,var_05.origin);
		wait(randomfloatrange(0.09,0.18));
	}
}

//Function Number: 33
alleyscombattriggertoggles()
{
	common_scripts\utility::flag_wait("FlagTrigAlleysMidLineRightSideSpawns");
	var_00 = getentarray("AlleysFrontLineUniqueTrig","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	common_scripts\utility::flag_wait("FlagTrigAlleysMidLineRetreat");
	var_04 = getentarray("AlleysMidLineUniqueTrig","targetname");
	foreach(var_02 in var_04)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	common_scripts\utility::flag_wait("FlagTriggerAlleysEnemyRPGs");
	var_07 = getentarray("AlleysBackLineUniqueTrig","targetname");
	foreach(var_02 in var_07)
	{
		var_02 common_scripts\utility::trigger_off();
	}
}

//Function Number: 34
alleyscombatenemyorders()
{
	common_scripts\utility::flag_wait_any("FlagTrigAlleysFrontLineBackSpawns","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	var_00 = getent("AlleysFrontLineBadPlaceVolume","targetname");
	badplace_brush("",5,var_00,"axis");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeMidPlusBack");
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait_any("FlagTrigAlleysMidLineCafeSpawns","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeMidPlusBack");
	thread maps\greece_alleys_vo::alleysenemyretreat();
	thread maps\greece_alleys_vo::alleysdialogtimer();
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait_any("FlagTrigAlleysMidLineRetreat","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeBackBothBldgs");
	thread maps\greece_alleys_vo::alleysenemyretreat();
	thread maps\greece_alleys_vo::alleysdialogtimer();
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait_any("FlagTrigAlleysBackLineRetreat","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeFinalBldgBottomFloor");
	thread maps\greece_alleys_vo::alleysenemyretreat();
	thread maps\greece_alleys_vo::alleysdialogtimer();
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	alleyscombatbacklinefloodspawns();
	common_scripts\utility::flag_wait_any("FlagTrigAlleysRPGSpawnedRetreat","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeFinalBldgBottomFloor");
	thread maps\greece_alleys_vo::alleysenemyretreat();
	thread maps\greece_alleys_vo::alleysdialogtimer();
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait_any("FlagTrigAlleysFinalBldgUpperRetreat","FlagAlleysCombatBeginEnemyRetreat","FlagAlleysEndStart");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
	level.alleysremainingenemies alleyscombatenemyretreat("AlleysGoalVolumeFinalBldgStairs");
	thread maps\greece_alleys_vo::alleysenemyretreat();
	thread maps\greece_alleys_vo::alleysdialogtimer();
	wait(0.5);
	common_scripts\utility::flag_clear("FlagAlleysCombatBeginEnemyRetreat");
	common_scripts\utility::flag_clear("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgInteriorFirstRoom");
	common_scripts\utility::flag_set("FlagAlleysDeleteAI");
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgKillAll");
	var_01 = getaiarray("axis");
	thread maps\greece_code::sunflareswap("sunflare");
	common_scripts\utility::flag_set("FlagAlleysFinalBldgClear");
	common_scripts\utility::flag_wait("FlagAlleysIlanaReadyToExit");
	wait 0.05;
	common_scripts\utility::flag_set("FlagSniperScrambleStart");
}

//Function Number: 35
alleyscombatenemycountmonitor(param_00)
{
	while(level.alleysremainingenemies.size > param_00)
	{
		level.alleysremainingenemies = maps\_utility::remove_dead_from_array(level.alleysremainingenemies);
		wait(1);
	}

	common_scripts\utility::flag_set("FlagAlleysCombatBeginEnemyRetreat");
}

//Function Number: 36
alleyscombatenemyretreat(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_02 = [];
	foreach(var_04 in self)
	{
		if(var_04.classname == "actor_enemy_kva_shotgun")
		{
			continue;
		}

		if(maps\_hms_utility::cointossweighted(66))
		{
			var_04 cleargoalvolume();
			var_04 setgoalvolumeauto(var_01);
			continue;
		}

		var_02 = common_scripts\utility::add_to_array(var_02,var_04);
		thread maps\_utility::ai_delete_when_out_of_sight(var_02,100);
	}
}

//Function Number: 37
alleyscombatfrontlinefloodspawns()
{
	var_00 = getentarray("AlleysFrontLineLeftFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgBothFloors");
	var_01 = getentarray("AlleysFrontLineRightUpperFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgTopFloors");
	var_02 = getentarray("AlleysFrontLineRightBottomFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_02,::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgJewelryStore");
	var_03 = maps\_utility::array_merge(var_01,var_02);
	var_04 = maps\_utility::array_merge(var_03,var_00);
	common_scripts\utility::flag_wait("FlagAlleysCombatBeginEnemyRetreat");
	if(!common_scripts\utility::flag("FlagTrigAlleysFrontLineBackSpawns") && !common_scripts\utility::flag("FlagAlleysEndStart"))
	{
		wait(1);
		thread maps\_utility::flood_spawn(var_04);
		thread maps\greece_code::killfloodspawnersonflag(74,"FlagTrigAlleysFrontLineBackSpawns");
	}
}

//Function Number: 38
alleyscombatfrontlineleftside()
{
	var_00 = getentarray("AlleysFrontLineTacSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	var_01 = getentarray("AlleysFrontLineAssSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	var_02 = getentarray("AlleysFrontLineInteriorSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_02,::alleyscombatenemysetup,"AlleysGoalVolumeFrontBothBldgs");
	var_03 = getent("AlleysFrontLineBalconyJumperASpawner","targetname");
	var_03 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor2");
	var_04 = getent("AlleysFrontLineBalconyJumperBSpawner","targetname");
	var_04 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	var_05 = getent("AlleysFrontLineLeftCornerSpawner","targetname");
	var_05 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	var_06 = getent("AlleysFrontLineLeftRooftopSpawner","targetname");
	var_06 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor3");
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineSpawns");
	var_07 = maps\_utility::array_spawn(var_00,0,1);
	var_08 = maps\_utility::array_spawn(var_01,0,1);
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineShowySpawns");
	var_09 = var_03 maps\_utility::spawn_ai();
	var_0A = var_04 maps\_utility::spawn_ai();
	thread alleyscombatenemycountmonitor(5);
	common_scripts\utility::flag_wait_either("FlagTrigAlleysFrontLineLeftCenterStairs","FlagTrigAlleysFrontLineLeftBackStairs");
	var_0B = maps\_utility::array_spawn(var_02,0,1);
}

//Function Number: 39
alleyscombatfrontlineleftbackstairs()
{
	var_00 = getent("AlleysFrontLineLeftBackStairsSpawner","targetname");
	var_00 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLeftBackStairsSpawn");
	var_01 = var_00 maps\_utility::spawn_ai();
}

//Function Number: 40
alleyscombatfrontlineleftsideinteriorfloor1()
{
	var_00 = getentarray("AlleysFrontLineLeftInteriorSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFrontLeftBldgFloor1");
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineLeftInterior");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 41
alleyscombatfrontlinerightside()
{
	var_00 = getentarray("AlleysFrontLineTacSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgJewelryStore");
	var_01 = getentarray("AlleysFrontLineAssSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgTopFloors");
	var_02 = getentarray("AlleysFrontLineInteriorSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_02,::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgFloor2");
	var_03 = getent("AlleysFrontLineBalconyJumperCSpawner","targetname");
	var_03 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgTopFloors");
	var_04 = getent("AlleysFrontLineRightBackStoreSpawner","targetname");
	var_04 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBldgFloor1");
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineSpawns");
	var_05 = maps\_utility::array_spawn(var_00,0,1);
	var_06 = maps\_utility::array_spawn(var_01,0,1);
	var_07 = var_04 maps\_utility::spawn_ai();
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineShowySpawns");
	var_08 = var_03 maps\_utility::spawn_ai();
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineBackSpawns");
	var_09 = maps\_utility::array_spawn(var_02,0,1);
}

//Function Number: 42
alleyscombatfrontlinerightbackatm()
{
	var_00 = getent("AlleysFrontLineRightBackATMSpawner","targetname");
	var_00 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeFrontRightBackATM");
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineRightBackATMSpawn");
	var_01 = var_00 maps\_utility::spawn_ai();
}

//Function Number: 43
alleyscombatmidlineleftside()
{
	var_00 = getentarray("AlleysMidLineTacSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeMarket");
	var_01 = getentarray("AlleysMidLineAssSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeMarket");
	common_scripts\utility::flag_wait("FlagTrigAlleysMidLineCafeSpawns");
	var_02 = maps\_utility::array_spawn(var_00,0,1);
	var_03 = maps\_utility::array_spawn(var_01,0,1);
	common_scripts\utility::flag_set("FlagAlleysEnemySpawnsVO");
	thread alleyscombatenemycountmonitor(3);
}

//Function Number: 44
alleyscombatmidlinerightside()
{
	var_00 = getentarray("AlleysMidLineTacSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeJewelryStoreFloor1");
	var_01 = getent("AlleysMidLineJewelryStoreRoofSpawner","targetname");
	var_01 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeJewelryStoreRoof");
	common_scripts\utility::flag_wait("FlagTrigAlleysMidLineRightSideSpawns");
	var_02 = maps\_utility::array_spawn(var_00,0,1);
	var_03 = var_01 maps\_utility::spawn_ai();
}

//Function Number: 45
alleyscombatmidlinerightsideinterior()
{
	var_00 = getentarray("AlleysMidLineRightSideInteriorSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgBottomFloors");
	common_scripts\utility::flag_wait("FlagTrigAlleysMidLineRightInteriorSpawns");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 46
alleyscombatbacklinefloodspawns()
{
	var_00 = getentarray("AlleysBackLineLeftFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackLeftBldgBottomFloors");
	var_01 = getentarray("AlleysBackLineRightFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgBottomFloors");
	var_02 = maps\_utility::array_merge(var_00,var_01);
	thread maps\_utility::flood_spawn(var_02);
	thread maps\greece_code::killfloodspawnersonflag(75,"FlagTrigAlleysBackLineRetreat");
}

//Function Number: 47
alleyscombatbacklineleftside()
{
	var_00 = getentarray("AlleysBackLineTacSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackLeftBldgFloor1");
	var_01 = getentarray("AlleysBackLineAssSquadASpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeBackLeftBldgFloor2");
	var_02 = getent("AlleysBackLineTowerSpawner","targetname");
	var_02 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeBackLeftBldgFloor3");
	common_scripts\utility::flag_wait("FlagTrigAlleysBackLineSpawns");
	var_03 = maps\_utility::array_spawn(var_00,0,1);
	var_04 = maps\_utility::array_spawn(var_01,0,1);
	var_05 = var_02 maps\_utility::spawn_ai(1);
	common_scripts\utility::flag_set("FlagAlleysEnemySpawnsVO");
	thread alleyscombatenemycountmonitor(5);
}

//Function Number: 48
alleyscombatbacklineleftinteriorfloor1()
{
	var_00 = getentarray("AlleysBackLineLeftInteriorSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackLeftBldgFloor1");
	common_scripts\utility::flag_wait("FlagTrigAlleysBackLineLeftInterior");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 49
alleyscombatbacklinerightside()
{
	var_00 = getentarray("AlleysBackLineTacSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgFloor1");
	var_01 = getentarray("AlleysBackLineAssSquadBSpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgFloor2");
	var_02 = getent("AlleysBackLinePotteryRooftopSpawner","targetname");
	var_02 maps\_utility::add_spawn_function(::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgFloor3");
	common_scripts\utility::flag_wait("FlagTrigAlleysBackLineSpawns");
	var_03 = maps\_utility::array_spawn(var_00,0,1);
	var_04 = maps\_utility::array_spawn(var_01,0,1);
	var_05 = var_02 maps\_utility::spawn_ai(1);
}

//Function Number: 50
alleyscombatbacklinerightinteriorfloor1()
{
	var_00 = getentarray("AlleysBackLineRightInteriorSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgFloor1");
	common_scripts\utility::flag_wait("FlagTrigAlleysBackLineRightInterior");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 51
alleyscombatbacklinerightinteriorfloor2()
{
	var_00 = getentarray("AlleysBackLineRightInteriorUpperSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeBackRightBldgFloor2");
	common_scripts\utility::flag_wait_either("FlagTrigAlleysBackLineRightUpperBackInterior","FlagTrigAlleysBackLineRightUpperFrontInterior");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 52
alleyscombatfinalbldgfloodspawns()
{
	var_00 = getentarray("AlleysFinalBldgFloodSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFinalBldgFloor2");
	thread maps\_utility::flood_spawn(var_00);
	thread maps\greece_code::killfloodspawnersonflag(76,"FlagTrigAlleysFinalBldgInteriorFirstRoom");
}

//Function Number: 53
alleyscombatfinalbuilding()
{
	var_00 = getentarray("AlleysFinalBldgAssSquadSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFinalBldgTotal");
	common_scripts\utility::flag_wait("FlagTriggerAlleysEnemyRPGs");
	var_01 = maps\_utility::array_spawn(var_00,0,1);
}

//Function Number: 54
alleyscombatfinalbuildingshotgunners()
{
	var_00 = getentarray("AlleysShotgunnerSpawnTrigs","targetname");
	var_01 = getentarray("AlleysShotgunnerSpawnerLeft","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup);
	var_02 = getentarray("AlleysShotgunnerSpawnerMiddle","targetname");
	maps\_utility::array_spawn_function(var_02,::alleyscombatenemysetup);
	var_03 = getentarray("AlleysShotgunnerSpawnerRight","targetname");
	maps\_utility::array_spawn_function(var_03,::alleyscombatenemysetup);
	common_scripts\utility::flag_wait_any("TrigShotgunnerSpawnLeft","TrigShotgunnerSpawnMiddle","TrigShotgunnerSpawnRight");
	foreach(var_05 in var_00)
	{
		var_05 common_scripts\utility::trigger_off();
	}

	if(common_scripts\utility::flag("TrigShotgunnerSpawnLeft"))
	{
		var_07 = maps\_utility::array_spawn(var_01,0,1);
	}
	else if(common_scripts\utility::flag("TrigShotgunnerSpawnMiddle"))
	{
		var_07 = maps\_utility::array_spawn(var_03,0,1);
	}
	else
	{
		var_07 = maps\_utility::array_spawn(var_04,0,1);
	}

	maps\_utility::waittill_dead(var_07);
	level notify("AlleysShotgunnersAllDead");
}

//Function Number: 55
alleyscombatfinalbuildinginterior()
{
	var_00 = getentarray("AlleysFinalBldgInteriorFirstRoomSpawner","targetname");
	maps\_utility::array_spawn_function(var_00,::alleyscombatenemysetup,"AlleysGoalVolumeFinalBldgFloor2Left");
	var_01 = getentarray("AlleysFinalBldgInteriorLastRoomSpawner","targetname");
	maps\_utility::array_spawn_function(var_01,::alleyscombatenemysetup,"AlleysGoalVolumeFinalBldgBalcony");
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgInteriorFirstRoom");
	common_scripts\utility::flag_wait("FlagTrigAlleysFinalBldgInteriorLastRoom");
	thread alleyscombatenemycountmonitor(0);
}

//Function Number: 56
alleyscombatenemysetup(param_00,param_01)
{
	level.alleysremainingenemies = common_scripts\utility::add_to_array(level.alleysremainingenemies,self);
	if(!isdefined(self.script_noteworthy))
	{
		self.script_noteworthy = "AlleysCanRetreat";
	}
	else if(self.script_noteworthy == "AlleysCannotRetreat")
	{
		maps\_hms_utility::aideleteonflag("FlagAlleysDeleteAI",100,1);
	}

	if(self.classname == "actor_enemy_kva_civ_smg")
	{
		thread maps\_rambo::enable_militia_behavior();
	}

	if(self.classname == "actor_enemy_kva_shotgun")
	{
		thread maps\_hms_ai_utility::setupshotgunkva(param_00);
	}

	if(self.classname == "actor_enemy_kva_civ_lmg" || self.classname == "actor_enemy_kva_civ_rpg")
	{
		self.grenadeammo = 0;
	}

	if(self.classname != "actor_enemy_kva_shotgun" && isdefined(param_00))
	{
		var_02 = getent(param_00,"targetname");
		self setgoalvolumeauto(var_02);
	}
}

//Function Number: 57
alleysspawnrpgenemies()
{
	if(level.start_point == "start_alleys_art")
	{
		return;
	}

	common_scripts\utility::flag_wait("FlagTriggerAlleysEnemyRPGs");
	var_00 = maps\_utility::array_spawn_targetname("AlleysEnemyRPGguySpawner",0,1);
	level.alleysremainingenemies = common_scripts\utility::add_to_array(level.alleysremainingenemies,self);
	foreach(var_02 in var_00)
	{
		var_02.dropweapon = 0;
		level.alleysremainingenemies = common_scripts\utility::add_to_array(level.alleysremainingenemies,var_02);
	}

	var_04 = getent("AlleysRPGtriggerLeft","targetname");
	var_05 = getent("AlleysRPGtriggerRight","targetname");
	if(level.player istouching(var_04))
	{
		var_06 = "RPGleft";
	}
	else if(level.player istouching(var_06))
	{
		var_06 = "RPGright";
	}
	else
	{
		var_06 = "RPGcenter";
	}

	var_07 = getnodearray("RPGguyNode","targetname");
	foreach(var_09 in var_07)
	{
		if(var_09.script_noteworthy != var_06)
		{
			var_07 = common_scripts\utility::array_remove(var_07,var_09);
		}
	}

	var_0B = common_scripts\utility::get_array_of_farthest(level.player.origin,var_07);
	var_0C = undefined;
	for(var_0D = 0;var_0D < var_00.size;var_0D++)
	{
		var_0C = var_0B[var_0D];
		var_02 = var_00[var_0D];
		if(isdefined(var_0C))
		{
			var_02 maps\_utility::set_goal_radius(64);
			var_02 maps\_utility::set_goal_node(var_0C);
			maps\_hms_utility::printlnscreenandconsole(var_02.script_noteworthy + " is now moving to " + var_0C.origin);
			var_02 thread alleysrpgguyshootfirst(var_0C);
		}
	}
}

//Function Number: 58
alleysrpgguyshootfirst(param_00)
{
	self endon("death");
	self endon("damage");
	self waittill("goal");
	if(isdefined(param_00.target))
	{
		var_01 = undefined;
		var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
		if(isdefined(var_01.dirty) && var_01.dirty == 1)
		{
			if(common_scripts\utility::cointoss())
			{
				maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " is not firing a fake rocket - too dirty!");
				return;
			}
		}

		var_02 = undefined;
		var_03 = common_scripts\utility::getstructarray("RPGendPoint","targetname");
		var_04 = common_scripts\utility::get_array_of_closest(level.player.origin,var_03);
		foreach(var_06 in var_04)
		{
			if(sighttracepassed(var_01.origin,var_06.origin,0,undefined))
			{
				var_02 = var_06;
				break;
			}
		}

		if(isdefined(var_02))
		{
			maps\_hms_utility::printlnscreenandconsole(self.script_noteworthy + " is firing a fake rocket from " + var_01.origin + " to " + var_02.origin);
			magicbullet("iw5_mahemstraight_sp",var_01.origin,var_02.origin);
			var_08 = common_scripts\utility::getstructarray("RPGstartPoint","script_noteworthy");
			foreach(var_06 in var_08)
			{
				var_06.dirty = 1;
			}

			soundscripts\_snd::snd_message("alleys_rpg_fight_music");
			wait(1);
			self notify("clear_target");
		}
	}

	self.favoriteenemy = level.player;
}

//Function Number: 59
monitordestructiblewalls()
{
	var_00 = getentarray("AlleysDestRocketWall","targetname");
	common_scripts\utility::array_thread(var_00,::rpgdestroywall);
}

//Function Number: 60
rpgdestroywall()
{
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_04))
		{
			var_04 = tolower(var_04);
			if(var_04 == "mod_projectile" || var_04 == "mod_projectile_splash" || var_04 == "mod_explosive" || var_04 == "splash")
			{
				self notify("destroyed");
				self delete();
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 61
alleysvideolog()
{
	common_scripts\utility::flag_wait("AlleysVisitorGateIsOpen");
	maps\_shg_utility::play_videolog("manhunt_videolog","screen_add");
}

//Function Number: 62
trans2alleyscivilians()
{
	thread trans2alleysbackdoorciv();
	thread trans2alleystunnelrunners();
	thread trans2alleysdoorpeek();
	if(level.nextgen)
	{
		thread trans2alleysdoorrunin();
	}

	thread trans2alleyssitsmoke();
	thread trans2alleysbridgecivilians();
	thread trans2alleyscafecivilians();
	thread alleysdronecivilians();
	thread trans2alleysciviliansvskva();
	thread trans2alleyscivwindowpeek();
}

//Function Number: 63
trans2alleysbackdoorciv()
{
	var_00 = common_scripts\utility::getstruct("PanicOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("backdoor_Civ",1);
	var_01.animname = "backdoor_civ";
	var_01.allowpain = 0;
	var_02 = getent("backdoor","targetname");
	var_02.animname = "backdoor";
	var_02 maps\_utility::assign_animtree("backdoor");
	var_03 = [var_01,var_02];
	var_00 maps\_anim::anim_first_frame(var_03,"backdoor_panic");
	common_scripts\utility::flag_wait("trig_Civs_panic");
	var_00 maps\_anim::anim_single(var_03,"backdoor_panic");
	wait 0.05;
	if(isdefined(var_01) && isalive(var_01))
	{
		var_01 delete();
	}

	common_scripts\utility::flag_wait("FlagDeleteAlleyCivilians");
	var_02 delete();
}

//Function Number: 64
trans2alleystunnelrunners()
{
	var_00 = common_scripts\utility::getstructarray("Trans2AlleysTunnelRunnerGoal","targetname");
	common_scripts\utility::flag_wait("FlagTrigTrans2AlleysTunnelRunners");
	soundscripts\_snd::snd_message("tunnel_runner_walla");
	var_01 = [];
	var_02 = maps\_utility::array_spawn_targetname("Trans2AlleysTunnelRunnerSpawner");
	foreach(var_04 in var_02)
	{
		var_05 = common_scripts\utility::random(var_00);
		var_04 maps\_utility::set_goal_pos(var_05.origin);
		var_04.allowpain = 0;
		var_01[var_01.size] = var_04;
	}

	common_scripts\utility::flag_wait("FlagDeleteAlleyCivilians");
	maps\_utility::array_delete(var_01);
}

//Function Number: 65
trans2alleysmagicdisappearingworldevent()
{
	var_00 = getent("Trans2AlleysStreamingBlockerTruck","targetname");
	var_01 = getent("Trans2AlleysTunnelBlocker","targetname");
	var_02 = getent("Trans2AlleysTunnelGateLeft","targetname");
	var_03 = getent("Trans2AlleysTunnelGateRight","targetname");
	var_04 = getentarray("Trans2AlleysTunnelGateClip","targetname");
	var_00 common_scripts\utility::hide_notsolid();
	common_scripts\utility::flag_wait("FlagTriggerAlleysTransitionStreet");
	var_00 show();
	var_01 movez(128,0.5);
	var_02 rotateyaw(150,0.5);
	var_03 rotateyaw(-80,0.5);
	foreach(var_06 in var_04)
	{
		var_06 notsolid();
		var_06 delete();
	}

	if(level.currentgen)
	{
		if(!istransientloaded("greece_middle_tr"))
		{
			level notify("tff_pre_intro_to_middle");
			unloadtransient("greece_intro_tr");
			loadtransient("greece_middle_tr");
			while(!istransientloaded("greece_middle_tr"))
			{
				wait(0.05);
			}

			level notify("tff_post_intro_to_middle");
		}
	}
}

//Function Number: 66
trans2alleysdoorpeek()
{
	var_00 = getent("Trans2AlleyDoorPeekSpawner","targetname");
	var_01 = var_00 maps\_utility::dronespawn();
	var_01.animname = "generic";
	var_01.allowpain = 0;
	var_02 = common_scripts\utility::getstruct("Trans2AlleysCivPeekOrg","targetname");
	var_03 = getent("Trans2AlleysCivPeekDoor","targetname");
	var_03.animname = "peek_door";
	var_03 maps\_utility::assign_animtree("peek_door");
	var_04 = [var_03,var_01];
	var_05 = "trans_alley_civ_doors_peek_idle";
	var_06 = "trans_alley_civ_doors_peek_in";
	var_02 thread maps\_anim::anim_loop(var_04,var_05,"StopDoorPeek");
	maps\_utility::trigger_wait_targetname("Trans2AlleyDoorPeekTrig");
	var_02 notify("StopDoorPeek");
	var_02 maps\_anim::anim_single(var_04,var_06);
	wait 0.05;
	if(isdefined(var_01) && isalive(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 67
trans2alleyscivwindowpeek()
{
	var_00 = common_scripts\utility::getstruct("windowOrg","targetname");
	var_01 = maps\_utility::spawn_targetname("windowCiv",1);
	var_01.animname = "window_civ";
	var_01.allowpain = 0;
	var_02 = getent("shutters","targetname");
	var_02 maps\_utility::assign_animtree("window_shutters");
	var_02.animname = "window_shutters";
	var_03 = [var_01,var_02];
	var_00 maps\_anim::anim_first_frame(var_03,"window_peek_all");
	maps\_utility::trigger_wait_targetname("Trans2AlleyDoorRunInTrig");
	var_00 maps\_anim::anim_single(var_03,"window_peek_all");
}

//Function Number: 68
trans2alleysdoorrunin()
{
	maps\_utility::trigger_wait_targetname("Trans2AlleyDoorRunInTrig");
	var_00 = getent("Trans2AlleysDoorRunInSpawner","targetname");
	var_01 = var_00 maps\_utility::spawn_ai();
	var_01.animname = "generic";
	var_01.allowpain = 0;
	soundscripts\_snd::snd_message("civ_panic_door_run_in",var_01);
	var_02 = common_scripts\utility::getstruct("Trans2AlleyDoorRunInOrg","targetname");
	var_03 = getent("Trans2AlleysDoorRunInDoor","targetname");
	var_03.animname = "runin_door";
	var_03 maps\_utility::assign_animtree("runin_door");
	var_04 = [var_03,var_01];
	var_05 = "trans_alley_civ_doors_runin";
	var_02 maps\_anim::anim_first_frame_solo(var_03,var_05);
	var_02 maps\_anim::anim_reach_solo(var_01,var_05);
	var_02 maps\_anim::anim_single(var_04,var_05);
	wait 0.05;
	if(isdefined(var_01) && isalive(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 69
trans2alleyssitsmoke()
{
	var_00 = getent("Trans2AlleysSitSmokeSpawner","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "generic";
	var_01.allowpain = 0;
	var_02 = common_scripts\utility::getstruct("Trans2AlleySitSmokeOrg","targetname");
	var_03 = "hms_greece_trans_alley_sit_smoke_idle";
	var_04 = "hms_greece_trans_alley_sit_smoke_out";
	var_05 = "hms_greece_trans_alley_sit_smoke_scared_loop";
	var_02 thread maps\_anim::anim_loop_solo(var_01,var_03,"StopSitSmoke");
	maps\_utility::trigger_wait_targetname("Trans2AlleySitSmokeRunTrig");
	soundscripts\_snd::snd_message("smoking_civ_panic",var_01);
	var_02 notify("StopSitSmoke");
	var_02 maps\_anim::anim_single_solo(var_01,var_04);
	var_02 thread maps\_anim::anim_loop_solo(var_01,var_05);
	common_scripts\utility::flag_wait("FlagTrans2AlleysCivCleanup");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 70
trans2alleyscafecivilians()
{
	var_00 = maps\_utility::array_spawn_targetname("AlleysTransCivilianCafeSpawner",1);
	foreach(var_02 in var_00)
	{
		var_02.animname = var_02.script_noteworthy;
		var_02.allowpain = 0;
		if(var_02.animname == "cafe1")
		{
			var_02 thread trans2alleysstandupcivcafe();
			continue;
		}

		var_02 thread trans2alleyscivcafe();
	}

	common_scripts\utility::flag_wait("FlagTrans2AlleysCivCleanup");
	var_00 = common_scripts\utility::array_removeundefined(var_00);
	thread maps\_utility::ai_delete_when_out_of_sight(var_00,2048);
	common_scripts\utility::flag_wait("FlagDeleteAlleyCivilians");
	var_00 = common_scripts\utility::array_removeundefined(var_00);
	maps\_utility::array_delete(var_00);
}

//Function Number: 71
trans2alleyscivcafe()
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	self.allowpain = 0;
	var_00 = getent("AlleysTransCafe2Org","targetname");
	var_01 = "hms_greece_trans_alley_cafe_civ_idle";
	var_00 thread maps\_anim::anim_loop_solo(self,var_01,"stop_loop");
	common_scripts\utility::flag_wait("FlagTriggerAlleysTransitionCafe");
	maps\_utility::anim_stopanimscripted();
	var_00 notify("stop_loop");
	var_02 = "hms_greece_trans_alley_cafe_civ_exit";
	var_00 maps\_anim::anim_single_solo_run(self,var_02);
	var_03 = self.script_noteworthy + "goalAlleyTrans";
	var_04 = common_scripts\utility::getstruct(var_03,"targetname");
	maps\_utility::set_goal_pos(var_04.origin);
}

//Function Number: 72
trans2alleysstandupcivcafe()
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	self.allowpain = 0;
	var_00 = getent("AlleysTransCafe1Org","targetname");
	var_01 = "hms_greece_trans_alley_cafe_civ_idle";
	var_00 thread maps\_anim::anim_loop_solo(self,var_01,"stop_loop_1");
	maps\_utility::trigger_wait_targetname("Trans2AlleyCivStandUpTrig");
	maps\_utility::anim_stopanimscripted();
	var_00 notify("stop_loop_1");
	var_02 = "hms_greece_trans_alley_cafe_civ_sit2stand_01";
	var_03 = "hms_greece_trans_alley_cafe_civ_stand_idle_01";
	var_00 maps\_anim::anim_single_solo(self,var_02);
	var_00 thread maps\_anim::anim_loop_solo(self,var_03,"stop_loop_2");
	common_scripts\utility::flag_wait("FlagTriggerAlleysTransitionCafe");
	maps\_utility::anim_stopanimscripted();
	var_00 notify("stop_loop_2");
	var_04 = "hms_greece_trans_alley_cafe_civ_exit";
	var_00 maps\_anim::anim_single_solo_run(self,var_04);
	var_05 = self.script_noteworthy + "goalAlleyTrans";
	var_06 = common_scripts\utility::getstruct(var_05,"targetname");
	maps\_utility::set_goal_pos(var_06.origin);
}

//Function Number: 73
trans2alleysbridgecivilians()
{
	maps\_utility::trigger_wait_targetname("Trans2AlleyBridgeTrig");
	soundscripts\_snd::snd_message("walla_bridge_runners");
	var_00 = getent("AlleysCivBridgeSpawner","targetname");
	var_01 = common_scripts\utility::getstructarray("AlleyCivBridgeOrg","targetname");
	var_02 = maps\_hms_greece_civilian::populatedronecivilians(var_00,var_01,0,1);
	thread tricklebridgecivilians(var_00,var_01);
}

//Function Number: 74
tricklebridgecivilians(param_00,param_01)
{
	var_02 = [];
	for(;;)
	{
		wait(randomfloatrange(3,9));
		if(common_scripts\utility::flag("FlagTrans2AlleysCivCleanup"))
		{
			break;
		}

		var_03 = [];
		var_02 = common_scripts\utility::array_randomize(param_01);
		var_04 = 25;
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_03 = common_scripts\utility::array_add(var_03,var_02[var_05]);
			if(maps\_hms_utility::cointossweighted(var_04))
			{
				break;
			}

			var_04 = var_04 + 25;
		}

		if(var_03.size > 0)
		{
			var_06 = maps\_hms_greece_civilian::populatedronecivilians(param_00,var_03,0,1);
		}
	}
}

//Function Number: 75
alleysdronecivilians()
{
	var_00 = [];
	thread alleysdronegawker();
	var_01 = getent("AlleysCivCowerSpawner","targetname");
	var_02 = common_scripts\utility::getstructarray("AlleyCivCowerOrg","targetname");
	var_03 = maps\_hms_greece_civilian::populatedronecivilians(var_01,var_02);
	var_00 = maps\_utility::array_merge(var_03,var_00);
	common_scripts\utility::flag_wait("FlagDeleteAlleyCivilians");
	var_00 = common_scripts\utility::array_removeundefined(var_00);
	thread maps\_utility::ai_delete_when_out_of_sight(var_00,2048);
}

//Function Number: 76
alleysdronegawker()
{
	var_00 = [];
	var_01 = getent("AlleysCivGawkingSpawner","targetname");
	var_02 = common_scripts\utility::getstruct("AlleyCivGawkingOrg","targetname");
	var_03 = var_01 maps\_utility::spawn_ai(1);
	var_03 endon("death");
	var_00 = common_scripts\utility::add_to_array(var_00,var_03);
	var_03.animname = "generic";
	var_02 thread maps\_anim::anim_loop_solo(var_03,"unarmed_cowerstand_idle","gawker_flee");
	maps\_utility::trigger_wait_targetname("Trans2AlleyCivRunnerTrig");
	var_02 notify("gawker_flee");
	var_02 maps\_anim::anim_single_solo(var_03,"unarmed_cowerstand_react_2_crouch");
	var_03 thread maps\_anim::anim_loop_solo(var_03,"unarmed_cowercrouch_idle");
	wait(1);
	thread maps\_utility::ai_delete_when_out_of_sight(var_00,1024);
}

//Function Number: 77
trans2alleysciviliansvskva()
{
	maps\_utility::trigger_wait_targetname("Trans2AlleyCivRunnerTrig");
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_03 = [];
	var_01 = maps\_utility::array_spawn_targetname("AlleysTransCivilianRunnerSpawner",1);
	var_00 = maps\_utility::array_merge(var_00,var_01);
	maps\_utility::array_spawn_function_targetname("AlleysTransCivilianDyingSpawner",::trans2alleyscivdying);
	var_03 = maps\_utility::array_spawn_targetname("AlleysTransCivilianDyingSpawner",1);
	var_00 = maps\_utility::array_merge(var_00,var_03);
	var_04 = getent("AlleysTransIntro1Org","targetname");
	var_05 = getent("AlleysTransIntro1VariantOrg","targetname");
	var_06 = "hms_greece_alleys_npc_civtd_civp1";
	foreach(var_08 in var_01)
	{
		var_08.allowpain = 0;
		if(var_08.script_noteworthy == "runner1")
		{
			var_08 thread trans2alleyscivrunner(var_05,var_06);
			soundscripts\_snd::snd_message("trans_civ_01_flee_kva",var_08);
		}
		else
		{
			var_08 thread trans2alleyscivrunner(var_04,var_06);
		}

		if(var_08.script_noteworthy == "runner3")
		{
			soundscripts\_snd::snd_message("trans_civ_03_flee_kva",var_08);
		}
	}

	maps\_utility::trigger_wait_targetname("Trans2AlleyCivVictimTrig");
	var_0A = getent("AlleysTransIntro2Org","targetname");
	var_0B = "hms_greece_alleys_npc_civtd_civp2";
	var_02 = maps\_utility::array_spawn_targetname("AlleysTransCivilianVictimSpawner",1);
	var_00 = maps\_utility::array_merge(var_00,var_02);
	foreach(var_08 in var_02)
	{
		var_08.allowpain = 0;
		var_08 thread trans2alleyscivvictim(var_0A,var_0B);
	}

	var_0E = maps\_utility::array_spawn_targetname("AlleysTransExecutionerSpawner",1);
	var_0E thread monitorexecutionerdeath();
	var_0F = [];
	var_0F[0] = "iw5_kf5_sp_opticsthermal";
	var_0F[1] = "iw5_maul_sp_opticsreddot";
	var_0F[2] = "iw5_ak12_sp_opticstargetenhancer";
	var_0F[3] = "iw5_hbra3_sp_opticsacog2";
	for(var_10 = 0;var_10 < var_0E.size;var_10++)
	{
		var_0E[var_10] thread trans2alleysexecutioner(var_0A,var_0B,var_0F[var_10],var_02);
	}

	thread monitorexecutionertrigger();
	common_scripts\utility::flag_wait("FlagTrans2AlleysCivCleanup");
	var_00 = common_scripts\utility::array_removeundefined(var_00);
	thread maps\_utility::ai_delete_when_out_of_sight(var_00,2048);
	common_scripts\utility::flag_wait("FlagDeleteAlleyCivilians");
	var_00 = common_scripts\utility::array_removeundefined(var_00);
	maps\_utility::array_delete(var_00);
	var_0E = maps\_utility::array_removedead_or_dying(var_0E);
	thread maps\_utility::ai_delete_when_out_of_sight(var_0E,2048);
}

//Function Number: 78
trans2alleysexecutioner(param_00,param_01,param_02,param_03)
{
	self endon("death");
	maps\_utility::disable_long_death();
	maps\_utility::set_ignoresuppression(1);
	self.grenadeammo = 0;
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_surprise();
	thread monitorexecutionerdamage();
	self.animname = self.script_noteworthy;
	maps\_utility::forceuseweapon(param_02,"primary");
	killsomecivilians(param_00,param_01,param_03);
	maps\_utility::anim_stopanimscripted();
	if(self.animname == "guard2")
	{
		thread executioner2standground();
	}
	else
	{
		var_04 = getent("AlleyTransExecutionerVol2","targetname");
		self setgoalvolumeauto(var_04);
	}

	maps\_utility::set_ignoreme(0);
	maps\_utility::set_ignoreall(0);
}

//Function Number: 79
monitorexecutionertrigger()
{
	level endon("Trans2AlleyExecutionersReleased");
	maps\_utility::trigger_wait_targetname("Trans2AlleyReleaseExecutionersTrig");
	level notify("Trans2AlleyExecutionersReleased");
}

//Function Number: 80
monitorexecutionerdamage()
{
	level endon("Trans2AlleyExecutionersReleased");
	common_scripts\utility::waittill_any("damage","death");
	level notify("Trans2AlleyExecutionersReleased");
}

//Function Number: 81
monitorexecutionerdeath()
{
	maps\_utility::waittill_dead_or_dying(self);
	common_scripts\utility::flag_set("FlagTrans2AlleysAllExecutionersDead");
}

//Function Number: 82
executioner2standground()
{
	self endon("death");
	var_00 = getent("AlleyTransExecutionerVol1","targetname");
	self setgoalvolumeauto(var_00);
	maps\_utility::trigger_wait_targetname("Trans2AlleyReleaseExecutionersTrig");
	var_01 = getent("AlleyTransExecutionerVol2","targetname");
	self setgoalvolumeauto(var_01);
}

//Function Number: 83
killsomecivilians(param_00,param_01,param_02)
{
	self endon("death");
	level endon("Trans2AlleyExecutionersReleased");
	if(self.animname == "guard3")
	{
		param_00 = getent("AlleysTransIntro3Org","targetname");
	}

	param_00 maps\_anim::anim_single_solo(self,param_01);
}

//Function Number: 84
trans2alleyscivrunner(param_00,param_01)
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	self.animname = self.script_noteworthy;
	self.allowpain = 0;
	param_00 thread maps\_anim::anim_single_solo_run(self,param_01);
	var_02 = self.script_noteworthy + "goalAlleyTrans";
	var_03 = common_scripts\utility::getstruct(var_02,"targetname");
	maps\_utility::set_goal_pos(var_03.origin);
}

//Function Number: 85
trans2alleyscivdying()
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	self.animname = "generic";
	var_00 = self.script_noteworthy + "AlleyTrans";
	var_01 = getent(var_00,"targetname");
	var_02 = var_01.animation;
	var_01 maps\_anim::anim_single_solo(self,var_02);
	self startragdoll();
	maps\greece_code::kill_no_react();
}

//Function Number: 86
trans2alleyscivvictim(param_00,param_01)
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	self.animname = self.script_noteworthy;
	self.allowpain = 0;
	if(self.animname == "victim1")
	{
		param_00 maps\_anim::anim_single_solo(self,param_01);
		self startragdoll();
		maps\greece_code::kill_no_react();
		return;
	}

	if(self.animname == "victim2" || self.animname == "victim3")
	{
		param_00 thread maps\_anim::anim_single_solo_run(self,param_01);
		var_02 = self.script_noteworthy + "goalAlleyTrans";
		var_03 = common_scripts\utility::getstruct(var_02,"targetname");
		maps\_utility::set_goal_pos(var_03.origin);
		return;
	}

	if(self.animname == "victim4")
	{
		var_04 = "hms_greece_alleys_npc_civtd_civp2_04_idle";
		param_00 maps\_anim::anim_single_solo(self,param_01);
		param_00 thread maps\_anim::anim_loop_solo(self,var_04);
		return;
	}

	if(self.animname == "victim5")
	{
		var_04 = "hms_greece_alleys_npc_civtd_civp2_05_idle";
		param_00 maps\_anim::anim_single_solo(self,param_01);
		var_02 = self.script_noteworthy + "goalAlleyTrans";
		var_03 = common_scripts\utility::getstruct(var_02,"targetname");
		maps\_utility::set_goal_pos(var_03.origin);
		return;
	}

	param_00 thread maps\_anim::anim_single_solo(self,param_01);
	maps\_utility::set_goal_pos(self.origin);
}

//Function Number: 87
alleysvehiclemonitor()
{
	level endon("ScrambleJumpWatcherStop");
	var_00 = getent("AlleysEndCar","targetname");
	var_00 thread alleysvehicleexplodeondeath();
	for(;;)
	{
		var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isdefined(var_05) && isexplosivedamagemod(var_05))
		{
			var_00 dodamage(var_01,var_00.origin);
		}

		wait 0.05;
	}
}

//Function Number: 88
alleysvehicleexplodeondeath()
{
	level endon("ScrambleJumpWatcherStop");
	self waittill("death");
	radiusdamage(self.origin,200,100,10);
	physicsexplosionsphere(self.origin,300,100,1.5);
	earthquake(0.5,0.3,self.origin,600);
}
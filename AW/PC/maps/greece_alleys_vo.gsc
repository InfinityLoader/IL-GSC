/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_alleys_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 267 ms
 * Timestamp: 4/22/2024 2:30:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	setupalleysvo();
	thread startalleysdialoguethreads();
}

//Function Number: 2
setupalleysvo()
{
	level.dialogdangerzone = 0;
}

//Function Number: 3
startalleysdialoguethreads()
{
	thread alleysintrotransitiondialogue();
	thread alleysgatebash();
	thread alleysstreettransitiondialogue();
	thread alleyskvaintrodialogue();
	thread alleysbegincombatdialog();
	thread alleysenemyrpg();
	thread alleysmidpointreminder();
	thread alleyscombatenterbuilding();
	thread alleysilanaleadstheway();
	thread alleysvisitorcentergate();
	thread alleyssniperpip();
	thread alleysenemyspawns();
}

//Function Number: 4
alleysintrotransitiondialogue()
{
	common_scripts\utility::flag_wait("FlagSafehouseExitGateOpen");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysTransitionIntro");
}

//Function Number: 5
alleysgatebash()
{
	common_scripts\utility::flag_wait("FlagKickSafehouseExitGate");
	wait(2);
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysThroughGate");
}

//Function Number: 6
alleysstreettransitiondialogue()
{
	common_scripts\utility::flag_wait("FlagTriggerAlleysTransitionStreet");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysTransitionStreet");
	soundscripts\_snd::snd_message("start_alleys_combat_music");
}

//Function Number: 7
alleyskvaintrodialogue()
{
	common_scripts\utility::flag_wait("FlagTrigTrans2AlleyCivBattle");
	level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysBeginCombat");
	level.allies["Ilona"] maps\_utility::set_battlechatter(1);
}

//Function Number: 8
alleysbegincombatdialog()
{
	common_scripts\utility::flag_wait("FlagTrigAlleysFrontLineShowySpawns");
	level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyNote");
	level.allies["Ilona"] maps\_utility::set_battlechatter(1);
}

//Function Number: 9
alleysenemyrpg()
{
	common_scripts\utility::flag_wait("FlagTriggerAlleysEnemyRPGs");
	wait(1);
	level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyRocket");
	level.allies["Ilona"] maps\_utility::set_battlechatter(1);
}

//Function Number: 10
alleysmidpointreminder()
{
	common_scripts\utility::flag_wait("FlagTrigAlleysBackLineSpawns");
	level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyReminderAgain");
	level.allies["Ilona"] maps\_utility::set_battlechatter(1);
}

//Function Number: 11
alleysenemyspawns()
{
	level endon("AlleysAllEnemiesDead");
	for(;;)
	{
		common_scripts\utility::flag_wait("FlagAlleysEnemySpawnsVO");
		if(common_scripts\utility::cointoss())
		{
			level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
			maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemySpawn",undefined,undefined,undefined,1);
			level.allies["Ilona"] maps\_utility::set_battlechatter(1);
		}

		wait(randomfloatrange(5,15));
		common_scripts\utility::flag_clear("FlagAlleysEnemySpawnsVO");
	}
}

//Function Number: 12
alleysenemyretreat()
{
	if(level.dialogdangerzone == 0)
	{
		if(maps\_hms_utility::cointossweighted(25))
		{
			level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
			maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyRetreat",undefined,undefined,undefined,1);
			level.allies["Ilona"] maps\_utility::set_battlechatter(1);
		}
	}
}

//Function Number: 13
alleysdialogtimer()
{
	level.dialogdangerzone = 1;
	wait(10);
	level.dialogdangerzone = 0;
}

//Function Number: 14
alleyscombatenterbuilding()
{
	var_00 = getentarray("AlleysFrontLineUniqueTrig","targetname");
	var_01 = getentarray("AlleysBackLineUniqueTrig","targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		var_04 waittill("trigger",var_05);
		level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
		thread maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyEnterBuilding",undefined,undefined,undefined,1);
		level.allies["Ilona"] maps\_utility::set_battlechatter(1);
	}
}

//Function Number: 15
alleysilanaleadstheway()
{
	common_scripts\utility::flag_wait("AlleysVisitorGateIsOpen");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysEnemyIlonaLeads",undefined,undefined,undefined,1);
}

//Function Number: 16
alleysvisitorcentergate()
{
	level waittill("AlleysAllEnemiesDead");
	level.allies["Ilona"] maps\_hms_utility::waittillbcsdone("Ilona");
	maps\_hms_utility::playdialog(level.dialogtable,"AlleysGateRipIntro",undefined,undefined,undefined,1);
	thread alleysvisitorcentergatereminder();
}

//Function Number: 17
alleysvisitorcentergatereminder()
{
	level endon("NotifyAlleysGateRipStarted");
	wait(20);
	while(!common_scripts\utility::flag("AlleysGateRipStarted"))
	{
		wait(randomfloatrange(10,15));
		maps\_hms_utility::playdialog(level.dialogtable,"AlleysPickup",undefined,undefined,undefined,1);
	}
}

//Function Number: 18
alleyssniperpip()
{
	common_scripts\utility::flag_wait("AlleysVisitorGateIsOpen");
	level.player allowsprint(0);
	level.player allowdodge(0);
	wait(2);
	soundscripts\_snd::snd_message("alleys_music_end");
	maps\_hms_utility::playdialog(level.dialogtable,"VideoLog");
	level.player allowsprint(1);
	level.player allowdodge(1);
	common_scripts\utility::flag_set("FlagAlleysPipComplete");
}
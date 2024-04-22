/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_liberty.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 416 ms
 * Timestamp: 4/22/2024 2:17:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::liberty_callbackstartgametype;
	maps\mp\mp_liberty_precache::main();
	maps\createart\mp_liberty_art::main();
	maps\mp\mp_liberty_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_liberty_lighting::main();
	maps\mp\mp_liberty_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_liberty");
	thread setupdynamicevent();
	thread dynamictraversals();
	thread aud_pa_map_event_1min();
	thread aud_pa_system_announcements_decon();
	thread aud_pa_system_announcements_vessel();
	thread aud_pa_system_announcements_medzone();
	maps\mp\_water::init();
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.ospvisionset = "mp_liberty_osp";
	level.osplightset = "mp_liberty_osp";
	level.dronevisionset = "mp_liberty_drone";
	level.dronelightset = "mp_liberty_drone";
	level.warbirdvisionset = "mp_liberty_warbird";
	level.warbirdlightset = "mp_liberty_warbird";
	level.skip_bot_node_checks = 1;
	level.monkeytriggerplayers = [];
	level.monkeytriggerplayers2 = [];
	level thread monkeysmonitorshooting();
	level thread monkeysmonitorshooting2();
	level thread monkeys();
	level thread monkeys2();
	if(level.nextgen)
	{
		level thread patchclip();
	}
}

//Function Number: 2
liberty_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
patchclip()
{
}

//Function Number: 4
setupdynamicevent()
{
	level thread maps\mp\_dynamic_events::dynamicevent(::dynamiceventstartfunc,undefined,::dynamiceventendfunc);
}

//Function Number: 5
dynamiceventstartfunc()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(2);
	playsoundatpos((0,0,0),"mp_liberty_alarm_start");
	wait(6);
	level notify("doors opening");
	var_00 = getent("ape_door","targetname");
	var_01 = getent("ape_door2","targetname");
	var_02 = getent("physicsJolt","targetname");
	physicsjolt(var_02.origin,512,256,(0,-0.4,0.1));
	var_03 = var_00 common_scripts\utility::spawn_tag_origin();
	var_03 linkto(var_00);
	var_03 show();
	playfxontag(common_scripts\utility::getfx("lib_hatchet_doors_open"),var_03,"tag_origin");
	var_04 = var_01 common_scripts\utility::spawn_tag_origin();
	var_04 linkto(var_01);
	var_04 show();
	playfxontag(common_scripts\utility::getfx("lib_hatchet_doors_open_2"),var_04,"tag_origin");
	thread maps\mp\mp_liberty_fx::dynamic_door_dust_effect();
	thread disconnectnodes();
	var_05 = getentarray("ape_door_sfx","targetname");
	foreach(var_07 in var_05)
	{
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(2);
	var_00 rotateto((0,0,-80),15,4,4);
	var_01 rotateto((0,0,80),15,4,4);
	var_09 = var_00 getlinkedchildren();
	var_09 = common_scripts\utility::array_combine(var_09,var_01 getlinkedchildren());
	for(var_0A = 0;var_0A < var_09.size;var_0A++)
	{
		if(isdefined(var_09[var_0A].targetname) && var_09[var_0A].targetname == "care_package")
		{
			var_09[var_0A] maps\mp\killstreaks\_airdrop::deletecrate();
		}

		if(isdefined(var_09[var_0A].classname) && var_09[var_0A].classname == "misc_turret")
		{
			var_09[var_0A] notify("death");
		}
	}

	thread maps\mp\_audio::snd_play_in_space("mp_lib_monkey_doors_full",var_00.origin);
	thread maps\mp\_audio::snd_play_in_space("mp_lib_monkey_doors_bed",var_00.origin);
	thread maps\mp\_audio::snd_play_in_space("dynwarn_liberty_doors_opening",(216,179,545));
	wait(12);
	var_0B = getent("physicsJolt2","targetname");
	physicsjolt(var_0B.origin,512,256,(0,-0.4,0.1));
	maps\mp\_audio::snd_play_in_space("dynwarn_liberty_doors_open",(216,179,545));
	wait(2);
}

//Function Number: 6
dynamiceventendfunc()
{
	level notify("doors opening");
	var_00 = getent("ape_door","targetname");
	var_01 = getent("ape_door2","targetname");
	var_00 rotateto((0,0,-80),1);
	var_01 rotateto((0,0,80),1);
	thread disconnectnodes();
}

//Function Number: 7
dynamictraversals()
{
	var_00 = getnodearray("dynamic_traversal_add","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 disconnectnode();
	}

	level waittill("doors opening");
	foreach(var_02 in var_00)
	{
		var_02 connectnode();
	}
}

//Function Number: 8
disconnectnodes()
{
	var_00 = getnodearray("dynamic_node_delete","targetname");
	foreach(var_02 in var_00)
	{
		var_02 disconnectnode();
	}

	var_04 = getnodearray("dynamic_traversal_delete","script_noteworthy");
	foreach(var_06 in var_04)
	{
		var_06 disconnectnode();
	}
}

//Function Number: 9
monkeys()
{
	level.monkeytriggers = getent("monkey_trigger","targetname");
	level.monkeys = getentarray("caged_monkey","targetname");
	level.monkeyanimvariants = ["a","a2","b","b2"];
	level.monkeyanimsubvariants = ["","2"];
	foreach(var_01 in level.monkeys)
	{
		var_01 thread startdefaultanim();
	}

	level.monkeytriggers thread monkeytriggerthink();
}

//Function Number: 10
startdefaultanim()
{
	var_00 = randomfloatrange(0.5,5);
	wait(var_00);
	var_01 = common_scripts\utility::random(level.monkeyanimvariants);
	var_02 = common_scripts\utility::random(level.monkeyanimsubvariants);
	if(var_01 == "a")
	{
		var_02 = "";
	}
	else if(var_01 == "a2")
	{
		var_02 = "2";
	}
	else if(var_01 == "b")
	{
		var_02 = "";
	}
	else if(var_01 == "b2")
	{
		var_02 = "2";
	}

	self scriptmodelplayanim("liberty_monkey_calm_idle_" + var_01 + var_02);
	self.freakoutstate = "calm";
}

//Function Number: 11
monkeytriggerthink()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00) && !common_scripts\utility::array_contains(level.monkeytriggerplayers,var_00))
		{
			level.monkeytriggerplayers = common_scripts\utility::array_add(level.monkeytriggerplayers,var_00);
			var_00 thread monitormonkeytriggerexit(self);
		}
	}
}

//Function Number: 12
monkeysmonitorshooting()
{
	for(;;)
	{
		foreach(var_01 in level.monkeytriggerplayers)
		{
			if(isplayer(var_01) && var_01 isfiring())
			{
				foreach(var_03 in level.monkeys)
				{
					if(var_03.freakoutstate == "calm")
					{
						var_03 thread monkeyfreakout();
					}
				}

				wait(1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
monitormonkeytriggerexit(param_00)
{
	while(isdefined(self) && self istouching(param_00))
	{
		wait(0.05);
	}

	if(common_scripts\utility::array_contains(level.monkeytriggerplayers,self))
	{
		level.monkeytriggerplayers = common_scripts\utility::array_remove(level.monkeytriggerplayers,self);
	}
}

//Function Number: 14
monkeyfreakout()
{
	self.freakoutstate = "freaking_out";
	thread aud_monkey_freakout();
	var_00 = randomfloatrange(0.1,2.5);
	wait(var_00);
	var_01 = common_scripts\utility::random(level.monkeyanimvariants);
	var_02 = common_scripts\utility::random(level.monkeyanimsubvariants);
	if(var_01 == "a")
	{
		var_02 = "";
	}
	else if(var_01 == "a2")
	{
		var_02 = "2";
	}
	else if(var_01 == "b")
	{
		var_02 = "";
	}
	else if(var_01 == "b2")
	{
		var_02 = "2";
	}

	self scriptmodelclearanim();
	self scriptmodelplayanim("liberty_monkey_calm_2_freak_" + var_01 + var_02,"freak_out");
	self waittillmatch("end","freak_out");
	self scriptmodelclearanim();
	self scriptmodelplayanim("liberty_monkey_freak_idle_" + var_01 + var_02,"freak_idle");
	self.freakoutstate = "freaking_out";
	self waittillmatch("end","freak_idle");
	self scriptmodelclearanim();
	self endon("cancel_calmdown");
	self.freakoutstate = "calm";
	self scriptmodelplayanim("liberty_monkey_freak_2_calm_" + var_01 + var_02,"freak_2_calm");
	self waittillmatch("end","freak_2_calm");
	self scriptmodelclearanim();
	restartdefaultanim(var_01);
}

//Function Number: 15
aud_monkey_freakout()
{
	var_00 = randomfloatrange(1,2.5);
	wait(var_00);
	self playsound("mp_lib_monkey_yells");
	wait(var_00);
	self playsound("mp_lib_monkey_yells");
}

//Function Number: 16
restartdefaultanim(param_00)
{
	self scriptmodelplayanim("liberty_monkey_calm_idle_" + param_00);
	self.freakoutstate = "calm";
}

//Function Number: 17
monkeys2()
{
	level.monkeytriggers2 = getent("monkey_trigger2","targetname");
	level.monkeys2 = getentarray("caged_monkey2","targetname");
	level.monkeyanimvariants = ["a","b"];
	level.monkeyanimsubvariants = ["","2"];
	foreach(var_01 in level.monkeys2)
	{
		var_01 thread startdefaultanim2();
	}

	level.monkeytriggers2 thread monkeytriggerthink2();
}

//Function Number: 18
startdefaultanim2()
{
	var_00 = randomfloatrange(0.5,5);
	wait(var_00);
	var_01 = common_scripts\utility::random(level.monkeyanimvariants);
	if(var_01 != "b")
	{
		var_02 = common_scripts\utility::random(level.monkeyanimsubvariants);
	}
	else
	{
		var_02 = "";
	}

	self scriptmodelplayanim("liberty_monkey_calm_idle_" + var_01 + var_02);
	self.freakoutstate = "calm";
}

//Function Number: 19
monkeytriggerthink2()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00) && !common_scripts\utility::array_contains(level.monkeytriggerplayers2,var_00))
		{
			level.monkeytriggerplayers2 = common_scripts\utility::array_add(level.monkeytriggerplayers2,var_00);
			var_00 thread monitormonkeytriggerexit2(self);
		}
	}
}

//Function Number: 20
monkeysmonitorshooting2()
{
	for(;;)
	{
		foreach(var_01 in level.monkeytriggerplayers2)
		{
			if(isplayer(var_01) && var_01 isfiring())
			{
				foreach(var_03 in level.monkeys2)
				{
					if(var_03.freakoutstate == "calm")
					{
						var_03 thread monkeyfreakout2();
					}
				}

				wait(1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
monitormonkeytriggerexit2(param_00)
{
	while(isdefined(self) && self istouching(param_00))
	{
		wait(0.05);
	}

	if(common_scripts\utility::array_contains(level.monkeytriggerplayers2,self))
	{
		level.monkeytriggerplayers2 = common_scripts\utility::array_remove(level.monkeytriggerplayers2,self);
	}
}

//Function Number: 22
monkeyfreakout2()
{
	self.freakoutstate = "freaking_out";
	thread aud_monkey_freakout();
	var_00 = randomfloatrange(0.1,2.5);
	wait(var_00);
	var_01 = common_scripts\utility::random(level.monkeyanimvariants);
	var_02 = common_scripts\utility::random(level.monkeyanimsubvariants);
	self scriptmodelclearanim();
	self scriptmodelplayanim("liberty_monkey_calm_2_freak_" + var_01 + var_02,"freak_out");
	self waittillmatch("end","freak_out");
	self scriptmodelclearanim();
	self scriptmodelplayanim("liberty_monkey_freak_idle_" + var_01 + var_02,"freak_idle");
	self.freakoutstate = "freaking_out";
	self waittillmatch("end","freak_idle");
	self scriptmodelclearanim();
	self endon("cancel_calmdown");
	self.freakoutstate = "calm";
	self scriptmodelplayanim("liberty_monkey_freak_2_calm_" + var_01 + var_02,"freak_2_calm");
	self waittillmatch("end","freak_2_calm");
	self scriptmodelclearanim();
	restartdefaultanim2(var_01);
}

//Function Number: 23
restartdefaultanim2(param_00)
{
	self scriptmodelplayanim("liberty_monkey_calm_idle_" + param_00);
	self.freakoutstate = "calm";
}

//Function Number: 24
aud_pa_map_event_1min()
{
	wait(240);
	common_scripts\utility::play_sound_in_space("dynwarn_liberty_doors_1min",(216,179,545));
}

//Function Number: 25
aud_pa_system_announcements_decon()
{
	var_00 = randomfloatrange(40,75);
	for(;;)
	{
		wait(var_00);
		thread common_scripts\utility::play_sound_in_space("dynwarn_liberty_decon",(2149,28,347));
		wait(4);
	}
}

//Function Number: 26
aud_pa_system_announcements_vessel()
{
	var_00 = randomfloatrange(45,60);
	for(;;)
	{
		wait(var_00);
		thread common_scripts\utility::play_sound_in_space("dynwarn_liberty_vessel",(-337,2701,427));
		wait(7);
	}
}

//Function Number: 27
aud_pa_system_announcements_medzone()
{
	var_00 = randomfloatrange(35,55);
	for(;;)
	{
		wait(var_00);
		thread common_scripts\utility::play_sound_in_space("dynwarn_liberty_medzone",(286,-681,439));
		wait(10);
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_fracture.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 946 ms
 * Timestamp: 4/22/2024 2:17:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::fracture_callbackstartgametype;
	maps\mp\mp_fracture_precache::main();
	maps\createart\mp_fracture_art::main();
	maps\mp\mp_fracture_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_fracture_lighting::main();
	maps\mp\mp_fracture_aud::main();
	maps\mp\_water::init();
	maps\mp\_water::init();
	maps\mp\_compass::setupminimap("compass_map_mp_cargoship2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.goliath_bad_landing_volumes = [];
	precachemodel("genericprop");
	precacherumble("cgo_event_rumble_loop");
	level.ospvisionset = "mp_fracture_osp";
	level.osplightset = "mp_fracture_osp";
	level.dronevisionset = "mp_fracture_drone";
	level.dronelightset = "mp_fracture_drone";
	level.warbirdvisionset = "mp_fracture_warbird";
	level.warbirdlightset = "mp_fracture_warbird";
	level.availableicebergs = [];
	level.usedicebergs = [];
	level.icebergspawn = getent("icebergSpawner","targetname");
	level.icebergfinish = getent("icebergEnd","targetname");
	level thread onplayerconnect();
	level thread initcarepackagebadvolumes();
	thread fracturekillstreakoverrides();
	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::handleiceberglanebreakup,::handleiceberglanereset,::handleiceberglanebreakupend);
	level thread fracturegoliathdeathhack();
	setdvar("scr_spawnfactor_maxenemydistance",2000);
	level.ballpreventgoaljumpfromtraversals = 1;
	level.ballgoalradius = 180;
}

//Function Number: 2
fracture_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
fracturekillstreakoverrides()
{
	while(!isdefined(level.orbitalsupportoverrides))
	{
		wait 0.05;
	}

	level.orbitalsupportoverrides.spawnheight = 6500;
	level.remote_missile_height_override = 18000;
	level.orbitalsupportoverrides.spawnangle = 90;
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread handleicewaterdamagetrigger();
	}
}

//Function Number: 5
handleicewaterdamagetrigger()
{
	var_00 = getent("ice_water_hurt_trig","targetname");
	for(;;)
	{
		while(isalive(self) && self istouching(var_00))
		{
			self dodamage(5,self.origin,undefined,undefined,"MOD_TRIGGER_HURT","none","none");
			wait(0.1);
			maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		}

		wait 0.05;
	}
}

//Function Number: 6
handledynamiceventspawns()
{
	waittillframeend;
	spawnsetup();
	if(!isdefined(level.endstateinit))
	{
		level.predynamicevent = 1;
		level.postdynamicevent = 0;
		level waittill("dynamic_event_started");
		level.predynamicevent = 0;
		level.postdynamicevent = 0;
		level waittill("dynamic_event_complete");
	}

	level.predynamicevent = 0;
	level.postdynamicevent = 1;
}

//Function Number: 7
spawnsetup()
{
	level.dynamicspawns = ::getlistofgoodspawnpoints;
}

//Function Number: 8
getlistofgoodspawnpoints(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.targetname) || var_03.targetname == "" || var_03 isvalidspawn() == 1)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 9
isvalidspawn()
{
	if(level.predynamicevent == 1 && self.targetname == "post_dynamic_event_spawn")
	{
		return 0;
	}
	else if(level.predynamicevent == 0 && level.postdynamicevent == 0 && self.targetname == "pre_dynamic_event_spawn" || self.targetname == "post_dynamic_event_spawn")
	{
		return 0;
	}
	else if(level.postdynamicevent == 1 && self.targetname == "pre_dynamic_event_spawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
getspawnsexcludingtargetname(param_00)
{
	var_01 = [];
	foreach(var_03 in level.allspawns)
	{
		if(var_03.targetname != param_00)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 11
dynamicevent_init()
{
	setupicebergbonelist();
	setupiceberglane();
	thread setupiceberganimproxy();
	setupiceberglanebadvolume();
	thread handledynamiceventspawns();
	thread handledynamiceventpaths();
	thread setupicebergeventshake();
	thread setupicebergfxchunks();
}

//Function Number: 12
setupicebergbonelist()
{
	var_00 = [setupbonestruct("chunk_A",(2340,971,-440.139),1),setupbonestruct("A_container_01_red",(1977.2,724.165,-307.299),1),setupbonestruct("A_container_01_orange",(1631,714.695,-182.16),1),setupbonestruct("chunk_B",(1052.38,1040.26,-138.983),0),setupbonestruct("B_snowcat",(162.003,746.972,-384.812),1),setupbonestruct("B_container_01_liteblue1",(-1540,780.63,-416.497),1),setupbonestruct("chunk_C",(227,1128.54,-402.207),1),setupbonestruct("chunk_D",(-561,1029.83,-122.877),0),setupbonestruct("chunk_E",(-1963,1031.29,-384.02),1)];
	level.icebergbonelist = [];
	foreach(var_02 in var_00)
	{
		level.icebergbonelist[var_02.jointname] = var_02;
	}
}

//Function Number: 13
setupiceberglane()
{
	level.iceberglanemodel = spawn("script_model",(0,0,0));
	level.iceberglanemodel setmodel("cgo_iceberg_lane");
	level.iceberglanemodel.angles = (0,-90,0);
	level.iceberglanemodel hide();
	foreach(var_01 in level.icebergbonelist)
	{
		if(ismajoricebergchunkent(var_01.jointname))
		{
			var_02 = getentarray(var_01.jointname,"targetname");
			foreach(var_04 in var_02)
			{
				var_04.origin = var_04.origin + (0,-1024,0);
			}
		}
	}
}

//Function Number: 14
prepareiceberganimation(param_00)
{
	wait(0.001);
	if(isdefined(level.endstateinit))
	{
		return;
	}

	param_00.animproxy scriptmodelplayanimdeltamotion(param_00.animname);
	param_00.animproxy scriptmodelpauseanim(1);
	level waittill("icebergAnimStart");
	param_00.animproxy scriptmodelpauseanim(0);
}

//Function Number: 15
setupiceberglanebadvolume()
{
	level.iceberglanebadvolumelist = getentarray("iceberg_lane_badplace_volume","targetname");
}

//Function Number: 16
ismajoricebergchunkent(param_00)
{
	if(param_00 == "chunk_A_jnt" || param_00 == "chunk_B_jnt" || param_00 == "chunk_C_jnt" || param_00 == "chunk_D_jnt" || param_00 == "chunk_E_jnt")
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
setupbonestruct(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.jointname = param_00 + "_jnt";
	var_03.animname = "cgo_iceberg_lane_collapse_" + param_00;
	var_03.xmodelname = "cgo_iceberg_lane_" + param_00;
	var_03.endpos = param_01;
	var_03.shouldclean = param_02;
	return var_03;
}

//Function Number: 18
setupicebergeventshake()
{
	var_00 = [];
	var_00["A"] = getscriptablearray("crack_event_A","targetname")[0];
	var_00["B"] = getscriptablearray("crack_event_B","targetname")[0];
	var_00["C"] = getscriptablearray("crack_event_C","targetname")[0];
	var_00["D"] = getscriptablearray("crack_event_D","targetname")[0];
	var_00["E"] = getscriptablearray("crack_event_E","targetname")[0];
	var_00["start"] = getscriptablearray("start_event","targetname")[0];
	level.icebergeventscriptables = var_00;
	var_01 = [];
	var_01["A"] = getentarray("event_shake_trigger_A","targetname");
	var_01["B"] = getentarray("event_shake_trigger_B","targetname");
	var_01["C"] = getentarray("event_shake_trigger_C","targetname");
	var_01["D"] = getentarray("event_shake_trigger_D","targetname");
	var_01["E"] = getentarray("event_shake_trigger_E","targetname");
	var_01["liteblue1"] = getentarray("event_shake_trigger_liteblue1","targetname");
	var_01["snowcat"] = getentarray("event_shake_trigger_snowcat","targetname");
	var_01["orange"] = getentarray("event_shake_trigger_orange","targetname");
	var_01["red"] = getentarray("event_shake_trigger_red","targetname");
	foreach(var_03 in var_01)
	{
		foreach(var_05 in var_03)
		{
			var_05 hide();
		}
	}

	level.icebergshaketriggerlists = var_01;
	level.icebergcontinuingrumble = "cgo_event_rumble_loop";
}

//Function Number: 19
setupicebergfxchunks()
{
	if(level.currentgen)
	{
		return;
	}

	common_scripts\utility::flag_init("icebergChunks");
	while(isdefined(level.icebergchunks1) == 0)
	{
		level.icebergchunks1 = getent("icebergChunks1","targetname");
		wait(0.2);
	}

	level.icebergchunks1 hide();
	while(isdefined(level.icebergchunks2) == 0)
	{
		level.icebergchunks2 = getent("icebergChunks2","targetname");
		wait(0.2);
	}

	level.icebergchunks2 hide();
	while(isdefined(level.icebergchunks3) == 0)
	{
		level.icebergchunks3 = getent("icebergChunks3","targetname");
		wait(0.2);
	}

	level.icebergchunks3 hide();
	common_scripts\utility::flag_set("icebergChunks");
}

//Function Number: 20
handleiceberglanebreakup()
{
	thread handleinitialicebergshake();
	thread doiceberglanebadplace();
	level notify("dynamic_event_pre_start");
	wait(5);
	level notify("dynamic_event_started");
	wait(3);
	common_scripts\utility::flag_wait("icebergAnimProxy");
	thread notifyaftermajormotion();
	thread maps\mp\mp_fracture_fx::ice_cracking_fx();
	thread handleicebergeventshake();
	if(level.nextgen)
	{
		thread playicebergchunks1();
		thread playicebergchunks2();
		thread playicebergchunks3();
	}

	level notify("icebergAnimStart");
	thread aud_play_iceberg_splitting();
	wait(30);
	level notify("dynamic_event_complete");
	thread cleanupsunkenchunks();
}

//Function Number: 21
aud_play_iceberg_splitting()
{
	var_00 = (2322.8,1093.73,-73.7358);
	wait(0.5);
	thread common_scripts\utility::play_sound_in_space("iceberg_full_event",var_00);
}

//Function Number: 22
notifyaftermajormotion()
{
	common_scripts\utility::flag_init("icebergMajorMotionComplete");
	wait(18);
	common_scripts\utility::flag_set("icebergMajorMotionComplete");
}

//Function Number: 23
doiceberglanebadplace()
{
	var_00 = 0;
	foreach(var_02 in level.iceberglanebadvolumelist)
	{
		badplace_brush("IBLaneBadplace" + var_00,15,var_02,"axis","allies");
		var_00++;
	}
}

//Function Number: 24
playicebergchunks1()
{
	wait(2.67);
	common_scripts\utility::flag_wait("icebergChunks");
	thread aud_iceberg_sequence_01();
	var_00 = spawnfx(common_scripts\utility::getfx("mp_cgo_iceberg_foam_1"),(2322.8,1093.73,-73.7358),anglestoforward((270,0,178)),anglestoup((270,0,178)));
	triggerfx(var_00);
	wait(3);
	level.icebergchunks1 show();
	level.icebergchunks1 scriptmodelplayanimdeltamotion("vfx_cgo_iceberg_breakup_1");
	wait(55);
	var_00 delete();
}

//Function Number: 25
playicebergchunks2()
{
	wait(5.67);
	common_scripts\utility::flag_wait("icebergChunks");
	thread aud_iceberg_sequence_02();
	var_00 = spawnfx(common_scripts\utility::getfx("mp_cgo_iceberg_foam_1"),(-1236.57,973.315,-78),anglestoforward((270,0,173)),anglestoup((270,0,173)));
	triggerfx(var_00);
	wait(4);
	level.icebergchunks2 show();
	level.icebergchunks2 scriptmodelplayanimdeltamotion("vfx_cgo_iceberg_breakup_2");
	wait(55);
	var_00 delete();
}

//Function Number: 26
playicebergchunks3()
{
	wait(1.33);
	common_scripts\utility::flag_wait("icebergChunks");
	thread aud_iceberg_sequence_03();
	var_00 = spawnfx(common_scripts\utility::getfx("mp_cgo_iceberg_foam_1"),(498.966,1091.24,-78),anglestoforward((270,0,173)),anglestoup((270,0,173)));
	triggerfx(var_00);
	wait(3);
	level.icebergchunks3 show();
	level.icebergchunks3 scriptmodelplayanimdeltamotion("vfx_cgo_iceberg_breakup_3");
	wait(55);
	var_00 delete();
}

//Function Number: 27
aud_iceberg_sequence_01()
{
	var_00 = (2322.8,1093.73,-73.7358);
	thread common_scripts\utility::play_sound_in_space("iceberg_full_event",var_00);
}

//Function Number: 28
aud_iceberg_sequence_02()
{
	var_00 = (-1236.57,973.315,-78);
	thread common_scripts\utility::play_sound_in_space("iceberg_full_event",var_00);
}

//Function Number: 29
aud_iceberg_sequence_03()
{
	var_00 = (498.966,1091.24,-78);
	thread common_scripts\utility::play_sound_in_space("iceberg_full_event",var_00);
}

//Function Number: 30
handleinitialicebergshake()
{
	wait(4);
	thread maps\mp\_audio::snd_play_in_space("mp_fracture_ty_initial_hit",(0,0,0));
	thread executeicebergeventscriptable(level.icebergeventscriptables["start"]);
}

//Function Number: 31
handleicebergeventshake()
{
	thread wakeupphysicsnearjoint(level.icebergbonelist["B_container_01_liteblue1_jnt"],10.1);
	thread wakeupphysicsnearjoint(level.icebergbonelist["A_container_01_orange_jnt"],7.7);
	thread wakeupphysicsnearjoint(level.icebergbonelist["A_container_01_red_jnt"],12.8);
	thread wakeupphysicsnearjoint(level.icebergbonelist["B_snowcat_jnt"],8);
	thread executeicebergeventscriptable(level.icebergeventscriptables["C"]);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["C"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["chunk_C_jnt"]);
	wait(1);
	thread executeicebergeventscriptable(level.icebergeventscriptables["D"]);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["D"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["chunk_D_jnt"]);
	wait(0.3);
	thread executeicebergeventscriptable(level.icebergeventscriptables["B"]);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["B"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["chunk_B_jnt"]);
	wait(0.7);
	thread executeicebergeventscriptable(level.icebergeventscriptables["E"]);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["E"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["chunk_E_jnt"]);
	wait(0.1);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["snowcat"]);
	wait(0.2);
	thread executeicebergeventscriptable(level.icebergeventscriptables["A"]);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["A"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["chunk_A_jnt"]);
	wait(0.7);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["orange"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["A_container_01_orange_jnt"]);
	wait(0.7);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["liteblue1"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["B_container_01_liteblue1_jnt"]);
	wait(6.3);
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists["red"]);
	thread wakeupphysicsnearjoint(level.icebergbonelist["A_container_01_red_jnt"]);
	level waittill("dynamic_event_complete");
	level notify("fracture_event_shake_end");
	foreach(var_01 in level.icebergshaketriggerlists)
	{
		foreach(var_03 in var_01)
		{
			var_03 common_scripts\utility::trigger_off();
		}
	}
}

//Function Number: 32
wakeupphysicsnearjoint(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	physicsexplosionsphere(param_00.animproxy.origin,800,0,0);
}

//Function Number: 33
executeicebergeventshakesection(param_00)
{
	thread executeicebergeventscriptable(level.icebergeventscriptables[param_00]);
	var_01 = "chunk_" + param_00 + "_jnt";
	thread activateicebergshaketriggerlists(level.icebergshaketriggerlists[param_00],var_01);
}

//Function Number: 34
executeicebergeventscriptable(param_00)
{
	param_00 setscriptablepartstate(0,1);
	wait(0.1);
	param_00 setscriptablepartstate(0,0);
}

//Function Number: 35
activateicebergshaketriggerlists(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 thread common_scripts\_dynamic_world::triggertouchthink(::entericebergshaketrigger,::exiticebergshaketrigger);
	}
}

//Function Number: 36
entericebergshaketrigger(param_00)
{
	var_01 = 0;
	if(isdefined(self.fractureshaketriggercount))
	{
		var_01 = self.fractureshaketriggercount;
	}

	if(var_01 == 0 && !isdefined(self.fractureshakeactive))
	{
		self.fractureshakeactive = 1;
		thread icebergtriggershakethink();
		if(!common_scripts\utility::flag("icebergMajorMotionComplete"))
		{
			thread setupicebergdeath();
		}
	}

	self.fractureshaketriggercount = var_01 + 1;
}

//Function Number: 37
exiticebergshaketrigger(param_00)
{
	self.fractureshaketriggercount--;
	waittillframeend;
	if(self.fractureshaketriggercount == 0)
	{
		self notify("fracture_event_triggers_left");
		self.fractureshakeactive = undefined;
		self.icebergtriggerrumbling = undefined;
	}
}

//Function Number: 38
icebergtriggershakethink()
{
	if(isbot(self))
	{
		return;
	}

	self endon("death");
	self endon("disconnect");
	self endon("fracture_event_triggers_left");
	level endon("dynamic_event_complete");
	level endon("fracture_event_shake_end");
	for(;;)
	{
		while(!self isonground() || !isdefined(self getmovingplatformparent()))
		{
			wait 0.05;
		}

		thread icebergtriggershake();
		wait(0.4);
	}
}

//Function Number: 39
icebergtriggershake()
{
	self notify("fracture_event_shake");
	self endon("death");
	self endon("disconnect");
	self endon("fracture_event_shake");
	if(!isdefined(self.icebergtriggerrumbling))
	{
		self playrumblelooponentity(level.icebergcontinuingrumble);
		self.icebergtriggerrumbling = 1;
	}

	earthquake(0.075,0.5,self.origin,63360,self);
	wait(0.5);
	self stoprumble(level.icebergcontinuingrumble);
	self.icebergtriggerrumbling = undefined;
}

//Function Number: 40
setupiceberganimproxy()
{
	common_scripts\utility::flag_init("icebergAnimProxy");
	foreach(var_01 in level.icebergbonelist)
	{
		connectenttoanimproxy(var_01);
	}

	common_scripts\utility::flag_set("icebergAnimProxy");
}

//Function Number: 41
setupanimproxy(param_00)
{
	var_01 = level.iceberglanemodel gettagorigin(param_00.jointname);
	var_02 = level.iceberglanemodel gettagangles(param_00.jointname);
	var_03 = spawn("script_model",var_01);
	var_03 setmodel(param_00.xmodelname);
	var_03.angles = var_02;
	return var_03;
}

//Function Number: 42
connectenttoanimproxy(param_00,param_01)
{
	param_00.animproxy = setupanimproxy(param_00);
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	var_02 = getentarray(param_00.jointname,"targetname");
	foreach(var_04 in var_02)
	{
		var_04 vehicle_jetbikesethoverforcescale(param_00.animproxy);
		if(isdefined(param_01))
		{
			wait(param_01);
		}
	}

	thread prepareiceberganimation(param_00);
	if(isdefined(param_01))
	{
		wait(param_01);
	}
}

//Function Number: 43
disconnectentfromanimproxyanddelete(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00.jointname,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 unlink();
		var_05 delete();
		if(isdefined(param_02))
		{
			wait(param_02);
		}
	}
}

//Function Number: 44
cleanupsunkenchunks()
{
	foreach(var_01 in level.icebergbonelist)
	{
		if(isdefined(var_01.shouldclean) && var_01.shouldclean == 1)
		{
			disconnectentfromanimproxyanddelete(var_01,level.iceberglanecollapseanimproxy,0.1);
		}
	}

	wait(26.67);
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("icebergChunks");
		level.icebergchunks1 delete();
		level.icebergchunks2 delete();
		level.icebergchunks3 delete();
	}
}

//Function Number: 45
handleiceberglanebreakupend()
{
	level.endstateinit = 1;
	level notify("dynamic_event_started");
	foreach(var_01 in level.icebergbonelist)
	{
		var_01.animproxy.origin = var_01.endpos;
	}

	level notify("dynamic_event_complete");
	thread cleanupsunkenchunks();
}

//Function Number: 46
handleiceberglanereset()
{
}

//Function Number: 47
handledynamiceventpaths()
{
	var_00 = getent("post_dynamic_event_temp_geo","targetname");
	var_01 = getent("pre_dynamic_event_temp_geo","targetname");
	var_00 delete();
	var_01 delete();
	patchaerialnodes();
	waittillframeend;
	thread handledynamiceventcarepackagebadvolumes();
	if(!isdefined(level.endstateinit))
	{
		thread disconnectnodes("post_dynamic_event_pathnodes");
		level waittill("dynamic_event_started");
		thread disconnectnodes("pre_dynamic_event_pathnodes",1);
		level waittill("icebergMajorMotionComplete");
		thread connectnodes("post_dynamic_event_pathnodes",1);
		return;
	}

	thread disconnectnodes("pre_dynamic_event_pathnodes");
}

//Function Number: 48
initcarepackagebadvolumes()
{
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	var_00 = getentarray("carepackage_bad_vol","targetname");
	foreach(var_02 in var_00)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_02;
	}

	foreach(var_02 in var_00)
	{
		level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_02;
	}
}

//Function Number: 49
handledynamiceventcarepackagebadvolumes()
{
	var_00 = getentarray("pre_event_bad_vol","targetname");
	var_01 = getentarray("post_event_bad_vol","targetname");
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	foreach(var_03 in var_00)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_03;
	}

	foreach(var_03 in var_00)
	{
		level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_03;
	}

	foreach(var_03 in var_01)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_03;
	}

	foreach(var_03 in var_01)
	{
		level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_03;
	}

	if(!isdefined(level.endstateinit))
	{
		thread disabletriggerset(var_01);
		level waittill("dynamic_event_pre_start");
		thread enabletriggerset(var_01);
		level waittill("dynamic_event_complete");
	}

	thread disabletriggerset(var_00);
}

//Function Number: 50
enabletriggerset(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}
}

//Function Number: 51
disabletriggerset(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}
}

//Function Number: 52
disconnectnodes(param_00,param_01)
{
	var_02 = getnodearray(param_00,"targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] disconnectnode();
		if(isdefined(param_01) && param_01 && var_03 % 20 == 0)
		{
			wait 0.05;
		}
	}

	if(isdefined(param_01) && param_01)
	{
		wait 0.05;
	}

	var_04 = getnodearray(param_00,"script_noteworthy");
	for(var_03 = 0;var_03 < var_04.size;var_03++)
	{
		var_04[var_03] disconnectnode();
		if(isdefined(param_01) && param_01 && var_03 % 20 == 0)
		{
			wait 0.05;
		}
	}

	if(isdefined(param_01) && param_01)
	{
		wait 0.05;
	}

	disconnectnodepairs(var_02,param_01);
	if(isdefined(param_01) && param_01)
	{
		wait 0.05;
	}

	disconnectnodepairs(var_04,param_01);
}

//Function Number: 53
connectnodes(param_00,param_01)
{
	var_02 = 0;
	var_03 = getnodearray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 connectnode();
		reconnectnodepairs(var_05);
		var_02++;
		if(isdefined(param_01) && param_01 && var_02 % 20 == 0)
		{
			wait 0.05;
		}
	}

	var_07 = getnodearray(param_00,"script_noteworthy");
	foreach(var_09 in var_07)
	{
		var_09 connectnode();
		reconnectnodepairs(var_09);
		var_02++;
		if(isdefined(param_01) && param_01 && var_02 % 20 == 0)
		{
			wait 0.05;
		}
	}
}

//Function Number: 54
reconnectnodepairs(param_00)
{
	if(isdefined(param_00.disconnections))
	{
		foreach(var_02 in param_00.disconnections)
		{
			connectnodepair(param_00,var_02);
		}
	}
}

//Function Number: 55
disconnectnodepairs(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		var_05 = [];
		var_05 = getlinkednodes(var_04,1);
		if(var_05.size > 0)
		{
			if(!isdefined(var_04.disconnections))
			{
				var_04.disconnections = [];
			}

			foreach(var_07 in var_05)
			{
				if(!isdefined(var_07.targetname) || var_07.targetname == "")
				{
					var_04.disconnections[var_04.disconnections.size] = var_07;
				}

				disconnectnodepair(var_04,var_07);
				var_02++;
				if(isdefined(param_01) && param_01 && var_02 % 20 == 0)
				{
					wait 0.05;
				}
			}
		}
	}
}

//Function Number: 56
patchaerialnodes()
{
	var_00 = [];
	var_00[var_00.size] = getnodearray("post_dynamic_event_pathnodes","script_noteworthy");
	var_00[var_00.size] = getnodearray("pre_dynamic_event_pathnodes","script_noteworthy");
	var_00[var_00.size] = getnodearray("post_dynamic_event_pathnodes","targetname");
	var_00[var_00.size] = getnodearray("pre_dynamic_event_pathnodes","targetname");
	foreach(var_02 in var_00)
	{
		foreach(var_04 in var_02)
		{
			var_04.forceenableaerialnode = 1;
		}
	}
}

//Function Number: 57
setupicebergdeath()
{
	if(isdefined(self.isjuggernaut) && self.isjuggernaut)
	{
		return;
	}

	self.prev_body = self.body;
	thread cleanupicebergdeath();
	self.prekilledfunc = ::onicebergdeath;
}

//Function Number: 58
cleanupicebergdeath()
{
	self endon("doneIcebergDeath");
	self endon("disconnect");
	common_scripts\utility::waittill_any("fracture_event_triggers_left","icebergMajorMotionComplete");
	self.prekilledfunc = undefined;
}

//Function Number: 59
onicebergdeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	thread onicebergdeath_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 60
onicebergdeath_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	self.prekilledfunc = undefined;
	waittillframeend;
	if(!isdefined(self.body) || isremovedentity(self.body) || isdefined(self.prev_body) && self.prev_body == self.body)
	{
		return;
	}

	var_0B = undefined;
	if(isdefined(param_04))
	{
		if(isexplosivedamagemod(param_04))
		{
			var_0B = 0.5;
		}
		else if(param_04 == "MOD_MELEE_ALT" && param_02 getstance() != "prone")
		{
			var_0B = 0.5;
		}
	}

	if(isdefined(var_0B))
	{
		wait(var_0B);
	}

	if(!isdefined(self.body) || isremovedentity(self.body))
	{
		return;
	}

	self.body startragdoll();
	self notify("doneIcebergDeath");
}

//Function Number: 61
fracturegoliathdeathhack()
{
	level endon("dynamic_event_complete");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		if(!isai(var_00))
		{
			var_00.prekilledfunc = ::fracturegoliathdeathhack_internal;
			var_00 thread fracturegoliathdeathhack_cleanup();
		}
	}
}

//Function Number: 62
fracturegoliathdeathhack_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(self.origin[1] > 480 && !isdefined(self.juggernautsuicide) && self.juggernautsuicide)
	{
		playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
		maps\mp\_snd_common_mp::snd_message("goliath_death_explosion");
		self.juggernautsuicide = 1;
		self.hideondeath = 1;
	}

	self.prekilledfunc = undefined;
	self notify("deathHackFinished");
}

//Function Number: 63
fracturegoliathdeathhack_cleanup()
{
	self endon("deathHackFinished");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","jugg_removed");
	self.prekilledfunc = undefined;
}
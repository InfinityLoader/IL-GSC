/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_ark_sq.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 242
 * Decompile Time: 3765 ms
 * Timestamp: 4/22/2024 2:19:05 AM
*******************************************************************/

//Function Number: 1
init_sidequest()
{
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("main",::init_main_sidequest,::sidequest_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage1",::stage1_init,::stage1_logic,::stage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage2",::stage2_init,::stage2_logic,::stage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("fishing",::init_fishing_sidequest,::sidequest_fishing_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("fishing","stage1",::fishing_stage1_init,::fishing_stage1_logic,::fishing_stage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("code1",::init_code1_sidequest,::sidequest_code1_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete,"code3");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1","stage1",::code1_stage1_init,::code1_stage1_logic,::code1_stage1_end,"code3");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1","stage2",::code1_stage2_init,::code1_stage2_logic,::code1_stage2_end,"code3");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1","stage3",::code1_stage3_init,::code1_stage3_logic,::code1_stage3_end,"code3");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1","stage4",::code1_stage4_init,::code1_stage4_logic,::code1_stage4_end,"code3");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("code2",::init_code2_sidequest,::sidequest_code2_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete,"code2");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code2","stage1",::code2_stage1_init,::code2_stage1_logic,::code2_stage1_end,"code2");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("code3",::init_code3_sidequest,::sidequest_code3_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3","stage1",::code3_stage1_init,::code3_stage1_logic,::code3_stage1_end,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3","stage2",::code3_stage2_init,::code3_stage2_logic,::code3_stage2_end,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3","stage3",::code3_stage3_init,::code3_stage3_logic,::code3_stage3_end,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3","stage4",::code3_stage4_init,::code3_stage4_logic,::code3_stage4_end,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3","stage5",::code3_stage5_init,::code3_stage5_logic,::code3_stage5_end,"code4");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("code4",::init_code4_sidequest,::sidequest_code4_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete,"code1");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code4","stage1",::code4_stage1_init,::code4_stage1_logic,::code4_stage1_end,"code1");
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("song",::init_song_sidequest,::sidequest_logic_song);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage1",::songstage1_init,::songstage1_logic,::songstage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage2",::songstage2_init,::songstage2_logic,::songstage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage3",::songstage3_init,::songstage3_logic,::songstage3_end);
	common_scripts\utility::flag_init("sq_plinko");
	level._effect["sq_island_timer"] = loadfx("vfx/unique/dlc_island_timer");
	level._effect["sq_dirt_dig"] = loadfx("vfx/gameplay/mp/zombie/dlc_sand_dig");
	level._effect["sq_fishing_splash"] = loadfx("vfx/water/dlc/water_fishing_splash");
	level._effect["sq_chum"] = loadfx("vfx/blood/dlc_zombie_blood_drip_chum");
	level._effect["sq_door_light_green"] = loadfx("vfx/gameplay/mp/zombie/dlc_engroom_light_green");
	level._effect["sq_door_light_red"] = loadfx("vfx/gameplay/mp/zombie/dlc_engroom_light_red");
	level._effect["dlc_prop_biometric_lock_on"] = loadfx("vfx/props/dlc_prop_biometric_lock_on");
	level._effect["dlc_prop_biometric_lock_pass"] = loadfx("vfx/props/dlc_prop_biometric_lock_pass");
	level._sidequest_counter_base_x = 110;
	level._sidequest_counter_base_y = -70;
	level.shouldignoreplayercallback = ::arkshouldignoreplayer;
	level thread onanyplayerspawned();
	level thread startarksidequest();
	level thread initvo();
	level thread weapondisposallogic();
	level thread runozextras();
}

//Function Number: 2
createfxhidesidquestents()
{
	if(getdvar("createfx") != "" || getdvar("r_reflectionProbeGenerate") == "1")
	{
		var_00 = getentarray("sqSecurityField","targetname");
		foreach(var_02 in var_00)
		{
			if(var_02.classname == "script_brushmodel")
			{
				var_02 hide();
			}
		}
	}
}

//Function Number: 3
onanyplayerspawned()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isdefined(var_00) && var_00 playerhasanyitem())
		{
			var_01 = inventoryitemgetid(var_00.inventoryitem);
			var_00 setclientomnvar("ui_zm_ee_int",var_01);
		}
	}
}

//Function Number: 4
startarksidequest()
{
	var_00 = common_scripts\utility::getstructarray("power_switch","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_flag) && var_02.script_flag == "zomboni_room")
		{
			var_02.noattract = 1;
		}
	}

	var_04 = getentarray("sqSecurityField","targetname");
	level.sqsecurityfieldbrushes = [];
	level.sqsecurityfieldtriggers = [];
	foreach(var_06 in var_04)
	{
		if(var_06.classname == "script_brushmodel")
		{
			level.sqsecurityfieldbrushes[level.sqsecurityfieldbrushes.size] = var_06;
			var_06 notsolid();
			var_06 hide();
			continue;
		}

		if(var_06.classname == "trigger_multiple")
		{
			level.sqsecurityfieldtriggers[level.sqsecurityfieldtriggers.size] = var_06;
		}
	}

	var_08 = getent("sqCageSwitch","targetname");
	if(isdefined(var_08))
	{
		var_08 hide();
	}

	var_09 = getent("sqPoolClip","targetname");
	if(isdefined(var_09))
	{
		var_09.origin = var_09.origin + (0,0,-1000);
	}

	var_0A = getent("sqPoolDoor1","targetname");
	if(isdefined(var_0A))
	{
		var_0A.unresolved_collision_func = ::maps\mp\_movers::unresolved_collision_void;
	}

	var_0B = getent("sqPoolDoor2","targetname");
	if(isdefined(var_0B))
	{
		var_0B.unresolved_collision_func = ::maps\mp\_movers::unresolved_collision_void;
	}

	var_0C = getent("sqArm","targetname");
	if(isdefined(var_0C))
	{
		var_0C hide();
	}

	var_0D = getent("sqIslandCrate2","targetname");
	if(isdefined(var_0D))
	{
		var_0D hide();
	}

	var_0E = getent("sqCode2","targetname");
	if(isdefined(var_0E))
	{
		var_0E hide();
	}

	var_0E = getent("sqCode3","targetname");
	if(isdefined(var_0E))
	{
		var_0E hide();
	}

	var_0F = getent("sqTeleporterLights","targetname");
	if(isdefined(var_0F))
	{
		level thread setupteleportlightmodel(var_0F,0);
	}

	var_10 = getentarray("sqTeleportLight","targetname");
	foreach(var_12 in var_10)
	{
		level thread setupteleportlight(var_12,0);
	}

	level.waterplayerhandledamagefunc = ::playerhandlewaterdamageark;
	level.gamemodeonunderwater = ::playerunderwater;
	level thread chumwaters();
	level thread setupsharkcage();
	wait(1);
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

//Function Number: 5
setupsharkcage()
{
	var_00 = common_scripts\utility::getstruct("shark_anim_node","targetname");
	var_01 = getent("sqCageModel","targetname");
	var_02 = getent("sqCrane","targetname");
	var_03 = getent("sqCage","targetname");
	var_04 = getent("sqCageDoorClip","targetname");
	var_05 = getent("sqCageDoorBottomClip","targetname");
	var_06 = getent("sqCageVolume","targetname");
	if(!isdefined(var_00) || !isdefined(var_01) || !isdefined(var_02) || !isdefined(var_03) || !isdefined(var_04) || !isdefined(var_05) || !isdefined(var_06))
	{
		return;
	}

	var_06 enablelinkto();
	var_06 vehicle_jetbikesethoverforcescale(var_01);
	var_04 vehicle_jetbikesethoverforcescale(var_01);
	var_05 vehicle_jetbikesethoverforcescale(var_01);
	var_03 vehicle_jetbikesethoverforcescale(var_01);
	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	wait 0.05;
	var_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_crane",var_00.origin,var_00.angles,"cageSequence");
	var_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_cage",var_00.origin,var_00.angles,"cageSequence");
	wait 0.05;
	var_07 = getnodesinradius(var_01.origin,300,0);
	var_03.unresolved_collision_nodes = var_07;
	var_04.unresolved_collision_nodes = var_07;
	var_05.unresolved_collision_nodes = var_07;
}

//Function Number: 6
initvo()
{
	wait 0.05;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq","dlc3_easter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","sq","sq_dlc3",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","weap_dis","weap_dis",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","weap_dis_prize","weap_dis_prize",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","weap_dis_cred","weap_dis_cred",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","sq","dlc3_easter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","sq","dlc3_easter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","weap_dis","weap_dis",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","weap_dis_cred","weap_dis_cred",undefined);
	if(!isdefined(level.sqarm))
	{
		level.sqarm = getent("sqArm","targetname");
	}

	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_zom","zombie_",level.sqarm,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","gimme","gimme",undefined,60);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","take","take",undefined,50);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","credits","credits",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","item","item",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","pain","pain",undefined,40);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom","machine_all_players","noise","noise",undefined,40);
}

//Function Number: 7
arkshouldignoreplayer(param_00)
{
	if(isdefined(level.zmplayerinzomboniroom) && level.zmplayerinzomboniroom == param_00)
	{
		return 1;
	}
	else if(isdefined(level.sqplayersteleporting) && level.sqplayersteleporting.size > 0 && common_scripts\utility::array_contains(level.sqplayersteleporting,param_00))
	{
		return 1;
	}
	else if(isdefined(param_00.onisland) && param_00.onisland)
	{
		return 1;
	}
	else if(param_00 playerisincage())
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
playerintoxicate(param_00,param_01)
{
	if(maps\mp\zombies\_util::isplayerinfected(self) || maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		return;
	}

	self endon("disconnect");
	self notify("playerIntoxicate");
	self endon("playerIntoxicate");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(!isdefined(param_01))
	{
		param_01 = 60;
	}

	thread maps\mp\mp_zombie_ark_aud::drink_rum();
	self.intoxicated = 1;
	self notify("update_ground_ref_ent");
	self setclientomnvar("ui_zm_ee_bool2",1);
	thread playerintoxicatedhandlemovement(param_01);
	thread playerintoxicatedrotateground(param_01);
	thread playerintoxicatedhandlescreen(param_01);
	thread playerintoxicatedhandlelaststand();
	updateintoxicatedentities();
	common_scripts\utility::waittill_notify_or_timeout("death",param_01);
	playerintoxicatefinish();
	self notify("playerIntociateComplete");
}

//Function Number: 9
playerintoxicatefinish()
{
	self setclientomnvar("ui_zm_ee_bool2",0);
	self.intoxicated = undefined;
	thread maps\mp\mp_zombie_ark_aud::rum_wears_off(self);
	updateintoxicatedentities();
	if(playerhasitem("rum"))
	{
		playertakeitem("rum");
	}
}

//Function Number: 10
playerintoxicatedhandlelaststand()
{
	self endon("playerIntociateComplete");
	self endon("death");
	self endon("disconnect");
	var_00 = common_scripts\utility::waittill_any_return_no_endon_death("player_infected","enter_last_stand");
	self notify("playerIntoxicate");
	thread playerintoxicatedhandlemovement(3);
	thread playerintoxicatedrotateground(3);
	if(var_00 == "enter_last_stand")
	{
		thread playerintoxicatedhandlescreen(3);
	}

	wait(3);
	playerintoxicatefinish();
}

//Function Number: 11
playerstopintoxication()
{
	if(maps\mp\zombies\_util::is_true(self.intoxicated))
	{
		thread playerintoxicate(undefined,3);
		thread maps\mp\mp_zombie_ark_aud::rum_wears_off(self);
	}
}

//Function Number: 12
stopallplayersintoxication()
{
	foreach(var_01 in level.players)
	{
		var_01 playerstopintoxication();
	}
}

//Function Number: 13
resetallplayersintoxication()
{
	foreach(var_01 in level.players)
	{
		var_01 playergiveitem("rum");
	}
}

//Function Number: 14
playerisintoxicated()
{
	return maps\mp\zombies\_util::is_true(self.intoxicated);
}

//Function Number: 15
playerintoxicatedhandlescreen(param_00)
{
	self endon("disconnect");
	self endon("player_infected");
	self notify("playerIntoxicatedHandleScreen");
	self endon("playerIntoxicatedHandleScreen");
	self visionsetpostapplyforplayer("mp_zombie_ark_intoxicated",1);
	self lightsetoverrideenableforplayer("mp_zombie_ark_intoxicated",1);
	common_scripts\utility::waittill_notify_or_timeout("death",param_00);
	self visionsetpostapplyforplayer("",1);
	self lightsetoverrideenableforplayer(1);
}

//Function Number: 16
playerintoxicatedhandlemovement(param_00)
{
	self endon("disconnect");
	self notify("playerIntoxicatedHandleMovement");
	self endon("playerIntoxicatedHandleMovement");
	if(!isdefined(self.exomovementoff))
	{
		maps\mp\zombies\_util::playerallowextendedsprint(0,"intoxicated");
		maps\mp\zombies\_util::playerallowlightweight(0,"intoxicated");
		maps\mp\_utility::playerallowdodge(0,"intoxicated");
		self.exomovementoff = 1;
		self.oldmovescaler = self.movespeedscaler;
		self.movespeedscaler = 0.75;
		maps\mp\gametypes\_weapons::updatemovespeedscale();
	}

	var_01 = gettime() + param_00 * 1000;
	var_02 = 5000;
	while(gettime() < var_01)
	{
		if(!isdefined(self.intoxicatedcanexotime) && self ishighjumping() || self isdodging() || self ispowersliding())
		{
			maps\mp\_utility::playerallowpowerslide(0,"intoxicated");
			self.intoxicatedcanexotime = gettime() + var_02;
			continue;
		}

		if(isdefined(self.intoxicatedcanexotime) && gettime() > self.intoxicatedcanexotime)
		{
			maps\mp\_utility::playerallowpowerslide(1,"intoxicated");
			self.intoxicatedcanexotime = undefined;
		}

		wait 0.05;
	}

	maps\mp\zombies\_util::playerallowextendedsprint(1,"intoxicated");
	maps\mp\zombies\_util::playerallowlightweight(1,"intoxicated");
	maps\mp\_utility::playerallowdodge(1,"intoxicated");
	if(isdefined(self.intoxicatedcanexotime))
	{
		maps\mp\_utility::playerallowhighjump(1,"intoxicated");
		maps\mp\_utility::playerallowpowerslide(1,"intoxicated");
		self.intoxicatedcanexotime = undefined;
	}

	self.movespeedscaler = self.oldmovescaler;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	self.oldmovescaler = undefined;
	self.exomovementoff = undefined;
}

//Function Number: 17
playerintoxicatedrotateground(param_00)
{
	self endon("disconnect");
	self notify("playerIntoxicatedRotateGround");
	self endon("playerIntoxicatedRotateGround");
	if(!isdefined(self.groundref))
	{
		self.groundref = spawn("script_model",(0,0,0));
	}

	self playersetgroundreferenceent(self.groundref);
	var_01 = 20;
	var_02 = 30;
	var_03 = 25;
	var_04 = 3;
	for(var_05 = int(param_00 / var_04);var_05 > 0;var_05--)
	{
		var_06 = randomfloatrange(-1 * var_01,var_01);
		var_07 = randomfloatrange(-1 * var_02,var_02);
		var_08 = randomfloatrange(-1 * var_03,var_03);
		var_09 = (var_06,var_07,var_08);
		var_0A = randomfloat(var_04 / 2);
		var_0B = randomfloat(var_04 / 2);
		if(var_05 == 1 || self getstance() == "prone")
		{
			var_09 = (0,0,0);
		}

		self.groundref rotateto(var_09,var_04,var_0A,var_0B);
		wait(var_04);
	}

	self playersetgroundreferenceent(undefined);
	self notify("update_ground_ref_ent");
	self.groundref.angles = (0,0,0);
}

//Function Number: 18
playerintoxicatedhudcountdown(param_00)
{
	self endon("disconnect");
	self notify("playerIntoxicatedHudCountdown");
	self endon("playerIntoxicatedHudCountdown");
	if(!isdefined(self.intoxicatedtimer))
	{
		self.intoxicatedtimer = maps\mp\gametypes\_hud_util::createfontstring("hudbig",1.5);
		self.intoxicatedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER TOP",undefined,0,20);
		self.intoxicatedtimer.sort = 3;
		self.intoxicatedtimer.label = &"ZOMBIES_INFECTED_TIMER";
	}

	if(param_00 > 0)
	{
		self.intoxicatedtimer settimer(param_00);
	}

	common_scripts\utility::waittill_notify_or_timeout("death",param_00);
	if(isdefined(self.intoxicatedtimer))
	{
		self.intoxicatedtimer destroy();
	}

	self.intoxicatedtimer = undefined;
}

//Function Number: 19
entitysetintoxicatedvisiononly(param_00)
{
	if(!isdefined(level.sqintoxicatedents))
	{
		level.sqintoxicatedents = [];
	}

	if(param_00)
	{
		level.sqintoxicatedents[level.sqintoxicatedents.size] = self;
	}
	else
	{
		level.sqintoxicatedents = common_scripts\utility::array_remove(level.sqintoxicatedents,self);
	}

	updateintoxicatedentities();
}

//Function Number: 20
updateintoxicatedentities()
{
	if(!isdefined(level.sqintoxicatedents))
	{
		level.sqintoxicatedents = [];
	}

	foreach(var_01 in level.sqintoxicatedents)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 hide();
		if(isdefined(level.players))
		{
			foreach(var_03 in level.players)
			{
				if(var_03 playerisintoxicated())
				{
					var_01 showtoplayer(var_03);
				}
			}
		}
	}
}

//Function Number: 21
weapondisposallogic()
{
	var_00 = getent("weaponDisposalUse","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getent("sqWeaponDisposalSign","targetname");
	if(isdefined(var_01))
	{
		var_01 hide();
	}

	level waittill("main_stage1_over");
	if(isdefined(var_01))
	{
		var_01 show();
	}

	var_00.angles = (0,0,0);
	setupweapontoitemmapping();
	if(!isdefined(level.sqarm))
	{
		level.sqarm = getent("sqArm","targetname");
		if(!isdefined(level.sqarm))
		{
			return;
		}
	}

	setuparmstates();
	level thread handlearm(var_00);
	for(;;)
	{
		for(var_02 = undefined;!isdefined(var_02);var_02 = waittillmachineused(var_00))
		{
			waittillarmready();
			wait(0.5);
		}

		var_03 = var_02 maps\mp\zombies\_wall_buys::getweaponslistprimariesminusalts();
		if(var_02 playerhasvalidweapon() && var_03.size > 1)
		{
			var_04 = var_02 getcurrentprimaryweapon();
			var_02 takeweapon(var_04);
			var_03 = var_02 maps\mp\zombies\_wall_buys::getweaponslistprimariesminusalts();
			foreach(var_06 in var_03)
			{
				if(var_06 != "" && var_06 != "none")
				{
					var_02 switchtoweapon(var_06);
				}
			}

			var_08 = getweaponbasename(var_04);
			var_09 = addweapontodisposallist(var_08);
			var_0A = maps\mp\zombies\_wall_buys::findholomodel(var_08);
			var_0B = spawn("script_model",(0,0,0));
			var_0B setmodel(var_0A);
			var_0B vehicle_jetbikesethoverforcescale(level.sqarm,"tag_weapon_right",(0,0,0),(0,0,0));
			level thread changearmstate("take",var_00);
			level.sqarm waittillmatch("item_swap","arm_notetrack");
			var_0C = getmodelforitem(var_09);
			if(isdefined(var_0C))
			{
				var_0B setmodel(var_0C);
				var_0D = getoriginoffsetforitem(var_09);
				var_0E = getanglesoffsetforitem(var_09);
				var_0B vehicle_jetbikesethoverforcescale(level.sqarm,"tag_weapon_right",var_0D,var_0E);
				var_0F = zombiearmplaysqvo("item");
			}
			else
			{
				var_0F = zombiearmplaysqvo("credits");
				var_0B delete();
			}

			level.sqarm waittillmatch("end","arm_notetrack");
			var_0F = 0;
			if(isdefined(var_0C))
			{
				var_0F = zombiearmplaysqvo("item");
			}
			else
			{
				var_0F = zombiearmplaysqvo("credits");
			}

			if(isdefined(var_09) && var_09 == "rum_bottle")
			{
				level thread launchrumbottle(var_0B);
			}
			else if(isdefined(var_0C))
			{
				var_0B delete();
			}

			if(isdefined(var_02))
			{
				var_02 thread playergiveweapondisposalprize(var_09,!var_0F);
			}
		}

		wait(1);
	}
}

//Function Number: 22
setuparmstates()
{
	level.const_sq_arm_idle = 0;
	level.const_sq_arm_thrash_enter = 1;
	level.const_sq_arm_thrash_exit = 2;
	level.const_sq_arm_thrash_loop = 3;
	level.const_sq_arm_thrash_to_gimme = 4;
	level.const_sq_arm_gimme_to_thrash = 5;
	level.const_sq_arm_pain = 6;
	level.const_sq_arm_pain_retreat = 7;
	level.const_sq_arm_gimme_loop = 8;
	level.const_sq_arm_take_weapon = 9;
	level.const_sq_arm_give_loop = 10;
	level.const_sq_arm_give_finish = 11;
	setarmtoidle();
}

//Function Number: 23
handlearm(param_00)
{
	var_01 = 1000;
	var_02 = 5;
	level.sqarm setmodel("zom_civ_ruban_male_r_arm_slice_scripted");
	level.sqarm setcandamage(1);
	level.sqarm setdamagecallbackon(1);
	level.sqarm.damagecallback = ::armdamaged;
	level.sqarm.health = 9999;
	level.sqarm.maxhealth = level.sqarm.health;
	level.sqarm.currentdamage = 0;
	level.sqarm thread armhandlehappiness();
	for(;;)
	{
		var_03 = level.sqarm common_scripts\utility::waittill_any_return_no_endon_death("handlePain","handleThrash","handleGimme","handleEnter","handleExit");
		var_04 = getarmstate();
		if(var_03 == "handlePain" && armstateislooping(var_04))
		{
			if(level.sqarm.currentdamage >= var_01)
			{
				changearmstate("painLeave",param_00);
				wait(var_02);
				changearmstate("enter",param_00);
				level.sqarm.currentdamage = 0;
			}
			else
			{
				changearmstate("pain",param_00);
			}

			continue;
		}

		if(var_03 == "handleEnter")
		{
			level.sqarm show();
			changearmstate("enter",param_00);
			continue;
		}

		if(var_03 == "handleExit")
		{
			changearmstate("exit",param_00);
			level.sqarm ghost();
			level.sqarm.currentdamage = 0;
			continue;
		}

		if(var_03 == "handleGimme")
		{
			changearmstate("gimme",param_00);
			continue;
		}

		if(var_03 == "handleThrash")
		{
			changearmstate("thrash",param_00);
		}
	}
}

//Function Number: 24
armdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_01) && isplayer(param_01))
	{
		self.currentdamage = self.currentdamage + param_02;
		self notify("handlePain");
	}
}

//Function Number: 25
armhandlehappiness()
{
	var_00 = 360000;
	var_01 = 22500;
	for(;;)
	{
		var_02 = getarmstate();
		if(armisidle(var_02))
		{
			foreach(var_04 in level.players)
			{
				if(maps\mp\zombies\_util::isplayerinlaststand(var_04) || !isalive(var_04))
				{
					continue;
				}

				var_05 = distancesquared(level.sqarm.origin,var_04.origin);
				if(var_05 <= var_00)
				{
					level.sqarm notify("handleEnter");
					break;
				}
			}
		}
		else if(armisthrashing(var_02))
		{
			doarmnoise();
			var_07 = 1;
			foreach(var_04 in level.players)
			{
				if(maps\mp\zombies\_util::isplayerinlaststand(var_04) || !isalive(var_04))
				{
					continue;
				}

				var_05 = distancesquared(level.sqarm.origin,var_04.origin);
				if(var_05 <= var_01)
				{
					level.sqarm notify("handleGimme");
					level thread doarmfirstseenvo(var_04);
					var_07 = 0;
					break;
				}
				else if(var_05 <= var_00)
				{
					var_07 = 0;
				}
			}

			if(var_07)
			{
				level.sqarm notify("handleExit");
			}
		}
		else if(armstateisready(var_02))
		{
			doarmnoise();
			var_07 = 1;
			foreach(var_04 in level.players)
			{
				if(maps\mp\zombies\_util::isplayerinlaststand(var_04) || !isalive(var_04))
				{
					continue;
				}

				var_05 = distancesquared(level.sqarm.origin,var_04.origin);
				if(var_05 <= var_01)
				{
					var_07 = 0;
					break;
				}
			}

			if(var_07)
			{
				level.sqarm notify("handleThrash");
			}
		}

		wait(1);
	}
}

//Function Number: 26
doarmnoise()
{
	if(!isdefined(level.sqarmfirstseenplayed))
	{
		return;
	}

	if(maps\mp\zombies\_zombies_audio_dlc3::anyplayersspeaking())
	{
		return;
	}

	if(!isdefined(level.sqarm.noisedebouncevo))
	{
		level.sqarm.noisedebouncevo = 0;
	}

	if(level.sqarm.noisedebouncevo < gettime())
	{
		level.sqarm.noisedebouncevo = gettime() + randomfloatrange(10,20) * 1000;
		zombiearmplaysqvo("noise");
	}
}

//Function Number: 27
doarmfirstseenvo(param_00)
{
	param_00 endon("disconnect");
	if(!isdefined(level.sqarmfirstseenplayed) && param_00 playerplaysqvo(14))
	{
		level.sqarmfirstseenplayed = 1;
		wait 0.05;
		waittilldonespeaking(param_00);
		zombiearmplaysqvo("gimme");
	}
}

//Function Number: 28
waittillmachineused(param_00)
{
	level.sqarm endon("pain");
	level.sqarm endon("thrash");
	var_01 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("arm_used",undefined,undefined,undefined,70,1);
	return var_01;
}

//Function Number: 29
waittillarmready()
{
	if(!armstateisready(level.sqarm.state))
	{
		level.sqarm waittill("gimme");
	}
}

//Function Number: 30
changearmstate(param_00,param_01)
{
	if(param_00 == "enter")
	{
		doarmanim(param_01,"zom_weap_arm_thrash_enter",level.const_sq_arm_thrash_enter,1);
		doarmanim(param_01,"zom_weap_arm_thrash_loop",level.const_sq_arm_thrash_loop,0);
		return;
	}

	if(param_00 == "exit")
	{
		doarmanim(param_01,"zom_weap_arm_thrash_exit",level.const_sq_arm_thrash_exit,1);
		setarmtoidle();
		return;
	}

	if(param_00 == "gimme")
	{
		doarmanim(param_01,"zom_weap_arm_thrash_to_gimme",level.const_sq_arm_thrash_to_gimme,1);
		doarmanim(param_01,"zom_weap_arm_gimme_loop",level.const_sq_arm_gimme_loop,0);
		level.sqarm notify("gimme");
		zombiearmplaysqvo("gimme");
		return;
	}

	if(param_00 == "thrash")
	{
		level.sqarm notify("thrash");
		doarmanim(param_01,"zom_weap_arm_gimme_to_thrash",level.const_sq_arm_gimme_to_thrash,1);
		doarmanim(param_01,"zom_weap_arm_thrash_loop",level.const_sq_arm_thrash_loop,0);
		return;
	}

	if(param_00 == "pain")
	{
		var_02 = getarmstate();
		var_03 = getarmanimref();
		level.sqarm notify("pain");
		var_04 = randomintrange(1,3);
		zombiearmplaysqvo("pain");
		doarmanim(param_01,"zom_weap_arm_pain_0" + var_04,level.const_sq_arm_pain,1);
		if(armstateisready(var_02))
		{
			doarmanim(param_01,"zom_weap_arm_thrash_to_gimme",level.const_sq_arm_thrash_to_gimme,1);
		}

		doarmanim(param_01,var_03,var_02,0);
		if(armstateisready(var_02))
		{
			level.sqarm notify("gimme");
			return;
		}

		return;
	}

	if(param_00 == "painLeave")
	{
		var_02 = getarmstate();
		level.sqarm notify("pain");
		var_04 = randomintrange(1,3);
		doarmanim(param_01,"zom_weap_arm_pain_retreat_0" + var_04,level.const_sq_arm_pain_retreat,1);
		setarmtoidle();
		return;
	}

	if(param_00 == "take")
	{
		zombiearmplaysqvo("take");
		doarmanim(param_01,"zom_weap_arm_take_weapon",level.const_sq_arm_take_weapon,1);
		var_04 = randomintrange(1,5);
		doarmanim(param_01,"zom_weap_arm_give_finish_0" + var_04,level.const_sq_arm_give_finish,1);
		doarmanim(param_01,"zom_weap_arm_gimme_loop",level.const_sq_arm_gimme_loop,0);
		level.sqarm notify("gimme");
		return;
	}
}

//Function Number: 31
armstateislooping(param_00)
{
	return param_00 == level.const_sq_arm_gimme_loop || param_00 == level.const_sq_arm_thrash_loop;
}

//Function Number: 32
armisidle(param_00)
{
	return param_00 == level.const_sq_arm_idle;
}

//Function Number: 33
armisthrashing(param_00)
{
	return param_00 == level.const_sq_arm_thrash_loop;
}

//Function Number: 34
armstateisready(param_00)
{
	return param_00 == level.const_sq_arm_gimme_loop;
}

//Function Number: 35
getarmstate()
{
	return level.sqarm.state;
}

//Function Number: 36
getarmanimref()
{
	return level.sqarm.animref;
}

//Function Number: 37
setarmtoidle()
{
	level.sqarm.state = level.const_sq_arm_idle;
	level.sqarm.animref = "";
}

//Function Number: 38
doarmanim(param_00,param_01,param_02,param_03)
{
	level.sqarm.state = param_02;
	level.sqarm.animref = param_01;
	level.sqarm scriptmodelplayanimdeltamotionfrompos(param_01,param_00.origin,param_00.angles,"arm_notetrack");
	if(param_03)
	{
		level.sqarm waittillmatch("end","arm_notetrack");
	}
}

//Function Number: 39
getmodelforitem(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "rum_bottle":
			return "zark_bottle_01";

		case "hook":
			return "zark_fishing_hook_01";

		case "line":
			return "zark_fishing_line_01";

		case "reel":
			return "zark_fishing_reel_01";

		case "c4":
			return "weapon_c4_mp";
	}
}

//Function Number: 40
getoriginoffsetforitem(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "rum_bottle":
			return (5,-1,0);

		case "hook":
			return (2,0,5);

		case "line":
			return (5,-2,1);

		case "reel":
			return (5,-2,1);

		case "c4":
			return (5,0,4);
	}
}

//Function Number: 41
getanglesoffsetforitem(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "rum_bottle":
			return (0,0,0);

		case "hook":
			return (0,0,90);

		case "line":
			return (0,0,0);

		case "reel":
			return (0,0,0);

		case "c4":
			return (0,0,90);
	}
}

//Function Number: 42
launchrumbottle(param_00)
{
	setitemascomplete("rum_bottle");
	thread maps\mp\mp_zombie_ark_aud::throw_rum_bottle(param_00);
	param_00 unlink();
	var_01 = (500,0,0);
	param_00 physicslaunchserver(param_00.origin,var_01);
	param_00 common_scripts\utility::waittill_notify_or_timeout("physics_finished",5);
	param_00 physicsstop();
	for(;;)
	{
		var_02 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("rum_used",undefined,undefined,undefined,40,1);
		var_02 playergiveitem("rum");
		wait(0.5);
	}
}

//Function Number: 43
playergiveweapondisposalprize(param_00,param_01)
{
	level notify("playerGiveWeaponDisposalPrize");
	level endon("playerGiveWeaponDisposalPrize");
	if(!isdefined(param_00))
	{
		maps\mp\gametypes\zombies::givepointsforevent("weapon_disposal",200,1);
		if(param_01)
		{
			announcerinworldplaysqvowaittilldone("weap_dis");
			announcerinworldplaysqvowaittilldone("weap_dis_cred");
			return;
		}

		return;
	}

	if(param_00 != "rum_bottle")
	{
		playergiveitem(param_00);
		thread maps\mp\mp_zombie_ark_aud::get_weapon_disposal_item(param_00);
	}

	if(param_01)
	{
		announcerinworldplaysqvowaittilldone("weap_dis");
		announcerinworldplaysqvowaittilldone("weap_dis_prize");
	}
}

//Function Number: 44
addweapontodisposallist(param_00)
{
	var_01 = 2;
	if(!common_scripts\utility::array_contains(level.sqweaponsdisposed,param_00))
	{
		level.sqweaponsdisposed[level.sqweaponsdisposed.size] = param_00;
		if(level.sqweaponsdisposed.size % var_01 == 0)
		{
			return getnextweapondisposalitem();
		}
	}
}

//Function Number: 45
getnextweapondisposalitem()
{
	for(var_00 = 0;var_00 < level.sqweapondisposalitems.size;var_00++)
	{
		var_01 = level.sqweapondisposalitems[var_00];
		if(!isitemcomplete(var_01) && !anyplayerhasitem(var_01))
		{
			return var_01;
		}
	}
}

//Function Number: 46
isitemcomplete(param_00)
{
	return common_scripts\utility::array_contains(level.sqitemscomplete,param_00);
}

//Function Number: 47
setitemascomplete(param_00)
{
	level.sqitemscomplete[level.sqitemscomplete.size] = param_00;
}

//Function Number: 48
setupweapontoitemmapping()
{
	level.sqweaponsdisposed = [];
	level.sqweapondisposalitems = [];
	level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "rum_bottle";
	level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "reel";
	level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "line";
	level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "hook";
	level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "c4";
	level.sqitemscomplete = [];
}

//Function Number: 49
playerhasvalidweapon()
{
	var_00 = self getcurrentprimaryweapon();
	return weaponisvalid(var_00);
}

//Function Number: 50
weaponisvalid(param_00)
{
	return param_00 != "" && param_00 != "none" && !maps\mp\zombies\_util::iszombiekillstreakweapon(param_00) && !maps\mp\zombies\_util::isrippedturretweapon(param_00) && !maps\mp\zombies\_util::iszombieequipment(param_00);
}

//Function Number: 51
playergiveitem(param_00)
{
	if(param_00 == "rum")
	{
		if(!maps\mp\zombies\_util::isplayerinfected(self) && !maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			thread playerintoxicate(0.5);
		}

		return;
	}

	if(!isdefined(self.sqplayedfoundfirstcode) && param_00 == "code" && playerplaysqvo(15))
	{
		self.sqplayedfoundfirstcode = 1;
	}

	if(isdefined(self.inventoryitem))
	{
		if(self.inventoryitem == "code")
		{
			return;
		}

		playertakeitem(self.inventoryitem);
	}

	self.inventoryitem = param_00;
	var_01 = inventoryitemgetid(param_00);
	self setclientomnvar("ui_zm_ee_int",var_01);
}

//Function Number: 52
playerhasitem(param_00)
{
	return isdefined(self.inventoryitem) && self.inventoryitem == param_00;
}

//Function Number: 53
playerhasanyitem()
{
	return isdefined(self.inventoryitem);
}

//Function Number: 54
playertakeitem(param_00)
{
	if(isdefined(self.inventoryitem) && self.inventoryitem == param_00)
	{
		self.inventoryitem = undefined;
		self setclientomnvar("ui_zm_ee_int",0);
	}
}

//Function Number: 55
inventoryitemgetid(param_00)
{
	switch(param_00)
	{
		case "code":
			return 1;

		case "shovel":
			return 2;

		case "c4":
			return 3;

		case "reel":
			return 4;

		case "hook":
			return 5;

		case "line":
			return 6;

		case "teleportEquipment":
			return 7;

		case "eye":
			return 8;

		case "fish":
			return 9;

		case "switch":
		default:
			return 10;
	}
}

//Function Number: 56
init_fishing_sidequest()
{
	setupfishingitems();
}

//Function Number: 57
sidequest_fishing_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("fishing","stage1");
	level waittill("fishing_stage1_over");
	var_00 = getent("sqPole2","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 setcursorhint("HINT_NOICON");
	for(;;)
	{
		var_00 sethintstring(&"ZOMBIE_ARK_SQ_FISH");
		var_00 setsecondaryhintstring(&"ZOMBIES_COST_100");
		var_00 makeusable();
		var_00 waittill("trigger",var_01);
		var_00 makeunusable();
		if(!var_01 maps\mp\gametypes\zombies::attempttobuy(100))
		{
			wait(1);
			continue;
		}

		var_01 thread maps\mp\mp_zombie_ark_aud::fishing_cast_line();
		var_00 scriptmodelplayanim("zark_fishing_pose_fish","fishing_notetrack");
		var_00 waittillmatch("attach_item","fishing_notetrack");
		var_01 thread maps\mp\mp_zombie_ark_aud::fishing_retrieve_line();
		level thread fishonsounds(var_01);
		var_02 = getrandomfishingitem();
		var_03 = putitemonhook(var_02,var_00);
		var_00 waittillmatch("item_reachable","fishing_notetrack");
		if(isdefined(var_01))
		{
			var_00 sethintstring(&"ZOMBIE_ARK_SQ_FISH_GRAB");
			var_00 setsecondaryhintstring("");
			var_00 makeusable();
			var_00.owner = var_01;
			var_00 sethintstringvisibleonlytoowner(1);
		}

		var_04 = waittillpickedupordonewiggling(var_00);
		var_00 scriptmodelplayanim("zark_fishing_pose_finish","fishing_notetrack");
		var_00 makeunusable();
		var_00 sethintstringvisibleonlytoowner(0);
		var_00.owner = undefined;
		if(!isdefined(var_04) && isdefined(var_01) && var_02.type != "junk")
		{
			if(var_02.type == "inventory")
			{
				var_01 playergiveitem(var_02.item);
				var_01 thread maps\mp\mp_zombie_ark_aud::fishing_grab_item(var_02.item);
			}
			else if(var_02.type == "credits")
			{
				var_01 maps\mp\gametypes\zombies::givepointsforevent("fishing",var_02.value,1);
				var_01 playlocalsound("interact_credit_machine");
			}
			else if(var_02.type == "ammo")
			{
				var_01 playergiveammo();
				var_01 thread maps\mp\mp_zombie_ark_aud::fishing_grab_item(var_02.item);
			}

			var_03 delete();
		}
		else
		{
			level thread launchanddelete(var_03,var_02,var_00);
			var_01 thread maps\mp\mp_zombie_ark_aud::fishing_drop_item();
		}

		var_00 waittillmatch("end","fishing_notetrack");
		var_00 scriptmodelplayanim("zark_fishing_pose_idle","fishing_notetrack");
		wait 0.05;
	}
}

//Function Number: 58
fishinghint()
{
	level endon("code1_stage2_over");
	level waittill("code1_stage1_over");
	var_00 = getent("sqPole2","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = 90000;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			var_04 = distancesquared(var_00.origin,var_03.origin);
			if(var_04 < var_01)
			{
				if(announcerozglobalplaysq(13))
				{
					break;
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 59
fishonsounds(param_00)
{
	var_01 = common_scripts\utility::getstruct("sqFishingSplash","targetname");
	if(isdefined(param_00) && !isdefined(param_00.sqfishinggotoneplayed))
	{
		param_00 playerplaysqvo(13,undefined,1);
		if(isdefined(param_00))
		{
			param_00.sqfishinggotoneplayed = 1;
		}
	}
	else
	{
		wait(1.5);
	}

	if(isdefined(var_01))
	{
		playfx(common_scripts\utility::getfx("sq_fishing_splash"),var_01.origin);
	}
}

//Function Number: 60
putitemonhook(param_00,param_01)
{
	var_02 = param_01 gettagorigin("tag_attach");
	var_03 = spawn("script_model",var_02);
	var_03 setmodel(param_00.model);
	var_03 linkto(param_01,"tag_attach",param_00.offset,param_00.angles);
	if(param_00.item == "fish")
	{
		var_03 thread fishwiggle();
	}

	return var_03;
}

//Function Number: 61
fishwiggle()
{
	wait 0.05;
	self scriptmodelplayanim("zark_red_herring_wiggle","wiggle_notetrack");
}

//Function Number: 62
playergiveammo()
{
	self endon("death");
	self endon("disconnect");
	var_00 = self getcurrentprimaryweapon();
	if(!weaponisvalid(var_00))
	{
		var_00 = undefined;
		var_01 = self getweaponslistprimaries();
		foreach(var_03 in var_01)
		{
			if(weaponisvalid(var_03))
			{
				var_00 = var_03;
				break;
			}
		}
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(issubstr(var_00,"em1"))
	{
		waittillframeend;
		var_05 = maps\mp\zombies\_util::playergetem1ammo();
		var_06 = maps\mp\gametypes\zombies::getem1maxammo();
		if(var_05 >= var_06)
		{
			return;
		}

		var_05 = getnewammoamount(var_05,var_06);
		maps\mp\zombies\_util::playerrecordem1ammo(var_05);
		maps\mp\gametypes\zombies::playerupdateem1omnvar();
		return;
	}

	var_05 = self setweaponammostock(var_06);
	var_06 = weaponmaxammo(var_05);
	if(var_05 < var_06)
	{
		var_05 = getnewammoamount(var_05,var_06);
		self setweaponammostock(var_00,var_05);
		return;
	}

	var_05 = self getweaponammoclip(var_00,"right");
	var_06 = weaponclipsize(var_00);
	if(var_05 < var_06)
	{
		var_05 = getnewammoamount(var_05,var_06);
		self setweaponammoclip(var_00,var_05,"right");
	}

	if(issubstr(var_00,"akimbo"))
	{
		var_05 = self getweaponammoclip(var_00,"left");
		if(var_05 < var_06)
		{
			var_05 = getnewammoamount(var_05,var_06);
			self setweaponammoclip(var_00,var_05,"left");
			return;
		}
	}
}

//Function Number: 63
getnewammoamount(param_00,param_01)
{
	var_02 = 0.1;
	var_03 = int(max(1,param_01 * var_02));
	if(param_00 + var_03 <= param_01)
	{
		param_00 = param_00 + var_03;
	}
	else if(param_00 < param_01)
	{
		param_00 = param_01;
	}

	return param_00;
}

//Function Number: 64
launchanddelete(param_00,param_01,param_02)
{
	param_00 unlink();
	var_03 = vectornormalize(param_00.origin - param_02.origin) * param_01.impulse;
	param_00 physicslaunchclient(param_02.origin,var_03);
	wait(2);
	param_00 delete();
}

//Function Number: 65
waittillpickedupordonewiggling(param_00)
{
	param_00 endon("trigger");
	param_00 waittillmatch("end","fishing_notetrack");
	return 1;
}

//Function Number: 66
setupfishingitems()
{
	level.sqfishingitem = [];
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("shovel","zark_tool_shovel_01","inventory",undefined,20,(-10,45,-60),(-2,5,-10.2),12);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("fish","zark_fish_red_herring_01_anim","inventory",undefined,20,(0,0,0),(0,0,0),9);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("boot","zark_rubber_boot_01","junk",undefined,5,(-20,90,0),(1,1,-14),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("arm","zom_civ_ruban_male_r_arm_phys","junk",undefined,200,(-90,0,0),(0,1,2),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("leg","zom_civ_ruban_male_r_leg_phys","junk",undefined,200,(-90,0,0),(0,0,7),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("head","zom_civ_urban_male_head_phys","junk",undefined,200,(-105,-105,0),(4,1,-5.3),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("vest","zark_life_vest_01","junk",undefined,1000,(0,-87,85),(2,0,-15),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("buoy","zark_buoy_01","junk",undefined,1000,(0,0,0),(2.2,0,-1.5),7);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("ammo","zark_grenadebag_01","ammo",undefined,20,(180,0,90),(0,2,-9),10);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits1","zark_money_01","credits",50,1000,(0,30,-20),(-2,0,-6.3),20);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits2","zark_money_01","credits",200,1000,(0,30,-20),(-2,0,-6.3),5);
	level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits3","zark_money_01","credits",500,1000,(0,30,-20),(-2,0,-6.3),2);
}

//Function Number: 67
addnewfishingitem(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.sqfishingitemsmaxweight))
	{
		level.sqfishingitemsmaxweight = 0;
	}

	var_08 = level.sqfishingitemsmaxweight;
	level.sqfishingitemsmaxweight = level.sqfishingitemsmaxweight + param_07;
	var_09 = level.sqfishingitemsmaxweight;
	var_0A = spawnstruct();
	var_0A.item = param_00;
	var_0A.model = param_01;
	var_0A.type = param_02;
	var_0A.startweight = var_08;
	var_0A.endweight = var_09;
	var_0A.value = param_03;
	var_0A.impulse = param_04;
	var_0A.angles = param_05;
	var_0A.offset = param_06;
	return var_0A;
}

//Function Number: 68
getrandomfishingitem()
{
	var_00 = randomfloat(level.sqfishingitemsmaxweight);
	foreach(var_02 in level.sqfishingitem)
	{
		if(var_00 >= var_02.startweight && var_00 < var_02.endweight)
		{
			return var_02;
		}
	}

	return level.sqfishingitem[randomint(level.sqfishingitem.size)];
}

//Function Number: 69
fishing_stage1_init()
{
}

//Function Number: 70
fishing_stage1_logic()
{
	var_00 = getent("sqPole2","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	while(!var_01 || !var_02 || !var_03)
	{
		var_05 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("poleUse");
		var_06 = 0;
		if(!var_02 && var_05 playerhasitem("reel"))
		{
			var_06 = 1;
			var_05 playertakeitem("reel");
			setitemascomplete("reel");
			var_05 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("reel");
			var_02 = 1;
			var_00 setmodel("zark_fishing_pole_reel_01");
		}

		if(var_02 && !var_01 && var_05 playerhasitem("line"))
		{
			var_06 = 1;
			var_05 playertakeitem("line");
			setitemascomplete("line");
			var_05 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("line");
			var_01 = 1;
			var_00 setmodel("zark_fishing_pole_reel_line_01");
		}

		if(var_02 && var_01 && !var_03 && var_05 playerhasitem("hook"))
		{
			var_06 = 1;
			var_05 playertakeitem("hook");
			setitemascomplete("hook");
			var_05 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("hook");
			var_03 = 1;
			var_00 setmodel("zark_fishing_gear_complete_01");
			var_00 scriptmodelplayanim("zark_fishing_pose_idle","fishing_notetrack");
		}

		if(var_06)
		{
			if(var_03 && var_02 && var_01)
			{
				var_05 playerplaysqvo(12);
			}

			var_04 = 1;
			continue;
		}

		if(!var_04)
		{
			var_05 playerplaysqvo(11);
			var_04 = 1;
		}

		wait(1);
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("fishing","stage1");
}

//Function Number: 71
fishing_stage1_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Fishing Pole Assembled");
}

//Function Number: 72
init_main_sidequest()
{
}

//Function Number: 73
sidequest_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage1");
	level waittill("main_stage1_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage2");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("fishing");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code4");
	level waittill("sidequest_code4_complete");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code2");
	level waittill("sidequest_code2_complete");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code1");
	level waittill("sidequest_code1_complete");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code3");
	level waittill("sidequest_code3_complete");
	level waittill("main_stage2_over");
}

//Function Number: 74
generic_stage_start()
{
}

//Function Number: 75
generic_stage_complete()
{
}

//Function Number: 76
complete_sidequest()
{
}

//Function Number: 77
stage1_init()
{
}

//Function Number: 78
stage1_logic()
{
	level.zmplayeraltteleport = ::zmplayeraltteleport;
	common_scripts\utility::flag_wait("zomboni_room");
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage1");
}

//Function Number: 79
zmplayeraltteleport(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::is_true(level.zmbsqobstaclecourserunning))
	{
		level notify("securityFieldTouched");
	}

	var_03 = getent("zomboni_room_volume","targetname");
	var_04 = getent("sqCageVolume","targetname");
	var_05 = 0;
	var_06 = 2;
	if(isdefined(level.zmplayerinzomboniroom) && self == level.zmplayerinzomboniroom)
	{
		return 1;
	}
	else if(isdefined(var_03) && ispointinvolume(param_00,var_03))
	{
		if(!common_scripts\utility::flag("zomboni_room") && !isdefined(level.zmplayerinzomboniroom))
		{
			var_07 = common_scripts\utility::getstructarray("zomboni_room_teleport","targetname");
			foreach(var_09 in var_07)
			{
				if(capsuletracepassed(var_09.origin + (0,0,5),15,60,self,1))
				{
					thread playerinzomboniroom(var_09);
					break;
				}

				var_05++;
				if(var_05 >= var_06)
				{
					wait 0.05;
					var_05 = 0;
				}
			}
		}

		return 1;
	}
	else if(isdefined(var_04) && ispointinvolume(param_00 + (0,0,10),var_04))
	{
		return 1;
	}

	return 0;
}

//Function Number: 80
playerinzomboniroom(param_00)
{
	level.zmplayerinzomboniroom = self;
	self setorigin(param_00.origin,1);
	self setplayerangles(param_00.angles);
	level thread announcerzomboniroom(self);
	wait(5);
	if(isdefined(self))
	{
		var_01 = common_scripts\utility::getstructarray("zomboni_teleport_out","targetname");
		var_02 = [];
		foreach(var_04 in var_01)
		{
			if(maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_04.script_noteworthy))
			{
				var_02[var_02.size] = var_04;
			}
		}

		maps\mp\zombies\_teleport::teleport_players_through_chute([self],0);
		thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
		playerteleporttoastructwait(var_02,1);
		playfx(common_scripts\utility::getfx("teleport_post_fx"),self.origin,anglestoforward(self.angles));
	}

	level.zmplayerinzomboniroom = undefined;
}

//Function Number: 81
announcerzomboniroom(param_00)
{
	announcerglobalplaysqvowaittilldone(1,undefined,[param_00]);
	wait(1);
	announcerglobalplaysqvowaittilldone(2,undefined,[param_00]);
}

//Function Number: 82
playerteleporttoastructwait(param_00,param_01)
{
	self endon("disconnect");
	var_02 = 2;
	var_03 = 0;
	var_04 = 0;
	var_05 = param_00[0];
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	for(;;)
	{
		foreach(var_07 in param_00)
		{
			if(playertryteleporttostruct(var_07))
			{
				return;
			}

			var_03++;
			if(var_03 >= var_02)
			{
				wait 0.05;
				var_03 = 0;
			}
		}

		if(isdefined(var_05) && param_01)
		{
			param_00 = getnodesinradiussorted(var_05.origin,200,0);
			var_05 = undefined;
		}
	}
}

//Function Number: 83
playertryteleporttostruct(param_00)
{
	if(capsuletracepassed(param_00.origin + (0,0,5),15,60,self))
	{
		self setorigin(param_00.origin,1);
		if(isdefined(param_00.angles))
		{
			self setplayerangles(param_00.angles);
		}

		thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(5);
		return 1;
	}

	return 0;
}

//Function Number: 84
stage1_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Zomboni room power on");
}

//Function Number: 85
stage2_init()
{
}

//Function Number: 86
stage2_logic()
{
	var_00 = common_scripts\utility::getstruct("sqEngineRoomDoor","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	alldoorlights();
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	for(;;)
	{
		wait(1);
		var_09 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("door_activated",undefined,undefined,"main_stage2_over",85);
		if(!var_02)
		{
			announcerozglobalplaysqwaittilldone(1);
			level thread announcerozglobalplaysq(6,randomintrange(10,15));
			var_02 = 1;
			continue;
		}
		else if(var_09 playerhasitem("code"))
		{
			var_09 playertakeitem("code");
			var_01++;
			var_0A = var_01 + 1;
			var_0B = common_scripts\utility::getstructarray("sqEngineRoomDoorFx" + var_0A,"targetname");
			foreach(var_0D in var_0B)
			{
				level thread turnondoorfx(var_0D);
			}

			var_09 thread maps\mp\mp_zombie_ark_aud::code_accepted();
			wait(0.5);
			var_0F = var_01 + 1;
			announcerozglobalplaysqwaittilldone(var_0F);
			if(var_01 == 3)
			{
				wait(1);
				level thread unlockspecialweaponupgrade();
				announcerglobalplaysqvowaittilldone(3);
			}

			if(var_0F == 2)
			{
				level thread announcerozglobalplaysq(16,randomintrange(10,15));
			}

			if(var_0F == 3)
			{
				level thread announcerozglobalplaysq(19,randomintrange(10,15));
			}

			if(var_0F == 4)
			{
				level thread announcerozglobalplaysq(11,randomintrange(10,15));
			}

			continue;
		}
		else if(var_01 == 4 && var_09 playerhasitem("c4"))
		{
			var_09 playertakeitem("c4");
			break;
		}

		playsoundatpos(var_00.origin,"ee_engine_door_locked");
		if(!var_03 || !var_04)
		{
			if(!var_03)
			{
				var_09 playerplaysqvo(1,0.5,1);
				var_03 = 1;
			}
			else if(!var_04)
			{
				var_09 playerplaysqvo(3,0.5,1);
				var_04 = 1;
			}

			continue;
		}

		if(var_01 == 1)
		{
			if(!var_05)
			{
				var_09 playerplaysqvo(4,0.5,1);
				var_05 = 1;
			}

			continue;
		}

		if(var_01 == 2)
		{
			if(!var_06)
			{
				var_09 playerplaysqvo(5,0.5,1);
				var_06 = 1;
			}

			continue;
		}

		if(var_01 == 3)
		{
			if(!var_07)
			{
				var_09 playerplaysqvo(6,0.5,1);
				var_07 = 1;
			}

			continue;
		}

		if(var_01 == 4)
		{
			if(!var_08)
			{
				var_09 playerplaysqvo(7,0.5,1);
				var_08 = 1;
			}

			continue;
		}
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage2");
}

//Function Number: 87
unlockspecialweaponupgrade()
{
	level notify("special_weapon_box_unlocked");
	var_00 = getent("sqUpgradeStationTop","targetname");
	if(isdefined(var_00))
	{
		var_01 = var_00.origin + (0,0,30);
		var_00 moveto(var_01,2,0.5,0.5);
	}

	var_02 = getent("sqUpgradeStationBottom","targetname");
	if(isdefined(var_02))
	{
		var_01 = var_02.origin + (0,0,-30);
		var_02 moveto(var_01,2,0.5,0.5);
	}
}

//Function Number: 88
alldoorlights()
{
	level.sqdoorfx = [];
	for(var_00 = 1;var_00 <= 5;var_00++)
	{
		var_01 = common_scripts\utility::getstructarray("sqEngineRoomDoorFx" + var_00,"targetname");
		foreach(var_03 in var_01)
		{
			var_03.fx = spawn("script_model",var_03.origin);
			var_03.fx setmodel("tag_origin");
			if(!isdefined(var_03.angles))
			{
				var_03.angles = (0,0,0);
			}

			var_03.fx.angles = var_03.angles;
			var_04 = "sq_door_light_red";
			if(var_00 == 1)
			{
				var_04 = "sq_door_light_green";
			}

			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_04),var_03.fx,"tag_origin");
		}
	}
}

//Function Number: 89
turnondoorfx(param_00)
{
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_door_light_red"),param_00.fx,"tag_origin");
	maps\mp\zombies\_util::waitnetworkframe();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_door_light_green"),param_00.fx,"tag_origin");
}

//Function Number: 90
stage2_end(param_00)
{
	level.endgamewaitfunc = ::endgamewaitcinematic;
	level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam,game["end_reason"]["zombies_completed"]);
	maps\mp\zombies\_zombies_music::changezombiemusic("victory");
	givesidequestachievement();
	set_side_quest_coop_data_ark();
	maps\mp\zombies\_util::writezombiestats();
}

//Function Number: 91
endgamewaitcinematic(param_00,param_01,param_02,param_03)
{
	addsoundsubmix("bink_mix");
	level.zombiegamepaused = 1;
	foreach(var_05 in level.players)
	{
		var_05 maps\mp\_utility::freezecontrolswrapper(1);
	}

	playcinematicforall("zombies_bg_dlc3_outro",1);
	wait(60);
}

//Function Number: 92
givesidequestachievement()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_EASTEREGG");
	}
}

//Function Number: 93
init_code1_sidequest()
{
}

//Function Number: 94
sidequest_code1_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("code1","stage1");
	level waittill("code1_stage1_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code1","stage2");
	level waittill("code1_stage2_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code1","stage3");
	level waittill("code1_stage3_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code1","stage4");
	level waittill("code1_stage4_over");
}

//Function Number: 95
code1_stage1_init()
{
	level.processenemykilledcodefunc = ::processenemykilledcode1;
	level.sqdroppedteleportequip = [];
}

//Function Number: 96
code1_stage1_logic()
{
	var_00 = common_scripts\utility::getstruct("sqTeleportMachineUse","targetname");
	var_01 = getent("sqTeleporterLights","targetname");
	var_02 = getentarray("sqTeleportLight","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	level.const_sq_teleporter_status_off = 0;
	level.const_sq_teleporter_status_broken = 1;
	level.const_sq_teleporter_status_repair = 2;
	level.const_sq_teleporter_status_on = 3;
	level.const_sq_teleporter_status_cooldown = 4;
	if(isdefined(var_01))
	{
		level thread setupteleportlightmodel(var_01,level.const_sq_teleporter_status_broken);
	}

	foreach(var_04 in var_02)
	{
		level thread setupteleportlight(var_04,level.const_sq_teleporter_status_broken);
	}

	level thread teleportmachinehint(var_00);
	var_06 = 20;
	var_07 = 0;
	while(var_07 < var_06)
	{
		var_08 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("machine_piece_placed",::playerhasteleportequipment);
		var_08 thread maps\mp\mp_zombie_ark_aud::teleporter_place_parts(var_07 + 1);
		var_08 playertakeitem("teleportEquipment");
		var_07++;
		if(isdefined(var_01))
		{
			if(var_07 < var_06)
			{
				setupteleportlightmodel(var_01,level.const_sq_teleporter_status_repair);
				foreach(var_04 in var_02)
				{
					level thread setupteleportlight(var_04,level.const_sq_teleporter_status_repair);
				}
			}

			continue;
		}

		var_0B = int(var_07 / var_06 * 100);
		iprintlnbold("Teleport machine " + var_0B + " percent repaired.");
		wait(0.5);
		wait 0.05;
	}

	thread maps\mp\mp_zombie_ark_aud::teleporter_repaired();
	maps\mp\zombies\_zombies_sidequests::stage_completed("code1","stage1");
}

//Function Number: 97
processenemykilledcode1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self))
	{
		return;
	}

	if(!maps\mp\zombies\_util::checkactivemutator("teleport"))
	{
		return;
	}

	if(isdefined(param_03) && param_03 == "MOD_SUICIDE")
	{
		return;
	}

	if(maps\mp\zombies\_util::istrapweapon(param_04))
	{
		return;
	}

	if(level.sqdroppedteleportequip.size >= 5)
	{
		return;
	}

	level thread dropteleportequip(self.origin);
}

//Function Number: 98
dropteleportequip(param_00)
{
	param_00 = param_00 + (0,0,10);
	var_01 = spawn("script_model",param_00);
	var_01.angles = (0,0,0);
	var_01 setmodel("dlc3_teleport_equipment");
	var_01 notsolid();
	var_02 = spawn("trigger_radius",param_00,0,32,32);
	var_01.trigger = var_02;
	level.sqdroppedteleportequip[level.sqdroppedteleportequip.size] = var_01;
	var_01 thread teleportequippickup();
	var_01 thread teleportequiptimer();
	var_01 scriptmodelplayanim("mp_dogtag_spin");
}

//Function Number: 99
teleportequippickup()
{
	self endon("deleted");
	var_00 = self.origin;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(isplayer(var_01) && var_01 playercanpickupteleportequipment())
		{
			var_01 playergiveitem("teleportEquipment");
			var_01 thread playerdoteleportpickupsound();
			thread removeteleportequip(self);
			return;
		}
	}
}

//Function Number: 100
playerdoteleportpickupsound()
{
	self playlocalsound("ee_teleport_pickup");
	if(!isdefined(level.sqplayedteleportequippickup) && playerplaysqvo(9,0.5))
	{
		level.sqplayedteleportequippickup = 1;
	}
}

//Function Number: 101
playercanpickupteleportequipment()
{
	if(playerhasitem("line") || playerhasitem("hook") || playerhasitem("reel") || playerhasitem("code") || playerhasitem("eye") || playerhasitem("teleportEquipment"))
	{
		return 0;
	}

	if(playerhasitem("shovel") && isdefined(level.sqtreasurefound))
	{
		return 0;
	}

	return 1;
}

//Function Number: 102
teleportequiptimer()
{
	self endon("deleted");
	wait(15);
	thread teleportequipstartflashing();
	wait(8);
	level thread removeteleportequip(self);
}

//Function Number: 103
teleportequipstartflashing()
{
	self endon("deleted");
	for(;;)
	{
		self ghost();
		wait(0.25);
		self show();
		wait(0.25);
	}
}

//Function Number: 104
removeteleportequip(param_00,param_01)
{
	param_00 notify("deleted");
	wait 0.05;
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
	if(!maps\mp\zombies\_util::is_true(param_01))
	{
		level.sqdroppedteleportequip = common_scripts\utility::array_removeundefined(level.sqdroppedteleportequip);
	}
}

//Function Number: 105
playerhasteleportequipment()
{
	return playerhasitem("teleportEquipment");
}

//Function Number: 106
teleportmachinehint(param_00)
{
	level endon("code1_stage1_over");
	var_01 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("machine_used");
	if(var_01 playerhasitem("teleportEquipment"))
	{
		return;
	}

	var_01 thread maps\mp\mp_zombie_ark_aud::teleporter_parts_missing();
	wait(2);
	var_01 playerplaysqvo(8);
}

//Function Number: 107
code1_stage1_end(param_00)
{
	level.processenemykilledcodefunc = undefined;
	foreach(var_02 in level.sqdroppedteleportequip)
	{
		level thread removeteleportequip(var_02,1);
	}

	level.sqdroppedteleportequip = undefined;
	level thread runteleportmachine();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Repaired Teleport Machine");
}

//Function Number: 108
runteleportmachine()
{
	level.sqtreasurefound = 0;
	level.sqtreasurepickedup = 0;
	var_00 = common_scripts\utility::getstructarray("sqIslandTeleport","script_noteworthy");
	var_01 = common_scripts\utility::getstruct("sqTeleportMachineUse","targetname");
	level.zmbsqteleportbackspots = common_scripts\utility::getstructarray("sqTeleportBack","targetname");
	var_02 = getent("sqTeleporterLights","targetname");
	var_03 = getentarray("sqTeleportLight","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	if(!isdefined(level.sqtreasure))
	{
		var_04 = common_scripts\utility::getstructarray("sqIslandDigPos","targetname");
		level.sqtreasure = var_04[randomint(var_04.size)];
		var_05 = bullettrace(level.sqtreasure.origin + (0,0,200),level.sqtreasure.origin + (0,0,-200),0);
		level.sqtreasure.origin = var_05["position"];
	}

	var_06 = [&"ZOMBIES_COST_100",&"ZOMBIES_COST_500",&"ZOMBIES_COST_1000"];
	var_07 = [100,500,1000];
	level.sqcostindex = 0;
	if(isdefined(var_02))
	{
		level thread setupteleportlightmodel(var_02,level.const_sq_teleporter_status_on);
	}

	foreach(var_09 in var_03)
	{
		level thread setupteleportlight(var_09,level.const_sq_teleporter_status_on);
	}

	wait(1);
	var_0B = spawn("script_model",var_01.origin);
	var_0B setmodel("tag_origin");
	var_0B setcursorhint("HINT_NOICON");
	var_0B makeusable();
	level thread doozislandtaunt();
	while(!level.sqtreasurefound || !level.sqtreasurepickedup)
	{
		level.sqcoststring = var_06[level.sqcostindex];
		level.sqcost = var_07[level.sqcostindex];
		var_0B sethintstring(&"ZOMBIE_ARK_SQ_TELEPORT");
		var_0B setsecondaryhintstring(level.sqcoststring);
		var_0B.cooldown = 0;
		if(isdefined(var_02))
		{
			level thread setupteleportlightmodel(var_02,level.const_sq_teleporter_status_on);
		}

		foreach(var_09 in var_03)
		{
			level thread setupteleportlight(var_09,level.const_sq_teleporter_status_on);
		}

		level thread resetcostonroundtransition(var_0B,var_06,var_07);
		for(;;)
		{
			var_0B waittill("trigger",var_0E);
			if(var_0E maps\mp\gametypes\zombies::attempttobuy(level.sqcost))
			{
				break;
			}

			wait(0.5);
		}

		if(isdefined(var_02))
		{
			playfxontag(common_scripts\utility::getfx("dlc_teleport_in"),var_02,"tag_fx");
			level thread setupteleportlightmodel(var_02,level.const_sq_teleporter_status_cooldown,1.5);
			foreach(var_09 in var_03)
			{
				level thread setupteleportlight(var_09,level.const_sq_teleporter_status_cooldown,1.5);
			}

			wait(0.3);
		}

		var_0B.cooldown = 1;
		var_0B sethintstring(&"ZOMBIES_CURE_COOLDOWN_HINT");
		var_0B setsecondaryhintstring("");
		if(level.sqcostindex + 1 < var_06.size)
		{
			level.sqcostindex++;
		}

		level.sqplayersteleporting = getplayersteleporting();
		maps\mp\zombies\_teleport::teleport_players_through_chute(level.sqplayersteleporting,0);
		thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time(level.sqplayersteleporting,0.75);
		for(var_11 = 0;var_11 < level.sqplayersteleporting.size;var_11++)
		{
			level.sqplayersteleporting[var_11] playerteleporttoisland(var_00[var_11]);
		}

		level.zmbsqteleportbackindex = 0;
		if(!level.sqtreasurefound)
		{
			foreach(var_0E in level.sqplayersteleporting)
			{
				var_0E thread playerdig();
			}
		}

		var_14 = level.sqplayersteleporting[0].origin;
		var_15 = common_scripts\utility::getstruct("sqIslandCenter","targetname");
		if(isdefined(var_15))
		{
			var_14 = var_15.origin;
		}

		level thread dotimereffect(var_14);
		wait(25);
		level notify("teleportBackFromIsland");
		foreach(var_0E in level.sqplayersteleporting)
		{
			if(isdefined(var_0E.digprompt))
			{
				var_0E.digprompt makeglobalunusable();
			}
		}

		maps\mp\zombies\_teleport::teleport_players_through_chute(level.sqplayersteleporting,0);
		thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time(level.sqplayersteleporting,0.75);
		for(var_11 = 0;var_11 < level.sqplayersteleporting.size;var_11++)
		{
			var_0E = level.sqplayersteleporting[var_11];
			if(!isdefined(var_0E) || !isalive(var_0E))
			{
				continue;
			}

			var_0E thread playerteleportfromisland(level.zmbsqteleportbackspots[level.zmbsqteleportbackindex]);
			level.zmbsqteleportbackindex++;
		}

		level thread doozislandtaunt2();
		level.sqplayersteleporting = undefined;
		wait(30);
		wait 0.05;
	}

	foreach(var_0E in level.players)
	{
		if(isdefined(var_0E.digprompt))
		{
			var_0E.digprompt delete();
		}
	}

	var_0B delete();
}

//Function Number: 109
doozislandtaunt2()
{
	if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedislandback))
	{
		if(announcerozglobalplaysq(14,1))
		{
			level.zmbaudioplayedislandback = 1;
		}
	}
}

//Function Number: 110
doozislandtaunt()
{
	var_00 = getent("sqTeleportTrigger","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01 playerhasitem("shovel"))
		{
			var_02 = 24;
			if(common_scripts\utility::cointoss())
			{
				var_02 = 25;
			}

			if(announcerozglobalplaysq(var_02))
			{
				return;
			}
		}
	}
}

//Function Number: 111
playerunderwater(param_00)
{
	if(maps\mp\zombies\_util::is_true(self.onisland))
	{
		thread playerwaterteleportbackinternal();
	}
}

//Function Number: 112
playerwaterteleportbackinternal()
{
	if(isdefined(level.sqplayersteleporting) && common_scripts\utility::array_contains(level.sqplayersteleporting,self))
	{
		self stopsound("ee_island_timer");
		level.sqplayersteleporting = common_scripts\utility::array_remove(level.sqplayersteleporting,self);
		maps\mp\zombies\_teleport::teleport_players_through_chute([self],0);
		thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
		thread playerteleportfromisland(level.zmbsqteleportbackspots[level.zmbsqteleportbackindex]);
		level.zmbsqteleportbackindex++;
	}
}

//Function Number: 113
dotimereffect(param_00)
{
	wait(5);
	playfx(common_scripts\utility::getfx("sq_island_timer"),param_00);
}

//Function Number: 114
resetcostonroundtransition(param_00,param_01,param_02)
{
	param_00 notify("resetCostOnRoundTransition");
	param_00 endon("resetCostOnRoundTransition");
	param_00 endon("death");
	level waittill("zombie_wave_started");
	if(!isdefined(param_00))
	{
		return;
	}

	level.sqcostindex = 0;
	level.sqcost = param_02[level.sqcostindex];
	level.sqcoststring = param_01[level.sqcostindex];
	if(!param_00.cooldown)
	{
		param_00 setsecondaryhintstring(level.sqcoststring);
	}
}

//Function Number: 115
setupteleportlightmodel(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	switch(param_01)
	{
		case 0:
			param_00 hidepart("TAG_FX_ON");
			param_00 showpart("TAG_FX_OFF");
			param_00 hidepart("TAG_FX_GLOW");
			break;

		case 4:
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin");
			break;

		case 1:
			param_00 hidepart("TAG_FX_ON");
			param_00 hidepart("TAG_FX_OFF");
			param_00 showpart("TAG_FX_GLOW");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin",0);
			break;

		case 2:
			param_00 showpart("TAG_FX_ON");
			param_00 hidepart("TAG_FX_OFF");
			param_00 hidepart("TAG_FX_GLOW");
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin",0);
			wait(0.5);
			param_00 hidepart("TAG_FX_ON");
			param_00 hidepart("TAG_FX_OFF");
			param_00 showpart("TAG_FX_GLOW");
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin",0);
			break;

		case 3:
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin",0);
			param_00 showpart("TAG_FX_ON");
			param_00 hidepart("TAG_FX_OFF");
			param_00 hidepart("TAG_FX_GLOW");
			break;
	}
}

//Function Number: 116
setupteleportlight(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	switch(param_01)
	{
		case 0:
			param_00 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloroff());
			param_00 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityoff());
			break;

		case 4:
		case 1:
			param_00 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcolorstandby());
			param_00 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensitystandby());
			break;

		case 2:
			param_00 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloron());
			param_00 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityon());
			wait(0.5);
			param_00 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcolorstandby());
			param_00 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensitystandby());
			break;

		case 3:
			param_00 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloron());
			param_00 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityon());
			break;
	}
}

//Function Number: 117
runteleporterlight(param_00)
{
	param_00 setlightcolor((1,0,0));
	self waittill("teleportReady");
	param_00 setlightcolor((0.501,1,1));
}

//Function Number: 118
playerteleporttoisland(param_00)
{
	self setorigin(param_00.origin,1);
	if(isdefined(param_00.angles))
	{
		self setplayerangles(param_00.angles);
	}

	self.onisland = 1;
	self method_856B(0);
	self notify("update_ground_ref_ent");
	playfx(common_scripts\utility::getfx("teleport_post_fx"),self.origin,anglestoforward(self.angles));
	thread maps\mp\mp_zombie_ark_aud::island_timer_start();
}

//Function Number: 119
playerteleportfromisland(param_00)
{
	self.onisland = undefined;
	self method_856B(1);
	self notify("update_ground_ref_ent");
	if(!playertryteleporttostruct(param_00))
	{
		var_01 = getnodesinradiussorted(param_00.origin,200,0);
		playerteleporttoastructwait(var_01,0);
	}

	playfx(common_scripts\utility::getfx("teleport_post_fx"),self.origin,anglestoforward(self.angles));
}

//Function Number: 120
playerdig()
{
	level endon("teleportBackFromIsland");
	level endon("treasureFound");
	if(!maps\mp\zombies\_util::is_true(level.sqshovelhint))
	{
		level.sqshovelhint = 1;
		wait(2);
		playerplaysqvo(10);
	}

	if(!playerhasitem("shovel"))
	{
		return;
	}

	if(!isdefined(self.digprompt))
	{
		self.digprompt = spawn("script_model",self.origin);
		self.digprompt hide();
		self.digprompt showtoplayer(self);
		self.digprompt setcursorhint("HINT_NOICON");
		self.digprompt sethintstring(&"ZOMBIE_ARK_SQ_DIG");
	}

	for(;;)
	{
		var_00 = self geteye();
		var_01 = anglestoforward(self getplayerangles());
		var_02 = var_00 + var_01 * 70;
		var_03 = bullettrace(var_00,var_02,0,self);
		if(var_03["fraction"] == 1 || !isdefined(var_03["surfacetype"]) || var_03["surfacetype"] != "sand")
		{
			if(maps\mp\zombies\_util::is_true(self.digprompt.usable))
			{
				self.digprompt makeglobalunusable();
				self.digprompt.usable = 0;
			}
		}
		else
		{
			if(!maps\mp\zombies\_util::is_true(self.digprompt.usable))
			{
				self.digprompt makeglobalusable(-100,self);
				self.digprompt.usable = 1;
			}

			if(self usebuttonpressed())
			{
				self.digprompt makeglobalunusable();
				self.digprompt.usable = 0;
				var_04 = var_03["position"];
				playfx(common_scripts\utility::getfx("sq_dirt_dig"),var_04);
				var_05 = distance2dsquared(var_04,level.sqtreasure.origin);
				thread maps\mp\mp_zombie_ark_aud::dig();
				if(var_05 < 1024)
				{
					level.sqtreasure.origin = var_04;
					level notify("treasureFound",self);
					return;
				}

				wait(1);
				self.digprompt makeglobalusable(-100,self);
				self.digprompt.usable = 1;
			}
		}

		wait 0.05;
	}
}

//Function Number: 121
findtreasure(param_00)
{
	level endon("code1_stage4_over");
	level.sqtreasurefound = 1;
	var_01 = getent("sqIslandCrate2","targetname");
	var_02 = getent("sqCode3","targetname");
	var_03 = param_00.origin - level.sqtreasure.origin;
	var_04 = (0,vectortoyaw(var_03),0);
	var_05 = level.sqtreasure.origin + (0,0,-10);
	if(!isdefined(var_01))
	{
		var_01 = spawn("script_model",var_05);
		var_01 setmodel("zark_tablet_chest_anim");
		var_01.targetname = "sqIslandCrate2";
		var_01.angles = var_04;
		if(isdefined(var_02))
		{
			var_02 show();
			var_02.origin = var_01.origin + (0.5,0,2);
			var_02.angles = var_01.angles;
			var_02 vehicle_jetbikesethoverforcescale(var_01);
		}
	}
	else
	{
		var_01 show();
		var_01 thread maps\mp\mp_zombie_ark_aud::treasure_found();
		if(isdefined(var_02))
		{
			var_02 show();
			var_02 vehicle_jetbikesethoverforcescale(var_01);
		}

		var_01 dontinterpolate();
		var_01.origin = var_05;
		var_01.angles = var_04;
	}

	wait 0.05;
	var_01 scriptmodelplayanim("zark_tablet_chest_closed_loop","chest_notetrack");
	var_06 = playerphysicstraceinfo(var_01.origin + (0,0,20),var_01.origin,param_00);
	var_07 = var_01.origin + (0,0,20);
	if(var_06["fraction"] > 0)
	{
		var_07 = (var_01.origin[0],var_01.origin[1],var_06["position"][2] + 1);
	}

	wait 0.05;
	var_01 moveto(var_07,0.2,0.1,0.1);
	wait(0.2);
	var_01 physicslaunchserver(var_01.origin,(0,0,-1));
	var_01 common_scripts\utility::waittill_notify_or_timeout("physics_finished",0.5);
	var_01 physicsstop();
	var_01 scriptmodelplayanim("zark_tablet_chest_closed_loop","chest_notetrack");
	wait(1);
	param_00 = var_01 maps\mp\zombies\_zombies_sidequests::fake_use("chest_opened");
	param_00 thread maps\mp\mp_zombie_ark_aud::treasure_opened();
	var_01 scriptmodelplayanim("zark_tablet_chest_open","chest_notetrack");
	var_01 waittillmatch("end","chest_notetrack");
	var_01 scriptmodelplayanim("zark_tablet_chest_open_loop","chest_notetrack");
	if(isdefined(var_02))
	{
		wait(1.5);
		param_00 = var_02 maps\mp\zombies\_zombies_sidequests::fake_use("got_code",::playernotholdingcode);
		var_02 hide();
	}

	param_00 playergiveitem("code");
	param_00 thread maps\mp\mp_zombie_ark_aud::got_code();
	foreach(param_00 in level.players)
	{
		param_00 maps\mp\gametypes\zombies::givepointsforevent("sq_code1",2000,1);
	}

	level.sqtreasurepickedup = 1;
}

//Function Number: 122
getplayersteleporting()
{
	var_00 = [];
	var_01 = getent("sqTeleportTrigger","targetname");
	if(isdefined(var_01))
	{
		foreach(var_03 in level.players)
		{
			if(var_03 istouching(var_01) && !var_03 isjumping() && !var_03 ishighjumping() && !var_03 ishighjumping())
			{
				var_00[var_00.size] = var_03;
			}
		}
	}
	else
	{
		var_00 = level.players;
	}

	return common_scripts\utility::array_randomize(var_00);
}

//Function Number: 123
code1_stage2_init()
{
}

//Function Number: 124
code1_stage2_logic()
{
	while(!anyplayerhasshovel())
	{
		wait 0.05;
	}

	wait(1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("code1","stage2");
}

//Function Number: 125
anyplayerhasitem(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 playerhasitem(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 126
anyplayerhasshovel()
{
	return anyplayerhasitem("shovel");
}

//Function Number: 127
code1_stage2_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found the shovel");
}

//Function Number: 128
code1_stage3_init()
{
}

//Function Number: 129
code1_stage3_logic()
{
	level waittill("treasureFound",var_00);
	level thread findtreasure(var_00);
	maps\mp\zombies\_zombies_sidequests::stage_completed("code1","stage3");
}

//Function Number: 130
code1_stage3_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found the treasure");
}

//Function Number: 131
code1_stage4_init()
{
}

//Function Number: 132
code1_stage4_logic()
{
	while(!level.sqtreasurepickedup)
	{
		wait 0.05;
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("code1","stage4");
}

//Function Number: 133
code1_stage4_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retreived code from the chest");
}

//Function Number: 134
init_code2_sidequest()
{
}

//Function Number: 135
sidequest_code2_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("code2","stage1");
	level waittill("code2_stage1_over");
}

//Function Number: 136
code2_stage1_init()
{
}

//Function Number: 137
code2_stage1_logic()
{
	var_00 = getent("sqSecurityButton","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	level thread runobstaclecourse();
	var_00 waittill("courseCompleted");
	maps\mp\zombies\_zombies_sidequests::stage_completed("code2","stage1");
}

//Function Number: 138
runobstaclecourse()
{
	var_00 = getent("sqSecurityButton","targetname");
	var_01 = getent("sqCode2","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),var_00,"tag_origin");
	wait(1);
	var_03 = 120;
	if(level.players.size > 1)
	{
		var_03 = var_03 * 2;
	}

	for(;;)
	{
		for(;;)
		{
			var_00 maps\mp\zombies\_zombies_sidequests::fake_use("button_pressed",undefined,undefined,"sqCourseStart");
			var_04 = allplayersinzone("biomed");
			if(var_04)
			{
				setomnvar("ui_zm_ee_bool",0);
				level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_ee_int2",gettime() + var_03 * 1000);
				foreach(var_06 in level.players)
				{
					if(var_06 playerisintoxicated())
					{
						var_06 thread playerintoxicate(undefined,var_03);
					}

					var_06 playlocalsound("ee_obstacle_course_on");
				}

				thread maps\mp\mp_zombie_ark_aud::start_obstacle_course();
				level thread maps\mp\zombies\_teleport::teleporter_disable_all();
				break;
			}
			else
			{
				setomnvar("ui_zm_ee_int2",0);
				level notify("ui_zm_ee_int2_cancel");
				thread maps\mp\mp_zombie_ark_aud::stop_obstacle_course();
			}

			wait(1);
		}

		foreach(var_09 in level.sqsecurityfieldbrushes)
		{
			var_09 entitysetintoxicatedvisiononly(1);
		}

		var_00 thread securitybuttonswitchfxon();
		if(isdefined(var_01))
		{
			var_01 show();
		}

		level thread doobstaclecoursevo();
		var_0B = securityfieldlogic(var_01,var_03);
		level thread delayenableteleporters();
		foreach(var_09 in level.sqsecurityfieldbrushes)
		{
			var_09 entitysetintoxicatedvisiononly(0);
			var_09 hide();
		}

		if(var_0B)
		{
			var_00 notify("courseCompleted");
			stopallplayersintoxication();
			thread maps\mp\mp_zombie_ark_aud::obstacle_course_complete();
		}
		else
		{
			foreach(var_06 in level.players)
			{
				var_06 playlocalsound("ee_obstacle_course_fail");
			}

			thread maps\mp\mp_zombie_ark_aud::stop_obstacle_course();
		}

		var_00 thread securitybuttonswitchfxoff();
		wait(1);
	}
}

//Function Number: 139
doobstaclecoursevo()
{
	level thread doobstaclecourselavavo();
	level thread doobstaclecoursecrouchvo();
	level thread doobstaclecoursemazevo();
}

//Function Number: 140
doobstaclecourselavavo()
{
	level endon("sq_obstacle_course_complete");
	if(maps\mp\zombies\_util::is_true(level.zmbsqplayedlavavo))
	{
		return;
	}

	var_00 = getent("sqTriggerEnterCargo","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01) || !var_01 playerisintoxicated())
		{
			continue;
		}

		if(var_01 playerplaysqvo(17) || var_01 playerplaysqvo(18))
		{
			level.zmbsqplayedlavavo = 1;
			var_00 delete();
			return;
		}
	}
}

//Function Number: 141
doobstaclecoursecrouchvo()
{
	level endon("sq_obstacle_course_complete");
	if(maps\mp\zombies\_util::is_true(level.zmbsqplayedcrouchvo))
	{
		return;
	}

	var_00 = getent("sqTriggerEnterLift","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01) || !var_01 playerisintoxicated())
		{
			continue;
		}

		if(var_01 playerplaysqvo(20))
		{
			level.zmbsqplayedcrouchvo = 1;
			var_00 delete();
			return;
		}
	}
}

//Function Number: 142
doobstaclecoursemazevo()
{
	level endon("sq_obstacle_course_complete");
	if(maps\mp\zombies\_util::is_true(level.zmbsqplayedmazevo))
	{
		return;
	}

	var_00 = getent("sqTriggerEnterPool","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01) || !var_01 playerisintoxicated())
		{
			continue;
		}

		if(var_01 playerplaysqvo(21))
		{
			level.zmbsqplayedmazevo = 1;
			var_00 delete();
			return;
		}
	}
}

//Function Number: 143
delayenableteleporters()
{
	wait(1);
	maps\mp\zombies\_teleport::teleporter_enable_all();
}

//Function Number: 144
allplayersinzone(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(isalive(var_03))
		{
			var_01++;
		}
	}

	return maps\mp\zombies\_zombies_zone_manager::getnumberofplayersinzone(param_00) == var_01;
}

//Function Number: 145
securityfielddetecttouched()
{
	level endon("code2_stage1_over");
	level endon("sq_obstacle_course_complete");
	waittillframeend;
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			foreach(var_03 in level.sqsecurityfieldtriggers)
			{
				if(var_01 istouching(var_03))
				{
					level notify("securityFieldTouched");
					return;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 146
securityfieldlogic(param_00,param_01)
{
	var_02 = gettime();
	level.zmbsqobstaclecourserunning = 1;
	level thread securityfielddetecttouched();
	level thread coursetimer(param_01);
	var_03 = waittillcoursecomplete(param_00);
	level notify("sq_obstacle_course_complete");
	level.zmbsqobstaclecourserunning = undefined;
	param_00 hide();
	var_04 = gettime();
	var_05 = var_04 - var_02;
	level thread doobstaclecoursetime(var_03,var_05);
	if(isdefined(var_03))
	{
		if(!maps\mp\zombies\_util::is_true(level.sqgotobstaclecoursecode))
		{
			var_03 playergiveitem("code");
			var_03 thread maps\mp\mp_zombie_ark_aud::got_code();
			level.sqgotobstaclecoursecode = 1;
		}

		return 1;
	}

	playfx(common_scripts\utility::getfx("teleport_equipment"),param_00.origin);
	return 0;
}

//Function Number: 147
coursetimer(param_00)
{
	level endon("code2_stage1_over");
	level endon("sq_obstacle_course_complete");
	wait(param_00);
	level notify("sq_obstacle_course_time");
}

//Function Number: 148
doobstaclecoursetime(param_00,param_01)
{
	if(isdefined(param_00))
	{
		setomnvar("ui_zm_ee_bool",1);
		setomnvar("ui_zm_ee_int2",param_01);
		if(param_00 playerhasitem("fish"))
		{
			level thread dorewardsplash(param_01,param_00);
		}

		wait(5);
	}

	setomnvar("ui_zm_ee_int2",0);
}

//Function Number: 149
dorewardsplash(param_00,param_01)
{
	var_02 = param_00 / 1000;
	if(var_02 < 60)
	{
		maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_gold");
		var_03 = param_01 getcoopplayerdatareservedint("eggData");
		var_03 = var_03 | 16;
		param_01 setcoopplayerdatareservedint("eggData",var_03);
		return;
	}

	if(var_02 < 75)
	{
		maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_silver");
		return;
	}

	if(var_02 < 90)
	{
		maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_bronze");
		return;
	}
}

//Function Number: 150
playernotholdingcode()
{
	return !playerhasitem("code");
}

//Function Number: 151
waittillcoursecomplete(param_00)
{
	level endon("securityFieldTouched");
	level endon("sq_obstacle_course_time");
	var_01 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("got_code",::playernotholdingcode,undefined,"securityFieldTouched");
	return var_01;
}

//Function Number: 152
securitybuttonswitchfxon()
{
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),self,"tag_origin");
	wait(1);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"),self,"tag_origin");
}

//Function Number: 153
securitybuttonswitchfxoff()
{
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"),self,"tag_origin");
	wait(1);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"),self,"tag_origin");
}

//Function Number: 154
code2_stage1_end(param_00)
{
	setitemascomplete("rum");
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed the obstacle course & got code.");
}

//Function Number: 155
init_code3_sidequest()
{
}

//Function Number: 156
sidequest_code3_logic()
{
	maps\mp\zombies\_zombies_sidequests::stage_start("code3","stage1");
	level waittill("code3_stage1_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code3","stage2");
	level waittill("code3_stage2_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code3","stage3");
	level waittill("code3_stage3_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code3","stage4");
	level waittill("code3_stage4_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("code3","stage5");
	level waittill("code3_stage5_over");
}

//Function Number: 157
code3_stage1_init()
{
}

//Function Number: 158
code3_stage1_logic()
{
	var_00 = getent("sqLocker1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = spawnstruct();
	var_01.origin = (65,-496,1023);
	var_02 = var_01 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed",undefined,undefined,"code3_stage1_over",80);
	playsoundatpos(var_01.origin,"ee_locker_locked");
	var_02 playerplaysqvo(22,0.5);
	maps\mp\zombies\_zombies_sidequests::stage_completed("code3","stage1");
}

//Function Number: 159
code3_stage1_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found locker.");
}

//Function Number: 160
code3_stage2_init()
{
	level thread dosharkhint();
}

//Function Number: 161
dosharkhint()
{
	level endon("code3_stage3_over");
	var_00 = getent("sqLocker1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = spawnstruct();
	var_01.origin = (65,-496,1023);
	var_02 = var_01 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed",undefined,undefined,"code3_stage1_over",80);
	playsoundatpos(var_01.origin,"ee_locker_locked");
	var_02 playerplaysqvo(23,0.5);
	level thread announcerozglobalplaysq(12,randomintrange(10,15));
}

//Function Number: 162
code3_stage2_logic()
{
	for(;;)
	{
		level waittill("zombie_ammo_drone_spawn",var_00,var_01,var_02);
		level thread waitspawnsqdrone(var_00,var_01,var_02);
	}
}

//Function Number: 163
waitspawnsqdrone(param_00,param_01,param_02)
{
	var_03 = getsqdronestartnode(param_01,param_02);
	if(!isdefined(var_03))
	{
		return;
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	level.ammodrone2 = maps\mp\zombies\zombie_ammo_drone::spawnammodrone(var_03.origin,(0,0,0));
	if(!isdefined(level.ammodrone2))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return;
	}

	level.ammodrone2.startzone = param_01;
	level.ammodrone2.linegunignore = 1;
	level thread maps\mp\zombies\zombie_ammo_drone::waittillactivate(level.ammodrone2,param_01);
	level waittill("zombie_ammo_drone_activate",param_00,var_04,var_05);
	var_06 = maps\mp\zombies\zombie_ammo_drone::getdestinationzone(param_01,var_04);
	var_07 = maps\mp\zombies\zombie_ammo_drone::getdestinationnode(var_06,var_03);
	level.ammodrone2.endnode = var_07;
	level.ammodrone2.endzone = var_06;
	level thread maps\mp\zombies\zombie_ammo_drone::droneactivate(level.ammodrone2,var_06,var_07,0);
	var_08 = level.ammodrone2 dronewaittilldropswitch();
	level.ammodrone2 = undefined;
	if(isdefined(var_08))
	{
		var_08 scriptmodelplayanim("zark_electricpanel_switch_pickup_spin","switch_notetrack");
		var_08 thread switchpickup();
	}
}

//Function Number: 164
dronewaittilldropswitch()
{
	self endon("explode");
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("zark_electricpanel_switch_01_anim");
	var_00 hudoutlineenable(2,0);
	var_00 linkto(self,"tag_origin",(0,0,20),(0,0,0));
	thread dronesqcleanupswitch(var_00);
	self waittill("disabled",var_01);
	if(isdefined(self.lastgroundposition))
	{
		var_01 = self.lastgroundposition;
	}

	if(!isdefined(var_01))
	{
		var_01 = self.origin;
	}

	var_00 unlink();
	var_00.origin = var_01;
	return var_00;
}

//Function Number: 165
switchpickup()
{
	self endon("deleted");
	self.trigger = spawn("trigger_radius",self.origin,0,32,32);
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			var_00 playergiveitem("switch");
			var_00 thread maps\mp\mp_zombie_ark_aud::switch_pickup();
			maps\mp\zombies\_zombies_sidequests::stage_completed("code3","stage2");
			level thread removeswitch(self);
			return;
		}
	}
}

//Function Number: 166
removeswitch(param_00)
{
	param_00 notify("deleted");
	wait 0.05;
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
}

//Function Number: 167
dronesqcleanupswitch(param_00)
{
	self endon("disabled");
	self waittill("explode");
	param_00 delete();
}

//Function Number: 168
getsqdronestartnode(param_00,param_01)
{
	var_02 = getlinkednodes(param_01,1);
	if(var_02.size > 0)
	{
		return var_02[randomint(var_02.size)];
	}

	var_03 = common_scripts\utility::array_randomize(param_00.ammodronespawnnodes);
	foreach(var_05 in var_03)
	{
		if(var_05 != param_01)
		{
			return var_05;
		}
	}
}

//Function Number: 169
waittillsqdroneactivate(param_00,param_01)
{
	level.ammodrone endon("droneDamaged");
	param_00 endon("droneDamaged");
	for(;;)
	{
		wait 0.05;
		if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(param_01.zone_name))
		{
			continue;
		}

		var_02 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(param_01.zone_name,1);
		if(var_02.size == 0)
		{
			continue;
		}

		var_03 = maps\mp\zombies\zombie_ammo_drone::getplayerclosetodrone(param_00,var_02);
		if(isdefined(var_03))
		{
			break;
		}

		var_03 = maps\mp\zombies\zombie_ammo_drone::getplayerlookingatdronetoolong(param_00,var_02);
		if(isdefined(var_03))
		{
			break;
		}
	}

	level notify("activateAmmoDrone");
}

//Function Number: 170
code3_stage2_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got the switch from the treasure drone.");
}

//Function Number: 171
code3_stage3_init()
{
}

//Function Number: 172
code3_stage3_logic()
{
	var_00 = getent("sqCageSwitch","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("used",::playerhasitem,"switch","code3_stage3_over");
	var_01 playertakeitem("switch");
	var_01 thread maps\mp\mp_zombie_ark_aud::switch_place_in_socket();
	wait(1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("code3","stage3");
}

//Function Number: 173
code3_stage3_end(param_00)
{
	var_04 = getent("sqCageSwitch","targetname");
	if(isdefined(var_04))
	{
		var_04 show();
		var_04 scriptmodelplayanim("zark_electricpanel_switch_up_idle","switch_notetrack");
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Placed switch by moon pool.");
}

//Function Number: 174
chumwaters()
{
	level.sqchumvolume = getent("sqChumWater","targetname");
	if(!isdefined(level.sqchumvolume))
	{
		return;
	}

	level.zmbwaterchummed = 0;
	level.processenemykilledfunc = ::processenemykilled;
	var_01 = 5;
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		level waittill("sq_chum_water",var_04,var_05);
		if(maps\mp\zombies\_util::is_true(level.zmbsqcagemoving))
		{
			continue;
		}

		playfx(common_scripts\utility::getfx("sq_chum"),var_04);
		if(!level.zmbwaterchummed)
		{
			if(isdefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling))
			{
				continue;
			}

			var_06 = gettime() - var_03;
			if(var_06 > 10000)
			{
				var_02 = 0;
			}

			var_03 = gettime();
			var_02++;
			if(var_02 >= var_01)
			{
				level.zmbwaterchummed = 1;
				level thread doshark();
				if(isdefined(var_05) && isplayer(var_05))
				{
					var_05 thread playerplaychumwatervo();
				}

				maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Water chummed");
				var_02 = 0;
				var_03 = 0;
				level thread resetchumtime(30);
			}

			continue;
		}

		var_02++;
		var_07 = 30 - var_02;
		level thread resetchumtime(var_07);
	}
}

//Function Number: 175
playerplaychumwatervo()
{
	self endon("disconnect");
	wait(1);
	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","chum_water");
}

//Function Number: 176
resetchumtime(param_00)
{
	level notify("resetChumTime");
	level endon("resetChumTime");
	if(param_00 > 0)
	{
		wait(param_00);
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Water not chummed");
	level.zmbwaterchummed = 0;
}

//Function Number: 177
doshark()
{
	var_00 = common_scripts\utility::getstruct("shark_anim_node","targetname");
	if(!isdefined(var_00))
	{
		var_00 = spawnstruct();
		var_00.origin = (0,0,0);
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	if(!isdefined(level.zmbshark))
	{
		level.zmbshark = spawn("script_model",var_00.origin);
		level.zmbshark setmodel("zark_shark_01");
		level.zmbeyeball = spawn("script_model",var_00.origin);
		level.zmbeyeball setmodel("zark_zom_eye_01");
		level.zmbeyeball vehicle_jetbikesethoverforcescale(level.zmbshark,"j_helmet",(0,0,0),(0,0,0));
	}

	level.zmbsharktriggeractive = 0;
	level.zmbshark show();
	level.zmbshark.circling = 1;
	level.zmbshark scriptmodelplayanimdeltamotionfrompos("zom_shark_circle_enter",var_00.origin,var_00.angles,"shark_notetrack");
	thread maps\mp\mp_zombie_ark_aud::shark_enters();
	level.zmbshark waittillmatch("end","shark_notetrack");
	if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedsharkhint))
	{
		if(announcerozglobalplaysq(15))
		{
			level.zmbaudioplayedsharkhint = 1;
		}
	}

	if(level.zmbwaterchummed)
	{
		level.zmbsharktriggeractive = 1;
		level.zmbshark scriptmodelplayanimdeltamotionfrompos("zom_shark_circle_loop",var_00.origin,var_00.angles,"shark_notetrack");
		thread maps\mp\mp_zombie_ark_aud::shark_loop();
		while(level.zmbwaterchummed && !maps\mp\zombies\_util::is_true(level.zmbsqcagemoving))
		{
			wait 0.05;
		}
	}

	level.zmbsharktriggeractive = 0;
	level.zmbshark scriptmodelplayanimdeltamotion("zom_shark_circle_exit","shark_notetrack");
	thread maps\mp\mp_zombie_ark_aud::shark_leaves();
	level.zmbshark waittillmatch("end","shark_notetrack");
	level.zmbshark.circling = undefined;
	level.zmbshark hide();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Shark leaving");
}

//Function Number: 178
processenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(level.processenemykilledcodefunc))
	{
		self thread [[ level.processenemykilledcodefunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(!level.zmbwaterchummed && ispointinvolume(self.origin + (0,0,10),level.sqchumvolume))
	{
		level notify("sq_chum_water",self.origin,param_01);
	}
}

//Function Number: 179
code3_stage4_init()
{
}

//Function Number: 180
code3_stage4_logic()
{
	cageoperation();
	maps\mp\zombies\_zombies_sidequests::stage_completed("code3","stage4");
}

//Function Number: 181
code3_stage4_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retrieved eye from pool");
}

//Function Number: 182
cageoperation()
{
	var_00 = common_scripts\utility::getstruct("shark_anim_node","targetname");
	var_01 = getent("sqCrane","targetname");
	var_02 = getent("sqCageModel","targetname");
	var_03 = getent("sqCageDoorClip","targetname");
	var_04 = getent("sqCageDoorBottomClip","targetname");
	var_05 = getent("sqCageSwitch","targetname");
	var_06 = getent("sqCageTrigger","targetname");
	var_07 = getent("sqCageVolume","targetname");
	var_08 = getent("sqPoolDoor1","targetname");
	var_09 = getent("sqPoolDoor2","targetname");
	var_0A = getent("sqChumWater","targetname");
	var_0B = getent("sqPoolTrigger","targetname");
	var_0C = getent("sqPoolClip","targetname");
	var_0D = var_05;
	if(isdefined(var_06))
	{
		var_0D = var_06;
	}
	else
	{
		var_05.origin = (var_05.origin[0],596,var_05.origin[2]);
	}

	var_0D makeusable();
	var_0D setcursorhint("HINT_NOICON");
	level.zmbsqcagemoving = 0;
	for(;;)
	{
		var_0D sethintstring(&"ZOMBIE_ARK_SQ_CAGE");
		var_0D setsecondaryhintstring(&"ZOMBIES_COST_1000");
		for(;;)
		{
			var_0D waittill("trigger",var_0E);
			if(var_0E maps\mp\gametypes\zombies::attempttobuy(1000))
			{
				break;
			}

			wait(0.5);
		}

		var_0D sethintstring(&"ZOMBIES_CURE_COOLDOWN_HINT");
		var_0D setsecondaryhintstring("");
		var_05 thread maps\mp\mp_zombie_ark_aud::cage_switch();
		var_05 scriptmodelplayanim("zark_electricpanel_switch_move_down","switch_notetrack");
		var_05 waittillmatch("end","switch_notetrack");
		var_05 scriptmodelplayanim("zark_electricpanel_switch_down_idle","switch_notetrack");
		var_01 thread maps\mp\mp_zombie_ark_aud::cage_down();
		level.zmbsqcagemoving = 1;
		var_0C poolclipon();
		docageanimation(var_00,var_02,var_01,var_03,var_04,var_07,var_08,var_09,var_0B);
		var_0C poolclipoff();
		level.zmbsqcagemoving = 0;
		if(isdefined(var_02.playerinside) && var_02.playerinside playerhasitem("eye"))
		{
			break;
		}

		wait(30);
		var_05 scriptmodelplayanim("zark_electricpanel_switch_move_up","switch_notetrack");
		var_05 waittillmatch("end","switch_notetrack");
		var_05 scriptmodelplayanim("zark_electricpanel_switch_up_idle","switch_notetrack");
	}

	var_0D makeunusable();
}

//Function Number: 183
docageanimation(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_06.origin;
	var_0A = var_09 + (0,-60,0);
	var_0B = param_07.origin;
	var_0C = var_0B + (0,40,0);
	var_0D = isdefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling);
	param_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_lower_crane",param_00.origin,param_00.angles,"cageSequence");
	param_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_lower_cage",param_00.origin,param_00.angles,"cageSequence");
	param_06 moveto(var_0A,3,1,1);
	param_07 moveto(var_0C,3,1,1);
	if(var_0D)
	{
		level thread dosharkcageoztaunt();
	}

	param_01 waittillmatch("end","cageSequence");
	param_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_getin_loop_crane",param_00.origin,param_00.angles,"cageSequence");
	param_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_getin_loop_cage",param_00.origin,param_00.angles,"cageSequence");
	level thread setclipwhenplayerjumpsin(param_01,param_03,param_05);
	param_03 cagedoorclipopen();
	param_01 common_scripts\utility::waittill_notify_or_timeout("playerJumpedIn",4);
	param_03 notify("timeout");
	if(maps\mp\zombies\_util::is_true(param_03.open))
	{
		param_03 cagedoorclipclose();
	}

	waittillsharkready();
	param_01 waittillmatch("getin_loop_point","cageSequence");
	level notify("removeExtraPlayersStop");
	if(var_0D && isdefined(param_01.playerinside))
	{
		level.zmbshark show();
		thread maps\mp\mp_zombie_ark_aud::shark_attack(param_01.playerinside);
		level.zmbshark scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_shark",param_00.origin,param_00.angles,"cageSequence");
		param_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_crane",param_00.origin,param_00.angles,"cageSequence");
		param_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_cage",param_00.origin,param_00.angles,"cageSequence");
		level thread handleeyeball(param_01);
		param_01 waittillmatch("start_raise","cageSequence");
		thread maps\mp\mp_zombie_ark_aud::cage_up();
	}
	else
	{
		thread maps\mp\mp_zombie_ark_aud::cage_up();
		param_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_raise_crane",param_00.origin,param_00.angles,"cageSequence");
		param_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_raise_cage",param_00.origin,param_00.angles,"cageSequence");
	}

	param_01 waittillmatch("close_pool","cageSequence");
	level thread closepooldoors(param_06,param_07,var_09,var_0B,param_08);
	param_01 waittillmatch("cage_dropout","cageSequence");
	if(isdefined(param_01.playerinside))
	{
		param_01.playerinside unlink();
	}

	param_04 thread cagedoorbottomdropplayer(param_01,param_05);
	param_01 waittillmatch("end","cageSequence");
	if(var_0D)
	{
		level.zmbshark hide();
	}

	param_02 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_crane",param_00.origin,param_00.angles,"cageSequence");
	param_01 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_cage",param_00.origin,param_00.angles,"cageSequence");
	level notify("removeExtraPlayersStop");
}

//Function Number: 184
dosharkcageoztaunt()
{
	if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedsharkcage))
	{
		wait(1);
		var_00 = 22;
		if(common_scripts\utility::cointoss())
		{
			var_00 = 23;
		}

		if(announcerozglobalplaysq(var_00))
		{
			level.zmbaudioplayedsharkcage = 1;
		}
	}
}

//Function Number: 185
handleeyeball(param_00)
{
	level endon("sqEyeballGrabDone");
	level thread handleeyeballend(param_00);
	level.zmbeyeball hudoutlineenableforclient(param_00.playerinside,3,0);
	param_00 waittillmatch("get_eyeball_start","cageSequence");
	var_01 = level.zmbeyeball maps\mp\zombies\_zombies_sidequests::fake_use("grabbedEyeball",::playerisincage,undefined,"sqEyeballGrabDone",100);
	level.zmbeyeball delete();
	param_00.playerinside playergiveitem("eye");
	param_00.playerinside thread maps\mp\mp_zombie_ark_aud::grab_eyeball();
}

//Function Number: 186
handleeyeballend(param_00)
{
	param_00 waittillmatch("get_eyeball_end","cageSequence");
	level notify("sqEyeballGrabDone");
	if(isdefined(level.zmbeyeball))
	{
		level.zmbeyeball hudoutlinedisable();
	}
}

//Function Number: 187
playerisincage()
{
	return maps\mp\zombies\_util::is_true(self.insidecage);
}

//Function Number: 188
waittillsharkready()
{
	while(isdefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling))
	{
		wait 0.05;
	}
}

//Function Number: 189
closepooldoors(param_00,param_01,param_02,param_03,param_04)
{
	param_00 moveto(param_02,2,1,1);
	param_01 moveto(param_03,2,1,1);
	param_00.unresolved_collision_func = undefined;
	param_01.unresolved_collision_func = undefined;
	wait(2.1);
	param_00.unresolved_collision_func = ::maps\mp\_movers::unresolved_collision_void;
	param_01.unresolved_collision_func = ::maps\mp\_movers::unresolved_collision_void;
}

//Function Number: 190
poolclipon()
{
	self dontinterpolate();
	self.origin = self.origin + (0,0,1000);
	self disconnectpaths();
}

//Function Number: 191
poolclipoff()
{
	self connectpaths();
	wait 0.05;
	self dontinterpolate();
	self.origin = self.origin + (0,0,-1000);
}

//Function Number: 192
cagedoorbottomdropplayer(param_00,param_01)
{
	if(isdefined(param_00.playerinside))
	{
		level thread cagefixplayerifwatersucks(param_00.playerinside);
	}

	self notsolid();
	wait(1.5);
	self solid();
	if(isdefined(param_00.playerinside))
	{
		param_00.playerinside.insidecage = undefined;
	}

	level thread removeextraplayers(param_00,param_01);
}

//Function Number: 193
cagefixplayerifwatersucks(param_00)
{
	if(isdefined(param_00.disabledweaponswitch) && param_00.disabledweaponswitch > 0 && isdefined(param_00.disabledoffhandweapons) && param_00.disabledoffhandweapons > 0)
	{
		param_00 enableweaponpickup();
		param_00 common_scripts\utility::_enableweaponswitch();
		param_00 common_scripts\utility::_enableoffhandweapons();
	}

	var_01 = param_00 getcurrentprimaryweapon();
	if(issubstr(var_01,"combatknife"))
	{
		param_00 takeweapon(var_01);
		var_02 = param_00 getweaponslistprimaries();
		if(var_02.size > 0)
		{
			param_00 switchtoweapon(var_02[0]);
		}
	}

	param_00 notify("above_water");
	param_00 notify("out_of_water");
	param_00 notify("end_swimming");
	if(maps\mp\zombies\_util::is_true(param_00.isshocked))
	{
		param_00 stopshellshock();
		param_00.isshocked = undefined;
	}

	if(!param_00 ishighjumpallowed() && maps\mp\zombies\_util::is_true(param_00.exosuitonline))
	{
		param_00 maps\mp\_utility::playerallowhighjump(1);
		param_00 maps\mp\_utility::playerallowhighjumpdrop(1);
		param_00 maps\mp\_utility::playerallowboostjump(1);
		param_00 maps\mp\_utility::playerallowpowerslide(1);
		param_00 maps\mp\_utility::playerallowdodge(1);
	}
}

//Function Number: 194
cagedoorclipopen()
{
	self notsolid();
	self.open = 1;
}

//Function Number: 195
cagedoorclipclose()
{
	self solid();
	self.open = 0;
}

//Function Number: 196
setclipwhenplayerjumpsin(param_00,param_01,param_02)
{
	param_01 endon("timeout");
	param_00.playerinside = undefined;
	for(;;)
	{
		foreach(var_04 in level.players)
		{
			if(var_04 istouching(param_02))
			{
				param_00.playerinside = var_04;
				var_04 playlocalsound("underwater_enter");
				var_04.insidecage = 1;
				level thread removeextraplayers(param_00,param_02);
				var_04 thread playerlinktocage(param_00);
				param_01 cagedoorclipclose();
				param_00 notify("playerJumpedIn");
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 197
removeextraplayers(param_00,param_01)
{
	level endon("removeExtraPlayersStop");
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(var_03 istouching(param_01) && !maps\mp\zombies\_util::is_true(var_03.insidecage))
			{
				var_03 thread playerteleportoutofcage(param_01);
			}
		}

		wait 0.05;
	}
}

//Function Number: 198
playerteleportoutofcage(param_00)
{
	maps\mp\_movers::unresolved_collision_nearest_node(self,1);
	wait(1);
	if(isalive(self) && !self istouching(param_00))
	{
		level thread cagefixplayerifwatersucks(self);
	}
}

//Function Number: 199
playerlinktocage(param_00)
{
	self endon("disconnect");
	wait(0.5);
	self playerlinktodelta(param_00,"tag_origin",1,180,180,180,180,1);
}

//Function Number: 200
playerhandlewaterdamageark()
{
	level endon("game_ended");
	self endon("death");
	self endon("stopped_using_remote");
	self endon("disconnect");
	self endon("above_water");
	thread maps\mp\_water::onplayerdeath();
	wait(13);
	for(;;)
	{
		if((!isdefined(self.isjuggernaut) || self.isjuggernaut == 0) && !maps\mp\zombies\_util::is_true(self.insidecage))
		{
			radiusdamage(self.origin + anglestoforward(self.angles) * 5,1,20,20,undefined,"MOD_TRIGGER_HURT");
		}

		wait(1);
	}
}

//Function Number: 201
code3_stage5_init()
{
}

//Function Number: 202
code3_stage5_logic()
{
	var_00 = getent("sqLocker1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = spawnstruct();
	var_01.origin = (65,-496,1023);
	var_02 = var_01 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed",::playerhasitem,"eye","code3_stage1_over",80);
	var_02 playertakeitem("eye");
	thread maps\mp\mp_zombie_ark_aud::open_locker(var_01);
	var_00 rotateyaw(-80,2,0.5,1);
	wait(2);
	var_03 = getent("sqCode4","targetname");
	if(isdefined(var_03))
	{
		var_03 show();
		var_02 = var_03 maps\mp\zombies\_zombies_sidequests::fake_use("got_code",::playernotholdingcode);
		var_03 delete();
	}

	var_02 playergiveitem("code");
	var_02 thread maps\mp\mp_zombie_ark_aud::got_code();
	maps\mp\zombies\_zombies_sidequests::stage_completed("code3","stage5");
}

//Function Number: 203
code3_stage5_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Opened locker and retrieved code.");
}

//Function Number: 204
init_code4_sidequest()
{
	common_scripts\utility::flag_init("sq_plinko_a");
	common_scripts\utility::flag_init("sq_plinko_b");
	common_scripts\utility::flag_init("sq_plinko_c");
}

//Function Number: 205
sidequest_code4_logic()
{
	common_scripts\utility::flag_set("sq_plinko");
	maps\mp\zombies\_zombies_sidequests::stage_start("code4","stage1");
	level waittill("code4_stage1_over");
	common_scripts\utility::flag_clear("sq_plinko");
}

//Function Number: 206
code4_stage1_init()
{
	level thread findsqplinkohint();
}

//Function Number: 207
findsqplinkohint()
{
	level.zmbfindgamblecustomvo = ::doplayerfoundplinkosq;
	var_00 = common_scripts\utility::getstructarray("plinko","targetname");
	foreach(var_02 in var_00)
	{
		level thread maps\mp\zombies\_gambling::discoverplinkologic(var_02);
	}
}

//Function Number: 208
doplayerfoundplinkosq(param_00,param_01)
{
	var_02 = 24;
	if(common_scripts\utility::cointoss())
	{
		var_02 = 25;
	}

	if(param_00 playerplaysqvo(var_02))
	{
		level notify("discoverPlinkoLogic");
		return 1;
	}

	return 0;
}

//Function Number: 209
code4_stage1_logic()
{
	level thread doplinkooztaunt();
	for(;;)
	{
		var_00 = waituntilplinkocomplete();
		if(maps\mp\zombies\_util::is_true(var_00))
		{
			break;
		}

		wait 0.05;
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("code4","stage1");
}

//Function Number: 210
doplinkooztaunt()
{
	level common_scripts\utility::waittill_any("sq_plinko_a","sq_plinko_b","sq_plinko_c");
	var_00 = 26;
	if(common_scripts\utility::cointoss())
	{
		var_00 = 27;
	}

	announcerozglobalplaysq(var_00);
}

//Function Number: 211
waituntilplinkocomplete()
{
	level endon("playerCountUpdate");
	common_scripts\utility::flag_wait("sq_plinko_a");
	common_scripts\utility::flag_wait("sq_plinko_b");
	var_00 = common_scripts\utility::flag_wait("sq_plinko_c");
	var_01 = getent("sqCode1","targetname");
	if(isdefined(var_01))
	{
		var_01 moveto((-124,696,998),1.5,0.1,0.5);
		var_00 = var_01 maps\mp\zombies\_zombies_sidequests::fake_use("got_code",::playernotholdingcode);
		var_01 delete();
	}

	if(isdefined(var_00))
	{
		var_00 playergiveitem("code");
		var_00 thread maps\mp\mp_zombie_ark_aud::got_code();
	}

	return 1;
}

//Function Number: 212
code4_stage1_end(param_00)
{
	level.zmbfindgamblecustomvo = undefined;
	level notify("discoverPlinkoLogic");
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retreived the passcode from the machine");
}

//Function Number: 213
init_song_sidequest()
{
	level.sq_song_ent = getent("sq_song","targetname");
	if(!isdefined(level.sq_song_ent))
	{
		level.sq_song_ent = spawn("script_model",(0,0,0));
	}
}

//Function Number: 214
sidequest_logic_song()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage1");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage2");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage3");
	var_03 = 0;
	for(;;)
	{
		var_04 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over","song_stage2_over","song_stage3_over");
		var_03++;
		if(var_03 < 3)
		{
			thread song_play(var_03);
			continue;
		}

		song_play(2);
		thread song_play();
		break;
	}
}

//Function Number: 215
song_play(param_00)
{
	level notify("sq_song_play");
	level endon("sq_song_play");
	level endon("sq_song_stop");
	if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing))
	{
		level.sq_song_ent stopsounds();
		level.sq_song_ent.playing = 0;
		wait(0.2);
	}

	var_01 = "zmb_mus_ee_04";
	if(!isdefined(param_00) || param_00 <= 0)
	{
		param_00 = musiclength("zmb_mus_ee_04");
	}
	else
	{
		var_01 = "zmb_mus_ee_04_prvw";
	}

	level.sq_song_ent playsoundonmovingent(var_01);
	level.sq_song_ent.playing = 1;
	wait(param_00);
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
}

//Function Number: 216
song_stop()
{
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
	level notify("sq_song_stop");
}

//Function Number: 217
song_fake_use(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.origin = param_00;
	var_04 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"song_stage" + param_01 + "_over",param_02,param_03);
	var_04 waittill("activated",var_05);
	return var_05;
}

//Function Number: 218
songstage1_init()
{
}

//Function Number: 219
songstage1_logic()
{
	var_00 = song_fake_use((70,-502,1079.5),1,120,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage1");
}

//Function Number: 220
songstage1_end(param_00)
{
}

//Function Number: 221
songstage2_init()
{
}

//Function Number: 222
songstage2_logic()
{
	var_00 = song_fake_use((966,1958,1074),2,undefined,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage2");
}

//Function Number: 223
songstage2_end(param_00)
{
}

//Function Number: 224
songstage3_init()
{
}

//Function Number: 225
songstage3_logic()
{
	var_00 = song_fake_use((-923,-2166,972),3,80,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage3");
}

//Function Number: 226
songstage3_end(param_00)
{
}

//Function Number: 227
musiclength(param_00)
{
	var_01 = tablelookup("mp/sound/soundlength_zm_mp_dlc3.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 2;
	}

	var_01 = int(var_01);
	var_01 = var_01 * 0.001;
	return var_01;
}

//Function Number: 228
playerplaysqvo(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(maps\mp\zombies\_util::is_true(self.speaking))
	{
		self waittill("done_speaking");
	}

	var_03 = maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq","sq",undefined,param_00);
	if(maps\mp\zombies\_util::is_true(param_02))
	{
		wait 0.05;
		waittilldonespeaking(self);
	}

	return var_03;
}

//Function Number: 229
waittilldonespeaking(param_00)
{
	param_00 endon("disconnect");
	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 230
playsqvowaittilldone(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(param_00);
	if(isdefined(var_04))
	{
		var_05 = var_04 playerplaysqvo(param_01,param_02,1);
		if(isdefined(param_03))
		{
			wait(param_03);
		}

		return var_05;
	}

	return 0;
}

//Function Number: 231
announcerinworldplaysqvowaittilldone(param_00,param_01,param_02)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("machine_all_players",param_00,level.sqarm.origin,undefined,undefined,undefined,undefined,param_02);
	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

//Function Number: 232
announcerglobalplaysqvo(param_00,param_01,param_02)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority","sq",undefined,param_00,1,undefined,param_02);
}

//Function Number: 233
announcerglobalplaysqvowaittilldone(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	announcerglobalplaysqvo(param_00,param_01,param_02);
	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

//Function Number: 234
announcerozglobalplaysqwaittilldone(param_00)
{
	announcerozglobalplaysq(param_00);
	waittillannouncerozdonespeaking();
}

//Function Number: 235
announcerozglobalplaysq(param_00,param_01)
{
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	return var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","sq",undefined,param_00,1,undefined,level.players);
}

//Function Number: 236
announcerozinworldplaysq(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	var_03.origin = param_00;
	wait 0.05;
	if(isdefined(param_02))
	{
		param_02 = common_scripts\utility::array_removeundefined(param_02);
	}

	return var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players","sq",undefined,param_01,1,undefined,param_02);
}

//Function Number: 237
waittillannouncerozdonespeaking(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	}

	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 238
zombiearmplaysqvo(param_00)
{
	return level.sqarm maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players",param_00);
}

//Function Number: 239
set_side_quest_coop_data_ark()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_02 = var_01 getcoopplayerdatareservedint("eggData");
		var_02 = var_02 | 8;
		var_01.sidequest = 1;
		var_01 setcoopplayerdatareservedint("eggData",var_02);
		setmatchdata("players",var_01.clientid,"startPrestige",var_01.sidequest);
	}
}

//Function Number: 240
runozextras()
{
	level thread ozdoor();
}

//Function Number: 241
ozphone()
{
	var_00 = spawnstruct();
	var_00.origin = (-1644,1083,800);
	for(;;)
	{
		var_01 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("phone",undefined,undefined,undefined,75,1);
		var_02 = bullettrace(var_01 geteye(),var_00.origin,0,var_01,0,0,0,0,0,0,0);
		if(var_02["fraction"] == 1)
		{
			if(announcerozglobalplaysq(21))
			{
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 242
ozdoor()
{
	var_00 = 62500;
	var_01 = common_scripts\utility::getstruct("sqEngineRoomDoor","targetname");
	var_02 = [7,8,9,10,17,18,20];
	var_02 = common_scripts\utility::array_randomize(var_02);
	var_03 = 0;
	for(;;)
	{
		wait(randomintrange(240,360));
		var_04 = [];
		foreach(var_06 in level.players)
		{
			if(var_06.origin[2] < 950)
			{
				continue;
			}

			var_07 = distance2dsquared(var_06.origin,var_01.origin);
			if(var_07 > var_00)
			{
				continue;
			}

			var_08 = vectornormalize((var_06.origin[0],var_06.origin[1],0) - (var_01.origin[0],var_01.origin[1],0));
			var_09 = anglestoforward(var_01.angles);
			var_0A = vectordot(var_08,var_09);
			if(var_0A > 0)
			{
				var_04[var_04.size] = var_06;
			}
		}

		if(var_04.size > 0)
		{
			announcerozinworldplaysq(var_01.origin,var_02[var_03],var_04);
			var_03++;
			if(var_03 >= var_02.size)
			{
				return;
			}
		}
	}
}
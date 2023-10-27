/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_ac130.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1066 ms
 * Timestamp: 10/27/2023 2:13:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.ac130_use_duration = 40;
	level.ac130_num_flares = 2;
	makedvarserverinfo("ui_ac130usetime",level.ac130_use_duration);
	precacheshader("black");
	precachestring(&"AC130_HUD_FLIR");
	precachestring(&"AC130_HUD_OPTICS");
	precachemenu("ac130timer");
	precachemodel("vehicle_ac130_coop");
	precacheitem("ac130_25mm_mp");
	precacheitem("ac130_40mm_mp");
	precacheitem("ac130_105mm_mp");
	precacheminimapicon("compass_objpoint_ac130_friendly");
	precacheminimapicon("compass_objpoint_ac130_enemy");
	precacheshellshock("ac130");
	angelflareprecache();
	level._effect["cloud"] = loadfx("misc/ac130_cloud");
	level._effect["beacon"] = loadfx("misc/ir_beacon_coop");
	level._effect["ac130_explode"] = loadfx("explosions/aerial_explosion_ac130_coop");
	level._effect["ac130_flare"] = loadfx("misc/flares_cobra");
	level._effect["ac130_light_red"] = loadfx("misc/aircraft_light_wingtip_red");
	level._effect["ac130_light_white_blink"] = loadfx("misc/aircraft_light_white_blink");
	level._effect["ac130_light_red_blink"] = loadfx("misc/aircraft_light_red_blink");
	level._effect["ac130_engineeffect"] = loadfx("fire/jet_engine_ac130");
	level._effect["coop_muzzleflash_105mm"] = loadfx("muzzleflashes/ac130_105mm");
	level._effect["coop_muzzleflash_40mm"] = loadfx("muzzleflashes/ac130_40mm");
	level.radioforcedtransmissionqueue = [];
	level.enemieskilledintimewindow = 0;
	level.lastradiotransmission = gettime();
	level.color["white"] = (1,1,1);
	level.color["red"] = (1,0,0);
	level.color["blue"] = (0.1,0.3,1);
	level.cosine = [];
	level.cosine["45"] = cos(45);
	level.cosine["5"] = cos(5);
	level.huditem = [];
	level.physicssphereradius["ac130_25mm_mp"] = 60;
	level.physicssphereradius["ac130_40mm_mp"] = 600;
	level.physicssphereradius["ac130_105mm_mp"] = 1000;
	level.physicssphereforce["ac130_25mm_mp"] = 0;
	level.physicssphereforce["ac130_40mm_mp"] = 3;
	level.physicssphereforce["ac130_105mm_mp"] = 6;
	level.weaponreloadtime["ac130_25mm_mp"] = 1.5;
	level.weaponreloadtime["ac130_40mm_mp"] = 3;
	level.weaponreloadtime["ac130_105mm_mp"] = 5;
	level.ac130_speed["move"] = 250;
	level.ac130_speed["rotate"] = 70;
	common_scripts\utility::flag_init("allow_context_sensative_dialog");
	common_scripts\utility::flag_set("allow_context_sensative_dialog");
	var_00 = getentarray("minimap_corner","targetname");
	var_01 = (0,0,0);
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_00[0].origin,var_00[1].origin);
	}

	level.ac130 = spawn("script_model",var_01);
	level.ac130 setmodel("c130_zoomrig");
	level.ac130.angles = (0,115,0);
	level.ac130.owner = undefined;
	level.ac130.thermal_vision = "ac130_thermal_mp";
	level.ac130.enhanced_vision = "ac130_enhanced_mp";
	level.ac130.targetname = "ac130rig_script_model";
	level.ac130 hide();
	level.ac130inuse = 0;
	init_sounds();
	thread rotateplane("on");
	thread ac130_spawn();
	thread onplayerconnect();
	thread handleincomingstinger();
	thread handleincomingsam();
	level.killstreakfuncs["ac130"] = ::tryuseac130;
	level.ac130queue = [];
}

//Function Number: 2
tryuseac130(param_00)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(isdefined(level.ac130player) || level.ac130inuse)
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	maps\mp\_utility::setusingremote("ac130");
	var_01 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

	var_01 = setac130player(self);
	if(isdefined(var_01) && var_01)
	{
		maps\mp\_matchdata::logkillstreakevent("ac130",self.origin);
		level.ac130.planemodel.crashed = undefined;
		level.ac130inuse = 1;
	}
	else
	{
		maps\mp\_utility::clearusingremote();
	}

	return isdefined(var_01) && var_01;
}

//Function Number: 3
init_sounds()
{
	setac130ambience("ambient_ac130_int1");
	level.scr_sound["foo"]["bar"] = "";
	add_context_sensative_dialog("ai","in_sight",0,"ac130_fco_moreenemy");
	add_context_sensative_dialog("ai","in_sight",1,"ac130_fco_getthatguy");
	add_context_sensative_dialog("ai","in_sight",2,"ac130_fco_guymovin");
	add_context_sensative_dialog("ai","in_sight",3,"ac130_fco_getperson");
	add_context_sensative_dialog("ai","in_sight",4,"ac130_fco_guyrunnin");
	add_context_sensative_dialog("ai","in_sight",5,"ac130_fco_gotarunner");
	add_context_sensative_dialog("ai","in_sight",6,"ac130_fco_backonthose");
	add_context_sensative_dialog("ai","in_sight",7,"ac130_fco_gonnagethim");
	add_context_sensative_dialog("ai","in_sight",8,"ac130_fco_personnelthere");
	add_context_sensative_dialog("ai","in_sight",9,"ac130_fco_nailthoseguys");
	add_context_sensative_dialog("ai","in_sight",11,"ac130_fco_lightemup");
	add_context_sensative_dialog("ai","in_sight",12,"ac130_fco_takehimout");
	add_context_sensative_dialog("ai","in_sight",14,"ac130_plt_yeahcleared");
	add_context_sensative_dialog("ai","in_sight",15,"ac130_plt_copysmoke");
	add_context_sensative_dialog("ai","in_sight",16,"ac130_fco_rightthere");
	add_context_sensative_dialog("ai","in_sight",17,"ac130_fco_tracking");
	add_context_sensative_dialog("ai","wounded_crawl",0,"ac130_fco_movingagain");
	add_context_sensative_timeout("ai","wounded_crawl",undefined,6);
	add_context_sensative_dialog("ai","wounded_pain",0,"ac130_fco_doveonground");
	add_context_sensative_dialog("ai","wounded_pain",1,"ac130_fco_knockedwind");
	add_context_sensative_dialog("ai","wounded_pain",2,"ac130_fco_downstillmoving");
	add_context_sensative_dialog("ai","wounded_pain",3,"ac130_fco_gettinbackup");
	add_context_sensative_dialog("ai","wounded_pain",4,"ac130_fco_yepstillmoving");
	add_context_sensative_dialog("ai","wounded_pain",5,"ac130_fco_stillmoving");
	add_context_sensative_timeout("ai","wounded_pain",undefined,12);
	add_context_sensative_dialog("weapons","105mm_ready",0,"ac130_gnr_gunready1");
	add_context_sensative_dialog("weapons","105mm_fired",0,"ac130_gnr_shot1");
	add_context_sensative_dialog("plane","rolling_in",0,"ac130_plt_rollinin");
	add_context_sensative_dialog("explosion","secondary",0,"ac130_nav_secondaries1");
	add_context_sensative_dialog("explosion","secondary",1,"ac130_tvo_directsecondary1");
	add_context_sensative_dialog("explosion","secondary",1,"ac130_tvo_directsecondary2");
	add_context_sensative_timeout("explosion","secondary",undefined,7);
	add_context_sensative_dialog("kill","single",0,"ac130_plt_gottahurt");
	add_context_sensative_dialog("kill","single",1,"ac130_fco_iseepieces");
	add_context_sensative_dialog("kill","single",2,"ac130_fco_oopsiedaisy");
	add_context_sensative_dialog("kill","single",3,"ac130_fco_goodkill");
	add_context_sensative_dialog("kill","single",4,"ac130_fco_yougothim");
	add_context_sensative_dialog("kill","single",5,"ac130_fco_yougothim2");
	add_context_sensative_dialog("kill","single",6,"ac130_fco_thatsahit");
	add_context_sensative_dialog("kill","single",7,"ac130_fco_directhit");
	add_context_sensative_dialog("kill","single",8,"ac130_fco_rightontarget");
	add_context_sensative_dialog("kill","single",9,"ac130_fco_okyougothim");
	add_context_sensative_dialog("kill","single",10,"ac130_fco_within2feet");
	add_context_sensative_dialog("kill","small_group",0,"ac130_fco_nice");
	add_context_sensative_dialog("kill","small_group",1,"ac130_fco_directhits");
	add_context_sensative_dialog("kill","small_group",2,"ac130_fco_iseepieces");
	add_context_sensative_dialog("kill","small_group",3,"ac130_fco_goodkill");
	add_context_sensative_dialog("kill","small_group",4,"ac130_fco_yougothim");
	add_context_sensative_dialog("kill","small_group",5,"ac130_fco_yougothim2");
	add_context_sensative_dialog("kill","small_group",6,"ac130_fco_thatsahit");
	add_context_sensative_dialog("kill","small_group",7,"ac130_fco_directhit");
	add_context_sensative_dialog("kill","small_group",8,"ac130_fco_rightontarget");
	add_context_sensative_dialog("kill","small_group",9,"ac130_fco_okyougothim");
	add_context_sensative_dialog("misc","action",0,"ac130_plt_scanrange");
	add_context_sensative_timeout("misc","action",0,70);
	add_context_sensative_dialog("misc","action",1,"ac130_plt_cleanup");
	add_context_sensative_timeout("misc","action",1,80);
	add_context_sensative_dialog("misc","action",2,"ac130_plt_targetreset");
	add_context_sensative_timeout("misc","action",2,55);
	add_context_sensative_dialog("misc","action",3,"ac130_plt_azimuthsweep");
	add_context_sensative_timeout("misc","action",3,100);
}

//Function Number: 4
add_context_sensative_dialog(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + param_03;
	var_04 = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + param_03;
	if(!isdefined(level.scr_sound[param_00]) || !isdefined(level.scr_sound[param_00][param_01]) || !isdefined(level.scr_sound[param_00][param_01][param_02]))
	{
		level.scr_sound[param_00][param_01][param_02] = spawnstruct();
		level.scr_sound[param_00][param_01][param_02].played = 0;
		level.scr_sound[param_00][param_01][param_02].sounds = [];
	}

	var_05 = level.scr_sound[param_00][param_01][param_02].sounds.size;
	level.scr_sound[param_00][param_01][param_02].sounds[var_05] = param_03;
}

//Function Number: 5
add_context_sensative_timeout(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.context_sensative_dialog_timeouts))
	{
		level.context_sensative_dialog_timeouts = [];
	}

	var_04 = 0;
	if(!isdefined(level.context_sensative_dialog_timeouts[param_00]))
	{
		var_04 = 1;
	}
	else if(!isdefined(level.context_sensative_dialog_timeouts[param_00][param_01]))
	{
		var_04 = 1;
	}

	if(var_04)
	{
		level.context_sensative_dialog_timeouts[param_00][param_01] = spawnstruct();
	}

	if(isdefined(param_02))
	{
		level.context_sensative_dialog_timeouts[param_00][param_01].groups = [];
		level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)] = spawnstruct();
		level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["timeoutDuration"] = param_03 * 1000;
		level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] = param_03 * -1000;
		return;
	}

	level.context_sensative_dialog_timeouts[param_00][param_01].v["timeoutDuration"] = param_03 * 1000;
	level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] = param_03 * -1000;
}

//Function Number: 6
play_sound_on_entity(param_00)
{
	maps\mp\_utility::play_sound_on_tag(param_00);
}

//Function Number: 7
within_fov(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_02 - param_00);
	var_05 = anglestoforward(param_01);
	var_06 = vectordot(var_05,var_04);
	return var_06 >= param_03;
}

//Function Number: 8
array_remove_nokeys(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != param_01)
		{
			var_02[var_02.size] = param_00[var_03];
		}
	}

	return var_02;
}

//Function Number: 9
array_remove_index(param_00,param_01)
{
	var_02 = [];
	var_03 = getarraykeys(param_00);
	for(var_04 = var_03.size - 1;var_04 >= 0;var_04--)
	{
		if(var_03[var_04] != param_01)
		{
			var_02[var_02.size] = param_00[var_03[var_04]];
		}
	}

	return var_02;
}

//Function Number: 10
string(param_00)
{
	return "" + param_00;
}

//Function Number: 11
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 12
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 13
deleteonac130playerremoved()
{
	level waittill("ac130player_removed");
	self delete();
}

//Function Number: 14
setac130player(param_00)
{
	self endon("ac130player_removed");
	if(isdefined(level.ac130player))
	{
		return 0;
	}

	level.ac130player = param_00;
	level.ac130.owner = param_00;
	level.ac130.planemodel show();
	level.ac130.planemodel thread playac130effects();
	level.ac130.incomingmissile = 0;
	level.ac130.planemodel playloopsound("veh_ac130_ext_dist");
	level.ac130.planemodel thread damagetracker();
	var_01 = spawnplane(param_00,"script_model",level.ac130.planemodel.origin,"compass_objpoint_ac130_friendly","compass_objpoint_ac130_enemy");
	var_01 notsolid();
	var_01 linkto(level.ac130,"tag_player",(0,80,32),(0,-90,0));
	var_01 thread deleteonac130playerremoved();
	param_00 startac130();
	param_00 openmenu("ac130timer");
	level.ac130.numflares = level.ac130_num_flares;
	thread maps\mp\_utility::teamplayercardsplash("used_ac130",param_00);
	param_00 thread waitsetthermal(1);
	param_00 thread maps\mp\_utility::reinitializethermal(level.ac130.planemodel);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 maps\mp\_utility::setthirdpersondof(0);
	}

	param_00 maps\mp\_utility::_giveweapon("ac130_105mm_mp");
	param_00 maps\mp\_utility::_giveweapon("ac130_40mm_mp");
	param_00 maps\mp\_utility::_giveweapon("ac130_25mm_mp");
	param_00 switchtoweapon("ac130_105mm_mp");
	param_00 setplayerdata("ac130Ammo105mm",param_00 getweaponammoclip("ac130_105mm_mp"));
	param_00 setplayerdata("ac130Ammo40mm",param_00 getweaponammoclip("ac130_40mm_mp"));
	param_00 setplayerdata("ac130Ammo25mm",param_00 getweaponammoclip("ac130_25mm_mp"));
	param_00 thread overlay(param_00);
	param_00 thread attachplayer(param_00);
	param_00 thread changeweapons();
	param_00 thread weaponfiredthread();
	param_00 thread context_sensative_dialog();
	param_00 thread shotfired();
	param_00 thread clouds();
	param_00 thread removeac130playeraftertime(level.ac130_use_duration * param_00.killstreakscaler);
	param_00 thread removeac130playerondisconnect();
	param_00 thread removeac130playeronchangeteams();
	param_00 thread removeac130playeronspectate();
	param_00 thread removeac130playeroncrash();
	param_00 thread removeac130playerongamecleanup();
	thread ac130_altscene();
	return 1;
}

//Function Number: 15
waitsetthermal(param_00)
{
	self endon("disconnect");
	level endon("ac130player_removed");
	wait param_00;
	self visionsetthermalforplayer(game["thermal_vision"],0);
	self thermalvisionfofoverlayon();
	thread thermalvision();
}

//Function Number: 16
playac130effects()
{
	wait 0.05;
	playfxontag(level._effect["ac130_light_red_blink"],self,"tag_light_belly");
	playfxontag(level._effect["ac130_engineeffect"],self,"tag_body");
	wait 0.5;
	playfxontag(level._effect["ac130_light_white_blink"],self,"tag_light_tail");
	playfxontag(level._effect["ac130_light_red"],self,"tag_light_top");
}

//Function Number: 17
ac130_altscene()
{
	foreach(var_01 in level.players)
	{
		if(var_01 != level.ac130player && var_01.team == level.ac130player.team)
		{
			var_01 thread maps\mp\_utility::setaltsceneobj(level.ac130.cameramodel,"tag_origin",20);
		}
	}
}

//Function Number: 18
removeac130playerongameend()
{
	self endon("ac130player_removed");
	level waittill("game_ended");
	level thread removeac130player(self,0);
}

//Function Number: 19
removeac130playerongamecleanup()
{
	self endon("ac130player_removed");
	level waittill("game_cleanup");
	level thread removeac130player(self,0);
}

//Function Number: 20
removeac130playerondeath()
{
	self endon("ac130player_removed");
	self waittill("death");
	level thread removeac130player(self,0);
}

//Function Number: 21
removeac130playeroncrash()
{
	self endon("ac130player_removed");
	level.ac130.planemodel waittill("crashing");
	level thread removeac130player(self,0);
}

//Function Number: 22
removeac130playerondisconnect()
{
	self endon("ac130player_removed");
	self waittill("disconnect");
	level thread removeac130player(self,1);
}

//Function Number: 23
removeac130playeronchangeteams()
{
	self endon("ac130player_removed");
	self waittill("joined_team");
	level thread removeac130player(self,0);
}

//Function Number: 24
removeac130playeronspectate()
{
	self endon("ac130player_removed");
	common_scripts\utility::waittill_any("joined_spectators","spawned");
	level thread removeac130player(self,0);
}

//Function Number: 25
removeac130playeraftertime(param_00)
{
	self endon("ac130player_removed");
	var_01 = param_00;
	setdvar("ui_ac130usetime",var_01);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_01);
	level thread removeac130player(self,0);
}

//Function Number: 26
removeac130player(param_00,param_01)
{
	param_00 notify("ac130player_removed");
	level notify("ac130player_removed");
	level.ac130.cameramodel notify("death");
	waittillframeend;
	if(!param_01)
	{
		param_00 maps\mp\_utility::clearusingremote();
		param_00 stoplocalsound("missile_incoming");
		param_00 show();
		param_00 unlink();
		param_00 thermalvisionoff();
		param_00 thermalvisionfofoverlayoff();
		param_00 visionsetthermalforplayer(level.ac130.thermal_vision,0);
		param_00.lastvisionsetthermal = level.ac130.thermal_vision;
		param_00 setblurforplayer(0,0);
		param_00 stopac130();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(1);
		}

		var_02 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon("ac130");
		param_00 takeweapon(var_02);
		param_00 takeweapon("ac130_105mm_mp");
		param_00 takeweapon("ac130_40mm_mp");
		param_00 takeweapon("ac130_25mm_mp");
		if(isdefined(param_00.darkscreenoverlay))
		{
			param_00.darkscreenoverlay destroy();
		}

		var_03 = getarraykeys(level.huditem);
		foreach(var_05 in var_03)
		{
			level.huditem[var_05] destroy();
			level.huditem[var_05] = undefined;
		}
	}

	wait 0.5;
	level.ac130.planemodel playsound("veh_ac130_ext_dist_fade");
	wait 0.5;
	level.ac130player = undefined;
	level.ac130.planemodel hide();
	level.ac130.planemodel stoploopsound();
	if(isdefined(level.ac130.planemodel.crashed))
	{
		level.ac130inuse = 0;
		return;
	}

	var_07 = spawn("script_model",level.ac130.planemodel gettagorigin("tag_origin"));
	var_07.angles = level.ac130.planemodel.angles;
	var_07 setmodel("vehicle_ac130_coop");
	var_08 = var_07.origin + anglestoright(var_07.angles) * 20000;
	var_07 thread playac130effects();
	var_07 moveto(var_08,40,0,0);
	var_07 thread deployflares(1);
	wait 5;
	var_07 thread deployflares(1);
	wait 5;
	var_07 thread deployflares(1);
	level.ac130inuse = 0;
	wait 30;
	var_07 delete();
}

//Function Number: 27
damagetracker()
{
	self endon("death");
	self endon("crashing");
	level endon("game_ended");
	level endon("ac130player_removed");
	self.health = 999999;
	self.maxhealth = 1000;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(level.ac130player) && level.teambased && isplayer(var_01) && var_01.team == level.ac130player.team && !isdefined(level.nukedetonated))
		{
			continue;
		}

		if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET")
		{
			continue;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ac130");
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ac130");
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01))
			{
				thread maps\mp\gametypes\_missions::vehiclekilled(level.ac130player,self,undefined,var_01,var_00,var_04,var_09);
				thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_ac130",var_01);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",400,var_09,var_04);
				var_01 notify("destroyed_killstreak");
			}

			level thread crashplane(10);
		}
	}
}

//Function Number: 28
ac130_spawn()
{
	wait 0.05;
	var_00 = spawn("script_model",level.ac130 gettagorigin("tag_player"));
	var_00 setmodel("vehicle_ac130_coop");
	var_00.targetname = "vehicle_ac130_coop";
	var_00 setcandamage(1);
	var_00.maxhealth = 1000;
	var_00.health = var_00.maxhealth;
	var_00 linkto(level.ac130,"tag_player",(0,80,32),(-25,0,0));
	level.ac130.planemodel = var_00;
	level.ac130.planemodel hide();
	var_01 = spawn("script_model",level.ac130 gettagorigin("tag_player"));
	var_01 setmodel("tag_origin");
	var_01 hide();
	var_01.targetname = "ac130CameraModel";
	var_01 linkto(level.ac130,"tag_player",(0,0,32),(-25,0,0));
	level.ac130.cameramodel = var_01;
	level.ac130player = level.players[0];
}

//Function Number: 29
overlay(param_00)
{
	level.huditem = [];
	level.huditem["thermal_vision"] = newclienthudelem(param_00);
	level.huditem["thermal_vision"].x = 200;
	level.huditem["thermal_vision"].y = 0;
	level.huditem["thermal_vision"].alignx = "left";
	level.huditem["thermal_vision"].aligny = "top";
	level.huditem["thermal_vision"].horzalign = "left";
	level.huditem["thermal_vision"].vertalign = "top";
	level.huditem["thermal_vision"].fontscale = 2.5;
	level.huditem["thermal_vision"] settext(&"AC130_HUD_FLIR");
	level.huditem["thermal_vision"].alpha = 1;
	level.huditem["enhanced_vision"] = newclienthudelem(param_00);
	level.huditem["enhanced_vision"].x = -200;
	level.huditem["enhanced_vision"].y = 0;
	level.huditem["enhanced_vision"].alignx = "right";
	level.huditem["enhanced_vision"].aligny = "top";
	level.huditem["enhanced_vision"].horzalign = "right";
	level.huditem["enhanced_vision"].vertalign = "top";
	level.huditem["enhanced_vision"].fontscale = 2.5;
	level.huditem["enhanced_vision"] settext(&"AC130_HUD_OPTICS");
	level.huditem["enhanced_vision"].alpha = 1;
	param_00 thread overlay_coords();
	param_00 setblurforplayer(1.2,0);
}

//Function Number: 30
overlay_coords()
{
	self endon("ac130player_removed");
	level.huditem["coord1_posx"] = newclienthudelem(self);
	level.huditem["coord1_posx"].x = 60;
	level.huditem["coord1_posx"].y = 100;
	level.huditem["coord1_posx"].alignx = "right";
	level.huditem["coord1_posx"].aligny = "middle";
	level.huditem["coord1_posx"].horzalign = "center";
	level.huditem["coord1_posx"].vertalign = "middle";
	level.huditem["coord1_posx"].fontscale = 1;
	level.huditem["coord1_posx"].alpha = 1;
	level.huditem["coord1_posy"] = newclienthudelem(self);
	level.huditem["coord1_posy"].x = 100;
	level.huditem["coord1_posy"].y = 100;
	level.huditem["coord1_posy"].alignx = "right";
	level.huditem["coord1_posy"].aligny = "middle";
	level.huditem["coord1_posy"].horzalign = "center";
	level.huditem["coord1_posy"].vertalign = "middle";
	level.huditem["coord1_posy"].fontscale = 1;
	level.huditem["coord1_posy"].alpha = 1;
	level.huditem["coord1_posz"] = newclienthudelem(self);
	level.huditem["coord1_posz"].x = 140;
	level.huditem["coord1_posz"].y = 100;
	level.huditem["coord1_posz"].alignx = "right";
	level.huditem["coord1_posz"].aligny = "middle";
	level.huditem["coord1_posz"].horzalign = "center";
	level.huditem["coord1_posz"].vertalign = "middle";
	level.huditem["coord1_posz"].fontscale = 1;
	level.huditem["coord1_posz"].alpha = 1;
	level.huditem["coord2_posx"] = newclienthudelem(self);
	level.huditem["coord2_posx"].x = 60;
	level.huditem["coord2_posx"].y = 110;
	level.huditem["coord2_posx"].alignx = "right";
	level.huditem["coord2_posx"].aligny = "middle";
	level.huditem["coord2_posx"].horzalign = "center";
	level.huditem["coord2_posx"].vertalign = "middle";
	level.huditem["coord2_posx"].fontscale = 1;
	level.huditem["coord2_posx"].alpha = 1;
	level.huditem["coord2_posy"] = newclienthudelem(self);
	level.huditem["coord2_posy"].x = 100;
	level.huditem["coord2_posy"].y = 110;
	level.huditem["coord2_posy"].alignx = "right";
	level.huditem["coord2_posy"].aligny = "middle";
	level.huditem["coord2_posy"].horzalign = "center";
	level.huditem["coord2_posy"].vertalign = "middle";
	level.huditem["coord2_posy"].fontscale = 1;
	level.huditem["coord2_posy"].alpha = 1;
	level.huditem["coord2_posz"] = newclienthudelem(self);
	level.huditem["coord2_posz"].x = 140;
	level.huditem["coord2_posz"].y = 110;
	level.huditem["coord2_posz"].alignx = "right";
	level.huditem["coord2_posz"].aligny = "middle";
	level.huditem["coord2_posz"].horzalign = "center";
	level.huditem["coord2_posz"].vertalign = "middle";
	level.huditem["coord2_posz"].fontscale = 1;
	level.huditem["coord2_posz"].alpha = 1;
	level.huditem["coord3_posx"] = newclienthudelem(self);
	level.huditem["coord3_posx"].x = -120;
	level.huditem["coord3_posx"].y = 100;
	level.huditem["coord3_posx"].alignx = "right";
	level.huditem["coord3_posx"].aligny = "middle";
	level.huditem["coord3_posx"].horzalign = "center";
	level.huditem["coord3_posx"].vertalign = "middle";
	level.huditem["coord3_posx"].fontscale = 1;
	level.huditem["coord3_posx"].alpha = 1;
	level.huditem["coord3_posy"] = newclienthudelem(self);
	level.huditem["coord3_posy"].x = -80;
	level.huditem["coord3_posy"].y = 100;
	level.huditem["coord3_posy"].alignx = "right";
	level.huditem["coord3_posy"].aligny = "middle";
	level.huditem["coord3_posy"].horzalign = "center";
	level.huditem["coord3_posy"].vertalign = "middle";
	level.huditem["coord3_posy"].fontscale = 1;
	level.huditem["coord3_posy"].alpha = 1;
	level.huditem["coord3_posz"] = newclienthudelem(self);
	level.huditem["coord3_posz"].x = -40;
	level.huditem["coord3_posz"].y = 100;
	level.huditem["coord3_posz"].alignx = "right";
	level.huditem["coord3_posz"].aligny = "middle";
	level.huditem["coord3_posz"].horzalign = "center";
	level.huditem["coord3_posz"].vertalign = "middle";
	level.huditem["coord3_posz"].fontscale = 1;
	level.huditem["coord3_posz"].alpha = 1;
	wait 0.05;
	thread updateaimingcoords();
	for(;;)
	{
		level.huditem["coord1_posx"] setvalue(abs(level.ac130.planemodel.origin[0]));
		level.huditem["coord1_posy"] setvalue(abs(level.ac130.planemodel.origin[1]));
		level.huditem["coord1_posz"] setvalue(abs(level.ac130.planemodel.origin[2]));
		level.huditem["coord2_posx"] setvalue(abs(self.origin[0]));
		level.huditem["coord2_posy"] setvalue(abs(self.origin[1]));
		level.huditem["coord2_posz"] setvalue(abs(self.origin[2]));
		wait 0.5;
	}
}

//Function Number: 31
updateaimingcoords()
{
	self endon("ac130player_removed");
	for(;;)
	{
		var_00 = self geteye();
		var_01 = self getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = var_00 + var_02 * 15000;
		var_04 = physicstrace(var_00,var_03);
		level.huditem["coord3_posx"] setvalue(abs(var_04[0]));
		level.huditem["coord3_posy"] setvalue(abs(var_04[1]));
		level.huditem["coord3_posz"] setvalue(abs(var_04[2]));
		wait 0.05;
	}
}

//Function Number: 32
ac130shellshock()
{
	self endon("ac130player_removed");
	level endon("post_effects_disabled");
	var_00 = 5;
	for(;;)
	{
		self shellshock("ac130",var_00);
		wait var_00;
	}
}

//Function Number: 33
rotateplane(param_00)
{
	level notify("stop_rotatePlane_thread");
	level endon("stop_rotatePlane_thread");
	if(param_00 == "on")
	{
		var_01 = 10;
		var_02 = level.ac130_speed["rotate"] / 360 * var_01;
		level.ac130 rotateyaw(level.ac130.angles[2] + var_01,var_02,var_02,0);
		for(;;)
		{
			level.ac130 rotateyaw(360,level.ac130_speed["rotate"]);
			wait level.ac130_speed["rotate"];
		}

		return;
	}

	if(param_00 == "off")
	{
		var_03 = 10;
		var_02 = level.ac130_speed["rotate"] / 360 * var_03;
		level.ac130 rotateyaw(level.ac130.angles[2] + var_03,var_02,0,var_02);
	}
}

//Function Number: 34
attachplayer(param_00)
{
	self playerlinkweaponviewtodelta(level.ac130,"tag_player",1,35,35,35,35);
	self setplayerangles(level.ac130 gettagangles("tag_player"));
}

//Function Number: 35
changeweapons()
{
	self endon("ac130player_removed");
	wait 0.05;
	self enableweapons();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		thread play_sound_on_entity("ac130_weapon_switch");
	}
}

//Function Number: 36
weaponfiredthread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = self getcurrentweapon();
		switch(var_00)
		{
			case "ac130_105mm_mp":
				thread gun_fired_and_ready_105mm();
				earthquake(0.2,1,level.ac130.planemodel.origin,1000);
				self setplayerdata("ac130Ammo105mm",self getweaponammoclip(var_00));
				break;
	
			case "ac130_40mm_mp":
				earthquake(0.1,0.5,level.ac130.planemodel.origin,1000);
				self setplayerdata("ac130Ammo40mm",self getweaponammoclip(var_00));
				break;
	
			case "ac130_25mm_mp":
				self setplayerdata("ac130Ammo25mm",self getweaponammoclip(var_00));
				break;
		}

		if(self getweaponammoclip(var_00))
		{
			continue;
		}

		thread weaponreload(var_00);
	}
}

//Function Number: 37
weaponreload(param_00)
{
	self endon("ac130player_removed");
	wait level.weaponreloadtime[param_00];
	self setweaponammoclip(param_00,9999);
	switch(param_00)
	{
		case "ac130_105mm_mp":
			self setplayerdata("ac130Ammo105mm",self getweaponammoclip(param_00));
			break;

		case "ac130_40mm_mp":
			self setplayerdata("ac130Ammo40mm",self getweaponammoclip(param_00));
			break;

		case "ac130_25mm_mp":
			self setplayerdata("ac130Ammo25mm",self getweaponammoclip(param_00));
			break;
	}

	if(self getcurrentweapon() == param_00)
	{
		self takeweapon(param_00);
		maps\mp\_utility::_giveweapon(param_00);
		self switchtoweapon(param_00);
	}
}

//Function Number: 38
thermalvision()
{
	self endon("ac130player_removed");
	if(maps\mp\_utility::getintproperty("ac130_thermal_enabled",1) == 0)
	{
		return;
	}

	var_00 = 0;
	self thermalvisionoff();
	self visionsetthermalforplayer(level.ac130.enhanced_vision,1);
	self.lastvisionsetthermal = level.ac130.enhanced_vision;
	level.huditem["thermal_vision"].alpha = 0.25;
	level.huditem["enhanced_vision"].alpha = 1;
	self notifyonplayercommand("switch thermal","+usereload");
	self notifyonplayercommand("switch thermal","+activate");
	for(;;)
	{
		self waittill("switch thermal");
		if(!var_00)
		{
			self thermalvisionon();
			self visionsetthermalforplayer(level.ac130.thermal_vision,0.62);
			self.lastvisionsetthermal = level.ac130.thermal_vision;
			level.huditem["thermal_vision"].alpha = 1;
			level.huditem["enhanced_vision"].alpha = 0.25;
		}
		else
		{
			self thermalvisionoff();
			self visionsetthermalforplayer(level.ac130.enhanced_vision,0.51);
			self.lastvisionsetthermal = level.ac130.enhanced_vision;
			level.huditem["thermal_vision"].alpha = 0.25;
			level.huditem["enhanced_vision"].alpha = 1;
		}

		var_00 = !var_00;
	}
}

//Function Number: 39
clouds()
{
	self endon("ac130player_removed");
	wait 6;
	clouds_create();
	for(;;)
	{
		wait randomfloatrange(40,80);
		clouds_create();
	}
}

//Function Number: 40
clouds_create()
{
	if(isdefined(level.playerweapon) && issubstr(tolower(level.playerweapon),"25"))
	{
		return;
	}

	playfxontagforclients(level._effect["cloud"],level.ac130,"tag_player",level.ac130player);
}

//Function Number: 41
gun_fired_and_ready_105mm()
{
	self endon("ac130player_removed");
	level notify("gun_fired_and_ready_105mm");
	level endon("gun_fired_and_ready_105mm");
	wait 0.5;
	if(randomint(2) == 0)
	{
		thread context_sensative_dialog_play_random_group_sound("weapons","105mm_fired");
	}

	wait 5;
	thread context_sensative_dialog_play_random_group_sound("weapons","105mm_ready");
}

//Function Number: 42
shotfired()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("projectile_impact",var_00,var_01,var_02);
		if(issubstr(tolower(var_00),"105"))
		{
			earthquake(0.4,1,var_01,3500);
			thread shotfireddarkscreenoverlay();
		}
		else if(issubstr(tolower(var_00),"40"))
		{
			earthquake(0.2,0.5,var_01,2000);
		}

		if(maps\mp\_utility::getintproperty("ac130_ragdoll_deaths",0))
		{
			thread shotfiredphysicssphere(var_01,var_00);
		}

		wait 0.05;
	}
}

//Function Number: 43
shotfiredphysicssphere(param_00,param_01)
{
	wait 0.1;
	physicsexplosionsphere(param_00,level.physicssphereradius[param_01],level.physicssphereradius[param_01] / 2,level.physicssphereforce[param_01]);
}

//Function Number: 44
shotfireddarkscreenoverlay()
{
	self endon("ac130player_removed");
	self notify("darkScreenOverlay");
	self endon("darkScreenOverlay");
	if(!isdefined(self.darkscreenoverlay))
	{
		self.darkscreenoverlay = newclienthudelem(self);
		self.darkscreenoverlay.x = 0;
		self.darkscreenoverlay.y = 0;
		self.darkscreenoverlay.alignx = "left";
		self.darkscreenoverlay.aligny = "top";
		self.darkscreenoverlay.horzalign = "fullscreen";
		self.darkscreenoverlay.vertalign = "fullscreen";
		self.darkscreenoverlay setshader("black",640,480);
		self.darkscreenoverlay.sort = -10;
		self.darkscreenoverlay.alpha = 0;
	}

	self.darkscreenoverlay.alpha = 0;
	self.darkscreenoverlay fadeovertime(0.2);
	self.darkscreenoverlay.alpha = 0.6;
	wait 0.4;
	self.darkscreenoverlay fadeovertime(0.8);
	self.darkscreenoverlay.alpha = 0;
}

//Function Number: 45
add_beacon_effect()
{
	self endon("death");
	var_00 = 0.75;
	wait randomfloat(3);
	for(;;)
	{
		if(level.ac130player)
		{
			playfxontagforclients(level._effect["beacon"],self,"j_spine4",level.ac130player);
		}

		wait var_00;
	}
}

//Function Number: 46
context_sensative_dialog()
{
	thread enemy_killed_thread();
	thread context_sensative_dialog_guy_in_sight();
	thread context_sensative_dialog_guy_crawling();
	thread context_sensative_dialog_guy_pain();
	thread context_sensative_dialog_secondary_explosion_vehicle();
	thread context_sensative_dialog_kill_thread();
	thread context_sensative_dialog_locations();
	thread context_sensative_dialog_filler();
}

//Function Number: 47
context_sensative_dialog_guy_in_sight()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(context_sensative_dialog_guy_in_sight_check())
		{
			thread context_sensative_dialog_play_random_group_sound("ai","in_sight");
		}

		wait randomfloatrange(1,3);
	}
}

//Function Number: 48
context_sensative_dialog_guy_in_sight_check()
{
	var_00 = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!isdefined(var_00[var_01]))
		{
			continue;
		}

		if(!isalive(var_00[var_01]))
		{
			continue;
		}

		if(within_fov(level.ac130player geteye(),level.ac130player getplayerangles(),var_00[var_01].origin,level.cosine["5"]))
		{
			return 1;
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 49
context_sensative_dialog_guy_crawling()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_crawling",var_00);
		thread context_sensative_dialog_play_random_group_sound("ai","wounded_crawl");
	}
}

//Function Number: 50
context_sensative_dialog_guy_pain()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_pain",var_00);
		thread context_sensative_dialog_play_random_group_sound("ai","wounded_pain");
	}
}

//Function Number: 51
context_sensative_dialog_secondary_explosion_vehicle()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("player_destroyed_car",var_00,var_01);
		wait 1;
		thread context_sensative_dialog_play_random_group_sound("explosion","secondary");
	}
}

//Function Number: 52
enemy_killed_thread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_killed",var_00);
		thread context_sensative_dialog_kill(var_00,level.ac130player);
	}
}

//Function Number: 53
context_sensative_dialog_kill(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	level.enemieskilledintimewindow++;
	level notify("enemy_killed");
}

//Function Number: 54
context_sensative_dialog_kill_thread()
{
	self endon("ac130player_removed");
	var_00 = 1;
	for(;;)
	{
		level waittill("enemy_killed");
		wait var_00;
		var_01 = "kill";
		var_02 = undefined;
		if(level.enemieskilledintimewindow >= 2)
		{
			var_02 = "small_group";
		}
		else
		{
			var_02 = "single";
			if(randomint(3) != 1)
			{
				level.enemieskilledintimewindow = 0;
				continue;
			}
		}

		level.enemieskilledintimewindow = 0;
		thread context_sensative_dialog_play_random_group_sound(var_01,var_02,1);
	}
}

//Function Number: 55
context_sensative_dialog_locations()
{
	common_scripts\utility::array_thread(getentarray("context_dialog_car","targetname"),::context_sensative_dialog_locations_add_notify_event,"car");
	common_scripts\utility::array_thread(getentarray("context_dialog_truck","targetname"),::context_sensative_dialog_locations_add_notify_event,"truck");
	common_scripts\utility::array_thread(getentarray("context_dialog_building","targetname"),::context_sensative_dialog_locations_add_notify_event,"building");
	common_scripts\utility::array_thread(getentarray("context_dialog_wall","targetname"),::context_sensative_dialog_locations_add_notify_event,"wall");
	common_scripts\utility::array_thread(getentarray("context_dialog_field","targetname"),::context_sensative_dialog_locations_add_notify_event,"field");
	common_scripts\utility::array_thread(getentarray("context_dialog_road","targetname"),::context_sensative_dialog_locations_add_notify_event,"road");
	common_scripts\utility::array_thread(getentarray("context_dialog_church","targetname"),::context_sensative_dialog_locations_add_notify_event,"church");
	common_scripts\utility::array_thread(getentarray("context_dialog_ditch","targetname"),::context_sensative_dialog_locations_add_notify_event,"ditch");
	thread context_sensative_dialog_locations_thread();
}

//Function Number: 56
context_sensative_dialog_locations_thread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("context_location",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(!common_scripts\utility::flag("allow_context_sensative_dialog"))
		{
			continue;
		}

		thread context_sensative_dialog_play_random_group_sound("location",var_00);
		wait 5 + randomfloat(10);
	}
}

//Function Number: 57
context_sensative_dialog_locations_add_notify_event(param_00)
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.team) || var_01.team != "axis")
		{
			continue;
		}

		level notify("context_location",param_00);
		wait 5;
	}
}

//Function Number: 58
context_sensative_dialog_vehiclespawn(param_00)
{
	if(param_00.script_team != "axis")
	{
		return;
	}

	thread context_sensative_dialog_vehicledeath(param_00);
	param_00 endon("death");
	while(!within_fov(level.ac130player geteye(),level.ac130player getplayerangles(),param_00.origin,level.cosine["45"]))
	{
		wait 0.5;
	}

	context_sensative_dialog_play_random_group_sound("vehicle","incoming");
}

//Function Number: 59
context_sensative_dialog_vehicledeath(param_00)
{
	param_00 waittill("death");
	thread context_sensative_dialog_play_random_group_sound("vehicle","death");
}

//Function Number: 60
context_sensative_dialog_filler()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(isdefined(level.radio_in_use) && level.radio_in_use == 1)
		{
			level waittill("radio_not_in_use");
		}

		var_00 = gettime();
		if(var_00 - level.lastradiotransmission >= 3000)
		{
			level.lastradiotransmission = var_00;
			thread context_sensative_dialog_play_random_group_sound("misc","action");
		}

		wait 0.25;
	}
}

//Function Number: 61
context_sensative_dialog_play_random_group_sound(param_00,param_01,param_02)
{
	level endon("ac130player_removed");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!common_scripts\utility::flag("allow_context_sensative_dialog"))
	{
		if(param_02)
		{
			common_scripts\utility::flag_wait("allow_context_sensative_dialog");
		}
		else
		{
			return;
		}
	}

	var_03 = undefined;
	var_04 = randomint(level.scr_sound[param_00][param_01].size);
	if(level.scr_sound[param_00][param_01][var_04].played == 1)
	{
		for(var_05 = 0;var_05 < level.scr_sound[param_00][param_01].size;var_05++)
		{
			var_04++;
			if(var_04 >= level.scr_sound[param_00][param_01].size)
			{
				var_04 = 0;
			}

			if(level.scr_sound[param_00][param_01][var_04].played == 1)
			{
				continue;
			}

			var_03 = var_04;
			break;
		}

		if(!isdefined(var_03))
		{
			for(var_05 = 0;var_05 < level.scr_sound[param_00][param_01].size;var_05++)
			{
				level.scr_sound[param_00][param_01][var_05].played = 0;
			}

			var_03 = randomint(level.scr_sound[param_00][param_01].size);
		}
	}
	else
	{
		var_03 = var_04;
	}

	if(context_sensative_dialog_timedout(param_00,param_01,var_03))
	{
		return;
	}

	level.scr_sound[param_00][param_01][var_03].played = 1;
	var_06 = randomint(level.scr_sound[param_00][param_01][var_03].size);
	playsoundoverradio(level.scr_sound[param_00][param_01][var_03].sounds[var_06],param_02);
}

//Function Number: 62
context_sensative_dialog_timedout(param_00,param_01,param_02)
{
	if(!isdefined(level.context_sensative_dialog_timeouts))
	{
		return 0;
	}

	if(!isdefined(level.context_sensative_dialog_timeouts[param_00]))
	{
		return 0;
	}

	if(!isdefined(level.context_sensative_dialog_timeouts[param_00][param_01]))
	{
		return 0;
	}

	if(isdefined(level.context_sensative_dialog_timeouts[param_00][param_01].groups) && isdefined(level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)]))
	{
		var_03 = gettime();
		if(var_03 - level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["timeoutDuration"])
		{
			return 1;
		}

		level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] = var_03;
	}
	else if(isdefined(level.context_sensative_dialog_timeouts[param_00][param_01].v))
	{
		var_03 = gettime();
		if(var_03 - level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] < level.context_sensative_dialog_timeouts[param_00][param_01].v["timeoutDuration"])
		{
			return 1;
		}

		level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] = var_03;
	}

	return 0;
}

//Function Number: 63
playsoundoverradio(param_00,param_01,param_02)
{
	if(!isdefined(level.radio_in_use))
	{
		level.radio_in_use = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	param_02 = param_02 * 1000;
	var_03 = gettime();
	var_04 = 0;
	var_04 = playaliasoverradio(param_00);
	if(var_04)
	{
		return;
	}

	if(!param_01)
	{
		return;
	}

	level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = param_00;
	while(!var_04)
	{
		if(level.radio_in_use)
		{
			level waittill("radio_not_in_use");
		}

		if(param_02 > 0 && gettime() - var_03 > param_02)
		{
			break;
		}

		if(!isdefined(level.ac130player))
		{
			break;
		}

		var_04 = playaliasoverradio(level.radioforcedtransmissionqueue[0]);
		if(!level.radio_in_use && isdefined(level.ac130player) && !var_04)
		{
		}
	}

	level.radioforcedtransmissionqueue = array_remove_index(level.radioforcedtransmissionqueue,0);
}

//Function Number: 64
playaliasoverradio(param_00)
{
	if(level.radio_in_use)
	{
		return 0;
	}

	if(!isdefined(level.ac130player))
	{
		return 0;
	}

	level.radio_in_use = 1;
	if(self.team == "allies" || self.team == "axis")
	{
		param_00 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + param_00;
		level.ac130player playlocalsound(param_00);
	}

	wait 4;
	level.radio_in_use = 0;
	level.lastradiotransmission = gettime();
	level notify("radio_not_in_use");
	return 1;
}

//Function Number: 65
debug_circle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 16;
	var_07 = 360 / var_06;
	var_08 = [];
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		var_0A = var_07 * var_09;
		var_0B = cos(var_0A) * param_01;
		var_0C = sin(var_0A) * param_01;
		var_0D = param_00[0] + var_0B;
		var_0E = param_00[1] + var_0C;
		var_0F = param_00[2];
		var_08[var_08.size] = (var_0D,var_0E,var_0F);
	}

	if(isdefined(param_04))
	{
		wait param_04;
	}

	thread debug_circle_drawlines(var_08,param_02,param_03,param_05,param_00);
}

//Function Number: 66
debug_circle_drawlines(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_03 = 0;
	}

	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_06 = param_00[var_05];
		if(var_05 + 1 >= param_00.size)
		{
			var_07 = param_00[0];
		}
		else
		{
			var_07 = param_00[var_05 + 1];
		}

		thread debug_line(var_06,var_07,param_01,param_02);
		if(param_03)
		{
			thread debug_line(param_04,var_06,param_01,param_02);
		}
	}
}

//Function Number: 67
debug_line(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 68
handleincomingstinger()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != level.ac130.planemodel)
		{
			continue;
		}

		var_01 thread stingerproximitydetonate(var_00,var_00.team);
	}
}

//Function Number: 69
deleteaftertime(param_00)
{
	wait param_00;
	self delete();
}

//Function Number: 70
stingerproximitydetonate(param_00,param_01)
{
	self endon("death");
	if(isdefined(level.ac130player))
	{
		level.ac130player playlocalsound("missile_incoming");
	}

	level.ac130.incomingmissile = 1;
	var_02 = level.ac130.planemodel;
	self missile_settargetent(var_02);
	var_03 = 0;
	var_04 = var_02 getpointinbounds(0,0,0);
	var_05 = distance(self.origin,var_04);
	var_06 = vectornormalize(var_04 - self.origin);
	for(;;)
	{
		if(!isdefined(level.ac130player) || isdefined(level.ac130.planemodel.crashed) && level.ac130.planemodel.crashed == 1)
		{
			self missile_settargetpos(level.ac130.origin + (0,0,100000));
			return;
		}

		var_04 = var_02 getpointinbounds(0,0,0);
		var_07 = distance(self.origin,var_04);
		if(var_07 < 3000 && var_02 == level.ac130.planemodel && level.ac130.numflares > 0)
		{
			level.ac130.numflares--;
			var_08 = var_02 deployflares();
			self missile_settargetent(var_08);
			var_02 = var_08;
			if(isdefined(level.ac130player))
			{
				level.ac130player stoplocalsound("missile_incoming");
			}

			return;
		}

		if(var_0B < var_06)
		{
			var_09 = var_06 - var_0B * 20;
			var_0A = var_0B / var_09;
			if(var_0A < 1.5 && !var_04 && var_03 == level.ac130.planemodel)
			{
				if(isdefined(level.ac130player))
				{
					level.ac130player playlocalsound("fasten_seatbelts");
				}

				var_04 = 1;
			}

			var_06 = var_0B;
		}

		var_08 = vectornormalize(var_05 - self.origin);
		if(vectordot(var_08,var_07) < 0)
		{
			if(isdefined(level.ac130player))
			{
				level.ac130player stoplocalsound("missile_incoming");
				if(level.ac130player.team != var_02)
				{
					radiusdamage(self.origin,1000,1000,1000,param_01,"MOD_EXPLOSIVE","stinger_mp");
				}
			}

			self hide();
			wait 0.05;
			self delete();
		}
		else
		{
			var_07 = var_08;
		}

		wait 0.05;
	}
}

//Function Number: 71
handleincomingsam()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("sam_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != level.ac130.planemodel)
		{
			continue;
		}

		level thread samproximitydetonate(var_00,var_00.team,var_01);
	}
}

//Function Number: 72
samproximitydetonate(param_00,param_01,param_02)
{
	if(isdefined(level.ac130player))
	{
		level.ac130player playlocalsound("missile_incoming");
	}

	level.ac130.incomingmissile = 1;
	var_03 = level.ac130.planemodel;
	var_04 = 0;
	var_05 = [];
	var_06 = var_03 getpointinbounds(0,0,0);
	for(var_07 = 0;var_07 < param_02.size;var_07++)
	{
		if(isdefined(param_02[var_07]))
		{
			var_05[var_07] = distance(param_02[var_07].origin,var_06);
			param_02[var_07].lastvectotarget = vectornormalize(var_06 - param_02[var_07].origin);
			continue;
		}

		var_05[var_07] = undefined;
	}

	for(;;)
	{
		if(!isdefined(level.ac130player) || isdefined(level.ac130.planemodel.crashed) && level.ac130.planemodel.crashed == 1)
		{
			for(var_07 = 0;var_07 < param_02.size;var_07++)
			{
				if(isdefined(param_02[var_07]))
				{
					param_02[var_07] missile_settargetpos(level.ac130.origin + (0,0,100000));
				}
			}

			return;
		}

		var_06 = var_03 getpointinbounds(0,0,0);
		var_08 = [];
		var_07 = 0;
		while(var_07 < param_02.size)
		{
			if(isdefined(param_02[var_07]))
			{
			}

			var_08++ = var_7B[var_07];
		}

		if(!isdefined(level.ac130player))
		{
			return;
		}

		var_08 = 0;
		while(var_08 < var_7B.size)
		{
			if(isdefined(var_7B[var_08]))
			{
				if(var_7B[var_08] < 3000 && var_04 == level.ac130.planemodel && level.ac130.numflares > 0)
				{
					level.ac130.numflares-- = distance(param_02[var_07].origin,var_06);
					var_09 = var_04 deployflares();
					for(var_0A = 0;var_0A < var_03.size;var_0A++)
					{
						if(isdefined(var_03[var_0A]))
						{
							var_03[var_0A] missile_settargetent(var_09);
						}
					}

					if(isdefined(level.ac130player))
					{
						level.ac130player stoplocalsound("missile_incoming");
					}

					return;
				}

				if(var_0A[var_09] < var_08[var_09])
				{
					var_0B = var_08[var_09] - var_0A[var_09] * 20;
					var_0C = var_0A[var_09] / var_0B;
					if(var_0C < 1.5 && !var_07 && var_06 == level.ac130.planemodel)
					{
						if(isdefined(level.ac130player))
						{
							level.ac130player playlocalsound("fasten_seatbelts");
						}

						var_07 = 1;
					}

					var_08[var_09] = var_0A[var_09];
				}

				var_0D = vectornormalize(var_7B - var_05[var_09].origin);
				if(vectordot(var_0D,var_05[var_09].lastvectotarget) < 0)
				{
					if(isdefined(level.ac130player))
					{
						level.ac130player stoplocalsound("missile_incoming");
						if(level.teambased)
						{
							if(level.ac130player.team != var_04)
							{
								radiusdamage(var_05[var_09].origin,1000,1000,1000,var_03,"MOD_EXPLOSIVE","sam_projectile_mp");
							}
						}
						else
						{
							radiusdamage(var_05[var_09].origin,1000,1000,1000,var_03,"MOD_EXPLOSIVE","sam_projectile_mp");
						}
					}

					var_05[var_09] hide();
					wait 0.05;
					var_05[var_09] delete();
				}
			}

			var_09++;
		}

		wait 0.05;
	}
}

//Function Number: 73
crashplane(param_00)
{
	level.ac130.planemodel notify("crashing");
	level.ac130.planemodel.crashed = 1;
	playfxontag(level._effect["ac130_explode"],level.ac130.planemodel,"tag_deathfx");
	wait 0.25;
	level.ac130.planemodel hide();
}

//Function Number: 74
playflarefx(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		thread angel_flare();
		wait randomfloatrange(0.1,0.25);
	}
}

//Function Number: 75
deployflares(param_00)
{
	self playsound("ac130_flare_burst");
	if(!isdefined(param_00))
	{
		var_01 = spawn("script_origin",level.ac130.planemodel.origin);
		var_01.angles = level.ac130.planemodel.angles;
		var_01 movegravity((0,0,0),5);
		thread playflarefx(10);
		var_01 thread deleteaftertime(5);
		return var_01;
	}

	thread playflarefx(5);
}

//Function Number: 76
angelflareprecache()
{
	precachemodel("angel_flare_rig");
	precachempanim("ac130_angel_flares01");
	precachempanim("ac130_angel_flares02");
	precachempanim("ac130_angel_flares03");
	level._effect["angel_flare_geotrail"] = loadfx("smoke/angel_flare_geotrail");
	level._effect["angel_flare_swirl"] = loadfx("smoke/angel_flare_swirl_runner");
}

//Function Number: 77
angel_flare()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("angel_flare_rig");
	var_00.origin = self gettagorigin("tag_flash_flares");
	var_00.angles = self gettagangles("tag_flash_flares");
	var_00.angles = (var_00.angles[0],var_00.angles[1] + 180,var_00.angles[2] + -90);
	var_01 = level._effect["angel_flare_geotrail"];
	var_00 scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
	wait 0.1;
	playfxontag(var_01,var_00,"flare_left_top");
	playfxontag(var_01,var_00,"flare_right_top");
	wait 0.05;
	playfxontag(var_01,var_00,"flare_left_bot");
	playfxontag(var_01,var_00,"flare_right_bot");
	wait 3;
	stopfxontag(var_01,var_00,"flare_left_top");
	stopfxontag(var_01,var_00,"flare_right_top");
	stopfxontag(var_01,var_00,"flare_left_bot");
	stopfxontag(var_01,var_00,"flare_right_bot");
	var_00 delete();
}
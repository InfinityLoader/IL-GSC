/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_ac130.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level.ac130_use_duration = 40;
	level.ac130_num_flares = 2;
	makedvarserverinfo("ui_ac130usetime", level.ac130_use_duration);
	precacheshader("black");
	precachestring(&"AC130_HUD_THERMAL_WHOT");
	precachestring(&"AC130_HUD_THERMAL_BHOT");
	precachestring(&"AC130_HUD_AGL");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
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
	minimaporigins = getentarray("minimap_corner", "targetname");
	ac130origin = (0,0,0);
	if(minimaporigins.size)
	{
		ac130origin = maps\mp\gametypes\_spawnlogic::findboxcenter(minimaporigins[0].origin, minimaporigins[1].origin);
	}

	level.ac130 = spawn("script_model", ac130origin);
	level.ac130 setmodel("c130_zoomrig");
	level.ac130.angles = (0,115,0);
	level.ac130.owner = undefined;
	level.ac130 hide();
	level.ac130inuse = 0;
	init_sounds();
	thread rotateplane("on");
	thread ac130_spawn();
	thread onplayerconnect();
	thread handleincomingstinger();
	level.killstreakfuncs["ac130"] = ::tryuseac130;
	level.ac130queue = [];
}

tryuseac130(lifeid)
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

	level.ac130inuse = 1;
	maps\mp\_utility::setusingremote("ac130");
	result = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(result != "success")
	{
		if(result != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		level.ac130inuse = 0;
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent("ac130", self.origin);
	self.ac130lifeid = lifeid;
	level.ac130.planemodel.crashed = undefined;
	thread setac130player(self);
	return 1;
}

init_sounds()
{
	setac130ambience("ambient_ac130_int1");
	level.scr_sound["foo"]["bar"] = "";
	add_context_sensative_dialog("ai", "in_sight", 0, "ac130_fco_moreenemy");
	add_context_sensative_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
	add_context_sensative_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
	add_context_sensative_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
	add_context_sensative_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
	add_context_sensative_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
	add_context_sensative_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
	add_context_sensative_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
	add_context_sensative_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
	add_context_sensative_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
	add_context_sensative_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
	add_context_sensative_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
	add_context_sensative_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
	add_context_sensative_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
	add_context_sensative_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
	add_context_sensative_dialog("ai", "in_sight", 17, "ac130_fco_tracking");
	add_context_sensative_dialog("ai", "wounded_crawl", 0, "ac130_fco_movingagain");
	add_context_sensative_timeout("ai", "wounded_crawl", undefined, 6);
	add_context_sensative_dialog("ai", "wounded_pain", 0, "ac130_fco_doveonground");
	add_context_sensative_dialog("ai", "wounded_pain", 1, "ac130_fco_knockedwind");
	add_context_sensative_dialog("ai", "wounded_pain", 2, "ac130_fco_downstillmoving");
	add_context_sensative_dialog("ai", "wounded_pain", 3, "ac130_fco_gettinbackup");
	add_context_sensative_dialog("ai", "wounded_pain", 4, "ac130_fco_yepstillmoving");
	add_context_sensative_dialog("ai", "wounded_pain", 5, "ac130_fco_stillmoving");
	add_context_sensative_timeout("ai", "wounded_pain", undefined, 12);
	add_context_sensative_dialog("weapons", "105mm_ready", 0, "ac130_gnr_gunready1");
	add_context_sensative_dialog("weapons", "105mm_fired", 0, "ac130_gnr_shot1");
	add_context_sensative_dialog("plane", "rolling_in", 0, "ac130_plt_rollinin");
	add_context_sensative_dialog("explosion", "secondary", 0, "ac130_nav_secondaries1");
	add_context_sensative_dialog("explosion", "secondary", 1, "ac130_tvo_directsecondary1");
	add_context_sensative_dialog("explosion", "secondary", 1, "ac130_tvo_directsecondary2");
	add_context_sensative_timeout("explosion", "secondary", undefined, 7);
	add_context_sensative_dialog("kill", "single", 0, "ac130_plt_gottahurt");
	add_context_sensative_dialog("kill", "single", 1, "ac130_fco_iseepieces");
	add_context_sensative_dialog("kill", "single", 2, "ac130_fco_oopsiedaisy");
	add_context_sensative_dialog("kill", "single", 3, "ac130_fco_goodkill");
	add_context_sensative_dialog("kill", "single", 4, "ac130_fco_yougothim");
	add_context_sensative_dialog("kill", "single", 5, "ac130_fco_yougothim2");
	add_context_sensative_dialog("kill", "single", 6, "ac130_fco_thatsahit");
	add_context_sensative_dialog("kill", "single", 7, "ac130_fco_directhit");
	add_context_sensative_dialog("kill", "single", 8, "ac130_fco_rightontarget");
	add_context_sensative_dialog("kill", "single", 9, "ac130_fco_okyougothim");
	add_context_sensative_dialog("kill", "single", 10, "ac130_fco_within2feet");
	add_context_sensative_dialog("kill", "small_group", 0, "ac130_fco_nice");
	add_context_sensative_dialog("kill", "small_group", 1, "ac130_fco_directhits");
	add_context_sensative_dialog("kill", "small_group", 2, "ac130_fco_iseepieces");
	add_context_sensative_dialog("kill", "small_group", 3, "ac130_fco_goodkill");
	add_context_sensative_dialog("kill", "small_group", 4, "ac130_fco_yougothim");
	add_context_sensative_dialog("kill", "small_group", 5, "ac130_fco_yougothim2");
	add_context_sensative_dialog("kill", "small_group", 6, "ac130_fco_thatsahit");
	add_context_sensative_dialog("kill", "small_group", 7, "ac130_fco_directhit");
	add_context_sensative_dialog("kill", "small_group", 8, "ac130_fco_rightontarget");
	add_context_sensative_dialog("kill", "small_group", 9, "ac130_fco_okyougothim");
	add_context_sensative_dialog("misc", "action", 0, "ac130_plt_scanrange");
	add_context_sensative_timeout("misc", "action", 0, 70);
	add_context_sensative_dialog("misc", "action", 1, "ac130_plt_cleanup");
	add_context_sensative_timeout("misc", "action", 1, 80);
	add_context_sensative_dialog("misc", "action", 2, "ac130_plt_targetreset");
	add_context_sensative_timeout("misc", "action", 2, 55);
	add_context_sensative_dialog("misc", "action", 3, "ac130_plt_azimuthsweep");
	add_context_sensative_timeout("misc", "action", 3, 100);
}

add_context_sensative_dialog(name1, name2, group, soundalias)
{
	fullsoundalias = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + soundalias;
	fullsoundalias = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + soundalias;
	if(!isdefined(level.scr_sound[name1]) || !isdefined(level.scr_sound[name1][name2]) || !isdefined(level.scr_sound[name1][name2][group]))
	{
		level.scr_sound[name1][name2][group] = spawnstruct();
		level.scr_sound[name1][name2][group].played = 0;
		level.scr_sound[name1][name2][group].sounds = [];
	}

	index = level.scr_sound[name1][name2][group].sounds.size;
	level.scr_sound[name1][name2][group].sounds[index] = soundalias;
}

add_context_sensative_timeout(name1, name2, groupnum, timeoutduration)
{
	if(!isdefined(level.context_sensative_dialog_timeouts))
	{
		level.context_sensative_dialog_timeouts = [];
	}

	createstruct = 0;
	if(!isdefined(level.context_sensative_dialog_timeouts[name1]))
	{
		createstruct = 1;
	}
	else if(!isdefined(level.context_sensative_dialog_timeouts[name1][name2]))
	{
		createstruct = 1;
	}

	if(createstruct)
	{
		level.context_sensative_dialog_timeouts[name1][name2] = spawnstruct();
	}

	if(isdefined(groupnum))
	{
		level.context_sensative_dialog_timeouts[name1][name2].groups = [];
		level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)] = spawnstruct();
		level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)].v["timeoutDuration"] = timeoutduration * 1000;
		level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)].v["lastPlayed"] = timeoutduration * -1000;
		return;
	}

	level.context_sensative_dialog_timeouts[name1][name2].v["timeoutDuration"] = timeoutduration * 1000;
	level.context_sensative_dialog_timeouts[name1][name2].v["lastPlayed"] = timeoutduration * -1000;
}

play_sound_on_entity(alias)
{
	maps\mp\_utility::play_sound_on_tag(alias);
}

within_fov(start_origin, start_angles, end_origin, fov)
{
	normal = vectornormalize(end_origin - start_origin);
	forward = anglestoforward(start_angles);
	dot = vectordot(forward, normal);
	return dot >= fov;
}

array_remove_nokeys(ents, remover)
{
	newents = [];
	for(i = 0;i < ents.size;i++)
	{
		if(ents[i] != remover)
		{
			newents[newents.size] = ents[i];
		}
	}

	return newents;
}

array_remove_index(array, index)
{
	newarray = [];
	keys = getarraykeys(array);
	for(i = keys.size - 1;i >= 0;i--)
	{
		if(keys[i] != index)
		{
			newarray[newarray.size] = array[keys[i]];
		}
	}

	return newarray;
}

string(num)
{
	return "" + num;
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

deleteonac130playerremoved()
{
	level waittill("ac130player_removed");
	self delete();
}

setac130player(player)
{
	self endon("ac130player_removed");
	level.ac130player = player;
	level.ac130.owner = player;
	level.ac130.planemodel show();
	level.ac130.planemodel thread playac130effects();
	level.ac130.incomingmissile = 0;
	level.ac130.planemodel playloopsound("veh_ac130_ext_dist");
	level.ac130.planemodel.maxhealth = 1000;
	level.ac130.planemodel.health = level.ac130.planemodel.maxhealth;
	objmodel = spawnplane(player, "script_model", level.ac130.planemodel.origin, "compass_objpoint_ac130_friendly", "compass_objpoint_ac130_enemy");
	objmodel linkto(level.ac130, "tag_player", (0,80,32), (0,-90,0));
	objmodel thread deleteonac130playerremoved();
	player startac130();
	player openmenu("ac130timer");
	level.ac130.numflares = level.ac130_num_flares;
	thread maps\mp\_utility::teamplayercardsplash("used_ac130", player);
	player visionsetthermalforplayer("black_bw", 0);
	player thermalvisionon();
	player thermalvisionfofoverlayon();
	if(getdvarint("camera_thirdPerson"))
	{
		player maps\mp\_utility::setthirdpersondof(0);
	}

	player maps\mp\_utility::_giveweapon("ac130_105mm_mp");
	player maps\mp\_utility::_giveweapon("ac130_40mm_mp");
	player maps\mp\_utility::_giveweapon("ac130_25mm_mp");
	player switchtoweapon("ac130_105mm_mp");
	player thread overlay(player);
	player thread attachplayer(player);
	player thread changeweapons();
	player thread weaponfiredthread();
	player thread thermalvision();
	player thread context_sensative_dialog();
	player thread shotfired();
	player thread clouds();
	player thread removeac130playeraftertime(level.ac130_use_duration * player.killstreakscaler);
	player thread removeac130playerondisconnect();
	player thread removeac130playeronchangeteams();
	player thread removeac130playeronspectate();
	player thread removeac130playeroncrash();
	player thread removeac130playerongamecleanup();
	thread ac130_altscene();
}

playac130effects()
{
	wait 0.05;
	playfxontag(level._effect["ac130_light_red_blink"], self, "tag_light_belly");
	playfxontag(level._effect["ac130_engineeffect"], self, "tag_body");
	wait 0.5;
	playfxontag(level._effect["ac130_light_white_blink"], self, "tag_light_tail");
	playfxontag(level._effect["ac130_light_red"], self, "tag_light_top");
}

ac130_altscene()
{
	foreach(player in level.players)
	{
		if(player != level.ac130player && player.team == level.ac130player.team)
		{
			player thread maps\mp\_utility::setaltsceneobj(level.ac130.cameramodel, "tag_origin", 20);
		}
	}
}

removeac130playerongameend()
{
	self endon("ac130player_removed");
	level waittill("game_ended");
	level thread removeac130player(self, 0);
}

removeac130playerongamecleanup()
{
	self endon("ac130player_removed");
	level waittill("game_cleanup");
	level thread removeac130player(self, 0);
}

removeac130playerondeath()
{
	self endon("ac130player_removed");
	self waittill("death");
	level thread removeac130player(self, 0);
}

removeac130playeroncrash()
{
	self endon("ac130player_removed");
	level.ac130.planemodel waittill("crashing");
	level thread removeac130player(self, 0);
}

removeac130playerondisconnect()
{
	self endon("ac130player_removed");
	self waittill("disconnect");
	level thread removeac130player(self, 1);
}

removeac130playeronchangeteams()
{
	self endon("ac130player_removed");
	self waittill("joined_team");
	level thread removeac130player(self, 0);
}

removeac130playeronspectate()
{
	self endon("ac130player_removed");
	common_scripts\utility::waittill_any("joined_spectators", "spawned");
	level thread removeac130player(self, 0);
}

removeac130playeraftertime(param_5CA)
{
	self endon("ac130player_removed");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_5CA);
	level thread removeac130player(self, 0);
}

removeac130player(player, disconnected)
{
	player notify("ac130player_removed");
	level notify("ac130player_removed");
	level.ac130.cameramodel notify("death");
	waittillframeend;
	if(!disconnected)
	{
		player maps\mp\_utility::clearusingremote();
		player stoplocalsound("missile_incoming");
		player show();
		player unlink();
		player thermalvisionoff();
		player thermalvisionfofoverlayoff();
		player visionsetthermalforplayer(game["thermal_vision"], 0);
		player setblurforplayer(0, 0);
		player stopac130();
		if(getdvarint("camera_thirdPerson"))
		{
			player maps\mp\_utility::setthirdpersondof(1);
		}

		weaponlist = player getweaponslistexclusives();
		foreach(weapon in weaponlist)
		{
			player takeweapon(weapon);
		}

		if(isdefined(player.darkscreenoverlay))
		{
			player.darkscreenoverlay destroy();
		}

		keys = getarraykeys(level.huditem);
		foreach(key in keys)
		{
			level.huditem[key] destroy();
			level.huditem[key] = undefined;
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

	ac130model = spawn("script_model", level.ac130.planemodel gettagorigin("tag_origin"));
	ac130model.angles = level.ac130.planemodel.angles;
	ac130model setmodel("vehicle_ac130_coop");
	destpoint = ac130model.origin + common_scripts\utility::vector_multiply(anglestoright(ac130model.angles), 20000);
	ac130model thread playac130effects();
	ac130model moveto(destpoint, 40, 0, 0);
	ac130model thread deployflares(1);
	wait 5;
	ac130model thread deployflares(1);
	wait 5;
	ac130model thread deployflares(1);
	level.ac130inuse = 0;
	wait 30;
	ac130model delete();
}

damagetracker()
{
	for(;;)
	{
		self waittill("damage", damage, attacker, dir, point, type);
		if(isdefined(level.ac130player) && level.teambased && isplayer(attacker) && attacker.team == level.ac130player.team && !isdefined(level.nukedetonated))
		{
			self.health = self.health + damage;
			continue;
		}

		if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_EXPLOSIVE_BULLET")
		{
			self.health = self.health + damage;
			continue;
		}

		if(isplayer(attacker))
		{
			attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
			if(attacker maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				damageadd = damage * level.armorpiercingmod;
				self.health = self.health - int(damageadd);
			}
		}

		if(self.health <= 0)
		{
			if(isplayer(attacker))
			{
				thread maps\mp\gametypes\_missions::vehiclekilled(level.ac130player, self, undefined, attacker, damage, type);
				thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_ac130", attacker);
				attacker thread maps\mp\gametypes\_rank::giverankxp("kill", 400);
				attacker notify("destroyed_killstreak");
			}

			level thread crashplane(10);
		}
	}
}

ac130_spawn()
{
	wait 0.05;
	ac130model = spawn("script_model", level.ac130 gettagorigin("tag_player"));
	ac130model setmodel("vehicle_ac130_coop");
	ac130model setcandamage(1);
	ac130model.maxhealth = 1000;
	ac130model.health = ac130model.maxhealth;
	ac130model thread damagetracker();
	ac130model linkto(level.ac130, "tag_player", (0,80,32), (-25,0,0));
	level.ac130.planemodel = ac130model;
	level.ac130.planemodel hide();
	ac130cameramodel = spawn("script_model", level.ac130 gettagorigin("tag_player"));
	ac130cameramodel setmodel("tag_origin");
	ac130cameramodel hide();
	ac130cameramodel linkto(level.ac130, "tag_player", (0,0,32), (-25,0,0));
	level.ac130.cameramodel = ac130cameramodel;
	level.ac130player = level.players[0];
}

overlay(player)
{
	level.huditem = [];
	thermalenabled = maps\mp\_utility::getintproperty("ac130_hud_text_thermal", 0);
	if(thermalenabled)
	{
		level.huditem["thermal_mode"] = newclienthudelem(player);
		level.huditem["thermal_mode"].x = -80;
		level.huditem["thermal_mode"].y = 50;
		level.huditem["thermal_mode"].alignx = "right";
		level.huditem["thermal_mode"].aligny = "top";
		level.huditem["thermal_mode"].horzalign = "right";
		level.huditem["thermal_mode"].vertalign = "top";
		level.huditem["thermal_mode"].fontscale = 2.5;
		level.huditem["thermal_mode"] settext(&"AC130_HUD_THERMAL_WHOT");
		level.huditem["thermal_mode"].alpha = 1;
	}

	if(!level.splitscreen)
	{
		player thread overlay_coords();
	}

	if(thermalenabled)
	{
		player setblurforplayer(1.2, 0);
		return;
	}
}

hud_timer(duration)
{
	self endon("ac130player_removed");
	level.huditem["timer"] = newclienthudelem(self);
	level.huditem["timer"].x = -100;
	level.huditem["timer"].y = 0;
	level.huditem["timer"].alignx = "right";
	level.huditem["timer"].aligny = "bottom";
	level.huditem["timer"].horzalign = "right_adjustable";
	level.huditem["timer"].vertalign = "bottom_adjustable";
	level.huditem["timer"].fontscale = 2.5;
	level.huditem["timer"] settimer(1);
	level.huditem["timer"].alpha = 1;
	level.huditem["timer"] settimer(duration);
}

overlay_coords()
{
	self endon("ac130player_removed");
	level.huditem["coordinate_long"] = newclienthudelem(self);
	level.huditem["coordinate_long"].x = -100;
	level.huditem["coordinate_long"].y = 0;
	level.huditem["coordinate_long"].alignx = "right";
	level.huditem["coordinate_long"].aligny = "top";
	level.huditem["coordinate_long"].horzalign = "right";
	level.huditem["coordinate_long"].vertalign = "top";
	level.huditem["coordinate_long"].fontscale = 2.5;
	level.huditem["coordinate_long"].alpha = 1;
	level.huditem["coordinate_lat"] = newclienthudelem(self);
	level.huditem["coordinate_lat"].x = 0;
	level.huditem["coordinate_lat"].y = 0;
	level.huditem["coordinate_lat"].alignx = "right";
	level.huditem["coordinate_lat"].aligny = "top";
	level.huditem["coordinate_lat"].horzalign = "right";
	level.huditem["coordinate_lat"].vertalign = "top";
	level.huditem["coordinate_lat"].fontscale = 2.5;
	level.huditem["coordinate_lat"].alpha = 1;
	level.huditem["coordinate_agl"] = newclienthudelem(self);
	level.huditem["coordinate_agl"].x = 0;
	level.huditem["coordinate_agl"].y = 20;
	level.huditem["coordinate_agl"].alignx = "right";
	level.huditem["coordinate_agl"].aligny = "top";
	level.huditem["coordinate_agl"].horzalign = "right";
	level.huditem["coordinate_agl"].vertalign = "top";
	level.huditem["coordinate_agl"].fontscale = 2.5;
	level.huditem["coordinate_agl"].label = &"AC130_HUD_AGL";
	level.huditem["coordinate_agl"].alpha = 1;
	wait 0.05;
	for(;;)
	{
		level.huditem["coordinate_long"] setvalue(abs(int(self.origin[0])));
		level.huditem["coordinate_lat"] setvalue(abs(int(self.origin[1])));
		pos = physicstrace(self.origin, self.origin - (0,0,100000));
		if(isdefined(pos) && isdefined(pos[2]))
		{
			alt = self.origin[2] - pos[2] * 1.5;
			level.huditem["coordinate_agl"] setvalue(abs(int(alt)));
		}

		wait 0.75 + randomfloat(2);
	}
}

ac130shellshock()
{
	self endon("ac130player_removed");
	level endon("post_effects_disabled");
	duration = 5;
	for(;;)
	{
		self shellshock("ac130", duration);
		wait duration;
	}
}

rotateplane(toggle)
{
	level notify("stop_rotatePlane_thread");
	level endon("stop_rotatePlane_thread");
	if(toggle == "on")
	{
		rampupdegrees = 10;
		rotatetime = level.ac130_speed["rotate"] / 360 * rampupdegrees;
		level.ac130 rotateyaw(level.ac130.angles[2] + rampupdegrees, rotatetime, rotatetime, 0);
		for(;;)
		{
			level.ac130 rotateyaw(360, level.ac130_speed["rotate"]);
			wait level.ac130_speed["rotate"];
		}

		return;
	}

	if(toggle == "off")
	{
		slowdowndegrees = 10;
		rotatetime = level.ac130_speed["rotate"] / 360 * slowdowndegrees;
		level.ac130 rotateyaw(level.ac130.angles[2] + slowdowndegrees, rotatetime, 0, rotatetime);
		return;
	}
}

attachplayer(player)
{
	self playerlinkweaponviewtodelta(level.ac130, "tag_player", 1, 35, 35, 35, 35);
	self setplayerangles(level.ac130 gettagangles("tag_player"));
}

changeweapons()
{
	self endon("ac130player_removed");
	wait 0.05;
	self enableweapons();
	for(;;)
	{
		self waittill("change_weapon", newweapon);
		thread play_sound_on_entity("ac130_weapon_switch");
	}
}

weaponfiredthread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("weapon_fired");
		weapon = self getcurrentweapon();
		if(weapon == "ac130_105mm_mp")
		{
			thread gun_fired_and_ready_105mm();
			earthquake(0.2, 1, level.ac130.planemodel.origin, 1000);
		}
		else if(weapon == "ac130_40mm_mp")
		{
			earthquake(0.1, 0.5, level.ac130.planemodel.origin, 1000);
		}

		if(self getweaponammoclip(weapon))
		{
			continue;
		}

		thread weaponreload(weapon);
	}
}

weaponreload(weapon)
{
	self endon("ac130player_removed");
	wait level.weaponreloadtime[weapon];
	self setweaponammoclip(weapon, 9999);
	if(self getcurrentweapon() == weapon)
	{
		self takeweapon(weapon);
		maps\mp\_utility::_giveweapon(weapon);
		self switchtoweapon(weapon);
		return;
	}
}

thermalvision()
{
	self endon("ac130player_removed");
	if(maps\mp\_utility::getintproperty("ac130_thermal_enabled", 1) == 0)
	{
		return;
	}

	inverted = 0;
	self visionsetthermalforplayer(game["thermal_vision"], 1);
	self notifyonplayercommand("switch thermal", "+usereload");
	for(;;)
	{
		self waittill("switch thermal");
		if(!inverted)
		{
			self visionsetthermalforplayer("missilecam", 0.62);
			if(isdefined(level.huditem["thermal_mode"]))
			{
				level.huditem["thermal_mode"] settext(&"AC130_HUD_THERMAL_BHOT");
			}
		}
		else
		{
			self visionsetthermalforplayer(game["thermal_vision"], 0.51);
			if(isdefined(level.huditem["thermal_mode"]))
			{
				level.huditem["thermal_mode"] settext(&"AC130_HUD_THERMAL_WHOT");
			}
		}

		inverted = !inverted;
	}
}

clouds()
{
	self endon("ac130player_removed");
	wait 6;
	clouds_create();
	for(;;)
	{
		wait randomfloatrange(40, 80);
		clouds_create();
	}
}

clouds_create()
{
	if(isdefined(level.playerweapon) && issubstr(tolower(level.playerweapon), "25"))
	{
		return;
	}

	playfxontagforclients(level._effect["cloud"], level.ac130, "tag_player", level.ac130player);
}

gun_fired_and_ready_105mm()
{
	self endon("ac130player_removed");
	level notify("gun_fired_and_ready_105mm");
	level endon("gun_fired_and_ready_105mm");
	wait 0.5;
	if(randomint(2) == 0)
	{
		thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_fired");
	}

	wait 5;
	thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_ready");
}

shotfired()
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("projectile_impact", weaponname, position, radius);
		if(issubstr(tolower(weaponname), "105"))
		{
			earthquake(0.4, 1, position, 3500);
			thread shotfireddarkscreenoverlay();
		}
		else if(issubstr(tolower(weaponname), "40"))
		{
			earthquake(0.2, 0.5, position, 2000);
		}

		if(maps\mp\_utility::getintproperty("ac130_ragdoll_deaths", 0))
		{
			thread shotfiredphysicssphere(position, weaponname);
		}

		wait 0.05;
	}
}

shotfiredphysicssphere(center, weapon)
{
	wait 0.1;
	physicsexplosionsphere(center, level.physicssphereradius[weapon], level.physicssphereradius[weapon] / 2, level.physicssphereforce[weapon]);
}

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
		self.darkscreenoverlay setshader("black", 640, 480);
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

add_beacon_effect()
{
	self endon("death");
	flashdelay = 0.75;
	wait randomfloat(3);
	for(;;)
	{
		if(level.ac130player)
		{
			playfxontagforclients(level._effect["beacon"], self, "j_spine4", level.ac130player);
		}

		wait flashdelay;
	}
}

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

context_sensative_dialog_guy_in_sight()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(context_sensative_dialog_guy_in_sight_check())
		{
			thread context_sensative_dialog_play_random_group_sound("ai", "in_sight");
		}

		wait randomfloatrange(1, 3);
	}
}

context_sensative_dialog_guy_in_sight_check()
{
	enemies = [];
	for(i = 0;i < enemies.size;i++)
	{
		if(!isdefined(enemies[i]))
		{
			continue;
		}

		if(!isalive(enemies[i]))
		{
			continue;
		}

		if(within_fov(level.ac130player geteye(), level.ac130player getplayerangles(), enemies[i].origin, level.cosine["5"]))
		{
			return 1;
		}

		wait 0.05;
	}

	return 0;
}

context_sensative_dialog_guy_crawling()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_crawling", guy);
		thread context_sensative_dialog_play_random_group_sound("ai", "wounded_crawl");
	}
}

context_sensative_dialog_guy_pain()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_pain", guy);
		thread context_sensative_dialog_play_random_group_sound("ai", "wounded_pain");
	}
}

context_sensative_dialog_secondary_explosion_vehicle()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("player_destroyed_car", player, vehicle_origin);
		wait 1;
		thread context_sensative_dialog_play_random_group_sound("explosion", "secondary");
	}
}

enemy_killed_thread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("ai_killed", guy);
		thread context_sensative_dialog_kill(guy, level.ac130player);
	}
}

context_sensative_dialog_kill(guy, attacker)
{
	if(!isdefined(attacker))
	{
		return;
	}

	if(!isplayer(attacker))
	{
		return;
	}

	level.enemieskilledintimewindow++;
	level notify("enemy_killed");
}

context_sensative_dialog_kill_thread()
{
	self endon("ac130player_removed");
	timewindow = 1;
	for(;;)
	{
		level waittill("enemy_killed");
		wait timewindow;
		soundalias1 = "kill";
		soundalias2 = undefined;
		if(level.enemieskilledintimewindow >= 2)
		{
			soundalias2 = "small_group";
		}
		else
		{
			soundalias2 = "single";
			if(randomint(3) != 1)
			{
				level.enemieskilledintimewindow = 0;
				continue;
			}
		}

		level.enemieskilledintimewindow = 0;
		thread context_sensative_dialog_play_random_group_sound(soundalias1, soundalias2, 1);
	}
}

context_sensative_dialog_locations()
{
	common_scripts\utility::array_thread(getentarray("context_dialog_car", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "car");
	common_scripts\utility::array_thread(getentarray("context_dialog_truck", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "truck");
	common_scripts\utility::array_thread(getentarray("context_dialog_building", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "building");
	common_scripts\utility::array_thread(getentarray("context_dialog_wall", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "wall");
	common_scripts\utility::array_thread(getentarray("context_dialog_field", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "field");
	common_scripts\utility::array_thread(getentarray("context_dialog_road", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "road");
	common_scripts\utility::array_thread(getentarray("context_dialog_church", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "church");
	common_scripts\utility::array_thread(getentarray("context_dialog_ditch", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "ditch");
	thread context_sensative_dialog_locations_thread();
}

context_sensative_dialog_locations_thread()
{
	self endon("ac130player_removed");
	for(;;)
	{
		level waittill("context_location", locationtype);
		if(!isdefined(locationtype))
		{
			continue;
		}

		if(!common_scripts\utility::flag("allow_context_sensative_dialog"))
		{
			continue;
		}

		thread context_sensative_dialog_play_random_group_sound("location", locationtype);
		wait 5 + randomfloat(10);
	}
}

context_sensative_dialog_locations_add_notify_event(locationtype)
{
	self endon("ac130player_removed");
	for(;;)
	{
		self waittill("trigger", triggerer);
		if(!isdefined(triggerer))
		{
			continue;
		}

		if(!isdefined(triggerer.team) || triggerer.team != "axis")
		{
			continue;
		}

		level notify("context_location", locationtype);
		wait 5;
	}
}

context_sensative_dialog_vehiclespawn(vehicle)
{
	if(vehicle.script_team != "axis")
	{
		return;
	}

	thread context_sensative_dialog_vehicledeath(vehicle);
	vehicle endon("death");
	while(!within_fov(level.ac130player geteye(), level.ac130player getplayerangles(), vehicle.origin, level.cosine["45"]))
	{
		wait 0.5;
	}

	context_sensative_dialog_play_random_group_sound("vehicle", "incoming");
}

context_sensative_dialog_vehicledeath(vehicle)
{
	vehicle waittill("death");
	thread context_sensative_dialog_play_random_group_sound("vehicle", "death");
}

context_sensative_dialog_filler()
{
	self endon("ac130player_removed");
	for(;;)
	{
		if(isdefined(level.radio_in_use) && level.radio_in_use == 1)
		{
			level waittill("radio_not_in_use");
		}

		currenttime = gettime();
		if(currenttime - level.lastradiotransmission >= 3000)
		{
			level.lastradiotransmission = currenttime;
			thread context_sensative_dialog_play_random_group_sound("misc", "action");
		}

		wait 0.25;
	}
}

context_sensative_dialog_play_random_group_sound(name1, name2, force_transmit_on_turn)
{
	level endon("ac130player_removed");
	if(!isdefined(force_transmit_on_turn))
	{
		force_transmit_on_turn = 0;
	}

	if(!common_scripts\utility::flag("allow_context_sensative_dialog"))
	{
		if(force_transmit_on_turn)
		{
			common_scripts\utility::flag_wait("allow_context_sensative_dialog");
		}
		else
		{
			return;
		}
	}

	validgroupnum = undefined;
	randgroup = randomint(level.scr_sound[name1][name2].size);
	if(level.scr_sound[name1][name2][randgroup].played == 1)
	{
		for(i = 0;i < level.scr_sound[name1][name2].size;i++)
		{
			randgroup++;
			if(randgroup >= level.scr_sound[name1][name2].size)
			{
				randgroup = 0;
			}

			if(level.scr_sound[name1][name2][randgroup].played == 1)
			{
				continue;
			}

			validgroupnum = randgroup;
			break;
		}

		if(!isdefined(validgroupnum))
		{
			for(i = 0;i < level.scr_sound[name1][name2].size;i++)
			{
				level.scr_sound[name1][name2][i].played = 0;
			}

			validgroupnum = randomint(level.scr_sound[name1][name2].size);
		}
	}
	else
	{
		validgroupnum = randgroup;
	}

	if(context_sensative_dialog_timedout(name1, name2, validgroupnum))
	{
		return;
	}

	level.scr_sound[name1][name2][validgroupnum].played = 1;
	randsound = randomint(level.scr_sound[name1][name2][validgroupnum].size);
	playsoundoverradio(level.scr_sound[name1][name2][validgroupnum].sounds[randsound], force_transmit_on_turn);
}

context_sensative_dialog_timedout(name1, name2, groupnum)
{
	if(!isdefined(level.context_sensative_dialog_timeouts))
	{
		return 0;
	}

	if(!isdefined(level.context_sensative_dialog_timeouts[name1]))
	{
		return 0;
	}

	if(!isdefined(level.context_sensative_dialog_timeouts[name1][name2]))
	{
		return 0;
	}

	if(isdefined(level.context_sensative_dialog_timeouts[name1][name2].groups) && isdefined(level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)]))
	{
		currenttime = gettime();
		if(currenttime - level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)].v["timeoutDuration"])
		{
			return 1;
		}

		level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupnum)].v["lastPlayed"] = currenttime;
	}
	else if(isdefined(level.context_sensative_dialog_timeouts[name1][name2].v))
	{
		currenttime = gettime();
		if(currenttime - level.context_sensative_dialog_timeouts[name1][name2].v["lastPlayed"] < level.context_sensative_dialog_timeouts[name1][name2].v["timeoutDuration"])
		{
			return 1;
		}

		level.context_sensative_dialog_timeouts[name1][name2].v["lastPlayed"] = currenttime;
	}

	return 0;
}

playsoundoverradio(soundalias, force_transmit_on_turn, timeout)
{
	if(!isdefined(level.radio_in_use))
	{
		level.radio_in_use = 0;
	}

	if(!isdefined(force_transmit_on_turn))
	{
		force_transmit_on_turn = 0;
	}

	if(!isdefined(timeout))
	{
		timeout = 0;
	}

	timeout = timeout * 1000;
	soundqueuetime = gettime();
	soundplayed = 0;
	soundplayed = playaliasoverradio(soundalias);
	if(soundplayed)
	{
		return;
	}

	if(!force_transmit_on_turn)
	{
		return;
	}

	level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = soundalias;
	while(!soundplayed)
	{
		if(level.radio_in_use)
		{
			level waittill("radio_not_in_use");
		}

		if(timeout > 0 && gettime() - soundqueuetime > timeout)
		{
			break;
		}

		if(!isdefined(level.ac130player))
		{
			break;
		}

		soundplayed = playaliasoverradio(level.radioforcedtransmissionqueue[0]);
		if(!level.radio_in_use && isdefined(level.ac130player) && !soundplayed)
		{
		}
	}

	level.radioforcedtransmissionqueue = array_remove_index(level.radioforcedtransmissionqueue, 0);
}

playaliasoverradio(soundalias)
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
		soundalias = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + soundalias;
		level.ac130player playlocalsound(soundalias);
	}

	wait 4;
	level.radio_in_use = 0;
	level.lastradiotransmission = gettime();
	level notify("radio_not_in_use");
	return 1;
}

debug_circle(center, radius, duration, color, startdelay, fillcenter)
{
	circle_sides = 16;
	anglefrac = 360 / circle_sides;
	circlepoints = [];
	for(i = 0;i < circle_sides;i++)
	{
		angle = anglefrac * i;
		xadd = cos(angle) * radius;
		yadd = sin(angle) * radius;
		x = center[0] + xadd;
		y = center[1] + yadd;
		z = center[2];
		circlepoints[circlepoints.size] = (x,y,z);
	}

	if(isdefined(startdelay))
	{
		wait startdelay;
	}

	thread debug_circle_drawlines(circlepoints, duration, color, fillcenter, center);
}

debug_circle_drawlines(circlepoints, duration, color, fillcenter, center)
{
	if(!isdefined(fillcenter))
	{
		fillcenter = 0;
	}

	if(!isdefined(center))
	{
		fillcenter = 0;
	}

	for(i = 0;i < circlepoints.size;i++)
	{
		start = circlepoints[i];
		if(i + 1 >= circlepoints.size)
		{
			end = circlepoints[0];
		}
		else
		{
			end = circlepoints[i + 1];
		}

		thread debug_line(start, end, duration, color);
		if(fillcenter)
		{
			thread debug_line(center, start, duration, color);
		}
	}
}

debug_line(start, end, duration, color)
{
	if(!isdefined(color))
	{
		color = (1,1,1);
	}

	for(i = 0;i < duration * 20;i++)
	{
		wait 0.05;
	}
}

handleincomingstinger()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("stinger_fired", player, missile, locktarget);
		if(!isdefined(locktarget) || locktarget != level.ac130.planemodel)
		{
			continue;
		}

		missile thread stingerproximitydetonate(player, player.team);
	}
}

deleteaftertime(delay)
{
	wait delay;
	self delete();
}

stingerproximitydetonate(player, missileteam)
{
	self endon("death");
	if(isdefined(level.ac130player))
	{
		level.ac130player playlocalsound("missile_incoming");
	}

	level.ac130.incomingmissile = 1;
	missiletarget = level.ac130.planemodel;
	self missile_settargetent(missiletarget);
	didseatbelts = 0;
	mindist = distance(self.origin, missiletarget getpointinbounds(0, 0, 0));
	for(;;)
	{
		center = missiletarget getpointinbounds(0, 0, 0);
		curdist = distance(self.origin, center);
		if(!isdefined(level.ac130player))
		{
			self missile_settargetpos(level.ac130.origin + (0,0,100000));
			return;
		}

		if(curdist < 3000 && missiletarget == level.ac130.planemodel && level.ac130.numflares > 0)
		{
			level.ac130.numflares--;
			newtarget = missiletarget deployflares();
			self missile_settargetent(newtarget);
			missiletarget = newtarget;
			if(isdefined(level.ac130player))
			{
				level.ac130player stoplocalsound("missile_incoming");
			}
		}

		if(curdist < mindist)
		{
			speedperframe = mindist - curdist * 20;
			eta = curdist / speedperframe;
			if(eta < 1.5 && !didseatbelts && missiletarget == level.ac130.planemodel)
			{
				if(isdefined(level.ac130player))
				{
					level.ac130player playlocalsound("fasten_seatbelts");
				}

				didseatbelts = 1;
			}

			mindist = curdist;
		}

		if(curdist > mindist)
		{
			if(curdist > 1536)
			{
				return;
			}

			if(isdefined(level.ac130player))
			{
				level.ac130player stoplocalsound("missile_incoming");
				if(level.ac130player.team != missileteam)
				{
					radiusdamage(self.origin, 1000, 1000, 1000, player);
				}
			}

			self hide();
			wait 0.05;
			self delete();
		}

		wait 0.05;
	}
}

crashplane(crashtime)
{
	level.ac130.planemodel notify("crashing");
	level.ac130.planemodel.crashed = 1;
	playfxontag(level._effect["ac130_explode"], level.ac130.planemodel, "tag_deathfx");
	wait 0.25;
	level.ac130.planemodel hide();
}

playflarefx(flarecount)
{
	for(i = 0;i < flarecount;i++)
	{
		thread angel_flare();
		wait randomfloatrange(0.1, 0.25);
	}
}

deployflares(fxonly)
{
	self playsound("ac130_flare_burst");
	if(!isdefined(fxonly))
	{
		flareobject = spawn("script_origin", level.ac130.planemodel.origin);
		flareobject.angles = level.ac130.planemodel.angles;
		flareobject movegravity((0,0,0), 5);
		thread playflarefx(10);
		flareobject thread deleteaftertime(5);
		return flareobject;
	}

	thread playflarefx(5);
}

angelflareprecache()
{
	precachemodel("angel_flare_rig");
	precachempanim("ac130_angel_flares01");
	precachempanim("ac130_angel_flares02");
	precachempanim("ac130_angel_flares03");
	level._effect["angel_flare_geotrail"] = loadfx("smoke/angel_flare_geotrail");
	level._effect["angel_flare_swirl"] = loadfx("smoke/angel_flare_swirl_runner");
}

angel_flare()
{
	rig = spawn("script_model", self.origin);
	rig setmodel("angel_flare_rig");
	rig.origin = self gettagorigin("tag_flash_flares");
	rig.angles = self gettagangles("tag_flash_flares");
	rig.angles = (rig.angles[0],rig.angles[1] + 180,rig.angles[2] + -90);
	fx_id = level._effect["angel_flare_geotrail"];
	rig scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
	wait 0.1;
	playfxontag(fx_id, rig, "flare_left_top");
	playfxontag(fx_id, rig, "flare_right_top");
	wait 0.05;
	playfxontag(fx_id, rig, "flare_left_bot");
	playfxontag(fx_id, rig, "flare_right_bot");
	wait 3;
	stopfxontag(fx_id, rig, "flare_left_top");
	stopfxontag(fx_id, rig, "flare_right_top");
	stopfxontag(fx_id, rig, "flare_left_bot");
	stopfxontag(fx_id, rig, "flare_right_bot");
	rig delete();
}
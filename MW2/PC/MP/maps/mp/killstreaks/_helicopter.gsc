/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	path_start = getentarray("heli_start", "targetname");
	loop_start = getentarray("heli_loop_start", "targetname");
	if(!path_start.size && !loop_start.size)
	{
		return;
	}

	level.heli_types = [];
	precachehelicopter("vehicle_cobra_helicopter_fly_low", "cobra");
	precachehelicopter("vehicle_mi24p_hind_mp", "hind");
	precachehelicopter("vehicle_mi-28_mp", "mi28");
	precachehelicopter("vehicle_apache_mp", "apache");
	precachehelicopter("vehicle_pavelow", "pavelow");
	precachehelicopter("vehicle_pavelow_opfor", "pavelow");
	precachehelicopter("vehicle_little_bird_armed", "cobra");
	precacheitem("cobra_FFAR_mp");
	precacheitem("cobra_20mm_mp");
	precacheitem("cobra_player_minigun_mp");
	precacheitem("heli_remote_mp");
	precachevehicle("cobra_mp");
	precachevehicle("cobra_minigun_mp");
	precachevehicle("pavelow_mp");
	precacheturret("pavelow_minigun_mp");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	level.chopper = undefined;
	level.heli_start_nodes = getentarray("heli_start", "targetname");
	level.heli_loop_nodes = getentarray("heli_loop_start", "targetname");
	level.heli_leave_nodes = getentarray("heli_leave", "targetname");
	level.heli_crash_nodes = getentarray("heli_crash_start", "targetname");
	level.heli_missile_rof = 5;
	level.heli_maxhealth = 1500;
	level.heli_debug = 0;
	level.heli_targeting_delay = 0.5;
	level.heli_turretreloadtime = 1.5;
	level.heli_turretclipsize = 40;
	level.heli_visual_range = 3500;
	level.heli_target_spawnprotection = 5;
	level.heli_target_recognition = 0.5;
	level.heli_missile_friendlycare = 256;
	level.heli_missile_target_cone = 0.3;
	level.heli_armor_bulletdamage = 0.3;
	level.heli_attract_strength = 1000;
	level.heli_attract_range = 4096;
	level.heli_angle_offset = 90;
	level.heli_forced_wait = 0;
	level.chopper_fx["explode"]["death"] = [];
	level.chopper_fx["explode"]["large"] = loadfx("explosions/helicopter_explosion_secondary_small");
	level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
	level.chopper_fx["smoke"]["trail"] = loadfx("smoke/smoke_trail_white_heli");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx("fire/fire_smoke_trail_L_emitter");
	level.chopper_fx["fire"]["trail"]["large"] = loadfx("fire/fire_smoke_trail_L");
	level.chopper_fx["damage"]["light_smoke"] = loadfx("smoke/smoke_trail_white_heli_emitter");
	level.chopper_fx["damage"]["heavy_smoke"] = loadfx("smoke/smoke_trail_black_heli_emitter");
	level.chopper_fx["damage"]["on_fire"] = loadfx("fire/fire_smoke_trail_L_emitter");
	level.chopper_fx["light"]["left"] = loadfx("misc/aircraft_light_wingtip_green");
	level.chopper_fx["light"]["right"] = loadfx("misc/aircraft_light_wingtip_red");
	level.chopper_fx["light"]["belly"] = loadfx("misc/aircraft_light_red_blink");
	level.chopper_fx["light"]["tail"] = loadfx("misc/aircraft_light_white_blink");
	level.fx_heli_dust = loadfx("treadfx/heli_dust_default");
	level.fx_heli_water = loadfx("treadfx/heli_water");
	makehelitype("cobra", "explosions/helicopter_explosion_cobra_low", ::defaultlightfx);
	addairexplosion("cobra", "explosions/aerial_explosion_cobra_low_mp");
	makehelitype("pavelow", "explosions/helicopter_explosion_pavelow", ::pavelowlightfx);
	addairexplosion("pavelow", "explosions/aerial_explosion_pavelow_mp");
	makehelitype("mi28", "explosions/helicopter_explosion_mi28_flying", ::defaultlightfx);
	addairexplosion("mi28", "explosions/aerial_explosion_mi28_flying_mp");
	makehelitype("hind", "explosions/helicopter_explosion_hind_chernobyl", ::defaultlightfx);
	addairexplosion("hind", "explosions/aerial_explosion_hind_chernobyl_mp");
	makehelitype("apache", "explosions/helicopter_explosion_apache", ::defaultlightfx);
	addairexplosion("apache", "explosions/aerial_explosion_apache_mp");
	makehelitype("littlebird", "explosions/aerial_explosion_littlebird_mp", ::defaultlightfx);
	addairexplosion("littlebird", "explosions/aerial_explosion_littlebird_mp");
	level.killstreakfuncs["helicopter"] = ::usehelicopter;
	level.killstreakfuncs["helicopter_blackbox"] = ::usehelicopterblackbox;
	level.killstreakfuncs["helicopter_flares"] = ::usehelicopterflares;
	level.killstreakfuncs["helicopter_minigun"] = ::usehelicopterminigun;
	level.killstreakfuncs["helicopter_mk19"] = ::usehelicoptermk19;
	level.helidialog["tracking"][0] = "ac130_fco_moreenemy";
	level.helidialog["tracking"][1] = "ac130_fco_getthatguy";
	level.helidialog["tracking"][2] = "ac130_fco_guyrunnin";
	level.helidialog["tracking"][3] = "ac130_fco_gotarunner";
	level.helidialog["tracking"][4] = "ac130_fco_personnelthere";
	level.helidialog["tracking"][5] = "ac130_fco_rightthere";
	level.helidialog["tracking"][6] = "ac130_fco_tracking";
	level.helidialog["locked"][0] = "ac130_fco_lightemup";
	level.helidialog["locked"][1] = "ac130_fco_takehimout";
	level.helidialog["locked"][2] = "ac130_fco_nailthoseguys";
	level.lasthelidialogtime = 0;
	maps\mp\_utility::queuecreate("helicopter");
}

makehelitype(helitype, deathfx, lightfxfunc)
{
	level.chopper_fx["explode"]["death"][helitype] = loadfx(deathfx);
	level.lightfxfunc[helitype] = lightfxfunc;
}

addairexplosion(helitype, explodefx)
{
	level.chopper_fx["explode"]["air_death"][helitype] = loadfx(explodefx);
}

pavelowlightfx()
{
	playfxontag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing1");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing1");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_cockpit01");
}

defaultlightfx()
{
	playfxontag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

usehelicopter(lifeid)
{
	return tryusehelicopter(lifeid);
}

usehelicopterblackbox(lifeid)
{
	return tryusehelicopter(lifeid, "blackbox");
}

usehelicopterflares(lifeid)
{
	return tryusehelicopter(lifeid, "flares");
}

usehelicopterminigun(lifeid)
{
	if(isdefined(self.laststand) && !maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	return tryusehelicopter(lifeid, "minigun");
}

usehelicoptermk19(lifeid)
{
	if(isdefined(self.laststand) && !maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	return tryusehelicopter(lifeid, "mk19");
}

tryusehelicopter(lifeid, helitype)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if((!isdefined(helitype) || helitype == "flares") && isdefined(level.chopper))
	{
		self iprintlnbold(&"MP_HELI_IN_QUEUE");
		if(isdefined(helitype))
		{
			streakname = "helicopter_" + helitype;
		}
		else
		{
			streakname = "helicopter";
		}

		maps\mp\killstreaks\_killstreaks::shufflekillstreaksfilo(streakname);
		maps\mp\killstreaks\_killstreaks::giveownedkillstreakitem();
		queueent = spawn("script_origin", (0,0,0));
		queueent hide();
		queueent thread deleteonentnotify(self, "disconnect");
		queueent.player = self;
		queueent.lifeid = lifeid;
		queueent.helitype = helitype;
		queueent.streakname = streakname;
		maps\mp\_utility::queueadd("helicopter", queueent);
		return 0;
	}
	else if(isdefined(level.chopper))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(isdefined(helitype) && helitype == "minigun")
	{
		maps\mp\_utility::setusingremote("helicopter_" + helitype);
		result = maps\mp\killstreaks\_killstreaks::initridekillstreak();
		if(result != "success")
		{
			if(result != "disconnect")
			{
				maps\mp\_utility::clearusingremote();
			}

			return 0;
		}

		if(isdefined(level.chopper))
		{
			maps\mp\_utility::clearusingremote();
			self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
			return 0;
		}
	}

	starthelicopter(lifeid, helitype);
	return 1;
}

deleteonentnotify(ent, notifystring)
{
	self endon("death");
	ent waittill(notifystring);
	self delete();
}

starthelicopter(lifeid, helitype)
{
	if(!isdefined(helitype))
	{
		helitype = "";
	}

	switch(helitype)
	{
		case "flares":
			eventtype = "helicopter_flares";
			break;

		case "minigun":
			eventtype = "helicopter_minigun";
			break;

		default:
			eventtype = "helicopter";
			break;
	}

	team = self.pers["team"];
	startnode = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
	maps\mp\_matchdata::logkillstreakevent(eventtype, self.origin);
	thread heli_think(lifeid, self, startnode, self.pers["team"], helitype);
}

precachehelicopter(model, helitype)
{
	deathfx = loadfx("explosions/tanker_explosion");
	precachemodel(model);
	level.heli_types[model] = helitype;
	level.cobra_missile_models = [];
	level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
	precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
	level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["allies"]["crash"] = "cobra_helicopter_crash";
	level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
	level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["axis"]["crash"] = "cobra_helicopter_crash";
	level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

spawn_helicopter(owner, origin, angles, vehicletype, modelname)
{
	chopper = spawnhelicopter(owner, origin, angles, vehicletype, modelname);
	if(!isdefined(chopper))
	{
		return undefined;
	}

	chopper.heli_type = level.heli_types[modelname];
	chopper thread [[ level.lightfxfunc[chopper.heli_type] ]]();
	chopper addtohelilist();
	chopper.zoffset = (0,0,chopper gettagorigin("tag_origin")[2] - chopper gettagorigin("tag_ground")[2]);
	chopper.attractor = missile_createattractorent(chopper, level.heli_attract_strength, level.heli_attract_range);
	chopper.damagecallback = ::callback_vehicledamage;
	return chopper;
}

heliride(lifeid, chopper)
{
	self endon("disconnect");
	chopper endon("helicopter_done");
	thread maps\mp\_utility::teamplayercardsplash("used_helicopter_minigun", self);
	self visionsetthermalforplayer("black_bw", 0);
	maps\mp\_utility::_giveweapon("heli_remote_mp");
	self switchtoweapon("heli_remote_mp");
	self visionsetthermalforplayer(game["thermal_vision"], 6);
	self thermalvisionon();
	self thermalvisionfofoverlayon();
	thread thermalvision(chopper);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(0);
	}

	chopper vehicleturretcontrolon(self);
	self playerlinkweaponviewtodelta(chopper, "tag_player", 1, 180, 180, 0, 180, 1);
	chopper.gunner = self;
	self.heliridelifeid = lifeid;
	thread endrideonhelicopterdone(chopper);
	thread weaponlockthink(chopper);
	for(;;)
	{
		chopper waittill("turret_fire");
		chopper fireweapon();
		earthquake(0.2, 1, chopper.origin, 1000);
	}
}

thermalvision(chopper)
{
	chopper endon("helicopter_done");
	if(maps\mp\_utility::getintproperty("ac130_thermal_enabled", 1) == 0)
	{
		return;
	}

	inverted = 0;
	self visionsetthermalforplayer(game["thermal_vision"], 3);
	self notifyonplayercommand("switch thermal", "+activate");
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

weaponlockthink(chopper)
{
	self endon("disconnect");
	chopper endon("helicopter_done");
	if(!isdefined(level.helitargetorigin))
	{
		level.helitargetorigin = spawn("script_origin", (0,0,0));
		level.helitargetorigin hide();
	}

	for(;;)
	{
		trace = bullettrace(self geteye(), self geteye() + anglestoforward(self getplayerangles()) * 100000, 1, self);
		level.helitargetorigin.origin = trace["position"];
		targetlistlos = [];
		targetlistnolos = [];
		foreach(player in level.players)
		{
			if(!isalive(player))
			{
				continue;
			}

			if(level.teambased && player.team == self.team)
			{
				continue;
			}

			if(player == self)
			{
				continue;
			}

			if(player maps\mp\_utility::_hasperk("specialty_coldblooded"))
			{
				continue;
			}

			if(isdefined(player.spawntime) && gettime() - player.spawntime / 1000 <= 5)
			{
				continue;
			}

			player.remotehelilos = 1;
			if(!bullettracepassed(self geteye(), player.origin + (0,0,32), 0, chopper))
			{
				targetlistnolos[targetlistnolos.size] = player;
				continue;
			}

			targetlistlos[targetlistlos.size] = player;
		}

		targetsinreticle = [];
		targetsinreticle = targetlistlos;
		foreach(target in targetlistnolos)
		{
			targetlistlos[targetlistlos.size] = target;
		}

		if(targetsinreticle.size != 0)
		{
			sortedtargets = sortbydistance(targetsinreticle, trace["position"]);
			if(distance(sortedtargets[0].origin, trace["position"]) < 384 && sortedtargets[0] damageconetrace(trace["position"]))
			{
				self weaponlockfinalize(sortedtargets[0]);
				helidialog("locked");
			}
			else
			{
				self weaponlockstart(sortedtargets[0]);
				helidialog("tracking");
			}
		}
		else
		{
			self weaponlockfree();
		}

		wait 0.05;
	}
}

helidialog(dialoggroup)
{
	if(gettime() - level.lasthelidialogtime < 6000)
	{
		return;
	}

	level.lasthelidialogtime = gettime();
	randomindex = randomint(level.helidialog[dialoggroup].size);
	soundalias = level.helidialog[dialoggroup][randomindex];
	fullsoundalias = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + soundalias;
	self playlocalsound(fullsoundalias);
}

endride(chopper)
{
	self remotecamerasoundscapeoff();
	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self unlink();
	self switchtoweapon(common_scripts\utility::getlastweapon());
	maps\mp\_utility::clearusingremote();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	self visionsetthermalforplayer(game["thermal_vision"], 0);
	weaponlist = self getweaponslistexclusives();
	foreach(weapon in weaponlist)
	{
		self takeweapon(weapon);
	}

	if(isdefined(chopper))
	{
		chopper vehicleturretcontroloff(self);
	}

	self notify("heliPlayer_removed");
}

endrideonhelicopterdone(chopper)
{
	self endon("disconnect");
	chopper waittill("helicopter_done");
	endride(chopper);
}

getposnearenemies()
{
	validenemies = [];
	foreach(player in level.players)
	{
		if(player.team == "spectator")
		{
			continue;
		}

		if(player.team == self.team)
		{
			continue;
		}

		if(!isalive(player))
		{
			continue;
		}

		if(!bullettracepassed(player.origin, player.origin + (0,0,2048), 0, player))
		{
			continue;
		}

		player.remotehelidist = 0;
		validenemies[validenemies.size] = player;
	}

	if(!validenemies.size)
	{
		return undefined;
	}

	for(i = 0;i < validenemies.size;i++)
	{
		for(j = i + 1;j < validenemies.size;j++)
		{
			dist = distancesquared(validenemies[i].origin, validenemies[j].origin);
			validenemies[i].remotehelidist = validenemies[i].remotehelidist + dist;
			validenemies[j].remotehelidist = validenemies[j].remotehelidist + dist;
		}
	}

	bestplayer = validenemies[0];
	foreach(player in validenemies)
	{
		if(player.remotehelidist < bestplayer.remotehelidist)
		{
			bestplayer = player;
		}
	}

	return bestplayer.origin;
}

updateareanodes(areanodes)
{
	validenemies = [];
	foreach(node in areanodes)
	{
		node.validplayers = [];
		node.nodescore = 0;
	}

	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(player.team == self.team)
		{
			continue;
		}

		foreach(node in areanodes)
		{
			if(distancesquared(player.origin, node.origin) > 1048576)
			{
				continue;
			}

			node.validplayers[node.validplayers.size] = player;
		}
	}

	bestnode = areanodes[0];
	foreach(node in areanodes)
	{
		helinode = getent(node.target, "targetname");
		foreach(player in node.validplayers)
		{
			node.nodescore = node.nodescore + 1;
			if(bullettracepassed(player.origin + (0,0,32), helinode.origin, 0, player))
			{
				node.nodescore = node.nodescore + 3;
			}
		}

		if(node.nodescore > bestnode.nodescore)
		{
			bestnode = node;
		}
	}

	return getent(bestnode.target, "targetname");
}

heli_think(lifeid, owner, startnode, heli_team, helitype)
{
	heliorigin = startnode.origin;
	heliangles = startnode.angles;
	switch(helitype)
	{
		case "minigun":
			vehicletype = "cobra_minigun_mp";
			if(owner.team == "allies")
			{
				vehiclemodel = "vehicle_apache_mp";
			}
			else
			{
				vehiclemodel = "vehicle_mi-28_mp";
			}
			break;

		case "flares":
			vehicletype = "pavelow_mp";
			if(startnode.team == "allies")
			{
				vehiclemodel = "vehicle_pavelow";
			}
			else
			{
				vehiclemodel = "vehicle_pavelow_opfor";
			}
			break;

		default:
			vehicletype = "cobra_mp";
			if(startnode.team == "allies")
			{
				vehiclemodel = "vehicle_cobra_helicopter_fly_low";
			}
			else
			{
				vehiclemodel = "vehicle_mi24p_hind_mp";
			}
			break;
	}

	chopper = spawn_helicopter(owner, heliorigin, heliangles, vehicletype, vehiclemodel);
	if(!isdefined(chopper))
	{
		return;
	}

	level.chopper = chopper;
	chopper.helitype = helitype;
	chopper.lifeid = lifeid;
	chopper.team = heli_team;
	chopper.pers["team"] = heli_team;
	chopper.owner = owner;
	if(helitype == "flares")
	{
		chopper.maxhealth = level.heli_maxhealth * 2;
	}
	else
	{
		chopper.maxhealth = level.heli_maxhealth;
	}

	chopper.targeting_delay = level.heli_targeting_delay;
	chopper.primarytarget = undefined;
	chopper.secondarytarget = undefined;
	chopper.attacker = undefined;
	chopper.currentstate = "ok";
	if(helitype == "flares" || helitype == "minigun")
	{
		chopper thread heli_flares_monitor();
	}

	chopper thread heli_leave_on_disconnect(owner);
	chopper thread heli_leave_on_changeteams(owner);
	chopper thread heli_leave_on_gameended(owner);
	chopper thread heli_damage_monitor();
	chopper thread heli_health();
	chopper thread heli_existance();
	chopper endon("helicopter_done");
	chopper endon("crashing");
	chopper endon("leaving");
	chopper endon("death");
	if(helitype == "minigun")
	{
		owner thread heliride(lifeid, chopper);
		chopper thread heli_leave_on_spawned(owner);
	}

	attackareas = getentarray("heli_attack_area", "targetname");
	loopnode = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
	switch(helitype)
	{
		case "minigun":
			chopper thread heli_targeting();
			chopper heli_fly_simple_path(startnode);
			chopper thread heli_leave_on_timeout(40);
			if(attackareas.size)
			{
				chopper thread heli_fly_well(attackareas);
			}
			else
			{
				chopper thread heli_fly_loop_path(loopnode);
			}
			break;

		case "flares":
			chopper thread makegunship();
			thread maps\mp\_utility::teamplayercardsplash("used_helicopter_flares", owner);
			chopper heli_fly_simple_path(startnode);
			chopper thread heli_leave_on_timeout(60);
			chopper thread heli_fly_loop_path(loopnode);
			break;

		default:
			chopper thread attack_targets();
			chopper thread heli_targeting();
			chopper heli_fly_simple_path(startnode);
			chopper thread heli_leave_on_timeout(60);
			chopper thread heli_fly_loop_path(loopnode);
			break;
	}
}

makegunship()
{
	self endon("death");
	self endon("helicopter_done");
	wait 0.5;
	mgturret = spawnturret("misc_turret", self.origin, "pavelow_minigun_mp");
	mgturret.lifeid = self.lifeid;
	mgturret linkto(self, "tag_gunner_left", (0,0,0), (0,0,0));
	mgturret setmodel("weapon_minigun");
	mgturret.owner = self.owner;
	mgturret.team = self.team;
	mgturret maketurretinoperable();
	mgturret.pers["team"] = self.team;
	mgturret.killcament = self;
	self.mgturretleft = mgturret;
	self.mgturretleft setdefaultdroppitch(0);
	mgturret = spawnturret("misc_turret", self.origin, "pavelow_minigun_mp");
	mgturret.lifeid = self.lifeid;
	mgturret linkto(self, "tag_gunner_right", (0,0,0), (0,0,0));
	mgturret setmodel("weapon_minigun");
	mgturret.owner = self.owner;
	mgturret.team = self.team;
	mgturret maketurretinoperable();
	mgturret.pers["team"] = self.team;
	mgturret.killcament = self;
	self.mgturretright = mgturret;
	self.mgturretright setdefaultdroppitch(0);
	if(level.teambased)
	{
		self.mgturretleft setturretteam(self.team);
		self.mgturretright setturretteam(self.team);
	}

	self.mgturretleft setmode("auto_nonai");
	self.mgturretright setmode("auto_nonai");
	self.mgturretleft setsentryowner(self.owner);
	self.mgturretright setsentryowner(self.owner);
	self.mgturretleft setturretminimapvisible(0);
	self.mgturretright setturretminimapvisible(0);
	self.mgturretleft thread sentry_attacktargets();
	self.mgturretright thread sentry_attacktargets();
	thread deleteturretswhendone();
}

deleteturretswhendone()
{
	self waittill("helicopter_done");
	self.mgturretright delete();
	self.mgturretleft delete();
}

sentry_attacktargets()
{
	self endon("death");
	self endon("helicopter_done");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self isfiringturret())
		{
			thread sentry_burstfirestart();
			continue;
		}

		thread sentry_burstfirestop();
	}
}

sentry_burstfirestart()
{
	self endon("death");
	self endon("stop_shooting");
	self endon("leaving");
	level endon("game_ended");
	firetime = 0.1;
	minshots = 40;
	maxshots = 80;
	minpause = 1;
	maxpause = 2;
	for(;;)
	{
		numshots = randomintrange(minshots, maxshots + 1);
		for(i = 0;i < numshots;i++)
		{
			targetent = self getturrettarget(0);
			if(isdefined(targetent) && !isdefined(targetent.spawntime) || gettime() - targetent.spawntime / 1000 > 5)
			{
				self shootturret();
			}

			wait firetime;
		}

		wait randomfloatrange(minpause, maxpause);
	}
}

sentry_burstfirestop()
{
	self notify("stop_shooting");
}

heli_existance()
{
	entitynumber = self getentitynumber();
	common_scripts\utility::waittill_any("death", "crashing", "leaving");
	removefromhelilist(entitynumber);
	self notify("helicopter_done");
	player = undefined;
	queueent = maps\mp\_utility::queueremovefirst("helicopter");
	if(!isdefined(queueent))
	{
		level.chopper = undefined;
		return;
	}

	player = queueent.player;
	lifeid = queueent.lifeid;
	streakname = queueent.streakname;
	helitype = queueent.helitype;
	queueent delete();
	if(isdefined(player) && player.sessionstate == "playing" || player.sessionstate == "dead")
	{
		player maps\mp\killstreaks\_killstreaks::usedkillstreak(streakname, 1);
		player starthelicopter(lifeid, helitype);
		return;
	}

	level.chopper = undefined;
}

heli_targeting()
{
	self endon("death");
	self endon("helicopter_done");
	for(;;)
	{
		targets = [];
		self.primarytarget = undefined;
		self.secondarytarget = undefined;
		players = level.players;
		foreach(player in level.players)
		{
			if(!cantarget_turret(player))
			{
				continue;
			}

			targets[targets.size] = player;
		}

		if(targets.size)
		{
			targetplayer = getbestprimarytarget(targets);
			self.primarytarget = targetplayer;
			self notify("primary acquired");
		}

		if(isdefined(level.harriers))
		{
			foreach(harrier in level.harriers)
			{
				if(!isdefined(harrier))
				{
					continue;
				}

				if((level.teambased && harrier.team != self.team) || !level.teambased && harrier.owner != self.owner)
				{
					self notify("secondary acquired");
					self.secondarytarget = harrier;
				}
			}
		}

		wait 0.5;
	}
}

cantarget_turret(player)
{
	cantarget = 1;
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}

	if(self.helitype != "flares")
	{
		if(!self vehicle_canturrettargetpoint(player.origin + (0,0,40), 1, self))
		{
			return 0;
		}
	}

	if(distance(player.origin, self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(level.teambased && player.pers["team"] == self.team)
	{
		return 0;
	}

	if(player == self.owner)
	{
		return 0;
	}

	if(isdefined(player.spawntime) && gettime() - player.spawntime / 1000 <= 5)
	{
		return 0;
	}

	if(player maps\mp\_utility::_hasperk("specialty_coldblooded"))
	{
		return 0;
	}

	heli_centroid = self.origin + (0,0,-160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(player sightconetrace(heli_turret_point, self) < level.heli_target_recognition)
	{
		return 0;
	}

	return cantarget;
}

getbestprimarytarget(targets)
{
	foreach(player in targets)
	{
		update_player_threat(player);
	}

	highest = 0;
	primarytarget = undefined;
	foreach(player in targets)
	{
		if(player.threatlevel < highest)
		{
			continue;
		}

		highest = player.threatlevel;
		primarytarget = player;
	}

	return primarytarget;
}

update_player_threat(player)
{
	player.threatlevel = 0;
	dist = distance(player.origin, self.origin);
	player.threatlevel = player.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
	if(isdefined(self.attacker) && player == self.attacker)
	{
		player.threatlevel = player.threatlevel + 100;
	}

	player.threatlevel = player.threatlevel + player.score * 4;
	if(isdefined(player.antithreat))
	{
		player.threatlevel = player.threatlevel - player.antithreat;
	}

	if(player.threatlevel <= 0)
	{
		player.threatlevel = 1;
		return;
	}
}

heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self vehicle_setspeed(60, 25);
	self setyawspeed(75, 45, 45);
	self setmaxpitchroll(30, 30);
	self setneargoalnotifydist(256);
	self setturningability(0.9);
}

callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname)
{
	if(!isdefined(attacker) || attacker == self)
	{
		return;
	}

	if(!maps\mp\gametypes\_weapons::attackercandamageitem(attacker, self.owner))
	{
		return;
	}

	switch(weapon)
	{
		case "javelin_mp":
		case "stinger_mp":
		case "remotemissile_projectile_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			self.largeprojectiledamage = 1;
			damage = self.maxhealth + 1;
			break;
	}

	if(self.damagetaken + damage >= self.maxhealth)
	{
		validattacker = undefined;
		if(!isdefined(self.owner) || attacker != self.owner)
		{
			validattacker = attacker;
		}

		if(isdefined(validattacker))
		{
			validattacker notify("destroyed_killstreak", weapon);
		}
	}

	self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, weapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

addrecentdamage(damage)
{
	self endon("death");
	self.recentdamageamount = self.recentdamageamount + damage;
	wait 4;
	self.recentdamageamount = self.recentdamageamount - damage;
}

heli_damage_monitor()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.damagetaken = 0;
	self.recentdamageamount = 0;
	for(;;)
	{
		self waittill("damage", damage, attacker, direction_vec, p, type);
		self.attacker = attacker;
		if(isplayer(attacker))
		{
			attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
			if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET")
			{
				damage = damage * level.heli_armor_bulletdamage;
				if(attacker maps\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					damage = damage + damage * level.armorpiercingmod;
				}
			}
		}

		self.damagetaken = self.damagetaken + damage;
		thread addrecentdamage(damage);
		if(self.damagetaken > self.maxhealth && (level.teambased && self.team != attacker.team) || !level.teambased)
		{
			validattacker = undefined;
			if(isdefined(attacker.owner) && !isdefined(self.owner) || attacker.owner != self.owner)
			{
				validattacker = attacker.owner;
			}
			else if(!isdefined(attacker.owner) && attacker.classname == "script_vehicle")
			{
				return;
			}
			else if(!isdefined(self.owner) || attacker != self.owner)
			{
				validattacker = attacker;
			}

			if(isdefined(validattacker))
			{
				attacker notify("destroyed_helicopter");
				if(self.helitype == "flares")
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter_flares", validattacker);
					xpval = 400;
				}
				else if(self.helitype == "minigun")
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter_minigun", validattacker);
					xpval = 300;
				}
				else
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter", validattacker);
					xpval = 200;
				}

				validattacker thread maps\mp\gametypes\_rank::giverankxp("kill", xpval);
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner, self, undefined, validattacker, damage, type);
			}
		}
	}
}

heli_health()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	damagestate = 3;
	self setdamagestage(damagestate);
	for(;;)
	{
		if(self.damagetaken >= self.maxhealth * 0.33 && damagestate == 3)
		{
			damagestate = 2;
			self setdamagestage(damagestate);
			self.currentstate = "light smoke";
			playfxontag(level.chopper_fx["damage"]["light_smoke"], self, "tag_engine_left");
		}
		else if(self.damagetaken >= self.maxhealth * 0.66 && damagestate == 2)
		{
			damagestate = 1;
			self setdamagestage(damagestate);
			self.currentstate = "heavy smoke";
			stopfxontag(level.chopper_fx["damage"]["light_smoke"], self, "tag_engine_left");
			playfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
		}
		else if(self.damagetaken > self.maxhealth)
		{
			damagestate = 0;
			self setdamagestage(damagestate);
			stopfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
			if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
			{
				thread heli_explode(1);
			}
			else
			{
				playfxontag(level.chopper_fx["damage"]["on_fire"], self, "tag_engine_left");
				thread heli_crash();
			}
		}

		wait 0.05;
	}
}

heli_crash()
{
	self notify("crashing");
	crashnode = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];
	thread heli_spin(180);
	thread heli_secondary_explosions();
	heli_fly_simple_path(crashnode);
	thread heli_explode();
}

heli_secondary_explosions()
{
	playfxontag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
	self playsound(level.heli_sound[self.team]["hitsecondary"]);
	wait 3;
	if(!isdefined(self))
	{
		return;
	}

	playfxontag(level.chopper_fx["explode"]["large"], self, "tag_engine_left");
	self playsound(level.heli_sound[self.team]["hitsecondary"]);
}

heli_spin(speed)
{
	self endon("death");
	self playsound(level.heli_sound[self.team]["hit"]);
	thread spinsoundshortly();
	self setyawspeed(speed, speed, speed);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait 1;
	}
}

spinsoundshortly()
{
	self endon("death");
	wait 0.25;
	self stoploopsound();
	wait 0.05;
	self playloopsound(level.heli_sound[self.team]["spinloop"]);
	wait 0.05;
	self playloopsound(level.heli_sound[self.team]["spinstart"]);
}

heli_explode(altstyle)
{
	self notify("death");
	if(isdefined(altstyle) && isdefined(level.chopper_fx["explode"]["air_death"][self.heli_type]))
	{
		deathangles = self gettagangles("tag_deathfx");
		playfx(level.chopper_fx["explode"]["air_death"][self.heli_type], self gettagorigin("tag_deathfx"), anglestoforward(deathangles), anglestoup(deathangles));
	}
	else
	{
		org = self.origin;
		forward = self.origin + (0,0,1) - self.origin;
		playfx(level.chopper_fx["explode"]["death"][self.heli_type], org, forward);
	}

	self playsound(level.heli_sound[self.team]["crash"]);
	wait 0.05;
	self delete();
}

fire_missile(smissiletype, ishots, etarget)
{
	if(!isdefined(ishots))
	{
		ishots = 1;
	}

	weaponname = undefined;
	weaponshoottime = undefined;
	defaultweapon = "cobra_20mm_mp";
	tags = [];
	switch(smissiletype)
	{
		case "ffar":
			weaponname = "harrier_FFAR_mp";
			tags[0] = "tag_store_r_2";
			break;

		default:
			break;
	}

	weaponshoottime = weaponfiretime(weaponname);
	self setvehweapon(weaponname);
	nextmissiletag = -1;
	for(i = 0;i < ishots;i++)
	{
		nextmissiletag++;
		if(nextmissiletag >= tags.size)
		{
			nextmissiletag = 0;
		}

		self setvehweapon("harrier_FFAR_mp");
		if(isdefined(etarget))
		{
			emissile = self fireweapon(tags[nextmissiletag], etarget);
			emissile missile_setflightmodedirect();
			emissile missile_settargetent(etarget);
		}
		else
		{
			emissile = self fireweapon(tags[nextmissiletag]);
			emissile missile_setflightmodedirect();
			emissile missile_settargetent(etarget);
		}

		if(i < ishots - 1)
		{
			wait weaponshoottime;
		}
	}
}

check_owner()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		thread heli_leave();
		return 0;
	}

	return 1;
}

heli_leave_on_disconnect(owner)
{
	self endon("death");
	self endon("helicopter_done");
	owner waittill("disconnect");
	thread heli_leave();
}

heli_leave_on_changeteams(owner)
{
	self endon("death");
	self endon("helicopter_done");
	owner common_scripts\utility::waittill_any("joined_team", "joined_spectators");
	thread heli_leave();
}

heli_leave_on_spawned(owner)
{
	self endon("death");
	self endon("helicopter_done");
	owner waittill("spawned");
	thread heli_leave();
}

heli_leave_on_gameended(owner)
{
	self endon("death");
	self endon("helicopter_done");
	level waittill("game_ended");
	thread heli_leave();
}

heli_leave_on_timeout(timeout)
{
	self endon("death");
	self endon("helicopter_done");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(timeout);
	thread heli_leave();
}

attack_targets()
{
	thread attack_primary();
	thread attack_secondary();
}

attack_secondary()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(isdefined(self.secondarytarget))
		{
			self.secondarytarget.antithreat = undefined;
			self.missiletarget = self.secondarytarget;
			antithreat = 0;
			while(isdefined(self.missiletarget) && isalive(self.missiletarget))
			{
				if(missile_target_sight_check(self.missiletarget))
				{
					thread missile_support(self.missiletarget, level.heli_missile_rof);
				}
				else
				{
					break;
				}

				self waittill("missile ready");
				if(!isdefined(self.secondarytarget) || isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget)
				{
					break;
				}
			}

			if(isdefined(self.missiletarget))
			{
				self.missiletarget.antithreat = undefined;
			}
		}

		self waittill("secondary acquired");
		check_owner();
	}
}

missile_target_sight_check(missiletarget)
{
	heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
	heli2forward = anglestoforward(self.angles);
	heli2forward_normal = vectornormalize(heli2forward);
	heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
	if(heli_dot_target >= level.heli_missile_target_cone)
	{
		debug_print3d_simple("Missile sight: " + heli_dot_target, self, (0,0,-40), 40);
		return 1;
	}

	return 0;
}

missile_support(target_player, rof)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(target_player))
	{
		if(level.teambased)
		{
			if(isdefined(target_player.owner) && target_player.team != self.team)
			{
				fire_missile("ffar", 1, target_player);
				self notify("missile fired");
			}
		}
		else if(isdefined(target_player.owner) && target_player.owner != self.owner)
		{
			fire_missile("ffar", 1, target_player);
			self notify("missile fired");
		}
	}

	wait rof;
	self notify("missile ready");
}

attack_primary()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		wait 0.05;
		if(!isalive(self.primarytarget))
		{
			continue;
		}

		currenttarget = self.primarytarget;
		currenttarget.antithreat = 0;
		if(randomint(5) < 3)
		{
			angle = currenttarget.angles[1] + randomfloatrange(-30, 30);
		}
		else
		{
			angle = randomint(360);
		}

		radiusoffset = 96;
		xoffset = cos(angle) * radiusoffset;
		yoffset = sin(angle) * radiusoffset;
		self setturrettargetent(currenttarget, (xoffset,yoffset,40));
		waitontargetordeath(currenttarget, 3);
		if(!isalive(currenttarget) || !self vehicle_canturrettargetpoint(currenttarget.origin + (0,0,40)))
		{
			continue;
		}

		weaponshoottime = weaponfiretime("cobra_20mm_mp");
		convergencemod = 1;
		shotssincelastsighting = 0;
		self playloopsound("weap_cobra_20mm_fire_npc");
		for(i = 0;i < level.heli_turretclipsize;i++)
		{
			self setvehweapon("cobra_20mm_mp");
			self fireweapon("tag_flash");
			if(i < level.heli_turretclipsize - 1)
			{
				wait weaponshoottime;
			}

			if(!isdefined(currenttarget))
			{
				break;
			}

			if(self vehicle_canturrettargetpoint(currenttarget.origin + (0,0,40), 1, self))
			{
				convergencemod = max(convergencemod - 0.05, 0);
				shotssincelastsighting = 0;
			}
			else
			{
				shotssincelastsighting++;
			}

			if(shotssincelastsighting > 10)
			{
				break;
			}

			targetpos = (xoffset * convergencemod + randomfloatrange(-6, 6),yoffset * convergencemod + randomfloatrange(-6, 6),40 + randomfloatrange(-6, 6));
			self setturrettargetent(currenttarget, targetpos);
		}

		self stoploopsound();
		if(isalive(currenttarget))
		{
			currenttarget.antithreat = currenttarget.antithreat + 100;
		}

		wait randomfloatrange(0.5, 2);
	}
}

waitontargetordeath(target, timeout)
{
	self endon("death");
	self endon("helicopter_done");
	target endon("death");
	target endon("disconnect");
	common_scripts\utility::waittill_notify_or_timeout("turret_on_target", timeout);
}

firemissile(missiletarget)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(!isdefined(missiletarget))
	{
		return;
	}

	if(distance2d(self.origin, missiletarget.origin) < 512)
	{
		return;
	}

	self setvehweapon("harrier_FFAR_mp");
	missile = self fireweapon("tag_flash", missiletarget);
	missile missile_setflightmodedirect();
	missile missile_settargetent(missiletarget);
}

getoriginoffsets(goalnode)
{
	startorigin = self.origin;
	endorigin = goalnode.origin;
	numtraces = 0;
	maxtraces = 40;
	traceoffset = (0,0,-196);
	traceorigin = physicstrace(startorigin + traceoffset, endorigin + traceoffset);
	while(distance(traceorigin, endorigin + traceoffset) > 10 && numtraces < maxtraces)
	{
		if(startorigin[2] < endorigin[2])
		{
			startorigin = startorigin + (0,0,128);
		}
		else if(startorigin[2] > endorigin[2])
		{
			endorigin = endorigin + (0,0,128);
		}
		else
		{
			startorigin = startorigin + (0,0,128);
			endorigin = endorigin + (0,0,128);
		}

		numtraces++;
		traceorigin = physicstrace(startorigin + traceoffset, endorigin + traceoffset);
	}

	offsets = [];
	offsets["start"] = startorigin;
	offsets["end"] = endorigin;
	return offsets;
}

traveltonode(goalnode)
{
	originoffets = getoriginoffsets(goalnode);
	if(originoffets["start"] != self.origin)
	{
		if(isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel))
		{
			heli_speed = goalnode.script_airspeed;
			heli_accel = goalnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self vehicle_setspeed(heli_speed, heli_accel);
		self setvehgoalpos(originoffets["start"] + (0,0,30), 0);
		self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
		self waittill("goal");
	}

	if(originoffets["end"] != goalnode.origin)
	{
		if(isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel))
		{
			heli_speed = goalnode.script_airspeed;
			heli_accel = goalnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self vehicle_setspeed(heli_speed, heli_accel);
		self setvehgoalpos(originoffets["end"] + (0,0,30), 0);
		self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
		self waittill("goal");
		return;
	}
}

heli_fly_simple_path(startnode)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	heli_reset();
	currentnode = startnode;
	while(isdefined(currentnode.target))
	{
		nextnode = getent(currentnode.target, "targetname");
		if(isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel))
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self vehicle_setspeed(heli_speed, heli_accel);
		if(!isdefined(nextnode.target))
		{
			self setvehgoalpos(nextnode.origin + self.zoffset, 1);
			self waittill("near_goal");
			continue;
		}

		self setvehgoalpos(nextnode.origin + self.zoffset, 0);
		self waittill("near_goal");
		self setgoalyaw(nextnode.angles[1]);
		self waittillmatch("goal");
		currentnode = nextnode;
	}
}

heli_fly_loop_path(startnode)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	heli_reset();
	thread heli_loop_speed_control(startnode);
	currentnode = startnode;
	while(isdefined(currentnode.target))
	{
		nextnode = getent(currentnode.target, "targetname");
		if(isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel))
		{
			self.desired_speed = currentnode.script_airspeed;
			self.desired_accel = currentnode.script_accel;
		}
		else
		{
			self.desired_speed = 30 + randomint(20);
			self.desired_accel = 15 + randomint(15);
		}

		if(self.helitype == "flares")
		{
			self.desired_speed = self.desired_speed * 0.5;
			self.desired_accel = self.desired_accel * 0.5;
		}

		if(isdefined(nextnode.script_delay) && isdefined(self.primarytarget) && !heli_is_threatened())
		{
			self setvehgoalpos(nextnode.origin + self.zoffset, 1);
			self waittill("near_goal");
			wait nextnode.script_delay;
			continue;
		}

		self setvehgoalpos(nextnode.origin + self.zoffset, 0);
		self waittill("near_goal");
		self setgoalyaw(nextnode.angles[1]);
		self waittillmatch("goal");
		currentnode = nextnode;
	}
}

heli_loop_speed_control(currentnode)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel))
	{
		self.desired_speed = currentnode.script_airspeed;
		self.desired_accel = currentnode.script_accel;
	}
	else
	{
		self.desired_speed = 30 + randomint(20);
		self.desired_accel = 15 + randomint(15);
	}

	lastspeed = 0;
	lastaccel = 0;
	for(;;)
	{
		goalspeed = self.desired_speed;
		goalaccel = self.desired_accel;
		if(self.helitype != "flares" && isdefined(self.primarytarget) && !heli_is_threatened())
		{
			goalspeed = goalspeed * 0.25;
		}

		if(lastspeed != goalspeed || lastaccel != goalaccel)
		{
			self vehicle_setspeed(goalspeed, goalaccel);
			lastspeed = goalspeed;
			lastaccel = goalaccel;
		}

		wait 0.05;
	}
}

heli_is_threatened()
{
	if(self.recentdamageamount > 50)
	{
		return 1;
	}

	if(self.currentstate == "heavy smoke")
	{
		return 1;
	}

	return 0;
}

heli_fly_well(destnodes)
{
	self notify("flying");
	self endon("flying");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		currentnode = get_best_area_attack_node(destnodes);
		traveltonode(currentnode);
		if(isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel))
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self vehicle_setspeed(heli_speed, heli_accel);
		self setvehgoalpos(currentnode.origin + self.zoffset, 1);
		self setgoalyaw(currentnode.angles[1] + level.heli_angle_offset);
		if(level.heli_forced_wait != 0)
		{
			self waittill("near_goal");
			wait level.heli_forced_wait;
			continue;
		}

		if(!isdefined(currentnode.script_delay))
		{
			self waittill("near_goal");
			wait 5 + randomint(5);
			continue;
		}

		self waittillmatch("goal");
		wait currentnode.script_delay;
	}
}

get_best_area_attack_node(destnodes)
{
	return updateareanodes(destnodes);
}

heli_leave()
{
	self notify("leaving");
	leavenode = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
	heli_reset();
	self vehicle_setspeed(100, 45);
	self setvehgoalpos(leavenode.origin, 1);
	self waittillmatch("goal");
	self notify("death");
	wait 0.05;
	self delete();
}

debug_print3d(message, color, ent, origin_offset, frames)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread draw_text(message, color, ent, origin_offset, frames);
		return;
	}
}

debug_print3d_simple(message, ent, offset, frames)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(isdefined(frames))
		{
			thread draw_text(message, (0.8,0.8,0.8), ent, offset, frames);
			return;
		}

		thread draw_text(message, (0.8,0.8,0.8), ent, offset, 0);
		return;
	}
}

debug_line(from, to, color, frames)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1 && !isdefined(frames))
	{
		thread draw_line(from, to, color);
		return;
	}

	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread draw_line(from, to, color, frames);
		return;
	}
}

draw_text(msg, color, ent, offset, frames)
{
	if(frames == 0)
	{
		while(isdefined(ent))
		{
			wait 0.05;
		}

		return;
	}

	for(i = 0;i < frames;i++)
	{
		if(!isdefined(ent))
		{
			break;
		}

		wait 0.05;
	}
}

draw_line(from, to, color, frames)
{
	if(isdefined(frames))
	{
		for(i = 0;i < frames;i++)
		{
			wait 0.05;
		}

		return;
	for(;;)
	{
		}

		wait 0.05;
	}
}

addtohelilist()
{
	level.helis[self getentitynumber()] = self;
}

removefromhelilist(entitynumber)
{
	level.helis[entitynumber] = undefined;
}

playflarefx()
{
	for(i = 0;i < 10;i++)
	{
		if(!isdefined(self))
		{
			return;
		}

		playfxontag(level._effect["ac130_flare"], self, "TAG_FLARE");
		wait 0.15;
	}
}

deployflares()
{
	flareobject = spawn("script_origin", level.ac130.planemodel.origin);
	flareobject.angles = level.ac130.planemodel.angles;
	flareobject movegravity((0,0,0), 5);
	flareobject thread deleteaftertime(5);
	return flareobject;
}

heli_flares_monitor()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("stinger_fired", player, missile, locktarget);
		if(!isdefined(locktarget) || locktarget != self)
		{
			continue;
		}

		missile endon("death");
		thread playflarefx();
		newtarget = deployflares();
		missile missile_settargetent(newtarget);
		return;
	}
}

deleteaftertime(delay)
{
	wait delay;
	self delete();
}
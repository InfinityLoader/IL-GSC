/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 73
 * Decompile Time: 1244 ms
 * Timestamp: 10/27/2023 1:32:37 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = getentarray("heli_start","targetname");
	var_01 = getentarray("heli_loop_start","targetname");
	if(!var_00.size && !var_01.size)
	{
		return;
	}

	level.chopper = undefined;
	level.heli_start_nodes = getentarray("heli_start","targetname");
	level.heli_loop_nodes = getentarray("heli_loop_start","targetname");
	level.strafe_nodes = common_scripts\utility::func_3C1A("strafe_path","targetname");
	level.heli_leave_nodes = getentarray("heli_leave","targetname");
	level.heli_crash_nodes = getentarray("heli_crash_start","targetname");
	level.heli_missile_rof = 5;
	level.heli_maxhealth = 2000;
	level.heli_debug = 0;
	level.heli_targeting_delay = 0.5;
	level.heli_turretreloadtime = 1.5;
	level.heli_turretclipsize = 60;
	level.heli_visual_range = 3700;
	level.heli_target_spawnprotection = 5;
	level.heli_target_recognition = 0.5;
	level.heli_missile_friendlycare = 256;
	level.heli_missile_target_cone = 0.3;
	level.heli_armor_bulletdamage = 0.3;
	level.heli_attract_strength = 1000;
	level.heli_attract_range = 4096;
	level.heli_angle_offset = 90;
	level.heli_forced_wait = 0;
	level func_6112();
	level.chopper_fx["damage"]["light_smoke"] = loadfx("fx/smoke/smoke_trail_white_heli_emitter");
	level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_helo_damage");
	level.chopper_fx["damage"]["on_fire"] = loadfx("fx/fire/fire_smoke_trail_L_emitter");
	level.chopper_fx["light"]["left"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green");
	level.chopper_fx["light"]["right"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red");
	level.chopper_fx["light"]["belly"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_red_blink");
	level.chopper_fx["light"]["tail"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_white_blink");
	level.chopper_fx["explode"]["medium"] = loadfx("fx/explosions/aerial_explosion");
	level.chopper_fx["explode"]["large"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
	level.chopper_fx["smoke"]["trail"] = loadfx("fx/smoke/smoke_trail_white_heli");
	level.chopper_fx["explode"]["death"] = [];
	level.chopper_fx["explode"]["death"]["apache"] = loadfx("vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary");
	level.chopper_fx["explode"]["air_death"]["apache"] = loadfx("vfx/gameplay/explosions/vehicle/apch_mp/vfx_x_mpapc_primary");
	level.lightfxfunc["apache"] = ::func_24BD;
	level.chopper_fx["explode"]["death"]["cobra"] = loadfx("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
	level.chopper_fx["explode"]["air_death"]["cobra"] = loadfx("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
	level.lightfxfunc["cobra"] = ::func_24BD;
	level.chopper_fx["explode"]["death"]["littlebird"] = loadfx("vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary");
	level.chopper_fx["explode"]["air_death"]["littlebird"] = loadfx("vfx/gameplay/explosions/vehicle/aas_mp/vfx_x_mpaas_primary");
	level.lightfxfunc["littlebird"] = ::func_24BD;
	level._effect["vehicle_flares"] = loadfx("fx/misc/flares_cobra");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx("fx/fire/fire_smoke_trail_L_emitter");
	level.killstreakfuncs["helicopter"] = ::func_87BC;
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
	level.heliconfigs = [];
	var_02 = addstruct();
	var_02.xppopup = "destroyed_helicopter";
	var_02.callout = "callout_destroyed_helicopter";
	var_02.samdamagescale = 0.09;
	var_02.enginevfxtag = "tag_engine_left";
	level.heliconfigs["helicopter"] = var_02;
	var_02 = addstruct();
	var_02.xppopup = "destroyed_little_bird";
	var_02.callout = "callout_destroyed_little_bird";
	var_02.samdamagescale = 0.09;
	var_02.enginevfxtag = "tag_engine_left";
	level.heliconfigs["airdrop"] = var_02;
	var_02 = addstruct();
	var_02.xppopup = "destroyed_pavelow";
	var_02.callout = "callout_destroyed_helicopter_flares";
	var_02.samdamagescale = 0.07;
	var_02.enginevfxtag = "tag_engine_left";
	level.heliconfigs["flares"] = var_02;
	maps\mp\_utility::func_6297("helicopter");
}

//Function Number: 2
func_5017(param_00,param_01,param_02)
{
	level.chopper_fx["explode"]["death"][param_00] = loadfx(param_01);
	level.lightfxfunc[param_00] = param_02;
}

//Function Number: 3
addairexplosion(param_00,param_01)
{
	level.chopper_fx["explode"]["air_death"][param_00] = loadfx(param_01);
}

//Function Number: 4
func_24BD()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_L_wing");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["right"],self,"tag_light_R_wing");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail");
}

//Function Number: 5
func_87BC(param_00,param_01)
{
	return func_8439(param_00,"helicopter");
}

//Function Number: 6
func_8439(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.chopper))
	{
		var_03 = 1;
	}
	else
	{
		var_03 = 0;
	}

	if(isdefined(level.chopper) && var_03)
	{
		self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");
		if(isdefined(param_01) && param_01 != "helicopter")
		{
			var_04 = "helicopter_" + param_01;
		}
		else
		{
			var_04 = "helicopter";
		}

		thread maps\mp\killstreaks\_killstreaks::func_86F7();
		var_05 = spawn("script_origin",(0,0,0));
		var_05 hide();
		var_05 thread deleteonentnotify(self,"disconnect");
		var_05.player = self;
		var_05.lifeid = param_00;
		var_05.helitype = param_01;
		var_05.streakname = var_04;
		maps\mp\_utility::func_6295("helicopter",var_05);
		var_06 = undefined;
		if(!self hasweapon(common_scripts\utility::func_3B0A()))
		{
			var_06 = maps\mp\killstreaks\_killstreaks::func_3AAA();
		}
		else
		{
			var_06 = common_scripts\utility::func_3B0A();
		}

		var_07 = maps\mp\_utility::getkillstreakweapon("helicopter");
		thread maps\mp\killstreaks\_killstreaks::waittakekillstreakweapon(var_07,var_06);
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_06 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	var_06 = 1;
	func_7AD7(var_04,var_05);
	return 1;
}

//Function Number: 7
deleteonentnotify(param_00,param_01)
{
	self endon("death");
	param_00 waittill(param_01);
	self delete();
}

//Function Number: 8
func_7AD7(param_00,param_01)
{
	maps\mp\_utility::func_4487();
	var_02 = undefined;
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	var_03 = "helicopter";
	var_04 = self.pers["team"];
	var_02 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
	maps\mp\_matchdata::func_4F1D(var_03,self.origin);
	thread heli_think(param_00,self,var_02,self.pers["team"],param_01);
}

//Function Number: 9
func_6112()
{
	level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
	level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
	level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
	level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

//Function Number: 10
func_40D4()
{
	var_00 = self.team;
	if(level.multiteambased)
	{
		var_00 = "axis";
	}

	return var_00;
}

//Function Number: 11
func_77D5(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnhelicopter(param_00,param_01,param_02,param_03,param_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	if(param_04 == "vehicle_battle_hind")
	{
		var_05.heli_type = "cobra";
	}
	else
	{
		var_05.heli_type = level.heli_types[param_04];
	}

	var_05 thread [[ level.lightfxfunc[var_05.heli_type] ]]();
	var_05 addtohelilist();
	var_05.zoffset = (0,0,var_05 gettagorigin("tag_origin")[2] - var_05 gettagorigin("tag_ground")[2]);
	var_05.attractor = missilecreateattractorent(var_05,level.heli_attract_strength,level.heli_attract_range);
	return var_05;
}

//Function Number: 12
helidialog(param_00)
{
	if(gettime() - level.lasthelidialogtime < 6000)
	{
	}

	level.lasthelidialogtime = gettime();
	var_01 = randomint(level.helidialog[param_00].size);
	var_02 = level.helidialog[param_00][var_01];
	var_03 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + var_02;
	self playlocalsound(var_03);
}

//Function Number: 13
updateareanodes(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.validplayers = [];
		var_03.nodescore = 0;
	}

	foreach(var_06 in level.players)
	{
		if(!isalive(var_06))
		{
			continue;
		}

		if(var_06.team == self.team)
		{
			continue;
		}

		foreach(var_03 in param_00)
		{
			if(distancesquared(var_06.origin,var_03.origin) > 1048576)
			{
				continue;
			}

			var_03.validplayers[var_03.validplayers.size] = var_06;
		}
	}

	var_0A = param_00[0];
	foreach(var_03 in param_00)
	{
		var_0C = getent(var_03.target,"targetname");
		foreach(var_06 in var_03.validplayers)
		{
			var_03.nodescore = var_03.nodescore + 1;
			if(bullettracepassed(var_06.origin + (0,0,32),var_0C.origin,0,var_06))
			{
				var_03.nodescore = var_03.nodescore + 3;
			}
		}

		if(var_03.nodescore > var_0A.nodescore)
		{
			var_0A = var_03;
		}
	}

	return getent(var_0A.target,"targetname");
}

//Function Number: 14
heli_think(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02.origin;
	var_06 = param_02.angles;
	var_07 = "cobra_mp";
	var_08 = "vehicle_battle_hind";
	var_09 = func_77D5(param_01,var_05,var_06,var_07,var_08);
	if(!isdefined(var_09))
	{
	}

	level.chopper = var_09;
	if(param_03 == "allies")
	{
		level.allieschopper = var_09;
	}
	else
	{
		level.axischopper = var_09;
	}

	var_09.helitype = param_04;
	var_09.lifeid = param_00;
	var_09.team = param_03;
	var_09.pers["team"] = param_03;
	var_09.owner = param_01;
	var_09 setotherent(param_01);
	var_09.startnode = param_02;
	var_09.maxhealth = level.heli_maxhealth;
	var_09.targeting_delay = level.heli_targeting_delay;
	var_09.primarytarget = undefined;
	var_09.secondarytarget = undefined;
	var_09.attacker = undefined;
	var_09.currentstate = "ok";
	var_09 common_scripts\utility::func_5009(param_03);
	var_09.empgrenaded = 0;
	if(param_04 == "flares" || param_04 == "minigun")
	{
		var_09 thread maps\mp\killstreaks\_flares::func_33DA(1);
	}

	var_09 thread heli_leave_on_disconnect(param_01);
	var_09 thread heli_leave_on_changeteams(param_01);
	var_09 thread func_40E6(param_01);
	var_09 thread func_40A5(param_04);
	var_09 thread func_4142();
	var_09 thread func_4141();
	var_09 thread func_40B3();
	var_09 endon("helicopter_done");
	var_09 endon("crashing");
	var_09 endon("leaving");
	var_09 endon("death");
	var_0A = getentarray("heli_attack_area","targetname");
	var_0B = undefined;
	var_0B = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
	var_09 func_40C6(param_02);
	var_09 thread func_412F();
	var_09 thread func_40E9(60);
	var_09 thread func_40C5(var_0B);
}

//Function Number: 15
func_40B3()
{
	var_00 = self getentitynumber();
	common_scripts\utility::func_8B2A("death","crashing","leaving");
	removefromhelilist(var_00);
	self notify("helicopter_done");
	self notify("helicopter_removed");
	var_01 = undefined;
	var_02 = maps\mp\_utility::func_6299("helicopter");
	if(!isdefined(var_02))
	{
		level.chopper = undefined;
	}

	var_01 = var_02.player;
	var_03 = var_02.lifeid;
	var_04 = var_02.streakname;
	var_05 = var_02.helitype;
	var_02 delete();
	if(isdefined(var_01) && var_01.sessionstate == "playing" || var_01.sessionstate == "dead")
	{
		var_01 maps\mp\killstreaks\_killstreaks::func_87B3(var_04,1);
		var_01 func_7AD7(var_03,var_05);
	}

	level.chopper = undefined;
}

//Function Number: 16
func_412F()
{
	self notify("heli_targeting");
	self endon("heli_targeting");
	self endon("death");
	self endon("helicopter_done");
	for(;;)
	{
		var_00 = [];
		self.primarytarget = undefined;
		self.secondarytarget = undefined;
		foreach(var_02 in level.characters)
		{
			wait(0.05);
			if(!func_1A01(var_02))
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}

		if(var_00.size)
		{
			for(var_04 = func_3A3E(var_00);!isdefined(var_04);var_04 = func_3A3E(var_00))
			{
				wait(0.05);
			}

			self.primarytarget = var_04;
			self notify("primary acquired");
		}

		if(isdefined(self.primarytarget))
		{
			fireontarget(self.primarytarget);
			continue;
		}

		wait(0.25);
	}
}

//Function Number: 17
func_1A01(param_00)
{
	var_01 = 1;
	if(!isalive(param_00) || isdefined(param_00.sessionstate) && param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(self.helitype == "remote_mortar")
	{
		if(param_00 sightconetrace(self.origin,self) < 1)
		{
			return 0;
		}
	}

	if(distance(param_00.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(!self.owner maps\mp\_utility::isenemy(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_78C4) && gettime() - param_00.var_78C4 / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	var_02 = self.origin + (0,0,-160);
	var_03 = anglestoforward(self.angles);
	var_04 = var_02 + 144 * var_03;
	if(param_00 sightconetrace(var_04,self) < level.heli_target_recognition)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 18
func_3A3E(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		func_869D(var_02);
	}

	var_04 = 0;
	var_05 = undefined;
	var_06 = getentarray("minimap_corner","targetname");
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_06.size == 2)
		{
			var_08 = var_06[0].origin;
			var_09 = var_06[0].origin;
			if(var_06[1].origin[0] > var_09[0])
			{
				var_09 = (var_06[1].origin[0],var_09[1],var_09[2]);
			}
			else
			{
				var_08 = (var_06[1].origin[0],var_08[1],var_08[2]);
			}

			if(var_06[1].origin[1] > var_09[1])
			{
				var_09 = (var_09[0],var_06[1].origin[1],var_09[2]);
			}
			else
			{
				var_08 = (var_08[0],var_06[1].origin[1],var_08[2]);
			}

			if(var_02.origin[0] < var_08[0] || var_02.origin[0] > var_09[0] || var_02.origin[1] < var_08[1] || var_02.origin[1] > var_09[1])
			{
				continue;
			}
		}

		if(var_02.threatlevel < var_04)
		{
			continue;
		}

		if(!bullettracepassed(var_02.origin + (0,0,32),self.origin,0,self))
		{
			wait(0.05);
			continue;
		}

		var_04 = var_02.threatlevel;
		var_05 = var_02;
	}

	return var_05;
}

//Function Number: 19
func_869D(param_00)
{
	param_00.threatlevel = 0;
	var_01 = distance(param_00.origin,self.origin);
	param_00.threatlevel = param_00.threatlevel + level.heli_visual_range - var_01 / level.heli_visual_range * 100;
	if(isdefined(self.attacker) && param_00 == self.attacker)
	{
		param_00.threatlevel = param_00.threatlevel + 100;
	}

	if(isplayer(param_00))
	{
		param_00.threatlevel = param_00.threatlevel + param_00.score * 4;
	}

	if(isdefined(param_00.antithreat))
	{
		param_00.threatlevel = param_00.threatlevel - param_00.antithreat;
	}

	if(param_00.threatlevel <= 0)
	{
		param_00.threatlevel = 1;
	}
}

//Function Number: 20
func_4105()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self setspeed(80,35);
	self setyawspeed(75,45,45);
	self setmaxpitchroll(30,30);
	self neargoalnotifydist(256);
	self setturningability(0.9);
}

//Function Number: 21
func_0960(param_00)
{
	self endon("death");
	self.recentdamageamount = self.recentdamageamount + param_00;
	wait(4);
	self.recentdamageamount = self.recentdamageamount - param_00;
}

//Function Number: 22
modifydamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		if((isdefined(self.owner) && param_00 == self.owner && self.streakname == "heli_sniper") || isdefined(param_00.class) && param_00.class == "worldspawn" || param_00 == self)
		{
			return -1;
		}
	}

	if(isdefined(level.ishorde) && level.ishorde && isdefined(self.streakname) && self.streakname == "heli_sniper")
	{
		return -1;
	}

	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	thread func_0960(var_04);
	self notify("heli_damage_fx");
	return var_04;
}

//Function Number: 23
handledeathdamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		var_04 = level.heliconfigs[self.streakname];
		var_05 = maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.destroyedvo,var_04.callout);
		if(var_05)
		{
			param_00 notify("destroyed_helicopter");
			self.killingattacker = param_00;
		}

		if(param_01 == "heli_pilot_turret_mp")
		{
			param_00 maps\mp\gametypes\_missions::func_61CE("ch_enemy_down");
		}

		maps\mp\gametypes\_missions::checkaachallenges(param_00,self,param_01);
	}
}

//Function Number: 24
func_40A5(param_00,param_01)
{
	self endon("crashing");
	self endon("leaving");
	self.streakname = param_00;
	self.recentdamageamount = 0;
	thread func_40D9();
	maps\mp\gametypes\_damage::func_537B(self.maxhealth,"helicopter",::handledeathdamage,::modifydamage,1,param_01);
}

//Function Number: 25
func_4142()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.owner endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		self.empgrenaded = 1;
		if(isdefined(self.mgturretleft))
		{
			self.mgturretleft notify("stop_shooting");
		}

		if(isdefined(self.mgturretright))
		{
			self.mgturretright notify("stop_shooting");
		}

		wait(var_01);
		self.empgrenaded = 0;
		if(isdefined(self.mgturretleft))
		{
			self.mgturretleft notify("turretstatechange");
		}

		if(isdefined(self.mgturretright))
		{
			self.mgturretright notify("turretstatechange");
		}
	}
}

//Function Number: 26
func_40D9()
{
	self endon("leaving");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self heli_setdamagestage(3);
	var_00 = 3;
	self heli_setdamagestage(var_00);
	var_01 = level.heliconfigs[self.streakname];
	for(;;)
	{
		self waittill("heli_damage_fx");
		if(var_00 > 0 && self.damagetaken >= self.maxhealth)
		{
			var_00 = 0;
			self heli_setdamagestage(var_00);
			stopfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,var_01.enginevfxtag);
			self notify("death");
			break;
		}
		else
		{
			if(var_00 > 1 && self.damagetaken >= self.maxhealth * 0.66)
			{
				var_00 = 1;
				self heli_setdamagestage(var_00);
				self.currentstate = "heavy smoke";
				stopfxontag(level.chopper_fx["damage"]["light_smoke"],self,var_01.enginevfxtag);
				playfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,var_01.enginevfxtag);
				continue;
			}

			if(var_00 > 2 && self.damagetaken >= self.maxhealth * 0.33)
			{
				var_00 = 2;
				self heli_setdamagestage(var_00);
				self.currentstate = "light smoke";
				playfxontag(level.chopper_fx["damage"]["light_smoke"],self,var_01.enginevfxtag);
			}
		}
	}
}

//Function Number: 27
func_4141()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
	{
		thread heli_explode(1);
	}

	var_00 = level.heliconfigs[self.streakname];
	playfxontag(level.chopper_fx["damage"]["on_fire"],self,var_00.enginevfxtag);
	thread func_4096();
}

//Function Number: 28
func_4096()
{
	self notify("crashing");
	self clearlookatent();
	var_00 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("stop_shooting");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("stop_shooting");
	}

	thread func_4113(180);
	thread func_4106();
	func_40C6(var_00);
	thread heli_explode();
}

//Function Number: 29
func_4106()
{
	var_00 = func_40D4();
	var_01 = level.heliconfigs[self.streakname];
	playfxontag(level.chopper_fx["explode"]["large"],self,var_01.enginevfxtag);
	self playsound(level.heli_sound[var_00]["hitsecondary"]);
	wait(3);
	if(!isdefined(self))
	{
	}

	playfxontag(level.chopper_fx["explode"]["large"],self,var_01.enginevfxtag);
	self playsound(level.heli_sound[var_00]["hitsecondary"]);
}

//Function Number: 30
func_4113(param_00)
{
	self endon("death");
	var_01 = func_40D4();
	self playsound(level.heli_sound[var_01]["hit"]);
	thread func_7925();
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 31
func_7925()
{
	self endon("death");
	wait(0.25);
	var_00 = func_40D4();
	self stoploopsound();
	wait(0.05);
	self playloopsound(level.heli_sound[var_00]["spinloop"]);
	wait(0.05);
	self playloopsound(level.heli_sound[var_00]["spinstart"]);
}

//Function Number: 32
heli_explode(param_00)
{
	self notify("death");
	if(isdefined(param_00) && isdefined(level.chopper_fx["explode"]["air_death"][self.heli_type]))
	{
		var_01 = self gettagangles("tag_deathfx");
		playfx(level.chopper_fx["explode"]["air_death"][self.heli_type],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	}
	else
	{
		var_02 = self.origin;
		var_03 = self.origin + (0,0,1) - self.origin;
		playfx(level.chopper_fx["explode"]["death"][self.heli_type],var_02,var_03);
	}

	var_04 = func_40D4();
	self playsound(level.heli_sound[var_04]["crash"]);
	wait(0.05);
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 33
func_1B7B()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		thread func_40E2();
		return 0;
	}

	return 1;
}

//Function Number: 34
heli_leave_on_disconnect(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("disconnect");
	thread func_40E2();
}

//Function Number: 35
heli_leave_on_changeteams(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
	}

	param_00 common_scripts\utility::func_8B2A("joined_team","joined_spectators");
	thread func_40E2();
}

//Function Number: 36
func_40E8(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("spawned");
	thread func_40E2();
}

//Function Number: 37
func_40E6(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	level waittill("game_ended");
	thread func_40E2();
}

//Function Number: 38
func_40E9(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
	thread func_40E2();
}

//Function Number: 39
fireontarget(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	var_01 = 15;
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in level.heli_loop_nodes)
	{
		var_02++;
		var_03 = var_03 + var_05.origin[2];
	}

	var_07 = var_03 / var_02;
	self notify("newTarget");
	if(isdefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth)
	{
	}

	if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver)
	{
	}

	var_08 = self.primarytarget;
	var_08.antithreat = 0;
	var_09 = self.primarytarget.origin * (1,1,0);
	var_0A = self.origin * (0,0,1);
	var_0B = var_09 + var_0A;
	var_0C = distance2d(self.origin,var_08.origin);
	if(var_0C < 1000)
	{
		var_01 = 600;
	}

	var_0D = anglestoforward(var_08.angles);
	var_0D = var_0D * (1,1,0);
	var_0E = var_0B + var_01 * var_0D;
	var_0F = var_0E - var_0B;
	var_10 = vectortoangles(var_0F);
	var_10 = var_10 * (1,1,0);
	thread func_1007(var_08);
	self setspeed(80);
	if(distance2d(self.origin,var_0E) < 1000)
	{
		var_0E = var_0E * 1.5;
	}

	var_0E = var_0E * (1,1,0);
	var_0E = var_0E + (0,0,var_07);
	_setvehgoalpos(var_0E,1,1);
	self waittill("near_goal");
	if(!isdefined(var_08) || !isalive(var_08))
	{
	}

	self setlookatent(var_08);
	thread isfacing(10,var_08);
	common_scripts\utility::func_8B35(4,"facing");
	if(!isdefined(var_08) || !isalive(var_08))
	{
	}

	self clearlookatent();
	var_11 = var_0B + var_01 * anglestoforward(var_10);
	self setmaxpitchroll(40,30);
	_setvehgoalpos(var_11,1,1);
	self setmaxpitchroll(30,30);
	if(isdefined(var_08) && isalive(var_08))
	{
		if(isdefined(var_08.antithreat))
		{
			var_08.antithreat = var_08.antithreat + 100;
		}
		else
		{
			var_08.antithreat = 100;
		}
	}

	common_scripts\utility::func_8B35(3,"near_goal");
}

//Function Number: 40
func_1007(param_00)
{
	self notify("attackGroundTarget");
	self endon("attackGroundTarget");
	self stoploopsound();
	self.isattacking = 1;
	self setturrettargetent(param_00);
	func_8B0E(param_00,3);
	if(!isalive(param_00))
	{
		self.isattacking = 0;
	}

	var_01 = function_0210(self.origin,param_00.origin);
	if(var_01 < 640000)
	{
		thread dropbombs(param_00);
		self.isattacking = 0;
	}

	if(checkisfacing(50,param_00) && common_scripts\utility::func_1DE9())
	{
		thread func_330D(param_00);
		self.isattacking = 0;
	}

	var_02 = weaponfiretime("cobra_20mm_mp");
	var_03 = 0;
	var_04 = 0;
	for(var_05 = 0;var_05 < level.heli_turretclipsize;var_05++)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(self.empgrenaded)
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		if(!isalive(param_00))
		{
			break;
		}

		if(self.damagetaken >= self.maxhealth)
		{
			continue;
		}

		if(!checkisfacing(55,param_00))
		{
			self stoploopsound();
			var_04 = 0;
			wait(var_02);
			var_05--;
			continue;
		}

		if(var_05 < level.heli_turretclipsize - 1)
		{
			wait(var_02);
		}

		if(!isdefined(param_00) || !isalive(param_00))
		{
			break;
		}

		if(!var_04)
		{
			self playloopsound("weap_hind_20mm_fire_npc");
			var_04 = 1;
		}

		self setweapon("cobra_20mm_mp");
		self fireweapon("tag_flash",param_00);
	}

	if(!isdefined(self))
	{
	}

	self stoploopsound();
	var_04 = 0;
	self.isattacking = 0;
}

//Function Number: 41
checkisfacing(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_02 = anglestoforward(self.angles);
	var_03 = param_01.origin - self.origin;
	var_02 = var_02 * (1,1,0);
	var_03 = var_03 * (1,1,0);
	var_03 = vectornormalize(var_03);
	var_02 = vectornormalize(var_02);
	var_04 = vectordot(var_03,var_02);
	var_05 = cos(param_00);
	if(var_04 >= var_05)
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
isfacing(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	while(isalive(param_01))
	{
		var_02 = anglestoforward(self.angles);
		var_03 = param_01.origin - self.origin;
		var_02 = var_02 * (1,1,0);
		var_03 = var_03 * (1,1,0);
		var_03 = vectornormalize(var_03);
		var_02 = vectornormalize(var_02);
		var_04 = vectordot(var_03,var_02);
		var_05 = cos(param_00);
		if(var_04 >= var_05)
		{
			self notify("facing");
			break;
		}

		wait(0.1);
	}
}

//Function Number: 43
func_8B0E(param_00,param_01)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 endon("death");
	param_00 endon("disconnect");
	common_scripts\utility::waittill_notify_or_timeout("turret_on_target",param_01);
}

//Function Number: 44
func_330D(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(level.ps3)
	{
		var_01 = 1;
	}
	else
	{
		var_01 = 2;
	}

	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		if(!isdefined(param_00))
		{
		}

		if(common_scripts\utility::func_1DE9())
		{
			var_03 = magicbullet("hind_missile_mp",self gettagorigin("tag_missile_right") - (0,0,64),param_00.origin,self.owner);
			var_03.vehicle_fired_from = self;
		}
		else
		{
			var_03 = magicbullet("hind_missile_mp",self gettagorigin("tag_missile_left") - (0,0,64),param_00.origin,self.owner);
			var_03.vehicle_fired_from = self;
		}

		var_03 missilesettargetent(param_00);
		var_03.owner = self;
		var_03 missilesetflightmodedirect();
		wait(0.5 / var_01);
	}
}

//Function Number: 45
dropbombs(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(!isdefined(param_00))
	{
	}

	for(var_01 = 0;var_01 < randomintrange(2,5);var_01++)
	{
		if(common_scripts\utility::func_1DE9())
		{
			var_02 = magicbullet("hind_bomb_mp",self gettagorigin("tag_missile_left") - (0,0,45),param_00.origin,self.owner);
			var_02.vehicle_fired_from = self;
		}
		else
		{
			var_02 = magicbullet("hind_bomb_mp",self gettagorigin("tag_missile_right") - (0,0,45),param_00.origin,self.owner);
			var_02.vehicle_fired_from = self;
		}

		wait(randomfloatrange(0.35,0.65));
	}
}

//Function Number: 46
func_3B66(param_00)
{
	var_01 = self.origin;
	var_02 = param_00.origin;
	var_03 = 0;
	var_04 = 40;
	var_05 = (0,0,-196);
	for(var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self);distancesquared(var_06["position"],var_02 + var_05) > 10 && var_03 < var_04;var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self))
	{
		if(var_01[2] < var_02[2])
		{
			var_01 = var_01 + (0,0,128);
		}
		else if(var_01[2] > var_02[2])
		{
			var_02 = var_02 + (0,0,128);
		}
		else
		{
			var_01 = var_01 + (0,0,128);
			var_02 = var_02 + (0,0,128);
		}

		var_03++;
	}

	var_07 = [];
	var_07["start"] = var_01;
	var_07["end"] = var_02;
	return var_07;
}

//Function Number: 47
func_82C6(param_00)
{
	var_01 = func_3B66(param_00);
	if(var_01["start"] != self.origin)
	{
		self setspeed(75,35);
		_setvehgoalpos(var_01["start"] + (0,0,30),0);
		self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
		self waittill("goal");
	}

	if(var_01["end"] != param_00.origin)
	{
		if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
		{
			var_02 = param_00.script_airspeed;
			var_03 = param_00.script_accel;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self setspeed(75,35);
		_setvehgoalpos(var_01["end"] + (0,0,30),0);
		self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
		self waittill("goal");
	}
}

//Function Number: 48
_setvehgoalpos(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	param_02 = 0;
	if(param_02)
	{
		thread _setvehgoalposadheretomesh(param_00,param_01);
	}

	self setgoalpos(param_00,param_01);
}

//Function Number: 49
_setvehgoalposadheretomesh(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	var_02 = param_00;
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		if(common_scripts\utility::func_27FE(self.origin,var_02) < 65536)
		{
			self setgoalpos(var_02,param_01);
			break;
		}

		var_03 = vectortoangles(var_02 - self.origin);
		var_04 = anglestoforward(var_03);
		var_05 = self.origin + var_04 * (1,1,0) * 250;
		var_06 = (0,0,2500);
		var_07 = var_05 + maps\mp\_utility::gethelipilotmeshoffset() + var_06;
		var_08 = var_05 + maps\mp\_utility::gethelipilotmeshoffset() - var_06;
		var_09 = bullettrace(var_07,var_08,0,self,0,0,1);
		var_0A = var_09;
		if(isdefined(var_09["entity"]) && var_09["entity"] == self && var_09["normal"][2] > 0.1)
		{
			var_0B = var_09["position"][2] - 4400;
			var_0C = var_0B - self.origin[2];
			if(var_0C > 256)
			{
				var_09["position"] = var_09["position"] * (1,1,0);
				var_09["position"] = var_09["position"] + (0,0,self.origin[2] + 256);
			}
			else if(var_0C < -256)
			{
				var_09["position"] = var_09["position"] * (1,1,0);
				var_09["position"] = var_09["position"] + (0,0,self.origin[2] - 256);
			}

			var_0A = var_09["position"] - maps\mp\_utility::gethelipilotmeshoffset() + (0,0,600);
		}
		else
		{
			var_0A = var_02;
		}

		self setgoalpos(var_0A,0);
		wait(0.15);
	}
}

//Function Number: 50
func_40C6(param_00)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	func_4105();
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			var_03 = var_01.script_airspeed;
			var_04 = var_01.script_accel;
		}
		else
		{
			var_03 = 30 + randomint(20);
			var_04 = 15 + randomint(15);
		}

		if(isdefined(self.isattacking) && self.isattacking)
		{
			wait(0.05);
			continue;
		}

		if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver)
		{
			wait(0.05);
			continue;
		}

		self setspeed(75,35);
		if(!isdefined(var_02.target))
		{
			_setvehgoalpos(var_02.origin + self.zoffset,1);
			self waittill("near_goal");
			continue;
		}

		_setvehgoalpos(var_02.origin + self.zoffset,0);
		self waittill("near_goal");
		self setgoalyaw(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 51
func_40C5(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	func_4105();
	thread heli_loop_speed_control(param_00);
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver)
		{
			wait(0.25);
			continue;
		}

		if(isdefined(self.isattacking) && self.isattacking)
		{
			wait(0.1);
			continue;
		}

		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			self.desired_speed = var_01.script_airspeed;
			self.desired_accel = var_01.script_accel;
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

		if(isdefined(var_02.script_delay) && isdefined(self.primarytarget) && !func_40DB())
		{
			_setvehgoalpos(var_02.origin + self.zoffset,1,1);
			self waittill("near_goal");
			wait(var_02.script_delay);
			continue;
		}

		_setvehgoalpos(var_02.origin + self.zoffset,0,1);
		self waittill("near_goal");
		self setgoalyaw(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 52
heli_loop_speed_control(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
	{
		self.desired_speed = param_00.script_airspeed;
		self.desired_accel = param_00.script_accel;
	}
	else
	{
		self.desired_speed = 30 + randomint(20);
		self.desired_accel = 15 + randomint(15);
	}

	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = self.desired_speed;
		var_04 = self.desired_accel;
		if(isdefined(self.isattacking) && self.isattacking)
		{
			wait(0.05);
			continue;
		}

		if(self.helitype != "flares" && isdefined(self.primarytarget) && !func_40DB())
		{
			var_03 = var_03 * 0.25;
		}

		if(var_01 != var_03 || var_02 != var_04)
		{
			self setspeed(75,35);
			var_01 = var_03;
			var_02 = var_04;
		}

		wait(0.05);
	}
}

//Function Number: 53
func_40DB()
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

//Function Number: 54
func_40C8(param_00)
{
	self notify("flying");
	self endon("flying");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(isdefined(self.isattacking) && self.isattacking)
		{
			wait(0.05);
			continue;
		}

		var_01 = func_37E5(param_00);
		func_82C6(var_01);
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			var_02 = var_01.script_airspeed;
			var_03 = var_01.script_accel;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self setspeed(75,35);
		_setvehgoalpos(var_01.origin + self.zoffset,1);
		self setgoalyaw(var_01.angles[1] + level.heli_angle_offset);
		if(level.heli_forced_wait != 0)
		{
			self waittill("near_goal");
			wait(level.heli_forced_wait);
			continue;
		}

		if(!isdefined(var_01.script_delay))
		{
			self waittill("near_goal");
			wait(5 + randomint(5));
			continue;
		}

		self waittillmatch("goal");
		wait(var_01.script_delay);
	}
}

//Function Number: 55
func_37E5(param_00)
{
	return updateareanodes(param_00);
}

//Function Number: 56
func_40E2(param_00)
{
	self notify("leaving");
	self clearlookatent();
	if(isdefined(self.helitype) && self.helitype == "osprey" && isdefined(self.pathgoal))
	{
		_setvehgoalpos(self.pathgoal,1);
		common_scripts\utility::func_8B35(5,"goal");
	}

	if(!isdefined(param_00))
	{
		var_01 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
		param_00 = var_01.origin;
	}

	var_02 = spawn("script_origin",param_00);
	if(isdefined(var_02))
	{
		self setlookatent(var_02);
		var_02 thread func_8A65(3);
	}

	var_03 = param_00 - self.origin * 2000;
	func_4105();
	self setspeed(180,45);
	_setvehgoalpos(var_03,1);
	common_scripts\utility::func_8B35(12,"goal");
	self notify("gone");
	self notify("death");
	wait(0.05);
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 57
func_8A65(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 58
debug_print3d(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread func_2A6A(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 59
debug_print3d_simple(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(isdefined(param_03))
		{
			thread func_2A6A(param_00,(0.8,0.8,0.8),param_01,param_02,param_03);
		}

		thread func_2A6A(param_00,(0.8,0.8,0.8),param_01,param_02,0);
	}
}

//Function Number: 60
debug_line(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1 && !isdefined(param_03))
	{
		thread func_2A5B(param_00,param_01,param_02);
	}

	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread func_2A5B(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 61
func_2A6A(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 0)
	{
		while(isdefined(param_02))
		{
			wait(0.05);
		}
	}

	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 62
func_2A5B(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		for(var_04 = 0;var_04 < param_03;var_04++)
		{
			wait(0.05);
		}
	}

	wait(0.05);
}

//Function Number: 63
addtohelilist()
{
	level.helis[self getentitynumber()] = self;
}

//Function Number: 64
removefromhelilist(param_00)
{
	level.helis[param_00] = undefined;
}

//Function Number: 65
addtolittlebirdlist(param_00)
{
	if(isdefined(param_00) && param_00 == "lbSniper")
	{
		level.lbsniper = self;
	}

	level.littlebirds[self getentitynumber()] = self;
}

//Function Number: 66
func_6590(param_00)
{
	var_01 = self getentitynumber();
	self waittill("death");
	if(isdefined(param_00) && param_00 == "lbSniper")
	{
		level.lbsniper = undefined;
	}

	level.littlebirds[var_01] = undefined;
}

//Function Number: 67
func_3041(param_00)
{
	if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && param_00 == "littlebird_flock")
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
pavelowmadeselectionvo()
{
	self endon("death");
	self endon("disconnect");
	self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
	wait(3.5);
	self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

//Function Number: 69
func_4D0A()
{
	self endon("gone");
	if(!isdefined(self))
	{
	}

	self notify("crashing");
	if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
	{
		common_scripts\utility::func_8AFE();
	}
	else
	{
		self setspeed(25,5);
		thread func_4D0C(randomintrange(180,220));
		wait(randomfloatrange(1,2));
	}

	lbexplode();
}

//Function Number: 70
func_4D0C(param_00)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["medium"],self,"tail_rotor_jnt");
	thread func_822D(level.chopper_fx["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 71
lbexplode()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	var_01 = self gettagangles("tag_deathfx");
	playfx(level.chopper_fx["explode"]["air_death"]["littlebird"],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	self playsound("exp_helicopter_fuel");
	self notify("explode");
	func_659E();
}

//Function Number: 72
func_822D(param_00,param_01,param_02)
{
	self notify(param_02);
	self endon(param_02);
	self endon("death");
	for(;;)
	{
		playfxontag(param_00,self,param_01);
		wait(0.05);
	}
}

//Function Number: 73
func_659E()
{
	if(isdefined(self.mgturretleft))
	{
		if(isdefined(self.mgturretleft.killcament))
		{
			self.mgturretleft.killcament delete();
		}

		self.mgturretleft delete();
	}

	if(isdefined(self.mgturretright))
	{
		if(isdefined(self.mgturretright.killcament))
		{
			self.mgturretright.killcament delete();
		}

		self.mgturretright delete();
	}

	if(isdefined(self.marker))
	{
		self.marker delete();
	}

	if(isdefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self)
	{
		level.heli_pilot[self.team] = undefined;
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}
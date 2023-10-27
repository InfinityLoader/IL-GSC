/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_matchevents.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 236 ms
 * Timestamp: 10/27/2023 2:15:06 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.match_events_fx["smoke"] = loadfx("smoke/smoke_grenade_11sec_mp");
	level.match_events_fx["tracer"] = loadfx("misc/tracer_incoming");
	level.match_events_fx["explosion"] = loadfx("explosions/building_explosion_huge_gulag");
	level.matchevents["mortar"] = ::domortar;
	level.matchevents["smoke"] = ::dosmoke;
	level.matchevents["airstrike"] = ::doairstrike;
	level.matchevents["pavelow"] = ::dopavelow;
	level.matchevents["heli_insertion"] = ::doheliinsertion;
	level.matchevents["osprey_insertion"] = ::doospreyinsertion;
	level.matcheventstarted = 0;
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	level endon("matchevent_started");
	self waittill("spawned_player");
	if(level.matcheventstarted == 0)
	{
		level.matcheventstarted = 1;
		if(common_scripts\utility::cointoss())
		{
			self thread [[ common_scripts\utility::random(level.matchevents) ]]();
		}

		level notify("matchevent_started");
	}
}

//Function Number: 4
getmapcenter()
{
	if(isdefined(level.mapcenter))
	{
		return level.mapcenter;
	}

	var_00 = getentarray("mp_tdm_spawn_allies_start","classname");
	var_01 = getentarray("mp_tdm_spawn_axis_start","classname");
	if(isdefined(var_00) && isdefined(var_00[0]) && isdefined(var_01) && isdefined(var_01[0]))
	{
		var_02 = distance(var_00[0].origin,var_01[0].origin) / 2;
		var_03 = vectortoangles(var_00[0].origin - var_01[0].origin);
		var_03 = vectornormalize(var_03);
		return var_00[0].origin + var_03 * var_02;
	}

	return (0,0,0);
}

//Function Number: 5
getstartspawns()
{
	var_00 = getentarray("mp_tdm_spawn_allies_start","classname");
	var_01 = getentarray("mp_tdm_spawn_axis_start","classname");
	if(isdefined(var_00) && isdefined(var_00[0]) && isdefined(var_01) && isdefined(var_01[0]))
	{
		var_02 = [];
		return var_7B;
	}

	return undefined;
}

//Function Number: 6
domortar()
{
	var_00 = getmapcenter();
	var_01 = 1;
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_03 = var_00 + (randomintrange(100,600) * var_01,randomintrange(100,600) * var_01,0);
		var_04 = bullettrace(var_03 + (0,0,500),var_03 - (0,0,500),0);
		if(isdefined(var_04["position"]))
		{
			playfx(level.match_events_fx["tracer"],var_03);
			thread maps\mp\_utility::playsoundinspace("fast_artillery_round",var_03);
			wait randomfloatrange(0.5,1.5);
			playfx(level.match_events_fx["explosion"],var_03);
			playrumbleonposition("grenade_rumble",var_03);
			earthquake(1,0.6,var_03,2000);
			thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main",var_03);
			physicsexplosionsphere(var_03 + (0,0,30),250,125,2);
			var_01 = var_01 * -1;
		}
	}
}

//Function Number: 7
dosmoke()
{
	var_00 = getmapcenter();
	var_01 = 1;
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_03 = var_00 + (randomintrange(100,600) * var_01,randomintrange(100,600) * var_01,0);
		playfx(level.match_events_fx["smoke"],var_03);
		var_01 = var_01 * -1;
		wait 2;
	}
}

//Function Number: 8
doairstrike()
{
	level endon("game_ended");
	var_00 = 1;
	var_01 = getmapcenter();
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_03 = var_01 + (randomintrange(100,600) * var_00,randomintrange(100,600) * var_00,0);
		var_04 = bullettrace(var_03 + (0,0,500),var_03 - (0,0,500),0);
		if(isdefined(var_04["position"]))
		{
			thread doairstrikeflyby(var_04["position"]);
			var_00 = var_00 * -1;
			wait randomintrange(2,4);
		}
	}
}

//Function Number: 9
doairstrikeflyby(param_00)
{
	var_01 = randomint(level.spawnpoints.size - 1);
	var_02 = level.spawnpoints[var_01].origin * (1,1,0);
	var_03 = 8000;
	var_04 = 8000;
	var_05 = getent("airstrikeheight","targetname");
	var_06 = (0,0,var_05.origin[2] + randomintrange(-100,600));
	var_07 = anglestoforward((0,randomint(45),0));
	var_08 = var_02 + var_06 + var_07 * var_03 * -1;
	var_09 = var_02 + var_06 + var_07 * var_04;
	var_0A = var_08 + (randomintrange(400,500),randomintrange(400,500),randomintrange(200,300));
	var_0B = var_09 + (randomintrange(400,500),randomintrange(400,500),randomintrange(200,300));
	var_0C = spawnplane(self,"script_model",var_08);
	var_0D = spawnplane(self,"script_model",var_0A);
	if(common_scripts\utility::cointoss())
	{
		var_0C setmodel("vehicle_av8b_harrier_jet_mp");
		var_0D setmodel("vehicle_av8b_harrier_jet_mp");
	}
	else
	{
		var_0C setmodel("vehicle_av8b_harrier_jet_opfor_mp");
		var_0D setmodel("vehicle_av8b_harrier_jet_opfor_mp");
	}

	var_0C.angles = vectortoangles(var_09 - var_08);
	var_0C playloopsound("veh_mig29_dist_loop");
	var_0C thread playplanefx();
	var_0D.angles = vectortoangles(var_09 - var_0A);
	var_0D playloopsound("veh_mig29_dist_loop");
	var_0D thread playplanefx();
	var_0E = distance(var_08,var_09);
	var_0C moveto(var_09 * 2,var_0E / 2000,0,0);
	wait randomfloatrange(0.25,0.5);
	var_0D moveto(var_0B * 2,var_0E / 2000,0,0);
	wait var_0E / 2000;
	var_0C delete();
	var_0D delete();
}

//Function Number: 10
playplanefx()
{
	self endon("death");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
	wait 0.5;
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	wait 0.5;
	playfxontag(level.fx_airstrike_contrail,self,"tag_left_wingtip");
}

//Function Number: 11
dopavelow()
{
	var_00 = getmapcenter();
	var_01 = bullettrace(var_00 + (0,0,500),var_00 - (0,0,500),0);
	if(isdefined(var_01["position"]))
	{
		if(common_scripts\utility::cointoss())
		{
			var_02 = "vehicle_pavelow";
		}
		else
		{
			var_02 = "vehicle_pavelow_opfor";
		}

		var_03 = spawnhelicopter(self,var_01["position"] + (0,0,1000),(0,0,0),"pavelow_mp",var_02);
		if(!isdefined(var_03))
		{
			return;
		}

		var_03.team = self.pers["team"];
		var_03.heli_type = level.heli_types[var_02];
		var_03 thread [[ level.lightfxfunc[level.heli_types[var_02]] ]]();
		var_03.zoffset = (0,0,var_03 gettagorigin("tag_origin")[2] - var_03 gettagorigin("tag_ground")[2]);
		wait 1;
		playfxontag(level.chopper_fx["damage"]["on_fire"],var_03,"tag_engine_left");
		var_03 thread maps\mp\killstreaks\_helicopter::heli_crash();
	}
}

//Function Number: 12
doheliinsertion()
{
	var_00 = getstartspawns();
	if(isdefined(var_00))
	{
		var_01 = 200;
		var_02 = 200;
		var_03 = 1000;
		var_04 = anglestoforward(var_00["allies"][0].angles) * 300;
		var_05 = anglestoup(var_00["allies"][0].angles) * var_01;
		var_06 = anglestoright(var_00["allies"][0].angles) * 200;
		var_07 = anglestoright(var_00["allies"][0].angles) * -200;
		var_08 = var_00["allies"][0].origin + var_04 + var_05 + var_06;
		var_09 = var_00["allies"][0].origin + var_04 + var_05 + var_07;
		var_0A = spawnhelicopter(self,var_08,var_00["allies"][0].angles,"attack_littlebird_mp","vehicle_little_bird_bench");
		var_0B = spawnhelicopter(self,var_09,var_00["allies"][0].angles,"attack_littlebird_mp","vehicle_little_bird_bench");
		var_0C = anglestoforward(var_00["axis"][0].angles) * 300;
		var_0D = anglestoup(var_00["axis"][0].angles) * var_01;
		var_0E = anglestoright(var_00["axis"][0].angles) * 200;
		var_0F = anglestoright(var_00["axis"][0].angles) * -200;
		var_10 = var_00["axis"][0].origin + var_0C + var_0D + var_0E;
		var_11 = var_00["axis"][0].origin + var_0C + var_0D + var_0F;
		var_12 = spawnhelicopter(self,var_10,var_00["axis"][0].angles,"attack_littlebird_mp","vehicle_little_bird_bench");
		var_13 = spawnhelicopter(self,var_11,var_00["axis"][0].angles,"attack_littlebird_mp","vehicle_little_bird_bench");
		var_0A vehicle_setspeed(20,10);
		var_0A setyawspeed(3,3,3,0.3);
		var_0A setvehgoalpos(var_08 + (0,0,var_02),1);
		var_0B vehicle_setspeed(20,10);
		var_0B setyawspeed(3,3,3,0.3);
		var_0B setvehgoalpos(var_09 + (0,0,var_02),1);
		var_12 vehicle_setspeed(20,10);
		var_12 setyawspeed(3,3,3,0.3);
		var_12 setvehgoalpos(var_10 + (0,0,var_02),1);
		var_13 vehicle_setspeed(20,10);
		var_13 setyawspeed(3,3,3,0.3);
		var_13 setvehgoalpos(var_11 + (0,0,var_02),1);
		var_0A waittill("goal");
		wait 2;
		var_0A vehicle_setspeed(80,60);
		var_0A setyawspeed(30,15,15,0.3);
		var_0A setvehgoalpos(var_08 + (0,0,var_03) + var_06 * 2,1);
		var_0B vehicle_setspeed(80,60);
		var_0B setyawspeed(30,15,15,0.3);
		var_0B setvehgoalpos(var_09 + (0,0,var_03) + var_07 * 2,1);
		var_12 vehicle_setspeed(80,60);
		var_12 setyawspeed(30,15,15,0.3);
		var_12 setvehgoalpos(var_10 + (0,0,var_03) + var_0E * 2,1);
		var_13 vehicle_setspeed(80,60);
		var_13 setyawspeed(30,15,15,0.3);
		var_13 setvehgoalpos(var_11 + (0,0,var_03) + var_0F * 2,1);
		var_0A waittill("goal");
		var_0A vehicle_setspeed(120,120);
		var_0A setyawspeed(60,40,40,0.3);
		var_0A setvehgoalpos(var_08 + (0,0,var_03) + var_06 * 2 + var_04 * -20,1);
		var_0B vehicle_setspeed(120,120);
		var_0B setyawspeed(60,40,40,0.3);
		var_0B setvehgoalpos(var_09 + (0,0,var_03) + var_07 * 2 + var_04 * -20,1);
		var_12 vehicle_setspeed(120,120);
		var_12 setyawspeed(60,40,40,0.3);
		var_12 setvehgoalpos(var_10 + (0,0,var_03) + var_0E * 2 + var_0C * -20,1);
		var_13 vehicle_setspeed(120,120);
		var_13 setyawspeed(60,40,40,0.3);
		var_13 setvehgoalpos(var_11 + (0,0,var_03) + var_0F * 2 + var_0C * -20,1);
		var_0A waittill("goal");
		var_0A delete();
		var_0B delete();
		var_12 delete();
		var_13 delete();
	}
}

//Function Number: 13
doospreyinsertion()
{
	var_00 = getstartspawns();
	if(isdefined(var_00))
	{
		var_01 = 200;
		var_02 = 200;
		var_03 = 1000;
		var_04 = anglestoforward(var_00["allies"][0].angles) * 300;
		var_05 = anglestoup(var_00["allies"][0].angles) * var_01;
		var_06 = var_00["allies"][0].origin + var_04 + var_05;
		var_07 = spawnhelicopter(self,var_06,var_00["allies"][0].angles,"osprey_minigun_mp","vehicle_v22_osprey_body_mp");
		var_08 = anglestoforward(var_00["axis"][0].angles) * 300;
		var_09 = anglestoup(var_00["axis"][0].angles) * var_01;
		var_0A = var_00["axis"][0].origin + var_08 + var_09;
		var_0B = spawnhelicopter(self,var_0A,var_00["axis"][0].angles,"osprey_minigun_mp","vehicle_v22_osprey_body_mp");
		var_07 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsup();
		var_0B thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsup();
		var_07 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchdown();
		var_0B thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchdown();
		var_07 vehicle_setspeed(20,10);
		var_07 setyawspeed(3,3,3,0.3);
		var_07 setvehgoalpos(var_06 + (0,0,var_02),1);
		var_0B vehicle_setspeed(20,10);
		var_0B setyawspeed(3,3,3,0.3);
		var_0B setvehgoalpos(var_0A + (0,0,var_02),1);
		var_07 waittill("goal");
		var_07 thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchup();
		var_0B thread maps\mp\killstreaks\_escortairdrop::airshippitchhatchup();
		wait 2;
		var_07 vehicle_setspeed(80,60);
		var_07 setyawspeed(30,15,15,0.3);
		var_07 setvehgoalpos(var_06 + (0,0,var_03),1);
		var_0B vehicle_setspeed(80,60);
		var_0B setyawspeed(30,15,15,0.3);
		var_0B setvehgoalpos(var_0A + (0,0,var_03),1);
		var_07 waittill("goal");
		var_07 thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsdown();
		var_0B thread maps\mp\killstreaks\_escortairdrop::airshippitchpropsdown();
		var_07 vehicle_setspeed(120,120);
		var_07 setyawspeed(100,100,40,0.3);
		var_07 setvehgoalpos(var_06 + (0,0,var_03) + var_04 * -20,1);
		var_0B vehicle_setspeed(120,120);
		var_0B setyawspeed(100,100,40,0.3);
		var_0B setvehgoalpos(var_0A + (0,0,var_03) + var_08 * -20,1);
		var_07 waittill("goal");
		var_07 delete();
		var_0B delete();
	}
}
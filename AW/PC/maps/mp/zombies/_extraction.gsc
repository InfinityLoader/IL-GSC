/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_extraction.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 249 ms
 * Timestamp: 4/22/2024 2:13:38 AM
*******************************************************************/

//Function Number: 1
initextractionwarbird()
{
	precacheitem("warbird_remote_turret_mp");
	precachempanim("zom_civ_extraction_air_warbird");
	precachempanim("zom_civ_extraction_air_rope");
	precachemodel("vehicle_xh9_warbird_pulley");
	maps\mp\zombies\_civilians::registerextractioninitevent("warbird",::warbirdextractioninit);
	maps\mp\zombies\_civilians::registerextractionescortevent("warbird",::warbirdextractionescort);
	maps\mp\zombies\_civilians::registerextractionevent("warbird",::warbirdextraction);
}

//Function Number: 2
warbirdextractioninit()
{
}

//Function Number: 3
warbirdextractionescort()
{
}

//Function Number: 4
warbirdextraction()
{
	var_00 = common_scripts\utility::getstruct(self.targetextractpoint.target,"targetname");
	var_01 = spawnhelicopter(level.players[0],var_00.origin,var_00.angles,"warbird_player_mp","vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak");
	var_01.warbirdturret = var_01 spawn_warbird_turret("warbird_remote_turret_mp","vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak","tag_player_mp",0);
	thread warbirdfire(var_01);
	var_01 vehicle_turnengineoff();
	var_01 playloopsound("veh_warbird_fly_over_civ_extract");
	var_02 = var_00;
	var_03 = 40;
	while(isdefined(var_02.target))
	{
		var_02 = common_scripts\utility::getstruct(var_02.target,"targetname");
		if(isdefined(var_02.script_count))
		{
			var_03 = var_02.script_count;
		}

		warbirdmovetoattackpoint(var_01,var_02,var_03);
	}

	level notify("extraction_sequence_complete");
	wait 0.05;
	var_01.warbirdturret delete();
	var_01.rope delete();
	var_01 delete();
	level.warbirdextraction = 0;
	var_01 notify("warbirdExtractionComplete");
}

//Function Number: 5
spawn_warbird_turret(param_00,param_01,param_02,param_03)
{
	var_04 = spawnturret("misc_turret",self gettagorigin(param_02),param_00,0);
	var_04.angles = self gettagangles(param_02);
	var_04 setmodel(param_01);
	var_04 setdefaultdroppitch(55);
	var_04 linkto(self,param_02,(0,0,0),(0,0,0));
	var_04.owner = self.owner;
	var_04.health = 99999;
	var_04.maxhealth = 1000;
	var_04.damagetaken = 0;
	var_04.stunned = 0;
	var_04.stunnedtime = 0;
	var_04 setcandamage(0);
	var_04 setcanradiusdamage(0);
	var_04.team = level.players[0].team;
	var_04.pers["team"] = level.players[0].team;
	var_04 setmode("auto_nonai");
	var_04 setsentryowner(self.owner);
	var_04 setturretminimapvisible(0);
	var_04.chopper = self;
	return var_04;
}

//Function Number: 6
warbirdfire(param_00)
{
	param_00 endon("warbirdExtractionComplete");
	param_00.picknewtarget = 1;
	for(;;)
	{
		wait(0.05);
		if(param_00.picknewtarget)
		{
			var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
			var_02 = [];
			foreach(var_04 in var_01)
			{
				if(var_04.team == level.playerteam)
				{
					continue;
				}

				foreach(var_06 in level.players)
				{
					if(distance(var_06.origin,var_04.origin) > 300)
					{
						var_02 = common_scripts\utility::array_add(var_02,var_04);
					}
				}
			}

			if(var_02.size < 0)
			{
				continue;
			}

			var_02 = sortbydistance(var_02,param_00.origin);
			var_09 = undefined;
			foreach(var_0B in var_02)
			{
				if(!isdefined(var_0B))
				{
					continue;
				}

				if(!isalive(var_0B))
				{
					continue;
				}

				var_09 = var_0B;
				param_00.enemy_target = var_09;
				checkwarbirdtargetlos(param_00);
				break;
			}
		}
	}
}

//Function Number: 7
fireatzombie(param_00)
{
	param_00 endon("warbirdExtractionComplete");
	param_00 endon("pickNewTarget");
	param_00.warbirdturret setmode("manual");
	param_00.warbirdturret settargetentity(param_00.enemy_target);
	var_01 = 0;
	var_02 = randomfloatrange(2,3);
	wait(randomfloatrange(3,5));
	while(var_01 < var_02)
	{
		if(!isdefined(param_00.enemy_target) || !isalive(param_00.enemy_target))
		{
			break;
		}

		param_00.warbirdturret shootturret();
		wait(randomfloatrange(0.15,0.25));
		var_01 = var_01 + 0.15;
	}

	param_00.enemy_target = undefined;
	param_00.picknewtarget = 1;
	param_00 notify("pickNewTarget");
}

//Function Number: 8
checkwarbirdtargetlos(param_00)
{
	param_00 endon("warbirdExtractionComplete");
	param_00 endon("pickNewTarget");
	param_00.enemy_target endon("death");
	param_00.enemy_target endon("disconnect");
	var_01 = param_00 gettagorigin("TAG_FLASH1");
	var_02 = param_00.enemy_target geteye();
	var_03 = vectornormalize(var_02 - var_01);
	var_04 = var_01 + var_03 * 20;
	var_05 = bullettrace(var_04,var_02,0,param_00,0,0,0,0,0);
	if(!checktargetisinvision(param_00) && var_05["fraction"] < 1 && !checktargetnearplayer(param_00))
	{
		wait(5);
		param_00.lineofsight = 0;
		param_00.picknewtarget = 1;
		param_00.enemy_target = undefined;
		param_00 notify("pickNewTarget");
		return;
	}

	param_00.lineofsight = 1;
	fireatzombie(param_00);
}

//Function Number: 9
checktargetnearplayer(param_00)
{
	foreach(var_02 in level.players)
	{
		if(distance(var_02.origin,param_00.enemy_target.origin) < 300)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 10
checktargetisinvision(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = param_00.enemy_target.origin - param_00.origin;
	var_03 = vectordot(var_01,var_02);
	return var_03 < 0;
}

//Function Number: 11
warbirdmovetoattackpoint(param_00,param_01,param_02)
{
	param_00 makevehiclenotcollidewithplayers(1);
	if(!isdefined(param_00.rope))
	{
		param_00.rope = spawn("script_model",(0,0,0));
		param_00.rope setmodel("vehicle_xh9_warbird_pulley");
		param_00.rope vehicle_jetbikesethoverforcescale(param_00,"tag_origin",(0,0,0),(0,0,0));
		param_00.rope hide();
	}

	param_00 vehicle_setspeed(param_02,param_02 / 4,param_02 / 4);
	param_00 setneargoalnotifydist(100);
	if(isdefined(param_01.target) && param_01.target == "ExtractionHoverPosition")
	{
		param_00 setneargoalnotifydist(10);
	}

	param_00 setvehgoalpos(param_01.origin,isdefined(param_01.script_parameters));
	param_00 waittill("near_goal");
	if(isdefined(param_01.script_parameters))
	{
		if(isscriptedagent(self) && isalive(self))
		{
			self notify("extraction_started");
			self.agentname = undefined;
			self.ignoreme = 1;
			self hudoutlinedisable();
			self.extractionsuccessful = 1;
			self scragentsetscripted(1);
			maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"SynchronizedAnim");
			self scragentsetphysicsmode("noclip");
			param_00.rope show();
			param_00.rope scriptmodelplayanim("zom_civ_extraction_air_rope","dummy");
			self scragentsynchronizeanims(1,0.2,param_00.rope,"tag_attach","tag_weapon_left");
			maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("zom_civ_extraction_air_civ",0,"synchronized");
			thread civilianplayidleoutroanim();
			maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"SynchronizedAnim");
		}

		wait(3);
		if(level.numberofalivecivilians > 0)
		{
			level notify("extraction_complete");
		}
	}

	param_00 makevehiclenotcollidewithplayers(0);
}

//Function Number: 12
civilianplayidleoutroanim()
{
	while(isscriptedagent(self) && isalive(self))
	{
		maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("zom_civ_extraction_air_civ_idle",0,"synchronized");
	}
}

//Function Number: 13
warbirdlookatenemy(param_00)
{
	for(;;)
	{
		if(isdefined(param_00.enemy_target))
		{
			monitorlookatent(param_00);
			param_00.warbirdturret cleartargetentity();
		}

		wait 0.05;
	}
}

//Function Number: 14
monitorlookatent(param_00)
{
	param_00 endon("pickNewTarget");
	param_00 setlookatent(param_00.enemy_target);
	param_00.warbirdturret settargetentity(param_00.enemy_target);
	param_00.enemy_target common_scripts\utility::waittill_either("death","disconnect");
	param_00.picknewtarget = 1;
	param_00.lineofsight = 0;
}

//Function Number: 15
executemultistageextractevent(param_00)
{
	if(!isdefined(param_00.groupname))
	{
		return;
	}

	switch(param_00.groupname)
	{
		case "repairDrone":
			repairdroneevent();
			break;
	}
}

//Function Number: 16
repairdroneevent()
{
	iprintlnbold("RELEASE DRONE");
	wait(5);
	foreach(var_01 in level.players)
	{
		var_02 = [];
		var_03 = var_01 maps\mp\zombies\killstreaks\_zombie_drone_assault::tryuseassaultdrone(-1,var_02);
		if(var_03 == 1)
		{
			return;
		}
	}
}
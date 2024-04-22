/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_warbird.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 331 ms
 * Timestamp: 4/22/2024 2:09:45 AM
*******************************************************************/

//Function Number: 1
hordecreatewarbird()
{
	foreach(var_01 in level.spawnedwarbirds)
	{
		var_01 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
		waittillframeend;
	}

	var_03 = -1;
	var_04 = ["sentry_guardian","assault_ugv_ai","assault_ugv_mg","warbird_ai_attack"];
	var_05 = maps\mp\killstreaks\_warbird::buildvalidflightpaths();
	horde_patch_flight_paths();
	var_06 = maps\mp\killstreaks\_warbird::findbestspawnlocation(var_05);
	var_06 = maps\mp\killstreaks\_warbird::rotatehelispawn(var_06);
	var_07 = spawnhelicopter(self,var_06.origin,var_06.angles,"warbird_horde",level.warbirdsetting["Warbird"].modelbase);
	var_07.currentnode = var_06;
	if(!isdefined(var_07))
	{
		return 0;
	}

	var_07 thread maps\mp\killstreaks\_warbird::warbird_audio();
	var_07 hide();
	var_07 thread maps\mp\killstreaks\_warbird::warbirdmakevehiclesolidcapsule();
	var_07.targetent = spawn("script_origin",(0,0,0));
	var_07.vehicletype = "Warbird";
	var_07.heli_type = level.warbirdsetting["Warbird"].helitype;
	var_07.helitype = level.warbirdsetting["Warbird"].helitype;
	var_07.attractor = missile_createattractorent(var_07,level.heli_attract_strength,level.heli_attract_range);
	var_07.lifeid = var_03;
	var_07.team = "axis";
	var_07.pers["team"] = "axis";
	var_07.maxhealth = level.warbirdhealth + maps\mp\gametypes\_horde_util::getnumplayers() - 1 * level.warbirdhealth / 2;
	var_07.zoffset = (0,0,0);
	var_07.targeting_delay = level.heli_targeting_delay;
	var_07.primarytarget = undefined;
	var_07.secondarytarget = undefined;
	var_07.attacker = undefined;
	var_07.currentstate = "ok";
	var_07.picknewtarget = 1;
	var_07.lineofsight = 0;
	var_07.overheattime = 6;
	var_07.firetime = 0;
	var_07.weaponfire = 0;
	var_07.ismoving = 1;
	var_07.cloakcooldown = 0;
	var_07.iscrashing = 0;
	var_07.ispossessed = 0;
	var_07.modules = var_04;
	var_07.aiattack = common_scripts\utility::array_contains(var_07.modules,"warbird_ai_attack");
	var_07.aifollow = common_scripts\utility::array_contains(var_07.modules,"warbird_ai_follow");
	var_07.hasai = var_07.aiattack || var_07.aifollow;
	var_07.cancloak = common_scripts\utility::array_contains(var_07.modules,"warbird_cloak");
	var_07.hasrockets = common_scripts\utility::array_contains(var_07.modules,"warbird_rockets");
	var_07.coopoffensive = common_scripts\utility::array_contains(var_07.modules,"warbird_coop_offensive");
	var_07.extraflare = common_scripts\utility::array_contains(var_07.modules,"warbird_flares");
	if(var_07.extraflare)
	{
		var_07.numextraflares = 1;
	}
	else
	{
		var_07.numextraflares = 0;
	}

	if(var_07.hasrockets)
	{
		var_07.rocketclip = 3;
	}
	else
	{
		var_07.rocketclip = 0;
	}

	var_07.remainingrocketshots = var_07.rocketclip;
	var_07 common_scripts\utility::make_entity_sentient_mp(var_07.team);
	if(!isdefined(level.spawnedwarbirds))
	{
		level.spawnedwarbirds = [];
	}

	level.spawnedwarbirds = common_scripts\utility::array_add(level.spawnedwarbirds,var_07);
	var_07 maps\mp\killstreaks\_aerial_utility::addtohelilist();
	var_07 thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(var_07.numextraflares);
	var_07 thread maps\mp\killstreaks\_aerial_utility::heli_monitoremp();
	var_07 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_07.maxhealth,"hitjuggernaut",::maps\mp\killstreaks\_warbird::warbirdondeath,::hordewarbirdmodifydamage,1);
	var_07 thread maps\mp\killstreaks\_warbird::warbird_health();
	var_07 thread maps\mp\killstreaks\_aerial_utility::heli_existance();
	var_07 thread hordewarbird_watchdeath();
	thread maps\mp\killstreaks\_warbird::monitoraiwarbirddeathortimeout(var_07);
	var_07.warbirdturret = var_07 maps\mp\killstreaks\_warbird::spawn_warbird_turret("warbird_remote_turret_mp","vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak","tag_player_mp",0);
	var_07.warbirdturret.ishordeenemywarbird = 1;
	var_07.warbirdturret hide();
	var_08 = "orbitalsupport_big_turret_mp";
	if(var_07.coopoffensive)
	{
		var_08 = "warbird_remote_turret_mp";
	}

	var_07.warbirdbuddyturret = var_07 maps\mp\killstreaks\_warbird::spawn_warbird_turret(var_08,"vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak","tag_playerbuddy_mp",1);
	var_07.warbirdbuddyturret hide();
	thread maps\mp\killstreaks\_warbird::setupcloaking(var_07);
	var_09 = 3;
	maps\mp\_utility::delaythread(var_09,::maps\mp\killstreaks\_warbird::cloakingtransition,var_07,0);
	var_07 common_scripts\utility::delaycall(var_09,::hudoutlineenable,level.enemyoutlinecolor,1);
	var_07.warbirdturret common_scripts\utility::delaycall(var_09,::hudoutlineenable,level.enemyoutlinecolor,1);
	var_07.ispossessed = 0;
	var_07.warbirdturret setmode("auto_nonai");
	var_07.getstingertargetposfunc = ::hordewarbird_stinger_target_pos;
	waittillframeend;
	var_07 thread hordewarbirdaiattack(var_07);
	var_07.killcamstarttime = gettime();
	var_07.warbirdturret.killcament = var_07;
	var_07.player = undefined;
	if(isdefined(var_07))
	{
		level.currentenemycount++;
		level.currentaliveenemycount++;
		level.warbirdinuse = 1;
		return 1;
	}

	return 0;
}

//Function Number: 2
hordewarbird_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	common_scripts\utility::waittill_any("crashing","death");
	if(isdefined(self))
	{
		self hudoutlinedisable();
	}

	if(isdefined(self.warbirdturret))
	{
		self.warbirdturret hudoutlinedisable();
	}

	var_00 = self.lasttododamage;
	thread hordewarbirddestroyed(var_00);
}

//Function Number: 3
hordewarbirddestroyed(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	level.currentaliveenemycount--;
	level.enemiesleft--;
	setomnvar("ui_horde_enemies_left",level.enemiesleft);
	if(level.objdefend)
	{
		maps\mp\gametypes\horde::checkdefendkill(self,param_00);
	}

	level notify("enemy_death",param_00,self);
	level.warbirdinuse = 0;
	if(isplayer(param_00))
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_00);
		param_00 thread maps\mp\gametypes\_rank::xppointspopup("kill",1000);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00,100);
	}

	if(isdefined(param_00) && isdefined(param_00.owner) && isplayer(param_00.owner) && isdefined(param_00.owner.killz))
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_00.owner);
		param_00.owner thread maps\mp\gametypes\_rank::xppointspopup("kill",1000);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00.owner,100);
	}
}

//Function Number: 4
hordewarbirdaiattack(param_00)
{
	thread hordewarbirdfire(param_00);
	thread hordewarbirdlookatenemy(param_00);
	thread hordewarbirdmovetoattackpoint(param_00);
}

//Function Number: 5
hordewarbirdmovetoattackpoint(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	if(!isdefined(level.warbirdhordebasespeed))
	{
		level.warbirdhordebasespeed = 40;
	}

	if(!isdefined(level.warbirdhordeneargoal))
	{
		level.warbirdhordeneargoal = 100;
	}

	var_01 = level.warbirdhordebasespeed;
	param_00 vehicle_setspeed(var_01,var_01 / 4,var_01 / 4);
	param_00 setneargoalnotifydist(level.warbirdhordeneargoal);
	var_02 = param_00.currentnode;
	if(!isdefined(var_02))
	{
		var_03 = common_scripts\utility::get_array_of_closest(param_00.origin,maps\mp\killstreaks\_warbird::buildvalidflightpaths());
		var_04 = param_00.origin;
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_06 = var_03[var_05].origin;
			if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_04,var_06,param_00))
			{
				var_07 = var_06 - var_04;
				var_08 = distance(var_04,var_06);
				var_09 = rotatevector(var_07,(0,90,0));
				var_0A = var_04 + var_09 * 100;
				var_0B = var_0A + var_07 * var_08;
				if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_0A,var_0B,param_00))
				{
					var_0C = rotatevector(var_07,(0,-90,0));
					var_0A = var_04 + var_0C * 100;
					var_0B = var_0A + var_07 * var_08;
					if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_0A,var_0B,param_00))
					{
						var_02 = var_03[var_05];
						break;
					}
				}
			}

			wait 0.05;
		}
	}
	else
	{
		var_02 = var_02.next;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	if(isdefined(var_02.horde_patch_slow_from_prev) || isdefined(var_02.horde_patch_slow_from_next))
	{
		param_00.horde_approach_next_node_slow = 1;
	}
	else
	{
		param_00.horde_approach_next_node_slow = 0;
	}

	for(;;)
	{
		var_0D = param_00.horde_approach_next_node_slow;
		param_00 setvehgoalpos(var_02.origin,var_0D);
		param_00.ismoving = 1;
		param_00 waittill("near_goal");
		param_00.currentnode = var_02;
		param_00.ismoving = 0;
		var_02 = hordewarbirdwaituntilmovereturnnode(param_00);
		param_00.currentnode = undefined;
	}
}

//Function Number: 6
hordewarbirdwaituntilmovereturnnode(param_00)
{
	var_01 = param_00.currentnode;
	var_02 = var_01.prev;
	var_03 = var_01.next;
	var_04 = maps\mp\_utility::getlivingplayers("allies");
	var_04 = sortbydistance(var_04,param_00.origin);
	if(var_04.size == 0)
	{
		return param_00.currentnode.next;
	}

	var_05 = var_04[0];
	var_06 = var_03;
	if(distancesquared(var_05.origin,var_02.origin) < distancesquared(var_05.origin,var_03.origin))
	{
		var_06 = var_02;
	}
	else
	{
		var_06 = var_03;
	}

	if(randomfloat(1) < 0.2)
	{
		if(var_06 == var_02)
		{
			var_06 = var_03;
		}
		else
		{
			var_06 = var_02;
		}
	}

	if((isdefined(var_06.horde_patch_slow_from_prev) && var_06 == var_03) || isdefined(var_06.horde_patch_slow_from_next) && var_06 == var_02)
	{
		param_00.horde_approach_next_node_slow = 1;
	}
	else
	{
		param_00.horde_approach_next_node_slow = 0;
	}

	return var_06;
}

//Function Number: 7
hordewarbirdlookatenemy(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		if(isdefined(param_00.enemy_target))
		{
			hordemonitorlookatent(param_00);
			param_00.warbirdturret cleartargetentity();
		}

		wait 0.05;
	}
}

//Function Number: 8
hordemonitorlookatent(param_00)
{
	param_00 endon("death");
	param_00 endon("pickNewTarget");
	param_00 setlookatent(param_00.enemy_target);
	if(isdefined(param_00.enemy_target.isaerialassaultdrone) && param_00.enemy_target.isaerialassaultdrone)
	{
		param_00.warbirdturret settargetentity(param_00.enemy_target,(0,0,50));
	}
	else
	{
		param_00.warbirdturret settargetentity(param_00.enemy_target);
	}

	param_00.enemy_target common_scripts\utility::waittill_any_timeout(randomfloatrange(3,5),"death","disconnect");
	param_00.picknewtarget = 1;
	param_00.lineofsight = 0;
}

//Function Number: 9
hordewarbirdfire(param_00)
{
	param_00 endon("crashing");
	param_00 endon("death");
	thread hordewarbirdfireai(param_00);
	for(;;)
	{
		if(param_00.picknewtarget)
		{
			var_01 = level.participants;
			var_01 = common_scripts\utility::array_combine(var_01,level.ugvs);
			var_01 = common_scripts\utility::array_combine(var_01,level.turrets);
			var_02 = [];
			foreach(var_04 in var_01)
			{
				if(var_04.team != self.team)
				{
					var_02 = common_scripts\utility::array_add(var_02,var_04);
				}
			}

			if(param_00.aiattack)
			{
				var_02 = sortbydistance(var_02,param_00.origin);
			}
			else
			{
				var_02 = sortbydistance(var_02,self.origin);
			}

			var_06 = undefined;
			foreach(var_04 in var_02)
			{
				if(!isdefined(var_04))
				{
					continue;
				}

				if(!isalive(var_04) || isdefined(var_04.isspectator) && var_04.isspectator || isdefined(var_04.inlaststand) && var_04.inlaststand)
				{
					continue;
				}

				if(var_04 maps\mp\_utility::_hasperk("specialty_blindeye"))
				{
					continue;
				}

				if(isdefined(var_04.spawntime) && gettime() - var_04.spawntime / 1000 < 5)
				{
					continue;
				}

				var_06 = var_04;
				param_00.enemy_target = var_06;
				checkhordewarbirdtargetlos(param_00);
				break;
			}
		}

		param_00 notify("LostLOS");
		wait(0.05);
	}
}

//Function Number: 10
hordewarbirdfireai(param_00)
{
	param_00 endon("crashing");
	param_00 endon("death");
	param_00.remainingrocketshots = param_00.rocketclip;
	var_01 = hordewarbirdburstendtime();
	var_02 = 0.2;
	param_00.firing_rocket = 0;
	if(level.hordelevelflip > 1)
	{
		param_00.hasrockets = 1;
	}

	for(;;)
	{
		if(gettime() > var_01)
		{
			hordewarbirdburstdelay();
			var_01 = hordewarbirdburstendtime();
		}
		else
		{
			wait(var_02);
		}

		if(!isdefined(param_00.enemy_target) || !isalive(param_00.enemy_target) || isdefined(param_00.enemy_target.isspectator) && param_00.enemy_target.isspectator || isdefined(param_00.enemy_target.inlaststand) && param_00.enemy_target.inlaststand || !param_00.lineofsight)
		{
			continue;
		}

		if(param_00.hasrockets)
		{
			if(!param_00.firing_rocket)
			{
				thread hordewarbirdfireairocket(param_00);
			}
		}

		param_00.warbirdturret shootturret();
	}
}

//Function Number: 11
hordewarbirdfireairocket(param_00)
{
	var_01 = param_00 gettagorigin("tag_missile_right");
	var_02 = vectornormalize(anglestoforward(param_00.angles));
	var_03 = param_00 vehicle_getvelocity();
	var_04 = magicbullet("warbird_missile_mp",var_01 + var_03 / 10,self geteye() + var_03 + var_02 * 1000);
	var_04.killcament = param_00;
	playfxontag(level.chopper_fx["rocketlaunch"]["warbird"],param_00,"tag_missile_right");
	var_04 missile_settargetent(param_00.enemy_target);
	var_04 missile_setflightmodedirect();
	param_00.remainingrocketshots--;
	if(param_00.remainingrocketshots <= 0)
	{
		thread hordewarbirdairocketreload(param_00);
	}

	param_00.firing_rocket = 1;
	waittillhordewarbirdrocketdeath(param_00,var_04);
	param_00.firing_rocket = 0;
}

//Function Number: 12
hordewarbirdairocketreload(param_00)
{
	param_00 endon("warbirdStreakComplete");
	wait(6);
	param_00.remainingrocketshots = param_00.rocketclip;
}

//Function Number: 13
waittillhordewarbirdrocketdeath(param_00,param_01)
{
	param_00.enemy_target endon("death");
	param_00.enemy_target endon("disconnect");
	param_01 waittill("death");
}

//Function Number: 14
checkhordewarbirdtargetlos(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	param_00.enemy_target endon("death");
	param_00.enemy_target endon("disconnect");
	for(;;)
	{
		var_01 = param_00 gettagorigin("TAG_FLASH1");
		var_02 = (0,0,0);
		if(isdefined(param_00.enemy_target.issentry) && param_00.enemy_target.issentry)
		{
			var_02 = param_00.enemy_target.origin + (0,0,40);
		}
		else
		{
			var_02 = param_00.enemy_target geteye();
		}

		var_03 = vectornormalize(var_02 - var_01);
		var_04 = var_01 + var_03 * 20;
		var_05 = bullettrace(var_04,var_02,0,param_00,0,0,0,0,0);
		if((isdefined(param_00.enemy_target.isspectator) && param_00.enemy_target.isspectator) || isdefined(param_00.enemy_target.inlaststand) && param_00.enemy_target.inlaststand || var_05["fraction"] < 0.99)
		{
			param_00.enemy_target = undefined;
			param_00 clearlookatent();
			param_00.warbirdturret cleartargetentity();
			param_00.lineofsight = 0;
			param_00.picknewtarget = 1;
			param_00 notify("pickNewTarget");
			return;
		}

		param_00.lineofsight = 1;
		wait(0.25);
	}
}

//Function Number: 15
hordewarbirdchecktargetisinvision(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = param_00.enemy_target.origin - param_00.origin;
	var_03 = vectordot(var_01,var_02);
	return var_03 > 0;
}

//Function Number: 16
hordewarbirdburstendtime()
{
	var_00 = 1000;
	var_01 = 2000;
	return gettime() + randomintrange(var_00,var_01);
}

//Function Number: 17
hordewarbirdburstdelay()
{
	var_00 = 2;
	var_01 = 4;
	wait(randomfloatrange(var_00,var_01));
}

//Function Number: 18
hordewarbirdmodifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	self.damagefeedback = "hitjuggernaut";
	if(isdefined(self.damageloc) && issubstr(self.damageloc,"rotor") || issubstr(self.damageloc,"wing"))
	{
		var_04 = 1.25;
		self.damagefeedback = "headshot";
	}

	var_05 = maps\mp\gametypes\_damage::modifydamage(param_00,param_01,param_02,param_03 * var_04);
	if(issubstr(param_01,"turret") && !isplayer(param_00))
	{
		var_05 = var_05 * 0.1;
	}

	if(issubstr(param_01,"remotemissile_projectile_cluster"))
	{
		var_05 = 1000;
	}
	else if(issubstr(param_01,"remotemissile_"))
	{
		var_05 = 1400;
	}
	else if(issubstr(param_01,"playermech_rocket_mp"))
	{
		var_05 = 500;
	}

	if(weaponclass(param_01) == "rocketlauncher")
	{
		var_06 = 500;
		if(getweaponbasename(param_01) == "iw5_maaws_mp")
		{
			var_05 = var_05;
		}

		if(getweaponbasename(param_01) == "iw5_mahem_mp")
		{
			var_05 = var_05 * 2.5;
		}

		if(getweaponbasename(param_01) == "iw5_stingerm7_mp")
		{
			var_05 = 500;
		}
	}

	if(var_05 > 0)
	{
		self.lasttododamage = param_00;
		maps\mp\killstreaks\_aerial_utility::heli_staticdamage(param_01,param_02,var_05);
		if(isdefined(param_00))
		{
			if(isplayer(param_00))
			{
				param_00 maps\mp\gametypes\horde::givepointsfordamage(self,var_05,"none",param_01,undefined,undefined,"none",0);
			}
			else if(isdefined(param_00.owner) && isplayer(param_00.owner))
			{
				param_00.owner maps\mp\gametypes\horde::givepointsfordamage(self,var_05,"none",param_01,undefined,undefined,"none",0);
			}
		}
	}

	return var_05;
}

//Function Number: 19
hordewarbird_stinger_target_pos()
{
	return self gettagorigin("tag_origin") + (0,0,64);
}

//Function Number: 20
horde_patch_flight_paths()
{
	if(isdefined(level.horde_flight_paths_patched))
	{
		return;
	}

	if(isdefined(level.warbirdflightpathnodes))
	{
		foreach(var_02 in level.horde_warbird_path_patch_array)
		{
			var_03 = level.warbirdflightpathnodes[var_02.index];
			if(isdefined(var_02.slow_from_next))
			{
				var_03.horde_patch_slow_from_next = var_02.slow_from_next;
			}

			if(isdefined(var_02.slow_from_prev))
			{
				var_03.horde_patch_slow_from_prev = var_02.slow_from_prev;
			}
		}

		level.horde_flight_paths_patched = 1;
	}
}

//Function Number: 21
horde_setup_warbird_pathnode_patch()
{
	var_00 = [];
	switch(level.script)
	{
		case "mp_comeback":
			var_00[0] = horde_create_patch_node(3,1,0);
			var_00[1] = horde_create_patch_node(2,1,0);
			var_00[2] = horde_create_patch_node(4,0,1);
			break;

		case "mp_lab2":
			var_00[0] = horde_create_patch_node(1,1,1);
			var_00[1] = horde_create_patch_node(0,1,0);
			var_00[2] = horde_create_patch_node(5,1,0);
			maps\mp\killstreaks\_aerial_utility::patchheliloopnode((-468,-2000,1536),(-318,-2058,1536));
			maps\mp\killstreaks\_aerial_utility::patchheliloopnode((720,3144,1508),(870,3086,1508));
			break;

		case "mp_laser2":
			maps\mp\killstreaks\_aerial_utility::patchheliloopnode((-1992,1648,2164),(-1329,768,2164));
			var_00[0] = horde_create_patch_node(1,1,0);
			var_00[1] = horde_create_patch_node(3,0,1);
			break;

		case "mp_levity":
			var_00[0] = horde_create_patch_node(5,1,1);
			break;

		case "mp_refraction":
			var_00[0] = horde_create_patch_node(4,1,0);
			var_00[1] = horde_create_patch_node(5,0,1);
			break;

		case "mp_terrace":
			var_00[0] = horde_create_patch_node(3,1,0);
			var_00[1] = horde_create_patch_node(4,0,1);
			break;

		case "mp_venus":
			var_00[0] = horde_create_patch_node(5,1,0);
			var_00[1] = horde_create_patch_node(6,0,1);
			break;

		case "mp_urban":
			var_00[0] = horde_create_patch_node(0,0,1);
			var_00[1] = horde_create_patch_node(5,1,0);
			level.warbirdhordebasespeed = 33;
			break;
	}

	level.horde_warbird_path_patch_array = var_00;
}

//Function Number: 22
horde_create_patch_node(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.index = param_00;
	if(isdefined(param_01) && param_01)
	{
		var_03.slow_from_prev = 1;
	}

	if(isdefined(param_02) && param_02)
	{
		var_03.slow_from_next = 1;
	}

	return var_03;
}
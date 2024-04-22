/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 803 ms
 * Timestamp: 4/22/2024 2:14:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	while(!isdefined(level.struct_class_names))
	{
		wait(0.05);
	}

	level.gibshotgunrange = 128;
	level.gibexplosivedamagetypes = ["weapon_grenade","weapon_projectile","killstreak"];
	level.agent_funcs["zombie"] = level.agent_funcs["player"];
	level.agent_funcs["zombie"]["onAIConnect"] = ::maps\mp\zombies\_util::onaiconnect;
	level.agent_funcs["zombie"]["on_killed"] = ::onzombiekilled;
	level.agent_funcs["zombie"]["on_damaged"] = ::onzombiedamaged;
	level.agent_funcs["zombie"]["on_damaged_finished"] = ::onzombiedamagefinished;
	level.agent_funcs["zombie"]["spawn"] = ::maps\mp\zombies\_util::onspawnscriptagenthumanoid;
	level.agent_funcs["zombie"]["think"] = ::maps\mp\zombies\_util::agentemptythink;
	createthreatbiasgroup("zombies");
	maps\mp\zombies\zombie_generic::init();
	if(isdefined(level.zombiedoginit))
	{
		[[ level.zombiedoginit ]]();
	}

	if(isdefined(level.zombiehostinit))
	{
		[[ level.zombiehostinit ]]();
	}

	if(isdefined(level.zombielevelinit))
	{
		[[ level.zombielevelinit ]]();
	}

	if(!isdefined(level.zombies_spawners_zombie))
	{
		level.zombies_spawners_zombie = [];
	}

	level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie,common_scripts\utility::getstructarray("zombie_spawner","targetname"));
	level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie,common_scripts\utility::getstructarray("Spawner_A","targetname"));
	level thread markpathnodezombiezones();
	level thread monitorplayerzone();
	level thread monitorplayerinexploitvolume();
}

//Function Number: 2
markpathnodezombiezones()
{
	var_00 = getallnodes();
	var_01 = 0;
	while(var_00.size > 0)
	{
		var_02 = var_00[var_00.size - 1];
		if(isdefined(level.zone_data))
		{
			var_03 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_02.origin);
			if(!isdefined(var_03) && maps\mp\zombies\_util::getzombieslevelnum() >= 3)
			{
				var_03 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_02.origin + (1,0,0));
				if(!isdefined(var_03))
				{
					var_03 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_02.origin + (0,1,0));
				}
			}

			if(isdefined(var_03))
			{
				var_02.zombieszone = var_03;
			}
		}

		var_00[var_00.size - 1] = undefined;
		var_01++;
		if(var_01 % 20 == 0)
		{
			wait(0.05);
		}
	}

	level.closetpathnodescalculated = 1;
}

//Function Number: 3
monitorplayerzone()
{
	level endon("game_ended");
	if(!isdefined(level.zone_data))
	{
		return;
	}

	var_00 = 0.05;
	var_01 = 0;
	for(;;)
	{
		var_02 = 0;
		foreach(var_04 in level.players)
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(var_04.sessionstate != "spectator" && var_04.sessionstate != "intermission")
			{
				var_05 = var_04 maps\mp\zombies\_zombies_zone_manager::getplayerzone();
				if(isdefined(var_05))
				{
					var_04.currentzone = var_05;
				}
				else
				{
					var_04.currentzone = undefined;
				}

				wait(var_00);
				var_02 = var_02 + var_00;
			}
		}

		if(var_02 == 0)
		{
			wait(var_00);
		}
	}
}

//Function Number: 4
monitorplayerinexploitvolume()
{
	level endon("game_ended");
	if(!isdefined(level.zone_data))
	{
		return;
	}

	var_00 = 0.5;
	var_01 = getentarray("zombie_ledge_exploit","targetname");
	var_02 = [];
	foreach(var_08, var_04 in level.zone_data.zones)
	{
		var_02[var_08] = [];
		foreach(var_06 in var_01)
		{
			if(var_06.script_noteworthy == var_08)
			{
				var_02[var_08][var_02[var_08].size] = var_06;
			}
		}
	}

	for(;;)
	{
		var_09 = 0;
		foreach(var_0B in level.players)
		{
			if(!isalive(var_0B))
			{
				continue;
			}

			var_0B.isinexploitspot = 0;
			var_0B.validnotmoving = 0;
			if(var_0B.sessionstate != "spectator" && var_0B.sessionstate != "intermission")
			{
				if(isdefined(var_0B.currentzone) && length(var_0B getvelocity()) < 5)
				{
					var_0B.validnotmoving = 1;
					foreach(var_06 in var_02[var_0B.currentzone])
					{
						if(var_0B istouching(var_06))
						{
							var_0B.isinexploitspot = 1;
							break;
						}
					}
				}
			}

			if(isdefined(level.zmpatchshovefunc))
			{
				var_0B [[ level.zmpatchshovefunc ]](var_0B.isinexploitspot,var_0B.validnotmoving);
			}

			wait(var_00);
			var_09 = var_09 + var_00;
		}

		if(var_09 == 0)
		{
			wait(var_00);
		}
	}
}

//Function Number: 5
spawnzombie(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_util::agentclassget(param_00);
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}
	else
	{
		var_04 = getspawnpoint(param_01,isdefined(var_04.spawnparameter));
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_03))
	{
		return;
	}

	if(isdefined(var_03.isbotagent) && var_03.isbotagent)
	{
		var_05 = maps\mp\zombies\_util::spawnbotagent(var_04,var_03,level.enemyteam);
	}
	else
	{
		var_05 = maps\mp\zombies\_util::spawnscriptagent(var_05,var_04,level.enemyteam);
	}

	if(!isdefined(var_05))
	{
		return;
	}

	if(!isdefined(var_03.roundhealth))
	{
		var_03.roundhealth = maps\mp\gametypes\zombies::calculatezombiehealth(var_03);
	}

	var_05.meleedamage = var_03.meleedamage;
	var_05.maxhealth = var_03.roundhealth;
	var_05.health = var_05.maxhealth;
	var_05.missingbodyparts = 0;
	var_05.dismember_crawl = 0;
	var_05.spawner = var_04;
	var_05 updatemeleechargeforcurrenthealth();
	if(isscriptedagent(var_05))
	{
		if(isdefined(param_02))
		{
			var_05 thread maps\mp\zombies\_util::zombie_set_eyes(param_02);
		}
		else
		{
			var_05 thread setdefaulteyes();
		}
	}

	var_05 setthreatbiasgroup("zombies");
	var_05 thread domoveloopeffects();
	if(isscriptedagent(var_05))
	{
		var_05 scragentsetzombietype(param_00);
	}

	if(isdefined(level.onzombiespawnfuncs))
	{
		foreach(var_07 in level.onzombiespawnfuncs)
		{
			var_05 thread [[ var_07 ]]();
		}
	}

	return var_05;
}

//Function Number: 6
updatemeleechargeforcurrenthealth()
{
	if(maps\mp\zombies\_util::isinstakill())
	{
		self setmeleechargevalid(1);
		self setexomeleechargevalid(1);
		return;
	}

	if(self.health <= level.playermeleedamage)
	{
		self setmeleechargevalid(1);
	}
	else
	{
		self setmeleechargevalid(0);
	}

	if(self.health <= level.playerexomeleedamage)
	{
		self setexomeleechargevalid(1);
		return;
	}

	self setexomeleechargevalid(0);
}

//Function Number: 7
setdefaulteyes()
{
	self endon("death");
	wait(0.25);
	if(!isdefined(self.eyefxactive) || !self.eyefxactive)
	{
		if(self.species == "dog")
		{
			maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_base");
			return;
		}

		if(self.agent_type == "zombie_host")
		{
			maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_host");
			return;
		}

		var_00 = maps\mp\gametypes\zombies::geteyeeffectforzombie("vanilla",self.headmodel);
		maps\mp\zombies\_util::zombie_set_eyes(var_00);
		return;
	}
}

//Function Number: 8
getspawnpoint(param_00,param_01)
{
	var_02 = maps\mp\zombies\_zombies_zone_manager::getspawnpoint(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	var_02 = getproximityspawnpoint();
	if(isdefined(var_02))
	{
		return var_02;
	}

	return getrandomspawnpoint();
}

//Function Number: 9
getproximityspawnpoint()
{
	var_00 = common_scripts\utility::array_randomize(level.players);
	var_01 = 1048576;
	var_02 = 262144;
	var_03 = [];
	foreach(var_05 in var_00)
	{
		if(!isalive(var_05))
		{
			continue;
		}

		foreach(var_07 in level.zombies_spawners_zombie)
		{
			var_08 = distancesquared(var_07.origin,var_05.origin);
			if(var_08 < var_01 && var_08 > var_02)
			{
				var_03[var_03.size] = var_07;
			}
		}

		if(var_03.size > 0)
		{
			break;
		}
	}

	if(var_03.size > 0)
	{
		return common_scripts\utility::random(var_03);
	}
}

//Function Number: 10
getrandomspawnpoint()
{
	var_00 = [];
	foreach(var_02 in level.zombies_spawners_zombie)
	{
		if(level.zone_data.zones[var_02.zone_name].is_enabled)
		{
			var_00[var_00.size] = var_02;
		}
	}

	return common_scripts\utility::random(var_00);
}

//Function Number: 11
deathgibmonitor()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isplayer(var_00))
	{
		return;
	}

	var_03 = var_00 getcurrentweapon();
	var_04 = maps\mp\_utility::getweaponclass(var_03);
	var_05 = distance(var_00.origin,self.origin);
	if(var_05 < level.gibshotgunrange && var_04 == "weapon_shotgun")
	{
		deathgibs(var_00);
		return;
	}

	if(common_scripts\utility::array_contains(level.gibexplosivedamagetypes,var_04))
	{
		deathragdoll();
	}
}

//Function Number: 12
deathgibs(param_00)
{
	var_01 = self.origin + (0,0,32);
	playfx(common_scripts\utility::getfx("mutant_gib_death"),var_01);
	earthquake(0.45,0.35,var_01,350);
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 setblurforplayer(3.25,0.1);
	wait(0.1);
	param_00 setblurforplayer(0,0.1);
}

//Function Number: 13
deathragdoll()
{
	var_00 = self.origin + (0,0,8);
	self.body startragdoll();
	wait(0.1);
	physicsexplosionsphere(var_00,128,0,5,0);
}

//Function Number: 14
deathbloodpool()
{
	self waittill("death");
	if(common_scripts\utility::cointoss())
	{
		playfx(common_scripts\utility::getfx("mutant_blood_pool"),self.origin);
	}
}

//Function Number: 15
zombieaimonitorthreads()
{
	thread monitorbadzombieai();
	thread monitorinitialtraversal();
	thread monitorstuckintraversal();
	thread zombie_speed_monitor();
}

//Function Number: 16
monitorbadzombieai()
{
	self endon("death");
	level endon("game_ended");
	var_00 = gettime();
	var_01 = self.origin;
	var_02 = var_00;
	var_03 = 0;
	var_04 = 5;
	for(;;)
	{
		wait(var_04);
		var_05 = distancesquared(self.origin,var_01);
		var_06 = gettime() - var_02 / 1000;
		var_07 = var_05 > 16384;
		var_08 = isscriptedagent(self) && self.aistate == "melee" && isdefined(self.curmeleetarget) && distancesquared(self.curmeleetarget.origin,self.origin) < 6400;
		if(var_07 || var_08)
		{
			var_01 = self.origin;
			var_02 = gettime();
		}
		else if(var_06 > 35)
		{
			if(var_06 > 55)
			{
				var_03 = 1;
				break;
			}
		}

		if(maps\mp\zombies\_util::checkexpiretime(var_00,180,240))
		{
			break;
		}
	}

	if(!var_03 && maps\mp\zombies\_util::is_true(level.recyclefullhealthzombies) && self.health >= self.maxhealth)
	{
		var_03 = 1;
	}

	if(var_03 && shouldrecycle() && !maps\mp\zombies\_util::is_true(self.ignorezombierecycling))
	{
		thread recyclezombie(self.agent_type);
	}

	maps\mp\agents\_agent_utility::killagent(self);
}

//Function Number: 17
shouldrecycle()
{
	if(!isdefined(level.allowzombierecycle))
	{
		return 0;
	}

	return maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() > 1;
}

//Function Number: 18
recyclezombie(param_00)
{
	if(!isdefined(level.recyclezombierequestspending))
	{
		level.recyclezombierequestspending = 0;
	}

	level.recyclezombierequestspending++;
	while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount || isdefined(level.recyclingzombie))
	{
		wait 0.05;
	}

	level.recyclingzombie = 1;
	maps\mp\zombies\zombies_spawn_manager::spawnzombietype(param_00);
	wait(0.2);
	level.recyclingzombie = undefined;
	level.recyclezombierequestspending--;
	if(level.recyclezombierequestspending < 0)
	{
		level.recyclezombierequestspending = 0;
	}
}

//Function Number: 19
monitorinitialtraversal()
{
	self endon("death");
	level endon("game_ended");
}

//Function Number: 20
monitorstuckintraversal()
{
	self endon("death");
	level endon("game_ended");
	self.velocity_zero_time = 0;
	for(;;)
	{
		if(length(self getvelocity()) == 0 && self.aistate == "move")
		{
			self.velocity_zero_time = self.velocity_zero_time + 0.05;
		}
		else
		{
			self.velocity_zero_time = 0;
		}

		if(self.velocity_zero_time > 2)
		{
			var_00 = undefined;
			var_01 = self getnegotiationstartnode();
			if(isdefined(var_01))
			{
				var_02 = distancesquared(self.origin,var_01.origin);
				if(var_02 < squared(15))
				{
					var_00 = var_01.origin;
				}
			}

			if(!isdefined(var_00) && maps\mp\zombies\_util::getzombieslevelnum() >= 3)
			{
				var_03 = self getpathgoalpos();
				if(isdefined(var_03) && distancesquared(self.origin,var_03) > 120)
				{
					var_04 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
					var_05 = [];
					foreach(var_07 in var_04)
					{
						if(var_07 != self && distancesquared(var_07.origin,self.origin) < squared(self.radius * 3))
						{
							var_05[var_05.size] = var_07;
						}
					}

					var_09 = 0;
					foreach(var_07 in var_05)
					{
						if(isdefined(var_07.velocity_zero_time) && var_07.velocity_zero_time > 2)
						{
							var_09++;
						}
					}

					if(var_09 >= 2)
					{
						var_0C = self scragentgetnodesonpath();
						if(var_0C.size > 0)
						{
							var_00 = var_0C[0].origin;
						}
					}
				}
			}

			if(isdefined(var_00))
			{
				self setorigin(var_00,0);
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\zombies\_util::isonhumanteam(self))
	{
		giveburgleachievement(param_01);
		giveexomeleeachievement(param_01,param_03);
		giveteleportgrenadeachievement(param_01,param_04);
		givegoliathmeleeachievement(param_01,param_03,param_04);
		givetrickshotachievement(param_01,param_03,param_04);
		maps\mp\zombies\_util::enemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(isdefined(level.onzombiekilledfunc))
		{
			[[ level.onzombiekilledfunc ]](param_01,param_04);
		}
	}

	thread maps\mp\zombies\_mutators::onkilledmutators(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	self hudoutlinedisable();
	maps\mp\zombies\_util::onscriptagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	spawnzombiekilledfx(self.activemutators,param_03,param_04);
}

//Function Number: 22
giveburgleachievement(param_00)
{
	if(!isdefined(self.distractiondrone) || !isdefined(param_00) || !isplayer(param_00))
	{
		return;
	}

	if(isdefined(self.distractiondrone.owner) && self.distractiondrone.owner == param_00)
	{
		return;
	}

	if(!isdefined(param_00.stolenkills))
	{
		param_00.stolenkills = 0;
	}

	param_00.stolenkills++;
	if(param_00.stolenkills >= 10)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_BURGLE");
	}
}

//Function Number: 23
giveboostslamachievement(param_00,param_01)
{
	if(param_01 != "boost_slam_mp" || !isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.zombieslamhits) || !isdefined(param_00.lastzombieslamtime))
	{
		param_00.zombieslamhits = 0;
		param_00.lastzombieslamtime = 0;
	}

	if(gettime() - param_00.lastzombieslamtime > 300)
	{
		param_00.zombieslamhits = 0;
	}

	param_00.zombieslamhits++;
	param_00.lastzombieslamtime = gettime();
	if(param_00.zombieslamhits >= 10)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_COMEONANDSLAM");
	}
}

//Function Number: 24
giveexomeleeachievement(param_00,param_01)
{
	if(!isdefined(param_00) || param_01 != "MOD_MELEE")
	{
		return;
	}

	if(!param_00 maps\mp\zombies\_terminals::hasexosuit())
	{
		return;
	}

	if(!isdefined(param_00.zombieexomeleekills))
	{
		param_00.zombieexomeleekills = [];
	}

	param_00.zombieexomeleekills[param_00.zombieexomeleekills.size] = gettime();
	var_02 = [];
	foreach(var_04 in param_00.zombieexomeleekills)
	{
		var_05 = gettime() - var_04;
		if(gettime() - var_04 > 30000)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	param_00.zombieexomeleekills = var_02;
	if(param_00.zombieexomeleekills.size == 10)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_DOYOUEVENEXO");
	}
}

//Function Number: 25
giveteleportgrenadeachievement(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01) || param_01 != "teleport_zombies_mp")
	{
		return;
	}

	if(!isdefined(param_00.teleportgrenadekills))
	{
		param_00.teleportgrenadekills = 0;
	}

	param_00.teleportgrenadekills++;
	if(param_00.teleportgrenadekills == 50)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_TELEFRAG");
	}
}

//Function Number: 26
givegoliathmeleeachievement(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_02) || param_02 != "iw5_exominigunzm_mp")
	{
		return;
	}

	if(!isdefined(param_01) || param_01 != "MOD_MELEE_ALT")
	{
		return;
	}

	if(!isdefined(param_00.goliathmeleekills))
	{
		param_00.goliathmeleekills = 0;
	}

	param_00.goliathmeleekills++;
	if(param_00.goliathmeleekills == 20)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_REALSTEEL");
	}
}

//Function Number: 27
givetrickshotachievement(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isplayer(param_00) || !isdefined(param_02))
	{
		return;
	}

	var_03 = getweaponbasename(param_02);
	if(var_03 != "iw5_tridentzm_mp")
	{
		return;
	}

	if(isdefined(param_01) && param_01 == "MOD_MELEE")
	{
		return;
	}

	var_04 = self.origin;
	var_05 = param_00.origin;
	var_06 = vectornormalize(var_04 - var_05);
	var_07 = anglestoforward(param_00 getplayerangles());
	if(vectordot(var_06,var_07) >= 0)
	{
		return;
	}

	if(!isdefined(param_00.trickshotkills))
	{
		param_00.trickshotkills = 0;
	}

	param_00.trickshotkills++;
	if(param_00.trickshotkills == 100)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_TRICKSHOT");
	}
}

//Function Number: 28
spawnzombiekilledfx(param_00,param_01,param_02)
{
	if(!isdefined(self.body))
	{
		return;
	}

	if(isdefined(level.spawnzombiekilledfxfunc))
	{
		var_03 = self [[ level.spawnzombiekilledfxfunc ]](param_01,param_02);
		if(var_03)
		{
			return;
		}
	}

	var_04 = self.recentlylostlimbs;
	if(!isdefined(var_04))
	{
		return;
	}

	if(maps\mp\zombies\_util::countlimbs(var_04) >= 3)
	{
		thread spawncorpsefullbodygib(param_00);
		return;
	}

	while(var_04 > 0)
	{
		var_05 = var_04 & 0 - var_04;
		thread spawncorpsebleedingfx(var_05,param_00);
		var_04 = var_04 - var_05;
	}
}

//Function Number: 29
spawncorpsebleedingfx(param_00,param_01)
{
	var_02 = level.dismemberment[param_00]["torsoFX"];
	if(isdefined(param_01))
	{
		if(isdefined(param_01["emz"]))
		{
			var_02 = var_02 + "_emz";
		}
		else if(isdefined(param_01["exploder"]))
		{
			var_02 = var_02 + "_exp";
		}
		else if(isdefined(param_01["fast"]))
		{
			var_02 = var_02 + "_ovr";
		}
	}

	playfxontag(common_scripts\utility::getfx(var_02),self.body,level.dismemberment[param_00]["fxTagName"]);
	wait(10);
	if(isdefined(self.body))
	{
		stopfxontag(common_scripts\utility::getfx(var_02),self.body,level.dismemberment[param_00]["fxTagName"]);
	}
}

//Function Number: 30
spawncorpsefullbodygib(param_00)
{
	var_01 = 3;
	if(isdefined(level.splitscreen) && level.splitscreen)
	{
		var_01 = 1;
	}

	var_02 = level.fullbodygibcounter < var_01;
	if(var_02)
	{
		level.fullbodygibcounter++;
		var_03 = common_scripts\utility::getfx("gib_full_body");
	}
	else
	{
		var_03 = common_scripts\utility::getfx("gib_full_body_cheap");
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00["emz"]))
		{
			var_03 = common_scripts\utility::getfx("gib_full_body_emz");
		}
		else if(isdefined(param_00["exploder"]))
		{
			var_03 = common_scripts\utility::getfx("gib_full_body_exp");
		}
		else if(isdefined(param_00["fast"]))
		{
			var_03 = common_scripts\utility::getfx("gib_full_body_ovr");
		}
	}

	var_04 = level.dismemberment["full"]["fxTagName"];
	playfxontag(var_03,self.body,var_04);
	var_05 = maps\mp\zombies\_util::getdismembersoundname();
	self.body playsoundonmovingent(level.dismemberment["full"][var_05]);
	wait(3);
	if(isdefined(self.body))
	{
		stopfxontag(var_03,self.body,var_04);
	}

	if(var_02)
	{
		level.fullbodygibcounter--;
	}
}

//Function Number: 31
onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	maps\mp\agents\_agents::on_agent_generic_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 32
cantrymutilate(param_00,param_01)
{
	return !maps\mp\zombies\_util::iszombiednagrenade(param_00) && !maps\mp\zombies\_util::zombiewaitingfordeath() && param_01 != "MOD_FALLING" && param_00 != "repulsor_zombie_mp" && param_00 != "zombie_water_trap_mp" && param_00 != "zombie_vaporize_mp" && !param_00 == "iw5_exominigunzm_mp" && param_01 == "MOD_MELEE_ALT" && !maps\mp\zombies\_util::is_true(self.skipmutilate);
}

//Function Number: 33
onzombiedamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self.health;
	var_0B = 0;
	var_0C = cantrymutilate(param_05,param_04);
	if(var_0C)
	{
		if(self.health > 0)
		{
			var_0D = clamp(param_02 / self.health,0,1);
		}
		else
		{
			var_0D = 1;
		}

		var_0B = maps\mp\zombies\_mutators::trymutilate(param_08,param_05,param_04,var_0D,param_01,param_07);
		if(var_0B && isdefined(param_01))
		{
			param_02 = self.health + 1;
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && !isdefined(self.favoriteenemy))
	{
		var_0E = self.aistate != "melee";
		var_0F = isdefined(self.curmeleetarget) && self.curmeleetarget == param_01;
		var_10 = isdefined(self.curmeleetarget) && !isplayer(self.curmeleetarget);
		if(var_0E || var_0F || var_10)
		{
			if(distancesquared(self.origin,param_01.origin) <= self.damagedradiussq)
			{
				maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy(param_01);
				thread maps\mp\agents\humanoid\_humanoid::watchfavoriteenemydeath();
			}
		}
	}

	thread maps\mp\zombies\_mutators::ondamagefinishedmutators(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	giveboostslamachievement(param_01,param_05);
	if(!maps\mp\zombies\_util::candie() && self.health - param_02 <= 0)
	{
		thread maps\mp\zombies\_util::zombiependingdeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		param_02 = int(max(0,self.health - 1));
	}

	if(self.species == "dog")
	{
		self [[ level.zombiedogondamage ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
	else
	{
		ondamagepainsensor(param_02,param_04,param_05);
		maps\mp\agents\humanoid\_humanoid::ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	maps\mp\zombies\_zombies_audio::do_zombies_playvocals("pain",self.agent_type);
	level notify("zombie_damaged",self,param_01);
	maps\mp\agents\_agents::agent_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	if(isalive(self))
	{
		if(var_0B && !maps\mp\zombies\_util::ispendingdeath())
		{
			self suicide();
			return;
		}

		updatemeleechargeforcurrenthealth();
	}
}

//Function Number: 34
zombie_speed_monitor()
{
	self endon("death");
	level.zombie_move_modes = ["walk","run","sprint"];
	if(isdefined(level.wavecycleoverride))
	{
		var_00 = level.wavecycleoverride;
	}
	else
	{
		var_00 = 7;
	}

	if(!isdefined(level.moveratescalemod))
	{
		level.moveratescalemod["walk"][0] = 0.65;
		level.moveratescalemod["walk"][1] = 1.5;
		level.moveratescalemod["run"][0] = 0.7;
		level.moveratescalemod["run"][1] = 1.25;
		level.moveratescalemod["sprint"][0] = 0.8;
		level.moveratescalemod["sprint"][1] = 0.9;
	}

	if(!isdefined(level.nonmoveratescalemod))
	{
		level.nonmoveratescalemod["walk"] = 0.9;
		level.nonmoveratescalemod["run"] = 1;
		level.nonmoveratescalemod["sprint"] = 1.1;
	}

	if(!isdefined(level.traverseratescalemod))
	{
		level.traverseratescalemod[0] = 0.55;
		level.traverseratescalemod[1] = 1.55;
	}

	if(!isdefined(level.zombiesharpturndist))
	{
		level.zombiesharpturndist["walk"] = 100;
		level.zombiesharpturndist["run"] = 130;
		level.zombiesharpturndist["sprint"] = 130;
	}

	for(;;)
	{
		if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || self.aistate == "traverse")
		{
			wait(0.05);
			continue;
		}

		if(isdefined(level.movemodefunc[self.agent_type]))
		{
			self.movemode = [[ level.movemodefunc[self.agent_type] ]]();
		}
		else
		{
			self.movemode = calulatezombiemovemode(var_00);
		}

		self.sharpturnnotifydist = level.zombiesharpturndist[self.movemode];
		if(isdefined(level.moveratescalefunc[self.agent_type]))
		{
			self.moveratescale = [[ level.moveratescalefunc[self.agent_type] ]]();
		}
		else
		{
			self.moveratescale = calculatezombiemoveratescale(var_00,level.moveratescalemod[self.movemode][0],level.moveratescalemod[self.movemode][1]);
		}

		if(isdefined(level.nonmoveratescalefunc[self.agent_type]))
		{
			self.nonmoveratescale = [[ level.nonmoveratescalefunc[self.agent_type] ]]();
		}
		else
		{
			self.nonmoveratescale = calculatezombienonmoveratescale(self.movemode);
		}

		if(isdefined(level.traverseratescalefunc[self.agent_type]))
		{
			self.traverseratescale = [[ level.traverseratescalefunc[self.agent_type] ]]();
		}
		else
		{
			self.traverseratescale = calculatezombietraverseratescale(var_00,level.traverseratescalemod[0],level.traverseratescalemod[1]);
		}

		self.generalspeedratescale = self.traverseratescale;
		if(maps\mp\agents\humanoid\_humanoid_util::iscrawling())
		{
			self.sharpturnnotifydist = 100;
			self.moveratescale = self.generalspeedratescale;
		}

		common_scripts\utility::waittill_any_timeout(1,"speed_debuffs_changed");
	}
}

//Function Number: 35
calulatezombiemovemode(param_00)
{
	var_01 = calculatezombieroundindex(param_00);
	var_02 = int(var_01 / param_00);
	return level.zombie_move_modes[int(clamp(var_02,0,level.zombie_move_modes.size - 1))];
}

//Function Number: 36
calculatezombiemoveratescale(param_00,param_01,param_02)
{
	var_03 = calculatezombieroundindex(param_00);
	var_04 = var_03 % param_00;
	var_05 = float(var_04) / float(param_00 - 1);
	var_06 = maps\mp\zombies\_util::lerp(var_05,param_01,param_02);
	if(level.wavecounter > 24)
	{
		var_06 = var_06 + 0.05;
	}

	if(level.wavecounter > 29)
	{
		var_06 = var_06 + 0.05;
	}

	var_06 = var_06 * getbuffspeedmultiplier();
	return var_06;
}

//Function Number: 37
calculatezombienonmoveratescale(param_00)
{
	var_01 = level.nonmoveratescalemod[param_00];
	var_01 = var_01 * getbuffspeedmultiplier();
	return var_01;
}

//Function Number: 38
calculatezombietraverseratescale(param_00,param_01,param_02)
{
	var_03 = calculatezombieroundindex(param_00);
	var_04 = var_03 / level.zombie_move_modes.size * param_00 - 1;
	var_05 = maps\mp\zombies\_util::lerp(var_04,param_01,param_02);
	if(level.wavecounter > 24)
	{
		var_05 = var_05 + 0.05;
	}

	if(level.wavecounter > 29)
	{
		var_05 = var_05 + 0.05;
	}

	var_05 = var_05 * getbuffspeedmultiplier();
	return var_05;
}

//Function Number: 39
calculatezombieroundindex(param_00)
{
	var_01 = level.wavecounter - 1;
	if(isdefined(self.moverateroundmod))
	{
		var_01 = var_01 + self.moverateroundmod;
	}

	var_01 = int(clamp(var_01,0,level.zombie_move_modes.size * param_00 - 1));
	return var_01;
}

//Function Number: 40
domoveloopeffects()
{
	self endon("death");
	for(;;)
	{
		self waittill("move_loop",var_00);
		switch(var_00)
		{
			case "fx_blood":
				crawlingfx("J_MainRoot","gib_bloodpool");
				break;
	
			case "fx_dust":
				crawlingfx("J_MainRoot","crawl_dust");
				break;
		}
	}
}

//Function Number: 41
crawlingfx(param_00,param_01)
{
	var_02 = self gettagorigin(param_00);
	var_03 = self gettagangles(param_00);
	playfx(common_scripts\utility::getfx(param_01),var_02,anglestoforward(var_03),(0,0,1));
}

//Function Number: 42
addbuff(param_00,param_01)
{
	self.buffs[param_00] = param_01;
}

//Function Number: 43
getbuff(param_00)
{
	if(!isdefined(self.buffs) || !isdefined(self.buffs[param_00]))
	{
		return undefined;
	}

	return self.buffs[param_00];
}

//Function Number: 44
updatebuff(param_00)
{
	if(!isdefined(param_00.buffupdate))
	{
		return;
	}

	self [[ param_00.buffupdate ]](param_00);
}

//Function Number: 45
removebuff(param_00)
{
	if(!isdefined(param_00.buffremove))
	{
		return;
	}

	self [[ param_00.buffremove ]](param_00);
}

//Function Number: 46
getbufftimestep()
{
	return 0.1;
}

//Function Number: 47
updatebuffs()
{
	self notify("updateBuffs");
	self endon("updateBuffs");
	self endon("death");
	var_00 = getbufftimestep();
	var_01 = 0;
	for(;;)
	{
		wait(var_00);
		if(!isdefined(self.buffs))
		{
			continue;
		}

		foreach(var_04, var_03 in self.buffs)
		{
			updatebuff(var_03);
			var_03.lifespan = var_03.lifespan - var_00;
			if(var_03.lifespan < 0)
			{
				removebuff(var_03);
				self.buffs[var_04] = undefined;
			}
		}

		self.buffs = maps\mp\zombies\_util::arrayremoveundefinedkeephash(self.buffs);
	}
}

//Function Number: 48
getbuffspeedmultiplier()
{
	var_00 = 1;
	if(!isdefined(self.buffs))
	{
		return var_00;
	}

	foreach(var_02 in self.buffs)
	{
		if(!isdefined(var_02.speedmultiplier))
		{
			continue;
		}

		var_00 = var_00 * var_02.speedmultiplier;
	}

	return var_00;
}

//Function Number: 49
updatepainsensor()
{
	self notify("updatePainSensor");
	self endon("updatePainSensor");
	self endon("death");
	self.painsensor = spawnstruct();
	self.painsensor.lastpaintime = gettime();
	self.painsensor.damage = 0;
	var_00 = 0.05;
	var_01 = 5 * var_00;
	for(;;)
	{
		wait(var_00);
		if(gettime() > self.painsensor.lastpaintime + 2000)
		{
			self.painsensor.damage = self.painsensor.damage - var_01;
		}

		self.painsensor.damage = max(self.painsensor.damage,0);
		if(isplayinghitreaction())
		{
			self.painsensor.damage = 0;
		}
	}
}

//Function Number: 50
ondamagepainsensor(param_00,param_01,param_02)
{
	if(isdefined(self.ondamagepainsensorfunc))
	{
		[[ self.ondamagepainsensorfunc ]](param_00,param_01,param_02);
	}

	if(isdefined(param_02) && param_02 == "dna_aoe_grenade_zombie_mp" || param_02 == "trap_zm_mp")
	{
		return;
	}

	self.painsensor.lastpaintime = gettime();
	self.painsensor.damage = self.painsensor.damage + param_00;
}

//Function Number: 51
gethitreactiondamagethreshold()
{
	if(isdefined(self.gethitreactiondamagethresholdfunc))
	{
		return [[ self.gethitreactiondamagethresholdfunc ]]();
	}

	var_00 = clamp(level.wavecounter / 15,0,1);
	var_01 = maps\mp\zombies\_util::lerp(1 - var_00,0.1,0.5);
	return var_01 * self.maxhealth;
}

//Function Number: 52
shouldplayhitreactionpainsensor()
{
	if(!isdefined(self.painsensor))
	{
		return 1;
	}

	if(self.painsensor.damage > gethitreactiondamagethreshold())
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
isplayinghitreaction()
{
	if(isdefined(self.inpainmoving) && self.inpainmoving)
	{
		return 1;
	}

	if(isdefined(self.inpain) && self.inpain)
	{
		return 1;
	}

	return 0;
}
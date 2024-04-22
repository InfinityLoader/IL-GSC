/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_drones.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 454 ms
 * Timestamp: 4/22/2024 2:09:38 AM
*******************************************************************/

//Function Number: 1
hordecreatedrone(param_00,param_01,param_02)
{
	var_03 = hordegetdronespawn();
	var_04 = (randomfloatrange(0.1,5),randomfloatrange(0.1,5),randomfloatrange(0.1,5));
	var_05 = spawnhelicopter(param_00,var_03.origin + var_04,(0,0,0),param_01,param_02);
	var_05.current_air_space = getent(var_03.target,"targetname");
	var_05.maxhealth = level.dronehealth;
	var_05.damagetaken = 0;
	var_05.fx_tag0 = "TAG_EYE";
	var_05.speed = 20;
	var_05.followspeed = 20;
	var_05.owner = param_00;
	var_05.team = "axis";
	var_05.ishordedrone = 1;
	var_05.maxtrackingrange = 2000;
	var_05.maxlaserrange = 300;
	var_05.trackedplayer = undefined;
	var_05 sethoverparams(0,0,0);
	var_05 setmaxpitchroll(90,90);
	var_05 vehicle_setspeed(40,40,40);
	var_05 vehicle_helicoptersetmaxangularvelocity(90,180,90);
	var_05 vehicle_helicoptersetmaxangularacceleration(1000);
	var_05 setneargoalnotifydist(5);
	var_05 setyawspeed(1000,250,100,0.1);
	var_05 thread horde_drone_flying_fx();
	var_05 thread hordedrone_handledamage();
	var_05 thread hordedrone_watchdeath();
	var_05.droneturret = var_05 hordespawndroneturret(level.droneweapon,"vehicle_xh9_warbird_turret_coop","TAG_EYE");
	var_05 thread hordedroneshoot();
	self.currenttarget = common_scripts\utility::random(level.players);
	var_05 thread flying_attack_drone_logic();
	return var_05;
}

//Function Number: 2
hordegetdronespawn()
{
	var_00 = common_scripts\utility::array_randomize(level.hordedronespawns);
	foreach(var_02 in var_00)
	{
		var_03 = 1;
		foreach(var_05 in level.players)
		{
			if(spawnsighttrace(var_02,var_02.origin,var_05.origin,0))
			{
				var_03 = 0;
				break;
			}
		}

		if(var_03)
		{
			return var_02;
		}
	}

	return common_scripts\utility::random(level.hordedronespawns);
}

//Function Number: 3
hordedroneshoot()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self.targetenemy))
		{
			if(isdefined(self.targetenemy.isaerialassaultdrone) && self.targetenemy.isaerialassaultdrone)
			{
				self.droneturret settargetentity(self.targetenemy,(0,0,-20));
			}
			else
			{
				self.droneturret settargetentity(self.targetenemy);
			}

			if(isdefined(self.droneturret getturrettarget(0)))
			{
				var_00 = randomintrange(5,10);
				for(var_01 = 0;var_01 < var_00;var_01++)
				{
					self.droneturret shootturret();
					wait(0.08);
				}

				wait(randomintrange(3,5));
			}
			else
			{
				wait(randomintrange(1,3));
			}
		}

		wait(0.05);
	}
}

//Function Number: 4
horde_drone_flying_fx()
{
	self endon("death");
	var_00 = 0.3;
	var_01 = common_scripts\utility::getfx("drone_fan_distortion");
	if(level.hordedronetype == "drone_large_energy")
	{
		var_01 = common_scripts\utility::getfx("drone_fan_distortion_large");
	}

	foreach(var_03 in level.players)
	{
		playfxontagforclients(var_01,self,"TAG_FX_FAN_L",var_03);
		wait 0.05;
		playfxontagforclients(var_01,self,"TAG_FX_FAN_R",var_03);
		playfxontagforclients(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_0",var_03);
		wait(var_00);
		playfxontagforclients(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_1",var_03);
		wait(var_00);
		playfxontagforclients(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_2",var_03);
	}
}

//Function Number: 5
hordedrone_handledamage()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if((!isdefined(var_01) || var_01.classname == "worldspawn") && isdefined(var_09) && var_09 == "killstreak_strike_missile_gas_mp" || var_09 == "warbird_missile_mp")
		{
			continue;
		}

		if(isdefined(var_01.team))
		{
			if(self.team == var_01.team)
			{
				continue;
			}
		}
		else if(isdefined(var_01.owner) && isdefined(var_01.owner.team))
		{
			if(self.team == var_01.owner.team)
			{
				continue;
			}
		}

		self.lasttododamage = var_01;
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("tracking_drone");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("tracking_drone");
		}

		if(isdefined(var_09))
		{
			var_0B = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0B)
			{
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "emp_grenade_killstreak_mp":
				case "emp_grenade_var_mp":
				case "emp_grenade_mp":
					var_0A = self.maxhealth + 1;
					break;
	
				case "stun_grenade_var_mp":
				case "stun_grenade_mp":
				case "flash_grenade_mp":
				case "concussion_grenade_mp":
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(maps\mp\_utility::ismeleemod(var_04) || var_04 == "MOD_IMPACT")
			{
				maps\mp\gametypes\_horde_util::awardhordemeleekills(var_01);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 6
hordedrone_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death",var_00);
	var_00 = self.lasttododamage;
	thread hordedronedestroyed(var_00);
}

//Function Number: 7
hordedronedestroyed(param_00)
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
	wait 0.05;
	if(isplayer(param_00))
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_00);
		param_00 thread maps\mp\gametypes\_rank::xppointspopup("kill",100);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00,100);
		if(param_00 maps\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
		}
	}

	if(isdefined(param_00) && isdefined(param_00.owner) && isplayer(param_00.owner) && isdefined(param_00.owner.killz))
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_00.owner);
		param_00.owner thread maps\mp\gametypes\_rank::xppointspopup("kill",100);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_00.owner,100);
	}

	maps\mp\_tracking_drone::trackingdrone_stunend();
	if(isdefined(level.trackingdronesettings.fxid_explode))
	{
		playfx(level.trackingdronesettings.fxid_explode,self.origin);
	}

	if(isdefined(level.trackingdronesettings.sound_explode))
	{
		self playsound("horde_uav_assault_drone_exp");
	}

	level.currentpointtotal = level.currentpointtotal + 100;
	level notify("pointsEarned");
	self.droneturret delete();
	self delete();
}

//Function Number: 8
hordespawndroneturret(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",self gettagorigin(param_02),param_00,0);
	var_03.angles = self gettagangles(param_02);
	var_03 setmodel(param_01);
	var_03 setdefaultdroppitch(-45);
	var_03 linkto(self,param_02,(0,0,0),(0,0,0));
	var_03.owner = self.owner;
	var_03.health = 10000;
	var_03.maxhealth = 10000;
	var_03.damagetaken = 0;
	var_03.stunned = 0;
	var_03.stunnedtime = 0;
	var_03 setcandamage(1);
	var_03 setcanradiusdamage(1);
	var_03 setbottomarc(180);
	var_03.team = self.team;
	var_03.pers["team"] = self.team;
	if(level.teambased)
	{
		var_03 setturretteam(self.team);
	}

	var_03 setmode("auto_nonai");
	var_03 setsentryowner(undefined);
	var_03 setturretminimapvisible(0);
	var_03.chopper = self;
	var_03 setleftarc(180);
	var_03 setrightarc(180);
	var_03 maketurretinoperable();
	var_03 maketurretsolid();
	var_03 makeunusable();
	var_03 thread hordedroneturret_setupdamagecallback();
	return var_03;
}

//Function Number: 9
hordedroneturret_setupdamagecallback()
{
	self.damagecallback = ::hordedroneturret_handledamagecallback;
	self setcandamage(1);
	self setdamagecallbackon(1);
}

//Function Number: 10
hordedroneturret_handledamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	self.chopper notify("damage",param_02,param_01,param_07,param_06,param_04,undefined,undefined,param_0B,param_03,param_05);
}

//Function Number: 11
flying_attack_drone_system_init()
{
	level.drone_air_spaces = [];
	level.flying_attack_drones = [];
	level.hordedronespawns = common_scripts\utility::getstructarray("horde_drone_spawn","targetname");
	level.player_test_points = common_scripts\utility::getstructarray("player_test_point","targetname");
	var_00 = getentarray("trigger_once","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "drone_air_space")
		{
			level.drone_air_spaces[level.drone_air_spaces.size] = var_02;
		}
	}

	init_linked_air_spaces();
	init_target_points();
	if(!isdefined(level.flying_attack_drones))
	{
		level.flying_attack_drones = [];
	}
}

//Function Number: 12
init_drone_motion()
{
	var_00 = undefined;
	if(!isdefined(self.script_airspeed))
	{
		var_00 = 40;
	}
	else
	{
		var_00 = self.script_airspeed;
	}

	self setneargoalnotifydist(30);
	self vehicle_setspeed(var_00,var_00 / 4,var_00 / 4);
}

//Function Number: 13
flying_attack_drone_logic(param_00)
{
	self notify("pdrone_flying_attack_drone_logic");
	self endon("pdrone_flying_attack_drone_logic");
	self endon("death");
	param_00 = self;
	param_00 thread flying_attack_drone_damage_monitor();
	param_00 thread flying_attack_drone_death_monitor();
	param_00.attack_delay = 1;
	param_00.attack_accuracy = 1;
	param_00 init_drone_motion();
	if(isdefined(param_00.target))
	{
		param_00 waittill("reached_dynamic_path_end");
	}

	param_00 thread flying_attack_drone_move_think();
}

//Function Number: 14
get_target_air_space(param_00)
{
	var_01 = 500000000;
	var_02 = undefined;
	foreach(var_04 in level.player_test_points)
	{
		var_05 = distancesquared(var_04.origin,param_00.origin);
		if(var_05 < var_01)
		{
			var_01 = var_05;
			var_02 = var_04;
		}
	}

	return var_02.link;
}

//Function Number: 15
get_random_air_space()
{
	var_00 = common_scripts\utility::random(level.player_test_points);
	return var_00.link;
}

//Function Number: 16
flying_attack_drone_move_think()
{
	self endon("death");
	if(!isdefined(level.drone_air_spaces))
	{
		return;
	}

	update_flying_attack_drone_goal_pos();
	self waittill("near_goal");
	wait(0.05);
	for(;;)
	{
		var_00 = maps\mp\gametypes\_horde_util::hordegetclosesthealthyenemy(self);
		if(isdefined(var_00))
		{
			self setlookatent(var_00);
			self.targetenemy = var_00;
			var_01 = get_target_air_space(var_00);
		}
		else
		{
			var_01 = get_random_air_space();
		}

		if(var_01 != self.current_air_space)
		{
			var_02 = get_next_air_space(self.current_air_space,var_01,level.drone_air_spaces);
			if(isdefined(var_02))
			{
				self.current_air_space = var_02;
			}
		}

		update_flying_attack_drone_goal_pos();
		self waittill("near_goal");
		if(var_01 == self.current_air_space)
		{
			wait_in_current_air_space();
		}
	}
}

//Function Number: 17
wait_in_current_air_space()
{
	level endon("pdrone_wait_in_current_air_space");
	wait(randomfloatrange(0.5,1.5));
}

//Function Number: 18
calc_flock_goal_pos()
{
	var_00 = self.origin;
	if(!ispointinvolume(var_00,self.current_air_space))
	{
		var_00 = get_random_point_in_air_space(self.current_air_space);
	}
	else
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = (0,0,0);
		var_04 = 0;
		var_05 = (0,0,0);
		foreach(var_07 in level.flying_attack_drones)
		{
			if(self != var_07 && isdefined(self.current_air_space) && isdefined(var_07.current_air_space))
			{
				if(self.current_air_space == var_07.current_air_space)
				{
					var_01++;
					var_08 = var_07.origin - self.origin;
					var_09 = length(var_08);
					if(var_09 < 90)
					{
						var_02++;
						var_03 = var_03 - 0.5 * 90 - var_09 * var_08 / var_09;
					}
					else if(var_09 > 150)
					{
						var_04++;
						var_05 = var_05 + 0.5 * var_09 - 150 * var_08 / var_09;
					}
				}
			}
		}

		if(var_01 > 0)
		{
			if(randomint(5) == 0)
			{
				var_00 = get_random_point_in_air_space(self.current_air_space);
			}
			else
			{
				if(var_02 > 0)
				{
					var_00 = var_00 + var_03 / var_02;
				}

				if(var_04 > 0)
				{
					var_00 = var_00 + var_05 / var_04;
				}
			}
		}
		else
		{
			var_00 = get_random_point_in_air_space(self.current_air_space);
		}
	}

	return var_00;
}

//Function Number: 19
get_tactical_goal_pos()
{
	if(self.current_air_space != level.drone_tactical_picker_data.target_air_space || !isdefined(self.flock_goal_position) || !isdefined(self.flock_goal_offset))
	{
		return get_random_point_in_air_space(self.current_air_space);
	}

	if(isdefined(self.dodge_position))
	{
		return self.dodge_position;
	}

	return self.flock_goal_position + self.flock_goal_offset;
}

//Function Number: 20
tactical_move_to_goal_pos()
{
	var_00 = get_tactical_goal_pos();
	var_01 = undefined;
	var_02 = self.angles[1];
	if(!isdefined(self.drone_threat_data) || !isdefined(self.drone_threat_data.threat))
	{
		var_01 = 1;
		var_03 = var_00 - self.origin;
		if(var_03 != (0,0,0))
		{
			var_04 = vectortoangles(var_03);
			var_02 = var_04[1];
		}
	}

	self vehicle_helisetai(var_00,60,50,50,undefined,var_01,var_02,0,0,0,0,0,1);
}

//Function Number: 21
update_flying_attack_drone_goal_pos()
{
	self setvehgoalpos(calc_flock_goal_pos(),1);
}

//Function Number: 22
get_random_point_in_air_space(param_00)
{
	for(var_01 = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));!ispointinvolume(var_01,param_00);var_01 = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1)))
	{
	}

	return var_01;
}

//Function Number: 23
flying_attack_drone_damage_monitor()
{
	self endon("death");
	self.damagetaken = 0;
	self.istakingdamage = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		self notify("flying_attack_drone_damaged_by_player");
		thread flying_attack_drone_damage_update();
	}
}

//Function Number: 24
flying_attack_drone_damage_update()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self.istakingdamage = 1;
	wait(1);
	self.istakingdamage = 0;
}

//Function Number: 25
flying_attack_drone_death_monitor()
{
	if(!isdefined(level.flying_attack_drones))
	{
		level.flying_attack_drones = [];
	}

	level.flying_attack_drones = common_scripts\utility::array_add(level.flying_attack_drones,self);
	self waittill("death");
	level.flying_attack_drones = common_scripts\utility::array_remove(level.flying_attack_drones,self);
	level notify("flying_attack_drone_destroyed");
}

//Function Number: 26
init_linked_air_spaces()
{
	var_00 = level.drone_air_spaces;
	var_01 = [];
	var_02 = 0;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(!isdefined(var_00[var_03].script_linkname))
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		if(int(var_00[var_03].script_linkname) > var_02)
		{
			var_02 = int(var_00[var_03].script_linkname);
		}
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_02++;
		var_00[var_01[var_03]].script_linkname = var_02;
	}

	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(!isdefined(var_00[var_03].links))
		{
			var_00[var_03].links = [];
		}

		var_04 = [];
		if(isdefined(var_00[var_03].script_linkto))
		{
			var_04 = strtok(var_00[var_03].script_linkto," ");
			for(var_05 = 0;var_05 < var_04.size;var_05++)
			{
				for(var_06 = 0;var_06 < var_00.size;var_06++)
				{
					if(var_00[var_06].script_linkname == var_04[var_05])
					{
						var_07 = 0;
						for(var_08 = 0;var_08 < var_00[var_03].links.size;var_08++)
						{
							if(var_00[var_03].links[var_08] == var_00[var_06])
							{
								var_07 = 1;
								break;
							}
						}

						if(!var_07)
						{
							var_00[var_03].links[var_00[var_03].links.size] = var_00[var_06];
						}

						if(!isdefined(var_00[var_06].links))
						{
							var_00[var_06].links = [];
						}

						var_07 = 0;
						for(var_08 = 0;var_08 < var_00[var_06].links.size;var_08++)
						{
							if(var_00[var_06].links[var_08] == var_00[var_03])
							{
								var_07 = 1;
								break;
							}
						}

						if(!var_07)
						{
							var_00[var_06].links[var_00[var_06].links.size] = var_00[var_03];
						}

						break;
					}
				}
			}
		}
	}
}

//Function Number: 27
init_target_points()
{
	for(var_00 = 0;var_00 < level.player_test_points.size;var_00++)
	{
		level.player_test_points[var_00].link = getent(level.player_test_points[var_00].target,"targetname");
	}
}

//Function Number: 28
get_next_air_space(param_00,param_01,param_02)
{
	var_03 = param_00;
	param_00 = param_01;
	param_01 = var_03;
	var_04 = [];
	var_04[0] = param_00;
	var_05 = [];
	param_00.f_score = distancesquared(param_00.origin,param_01.origin);
	param_00.g_score = 0;
	while(var_04.size > 0)
	{
		var_06 = undefined;
		var_07 = 500000000;
		foreach(var_09 in var_04)
		{
			if(var_09.f_score < var_07)
			{
				var_06 = var_09;
				var_07 = var_09.f_score;
			}
		}

		if(var_06 == param_01)
		{
			return var_06.came_from;
		}

		var_04 = common_scripts\utility::array_remove(var_04,var_06);
		var_05[var_05.size] = var_06;
		var_0B = var_06.links;
		foreach(var_09 in var_0B)
		{
			if(common_scripts\utility::array_contains(var_05,var_09))
			{
				continue;
			}

			var_0D = var_06.g_score + distancesquared(var_06.origin,var_09.origin);
			var_0E = common_scripts\utility::array_contains(var_04,var_09);
			if(!var_0E)
			{
				var_09.came_from = var_06;
				var_09.g_score = var_0D;
				var_09.f_score = var_09.g_score + distancesquared(var_09.origin,param_01.origin);
				var_04[var_04.size] = var_09;
				continue;
			}

			if(var_0D < var_09.g_score)
			{
				var_09.came_from = var_06;
				var_09.g_score = var_0D;
				var_09.f_score = var_09.g_score + distancesquared(var_09.origin,param_01.origin);
			}
		}
	}

	return undefined;
}
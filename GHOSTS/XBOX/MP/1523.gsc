/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1523.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 43
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 1:32:17 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["ball_drone_radar"] = ::func_842C;
	level.killstreakfuncs["ball_drone_backup"] = ::func_842C;
	level.balldronesettings = [];
	level.balldronesettings["ball_drone_radar"] = addstruct();
	level.balldronesettings["ball_drone_radar"].timeout = 60;
	level.balldronesettings["ball_drone_radar"].health = 999999;
	level.balldronesettings["ball_drone_radar"].maxhealth = 500;
	level.balldronesettings["ball_drone_radar"].streakname = "ball_drone_radar";
	level.balldronesettings["ball_drone_radar"].vehicleinfo = "ball_drone_mp";
	level.balldronesettings["ball_drone_radar"].modelbase = "vehicle_ball_drone_iw6";
	level.balldronesettings["ball_drone_radar"].teamsplash = "used_ball_drone_radar";
	level.balldronesettings["ball_drone_radar"].fxid_sparks = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
	level.balldronesettings["ball_drone_radar"].fxid_explode = loadfx("vfx/gameplay/explosions/vehicle/ball/vfx_exp_ball_drone");
	level.balldronesettings["ball_drone_radar"].sound_explode = "ball_drone_explode";
	level.balldronesettings["ball_drone_radar"].vodestroyed = "nowl_destroyed";
	level.balldronesettings["ball_drone_radar"].votimedout = "nowl_gone";
	level.balldronesettings["ball_drone_radar"].xppopup = "destroyed_ball_drone_radar";
	level.balldronesettings["ball_drone_radar"].playfxcallback = ::func_62A8;
	level.balldronesettings["ball_drone_radar"].fxid_light1 = [];
	level.balldronesettings["ball_drone_radar"].fxid_light2 = [];
	level.balldronesettings["ball_drone_radar"].fxid_light3 = [];
	level.balldronesettings["ball_drone_radar"].fxid_light4 = [];
	level.balldronesettings["ball_drone_radar"].fxid_light1["enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.balldronesettings["ball_drone_radar"].fxid_light2["enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.balldronesettings["ball_drone_radar"].fxid_light3["enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.balldronesettings["ball_drone_radar"].fxid_light4["enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.balldronesettings["ball_drone_radar"].fxid_light1["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	level.balldronesettings["ball_drone_radar"].fxid_light2["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	level.balldronesettings["ball_drone_radar"].fxid_light3["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	level.balldronesettings["ball_drone_radar"].fxid_light4["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	level.balldronesettings["ball_drone_backup"] = addstruct();
	level.balldronesettings["ball_drone_backup"].timeout = 90;
	level.balldronesettings["ball_drone_backup"].health = 999999;
	level.balldronesettings["ball_drone_backup"].maxhealth = 500;
	level.balldronesettings["ball_drone_backup"].streakname = "ball_drone_backup";
	level.balldronesettings["ball_drone_backup"].vehicleinfo = "backup_drone_mp";
	level.balldronesettings["ball_drone_backup"].modelbase = "vehicle_drone_backup_buddy";
	level.balldronesettings["ball_drone_backup"].teamsplash = "used_ball_drone_radar";
	level.balldronesettings["ball_drone_backup"].fxid_sparks = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
	level.balldronesettings["ball_drone_backup"].fxid_explode = loadfx("fx/explosions/bouncing_betty_explosion");
	level.balldronesettings["ball_drone_backup"].sound_explode = "ball_drone_explode";
	level.balldronesettings["ball_drone_backup"].vodestroyed = "vulture_destroyed";
	level.balldronesettings["ball_drone_backup"].votimedout = "vulture_gone";
	level.balldronesettings["ball_drone_backup"].xppopup = "destroyed_ball_drone";
	level.balldronesettings["ball_drone_backup"].weaponinfo = "ball_drone_gun_mp";
	level.balldronesettings["ball_drone_backup"].weaponmodel = "vehicle_drone_backup_buddy_gun";
	level.balldronesettings["ball_drone_backup"].weapontag = "tag_turret_attach";
	level.balldronesettings["ball_drone_backup"].sound_weapon = "weap_p99_fire_npc";
	level.balldronesettings["ball_drone_backup"].sound_targeting = "ball_drone_targeting";
	level.balldronesettings["ball_drone_backup"].sound_lockon = "ball_drone_lockon";
	level.balldronesettings["ball_drone_backup"].sentrymode = "sentry";
	level.balldronesettings["ball_drone_backup"].visual_range_sq = 1440000;
	level.balldronesettings["ball_drone_backup"].burstmin = 10;
	level.balldronesettings["ball_drone_backup"].burstmax = 20;
	level.balldronesettings["ball_drone_backup"].pausemin = 0.15;
	level.balldronesettings["ball_drone_backup"].pausemax = 0.35;
	level.balldronesettings["ball_drone_backup"].lockontime = 0.25;
	level.balldronesettings["ball_drone_backup"].playfxcallback = ::backupbuddyplayfx;
	level.balldronesettings["ball_drone_backup"].fxid_light1 = [];
	level.balldronesettings["ball_drone_backup"].fxid_light1["enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.balldronesettings["ball_drone_backup"].fxid_light1["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	level.balldrones = [];
}

//Function Number: 2
func_842C(param_00,param_01)
{
	return useballdrone(param_01);
}

//Function Number: 3
useballdrone(param_00)
{
	var_01 = 1;
	if(maps\mp\_utility::func_4995())
	{
		return 0;
	}
	else if(exceededmaxballdrones())
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(isdefined(self.balldrone))
	{
		self iprintlnbold(&"KILLSTREAKS_COMPANION_ALREADY_EXISTS");
		return 0;
	}
	else if(isdefined(self.drones_disabled))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_02 = createballdrone(param_00);
	if(!isdefined(var_02))
	{
		if(maps\mp\_utility::func_47BB())
		{
			self.drone_failed = 1;
		}
		else
		{
			self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		}

		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	self.balldrone = var_02;
	thread func_7AC3(var_02);
	if(param_00 == "ball_drone_backup" && maps/mp/agents/_agent_utility::func_3B5A(self,"dog") > 0)
	{
		maps\mp\gametypes\_missions::func_61CE("ch_twiceasdeadly");
	}

	return 1;
}

//Function Number: 4
createballdrone(param_00)
{
	var_01 = self.angles;
	var_02 = anglestoforward(self.angles);
	var_03 = self.origin + var_02 * 100 + (0,0,90);
	var_04 = self.origin + (0,0,90);
	var_05 = bullettrace(var_04,var_03,0);
	var_06 = 3;
	while(var_05["surfacetype"] != "none" && var_06 > 0)
	{
		var_03 = self.origin + vectornormalize(var_04 - var_05["position"]) * 5;
		var_05 = bullettrace(var_04,var_03,0);
		var_06--;
		wait(0.05);
	}

	if(var_06 <= 0)
	{
	}

	var_07 = anglestoright(self.angles);
	var_08 = self.origin + var_07 * 20 + (0,0,90);
	var_05 = bullettrace(var_03,var_08,0);
	var_06 = 3;
	while(var_05["surfacetype"] != "none" && var_06 > 0)
	{
		var_08 = var_03 + vectornormalize(var_03 - var_05["position"]) * 5;
		var_05 = bullettrace(var_03,var_08,0);
		var_06--;
		wait(0.05);
	}

	if(var_06 <= 0)
	{
	}

	var_09 = spawnhelicopter(self,var_03,var_01,level.balldronesettings[param_00].vehicleinfo,level.balldronesettings[param_00].modelbase);
	if(!isdefined(var_09))
	{
	}

	var_09 enableaimassist();
	var_09 makevehiclenotcollidewithplayers(1);
	var_09 addtoballdronelist();
	var_09 thread func_658A();
	var_09.health = level.balldronesettings[param_00].health;
	var_09.maxhealth = level.balldronesettings[param_00].maxhealth;
	var_09.damagetaken = 0;
	var_09.speed = 140;
	var_09.followspeed = 140;
	var_09.owner = self;
	var_09.team = self.team;
	var_09 setspeed(var_09.speed,16,16);
	var_09 setyawspeed(120,90);
	var_09 neargoalnotifydist(16);
	var_09.balldronetype = param_00;
	var_09 sethoverparams(30,10,5);
	var_09 setotherent(self);
	var_09 common_scripts\utility::func_5009(self.team,param_00 != "ball_drone_backup");
	if(issentient(var_09))
	{
		var_09 setthreatbiasgroup("DogsDontAttack");
	}

	if(!maps\mp\_utility::func_47BB())
	{
		if(level.teambased)
		{
			var_09 maps\mp\_entityheadicons::func_70E0(var_09.team,(0,0,25));
		}
		else
		{
			var_09 maps\mp\_entityheadicons::func_7099(var_09.owner,(0,0,25));
		}
	}

	var_0A = 45;
	var_0B = 45;
	switch(param_00)
	{
		case "ball_drone_radar":
			var_0A = 90;
			var_0B = 90;
			var_0C = spawn("script_model",self.origin);
			var_0C.team = self.team;
			var_0C makeportableradar(self);
			var_09.radar = var_0C;
			var_09 thread func_62A9();
			var_09.ammo = 99999;
			var_09.cameraoffset = distance(var_09.origin,var_09 gettagorigin("camera_jnt"));
			var_09 thread maps\mp\gametypes\_trophy_system::func_83C9(self);
			var_09 thread balldrone_handledamage();
			break;

		case "alien_ball_drone_4":
		case "alien_ball_drone_3":
		case "alien_ball_drone_2":
		case "alien_ball_drone_1":
		case "alien_ball_drone":
		case "ball_drone_backup":
			var_0D = spawnturret("misc_turret",var_09 gettagorigin(level.balldronesettings[param_00].weapontag),level.balldronesettings[param_00].weaponinfo);
			var_0D linkto(var_09,level.balldronesettings[param_00].weapontag);
			var_0D setmodel(level.balldronesettings[param_00].weaponmodel);
			var_0D.angles = var_09.angles;
			var_0D.owner = var_09.owner;
			var_0D.team = self.team;
			var_0D maketurretinoperable();
			var_0D makeunusable();
			var_0D.vehicle = var_09;
			var_0D.health = level.balldronesettings[param_00].health;
			var_0D.maxhealth = level.balldronesettings[param_00].maxhealth;
			var_0D.damagetaken = 0;
			var_0E = self.origin + var_02 * -100 + (0,0,40);
			var_0D.idletarget = spawn("script_origin",var_0E);
			var_0D.idletarget.targetname = "test";
			thread func_43E9(var_0D.idletarget);
			if(level.teambased)
			{
				var_0D setturretteam(self.team);
			}
	
			var_0D setmode(level.balldronesettings[param_00].sentrymode);
			var_0D setsentryowner(self);
			var_0D setleftarc(180);
			var_0D setrightarc(180);
			var_0D setbottomarc(50);
			var_0D thread func_1273();
			var_0D setturretminimapvisible(1,"buddy_turret");
			var_0F = var_09.origin + anglestoforward(var_09.angles) * -10 + anglestoright(var_09.angles) * -10 + (0,0,10);
			var_0D.killcament = spawn("script_model",var_0F);
			var_0D.killcament setscriptmoverkillcam("explosive");
			var_0D.killcament linkto(var_09);
			var_09.turret = var_0D;
			var_0D.parent = var_09;
			var_09 thread func_1274();
			var_09.turret thread func_1275();
			break;

		default:
			break;
	}

	var_09 setmaxpitchroll(var_0A,var_0B);
	var_09.targetpos = var_08;
	var_09.attract_strength = 10000;
	var_09.attract_range = 150;
	if(!maps\mp\_utility::func_47BB() && isdefined(level.script) && level.script == "mp_alien_last")
	{
		var_09.attractor = missilecreateattractorent(var_09,var_09.attract_strength,var_09.attract_range);
	}

	var_09.hasdodged = 0;
	var_09.stunned = 0;
	var_09.inactive = 0;
	var_09 thread func_8CDF();
	var_09 thread balldrone_watchdeath();
	var_09 thread balldrone_watchtimeout();
	var_09 thread balldrone_watchownerloss();
	var_09 thread balldrone_watchownerdeath();
	var_09 thread balldrone_watchroundend();
	var_09 thread balldrone_enemy_lightfx();
	var_09 thread balldrone_friendly_lightfx();
	var_10 = addstruct();
	var_10.validateaccuratetouching = 1;
	var_10.deathoverridecallback = ::balldrone_moving_platform_death;
	var_09 thread maps\mp\_movers::func_3F25(var_10);
	var_09.owner maps\mp\_matchdata::func_4F1D(level.balldronesettings[var_09.balldronetype].streakname,var_09.targetpos);
	return var_09;
}

//Function Number: 5
balldrone_moving_platform_death(param_00)
{
	if(!isdefined(param_00.lasttouchedplatform.destroydroneoncollision) || param_00.lasttouchedplatform.destroydroneoncollision)
	{
		self notify("death");
	}
}

//Function Number: 6
func_43E9(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = anglestoforward(self.angles);
	for(;;)
	{
		if(maps\mp\_utility::func_4945(self) && !maps\mp\_utility::func_4995() && anglestoforward(self.angles) != var_01)
		{
			var_01 = anglestoforward(self.angles);
			var_02 = self.origin + var_01 * -100 + (0,0,40);
			param_00 moveto(var_02,0.5);
		}

		wait(0.5);
	}
}

//Function Number: 7
balldrone_enemy_lightfx()
{
	self endon("death");
	var_00 = level.balldronesettings[self.balldronetype];
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02))
			{
				if(level.teambased)
				{
					if(var_02.team != self.team)
					{
						self [[ var_00.playfxcallback ]]("enemy",var_02);
					}

					continue;
				}

				if(var_02 != self.owner)
				{
					self [[ var_00.playfxcallback ]]("enemy",var_02);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 8
balldrone_friendly_lightfx()
{
	self endon("death");
	var_00 = level.balldronesettings[self.balldronetype];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02))
		{
			if(level.teambased)
			{
				if(var_02.team == self.team)
				{
					self [[ var_00.playfxcallback ]]("friendly",var_02);
				}

				continue;
			}

			if(var_02 == self.owner)
			{
				self [[ var_00.playfxcallback ]]("friendly",var_02);
			}
		}
	}

	thread func_8CD4();
	thread func_8CFD();
}

//Function Number: 9
backupbuddyplayfx(param_00,param_01)
{
	var_02 = level.balldronesettings[self.balldronetype];
	playfxontagforclients(var_02.fxid_light1[param_00],self.turret,"tag_fx",param_01);
	playfxontagforclients(var_02.fxid_light1[param_00],self,"tag_fx",param_01);
}

//Function Number: 10
func_62A8(param_00,param_01)
{
	var_02 = level.balldronesettings[self.balldronetype];
	playfxontagforclients(var_02.fxid_light1[param_00],self,"tag_fx",param_01);
	playfxontagforclients(var_02.fxid_light2[param_00],self,"tag_fx1",param_01);
	playfxontagforclients(var_02.fxid_light3[param_00],self,"tag_fx2",param_01);
	playfxontagforclients(var_02.fxid_light4[param_00],self,"tag_fx3",param_01);
}

//Function Number: 11
func_8CD4()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 waittill("spawned_player");
		var_01 = level.balldronesettings[self.balldronetype];
		if(isdefined(var_00))
		{
			if(level.teambased)
			{
				if(var_00.team == self.team)
				{
					self [[ var_01.playfxcallback ]]("friendly",var_00);
				}
				else
				{
					self [[ var_01.playfxcallback ]]("enemy",var_00);
				}

				continue;
			}

			if(var_00 == self.owner)
			{
				self [[ var_01.playfxcallback ]]("friendly",var_00);
				continue;
			}

			self [[ var_01.playfxcallback ]]("enemy",var_00);
		}
	}
}

//Function Number: 12
func_8CFD()
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 waittill("spawned_player");
		var_01 = level.balldronesettings[self.balldronetype];
		if(isdefined(var_00))
		{
			if(level.teambased)
			{
				if(var_00.team == self.team)
				{
					self [[ var_01.playfxcallback ]]("friendly",var_00);
				}
				else
				{
					self [[ var_01.playfxcallback ]]("enemy",var_00);
				}

				continue;
			}

			if(var_00 == self.owner)
			{
				self [[ var_01.playfxcallback ]]("friendly",var_00);
				continue;
			}

			self [[ var_01.playfxcallback ]]("enemy",var_00);
		}
	}
}

//Function Number: 13
func_7AC3(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	switch(param_00.balldronetype)
	{
		case "alien_ball_drone_4":
		case "alien_ball_drone_3":
		case "alien_ball_drone_2":
		case "alien_ball_drone_1":
		case "alien_ball_drone":
		case "ball_drone_backup":
			if(isdefined(param_00.turret) && isdefined(param_00.turret.idletarget))
			{
				param_00 setlookatent(param_00.turret.idletarget);
			}
			else
			{
				param_00 setlookatent(self);
			}
			break;

		default:
			param_00 setlookatent(self);
			break;
	}

	var_01 = (0,0,118);
	param_00 setdronegoalpos(self,var_01);
	param_00 waittill("near_goal");
	param_00 setspeed(param_00.speed,10,10);
	param_00 waittill("goal");
	param_00 thread balldrone_followplayer();
}

//Function Number: 14
balldrone_followplayer()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread balldrone_leave();
	}

	self.owner endon("disconnect");
	self endon("owner_gone");
	self setspeed(self.followspeed,10,10);
	var_00 = (0,0,0);
	var_01 = 4096;
	thread low_entries_watcher();
	for(;;)
	{
		if(isdefined(self.owner) && isalive(self.owner))
		{
			if(self.owner.origin != var_00 && distancesquared(self.owner.origin,var_00) > var_01)
			{
				if(self.balldronetype == "ball_drone_backup" || self.balldronetype == "alien_ball_drone" || self.balldronetype == "alien_ball_drone_1" || self.balldronetype == "alien_ball_drone_2" || self.balldronetype == "alien_ball_drone_3" || self.balldronetype == "alien_ball_drone_4")
				{
					if(!isdefined(self.turret getturrettarget(0)))
					{
						var_00 = self.owner.origin;
						func_127D();
						continue;
					}
				}
				else
				{
					var_00 = self.owner.origin;
					func_127D();
					continue;
				}
			}
		}

		wait(1);
	}
}

//Function Number: 15
func_127D()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("ballDrone_moveToPlayer");
	self endon("ballDrone_moveToPlayer");
	var_00 = 40;
	var_01 = 40;
	var_02 = 118;
	switch(self.owner getstance())
	{
		case "stand":
			var_02 = 118;
			break;

		case "crouch":
			var_02 = 70;
			break;

		case "prone":
			var_02 = 36;
			break;
	}

	if(isdefined(self.low_entry))
	{
		var_02 = var_02 * self.low_entry;
	}

	var_03 = (var_01,var_00,var_02);
	self setdronegoalpos(self.owner,var_03);
	self.intransit = 1;
	thread balldrone_watchforgoal();
}

//Function Number: 16
balldrone_watchforgoal()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("ballDrone_watchForGoal");
	self endon("ballDrone_watchForGoal");
	var_00 = common_scripts\utility::func_8B33("goal","near_goal","hit_goal");
	self.intransit = 0;
	self.inactive = 0;
	self notify("hit_goal");
}

//Function Number: 17
func_62A9()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.stunned) && self.stunned)
		{
			wait(0.5);
			continue;
		}

		if(isdefined(self.inactive) && self.inactive)
		{
			wait(0.5);
			continue;
		}

		if(isdefined(self.radar))
		{
			self.radar moveto(self.origin,0.5);
		}

		wait(0.5);
	}
}

//Function Number: 18
low_entries_watcher()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	var_00 = getentarray("low_entry","targetname");
	while(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			while(self istouching(var_02) || self.owner istouching(var_02))
			{
				if(isdefined(var_02.script_parameters))
				{
					self.low_entry = castfloat(var_02.script_parameters);
					continue;
				}

				self.low_entry = 0.5;
				wait(0.1);
			}

			self.low_entry = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 19
balldrone_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread balldronedestroyed();
}

//Function Number: 20
balldrone_watchtimeout()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	var_00 = level.balldronesettings[self.balldronetype];
	var_01 = var_00.timeout;
	if(maps\mp\_utility::func_47BB() && isdefined(level.ball_drone_alien_timeout_func) && isdefined(self.owner))
	{
		var_01 = self [[ level.ball_drone_alien_timeout_func ]](var_01,self.owner);
	}

	if(!maps\mp\_utility::func_47BB())
	{
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(var_01);
	if(isdefined(self.owner) && !maps\mp\_utility::func_47BB())
	{
		self.owner maps\mp\_utility::func_4D35(var_00.votimedout);
	}

	thread balldrone_leave();
}

//Function Number: 21
balldrone_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner waittill("killstreak_disowned");
	self notify("owner_gone");
	thread balldrone_leave();
}

//Function Number: 22
balldrone_watchownerdeath()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		self.owner waittill("death");
		if(maps\mp\_utility::func_3ABB() && self.owner.pers["deaths"] == maps\mp\_utility::func_3ABB())
		{
			thread balldrone_leave();
		}
	}
}

//Function Number: 23
balldrone_watchroundend()
{
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread balldrone_leave();
}

//Function Number: 24
balldrone_leave()
{
	self endon("death");
	self notify("leaving");
	balldroneexplode();
}

//Function Number: 25
balldrone_handledamage()
{
	maps\mp\gametypes\_damage::func_537B(self.maxhealth,"ball_drone",::handledeathdamage,::modifydamage,1);
}

//Function Number: 26
func_1274()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		maps\mp\gametypes\_damage::func_537C(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"ball_drone",::handledeathdamage,::modifydamage,1);
	}
}

//Function Number: 27
func_1275()
{
	self endon("death");
	level endon("game_ended");
	self maketurretsolid();
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.parent))
		{
			self.parent maps\mp\gametypes\_damage::func_537C(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"ball_drone",::handledeathdamage,::modifydamage,1);
		}
	}
}

//Function Number: 28
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 29
handledeathdamage(param_00,param_01,param_02,param_03)
{
	var_04 = level.balldronesettings[self.balldronetype];
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.vodestroyed);
	if(self.balldronetype == "ball_drone_backup")
	{
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_vulturekiller");
	}
}

//Function Number: 30
func_8CDF()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		balldrone_stunned(var_01);
	}
}

//Function Number: 31
balldrone_stunned(param_00)
{
	self notify("ballDrone_stunned");
	self endon("ballDrone_stunned");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.stunned = 1;
	if(isdefined(level.balldronesettings[self.balldronetype].fxid_sparks))
	{
		playfxontag(level.balldronesettings[self.balldronetype].fxid_sparks,self,"tag_origin");
	}

	if(self.balldronetype == "ball_drone_radar")
	{
		if(isdefined(self.radar))
		{
			self.radar delete();
		}
	}

	if(isdefined(self.turret))
	{
		self.turret notify("turretstatechange");
	}

	wait(param_00);
	self.stunned = 0;
	if(self.balldronetype == "ball_drone_radar")
	{
		var_01 = spawn("script_model",self.origin);
		var_01.team = self.team;
		var_01 makeportableradar(self.owner);
		self.radar = var_01;
	}

	if(isdefined(self.turret))
	{
		self.turret notify("turretstatechange");
	}
}

//Function Number: 32
balldronedestroyed()
{
	if(!isdefined(self))
	{
	}

	balldroneexplode();
}

//Function Number: 33
balldroneexplode()
{
	if(isdefined(level.balldronesettings[self.balldronetype].fxid_explode))
	{
		playfx(level.balldronesettings[self.balldronetype].fxid_explode,self.origin);
	}

	if(isdefined(level.balldronesettings[self.balldronetype].sound_explode))
	{
		self playsound(level.balldronesettings[self.balldronetype].sound_explode);
	}

	self notify("explode");
	func_657A();
}

//Function Number: 34
func_657A()
{
	maps\mp\_utility::decrementfauxvehiclecount();
	if(isdefined(self.radar))
	{
		self.radar delete();
	}

	if(isdefined(self.turret))
	{
		self.turret setturretminimapvisible(0);
		if(isdefined(self.turret.idletarget))
		{
			self.turret.idletarget delete();
		}

		if(isdefined(self.turret.killcament))
		{
			self.turret.killcament delete();
		}

		self.turret delete();
	}

	if(isdefined(self.owner) && isdefined(self.owner.balldrone))
	{
		self.owner.balldrone = undefined;
	}

	self delete();
}

//Function Number: 35
addtoballdronelist()
{
	level.balldrones[self getentitynumber()] = self;
}

//Function Number: 36
func_658A()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.balldrones[var_00] = undefined;
}

//Function Number: 37
exceededmaxballdrones()
{
	if(level.balldrones.size >= maps\mp\_utility::maxvehiclesallowed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
func_1273()
{
	self.vehicle endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self isfiringturret() && isdefined(self.vehicle.stunned) && !self.vehicle.stunned && isdefined(self.vehicle.inactive) && !self.vehicle.inactive)
		{
			self laseron();
			func_2969(level.balldronesettings[self.vehicle.balldronetype].lockontime);
			thread func_1276();
			continue;
		}

		self laseroff();
		thread balldrone_burstfirestop();
	}
}

//Function Number: 39
func_1276()
{
	self.vehicle endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	var_00 = self.vehicle;
	var_01 = weaponfiretime(level.balldronesettings[var_00.balldronetype].weaponinfo);
	var_02 = level.balldronesettings[var_00.balldronetype].burstmin;
	var_03 = level.balldronesettings[var_00.balldronetype].burstmax;
	var_04 = level.balldronesettings[var_00.balldronetype].pausemin;
	var_05 = level.balldronesettings[var_00.balldronetype].pausemax;
	if(maps\mp\_utility::func_47BB() && level.balldronesettings[var_00.balldronetype].weaponinfo == "alien_ball_drone_gun4_mp")
	{
		childthread fire_rocket();
	}

	for(;;)
	{
		var_06 = randomintrange(var_02,var_03 + 1);
		for(var_07 = 0;var_07 < var_06;var_07++)
		{
			if(isdefined(var_00.inactive) && var_00.inactive)
			{
				break;
			}

			var_08 = self getturrettarget(0);
			if(isdefined(var_08) && canbetargeted(var_08))
			{
				var_00 setlookatent(var_08);
				self shootturret();
			}

			wait(var_01);
		}

		wait(randomfloatrange(var_04,var_05));
	}
}

//Function Number: 40
fire_rocket()
{
	for(;;)
	{
		var_00 = self getturrettarget(0);
		if(isdefined(var_00) && canbetargeted(var_00))
		{
			magicbullet("alienvulture_mp",self gettagorigin("tag_flash"),var_00.origin,self.owner);
		}

		var_01 = weaponfiretime("alienvulture_mp");
		if(isdefined(level.ball_drone_faster_rocket_func) && isdefined(self.owner))
		{
			var_01 = self [[ level.ball_drone_faster_rocket_func ]](var_01,self.owner);
		}

		wait(weaponfiretime("alienvulture_mp"));
	}
}

//Function Number: 41
func_2969(param_00)
{
	while(param_00 > 0)
	{
		self playsound(level.balldronesettings[self.vehicle.balldronetype].sound_targeting);
		wait(0.5);
		param_00 = param_00 - 0.5;
	}

	self playsound(level.balldronesettings[self.vehicle.balldronetype].sound_lockon);
}

//Function Number: 42
balldrone_burstfirestop()
{
	self notify("stop_shooting");
	if(isdefined(self.idletarget))
	{
		self.vehicle setlookatent(self.idletarget);
	}
}

//Function Number: 43
canbetargeted(param_00)
{
	var_01 = 1;
	if(isplayer(param_00))
	{
		if(!maps\mp\_utility::func_4945(param_00) || param_00.sessionstate != "playing")
		{
			return 0;
		}
	}

	if(level.teambased && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_00.team) && param_00.team == "spectator")
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 == self.owner)
	{
		return 0;
	}

	if(isplayer(param_00) && isdefined(param_00.var_78C4) && gettime() - param_00.var_78C4 / 1000 <= 5)
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 maps\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > level.balldronesettings[self.vehicle.balldronetype].visual_range_sq)
	{
		return 0;
	}

	var_02 = self gettagorigin("tag_flash");
	return var_01;
}
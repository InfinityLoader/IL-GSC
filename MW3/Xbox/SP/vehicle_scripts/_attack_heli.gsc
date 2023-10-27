/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_attack_heli.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 71
 * Decompile Time: 1219 ms
 * Timestamp: 10/27/2023 2:35:50 AM
*******************************************************************/

//Function Number: 1
func_23F6()
{
	precacheitem("turret_attackheli");
	precacheitem("missile_attackheli");
	attack_heli_fx();
	thread init();
}

//Function Number: 2
attack_heli_fx()
{
	if(getdvarint("sm_enable") && getdvar("r_zfeather") != "0")
	{
		level._effect["_attack_heli_spotlight"] = loadfx("misc/hunted_spotlight_model");
		return;
	}

	level._effect["_attack_heli_spotlight"] = loadfx("misc/spotlight_large");
}

//Function Number: 3
init()
{
	if(isdefined(level.attackheliaiburstsize))
	{
		return;
	}

	while(!isdefined(level.gameskill))
	{
		wait 0.05;
	}

	if(!isdefined(level.cosine))
	{
		level.cosine = [];
	}

	if(!isdefined(level.cosine["25"]))
	{
		level.cosine["25"] = cos(25);
	}

	if(!isdefined(level.cosine["35"]))
	{
		level.cosine["35"] = cos(35);
	}

	if(!isdefined(level.attackhelirange))
	{
		level.attackhelirange = 3500;
	}

	if(!isdefined(level.attackhelikillsai))
	{
		level.attackhelikillsai = 0;
	}

	if(!isdefined(level.attackhelifov))
	{
		level.attackhelifov = cos(30);
	}

	level.attackheliaiburstsize = 1;
	level.var_23FD = 3;
	level.attackhelitargetreaquire = 6;
	level.attackhelimovetime = 3;
	switch(level.gameskill)
	{
		case 0:
			level.attackheliplayerbreak = 9;
			level.attackhelitimeout = 1;
			break;

		case 1:
			level.attackheliplayerbreak = 7;
			level.attackhelitimeout = 2;
			break;

		case 2:
			level.attackheliplayerbreak = 5;
			level.attackhelitimeout = 3;
			break;

		case 3:
			level.attackheliplayerbreak = 3;
			level.attackhelitimeout = 5;
			break;
	}
}

//Function Number: 4
start_attack_heli(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	var_01 = func_2404(var_01);
	return var_01;
}

//Function Number: 5
func_2404(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	if(level.gameskill == 0 || level.gameskill == 1)
	{
		var_02 = spawn("script_origin",param_00.origin + (0,0,-20));
		var_02 linkto(param_00);
		param_00 thread common_scripts\utility::delete_on_death(var_02);
		var_03 = undefined;
		if(level.gameskill == 0)
		{
			var_03 = 2800;
		}
		else
		{
			var_03 = 2200;
		}

		if(!isdefined(param_00.no_attractor))
		{
			param_00.attractor = missile_createattractorent(var_02,var_03,10000,level.player);
			if(maps\_utility::func_E89())
			{
				param_00.attractor2 = missile_createattractorent(var_02,var_03,10000,level.player2);
			}
		}
	}

	param_00 enableaimassist();
	param_00.startingorigin = spawn("script_origin",param_00.origin);
	param_00 thread common_scripts\utility::delete_on_death(param_00.startingorigin);
	if(!isdefined(param_00.circling))
	{
		param_00.circling = 0;
	}

	param_00.allowshoot = 1;
	param_00.var_240B = 0;
	param_00.moving = 1;
	param_00.istakingdamage = 0;
	param_00.var_240E = undefined;
	param_00 thread notify_disable();
	param_00 thread notify_enable();
	thread kill_heli_logic(param_00,param_01);
	param_00.turrettype = undefined;
	param_00 func_2415();
	param_00 thread detect_player_death();
	switch(param_00.vehicletype)
	{
		case "ny_harbor_hind":
		case "hind":
			param_00.turrettype = "default";
			break;

		case "mi28":
			param_00.turrettype = "default";
			break;

		case "littlebird":
			param_00 setyawspeed(90,30,20);
			param_00 setmaxpitchroll(40,40);
			param_00 sethoverparams(100,20,5);
			param_00 setup_miniguns();
			break;

		default:
			break;
	}

	param_00.etarget = param_00.targetdefault;
	if(isdefined(param_00.script_spotlight) && param_00.script_spotlight == 1 && !isdefined(param_00.spotlight))
	{
		param_00 thread heli_spotlight_on(undefined,1);
	}

	param_00 thread func_245B();
	return param_00;
}

//Function Number: 6
detect_player_death()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	}

	maps\_utility::do_wait_any();
	self notify("heli_players_dead");
}

//Function Number: 7
func_2415()
{
	var_00 = undefined;
	var_01 = undefined;
	switch(self.vehicletype)
	{
		case "ny_harbor_hind":
		case "hind":
			var_01 = 600;
			var_00 = -100;
			break;

		case "mi28":
			var_01 = 600;
			var_00 = -100;
			break;

		case "littlebird":
			var_01 = 600;
			var_00 = -204;
			break;

		default:
			break;
	}

	self.targetdefault = spawn("script_origin",self.origin);
	self.targetdefault.angles = self.angles;
	self.targetdefault.origin = self.origin;
	var_02 = spawnstruct();
	var_02.entity = self.targetdefault;
	var_02.forward = var_01;
	var_02.up = var_00;
	var_02 maps\_utility::translate_local();
	self.targetdefault linkto(self);
	self.targetdefault thread func_241B(self);
}

//Function Number: 8
func_2416()
{
	if(isdefined(self.turrets))
	{
		return self.turrets;
	}

	setup_miniguns();
	return self.turrets;
}

//Function Number: 9
setup_miniguns()
{
	self.turrettype = "miniguns";
	self.var_2419 = 0;
	self.var_241A = 0;
	if(!isdefined(self.mgturret))
	{
		return;
	}

	self.turrets = self.mgturret;
	common_scripts\utility::array_thread(self.turrets,::littlebird_turrets_think,self);
}

//Function Number: 10
func_241B(param_00)
{
	param_00 common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 11
func_241C(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	var_02.startingorigin = spawn("script_origin",var_02.origin);
	var_02 thread common_scripts\utility::delete_on_death(var_02.startingorigin);
	var_02.circling = 1;
	var_02.allowshoot = 1;
	var_02.var_240B = 0;
	var_02 thread notify_disable();
	var_02 thread notify_enable();
	thread kill_heli_logic(var_02,param_01);
	return var_02;
}

//Function Number: 12
kill_heli_logic(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
		param_00.allowshoot = 1;
		param_00.var_240B = 0;
		param_00 thread notify_disable();
		param_00 thread notify_enable();
	}

	var_02 = undefined;
	if(!isdefined(param_00.script_airspeed))
	{
		var_02 = 40;
	}
	else
	{
		var_02 = param_00.script_airspeed;
	}

	if(!isdefined(level.enemy_heli_killed))
	{
		level.enemy_heli_killed = 0;
	}

	if(!isdefined(level.commander_speaking))
	{
		level.commander_speaking = 0;
	}

	if(!isdefined(level.var_2421))
	{
		level.var_2421 = 0;
	}

	level.attack_heli_safe_volumes = undefined;
	var_03 = getentarray("attack_heli_safe_volume","script_noteworthy");
	if(var_03.size > 0)
	{
		level.attack_heli_safe_volumes = var_03;
	}

	if(!level.enemy_heli_killed)
	{
		thread func_244E(param_00);
	}

	if(!isdefined(param_00.var_2423))
	{
		switch(param_00.vehicletype)
		{
			case "mi28":
				target_set(param_00,(0,0,-80));
				break;

			case "ny_harbor_hind":
			case "hind":
				target_set(param_00,(0,0,-96));
				break;

			case "littlebird":
				target_set(param_00,(0,0,-80));
				break;

			default:
				break;
		}

		target_setjavelinonly(param_00,1);
	}

	param_00 thread func_2447();
	param_00 thread func_244D();
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	param_00 endon("returning_home");
	param_00 setvehweapon("turret_attackheli");
	if(!isdefined(param_00.circling))
	{
		param_00.circling = 0;
	}

	if(!param_00.circling)
	{
		param_00 setneargoalnotifydist(100);
		if(!isdefined(param_00.dontwaitforpathend))
		{
			param_00 waittill("reached_dynamic_path_end");
		}
	}
	else
	{
		param_00 setneargoalnotifydist(500);
		param_00 waittill("near_goal");
	}

	param_00 thread heli_shoot_think();
	if(param_00.circling)
	{
		param_00 thread heli_circling_think(param_01,var_02);
		return;
	}

	param_00 thread heli_goal_think(var_02);
}

//Function Number: 13
heli_circling_think(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "attack_heli_circle_node";
	}

	var_02 = getentarray(param_00,"targetname");
	if(!isdefined(var_02) || var_02.size < 1)
	{
		var_02 = common_scripts\utility::getstructarray(param_00,"targetname");
	}

	var_03 = self;
	var_03 endon("stop_circling");
	var_03 endon("death");
	var_03 endon("returning_home");
	var_03 endon("heli_players_dead");
	for(;;)
	{
		var_03 vehicle_setspeed(param_01,param_01 / 4,param_01 / 4);
		var_03 setneargoalnotifydist(100);
		var_04 = maps\_utility::func_218B(var_03.origin);
		var_05 = var_04.origin;
		var_03 setlookatent(var_04);
		var_06 = maps\_utility::getclosest(var_05,var_02);
		var_07 = getentarray(var_06.target,"targetname");
		if(!isdefined(var_07) || var_07.size < 1)
		{
			var_07 = common_scripts\utility::getstructarray(var_06.target,"targetname");
		}

		var_08 = var_07[randomint(var_07.size)];
		var_03 setvehgoalpos(var_08.origin,1);
		var_03 waittill("near_goal");
		if(!isdefined(var_04.var_1DDB))
		{
			wait 1;
			wait randomfloatrange(0.8,1.3);
		}
	}
}

//Function Number: 14
heli_goal_think(param_00)
{
	self endon("death");
	var_01 = getentarray("kill_heli_spot","targetname");
	var_02 = self;
	var_03 = maps\_utility::getclosest(var_02.origin,var_01);
	var_04 = var_03;
	var_02 endon("death");
	var_02 endon("returning_home");
	var_02 endon("heli_players_dead");
	var_05 = undefined;
	for(;;)
	{
		wait 0.05;
		var_02 vehicle_setspeed(param_00,param_00 / 2,param_00 / 10);
		var_02 setneargoalnotifydist(100);
		var_06 = maps\_utility::func_218B(var_02.origin);
		var_07 = var_06.origin;
		if(var_03 == var_04 && var_02.istakingdamage)
		{
			var_08 = func_2446(var_02,var_03,var_01,var_06,var_07);
			var_03 = maps\_utility::getclosest(var_07,var_08);
		}

		var_02 setvehgoalpos(var_03.origin,1);
		var_02.moving = 1;
		var_06 = maps\_utility::func_218B(var_02.origin);
		if(isdefined(self.etarget) && isdefined(self.etarget.classname) && self.etarget.classname == "script_origin")
		{
			var_05 = var_06;
		}
		else if(isdefined(self.etarget))
		{
			var_05 = self.etarget;
		}
		else
		{
			var_05 = self.targetdefault;
		}

		var_02 setlookatent(var_05);
		var_02 waittill("near_goal");
		var_02.moving = 0;
		if(!maps\_utility::func_E89())
		{
			if(level.gameskill == 0 || level.gameskill == 1)
			{
				while(player_is_aiming_with_rocket(var_02))
				{
					wait 0.5;
				}

				wait 3;
			}
		}

		var_06 = maps\_utility::func_218B(var_02.origin);
		var_07 = var_06.origin;
		var_08 = func_2446(var_02,var_03,var_01,var_06,var_07);
		var_08[var_08.size] = var_03;
		var_04 = var_03;
		var_09 = maps\_utility::getclosest(var_07,var_01);
		var_0A = maps\_utility::getclosest(var_07,var_08);
		foreach(var_0C in var_08)
		{
			if(var_06 sightconetrace(var_0C.origin,var_02) != 1)
			{
				var_08 = common_scripts\utility::array_remove(var_08,var_0C);
				continue;
			}
		}

		var_0E = maps\_utility::getclosest(var_07,var_08);
		if(var_08.size < 2)
		{
			var_03 = var_0A;
		}
		else if(var_0E != var_09)
		{
			var_03 = var_0E;
		}
		else
		{
			var_0F = [];
			var_09 = maps\_utility::get_array_of_closest(var_08,var_09,var_41,2);
			var_10 = randomint(var_09.size);
			if(randomint(100) > 50)
			{
				var_04 = var_09[var_10];
			}
			else
			{
				var_04 = var_0A;
			}
		}

		var_0F = randomfloatrange(level.attackhelimovetime - 0.5,level.attackhelimovetime + 0.5);
		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",var_0F);
	}
}

//Function Number: 15
player_is_aiming_with_rocket(param_00)
{
	if(!level.player func_2450())
	{
		return 0;
	}

	if(!level.player adsbuttonpressed())
	{
		return 0;
	}

	var_01 = level.player geteye();
	if(sighttracepassed(var_01,param_00.origin,0,level.player))
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
heli_shoot_think()
{
	self endon("stop_shooting");
	self endon("death");
	self endon("heli_players_dead");
	thread func_2432();
	var_00 = level.attackhelirange * level.attackhelirange;
	level.var_2429 = 0;
	while(isdefined(self))
	{
		wait randomfloatrange(0.8,1.3);
		if(!heli_has_target() || !heli_has_player_target())
		{
			var_01 = heli_get_target_player_only();
			if(isplayer(var_01))
			{
				self.etarget = var_01;
			}
		}

		if(heli_has_player_target() && level.players.size > 1)
		{
			var_02 = maps\_utility::func_218B(self.origin);
			if(self.etarget != var_02)
			{
				var_01 = heli_get_target_player_only();
				if(isplayer(var_01))
				{
					self.etarget = var_01;
				}
			}
		}

		if(heli_has_player_target())
		{
			if(!heli_can_see_target() || level.var_2429 == 1)
			{
				var_01 = heli_get_target_ai_only();
				self.etarget = var_01;
			}
		}

		if(isdefined(self.var_240E) && isplayer(self.var_240E))
		{
			self.etarget = self.var_240E;
		}
		else if(!heli_has_target())
		{
			var_01 = heli_get_target_ai_only();
			self.etarget = var_01;
		}

		if(!heli_has_target())
		{
			continue;
		}

		if(self.etarget func_244B(self))
		{
			continue;
		}

		if(heli_has_target() && distancesquared(self.etarget.origin,self.origin) > var_00)
		{
			continue;
		}

		if(self.turrettype == "default" && heli_has_player_target())
		{
			func_2444(self.etarget);
			wait randomfloatrange(0.8,1.3);
			func_2444(self.etarget);
			wait randomfloatrange(0.8,1.3);
			while(can_see_player(self.etarget) && !self.etarget func_244B(self))
			{
				fire_guns();
				wait randomfloatrange(2,4);
			}

			continue;
		}

		if(isplayer(self.etarget) || isai(self.etarget))
		{
			fire_guns();
		}

		if(isplayer(self.etarget))
		{
			thread player_grace_period(self);
		}

		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.attackhelitargetreaquire);
	}
}

//Function Number: 17
player_grace_period(param_00)
{
	level notify("player_is_heli_target");
	level endon("player_is_heli_target");
	level.var_2429 = 1;
	param_00 common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.attackheliplayerbreak);
	level.var_2429 = 0;
}

//Function Number: 18
heli_can_see_target()
{
	if(!isdefined(self.etarget))
	{
		return 0;
	}

	var_00 = self.etarget.origin + (0,0,32);
	if(isplayer(self.etarget))
	{
		var_00 = self.etarget geteye();
	}

	var_01 = self gettagorigin("tag_flash");
	var_02 = sighttracepassed(var_01,var_00,0,self);
	return var_02;
}

//Function Number: 19
heli_has_player_target()
{
	if(!isdefined(self.etarget))
	{
		return 0;
	}

	if(isplayer(self.etarget))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
heli_has_target()
{
	if(!isdefined(self.etarget))
	{
		return 0;
	}

	if(!isalive(self.etarget))
	{
		return 0;
	}

	if(self.etarget == self.targetdefault)
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_242E()
{
	var_00 = maps\_helicopter_globals::getenemytarget(level.attackhelirange,level.attackhelifov,1,1,0,1,level.var_242F);
	if(isdefined(var_00) && isplayer(var_00))
	{
		var_00 = self.targetdefault;
	}

	if(!isdefined(var_00))
	{
		var_00 = self.targetdefault;
	}

	return var_00;
}

//Function Number: 22
heli_get_target_player_only()
{
	var_00 = getaiarray("allies");
	var_01 = maps\_helicopter_globals::getenemytarget(level.attackhelirange,level.attackhelifov,1,0,0,0,var_00);
	if(!isdefined(var_01))
	{
		var_01 = self.targetdefault;
	}

	return var_01;
}

//Function Number: 23
heli_get_target_ai_only()
{
	var_00 = maps\_helicopter_globals::getenemytarget(level.attackhelirange,level.attackhelifov,1,1,0,1,level.players);
	if(!isdefined(var_00))
	{
		var_00 = self.targetdefault;
	}

	return var_00;
}

//Function Number: 24
func_2432()
{
	if(!isdefined(self.var_2433))
	{
		return;
	}

	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_shooting");
	var_00 = undefined;
	var_01 = "turret_attackheli";
	var_02 = "missile_attackheli";
	var_03 = undefined;
	var_04 = undefined;
	var_05 = [];
	switch(self.vehicletype)
	{
		case "mi28":
			var_00 = 1;
			var_03 = 1;
			var_04 = 0.5;
			break;
	var_41[7]
	"tag_store_R_2_d"
	var_41[6]
	"tag_store_L_2_d"
	var_41[5]
	"tag_store_R_2_c"
	var_41[4]
	"tag_store_L_2_c"
	var_41[3]
	"tag_store_R_2_b"
	var_41[2]
	"tag_store_L_2_b"
	var_41[1]
	"tag_store_R_2_a"
	var_41[0]
	"tag_store_L_2_a"
			break;

		case "littlebird":
			var_01 = 1;
			var_04 = 1;
			var_05 = 0.5;
			break;
	var_41[1]
	"tag_missile_right"
	var_41[0]
	"tag_missile_left"
			break;

		default:
			break;
	}

	var_06 = -1;
	for(;;)
	{
		wait 0.05;
		self waittill("fire_missiles",var_07);
		if(!isplayer(var_07))
		{
			continue;
		}

		var_08 = var_07;
		if(!func_2434(var_08))
		{
			continue;
		}

		for(var_09 = 0;var_09 < var_01;var_09++)
		{
			var_06++;
			if(var_06 >= var_41.size)
			{
				var_06 = 0;
			}

			self setvehweapon(var_03);
			self.var_240B = 1;
			var_0A = self fireweapon(var_41[var_06],var_08);
			var_0A thread func_23F5(var_05);
			var_0A thread func_2435();
			if(var_09 < var_01 - 1)
			{
				wait var_04;
			}
		}

		self.var_240B = 0;
		self setvehweapon(var_02);
		wait 10;
	}
}

//Function Number: 25
func_2434(param_00)
{
	if(self.moving)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_2435()
{
	if(distancesquared(self.origin,level.player.origin) > 9000000)
	{
		return;
	}

	var_00 = self.origin;
	while(isdefined(self))
	{
		var_00 = self.origin;
		wait 0.1;
	}

	earthquake(0.7,1.5,var_00,1600);
}

//Function Number: 27
func_23F5(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	wait param_00;
	if(isdefined(self))
	{
		self missile_cleartarget();
	}
}

//Function Number: 28
get_different_player(param_00)
{
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(param_00 != level.players[var_01])
		{
			return level.players[var_01];
		}
	}

	return level.players[0];
}

//Function Number: 29
notify_disable()
{
	self notify("notify_disable_thread");
	self endon("notify_disable_thread");
	self endon("death");
	self endon("heli_players_dead");
	for(;;)
	{
		self waittill("disable_turret");
		self.allowshoot = 0;
	}
}

//Function Number: 30
notify_enable()
{
	self notify("notify_enable_thread");
	self endon("notify_enable_thread");
	self endon("death");
	self endon("heli_players_dead");
	for(;;)
	{
		self waittill("enable_turret");
		self.allowshoot = 1;
	}
}

//Function Number: 31
fire_guns()
{
	switch(self.turrettype)
	{
		case "default":
			var_00 = randomintrange(5,10);
			var_01 = weaponfiretime("turret_attackheli");
			turret_default_fire(self.etarget,var_00,var_01);
			break;

		case "miniguns":
			var_00 = func_243A(self.etarget);
			if(self.allowshoot && !self.var_240B)
			{
				turret_minigun_fire(self.etarget,var_00);
			}
			break;

		default:
			break;
	}
}

//Function Number: 32
func_243A(param_00)
{
	var_01 = undefined;
	if(!isplayer(param_00))
	{
		var_01 = level.attackheliaiburstsize;
		return var_01;
	}

	switch(level.gameskill)
	{
		case 3:
		case 2:
		case 1:
		case 0:
			var_01 = randomintrange(2,3);
			break;
	}

	return var_01;
}

//Function Number: 33
func_243B(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	wait param_00;
	if(!isplayer(self.etarget))
	{
		return;
	}

	self notify("fire_missiles",self.etarget);
}

//Function Number: 34
turret_default_fire(param_00,param_01,param_02)
{
	thread func_243B(randomfloatrange(0.2,2));
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		self setturrettargetent(param_00,common_scripts\utility::randomvector(50) + (0,0,32));
		if(self.allowshoot && !self.var_240B)
		{
			self fireweapon();
		}

		wait param_02;
	}
}

//Function Number: 35
turret_minigun_fire(param_00,param_01,param_02)
{
	self endon("death");
	self endon("heli_players_dead");
	self notify("firing_miniguns");
	self endon("firing_miniguns");
	var_03 = func_2416();
	common_scripts\utility::array_thread(var_03,::func_2440,param_00,self);
	if(!self.var_2419)
	{
		self.var_241A = 1;
		thread maps\_utility::play_sound_on_tag("littlebird_gatling_spinup","tag_flash");
		wait 2.1;
		thread maps\_utility::play_loop_sound_on_tag("littlebird_minigun_spinloop","tag_flash");
	}

	self.var_2419 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	var_04 = 0.5;
	if(var_04 > param_02)
	{
		var_04 = param_02;
	}

	if(var_04 > 0)
	{
		wait randomfloatrange(var_04,param_02);
	}

	minigun_fire(param_00,param_01);
	var_03 = func_2416();
	common_scripts\utility::array_call(var_03,::stopfiring);
	thread minigun_spindown(param_00);
	self notify("stopping_firing");
}

//Function Number: 36
minigun_fire(param_00,param_01)
{
	self endon("death");
	self endon("heli_players_dead");
	if(isplayer(param_00))
	{
		self endon("cant_see_player");
	}

	var_02 = func_2416();
	common_scripts\utility::array_call(var_02,::startfiring);
	wait randomfloatrange(1,2);
	if(isplayer(param_00))
	{
		thread target_track(param_00);
	}

	if(isplayer(param_00))
	{
		var_03 = randomfloatrange(0.5,3);
		thread func_243B(var_03);
	}

	wait param_01;
}

//Function Number: 37
target_track(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stopping_firing");
	self notify("tracking_player");
	self endon("tracking_player");
	for(;;)
	{
		if(!can_see_player(param_00))
		{
			break;
		}

		wait 0.5;
	}

	wait level.attackhelitimeout;
	self notify("cant_see_player");
}

//Function Number: 38
func_2440(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("heli_players_dead");
	self notify("miniguns_have_new_target");
	self endon("miniguns_have_new_target");
	if(!isplayer(param_00) && isai(param_00) && level.attackhelikillsai == 0)
	{
		var_02 = spawn("script_origin",param_00.origin + (0,0,100));
		var_02 linkto(param_00);
		thread minigun_ai_target_cleanup(var_02);
		param_00 = var_02;
	}

	for(;;)
	{
		wait 0.5;
		self settargetentity(param_00);
	}
}

//Function Number: 39
minigun_ai_target_cleanup(param_00)
{
	common_scripts\utility::waittill_either("death","miniguns_have_new_target");
	param_00 delete();
}

//Function Number: 40
minigun_spindown(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("firing_miniguns");
	if(isplayer(param_00))
	{
		wait randomfloatrange(3,4);
	}
	else
	{
		wait randomfloatrange(1,2);
	}

	thread func_2443();
	self.var_241A = 0;
}

//Function Number: 41
func_2443()
{
	self notify("stop soundlittlebird_minigun_spinloop");
	self.var_2419 = 0;
	maps\_utility::play_sound_on_tag("littlebird_gatling_cooldown","tag_flash");
}

//Function Number: 42
func_2444(param_00)
{
	var_01 = anglestoforward(level.player.angles);
	var_02 = var_01 * 400;
	var_03 = var_02 + common_scripts\utility::randomvector(50);
	var_04 = randomintrange(10,20);
	var_05 = weaponfiretime("turret_attackheli");
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		var_03 = var_02 + common_scripts\utility::randomvector(50);
		self setturrettargetent(param_00,var_03);
		if(self.allowshoot)
		{
			self fireweapon();
		}

		wait var_05;
	}
}

//Function Number: 43
can_see_player(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	var_01 = self gettagorigin("tag_flash");
	if(sighttracepassed(var_01,param_00 geteye(),0,undefined))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_2446(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_06 = strtok(param_01.script_linkto," ");
	for(var_07 = 0;var_07 < param_02.size;var_07++)
	{
		for(var_08 = 0;var_08 < var_06.size;var_08++)
		{
			if(param_02[var_07].script_linkname == var_06[var_08])
			{
				var_05[var_05.size] = param_02[var_07];
			}
		}
	}

	foreach(var_0A in var_05)
	{
		if(var_0A.origin[2] < param_04[2])
		{
			var_05 = common_scripts\utility::array_remove(var_05,var_0A);
			continue;
		}
	}

	return var_05;
}

//Function Number: 45
func_2447()
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("crashing");
	self endon("leaving");
	self.damagetaken = 0;
	self.seen_attacker = undefined;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		self notify("damage_by_player");
		thread heli_damage_update();
		thread func_244A(var_01);
		if(maps\_utility::is_damagefeedback_enabled())
		{
			var_01 thread updatedamagefeedback();
		}
	}
}

//Function Number: 46
heli_damage_update()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self endon("heli_players_dead");
	self.istakingdamage = 1;
	wait 1;
	self.istakingdamage = 0;
}

//Function Number: 47
func_244A(param_00)
{
	self notify("attacker_seen");
	self endon("attacker_seen");
	self.seen_attacker = param_00;
	self.var_240E = param_00;
	wait level.var_23FD;
	self.var_240E = undefined;
	self.seen_attacker = undefined;
}

//Function Number: 48
func_244B(param_00)
{
	if(isdefined(param_00.seen_attacker))
	{
		if(param_00.seen_attacker == self)
		{
			return 0;
		}
	}

	if(isdefined(level.attack_heli_safe_volumes))
	{
		foreach(var_02 in level.attack_heli_safe_volumes)
		{
			if(self istouching(var_02))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 49
updatedamagefeedback()
{
	if(!isplayer(self))
	{
		return;
	}

	self.hud_damagefeedback setshader("damage_feedback",24,48);
	self playlocalsound("player_feedback_hit_alert");
	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeovertime(1);
	self.hud_damagefeedback.alpha = 0;
}

//Function Number: 50
func_244C()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.hud_damagefeedback = newclienthudelem(var_01);
		var_01.hud_damagefeedback.horzalign = "center";
		var_01.hud_damagefeedback.vertalign = "middle";
		var_01.hud_damagefeedback.x = -12;
		var_01.hud_damagefeedback.y = -12;
		var_01.hud_damagefeedback.alpha = 0;
		var_01.hud_damagefeedback.archived = 1;
		var_01.hud_damagefeedback setshader("damage_feedback",24,48);
	}
}

//Function Number: 51
func_244D()
{
	self waittill("death");
	level notify("attack_heli_destroyed");
	level.enemy_heli_killed = 1;
	wait 15;
	level.var_2421 = 0;
}

//Function Number: 52
func_244E(param_00)
{
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	wait 30;
	if(!level.var_2421)
	{
		return;
	}

	func_244F("co_cf_cmd_heli_small_fire");
	if(!level.var_2421)
	{
		return;
	}

	func_244F("co_cf_cmd_rpg_stinger");
	wait 30;
	if(!level.var_2421)
	{
		return;
	}

	func_244F("co_cf_cmd_heli_wonders");
}

//Function Number: 53
func_244F(param_00)
{
	while(level.commander_speaking)
	{
		wait 1;
	}

	level.commander_speaking = 1;
	level.player playsound(param_00,"sounddone");
	level.player waittill("sounddone");
	wait 0.5;
	level.commander_speaking = 0;
}

//Function Number: 54
func_2450()
{
	var_00 = self getcurrentweapon();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(issubstr(tolower(var_00),"rpg"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"stinger"))
	{
		return 1;
	}

	if(issubstr(tolower(var_00),"at4"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
func_2451(param_00)
{
	common_scripts\utility::waittill_any("death","crash_done","turn_off_spotlight");
	self.spotlight = undefined;
	if(isdefined(self))
	{
		stopfxontag(common_scripts\utility::func_539("_attack_heli_spotlight"),self,param_00);
	}
}

//Function Number: 56
func_2452()
{
	self endon("death");
	self endon("heli_players_dead");
	if(self.vehicletype != "littlebird")
	{
		return;
	}

	thread heli_spotlight_think();
	var_00 = undefined;
	for(;;)
	{
		wait 0.05;
		switch(self.vehicletype)
		{
			case "littlebird":
				var_00 = self.var_2453;
				break;
	
			default:
				var_00 = self.etarget;
				break;
		}

		if(isdefined(var_00))
		{
			self setturrettargetent(var_00,(0,0,0));
		}
	}
}

//Function Number: 57
heli_spotlight_think()
{
	self endon("death");
	self endon("heli_players_dead");
	var_00 = self.targetdefault;
	var_00.targetname = "original_ent";
	self.left_ent = spawn("script_origin",var_00.origin);
	self.left_ent.origin = var_00.origin;
	self.left_ent.angles = var_00.angles;
	self.left_ent.targetname = "left_ent";
	self.right_ent = spawn("script_origin",var_00.origin);
	self.right_ent.origin = var_00.origin;
	self.right_ent.angles = var_00.angles;
	self.right_ent.targetname = "right_ent";
	var_01 = spawnstruct();
	var_01.entity = self.left_ent;
	var_01.right = 250;
	var_01 maps\_utility::translate_local();
	self.left_ent linkto(self);
	var_02 = spawnstruct();
	var_02.entity = self.right_ent;
	var_02.right = -250;
	var_02 maps\_utility::translate_local();
	self.right_ent linkto(self);
	var_03 = [];
	self.var_2453 = var_01;
	common_scripts\utility::array_thread(var_41,::func_2458,self);
	for(;;)
	{
		wait randomfloatrange(1,3);
		if(heli_has_player_target() && !within_player_fov())
		{
			self.var_2453 = self.etarget;
			continue;
		}

		var_04 = randomint(var_41.size);
		self.targetdefault = var_41[var_04];
		self.var_2453 = self.targetdefault;
	}
}

//Function Number: 58
within_player_fov()
{
	self endon("death");
	self endon("heli_players_dead");
	if(!isdefined(self.etarget))
	{
		return 0;
	}

	if(!isplayer(self.etarget))
	{
		return 0;
	}

	var_00 = self.etarget;
	var_01 = maps\_utility::within_fov(var_00 geteye(),var_00 getplayerangles(),self.origin,level.cosine["35"]);
	return var_01;
}

//Function Number: 59
func_2458(param_00)
{
	param_00 common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 60
littlebird_turrets_think(param_00)
{
	var_01 = self;
	var_01 maps\_vehicle::func_245A("manual");
	if(isdefined(param_00.targetdefault))
	{
		var_01 settargetentity(param_00.targetdefault);
	}

	var_01 setmode("manual");
	param_00 waittill("death");
	if(isdefined(param_00.var_241A) && param_00.var_241A == 1)
	{
		thread func_2443();
	}
}

//Function Number: 61
func_245B()
{
	common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self.attractor))
	{
		missile_deleteattractor(self.attractor);
	}

	if(isdefined(self.attractor2))
	{
		missile_deleteattractor(self.attractor2);
	}
}

//Function Number: 62
func_245C(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_default_heli_missiles");
	self.preferredtarget = undefined;
	while(isdefined(self))
	{
		wait 0.05;
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		self.preferredtarget = undefined;
		var_04 = undefined;
		if(isdefined(self.currentnode) && isdefined(self.currentnode.target))
		{
			var_04 = maps\_utility::func_2373(self.currentnode.target,"targetname");
		}

		if(isdefined(var_04) && isdefined(var_04.script_linkto))
		{
			self.preferredtarget = maps\_utility::func_2373(var_04.script_linkto,"script_linkname");
		}

		if(isdefined(self.preferredtarget))
		{
			var_01 = self.preferredtarget;
			var_02 = var_01.script_shotcount;
			var_03 = var_01.script_delay;
			var_04 waittill("trigger");
			continue;
		}

		common_scripts\utility::waittill_any("near_goal","goal");
		if(isdefined(var_01))
		{
			thread func_2464(var_01,var_02,var_03,param_00);
		}
	}
}

//Function Number: 63
heli_default_missiles_off()
{
	self notify("stop_default_heli_missiles");
}

//Function Number: 64
heli_spotlight_on(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "tag_barrel";
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	playfxontag(common_scripts\utility::func_539("_attack_heli_spotlight"),self,param_00);
	self.spotlight = 1;
	thread func_2451(param_00);
	if(param_01)
	{
		self endon("death");
		self endon("heli_players_dead");
		var_02 = self gettagorigin("tag_origin");
		if(!isdefined(self.targetdefault))
		{
			func_2415();
		}

		self setturrettargetent(self.targetdefault);
		thread func_2452();
	}
}

//Function Number: 65
heli_spotlight_off()
{
	self notify("turn_off_spotlight");
}

//Function Number: 66
heli_spotlight_random_targets_on()
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_spotlight_random_targets");
	if(!isdefined(self.targetdefault))
	{
		thread func_2415();
	}

	if(!isdefined(self.left_ent))
	{
		thread heli_spotlight_think();
	}

	while(isdefined(self))
	{
		wait 0.05;
		self setturrettargetent(self.targetdefault,(0,0,0));
	}
}

//Function Number: 67
heli_spotlight_random_targets_off()
{
	self notify("stop_spotlight_random_targets");
}

//Function Number: 68
func_2464(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("heli_players_dead");
	if(isdefined(self.var_2465))
	{
		var_04 = self.var_2465;
	}
	else
	{
		var_04 = "turret_attackheli";
	}

	var_05 = "missile_attackheli";
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	var_06 = undefined;
	var_07 = [];
	self setvehweapon(var_04);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_00.classname))
	{
		if(!isdefined(self.var_2466))
		{
			self.var_2466 = spawn("script_origin",param_00.origin);
			thread common_scripts\utility::delete_on_death(self.var_2466);
		}

		self.var_2466.origin = param_00.origin;
		param_00 = self.var_2466;
	}

	switch(self.vehicletype)
	{
		case "mi28":
			var_06 = 0.5;
			break;
	var_41[7]
	"tag_store_R_2_d"
	var_41[6]
	"tag_store_L_2_d"
	var_41[5]
	"tag_store_R_2_c"
	var_41[4]
	"tag_store_L_2_c"
	var_41[3]
	"tag_store_R_2_b"
	var_41[2]
	"tag_store_L_2_b"
	var_41[1]
	"tag_store_R_2_a"
	var_41[0]
	"tag_store_L_2_a"
			break;

		case "littlebird":
			var_07 = 0.5;
			break;
	var_41[1]
	"tag_missile_right"
	var_41[0]
	"tag_missile_left"
			break;

		default:
			break;
	}

	var_08 = -1;
	for(var_09 = 0;var_09 < param_02;var_09++)
	{
		var_08++;
		if(var_08 >= var_41.size)
		{
			var_08 = 0;
		}

		self setvehweapon(var_06);
		self.var_240B = 1;
		var_0A = self fireweapon(var_41[var_08],param_01);
		var_0A thread func_2435();
		if(var_09 < param_02 - 1)
		{
			wait param_03;
		}
	}

	self.var_240B = 0;
	self setvehweapon(var_05);
}

//Function Number: 69
boneyard_style_heli_missile_attack()
{
	self waittill("trigger",var_00);
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_01 = maps\_utility::func_236E(var_01);
	boneyard_fire_at_targets(var_00,var_01);
}

//Function Number: 70
func_2468()
{
	self waittill("trigger",var_00);
	var_01 = maps\_utility::get_linked_structs();
	var_01 = maps\_utility::func_236E(var_01);
	boneyard_fire_at_targets(var_00,var_01);
}

//Function Number: 71
boneyard_fire_at_targets(param_00,param_01)
{
	var_02 = [];
	if(level.script == "roadkill")
	{
	}

	if(param_01.vehicletype == "cobra")
	{
	}

	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++ = var_41[1])
	{
		var_03[var_04] = spawn("script_origin",var_02[var_04].origin);
		param_01 setvehweapon("littlebird_FFAR");
		param_01 setturrettargetent(var_03[var_04]);
		var_05 = param_01 fireweapon(var_41[var_04 % var_41.size],var_03[var_04],(0,0,0));
		var_05 common_scripts\utility::delaycall(1,::missile_cleartarget);
		wait randomfloatrange(0.2,0.3);
	}

	wait 2;
	foreach(var_07 in var_03)
	{
		var_07 delete();
	}
}
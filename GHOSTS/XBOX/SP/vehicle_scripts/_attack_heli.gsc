/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_attack_heli.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 73
 * Decompile Time: 1220 ms
 * Timestamp: 10/27/2023 1:38:15 AM
*******************************************************************/

//Function Number: 1
preload()
{
	precacheitem("turret_attackheli");
	precacheitem("missile_attackheli");
	attack_heli_fx();
	thread func_44DF();
}

//Function Number: 2
attack_heli_fx()
{
	if(getdvarint("sm_enable") && getdvar("r_zfeather") != "0")
	{
		level._effect["_attack_heli_spotlight"] = loadfx("fx/misc/hunted_spotlight_model");
	}

	level._effect["_attack_heli_spotlight"] = loadfx("fx/misc/spotlight_large");
}

//Function Number: 3
func_44DF()
{
	if(isdefined(level.var_1009))
	{
	}

	while(!isdefined(level.gameskill))
	{
		wait(0.05);
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

	level.var_1009 = 1;
	level.attackhelimemory = 3;
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
func_79FC(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_01 = maps\_vehicle::func_784F(param_00);
	var_01 = func_13B9(var_01);
	return var_01;
}

//Function Number: 5
func_13B9(param_00,param_01)
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

		if(!isdefined(param_00.var_5615))
		{
			param_00.attractor = missilecreateattractorent(var_02,var_03,10000,level.player);
			if(maps\_utility::func_47D0())
			{
				param_00.attractor2 = missilecreateattractorent(var_02,var_03,10000,level.var_5D60);
			}
		}
	}

	param_00 enableaimassist();
	param_00.var_7ADB = spawn("script_origin",param_00.origin);
	param_00 thread common_scripts\utility::delete_on_death(param_00.var_7ADB);
	if(!isdefined(param_00.circling))
	{
		param_00.circling = 0;
	}

	param_00.allowshoot = 1;
	param_00.var_3346 = 0;
	param_00.moving = 1;
	param_00.var_497C = 0;
	param_00.var_40E1 = undefined;
	param_00 thread func_5705();
	param_00 thread notify_enable();
	thread kill_heli_logic(param_00,param_01);
	param_00.turrettype = undefined;
	param_00 func_40AD();
	param_00 thread detect_player_death();
	switch(param_00.vehicletype)
	{
		case "ny_harbor_hind":
		case "hind_blackice":
		case "hind":
			param_00.turrettype = "default";
			break;

		case "mi28":
		case "nh90":
		case "mi17":
			param_00.turrettype = "default";
			break;

		case "apache":
			param_00.turrettype = "default";
			break;

		case "littlebird_spotlight":
		case "littlebird":
			param_00 setyawspeed(90,30,20);
			param_00 setmaxpitchroll(40,40);
			param_00 sethoverparams(100,20,5);
			param_00 func_718F();
			break;

		default:
			break;
	}

	param_00.var_2FDF = param_00.var_7F5A;
	if(isdefined(param_00.var_6CB5) && param_00.var_6CB5 == 1 && !isdefined(param_00.var_796A))
	{
		param_00 thread func_411E(undefined,1);
	}

	param_00 thread attack_heli_cleanup();
	return param_00;
}

//Function Number: 6
detect_player_death()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::add_wait(::maps\_utility::func_8B71,"death");
	}

	maps\_utility::func_2852();
	self notify("heli_players_dead");
}

//Function Number: 7
func_40AD()
{
	var_00 = undefined;
	var_01 = undefined;
	switch(self.vehicletype)
	{
		case "ny_harbor_hind":
		case "hind_blackice":
		case "hind":
			var_01 = 600;
			var_00 = -100;
			break;

		case "mi28":
		case "nh90":
		case "mi17":
			var_01 = 600;
			var_00 = -100;
			break;

		case "apache":
			var_01 = 600;
			var_00 = -100;
			break;

		case "littlebird_spotlight":
		case "littlebird":
			var_01 = 600;
			var_00 = -204;
			break;

		default:
			break;
	}

	self.var_7F5A = spawn("script_origin",self.origin);
	self.var_7F5A.angles = self.angles;
	self.var_7F5A.origin = self.origin;
	var_02 = addstruct();
	var_02.entity = self.var_7F5A;
	var_02.forward = var_01;
	var_02.up = var_00;
	var_02 maps\_utility::func_8275();
	self.var_7F5A linkto(self);
	self.var_7F5A thread func_40AC(self);
}

//Function Number: 8
func_39D9()
{
	if(isdefined(self.turrets))
	{
		return self.turrets;
	}

	func_718F();
	return self.turrets;
}

//Function Number: 9
func_718F()
{
	self.turrettype = "miniguns";
	self.minigunsspinning = 0;
	self.var_3345 = 0;
	if(!isdefined(self.mgturret))
	{
	}

	self.turrets = self.mgturret;
	common_scripts\utility::func_F1B(self.turrets,::littlebird_turrets_think,self);
}

//Function Number: 10
func_40AC(param_00)
{
	param_00 common_scripts\utility::func_8B4F("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 11
func_7A15(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_02 = maps\_vehicle::func_784F(param_00);
	var_02.var_7ADB = spawn("script_origin",var_02.origin);
	var_02 thread common_scripts\utility::delete_on_death(var_02.var_7ADB);
	var_02.circling = 1;
	var_02.allowshoot = 1;
	var_02.var_3346 = 0;
	var_02 thread func_5705();
	var_02 thread notify_enable();
	thread kill_heli_logic(var_02,param_01);
	return var_02;
}

//Function Number: 12
kill_heli_logic(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\_vehicle::func_784F("kill_heli");
		param_00.allowshoot = 1;
		param_00.var_3346 = 0;
		param_00 thread func_5705();
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

	if(!isdefined(level.enemy_heli_attacking))
	{
		level.enemy_heli_attacking = 0;
	}

	level.attack_heli_safe_volumes = undefined;
	var_03 = getentarray("attack_heli_safe_volume","script_noteworthy");
	if(var_03.size > 0)
	{
		level.attack_heli_safe_volumes = var_03;
	}

	if(!level.enemy_heli_killed)
	{
		thread dialog_nags_heli(param_00);
	}

	if(!isdefined(param_00.helicopter_predator_target_shader))
	{
		switch(param_00.vehicletype)
		{
			case "mi28":
			case "nh90":
			case "mi17":
				function_017A(param_00,(0,0,-80));
				break;

			case "ny_harbor_hind":
			case "hind_blackice":
			case "hind":
				function_017A(param_00,(0,0,-96));
				break;

			case "apache":
				function_017A(param_00,(0,0,-96));
				break;

			case "littlebird_spotlight":
			case "littlebird":
				function_017A(param_00,(0,0,-80));
				break;

			default:
				break;
		}

		function_0185(param_00,1);
	}

	param_00 thread func_40A5();
	param_00 thread func_40A7();
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	param_00 endon("returning_home");
	param_00 setweapon("turret_attackheli");
	if(!isdefined(param_00.circling))
	{
		param_00.circling = 0;
	}

	if(!param_00.circling)
	{
		param_00 neargoalnotifydist(100);
		if(!isdefined(param_00.var_29B5))
		{
			param_00 waittill("reached_dynamic_path_end");
		}
	}
	else
	{
		param_00 neargoalnotifydist(500);
		param_00 waittill("near_goal");
	}

	param_00 thread heli_shoot_think();
	if(param_00.circling)
	{
		param_00 thread func_408E(param_01,var_02);
	}

	param_00 thread heli_goal_think(var_02);
}

//Function Number: 13
func_408E(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "attack_heli_circle_node";
	}

	var_02 = getentarray(param_00,"targetname");
	if(!isdefined(var_02) || var_02.size < 1)
	{
		var_02 = common_scripts\utility::func_3C1A(param_00,"targetname");
	}

	var_03 = self;
	var_03 endon("stop_circling");
	var_03 endon("death");
	var_03 endon("returning_home");
	var_03 endon("heli_players_dead");
	for(;;)
	{
		var_03 setspeed(param_01,param_01 / 4,param_01 / 4);
		var_03 neargoalnotifydist(100);
		var_04 = maps\_utility::get_closest_player_healthy(var_03.origin);
		var_05 = var_04.origin;
		var_03 setlookatent(var_04);
		var_06 = common_scripts\utility::func_3A56(var_05,var_02);
		var_07 = getentarray(var_06.target,"targetname");
		if(!isdefined(var_07) || var_07.size < 1)
		{
			var_07 = common_scripts\utility::func_3C1A(var_06.target,"targetname");
		}

		var_08 = var_07[randomint(var_07.size)];
		var_03 setgoalpos(var_08.origin,1);
		var_03 waittill("near_goal");
		if(!isdefined(var_04.var_47CF))
		{
			wait(1);
			wait(randomfloatrange(0.8,1.3));
		}
	}
}

//Function Number: 14
heli_goal_think(param_00)
{
	self endon("death");
	var_01 = getentarray("kill_heli_spot","targetname");
	var_02 = self;
	var_03 = common_scripts\utility::func_3A56(var_02.origin,var_01);
	var_04 = var_03;
	var_02 endon("death");
	var_02 endon("returning_home");
	var_02 endon("heli_players_dead");
	var_05 = undefined;
	for(;;)
	{
		wait(0.05);
		var_02 setspeed(param_00,param_00 / 2,param_00 / 10);
		var_02 neargoalnotifydist(100);
		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		var_07 = var_06.origin;
		if(var_03 == var_04 && var_02.var_497C)
		{
			var_08 = get_linked_points(var_02,var_03,var_01,var_06,var_07);
			var_03 = common_scripts\utility::func_3A56(var_07,var_08);
		}

		var_02 setgoalpos(var_03.origin,1);
		var_02.moving = 1;
		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		if(isdefined(self.var_2FDF) && isdefined(self.var_2FDF.classname) && self.var_2FDF.classname == "script_origin")
		{
			var_05 = var_06;
		}
		else if(isdefined(self.var_2FDF))
		{
			var_05 = self.var_2FDF;
		}
		else
		{
			var_05 = self.var_7F5A;
		}

		var_02 setlookatent(var_05);
		var_02 waittill("near_goal");
		var_02.moving = 0;
		if(!maps\_utility::func_47D0())
		{
			if(level.gameskill == 0 || level.gameskill == 1)
			{
				while(func_5E60(var_02))
				{
					wait(0.5);
				}

				wait(3);
			}
		}

		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		var_07 = var_06.origin;
		var_08 = get_linked_points(var_02,var_03,var_01,var_06,var_07);
		var_08[var_08.size] = var_03;
		var_04 = var_03;
		var_09 = common_scripts\utility::func_3A56(var_07,var_01);
		var_0A = common_scripts\utility::func_3A56(var_07,var_08);
		foreach(var_0C in var_08)
		{
			if(var_06 sightconetrace(var_0C.origin,var_02) != 1)
			{
				var_08 = common_scripts\utility::array_remove(var_08,var_0C);
				continue;
			}
		}

		var_0E = common_scripts\utility::func_3A56(var_07,var_08);
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
			var_0F[0] = var_0E;
			var_08 = common_scripts\utility::func_37D5(var_07,var_08,var_0F,2);
			var_10 = randomint(var_08.size);
			if(randomint(100) > 50)
			{
				var_03 = var_08[var_10];
			}
			else
			{
				var_03 = var_09;
			}
		}

		var_11 = randomfloatrange(level.attackhelimovetime - 0.5,level.attackhelimovetime + 0.5);
		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",var_11);
	}
}

//Function Number: 15
func_5E60(param_00)
{
	if(!level.player func_87EE())
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
	thread func_40F7();
	var_00 = level.attackhelirange * level.attackhelirange;
	level.attackheligraceperiod = 0;
	while(isdefined(self))
	{
		wait(randomfloatrange(0.8,1.3));
		if(!func_40D8() || !func_40D7())
		{
			var_01 = heli_get_target_player_only();
			if(isplayer(var_01))
			{
				self.var_2FDF = var_01;
			}
		}

		if(func_40D7() && level.players.size > 1)
		{
			var_02 = maps\_utility::get_closest_player_healthy(self.origin);
			if(self.var_2FDF != var_02)
			{
				var_01 = heli_get_target_player_only();
				if(isplayer(var_01))
				{
					self.var_2FDF = var_01;
				}
			}
		}

		if(func_40D7())
		{
			if(!heli_can_see_target() || level.attackheligraceperiod == 1)
			{
				var_01 = func_40D2();
				self.var_2FDF = var_01;
			}
		}

		if(isdefined(self.var_40E1) && isplayer(self.var_40E1))
		{
			self.var_2FDF = self.var_40E1;
		}
		else if(!func_40D8())
		{
			var_01 = func_40D2();
			self.var_2FDF = var_01;
		}

		if(!func_40D8())
		{
			continue;
		}

		if(self.var_2FDF func_47FE(self))
		{
			continue;
		}

		if(func_40D8() && distancesquared(self.var_2FDF.origin,self.origin) > var_00)
		{
			continue;
		}

		if(self.turrettype == "default" && func_40D7())
		{
			func_528A(self.var_2FDF);
			wait(randomfloatrange(0.8,1.3));
			func_528A(self.var_2FDF);
			wait(randomfloatrange(0.8,1.3));
			while(func_198F(self.var_2FDF) && !self.var_2FDF func_47FE(self))
			{
				fire_guns();
				wait(randomfloatrange(2,4));
			}

			continue;
		}

		if(isplayer(self.var_2FDF) || isai(self.var_2FDF))
		{
			fire_guns();
		}

		if(isplayer(self.var_2FDF))
		{
			thread func_5E17(self);
		}

		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.attackhelitargetreaquire);
	}
}

//Function Number: 17
func_5E17(param_00)
{
	level notify("player_is_heli_target");
	level endon("player_is_heli_target");
	level.attackheligraceperiod = 1;
	param_00 common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.attackheliplayerbreak);
	level.attackheligraceperiod = 0;
}

//Function Number: 18
heli_can_see_target()
{
	if(!isdefined(self.var_2FDF))
	{
		return 0;
	}

	var_00 = self.var_2FDF.origin + (0,0,32);
	if(isplayer(self.var_2FDF))
	{
		var_00 = self.var_2FDF geteye();
	}

	var_01 = self gettagorigin("tag_flash");
	var_02 = sighttracepassed(var_01,var_00,0,self);
	return var_02;
}

//Function Number: 19
func_40D7()
{
	if(!isdefined(self.var_2FDF))
	{
		return 0;
	}

	if(isplayer(self.var_2FDF))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_40D8()
{
	if(!isdefined(self.var_2FDF))
	{
		return 0;
	}

	if(!isalive(self.var_2FDF))
	{
		return 0;
	}

	if(self.var_2FDF == self.var_7F5A)
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_40D1()
{
	var_00 = maps\_helicopter_globals::func_3A98(level.attackhelirange,level.attackhelifov,1,1,0,1,level.attackheliexcluders);
	if(isdefined(var_00) && isplayer(var_00))
	{
		var_00 = self.var_7F5A;
	}

	if(!isdefined(var_00))
	{
		var_00 = self.var_7F5A;
	}

	return var_00;
}

//Function Number: 22
heli_get_target_player_only()
{
	var_00 = function_016B("allies");
	var_01 = maps\_helicopter_globals::func_3A98(level.attackhelirange,level.attackhelifov,1,0,0,0,var_00);
	if(!isdefined(var_01))
	{
		var_01 = self.var_7F5A;
	}

	return var_01;
}

//Function Number: 23
func_40D2()
{
	var_00 = maps\_helicopter_globals::func_3A98(level.attackhelirange,level.attackhelifov,1,1,0,1,level.players);
	if(!isdefined(var_00))
	{
		var_00 = self.var_7F5A;
	}

	return var_00;
}

//Function Number: 24
func_40F7()
{
	if(!isdefined(self.var_6C28))
	{
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
			var_05[0] = "tag_store_L_2_a";
			var_05[1] = "tag_store_R_2_a";
			var_05[2] = "tag_store_L_2_b";
			var_05[3] = "tag_store_R_2_b";
			var_05[4] = "tag_store_L_2_c";
			var_05[5] = "tag_store_R_2_c";
			var_05[6] = "tag_store_L_2_d";
			var_05[7] = "tag_store_R_2_d";
			break;

		case "littlebird":
		case "apache":
			var_00 = 1;
			var_03 = 1;
			var_04 = 0.5;
			var_05[0] = "tag_missile_left";
			var_05[1] = "tag_missile_right";
			break;

		default:
			break;
	}

	var_06 = -1;
	for(;;)
	{
		wait(0.05);
		self waittill("fire_missiles",var_07);
		if(!isplayer(var_07))
		{
			continue;
		}

		var_08 = var_07;
		if(!player_is_good_missile_target(var_08))
		{
			continue;
		}

		for(var_09 = 0;var_09 < var_00;var_09++)
		{
			var_06++;
			if(var_06 >= var_05.size)
			{
				var_06 = 0;
			}

			self setweapon(var_02);
			self.var_3346 = 1;
			var_0A = self fireweapon(var_05[var_06],var_08);
			var_0A thread missilelosetarget(var_04);
			var_0A thread func_5295();
			if(var_09 < var_00 - 1)
			{
				wait(var_03);
			}
		}

		self.var_3346 = 0;
		self setweapon(var_01);
		wait(10);
	}
}

//Function Number: 25
player_is_good_missile_target(param_00)
{
	if(self.moving)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_5295()
{
	if(distancesquared(self.origin,level.player.origin) > 9000000)
	{
	}

	var_00 = self.origin;
	while(isdefined(self))
	{
		var_00 = self.origin;
		wait(0.1);
	}

	earthquake(0.7,1.5,var_00,1600);
}

//Function Number: 27
missilelosetarget(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	wait(param_00);
	if(isdefined(self))
	{
		self missilecleartarget();
	}
}

//Function Number: 28
func_3851(param_00)
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
func_5705()
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
			func_84D8(self.var_2FDF,var_00,var_01);
			break;

		case "miniguns":
			var_00 = func_3A48(self.var_2FDF);
			if(self.allowshoot && !self.var_3346)
			{
				func_84F0(self.var_2FDF,var_00);
			}
			break;

		default:
			break;
	}
}

//Function Number: 32
func_3A48(param_00)
{
	var_01 = undefined;
	if(!isplayer(param_00))
	{
		var_01 = level.var_1009;
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
fire_missiles(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	wait(param_00);
	if(!isplayer(self.var_2FDF))
	{
	}

	self notify("fire_missiles",self.var_2FDF);
}

//Function Number: 34
func_84D8(param_00,param_01,param_02)
{
	thread fire_missiles(randomfloatrange(0.2,2));
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		self setturrettargetent(param_00,common_scripts\utility::randomvector(50) + (0,0,32));
		if(self.allowshoot && !self.var_3346)
		{
			self fireweapon();
		}

		wait(param_02);
	}
}

//Function Number: 35
func_84F0(param_00,param_01,param_02)
{
	self endon("death");
	self endon("heli_players_dead");
	self notify("firing_miniguns");
	self endon("firing_miniguns");
	var_03 = func_39D9();
	common_scripts\utility::func_F1B(var_03,::func_84F1,param_00,self);
	if(!self.minigunsspinning)
	{
		self.var_3345 = 1;
		thread maps\_utility::func_5D25("littlebird_gatling_spinup","tag_flash");
		wait(2.1);
		thread maps\_utility::func_5CF5("littlebird_minigun_spinloop","tag_flash");
	}

	self.minigunsspinning = 1;
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
		wait(randomfloatrange(var_04,param_02));
	}

	minigun_fire(param_00,param_01);
	var_03 = func_39D9();
	common_scripts\utility::array_call(var_03,::stopfiring);
	thread func_5270(param_00);
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

	var_02 = func_39D9();
	common_scripts\utility::array_call(var_02,::startfiring);
	wait(randomfloatrange(1,2));
	if(isplayer(param_00))
	{
		thread func_7F56(param_00);
	}

	if(isplayer(param_00))
	{
		var_03 = randomfloatrange(0.5,3);
		thread fire_missiles(var_03);
	}

	wait(param_01);
}

//Function Number: 37
func_7F56(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stopping_firing");
	self notify("tracking_player");
	self endon("tracking_player");
	for(;;)
	{
		if(!func_198F(param_00))
		{
			break;
		}

		wait(0.5);
	}

	wait(level.attackhelitimeout);
	self notify("cant_see_player");
}

//Function Number: 38
func_84F1(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("heli_players_dead");
	self notify("miniguns_have_new_target");
	self endon("miniguns_have_new_target");
	if(!isplayer(param_00) && isai(param_00) && level.attackhelikillsai == 0)
	{
		var_02 = spawn("script_origin",param_00.origin + (0,0,100));
		var_02 linkto(param_00);
		thread func_5263(var_02);
		param_00 = var_02;
	}

	for(;;)
	{
		wait(0.5);
		self settargetentity(param_00);
	}
}

//Function Number: 39
func_5263(param_00)
{
	common_scripts\utility::func_8B4F("death","miniguns_have_new_target");
	param_00 delete();
}

//Function Number: 40
func_5270(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("firing_miniguns");
	if(isplayer(param_00))
	{
		wait(randomfloatrange(3,4));
	}
	else
	{
		wait(randomfloatrange(1,2));
	}

	thread func_5271();
	self.var_3345 = 0;
}

//Function Number: 41
func_5271()
{
	self notify("stop soundlittlebird_minigun_spinloop");
	self.minigunsspinning = 0;
	maps\_utility::func_5D25("littlebird_gatling_cooldown","tag_flash");
}

//Function Number: 42
func_528A(param_00)
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

		wait(var_05);
	}
}

//Function Number: 43
func_198F(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	var_01 = self gettagorigin("tag_flash");
	var_02 = (0,0,0);
	if(isplayer(param_00))
	{
		var_02 = param_00 geteye();
	}
	else
	{
		var_02 = param_00.origin;
	}

	if(sighttracepassed(var_01,var_02,0,undefined))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
get_linked_points(param_00,param_01,param_02,param_03,param_04)
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
func_40A5()
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
		thread can_see_attacker_for_a_bit(var_01);
		if(maps\_utility::func_47D7())
		{
			var_01 thread func_86E0();
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
	self.var_497C = 1;
	wait(1);
	self.var_497C = 0;
}

//Function Number: 47
can_see_attacker_for_a_bit(param_00)
{
	self notify("attacker_seen");
	self endon("attacker_seen");
	self.seen_attacker = param_00;
	self.var_40E1 = param_00;
	wait(level.attackhelimemory);
	self.var_40E1 = undefined;
	self.seen_attacker = undefined;
}

//Function Number: 48
func_47FE(param_00)
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
func_86E0()
{
	if(!isplayer(self))
	{
	}

	self.var_4310 setmaterial("damage_feedback",24,48);
	self playlocalsound("player_feedback_hit_alert");
	self.var_4310.alpha = 1;
	self.var_4310 fadeovertime(1);
	self.var_4310.alpha = 0;
}

//Function Number: 50
damage_feedback_setup()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.var_4310 = newclienthudelem(var_01);
		var_01.var_4310.horzalign = "center";
		var_01.var_4310.vertalign = "middle";
		var_01.var_4310.x = -12;
		var_01.var_4310.y = -12;
		var_01.var_4310.alpha = 0;
		var_01.var_4310.archived = 1;
		var_01.var_4310 setmaterial("damage_feedback",24,48);
	}
}

//Function Number: 51
func_40A7()
{
	self waittill("death");
	level notify("attack_heli_destroyed");
	level.enemy_heli_killed = 1;
	wait(15);
	level.enemy_heli_attacking = 0;
}

//Function Number: 52
dialog_nags_heli(param_00)
{
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	wait(30);
	if(!level.enemy_heli_attacking)
	{
	}

	func_1E78("co_cf_cmd_heli_small_fire");
	if(!level.enemy_heli_attacking)
	{
	}

	func_1E78("co_cf_cmd_rpg_stinger");
	wait(30);
	if(!level.enemy_heli_attacking)
	{
	}

	func_1E78("co_cf_cmd_heli_wonders");
}

//Function Number: 53
func_1E78(param_00)
{
	while(level.commander_speaking)
	{
		wait(1);
	}

	level.commander_speaking = 1;
	level.player playsound(param_00,"sounddone");
	level.player waittill("sounddone");
	wait(0.5);
	level.commander_speaking = 0;
}

//Function Number: 54
func_87EE()
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
heli_spotlight_cleanup(param_00)
{
	common_scripts\utility::func_8B2A("death","crash_done","turn_off_spotlight");
	self.var_796A = undefined;
	if(isdefined(self))
	{
		stopfxontag(common_scripts\utility::func_3AB9("_attack_heli_spotlight"),self,param_00);
	}
}

//Function Number: 56
func_411A(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	var_01 = self.var_7F5A;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	var_01.targetname = "original_ent";
	self.left_ent = spawn("script_origin",var_01.origin);
	self.left_ent.origin = var_01.origin;
	self.left_ent.angles = var_01.angles;
	self.left_ent.targetname = "left_ent";
	self.var_66B9 = spawn("script_origin",var_01.origin);
	self.var_66B9.origin = var_01.origin;
	self.var_66B9.angles = var_01.angles;
	self.var_66B9.targetname = "right_ent";
	var_02 = addstruct();
	var_02.entity = self.left_ent;
	var_02.right = 250;
	var_02 maps\_utility::func_8275();
	self.left_ent linkto(self);
	var_03 = addstruct();
	var_03.entity = self.var_66B9;
	var_03.right = -250;
	var_03 maps\_utility::func_8275();
	self.var_66B9 linkto(self);
	var_04 = [];
	var_04[0] = var_01;
	var_04[1] = self.left_ent;
	var_04[2] = self.var_66B9;
	level.var_796B = var_04;
	self.var_7972 = var_01;
}

//Function Number: 57
func_411B()
{
	if(isdefined(level.var_796B))
	{
		foreach(var_01 in level.var_796B)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 58
func_4117(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	if(self.vehicletype != "littlebird")
	{
	}

	thread heli_spotlight_think(param_00);
	var_01 = undefined;
	for(;;)
	{
		wait(0.05);
		switch(self.vehicletype)
		{
			case "littlebird_spotlight":
			case "littlebird":
				var_01 = self.var_7972;
				break;
	
			default:
				var_01 = self.var_2FDF;
				break;
		}

		if(isdefined(var_01))
		{
			self setturrettargetent(var_01,(0,0,0));
		}
	}
}

//Function Number: 59
heli_spotlight_think(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	func_411A();
	common_scripts\utility::func_F1B(level.var_796B,::func_4118,self);
	if(isdefined(param_00))
	{
		self thread [[ param_00 ]]();
	}

	for(;;)
	{
		wait(randomfloatrange(1,3));
		if(func_40D7() && !func_8E1B())
		{
			self.var_7972 = self.var_2FDF;
			continue;
		}

		var_01 = randomint(level.var_796B.size);
		self.var_7F5A = level.var_796B[var_01];
		self.var_7972 = self.var_7F5A;
	}
}

//Function Number: 60
func_8E1B()
{
	self endon("death");
	self endon("heli_players_dead");
	if(!isdefined(self.var_2FDF))
	{
		return 0;
	}

	if(!isplayer(self.var_2FDF))
	{
		return 0;
	}

	var_00 = self.var_2FDF;
	var_01 = common_scripts\utility::func_8E18(var_00 geteye(),var_00 getangles(),self.origin,level.cosine["35"]);
	return var_01;
}

//Function Number: 61
func_4118(param_00)
{
	param_00 common_scripts\utility::func_8B4F("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 62
littlebird_turrets_think(param_00)
{
	var_01 = self;
	var_01 maps\_vehicle_code::func_8500("manual");
	if(isdefined(param_00.var_7F5A))
	{
		var_01 settargetentity(param_00.var_7F5A);
	}

	var_01 setmode("manual");
	param_00 waittill("death");
	if(isdefined(param_00.var_3345) && param_00.var_3345 == 1)
	{
		thread func_5271();
	}
}

//Function Number: 63
attack_heli_cleanup()
{
	common_scripts\utility::func_8B4F("death","crash_done");
	if(isdefined(self.attractor))
	{
		missiledeleteattractor(self.attractor);
	}

	if(isdefined(self.attractor2))
	{
		missiledeleteattractor(self.attractor2);
	}
}

//Function Number: 64
func_40AB(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_default_heli_missiles");
	self.var_6129 = undefined;
	while(isdefined(self))
	{
		wait(0.05);
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		self.var_6129 = undefined;
		var_04 = undefined;
		if(isdefined(self.currentnode) && isdefined(self.currentnode.target))
		{
			var_04 = maps\_utility::getent_or_struct(self.currentnode.target,"targetname");
		}

		if(isdefined(var_04) && isdefined(var_04.script_linkto))
		{
			self.var_6129 = maps\_utility::getent_or_struct(var_04.script_linkto,"script_linkname");
		}

		if(isdefined(self.var_6129))
		{
			var_01 = self.var_6129;
			var_02 = var_01.var_6CA2;
			var_03 = var_01.script_delay;
			var_04 waittill("trigger");
			continue;
		}

		common_scripts\utility::func_8B2A("near_goal","goal");
		if(isdefined(var_01))
		{
			thread func_40B9(var_01,var_02,var_03,param_00);
		}
	}
}

//Function Number: 65
func_40AA()
{
	self notify("stop_default_heli_missiles");
}

//Function Number: 66
func_411E(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = "tag_barrel";
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	playfxontag(common_scripts\utility::func_3AB9("_attack_heli_spotlight"),self,param_00);
	self.var_796A = 1;
	thread heli_spotlight_cleanup(param_00);
	if(param_02)
	{
		self setturrettargetent(level.player);
	}

	if(param_01)
	{
		self endon("death");
		self endon("heli_players_dead");
		var_03 = self gettagorigin("tag_origin");
		if(!isdefined(self.var_7F5A))
		{
			func_40AD();
		}

		self setturrettargetent(self.var_7F5A);
		thread func_4117();
	}
}

//Function Number: 67
func_411D()
{
	self notify("turn_off_spotlight");
}

//Function Number: 68
func_4120()
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_spotlight_random_targets");
	if(!isdefined(self.var_7F5A))
	{
		thread func_40AD();
	}

	if(!isdefined(self.left_ent))
	{
		thread heli_spotlight_think();
	}

	while(isdefined(self))
	{
		wait(0.05);
		self setturrettargetent(self.var_7F5A,(0,0,0));
	}
}

//Function Number: 69
func_411F()
{
	self notify("stop_spotlight_random_targets");
}

//Function Number: 70
func_40B9(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("heli_players_dead");
	if(isdefined(self.defaultweapon))
	{
		var_04 = self.defaultweapon;
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
	self setweapon(var_04);
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
		if(!isdefined(self.var_2B90))
		{
			self.var_2B90 = spawn("script_origin",param_00.origin);
			thread common_scripts\utility::delete_on_death(self.var_2B90);
		}

		self.var_2B90.origin = param_00.origin;
		param_00 = self.var_2B90;
	}

	switch(self.vehicletype)
	{
		case "mi28":
			var_06 = 0.5;
			var_07[0] = "tag_store_L_2_a";
			var_07[1] = "tag_store_R_2_a";
			var_07[2] = "tag_store_L_2_b";
			var_07[3] = "tag_store_R_2_b";
			var_07[4] = "tag_store_L_2_c";
			var_07[5] = "tag_store_R_2_c";
			var_07[6] = "tag_store_L_2_d";
			var_07[7] = "tag_store_R_2_d";
			break;

		case "littlebird":
		case "apache":
			var_06 = 0.5;
			var_07[0] = "tag_missile_left";
			var_07[1] = "tag_missile_right";
			break;

		case "hind_battle":
			var_07[0] = "tag_missile_left";
			var_07[1] = "tag_missile_right";
			break;

		default:
			break;
	}

	var_08 = -1;
	for(var_09 = 0;var_09 < param_01;var_09++)
	{
		var_08++;
		if(var_08 >= var_07.size)
		{
			var_08 = 0;
		}

		self setweapon(var_05);
		self.var_3346 = 1;
		var_0A = self fireweapon(var_07[var_08],param_00);
		var_0A thread func_5295();
		if(var_09 < param_01 - 1)
		{
			wait(param_02);
		}
	}

	self.var_3346 = 0;
	self setweapon(var_04);
}

//Function Number: 71
boneyard_style_heli_missile_attack()
{
	self waittill("trigger",var_00);
	var_01 = common_scripts\utility::func_3C1A(self.target,"targetname");
	var_01 = maps\_utility::func_EEA(var_01);
	func_1566(var_00,var_01);
}

//Function Number: 72
func_1568()
{
	self waittill("trigger",var_00);
	var_01 = maps\_utility::get_linked_structs();
	var_01 = maps\_utility::func_EEA(var_01);
	func_1566(var_00,var_01);
}

//Function Number: 73
func_1566(param_00,param_01)
{
	var_02 = [];
	var_02[0] = "tag_missile_right";
	var_02[1] = "tag_missile_left";
	if(param_00.vehicletype == "cobra")
	{
		var_02[0] = "tag_store_L_1_a";
		var_02[1] = "tag_store_R_1_a";
	}

	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_03[var_04] = spawn("script_origin",param_01[var_04].origin);
		param_00 setweapon("littlebird_FFAR");
		param_00 setturrettargetent(var_03[var_04]);
		var_05 = param_00 fireweapon(var_02[var_04 % var_02.size],var_03[var_04],(0,0,0));
		var_05 common_scripts\utility::delaycall(1,::missilecleartarget);
		wait(randomfloatrange(0.2,0.3));
	}

	wait(2);
	foreach(var_07 in var_03)
	{
		var_07 delete();
	}
}
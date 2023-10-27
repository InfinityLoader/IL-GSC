/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 363.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 86 ms
 * Timestamp: 10/27/2023 2:23:16 AM
*******************************************************************/

//Function Number: 1
func_2874()
{
	precacheitem("turret_attackheli");
	precacheitem("missile_attackheli");
	func_2875();
	thread init();
}

//Function Number: 2
func_2875()
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
	if(isdefined(level.var_2876))
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

	if(!isdefined(level.var_2878))
	{
		level.var_2878 = 3500;
	}

	if(!isdefined(level.var_2879))
	{
		level.var_2879 = 0;
	}

	if(!isdefined(level.var_287A))
	{
		level.var_287A = cos(30);
	}

	level.var_2876 = 1;
	level.var_287B = 3;
	level.var_287C = 6;
	level.var_287D = 3;
	switch(level.gameskill)
	{
		case 0:
			level.var_287E = 9;
			level.var_287F = 1;
			break;

		case 1:
			level.var_287E = 7;
			level.var_287F = 2;
			break;

		case 2:
			level.var_287E = 5;
			level.var_287F = 3;
			break;

		case 3:
			level.var_287E = 3;
			level.var_287F = 5;
			break;
	}
}

//Function Number: 4
func_2880(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	var_01 = func_2882(var_01);
	return var_01;
}

//Function Number: 5
func_2882(param_00,param_01)
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

		if(!isdefined(param_00.var_2883))
		{
			param_00.attractor = missile_createattractorent(var_02,var_03,10000,level.player);
			if(maps\_utility::is_coop())
			{
				param_00.var_2885 = missile_createattractorent(var_02,var_03,10000,level.player2);
			}
		}
	}

	param_00 enableaimassist();
	param_00.var_2886 = spawn("script_origin",param_00.origin);
	param_00 thread common_scripts\utility::delete_on_death(param_00.var_2886);
	if(!isdefined(param_00.var_2887))
	{
		param_00.var_2887 = 0;
	}

	param_00.var_2888 = 1;
	param_00.var_2889 = 0;
	param_00.var_288A = 1;
	param_00.var_288B = 0;
	param_00.var_288C = undefined;
	param_00 thread func_28B5();
	param_00 thread func_28B6();
	thread func_289B(param_00,param_01);
	param_00.turrettype = undefined;
	param_00 func_2893();
	param_00 thread func_2892();
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
			param_00 func_2896();
			break;

		default:
			break;
	}

	param_00.var_288F = param_00.var_288E;
	if(isdefined(param_00.var_2890) && param_00.var_2890 == 1 && !isdefined(param_00.var_2891))
	{
		param_00 thread func_28DE(undefined,1);
	}

	param_00 thread func_28D9();
	return param_00;
}

//Function Number: 6
func_2892()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	}

	maps\_utility::do_wait_any();
	self notify("heli_players_dead");
}

//Function Number: 7
func_2893()
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

	self.var_288E = spawn("script_origin",self.origin);
	self.var_288E.angles = self.angles;
	self.var_288E.origin = self.origin;
	var_02 = spawnstruct();
	var_02.entity = self.var_288E;
	var_02.forward = var_01;
	var_02.up = var_00;
	var_02 maps\_utility::translate_local();
	self.var_288E linkto(self);
	self.var_288E thread func_2899(self);
}

//Function Number: 8
func_2894()
{
	if(isdefined(self.turrets))
	{
		return self.turrets;
	}

	func_2896();
	return self.turrets;
}

//Function Number: 9
func_2896()
{
	self.turrettype = "miniguns";
	self.var_2897 = 0;
	self.var_2898 = 0;
	if(!isdefined(self.mgturret))
	{
		return;
	}

	self.turrets = self.mgturret;
	common_scripts\utility::array_thread(self.turrets,::func_28D7,self);
}

//Function Number: 10
func_2899(param_00)
{
	param_00 common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 11
func_289A(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "kill_heli";
	}

	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	var_02.var_2886 = spawn("script_origin",var_02.origin);
	var_02 thread common_scripts\utility::delete_on_death(var_02.var_2886);
	var_02.var_2887 = 1;
	var_02.var_2888 = 1;
	var_02.var_2889 = 0;
	var_02 thread func_28B5();
	var_02 thread func_28B6();
	thread func_289B(var_02,param_01);
	return var_02;
}

//Function Number: 12
func_289B(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
		param_00.var_2888 = 1;
		param_00.var_2889 = 0;
		param_00 thread func_28B5();
		param_00 thread func_28B6();
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

	if(!isdefined(level.var_289D))
	{
		level.var_289D = 0;
	}

	if(!isdefined(level.var_289E))
	{
		level.var_289E = 0;
	}

	if(!isdefined(level.var_289F))
	{
		level.var_289F = 0;
	}

	level.var_28A0 = undefined;
	var_03 = getentarray("attack_heli_safe_volume","script_noteworthy");
	if(var_03.size > 0)
	{
		level.var_28A0 = var_03;
	}

	if(!level.var_289D)
	{
		thread func_28CC(param_00);
	}

	if(!isdefined(param_00.var_28A1))
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

	param_00 thread heli_damage_monitor();
	param_00 thread func_28CB();
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	param_00 endon("returning_home");
	param_00 setvehweapon("turret_attackheli");
	if(!isdefined(param_00.var_2887))
	{
		param_00.var_2887 = 0;
	}

	if(!param_00.var_2887)
	{
		param_00 setneargoalnotifydist(100);
		if(!isdefined(param_00.var_28A2))
		{
			param_00 waittill("reached_dynamic_path_end");
		}
	}
	else
	{
		param_00 setneargoalnotifydist(500);
		param_00 waittill("near_goal");
	}

	param_00 thread func_28A6();
	if(param_00.var_2887)
	{
		param_00 thread func_28A3(param_01,var_02);
		return;
	}

	param_00 thread func_28A4(var_02);
}

//Function Number: 13
func_28A3(param_00,param_01)
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
		var_04 = maps\_utility::get_closest_player_healthy(var_03.origin);
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
		if(!isdefined(var_04.is_controlling_uav))
		{
			wait 1;
			wait randomfloatrange(0.8,1.3);
		}
	}
}

//Function Number: 14
func_28A4(param_00)
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
		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		var_07 = var_06.origin;
		if(var_03 == var_04 && var_02.var_288B)
		{
			var_08 = func_28C4(var_02,var_03,var_01,var_06,var_07);
			var_03 = maps\_utility::getclosest(var_07,var_08);
		}

		var_02 setvehgoalpos(var_03.origin,1);
		var_02.var_288A = 1;
		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		if(isdefined(self.var_288F) && isdefined(self.var_288F.classname) && self.var_288F.classname == "script_origin")
		{
			var_05 = var_06;
		}
		else if(isdefined(self.var_288F))
		{
			var_05 = self.var_288F;
		}
		else
		{
			var_05 = self.var_288E;
		}

		var_02 setlookatent(var_05);
		var_02 waittill("near_goal");
		var_02.var_288A = 0;
		if(!maps\_utility::is_coop())
		{
			if(level.gameskill == 0 || level.gameskill == 1)
			{
				while(func_28A5(var_02))
				{
					wait 0.5;
				}

				wait 3;
			}
		}

		var_06 = maps\_utility::get_closest_player_healthy(var_02.origin);
		var_07 = var_06.origin;
		var_08 = func_28C4(var_02,var_03,var_01,var_06,var_07);
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
			var_09 = maps\_utility::get_array_of_closest(var_08,var_09,var_7B,2);
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

		var_0F = randomfloatrange(level.var_287D - 0.5,level.var_287D + 0.5);
		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",var_0F);
	}
}

//Function Number: 15
func_28A5(param_00)
{
	if(!level.player func_28CE())
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
func_28A6()
{
	self endon("stop_shooting");
	self endon("death");
	self endon("heli_players_dead");
	thread func_28B0();
	var_00 = level.var_2878 * level.var_2878;
	level.var_28A7 = 0;
	while(isdefined(self))
	{
		wait randomfloatrange(0.8,1.3);
		if(!func_28AB() || !func_28AA())
		{
			var_01 = func_28AE();
			if(isplayer(var_01))
			{
				self.var_288F = var_01;
			}
		}

		if(func_28AA() && level.players.size > 1)
		{
			var_02 = maps\_utility::get_closest_player_healthy(self.origin);
			if(self.var_288F != var_02)
			{
				var_01 = func_28AE();
				if(isplayer(var_01))
				{
					self.var_288F = var_01;
				}
			}
		}

		if(func_28AA())
		{
			if(!func_28A9() || level.var_28A7 == 1)
			{
				var_01 = func_28AF();
				self.var_288F = var_01;
			}
		}

		if(isdefined(self.var_288C) && isplayer(self.var_288C))
		{
			self.var_288F = self.var_288C;
		}
		else if(!func_28AB())
		{
			var_01 = func_28AF();
			self.var_288F = var_01;
		}

		if(!func_28AB())
		{
			continue;
		}

		if(self.var_288F func_28C9(self))
		{
			continue;
		}

		if(func_28AB() && distancesquared(self.var_288F.origin,self.origin) > var_00)
		{
			continue;
		}

		if(self.turrettype == "default" && func_28AA())
		{
			func_28C2(self.var_288F);
			wait randomfloatrange(0.8,1.3);
			func_28C2(self.var_288F);
			wait randomfloatrange(0.8,1.3);
			while(func_28C3(self.var_288F) && !self.var_288F func_28C9(self))
			{
				func_28B7();
				wait randomfloatrange(2,4);
			}

			continue;
		}

		if(isplayer(self.var_288F) || isai(self.var_288F))
		{
			func_28B7();
		}

		if(isplayer(self.var_288F))
		{
			thread func_28A8(self);
		}

		common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.var_287C);
	}
}

//Function Number: 17
func_28A8(param_00)
{
	level notify("player_is_heli_target");
	level endon("player_is_heli_target");
	level.var_28A7 = 1;
	param_00 common_scripts\utility::waittill_notify_or_timeout("damage_by_player",level.var_287E);
	level.var_28A7 = 0;
}

//Function Number: 18
func_28A9()
{
	if(!isdefined(self.var_288F))
	{
		return 0;
	}

	var_00 = self.var_288F.origin + (0,0,32);
	if(isplayer(self.var_288F))
	{
		var_00 = self.var_288F geteye();
	}

	var_01 = self gettagorigin("tag_flash");
	var_02 = sighttracepassed(var_01,var_00,0,self);
	return var_02;
}

//Function Number: 19
func_28AA()
{
	if(!isdefined(self.var_288F))
	{
		return 0;
	}

	if(isplayer(self.var_288F))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_28AB()
{
	if(!isdefined(self.var_288F))
	{
		return 0;
	}

	if(!isalive(self.var_288F))
	{
		return 0;
	}

	if(self.var_288F == self.var_288E)
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_28AC()
{
	var_00 = maps\_helicopter_globals::getenemytarget(level.var_2878,level.var_287A,1,1,0,1,level.var_28AD);
	if(isdefined(var_00) && isplayer(var_00))
	{
		var_00 = self.var_288E;
	}

	if(!isdefined(var_00))
	{
		var_00 = self.var_288E;
	}

	return var_00;
}

//Function Number: 22
func_28AE()
{
	var_00 = getaiarray("allies");
	var_01 = maps\_helicopter_globals::getenemytarget(level.var_2878,level.var_287A,1,0,0,0,var_00);
	if(!isdefined(var_01))
	{
		var_01 = self.var_288E;
	}

	return var_01;
}

//Function Number: 23
func_28AF()
{
	var_00 = maps\_helicopter_globals::getenemytarget(level.var_2878,level.var_287A,1,1,0,1,level.players);
	if(!isdefined(var_00))
	{
		var_00 = self.var_288E;
	}

	return var_00;
}

//Function Number: 24
func_28B0()
{
	if(!isdefined(self.var_28B1))
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
	var_7B[7]
	"tag_store_R_2_d"
	var_7B[6]
	"tag_store_L_2_d"
	var_7B[5]
	"tag_store_R_2_c"
	var_7B[4]
	"tag_store_L_2_c"
	var_7B[3]
	"tag_store_R_2_b"
	var_7B[2]
	"tag_store_L_2_b"
	var_7B[1]
	"tag_store_R_2_a"
	var_7B[0]
	"tag_store_L_2_a"
			break;

		case "littlebird":
			var_01 = 1;
			var_04 = 1;
			var_05 = 0.5;
			break;
	var_7B[1]
	"tag_missile_right"
	var_7B[0]
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
		if(!func_28B2(var_08))
		{
			continue;
		}

		for(var_09 = 0;var_09 < var_01;var_09++)
		{
			var_06++;
			if(var_06 >= var_7B.size)
			{
				var_06 = 0;
			}

			self setvehweapon(var_03);
			self.var_2889 = 1;
			var_0A = self fireweapon(var_7B[var_06],var_08);
			var_0A thread missilelosetarget(var_05);
			var_0A thread func_28B3();
			if(var_09 < var_01 - 1)
			{
				wait var_04;
			}
		}

		self.var_2889 = 0;
		self setvehweapon(var_02);
		wait 10;
	}
}

//Function Number: 25
func_28B2(param_00)
{
	if(self.var_288A)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_28B3()
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
missilelosetarget(param_00)
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
func_28B4(param_00)
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
func_28B5()
{
	self notify("notify_disable_thread");
	self endon("notify_disable_thread");
	self endon("death");
	self endon("heli_players_dead");
	for(;;)
	{
		self waittill("disable_turret");
		self.var_2888 = 0;
	}
}

//Function Number: 30
func_28B6()
{
	self notify("notify_enable_thread");
	self endon("notify_enable_thread");
	self endon("death");
	self endon("heli_players_dead");
	for(;;)
	{
		self waittill("enable_turret");
		self.var_2888 = 1;
	}
}

//Function Number: 31
func_28B7()
{
	switch(self.turrettype)
	{
		case "default":
			var_00 = randomintrange(5,10);
			var_01 = weaponfiretime("turret_attackheli");
			func_28BA(self.var_288F,var_00,var_01);
			break;

		case "miniguns":
			var_00 = func_28B8(self.var_288F);
			if(self.var_2888 && !self.var_2889)
			{
				func_28BB(self.var_288F,var_00);
			}
			break;

		default:
			break;
	}
}

//Function Number: 32
func_28B8(param_00)
{
	var_01 = undefined;
	if(!isplayer(param_00))
	{
		var_01 = level.var_2876;
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
func_28B9(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	wait param_00;
	if(!isplayer(self.var_288F))
	{
		return;
	}

	self notify("fire_missiles",self.var_288F);
}

//Function Number: 34
func_28BA(param_00,param_01,param_02)
{
	thread func_28B9(randomfloatrange(0.2,2));
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		self setturrettargetent(param_00,common_scripts\utility::randomvector(50) + (0,0,32));
		if(self.var_2888 && !self.var_2889)
		{
			self fireweapon();
		}

		wait param_02;
	}
}

//Function Number: 35
func_28BB(param_00,param_01,param_02)
{
	self endon("death");
	self endon("heli_players_dead");
	self notify("firing_miniguns");
	self endon("firing_miniguns");
	var_03 = func_2894();
	common_scripts\utility::array_thread(var_03,::func_28BE,param_00,self);
	if(!self.var_2897)
	{
		self.var_2898 = 1;
		thread maps\_utility::play_sound_on_tag("littlebird_gatling_spinup","tag_flash");
		wait 2.1;
		thread maps\_utility::play_loop_sound_on_tag("littlebird_minigun_spinloop","tag_flash");
	}

	self.var_2897 = 1;
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

	func_28BC(param_00,param_01);
	var_03 = func_2894();
	common_scripts\utility::array_call(var_03,::stopfiring);
	thread func_28C0(param_00);
	self notify("stopping_firing");
}

//Function Number: 36
func_28BC(param_00,param_01)
{
	self endon("death");
	self endon("heli_players_dead");
	if(isplayer(param_00))
	{
		self endon("cant_see_player");
	}

	var_02 = func_2894();
	common_scripts\utility::array_call(var_02,::startfiring);
	wait randomfloatrange(1,2);
	if(isplayer(param_00))
	{
		thread func_28BD(param_00);
	}

	if(isplayer(param_00))
	{
		var_03 = randomfloatrange(0.5,3);
		thread func_28B9(var_03);
	}

	wait param_01;
}

//Function Number: 37
func_28BD(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stopping_firing");
	self notify("tracking_player");
	self endon("tracking_player");
	for(;;)
	{
		if(!func_28C3(param_00))
		{
			break;
		}

		wait 0.5;
	}

	wait level.var_287F;
	self notify("cant_see_player");
}

//Function Number: 38
func_28BE(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("heli_players_dead");
	self notify("miniguns_have_new_target");
	self endon("miniguns_have_new_target");
	if(!isplayer(param_00) && isai(param_00) && level.var_2879 == 0)
	{
		var_02 = spawn("script_origin",param_00.origin + (0,0,100));
		var_02 linkto(param_00);
		thread func_28BF(var_02);
		param_00 = var_02;
	}

	for(;;)
	{
		wait 0.5;
		self settargetentity(param_00);
	}
}

//Function Number: 39
func_28BF(param_00)
{
	common_scripts\utility::waittill_either("death","miniguns_have_new_target");
	param_00 delete();
}

//Function Number: 40
func_28C0(param_00)
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

	thread func_28C1();
	self.var_2898 = 0;
}

//Function Number: 41
func_28C1()
{
	self notify("stop soundlittlebird_minigun_spinloop");
	self.var_2897 = 0;
	maps\_utility::play_sound_on_tag("littlebird_gatling_cooldown","tag_flash");
}

//Function Number: 42
func_28C2(param_00)
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
		if(self.var_2888)
		{
			self fireweapon();
		}

		wait var_05;
	}
}

//Function Number: 43
func_28C3(param_00)
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
func_28C4(param_00,param_01,param_02,param_03,param_04)
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
heli_damage_monitor()
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("crashing");
	self endon("leaving");
	self.damagetaken = 0;
	self.var_28C6 = undefined;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		self notify("damage_by_player");
		thread func_28C7();
		thread func_28C8(var_01);
		if(maps\_utility::is_damagefeedback_enabled())
		{
			var_01 thread updatedamagefeedback();
		}
	}
}

//Function Number: 46
func_28C7()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self endon("heli_players_dead");
	self.var_288B = 1;
	wait 1;
	self.var_288B = 0;
}

//Function Number: 47
func_28C8(param_00)
{
	self notify("attacker_seen");
	self endon("attacker_seen");
	self.var_28C6 = param_00;
	self.var_288C = param_00;
	wait level.var_287B;
	self.var_288C = undefined;
	self.var_28C6 = undefined;
}

//Function Number: 48
func_28C9(param_00)
{
	if(isdefined(param_00.var_28C6))
	{
		if(param_00.var_28C6 == self)
		{
			return 0;
		}
	}

	if(isdefined(level.var_28A0))
	{
		foreach(var_02 in level.var_28A0)
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
func_28CA()
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
func_28CB()
{
	self waittill("death");
	level notify("attack_heli_destroyed");
	level.var_289D = 1;
	wait 15;
	level.var_289F = 0;
}

//Function Number: 52
func_28CC(param_00)
{
	param_00 endon("death");
	param_00 endon("heli_players_dead");
	wait 30;
	if(!level.var_289F)
	{
		return;
	}

	func_28CD("co_cf_cmd_heli_small_fire");
	if(!level.var_289F)
	{
		return;
	}

	func_28CD("co_cf_cmd_rpg_stinger");
	wait 30;
	if(!level.var_289F)
	{
		return;
	}

	func_28CD("co_cf_cmd_heli_wonders");
}

//Function Number: 53
func_28CD(param_00)
{
	while(level.var_289E)
	{
		wait 1;
	}

	level.var_289E = 1;
	level.player playsound(param_00,"sounddone");
	level.player waittill("sounddone");
	wait 0.5;
	level.var_289E = 0;
}

//Function Number: 54
func_28CE()
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
func_28CF(param_00)
{
	common_scripts\utility::waittill_any("death","crash_done","turn_off_spotlight");
	self.var_2891 = undefined;
	if(isdefined(self))
	{
		stopfxontag(common_scripts\utility::getfx("_attack_heli_spotlight"),self,param_00);
	}
}

//Function Number: 56
func_28D0()
{
	self endon("death");
	self endon("heli_players_dead");
	if(self.vehicletype != "littlebird")
	{
		return;
	}

	thread func_28D2();
	var_00 = undefined;
	for(;;)
	{
		wait 0.05;
		switch(self.vehicletype)
		{
			case "littlebird":
				var_00 = self.var_28D1;
				break;
	
			default:
				var_00 = self.var_288F;
				break;
		}

		if(isdefined(var_00))
		{
			self setturrettargetent(var_00,(0,0,0));
		}
	}
}

//Function Number: 57
func_28D2()
{
	self endon("death");
	self endon("heli_players_dead");
	var_00 = self.var_288E;
	var_00.targetname = "original_ent";
	self.var_28D3 = spawn("script_origin",var_00.origin);
	self.var_28D3.origin = var_00.origin;
	self.var_28D3.angles = var_00.angles;
	self.var_28D3.targetname = "left_ent";
	self.var_28D4 = spawn("script_origin",var_00.origin);
	self.var_28D4.origin = var_00.origin;
	self.var_28D4.angles = var_00.angles;
	self.var_28D4.targetname = "right_ent";
	var_01 = spawnstruct();
	var_01.entity = self.var_28D3;
	var_01.right = 250;
	var_01 maps\_utility::translate_local();
	self.var_28D3 linkto(self);
	var_02 = spawnstruct();
	var_02.entity = self.var_28D4;
	var_02.right = -250;
	var_02 maps\_utility::translate_local();
	self.var_28D4 linkto(self);
	var_03 = [];
	self.var_28D1 = var_01;
	common_scripts\utility::array_thread(var_7B,::func_28D6,self);
	for(;;)
	{
		wait randomfloatrange(1,3);
		if(func_28AA() && !func_28D5())
		{
			self.var_28D1 = self.var_288F;
			continue;
		}

		var_04 = randomint(var_7B.size);
		self.var_288E = var_7B[var_04];
		self.var_28D1 = self.var_288E;
	}
}

//Function Number: 58
func_28D5()
{
	self endon("death");
	self endon("heli_players_dead");
	if(!isdefined(self.var_288F))
	{
		return 0;
	}

	if(!isplayer(self.var_288F))
	{
		return 0;
	}

	var_00 = self.var_288F;
	var_01 = maps\_utility::within_fov(var_00 geteye(),var_00 getplayerangles(),self.origin,level.cosine["35"]);
	return var_01;
}

//Function Number: 59
func_28D6(param_00)
{
	param_00 common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 60
func_28D7(param_00)
{
	var_01 = self;
	var_01 maps\_vehicle::turret_set_default_on_mode("manual");
	if(isdefined(param_00.var_288E))
	{
		var_01 settargetentity(param_00.var_288E);
	}

	var_01 setmode("manual");
	param_00 waittill("death");
	if(isdefined(param_00.var_2898) && param_00.var_2898 == 1)
	{
		thread func_28C1();
	}
}

//Function Number: 61
func_28D9()
{
	common_scripts\utility::waittill_either("death","crash_done");
	if(isdefined(self.attractor))
	{
		missile_deleteattractor(self.attractor);
	}

	if(isdefined(self.var_2885))
	{
		missile_deleteattractor(self.var_2885);
	}
}

//Function Number: 62
func_28DA(param_00)
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_default_heli_missiles");
	self.var_28DB = undefined;
	while(isdefined(self))
	{
		wait 0.05;
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		self.var_28DB = undefined;
		var_04 = undefined;
		if(isdefined(self.currentnode) && isdefined(self.currentnode.target))
		{
			var_04 = maps\_utility::getent_or_struct(self.currentnode.target,"targetname");
		}

		if(isdefined(var_04) && isdefined(var_04.script_linkto))
		{
			self.var_28DB = maps\_utility::getent_or_struct(var_04.script_linkto,"script_linkname");
		}

		if(isdefined(self.var_28DB))
		{
			var_01 = self.var_28DB;
			var_02 = var_01.var_28DC;
			var_03 = var_01.script_delay;
			var_04 waittill("trigger");
			continue;
		}

		common_scripts\utility::waittill_any("near_goal","goal");
		if(isdefined(var_01))
		{
			thread func_28E2(var_01,var_02,var_03,param_00);
		}
	}
}

//Function Number: 63
func_28DD()
{
	self notify("stop_default_heli_missiles");
}

//Function Number: 64
func_28DE(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "tag_barrel";
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	playfxontag(common_scripts\utility::getfx("_attack_heli_spotlight"),self,param_00);
	self.var_2891 = 1;
	thread func_28CF(param_00);
	if(param_01)
	{
		self endon("death");
		self endon("heli_players_dead");
		var_02 = self gettagorigin("tag_origin");
		if(!isdefined(self.var_288E))
		{
			func_2893();
		}

		self setturrettargetent(self.var_288E);
		thread func_28D0();
	}
}

//Function Number: 65
func_28DF()
{
	self notify("turn_off_spotlight");
}

//Function Number: 66
func_28E0()
{
	self endon("death");
	self endon("heli_players_dead");
	self endon("stop_spotlight_random_targets");
	if(!isdefined(self.var_288E))
	{
		thread func_2893();
	}

	if(!isdefined(self.var_28D3))
	{
		thread func_28D2();
	}

	while(isdefined(self))
	{
		wait 0.05;
		self setturrettargetent(self.var_288E,(0,0,0));
	}
}

//Function Number: 67
func_28E1()
{
	self notify("stop_spotlight_random_targets");
}

//Function Number: 68
func_28E2(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("heli_players_dead");
	if(isdefined(self.var_28E3))
	{
		var_04 = self.var_28E3;
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
		if(!isdefined(self.var_28E4))
		{
			self.var_28E4 = spawn("script_origin",param_00.origin);
			thread common_scripts\utility::delete_on_death(self.var_28E4);
		}

		self.var_28E4.origin = param_00.origin;
		param_00 = self.var_28E4;
	}

	switch(self.vehicletype)
	{
		case "mi28":
			var_06 = 0.5;
			break;
	var_7B[7]
	"tag_store_R_2_d"
	var_7B[6]
	"tag_store_L_2_d"
	var_7B[5]
	"tag_store_R_2_c"
	var_7B[4]
	"tag_store_L_2_c"
	var_7B[3]
	"tag_store_R_2_b"
	var_7B[2]
	"tag_store_L_2_b"
	var_7B[1]
	"tag_store_R_2_a"
	var_7B[0]
	"tag_store_L_2_a"
			break;

		case "littlebird":
			var_07 = 0.5;
			break;
	var_7B[1]
	"tag_missile_right"
	var_7B[0]
	"tag_missile_left"
			break;

		default:
			break;
	}

	var_08 = -1;
	for(var_09 = 0;var_09 < param_02;var_09++)
	{
		var_08++;
		if(var_08 >= var_7B.size)
		{
			var_08 = 0;
		}

		self setvehweapon(var_06);
		self.var_2889 = 1;
		var_0A = self fireweapon(var_7B[var_08],param_01);
		var_0A thread func_28B3();
		if(var_09 < param_02 - 1)
		{
			wait param_03;
		}
	}

	self.var_2889 = 0;
	self setvehweapon(var_05);
}

//Function Number: 69
func_28E5()
{
	self waittill("trigger",var_00);
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_01 = maps\_utility::array_index_by_script_index(var_01);
	func_28E7(var_00,var_01);
}

//Function Number: 70
func_28E6()
{
	self waittill("trigger",var_00);
	var_01 = maps\_utility::get_linked_structs();
	var_01 = maps\_utility::array_index_by_script_index(var_01);
	func_28E7(var_00,var_01);
}

//Function Number: 71
func_28E7(param_00,param_01)
{
	var_02 = [];
	if(level.script == "roadkill")
	{
	}

	if(param_01.vehicletype == "cobra")
	{
	}

	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++ = var_7B[1])
	{
		var_03[var_04] = spawn("script_origin",var_02[var_04].origin);
		param_01 setvehweapon("littlebird_FFAR");
		param_01 setturrettargetent(var_03[var_04]);
		var_05 = param_01 fireweapon(var_7B[var_04 % var_7B.size],var_03[var_04],(0,0,0));
		var_05 common_scripts\utility::delaycall(1,::missile_cleartarget);
		wait randomfloatrange(0.2,0.3);
	}

	wait 2;
	foreach(var_07 in var_03)
	{
		var_07 delete();
	}
}
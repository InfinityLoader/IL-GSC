/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_squad_enemies.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 499 ms
 * Timestamp: 10/27/2023 2:20:48 AM
*******************************************************************/

//Function Number: 1
squad_setup(param_00)
{
	if(!common_scripts\utility::flag_exist("squad_spawning"))
	{
		common_scripts\utility::flag_init("squad_spawning");
	}

	level.new_squad_logic = 1;
	level.merge_squad_member_max = 3;
	level.leaders = [];
	if(isdefined(param_00) && param_00)
	{
		var_01 = common_scripts\utility::getstructarray("leader","script_noteworthy");
	}
	else
	{
		var_01 = getentarray("leader","script_noteworthy");
	}

	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.targetname) && issubstr(var_03.targetname,"protector"))
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_03);
		}
	}

	level.squad_follower_func = ::setup_follower_advanced;
	thread merge_squad();
	thread squad_spread();
	thread drawleader();
	return var_01;
}

//Function Number: 2
squad_disband(param_00,param_01,param_02)
{
	if(isdefined(param_00) && param_00 > 0)
	{
		wait param_00;
	}

	if(common_scripts\utility::flag_exist("squad_spawning"))
	{
		common_scripts\utility::flag_waitopen("squad_spawning");
	}

	level notify("squad_disband");
	level.leaders = [];
	if(isdefined(param_01))
	{
		var_03 = getaiarray("axis");
		foreach(var_05 in var_03)
		{
			var_05 notify("ai_behavior_change");
			var_05.leader = undefined;
			var_05.squadmembers = undefined;
			if(isdefined(var_05.is_squad_enemy) && var_05.is_squad_enemy)
			{
				if(isdefined(param_02))
				{
					var_05 thread [[ param_01 ]](param_02);
				}
				else
				{
					var_05 thread [[ param_01 ]]();
				}
			}

			var_05.is_squad_enemy = 0;
		}
	}
}

//Function Number: 3
setup_zones(param_00,param_01)
{
	level endon("challenge_success");
	level endon("special_op_terminated");
	if(!common_scripts\utility::flag_exist("squad_spawning"))
	{
		common_scripts\utility::flag_init("squad_spawning");
	}

	var_02 = param_00 common_scripts\utility::get_links();
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_03[var_03.size] = getent(var_05,"script_linkname");
	}

	param_00 thread one_direction_trigger();
	param_00 waittill("trigger");
	if(getaiarray("axis").size > 1)
	{
		level.cleaning_up = 1;
		squad_clean_up();
		wait 2.02;
	}
	else
	{
		level.cleaning_up = 0;
	}

	if(level.leaders.size + param_01 > level.desired_squads)
	{
		param_01 = level.desired_squads - level.leaders.size;
	}

	for(var_07 = 0;var_07 < param_01;var_07++)
	{
		spawn_far_squad(var_03,undefined,undefined,undefined);
	}

	wait 1;
	level.cleaning_up = 0;
	level notify("clean_up_done");
	level notify("zone_spawn_complete");
}

//Function Number: 4
spawn_enemy_squads(param_00)
{
	level endon("challenge_success");
	level endon("special_op_terminated");
	var_01 = squad_setup();
	if(!isdefined(level.desired_squads))
	{
		level.desired_squads = 4;
	}
	else
	{
		var_02 = "Must have at least 4 squad leader spawners in level";
	}

	if(isdefined(level.squad_zoning) && level.squad_zoning)
	{
		var_03 = getentarray("zone_trig","targetname");
		foreach(var_05 in var_03)
		{
			thread setup_zones(var_05,int(var_05.script_noteworthy));
		}

		level waittill("zone_spawn_complete");
	}

	for(;;)
	{
		wait 0.15;
		if(isdefined(level.cleaning_up) && level.cleaning_up)
		{
			level waittill("clean_up_done");
		}

		if(level.leaders.size < level.desired_squads)
		{
			spawn_far_squad(var_01,undefined,undefined,param_00);
		}
	}
}

//Function Number: 5
spawn_far_squad(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(maps\_utility::is_coop())
	{
	}

	foreach(var_06 in level.leaders)
	{
		var_7B[var_7B.size] = var_06;
	}

	var_08 = undefined;
	while(param_01.size > 1)
	{
		foreach(var_0A in var_7B)
		{
			var_08 = maps\_utility::getclosest(var_0A.origin,param_01);
			param_01 = common_scripts\utility::array_remove(param_01,var_08);
			if(param_01.size == 1)
			{
				break;
			}
		}
	}

	var_08 = param_01[0];
	thread draw_debug_marker(var_08.origin,(1,1,1));
	if(isspawner(param_01[0]))
	{
		var_0C = getentarray(var_08.target,"targetname");
	}
	else
	{
		var_0C = common_scripts\utility::getstructarray(var_09.target,"targetname");
	}

	foreach(var_0E in var_0C)
	{
		if(!isdefined(var_0E.script_noteworthy))
		{
			var_0E.script_noteworthy = "follower";
		}
	}

	common_scripts\utility::flag_set("squad_spawning");
	var_10 = [];
	var_10 = spawn_enemy_group(var_0C,param_02,param_03,var_04);
	common_scripts\utility::flag_clear("squad_spawning");
	wait 0.05;
	return var_10;
}

//Function Number: 6
squad_clean_up()
{
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.protector_obj_group))
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_02);
		}
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_00,1300);
}

//Function Number: 7
squad_spread()
{
	level endon("challenge_success");
	level endon("special_op_terminated");
	for(;;)
	{
		wait 1;
		if(!isdefined(level.leaders))
		{
			continue;
		}

		if(level.leaders.size < 2)
		{
			continue;
		}

		foreach(var_01 in level.leaders)
		{
			if(!isdefined(var_01.squadmembers) || var_01.squadmembers.size < 2)
			{
				continue;
			}

			foreach(var_03 in level.leaders)
			{
				if(var_03 == var_01)
				{
					continue;
				}

				if(!isdefined(var_03.squadmembers) || var_03.squadmembers.size < 2)
				{
					continue;
				}

				if(distance(var_01.origin,var_03.origin) < 600)
				{
					foreach(var_05 in var_03.squadmembers)
					{
						if(isdefined(var_05.saw_player) && var_05.saw_player)
						{
							var_05.goalradius = 800;
						}
					}

					continue;
				}

				foreach(var_05 in var_03.squadmembers)
				{
					if(isdefined(var_05.saw_player) && var_05.saw_player)
					{
						var_05.goalradius = 600;
					}
				}
			}
		}
	}
}

//Function Number: 8
merge_squad()
{
	level endon("challenge_success");
	level endon("special_op_terminated");
	for(;;)
	{
		wait 2;
		if(!isdefined(level.leaders))
		{
			continue;
		}

		if(level.leaders.size < 2)
		{
			continue;
		}

		var_00 = level.leaders[0];
		foreach(var_02 in level.leaders)
		{
			if(var_00.squadmembers.size > var_02.squadmembers.size)
			{
				var_00 = var_02;
			}
		}

		var_04 = common_scripts\utility::array_remove(level.leaders,var_00);
		var_05 = var_04[0];
		foreach(var_02 in var_04)
		{
			if(var_05.squadmembers.size > var_02.squadmembers.size)
			{
				var_05 = var_02;
			}
		}

		var_08 = var_00.squadmembers.size + var_05.squadmembers.size + 2;
		if(var_08 <= 3)
		{
			level.leaders = common_scripts\utility::array_remove(level.leaders,var_00);
			var_00 notify("demotion");
			var_09 = common_scripts\utility::array_combine(var_00.squadmembers,var_05.squadmembers);
			var_06 thread setup_leader(var_7B);
			var_0A = common_scripts\utility::array_remove(var_7B,var_06);
			foreach(var_0C in var_0A)
			{
				if(isalive(var_0C))
				{
					var_0C thread setup_follower(var_06);
				}
			}
		}
	}
}

//Function Number: 9
spawn_enemy_group(param_00,param_01,param_02,param_03)
{
	level endon("challenge_success");
	level endon("special_op_terminated");
	var_04 = 0;
	if(isdefined(param_01))
	{
		var_04 = 1;
	}

	if(!isdefined(level.leaders))
	{
		level.leaders = [];
	}

	if(!isdefined(param_03))
	{
		param_03 = param_00.size - 1;
	}
	else
	{
		param_03 = int(min(param_00.size - 1,param_03));
	}

	var_05 = "Trying to spawn " + param_03 + " followers but only " + param_00.size - 1 + " spawners are available!";
	if(var_04 || !isspawner(param_00[0]))
	{
		var_06 = undefined;
		var_07 = undefined;
		var_08 = getspawnerarray();
		foreach(var_0A in var_08)
		{
			if(var_0A.classname == param_01)
			{
				var_06 = var_0A;
			}

			if(var_0A.classname == param_02)
			{
				var_07 = var_0A;
			}
		}

		var_0C = 0;
		var_0D = [];
		foreach(var_0F in param_00)
		{
			wait 0.05;
			if(var_0F.script_noteworthy == "leader")
			{
				var_06.script_noteworthy = "leader";
				var_06.count = 1;
				var_06.origin = var_0F.origin;
				var_06.angles = var_0F.angles;
				var_10 = var_06 maps\_utility::spawn_ai(1);
				var_0D[var_0D.size] = var_10;
			}

			if(var_0F.script_noteworthy == "follower")
			{
				if(var_0C >= param_03)
				{
					continue;
				}

				var_0C++;
				var_07.script_noteworthy = "follower";
				var_07.count = 1;
				var_07.origin = var_0F.origin;
				var_07.angles = var_0F.angles;
				var_10 = var_07 maps\_utility::spawn_ai(1);
				var_0D[var_0D.size] = var_10;
			}
		}
	}
	else
	{
		var_0C = 0;
		var_0D = [];
		foreach(var_0F in param_01)
		{
			if(var_0F.script_noteworthy == "follower")
			{
				var_0C++;
			}

			if(var_0C >= param_03)
			{
				continue;
			}

			var_0F.count = 1;
			var_10 = var_0F maps\_utility::spawn_ai(1);
			var_0D[var_0D.size] = var_10;
		}
	}

	if(!var_0D.size)
	{
		return undefined;
	}

	var_14 = [];
	foreach(var_10 in var_0D)
	{
		var_10.is_squad_enemy = 1;
		if(isalive(var_10))
		{
			var_14[var_14.size] = var_10;
		}
	}

	var_0D = var_14;
	var_17 = undefined;
	foreach(var_10 in var_0D)
	{
		if(var_10.script_noteworthy == "leader")
		{
			var_17 = var_10;
			var_17.back_occupied["left"] = 0;
			var_17.back_occupied["right"] = 0;
			var_17 thread setup_leader(var_0D);
		}
	}

	if(var_0D.size < param_00.size && !isdefined(var_17))
	{
		var_17 = var_0D[randomint(var_0D.size)];
		var_17.script_noteworthy = "leader";
		var_17 thread setup_leader(var_0D);
	}

	foreach(var_10 in var_0D)
	{
		if(isdefined(level.squad_drop_weapon_rate))
		{
			var_1B = randomfloat(1);
			if(var_1B > level.squad_drop_weapon_rate)
			{
				var_10.dropweapon = 0;
			}
		}

		if(var_10.script_noteworthy == "follower")
		{
			var_10 thread setup_follower(var_17);
		}
	}

	return var_0D;
}

//Function Number: 10
setup_leader(param_00)
{
	level endon("squad_disband");
	self notify("new_leader");
	self endon("new_leader");
	self endon("demotion");
	self.squadmembers = [];
	self.leader = undefined;
	foreach(var_02 in param_00)
	{
		if(!isalive(var_02))
		{
			param_00 common_scripts\utility::array_remove(param_00,var_02);
		}
	}

	if(!isdefined(level.new_squad_logic) || level.new_squad_logic == 0)
	{
		if(param_00.size == 1 && level.leaders.size > 0)
		{
			var_04 = level.leaders[0];
			if(level.leaders.size > 1)
			{
				var_04 = maps\_utility::get_closest_living(self.origin,level.leaders);
			}

			setup_follower(var_04);
			return;
		}
	}

	if(!maps\_utility::is_in_array(level.leaders,self))
	{
		level.leaders[level.leaders.size] = self;
	}

	if(isdefined(level.squad_leader_behavior_func))
	{
		self thread [[ level.squad_leader_behavior_func ]]();
	}
	else
	{
		self.goalradius = 2048;
		var_05 = maps\_utility::getclosest(self.origin,level.players);
		self.favoriteenemy = var_05;
		self setgoalentity(var_05);
		self setengagementmindist(300,200);
		self setengagementmaxdist(512,720);
	}

	thread wait_for_followers();
	thread enlarge_follower_goalradius_upon_seeing_player();
	if(!isdefined(level.new_squad_logic) || level.new_squad_logic == 0)
	{
		thread handle_all_followers_dying(var_01);
	}

	self waittill("death");
	var_06 = [];
	foreach(var_07 in level.leaders)
	{
		if(isdefined(var_07) && isalive(var_07))
		{
			var_04[var_04.size] = var_07;
		}
	}

	level.leaders = var_04;
	var_07 = undefined;
	foreach(var_02 in param_00)
	{
		if(isalive(var_02))
		{
			if(!isdefined(var_07))
			{
				var_07 = var_02;
				var_02 notify("promotion");
				var_02 thread setup_leader(param_00);
				continue;
			}

			var_02 thread setup_follower(var_07);
		}
	}
}

//Function Number: 11
enlarge_follower_goalradius_upon_seeing_player()
{
	level endon("squad_disband");
	self endon("new_leader");
	self endon("demotion");
	self endon("death");
	self waittill("enemy_visible");
	if(isdefined(self.squadmembers) && self.squadmembers.size)
	{
		foreach(var_01 in self.squadmembers)
		{
			var_01 notify("leader_saw_player");
		}
	}
}

//Function Number: 12
wait_for_followers()
{
	level endon("squad_disband");
	self endon("new_leader");
	self endon("demotion");
	self endon("death");
	var_00 = self.moveplaybackrate;
	for(;;)
	{
		wait 2;
		if(isdefined(self.squadmembers) && self.squadmembers.size)
		{
			var_01 = maps\_utility::get_closest_living(self.origin,self.squadmembers);
			if(isdefined(var_01) && distance(var_01.origin,self.origin) > 256)
			{
				self.moveplaybackrate = 0.85 * var_00;
			}
			else
			{
				self.moveplaybackrate = var_00;
			}
		}
	}
}

//Function Number: 13
setup_follower(param_00)
{
	level endon("squad_disband");
	self notify("assigned_new_leader");
	self endon("assigned_new_leader");
	self endon("death");
	self endon("promotion");
	self.squadmembers = undefined;
	self.leader = param_00;
	thread leader_follower_count(param_00);
	if(isdefined(level.var_3B89))
	{
		self [[ level.var_3B89 ]]();
	}

	if(isdefined(level.squad_follower_func))
	{
		self [[ level.squad_follower_func ]](param_00);
		return;
	}

	thread follow_leader_regular(param_00);
}

//Function Number: 14
leader_follower_count(param_00)
{
	level endon("squad_disband");
	self endon("assigned_new_leader");
	param_00 endon("death");
	param_00.squadmembers[param_00.squadmembers.size] = self;
	self waittill("death");
	if(!isdefined(self.leader))
	{
		return;
	}

	if(isalive(self.leader) && isdefined(self.leader.squadmembers) && self.leader.squadmembers.size > 0)
	{
		var_01 = [];
		foreach(var_03 in param_00.squadmembers)
		{
			if(isalive(var_03))
			{
				var_01[var_01.size] = var_03;
			}
		}

		param_00.squadmembers = var_01;
	}
}

//Function Number: 15
setup_follower_advanced(param_00)
{
	if(is_riotshield(param_00))
	{
		param_00.goalradius = 1300;
		var_01 = undefined;
		if(!param_00.back_occupied["right"] && !param_00.back_occupied["left"])
		{
			if(common_scripts\utility::cointoss())
			{
				follow_leader_riotshield("left");
			}
			else
			{
				follow_leader_riotshield("right");
			}

			return;
		}

		if(param_00.back_occupied["right"] && param_00.back_occupied["left"])
		{
			follow_leader_regular();
			return;
		}

		if(!param_00.back_occupied["right"] && param_00.back_occupied["left"])
		{
			follow_leader_riotshield("right");
			return;
		}

		if(param_00.back_occupied["right"] && !param_00.back_occupied["left"])
		{
			follow_leader_riotshield("left");
			return;
		}

		return;
	}

	follow_leader_regular();
}

//Function Number: 16
follow_leader_riotshield(param_00)
{
	level endon("squad_disband");
	self endon("death");
	self endon("promotion");
	self.goalradius = 128;
	self.pathenemyfightdist = 192;
	self.pathenemylookahead = 192;
	self.favoriteenemy = undefined;
	self setengagementmindist(300,200);
	self setengagementmaxdist(512,720);
	self.leader.back_occupied[param_00] = 1;
	self.is_occupying = param_00;
	thread setup_follower_goalradius_riotshield();
	for(;;)
	{
		var_01 = self.leader get_riotshield_back_pos(param_00,0);
		if(!isdefined(var_01))
		{
			follow_leader_regular();
			return;
		}

		var_02 = self.leader.origin;
		wait 0.2;
		while(isdefined(self.leader) && isalive(self.leader) && distance(self.leader.origin,var_02) < 2)
		{
			var_02 = self.leader.origin;
			wait 0.2;
		}

		if(!isalive(self.leader) || !isdefined(var_01))
		{
			self setgoalpos(self.origin);
			continue;
		}

		self setgoalpos(var_01);
	}
}

//Function Number: 17
follow_leader_regular()
{
	level endon("squad_disband");
	self endon("death");
	self endon("promotion");
	self.goalradius = 128;
	self.pathenemyfightdist = 192;
	self.pathenemylookahead = 192;
	self.favoriteenemy = undefined;
	self setengagementmindist(300,200);
	self setengagementmaxdist(512,720);
	thread setup_follower_goalradius();
	for(;;)
	{
		wait 0.2;
		if(!isalive(self.leader))
		{
			self setgoalpos(self.origin);
			continue;
		}

		self setgoalpos(self.leader.origin);
	}
}

//Function Number: 18
protector_leader_logic(param_00,param_01)
{
	level endon("squad_disband");
	self endon("death");
	self.back_occupied["left"] = 0;
	self.back_occupied["right"] = 0;
	self.protecting_obj = 1;
	self.protector_obj_group = param_00;
	var_02 = common_scripts\utility::getstruct(self.target,"targetname");
	bind_in_place(param_01,var_02.origin);
	param_01 waittill("trigger");
	wait 5;
	self.protecting_obj = 0;
	self.goalradius = 512;
	var_03 = maps\_utility::getclosest(self.origin,level.players);
	self.favoriteenemy = var_03;
	self setgoalentity(var_03);
}

//Function Number: 19
setup_follower_goalradius()
{
	common_scripts\utility::waittill_either("enemy_visible","leader_saw_player");
	self.goalradius = 600;
	self.saw_player = 1;
}

//Function Number: 20
setup_follower_goalradius_riotshield()
{
	level endon("squad_disband");
	self endon("death");
	self endon("promotion");
	self.goalradius = 8;
	self waittill("goal");
	var_00 = 10;
	var_01 = 5;
	var_02 = 120;
	for(;;)
	{
		maps\_utility::cqb_walk("on");
		if(isdefined(self.protecting_obj) && self.protecting_obj)
		{
			wait 1;
			continue;
		}

		wait 30;
		self.goalradius = 600;
		maps\_utility::cqb_walk("off");
		wait 20;
		self.goalradius = 8;
	}

	self.goalradius = 600;
	self.leader.back_occupied[self.is_occupying] = 0;
}

//Function Number: 21
get_riotshield_back_pos(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_02 = undefined;
	if(isdefined(param_01) && param_01)
	{
		if(isdefined(self.enemy) && isplayer(self.enemy))
		{
			var_02 = vectortoangles(self.enemy - self.origin);
		}
		else
		{
			return undefined;
		}
	}
	else
	{
		var_02 = self.angles;
	}

	if(param_00 == "left")
	{
		var_03 = (var_02[0],var_02[1] - 145,var_02[2]);
	}
	else
	{
		var_03 = (var_03[0],var_03[1] + 145,var_03[2]);
	}

	var_04 = vectornormalize(anglestoforward(var_03)) * 45;
	return self.origin + var_04;
}

//Function Number: 22
bind_in_place(param_00,param_01)
{
	level endon("squad_disband");
	param_00 endon("trigger");
	self endon("death");
	for(;;)
	{
		self.goalradius = 8;
		self setgoalpos(param_01);
		wait 0.05;
	}
}

//Function Number: 23
one_direction_trigger()
{
	self endon("trigger");
	var_00 = getent(self.target,"targetname");
	var_00 waittill("trigger");
	common_scripts\utility::trigger_off();
}

//Function Number: 24
is_leader_riotshield(param_00)
{
	return isdefined(param_00.leader) && param_00.leader.classname == "actor_enemy_afghan_riotshield";
}

//Function Number: 25
is_riotshield(param_00)
{
	if(param_00.classname == "actor_enemy_afghan_riotshield")
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
handle_all_followers_dying(param_00)
{
	level endon("squad_disband");
	self endon("death");
	for(;;)
	{
		wait 1;
		var_01 = 0;
		foreach(var_03 in param_00)
		{
			if(isalive(var_03))
			{
				var_01++;
			}
		}

		if(var_01 == 1 && level.leaders.size > 1)
		{
			level.leaders = common_scripts\utility::array_remove(level.leaders,self);
			var_05 = level.leaders[0];
			if(level.leaders.size > 1)
			{
				var_05 = maps\_utility::get_closest_living(self.origin,level.leaders);
			}

			thread setup_follower(var_05);
			self notify("demotion");
			return;
		}
	}
}

//Function Number: 27
drawleader()
{
	if(getdvar("squad_debug") == "" || getdvar("squad_debug") == "0")
	{
		return;
	}

	var_00 = (1,1,1);
	for(;;)
	{
		foreach(var_02 in level.leaders)
		{
			if(isalive(var_02) && isdefined(var_02.squadmembers))
			{
				foreach(var_04 in var_02.squadmembers)
				{
					if(isdefined(var_04) && isalive(var_04))
					{
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 28
draw_debug_marker(param_00,param_01)
{
	if(getdvar("squad_debug") == "" || getdvar("squad_debug") == "0")
	{
		return;
	}

	for(var_02 = 0;var_02 < 40;var_02++)
	{
		wait 0.05;
	}
}

//Function Number: 29
drawfollowers()
{
	if(getdvar("squad_debug") == "" || getdvar("squad_debug") == "0")
	{
		return;
	}

	for(;;)
	{
		var_00 = getaiarray();
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02.leader))
			{
				thread common_scripts\utility::draw_line_for_time(var_02.origin,var_02.leader.origin,0.5,0.5,1,0.1);
			}
		}

		wait 0.1;
	}
}
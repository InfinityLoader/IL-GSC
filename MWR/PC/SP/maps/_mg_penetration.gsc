/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_mg_penetration.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 236 ms
 * Timestamp: 10/27/2023 2:48:18 AM
*******************************************************************/

//Function Number: 1
gunner_think(param_00)
{
	self endon("death");
	self notify("end_mg_behavior");
	self endon("end_mg_behavior");
	self.can_fire_turret = 1;
	self.wants_to_fire = 0;
	if(!maps\_mgturret::use_the_turret(param_00))
	{
		self notify("continue_cover_script");
		return;
	}

	self.last_enemy_sighting_position = undefined;
	thread record_enemy_sightings();
	var_01 = anglestoforward(param_00.angles);
	var_02 = spawn("script_origin",(0,0,0));
	thread target_ent_cleanup(var_02);
	var_02.origin = param_00.origin + var_01 * 500;
	if(isdefined(self.last_enemy_sighting_position))
	{
		var_02.origin = self.last_enemy_sighting_position;
	}

	param_00 settargetentity(var_02);
	var_03 = undefined;
	for(;;)
	{
		if(!isalive(self.current_enemy))
		{
			stop_firing();
			self waittill("new_enemy");
		}

		start_firing();
		shoot_enemy_until_he_hides_then_shoot_wall(var_02);
		if(!isalive(self.current_enemy))
		{
			continue;
		}

		if(self cansee(self.current_enemy))
		{
			continue;
		}

		self waittill("saw_enemy");
	}
}

//Function Number: 2
target_ent_cleanup(param_00)
{
	common_scripts\utility::waittill_either("death","end_mg_behavior");
	param_00 delete();
}

//Function Number: 3
shoot_enemy_until_he_hides_then_shoot_wall(param_00)
{
	self endon("death");
	self endon("new_enemy");
	self.current_enemy endon("death");
	var_01 = self.current_enemy;
	while(self cansee(var_01))
	{
		var_02 = vectortoangles(var_01 geteye() - param_00.origin);
		var_02 = anglestoforward(var_02);
		param_00 moveto(param_00.origin + var_02 * 12,0.1);
		wait(0.1);
	}

	if(isplayer(var_01))
	{
		self endon("saw_enemy");
		var_03 = var_01 geteye();
		var_02 = vectortoangles(var_03 - param_00.origin);
		var_02 = anglestoforward(var_02);
		var_04 = 150;
		var_05 = distance(param_00.origin,self.last_enemy_sighting_position) / var_04;
		if(var_05 > 0)
		{
			param_00 moveto(self.last_enemy_sighting_position,var_05);
			wait(var_05);
		}

		var_06 = param_00.origin + var_02 * 180;
		var_07 = get_suppress_point(self geteye(),param_00.origin,var_06);
		if(!isdefined(var_07))
		{
			var_07 = param_00.origin;
		}

		param_00 moveto(param_00.origin + var_02 * 80 + (0,0,randomfloatrange(15,50) * -1),3,1,1);
		wait(3.5);
		param_00 moveto(var_07 + var_02 * -20,3,1,1);
	}

	wait(randomfloatrange(2.5,4));
	stop_firing();
}

//Function Number: 4
set_firing(param_00)
{
	if(param_00)
	{
		self.can_fire_turret = 1;
		if(self.wants_to_fire)
		{
			self.turret notify("startfiring");
			return;
		}

		return;
	}

	self.can_fire_turret = 0;
	self.turret notify("stopfiring");
}

//Function Number: 5
stop_firing()
{
	self.wants_to_fire = 0;
	self.turret notify("stopfiring");
}

//Function Number: 6
start_firing()
{
	self.wants_to_fire = 1;
	if(self.can_fire_turret)
	{
		self.turret notify("startfiring");
	}
}

//Function Number: 7
create_mg_team()
{
	if(isdefined(level.mg_gunner_team))
	{
		level.mg_gunner_team[level.mg_gunner_team.size] = self;
		return;
	}

	level.mg_gunner_team = [];
	level.mg_gunner_team[level.mg_gunner_team.size] = self;
	waittillframeend;
	var_00 = spawnstruct();
	common_scripts\utility::array_thread(level.mg_gunner_team,::mg_gunner_death_notify,var_00);
	var_01 = level.mg_gunner_team;
	level.mg_gunner_team = undefined;
	var_00 waittill("gunner_died");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02]))
		{
			continue;
		}

		var_01[var_02] notify("stop_using_built_in_burst_fire");
		var_01[var_02] thread solo_fires();
	}
}

//Function Number: 8
mg_gunner_death_notify(param_00)
{
	self waittill("death");
	param_00 notify("gunner_died");
}

//Function Number: 9
mgteam_take_turns_firing(param_00)
{
	wait(1);
	level notify("new_mg_firing_team" + param_00[0].script_noteworthy);
	level endon("new_mg_firing_team" + param_00[0].script_noteworthy);
	for(;;)
	{
		dual_firing(param_00);
		solo_firing(param_00);
	}
}

//Function Number: 10
solo_firing(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isalive(param_00[var_02]))
		{
			continue;
		}

		var_01 = param_00[var_02];
		break;
	}

	if(!isdefined(var_01))
	{
	}
}

//Function Number: 11
solo_fires()
{
	self endon("death");
	for(;;)
	{
		self.turret startfiring();
		wait(randomfloatrange(0.3,0.7));
		self.turret stopfiring();
		wait(randomfloatrange(0.1,1.1));
	}
}

//Function Number: 12
dual_firing(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01] endon("death");
	}

	var_02 = 0;
	var_03 = 1;
	for(;;)
	{
		if(isalive(param_00[var_02]))
		{
			param_00[var_02] set_firing(1);
		}

		if(isalive(param_00[var_03]))
		{
			param_00[var_03] set_firing(0);
		}

		var_04 = var_02;
		var_02 = var_03;
		var_03 = var_04;
		wait(randomfloatrange(2.3,3.5));
	}
}

//Function Number: 13
spotted_an_enemy(param_00,param_01)
{
	start_firing();
	self endon("death");
	self endon("new_enemy");
	param_01 endon("death");
	while(self cansee(param_01))
	{
		var_02 = vectortoangles(param_01 geteye() - param_00.origin);
		var_02 = anglestoforward(var_02);
		param_00 moveto(param_00.origin + var_02 * 10,0.2);
		wait(0.2);
	}

	var_02 = vectortoangles(param_01 geteye() - param_00.origin);
	var_02 = anglestoforward(var_02);
	var_03 = 150;
	var_04 = distance(param_00.origin,self.last_enemy_sighting_position) / var_03;
	param_00 moveto(self.last_enemy_sighting_position,var_04);
	wait(var_04);
	var_05 = param_00.origin;
	param_00 moveto(param_00.origin + var_02 * 80 + (0,0,-25),3,1,1);
	wait(3.5);
	param_00 moveto(var_05 + var_02 * -20,3,1,1);
	wait(1);
	stop_firing();
}

//Function Number: 14
get_suppress_point(param_00,param_01,param_02)
{
	var_03 = distance(param_01,param_02) * 0.05;
	if(var_03 < 5)
	{
		var_03 = 5;
	}

	if(var_03 > 20)
	{
		var_03 = 20;
	}

	var_04 = param_02 - param_01;
	var_04 = (var_04[0] / var_03,var_04[1] / var_03,var_04[2] / var_03);
	var_05 = (0,0,0);
	var_06 = undefined;
	for(var_07 = 0;var_07 < var_03 + 2;var_07++)
	{
		var_08 = bullettrace(param_00,param_01 + var_05,0,undefined);
		if(var_08["fraction"] < 1)
		{
			var_06 = var_08["position"];
			break;
		}

		var_05 = var_05 + var_04;
	}

	return var_06;
}

//Function Number: 15
record_enemy_sightings()
{
	self endon("death");
	self endon("end_mg_behavior");
	self.current_enemy = undefined;
	for(;;)
	{
		record_sighting();
		wait(0.05);
	}
}

//Function Number: 16
record_sighting()
{
	if(!isalive(self.enemy))
	{
		return;
	}

	if(!self cansee(self.enemy))
	{
		return;
	}

	self.last_enemy_sighting_position = self.enemy geteye();
	self notify("saw_enemy");
	if(!isalive(self.current_enemy) || self.current_enemy != self.enemy)
	{
		self.current_enemy = self.enemy;
		self notify("new_enemy");
	}
}
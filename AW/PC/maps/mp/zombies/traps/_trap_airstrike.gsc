/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_airstrike.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 118 ms
 * Timestamp: 4/22/2024 2:13:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachelaser("trap_zm");
	precacheitem("trap_missile_zm_mp");
	precacheitem("orbitalsupport_missile_mp");
}

//Function Number: 2
trap_airstrike_begin()
{
	var_00 = [];
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		if(var_03.script_noteworthy == "trap_airstrike_target")
		{
			var_00 = common_scripts\utility::add_to_array(var_00,var_03);
		}
	}

	wait(3);
	for(var_05 = 0;var_05 < 12;var_05++)
	{
		var_00 = common_scripts\utility::array_randomize(var_00);
		var_00 = common_scripts\utility::array_sort_by_handler(var_00,::zombies_in_strike_zone);
		var_00 = common_scripts\utility::array_reverse(var_00);
		var_06 = var_00[0];
		var_00 = common_scripts\utility::array_remove(var_00,var_06);
		thread trap_airstrike_fire_missile(var_06);
		wait(randomfloatrange(0.5,1.5));
	}
}

//Function Number: 3
zombies_in_strike_zone()
{
	self.numzombies = 0;
	var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_00 = sortbydistance(var_00,self.origin,384);
	self.numzombies = var_00.size;
	return self.numzombies;
}

//Function Number: 4
trap_airstrike_fire_missile(param_00)
{
	var_01 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] + 8000);
	var_02 = magicbullet("trap_missile_zm_mp",var_01,param_00.origin,self.owner);
	var_02 thread trap_airstrike_laser(var_01,param_00.origin);
	var_02 thread trap_airstrike_damage_think(self.owner);
}

//Function Number: 5
trap_airstrike_laser(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_03 = vectortoangles(param_01 - param_00);
	var_02.origin = param_00;
	var_02.angles = var_03;
	var_02.start_origin = param_00;
	var_02.start_angles = var_03;
	var_02 setmodel("tag_laser");
	var_02 laseron("trap_zm");
	var_04 = spawnfx(common_scripts\utility::getfx("trap_airstrike_laser_target"),param_01,(0,0,90));
	triggerfx(var_04);
	self waittill("death");
	var_02 delete();
	var_04 delete();
}

//Function Number: 6
trap_airstrike_damage_think(param_00)
{
	self waittill("death");
	var_01 = self.origin;
	thread trap_airstrike_radius_damage(var_01);
	physicsexplosionsphere(var_01,512,64,randomfloatrange(2,5));
	earthquake(0.3,0.5,var_01,400);
	playrumbleonposition("artillery_rumble",var_01);
}

//Function Number: 7
trap_airstrike_radius_damage(param_00)
{
	wait(0.05);
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_02 = sortbydistance(var_01,param_00,384);
	var_03 = sortbydistance(var_02,param_00,128);
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.agentteam) && var_05.agentteam == level.playerteam)
		{
			if(common_scripts\utility::array_contains(var_03,var_05) && var_05.health > 1)
			{
				var_05 dodamage(1,param_00);
			}

			continue;
		}

		if(isplayer(var_05))
		{
			if(!maps\mp\zombies\_util::isplayerinlaststand(var_05))
			{
				if(common_scripts\utility::array_contains(var_03,var_05))
				{
					var_06 = var_05.health * 0.5;
					if(var_06 > 20)
					{
						var_06 = 20;
					}

					var_05 dodamage(var_06,param_00);
				}
				else if(var_05.health > 1)
				{
					var_05 dodamage(1,param_00);
				}
			}

			continue;
		}

		if(var_05 maps\mp\zombies\_util::istrapresistant())
		{
			if(common_scripts\utility::array_contains(var_03,var_05))
			{
				var_07 = 0.5;
			}
			else
			{
				var_07 = 0.1;
			}

			var_06 = var_05.health * var_07;
			if(isdefined(var_05.maxhealth))
			{
				var_06 = var_05.maxhealth * var_07;
			}
		}
		else if(common_scripts\utility::array_contains(var_03,var_05))
		{
			var_06 = var_05.health + 10;
			if(isdefined(var_05.maxhealth))
			{
				var_06 = var_05.maxhealth + 10;
			}
		}
		else
		{
			var_06 = var_05.health * 0.5;
			if(isdefined(var_05.maxhealth))
			{
				var_06 = var_05.maxhealth * 0.5;
			}
		}

		var_05 dodamage(var_06,param_00,self.owner,self.owner,"MOD_EXPLOSIVE","trap_missile_zm_mp");
	}
}
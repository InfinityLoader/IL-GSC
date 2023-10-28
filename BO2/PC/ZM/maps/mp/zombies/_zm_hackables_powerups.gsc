/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_powerups.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:11:49 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
unhackable_powerup(name)
{
	ret = 0;
	switch(name)
	{
		case "bonus_points_player":
		case "bonus_points_team":
		case "lose_points_team":
		case "random_weapon":
			ret = 1;
			break;
	}

	return ret;
}

//Function Number: 2
hack_powerups()
{
	while(1)
	{
		level waittill("powerup_dropped",powerup);
		if(!(unhackable_powerup(powerup.powerup_name)))
		{
			struct = spawnstruct();
			struct.origin = powerup.origin;
			struct.radius = 65;
			struct.height = 72;
			struct.script_float = 5;
			struct.script_int = 5000;
			struct.powerup = powerup;
			powerup thread powerup_pickup_watcher(struct);
			maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(struct,::powerup_hack);
		}
	}
}

//Function Number: 3
powerup_pickup_watcher(powerup_struct)
{
	self endon("hacked");
	self waittill("death");
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(powerup_struct);
}

//Function Number: 4
powerup_hack(hacker)
{
	self.powerup notify("hacked");
	if(IsDefined(self.powerup.zombie_grabbable) && self.powerup.zombie_grabbable)
	{
		self.powerup notify("powerup_timedout");
		origin = self.powerup.origin;
		self.powerup delete();
		self.powerup = maps/mp/zombies/_zm_net::network_safe_spawn("powerup",1,"script_model",origin);
		if(IsDefined(self.powerup))
		{
			self.powerup maps/mp/zombies/_zm_powerups::powerup_setup("full_ammo");
			self.powerup thread maps/mp/zombies/_zm_powerups::powerup_timeout();
			self.powerup thread maps/mp/zombies/_zm_powerups::powerup_wobble();
			self.powerup thread maps/mp/zombies/_zm_powerups::powerup_grab();
		}
	}
	else if(self.powerup.powerup_name == "full_ammo")
	{
		self.powerup maps/mp/zombies/_zm_powerups::powerup_setup("fire_sale");
	}
	else
	{
		self.powerup maps/mp/zombies/_zm_powerups::powerup_setup("full_ammo");
	}

	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self);
}
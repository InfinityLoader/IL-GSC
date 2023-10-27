/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_wallbuys.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 3:03:11 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
hack_wallbuys()
{
	weapon_spawns = getstructarray("weapon_upgrade","targetname");
	for(i = 0;i < weapon_spawns.size;i++)
	{
		if(weapontype(weapon_spawns[i].zombie_weapon_upgrade) == "grenade")
		{
		}
		else if(weapontype(weapon_spawns[i].zombie_weapon_upgrade) == "melee")
		{
		}
		else if(weapontype(weapon_spawns[i].zombie_weapon_upgrade) == "mine")
		{
		}
		else if(weapontype(weapon_spawns[i].zombie_weapon_upgrade) == "bomb")
		{
		}
		else
		{
			struct = spawnstruct();
			struct.origin = weapon_spawns[i].origin;
			struct.radius = 48;
			struct.height = 48;
			struct.script_float = 2;
			struct.script_int = 3000;
			struct.wallbuy = weapon_spawns[i];
			maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(struct,::wallbuy_hack);
		}
	}

	bowie_triggers = getentarray("bowie_upgrade","targetname");
	array_thread(bowie_triggers,maps/mp/zombies/_zm_equip_hacker::hide_hint_when_hackers_active);
}

//Function Number: 2
wallbuy_hack(hacker)
{
	self.wallbuy.hacked = 1;
	self.clientfieldname = self.wallbuy.zombie_weapon_upgrade + "_" + self.origin;
	level setclientfield(self.clientfieldname,2);
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self);
}
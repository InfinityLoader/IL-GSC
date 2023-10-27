/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_perks.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 3:03:10 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
hack_perks()
{
	vending_triggers = getentarray("zombie_vending","targetname");
	for(i = 0;i < vending_triggers.size;i++)
	{
		struct = spawnstruct();
		if(IsDefined(vending_triggers[i].machine))
		{
			machine[0] = vending_triggers[i].machine;
		}
		else
		{
			machine = getentarray(vending_triggers[i].target,"targetname");
		}

		struct.origin = 48 + VectorScale((0,0,1));
		struct.radius = 48;
		struct.height = 64;
		struct.script_float = 5;
		while(!(IsDefined(vending_triggers[i].cost)))
		{
			wait(0.05);
		}

		struct.script_int = int(vending_triggers[i].cost * -1);
		struct.perk = vending_triggers[i];
		if(IsDefined(level._hack_perks_override))
		{
			struct = struct [[ level._hack_perks_override ]]();
		}

		vending_triggers[i].hackable = struct;
		maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(struct,::perk_hack,::perk_hack_qualifier);
	}

	level._solo_revive_machine_expire_func = ::solo_revive_expire_func;
}

//Function Number: 2
solo_revive_expire_func()
{
	if(IsDefined(self.hackable))
	{
		maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self.hackable);
		self.hackable = undefined;
	}
}

//Function Number: 3
perk_hack_qualifier(player)
{
	if(IsDefined(player._retain_perks))
	{
		return 0;
	}

	if(IsDefined(self.perk) && IsDefined(self.perk.script_noteworthy))
	{
		if(player hasperk(self.perk.script_noteworthy))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
perk_hack(hacker)
{
	if(flag("solo_game") && self.perk.script_noteworthy == "specialty_quickrevive")
	{
		hacker.lives--;
	}

	hacker notify(self.perk.script_noteworthy + "_stop");
	hacker playsoundtoplayer("evt_perk_throwup",hacker);
	if(IsDefined(hacker.perk_hud))
	{
		keys = getarraykeys(hacker.perk_hud);
		for(i = 0;i < hacker.perk_hud.size;i++)
		{
			hacker.perk_hud[keys[i]].x = i * 30;
		}
	}
}
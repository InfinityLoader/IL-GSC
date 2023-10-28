/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_packapunch.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:48 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
hack_packapunch()
{
	vending_weapon_upgrade_trigger = getentarray("specialty_weapupgrade","script_noteworthy");
	perk = getent(vending_weapon_upgrade_trigger[0].target,"targetname");
	if(IsDefined(perk))
	{
		struct = spawnstruct();
		struct.origin = 48 + VectorScale((0,0,1));
		struct.radius = 48;
		struct.height = 48;
		struct.script_float = 5;
		struct.script_int = -1000;
		level._pack_hack_struct = struct;
		maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(level._pack_hack_struct,::packapunch_hack);
		level._pack_hack_struct pack_trigger_think();
	}
}

//Function Number: 2
pack_trigger_think()
{
	if(!(flag_exists("enter_nml")))
	{
		return;
	}

	while(1)
	{
		flag_wait("enter_nml");
		self.script_int = -1000;
		while(flag("enter_nml"))
		{
			wait(1);
		}
	}
}

//Function Number: 3
packapunch_hack(hacker)
{
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(level._pack_hack_struct);
	level._pack_hack_struct.script_int = 0;
	level notify("packapunch_hacked");
}
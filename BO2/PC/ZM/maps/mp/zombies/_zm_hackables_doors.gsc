/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_doors.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 3:03:09 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_blockers;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
door_struct_debug()
{
	while(1)
	{
		wait(0.1);
		origin = self.origin;
		point = origin;
		for(i = 1;i < 5;i++)
		{
			point = origin + AnglesToForward(self.door.angles) * i * 2;
			passed = bullettracepassed(point,origin,0,undefined);
			color = VectorScale((0,1,0));
			if(!(passed))
			{
				color = VectorScale((1,0,0));
			}

/#
			print3d(point,"+",color,1,1);
#/
		}
	}
}

//Function Number: 2
hack_doors(targetname,door_activate_func)
{
	if(!(IsDefined(targetname)))
	{
		targetname = "zombie_door";
	}

	doors = getentarray(targetname,"targetname");
	if(!(IsDefined(door_activate_func)))
	{
		door_activate_func = maps/mp/zombies/_zm_blockers::door_opened;
	}

	for(i = 0;i < doors.size;i++)
	{
		door = doors[i];
		struct = spawnstruct();
		struct.origin = door.origin + AnglesToForward(door.angles) * 2;
		struct.radius = 48;
		struct.height = 72;
		struct.script_float = 32.7;
		struct.script_int = 200;
		struct.door = door;
		struct.no_bullet_trace = 1;
		struct.door_activate_func = door_activate_func;
		trace_passed = 0;
		door thread hide_door_buy_when_hacker_active(struct);
		maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(struct,::door_hack);
		door thread watch_door_for_open(struct);
	}
}

//Function Number: 3
hide_door_buy_when_hacker_active(door_struct)
{
	self endon("death");
	self endon("door_hacked");
	self endon("door_opened");
	maps/mp/zombies/_zm_equip_hacker::hide_hint_when_hackers_active();
}

//Function Number: 4
watch_door_for_open(door_struct)
{
	self waittill("door_opened");
	self endon("door_hacked");
	remove_all_door_hackables_that_target_door(door_struct.door);
}

//Function Number: 5
door_hack(hacker)
{
	self.door notify("door_hacked");
	self.door notify("kill_door_think");
	remove_all_door_hackables_that_target_door(self.door);
	self.door [[ self.door_activate_func ]]();
	self.door._door_open = 1;
}

//Function Number: 6
remove_all_door_hackables_that_target_door(door)
{
	candidates = [];
	for(i = 0;i < level._hackable_objects.size;i++)
	{
		obj = level._hackable_objects[i];
		if(IsDefined(obj.door) && obj.door.target == door.target)
		{
			candidates[candidates.size] = obj;
		}
	}

	for(i = 0;i < candidates.size;i++)
	{
		maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(candidates[i]);
	}
}
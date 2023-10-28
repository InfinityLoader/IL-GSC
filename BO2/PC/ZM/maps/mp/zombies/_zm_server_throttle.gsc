/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_server_throttle.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:54 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
server_choke_init(id,max)
{
	if(!(IsDefined(level.zombie_server_choke_ids_max)))
	{
		level.zombie_server_choke_ids_max = [];
		level.zombie_server_choke_ids_count = [];
	}

	level.zombie_server_choke_ids_max[id] = max;
	level.zombie_server_choke_ids_count[id] = 0;
	level thread server_choke_thread(id);
}

//Function Number: 2
server_choke_thread(id)
{
	while(1)
	{
		wait(0.05);
		level.zombie_server_choke_ids_count[id] = 0;
	}
}

//Function Number: 3
server_choke_safe(id)
{
	return level.zombie_server_choke_ids_count[id] < level.zombie_server_choke_ids_max[id];
}

//Function Number: 4
server_choke_action(id,choke_action,arg1,arg2,arg3)
{
/#
	assert(IsDefined(level.zombie_server_choke_ids_max[id]),"server Choke: " + id + " undefined");
		for(;;)
		{
#/
		if(!(server_choke_safe(id)))
		{
			wait(0.05);
		}
	}

	level.zombie_server_choke_ids_count[id]++;
	if(!(IsDefined(arg1)))
	{
		return [[ choke_action ]]();
	}

	if(!(IsDefined(arg2)))
	{
		return [[ choke_action ]](arg1);
	}

	if(!(IsDefined(arg3)))
	{
		return [[ choke_action ]](arg1,arg2);
	}

	return [[ choke_action ]](arg1,arg2,arg3);
}

//Function Number: 5
server_entity_valid(entity)
{
	if(!(IsDefined(entity)))
	{
		return 0;
	}
}

//Function Number: 6
server_safe_init(id,max)
{
	if(!IsDefined(level.zombie_server_choke_ids_max) || !IsDefined(level.zombie_server_choke_ids_max[id]))
	{
		server_choke_init(id,max);
	}

/#
	assert(max == level.zombie_server_choke_ids_max[id]);
#/
}

//Function Number: 7
_server_safe_ground_trace(pos)
{
	return groundpos(pos);
}

//Function Number: 8
server_safe_ground_trace(id,max,origin)
{
	server_safe_init(id,max);
	return server_choke_action(id,::_server_safe_ground_trace,origin);
}

//Function Number: 9
_server_safe_ground_trace_ignore_water(pos)
{
	return groundpos_ignore_water(pos);
}

//Function Number: 10
server_safe_ground_trace_ignore_water(id,max,origin)
{
	server_safe_init(id,max);
	return server_choke_action(id,::_server_safe_ground_trace_ignore_water,origin);
}
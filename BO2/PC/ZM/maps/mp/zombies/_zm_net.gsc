/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_net.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 3:03:14 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
network_choke_init(id,max)
{
	if(!(IsDefined(level.zombie_network_choke_ids_max)))
	{
		level.zombie_network_choke_ids_max = [];
		level.zombie_network_choke_ids_count = [];
	}

	level.zombie_network_choke_ids_max[id] = max;
	level.zombie_network_choke_ids_count[id] = 0;
	level thread network_choke_thread(id);
}

//Function Number: 2
network_choke_thread(id)
{
	while(1)
	{
		wait_network_frame();
		wait_network_frame();
		level.zombie_network_choke_ids_count[id] = 0;
	}
}

//Function Number: 3
network_choke_safe(id)
{
	return level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id];
}

//Function Number: 4
network_choke_action(id,choke_action,arg1,arg2,arg3)
{
/#
	assert(IsDefined(level.zombie_network_choke_ids_max[id]),"Network Choke: " + id + " undefined");
#/
	while(!(network_choke_safe(id)))
	{
		wait(0.05);
	}

	level.zombie_network_choke_ids_count[id]++;
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
network_entity_valid(entity)
{
	if(!(IsDefined(entity)))
	{
		return 0;
	}
}

//Function Number: 6
network_safe_init(id,max)
{
	if(!IsDefined(level.zombie_network_choke_ids_max) || !IsDefined(level.zombie_network_choke_ids_max[id]))
	{
		network_choke_init(id,max);
	}

/#
	assert(max == level.zombie_network_choke_ids_max[id]);
#/
}

//Function Number: 7
_network_safe_spawn(classname,origin)
{
	return spawn(classname,origin);
}

//Function Number: 8
network_safe_spawn(id,max,classname,origin)
{
	network_safe_init(id,max);
	return network_choke_action(id,::_network_safe_spawn,classname,origin);
}

//Function Number: 9
_network_safe_play_fx_on_tag(fx,entity,tag)
{
	if(network_entity_valid(entity))
	{
		playfxontag(fx,entity,tag);
	}
}

//Function Number: 10
network_safe_play_fx_on_tag(id,max,fx,entity,tag)
{
	network_safe_init(id,max);
	network_choke_action(id,::_network_safe_play_fx_on_tag,fx,entity,tag);
}
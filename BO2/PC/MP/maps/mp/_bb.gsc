/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_bb.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 3:01:12 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player thread onplayerspawned();
		player thread onplayerdeath();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	self._bbdata = [];
	for(;;)
	{
		self waittill("spawned_player");
		self._bbdata["score"] = 0;
		self._bbdata["momentum"] = 0;
		self._bbdata["spawntime"] = GetTime();
		self._bbdata["shots"] = 0;
		self._bbdata["hits"] = 0;
	}
}

//Function Number: 4
onplayerdisconnect()
{
	for(;;)
	{
		self waittill("disconnect");
		self commitspawndata();
		break;
	}
}

//Function Number: 5
onplayerdeath()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		self commitspawndata();
	}
}

//Function Number: 6
commitspawndata()
{
/#
/#
	assert(IsDefined(self._bbdata));
#/
#/
	if(!(IsDefined(self._bbdata)))
	{
		return;
	}

	bbprint("mpplayerlives","gametime %d spawnid %d lifescore %d lifemomentum %d lifetime %d name %s",GetTime(),getplayerspawnid(self),self._bbdata["score"],self._bbdata["momentum"],GetTime() - self._bbdata["spawntime"],self.name);
}

//Function Number: 7
commitweapondata(spawnid,currentweapon,time0)
{
/#
/#
	assert(IsDefined(self._bbdata));
#/
#/
	if(!(IsDefined(self._bbdata)))
	{
		return;
	}

	time1 = GetTime();
	bbprint("mpweapons","spawnid %d name %s duration %d shots %d hits %d",spawnid,currentweapon,time1 - time0,self._bbdata["shots"],self._bbdata["hits"]);
	self._bbdata["shots"] = 0;
	self._bbdata["hits"] = 0;
}

//Function Number: 8
bbaddtostat(statname,delta)
{
	if(IsDefined(self._bbdata) && IsDefined(self._bbdata[statname]))
	{
		self._bbdata[statname] = self._bbdata[statname] + delta;
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_objpoints.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:34 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/gametypes/_hud_util;

//Function Number: 1
init()
{
	precacheshader("objpoint_default");
	level.objpointnames = [];
	level.objpoints = [];
	if(level.splitscreen)
	{
		level.objpointsize = 15;
	}
	else
	{
		level.objpointsize = 8;
	}

	level.objpoint_alpha_default = 0.5;
	level.objpointscale = 1;
}

//Function Number: 2
createteamobjpoint(name,origin,team,shader,alpha,scale)
{
/#
	assert(IsDefined(level.teams[team]) || team == "all");
#/
	objpoint = getobjpointbyname(name);
	if(IsDefined(objpoint))
	{
		deleteobjpoint(objpoint);
	}

	if(!(IsDefined(shader)))
	{
		shader = "objpoint_default";
	}

	if(!(IsDefined(scale)))
	{
		scale = 1;
	}

	if(team != "all")
	{
		objpoint = newteamhudelem(team);
	}
	else
	{
		objpoint = newhudelem();
	}

	objpoint.name = name;
	objpoint.x = origin[0];
	objpoint.y = origin[1];
	objpoint.z = origin[2];
	objpoint.team = team;
	objpoint.isflashing = 0;
	objpoint.isshown = 1;
	objpoint.fadewhentargeted = 1;
	objpoint.archived = 0;
	objpoint setshader(shader,level.objpointsize,level.objpointsize);
	objpoint setwaypoint(1);
	if(IsDefined(alpha))
	{
		objpoint.alpha = alpha;
	}
	else
	{
		objpoint.alpha = level.objpoint_alpha_default;
	}

	objpoint.basealpha = objpoint.alpha;
	objpoint.index = level.objpointnames.size;
	level.objpoints[name] = objpoint;
	level.objpointnames[level.objpointnames.size] = name;
	return objpoint;
}

//Function Number: 3
deleteobjpoint(oldobjpoint)
{
/#
	assert(level.objpoints.size == level.objpointnames.size);
#/
	if(level.objpoints.size == 1)
	{
/#
		assert(level.objpointnames[0] == oldobjpoint.name);
#/
/#
		assert(IsDefined(level.objpoints[oldobjpoint.name]));
#/
		level.objpoints = [];
		level.objpointnames = [];
		oldobjpoint destroy();
		return;
	}

	newindex = oldobjpoint.index;
	oldindex = level.objpointnames.size - 1;
	objpoint = getobjpointbyindex(oldindex);
	level.objpointnames[newindex] = objpoint.name;
	objpoint.index = newindex;
	level.objpointnames[oldindex] = undefined;
	level.objpoints[oldobjpoint.name] = undefined;
	oldobjpoint destroy();
}

//Function Number: 4
updateorigin(origin)
{
	if(self.x != origin[0])
	{
		self.x = origin[0];
	}

	if(self.y != origin[1])
	{
		self.y = origin[1];
	}

	if(self.z != origin[2])
	{
		self.z = origin[2];
	}
}

//Function Number: 5
setoriginbyname(name,origin)
{
	objpoint = getobjpointbyname(name);
	objpoint updateorigin(origin);
}

//Function Number: 6
getobjpointbyname(name)
{
	if(IsDefined(level.objpoints[name]))
	{
		return level.objpoints[name];
	}
	else
	{
		return undefined;
	}
}

//Function Number: 7
getobjpointbyindex(index)
{
	if(IsDefined(level.objpointnames[index]))
	{
		return level.objpoints[level.objpointnames[index]];
	}
	else
	{
		return undefined;
	}
}

//Function Number: 8
startflashing()
{
	self endon("stop_flashing_thread");
	if(self.isflashing)
	{
		return;
	}

	self.isflashing = 1;
	while(self.isflashing)
	{
		self fadeovertime(0.75);
		self.alpha = 0.35 * self.basealpha;
		wait(0.75);
		self fadeovertime(0.75);
		self.alpha = self.basealpha;
		wait(0.75);
	}

	self.alpha = self.basealpha;
}

//Function Number: 9
stopflashing()
{
	if(!(self.isflashing))
	{
		return;
	}

	self.isflashing = 0;
}
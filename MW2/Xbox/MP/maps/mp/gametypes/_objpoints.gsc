/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_objpoints.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

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

createteamobjpoint(name, origin, team, shader, alpha, scale)
{
	objpoint = getobjpointbyname(name);
	if(isdefined(objpoint))
	{
		deleteobjpoint(objpoint);
	}

	if(!isdefined(shader))
	{
		shader = "objpoint_default";
	}

	if(!isdefined(scale))
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
	objpoint setshader(shader, level.objpointsize, level.objpointsize);
	objpoint setwaypoint(1, 0);
	if(isdefined(alpha))
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

deleteobjpoint(oldobjpoint)
{
	if(level.objpoints.size == 1)
	{
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
		return;
	}
}

setoriginbyname(name, origin)
{
	objpoint = getobjpointbyname(name);
	objpoint updateorigin(origin);
}

getobjpointbyname(name)
{
	if(isdefined(level.objpoints[name]))
	{
		return level.objpoints[name];
	}

	return undefined;
}

getobjpointbyindex(index)
{
	if(isdefined(level.objpointnames[index]))
	{
		return level.objpoints[level.objpointnames[index]];
	}

	return undefined;
}

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
		wait 0.75;
		self fadeovertime(0.75);
		self.alpha = self.basealpha;
		wait 0.75;
	}

	self.alpha = self.basealpha;
}

stopflashing()
{
	if(!self.isflashing)
	{
		return;
	}

	self.isflashing = 0;
}
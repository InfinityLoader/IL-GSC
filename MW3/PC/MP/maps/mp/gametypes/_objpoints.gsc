/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_objpoints.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 140 ms
 * Timestamp: 10/27/2023 2:12:44 AM
*******************************************************************/

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
createteamobjpoint(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getobjpointbyname(param_00);
	if(isdefined(var_06))
	{
		deleteobjpoint(var_06);
	}

	if(!isdefined(param_03))
	{
		param_03 = "objpoint_default";
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(param_02 != "all")
	{
		var_06 = newteamhudelem(param_02);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.name = param_00;
	var_06.x = param_01[0];
	var_06.y = param_01[1];
	var_06.z = param_01[2];
	var_06.team = param_02;
	var_06.isflashing = 0;
	var_06.isshown = 1;
	var_06 setshader(param_03,level.objpointsize,level.objpointsize);
	var_06 setwaypoint(1,0);
	if(isdefined(param_04))
	{
		var_06.alpha = param_04;
	}
	else
	{
		var_06.alpha = level.objpoint_alpha_default;
	}

	var_06.basealpha = var_06.alpha;
	var_06.index = level.objpointnames.size;
	level.objpoints[param_00] = var_06;
	level.objpointnames[level.objpointnames.size] = param_00;
	return var_06;
}

//Function Number: 3
deleteobjpoint(param_00)
{
	if(level.objpoints.size == 1)
	{
		level.objpoints = [];
		level.objpointnames = [];
		param_00 destroy();
		return;
	}

	var_01 = param_00.index;
	var_02 = level.objpointnames.size - 1;
	var_03 = getobjpointbyindex(var_02);
	level.objpointnames[var_01] = var_03.name;
	var_03.index = var_01;
	level.objpointnames[var_02] = undefined;
	level.objpoints[param_00.name] = undefined;
	param_00 destroy();
}

//Function Number: 4
updateorigin(param_00)
{
	if(self.x != param_00[0])
	{
		self.x = param_00[0];
	}

	if(self.y != param_00[1])
	{
		self.y = param_00[1];
	}

	if(self.z != param_00[2])
	{
		self.z = param_00[2];
	}
}

//Function Number: 5
setoriginbyname(param_00,param_01)
{
	var_02 = getobjpointbyname(param_00);
	var_02 updateorigin(param_01);
}

//Function Number: 6
getobjpointbyname(param_00)
{
	if(isdefined(level.objpoints[param_00]))
	{
		return level.objpoints[param_00];
	}

	return undefined;
}

//Function Number: 7
getobjpointbyindex(param_00)
{
	if(isdefined(level.objpointnames[param_00]))
	{
		return level.objpoints[level.objpointnames[param_00]];
	}

	return undefined;
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
		wait 0.75;
		self fadeovertime(0.75);
		self.alpha = self.basealpha;
		wait 0.75;
	}

	self.alpha = self.basealpha;
}

//Function Number: 9
stopflashing()
{
	if(!self.isflashing)
	{
		return;
	}

	self.isflashing = 0;
}
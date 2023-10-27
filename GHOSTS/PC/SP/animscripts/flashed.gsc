/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\flashed.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 90 ms
 * Timestamp: 10/27/2023 1:24:00 AM
*******************************************************************/

//Function Number: 1
init_animset_flashed()
{
	var_00 = [];
	var_00["flashed"] = [%exposed_flashbang_v2,%exposed_flashbang_v4];
	var_00["flashed"] = common_scripts\utility::array_randomize(var_00["flashed"]);
	level.archetypes["soldier"]["flashed"] = var_00;
	level.flashanimindex["soldier"] = 0;
}

//Function Number: 2
getnextflashanim()
{
	var_00 = "soldier";
	if(isdefined(self.var_DC4) && isdefined(level.flashanimindex[self.var_DC4]))
	{
		var_00 = self.var_DC4;
	}

	level.flashanimindex[var_00]++;
	if(level.flashanimindex[var_00] >= level.archetypes[var_00]["flashed"]["flashed"].size)
	{
		level.flashanimindex[var_00] = 0;
		level.archetypes[var_00]["flashed"]["flashed"] = common_scripts\utility::array_randomize(level.archetypes[var_00]["flashed"]["flashed"]);
	}

	return level.archetypes[var_00]["flashed"]["flashed"][level.flashanimindex[var_00]];
}

//Function Number: 3
func_33F9(param_00)
{
	self endon("killanimscript");
	self setflaggedanimknoball("flashed_anim",param_00,%body,0.2,randomfloatrange(0.9,1.1));
	animscripts/shared::func_2986("flashed_anim");
}

//Function Number: 4
func_4FDD()
{
	self endon("death");
	self endon("killanimscript");
	animscripts/utility::func_4622("flashed");
	var_00 = maps\_utility::func_33FB();
	if(var_00 <= 0)
	{
	}

	animscripts/face::func_6AB2("flashbang");
	if(isdefined(self.var_78EC))
	{
		self [[ self.var_78EC ]]();
	}

	var_01 = getnextflashanim();
	flashbangedloop(var_01,var_00);
}

//Function Number: 5
flashbangedloop(param_00,param_01)
{
	self endon("death");
	self endon("killanimscript");
	if(self.a.var_60B1 == "prone")
	{
		animscripts/utility::exitpronewrapper(1);
	}

	self.a.var_60B1 = "stand";
	self.allowdeath = 1;
	thread func_33F9(param_00);
	wait(param_01);
	self notify("stop_flashbang_effect");
	self.var_3402 = 0;
}
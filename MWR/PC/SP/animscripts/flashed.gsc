/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\flashed.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 116 ms
 * Timestamp: 10/27/2023 2:44:12 AM
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
	if(isdefined(self.animarchetype) && isdefined(level.flashanimindex[self.animarchetype]))
	{
		var_00 = self.animarchetype;
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
flashbanganim(param_00)
{
	self endon("killanimscript");
	self setflaggedanimknoball("flashed_anim",param_00,%body,0.2,randomfloatrange(0.9,1.1));
	animscripts\shared::donotetracks("flashed_anim");
}

//Function Number: 4
main()
{
	self endon("death");
	self endon("killanimscript");
	animscripts\utility::initialize("flashed");
	var_00 = maps\_utility::flashbanggettimeleftsec();
	if(var_00 <= 0)
	{
		return;
	}

	animscripts\face::saygenericdialogue("flashbang");
	if(isdefined(self.specialflashedfunc))
	{
		self [[ self.specialflashedfunc ]]();
		return;
	}

	var_01 = getnextflashanim();
	flashbangedloop(var_01,var_00);
}

//Function Number: 5
flashbangedloop(param_00,param_01)
{
	self endon("death");
	self endon("killanimscript");
	if(self.a.pose == "prone")
	{
		animscripts\utility::exitpronewrapper(1);
	}

	self.a.pose = "stand";
	self.allowdeath = 1;
	thread flashbanganim(param_00);
	wait(param_01);
	self notify("stop_flashbang_effect");
	self.flashed = 0;
}
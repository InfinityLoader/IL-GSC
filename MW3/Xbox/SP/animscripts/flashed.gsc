/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\flashed.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 106 ms
 * Timestamp: 10/27/2023 2:30:23 AM
*******************************************************************/

//Function Number: 1
initflashed()
{
	level.flashanimarray[0] = %exposed_flashbang_v1;
	level.flashanimarray[1] = %exposed_flashbang_v2;
	level.flashanimarray[2] = %exposed_flashbang_v3;
	level.flashanimarray[3] = %exposed_flashbang_v4;
	level.flashanimarray[4] = %exposed_flashbang_v5;
	randomizeflashanimarray();
	anim.flashanimindex = 0;
}

//Function Number: 2
randomizeflashanimarray()
{
	for(var_00 = 0;var_00 < level.flashanimarray.size;var_00++)
	{
		var_01 = randomint(level.flashanimarray.size);
		var_02 = level.flashanimarray[var_00];
		level.flashanimarray[var_00] = level.flashanimarray[var_01];
		level.flashanimarray[var_01] = var_02;
	}
}

//Function Number: 3
getnextflashanim()
{
	level.flashanimindex++;
	if(level.flashanimindex >= level.flashanimarray.size)
	{
		anim.flashanimindex = 0;
		randomizeflashanimarray();
	}

	return level.flashanimarray[level.flashanimindex];
}

//Function Number: 4
func_1C15(param_00)
{
	self endon("killanimscript");
	self setflaggedanimknoball("flashed_anim",param_00,%body,0.2,randomfloatrange(0.9,1.1));
	animscripts/shared::donotetracks("flashed_anim");
}

//Function Number: 5
main()
{
	self endon("death");
	self endon("killanimscript");
	animscripts/utility::initialize("flashed");
	var_00 = maps\_utility::func_1C16();
	if(var_00 <= 0)
	{
		return;
	}

	animscripts/face::saygenericdialogue("flashbang");
	if(isdefined(self.specialflashedfunc))
	{
		self [[ self.specialflashedfunc ]]();
		return;
	}

	var_01 = getnextflashanim();
	func_1C18(var_01,var_00);
}

//Function Number: 6
func_1C18(param_00,param_01)
{
	self endon("death");
	self endon("killanimscript");
	if(self.a.var_911 == "prone")
	{
		animscripts/utility::exitpronewrapper(1);
	}

	self.a.var_911 = "stand";
	self.allowdeath = 1;
	thread func_1C15(param_00);
	wait param_01;
	self notify("stop_flashbang_effect");
	self.var_1C19 = 0;
}
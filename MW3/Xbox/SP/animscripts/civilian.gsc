/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 74 ms
 * Timestamp: 10/27/2023 2:29:56 AM
*******************************************************************/

//Function Number: 1
func_3B0E()
{
	self endon("killanimscript");
	self clearanim(%root,0.2);
	if(animscripts/utility::isincombat())
	{
		var_00 = "idle_combat";
	}
	else
	{
		var_00 = "idle_noncombat";
	}

	var_01 = undefined;
	if(isdefined(self.animname) && isdefined(level.scr_anim[self.animname]))
	{
		var_01 = level.scr_anim[self.animname][var_00];
	}

	if(!isdefined(var_01))
	{
		if(!isdefined(level.scr_anim["default_civilian"]))
		{
			return;
		}

		var_01 = level.scr_anim["default_civilian"][var_00];
	}

	thread func_3B0F();
	for(;;)
	{
		self setflaggedanimknoball("idle",common_scripts\utility::random(var_01),%root,1,0.2,1);
		self waittillmatch("end","idle");
	}
}

//Function Number: 2
func_3B0F()
{
	self endon("killanimscript");
	while(!isdefined(self.var_3B10))
	{
		wait 1;
	}
}

//Function Number: 3
stop()
{
	func_3B0E();
}

//Function Number: 4
func_3B12()
{
	return level.civilianflashedarray[randomint(level.civilianflashedarray.size)];
}
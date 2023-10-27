/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 2:17:52 AM
*******************************************************************/

//Function Number: 1
func_400A()
{
	self endon("killanimscript");
	self clearanim(%root,0.2);
	if(animscripts/utility::func_A69())
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

	thread func_400B();
	for(;;)
	{
		self setflaggedanimknoball("idle",common_scripts\utility::random(var_01),%root,1,0.2,1);
		self waittillmatch("end","idle");
	}
}

//Function Number: 2
func_400B()
{
	self endon("killanimscript");
	while(!isdefined(self.var_400C))
	{
		wait 1;
	}
}

//Function Number: 3
func_400D()
{
	func_400A();
}

//Function Number: 4
func_400E()
{
	return level.var_400F[randomint(level.var_400F.size)];
}
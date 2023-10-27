/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 1:23:28 AM
*******************************************************************/

//Function Number: 1
cover()
{
	self endon("killanimscript");
	self clearanim(%root,0.2);
	animscripts/utility::func_86F6();
	if(animscripts/utility::func_48DE())
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

	thread move_check();
	for(;;)
	{
		self setflaggedanimknoball("idle",common_scripts\utility::func_6306(var_01),%root,1,0.2,1);
		self waittillmatch("end","idle");
	}
}

//Function Number: 2
move_check()
{
	self endon("killanimscript");
	while(!isdefined(self.var_1ACC))
	{
		wait(1);
	}
}

//Function Number: 3
stop()
{
	cover();
}

//Function Number: 4
get_flashed_anim()
{
	return level.var_1C89[randomint(level.var_1C89.size)];
}
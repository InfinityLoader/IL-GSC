/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 2:00:01 AM
*******************************************************************/

//Function Number: 1
cover()
{
	self endon("killanimscript");
	self clearanim(%animscript_root,0.2);
	animscripts\utility::updateisincombattimer();
	if(animscripts\utility::isincombat())
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
		self setflaggedanimknoball("idle",common_scripts\utility::random(var_01),%animscript_root,1,0.2,1);
		self waittillmatch("end","idle");
	}
}

//Function Number: 2
move_check()
{
	self endon("killanimscript");
	while(!isdefined(self.champion))
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
	return level.civilianflashedarray[randomint(level.civilianflashedarray.size)];
}
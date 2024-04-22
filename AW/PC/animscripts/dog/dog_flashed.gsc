/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_flashed.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 1:58:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["flashed"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	self endon("stop_flashbang_effect");
	wait(randomfloatrange(0,0.4));
	self clearanim(%body,0.1);
	var_00 = maps\_utility::flashbanggettimeleftsec();
	if(var_00 > 2 && randomint(100) > 60)
	{
		self setflaggedanimrestart("flashed_anim",getdogflashedanim("flash_long"),1,0.2,self.animplaybackrate * 0.75);
	}
	else
	{
		self setflaggedanimrestart("flashed_anim",getdogflashedanim("flash_short"),1,0.2,self.animplaybackrate);
	}

	var_01 = getanimlength(getdogflashedanim("flash_short")) * self.animplaybackrate;
	if(var_00 < var_01)
	{
		animscripts\notetracks::donotetracksfortime(var_00,"flashed_anim");
	}
	else
	{
		animscripts\shared::donotetracks("flashed_anim");
	}

	self.flashed = 0;
	self notify("stop_flashbang_effect");
}

//Function Number: 2
getdogflashedanim(param_00)
{
	var_01 = animscripts\utility::lookupdoganim("reaction",param_00);
	if(isdefined(var_01) && isarray(var_01))
	{
		return var_01[randomint(var_01.size)];
	}

	return var_01;
}
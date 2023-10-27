/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_flashed.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:17:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("stop_flashbang_effect");
	wait randomfloatrange(0,0.4);
	self clearanim(%root,0.1);
	var_00 = maps\_utility::flashbanggettimeleftsec();
	if(var_00 > 2 && randomint(100) > 60)
	{
		self setflaggedanimrestart("flashed_anim",%german_shepherd_run_pain,1,0.2,self.var_10F7 * 0.75);
	}
	else
	{
		self setflaggedanimrestart("flashed_anim",%german_shepherd_run_flashbang_b,1,0.2,self.var_10F7);
	}

	var_01 = getanimlength(%german_shepherd_run_flashbang_b) * self.var_10F7;
	if(var_00 < var_01)
	{
		animscripts/notetracks::func_D4F(var_00,"flashed_anim");
	}
	else
	{
		animscripts/shared::donotetracks("flashed_anim");
	}

	self.var_2097 = 0;
	self notify("stop_flashbang_effect");
}
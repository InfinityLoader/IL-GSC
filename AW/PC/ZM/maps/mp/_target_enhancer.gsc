/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_target_enhancer.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:08:34 AM
*******************************************************************/

//Function Number: 1
target_enhancer_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 10;
	var_01 = cos(var_00);
	var_02 = 0.5;
	self.has_target_enhancer = 0;
	for(;;)
	{
		while(self.has_target_enhancer && self playerads() < var_02)
		{
			wait(0.05);
		}

		if(!self.has_target_enhancer)
		{
			wait(0.05);
			continue;
		}

		if(self isusingturret())
		{
			wait(0.05);
			continue;
		}

		if(isdefined(self.empon) && self.empon)
		{
			wait 0.05;
			continue;
		}

		if(isplayer(self))
		{
			childthread maps\mp\_threatdetection::detection_highlight_hud_effect(self,0.05,1);
		}

		wait(0.05);
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_headtracking.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:45:49 AM
*******************************************************************/

//Function Number: 1
player_head_tracking()
{
	self endon("head_tracking_end");
	self endon("death");
	self.player_head_tracking = 1;
	self.head_track_debug = self.name;
	for(;;)
	{
		wait(0.2);
		if(distance(self.origin,level.player.origin) <= 200 && maps\_utility::player_looking_at(self.origin))
		{
			self method_81BA(60,60,randomfloatrange(0.5,2));
			self setlookatentity(level.player,1,randomint(5) == 0);
			maps\_utility::waitspread(5,7);
			self setlookatyawlimits(1);
			maps\_utility::waitspread(5,7);
		}
	}
}

//Function Number: 2
head_tracking_end(param_00,param_01)
{
	self notify("head_tracking_end");
	self.player_head_tracking = 0;
	var_02 = isdefined(param_01) && param_01;
	if(isdefined(param_00) && param_00)
	{
		self setlookatentity();
		return;
	}

	self setlookatyawlimits(1,var_02);
}
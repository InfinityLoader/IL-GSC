/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_player_boost_jump_mp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 1:50:49 AM
*******************************************************************/

//Function Number: 1
boost_jump_wrapper()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	maps\mp\_utility::gameflagwait("prematch_done");
	thread play_boost_sound();
}

//Function Number: 2
play_boost_sound()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	var_00 = self isjumping();
	for(;;)
	{
		var_01 = self isjumping();
		if(var_01)
		{
			if(var_01 != var_00)
			{
				self playrumbleonentity("damage_heavy");
				maps\mp\_utility::playsoundinspace("boost_jump_plr_mp",self.origin);
			}
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 3
playerboostjumpprecaching()
{
}
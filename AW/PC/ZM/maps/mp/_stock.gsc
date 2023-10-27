/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_stock.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:08:33 AM
*******************************************************************/

//Function Number: 1
stock_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.has_stock = 0;
	for(;;)
	{
		if(!self.has_stock)
		{
			if(self hasperk("specialty_stalker",1))
			{
				self unsetperk("specialty_stalker",1);
			}

			wait(0.05);
			continue;
		}

		if(!self hasperk("specialty_stalker",1))
		{
			self setperk("specialty_stalker",1,0);
		}

		wait(0.05);
	}
}
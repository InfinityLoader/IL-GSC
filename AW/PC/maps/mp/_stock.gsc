/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_stock.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:16:16 AM
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
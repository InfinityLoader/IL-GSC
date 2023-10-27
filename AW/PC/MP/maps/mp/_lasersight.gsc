/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_lasersight.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:49:01 AM
*******************************************************************/

//Function Number: 1
lasersight_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.laser_on = undefined;
	self.wasemp = 0;
	self.has_laser = 0;
	for(;;)
	{
		while(maps\mp\_utility::isemped() && self.has_laser)
		{
			wait(0.05);
			self laseroff();
			self.wasemp = 1;
			continue;
		}

		if(self.wasemp && self.has_laser)
		{
			self.wasemp = 0;
			self laseron(get_laser_name());
		}

		if(issubstr(self getcurrentweapon(),"maaws") || issubstr(self getcurrentweapon(),"dlcgun11loot3"))
		{
			self.has_laser = 1;
		}

		if(self.has_laser && self isthrowinggrenade())
		{
			if(isdefined(self.laser_on) && self.laser_on)
			{
				self laseroff();
				self.laser_on = 0;
				while(!self isusingoffhand() && self isthrowinggrenade())
				{
					wait(0.05);
				}

				while(self isusingoffhand() && self isthrowinggrenade())
				{
					wait(0.05);
				}

				while(self isthrowinggrenade())
				{
					wait(0.05);
				}

				self laseron(get_laser_name());
				self.laser_on = 1;
			}
		}

		if(!self.has_laser)
		{
			if(isdefined(self.laser_on) && self.laser_on)
			{
				self laseroff();
				self.laser_on = 0;
			}
		}
		else if(!isdefined(self.laser_on) || !self.laser_on)
		{
			self laseron(get_laser_name());
			self.laser_on = 1;
		}

		wait(0.05);
	}
}

//Function Number: 2
get_laser_name()
{
	var_00 = self getcurrentweapon();
	if(issubstr(var_00,"_dlcgun10loot5") || maps\mp\gametypes\_class::isexoxmg(var_00) || maps\mp\gametypes\_class::issac3(var_00))
	{
		return "mp_attachment_lasersight_short";
	}

	return "mp_attachment_lasersight";
}
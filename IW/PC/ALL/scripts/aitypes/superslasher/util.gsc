/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\superslasher\util.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 528 ms
 * Timestamp: 10/26/2023 11:59:05 PM
*******************************************************************/

//Function Number: 1
isonroof()
{
	return scripts\aitypes\superslasher\behaviors::superslasher_isonroof();
}

//Function Number: 2
forcestagger(param_00)
{
	if(!isdefined(self.var_1198.bstaggerrequested))
	{
		self.var_1198.bstaggerrequested = 1;
		if(scripts\aitypes\superslasher\behaviors::superslasher_isonground())
		{
			thread queueinterruptible("ground_stagger");
		}
		else if(isonroof())
		{
			thread queueinterruptible("roof_stagger");
		}

		if(param_00)
		{
			func_5CF8();
		}
	}
}

//Function Number: 3
forcetrapped(param_00)
{
	if(!isdefined(self.var_1198.btraprequested))
	{
		self.var_1198.btraprequested = 1;
		self.var_1198.trapduration = param_00;
		thread queueinterruptible("ground_trapped");
		self.btrophysystem = undefined;
		scripts\aitypes\superslasher\behaviors::shieldcleanup();
	}
}

//Function Number: 4
queueinterruptible(param_00)
{
	self notify("queue_interruptible");
	self endon("death");
	self endon("queue_interruptible");
	while(isdefined(self.var_1198.buninterruptibleanim))
	{
		wait(0.05);
	}

	lib_0A1A::func_237C(param_00);
}

//Function Number: 5
dosawsharks()
{
	scripts\asm\superslasher\superslasher_actions::killallsharks(self);
	self notify("kill_sharks");
	scripts\asm\superslasher\superslasher_actions::dosawsharks("ground");
}

//Function Number: 6
requestshockwave()
{
	self.bshockwaverequested = 1;
}

//Function Number: 7
requestgotoroof()
{
	if(scripts\aitypes\superslasher\behaviors::superslasher_isonground() || scripts\aitypes\superslasher\behaviors::superslasher_isgoingtoground())
	{
		self.var_1198.bgotoroofrequested = 1;
	}
}

//Function Number: 8
requestgotoground()
{
	if(scripts\aitypes\superslasher\behaviors::superslasher_isonroof() || scripts\aitypes\superslasher\behaviors::superslasher_isgoingtoroof())
	{
		self.var_1198.bgotogroundrequested = 1;
	}
}

//Function Number: 9
ongotoroof_init()
{
	self.btrophysystem = undefined;
	scripts\aitypes\superslasher\behaviors::shieldcleanup();
}

//Function Number: 10
onroof_init()
{
}

//Function Number: 11
ongotoground_init()
{
}

//Function Number: 12
onground_init()
{
}

//Function Number: 13
func_5CF8()
{
	scripts\common\utility::flag_set("force_drop_max_ammo");
}
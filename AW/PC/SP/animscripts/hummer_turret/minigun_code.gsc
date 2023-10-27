/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\hummer_turret\minigun_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 98 ms
 * Timestamp: 10/27/2023 1:53:05 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	param_00.fireinterval = 0.1;
	param_00.closeenoughaimdegrees = 45;
	param_00.firecontrollerfunc = ::firecontroller_minigun;
	param_00.specialcleanupfunc = ::minigun_cleanup_func;
	param_00.default_drop_pitch = 20;
	animscripts\hummer_turret\common::humvee_turret_init(param_00,"minigun");
	wait(0.05);
	param_00 notify("turret_ready");
}

//Function Number: 2
minigun_cleanup_func(param_00,param_01)
{
	if(param_01 getbarrelspinrate() > 0)
	{
		param_01 stopbarrelspin();
	}
}

//Function Number: 3
firecontroller_minigun(param_00)
{
	self endon("death");
	self endon("dismount");
	param_00 endon("kill_fireController");
	param_00 endon("death");
	param_00.extrafiretime_min = 600;
	param_00.extrafiretime_max = 900;
	var_01 = -1;
	var_02 = undefined;
	var_03 = undefined;
	param_00.extraspintime_min = 250;
	param_00.extraspintime_max = 2250;
	var_04 = -1;
	var_05 = undefined;
	var_06 = 0;
	var_07 = 0;
	param_00.secsoffiringbeforereload = 15;
	if(isdefined(param_00.secsoffiringbeforereloaddefault))
	{
		param_00.secsoffiringbeforereload = param_00.secsoffiringbeforereloaddefault;
	}

	param_00.firetime = 0;
	animscripts\hummer_turret\common::doaim(param_00);
	for(;;)
	{
		if(param_00.dofiring && !var_06 && !self.iscustomanimating)
		{
			var_06 = 1;
			if(!var_07)
			{
				param_00 minigun_spinup();
				var_07 = 1;
			}

			param_00 notify("startfiring");
			var_01 = gettime();
			animscripts\hummer_turret\common::doshoot(param_00);
			wait(0.05);
		}
		else if(!param_00.dofiring && var_06)
		{
			if(!isdefined(var_02))
			{
				var_02 = gettime();
			}

			if(!isdefined(var_03))
			{
				var_03 = randomfloatrange(param_00.extrafiretime_min,param_00.extrafiretime_max);
			}

			if(gettime() - var_02 >= var_03)
			{
				var_06 = 0;
				animscripts\hummer_turret\common::doaim(param_00);
				var_04 = gettime();
				var_02 = undefined;
				var_03 = undefined;
			}
		}
		else if(!param_00.dofiring && !var_06 && var_07)
		{
			if(!isdefined(var_05))
			{
				var_05 = randomfloatrange(param_00.extraspintime_min,param_00.extraspintime_max);
			}

			if(self.iscustomanimating || gettime() - var_04 >= var_05)
			{
				param_00 stopbarrelspin();
				var_07 = 0;
				var_05 = undefined;
			}
		}

		if(param_00.turretstate == "fire")
		{
			param_00.firetime = param_00.firetime + 0.05;
		}

		if(param_00.firetime > param_00.secsoffiringbeforereload)
		{
			param_00.dofiring = 0;
			var_06 = 0;
			animscripts\hummer_turret\common::doaim(param_00);
			var_04 = -1;
			var_02 = undefined;
			var_03 = undefined;
			thread animscripts\hummer_turret\common::doreload(param_00);
			param_00.firetime = 0;
		}

		wait(0.05);
		if(!isdefined(param_00))
		{
			break;
		}
	}
}

//Function Number: 4
minigun_spinup()
{
	if(self getbarrelspinrate() == 1)
	{
		return;
	}

	self startbarrelspin();
	while(self getbarrelspinrate() < 1)
	{
		wait(0.05);
	}
}
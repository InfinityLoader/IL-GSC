/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: saw\common.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 165 ms
 * Timestamp: 4/22/2024 1:58:54 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self endon("killanimscript");
	animscripts\utility::initialize("saw");
	if(!isdefined(param_00))
	{
		return;
	}

	self.a.special = "saw";
	if(isdefined(param_00.script_delay_min))
	{
		var_01 = param_00.script_delay_min;
	}
	else
	{
		var_01 = maps\_mgturret::burst_fire_settings("delay");
	}

	if(isdefined(param_00.script_delay_max))
	{
		var_02 = param_00.script_delay_max - var_01;
	}
	else
	{
		var_02 = maps\_mgturret::burst_fire_settings("delay_range");
	}

	if(isdefined(param_00.script_burst_min))
	{
		var_03 = param_00.script_burst_min;
	}
	else
	{
		var_03 = maps\_mgturret::burst_fire_settings("burst");
	}

	if(isdefined(param_00.script_burst_max))
	{
		var_04 = param_00.script_burst_max - var_03;
	}
	else
	{
		var_04 = maps\_mgturret::burst_fire_settings("burst_range");
	}

	var_05 = gettime();
	var_06 = "start";
	animscripts\shared::placeweaponon(self.weapon,"none");
	param_00 show();
	if(isdefined(param_00.aiowner))
	{
		self.a.postscriptfunc = ::postscriptfunc;
		self.a.usingturret = param_00;
		param_00 notify("being_used");
		thread stopusingturretwhennodelost();
	}
	else
	{
		self.a.postscriptfunc = ::preplacedpostscriptfunc;
	}

	param_00.dofiring = 0;
	thread firecontroller(param_00);
	self setturretanim(self.primaryturretanim);
	self setanimknobrestart(self.primaryturretanim,1,0.2,1);
	self setanimknoblimitedrestart(self.additiveturretidle);
	self setanimknoblimitedrestart(self.additiveturretfire);
	param_00 setanimknoblimitedrestart(param_00.additiveturretidle);
	param_00 setanimknoblimitedrestart(param_00.additiveturretfire);
	param_00 endon("death");
	for(;;)
	{
		if(param_00.dofiring)
		{
			thread doshoot(param_00);
			waittimeoruntilturretstatechange(randomfloatrange(var_03,var_03 + var_04),param_00);
			param_00 notify("turretstatechange");
			if(param_00.dofiring)
			{
				thread doaim(param_00);
				wait(randomfloatrange(var_01,var_01 + var_02));
			}

			continue;
		}

		thread doaim(param_00);
		param_00 waittill("turretstatechange");
	}
}

//Function Number: 2
waittimeoruntilturretstatechange(param_00,param_01)
{
	param_01 endon("turretstatechange");
	wait(param_00);
}

//Function Number: 3
firecontroller(param_00)
{
	self endon("killanimscript");
	var_01 = cos(15);
	for(;;)
	{
		while(isdefined(self.enemy))
		{
			var_02 = self.enemy.origin;
			var_03 = param_00 gettagangles("tag_aim");
			if(common_scripts\utility::within_fov(param_00.origin,var_03,var_02,var_01) || distancesquared(param_00.origin,var_02) < 40000)
			{
				if(!param_00.dofiring)
				{
					param_00.dofiring = 1;
					param_00 notify("turretstatechange");
				}
			}
			else if(param_00.dofiring)
			{
				param_00.dofiring = 0;
				param_00 notify("turretstatechange");
			}

			wait(0.05);
		}

		if(param_00.dofiring)
		{
			param_00.dofiring = 0;
			param_00 notify("turretstatechange");
		}

		wait(0.05);
	}
}

//Function Number: 4
turrettimer(param_00,param_01)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("killanimscript");
	param_01 endon("turretstatechange");
	wait(param_00);
	param_01 notify("turretstatechange");
}

//Function Number: 5
stopusingturretwhennodelost()
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.node) || distancesquared(self.origin,self.node.origin) > 4096)
		{
			self stopuseturret();
		}

		wait(0.25);
	}
}

//Function Number: 6
postscriptfunc(param_00)
{
	if(param_00 == "pain")
	{
		if(isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 4096)
		{
			self.a.usingturret hide();
			animscripts\shared::placeweaponon(self.weapon,"right");
			self.a.postscriptfunc = ::postpainfunc;
			return;
		}
		else
		{
			self stopuseturret();
		}
	}

	if(param_00 == "saw")
	{
		var_01 = self getturret();
		return;
	}

	self.a.usingturret delete();
	self.a.usingturret = undefined;
	animscripts\shared::placeweaponon(self.weapon,"right");
}

//Function Number: 7
postpainfunc(param_00)
{
	if(!isdefined(self.node) || distancesquared(self.origin,self.node.origin) > 4096)
	{
		self stopuseturret();
		self.a.usingturret delete();
		self.a.usingturret = undefined;
		if(isdefined(self.weapon) && self.weapon != "none")
		{
			animscripts\shared::placeweaponon(self.weapon,"right");
			return;
		}

		return;
	}

	if(param_00 != "saw")
	{
		self.a.usingturret delete();
	}
}

//Function Number: 8
preplacedpostscriptfunc(param_00)
{
	animscripts\shared::placeweaponon(self.weapon,"right");
}

//Function Number: 9
doshoot(param_00)
{
	self setanim(%additive_saw_idle,0,0.1);
	self setanim(%additive_saw_fire,1,0.1);
	param_00 turretdoshootanims();
	turretdoshoot(param_00);
}

//Function Number: 10
doaim(param_00)
{
	self setanim(%additive_saw_idle,1,0.1);
	self setanim(%additive_saw_fire,0,0.1);
	param_00 turretdoaimanims();
}

//Function Number: 11
turretdoshoot(param_00)
{
	self endon("killanimscript");
	param_00 endon("turretstatechange");
	for(;;)
	{
		param_00 shootturret();
		wait(0.1);
	}
}

//Function Number: 12
turretdoshootanims()
{
	self setanim(%additive_saw_idle,0,0.1);
	self setanim(%additive_saw_fire,1,0.1);
}

//Function Number: 13
turretdoaimanims()
{
	self setanim(%additive_saw_idle,1,0.1);
	self setanim(%additive_saw_fire,0,0.1);
}
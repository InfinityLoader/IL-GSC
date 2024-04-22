/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_warbird_missile_defense.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 127 ms
 * Timestamp: 4/22/2024 2:27:24 AM
*******************************************************************/

//Function Number: 1
missile_defense_precache()
{
	level._effect["flare"] = loadfx("vfx/lensflare/flares_warbird");
	level.stinger_no_ai = 1;
}

//Function Number: 2
heli_flares_monitor(param_00)
{
	self.numflares = 2;
	if(isdefined(param_00))
	{
		self.numflares = self.numflares + param_00;
	}

	thread handleincomingstinger();
}

//Function Number: 3
handleincomingstinger(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	var_01 = level.player;
	for(;;)
	{
		level waittill("stinger_fired",var_01,var_02);
		if(!maps\_stingerm7::anystingermissilelockedon(var_02,self))
		{
			continue;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(isdefined(param_00))
		{
			level thread [[ param_00 ]](var_02,var_01,var_01.team);
			continue;
		}

		level thread watchmissileproximity(var_02,var_01,var_01.team);
	}
}

//Function Number: 4
watchmissileproximity(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.lockedstingertarget))
		{
			var_04 thread missilewatchproximity(param_01,param_02,var_04.lockedstingertarget);
		}
	}
}

//Function Number: 5
missilewatchproximity(param_00,param_01,param_02)
{
	self endon("death");
	param_02 endon("death");
	var_03 = 5;
	var_04 = 3500;
	for(;;)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_05 = param_02 getpointinbounds(0,0,0);
		var_06 = distance(self.origin,var_05);
		if(var_06 < var_04)
		{
			if(isdefined(param_02.numflares) && param_02.numflares > 0)
			{
				param_02.numflares--;
				var_07 = param_02 deployflares(var_03);
				playfxontag(level._effect["flare"],var_07,"tag_origin");
				if(isdefined(self.delayedlocktargetent))
				{
					self.delayedlocktargetent = var_07;
					self.delayedlocktargettag = "tag_origin";
				}
				else
				{
					self missile_settargetent(var_07);
				}

				return;
			}

			self missile_settargetent(var_03,(0,0,50));
		}

		wait(0.05);
	}
}

//Function Number: 6
deployflares(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = self gettagorigin("tag_origin") + (0,0,200);
	var_01.angles = self.angles;
	var_02 = common_scripts\utility::randomvector(1) + (0,0,1);
	var_02 = vectornormalize(var_02);
	var_03 = var_02 * randomfloatrange(500,800);
	var_01 movegravity(var_03,param_00);
	var_01 thread deleteaftertime(param_00);
	return var_01;
}

//Function Number: 7
deleteaftertime(param_00)
{
	wait(param_00);
	self delete();
}
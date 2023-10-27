/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_leak.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 136 ms
 * Timestamp: 10/27/2023 2:20:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = getentarray("leaking","targetname");
	if(!var_00.size)
	{
		return;
	}

	var_00 thread precachefx();
	var_00 thread methodsinit();
	common_scripts\utility::array_thread(var_00,::leak_setup);
}

//Function Number: 2
leak_setup()
{
	switch(self.script_noteworthy)
	{
		case "barrel_oil":
			leak_barrel_setup();
			break;

		case "barrel_acid":
			leak_barrel_setup();
			break;

		case "barrel_sludge":
			leak_barrel_setup();
			break;

		case "barrel_water":
			leak_barrel_setup();
			break;
	}

	thread leak_think();
}

//Function Number: 3
leak_barrel_setup()
{
	self.a = self.origin;
	self.up = anglestoup(self.angles);
	var_00 = anglestoup((0,90,0));
	self.org = self.a + self.up * 22;
	self.a = self.a + self.up * 1.5;
	self.b = self.a + self.up * 41.4;
	self.volume = 25861.65;
	self.curvol = self.volume;
	var_01 = vectordot(self.up,var_00);
	var_02 = self.b;
	if(var_01 < 0)
	{
		var_02 = self.a;
	}

	var_01 = abs(1 - abs(var_01));
	self.lowz = physicstrace(self.org,self.org + (0,0,-80))[2];
	self.highz = var_02[2] + var_01 * 14;
}

//Function Number: 4
leak_think()
{
	self setcandamage(1);
	self endon("drained");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 == "MOD_MELEE" || var_04 == "MOD_IMPACT")
		{
			continue;
		}

		var_03 = self [[ level._leak_methods[var_04] ]](var_03,var_04);
		if(!isdefined(var_03))
		{
			continue;
		}

		thread leak_drain(var_03);
	}
}

//Function Number: 5
leak_drain(param_00)
{
	var_01 = pointonsegmentnearesttopoint(self.a,self.b,param_00);
	var_02 = undefined;
	if(var_01 == self.a)
	{
		var_02 = self.up * -1;
	}
	else if(var_01 == self.b)
	{
		var_02 = self.up;
	}
	else
	{
		var_02 = vectorfromlinetopoint(self.a,self.b,param_00);
	}

	var_03 = param_00[2] - self.lowz;
	if(var_03 < 0.02)
	{
		var_03 = 0;
	}

	var_04 = var_03 / self.highz - self.lowz * self.volume;
	if(self.curvol > var_04)
	{
		while(self.curvol > var_04)
		{
			playfx(level._effect["leak_interactive_leak"][self.script_noteworthy],param_00,var_02);
			self.curvol = self.curvol - 100;
			wait 0.1;
		}

		playfx(level._effect["leak_interactive_drain"][self.script_noteworthy],param_00,var_02);
	}

	if(self.curvol / self.volume <= 0.05)
	{
		self notify("drained");
	}
}

//Function Number: 6
methodsinit()
{
	level._leak_methods = [];
	level._leak_methods["MOD_UNKNOWN"] = ::leak_calc_splash;
	level._leak_methods["MOD_PISTOL_BULLET"] = ::leak_calc_ballistic;
	level._leak_methods["MOD_RIFLE_BULLET"] = ::leak_calc_ballistic;
	level._leak_methods["MOD_GRENADE"] = ::leak_calc_splash;
	level._leak_methods["MOD_GRENADE_SPLASH"] = ::leak_calc_splash;
	level._leak_methods["MOD_PROJECTILE"] = ::leak_calc_splash;
	level._leak_methods["MOD_PROJECTILE_SPLASH"] = ::leak_calc_splash;
	level._leak_methods["MOD_MELEE"] = ::leak_calc_nofx;
	level._leak_methods["MOD_HEAD_SHOT"] = ::leak_calc_nofx;
	level._leak_methods["MOD_CRUSH"] = ::leak_calc_nofx;
	level._leak_methods["MOD_TELEFRAG"] = ::leak_calc_nofx;
	level._leak_methods["MOD_FALLING"] = ::leak_calc_nofx;
	level._leak_methods["MOD_SUICIDE"] = ::leak_calc_nofx;
	level._leak_methods["MOD_TRIGGER_HURT"] = ::leak_calc_splash;
	level._leak_methods["MOD_EXPLOSIVE"] = ::leak_calc_splash;
	level._leak_methods["MOD_IMPACT"] = ::leak_calc_nofx;
}

//Function Number: 7
leak_calc_ballistic(param_00,param_01)
{
	return param_00;
}

//Function Number: 8
leak_calc_splash(param_00,param_01)
{
	var_02 = vectornormalize(vectorfromlinetopoint(self.a,self.b,param_00));
	param_00 = pointonsegmentnearesttopoint(self.a,self.b,param_00);
	return param_00 + var_02 * 4;
}

//Function Number: 9
leak_calc_nofx(param_00,param_01)
{
	return undefined;
}

//Function Number: 10
leak_calc_assert(param_00,param_01)
{
}

//Function Number: 11
precachefx()
{
	for(var_00 = 0;var_00 < self.size;var_00++)
	{
		if(self[var_00].script_noteworthy != "barrel_oil")
		{
			continue;
		}

		level._effect["leak_interactive_leak"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_leak");
		level._effect["leak_interactive_drain"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_drain");
		break;
	}

	for(var_00 = 0;var_00 < self.size;var_00++)
	{
		if(self[var_00].script_noteworthy != "barrel_acid")
		{
			continue;
		}

		level._effect["leak_interactive_leak"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_leak");
		level._effect["leak_interactive_drain"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_drain");
		break;
	}

	for(var_00 = 0;var_00 < self.size;var_00++)
	{
		if(self[var_00].script_noteworthy != "barrel_water")
		{
			continue;
		}

		level._effect["leak_interactive_leak"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_leak");
		level._effect["leak_interactive_drain"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_drain");
		break;
	}

	for(var_00 = 0;var_00 < self.size;var_00++)
	{
		if(self[var_00].script_noteworthy != "barrel_sludge")
		{
			continue;
		}

		level._effect["leak_interactive_leak"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_leak");
		level._effect["leak_interactive_drain"][self[var_00].script_noteworthy] = loadfx("impacts/barrel_drain");
		break;
	}
}
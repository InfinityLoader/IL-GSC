/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1440.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 2:20:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::precache("woodgib_medium");
	maps\_utility::precache("woodgib_big");
	maps\_utility::precache("woodgib_small1");
	maps\_utility::precache("woodgib_small2");
	maps\_utility::precache("wood_plank2");
	maps\_utility::precache("gib_woodplank");
	var_00 = getentarray("wood_splinter","targetname");
	maps\_utility::array_thread(var_00,::func_43FA);
}

//Function Number: 2
func_43FA()
{
	if(!isdefined(self.target))
	{
		return;
	}

	var_00 = getentarray(self.target,"targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].script_noteworthy) && var_00[var_01].script_noteworthy == "notsolid")
		{
			var_00[var_01] notsolid();
		}

		if(!isdefined(var_00[var_01].target))
		{
			continue;
		}

		var_00[var_01].var_43FB = getentarray(var_00[var_01].target,"targetname");
		for(var_02 = 0;var_02 < var_00[var_01].var_43FB.size;var_02++)
		{
			if(isdefined(var_00[var_01].var_43FB[var_02]))
			{
				var_00[var_01].var_43FB[var_02] hide();
			}
		}
	}

	if(isdefined(self.script_noteworthy))
	{
		level waittill(self.script_noteworthy);
	}

	self waittill("trigger",var_03);
	if(isplayer(var_03))
	{
		var_04 = var_03 getorigin();
	}
	else
	{
		var_04 = var_04.origin;
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!isdefined(var_00[var_01].target))
		{
			continue;
		}

		var_00[var_01].var_43FB = getentarray(var_00[var_01].target,"targetname");
		for(var_02 = 0;var_02 < var_00[var_01].var_43FB.size;var_02++)
		{
			if(isdefined(var_00[var_01].var_43FB[var_02]))
			{
				var_00[var_01].var_43FB[var_02] show();
			}
		}
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!isdefined(var_00[var_01]))
		{
			continue;
		}

		var_00[var_01] playsound("wood_break");
		var_00[var_01] thread func_43FC(var_04);
		var_00[var_01] delete();
	}
}

//Function Number: 3
func_43FC(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	if(randomint(100) > 25)
	{
		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "dark")
		{
			if(randomint(100) > 50)
			{
				var_01 setmodel("wood_plank2");
			}
			else
			{
				var_01 setmodel("gib_woodplank");
			}
		}
		else if(randomint(100) > 50)
		{
			var_01 setmodel("woodgib_big");
		}
		else
		{
			var_01 setmodel("woodgib_medium");
		}
	}

	var_01.origin = self getorigin();
	var_01 thread func_43FD(param_00);
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "dark")
	{
		return;
	}

	func_43FE(var_01.origin,param_00);
}

//Function Number: 4
func_43FD(param_00)
{
	var_01 = vectornormalize(self.origin - param_00);
	var_01 = var_01 * 250 + randomint(100);
	var_02 = var_01[0];
	var_03 = var_01[1];
	var_04 = 200 + randomint(100);
	if(var_02 > 0)
	{
		self rotateroll(1500 + randomfloat(2500) * -1,5,0,0);
	}
	else
	{
		self rotateroll(1500 + randomfloat(2500),5,0,0);
	}

	self movegravity((var_02,var_03,var_04),12);
	wait 6;
	self delete();
}

//Function Number: 5
func_43FE(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < randomint(6) + 1;var_03++)
	{
		var_02[var_03] = spawn("script_model",param_00);
		var_02[var_03].origin = var_02[var_03].origin + (randomfloat(10) - 5,0,randomfloat(30) - 15);
		if(randomint(100) > 50)
		{
			var_02[var_03] setmodel("woodgib_small1");
		}
		else
		{
			var_02[var_03] setmodel("woodgib_small2");
		}

		param_01 = param_01 + (50 - randomint(100),50 - randomint(100),0);
		var_04 = vectornormalize(param_00 - param_01);
		var_04 = var_04 * 300 + randomint(150);
		var_05 = var_04[0];
		var_06 = var_04[1];
		var_07 = 120 + randomint(200);
		var_02[var_03] movegravity((var_05,var_06,var_07),12);
		if(var_05 > 0)
		{
			var_02[var_03] rotateroll(1500 + randomfloat(2500) * -1,5,0,0);
			continue;
		}

		var_02[var_03] rotateroll(1500 + randomfloat(2500),5,0,0);
	}

	wait 6;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] delete();
	}
}
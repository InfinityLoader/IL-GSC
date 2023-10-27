/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1534.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 1:32:27 AM
*******************************************************************/

//Function Number: 1
func_74B9()
{
	return !maps\mp\_utility::_hasperk("specialty_empimmune") && maps\mp\_utility::func_48B2();
}

//Function Number: 2
applyglobalempeffects()
{
	visionsetnaked("coup_sunblind",0.05);
	wait(0.05);
	visionsetnaked("coup_sunblind",0);
	visionsetnaked("",0.5);
}

//Function Number: 3
applyperplayerempeffects_ondetonate()
{
	self playlocalsound("emp_activate");
}

//Function Number: 4
applyperplayerempeffects()
{
	self setempjammed(1);
	if(maps\mp\_utility::_hasperk("specialty_localjammer"))
	{
		self clearscrambler();
	}

	thread func_7AD1();
}

//Function Number: 5
func_65A7()
{
	self setempjammed(0);
	if(maps\mp\_utility::_hasperk("specialty_localjammer"))
	{
		self makescrambler();
	}

	thread func_7C5D();
}

//Function Number: 6
func_7AD1()
{
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("disconnect");
	self.bisplayingjameffects = 1;
	thread doempartifactloop();
	wait(1);
	self setclientomnvar("ui_hud_static",2);
	wait(0.5);
	self notify("emp_stop_artifact");
	self setclientomnvar("ui_hud_emp_artifact",0);
	for(;;)
	{
		self setclientomnvar("ui_hud_static",3);
		var_00 = randomfloatrange(0.25,1.25);
		wait(var_00);
		self setclientomnvar("ui_hud_static",2);
		wait(0.5);
	}
}

//Function Number: 7
func_7C5D()
{
	level endon("game_ended");
	self notify("emp_stop_effect");
	self endon("disconnect");
	if(isdefined(self.bisplayingjameffects))
	{
		self.bisplayingjameffects = undefined;
		self setclientomnvar("ui_hud_static",0);
		for(var_00 = 0;var_00 < 3;var_00++)
		{
			self setclientomnvar("ui_hud_emp_artifact",1);
			wait(0.5);
		}

		self setclientomnvar("ui_hud_emp_artifact",0);
		self.player_static_value = 0;
	}
}

//Function Number: 8
func_7C5E()
{
	self notify("emp_stop_effect");
	if(isdefined(self.bisplayingjameffects) || isdefined(self.player_static_value))
	{
		self.bisplayingjameffects = undefined;
		self.player_static_value = 0;
		self setclientomnvar("ui_hud_static",0);
		self setclientomnvar("ui_hud_emp_artifact",0);
	}
}

//Function Number: 9
doempartifactloop()
{
	self notify("emp_stop_artifact");
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("emp_stop_artifact");
	self endon("disconnect");
	self endon("joined_spectators");
	for(;;)
	{
		self setclientomnvar("ui_hud_emp_artifact",1);
		var_00 = randomfloatrange(0.375,0.5);
		wait(var_00);
	}
}

//Function Number: 10
func_2877(param_00)
{
	self notify("emp_stop_static");
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("emp_stop_static");
	self endon("disconnect");
	self endon("joined_spectators");
	var_01 = 1;
	var_02 = 2;
	if(param_00 == 2)
	{
		var_01 = 0.5;
		var_02 = 0.75;
	}

	for(;;)
	{
		self setclientomnvar("ui_hud_static",2);
		var_03 = randomfloatrange(var_01,var_02);
		wait(var_03);
	}
}

//Function Number: 11
func_7B21()
{
	self.player_static_value = 0;
}

//Function Number: 12
func_7B22(param_00)
{
	if(self.player_static_value != param_00 && isalive(self) && !maps\mp\_utility::func_48B2())
	{
		self.player_static_value = param_00;
		switch(param_00)
		{
			case 0:
				func_7C5D();
				break;

			case 1:
				self.bisplayingjameffects = 1;
				self notify("emp_stop_static");
				thread doempartifactloop();
				thread func_2877(1);
				break;

			case 2:
				self.bisplayingjameffects = 1;
				self notify("emp_stop_static");
				self notify("emp_stop_artifact");
				thread func_2877(2);
				break;
		}
	}
}

//Function Number: 13
func_94E8()
{
	return self.player_static_value;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _player_boost_dash.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 133 ms
 * Timestamp: 4/22/2024 2:22:07 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
enable_boost_dash()
{
	if(!isdefined(self.boost))
	{
		self.boost = [];
		self.boost["inboost"] = 0;
	}

	self allowsprint(0);
	thread track_player_movement();
	thread track_player_velocity();
	thread dash();
}

//Function Number: 3
disable_boost_dash()
{
	self notify("disable_boost_dash");
	self.boost = undefined;
	self allowsprint(1);
}

//Function Number: 4
track_player_movement()
{
	self endon("death");
	self endon("disable_boost_dash");
	if(!isdefined(self.boost["stick_input"]))
	{
		self.boost["stick_input"] = (0,0,0);
	}

	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_00 = (var_00[0],var_00[1] * -1,0);
		var_01 = self.angles;
		var_02 = vectortoangles(var_00);
		var_03 = common_scripts\utility::flat_angle(combineangles(var_01,var_02));
		var_04 = anglestoforward(var_03) * length(var_00);
		self.boost["stick_input"] = var_04;
		wait(0.05);
	}
}

//Function Number: 5
track_player_velocity()
{
	self endon("death");
	self endon("disable_boost_dash");
	if(!isdefined(self.boost["player_vel"]))
	{
		self.boost["player_vel"] = (0,0,0);
	}

	for(;;)
	{
		self.boost["player_vel"] = self getvelocity();
		wait(0.05);
	}
}

//Function Number: 6
dash()
{
	self endon("death");
	self endon("disable_boost_dash");
	for(;;)
	{
		waittill_dash_button_pressed();
		var_00 = 400;
		var_01 = (0,0,300);
		var_02 = 0.5;
		var_03 = 1;
		var_04 = 700;
		if(self isonground() && !self adsbuttonpressed())
		{
			thread boost_dash(var_00,var_01,var_02,var_03,var_04);
		}

		waittill_dash_button_released();
	}
}

//Function Number: 7
boost_dash(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("mode_switch");
	self endon("death");
	self.boost["inboost"] = 1;
	earthquake(0.3,1,self.origin,300);
	var_06 = self.boost["stick_input"];
	var_07 = self.boost["player_vel"] * param_02;
	if(var_07[2] > 0)
	{
		var_07 = (var_07[0],var_07[1],0);
	}

	var_08 = var_07 + var_06 * param_00 + param_01;
	if(isdefined(param_03) && param_03)
	{
		if(!isdefined(param_04))
		{
			var_09 = param_01[2];
		}

		var_0A = var_08;
		var_08 = vectornormalize(var_08) * param_04;
		var_08 = (var_08[0],var_08[1],var_0A[2]);
		if(var_06[2] == 0)
		{
			var_0B = 0.7;
			var_08 = (var_08[0],var_08[1],var_08[2] * var_0B);
		}
	}

	var_0C = 2;
	if(isdefined(param_05) && param_05)
	{
		var_0D = 0;
		var_0E = self.boost["player_vel"];
		var_0F = var_08;
		var_10 = var_0F - var_0E;
		var_11 = var_10 / var_0C;
		while(var_0D <= var_0C)
		{
			self setvelocity(var_0E + var_11);
			wait(0.05);
			var_0D++;
		}
	}

	self setvelocity(var_08);
}

//Function Number: 8
waittill_dash_button_pressed()
{
	self endon("death");
	while(!self sprintbuttonpressed())
	{
		wait(0.05);
	}

	return 1;
}

//Function Number: 9
waittill_dash_button_released()
{
	self endon("death");
	while(self sprintbuttonpressed())
	{
		wait(0.05);
	}

	return 1;
}
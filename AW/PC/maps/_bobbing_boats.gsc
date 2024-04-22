/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _bobbing_boats.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 197 ms
 * Timestamp: 4/22/2024 2:20:06 AM
*******************************************************************/

//Function Number: 1
createdefaultbobsettings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 3;
	var_00.min_pitch_period = 3;
	var_00.max_pitch_period = 6;
	var_00.max_yaw = 0;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 6;
	var_00.min_roll_period = 3;
	var_00.max_roll_period = 6;
	var_00.max_sink = 36;
	var_00.max_float = 24;
	var_00.min_bob_period = 3;
	var_00.max_bob_period = 6;
	return var_00;
}

//Function Number: 2
createdefaultsmallbobsettings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 10;
	var_00.min_pitch_period = 1;
	var_00.max_pitch_period = 3;
	var_00.max_yaw = 0;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 10;
	var_00.min_roll_period = 1;
	var_00.max_roll_period = 3;
	var_00.max_sink = 12;
	var_00.max_float = 12;
	var_00.min_bob_period = 1;
	var_00.max_bob_period = 3;
	var_00.isbuoy = 1;
	return var_00;
}

//Function Number: 3
no_bobbing()
{
	self.nobob = 1;
	self notify("stop_bobbing");
}

//Function Number: 4
cleanup_bobbing()
{
	self.org_angles = self.angles;
	self.org_origin = self.origin;
	self waittill("stop_bobbing");
	waittillframeend;
	self rotateto(self.org_angles,1,0,0);
	self moveto(self.org_origin,1,0,0);
}

//Function Number: 5
start_bobbing_single(param_00)
{
	self notify("stop_bobbing");
	self endon("stop_bobbing");
	self endon("death");
	thread cleanup_bobbing();
	wait(param_00);
	if(isdefined(self.nobob) && self.nobob)
	{
		return;
	}

	self [[ self.bobbing_fnc ]](self.bobbing_settings);
}

//Function Number: 6
start_bobbing(param_00)
{
	var_01 = 1;
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		var_04 thread start_bobbing_single(var_02);
		var_02 = var_02 + 0.05;
		if(var_02 > var_01)
		{
			var_02 = var_02 - var_01;
		}
	}
}

//Function Number: 7
stop_bobbing(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 notify("stop_bobbing");
	}
}

//Function Number: 8
prep_bobbing(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00)
	{
		var_05.bobbing_fnc = param_01;
		var_05.bobbing_settings = param_02;
		var_05.bobbing_underwater = param_03;
	}
}

//Function Number: 9
bobbingobject(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles;
	var_03 = 5;
	var_04 = 3;
	var_05 = 6;
	var_06 = 0;
	var_07 = 3;
	var_08 = 6;
	var_09 = 0;
	var_0A = 3;
	var_0B = 6;
	var_0C = 36;
	var_0D = 24;
	var_0E = 3;
	var_0F = 6;
	var_10 = 0;
	var_11 = 3;
	var_12 = 6;
	var_13 = 0;
	var_14 = 3;
	var_15 = 6;
	var_16 = 1;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.max_pitch))
		{
			var_03 = param_00.max_pitch;
		}

		if(isdefined(param_00.min_pitch_period))
		{
			var_04 = param_00.min_pitch_period;
		}

		if(isdefined(param_00.max_pitch_period))
		{
			var_05 = param_00.max_pitch_period;
		}

		if(isdefined(param_00.max_yaw))
		{
			var_06 = param_00.max_yaw;
		}

		if(isdefined(param_00.min_yaw_period))
		{
			var_07 = param_00.min_yaw_period;
		}

		if(isdefined(param_00.max_yaw_period))
		{
			var_08 = param_00.max_yaw_period;
		}

		if(isdefined(param_00.max_roll))
		{
			var_09 = param_00.max_roll;
		}

		if(isdefined(param_00.min_roll_period))
		{
			var_0A = param_00.min_roll_period;
		}

		if(isdefined(param_00.max_roll_period))
		{
			var_0B = param_00.max_roll_period;
		}

		if(isdefined(param_00.max_sink))
		{
			var_0C = param_00.max_sink;
		}

		if(isdefined(param_00.max_float))
		{
			var_0D = param_00.max_float;
		}

		if(isdefined(param_00.min_bob_period))
		{
			var_0E = param_00.min_bob_period;
		}

		if(isdefined(param_00.max_bob_period))
		{
			var_0F = param_00.max_bob_period;
		}

		if(isdefined(param_00.max_dx))
		{
			var_10 = param_00.max_dx;
		}

		if(isdefined(param_00.min_dx_period))
		{
			var_11 = param_00.min_dx_period;
		}

		if(isdefined(param_00.max_dx_period))
		{
			var_12 = param_00.max_dx_period;
		}

		if(isdefined(param_00.max_dy))
		{
			var_13 = param_00.max_dy;
		}

		if(isdefined(param_00.min_dy_period))
		{
			var_14 = param_00.min_dy_period;
		}

		if(isdefined(param_00.max_dy_period))
		{
			var_15 = param_00.max_dy_period;
		}

		if(isdefined(param_00.oldstyle))
		{
			var_16 = param_00.oldstyle;
		}
	}

	self.tgt_values[0] = var_02[0];
	self.tgt_values[1] = var_02[1];
	self.tgt_values[2] = var_02[2];
	self.tgt_values[3] = var_01[0];
	self.tgt_values[4] = var_01[1];
	self.tgt_values[5] = var_01[2];
	if(!var_16)
	{
		thread bobobjectto(isdefined(param_00.isbuoy));
	}

	if(isdefined(param_00.isbuoy))
	{
		thread bobbingbuoyangles();
	}
	else
	{
		if(var_03 > 0)
		{
			thread bobobjectparam(0,var_02[0],0 - var_03,var_03,var_04,var_05,var_16);
		}

		if(var_06 > 0)
		{
			thread bobobjectparam(1,var_02[1],0 - var_06,var_06,var_07,var_08,var_16);
		}

		if(var_09 > 0)
		{
			thread bobobjectparam(2,var_02[2],0 - var_09,var_09,var_0A,var_0B,var_16);
		}
	}

	if(var_10 > 0)
	{
		thread bobobjectparam(3,var_01[0],0 - var_10,var_10,var_11,var_12,var_16);
	}

	if(var_13 > 0)
	{
		thread bobobjectparam(4,var_01[1],0 - var_13,var_13,var_14,var_15,var_16);
	}

	if(var_0D > 0)
	{
		thread bobobjectparam(5,var_01[2],0 - var_0C,var_0D,var_0E,var_0F,var_16);
	}
}

//Function Number: 10
bobobjectparam(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("stop_bobbing");
	self endon("death");
	var_07 = randomint(2);
	self.tgt_values[param_00] = param_01;
	for(;;)
	{
		var_08 = param_01;
		var_09 = param_04;
		switch(var_07)
		{
			case 0:
				var_08 = param_01 + randomfloat(param_03);
				break;
	
			case 1:
				if(param_02 < 0)
				{
					var_08 = param_01 - randomfloat(-1 * param_02);
				}
				else
				{
					var_08 = param_01 + randomfloat(param_02);
				}
				break;
		}

		var_09 = randomfloatrange(param_04,param_05);
		var_0A = var_09 / 3;
		var_0B = var_09 / 3;
		if(param_06)
		{
			var_0C = 0;
			if(param_00 < 3)
			{
				var_0C = var_08 - self.angles[param_00];
				var_0C = angleclamp180(var_0C);
			}

			switch(param_00)
			{
				case 0:
					self rotatepitch(var_0C,var_09,var_0A,var_0B);
					break;
	
				case 1:
					self rotateyaw(var_0C,var_09,var_0A,var_0B);
					break;
	
				case 2:
					self rotateroll(var_0C,var_09,var_0A,var_0B);
					break;
	
				case 3:
					self movex(var_08 - self.origin[0],var_09,var_0A,var_0B);
					break;
	
				case 4:
					self movey(var_08 - self.origin[1],var_09,var_0A,var_0B);
					break;
	
				case 5:
					self movez(var_08 - self.origin[2],var_09,var_0A,var_0B);
					break;
			}

			wait(var_09);
		}
		else
		{
			while(0 < var_09)
			{
				var_0D = self.tgt_values[param_00];
				var_0C = var_08 - var_0D;
				self.tgt_values[param_00] = self.tgt_values[param_00] + 0.05 / var_09 * var_0C;
				wait(0.05);
				var_09 = var_09 - 0.05;
			}
		}

		var_07 = 1 - var_07;
	}
}

//Function Number: 11
bobbingbuoyangles()
{
	self endon("stop_bobbing");
	self endon("death");
	var_00 = 0.3;
	var_01 = 1.5;
	var_02 = 60;
	var_03 = 3;
	var_04 = 4;
	var_05 = var_00 * var_04;
	var_06 = 0;
	self.org_angles = self.angles;
	if(self.org_angles[0] == 0 && self.org_angles[2] == 0)
	{
		var_07 = 1;
	}
	else
	{
		var_07 = 0;
	}

	var_08 = (0,0,0);
	var_09 = 18 / var_02;
	var_0A = 0.36 / var_03;
	for(;;)
	{
		var_0B = calcrockingangles(self.org_angles,var_06,4,3,60);
		var_0C = var_0B["angles"];
		var_06 = var_0B["result"];
		self rotateto(var_0C,0.4,0,0);
		wait(0.2);
	}
}

//Function Number: 12
bobobjectto(param_00)
{
	self endon("stop_bobbing");
	self endon("death");
	for(;;)
	{
		var_01 = (self.tgt_values[3],self.tgt_values[4],self.tgt_values[5]);
		var_02 = (self.tgt_values[0],self.tgt_values[1],self.tgt_values[2]);
		self moveto(var_01,0.1,0,0);
		if(!param_00)
		{
			self rotateto(var_02,0.1,0,0);
		}

		wait(0.05);
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_stop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 109 ms
 * Timestamp: 10/27/2023 2:17:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self clearanim(%root,0.1);
	self clearanim(%german_shepherd_idle,0.2);
	self clearanim(%german_shepherd_attackidle_knob,0.2);
	thread func_3B01("attackIdle");
	for(;;)
	{
		if(func_3AFF())
		{
			self clearanim(%german_shepherd_idle,0.2);
			func_3AFE();
		}
		else
		{
			self orientmode("face current");
			self clearanim(%german_shepherd_attackidle_knob,0.2);
			self setflaggedanimrestart("dog_idle",%german_shepherd_idle,1,0.2,self.var_10F7);
		}

		animscripts/shared::donotetracks("dog_idle");
		if(isdefined(self.var_3AFC))
		{
			self.turnrate = self.var_3AFC;
			self.var_3AFC = undefined;
		}
	}
}

//Function Number: 2
func_3AFD(param_00)
{
	var_01 = self.enemy.origin - self.origin;
	var_02 = length(var_01);
	if(var_02 < 1)
	{
		return 1;
	}

	var_03 = anglestoforward(self.angles);
	return var_03[0] * var_01[0] + var_03[1] * var_01[1] / var_02 > param_00;
}

//Function Number: 3
func_3AFE()
{
	self clearanim(%german_shepherd_attackidle_knob,0.1);
	if(func_3AFD(0.866))
	{
		self orientmode("face angle",self.angles[1]);
	}
	else
	{
		if(isdefined(self.enemy))
		{
			var_00 = vectortoyaw(self.enemy.origin - self.origin);
			var_01 = angleclamp180(var_00 - self.angles[1]);
			if(abs(var_01) > 10)
			{
				self orientmode("face enemy");
				self.var_3AFC = self.turnrate;
				self.turnrate = 0.3;
				if(var_01 > 0)
				{
					var_02 = %german_shepherd_rotate_ccw;
				}
				else
				{
					var_02 = %german_shepherd_rotate_cw;
				}

				self setflaggedanimrestart("dog_turn",var_02,1,0.2,1);
				animscripts/shared::donotetracks("dog_turn");
				self.turnrate = self.var_3AFC;
				self.var_3AFC = undefined;
				self clearanim(%german_shepherd_rotate_cw,0.2);
				self clearanim(%german_shepherd_rotate_ccw,0.2);
			}
		}

		self orientmode("face angle",self.angles[1]);
	}

	if(func_3B00())
	{
		self setflaggedanimrestart("dog_idle",%german_shepherd_attackidle_growl,1,0.2,1);
		return;
	}

	var_03 = 33;
	var_04 = 66;
	if(isdefined(self.mode))
	{
		if(self.mode == "growl")
		{
			var_03 = 15;
			var_04 = 30;
		}
		else if(self.mode == "bark")
		{
			var_03 = 15;
			var_04 = 85;
		}
	}

	var_05 = randomint(100);
	if(var_05 < var_03)
	{
		self setflaggedanimrestart("dog_idle",%german_shepherd_attackidle_b,1,0.2,self.var_10F7);
		return;
	}

	if(var_05 < var_04)
	{
		self setflaggedanimrestart("dog_idle",%german_shepherd_attackidle_bark,1,0.2,self.var_10F7);
		return;
	}

	self setflaggedanimrestart("dog_idle",%german_shepherd_attackidle_growl,1,0.2,self.var_10F7);
}

//Function Number: 4
func_3AFF()
{
	return isdefined(self.enemy) && isalive(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 1000000;
}

//Function Number: 5
func_3B00()
{
	if(isdefined(self.var_23DB))
	{
		return 1;
	}

	if(!isalive(self.enemy))
	{
		return 1;
	}

	return !self cansee(self.enemy);
}

//Function Number: 6
func_3B01(param_00)
{
	self endon("killanimscript");
	self endon("stop tracking");
	self clearanim(%german_shepherd_look_2,0);
	self clearanim(%german_shepherd_look_4,0);
	self clearanim(%german_shepherd_look_6,0);
	self clearanim(%german_shepherd_look_8,0);
	self setdefaultaimlimits();
	self.var_716 = 90;
	self.var_717 = -90;
	self setanimlimited(level.var_3AF9[param_00][2],1,0);
	self setanimlimited(level.var_3AF9[param_00][4],1,0);
	self setanimlimited(level.var_3AF9[param_00][6],1,0);
	self setanimlimited(level.var_3AF9[param_00][8],1,0);
	animscripts/track::func_CC4(1,0.2);
	animscripts/track::func_CAA(%german_shepherd_look_2,%german_shepherd_look_4,%german_shepherd_look_6,%german_shepherd_look_8);
}
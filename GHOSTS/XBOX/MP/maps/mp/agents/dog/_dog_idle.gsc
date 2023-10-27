/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_idle.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 292 ms
 * Timestamp: 10/27/2023 1:27:51 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animsubstate = "none";
	func_70E7();
	self.timeofnextsound = self.timeofnextsound + 2000;
	self.bidlehitreaction = 0;
	self setgoalpos(self.origin);
	self setorientmode("face angle abs",self.angles);
	self setanimmode("anim deltas");
	self setphysicsmode("gravity");
	func_8737();
}

//Function Number: 2
end_script()
{
	if(isdefined(self.prevturnrate))
	{
		self setmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}
}

//Function Number: 3
func_8737()
{
	self endon("killanimscript");
	self endon("cancelidleloop");
	for(;;)
	{
		var_00 = self.animsubstate;
		var_01 = func_26DC();
		if(var_01 != self.animsubstate)
		{
			func_2F67(var_01);
		}

		func_86C9();
		switch(self.animsubstate)
		{
			case "idle_combat":
				wait(0.2);
				break;
	
			case "idle_noncombat":
				if(var_00 == "none")
				{
					if(self.movemode == "run" || self.movemode == "sprint")
					{
						self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_pants_mp_fast","anml_dog_pants_mp_fast"));
					}
					else
					{
						self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_pants_mp_med","anml_dog_pants_mp_med"));
					}
				}
				else if(gettime() > self.timeofnextsound)
				{
					if(randomint(10) < 4)
					{
						self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_whine","anml_dog_whine"));
					}
					else
					{
						self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_pants_mp_med","anml_dog_pants_mp_med"));
					}
		
					func_70E7();
				}
		
				wait(0.5);
				break;
	
			default:
				wait(1);
				break;
		}
	}
}

//Function Number: 4
func_26DC()
{
	if(func_749D())
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 5
func_2F67(param_00)
{
	func_309E(self.animsubstate);
	self.animsubstate = param_00;
	func_6016();
}

//Function Number: 6
func_309E(param_00)
{
	if(isdefined(self.prevturnrate))
	{
		self setmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}
}

//Function Number: 7
func_6016()
{
	if(self.animsubstate == "idle_combat")
	{
		self setanimstate("attack_idle");
	}

	self setanimstate("casual_idle");
}

//Function Number: 8
func_86C9()
{
	var_00 = undefined;
	if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.origin) < 1048576)
	{
		var_00 = self.enemy;
	}
	else if(isdefined(self.owner) && distancesquared(self.owner.origin,self.origin) > 576)
	{
		var_00 = self.owner;
	}

	if(isdefined(var_00))
	{
		var_01 = var_00.origin - self.origin;
		var_02 = vectortoangles(var_01);
		if(abs(angleclamp180(var_02[1] - self.angles[1])) > 1)
		{
			func_84BE(var_02[1]);
		}
	}
}

//Function Number: 9
func_749D()
{
	return isdefined(self.enemy) && maps\mp\_utility::func_4945(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 1000000;
}

//Function Number: 10
getturnanimstate(param_00)
{
	if(func_749D())
	{
		if(param_00 < -135 || param_00 > 135)
		{
			return "attack_turn_180";
		}

		if(param_00 < 0)
		{
			return "attack_turn_right_90";
		}

		return "attack_turn_left_90";
	}

	if(param_00 < -135 || param_00 > 135)
	{
		return "casual_turn_180";
	}

	if(param_00 < 0)
	{
		return "casual_turn_right_90";
	}

	return "casual_turn_left_90";
}

//Function Number: 11
func_84BE(param_00)
{
	var_01 = self.angles[1];
	var_02 = angleclamp180(param_00 - var_01);
	if(-0.5 < var_02 && var_02 < 0.5)
	{
	}

	if(-10 < var_02 && var_02 < 10)
	{
		func_687C(param_00,2);
	}

	var_03 = getturnanimstate(var_02);
	var_04 = self getanimentry(var_03,0);
	var_05 = getanimlength(var_04);
	var_06 = distance2dsquared(var_04);
	self setanimmode("anim angle delta");
	if(animhasnotetrack(var_04,"turn_begin") && animhasnotetrack(var_04,"turn_end"))
	{
		maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_03,0,"turn_in_place");
		var_07 = getnotetracktimes(var_04,"turn_begin");
		var_08 = getnotetracktimes(var_04,"turn_end");
		var_09 = var_08[0] - var_07[0] * var_05;
		var_0A = angleclamp180(var_02 - var_06[1]);
		var_0B = abs(var_0A) / var_09 / 20;
		var_0B = var_0B * 3.14159 / 180;
		var_0C = (0,angleclamp180(self.angles[1] + var_0A),0);
		self.prevturnrate = self getmaxturnspeed();
		self setmaxturnspeed(var_0B);
		self setorientmode("face angle abs",var_0C);
		maps/mp/agents/_scriptedagents::func_8BCA("turn_in_place","turn_end");
		self setmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
		maps/mp/agents/_scriptedagents::func_8BCA("turn_in_place","end");
	}
	else
	{
		self.prevturnrate = self getmaxturnspeed();
		var_0B = abs(angleclamp180(var_04 - var_0C[1])) / var_0B / 20;
		var_0C = var_0C * 3.14159 / 180;
		self setmaxturnspeed(var_0C);
		var_0C = (0,angleclamp180(var_01 - var_0B[1]),0);
		self setorientmode("face angle abs",var_0C);
		maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_03,0,"turn_in_place");
		self setmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}

	self setanimmode("anim deltas");
	func_6016();
}

//Function Number: 12
func_687C(param_00,param_01)
{
	if(abs(angleclamp180(param_00 - self.angles[1])) <= param_01)
	{
	}

	var_02 = (0,param_00,0);
	self setorientmode("face angle abs",var_02);
	while(angleclamp180(param_00 - self.angles[1]) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 13
func_70E7()
{
	self.timeofnextsound = gettime() + 8000 + randomint(5000);
}

//Function Number: 14
func_2954(param_00)
{
	self.blockgoalpos = 1;
	self.statelocked = 1;
	self.bidlehitreaction = 1;
	var_01 = angleclamp180(param_00 - self.angles[1]);
	if(var_01 > 0)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	self notify("cancelidleloop");
	self setanimmode("anim deltas");
	self setorientmode("face angle abs",self.angles);
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack("stand_pain",var_02,"stand_pain");
	self.blockgoalpos = 0;
	self.statelocked = 0;
	self.bidlehitreaction = 0;
	self setorientmode("face angle abs",self.angles);
	self.animsubstate = "none";
	thread func_8737();
}

//Function Number: 15
func_5906(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(self.bidlehitreaction)
	{
	}

	var_0A = vectortoangles(param_07);
	var_0B = var_0A[1] - 180;
	func_2954(var_0B);
}

//Function Number: 16
func_593B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(self.bidlehitreaction)
	{
	}

	func_2954(self.angles[1] + 180);
}
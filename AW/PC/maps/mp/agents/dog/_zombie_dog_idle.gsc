/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_zombie_dog_idle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 204 ms
 * Timestamp: 4/22/2024 2:08:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animsubstate = "none";
	self scragentsetgoalpos(self.origin);
	self scragentsetorientmode("face angle abs",self.angles);
	self scragentsetanimmode("anim deltas");
	self scragentsetphysicsmode("gravity");
	updatestate();
}

//Function Number: 2
end_script()
{
	if(isdefined(self.prevturnrate))
	{
		self scragentsetmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}
}

//Function Number: 3
updatestate()
{
	self endon("killanimscript");
	self endon("UpdateState");
	for(;;)
	{
		var_00 = determinestate();
		if(var_00 != self.animsubstate)
		{
			exitstate(self.animsubstate);
			enterstate(var_00);
		}

		updateangle();
		switch(self.animsubstate)
		{
			case "idle_combat":
				wait(0.2);
				break;
	
			case "idle_noncombat":
				wait(0.5);
				break;
	
			default:
				wait(1);
				break;
		}
	}
}

//Function Number: 4
determinestate()
{
	if(isdefined(self.idlestateoverridefunc))
	{
		return [[ self.idlestateoverridefunc ]]();
	}

	if(shouldattackidle())
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 5
enterstate(param_00)
{
	self.animsubstate = param_00;
	playidleanim();
}

//Function Number: 6
exitstate(param_00)
{
	if(isdefined(self.prevturnrate))
	{
		self scragentsetmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}
}

//Function Number: 7
playidleanim()
{
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(self.animsubstate);
}

//Function Number: 8
updateangle()
{
	var_00 = undefined;
	if(isdefined(self.targetofinterest) && distancesquared(self.targetofinterest.origin,self.origin) < 262144)
	{
		var_00 = self.targetofinterest;
	}
	else if(isdefined(self.distractiondrone) && distancesquared(self.distractiondrone.groundpos,self.origin) < 16384)
	{
		var_00 = self.distractiondrone;
	}
	else if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.origin) < 1048576)
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
			turntoangle(var_02[1]);
		}
	}
}

//Function Number: 9
shouldattackidle()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) >= 1000000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
getturnanimstate(param_00)
{
	var_01 = "idle_noncombat_turn";
	if(shouldattackidle())
	{
		var_01 = "idle_combat_turn";
	}

	var_02 = self getanimentrycount(var_01);
	var_03 = 0;
	if(var_02 == 3)
	{
		if(param_00 < -135 || param_00 > 135)
		{
			var_03 = 0;
		}
		else if(param_00 < 0)
		{
			var_03 = 1;
		}
		else
		{
			var_03 = 2;
		}
	}

	return [var_01,var_03];
}

//Function Number: 11
turntoangle(param_00)
{
	var_01 = self.angles[1];
	var_02 = angleclamp180(param_00 - var_01);
	if(-0.5 < var_02 && var_02 < 0.5)
	{
		return;
	}

	if(-10 < var_02 && var_02 < 10)
	{
		rotatetoangle(param_00,2);
		return;
	}

	var_03 = getturnanimstate(var_02);
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = self getanimentry(var_04,var_05);
	var_07 = getanimlength(var_06);
	var_08 = getangledelta3d(var_06);
	self scragentsetanimmode("anim angle delta");
	if(animhasnotetrack(var_06,"turn_begin") && animhasnotetrack(var_06,"turn_end"))
	{
		maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.generalspeedratescale,"turn_in_place");
		var_09 = getnotetracktimes(var_06,"turn_begin");
		var_0A = getnotetracktimes(var_06,"turn_end");
		var_0B = var_0A[0] - var_09[0] * var_07;
		var_0C = angleclamp180(var_02 - var_08[1]);
		var_0D = abs(var_0C) / var_0B / 20;
		var_0D = var_0D * 3.14159 / 180;
		var_0E = (0,angleclamp180(self.angles[1] + var_0C),0);
		self.prevturnrate = self scragentgetmaxturnspeed();
		self scragentsetmaxturnspeed(var_0D);
		self scragentsetorientmode("face angle abs",var_0E);
		var_07 = getanimlength(self getanimentry(var_04,var_05));
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("turn_in_place","turn_end",var_07);
		self scragentsetmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("turn_in_place","end",var_07);
	}
	else
	{
		self.prevturnrate = self scragentgetmaxturnspeed();
		var_0D = abs(angleclamp180(var_04 - var_0E[1])) / var_0D / 20;
		var_0E = var_0E * 3.14159 / 180;
		self scragentsetmaxturnspeed(var_0E);
		var_0E = (0,angleclamp180(var_01 - var_0D[1]),0);
		self scragentsetorientmode("face angle abs",var_0E);
		maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.generalspeedratescale,"turn_in_place");
		self scragentsetmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
	}

	self scragentsetanimmode("anim deltas");
	playidleanim();
}

//Function Number: 12
rotatetoangle(param_00,param_01)
{
	if(abs(angleclamp180(param_00 - self.angles[1])) <= param_01)
	{
		return;
	}

	var_02 = (0,param_00,0);
	self scragentsetorientmode("face angle abs",var_02);
	while(angleclamp180(param_00 - self.angles[1]) > param_01)
	{
		wait(0.1);
	}
}
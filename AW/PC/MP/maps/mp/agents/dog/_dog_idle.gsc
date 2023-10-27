/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_idle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 286 ms
 * Timestamp: 10/27/2023 1:40:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animsubstate = "none";
	settimeofnextsound();
	self.timeofnextsound = self.timeofnextsound + 2000;
	self.bidlehitreaction = 0;
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
	self endon("cancelidleloop");
	var_00 = self.animsubstate;
	var_01 = determinestate();
	if(var_01 != self.animsubstate)
	{
		enterstate(var_01);
	}

	updateangle();
	switch(self.animsubstate)
	{
		case "idle_combat":
			break;

		case "idle_noncombat":
			break;

		default:
			break;
	}
}

//Function Number: 4
determinestate()
{
	if(shouldattackidle())
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 5
enterstate(param_00)
{
	exitstate(self.animsubstate);
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
	if(self.animsubstate == "idle_combat")
	{
		self setanimstate("attack_idle");
		return;
	}

	self setanimstate("casual_idle");
}

//Function Number: 8
updateangle()
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
			turntoangle(var_02[1]);
		}
	}
}

//Function Number: 9
shouldattackidle()
{
	return isdefined(self.enemy) && maps\mp\_utility::isreallyalive(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 1000000;
}

//Function Number: 10
getturnanimstate(param_00)
{
	if(shouldattackidle())
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
	var_04 = self getanimentry(var_03,0);
	var_05 = getanimlength(var_04);
	var_06 = getangledelta3d(var_04);
	self scragentsetanimmode("anim angle delta");
	if(animhasnotetrack(var_04,"turn_begin") && animhasnotetrack(var_04,"turn_end"))
	{
		maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_03,0,"turn_in_place");
		var_07 = getnotetracktimes(var_04,"turn_begin");
		var_08 = getnotetracktimes(var_04,"turn_end");
		var_09 = var_08[0] - var_07[0] * var_05;
		var_0A = angleclamp180(var_02 - var_06[1]);
		var_0B = abs(var_0A) / var_09 / 20;
		var_0B = var_0B * 3.14159 / 180;
		var_0C = (0,angleclamp180(self.angles[1] + var_0A),0);
		self.prevturnrate = self scragentgetmaxturnspeed();
		self scragentsetmaxturnspeed(var_0B);
		self scragentsetorientmode("face angle abs",var_0C);
		maps\mp\agents\_scriptedagents::waituntilnotetrack("turn_in_place","turn_end");
		self scragentsetmaxturnspeed(self.prevturnrate);
		self.prevturnrate = undefined;
		maps\mp\agents\_scriptedagents::waituntilnotetrack("turn_in_place","end");
	}
	else
	{
		self.prevturnrate = self scragentgetmaxturnspeed();
		var_0B = abs(angleclamp180(var_04 - var_0C[1])) / var_0B / 20;
		var_0C = var_0C * 3.14159 / 180;
		self scragentsetmaxturnspeed(var_0C);
		var_0C = (0,angleclamp180(var_01 - var_0B[1]),0);
		self scragentsetorientmode("face angle abs",var_0C);
		maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_03,0,"turn_in_place");
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

//Function Number: 13
settimeofnextsound()
{
	self.timeofnextsound = gettime() + 8000 + randomint(5000);
}

//Function Number: 14
dohitreaction(param_00)
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
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",self.angles);
	maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("stand_pain",var_02,"stand_pain");
	self.blockgoalpos = 0;
	self.statelocked = 0;
	self.bidlehitreaction = 0;
	self scragentsetorientmode("face angle abs",self.angles);
	self.animsubstate = "none";
	thread updatestate();
}

//Function Number: 15
ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(self.bidlehitreaction)
	{
		return;
	}

	var_0A = vectortoangles(param_07);
	var_0B = var_0A[1] - 180;
	dohitreaction(var_0B);
}

//Function Number: 16
onflashbanged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(self.bidlehitreaction)
	{
		return;
	}

	dohitreaction(self.angles[1] + 180);
}
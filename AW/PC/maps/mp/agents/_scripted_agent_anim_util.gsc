/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_scripted_agent_anim_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 254 ms
 * Timestamp: 4/22/2024 2:08:26 AM
*******************************************************************/

//Function Number: 1
playanimnatrateuntilnotetrack_safe(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_00))
	{
		if(isdefined(param_01))
		{
			var_06 = getanimlength(self getanimentry(param_00,param_01));
		}
		else
		{
			var_06 = getanimlength(self getanimentry(param_01,0));
		}

		childthread notetrack_timeout(param_03,var_06 * 1 / param_02,param_04);
	}

	playanimnatrateuntilnotetrack(param_00,param_01,param_02,param_03,param_04,param_05);
	self notify("Notetrack_Timeout");
}

//Function Number: 2
playanimnuntilnotetrack_safe(param_00,param_01,param_02,param_03,param_04)
{
	playanimnatrateuntilnotetrack_safe(param_00,param_01,1,param_02,param_03,param_04);
}

//Function Number: 3
playanimnatrateuntilnotetrack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	set_anim_state(param_00,param_01,param_02);
	if(!isdefined(param_04))
	{
		param_04 = "end";
	}

	waituntilnotetrack(param_03,param_04,param_00,param_01,param_05);
}

//Function Number: 4
waituntilnotetrack_safe(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_02))
	{
		childthread notetrack_timeout(param_00,param_02,param_01);
	}

	waituntilnotetrack(param_00,param_01);
	self notify("Notetrack_Timeout");
}

//Function Number: 5
waituntilnotetrack(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = gettime();
	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(param_02) && isdefined(param_03))
	{
		var_07 = getanimlength(self getanimentry(param_02,param_03));
	}

	for(;;)
	{
		self waittill(param_00,var_08);
		if(isdefined(var_07))
		{
			var_06 = gettime() - var_05 * 0.001 / var_07;
		}

		if(!isdefined(var_07) || var_06 > 0)
		{
			if(var_08 == param_01 || var_08 == "end" || var_08 == "anim_will_finish" || var_08 == "finish")
			{
				break;
			}
		}

		if(isdefined(param_04))
		{
			[[ param_04 ]](var_08,param_02,param_03,var_06);
		}
	}
}

//Function Number: 6
notetrack_timeout(param_00,param_01,param_02)
{
	self notify("Notetrack_Timeout");
	self endon("Notetrack_Timeout");
	param_01 = max(0.05,param_01);
	wait(param_01);
	if(isdefined(param_02))
	{
		self notify(param_00,param_02);
		return;
	}

	self notify(param_00,"end");
}

//Function Number: 7
playanimnatratefortime(param_00,param_01,param_02,param_03)
{
	set_anim_state(param_00,param_01,param_02);
	wait(param_03);
}

//Function Number: 8
loop_anim_state_randomize(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = randomint(self getanimentrycount(param_00));
		set_anim_state(param_00,var_03,param_01);
		var_04 = getanimlength(self getanimentry(param_00,var_03)) * 1 / param_01;
		waituntilnotetrack_safe(param_02,"end",var_04);
	}
}

//Function Number: 9
set_anim_state(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self setanimstate(param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		self setanimstate(param_00,param_01);
		return;
	}

	self setanimstate(param_00);
}

//Function Number: 10
getangleindexvariable(param_00,param_01)
{
	if(param_01 <= 1)
	{
		return 0;
	}

	var_02 = 360 / param_01 - 1;
	var_03 = var_02 * 0.2222222;
	if(param_00 < 0)
	{
		return int(ceil(180 + param_00 - var_03 / var_02));
	}

	return int(floor(180 + param_00 + var_03 / var_02));
}

//Function Number: 11
getanimscalefactors(param_00,param_01,param_02)
{
	var_03 = length2d(param_00);
	var_04 = param_00[2];
	var_05 = length2d(param_01);
	var_06 = param_01[2];
	var_07 = 1;
	var_08 = 1;
	if(isdefined(param_02) && param_02)
	{
		var_09 = (param_01[0],param_01[1],0);
		var_0A = vectornormalize(var_09);
		if(vectordot(var_0A,param_00) < 0)
		{
			var_07 = 0;
		}
		else if(var_05 > 0)
		{
			var_07 = var_03 / var_05;
		}
	}
	else if(var_05 > 0)
	{
		var_07 = var_03 / var_05;
	}

	if(abs(var_06) > 0.001 && var_06 * var_04 >= 0)
	{
		var_08 = var_04 / var_06;
	}

	var_0B = spawnstruct();
	var_0B.xy = var_07;
	var_0B.z = var_08;
	return var_0B;
}

//Function Number: 12
onenteranimstate(param_00,param_01)
{
	self notify("killanimscript");
	if(isdefined(self.animcbs.onexit[param_00]))
	{
		self [[ self.animcbs.onexit[param_00] ]]();
	}

	exitaistate(param_00);
	if(!isdefined(self.animcbs.onenter[param_01]))
	{
		return;
	}

	if(param_00 == param_01 && param_01 != "traverse")
	{
		return;
	}

	self.aistate = param_01;
	enteraistate(param_01);
	self [[ self.animcbs.onenter[param_01] ]]();
}

//Function Number: 13
enteraistate(param_00)
{
	self.aistate = param_00;
	switch(param_00)
	{
		case "idle":
			self.bhasbadpath = 0;
			break;

		default:
			break;
	}
}

//Function Number: 14
exitaistate(param_00)
{
	switch(param_00)
	{
		default:
			break;
	}
}

//Function Number: 15
isstatelocked()
{
	return self.statelocked;
}

//Function Number: 16
setstatelocked(param_00,param_01)
{
	self.statelocked = param_00;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_scriptedagents.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 387 ms
 * Timestamp: 10/27/2023 1:41:01 AM
*******************************************************************/

//Function Number: 1
onenterstate(param_00,param_01)
{
	if(isdefined(self.onenteranimstate))
	{
		self [[ self.onenteranimstate ]](param_00,param_01);
	}
}

//Function Number: 2
ondeactivate()
{
	self notify("killanimscript");
}

//Function Number: 3
playanimuntilnotetrack(param_00,param_01,param_02,param_03)
{
	playanimnuntilnotetrack(param_00,0,param_01,param_02,param_03);
}

//Function Number: 4
playanimnuntilnotetrack(param_00,param_01,param_02,param_03,param_04)
{
	self setanimstate(param_00,param_01);
	if(!isdefined(param_03))
	{
		param_03 = "end";
	}

	waituntilnotetrack(param_02,param_03,param_00,param_01,param_04);
}

//Function Number: 5
playanimnatrateuntilnotetrack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self setanimstate(param_00,param_01,param_02);
	if(!isdefined(param_04))
	{
		param_04 = "end";
	}

	waituntilnotetrack(param_03,param_04,param_00,param_01,param_05);
}

//Function Number: 6
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

//Function Number: 7
playanimfortime(param_00,param_01)
{
	playanimnfortime(param_00,0,param_01);
}

//Function Number: 8
playanimnfortime(param_00,param_01,param_02)
{
	self setanimstate(param_00,param_01);
	wait(param_02);
}

//Function Number: 9
playanimnatratefortime(param_00,param_01,param_02,param_03)
{
	self setanimstate(param_00,param_01,param_02);
	wait(param_03);
}

//Function Number: 10
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

//Function Number: 11
getangleindex(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(param_00 < 0)
	{
		return int(ceil(180 + param_00 - param_01 / 45));
	}

	return int(floor(180 + param_00 + param_01 / 45));
}

//Function Number: 12
droppostoground(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 18;
	}

	var_02 = param_00 + (0,0,param_01);
	var_03 = param_00 + (0,0,param_01 * -1);
	var_04 = self aiphysicstrace(var_02,var_03,self.radius,self.height,1);
	if(abs(var_04[2] - var_02[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_04[2] - var_03[2]) < 0.1)
	{
		return undefined;
	}

	return var_04;
}

//Function Number: 13
canmovepointtopoint(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	if(!isdefined(param_03))
	{
		param_03 = self.radius;
	}

	var_04 = (0,0,1) * param_02;
	var_05 = param_00 + var_04;
	var_06 = param_01 + var_04;
	return self aiphysicstracepassed(var_05,var_06,param_03,self.height - param_02,1);
}

//Function Number: 14
getvalidpointtopointmovelocation(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = (0,0,1) * param_02;
	var_04 = param_00 + var_03;
	var_05 = param_01 + var_03;
	return self aiphysicstrace(var_04,var_05,self.radius + 4,self.height - param_02,1);
}

//Function Number: 15
getsafeanimmovedeltapercentage(param_00)
{
	var_01 = getmovedelta(param_00);
	var_02 = self localtoworldcoords(var_01);
	var_03 = getvalidpointtopointmovelocation(self.origin,var_02);
	var_04 = distance(self.origin,var_03);
	var_05 = distance(self.origin,var_02);
	return min(1,var_04 / var_05);
}

//Function Number: 16
safelyplayanimuntilnotetrack(param_00,param_01,param_02,param_03)
{
	var_04 = getrandomanimentry(param_00);
	safelyplayanimnuntilnotetrack(param_00,var_04,param_01,param_02,param_03);
}

//Function Number: 17
safelyplayanimatrateuntilnotetrack(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getrandomanimentry(param_00);
	safelyplayanimnatrateuntilnotetrack(param_00,var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 18
safelyplayanimnatrateuntilnotetrack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self setanimstate(param_00,param_01,param_02);
	safelyplayanimnuntilnotetrack(param_00,param_01,param_03,param_04,param_05);
}

//Function Number: 19
safelyplayanimnuntilnotetrack(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self getanimentry(param_00,param_01);
	var_06 = getsafeanimmovedeltapercentage(var_05);
	self scragentsetanimscale(var_06,1);
	playanimnuntilnotetrack(param_00,param_01,param_02,param_03,param_04);
	self scragentsetanimscale(1,1);
}

//Function Number: 20
getrandomanimentry(param_00)
{
	var_01 = self getanimentrycount(param_00);
	return randomint(var_01);
}

//Function Number: 21
getangleindexfromselfyaw(param_00)
{
	var_01 = vectortoangles(param_00);
	var_02 = angleclamp180(var_01[1] - self.angles[1]);
	return getangleindex(var_02);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\stairs_utility.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 601 ms
 * Timestamp: 10/27/2023 2:44:49 AM
*******************************************************************/

//Function Number: 1
getprecisegroundnear(param_00)
{
	var_01 = param_00 + (0,0,36);
	var_02 = param_00 - (0,0,36);
	return getrayfromtrace(var_01,var_02);
}

//Function Number: 2
getrayfromtrace(param_00,param_01)
{
	var_02 = self aiphysicstrace(param_00,param_01,0,0,1,1);
	if(var_02["fraction"] < 1)
	{
		var_03 = vectorlerp(param_00,param_01,var_02["fraction"]);
		var_04["pos"] = var_03;
		var_04["normal"] = var_02["normal"];
	}
	else
	{
		var_04 = undefined;
	}

	return var_04;
}

//Function Number: 3
distancefromplanetopoint(param_00,param_01,param_02)
{
	return vectordot(param_00,param_02) + param_01;
}

//Function Number: 4
sweptspherecast(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = distancefromplanetopoint(param_03,param_04,param_00);
	var_06 = distancefromplanetopoint(param_03,param_04,param_01);
	var_07 = param_00;
	if(abs(var_05) <= param_02)
	{
		return var_07;
	}

	if(var_05 > param_02 && var_06 < param_02)
	{
		var_08 = var_05 - param_02 / var_05 - var_06;
		var_07 = 1 - var_08 * param_00 + var_08 * param_01;
		return var_07;
	}

	return param_02;
}

//Function Number: 5
findstaircorner(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = (0,0,param_06);
	var_08 = param_04[2] - param_02[2];
	var_09 = (param_00[0],param_00[1],0);
	var_0A = vectornormalize(var_09);
	var_0B = vectordot(param_03,var_0A);
	if(var_0B > 0)
	{
		var_0A = var_0A * -1;
	}

	if(var_08 < 0)
	{
		var_07 = var_07 + param_04;
	}
	else
	{
		var_07 = var_07 + param_02;
		var_07 = var_07 + (0,0,var_08);
	}

	var_0C["position"] = var_07;
	var_0D = var_07;
	var_07 = var_07 - var_0A * param_06;
	var_0A = var_0A * 2 * param_01 + param_06;
	var_0D = var_0D + var_0A;
	var_0E = -1 * vectordot(param_03,param_02);
	var_0C["position"] = sweptspherecast(var_07,var_0D,param_06,param_03,var_0E);
	var_0C["position"] = var_0C["position"] - (0,0,param_06);
	var_0C["stairEdgeDirection"] = vectorcross(param_03,param_05);
	var_0C["stairEdgeDirection"] = vectornormalize(var_0C["stairEdgeDirection"]);
	return var_0C;
}

//Function Number: 6
getcurrentanimdisplacement(param_00,param_01,param_02)
{
	var_03 = getanimlength(param_00);
	var_04 = self getanimtime(param_00);
	var_05 = var_04 * var_03;
	var_06 = var_05 + param_02;
	if(param_01)
	{
		var_07 = var_06 / var_03;
		if(var_06 < var_03)
		{
			var_08 = getmovedelta(param_00,var_04,var_07);
		}
		else
		{
			var_09 = var_07 - var_04;
			var_0A = var_09 / var_03;
			var_08 = getmovedelta(param_00,var_04,1);
			var_08 = var_08 + getmovedelta(param_00,0,var_0A);
		}
	}
	else
	{
		var_08 = min(var_08,var_05);
		var_07 = var_08 / var_05;
		var_08 = getmovedelta(param_01,var_05,var_08);
	}

	return var_08[0] * self.moveplaybackrate;
}

//Function Number: 7
getstairanimtranslationtoedge(param_00)
{
	var_01 = getnotetracktimes(param_00,"stair_edge");
	return getmovedelta(param_00,0,var_01[0]);
}

//Function Number: 8
distancebetweentwolines(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 - param_02;
	var_05 = vectordot(param_01,param_01);
	var_06 = vectordot(param_01,param_03);
	var_07 = vectordot(param_03,param_03);
	var_08 = vectordot(param_01,var_04);
	var_09 = vectordot(param_03,var_04);
	var_0A = var_05 * var_07 - var_06 * var_06;
	if(var_0A < 1E-05)
	{
		var_0B = 0;
		if(var_06 > var_07)
		{
			var_0C = var_08 / var_06;
		}
		else
		{
			var_0C = var_0A / var_08;
		}
	}
	else
	{
		var_0B = var_08 * var_0B - var_09 * var_0A;
		var_0C = var_06 * var_0A - var_07 * var_09;
	}

	var_0D = var_04 + var_0B * param_01 - var_0C * param_03;
	var_0E["distance"] = length(var_0D);
	var_0E["intersectionLine1"] = param_00 + var_0B * param_01;
	var_0E["intersectionLine2"] = param_02 + var_0C * param_03;
	return var_0E;
}

//Function Number: 9
stairupdatepos(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("stair_transition");
	self endon("death");
	self endon("stair_transition_to_transition");
	self endon("killanimscript");
	var_06 = param_02["wantedPos"];
	var_07 = param_02["stairEdgeDir"];
	var_08 = length(param_02["trans"]);
	if(isdefined(param_02["startTime"]))
	{
		var_09 = param_02["startTime"];
		var_0A = getmovedelta(param_00,0,var_09);
		var_08 = var_08 - length(var_0A);
	}
	else
	{
		var_09 = 0;
	}

	for(;;)
	{
		if(param_04)
		{
			if(lengthsquared(var_07) <= 0.001)
			{
				if(!isdefined(self.stairstransition["wantedPos"]))
				{
					self.stairstransition["wantedPos"] = var_06;
				}
			}
			else
			{
				var_0B = vectornormalize((self.lookaheaddir[0],self.lookaheaddir[1],0));
				var_0C = distancebetweentwolines(self.origin,var_0B,var_06,var_07);
				self.stairstransition["wantedPos"] = var_0C["intersectionLine2"];
			}
		}

		var_0D = var_09 + param_05;
		if(var_0D >= param_03)
		{
			var_0E = anglestoforward(self.angles);
			var_0F = getmovedelta(param_00,param_03,var_0D);
			var_10 = var_0F[0] * var_0E + (0,0,var_0F[2]);
			var_11 = self.stairstransition["wantedPos"] + var_10;
			self. = length(var_11 - self.origin);
			return;
		}

		var_10 = self.stairstransition["wantedPos"] - self.origin;
		var_11 = 0.001;
		if(vectordot(var_10,self.lookaheaddir) > var_11)
		{
			var_14 = getmovedelta(param_04,var_0E,var_0F);
			var_15 = length(var_14) / var_13;
			var_16 = length(self.stairstransition["wantedPos"] - param_05);
			var_17 = length(var_10);
			var_18 = getmovedelta(param_04,var_0E,var_07);
			var_19 = length(var_18);
			var_1A = var_19 / var_13;
			var_1B = var_17 / var_16;
			var_1C = var_1A / var_1B * var_16;
			var_1D = var_15 * var_1C;
			self. = min(var_1D,var_17);
		}
		else
		{
			self. = 0;
		}

		wait 0.05;
		var_0E = self getanimtime(param_04);
		if(var_0E == 0)
		{
			return;
		}
	}
}

//Function Number: 10
poststairsedge_restoreanimrate(param_00)
{
	self.moveplaybackrate = self.stairs_old_moveplaybackrate;
	self.stairs_old_moveplaybackrate = undefined;
	self setanimrate(param_00,self.moveplaybackrate);
}

//Function Number: 11
poststairsedge_cleanup(param_00)
{
	self endon("death");
	self endon("stair_transition_to_transition");
	self endon("stair_transition");
	self waittill("killanimscript");
	poststairsedge_restoreanimrate(param_00);
	self.isinstairstransition = undefined;
}

//Function Number: 12
waitforstairedge(param_00,param_01)
{
	self endon("death");
	self endon("stair_transition_to_transition");
	self endon("killanimscript");
	thread poststairsedge_cleanup(param_00);
	var_02 = 0;
	for(;;)
	{
		wait 0.05;
		var_03 = self getanimtime(param_00);
		if(var_03 == 0)
		{
			var_02 = 1;
			break;
		}

		if(var_03 >= param_01)
		{
			break;
		}
	}

	poststairsedge_restoreanimrate(param_00);
	self notify("stair_transition");
	if(var_02)
	{
		self.isinstairstransition = undefined;
		return;
	}

	if(!isdefined(self.stairstransition))
	{
		return;
	}

	var_04 = self.stairstransition["wantedPos"];
	if(isdefined(var_04))
	{
		var_05 = anglestoforward(self.angles);
		var_06 = getmovedelta(param_00,param_01,var_03);
		var_07 = var_06[0] * var_05 + (0,0,var_06[2]);
		var_08 = var_04 + var_07;
		if(lengthsquared(self.origin - var_08) < squared(20))
		{
			var_09 = self.origin + (0,0,15);
			var_0A = var_08 + (0,0,15);
			var_0B = self aiphysicstrace(var_09,var_0A,15,30,0,1);
			if(var_0B["fraction"] == 1)
			{
				self forceteleport(var_08,self.angles,100);
			}
		}
	}

	var_0C = getanimlength(param_00);
	var_0D = var_0C * 1 - var_03;
	wait(var_0D);
	self.isinstairstransition = undefined;
}

//Function Number: 13
gettracecontactpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 * 0.5;
	var_06 = param_00 + (0,0,var_05);
	var_07 = param_01 + (0,0,var_05);
	var_08 = var_07 - var_06;
	var_09 = var_05 - param_03;
	var_0A = vectornormalize(var_08);
	var_0A = var_0A * var_09;
	var_0B = var_08 * param_02["fraction"] + var_06;
	var_0B = var_0B + var_0A;
	var_0B = var_0B - param_02["normal"] * param_03;
	return var_0B;
}

//Function Number: 14
getstairstransition(param_00,param_01,param_02)
{
	if(!isdefined(self.detectedstairstransitiontime) || self.detectedstairstransitiontime != gettime())
	{
		if(!checkshouldstairstransition(param_00,param_01,param_02))
		{
			return undefined;
		}
	}

	return self.detectedstairstransition;
}

//Function Number: 15
preparedetectedstairstransition()
{
	self.stairstransition = self.detectedstairstransition;
	if(isdefined(self.stairs_old_moveplaybackrate))
	{
		self notify("stair_transition_to_transition");
	}
	else
	{
		self.stairs_old_moveplaybackrate = self.stairstransition["stairs_old_moveplaybackrate"];
	}

	self.moveplaybackrate = clamp(self.stairstransition["moveplaybackrate"],1,2);
}

//Function Number: 16
getanimstarttime(param_00,param_01,param_02)
{
	var_03 = 0.01;
	var_04 = length(param_01);
	var_05 = getnotetracktimes(self.stairstransition["transitionAnim"],"stair_edge");
	if(var_04 < 1)
	{
		return var_05[0];
	}

	var_06 = length(param_02);
	var_07 = length(param_01) / var_06;
	if(var_07 > 1)
	{
		return 0;
	}

	var_08 = 1 - var_07;
	var_09 = var_08 * var_05[0];
	var_0A = 0;
	var_0B = var_05[0];
	for(;;)
	{
		var_0C = getmovedelta(param_00,0,var_09);
		var_0D = length(var_0C) / var_06;
		if(var_0D < var_08 && var_0D + var_03 > var_08)
		{
			return var_09;
		}

		if(var_0D < var_08)
		{
			var_0A = var_09;
		}
		else
		{
			var_0B = var_09;
		}

		var_09 = var_0B + var_0A * 0.5;
	}
}

//Function Number: 17
checktransition_up_in(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00["stairs"]))
	{
		var_06 = getstairtypefromnormal(param_00["normal"]);
		var_07 = animscripts\run::getstairstransitionanim(param_05,"up",var_06);
		var_08 = getstairanimtranslationtoedge(var_07);
		var_09 = gettracecontactpos(param_02,param_04,param_00,15,48);
		var_0A = getprecisegroundnear(var_09);
		if(!isdefined(var_0A))
		{
			return undefined;
		}

		if(vectordot(var_0A["normal"],param_03) > 0)
		{
			return undefined;
		}

		var_09 = var_0A["pos"];
		var_0B = findstaircorner(self.lookaheaddir,self.lookaheaddist,var_09,param_00["normal"],self.origin,(0,0,1),15);
		var_0C["wantedPos"] = var_0B["position"];
		var_0C["stairEdgeDir"] = var_0B["stairEdgeDirection"];
		var_0C["inStairTransitionIn"] = 1;
		var_0C["transitionAnim"] = var_07;
		var_0C["trans"] = var_08;
		return var_0C;
	}

	if(var_08 < self.lookaheaddist)
	{
		return undefined;
	}

	if(var_08 - self.lookaheaddist > 15)
	{
		var_0B = var_0B - var_0A * 15;
	}
	else
	{
		var_0D = var_08 + self.lookaheaddist * 0.5;
		var_0B = var_0B - var_0A * var_0D;
	}

	return checktransition_down_in(var_08,var_0B,var_0A,var_0C);
}

//Function Number: 18
checktransition_down_in(param_00,param_01,param_02,param_03)
{
	var_04 = 18;
	var_05 = param_00 * 1.333;
	var_06 = param_01 + (0,0,var_04 + 15);
	var_07 = param_01 - (0,0,var_05 + 15);
	var_08 = self aiphysicstrace(var_06,var_07,0,48,1,1);
	if(var_08["fraction"] >= 1)
	{
		return undefined;
	}

	if(!isdefined(var_08["stairs"]))
	{
		return undefined;
	}

	if(var_08["normal"][2] > 0.9962)
	{
		var_06 = var_06 + param_02;
		var_07 = var_07 + param_02;
		var_08 = self aiphysicstrace(var_06,var_07,0,48,1,1);
		if(var_08["fraction"] >= 1)
		{
			return undefined;
		}

		if(!isdefined(var_08["stairs"]))
		{
			return undefined;
		}

		if(var_08["normal"][2] > 0.9962)
		{
			var_09 = gettracecontactpos(var_06,var_07,var_08,0,48);
			return undefined;
		}
	}

	var_0A = var_09["normal"];
	if(vectordot(var_0A,param_03) < 0)
	{
		return undefined;
	}

	var_0B = getstairtypefromnormal(var_0A);
	var_0C = animscripts\run::getstairstransitionanim(var_04,"down",var_0B);
	var_0D = getstairanimtranslationtoedge(var_0C);
	var_09 = gettracecontactpos(var_07,var_08,var_09,0,48);
	var_0E = findstaircorner(self.lookaheaddir,self.lookaheaddist,var_0D,var_09,self.origin,(0,0,1),15);
	var_0F["wantedPos"] = var_0E["position"];
	var_0F["stairEdgeDir"] = var_0E["stairEdgeDirection"];
	var_0F["inStairTransitionIn"] = 1;
	var_0F["transitionAnim"] = var_0B;
	var_0F["trans"] = var_0C;
	if(getdvarint("ai_useStairsTraceErrorOffset",1))
	{
		var_10 = (self.lookaheaddir[0],self.lookaheaddir[1],0);
		var_10 = vectornormalize(var_10);
		if(vectordot(var_09,var_10) > 0)
		{
			var_11 = (var_09[0],var_09[1],0);
			var_11 = vectornormalize(var_11);
			var_11 = common_scripts\utility::vectorscale(var_11,0.5);
			var_0F["wantedPos"] = var_0F["wantedPos"] + var_11;
		}
	}

	return var_0F;
}

//Function Number: 19
checktransition_up_out(param_00)
{
	var_01 = getprecisegroundnear(self.origin);
	var_02 = getstairtypefromtraceresult(var_01,self.origin);
	var_03 = animscripts\run::getstairstransitionanim("up","none",var_02);
	var_04 = getstairanimtranslationtoedge(var_03);
	var_05 = var_04[0];
	var_06 = 21;
	var_07 = var_05 * 1.333;
	var_08 = param_00 * 15;
	var_09 = self.origin + var_05 * param_00 + var_08;
	var_0A = var_09 + (0,0,var_07 + var_06);
	var_0B = var_09 - (0,0,var_06);
	var_0C = self aiphysicstrace(var_0A,var_0B,0,0,1,1);
	if(var_0C["fraction"] <= 0 || var_0C["fraction"] >= 1)
	{
		return undefined;
	}

	if(isdefined(var_0C["stairs"]) && abs(var_0C["normal"][2]) < 0.9962)
	{
		return undefined;
	}

	var_0D = vectorlerp(var_0A,var_0B,var_0C["fraction"]);
	if(var_01["normal"][2] > 0.9962)
	{
		var_01 = getprecisegroundnear(self.origin - param_00);
		if(var_01["normal"][2] > 0.9962)
		{
			return undefined;
		}
	}

	if(vectordot(var_01["normal"],param_00) > 0)
	{
		return undefined;
	}

	var_0E = findstaircorner(self.lookaheaddir,self.lookaheaddist,var_01["pos"],var_01["normal"],var_0D,(0,0,1),15);
	var_0F["wantedPos"] = var_0E["position"];
	var_0F["stairEdgeDir"] = var_0E["stairEdgeDirection"];
	var_0F["transitionAnim"] = var_03;
	var_0F["trans"] = var_04;
	return var_0F;
}

//Function Number: 20
checktransition_down_out(param_00)
{
	var_01 = getprecisegroundnear(self.origin);
	var_02 = getstairtypefromtraceresult(var_01,self.origin);
	var_03 = animscripts\run::getstairstransitionanim("down","none",var_02);
	var_04 = getstairanimtranslationtoedge(var_03);
	var_05 = var_04[0];
	var_06 = 18;
	var_07 = 22;
	var_08 = var_05 * 1.333;
	var_09 = self.origin + var_05 * param_00;
	var_0A = var_09;
	var_0B = var_09 - (0,0,var_08 + var_07);
	var_0C = self aiphysicstrace(var_0A,var_0B,0,0,1,1);
	if(var_0C["fraction"] <= 0 || var_0C["fraction"] >= 1)
	{
		return undefined;
	}

	if(isdefined(var_0C["stairs"]))
	{
		return undefined;
	}

	var_0D = vectorlerp(var_0A,var_0B,var_0C["fraction"]);
	if(var_01["normal"][2] >= 0.9962)
	{
		var_01 = getprecisegroundnear(self.origin - param_00);
		if(var_01["normal"][2] >= 0.9962)
		{
			return undefined;
		}
	}

	if(vectordot(var_01["normal"],param_00) < 0)
	{
		return undefined;
	}

	var_0E = findstaircorner(self.lookaheaddir,self.lookaheaddist,var_01["pos"],var_01["normal"],var_0D,(0,0,1),15);
	var_0F["wantedPos"] = var_0E["position"];
	var_0F["stairEdgeDir"] = var_0E["stairEdgeDirection"];
	var_0F["transitionAnim"] = var_03;
	var_0F["trans"] = var_04;
	return var_0F;
}

//Function Number: 21
getexpectedstairstransition(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(!isdefined(self.lookaheaddir))
	{
		return undefined;
	}

	var_05 = getanimationcontext(param_00);
	var_06 = vectornormalize((self.lookaheaddir[0],self.lookaheaddir[1],0));
	var_07 = !isdefined(param_03) || param_03 == "inOnly";
	var_08 = !isdefined(param_03) || param_03 == "outOnly";
	if(self.stairsstate == "none" && var_07)
	{
		var_09 = getcurrentanimdisplacement(param_00,param_01,param_02);
		var_0A = self.origin + (0,0,1);
		var_0B = var_0A + var_09 * var_06;
		var_0C = self aiphysicstrace(var_0A,var_0B,15,48,1,1);
		if(var_0C["fraction"] < 1)
		{
			var_04 = checktransition_up_in(var_0C,var_09,var_0A,var_06,var_0B,var_05);
		}
		else
		{
			var_04 = checktransition_down_in(var_09,var_0B,var_06,var_05);
		}
	}
	else if(var_08)
	{
		if(self.stairsstate == "up")
		{
			var_04 = checktransition_up_out(var_06);
		}
		else if(self.stairsstate == "down")
		{
			var_04 = checktransition_down_out(var_06);
		}
	}

	if(isdefined(var_04))
	{
		var_0D = length(var_04["trans"]);
		if(var_0D <= 0)
		{
			return undefined;
		}

		var_0E = var_04["wantedPos"] - self.origin;
		var_04["stairs_old_moveplaybackrate"] = self.moveplaybackrate;
		var_04["moveplaybackrate"] = length(var_0E) / var_0D;
		var_04["currentContext"] = var_05;
		var_04["distanceToCorner"] = var_0E;
		return var_04;
	}

	return undefined;
}

//Function Number: 22
getanimationcontext(param_00)
{
	var_01 = animscripts\move::getturnaniminfo();
	if(param_00 == var_01["animArray"][2])
	{
		return "turn_L90";
	}
	else if(param_00 == var_01["animArray"][6])
	{
		return "turn_R90";
	}

	return "none";
}

//Function Number: 23
checkshouldstairstransition(param_00,param_01,param_02,param_03)
{
	if(!using_h1_stairs_system())
	{
		return 0;
	}

	var_04 = getexpectedstairstransition(param_00,param_01,param_02,param_03);
	if(!isdefined(var_04))
	{
		return 0;
	}

	self.detectedstairstransition = var_04;
	self.detectedstairstransitiontime = gettime();
	return 1;
}

//Function Number: 24
threadcheckstairstransition(param_00,param_01,param_02,param_03,param_04)
{
	if(!using_h1_stairs_system())
	{
		return;
	}

	self endon("death");
	self endon("killThreadCheckStairsTransition");
	for(;;)
	{
		if(checkshouldstairstransition(param_00,param_01,param_02,param_04))
		{
			if(isdefined(param_03))
			{
				[[ param_03 ]]();
			}

			self notify("should_stairs_transition");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 25
stairstransitionpendingsince(param_00)
{
	if(!isdefined(self.detectedstairstransitiontime))
	{
		return 0;
	}

	return gettime() - self.detectedstairstransitiontime <= param_00;
}

//Function Number: 26
isinstairstransition()
{
	return isdefined(self.isinstairstransition);
}

//Function Number: 27
shouldstairstransitionnow()
{
	var_00 = animscripts\move::getexpectedcurrentmoveanim();
	if(!isdefined(var_00["anim"]))
	{
		return 0;
	}

	var_01 = getanimlength(var_00["anim"]);
	var_02 = self getanimtime(var_00["anim"]);
	var_03 = var_02 * var_01;
	var_03 = var_03 - floor(var_03 / var_00["updateTime"]) * var_00["updateTime"];
	var_04 = var_00["updateTime"] - var_03;
	return checkshouldstairstransition(var_00["anim"],1,var_04);
}

//Function Number: 28
lookaheadhitstairslistener()
{
	self endon("death");
	self endon("killanimscript");
	for(;;)
	{
		self waittill("lookahead_hit_stairs");
		if(isinstairstransition())
		{
			continue;
		}

		if(self.stairsstate != "none")
		{
			continue;
		}

		if(shouldstairstransitionnow())
		{
			self notify("move_loop_restart");
			animscripts\combat_utility::endfireandanimidlethread();
		}
	}
}

//Function Number: 29
getstairtransitionfinishedthisframe()
{
	if(isdefined(self.lastfinishedstairtransitiontime) && self.lastfinishedstairtransitiontime == gettime())
	{
		return self.lastfinishedstairtransitiontype;
	}

	return "none";
}

//Function Number: 30
using_h1_stairs_system()
{
	return !isdefined(self.disablestairsanims) || !self.disablestairsanims;
}

//Function Number: 31
isonstairs()
{
	return self.stairsstate != "none" && using_h1_stairs_system();
}

//Function Number: 32
getstairtypefromtraceresult(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return getstairtypefromnormal((0,0,1));
	}

	return getstairtypefromnormal(param_00["normal"]);
}

//Function Number: 33
getstairtypefromnormal(param_00)
{
	if(param_00[2] < 0.65)
	{
		return "6x8";
	}

	if(param_00[2] < 0.75)
	{
		return "8x8";
	}

	if(param_00[2] < 0.86)
	{
		return "12x8";
	}

	if(level.script == "scoutsniper")
	{
		return "12x6";
	}

	return "16x8";
}

//Function Number: 34
getstairsanimnameatgroundpos()
{
	var_00 = getprecisegroundnear(self.origin);
	var_01 = getstairtypefromtraceresult(var_00,self.origin);
	return "stairs_" + self.stairsstate + "_" + var_01;
}
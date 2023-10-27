/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_move.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 433 ms
 * Timestamp: 10/27/2023 1:16:38 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	self.blockgoalpos = 0;
	self scragentsetphysicsmode("gravity");
	func_7AE3();
	continuemovement();
}

//Function Number: 2
end_script()
{
	self.blockgoalpos = 0;
	func_199F(undefined);
	self scragentsetanimscale(1,1);
}

//Function Number: 3
setupmovement()
{
	thread func_8AF1();
	thread func_8AF3();
	thread func_8AF8();
}

//Function Number: 4
continuemovement()
{
	setupmovement();
	self scragentsetanimmode("code_move");
	self scragentsetorientmode("face motion");
	self scragentsetanimscale(1,1);
	func_7075(self.movemode);
}

//Function Number: 5
func_7075(param_00)
{
	self setanimstate(param_00);
}

//Function Number: 6
func_8AF1()
{
	self endon("dogmove_endwait_runwalk");
	var_00 = self.movemode;
	for(;;)
	{
		if(var_00 != self.movemode)
		{
			func_7075(self.movemode);
			var_00 = self.movemode;
		}

		wait(0.1);
	}
}

//Function Number: 7
func_2A0B(param_00)
{
	var_01 = vectortoangles(param_00);
	var_02 = angleclamp180(var_01[1] - self.angles[1]);
	var_03 = maps/mp/agents/_scriptedagents::getangleindex(var_02);
	if(var_03 == 4)
	{
		continuemovement();
	}

	var_04 = "sharp_turn";
	var_05 = self getanimentry(var_04,var_03);
	var_06 = getangledelta(var_05);
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",(0,angleclamp180(var_01[1] - var_06),0));
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_04,var_03,"sharp_turn");
	continuemovement();
}

//Function Number: 8
func_8AF3()
{
	self endon("dogmove_endwait_sharpturn");
	self waittill("path_dir_change",var_00);
	func_199F("sharpturn");
	func_2A0B(var_00);
}

//Function Number: 9
func_8AF8()
{
	self endon("dogmove_endwait_stop");
	self waittill("stop_soon");
	if(isdefined(self.barrivalsenabled) && !self.barrivalsenabled)
	{
		thread func_8AF8();
	}

	var_00 = func_3C13();
	var_01 = self getanimentry(var_00.state,var_00.index);
	var_02 = getmovedelta(var_01);
	var_03 = getangledelta(var_01);
	var_04 = self getpathgoalpos();
	var_05 = var_04 - self.origin;
	if(length(var_05) + 12 < length(var_02))
	{
		thread func_8AF8();
	}

	var_06 = getstopdata();
	var_07 = calcanimstartpos(var_06.pos,var_06.angles[1],var_02,var_03);
	var_08 = maps/mp/agents/_scriptedagents::droppostoground(var_07);
	if(!isdefined(var_08))
	{
		thread func_8AF8();
	}

	if(!maps/mp/agents/_scriptedagents::canmovepointtopoint(var_06.pos,var_08))
	{
		thread func_8AF8();
	}

	func_199F("stop");
	thread func_8AEC();
	thread func_8AF5();
	if(distancesquared(var_07,self.origin) > 4)
	{
		self scragentsetwaypoint(var_07);
		thread func_8AD9();
		self waittill("waypoint_reached");
		self notify("dogmove_endwait_blockedwhilestopping");
	}

	var_09 = var_04 - self.origin;
	var_0A = vectortoangles(var_09);
	var_0B = (0,var_0A[1] - var_03,0);
	var_0C = maps/mp/agents/_scriptedagents::getanimscalefactors(var_04 - self.origin,var_02);
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",var_0B,(0,var_0A[1],0));
	self scragentsetanimscale(var_0C.xy,var_0C.z);
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_00.state,var_00.index,"move_stop");
	self scragentsetgoalpos(self.origin);
}

//Function Number: 10
func_8AEC()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_pathsetwhilestopping");
	var_00 = self scragentgetgoalpos();
	self waittill("path_set");
	var_01 = self scragentgetgoalpos();
	if(distancesquared(var_00,var_01) < 1)
	{
		thread func_8AEC();
	}

	self notify("dogmove_endwait_stop");
	self notify("dogmove_endwait_sharpturnwhilestopping");
	continuemovement();
}

//Function Number: 11
func_8AF5()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_sharpturnwhilestopping");
	self waittill("path_dir_change",var_00);
	self notify("dogmove_endwait_pathsetwhilestopping");
	self notify("dogmove_endwait_stop");
	func_2A0B(var_00);
}

//Function Number: 12
func_8AD9()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_blockedwhilestopping");
	self waittill("path_blocked");
	self notify("dogmove_endwait_stop");
	self scragentsetwaypoint(undefined);
}

//Function Number: 13
func_8AF9()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_stopearly");
	var_00 = self getanimentry("move_stop_4",0);
	var_01 = getmovedelta(var_00);
	var_02 = length(var_01);
	var_03 = self.preferredoffsetfromowner + var_02;
	var_04 = var_03 * var_03;
	if(distancesquared(self.origin,self.owner.origin) <= var_04)
	{
	}

	for(;;)
	{
		if(!isdefined(self.owner))
		{
			break;
		}

		if(distancesquared(self.origin,self.owner.origin) < var_04)
		{
			var_05 = self localtoworldcoords(var_01);
			self scragentsetgoalpos(var_05);
			break;
		}

		wait(0.1);
	}
}

//Function Number: 14
func_199F(param_00)
{
	var_01 = ["runwalk","sharpturn","stop","pathsetwhilestopping","blockedwhilestopping","sharpturnwhilestopping","stopearly"];
	var_02 = isdefined(param_00);
	foreach(var_04 in var_01)
	{
		if(var_02 && var_04 == param_00)
		{
			continue;
		}

		self notify("dogmove_endwait_" + var_04);
	}
}

//Function Number: 15
func_7AE3()
{
	var_00 = self getnegotiationstartnode();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin;
	}
	else
	{
		var_01 = self getpathgoalpos();
	}

	if(distancesquared(var_01,self.origin) < 10000)
	{
	}

	var_02 = self getlookaheaddir();
	var_03 = vectortoangles(var_02);
	var_04 = self getvelocity();
	if(length2dsquared(var_04) > 16)
	{
		var_04 = vectornormalize(var_04);
		if(vectordot(var_04,var_02) > 0.707)
		{
		}
	}

	var_05 = angleclamp180(var_03[1] - self.angles[1]);
	var_06 = maps/mp/agents/_scriptedagents::getangleindex(var_05);
	var_07 = self getanimentry("move_start",var_06);
	var_08 = getmovedelta(var_07);
	var_09 = rotatevector(var_08,self.angles) + self.origin;
	if(!maps/mp/agents/_scriptedagents::canmovepointtopoint(self.origin,var_09))
	{
	}

	var_0A = getangledelta3d(var_07);
	self scragentsetanimmode("anim deltas");
	if(3 <= var_06 && var_06 <= 5)
	{
		self scragentsetorientmode("face angle abs",(0,angleclamp180(var_03[1] - var_0A[1]),0));
	}
	else
	{
		self scragentsetorientmode("face angle abs",self.angles);
	}

	self.blockgoalpos = 1;
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack("move_start",var_06,"move_start");
	self.blockgoalpos = 0;
}

//Function Number: 16
getstopdata()
{
	var_00 = spawnstruct();
	if(isdefined(self.node))
	{
		var_00.pos = self.node.origin;
		var_00.angles = self.node.angles;
	}
	else
	{
		var_01 = self getpathgoalpos();
		var_00.pos = var_01;
		var_00.angles = vectortoangles(self getlookaheaddir());
	}

	return var_00;
}

//Function Number: 17
func_3C13(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node.angles[1] - self.angles[1];
		var_02 = maps/mp/agents/_scriptedagents::getangleindex(var_01);
	}
	else
	{
		var_02 = 4;
	}

	var_03 = spawnstruct();
	var_03.state = "move_stop";
	var_03.index = var_02;
	return var_03;
}

//Function Number: 18
calcanimstartpos(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_03;
	var_05 = (0,var_04,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = var_06 * param_02[0];
	var_09 = var_07 * param_02[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 19
func_289C()
{
	var_00 = clamp(self.leanamount / 25,-1,1);
	if(var_00 > 0)
	{
	}
}

//Function Number: 20
func_3F7E(param_00,param_01,param_02,param_03)
{
	if(1)
	{
		return 0;
	}

	switch(param_00)
	{
		case "footstep_back_right_large":
		case "footstep_back_left_large":
		case "footstep_front_right_large":
		case "footstep_front_left_large":
		case "footstep_back_right_small":
		case "footstep_back_left_small":
		case "footstep_front_right_small":
		case "footstep_front_left_small":
			var_04 = undefined;
			if(isdefined(self.surfacetype))
			{
				var_04 = self.surfacetype;
				self.lastsurfacetype = var_04;
			}
			else if(isdefined(self.lastsurfacetype))
			{
				var_04 = self.lastsurfacetype;
			}
			else
			{
				var_04 = "dirt";
			}
	
			if(var_04 != "dirt" && var_04 != "concrete" && var_04 != "wood" && var_04 != "metal")
			{
				var_04 = "dirt";
			}
	
			if(var_04 == "concrete")
			{
				var_04 = "cement";
			}
	
			if(self.aistate == "traverse")
			{
				var_05 = "land";
			}
			else if(self.movemode == "sprint")
			{
				var_05 = "sprint";
			}
			else if(self.movemode == "fastwalk")
			{
				var_05 = "walk";
			}
			else
			{
				var_05 = "run";
			}
	
			self playsoundonmovingent("dogstep_" + var_05 + "_" + var_04);
			if(issubstr(param_00,"front_left"))
			{
				var_06 = "anml_dog_mvmt_accent";
				var_07 = "anml_dog_mvmt_vest";
				if(var_05 == "walk")
				{
					var_08 = "_npc";
				}
				else
				{
					var_08 = "_run_npc";
				}
	
				self playsoundonmovingent(var_06 + var_08);
				self playsoundonmovingent(var_07 + var_08);
			}
			return 1;
	}

	return 0;
}

//Function Number: 21
func_2954(param_00)
{
	func_199F(undefined);
	self.blockgoalpos = 1;
	self.statelocked = 1;
	var_01 = angleclamp180(param_00 - self.angles[1]);
	if(var_01 > 0)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",self.angles);
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack("run_pain",var_02,"run_pain");
	self.blockgoalpos = 0;
	self.statelocked = 0;
	continuemovement();
}

//Function Number: 22
func_5906(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(self.statelocked)
	{
	}

	var_0A = vectortoangles(param_07);
	var_0B = var_0A[1] - 180;
	func_2954(var_0B);
}

//Function Number: 23
func_593B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(self.statelocked)
	{
	}

	func_2954(self.angles[1] + 180);
}
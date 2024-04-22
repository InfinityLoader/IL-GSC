/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_zombie_dog_move.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 292 ms
 * Timestamp: 4/22/2024 2:08:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self scragentsetphysicsmode("gravity");
	self.ismoving = 1;
	startmove();
	continuemovement();
}

//Function Number: 2
end_script()
{
	self.ismoving = undefined;
	cancelallbut(undefined);
	self scragentsetanimscale(1,1);
}

//Function Number: 3
setupmovement()
{
	thread maps\mp\agents\humanoid\_humanoid_move::waitforrunwalkchange();
	thread waitforturn();
	thread waitforstop();
}

//Function Number: 4
continuemovement()
{
	setupmovement();
	self scragentsetanimmode("code_move");
	self scragentsetorientmode("face motion");
	self scragentsetanimscale(1,1);
	setmoveanim(self.movemode);
}

//Function Number: 5
setmoveanim(param_00)
{
	self notify("zombiedogmove_endwait_setmoveanim");
	self endon("zombiedogmove_endwait_setmoveanim");
	self endon("killanimscript");
	var_01 = randomint(self getanimentrycount(param_00));
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_00,var_01,self.moveratescale);
}

//Function Number: 6
doturn(param_00)
{
	self notify("zombiedogmove_DoTurn");
	self endon("zombiedogmove_DoTurn");
	self endon("killanimscript");
	var_01 = "turn_" + self.movemode;
	var_02 = vectortoangles(param_00);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = self getanimentrycount(var_01);
	if(var_04 <= 0)
	{
		thread waitforturn();
		return;
	}

	var_05 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_03,var_04);
	if(var_05 == int(var_04 * 0.5))
	{
		thread waitforturn();
		return;
	}

	var_06 = self getanimentry(var_01,var_05);
	var_07 = getangledelta(var_06);
	var_08 = (0,angleclamp180(var_02[1] - var_07),0);
	if(!maps\mp\agents\humanoid\_humanoid_move::candoturnanim(var_06,var_08,var_05 == 3 || var_05 == 5,1))
	{
		thread waitforturn();
		return;
	}

	cancelallbut("turn");
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",var_08);
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_01,var_05,self.moveratescale,"turn");
	thread continuemovement();
}

//Function Number: 7
waitforturn()
{
	self notify("zombiedogmove_endwait_turn");
	self endon("zombiedogmove_endwait_turn");
	self waittill("path_dir_change",var_00);
	childthread doturn(var_00);
}

//Function Number: 8
waitforstop()
{
	self notify("zombiedogmove_endwait_stop");
	self endon("zombiedogmove_endwait_stop");
	self endon("killanimscript");
	self waittill("stop_soon");
	if(!maps\mp\zombies\_util::is_true(self.barrivalsenabled))
	{
		thread waitforstop();
		return;
	}

	var_00 = "stop_" + self.movemode;
	var_01 = self getanimentrycount(var_00);
	if(var_01 <= 0)
	{
		thread waitforstop();
		return;
	}

	var_02 = 0;
	if(isdefined(self.node))
	{
		var_02 = self.node.angles[1] - self.angles[1];
	}

	var_03 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_02,var_01);
	var_04 = self getanimentry(var_00,var_03);
	var_05 = getmovedelta(var_04);
	var_06 = getangledelta(var_04);
	var_07 = self getpathgoalpos();
	var_08 = var_07 - self.origin;
	if(length(var_08) + 12 < length(var_05))
	{
		thread waitforstop();
		return;
	}

	var_09 = getstopdata();
	var_0A = calcanimstartpos(var_09.pos,var_09.angles[1],var_05,var_06);
	var_0B = maps\mp\zombies\_util::droppostoground(var_0A);
	if(!isdefined(var_0B))
	{
		thread waitforstop();
		return;
	}

	if(!maps\mp\zombies\_util::canmovepointtopoint(var_09.pos,var_0B))
	{
		thread waitforstop();
		return;
	}

	cancelallbut("stop");
	thread waitforpathsetwhilestopping();
	thread waitforturnwhilestopping();
	if(distancesquared(var_0A,self.origin) > 4)
	{
		self scragentsetwaypoint(var_0A);
		thread waitforblockedwhilestopping();
		self waittill("waypoint_reached");
		self notify("zombiedogmove_endwait_blockedwhilestopping");
	}

	var_0C = var_07 - self.origin;
	var_0D = vectortoangles(var_0C);
	var_0E = (0,var_0D[1] - var_06,0);
	var_0F = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_07 - self.origin,var_05);
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",var_0E,(0,var_0D[1],0));
	self scragentsetanimscale(var_0F.xy,var_0F.z);
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_00,var_03,self.moveratescale,"move_stop");
	self scragentsetgoalpos(self.origin);
}

//Function Number: 9
waitforpathsetwhilestopping()
{
	self notify("zombiedogmove_endwait_pathsetwhilestopping");
	self endon("zombiedogmove_endwait_pathsetwhilestopping");
	self endon("killanimscript");
	var_00 = self scragentgetgoalpos();
	self waittill("path_set");
	var_01 = self scragentgetgoalpos();
	if(distancesquared(var_00,var_01) < 1)
	{
		thread waitforpathsetwhilestopping();
		return;
	}

	self notify("zombiedogmove_endwait_stop");
	self notify("zombiedogmove_endwait_turnwhilestopping");
	thread continuemovement();
}

//Function Number: 10
waitforturnwhilestopping()
{
	self notify("zombiedogmove_endwait_turnwhilestopping");
	self endon("zombiedogmove_endwait_turnwhilestopping");
	self endon("killanimscript");
	self waittill("path_dir_change",var_00);
	self notify("zombiedogmove_endwait_pathsetwhilestopping");
	self notify("zombiedogmove_endwait_stop");
	thread doturn(var_00);
}

//Function Number: 11
waitforblockedwhilestopping()
{
	self notify("zombiedogmove_endwait_blockedwhilestopping");
	self endon("zombiedogmove_endwait_blockedwhilestopping");
	self endon("killanimscript");
	self waittill("path_blocked");
	self notify("zombiedogmove_endwait_stop");
	self scragentsetwaypoint(undefined);
}

//Function Number: 12
cancelallbut(param_00)
{
	var_01 = ["turn","stop","pathsetwhilestopping","blockedwhilestopping","turnwhilestopping","setmoveanim","modechange"];
	var_02 = isdefined(param_00);
	foreach(var_04 in var_01)
	{
		if(var_02 && var_04 == param_00)
		{
			continue;
		}

		self notify("zombiedogmove_endwait_" + var_04);
	}
}

//Function Number: 13
startmove()
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
		return;
	}

	var_02 = self getlookaheaddir();
	var_03 = vectortoangles(var_02);
	var_04 = self getvelocity();
	if(length2dsquared(var_04) > 16)
	{
		var_04 = vectornormalize(var_04);
		if(vectordot(var_04,var_02) > 0.707)
		{
			return;
		}
	}

	var_05 = "move_start";
	var_06 = angleclamp180(var_03[1] - self.angles[1]);
	var_07 = self getanimentrycount(var_05);
	if(var_07 == 0)
	{
		return;
	}

	var_08 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_06,var_07);
	var_09 = self getanimentry(var_05,var_08);
	var_0A = getmovedelta(var_09);
	var_0B = rotatevector(var_0A,self.angles) + self.origin;
	if(!maps\mp\zombies\_util::canmovepointtopoint(self.origin,var_0B,0))
	{
		return;
	}

	var_0C = getangledelta3d(var_09);
	self scragentsetanimmode("anim deltas");
	if(abs(var_08 - int(var_07 * 0.5)) <= 1)
	{
		self scragentsetorientmode("face angle abs",(0,angleclamp180(var_03[1] - var_0C[1]),0));
	}
	else
	{
		self scragentsetorientmode("face angle abs",self.angles);
	}

	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_05,var_08,self.moveratescale,"move_start","code_move");
}

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
dohitreaction(param_00,param_01)
{
	cancelallbut(undefined);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoHitReaction");
	var_02 = angleclamp180(param_00 - self.angles[1]);
	var_03 = "";
	var_04 = 0;
	if(isdefined(param_01) && param_01 == "boost_slam_mp" && var_02 < 45 && randomfloat(1) < 0.4)
	{
		var_03 = "pain_knockback_front";
		var_04 = 0;
	}
	else
	{
		var_03 = "run_pain";
		if(var_02 > 0)
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 0;
		}
	}

	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",self.angles);
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack(var_03,var_04,self.nonmoveratescale,"pain_anim");
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoHitReaction");
	continuemovement();
}

//Function Number: 17
ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return;
	}

	if(isdefined(param_07))
	{
		var_0A = vectortoangles(param_07);
		var_0B = var_0A[1] - 180;
		thread dohitreaction(var_0B,param_05);
	}
}

//Function Number: 18
onflashbanged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return;
	}

	dohitreaction(self.angles[1] + 180);
}
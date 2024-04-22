/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\humanoid\_humanoid_move.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 375 ms
 * Timestamp: 4/22/2024 2:08:11 AM
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
	thread waitforrunwalkchange();
	thread waitforturn();
	thread waitforstop();
	thread waitfordodge();
	thread waitforleap();
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
	self notify("humanoidmove_endwait_setmoveanim");
	self endon("humanoidmove_endwait_setmoveanim");
	self endon("killanimscript");
	self.inpainmoving = 0;
	self.inturnanim = 0;
	var_01 = randomint(self getanimentrycount(param_00));
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_00,var_01,self.moveratescale);
}

//Function Number: 6
setmoveanimpain(param_00,param_01,param_02)
{
	self notify("humanoidmove_endwait_setmoveanim");
	self endon("humanoidmove_endwait_setmoveanim");
	self endon("killanimscript");
	if(maps\mp\agents\humanoid\_humanoid_util::iscrawling())
	{
		return;
	}

	var_03 = "pain_" + self.movemode;
	if(param_02)
	{
		var_03 = var_03 + "_lower";
	}

	var_04 = angleclamp180(param_00 - self.angles[1]);
	var_05 = self getanimentrycount(var_03);
	var_06 = maps\mp\agents\humanoid\_humanoid_util::getpainangleindexvariable(var_04,var_05);
	self.inpainmoving = 1;
	self scragentsetanimmode("code_move");
	self scragentsetorientmode("face motion");
	self scragentsetanimscale(1,1);
	var_07 = self.moveratescale;
	if(self.movemode == "walk")
	{
		var_07 = var_07 - 0.2;
	}
	else if(self.movemode == "run")
	{
		var_07 = var_07 - 0.1;
	}

	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_06,var_07,"pain_anim");
	thread continuemovement();
}

//Function Number: 7
waitforrunwalkchange()
{
	self notify("humanoidmove_endwait_modechange");
	self endon("humanoidmove_endwait_modechange");
	self endon("killanimscript");
	var_00 = self.movemode;
	var_01 = self.moveratescale;
	for(;;)
	{
		var_02 = 0;
		if(isdefined(self.movemode) && !isdefined(var_00) || var_00 != self.movemode)
		{
			var_02 = 1;
		}

		if(isdefined(self.moveratescale) && !isdefined(var_01) || var_01 != self.moveratescale)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			thread setmoveanim(self.movemode);
			var_00 = self.movemode;
			var_01 = self.moveratescale;
		}

		wait(0.05);
	}
}

//Function Number: 8
doturn(param_00)
{
	self notify("humanoidmove_DoTurn");
	self endon("humanoidmove_DoTurn");
	self endon("killanimscript");
	var_01 = "turn_" + self.movemode;
	if(self.movemode == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2)
	{
		var_01 = var_01 + "_v2";
	}

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
	if(!candoturnanim(var_06,var_08,var_05 == 3 || var_05 == 5,1))
	{
		var_01 = var_01 + "_quick";
		var_09 = 0;
		if(self hasanimstate(var_01) && maps\mp\zombies\_util::getzombieslevelnum() >= 2)
		{
			var_06 = self getanimentry(var_01,var_05);
			var_07 = getangledelta(var_06);
			var_08 = (0,angleclamp180(var_02[1] - var_07),0);
			if(candoturnanim(var_06,var_08,var_05 == 3 || var_05 == 5,2))
			{
				var_09 = 1;
			}
		}

		if(!var_09)
		{
			thread waitforturn();
			return;
		}
	}

	cancelallbut("turn");
	self.inturnanim = 1;
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",var_08);
	var_0A = self.moveratescale;
	if(!maps\mp\agents\humanoid\_humanoid_util::iscrawling() && self.movemode == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() < 2)
	{
		var_0A = level.moveratescalemod["run"][1];
		var_0A = var_0A + self.moveratescale - level.moveratescalemod["sprint"][0];
	}

	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_01,var_05,var_0A,"turn");
	thread continuemovement();
}

//Function Number: 9
candoturnanim(param_00,param_01,param_02,param_03)
{
	var_04 = 0.5;
	var_05 = getnotetracktimes(param_00,"turn_extent");
	if(var_05.size == 1)
	{
		var_04 = var_05[0];
	}

	var_06 = 1;
	var_07 = getnotetracktimes(param_00,"finish");
	if(var_07.size == 0)
	{
		var_07 = getnotetracktimes(param_00,"end");
	}

	if(var_07.size == 1)
	{
		var_06 = var_07[0];
	}

	var_08 = getmovedelta(param_00,0,var_04);
	var_09 = getmovedelta(param_00,0,var_06);
	var_0A = self.origin;
	var_0B = rotatevector(var_08,param_01) + var_0A;
	var_0C = rotatevector(var_09,param_01) + var_0A;
	if(!maps\mp\zombies\_util::canmovepointtopoint(var_0B,var_0C,0))
	{
		return 0;
	}

	var_0D = self.radius;
	if(!param_02)
	{
		var_0D = self.radius / 2;
	}

	if(!maps\mp\zombies\_util::canmovepointtopoint(var_0A,var_0B,0,var_0D))
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
waitforturn()
{
	self notify("humanoidmove_endwait_turn");
	self endon("humanoidmove_endwait_turn");
	self endon("killanimscript");
	self waittill("path_dir_change",var_00);
	if(maps\mp\zombies\_util::is_true(self.inairforleap))
	{
		thread waitforturn();
	}

	if(maps\mp\zombies\_util::is_true(self.inpainmoving))
	{
		thread waitforturn();
	}

	childthread doturn(var_00);
}

//Function Number: 11
waitforstop()
{
	self notify("humanoidmove_endwait_stop");
	self endon("humanoidmove_endwait_stop");
	self endon("killanimscript");
	self waittill("stop_soon");
	if(maps\mp\zombies\_util::is_true(self.inairforleap))
	{
		thread waitforstop();
	}

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
	if(var_00 == "stop_sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2)
	{
		var_00 = var_00 + "_v2";
	}

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
		self notify("humanoidmove_endwait_blockedwhilestopping");
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

//Function Number: 12
waitfordodge()
{
	self notify("humanoidmove_endwait_dodge");
	self endon("humanoidmove_endwait_dodge");
	self endon("killanimscript");
	maps\mp\zombies\_util::waittill_enter_game();
	while(isalive(self))
	{
		self waittill("damage",var_00,var_01);
		wait(0.05);
		if(!isalive(self))
		{
			return;
		}

		if(!maps\mp\zombies\_util::is_true(self.dodgeenabled))
		{
			return;
		}

		if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			continue;
		}

		if(!isdefined(var_01) || !isalive(var_01) || !isplayer(var_01))
		{
			continue;
		}

		var_02 = var_01.origin - self.origin;
		var_03 = anglestoforward(self.angles);
		if(vectordot(vectornormalize(var_02),var_03) < 0.7)
		{
			continue;
		}

		var_04 = lengthsquared(var_02);
		if(var_04 > 1000000 || var_04 < 40000)
		{
			continue;
		}

		if(isdefined(self.dodgelast) && gettime() - self.dodgelast < self.dodgedebouncems)
		{
			continue;
		}

		self.dodgelast = gettime();
		if(randomfloat(1) < self.dodgechance)
		{
			wait(randomfloatrange(0.1,0.3));
			if(!isalive(self))
			{
				return;
			}

			if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
			{
				continue;
			}

			cancelallbut("dodge");
			self.lungelast = gettime();
			var_05 = vectornormalize((var_02[0],var_02[1],0));
			var_06 = vectortoangles(var_05);
			var_07 = self.dodgeanimstate;
			var_08 = randomint(self getanimentrycount(var_07));
			maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(self.dodge_fx[var_08]);
			self scragentsetanimmode("anim deltas");
			self scragentsetorientmode("face angle abs",var_06,var_06);
			self scragentsetanimscale(1,1);
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_07,var_08,self.nonmoveratescale,"dodge");
			self.bhasnopath = 1;
			thread continuemovement();
		}
	}
}

//Function Number: 13
waitforleap()
{
	self notify("humanoidmove_endwait_leap");
	self endon("humanoidmove_endwait_leap");
	self endon("killanimscript");
	maps\mp\zombies\_util::waittill_enter_game();
	for(;;)
	{
		wait(0.05);
		if(!isalive(self))
		{
			return;
		}

		if(!maps\mp\zombies\_util::is_true(self.leapenabled))
		{
			return;
		}

		if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			continue;
		}

		if(!isdefined(self.curmeleetarget))
		{
			continue;
		}

		if((issentient(self.curmeleetarget) && !self agentcanseesentient(self.curmeleetarget)) || !maps\mp\_utility::findisfacing(self,self.curmeleetarget,25))
		{
			continue;
		}

		if(isdefined(self.getleaptargetpointfunc))
		{
			var_00 = [[ self.getleaptargetpointfunc ]]();
		}
		else
		{
			var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
		}

		if(!var_00.valid)
		{
			continue;
		}

		var_01 = distancesquared(self.curmeleetarget.origin,self.origin);
		if(var_01 > self.leapmaxrangesq || var_01 < self.leapminrangesq)
		{
			continue;
		}

		var_02 = gettime();
		var_03 = var_02 - self.leaplastperform;
		if(var_03 < self.leapdebouncems)
		{
			continue;
		}

		var_04 = var_02 - self.leaplastcheck;
		if(var_04 < self.leapchecktimems)
		{
			continue;
		}

		self.leaplastcheck = var_02;
		var_05 = self.leapchance;
		if(randomfloat(1) >= var_05)
		{
			continue;
		}

		var_07 = randomint(self getanimentrycount(self.leapanimstate));
		var_08 = self getanimentry(self.leapanimstate,var_07);
		var_09 = getnotetracktimes(var_08,"h_point")[0];
		var_0A = getmovedelta(var_08,0,var_09);
		var_0B = self localtoworldcoords(var_0A);
		var_0C = playerphysicstrace(self.origin,var_0B,self);
		if(distancesquared(var_0C,var_0B) > 1)
		{
			self.leaplastcheck = self.leaplastcheck + 1000;
			continue;
		}

		var_0C = playerphysicstrace(var_0B,var_00.origin,self);
		if(distancesquared(var_0C,var_00.origin) > 1)
		{
			self.leaplastcheck = self.leaplastcheck + 1000;
			continue;
		}

		cancelallbut("leap");
		self.leaplastperform = gettime();
		maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(self.leapfx);
		var_0D = getanimlength(var_08);
		var_0E = getnotetracktimes(var_08,"land");
		var_0E[0] = var_0E[0] - 0.1;
		var_0F = var_0D / self.nonmoveratescale * var_0E[0];
		self scragentsetphysicsmode("noclip");
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(var_00.origin - self.origin),0));
		self scragentsetanimmode("anim deltas");
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,var_00.origin,var_0F);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"WaitForLeap");
		self.inairforleap = 1;
		maps\mp\agents\_scripted_agent_anim_util::set_anim_state(self.leapanimstate,var_07,self.nonmoveratescale);
		wait(var_0F);
		self notify("cancel_updatelerppos");
		self scragentsetanimmode("anim deltas");
		self scragentsetanimscale(1,1);
		self scragentsetphysicsmode("gravity");
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"WaitForLeap");
		self.inairforleap = 0;
		if(var_0D - var_0F > 0)
		{
			maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("leap","end",var_0D - var_0F);
		}

		thread continuemovement();
	}
}

//Function Number: 14
waitforpathsetwhilestopping()
{
	self notify("humanoidmove_endwait_pathsetwhilestopping");
	self endon("humanoidmove_endwait_pathsetwhilestopping");
	self endon("killanimscript");
	var_00 = self scragentgetgoalpos();
	self waittill("path_set");
	var_01 = self scragentgetgoalpos();
	if(distancesquared(var_00,var_01) < 1)
	{
		thread waitforpathsetwhilestopping();
		return;
	}

	self notify("humanoidmove_endwait_stop");
	self notify("humanoidmove_endwait_turnwhilestopping");
	thread continuemovement();
}

//Function Number: 15
waitforturnwhilestopping()
{
	self notify("humanoidmove_endwait_turnwhilestopping");
	self endon("humanoidmove_endwait_turnwhilestopping");
	self endon("killanimscript");
	self waittill("path_dir_change",var_00);
	self notify("humanoidmove_endwait_pathsetwhilestopping");
	self notify("humanoidmove_endwait_stop");
	thread doturn(var_00);
}

//Function Number: 16
waitforblockedwhilestopping()
{
	self notify("humanoidmove_endwait_blockedwhilestopping");
	self endon("humanoidmove_endwait_blockedwhilestopping");
	self endon("killanimscript");
	self waittill("path_blocked");
	self notify("humanoidmove_endwait_stop");
	self scragentsetwaypoint(undefined);
}

//Function Number: 17
cancelallbut(param_00)
{
	var_01 = ["turn","stop","pathsetwhilestopping","blockedwhilestopping","turnwhilestopping","dodge","setmoveanim","modechange"];
	var_02 = isdefined(param_00);
	foreach(var_04 in var_01)
	{
		if(var_02 && var_04 == param_00)
		{
			continue;
		}

		self notify("humanoidmove_endwait_" + var_04);
	}
}

//Function Number: 18
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

	var_05 = "start_" + self.movemode;
	if(self.movemode == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2)
	{
		var_05 = var_05 + "_v2";
	}

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
	if(!maps\mp\zombies\_util::canmovepointtopoint(self.origin,var_0B))
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

	var_0D = self.moveratescale;
	if(!maps\mp\agents\humanoid\_humanoid_util::iscrawling() && self.movemode == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() < 2)
	{
		var_0D = level.moveratescalemod["run"][1];
		var_0D = var_0D + self.moveratescale - level.moveratescalemod["sprint"][0];
	}

	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_05,var_08,var_0D,"move_start","code_move");
}

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
islowerbody(param_00)
{
	switch(param_00)
	{
		case "left_foot":
		case "right_foot":
		case "left_leg_lower":
		case "right_leg_lower":
		case "left_leg_upper":
		case "right_leg_upper":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 22
ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!maps\mp\zombies\_zombies::shouldplayhitreactionpainsensor())
	{
		return;
	}

	if(!maps\mp\agents\_scripted_agent_anim_util::isstatelocked() && !maps\mp\zombies\_util::is_true(self.inpainmoving))
	{
		thread setmoveanimpain(maps\mp\agents\humanoid\_humanoid_util::damagehitangle(param_06,param_07),self.movemode,islowerbody(param_08));
	}
}
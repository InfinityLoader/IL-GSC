/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_move.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 584 ms
 * Timestamp: 4/22/2024 1:58:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["move"] ]]();
			return;
		}
	}

	self.sharpturnlookaheaddist = 48;
	self.postsharpturnlookaheaddist = 100;
	self.sharpturntooclosetodestdist = 72;
	self endon("killanimscript");
	thread handlefootstepnotetracks();
	if(self isdogbeingdriven())
	{
		continuedrivenmovement();
		return;
	}

	startmove();
	continuemovement();
}

//Function Number: 2
end_script()
{
	if(isdefined(self.prevturnrate))
	{
		self.turnrate = self.prevturnrate;
		self.prevturnrate = undefined;
	}

	if(isdefined(self.moveoverridesound))
	{
		stopmovesound();
		self.moveoverridesound = undefined;
	}

	self.drivenmovemode = undefined;
	self.bsharpturnduringsharpturn = undefined;
	cancelallbut(undefined);
}

//Function Number: 3
setupmovement()
{
	thread waitfordrivenchange();
	thread waitforrunwalkslopechange();
	thread waitforratechange();
	thread waitforbark();
	thread waitforsharpturn();
	thread waitforstop();
	thread waitforfollowspeed();
}

//Function Number: 4
continuemovement()
{
	self.moveratemultiplier = 1;
	setupmovement();
	self animmode("none");
	self orientmode("face motion");
	self clearanim(%body,0.2);
	setmoveanim(self.movemode,self.stairsstate,1);
}

//Function Number: 5
continuedrivenmovement()
{
	self clearanim(%body,0.5);
	self.drivenmovemode = getdesireddrivenmovemode("walk");
	setdrivenanim(self.drivenmovemode,1);
	thread waitfordrivenchange();
	thread drivenanimupdate();
}

//Function Number: 6
startturntoangle(param_00,param_01)
{
	self clearanim(%body,0.2);
	animscripts\dog\dog_stop::turntoangle(param_00,param_01);
}

//Function Number: 7
startmove()
{
	self.bfirstmoveanim = 1;
	var_00 = self getnegotiationstartnode();
	if(isdefined(var_00))
	{
		var_01 = var_00.origin;
	}
	else
	{
		var_01 = self.pathgoalpos;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(isdefined(self.disableexits) && self.disableexits)
	{
		return;
	}

	if(self isdogbeingdriven())
	{
		return;
	}

	var_02 = vectortoangles(self.lookaheaddir);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	if((isdefined(self.bdoturnandmove) && self.bdoturnandmove) || isdefined(self.movementtype) && self.movementtype == "walk" || self.movementtype == "walk_fast" || self.movementtype == "sniff")
	{
		if(abs(var_03) > 25)
		{
			startturntoangle(var_02[1],1);
		}

		return;
	}

	if(length2dsquared(self.velocity) > 16)
	{
		var_04 = vectortoangles(self.velocity);
		if(abs(angleclamp180(var_04[1] - var_02[1])) < 45)
		{
			return;
		}
	}

	if(distancesquared(var_01,self.origin) < 22500)
	{
		if(abs(var_03) > 25)
		{
			startturntoangle(var_02[1],1);
		}

		return;
	}

	var_05 = getdogmoveanim("run_start");
	var_06 = getangleindices(var_03);
	var_07 = undefined;
	for(var_08 = 0;var_08 < var_06.size;var_08++)
	{
		var_09 = var_06[var_08];
		var_07 = var_05[var_09];
		var_0A = getmovedelta(var_07);
		var_0B = rotatevector(var_0A,self.angles) + self.origin;
		if(self maymovefrompointtopoint(self.origin,var_0B,1,1))
		{
			break;
		}
	}

	if(var_08 == var_06.size)
	{
		if(abs(var_03) > 25)
		{
			startturntoangle(var_02[1],1);
		}

		return;
	}

	self.moveanimtype = "run";
	var_0C = getnotetracktimes(var_07,"code_move");
	var_0D = 1;
	if(var_0C.size > 0)
	{
		var_0D = var_0C[0];
	}

	var_0E = getangledelta3d(var_07,0,var_0D);
	self animmode("zonly_physics",0);
	self orientmode("face angle",angleclamp180(var_02[1] - var_0E[1]));
	var_0F = getanimlength(var_07) * var_0D;
	var_10 = 0.01 + abs(angleclamp180(var_03 - var_0E[1])) / var_0F / 1000;
	if(var_10 < 0.01)
	{
		var_10 = 0.01;
	}

	self.prevturnrate = self.turnrate;
	self.turnrate = var_10;
	var_11 = 0.1;
	if(animscripts\dog\dog_stop::getdefaultidlestate() != "attackidle")
	{
		var_11 = 0.4;
	}

	self setflaggedanimknoballrestart("dog_start_move",var_07,%body,1,var_11,self.moveplaybackrate);
	thread startmove_updateangle(var_07,var_0D,var_0F);
	animscripts\shared::donotetracks("dog_start_move");
	self notify("end_startmove_updateangle");
	self.turnrate = self.prevturnrate;
	self.prevturnrate = undefined;
	self animmode("none",0);
	self orientmode("face motion");
}

//Function Number: 8
startmove_updateangle(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("end_startmove_updateangle");
	wait(0.05);
	for(;;)
	{
		var_03 = self getanimtime(param_00);
		var_04 = vectortoangles(self.lookaheaddir);
		var_05 = getangledelta3d(param_00,var_03,param_01);
		var_06 = angleclamp180(var_04[1] - self.angles[1]);
		self orientmode("face angle",angleclamp180(var_04[1] - var_05[1]));
		self.turnrate = 0.01 + abs(angleclamp180(var_06 - var_05[1])) / param_02 / 1000;
		if(self.turnrate < 0.01)
		{
			self.turnrate = 0.01;
		}

		wait(0.05);
	}
}

//Function Number: 9
startdrivenmovement()
{
	var_00 = getdogmoveanim("run_start");
	var_01 = var_00[4];
	self setflaggedanimknoballrestart("dog_start_move",var_01,%body);
	animscripts\shared::donotetracks("dog_start_move");
}

//Function Number: 10
waitfordrivenchange()
{
	self endon("dogmove_endwait_drivenchange");
	self endon("killanimscript");
	var_00 = self isdogbeingdriven();
	for(;;)
	{
		var_01 = self isdogbeingdriven();
		if(var_00 != var_01)
		{
			cancelallbut("drivenchange");
			if(var_01)
			{
				continuedrivenmovement();
			}
			else
			{
				continuemovement();
			}

			break;
		}

		wait(0.2);
	}
}

//Function Number: 11
waitforrunwalkslopechange()
{
	self endon("dogmove_endwait_runwalkslope");
	self endon("killanimscript");
	var_00 = self.movemode;
	var_01 = self.stairsstate;
	var_02 = self.run_overrideanim;
	var_03 = self.walk_overrideanim;
	var_04 = self.movementtype;
	for(;;)
	{
		if(var_00 != self.movemode || var_01 != self.stairsstate || hasmovementtypechanged(var_04) || hasoverrideanimchanged(var_02,var_03))
		{
			self clearanim(%dog_move,0.2);
			if(isdefined(self.script_nostairs))
			{
				setmoveanim(self.movemode,"none",1);
			}
			else
			{
				setmoveanim(self.movemode,self.stairsstate,1);
			}

			var_00 = self.movemode;
			var_01 = self.stairsstate;
			var_02 = self.run_overrideanim;
			var_03 = self.walk_overrideanim;
			var_04 = self.movementtype;
		}

		wait(0.1);
	}
}

//Function Number: 12
waitforratechange()
{
	self endon("dogmove_endwait_ratechange");
	self endon("killanimscript");
	var_00 = self.moveplaybackrate;
	var_01 = self.moveratemultiplier;
	for(;;)
	{
		if(var_00 != self.moveplaybackrate || var_01 != self.moveratemultiplier)
		{
			setmoveanim(self.movemode,self.stairsstate,0);
			var_00 = self.moveplaybackrate;
			var_01 = self.moveratemultiplier;
		}

		wait(0.1);
	}
}

//Function Number: 13
waitforsharpturn()
{
	self endon("dogmove_endwait_sharpturn");
	self endon("killanimscript");
	self waittill("path_changed",var_00,var_01,var_02);
	var_03 = dosharpturn(var_01,var_02);
	if(!var_03)
	{
		thread waitforsharpturn();
	}
}

//Function Number: 14
shoulddosharpturns()
{
	if(isdefined(self.script_noturnanim) || self isdogbeingdriven())
	{
		return 0;
	}

	if(isdefined(self.movementtype) && self.movementtype == "walk" || self.movementtype == "walk_fast")
	{
		return 0;
	}

	if(self.stairsstate == "down")
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
dosharpturn(param_00,param_01)
{
	if(!shoulddosharpturns())
	{
		return 0;
	}

	var_02 = 10;
	if(param_01)
	{
		var_02 = 30;
	}

	var_03 = vectortoangles(param_00);
	var_04 = angleclamp180(var_03[1] - self.angles[1]);
	var_05 = getangleindex(var_04,var_02);
	if(var_05 == 4)
	{
		return 0;
	}

	cancelallbut("sharpturn");
	thread waitforsharpturnduringsharpturn();
	if(shouldsniff())
	{
		var_06 = getdogmoveanim("sniff_turn");
		if(var_05 < 4)
		{
			var_07 = var_06[2];
		}
		else
		{
			var_07 = var_06[6];
		}
	}
	else
	{
		var_07 = getdogturnanim("quick_sharp_turn",var_07);
	}

	var_08 = getnotetracktimes(var_07,"code_move");
	var_09 = 1;
	if(var_08.size > 0)
	{
		var_09 = var_08[0];
	}

	var_0A = getangledelta(var_07,0,var_09);
	var_0B = getanimlength(var_07) * var_09;
	var_0C = abs(var_04 - var_0A) / var_0B / 1000;
	if(var_0C < 0.01)
	{
		var_0C = 0.01;
	}

	self.prevturnrate = self.turnrate;
	self.turnrate = var_0C;
	self clearanim(%dog_move,0.1);
	self animmode("zonly_physics",0);
	self orientmode("face angle",angleclamp180(var_03[1] - var_0A));
	self setflaggedanimknoballrestart("dog_sharp_turn",var_07,%body,1,0.2,self.moveplaybackrate);
	animscripts\shared::donotetracks("dog_sharp_turn");
	self clearanim(%dog_move_turn,0.2);
	self.turnrate = self.prevturnrate;
	self.prevturnrate = undefined;
	self notify("dogmove_endwait_sharpturnduringsharpturn");
	if(isdefined(self.bsharpturnduringsharpturn))
	{
		self.bsharpturnduringsharpturn = undefined;
		if(!dosharpturn(self.lookaheaddir,1))
		{
			continuemovement();
		}
	}
	else
	{
		continuemovement();
	}

	return 1;
}

//Function Number: 16
waitforsharpturnduringsharpturn()
{
	self endon("dogmove_endwait_sharpturnduringsharpturn");
	self endon("killanimscript");
	for(;;)
	{
		self waittill("path_changed",var_00,var_01,var_02);
		if(var_02)
		{
			self.bsharpturnduringsharpturn = 1;
		}
	}
}

//Function Number: 17
shoulddoarrivals()
{
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	if(self isdogbeingdriven())
	{
		return 0;
	}

	if(isdefined(self.movementtype) && self.movementtype == "walk" || self.movementtype == "walk_fast")
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
waitforstop()
{
	self endon("dogmove_endwait_stop");
	self endon("killanimscript");
	self.stopanimdistsq = level.dogstoppingdistsq;
	self waittill("stop_soon");
	if(!shoulddoarrivals())
	{
		return;
	}

	var_00 = self.pathgoalpos;
	if(!isdefined(var_00))
	{
		thread waitforstop();
		return;
	}

	var_01 = getarrivalnode();
	if(isdefined(var_01) && var_01.type != "Path")
	{
		var_02 = angleclamp180(var_01.angles[1] - self.angles[1]);
		var_03 = getangleindex(var_02);
	}
	else
	{
		var_04 = var_02 - self.origin;
		var_05 = vectortoangles(var_04);
		var_02 = angleclamp180(var_05[1] - self.angles[1]);
		var_03 = getangleindex(var_02);
	}

	var_06 = getdogmoveanim("run_stop");
	var_07 = animscripts\dog\dog_stop::getdefaultidlestate(0);
	if(var_07 == "attackidle")
	{
		var_08 = "attack";
	}
	else if(var_08 == "sneakidle" && var_06 == 4)
	{
		var_08 = "sneak";
	}
	else if(var_08 == "alertidle" || var_08 == "sneakidle")
	{
		var_08 = "alert";
	}
	else
	{
		var_08 = "casual";
	}

	var_09 = var_06[var_08][var_03];
	if(!isdefined(var_09))
	{
		thread waitforstop();
		return;
	}

	var_0A = getmovedelta(var_09);
	var_0B = getangledelta(var_09);
	var_0C = var_00 - self.origin;
	if(length(var_0C) < length(var_0A))
	{
		thread waitforstop();
		return;
	}

	var_0D = getstopdata();
	var_0E = calcanimstartpos(var_0D.pos,var_0D.angles[1],var_0A,var_0B);
	var_0F = droppostoground(var_0E);
	if(!isdefined(var_0F))
	{
		thread waitforstop();
		return;
	}

	if(!self maymovefrompointtopoint(var_0D.pos,var_0F))
	{
		thread waitforstop();
		return;
	}

	cancelallbut("stop");
	if(distancesquared(var_0E,self.origin) > 4)
	{
		thread waitforpathsetwhilestopping();
		self setruntopos(var_0E);
		self waittill("runto_arrived");
		self notify("dogmove_endwait_pathsetwhilestopping");
	}

	if(!shoulddoarrivals())
	{
		continuemovement();
		return;
	}

	stopmovesound();
	if(isdefined(var_01) && var_01.type != "Path")
	{
		var_10 = var_01.angles;
	}
	else
	{
		var_11 = var_01 - self.origin;
		var_10 = vectortoangles(var_11);
	}

	if(var_03 == 0 || var_03 == 1 || var_03 == 7 || var_03 == 8)
	{
		var_12 = (0,var_0D.angles[1] - var_0B,0);
	}
	else
	{
		var_12 = (0,var_12[1] - var_0C,0);
	}

	self.dogarrivalanim = var_09;
	self startcoverarrival(var_0E,var_12[1],0);
}

//Function Number: 19
waitforpathsetwhilestopping()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_pathsetwhilestopping");
	var_00 = self.goalpos;
	self waittill("path_set");
	var_01 = self.goalpos;
	if(distance2dsquared(var_00,var_01) < 1)
	{
		thread waitforpathsetwhilestopping();
		return;
	}

	cancelallbut("pathsetwhilestopping");
	continuemovement();
}

//Function Number: 20
waitforbark()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_bark");
	var_00 = 0.3;
	var_01 = var_00;
	for(;;)
	{
		if(isdefined(self.script_nobark) && self.script_nobark)
		{
			var_01 = var_00;
		}
		else if(isdefined(self.enemy))
		{
			soundscripts\_snd::snd_message("anml_doberman","bark");
			var_01 = 2 + randomint(1);
		}
		else
		{
			var_01 = var_00;
		}

		wait(var_01);
	}
}

//Function Number: 21
waitforfollowspeed()
{
	self endon("killanimscript");
	self endon("dogmove_endwait_followspeed");
	var_00 = 128;
	var_01 = 0.6;
	var_02 = -30;
	var_03 = 30;
	self.moveratemultiplier = 1;
	for(;;)
	{
		var_04 = self.moveratemultiplier;
		self.moveratemultiplier = 1;
		if(self isdogfollowinghandler() && self.movemode == "run")
		{
			if(isdefined(self.doghandler.pathgoalpos))
			{
				var_05 = self.origin - self.doghandler.origin;
				var_06 = lengthsquared(var_05);
				if(var_06 < var_00 * var_00)
				{
					var_07 = vectordot(self.doghandler.lookaheaddir,var_05);
					if(var_07 > var_03)
					{
						self.moveratemultiplier = lerp(var_01,1,lerpfraction(var_03,var_00,var_07));
					}
					else if(var_07 > var_02)
					{
						self.moveratemultiplier = var_01;
					}
					else
					{
						self.moveratemultiplier = lerp(var_01,1,lerpfraction(var_02,-1 * var_00,var_07));
					}
				}
			}
		}
		else
		{
			var_08 = 1;
			var_09 = self getdogavoident();
			if(isdefined(var_09))
			{
				var_0A = var_09.origin - self.origin;
				var_0B = anglestoforward(self.angles);
				var_0C = vectordot(var_0B,var_0A);
				if(var_0C > 0)
				{
					if(isplayer(var_09))
					{
						var_0D = lengthsquared(var_09 getentityvelocity());
					}
					else
					{
						var_0D = lengthsquared(var_0A.velocity);
					}

					var_0E = anglestoforward(var_09.angles);
					var_0F = 0.5;
					if(var_0D < 1 || vectordot(var_0E,var_0B) > var_0F)
					{
						var_08 = 0.65;
					}
				}
			}

			if(var_04 < var_08)
			{
				self.moveratemultiplier = min(var_04 + 0.05,var_08);
			}
			else if(var_04 > var_08)
			{
				self.moveratemultiplier = max(var_04 - 0.05,var_08);
			}
		}

		wait(0.1);
	}
}

//Function Number: 22
lerp(param_00,param_01,param_02)
{
	return param_00 + param_01 - param_00 * param_02;
}

//Function Number: 23
lerpfraction(param_00,param_01,param_02)
{
	return param_02 - param_00 / param_01 - param_00;
}

//Function Number: 24
cancelallbut(param_00,param_01)
{
	var_02 = ["runwalkslope","ratechange","bark","sharpturn","sharpturnduringsharpturn","stop","pathsetwhilestopping","followspeed","drivenchange","drivenanim"];
	var_03 = isdefined(param_00);
	var_04 = isdefined(param_01);
	foreach(var_06 in var_02)
	{
		if(var_03 && var_06 == param_00)
		{
			continue;
		}

		if(var_04 && var_06 == param_01)
		{
			continue;
		}

		self notify("dogmove_endwait_" + var_06);
	}
}

//Function Number: 25
getstopdata()
{
	var_00 = spawnstruct();
	var_01 = getarrivalnode();
	if(isdefined(var_01) && var_01.type != "Path")
	{
		var_00.pos = var_01.origin;
		var_00.angles = var_01.angles;
	}
	else
	{
		var_00.pos = self.pathgoalpos;
		if(lengthsquared(self.velocity) > 1)
		{
			var_00.angles = self.angles;
		}
		else
		{
			var_00.angles = vectortoangles(self.lookaheaddir);
		}
	}

	return var_00;
}

//Function Number: 26
playmoveanim(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("dog_move",param_00,%dog_move,1,param_02,param_03);
		return;
	}

	self setflaggedanimknoball("dog_move",param_00,%dog_move,1,param_02,param_03);
}

//Function Number: 27
playmoveanimknob(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		self setflaggedanimknoballrestart("dog_move",param_00,%dog_move,1,param_02,param_03);
		return;
	}

	self setflaggedanimknoball("dog_move",param_00,%dog_move,1,param_02,param_03);
}

//Function Number: 28
setmoveanim(param_00,param_01,param_02)
{
	var_03 = !isdefined(param_02) || param_02;
	var_04 = undefined;
	var_05 = isdefined(self.bfirstmoveanim) && self.bfirstmoveanim;
	self.bfirstmoveanim = undefined;
	if(param_00 == "walk")
	{
		self setanimknob(%dog_walk,1);
		if(isdefined(self.walk_overrideanim))
		{
			var_06 = self.walk_overrideanim;
		}
		else if(shouldsniff())
		{
			var_06 = getdogmoveanim("sniff");
		}
		else
		{
			var_06 = getdogmoveanim("walk");
		}

		playmoveanim(var_06,var_03,0.3,self.moveplaybackrate * self.moveratemultiplier);
		self.moveanimtype = "walk";
	}
	else if(param_00 == "run")
	{
		if(param_01 == "up")
		{
			self setanimknob(%dog_slope,1);
			var_06 = getdogmoveanim("run_up");
			playmoveanimknob(var_06,var_03,0.5,self.moveplaybackrate * self.moveratemultiplier);
			self.moveanimtype = "run";
		}
		else if(param_02 == "down")
		{
			self setanimknob(%dog_slope,1);
			var_06 = getdogmoveanim("run_down");
			playmoveanimknob(var_06,var_03,0.5,self.moveplaybackrate * self.moveratemultiplier);
			self.moveanimtype = "run";
		}
		else if(isdefined(self.sprint) && self.sprint)
		{
			self setanimknob(%dog_run,1);
			var_06 = getdogmoveanim("sprint");
			playmoveanim(var_06,var_03,0.3,self.moveplaybackrate * self.moveratemultiplier);
			self.moveanimtype = "sprint";
		}
		else
		{
			self setanimknob(%dog_run,1);
			self.moveanimtype = "run";
			var_07 = isdefined(self.movementtype);
			var_08 = 0.3;
			if(isdefined(self.run_overrideanim))
			{
				var_06 = self.run_overrideanim;
				if(isdefined(self.run_overridesound))
				{
					var_04 = self.run_overridesound;
				}
			}
			else if(var_07 && self.movementtype == "walk")
			{
				var_06 = getdogmoveanim("walk");
				self.moveanimtype = "walk";
				if(var_05)
				{
					var_08 = 0.5;
				}
			}
			else if(var_07 && self.movementtype == "walk_fast")
			{
				var_06 = getdogmoveanim("walk_fast");
				self.moveanimtype = "walk";
				if(var_05)
				{
					var_08 = 0.5;
				}
			}
			else if(shouldsniff())
			{
				var_06 = getdogmoveanim("sniff");
				var_04 = "anml_dog_sniff_walk";
				self.moveanimtype = "walk";
				if(var_05)
				{
					var_08 = 0.5;
				}
			}
			else
			{
				var_06 = getdogmoveanim("run");
			}

			playmoveanim(var_06,var_03,var_08,self.moveplaybackrate * self.moveratemultiplier);
		}
	}
	else
	{
	}

	playmovesound(var_04);
}

//Function Number: 29
playmovesound(param_00)
{
	var_01 = isdefined(self.moveoverridesound);
	var_02 = isdefined(param_00);
	if(!var_01 && !var_02)
	{
		return;
	}
	else if(var_01 && var_02 && self.moveoverridesound == param_00)
	{
		return;
	}

	stopmovesound();
	if(var_02)
	{
		thread loopmovesound(param_00);
	}
}

//Function Number: 30
loopmovesound(param_00)
{
	self endon("killanimscript");
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 linkto(self);
	self.movesoundorigin = var_01;
	self.moveoverridesound = param_00;
	for(;;)
	{
		var_01 playsound(param_00,"dog_move_sound");
		var_02 = movesound_waitfordoneordeath(var_01,"dog_move_sound");
		if(!isdefined(var_02))
		{
			break;
		}
	}
}

//Function Number: 31
movesound_waitfordoneordeath(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	param_00 waittill(param_01);
	return 1;
}

//Function Number: 32
stopmovesound()
{
	if(isdefined(self.movesoundorigin))
	{
		if(self.movesoundorigin iswaitingonsound())
		{
			self.movesoundorigin stopsounds();
			wait(0.05);
		}

		if(isdefined(self.movesoundorigin))
		{
			self.movesoundorigin delete();
		}

		self.movesoundorigin = undefined;
		self.moveoverridesound = undefined;
	}
}

//Function Number: 33
getdesireddrivenmovemode(param_00)
{
	var_01 = 22500;
	var_02 = 10000;
	var_03 = length2dsquared(self.velocity);
	if(param_00 == "walk")
	{
		if(var_03 > var_01)
		{
			return "run";
		}
	}
	else if(param_00 == "run")
	{
		if(var_03 < var_02)
		{
			return "walk";
		}
	}

	return param_00;
}

//Function Number: 34
setdrivenanim(param_00,param_01,param_02)
{
	self.bfirstmoveanim = undefined;
	var_03 = 0.5;
	self clearanim(%dog_move,var_03);
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_00 == "walk")
	{
		playmoveanimknob(getdogmoveanim("sneak"),param_01,var_03,param_02);
		return;
	}

	if(param_00 == "run")
	{
		playmoveanimknob(getdogmoveanim("run"),param_01,var_03,param_02);
	}
}

//Function Number: 35
drivenanimupdate()
{
	self endon("dogmove_endwait_drivenanim");
	self endon("killanimscript");
	var_00 = 30;
	var_01 = var_00 * var_00;
	for(;;)
	{
		var_02 = getdesireddrivenmovemode(self.drivenmovemode);
		if(var_02 != self.drivenmovemode)
		{
			setdrivenanim(var_02,1);
			self.drivenmovemode = var_02;
		}

		if(self.drivenmovemode == "walk")
		{
			var_03 = 1;
			var_04 = length2dsquared(self.velocity);
			if(var_04 < var_01)
			{
				var_03 = max(sqrt(var_04) / var_00,0.15);
			}

			setdrivenanim(var_02,0,var_03);
		}

		wait(0.1);
	}
}

//Function Number: 36
calcanimstartpos(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_03;
	var_05 = (0,var_04,0);
	var_06 = rotatevector(param_02,var_05);
	return param_00 - var_06;
}

//Function Number: 37
dog_addlean()
{
	var_00 = clamp(self.leanamount / 25,-1,1);
	if(var_00 > 0)
	{
	}
}

//Function Number: 38
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

//Function Number: 39
getangleindices(param_00,param_01)
{
	var_02 = [-180,-135,-90,-45,0,45,90,135,180];
	var_03 = getangleindex(param_00,param_01);
	var_04 = [var_03];
	if(param_00 > var_02[var_03])
	{
		if(var_03 + 1 < var_02.size)
		{
			var_04[var_04.size] = var_03 + 1;
			if(param_00 > var_02[var_03] + var_02[var_03 + 1] * 0.5)
			{
				if(var_03 + 2 < var_02.size)
				{
					var_04[var_04.size] = var_03 + 2;
				}
			}
			else if(var_03 - 1 >= 0)
			{
				var_04[var_04.size] = var_03 - 1;
			}
		}
		else
		{
			if(var_03 - 1 >= 0)
			{
				var_04[var_04.size] = var_03 - 1;
			}

			var_04[var_04.size] = 1;
		}
	}
	else if(var_03 - 1 >= 0)
	{
		var_04[var_04.size] = var_03 - 1;
		if(param_00 < var_02[var_03] + var_02[var_03 - 1] * 0.5)
		{
			if(var_03 - 2 >= 0)
			{
				var_04[var_04.size] = var_03 - 2;
			}
		}
		else if(var_03 + 1 < var_02.size)
		{
			var_04[var_04.size] = var_03 + 1;
		}
	}
	else
	{
		if(var_03 + 1 < var_02.size)
		{
			var_04[var_04.size] = var_03 + 1;
		}

		var_04[var_04.size] = var_02.size - 1;
	}

	return var_04;
}

//Function Number: 40
droppostoground(param_00)
{
	var_01 = param_00 + (0,0,64);
	var_02 = param_00 + (0,0,-64);
	var_03 = 15;
	var_04 = 45;
	var_05 = self aiphysicstrace(var_01,var_02,var_03,var_04,1);
	if(abs(var_05[2] - var_01[2]) < 0.5)
	{
		return undefined;
	}

	if(abs(var_05[2] - var_02[2]) < 0.5)
	{
		return undefined;
	}

	return var_05;
}

//Function Number: 41
aredifferent(param_00,param_01)
{
	var_02 = isdefined(param_00);
	var_03 = isdefined(param_01);
	if(!var_02 && !var_03)
	{
		return 0;
	}

	if(var_02 && var_03 && param_00 == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 42
hasmovementtypechanged(param_00)
{
	return aredifferent(self.movementtype,param_00);
}

//Function Number: 43
hasoverrideanimchanged(param_00,param_01)
{
	return aredifferent(self.run_overrideanim,param_00) || aredifferent(self.walk_overrideanim,param_01);
}

//Function Number: 44
getarrivalnode()
{
	if(isdefined(self.scriptedarrivalent))
	{
		return self.scriptedarrivalent;
	}

	if(isdefined(self.node))
	{
		return self.node;
	}

	if(isdefined(self.prevnode) && isdefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin,self.pathgoalpos) < 36)
	{
		return self.prevnode;
	}

	return undefined;
}

//Function Number: 45
shouldsniff()
{
	return isdefined(self.movementtype) && self.movementtype == "sniff";
}

//Function Number: 46
getdogmoveanim(param_00)
{
	var_01 = animscripts\utility::lookupdoganim("move",param_00);
	return var_01;
}

//Function Number: 47
getdogturnanim(param_00,param_01,param_02)
{
	var_03 = getdogmoveanim(param_00);
	if(isdefined(var_03[param_01]))
	{
		return var_03[param_01];
	}

	if(isdefined(param_02))
	{
		var_03 = getdogmoveanim(param_02);
		return var_03[param_01];
	}
}

//Function Number: 48
handlefootstepnotetracks()
{
	self endon("killanimscript");
	for(;;)
	{
		self waittill("dog_move",var_00);
		animscripts\notetracks::handlenotetrack(var_00,"dog_move");
	}
}

//Function Number: 49
initdogarchetype_move()
{
	var_00 = [];
	var_00["walk"] = %iw6_dog_walk;
	var_00["walk_fast"] = %iw6_dog_fastwalk;
	var_00["run"] = %iw6_dog_run;
	var_00["run_up"] = %iw6_dog_ramp_up_run;
	var_00["run_down"] = %iw6_dog_ramp_down_run;
	var_00["sprint"] = %iw6_dog_sprint;
	var_00["sneak"] = %iw6_dog_sneak_walk_forward;
	var_00["sniff"] = %iw6_dog_sniff_walk;
	var_00["run_start"] = [];
	var_00["run_start"][0] = %iw6_dog_attackidle_runout_2;
	var_00["run_start"][1] = %iw6_dog_attackidle_runout_3;
	var_00["run_start"][2] = %iw6_dog_attackidle_runout_6;
	var_00["run_start"][3] = %iw6_dog_attackidle_runout_9;
	var_00["run_start"][4] = %iw6_dog_attackidle_runout_8;
	var_00["run_start"][5] = %iw6_dog_attackidle_runout_7;
	var_00["run_start"][6] = %iw6_dog_attackidle_runout_4;
	var_00["run_start"][7] = %iw6_dog_attackidle_runout_1;
	var_00["run_start"][8] = %iw6_dog_attackidle_runout_2;
	var_00["run_stop"] = [];
	var_00["run_stop"]["attack"] = [];
	var_00["run_stop"]["attack"][0] = %iw6_dog_attackidle_runin_2;
	var_00["run_stop"]["attack"][1] = %iw6_dog_attackidle_runin_1;
	var_00["run_stop"]["attack"][2] = %iw6_dog_attackidle_runin_4;
	var_00["run_stop"]["attack"][3] = %iw6_dog_attackidle_runin_7;
	var_00["run_stop"]["attack"][4] = %iw6_dog_attackidle_runin_8;
	var_00["run_stop"]["attack"][5] = %iw6_dog_attackidle_runin_9;
	var_00["run_stop"]["attack"][6] = %iw6_dog_attackidle_runin_6;
	var_00["run_stop"]["attack"][7] = %iw6_dog_attackidle_runin_3;
	var_00["run_stop"]["attack"][8] = %iw6_dog_attackidle_runin_2;
	var_00["run_stop"]["alert"] = [];
	var_00["run_stop"]["alert"][0] = %iw6_dog_alertidle_runin_2;
	var_00["run_stop"]["alert"][1] = %iw6_dog_alertidle_runin_1;
	var_00["run_stop"]["alert"][2] = %iw6_dog_alertidle_runin_4;
	var_00["run_stop"]["alert"][3] = %iw6_dog_alertidle_runin_7;
	var_00["run_stop"]["alert"][4] = %iw6_dog_alertidle_runin_8;
	var_00["run_stop"]["alert"][5] = %iw6_dog_alertidle_runin_9;
	var_00["run_stop"]["alert"][6] = %iw6_dog_alertidle_runin_6;
	var_00["run_stop"]["alert"][7] = %iw6_dog_alertidle_runin_3;
	var_00["run_stop"]["alert"][8] = %iw6_dog_alertidle_runin_2;
	var_00["run_stop"]["casual"] = [];
	var_00["run_stop"]["casual"][0] = %iw6_dog_casualidle_runin_2;
	var_00["run_stop"]["casual"][1] = %iw6_dog_casualidle_runin_1;
	var_00["run_stop"]["casual"][2] = %iw6_dog_casualidle_runin_4;
	var_00["run_stop"]["casual"][3] = %iw6_dog_casualidle_runin_7;
	var_00["run_stop"]["casual"][4] = %iw6_dog_casualidle_runin_8;
	var_00["run_stop"]["casual"][5] = %iw6_dog_casualidle_runin_9;
	var_00["run_stop"]["casual"][6] = %iw6_dog_casualidle_runin_6;
	var_00["run_stop"]["casual"][7] = %iw6_dog_casualidle_runin_3;
	var_00["run_stop"]["casual"][8] = %iw6_dog_casualidle_runin_2;
	var_00["run_stop"]["sneak"] = [];
	var_00["run_stop"]["sneak"][4] = %iw6_dog_sneak_runin_8;
	var_00["sharp_turn"] = [];
	var_00["sharp_turn"][0] = %iw6_dog_run_turn_2;
	var_00["sharp_turn"][1] = %iw6_dog_run_turn_3;
	var_00["sharp_turn"][2] = %iw6_dog_run_turn_6;
	var_00["sharp_turn"][3] = %iw6_dog_run_turn_9;
	var_00["sharp_turn"][5] = %iw6_dog_run_turn_7;
	var_00["sharp_turn"][6] = %iw6_dog_run_turn_4;
	var_00["sharp_turn"][7] = %iw6_dog_run_turn_1;
	var_00["sharp_turn"][8] = %iw6_dog_run_turn_2;
	var_00["quick_sharp_turn"] = [];
	var_00["quick_sharp_turn"][0] = %iw6_dog_run_quickturn_2;
	var_00["quick_sharp_turn"][1] = %iw6_dog_run_quickturn_3;
	var_00["quick_sharp_turn"][2] = %iw6_dog_run_quickturn_6;
	var_00["quick_sharp_turn"][3] = %iw6_dog_run_quickturn_9;
	var_00["quick_sharp_turn"][5] = %iw6_dog_run_quickturn_7;
	var_00["quick_sharp_turn"][6] = %iw6_dog_run_quickturn_4;
	var_00["quick_sharp_turn"][7] = %iw6_dog_run_quickturn_1;
	var_00["quick_sharp_turn"][8] = %iw6_dog_run_quickturn_2;
	var_00["sniff_turn"][2] = %iw6_dog_sniff_turn_6;
	var_00["sniff_turn"][6] = %iw6_dog_sniff_turn_4;
	level.archetypes["dog"]["move"] = var_00;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: exit_node.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 245 ms
 * Timestamp: 4/22/2024 2:00:28 AM
*******************************************************************/

//Function Number: 1
startmovetransition()
{
	if(isdefined(self.custommovetransition))
	{
		custommovetransition();
		return;
	}

	self endon("killanimscript");
	if(!checktransitionpreconditions())
	{
		return;
	}

	var_00 = self.origin;
	var_01 = self.angles[1];
	var_02 = "exposed";
	var_03 = 0;
	var_04 = getexitnode();
	if(isdefined(var_04))
	{
		var_05 = determinenodeexittype(var_04);
		if(isdefined(var_05))
		{
			var_02 = var_05;
			var_03 = 1;
			if(isdefined(self.heat))
			{
				var_02 = determineheatcoverexittype(var_04,var_02);
			}

			if(!isdefined(level.exposedtransition[var_02]) && var_02 != "stand_unstable" && var_02 != "stand_unstable_run" && var_02 != "stand_saw" && var_02 != "crouch_saw")
			{
				var_06 = animscripts\utility::absangleclamp180(self.angles[1] - animscripts\utility::getnodeforwardyaw(var_04));
				if(var_06 < 5)
				{
					if(!isdefined(self.heat))
					{
						var_00 = var_04.origin;
					}

					var_01 = animscripts\utility::getnodeforwardyaw(var_04);
				}
			}
		}
	}

	if(!checktransitionconditions(var_02,var_04))
	{
		return;
	}

	var_07 = isdefined(level.exposedtransition[var_02]);
	if(!var_03)
	{
		var_02 = determinenonnodeexittype();
	}

	var_08 = (-1 * self.lookaheaddir[0],-1 * self.lookaheaddir[1],0);
	var_09 = getmaxdirectionsandexcludedirfromapproachtype(var_04);
	var_0A = var_09.maxdirections;
	var_0B = var_09.excludedir;
	var_0C = spawnstruct();
	calculatenodetransitionangles(var_0C,var_02,0,var_01,var_08,var_0A,var_0B);
	sortnodetransitionangles(var_0C,var_0A);
	var_0D = -1;
	var_0E = 3;
	if(var_07)
	{
		var_0E = 1;
	}

	for(var_0F = 1;var_0F <= var_0E;var_0F++)
	{
		var_0D = var_0C.transindex[var_0F];
		if(checknodeexitpos(var_00,var_01,var_02,var_07,var_0D))
		{
			break;
		}
	}

	if(var_0F > var_0E)
	{
		return;
	}

	var_10 = distancesquared(self.origin,self.coverexitpos) * 1.25 * 1.25;
	if(distancesquared(self.origin,self.pathgoalpos) < var_10)
	{
		return;
	}

	donodeexitanimation(var_02,var_0D);
}

//Function Number: 2
determinenodeexittype(param_00)
{
	if(animscripts\utility::is_free_running() && param_00.type == "Cover Crouch")
	{
		return "free_run_out_of_cover_crouch";
	}

	if(animscripts\cover_arrival::canusesawapproach(param_00))
	{
		if(param_00.type == "Cover Stand")
		{
			return "stand_saw";
		}

		if(param_00.type == "Cover Crouch")
		{
			return "crouch_saw";
		}
		else if(param_00.type == "Cover Prone")
		{
			return "prone_saw";
		}
	}

	if(!isdefined(level.approach_types[param_00.type]))
	{
		return;
	}

	if(isdefined(level.requiredexitstance[param_00.type]) && level.requiredexitstance[param_00.type] != self.a.pose)
	{
		return;
	}

	var_01 = self.a.pose;
	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	var_02 = level.approach_types[param_00.type][var_01];
	if(animscripts\cover_arrival::usereadystand() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(animscripts\utility::isunstableground())
	{
		if(var_02 == "exposed")
		{
			var_02 = "exposed_unstable";
			if(self.movemode == "run")
			{
				var_02 = var_02 + "_run";
			}

			return var_02;
		}
		else if(var_02 == "stand")
		{
			var_02 = "stand_unstable";
			if(self.movemode == "run")
			{
				var_02 = var_02 + "_run";
			}

			return var_02;
		}
	}

	if(animscripts\utility::shouldcqb())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.archetypes["soldier"]["cover_exit"][var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 3
checktransitionpreconditions()
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	if(!self shouldfacemotion())
	{
		return 0;
	}

	if(self.a.pose == "prone")
	{
		return 0;
	}

	if(isdefined(self.disableexits) && self.disableexits)
	{
		return 0;
	}

	if(self.stairsstate != "none")
	{
		return 0;
	}

	if(!self isstanceallowed("stand") && !isdefined(self.heat))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.pathgoalpos) < 10000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
checktransitionconditions(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "exposed" || isdefined(self.heat))
	{
		if(self.a.pose != "stand" && self.a.pose != "crouch")
		{
			return 0;
		}

		if(self.a.movement != "stop")
		{
			return 0;
		}
	}

	if(!isdefined(self.heat) && isdefined(self.enemy) && vectordot(self.lookaheaddir,self.enemy.origin - self.origin) < 0)
	{
		if(animscripts\utility::canseeenemyfromexposed() && distancesquared(self.origin,self.enemy.origin) < 90000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 5
determinenonnodeexittype(param_00)
{
	if(self.a.pose == "stand")
	{
		param_00 = "exposed";
	}
	else
	{
		param_00 = "exposed_crouch";
	}

	if(animscripts\cover_arrival::usereadystand())
	{
		param_00 = "exposed_ready";
	}

	if(param_00 == "exposed" && animscripts\utility::isunstableground())
	{
		param_00 = "exposed_unstable";
		if(self.movemode == "run")
		{
			param_00 = param_00 + "_run";
		}

		return param_00;
	}

	if(animscripts\utility::shouldcqb())
	{
		param_00 = param_00 + "_cqb";
	}
	else if(isdefined(self.heat))
	{
		param_00 = "heat";
	}

	return param_00;
}

//Function Number: 6
getmaxdirectionsandexcludedirfromapproachtype(param_00)
{
	var_01 = spawnstruct();
	if(isdefined(param_00) && isdefined(level.maxdirections[param_00.type]))
	{
		var_01.maxdirections = level.maxdirections[param_00.type];
		var_01.excludedir = level.excludedir[param_00.type];
	}
	else
	{
		var_01.maxdirections = 9;
		var_01.excludedir = -1;
	}

	return var_01;
}

//Function Number: 7
calculatenodetransitionangles(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00.transitions = [];
	param_00.transindex = [];
	var_07 = undefined;
	var_08 = 1;
	var_09 = 0;
	if(param_02)
	{
		var_07 = animscripts\utility::lookupanim("cover_trans_angles",param_01);
		var_08 = -1;
		var_09 = 0;
	}
	else
	{
		var_07 = animscripts\utility::lookupanim("cover_exit_angles",param_01);
		var_08 = 1;
		var_09 = 180;
	}

	for(var_0A = 1;var_0A <= param_05;var_0A++)
	{
		param_00.transindex[var_0A] = var_0A;
		if(var_0A == 5 || var_0A == param_06 || !isdefined(var_07[var_0A]))
		{
			param_00.transitions[var_0A] = -1.0003;
			continue;
		}

		var_0B = (0,param_03 + var_08 * var_07[var_0A] + var_09,0);
		var_0C = vectornormalize(anglestoforward(var_0B));
		param_00.transitions[var_0A] = vectordot(param_04,var_0C);
	}
}

//Function Number: 8
sortnodetransitionangles(param_00,param_01)
{
	for(var_02 = 2;var_02 <= param_01;var_02++)
	{
		var_03 = param_00.transitions[param_00.transindex[var_02]];
		var_04 = param_00.transindex[var_02];
		for(var_05 = var_02 - 1;var_05 >= 1;var_05--)
		{
			if(var_03 < param_00.transitions[param_00.transindex[var_05]])
			{
				break;
			}

			param_00.transindex[var_05 + 1] = param_00.transindex[var_05];
		}

		param_00.transindex[var_05 + 1] = var_04;
	}
}

//Function Number: 9
checknodeexitpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,param_01,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = animscripts\utility::lookuptransitionanim("cover_exit_dist",param_02,param_04);
	var_09 = var_06 * var_08[0];
	var_0A = var_07 * var_08[1];
	var_0B = param_00 + var_09 - var_0A;
	self.coverexitpos = var_0B;
	if(!param_03 && !self checkcoverexitposwithpath(var_0B))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(self.origin,var_0B))
	{
		return 0;
	}

	if(param_04 <= 6 || param_03)
	{
		return 1;
	}

	var_0C = animscripts\utility::lookuptransitionanim("cover_exit_postdist",param_02,param_04);
	var_09 = var_06 * var_0C[0];
	var_0A = var_07 * var_0C[1];
	var_0D = var_0B + var_09 - var_0A;
	self.coverexitpos = var_0D;
	return self maymovefrompointtopoint(var_0B,var_0D);
}

//Function Number: 10
donodeexitanimation(param_00,param_01)
{
	var_02 = animscripts\utility::lookuptransitionanim("cover_exit",param_00,param_01);
	var_03 = vectortoangles(self.lookaheaddir);
	if(self.a.pose == "prone")
	{
		return;
	}

	var_04 = 0.2;
	if(self.swimmer)
	{
		self animmode("nogravity",0);
	}
	else
	{
		self animmode("zonly_physics",0);
	}

	self orientmode("face angle",self.angles[1]);
	self setflaggedanimknoballrestart("coverexit",var_02,%body,1,var_04,self.movetransitionrate);
	animscripts\shared::donotetracks("coverexit");
	self.a.pose = "stand";
	self.a.movement = "run";
	self.ignorepathchange = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	finishcoverexitnotetracks("coverexit");
	self clearanim(%animscript_root,0.2);
	self orientmode("face default");
	self animmode("normal",0);
}

//Function Number: 11
finishcoverexitnotetracks(param_00)
{
	self endon("move_loop_restart");
	animscripts\shared::donotetracks(param_00);
}

//Function Number: 12
determineheatcoverexittype(param_00,param_01)
{
	if(param_00.type == "Cover Right")
	{
		param_01 = "heat_right";
	}
	else if(param_00.type == "Cover Left")
	{
		param_01 = "heat_left";
	}

	return param_01;
}

//Function Number: 13
getexitnode()
{
	var_00 = undefined;
	if(!isdefined(self.heat))
	{
		var_01 = 400;
	}
	else
	{
		var_01 = 4096;
	}

	if(animscripts\utility::isspaceai())
	{
		var_01 = 1024;
	}

	if(isdefined(self.node) && distancesquared(self.origin,self.node.origin) < var_01)
	{
		var_00 = self.node;
	}
	else if(isdefined(self.prevnode) && distancesquared(self.origin,self.prevnode.origin) < var_01)
	{
		var_00 = self.prevnode;
	}

	if(isdefined(var_00) && isdefined(self.heat) && animscripts\utility::absangleclamp180(self.angles[1] - var_00.angles[1]) > 30)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 14
custommovetransition()
{
	var_00 = self.custommovetransition;
	if(!isdefined(self.permanentcustommovetransition))
	{
		self.custommovetransition = undefined;
	}

	var_01 = [[ var_00 ]]();
	if(!isdefined(self.permanentcustommovetransition))
	{
		self.startmovetransitionanim = undefined;
	}

	if(!isdefined(var_01))
	{
		var_01 = 0.2;
	}

	self clearanim(%animscript_root,var_01);
	self orientmode("face default");
	self animmode("none",0);
}

//Function Number: 15
debug_arrival(param_00)
{
	if(!animscripts\cover_arrival::debug_arrivals_on_actor())
	{
	}
}
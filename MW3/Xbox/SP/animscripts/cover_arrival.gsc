/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_arrival.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 49
 * Decompile Time: 813 ms
 * Timestamp: 10/27/2023 2:30:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("abort_approach");
	var_00 = self.approachnumber;
	var_01 = level.covertrans[self.approachtype][var_00];
	if(!isdefined(self.heat))
	{
		thread abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts/shared::donotetracks("coverArrival",::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.var_911 = var_02;
	}

	self.a.movement = "stop";
	self.a.var_CCA = self.approachtype;
	self clearanim(%root,0.3);
	self.lastapproachaborttime = undefined;
}

//Function Number: 2
handlestartaim(param_00)
{
	if(param_00 == "start_aim")
	{
		if(self.a.var_911 == "stand")
		{
			animscripts/animset::set_animarray_standing();
		}
		else if(self.a.var_911 == "crouch")
		{
			animscripts/animset::set_animarray_crouching();
		}
		else
		{
		}

		animscripts/combat::set_aim_and_turn_limits();
		self.previouspitchdelta = 0;
		animscripts/combat_utility::setupaim(0);
		thread animscripts/track::trackshootentorpos();
	}
}

//Function Number: 3
isthreatenedbyenemy()
{
	if(!isdefined(self.node))
	{
		return 0;
	}

	if(isdefined(self.enemy) && self seerecently(self.enemy,1.5) && distancesquared(self.origin,self.enemy.origin) < 250000)
	{
		return !self iscovervalidagainstenemy();
	}

	return 0;
}

//Function Number: 4
abortapproachifthreatened()
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.node))
		{
			return;
		}

		if(isthreatenedbyenemy())
		{
			self clearanim(%root,0.3);
			self notify("abort_approach");
			self.lastapproachaborttime = gettime();
			return;
		}

		wait 0.1;
	}
}

//Function Number: 5
func_0D56(param_00)
{
	if(isdefined(self.heat))
	{
		return 0;
	}

	if(param_00 == "left" || param_00 == "left_crouch")
	{
		return 90;
	}
	else if(param_00 == "right" || param_00 == "right_crouch")
	{
		return -90;
	}

	return 0;
}

//Function Number: 6
canusesawapproach(param_00)
{
	if(!animscripts/utility::usingmg())
	{
		return 0;
	}

	if(!isdefined(param_00.turretinfo))
	{
		return 0;
	}

	if(param_00.type != "Cover Stand" && param_00.type != "Cover Prone" && param_00.type != "Cover Crouch")
	{
		return 0;
	}

	if(isdefined(self.enemy) && distancesquared(self.enemy.origin,param_00.origin) < 65536)
	{
		return 0;
	}

	if(animscripts/utility::getnodeyawtoenemy() > 40 || animscripts/utility::getnodeyawtoenemy() < -40)
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
determinenodeapproachtype(param_00)
{
	if(canusesawapproach(param_00))
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

	if(isdefined(param_00.arrivalstance))
	{
		var_01 = param_00.arrivalstance;
	}
	else
	{
		var_01 = var_01 gethighestnodestance();
	}

	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	var_02 = level.approach_types[param_00.type][var_01];
	if(use_readystand() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(animscripts/utility::shouldcqb())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.covertrans[var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 8
determinenodeexittype(param_00)
{
	if(canusesawapproach(param_00))
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

	if(isdefined(level.var_D5D[param_00.type]) && level.var_D5D[param_00.type] != self.a.var_911)
	{
		return;
	}

	var_01 = self.a.var_911;
	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	var_02 = level.approach_types[param_00.type][var_01];
	if(use_readystand() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(animscripts/utility::shouldcqb())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.coverexit[var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 9
determineexposedapproachtype(param_00)
{
	if(isdefined(self.heat))
	{
		return "heat";
	}

	if(isdefined(param_00.arrivalstance))
	{
		var_01 = param_00.arrivalstance;
	}
	else
	{
		var_01 = var_01 gethighestnodestance();
	}

	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	if(var_01 == "crouch")
	{
		var_02 = "exposed_crouch";
	}
	else
	{
		var_02 = "exposed";
	}

	if(var_02 == "exposed" && use_readystand())
	{
		var_02 = var_02 + "_ready";
	}

	if(animscripts/utility::shouldcqb())
	{
		return var_02 + "_cqb";
	}

	return var_02;
}

//Function Number: 10
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

//Function Number: 11
shouldapproachtoexposed(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(animscripts/combat_utility::needtoreload(0.5))
	{
		return 0;
	}

	if(animscripts/utility::issuppressedwrapper())
	{
		return 0;
	}

	if(isdefined(level.exposedtransition[param_00]))
	{
		return 0;
	}

	if(param_00 == "left_crouch" || param_00 == "right_crouch")
	{
		return 0;
	}

	return animscripts/utility::canseepointfromexposedatnode(self.enemy getshootatpos(),self.node);
}

//Function Number: 12
func_0D66(param_00,param_01)
{
	var_02 = anglestoright(param_00);
	var_03 = anglestoforward(param_00);
	return var_03 * param_01[0] + var_02 * 0 - param_01[1];
}

//Function Number: 13
getapproachent()
{
	if(isdefined(self.scriptedarrivalent))
	{
		return self.scriptedarrivalent;
	}

	if(isdefined(self.node))
	{
		return self.node;
	}

	return undefined;
}

//Function Number: 14
getapproachpoint(param_00,param_01)
{
	if(param_01 == "stand_saw")
	{
		var_02 = (param_00.turretinfo.origin[0],param_00.turretinfo.origin[1],param_00.origin[2]);
		var_03 = anglestoforward((0,param_00.turretinfo.angles[1],0));
		var_04 = anglestoright((0,param_00.turretinfo.angles[1],0));
		var_02 = var_02 + var_03 * -32.545 - var_04 * 6.899;
	}
	else if(var_02 == "crouch_saw")
	{
		var_02 = (param_01.turretinfo.origin[0],param_01.turretinfo.origin[1],param_01.origin[2]);
		var_03 = anglestoforward((0,param_00.turretinfo.angles[1],0));
		var_04 = anglestoright((0,param_00.turretinfo.angles[1],0));
		var_02 = var_02 + var_03 * -32.545 - var_04 * 6.899;
	}
	else if(var_02 == "prone_saw")
	{
		var_02 = (param_01.turretinfo.origin[0],param_01.turretinfo.origin[1],param_01.origin[2]);
		var_03 = anglestoforward((0,param_00.turretinfo.angles[1],0));
		var_04 = anglestoright((0,param_00.turretinfo.angles[1],0));
		var_02 = var_02 + var_03 * -37.36 - var_04 * 13.279;
	}
	else if(isdefined(self.scriptedarrivalent))
	{
		var_02 = self.goalpos;
	}
	else
	{
		var_02 = param_01.origin;
	}

	return var_02;
}

//Function Number: 15
checkapproachpreconditions()
{
	if(isdefined(self getnegotiationstartnode()))
	{
		return 0;
	}

	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
checkapproachconditions(param_00,param_01,param_02)
{
	if(isdefined(level.exposedtransition[param_00]))
	{
		return 0;
	}

	if(param_00 == "stand" || param_00 == "crouch")
	{
		if(animscripts/utility::absangleclamp180(vectortoyaw(param_01) - param_02.angles[1] + 180) < 60)
		{
			return 0;
		}
	}

	if(isthreatenedbyenemy() || isdefined(self.lastapproachaborttime) && self.lastapproachaborttime + 500 > gettime())
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_0C94(param_00)
{
	self endon("killanimscript");
	if(isdefined(self.heat))
	{
		thread dolastminuteexposedapproachwrapper();
		return;
	}

	if(param_00)
	{
		self.requestarrivalnotify = 1;
	}

	self.a.var_CCA = undefined;
	thread dolastminuteexposedapproachwrapper();
	self waittill("cover_approach",var_01);
	if(!checkapproachpreconditions())
	{
		return;
	}

	thread func_0C94(0);
	var_02 = "exposed";
	var_03 = self.pathgoalpos;
	var_04 = vectortoyaw(var_01);
	var_05 = var_04;
	var_06 = getapproachent();
	if(isdefined(var_06))
	{
		var_02 = determinenodeapproachtype(var_06);
		if(isdefined(var_02) && var_02 != "exposed")
		{
			var_03 = getapproachpoint(var_06,var_02);
			var_04 = var_06.angles[1];
			var_05 = animscripts/utility::getnodeforwardyaw(var_06);
		}
	}
	else if(use_readystand())
	{
		if(animscripts/utility::shouldcqb())
		{
			var_02 = "exposed_ready_cqb";
		}
		else
		{
			var_02 = "exposed_ready";
		}
	}

	if(!checkapproachconditions(var_02,var_01,var_06))
	{
		return;
	}

	startcoverapproach(var_02,var_03,var_04,var_05,var_01);
}

//Function Number: 18
coverapproachlastminutecheck(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	if(abs(self getmotionangle()) > 45 && isdefined(self.enemy) && vectordot(anglestoforward(self.angles),vectornormalize(self.enemy.origin - self.origin)) > 0.8)
	{
		return 0;
	}

	if(self.a.var_911 != "stand" || self.a.movement != "run" && !animscripts/utility::iscqbwalkingorfacingenemy())
	{
		return 0;
	}

	if(animscripts/utility::absangleclamp180(param_04 - self.angles[1]) > 30)
	{
		if(isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536)
		{
			if(vectordot(anglestoforward(self.angles),self.enemy.origin - self.origin) > 0)
			{
				return 0;
			}
		}
	}

	if(!checkcoverenterpos(param_00,param_01,param_02,param_03,0))
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
approachwaittillclose(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			waitforpathgoalpos();
		}

		var_02 = distance(self.origin,self.pathgoalpos);
		if(var_02 <= param_01 + 8)
		{
			break;
		}

		var_03 = var_02 - param_01 / 250 - 0.1;
		if(var_03 < 0.05)
		{
			var_03 = 0.05;
		}

		wait var_03;
	}
}

//Function Number: 20
startcoverapproach(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("cover_approach");
	var_05 = getapproachent();
	var_06 = getmaxdirectionsandexcludedirfromapproachtype(var_05);
	var_07 = var_06.maxdirections;
	var_08 = var_06.excludedir;
	var_09 = vectordot(param_04,anglestoforward(var_05.angles)) >= 0;
	var_06 = checkarrivalenterpositions(param_01,param_03,param_00,param_04,var_07,var_08,var_09);
	if(var_06.approachnumber < 0)
	{
		return;
	}

	var_0A = var_06.approachnumber;
	if(level.newarrivals && var_0A <= 6 && var_09)
	{
		self endon("goal_changed");
		self.var_C98 = level.covertranslongestdist[param_00];
		approachwaittillclose(var_05,self.var_C98);
		var_0B = vectornormalize(param_01 - self.origin);
		var_06 = checkarrivalenterpositions(param_01,param_03,param_00,var_0B,var_07,var_08,var_09);
		self.var_C98 = length(level.covertransdist[param_00][var_0A]);
		approachwaittillclose(var_05,self.var_C98);
		if(!self maymovetopoint(param_01))
		{
			self.var_C98 = undefined;
			return;
		}

		if(var_06.approachnumber < 0)
		{
			self.var_C98 = undefined;
			return;
		}

		var_0A = var_06.approachnumber;
		var_0C = param_03 - level.var_D72[param_00][var_0A];
	}
	else
	{
		self setruntopos(self.var_D73);
		self waittill("runto_arrived");
		var_0C = param_04 - level.var_D72[param_01][var_0C];
		if(!coverapproachlastminutecheck(param_01,param_03,param_00,var_0A,var_0C))
		{
			return;
		}
	}

	self.approachnumber = var_0A;
	self.approachtype = param_00;
	self.var_C98 = undefined;
	self startcoverarrival(self.var_D73,var_0C);
}

//Function Number: 21
checkarrivalenterpositions(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	calculatenodetransitionangles(var_07,param_02,1,param_01,param_03,param_04,param_05);
	sortnodetransitionangles(var_07,param_04);
	var_08 = spawnstruct();
	var_09 = (0,0,0);
	var_08.approachnumber = -1;
	var_0A = 2;
	for(var_0B = 1;var_0B <= var_0A;var_0B++)
	{
		var_08.approachnumber = var_07.transindex[var_0B];
		if(!checkcoverenterpos(param_00,param_01,param_02,var_08.approachnumber,param_06))
		{
			continue;
		}

		break;
	}

	if(var_0B > var_0A)
	{
		var_08.approachnumber = -1;
		return var_08;
	}

	var_0C = distancesquared(param_00,self.origin);
	var_0D = distancesquared(param_00,self.var_D73);
	if(var_0C < var_0D * 2 * 2)
	{
		if(var_0C < var_0D)
		{
			var_08.approachnumber = -1;
			return var_08;
		}

		if(!level.newarrivals || !param_06)
		{
			var_0E = vectornormalize(self.var_D73 - self.origin);
			var_0F = param_01 - level.var_D72[param_02][var_08.approachnumber];
			var_10 = anglestoforward((0,var_0F,0));
			var_11 = vectordot(var_0E,var_10);
			if(var_11 < 0.707)
			{
				var_08.approachnumber = -1;
				return var_08;
			}
		}
	}

	return var_08;
}

//Function Number: 22
dolastminuteexposedapproachwrapper()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self notify("doing_last_minute_exposed_approach");
	self endon("doing_last_minute_exposed_approach");
	thread watchgoalchanged();
	for(;;)
	{
		func_0D7D();
		for(;;)
		{
			common_scripts\utility::waittill_any("goal_changed","goal_changed_previous_frame");
			if(isdefined(self.var_D73) && isdefined(self.pathgoalpos) && distance2d(self.var_D73,self.pathgoalpos) < 1)
			{
				continue;
			}

			break;
		}
	}
}

//Function Number: 23
watchgoalchanged()
{
	self endon("killanimscript");
	self endon("doing_last_minute_exposed_approach");
	for(;;)
	{
		self waittill("goal_changed");
		wait 0.05;
		self notify("goal_changed_previous_frame");
	}
}

//Function Number: 24
exposedapproachconditioncheck(param_00,param_01)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	if(isdefined(self.var_D79))
	{
		if(!self [[ self.var_D79 ]](param_00))
		{
			return 0;
		}
	}
	else
	{
		if(!self.facemotion && !isdefined(param_00) || param_00.type == "Path")
		{
			return 0;
		}

		if(self.a.var_911 != "stand")
		{
			return 0;
		}
	}

	if(isthreatenedbyenemy() || isdefined(self.lastapproachaborttime) && self.lastapproachaborttime + 500 > gettime())
	{
		return 0;
	}

	if(!self maymovetopoint(self.pathgoalpos))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
exposedapproachwaittillclose()
{
	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			waitforpathgoalpos();
		}

		var_00 = getapproachent();
		if(isdefined(var_00) && !isdefined(self.heat))
		{
			var_01 = var_00.origin;
		}
		else
		{
			var_01 = self.pathgoalpos;
		}

		var_02 = distance(self.origin,var_01);
		var_03 = level.longestexposedapproachdist;
		if(var_02 <= var_03 + 8)
		{
			break;
		}

		var_04 = var_02 - level.longestexposedapproachdist / 250 - 0.1;
		if(var_04 < 0)
		{
			break;
		}

		if(var_04 < 0.05)
		{
			var_04 = 0.05;
		}

		wait var_04;
	}
}

//Function Number: 26
faceenemyatendofapproach(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.heat) && isdefined(param_00))
	{
		return 0;
	}

	if(self.combatmode == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000)
	{
		return 0;
	}

	return sighttracepassed(self.enemy getshootatpos(),self.pathgoalpos + (0,0,60),0,undefined);
}

//Function Number: 27
func_0D7D()
{
	self endon("goal_changed");
	self endon("move_interrupt");
	if(isdefined(self getnegotiationstartnode()))
	{
		return;
	}

	exposedapproachwaittillclose();
	if(isdefined(self.grenade) && isdefined(self.grenade.activator) && self.grenade.activator == self)
	{
		return;
	}

	var_00 = "exposed";
	var_01 = 1;
	if(isdefined(self.var_D7E))
	{
		var_00 = self [[ self.var_D7E ]]();
	}
	else if(use_readystand())
	{
		if(animscripts/utility::shouldcqb())
		{
			var_00 = "exposed_ready_cqb";
		}
		else
		{
			var_00 = "exposed_ready";
		}
	}
	else if(animscripts/utility::shouldcqb())
	{
		var_00 = "exposed_cqb";
	}
	else if(isdefined(self.heat))
	{
		var_00 = "heat";
		var_01 = 4096;
	}

	var_02 = getapproachent();
	if(isdefined(var_02) && isdefined(self.pathgoalpos) && !isdefined(self.var_D7F))
	{
		var_03 = distancesquared(self.pathgoalpos,var_02.origin) < var_01;
	}
	else
	{
		var_03 = 0;
	}

	if(var_03)
	{
		var_00 = determineexposedapproachtype(var_02);
	}

	var_04 = vectornormalize(self.pathgoalpos - self.origin);
	var_05 = vectortoyaw(var_04);
	if(isdefined(self.faceenemyarrival))
	{
		var_05 = self.angles[1];
	}
	else if(faceenemyatendofapproach(var_02))
	{
		var_05 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
	}
	else
	{
		var_06 = isdefined(var_02) && var_03;
		var_06 = var_06 && var_02.type != "Path" && var_02.type != "Ambush" || !animscripts/utility::recentlysawenemy();
		if(var_06)
		{
			var_05 = animscripts/utility::getnodeforwardyaw(var_02);
		}
		else
		{
			var_07 = self getanglestolikelyenemypath();
			if(isdefined(var_07))
			{
				var_05 = var_07[1];
			}
		}
	}

	var_08 = spawnstruct();
	calculatenodetransitionangles(var_08,var_00,1,var_05,var_04,9,-1);
	var_09 = 1;
	for(var_0A = 2;var_0A <= 9;var_0A++)
	{
		if(var_08.transitions[var_0A] > var_08.transitions[var_09])
		{
			var_09 = var_0A;
		}
	}

	self.approachnumber = var_08.transindex[var_09];
	self.approachtype = var_00;
	var_0B = level.covertrans[var_00][self.approachnumber];
	var_0C = length(level.covertransdist[var_00][self.approachnumber]);
	var_0D = var_0C + 8;
	var_0D = var_0D * var_0D;
	while(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > var_0D)
	{
		wait 0.05;
	}

	if(isdefined(self.var_C98) && self.var_C98 < var_0C + 8)
	{
		return;
	}

	if(!exposedapproachconditioncheck(var_02,var_03))
	{
		return;
	}

	var_0E = distance(self.origin,self.pathgoalpos);
	if(abs(var_0E - var_0C) > 8)
	{
		return;
	}

	var_0F = vectortoyaw(self.pathgoalpos - self.origin);
	if(isdefined(self.heat) && var_03)
	{
		var_10 = var_05 - level.var_D72[var_00][self.approachnumber];
		var_11 = getarrivalstartpos(self.pathgoalpos,var_05,var_00,self.approachnumber);
	}
	else if(var_0E > 0)
	{
		var_12 = level.covertransdist[var_02][self.approachnumber];
		var_13 = atan(var_12[1] / var_12[0]);
		if(!isdefined(self.faceenemyarrival) || self.facemotion)
		{
			var_10 = var_0F - var_13;
			if(animscripts/utility::absangleclamp180(var_10 - self.angles[1]) > 30)
			{
				return;
			}
		}
		else
		{
			var_10 = self.angles[1];
		}

		var_14 = var_0E - var_0C;
		var_11 = self.origin + vectornormalize(self.pathgoalpos - self.origin) * var_14;
	}
	else
	{
		var_10 = self.angles[1];
		var_11 = self.origin;
	}

	self startcoverarrival(var_11,var_10);
}

//Function Number: 28
waitforpathgoalpos()
{
	for(;;)
	{
		if(isdefined(self.pathgoalpos))
		{
			return;
		}

		wait 0.1;
	}
}

//Function Number: 29
startmovetransitionpreconditions()
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	if(!self shouldfacemotion())
	{
		return 0;
	}

	if(self.a.var_911 == "prone")
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

//Function Number: 30
startmovetransitionconditions(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "exposed" || isdefined(self.heat))
	{
		if(self.a.var_911 != "stand" && self.a.var_911 != "crouch")
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
		if(animscripts/utility::func_B35() && distancesquared(self.origin,self.enemy.origin) < 90000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 31
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

	if(isdefined(self.node) && distancesquared(self.origin,self.node.origin) < var_01)
	{
		var_00 = self.node;
	}
	else if(isdefined(self.prevnode) && distancesquared(self.origin,self.prevnode.origin) < var_01)
	{
		var_00 = self.prevnode;
	}

	if(isdefined(var_00) && isdefined(self.heat) && animscripts/utility::absangleclamp180(self.angles[1] - var_00.angles[1]) > 30)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 32
custommovetransitionfunc()
{
	if(!isdefined(self.startmovetransitionanim))
	{
		return;
	}

	self animmode("zonly_physics",0);
	self orientmode("face current");
	self setflaggedanimknoballrestart("move",self.startmovetransitionanim,%root,1);
	if(animhasnotetrack(self.startmovetransitionanim,"code_move"))
	{
		animscripts/shared::donotetracks("move");
		self orientmode("face motion");
		self animmode("none",0);
	}

	animscripts/shared::donotetracks("move");
}

//Function Number: 33
determinenonnodeexittype(param_00)
{
	if(self.a.var_911 == "stand")
	{
		param_00 = "exposed";
	}
	else
	{
		param_00 = "exposed_crouch";
	}

	if(use_readystand())
	{
		param_00 = "exposed_ready";
	}

	if(animscripts/utility::shouldcqb())
	{
		param_00 = param_00 + "_cqb";
	}
	else if(isdefined(self.heat))
	{
		param_00 = "heat";
	}

	return param_00;
}

//Function Number: 34
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

//Function Number: 35
startmovetransition()
{
	if(isdefined(self.var_D8B))
	{
		var_00 = self.var_D8B;
		if(!isdefined(self.permanentcustommovetransition))
		{
			self.var_D8B = undefined;
		}

		[[ var_00 ]]();
		if(!isdefined(self.permanentcustommovetransition))
		{
			self.startmovetransitionanim = undefined;
		}

		self clearanim(%root,0.2);
		self orientmode("face default");
		self animmode("none",0);
		return;
	}

	self endon("killanimscript");
	if(!startmovetransitionpreconditions())
	{
		return;
	}

	var_01 = self.origin;
	var_02 = self.angles[1];
	var_03 = "exposed";
	var_04 = 0;
	var_05 = getexitnode();
	if(isdefined(var_05))
	{
		var_06 = determinenodeexittype(var_05);
		if(isdefined(var_06))
		{
			var_03 = var_06;
			var_04 = 1;
			if(isdefined(self.heat))
			{
				var_03 = determineheatcoverexittype(var_05,var_03);
			}

			if(!isdefined(level.exposedtransition[var_03]) && var_03 != "stand_saw" && var_03 != "crouch_saw")
			{
				var_07 = animscripts/utility::absangleclamp180(self.angles[1] - animscripts/utility::getnodeforwardyaw(var_05));
				if(var_07 < 5)
				{
					if(!isdefined(self.heat))
					{
						var_01 = var_05.origin;
					}

					var_02 = animscripts/utility::getnodeforwardyaw(var_05);
				}
			}
		}
	}

	if(!startmovetransitionconditions(var_03,var_05))
	{
		return;
	}

	var_08 = isdefined(level.exposedtransition[var_03]);
	if(!var_04)
	{
		var_03 = determinenonnodeexittype();
	}

	var_09 = (-1 * self.lookaheaddir[0],-1 * self.lookaheaddir[1],0);
	var_0A = getmaxdirectionsandexcludedirfromapproachtype(var_05);
	var_0B = var_0A.maxdirections;
	var_0C = var_0A.excludedir;
	var_0D = spawnstruct();
	calculatenodetransitionangles(var_0D,var_03,0,var_02,var_09,var_0B,var_0C);
	sortnodetransitionangles(var_0D,var_0B);
	var_0E = -1;
	var_0F = 3;
	if(var_08)
	{
		var_0F = 1;
	}

	for(var_10 = 1;var_10 <= var_0F;var_10++)
	{
		var_0E = var_0D.transindex[var_10];
		if(checkcoverexitpos(var_01,var_02,var_03,var_08,var_0E))
		{
			break;
		}
	}

	if(var_10 > var_0F)
	{
		return;
	}

	var_11 = distancesquared(self.origin,self.coverexitpos) * 1.25 * 1.25;
	if(distancesquared(self.origin,self.pathgoalpos) < var_11)
	{
		return;
	}

	docoverexitanimation(var_03,var_0E);
}

//Function Number: 36
func_0D8E(param_00)
{
	if(!isdefined(param_00))
	{
		return "{undefined}";
	}

	return param_00;
}

//Function Number: 37
docoverexitanimation(param_00,param_01)
{
	var_02 = level.coverexit[param_00][param_01];
	var_03 = vectortoangles(self.lookaheaddir);
	if(self.a.var_911 == "prone")
	{
		return;
	}

	var_05 = 0.2;
	self animmode("zonly_physics",0);
	self orientmode("face angle",self.angles[1]);
	self setflaggedanimknoballrestart("coverexit",var_02,%body,1,var_05,self.movetransitionrate);
	animscripts/shared::donotetracks("coverexit");
	self.a.var_911 = "stand";
	self.a.movement = "run";
	self.ignorepathchange = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	finishcoverexitnotetracks("coverexit");
	self clearanim(%root,0.2);
	self orientmode("face default");
	self animmode("normal",0);
}

//Function Number: 38
finishcoverexitnotetracks(param_00)
{
	self endon("move_loop_restart");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 39
drawvec(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_02 * 100;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 40
drawapproachvec(param_00)
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.node))
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 41
calculatenodetransitionangles(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00.transitions = [];
	param_00.transindex = [];
	var_07 = undefined;
	var_08 = 1;
	var_09 = 0;
	if(param_02)
	{
		var_07 = level.var_D72[param_01];
		var_08 = -1;
		var_09 = 0;
	}
	else
	{
		var_07 = level.coverexitangles[param_01];
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

//Function Number: 42
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

//Function Number: 43
checkcoverexitpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,param_01,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = var_06 * level.coverexitdist[param_02][param_04][0];
	var_09 = var_07 * level.coverexitdist[param_02][param_04][1];
	var_0A = param_00 + var_08 - var_09;
	self.coverexitpos = var_0A;
	if(!param_03 && !self checkcoverexitposwithpath(var_0A))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(self.origin,var_0A))
	{
		return 0;
	}

	if(param_04 <= 6 || param_03)
	{
		return 1;
	}

	var_08 = var_06 * level.var_D98[param_02][param_04][0];
	var_09 = var_07 * level.var_D98[param_02][param_04][1];
	var_0B = var_0A + var_08 - var_09;
	self.coverexitpos = var_0B;
	return self maymovefrompointtopoint(var_0A,var_0B);
}

//Function Number: 44
getarrivalstartpos(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - level.var_D72[param_02][param_03],0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = var_05 * level.covertransdist[param_02][param_03][0];
	var_08 = var_06 * level.covertransdist[param_02][param_03][1];
	return param_00 - var_07 + var_08;
}

//Function Number: 45
getarrivalprestartpos(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - level.var_D72[param_02][param_03],0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = var_05 * level.var_D9B[param_02][param_03][0];
	var_08 = var_06 * level.var_D9B[param_02][param_03][1];
	return param_00 - var_07 + var_08;
}

//Function Number: 46
checkcoverenterpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getarrivalstartpos(param_00,param_01,param_02,param_03);
	self.var_D73 = var_05;
	if(level.newarrivals && param_03 <= 6 && param_04)
	{
		return 1;
	}

	if(!self maymovefrompointtopoint(var_05,param_00))
	{
		return 0;
	}

	if(param_03 <= 6 || isdefined(level.exposedtransition[param_02]))
	{
		return 1;
	}

	var_06 = getarrivalprestartpos(var_05,param_01,param_02,param_03);
	self.var_D73 = var_06;
	return self maymovefrompointtopoint(var_06,var_05);
}

//Function Number: 47
use_readystand()
{
	if(!isdefined(level.readystand_anims_inited))
	{
		return 0;
	}

	if(!level.readystand_anims_inited)
	{
		return 0;
	}

	if(!isdefined(self.busereadyidle))
	{
		return 0;
	}

	if(!self.busereadyidle)
	{
		return 0;
	}

	return 1;
}

//Function Number: 48
debug_arrivals_on_actor()
{
	return 0;
}

//Function Number: 49
debug_arrival(param_00)
{
	if(!debug_arrivals_on_actor())
	{
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_arrival.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 614 ms
 * Timestamp: 10/27/2023 2:43:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("abort_approach");
	if(self.swimmer)
	{
		animscripts\swim::swim_coverarrival_main();
		return;
	}

	if(isdefined(self.customarrivalfunc))
	{
		[[ self.customarrivalfunc ]]();
		return;
	}

	var_00 = self.approachnumber;
	var_01 = animscripts\utility::lookupanim("cover_trans",self.approachtype)[var_00];
	if(!isdefined(self.heat))
	{
		thread abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts\face::playfacialanim(var_01,"run");
	animscripts\shared::donotetracks("coverArrival",::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	self clearanim(%animscript_root,0.2);
	self.lastapproachaborttime = undefined;
}

//Function Number: 2
handlestartaim(param_00)
{
	if(param_00 == "start_aim")
	{
		if(isdefined(self.a.dontstartaim) && self.a.dontstartaim)
		{
			return;
		}

		if(self.a.pose == "stand")
		{
			animscripts\animset::set_animarray_standing();
		}
		else if(self.a.pose == "crouch")
		{
			animscripts\animset::set_animarray_crouching();
		}
		else
		{
		}

		animscripts\combat::set_aim_and_turn_limits();
		self.previouspitchdelta = 0;
		animscripts\combat_utility::setupaim(0.2);
		thread animscripts\track::trackshootentorpos();
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
			self clearanim(%animscript_root,0.3);
			self notify("abort_approach");
			self.lastapproachaborttime = gettime();
			return;
		}

		wait(0.1);
	}
}

//Function Number: 5
canusesawapproach(param_00)
{
	if(!animscripts\utility::usingmg())
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

	if(animscripts\utility::getnodeyawtoenemy() > 40 || animscripts\utility::getnodeyawtoenemy() < -40)
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
determinenodeapproachtype(param_00)
{
	if(isdefined(self.mech) && self.mech)
	{
		return "exposed";
	}

	var_01 = param_00.type;
	if(animscripts\utility::is_free_running() && var_01 == "Cover Crouch")
	{
		return "free_run_into_cover_crouch";
	}

	if(var_01 == "Cover Multi")
	{
		if(!isdefined(self.cover))
		{
			self.cover = spawnstruct();
		}

		var_02 = animscripts\cover_multi::covermulti_getbestvaliddir(["over",["left","right"]]);
		self.cover.arrivalnodetype = var_02;
		var_03 = animscripts\cover_multi::covermulti_getstatefromdir(param_00,var_02);
		var_01 = animscripts\utility::getcovermultipretendtype(param_00,var_03);
	}

	if(canusesawapproach(param_00))
	{
		if(var_01 == "Cover Stand")
		{
			return "stand_saw";
		}

		if(var_01 == "Cover Crouch")
		{
			return "crouch_saw";
		}
		else if(var_01 == "Cover Prone")
		{
			return "prone_saw";
		}
	}

	if(!isdefined(level.approach_types[var_01]))
	{
		return;
	}

	if(isdefined(param_00.arrivalstance))
	{
		var_04 = param_00.arrivalstance;
	}
	else if(isdefined(var_01.classname) && var_01.classname == "script_origin")
	{
		var_04 = "stand";
	}
	else
	{
		var_04 = var_01 gethighestnodestance();
	}

	if(var_04 == "prone")
	{
		var_04 = "crouch";
	}

	var_05 = level.approach_types[var_01][var_04];
	if(usereadystand() && var_05 == "exposed")
	{
		var_05 = "exposed_ready";
	}

	if(animscripts\utility::isunstableground())
	{
		if(var_05 == "exposed")
		{
			var_05 = "exposed_unstable";
			if(self.movemode == "run")
			{
				var_05 = var_05 + "_run";
			}

			return var_05;
		}
		else if(var_05 == "stand")
		{
			var_05 = "stand_unstable";
			if(self.movemode == "run")
			{
				var_05 = var_05 + "_run";
			}

			return var_05;
		}
	}

	if(animscripts\utility::shouldcqb())
	{
		var_06 = var_05 + "_cqb";
		if(isdefined(level.archetypes["soldier"]["cover_trans"][var_06]))
		{
			var_05 = var_06;
		}
	}

	return var_05;
}

//Function Number: 7
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

	if(var_02 == "exposed" && usereadystand())
	{
		var_02 = var_02 + "_ready";
	}

	if(var_02 == "exposed" && animscripts\utility::isunstableground())
	{
		var_02 = "exposed_unstable";
		if(self.movemode == "run")
		{
			var_02 = var_02 + "_run";
		}

		return var_02;
	}

	if(animscripts\utility::shouldcqb())
	{
		return var_02 + "_cqb";
	}

	return var_02;
}

//Function Number: 8
calculatenodeoffsetfromanimationdelta(param_00,param_01)
{
	var_02 = anglestoright(param_00);
	var_03 = anglestoforward(param_00);
	return var_03 * param_01[0] + var_02 * 0 - param_01[1];
}

//Function Number: 9
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

//Function Number: 10
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

//Function Number: 11
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

//Function Number: 12
checkapproachconditions(param_00,param_01,param_02)
{
	if(isdefined(level.exposedtransition[param_00]))
	{
		return 0;
	}

	if(param_00 == "stand" || param_00 == "crouch" || param_00 == "stand_unstable")
	{
		if(animscripts\utility::absangleclamp180(vectortoyaw(param_01) - param_02.angles[1] + 180) < 60)
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

//Function Number: 13
setupapproachnode(param_00)
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

	if(self.swimmer == 1)
	{
		thread animscripts\swim::swim_setupapproach();
		return;
	}

	self.a.arrivaltype = undefined;
	thread dolastminuteexposedapproachwrapper();
	self waittill("cover_approach",var_01);
	if(!checkapproachpreconditions())
	{
		return;
	}

	thread setupapproachnode(0);
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
			var_05 = animscripts\utility::getnodeforwardyaw(var_06);
		}
	}
	else if(usereadystand())
	{
		if(animscripts\utility::shouldcqb())
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

//Function Number: 14
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

	if(self.a.pose != "stand" || self.a.movement != "run" && !animscripts\utility::iscqbwalkingorfacingenemy())
	{
		return 0;
	}

	if(animscripts\utility::absangleclamp180(param_04 - self.angles[1]) > 30)
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

//Function Number: 15
approachwaittillclose(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = undefined;
	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			waitforpathgoalpos();
		}

		var_04 = distance(self.origin,self.pathgoalpos);
		if(isdefined(param_02))
		{
			var_05 = calculateapproachdir();
			var_06 = calculatedesiredfacingyaw(var_05);
			var_07 = calculatelastminuteanimdistance(var_05,var_06,param_00,1,param_02.approachtype);
			var_08 = vectornormalize(param_02.approachpoint - self.origin);
			var_03 = checkarrivalenterpositions(param_02.approachpoint,param_02.approachfinalyaw,param_02.approachtype,var_08,param_02.maxdirections,param_02.excludedir,param_02.arrivalfromfront);
			if(var_03.approachnumber > 0)
			{
				param_01 = length(animscripts\utility::lookuptransitionanim("cover_trans_dist",param_02.approachtype,var_03.approachnumber));
			}
		}

		if(var_04 <= param_01 + 8)
		{
			break;
		}

		var_09 = self.moveplaybackrate;
		if(level.script == "scoutsniper" && self getanimweight(%h1_sprint_loop) > 0.5)
		{
			var_09 = var_09 * 1.25;
		}

		var_0A = var_04 - param_01 / 250 * var_09 - 0.1;
		if(var_0A < 0.05)
		{
			var_0A = 0.05;
		}

		wait(var_0A);
	}

	return var_03;
}

//Function Number: 16
startcoverapproach(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("cover_approach");
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return;
	}

	var_05 = getapproachent();
	var_06 = animscripts\exit_node::getmaxdirectionsandexcludedirfromapproachtype(var_05);
	var_07 = var_06.maxdirections;
	var_08 = var_06.excludedir;
	var_09 = vectordot(param_04,anglestoforward(var_05.angles)) >= 0;
	var_06 = checkarrivalenterpositions(param_01,param_03,param_00,param_04,var_07,var_08,var_09);
	if(var_06.approachnumber < 0)
	{
		return;
	}

	var_0A = var_06.approachnumber;
	if(var_0A <= 6 && var_09)
	{
		self endon("goal_changed");
		if(isdefined(self.animarchetype) && isdefined(level.archetypes[self.animarchetype]) && isdefined(level.archetypes[self.animarchetype]["CoverTransLongestDist"][param_00]))
		{
			self.arrivalstartdist = level.archetypes[self.animarchetype]["CoverTransLongestDist"][param_00];
		}
		else if(isdefined(level.archetypes["soldier"]["CoverTransLongestDist"][param_00]))
		{
			self.arrivalstartdist = level.archetypes["soldier"]["CoverTransLongestDist"][param_00];
		}
		else
		{
			self.arrivalstartdist = 8;
		}

		approachwaittillclose(var_05,self.arrivalstartdist);
		var_0B = vectornormalize(param_01 - self.origin);
		var_06 = checkarrivalenterpositions(param_01,param_03,param_00,var_0B,var_07,var_08,var_09);
		self.arrivalstartdist = length(animscripts\utility::lookuptransitionanim("cover_trans_dist",param_00,var_0A));
		var_0C = spawnstruct();
		var_0C.approachtype = param_00;
		var_0C.approachpoint = param_01;
		var_0C.arrivalfromfront = var_09;
		var_0C.excludedir = var_08;
		var_0C.maxdirections = var_07;
		var_0C.approachfinalyaw = param_03;
		var_06 = approachwaittillclose(var_05,self.arrivalstartdist,var_0C);
		if(!self maymovetopoint(param_01))
		{
			self.arrivalstartdist = undefined;
			return;
		}

		if(var_06.approachnumber < 0)
		{
			self.arrivalstartdist = undefined;
			return;
		}

		var_0A = var_06.approachnumber;
		var_0D = param_03 - animscripts\utility::lookuptransitionanim("cover_trans_angles",param_00,var_0A);
	}
	else
	{
		self setruntopos(self.coverenterpos);
		self waittill("runto_arrived");
		var_0D = param_04 - animscripts\utility::lookuptransitionanim("cover_trans_angles",param_01,var_0D);
		if(!coverapproachlastminutecheck(param_01,param_03,param_00,var_0A,var_0D))
		{
			return;
		}
	}

	self.approachnumber = var_0A;
	self.approachtype = param_00;
	self.arrivalstartdist = undefined;
	if(animscripts\utility::using_cover_transition_angle_correction())
	{
		self.arrivalanim = animscripts\utility::lookupanim("cover_trans",self.approachtype)[self.approachnumber];
		var_0E = animscripts\utility::lookuptransitionanim("cover_trans_move_end",param_00,self.approachnumber);
		self.arrivalangles = self method_8567(self.coverenterpos,var_0D,0,self.arrivalanim,var_0E);
		return;
	}

	self.arrivalangles = self startcoverarrival(self.coverenterpos,var_0D,0);
}

//Function Number: 17
checkarrivalenterpositions(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	animscripts\exit_node::calculatenodetransitionangles(var_07,param_02,1,param_01,param_03,param_04,param_05);
	animscripts\exit_node::sortnodetransitionangles(var_07,param_04);
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
	var_0D = distancesquared(param_00,self.coverenterpos);
	if(var_0C < var_0D * 2 * 2)
	{
		if(var_0C < var_0D)
		{
			var_08.approachnumber = -1;
			return var_08;
		}

		if(!param_06)
		{
			var_0E = vectornormalize(self.coverenterpos - self.origin);
			var_0F = param_01 - animscripts\utility::lookuptransitionanim("cover_trans_angles",param_02,var_08.approachnumber);
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

//Function Number: 18
dolastminuteexposedapproachwrapper()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self notify("doing_last_minute_exposed_approach");
	self endon("doing_last_minute_exposed_approach");
	thread watchgoalchanged();
	for(;;)
	{
		dolastminuteexposedapproach();
		for(;;)
		{
			common_scripts\utility::waittill_any("goal_changed","goal_changed_previous_frame");
			if(isdefined(self.coverenterpos) && isdefined(self.pathgoalpos) && distance2d(self.coverenterpos,self.pathgoalpos) < 1)
			{
				continue;
			}

			break;
		}
	}
}

//Function Number: 19
watchgoalchanged()
{
	self endon("killanimscript");
	self endon("doing_last_minute_exposed_approach");
	for(;;)
	{
		self waittill("goal_changed");
		wait(0.05);
		self notify("goal_changed_previous_frame");
	}
}

//Function Number: 20
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

	if(isdefined(self.approachconditioncheckfunc))
	{
		if(!self [[ self.approachconditioncheckfunc ]](param_00))
		{
			return 0;
		}
	}
	else
	{
		if(!self.facemotion && !isdefined(param_00) || param_00.type == "Path" || param_00.type == "Path 3D")
		{
			return 0;
		}

		if(self.a.pose != "stand")
		{
			return 0;
		}
	}

	if(isthreatenedbyenemy() || isdefined(self.lastapproachaborttime) && self.lastapproachaborttime + 500 > gettime())
	{
		return 0;
	}

	if(!self maymovetopoint(self.pathgoalpos,1,0,level.h1_arrival_ignores_player))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
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
		var_03 = 0;
		if(isdefined(self.animarchetype) && isdefined(level.archetypes[self.animarchetype]) && isdefined(level.archetypes[self.animarchetype]["longestExposedApproachDist"]))
		{
			var_03 = level.archetypes[self.animarchetype]["longestExposedApproachDist"];
		}
		else
		{
			var_03 = level.archetypes["soldier"]["longestExposedApproachDist"];
		}

		if(var_02 <= var_03 + 8)
		{
			break;
		}

		var_04 = var_02 - var_03 / 250 * self.moveplaybackrate - 0.1;
		if(var_04 < 0)
		{
			break;
		}

		if(var_04 < 0.05)
		{
			var_04 = 0.05;
		}

		wait(var_04);
	}
}

//Function Number: 22
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

	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		return self cansee(self.enemy);
	}

	return sighttracepassed(self.enemy getshootatpos(),self.pathgoalpos + (0,0,60),0,undefined);
}

//Function Number: 23
calculatelastminuteanimdistance(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.faceenemyarrival))
	{
		param_01 = self.angles[1];
	}
	else if(faceenemyatendofapproach(param_02))
	{
		param_01 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
	}
	else
	{
		var_05 = isdefined(param_02) && param_03;
		var_05 = var_05 && param_02.type != "Path" && param_02.type != "Path 3D" && param_02.type != "Ambush" || !animscripts\utility::recentlysawenemy();
		if(var_05)
		{
			param_01 = animscripts\utility::getnodeforwardyaw(param_02);
		}
		else
		{
			var_06 = self getanglestolikelyenemypath();
			if(isdefined(var_06))
			{
				param_01 = var_06[1];
			}
		}
	}

	var_07 = spawnstruct();
	animscripts\exit_node::calculatenodetransitionangles(var_07,param_04,1,param_01,param_00,9,-1);
	var_08 = 1;
	for(var_09 = 2;var_09 <= 9;var_09++)
	{
		if(var_07.transitions[var_09] > var_07.transitions[var_08])
		{
			var_08 = var_09;
		}
	}

	self.approachnumber = var_07.transindex[var_08];
	self.approachtype = param_04;
	var_0A = animscripts\utility::lookuptransitionanim("cover_trans",param_04,self.approachnumber);
	if(!isdefined(var_0A) || isdefined(self.disableapproach))
	{
		return;
	}

	var_0B = length(animscripts\utility::lookuptransitionanim("cover_trans_dist",param_04,self.approachnumber));
	return var_0B;
}

//Function Number: 24
calculatelastminuterequireddistsq(param_00)
{
	var_01 = param_00 + 8;
	var_01 = var_01 * var_01;
	return var_01;
}

//Function Number: 25
calculateapproachdir()
{
	var_00 = vectornormalize(self.pathgoalpos - self.origin);
	return var_00;
}

//Function Number: 26
calculatedesiredfacingyaw(param_00)
{
	var_01 = vectortoyaw(param_00);
	return var_01;
}

//Function Number: 27
dolastminuteexposedapproach()
{
	self endon("goal_changed");
	self endon("move_interrupt");
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return;
	}

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
	if(isdefined(self.approachtypefunc))
	{
		var_00 = self [[ self.approachtypefunc ]]();
	}
	else if(animscripts\utility::isunstableground())
	{
		var_00 = "exposed_unstable";
		if(self.movemode == "run")
		{
			var_00 = var_00 + "_run";
		}
	}
	else if(usereadystand())
	{
		if(animscripts\utility::shouldcqb())
		{
			var_00 = "exposed_ready_cqb";
		}
		else
		{
			var_00 = "exposed_ready";
		}
	}
	else if(animscripts\utility::shouldcqb())
	{
		var_00 = "exposed_cqb";
	}
	else if(isdefined(self.heat))
	{
		var_00 = "heat";
		var_01 = 4096;
	}
	else if(animscripts\utility::usingsmg())
	{
		var_00 = "exposed_smg";
	}

	var_02 = getapproachent();
	if(isdefined(var_02) && isdefined(self.pathgoalpos) && !isdefined(self.disablecoverarrivalsonly))
	{
		var_03 = distancesquared(self.pathgoalpos,var_02.origin) < var_01;
	}
	else
	{
		var_03 = 0;
	}

	if(var_03 && !isdefined(self.approachtypefunc))
	{
		var_00 = determineexposedapproachtype(var_02);
	}

	if(isdefined(self.mech) && self.mech)
	{
		var_00 = "exposed";
	}

	var_04 = calculateapproachdir();
	var_05 = calculatedesiredfacingyaw(var_04);
	var_06 = calculatelastminuteanimdistance(var_04,var_05,var_02,var_03,var_00);
	if(!isdefined(var_06))
	{
		return;
	}

	var_07 = calculatelastminuterequireddistsq(var_06);
	while(isdefined(self.pathgoalpos) && isdefined(var_07) && distancesquared(self.origin,self.pathgoalpos) > var_07)
	{
		var_04 = calculateapproachdir();
		var_05 = calculatedesiredfacingyaw(var_04);
		var_06 = calculatelastminuteanimdistance(var_04,var_05,var_02,var_03,var_00);
		var_07 = calculatelastminuterequireddistsq(var_06);
		wait(0.05);
	}

	if(isdefined(self.arrivalstartdist) && self.arrivalstartdist < var_06 + 8)
	{
		return;
	}

	if(!exposedapproachconditioncheck(var_02,var_03))
	{
		return;
	}

	var_08 = distance(self.origin,self.pathgoalpos);
	if(abs(var_08 - var_06) > 8)
	{
		return;
	}

	var_09 = vectortoyaw(self.pathgoalpos - self.origin);
	if(isdefined(self.heat) && var_03)
	{
		var_0A = var_05 - animscripts\utility::lookuptransitionanim("cover_trans_angles",var_00,self.approachnumber);
		var_0B = getarrivalstartpos(self.pathgoalpos,var_05,var_00,self.approachnumber);
	}
	else if(isdefined(self.a.forceapproachfacenodeyaw) && self.a.forceapproachfacenodeyaw)
	{
		var_07 = var_04.angles[1];
		var_0A = var_07 - animscripts\utility::lookuptransitionanim("cover_trans_angles",var_02,self.approachnumber);
		var_0B = getarrivalstartpos(self.pathgoalpos,var_06,var_01,self.approachnumber);
	}
	else if(var_08 > 0)
	{
		var_0C = animscripts\utility::lookuptransitionanim("cover_trans_dist",var_02,self.approachnumber);
		var_0D = atan(var_0C[1] / var_0C[0]);
		if(!isdefined(self.faceenemyarrival) || self.facemotion)
		{
			var_0A = var_09 - var_0D;
			if(animscripts\utility::absangleclamp180(var_0A - self.angles[1]) > 30)
			{
				return;
			}
		}
		else
		{
			var_0A = self.angles[1];
		}

		var_0E = var_08 - var_06;
		var_0B = self.origin + vectornormalize(self.pathgoalpos - self.origin) * var_0E;
	}
	else
	{
		var_0A = self.angles[1];
		var_0B = self.origin;
	}

	self.approachtype = var_00;
	if(animscripts\utility::using_cover_transition_angle_correction())
	{
		self.arrivalanim = animscripts\utility::lookupanim("cover_trans",self.approachtype)[self.approachnumber];
		var_0F = animscripts\utility::lookuptransitionanim("cover_trans_move_end",var_00,self.approachnumber);
		self.arrivalangles = self method_8567(var_0B,var_0A,0,self.arrivalanim,var_0F);
		return;
	}

	self.arrivalangles = self startcoverarrival(var_0B,var_0A,0);
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

		wait(0.1);
	}
}

//Function Number: 29
custommovetransitionfunc()
{
	if(!isdefined(self.startmovetransitionanim))
	{
		return;
	}

	self animmode("zonly_physics",0);
	self orientmode("face current");
	self setflaggedanimknoballrestart("move",self.startmovetransitionanim,%animscript_root,1);
	animscripts\face::playfacialanim(self.startmovetransitionanim,"run");
	if(animhasnotetrack(self.startmovetransitionanim,"code_move"))
	{
		animscripts\shared::donotetracks("move");
		self orientmode("face motion");
		self animmode("none",0);
	}

	animscripts\shared::donotetracks("move");
}

//Function Number: 30
customidletransitionfunc()
{
	if(!isdefined(self.startidletransitionanim))
	{
		return;
	}

	var_00 = self.approachnumber;
	var_01 = self.startidletransitionanim;
	if(!isdefined(self.heat))
	{
		thread abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts\face::playfacialanim(var_01,"run");
	animscripts\shared::donotetracks("coverArrival",::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	self clearanim(%animscript_root,0.3);
	self.lastapproachaborttime = undefined;
}

//Function Number: 31
str(param_00)
{
	if(!isdefined(param_00))
	{
		return "{undefined}";
	}

	return param_00;
}

//Function Number: 32
drawvec(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_02 * 100;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 33
drawapproachvec(param_00)
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.node))
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 34
getarrivalstartpos(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - animscripts\utility::lookuptransitionanim("cover_trans_angles",param_02,param_03),0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = animscripts\utility::lookuptransitionanim("cover_trans_dist",param_02,param_03);
	var_08 = var_05 * var_07[0];
	var_09 = var_06 * var_07[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 35
getarrivalprestartpos(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - animscripts\utility::lookuptransitionanim("cover_trans_angles",param_02,param_03),0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = animscripts\utility::lookuptransitionanim("cover_trans_predist",param_02,param_03);
	var_08 = var_05 * var_07[0];
	var_09 = var_06 * var_07[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 36
checkcoverenterpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getarrivalstartpos(param_00,param_01,param_02,param_03);
	self.coverenterpos = var_05;
	if(param_03 <= 6 && param_04)
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
	self.coverenterpos = var_06;
	return self maymovefrompointtopoint(var_06,var_05);
}

//Function Number: 37
usereadystand()
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

//Function Number: 38
debug_arrivals_on_actor()
{
	return 0;
}

//Function Number: 39
debug_arrival(param_00)
{
	if(!debug_arrivals_on_actor())
	{
	}
}
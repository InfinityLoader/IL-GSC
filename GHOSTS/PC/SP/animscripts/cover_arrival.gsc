/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_arrival.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 585 ms
 * Timestamp: 10/27/2023 1:23:42 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	self endon("abort_approach");
	if(self.swimmer)
	{
		animscripts/swim::func_7DD0();
		return;
	}

	if(isdefined(self.customarrivalfunc))
	{
		[[ self.customarrivalfunc ]]();
		return;
	}

	var_00 = self.approachnumber;
	var_01 = animscripts/utility::lookupanim("cover_trans",self.var_EB9)[var_00];
	if(!isdefined(self.heat))
	{
		thread abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.var_54C3);
	animscripts/face::func_6004(var_01,"run");
	animscripts/shared::func_2986("coverArrival",::func_3F98);
	var_02 = level.arrivalendstance[self.var_EB9];
	if(isdefined(var_02))
	{
		self.a.var_60B1 = var_02;
	}

	self.a.var_5486 = "stop";
	self.a.arrivaltype = self.var_EB9;
	self clearanim(%root,0.3);
	self.var_4C3C = undefined;
}

//Function Number: 2
func_3F98(param_00)
{
	if(param_00 == "start_aim")
	{
		if(self.a.var_60B1 == "stand")
		{
			animscripts/animset::func_6E41();
		}
		else if(self.a.var_60B1 == "crouch")
		{
			animscripts/animset::set_animarray_crouching();
		}
		else
		{
		}

		animscripts/combat::func_6E22();
		self.var_616D = 0;
		animscripts/combat_utility::func_71EA(0);
		thread animscripts/track::trackshootentorpos();
	}
}

//Function Number: 3
func_4988()
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
		}

		if(func_4988())
		{
			self clearanim(%root,0.3);
			self notify("abort_approach");
			self.var_4C3C = gettime();
		}

		wait(0.1);
	}
}

//Function Number: 5
func_1A20(param_00)
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

	if(animscripts/utility::func_3B53() > 40 || animscripts/utility::func_3B53() < -40)
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
determinenodeapproachtype(param_00)
{
	var_01 = param_00.type;
	if(var_01 == "Cover Multi")
	{
		if(!isdefined(self.cover))
		{
			self.cover = spawnstruct();
		}

		var_02 = animscripts/cover_multi::func_1FC1(["over",["left","right"]]);
		self.cover.arrivalnodetype = var_02;
		var_03 = animscripts/cover_multi::covermulti_getstatefromdir(param_00,var_02);
		var_01 = animscripts/utility::getcovermultipretendtype(param_00,var_03);
	}

	if(func_1A20(param_00))
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
	}

	if(isdefined(param_00.arrivalstance))
	{
		var_04 = param_00.arrivalstance;
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
	if(func_87CF() && var_05 == "exposed")
	{
		var_05 = "exposed_ready";
	}

	if(animscripts/utility::func_74A5())
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

	if(var_02 == "exposed" && func_87CF())
	{
		var_02 = var_02 + "_ready";
	}

	if(animscripts/utility::func_74A5())
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
func_3A25()
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
func_3A26(param_00,param_01)
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

	if(isdefined(self.var_279A) && self.var_279A)
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_1B92(param_00,param_01,param_02)
{
	if(isdefined(level.var_3105[param_00]))
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

	if(func_4988() || isdefined(self.var_4C3C) && self.var_4C3C + 500 > gettime())
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
	}

	if(param_00)
	{
		self.requestarrivalnotify = 1;
	}

	if(self.swimmer == 1)
	{
		thread animscripts/swim::func_7DF1();
	}

	self.a.arrivaltype = undefined;
	thread dolastminuteexposedapproachwrapper();
	self waittill("cover_approach",var_01);
	if(!checkapproachpreconditions())
	{
	}

	thread setupapproachnode(0);
	var_02 = "exposed";
	var_03 = self.pathgoalpos;
	var_04 = vectortoyaw(var_01);
	var_05 = var_04;
	var_06 = func_3A25();
	if(isdefined(var_06))
	{
		var_02 = determinenodeapproachtype(var_06);
		if(isdefined(var_02) && var_02 != "exposed")
		{
			var_03 = func_3A26(var_06,var_02);
			var_04 = var_06.angles[1];
			var_05 = animscripts/utility::getnodeforwardyaw(var_06);
		}
	}
	else if(func_87CF())
	{
		if(animscripts/utility::func_74A5())
		{
			var_02 = "exposed_ready_cqb";
		}
		else
		{
			var_02 = "exposed_ready";
		}
	}

	if(!func_1B92(var_02,var_01,var_06))
	{
	}

	func_7AC6(var_02,var_03,var_04,var_05,var_01);
}

//Function Number: 14
func_1FAB(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_279A) && self.var_279A)
	{
		return 0;
	}

	if(abs(self getmotionangle()) > 45 && isdefined(self.enemy) && vectordot(anglestoforward(self.angles),vectornormalize(self.enemy.origin - self.origin)) > 0.8)
	{
		return 0;
	}

	if(self.a.var_60B1 != "stand" || self.a.var_5486 != "run" && !animscripts/utility::iscqbwalkingorfacingenemy())
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

//Function Number: 15
approachwaittillclose(param_00,param_01)
{
	if(!isdefined(param_00))
	{
	}

	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			func_8AEA();
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

		wait(var_03);
	}
}

//Function Number: 16
func_7AC6(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("cover_approach");
	var_05 = func_3A25();
	var_06 = animscripts/exit_node::func_3B26(var_05);
	var_07 = var_06.maxdirections;
	var_08 = var_06.excludedir;
	var_09 = vectordot(param_04,anglestoforward(var_05.angles)) >= 0;
	var_06 = checkarrivalenterpositions(param_01,param_03,param_00,param_04,var_07,var_08,var_09);
	if(var_06.approachnumber < 0)
	{
	}

	var_0A = var_06.approachnumber;
	if(var_0A <= 6 && var_09)
	{
		self endon("goal_changed");
		self.arrivalstartdist = level.var_1FDA[param_00];
		approachwaittillclose(var_05,self.arrivalstartdist);
		var_0B = vectornormalize(param_01 - self.origin);
		var_06 = checkarrivalenterpositions(param_01,param_03,param_00,var_0B,var_07,var_08,var_09);
		self.arrivalstartdist = length(animscripts/utility::func_4F60("cover_trans_dist",param_00,var_0A));
		approachwaittillclose(var_05,self.arrivalstartdist);
		if(!self maymovetopoint(param_01))
		{
			self.arrivalstartdist = undefined;
		}

		if(var_06.approachnumber < 0)
		{
			self.arrivalstartdist = undefined;
		}

		var_0A = var_06.approachnumber;
		var_0C = param_03 - animscripts/utility::func_4F60("cover_trans_angles",param_00,var_0A);
	}
	else
	{
		self setruntopos(self.coverenterpos);
		self waittill("runto_arrived");
		var_0C = param_04 - animscripts/utility::func_4F60("cover_trans_angles",param_01,var_0C);
		if(!func_1FAB(param_01,param_03,param_00,var_0A,var_0C))
		{
		}
	}

	self.approachnumber = var_0A;
	self.var_EB9 = param_00;
	self.arrivalstartdist = undefined;
	self startcoverarrival(self.coverenterpos,var_0C,0);
}

//Function Number: 17
checkarrivalenterpositions(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	animscripts/exit_node::func_1937(var_07,param_02,1,param_01,param_03,param_04,param_05);
	animscripts/exit_node::func_76FB(var_07,param_04);
	var_08 = spawnstruct();
	var_09 = (0,0,0);
	var_08.approachnumber = -1;
	var_0A = 2;
	for(var_0B = 1;var_0B <= var_0A;var_0B++)
	{
		var_08.approachnumber = var_07.var_825F[var_0B];
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
			var_0F = param_01 - animscripts/utility::func_4F60("cover_trans_angles",param_02,var_08.approachnumber);
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
	thread func_8CF2();
	for(;;)
	{
		dolastminuteexposedapproach();
		for(;;)
		{
			common_scripts\utility::func_8B2A("goal_changed","goal_changed_previous_frame");
			if(isdefined(self.coverenterpos) && isdefined(self.pathgoalpos) && distance2d(self.coverenterpos,self.pathgoalpos) < 1)
			{
				continue;
			}

			break;
		}
	}
}

//Function Number: 19
func_8CF2()
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
func_30FA(param_00,param_01)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	if(isdefined(self.var_279A) && self.var_279A)
	{
		return 0;
	}

	if(isdefined(self.var_EB7))
	{
		if(!self [[ self.var_EB7 ]](param_00))
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

		if(self.a.var_60B1 != "stand")
		{
			return 0;
		}
	}

	if(func_4988() || isdefined(self.var_4C3C) && self.var_4C3C + 500 > gettime())
	{
		return 0;
	}

	if(!self maymovetopoint(self.pathgoalpos))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_30FB()
{
	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			func_8AEA();
		}

		var_00 = func_3A25();
		if(isdefined(var_00) && !isdefined(self.heat))
		{
			var_01 = var_00.origin;
		}
		else
		{
			var_01 = self.pathgoalpos;
		}

		var_02 = distance(self.origin,var_01);
		var_03 = level.var_4F3E;
		if(var_02 <= var_03 + 8)
		{
			break;
		}

		var_04 = var_02 - level.var_4F3E / 250 - 0.1;
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

	return sighttracepassed(self.enemy getshootatpos(),self.pathgoalpos + (0,0,60),0,undefined);
}

//Function Number: 23
dolastminuteexposedapproach()
{
	self endon("goal_changed");
	self endon("move_interrupt");
	if(isdefined(self getnegotiationstartnode()))
	{
	}

	func_30FB();
	if(isdefined(self.grenade) && isdefined(self.grenade.activator) && self.grenade.activator == self)
	{
	}

	var_00 = "exposed";
	var_01 = 1;
	if(isdefined(self.var_EBA))
	{
		var_00 = self [[ self.var_EBA ]]();
	}
	else if(func_87CF())
	{
		if(animscripts/utility::func_74A5())
		{
			var_00 = "exposed_ready_cqb";
		}
		else
		{
			var_00 = "exposed_ready";
		}
	}
	else if(animscripts/utility::func_74A5())
	{
		var_00 = "exposed_cqb";
	}
	else if(isdefined(self.heat))
	{
		var_00 = "heat";
		var_01 = 4096;
	}

	var_02 = func_3A25();
	if(isdefined(var_02) && isdefined(self.pathgoalpos) && !isdefined(self.disablecoverarrivalsonly))
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
		var_06 = var_06 && var_02.type != "Path" && var_02.type != "Path 3D" && var_02.type != "Ambush" || !animscripts/utility::func_63FE();
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
	animscripts/exit_node::func_1937(var_08,var_00,1,var_05,var_04,9,-1);
	var_09 = 1;
	for(var_0A = 2;var_0A <= 9;var_0A++)
	{
		if(var_08.var_826B[var_0A] > var_08.var_826B[var_09])
		{
			var_09 = var_0A;
		}
	}

	self.approachnumber = var_08.var_825F[var_09];
	self.var_EB9 = var_00;
	var_0B = animscripts/utility::func_4F60("cover_trans",var_00,self.approachnumber);
	var_0C = length(animscripts/utility::func_4F60("cover_trans_dist",var_00,self.approachnumber));
	var_0D = var_0C + 8;
	var_0D = var_0D * var_0D;
	while(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > var_0D)
	{
		wait(0.05);
	}

	if(isdefined(self.arrivalstartdist) && self.arrivalstartdist < var_0C + 8)
	{
	}

	if(!func_30FA(var_02,var_03))
	{
	}

	var_0E = distance(self.origin,self.pathgoalpos);
	if(abs(var_0E - var_0C) > 8)
	{
	}

	var_0F = vectortoyaw(self.pathgoalpos - self.origin);
	if(isdefined(self.heat) && var_03)
	{
		var_10 = var_05 - animscripts/utility::func_4F60("cover_trans_angles",var_00,self.approachnumber);
		var_11 = func_3A29(self.pathgoalpos,var_05,var_00,self.approachnumber);
	}
	else if(var_0E > 0)
	{
		var_12 = animscripts/utility::func_4F60("cover_trans_dist",var_02,self.approachnumber);
		var_13 = atan(var_12[1] / var_12[0]);
		if(!isdefined(self.faceenemyarrival) || self.facemotion)
		{
			var_10 = var_0F - var_13;
			if(animscripts/utility::absangleclamp180(var_10 - self.angles[1]) > 30)
			{
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

	self startcoverarrival(var_11,var_10,0);
}

//Function Number: 24
func_8AEA()
{
	for(;;)
	{
		if(isdefined(self.pathgoalpos))
		{
		}

		wait(0.1);
	}
}

//Function Number: 25
custommovetransitionfunc()
{
	if(!isdefined(self.var_7AE6))
	{
	}

	self animmode("zonly_physics",0);
	self orientmode("face current");
	self setflaggedanimknoballrestart("move",self.var_7AE6,%root,1);
	animscripts/face::func_6004(self.var_7AE6,"run");
	if(animhasnotetrack(self.var_7AE6,"code_move"))
	{
		animscripts/shared::func_2986("move");
		self orientmode("face motion");
		self animmode("none",0);
	}

	animscripts/shared::func_2986("move");
}

//Function Number: 26
str(param_00)
{
	if(!isdefined(param_00))
	{
		return "{undefined}";
	}

	return param_00;
}

//Function Number: 27
func_2A90(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_02 * 100;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 28
func_2A70(param_00)
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

//Function Number: 29
func_3A29(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - animscripts/utility::func_4F60("cover_trans_angles",param_02,param_03),0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = animscripts/utility::func_4F60("cover_trans_dist",param_02,param_03);
	var_08 = var_05 * var_07[0];
	var_09 = var_06 * var_07[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 30
getarrivalprestartpos(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - animscripts/utility::func_4F60("cover_trans_angles",param_02,param_03),0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = animscripts/utility::func_4F60("cover_trans_predist",param_02,param_03);
	var_08 = var_05 * var_07[0];
	var_09 = var_06 * var_07[1];
	return param_00 - var_08 + var_09;
}

//Function Number: 31
checkcoverenterpos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_3A29(param_00,param_01,param_02,param_03);
	self.coverenterpos = var_05;
	if(param_03 <= 6 && param_04)
	{
		return 1;
	}

	if(!self maymovefrompointtopoint(var_05,param_00))
	{
		return 0;
	}

	if(param_03 <= 6 || isdefined(level.var_3105[param_02]))
	{
		return 1;
	}

	var_06 = getarrivalprestartpos(var_05,param_01,param_02,param_03);
	self.coverenterpos = var_06;
	return self maymovefrompointtopoint(var_06,var_05);
}

//Function Number: 32
func_87CF()
{
	if(!isdefined(level.var_63D6))
	{
		return 0;
	}

	if(!level.var_63D6)
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

//Function Number: 33
debug_arrivals_on_actor()
{
	return 0;
}

//Function Number: 34
func_23CC(param_00)
{
	if(!debug_arrivals_on_actor())
	{
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_arrival.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 869 ms
 * Timestamp: 10/27/2023 2:18:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("abort_approach");
	var_00 = self.var_1162;
	var_01 = level.var_1164[self.var_1163][var_00];
	if(!isdefined(self.heat))
	{
		thread func_116A();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.var_1165);
	animscripts/shared::donotetracks("coverArrival",::func_1168);
	var_02 = level.var_1166[self.var_1163];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.var_10DF = self.var_1163;
	self clearanim(%root,0.3);
	self.var_1167 = undefined;
}

//Function Number: 2
func_1168(param_00)
{
	if(param_00 == "start_aim")
	{
		if(self.a.pose == "stand")
		{
			animscripts/animset::func_C94();
		}
		else if(self.a.pose == "crouch")
		{
			animscripts/animset::func_C99();
		}
		else
		{
		}

		animscripts/combat::func_110E();
		self.var_110A = 0;
		animscripts/combat_utility::func_110B(0);
		thread animscripts/track::func_CA9();
	}
}

//Function Number: 3
func_1169()
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
func_116A()
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.node))
		{
			return;
		}

		if(func_1169())
		{
			self clearanim(%root,0.3);
			self notify("abort_approach");
			self.var_1167 = gettime();
			return;
		}

		wait 0.1;
	}
}

//Function Number: 5
func_116B(param_00)
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
func_116C(param_00)
{
	if(!animscripts/utility::func_F79())
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

	if(animscripts/utility::func_116D() > 40 || animscripts/utility::func_116D() < -40)
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_116E(param_00)
{
	if(func_116C(param_00))
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

	if(!isdefined(level.var_116F[param_00.type]))
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

	var_02 = level.var_116F[param_00.type][var_01];
	if(func_11B2() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(animscripts/utility::func_CB2())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.var_1164[var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 8
func_1171(param_00)
{
	if(func_116C(param_00))
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

	if(!isdefined(level.var_116F[param_00.type]))
	{
		return;
	}

	if(isdefined(level.var_1172[param_00.type]) && level.var_1172[param_00.type] != self.a.pose)
	{
		return;
	}

	var_01 = self.a.pose;
	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	var_02 = level.var_116F[param_00.type][var_01];
	if(func_11B2() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(animscripts/utility::func_CB2())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.var_1173[var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 9
func_1174(param_00)
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

	if(var_02 == "exposed" && func_11B2())
	{
		var_02 = var_02 + "_ready";
	}

	if(animscripts/utility::func_CB2())
	{
		return var_02 + "_cqb";
	}

	return var_02;
}

//Function Number: 10
func_1175(param_00)
{
	var_01 = spawnstruct();
	if(isdefined(param_00) && isdefined(level.var_1176[param_00.type]))
	{
		var_01.var_1176 = level.var_1176[param_00.type];
		var_01.var_1177 = level.var_1177[param_00.type];
	}
	else
	{
		var_01.var_1176 = 9;
		var_01.var_1177 = -1;
	}

	return var_01;
}

//Function Number: 11
func_1178(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(animscripts/combat_utility::func_F08(0.5))
	{
		return 0;
	}

	if(animscripts/utility::func_F4C())
	{
		return 0;
	}

	if(isdefined(level.var_1179[param_00]))
	{
		return 0;
	}

	if(param_00 == "left_crouch" || param_00 == "right_crouch")
	{
		return 0;
	}

	return animscripts/utility::func_117A(self.enemy getshootatpos(),self.node);
}

//Function Number: 12
func_117B(param_00,param_01)
{
	var_02 = anglestoright(param_00);
	var_03 = anglestoforward(param_00);
	return var_03 * param_01[0] + var_02 * 0 - param_01[1];
}

//Function Number: 13
func_117C()
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
func_117D(param_00,param_01)
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
func_117E()
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
func_1180(param_00,param_01,param_02)
{
	if(isdefined(level.var_1179[param_00]))
	{
		return 0;
	}

	if(param_00 == "stand" || param_00 == "crouch")
	{
		if(animscripts/utility::func_D61(vectortoyaw(param_01) - param_02.angles[1] + 180) < 60)
		{
			return 0;
		}
	}

	if(func_1169() || isdefined(self.var_1167) && self.var_1167 + 500 > gettime())
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_10A9(param_00)
{
	self endon("killanimscript");
	if(isdefined(self.heat))
	{
		thread func_118B();
		return;
	}

	if(param_00)
	{
		self.var_779 = 1;
	}

	self.a.var_10DF = undefined;
	thread func_118B();
	self waittill("cover_approach",var_01);
	if(!func_117E())
	{
		return;
	}

	thread func_10A9(0);
	var_02 = "exposed";
	var_03 = self.pathgoalpos;
	var_04 = vectortoyaw(var_01);
	var_05 = var_04;
	var_06 = func_117C();
	if(isdefined(var_06))
	{
		var_02 = func_116E(var_06);
		if(isdefined(var_02) && var_02 != "exposed")
		{
			var_03 = func_117D(var_06,var_02);
			var_04 = var_06.angles[1];
			var_05 = animscripts/utility::func_F41(var_06);
		}
	}
	else if(func_11B2())
	{
		if(animscripts/utility::func_CB2())
		{
			var_02 = "exposed_ready_cqb";
		}
		else
		{
			var_02 = "exposed_ready";
		}
	}

	if(!func_1180(var_02,var_01,var_06))
	{
		return;
	}

	func_1183(var_02,var_03,var_04,var_05,var_01);
}

//Function Number: 18
func_1181(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	if(abs(self getmotionangle()) > 45 && isdefined(self.enemy) && vectordot(anglestoforward(self.angles),vectornormalize(self.enemy.origin - self.origin)) > 0.8)
	{
		return 0;
	}

	if(self.a.pose != "stand" || self.a.movement != "run" && !animscripts/utility::func_10B9())
	{
		return 0;
	}

	if(animscripts/utility::func_D61(param_04 - self.angles[1]) > 30)
	{
		if(isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536)
		{
			if(vectordot(anglestoforward(self.angles),self.enemy.origin - self.origin) > 0)
			{
				return 0;
			}
		}
	}

	if(!func_11B1(param_00,param_01,param_02,param_03,0))
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
func_1182(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			func_1197();
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
func_1183(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("cover_approach");
	var_05 = func_117C();
	var_06 = func_1175(var_05);
	var_07 = var_06.var_1176;
	var_08 = var_06.var_1177;
	var_09 = vectordot(param_04,anglestoforward(var_05.angles)) >= 0;
	var_06 = func_1189(param_01,param_03,param_00,param_04,var_07,var_08,var_09);
	if(var_06.var_1162 < 0)
	{
		return;
	}

	var_0A = var_06.var_1162;
	if(level.var_1184 && var_0A <= 6 && var_09)
	{
		self endon("goal_changed");
		self.var_10AD = level.var_1185[param_00];
		func_1182(var_05,self.var_10AD);
		var_0B = vectornormalize(param_01 - self.origin);
		var_06 = func_1189(param_01,param_03,param_00,var_0B,var_07,var_08,var_09);
		self.var_10AD = length(level.var_1186[param_00][var_0A]);
		func_1182(var_05,self.var_10AD);
		if(!self maymovetopoint(param_01))
		{
			self.var_10AD = undefined;
			return;
		}

		if(var_06.var_1162 < 0)
		{
			self.var_10AD = undefined;
			return;
		}

		var_0A = var_06.var_1162;
		var_0C = param_03 - level.var_1187[param_00][var_0A];
	}
	else
	{
		self setruntopos(self.var_1188);
		self waittill("runto_arrived");
		var_0C = param_04 - level.var_1187[param_01][var_0C];
		if(!func_1181(param_01,param_03,param_00,var_0A,var_0C))
		{
			return;
		}
	}

	self.var_1162 = var_0A;
	self.var_1163 = param_00;
	self.var_10AD = undefined;
	self startcoverarrival(self.var_1188,var_0C);
}

//Function Number: 21
func_1189(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	func_11A8(var_07,param_02,1,param_01,param_03,param_04,param_05);
	func_11AA(var_07,param_04);
	var_08 = spawnstruct();
	var_09 = (0,0,0);
	var_08.var_1162 = -1;
	var_0A = 2;
	for(var_0B = 1;var_0B <= var_0A;var_0B++)
	{
		var_08.var_1162 = var_07.var_118A[var_0B];
		if(!func_11B1(param_00,param_01,param_02,var_08.var_1162,param_06))
		{
			continue;
		}

		break;
	}

	if(var_0B > var_0A)
	{
		var_08.var_1162 = -1;
		return var_08;
	}

	var_0C = distancesquared(param_00,self.origin);
	var_0D = distancesquared(param_00,self.var_1188);
	if(var_0C < var_0D * 2 * 2)
	{
		if(var_0C < var_0D)
		{
			var_08.var_1162 = -1;
			return var_08;
		}

		if(!level.var_1184 || !param_06)
		{
			var_0E = vectornormalize(self.var_1188 - self.origin);
			var_0F = param_01 - level.var_1187[param_02][var_08.var_1162];
			var_10 = anglestoforward((0,var_0F,0));
			var_11 = vectordot(var_0E,var_10);
			if(var_11 < 0.707)
			{
				var_08.var_1162 = -1;
				return var_08;
			}
		}
	}

	return var_08;
}

//Function Number: 22
func_118B()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self notify("doing_last_minute_exposed_approach");
	self endon("doing_last_minute_exposed_approach");
	thread func_118C();
	for(;;)
	{
		func_1192();
		for(;;)
		{
			common_scripts\utility::waittill_any("goal_changed","goal_changed_previous_frame");
			if(isdefined(self.var_1188) && isdefined(self.pathgoalpos) && distance2d(self.var_1188,self.pathgoalpos) < 1)
			{
				continue;
			}

			break;
		}
	}
}

//Function Number: 23
func_118C()
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
func_118D(param_00,param_01)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return 0;
	}

	if(isdefined(self.var_118E))
	{
		if(!self [[ self.var_118E ]](param_00))
		{
			return 0;
		}
	}
	else
	{
		if(!self.var_781 && !isdefined(param_00) || param_00.type == "Path")
		{
			return 0;
		}

		if(self.a.pose != "stand")
		{
			return 0;
		}
	}

	if(func_1169() || isdefined(self.var_1167) && self.var_1167 + 500 > gettime())
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
func_118F()
{
	for(;;)
	{
		if(!isdefined(self.pathgoalpos))
		{
			func_1197();
		}

		var_00 = func_117C();
		if(isdefined(var_00) && !isdefined(self.heat))
		{
			var_01 = var_00.origin;
		}
		else
		{
			var_01 = self.pathgoalpos;
		}

		var_02 = distance(self.origin,var_01);
		var_03 = level.var_1190;
		if(var_02 <= var_03 + 8)
		{
			break;
		}

		var_04 = var_02 - level.var_1190 / 250 - 0.1;
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
func_1191(param_00)
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
func_1192()
{
	self endon("goal_changed");
	self endon("move_interrupt");
	if(isdefined(self getnegotiationstartnode()))
	{
		return;
	}

	func_118F();
	if(isdefined(self.var_73C) && isdefined(self.var_73C.var_7C1) && self.var_73C.var_7C1 == self)
	{
		return;
	}

	var_00 = "exposed";
	var_01 = 1;
	if(isdefined(self.var_1193))
	{
		var_00 = self [[ self.var_1193 ]]();
	}
	else if(func_11B2())
	{
		if(animscripts/utility::func_CB2())
		{
			var_00 = "exposed_ready_cqb";
		}
		else
		{
			var_00 = "exposed_ready";
		}
	}
	else if(animscripts/utility::func_CB2())
	{
		var_00 = "exposed_cqb";
	}
	else if(isdefined(self.heat))
	{
		var_00 = "heat";
		var_01 = 4096;
	}

	var_02 = func_117C();
	if(isdefined(var_02) && isdefined(self.pathgoalpos) && !isdefined(self.var_1194))
	{
		var_03 = distancesquared(self.pathgoalpos,var_02.origin) < var_01;
	}
	else
	{
		var_03 = 0;
	}

	if(var_03)
	{
		var_00 = func_1174(var_02);
	}

	var_04 = vectornormalize(self.pathgoalpos - self.origin);
	var_05 = vectortoyaw(var_04);
	if(isdefined(self.var_1195))
	{
		var_05 = self.angles[1];
	}
	else if(func_1191(var_02))
	{
		var_05 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
	}
	else
	{
		var_06 = isdefined(var_02) && var_03;
		var_06 = var_06 && var_02.type != "Path" && var_02.type != "Ambush" || !animscripts/utility::func_CBC();
		if(var_06)
		{
			var_05 = animscripts/utility::func_F41(var_02);
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
	func_11A8(var_08,var_00,1,var_05,var_04,9,-1);
	var_09 = 1;
	for(var_0A = 2;var_0A <= 9;var_0A++)
	{
		if(var_08.var_1196[var_0A] > var_08.var_1196[var_09])
		{
			var_09 = var_0A;
		}
	}

	self.var_1162 = var_08.var_118A[var_09];
	self.var_1163 = var_00;
	var_0B = level.var_1164[var_00][self.var_1162];
	var_0C = length(level.var_1186[var_00][self.var_1162]);
	var_0D = var_0C + 8;
	var_0D = var_0D * var_0D;
	while(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > var_0D)
	{
		wait 0.05;
	}

	if(isdefined(self.var_10AD) && self.var_10AD < var_0C + 8)
	{
		return;
	}

	if(!func_118D(var_02,var_03))
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
		var_10 = var_05 - level.var_1187[var_00][self.var_1162];
		var_11 = func_11AE(self.pathgoalpos,var_05,var_00,self.var_1162);
	}
	else if(var_0E > 0)
	{
		var_12 = level.var_1186[var_02][self.var_1162];
		var_13 = atan(var_12[1] / var_12[0]);
		if(!isdefined(self.var_1195) || self.var_781)
		{
			var_10 = var_0F - var_13;
			if(animscripts/utility::func_D61(var_10 - self.angles[1]) > 30)
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
func_1197()
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
func_1198()
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

	if(self.var_786 != "none")
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
func_119A(param_00,param_01)
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

	if(!isdefined(self.heat) && isdefined(self.enemy) && vectordot(self.var_773,self.enemy.origin - self.origin) < 0)
	{
		if(animscripts/utility::func_F4A() && distancesquared(self.origin,self.enemy.origin) < 90000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 31
func_119B()
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
	else if(isdefined(self.var_79E) && distancesquared(self.origin,self.var_79E.origin) < var_01)
	{
		var_00 = self.var_79E;
	}

	if(isdefined(var_00) && isdefined(self.heat) && animscripts/utility::func_D61(self.angles[1] - var_00.angles[1]) > 30)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 32
func_119C()
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
func_119E(param_00)
{
	if(self.a.pose == "stand")
	{
		param_00 = "exposed";
	}
	else
	{
		param_00 = "exposed_crouch";
	}

	if(func_11B2())
	{
		param_00 = "exposed_ready";
	}

	if(animscripts/utility::func_CB2())
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
func_119F(param_00,param_01)
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
func_10A6()
{
	if(isdefined(self.custommovetransition))
	{
		var_00 = self.custommovetransition;
		if(!isdefined(self.var_11A1))
		{
			self.custommovetransition = undefined;
		}

		[[ var_00 ]]();
		if(!isdefined(self.var_11A1))
		{
			self.startmovetransitionanim = undefined;
		}

		self clearanim(%root,0.2);
		self orientmode("face default");
		self animmode("none",0);
		return;
	}

	self endon("killanimscript");
	if(!func_1198())
	{
		return;
	}

	var_01 = self.origin;
	var_02 = self.angles[1];
	var_03 = "exposed";
	var_04 = 0;
	var_05 = func_119B();
	if(isdefined(var_05))
	{
		var_06 = func_1171(var_05);
		if(isdefined(var_06))
		{
			var_03 = var_06;
			var_04 = 1;
			if(isdefined(self.heat))
			{
				var_03 = func_119F(var_05,var_03);
			}

			if(!isdefined(level.var_1179[var_03]) && var_03 != "stand_saw" && var_03 != "crouch_saw")
			{
				var_07 = animscripts/utility::func_D61(self.angles[1] - animscripts/utility::func_F41(var_05));
				if(var_07 < 5)
				{
					if(!isdefined(self.heat))
					{
						var_01 = var_05.origin;
					}

					var_02 = animscripts/utility::func_F41(var_05);
				}
			}
		}
	}

	if(!func_119A(var_03,var_05))
	{
		return;
	}

	var_08 = isdefined(level.var_1179[var_03]);
	if(!var_04)
	{
		var_03 = func_119E();
	}

	var_09 = (-1 * self.var_773[0],-1 * self.var_773[1],0);
	var_0A = func_1175(var_05);
	var_0B = var_0A.var_1176;
	var_0C = var_0A.var_1177;
	var_0D = spawnstruct();
	func_11A8(var_0D,var_03,0,var_02,var_09,var_0B,var_0C);
	func_11AA(var_0D,var_0B);
	var_0E = -1;
	var_0F = 3;
	if(var_08)
	{
		var_0F = 1;
	}

	for(var_10 = 1;var_10 <= var_0F;var_10++)
	{
		var_0E = var_0D.var_118A[var_10];
		if(func_11AB(var_01,var_02,var_03,var_08,var_0E))
		{
			break;
		}
	}

	if(var_10 > var_0F)
	{
		return;
	}

	var_11 = distancesquared(self.origin,self.var_11A2) * 1.25 * 1.25;
	if(distancesquared(self.origin,self.pathgoalpos) < var_11)
	{
		return;
	}

	func_11A4(var_03,var_0E);
}

//Function Number: 36
func_11A3(param_00)
{
	if(!isdefined(param_00))
	{
		return "{undefined}";
	}

	return param_00;
}

//Function Number: 37
func_11A4(param_00,param_01)
{
	var_02 = level.var_1173[param_00][param_01];
	var_03 = vectortoangles(self.var_773);
	if(self.a.pose == "prone")
	{
		return;
	}

	var_05 = 0.2;
	self animmode("zonly_physics",0);
	self orientmode("face angle",self.angles[1]);
	self setflaggedanimknoballrestart("coverexit",var_02,%body,1,var_05,self.var_1165);
	animscripts/shared::donotetracks("coverexit");
	self.a.pose = "stand";
	self.a.movement = "run";
	self.var_10A8 = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	func_11A5("coverexit");
	self clearanim(%root,0.2);
	self orientmode("face default");
	self animmode("normal",0);
}

//Function Number: 38
func_11A5(param_00)
{
	self endon("move_loop_restart");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 39
func_11A6(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_02 * 100;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 40
func_11A7(param_00)
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
func_11A8(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00.var_1196 = [];
	param_00.var_118A = [];
	var_07 = undefined;
	var_08 = 1;
	var_09 = 0;
	if(param_02)
	{
		var_07 = level.var_1187[param_01];
		var_08 = -1;
		var_09 = 0;
	}
	else
	{
		var_07 = level.var_11A9[param_01];
		var_08 = 1;
		var_09 = 180;
	}

	for(var_0A = 1;var_0A <= param_05;var_0A++)
	{
		param_00.var_118A[var_0A] = var_0A;
		if(var_0A == 5 || var_0A == param_06 || !isdefined(var_07[var_0A]))
		{
			param_00.var_1196[var_0A] = -1.0003;
			continue;
		}

		var_0B = (0,param_03 + var_08 * var_07[var_0A] + var_09,0);
		var_0C = vectornormalize(anglestoforward(var_0B));
		param_00.var_1196[var_0A] = vectordot(param_04,var_0C);
	}
}

//Function Number: 42
func_11AA(param_00,param_01)
{
	for(var_02 = 2;var_02 <= param_01;var_02++)
	{
		var_03 = param_00.var_1196[param_00.var_118A[var_02]];
		var_04 = param_00.var_118A[var_02];
		for(var_05 = var_02 - 1;var_05 >= 1;var_05--)
		{
			if(var_03 < param_00.var_1196[param_00.var_118A[var_05]])
			{
				break;
			}

			param_00.var_118A[var_05 + 1] = param_00.var_118A[var_05];
		}

		param_00.var_118A[var_05 + 1] = var_04;
	}
}

//Function Number: 43
func_11AB(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,param_01,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = var_06 * level.var_11AC[param_02][param_04][0];
	var_09 = var_07 * level.var_11AC[param_02][param_04][1];
	var_0A = param_00 + var_08 - var_09;
	self.var_11A2 = var_0A;
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

	var_08 = var_06 * level.var_11AD[param_02][param_04][0];
	var_09 = var_07 * level.var_11AD[param_02][param_04][1];
	var_0B = var_0A + var_08 - var_09;
	self.var_11A2 = var_0B;
	return self maymovefrompointtopoint(var_0A,var_0B);
}

//Function Number: 44
func_11AE(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - level.var_1187[param_02][param_03],0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = var_05 * level.var_1186[param_02][param_03][0];
	var_08 = var_06 * level.var_1186[param_02][param_03][1];
	return param_00 - var_07 + var_08;
}

//Function Number: 45
func_11AF(param_00,param_01,param_02,param_03)
{
	var_04 = (0,param_01 - level.var_1187[param_02][param_03],0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = var_05 * level.var_11B0[param_02][param_03][0];
	var_08 = var_06 * level.var_11B0[param_02][param_03][1];
	return param_00 - var_07 + var_08;
}

//Function Number: 46
func_11B1(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_11AE(param_00,param_01,param_02,param_03);
	self.var_1188 = var_05;
	if(level.var_1184 && param_03 <= 6 && param_04)
	{
		return 1;
	}

	if(!self maymovefrompointtopoint(var_05,param_00))
	{
		return 0;
	}

	if(param_03 <= 6 || isdefined(level.var_1179[param_02]))
	{
		return 1;
	}

	var_06 = func_11AF(var_05,param_01,param_02,param_03);
	self.var_1188 = var_06;
	return self maymovefrompointtopoint(var_06,var_05);
}

//Function Number: 47
func_11B2()
{
	if(!isdefined(level.var_11B3))
	{
		return 0;
	}

	if(!level.var_11B3)
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
func_11B4()
{
	return 0;
}

//Function Number: 49
func_11B5(param_00)
{
	if(!func_11B4())
	{
	}
}
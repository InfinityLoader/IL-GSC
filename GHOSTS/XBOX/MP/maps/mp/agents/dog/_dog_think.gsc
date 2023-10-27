/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_think.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 39
 * Decompile Time: 730 ms
 * Timestamp: 10/27/2023 1:27:56 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_71F5();
	thread func_8087();
	thread func_8D09();
	thread func_8D0A();
	thread func_8D0C();
	thread func_8AD6();
	thread func_8AEB();
}

//Function Number: 2
func_71F5()
{
	self.blockgoalpos = 0;
	self.ownerradiussq = 20736;
	self.meleeradiussq = 16384;
	self.attackoffset = 25 + self.radius;
	self.attackradiussq = 202500;
	self.warningradiussq = 302500;
	self.warningzheight = 96;
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.ownerdamagedradiussq = 2250000;
	self.dogdamagedradiussq = 2250000;
	self.keeppursuingtargetradiussq = 1000000;
	self.preferredoffsetfromowner = 76;
	self.minoffsetfromowner = 50;
	self.forceattack = 0;
	self.ignoreclosefoliage = 1;
	self.movemode = "run";
	self.enableextendedkill = 1;
	self.attackstate = "idle";
	self.movestate = "idle";
	self.bhasbadpath = 0;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self setgoalradius(24);
}

//Function Number: 3
func_44DF()
{
	self.animcbs = addstruct();
	self.animcbs.onenter = [];
	self.animcbs.onenter["idle"] = ::maps/mp/agents/dog/_dog_idle::func_4FDD;
	self.animcbs.onenter["move"] = ::maps/mp/agents/dog/_dog_move::func_4FDD;
	self.animcbs.onenter["traverse"] = ::maps/mp/agents/dog/_dog_traverse::func_4FDD;
	self.animcbs.onenter["melee"] = ::maps/mp/agents/dog/_dog_melee::func_4FDD;
	self.animcbs.onexit = [];
	self.animcbs.onexit["idle"] = ::maps/mp/agents/dog/_dog_idle::end_script;
	self.animcbs.onexit["move"] = ::maps/mp/agents/dog/_dog_move::end_script;
	self.animcbs.onexit["melee"] = ::maps/mp/agents/dog/_dog_melee::end_script;
	self.animcbs.onexit["traverse"] = ::maps/mp/agents/dog/_dog_traverse::end_script;
	self.watchattackstatefunc = ::watchattackstate;
	self.aistate = "idle";
	self.movemode = "fastwalk";
	self.radius = 15;
	self.height = 40;
}

//Function Number: 4
onenteranimstate(param_00,param_01)
{
	self notify("killanimscript");
	if(!isdefined(self.animcbs.onenter[param_01]))
	{
	}

	if(param_00 == param_01 && param_01 != "traverse")
	{
	}

	if(isdefined(self.animcbs.onexit[param_00]))
	{
		self [[ self.animcbs.onexit[param_00] ]]();
	}

	exitaistate(self.aistate);
	self.aistate = param_01;
	func_2F62(param_01);
	self [[ self.animcbs.onenter[param_01] ]]();
}

//Function Number: 5
func_8087()
{
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.owner))
	{
		self endon("owner_disconnect");
		thread func_2657(self.owner);
	}

	self thread [[ self.watchattackstatefunc ]]();
	thread func_538C();
	for(;;)
	{
		if(self.aistate != "melee" && !self.statelocked && func_63DA() && !didpastmeleefail())
		{
			self beginmelee(self.curmeleetarget);
		}

		switch(self.aistate)
		{
			case "idle":
				func_86F4();
				break;
	
			case "move":
				func_8704();
				break;
	
			case "melee":
				func_8701();
				break;
		}

		wait(0.05);
	}
}

//Function Number: 6
didpastpursuitfail(param_00)
{
	if(isdefined(self.curmeleetarget) && param_00 != self.curmeleetarget)
	{
		return 0;
	}

	if(!isdefined(self.lastpursuitfailedpos) || !isdefined(self.lastpursuitfailedmypos))
	{
		return 0;
	}

	if(function_0210(param_00.origin,self.lastpursuitfailedpos) > 4)
	{
		return 0;
	}

	if(self.blastpursuitfailedposbad)
	{
		return 1;
	}

	if(distancesquared(self.origin,self.lastpursuitfailedmypos) > 4096 && gettime() - self.lastpursuitfailedtime > 2000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
didpastmeleefail()
{
	if(isdefined(self.lastmeleefailedpos) && isdefined(self.lastmeleefailedmypos) && function_0210(self.curmeleetarget.origin,self.lastmeleefailedpos) < 4 && distancesquared(self.origin,self.lastmeleefailedmypos) < 2500)
	{
		return 1;
	}

	if(func_8C05(0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_2F62(param_00)
{
	exitaistate(self.aistate);
	self.aistate = param_00;
	switch(param_00)
	{
		case "idle":
			self.movestate = "idle";
			self.bhasbadpath = 0;
			break;

		case "move":
			self.movestate = "follow";
			break;

		case "melee":
			break;

		default:
			break;
	}
}

//Function Number: 9
exitaistate(param_00)
{
	switch(param_00)
	{
		case "move":
			self.ownerprevpos = undefined;
			break;

		default:
			break;
	}
}

//Function Number: 10
func_86F4()
{
	func_8708();
}

//Function Number: 11
func_8704()
{
	func_8708();
}

//Function Number: 12
func_8701()
{
	self setgoalpos(self.origin);
}

//Function Number: 13
func_8708()
{
	if(self.blockgoalpos)
	{
	}

	self.prevmovestate = self.movestate;
	var_00 = undefined;
	var_01 = 0;
	var_02 = 0;
	var_03 = 500;
	if(self.bhasbadpath && gettime() - self.lastbadpathtime < var_03)
	{
		self.movestate = "follow";
		var_01 = 1;
	}
	else
	{
		self.movestate = func_3B37();
	}

	if(self.movestate == "pursuit")
	{
		var_00 = getattackpoint(self.enemy);
		var_04 = 0;
		if(isdefined(self.lastbadpathtime) && gettime() - self.lastbadpathtime < 3000)
		{
			if(function_0210(var_00,self.lastbadpathgoal) < 16)
			{
				var_04 = 1;
			}
			else if(isdefined(self.lastbadpathmovestate) && self.lastbadpathmovestate == "pursuit" && function_0210(self.lastbadpathultimategoal,self.enemy.origin) < 16)
			{
				var_04 = 1;
			}
		}

		if(var_04)
		{
			self.movestate = "follow";
			var_02 = 1;
		}
		else if(func_8C05(1))
		{
			self.movestate = "follow";
			var_02 = 1;
		}
		else if(didpastpursuitfail(self.enemy))
		{
			self.movestate = "follow";
			var_02 = 1;
		}
	}

	func_7090(var_02);
	if(self.movestate == "follow")
	{
		self.curmeleetarget = undefined;
		self.movemode = getfollowmovemode(self.movemode);
		self.barrivalsenabled = 1;
		var_05 = self getpathgoalpos();
		if(!isdefined(var_05))
		{
			var_05 = self.origin;
		}

		if(self.owner.sessionstate == "spectator")
		{
		}

		if(gettime() - self.timeoflastdamage < 5000)
		{
			var_01 = 1;
		}

		var_06 = self.owner getstance();
		if(!isdefined(self.owner.prevstance) && isdefined(self.owner))
		{
			self.owner.prevstance = var_06;
		}

		var_07 = !isdefined(self.ownerprevpos) || function_0210(self.ownerprevpos,self.owner.origin) > 100;
		if(var_07)
		{
			self.ownerprevpos = self.owner.origin;
		}

		var_08 = function_0210(var_05,self.owner.origin);
		if(var_01 || var_08 > self.ownerradiussq && var_07 || self.owner.prevstance != var_06 || self.prevmovestate != "idle" && self.prevmovestate != self.movestate)
		{
			self setgoalpos(findpointnearowner());
			self.owner.prevstance = var_06;
		}
	}

	if(self.movestate == "pursuit")
	{
		self.curmeleetarget = self.enemy;
		self.movemode = "sprint";
		self.barrivalsenabled = 0;
		self setgoalpos(var_00);
	}
}

//Function Number: 14
func_3B37(param_00)
{
	if(isdefined(self.enemy))
	{
		if(isdefined(self.favoriteenemy) && self.enemy == self.favoriteenemy)
		{
			return "pursuit";
		}

		if(abs(self.origin[2] - self.enemy.origin[2]) < self.warningzheight && function_0210(self.enemy.origin,self.origin) < self.attackradiussq)
		{
			return "pursuit";
		}

		if(isdefined(self.curmeleetarget) && self.curmeleetarget == self.enemy)
		{
			if(function_0210(self.curmeleetarget.origin,self.origin) < self.keeppursuingtargetradiussq)
			{
				return "pursuit";
			}
		}
	}

	return "follow";
}

//Function Number: 15
func_7090(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.lastpursuitfailedpos))
		{
			self.lastpursuitfailedpos = self.enemy.origin;
			self.lastpursuitfailedmypos = self.origin;
			var_01 = maps/mp/agents/_scriptedagents::droppostoground(self.enemy.origin);
			self.blastpursuitfailedposbad = !isdefined(var_01);
			self.lastpursuitfailedtime = gettime();
		}
	}

	self.lastpursuitfailedpos = undefined;
	self.lastpursuitfailedmypos = undefined;
	self.blastpursuitfailedposbad = undefined;
	self.lastpursuitfailedtime = undefined;
}

//Function Number: 16
func_8AD6()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bad_path",var_00);
		self.bhasbadpath = 1;
		self.lastbadpathtime = gettime();
		self.lastbadpathgoal = var_00;
		self.lastbadpathmovestate = self.movestate;
		if(self.movestate == "follow" && isdefined(self.owner))
		{
			self.lastbadpathultimategoal = self.owner.origin;
			continue;
		}

		if(self.movestate == "pursuit" && isdefined(self.enemy))
		{
			self.lastbadpathultimategoal = self.enemy.origin;
		}
	}
}

//Function Number: 17
func_8AEB()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("path_set");
		self.bhasbadpath = 0;
	}
}

//Function Number: 18
getfollowmovemode(param_00)
{
	var_01 = -25536;
	var_02 = 65536;
	var_03 = self getpathgoalpos();
	if(isdefined(var_03))
	{
		var_04 = distancesquared(var_03,self.origin);
		if(param_00 == "run" || param_00 == "sprint")
		{
			if(var_04 < var_01)
			{
				return "fastwalk";
			}
			else if(param_00 == "sprint")
			{
				return "run";
			}
		}
		else if(param_00 == "fastwalk")
		{
			if(var_04 > var_02)
			{
				return "run";
			}
		}
	}

	return param_00;
}

//Function Number: 19
func_92B4(param_00)
{
	var_01 = param_00[2] - self.origin[2];
	return var_01 <= self.attackzheight && var_01 >= self.attackzheightdown;
}

//Function Number: 20
func_8C05(param_00)
{
	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	return !func_92B4(self.curmeleetarget.origin) && function_0210(self.origin,self.curmeleetarget.origin) < self.meleeradiussq * 0.75 * 0.75 && !param_00 || self agentcanseesentient(self.curmeleetarget);
}

//Function Number: 21
func_63DA()
{
	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_4945(self.curmeleetarget))
	{
		return 0;
	}

	if(self.aistate == "traverse")
	{
		return 0;
	}

	if(function_0210(self.origin,self.curmeleetarget.origin) > self.meleeradiussq)
	{
		return 0;
	}

	if(!func_92B4(self.curmeleetarget.origin))
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_8C04()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(abs(self.origin[2] - self.enemy.origin[2]) <= self.warningzheight || self agentcanseesentient(self.enemy))
	{
		var_00 = function_0210(self.origin,self.enemy.origin);
		if(var_00 < self.warningradiussq)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
getattackpoint(param_00)
{
	var_01 = param_00.origin - self.origin;
	var_01 = vectornormalize(var_01);
	var_02 = self getpathgoalpos();
	var_03 = self.attackoffset + 4;
	if(isdefined(var_02) && function_0210(var_02,param_00.origin) < var_03 * var_03 && maps/mp/agents/_scriptedagents::canmovepointtopoint(param_00.origin,var_02))
	{
		return var_02;
	}

	var_04 = param_00.origin - var_01 * self.attackoffset;
	var_04 = maps/mp/agents/_scriptedagents::droppostoground(var_04);
	if(!isdefined(var_04))
	{
		return param_00.origin;
	}

	if(!maps/mp/agents/_scriptedagents::canmovepointtopoint(param_00.origin,var_04))
	{
		var_05 = anglestoforward(param_00.angles);
		var_04 = param_00.origin + var_05 * self.attackoffset;
		if(!maps/mp/agents/_scriptedagents::canmovepointtopoint(param_00.origin,var_04))
		{
			return param_00.origin;
		}
	}

	return var_04;
}

//Function Number: 24
func_214C(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

//Function Number: 25
findpointnearowner()
{
	var_00 = vectornormalize(self.origin - self.owner.origin);
	var_01 = anglestoforward(self.owner.angles);
	var_01 = (var_01[0],var_01[1],0);
	var_01 = vectornormalize(var_01);
	var_02 = func_214C(var_00,var_01);
	var_03 = getclosestnodeinsight(self.owner.origin);
	if(!isdefined(var_03))
	{
		return self.origin;
	}

	var_04 = getpathdist(var_03);
	var_05 = 5;
	var_06 = 10;
	var_07 = 15;
	var_08 = -15;
	var_09 = gettime() - self.timeoflastdamage < 5000;
	var_0A = 0;
	var_0B = undefined;
	var_04[var_04.size] = var_03;
	foreach(var_0D in var_04)
	{
		var_0E = 0;
		var_0F = var_0D.origin - self.owner.origin;
		var_10 = length(var_0F);
		if(var_10 >= self.preferredoffsetfromowner)
		{
			var_0E = var_0E + var_05;
		}
		else if(var_10 < self.minoffsetfromowner)
		{
			var_11 = 1 - self.minoffsetfromowner - var_10 / self.minoffsetfromowner;
			var_0E = var_0E + var_05 * var_11 * var_11;
		}
		else
		{
			var_0E = var_0E + var_05 * var_10 / self.preferredoffsetfromowner;
		}

		if(var_10 == 0)
		{
			var_10 = 1;
		}

		var_0F = var_0F / var_10;
		var_12 = vectordot(var_01,var_0F);
		var_13 = self.owner getstance();
		switch(var_13)
		{
			case "stand":
				if(var_12 < cos(35) && var_12 > cos(45))
				{
					var_0E = var_0E + var_06;
				}
				break;

			case "crouch":
				if(var_12 < cos(75) && var_12 > cos(90))
				{
					var_0E = var_0E + var_06;
				}
				break;

			case "prone":
				if(var_12 < cos(125) && var_12 > cos(135))
				{
					var_0E = var_0E + var_06;
				}
				break;
		}

		var_14 = func_214C(var_0F,var_01);
		if(var_14 * var_02 > 0)
		{
			var_0E = var_0E + var_07;
		}

		if(var_09)
		{
			var_15 = vectordot(self.damagedownertome,var_0F);
			var_0E = var_0E + var_15 * var_08;
		}

		if(var_0E > var_0A)
		{
			var_0A = var_0E;
			var_0B = var_0D;
		}
	}

	if(!isdefined(var_0B))
	{
		return self.origin;
	}

	var_17 = var_0B.origin - self.owner.origin;
	var_18 = length(var_17);
	if(var_18 > self.preferredoffsetfromowner)
	{
		var_19 = var_03.origin - self.owner.origin;
		if(vectordot(var_19,var_17 / var_18) < 0)
		{
			var_1A = var_0B.origin;
		}
		else
		{
			var_1B = vectornormalize(var_0B.origin - var_03.origin);
			var_1A = var_03.origin + var_1B * self.preferredoffsetfromowner;
		}
	}
	else
	{
		var_1A = var_0C.origin;
	}

	var_1A = maps/mp/agents/_scriptedagents::droppostoground(var_1A);
	if(!isdefined(var_1A))
	{
		return self.origin;
	}

	if(self.bhasbadpath && function_0210(var_1A,self.lastbadpathgoal) < 4)
	{
		return self.origin;
	}

	return var_1A;
}

//Function Number: 26
func_2657(param_00)
{
	self endon("death");
	param_00 common_scripts\utility::func_8B2A("disconnect","joined_team");
	self notify("owner_disconnect");
	if(maps\mp\gametypes\_hostmigration::func_8BBA())
	{
		wait(0.05);
	}

	self notify("killanimscript");
	if(isdefined(self.animcbs.onexit[self.aistate]))
	{
		self [[ self.animcbs.onexit[self.aistate] ]]();
	}

	self suicide();
}

//Function Number: 27
watchattackstate()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(self.aistate == "melee")
		{
			if(self.attackstate != "melee")
			{
				self.attackstate = "melee";
				func_70CB(undefined);
			}
		}
		else if(self.movestate == "pursuit")
		{
			if(self.attackstate != "attacking")
			{
				self.attackstate = "attacking";
				func_70CB("bark","attacking");
			}
		}
		else if(self.attackstate != "warning")
		{
			if(func_8C04())
			{
				self.attackstate = "warning";
				func_70CB("growl","warning");
			}
			else
			{
				self.attackstate = self.aistate;
				func_70CB("pant");
			}
		}
		else if(!func_8C04())
		{
			self.attackstate = self.aistate;
			func_70CB("pant");
		}

		wait(0.05);
	}
}

//Function Number: 28
func_70CB(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		self notify("end_dog_sound");
		self.soundstate = undefined;
	}

	if(!isdefined(self.soundstate) || self.soundstate != param_00)
	{
		self notify("end_dog_sound");
		self.soundstate = param_00;
		if(param_00 == "bark")
		{
			thread func_5D4D(param_01);
		}

		if(param_00 == "growl")
		{
			thread playgrowl(param_01);
		}

		if(param_00 == "pant")
		{
			thread playpanting();
		}
	}
}

//Function Number: 29
func_5D4D(param_00)
{
	self endon("death");
	level endon("game_ended");
	self endon("end_dog_sound");
	if(!isdefined(self.barking_sound))
	{
		self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_bark","anml_dog_bark"));
		self.barking_sound = 1;
		thread func_8CC8();
	}
}

//Function Number: 30
func_8CC8()
{
	self endon("death");
	level endon("game_ended");
	self endon("end_dog_sound");
	wait(randomintrange(5,10));
	self.barking_sound = undefined;
}

//Function Number: 31
playgrowl(param_00)
{
	self endon("death");
	level endon("game_ended");
	self endon("end_dog_sound");
	if(isdefined(self.lastgrowlplayedtime) && gettime() - self.lastgrowlplayedtime < 3000)
	{
		wait(3);
	}

	for(;;)
	{
		self.lastgrowlplayedtime = gettime();
		self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_growl","anml_dog_growl"));
		wait(randomintrange(3,6));
	}
}

//Function Number: 32
playpanting(param_00)
{
	self endon("death");
	level endon("game_ended");
	self endon("end_dog_sound");
	if(isdefined(self.lastpantplayedtime) && gettime() - self.lastpantplayedtime < 3000)
	{
		wait(3);
	}

	self.lastpantplayedtime = gettime();
	for(;;)
	{
		if(self.aistate == "idle")
		{
			wait(3);
			continue;
		}

		self.lastpantplayedtime = gettime();
		if(self.movemode == "run" || self.movemode == "sprint")
		{
			self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_pants_mp_fast","anml_dog_pants_mp_fast"));
		}
		else
		{
			self botpredictenemycampspots(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_pants_mp_med","anml_dog_pants_mp_med"));
		}

		wait(randomintrange(6,8));
	}
}

//Function Number: 33
func_8D09()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.owner))
		{
		}

		self.owner waittill("damage",var_00,var_01);
		if(isplayer(var_01) && var_01 != self.owner)
		{
			if(self.attackstate == "attacking")
			{
				continue;
			}

			if(distancesquared(self.owner.origin,self.origin) > self.ownerdamagedradiussq)
			{
				continue;
			}

			if(distancesquared(self.owner.origin,var_01.origin) > self.ownerdamagedradiussq)
			{
				continue;
			}

			self.favoriteenemy = var_01;
			self.forceattack = 1;
			thread func_8CE4();
		}
	}
}

//Function Number: 34
func_8D0A()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.owner))
		{
		}

		self.owner waittill("death");
		switch(level.gametype)
		{
			case "sd":
				maps/mp/agents/_agent_utility::func_4B15();
				break;
	
			case "sr":
				var_00 = level common_scripts\utility::func_8B33("sr_player_eliminated","sr_player_respawned");
				if(isdefined(var_00) && var_00 == "sr_player_eliminated")
				{
					maps/mp/agents/_agent_utility::func_4B15();
				}
				break;
		}
	}
}

//Function Number: 35
func_8D0C()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.owner))
		{
		}

		var_00 = self.owner common_scripts\utility::waittill_any_return_no_endon_death("joined_team","joined_spectators");
		if(isdefined(var_00) && var_00 == "joined_team" || var_00 == "joined_spectators")
		{
			maps/mp/agents/_agent_utility::func_4B15();
		}
	}
}

//Function Number: 36
func_8CE4()
{
	self notify("watchFavoriteEnemyDeath");
	self endon("watchFavoriteEnemyDeath");
	self endon("death");
	self.favoriteenemy common_scripts\utility::func_8B35(5,"death","disconnect");
	self.favoriteenemy = undefined;
	self.forceattack = 0;
}

//Function Number: 37
func_5906(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self.timeoflastdamage = gettime();
	if(isdefined(self.owner))
	{
		self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
	}

	if(func_948A(param_02,param_05,param_04))
	{
		switch(self.aistate)
		{
			case "idle":
				thread maps/mp/agents/dog/_dog_idle::func_5906(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
				break;

			case "move":
				thread maps/mp/agents/dog/_dog_move::func_5906(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
				break;
		}
	}
}

//Function Number: 38
func_948A(param_00,param_01,param_02)
{
	if(isdefined(param_01) && weaponclass(param_01) == "sniper")
	{
		return 1;
	}

	if(isdefined(param_02) && isexplosivedamagemod(param_02) && param_00 >= 10)
	{
		return 1;
	}

	if(isdefined(param_02) && param_02 == "MOD_MELEE")
	{
		return 1;
	}

	if(isdefined(param_01) && param_01 == "concussion_grenade_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
func_538C()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03,var_04,var_05);
		if(isdefined(var_03) && var_03 == self.owner)
		{
			continue;
		}

		switch(self.aistate)
		{
			case "idle":
				maps/mp/agents/dog/_dog_idle::func_593B();
				break;
	
			case "move":
				maps/mp/agents/dog/_dog_move::func_593B();
				break;
		}
	}
}
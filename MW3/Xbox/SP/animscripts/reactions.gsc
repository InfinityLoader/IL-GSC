/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\reactions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 194 ms
 * Timestamp: 10/27/2023 2:30:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::initialize("reactions");
	newenemysurprisedreaction();
}

//Function Number: 2
func_0B07()
{
	anim.runningreacttobullets = [];
	level.runningreacttobullets[level.runningreacttobullets.size] = %run_react_duck;
	level.runningreacttobullets[level.runningreacttobullets.size] = %run_react_flinch;
	level.runningreacttobullets[level.runningreacttobullets.size] = %run_react_stumble;
	anim.lastrunningreactanim = 0;
	anim.coverreactions = [];
	level.coverreactions["cover_stand"] = animscripts/utility::array(%stand_cover_reaction_a,%stand_cover_reaction_b);
	level.coverreactions["cover_crouch"] = animscripts/utility::array(%crouch_cover_reaction_a,%crouch_cover_reaction_b);
	level.coverreactions["cover_left"] = animscripts/utility::array(%cornerstndl_react_a);
	level.coverreactions["cover_right"] = animscripts/utility::array(%cornerstndr_react_a);
}

//Function Number: 3
reactionscheckloop()
{
	thread func_0B12();
}

//Function Number: 4
func_0B0C()
{
	return !isdefined(self.lastreacttime) || gettime() - self.lastreacttime > 2000;
}

//Function Number: 5
func_0B0E()
{
	self endon("killanimscript");
	self.lastreacttime = gettime();
	self.a.movement = "stop";
	var_00 = isdefined(self.whizbyenemy) && distancesquared(self.origin,self.whizbyenemy.origin) < 160000;
	self animmode("gravity");
	self orientmode("face current");
	if(var_00 || common_scripts\utility::cointoss())
	{
		self clearanim(%root,0.1);
		var_01 = [];
		var_02 = var_41[randomint(var_41.size)];
		if(var_01)
		{
			var_03 = 1 + randomfloat(0.5);
		}
		else
		{
			var_03 = 0.2 + randomfloat(0.5);
		}

		self setflaggedanimknobrestart("reactanim",var_02,1,0.1,1);
		animscripts/notetracks::donotetracksfortime(var_03,"reactanim");
		self clearanim(%root,0.1);
		if(!var_01 && self.stairsstate == "none" && !isdefined(self.disable_dive_whizby_react))
		{
			var_04 = 1 + randomfloat(0.2);
			var_05 = animscripts/utility::randomanimoftwo(%exposed_dive_grenade_b,%exposed_dive_grenade_f);
			self setflaggedanimknobrestart("dive",var_05,1,0.1,var_04);
			animscripts/shared::donotetracks("dive");
		}
	}
	else
	{
		wait randomfloat(0.2);
		var_04 = 1.2 + randomfloat(0.3);
		if(self.a.var_911 == "stand")
		{
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("crouch",%exposed_stand_2_crouch,1,0.1,var_04);
			animscripts/shared::donotetracks("crouch");
		}

		var_06 = anglestoforward(self.angles);
		if(isdefined(self.whizbyenemy))
		{
			var_07 = vectornormalize(self.whizbyenemy.origin - self.origin);
		}
		else
		{
			var_07 = var_07;
		}

		if(vectordot(var_07,var_06) > 0)
		{
			var_08 = animscripts/utility::randomanimoftwo(%exposed_crouch_idle_twitch_v2,%exposed_crouch_idle_twitch_v3);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("twitch",var_08,1,0.1,1);
			animscripts/shared::donotetracks("twitch");
		}
		else
		{
			var_09 = animscripts/utility::randomanimoftwo(%exposed_crouch_turn_180_left,%exposed_crouch_turn_180_right);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("turn",var_09,1,0.1,1);
			animscripts/shared::donotetracks("turn");
		}
	}

	self clearanim(%root,0.1);
	self.whizbyenemy = undefined;
	self animmode("normal");
	self orientmode("face default");
}

//Function Number: 6
func_0B12()
{
	self endon("killanimscript");
	if(isdefined(self.disablebulletwhizbyreaction))
	{
		return;
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(!isdefined(var_00.team) || self.team == var_00.team)
		{
			continue;
		}

		if(isdefined(self.covernode) || isdefined(self.ambushnode))
		{
			continue;
		}

		if(self.a.var_911 != "stand")
		{
			continue;
		}

		if(!func_0B0C())
		{
			continue;
		}

		self.whizbyenemy = var_00;
		self animcustom(::func_0B0E);
	}
}

//Function Number: 7
clearlookatthread()
{
	self endon("killanimscript");
	wait 0.3;
	self setlookatentity();
}

//Function Number: 8
func_0B14()
{
	var_00 = undefined;
	if(self nearclaimnodeandangle() && isdefined(level.coverreactions[self.prevscript]))
	{
		var_01 = anglestoforward(self.node.angles);
		var_02 = vectornormalize(self.reactiontargetpos - self.origin);
		if(vectordot(var_01,var_02) < -0.5)
		{
			self orientmode("face current");
			var_03 = randomint(level.coverreactions[self.prevscript].size);
			var_00 = level.coverreactions[self.prevscript][var_03];
		}
	}

	if(!isdefined(var_00))
	{
		var_04 = [];
		if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.reactiontargetpos) < 65536)
		{
			self orientmode("face enemy");
		}
		else
		{
			self orientmode("face point",self.reactiontargetpos);
		}

		if(self.a.var_911 == "crouch")
		{
			var_02 = vectornormalize(self.reactiontargetpos - self.origin);
			var_05 = anglestoforward(self.angles);
			if(vectordot(var_05,var_02) < -0.5)
			{
				self orientmode("face current");
				var_41[0] = %crouch_cover_reaction_a;
				var_41[1] = %crouch_cover_reaction_b;
			}
		}

		var_04 = var_41[randomint(var_41.size)];
	}

	return var_04;
}

//Function Number: 9
func_0B15()
{
	self clearanim(%root,0.2);
	if(randomint(4) < 3)
	{
		self orientmode("face enemy");
		self setflaggedanimknobrestart("reactanim",%exposed_idle_reactb,1,0.2,1);
		var_00 = getanimlength(%exposed_idle_reactb);
		animscripts/notetracks::donotetracksfortime(var_00 * 0.8,"reactanim");
		self orientmode("face current");
		return;
	}

	self orientmode("face enemy");
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal,1,0.2,1);
	var_00 = getanimlength(%exposed_backpedal);
	animscripts/notetracks::donotetracksfortime(var_00 * 0.8,"reactanim");
	self orientmode("face current");
	self clearanim(%root,0.2);
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal_v2,1,0.2,1);
	animscripts/shared::donotetracks("reactanim");
}

//Function Number: 10
newenemyreactionanim()
{
	self endon("death");
	self endon("endNewEnemyReactionAnim");
	self.lastreacttime = gettime();
	self.a.movement = "stop";
	if(isdefined(self._stealth) && self.alertlevel != "combat")
	{
		func_0B15();
	}
	else
	{
		var_00 = func_0B14();
		self clearanim(%root,0.2);
		self setflaggedanimknobrestart("reactanim",var_00,1,0.2,1);
		animscripts/shared::donotetracks("reactanim");
	}

	self notify("newEnemyReactionDone");
}

//Function Number: 11
newenemysurprisedreaction()
{
	self endon("death");
	if(isdefined(self.var_B18))
	{
		return;
	}

	if(!func_0B0C())
	{
		return;
	}

	if(self.a.var_911 == "prone" || isdefined(self.a.onback))
	{
		return;
	}

	self animmode("gravity");
	if(isdefined(self.enemy))
	{
		newenemyreactionanim();
	}
}
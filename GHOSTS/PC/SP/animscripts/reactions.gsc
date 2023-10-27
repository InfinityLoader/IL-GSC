/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\reactions.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 197 ms
 * Timestamp: 10/27/2023 1:24:17 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	animscripts/utility::func_4622("reactions");
	newenemysurprisedreaction();
}

//Function Number: 2
init_animset_reactions()
{
	var_00 = [];
	var_00["cover_stand"] = [%stand_cover_reaction_a,%stand_cover_reaction_b];
	var_00["cover_crouch"] = [%stand_cover_reaction_a,%stand_cover_reaction_b];
	var_00["cover_left"] = [%stand_cover_reaction_a,%stand_cover_reaction_b];
	var_00["cover_right"] = [%stand_cover_reaction_a,%stand_cover_reaction_b];
	level.archetypes["soldier"]["cover_reactions"] = var_00;
	var_00 = [];
	var_00[0] = %run_wizby_a;
	var_00[1] = %run_wizby_b;
	level.archetypes["soldier"]["running_react_to_bullets"] = var_00;
	anim.var_4C94 = 0;
}

//Function Number: 3
func_63BF()
{
	thread bulletwhizbycheckloop();
}

//Function Number: 4
canreactagain()
{
	return !isdefined(self.var_4C91) || gettime() - self.var_4C91 > 2000;
}

//Function Number: 5
bulletwhizbyreaction()
{
	self endon("killanimscript");
	self.var_4C91 = gettime();
	self.a.var_5486 = "stop";
	var_00 = isdefined(self.var_8DE9) && distancesquared(self.origin,self.var_8DE9.origin) < 160000;
	self animmode("gravity");
	self orientmode("face current");
	if(var_00 || common_scripts\utility::func_1DE9())
	{
		self clearanim(%root,0.1);
		var_01 = [];
		var_01[0] = %exposed_idle_reacta;
		var_01[1] = %exposed_idle_reactb;
		var_01[2] = %exposed_idle_twitch;
		var_01[3] = %exposed_idle_twitch_v4;
		var_02 = var_01[randomint(var_01.size)];
		if(var_00)
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
		if(!var_00 && self.stairsstate == "none" && !isdefined(self.var_275C))
		{
			var_04 = 1 + randomfloat(0.2);
			var_05 = animscripts/utility::func_632D(%exposed_dive_grenade_b,%exposed_dive_grenade_f);
			self setflaggedanimknobrestart("dive",var_05,1,0.1,var_04);
			animscripts/shared::func_2986("dive");
		}
	}
	else
	{
		wait(randomfloat(0.2));
		var_04 = 1.2 + randomfloat(0.3);
		if(self.a.var_60B1 == "stand")
		{
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("crouch",%exposed_stand_2_crouch,1,0.1,var_04);
			animscripts/shared::func_2986("crouch");
		}

		var_06 = anglestoforward(self.angles);
		if(isdefined(self.var_8DE9))
		{
			var_07 = vectornormalize(self.var_8DE9.origin - self.origin);
		}
		else
		{
			var_07 = var_07;
		}

		if(vectordot(var_07,var_06) > 0)
		{
			var_08 = animscripts/utility::func_632D(%exposed_crouch_idle_twitch_v2,%exposed_crouch_idle_twitch_v3);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("twitch",var_08,1,0.1,1);
			animscripts/shared::func_2986("twitch");
		}
		else
		{
			var_09 = animscripts/utility::func_632D(%exposed_crouch_turn_180_left,%exposed_crouch_turn_180_right);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("turn",var_09,1,0.1,1);
			animscripts/shared::func_2986("turn");
		}
	}

	self clearanim(%root,0.1);
	self.var_8DE9 = undefined;
	self animmode("normal");
	self orientmode("face default");
}

//Function Number: 6
bulletwhizbycheckloop()
{
	self endon("killanimscript");
	if(isdefined(self.var_279D))
	{
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(!isdefined(var_00.team) || self.team == var_00.team)
		{
			continue;
		}

		if(isdefined(self.var_1FCA) || isdefined(self.var_CFA))
		{
			continue;
		}

		if(self.a.var_60B1 != "stand")
		{
			continue;
		}

		if(!canreactagain())
		{
			continue;
		}

		self.var_8DE9 = var_00;
		self animcustom(::bulletwhizbyreaction);
	}
}

//Function Number: 7
func_1D46()
{
	self endon("killanimscript");
	wait(0.3);
	self setlookatentity();
}

//Function Number: 8
getnewenemyreactionanim()
{
	var_00 = undefined;
	if(self nearclaimnodeandangle())
	{
		var_01 = animscripts/utility::func_4F5D("cover_reactions");
		if(isdefined(var_01[self.prevscript]))
		{
			var_02 = anglestoforward(self.node.angles);
			var_03 = vectornormalize(self.reactiontargetpos - self.origin);
			if(vectordot(var_02,var_03) < -0.5)
			{
				self orientmode("face current");
				var_04 = randomint(var_01[self.prevscript].size);
				var_00 = var_01[self.prevscript][var_04];
			}
		}
	}

	if(!isdefined(var_00))
	{
		var_05 = [];
		var_05[0] = %exposed_backpedal;
		var_05[1] = %exposed_idle_reactb;
		if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.reactiontargetpos) < 65536)
		{
			self orientmode("face enemy");
		}
		else
		{
			self orientmode("face point",self.reactiontargetpos);
		}

		if(self.a.var_60B1 == "crouch")
		{
			var_03 = vectornormalize(self.reactiontargetpos - self.origin);
			var_06 = anglestoforward(self.angles);
			if(vectordot(var_06,var_03) < -0.5)
			{
				self orientmode("face current");
				var_05[0] = %crouch_cover_reaction_a;
				var_05[1] = %crouch_cover_reaction_b;
			}
		}

		var_00 = var_05[randomint(var_05.size)];
	}

	return var_00;
}

//Function Number: 9
stealthnewenemyreactanim()
{
	self clearanim(%root,0.2);
	if(randomint(4) < 3)
	{
		self orientmode("face enemy");
		self setflaggedanimknobrestart("reactanim",%exposed_idle_reactb,1,0.2,1);
		var_00 = getanimlength(%exposed_idle_reactb);
		animscripts/notetracks::donotetracksfortime(var_00 * 0.8,"reactanim");
		self orientmode("face current");
	}

	self orientmode("face enemy");
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal,1,0.2,1);
	var_00 = getanimlength(%exposed_backpedal);
	animscripts/notetracks::donotetracksfortime(var_00 * 0.8,"reactanim");
	self orientmode("face current");
	self clearanim(%root,0.2);
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal_v2,1,0.2,1);
	animscripts/shared::func_2986("reactanim");
}

//Function Number: 10
func_55C7()
{
	self endon("death");
	self endon("endNewEnemyReactionAnim");
	self.var_4C91 = gettime();
	self.a.var_5486 = "stop";
	if(isdefined(self._stealth) && self.alertlevel != "combat")
	{
		stealthnewenemyreactanim();
	}
	else
	{
		var_00 = getnewenemyreactionanim();
		self clearanim(%root,0.2);
		self setflaggedanimknobrestart("reactanim",var_00,1,0.2,1);
		animscripts/shared::func_2986("reactanim");
	}

	self notify("newEnemyReactionDone");
}

//Function Number: 11
newenemysurprisedreaction()
{
	self endon("death");
	if(isdefined(self.var_27BB))
	{
	}

	if(!canreactagain())
	{
	}

	if(self.a.var_60B1 == "prone" || isdefined(self.a.onback))
	{
	}

	self animmode("gravity");
	if(isdefined(self.enemy))
	{
		func_55C7();
	}
}
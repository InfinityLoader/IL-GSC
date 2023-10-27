/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\reactions.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 207 ms
 * Timestamp: 10/27/2023 1:55:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts\utility::initialize("reactions");
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
	anim.lastrunningreactanim = 0;
}

//Function Number: 3
reactionscheckloop()
{
	thread bulletwhizbycheckloop();
}

//Function Number: 4
canreactagain()
{
	return !isdefined(self.lastreacttime) || gettime() - self.lastreacttime > 2000;
}

//Function Number: 5
bulletwhizbyreaction()
{
	self endon("killanimscript");
	self.lastreacttime = gettime();
	self.a.movement = "stop";
	var_00 = isdefined(self.whizbyenemy) && distancesquared(self.origin,self.whizbyenemy.origin) < 160000;
	self animmode("gravity");
	self orientmode("face current");
	if(var_00 || common_scripts\utility::cointoss())
	{
		self clearanim(%animscript_root,0.1);
		var_01 = [];
		if(animscripts\utility::usingsmg())
		{
			var_01[0] = %smg_exposed_idle_reacta;
			var_01[1] = %smg_exposed_idle_reactb;
			var_01[2] = %smg_exposed_idle_twitch;
			var_01[3] = %smg_exposed_idle_twitch_v4;
		}
		else
		{
			var_01[0] = %exposed_idle_reacta;
			var_01[1] = %exposed_idle_reactb;
			var_01[2] = %exposed_idle_twitch;
			var_01[3] = %exposed_idle_twitch_v4;
		}

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
		animscripts\notetracks::donotetracksfortime(var_03,"reactanim");
		self clearanim(%animscript_root,0.1);
		if(!var_00 && self.stairsstate == "none" && !isdefined(self.disable_dive_whizby_react))
		{
			var_04 = 1 + randomfloat(0.2);
			var_05 = animscripts\utility::randomanimoftwo(%exposed_dive_grenade_b,%exposed_dive_grenade_f);
			self setflaggedanimknobrestart("dive",var_05,1,0.1,var_04);
			animscripts\shared::donotetracks("dive");
		}
	}
	else
	{
		wait(randomfloat(0.2));
		var_04 = 1.2 + randomfloat(0.3);
		if(self.a.pose == "stand")
		{
			self clearanim(%animscript_root,0.1);
			self setflaggedanimknobrestart("crouch",%exposed_stand_2_crouch,1,0.1,var_04);
			animscripts\shared::donotetracks("crouch");
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
			var_08 = animscripts\utility::randomanimoftwo(%exposed_crouch_idle_twitch_v2,%exposed_crouch_idle_twitch_v3);
			self clearanim(%animscript_root,0.1);
			self setflaggedanimknobrestart("twitch",var_08,1,0.1,1);
			animscripts\shared::donotetracks("twitch");
		}
		else
		{
			var_09 = animscripts\utility::randomanimoftwo(%exposed_crouch_turn_180_left,%exposed_crouch_turn_180_right);
			self clearanim(%animscript_root,0.1);
			self setflaggedanimknobrestart("turn",var_09,1,0.1,1);
			animscripts\shared::donotetracks("turn");
		}
	}

	self clearanim(%animscript_root,0.1);
	self.whizbyenemy = undefined;
	self animmode("normal");
	self orientmode("face default");
}

//Function Number: 6
bulletwhizbycheckloop()
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

		if(self.a.pose != "stand")
		{
			continue;
		}

		if(!canreactagain())
		{
			continue;
		}

		self.whizbyenemy = var_00;
		self animcustom(::bulletwhizbyreaction);
	}
}

//Function Number: 7
clearlookatthread()
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
		var_01 = animscripts\utility::lookupanimarray("cover_reactions");
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
		if(animscripts\utility::usingsmg())
		{
			var_05[0] = %smg_exposed_backpedal;
			var_05[1] = %smg_exposed_idle_reactb;
		}
		else if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
		{
			var_05[0] = %s1_exposed_backpedal;
			var_05[1] = %s1_exposed_idle_alert_v5;
		}
		else
		{
			var_05[0] = %exposed_backpedal;
			var_05[1] = %exposed_idle_reactb;
		}

		if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.reactiontargetpos) < 65536)
		{
			self orientmode("face enemy");
		}
		else
		{
			self orientmode("face point",self.reactiontargetpos);
		}

		if(self.a.pose == "crouch")
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
	self clearanim(%animscript_root,0.2);
	if(randomint(4) < 3)
	{
		self orientmode("face enemy");
		var_00 = %exposed_idle_reactb;
		if(animscripts\utility::usingsmg())
		{
			var_00 = %smg_exposed_idle_reactb;
		}

		self setflaggedanimknobrestart("reactanim",var_00,1,0.2,1);
		var_01 = getanimlength(var_00);
		animscripts\notetracks::donotetracksfortime(var_01 * 0.8,"reactanim");
		self orientmode("face current");
		return;
	}

	self orientmode("face enemy");
	var_02 = %exposed_backpedal;
	var_03 = %exposed_backpedal_v2;
	if(animscripts\utility::usingsmg())
	{
		var_02 = %smg_exposed_backpedal;
		var_03 = %smg_exposed_backpedal_v2;
	}

	self setflaggedanimknobrestart("reactanim",var_02,1,0.2,1);
	var_01 = getanimlength(var_02);
	animscripts\notetracks::donotetracksfortime(var_01 * 0.8,"reactanim");
	self orientmode("face current");
	self clearanim(%animscript_root,0.2);
	self setflaggedanimknobrestart("reactanim",var_03,1,0.2,1);
	animscripts\shared::donotetracks("reactanim");
}

//Function Number: 10
newenemyreactionanim()
{
	self endon("death");
	self endon("endNewEnemyReactionAnim");
	self.lastreacttime = gettime();
	self.a.movement = "stop";
	self.playing_new_enemy_reaction_anim = 1;
	if(isdefined(self._stealth) && self.alertlevel != "combat")
	{
		stealthnewenemyreactanim();
	}
	else
	{
		var_00 = getnewenemyreactionanim();
		self clearanim(%animscript_root,0.2);
		self setflaggedanimknobrestart("reactanim",var_00,1,0.2,1);
		animscripts\shared::donotetracks("reactanim");
	}

	self notify("newEnemyReactionDone");
	self.playing_new_enemy_reaction_anim = undefined;
}

//Function Number: 11
newenemysurprisedreaction()
{
	self endon("death");
	if(isdefined(self.disablereactionanims))
	{
		return;
	}

	if(!canreactagain())
	{
		return;
	}

	if(self.a.pose == "prone" || isdefined(self.a.onback))
	{
		return;
	}

	self animmode("gravity");
	if(isdefined(self.enemy))
	{
		newenemyreactionanim();
	}
}

//Function Number: 12
end_script()
{
	if(isdefined(self.playing_new_enemy_reaction_anim))
	{
		self notify("newEnemyReactionDone");
		self.playing_new_enemy_reaction_anim = undefined;
	}
}
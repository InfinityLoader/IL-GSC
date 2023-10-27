/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\reactions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 182 ms
 * Timestamp: 10/27/2023 2:18:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::func_D15("reactions");
	func_0F2C();
}

//Function Number: 2
func_0F1C()
{
	anim.var_F1D = [];
	level.var_F1D[level.var_F1D.size] = %run_react_duck;
	level.var_F1D[level.var_F1D.size] = %run_react_flinch;
	level.var_F1D[level.var_F1D.size] = %run_react_stumble;
	anim.var_F1E = 0;
	anim.var_F1F = [];
	level.var_F1F["cover_stand"] = animscripts/utility::array(%stand_cover_reaction_a,%stand_cover_reaction_b);
	level.var_F1F["cover_crouch"] = animscripts/utility::array(%crouch_cover_reaction_a,%crouch_cover_reaction_b);
	level.var_F1F["cover_left"] = animscripts/utility::array(%cornerstndl_react_a);
	level.var_F1F["cover_right"] = animscripts/utility::array(%cornerstndr_react_a);
}

//Function Number: 3
func_0F20()
{
	thread func_0F27();
}

//Function Number: 4
func_0F21()
{
	return !isdefined(self.var_F22) || gettime() - self.var_F22 > 2000;
}

//Function Number: 5
func_0F23()
{
	self endon("killanimscript");
	self.var_F22 = gettime();
	self.a.movement = "stop";
	var_00 = isdefined(self.var_F24) && distancesquared(self.origin,self.var_F24.origin) < 160000;
	self animmode("gravity");
	self orientmode("face current");
	if(var_00 || common_scripts\utility::cointoss())
	{
		self clearanim(%root,0.1);
		var_01 = [];
		var_02 = var_7B[randomint(var_7B.size)];
		if(var_01)
		{
			var_03 = 1 + randomfloat(0.5);
		}
		else
		{
			var_03 = 0.2 + randomfloat(0.5);
		}

		self setflaggedanimknobrestart("reactanim",var_02,1,0.1,1);
		animscripts/notetracks::func_D4F(var_03,"reactanim");
		self clearanim(%root,0.1);
		if(!var_01 && self.var_786 == "none" && !isdefined(self.var_F25))
		{
			var_04 = 1 + randomfloat(0.2);
			var_05 = animscripts/utility::func_F26(%exposed_dive_grenade_b,%exposed_dive_grenade_f);
			self setflaggedanimknobrestart("dive",var_05,1,0.1,var_04);
			animscripts/shared::donotetracks("dive");
		}
	}
	else
	{
		wait randomfloat(0.2);
		var_04 = 1.2 + randomfloat(0.3);
		if(self.a.pose == "stand")
		{
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("crouch",%exposed_stand_2_crouch,1,0.1,var_04);
			animscripts/shared::donotetracks("crouch");
		}

		var_06 = anglestoforward(self.angles);
		if(isdefined(self.var_F24))
		{
			var_07 = vectornormalize(self.var_F24.origin - self.origin);
		}
		else
		{
			var_07 = var_07;
		}

		if(vectordot(var_07,var_06) > 0)
		{
			var_08 = animscripts/utility::func_F26(%exposed_crouch_idle_twitch_v2,%exposed_crouch_idle_twitch_v3);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("twitch",var_08,1,0.1,1);
			animscripts/shared::donotetracks("twitch");
		}
		else
		{
			var_09 = animscripts/utility::func_F26(%exposed_crouch_turn_180_left,%exposed_crouch_turn_180_right);
			self clearanim(%root,0.1);
			self setflaggedanimknobrestart("turn",var_09,1,0.1,1);
			animscripts/shared::donotetracks("turn");
		}
	}

	self clearanim(%root,0.1);
	self.var_F24 = undefined;
	self animmode("normal");
	self orientmode("face default");
}

//Function Number: 6
func_0F27()
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

		if(isdefined(self.var_CAF) || isdefined(self.var_CF1))
		{
			continue;
		}

		if(self.a.pose != "stand")
		{
			continue;
		}

		if(!func_0F21())
		{
			continue;
		}

		self.var_F24 = var_00;
		self animcustom(::func_0F23);
	}
}

//Function Number: 7
func_0F28()
{
	self endon("killanimscript");
	wait 0.3;
	self setlookatentity();
}

//Function Number: 8
func_0F29()
{
	var_00 = undefined;
	if(self nearclaimnodeandangle() && isdefined(level.var_F1F[self.var_788]))
	{
		var_01 = anglestoforward(self.node.angles);
		var_02 = vectornormalize(self.var_731 - self.origin);
		if(vectordot(var_01,var_02) < -0.5)
		{
			self orientmode("face current");
			var_03 = randomint(level.var_F1F[self.var_788].size);
			var_00 = level.var_F1F[self.var_788][var_03];
		}
	}

	if(!isdefined(var_00))
	{
		var_04 = [];
		if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.var_731) < 65536)
		{
			self orientmode("face enemy");
		}
		else
		{
			self orientmode("face point",self.var_731);
		}

		if(self.a.pose == "crouch")
		{
			var_02 = vectornormalize(self.var_731 - self.origin);
			var_05 = anglestoforward(self.angles);
			if(vectordot(var_05,var_02) < -0.5)
			{
				self orientmode("face current");
				var_7B[0] = %crouch_cover_reaction_a;
				var_7B[1] = %crouch_cover_reaction_b;
			}
		}

		var_04 = var_7B[randomint(var_7B.size)];
	}

	return var_04;
}

//Function Number: 9
func_0F2A()
{
	self clearanim(%root,0.2);
	if(randomint(4) < 3)
	{
		self orientmode("face enemy");
		self setflaggedanimknobrestart("reactanim",%exposed_idle_reactb,1,0.2,1);
		var_00 = getanimlength(%exposed_idle_reactb);
		animscripts/notetracks::func_D4F(var_00 * 0.8,"reactanim");
		self orientmode("face current");
		return;
	}

	self orientmode("face enemy");
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal,1,0.2,1);
	var_00 = getanimlength(%exposed_backpedal);
	animscripts/notetracks::func_D4F(var_00 * 0.8,"reactanim");
	self orientmode("face current");
	self clearanim(%root,0.2);
	self setflaggedanimknobrestart("reactanim",%exposed_backpedal_v2,1,0.2,1);
	animscripts/shared::donotetracks("reactanim");
}

//Function Number: 10
func_0F2B()
{
	self endon("death");
	self endon("endNewEnemyReactionAnim");
	self.var_F22 = gettime();
	self.a.movement = "stop";
	if(isdefined(self._stealth) && self.var_74A != "combat")
	{
		func_0F2A();
	}
	else
	{
		var_00 = func_0F29();
		self clearanim(%root,0.2);
		self setflaggedanimknobrestart("reactanim",var_00,1,0.2,1);
		animscripts/shared::donotetracks("reactanim");
	}

	self notify("newEnemyReactionDone");
}

//Function Number: 11
func_0F2C()
{
	self endon("death");
	if(isdefined(self.var_F2D))
	{
		return;
	}

	if(!func_0F21())
	{
		return;
	}

	if(self.a.pose == "prone" || isdefined(self.a.var_D29))
	{
		return;
	}

	self animmode("gravity");
	if(isdefined(self.enemy))
	{
		func_0F2B();
	}
}
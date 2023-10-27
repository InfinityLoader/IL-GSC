/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\walk.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 76 ms
 * Timestamp: 10/27/2023 2:31:02 AM
*******************************************************************/

//Function Number: 1
movewalk()
{
	var_00 = undefined;
	if(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > 4096)
	{
		var_00 = "stand";
	}

	var_01 = [[ self.chooseposefunc ]](var_00);
	switch(var_01)
	{
		case "stand":
			if(animscripts/setposemovement::beginstandwalk())
			{
				return;
			}
	
			if(isdefined(self.walk_overrideanim))
			{
				animscripts/move::movestandmoveoverride(self.walk_overrideanim,self.walk_override_weights);
				return;
			}
	
			dowalkanim(getwalkanim("straight"));
			break;

		case "crouch":
			if(animscripts/setposemovement::func_C6E())
			{
				return;
			}
	
			dowalkanim(getwalkanim("crouch"));
			break;

		default:
			if(animscripts/setposemovement::beginpronewalk())
			{
				return;
			}
	
			self.a.movement = "walk";
			dowalkanim(getwalkanim("prone"));
			break;
	}
}

//Function Number: 2
dowalkanimoverride(param_00)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isarray(self.walk_overrideanim))
	{
		if(isdefined(self.walk_override_weights))
		{
			var_01 = common_scripts\utility::choose_from_weighted_array(self.walk_overrideanim,self.walk_override_weights);
		}
		else
		{
			var_01 = self.walk_overrideanim[randomint(self.walk_overrideanim.size)];
		}
	}
	else
	{
		var_01 = self.walk_overrideanim;
	}

	self setflaggedanimknob("moveanim",var_01,1,0.2);
	animscripts/shared::donotetracks("moveanim");
}

//Function Number: 3
getwalkanim(param_00)
{
	if(self.stairsstate == "up")
	{
		return animscripts/utility::moveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts/utility::moveanim("stairs_down");
	}

	var_01 = animscripts/utility::moveanim(param_00);
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 4
dowalkanim(param_00)
{
	self endon("movemode");
	var_01 = self.moveplaybackrate;
	if(self.stairsstate != "none")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.a.var_911 == "stand")
	{
		if(isdefined(self.enemy))
		{
			thread animscripts/cqb::cqbtracking();
			self setflaggedanimknoball("walkanim",animscripts/cqb::determinecqbanim(),%walk_and_run_loops,1,1,var_01,1);
		}
		else
		{
			self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		}

		animscripts/run::setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
		thread animscripts/run::setcombatstandmoveanimweights("walk");
	}
	else
	{
		self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		animscripts/run::setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
		thread animscripts/run::setcombatstandmoveanimweights("walk");
	}

	animscripts/notetracks::donotetracksfortime(0.2,"walkanim");
	thread animscripts/run::stopshootwhilemovingthreads();
}
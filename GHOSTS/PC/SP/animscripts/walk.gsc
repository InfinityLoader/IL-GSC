/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\walk.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 1:24:44 AM
*******************************************************************/

//Function Number: 1
func_54C5()
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
			if(animscripts/setposemovement::standwalk_begin())
			{
				return;
			}
	
			if(isdefined(self.var_8BD8))
			{
				animscripts/move::func_54A4(self.var_8BD8,self.var_8BD7);
				return;
			}
	
			func_2A2C(getwalkanim("straight"));
			break;

		case "crouch":
			if(animscripts/setposemovement::func_2164())
			{
				return;
			}
	
			func_2A2C(getwalkanim("crouch"));
			break;

		default:
			if(animscripts/setposemovement::func_620D())
			{
				return;
			}
	
			self.a.var_5486 = "walk";
			func_2A2C(getwalkanim("prone"));
			break;
	}
}

//Function Number: 2
dowalkanimoverride(param_00)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isarray(self.var_8BD8))
	{
		if(isdefined(self.var_8BD7))
		{
			var_01 = common_scripts\utility::choose_from_weighted_array(self.var_8BD8,self.var_8BD7);
		}
		else
		{
			var_01 = self.var_8BD8[randomint(self.var_8BD8.size)];
		}
	}
	else
	{
		var_01 = self.var_8BD8;
	}

	self setflaggedanimknob("moveanim",var_01,1,0.2);
	animscripts/shared::func_2986("moveanim");
}

//Function Number: 3
getwalkanim(param_00)
{
	if(self.stairsstate == "up")
	{
		return animscripts/utility::getmoveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts/utility::getmoveanim("stairs_down");
	}

	var_01 = animscripts/utility::getmoveanim(param_00);
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 4
func_2A2C(param_00)
{
	self endon("movemode");
	var_01 = self.moveplaybackrate;
	if(self.stairsstate != "none")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.a.var_60B1 == "stand")
	{
		if(isdefined(self.enemy))
		{
			animscripts/cqb::cqbtracking();
			self setflaggedanimknoball("walkanim",animscripts/cqb::determinecqbanim(),%walk_and_run_loops,1,1,var_01,1);
		}
		else
		{
			self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		}

		animscripts/run::setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
		thread animscripts/run::func_7008("walk");
	}
	else if(self.a.var_60B1 == "prone")
	{
		self setflaggedanimknob("walkanim",animscripts/utility::getmoveanim("prone"),1,0.3,self.moveplaybackrate);
	}
	else
	{
		self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		animscripts/run::setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
		thread animscripts/run::func_7008("walk");
	}

	animscripts/notetracks::donotetracksfortime(0.2,"walkanim");
	animscripts/run::func_70C6(0);
}
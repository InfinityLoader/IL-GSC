/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\walk.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 81 ms
 * Timestamp: 10/27/2023 2:18:58 AM
*******************************************************************/

//Function Number: 1
func_107F()
{
	var_00 = undefined;
	if(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > 4096)
	{
		var_00 = "stand";
	}

	var_01 = [[ self.var_FBA ]](var_00);
	switch(var_01)
	{
		case "stand":
			if(animscripts/setposemovement::func_1080())
			{
				return;
			}
	
			if(isdefined(self.walk_overrideanim))
			{
				animscripts/move::func_FBE(self.walk_overrideanim,self.walk_override_weights);
				return;
			}
	
			func_1087(func_1086("straight"));
			break;

		case "crouch":
			if(animscripts/setposemovement::func_1083())
			{
				return;
			}
	
			func_1087(func_1086("crouch"));
			break;

		default:
			if(animscripts/setposemovement::func_1084())
			{
				return;
			}
	
			self.a.movement = "walk";
			func_1087(func_1086("prone"));
			break;
	}
}

//Function Number: 2
func_1085(param_00)
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
func_1086(param_00)
{
	if(self.var_786 == "up")
	{
		return animscripts/utility::func_FC3("stairs_up");
	}
	else if(self.var_786 == "down")
	{
		return animscripts/utility::func_FC3("stairs_down");
	}

	var_01 = animscripts/utility::func_FC3(param_00);
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	return var_01;
}

//Function Number: 4
func_1087(param_00)
{
	self endon("movemode");
	var_01 = self.moveplaybackrate;
	if(self.var_786 != "none")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.a.pose == "stand")
	{
		if(isdefined(self.enemy))
		{
			thread animscripts/cqb::func_1079();
			self setflaggedanimknoball("walkanim",animscripts/cqb::func_1076(),%walk_and_run_loops,1,1,var_01,1);
		}
		else
		{
			self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		}

		animscripts/run::func_FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
		thread animscripts/run::func_FF8("walk");
	}
	else
	{
		self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		animscripts/run::func_FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
		thread animscripts/run::func_FF8("walk");
	}

	animscripts/notetracks::func_D4F(0.2,"walkanim");
	thread animscripts/run::func_FE5();
}
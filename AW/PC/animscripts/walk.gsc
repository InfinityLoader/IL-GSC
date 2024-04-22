/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: walk.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 2:01:11 AM
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
			if(animscripts\setposemovement::standwalk_begin())
			{
				return;
			}
	
			if(isdefined(self.walk_overrideanim))
			{
				animscripts\move::movestand_moveoverride(self.walk_overrideanim,self.walk_override_weights);
				return;
			}
	
			dowalkanim(getwalkanim("straight"));
			break;

		case "crouch":
			if(animscripts\setposemovement::crouchwalk_begin())
			{
				return;
			}
	
			dowalkanim(getwalkanim("crouch"));
			break;

		default:
			if(animscripts\setposemovement::pronewalk_begin())
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
	animscripts\shared::donotetracks("moveanim");
}

//Function Number: 3
getwalkanim(param_00)
{
	if(self.stairsstate == "up")
	{
		return animscripts\utility::getmoveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts\utility::getmoveanim("stairs_down");
	}

	var_01 = animscripts\utility::getmoveanim(param_00);
	if(!animscripts\utility::isincombat() && !isdefined(self.noruntwitch) && self.noruntwitch && !isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
	{
		var_02 = animscripts\utility::getmoveanim("straight_twitch");
		if(isdefined(self.isunstableground) && self.isunstableground)
		{
			var_03 = animscripts\traverse\shared::getnextfootdown();
			if(var_03 == "Left")
			{
				var_02 = animscripts\utility::getmoveanim("straight_twitch_l");
			}
			else if(var_03 == "Right")
			{
				var_02 = animscripts\utility::getmoveanim("straight_twitch_r");
			}
		}

		if(isdefined(var_02) && var_02.size > 0)
		{
			var_04 = animscripts\utility::getrandomintfromseed(self.a.runloopcount,4);
			if(var_04 == 0)
			{
				var_04 = animscripts\utility::getrandomintfromseed(self.a.runloopcount,var_02.size);
				return var_02[var_04];
			}
		}
	}

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

	if(self.a.pose == "stand")
	{
		if(isdefined(self.enemy))
		{
			animscripts\cqb::cqbtracking();
			self setflaggedanimknoball("walkanim",animscripts\cqb::determinecqbanim(),%walk_and_run_loops,1,1,var_01,1);
		}
		else
		{
			self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		}

		animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
		thread animscripts\run::setcombatstandmoveanimweights("walk");
	}
	else if(self.a.pose == "prone")
	{
		self setflaggedanimknob("walkanim",animscripts\utility::getmoveanim("prone"),1,0.3,self.moveplaybackrate);
	}
	else
	{
		self setflaggedanimknoball("walkanim",param_00,%body,1,1,var_01,1);
		animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
		thread animscripts\run::setcombatstandmoveanimweights("walk");
	}

	animscripts\notetracks::donotetracksfortime(0.2,"walkanim");
	animscripts\run::setshootwhilemoving(0);
}
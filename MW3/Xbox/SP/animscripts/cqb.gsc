/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cqb.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 2:30:18 AM
*******************************************************************/

//Function Number: 1
func_0C60()
{
	animscripts/run::changeweaponstandrun();
	if(self.a.var_911 != "stand")
	{
		self clearanim(%root,0.2);
		if(self.a.var_911 == "prone")
		{
			animscripts/utility::exitpronewrapper(1);
		}

		self.a.var_911 = "stand";
	}

	self.a.movement = self.movemode;
	thread cqbtracking();
	var_00 = determinecqbanim();
	var_01 = self.moveplaybackrate;
	if(self.movemode == "walk")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.stairsstate == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	self setflaggedanimknoball("runanim",var_00,%walk_and_run_loops,1,var_02,var_01,1);
	animscripts/run::setmovenonforwardanims(%walk_backward,%walk_left,%walk_right);
	thread animscripts/run::setcombatstandmoveanimweights("cqb");
	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
	thread animscripts/run::stopshootwhilemovingthreads();
}

//Function Number: 2
determinecqbanim()
{
	if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["cqb"]))
	{
		return animscripts/run::getrunanim();
	}

	if(self.stairsstate == "up")
	{
		return %traverse_stair_run;
	}

	if(self.stairsstate == "down")
	{
		return %traverse_stair_run_down_01;
	}

	if(self.movemode == "walk")
	{
		return %walk_cqb_f;
	}

	var_00 = animscripts/utility::getrandomintfromseed(self.a.runloopcount,2);
	if(var_00 == 0)
	{
		return %run_cqb_f_search_v1;
	}

	return %run_cqb_f_search_v2;
}

//Function Number: 3
cqbtracking()
{
	if(animscripts/move::mayshootwhilemoving())
	{
		animscripts/run::runshootwhilemovingthreads();
	}

	animscripts/run::faceenemyaimtracking();
}

//Function Number: 4
func_0C65()
{
	level.cqbpointsofinterest = [];
	var_00 = getentarray("cqb_point_of_interest","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.cqbpointsofinterest[var_01] = var_00[var_01].origin;
		var_00[var_01] delete();
	}
}

//Function Number: 5
func_0C67()
{
	if(isdefined(level.var_C68))
	{
		return;
	}

	anim.var_C68 = 1;
	if(!level.cqbpointsofinterest.size)
	{
		return;
	}

	for(;;)
	{
		var_00 = getaiarray();
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(isalive(var_03) && var_03 animscripts/utility::iscqbwalking() && !isdefined(var_03.disable_cqb_points_of_interest))
			{
				var_04 = var_03.a.movement != "stop";
				var_05 = (var_03.origin[0],var_03.origin[1],var_03 getshootatpos()[2]);
				var_06 = var_05;
				var_07 = anglestoforward(var_03.angles);
				if(var_04)
				{
					var_08 = bullettrace(var_06,var_06 + var_07 * 128,0,undefined);
					var_06 = var_08["position"];
				}

				var_09 = -1;
				var_0A = 1048576;
				for(var_0B = 0;var_0B < level.cqbpointsofinterest.size;var_0B++)
				{
					var_0C = level.cqbpointsofinterest[var_0B];
					var_0D = distancesquared(var_0C,var_06);
					if(var_0D < var_0A)
					{
						if(var_04)
						{
							if(distancesquared(var_0C,var_05) < 4096)
							{
								continue;
							}

							var_0E = vectordot(vectornormalize(var_0C - var_05),var_07);
							if(var_0E < 0.643 || var_0E > 0.966)
							{
								continue;
							}
						}
						else if(var_0D < 2500)
						{
							continue;
						}

						if(!sighttracepassed(var_06,var_0C,0,undefined))
						{
							continue;
						}

						var_0A = var_0D;
						var_09 = var_0B;
					}
				}

				if(var_09 < 0)
				{
					var_03.cqb_point_of_interest = undefined;
				}
				else
				{
					var_03.cqb_point_of_interest = level.cqbpointsofinterest[var_09];
				}

				wait 0.05;
				var_01 = 1;
			}
		}

		if(!var_01)
		{
			wait 0.25;
		}
	}
}
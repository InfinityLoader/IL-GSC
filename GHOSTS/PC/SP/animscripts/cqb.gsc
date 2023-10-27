/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cqb.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 137 ms
 * Timestamp: 10/27/2023 1:23:54 AM
*******************************************************************/

//Function Number: 1
func_5479()
{
	animscripts/run::func_79D6();
	if(self.a.var_60B1 != "stand")
	{
		self clearanim(%root,0.2);
		if(self.a.var_60B1 == "prone")
		{
			animscripts/utility::exitpronewrapper(1);
		}

		self.a.var_60B1 = "stand";
	}

	self.a.var_5486 = self.movemode;
	cqbtracking();
	if(animscripts/run::func_5438())
	{
		return;
	}

	self clearanim(%stair_transitions,0.2);
	if(animscripts/run::standrun_checkreload())
	{
		return;
	}

	if(isdefined(self.var_8122))
	{
		var_00 = self.var_8122;
	}
	else
	{
		var_00 = 0;
	}

	self.var_8122 = gettime();
	var_01 = determinecqbanim();
	if(self.stairsstate == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	var_03 = 0.2;
	var_04 = %walk_and_run_loops;
	if(self.var_8122 - var_00 > var_03 * 1000)
	{
		var_04 = %stand_and_crouch;
	}

	self setflaggedanimknoball("runanim",var_01,var_04,1,var_02,self.moveplaybackrate,1);
	cqb_playfacialanim(var_01);
	animscripts/run::setmovenonforwardanims(animscripts/utility::lookupanim("cqb","move_b"),animscripts/utility::lookupanim("cqb","move_l"),animscripts/utility::lookupanim("cqb","move_r"));
	thread animscripts/run::func_7008("cqb");
	animscripts/notetracks::donotetracksfortime(var_03,"runanim");
}

//Function Number: 2
determinecqbanim()
{
	if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["cqb"]))
	{
		return animscripts/run::func_3BDB();
	}

	if(self.stairsstate == "up")
	{
		return animscripts/utility::lookupanim("cqb","stairs_up");
	}

	if(self.stairsstate == "down")
	{
		return animscripts/utility::lookupanim("cqb","stairs_down");
	}

	if(self.movemode == "walk")
	{
		return animscripts/utility::lookupanim("cqb","move_f");
	}

	if(isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
	{
		return animscripts/utility::lookupanim("cqb","straight");
	}

	var_00 = animscripts/utility::lookupanim("cqb","straight_twitch");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return animscripts/utility::lookupanim("cqb","straight");
	}

	var_01 = animscripts/utility::func_3BBB(self.a.var_698E,4);
	if(var_01 == 0)
	{
		var_02 = animscripts/utility::func_3BBB(self.a.var_698E,var_00.size);
		return var_00[var_02];
	}

	return animscripts/utility::lookupanim("cqb","straight");
}

//Function Number: 3
cqb_reloadinternal()
{
	self endon("movemode");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts/combat_utility::getuniqueflagnameindex();
	var_01 = animscripts/utility::lookupanim("cqb","reload");
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	self setflaggedanimknoballrestart(var_00,var_01,%body,1,0.25);
	cqb_playfacialanim(var_01);
	animscripts/run::setmovenonforwardanims(animscripts/utility::lookupanim("cqb","move_b"),animscripts/utility::lookupanim("cqb","move_l"),animscripts/utility::lookupanim("cqb","move_r"));
	thread animscripts/run::func_7008("cqb");
	animscripts/shared::func_2986(var_00);
}

//Function Number: 4
cqbtracking()
{
	var_00 = self.stairsstate != "none";
	var_01 = !var_00 && animscripts/move::func_5127();
	animscripts/run::func_70C6(var_01);
	if(var_00)
	{
		animscripts/run::func_2D51();
	}

	thread animscripts/run::faceenemyaimtracking();
}

//Function Number: 5
setupcqbpointsofinterest()
{
	level.cqbpointsofinterest = [];
	var_00 = getentarray("cqb_point_of_interest","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.cqbpointsofinterest[var_01] = var_00[var_01].origin;
		var_00[var_01] delete();
	}
}

//Function Number: 6
func_3284()
{
	if(isdefined(level.var_3286))
	{
	}

	anim.var_3286 = 1;
	if(!level.cqbpointsofinterest.size)
	{
	}

	for(;;)
	{
		var_00 = getaiarray();
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(isalive(var_03) && var_03 animscripts/utility::func_48A0() && !isdefined(var_03.disable_cqb_points_of_interest))
			{
				var_04 = var_03.a.var_5486 != "stop";
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

				wait(0.05);
				var_01 = 1;
			}
		}

		if(!var_01)
		{
			wait(0.25);
		}
	}
}

//Function Number: 7
cqb_playfacialanim(param_00)
{
	self.facialidx = animscripts/face::func_6004(param_00,"run",self.facialidx);
}

//Function Number: 8
cqb_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}
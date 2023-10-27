/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cqb.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 94 ms
 * Timestamp: 10/27/2023 2:18:14 AM
*******************************************************************/

//Function Number: 1
func_1075()
{
	animscripts/run::func_FFD();
	if(self.a.pose != "stand")
	{
		self clearanim(%root,0.2);
		if(self.a.pose == "prone")
		{
			animscripts/utility::func_F7D(1);
		}

		self.a.pose = "stand";
	}

	self.a.movement = self.movemode;
	thread func_1079();
	var_00 = func_1076();
	var_01 = self.moveplaybackrate;
	if(self.movemode == "walk")
	{
		var_01 = var_01 * 0.6;
	}

	if(self.var_786 == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	self setflaggedanimknoball("runanim",var_00,%walk_and_run_loops,1,var_02,var_01,1);
	animscripts/run::func_FF7(%walk_backward,%walk_left,%walk_right);
	thread animscripts/run::func_FF8("cqb");
	animscripts/notetracks::func_D4F(0.2,"runanim");
	thread animscripts/run::func_FE5();
}

//Function Number: 2
func_1076()
{
	if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["cqb"]))
	{
		return animscripts/run::func_FC2();
	}

	if(self.var_786 == "up")
	{
		return %traverse_stair_run;
	}

	if(self.var_786 == "down")
	{
		return %traverse_stair_run_down_01;
	}

	if(self.movemode == "walk")
	{
		return %walk_cqb_f;
	}

	var_00 = animscripts/utility::func_1078(self.a.var_1077,2);
	if(var_00 == 0)
	{
		return %run_cqb_f_search_v1;
	}

	return %run_cqb_f_search_v2;
}

//Function Number: 3
func_1079()
{
	if(animscripts/move::func_FDE())
	{
		animscripts/run::func_FE3();
	}

	animscripts/run::func_FE1();
}

//Function Number: 4
func_107A()
{
	level.var_107B = [];
	var_00 = getentarray("cqb_point_of_interest","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.var_107B[var_01] = var_00[var_01].origin;
		var_00[var_01] delete();
	}
}

//Function Number: 5
func_107C()
{
	if(isdefined(level.var_107D))
	{
		return;
	}

	anim.var_107D = 1;
	if(!level.var_107B.size)
	{
		return;
	}

	for(;;)
	{
		var_00 = getaiarray();
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(isalive(var_03) && var_03 animscripts/utility::func_C98() && !isdefined(var_03.var_107E))
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
				for(var_0B = 0;var_0B < level.var_107B.size;var_0B++)
				{
					var_0C = level.var_107B[var_0B];
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
					var_03.cqb_point_of_interest = level.var_107B[var_09];
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
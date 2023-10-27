/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1381.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 3:25:55 AM
*******************************************************************/

//Function Number: 1
func_5373()
{
	level thread func_400A();
}

//Function Number: 2
unlocksurvivalmaps()
{
	if(!function_02A3())
	{
		return;
	}

	if(getdvarint("spv_shattered_srv_unlock_auto",0) == 0)
	{
		return;
	}

	var_00 = self;
	var_00 ae_reportcomplexgameevent(42,[5,5]);
}

//Function Number: 3
getzombiegeareventvalue(param_00)
{
	switch(param_00)
	{
		case "raven_set":
			return 2;

		case "treasure_set":
			return 1;

		case "assassin_set":
			return 3;

		case "survivalist_set":
			return 4;

		case "mountain_man_set":
			return 5;

		case "bat_elite_set":
			return 6;

		case "hunter_blood_set":
			return 12;

		case "hunter_bat_set":
			return 11;

		case "hunter_origin_set":
			return 10;

		case "mountain_man_blood_set":
			return 15;

		case "mountain_man_bat_set":
			return 14;

		case "mountain_man_origin_set":
			return 13;

		case "survivalist_blood_set":
			return 9;

		case "survivalist_bat_set":
			return 8;

		case "survivalist_origin_set":
			return 7;

		case "assassin_blood_set":
			return 18;

		case "assassin_bat_set":
			return 17;

		case "assassin_origin_set":
			return 16;

		case "surgeon_set":
			return 19;

		case "rebel_set":
			return 20;

		case "super_soldier_set":
			return 21;

		case "arrow_set":
			return 23;

		case "captain_set":
			return 24;

		case "explorer_set":
			return 25;

		case "african_set":
			return 26;

		case "outlaw_set":
			return 27;

		case "arabic_set":
			return 28;

		case "wicht_set":
			return 29;
	}
}

//Function Number: 4
func_7C07(param_00)
{
	if(!isdefined(level.var_400C))
	{
		level.var_400C = [];
	}

	level.var_400C[param_00] = 16;
}

//Function Number: 5
func_400A()
{
	level endon("game_over");
	self endon("disconnect");
	if(!isdefined(level.var_400E))
	{
		level.var_400E = [];
	}

	if(!isdefined(level.var_400C))
	{
		level.var_400C = [];
	}

	if(!isdefined(level.var_400D))
	{
		level.var_400D = [];
	}

	for(;;)
	{
		if(level.var_400E.size > 0)
		{
			foreach(var_01 in level.var_400E)
			{
				var_02 = strtok(var_01[0]," ");
				var_03 = var_02[0];
				var_04 = int(var_02[1]);
				var_05 = int(var_02[2]);
				var_06 = var_01[1];
				var_07 = var_03 + var_04;
				var_08 = level.var_400C[var_03];
				if(!isdefined(var_08))
				{
					continue;
				}

				if(common_scripts\utility::func_562E(level.var_400D[var_07]))
				{
					continue;
				}

				if(var_05 < 0)
				{
					level.var_400D[var_07] = 1;
					continue;
				}

				if(!isdefined(var_06))
				{
					continue;
				}

				if(common_scripts\utility::func_562E(level.var_6B4D))
				{
					if(isstring(var_06) && var_06 == "all")
					{
						if(!isdefined(level.var_744A))
						{
							continue;
						}

						foreach(var_0A in level.var_744A)
						{
							var_0A func_83DB(var_08,var_04,var_05,var_03);
						}

						continue;
					}

					if(!function_0279(var_06) && isplayer(var_06))
					{
						var_06 func_83DB(var_08,var_04,var_05,var_03);
					}
				}
			}

			level.var_400E = [];
		}

		wait 0.05;
	}
}

//Function Number: 6
func_83DB(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::func_562E(self.var_596A))
	{
		return;
	}

	if(!isdefined(self.var_400B))
	{
		self.var_400B = [];
	}

	var_04 = param_03 + param_01;
	if(common_scripts\utility::func_562E(self.var_400B[var_04]))
	{
		return;
	}

	self.var_400B[var_04] = 1;
	thread maps\mp\gametypes\_hud_message::func_9102(var_04 + "_objective_complete");
	lib_0468::func_A2B(param_03,param_01);
}

//Function Number: 7
getchallengesplashref(param_00,param_01)
{
	return param_00 + param_01 + "_objective_complete";
}

//Function Number: 8
zombiegearchallengecompleteall(param_00,param_01)
{
	var_02 = get_is_testing_offline();
	foreach(var_04 in level.var_744A)
	{
		var_04 zombiegearchallengecomplete(param_00,param_01,var_02);
	}
}

//Function Number: 9
zombiegearchallengecomplete(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = getchallengesplashref(param_00,param_01);
	var_05 = getzombiegeareventvalue(param_00);
	var_06 = [3,var_05,4,param_01];
	if(!common_scripts\utility::func_562E(param_02))
	{
		var_03 ae_reportcomplexgameevent(16,var_06);
	}

	var_03 thread maps\mp\gametypes\_hud_message::func_9102(var_04);
}

//Function Number: 10
zombiegearchallengethread(param_00)
{
	var_01 = self;
	var_01 endon("disconnect");
	var_02 = param_00.splashrefprefix;
	var_03 = param_00.challengebitindex;
	var_04 = param_00.challengefunc;
	var_05 = var_01 wait_for_challenge_return(var_04);
	var_06 = get_is_testing_offline();
	if(!level.var_6B4D && !var_06)
	{
		return;
	}

	if(!common_scripts\utility::func_562E(var_05))
	{
		return;
	}

	var_01 zombiegearchallengecomplete(var_02,var_03,var_06);
}

//Function Number: 11
get_is_testing_offline()
{
	var_00 = 0;
	return var_00;
}

//Function Number: 12
wait_for_challenge_return(param_00)
{
	var_01 = self [[ param_00 ]]();
	return var_01;
}

//Function Number: 13
zombiegearchallengeregister(param_00,param_01,param_02)
{
	foreach(var_07, var_04 in param_01)
	{
		var_05 = spawnstruct();
		var_05.splashrefprefix = param_00;
		var_05.challengebitindex = var_07;
		var_05.challengefunc = var_04;
		if(isdefined(param_02))
		{
			var_06 = param_02 + var_07;
		}
		else
		{
			var_06 = undefined;
		}

		level thread maps\mp\_utility::func_6F74(::zombiegearchallengethread,var_05,var_06);
	}
}
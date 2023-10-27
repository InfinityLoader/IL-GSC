/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\contracts_coop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 522 ms
 * Timestamp: 10/27/2023 12:09:10 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!mayprocesscontracts())
	{
		return;
	}

	var_00 = spawnstruct();
	level.contractglobals = var_00;
	scripts\cp\contractchallenges_coop::registercontractchallenges();
	var_00.numchallenges = 0;
	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow("cp/contractChallengesZM.csv",var_01,0);
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		var_00.numchallenges++;
		var_01++;
	}

	level thread func_C56E();
}

//Function Number: 2
mayprocesscontracts()
{
	if(level.onlinegame)
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
contractsenabled()
{
	if(isai(self))
	{
		return 0;
	}

	if(getdvarint("mission_team_contracts_enabled",0) == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!var_00 contractsenabled())
		{
			continue;
		}

		var_00.contracts = [];
		var_01 = var_00 getchallengeids();
		foreach(var_04, var_03 in var_01)
		{
			var_00 givecontractchallenge(var_03,var_04);
		}
	}
}

//Function Number: 5
getchallengeids()
{
	var_00 = self getplayerdata("cp","contracts","challenges",0,"challengeID");
	var_01 = self getplayerdata("cp","contracts","challenges",1,"challengeID");
	return [var_00,var_01];
}

//Function Number: 6
givecontractchallenge(param_00,param_01)
{
	var_02 = lookupcontractchallengeref(param_00);
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = spawnstruct();
	var_03.var_10307 = param_01;
	var_03.var_DE3F = var_02;
	var_03.target = lookupcontractchallengetarget(param_00);
	var_03.team = lookupcontractchallengeteam(param_00);
	var_03.var_92B8 = param_00;
	var_03.var_D9D9 = self getplayerdata("cp","contracts","challenges",var_03.var_10307,"progress");
	var_04 = 0;
	var_03.completed = var_03.var_D9D9 >= var_03.target;
	if(!var_03.completed)
	{
		self thread [[ level.contractchallenges[var_03.var_DE3F] ]](var_03);
		self.contracts[param_01] = var_03;
	}
}

//Function Number: 7
lookupcontractchallengeref(param_00)
{
	var_01 = tablelookup("cp/contractChallengesZM.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return undefined;
	}

	return var_01;
}

//Function Number: 8
lookupcontractchallengetarget(param_00)
{
	var_01 = tablelookup("cp/contractChallengesZM.csv",0,param_00,3);
	if(!isdefined(var_01) || var_01 == "")
	{
		return undefined;
	}

	return int(var_01);
}

//Function Number: 9
lookupcontractchallengeteam(param_00)
{
	var_01 = tablelookup("cp/contractChallengesZM.csv",0,param_00,2);
	if(!isdefined(var_01) || var_01 == "")
	{
		return undefined;
	}

	return int(var_01);
}

//Function Number: 10
updatecontractprogress(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	param_00.var_D9D9 = param_00.var_D9D9 + param_01;
	param_00.var_D9D9 = int(min(param_00.var_D9D9,param_00.target));
	if(!param_00.completed)
	{
		param_00.completed = param_00.var_D9D9 >= param_00.target;
		if(param_00.completed)
		{
			var_02 = scripts\common\utility::func_116D7(param_00.team == -1,"contract_complete_joint_ops","contract_complete_team_" + param_00.team);
			thread scripts\cp\_hud_message::func_10151(var_02);
			self setplayerdata("cp","contracts","challenges",param_00.var_10307,"completed",1);
		}
	}

	self setplayerdata("cp","contracts","challenges",param_00.var_10307,"progress",param_00.var_D9D9);
}
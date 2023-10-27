/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\reactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 546 ms
 * Timestamp: 10/27/2023 12:00:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		return;
	}

	self endon("killanimscript");
	scripts\anim\utility::func_9832("reactions");
	func_BF22();
}

//Function Number: 2
func_951D()
{
}

//Function Number: 3
func_DD51()
{
	thread func_325D();
}

//Function Number: 4
func_38FD()
{
	return !isdefined(self.var_A9D9) || gettime() - self.var_A9D9 > 2000;
}

//Function Number: 5
func_325E()
{
}

//Function Number: 6
func_325D()
{
	self endon("killanimscript");
	if(isdefined(self.var_55B5))
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

		if(isdefined(self.var_473C) || isdefined(self.var_1E2C))
		{
			continue;
		}

		if(self.var_1491.var_D6A5 != "stand")
		{
			continue;
		}

		if(!func_38FD())
		{
			continue;
		}

		self.var_13D13 = var_00;
		self method_8015(::func_325E);
	}
}

//Function Number: 7
func_41C3()
{
	self endon("killanimscript");
	wait(0.3);
	self method_8306();
}

//Function Number: 8
func_7FE1()
{
}

//Function Number: 9
func_10F51()
{
}

//Function Number: 10
func_BF20()
{
	self endon("death");
	self endon("endNewEnemyReactionAnim");
	self.var_A9D9 = gettime();
	self.var_1491.var_BCC8 = "stop";
	if(isdefined(self.var_1412) && self.var_28 != "combat")
	{
		func_10F51();
	}
	else
	{
		var_00 = func_7FE1();
		self method_806F(%root,0.2);
		self method_82E7("reactanim",var_00,1,0.2,1);
		scripts\anim\shared::func_592B("reactanim");
	}

	self notify("newEnemyReactionDone");
}

//Function Number: 11
func_BF22()
{
	self endon("death");
	if(isdefined(self.var_560E))
	{
		return;
	}

	if(!func_38FD())
	{
		return;
	}

	if(self.var_1491.var_D6A5 == "prone" || isdefined(self.var_1491.var_C4C8))
	{
		return;
	}

	self method_8016("gravity");
	if(isdefined(self.var_10C))
	{
		func_BF20();
	}
}
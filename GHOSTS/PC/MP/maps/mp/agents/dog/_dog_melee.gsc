/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_melee.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 329 ms
 * Timestamp: 10/27/2023 1:16:36 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	var_00 = self.curmeleetarget.origin - self.origin;
	var_01 = length(var_00);
	var_02 = 1;
	if(var_01 < self.attackoffset)
	{
		var_03 = self.origin;
		var_02 = 0;
	}
	else
	{
		var_01 = var_01 / var_02;
		var_03 = self.curmeleetarget.origin - var_01 * self.attackoffset;
	}

	var_04 = 0;
	var_05 = self.origin + (0,0,30);
	var_06 = self.curmeleetarget.origin + (0,0,30);
	var_07 = physicstrace(var_05,var_06);
	if(distancesquared(var_07,var_06) > 1)
	{
		meleefailed();
		return;
	}

	if(var_02)
	{
		var_08 = maps/mp/agents/_scriptedagents::canmovepointtopoint(self.origin,var_03);
	}
	else
	{
		var_08 = 1;
	}

	var_09 = undefined;
	if(!var_08)
	{
		var_0A = 0;
	}
	else
	{
		var_0A = func_74A7(self.curmeleetarget);
		var_0A = isdefined(var_0A);
	}

	self.blockgoalpos = 1;
	if(var_0A)
	{
		func_2879(var_09);
		return;
	}

	func_2A13(var_03,var_08);
}

//Function Number: 2
end_script()
{
	self scragentsetanimscale(1,1);
	self.blockgoalpos = 0;
}

//Function Number: 3
func_3B2B()
{
	return "attack_run_and_jump";
}

//Function Number: 4
func_74A7(param_00)
{
	if(!self.enableextendedkill)
	{
		return undefined;
	}

	var_01 = 4;
	if(!maps\mp\_utility::func_48CE(param_00))
	{
		return undefined;
	}

	if(func_493F(param_00))
	{
		return undefined;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return undefined;
	}

	var_02 = self.origin - param_00.origin;
	if(abs(var_02[2]) > var_01)
	{
		return undefined;
	}

	var_03 = vectornormalize((var_02[0],var_02[1],0));
	var_04 = anglestoforward(param_00.angles);
	var_05 = vectordot(var_04,var_03);
	if(var_05 > 0.707)
	{
		var_06 = 0;
		var_07 = rotatevector((1,0,0),param_00.angles);
	}
	else if(var_07 < -0.707)
	{
		var_06 = 1;
		var_07 = rotatevector((-1,0,0),var_01.angles);
	}
	else
	{
		var_08 = maps/mp/agents/dog/_dog_think::func_214C(var_04,var_06);
		if(var_08 > 0)
		{
			var_06 = 3;
			var_07 = rotatevector((0,-1,0),param_00.angles);
		}
		else
		{
			var_06 = 2;
			var_07 = rotatevector((0,1,0),param_00.angles);
		}
	}

	if(var_06 == 1)
	{
		var_09 = 128;
	}
	else
	{
		var_09 = 96;
	}

	var_0A = param_00.origin - var_09 * var_07;
	var_0B = maps/mp/agents/_scriptedagents::droppostoground(var_0A);
	if(!isdefined(var_0B))
	{
		return undefined;
	}

	if(abs(var_0B[2] - var_0A[2]) > var_01)
	{
		return undefined;
	}

	if(!self aiphysicstracepassed(param_00.origin + (0,0,4),var_0B + (0,0,4),self.radius,self.height))
	{
		return undefined;
	}

	return var_06;
}

//Function Number: 5
func_2879(param_00)
{
	var_01 = "attack_extended";
	func_2970(self.curmeleetarget,self.curmeleetarget.health,"MOD_MELEE_DOG");
	var_02 = self getanimentry(var_01,param_00);
	thread func_3107(var_02,self.curmeleetarget.origin,self.curmeleetarget.angles);
	if(param_00 == 1)
	{
		self playsoundonmovingent(common_scripts\utility::func_803F(self.biswolf,"mp_wolf_attack_quick_back_npc","mp_dog_attack_quick_back_npc"));
	}
	else
	{
		self playsoundonmovingent(common_scripts\utility::func_803F(self.biswolf,"mp_wolf_attack_short_npc","mp_dog_attack_short_npc"));
	}

	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_01,param_00,"attack","end");
	self notify("kill_stick");
	self.curmeleetarget = undefined;
	self scragentsetanimmode("anim deltas");
	self unlink();
}

//Function Number: 6
func_3107(param_00,param_01,param_02)
{
	self endon("death");
	self endon("killanimscript");
	self endon("kill_stick");
	wait(0.05);
	if(isalive(self.curmeleetarget))
	{
	}

	var_03 = self.curmeleetarget getcorpseentity();
	self linkto(var_03);
	self scragentdoanimrelative(param_00,param_01,param_02);
}

//Function Number: 7
func_2A13(param_00,param_01)
{
	var_02 = func_3B2B();
	var_03 = 0;
	if(!param_01)
	{
		if(self agentcanseesentient(self.curmeleetarget))
		{
			var_04 = maps/mp/agents/_scriptedagents::droppostoground(self.curmeleetarget.origin);
			if(isdefined(var_04))
			{
				var_03 = 1;
				param_00 = var_04;
			}
			else
			{
				meleefailed();
			}
		}
		else
		{
			meleefailed();
		}
	}

	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	var_05 = self getanimentry(var_02,0);
	var_06 = getanimlength(var_05);
	var_07 = getnotetracktimes(var_05,"dog_melee");
	if(var_07.size > 0)
	{
		var_08 = var_07[0] * var_06;
	}
	else
	{
		var_08 = var_07;
	}

	self scragentdoanimlerp(self.origin,param_00,var_08);
	thread func_86F9(self.curmeleetarget,var_08,param_01);
	maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_02,0,"attack","dog_melee");
	self notify("cancel_updatelerppos");
	var_09 = 0;
	if(isdefined(self.curmeleetarget))
	{
		var_09 = self.curmeleetarget.health;
	}

	if(isdefined(self.meleedamage))
	{
		var_09 = self.meleedamage;
	}

	if(isdefined(self.curmeleetarget))
	{
		func_2970(self.curmeleetarget,var_09,"MOD_IMPACT");
	}

	self.curmeleetarget = undefined;
	if(var_03)
	{
		self scragentsetanimscale(0,1);
	}
	else
	{
		self scragentsetanimscale(1,1);
	}

	self scragentsetphysicsmode("gravity");
	self scragentsetanimmode("anim deltas");
	maps/mp/agents/_scriptedagents::func_8BCA("attack","end");
}

//Function Number: 8
func_86F9(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon("cancel_updatelerppos");
	param_00 endon("disconnect");
	param_00 endon("death");
	var_03 = param_01;
	var_04 = 0.05;
	for(;;)
	{
		wait(var_04);
		var_03 = var_03 - var_04;
		if(var_03 <= 0)
		{
			break;
		}

		var_05 = func_3C5E(param_00,param_02);
		if(!isdefined(var_05))
		{
			break;
		}

		self scragentdoanimlerp(self.origin,var_05,var_03);
	}
}

//Function Number: 9
func_3C5E(param_00,param_01)
{
	if(!param_01)
	{
		var_02 = maps/mp/agents/_scriptedagents::droppostoground(param_00.origin);
		return var_02;
	}

	var_03 = param_01.origin - self.origin;
	var_04 = length(var_03);
	if(var_04 < self.attackoffset)
	{
		return self.origin;
	}

	var_03 = var_03 / var_04;
	var_05 = param_01.origin - var_03 * self.attackoffset;
	if(maps/mp/agents/_scriptedagents::canmovepointtopoint(self.origin,var_05))
	{
		return var_05;
	}

	return undefined;
}

//Function Number: 10
func_493F(param_00)
{
	if(isdefined(param_00.hasriotshield) && param_00.hasriotshield)
	{
		var_01 = self.origin - param_00.origin;
		var_02 = vectornormalize((var_01[0],var_01[1],0));
		var_03 = anglestoforward(param_00.angles);
		var_04 = vectordot(var_03,var_01);
		if(param_00.hasriotshieldequipped)
		{
			if(var_04 > 0.766)
			{
				return 1;
			}
		}
		else if(var_04 < -0.766)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
func_2970(param_00,param_01,param_02)
{
	if(func_493F(param_00))
	{
	}

	param_00 dodamage(param_01,self.origin,self,self,param_02);
}

//Function Number: 12
meleefailed()
{
	self.lastmeleefailedmypos = self.origin;
	self.lastmeleefailedpos = self.curmeleetarget.origin;
}
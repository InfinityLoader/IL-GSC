/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_dog_melee.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 206 ms
 * Timestamp: 4/22/2024 2:07:57 AM
*******************************************************************/

//Function Number: 1
main()
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
		var_08 = maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin,var_03);
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
		var_0A = shoulddoextendedkill(self.curmeleetarget);
		var_0A = isdefined(var_0A);
	}

	self.blockgoalpos = 1;
	if(var_0A)
	{
		doextendedkill(var_09);
		return;
	}

	dostandardkill(var_03,var_08);
}

//Function Number: 2
end_script()
{
	self scragentsetanimscale(1,1);
	self.blockgoalpos = 0;
}

//Function Number: 3
getmeleeanimstate()
{
	return "attack_run_and_jump";
}

//Function Number: 4
shoulddoextendedkill(param_00)
{
	if(!self.enableextendedkill)
	{
		return undefined;
	}

	var_01 = 4;
	if(!maps\mp\_utility::isgameparticipant(param_00))
	{
		return undefined;
	}

	if(isprotectedbyriotshield(param_00))
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
		var_08 = maps\mp\agents\dog\_dog_think::cross2d(var_04,var_06);
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
	var_0B = maps\mp\agents\_scriptedagents::droppostoground(var_0A);
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
doextendedkill(param_00)
{
	var_01 = "attack_extended";
	domeleedamage(self.curmeleetarget,self.curmeleetarget.health,"MOD_MELEE_DOG");
	var_02 = self getanimentry(var_01,param_00);
	thread extendedkill_sticktovictim(var_02,self.curmeleetarget.origin,self.curmeleetarget.angles);
	maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_01,param_00,"attack","end");
	self notify("kill_stick");
	self.curmeleetarget = undefined;
	self scragentsetanimmode("anim deltas");
	self unlink();
}

//Function Number: 6
extendedkill_sticktovictim(param_00,param_01,param_02)
{
	self endon("death");
	self endon("killanimscript");
	self endon("kill_stick");
	wait(0.05);
	if(isalive(self.curmeleetarget))
	{
		return;
	}

	var_03 = self.curmeleetarget getcorpseentity();
	self linkto(var_03);
	self scragentdoanimrelative(param_00,param_01,param_02);
}

//Function Number: 7
dostandardkill(param_00,param_01)
{
	var_02 = getmeleeanimstate();
	var_03 = 0;
	if(!param_01)
	{
		if(self agentcanseesentient(self.curmeleetarget))
		{
			var_04 = maps\mp\agents\_scriptedagents::droppostoground(self.curmeleetarget.origin);
			if(isdefined(var_04))
			{
				var_03 = 1;
				param_00 = var_04;
			}
			else
			{
				meleefailed();
				return;
			}
		}
		else
		{
			meleefailed();
			return;
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
	thread updatelerppos(self.curmeleetarget,var_08,param_01);
	maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_02,0,"attack","dog_melee");
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
		domeleedamage(self.curmeleetarget,var_09,"MOD_IMPACT");
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
	maps\mp\agents\_scriptedagents::waituntilnotetrack("attack","end");
}

//Function Number: 8
updatelerppos(param_00,param_01,param_02)
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

		var_05 = getupdatedattackpos(param_00,param_02);
		if(!isdefined(var_05))
		{
			break;
		}

		self scragentdoanimlerp(self.origin,var_05,var_03);
	}
}

//Function Number: 9
getupdatedattackpos(param_00,param_01)
{
	if(!param_01)
	{
		var_02 = maps\mp\agents\_scriptedagents::droppostoground(param_00.origin);
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
	if(maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin,var_05))
	{
		return var_05;
	}

	return undefined;
}

//Function Number: 10
isprotectedbyriotshield(param_00)
{
	if(param_00 maps\mp\_riotshield::hasriotshield())
	{
		var_01 = self.origin - param_00.origin;
		var_02 = vectornormalize((var_01[0],var_01[1],0));
		var_03 = anglestoforward(param_00.angles);
		var_04 = vectordot(var_03,var_01);
		if(param_00 maps\mp\_riotshield::hasriotshieldequipped())
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
domeleedamage(param_00,param_01,param_02)
{
	if(isprotectedbyriotshield(param_00))
	{
		return;
	}

	param_00 dodamage(param_01,self.origin,self,self,param_02);
}

//Function Number: 12
meleefailed()
{
	self.lastmeleefailedmypos = self.origin;
	self.lastmeleefailedpos = self.curmeleetarget.origin;
}
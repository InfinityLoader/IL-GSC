/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_zombie_dog_melee.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 99 ms
 * Timestamp: 4/22/2024 2:08:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	var_00 = distancesquared(self.curmeleetarget.origin,self.origin);
	var_01 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
	}

	doattackstandard(self.curmeleetarget,var_01.origin);
}

//Function Number: 2
end_script()
{
	self scragentsetanimscale(1,1);
}

//Function Number: 3
getmeleeanimstate()
{
	return "attack_run_and_jump";
}

//Function Number: 4
doattackstandard(param_00,param_01)
{
	var_02 = getmeleeanimstate();
	var_03 = self.nonmoveratescale;
	var_04 = 0;
	var_05 = 0;
	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	var_06 = randomint(self getanimentrycount(var_02));
	var_07 = self getanimentry(var_02,var_06);
	var_08 = getanimlength(var_07);
	var_09 = getnotetracktimes(var_07,"dog_melee");
	var_0A = var_08 / var_03 * 0.33;
	if(var_09.size > 0)
	{
		var_0A = var_08 / var_03 * var_09[0];
	}

	self scragentsetphysicsmode("gravity");
	if(var_05)
	{
		self scragentsetorientmode("face enemy");
	}
	else
	{
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(param_00.origin - self.origin),0));
	}

	self scragentsetanimmode("anim deltas");
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_02,var_06,var_03);
	if(var_04)
	{
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,param_01,var_0A);
		childthread updatelerppos(param_00,var_0A,1,self.lungelerprange);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoAttackStandard");
	}
	else
	{
		self scragentsetanimscale(1,1);
	}

	wait(var_0A);
	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(var_04)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttackStandard");
	}

	if(maps\mp\agents\humanoid\_humanoid_melee::attackshouldhit(param_00))
	{
		self notify("attack_hit",param_00,param_01);
		var_0B = 0;
		if(isdefined(param_00))
		{
			var_0B = param_00.health;
		}

		if(isdefined(self.meleedamage))
		{
			var_0B = self.meleedamage;
		}

		if(isalive(param_00))
		{
			maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(param_00,var_0B,"MOD_IMPACT");
		}
	}
	else
	{
		self notify("attack_miss",param_00,param_01);
	}

	self.lastmeleepos = self.origin;
	var_0C = var_08 / var_03 - var_0A;
	if(var_0C > 0)
	{
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim","end",var_0C);
	}

	self.lastmeleefinishtime = gettime();
}

//Function Number: 5
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

//Function Number: 6
getupdatedattackpos(param_00,param_01)
{
	if(!param_01)
	{
		var_02 = maps\mp\zombies\_util::droppostoground(param_00.origin);
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
	if(maps\mp\zombies\_util::canmovepointtopoint(self.origin,var_05))
	{
		return var_05;
	}

	return undefined;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\humanoid\_humanoid_melee.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 267 ms
 * Timestamp: 4/22/2024 2:08:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
	if(ismeleeblocked())
	{
		return meleefailed();
	}

	if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_00.valid)
	{
		if(!isdefined(self.lungelast))
		{
			self.lungelast = 0;
		}

		if(isdefined(self.meleemovemode))
		{
			var_01 = gettime() - self.lungelast > self.lungedebouncems;
			var_02 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin,var_00.origin);
			var_03 = distancesquared(self.curmeleetarget.origin,self.origin) > self.lungeminrangesq;
			if(var_01 && var_02 && var_03)
			{
				self.lungelast = gettime();
				doattacklunge(self.curmeleetarget,var_00.origin);
				return;
			}
		}

		if(!maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase())
		{
			lungemeleefailed();
			return;
		}
	}

	doattackstandard(self.curmeleetarget,var_00.origin);
}

//Function Number: 2
ismeleeblocked()
{
	var_00 = self.origin + (0,0,self.meleecheckheight);
	var_01 = self.curmeleetarget.origin + (0,0,self.meleecheckheight);
	var_02 = undefined;
	if(isdefined(self.curmeleetarget.classname) && self.curmeleetarget.classname == "misc_turret" && isdefined(self.curmeleetarget.aiclip))
	{
		var_02 = physicstrace(var_00,var_01,self.curmeleetarget.aiclip);
	}
	else
	{
		var_02 = physicstrace(var_00,var_01);
	}

	return distancesquared(var_02,var_01) > 1;
}

//Function Number: 3
end_script()
{
	self scragentsetanimscale(1,1);
}

//Function Number: 4
doattack(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_07 = randomint(self getanimentrycount(param_02));
	var_08 = self getanimentry(param_02,var_07);
	var_09 = getanimlength(var_08);
	var_0A = getnotetracktimes(var_08,"hit");
	var_0B = var_09 / param_05 * 0.33;
	if(var_0A.size > 0)
	{
		var_0B = var_09 / param_05 * var_0A[0];
	}

	self scragentsetphysicsmode("gravity");
	if(param_04)
	{
		self scragentsetorientmode("face enemy");
	}
	else
	{
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(param_00.origin - self.origin),0));
	}

	self scragentsetanimmode("anim deltas");
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_02,var_07,param_05);
	if(param_06)
	{
		var_0C = getnotetracktimes(var_08,"lunge_start");
		var_0D = 0;
		if(var_0C.size > 0)
		{
			var_0D = var_09 / param_05 * var_0C[0];
		}

		var_0B = var_0B - var_0D;
		if(var_0D > 0)
		{
			wait(var_0D);
		}

		maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(self.lungefx);
		if(self.lungeanimratescale)
		{
			var_0E = param_01 - self.origin;
			var_0F = getmovedelta(var_08,var_0C[0],var_0A[0]);
			var_10 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_0E,var_0F);
			param_05 = param_05 * clamp(1 / var_10.xy,0.5,1);
			var_0B = var_09 / param_05 * var_0A[0] - var_09 / param_05 * var_0C[0];
			maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_02 + "_norestart",var_07,param_05);
		}
	}

	if(param_03)
	{
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,param_01,var_0B);
		childthread updatelerppos(param_00,var_0B,1,self.lungelerprange);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoAttack");
	}
	else
	{
		self scragentsetanimscale(1,1);
	}

	wait(var_0B);
	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(param_03)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
	}

	if(attackshouldhit(param_00))
	{
		self notify("attack_hit",param_00,param_01);
		var_11 = 0;
		if(isdefined(param_00))
		{
			var_11 = param_00.health;
		}

		if(isdefined(self.meleedamage))
		{
			var_11 = self.meleedamage;
		}

		if(isalive(param_00))
		{
			domeleedamage(param_00,var_11,"MOD_IMPACT");
		}
	}
	else
	{
		self notify("attack_miss",param_00,param_01);
	}

	self.lastmeleepos = self.origin;
	var_12 = var_09 / param_05 - var_0B;
	if(var_12 > 0)
	{
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim","end",var_12);
	}

	self.lastmeleefinishtime = gettime();
}

//Function Number: 5
attackshouldhit(param_00)
{
	if(!isalive(param_00))
	{
		return 0;
	}

	if(!withinmeleedamagerange())
	{
		return 0;
	}

	if(isenemyinfrontofme(param_00,self.meleedot))
	{
		return 1;
	}

	if(maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
isenemyinfrontofme(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	var_03 = anglestoforward(self.angles);
	var_04 = vectordot(var_02,var_03);
	return var_04 > param_01;
}

//Function Number: 7
withinmeleedamagerange()
{
	if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("normal"))
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() > self.meleeradiusbase && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase())
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
doattackstandard(param_00,param_01)
{
	var_02 = "attack_stand";
	var_03 = self.nonmoveratescale;
	var_04 = 0;
	if(isdefined(self.meleemovemode))
	{
		var_02 = "attack_" + self.meleemovemode;
		var_04 = 1;
		self.meleemovemode = undefined;
	}

	doattack(param_00,param_01,var_02,0,var_04,var_03);
}

//Function Number: 9
doattacklunge(param_00,param_01)
{
	doattack(param_00,param_01,self.lungeanimstate,1,1,self.nonmoveratescale,1);
}

//Function Number: 10
updatelerppos(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self endon("death");
	self endon("cancel_updatelerppos");
	param_00 endon("disconnect");
	param_00 endon("death");
	var_04 = self.origin;
	var_05 = param_01;
	var_06 = 0.05;
	for(;;)
	{
		wait(var_06);
		var_05 = var_05 - var_06;
		if(var_05 <= 0)
		{
			break;
		}

		var_07 = getupdatedattackpos(param_00,param_02);
		if(!isdefined(var_07))
		{
			break;
		}

		if(isdefined(param_03))
		{
			var_08 = param_03;
		}
		else
		{
			var_08 = maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() - self.radius;
		}

		var_09 = var_07 - var_04;
		if(lengthsquared(var_09) > var_08 * var_08)
		{
			var_07 = var_04 + vectornormalize(var_09) * var_08;
		}

		self scragentsetorientmode("face enemy");
		self scragentdoanimlerp(self.origin,var_07,var_05);
	}
}

//Function Number: 11
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
	var_05 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(param_01);
	if(maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin,var_05.origin))
	{
		return var_05.origin;
	}

	return undefined;
}

//Function Number: 12
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

//Function Number: 13
domeleedamage(param_00,param_01,param_02)
{
	if(isprotectedbyriotshield(param_00))
	{
		return;
	}

	param_00 dodamage(param_01,self.origin,self,self,param_02);
}

//Function Number: 14
meleefailed()
{
	self.lastmeleefailedmypos = self.origin;
	self.lastmeleefailedpos = self.curmeleetarget.origin;
}

//Function Number: 15
lungemeleefailed()
{
	self.lastlungemeleefailedmypos = self.origin;
	self.lastlungemeleefailedpos = self.curmeleetarget.origin;
}
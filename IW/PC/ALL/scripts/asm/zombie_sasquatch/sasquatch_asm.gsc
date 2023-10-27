/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\zombie_sasquatch\sasquatch_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1165 ms
 * Timestamp: 10/27/2023 12:03:05 AM
*******************************************************************/

//Function Number: 1
sasquatch_init(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "left";
	self.var_2303.var_4C86 = spawnstruct();
	self.sharpturnnotifydist = 24;
	self.var_1198.btreespawn = 0;
	self.var_1198.var_BD23 = "run";
}

//Function Number: 2
sasquatch_playidleanim(param_00,param_01,param_02,param_03)
{
	var_04 = isdefined(self.var_10C);
	if(var_04)
	{
		self method_8289("face enemy");
	}
	else
	{
		self method_8289("face angle abs",self.angles);
	}

	lib_0A1D::func_235F(param_00,param_01,param_02,1,0);
}

//Function Number: 3
sas_play_meleeattack(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_3135.var_B64D))
	{
		thread sasquatch_faceenemyhelper(self.var_3135.var_B64D,500,param_01);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 4
sasquatch_melee_cleanup(param_00,param_01,param_02)
{
	lib_0A1A::func_232F("meleeattack","end");
}

//Function Number: 5
sasquatch_faceenemyhelper(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self endon(param_02 + "_finished");
	}

	if(isdefined(param_01))
	{
		var_03 = gettime() + param_01;
	}
	else
	{
		var_03 = -1;
	}

	while((var_03 < 0 || gettime() <= var_03) && isdefined(param_00) && isalive(param_00))
	{
		var_04 = param_00.origin - self.origin;
		if(length2dsquared(var_04) > 1024)
		{
			var_05 = vectortoyaw(var_04);
			self method_8289("face angle abs",(0,var_05,0));
		}

		wait(0.05);
	}
}

//Function Number: 6
sasquatch_melee_notehandler(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "hit":
			sasquatch_domeleedamage();
			break;
	}
}

//Function Number: 7
sasquatch_domeleedamage()
{
	var_00 = 90;
	var_01 = 9216;
	var_02 = 72;
	var_03 = 0.707;
	var_04 = 2304;
	var_05 = 0.174;
	var_06 = anglestoforward(self.angles);
	var_07 = 0;
	foreach(var_09 in level.players)
	{
		if(!isalive(var_09))
		{
			continue;
		}

		var_0A = var_09.origin - self.origin;
		var_0B = lengthsquared(var_0A);
		if(var_0B > var_01)
		{
			continue;
		}

		if(abs(var_0A[2]) > var_02)
		{
			continue;
		}

		var_0C = (var_0A[0],var_0A[1],0);
		var_0A = vectornormalize(var_0C);
		var_0D = vectordot(var_0A,var_06);
		if(var_0B < var_04)
		{
			if(var_0D < var_05)
			{
				continue;
			}
		}
		else if(var_0D < var_03)
		{
			continue;
		}

		var_07 = 1;
		self notify("attack_hit",var_09);
		lib_0C73::func_5904(var_09,var_00,"MOD_IMPACT");
	}

	if(!var_07)
	{
		self notify("attack_miss");
	}
}

//Function Number: 8
sas_play_throw(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1B::func_2930();
	thread sasquatch_faceenemyhelper(var_04,1500,param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
sas_play_throw_notehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "pickup")
	{
		return;
	}

	if(param_00 == "throw")
	{
		if(isdefined(self.rockmodel))
		{
			self.rockmodel unlink();
			self.rockmodel delete();
			self.rockmodel = undefined;
		}

		sasquatch_throwrock(lib_0A1B::func_2930());
	}
}

//Function Number: 10
sasquatch_throwrock(param_00)
{
	var_01 = self gettagorigin("j_wrist_ri");
	var_02 = undefined;
	if(isdefined(param_00))
	{
		var_03 = anglestoforward(self.angles);
		var_04 = param_00.origin - self.origin;
		if(vectordot(var_03,vectornormalize(var_04)) > 0.707)
		{
			if(isalive(param_00))
			{
				var_02 = param_00 geteye();
			}
			else
			{
				var_02 = param_00.origin;
			}
		}
	}

	if(!isdefined(var_02))
	{
		var_05 = 256;
		var_06 = (cos(20),0,-1 * sin(20));
		var_02 = var_01 + rotatevector(var_06,self.angles) * var_05;
	}

	var_02 = var_02 + (0,0,-20);
	magicbullet("iw7_sasq_rock_mp",var_01,var_02,self);
}

//Function Number: 11
sas_play_throw_terminate(param_00,param_01,param_02)
{
	if(isdefined(self.rockmodel))
	{
		self.rockmodel delete();
	}

	lib_0A1A::func_232F("throwevent","end");
}

//Function Number: 12
sas_play_rush(param_00,param_01,param_02,param_03)
{
	self notify("attack_charge");
	lib_0A1D::func_235F(param_00,param_01,param_02,1,1);
}

//Function Number: 13
sas_play_rush_orienthelper(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self method_8289("face motion");
}

//Function Number: 14
sas_play_rushattack_notehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		sasquatch_domeleedamage();
		return;
	}

	if(param_00 == "footstep_left_small")
	{
		lib_0A1A::func_232F("rushattack","end");
	}
}

//Function Number: 15
sas_play_rushattack_cleanup(param_00,param_01,param_02)
{
	lib_0A1A::func_232F("rushattack","end");
}

//Function Number: 16
sas_play_traverseexternal(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED4(param_01,var_04,1);
	var_05 = self method_8146();
	self setorigin(var_05);
	self notify("killanimscript");
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 17
sasq_tauntrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.btauntrequested) && self.var_1198.btauntrequested;
}

//Function Number: 18
sasq_rushrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.brushrequested);
}

//Function Number: 19
sasq_rushnotrequested(param_00,param_01,param_02,param_03)
{
	return !sasq_rushrequested(param_00,param_01,param_02,param_03);
}

//Function Number: 20
sasq_rushcomplete(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.brushcomplete) && self.var_1198.brushcomplete;
}

//Function Number: 21
sasq_throwrockrequested(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_298A();
}
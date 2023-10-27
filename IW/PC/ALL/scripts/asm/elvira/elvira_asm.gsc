/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\elvira\elvira_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 1124 ms
 * Timestamp: 10/27/2023 12:01:45 AM
*******************************************************************/

//Function Number: 1
elvirainit(param_00,param_01,param_02,param_03)
{
	self.var_FFEF = 1;
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
}

//Function Number: 2
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "cast_return_spell":
		case "cast_reveal_spell":
		case "cast_revive_spell":
		case "cast_spell":
		case "revive_player":
		case "reload":
		case "melee":
			return 1;
	}

	return 0;
}

//Function Number: 3
setaction(param_00)
{
	self.requested_action = param_00;
}

//Function Number: 4
clearaction()
{
	self.requested_action = undefined;
}

//Function Number: 5
isanimdone(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"early_end"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"finish_early"))
	{
		return 1;
	}

	if(lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
isrevivedone(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.reviveplayer))
	{
		return 1;
	}

	if(!scripts\common\utility::istrue(self.reviveplayer.inlaststand))
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
dorevive(param_00,param_01)
{
	self endon(param_00 + "_finished");
	param_01 endon("disconnect");
	var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
	wait(var_02.revive_wait_time);
	if(!isdefined(param_01.reviveent))
	{
		return;
	}

	param_01.reviveent notify("pg_trigger",self);
}

//Function Number: 8
playreviveanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(isdefined(self.reviveplayer))
	{
		thread lib_0C73::func_6A6A(param_01,self.reviveplayer);
		thread dorevive(param_01,self.reviveplayer);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
shouldabortaction(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(self.btraversalteleport))
	{
		return 0;
	}

	if(!isdefined(self.requested_action))
	{
		return 1;
	}

	if(isdefined(param_03))
	{
		if(self.requested_action != param_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
shoulddoaction(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.requested_action))
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 != "")
	{
		if(self.requested_action == param_03)
		{
			return 1;
		}

		return 0;
	}

	if(self.requested_action == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
playanimwithplaybackrate(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 12
func_3EE4(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 13
playmovingpainanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	if(!isdefined(self.var_233) || self method_841E() < scripts\mp\agents\elvira\elvira_tunedata::gettunedata().min_moving_pain_dist)
	{
		var_04 = func_3EE4(param_00,"pain_generic",param_03);
		self method_8289("face angle abs",self.angles);
		lib_0A1D::func_2365(param_00,"pain_generic",param_02,var_04,1);
		return;
	}

	lib_0A1D::func_2364(param_01,param_02,param_03,var_04);
}

//Function Number: 14
choosereviveanim(param_00,param_01,param_02)
{
	if(!isdefined(self.reviveanimindex))
	{
		self.reviveanimindex = lib_0F3C::func_3EF4(param_00,param_01,param_02);
	}

	return self.reviveanimindex;
}

//Function Number: 15
faceplayer(param_00,param_01)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		if(isdefined(param_01))
		{
			self method_8289("face angle abs",(0,vectortoyaw(param_01.origin - self.origin),0));
		}
		else
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 16
playcastspellanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	playfxontag(level._effect["vfx_spell_tornado"],self,"j_wrist_le");
	self playsound("elvira_fire_spell_cast");
	thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_timely_torrent();
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 17
playrevealspellanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = param_03;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	playfxontag(level._effect["vfx_spell_anom"],self,"j_wrist_le");
	self playsound("elvira_portal_spell_cast");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05,var_04);
}

//Function Number: 18
playteleportfx(param_00,param_01)
{
	self endon(param_00 + "_finished");
	wait(param_01);
	playfx(level._effect["elvira_stand_smoke"],self.origin);
}

//Function Number: 19
terminate_traverseexternal(param_00,param_01,param_02)
{
	self.earlytraversalteleportpos = undefined;
	self.ishidden = undefined;
	self.var_9CEC = undefined;
}

//Function Number: 20
dotraverseteleport(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
	thread playteleportfx(param_01,0.75);
	var_04 = undefined;
	if(isdefined(self.earlytraversalteleportpos))
	{
		var_04 = self.earlytraversalteleportpos;
	}
	else
	{
		var_04 = self method_8146();
	}

	var_05 = vectornormalize(var_04 - self.origin * (1,1,0));
	var_06 = vectortoangles(var_05);
	self method_8289("face angle abs",var_06);
	wait(0.9);
	self hide();
	self.ishidden = 1;
	self setorigin(var_04,0);
	playfx(level._effect["elvira_stand_smoke"],var_04);
	wait(0.25);
	self show();
	self.ishidden = undefined;
	self.var_9CEC = undefined;
	self notify("traverse_end");
	thread lib_0A1A::func_237C("exposed_idle",param_03);
}
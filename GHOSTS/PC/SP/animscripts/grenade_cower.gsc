/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\grenade_cower.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 1:24:01 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	animscripts/utility::func_4622("grenadecower");
	if(isdefined(self.var_3DAE))
	{
		self [[ self.var_3DAE ]]();
		return;
	}

	if(self.a.var_60B1 == "prone")
	{
		animscripts/stop::func_4FDD();
		return;
	}

	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
	var_00 = 0;
	if(isdefined(self.grenade))
	{
		var_00 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);
	}
	else
	{
		var_00 = self.angles[1];
	}

	if(self.a.var_60B1 == "stand")
	{
		if(isdefined(self.grenade) && func_83FA(var_00))
		{
			return;
		}

		self setflaggedanimknoballrestart("cowerstart",animscripts/utility::lookupanim("grenade","cower_squat"),%body,1,0.2);
		animscripts/shared::func_2986("cowerstart");
	}

	self.a.var_60B1 = "crouch";
	self.a.var_5486 = "stop";
	self setflaggedanimknoballrestart("cower",animscripts/utility::lookupanim("grenade","cower_squat_idle"),%body,1,0.2);
	animscripts/shared::func_2986("cower");
	self waittill("never");
}

//Function Number: 2
end_script()
{
	self.safetochangescript = 1;
}

//Function Number: 3
func_83FA(param_00)
{
	if(randomint(2) == 0)
	{
		return 0;
	}

	if(self.stairsstate != "none")
	{
		return 0;
	}

	var_01 = undefined;
	if(abs(param_00) > 90)
	{
		var_01 = animscripts/utility::lookupanim("grenade","cower_dive_back");
	}
	else
	{
		var_01 = animscripts/utility::lookupanim("grenade","cower_dive_front");
	}

	var_02 = getmovedelta(var_01,0,0.5);
	var_03 = self localtoworldcoords(var_02);
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	self.safetochangescript = 0;
	self setflaggedanimknoballrestart("cowerstart",var_01,%body,1,0.2);
	animscripts/shared::func_2986("cowerstart");
	self.safetochangescript = 1;
	return 1;
}
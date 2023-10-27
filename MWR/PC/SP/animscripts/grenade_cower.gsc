/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\grenade_cower.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 2:44:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts\utility::initialize("grenadecower");
	if(isdefined(self.grenadecowerfunction))
	{
		self [[ self.grenadecowerfunction ]]();
		return;
	}

	if(self.a.pose == "prone")
	{
		animscripts\stop::main();
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

	if(self.a.pose == "stand")
	{
		if(isdefined(self.grenade) && trydive(var_00))
		{
			return;
		}

		self setflaggedanimknoballrestart("cowerstart",animscripts\utility::lookupanim("grenade","cower_squat"),%body,1,0.2);
		self.custommovetransition = ::squatouttransition;
		animscripts\shared::donotetracks("cowerstart");
	}

	self.a.pose = "crouch";
	self.a.movement = "stop";
	self setflaggedanimknoballrestart("cower",animscripts\utility::lookupanim("grenade","cower_squat_idle"),%body,1,0.2);
	animscripts\shared::donotetracks("cower");
	self waittill("never");
}

//Function Number: 2
squatouttransition()
{
	self orientmode("face angle",self.angles[1]);
	self.nododgemove = 1;
	self setflaggedanimknoballrestart("cowerend",animscripts\utility::lookupanim("grenade","cower_squat_up"),%body,1,0.4);
	animscripts\shared::donotetracks("cowerend");
	self.custommovetransition = undefined;
	self.a.movement = "stop";
	self.nododgemove = 0;
	animscripts\exit_node::startmovetransition();
}

//Function Number: 3
end_script()
{
	self.safetochangescript = 1;
}

//Function Number: 4
trydive(param_00)
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
		var_01 = animscripts\utility::lookupanim("grenade","cower_dive_back");
	}
	else
	{
		var_01 = animscripts\utility::lookupanim("grenade","cower_dive_front");
	}

	var_02 = getmovedelta(var_01,0,0.5);
	var_03 = self localtoworldcoords(var_02);
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	self.safetochangescript = 0;
	self setflaggedanimknoballrestart("cowerstart",var_01,%body,1,0.2);
	animscripts\shared::donotetracks("cowerstart");
	self.safetochangescript = 1;
	return 1;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\grenade_cower.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:18:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::func_D15("grenadecower");
	if(isdefined(self.var_3ACA))
	{
		self [[ self.var_3ACA ]]();
		return;
	}

	if(self.a.pose == "prone")
	{
		animscripts/stop::main();
		return;
	}

	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
	var_00 = 0;
	if(isdefined(self.var_73C))
	{
		var_00 = angleclamp180(vectortoangles(self.var_73C.origin - self.origin)[1] - self.angles[1]);
	}
	else
	{
		var_00 = self.angles[1];
	}

	if(self.a.pose == "stand")
	{
		if(isdefined(self.var_73C) && func_3FE0(var_00))
		{
			return;
		}

		self setflaggedanimknoballrestart("cowerstart",%exposed_squat_down_grenade_f,%body,1,0.2);
		animscripts/shared::donotetracks("cowerstart");
	}

	self.a.pose = "crouch";
	self.a.movement = "stop";
	self setflaggedanimknoballrestart("cower",%exposed_squat_idle_grenade_f,%body,1,0.2);
	animscripts/shared::donotetracks("cower");
	self waittill("never");
}

//Function Number: 2
func_067F()
{
	self.var_765 = 1;
}

//Function Number: 3
func_3FE0(param_00)
{
	if(randomint(2) == 0)
	{
		return 0;
	}

	if(self.var_786 != "none")
	{
		return 0;
	}

	var_01 = undefined;
	if(abs(param_00) > 90)
	{
		var_01 = %exposed_dive_grenade_b;
	}
	else
	{
		var_01 = %exposed_dive_grenade_f;
	}

	var_02 = getmovedelta(var_01,0,0.5);
	var_03 = self localtoworldcoords(var_02);
	if(!self maymovetopoint(var_03))
	{
		return 0;
	}

	self.var_765 = 0;
	self setflaggedanimknoballrestart("cowerstart",var_01,%body,1,0.2);
	animscripts/shared::donotetracks("cowerstart");
	self.var_765 = 1;
	return 1;
}
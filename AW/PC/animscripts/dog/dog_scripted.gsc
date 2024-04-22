/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_scripted.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 1:58:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["scripted"] ]]();
			return;
		}
	}

	self endon("death");
	self notify("killanimscript");
	self.codescripted["root"] = %body;
	self endon("end_sequence");
	self startscriptedanim(self.codescripted["notifyName"],self.codescripted["origin"],self.codescripted["angles"],self.codescripted["anim"],self.codescripted["animMode"],self.codescripted["root"],self.codescripted["goalTime"]);
	self.codescripted = undefined;
	if(isdefined(self.deathstring_passed))
	{
		self.deathstring = self.deathstring_passed;
	}

	self waittill("killanimscript");
}

//Function Number: 2
init(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["scripted_init"] ]](param_00,param_01,param_02,param_03,param_04,param_05);
			return;
		}
	}

	self.codescripted["notifyName"] = param_00;
	self.codescripted["origin"] = param_01;
	self.codescripted["angles"] = param_02;
	self.codescripted["anim"] = param_03;
	if(isdefined(param_04))
	{
		self.codescripted["animMode"] = param_04;
	}
	else
	{
		self.codescripted["animMode"] = "normal";
	}

	if(isdefined(param_05))
	{
		self.codescripted["root"] = param_05;
	}
	else
	{
		self.codescripted["root"] = %body;
	}

	self.codescripted["goalTime"] = param_06;
}
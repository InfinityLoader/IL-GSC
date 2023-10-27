/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\scripted.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:30:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self notify("killanimscript");
	self notify("clearSuppressionAttack");
	self.a.var_1C2D = 0;
	self.codescripted["root"] = %body;
	self endon("end_sequence");
	self startscriptedanim(self.codescripted["notifyName"],self.codescripted["origin"],self.codescripted["angles"],self.codescripted["anim"],self.codescripted["animMode"],self.codescripted["root"]);
	self.codescripted = undefined;
	if(isdefined(self.var_3AE8) || isdefined(self.facial_animation))
	{
		animscripts/face::sayspecificdialogue(self.facial_animation,self.var_3AE8,0.9,"scripted_anim_facedone");
		self.facial_animation = undefined;
		self.var_3AE8 = undefined;
	}

	if(isdefined(self.deathstring_passed))
	{
		self.deathstring = self.deathstring_passed;
	}

	self waittill("killanimscript");
}

//Function Number: 2
init(param_00,param_01,param_02,param_03,param_04,param_05)
{
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
		return;
	}

	self.codescripted["root"] = %body;
}
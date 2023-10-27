/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\scripted.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 1:55:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self notify("killanimscript");
	self notify("clearSuppressionAttack");
	self.a.suppressingenemy = 0;
	self.codescripted["root"] = %body;
	self endon("end_sequence");
	self startscriptedanim(self.codescripted["notifyName"],self.codescripted["origin"],self.codescripted["angles"],self.codescripted["anim"],self.codescripted["animMode"],self.codescripted["root"],self.codescripted["goalTime"]);
	self.codescripted = undefined;
	if(isdefined(self.scripted_dialogue) || isdefined(self.facial_animation))
	{
		animscripts\face::sayspecificdialogue(self.facial_animation,self.scripted_dialogue,0.9,"scripted_anim_facedone");
		self.facial_animation = undefined;
		self.scripted_dialogue = undefined;
	}

	if(isdefined(self.deathstring_passed))
	{
		self.deathstring = self.deathstring_passed;
	}

	self waittill("killanimscript");
}

//Function Number: 2
init(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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
	}
	else
	{
		self.codescripted["root"] = %body;
	}

	self.codescripted["goalTime"] = param_06;
}
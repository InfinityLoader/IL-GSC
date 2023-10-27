/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\scripted.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 1:24:20 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("death");
	self notify("killanimscript");
	self notify("clearSuppressionAttack");
	self.a.var_7D67 = 0;
	self.var_1DE8["root"] = %body;
	self endon("end_sequence");
	self startscriptedanim(self.var_1DE8["notifyName"],self.var_1DE8["origin"],self.var_1DE8["angles"],self.var_1DE8["anim"],self.var_1DE8["animMode"],self.var_1DE8["root"],self.var_1DE8["goalTime"]);
	self.var_1DE8 = undefined;
	if(isdefined(self.scripted_dialogue) || isdefined(self.var_3122))
	{
		animscripts/face::func_6AB5(self.var_3122,self.scripted_dialogue,0.9,"scripted_anim_facedone");
		self.var_3122 = undefined;
		self.scripted_dialogue = undefined;
	}

	if(isdefined(self.var_238B))
	{
		self.deathstring = self.var_238B;
	}

	self waittill("killanimscript");
}

//Function Number: 2
func_44DF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.var_1DE8["notifyName"] = param_00;
	self.var_1DE8["origin"] = param_01;
	self.var_1DE8["angles"] = param_02;
	self.var_1DE8["anim"] = param_03;
	if(isdefined(param_04))
	{
		self.var_1DE8["animMode"] = param_04;
	}
	else
	{
		self.var_1DE8["animMode"] = "normal";
	}

	if(isdefined(param_05))
	{
		self.var_1DE8["root"] = param_05;
	}
	else
	{
		self.var_1DE8["root"] = %body;
	}

	self.var_1DE8["goalTime"] = param_06;
}
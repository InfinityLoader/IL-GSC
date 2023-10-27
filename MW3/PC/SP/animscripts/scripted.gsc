/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\scripted.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:18:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self notify("killanimscript");
	self notify("clearSuppressionAttack");
	self.a.var_20AB = 0;
	self.var_3B66["root"] = %body;
	self endon("end_sequence");
	self startscriptedanim(self.var_3B66["notifyName"],self.var_3B66["origin"],self.var_3B66["angles"],self.var_3B66["anim"],self.var_3B66["animMode"],self.var_3B66["root"]);
	self.var_3B66 = undefined;
	if(isdefined(self.var_3FE4) || isdefined(self.var_3FE5))
	{
		animscripts/face::func_C46(self.var_3FE5,self.var_3FE4,0.9,"scripted_anim_facedone");
		self.var_3FE5 = undefined;
		self.var_3FE4 = undefined;
	}

	if(isdefined(self.var_3B67))
	{
		self.var_3B68 = self.var_3B67;
	}

	self waittill("killanimscript");
}

//Function Number: 2
init(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.var_3B66["notifyName"] = param_00;
	self.var_3B66["origin"] = param_01;
	self.var_3B66["angles"] = param_02;
	self.var_3B66["anim"] = param_03;
	if(isdefined(param_04))
	{
		self.var_3B66["animMode"] = param_04;
	}
	else
	{
		self.var_3B66["animMode"] = "normal";
	}

	if(isdefined(param_05))
	{
		self.var_3B66["root"] = param_05;
		return;
	}

	self.var_3B66["root"] = %body;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_scripted.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:17:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self notify("killanimscript");
	self.var_3B66["root"] = %root;
	self endon("end_sequence");
	self startscriptedanim(self.var_3B66["notifyName"],self.var_3B66["origin"],self.var_3B66["angles"],self.var_3B66["anim"],self.var_3B66["animMode"],self.var_3B66["root"]);
	self.var_3B66 = undefined;
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

	self.var_3B66["root"] = %root;
}
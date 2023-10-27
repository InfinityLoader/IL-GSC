/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\ladder_up.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 74 ms
 * Timestamp: 10/26/2023 11:59:39 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.type) && self.type == "dog")
	{
		return;
	}

	self.var_5270 = "crouch";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("noclip");
	var_00 = %ladder_climbup;
	var_01 = %ladder_climboff;
	var_02 = self method_8148();
	self method_8221("face angle",var_02.angles[1]);
	var_03 = 1;
	if(isdefined(self.var_BCD6))
	{
		var_03 = self.var_BCD6;
	}

	self method_82E4("climbanim",var_00,%body,1,0.1,var_03);
	var_04 = getmovedelta(var_01,0,1);
	var_05 = self method_8145();
	var_06 = var_05.origin - var_04 + (0,0,1);
	var_07 = getmovedelta(var_00,0,1);
	var_08 = var_07[2] * var_03 / getanimlength(var_00);
	var_09 = var_06[2] - self.origin[2] / var_08;
	if(var_09 > 0)
	{
		self.allowpain = 1;
		scripts\anim\notetracks::func_5931(var_09,"climbanim");
		self method_82E4("climbanim",var_01,%body,1,0.1,var_03);
		scripts\anim\shared::func_592B("climbanim");
	}

	self method_83C4("gravity");
	self.var_1491.var_BCC8 = "run";
	self.var_1491.var_D6A5 = "crouch";
}
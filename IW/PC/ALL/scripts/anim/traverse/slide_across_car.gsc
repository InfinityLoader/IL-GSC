/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\slide_across_car.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 184 ms
 * Timestamp: 10/26/2023 11:59:41 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		func_102DE();
		return;
	}

	func_102DF();
}

//Function Number: 2
func_102DF()
{
	var_00 = [];
	var_00["traverseAnim"] = %slide_across_car;
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}

//Function Number: 3
func_102DE()
{
	self endon("killanimscript");
	self method_83C4("noclip");
	var_00 = self method_8148();
	self method_8221("face angle",var_00.angles[1]);
	self method_806F(%root,0.1);
	self method_82EA("traverse",level.var_58C7["jump_up_40"],1,0.1,1);
	scripts\anim\shared::func_592B("traverse");
	function_0178("anml_dog_bark",self gettagorigin("tag_eye"));
	self method_806F(%root,0);
	self method_82EA("traverse",level.var_58C7["jump_down_40"],1,0,1);
	scripts\anim\shared::func_592B("traverse");
	self method_83C4("gravity");
}
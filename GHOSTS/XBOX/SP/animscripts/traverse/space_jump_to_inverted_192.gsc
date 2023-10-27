/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\space_jump_to_inverted_192.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 1:35:53 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(!isdefined(self.swimmer) || !self.swimmer)
	{
		return;
	}

	self method_820C("noclip");
	var_00 = self getnegotiationstartnode();
	self.turnrate = 2000;
	self method_820E("face angle 3d",var_00.angles);
	%root;
	self method_8268("",,%root],0.1,1,0);
	lib_3364::should_do_immediate_ragdoll("space_traversal_jump_180_u");
}
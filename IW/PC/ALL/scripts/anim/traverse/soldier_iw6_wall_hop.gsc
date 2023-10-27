/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\soldier_iw6_wall_hop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 144 ms
 * Timestamp: 10/26/2023 11:59:41 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_586D("wallhop",40);
		return;
	}

	func_138A5();
}

//Function Number: 2
func_138A5()
{
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_18D1(func_7814(),39.875);
		return;
	}

	self waittill("killanimscript");
}

//Function Number: 3
func_7814()
{
	return %traverse_wallhop_3;
}
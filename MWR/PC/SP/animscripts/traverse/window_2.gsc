/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_2.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:43:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("wallhop",40);
		return;
	}

	advancedwindowtraverse(%windowclimb,35);
}

//Function Number: 2
advancedwindowtraverse(param_00,param_01)
{
	var_02 = [];
	var_02["traverseAnim"] = param_00;
	var_02["traverseHeight"] = param_01;
	var_02["traverseSound"] = "npc_wall_over_40";
	animscripts\traverse\shared::dotraverse(var_02);
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\lag_unstable_jump_long.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:53:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	if(animscripts\traverse\shared::getnextfootdown() == "Right")
	{
		var_00["traverseAnim"] = %lag_unstable_jump_a_long_l;
	}
	else
	{
		var_00["traverseAnim"] = %lag_unstable_jump_a_long_r;
	}

	var_00["traverseNotetrackFunc"] = ::animscripts\traverse\shared::handletraversenotetracks;
	animscripts\traverse\shared::dotraverse(var_00);
	self setflaggedanimknoballrestart("traverse_align",%lag_unstable_jumparrive_8,%body,1,0.2,1);
	animscripts\shared::donotetracks("traverse_align",::animscripts\traverse\shared::handletraversenotetracks);
}
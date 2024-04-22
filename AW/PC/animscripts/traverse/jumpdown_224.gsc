/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\jumpdown_224.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 1:59:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	jumpdown_224();
}

//Function Number: 2
jumpdown_224()
{
	var_00 = [];
	var_00["traverseAnim"] = %jumpdown_224;
	var_00["traverseHeight"] = 0;
	animscripts\traverse\shared::dotraverse(var_00);
}
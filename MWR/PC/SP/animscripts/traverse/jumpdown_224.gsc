/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_224.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:43:00 AM
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
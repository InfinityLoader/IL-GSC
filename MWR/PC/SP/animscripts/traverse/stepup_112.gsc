/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\stepup_112.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 55 ms
 * Timestamp: 10/27/2023 2:43:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	stepup_112();
}

//Function Number: 2
stepup_112()
{
	var_00 = [];
	var_00["traverseAnim"] = %stepup_112;
	var_00["traverseHeight"] = 112;
	animscripts\traverse\shared::dotraverse(var_00);
}
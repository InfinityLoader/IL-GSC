/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1343.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 1:57:06 AM
*******************************************************************/

//Function Number: 1
codecallback_handleinstantmessage(param_00)
{
	if(isdefined(level.globalinstantmessagehandler))
	{
		[[ level.globalinstantmessagehandler ]](param_00);
		return;
	}

	iprintlnbold("no level handler for: " + param_00);
}
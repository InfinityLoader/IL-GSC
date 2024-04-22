/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: message.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 2:02:46 AM
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
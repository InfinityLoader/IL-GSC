/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\message.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:46:23 AM
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
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_highlights.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:22:18 AM
*******************************************************************/

//Function Number: 1
givehighlight(param_00,param_01)
{
	var_02 = getclientmatchdata("highlightCount");
	if(var_02 < 18)
	{
		setclientmatchdata("highlights",var_02,"award",param_00);
		setclientmatchdata("highlights",var_02,"clientId",self.clientmatchdataid);
		setclientmatchdata("highlights",var_02,"value",param_01);
		var_02++;
		setclientmatchdata("highlightCount",var_02);
	}
}
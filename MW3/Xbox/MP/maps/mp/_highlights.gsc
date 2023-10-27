/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_highlights.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 2:27:46 AM
*******************************************************************/

//Function Number: 1
func_2D71(param_00,param_01)
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
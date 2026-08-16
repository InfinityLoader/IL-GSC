/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_highlights.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

givehighlight(ref, value)
{
	highlightcount = getclientmatchdata("highlightCount");
	if(highlightcount < 18)
	{
		setclientmatchdata("highlights", highlightcount, "award", ref);
		setclientmatchdata("highlights", highlightcount, "clientId", self.clientmatchdataid);
		setclientmatchdata("highlights", highlightcount, "value", value);
		highlightcount++;
		setclientmatchdata("highlightCount", highlightcount);
		return;
	}
}
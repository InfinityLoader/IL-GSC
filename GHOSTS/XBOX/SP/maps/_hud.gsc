/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 1:39:51 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.uiparent = addstruct();
	level.uiparent.horzalign = "left";
	level.uiparent.vertalign = "top";
	level.uiparent.alignx = "left";
	level.uiparent.aligny = "top";
	level.uiparent.x = 0;
	level.uiparent.y = 0;
	level.uiparent.width = 0;
	level.uiparent.height = 0;
	level.uiparent.children = [];
	if(level.console)
	{
		level.fontheight = 12;
		return;
	}

	level.fontheight = 12;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 2:25:10 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.uiparent = spawnstruct();
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
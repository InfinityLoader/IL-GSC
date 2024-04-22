/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:21:27 AM
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
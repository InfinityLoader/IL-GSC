/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_hud.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 149 ms
 * Timestamp: 10/27/2023 12:20:33 AM
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
	level.fontheight = 12;
	level.var_912F["allies"] = spawnstruct();
	level.var_912F["axis"] = spawnstruct();
	level.primaryprogressbary = -61;
	level.primaryprogressbarx = 0;
	level.primaryprogressbarheight = 9;
	level.primaryprogressbarwidth = 120;
	level.primaryprogressbartexty = -75;
	level.primaryprogressbartextx = 0;
	level.primaryprogressbarfontsize = 1.2;
	level.teamprogressbary = 32;
	level.teamprogressbarheight = 14;
	level.teamprogressbarwidth = 192;
	level.teamprogressbartexty = 8;
	level.teamprogressbarfontsize = 1.65;
	level.var_B0E6 = "BOTTOM";
	level.var_B0E5 = -140;
	level.var_B0E4 = 1.6;
}

//Function Number: 2
func_7251(param_00)
{
	self.basefontscale = self.fontscale;
	if(isdefined(param_00))
	{
		self.var_B49C = min(param_00,6.3);
	}
	else
	{
		self.var_B49C = min(self.fontscale * 2,6.3);
	}

	self.var_94C4 = 2;
	self.var_C766 = 4;
}

//Function Number: 3
func_7250(param_00)
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	self changefontscaleovertime(self.var_94C4 * 0.05);
	self.fontscale = self.var_B49C;
	wait(self.var_94C4 * 0.05);
	self changefontscaleovertime(self.var_C766 * 0.05);
	self.fontscale = self.basefontscale;
}
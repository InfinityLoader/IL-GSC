/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 1:31:02 AM
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
	level.fontheight = 12;
	level.hud["allies"] = addstruct();
	level.hud["axis"] = addstruct();
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
	level.lowertextyalign = "BOTTOM";
	level.lowertexty = -140;
	level.lowertextfontsize = 1.6;
}

//Function Number: 2
func_349E(param_00)
{
	self.basefontscale = self.fontscale;
	if(isdefined(param_00))
	{
		self.maxfontscale = min(param_00,6.3);
	}
	else
	{
		self.maxfontscale = min(self.fontscale * 2,6.3);
	}

	self.inframes = 2;
	self.outframes = 4;
}

//Function Number: 3
fontpulse(param_00)
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	self changefontscaleovertime(self.inframes * 0.05);
	self.fontscale = self.maxfontscale;
	wait(self.inframes * 0.05);
	self changefontscaleovertime(self.outframes * 0.05);
	self.fontscale = self.basefontscale;
}
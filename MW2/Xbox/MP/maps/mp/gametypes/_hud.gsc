/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precacheshader("progress_bar_bg");
	precacheshader("progress_bar_fg");
	precacheshader("progress_bar_fill");
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
	level.hud["allies"] = spawnstruct();
	level.hud["axis"] = spawnstruct();
	level.primaryprogressbary = -61;
	level.primaryprogressbarx = 0;
	level.primaryprogressbarheight = 9;
	level.primaryprogressbarwidth = 120;
	level.primaryprogressbartexty = -75;
	level.primaryprogressbartextx = 0;
	level.primaryprogressbarfontsize = 0.6;
	level.teamprogressbary = 32;
	level.teamprogressbarheight = 14;
	level.teamprogressbarwidth = 192;
	level.teamprogressbartexty = 8;
	level.teamprogressbarfontsize = 1.65;
	if(level.splitscreen)
	{
		level.lowertextyalign = "BOTTOM";
		level.lowertexty = -76;
		level.lowertextfontsize = 1.14;
		return;
	}

	level.lowertextyalign = "CENTER";
	level.lowertexty = 70;
	level.lowertextfontsize = 1.6;
}

fontpulseinit(maxfontscale)
{
	self.basefontscale = self.fontscale;
	if(isdefined(maxfontscale))
	{
		self.maxfontscale = min(maxfontscale, 6.3);
	}
	else
	{
		self.maxfontscale = min(self.fontscale * 2, 6.3);
	}

	self.inframes = 2;
	self.outframes = 4;
}

fontpulse(player)
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	player endon("disconnect");
	player endon("joined_team");
	player endon("joined_spectators");
	self changefontscaleovertime(self.inframes * 0.05);
	self.fontscale = self.maxfontscale;
	wait self.inframes * 0.05;
	self changefontscaleovertime(self.outframes * 0.05);
	self.fontscale = self.basefontscale;
}
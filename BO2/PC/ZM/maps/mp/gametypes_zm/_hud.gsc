/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_hud.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 3:02:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("progress_bar_bg");
	precacheshader("progress_bar_fg");
	precacheshader("progress_bar_fill");
	precacheshader("score_bar_bg");
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
	foreach(team in level.teams)
	{
		level.hud[team] = spawnstruct();
	}

	level.primaryprogressbary = -61;
	level.primaryprogressbarx = 0;
	level.primaryprogressbarheight = 9;
	level.primaryprogressbarwidth = 120;
	level.primaryprogressbartexty = -75;
	level.primaryprogressbartextx = 0;
	level.primaryprogressbarfontsize = 1.4;
	level.primaryprogressbarx_ss = 20;
	level.primaryprogressbartextx_ss = 20;
	level.primaryprogressbary_ss = 30;
	level.primaryprogressbartexty_ss = 33;
	level.primaryprogressbarheight_ss = 2;
	level.secondaryprogressbary = -85;
	level.secondaryprogressbarx = 0;
	level.secondaryprogressbarheight = 9;
	level.secondaryprogressbarwidth = 120;
	level.secondaryprogressbartexty = -100;
	level.secondaryprogressbartextx = 0;
	level.secondaryprogressbarfontsize = 1.4;
	level.secondaryprogressbarx_ss = 20;
	level.secondaryprogressbartextx_ss = 20;
	level.secondaryprogressbary_ss = 15;
	level.secondaryprogressbartexty_ss = 0;
	level.secondaryprogressbarheight_ss = 2;
	level.teamprogressbary = 32;
	level.teamprogressbarheight = 14;
	level.teamprogressbarwidth = 192;
	level.teamprogressbartexty = 8;
	level.teamprogressbarfontsize = 1.65;
	setdvar("ui_generic_status_bar",0);
	level.lowertextyalign = "BOTTOM";
	level.lowertexty = -42;
	level.lowertextfontsize = 1.4;
	level.lowertextyalign_ss = "CENTER";
	level.lowertexty_ss = 40;
	level.lowertextfontsize_ss = 1.4;
}

//Function Number: 2
fontpulseinit()
{
	self.basefontscale = self.fontscale;
	self.maxfontscale = self.fontscale * 2;
	self.inframes = 1.5;
	self.outframes = 3;
}

//Function Number: 3
fontpulse(player)
{
	self notify("fontPulse");
	self endon("fontPulse");
	self endon("death");
	player endon("disconnect");
	player endon("joined_team");
	player endon("joined_spectators");
	if(self.outframes == 0)
	{
		self.fontscale = 0.01;
	}
	else
	{
		self.fontscale = self.fontscale;
	}

	if(self.inframes > 0)
	{
		self changefontscaleovertime(self.inframes * 0.05);
		self.fontscale = self.maxfontscale;
		wait(self.inframes * 0.05);
	}
	else
	{
		self.fontscale = self.maxfontscale;
		self.alpha = 0;
		self fadeovertime(self.outframes * 0.05);
		self.alpha = 1;
	}

	if(self.outframes > 0)
	{
		self changefontscaleovertime(self.outframes * 0.05);
		self.fontscale = self.basefontscale;
	}
}

//Function Number: 4
fadetoblackforxsec(startwait,blackscreenwait,fadeintime,fadeouttime,shadername,n_sort)
{
	if(!(IsDefined(n_sort)))
	{
		n_sort = 50;
	}

	wait(startwait);
	if(!(IsDefined(self)))
	{
		return;
	}

	if(!(IsDefined(self.blackscreen)))
	{
		self.blackscreen = newclienthudelem(self);
	}

	self.blackscreen.x = 0;
	self.blackscreen.y = 0;
	self.blackscreen.horzalign = "fullscreen";
	self.blackscreen.vertalign = "fullscreen";
	self.blackscreen.foreground = 0;
	self.blackscreen.hidewhendead = 0;
	self.blackscreen.hidewheninmenu = 1;
	self.blackscreen.sort = n_sort;
	if(IsDefined(shadername))
	{
		self.blackscreen setshader(shadername,640,480);
	}
	else
	{
		self.blackscreen setshader("black",640,480);
	}

	self.blackscreen.alpha = 0;
	if(fadeintime > 0)
	{
		self.blackscreen fadeovertime(fadeintime);
	}

	self.blackscreen.alpha = 1;
	wait(fadeintime);
	if(!(IsDefined(self.blackscreen)))
	{
		return;
	}

	wait(blackscreenwait);
	if(!(IsDefined(self.blackscreen)))
	{
		return;
	}

	if(fadeouttime > 0)
	{
		self.blackscreen fadeovertime(fadeouttime);
	}

	self.blackscreen.alpha = 0;
	wait(fadeouttime);
	if(IsDefined(self.blackscreen))
	{
		self.blackscreen destroy();
		self.blackscreen = undefined;
	}
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_util.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 9 ms
 * Timestamp: 10/28/2023 12:10:34 AM
*******************************************************************/

#include maps/mp/_utility;

//Function Number: 1
setparent(element)
{
	if(IsDefined(self.parent) && self.parent == element)
	{
		return;
	}

	if(IsDefined(self.parent))
	{
		self.parent removechild(self);
	}

	self.parent = element;
	self.parent addchild(self);
	if(IsDefined(self.point))
	{
		self setpoint(self.point,self.relativepoint,self.xoffset,self.yoffset);
	}
	else
	{
		self setpoint("TOP");
	}
}

//Function Number: 2
getparent()
{
	return self.parent;
}

//Function Number: 3
addchild(element)
{
	element.index = self.children.size;
	self.children[self.children.size] = element;
}

//Function Number: 4
removechild(element)
{
	element.parent = undefined;
	if(self.children[self.children.size - 1] != element)
	{
		self.children[element.index] = self.children[self.children.size - 1];
		self.children[element.index].index = element.index;
	}

	self.children[self.children.size - 1] = undefined;
	element.index = undefined;
}

//Function Number: 5
setpoint(point,relativepoint,xoffset,yoffset,movetime)
{
	if(!(IsDefined(movetime)))
	{
		movetime = 0;
	}

	element = self getparent();
	if(movetime)
	{
		self moveovertime(movetime);
	}

	if(!(IsDefined(xoffset)))
	{
		xoffset = 0;
	}

	self.xoffset = xoffset;
	if(!(IsDefined(yoffset)))
	{
		yoffset = 0;
	}

	self.yoffset = yoffset;
	self.point = point;
	self.alignx = "center";
	self.aligny = "middle";
	switch(point)
	{
		case "CENTER":
			break;

		case "TOP":
			self.aligny = "top";
			break;

		case "BOTTOM":
			self.aligny = "bottom";
			break;

		case "LEFT":
			self.alignx = "left";
			break;

		case "RIGHT":
			self.alignx = "right";
			break;

		case "TOPRIGHT":
		case "TOP_RIGHT":
			self.aligny = "top";
			self.alignx = "right";
			break;

		case "TOPLEFT":
		case "TOP_LEFT":
			self.aligny = "top";
			self.alignx = "left";
			break;

		case "TOPCENTER":
			self.aligny = "top";
			self.alignx = "center";
			break;

		case "BOTTOM RIGHT":
		case "BOTTOM_RIGHT":
			self.aligny = "bottom";
			self.alignx = "right";
			break;

		case "BOTTOM LEFT":
		case "BOTTOM_LEFT":
			self.aligny = "bottom";
			self.alignx = "left";
			break;

		default:
	/#
			println("^3Warning: unknown point passed to setPoint(): " + point);
	#/
			break;
	}

	if(!(IsDefined(relativepoint)))
	{
		relativepoint = point;
	}

	self.relativepoint = relativepoint;
	relativex = "center";
	relativey = "middle";
	switch(relativepoint)
	{
		case "CENTER":
			break;

		case "TOP":
			relativey = "top";
			break;

		case "BOTTOM":
			relativey = "bottom";
			break;

		case "LEFT":
			relativex = "left";
			break;

		case "RIGHT":
			relativex = "right";
			break;

		case "TOPRIGHT":
		case "TOP_RIGHT":
			relativey = "top";
			relativex = "right";
			break;

		case "TOPLEFT":
		case "TOP_LEFT":
			relativey = "top";
			relativex = "left";
			break;

		case "TOPCENTER":
			relativey = "top";
			relativex = "center";
			break;

		case "BOTTOM RIGHT":
		case "BOTTOM_RIGHT":
			relativey = "bottom";
			relativex = "right";
			break;

		case "BOTTOM LEFT":
		case "BOTTOM_LEFT":
			relativey = "bottom";
			relativex = "left";
			break;

		default:
	/#
			println("^3Warning: unknown relativePoint passed to setPoint(): " + relativepoint);
	#/
			break;
	}

	if(element == level.uiparent)
	{
		self.horzalign = relativex;
		self.vertalign = relativey;
	}
	else
	{
		self.horzalign = element.horzalign;
		self.vertalign = element.vertalign;
	}

	if(relativex == element.alignx)
	{
		offsetx = 0;
		xfactor = 0;
	}
	else if(relativex == "center" || element.alignx == "center")
	{
		offsetx = int(element.width / 2);
		if(relativex == "left" || element.alignx == "right")
		{
			xfactor = -1;
		}
		else
		{
			xfactor = 1;
		}
	}
	else
	{
		offsetx = element.width;
		if(relativex == "left")
		{
			xfactor = -1;
		}
		else
		{
			xfactor = 1;
		}
	}

	self.x = element.x + offsetx * xfactor;
	if(relativey == element.aligny)
	{
		offsety = 0;
		yfactor = 0;
	}
	else if(relativey == "middle" || element.aligny == "middle")
	{
		offsety = int(element.height / 2);
		if(relativey == "top" || element.aligny == "bottom")
		{
			yfactor = -1;
		}
		else
		{
			yfactor = 1;
		}
	}
	else
	{
		offsety = element.height;
		if(relativey == "top")
		{
			yfactor = -1;
		}
		else
		{
			yfactor = 1;
		}
	}

	self.y = element.y + offsety * yfactor;
	self.x = self.x + self.xoffset;
	self.y = self.y + self.yoffset;
	switch(self.elemtype)
	{
		case "bar":
			setpointbar(point,relativepoint,xoffset,yoffset);
			self.barframe setparent(self getparent());
			self.barframe setpoint(point,relativepoint,xoffset,yoffset);
			break;
	}

	self updatechildren();
}

//Function Number: 6
setpointbar(point,relativepoint,xoffset,yoffset)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width;
	}
	else
	{
		self.bar.x = self.x - int(self.width / 2);
	}

	if(self.aligny == "top")
	{
		self.bar.y = self.y;
	}
	else if(self.aligny == "bottom")
	{
		self.bar.y = self.y;
	}

	self updatebar(self.bar.frac);
}

//Function Number: 7
updatebar(barfrac,rateofchange)
{
	if(self.elemtype == "bar")
	{
		updatebarscale(barfrac,rateofchange);
	}
}

//Function Number: 8
updatebarscale(barfrac,rateofchange)
{
	barwidth = int(self.width * barfrac + 0.5);
	if(!(barwidth))
	{
		barwidth = 1;
	}

	self.bar.frac = barfrac;
	self.bar setshader(self.bar.shader,barwidth,self.height);
/#
	assert(barwidth <= self.width,"barWidth <= self.width: " + barwidth + " <= " + self.width + " - barFrac was " + barfrac);
#/
	if(IsDefined(rateofchange) && barwidth < self.width)
	{
		if(rateofchange > 0)
		{
/#
			assert(1 - barfrac / rateofchange > 0,"barFrac: " + barfrac + "rateOfChange: " + rateofchange);
#/
			self.bar scaleovertime(1 - barfrac / rateofchange,self.width,self.height);
		}
		else if(rateofchange < 0)
		{
/#
			assert(barfrac / -1 * rateofchange > 0,"barFrac: " + barfrac + "rateOfChange: " + rateofchange);
#/
			self.bar scaleovertime(barfrac / -1 * rateofchange,1,self.height);
		}
	}

	self.bar.rateofchange = rateofchange;
	self.bar.lastupdatetime = GetTime();
}

//Function Number: 9
createfontstring(font,fontscale)
{
	fontelem = newclienthudelem(self);
	fontelem.elemtype = "font";
	fontelem.font = font;
	fontelem.fontscale = fontscale;
	fontelem.x = 0;
	fontelem.y = 0;
	fontelem.width = 0;
	fontelem.height = int(level.fontheight * fontscale);
	fontelem.xoffset = 0;
	fontelem.yoffset = 0;
	fontelem.children = [];
	fontelem setparent(level.uiparent);
	fontelem.hidden = 0;
	return fontelem;
}

//Function Number: 10
createserverfontstring(font,fontscale,team)
{
	if(IsDefined(team))
	{
		fontelem = newteamhudelem(team);
	}
	else
	{
		fontelem = newhudelem();
	}

	fontelem.elemtype = "font";
	fontelem.font = font;
	fontelem.fontscale = fontscale;
	fontelem.x = 0;
	fontelem.y = 0;
	fontelem.width = 0;
	fontelem.height = int(level.fontheight * fontscale);
	fontelem.xoffset = 0;
	fontelem.yoffset = 0;
	fontelem.children = [];
	fontelem setparent(level.uiparent);
	fontelem.hidden = 0;
	return fontelem;
}

//Function Number: 11
createservertimer(font,fontscale,team)
{
	if(IsDefined(team))
	{
		timerelem = newteamhudelem(team);
	}
	else
	{
		timerelem = newhudelem();
	}

	timerelem.elemtype = "timer";
	timerelem.font = font;
	timerelem.fontscale = fontscale;
	timerelem.x = 0;
	timerelem.y = 0;
	timerelem.width = 0;
	timerelem.height = int(level.fontheight * fontscale);
	timerelem.xoffset = 0;
	timerelem.yoffset = 0;
	timerelem.children = [];
	timerelem setparent(level.uiparent);
	timerelem.hidden = 0;
	return timerelem;
}

//Function Number: 12
createclienttimer(font,fontscale)
{
	timerelem = newclienthudelem(self);
	timerelem.elemtype = "timer";
	timerelem.font = font;
	timerelem.fontscale = fontscale;
	timerelem.x = 0;
	timerelem.y = 0;
	timerelem.width = 0;
	timerelem.height = int(level.fontheight * fontscale);
	timerelem.xoffset = 0;
	timerelem.yoffset = 0;
	timerelem.children = [];
	timerelem setparent(level.uiparent);
	timerelem.hidden = 0;
	return timerelem;
}

//Function Number: 13
createicon(shader,width,height)
{
	iconelem = newclienthudelem(self);
	iconelem.elemtype = "icon";
	iconelem.x = 0;
	iconelem.y = 0;
	iconelem.width = width;
	iconelem.height = height;
	iconelem.xoffset = 0;
	iconelem.yoffset = 0;
	iconelem.children = [];
	iconelem setparent(level.uiparent);
	iconelem.hidden = 0;
	if(IsDefined(shader))
	{
		iconelem setshader(shader,width,height);
	}

	return iconelem;
}

//Function Number: 14
createservericon(shader,width,height,team)
{
	if(IsDefined(team))
	{
		iconelem = newteamhudelem(team);
	}
	else
	{
		iconelem = newhudelem();
	}

	iconelem.elemtype = "icon";
	iconelem.x = 0;
	iconelem.y = 0;
	iconelem.width = width;
	iconelem.height = height;
	iconelem.xoffset = 0;
	iconelem.yoffset = 0;
	iconelem.children = [];
	iconelem setparent(level.uiparent);
	iconelem.hidden = 0;
	if(IsDefined(shader))
	{
		iconelem setshader(shader,width,height);
	}

	return iconelem;
}

//Function Number: 15
createserverbar(color,width,height,flashfrac,team,selected)
{
	if(IsDefined(team))
	{
		barelem = newteamhudelem(team);
	}
	else
	{
		barelem = newhudelem();
	}

	barelem.x = 0;
	barelem.y = 0;
	barelem.frac = 0;
	barelem.color = color;
	barelem.sort = -2;
	barelem.shader = "progress_bar_fill";
	barelem setshader("progress_bar_fill",width,height);
	barelem.hidden = 0;
	if(IsDefined(flashfrac))
	{
		barelem.flashfrac = flashfrac;
	}

	if(IsDefined(team))
	{
		barelemframe = newteamhudelem(team);
	}
	else
	{
		barelemframe = newhudelem();
	}

	barelemframe.elemtype = "icon";
	barelemframe.x = 0;
	barelemframe.y = 0;
	barelemframe.width = width;
	barelemframe.height = height;
	barelemframe.xoffset = 0;
	barelemframe.yoffset = 0;
	barelemframe.bar = barelem;
	barelemframe.barframe = barelemframe;
	barelemframe.children = [];
	barelemframe.sort = -1;
	barelemframe.color = (1,1,1);
	barelemframe setparent(level.uiparent);
	if(IsDefined(selected))
	{
		barelemframe setshader("progress_bar_fg_sel",width,height);
	}
	else
	{
		barelemframe setshader("progress_bar_fg",width,height);
	}

	barelemframe.hidden = 0;
	if(IsDefined(team))
	{
		barelembg = newteamhudelem(team);
	}
	else
	{
		barelembg = newhudelem();
	}

	barelembg.elemtype = "bar";
	barelembg.x = 0;
	barelembg.y = 0;
	barelembg.width = width;
	barelembg.height = height;
	barelembg.xoffset = 0;
	barelembg.yoffset = 0;
	barelembg.bar = barelem;
	barelembg.barframe = barelemframe;
	barelembg.children = [];
	barelembg.sort = -3;
	barelembg.color = (0,0,0);
	barelembg.alpha = 0.5;
	barelembg setparent(level.uiparent);
	barelembg setshader("progress_bar_bg",width,height);
	barelembg.hidden = 0;
	return barelembg;
}

//Function Number: 16
createbar(color,width,height,flashfrac)
{
	barelem = newclienthudelem(self);
	barelem.x = 0;
	barelem.y = 0;
	barelem.frac = 0;
	barelem.color = color;
	barelem.sort = -2;
	barelem.shader = "progress_bar_fill";
	barelem setshader("progress_bar_fill",width,height);
	barelem.hidden = 0;
	if(IsDefined(flashfrac))
	{
		barelem.flashfrac = flashfrac;
	}

	barelemframe = newclienthudelem(self);
	barelemframe.elemtype = "icon";
	barelemframe.x = 0;
	barelemframe.y = 0;
	barelemframe.width = width;
	barelemframe.height = height;
	barelemframe.xoffset = 0;
	barelemframe.yoffset = 0;
	barelemframe.bar = barelem;
	barelemframe.barframe = barelemframe;
	barelemframe.children = [];
	barelemframe.sort = -1;
	barelemframe.color = (1,1,1);
	barelemframe setparent(level.uiparent);
	barelemframe.hidden = 0;
	barelembg = newclienthudelem(self);
	barelembg.elemtype = "bar";
	if(!(level.splitscreen))
	{
		barelembg.x = -2;
		barelembg.y = -2;
	}

	barelembg.width = width;
	barelembg.height = height;
	barelembg.xoffset = 0;
	barelembg.yoffset = 0;
	barelembg.bar = barelem;
	barelembg.barframe = barelemframe;
	barelembg.children = [];
	barelembg.sort = -3;
	barelembg.color = (0,0,0);
	barelembg.alpha = 0.5;
	barelembg setparent(level.uiparent);
	if(!(level.splitscreen))
	{
		barelembg setshader("progress_bar_bg",width + 4,height + 4);
	}
	else
	{
		barelembg setshader("progress_bar_bg",width + 0,height + 0);
	}

	barelembg.hidden = 0;
	return barelembg;
}

//Function Number: 17
getcurrentfraction()
{
	frac = self.bar.frac;
	if(IsDefined(self.bar.rateofchange))
	{
		frac = frac + GetTime() - self.bar.lastupdatetime * self.bar.rateofchange;
		if(frac > 1)
		{
			frac = 1;
		}

		if(frac < 0)
		{
			frac = 0;
		}
	}

	return frac;
}

//Function Number: 18
createprimaryprogressbar()
{
	bar = createbar((1,1,1),level.primaryprogressbarwidth,level.primaryprogressbarheight);
	if(level.splitscreen)
	{
		bar setpoint("TOP",undefined,level.primaryprogressbarx,level.primaryprogressbary);
	}
	else
	{
		bar setpoint("CENTER",undefined,level.primaryprogressbarx,level.primaryprogressbary);
	}

	return bar;
}

//Function Number: 19
createprimaryprogressbartext()
{
	text = createfontstring("objective",level.primaryprogressbarfontsize);
	if(level.splitscreen)
	{
		text setpoint("TOP",undefined,level.primaryprogressbartextx,level.primaryprogressbartexty);
	}
	else
	{
		text setpoint("CENTER",undefined,level.primaryprogressbartextx,level.primaryprogressbartexty);
	}

	text.sort = -1;
	return text;
}

//Function Number: 20
createsecondaryprogressbar()
{
	secondaryprogressbarheight = getdvarintdefault("scr_secondaryProgressBarHeight",level.secondaryprogressbarheight);
	secondaryprogressbarx = getdvarintdefault("scr_secondaryProgressBarX",level.secondaryprogressbarx);
	secondaryprogressbary = getdvarintdefault("scr_secondaryProgressBarY",level.secondaryprogressbary);
	bar = createbar((1,1,1),level.secondaryprogressbarwidth,secondaryprogressbarheight);
	if(level.splitscreen)
	{
		bar setpoint("TOP",undefined,secondaryprogressbarx,secondaryprogressbary);
	}
	else
	{
		bar setpoint("CENTER",undefined,secondaryprogressbarx,secondaryprogressbary);
	}

	return bar;
}

//Function Number: 21
createsecondaryprogressbartext()
{
	secondaryprogressbartextx = getdvarintdefault("scr_btx",level.secondaryprogressbartextx);
	secondaryprogressbartexty = getdvarintdefault("scr_bty",level.secondaryprogressbartexty);
	text = createfontstring("objective",level.primaryprogressbarfontsize);
	if(level.splitscreen)
	{
		text setpoint("TOP",undefined,secondaryprogressbartextx,secondaryprogressbartexty);
	}
	else
	{
		text setpoint("CENTER",undefined,secondaryprogressbartextx,secondaryprogressbartexty);
	}

	text.sort = -1;
	return text;
}

//Function Number: 22
createteamprogressbar(team)
{
	bar = createserverbar((1,0,0),level.teamprogressbarwidth,level.teamprogressbarheight,undefined,team);
	bar setpoint("TOP",undefined,0,level.teamprogressbary);
	return bar;
}

//Function Number: 23
createteamprogressbartext(team)
{
	text = createserverfontstring("default",level.teamprogressbarfontsize,team);
	text setpoint("TOP",undefined,0,level.teamprogressbartexty);
	return text;
}

//Function Number: 24
setflashfrac(flashfrac)
{
	self.bar.flashfrac = flashfrac;
}

//Function Number: 25
hideelem()
{
	if(self.hidden)
	{
		return;
	}

	self.hidden = 1;
	if(self.alpha != 0)
	{
		self.alpha = 0;
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar.hidden = 1;
		if(self.bar.alpha != 0)
		{
			self.bar.alpha = 0;
		}

		self.barframe.hidden = 1;
		if(self.barframe.alpha != 0)
		{
			self.barframe.alpha = 0;
		}
	}
}

//Function Number: 26
showelem()
{
	if(!(self.hidden))
	{
		return;
	}

	self.hidden = 0;
	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		if(self.alpha != 0.5)
		{
			self.alpha = 0.5;
		}

		self.bar.hidden = 0;
		if(self.bar.alpha != 1)
		{
			self.bar.alpha = 1;
		}

		self.barframe.hidden = 0;
		if(self.barframe.alpha != 1)
		{
			self.barframe.alpha = 1;
		}
	}
	else if(self.alpha != 1)
	{
		self.alpha = 1;
	}
}

//Function Number: 27
flashthread()
{
	self endon("death");
	if(!(self.hidden))
	{
		self.alpha = 1;
	}

	while(1)
	{
		if(self.frac >= self.flashfrac)
		{
			if(!(self.hidden))
			{
				self fadeovertime(0.3);
				self.alpha = 0.2;
				wait(0.35);
				self fadeovertime(0.3);
				self.alpha = 1;
			}

			wait(0.7);
			continue;
		}

		if(!self.hidden && self.alpha != 1)
		{
			self.alpha = 1;
		}

		wait(0.05);
	}
}

//Function Number: 28
destroyelem()
{
	tempchildren = [];
	for(index = 0;index < self.children.size;index++)
	{
		if(IsDefined(self.children[index]))
		{
			tempchildren[tempchildren.size] = self.children[index];
		}
	}

	for(index = 0;index < tempchildren.size;index++)
	{
		tempchildren[index] setparent(self getparent());
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar destroy();
		self.barframe destroy();
	}

	self destroy();
}

//Function Number: 29
seticonshader(shader)
{
	self setshader(shader,self.width,self.height);
}

//Function Number: 30
setwidth(width)
{
	self.width = width;
}

//Function Number: 31
setheight(height)
{
	self.height = height;
}

//Function Number: 32
setsize(width,height)
{
	self.width = width;
	self.height = height;
}

//Function Number: 33
updatechildren()
{
	for(index = 0;index < self.children.size;index++)
	{
		child = self.children[index];
		child setpoint(child.point,child.relativepoint,child.xoffset,child.yoffset);
	}
}

//Function Number: 34
createloadouticon(player,verindex,horindex,xpos,ypos)
{
	iconsize = 32;
	if(player issplitscreen())
	{
		iconsize = 22;
	}

	ypos = ypos - 90 + iconsize * 3 - verindex;
	xpos = xpos - 10 + iconsize * horindex;
	icon = createicon("white",iconsize,iconsize);
	icon setpoint("BOTTOM RIGHT","BOTTOM RIGHT",xpos,ypos);
	icon.horzalign = "user_right";
	icon.vertalign = "user_bottom";
	icon.archived = 0;
	icon.foreground = 0;
	return icon;
}

//Function Number: 35
setloadouticoncoords(player,verindex,horindex,xpos,ypos)
{
	iconsize = 32;
	if(player issplitscreen())
	{
		iconsize = 22;
	}

	ypos = ypos - 90 + iconsize * 3 - verindex;
	xpos = xpos - 10 + iconsize * horindex;
	self setpoint("BOTTOM RIGHT","BOTTOM RIGHT",xpos,ypos);
	self.horzalign = "user_right";
	self.vertalign = "user_bottom";
	self.archived = 0;
	self.foreground = 0;
	self.alpha = 1;
}

//Function Number: 36
setloadouttextcoords(xcoord)
{
	self setpoint("RIGHT","LEFT",xcoord,0);
}

//Function Number: 37
createloadouttext(icon,xcoord)
{
	text = createfontstring("small",1);
	text setparent(icon);
	text setpoint("RIGHT","LEFT",xcoord,0);
	text.archived = 0;
	text.alignx = "right";
	text.aligny = "middle";
	text.foreground = 0;
	return text;
}

//Function Number: 38
showloadoutattribute(iconelem,icon,alpha,textelem,text)
{
	iconsize = 32;
	iconelem.alpha = alpha;
	if(alpha)
	{
		iconelem setshader(icon,iconsize,iconsize);
	}

	if(IsDefined(textelem))
	{
		textelem.alpha = alpha;
		if(alpha)
		{
			textelem settext(text);
		}
	}
}

//Function Number: 39
hideloadoutattribute(iconelem,fadetime,textelem,hidetextonly)
{
	if(IsDefined(fadetime))
	{
		if(!IsDefined(hidetextonly) || !hidetextonly)
		{
			iconelem fadeovertime(fadetime);
		}

		if(IsDefined(textelem))
		{
			textelem fadeovertime(fadetime);
		}
	}

	if(!IsDefined(hidetextonly) || !hidetextonly)
	{
		iconelem.alpha = 0;
	}

	if(IsDefined(textelem))
	{
		textelem.alpha = 0;
	}
}

//Function Number: 40
showperks()
{
	ypos = 40;
	if(self issplitscreen())
	{
		ypos = 5;
	}

	if(!(IsDefined(self.perkhudelem)))
	{
		self.perkhudelem = createloadouticon(self,0,0,200,ypos);
	}
	else
	{
		self.perkhudelem setloadouticoncoords(self,0,0,200,ypos);
	}

	self.perkhudelem setperks(self);
	self.perkhudelem.x = -20;
	self.perkhudelem.alpha = 0;
	self.perkhudelem fadeovertime(0.4);
	self.perkhudelem.alpha = 1;
	self.perkhudelem.hidewheninmenu = 1;
}

//Function Number: 41
showperk(index,perk,ypos)
{
/#
	assert(game["state"] != "postgame");
#/
	if(!(IsDefined(self.perkicon)))
	{
		self.perkicon = [];
		self.perkname = [];
	}

	if(!(IsDefined(self.perkicon[index])))
	{
/#
		assert(!IsDefined(self.perkname[index]));
#/
		self.perkicon[index] = createloadouticon(self,index,0,200,ypos);
		self.perkname[index] = createloadouttext(self.perkicon[index],160);
	}
	else
	{
		self.perkicon[index] setloadouticoncoords(self,index,0,200,ypos);
		self.perkname[index] setloadouttextcoords(160);
	}

	if(perk == "perk_null" || perk == "weapon_null" || perk == "specialty_null")
	{
		alpha = 0;
	}
	else
	{
/#
		assert(IsDefined(level.perknames[perk]),perk);
#/
		alpha = 1;
	}

	showloadoutattribute(self.perkicon[index],perk,alpha,self.perkname[index],level.perknames[perk]);
	self.perkicon[index] moveovertime(0.3);
	self.perkicon[index].x = -5;
	self.perkicon[index].hidewheninmenu = 1;
	self.perkname[index] moveovertime(0.3);
	self.perkname[index].x = -40;
	self.perkname[index].hidewheninmenu = 1;
}

//Function Number: 42
hideperks(fadetime)
{
	if(level.perksenabled == 1)
	{
		if(game["state"] == "postgame")
		{
/#
			assert(!IsDefined(self.perkhudelem));
#/
			return;
		}
	}

/#
	assert(IsDefined(self.perkhudelem));
#/
	if(IsDefined(self.perkhudelem))
	{
		hideloadoutattribute(self.perkhudelem,fadetime);
	}
}

//Function Number: 43
hideperk(index,fadetime,hidetextonly)
{
	if(!(IsDefined(fadetime)))
	{
		fadetime = 0.05;
	}

	if(level.perksenabled == 1)
	{
		if(game["state"] == "postgame")
		{
			if(IsDefined(self.perkicon))
			{
/#
				assert(!IsDefined(self.perkicon[index]));
#/
/#
				assert(!IsDefined(self.perkname[index]));
			}
#/
			return;
		}

/#
		assert(IsDefined(self.perkicon[index]));
#/
/#
		assert(IsDefined(self.perkname[index]));
#/
		if(IsDefined(self.perkicon) && IsDefined(self.perkicon[index]) && IsDefined(self.perkname) && IsDefined(self.perkname[index]))
		{
			hideloadoutattribute(self.perkicon[index],fadetime,self.perkname[index],hidetextonly);
		}
	}
}

//Function Number: 44
hideallperks(fadetime,hidetextonly)
{
	if(level.perksenabled == 1)
	{
		hideperks(fadetime);
	}
}

//Function Number: 45
showkillstreak(index,killstreak,xpos,ypos)
{
/#
	assert(game["state"] != "postgame");
#/
	if(!(IsDefined(self.killstreakicon)))
	{
		self.killstreakicon = [];
	}

	if(!(IsDefined(self.killstreakicon[index])))
	{
		self.killstreakicon[index] = createloadouticon(self,3,self.killstreak.size - 1 - index,xpos,ypos);
	}

	if(killstreak == "killstreak_null" || killstreak == "weapon_null")
	{
		alpha = 0;
	}
	else
	{
/#
		assert(IsDefined(level.killstreakicons[killstreak]),killstreak);
#/
		alpha = 1;
	}

	showloadoutattribute(self.killstreakicon[index],level.killstreakicons[killstreak],alpha);
}

//Function Number: 46
hidekillstreak(index,fadetime)
{
	if(iskillstreaksenabled())
	{
		if(game["state"] == "postgame")
		{
/#
			assert(!IsDefined(self.killstreakicon[index]));
#/
			return;
		}

/#
		assert(IsDefined(self.killstreakicon[index]));
#/
		hideloadoutattribute(self.killstreakicon[index],fadetime);
	}
}

//Function Number: 47
setgamemodeinfopoint()
{
	self.x = 11;
	self.y = 120;
	self.horzalign = "user_left";
	self.vertalign = "user_top";
	self.alignx = "left";
	self.aligny = "top";
}
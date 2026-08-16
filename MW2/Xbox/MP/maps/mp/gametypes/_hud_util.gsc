/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_util.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

setparent(element)
{
	if(isdefined(self.parent) && self.parent == element)
	{
		return;
	}

	if(isdefined(self.parent))
	{
		self.parent removechild(self);
	}

	self.parent = element;
	self.parent addchild(self);
	if(isdefined(self.point))
	{
		setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
		return;
	}

	setpoint("TOPLEFT");
}

getparent()
{
	return self.parent;
}

addchild(element)
{
	element.index = self.children.size;
	self.children[self.children.size] = element;
}

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

setpoint(point, relativepoint, xoffset, yoffset, movetime)
{
	if(!isdefined(movetime))
	{
		movetime = 0;
	}

	element = getparent();
	if(movetime)
	{
		self moveovertime(movetime);
	}

	if(!isdefined(xoffset))
	{
		xoffset = 0;
	}

	self.xoffset = xoffset;
	if(!isdefined(yoffset))
	{
		yoffset = 0;
	}

	self.yoffset = yoffset;
	self.point = point;
	self.alignx = "center";
	self.aligny = "middle";
	if(issubstr(point, "TOP"))
	{
		self.aligny = "top";
	}

	if(issubstr(point, "BOTTOM"))
	{
		self.aligny = "bottom";
	}

	if(issubstr(point, "LEFT"))
	{
		self.alignx = "left";
	}

	if(issubstr(point, "RIGHT"))
	{
		self.alignx = "right";
	}

	if(!isdefined(relativepoint))
	{
		relativepoint = point;
	}

	self.relativepoint = relativepoint;
	relativex = "center_adjustable";
	relativey = "middle";
	if(issubstr(relativepoint, "TOP"))
	{
		relativey = "top_adjustable";
	}

	if(issubstr(relativepoint, "BOTTOM"))
	{
		relativey = "bottom_adjustable";
	}

	if(issubstr(relativepoint, "LEFT"))
	{
		relativex = "left_adjustable";
	}

	if(issubstr(relativepoint, "RIGHT"))
	{
		relativex = "right_adjustable";
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

	if(maps\mp\_utility::strip_suffix(relativex, "_adjustable") == element.alignx)
	{
		offsetx = 0;
		xfactor = 0;
	}
	else if(relativex == "center" || element.alignx == "center")
	{
		offsetx = int(element.width / 2);
		if(relativex == "left_adjustable" || element.alignx == "right")
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
		if(relativex == "left_adjustable")
		{
			xfactor = -1;
		}
		else
		{
			xfactor = 1;
		}
	}

	self.x = element.x + offsetx * xfactor;
	if(maps\mp\_utility::strip_suffix(relativey, "_adjustable") == element.aligny)
	{
		offsety = 0;
		yfactor = 0;
	}
	else if(relativey == "middle" || element.aligny == "middle")
	{
		offsety = int(element.height / 2);
		if(relativey == "top_adjustable" || element.aligny == "bottom")
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
		if(relativey == "top_adjustable")
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
			setpointbar(point, relativepoint, xoffset, yoffset);
			break;
	}

	updatechildren();
}

setpointbar(point, relativepoint, xoffset, yoffset)
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

	updatebar(self.bar.frac);
}

updatebar(barfrac, rateofchange)
{
	if(self.elemtype == "bar")
	{
		updatebarscale(barfrac, rateofchange);
		return;
	}
}

updatebarscale(barfrac, rateofchange)
{
	barwidth = int(self.width * barfrac + 0.5);
	if(!barwidth)
	{
		barwidth = 1;
	}

	self.bar.frac = barfrac;
	self.bar setshader(self.bar.shader, barwidth, self.height);
	if(isdefined(rateofchange) && barwidth < self.width)
	{
		if(rateofchange > 0)
		{
			self.bar scaleovertime(1 - barfrac / rateofchange, self.width, self.height);
		}
		else if(rateofchange < 0)
		{
			self.bar scaleovertime(barfrac / -1 * rateofchange, 1, self.height);
		}
	}

	self.bar.rateofchange = rateofchange;
	self.bar.lastupdatetime = gettime();
}

createfontstring(font, fontscale)
{
	fontelem = newclienthudelem(self);
	fontelem.elemtype = "font";
	fontelem.font = font;
	fontelem.fontscale = fontscale;
	fontelem.basefontscale = fontscale;
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

createserverfontstring(font, fontscale, team)
{
	if(isdefined(team))
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
	fontelem.basefontscale = fontscale;
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

createservertimer(font, fontscale, team)
{
	if(isdefined(team))
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
	timerelem.basefontscale = fontscale;
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

createtimer(font, fontscale)
{
	timerelem = newclienthudelem(self);
	timerelem.elemtype = "timer";
	timerelem.font = font;
	timerelem.fontscale = fontscale;
	timerelem.basefontscale = fontscale;
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

createicon(shader, width, height)
{
	iconelem = newclienthudelem(self);
	iconelem.elemtype = "icon";
	iconelem.x = 0;
	iconelem.y = 0;
	iconelem.width = width;
	iconelem.height = height;
	iconelem.basewidth = iconelem.width;
	iconelem.baseheight = iconelem.height;
	iconelem.xoffset = 0;
	iconelem.yoffset = 0;
	iconelem.children = [];
	iconelem setparent(level.uiparent);
	iconelem.hidden = 0;
	if(isdefined(shader))
	{
		iconelem setshader(shader, width, height);
		iconelem.shader = shader;
	}

	return iconelem;
}

createservericon(shader, width, height, team)
{
	if(isdefined(team))
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
	iconelem.basewidth = iconelem.width;
	iconelem.baseheight = iconelem.height;
	iconelem.xoffset = 0;
	iconelem.yoffset = 0;
	iconelem.children = [];
	iconelem setparent(level.uiparent);
	iconelem.hidden = 0;
	if(isdefined(shader))
	{
		iconelem setshader(shader, width, height);
		iconelem.shader = shader;
	}

	return iconelem;
}

createserverbar(color, width, height, flashfrac, team, selected)
{
	if(isdefined(team))
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
	barelem setshader("progress_bar_fill", width, height);
	barelem.hidden = 0;
	if(isdefined(flashfrac))
	{
		barelem.flashfrac = flashfrac;
	}

	if(isdefined(team))
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
	barelembg.children = [];
	barelembg.sort = -3;
	barelembg.color = (0,0,0);
	barelembg.alpha = 0.5;
	barelembg setparent(level.uiparent);
	barelembg setshader("progress_bar_bg", width, height);
	barelembg.hidden = 0;
	return barelembg;
}

createbar(color, width, height, flashfrac)
{
	barelem = newclienthudelem(self);
	barelem.x = 0;
	barelem.y = 0;
	barelem.frac = 0;
	barelem.color = color;
	barelem.sort = -2;
	barelem.shader = "progress_bar_fill";
	barelem setshader("progress_bar_fill", width, height);
	barelem.hidden = 0;
	if(isdefined(flashfrac))
	{
		barelem.flashfrac = flashfrac;
	}

	barelembg = newclienthudelem(self);
	barelembg.elemtype = "bar";
	barelembg.width = width;
	barelembg.height = height;
	barelembg.xoffset = 0;
	barelembg.yoffset = 0;
	barelembg.bar = barelem;
	barelembg.children = [];
	barelembg.sort = -3;
	barelembg.color = (0,0,0);
	barelembg.alpha = 0.5;
	barelembg setparent(level.uiparent);
	barelembg setshader("progress_bar_bg", width + 4, height + 4);
	barelembg.hidden = 0;
	return barelembg;
}

getcurrentfraction()
{
	frac = self.bar.frac;
	if(isdefined(self.bar.rateofchange))
	{
		frac = frac + gettime() - self.bar.lastupdatetime * self.bar.rateofchange;
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

createprimaryprogressbar(yoffset)
{
	if(!isdefined(yoffset))
	{
		yoffset = 0;
	}

	bar = createbar((1,1,1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
	bar setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary - yoffset);
	return bar;
}

createprimaryprogressbartext(yoffset)
{
	if(!isdefined(yoffset))
	{
		yoffset = 0;
	}

	text = createfontstring("hudbig", level.primaryprogressbarfontsize);
	text setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty - yoffset);
	text.sort = -1;
	return text;
}

createteamprogressbar(team)
{
	bar = createserverbar((1,0,0), level.teamprogressbarwidth, level.teamprogressbarheight, undefined, team);
	bar setpoint("TOP", undefined, 0, level.teamprogressbary);
	return bar;
}

createteamprogressbartext(team)
{
	text = createserverfontstring("default", level.teamprogressbarfontsize, team);
	text setpoint("TOP", undefined, 0, level.teamprogressbartexty);
	return text;
}

setflashfrac(flashfrac)
{
	self.bar.flashfrac = flashfrac;
}

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
			return;
		}

		return;
	}
}

showelem()
{
	if(!self.hidden)
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
			return;
		}

		return;
	}

	if(self.alpha != 1)
	{
		self.alpha = 1;
		return;
	}
}

flashthread()
{
	self endon("death");
	if(!self.hidden)
	{
		self.alpha = 1;
	}

	for(;;)
	{
		if(self.frac >= self.flashfrac)
		{
			if(!self.hidden)
			{
				self fadeovertime(0.3);
				self.alpha = 0.2;
				wait 0.35;
				self fadeovertime(0.3);
				self.alpha = 1;
			}

			wait 0.7;
			continue;
		}

		if(!self.hidden && self.alpha != 1)
		{
			self.alpha = 1;
		}

		wait 0.05;
	}
}

destroyelem()
{
	tempchildren = [];
	for(index = 0;index < self.children.size;index++)
	{
		if(isdefined(self.children[index]))
		{
			tempchildren[tempchildren.size] = self.children[index];
		}
	}

	for(index = 0;index < tempchildren.size;index++)
	{
		tempchildren[index] setparent(getparent());
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar destroy();
	}

	self destroy();
}

seticonshader(shader)
{
	self setshader(shader);
	self.shader = shader;
}

geticonshader(shader)
{
	return self.shader;
}

seticonsize(width, height)
{
	self setshader(self.shader, width, height);
}

setwidth(width)
{
	self.width = width;
}

setheight(height)
{
	self.height = height;
}

setsize(width, height)
{
	self.width = width;
	self.height = height;
}

updatechildren()
{
	for(index = 0;index < self.children.size;index++)
	{
		child = self.children[index];
		child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
	}
}

transitionreset()
{
	self.x = self.xoffset;
	self.y = self.yoffset;
	if(self.elemtype == "font")
	{
		self.fontscale = self.basefontscale;
		self.label = &"";
	}
	else if(self.elemtype == "icon")
	{
		self setshader(self.shader, self.width, self.height);
	}

	self.alpha = 0;
}

transitionzoomin(duration)
{
	switch(self.elemtype)
	{
		case "font":
		case "timer":
			self.fontscale = 6.3;
			self changefontscaleovertime(duration);
			self.fontscale = self.basefontscale;
			break;

		case "icon":
			self setshader(self.shader, self.width * 6, self.height * 6);
			self scaleovertime(duration, self.width, self.height);
			break;
	}
}

transitionpulsefxin(intime, duration)
{
	transtime = int(intime) * 1000;
	showtime = int(duration) * 1000;
	switch(self.elemtype)
	{
		case "font":
		case "timer":
			self setpulsefx(transtime + 250, showtime + transtime, transtime + 250);
			break;

		default:
			break;
	}
}

transitionslidein(duration, direction)
{
	if(!isdefined(direction))
	{
		direction = "left";
	}

	switch(direction)
	{
		case "left":
			self.x = self.x + 1000;
			break;

		case "right":
			self.x = self.x - 1000;
			break;

		case "up":
			self.y = self.y - 1000;
			break;

		case "down":
			self.y = self.y + 1000;
			break;
	}

	self moveovertime(duration);
	self.x = self.xoffset;
	self.y = self.yoffset;
}

transitionslideout(duration, direction)
{
	if(!isdefined(direction))
	{
		direction = "left";
	}

	gotox = self.xoffset;
	gotoy = self.yoffset;
	switch(direction)
	{
		case "left":
			gotox = gotox + 1000;
			break;

		case "right":
			gotox = gotox - 1000;
			break;

		case "up":
			gotoy = gotoy - 1000;
			break;

		case "down":
			gotoy = gotoy + 1000;
			break;
	}

	self.alpha = 1;
	self moveovertime(duration);
	self.x = gotox;
	self.y = gotoy;
}

transitionzoomout(duration)
{
	switch(self.elemtype)
	{
		case "font":
		case "timer":
			self changefontscaleovertime(duration);
			self.fontscale = 6.3;
			break;

		case "icon":
			self scaleovertime(duration, self.width * 6, self.height * 6);
			break;
	}
}

transitionfadein(duration)
{
	self fadeovertime(duration);
	if(isdefined(self.maxalpha))
	{
		self.alpha = self.maxalpha;
		return;
	}

	self.alpha = 1;
}

transitionfadeout(duration)
{
	self fadeovertime(0.15);
	self.alpha = 0;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud_util.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 443 ms
 * Timestamp: 10/27/2023 2:25:10 AM
*******************************************************************/

//Function Number: 1
setparent(param_00)
{
	if(isdefined(self.parent) && self.parent == param_00)
	{
		return;
	}

	if(isdefined(self.parent))
	{
		self.parent removechild(self);
	}

	self.parent = param_00;
	self.parent addchild(self);
	if(isdefined(self.point))
	{
		setpoint(self.point,self.relativepoint,self.xoffset,self.yoffset);
		return;
	}

	setpoint("TOPLEFT");
}

//Function Number: 2
getparent()
{
	return self.parent;
}

//Function Number: 3
addchild(param_00)
{
	param_00.index = self.children.size;
	self.children[self.children.size] = param_00;
}

//Function Number: 4
removechild(param_00)
{
	param_00.parent = undefined;
	if(self.children[self.children.size - 1] != param_00)
	{
		self.children[param_00.index] = self.children[self.children.size - 1];
		self.children[param_00.index].index = param_00.index;
	}

	self.children[self.children.size - 1] = undefined;
	param_00.index = undefined;
}

//Function Number: 5
setpoint(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = getparent();
	if(param_04)
	{
		self moveovertime(param_04);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.xoffset = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self.yoffset = param_03;
	self.point = param_00;
	self.alignx = "center";
	self.aligny = "middle";
	if(issubstr(param_00,"TOP"))
	{
		self.aligny = "top";
	}

	if(issubstr(param_00,"BOTTOM"))
	{
		self.aligny = "bottom";
	}

	if(issubstr(param_00,"LEFT"))
	{
		self.alignx = "left";
	}

	if(issubstr(param_00,"RIGHT"))
	{
		self.alignx = "right";
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.relativepoint = param_01;
	var_06 = "center";
	var_07 = "middle";
	if(issubstr(param_01,"TOP"))
	{
		var_07 = "top";
	}

	if(issubstr(param_01,"BOTTOM"))
	{
		var_07 = "bottom";
	}

	if(issubstr(param_01,"LEFT"))
	{
		var_06 = "left";
	}

	if(issubstr(param_01,"RIGHT"))
	{
		var_06 = "right";
	}

	if(var_05 == level.uiparent)
	{
		self.horzalign = var_06;
		self.vertalign = var_07;
	}
	else
	{
		self.horzalign = var_05.horzalign;
		self.vertalign = var_05.vertalign;
	}

	if(var_06 == var_05.alignx)
	{
		var_08 = 0;
		var_09 = 0;
	}
	else if(var_08 == "center" || var_07.alignx == "center")
	{
		var_08 = int(var_07.width / 2);
		if(var_07 == "left" || var_06.alignx == "right")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}
	else
	{
		var_08 = var_07.width;
		if(var_07 == "left")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}

	self.x = var_05.x + var_08 * var_09;
	if(var_07 == var_05.aligny)
	{
		var_0A = 0;
		var_0B = 0;
	}
	else if(var_09 == "middle" || var_07.aligny == "middle")
	{
		var_0A = int(var_07.height / 2);
		if(var_08 == "top" || var_06.aligny == "bottom")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}
	else
	{
		var_0A = var_07.height;
		if(var_08 == "top")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}

	self.y = var_05.y + var_0A * var_0B;
	self.x = self.x + self.xoffset;
	self.y = self.y + self.yoffset;
	switch(self.elemtype)
	{
		case "bar":
			setpointbar(param_00,param_01,param_02,param_03);
			break;
	}

	updatechildren();
}

//Function Number: 6
setpointbar(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x + self.padding;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width - self.padding;
	}
	else
	{
		self.bar.x = self.x - int(self.width - self.padding / 2);
	}

	updatebar(self.bar.frac);
}

//Function Number: 7
updatebar(param_00)
{
	var_01 = int(self.width - self.padding * 2 * param_00);
	if(!var_01)
	{
		var_01 = 1;
	}

	self.bar.frac = param_00;
	self.bar setshader(self.bar.shader,var_01,self.height - self.padding * 2);
}

//Function Number: 8
hidebar(param_00)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,1);
	if(param_00 || !isdefined(self.var_987) || !isdefined(self.bar.var_987))
	{
		self.var_987 = self.alpha;
		self.bar.var_987 = self.bar.alpha;
	}

	self.alpha = common_scripts\utility::ter_op(param_00,0,self.var_987);
	self.bar.alpha = common_scripts\utility::ter_op(param_00,0,self.bar.var_987);
}

//Function Number: 9
createfontstring(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.elemtype = "font";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	return var_02;
}

//Function Number: 10
createclientfontstring(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.elemtype = "font";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	return var_02;
}

//Function Number: 11
createclienttimer(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.elemtype = "timer";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	return var_02;
}

//Function Number: 12
createserverfontstring(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.elemtype = "font";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	return var_02;
}

//Function Number: 13
createservertimer(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.elemtype = "timer";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 setparent(level.uiparent);
	return var_02;
}

//Function Number: 14
createicon(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	return createicon_hudelem(var_03,param_00,param_01,param_02);
}

//Function Number: 15
createclienticon(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(self);
	return createicon_hudelem(var_03,param_00,param_01,param_02);
}

//Function Number: 16
createicon_hudelem(param_00,param_01,param_02,param_03)
{
	param_00.elemtype = "icon";
	param_00.x = 0;
	param_00.y = 0;
	param_00.width = param_02;
	param_00.height = param_03;
	param_00.xoffset = 0;
	param_00.yoffset = 0;
	param_00.children = [];
	param_00 setparent(level.uiparent);
	if(isdefined(param_01))
	{
		param_00 setshader(param_01,param_02,param_03);
	}

	return param_00;
}

//Function Number: 17
createbar(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		param_00 = "white";
	}

	if(!isdefined(param_01))
	{
		param_01 = "black";
	}

	if(!isdefined(param_02))
	{
		param_02 = 100;
	}

	if(!isdefined(param_03))
	{
		param_03 = 9;
	}

	var_05 = newhudelem();
	var_05.x = 2;
	var_05.y = 2;
	var_05.frac = 0.25;
	var_05.shader = param_00;
	var_05.sort = -1;
	var_05 setshader(param_00,param_02 - 2,param_03 - 2);
	if(isdefined(param_04))
	{
		var_05.flashfrac = param_04;
		var_05 thread flashthread();
	}

	var_06 = newhudelem();
	var_06.elemtype = "bar";
	var_06.x = 0;
	var_06.y = 0;
	var_06.width = param_02;
	var_06.height = param_03;
	var_06.xoffset = 0;
	var_06.yoffset = 0;
	var_06.bar = var_05;
	var_06.children = [];
	var_06.padding = 2;
	var_06.sort = -2;
	var_06.alpha = 0.5;
	var_06 setparent(level.uiparent);
	var_06 setshader(param_01,param_02,param_03);
	return var_06;
}

//Function Number: 18
createclientprogressbar(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,level.player);
	param_01 = common_scripts\utility::ter_op(isdefined(param_01),param_01,90);
	param_02 = common_scripts\utility::ter_op(isdefined(param_02),param_02,"white");
	param_03 = common_scripts\utility::ter_op(isdefined(param_03),param_03,"black");
	param_04 = common_scripts\utility::ter_op(isdefined(param_04),param_04,100);
	param_05 = common_scripts\utility::ter_op(isdefined(param_05),param_05,9);
	var_06 = param_00 createclientbar(param_02,param_03,param_04,param_05);
	var_06 setpoint("CENTER",undefined,0,param_01);
	return var_06;
}

//Function Number: 19
createclientbar(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = newclienthudelem(self);
	var_05.x = 2;
	var_05.y = 2;
	var_05.frac = 0.25;
	var_05.shader = param_00;
	var_05.sort = -1;
	var_05 setshader(param_00,param_02 - 2,param_03 - 2);
	if(isdefined(param_04))
	{
		var_05.flashfrac = param_04;
		var_05 thread flashthread();
	}

	var_06 = newclienthudelem(self);
	var_06.elemtype = "bar";
	var_06.x = 0;
	var_06.y = 0;
	var_06.width = param_02;
	var_06.height = param_03;
	var_06.xoffset = 0;
	var_06.yoffset = 0;
	var_06.bar = var_05;
	var_06.children = [];
	var_06.padding = 2;
	var_06.sort = -2;
	var_06.alpha = 0.5;
	var_06 setparent(level.uiparent);
	var_06 setshader(param_01,param_02,param_03);
	return var_06;
}

//Function Number: 20
setflashfrac(param_00)
{
	self.bar.flashfrac = param_00;
}

//Function Number: 21
fade_over_time(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		self fadeovertime(param_01);
	}

	self.alpha = param_00;
	if(isdefined(param_01) && param_01 > 0)
	{
		wait param_01;
	}
}

//Function Number: 22
flashthread()
{
	self endon("death");
	self.alpha = 1;
	for(;;)
	{
		if(self.frac >= self.flashfrac)
		{
			self fadeovertime(0.3);
			self.alpha = 0.2;
			wait 0.35;
			self fadeovertime(0.3);
			self.alpha = 1;
			wait 0.7;
			continue;
		}

		self.alpha = 1;
		wait 0.05;
	}
}

//Function Number: 23
destroyelem()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		var_00[var_01] = self.children[var_01];
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] setparent(getparent());
	}

	if(self.elemtype == "bar")
	{
		self.bar destroy();
	}

	self destroy();
}

//Function Number: 24
seticonshader(param_00)
{
	self setshader(param_00,self.width,self.height);
}

//Function Number: 25
setwidth(param_00)
{
	self.width = param_00;
}

//Function Number: 26
setheight(param_00)
{
	self.height = param_00;
}

//Function Number: 27
setsize(param_00,param_01)
{
	self.width = param_00;
	self.height = param_01;
}

//Function Number: 28
updatechildren()
{
	for(var_00 = 0;var_00 < self.children.size;var_00++)
	{
		var_01 = self.children[var_00];
		var_01 setpoint(var_01.point,var_01.relativepoint,var_01.xoffset,var_01.yoffset);
	}
}

//Function Number: 29
stance_carry_icon_enable(param_00)
{
	if(isdefined(param_00) && param_00 == 0)
	{
		stance_carry_icon_disable();
		return;
	}

	if(isdefined(level.var_99F))
	{
		level.var_99F destroy();
	}

	setsaveddvar("hud_showStance","0");
	level.var_99F = newhudelem();
	level.var_99F.x = -75;
	if(level.console)
	{
		level.var_99F.y = -20;
	}
	else
	{
		level.var_99F.y = -10;
	}

	level.var_99F setshader("stance_carry",64,64);
	level.var_99F.alignx = "right";
	level.var_99F.aligny = "bottom";
	level.var_99F.horzalign = "right";
	level.var_99F.vertalign = "bottom";
	level.var_99F.foreground = 1;
	level.var_99F.alpha = 0;
	level.var_99F fadeovertime(0.5);
	level.var_99F.alpha = 1;
}

//Function Number: 30
stance_carry_icon_disable()
{
	if(isdefined(level.var_99F))
	{
		level.var_99F fadeovertime(0.5);
		level.var_99F.alpha = 0;
		level.var_99F destroy();
	}

	setsaveddvar("hud_showStance","1");
}

//Function Number: 31
create_mantle()
{
	if(level.console)
	{
		var_00 = createfontstring("default",1.8);
		var_00 setpoint("CENTER",undefined,-23,115);
		var_00 settext(level.strings["mantle"]);
		var_01 = createicon("hint_mantle",40,40);
		var_01 setpoint("CENTER",undefined,73,0);
		var_01 setparent(var_00);
	}
	else
	{
		var_00 = createfontstring("default",1.6);
		var_01 setpoint("CENTER",undefined,0,115);
		var_01 settext(level.strings["mantle"]);
		var_01 = createicon("hint_mantle",40,40);
		var_01 setpoint("CENTER",undefined,0,30);
		var_01 setparent(var_00);
	}

	var_01.alpha = 0;
	var_00.alpha = 0;
	level.var_9A4 = [];
	level.var_9A4["text"] = var_00;
	level.var_9A4["icon"] = var_01;
}

//Function Number: 32
get_countdown_hud(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = undefined;
	if(!level.console)
	{
		var_04 = -250;
	}
	else if(!isdefined(param_00))
	{
		var_04 = -225;
	}
	else
	{
		var_04 = param_00;
	}

	if(param_03)
	{
		var_04 = param_00;
	}

	if(!isdefined(param_01))
	{
		var_05 = 100;
	}
	else
	{
		var_05 = param_02;
	}

	if(isdefined(param_02))
	{
		var_06 = newclienthudelem(param_02);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.alignx = "left";
	var_06.aligny = "middle";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.x = var_04;
	var_06.y = var_05;
	var_06.fontscale = 1.6;
	var_06.color = (0.8,1,0.8);
	var_06.font = "objective";
	var_06.glowcolor = (0.3,0.6,0.3);
	var_06.glowalpha = 1;
	var_06.foreground = 1;
	var_06.hidewheninmenu = 1;
	var_06.hidewhendead = 1;
	return var_06;
}

//Function Number: 33
get_download_state_hud(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = undefined;
	if(!level.console)
	{
		var_04 = -250;
	}
	else if(!isdefined(param_00))
	{
		var_04 = -170;
	}
	else
	{
		var_04 = param_00;
	}

	if(param_03)
	{
		var_04 = param_00;
	}

	if(!isdefined(param_01))
	{
		var_05 = 100;
	}
	else
	{
		var_05 = param_02;
	}

	if(isdefined(param_02))
	{
		var_06 = newclienthudelem(param_02);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.alignx = "right";
	var_06.aligny = "middle";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.x = var_04;
	var_06.y = var_05;
	var_06.fontscale = 1.6;
	var_06.color = (0.8,1,0.8);
	var_06.font = "objective";
	var_06.glowcolor = (0.3,0.6,0.3);
	var_06.glowalpha = 1;
	var_06.foreground = 1;
	var_06.hidewheninmenu = 1;
	var_06.hidewhendead = 1;
	return var_06;
}

//Function Number: 34
create_client_overlay(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = newclienthudelem(param_02);
	}
	else
	{
		var_03 = newhudelem();
	}

	var_03.x = 0;
	var_03.y = 0;
	var_03 setshader(param_00,640,480);
	var_03.alignx = "left";
	var_03.aligny = "top";
	var_03.sort = 1;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_01;
	var_03.foreground = 1;
	return var_03;
}

//Function Number: 35
create_client_overlay_custom_size(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::get_player_from_self();
	var_06 = newclienthudelem(var_05);
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_06.x = param_02;
	var_06.y = param_03;
	var_06 setshader(param_00,int(640 * param_04),int(480 * param_04));
	var_06.alignx = "center";
	var_06.aligny = "middle";
	var_06.sort = 1;
	var_06.horzalign = "center";
	var_06.vertalign = "middle";
	var_06.alpha = param_01;
	var_06.foreground = 1;
	return var_06;
}

//Function Number: 36
create_client_overlay_fullscreen(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::get_player_from_self();
	var_06 = newclienthudelem(var_05);
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_06.x = param_02;
	var_06.y = param_03;
	var_06 setshader(param_00,int(640 * param_04),int(480 * param_04));
	var_06.alignx = "center";
	var_06.aligny = "middle";
	var_06.sort = 1;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = param_01;
	var_06.foreground = 1;
	return var_06;
}
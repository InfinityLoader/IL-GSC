/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud_util.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 1210 ms
 * Timestamp: 10/27/2023 2:48:00 AM
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
removedestroyedchildren()
{
	if(isdefined(self.childchecktime) && self.childchecktime == gettime())
	{
		return;
	}

	self.childchecktime = gettime();
	var_00 = [];
	foreach(var_02 in self.children)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02.index = var_00.size;
		var_00[var_00.size] = var_02;
	}

	self.children = var_00;
}

//Function Number: 4
addchild(param_00)
{
	param_00.index = self.children.size;
	self.children[self.children.size] = param_00;
	removedestroyedchildren();
}

//Function Number: 5
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

//Function Number: 6
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
			break;
	}
}

//Function Number: 7
setpointbar(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.bar.offset_y + self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.bar.offset_x + self.x + self.xpadding;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.bar.offset_x + self.x - self.width - self.xpadding;
	}
	else
	{
		self.bar.x = self.bar.offset_x + self.x - int(self.width - self.xpadding * 2 / 2);
	}

	if(isdefined(self.progress_bg_distort))
	{
		self.progress_bg_distort.x = self.x;
		self.progress_bg_distort.y = self.y;
		self.progress_bg_distort.horzalign = self.horzalign;
		self.progress_bg_distort.vertalign = self.vertalign;
		self.progress_bg_distort.alignx = self.alignx;
		self.progress_bg_distort.aligny = self.aligny;
	}

	updatebar(self.bar.frac);
}

//Function Number: 8
updatebar(param_00)
{
	var_01 = int(self.width - self.xpadding * 2 * param_00);
	if(!var_01)
	{
		var_01 = 1;
	}

	self.bar.frac = param_00;
	self.bar setshader(self.bar.shader,var_01,self.height - self.ypadding * 2);
}

//Function Number: 9
hidebar(param_00)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,1);
	if(param_00 || !isdefined(self.orig_alpha) || !isdefined(self.bar.orig_alpha))
	{
		self.orig_alpha = self.alpha;
		self.bar.orig_alpha = self.bar.alpha;
	}

	self.alpha = common_scripts\utility::ter_op(param_00,0,self.orig_alpha);
	self.bar.alpha = common_scripts\utility::ter_op(param_00,0,self.bar.orig_alpha);
}

//Function Number: 10
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

//Function Number: 11
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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
createicon(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	return createicon_hudelem(var_03,param_00,param_01,param_02);
}

//Function Number: 16
createclienticon(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(self);
	return createicon_hudelem(var_03,param_00,param_01,param_02);
}

//Function Number: 17
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

//Function Number: 18
h1_createbar(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = newhudelem();
	var_07.alignx = "center";
	var_07.aligny = "bottom";
	var_07.horzalign = "center";
	var_07.vertalign = "bottom";
	var_07.x = param_00;
	var_07.y = param_01 + 1;
	var_07.alpha = 0.9;
	var_07 setshader(param_05,param_02,param_03);
	var_07.sort = -2;
	var_08 = newhudelem();
	var_08 setshader(param_06,10,0);
	var_08.alignx = "right";
	var_08.aligny = "bottom";
	var_08.horzalign = "right";
	var_08.vertalign = "bottom";
	var_08.offset_x = 1;
	var_08.offset_y = -2;
	var_08.color = (1,0.9,0.1);
	var_08.alpha = 0.9;
	var_08.sort = 0;
	var_08.frac = 0.25;
	var_08.shader = param_06;
	var_09 = newhudelem();
	var_09.elemtype = "bar";
	var_09.alignx = "center";
	var_09.aligny = "bottom";
	var_09.horzalign = "center";
	var_09.vertalign = "bottom";
	var_09.x = param_00;
	var_09.y = param_01 + 1;
	var_09.alpha = 0.3;
	var_09 setshader(param_04,param_02,param_03);
	var_09.sort = -1;
	var_09.width = param_02;
	var_09.height = param_03;
	var_09.xpadding = 2;
	var_09.ypadding = 3;
	var_09.children = [];
	var_09.progress_bg_distort = var_07;
	var_09.bar = var_08;
	var_09 setparent(level.uiparent);
	return var_09;
}

//Function Number: 19
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

	var_05.offset_x = 0;
	var_05.offset_y = 0;
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
	var_06.xpadding = 2;
	var_06.ypadding = 2;
	var_06.sort = -2;
	var_06.alpha = 0.5;
	var_06 setparent(level.uiparent);
	var_06 setshader(param_01,param_02,param_03);
	return var_06;
}

//Function Number: 20
createclientprogressbar(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,level.player);
	param_01 = common_scripts\utility::ter_op(isdefined(param_01),param_01,90);
	param_02 = common_scripts\utility::ter_op(isdefined(param_02),param_02,"white");
	param_03 = common_scripts\utility::ter_op(isdefined(param_03),param_03,"black");
	param_04 = common_scripts\utility::ter_op(isdefined(param_04),param_04,100);
	param_05 = common_scripts\utility::ter_op(isdefined(param_05),param_05,9);
	param_06 = common_scripts\utility::ter_op(isdefined(param_06),param_06,2);
	param_07 = common_scripts\utility::ter_op(isdefined(param_07),param_07,2);
	var_08 = param_00 createclientbar(param_02,param_03,param_04,param_05,undefined,param_06,param_07);
	var_08 setpoint("CENTER",undefined,0,param_01);
	return var_08;
}

//Function Number: 21
createclientbar(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_05))
	{
		param_05 = 2;
	}

	if(!isdefined(param_06))
	{
		param_06 = 2;
	}

	var_07 = newclienthudelem(self);
	var_07.x = 0 - param_05;
	var_07.y = 0 - param_06;
	var_07.frac = 0.25;
	var_07.shader = param_00;
	var_07.sort = -1;
	var_07 setshader(param_00,param_02 - param_05 * 2,param_03 - param_06 * 2);
	if(isdefined(param_04))
	{
		var_07.flashfrac = param_04;
		var_07 thread flashthread();
	}

	var_08 = newclienthudelem(self);
	var_08.elemtype = "bar";
	var_08.x = 0;
	var_08.y = 0;
	var_08.width = param_02;
	var_08.height = param_03;
	var_08.xoffset = -1 * param_05;
	var_08.yoffset = 0;
	var_08.bar = var_07;
	var_08.children = [];
	var_08.xpadding = param_05;
	var_08.ypadding = param_06;
	var_08.sort = -2;
	var_08.alpha = 0.5;
	var_08 setparent(level.uiparent);
	var_08 setshader(param_01,param_02,param_03);
	return var_08;
}

//Function Number: 22
setflashfrac(param_00)
{
	self.bar.flashfrac = param_00;
}

//Function Number: 23
fade_over_time(param_00,param_01)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		self fadeovertime(param_01);
	}

	self.alpha = param_00;
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}
}

//Function Number: 24
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
			wait(0.35);
			self fadeovertime(0.3);
			self.alpha = 1;
			wait(0.7);
			continue;
		}

		self.alpha = 1;
		wait(0.05);
	}
}

//Function Number: 25
destroyelem()
{
	if(isdefined(self.children) && self.children.size)
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
	}

	if(isdefined(self.elemtype) && self.elemtype == "bar")
	{
		self.bar destroy();
		if(isdefined(self.progress_bg_distort))
		{
			self.progress_bg_distort destroy();
		}
	}

	self destroy();
}

//Function Number: 26
seticonshader(param_00)
{
	self setshader(param_00,self.width,self.height);
}

//Function Number: 27
setwidth(param_00)
{
	self.width = param_00;
}

//Function Number: 28
setheight(param_00)
{
	self.height = param_00;
}

//Function Number: 29
setsize(param_00,param_01)
{
	self.width = param_00;
	self.height = param_01;
}

//Function Number: 30
updatechildren(param_00)
{
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		var_02 = self.children[var_01];
		var_02 setpoint(var_02.point,var_02.relativepoint,var_02.xoffset,var_02.yoffset,param_00);
	}
}

//Function Number: 31
stance_carry_icon_enable(param_00)
{
	if(isdefined(param_00) && param_00 == 0)
	{
		stance_carry_icon_disable();
		return;
	}

	setsaveddvar("hud_showStanceCarry","1");
}

//Function Number: 32
stance_carry_icon_disable()
{
	setsaveddvar("hud_showStanceCarry","0");
}

//Function Number: 33
create_mantle()
{
	if(level.console)
	{
		var_00 = createfontstring("default",1.8);
		var_00 setpoint("CENTER",undefined,0,115);
		var_00 settext(level.strings["mantle"]);
	}
	else
	{
		var_00 = createfontstring("default",1.6);
		var_00 setpoint("CENTER",undefined,0,115);
		var_00 settext(level.strings["mantle"]);
	}

	var_00.alpha = 0;
	level.hud_mantle = [];
	level.hud_mantle["text"] = var_00;
}

//Function Number: 34
add_hint_background(param_00,param_01,param_02)
{
	clear_hint_background();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isdefined(param_00))
	{
		var_03 = 121;
		var_04 = 38;
		level.hintbackground = createicon("h1_hud_tutorial_blur",560,39);
		level.hintbordertop = createicon("h1_hud_tutorial_border",560,1);
		level.hintborderbottom = createicon("h1_hud_tutorial_border",560,1);
	}
	else
	{
		var_03 = 121;
		var_04 = 24;
		level.hintbackground = createicon("h1_hud_tutorial_blur",560,25);
		level.hintbordertop = createicon("h1_hud_tutorial_border",560,1);
		level.hintborderbottom = createicon("h1_hud_tutorial_border",560,1);
	}

	level.hintbackground setpoint("TOP",undefined,0,var_03 + param_01);
	level.hintbackground.sort = 1;
	level.hintbackground.hidewheninmenu = 1;
	level.hintbackground.hidewhendead = 1;
	level.hintbordertop setpoint("TOP",undefined,0,var_03 + param_01);
	level.hintbordertop.sort = 1;
	level.hintbordertop.hidewheninmenu = 1;
	level.hintbordertop.hidewhendead = 1;
	level.hintborderbottom setpoint("TOP",undefined,0,var_03 + param_01 + var_04);
	level.hintborderbottom.sort = 1;
	level.hintborderbottom.hidewheninmenu = 1;
	level.hintborderbottom.hidewhendead = 1;
	if(param_02 == 0)
	{
		level.hintbackground.alpha = 0.9;
		level.hintbordertop.alpha = 0.05;
		level.hintborderbottom.alpha = 0.05;
		return;
	}

	level.hintbackground.alpha = 0;
	level.hintbackground fadeovertime(param_02);
	level.hintbackground.alpha = 0.9;
	level.hintbordertop.alpha = 0;
	level.hintbordertop fadeovertime(param_02);
	level.hintbordertop.alpha = 0.05;
	level.hintborderbottom.alpha = 0;
	level.hintborderbottom fadeovertime(param_02);
	level.hintborderbottom.alpha = 0.05;
}

//Function Number: 35
fade_hint_background(param_00)
{
	if(isdefined(level.hintbackground))
	{
		if(param_00 > 0)
		{
			level.hintbackground fadeovertime(param_00);
		}

		level.hintbackground.alpha = 0;
	}

	if(isdefined(level.hintbordertop))
	{
		if(param_00 > 0)
		{
			level.hintbordertop fadeovertime(param_00);
		}

		level.hintbordertop.alpha = 0;
	}

	if(isdefined(level.hintborderbottom))
	{
		if(param_00 > 0)
		{
			level.hintborderbottom fadeovertime(param_00);
		}

		level.hintborderbottom.alpha = 0;
	}
}

//Function Number: 36
clear_hint_background()
{
	if(isdefined(level.hintbackground))
	{
		level.hintbackground destroyelem();
	}

	if(isdefined(level.hintbordertop))
	{
		level.hintbordertop destroyelem();
	}

	if(isdefined(level.hintborderbottom))
	{
		level.hintborderbottom destroyelem();
	}
}

//Function Number: 37
get_stats_display_hud(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_06 = common_scripts\utility::ter_op(!isdefined(param_00) || param_03,-225,param_00);
	var_07 = common_scripts\utility::ter_op(!isdefined(param_01),10.5,param_01);
	param_04 = common_scripts\utility::ter_op(!isdefined(param_04),1.6,param_04);
	if(isdefined(param_02))
	{
		var_08 = newclienthudelem(param_02);
	}
	else
	{
		var_08 = newhudelem();
	}

	var_08.alignx = "left";
	var_08.aligny = "middle";
	var_08.horzalign = "right";
	var_08.vertalign = "top";
	var_08.x = var_06;
	var_08.y = var_07;
	if(maps\_utility::arcademode())
	{
		var_08.alignx = "left";
		var_08.aligny = "top";
		var_08.horzalign = "right";
		var_08.vertalign = "top";
		var_08.y = 0;
	}

	var_08.fontscale = param_04;
	var_08.color = (0.8,1,0.8);
	var_08.font = "objective";
	var_08.glowcolor = (0.26,0.65,0.32);
	var_08.glowalpha = 0.2;
	var_08.foreground = 1;
	var_08.hidewheninmenu = 1;
	var_08.hidewhendead = 1;
	if(isdefined(param_05))
	{
		var_08 settext(param_05);
	}

	return var_08;
}

//Function Number: 38
add_countdown_flourish_flash_timer(param_00,param_01,param_02,param_03)
{
	level endon("kill_timer_flourish");
	for(;;)
	{
		param_00.color = param_02;
		wait(param_01);
		param_00.color = param_03;
		wait(param_01);
	}
}

//Function Number: 39
add_countdown_flourish(param_00,param_01,param_02,param_03)
{
	level endon("kill_timer_flourish");
	var_04 = 57;
	var_05 = (1,1,1);
	var_06 = 210;
	var_07 = 0.13;
	var_08 = 0.03;
	var_09 = 0.01;
	var_0A = 5;
	var_0B = 0.1;
	var_0C = (0.9,0.2,0.2);
	var_0D = var_07 + var_08;
	if(param_02 > 30)
	{
		var_0E = var_05;
	}
	else
	{
		var_0E = var_0D;
	}

	var_0F = newhudelem();
	var_0F.x = param_00;
	var_0F.y = param_01 - 10;
	var_0F setshader("h1_timer_on_flare",0,var_04);
	var_0F.alignx = "center";
	var_0F.color = var_0E;
	var_0F.aligny = "top";
	var_0F.sort = 1;
	var_0F.foreground = 0;
	var_0F.horzalign = "center_adjustable";
	var_0F.vertalign = "top_adjustable";
	var_0F.hidewheninmenu = 1;
	var_0F.hidewhendead = 1;
	var_0F.alpha = 1;
	param_02 = param_02 - 0.05;
	wait(0.05);
	if(param_02 > 30)
	{
		var_0F scaleovertime(var_0D,var_06,var_04);
		param_02 = param_02 - var_07;
		wait(var_07);
		var_0F fadeovertime(var_08);
		var_0F.alpha = 0;
		param_02 = param_02 - var_08;
		wait(var_08);
		var_10 = param_02 - 30;
		param_02 = param_02 - var_10;
		wait(var_10);
		var_0F scaleovertime(0.05,0,var_04);
		param_02 = param_02 - 0.05;
		wait(0.05);
	}

	param_03.color = var_0C;
	var_0F.color = var_0C;
	var_0F.alpha = 1;
	var_0F scaleovertime(var_0D,var_06,var_04);
	param_02 = param_02 - var_07;
	wait(var_07);
	var_0F fadeovertime(var_08);
	var_0F.alpha = 0;
	param_02 = param_02 - var_08;
	wait(var_08);
	var_0F scaleovertime(0.05,0,var_04);
	if(param_02 > 15)
	{
		var_11 = param_02 - 15;
		param_02 = param_02 - var_11;
		wait(var_11);
	}

	thread add_countdown_flourish_flash_timer(param_03,var_0B,var_05,var_0C);
	var_12 = param_03.y;
	for(;;)
	{
		var_0F.alpha = 1;
		var_0F scaleovertime(0.05,var_06,var_04);
		param_03.y = var_12 + var_0A;
		wait(var_09);
		var_0F fadeovertime(0.05);
		var_0F.alpha = 0;
		param_03.y = var_12;
		wait(1 - var_09);
	}

	var_0F destroy();
}

//Function Number: 40
get_countdown_hud(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = common_scripts\utility::ter_op(!isdefined(param_00) || param_03,0,param_00);
	var_06 = common_scripts\utility::ter_op(!isdefined(param_01),10.5,param_01);
	if(isdefined(param_02))
	{
		var_07 = newclienthudelem(param_02);
	}
	else
	{
		var_07 = newhudelem();
	}

	var_07.alignx = "center";
	var_07.aligny = "top";
	var_07.horzalign = "center_adjustable";
	var_07.vertalign = "top_adjustable";
	var_07.x = var_05;
	switch(getdvarint("loc_language"))
	{
		case 15:
		case 12:
		case 11:
		case 10:
		case 9:
		case 8:
			break;

		default:
			break;
	}
}

//Function Number: 41
destroy_countdown_hud(param_00)
{
	level notify("kill_timer_flourish");
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.text))
	{
		param_00.text destroy();
	}

	if(isdefined(param_00.blur))
	{
		param_00.blur destroy();
	}

	if(isdefined(param_00.border))
	{
		param_00.border destroy();
	}

	param_00 destroy();
}

//Function Number: 42
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

//Function Number: 43
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

//Function Number: 44
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

//Function Number: 45
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

//Function Number: 46
fade_in(param_00,param_01)
{
	if(level.missionfailed)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0.3;
	}

	var_02 = get_optional_overlay(param_01);
	var_02 fadeovertime(param_00);
	var_02.alpha = 0;
	wait(param_00);
}

//Function Number: 47
get_optional_overlay(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "black";
	}

	return get_overlay(param_00);
}

//Function Number: 48
fade_out(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.3;
	}

	var_02 = get_optional_overlay(param_01);
	if(param_00 > 0)
	{
		var_02 fadeovertime(param_00);
	}

	var_02.alpha = 1;
	wait(param_00);
}

//Function Number: 49
start_overlay(param_00)
{
	var_01 = get_optional_overlay(param_00);
	var_01.alpha = 1;
}

//Function Number: 50
get_overlay(param_00)
{
	if(isplayer(self))
	{
		var_01 = self;
	}
	else
	{
		var_01 = level.player;
	}

	if(!isdefined(var_01.overlay))
	{
		var_01.overlay = [];
	}

	if(!isdefined(var_01.overlay[param_00]))
	{
		var_01.overlay[param_00] = create_client_overlay(param_00,0,var_01);
	}

	var_01.overlay[param_00].sort = 0;
	var_01.overlay[param_00].foreground = 1;
	return var_01.overlay[param_00];
}

//Function Number: 51
display_custom_nameplate(param_00,param_01,param_02)
{
	if(!maps\_utility::ent_flag_exist("kill_custom_nameplate"))
	{
		maps\_utility::ent_flag_init("kill_custom_nameplate");
	}

	var_03 = undefined;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else if(isdefined(self.name))
	{
		var_03 = self.name;
	}

	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else if(isdefined(self.team))
	{
		var_04 = self.team;
	}

	var_05 = undefined;
	for(;;)
	{
		if(!isdefined(self) || maps\_utility::ent_flag("kill_custom_nameplate"))
		{
			if(isdefined(var_05))
			{
				var_05 destroy();
			}

			break;
		}

		if([[ param_00 ]]())
		{
			if(!isdefined(var_05))
			{
				var_05 = create_nameplate_hud(var_03,var_04);
			}
		}
		else if(isdefined(var_05))
		{
			var_05 destroy();
		}

		wait(0.05);
	}
}

//Function Number: 52
create_nameplate_hud(param_00,param_01)
{
	var_02 = 25;
	var_03 = -2;
	var_04 = newhudelem();
	var_04.alignx = "left";
	var_04.aligny = "bottom";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.x = var_02;
	var_04.y = var_03;
	var_04.fontscale = 1.2;
	var_04.font = "objective";
	var_04.label = param_00;
	var_05 = get_nameplate_color("hostileNameFontColor");
	var_06 = get_nameplate_color("hostileNameFontGlowColor");
	var_07 = get_nameplate_color("friendlyNameFontColor");
	var_08 = get_nameplate_color("friendlyNameFontGlowColor");
	if(param_01 == "axis")
	{
		var_04.color = (var_05[0],var_05[1],var_05[2]);
		var_04.alpha = var_05[3];
		var_04.glowcolor = (var_06[0],var_06[1],var_06[2]);
		var_04.glowalpha = var_06[3];
	}
	else
	{
		var_04.color = (var_07[0],var_07[1],var_07[2]);
		var_04.alpha = var_07[3];
		var_04.glowcolor = (var_08[0],var_08[1],var_08[2]);
		var_04.glowalpha = var_08[3];
	}

	var_04.foreground = 1;
	var_04.hidewheninmenu = 1;
	var_04.hidewhendead = 1;
	return var_04;
}

//Function Number: 53
get_nameplate_color(param_00)
{
	var_01 = strtok(getdvar(param_00)," ");
	var_02 = [];
	var_02 = common_scripts\utility::array_add(var_02,float(var_01[0]));
	var_02 = common_scripts\utility::array_add(var_02,float(var_01[1]));
	var_02 = common_scripts\utility::array_add(var_02,float(var_01[2]));
	var_02 = common_scripts\utility::array_add(var_02,float(var_01[3]));
	return var_02;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hud_util.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 42
 * Decompile Time: 684 ms
 * Timestamp: 10/27/2023 1:39:53 AM
*******************************************************************/

//Function Number: 1
func_708F(param_00)
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
		func_70A4(self.point,self.relativepoint,self.xoffset,self.yoffset);
		return;
	}

	func_70A4("TOPLEFT");
}

//Function Number: 2
getparent()
{
	return self.parent;
}

//Function Number: 3
func_6586()
{
	if(isdefined(self.childchecktime) && self.childchecktime == gettime())
	{
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
	func_6586();
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
func_70A4(param_00,param_01,param_02,param_03,param_04)
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
		var_08 = castint(var_07.width / 2);
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
		var_0A = castint(var_07.height / 2);
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
			func_70A5(param_00,param_01,param_02,param_03);
			break;
	}

	func_86D8(param_04);
}

//Function Number: 7
func_70A5(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x + self.var_8E6D;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width - self.var_8E6D;
	}
	else
	{
		self.bar.x = self.x - castint(self.width - self.var_8E6D * 2 / 2);
	}

	func_86CD(self.bar.frac);
}

//Function Number: 8
func_86CD(param_00)
{
	var_01 = castint(self.width - self.var_8E6D * 2 * param_00);
	if(!var_01)
	{
		var_01 = 1;
	}

	self.bar.frac = param_00;
	self.bar setmaterial(self.bar.shader,var_01,self.height - self.var_8E9B * 2);
}

//Function Number: 9
func_4200(param_00)
{
	param_00 = common_scripts\utility::func_803F(isdefined(param_00),param_00,1);
	if(param_00 || !isdefined(self.var_59E4) || !isdefined(self.bar.var_59E4))
	{
		self.var_59E4 = self.alpha;
		self.bar.var_59E4 = self.bar.alpha;
	}

	self.alpha = common_scripts\utility::func_803F(param_00,0,self.var_59E4);
	self.bar.alpha = common_scripts\utility::func_803F(param_00,0,self.bar.var_59E4);
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
	var_02.height = castint(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 func_708F(level.uiparent);
	return var_02;
}

//Function Number: 11
func_20D1(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.elemtype = "font";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = castint(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 func_708F(level.uiparent);
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
	var_02.height = castint(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 func_708F(level.uiparent);
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
	var_02.height = castint(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 func_708F(level.uiparent);
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
	var_02.height = castint(level.fontheight * param_01);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 func_708F(level.uiparent);
	return var_02;
}

//Function Number: 15
func_20FC(param_00,param_01,param_02)
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
	param_00 func_708F(level.uiparent);
	if(isdefined(param_01))
	{
		param_00 setmaterial(param_01,param_02,param_03);
	}

	return param_00;
}

//Function Number: 18
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
	var_05 setmaterial(param_00,param_02 - 2,param_03 - 2);
	if(isdefined(param_04))
	{
		var_05.flashfrac = param_04;
		var_05 thread func_3413();
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
	var_06.var_5AA3 = 2;
	var_06.sort = -2;
	var_06.alpha = 0.5;
	var_06 func_708F(level.uiparent);
	var_06 setmaterial(param_01,param_02,param_03);
	return var_06;
}

//Function Number: 19
createclientprogressbar(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	param_00 = common_scripts\utility::func_803F(isdefined(param_00),param_00,level.player);
	param_01 = common_scripts\utility::func_803F(isdefined(param_01),param_01,90);
	param_02 = common_scripts\utility::func_803F(isdefined(param_02),param_02,"white");
	param_03 = common_scripts\utility::func_803F(isdefined(param_03),param_03,"black");
	param_04 = common_scripts\utility::func_803F(isdefined(param_04),param_04,100);
	param_05 = common_scripts\utility::func_803F(isdefined(param_05),param_05,9);
	param_06 = common_scripts\utility::func_803F(isdefined(param_06),param_06,2);
	param_07 = common_scripts\utility::func_803F(isdefined(param_07),param_07,2);
	var_08 = param_00 func_20D0(param_02,param_03,param_04,param_05,undefined,param_06,param_07);
	var_08 func_70A4("CENTER",undefined,0,param_01);
	return var_08;
}

//Function Number: 20
func_20D0(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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
	var_07 setmaterial(param_00,param_02 - param_05 * 2,param_03 - param_06 * 2);
	if(isdefined(param_04))
	{
		var_07.flashfrac = param_04;
		var_07 thread func_3413();
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
	var_08.var_8E6D = param_05;
	var_08.var_8E9B = param_06;
	var_08.sort = -2;
	var_08.alpha = 0.5;
	var_08 func_708F(level.uiparent);
	var_08 setmaterial(param_01,param_02,param_03);
	return var_08;
}

//Function Number: 21
func_7037(param_00)
{
	self.bar.flashfrac = param_00;
}

//Function Number: 22
func_3147(param_00,param_01)
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

//Function Number: 23
func_3413()
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

//Function Number: 24
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
			var_00[var_01] func_708F(getparent());
		}
	}

	if(isdefined(self.elemtype) && self.elemtype == "bar")
	{
		self.bar destroy();
	}

	self destroy();
}

//Function Number: 25
seticonshader(param_00)
{
	self setmaterial(param_00,self.width,self.height);
}

//Function Number: 26
func_721A(param_00)
{
	self.width = param_00;
}

//Function Number: 27
func_704C(param_00)
{
	self.height = param_00;
}

//Function Number: 28
setsize(param_00,param_01)
{
	self.width = param_00;
	self.height = param_01;
}

//Function Number: 29
func_86D8(param_00)
{
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		var_02 = self.children[var_01];
		var_02 func_70A4(var_02.point,var_02.relativepoint,var_02.xoffset,var_02.yoffset,param_00);
	}
}

//Function Number: 30
func_79BE(param_00)
{
	if(isdefined(param_00) && param_00 == 0)
	{
		func_79BD();
	}

	if(isdefined(level.var_79BC))
	{
		level.var_79BC destroy();
	}

	function_0168("hud_showStance","0");
	level.var_79BC = newhudelem();
	level.var_79BC.x = -75;
	if(level.console)
	{
		level.var_79BC.y = -20;
	}
	else
	{
		level.var_79BC.y = -10;
	}

	level.var_79BC setmaterial("stance_carry",64,64);
	level.var_79BC.alignx = "right";
	level.var_79BC.aligny = "bottom";
	level.var_79BC.horzalign = "right";
	level.var_79BC.vertalign = "bottom";
	level.var_79BC.foreground = 1;
	level.var_79BC.alpha = 0;
	level.var_79BC fadeovertime(0.5);
	level.var_79BC.alpha = 1;
}

//Function Number: 31
func_79BD()
{
	if(isdefined(level.var_79BC))
	{
		level.var_79BC fadeovertime(0.5);
		level.var_79BC.alpha = 0;
		level.var_79BC destroy();
	}

	function_0168("hud_showStance","1");
}

//Function Number: 32
create_mantle()
{
	if(level.console)
	{
		var_00 = createfontstring("default",1.8);
		var_00 func_70A4("CENTER",undefined,-23,115);
		var_00 settext(level.var_7CE8["mantle"]);
		var_01 = func_20FC("hint_mantle",40,40);
		var_01 func_70A4("CENTER",undefined,73,0);
		var_01 func_708F(var_00);
	}
	else
	{
		var_00 = createfontstring("default",1.6);
		var_01 func_70A4("CENTER",undefined,0,115);
		var_01 settext(level.var_7CE8["mantle"]);
		var_01 = func_20FC("hint_mantle",40,40);
		var_01 func_70A4("CENTER",undefined,0,30);
		var_01 func_708F(var_00);
	}

	var_01.alpha = 0;
	var_00.alpha = 0;
	level.hud_mantle = [];
	level.hud_mantle["text"] = var_00;
	level.hud_mantle["icon"] = var_01;
}

//Function Number: 33
func_3827(param_00,param_01,param_02,param_03)
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

//Function Number: 34
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

//Function Number: 35
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
	var_03 setmaterial(param_00,640,480);
	var_03.alignx = "left";
	var_03.aligny = "top";
	var_03.sort = 1;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_01;
	var_03.foreground = 1;
	return var_03;
}

//Function Number: 36
create_client_overlay_custom_size(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::func_3942();
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
	var_06 setmaterial(param_00,castint(640 * param_04),castint(480 * param_04));
	var_06.alignx = "center";
	var_06.aligny = "middle";
	var_06.sort = 1;
	var_06.horzalign = "center";
	var_06.vertalign = "middle";
	var_06.alpha = param_01;
	var_06.foreground = 1;
	return var_06;
}

//Function Number: 37
func_206D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::func_3942();
	var_06 = newclienthudelem(var_05);
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_06.x = param_02;
	var_06.y = param_03;
	var_06 setmaterial(param_00,castint(640 * param_04),castint(480 * param_04));
	var_06.alignx = "center";
	var_06.aligny = "middle";
	var_06.sort = 1;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = param_01;
	var_06.foreground = 1;
	return var_06;
}

//Function Number: 38
func_3131(param_00,param_01)
{
	if(level.var_52F1)
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 0.3;
	}

	var_02 = func_3920(param_01);
	var_02 fadeovertime(param_00);
	var_02.alpha = 0;
	wait(param_00);
}

//Function Number: 39
func_3920(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "black";
	}

	return func_392C(param_00);
}

//Function Number: 40
fade_out(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.3;
	}

	var_02 = func_3920(param_01);
	if(param_00 > 0)
	{
		var_02 fadeovertime(param_00);
	}

	var_02.alpha = 1;
	wait(param_00);
}

//Function Number: 41
func_7A75(param_00)
{
	var_01 = func_3920(param_00);
	var_01.alpha = 1;
}

//Function Number: 42
func_392C(param_00)
{
	if(isplayer(self))
	{
		var_01 = self;
	}
	else
	{
		var_01 = level.player;
	}

	if(!isdefined(var_01.var_5A6F))
	{
		var_01.var_5A6F = [];
	}

	if(!isdefined(var_01.var_5A6F[param_00]))
	{
		var_01.var_5A6F[param_00] = create_client_overlay(param_00,0,var_01);
	}

	var_01.var_5A6F[param_00].sort = 0;
	var_01.var_5A6F[param_00].foreground = 1;
	return var_01.var_5A6F[param_00];
}
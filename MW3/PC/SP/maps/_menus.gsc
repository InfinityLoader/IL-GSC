/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_menus.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 552 ms
 * Timestamp: 10/27/2023 2:20:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachemenu("uiScript_startMultiplayer");
	precacheshader("black");
	precacheshader("white");
	precacheshader("menu_button");
	precacheshader("menu_button_selected");
	precacheshader("menu_button_fade");
	precacheshader("menu_button_fade_selected");
	precacheshader("menu_button_faderight");
	precacheshader("menu_button_faderight_selected");
	precacheshader("menu_caret_open");
	precacheshader("menu_caret_closed");
	thread initthumbsticklayout();
	thread initbuttonlayout();
	thread initsensitivity();
	thread initinversion();
	thread initautoaim();
	thread initvibration();
	level.menustack = [];
	var_00 = createmenu("levels");
	var_01 = setupaction(::loadmap,"cqb_1");
	var_02 = spawnstruct();
	var_02.display = &"MENU_1ST_PASS";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_CQB_TEST",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"descent");
	var_02 = spawnstruct();
	var_02.display = &"MENU_1ST_PASS";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_BUNKER",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"aftermath");
	var_02 = spawnstruct();
	var_02.display = &"MENU_100_INITIAL_GEO";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_AFTERMATH",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"chechnya_escape");
	var_02 = spawnstruct();
	var_02.display = &"MENU_40_INITIAL_GEO";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_CHECHNYA_ESCAPE",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"marksman");
	var_02 = spawnstruct();
	var_02.display = &"MENU_25_SCRIPTED";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_MARKSMAN",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"seaknight_defend");
	var_02 = spawnstruct();
	var_02.display = &"MENU_PROTOTYPE_LEVEL_30_SCRIPTED";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_SEAKNIGHT_DEFEND",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"wetwork");
	var_02 = spawnstruct();
	var_02.display = &"MENU_100_INITIAL_GEO";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_WETWORK",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"cargoship");
	var_02 = spawnstruct();
	var_02.display = &"MENU_10_SCRIPTED";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_CARGOSHIP",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"bog");
	var_02 = spawnstruct();
	var_02.display = &"MENU_35_INITIAL_GEO";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_BOG",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"training");
	var_02 = spawnstruct();
	var_02.display = &"MENU_5_SCRIPTED";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_TRAINING1",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"ac130");
	var_02 = spawnstruct();
	var_02.display = &"MENU_30";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_AC130",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"seaknight_assault");
	var_02 = spawnstruct();
	var_02.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_SEAKNIGHT_ASSAULT",var_01,"loadmap",var_02);
	var_01 = setupaction(::loadmap,"pilotcobra");
	var_02 = spawnstruct();
	var_02.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
	var_02.xpos = 240;
	var_02.ypos = 100;
	var_00 additem(&"MENU_PILOT_COBRA",var_01,"loadmap",var_02);
	var_03 = createmenu_controls("controls");
	var_04 = spawnstruct();
	var_04.index = 0;
	var_04.dvar = "controls_sticksConfig";
	var_04.value[0] = "thumbstick_default";
	var_04.value[1] = "thumbstick_southpaw";
	var_04.value[2] = "thumbstick_legacy";
	var_04.value[3] = "thumbstick_legacysouthpaw";
	var_04.display[0] = "Default";
	var_04.display[1] = "Southpaw";
	var_04.display[2] = "Legacy";
	var_04.display[3] = "Legacy Southpaw";
	var_03 additemsetting(&"MENU_THUMBSTICK_LAYOUT",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 0;
	var_04.dvar = "controls_buttonConfig";
	var_04.value[0] = "buttons_default";
	var_04.value[1] = "buttons_tactical";
	var_04.value[2] = "buttons_lefty";
	var_04.value[3] = "buttons_finesthour";
	var_04.display[0] = "Default";
	var_04.display[1] = "Tactical";
	var_04.display[2] = "Lefty";
	var_04.display[3] = "Finest Hour";
	var_03 additemsetting(&"MENU_BUTTON_LAYOUT",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 1;
	var_04.dvar = "controls_sensitivityConfig";
	var_04.value[0] = "sensitivity_low";
	var_04.value[1] = "sensitivity_medium";
	var_04.value[2] = "sensitivity_high";
	var_04.value[3] = "sensitivity_veryhigh";
	var_04.display[0] = "Low";
	var_04.display[1] = "Medium";
	var_04.display[2] = "High";
	var_04.display[3] = "Very High";
	var_03 additemsetting(&"MENU_LOOK_SENSITIVITY",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 0;
	var_04.dvar = "controls_inversionConfig";
	var_04.value[0] = "inversion_disabled";
	var_04.value[1] = "inversion_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 additemsetting(&"MENU_LOOK_INVERSION",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 1;
	var_04.dvar = "controls_autoaimConfig";
	var_04.value[0] = "autoaim_disabled";
	var_04.value[1] = "autoaim_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 additemsetting(&"MENU_AUTOAIM",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 1;
	var_04.dvar = "controls_vibrationConfig";
	var_04.value[0] = "vibration_disabled";
	var_04.value[1] = "vibration_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 additemsetting(&"MENU_CONTROLLER_VIBRATION",undefined,undefined,undefined,var_04);
	var_05 = createmenu("main");
	var_01 = setupaction(::pushmenu,var_00);
	var_05 additem(&"MENU_SELECT_LEVEL",var_01,"openmenu_levels");
	var_06 = var_05 addsubmenu("options",&"MENU_OPTIONS");
	var_01 = setupaction(::pushmenu,var_03);
	var_06 additem(&"MENU_CONTROLS",var_01);
	var_06 additem(&"MENU_SUBTITLES");
	var_06 additem(&"MENU_SAVE_DEVICE");
	var_05 additem(&"MENU_CREDITS");
	var_01 = setupaction(::loadmultiplayer);
	var_05 additem(&"MENU_MULTIPLAYER",var_01);
	pushmenu(var_05);
	level.player thread menuresponse();
}

//Function Number: 2
void()
{
}

//Function Number: 3
loadmap(param_00)
{
	changelevel(param_00);
}

//Function Number: 4
loadmultiplayer()
{
	level.player openpopupmenu("uiScript_startMultiplayer");
}

//Function Number: 5
pushmenu(param_00)
{
	level.menustack[level.menustack.size] = param_00;
	var_01 = level.curmenu;
	level.curmenu = param_00;
	if(param_00.menutype == "fullScreen")
	{
		if(isdefined(var_01))
		{
			var_01 thread hidemenu(0.2,1);
		}

		param_00 thread showmenu(0.2,1);
		level notify("open_menu",level.curmenu.name);
	}
	else
	{
		param_00 thread expandmenu(0.2);
	}

	level.player playsound("mouse_click");
}

//Function Number: 6
popmenu()
{
	if(level.menustack.size == 1)
	{
		return;
	}

	level.menustack[level.menustack.size - 1] = undefined;
	var_00 = level.curmenu;
	level.curmenu = level.menustack[level.menustack.size - 1];
	if(var_00.menutype == "subMenu")
	{
		var_00 thread collapsemenu(0.2);
		level.curmenu updatemenu(0.2,1);
	}
	else
	{
		var_00 thread hidemenu(0.2,0);
		level.curmenu thread showmenu(0.2,0);
		level notify("close_menu",level.menustack.size);
	}

	level.player playsound("mouse_click");
}

//Function Number: 7
createmenu(param_00)
{
	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.menutype = "fullScreen";
	var_01.itemdefs = [];
	var_01.itemwidth = 120;
	var_01.itemheight = 20;
	var_01.itempadding = 0;
	var_01.selectedindex = 0;
	var_01.xpos = 80;
	var_01.ypos = 100;
	var_01.xoffset = 0;
	var_01.yoffset = 0;
	return var_01;
}

//Function Number: 8
createmenu_controls(param_00)
{
	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.menutype = "fullScreen";
	var_01.itemdefs = [];
	var_01.itemwidth = 420;
	var_01.itemheight = 20;
	var_01.itempadding = 0;
	var_01.selectedindex = 0;
	var_01.xpos = 80;
	var_01.ypos = 100;
	var_01.xoffset = 0;
	var_01.yoffset = 0;
	return var_01;
}

//Function Number: 9
createsubmenu(param_00)
{
	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.menutype = "subMenu";
	var_01.itemdefs = [];
	var_01.itemwidth = 120;
	var_01.itemheight = 20;
	var_01.itempadding = 0;
	var_01.selectedindex = 0;
	var_01.isexpanded = 0;
	return var_01;
}

//Function Number: 10
additem(param_00,param_01,param_02,param_03)
{
	precachestring(param_00);
	var_04 = spawnstruct();
	var_04.itemtype = "item";
	var_04.bgshader = "menu_button_selected";
	var_04.fgtext = param_00;
	var_04.xpos = 0;
	var_04.ypos = 0;
	var_04.xoffset = 0;
	var_04.yoffset = 0;
	var_04.action = param_01;
	var_04.event = param_02;
	var_04.description = param_03;
	var_04.parentdef = self;
	var_04.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_04;
}

//Function Number: 11
additemsetting(param_00,param_01,param_02,param_03,param_04)
{
	precachestring(param_00);
	var_05 = spawnstruct();
	var_05.itemtype = "settingMenu";
	var_05.bgshader = "menu_button_selected";
	var_05.fgtext = param_00;
	var_05.xpos = 0;
	var_05.ypos = 0;
	var_05.xoffset = 0;
	var_05.yoffset = 0;
	var_05.action = param_01;
	var_05.event = param_02;
	var_05.description = param_03;
	var_05.setting = param_04;
	var_05.parentdef = self;
	var_05.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_05;
}

//Function Number: 12
addsubmenu(param_00,param_01)
{
	var_02 = createsubmenu(param_00);
	var_02.itemtype = "subMenu";
	var_02.bgshader = "menu_button_selected";
	var_02.fgtext = param_01;
	var_02.xpos = 0;
	var_02.ypos = 0;
	var_02.xoffset = 20;
	var_02.yoffset = self.itemheight + self.itempadding;
	var_02.parentdef = self;
	var_02.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_02;
	return var_02;
}

//Function Number: 13
createitemelems()
{
	self.bgicon = maps\_hud_util::createicon(self.bgshader,self.parentdef.itemwidth,self.parentdef.itemheight);
	self.bgicon.alpha = 0;
	self.bgicon.sort = 0;
	self.fontstring = maps\_hud_util::createfontstring("default",1.5);
	self.fontstring.alpha = 0;
	self.fontstring.sort = 100;
	self.fontstring settext(self.fgtext);
	if(self.itemtype == "settingMenu")
	{
		self.settingvalue = maps\_hud_util::createfontstring("default",1.5);
		self.settingvalue.alpha = 0;
		self.settingvalue.sort = 100;
		updatedisplayvalue();
	}

	if(self.itemtype == "subMenu")
	{
		self.careticon = maps\_hud_util::createicon("menu_caret_closed",self.parentdef.itemheight,self.parentdef.itemheight);
		self.careticon.alpha = 0;
		self.careticon.sort = 100;
	}

	if(isdefined(self.description))
	{
		self.descriptionvalue = maps\_hud_util::createfontstring("default",1.5);
		self.descriptionvalue.alpha = 0;
		self.descriptionvalue.sort = 100;
		self.descriptionvalue settext(self.description.display);
	}
}

//Function Number: 14
destroyitemelems()
{
	if(self.itemtype == "subMenu")
	{
		self.careticon maps\_hud_util::destroyelem();
	}

	if(self.itemtype == "settingMenu")
	{
		self.settingvalue maps\_hud_util::destroyelem();
	}

	if(isdefined(self.descriptionvalue))
	{
		self.descriptionvalue maps\_hud_util::destroyelem();
	}

	self.bgicon maps\_hud_util::destroyelem();
	self.fontstring maps\_hud_util::destroyelem();
}

//Function Number: 15
setelempoints(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 3;
	self.bgicon maps\_hud_util::setpoint(param_00,param_01,param_02,param_03,param_04);
	if(self.itemtype == "subMenu")
	{
		self.careticon maps\_hud_util::setpoint(param_00,param_01,param_02,param_03,param_04);
		var_05 = var_05 + 16;
	}

	if(self.itemtype == "settingMenu")
	{
		self.settingvalue maps\_hud_util::setpoint("TOPRIGHT",param_01,param_02 + var_05 + 400,param_03,param_04);
	}

	if(isdefined(self.descriptionvalue))
	{
		self.descriptionvalue maps\_hud_util::setpoint("TOPLEFT",param_01,self.description.xpos,self.description.ypos,param_04);
	}

	self.fontstring maps\_hud_util::setpoint(param_00,param_01,param_02 + var_05,param_03,param_04);
}

//Function Number: 16
showmenu(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_03 < self.itemdefs.size;var_03++)
	{
		var_04 = self.itemdefs[var_03];
		var_04 createitemelems();
		if(param_01)
		{
			var_04 setelempoints("TOPLEFT","TOPRIGHT",self.xpos,self.ypos + var_02);
		}
		else
		{
			var_04 setelempoints("TOPRIGHT","TOPLEFT",self.xpos,self.ypos + var_02);
		}

		var_04.xpos = self.xpos;
		var_04.ypos = self.ypos + var_02;
		var_02 = var_02 + self.itemheight + self.itempadding;
		if(var_04.itemtype == "subMenu" && var_04.isexpanded)
		{
			var_02 = var_02 + var_04 getmenuheight();
		}
	}

	if(self.menutype == "subMenu")
	{
		self.parentdef showmenu(param_00,param_01);
	}

	updatemenu(param_00,1);
}

//Function Number: 17
hidemenu(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_03 < self.itemdefs.size;var_03++)
	{
		var_04 = self.itemdefs[var_03];
		var_05 = -1 * self.itemwidth;
		if(param_01)
		{
			var_04 setelempoints("TOPRIGHT","TOPLEFT",self.xpos,self.ypos + var_02,param_00);
			var_04.bgicon fadeovertime(param_00);
			var_04.bgicon.alpha = 0;
			var_04.fontstring fadeovertime(param_00);
			var_04.fontstring.alpha = 0;
			if(var_04.itemtype == "settingMenu")
			{
				var_04.settingvalue fadeovertime(param_00);
				var_04.settingvalue.alpha = 0;
			}

			if(var_04.itemtype == "subMenu")
			{
				var_04.careticon fadeovertime(param_00);
				var_04.careticon.alpha = 0;
			}
		}
		else
		{
			var_04 setelempoints("TOPLEFT","TOPRIGHT",self.xpos,self.ypos + var_02,param_00);
			var_04.bgicon fadeovertime(param_00);
			var_04.bgicon.alpha = 0;
			var_04.fontstring fadeovertime(param_00);
			var_04.fontstring.alpha = 0;
			if(var_04.itemtype == "settingMenu")
			{
				var_04.settingvalue fadeovertime(param_00);
				var_04.settingvalue.alpha = 0;
			}

			if(var_04.itemtype == "subMenu")
			{
				var_04.careticon fadeovertime(param_00);
				var_04.careticon.alpha = 0;
			}
		}

		var_04.xpos = self.xpos;
		var_04.ypos = self.ypos + var_02;
		var_02 = var_02 + self.itemheight + self.itempadding;
		if(var_04.itemtype == "subMenu" && var_04.isexpanded)
		{
			var_02 = var_02 + var_04 getmenuheight();
		}
	}

	if(self.menutype == "subMenu")
	{
		self.parentdef thread hidemenu(param_00,param_01);
	}

	wait param_00;
	for(var_03 = 0;var_03 < self.itemdefs.size;var_03++)
	{
		var_04 = self.itemdefs[var_03];
		var_04 destroyitemelems();
	}
}

//Function Number: 18
collapsemenu(param_00)
{
	self.isexpanded = 0;
	self.careticon setshader("menu_caret_closed",self.parentdef.itemheight,self.parentdef.itemheight);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.itemdefs.size;var_02++)
	{
		var_03 = self.itemdefs[var_02];
		var_03 setelempoints("TOPLEFT","TOPLEFT",self.xpos,self.ypos,param_00);
		var_03.bgicon fadeovertime(param_00);
		var_03.bgicon.alpha = 0;
		var_03.fontstring fadeovertime(param_00);
		var_03.fontstring.alpha = 0;
		if(var_03.itemtype == "subMenu")
		{
			var_03.careticon fadeovertime(param_00);
			var_03.careticon.alpha = 0;
		}

		var_03.xpos = self.xpos;
		var_03.ypos = self.ypos;
	}

	wait param_00;
	for(var_02 = 0;var_02 < self.itemdefs.size;var_02++)
	{
		var_03 = self.itemdefs[var_02];
		var_03.bgicon maps\_hud_util::destroyelem();
		var_03.fontstring maps\_hud_util::destroyelem();
		if(var_03.itemtype == "subMenu")
		{
			var_03.careticon maps\_hud_util::destroyelem();
		}
	}
}

//Function Number: 19
expandmenu(param_00)
{
	self.isexpanded = 1;
	self.careticon setshader("menu_caret_open",self.parentdef.itemheight,self.parentdef.itemheight);
	for(var_01 = 0;var_01 < self.itemdefs.size;var_01++)
	{
		var_02 = self.itemdefs[var_01];
		var_02 createitemelems();
		var_02 setelempoints("TOPLEFT","TOPLEFT",self.xpos + self.xoffset,self.ypos + self.yoffset);
		var_02.xpos = self.xpos + self.xoffset;
		var_02.ypos = self.ypos + self.yoffset;
	}

	updatemenu(param_00,1);
}

//Function Number: 20
updatemenu(param_00,param_01)
{
	var_02 = self.xoffset;
	var_03 = self.yoffset;
	for(var_04 = 0;var_04 < self.itemdefs.size;var_04++)
	{
		var_05 = self.itemdefs[var_04];
		var_05 setselected(param_00,var_04 == self.selectedindex);
		var_06 = var_05.xpos;
		var_07 = var_05.ypos;
		if(param_01 || self.xpos + var_02 != var_06 || self.ypos + var_03 != var_07)
		{
			var_05 setelempoints("TOPLEFT","TOPLEFT",self.xpos + var_02,self.ypos + var_03,param_00);
			var_05.xpos = self.xpos + var_02;
			var_05.ypos = self.ypos + var_03;
		}

		var_03 = var_03 + self.itemheight + self.itempadding;
		if(var_05.itemtype == "subMenu" && var_05.isexpanded)
		{
			var_03 = var_03 + var_05 getmenuheight();
		}
	}

	if(isdefined(self.parentdef))
	{
		self.parentdef thread updatemenu(param_00,param_01);
	}
}

//Function Number: 21
setselected(param_00,param_01)
{
	self.bgicon fadeovertime(param_00);
	self.fontstring fadeovertime(param_00);
	if(isdefined(self.settingvalue))
	{
		self.settingvalue fadeovertime(param_00);
	}

	if(isdefined(self.descriptionvalue))
	{
		self.descriptionvalue fadeovertime(param_00);
	}

	if(param_01)
	{
		if(self.parentdef == level.curmenu)
		{
			setelemalpha(1);
		}
		else
		{
			setelemalpha(0.5);
		}

		if(isdefined(self.descriptionvalue))
		{
			self.descriptionvalue.alpha = 1;
			return;
		}

		return;
	}

	if(self.parentdef == level.curmenu)
	{
		setelemalpha(0.5);
	}
	else
	{
		setelemalpha(0.25);
	}

	if(isdefined(self.descriptionvalue))
	{
		self.descriptionvalue.alpha = 0;
	}
}

//Function Number: 22
setelemalpha(param_00)
{
	self.bgicon.alpha = param_00;
	self.fontstring.alpha = param_00;
	if(self.itemtype == "settingMenu")
	{
		self.settingvalue.alpha = param_00;
	}

	if(self.itemtype == "subMenu")
	{
		self.careticon.alpha = param_00;
	}
}

//Function Number: 23
setelemcolor(param_00)
{
	self.fontstring.color = param_00;
}

//Function Number: 24
getmenuheight()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < self.itemdefs.size;var_01++)
	{
		var_02 = self.itemdefs[var_01];
		var_00 = var_00 + self.itemheight + self.itempadding;
		if(var_02.itemtype == "subMenu" && var_02.isexpanded)
		{
			var_00 = var_00 + var_02 getmenuheight();
		}
	}

	return var_00;
}

//Function Number: 25
ondpadup()
{
	self.selectedindex--;
	if(self.selectedindex < 0)
	{
		self.selectedindex = self.itemdefs.size - 1;
	}

	updatemenu(0.1,0);
	level.player playsound("mouse_over");
}

//Function Number: 26
ondpaddown()
{
	self.selectedindex++;
	if(self.selectedindex >= self.itemdefs.size)
	{
		self.selectedindex = 0;
	}

	updatemenu(0.1,0);
	level.player playsound("mouse_over");
}

//Function Number: 27
onbuttonb()
{
	popmenu();
}

//Function Number: 28
onbuttona()
{
	var_00 = self.itemdefs[self.selectedindex];
	if(var_00.itemtype == "subMenu")
	{
		pushmenu(var_00);
		return;
	}

	if(var_00.itemtype == "item")
	{
		var_00 thread runaction();
	}
}

//Function Number: 29
ondpadleft()
{
	var_00 = self.itemdefs[self.selectedindex];
	if(var_00.itemtype == "settingMenu")
	{
		var_01 = getdvar(var_00.setting.dvar);
		var_02 = var_00.setting.value;
		var_03 = 0;
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			var_05 = var_02[var_04];
			if(var_05 != var_01)
			{
				continue;
			}

			var_03 = var_04 - 1;
			if(var_03 >= 0)
			{
				var_00.setting.index = var_03;
				setdvar(var_00.setting.dvar,var_02[var_03]);
				var_00 updatedisplayvalue();
				level.player playsound("mouse_over");
			}

			break;
		}
	}
}

//Function Number: 30
ondpadright()
{
	var_00 = self.itemdefs[self.selectedindex];
	if(var_00.itemtype == "settingMenu")
	{
		var_01 = getdvar(var_00.setting.dvar);
		var_02 = var_00.setting.value;
		var_03 = 0;
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			var_05 = var_02[var_04];
			if(var_05 != var_01)
			{
				continue;
			}

			var_03 = var_04 + 1;
			if(var_03 <= var_00.setting.value.size - 1)
			{
				var_00.setting.index = var_03;
				setdvar(var_00.setting.dvar,var_02[var_03]);
				var_00 updatedisplayvalue();
				level.player playsound("mouse_over");
			}

			break;
		}
	}
}

//Function Number: 31
initthumbsticklayout()
{
	setdvar("controls_sticksConfig","thumbstick_default");
}

//Function Number: 32
initbuttonlayout()
{
	setdvar("controls_buttonConfig","buttons_default");
}

//Function Number: 33
initsensitivity()
{
	setdvar("controls_sensitivityConfig","sensitivity_medium");
}

//Function Number: 34
initinversion()
{
	setdvar("controls_inversionConfig","inversion_disabled");
}

//Function Number: 35
initautoaim()
{
	setdvar("controls_autoaimConfig","autoaim_enabled");
}

//Function Number: 36
initvibration()
{
	setdvar("controls_vibrationConfig","vibration_enabled");
}

//Function Number: 37
updatedisplayvalue()
{
	self.settingvalue settext(self.setting.display[self.setting.index]);
}

//Function Number: 38
setupaction(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.name = param_00;
	if(isdefined(param_01))
	{
		var_03.arg1 = param_01;
	}

	if(isdefined(param_02))
	{
		var_03.arg2 = param_02;
	}

	return var_03;
}

//Function Number: 39
runaction()
{
	if(isdefined(self.action))
	{
		if(isdefined(self.action.arg1))
		{
			thread [[ self.action.name ]](self.action.arg1);
		}
		else
		{
			thread [[ self.action.name ]]();
		}
	}

	if(isdefined(self.event))
	{
		level notify(self.event);
	}
}

//Function Number: 40
testaction()
{
	level.marine setgoalnode(getnode("node2","targetname"));
	level.camera attachpath(getvehiclenode("path2","targetname"));
	thread maps\_vehicle::gopath(level.camera);
}

//Function Number: 41
menuresponse()
{
	for(;;)
	{
		self waittill("menuresponse",var_00,var_01);
		switch(var_01)
		{
			case "DPAD_UP":
				level.curmenu ondpadup();
				break;
	
			case "DPAD_DOWN":
				level.curmenu ondpaddown();
				break;
	
			case "DPAD_LEFT":
				level.curmenu ondpadleft();
				break;
	
			case "DPAD_RIGHT":
				level.curmenu ondpadright();
				break;
	
			case "BUTTON_A":
				level.curmenu onbuttona();
				break;
	
			case "BUTTON_B":
				level.curmenu onbuttonb();
				break;
		}
	}
}
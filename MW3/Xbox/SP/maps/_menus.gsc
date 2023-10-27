/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_menus.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 41
 * Decompile Time: 623 ms
 * Timestamp: 10/27/2023 2:34:26 AM
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
	thread func_3C03();
	thread func_3C04();
	thread func_3C05();
	thread initvibration();
	level.menustack = [];
	var_00 = createmenu("levels");
	var_01 = setupaction(::func_3BD2,"cqb_1");
	var_02 = spawnstruct();
	var_02.display = &"MENU_1ST_PASS";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_CQB_TEST",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"descent");
	var_02 = spawnstruct();
	var_02.display = &"MENU_1ST_PASS";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_BUNKER",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"aftermath");
	var_02 = spawnstruct();
	var_02.display = &"MENU_100_INITIAL_GEO";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_AFTERMATH",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"chechnya_escape");
	var_02 = spawnstruct();
	var_02.display = &"MENU_40_INITIAL_GEO";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_CHECHNYA_ESCAPE",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"marksman");
	var_02 = spawnstruct();
	var_02.display = &"MENU_25_SCRIPTED";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_MARKSMAN",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"seaknight_defend");
	var_02 = spawnstruct();
	var_02.display = &"MENU_PROTOTYPE_LEVEL_30_SCRIPTED";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_SEAKNIGHT_DEFEND",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"wetwork");
	var_02 = spawnstruct();
	var_02.display = &"MENU_100_INITIAL_GEO";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_WETWORK",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"cargoship");
	var_02 = spawnstruct();
	var_02.display = &"MENU_10_SCRIPTED";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_CARGOSHIP",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"bog");
	var_02 = spawnstruct();
	var_02.display = &"MENU_35_INITIAL_GEO";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_BOG",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"training");
	var_02 = spawnstruct();
	var_02.display = &"MENU_5_SCRIPTED";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_TRAINING1",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"ac130");
	var_02 = spawnstruct();
	var_02.display = &"MENU_30";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_AC130",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"seaknight_assault");
	var_02 = spawnstruct();
	var_02.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_SEAKNIGHT_ASSAULT",var_01,"loadmap",var_02);
	var_01 = setupaction(::func_3BD2,"pilotcobra");
	var_02 = spawnstruct();
	var_02.display = &"MENU_INITIAL_GEO_IN_PROGRESS";
	var_02.var_3BD0 = 240;
	var_02.ypos = 100;
	var_00 func_3BE1(&"MENU_PILOT_COBRA",var_01,"loadmap",var_02);
	var_03 = func_3BDE("controls");
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
	var_03 func_3BE7(&"MENU_THUMBSTICK_LAYOUT",undefined,undefined,undefined,var_04);
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
	var_03 func_3BE7(&"MENU_BUTTON_LAYOUT",undefined,undefined,undefined,var_04);
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
	var_03 func_3BE7(&"MENU_LOOK_SENSITIVITY",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 0;
	var_04.dvar = "controls_inversionConfig";
	var_04.value[0] = "inversion_disabled";
	var_04.value[1] = "inversion_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 func_3BE7(&"MENU_LOOK_INVERSION",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 1;
	var_04.dvar = "controls_autoaimConfig";
	var_04.value[0] = "autoaim_disabled";
	var_04.value[1] = "autoaim_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 func_3BE7(&"MENU_AUTOAIM",undefined,undefined,undefined,var_04);
	var_04 = spawnstruct();
	var_04.index = 1;
	var_04.dvar = "controls_vibrationConfig";
	var_04.value[0] = "vibration_disabled";
	var_04.value[1] = "vibration_enabled";
	var_04.display[0] = "Disabled";
	var_04.display[1] = "Enabled";
	var_03 func_3BE7(&"MENU_CONTROLLER_VIBRATION",undefined,undefined,undefined,var_04);
	var_05 = createmenu("main");
	var_01 = setupaction(::pushmenu,var_00);
	var_05 func_3BE1(&"MENU_SELECT_LEVEL",var_01,"openmenu_levels");
	var_06 = var_05 func_3BE9("options",&"MENU_OPTIONS");
	var_01 = setupaction(::pushmenu,var_03);
	var_06 func_3BE1(&"MENU_CONTROLS",var_01);
	var_06 func_3BE1(&"MENU_SUBTITLES");
	var_06 func_3BE1(&"MENU_SAVE_DEVICE");
	var_05 func_3BE1(&"MENU_CREDITS");
	var_01 = setupaction(::loadmultiplayer);
	var_05 func_3BE1(&"MENU_MULTIPLAYER",var_01);
	pushmenu(var_05);
	level.player thread menuresponse();
}

//Function Number: 2
void()
{
}

//Function Number: 3
func_3BD2(param_00)
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
	var_01 = level.var_3BD5;
	level.var_3BD5 = param_00;
	if(param_00.menutype == "fullScreen")
	{
		if(isdefined(var_01))
		{
			var_01 thread hidemenu(0.2,1);
		}

		param_00 thread showmenu(0.2,1);
		level notify("open_menu",level.var_3BD5.name);
	}
	else
	{
		param_00 thread expandmenu(0.2);
	}

	level.player playsound("mouse_click");
}

//Function Number: 6
func_3BD7()
{
	if(level.menustack.size == 1)
	{
		return;
	}

	level.menustack[level.menustack.size - 1] = undefined;
	var_00 = level.var_3BD5;
	level.var_3BD5 = level.menustack[level.menustack.size - 1];
	if(var_00.menutype == "subMenu")
	{
		var_00 thread collapsemenu(0.2);
		level.var_3BD5 func_3BF6(0.2,1);
	}
	else
	{
		var_00 thread hidemenu(0.2,0);
		level.var_3BD5 thread showmenu(0.2,0);
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
	var_01.var_3BDB = 20;
	var_01.var_3BDC = 0;
	var_01.var_3BDD = 0;
	var_01.var_3BD0 = 80;
	var_01.ypos = 100;
	var_01.xoffset = 0;
	var_01.yoffset = 0;
	return var_01;
}

//Function Number: 8
func_3BDE(param_00)
{
	var_01 = spawnstruct();
	var_01.name = param_00;
	var_01.menutype = "fullScreen";
	var_01.itemdefs = [];
	var_01.itemwidth = 420;
	var_01.var_3BDB = 20;
	var_01.var_3BDC = 0;
	var_01.var_3BDD = 0;
	var_01.var_3BD0 = 80;
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
	var_01.var_3BDB = 20;
	var_01.var_3BDC = 0;
	var_01.var_3BDD = 0;
	var_01.var_3BE0 = 0;
	return var_01;
}

//Function Number: 10
func_3BE1(param_00,param_01,param_02,param_03)
{
	precachestring(param_00);
	var_04 = spawnstruct();
	var_04.itemtype = "item";
	var_04.var_3BE3 = "menu_button_selected";
	var_04.var_3BE4 = param_00;
	var_04.var_3BD0 = 0;
	var_04.ypos = 0;
	var_04.xoffset = 0;
	var_04.yoffset = 0;
	var_04.action = param_01;
	var_04.event = param_02;
	var_04.var_16D0 = param_03;
	var_04.var_3BE6 = self;
	var_04.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_04;
}

//Function Number: 11
func_3BE7(param_00,param_01,param_02,param_03,param_04)
{
	precachestring(param_00);
	var_05 = spawnstruct();
	var_05.itemtype = "settingMenu";
	var_05.var_3BE3 = "menu_button_selected";
	var_05.var_3BE4 = param_00;
	var_05.var_3BD0 = 0;
	var_05.ypos = 0;
	var_05.xoffset = 0;
	var_05.yoffset = 0;
	var_05.action = param_01;
	var_05.event = param_02;
	var_05.var_16D0 = param_03;
	var_05.setting = param_04;
	var_05.var_3BE6 = self;
	var_05.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_05;
}

//Function Number: 12
func_3BE9(param_00,param_01)
{
	var_02 = createsubmenu(param_00);
	var_02.itemtype = "subMenu";
	var_02.var_3BE3 = "menu_button_selected";
	var_02.var_3BE4 = param_01;
	var_02.var_3BD0 = 0;
	var_02.ypos = 0;
	var_02.xoffset = 20;
	var_02.yoffset = self.var_3BDB + self.var_3BDC;
	var_02.var_3BE6 = self;
	var_02.index = self.itemdefs.size;
	self.itemdefs[self.itemdefs.size] = var_02;
	return var_02;
}

//Function Number: 13
createitemelems()
{
	self.bgicon = maps\_hud_util::createicon(self.var_3BE3,self.var_3BE6.itemwidth,self.var_3BE6.var_3BDB);
	self.bgicon.alpha = 0;
	self.bgicon.sort = 0;
	self.var_3BEC = maps\_hud_util::createfontstring("default",1.5);
	self.var_3BEC.alpha = 0;
	self.var_3BEC.sort = 100;
	self.var_3BEC settext(self.var_3BE4);
	if(self.itemtype == "settingMenu")
	{
		self.var_3BED = maps\_hud_util::createfontstring("default",1.5);
		self.var_3BED.alpha = 0;
		self.var_3BED.sort = 100;
		updatedisplayvalue();
	}

	if(self.itemtype == "subMenu")
	{
		self.var_3BEE = maps\_hud_util::createicon("menu_caret_closed",self.var_3BE6.var_3BDB,self.var_3BE6.var_3BDB);
		self.var_3BEE.alpha = 0;
		self.var_3BEE.sort = 100;
	}

	if(isdefined(self.var_16D0))
	{
		self.var_3BEF = maps\_hud_util::createfontstring("default",1.5);
		self.var_3BEF.alpha = 0;
		self.var_3BEF.sort = 100;
		self.var_3BEF settext(self.var_16D0.display);
	}
}

//Function Number: 14
destroyitemelems()
{
	if(self.itemtype == "subMenu")
	{
		self.var_3BEE maps\_hud_util::destroyelem();
	}

	if(self.itemtype == "settingMenu")
	{
		self.var_3BED maps\_hud_util::destroyelem();
	}

	if(isdefined(self.var_3BEF))
	{
		self.var_3BEF maps\_hud_util::destroyelem();
	}

	self.bgicon maps\_hud_util::destroyelem();
	self.var_3BEC maps\_hud_util::destroyelem();
}

//Function Number: 15
setelempoints(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 3;
	self.bgicon maps\_hud_util::setpoint(param_00,param_01,param_02,param_03,param_04);
	if(self.itemtype == "subMenu")
	{
		self.var_3BEE maps\_hud_util::setpoint(param_00,param_01,param_02,param_03,param_04);
		var_05 = var_05 + 16;
	}

	if(self.itemtype == "settingMenu")
	{
		self.var_3BED maps\_hud_util::setpoint("TOPRIGHT",param_01,param_02 + var_05 + 400,param_03,param_04);
	}

	if(isdefined(self.var_3BEF))
	{
		self.var_3BEF maps\_hud_util::setpoint("TOPLEFT",param_01,self.var_16D0.var_3BD0,self.var_16D0.ypos,param_04);
	}

	self.var_3BEC maps\_hud_util::setpoint(param_00,param_01,param_02 + var_05,param_03,param_04);
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
			var_04 setelempoints("TOPLEFT","TOPRIGHT",self.var_3BD0,self.ypos + var_02);
		}
		else
		{
			var_04 setelempoints("TOPRIGHT","TOPLEFT",self.var_3BD0,self.ypos + var_02);
		}

		var_04.var_3BD0 = self.var_3BD0;
		var_04.ypos = self.ypos + var_02;
		var_02 = var_02 + self.var_3BDB + self.var_3BDC;
		if(var_04.itemtype == "subMenu" && var_04.var_3BE0)
		{
			var_02 = var_02 + var_04 func_3BFA();
		}
	}

	if(self.menutype == "subMenu")
	{
		self.var_3BE6 showmenu(param_00,param_01);
	}

	func_3BF6(param_00,1);
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
			var_04 setelempoints("TOPRIGHT","TOPLEFT",self.var_3BD0,self.ypos + var_02,param_00);
			var_04.bgicon fadeovertime(param_00);
			var_04.bgicon.alpha = 0;
			var_04.var_3BEC fadeovertime(param_00);
			var_04.var_3BEC.alpha = 0;
			if(var_04.itemtype == "settingMenu")
			{
				var_04.var_3BED fadeovertime(param_00);
				var_04.var_3BED.alpha = 0;
			}

			if(var_04.itemtype == "subMenu")
			{
				var_04.var_3BEE fadeovertime(param_00);
				var_04.var_3BEE.alpha = 0;
			}
		}
		else
		{
			var_04 setelempoints("TOPLEFT","TOPRIGHT",self.var_3BD0,self.ypos + var_02,param_00);
			var_04.bgicon fadeovertime(param_00);
			var_04.bgicon.alpha = 0;
			var_04.var_3BEC fadeovertime(param_00);
			var_04.var_3BEC.alpha = 0;
			if(var_04.itemtype == "settingMenu")
			{
				var_04.var_3BED fadeovertime(param_00);
				var_04.var_3BED.alpha = 0;
			}

			if(var_04.itemtype == "subMenu")
			{
				var_04.var_3BEE fadeovertime(param_00);
				var_04.var_3BEE.alpha = 0;
			}
		}

		var_04.var_3BD0 = self.var_3BD0;
		var_04.ypos = self.ypos + var_02;
		var_02 = var_02 + self.var_3BDB + self.var_3BDC;
		if(var_04.itemtype == "subMenu" && var_04.var_3BE0)
		{
			var_02 = var_02 + var_04 func_3BFA();
		}
	}

	if(self.menutype == "subMenu")
	{
		self.var_3BE6 thread hidemenu(param_00,param_01);
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
	self.var_3BE0 = 0;
	self.var_3BEE setshader("menu_caret_closed",self.var_3BE6.var_3BDB,self.var_3BE6.var_3BDB);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.itemdefs.size;var_02++)
	{
		var_03 = self.itemdefs[var_02];
		var_03 setelempoints("TOPLEFT","TOPLEFT",self.var_3BD0,self.ypos,param_00);
		var_03.bgicon fadeovertime(param_00);
		var_03.bgicon.alpha = 0;
		var_03.var_3BEC fadeovertime(param_00);
		var_03.var_3BEC.alpha = 0;
		if(var_03.itemtype == "subMenu")
		{
			var_03.var_3BEE fadeovertime(param_00);
			var_03.var_3BEE.alpha = 0;
		}

		var_03.var_3BD0 = self.var_3BD0;
		var_03.ypos = self.ypos;
	}

	wait param_00;
	for(var_02 = 0;var_02 < self.itemdefs.size;var_02++)
	{
		var_03 = self.itemdefs[var_02];
		var_03.bgicon maps\_hud_util::destroyelem();
		var_03.var_3BEC maps\_hud_util::destroyelem();
		if(var_03.itemtype == "subMenu")
		{
			var_03.var_3BEE maps\_hud_util::destroyelem();
		}
	}
}

//Function Number: 19
expandmenu(param_00)
{
	self.var_3BE0 = 1;
	self.var_3BEE setshader("menu_caret_open",self.var_3BE6.var_3BDB,self.var_3BE6.var_3BDB);
	for(var_01 = 0;var_01 < self.itemdefs.size;var_01++)
	{
		var_02 = self.itemdefs[var_01];
		var_02 createitemelems();
		var_02 setelempoints("TOPLEFT","TOPLEFT",self.var_3BD0 + self.xoffset,self.ypos + self.yoffset);
		var_02.var_3BD0 = self.var_3BD0 + self.xoffset;
		var_02.ypos = self.ypos + self.yoffset;
	}

	func_3BF6(param_00,1);
}

//Function Number: 20
func_3BF6(param_00,param_01)
{
	var_02 = self.xoffset;
	var_03 = self.yoffset;
	for(var_04 = 0;var_04 < self.itemdefs.size;var_04++)
	{
		var_05 = self.itemdefs[var_04];
		var_05 setselected(param_00,var_04 == self.var_3BDD);
		var_06 = var_05.var_3BD0;
		var_07 = var_05.ypos;
		if(param_01 || self.var_3BD0 + var_02 != var_06 || self.ypos + var_03 != var_07)
		{
			var_05 setelempoints("TOPLEFT","TOPLEFT",self.var_3BD0 + var_02,self.ypos + var_03,param_00);
			var_05.var_3BD0 = self.var_3BD0 + var_02;
			var_05.ypos = self.ypos + var_03;
		}

		var_03 = var_03 + self.var_3BDB + self.var_3BDC;
		if(var_05.itemtype == "subMenu" && var_05.var_3BE0)
		{
			var_03 = var_03 + var_05 func_3BFA();
		}
	}

	if(isdefined(self.var_3BE6))
	{
		self.var_3BE6 thread func_3BF6(param_00,param_01);
	}
}

//Function Number: 21
setselected(param_00,param_01)
{
	self.bgicon fadeovertime(param_00);
	self.var_3BEC fadeovertime(param_00);
	if(isdefined(self.var_3BED))
	{
		self.var_3BED fadeovertime(param_00);
	}

	if(isdefined(self.var_3BEF))
	{
		self.var_3BEF fadeovertime(param_00);
	}

	if(param_01)
	{
		if(self.var_3BE6 == level.var_3BD5)
		{
			func_3BF8(1);
		}
		else
		{
			func_3BF8(0.5);
		}

		if(isdefined(self.var_3BEF))
		{
			self.var_3BEF.alpha = 1;
			return;
		}

		return;
	}

	if(self.var_3BE6 == level.var_3BD5)
	{
		func_3BF8(0.5);
	}
	else
	{
		func_3BF8(0.25);
	}

	if(isdefined(self.var_3BEF))
	{
		self.var_3BEF.alpha = 0;
	}
}

//Function Number: 22
func_3BF8(param_00)
{
	self.bgicon.alpha = param_00;
	self.var_3BEC.alpha = param_00;
	if(self.itemtype == "settingMenu")
	{
		self.var_3BED.alpha = param_00;
	}

	if(self.itemtype == "subMenu")
	{
		self.var_3BEE.alpha = param_00;
	}
}

//Function Number: 23
func_3BF9(param_00)
{
	self.var_3BEC.color = param_00;
}

//Function Number: 24
func_3BFA()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < self.itemdefs.size;var_01++)
	{
		var_02 = self.itemdefs[var_01];
		var_00 = var_00 + self.var_3BDB + self.var_3BDC;
		if(var_02.itemtype == "subMenu" && var_02.var_3BE0)
		{
			var_00 = var_00 + var_02 func_3BFA();
		}
	}

	return var_00;
}

//Function Number: 25
func_3BFB()
{
	self.var_3BDD--;
	if(self.var_3BDD < 0)
	{
		self.var_3BDD = self.itemdefs.size - 1;
	}

	func_3BF6(0.1,0);
	level.player playsound("mouse_over");
}

//Function Number: 26
func_3BFC()
{
	self.var_3BDD++;
	if(self.var_3BDD >= self.itemdefs.size)
	{
		self.var_3BDD = 0;
	}

	func_3BF6(0.1,0);
	level.player playsound("mouse_over");
}

//Function Number: 27
func_3BFD()
{
	func_3BD7();
}

//Function Number: 28
func_3BFE()
{
	var_00 = self.itemdefs[self.var_3BDD];
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
func_3BFF()
{
	var_00 = self.itemdefs[self.var_3BDD];
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
func_3C00()
{
	var_00 = self.itemdefs[self.var_3BDD];
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
func_3C03()
{
	setdvar("controls_sensitivityConfig","sensitivity_medium");
}

//Function Number: 34
func_3C04()
{
	setdvar("controls_inversionConfig","inversion_disabled");
}

//Function Number: 35
func_3C05()
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
	self.var_3BED settext(self.setting.display[self.setting.index]);
}

//Function Number: 38
setupaction(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.name = param_00;
	if(isdefined(param_01))
	{
		var_03.var_3C09 = param_01;
	}

	if(isdefined(param_02))
	{
		var_03.var_3C0A = param_02;
	}

	return var_03;
}

//Function Number: 39
runaction()
{
	if(isdefined(self.action))
	{
		if(isdefined(self.action.var_3C09))
		{
			thread [[ self.action.name ]](self.action.var_3C09);
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
	thread maps\_vehicle::func_1B44(level.camera);
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
				level.var_3BD5 func_3BFB();
				break;
	
			case "DPAD_DOWN":
				level.var_3BD5 func_3BFC();
				break;
	
			case "DPAD_LEFT":
				level.var_3BD5 func_3BFF();
				break;
	
			case "DPAD_RIGHT":
				level.var_3BD5 func_3C00();
				break;
	
			case "BUTTON_A":
				level.var_3BD5 func_3BFE();
				break;
	
			case "BUTTON_B":
				level.var_3BD5 func_3BFD();
				break;
		}
	}
}
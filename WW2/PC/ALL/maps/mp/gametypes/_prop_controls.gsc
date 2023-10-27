/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_prop_controls.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 57
 * Decompile Time: 976 ms
 * Timestamp: 10/27/2023 3:10:09 AM
*******************************************************************/

//Function Number: 1
setupkeybindings()
{
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommand("lock","+attack");
	self notifyonplayercommand("lock","+attack_akimbo_accessible");
	self notifyonplayercommand("changeProp","+weapnext");
	self notifyonplayercommand("setToSlope","+usereload");
	self notifyonplayercommand("setToSlope","+activate");
	self notifyonplayercommand("propAbility","+smoke");
	self notifyonplayercommand("cloneProp","+actionslot 2");
	self notifyonplayercommand("zoomin","+actionslot 3");
	self notifyonplayercommand("zoomout","+actionslot 4");
	thread cleanupkeybindingsondeath();
}

//Function Number: 2
cleanupkeybindingsondeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("cleanupKeyBindings");
	self waittill("death");
	thread cleanupkeybindings();
}

//Function Number: 3
cleanupkeybindings()
{
	self notify("cleanupKeyBindings");
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommandremove("lock","+attack");
	self notifyonplayercommandremove("lock","+attack_akimbo_accessible");
	self notifyonplayercommandremove("changeProp","+weapnext");
	self notifyonplayercommandremove("setToSlope","+usereload");
	self notifyonplayercommandremove("setToSlope","+activate");
	self notifyonplayercommandremove("propAbility","+smoke");
	self notifyonplayercommandremove("cloneProp","+frag");
	self notifyonplayercommandremove("zoomin","+actionslot 3");
	self notifyonplayercommandremove("zoomout","+actionslot 4");
}

//Function Number: 4
propcontrolshud()
{
	self.currenthudy = 26;
	self.changepropkey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_CHANGE",0);
	self.spinpropkey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_SPIN",undefined,undefined,&"MP_PH_SPIN_PC");
	self.lockpropkey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_LOCK");
	self.matchslopekey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_SLOPE",undefined,undefined,&"MP_PH_SLOPE_PC");
	self.abilitykey = maps/mp/gametypes/prop::addupperrighthudelem();
	self.clonekey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_CLONE");
	setnewabilityhud();
	self.zoomkey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_ZOOM");
	self.spectatekey = maps/mp/gametypes/prop::addupperrighthudelem(&"MP_PH_SPECKEY");
	thread updatetextongamepadchange();
}

//Function Number: 5
cleanuppropcontrolshudondeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("death");
	thread cleanupkeybindings();
	thread cleanuppropcontrolshud();
}

//Function Number: 6
safedestroy(param_00)
{
	if(isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 7
cleanuppropcontrolshud()
{
	self notify("cleanupPropControlsHUD");
	safedestroy(self.changepropkey);
	safedestroy(self.spinpropkey);
	safedestroy(self.lockpropkey);
	safedestroy(self.matchslopekey);
	safedestroy(self.abilitykey);
	safedestroy(self.zoomkey);
	safedestroy(self.spectatekey);
	safedestroy(self.clonekey);
}

//Function Number: 8
updatetextongamepadchange()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	if(level.var_258F)
	{
		return;
	}

	waittillframeend;
	var_00 = common_scripts\utility::func_55E0();
	for(;;)
	{
		var_01 = common_scripts\utility::func_55E0();
		if(var_01 != var_00)
		{
			var_00 = var_01;
			if(var_01)
			{
				if(!common_scripts\utility::func_562E(self.slopelocked))
				{
					self.matchslopekey.var_E5 = &"MP_PH_SLOPE";
				}
				else
				{
					self.matchslopekey.var_E5 = &"MP_PH_SLOPED";
				}
			}
			else if(!common_scripts\utility::func_562E(self.slopelocked))
			{
				self.matchslopekey.var_E5 = &"MP_PH_SLOPE_PC";
			}
			else
			{
				self.matchslopekey.var_E5 = &"MP_PH_SLOPED_PC";
			}
		}

		wait 0.05;
	}
}

//Function Number: 9
propinputwatch()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	self.var_5E61 = 0;
	self.slopelocked = 0;
	self setclientomnvar("ui_ph_is_locked",0);
	self setclientomnvar("ui_ph_matching_slope",0);
	maps\mp\_utility::func_3FA5("prematch_done");
	childthread propmoveunlock();
	childthread propcamerazoom();
	childthread proprotate();
	self.propspectating = 0;
	self.endingpropspecate = 0;
	self.debugnextpropindex = 1;
	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("lock","changeProp","setToSlope","propAbility","cloneProp");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(self.propspectating)
		{
			continue;
		}

		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_00 == "lock")
		{
			proplockunlock();
			continue;
		}

		if(var_00 == "changeProp")
		{
			propchange();
			continue;
		}

		if(var_00 == "setToSlope")
		{
			propmatchslope();
			continue;
		}

		if(var_00 == "propAbility")
		{
			propability();
			continue;
		}

		if(var_00 == "cloneProp")
		{
			propclonepower();
		}
	}
}

//Function Number: 10
proplockunlock()
{
	if(self method_82E4())
	{
		return;
	}

	if(self.var_5E61)
	{
		unlockprop();
		return;
	}

	lockprop();
}

//Function Number: 11
registerpreviousprop(param_00)
{
	var_01 = 3;
	if(!isdefined(param_00.usedpropsindex))
	{
		param_00.usedpropsindex = 0;
	}

	param_00.usedprops[param_00.usedpropsindex] = param_00.var_777D.var_5135;
	param_00.usedpropsindex++;
	if(param_00.usedpropsindex >= var_01)
	{
		param_00.usedpropsindex = 0;
	}
}

//Function Number: 12
propchange()
{
	if(!prophaschangesleft())
	{
		return;
	}

	if(common_scripts\utility::func_562E(level.var_122))
	{
		var_00 = 300;
		if(isdefined(self.lastpropchangetime) && gettime() - self.lastpropchangetime < var_00)
		{
			return;
		}

		self.lastpropchangetime = gettime();
	}

	self notify("changed_prop");
	registerpreviousprop(self);
	self.var_777D.var_5135 = maps/mp/gametypes/prop::getnextprop(self);
	propchangeto(self.var_777D.var_5135);
	self.var_FB = int(maps/mp/gametypes/prop::getprophealth(self.var_777D.var_5135));
	self setnormalhealth(1);
	setnewabilitycount(self.currentability);
	setnewabilitycount("CLONE");
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.abilitykey.var_18 = 1;
		self.clonekey.var_18 = 1;
	}

	propdeductchange();
}

//Function Number: 13
prophaschangesleft()
{
	return self.changesleft > 0;
}

//Function Number: 14
propdeductchange()
{
	propsetchangesleft(self.changesleft - 1);
}

//Function Number: 15
propsetchangesleft(param_00)
{
	self.changesleft = param_00;
	self setclientomnvar("ui_ph_num_changes_left",self.changesleft);
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.changepropkey setvalue(self.changesleft);
		if(self.changesleft <= 0)
		{
			self.changepropkey.var_18 = 0.5;
		}
	}
}

//Function Number: 16
propchangeto(param_00)
{
	self.var_777D setmodel(param_00.modelname);
	self.var_777D.xyzoffset = param_00.xyzoffset;
	self.var_777D.anglesoffset = param_00.anglesoffset;
	self.var_777D unlink();
	self.propent unlink();
	self.propent.var_116 = self.propanchor.var_116;
	self.var_777D.var_116 = self.propent.var_116;
	self.propent.var_1D = (self.var_1D[0],self.propent.var_1D[1],self.var_1D[2]);
	self.var_777D.var_1D = self.propent.var_1D;
	if(common_scripts\utility::func_562E(self.isangleoffset))
	{
		self.var_777D.var_1D = self.var_1D;
		self.isangleoffset = 0;
	}

	maps/mp/gametypes/prop::applyxyzoffset();
	maps/mp/gametypes/prop::applyanglesoffset();
	self.var_777D method_8449(self.propent,"J_prop_1");
	if(self.slopelocked && common_scripts\utility::func_562E(self.var_5E61))
	{
		self.propent set_pitch_roll_for_ground_normal(self.var_777D);
	}

	self.propent method_8449(self.propanchor);
	self.thirdpersonrange = maps/mp/gametypes/prop::getthirdpersonrangeforpropinfo(param_00);
	self.thirdpersonheightoffset = maps/mp/gametypes/prop::getthirdpersonheightoffsetforpropinfo(param_00);
	self method_86BD(1,self.thirdpersonrange,self.thirdpersonheightoffset);
}

//Function Number: 17
propmatchslope()
{
	if(!common_scripts\utility::func_562E(self.slopelocked))
	{
		self.slopelocked = 1;
		self setclientomnvar("ui_ph_matching_slope",1);
		if(common_scripts\utility::func_562E(self.var_5E61))
		{
			self.propent unlink();
			self.propent set_pitch_roll_for_ground_normal(self.var_777D);
			self.propent method_8449(self.propanchor);
		}

		if(maps/mp/gametypes/prop::useprophudserver())
		{
			if(common_scripts\utility::func_55E0())
			{
				self.matchslopekey.var_E5 = &"MP_PH_SLOPED";
				return;
			}

			self.matchslopekey.var_E5 = &"MP_PH_SLOPED_PC";
			return;
		}

		return;
	}

	self.slopelocked = 0;
	self setclientomnvar("ui_ph_matching_slope",0);
	if(common_scripts\utility::func_562E(self.var_5E61))
	{
		self.propent unlink();
		self.propent.var_1D = (self.var_1D[0],self.propent.var_1D[1],self.var_1D[2]);
		self.propent.var_116 = self.propanchor.var_116;
		self.propent method_8449(self.propanchor);
	}

	if(maps/mp/gametypes/prop::useprophudserver())
	{
		if(common_scripts\utility::func_55E0())
		{
			self.matchslopekey.var_E5 = &"MP_PH_SLOPE";
			return;
		}

		self.matchslopekey.var_E5 = &"MP_PH_SLOPE_PC";
		return;
	}
}

//Function Number: 18
propability()
{
	if(!maps\mp\_utility::func_3FA0("props_hide_over"))
	{
		return;
	}

	if(prophasflashesleft())
	{
		thread flashenemies();
		propdeductflash();
	}
}

//Function Number: 19
propclonepower()
{
	if(prophasclonesleft())
	{
		thread cloneprop();
		thread propdeductclonechange();
	}
}

//Function Number: 20
prophasclonesleft()
{
	return self.clonesleft > 0;
}

//Function Number: 21
propdeductclonechange()
{
	propsetclonesleft(self.clonesleft - 1);
}

//Function Number: 22
propsetclonesleft(param_00)
{
	self.clonesleft = param_00;
	self setclientomnvar("ui_ph_num_clones_left",self.clonesleft);
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.clonekey setvalue(self.clonesleft);
		if(self.clonesleft <= 0)
		{
			self.clonekey.var_18 = 0.5;
		}
	}
}

//Function Number: 23
prophasflashesleft()
{
	return self.abilityleft > 0;
}

//Function Number: 24
propdeductflash()
{
	propsetflashesleft(self.abilityleft - 1);
}

//Function Number: 25
propsetflashesleft(param_00)
{
	self.abilityleft = param_00;
	self setclientomnvar("ui_ph_num_flashes_left",self.abilityleft);
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.abilitykey setvalue(self.abilityleft);
		if(self.abilityleft <= 0)
		{
			self.abilitykey.var_18 = 0.5;
		}
	}
}

//Function Number: 26
set_pitch_roll_for_ground_normal(param_00)
{
	var_01 = get_ground_normal(param_00,0);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = anglestoforward(self.var_1D);
	var_03 = anglestoright(self.var_1D);
	var_04 = vectortoangles(var_01);
	var_05 = angleclamp180(var_04[0] + 90);
	var_04 = (0,var_04[1],0);
	var_06 = anglestoforward(var_04);
	var_07 = vectordot(var_06,var_03);
	if(var_07 < 0)
	{
		var_07 = -1;
	}
	else
	{
		var_07 = 1;
	}

	var_08 = vectordot(var_06,var_02);
	var_09 = var_08 * var_05;
	var_0A = 1 - abs(var_08) * var_05 * var_07;
	self.var_1D = (var_09,self.var_1D[1],var_0A);
}

//Function Number: 27
get_ground_normal(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		var_02 = self;
	}
	else
	{
		var_02 = param_01;
	}

	var_03 = [self.var_116];
	if(getdvarint("scr_ph_useBoundsForGroundNormal",1))
	{
		for(var_04 = -1;var_04 <= 1;var_04 = var_04 + 2)
		{
			for(var_05 = -1;var_05 <= 1;var_05 = var_05 + 2)
			{
				var_06 = var_02 method_8549(var_04,var_05,0);
				var_06 = (var_06[0],var_06[1],self.var_116[2]);
				var_03[var_03.size] = var_06;
			}
		}
	}

	var_07 = (0,0,0);
	var_08 = 0;
	foreach(var_0A in var_03)
	{
		var_0B = bullettrace(var_0A + (0,0,4),var_0A + (0,0,-16),0,var_02,1,0,0,0,0,0,0);
		var_0C = var_0B["fraction"] > 0 && var_0B["fraction"] < 1;
		if(var_0C)
		{
			var_07 = var_07 + var_0B["normal"];
			var_08++;
		}
	}

	if(var_08 > 0)
	{
		var_07 = var_07 / var_08;
		return var_07;
	}

	return undefined;
}

//Function Number: 28
propmoveunlock()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		wait 0.05;
		var_03 = self getnormalizedmovement();
		if(!isdefined(var_03))
		{
			continue;
		}

		if(self.propspectating)
		{
			continue;
		}

		var_04 = var_03[0] != 0 || var_03[1] != 0;
		if(self.var_5E61 && var_02 && !var_04)
		{
			var_02 = 0;
		}
		else if(self.var_5E61 && !var_00 && var_04)
		{
			var_02 = 1;
		}
		else if(self.var_5E61 && var_04 && !var_02)
		{
			unlockprop();
		}

		var_00 = self.var_5E61;
		var_01 = var_04;
	}
}

//Function Number: 29
unlockprop()
{
	self unlink();
	if(self.slopelocked)
	{
		self.propent unlink();
		self.propent.var_1D = (self.var_1D[0],self.propent.var_1D[1],self.var_1D[2]);
		self.propent.var_116 = self.propanchor.var_116;
		self.propent method_8449(self.propanchor);
	}

	self.propanchor method_8449(self);
	self.var_5E61 = 0;
	self setclientomnvar("ui_ph_is_locked",0);
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.lockpropkey.var_E5 = &"MP_PH_LOCK";
	}
}

//Function Number: 30
lockprop()
{
	if(!canlock())
	{
		return;
	}

	self.propanchor unlink();
	self.propanchor.var_116 = self.var_116;
	self playerlinkto(self.propanchor);
	if(self.slopelocked)
	{
		self.propent unlink();
		self.propent set_pitch_roll_for_ground_normal(self.var_777D);
		self.propent method_8449(self.propanchor);
	}

	self.var_5E61 = 1;
	self notify("locked");
	self setclientomnvar("ui_ph_is_locked",1);
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		self.lockpropkey.var_E5 = &"MP_PH_LOCKED";
	}
}

//Function Number: 31
canlock()
{
	if(!self isonground())
	{
		var_00 = getgroundposition(self.var_116,15,30000,0);
		var_01 = getentarray("trigger_hurt","classname");
		foreach(var_03 in var_01)
		{
			if(ispointinvolume(var_00,var_03))
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 32
propspectate()
{
	level endon("noPropsToSpectate");
	self.propspectating = 0;
	self.endingpropspecate = 0;
	if(!isdefined(self.spectatenumber))
	{
		self.spectatenumber = 0;
	}

	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("spectate");
		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_00 == "spectate")
		{
			if(self.propspectating)
			{
				self notify("endPropSpectate");
				continue;
			}

			maps/mp/gametypes/prop::createpropspeclist();
			if(self.spectatableprops.size <= 1)
			{
				continue;
			}

			self.propspectating = 1;
			propabilitykeysvisible(0);
			thread propspectateendwatch();
			childthread propspectatekeys();
		}
	}
}

//Function Number: 33
propspectatekeys()
{
	self endon("endPropSpectate");
	if(checkifvalidpropspectate())
	{
		spectateprop();
	}
	else
	{
		findvalidspectateprop(1);
		spectateprop();
	}

	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("zoomin","zoomout");
		if(self.endingpropspecate)
		{
			continue;
		}

		if(var_00 == "zoomin")
		{
			findvalidspectateprop(1);
			checkifvalidpropspectate();
			movetonewprop();
		}

		if(var_00 == "zoomout")
		{
			findvalidspectateprop(0);
			checkifvalidpropspectate();
			movetonewprop();
		}
	}
}

//Function Number: 34
checkifvalidpropspectate()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00 == self)
	{
		return 0;
	}

	if(maps\mp\_utility::func_57A0(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
findvalidspectateprop(param_00)
{
	var_01 = self.spectatenumber;
	for(;;)
	{
		if(common_scripts\utility::func_562E(param_00))
		{
			self.spectatenumber++;
		}
		else
		{
			self.spectatenumber--;
		}

		if(param_00 && self.spectatableprops.size <= self.spectatenumber)
		{
			self.spectatenumber = 0;
		}
		else if(self.spectatenumber < 0)
		{
			self.spectatenumber = self.spectatableprops.size - 1;
		}

		if(self.spectatenumber == var_01)
		{
			break;
		}

		if(checkifvalidpropspectate())
		{
			break;
		}
	}
}

//Function Number: 36
propspectateendwatch()
{
	self endon("disconnect");
	self endon("death");
	createpropspecatehud();
	common_scripts\utility::func_A70C(self,"endPropSpectate",level,"noPropsToSpectate");
	if(common_scripts\utility::func_562E(self.endingpropspecate))
	{
		return;
	}

	self.endingpropspecate = 1;
	destroypropspecatehud();
	returntoprop();
	waittillframeend;
	propabilitykeysvisible(1);
	self.propspectating = 0;
	self.endingpropspecate = 0;
}

//Function Number: 37
createpropspecatehud()
{
	self.spectatecommands = maps\mp\gametypes\_hud_util::func_27ED("default",1);
	self.spectatecommands.var_E5 = &"MP_PH_SPECCOMMANDS";
	self.spectatecommands.maxsightdistsqrd = 20;
	self.spectatecommands.var_1D7 = -80;
	self.spectatecommands.accuracy = "center";
	self.spectatecommands.var_11 = "middle";
	self.spectatecommands.var_C6 = "center_adjustable";
	self.spectatecommands.var_1CA = "bottom_adjustable";
	self.spectatecommands.var_1F = 1;
	self.spectatecommands.var_9B = 1;
	self.spectatecommands.var_18 = 1;
	self.spectatecommands.var_AA = 0.5;
	self.spectatecommands.var_C2 = 0;
}

//Function Number: 38
destroypropspecatehud()
{
	if(isdefined(self.spectatecommands))
	{
		self.spectatecommands destroy();
	}
}

//Function Number: 39
spectateprop()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	self.spectatingthisplayer = var_00;
	self.propanchor unlink();
	self.propanchor.var_116 = self.var_116;
	self setorigin(var_00.var_116);
	self.var_1D = var_00.var_1D;
	self playerlinkto(var_00.propanchor);
}

//Function Number: 40
movetonewprop()
{
	var_00 = self.spectatableprops[self.spectatenumber];
	self unlink();
	self.var_116 = var_00.var_116;
	self.var_1D = var_00.var_1D;
	self playerlinkto(var_00.propanchor);
}

//Function Number: 41
returntoprop()
{
	self unlink();
	self setorigin(self.propanchor.var_116);
	if(self.var_5E61)
	{
		self playerlinkto(self.propanchor);
		return;
	}

	self.propanchor method_8449(self);
	self.propanchor.var_116 = self.var_116;
}

//Function Number: 42
nospectatablepropswatch()
{
	level endon("game_ended");
	level waittill("noPropsToSpectate");
	safedestroy(self.spectatekey);
}

//Function Number: 43
propcamerazoom()
{
	self.thirdpersonrange = maps/mp/gametypes/prop::getthirdpersonrangeforpropinfo(self.var_777D.var_5135);
	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("zoomin","zoomout");
		if(common_scripts\utility::func_562E(self.endingpropspecate))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			continue;
		}

		if(common_scripts\utility::func_562E(self.propspectating))
		{
			continue;
		}

		if(var_00 == "zoomin")
		{
			if(self.thirdpersonrange <= 60)
			{
				continue;
			}

			self.thirdpersonrange = self.thirdpersonrange - 10;
			self method_86BD(1,self.thirdpersonrange,self.thirdpersonheightoffset);
			continue;
		}

		if(var_00 == "zoomout")
		{
			if(self.thirdpersonrange >= max(maps/mp/gametypes/prop::getthirdpersonrangeforpropinfo(self.var_777D.var_5135),240))
			{
				continue;
			}

			self.thirdpersonrange = self.thirdpersonrange + 10;
			self method_86BD(1,self.thirdpersonrange,self.thirdpersonheightoffset);
		}
	}
}

//Function Number: 44
proprotate()
{
	for(;;)
	{
		if(self adsbuttonpressed(1) && !common_scripts\utility::func_562E(self.propent.spinning))
		{
			self.propent scriptmodelpauseanim(0);
			self.propent.spinning = 1;
		}
		else if(!self adsbuttonpressed(1) && common_scripts\utility::func_562E(self.propent.spinning))
		{
			self.propent scriptmodelpauseanim(1);
			self.propent.spinning = 0;
		}

		wait 0.05;
	}
}

//Function Number: 45
setnewabilityhud()
{
	switch(self.currentability)
	{
		case "FLASH":
			self.abilitykey.var_E5 = &"MP_PH_FLASH";
			break;

		default:
			break;
	}
}

//Function Number: 46
setnewabilitycount(param_00)
{
	switch(param_00)
	{
		case "FLASH":
			propsetflashesleft(level.phsettings.propnumflashes);
			break;

		case "CLONE":
			propsetclonesleft(level.phsettings.propnumclones);
			break;

		default:
			break;
	}
}

//Function Number: 47
flashtheprops(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	thread maps\mp\gametypes\_shellshock::func_36DC();
	self endon("end_explode");
	self waittill("explode",var_01);
	if(!isdefined(param_00))
	{
		return;
	}

	flashenemies(param_00,var_01);
}

//Function Number: 48
flashenemies(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	if(!isdefined(param_01))
	{
		param_01 = self.var_116;
	}

	playfx(common_scripts\utility::func_44F5("propFlash"),param_01 + (0,0,4));
	playsoundatpos(param_01,"prop_flashbang");
	foreach(var_0C, var_03 in level.var_744A)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_03.flashimmune))
		{
			continue;
		}

		if(!isdefined(var_03) || !isalive(var_03) || !isdefined(var_03.var_1A7) || var_03.var_1A7 != game["attackers"])
		{
			continue;
		}

		var_04 = param_01 + (0,0,4) - var_03 geteye();
		var_05 = length(var_04);
		var_06 = 500;
		var_07 = 150;
		if(var_05 <= var_06)
		{
			if(var_05 <= var_07)
			{
				var_08 = 1;
			}
			else
			{
				var_08 = 1 - var_06 - var_0C / var_07 - var_0C;
			}

			var_09 = vectornormalize(var_04);
			var_0A = anglestoforward(var_03 getangles());
			var_0B = vectordot(var_0A,var_09);
			var_03 notify("flashbang",param_01 + (0,0,4),var_08,var_0B,param_00,param_00.var_1A7,2);
			param_00 thread maps\mp\gametypes\_damagefeedback::func_A102("standard",param_00);
		}
	}
}

//Function Number: 49
deletepropsifatmax()
{
	var_00 = 9;
	if(self.propclones.size + 1 <= var_00)
	{
		return;
	}

	var_01 = 0;
	foreach(var_03 in self.propclones)
	{
		if(isdefined(var_03))
		{
			var_01++;
		}
	}

	if(var_01 + 1 <= var_00)
	{
		return;
	}

	var_05 = [];
	var_06 = undefined;
	for(var_07 = 0;var_07 < self.propclones.size;var_07++)
	{
		var_03 = self.propclones[var_07];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(!isdefined(var_06))
		{
			var_06 = var_03;
			continue;
		}

		var_05[var_05.size] = var_03;
	}

	var_06 notify("maxDelete");
	var_06 delete();
	self.propclones = var_05;
}

//Function Number: 50
cloneprop()
{
	if(!isdefined(self.propclones))
	{
		self.propclones = [];
	}
	else
	{
		deletepropsifatmax();
	}

	var_00 = spawn("script_model",self.var_777D.var_116);
	var_00.var_1A5 = "propClone";
	var_00 setmodel(self.var_777D.var_106);
	var_00.var_1D = self.var_777D.var_1D;
	var_00.var_BC = 50;
	var_00.var_7433 = self;
	var_00 setcandamage(1);
	var_00 setdamagecallbackon(1);
	var_00.var_29B5 = ::damageclonewatch;
	var_00 thread deleteclone(self);
	var_00 thread maps/mp/gametypes/prop::highlighttoteam(game["defenders"],0,self);
	var_00 common_scripts\utility::func_5FA9(self.var_1A7);
	self.propclones[self.propclones.size] = var_00;
}

//Function Number: 51
damageclonewatch(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(isplayer(param_01))
	{
		if(common_scripts\utility::func_562E(self.isdying))
		{
			return;
		}

		param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("raid_buildable",self);
		self.var_E6 = param_00;
		self finishentitydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}
}

//Function Number: 52
deleteclone(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("maxDelete");
	var_01 = 0.25;
	param_00 common_scripts\utility::func_A70C(self,"death");
	if(isdefined(self.var_E6))
	{
		level thread maps\mp\gametypes\_rank::func_1457("clone_destroyed",self.var_E6);
		if(isdefined(self.var_7433))
		{
			level thread maps\mp\gametypes\_rank::func_1457("clone_was_destroyed",self.var_7433);
		}
	}

	if(!isdefined(self.isdying))
	{
		self.isdying = 1;
	}

	var_02 = "prop_death";
	var_03 = "propDeathFX";
	playsoundatpos(self.var_116 + (0,0,4),var_02);
	playfx(common_scripts\utility::func_44F5(var_03),self.var_116 + (0,0,4));
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 53
fadetoblackforxsec(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	if(!isdefined(param_00))
	{
		param_00 = 5;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = newclienthudelem(self);
	var_03.var_A0 = 0;
	var_03.maxsightdistsqrd = 0;
	var_03.var_1D7 = 0;
	var_03 setshader("black",640,480);
	var_03.accuracy = "left";
	var_03.var_11 = "top";
	var_03.var_C6 = "fullscreen";
	var_03.var_1CA = "fullscreen";
	var_03.var_18 = 0;
	wait 0.05;
	if(param_01 > 0)
	{
		var_03 fadeovertime(param_01);
	}

	var_03.var_18 = 1;
	maps\mp\gametypes\_hostmigration::func_A6F5(param_00 - param_02);
	if(param_02 > 0)
	{
		var_03 fadeovertime(param_02);
	}

	var_03.var_18 = 0;
	maps\mp\gametypes\_hostmigration::func_A6F5(param_02);
	wait 0.05;
	safedestroy(var_03);
}

//Function Number: 54
watchspecialgrenadethrow()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("specialGrenade","+smoke");
	for(;;)
	{
		self waittill("specialGrenade");
		self.thrownspecialcount = self.thrownspecialcount + 1;
	}
}

//Function Number: 55
hidehudintermission()
{
	level waittill("game_ended");
	if(maps/mp/gametypes/prop::useprophudserver())
	{
		level.elim_hud.var_18 = 0;
		level.phwhistletimer.var_18 = 0;
		level.whistling.var_18 = 0;
	}

	foreach(var_01 in level.var_744A)
	{
		var_01 propabilitykeysvisible(0);
	}
}

//Function Number: 56
safesetalpha(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00.var_18 = param_01;
	}
}

//Function Number: 57
propabilitykeysvisible(param_00,param_01)
{
	if(common_scripts\utility::func_562E(param_00))
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	if(maps/mp/gametypes/prop::useprophudserver() || common_scripts\utility::func_562E(param_01))
	{
		safesetalpha(self.changepropkey,var_02);
		safesetalpha(self.spinpropkey,var_02);
		safesetalpha(self.lockpropkey,var_02);
		safesetalpha(self.matchslopekey,var_02);
		safesetalpha(self.abilitykey,var_02);
		safesetalpha(self.clonekey,var_02);
		safesetalpha(self.zoomkey,var_02);
		if(!common_scripts\utility::func_562E(level.nopropsspectate))
		{
			safesetalpha(self.spectatekey,var_02);
		}
	}
}
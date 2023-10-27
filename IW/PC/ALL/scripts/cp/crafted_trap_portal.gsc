/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_trap_portal.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 997 ms
 * Timestamp: 10/27/2023 12:10:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_11901 = 300;
	var_00.var_B91A = "cp_town_teleporter_device";
	var_00.var_B924 = "cp_town_teleporter_device_good";
	var_00.var_B925 = "cp_town_teleporter_device_bad";
	var_00.var_CC12 = "cp_town_teleporter_device";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 24;
	var_00.var_3AA7 = (0,0,25);
	var_00.var_3AA6 = (0,0,0);
	level.crafted_portal_settings = [];
	level.crafted_portal_settings["crafted_portal"] = var_00;
}

//Function Number: 2
give_crafted_portal(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_portal");
	param_01 setclientomnvar("zom_crafted_weapon",6);
	scripts\cp\_utility::func_F313("crafted_portal",::give_crafted_portal,param_01);
	if(isdefined(param_01.placed_portals) && param_01.placed_portals.size == 2)
	{
		foreach(var_03 in param_01.placed_portals)
		{
			var_03 notify("death");
		}
	}
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_portal","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_portal");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread give_portal(1);
}

//Function Number: 4
give_portal(param_00,param_01,param_02)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_03 = createportalforplayer(self,param_02);
	self.var_A039 = var_03.name;
	func_E152();
	self.var_3AA5 = var_03;
	if(param_00)
	{
		var_03.var_6DEC = 1;
	}

	var_04 = setcarryingportal(var_03,param_00,param_01);
	self.var_3AA5 = undefined;
	thread func_1370F();
	self.var_9D81 = 0;
	if(isdefined(var_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
setcarryingportal(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 portal_setcarried(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_portal","+attack");
	self notifyonplayercommand("place_portal","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_portal","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_portal","+actionslot 5");
		self notifyonplayercommand("cancel_portal","+actionslot 6");
		self notifyonplayercommand("cancel_portal","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_portal","cancel_portal","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_portal" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_portal")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 portal_setcancelled();
			if(var_03 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 portal_setplaced(param_02,self);
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_E152()
{
	if(scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}
}

//Function Number: 7
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\cp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 8
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 9
createportalforplayer(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_00.angles;
	var_02.var_222 = param_00;
	var_02.name = "crafted_portal";
	var_02.carriedportal = spawn("script_model",var_02.origin);
	var_02.carriedportal.angles = param_00.angles;
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_00);
	if(!isdefined(param_01))
	{
		var_02.var_130D2 = 1;
	}
	else
	{
		var_02.var_130D2 = param_01;
	}

	var_02 portal_initportal(param_00);
	return var_02;
}

//Function Number: 10
portal_initportal(param_00)
{
	self.var_3872 = 1;
	portal_setinactive();
}

//Function Number: 11
portal_handledeath(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	portal_setinactive();
	param_00.placed_portals = scripts\common\utility::func_22A9(param_00.placed_portals,self);
	scripts\cp\_utility::func_E11E();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 12
portal_setplaced(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin + (0,0,1));
	var_02.angles = self.angles;
	if(isdefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !isdefined(level.portal_opened))
	{
		var_03 = scripts\common\utility::getclosest(self.origin,level.secretpapstructs);
		if(distance(var_03.origin,self.origin) <= 128)
		{
			var_02.papredirect = 1;
		}
	}

	var_02 solid();
	var_02 setmodel(level.crafted_portal_settings["crafted_portal"].var_CC12);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	var_02.var_222 = param_01;
	var_02.var_130D2 = self.var_130D2;
	var_02.name = "crafted_portal";
	var_02 thread portal_setactive(param_00);
	var_02 thread portal_wait_for_player();
	self notify("placed");
	self.carriedportal delete();
	self delete();
	var_02 hudoutlineenableforclient(param_01,2,0,1,0);
	if(!isdefined(param_01.placed_portals))
	{
		param_01.placed_portals = [];
	}

	param_01.placed_portals[param_01.placed_portals.size] = var_02;
	if(param_01.placed_portals.size == 1)
	{
		param_01 thread func_13932();
		param_01 setclientomnvar("zom_crafted_weapon",6);
		scripts\cp\_utility::func_F313("crafted_portal",::give_crafted_portal,param_01);
	}

	if(param_01.placed_portals.size == 3)
	{
		param_01.placed_portals[param_01.placed_portals.size - 1] notify("death");
	}
}

//Function Number: 13
portal_setcancelled()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.carriedportal delete();
	self delete();
}

//Function Number: 14
portal_setcarried(param_00,param_01)
{
	self setmodel(level.crafted_portal_settings["crafted_portal"].var_B924);
	self hide();
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.carriedportal,level.crafted_portal_settings["crafted_portal"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	portal_setinactive();
	self notify("carried");
}

//Function Number: 15
portal_setactive(param_00)
{
	self endon("death");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.crafted_portal_settings["crafted_portal"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread portal_handledeath(self.var_222);
	thread scripts\cp\_utility::func_A021("elecportal_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.crafted_portal_settings["crafted_portal"].var_11901);
	thread portal_handleuse();
	scripts\cp\_utility::func_1861();
	wait(1);
	if(!scripts\common\utility::istrue(self.papredirect))
	{
		self setscriptablepartstate("portal","on");
		return;
	}

	iprintlnbold("PAP PORTAL ACTIVE");
	self.var_222 notify("craft_dpad_watcher");
	self.var_222 setclientomnvar("zom_crafted_weapon",0);
	self.var_222.var_4B5C = undefined;
	level.portal_opened = 1;
	activate_pap_portals(self.origin);
	foreach(var_02 in self.var_222.placed_portals)
	{
		var_02 notify("death");
	}
}

//Function Number: 16
activate_pap_portals(param_00)
{
	var_01 = scripts\common\utility::getclosest(param_00,level.secretpapstructs);
	var_01.model setscriptablepartstate("portal","on");
	var_01.var_19 = 1;
	var_01.revealed = 1;
	level.active_pap_portal = var_01;
}

//Function Number: 17
portal_handleuse()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		self playsound("zmb_item_pickup");
		var_00 thread give_portal(0,self.var_AC71,self.var_130D2);
		var_00.placed_portals = scripts\common\utility::func_22A9(var_00.placed_portals,self);
		scripts\cp\_utility::func_E11E();
		self delete();
	}
}

//Function Number: 18
portal_setinactive()
{
	self makeunusable();
	scripts\cp\_utility::func_E11E();
}

//Function Number: 19
portal_wait_for_player()
{
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("death");
	for(;;)
	{
		if(scripts\common\utility::istrue(self.var_222.var_1165E))
		{
			while(distancesquared(self.var_222.origin,self.origin) < 576)
			{
				wait(0.1);
			}

			self.var_222.var_1165E = undefined;
		}

		if(distancesquared(self.var_222.origin,self.origin) < 576)
		{
			self.var_222.var_1165E = 1;
			self.var_222 thread teleport_owner(self);
			wait(5);
		}

		wait(0.1);
	}
}

//Function Number: 20
teleport_owner(param_00)
{
	var_01 = self.placed_portals;
	foreach(var_03 in self.placed_portals)
	{
		if(var_03 == param_00)
		{
			continue;
		}
		else
		{
			self playlocalsound("zmb_portal_travel_lr");
			scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
			thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.5);
			playfx(level._effect["portal_player_world"],param_00.origin + (0,0,10));
			self setorigin(var_03.origin + (0,0,1));
		}
	}
}
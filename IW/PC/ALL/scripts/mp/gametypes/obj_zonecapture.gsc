/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_zonecapture.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1531 ms
 * Timestamp: 10/27/2023 12:12:59 AM
*******************************************************************/

//Function Number: 1
func_8B4A(param_00)
{
	var_01 = level.var_C2A8[param_00];
	var_02 = [];
	var_02[0] = var_01;
	var_01 = postshipmodifiedkothzones(var_01);
	var_01.var_767B = scripts\mp\_gameobjects::func_4A2E("neutral",var_01,var_02,(0,0,0));
	var_01.var_767B scripts\mp\_gameobjects::disableobject();
	var_01.var_767B scripts\mp\_gameobjects::func_F283("mlg",undefined);
	var_01.var_767B scripts\mp\_gameobjects::func_F284("mlg",undefined);
	var_01.var_767B.var_3FF7 = level.var_13FBC * 1000;
	var_01.var_767B scripts\mp\_gameobjects::cancontestclaim(1);
	if(level.var_13097)
	{
		var_01.var_767B scripts\mp\_gameobjects::mustmaintainclaim(0);
	}
	else
	{
		var_01.var_767B scripts\mp\_gameobjects::mustmaintainclaim(1);
	}

	var_01.var_767B.var_92B8 = "hardpoint";
	var_01.var_130AC = var_01.var_767B;
	if(isdefined(var_01.target))
	{
		var_01.var_130AC thread assignchevrons(var_01.target,var_01.script_label);
	}

	return var_01;
}

//Function Number: 2
postshipmodifiedkothzones(param_00)
{
	if(level.var_B335 == "mp_parkour")
	{
		if(param_00.script_label == "1")
		{
			param_00.origin = param_00.origin + (0,0,135);
		}
	}

	if(level.var_B335 == "mp_fallen")
	{
		if(param_00.script_label == "3")
		{
			param_00.origin = param_00.origin - (0,0,50);
		}
	}

	if(level.var_B335 == "mp_junk")
	{
		if(param_00.script_label == "4")
		{
			param_00.origin = param_00.origin - (0,7,0);
		}
	}

	return param_00;
}

//Function Number: 3
assignchevrons(param_00,param_01)
{
	wait(1);
	var_02 = 0;
	var_03 = getscriptablearray(param_00,"targetname");
	if(level.var_B335 == "mp_parkour")
	{
		if(param_01 == "1")
		{
			var_02 = 1;
		}
	}

	if(!var_02)
	{
		var_04 = [];
		foreach(var_06 in var_03)
		{
			var_07 = var_04.size;
			var_04[var_07] = var_06;
			var_04[var_07].numchevrons = 1;
			if(isdefined(var_06.script_noteworthy))
			{
				if(var_06.script_noteworthy == "2")
				{
					var_04[var_07].numchevrons = 2;
					continue;
				}

				if(var_06.script_noteworthy == "3")
				{
					var_04[var_07].numchevrons = 3;
					continue;
				}

				if(var_06.script_noteworthy == "4")
				{
					var_04[var_07].numchevrons = 4;
				}
			}
		}
	}
	else
	{
		var_04 = postshipmodifychevrons(var_02);
	}

	self.chevrons = var_04;
}

//Function Number: 4
updatechevrons(param_00)
{
	self notify("updateChevrons");
	self endon("updateChevrons");
	while(!isdefined(self.chevrons))
	{
		wait(0.05);
	}

	foreach(var_02 in self.chevrons)
	{
		for(var_03 = 0;var_03 < var_02.numchevrons;var_03++)
		{
			var_02 setscriptablepartstate("chevron_" + var_03,param_00);
		}
	}
}

//Function Number: 5
func_1619()
{
	self.var_C5BB = ::func_13FB6;
	self.var_C4CB = ::func_13FB7;
	self.var_C5C8 = ::func_13FB8;
	self.var_C50D = ::zone_onuseend;
	self.var_C5BA = ::func_13FB5;
	self.var_C4D9 = ::func_13FB3;
	self.var_C5B9 = ::func_13FB4;
	level thread scripts\mp\gametypes\koth::func_26CE();
}

//Function Number: 6
func_4DE2()
{
	self.var_C5BB = undefined;
	self.var_C4CB = undefined;
	self.var_C5C8 = undefined;
	self.var_C5BA = undefined;
	self.var_C4D9 = undefined;
	self.var_C5B9 = undefined;
	thread updatechevrons("off");
}

//Function Number: 7
func_13FC7()
{
	level endon("game_ended");
	level endon("dev_force_zone");
	var_00 = int(level.var_13FC2 * 1000 + gettime());
	thread func_911B();
	level thread func_89B4(var_00);
	scripts\mp\_hostmigration::func_13708(level.var_13FC2);
}

//Function Number: 8
func_911B()
{
	level endon("game_ended");
	if(int(level.var_13FC2) > 12)
	{
		var_00 = level.var_13FC2 - 12;
		scripts\mp\_hostmigration::func_13708(var_00);
		level scripts\mp\_utility::func_10E60("hp_move_soon","allies");
		level scripts\mp\_utility::func_10E60("hp_move_soon","axis");
	}
}

//Function Number: 9
func_89B4(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setomnvar("ui_uplink_timer_stopped",1);
	var_01 = scripts\mp\_hostmigration::func_13834();
	setomnvar("ui_uplink_timer_stopped",0);
	if(var_01 > 0)
	{
		setomnvar("ui_hardpoint_timer",level.zoneendtime + var_01);
		return;
	}

	setomnvar("ui_hardpoint_timer",level.zoneendtime);
}

//Function Number: 10
func_8B49()
{
	self notify("flag_neutral");
	scripts\mp\_gameobjects::func_F7D4("neutral");
	func_D493();
	thread updatechevrons("idle");
}

//Function Number: 11
func_11ADB()
{
	thread func_40F8();
	level endon("game_ended");
	level endon("zone_moved");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 istouching(self.trigger))
			{
				var_01 method_80C1(1);
				continue;
			}

			var_01 method_80C1(0);
		}

		wait(0.5);
	}
}

//Function Number: 12
func_40F8()
{
	level scripts\common\utility::waittill_any_3("game_ended","zone_moved");
	foreach(var_01 in level.players)
	{
		var_01 method_80C1(0);
	}
}

//Function Number: 13
func_13FB6(param_00)
{
	if(level.var_13097 && self.ownerteam != "neutral")
	{
		level notify("zone_destroyed");
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setvisibleteam("none");
		level scripts\mp\gametypes\koth::func_12F17("zone_shift",0);
		level scripts\mp\_utility::func_10E60("obj_destroyed",self.ownerteam,1);
		level scripts\mp\_utility::func_10E60("obj_captured",param_00.team,1);
		return;
	}

	var_01 = param_00.team;
	var_02 = scripts\mp\_gameobjects::func_803E();
	var_03 = scripts\mp\_utility::getotherteam(var_01);
	var_04 = gettime();
	if(!level.var_11920 && level.var_C9D5)
	{
		level scripts\mp\_gamelogic::func_C9D6();
	}

	level.var_130DD = 0;
	var_05 = 0;
	level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icondefend,level.iconcapture);
	level scripts\mp\gametypes\koth::func_12F17(var_01,0);
	if(!isdefined(level.var_A950) || level.var_A950 != var_01)
	{
		if(level.gametype == "koth")
		{
			level scripts\mp\_utility::func_10E60("hp_captured_friendly",var_01,1);
			level scripts\mp\_utility::func_10E60("hp_captured_enemy",var_03,1);
		}
		else
		{
			level scripts\mp\_utility::func_10E60("friendly_zone_control",var_01,1);
			level scripts\mp\_utility::func_10E60("enemy_zone_control",var_03,1);
		}

		var_06 = [];
		var_07 = getarraykeys(self.touchlist[var_01]);
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			var_06[var_07[var_08]] = self.touchlist[var_01][var_07[var_08]];
		}

		level thread scripts\mp\gametypes\koth::func_82AE(var_06,var_04,var_01,level.var_A950);
	}

	thread scripts\mp\_utility::printandsoundoneveryone(var_01,var_03,undefined,undefined,"mp_dom_flag_captured",undefined,param_00);
	foreach(var_0A in level.players)
	{
		func_10114(var_01,var_0A);
	}

	level.var_13FB0.var_767B thread updatechevrons(var_01);
	thread func_8B4C();
	level.var_911E = var_01;
	if(!isdefined(level.var_A950) || var_01 != level.var_A950)
	{
		scripts\mp\_utility::func_F79E(6,var_01,param_00 getentitynumber());
	}

	scripts\mp\_gameobjects::func_F7D4(var_01);
	self.var_3A3D++;
	level.var_A950 = var_01;
	if(level.var_13097)
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_1CAF("enemy");
	}
	else
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::func_1CAF("none");
	}

	level notify("zone_captured");
	level notify("zone_captured" + var_01);
}

//Function Number: 14
func_13FB7(param_00)
{
	self.var_54C5 = 0;
	scripts\mp\_gameobjects::func_FB08(level.var_13FBC);
	thread scripts\mp\_gameobjects::func_130AE(param_00.team);
	if(level.var_13FBC > 0)
	{
		self.var_D8BA = level.var_C74B[param_00.team];
		scripts\mp\_gameobjects::setzonestatusicons(level.iconlosing,level.icontaking);
	}
}

//Function Number: 15
func_13FB8(param_00,param_01,param_02,param_03)
{
	if(!level.var_11920 && level.var_C9D5)
	{
		level scripts\mp\_gamelogic::func_C9D6();
	}

	var_04 = scripts\mp\_gameobjects::func_803E();
	var_05 = scripts\mp\_utility::getotherteam(param_00);
	if(param_01 > 0.05 && param_02 && !self.var_54C5)
	{
		if(var_04 == "neutral")
		{
			scripts\mp\_utility::func_10E60("hp_capturing_friendly",param_00);
			scripts\mp\_utility::func_10E60("hp_capturing_enemy",var_05);
		}
		else
		{
			scripts\mp\_utility::func_10E60("hp_capturing_enemy",var_04,1);
			scripts\mp\_utility::func_10E60("hp_capturing_friendly",param_00);
		}

		self.var_54C5 = 1;
	}
}

//Function Number: 16
zone_onuseend(param_00,param_01,param_02)
{
	if(!param_02)
	{
		if(level.var_11920 && level.var_C9D5)
		{
			level scripts\mp\_gamelogic::func_E2FF();
		}
	}

	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_objective_state",0);
		param_01.var_12B1D = undefined;
	}

	var_03 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
	if(var_03 == "neutral")
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral);
		foreach(param_01 in level.players)
		{
			level.var_13FB0.var_767B func_1015F(param_01);
		}
	}
	else
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icondefend,level.iconcapture);
		foreach(param_01 in level.players)
		{
			level.var_13FB0.var_767B func_10114(var_03,param_01);
		}
	}

	if(!param_02)
	{
		if(level.var_11920 && level.var_C9D5)
		{
			level scripts\mp\_gamelogic::func_E2FF();
		}
	}
}

//Function Number: 17
func_13FB5()
{
	if(level.var_13097 && self.ownerteam != "neutral")
	{
		return;
	}

	level notify("zone_destroyed");
	level.var_911E = "neutral";
	if(level.var_11920 && level.var_C9D5)
	{
		level scripts\mp\_gamelogic::func_E2FF();
	}

	if(self.numtouching["axis"] == 0 && self.numtouching["allies"] == 0)
	{
		level.var_13FB0.var_767B.var_13917 = 1;
		level scripts\mp\gametypes\koth::func_12F17("neutral",0);
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral);
		level.var_13FB0.var_767B func_D493();
		level.var_13FB0.var_767B thread updatechevrons("idle");
	}
}

//Function Number: 18
func_13FB3()
{
	scripts\mp\_utility::func_F79E(7,"free");
	if(level.var_11920 && level.var_C9D5)
	{
		level scripts\mp\_gamelogic::func_E2FF();
	}

	var_00 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
	level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconcontested);
	level scripts\mp\gametypes\koth::func_12F17(var_00,1);
	level.var_13FB0.var_767B thread updatechevrons("contested");
	foreach(var_02 in level.players)
	{
		level.var_13FB0.var_767B func_10114(var_00,var_02);
	}

	if(var_00 == "neutral")
	{
		var_04 = self.claimteam;
	}
	else
	{
		var_04 = var_01;
	}

	scripts\mp\_utility::func_10E60("hp_contested",var_04,1);
	level.var_13FB0.var_767B thread scripts\mp\_matchdata::func_AFBA("hill_contested",level.var_13FB0.origin);
}

//Function Number: 19
func_13FB4(param_00)
{
	if(!level.var_11920 && level.var_C9D5)
	{
		level scripts\mp\_gamelogic::func_C9D6();
	}

	var_01 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
	if(param_00 == "none" || var_01 == "neutral")
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral);
		foreach(var_03 in level.players)
		{
			level.var_13FB0.var_767B func_1015F(var_03);
		}

		level.var_13FB0.var_767B thread scripts\mp\_matchdata::func_AFBA("hill_empty",level.var_13FB0.origin);
	}
	else
	{
		level.var_13FB0.var_767B scripts\mp\_gameobjects::setzonestatusicons(level.icondefend,level.iconcapture);
		foreach(var_03 in level.players)
		{
			level.var_13FB0.var_767B func_10114(var_01,var_03);
		}

		level.var_13FB0.var_767B thread scripts\mp\_matchdata::func_AFBA("hill_uncontested",level.var_13FB0.origin);
	}

	var_07 = scripts\common\utility::func_116D7(var_01 == "neutral","idle",var_01);
	level.var_13FB0.var_767B thread updatechevrons(var_07);
	level scripts\mp\gametypes\koth::func_12F17(var_01,0);
}

//Function Number: 20
func_F6AA(param_00)
{
	if(isdefined(level.var_112C0) && level.var_112C0 && isdefined(param_00.var_47ED) && param_00.var_47ED)
	{
		param_00 scripts\mp\_utility::func_F6A8("assist");
	}
}

//Function Number: 21
func_D493()
{
	foreach(var_01 in level.players)
	{
		if(level.var_13095)
		{
			func_1015F(var_01);
		}
	}
}

//Function Number: 22
func_10114(param_00,param_01)
{
	var_02 = param_01.team;
	var_03 = param_01 ismlgspectator();
	if(var_03)
	{
		var_02 = param_01 method_813B();
	}

	if(level.var_13095)
	{
		if(level.var_13FB0.var_767B.var_10B51)
		{
			func_1015C(param_01);
			return;
		}

		if(var_02 == param_00)
		{
			func_1015E(param_01);
			return;
		}

		func_1015D(param_01);
		return;
	}
}

//Function Number: 23
func_1015F(param_00)
{
	level.var_13FB0.var_767B.var_7403 method_8429(param_00);
	level.var_13FB0.var_767B.var_6550 method_8429(param_00);
	level.var_13FB0.var_767B.var_457E method_8429(param_00);
	level.var_13FB0.var_767B.var_BEEE showtoplayer(param_00);
}

//Function Number: 24
func_1015E(param_00)
{
	level.var_13FB0.var_767B.var_7403 showtoplayer(param_00);
	level.var_13FB0.var_767B.var_6550 method_8429(param_00);
	level.var_13FB0.var_767B.var_457E method_8429(param_00);
	level.var_13FB0.var_767B.var_BEEE method_8429(param_00);
}

//Function Number: 25
func_1015D(param_00)
{
	level.var_13FB0.var_767B.var_7403 method_8429(param_00);
	level.var_13FB0.var_767B.var_6550 showtoplayer(param_00);
	level.var_13FB0.var_767B.var_457E method_8429(param_00);
	level.var_13FB0.var_767B.var_BEEE method_8429(param_00);
}

//Function Number: 26
func_1015C(param_00)
{
	level.var_13FB0.var_767B.var_7403 method_8429(param_00);
	level.var_13FB0.var_767B.var_6550 method_8429(param_00);
	level.var_13FB0.var_767B.var_457E showtoplayer(param_00);
	level.var_13FB0.var_767B.var_BEEE method_8429(param_00);
}

//Function Number: 27
func_8ED5(param_00)
{
	self.var_7403 method_8429(param_00);
	self.var_6550 method_8429(param_00);
	self.var_BEEE method_8429(param_00);
	self.var_457E method_8429(param_00);
}

//Function Number: 28
func_8B4C()
{
	level endon("game_ended");
	self endon("flag_neutral");
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(var_00.team != "spectator" && level.var_13FB0.var_767B.ownerteam != "neutral")
		{
			level.var_13FB0.var_767B func_10114(level.var_13FB0.var_767B.ownerteam,var_00);
		}
	}
}

//Function Number: 29
postshipmodifychevrons(param_00)
{
	if(level.var_B335 == "mp_parkour")
	{
		var_01 = [];
		var_02 = [];
		var_03 = spawn("script_model",(176,-240,308));
		var_03 setmodel("hp_chevron_scriptable");
		var_03 = createvisualsinfo(var_03,(176,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_03;
		var_04 = spawn("script_model",(112,-240,308));
		var_04 setmodel("hp_chevron_scriptable");
		var_04 = createvisualsinfo(var_04,(112,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_04;
		var_05 = spawn("script_model",(48,-240,308));
		var_05 setmodel("hp_chevron_scriptable");
		var_05 = createvisualsinfo(var_05,(48,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_05;
		var_06 = spawn("script_model",(-16,-240,308));
		var_06 setmodel("hp_chevron_scriptable");
		var_06 = createvisualsinfo(var_06,(-16,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_06;
		var_07 = spawn("script_model",(-80,-240,308));
		var_07 setmodel("hp_chevron_scriptable");
		var_07 = createvisualsinfo(var_07,(-80,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_07;
		var_08 = spawn("script_model",(-144,-240,308));
		var_08 setmodel("hp_chevron_scriptable");
		var_08 = createvisualsinfo(var_08,(-144,-240,308),(0,90,0),param_00);
		var_02[var_02.size] = var_08;
		var_09 = spawn("script_model",(-176,-192,308));
		var_09 setmodel("hp_chevron_scriptable");
		var_09 = createvisualsinfo(var_09,(-176,-192,308),(0,0,0),param_00);
		var_02[var_02.size] = var_09;
		var_0A = spawn("script_model",(-176,-128,308));
		var_0A setmodel("hp_chevron_scriptable");
		var_0A = createvisualsinfo(var_0A,(-176,-128,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0A;
		var_0B = spawn("script_model",(-176,-64,308));
		var_0B setmodel("hp_chevron_scriptable");
		var_0B = createvisualsinfo(var_0B,(-176,-64,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0B;
		var_0C = spawn("script_model",(-176,0,308));
		var_0C setmodel("hp_chevron_scriptable");
		var_0C = createvisualsinfo(var_0C,(-176,0,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0C;
		var_0D = spawn("script_model",(-176,64,308));
		var_0D setmodel("hp_chevron_scriptable");
		var_0D = createvisualsinfo(var_0D,(-176,64,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0D;
		var_0E = spawn("script_model",(-176,128,308));
		var_0E setmodel("hp_chevron_scriptable");
		var_0E = createvisualsinfo(var_0E,(-176,128,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0E;
		var_0F = spawn("script_model",(-176,192,308));
		var_0F setmodel("hp_chevron_scriptable");
		var_0F = createvisualsinfo(var_0F,(-176,192,308),(0,0,0),param_00);
		var_02[var_02.size] = var_0F;
		var_10 = spawn("script_model",(-144,240,308));
		var_10 setmodel("hp_chevron_scriptable");
		var_10 = createvisualsinfo(var_10,(-144,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_10;
		var_11 = spawn("script_model",(-80,240,308));
		var_11 setmodel("hp_chevron_scriptable");
		var_11 = createvisualsinfo(var_11,(-80,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_11;
		var_12 = spawn("script_model",(-16,240,308));
		var_12 setmodel("hp_chevron_scriptable");
		var_12 = createvisualsinfo(var_12,(-16,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_12;
		var_13 = spawn("script_model",(48,240,308));
		var_13 setmodel("hp_chevron_scriptable");
		var_13 = createvisualsinfo(var_13,(48,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_13;
		var_14 = spawn("script_model",(112,240,308));
		var_14 setmodel("hp_chevron_scriptable");
		var_14 = createvisualsinfo(var_14,(112,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_14;
		var_15 = spawn("script_model",(176,240,308));
		var_15 setmodel("hp_chevron_scriptable");
		var_15 = createvisualsinfo(var_15,(176,240,308),(0,270,0),param_00);
		var_02[var_02.size] = var_15;
		foreach(var_17 in var_02)
		{
			var_18 = var_01.size;
			var_01[var_18] = var_17;
			var_01[var_18].numchevrons = 1;
		}

		return var_01;
	}
}

//Function Number: 30
createvisualsinfo(param_00,param_01,param_02,param_03)
{
	param_00.origin = param_01;
	param_00.angles = param_02;
	return param_00;
}
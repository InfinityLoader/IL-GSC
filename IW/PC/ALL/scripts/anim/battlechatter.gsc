/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\battlechatter.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 173
 * Decompile Time: 8542 ms
 * Timestamp: 10/27/2023 12:00:03 AM
*******************************************************************/

//Function Number: 1
func_9542()
{
	if(isdefined(level.var_3D4B) && level.var_3D4B)
	{
		return;
	}

	setdvarifuninitialized("bcs_enable",1);
	if(getdvarint("bcs_enable") == 0)
	{
		anim.var_3D4B = 0;
		level.player.var_3D4B = 0;
		return;
	}

	anim.var_29B7 = 0;
	anim.var_3D4B = 1;
	level.player.var_3D4B = 0;
	if(!isdefined(level.var_7410))
	{
		level.var_7410 = 1;
	}

	setdvarifuninitialized("bcs_filterThreat","off");
	setdvarifuninitialized("bcs_filterInform","off");
	setdvarifuninitialized("bcs_filterOrder","off");
	setdvarifuninitialized("bcs_filterReaction","off");
	setdvarifuninitialized("bcs_filterResponse","off");
	setdvarifuninitialized("bcs_forceEnglish","0");
	setdvarifuninitialized("bcs_allowsamevoiceresponse","off");
	setdvarifuninitialized("debug_bcprint","off");
	setdvarifuninitialized("debug_bcprintdump","off");
	setdvarifuninitialized("debug_bcprintdumptype","csv");
	setdvarifuninitialized("debug_bcshowqueue","off");
	anim.var_29B1 = "^3***** BCS FAILURE: ";
	anim.var_29B2 = "^3***** BCS WARNING: ";
	func_29C4();
	func_29C2();
	level.var_D3DD["unitednations"] = "1";
	level.var_D3DD["unitednationshelmet"] = "1";
	level.var_D3DD["unitednationsfemale"] = "1";
	level.var_D3DD["unitednationsjackal"] = "1";
	thread func_F7ED();
	func_95E5();
	anim.var_68BB = [];
	level.var_68BB["threat"] = [];
	level.var_68BB["response"] = [];
	level.var_68BB["reaction"] = [];
	level.var_68BB["order"] = [];
	level.var_68BB["inform"] = [];
	level.var_68BB["custom"] = [];
	level.var_68BB["direction"] = [];
	if(isdefined(level.var_1412))
	{
		level.var_68AD["threat"]["self"] = 20000;
		level.var_68AD["threat"]["squad"] = 30000;
	}
	else if(scripts\sp\_utility::func_D123())
	{
		level.var_68AD["threat"]["self"] = 11000;
		level.var_68AD["threat"]["squad"] = 7000;
	}
	else
	{
		level.var_68AD["threat"]["self"] = 9000;
		level.var_68AD["threat"]["squad"] = 5000;
	}

	level.var_68AD["threat"]["location_repeat"] = 15000;
	level.var_68AD["response"]["self"] = 1400;
	level.var_68AD["response"]["squad"] = 1400;
	level.var_68AD["reaction"]["self"] = 1400;
	level.var_68AD["reaction"]["squad"] = 1400;
	level.var_68AD["order"]["self"] = 7000;
	level.var_68AD["order"]["squad"] = 6000;
	level.var_68AD["inform"]["self"] = 4000;
	level.var_68AD["inform"]["squad"] = 6000;
	level.var_68AD["custom"]["self"] = 0;
	level.var_68AD["custom"]["squad"] = 0;
	level.var_68BB["playername"] = -15536;
	level.var_68BB["reaction"]["casualty"] = 14000;
	level.var_68BB["reaction"]["friendlyfire"] = 5000;
	level.var_68BB["reaction"]["takingfire"] = -30536;
	level.var_68BB["reaction"]["maneuver"] = 24000;
	level.var_68BB["reaction"]["movement"] = 24000;
	level.var_68BB["reaction"]["underfire"] = 24000;
	level.var_68BB["reaction"]["danger"] = 14000;
	level.var_68BB["reaction"]["ask_ok"] = 14000;
	level.var_68BB["reaction"]["taunt"] = 25000;
	level.var_68BB["inform"]["reloading"] = 30000;
	level.var_68BB["inform"]["killfirm"] = -25536;
	level.var_68BB["inform"]["attack"] = 9000;
	level.var_68BB["threat"]["acquired"] = 7000;
	level.var_68BB["threat"]["sighted"] = 7000;
	level.var_68BB["reaction"]["maneuver"] = 15000;
	level.var_68BB["reaction"]["underfire"] = 2000;
	level.var_68BB["order"]["action"] = 9000;
	level.var_68BB["response"]["callout"] = 7000;
	level.var_68B5["threat"]["infantry"] = 0.6;
	level.var_68B5["threat"]["vehicle"] = 0.7;
	level.var_68B5["threat"]["sighted"] = 0.6;
	level.var_68B5["threat"]["acquired"] = 0.6;
	level.var_68B5["threat"]["c12"] = 0.7;
	level.var_68B5["response"]["ack"] = 0.9;
	level.var_68B5["response"]["exposed"] = 0.8;
	level.var_68B5["response"]["callout"] = 0.9;
	level.var_68B5["response"]["echo"] = 0.9;
	level.var_68B5["response"]["covering"] = 0.9;
	level.var_68B5["response"]["im"] = 0.9;
	level.var_68B5["reaction"]["casualty"] = 0.5;
	level.var_68B5["reaction"]["friendlyfire"] = 1;
	level.var_68B5["reaction"]["takingfire"] = 1;
	level.var_68B5["reaction"]["maneuver"] = 0.8;
	level.var_68B5["reaction"]["movement"] = 0.8;
	level.var_68B5["reaction"]["underfire"] = 0.8;
	level.var_68B5["reaction"]["danger"] = 0.8;
	level.var_68B5["reaction"]["ask_ok"] = 1;
	level.var_68B5["reaction"]["taunt"] = 0.9;
	level.var_68B5["order"]["action"] = 0.3;
	level.var_68B5["order"]["move"] = 0.3;
	level.var_68B5["order"]["displace"] = 0.5;
	level.var_68B5["inform"]["attack"] = 0.9;
	level.var_68B5["inform"]["incoming"] = 0.9;
	level.var_68B5["inform"]["reloading"] = 0.2;
	level.var_68B5["inform"]["suppressed"] = 0.2;
	level.var_68B5["inform"]["killfirm"] = 0.4;
	level.var_68B5["custom"]["generic"] = 1;
	level.var_68AF["threat"]["infantry"] = 1000;
	level.var_68AF["threat"]["vehicle"] = 1000;
	level.var_68AF["threat"]["sighted"] = 1500;
	level.var_68AF["threat"]["acquired"] = 1500;
	level.var_68AF["threat"]["c12"] = 1000;
	level.var_68AF["response"]["exposed"] = 1000;
	level.var_68AF["response"]["callout"] = 2000;
	level.var_68AF["response"]["echo"] = 2000;
	level.var_68AF["response"]["ack"] = 1000;
	level.var_68AF["response"]["covering"] = 1500;
	level.var_68AF["response"]["im"] = 1500;
	level.var_68AF["reaction"]["casualty"] = 1000;
	level.var_68AF["reaction"]["friendlyfire"] = 1000;
	level.var_68AF["reaction"]["takingfire"] = 1500;
	level.var_68AF["reaction"]["maneuver"] = 1500;
	level.var_68AF["reaction"]["movement"] = 1500;
	level.var_68AF["reaction"]["underfire"] = 1500;
	level.var_68AF["reaction"]["danger"] = 1500;
	level.var_68AF["reaction"]["ask_ok"] = 1500;
	level.var_68AF["reaction"]["taunt"] = 2000;
	level.var_68AF["order"]["action"] = 3000;
	level.var_68AF["order"]["move"] = 3000;
	level.var_68AF["order"]["displace"] = 3000;
	level.var_68AF["inform"]["attack"] = 1000;
	level.var_68AF["inform"]["incoming"] = 1500;
	level.var_68AF["inform"]["reloading"] = 1000;
	level.var_68AF["inform"]["suppressed"] = 2000;
	level.var_68AF["inform"]["killfirm"] = 2000;
	level.var_68AF["custom"]["generic"] = 1000;
	level.var_68AE["response"]["exposed"] = 75;
	level.var_68AE["response"]["reload"] = 50;
	level.var_68AE["response"]["callout"] = 75;
	level.var_68AE["response"]["callout_negative"] = 20;
	level.var_68AE["response"]["order"] = 40;
	level.var_68AE["moveEvent"]["coverme"] = 70;
	level.var_68AE["moveEvent"]["ordertoplayer"] = 10;
	if(scripts\sp\_utility::func_D123())
	{
		anim.var_6BB2 = 9999999;
		anim.var_6BB8 = 2;
		anim.var_6BB7 = 5;
		anim.var_6BB6 = 0.5;
		anim.var_6BB5 = 3;
	}
	else
	{
		anim.var_6BB2 = 620;
		anim.var_6BB8 = 12;
		anim.var_6BB7 = 24;
		anim.var_6BB6 = 2;
		anim.var_6BB5 = 5;
	}

	anim.var_BCD1 = spawn("script_origin",(0,0,0));
	if(!isdefined(level.var_29BD))
	{
		if(scripts\sp\_utility::func_D123())
		{
			level.var_29BD = squared(9999999);
		}
		else
		{
			level.var_29BD = squared(3000);
		}
	}

	if(!isdefined(level.var_29BE))
	{
		if(scripts\sp\_utility::func_D123())
		{
			level.var_29BE = squared(9999999);
		}
		else
		{
			level.var_29BE = squared(5000);
		}
	}

	level.var_8D0F = 96;
	level.var_B75D = 10;
	level.var_B493 = 45;
	level.var_B4A4 = 50;
	scripts\common\bcs_location_trigs::func_29BB();
	anim.var_EF74 = 4000;
	anim.var_29C6 = 3000;
	level.var_10AE0[level.var_10AE0.size] = ::func_9762;
	level.var_10AE1[level.var_10AE1.size] = "::init_squadBattleChatter";
	foreach(var_01 in level.var_115E7)
	{
		level.var_9F9F[var_01] = 0;
		level.var_9F9E[var_01]["threat"] = 0;
		level.var_9F9E[var_01]["order"] = 0;
		level.var_9F9E[var_01]["reaction"] = 0;
		level.var_9F9E[var_01]["response"] = 0;
		level.var_9F9E[var_01]["inform"] = 0;
		level.var_9F9E[var_01]["custom"] = 0;
	}

	func_29C1();
	func_29C3();
	anim.var_AA27 = [];
	anim.var_A9C3 = [];
	anim.var_A9C4 = [];
	foreach(var_01 in level.var_115E7)
	{
		level.var_AA27[var_01] = --15536;
		level.var_A9C3[var_01] = "none";
		level.var_A9C4[var_01] = -100000;
	}

	anim.var_A9C5 = 120000;
	for(var_05 = 0;var_05 < level.var_10AE5.size;var_05++)
	{
		if(isdefined(level.var_10AE5[var_05].var_3D4B) && level.var_10AE5[var_05].var_3D4B)
		{
			continue;
		}

		level.var_10AE5[var_05] func_9762();
	}

	anim.var_117E0 = [];
	level.var_117E0["exposed"] = 25;
	level.var_117E0["sighted"] = 25;
	level.var_117E0["acquired"] = 50;
	level.var_117E0["player_distance"] = 20;
	level.var_117E0["player_obvious"] = 25;
	level.var_117E0["player_contact_clock"] = 25;
	level.var_117E0["player_target_clock"] = 25;
	level.var_117E0["player_target_clock_high"] = 25;
	level.var_117E0["player_cardinal"] = 20;
	level.var_117E0["ai_distance"] = 25;
	level.var_117E0["ai_obvious"] = 25;
	level.var_117E0["ai_contact_clock"] = 20;
	level.var_117E0["ai_casual_clock"] = 20;
	level.var_117E0["ai_target_clock"] = 20;
	level.var_117E0["ai_target_clock_high"] = 25;
	level.var_117E0["ai_cardinal"] = 10;
	level.var_117E0["concat_location"] = 90;
	level.var_117E0["player_location"] = 90;
	level.var_117E0["ai_location"] = 100;
	level.var_117E0["generic_location"] = 95;
	anim.var_AA28 = [];
	anim.var_AA29 = [];
	foreach(var_01 in level.var_115E7)
	{
		level.var_AA28[var_01] = undefined;
		level.var_AA29[var_01] = undefined;
	}

	if(scripts\sp\_utility::func_D123())
	{
		anim.var_115EE = 300000;
	}
	else
	{
		anim.var_115EE = 120000;
	}

	level notify("battlechatter initialized");
	anim notify("battlechatter initialized");
}

//Function Number: 2
func_29C4()
{
	if(!isdefined(level.var_115E7))
	{
		anim.var_115E7 = [];
		level.var_115E7[level.var_115E7.size] = "axis";
		level.var_115E7[level.var_115E7.size] = "allies";
		level.var_115E7[level.var_115E7.size] = "team3";
		level.var_115E7[level.var_115E7.size] = "neutral";
	}
}

//Function Number: 3
func_29C2()
{
	if(!isdefined(level.var_13075))
	{
		anim.var_13075 = [];
		anim.var_6EED = [];
		anim.var_46BD = [];
		func_29C5("unitednations","UN",6,1);
		func_29C5("unitednationshelmet","UN",6,1);
		func_29C5("unitednationsfemale","UN",3,1);
		func_29C5("unitednationsjackal","JK",3,1);
		func_29C5("setdef","SD",5);
		func_29C5("c6","C6",1);
	}
}

//Function Number: 4
func_29C5(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	level.var_13075[param_00] = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		level.var_13075[param_00][var_04] = spawnstruct();
		level.var_13075[param_00][var_04].var_C1 = 0;
		level.var_13075[param_00][var_04].var_C19D = "" + var_04;
	}

	level.var_46BD[param_00] = param_01;
	level.var_6EED[param_00] = param_03;
}

//Function Number: 5
func_29C1()
{
	func_29C4();
	if(!isdefined(level.var_28CF))
	{
		level.var_28CF = [];
		foreach(var_01 in level.var_115E7)
		{
			scripts\sp\_utility::func_F2DC(var_01,0);
		}
	}
}

//Function Number: 6
func_29C3()
{
	func_29C4();
	if(!isdefined(level.var_6EE9))
	{
		level.var_6EE9 = [];
		foreach(var_01 in level.var_115E7)
		{
			level.var_6EE9[var_01] = 0;
		}
	}
}

//Function Number: 7
func_95E5()
{
	level.var_6EE9["unitednations"] = [];
	var_00 = 41;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_6EE9["unitednations"][var_01] = scripts\sp\_utility::func_11145(var_01 + 1);
	}

	level.var_6EE9["unitednationshelmet"] = [];
	var_00 = 41;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_6EE9["unitednationshelmet"][var_01] = scripts\sp\_utility::func_11145(var_01 + 1);
	}

	level.var_6EE9["unitednationsfemale"] = [];
	var_00 = 41;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_6EE9["unitednationsfemale"][var_01] = scripts\sp\_utility::func_11145(var_01 + 1);
	}

	level.var_6EE9["unitednationsjackal"] = [];
	var_00 = 13;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_6EE9["unitednationsjackal"][var_01] = scripts\sp\_utility::func_11145(var_01 + 1);
	}

	anim.var_6EEC = [];
}

//Function Number: 8
func_10179()
{
	anim.var_46BD = undefined;
	anim.var_68BB = undefined;
	anim.var_68AD = undefined;
	anim.var_68BB = undefined;
	anim.var_68B5 = undefined;
	anim.var_68AF = undefined;
	anim.var_BCD1 = undefined;
	anim.var_EF74 = undefined;
	anim.var_29C6 = undefined;
	anim.var_AECC = undefined;
	anim.var_13075 = undefined;
	anim.var_6EEC = undefined;
	anim.var_AA28 = undefined;
	anim.var_AA29 = undefined;
	anim.var_A9C5 = undefined;
	anim.var_A9C3 = undefined;
	anim.var_A9C4 = undefined;
	anim.var_3D4B = 0;
	level.player.var_3D4B = 0;
	level.var_28CF = undefined;
	anim.var_29BC = undefined;
	for(var_00 = 0;var_00 < level.var_10AE0.size;var_00++)
	{
		if(level.var_10AE1[var_00] != "::init_squadBattleChatter")
		{
			continue;
		}

		if(var_00 != level.var_10AE0.size - 1)
		{
			level.var_10AE0[var_00] = level.var_10AE0[level.var_10AE0.size - 1];
			level.var_10AE1[var_00] = level.var_10AE1[level.var_10AE1.size - 1];
		}

		level.var_10AE0[level.var_10AE0.size - 1] = undefined;
		level.var_10AE1[level.var_10AE1.size - 1] = undefined;
	}

	level notify("battlechatter disabled");
	anim notify("battlechatter disabled");
}

//Function Number: 9
func_9762()
{
	var_00 = self;
	var_00.var_C242 = 0;
	var_00.var_B4C8 = 1;
	var_00.var_BFA8 = gettime() + 50;
	var_00.var_BFA9["threat"] = gettime() + 50;
	var_00.var_BFA9["order"] = gettime() + 50;
	var_00.var_BFA9["reaction"] = gettime() + 50;
	var_00.var_BFA9["response"] = gettime() + 50;
	var_00.var_BFA9["inform"] = gettime() + 50;
	var_00.var_BFA9["custom"] = gettime() + 50;
	var_00.var_BFB4["threat"] = [];
	var_00.var_BFB4["order"] = [];
	var_00.var_BFB4["reaction"] = [];
	var_00.var_BFB4["response"] = [];
	var_00.var_BFB4["inform"] = [];
	var_00.var_BFB4["custom"] = [];
	var_00.var_9E9B["threat"] = 0;
	var_00.var_9E9B["order"] = 0;
	var_00.var_9E9B["reaction"] = 0;
	var_00.var_9E9B["response"] = 0;
	var_00.var_9E9B["inform"] = 0;
	var_00.var_9E9B["custom"] = 0;
	var_00.var_A975 = "";
	var_00.var_B659[var_00.var_B659.size] = ::scripts\anim\battlechatter_ai::func_185D;
	var_00.var_B65F[var_00.var_B65F.size] = ::scripts\anim\battlechatter_ai::func_E11B;
	var_00.var_10AFD[var_00.var_10AFD.size] = ::func_97EE;
	var_00.var_6BB3 = 1;
	var_00.var_6BB4 = undefined;
	for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
	{
		var_00 thread func_97EE(level.var_10AE5[var_01].var_10AEE);
	}

	var_00 thread scripts\anim\battlechatter_ai::func_10AFB();
	var_00 thread scripts\anim\battlechatter_ai::func_10AE7();
	var_00 thread func_10AE2();
	var_00.var_3D4B = 1;
	var_00 notify("squad chat initialized");
}

//Function Number: 10
func_10182()
{
	var_00 = self;
	var_00.var_C242 = undefined;
	var_00.var_B4C8 = undefined;
	var_00.var_BFA8 = undefined;
	var_00.var_BFA9 = undefined;
	var_00.var_BFB4 = undefined;
	var_00.var_9E9B = undefined;
	var_00.var_6BB3 = undefined;
	var_00.var_6BB4 = undefined;
	for(var_01 = 0;var_01 < var_00.var_B659.size;var_01++)
	{
		var_00.var_B659[var_01] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.var_B65F.size;var_01++)
	{
		var_00.var_B660[var_01] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.var_10AFD.size;var_01++)
	{
		var_00.var_10AFD[var_01] = undefined;
	}

	for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
	{
		var_00 func_10183(level.var_10AE5[var_01].var_10AEE);
	}

	var_00.var_3D4B = 0;
}

//Function Number: 11
func_29CA()
{
	if(isdefined(level.var_3D4B))
	{
		return level.var_3D4B;
	}

	return 0;
}

//Function Number: 12
func_29C9()
{
	var_00 = getdvarint("bcs_enable");
	for(;;)
	{
		var_01 = getdvarint("bcs_enable");
		if(var_01 != var_00)
		{
			switch(var_01)
			{
				case 1:
					if(!level.var_3D4B)
					{
						func_6260();
					}
					break;
	
				case 0:
					if(level.var_3D4B)
					{
						func_55B4();
					}
					break;
			}

			var_00 = var_01;
		}

		wait(1);
	}
}

//Function Number: 13
func_6260()
{
	func_9542();
	level.player thread scripts\anim\battlechatter_ai::func_185D();
	var_00 = function_0072();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] scripts\anim\battlechatter_ai::func_185D();
	}
}

//Function Number: 14
func_55B4()
{
	if(!isdefined(level.var_3D4B))
	{
		return;
	}

	func_10179();
	var_00 = function_0072();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].var_10AC8) && var_00[var_01].var_10AC8.var_3D4B)
		{
			var_00[var_01].var_10AC8 func_10182();
		}

		var_00[var_01] scripts\anim\battlechatter_ai::func_E11B();
	}
}

//Function Number: 15
func_F7ED(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		level.player.var_29AE = param_00;
		level.player.var_29A3 = param_01;
		return;
	}

	while(!isdefined(level.var_37E7))
	{
		wait(0.1);
	}

	var_02 = level.var_37E7;
	var_03 = level.var_D3DD[var_02];
	var_04 = level.var_46BD[var_02];
	if(isdefined(var_03))
	{
		level.player.var_29AE = var_03;
	}

	if(isdefined(var_04))
	{
		level.player.var_29A3 = var_04;
	}
}

//Function Number: 16
func_CEE8(param_00)
{
	if(!isalive(self))
	{
		return;
	}

	if(!isdefined(self.team))
	{
		return;
	}

	if(!func_29CA())
	{
		return;
	}

	if(isdefined(self.var_117C) && self.var_117C > 0)
	{
		return;
	}

	if(isdefined(self.var_9F6B) && self.var_9F6B)
	{
		return;
	}

	if(!isdefined(self.team) || isdefined(self.team) && self.team == "allies" && isdefined(level.var_EF75))
	{
		if(level.var_EF75 + level.var_EF74 > gettime())
		{
			return;
		}
	}

	if(func_740F())
	{
		return;
	}

	if(!isdefined(self.var_28CF) || !self.var_28CF)
	{
		return;
	}

	if(!isdefined(self.team) || isdefined(self.team) && self.team == "allies" && getdvarint("bcs_forceEnglish",0))
	{
		return;
	}

	if(level.var_9F9F[self.team])
	{
		return;
	}

	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = func_7EFE();
	}

	if(isdefined(self.var_299A))
	{
		param_00 = self.var_299A;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(self.var_B55B))
	{
		if(isdefined(self.var_B55B.var_9904))
		{
			if(self.var_B55B.var_9904)
			{
				return;
			}
		}
	}

	if(self == level.player)
	{
		if(!isdefined(level.player.var_28CF) || isdefined(level.player.var_28CF) && !level.player.var_28CF)
		{
			return;
		}

		if(scripts\common\utility::func_D11B())
		{
			var_01 = level.player scripts\sp\_utility::func_7B9D();
			if(var_01 < 0.3)
			{
				return;
			}
		}

		if(!isdefined(level.player.var_29C8) || level.player.var_29C8 != 0)
		{
			return;
		}
		else
		{
			level notify("player_battlechatter_refresh");
		}
	}

	switch(param_00)
	{
		case "custom":
			thread func_CF0A();
			break;

		case "response":
			thread func_D50A();
			break;

		case "order":
			thread func_D4EB();
			break;

		case "threat":
			thread func_D54B();
			break;

		case "reaction":
			thread func_D503();
			break;

		case "inform":
			thread func_D4A3();
			break;
	}
}

//Function Number: 17
func_D54B()
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("cancel speaking");
	self.var_4B1F = self.var_3D4C["threat"];
	var_00 = self.var_3D4C["threat"].var_117B9;
	if(!isalive(var_00))
	{
		return;
	}

	if(func_117ED(var_00) && !isplayer(var_00))
	{
		return;
	}

	anim thread func_AEEB(self,"threat");
	var_01 = 0;
	var_02 = self.var_3D4C["threat"].var_68BA;
	switch(var_02)
	{
		case "infantry":
			if((scripts\common\utility::func_D11B() && var_00 == level.player) || !var_00 scripts\anim\battlechatter_ai::func_1A1B() && isplayer(var_00) || (!var_00 scripts\anim\battlechatter_ai::func_1A1B() && !isdefined(var_00 method_8164())) || var_00 scripts\anim\battlechatter_ai::func_1A1B())
			{
				if(isdefined(self.var_1198))
				{
					self.var_1198.var_28DE = var_00;
				}
	
				var_01 = func_117E4(var_00,undefined);
			}
			else
			{
			}
			break;

		case "acquired":
		case "vehicle":
			self.var_3778 = var_02;
			var_01 = func_117E4(var_00,undefined);
			break;

		case "sighted":
			self.var_3778 = var_02;
			var_01 = func_117E4(var_00,undefined);
			break;
	}

	var_03 = self;
	var_03 notify("done speaking");
	if(!var_01)
	{
		return;
	}

	if(!isalive(var_00))
	{
		return;
	}

	var_00.var_376A[var_03.var_10AC8.var_10AEE] = spawnstruct();
	var_00.var_376A[var_03.var_10AC8.var_10AEE].var_10A9F = var_03;
	var_00.var_376A[var_03.var_10AC8.var_10AEE].var_117EC = var_03.var_3D4C["threat"].var_68BA;
	var_00.var_376A[var_03.var_10AC8.var_10AEE].var_698B = gettime() + level.var_29C6;
	if(isdefined(var_00.var_10AC8))
	{
		var_03.var_10AC8.var_10AE9[var_00.var_10AC8.var_10AEE].var_376A = 1;
	}
}

//Function Number: 18
func_117ED(param_00)
{
	if(isdefined(param_00.var_376A) && isdefined(param_00.var_376A[self.var_10AC8.var_10AEE]))
	{
		if(param_00.var_376A[self.var_10AC8.var_10AEE].var_698B > gettime())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
func_117E4(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = func_4996();
	var_02.var_B3D1 = 1;
	var_02.var_117E3 = param_00;
	var_03 = func_81C4(param_00);
	if(!isdefined(var_03) || isdefined(var_03) && !isdefined(var_03.type))
	{
		return 0;
	}

	var_04 = undefined;
	if(isdefined(self.var_3778))
	{
		var_04 = self.var_3778;
	}
	else
	{
		var_04 = var_03.type;
	}

	switch(var_04)
	{
		case "exposed":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = var_03.var_E29B;
			}
	
			var_05 = func_582F(var_03.var_E29B);
			var_06 = self;
			if(var_05 && var_06 func_3903(var_03.var_E29B))
			{
				var_02 func_17F2(var_03.var_E29B.var_29AD);
				var_02.var_299D = var_03.var_E29B;
			}
	
			var_02 func_117E6(param_00);
			if(var_05)
			{
				if(randomint(100) < level.var_68AE["response"]["callout_negative"])
				{
					var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("callout","neg",self,0.9);
				}
				else
				{
					var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("exposed","acquired",self,0.9);
				}
			}
			break;

		case "acquired":
			var_02 func_180F();
			var_02 func_1837("acquired",var_03.var_D371);
			break;

		case "sighted":
			var_02 func_180F();
			var_02 func_1837("sighted",var_03.var_D371);
			break;

		case "player_obvious":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = level.player;
			}
	
			var_02 func_180F();
			var_02 func_1841();
			break;

		case "player_distance":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = level.player;
			}
	
			if(scripts\common\utility::func_D11B() && level.player == level.var_D127 && param_00 scripts\anim\battlechatter_ai::func_1A1B())
			{
				var_07 = func_7E7D(level.var_D127.origin,param_00.origin);
			}
			else
			{
				var_07 = func_7E7B(level.player.origin,param_01.origin);
			}
	
			var_02 func_180F();
			var_02 func_183D(var_07);
			break;

		case "player_contact_clock":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_180F();
			var_02 func_1837("contactclock",var_03.var_D371);
			break;

		case "player_target_clock":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_180F();
			var_02 func_1837("targetclock",var_03.var_D371);
			break;

		case "player_target_clock_high":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_180F();
			var_08 = func_7E69(level.player.origin,param_00.origin);
			if(var_08 >= 20 && var_08 <= 50)
			{
				var_02 func_1837("targetclock",var_03.var_D371);
				var_02 func_183E(var_08);
			}
			else
			{
				return 0;
			}
			break;

		case "player_cardinal":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_180F();
			var_09 = func_7E74(level.player.origin,param_00.origin);
			var_0A = func_C098(var_09);
			if(var_0A == "impossible")
			{
				return 0;
			}
	
			var_02 func_1837("cardinal",var_0A);
			break;

		case "ai_obvious":
			if(isdefined(var_03.var_E29B) && func_3903(var_03.var_E29B))
			{
				var_02 func_17F2(var_03.var_E29B.var_29AD);
				var_02.var_299D = var_03.var_E29B;
			}
	
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_1841();
			var_02 func_17B2(self,var_03,param_00);
			break;

		case "ai_distance":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
			else if(isdefined(var_03.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"])
			{
				var_0B = var_03.var_E29B;
			}
	
			if(var_0B scripts\anim\battlechatter_ai::func_1A1B() && param_00 scripts\anim\battlechatter_ai::func_1A1B())
			{
				var_07 = func_7E7D(var_0B.origin,param_00.origin);
			}
			else if(scripts\common\utility::func_D11B() && var_07 == level.var_D127 && param_01 scripts\anim\battlechatter_ai::func_1A1B())
			{
				var_07 = func_7E7D(var_07.origin,param_01.origin);
			}
			else
			{
				var_07 = func_7E7B(var_07.origin,param_01.origin);
			}
	
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_02 func_183D(var_07);
			var_02 func_17B2(self,var_03,param_00);
			break;

		case "ai_contact_clock":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
			else if(isdefined(var_03.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"])
			{
				var_0B = var_03.var_E29B;
			}
	
			var_0C = func_80E5(var_0B);
			var_0D = func_7E75(var_0C,var_0B.origin,param_00.origin);
			var_02 func_1837("contactclock",var_0D);
			var_02 func_17B2(self,var_03,param_00);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "ai_casual_clock":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
			else if(isdefined(var_03.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"])
			{
				var_0B = var_03.var_E29B;
			}
	
			var_0C = func_80E5(var_0B);
			var_0D = func_7E75(var_0C,var_0B.origin,param_00.origin);
			var_02 func_1837("casualclock",var_0D);
			var_02 func_17B2(self,var_03,param_00);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "ai_target_clock":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
			else if(isdefined(var_03.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"])
			{
				var_0B = var_03.var_E29B;
			}
	
			var_0C = func_80E5(var_0B);
			var_0D = func_7E75(var_0C,var_0B.origin,param_00.origin);
			var_02 func_1837("targetclock",var_0D);
			var_02 func_17B2(self,var_03,param_00);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "ai_target_clock_high":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
			else if(isdefined(var_03.var_E29B) && randomint(100) < level.var_68AE["response"]["callout"])
			{
				var_0B = var_03.var_E29B;
			}
	
			var_0C = func_80E5(var_0B);
			var_0D = func_7E75(var_0C,var_0B.origin,param_00.origin);
			var_08 = func_7E69(var_0B.origin,param_00.origin);
			if(var_08 >= 20 && var_08 <= 50)
			{
				var_02 func_1837("targetclock",var_0D);
				var_02 func_183E(var_08);
			}
			else
			{
				return 0;
			}
	
			var_02 func_17B2(self,var_03,param_00);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "ai_cardinal":
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
	
			var_09 = func_7E74(var_0B.origin,param_00.origin);
			var_0A = func_C098(var_09);
			if(var_0A == "impossible")
			{
				return 0;
			}
	
			var_02 func_1837("cardinal",var_0A);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "generic_location":
			var_06 = self;
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
	
			var_0E = var_02 func_117E5(var_03,undefined,var_06);
			if(!var_0E)
			{
				return 0;
			}
			break;

		case "player_location":
			var_06 = self;
			var_02 func_180F();
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = level.player;
			}
	
			var_0E = var_02 func_117E5(var_03,undefined,var_06);
			if(!var_0E)
			{
				return 0;
			}
			break;

		case "concat_location":
			var_02 func_17BE(param_00);
			var_06 = self;
			var_0B = self;
			if(self.team == "allies")
			{
				var_0B = level.player;
			}
	
			var_0E = var_02 func_117E5(var_03,1,var_06);
			if(!var_0E)
			{
				return 0;
			}
	
			var_02 func_17BD(var_0B,param_00);
			var_02 func_17B2(self,var_03,param_00);
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;

		case "ai_location":
			var_06 = self;
			if(var_06 func_3903(var_03.var_E29B))
			{
				var_02 func_17F2(var_03.var_E29B.var_29AD);
				var_02.var_299D = var_03.var_E29B;
			}
	
			var_0E = var_02 func_117E5(var_03,undefined,var_06);
			if(!var_0E)
			{
				return 0;
			}
	
			var_0F = var_02.var_10476.size - 1;
			var_10 = var_02.var_10476[var_0F];
			if(func_9D7C(var_10))
			{
				var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("callout","echo",self,0.9,var_10);
			}
			else if(func_9D7B(var_10,self))
			{
				var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("callout","QA",self,0.9,var_10,var_03.var_AEC4);
			}
			else if(randomint(100) < level.var_68AE["response"]["callout_negative"])
			{
				var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("callout","neg",self,0.9);
			}
			else
			{
				var_03.var_E29B scripts\anim\battlechatter_ai::func_1820("exposed","acquired",self,0.9);
			}
	
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = param_00;
			}
			break;
	}

	func_F77C(var_03.type);
	var_06 = self;
	if(isdefined(self.var_1198))
	{
		self.var_1198.var_28D6 = 0;
	}

	var_06 func_D4F8(var_02,self);
	if(isdefined(self.var_1198))
	{
		self.var_1198.var_28D0 = undefined;
		self.var_1198.var_28DE = undefined;
	}

	return 1;
}

//Function Number: 20
func_582F(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.var_46BC != "UN")
	{
		return 0;
	}

	if(randomint(100) > level.var_68AE["response"]["exposed"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_117E5(param_00,param_01,param_02)
{
	var_03 = func_183A(param_00.var_AEC4,param_01,param_02);
	return var_03;
}

//Function Number: 22
func_17B2(param_00,param_01,param_02)
{
	if(!isdefined(param_01.var_E29B))
	{
		return;
	}

	if(param_01.var_E29B.team != param_00.team)
	{
		return;
	}

	if(randomint(100) > level.var_68AE["response"]["callout"])
	{
		return;
	}

	var_03 = "affirm";
	if(!param_01.var_E29B scripts\anim\battlechatter_ai::func_29A2(param_02) && randomint(100) < level.var_68AE["response"]["callout_negative"])
	{
		var_03 = "neg";
	}

	param_01.var_E29B scripts\anim\battlechatter_ai::func_1820("callout",var_03,param_00,0.9);
}

//Function Number: 23
func_81C4(param_00)
{
	var_01 = param_00 func_81F7(self);
	var_02 = func_7E75(self.angles,self.origin,param_00.origin);
	var_03 = func_80EA(64,1024,"response");
	var_04 = undefined;
	if(isdefined(var_03))
	{
		var_04 = func_7E75(var_03.angles,var_03.origin,param_00.origin);
	}

	var_05 = func_7E75(level.player.angles,level.player.origin,param_00.origin);
	if(self.team == "allies")
	{
		var_06 = var_05;
		var_07 = level.player;
	}
	else if(isdefined(var_05))
	{
		var_06 = var_06;
		var_07 = var_04;
	}
	else
	{
		var_06 = var_04;
		var_07 = self;
	}

	var_08 = func_7E7A(var_07.origin,param_00.origin);
	self.var_D6B2 = [];
	if(!isdefined(var_01) && param_00 func_9DE8(0))
	{
		func_1812("exposed");
	}

	if(self.team == "allies")
	{
		var_09 = 0;
		if(param_00.origin[2] - var_07.origin[2] >= level.var_8D0F)
		{
			if(func_1812("player_target_clock_high"))
			{
				var_09 = 1;
			}
		}

		if(!var_09)
		{
			if(var_06 == "12")
			{
				func_1812("player_obvious");
				if(var_08 > level.var_B75D && var_08 < level.var_B493)
				{
					func_1812("player_distance");
				}
			}

			if(func_3904() && var_06 != "12")
			{
				func_1812("player_contact_clock");
				func_1812("player_target_clock");
				func_1812("player_cardinal");
			}
		}
	}

	var_09 = 0;
	if(param_00.origin[2] - var_07.origin[2] >= level.var_8D0F)
	{
		if(func_1812("ai_target_clock_high"))
		{
			var_09 = 1;
		}
	}

	func_1812("ai_casual_clock");
	if(!var_09)
	{
		if(var_06 == "12")
		{
			func_1812("ai_distance");
			if(var_08 > level.var_B75D && var_08 < level.var_B493)
			{
				func_1812("ai_obvious");
			}
		}

		func_1812("ai_contact_clock");
		func_1812("ai_target_clock");
		func_1812("ai_cardinal");
	}

	if(isdefined(var_01))
	{
		if(func_3896(var_01))
		{
			func_1812("concat_location");
		}
		else if(isdefined(var_01 func_7E18(self)))
		{
			if(isdefined(var_03))
			{
				func_1812("ai_location");
			}
			else
			{
				if(func_3904())
				{
					func_1812("player_location");
				}

				func_1812("generic_location");
			}
		}
		else
		{
			if(isdefined(var_03))
			{
				func_1812("ai_location");
			}

			if(func_3904() || isdefined(self.var_C80C))
			{
				func_1812("player_location");
			}

			func_1812("generic_location");
		}
	}

	if(!self.var_D6B2.size)
	{
		return undefined;
	}

	var_0B = func_823E(self.var_D6B2,level.var_117E0);
	var_0C = spawnstruct();
	var_0C.type = var_0B;
	var_0C.var_E29B = var_03;
	var_0C.var_E29C = var_04;
	var_0C.var_D371 = var_05;
	if(isdefined(var_01))
	{
		var_0C.var_AEC4 = var_01;
	}

	return var_0C;
}

//Function Number: 24
func_3878(param_00)
{
	foreach(var_02 in param_00.var_AECB)
	{
		var_03 = func_7F7F("callout_loc_" + var_02);
		var_04 = func_80A3(var_02,0);
		var_05 = func_7F7F("concat_loc_" + var_02);
		var_06 = soundexists(var_03) || soundexists(var_04) || soundexists(var_05);
		if(var_06)
		{
			return var_06;
		}
	}

	return 0;
}

//Function Number: 25
func_3896(param_00)
{
	var_01 = param_00.var_AECB;
	foreach(var_03 in var_01)
	{
		if(func_9D7A(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
func_7E18(param_00)
{
	var_01 = undefined;
	var_02 = self.var_AECB;
	foreach(var_04 in var_02)
	{
		if(func_9D7B(var_04,param_00) && !isdefined(self.var_DB40))
		{
			var_01 = var_04;
			break;
		}

		if(func_9D7C(var_04))
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 27
func_9D7C(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 28
func_9D7A(param_00,param_01)
{
	var_02 = param_01 func_7F7F("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_9D7B(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 func_80A3(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_7F7F(param_00)
{
	var_01 = undefined;
	if(self == level.player)
	{
		var_01 = "UN_plr_";
		var_01 = var_01 + param_00;
	}
	else
	{
		var_01 = self.var_46BC + "_" + self.var_C19D + "_";
		var_01 = var_01 + param_00;
	}

	return var_01;
}

//Function Number: 31
func_80A3(param_00,param_01)
{
	var_02 = func_7F7F("callout_loc_" + param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 32
func_17A2(param_00)
{
	self.var_1C8B[self.var_1C8B.size] = param_00;
}

//Function Number: 33
func_1812(param_00)
{
	var_01 = 0;
	if(isdefined(self.var_1C8B))
	{
		foreach(var_03 in self.var_1C8B)
		{
			if(var_03 == param_00)
			{
				if(!func_3783(param_00))
				{
					var_01 = 1;
				}

				break;
			}
		}
	}

	if(!var_01)
	{
		return var_01;
	}

	self.var_D6B2[self.var_D6B2.size] = param_00;
	return var_01;
}

//Function Number: 34
func_3783(param_00)
{
	if(!isdefined(level.var_AA28[self.team]))
	{
		return 0;
	}

	if(!isdefined(level.var_AA29[self.team]))
	{
		return 0;
	}

	var_01 = level.var_AA28[self.team];
	var_02 = level.var_AA29[self.team];
	var_03 = level.var_115EE;
	if(isdefined(self.var_12BA4) && self.var_12BA4 != "c6")
	{
		if(param_00 == var_01 && gettime() - var_02 < var_03)
		{
			return 1;
		}
	}
	else
	{
		return 0;
	}

	return 0;
}

//Function Number: 35
func_F77C(param_00)
{
	level.var_AA28[self.team] = param_00;
	level.var_AA29[self.team] = gettime();
}

//Function Number: 36
func_823E(param_00,param_01)
{
	var_02 = undefined;
	var_03 = -1;
	foreach(var_05 in param_00)
	{
		if(param_01[var_05] <= 0)
		{
			continue;
		}

		var_06 = randomint(param_01[var_05]);
		if(isdefined(var_02) && param_01[var_02] >= 100)
		{
			if(param_01[var_05] < 100)
			{
				continue;
			}

			continue;
		}

		if(param_01[var_05] >= 100)
		{
			var_02 = var_05;
			var_03 = var_06;
			continue;
		}

		if(var_06 > var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 37
func_117E6(param_00)
{
	var_01 = [];
	var_01 = scripts\common\utility::array_add(var_01,"open");
	var_01 = scripts\common\utility::array_add(var_01,"breaking");
	var_01 = scripts\common\utility::array_add(var_01,"generic");
	if(self.var_222.team == "allies")
	{
		var_01 = scripts\common\utility::array_add(var_01,"movement");
		var_02 = function_0073("axis");
		if(var_02 > 2)
		{
			var_01 = scripts\common\utility::array_add(var_01,"group");
		}
	}

	var_03 = var_01[randomint(var_01.size)];
	func_1840(var_03);
}

//Function Number: 38
func_D503()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_4B1F = self.var_3D4C["reaction"];
	var_00 = self.var_3D4C["reaction"].var_DD60;
	var_01 = self.var_3D4C["reaction"].var_B92F;
	anim thread func_AEEB(self,"reaction");
	if(isdefined(self.var_1198))
	{
		self.var_1198.var_28D0 = undefined;
	}

	var_02 = self.var_3D4C["reaction"].var_68BA;
	switch(var_02)
	{
		case "danger":
		case "underfire":
		case "movement":
		case "maneuver":
			func_DD50(var_00,var_01,var_02);
			break;

		case "casualty":
			func_DD4E(var_00,var_01,var_02);
			break;

		case "taunt":
			func_DD53(var_00,var_01,var_02);
			break;

		case "friendlyfire":
			func_DD4F(var_00,var_01,var_02);
			break;

		case "takingfire":
			func_DD52(var_00,var_01,var_02);
			if(scripts\common\utility::func_4347())
			{
				var_03 = func_80EA(64,1024,"response");
				if(isdefined(var_03))
				{
					if(scripts\common\utility::func_4347())
					{
						if(var_03 func_3902("reaction","ask_ok",1,undefined))
						{
							var_03 scripts\anim\battlechatter_ai::func_181C("ask_ok",undefined,self,1);
						}
					}
					else
					{
						var_03 scripts\anim\battlechatter_ai::func_1820("covering","fire",self,1);
					}
				}
			}
			break;

		case "ask_ok":
			func_E2A4(var_00,"ask","ok");
			var_03 = func_80EA(64,1024,"response");
			if(isdefined(var_03))
			{
				var_03 scripts\anim\battlechatter_ai::func_1820("im","ok",self,1);
			}
			break;
	}

	if(isdefined(self.var_1198))
	{
		self.var_1198.var_28D0 = undefined;
	}

	self notify("done speaking");
}

//Function Number: 39
func_DD50(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	var_03 endon("removed from battleChatter");
	if(!isdefined(param_01) && !scripts\sp\_utility::func_D123())
	{
		param_01 = "generic";
	}

	var_04 = var_03 func_4996();
	var_04 func_181B(param_02,param_01);
	var_03 func_D4F8(var_04,self);
	wait(randomfloatrange(0.25,0.5));
	if(scripts\common\utility::func_4347())
	{
		var_05 = var_03 func_80EA(64,100000,"order");
		if(isdefined(var_05))
		{
			if(var_05 func_3902("order","action",0.9))
			{
				var_06 = scripts\common\utility::random(["dive","pullup","break_generic","break_right","break_left"]);
				var_05 scripts\anim\battlechatter_ai::func_1809("action",var_06,var_03,0.9);
				return;
			}
		}
	}
}

//Function Number: 40
func_DD4E(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	var_03 endon("removed from battleChatter");
	var_04 = var_03 func_4996();
	var_04 func_181B("casualty","generic");
	var_03 func_D4F8(var_04,self);
}

//Function Number: 41
func_DD53(param_00,param_01,param_02)
{
	var_03 = self;
	self endon("death");
	self endon("removed from battleChatter");
	var_04 = var_03 func_4996();
	if(isdefined(param_01) && param_01 == "hostileburst")
	{
		var_04 func_17CF();
	}
	else
	{
		var_04 func_1834("taunt","generic");
	}

	var_03 func_D4F8(var_04,self);
}

//Function Number: 42
func_DD4F(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	var_03 endon("removed from battleChatter");
	var_04 = var_03 func_4996();
	var_04 func_17BB();
	var_03 func_D4F8(var_04,self);
}

//Function Number: 43
func_DD52(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	var_03 endon("removed from battleChatter");
	var_04 = var_03 func_4996();
	var_04 func_1832();
	var_03 func_D4F8(var_04,self);
}

//Function Number: 44
func_E2A4(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	var_03 endon("removed from battleChatter");
	var_04 = var_03 func_4996();
	var_04 func_181F(param_01,param_02);
	var_03 func_D4F8(var_04,self);
}

//Function Number: 45
func_D50A()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_4B1F = self.var_3D4C["response"];
	var_00 = self.var_3D4C["response"].var_B92F;
	var_01 = self.var_3D4C["response"].var_E29D;
	if(!isalive(var_01) || func_9B42(var_01))
	{
		return;
	}

	if(self.var_3D4C["response"].var_B92F == "follow" && self.var_1491.var_10E19 != "move")
	{
		return;
	}

	anim thread func_AEEB(self,"response");
	switch(self.var_3D4C["response"].var_68BA)
	{
		case "exposed":
			func_E2A6(var_01,var_00);
			break;

		case "callout":
			func_E2A5(var_01,var_00,self.var_10C);
			break;

		case "ack":
			func_E2A2(var_01,var_00);
			break;

		default:
			func_E2A2(var_01,var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 46
func_E2A6(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	var_02 endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_03 = var_02 func_4996();
	var_03 func_1840(param_01);
	var_03.var_299D = param_00;
	var_03.var_B3D1 = 1;
	var_02 func_D4F8(var_03,self);
}

//Function Number: 47
func_E2A5(param_00,param_01,param_02)
{
	var_03 = self.var_4B1F.var_E1A1;
	var_04 = self.var_4B1F.var_AEC4;
	var_05 = self;
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_06 = var_05 func_4996();
	var_07 = 0;
	if(param_01 == "echo")
	{
		var_07 = var_06 func_1838(var_03,param_00);
	}
	else if(param_01 == "QA")
	{
		var_07 = var_06 func_183B(param_00,var_03,var_04);
	}
	else
	{
		var_07 = var_06 func_183C(param_01,param_02);
	}

	if(!var_07)
	{
		return;
	}

	var_06.var_299D = param_00;
	var_06.var_B3D1 = 1;
	var_05 func_D4F8(var_06,self);
}

//Function Number: 48
func_E2A2(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = self.var_3D4C["response"].var_68BA;
	var_03 = self;
	var_04 = var_03 func_4996();
	var_04 func_181F(var_02,param_01);
	var_04.var_299D = param_00;
	var_04.var_B3D1 = 1;
	var_03 func_D4F8(var_04,self);
}

//Function Number: 49
func_D4EB()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_4B1F = self.var_3D4C["order"];
	var_00 = self.var_3D4C["order"].var_B92F;
	var_01 = self.var_3D4C["order"].var_C6E5;
	anim thread func_AEEB(self,"order");
	switch(self.var_3D4C["order"].var_68BA)
	{
		case "action":
			if(isdefined(self.var_1198))
			{
				self.var_1198.var_28DE = level.player;
			}
	
			func_C6E1(var_00,var_01);
			break;

		case "move":
			func_C6E3(var_00,var_01);
			break;

		case "displace":
			func_C6E2(var_00);
			break;
	}

	if(isdefined(self.var_1198))
	{
		self.var_1198.var_28D0 = undefined;
		self.var_1198.var_28DE = undefined;
	}

	self notify("done speaking");
}

//Function Number: 50
func_C6E1(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	var_02 endon("removed from battleChatter");
	var_03 = var_02 func_4996();
	if(!scripts\sp\_utility::func_D123())
	{
		var_02 func_128A8(var_03,param_01);
	}

	var_03 func_1808("action",param_00);
	var_02 func_D4F8(var_03,self);
}

//Function Number: 51
func_C6E3(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	var_02 endon("removed from battleChatter");
	var_03 = var_02 func_4996();
	var_02 func_128A8(var_03,param_01);
	var_03 func_1808("move",param_00);
	var_02 func_D4F8(var_03,self);
}

//Function Number: 52
func_C6E2(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = self;
	var_02 = var_01 func_4996();
	var_02 func_1808("displace",param_00);
	var_01 func_D4F8(var_02,self,1);
}

//Function Number: 53
func_128A8(param_00,param_01)
{
	if(randomint(100) > level.var_68AE["response"]["order"])
	{
		if(!isdefined(param_01) || isdefined(param_01) && !isplayer(param_01))
		{
			return;
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(level.player.var_29AE))
	{
		param_00 func_180F();
		param_00.var_299D = level.player;
		return;
	}

	if(isdefined(param_01) && func_3903(param_01))
	{
		param_00 func_17F2(param_01.var_29AD);
		param_00.var_299D = param_01;
		param_01 scripts\anim\battlechatter_ai::func_1820("ack","yes",self,0.9);
		return;
	}

	level notify("follow order",self);
}

//Function Number: 54
func_D4A3()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_4B1F = self.var_3D4C["inform"];
	var_00 = self.var_3D4C["inform"].var_B92F;
	anim thread func_AEEB(self,"inform");
	if(self != level.player)
	{
		self.var_1198.var_28DE = level.player;
	}

	switch(self.var_3D4C["inform"].var_68BA)
	{
		case "incoming":
			func_94BE(var_00);
			break;

		case "attack":
			func_94BD(var_00);
			break;

		case "reloading":
			func_94C0(var_00);
			break;

		case "suppressed":
			func_94C1(var_00);
			break;

		case "killfirm":
			func_94BF(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 55
func_94C0(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	var_02 = var_01 func_4996();
	var_02 func_17D1("reloading",param_00);
	var_01 func_D4F8(var_02,self);
}

//Function Number: 56
func_94C1(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	var_02 = var_01 func_4996();
	var_02 func_17D1("suppressed",param_00);
	var_01 func_D4F8(var_02,self);
}

//Function Number: 57
func_94BE(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	var_02 = var_01 func_4996();
	if(param_00 == "frag" || param_00 == "shock" || param_00 == "ant" || param_00 == "seek")
	{
		var_02.var_B3D1 = 1;
	}

	var_02 func_17D1("incoming",param_00);
	var_01 func_D4F8(var_02,self);
}

//Function Number: 58
func_94BD(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	var_02 = var_01 func_4996();
	var_02 func_17D1("attack",param_00);
	var_01 func_D4F8(var_02,self);
}

//Function Number: 59
func_94BF(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	var_02 = var_01 func_4996();
	var_02 func_17D1("killfirm",param_00,self.var_4B1F.var_117DE);
	var_01 func_D4F8(var_02,self);
}

//Function Number: 60
func_CF0A()
{
	var_00 = self.var_3D4C["custom"];
	self.var_4B1F = self.var_3D4C["custom"];
	var_01 = self;
	var_01 endon("death");
	var_01 endon("removed from battleChatter");
	anim thread func_AEEB(var_01,var_00.type,1);
	var_01 func_D4F8(var_01.var_4C84,self);
	var_01 notify("done speaking");
	var_01.var_4C83 = undefined;
	var_01.var_4C84 = undefined;
}

//Function Number: 61
func_D4F8(param_00,param_01,param_02)
{
	anim endon("battlechatter disabled");
	self endon("dog_attacks_ai");
	self endon("death");
	if(isdefined(param_02))
	{
		return;
	}

	if(scripts\anim\battlechatter_ai::func_1A1B() && !scripts\common\utility::func_D11B())
	{
		self notify("playPhrase_done");
		param_01 func_5ACA(param_01.var_4B1F.var_68AC,param_01.var_4B1F.var_68BA);
		return;
	}

	if(func_28D2() || func_28D3())
	{
		var_03 = [];
		foreach(var_05 in param_00.var_10476)
		{
			var_03[var_03.size] = var_05;
		}

		if(func_28D2())
		{
			func_28DA(var_03);
		}

		if(func_28D3())
		{
			var_07 = self.var_4B1F.var_68AC + "_" + self.var_4B1F.var_68BA;
			if(isdefined(self.var_4B1F.var_B92F))
			{
				var_07 = var_07 + "_" + self.var_4B1F.var_B92F;
			}

			thread func_28DB(var_03,var_07);
		}
	}

	for(var_08 = 0;var_08 < param_00.var_10476.size;var_08++)
	{
		if(!self.var_28CF)
		{
			if(!func_9BEB(self.var_4B1F))
			{
			}
			else
			{
			}
			else if(!func_3844(0))
			{
			}
			else if((!isdefined(self.var_117C) && self != level.player && !scripts\anim\battlechatter_ai::func_1A1B()) || isdefined(self.var_117C) && self.var_117C > 0)
			{
			}
			else if(func_9DF3(param_01.var_4B1F.var_68AC))
			{
				wait(0.85);
			}
			else if(!soundexists(param_00.var_10476[var_08]))
			{
			}
			else
			{
				var_09 = gettime();
				if(self == level.player)
				{
					var_0A = spawn("script_origin",level.player geteye());
					var_0A linkto(self);
				}
				else if(scripts\common\utility::func_D11B())
				{
					var_0B = level.player gettagorigin("tag_cockpit_light_monitor2");
					var_0A = spawn("script_origin",var_0B);
					var_0A linkto(level.player);
				}
				else
				{
					var_0A = spawn("script_origin",self gettagorigin("j_head"));
					var_0A linkto(param_01);
				}

				thread func_11047(param_00.var_10476[var_08],var_0A);
				func_F2DB(param_00.var_10476[var_08]);
				if(param_00.var_B3D1 && self.team == "allies")
				{
					thread lib_0B06::func_1EBF(param_00.var_10476[var_08],param_00.var_299D);
					if(isdefined(self.classname) && self.classname == "player")
					{
						var_0C = self.health / self.maxhealth;
						if(var_0C > self.var_86A9.var_8CBC)
						{
							var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
						}
					}
					else
					{
						var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
					}

					var_0A waittill(param_00.var_10476[var_08]);
					self notify(param_00.var_10476[var_08]);
				}
				else
				{
					thread lib_0B06::func_1EBF(param_00.var_10476[var_08],param_00.var_299D);
					if(getdvarint("bcs_forceEnglish",0))
					{
						if(isdefined(self.classname) && self.classname == "player")
						{
							var_0C = self.health / self.maxhealth;
							if(var_0C > self.var_86A9.var_8CBC)
							{
								var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
							}
						}
						else
						{
							var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
						}
					}
					else if(isdefined(self.classname) && self.classname == "player")
					{
						var_0C = self.health / self.maxhealth;
						if(var_0C > self.var_86A9.var_8CBC)
						{
							var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
						}
					}
					else
					{
						var_0A playsound(param_00.var_10476[var_08],param_00.var_10476[var_08],1);
					}

					var_0A waittill(param_00.var_10476[var_08]);
					self notify(param_00.var_10476[var_08]);
				}

				var_0A delete();
				if(gettime() < var_09 + 250)
				{
				}
			}
		}
	}

	self notify("playPhrase_done");
	if(self != level.player)
	{
		self.var_1198.var_28DE = undefined;
		self.var_1198.var_28D0 = undefined;
	}

	param_01 func_5ACA(param_01.var_4B1F.var_68AC,param_01.var_4B1F.var_68BA);
}

//Function Number: 62
func_F2DB(param_00)
{
	var_01 = strtok(param_00,"_");
	if(!isdefined(self.var_1198))
	{
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"killfirm"))
	{
		self.var_1198.var_28D0 = "action";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"action"))
	{
		self.var_1198.var_28D0 = "action";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"attack") && !scripts\common\utility::func_2286(var_01,"grenade"))
	{
		self.var_1198.var_28D0 = "attacking_action";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"grenade") || scripts\common\utility::func_2286(var_01,"incoming") || scripts\common\utility::func_2286(var_01,"inform") && !scripts\common\utility::func_2286(var_01,"taking"))
	{
		self.var_1198.var_28D0 = "defending_action";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"order"))
	{
		self.var_1198.var_28D0 = "order_action";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"callout") || scripts\common\utility::func_2286(var_01,"dist") || scripts\common\utility::func_2286(var_01,"exposed") && !scripts\common\utility::func_2286(var_01,"acquired"))
	{
		self.var_1198.var_28D0 = "threat_infantry";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"taking"))
	{
		self.var_1198.var_28D0 = "takingfire";
		return;
	}

	if(scripts\common\utility::func_2286(var_01,"resp") || scripts\common\utility::func_2286(var_01,"affirm") || scripts\common\utility::func_2286(var_01,"acquired"))
	{
		self.var_1198.var_28D0 = "response";
		return;
	}
}

//Function Number: 63
func_11047(param_00,param_01)
{
	param_01 endon("death");
	self waittill("death");
	if(isdefined(param_01))
	{
		param_01 method_83AD();
		scripts\common\utility::func_136F7();
		if(isdefined(param_01))
		{
			param_01 notify(param_00);
			param_01 delete();
		}
	}
}

//Function Number: 64
func_9BEB(param_00)
{
	if(!isdefined(param_00.var_68AC) || !isdefined(param_00.var_68BA))
	{
		return 0;
	}

	if(param_00.var_68AC == "reaction" && param_00.var_68BA == "friendlyfire")
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
func_9F6C(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(25);
	func_41BC(param_00);
}

//Function Number: 66
func_41BC(param_00)
{
	self.var_9F6B = 0;
	self.var_3D4C[param_00].var_698B = 0;
	self.var_3D4C[param_00].priority = 0;
	if(isdefined(self.var_12BA4) && self.var_12BA4 != "c6")
	{
		self.var_BFA9[param_00] = gettime() + level.var_68AD[param_00]["self"];
		return;
	}

	self.var_BFA9[param_00] = gettime() + 1;
}

//Function Number: 67
func_AEEB(param_00,param_01,param_02)
{
	anim endon("battlechatter disabled");
	var_03 = param_00.var_10AC8;
	var_04 = param_00.team;
	param_00.var_9F6B = 1;
	param_00 thread func_9F6C(param_01);
	var_03.var_9E9B[param_01] = 1;
	var_03.var_C242++;
	level.var_9F9F[var_04] = 1;
	level.var_9F9E[var_04][param_01] = 1;
	var_05 = param_00 scripts\common\utility::func_13734("death","done speaking","cancel speaking");
	var_03.var_9E9B[param_01] = 0;
	var_03.var_C242--;
	level.var_9F9F[var_04] = 0;
	level.var_9F9E[var_04][param_01] = 0;
	if(var_05 == "cancel speaking")
	{
		return;
	}

	level.var_AA27[var_04] = gettime();
	if(isalive(param_00))
	{
		param_00 func_41BC(param_01);
	}

	var_03.var_BFA9[param_01] = gettime() + level.var_68AD[param_01]["squad"];
}

//Function Number: 68
func_12E7C(param_00,param_01)
{
	if(gettime() - self.var_10AE9[param_00].var_A95F > 10000)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < self.var_B661.size;var_03++)
		{
			if(self.var_B661[var_03] != param_01 && isalive(self.var_B661[var_03].var_10C) && isdefined(self.var_B661[var_03].var_10C.var_10AC8) && self.var_B661[var_03].var_10C.var_10AC8.var_10AEE == param_00)
			{
				var_02 = 1;
			}
		}

		if(!var_02)
		{
			self.var_10AE9[param_00].var_6DE4 = gettime();
			self.var_10AE9[param_00].var_376A = 0;
		}
	}

	self.var_10AE9[param_00].var_A95F = gettime();
}

//Function Number: 69
func_3902(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c8")
	{
		return 0;
	}

	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c12")
	{
		return 0;
	}

	if(!isdefined(level.player.var_28CF) || isdefined(level.player.var_28CF) && !level.player.var_28CF && isplayer(self))
	{
		return 0;
	}

	if(distance(level.player.origin,self.origin) > level.var_29BD)
	{
		return 0;
	}

	if(!isdefined(self.var_28CF) || !self.var_28CF || !isdefined(self.var_BFA9))
	{
		return 0;
	}

	if(isdefined(param_02) && param_02 >= 1)
	{
		return 1;
	}

	if(gettime() + level.var_68AD[param_00]["self"] < self.var_BFA9[param_00])
	{
		return 0;
	}

	if(gettime() + level.var_68AD[param_00]["squad"] < self.var_10AC8.var_BFA9[param_00])
	{
		return 0;
	}

	if(isdefined(param_01) && func_12AE7(param_00,param_01))
	{
		return 0;
	}

	if(isdefined(param_01) && level.var_68B5[param_00][param_01] < self.var_29BF)
	{
		return 0;
	}

	return 1;
}

//Function Number: 70
func_7EFE()
{
	var_00 = undefined;
	var_01 = -999999999;
	foreach(var_04, var_03 in self.var_3D4C)
	{
		if(func_9FD7(var_04))
		{
			if(var_03.priority > var_01)
			{
				var_00 = var_04;
				var_01 = var_03.priority;
			}
		}
	}

	return var_00;
}

//Function Number: 71
func_83DE(param_00)
{
	if(!level.var_9F9E[level.var_115E7[0]][param_00] && !level.var_9F9E[level.var_115E7[1]][param_00] && !level.var_9F9E[level.var_115E7[2]][param_00] && !level.var_9F9E[level.var_115E7[3]][param_00])
	{
		return 1;
	}

	return 0;
}

//Function Number: 72
func_819F(param_00)
{
	var_01 = self.var_10AC8;
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.var_B661.size;var_03++)
	{
		if(isdefined(var_01.var_B661[var_03].var_10C) && var_01.var_B661[var_03].var_10C == param_00)
		{
			var_02[var_02.size] = var_01.var_B661[var_03];
		}
	}

	if(!isdefined(var_02[0]))
	{
		return undefined;
	}

	var_04 = undefined;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] func_3902("response"))
		{
			return var_04;
		}
	}

	return scripts\common\utility::getclosest(self.origin,var_02);
}

//Function Number: 73
func_80A5()
{
	var_00 = [];
	var_01 = [];
	var_00[0] = "custom";
	var_00[1] = "response";
	var_00[2] = "order";
	var_00[3] = "threat";
	var_00[4] = "inform";
	for(var_02 = var_00.size - 1;var_02 >= 0;var_02--)
	{
		for(var_03 = 1;var_03 <= var_02;var_03++)
		{
			if(self.var_3D4C[var_00[var_03 - 1]].priority < self.var_3D4C[var_00[var_03]].priority)
			{
				var_04 = var_00[var_03 - 1];
				var_00[var_03 - 1] = var_00[var_03];
				var_00[var_03] = var_04;
			}
		}
	}

	var_05 = 0;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_06 = func_7EA1(var_00[var_02]);
		if(var_06 == " valid" && !var_05)
		{
			var_05 = 1;
			var_01[var_02] = "g " + var_00[var_02] + var_06 + " " + self.var_3D4C[var_00[var_02]].priority;
			continue;
		}

		if(var_06 == " valid")
		{
			var_01[var_02] = "y " + var_00[var_02] + var_06 + " " + self.var_3D4C[var_00[var_02]].priority;
			continue;
		}

		if(self.var_3D4C[var_00[var_02]].var_698B == 0)
		{
			var_01[var_02] = "b " + var_00[var_02] + var_06 + " " + self.var_3D4C[var_00[var_02]].priority;
			continue;
		}

		var_01[var_02] = "r " + var_00[var_02] + var_06 + " " + self.var_3D4C[var_00[var_02]].priority;
	}

	return var_01;
}

//Function Number: 74
func_7EA1(param_00)
{
	var_01 = "";
	if(self.var_10AC8.var_9E9B[param_00])
	{
		var_01 = var_01 + " playing";
	}

	if(gettime() > self.var_3D4C[param_00].var_698B)
	{
		var_01 = var_01 + " expired";
	}

	if(gettime() < self.var_10AC8.var_BFA9[param_00])
	{
		var_01 = var_01 + " cantspeak";
	}

	if(var_01 == "")
	{
		var_01 = " valid";
	}

	return var_01;
}

//Function Number: 75
func_9DF3(param_00)
{
	if(getdvar("bcs_filter" + param_00,"off") == "on" || getdvar("bcs_filter" + param_00,"off") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
func_9FD7(param_00)
{
	var_01 = gettime();
	if(!self.var_10AC8.var_9E9B[param_00] && !level.var_9F9E[level.var_115E7[0]][param_00] && !level.var_9F9E[level.var_115E7[1]][param_00] && !level.var_9F9E[level.var_115E7[2]][param_00] && !level.var_9F9E[level.var_115E7[3]][param_00] && gettime() < self.var_3D4C[param_00].var_698B && gettime() > self.var_10AC8.var_BFA9[param_00])
	{
		if(!func_12AE7(param_00,self.var_3D4C[param_00].var_68BA))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 77
func_12AE7(param_00,param_01)
{
	if(!isdefined(level.var_68BB[param_00][param_01]))
	{
		return 0;
	}

	if(!isdefined(self.var_10AC8.var_BFB4[param_00][param_01]))
	{
		return 0;
	}

	if(gettime() > self.var_10AC8.var_BFB4[param_00][param_01])
	{
		return 0;
	}

	return 1;
}

//Function Number: 78
func_5ACA(param_00,param_01)
{
	if(!isdefined(level.var_68BB[param_00][param_01]))
	{
		return;
	}

	self.var_10AC8.var_BFB4[param_00][param_01] = gettime() + level.var_68BB[param_00][param_01];
}

//Function Number: 79
func_29AB()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(isplayer(self))
	{
		return 0;
	}

	if(!isdefined(self.var_394))
	{
		return 0;
	}

	return scripts\anim\utility_common::func_9F62(self.var_394);
}

//Function Number: 80
func_9DE8(param_00)
{
	if(distancesquared(self.origin,level.player.origin) > 2250000)
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 && isdefined(func_7F7E()))
	{
		return 0;
	}

	var_01 = func_29A6();
	if(!isdefined(var_01))
	{
		return 1;
	}

	if(!func_9EB6())
	{
		return 0;
	}

	return 1;
}

//Function Number: 81
func_9EB6()
{
	var_00 = self.var_205;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(issubstr(var_00.type,"Cover") || issubstr(var_00.type,"Conceal"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 82
func_10AE3(param_00)
{
	if(param_00.var_C35A > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
func_9EC2()
{
	var_00 = func_80C8();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00 == "sergeant" || var_00 == "lieutenant" || var_00 == "captain" || var_00 == "sergeant")
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
func_29A6()
{
	if(isplayer(self))
	{
		return self.var_205;
	}

	return scripts\anim\utility_common::func_7E28();
}

//Function Number: 85
func_652B()
{
	if(issentient(self) && self method_8198())
	{
		return 1;
	}

	return 0;
}

//Function Number: 86
func_7FD8()
{
	if(func_652B())
	{
		var_00 = self.var_1A53;
	}
	else if(self.team == "allies")
	{
		var_00 = self.name;
	}
	else
	{
		var_00 = undefined;
	}

	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = strtok(var_00," ");
	if(var_01.size < 2)
	{
		return var_00;
	}

	return var_01[1];
}

//Function Number: 87
func_80C8()
{
	return self.var_1A70;
}

//Function Number: 88
func_7E32(param_00)
{
	var_01 = func_8145(param_00,self.team);
	var_02 = scripts\common\utility::getclosest(self.origin,var_01);
	return var_02;
}

//Function Number: 89
func_8145(param_00,param_01)
{
	var_02 = [];
	var_03 = function_0072(param_01);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(var_03[var_04] == self)
		{
			continue;
		}

		if(!var_03[var_04] func_3902(param_00))
		{
			continue;
		}

		var_02[var_02.size] = var_03[var_04];
	}

	return var_02;
}

//Function Number: 90
func_80EA(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = "response";
	}

	var_04 = scripts\common\utility::array_randomize(self.var_10AC8.var_B661);
	param_00 = param_00 * param_00;
	param_01 = param_01 * param_01;
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(var_04[var_05] == self)
		{
			continue;
		}

		if(!isalive(var_04[var_05]))
		{
			continue;
		}

		var_06 = distancesquared(self.origin,var_04[var_05].origin);
		if(var_06 < param_00)
		{
			continue;
		}

		if(var_06 > param_01)
		{
			continue;
		}

		if(func_9FC7(var_04[var_05]))
		{
			continue;
		}

		if(!var_04[var_05] func_3902(param_02))
		{
			continue;
		}

		var_03 = var_04[var_05];
		if(!scripts\sp\_utility::func_D123())
		{
			if(func_3903(var_03))
			{
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 91
func_7F7E()
{
	var_00 = func_7803();
	var_00 = scripts\common\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!func_AEC6(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!func_AEC7(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 92
func_81F7(param_00)
{
	var_01 = func_7803();
	var_01 = scripts\common\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!func_AEC6(var_03) && param_00 func_3878(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!func_AEC7(var_03) && param_00 func_3878(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 93
func_7803()
{
	var_00 = level.var_29BC;
	var_01 = self getistouchingentities(var_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.var_AECB))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 94
func_12D96()
{
	if(isdefined(level.var_29BC))
	{
		anim.var_29BC = scripts\common\utility::func_22BC(level.var_29BC);
	}
}

//Function Number: 95
func_9C15()
{
	var_00 = func_7803();
	foreach(var_02 in var_00)
	{
		if(!func_AEC7(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 96
func_AEC6(param_00)
{
	var_01 = func_AEC9(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 97
func_AEC7(param_00)
{
	var_01 = func_AEC9(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = var_01 + level.var_68AD["threat"]["location_repeat"];
	if(gettime() < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 98
func_AEC5(param_00)
{
	level.var_AECC[param_00.classname] = gettime();
}

//Function Number: 99
func_AEC9(param_00)
{
	if(isdefined(level.var_AECC[param_00.classname]))
	{
		return level.var_AECC[param_00.classname];
	}

	return undefined;
}

//Function Number: 100
func_80E5(param_00)
{
	var_01 = param_00.angles;
	if(!isplayer(param_00))
	{
		var_02 = param_00 func_29A6();
		if(isdefined(var_02))
		{
			var_01 = var_02.angles;
		}
	}

	return var_01;
}

//Function Number: 101
func_101B8(param_00)
{
	if(param_00 == "left" || param_00 == "right")
	{
		return 1;
	}

	return 0;
}

//Function Number: 102
func_7E76(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02);
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = var_03[1] - var_04[1];
	var_05 = var_05 + 360;
	var_05 = int(var_05) % 360;
	if(var_05 > 315 || var_05 < 45)
	{
		var_06 = "front";
	}
	else if(var_06 < 135)
	{
		var_06 = "right";
	}
	else if(var_06 < 225)
	{
		var_06 = "rear";
	}
	else
	{
		var_06 = "left";
	}

	return var_06;
}

//Function Number: 103
func_C098(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "north":
			var_01 = "n";
			break;

		case "northwest":
			var_01 = "nw";
			break;

		case "west":
			var_01 = "w";
			break;

		case "southwest":
			var_01 = "sw";
			break;

		case "south":
			var_01 = "s";
			break;

		case "southeast":
			var_01 = "se";
			break;

		case "east":
			var_01 = "e";
			break;

		case "northeast":
			var_01 = "ne";
			break;

		case "impossible":
			var_01 = "impossible";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 104
func_7E74(param_00,param_01)
{
	var_02 = vectortoangles(param_01 - param_00);
	var_03 = var_02[1];
	var_04 = getnorthyaw();
	var_03 = var_03 - var_04;
	if(var_03 < 0)
	{
		var_03 = var_03 + 360;
	}
	else if(var_03 > 360)
	{
		var_03 = var_03 - 360;
	}

	if(var_03 < 22.5 || var_03 > 337.5)
	{
		var_05 = "north";
	}
	else if(var_04 < 67.5)
	{
		var_05 = "northwest";
	}
	else if(var_04 < 112.5)
	{
		var_05 = "west";
	}
	else if(var_04 < 157.5)
	{
		var_05 = "southwest";
	}
	else if(var_04 < 202.5)
	{
		var_05 = "south";
	}
	else if(var_04 < 247.5)
	{
		var_05 = "southeast";
	}
	else if(var_04 < 292.5)
	{
		var_05 = "east";
	}
	else if(var_04 < 337.5)
	{
		var_05 = "northeast";
	}
	else
	{
		var_05 = "impossible";
	}

	return var_05;
}

//Function Number: 105
func_7E7A(param_00,param_01)
{
	var_02 = distance2d(param_00,param_01);
	var_03 = 0.0254 * var_02;
	return var_03;
}

//Function Number: 106
func_7E7B(param_00,param_01)
{
	var_02 = func_7E7A(param_00,param_01);
	if(var_02 < 19)
	{
		return "10";
	}

	if(var_02 < 29)
	{
		return "20";
	}

	if(var_02 < 39)
	{
		return "30";
	}

	return "40";
}

//Function Number: 107
func_7E7C(param_00,param_01)
{
	var_02 = distance2d(param_00,param_01);
	var_03 = 1.57828E-05 * var_02;
	return var_03;
}

//Function Number: 108
func_7E7D(param_00,param_01)
{
	var_02 = func_7E7C(param_00,param_01);
	if(var_02 < 5)
	{
		return "4";
	}

	if(var_02 < 6)
	{
		return "5";
	}

	if(var_02 < 7)
	{
		return "6";
	}

	if(var_02 < 15)
	{
		return "10";
	}

	return "15";
}

//Function Number: 109
func_7EC9(param_00)
{
	var_01 = "undefined";
	if(param_00 == "10" || param_00 == "11")
	{
		var_01 = "10";
	}
	else if(param_00 == "12")
	{
		var_01 = param_00;
	}
	else if(param_00 == "1" || param_00 == "2")
	{
		var_01 = "2";
	}

	return var_01;
}

//Function Number: 110
func_7E75(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_00);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = int(var_07) % 360;
	if(var_07 > 345 || var_07 < 15)
	{
		var_08 = "12";
	}
	else if(var_08 < 45)
	{
		var_08 = "1";
	}
	else if(var_08 < 75)
	{
		var_08 = "2";
	}
	else if(var_08 < 105)
	{
		var_08 = "3";
	}
	else if(var_08 < 135)
	{
		var_08 = "4";
	}
	else if(var_08 < 165)
	{
		var_08 = "5";
	}
	else if(var_08 < 195)
	{
		var_08 = "6";
	}
	else if(var_08 < 225)
	{
		var_08 = "7";
	}
	else if(var_08 < 255)
	{
		var_08 = "8";
	}
	else if(var_08 < 285)
	{
		var_08 = "9";
	}
	else if(var_08 < 315)
	{
		var_08 = "10";
	}
	else
	{
		var_08 = "11";
	}

	return var_08;
}

//Function Number: 111
func_7E69(param_00,param_01)
{
	var_02 = param_01[2] - param_00[2];
	var_03 = distance2d(param_00,param_01);
	var_04 = atan(var_02 / var_03);
	if(var_04 < 15 || var_04 > 55)
	{
		return var_04;
	}

	if(var_04 < 25)
	{
		return 20;
	}

	if(var_04 < 35)
	{
		return 30;
	}

	if(var_04 < 45)
	{
		return 40;
	}

	if(var_04 < 55)
	{
		return 50;
	}
}

//Function Number: 112
func_81FE(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 113
func_81FD(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 114
func_17BE(param_00)
{
	var_01 = "_generic";
	var_02 = undefined;
	if(param_00 func_29AB())
	{
		var_01 = "_sniper";
	}
	else if(func_9B42(param_00))
	{
		if(randomint(100) > 60)
		{
			var_01 = "_bot";
		}
		else if(isdefined(param_00.var_12BA4) && param_00.var_12BA4 == "c6")
		{
			var_01 = "_c6";
		}
		else if(isdefined(param_00.var_12BA4) && param_00.var_12BA4 == "c8")
		{
			var_01 = "_c8";
		}
		else if(isdefined(param_00.var_12BA4) && param_00.var_12BA4 == "c12")
		{
			var_01 = "_target_mega";
		}
	}

	if(self.var_222 == level.player)
	{
		var_02 = "UN_plr_concat_target" + var_01;
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_concat_target" + var_01;
	}

	self.var_10476[self.var_10476.size] = var_02;
}

//Function Number: 115
func_17BD(param_00,param_01)
{
	var_02 = scripts\common\utility::random(["relative","absolute"]);
	switch(var_02)
	{
		case "absolute":
			var_03 = func_7E74(level.player.origin,param_01.origin);
			var_04 = func_C098(var_03);
			if(var_04 != "impossible" && var_04.size != 2)
			{
				if(self.var_222 == level.player)
				{
					var_05 = "UN_plr_concat_dir_cmpss_" + var_04;
				}
				else
				{
					var_05 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_concat_dir_cmpss_" + var_05;
				}
	
				self.var_10476[self.var_10476.size] = var_05;
				break;
			}
	
			break;

		case "relative":
			var_06 = func_80E5(param_00);
			var_07 = func_7E75(var_06,param_00.origin,param_01.origin);
			var_08 = int(var_07);
			if(1 < var_08 && var_08 < 5 && scripts\common\utility::func_4347())
			{
				if(self.var_222 == level.player)
				{
					var_05 = "UN_plr_concat_dir_right";
				}
				else
				{
					var_05 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_concat_dir_right";
				}
	
				self.var_10476[self.var_10476.size] = var_05;
				break;
			}
			else if(7 < var_08 && var_08 < 11 && scripts\common\utility::func_4347())
			{
				if(self.var_222 == level.player)
				{
					var_05 = "UN_plr_concat_dir_left";
				}
				else
				{
					var_05 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_concat_dir_left";
				}
	
				self.var_10476[self.var_10476.size] = var_05;
				break;
			}
			else
			{
				if(self.var_222 == level.player)
				{
					var_05 = "UN_plr_concat_dir_clock_" + var_07;
				}
				else
				{
					var_05 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_concat_dir_clock_" + var_08;
				}
	
				self.var_10476[self.var_10476.size] = var_05;
			}
			break;
	}
}

//Function Number: 116
func_17F2(param_00)
{
	if(self.var_222 == level.player)
	{
	}
	else
	{
		self.var_10476[self.var_10476.size] = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_name_" + param_00;
	}

	level.var_A9C3[self.var_222.team] = param_00;
	level.var_A9C4[self.var_222.team] = gettime();
}

//Function Number: 117
func_180F()
{
	if(!self.var_222 func_3904())
	{
		return;
	}

	anim.var_A9CF = gettime();
	var_00 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_name_player_" + level.player.var_29A3 + "_" + level.player.var_29AE;
	self.var_10476[self.var_10476.size] = var_00;
	self.var_299D = level.player;
}

//Function Number: 118
func_1816(param_00)
{
	self.var_10476[self.var_10476.size] = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_rank_" + param_00;
}

//Function Number: 119
func_3903(param_00)
{
	if(func_652B())
	{
		return 0;
	}

	if(!isdefined(param_00.var_29AD))
	{
		return 0;
	}

	if(param_00.var_28CF == 0)
	{
		return 0;
	}

	if(!isdefined(param_00.var_46BC))
	{
		return 0;
	}

	if(self.var_46BC != param_00.var_46BC)
	{
		return 0;
	}

	if(func_BE4E(param_00))
	{
		return 0;
	}

	var_01 = undefined;
	if(isplayer(self))
	{
		var_01 = "UN_plr_name_" + param_00.var_29AD;
	}
	else
	{
		var_01 = self.var_46BC + "_" + self.var_C19D + "_name_" + param_00.var_29AD;
	}

	if(soundexists(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 120
func_BE4E(param_00)
{
	if(level.var_A9C3[self.team] == param_00.var_29AD || gettime() - level.var_A9C4[self.team] < level.var_A9C5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 121
func_3904()
{
	if(func_652B())
	{
		return 0;
	}

	if(self == level.player)
	{
		return 0;
	}

	if(!isdefined(level.player.var_29AE) || !isdefined(level.player.var_29A3))
	{
		return 0;
	}

	if(func_D203())
	{
		return 0;
	}

	var_00 = self.var_46BC + "_" + self.var_C19D + "_name_player_" + level.player.var_29A3 + "_" + level.player.var_29AE;
	if(soundexists(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 122
func_D203()
{
	if(!isdefined(level.var_A9CF))
	{
		return 0;
	}

	if(gettime() - level.var_A9CF >= level.var_68BB["playername"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 123
func_9FC7(param_00)
{
	if(isstring(self.var_C19D) && isstring(param_00.var_C19D) && self.var_C19D == param_00.var_C19D)
	{
		return 1;
	}

	if(!isstring(self.var_C19D) && !isstring(param_00.var_C19D) && self.var_C19D == param_00.var_C19D)
	{
		return 1;
	}

	return 0;
}

//Function Number: 124
func_1836(param_00,param_01)
{
	var_02 = undefined;
	var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_threat_" + param_00;
	if(isdefined(param_01))
	{
		var_02 = var_02 + "_" + param_01;
	}

	self.var_10476 = scripts\common\utility::array_add(self.var_10476,var_02);
	return 1;
}

//Function Number: 125
func_1840(param_00)
{
	var_01 = undefined;
	var_02 = "exposed";
	if(param_00 == "group")
	{
		var_02 = "contact_movement";
	}
	else if(param_00 == "movement" && func_9B42(self.var_117E3))
	{
		var_02 = "contact_movement";
		param_00 = "bot";
	}

	if(param_00 == "generic")
	{
		var_02 = "target";
	}

	if(isdefined(self.var_117E3) && self.var_117E3 != level.player)
	{
		if(var_02 == "target" && isdefined(self.var_117E3.var_12BA4) && self.var_117E3.var_12BA4 == "c12")
		{
			param_00 = "c12";
		}
		else if(var_02 == "target" && func_9B42(self.var_117E3))
		{
			param_00 = "bots";
		}
	}

	if(self.var_222 == level.player)
	{
		var_01 = "UN_plr_" + var_02 + "_" + param_00;
	}
	else if(isdefined(self.var_222.var_12BA4) && self.var_222.var_12BA4 == "c6")
	{
		if(randomint(100) < 30 && func_9B42(self.var_117E3))
		{
			var_01 = "c6_0_inform_incoming_c6";
		}
		else
		{
			var_01 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_exposed_open";
		}
	}
	else
	{
		var_01 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_" + var_02 + "_" + param_00;
	}

	self.var_10476[self.var_10476.size] = var_01;
	return 1;
}

//Function Number: 126
func_1841()
{
	if(self.var_222 == level.player)
	{
		var_00 = "UN_plr_order_action_suppress";
	}
	else
	{
		var_00 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_order_action_suppress";
	}

	self.var_10476[self.var_10476.size] = var_00;
	return 1;
}

//Function Number: 127
func_183D(param_00)
{
	if(!scripts\sp\_utility::func_D123() && self.var_222 == level.player)
	{
		var_01 = "UN_plr_co_dist_" + param_00;
	}
	else if(scripts\sp\_utility::func_D123() && self.var_222 == level.var_D127)
	{
		var_01 = "JK_plr_co_dist_" + var_01;
	}
	else
	{
		var_01 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_co_dist_" + var_01;
	}

	self.var_10476[self.var_10476.size] = var_01;
	return 1;
}

//Function Number: 128
func_183E(param_00)
{
	if(self.var_222 == level.player)
	{
		var_01 = "UN_plr_co_elev_" + param_00;
	}
	else
	{
		var_01 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_co_elev_" + var_01;
	}

	self.var_10476[self.var_10476.size] = var_01;
	return 1;
}

//Function Number: 129
func_1838(param_00,param_01)
{
	var_02 = func_49A9(param_00,param_01);
	if(!soundexists(var_02))
	{
		return 0;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 130
func_183C(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(isalive(param_01) && func_9B42(param_01) && self.var_222.team == "allies")
	{
		var_03 = "_resp_target_bot_hit";
	}

	if(scripts\common\utility::func_D11B())
	{
		return 0;
	}
	else if(self.var_222 == level.player)
	{
		if(isdefined(var_03))
		{
			var_02 = "UN_plr_resp_target_bot_hit";
		}
		else
		{
			var_02 = "UN_plr_resp_ack_co_gnrc_" + param_00;
		}
	}
	else if(isdefined(var_03))
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_resp_target_bot_hit";
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_resp_ack_co_gnrc_" + param_00;
	}

	if(!soundexists(var_02))
	{
		return 0;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 131
func_183B(param_00,param_01,param_02)
{
	var_03 = undefined;
	foreach(var_05 in param_02.var_AECB)
	{
		if(issubstr(param_01,var_05))
		{
			var_03 = var_05;
			break;
		}
	}

	var_07 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_";
	var_08 = getsubstr(param_01,param_01.size - 1,param_01.size);
	var_09 = int(var_08) + 1;
	var_0A = var_07 + "callout_loc_" + var_03 + "_qa" + var_09;
	if(!soundexists(var_0A))
	{
		if(randomint(100) < level.var_68AE["response"]["callout_negative"])
		{
			param_00 scripts\anim\battlechatter_ai::func_1820("callout","neg",self.var_222,0.9);
		}
		else
		{
			param_00 scripts\anim\battlechatter_ai::func_1820("exposed","acquired",self.var_222,0.9);
		}

		param_02.var_DB40 = 1;
		return 0;
	}

	param_00 scripts\anim\battlechatter_ai::func_1820("callout","QA",self.var_222,0.9,var_0A,param_02);
	self.var_10476[self.var_10476.size] = var_0A;
	return 1;
}

//Function Number: 132
func_49A9(param_00,param_01)
{
	var_02 = "_report";
	var_03 = "_echo";
	var_04 = undefined;
	if(param_01 == level.player)
	{
		var_05 = "plr";
	}
	else
	{
		var_05 = var_02.var_C19D;
	}

	if(self.var_222 == level.player)
	{
		var_04 = self.var_222.var_46BC + "_plr_";
	}
	else
	{
		var_04 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_";
	}

	var_06 = param_00.size - var_02.size;
	if(self.var_222 == level.player)
	{
		var_07 = self.var_222.var_46BC + "_plr_";
		var_08 = var_07.size;
	}
	else
	{
		var_07 = self.var_222.var_46BC + "_" + var_07 + "_";
		var_08 = var_08.size;
	}

	var_09 = getsubstr(param_00,var_08,var_06);
	var_0A = var_04 + var_09 + var_03;
	return var_0A;
}

//Function Number: 133
func_1837(param_00,param_01)
{
	var_02 = undefined;
	if(self.var_222 == level.player)
	{
		if(scripts\common\utility::func_D11B() && param_00 == "acquired")
		{
			if(!isdefined(level.var_D127.var_649F))
			{
				return 0;
			}
		}

		if(param_00 == "acquired" || param_00 == "sighted")
		{
			var_02 = self.var_222.var_46BC + "_plr_target_" + param_00;
		}
		else
		{
			var_02 = self.var_222.var_46BC + "_plr_callout_" + param_00 + "_" + param_01;
		}
	}
	else if(self.var_222.var_46BC == "UN")
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01;
	}
	else if(self.var_222.var_46BC == "JK")
	{
		var_03 = self.var_222.origin[2];
		var_04 = self.var_117E3.origin[2];
		var_05 = var_03 - var_04;
		if(param_00 == "targetclock")
		{
			if(var_05 > 3000)
			{
				var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01 + "_high";
			}
			else if(var_05 < -3000)
			{
				var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01 + "_low";
			}
			else
			{
				var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01;
			}
		}
		else
		{
			var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01;
		}

		if(randomint(100) < 35)
		{
			var_06 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_target_sighted";
			self.var_10476[self.var_10476.size] = var_06;
		}
	}
	else if(isdefined(self.var_222.var_12BA4) && self.var_222.var_12BA4 == "c6")
	{
		if(param_00 == "cardinal")
		{
			switch(param_01)
			{
				case "ne":
				case "se":
							param_01 = "e";
					break;

				case "sw":
				case "nw":
							param_01 = "w";
					break;
			}

			var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_co_cardinal_" + param_01;
		}
		else
		{
			var_02 = "c6_0_exposed_open";
		}
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_" + param_00 + "_" + param_01;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 134
func_1839(param_00,param_01,param_02)
{
	var_03 = param_00.var_EDFB;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_callout_obj_" + var_03;
	if(param_02)
	{
		var_04 = var_04 + "_y";
	}

	var_04 = var_04 + "_" + param_01;
	if(!soundexists(var_04))
	{
		return 0;
	}

	self.var_10476[self.var_10476.size] = var_04;
	return 1;
}

//Function Number: 135
func_183A(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = param_00.var_AECB;
	var_05 = var_04[0];
	if(var_04.size > 1)
	{
		var_06 = undefined;
		var_06 = param_00 func_7E18(param_02);
		if(isdefined(var_06))
		{
			var_05 = var_06;
		}
		else
		{
			var_05 = scripts\common\utility::random(var_04);
		}
	}

	var_07 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_07 = self.var_222 func_7F7F("concat_loc_" + var_05);
	}
	else if(!isdefined(param_00.var_DB40) && func_9D7B(var_05,self.var_222))
	{
		var_07 = self.var_222 func_80A3(var_05,0);
	}
	else
	{
		var_07 = self.var_222 func_7F7F("callout_loc_" + var_05);
	}

	if(soundexists(var_07))
	{
		var_03 = var_07;
	}

	if(!isdefined(var_03))
	{
		return 0;
	}

	func_AEC5(param_00);
	self.var_10476[self.var_10476.size] = var_03;
	return 1;
}

//Function Number: 136
func_17D1(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01 == "hack")
	{
		if(isdefined(level.player.var_883D) && level.player.var_883D == "scanning")
		{
			var_03 = "UN_plr_inform_hack_generic";
		}
		else
		{
			return;
		}
	}
	else if(isdefined(param_02) && param_02 == "ally_c12_kill")
	{
		if(self.var_222 == level.player)
		{
			var_03 = "UN_plr_reaction_bot_c12";
		}
		else
		{
			var_03 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_reaction_bot_c12";
		}
	}
	else
	{
		if(param_00 == "killfirm")
		{
			if(param_02 == "c6" || param_02 == "c8" || param_02 == "c12")
			{
				param_01 = "bot";
			}
		}

		if(param_01 == "frag")
		{
			param_01 = "grenade";
		}

		if(!issubstr(param_01,"weapon"))
		{
			param_00 = "_inform_" + param_00 + "_";
		}
		else
		{
			param_00 = "_";
		}

		if(self.var_222 == level.player)
		{
			if(scripts\common\utility::func_D11B())
			{
				var_03 = "JK_plr" + param_00 + param_01;
			}
			else
			{
				var_03 = "UN_plr" + param_00 + param_01;
			}
		}
		else
		{
			var_03 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + param_00 + param_01;
		}
	}

	self.var_10476[self.var_10476.size] = var_03;
}

//Function Number: 137
func_181F(param_00,param_01)
{
	var_02 = undefined;
	if(scripts\common\utility::func_D11B() && self.var_222 == level.var_D127)
	{
		var_02 = "JK_plr_response_" + param_00 + "_yes";
	}
	else if(self.var_222 == level.player)
	{
		var_02 = "UN_plr_response_" + param_00 + "_" + param_01;
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_response_" + param_00 + "_" + param_01;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 138
func_181B(param_00,param_01)
{
	if(!scripts\sp\_utility::func_D123())
	{
	}

	var_02 = undefined;
	if(scripts\sp\_utility::func_D123() && self.var_222 == level.var_D127)
	{
		if(param_00 == "movement")
		{
			if(!isdefined(param_01))
			{
				param_01 = "generic";
			}

			var_02 = "JK_plr_enemy_" + param_00 + "_" + param_01;
		}
		else
		{
			var_02 = "JK_plr_reaction_" + param_00;
		}
	}
	else if(scripts\sp\_utility::func_D123() && param_00 == "movement")
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_enemy_movement_generic";
	}
	else if(!scripts\sp\_utility::func_D123() && self.var_222 == level.player)
	{
		var_02 = "UN_plr_reaction_" + param_00 + "_" + param_01;
	}
	else if(isdefined(param_01))
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_reaction_" + param_00 + "_" + param_01;
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_reaction_" + param_00;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 139
func_17BB()
{
	var_00 = undefined;
	if(self.var_222 == level.player)
	{
		var_00 = "UN_plr_check_fire";
	}
	else
	{
		var_00 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_check_fire";
	}

	self.var_10476[self.var_10476.size] = var_00;
	return 1;
}

//Function Number: 140
func_1832()
{
	var_00 = undefined;
	if(scripts\common\utility::func_D11B() && level.player == level.var_D127)
	{
		return 0;
	}
	else if(self.var_222 == level.player)
	{
		var_00 = "UN_plr_inform_taking_fire";
	}
	else
	{
		var_00 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_inform_taking_fire";
	}

	self.var_10476[self.var_10476.size] = var_00;
	return 1;
}

//Function Number: 141
func_1834(param_00,param_01)
{
	var_02 = undefined;
	if(self.var_222 == level.player)
	{
		var_02 = "UN_plr_taunt";
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_taunt";
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 142
func_17CF()
{
	var_00 = undefined;
	if(self.var_222 == level.player)
	{
		var_00 = "UN_plr_hostile_burst";
	}
	else if(isdefined(self.var_222.var_12BA4) && self.var_222.var_12BA4 == "c6")
	{
		var_00 = "c6_hostile_burst";
	}
	else
	{
		var_00 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_hostile_burst";
	}

	if(soundexists(var_00))
	{
		self.var_10476[self.var_10476.size] = var_00;
	}

	return 1;
}

//Function Number: 143
func_1808(param_00,param_01)
{
	var_02 = undefined;
	if(self.var_222 == level.player)
	{
		if(!scripts\sp\_utility::func_D123())
		{
			var_02 = "UN_plr_order_" + param_00 + "_" + param_01;
		}
	}
	else if(!scripts\sp\_utility::func_D123())
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_order_" + param_00 + "_" + param_01;
	}
	else
	{
		var_02 = self.var_222.var_46BC + "_" + self.var_222.var_C19D + "_order_" + param_01;
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	self.var_10476[self.var_10476.size] = var_02;
	return 1;
}

//Function Number: 144
func_97EE(param_00)
{
	if(!isdefined(self.var_10AE9[param_00].var_376A))
	{
		self.var_10AE9[param_00].var_376A = 0;
	}

	if(!isdefined(self.var_10AE9[param_00].var_6DE4))
	{
		self.var_10AE9[param_00].var_6DE4 = 2000000000;
	}

	if(!isdefined(self.var_10AE9[param_00].var_A95F))
	{
		self.var_10AE9[param_00].var_A95F = 0;
	}
}

//Function Number: 145
func_10183(param_00)
{
	self.var_10AE9[param_00].var_376A = undefined;
	self.var_10AE9[param_00].var_6DE4 = undefined;
	self.var_10AE9[param_00].var_A95F = undefined;
}

//Function Number: 146
func_4995(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_222 = self;
	var_03.var_68BA = param_01;
	var_03.var_68AC = param_00;
	if(isdefined(param_02))
	{
		var_03.priority = param_02;
	}
	else
	{
		var_03.priority = level.var_68B5[param_00][param_01];
	}

	var_03.var_698B = gettime() + level.var_68AF[param_00][param_01];
	return var_03;
}

//Function Number: 147
func_4996()
{
	var_00 = spawnstruct();
	var_00.var_222 = self;
	var_00.var_10476 = [];
	var_00.var_B3D1 = 0;
	return var_00;
}

//Function Number: 148
func_D643(param_00)
{
	return scripts\common\utility::func_13D90(self.origin,self.angles,param_00,0.766);
}

//Function Number: 149
func_6632(param_00)
{
	return scripts\common\utility::func_13D90(self.origin,self.angles,param_00.origin,0);
}

//Function Number: 150
func_10AE2()
{
	anim endon("battlechatter disabled");
	self endon("squad_deleting");
	if(self.var_10AEE != "jackal_allies")
	{
		return;
	}

	while(self.var_B65C <= 0)
	{
		wait(0.5);
	}

	wait(0.5);
	var_00 = 0;
	while(isdefined(self))
	{
		if(!func_10ADE(self))
		{
			var_00 = 1;
			wait(1);
			continue;
		}
		else if(self.var_6BB3)
		{
			if(!var_00)
			{
				wait(randomfloat(level.var_6BB8));
			}

			if(var_00)
			{
				var_00 = 0;
			}

			self.var_6BB3 = 0;
		}
		else
		{
			if(!var_00)
			{
				wait(randomfloatrange(level.var_6BB8,level.var_6BB7));
			}

			if(var_00)
			{
				var_00 = 0;
			}
		}

		var_01 = func_7E14(self);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = var_01.var_13525;
		var_03 = func_7EBD(self,var_02);
		var_04 = func_7EBC(var_02,var_03);
		foreach(var_08, var_06 in var_04)
		{
			if(!var_01 func_38A3() || distance(level.player.origin,var_01.origin) > level.var_6BB2 && !isdefined(var_01.var_29B8))
			{
				for(var_07 = 0;var_07 < self.var_B661.size;var_07++)
				{
					var_01 = func_7E14(self);
					if(!isdefined(var_01))
					{
						continue;
					}

					if(var_01.var_13525 == var_02)
					{
						break;
					}
				}

				if(!isdefined(var_01) || var_01.var_13525 != var_02)
				{
					break;
				}
			}

			thread func_D47B(var_01,var_06);
			self waittill("burst_line_done");
			if(var_08 != var_04.size - 1)
			{
				wait(randomfloatrange(level.var_6BB6,level.var_6BB5));
			}
		}
	}
}

//Function Number: 151
func_10ADE(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.var_B661)
	{
		if(isalive(var_03) && var_03.var_10AC8.var_10AEE == "jackal_allies")
		{
			if(isdefined(self.var_9F6B) && self.var_9F6B)
			{
				return 0;
			}
		}

		if(var_03 == level.player)
		{
			continue;
		}

		if(!isdefined(var_03.team))
		{
			return var_01;
		}

		if(var_03 func_38A3())
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 152
func_38A3()
{
	var_00 = 0;
	if(isalive(self) && self.var_10AC8.var_10AEE == "jackal_allies")
	{
		if(!isdefined(level.var_C52F) || isdefined(level.var_C52F) && !level.var_C52F)
		{
			if(!scripts\common\utility::func_D11B())
			{
				return 0;
			}
		}
	}

	if(self != level.player && isalive(self) && level.var_6EE9[self.team] && func_13528() && isdefined(self.var_6EE9) && self.var_6EE9)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 153
func_13528()
{
	if(isdefined(level.var_6EED) && isdefined(level.var_6EED[self.var_13525]) && level.var_6EED[self.var_13525])
	{
		return 1;
	}

	return 0;
}

//Function Number: 154
func_7E14(param_00)
{
	var_01 = undefined;
	var_02 = scripts\common\utility::func_7830(level.player.origin,param_00.var_B661);
	foreach(var_04 in var_02)
	{
		if(var_04 func_38A3())
		{
			var_01 = var_04;
			if(!isdefined(param_00.var_6BB4))
			{
				break;
			}

			if(isdefined(param_00.var_6BB4) && param_00.var_6BB4 == var_01.var_12BA3)
			{
				continue;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.var_6BB4 = var_01.var_12BA3;
	}

	return var_01;
}

//Function Number: 155
func_7EBD(param_00,param_01)
{
	var_02 = scripts\common\utility::array_randomize(level.var_6EE9[param_01]);
	if(level.var_6EEC.size >= var_02.size)
	{
		anim.var_6EEC = [];
	}

	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_03 = var_05;
		if(!func_6EEE(var_03))
		{
			break;
		}
	}

	level.var_6EEC[level.var_6EEC.size] = var_03;
	return var_03;
}

//Function Number: 156
func_6EEE(param_00)
{
	if(!level.var_6EEC.size)
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in level.var_6EEC)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 157
func_7EBC(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = param_02;
	var_04 = [];
	for(;;)
	{
		if(issubstr(param_00,"jackal"))
		{
			var_05 = var_03 * 10;
		}
		else
		{
			var_05 = var_03;
		}

		var_06 = "FB_" + level.var_46BD[param_00] + "_" + param_01 + "_" + var_05;
		var_03++;
		if(soundexists(var_06))
		{
			var_04[var_04.size] = var_06;
			continue;
		}

		break;
	}

	return var_04;
}

//Function Number: 158
func_D47B(param_00,param_01)
{
	anim endon("battlechatter disabled");
	var_02 = undefined;
	if(isdefined(param_00.var_29B8) && param_00.var_29B8)
	{
		if(!scripts\common\utility::func_D11B())
		{
			if(isdefined(level.var_C52F) && level.var_C52F)
			{
				var_02 = spawn("script_origin",level.player geteye());
				var_02 linkto(level.player);
			}
			else if(isdefined(self))
			{
				self notify("burst_line_done");
				return;
			}
			else
			{
				return;
			}
		}
		else
		{
			var_03 = level.player gettagorigin("tag_cockpit_light_monitor2");
			var_02 = spawn("script_origin",var_03);
			var_02 linkto(level.player);
		}
	}
	else
	{
		var_02 = spawn("script_origin",param_00 gettagorigin("j_head"));
		var_02 linkto(param_00);
	}

	var_02 playsound(param_01,param_01,1);
	var_02 waittill(param_01);
	var_02 delete();
	if(isdefined(self))
	{
		self notify("burst_line_done");
	}
}

//Function Number: 159
func_6EE8(param_00,param_01)
{
	self endon("burst_line_done");
	wait(0.05);
}

//Function Number: 160
func_28D2()
{
	return 0;
}

//Function Number: 161
func_28D3()
{
	return 0;
}

//Function Number: 162
func_28DA(param_00)
{
	if(param_00.size <= 0)
	{
		return;
	}

	if(!func_28D2())
	{
		return;
	}

	var_01 = "^5 ";
	if(func_652B())
	{
		var_01 = "^6 ";
	}

	foreach(var_03 in param_00)
	{
	}
}

//Function Number: 163
func_28DB(param_00,param_01)
{
}

//Function Number: 164
func_7DAD(param_00)
{
	var_01 = self.var_46BC + "_" + self.var_C19D + "_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	return var_02;
}

//Function Number: 165
func_28DC(param_00,param_01,param_02)
{
	if(scripts\common\utility::flag(param_02))
	{
		scripts\common\utility::flag_wait(param_02);
	}

	scripts\common\utility::flag_set(param_02);
	scripts\common\utility::func_6E2A(param_02);
}

//Function Number: 166
func_29A5()
{
	for(var_00 = 0;var_00 < level.var_29BC.size;var_00++)
	{
		var_01 = level.var_29BC[var_00].var_AECB;
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = "";
		foreach(var_04 in var_01)
		{
			var_02 = var_02 + var_04;
		}

		thread func_5B71("Location: " + var_02,level.var_29BC[var_00] getorigin(),(0,0,8),(1,1,1));
	}
}

//Function Number: 167
func_5B71(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		if(distancesquared(level.player.origin,param_01) > 4194304)
		{
			wait(0.1);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 168
func_5B70(param_00,param_01,param_02)
{
	var_03 = param_00 getorigin();
	for(;;)
	{
		if(distancesquared(level.player.origin,var_03) > 4194304)
		{
			wait(0.1);
			continue;
		}

		var_04 = func_7E74(level.player.origin,var_03);
		var_04 = func_C098(var_04);
		var_05 = func_7E75(level.player.angles,level.player.origin,var_03);
		var_06 = var_04 + ", " + var_05 + ":00";
		wait(0.05);
	}
}

//Function Number: 169
func_E25A(param_00,param_01)
{
	var_02 = function_0072(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(!isalive(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.var_28CF))
		{
			continue;
		}

		var_04.var_BFA9[param_01] = gettime() + 350;
		var_04.var_10AC8.var_BFA9[param_01] = gettime() + 350;
	}
}

//Function Number: 170
func_13527()
{
	self endon("death");
	if(self.var_13525 == "british")
	{
		return 1;
	}

	return 0;
}

//Function Number: 171
func_740F()
{
	if(!func_3844())
	{
		return 0;
	}

	func_5ACA("reaction","friendlyfire");
	thread func_D503();
	return 1;
}

//Function Number: 172
func_3844(param_00)
{
	if(isdefined(self.var_7411))
	{
		return 0;
	}

	if(isdefined(self.var_B55B))
	{
		if(isdefined(self.var_B55B.var_9904))
		{
			if(self.var_B55B.var_9904)
			{
				return 0;
			}
		}
	}

	if(!isdefined(self.var_3D4C))
	{
		return 0;
	}

	if(!isdefined(self.var_3D4C["reaction"]) || !isdefined(self.var_3D4C["reaction"].var_68BA))
	{
		return 0;
	}

	if(self.var_3D4C["reaction"].var_68BA != "friendlyfire")
	{
		return 0;
	}

	if(gettime() > self.var_3D4C["reaction"].var_698B)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		if(isdefined(self.var_10AC8.var_BFB4["reaction"]["friendlyfire"]))
		{
			if(gettime() < self.var_10AC8.var_BFB4["reaction"]["friendlyfire"])
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 173
func_9B42(param_00)
{
	var_01 = 0;
	if(isdefined(param_00) && isalive(param_00) && param_00 != level.player && isdefined(param_00.var_12BA4))
	{
		if(param_00.var_12BA4 == "c6" || param_00.var_12BA4 == "c8" || param_00.var_12BA4 == "c12")
		{
			var_01 = 1;
		}
	}

	return var_01;
}
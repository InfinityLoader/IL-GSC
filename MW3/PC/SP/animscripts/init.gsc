/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 432 ms
 * Timestamp: 10/27/2023 2:18:22 AM
*******************************************************************/

//Function Number: 1
func_2098(param_00)
{
	self.weaponinfo[param_00] = spawnstruct();
	self.weaponinfo[param_00].position = "none";
	self.weaponinfo[param_00].var_209A = 1;
	if(getweaponclipmodel(param_00) != "")
	{
		self.weaponinfo[param_00].var_209B = 1;
		return;
	}

	self.weaponinfo[param_00].var_209B = 0;
}

//Function Number: 2
func_209C(param_00)
{
	return isdefined(self.weaponinfo[param_00]);
}

//Function Number: 3
func_209D()
{
	anim.var_CAD = 55;
	anim.var_209E = 10;
	anim.var_209F = 4096;
	anim.var_20A0 = 45;
	anim.var_20A1 = 20;
	anim.var_D62 = 25;
	anim.var_D63 = level.var_209F;
	anim.var_D64 = level.var_20A0;
	anim.var_D65 = 30;
	anim.var_CC0 = 65;
	anim.var_CC1 = 65;
}

//Function Number: 4
func_20A2()
{
	if(animscripts/utility::func_CEA(self.secondaryweapon))
	{
		return 1;
	}

	if(weaponclass(self.primaryweapon) == "rocketlauncher")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
main()
{
	self.a = spawnstruct();
	self.a.var_CDF = 0;
	self.primaryweapon = self.weapon;
	func_20C5();
	if(self.primaryweapon == "")
	{
		self.primaryweapon = "none";
	}

	if(self.secondaryweapon == "")
	{
		self.secondaryweapon = "none";
	}

	if(self.sidearm == "")
	{
		self.sidearm = "none";
	}

	func_2098(self.primaryweapon);
	func_2098(self.secondaryweapon);
	func_2098(self.sidearm);
	self setdefaultaimlimits();
	self.a.weaponpos["left"] = "none";
	self.a.weaponpos["right"] = "none";
	self.a.weaponpos["chest"] = "none";
	self.a.weaponpos["back"] = "none";
	self.a.var_20A4["left"] = "none";
	self.a.var_20A4["right"] = "none";
	self.a.var_20A4["chest"] = "none";
	self.a.var_20A4["back"] = "none";
	self.lastweapon = self.weapon;
	self.var_C56 = %root;
	thread begingrenadetracking();
	var_00 = animscripts/utility::func_BB6();
	self.a.var_20A5 = var_00;
	if(var_00)
	{
		thread animscripts/shared::func_20A6();
	}

	self.a.rockets = 3;
	self.a.var_CD2 = 1;
	self.a.pose = "stand";
	self.a.var_113C = "stand";
	self.a.movement = "stop";
	self.a.var_A98 = "stop";
	self.a.var_D19 = "none";
	self.a.var_20A7 = "none";
	self.a.var_20A8 = -1;
	self.dropweapon = 1;
	self.minexposedgrenadedist = 750;
	animscripts/shared::func_C9B(self.primaryweapon,"right");
	if(animscripts/utility::func_CEA(self.secondaryweapon))
	{
		animscripts/shared::func_C9B(self.secondaryweapon,"back");
	}

	self.a.var_114D = 0;
	self.a.var_20A9 = gettime();
	self.a.var_20AA = gettime();
	self.a.var_20AB = 0;
	self.a.disablelongdeath = !self isbadguy();
	self.a.var_20AC = 0;
	self.a.var_B29 = 0;
	self.a.lastshoottime = 0;
	self.a.var_113A = 0;
	self.a.var_FDD = 0.8;
	if(self.team != "allies")
	{
		self.has_no_ir = 1;
	}

	self.a.var_20AD = undefined;
	self.a.stance = "stand";
	self.var_FBA = ::animscripts/utility::func_10AF;
	self._animactive = 0;
	self._lastanimtime = 0;
	thread func_20C1();
	self.baseaccuracy = 1;
	self.a.misstime = 0;
	self.a.var_D55 = 0;
	self.a.misstime = 0;
	self.a.misstimedebounce = 0;
	self.a.disablepain = 0;
	self.var_20B1 = 1;
	self.chatinitialized = 0;
	self.var_20B2 = 0;
	self.var_20B3 = 1;
	self.var_20B4 = 1;
	self.var_110F = 55;
	self.a.var_D14 = 0;
	if(!isdefined(self.script_forcegrenade))
	{
		self.script_forcegrenade = 0;
	}

	func_20BD();
	animscripts/weaponlist::func_CD0();
	self.var_A7F = 0;
	self.var_A80 = 0;
	self.var_A9D = 0;
	self.var_A9E = 0;
	if(self.team == "allies")
	{
		self.var_CFB = 0.5;
	}
	else
	{
		self.var_CFB = 0;
	}

	if(self.team == "allies")
	{
		self.var_20B6 = 0;
	}
	else
	{
		self.var_20B6 = 256;
	}

	self.var_20B7 = 8000;
	self.var_10BA = 0;
	animscripts/animset::func_CA0();
	self.var_8BE = [];
	self.var_8BE["corner"] = 1;
	self.var_8BE["cover_crouch"] = 1;
	self.var_8BE["stop"] = 1;
	self.var_8BE["stop_immediate"] = 1;
	self.var_8BE["move"] = 1;
	self.var_8BE["exposed"] = 1;
	self.var_8BE["corner_normal"] = 1;
	var_01 = getarraykeys(self.var_8BE);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::clear_exception(var_01[var_02]);
	}

	self.var_1160 = 0;
	thread func_20BB();
	self.var_20B8 = 0;
	thread animscripts/combat_utility::monitorflash();
	thread ondeath();
}

//Function Number: 6
func_20BA(param_00)
{
	var_01[0] = "m4_grenadier";
	if(!isdefined(var_01))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < var_7B.size;var_02++ = var_7B[3])
	{
		if(issubstr(var_01,var_7B[var_02]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_20BB()
{
	self endon("death");
	if(!isdefined(level.loadoutcomplete))
	{
		level waittill("loadout complete");
	}

	maps\_names::get_name();
	thread animscripts/squadmanager::func_A7E();
}

//Function Number: 8
func_20BC()
{
	for(;;)
	{
		if(self isstanceallowed("stand"))
		{
			var_00[0] = "stand allowed";
			var_01[0] = (0,1,0);
		}
		else
		{
			var_00[0] = "stand not allowed";
			var_01[0] = (1,0,0);
		}

		if(self isstanceallowed("crouch"))
		{
			var_00[1] = "crouch allowed";
			var_01[1] = (0,1,0);
		}
		else
		{
			var_00[1] = "crouch not allowed";
			var_01[1] = (1,0,0);
		}

		if(self isstanceallowed("prone"))
		{
			var_00[2] = "prone allowed";
			var_01[2] = (0,1,0);
		}
		else
		{
			var_00[2] = "prone not allowed";
			var_01[2] = (1,0,0);
		}

		var_02 = self getshootatpos() + (0,0,30);
		var_03 = (0,0,-10);
		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			var_05 = (var_02[0] + var_03[0] * var_04,var_02[1] + var_03[1] * var_04,var_02[2] + var_03[2] * var_04);
		}

		wait 0.05;
	}
}

//Function Number: 9
func_20BD()
{
	if(!isdefined(self.var_10F7) || !isdefined(self.moveplaybackrate))
	{
		func_20BE();
	}
}

//Function Number: 10
func_20BE()
{
	self.var_10F7 = 0.9 + randomfloat(0.2);
	self.var_1165 = 0.9 + randomfloat(0.2);
	self.moveplaybackrate = 1;
	self.var_FE0 = 1.35;
}

//Function Number: 11
func_20BF(param_00,param_01,param_02,param_03)
{
	anim waittill("new exceptions");
}

//Function Number: 12
empty(param_00,param_01,param_02,param_03)
{
}

//Function Number: 13
func_20C1()
{
	self endon("death");
	if(1)
	{
		return;
	}

	for(;;)
	{
		self waittill("enemy");
		if(!isalive(self.enemy))
		{
			continue;
		}

		while(isplayer(self.enemy))
		{
			if(animscripts/utility::func_F8C())
			{
				level.lastplayersighted = gettime();
			}

			wait 2;
		}
	}
}

//Function Number: 14
func_20C3()
{
	level.var_20C4[0] = -36.8552;
	level.var_20C4[1] = -27.0095;
	level.var_20C4[2] = -15.5981;
	level.var_20C4[3] = -4.37769;
	level.var_20C4[4] = 17.7776;
	level.var_20C4[5] = 59.8499;
	level.var_20C4[6] = 104.808;
	level.var_20C4[7] = 152.325;
	level.var_20C4[8] = 201.052;
	level.var_20C4[9] = 250.244;
	level.var_20C4[10] = 298.971;
	level.var_20C4[11] = 330.681;
}

//Function Number: 15
func_20C5()
{
	if(isdefined(level.var_20C6))
	{
		return;
	}

	anim.var_20C6 = 1;
	animscripts/animset::func_C64();
	anim.usefacialanims = 0;
	maps\_load::init_level_players();
	level.player.var_20C7 = 0;
	level.nextgrenadedrop = randomint(3);
	level.lastplayersighted = 100;
	anim.var_8BD = ::empty;
	func_20DF();
	setdvar("scr_expDeathMayMoveCheck","on");
	maps\_names::setup_names();
	anim.var_20C9 = 0;
	animscripts/init_move_transitions::func_2087();
	animscripts/reactions::func_F1C();
	anim.var_20CA = 10000;
	anim.var_20CB = 6000;
	func_20E2();
	func_20E8();
	animscripts/utility::func_20CC("none");
	if(!isdefined(level.var_20CD))
	{
		anim.var_20CF = ::animscripts/notetracks::func_20CE;
		anim.var_20CD = ::animscripts/notetracks::func_20D0;
	}

	if(!isdefined(level.var_20D1))
	{
		anim.var_20D1 = [];
	}

	if(!isdefined(level.var_20D2))
	{
		anim.var_20D2 = [];
	}

	anim.var_20D4 = ::animscripts/utility::func_20D3;
	level.fire_notetrack_functions["scripted"] = ::animscripts/notetracks::func_20D5;
	level.fire_notetrack_functions["cover_right"] = ::animscripts/notetracks::func_20D7;
	level.fire_notetrack_functions["cover_left"] = ::animscripts/notetracks::func_20D7;
	level.fire_notetrack_functions["cover_crouch"] = ::animscripts/notetracks::func_20D7;
	level.fire_notetrack_functions["cover_stand"] = ::animscripts/notetracks::func_20D7;
	level.fire_notetrack_functions["move"] = ::animscripts/notetracks::func_20D7;
	animscripts/notetracks::func_1E73();
	if(!isdefined(level.flag))
	{
		common_scripts\utility::init_flags();
	}

	maps\_gameskill::setskill();
	level.painai = undefined;
	animscripts/setposemovement::func_20D9();
	animscripts/face::func_C55();
	anim.var_20DA = animscripts/utility::array(1,2,2,2,3,3,3,3,4,4,5);
	anim.var_20DB = animscripts/utility::array(2,3,3,3,4,4,4,5,5);
	anim.var_20DC = animscripts/utility::array(1,2,2,3,3,4,4,4,4,5,5,5);
	anim.badplaces = [];
	anim.var_20DD = 0;
	anim.player = getentarray("player","classname")[0];
	func_20E0();
	func_20C3();
	animscripts/flashed::func_208E();
	animscripts/cqb::func_107A();
	func_20E1();
	func_209D();
	anim.var_D20 = -100000;
	func_20F5();
	level.player thread animscripts/combat_utility::func_20DE();
	thread func_20F0();
}

//Function Number: 16
func_20DF()
{
}

//Function Number: 17
func_20E0()
{
	animscripts/squadmanager::func_A5E();
	level.player thread animscripts/squadmanager::func_A78();
	animscripts/battlechatter::func_B6B();
	level.player thread animscripts/battlechatter_ai::func_AA9();
	anim thread animscripts/battlechatter::func_B9C();
}

//Function Number: 18
func_20E1()
{
	anim.var_D43 = randomintrange(0,15);
	anim.var_D6B = randomintrange(0,10);
	anim.var_D44 = gettime() + randomintrange(0,20000);
	anim.var_D42 = gettime() + randomintrange(0,10000);
	anim.var_D6C = gettime() + randomintrange(0,15000);
}

//Function Number: 19
func_20E2()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.var_20E3["fraggrenade"] = randomintrange(1000,20000);
		var_01.var_20E3["flash_grenade"] = randomintrange(1000,20000);
		var_01.var_20E3["double_grenade"] = randomintrange(1000,-5536);
		var_01.var_20E4 = 0;
		var_01.var_20E5 = -1000000;
		var_01.var_20E6 = -1000000;
		var_01 thread func_20F1();
	}

	level.var_20E3["AI_fraggrenade"] = randomintrange(0,20000);
	level.var_20E3["AI_flash_grenade"] = randomintrange(0,20000);
	level.var_20E3["AI_smoke_grenade_american"] = randomintrange(0,20000);
	animscripts/combat_utility::func_20E7();
}

//Function Number: 20
func_20E8()
{
	level.lastadvancetoenemytime = [];
	level.lastadvancetoenemytime["axis"] = 0;
	level.lastadvancetoenemytime["allies"] = 0;
	level.lastadvancetoenemytime["team3"] = 0;
	level.lastadvancetoenemytime["neutral"] = 0;
	level.var_20EA = [];
	level.var_20EA["axis"] = (0,0,0);
	level.var_20EA["allies"] = (0,0,0);
	level.var_20EA["team3"] = (0,0,0);
	level.var_20EA["neutral"] = (0,0,0);
	level.var_20EB = [];
	level.var_20EB["axis"] = (0,0,0);
	level.var_20EB["allies"] = (0,0,0);
	level.var_20EB["team3"] = (0,0,0);
	level.var_20EB["neutral"] = (0,0,0);
	level.var_20EC = [];
	level.var_20ED = [];
	level.var_20ED["axis"] = 0;
	level.var_20ED["allies"] = 0;
	level.var_20ED["team3"] = 0;
	level.var_20ED["neutral"] = 0;
	level.advancetoenemyinterval = 30000;
	level.advancetoenemygroupmax = 3;
}

//Function Number: 21
func_20F0()
{
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		var_02 = getaiarray();
		if(var_02.size == 0)
		{
			wait 0.05;
			var_00 = 0;
			continue;
		}

		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(!isdefined(var_02[var_03]))
			{
				continue;
			}

			var_02[var_03] notify("do_slow_things");
			var_00++;
			if(var_00 == var_01)
			{
				wait 0.05;
				var_00 = 0;
			}
		}
	}
}

//Function Number: 22
func_20F1()
{
	waittillframeend;
	if(isdefined(self.gs.playergrenaderangetime))
	{
		var_00 = int(self.gs.playergrenaderangetime * 0.7);
		if(var_00 < 1)
		{
			var_00 = 1;
		}

		self.var_20E3["fraggrenade"] = randomintrange(0,var_00);
		self.var_20E3["flash_grenade"] = randomintrange(0,var_00);
	}

	if(isdefined(self.gs.playerdoublegrenadetime))
	{
		var_00 = int(self.gs.playerdoublegrenadetime);
		var_01 = int(var_00 / 2);
		if(var_00 <= var_01)
		{
			var_00 = var_01 + 1;
		}

		self.var_20E3["double_grenade"] = randomintrange(var_01,var_00);
	}
}

//Function Number: 23
begingrenadetracking()
{
	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_00 thread maps\_utility::grenade_earthquake();
	}
}

//Function Number: 24
func_20F5()
{
	anim.var_20F6 = 60;
	anim.var_20F7 = [];
	for(var_00 = 0;var_00 < level.var_20F6;var_00++)
	{
		level.var_20F7[var_00] = var_00;
	}

	for(var_00 = 0;var_00 < level.var_20F6;var_00++)
	{
		var_01 = randomint(level.var_20F6);
		var_02 = level.var_20F7[var_00];
		level.var_20F7[var_00] = level.var_20F7[var_01];
		level.var_20F7[var_01] = var_02;
	}
}

//Function Number: 25
ondeath()
{
	if(isdefined(level.var_20F9))
	{
		return;
	}

	self waittill("death");
	if(!isdefined(self))
	{
		if(isdefined(self.a.var_20FA))
		{
			self.a.var_20FA delete();
		}
	}
}
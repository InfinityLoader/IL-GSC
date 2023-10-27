/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 408 ms
 * Timestamp: 10/27/2023 1:24:03 AM
*******************************************************************/

//Function Number: 1
initweapon(param_00)
{
	self.weaponinfo[param_00] = spawnstruct();
	self.weaponinfo[param_00].position = "none";
	self.weaponinfo[param_00].var_4003 = 1;
	if(getweaponclipmodel(param_00) != "")
	{
		self.weaponinfo[param_00].var_87A8 = 1;
		return;
	}

	self.weaponinfo[param_00].var_87A8 = 0;
}

//Function Number: 2
func_49B7(param_00)
{
	return isdefined(self.weaponinfo[param_00]);
}

//Function Number: 3
setglobalaimsettings()
{
	anim.covercrouchleanpitch = 55;
	anim.var_A54 = 10;
	anim.aimyawdiffclosedistsq = 4096;
	anim.var_A53 = 45;
	anim.aimpitchdifftolerance = 20;
	anim.var_5ABA = 25;
	anim.var_5AB8 = level.aimyawdiffclosedistsq;
	anim.var_5AB9 = level.var_A53;
	anim.var_5AB5 = 30;
	anim.var_50F0 = 65;
	anim.var_50EF = 65;
}

//Function Number: 4
everusessecondaryweapon()
{
	if(animscripts/utility::isshotgun(self.secondaryweapon))
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
func_4FDD()
{
	self.a = spawnstruct();
	self.a.var_4BDF = 0;
	self.primaryweapon = self.weapon;
	firstinit();
	if(self.primaryweapon == "")
	{
		self.primaryweapon = "none";
	}

	if(self.secondaryweapon == "")
	{
		self.secondaryweapon = "none";
	}

	if(self.var_7544 == "")
	{
		self.var_7544 = "none";
	}

	initweapon(self.primaryweapon);
	initweapon(self.secondaryweapon);
	initweapon(self.var_7544);
	self setdefaultaimlimits();
	self.a.var_8DB5["left"] = "none";
	self.a.var_8DB5["right"] = "none";
	self.a.var_8DB5["chest"] = "none";
	self.a.var_8DB5["back"] = "none";
	self.a.var_8DB6["left"] = "none";
	self.a.var_8DB6["right"] = "none";
	self.a.var_8DB6["chest"] = "none";
	self.a.var_8DB6["back"] = "none";
	self.lastweapon = self.weapon;
	self.root_anim = %root;
	thread begingrenadetracking();
	var_00 = animscripts/utility::func_87FA();
	self.a.var_55A8 = var_00;
	if(var_00)
	{
		thread animscripts/shared::func_68B3();
	}

	self.a.rockets = 3;
	self.a.var_66F8 = 1;
	self.a.var_60B1 = "stand";
	self.a.grenadethrowpose = "stand";
	self.a.var_5486 = "stop";
	self.a.state = "stop";
	self.a.var_78D0 = "none";
	self.a.var_3E10 = "none";
	self.a.var_6176 = -1;
	self.dropweapon = 1;
	self.var_525E = 750;
	animscripts/shared::placeweaponon(self.primaryweapon,"right");
	if(animscripts/utility::isshotgun(self.secondaryweapon))
	{
		animscripts/shared::placeweaponon(self.secondaryweapon,"back");
	}

	self.a.var_5593 = 0;
	self.a.var_1E56 = gettime();
	self.a.var_4C60 = gettime();
	self.a.var_7D67 = 0;
	self.a.disablelongdeath = !self isbadguy();
	self.a.var_4F4B = 0;
	self.a.var_5AB7 = 0;
	self.a.lastshoottime = 0;
	self.a.var_55EC = 0;
	self.a.var_63C9 = 0.8;
	if(self.team != "allies")
	{
		self.var_3FE4 = 1;
	}

	self.a.var_60DA = undefined;
	self.a.stance = "stand";
	self.chooseposefunc = ::animscripts/utility::choosepose;
	self._animactive = 0;
	self._lastanimtime = 0;
	thread func_2F29();
	self.baseaccuracy = 1;
	self.a.var_52F4 = 0;
	self.a.var_564F = 0;
	self.a.var_52F4 = 0;
	self.a.var_52F6 = 0;
	self.a.disablepain = 0;
	self.accuracystationarymod = 1;
	self.var_1B40 = 0;
	self.var_754D = 0;
	self.var_754C = 1;
	self.needrecalculategoodshootpos = 1;
	self.defaultturnthreshold = 55;
	self.a.nextstandinghitdying = 0;
	if(!isdefined(self.script_forcegrenade))
	{
		self.script_forcegrenade = 0;
	}

	func_7209();
	animscripts/weaponlist::refillclip();
	self.var_4C5F = 0;
	self.combattime = 0;
	self.var_7D64 = 0;
	self.var_7D66 = 0;
	if(self.team == "allies")
	{
		self.var_7D6A = 0.5;
	}
	else
	{
		self.var_7D6A = 0;
	}

	if(self.team == "allies")
	{
		self.var_6333 = 0;
	}
	else
	{
		self.var_6333 = 256;
	}

	self.ammocheatinterval = 8000;
	self.ammocheattime = 0;
	animscripts/animset::func_71B6();
	self.exception = [];
	self.exception["corner"] = 1;
	self.exception["cover_crouch"] = 1;
	self.exception["stop"] = 1;
	self.exception["stop_immediate"] = 1;
	self.exception["move"] = 1;
	self.exception["exposed"] = 1;
	self.exception["corner_normal"] = 1;
	var_01 = getarraykeys(self.exception);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::clear_exception(var_01[var_02]);
	}

	self.var_63AC = 0;
	thread func_7077();
	self.shouldconserveammotime = 0;
	if(!isdefined(level.var_27B5))
	{
		thread animscripts/combat_utility::func_538C();
	}

	thread ondeath();
}

//Function Number: 6
func_8DBE(param_00)
{
	var_01[0] = "m4_grenadier";
	var_01[1] = "m4_grunt";
	var_01[2] = "m4_silencer";
	var_01[3] = "m4m203";
	if(!isdefined(param_00))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(issubstr(param_00,var_01[var_02]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_7077()
{
	self endon("death");
	if(!isdefined(level.var_4EA0))
	{
		level waittill("loadout complete");
	}

	maps\_names::get_name();
	thread animscripts/squadmanager::addtosquad();
}

//Function Number: 8
func_6093()
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

		wait(0.05);
	}
}

//Function Number: 9
func_7209()
{
	if(!isdefined(self.animplaybackrate) || !isdefined(self.moveplaybackrate))
	{
		func_6E33();
	}
}

//Function Number: 10
func_6E33()
{
	self.animplaybackrate = 0.9 + randomfloat(0.2);
	self.var_54C3 = 0.9 + randomfloat(0.2);
	self.moveplaybackrate = 1;
	self.sidesteprate = 1.35;
}

//Function Number: 11
func_44D1(param_00,param_01,param_02,param_03)
{
	anim waittill("new exceptions");
}

//Function Number: 12
empty(param_00,param_01,param_02,param_03)
{
}

//Function Number: 13
func_2F29()
{
	self endon("death");
	if(1)
	{
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
			if(animscripts/utility::hasenemysightpos())
			{
				level.var_4C8A = gettime();
			}

			wait(2);
		}
	}
}

//Function Number: 14
initwindowtraverse()
{
	level.var_8DFE[0] = -36.8552;
	level.var_8DFE[1] = -27.0095;
	level.var_8DFE[2] = -15.5981;
	level.var_8DFE[3] = -4.37769;
	level.var_8DFE[4] = 17.7776;
	level.var_8DFE[5] = 59.8499;
	level.var_8DFE[6] = 104.808;
	level.var_8DFE[7] = 152.325;
	level.var_8DFE[8] = 201.052;
	level.var_8DFE[9] = 250.244;
	level.var_8DFE[10] = 298.971;
	level.var_8DFE[11] = 330.681;
}

//Function Number: 15
firstinit()
{
	if(isdefined(level.notfirsttime))
	{
	}

	anim.notfirsttime = 1;
	animscripts/animset::func_44EB();
	anim.var_87B9 = 0;
	maps\_load::func_4561();
	level.player.var_47A9 = 0;
	level.nextgrenadedrop = randomint(3);
	level.var_4C8A = 100;
	anim.defaultexception = ::empty;
	func_4600();
	setdvar("scr_expDeathMayMoveCheck","on");
	maps\_names::func_7193();
	anim.animflagnameindex = 0;
	animscripts/init_move_transitions::initmovestartstoptransitions();
	anim.combatmemorytimeconst = 10000;
	anim.var_1E5E = 6000;
	func_4613();
	func_45D4();
	if(!isdefined(level.var_59D0))
	{
		anim.var_59D2 = ::animscripts/notetracks::func_600A;
		anim.var_59D0 = ::animscripts/notetracks::func_6009;
	}

	if(!isdefined(level.var_59D1))
	{
		anim.var_59D1 = [];
	}

	if(!isdefined(level.var_59D3))
	{
		anim.var_59D3 = [];
	}

	if(!isdefined(level.var_7436))
	{
		anim.var_7436 = ::animscripts/utility::func_7438;
	}

	if(!isdefined(level.var_7449))
	{
		anim.var_7449 = ::animscripts/utility::func_7448;
	}

	level.var_32D4["scripted"] = ::animscripts/notetracks::func_32E8;
	level.var_32D4["cover_right"] = ::animscripts/notetracks::func_7442;
	level.var_32D4["cover_left"] = ::animscripts/notetracks::func_7442;
	level.var_32D4["cover_crouch"] = ::animscripts/notetracks::func_7442;
	level.var_32D4["cover_stand"] = ::animscripts/notetracks::func_7442;
	level.var_32D4["move"] = ::animscripts/notetracks::func_7442;
	animscripts/notetracks::func_646F();
	if(!isdefined(level.flag))
	{
		common_scripts\utility::func_4549();
	}

	maps\_gameskill::func_70C9();
	level.painai = undefined;
	animscripts/setposemovement::func_4645();
	animscripts/face::func_4633();
	anim.burstfirenumshots = animscripts/utility::func_ED8(1,2,2,2,3,3,3,3,4,4,5);
	anim.fastburstfirenumshots = animscripts/utility::func_ED8(2,3,3,3,4,4,4,5,5);
	anim.var_6D8B = animscripts/utility::func_ED8(1,2,2,3,3,4,4,4,4,5,5,5);
	anim.badplaces = [];
	anim.badplaceint = 0;
	anim.player = getentarray("player","classname")[0];
	initbattlechatter();
	initwindowtraverse();
	animscripts/cqb::setupcqbpointsofinterest();
	func_45FE();
	setglobalaimsettings();
	anim.lastcarexplosiontime = -100000;
	func_7207();
	level.player thread animscripts/combat_utility::func_8D14();
	thread aiturnnotifies();
}

//Function Number: 16
func_4600()
{
}

//Function Number: 17
initbattlechatter()
{
	animscripts/squadmanager::func_45AF();
	level.player thread animscripts/squadmanager::addplayertosquad();
	animscripts/battlechatter::func_4519();
	level.player thread animscripts/battlechatter_ai::func_99A();
	anim thread animscripts/battlechatter::bcsdebugwaiter();
}

//Function Number: 18
func_45FE()
{
	anim.var_5780 = randomintrange(0,15);
	anim.var_577F = randomintrange(0,10);
	anim.var_55E6 = gettime() + randomintrange(0,20000);
	anim.var_55E7 = gettime() + randomintrange(0,10000);
	anim.var_55E5 = gettime() + randomintrange(0,15000);
}

//Function Number: 19
func_4613()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.grenadetimers["fraggrenade"] = randomintrange(1000,20000);
		var_01.grenadetimers["flash_grenade"] = randomintrange(1000,20000);
		var_01.grenadetimers["double_grenade"] = randomintrange(1000,-5536);
		var_01.numgrenadesinprogresstowardsplayer = 0;
		var_01.lastgrenadelandednearplayertime = -1000000;
		var_01.lastfraggrenadetoplayerstart = -1000000;
		var_01 thread func_707A();
	}

	level.grenadetimers["AI_fraggrenade"] = randomintrange(0,20000);
	level.grenadetimers["AI_flash_grenade"] = randomintrange(0,20000);
	level.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0,20000);
	animscripts/combat_utility::func_4614();
}

//Function Number: 20
func_45D4()
{
	level.var_4C39 = [];
	level.var_4C39["axis"] = 0;
	level.var_4C39["allies"] = 0;
	level.var_4C39["team3"] = 0;
	level.var_4C39["neutral"] = 0;
	level.lastadvancetoenemydest = [];
	level.lastadvancetoenemydest["axis"] = (0,0,0);
	level.lastadvancetoenemydest["allies"] = (0,0,0);
	level.lastadvancetoenemydest["team3"] = (0,0,0);
	level.lastadvancetoenemydest["neutral"] = (0,0,0);
	level.lastadvancetoenemysrc = [];
	level.lastadvancetoenemysrc["axis"] = (0,0,0);
	level.lastadvancetoenemysrc["allies"] = (0,0,0);
	level.lastadvancetoenemysrc["team3"] = (0,0,0);
	level.lastadvancetoenemysrc["neutral"] = (0,0,0);
	level.lastadvancetoenemyattacker = [];
	level.advancetoenemygroup = [];
	level.advancetoenemygroup["axis"] = 0;
	level.advancetoenemygroup["allies"] = 0;
	level.advancetoenemygroup["team3"] = 0;
	level.advancetoenemygroup["neutral"] = 0;
	level.advancetoenemyinterval = 30000;
	level.advancetoenemygroupmax = 3;
}

//Function Number: 21
aiturnnotifies()
{
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		var_02 = getaiarray();
		if(var_02.size == 0)
		{
			wait(0.05);
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
				wait(0.05);
				var_00 = 0;
			}
		}
	}
}

//Function Number: 22
func_707A()
{
	waittillframeend;
	if(isdefined(self.var_3DE2.playergrenaderangetime))
	{
		var_00 = int(self.var_3DE2.playergrenaderangetime * 0.7);
		if(var_00 < 1)
		{
			var_00 = 1;
		}

		self.grenadetimers["fraggrenade"] = randomintrange(0,var_00);
		self.grenadetimers["flash_grenade"] = randomintrange(0,var_00);
	}

	if(isdefined(self.var_3DE2.var_5FA5))
	{
		var_00 = int(self.var_3DE2.var_5FA5);
		var_01 = int(var_00 / 2);
		if(var_00 <= var_01)
		{
			var_00 = var_01 + 1;
		}

		self.grenadetimers["double_grenade"] = randomintrange(var_01,var_00);
	}
}

//Function Number: 23
begingrenadetracking()
{
	if(isdefined(level.disablegrenadetracking))
	{
	}

	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_00 thread maps\_utility::func_3DA7();
	}
}

//Function Number: 24
func_7207()
{
	anim.var_6337 = 60;
	anim.randominttable = [];
	for(var_00 = 0;var_00 < level.var_6337;var_00++)
	{
		level.randominttable[var_00] = var_00;
	}

	for(var_00 = 0;var_00 < level.var_6337;var_00++)
	{
		var_01 = randomint(level.var_6337);
		var_02 = level.randominttable[var_00];
		level.randominttable[var_00] = level.randominttable[var_01];
		level.randominttable[var_01] = var_02;
	}
}

//Function Number: 25
ondeath()
{
	if(isdefined(level.var_27BE))
	{
	}

	self waittill("death");
	if(!isdefined(self))
	{
		if(isdefined(self.a.var_87FF))
		{
			self.a.var_87FF delete();
		}
	}
}
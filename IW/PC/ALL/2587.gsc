/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2587.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 115
 * Decompile Time: 8 ms
 * Timestamp: 10/27/2023 12:23:25 AM
*******************************************************************/

//Function Number: 1
func_2980(param_00,param_01)
{
	self.var_1198.var_1FC7[param_00] = param_01;
}

//Function Number: 2
func_2927(param_00)
{
	if(isdefined(self.var_1198.var_1FC7) && isdefined(self.var_1198.var_1FC7[param_00]))
	{
		return self.var_1198.var_1FC7[param_00];
	}

	return undefined;
}

//Function Number: 3
func_2928(param_00)
{
	var_01 = func_2927(param_00);
	if(isdefined(var_01) && var_01.size > 0)
	{
		return var_01 + "_";
	}

	return undefined;
}

//Function Number: 4
func_298E()
{
	if(isdefined(self.var_1198.var_B633) && self.var_1198.var_B633)
	{
		return 1;
	}

	if(isdefined(self.var_1198.var_3323))
	{
		return self.var_1198.var_3323;
	}

	return 0;
}

//Function Number: 5
func_9DA4(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == param_03;
}

//Function Number: 6
func_296A(param_00)
{
	self.var_1198.var_527D = param_00;
}

//Function Number: 7
func_292C()
{
	return self.var_1198.var_527D;
}

//Function Number: 8
func_2949(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_527D == param_03;
}

//Function Number: 9
func_297E(param_00)
{
	self.var_1198.var_2B11 = !isdefined(param_00) || param_00;
}

//Function Number: 10
func_2941()
{
	if(isdefined(self.var_1198.var_2B11))
	{
		return self.var_1198.var_2B11;
	}

	return 0;
}

//Function Number: 11
func_294D(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::func_13C07(self.var_394) == param_03;
}

//Function Number: 12
func_2986(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::func_13C07(self.var_394) != "rocketlauncher")
	{
		return 0;
	}

	var_04 = func_292E();
	if(!isdefined(var_04))
	{
		return 0;
	}

	return var_04 != "rocketlauncher";
}

//Function Number: 13
func_2967()
{
}

//Function Number: 14
func_2917()
{
}

//Function Number: 15
func_2955()
{
	return self method_8542();
}

//Function Number: 16
func_2958(param_00,param_01,param_02,param_03)
{
	return !self method_8542();
}

//Function Number: 17
func_2956(param_00)
{
	return self.var_1198.var_BD23 == param_00;
}

//Function Number: 18
func_2968(param_00)
{
	self.var_1198.var_BD23 = param_00;
	if(param_00 == "cqb")
	{
		self.var_2303.var_13CAF = 0;
	}
}

//Function Number: 19
func_2970(param_00)
{
	self.var_1198.var_13CC2 = param_00;
}

//Function Number: 20
func_2919()
{
	self.var_1198.var_13CC2 = undefined;
}

//Function Number: 21
func_292E()
{
	return self.var_1198.var_13CC2;
}

//Function Number: 22
func_2969(param_00)
{
	if(!isdefined(param_00))
	{
		self.var_1198.var_2FC8 = 1;
		return;
	}

	self.var_1198.var_2FC8 = param_00;
}

//Function Number: 23
func_2959()
{
	if(isdefined(self.var_1198.var_2FC8))
	{
		return self.var_1198.var_2FC8;
	}

	return 0;
}

//Function Number: 24
func_296C(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		self.var_1198.var_313B = 1;
	}
	else
	{
		self.var_1198.var_313B = param_00;
	}

	if(self.var_1198.var_313B)
	{
		self.var_1198.var_11815 = param_01;
		return;
	}

	self.var_1198.var_11815 = undefined;
}

//Function Number: 25
func_298A()
{
	if(isdefined(self.var_1198.var_313B))
	{
		return self.var_1198.var_313B && isdefined(self.var_1198.var_11815);
	}

	return 0;
}

//Function Number: 26
func_2930()
{
	return self.var_1198.var_11815;
}

//Function Number: 27
func_296D(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		self.var_1198.var_313D = 1;
	}
	else
	{
		self.var_1198.var_313D = param_00;
	}

	if(self.var_1198.var_313D)
	{
		self.var_1198.var_1182F = param_01;
		return;
	}

	self.var_1198.var_1182F = undefined;
}

//Function Number: 28
func_298B()
{
	if(isdefined(self.var_1198.var_313D))
	{
		return self.var_1198.var_313D && isdefined(self.var_1198.var_1182F);
	}

	return 0;
}

//Function Number: 29
func_2931()
{
	return self.var_1198.var_1182F;
}

//Function Number: 30
func_2962(param_00)
{
	if(!isdefined(param_00))
	{
		self.var_1198.var_2AA6 = 1;
		return;
	}

	self.var_1198.var_2AA6 = param_00;
}

//Function Number: 31
func_291C()
{
	if(isdefined(self.var_1198.var_2AA6))
	{
		return self.var_1198.var_2AA6;
	}

	return 0;
}

//Function Number: 32
func_2983(param_00,param_01)
{
	self.var_1198.var_FECD = param_00;
	if(isdefined(param_00))
	{
		self.var_1198.var_FECD.target = param_01;
		if(isdefined(param_01))
		{
			self.var_1198.var_FECD.var_3137 = 1;
			return;
		}

		self.var_1198.var_FECD.var_3137 = undefined;
	}
}

//Function Number: 33
func_2985()
{
	if(isdefined(self.var_1198.var_FECD))
	{
		if(isdefined(self.var_FED1) && isdefined(self.var_1198.var_FECD.var_D699))
		{
			return 1;
		}

		if(isdefined(self.var_595D) && self.var_595D)
		{
			return 0;
		}

		if(isdefined(self.var_1198.var_FECD.target) && isdefined(self.var_10C) && self.var_10C == self.var_1198.var_FECD.target)
		{
			return scripts\common\utility::func_9DA3();
		}
	}

	return 0;
}

//Function Number: 34
func_2961(param_00)
{
	self.var_1198.var_474D = param_00;
}

//Function Number: 35
func_292B()
{
	if(!isdefined(self.var_1198.var_474D))
	{
		return "none";
	}

	return self.var_1198.var_474D;
}

//Function Number: 36
func_2948(param_00,param_01,param_02,param_03)
{
	return func_292B() == param_03;
}

//Function Number: 37
func_2944(param_00,param_01,param_02,param_03)
{
	return func_292B() != param_03;
}

//Function Number: 38
func_295E(param_00)
{
	self.var_1198.var_4720 = param_00;
}

//Function Number: 39
func_2929()
{
	return self.var_1198.var_4720;
}

//Function Number: 40
func_2947(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_4720) && self.var_1198.var_4720 == param_03;
}

//Function Number: 41
func_2946(param_00,param_01,param_02,param_03)
{
	return func_292B() == "exposed" && func_2947(param_00,param_01,param_02,param_03);
}

//Function Number: 42
func_2943(param_00,param_01,param_02,param_03)
{
	return func_292B() != "exposed" || !func_2947(param_00,param_01,param_02,param_03);
}

//Function Number: 43
func_295D(param_00)
{
	self.var_1198.var_2996 = param_00;
}

//Function Number: 44
func_291A()
{
	return isdefined(self.var_1198.var_2996) && self.var_1198.var_2996;
}

//Function Number: 45
func_2976(param_00)
{
	self.var_1198.var_473C = param_00;
	self.var_1198.var_2AB3 = isdefined(param_00);
}

//Function Number: 46
func_2932()
{
	return isdefined(self.var_1198.var_2AB3) && self.var_1198.var_2AB3;
}

//Function Number: 47
func_2920()
{
	return self.var_1198.var_473C;
}

//Function Number: 48
func_292D()
{
	if(isdefined(self.var_1198.var_E1AE))
	{
		return self.var_1198.var_E1AE;
	}

	return undefined;
}

//Function Number: 49
func_296E(param_00)
{
	self.var_1198.var_E1AE = param_00;
}

//Function Number: 50
func_296F(param_00)
{
	self.var_1198.var_E1AF = param_00;
}

//Function Number: 51
func_2934(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_10171) && isdefined(self.var_205) && self.var_1198.var_10171 == self.var_205 && distancesquared(self.var_205.origin,self.origin) > 16;
}

//Function Number: 52
func_2936(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_1198.var_10171))
	{
		return 0;
	}

	if(!isdefined(self.var_205))
	{
		return 0;
	}

	if(self.var_1198.var_10171 != self.var_205)
	{
		return 0;
	}

	if(distancesquared(self.var_205.origin,self.origin) <= 16)
	{
		return 0;
	}

	if(self.var_1198.var_10171.type != param_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
func_9F53(param_00,param_01)
{
	var_02 = vectornormalize(param_00.origin - self.origin);
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectorcross(var_03,var_02);
	if(var_04[2] > 0 && param_01 == "left")
	{
		return 1;
	}

	if(var_04[2] < 0 && param_01 == "right")
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
func_2935(param_00,param_01,param_02,param_03)
{
	if(!func_2934(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	return func_9F53(self.var_1198.var_10171,param_03);
}

//Function Number: 55
func_2933(param_00,param_01,param_02,param_03)
{
	if(!func_2934(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	if(!func_9F53(self.var_1198.var_10171,param_03))
	{
		return 0;
	}

	if(param_03 == "right")
	{
		return self.var_1198.var_1016B.type == "Cover Right" && self.var_1198.var_10171.type == "Cover Left";
	}

	return self.var_1198.var_1016B.type == "Cover Left" && self.var_1198.var_10171.type == "Cover Right";
}

//Function Number: 56
func_2973()
{
	self.var_1198.var_1FCD = 1;
}

//Function Number: 57
func_2911()
{
	self.var_1198.var_1FCD = 0;
}

//Function Number: 58
func_2938()
{
	if(!isdefined(self.script))
	{
		return 0;
	}

	return self.script == "scripted" || self.script == "<custom>" || scripts\common\utility::istrue(self.var_1198.var_1FCD);
}

//Function Number: 59
func_2965(param_00)
{
	self.var_1198.var_B633 = 1;
	self.var_1198.var_B638 = param_00;
	self.var_1198.var_B637 = 0;
}

//Function Number: 60
func_2925()
{
	if(!isdefined(self.var_1198.var_B633))
	{
		return undefined;
	}

	return self.var_1198.var_B638;
}

//Function Number: 61
func_2914()
{
	self.var_1198.var_B633 = undefined;
	self.var_1198.var_B638 = undefined;
}

//Function Number: 62
func_2915()
{
	self.var_1198.var_B637 = undefined;
}

//Function Number: 63
func_2952(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_B637);
}

//Function Number: 64
func_2951(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_B637) && self.var_1198.var_B637;
}

//Function Number: 65
func_2953(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_B633) && self.var_1198.var_B633;
}

//Function Number: 66
func_2954(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_B55B))
	{
		return 1;
	}

	if(!isdefined(self.var_B55B.target))
	{
		return 1;
	}

	return 0;
}

//Function Number: 67
func_2966(param_00,param_01)
{
	self.var_1198.var_B634 = 1;
	self.var_1198.var_B635 = param_00;
	self.var_1198.var_B636 = param_01;
}

//Function Number: 68
func_2913()
{
	self.var_1198.var_B634 = undefined;
	self.var_1198.var_B635 = undefined;
	self.var_1198.var_B636 = undefined;
}

//Function Number: 69
func_2950(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_B634) && self.var_1198.var_B634 && isdefined(self.var_233);
}

//Function Number: 70
func_2957(param_00,param_01,param_02,param_03)
{
	return !func_2950(param_00,param_01,param_02,param_03);
}

//Function Number: 71
func_294F(param_00,param_01,param_02,param_03)
{
	if(func_2950(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 72
func_2923()
{
	if(!isdefined(self.var_1198.var_B634))
	{
		return undefined;
	}

	return self.var_1198.var_B635;
}

//Function Number: 73
func_2924()
{
	return self.var_1198.var_B636;
}

//Function Number: 74
func_2964(param_00)
{
	self.var_1198.var_2AB0 = param_00;
}

//Function Number: 75
func_293D(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_2AB0) && self.var_1198.var_2AB0;
}

//Function Number: 76
func_2963(param_00)
{
	self.var_1198.var_2AAF = param_00;
}

//Function Number: 77
func_293C()
{
	return isdefined(self.var_1198.var_2AAF) && self.var_1198.var_2AAF;
}

//Function Number: 78
func_2971(param_00)
{
	self.var_1198.var_13D14 = param_00;
}

//Function Number: 79
func_294E()
{
	return isdefined(self.var_1198.var_13D14);
}

//Function Number: 80
func_292F()
{
	return self.var_1198.var_13D14;
}

//Function Number: 81
func_293B()
{
	var_00 = func_2920();
	if(!isdefined(var_00))
	{
		var_00 = self.var_205;
	}

	var_01 = isdefined(var_00) && var_00.type == "Conceal Crouch" || var_00.type == "Conceal Stand";
	return self.var_1198.var_BD23 == "frantic" && !var_01;
}

//Function Number: 82
func_2942()
{
	var_00 = func_2926();
	if(isdefined(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
func_2926()
{
	var_00 = 0;
	var_01 = undefined;
	if(!isdefined(self.var_1198.var_5665))
	{
		return var_01;
	}

	if(isdefined(self.var_1198.var_5665["left_leg"]))
	{
		var_00++;
		var_01 = "left";
	}

	if(isdefined(self.var_1198.var_5665["right_leg"]))
	{
		var_00++;
		var_01 = "right";
	}

	if(var_00 == 2)
	{
		var_01 = "both";
	}

	return var_01;
}

//Function Number: 84
func_9ED3(param_00)
{
	if(!isdefined(self.var_1198))
	{
		return 0;
	}

	if(isdefined(self.var_1198.var_EF3B))
	{
		if(!isdefined(self.var_1198.var_EF3B[param_00]))
		{
			return 0;
		}

		return self.var_1198.var_EF3B[param_00].var_10E19 == "dismember";
	}

	if(!isdefined(self.var_1198.var_5665))
	{
		return 0;
	}

	return isdefined(self.var_1198.var_5665[param_00]);
}

//Function Number: 85
func_2945(param_00,param_01,param_02,param_03)
{
	return func_9ED3(param_03);
}

//Function Number: 86
func_13919(param_00)
{
	if(isdefined(self.var_1198.var_EF3B))
	{
		if(!isdefined(self.var_1198.var_EF3B[param_00]))
		{
			return 0;
		}

		if(self.var_1198.var_EF3B[param_00].var_10E19 != "dismember")
		{
			return 0;
		}

		return self.var_1198.var_EF3B[param_00].time == gettime();
	}

	if(!isdefined(self.var_1198.var_5665))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.var_5665[param_00]))
	{
		return 0;
	}

	return self.var_1198.var_5665[param_00] == gettime();
}

//Function Number: 87
func_298F(param_00,param_01,param_02,param_03)
{
	return func_13919(param_03);
}

//Function Number: 88
func_2991(param_00,param_01,param_02,param_03)
{
	return func_9ED3(param_03[0]) && func_13919(param_03[1]);
}

//Function Number: 89
func_291B(param_00)
{
	self.var_1198.var_5665[param_00] = gettime();
}

//Function Number: 90
func_2982(param_00)
{
	self.var_1198.var_F1EB = param_00;
}

//Function Number: 91
func_294B()
{
	if(!isdefined(self.var_1198.var_F1EB))
	{
		if(isdefined(self.var_3135.var_72DD) && gettime() > self.var_3135.var_72DD)
		{
			self.var_1198.var_F1EB = 1;
		}
	}

	return isdefined(self.var_1198.var_F1EB);
}

//Function Number: 92
func_2972()
{
	self.var_1198.var_F1FF = 1;
}

//Function Number: 93
func_2988()
{
	return isdefined(self.var_1198.var_F1FF);
}

//Function Number: 94
func_297C(param_00)
{
	self.var_1198.var_9E22 = param_00;
}

//Function Number: 95
func_293F()
{
	if(isdefined(self.var_3135.var_4882))
	{
		return 0;
	}

	return isdefined(self.var_1198.var_9E22);
}

//Function Number: 96
func_2974(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = "left";
	if(param_00 == var_02)
	{
		var_02 = "right";
	}

	if(isdefined(self.var_1198.var_E5E7) && isdefined(self.var_1198.var_E5E7[var_02]))
	{
		self.var_1198.var_E5E7[var_02] = 0;
		self.var_1198.var_E5E7[param_00] = 0;
		return;
	}

	self.var_1198.var_E5E7[param_00] = param_01;
}

//Function Number: 97
func_2910(param_00)
{
	if(!isdefined(self.var_1198.var_E5E7))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.var_E5E7[param_00]))
	{
		return 0;
	}

	if(!self.var_1198.var_E5E7[param_00])
	{
		return 0;
	}

	return 1;
}

//Function Number: 98
func_2981(param_00)
{
	self.var_1198.var_E5FF = param_00;
}

//Function Number: 99
func_2918(param_00)
{
	self.var_1198.var_E600 = undefined;
}

//Function Number: 100
func_294A(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_1198.var_E5FF))
	{
		return 0;
	}

	return 1;
}

//Function Number: 101
func_297F(param_00)
{
	self.var_B55B = spawnstruct();
	param_00.var_B55B = spawnstruct();
	self.var_B55B.target = param_00;
	self.var_B55B.var_C92C = param_00;
	param_00.var_B55B.var_C92C = self;
}

//Function Number: 102
func_2916()
{
	if(!isdefined(self.var_B55B))
	{
		return;
	}

	if(isdefined(self.var_B55B.target))
	{
		self.var_B55B.target.var_B55B = undefined;
	}

	if(isdefined(self.var_B55B.var_1168C))
	{
		self.var_B55B.var_1168C delete();
	}

	self.var_B55B = undefined;
}

//Function Number: 103
func_2977(param_00)
{
	self.var_1198.var_4879 = param_00;
}

//Function Number: 104
func_293A()
{
	return isdefined(self.var_1198.var_4879);
}

//Function Number: 105
func_297B(param_00)
{
	self.var_1198.var_8C52 = param_00;
}

//Function Number: 106
func_293E()
{
	return isdefined(self.var_1198.var_8C52);
}

//Function Number: 107
func_2922()
{
	return self.var_1198.var_8C52;
}

//Function Number: 108
func_297D(param_00)
{
	self.var_1198.var_2992 = param_00;
}

//Function Number: 109
func_2940()
{
	return isdefined(self.var_1198.var_2992) && self.var_1198.var_2992;
}

//Function Number: 110
func_2975(param_00)
{
	self.var_1198.var_3FEC = param_00;
	self.var_1198.var_3FED = gettime();
}

//Function Number: 111
func_291D(param_00)
{
	return self.var_1198.var_3FEC;
}

//Function Number: 112
func_291E()
{
	return self.var_1198.var_3FED;
}

//Function Number: 113
func_1005F(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_2F39) || !self.var_2F39;
}

//Function Number: 114
func_294C()
{
	return isdefined(self.var_1198.var_FEED) && self.var_1198.var_FEED;
}

//Function Number: 115
func_2984(param_00)
{
	self.var_1198.var_FEED = param_00;
}
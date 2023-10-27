/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_final_killcam.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 433 ms
 * Timestamp: 10/27/2023 12:20:16 AM
*******************************************************************/

//Function Number: 1
func_9807()
{
	level.var_6C63 = [];
	level.var_6C6E = [];
	level.var_6C5D = [];
	level.var_6C60 = [];
	level.var_6C64 = [];
	level.var_6C65 = [];
	level.var_6C66 = [];
	level.var_6C67 = [];
	level.var_6C68 = [];
	level.finalkillcam_killcamentitystickstovictim = [];
	level.var_6C6B = [];
	level.var_6C62 = [];
	level.var_6C69 = [];
	level.var_6C6D = [];
	level.var_6C6C = [];
	level.var_6C6A = [];
	level.var_6C61 = [];
	level.var_6C5E = [];
	level.var_6C5F = [];
	level.finalkillcam_killstreakvariantinfo = [];
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			level.var_6C63[var_01] = undefined;
			level.var_6C6E[var_01] = undefined;
			level.var_6C5D[var_01] = undefined;
			level.var_6C60[var_01] = undefined;
			level.var_6C64[var_01] = undefined;
			level.var_6C65[var_01] = undefined;
			level.var_6C66[var_01] = undefined;
			level.var_6C67[var_01] = undefined;
			level.var_6C68[var_01] = undefined;
			level.finalkillcam_killcamentitystickstovictim[var_01] = undefined;
			level.var_6C6B[var_01] = undefined;
			level.var_6C62[var_01] = undefined;
			level.var_6C69[var_01] = undefined;
			level.var_6C6D[var_01] = undefined;
			level.var_6C6C[var_01] = undefined;
			level.var_6C6A[var_01] = undefined;
			level.var_6C61[var_01] = undefined;
			level.var_6C5E[var_01] = undefined;
			level.var_6C5F[var_01] = undefined;
			level.finalkillcam_killstreakvariantinfo[var_01] = undefined;
		}
	}
	else
	{
		level.var_6C63["axis"] = undefined;
		level.var_6C6E["axis"] = undefined;
		level.var_6C5D["axis"] = undefined;
		level.var_6C60["axis"] = undefined;
		level.var_6C64["axis"] = undefined;
		level.var_6C65["axis"] = undefined;
		level.var_6C66["axis"] = undefined;
		level.var_6C67["axis"] = undefined;
		level.var_6C68["axis"] = undefined;
		level.finalkillcam_killcamentitystickstovictim["axis"] = undefined;
		level.var_6C6B["axis"] = undefined;
		level.var_6C62["axis"] = undefined;
		level.var_6C69["axis"] = undefined;
		level.var_6C6D["axis"] = undefined;
		level.var_6C6C["axis"] = undefined;
		level.var_6C6A["axis"] = undefined;
		level.var_6C61["axis"] = undefined;
		level.var_6C5E["axis"] = undefined;
		level.var_6C5F["axis"] = undefined;
		level.finalkillcam_killstreakvariantinfo["axis"] = undefined;
		level.var_6C63["allies"] = undefined;
		level.var_6C6E["allies"] = undefined;
		level.var_6C5D["allies"] = undefined;
		level.var_6C60["allies"] = undefined;
		level.var_6C64["allies"] = undefined;
		level.var_6C65["allies"] = undefined;
		level.var_6C66["allies"] = undefined;
		level.var_6C67["allies"] = undefined;
		level.var_6C68["allies"] = undefined;
		level.finalkillcam_killcamentitystickstovictim["allies"] = undefined;
		level.var_6C6B["allies"] = undefined;
		level.var_6C62["allies"] = undefined;
		level.var_6C69["allies"] = undefined;
		level.var_6C6D["allies"] = undefined;
		level.var_6C6C["allies"] = undefined;
		level.var_6C6A["allies"] = undefined;
		level.var_6C61["allies"] = undefined;
		level.var_6C5E["allies"] = undefined;
		level.var_6C5F["allies"] = undefined;
		level.finalkillcam_killstreakvariantinfo["allies"] = undefined;
	}

	level.var_6C63["none"] = undefined;
	level.var_6C6E["none"] = undefined;
	level.var_6C5D["none"] = undefined;
	level.var_6C60["none"] = undefined;
	level.var_6C64["none"] = undefined;
	level.var_6C65["none"] = undefined;
	level.var_6C66["none"] = undefined;
	level.var_6C67["none"] = undefined;
	level.var_6C68["none"] = undefined;
	level.finalkillcam_killcamentitystickstovictim["none"] = undefined;
	level.var_6C6B["none"] = undefined;
	level.var_6C62["none"] = undefined;
	level.var_6C69["none"] = undefined;
	level.var_6C6D["none"] = undefined;
	level.var_6C6C["none"] = undefined;
	level.var_6C6A["none"] = undefined;
	level.var_6C61["none"] = undefined;
	level.var_6C5E["none"] = undefined;
	level.var_6C5F["none"] = undefined;
	level.finalkillcam_killstreakvariantinfo["none"] = undefined;
	level.var_6C6F = undefined;
	level.var_DDEE = 1;
}

//Function Number: 2
func_66BC()
{
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			level.var_6C63[level.teamnamelist[var_00]] = undefined;
			level.var_6C6E[level.teamnamelist[var_00]] = undefined;
			level.var_6C5D[level.teamnamelist[var_00]] = undefined;
			level.var_6C60[level.teamnamelist[var_00]] = undefined;
			level.var_6C64[level.teamnamelist[var_00]] = undefined;
			level.var_6C65[level.teamnamelist[var_00]] = undefined;
			level.var_6C66[level.teamnamelist[var_00]] = undefined;
			level.var_6C67[level.teamnamelist[var_00]] = undefined;
			level.var_6C68[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killcamentitystickstovictim[level.teamnamelist[var_00]] = undefined;
			level.var_6C6B[level.teamnamelist[var_00]] = undefined;
			level.var_6C62[level.teamnamelist[var_00]] = undefined;
			level.var_6C69[level.teamnamelist[var_00]] = undefined;
			level.var_6C6D[level.teamnamelist[var_00]] = undefined;
			level.var_6C6C[level.teamnamelist[var_00]] = undefined;
			level.var_6C6A[level.teamnamelist[var_00]] = undefined;
			level.var_6C61[level.teamnamelist[var_00]] = undefined;
			level.var_6C5E[level.teamnamelist[var_00]] = undefined;
			level.var_6C5F[level.teamnamelist[var_00]] = undefined;
			level.finalkillcam_killstreakvariantinfo[level.teamnamelist[var_00]] = undefined;
		}
	}
	else
	{
		level.var_6C63["axis"] = undefined;
		level.var_6C6E["axis"] = undefined;
		level.var_6C5D["axis"] = undefined;
		level.var_6C60["axis"] = undefined;
		level.var_6C64["axis"] = undefined;
		level.var_6C65["axis"] = undefined;
		level.var_6C66["axis"] = undefined;
		level.var_6C67["axis"] = undefined;
		level.var_6C68["axis"] = undefined;
		level.finalkillcam_killcamentitystickstovictim["axis"] = undefined;
		level.var_6C6B["axis"] = undefined;
		level.var_6C62["axis"] = undefined;
		level.var_6C69["axis"] = undefined;
		level.var_6C6D["axis"] = undefined;
		level.var_6C6C["axis"] = undefined;
		level.var_6C6A["axis"] = undefined;
		level.var_6C61["axis"] = undefined;
		level.var_6C5E["axis"] = undefined;
		level.var_6C5F["axis"] = undefined;
		level.finalkillcam_killstreakvariantinfo["axis"] = undefined;
		level.var_6C63["allies"] = undefined;
		level.var_6C6E["allies"] = undefined;
		level.var_6C5D["allies"] = undefined;
		level.var_6C60["allies"] = undefined;
		level.var_6C64["allies"] = undefined;
		level.var_6C65["allies"] = undefined;
		level.var_6C66["allies"] = undefined;
		level.var_6C67["allies"] = undefined;
		level.var_6C68["allies"] = undefined;
		level.finalkillcam_killcamentitystickstovictim["allies"] = undefined;
		level.var_6C6B["allies"] = undefined;
		level.var_6C62["allies"] = undefined;
		level.var_6C69["allies"] = undefined;
		level.var_6C6D["allies"] = undefined;
		level.var_6C6C["allies"] = undefined;
		level.var_6C6A["allies"] = undefined;
		level.var_6C61["allies"] = undefined;
		level.var_6C5E["allies"] = undefined;
		level.var_6C5F["allies"] = undefined;
		level.finalkillcam_killstreakvariantinfo["allies"] = undefined;
	}

	level.var_6C63["none"] = undefined;
	level.var_6C6E["none"] = undefined;
	level.var_6C5D["none"] = undefined;
	level.var_6C60["none"] = undefined;
	level.var_6C64["none"] = undefined;
	level.var_6C65["none"] = undefined;
	level.var_6C66["none"] = undefined;
	level.var_6C67["none"] = undefined;
	level.var_6C68["none"] = undefined;
	level.finalkillcam_killcamentitystickstovictim["none"] = undefined;
	level.var_6C6B["none"] = undefined;
	level.var_6C62["none"] = undefined;
	level.var_6C69["none"] = undefined;
	level.var_6C6D["none"] = undefined;
	level.var_6C6C["none"] = undefined;
	level.var_6C6A["none"] = undefined;
	level.var_6C61["none"] = undefined;
	level.var_6C5E["none"] = undefined;
	level.var_6C5F["none"] = undefined;
	level.finalkillcam_killstreakvariantinfo["none"] = undefined;
	level.var_6C6F = undefined;
}

//Function Number: 3
preloadfinalkillcam()
{
	var_00 = level.var_6C5D[level.var_6C6F];
	if(isdefined(var_00))
	{
		foreach(var_02 in level.players)
		{
			var_02 method_81E6(var_00);
		}
	}
}

//Function Number: 4
func_5853()
{
	level waittill("round_end_finished");
	level.var_10130 = 1;
	var_00 = "none";
	if(isdefined(level.var_6C6F))
	{
		var_00 = level.var_6C6F;
	}

	var_01 = level.var_6C63[var_00];
	var_02 = level.var_6C6E[var_00];
	var_03 = level.var_6C5D[var_00];
	var_04 = level.var_6C60[var_00];
	var_05 = level.var_6C64[var_00];
	var_06 = level.var_6C65[var_00];
	var_07 = level.var_6C66[var_00];
	var_08 = level.var_6C67[var_00];
	var_09 = level.var_6C68[var_00];
	var_0A = level.finalkillcam_killcamentitystickstovictim[var_00];
	var_0B = level.var_6C6B[var_00];
	var_0C = level.var_6C62[var_00];
	var_0D = level.var_6C69[var_00];
	var_0E = level.var_6C6D[var_00];
	var_0F = level.var_6C6C[var_00];
	var_10 = level.var_6C6A[var_00];
	var_11 = level.var_6C61[var_00];
	var_12 = level.var_6C5E[var_00];
	var_13 = level.var_6C5F[var_00];
	var_14 = level.finalkillcam_killstreakvariantinfo[var_00];
	if(!isdefined(var_02) || !isdefined(var_03))
	{
		level.var_10130 = 0;
		level notify("final_killcam_done");
		return;
	}

	var_15 = 20;
	var_16 = var_0F - var_0E;
	if(var_16 > var_15)
	{
		level.var_10130 = 0;
		level notify("final_killcam_done");
		return;
	}

	if(isdefined(var_03))
	{
		if(level.teambased)
		{
			var_17 = var_03.team;
		}
		else
		{
			var_17 = var_04.var_86BD;
		}

		if(isdefined(level.var_6C5D[var_17]) && level.var_6C5D[var_17] == var_03)
		{
			scripts\mp\_missions::func_D99F(var_03,var_02);
		}
	}

	var_18 = spawnstruct();
	var_18.agent_type = var_06;
	var_18.var_A9F6 = var_07;
	var_19 = gettime() - var_02.var_4E72 / 1000;
	foreach(var_1B in level.players)
	{
		var_1B scripts\mp\_utility::func_E2D8(0);
		var_1B.var_1AA = var_02 getentitynumber();
		var_1B scripts\mp\_damage::func_12E85(var_11,var_12);
		if(!scripts\mp\_utility::func_9E6C(var_0B))
		{
			var_1B scripts\mp\_killcam::func_F770(var_0B,var_10,var_05);
		}

		var_1B thread scripts\mp\_killcam::func_A636(var_05,var_18,var_04,var_08,var_09,var_02 getentitynumber(),var_0A,var_0B,var_19 + var_0C,var_0D,0,12,var_03,var_02,var_10,var_13,var_14);
	}

	wait(0.15 + level.var_B4A7);
	while(func_2041())
	{
		wait(0.05);
	}

	level notify("final_killcam_done");
	level.var_10130 = 0;
}

//Function Number: 5
func_DDEE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(level.teambased && isdefined(param_02.team))
	{
		level.var_6C63[param_02.team] = param_00;
		level.var_6C6E[param_02.team] = param_01;
		level.var_6C5D[param_02.team] = param_02;
		level.var_6C60[param_02.team] = param_03;
		level.var_6C64[param_02.team] = param_04;
		level.var_6C67[param_02.team] = param_05;
		level.var_6C68[param_02.team] = param_06;
		level.finalkillcam_killcamentitystickstovictim[param_02.team] = param_07;
		level.var_6C6B[param_02.team] = param_08;
		level.var_6C62[param_02.team] = param_09;
		level.var_6C69[param_02.team] = param_0A;
		level.var_6C6D[param_02.team] = scripts\mp\_utility::func_810C();
		level.var_6C6C[param_02.team] = scripts\mp\_utility::func_810C();
		level.var_6C6A[param_02.team] = param_0B;
		level.var_6C61[param_02.team] = param_01.var_2507;
		level.var_6C5E[param_02.team] = param_01.var_24E5;
		level.var_6C5F[param_02.team] = param_02.pers["loadoutPerks"];
		level.finalkillcam_killstreakvariantinfo[param_02.team] = param_01.killsteakvariantattackerinfo;
		if(isdefined(param_04) && isagent(param_04))
		{
			level.var_6C65[param_02.team] = param_04.agent_type;
			level.var_6C66[param_02.team] = param_04.var_A9F6;
		}
		else
		{
			level.var_6C65[param_02.team] = undefined;
			level.var_6C66[param_02.team] = undefined;
		}
	}
	else if(!level.teambased)
	{
		level.var_6C63[param_02.var_86BD] = param_00;
		level.var_6C6E[param_02.var_86BD] = param_01;
		level.var_6C5D[param_02.var_86BD] = param_02;
		level.var_6C60[param_02.var_86BD] = param_03;
		level.var_6C64[param_02.var_86BD] = param_04;
		level.var_6C67[param_02.var_86BD] = param_05;
		level.var_6C68[param_02.var_86BD] = param_06;
		level.finalkillcam_killcamentitystickstovictim[param_02.var_86BD] = param_07;
		level.var_6C6B[param_02.var_86BD] = param_08;
		level.var_6C62[param_02.var_86BD] = param_09;
		level.var_6C69[param_02.var_86BD] = param_0A;
		level.var_6C6D[param_02.var_86BD] = scripts\mp\_utility::func_810C();
		level.var_6C6C[param_02.var_86BD] = scripts\mp\_utility::func_810C();
		level.var_6C6A[param_02.var_86BD] = param_0B;
		level.var_6C61[param_02.var_86BD] = param_01.var_2507;
		level.var_6C5E[param_02.var_86BD] = param_01.var_24E5;
		level.var_6C5F[param_02.var_86BD] = param_02.pers["loadoutPerks"];
		level.finalkillcam_killstreakvariantinfo[param_02.var_86BD] = param_01.killsteakvariantattackerinfo;
		if(isdefined(param_04) && isagent(param_04))
		{
			level.var_6C65[param_02.var_86BD] = param_04.agent_type;
			level.var_6C66[param_02.var_86BD] = param_04.var_A9F6;
		}
		else
		{
			level.var_6C65[param_02.var_86BD] = undefined;
			level.var_6C66[param_02.var_86BD] = undefined;
		}
	}

	level.var_6C63["none"] = param_00;
	level.var_6C6E["none"] = param_01;
	level.var_6C5D["none"] = param_02;
	level.var_6C60["none"] = param_03;
	level.var_6C64["none"] = param_04;
	level.var_6C67["none"] = param_05;
	level.var_6C68["none"] = param_06;
	level.finalkillcam_killcamentitystickstovictim["none"] = param_07;
	level.var_6C6B["none"] = param_08;
	level.var_6C62["none"] = param_09;
	level.var_6C69["none"] = param_0A;
	level.var_6C6D["none"] = scripts\mp\_utility::func_810C();
	level.var_6C6C["none"] = scripts\mp\_utility::func_810C();
	level.var_6C6C["none"] = scripts\mp\_utility::func_810C();
	level.var_6C6A["none"] = param_0B;
	level.var_6C61["none"] = param_01.var_2507;
	level.var_6C5E["none"] = param_01.var_24E5;
	level.var_6C5F["none"] = param_02.pers["loadoutPerks"];
	level.finalkillcam_killstreakvariantinfo["none"] = param_01.killsteakvariantattackerinfo;
	if(isdefined(param_04) && isagent(param_04))
	{
		level.var_6C65["none"] = param_04.agent_type;
		level.var_6C66["none"] = param_04.var_A9F6;
		return;
	}

	level.var_6C65["none"] = undefined;
	level.var_6C66["none"] = undefined;
}

//Function Number: 6
func_13716()
{
	self endon("disconnect");
	self endon("killcam_death_done_waiting");
	self notifyonplayercommand("death_respawn","+usereload");
	self notifyonplayercommand("death_respawn","+activate");
	self waittill("death_respawn");
	self notify("killcam_death_button_cancel");
}

//Function Number: 7
func_13717(param_00)
{
	self endon("disconnect");
	self endon("killcam_death_button_cancel");
	wait(param_00);
	self notify("killcam_death_done_waiting");
}

//Function Number: 8
func_10266(param_00)
{
	self endon("disconnect");
	if(level.var_10130)
	{
		return 0;
	}

	if(!isai(self))
	{
		thread func_13716();
		thread func_13717(param_00);
		var_01 = scripts\common\utility::func_13734("killcam_death_done_waiting","killcam_death_button_cancel");
		if(var_01 == "killcam_death_done_waiting")
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_5854(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killcam_ended");
	if(isdefined(level.var_58D8))
	{
		return;
	}

	level.var_58D8 = 1;
	var_05 = param_00.var_37F1;
	var_06 = 0;
	var_07 = param_03 getentitynumber();
	if(!isdefined(param_00.var_24FF))
	{
		param_00.var_24FF = param_02 getentitynumber();
	}

	var_08 = var_05;
	if(var_08 > 1)
	{
		var_08 = 1;
		var_06 = var_06 + 1;
		wait(var_05 - var_06);
	}

	soundsettimescalefactor("music_lr",0);
	soundsettimescalefactor("music_lsrs",0);
	soundsettimescalefactor("voice_air_3d",0);
	soundsettimescalefactor("voice_radio_3d",0);
	soundsettimescalefactor("voice_radio_2d",0);
	soundsettimescalefactor("voice_narration_2d",0);
	soundsettimescalefactor("voice_special_2d",0);
	soundsettimescalefactor("voice_bchatter_1_3d",0);
	soundsettimescalefactor("plr_ui_ingame_unres_2d",0);
	soundsettimescalefactor("weap_plr_fire_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_4_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_overlap_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_lfe_2d",0);
	soundsettimescalefactor("weap_plr_fire_alt_1_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_2_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_3_2d",0.25);
	soundsettimescalefactor("weap_plr_fire_alt_4_2d",0.25);
	soundsettimescalefactor("reload_plr_res_2d",0.3);
	soundsettimescalefactor("reload_plr_unres_2d",0.3);
	soundsettimescalefactor("hurt_nofilter_2d",0.15);
	soundsettimescalefactor("scn_fx_unres_3d",0.15);
	soundsettimescalefactor("scn_lfe_unres_2d",0);
	soundsettimescalefactor("scn_lfe_unres_3d",0);
	soundsettimescalefactor("scn_fx_unres_2d",0.15);
	soundsettimescalefactor("spear_refl_close_unres_3d_lim",0.15);
	soundsettimescalefactor("spear_refl_unres_3d_lim",0.15);
	soundsettimescalefactor("weap_npc_main_3d",0.25);
	soundsettimescalefactor("weap_npc_mech_3d",0.25);
	soundsettimescalefactor("weap_npc_mid_3d",0.25);
	soundsettimescalefactor("weap_npc_lfe_3d",0);
	soundsettimescalefactor("weap_npc_dist_3d",0.25);
	soundsettimescalefactor("weap_npc_lo_3d",0.25);
	soundsettimescalefactor("melee_npc_3d",0.25);
	soundsettimescalefactor("melee_plr_2d",0.25);
	soundsettimescalefactor("special_hi_unres_1_3d",0.15);
	soundsettimescalefactor("special_lo_unres_1_2d",0);
	soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_1_unres_3d_lim",0.15);
	soundsettimescalefactor("bulletflesh_2_unres_3d_lim",0.15);
	soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim",0.2);
	soundsettimescalefactor("scn_fx_unres_2d_lim",0.2);
	soundsettimescalefactor("menu_1_2d_lim",0);
	soundsettimescalefactor("equip_use_unres_3d",0.15);
	soundsettimescalefactor("shock1_nofilter_3d",0.15);
	soundsettimescalefactor("explo_1_3d",0.15);
	soundsettimescalefactor("explo_2_3d",0.15);
	soundsettimescalefactor("explo_3_3d",0.15);
	soundsettimescalefactor("explo_4_3d",0.15);
	soundsettimescalefactor("explo_5_3d",0.15);
	soundsettimescalefactor("explo_lfe_3d",0.15);
	soundsettimescalefactor("vehicle_air_loops_3d_lim",0.15);
	soundsettimescalefactor("projectile_loop_close",0.15);
	soundsettimescalefactor("projectile_loop_mid",0.15);
	soundsettimescalefactor("projectile_loop_dist",0.15);
	setslowmotion(1,0.25,var_08);
	wait(var_08 + 0.5);
	setslowmotion(0.25,1,1);
	level.var_58D8 = undefined;
}

//Function Number: 10
func_2041()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_A636))
		{
			return 1;
		}
	}

	return 0;
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\archetypes\archassassin_utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 12:11:40 AM
*******************************************************************/

//Function Number: 1
func_CEF1(param_00,param_01)
{
	var_02[0][0]["org"] = self gettagorigin("j_spineupper");
	var_02[0][0]["angles"] = self gettagangles("j_spineupper");
	var_02[0][1]["org"] = self gettagorigin("j_spinelower");
	var_02[0][1]["angles"] = self gettagangles("j_spinelower");
	var_02[0][2]["org"] = self gettagorigin("j_head");
	var_02[0][2]["angles"] = self gettagangles("j_head");
	var_02[1][0]["org"] = self gettagorigin("j_knee_ri");
	var_02[1][0]["angles"] = self gettagangles("j_knee_ri");
	var_02[1][1]["org"] = self gettagorigin("j_knee_le");
	var_02[1][1]["angles"] = self gettagangles("j_knee_le");
	var_02[1][2]["org"] = self gettagorigin("j_elbow_ri");
	var_02[1][2]["angles"] = self gettagangles("j_elbow_ri");
	var_02[1][3]["org"] = self gettagorigin("j_elbow_le");
	var_02[1][3]["angles"] = self gettagangles("j_elbow_le");
	var_02[2][0]["org"] = self gettagorigin("j_ankle_le");
	var_02[2][0]["angles"] = self gettagangles("j_ankle_le");
	var_02[2][1]["org"] = self gettagorigin("j_ankle_ri");
	var_02[2][1]["angles"] = self gettagangles("j_ankle_ri");
	var_02[2][2]["org"] = self gettagorigin("j_wrist_le");
	var_02[2][2]["angles"] = self gettagangles("j_wrist_le");
	var_02[2][3]["org"] = self gettagorigin("j_wrist_ri");
	var_02[2][3]["angles"] = self gettagangles("j_wrist_ri");
	var_03 = "bullet_atomizer_impact_npc";
	var_04 = (0,0,0);
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	if(isdefined(param_00))
	{
		var_03 = param_00;
	}

	self playsound(var_03);
	foreach(var_06 in var_02)
	{
		foreach(var_08 in var_06)
		{
			playfx(level._effect["atomize_body"],var_08["org"] + var_04,anglestoforward(var_08["angles"]));
		}

		wait(0.01);
	}
}
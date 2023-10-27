/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 951.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:32:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("robot_c6_scriptable");
	self.var_1FEC = "c6";
	self.var_1FA8 = "c6";
	self.var_13525 = "c6";
	self method_82C6("c6servo");
	if(issentient(self))
	{
		self method_8492("locdmgtable/c6_lochit_dmgtable");
	}

	if(issentient(self))
	{
		self method_849A();
		var_00 = [];
		var_00["left_arm"] = spawnstruct();
		var_00["left_arm"].var_B4B8 = 90;
		var_00["left_arm"].var_C92D = [];
		var_00["left_arm"].var_C92D["upper"] = spawnstruct();
		var_00["left_arm"].var_C92D["upper"].maxhealth = 30;
		var_00["left_arm"].var_C92D["upper"].var_9038 = "left_arm_upper";
		var_00["left_arm"].var_C92D["upper"].var_4D6F = "j_shoulder_le";
		var_00["left_arm"].var_C92D["lower"] = spawnstruct();
		var_00["left_arm"].var_C92D["lower"].maxhealth = 30;
		var_00["left_arm"].var_C92D["lower"].var_9038 = "left_arm_lower";
		var_00["left_arm"].var_C92D["lower"].var_4D6F = "j_shoulder_le";
		self method_849B("left_arm",90,"upper",30,"left_arm_upper","j_shoulder_le","lower",30,"left_arm_lower","j_shoulder_le");
		var_00["right_arm"] = spawnstruct();
		var_00["right_arm"].var_B4B8 = 90;
		var_00["right_arm"].var_C92D = [];
		var_00["right_arm"].var_C92D["upper"] = spawnstruct();
		var_00["right_arm"].var_C92D["upper"].maxhealth = 30;
		var_00["right_arm"].var_C92D["upper"].var_9038 = "right_arm_upper";
		var_00["right_arm"].var_C92D["upper"].var_4D6F = "j_shoulder_ri";
		var_00["right_arm"].var_C92D["lower"] = spawnstruct();
		var_00["right_arm"].var_C92D["lower"].maxhealth = 30;
		var_00["right_arm"].var_C92D["lower"].var_9038 = "right_arm_lower";
		var_00["right_arm"].var_C92D["lower"].var_4D6F = "j_shoulder_ri";
		self method_849B("right_arm",90,"upper",30,"right_arm_upper","j_shoulder_ri","lower",30,"right_arm_lower","j_shoulder_ri");
		var_00["left_leg"] = spawnstruct();
		var_00["left_leg"].var_B4B8 = 90;
		var_00["left_leg"].var_C92D = [];
		var_00["left_leg"].var_C92D["upper"] = spawnstruct();
		var_00["left_leg"].var_C92D["upper"].maxhealth = 30;
		var_00["left_leg"].var_C92D["upper"].var_9038 = "left_leg_upper";
		var_00["left_leg"].var_C92D["upper"].var_4D6F = "j_hip_le";
		var_00["left_leg"].var_C92D["lower"] = spawnstruct();
		var_00["left_leg"].var_C92D["lower"].maxhealth = 30;
		var_00["left_leg"].var_C92D["lower"].var_9038 = "left_leg_lower";
		var_00["left_leg"].var_C92D["lower"].var_4D6F = "j_hip_le";
		self method_849B("left_leg",90,"upper",30,"left_leg_upper","j_hip_le","lower",30,"left_leg_lower","j_hip_le");
		var_00["right_leg"] = spawnstruct();
		var_00["right_leg"].var_B4B8 = 90;
		var_00["right_leg"].var_C92D = [];
		var_00["right_leg"].var_C92D["upper"] = spawnstruct();
		var_00["right_leg"].var_C92D["upper"].maxhealth = 30;
		var_00["right_leg"].var_C92D["upper"].var_9038 = "right_leg_upper";
		var_00["right_leg"].var_C92D["upper"].var_4D6F = "j_hip_ri";
		var_00["right_leg"].var_C92D["lower"] = spawnstruct();
		var_00["right_leg"].var_C92D["lower"].maxhealth = 30;
		var_00["right_leg"].var_C92D["lower"].var_9038 = "right_leg_lower";
		var_00["right_leg"].var_C92D["lower"].var_4D6F = "j_hip_ri";
		self method_849B("right_leg",90,"upper",30,"right_leg_upper","j_hip_ri","lower",30,"right_leg_lower","j_hip_ri");
		var_00["head"] = spawnstruct();
		var_00["head"].var_B4B8 = 300;
		var_00["head"].var_C92D = [];
		var_00["head"].var_C92D["head"] = spawnstruct();
		var_00["head"].var_C92D["head"].maxhealth = 0;
		var_00["head"].var_C92D["head"].var_9038 = "head";
		var_00["head"].var_C92D["head"].var_4D6F = "j_head";
		self method_849B("head",300,"head",0,"head","j_head");
		var_00["torso"] = spawnstruct();
		var_00["torso"].var_B4B8 = 0;
		var_00["torso"].var_C92D = [];
		var_00["torso"].var_C92D["upper"] = spawnstruct();
		var_00["torso"].var_C92D["upper"].maxhealth = 100;
		var_00["torso"].var_C92D["upper"].var_9038 = "torso_upper";
		var_00["torso"].var_C92D["upper"].var_4D6F = "j_spineupper";
		var_00["torso"].var_C92D["lower"] = spawnstruct();
		var_00["torso"].var_C92D["lower"].maxhealth = 100;
		var_00["torso"].var_C92D["lower"].var_9038 = "torso_lower";
		var_00["torso"].var_C92D["lower"].var_4D6F = "j_spinelower";
		self method_849B("torso",0,"upper",100,"torso_upper","j_spineupper","lower",100,"torso_lower","j_spinelower");
		self.var_4D5D = var_00;
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("robot_c6_scriptable");
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1202.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 12:23:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("robot_c12_normal_torso");
	self.var_1FEC = "c12";
	self.var_1FA8 = "c12";
	self.var_13525 = "unitednations";
	self method_82C6("c12servo");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	if(issentient(self))
	{
		self method_849A();
		var_00 = [];
		var_00["head"] = spawnstruct();
		var_00["head"].var_B4B8 = 0;
		var_00["head"].var_C92D = [];
		var_00["head"].var_C92D["head"] = spawnstruct();
		var_00["head"].var_C92D["head"].maxhealth = 5000;
		var_00["head"].var_C92D["head"].var_9038 = "head";
		var_00["head"].var_C92D["head"].var_4D6F = "J_Neck";
		self method_849B("head",0,"head",5000,"head","J_Neck");
		var_00["right_arm"] = spawnstruct();
		var_00["right_arm"].var_B4B8 = 2000;
		var_00["right_arm"].var_C92D = [];
		var_00["right_arm"].var_C92D["lower"] = spawnstruct();
		var_00["right_arm"].var_C92D["lower"].maxhealth = 1000;
		var_00["right_arm"].var_C92D["lower"].var_9038 = "right_arm_lower";
		var_00["right_arm"].var_C92D["lower"].var_4D6F = "J_Clavicle_X_RI";
		var_00["right_arm"].var_C92D["upper"] = spawnstruct();
		var_00["right_arm"].var_C92D["upper"].maxhealth = 1000;
		var_00["right_arm"].var_C92D["upper"].var_9038 = "right_arm_upper";
		var_00["right_arm"].var_C92D["upper"].var_4D6F = "J_Clavicle_X_RI";
		self method_849B("right_arm",2000,"lower",1000,"right_arm_lower","J_Clavicle_X_RI","upper",1000,"right_arm_upper","J_Clavicle_X_RI");
		var_00["left_arm"] = spawnstruct();
		var_00["left_arm"].var_B4B8 = 2000;
		var_00["left_arm"].var_C92D = [];
		var_00["left_arm"].var_C92D["lower"] = spawnstruct();
		var_00["left_arm"].var_C92D["lower"].maxhealth = 1000;
		var_00["left_arm"].var_C92D["lower"].var_9038 = "left_arm_lower";
		var_00["left_arm"].var_C92D["lower"].var_4D6F = "J_Clavicle_X_LE";
		var_00["left_arm"].var_C92D["upper"] = spawnstruct();
		var_00["left_arm"].var_C92D["upper"].maxhealth = 1000;
		var_00["left_arm"].var_C92D["upper"].var_9038 = "left_arm_upper";
		var_00["left_arm"].var_C92D["upper"].var_4D6F = "J_Clavicle_X_LE";
		self method_849B("left_arm",2000,"lower",1000,"left_arm_lower","J_Clavicle_X_LE","upper",1000,"left_arm_upper","J_Clavicle_X_LE");
		var_00["right_leg"] = spawnstruct();
		var_00["right_leg"].var_B4B8 = 2000;
		var_00["right_leg"].var_C92D = [];
		var_00["right_leg"].var_C92D["upper"] = spawnstruct();
		var_00["right_leg"].var_C92D["upper"].maxhealth = 1000;
		var_00["right_leg"].var_C92D["upper"].var_9038 = "right_leg_upper";
		var_00["right_leg"].var_C92D["upper"].var_4D6F = "J_HipInner_RI";
		var_00["right_leg"].var_C92D["lower"] = spawnstruct();
		var_00["right_leg"].var_C92D["lower"].maxhealth = 1000;
		var_00["right_leg"].var_C92D["lower"].var_9038 = "right_leg_lower";
		var_00["right_leg"].var_C92D["lower"].var_4D6F = "J_HipInner_RI";
		self method_849B("right_leg",2000,"upper",1000,"right_leg_upper","J_HipInner_RI","lower",1000,"right_leg_lower","J_HipInner_RI");
		var_00["left_leg"] = spawnstruct();
		var_00["left_leg"].var_B4B8 = 2000;
		var_00["left_leg"].var_C92D = [];
		var_00["left_leg"].var_C92D["upper"] = spawnstruct();
		var_00["left_leg"].var_C92D["upper"].maxhealth = 1000;
		var_00["left_leg"].var_C92D["upper"].var_9038 = "left_leg_upper";
		var_00["left_leg"].var_C92D["upper"].var_4D6F = "J_HipInner_LE";
		var_00["left_leg"].var_C92D["lower"] = spawnstruct();
		var_00["left_leg"].var_C92D["lower"].maxhealth = 1000;
		var_00["left_leg"].var_C92D["lower"].var_9038 = "left_leg_lower";
		var_00["left_leg"].var_C92D["lower"].var_4D6F = "J_HipInner_LE";
		self method_849B("left_leg",2000,"upper",1000,"left_leg_upper","J_HipInner_LE","lower",1000,"left_leg_lower","J_HipInner_LE");
		var_00["hip_pack_right"] = spawnstruct();
		var_00["hip_pack_right"].var_B4B8 = 0;
		var_00["hip_pack_right"].var_C92D = [];
		var_00["hip_pack_right"].var_C92D["hip_pack_right"] = spawnstruct();
		var_00["hip_pack_right"].var_C92D["hip_pack_right"].maxhealth = 500;
		var_00["hip_pack_right"].var_C92D["hip_pack_right"].var_9038 = "torso_upper";
		var_00["hip_pack_right"].var_C92D["hip_pack_right"].var_4D6F = "J_SpineLowerBottom_RI";
		self method_849B("hip_pack_right",0,"hip_pack_right",500,"torso_upper","J_SpineLowerBottom_RI");
		var_00["hip_pack_left"] = spawnstruct();
		var_00["hip_pack_left"].var_B4B8 = 0;
		var_00["hip_pack_left"].var_C92D = [];
		var_00["hip_pack_left"].var_C92D["hip_pack_left"] = spawnstruct();
		var_00["hip_pack_left"].var_C92D["hip_pack_left"].maxhealth = 500;
		var_00["hip_pack_left"].var_C92D["hip_pack_left"].var_9038 = "torso_upper";
		var_00["hip_pack_left"].var_C92D["hip_pack_left"].var_4D6F = "J_SpineLowerBottom_LE";
		self method_849B("hip_pack_left",0,"hip_pack_left",500,"torso_upper","J_SpineLowerBottom_LE");
		var_00["torso"] = spawnstruct();
		var_00["torso"].var_B4B8 = 0;
		var_00["torso"].var_C92D = [];
		var_00["torso"].var_C92D["upper"] = spawnstruct();
		var_00["torso"].var_C92D["upper"].maxhealth = 9999;
		var_00["torso"].var_C92D["upper"].var_9038 = "torso_upper";
		var_00["torso"].var_C92D["upper"].var_4D6F = "j_spineupper";
		var_00["torso"].var_C92D["lower"] = spawnstruct();
		var_00["torso"].var_C92D["lower"].maxhealth = 9999;
		var_00["torso"].var_C92D["lower"].var_9038 = "torso_lower";
		var_00["torso"].var_C92D["lower"].var_4D6F = "j_mainroot";
		self method_849B("torso",0,"upper",9999,"torso_upper","j_spineupper","lower",9999,"torso_lower","j_mainroot");
		self.var_4D5D = var_00;
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("robot_c12_normal_torso");
}
/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: container_plastic_72x56x48_01_destp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 2:03:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\_destructible::destructible_create("container_plastic_72x56x48_01_destp","tag_origin",500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_origin","vfx/destructible/container_plastic_72x56x48_01",1);
	common_scripts\_destructible::destructible_explode(1500,3000,100,100,10,20,undefined,undefined,undefined,undefined,undefined,undefined,2000,3000);
	common_scripts\_destructible::destructible_state("tag_origin","container_plastic_72x56x48_01_dstry_destp",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_part_01","container_plastic_72x56x48_01_part_01_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_02","container_plastic_72x56x48_01_part_02_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_03","container_plastic_72x56x48_01_part_03_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_04","container_plastic_72x56x48_01_part_04_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_05","container_plastic_72x56x48_01_part_05_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_06","container_plastic_72x56x48_01_part_06_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_07","container_plastic_72x56x48_01_part_07_destp",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_part_08","container_plastic_72x56x48_01_part_08_destp",undefined,undefined,undefined,undefined,1,1);
}
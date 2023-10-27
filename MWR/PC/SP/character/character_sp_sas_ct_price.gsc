/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_ct_price.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 56 ms
 * Timestamp: 10/27/2023 2:45:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sas_ct_assault_price");
	self attach("head_sas_ct_assault_price_mask_down","",1);
	self.headmodel = "head_sas_ct_assault_price_mask_down";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sas_ct_assault_price");
	precachemodel("head_sas_ct_assault_price_mask_down");
}
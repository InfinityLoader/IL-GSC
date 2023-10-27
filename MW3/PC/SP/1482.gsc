/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1482.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:20:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_so_juggernaut_blue");
	self attach("head_so_juggernaut_blue_hat","",1);
	self.var_1E5A = "head_so_juggernaut_blue_hat";
	if(isendstr(self.var_1E5A,"_hat"))
	{
		self.hatmodel = "hat_so_juggernaut_blue";
		self attach(self.hatmodel);
	}

	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("body_so_juggernaut_blue");
	precachemodel("head_so_juggernaut_blue_hat");
	precachemodel("hat_so_juggernaut_blue");
}
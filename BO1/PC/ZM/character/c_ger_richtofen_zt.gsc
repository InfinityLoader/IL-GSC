
main()
{
	self setModel("c_ger_richtofen_body");
	self.headModel = "c_ger_richtofen_head";
	self attach(self.headModel, "", true);
	self.hatModel = "c_ger_richtofen_offcap";
	self attach(self.hatModel);
	self.voice = "german";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_ger_richtofen_body");
	precacheModel("c_ger_richtofen_head");
	precacheModel("c_ger_richtofen_offcap");
}
 
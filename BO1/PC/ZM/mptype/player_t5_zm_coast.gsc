
main()
{
	switch( codescripts\character::get_random_character(4) )
	{
		case 0:
		character\c_zom_sarah_michelle_gellar_player::main();
		break;
		case 1:
		character\c_zom_robert_englund_player::main();
		break;
		case 2:
		character\c_zom_danny_trejo_player::main();
		break;
		case 3:
		character\c_zom_michael_rooker_player::main();
		break;
	}
}
precache()
{
	character\c_zom_sarah_michelle_gellar_player::precache();
	character\c_zom_robert_englund_player::precache();
	character\c_zom_danny_trejo_player::precache();
	character\c_zom_michael_rooker_player::precache();
}
 
/// @description Insert description here
// You can write your code in this editor
deathTallyCounter++;

if (deathTallyCounter < 60)
{
	x -= 400/60;
}
else if (deathTallyCounter < 240)
{
	x = 0;
}
else if (deathTallyCounter < 300)
{
	if (deathTallyCounter == 240)
	{
		room_goto(mainBattle);
	}
	x -= 400/60;
}
else
{
	instance_destroy();
}
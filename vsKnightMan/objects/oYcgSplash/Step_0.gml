/// @description Insert description here
// You can write your code in this editor
outroCounter++;
if (outroCounter == 180)
{
	instance_create_layer(0, 0, "Instances", oCurtainTransitionOutro);
}
else if (outroCounter > 180 && !instance_exists(oCurtainTransitionOutro))
{
	instance_create_layer(0, 0, "Instances", oTitleScreen);
	instance_destroy();
}
/// @description Insert description here
// You can write your code in this editor
instance_create_layer(0, 0, "Instances", oCurtainTransitionIntro);
choices = ["start game", "controls", "exit"];
selection = 0;
startGameCounter = 0; //When player selects "start game", wait 2 seconds before creating the curtain outro.
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);
draw_set_font(shovelFont);
draw_set_colour(c_white);
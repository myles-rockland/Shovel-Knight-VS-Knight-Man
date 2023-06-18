/// @description Insert description here
// You can write your code in this editor
//Font stuff
x = 0;
y = 0;
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);

//Dialogue lines
text[0] = "knight man: halt! have you seen a short, blue man pass through this area?";
text[1] = "shovel knight: well met, but no, sorry.";
text[2] = "knight man: very well, i shall be on my way, then.";

text_current = 0; //Current text array position
text_last = 2; //last array position
text_width = 350; //Max width for text until it wraps
text_x = 55; //X position to draw at
text_y = 8; //Y position to draw at

char_current = string_pos(":", text[text_current]); //Start from the first colon
char_speed = 0.5;

//Call function to draw first line of text
text[text_current] = string_wrap(text[text_current], text_width);
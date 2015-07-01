--[[
 ? 2013 CloudSixteen.com do not share, re-distribute or modify
 without permission of its author (kurozael@gmail.com).
--]]

ITEM = Clockwork.item:New("book_base");
ITEM.name = "Ranger Manual";
ITEM.cost = 6;
ITEM.model = "models/props_lab/binderredlabel.mdl";
ITEM.uniqueID = "book_fha";
ITEM.business = true;
ITEM.description = "A book with a strange symbol on the front.";
ITEM.bookInformation = [[
<font color='red' size='4'>Written by Dmitiri Solovanak.</font>

Well.. Welcome to the Rangers. I am sure you want to ask a lot of questions, but lets get to the point.

You are now part of the leading authority of the Metro's, and you will die to defend what you have.
Now, me. Dmitiri, I am your leader, your boss. We will have meetings in the control room at times, and our frequency is and ALWAYS will be, 
101.2
Now. We have a supplier in the main control room, he will supply you with weapons for a decent price. You can get bullets by
selling trash to people around the Metro's, or you can ask me for a gun.

Now. If you see an apposing faction in the base, keep your eye on them. They may be planning something.
Heres a big tip, don't get on my bad side. This means you will follow every order I give you even if it is ridicoulous.
If you try to harm me in ANY way, you will be kicked out from the rangers.

This is just a basic manual, I hope that this has tought you the basics. You will learn the rest on the battlefield!

]];

ITEM:Register();
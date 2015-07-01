--IMPORTANT--
To create an item that will spawn using the item spawner you must do the following:
Add this to the sh_item file: ITEM.value = #;
The higher the number, the higher the chance of it spawning.
The lower the number, the lower the chance of it spawning.
The number must be between zero and one and can use decimals.

--ALSO IMPORTANT--
To avoid infinite loops (aka stuff that results in a server crash), do one of the following:
1. Create many item spawns across your map.
2. Create an item spawn in an isolated and unreachable location.

"Planned" update(s):
Server configuration variable for random item spawn intervals.
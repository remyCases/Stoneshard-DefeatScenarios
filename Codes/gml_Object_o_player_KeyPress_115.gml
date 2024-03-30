var _terrainWidth = 39;
var _terrainHeight = 36;

var xx = -1;
var yy = -1;
var roomtype = "";
var roomindex = -1;
var xroom = -1;
var yroom = -1;

var moral = scr_atr("Morale");
var sanity = scr_atr("Sanity");
var pain = scr_atr("Pain");
var hunger = scr_atr("Hunger");
var thirsty = scr_atr("Thirsty");

do
{
    xx = irandom(_terrainWidth);
    yy = irandom(_terrainHeight);
    roomtype = scr_globaltile_get("room_type", xx, yy);
    roomindex = asset_get_index(roomtype);
    scr_actionsLogUpdate("tested roomtype " + roomtype + ": " + string(xx) + " " + string(yy) + " at room index: " + string(roomindex));
}
until (roomindex >= 0 && roomtype != "r_sea" && roomtype != "r_AbbeyOfHolyRevelation");

scr_actionsLogUpdate("new coordinates: " + string(xx) + " " + string(yy) + " at room index: " + string(roomindex));

var _distance = scr_tile_distance_xy(global.playerGridX, global.playerGridY, xx, yy, 1);
global.playerGridX = xx;
global.playerGridY = yy;

scr_smoothFastTravel(scr_globaltile_get_room(), ceil((_distance * 0.5)));

do
{
    xroom = random(room_width);
    yroom = random(room_height);
    scr_actionsLogUpdate("tested place: " + string(xroom) + " " + string(yroom));
}
until (place_free(xroom, yroom));

with(o_player)
{
    x = xroom;
    y = yroom;
    draw_x = xroom;
    draw_y = yroom;
}
ds_map_replace(global.characterDataMap, "Morale", moral * 0.75);
ds_map_replace(global.characterDataMap, "Sanity", sanity * 0.75);
ds_map_replace(global.characterDataMap, "Pain", pain * 0.75 + 0.25 * 50);
ds_map_replace(global.characterDataMap, "Hunger", hunger * 0.75 + 0.25 * 50);
ds_map_replace(global.characterDataMap, "Thirsty", thirsty * 0.75 + 0.25 * 50);

// scr_camera_set_target(o_player)
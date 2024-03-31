var xx = -1;
var yy = -1;

if (global.rescue > 3)
{
    global.rescue = 0;
    xx = global.osbrook_x;
    yy = global.osbrook_y;
}
else
{
    global.rescue += 1;
    var _terrainWidth = 39;
    var _terrainHeight = 36;
    
    var roomtype = "";
    var roomindex = -1;
    
    do
    {
        xx = irandom(_terrainWidth);
        yy = irandom(_terrainHeight);
        roomtype = scr_globaltile_get("room_type", xx, yy);
        roomindex = asset_get_index(roomtype);
    }
    until (roomindex >= 0 && roomtype != "r_sea" && roomtype != "r_AbbeyOfHolyRevelation");
}

var _distance = scr_tile_distance_xy(global.playerGridX, global.playerGridY, xx, yy, 1);
global.playerGridX = xx;
global.playerGridY = yy;

var _smoothChanger = scr_smoothRoomChange(scr_globaltile_get_room(), [4], (room_speed * 2))
if ((_smoothChanger != -4))
{
    with (instance_create_depth(-50, -50, 0, o_sleepController))
    {
        smoothChanger = _smoothChanger
        sleepType = 16
        sleepHours = ceil((_distance * 0.5))
    }
}
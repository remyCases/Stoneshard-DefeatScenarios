var _turns = (sleepHours * 120);
var moral = scr_atr("Morale");
var sanity = scr_atr("Sanity");
var pain = scr_atr("Pain");
var hunger = scr_atr("Hunger");
var thirsty = scr_atr("Thirsty");
var xroom = -1;
var yroom = -1;

scr_states_duration_dec(o_player, 1, _turns);
scr_hunger_change(_turns * 0.005 - 0.1*(hunger - 75));
scr_thirsty_change(_turns * 0.01 - 0.1*(thirsty - 75));
scr_intoxication_change(_turns * -0.0002);
scr_pain_change(o_player, - 0.1*(pain - 60));
scr_psychic_change("Morale", - 0.1*moral);
scr_psychic_change("Sanity", - 0.1*sanity);
scr_fatigue_change(_turns * 0.01, 1);

with (o_player)
{
    if(max_hp < 10)
    {
        max_hp = 10; 
    } 
    var _dhp = ((((max_hp * 0.01 * (Healing_Received / 100)) / (100 / Health_Restoration)) * _turns))
    scr_restore_hp(id, _dhp)
    scr_restore_mp(id, max_mp)
    for (var _i = 0; _i < array_length(chance); _i++)
        chance[_i] = 0
    for (_i = 0; _i < array_length(CD); _i++)
        CD[_i] = 0
    var _bodyPartsMapSize = ds_map_size(Body_Parts_map)
    var _key = ds_map_find_first(Body_Parts_map)
    for (_i = 0; _i < _bodyPartsMapSize; _i++)
    {
        var _wound = ds_map_find_value(Body_Parts_map, _key)
        ds_map_set(Body_Parts_map, _key, min(100, (_wound + ((0.001 * _turns)))))
        _key = ds_map_find_next(Body_Parts_map, _key)
    }
}

with (o_skill_ico)
{
    if (is_open && (!passive))
    {
        scr_set_kd(skill, "KD", 0)
        with (child_skill)
            scr_set_kd(skill, "KD", 0)
    }
}
with (o_wound)
{
    if is_player(target)
        event_user(0)
}

do
{
    xroom = random(room_width);
    yroom = random(room_height);
}
until (place_free(xroom, yroom));

with(o_player)
{
    x = xroom;
    y = yroom;
    draw_x = xroom;
    draw_y = yroom;
}

scr_actionsLogUpdate(string(sleepHours) + "h passed.");
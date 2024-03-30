// Copyright (C)
// See LICENSE file for extended copyright information.
// This file is part of the repository from .

using ModShardLauncher;
using ModShardLauncher.Mods;

namespace DefeatScenarios;
public class DefeatScenarios : Mod
{
    public override string Author => "zizani";
    public override string Name => "Defeat Scenarios";
    public override string Description => "You were defeated but you didn't die. Rise up and try to survive once more.";
    public override string Version => "0.1.0.0";
    public override string TargetVersion => "0.8.2.10";

    public override void PatchMod()
    {
        Msl.LoadGML("gml_Object_o_player_KeyPress_115")
            .MatchAll()
            .ReplaceBy(ModFiles, "gml_Object_o_player_KeyPress_115.gml")
            .Save();

        Msl.LoadGML("gml_Object_o_player_Other_16")
            .MatchAll()
            .ReplaceBy(ModFiles, "gml_Object_o_player_KeyPress_115.gml")
            .Save();
    }
}

<?php

namespace App\Formatter;

class PitchesFormatter
{
    public string $name;
    public int $position;
    public array $pitches;

    public function __construct($name, $position)
    {
        $this->name = $name;
        $this->position = $position;
    }

    public function formatPitchArray(array $pitches){
//        array_map(function (){
//
//        }, $pitches);
    }
}
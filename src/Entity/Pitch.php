<?php

namespace App\Entity;

use App\Repository\PitchRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PitchRepository::class)]
class Pitch
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $note_letter = null;

    #[ORM\Column(length: 255)]
    private ?string $accidental = null;

    #[ORM\Column]
    private ?int $octave = null;

    #[ORM\Column]
    private ?int $midi_number = null;

    #[ORM\Column]
    private ?int $position = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNoteLetter(): ?string
    {
        return $this->note_letter;
    }

    public function setNoteLetter(string $note_letter): self
    {
        $this->note_letter = $note_letter;

        return $this;
    }

    public function getAccidental(): ?string
    {
        return $this->accidental;
    }

    public function setAccidental(string $accidental): self
    {
        $this->accidental = $accidental;

        return $this;
    }

    public function getOctave(): ?int
    {
        return $this->octave;
    }

    public function setOctave(int $octave): self
    {
        $this->octave = $octave;

        return $this;
    }

    public function getMidiNumber(): ?int
    {
        return $this->midi_number;
    }

    public function setMidiNumber(int $midi_number): self
    {
        $this->midi_number = $midi_number;

        return $this;
    }

    public function getPosition(): ?int
    {
        return $this->position;
    }

    public function setPosition(int $position): self
    {
        $this->position = $position;

        return $this;
    }
}

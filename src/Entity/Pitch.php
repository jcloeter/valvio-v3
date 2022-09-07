<?php

namespace App\Entity;

use App\Repository\PitchRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PitchRepository::class)]
class
Pitch
{
    #[ORM\Id]
//    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?string $id = null;

    #[ORM\Column(length: 255)]
    private ?string $noteLetter = null;

    #[ORM\Column(length: 255)]
    private ?string $accidental = null;

    #[ORM\Column]
    private ?int $octave = null;

    #[ORM\Column]
    private ?int $midiNumber = null;

    #[ORM\Column]
    private ?int $position = null;

    #[ORM\OneToMany(mappedBy: 'pitch', targetEntity: QuizPitch::class, orphanRemoval: true)]
    private Collection $quizPitches;
//
    #[ORM\OneToMany(mappedBy: 'transposedAnswerPitch', targetEntity: QuizPitch::class)]
    private Collection $transposedAnswerQuizPitches;

    public function __construct()
    {
//        $this->quizPitches = new ArrayCollection();
//        $this->transposedAnswerQuizPitches = new ArrayCollection();
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getNoteLetter(): ?string
    {
        return $this->noteLetter;
    }

    public function setNoteLetter(string $noteLetter): self
    {
        $this->noteLetter = $noteLetter;

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
        return $this->midiNumber;
    }

    public function setMidiNumber(int $midiNumber): self
    {
        $this->midiNumber = $midiNumber;

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

//    /**
//     * @return Collection<int, QuizPitch>
//     */
//    public function getQuizPitches(): Collection
//    {
//        return $this->quizPitches;
//    }
//
//    public function addQuizPitch(QuizPitch $quizPitch): self
//    {
//        if (!$this->quizPitches->contains($quizPitch)) {
//            $this->quizPitches->add($quizPitch);
//            $quizPitch->setPitchId($this);
//        }
//
//        return $this;
//    }
//
//    public function removeQuizPitch(QuizPitch $quizPitch): self
//    {
//        if ($this->quizPitches->removeElement($quizPitch)) {
//            // set the owning side to null (unless already changed)
//            if ($quizPitch->getPitchId() === $this) {
//                $quizPitch->setPitchId(null);
//            }
//        }
//
//        return $this;
//    }
//
//    /**
//     * @return Collection<int, QuizPitch>
//     */
//    public function getTransposedAnswerQuizPitches(): Collection
//    {
//        return $this->transposedAnswerQuizPitches;
//    }
//
//    public function addTransposedAnswerQuizPitch(QuizPitch $transposedAnswerQuizPitch): self
//    {
//        if (!$this->transposedAnswerQuizPitches->contains($transposedAnswerQuizPitch)) {
//            $this->transposedAnswerQuizPitches->add($transposedAnswerQuizPitch);
//            $transposedAnswerQuizPitch->setTransposedAnswerPitchId($this);
//        }
//
//        return $this;
//    }
//
//    public function removeTransposedAnswerQuizPitch(QuizPitch $transposedAnswerQuizPitch): self
//    {
//        if ($this->transposedAnswerQuizPitches->removeElement($transposedAnswerQuizPitch)) {
//            // set the owning side to null (unless already changed)
//            if ($transposedAnswerQuizPitch->getTransposedAnswerPitchId() === $this) {
//                $transposedAnswerQuizPitch->setTransposedAnswerPitchId(null);
//            }
//        }
//
//        return $this;
//    }
}

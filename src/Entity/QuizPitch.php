<?php

namespace App\Entity;

use App\Repository\QuizPitchRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: QuizPitchRepository::class)]
class QuizPitch
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'quizPitches')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Quiz $quiz = null;

    #[ORM\ManyToOne(inversedBy: 'quizPitches', fetch:'EAGER')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Pitch $pitch = null;

    #[ORM\ManyToOne(inversedBy: 'transposedAnswerQuizPitches', fetch:'EAGER')]
    #[ORM\JoinColumn(nullable: true)]
    private ?Pitch $transposedAnswerPitch = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getQuiz(): ?Quiz
    {
        return $this->quiz;
    }

    public function setQuiz(?Quiz $quiz): self
    {
        $this->quiz = $quiz;

        return $this;
    }

    public function getPitch(): ?Pitch
    {
        return $this->pitch;
    }

    public function setPitch(?Pitch $pitch): self
    {
        $this->pitch = $pitch;

        return $this;
    }

    public function getTransposedAnswerPitch(): ?Pitch
    {
        return $this->transposedAnswerPitch;
    }

    public function setTransposedAnswerPitch(?Pitch $transposedAnswerPitch): self
    {
        $this->transposedAnswerPitch = $transposedAnswerPitch;

        return $this;
    }
}

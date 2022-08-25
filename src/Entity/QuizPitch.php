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
    private ?Quiz $quizId = null;

    #[ORM\ManyToOne(inversedBy: 'quizPitches')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Pitch $pitchId = null;

    #[ORM\ManyToOne(inversedBy: 'transposedAnswerQuizPitches')]
    private ?Pitch $transposedAnswerPitchId = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getQuizId(): ?Quiz
    {
        return $this->quizId;
    }

    public function setQuizId(?Quiz $quizId): self
    {
        $this->quizId = $quizId;

        return $this;
    }

    public function getPitchId(): ?Pitch
    {
        return $this->pitchId;
    }

    public function setPitchId(?Pitch $pitchId): self
    {
        $this->pitchId = $pitchId;

        return $this;
    }

    public function getTransposedAnswerPitchId(): ?Pitch
    {
        return $this->transposedAnswerPitchId;
    }

    public function setTransposedAnswerPitchId(?Pitch $transposedAnswerPitchId): self
    {
        $this->transposedAnswerPitchId = $transposedAnswerPitchId;

        return $this;
    }
}

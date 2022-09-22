<?php

namespace App\Entity;

use App\Repository\QuizPitchAttemptRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: QuizPitchAttemptRepository::class)]
class QuizPitchAttempt
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $startedAt = null;

    //Remove one of these Datetimes?
    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $endedAt = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $userInput = null;

    #[ORM\Column]
    private ?bool $correct = null;

    #[ORM\ManyToOne(inversedBy: 'questionAttempts')]
    #[ORM\JoinColumn(nullable: false)]
    private ?QuizAttempt $quizAttemptId = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: false)]
    private ?QuizPitch $quizPitch = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStartedAt(): ?\DateTimeImmutable
    {
        return $this->startedAt;
    }

    public function setStartedAt(\DateTimeImmutable $startedAt): self
    {
        $this->startedAt = $startedAt;

        return $this;
    }

    public function getEndedAt(): ?\DateTimeImmutable
    {
        return $this->endedAt;
    }

    public function setEndedAt(?\DateTimeImmutable $endedAt): self
    {
        $this->endedAt = $endedAt;

        return $this;
    }

    public function getUserInput(): ?string
    {
        return $this->userInput;
    }

    public function setUserInput(?string $userInput): self
    {
        $this->userInput = $userInput;

        return $this;
    }

    public function isCorrect(): ?bool
    {
        return $this->correct;
    }

    public function setCorrect(bool $correct): self
    {
        $this->correct = $correct;

        return $this;
    }

    public function getQuizAttemptId(): ?QuizAttempt
    {
        return $this->quizAttemptId;
    }

    public function setQuizAttemptId(?QuizAttempt $quizAttemptId): self
    {
        $this->quizAttemptId = $quizAttemptId;

        return $this;
    }

    public function getQuizPitch(): ?QuizPitch
    {
        return $this->quizPitch;
    }

    public function setQuizPitch(?QuizPitch $quizPitch): self
    {
        $this->quizPitch = $quizPitch;

        return $this;
    }
}

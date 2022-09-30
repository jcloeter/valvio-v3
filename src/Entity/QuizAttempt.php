<?php

namespace App\Entity;

use App\Repository\QuizAttemptRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: QuizAttemptRepository::class)]
class QuizAttempt
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $startedAt = null;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $completedAt = null;

    #[ORM\ManyToOne(inversedBy: 'quizAttempts')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $userId = null;

    #[ORM\OneToMany(mappedBy: 'quizAttemptId', targetEntity: QuizPitchAttempt::class, orphanRemoval: true)]
    private Collection $quizPitchAttempts;

    #[ORM\Column(nullable: true)]
    private ?int $secondsToComplete = null;

    #[ORM\ManyToOne]
    #[ORM\JoinColumn(nullable: false)]
    private ?Quiz $quiz = null;

    public function __construct()
    {
        $this->quizPitchAttempts = new ArrayCollection();
    }

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

    public function getCompletedAt(): ?\DateTimeImmutable
    {
        return $this->completedAt;
    }

    public function setCompletedAt(?\DateTimeImmutable $completedAt): self
    {
        $this->completedAt = $completedAt;

        return $this;
    }

    public function getUser(): ?User
    {
        return $this->userId;
    }

    public function setUser(?User $userId): self
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * @return Collection<int, QuizPitchAttempt>
     */
    public function getQuizPitchAttempts(): Collection
    {
        return $this->quizPitchAttempts;
    }

    public function addQuestionAttempt(QuizPitchAttempt $quizPitchAttempt): self
    {
        if (!$this->quizPitchAttempts->contains($quizPitchAttempt)) {
            $this->quizPitchAttempts->add($quizPitchAttempt);
            $quizPitchAttempt->setQuizAttemptId($this);
        }

        return $this;
    }

    public function removeQuestionAttempt(QuizPitchAttempt $quizPitchAttempt): self
    {
        if ($this->quizPitchAttempts->removeElement($quizPitchAttempt)) {
            // set the owning side to null (unless already changed)
            if ($quizPitchAttempt->getQuizAttemptId() === $this) {
                $quizPitchAttempt->setQuizAttemptId(null);
            }
        }

        return $this;
    }

    public function getSecondsToComplete(): ?int
    {
        return $this->secondsToComplete;
    }

    public function setSecondsToComplete(?int $secondsToComplete): self
    {
        $this->secondsToComplete = $secondsToComplete;

        return $this;
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
}

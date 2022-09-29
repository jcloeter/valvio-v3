<?php

namespace App\Entity;

use App\Repository\QuizRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: QuizRepository::class)]
class Quiz
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(length: 255)]
    private ?string $difficulty = null;

    #[ORM\Column]
    private ?float $level = null;

    #[ORM\Column(length: 255)]
    private ?string $description = null;

    #[ORM\OneToMany(mappedBy: 'quiz', targetEntity: QuizPitch::class, orphanRemoval: true)]
    private Collection $quizPitches;

    #[ORM\ManyToOne(inversedBy: 'quizzes')]
    #[ORM\JoinColumn(nullable: false)]
    #[ORM\JoinColumn(referencedColumnName: 'id')]
    private ?Transposition $transposition = null;

    #[ORM\Column]
    private ?int $length = null;

    public function __construct()
    {
        $this->quizPitches = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getDifficulty(): ?string
    {
        return $this->difficulty;
    }

    public function setDifficulty(string $difficulty): self
    {
        $this->difficulty = $difficulty;

        return $this;
    }

    public function getLevel(): ?float
    {
        return $this->level;
    }

    public function setLevel(float $level): self
    {
        $this->level = $level;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

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
//            $quizPitch->setQuizId($this);
//        }
//
//        return $this;
//    }
//
//    public function removeQuizPitch(QuizPitch $quizPitch): self
//    {
//        if ($this->quizPitches->removeElement($quizPitch)) {
//            // set the owning side to null (unless already changed)
//            if ($quizPitch->getQuizId() === $this) {
//                $quizPitch->setQuizId(null);
//            }
//        }
//
//        return $this;
//    }

public function getTransposition(): ?Transposition
{
    return $this->transposition;
}

public function setTransposition(?Transposition $transposition): self
{
    $this->transposition = $transposition;

    return $this;
}

public function getLength(): ?int
{
    return $this->length;
}

public function setLength(int $length): self
{
    $this->length = $length;

    return $this;
}
}

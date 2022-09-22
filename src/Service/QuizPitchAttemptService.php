<?php

namespace App\Service;

use App\Entity\QuizPitchAttempt;
use App\Repository\QuizAttemptRepository;
use App\Repository\QuizPitchRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Repository\QuizPitchAttemptRepository;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;

class QuizPitchAttemptService
{

    private QuizPitchAttemptRepository $quizPitchAttemptRepository;
    private QuizAttemptRepository $quizAttemptRepository;
    private QuizPitchRepository $quizPitchRepository;

    public function __construct(QuizPitchAttemptRepository $quizPitchAttemptRepository, QuizAttemptRepository $quizAttemptRepository, QuizPitchRepository $quizPitchRepository)
    {
        $this->quizPitchAttemptRepository = $quizPitchAttemptRepository;
        $this->quizAttemptRepository = $quizAttemptRepository;
        $this->quizPitchRepository = $quizPitchRepository;
    }

    public function createQuizPitchAttempt(int $userInput, bool $isCorrect, int $quizPitchId, int $quizAttemptId): QuizPitchAttempt
    {
        $quizPitchAttempt = new QuizPitchAttempt();
        $quizPitchAttempt->setStartedAt(new \DateTimeImmutable("now"));
        $quizPitchAttempt->setCorrect($isCorrect);
        $quizPitchAttempt->setUserInput($userInput);

        $quizAttempt = $this->quizAttemptRepository->find($quizAttemptId);
        $quizPitch = $this->quizPitchRepository->find($quizPitchId);

        if (!$quizAttempt || !$quizPitch) {
            throw new ResourceNotFoundException("Quiz Attempt Id or Quiz Pitch Id are invalid");
        }

        $quizPitchAttempt->setQuizAttemptId($quizAttempt);
        $quizPitchAttempt->setQuizPitch($quizPitch);

        $this->quizPitchAttemptRepository->add($quizPitchAttempt, true);
        return $quizPitchAttempt;
    }
}
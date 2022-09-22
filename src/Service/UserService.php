<?php

namespace App\Service;

use App\Entity\QuizAttempt;
use App\Entity\User;
use App\Repository\QuizAttemptRepository;
use App\Repository\QuizRepository;
use App\Repository\UserRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;

class UserService
{
    private UserRepository $userRepository;
    private QuizAttemptRepository $quizAttemptRepository;
    private ManagerRegistry $doctrine;
    private QuizRepository $quizRepository;

    public function __construct(UserRepository $userRepository, QuizAttemptRepository $quizAttemptRepository, ManagerRegistry $doctrine, QuizRepository $quizRepository)
    {
        $this->userRepository = $userRepository;
        $this->quizAttemptRepository = $quizAttemptRepository;
        $this->doctrine = $doctrine;
        $this->quizRepository = $quizRepository;
    }

    public function createAnonymousUser(): User
    {
        $user = new User();
        $user->setFirstName("anon_first");
        $user->setLastName("anon_last");
        $user->setEmail("anon@email.com");
        $user->setPassword("test123");
        $user->setCreatedAt(new \DateTimeImmutable("now"));
        $user->setIsTemporary(true);

        $this->userRepository->add($user, true);

        return $user;
    }

    public function createQuizAttempt(int $userId, int $quizId): QuizAttempt
    {
        $user = $this->userRepository->find($userId);

        $quizAttempt = new QuizAttempt();
        $quizAttempt->setUserId($user);
        $quizAttempt->setStartedAt(new \DateTimeImmutable("now"));
        $quizAttempt->setCompletedAt(null);
        $quizAttempt->setSecondsToComplete(null);

        $quiz = $this->quizRepository->find($quizId);

        if (!$quiz) {
            throw new ResourceNotFoundException("Quiz id is not valid");
        }

        $quizAttempt->setQuiz($quiz);

        $this->quizAttemptRepository->add($quizAttempt, true);

        return $quizAttempt;
    }

    public function updateQuizAttemptToComplete(int $quizAttemptId, int $secondsToComplete): void
    {
        $quizAttempt = $this->quizAttemptRepository->find($quizAttemptId);
        $entityManager = $this->doctrine->getManager();

        if (!$quizAttempt) {
            throw new ResourceNotFoundException("Could not find Quiz Attempt");
        }

        $quizAttempt->setCompletedAt(new \DateTimeImmutable("now"));
        $quizAttempt->setSecondsToComplete($secondsToComplete);

        $entityManager->persist($quizAttempt);
        $entityManager->flush();
    }

}
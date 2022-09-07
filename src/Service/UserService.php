<?php

namespace App\Service;

use App\Entity\QuizAttempt;
use App\Entity\User;
use App\Repository\QuizAttemptRepository;
use App\Repository\UserRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;

class UserService
{
    private UserRepository $userRepository;
    private QuizAttemptRepository $quizAttemptRepository;
    private ManagerRegistry $doctrine;

    public function __construct(UserRepository $userRepository, QuizAttemptRepository $quizAttemptRepository, ManagerRegistry $doctrine)
    {
        $this->userRepository = $userRepository;
        $this->quizAttemptRepository = $quizAttemptRepository;
        $this->doctrine = $doctrine;
    }

    public function createAnonymousUser(): User
    {
        $user = new User();
        $user->setFirstName("anon_first");
        $user->setLastName("anon_last");
        $user->setEmail("anon@email.com");
        $user->setPassword("test123");
        $user->setCreatedAt(new \DateTimeImmutable("now"));

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

        //TODO: Modify db to add quiz_id to quizAttempt, then add quizId here
        //TODO: Also modify table and entity name from user_id_id

        $this->quizAttemptRepository->add($quizAttempt, true);

        return $quizAttempt;
    }

    public function updateQuizAttemptToComplete(int $quizAttemptId, int $secondsToComplete)
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
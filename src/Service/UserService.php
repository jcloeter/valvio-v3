<?php

namespace App\Service;

use App\Entity\QuizAttempt;
use App\Entity\User;
use App\Repository\QuizAttemptRepository;
use App\Repository\QuizRepository;
use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
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
        $quizAttempt->setUser($user);
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



    public function findAllQuizAttemptsForUser($userId)
    {
        $user = $this->userRepository->find($userId);
        if (!$user)
        {
            throw new ResourceNotFoundException("Must be a valid user id");
        }

        $quizAttemptsArray = $user->getQuizAttempts()->getValues();


        $formattedQuizAttempts = array_map(function ($quizAttempt) {
            $quizPitchAttempts = $quizAttempt->getQuizPitchAttempts()->getValues();

            $formattedQuizPitchAttempts = array_map( function ($quizPitchAttempt) {
                return Array (
                    "isCorrect" => $quizPitchAttempt->isCorrect(),
                    "quizPitchAttemptId" => $quizPitchAttempt->getId(),
                    "userInput" => $quizPitchAttempt->getUserInput(),
                    "pitch" => Array(
                        "pitchId" => $quizPitchAttempt->getQuizPitch()->getPitch()->getId(),
                        "noteLetter" => $quizPitchAttempt->getQuizPitch()->getPitch()->getNoteLetter(),
                        "accidental" => $quizPitchAttempt->getQuizPitch()->getPitch()->getAccidental(),
                        "octave" => $quizPitchAttempt->getQuizPitch()->getPitch()->getOctave(),
                        "position" => $quizPitchAttempt->getQuizPitch()->getPitch()->getPosition(),
                        "midiNumber" => $quizPitchAttempt->getQuizPitch()->getPitch()->getMidiNumber(),
                    ),
                    "transposedAnswerPitch" => Array(
                        "pitchId" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getId(),
                        "noteLetter" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getNoteLetter(),
                        "accidental" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getAccidental(),
                        "octave" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getOctave(),
                        "position" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getPosition(),
                        "midiNumber" => $quizPitchAttempt->getQuizPitch()->getTransposedAnswerPitch()?->getMidiNumber(),
                    )
                );
            },$quizPitchAttempts);

            $score = null;

            if ($quizAttempt->getCompletedAt()) {
                $quizLength = $quizAttempt->getQuiz()->getLength();
                $numberIncorrect = array_reduce($quizPitchAttempts, function ($accumulator, $quizPitchAttempt) {
                    if (!$quizPitchAttempt->isCorrect()) {
                        ++$accumulator;
                    }
                    return $accumulator ;
                });

                $score = 100 - ((100/$quizLength) * $numberIncorrect * .75);
            }

            return Array(
                "id" => $quizAttempt->getId(),
                "startedAt" => $quizAttempt->getStartedAt(),
                "completedAt" => $quizAttempt->getCompletedAt(),
                "secondsToComplete" => $quizAttempt->getSecondsToComplete(),
                "quiz" => Array(
                    "id" => $quizAttempt->getQuiz()->getId(),
                    "transposition" => $quizAttempt->getQuiz()->getTransposition()->getInterval(),
                    "length" => $quizAttempt->getQuiz()->getLength(),
                ),
                "score" => $score,
                "quizPitchAttempts" => $formattedQuizPitchAttempts,
                );
        }, $quizAttemptsArray);

        return $formattedQuizAttempts;

    }

}
<?php

namespace App\Controller;

use App\Service\PitchService;
use App\Service\QuizService;
use App\Service\UserService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class QuizController extends AbstractController
{
    #[Route('/quizzes', methods: ['GET'])]
    public function readQuizzes(QuizService $quizService)
    {
        $quizzes = $quizService->getAllQuizzes();
        return $this->json([
            'quizzes' => $quizzes
        ]);
    }

    #[Route('/quizzes/{quizId}/pitches', methods: ['GET'])]
    //Requires query parameter: /user/5/quizAttempt?quizId=7
    public function readQuizPitches (int $quizId, PitchService $pitchService, QuizService $quizService): JsonResponse
    {
        //Todo: Find out how to send along the quizPitchId

        $pitches = $pitchService->getPitchesByQuizId($quizId);
        $quiz = $quizService->getQuizByQuizId($quizId);

        $transpositionInterval = $quiz->getTransposition()?->getInterval();
        $transpositionDescription = $quiz->getTransposition()?->getName();

        if ($transpositionInterval !== 0) {
            $isTransposition = true;
        } else {
            $isTransposition = false;
        }

        return $this->json([
            'transpositionInterval' => $transpositionInterval,
            'isTransposition' => $isTransposition,
            'transpositionDescription' => $transpositionDescription,
            'quizId' => $quiz->getId(),
            'quizLength' => $quiz->getLength(),
            'pitches' => $pitches,
            'quizLevel' => $quiz->getLevel(),
            'quizName' => $quiz->getName(),
        ]);
    }

}
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
    public function readQuizPitches (int $quizId, PitchService $pitchService): JsonResponse
    {
        $pitches = $pitchService->getPitchesByQuizId($quizId);

        return $this->json([
            'pitches' => $pitches
        ]);
    }

}
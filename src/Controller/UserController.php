<?php

namespace App\Controller;

use App\Service\PitchService;
use App\Service\UserService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Serializer\SerializerInterface;

class UserController extends AbstractController
{
    #[Route('/user', name: 'app_user', methods: ['POST'])]
    public function create(UserService $userService): JSONResponse
    {
        //TODO: logic for anon/temporary vs real user. Add indicator in database too
        $user = $userService->createAnonymousUser();

        return new JsonResponse([
            "firstName" => $user->getFirstName(),
            "lastName" => $user->getLastName(),
            "userId" => $user->getId(),
            "createdAt" => $user->getCreatedAt()
        ]);
    }

    #[Route('/user/{userId}/quizAttempt', methods: ['POST'])]
    //Requires query parameter: /user/5/quizAttempt?quizId=7
    public function createQuizAttempt(int $userId, Request $request, UserService $userService, PitchService $pitchService): JsonResponse
    {
        $quizId = $request->query->get('quizId');
        $quizAttempt = $userService->createQuizAttempt($userId, $quizId);
        $pitches = $pitchService->getPitchesByQuizId($quizId);

        return $this->json([
            'success' => true,
            'pitches' => $pitches
          ]);
    }

    #[Route('/user/{userId}/quizAttempt/{quizAttemptId}', methods: ['PATCH'])]
    //Requires query parameter: /user/5/quizAttempt/quizAttemptId?secondsToComplete=100
    public function updateQuizAttempt(int $quizAttemptId, Request $request, UserService $userService): JsonResponse
    {
        $secondsToComplete = $request->query->get('secondsToComplete');

        $userService->updateQuizAttemptToComplete($quizAttemptId, $secondsToComplete);

        return $this->json([
            'success' => true,
        ]);
    }

    // TODO: Get scores from questionAttempts
    // TODO: Create questionAttempt
}

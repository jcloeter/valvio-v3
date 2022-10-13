<?php

namespace App\Controller;

use App\Service\PitchService;
use App\Service\QuizPitchAttemptService;
use App\Service\UserService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;

class UserController extends AbstractController
{
    #[Route('/user', name: 'app_user', methods: ['POST'])]
    //Body = {
        // firebaseUid
        // displayName
        // email
        // isAnonymous
        //}
    public function create(UserService $userService, Request $request): JSONResponse
    {
        $parameters = json_decode($request->getContent(), true);
        $content = $request->getContent();
        $displayName = $parameters["displayName"];
        $isAnonymous = $parameters["isAnonymous"];
        $firebaseUid = $parameters["firebaseUid"];
        $email = $parameters["email"];

        $user = $userService->createUser($displayName, $isAnonymous, $firebaseUid, $email);

        return new JsonResponse([
            "success" => true,
            "id" => $user->getId(),
            "displayName" => $user->getDisplayName(),
            "email" => $user->getEmail(),
            "isAnonymous" => $user->isIsAnonymous(),
            "createdAt" => $user->getCreatedAt(),
        ]);
    }

    #[Route('/user/{userId}/quizAttempt', methods: ['GET'])]
    public function readQuizAttemptCollectionByUser(string $userId, Request $request, UserService $userService, QuizPitchAttemptService $quizPitchAttemptService): JsonResponse
    {
        $quizAttempts = $userService->findAllQuizAttemptsForUser($userId);

        return $this->json([
             "quizAttempts" => $quizAttempts,
        ]);
    }

    #[Route('/user/{userId}/quizAttempt', methods: ['POST'])]
    //Requires query parameter: /user/5/quizAttempt?quizId=7
    //Pitches will be returned using /quizzes/id/pitches
    public function createQuizAttempt(string $userId, Request $request, UserService $userService, PitchService $pitchService): JsonResponse
    {
        $quizId = $request->query->get('quizId');
        $quizAttempt = $userService->createQuizAttempt($userId, $quizId);

        return $this->json([
            'success' => true,
            'id' => $quizAttempt->getId(),
            'completedAt' => $quizAttempt->getCompletedAt(),
            'secondsToComplete' => $quizAttempt->getSecondsToComplete(),
            'quizId' => $quizAttempt->getQuiz()->getId(),
            'userId' => $quizAttempt->getUser()->getId()
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


    #[Route('/user/{userId}/quizPitchAttempt', methods: ['POST'])]
    //Requires body payload: /user/{userId}/quizPitchAttempt
        // body={
        //      userInput: int,
        //      isCorrect: bool,
        //      quizPitchId: int
        //      quizId: int
        //     quizAttemptId: int
        //}
    public function createQuizPitchAttempts(string $userId, Request $request, QuizPitchAttemptService $quizPitchAttemptService): JsonResponse
    {
        $parameters = json_decode($request->getContent(), true);
        $quizPitchAttempt = $quizPitchAttemptService->createQuizPitchAttemptsFromArray($parameters);

        return $this->json([
            'success' => true,
        ]);
    }
}

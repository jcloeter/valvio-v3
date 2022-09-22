<?php

namespace App\Controller;

use App\Service\PitchService;
use App\Service\QuizPitchAttemptService;
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
            "isTemporary" => $user->isIsTemporary(),
            "createdAt" => $user->getCreatedAt(),
        ]);
    }

    #[Route('/user/{userId}/quizAttempt', methods: ['POST'])]
    //Requires query parameter: /user/5/quizAttempt?quizId=7
    //Pitches will be returned using /quizzes/id/pitches
    public function createQuizAttempt(int $userId, Request $request, UserService $userService, PitchService $pitchService): JsonResponse
    {
        $quizId = $request->query->get('quizId');
        $quizAttempt = $userService->createQuizAttempt($userId, $quizId);
//        $pitches = $pitchService->getPitchesByQuizId($quizId);

        return $this->json([
            'success' => true,
//            'pitches' => $pitches
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
        //      correct: bool,
        //      quizPitchId: int
        //      quizId: int
        //     quizAttemptId: int
        //}
    public function createQuizPitchAttempt(int $userId, Request $request, QuizPitchAttemptService $quizPitchAttemptService): JsonResponse
    {
        //TODO: hold up, how is this attempt being linked the the quizAttempt?
        $parameters = json_decode($request->getContent(), true);
        $userInput = $parameters["userInput"];
        $isCorrect = $parameters["isCorrect"];
        $quizPitchId = $parameters["quizPitchId"];
        $quizAttemptId = $parameters["quizAttemptId"];

        $quizPitchAttempt = $quizPitchAttemptService->createQuizPitchAttempt($userInput, $isCorrect, $quizPitchId, $quizAttemptId);

        return $this->json([
            'success' => true,
        ]);
    }

    #[Route('/user/{userId}/quizAttempt/{quizAttemptId}', methods: ['GET'])]
    public function readQuizAttempt(int $userId,int $quizAttemptId,  Request $request, QuizPitchAttemptService $quizPitchAttemptService): JsonResponse
    {

        $parameters = json_decode($request->getContent(), true);

        //Steps:
        //Find quizAttempt by id
        //Find all quizPitchAttempts associated with that quizAttempt
        //Loop through the quizPitchAttempts and generate a score value.
        //Format quizAttempt

        return $this->json([
            'success' => true,
        ]);
    }





    // TODO: Get scores from quizAttempts
    // GET /user/id/quizAttempts- will return array of quizAttempt objects with added fields for score
    // GET /user/id/quizAttempts/id- will return ONE quizAttempt object with the added field score
}

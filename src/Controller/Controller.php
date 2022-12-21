<?php


namespace App\Controller;


use App\Entity\Quiz;
use App\Entity\QuizPitch;
use App\Formatter\PitchesFormatter;
use App\Repository\QuizPitchRepository;
use App\Repository\QuizRepository;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\Request;


use App\Repository\PitchRepository;
//use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\SerializerInterface;
use const Grpc\STATUS_OK;

class Controller extends AbstractController
{

    #[Route('/')]
    #[Route('/health')]
    public function health(): Response {
        return new Response("healthy");
    }

    #[Route('/log/{name}')]
    public function log(string $name, LoggerInterface $logger): Response {
        // See these in /var/log/ of your project root
        $logger->info("Hello, $name");
        return $this->json([
            'success' => true,
            'name' => "new"
        ]);
    }

    #[Route('/test/quizzes/')]
    public function readQuizzes(PitchRepository $pitchRepository, UserRepository $userRepository, QuizPitchRepository $quizPitchRepository, QuizRepository $quizRepository, SerializerInterface $serializer, LoggerInterface $logger): JsonResponse {

        $quiz = $quizRepository->findAll();

        return $this->json([
            'success' => true,
        ]);
    }


    #[Route('/test/quizzes/{quizId}')]
    public function pitch(int $quizId, PitchRepository $pitchRepository, UserRepository $userRepository, QuizPitchRepository $quizPitchRepository, QuizRepository $quizRepository, SerializerInterface $serializer, LoggerInterface $logger): JsonResponse {

          $quiz = $quizRepository->find($quizId);

          $quizPitches = $quizPitchRepository->findBy(['quiz' => $quizId]);

          $pitches = array_map(function($quizPitch){
              return array($quizPitch->getPitch(), $quizPitch->getTransposedAnswerPitch());
          }, $quizPitches);

        return $this->json([
            'success' => true,
            'quizDescription' => $quiz->getDescription(),
            'data' => $pitches
        ]);
    }


}

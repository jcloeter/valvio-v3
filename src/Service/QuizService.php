<?php

namespace App\Service;

use App\Repository\QuizRepository;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;

class QuizService
{
    private QuizRepository $quizRepository;

    public function __construct(QuizRepository $quizRepository)
    {
        $this->quizRepository = $quizRepository;
    }

    public function getQuizByQuizId(int $quizId)
    {
        $quiz = $this->quizRepository->find($quizId);

        if (!$quiz) {
            return new ResourceNotFoundException("Cannot find quiz");
        }

        return $quiz;
    }


    public function getAllQuizzes()
    {
        $quizzes = $this->quizRepository->findAll();

        return array_map(function ($quiz) {
            return Array(
                "id" => $quiz->getId(),
                "name"=> $quiz->getName(),
                "level" => $quiz->getLevel(),
                "description" => $quiz->getDescription(),
                "length" => $quiz->getLength(),
                "difficulty" => $quiz->getDifficulty(),
                "transposition" => Array(
                    "transpositionName" => $quiz->getTransposition()?->getName(),
                    "transpositionInterval" => $quiz->getTransposition()?->getInterval(),
                    "transpositionId" => $quiz->getTransposition()?->getId(),
                )
            );
        }, $quizzes);
    }
}
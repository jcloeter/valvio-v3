<?php

namespace App\Service;

use App\Repository\QuizRepository;

class QuizService
{
    private QuizRepository $quizRepository;

    public function __construct(QuizRepository $quizRepository)
    {
        $this->quizRepository = $quizRepository;
    }

    public function getAllQuizzes()
    {
        return $this->quizRepository->findAll();
    }
}
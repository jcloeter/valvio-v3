<?php

namespace App\Service;

use App\Repository\QuizPitchRepository;
use App\Repository\QuizRepository;

class PitchService
{
    private QuizPitchRepository $quizPitchRepository;
    private QuizRepository $quizRepository;

    public function __construct(QuizPitchRepository $quizPitchRepository, QuizRepository $quizRepository )
    {
        $this->quizPitchRepository = $quizPitchRepository;
        $this->quizRepository = $quizRepository;
    }


    public function getPitchesByQuizId(int $quizId)
    {
        $quizPitches = $this->quizPitchRepository->findBy(['quiz' => $quizId]);

        $pitches = array_map(function($quizPitch){
            return array($quizPitch->getPitch(), $quizPitch->getTransposedAnswerPitch());
        }, $quizPitches);

        return $pitches;
    }
}
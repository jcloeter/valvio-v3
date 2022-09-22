<?php

namespace App\Repository;

use App\Entity\QuizPitchAttempt;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<QuizPitchAttempt>
 *
 * @method QuizPitchAttempt|null find($id, $lockMode = null, $lockVersion = null)
 * @method QuizPitchAttempt|null findOneBy(array $criteria, array $orderBy = null)
 * @method QuizPitchAttempt[]    findAll()
 * @method QuizPitchAttempt[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class QuizPitchAttemptRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, QuizPitchAttempt::class);
    }

    public function add(QuizPitchAttempt $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(QuizPitchAttempt $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

//    /**
//     * @return QuestionAttempt[] Returns an array of QuestionAttempt objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('q')
//            ->andWhere('q.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('q.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?QuestionAttempt
//    {
//        return $this->createQueryBuilder('q')
//            ->andWhere('q.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}

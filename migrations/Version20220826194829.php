<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220826194829 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP SEQUENCE pitch_id_seq CASCADE');
        $this->addSql('ALTER TABLE pitch ALTER id TYPE VARCHAR(255)');
        $this->addSql('ALTER TABLE pitch ALTER id DROP DEFAULT');
        $this->addSql('ALTER TABLE quiz_pitch ALTER pitch_id_id TYPE VARCHAR(255)');
        $this->addSql('ALTER TABLE quiz_pitch ALTER pitch_id_id DROP DEFAULT');
        $this->addSql('ALTER TABLE quiz_pitch ALTER transposed_answer_pitch_id_id TYPE VARCHAR(255)');
        $this->addSql('ALTER TABLE quiz_pitch ALTER transposed_answer_pitch_id_id DROP DEFAULT');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('CREATE SEQUENCE pitch_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('ALTER TABLE quiz_pitch ALTER pitch_id_id TYPE INT');
        $this->addSql('ALTER TABLE quiz_pitch ALTER pitch_id_id DROP DEFAULT');
        $this->addSql('ALTER TABLE quiz_pitch ALTER transposed_answer_pitch_id_id TYPE INT');
        $this->addSql('ALTER TABLE quiz_pitch ALTER transposed_answer_pitch_id_id DROP DEFAULT');
        $this->addSql('ALTER TABLE pitch ALTER id TYPE INT');
        $this->addSql('ALTER TABLE pitch ALTER id DROP DEFAULT');
    }
}

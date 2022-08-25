<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220825203704 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP SEQUENCE question_attempt_id_seq CASCADE');
        $this->addSql('CREATE SEQUENCE quiz_pitch_attempt_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE quiz_pitch_attempt (id INT NOT NULL, quiz_attempt_id_id INT NOT NULL, started_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, ended_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, user_input VARCHAR(255) DEFAULT NULL, correct BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_B0D43F42F53413B5 ON quiz_pitch_attempt (quiz_attempt_id_id)');
        $this->addSql('COMMENT ON COLUMN quiz_pitch_attempt.started_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN quiz_pitch_attempt.ended_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE quiz_pitch_attempt ADD CONSTRAINT FK_B0D43F42F53413B5 FOREIGN KEY (quiz_attempt_id_id) REFERENCES quiz_attempt (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('DROP TABLE question_attempt');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE quiz_pitch_attempt_id_seq CASCADE');
        $this->addSql('CREATE SEQUENCE question_attempt_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE question_attempt (id INT NOT NULL, quiz_attempt_id_id INT NOT NULL, started_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, ended_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, user_input VARCHAR(255) DEFAULT NULL, correct BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX idx_1630d77bf53413b5 ON question_attempt (quiz_attempt_id_id)');
        $this->addSql('COMMENT ON COLUMN question_attempt.started_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN question_attempt.ended_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE question_attempt ADD CONSTRAINT fk_1630d77bf53413b5 FOREIGN KEY (quiz_attempt_id_id) REFERENCES quiz_attempt (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('DROP TABLE quiz_pitch_attempt');
    }
}

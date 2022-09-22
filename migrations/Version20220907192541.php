<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220907192541 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE quiz_attempt DROP CONSTRAINT FK_AB6AFC69D86650F');
        $this->addSql('DROP INDEX IDX_AB6AFC69D86650F');
        $this->addSql('ALTER TABLE quiz_attempt RENAME COLUMN user_id TO user_id_id');
        $this->addSql('ALTER TABLE quiz_attempt ADD CONSTRAINT FK_AB6AFC69D86650F FOREIGN KEY (user_id_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_AB6AFC69D86650F ON quiz_attempt (user_id_id)');
        $this->addSql('ALTER TABLE quiz_pitch_attempt DROP CONSTRAINT FK_B0D43F42F53413B5');
        $this->addSql('DROP INDEX IDX_B0D43F42F53413B5');
        $this->addSql('ALTER TABLE quiz_pitch_attempt ADD ended_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL');
        $this->addSql('ALTER TABLE quiz_pitch_attempt RENAME COLUMN quiz_attempt_id TO quiz_attempt_id_id');
        $this->addSql('COMMENT ON COLUMN quiz_pitch_attempt.ended_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE quiz_pitch_attempt ADD CONSTRAINT FK_B0D43F42F53413B5 FOREIGN KEY (quiz_attempt_id_id) REFERENCES quiz_attempt (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_B0D43F42F53413B5 ON quiz_pitch_attempt (quiz_attempt_id_id)');
        $this->addSql('ALTER TABLE "user" ADD is_temporary BOOLEAN NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE "user" DROP is_temporary');
        $this->addSql('ALTER TABLE quiz_pitch_attempt DROP CONSTRAINT fk_b0d43f42f53413b5');
        $this->addSql('DROP INDEX idx_b0d43f42f53413b5');
        $this->addSql('ALTER TABLE quiz_pitch_attempt DROP ended_at');
        $this->addSql('ALTER TABLE quiz_pitch_attempt RENAME COLUMN quiz_attempt_id_id TO quiz_attempt_id');
        $this->addSql('ALTER TABLE quiz_pitch_attempt ADD CONSTRAINT fk_b0d43f42f53413b5 FOREIGN KEY (quiz_attempt_id) REFERENCES quiz_attempt (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX idx_b0d43f42f53413b5 ON quiz_pitch_attempt (quiz_attempt_id)');
        $this->addSql('ALTER TABLE quiz_attempt DROP CONSTRAINT fk_ab6afc69d86650f');
        $this->addSql('DROP INDEX idx_ab6afc69d86650f');
        $this->addSql('ALTER TABLE quiz_attempt RENAME COLUMN user_id_id TO user_id');
        $this->addSql('ALTER TABLE quiz_attempt ADD CONSTRAINT fk_ab6afc69d86650f FOREIGN KEY (user_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX idx_ab6afc69d86650f ON quiz_attempt (user_id)');
    }
}

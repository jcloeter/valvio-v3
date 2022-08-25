<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220825204711 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE quiz_pitch_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE quiz_pitch (id INT NOT NULL, quiz_id_id INT NOT NULL, pitch_id_id INT NOT NULL, transposed_answer_pitch_id_id INT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_DBECC7598337E7D7 ON quiz_pitch (quiz_id_id)');
        $this->addSql('CREATE INDEX IDX_DBECC759B79B28CE ON quiz_pitch (pitch_id_id)');
        $this->addSql('CREATE INDEX IDX_DBECC759893863CE ON quiz_pitch (transposed_answer_pitch_id_id)');
        $this->addSql('ALTER TABLE quiz_pitch ADD CONSTRAINT FK_DBECC7598337E7D7 FOREIGN KEY (quiz_id_id) REFERENCES quiz (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE quiz_pitch ADD CONSTRAINT FK_DBECC759B79B28CE FOREIGN KEY (pitch_id_id) REFERENCES pitch (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE quiz_pitch ADD CONSTRAINT FK_DBECC759893863CE FOREIGN KEY (transposed_answer_pitch_id_id) REFERENCES pitch (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE quiz_pitch_id_seq CASCADE');
        $this->addSql('DROP TABLE quiz_pitch');
    }
}

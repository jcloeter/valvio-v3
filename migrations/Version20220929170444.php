<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220929170444 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
//        $this->addSql('CREATE SEQUENCE transposition_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
//        $this->addSql('CREATE TABLE transposition (id INT NOT NULL, name VARCHAR(255) NOT NULL, interval INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('ALTER TABLE quiz ADD transposition_id INT NOT NULL');
        $this->addSql('ALTER TABLE quiz ADD length INT NOT NULL');
        $this->addSql('ALTER TABLE quiz ADD CONSTRAINT FK_A412FA924926ABE9 FOREIGN KEY (transposition_id) REFERENCES transposition (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_A412FA924926ABE9 ON quiz (transposition_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE quiz DROP CONSTRAINT FK_A412FA924926ABE9');
        $this->addSql('DROP SEQUENCE transposition_id_seq CASCADE');
        $this->addSql('DROP TABLE transposition');
        $this->addSql('DROP INDEX IDX_A412FA924926ABE9');
        $this->addSql('ALTER TABLE quiz DROP transposition_id');
        $this->addSql('ALTER TABLE quiz DROP length');
    }
}

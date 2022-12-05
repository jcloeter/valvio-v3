<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20221013133737 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
//        $this->addSql('ALTER TABLE quiz ADD CONSTRAINT FK_A412FA924926ABE94926ABE9 FOREIGN KEY (transposition_id) REFERENCES transposition (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
//        $this->addSql('DROP INDEX transposition_id_uindex');
//        $this->addSql('DROP INDEX "primary"');
//        $this->addSql('ALTER TABLE transposition ALTER id SET NOT NULL');
//        $this->addSql('ALTER TABLE transposition ADD PRIMARY KEY (id)');
        $this->addSql('ALTER TABLE "user" ADD display_name VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE "user" ADD is_anonymous BOOLEAN DEFAULT NULL');
        $this->addSql('ALTER TABLE "user" ADD firebase_uid VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP INDEX transposition_pkey');
        $this->addSql('ALTER TABLE transposition ALTER id DROP NOT NULL');
        $this->addSql('CREATE UNIQUE INDEX transposition_id_uindex ON transposition (id)');
        $this->addSql('ALTER TABLE transposition ADD PRIMARY KEY (interval)');
        $this->addSql('ALTER TABLE "user" DROP display_name');
        $this->addSql('ALTER TABLE "user" DROP is_anonymous');
        $this->addSql('ALTER TABLE "user" DROP firebase_uid');
        $this->addSql('ALTER TABLE quiz DROP CONSTRAINT FK_A412FA924926ABE94926ABE9');
    }
}

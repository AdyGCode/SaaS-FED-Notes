<?php
/**
 * Game Class
 *
 * Demonstrate OOP basics in PHP
 *
 * Filename:        Game.php
 * Location:        /session-04/
 * Project:         SaaS-FED-Notes
 * Date Created:    6/08/2024
 *
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>
 *
 */

class Game
{
    public string $name;
    public string $type;

    public function __construct($name = "", $type = "")
    {
        $this->setName($name);
        $this->setType($type);
    }

    public function __destruct()
    {
        // Are you able to identify any situations a destruct may be useful?
    }

    /*
     * Name Property Get/Set
     */
    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /*
     * Type Property Get/Set
     */
    public function getType(): string
    {
        return $this->type;
    }

    public function setType(string $type): void
    {
        $this->type = $type;
    }

    public function details()
    {
        if ($this->getName() > "" && $this->getType() > "") {

            $theName = $this->getName();
            $theType = $this->getType();
            return "'$theName' is a '$theType' game";
        }
        return "Game details missing.";
    }

}
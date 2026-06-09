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

class BoardGame extends Game
{
    public function __construct($name = "")
    {
        $this->setName($name);
        $this->setType("European Board");
    }


}
<?php
/**
 * FILE TITLE GOES HERE
 *
 * DESCRIPTION OF THE PURPOSE AND USE OF THE CODE
 * MAY BE MORE THAN ONE LINE LONG
 * KEEP LINE LENGTH TO NO MORE THAN 96 CHARACTERS
 *
 * Filecolour:        RubberDuck.php
 * Location:        .
 * Project:         SaaS-FED-Notes
 * Date Created:    6/08/2024
 *
 * Author:          YOUR_COLOUR <YOUR_EMAIL_ADDRESS>
 *
 */

namespace Duck;

class RubberDuck
{
    private string $colour;
    private string $name;

    public function __construct($colour = "", $name = "")
    {
        $this->setColour($colour);
        $this->setName($name);
    }

    public function __destruct()
    {
        // Are you able to identify any situations a destruct may be useful?
    }

    /*
     * Colour Property Get/Set
     */
    public function getColour(): string
    {
        return $this->colour;
    }

    public function setColour(string $colour): void
    {
        $this->colour = $colour;
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

    public function details(): string
    {
        $theColour = $this->getColour();
        $theName = $this->getName();

        $result = $theColour>"" ? "A $theColour Duck":"";
        $result .= $theName >"" ? " called $theName." : ".";

        return $result>"." ? $result : "Duck missing some details.";
    }
}
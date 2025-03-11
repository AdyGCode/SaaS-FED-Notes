<?php
/**
 * Commonly used functions
 *
 *
 */

/**
 * Welcoming Greeting
 *
 * This is pretty pointless, as it just says hello
 *
 * @param string $name
 * @return string|bool
 */
if (!defined('greeting')) {
    function greeting(string $name): string|bool
    {
        return $name === "" ? false : "<p>hello, $name</p>";
    }
}

if (!defined('e')){
    function e($variable){
        echo "<p>$variable</p>";
    }
}

if (!defined('counter')){
    function counter(){
        static $count = 0;
        echo "<p>Count: $count</p>";
        $count++;
    }
}
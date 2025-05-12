<?php

function load_model($class_name)
{
    /*
     * As `use Models\MODEL_NAME;` identifies the class, the
     * class_name gets expanded to be the Folder plus the class' name
     */
    $path_to_file =  $class_name . '.php';

    if (file_exists($path_to_file)) {
        require_once $path_to_file;
    }
}


spl_autoload_register('load_model');